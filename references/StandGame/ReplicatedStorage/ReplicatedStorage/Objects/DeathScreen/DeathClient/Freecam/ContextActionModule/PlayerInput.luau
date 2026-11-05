 

 

local l__UserInputService__1 = game:GetService("UserInputService");
local u1 = {
    CurrentInput = nil,
    InputTypes = {
        KEYBOARD_MOUSE = "keyboard/mouse",
        TOUCH = "touch",
        GAMEPAD = "gamepad"
    },
    InputTypeChanged = Instance.new("BindableEvent")
};
local function u3(p2) --[[ Line: 17 ]]
    -- upvalues: u1 (copy)
    if p2 == Enum.UserInputType.MouseButton1 or (p2 == Enum.UserInputType.MouseButton2 or (p2 == Enum.UserInputType.MouseButton3 or (p2 == Enum.UserInputType.MouseWheel or (p2 == Enum.UserInputType.MouseMovement or p2 == Enum.UserInputType.Keyboard)))) then
        return u1.InputTypes.KEYBOARD_MOUSE;
    elseif p2 == Enum.UserInputType.Touch or (p2 == Enum.UserInputType.Accelerometer or p2 == Enum.UserInputType.Gyro) then
        return u1.InputTypes.TOUCH;
    elseif p2 == Enum.UserInputType.Gamepad1 or (p2 == Enum.UserInputType.Gamepad2 or (p2 == Enum.UserInputType.Gamepad3 or (p2 == Enum.UserInputType.Gamepad4 or (p2 == Enum.UserInputType.Gamepad5 or (p2 == Enum.UserInputType.Gamepad6 or (p2 == Enum.UserInputType.Gamepad7 or p2 == Enum.UserInputType.Gamepad8)))))) then
        return u1.InputTypes.GAMEPAD;
    else
        return nil;
    end;
end;
local function v6(p4) --[[ Line: 48 ]]
    -- upvalues: u3 (copy), u1 (copy)
    local v5 = u3(p4);
    if v5 and v5 ~= u1.CurrentInput then
        u1.CurrentInput = v5;
        u1.InputTypeChanged:Fire(v5);
    end;
end;
local v7 = u3((l__UserInputService__1:GetLastInputType()));
if v7 and v7 ~= u1.CurrentInput then
    u1.CurrentInput = v7;
    u1.InputTypeChanged:Fire(v7);
end;
l__UserInputService__1.LastInputTypeChanged:Connect(v6);
return u1;