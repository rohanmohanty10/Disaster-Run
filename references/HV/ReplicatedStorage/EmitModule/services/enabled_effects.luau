 

 

local RunService = game:GetService("RunService");
local CollectionService = game:GetService("CollectionService");
require("../types");
local u1 = require("../mod/utility");
local u2 = require("../emitters");

return {
    init = function(p3, u4, u5) -- Line: 10, Name: init
        -- upvalues: u1 (copy), u2 (copy), RunService (copy), CollectionService (copy)
        local u6 = {};

        local function removeEnabledEffect(p7: userdata) -- Line: 13
            -- upvalues: u6 (copy), u1 (ref)
            local v8 = u6[p7];

            if v8 then
                u1.cleanupScope(v8);
            end;

            u6[p7] = nil;
        end;

        local function addEnabledEffect(u9: userdata) -- Line: 23
            -- upvalues: u2 (ref), u6 (copy), addEnabledEffect (copy), u1 (ref), RunService (ref), u5 (copy), u4 (copy)
            local u10 = nil;

            for _, v in u2.enabled_registry do
                if v.check(u9) then
                    u10 = v;
                    break;
                end;
            end;

            if not u10 then
                return;
            end;

            local u11 = {};
            local v12 = {};
            table.insert(v12, u11);
            u6[u9] = v12;
            table.insert(v12, u9.AncestryChanged:Connect(function() -- Line: 47
                -- upvalues: u9 (copy), u6 (ref), addEnabledEffect (ref), u1 (ref)
                if u9:IsDescendantOf(workspace) or u9.Parent and u9.Parent:HasTag("AllowEmitting") then
                    if not u6[u9] then
                        addEnabledEffect(u9);
                    end;
                else
                    local v13 = u9;
                    local v14 = u6[v13];

                    if v14 then
                        u1.cleanupScope(v14);
                    end;

                    u6[v13] = nil;
                end;
            end));

            if not u9:IsDescendantOf(workspace) then
                local v15;

                if u9.Parent then
                    v15 = not u9.Parent:HasTag("AllowEmitting");
                else
                    v15 = false;
                end;

                if v15 then
                    return;
                end;
            end;

            local function onEnabled() -- Line: 62
                -- upvalues: u1 (ref), u9 (copy), u11 (copy), RunService (ref), u5 (ref), u10 (ref), u4 (ref)
                if not u1.getAttribute(u9, "Enabled", true) then
                    u1.cleanupScope(u11);

                    return;
                end;

                local u16 = 0;
                table.insert(u11, RunService.RenderStepped:Connect(function() -- Line: 70
                    -- upvalues: u1 (ref), u9 (ref), u16 (ref), u5 (ref), u10 (ref), u4 (ref)
                    local Attribute = u1.getAttribute(u9, "Rate", 5);
                    local v17 = u9:GetAttribute("SpeedOverride") or 1;

                    if v17 == 0 then
                        return;
                    end;

                    if os.clock() - u16 <= 1 / Attribute / v17 then
                        return;
                    end;

                    u16 = os.clock();
                    local v18 = {
                        depth = 0,
                        effects = u5
                    };
                    u10.emit(u9, v18, u4);
                    u1.cleanupScope(v18);
                end));
            end;

            local AttributeChangedSignal = u9:GetAttributeChangedSignal("Enabled");
            table.insert(v12, AttributeChangedSignal:Connect(onEnabled));
            onEnabled();
        end;

        for _, v in CollectionService:GetTagged(u1.ENABLED_VFX_TAG) do
            addEnabledEffect(v);
        end;

        CollectionService:GetInstanceAddedSignal(u1.ENABLED_VFX_TAG):Connect(addEnabledEffect);
        CollectionService:GetInstanceRemovedSignal(u1.ENABLED_VFX_TAG):Connect(removeEnabledEffect);
        table.insert(p3, function() -- Line: 110
            -- upvalues: u6 (copy), u1 (ref)
            for _, v in u6 do
                u1.cleanupScope(v);
            end;
        end);
    end
};