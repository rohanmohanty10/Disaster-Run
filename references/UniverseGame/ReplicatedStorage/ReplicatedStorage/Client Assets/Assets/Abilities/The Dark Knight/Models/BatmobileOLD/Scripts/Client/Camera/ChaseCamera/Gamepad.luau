  

 

local UserInputService = game:GetService("UserInputService");
local UserGameSettings = UserSettings():GetService("UserGameSettings");
local disconnectAndClear = require(script.Parent.Parent.Parent.disconnectAndClear);
local u1 = Vector2.new(1, 0.77) * 4.1887902047863905;
local Thumbstick2 = Enum.KeyCode.Thumbstick2;
local Gamepad1 = Enum.UserInputType.Gamepad1;
local u2 = false;
local u3 = {};

local function thumbstickCurve(p4) -- Line: 17
    local v5 = (math.abs(p4) - 0.1) / 0.9 * 2;
    local v6 = (math.exp(v5) - 1) / 6.38905609893065;

    return math.sign(p4) * math.clamp(v6, 0, 1);
end;

local function onLastInputTypeChanged(p7) -- Line: 28
    -- upvalues: Gamepad1 (ref)
    if string.find(p7.Name, "Gamepad") then
        Gamepad1 = p7;
    end;
end;

return {
    getInput = function(p8, p9) -- Line: 36, Name: getInput
        -- upvalues: UserGameSettings (copy), UserInputService (copy), Gamepad1 (ref), Thumbstick2 (copy), u1 (copy)
        local v10 = Vector2.new(1, UserGameSettings:GetCameraYInvertValue());
        local zero = Vector2.zero;

        for _, v in UserInputService:GetGamepadState(Gamepad1) do
            if v.KeyCode == Thumbstick2 then
                local new = Vector2.new;
                local X = v.Position.X;
                local v11 = (math.abs(X) - 0.1) / 0.9 * 2;
                local v12 = (math.exp(v11) - 1) / 6.38905609893065;
                local v13 = math.sign(X) * math.clamp(v12, 0, 1);
                local Y = v.Position.Y;
                local v14 = (math.abs(Y) - 0.1) / 0.9 * 2;
                local v15 = (math.exp(v14) - 1) / 6.38905609893065;
                zero = new(v13, -(math.sign(Y) * math.clamp(v15, 0, 1)));
            end;
        end;

        return zero * u1 * v10 * p9;
    end,

    enable = function(p16) -- Line: 51, Name: enable
        -- upvalues: u2 (ref), u3 (copy), UserInputService (copy), onLastInputTypeChanged (copy)
        if u2 then
            return;
        end;

        u2 = true;
        table.insert(u3, UserInputService.LastInputTypeChanged:Connect(onLastInputTypeChanged));
    end,

    disable = function(p17) -- Line: 60, Name: disable
        -- upvalues: u2 (ref), disconnectAndClear (copy), u3 (copy)
        if not u2 then
            return;
        end;

        u2 = false;
        disconnectAndClear(u3);
    end
};