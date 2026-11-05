  

 

local ContextActionService = game:GetService("ContextActionService");
local Players = game:GetService("Players");
local UserInputService = game:GetService("UserInputService");
local Constants = require(script.Parent.Parent.Parent.Constants);
local cycleCameraModeHandler = require(script.Parent.cycleCameraModeHandler);
local exitHandlerAsync = require(script.Parent.exitHandlerAsync);
local nitroHandler = require(script.Parent.nitroHandler);
local handBrakeHandler = require(script.Parent.handBrakeHandler);
local getStringForKeyCode = require(script.Parent.getStringForKeyCode);
local PlayerGui = Players.LocalPlayer.PlayerGui;
local ControlsGui = script.Parent.ControlsGui;
local Inputs = script.Parent.Parent.Parent.Parent.Inputs;
local W = Enum.KeyCode.W;
local S = Enum.KeyCode.S;
local D = Enum.KeyCode.D;
local A = Enum.KeyCode.A;
local Up = Enum.KeyCode.Up;
local Down = Enum.KeyCode.Down;
local Right = Enum.KeyCode.Right;
local Left = Enum.KeyCode.Left;
local u1 = false;
local u2 = nil;

return {
    getThrottleAndSteering = function(p3) -- Line: 32, Name: getThrottleAndSteering
        -- upvalues: UserInputService (copy), W (copy), Up (copy), S (copy), Down (copy), D (copy), Right (copy), A (copy), Left (copy)
        local v4 = 0;
        local v5 = 0;

        if UserInputService:IsKeyDown(W) or UserInputService:IsKeyDown(Up) then
            v4 = v4 + 1;
        end;

        if UserInputService:IsKeyDown(S) or UserInputService:IsKeyDown(Down) then
            v4 = v4 - 1;
        end;

        if UserInputService:IsKeyDown(D) or UserInputService:IsKeyDown(Right) then
            v5 = v5 + 1;
        end;

        if UserInputService:IsKeyDown(A) or UserInputService:IsKeyDown(Left) then
            v5 = v5 - 1;
        end;

        return v4, v5;
    end,

    enable = function(p6) -- Line: 52, Name: enable
        -- upvalues: u1 (ref), Inputs (copy), Constants (copy), u2 (ref), ControlsGui (copy), PlayerGui (copy), getStringForKeyCode (copy), ContextActionService (copy), cycleCameraModeHandler (copy), exitHandlerAsync (copy), nitroHandler (copy), handBrakeHandler (copy)
        if u1 then
            return;
        end;

        u1 = true;
        local v7 = Inputs:GetAttribute(Constants.KEYBOARD_CYCLE_CAMERA_MODE_KEY_CODE_ATTRIBUTE);
        local v8 = Inputs:GetAttribute(Constants.KEYBOARD_EXIT_KEY_CODE_ATTRIBUTE);
        local v9 = Inputs:GetAttribute(Constants.KEYBOARD_NITRO_KEY_CODE_ATTRIBUTE);
        local v10 = Inputs:GetAttribute(Constants.KEYBOARD_HAND_BRAKE_KEY_CODE_ATTRIBUTE);
        u2 = ControlsGui:Clone();
        u2.Parent = PlayerGui;
        local v11 = getStringForKeyCode(v7);
        local v12 = getStringForKeyCode(v8);
        local v13 = getStringForKeyCode(v9);
        local v14 = getStringForKeyCode(v10);
        u2.Controls.CameraFrame.KeyboardLabel.TextLabel.Text = string.upper(v11);
        u2.Controls.ExitFrame.KeyboardLabel.TextLabel.Text = string.upper(v12);
        u2.Controls.NitroFrame.KeyboardLabel.TextLabel.Text = string.upper(v13);
        u2.Controls.HandBrakeFrame.KeyboardLabel.TextLabel.Text = string.upper(v14);
        u2.Controls.CameraFrame.KeyboardLabel.Visible = true;
        u2.Controls.ExitFrame.KeyboardLabel.Visible = true;
        u2.Controls.NitroFrame.KeyboardLabel.Visible = true;
        u2.Controls.HandBrakeFrame.KeyboardLabel.Visible = true;
        ContextActionService:BindAction(Constants.KEYBOARD_CYCLE_CAMERA_MODE_BIND_NAME, cycleCameraModeHandler, false, v7);
        ContextActionService:BindAction(Constants.KEYBOARD_EXIT_BIND_NAME, exitHandlerAsync, false, v8);
        ContextActionService:BindAction(Constants.KEYBOARD_NITRO_BIND_NAME, nitroHandler, false, v9);
        ContextActionService:BindAction(Constants.KEYBOARD_HAND_BRAKE_BIND_NAME, handBrakeHandler, false, v10);
    end,

    disable = function(p15) -- Line: 93, Name: disable
        -- upvalues: u1 (ref), ContextActionService (copy), Constants (copy), u2 (ref)
        if not u1 then
            return;
        end;

        u1 = false;
        ContextActionService:UnbindAction(Constants.KEYBOARD_CYCLE_CAMERA_MODE_BIND_NAME);
        ContextActionService:UnbindAction(Constants.KEYBOARD_EXIT_BIND_NAME);
        ContextActionService:UnbindAction(Constants.KEYBOARD_NITRO_BIND_NAME);
        ContextActionService:UnbindAction(Constants.KEYBOARD_HAND_BRAKE_BIND_NAME);

        if u2 then
            u2:Destroy();
            u2 = nil;
        end;
    end
};