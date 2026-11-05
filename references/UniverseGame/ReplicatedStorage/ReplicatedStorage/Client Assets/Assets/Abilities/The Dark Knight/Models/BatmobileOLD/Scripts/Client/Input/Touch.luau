  

 

local Players = game:GetService("Players");
local UserInputService = game:GetService("UserInputService");
local Constants = require(script.Parent.Parent.Parent.Constants);
local disconnectAndClear = require(script.Parent.Parent.disconnectAndClear);
local cycleCameraModeHandler = require(script.Parent.cycleCameraModeHandler);
local exitHandlerAsync = require(script.Parent.exitHandlerAsync);
local handBrakeHandler = require(script.Parent.handBrakeHandler);
local nitroHandler = require(script.Parent.nitroHandler);
local PlayerGui = Players.LocalPlayer.PlayerGui;
local TouchGui = script.TouchGui;
local u1 = false;
local u2 = nil;
local u3 = {};
local u4 = 0;
local u5 = 0;
local u6 = nil;
local u7 = nil;
local u8 = nil;
local u9 = nil;
local u10 = nil;

local function onInputEnded(p11) -- Line: 28
    -- upvalues: Constants (copy), u6 (ref), u7 (ref), u4 (ref), u8 (ref), u5 (ref), u9 (ref), nitroHandler (copy), u10 (ref), handBrakeHandler (copy)
    p11:RemoveTag(Constants.TOUCH_INPUT_OBJECT_IGNORE_TAG);

    if p11 == u6 then
        u6 = nil;

        return;
    end;

    if p11 == u7 then
        u7 = nil;
        u4 = 0;

        return;
    end;

    if p11 == u8 then
        u8 = nil;
        u5 = 0;

        return;
    end;

    if p11 ~= u9 then
        if p11 == u10 then
            u10 = nil;
            handBrakeHandler(Constants.TOUCH_HAND_BRAKE_BIND_NAME, Enum.UserInputState.End);
        end;

        return;
    end;

    u9 = nil;
    nitroHandler(Constants.TOUCH_NITRO_BIND_NAME, Enum.UserInputState.End);
end;

local function onGasPedalInputBegan(p12) -- Line: 54
    -- upvalues: Constants (copy), u7 (ref), u4 (ref)
    if p12:HasTag(Constants.TOUCH_INPUT_OBJECT_IGNORE_TAG) then
        return;
    end;

    p12:AddTag(Constants.TOUCH_INPUT_OBJECT_IGNORE_TAG);
    u7 = p12;
    u4 = 1;
end;

local function onBrakePedalInputBegan(p13) -- Line: 63
    -- upvalues: Constants (copy), u8 (ref), u5 (ref)
    if p13:HasTag(Constants.TOUCH_INPUT_OBJECT_IGNORE_TAG) then
        return;
    end;

    p13:AddTag(Constants.TOUCH_INPUT_OBJECT_IGNORE_TAG);
    u8 = p13;
    u5 = 1;
end;

local function onWheelInputBegan(p14) -- Line: 72
    -- upvalues: Constants (copy), u6 (ref)
    if p14:HasTag(Constants.TOUCH_INPUT_OBJECT_IGNORE_TAG) then
        return;
    end;

    p14:AddTag(Constants.TOUCH_INPUT_OBJECT_IGNORE_TAG);
    u6 = p14;
end;

local function onNitroButtonInputBegan(p15) -- Line: 82
    -- upvalues: Constants (copy), u9 (ref), nitroHandler (copy)
    if p15:HasTag(Constants.TOUCH_INPUT_OBJECT_IGNORE_TAG) then
        return;
    end;

    p15:AddTag(Constants.TOUCH_INPUT_OBJECT_IGNORE_TAG);
    u9 = p15;
    nitroHandler(Constants.TOUCH_NITRO_BIND_NAME, Enum.UserInputState.Begin);
end;

local function onHandBrakeInputBegan(p16) -- Line: 92
    -- upvalues: Constants (copy), u10 (ref), handBrakeHandler (copy)
    if p16:HasTag(Constants.TOUCH_INPUT_OBJECT_IGNORE_TAG) then
        return;
    end;

    p16:AddTag(Constants.TOUCH_INPUT_OBJECT_IGNORE_TAG);
    u10 = p16;
    handBrakeHandler(Constants.TOUCH_HAND_BRAKE_BIND_NAME, Enum.UserInputState.Begin);
end;

local function onExitButtonInputBegan(p17) -- Line: 102
    -- upvalues: Constants (copy), exitHandlerAsync (copy)
    if p17:HasTag(Constants.TOUCH_INPUT_OBJECT_IGNORE_TAG) then
        return;
    end;

    exitHandlerAsync(Constants.TOUCH_EXIT_BIND_NAME, Enum.UserInputState.Begin);
end;

local function onCycleCameraModeButtonInputBegan(p18) -- Line: 110
    -- upvalues: Constants (copy), cycleCameraModeHandler (copy)
    if p18:HasTag(Constants.TOUCH_INPUT_OBJECT_IGNORE_TAG) then
        return;
    end;

    cycleCameraModeHandler(Constants.TOUCH_CYCLE_CAMERA_MODE_BIND_NAME, Enum.UserInputState.Begin);
end;

local function updateScale() -- Line: 118
    -- upvalues: u2 (ref), Constants (copy)
    local v19 = math.min(u2.AbsoluteSize.X, u2.AbsoluteSize.Y) < Constants.UI_SMALL_SCREEN_THRESHOLD;
    u2.UIScale.Scale = not v19 and 1 or Constants.UI_SMALL_SCREEN_SCALE;
end;

return {
    getThrottleAndSteering = function(p20) -- Line: 127, Name: getThrottleAndSteering
        -- upvalues: u4 (ref), u5 (ref), u6 (ref), u2 (ref)
        local v21 = not u6 and 0 or math.clamp((u6.Position.X - (u2.Wheel.AbsolutePosition.X + u2.Wheel.AbsoluteSize.X / 2)) / u2.Wheel.AbsoluteSize.X * 2, -1, 1);
        u2.Wheel.WheelLabel.Rotation = v21 * 90;

        return u4 - u5, v21;
    end,

    enable = function(p22) -- Line: 146, Name: enable
        -- upvalues: u1 (ref), u2 (ref), TouchGui (copy), PlayerGui (copy), u3 (copy), onWheelInputBegan (copy), onGasPedalInputBegan (copy), onBrakePedalInputBegan (copy), onHandBrakeInputBegan (copy), onNitroButtonInputBegan (copy), onExitButtonInputBegan (copy), onCycleCameraModeButtonInputBegan (copy), UserInputService (copy), onInputEnded (copy), updateScale (copy), Constants (copy)
        if u1 then
            return;
        end;

        u1 = true;
        u2 = TouchGui:Clone();
        u2.Parent = PlayerGui;
        table.insert(u3, u2.Wheel.InputButton.InputBegan:Connect(onWheelInputBegan));
        table.insert(u3, u2.Controls.GasButton.InputBegan:Connect(onGasPedalInputBegan));
        table.insert(u3, u2.Controls.BrakeButton.InputBegan:Connect(onBrakePedalInputBegan));
        table.insert(u3, u2.Controls.HandBrakeButton.InputBegan:Connect(onHandBrakeInputBegan));
        table.insert(u3, u2.Controls.NitroButton.InputBegan:Connect(onNitroButtonInputBegan));
        table.insert(u3, u2.Misc.ExitButton.InputBegan:Connect(onExitButtonInputBegan));
        table.insert(u3, u2.Misc.CycleCameraModeButton.InputBegan:Connect(onCycleCameraModeButtonInputBegan));
        table.insert(u3, UserInputService.InputEnded:Connect(onInputEnded));
        local v23 = u2:GetPropertyChangedSignal("AbsoluteSize");
        table.insert(u3, v23:Connect(updateScale));
        local v24 = math.min(u2.AbsoluteSize.X, u2.AbsoluteSize.Y) < Constants.UI_SMALL_SCREEN_THRESHOLD;
        u2.UIScale.Scale = not v24 and 1 or Constants.UI_SMALL_SCREEN_SCALE;
    end,

    disable = function(p25) -- Line: 169, Name: disable
        -- upvalues: u1 (ref), disconnectAndClear (copy), u3 (copy), u2 (ref)
        if not u1 then
            return;
        end;

        u1 = false;
        disconnectAndClear(u3);

        if u2 then
            u2:Destroy();
            u2 = nil;
        end;
    end
};