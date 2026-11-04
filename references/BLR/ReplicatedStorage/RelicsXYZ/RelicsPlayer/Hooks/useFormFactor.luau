  

local Shared = script:FindFirstAncestor("RelicsXYZ").Shared;
local React = require(Shared.React);
local script_Parent = script.Parent;
local useSignal = require(script_Parent.useSignal);
local useProperty = require(script_Parent.useProperty);
local GuiService = game:GetService("GuiService");

return function() -- Line: 16, Name: useFormFactor
    -- upvalues: React (copy), useProperty (copy), GuiService (copy), useSignal (copy)
    local u1, u2 = React.useState("Desktop");
    local u4 = useProperty(workspace, function(p3) -- Line: 19
        return p3.CurrentCamera;
    end);
    useSignal(u4:GetPropertyChangedSignal("ViewportSize"), function() -- Line: 25, Name: update
        -- upvalues: GuiService (ref), u1 (copy), u2 (copy), u4 (copy)
        if GuiService:IsTenFootInterface() then
            if u1 ~= "TenFoot" then
                u2("TenFoot");
            end;

            return;
        end;

        local v5 = u4.ViewportSize.Y >= 600 and "Desktop" or "Phone";

        if u1 ~= v5 then
            u2(v5);
        end;
    end);

    if GuiService:IsTenFootInterface() then
        if u1 ~= "TenFoot" then
            u2("TenFoot");

            return u1;
        end;
    else
        local v6 = u4.ViewportSize.Y >= 600 and "Desktop" or "Phone";

        if u1 ~= v6 then
            u2(v6);
        end;
    end;

    return u1;
end;