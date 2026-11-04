 

 

local UserInputService = game:GetService("UserInputService");
local GuiService = game:GetService("GuiService");
local u1 = {
    isPC = function() -- Line: 8, Name: isPC
        -- upvalues: GuiService (copy), UserInputService (copy)
        if GuiService:IsTenFootInterface() or UserInputService.VREnabled then
            return false;
        end;

        return UserInputService.MouseEnabled and UserInputService.KeyboardEnabled;
    end
};

function u1.clone(p2) -- Line: 16
    -- upvalues: u1 (copy)
    local Detail = p2:FindFirstChild("Detail");

    if Detail and not u1.isPC() then
        Detail:Destroy();
    end;

    return p2:Clone();
end;

return u1;