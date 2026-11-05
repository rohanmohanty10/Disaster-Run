  

 

local ContextActionService = game:GetService("ContextActionService");
local Players = game:GetService("Players");
local UserInputService = game:GetService("UserInputService");
local Constants = require(script.Parent.Parent.Parent.Constants);
local cycleCameraModeHandler = require(script.Parent.cycleCameraModeHandler);
local exitHandlerAsync = require(script.Parent.exitHandlerAsync);
local nitroHandler = require(script.Parent.nitroHandler);
local handBrakeHandler = require(script.Parent.handBrakeHandler);
local PlayerGui = Players.LocalPlayer.PlayerGui;
local ControlsGui = script.Parent.ControlsGui;
local Inputs = script.Parent.Parent.Parent.Parent.Inputs;
local Thumbstick1 = Enum.KeyCode.Thumbstick1;
local ButtonR2 = Enum.KeyCode.ButtonR2;
local ButtonL2 = Enum.KeyCode.ButtonL2;
local Gamepad1 = Enum.UserInputType.Gamepad1;
local u1 = false;
local u2 = nil;
local u3 = nil;

local function onLastInputTypeChanged(p4) -- Line: 27
    -- upvalues: Gamepad1 (ref)
    if string.find(p4.Name, "Gamepad") then
        Gamepad1 = p4;
    end;
end;

return {
    getThrottleAndSteering = function(p5) -- Line: 35, Name: getThrottleAndSteering
        -- upvalues: UserInputService (copy), Gamepad1 (ref), Thumbstick1 (copy), ButtonR2 (copy), ButtonL2 (copy)
        local v6 = 0;
        local v7 = 0;

        for _, v in UserInputService:GetGamepadState(Gamepad1) do
            if v.KeyCode == Thumbstick1 then
                local X = v.Position.X;

                if math.abs(X) > 0.1 then
                    v7 = (math.abs(X) - 0.1) / 0.9 * math.sign(X);
                end;
            elseif v.KeyCode == ButtonR2 then
                v6 = v6 + v.Position.Z;
            elseif v.KeyCode == ButtonL2 then
                v6 = v6 - v.Position.Z;
            end;
        end;

        return v6, v7;
    end,

    enable = function(p8) -- Line: 57, Name: enable
        -- upvalues: u1 (ref), Inputs (copy), Constants (copy), u3 (ref), ControlsGui (copy), PlayerGui (copy), UserInputService (copy), ContextActionService (copy), cycleCameraModeHandler (copy), exitHandlerAsync (copy), nitroHandler (copy), handBrakeHandler (copy), u2 (ref), onLastInputTypeChanged (copy), Gamepad1 (ref)
        if u1 then
            return;
        end;

        u1 = true;
        local v9 = Inputs:GetAttribute(Constants.GAMEPAD_CYCLE_CAMERA_MODE_KEY_CODE_ATTRIBUTE);
        local v10 = Inputs:GetAttribute(Constants.GAMEPAD_EXIT_KEY_CODE_ATTRIBUTE);
        local v11 = Inputs:GetAttribute(Constants.GAMEPAD_NITRO_KEY_CODE_ATTRIBUTE);
        local v12 = Inputs:GetAttribute(Constants.GAMEPAD_HAND_BRAKE_KEY_CODE_ATTRIBUTE);
        u3 = ControlsGui:Clone();
        u3.Parent = PlayerGui;
        local v13 = UserInputService:GetImageForKeyCode(v9);
        local v14 = UserInputService:GetImageForKeyCode(v10);
        local v15 = UserInputService:GetImageForKeyCode(v11);
        local v16 = UserInputService:GetImageForKeyCode(v12);
        u3.Controls.CameraFrame.GamepadLabel.Image = v13;
        u3.Controls.ExitFrame.GamepadLabel.Image = v14;
        u3.Controls.NitroFrame.GamepadLabel.Image = v15;
        u3.Controls.HandBrakeFrame.GamepadLabel.Image = v16;
        u3.Controls.CameraFrame.GamepadLabel.Visible = true;
        u3.Controls.ExitFrame.GamepadLabel.Visible = true;
        u3.Controls.NitroFrame.GamepadLabel.Visible = true;
        u3.Controls.HandBrakeFrame.GamepadLabel.Visible = true;
        ContextActionService:BindAction(Constants.GAMEPAD_CYCLE_CAMERA_MODE_BIND_NAME, cycleCameraModeHandler, false, v9);
        ContextActionService:BindAction(Constants.GAMEPAD_EXIT_BIND_NAME, exitHandlerAsync, false, v10);
        ContextActionService:BindAction(Constants.GAMEPAD_NITRO_BIND_NAME, nitroHandler, false, v11);
        ContextActionService:BindAction(Constants.GAMEPAD_HAND_BRAKE_BIND_NAME, handBrakeHandler, false, v12);
        u2 = UserInputService.LastInputTypeChanged:Connect(onLastInputTypeChanged);
        local v17 = UserInputService:GetLastInputType();

        if string.find(v17.Name, "Gamepad") then
            Gamepad1 = v17;
        end;
    end,

    disable = function(p18) -- Line: 106, Name: disable
        -- upvalues: u1 (ref), ContextActionService (copy), Constants (copy), u2 (ref), u3 (ref)
        if not u1 then
            return;
        end;

        u1 = false;
        ContextActionService:UnbindAction(Constants.GAMEPAD_CYCLE_CAMERA_MODE_BIND_NAME);
        ContextActionService:UnbindAction(Constants.GAMEPAD_EXIT_BIND_NAME);
        ContextActionService:UnbindAction(Constants.GAMEPAD_NITRO_BIND_NAME);
        ContextActionService:UnbindAction(Constants.GAMEPAD_HAND_BRAKE_BIND_NAME);

        if u2 then
            u2:Disconnect();
            u2 = nil;
        end;

        if u3 then
            u3:Destroy();
            u3 = nil;
        end;
    end
};