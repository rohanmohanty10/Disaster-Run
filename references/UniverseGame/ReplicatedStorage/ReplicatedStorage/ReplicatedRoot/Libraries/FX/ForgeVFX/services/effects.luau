  

 

require("../types");
local u1 = require("../mod/logger");
local u2 = require("../mod/utility");
local u3 = require("../emitters");
local u4 = require("../pkg/Promise");
local u5 = table.concat({
    "Beam",
    "Trail",
    "Sound",
    "ParticleEmitter",
    `.{u2.BEZIER_TAG}`,
    `.{u2.LIGHTNING_TAG}`,
    "Model",
    "RayValue",
    "BasePart[$Enabled=true]",
    "#Rings > Part",
    "#Lines > Part",
    "#Debris > Part"
}, ",");
local u6 = {};
local u7 = nil;

local function u8() -- Line: 39
end;

local u9 = {
    Finished = u4.resolve(),
    Clear = u8
};

function u6.init(p10) -- Line: 46
    -- upvalues: u7 (ref)
    u7 = p10;
end;

function u6.deinit() -- Line: 50
    -- upvalues: u7 (ref)
    u7 = nil;
end;

local function emitWithContext(p11, u12, ...) -- Line: 54
    -- upvalues: u7 (ref), u1 (copy), u9 (copy), u5 (copy), u2 (copy), u6 (copy), u3 (copy), u4 (copy), u8 (copy)
    if not (u7 and u7.setup) then
        u1.error("effects service not initialized");

        return u9;
    end;

    local u13 = {};
    local u14 = {};

    local function queryAndEmitDescendants(p15, p16) -- Line: 68
        -- upvalues: u5 (ref), u2 (ref), u6 (ref), u3 (ref), u13 (copy), u14 (copy), u7 (ref), u12 (copy)
        local v17 = p15:QueryDescendants(u5);
        local v18 = #v17;

        if v18 == 0 then
            return {};
        end;

        local v19 = table.create(v18);
        local v20 = {};
        local v21 = {};
        v20[p15] = false;
        v21[p15] = p16;

        for _, v in v17 do
            local Parent = v.Parent;
            local v22 = {};

            while v21[Parent] == nil do
                table.insert(v22, Parent);
                Parent = Parent.Parent;
            end;

            local v23 = v20[Parent];
            local v24 = v21[Parent];

            for i = #v22, 1, -1 do
                local v25 = v22[i];
                v24 = v24 + 1;
                v21[v25] = v24;
                v23 = v23 or (u2.shouldSkipNested(v25) or v25:HasTag(u2.EMIT_EXCLUDE_TAG));
                v20[v25] = v23;
            end;

            if not v23 then
                table.insert(v19, u2.createEmitPromise(u6, v, v21[v.Parent], function(p26) -- Line: 112
                    -- upvalues: u3 (ref), v (copy), u13 (ref), u14 (ref), u7 (ref)
                    u3.dispatch(v, p26, u13, u14, u7.caches.shared_part, 1);
                end, u12));
            end;
        end;

        return v19;
    end;

    local v27 = {};

    for _, v in { ... } do
        if v:IsA("BasePart") and (v:GetAttribute("Enabled") and not u2.findFirstClassWithTag(v, "Attachment", u2.SHOCKWAVE_TAG)) then
            if not u2.lock(v) then
                local v28 = v:FindFirstAncestorOfClass("Model");

                if not v28 or u2.isSpinModelStatic(v28) then
                    local u29 = coroutine.running();
                    local u30 = {
                        depth = p11,
                        effects = u6,
                        _context = u12
                    };

                    if u3.screen(v, u30) then
                        local v31 = queryAndEmitDescendants(v, p11 + 1);

                        if #v31 > 0 then
                            local v32 = u4.all(v31);
                            table.insert(v27, v32:finally(function() -- Line: 154
                                -- upvalues: u2 (ref), v (copy), u29 (copy), u30 (copy)
                                u2.unlock(v, u29);
                                u2.cleanupScope(u30);
                            end));
                        else
                            u2.unlock(v, u29);
                            u2.cleanupScope(u30);
                        end;
                    end;
                end;
            end;
        else
            table.insert(v27, u2.createEmitPromise(u6, v, p11, function(p33) -- Line: 168
                -- upvalues: u3 (ref), v (copy), u13 (copy), u14 (copy), u7 (ref)
                u3.dispatch(v, p33, u13, u14, u7.caches.shared_part, 1);
            end, u12));

            if not u2.shouldSkipNested(v) then
                for _, v2 in queryAndEmitDescendants(v, p11 + 1) do
                    table.insert(v27, v2);
                end;
            end;
        end;
    end;

    local u34 = {
        Finished = u4.all(v27)
    };
    u34.Clear = u12 and function() -- Line: 187
        -- upvalues: u12 (copy), u34 (copy)
        for _, v in u12._promises do
            v:cancel();
        end;

        u34.Finished:cancel();
    end or u8;

    return u34;
end;

function u6.emit(p35, ...) -- Line: 198
    -- upvalues: emitWithContext (copy)
    return emitWithContext(p35, {
        _promises = {}
    }, ...);
end;

function u6.prepareEmitFolder(p36, p37, p38) -- Line: 203
    local v39 = p36:FindFirstChild(p37);

    if not (v39 and v39:IsA("Folder")) then
        return nil;
    end;

    v39.Parent = nil;
    table.insert(p38, v39);

    return v39;
end;

function u6.prepareEmitOnFinish(p40, p41) -- Line: 215
    -- upvalues: u6 (copy)
    return u6.prepareEmitFolder(p40, "EmitOnFinish", p41);
end;

function u6.emitNested(p42, p43, p44) -- Line: 219
    -- upvalues: u7 (ref), u9 (copy), emitWithContext (copy)
    if not (u7 and u7.setup) then
        return u9;
    end;

    local v45 = p42:GetChildren();

    if #v45 == 0 then
        return u9;
    end;

    local v46;

    if p44 then
        v46 = p44._context;
    else
        v46 = nil;
    end;

    return emitWithContext(p43, v46, table.unpack(v45));
end;

function u6.emitFromFolder(p47, p48, p49, p50) -- Line: 234
    -- upvalues: u9 (copy), emitWithContext (copy)
    if not p47 then
        return u9;
    end;

    local v51 = p47:GetChildren();

    if #v51 == 0 then
        return u9;
    end;

    for _, v in v51 do
        v.Parent = p48;
    end;

    local v52;

    if p50 then
        v52 = p50._context;
    else
        v52 = nil;
    end;

    return emitWithContext(p49, v52, table.unpack(v51));
end;

function u6.emitOnFinish(p53, p54, p55, p56) -- Line: 258
    -- upvalues: u6 (copy)
    return u6.emitFromFolder(p53, p54, p55, p56);
end;

return u6;