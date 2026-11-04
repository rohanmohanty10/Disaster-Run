  

local ContextActionService = game:GetService("ContextActionService");
local UserInputService = game:GetService("UserInputService");
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local UserGameSettings = UserSettings():GetService("UserGameSettings");
local VRService = game:GetService("VRService");
local CommonUtils = script.Parent.Parent:WaitForChild("CommonUtils");
local UserFlag = require(CommonUtils:WaitForChild("FlagUtil")).getUserFlag("UserCameraInputDt");
local LocalPlayer = Players.LocalPlayer;
local Value = Enum.ContextActionPriority.Medium.Value;
local u1 = Vector2.new(1, 0.77) * 0.06981317007977318;
local u2 = Vector2.new(1, 0.77) * 0.008726646259971648;
local u3 = Vector2.new(1, 0.77) * 0.12217304763960307;
local u4 = Vector2.new(1, 0.66) * 0.017453292519943295;

if UserFlag then
    u1 = u1 * 60;
end;

local success, result = pcall(function() -- Line: 41
    return UserSettings():IsUserFeatureEnabled("UserResetTouchStateOnMenuOpen");
end);
local u5 = success and result;
local success2, result2 = pcall(function() -- Line: 49
    return UserSettings():IsUserFeatureEnabled("UserClearPanOnCameraDisable");
end);
local u6 = success2 and result2;
local success3, result3 = pcall(function() -- Line: 57
    return UserSettings():IsUserFeatureEnabled("UserFixGamepadSensitivity");
end);
local u7 = success3 and result3;
local BindableEvent = Instance.new("BindableEvent");
local BindableEvent2 = Instance.new("BindableEvent");
local Event = BindableEvent.Event;
local Event2 = BindableEvent2.Event;
UserInputService.InputBegan:Connect(function(p8, p9) -- Line: 71
    -- upvalues: BindableEvent (copy)
    if not p9 and p8.UserInputType == Enum.UserInputType.MouseButton2 then
        BindableEvent:Fire();
    end;
end);
UserInputService.InputEnded:Connect(function(p10, p11) -- Line: 77
    -- upvalues: BindableEvent2 (copy)
    if p10.UserInputType == Enum.UserInputType.MouseButton2 then
        BindableEvent2:Fire();
    end;
end);

local function thumbstickCurve(p12) -- Line: 88
    local v13 = (math.abs(p12) - 0.1) / 0.9 * 2;
    local v14 = (math.exp(v13) - 1) / 6.38905609893065;

    return math.sign(p12) * math.clamp(v14, 0, 1);
end;

local function adjustTouchPitchSensitivity(p15) -- Line: 102
    local workspace_CurrentCamera = workspace.CurrentCamera;

    if not workspace_CurrentCamera then
        return p15;
    end;

    local v16 = workspace_CurrentCamera.CFrame:ToEulerAnglesYXZ();

    if p15.Y * v16 >= 0 then
        return p15;
    end;

    local v17 = (1 - (math.abs(v16) * 2 / 3.141592653589793) ^ 0.75) * 0.75 + 0.25;

    return Vector2.new(1, v17) * p15;
end;

local function isInDynamicThumbstickArea(p18: vector) -- Line: 128
    -- upvalues: LocalPlayer (copy)
    local v19 = LocalPlayer:FindFirstChildOfClass("PlayerGui");

    if v19 then
        v19 = v19:FindFirstChild("TouchGui");
    end;

    local v20;

    if v19 then
        v20 = v19:FindFirstChild("TouchControlFrame");
    else
        v20 = v19;
    end;

    if v20 then
        v20 = v20:FindFirstChild("DynamicThumbstickFrame");
    end;

    if not v20 then
        return false;
    end;

    if not v19.Enabled then
        return false;
    end;

    local AbsolutePosition = v20.AbsolutePosition;
    local v21 = AbsolutePosition + v20.AbsoluteSize;
    local v22;

    if p18.X >= AbsolutePosition.X and (p18.Y >= AbsolutePosition.Y and p18.X <= v21.X) then
        v22 = p18.Y <= v21.Y;
    else
        v22 = false;
    end;

    return v22;
end;

local u23 = 0.016666666666666666;
RunService.Stepped:Connect(function(p24, p25) -- Line: 153
    -- upvalues: u23 (ref)
    u23 = p25;
end);
local v26 = {};
local u27 = {};
local u28 = 0;

local function incPanInputCount() -- Line: 163
    -- upvalues: u28 (ref)
    u28 = math.max(0, u28 + 1);
end;

local function decPanInputCount() -- Line: 167
    -- upvalues: u28 (ref)
    u28 = math.max(0, u28 - 1);
end;

local function resetPanInputCount() -- Line: 171
    -- upvalues: u28 (ref)
    u28 = 0;
end;

local u29 = {
    Thumbstick2 = Vector2.new()
};
local u30 = {
    Left = 0,
    Right = 0,
    I = 0,
    O = 0
};
local u31 = {
    Wheel = 0,
    Pinch = 0,
    Movement = Vector2.new(),
    Pan = Vector2.new()
};
local u32 = {
    Pinch = 0,
    Move = Vector2.new()
};
local BindableEvent3 = Instance.new("BindableEvent");
v26.gamepadZoomPress = BindableEvent3.Event;
local u33 = VRService.VREnabled and Instance.new("BindableEvent") or nil;

if VRService.VREnabled then
    v26.gamepadReset = u33.Event;
end;

function v26.getRotationActivated() -- Line: 204
    -- upvalues: u28 (ref), u29 (copy)
    return u28 > 0 and true or u29.Thumbstick2.Magnitude > 0;
end;

function v26.getRotation(p34: any, p35: boolean?) -- Line: 208
    -- upvalues: UserGameSettings (copy), UserFlag (copy), u30 (copy), u23 (ref), u7 (ref), u29 (copy), u31 (copy), adjustTouchPitchSensitivity (copy), u32 (copy), u1 (ref), u2 (copy), u3 (copy), u4 (copy)
    local Vector2_new_ret = Vector2.new(1, UserGameSettings:GetCameraYInvertValue());
    local v36;

    if UserFlag then
        v36 = Vector2.new(u30.Right - u30.Left, 0) * p34;
    else
        v36 = Vector2.new(u30.Right - u30.Left, 0) * u23;
    end;

    local v37;

    if u7 then
        v37 = u29.Thumbstick2 * UserGameSettings.GamepadCameraSensitivity;
    else
        v37 = u29.Thumbstick2;
    end;

    if UserFlag then
        v37 = v37 * p34;
    end;

    local Movement = u31.Movement;
    local Pan = u31.Pan;
    local v38 = adjustTouchPitchSensitivity(u32.Move);

    if p35 then
        v36 = Vector2.new();
    end;

    return (v36 * 2.0943951023931953 + v37 * u1 + Movement * u2 + Pan * u3 + v38 * u4) * Vector2_new_ret;
end;

function v26.getZoomDelta() -- Line: 248
    -- upvalues: u30 (copy), u31 (copy), u32 (copy)
    return (u30.O - u30.I) * 0.1 + (-u31.Wheel + u31.Pinch) * 1 + -u32.Pinch * 0.04;
end;

local function thumbstick(p39, p40, p41) -- Line: 256
    -- upvalues: u29 (copy), thumbstickCurve (ref)
    local Position = p41.Position;
    u29[p41.KeyCode.Name] = Vector2.new(thumbstickCurve(Position.X), -thumbstickCurve(Position.Y));

    return Enum.ContextActionResult.Pass;
end;

local function mouseMovement(p42) -- Line: 262
    -- upvalues: u31 (copy)
    local Delta = p42.Delta;
    u31.Movement = Vector2.new(Delta.X, Delta.Y);
end;

local function mouseWheel(p43, p44, p45) -- Line: 267
    -- upvalues: u31 (copy)
    u31.Wheel = p45.Position.Z;

    return Enum.ContextActionResult.Pass;
end;

local function keypress(p46, p47, p48) -- Line: 272
    -- upvalues: u30 (copy)
    u30[p48.KeyCode.Name] = p47 == Enum.UserInputState.Begin and 1 or 0;
end;

local function gamepadZoomPress(p49, p50, p51) -- Line: 276
    -- upvalues: BindableEvent3 (copy)
    if p50 == Enum.UserInputState.Begin then
        BindableEvent3:Fire();
    end;
end;

local function gamepadReset(p52, p53, p54) -- Line: 282
    -- upvalues: u33 (copy)
    if p53 == Enum.UserInputState.Begin then
        u33:Fire();
    end;
end;

local function resetInputDevices() -- Line: 288
    -- upvalues: u29 (copy), u30 (copy), u31 (copy), u32 (copy), u6 (ref), u28 (ref)
    for _, v in pairs({
        u29,
        u30,
        u31,
        u32
    }) do
        local v55 = v;

        for i, v2 in pairs(v) do
            if type(v2) == "boolean" then
                v55[i] = false;
            else
                v55[i] = v55[i] * 0;
            end;
        end;
    end;

    if u6 then
        u28 = 0;
    end;
end;

local u56 = {};
local u57 = nil;
local u58 = nil;

local function touchBegan(p59: userdata, p60: boolean) -- Line: 316
    -- upvalues: u57 (ref), isInDynamicThumbstickArea (copy), u28 (ref), u56 (ref)
    assert(p59.UserInputType == Enum.UserInputType.Touch);
    assert(p59.UserInputState == Enum.UserInputState.Begin);

    if u57 == nil and (isInDynamicThumbstickArea(p59.Position) and not p60) then
        u57 = p59;

        return;
    end;

    if not p60 then
        u28 = math.max(0, u28 + 1);
    end;

    u56[p59] = p60;
end;

local function touchEnded(p61: userdata, p62: boolean) -- Line: 336
    -- upvalues: u57 (ref), u56 (ref), u58 (ref), u28 (ref)
    assert(p61.UserInputType == Enum.UserInputType.Touch);
    assert(p61.UserInputState == Enum.UserInputState.End);

    if p61 == u57 then
        u57 = nil;
    end;

    if u56[p61] == false then
        u58 = nil;
        u28 = math.max(0, u28 - 1);
    end;

    u56[p61] = nil;
end;

local function touchChanged(p63, p64) -- Line: 355
    -- upvalues: u57 (ref), u56 (ref), u32 (copy), u58 (ref)
    assert(p63.UserInputType == Enum.UserInputType.Touch);
    assert(p63.UserInputState == Enum.UserInputState.Change);

    if p63 == u57 then
        return;
    end;

    if u56[p63] == nil then
        u56[p63] = p64;
    end;

    local v65 = {};

    for i, v in pairs(u56) do
        if not v then
            table.insert(v65, i);
        end;
    end;

    if #v65 == 1 and u56[p63] == false then
        local Delta = p63.Delta;
        local v66 = u32;
        v66.Move = v66.Move + Vector2.new(Delta.X, Delta.Y);
    end;

    if #v65 ~= 2 then
        u58 = nil;

        return;
    end;

    local Magnitude = (v65[1].Position - v65[2].Position).Magnitude;

    if u58 then
        local v67 = u32;
        v67.Pinch = v67.Pinch + (Magnitude - u58);
    end;

    u58 = Magnitude;
end;

local function resetTouchState() -- Line: 399
    -- upvalues: u56 (ref), u57 (ref), u58 (ref), u5 (ref), u28 (ref)
    u56 = {};
    u57 = nil;
    u58 = nil;

    if u5 then
        u28 = 0;
    end;
end;

local function pointerAction(p68, p69, p70, p71) -- Line: 409
    -- upvalues: u31 (copy)
    if not p71 then
        u31.Wheel = p68;
        u31.Pan = p69;
        u31.Pinch = -p70;
    end;
end;

local function inputBegan(p72, p73) -- Line: 417
    -- upvalues: touchBegan (ref), u28 (ref)
    if p72.UserInputType == Enum.UserInputType.Touch then
        touchBegan(p72, p73);

        return;
    end;

    if p72.UserInputType == Enum.UserInputType.MouseButton2 and not p73 then
        u28 = math.max(0, u28 + 1);
    end;
end;

local function inputChanged(p74, p75) -- Line: 426
    -- upvalues: touchChanged (ref), u31 (copy)
    if p74.UserInputType == Enum.UserInputType.Touch then
        touchChanged(p74, p75);

        return;
    end;

    if p74.UserInputType == Enum.UserInputType.MouseMovement then
        local Delta = p74.Delta;
        u31.Movement = Vector2.new(Delta.X, Delta.Y);
    end;
end;

local function inputEnded(p76, p77) -- Line: 435
    -- upvalues: touchEnded (ref), u28 (ref)
    if p76.UserInputType == Enum.UserInputType.Touch then
        touchEnded(p76, p77);

        return;
    end;

    if p76.UserInputType == Enum.UserInputType.MouseButton2 then
        u28 = math.max(0, u28 - 1);
    end;
end;

local u78 = false;

function v26.setInputEnabled(p79) -- Line: 446
    -- upvalues: u78 (ref), resetInputDevices (copy), resetTouchState (ref), ContextActionService (copy), thumbstick (copy), Value (copy), keypress (copy), VRService (copy), gamepadReset (copy), gamepadZoomPress (copy), u27 (ref), UserInputService (copy), inputBegan (copy), inputChanged (copy), inputEnded (copy), pointerAction (copy), u5 (ref)
    if u78 == p79 then
        return;
    end;

    u78 = p79;
    resetInputDevices();
    resetTouchState();

    if u78 then
        ContextActionService:BindActionAtPriority("RbxCameraThumbstick", thumbstick, false, Value, Enum.KeyCode.Thumbstick2);
        ContextActionService:BindActionAtPriority("RbxCameraKeypress", keypress, false, Value, Enum.KeyCode.Left, Enum.KeyCode.Right, Enum.KeyCode.I, Enum.KeyCode.O);

        if VRService.VREnabled then
            ContextActionService:BindAction("RbxCameraGamepadReset", gamepadReset, false, Enum.KeyCode.ButtonL3);
        end;

        ContextActionService:BindAction("RbxCameraGamepadZoom", gamepadZoomPress, false, Enum.KeyCode.ButtonR3);
        table.insert(u27, UserInputService.InputBegan:Connect(inputBegan));
        table.insert(u27, UserInputService.InputChanged:Connect(inputChanged));
        table.insert(u27, UserInputService.InputEnded:Connect(inputEnded));
        table.insert(u27, UserInputService.PointerAction:Connect(pointerAction));

        if u5 then
            local MenuOpened = game:GetService("GuiService").MenuOpened;
            table.insert(u27, MenuOpened:connect(resetTouchState));
        end;
    else
        ContextActionService:UnbindAction("RbxCameraThumbstick");
        ContextActionService:UnbindAction("RbxCameraMouseMove");
        ContextActionService:UnbindAction("RbxCameraMouseWheel");
        ContextActionService:UnbindAction("RbxCameraKeypress");
        ContextActionService:UnbindAction("RbxCameraGamepadZoom");

        if VRService.VREnabled then
            ContextActionService:UnbindAction("RbxCameraGamepadReset");
        end;

        for _, v in pairs(u27) do
            v:Disconnect();
        end;

        u27 = {};
    end;
end;

function v26.getInputEnabled() -- Line: 518
    -- upvalues: u78 (ref)
    return u78;
end;

function v26.resetInputForFrameEnd() -- Line: 522
    -- upvalues: u31 (copy), u32 (copy)
    u31.Movement = Vector2.new();
    u32.Move = Vector2.new();
    u32.Pinch = 0;
    u31.Wheel = 0;
    u31.Pan = Vector2.new();
    u31.Pinch = 0;
end;

UserInputService.WindowFocused:Connect(resetInputDevices);
UserInputService.WindowFocusReleased:Connect(resetInputDevices);
local u80 = false;
local u81 = false;
local u82 = 0;

function v26.getHoldPan() -- Line: 543
    -- upvalues: u80 (ref)
    return u80;
end;

function v26.getTogglePan() -- Line: 547
    -- upvalues: u81 (ref)
    return u81;
end;

function v26.getPanning() -- Line: 551
    -- upvalues: u81 (ref), u80 (ref)
    return u81 or u80;
end;

function v26.setTogglePan(p83: boolean) -- Line: 555
    -- upvalues: u81 (ref)
    u81 = p83;
end;

local u84 = false;
local u85 = nil;
local u86 = nil;

function v26.enableCameraToggleInput() -- Line: 563
    -- upvalues: u84 (ref), u80 (ref), u81 (ref), u85 (ref), u86 (ref), Event (ref), u82 (ref), Event2 (ref), UserInputService (copy)
    if u84 then
        return;
    end;

    u84 = true;
    u80 = false;
    u81 = false;

    if u85 then
        u85:Disconnect();
    end;

    if u86 then
        u86:Disconnect();
    end;

    u85 = Event:Connect(function() -- Line: 580
        -- upvalues: u80 (ref), u82 (ref)
        u80 = true;
        u82 = tick();
    end);
    u86 = Event2:Connect(function() -- Line: 585
        -- upvalues: u80 (ref), u82 (ref), u81 (ref), UserInputService (ref)
        u80 = false;

        if tick() - u82 < 0.3 and (u81 or UserInputService:GetMouseDelta().Magnitude < 2) then
            u81 = not u81;
        end;
    end);
end;

function v26.disableCameraToggleInput() -- Line: 593
    -- upvalues: u84 (ref), u85 (ref), u86 (ref)
    if not u84 then
        return;
    end;

    u84 = false;

    if u85 then
        u85:Disconnect();
        u85 = nil;
    end;

    if u86 then
        u86:Disconnect();
        u86 = nil;
    end;
end;

return v26;