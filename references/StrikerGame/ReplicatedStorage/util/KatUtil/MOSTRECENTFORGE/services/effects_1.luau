 
 

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
        local v14 = #v13;

        if v14 == 0 then
            return {};
        end;

        local table_create_ret = table.create(v14);
        local v15 = {};
        local v16 = {};
        v15[p11] = false;
        v16[p11] = p12;

        for _, v in v13 do
            local Parent = v.Parent;
            local u17 = v;
            local v18 = {};

            while v16[Parent] == nil do
                table.insert(v18, Parent);
                Parent = Parent.Parent;
            end;

            local v19 = v15[Parent];
            local v20 = v16[Parent];

            for i = #v18, 1, -1 do
                local v21 = v18[i];
                v20 = v20 + 1;
                v16[v21] = v20;
                v19 = v19 or (u2.shouldSkipNested(v21) or v21:HasTag(u2.EMIT_EXCLUDE_TAG));
                v15[v21] = v19;
                local _ = i;
            end;

            if not v19 then
                table.insert(table_create_ret, u2.createEmitPromise(u5, u17, v16[u17.Parent], function(p22) -- Line: 106
                    -- upvalues: u3 (ref), u17 (copy), u9 (ref), u10 (ref), u6 (ref)
                    u3.dispatch(u17, p22, u9, u10, u6.caches.shared_part, 1);
                end));
            end;
        end;

        return table_create_ret;
    end;

    local v23 = {};

    for _, v in { ... } do
        if v:IsA("BasePart") and (v:GetAttribute("Enabled") and not u2.findFirstClassWithTag(v, "Attachment", u2.SHOCKWAVE_TAG)) then
            if not u2.lock(v) then
                local v24 = v:FindFirstAncestorOfClass("Model");

                if not v24 or u2.isSpinModelStatic(v24) then
                    local coroutine_running_ret = coroutine.running();
                    local u25 = {
                        depth = p8,
                        effects = u5
                    };

                    if u3.screen(v, u25) then
                        local v26 = queryAndEmitDescendants(v, p8 + 1);

                        if #v26 > 0 then
                            local v27 = u4.all(v26);
                            table.insert(v23, v27:finally(function() -- Line: 147
                                -- upvalues: u2 (ref), v (copy), coroutine_running_ret (copy), u25 (copy)
                                u2.unlock(v, coroutine_running_ret);
                                u2.cleanupScope(u25);
                            end));
                        else
                            u2.unlock(v, coroutine_running_ret);
                            u2.cleanupScope(u25);
                        end;
                    end;
                end;
            end;
        else
            table.insert(v23, u2.createEmitPromise(u5, v, p8, function(p28) -- Line: 161
                -- upvalues: u3 (ref), v (copy), u9 (copy), u10 (copy), u6 (ref)
                u3.dispatch(v, p28, u9, u10, u6.caches.shared_part, 1);
            end));

            if not u2.shouldSkipNested(v) then
                for _, v2 in queryAndEmitDescendants(v, p8 + 1) do
                    table.insert(v23, v2);
                end;
            end;
        end;
    end;

    return {
        Finished = u4.all(v23)
    };
end;

function u5.prepareEmitOnFinish(p29: userdata, p30: any) -- Line: 186
    local EmitOnFinish = p29:FindFirstChild("EmitOnFinish");

    if not (EmitOnFinish and EmitOnFinish:IsA("Folder")) then
        return nil;
    end;

    EmitOnFinish.Parent = nil;
    table.insert(p30, EmitOnFinish);

    return EmitOnFinish;
end;

function u5.emitNested(p31: userdata, p32: number) -- Line: 201
    -- upvalues: u6 (ref), u4 (copy), u5 (copy)
    if not (u6 and u6.setup) then
        return {
            Finished = u4.resolve()
        };
    end;

    local Children = p31:GetChildren();

    return #Children == 0 and {
        Finished = u4.resolve()
    } or u5.emit(p32, table.unpack(Children));
end;

function u5.emitOnFinish(p33: userdata?, p34: userdata, p35: number) -- Line: 219
    -- upvalues: u4 (copy), u5 (copy)
    if not p33 then
        return {
            Finished = u4.resolve()
        };
    end;

    local Children = p33:GetChildren();

    if #Children == 0 then
        return {
            Finished = u4.resolve()
        };
    end;

    for _, v in Children do
        v.Parent = p34;
    end;

    return u5.emit(p35, table.unpack(Children));
end;

return u5;