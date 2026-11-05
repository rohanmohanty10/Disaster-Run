  

 

local UserInputService = game:GetService("UserInputService");
local u1 = {
    [Enum.KeyCode.Space] = "Spacebar",
    [Enum.KeyCode.LeftShift] = "LShift",
    [Enum.KeyCode.RightShift] = "RShift",
    [Enum.KeyCode.LeftControl] = "LCtrl",
    [Enum.KeyCode.RightControl] = "RCtrl",
    [Enum.KeyCode.LeftAlt] = "LAlt",
    [Enum.KeyCode.RightAlt] = "RAlt"
};

return function(p2) -- Line: 13, Name: getStringForKeyCode
    -- upvalues: u1 (copy), UserInputService (copy)
    if u1[p2] then
        return u1[p2];
    end;

    local v3 = UserInputService:GetStringForKeyCode(p2);

    if v3 == "" then
        return p2.Name;
    end;

    return v3;
end;