  

 

local Signal = require(script.Parent.Parent.Signal);
local EnumList = require(script.Parent.Parent.EnumList);
local UserInputService = game:GetService("UserInputService");
local Touch = Enum.UserInputType.Touch;
local Keyboard = Enum.UserInputType.Keyboard;
local u1 = {
    Changed = Signal.new(),
    InputType = EnumList.new("InputType", { "MouseKeyboard", "Touch", "Gamepad" })
};
u1.Current = u1.InputType.MouseKeyboard;

function u1.Observe(p2) -- Line: 111
    -- upvalues: u1 (copy)
    task.spawn(p2, u1.Current);

    return u1.Changed:Connect(p2);
end;

local function SetPreferred(p3) -- Line: 117
    -- upvalues: u1 (copy)
    if p3 ~= u1.Current then
        u1.Current = p3;
        u1.Changed:Fire(p3);
    end;
end;

local function DeterminePreferred(p4) -- Line: 125
    -- upvalues: Touch (copy), u1 (copy), Keyboard (copy)
    if p4 == Touch then
        local Touch2 = u1.InputType.Touch;

        if Touch2 ~= u1.Current then
            u1.Current = Touch2;
            u1.Changed:Fire(Touch2);
        end;
    elseif p4 == Keyboard or p4.Name:sub(1, 5) == "Mouse" then
        local MouseKeyboard = u1.InputType.MouseKeyboard;

        if MouseKeyboard ~= u1.Current then
            u1.Current = MouseKeyboard;
            u1.Changed:Fire(MouseKeyboard);
        end;
    elseif p4.Name:sub(1, 7) == "Gamepad" then
        local Gamepad = u1.InputType.Gamepad;

        if Gamepad ~= u1.Current then
            u1.Current = Gamepad;
            u1.Changed:Fire(Gamepad);
        end;
    end;
end;

DeterminePreferred(UserInputService:GetLastInputType());
UserInputService.LastInputTypeChanged:Connect(DeterminePreferred);

return u1;