 
 

local RunService = game:GetService("RunService");
local CollectionService = game:GetService("CollectionService");
local u1 = require("../mod/attributes");
require("../types");
local u2 = require("../mod/utility");
local u3 = require("../emitters");

return {
    init = function(p4, u5, u6) -- Line: 11, Name: init
        -- upvalues: u2 (copy), u3 (copy), u1 (copy), RunService (copy), CollectionService (copy)
        local u7 = {};

        local function removeEnabledEffect(p8: userdata) -- Line: 14
            -- upvalues: u7 (copy), u2 (ref)
            local v9 = u7[p8];

            if v9 then
                u2.cleanupScope(v9);
            end;

            u7[p8] = nil;
        end;

        local function addEnabledEffect(u10: userdata) -- Line: 24
            -- upvalues: u3 (ref), u7 (copy), addEnabledEffect (copy), u2 (ref), u1 (ref), RunService (ref), u6 (copy), u5 (copy)
            local u11 = nil;

            for _, v in u3.enabled_registry do
                if v.check(u10) then
                    u11 = v;
                    break;
                end;
            end;

            if not u11 then
                return;
            end;

            local u12 = {};
            local v13 = {};
            table.insert(v13, u12);
            u7[u10] = v13;
            table.insert(v13, u10.AncestryChanged:Connect(function() -- Line: 48
                -- upvalues: u10 (copy), u7 (ref), addEnabledEffect (ref), u2 (ref)
                if u10:IsDescendantOf(workspace) or u10.Parent and u10.Parent:HasTag("AllowEmitting") then
                    if not u7[u10] then
                        addEnabledEffect(u10);
                    end;
                else
                    local v14 = u10;
                    local v15 = u7[v14];

                    if v15 then
                        u2.cleanupScope(v15);
                    end;

                    u7[v14] = nil;
                end;
            end));

            if not u10:IsDescendantOf(workspace) then
                local v16;

                if u10.Parent then
                    v16 = not u10.Parent:HasTag("AllowEmitting");
                else
                    v16 = false;
                end;

                if v16 then
                    return;
                end;
            end;

            local function onEnabled(p17: boolean?) -- Line: 63
                -- upvalues: u1 (ref), u10 (copy), u12 (copy), RunService (ref), u6 (ref), u11 (ref), u5 (ref), u2 (ref)
                if p17 == nil then
                    p17 = u1.get(u10, "Enabled", true);
                end;

                if not p17 then
                    u2.cleanupScope(u12);

                    return;
                end;

                local u18 = 0;
                table.insert(u12, RunService.RenderStepped:Connect(function() -- Line: 73
                    -- upvalues: u1 (ref), u10 (ref), u18 (ref), u6 (ref), u11 (ref), u5 (ref), u2 (ref)
                    local v19 = u1.get(u10, "Rate", 5);
                    local State = u1.getState(u10, "SpeedOverride", 1);

                    if State == 0 then
                        return;
                    end;

                    if os.clock() - u18 <= 1 / v19 / State then
                        return;
                    end;

                    u18 = os.clock();
                    local v20 = {
                        depth = 0,
                        effects = u6
                    };
                    u11.emit(u10, v20, u5);
                    u2.cleanupScope(v20);
                end));
            end;

            table.insert(v13, u1.hook(u10, "Enabled", onEnabled));
            onEnabled();
        end;

        for _, v in CollectionService:GetTagged(u2.ENABLED_VFX_TAG) do
            addEnabledEffect(v);
        end;

        CollectionService:GetInstanceAddedSignal(u2.ENABLED_VFX_TAG):Connect(addEnabledEffect);
        CollectionService:GetInstanceRemovedSignal(u2.ENABLED_VFX_TAG):Connect(removeEnabledEffect);
        table.insert(p4, function() -- Line: 113
            -- upvalues: u7 (copy), u2 (ref)
            for _, v in u7 do
                u2.cleanupScope(v);
            end;
        end);
    end
};