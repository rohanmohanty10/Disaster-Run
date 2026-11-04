 

 

require("../types");
local u1 = require("../mod/logger");
local u2 = require("../mod/utility");
local u3 = require("../emitters");
local u4 = require("../pkg/Promise");
local table_concat_ret = table.concat({
    "Beam",
    "Trail",
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
local u5 = {};
local u6 = nil;

function u5.init(p7) -- Line: 38
    -- upvalues: u6 (ref)
    u6 = p7;
end;

function u5.deinit() -- Line: 42
    -- upvalues: u6 (ref)
    u6 = nil;
end;

function u5.emit(p8: number, ...) -- Line: 48
    -- upvalues: u6 (ref), u1 (copy), u4 (copy), table_concat_ret (copy), u2 (copy), u5 (copy), u3 (copy)
    if not (u6 and u6.setup) then
        u1.error("effects service not initialized");

        return {
            Finished = u4.resolve()
        };
    end;

    local u9 = {};
    local u10 = {};

    local function queryAndEmitDescendants(p11: userdata, p12: number) -- Line: 62
        -- upvalues: table_concat_ret (ref), u2 (ref), u5 (ref), u3 (ref), u9 (copy), u10 (copy), u6 (ref)
        local v13 = p11:QueryDescendants(table_concat_ret);

        if #v13 == 0 then
            return {};
        end;

        local v14 = {};

        for _, v in v13 do
            if u2.shouldSkipNested(v) then
                v14[v] = true;
            end;
        end;

        local v15 = {};

        for _, v in v13 do
            local Parent = v.Parent;
            local u16 = v;
            local v17 = false;

            while Parent and Parent ~= p11 do
                if v14[Parent] then
                    v17 = true;
                    break;
                end;

                Parent = Parent.Parent;
            end;

            if not v17 then
                local Parent2 = u16.Parent;
                local v18 = p12;

                while Parent2 and Parent2 ~= p11 do
                    Parent2 = Parent2.Parent;
                    p12 = p12 + 1;
                end;

                table.insert(v15, u2.createEmitPromise(u5, u16, p12, function(p19) -- Line: 104
                    -- upvalues: u3 (ref), u16 (copy), u9 (ref), u10 (ref), u6 (ref)
                    u3.dispatch(u16, p19, u9, u10, u6.caches.shared_part, 1);
                end));
                p12 = v18;
            end;
        end;

        return v15;
    end;

    local v20 = {};

    for _, v in { ... } do
        if v:IsA("BasePart") and (v:GetAttribute("Enabled") and not u2.findFirstClassWithTag(v, "Attachment", u2.SHOCKWAVE_TAG)) then
            if not u2.lock(v) then
                local v21 = v:FindFirstAncestorOfClass("Model");

                if not v21 or u2.isSpinModelStatic(v21) then
                    local coroutine_running_ret = coroutine.running();
                    local u22 = {
                        depth = p8,
                        effects = u5
                    };

                    if u3.screen(v, u22) then
                        local v23 = queryAndEmitDescendants(v, p8 + 1);

                        if #v23 > 0 then
                            local v24 = u4.all(v23);
                            table.insert(v20, v24:finally(function() -- Line: 145
                                -- upvalues: u2 (ref), v (copy), coroutine_running_ret (copy), u22 (copy)
                                u2.unlock(v, coroutine_running_ret);
                                u2.cleanupScope(u22);
                            end));
                        else
                            u2.unlock(v, coroutine_running_ret);
                            u2.cleanupScope(u22);
                        end;
                    end;
                end;
            end;
        else
            table.insert(v20, u2.createEmitPromise(u5, v, p8, function(p25) -- Line: 159
                -- upvalues: u3 (ref), v (copy), u9 (copy), u10 (copy), u6 (ref)
                u3.dispatch(v, p25, u9, u10, u6.caches.shared_part, 1);
            end));

            if not u2.shouldSkipNested(v) then
                for _, v2 in queryAndEmitDescendants(v, p8 + 1) do
                    table.insert(v20, v2);
                end;
            end;
        end;
    end;

    return {
        Finished = u4.all(v20)
    };
end;

function u5.prepareEmitOnFinish(p26: userdata, p27: any) -- Line: 184
    local EmitOnFinish = p26:FindFirstChild("EmitOnFinish");

    if not (EmitOnFinish and EmitOnFinish:IsA("Folder")) then
        return nil;
    end;

    EmitOnFinish.Parent = nil;
    table.insert(p27, EmitOnFinish);

    return EmitOnFinish;
end;

function u5.emitNested(p28: userdata, p29: number) -- Line: 199
    -- upvalues: u6 (ref), u4 (copy), u5 (copy)
    if not (u6 and u6.setup) then
        return {
            Finished = u4.resolve()
        };
    end;

    local Children = p28:GetChildren();

    return #Children == 0 and {
        Finished = u4.resolve()
    } or u5.emit(p29, table.unpack(Children));
end;

function u5.emitOnFinish(p30: userdata?, p31: userdata, p32: number) -- Line: 217
    -- upvalues: u4 (copy), u5 (copy)
    if not p30 then
        return {
            Finished = u4.resolve()
        };
    end;

    local Children = p30:GetChildren();

    if #Children == 0 then
        return {
            Finished = u4.resolve()
        };
    end;

    for _, v in Children do
        v.Parent = p31;
    end;

    return u5.emit(p32, table.unpack(Children));
end;

return u5;