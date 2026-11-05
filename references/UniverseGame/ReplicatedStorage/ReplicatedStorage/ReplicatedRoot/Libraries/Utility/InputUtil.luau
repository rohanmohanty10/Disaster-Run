  

 

local u1 = {};
local UserInputService = game:GetService("UserInputService");
u1.Order = { "MouseButton1", "MouseButton2", "MouseButton3", "F", "C", "X", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Zero", "Q", "W", "E", "R", "T", "Y", "U", "I", "O", "A", "S", "D", "G", "H", "J", "K", "L", "Z", "V", "B", "N", "M", "P" };
u1.Mapping = {
    One = "1",
    Two = "2",
    Three = "3",
    Four = "4",
    Five = "5",
    Six = "6",
    Seven = "7",
    Eight = "8",
    Nine = "9",
    Zero = "0",
    MouseButton1 = "M1",
    MouseButton2 = "M2",
    MouseButton3 = "M3"
};
u1.UpperMap = {};

for _, v in pairs(Enum.KeyCode:GetEnumItems()) do
    u1.UpperMap[v.Name:upper()] = v;
end;

for _, v in pairs(Enum.UserInputType:GetEnumItems()) do
    u1.UpperMap[v.Name:upper()] = v;
end;

for i, v in pairs(u1.Mapping) do
    u1[v] = i;
end;

local CustomKeybindMap = require(game.ReplicatedStorage.ReplicatedModules.CustomKeybindMap);

function u1.FormatKeybind(p2) -- Line: 84
    local Input = p2.Input;
    local IsHeld = p2.IsHeld;
    local v3 = typeof(Input) ~= "EnumItem" and (Input or "Unknown") or Input.Name;

    return `{tostring(v3)}` .. (IsHeld and "+" or "");
end;

function u1.FormatIndicatorString(p4) -- Line: 90
    -- upvalues: u1 (copy)
    local Input = p4.Input;

    return `{u1.Mapping[Input.Name] or Input.Name}{p4.IsHeld and "+" or ""}`;
end;

function u1.Convert(p5) -- Line: 96
    local v6 = {
        Value = nil,
        Delta = p5.Delta or Vector3.new(0, 0, 0),
        Position = p5.Position or Vector3.new(0, 0, 0),
        KeyCode = p5.KeyCode or Enum.KeyCode.Unknown,
        UserInputType = p5.UserInputType or Enum.UserInputType.None,
        UserInputState = p5.UserInputState or Enum.UserInputState.None
    };

    if v6.UserInputType == Enum.UserInputType.Keyboard then
        v6.Value = v6.KeyCode;

        return v6;
    end;

    v6.Value = v6.UserInputType;

    return v6;
end;

function u1.FromLegacyString(p7, p8) -- Line: 115
    -- upvalues: UserInputService (copy), CustomKeybindMap (copy)
    local v9 = p8 or UserInputService:GetLastInputType();
    local v10 = {
        Value = nil,
        PrefixString = "",
        ModifierString = "",
        Held = false,
        UserInputState = Enum.UserInputState.None,
        UserInputType = Enum.UserInputType.None,
        KeyCode = Enum.KeyCode.Unknown,
        RawString = p7,
        InputString = p7
    };

    if string.sub(p7, 1, 6) == "START-" then
        v10.UserInputState = Enum.UserInputState.Begin;
        v10.PrefixString = "START-";
    elseif string.sub(p7, 1, 7) == "CHANGE-" then
        v10.UserInputState = Enum.UserInputState.Change;
        v10.PrefixString = "CHANGE-";
    elseif string.sub(p7, 1, 4) == "END-" then
        v10.UserInputState = Enum.UserInputState.End;
        v10.PrefixString = "END-";
    end;

    if v10.PrefixString ~= "" then
        v10.InputString = string.sub(v10.InputString, #v10.PrefixString + 1);
    end;

    if string.sub(v10.InputString, #v10.InputString) == "+" then
        v10.ModifierString = "+";
        v10.InputString = string.sub(v10.InputString, 1, #v10.InputString - 1);
        v10.Held = true;
    end;

    local v11 = CustomKeybindMap.GetKeybindValue(v10.InputString);
    local v12 = v11 and CustomKeybindMap.KeybindsEnums[v11];

    if v12 then
        if v12.EnumType == Enum.UserInputType then
            v10.UserInputType = v12;
        elseif v12.EnumType == Enum.KeyCode then
            v10.UserInputType = v9 == Enum.UserInputType.Gamepad1 and Enum.UserInputType.Gamepad1 or Enum.UserInputType.Keyboard;
            v10.KeyCode = v12;
        end;

        v10.Value = v12;
    end;

    return v10;
end;

function u1.IsInputActive(p13) -- Line: 170
    -- upvalues: UserInputService (copy)
    if p13 == nil then
        return false;
    end;

    if p13.UserInputType == Enum.UserInputType.Keyboard then
        return UserInputService:IsKeyDown(p13.KeyCode);
    end;

    if p13.UserInputType == Enum.UserInputType.MouseButton1 or (p13.UserInputType == Enum.UserInputType.MouseButton2 or p13.UserInputType == Enum.UserInputType.MouseButton3) then
        return UserInputService:IsMouseButtonPressed(p13.UserInputType);
    end;

    if p13.UserInputType == Enum.UserInputType.Gamepad1 then
        return UserInputService:IsGamepadButtonDown(p13.UserInputType, p13.KeyCode);
    end;

    return false;
end;

return u1;