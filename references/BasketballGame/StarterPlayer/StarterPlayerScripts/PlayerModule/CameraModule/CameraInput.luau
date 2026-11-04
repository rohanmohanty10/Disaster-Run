 
 

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
local BindableEvent = Instance.new("BindableEvent");
local BindableEvent2 = Instance.new("BindableEvent");
local Event = BindableEvent.Event;
local Event2 = BindableEvent2.Event;
UserInputService.InputBegan:Connect(function(p7, p8) -- Line: 63
    -- upvalues: BindableEvent (copy)
    if not p8 and p7.UserInputType == Enum.UserInputType.MouseButton2 then
        BindableEvent:Fire();
    end;
end);
UserInputService.InputEnded:Connect(function(p9, p10) -- Line: 69
    -- upvalues: BindableEvent2 (copy)
    if p9.UserInputType == Enum.UserInputType.MouseButton2 then
        BindableEvent2:Fire();
    end;
end);

local function thumbstickCurve(p11) -- Line: 80
    local v12 = (math.abs(p11) - 0.1) / 0.9 * 2;
    local v13 = (math.exp(v12) - 1) / 6.38905609893065;

    return math.sign(p11) * math.clamp(v13, 0, 1);
end;

local function adjustTouchPitchSensitivity(p14) -- Line: 94
    local workspace_CurrentCamera = workspace.CurrentCamera;

    if not workspace_CurrentCamera then
        return p14;
    end;

    local v15 = workspace_CurrentCamera.CFrame:ToEulerAnglesYXZ();

    if p14.Y * v15 >= 0 then
        return p14;
    end;

    local v16 = (1 - (math.abs(v15) * 2 / 3.141592653589793) ^ 0.75) * 0.75 + 0.25;

    return Vector2.new(1, v16) * p14;
end;

local function isInDynamicThumbstickArea(p17: vector) -- Line: 120
    -- upvalues: LocalPlayer (copy)
    local v18 = LocalPlayer:FindFirstChildOfClass("PlayerGui");

    if v18 then
        v18 = v18:FindFirstChild("TouchGui");
    end;

    local v19;

    if v18 then
        v19 = v18:FindFirstChild("TouchControlFrame");
    else
        v19 = v18;
    end;

    if v19 then
        v19 = v19:FindFirstChild("DynamicThumbstickFrame");
    end;

    if not v19 then
        return false;
    end;

    if not v18.Enabled then
        return false;
    end;

    local AbsolutePosition = v19.AbsolutePosition;
    local v20 = AbsolutePosition + v19.AbsoluteSize;
    local v21;

    if p17.X >= AbsolutePosition.X and (p17.Y >= AbsolutePosition.Y and p17.X <= v20.X) then
        v21 = p17.Y <= v20.Y;
    else
        v21 = false;
    end;

    return v21;
end;

local u22 = 0.016666666666666666;
RunService.Stepped:Connect(function(p23, p24) -- Line: 145
    -- upvalues: u22 (ref)
    u22 = p24;
end);
local v25 = {};
local u26 = {};
local u27 = 0;

local function incPanInputCount() -- Line: 155
    -- upvalues: u27 (ref)
    u27 = math.max(0, u27 + 1);
end;

local function decPanInputCount() -- Line: 159
    -- upvalues: u27 (ref)
    u27 = math.max(0, u27 - 1);
end;

local function resetPanInputCount() -- Line: 163
    -- upvalues: u27 (ref)
    u27 = 0;
end;

local u28 = {
    Thumbstick2 = Vector2.new()
};
local u29 = {
    Left = 0,
    Right = 0,
    I = 0,
    O = 0
};
local u30 = {
    Wheel = 0,
    Pinch = 0,
    Movement = Vector2.new(),
    Pan = Vector2.new()
};
local u31 = {
    Pinch = 0,
    Move = Vector2.new()
};
local BindableEvent3 = Instance.new("BindableEvent");
v25.gamepadZoomPress = BindableEvent3.Event;
local u32 = VRService.VREnabled and Instance.new("BindableEvent") or nil;

if VRService.VREnabled then
    v25.gamepadReset = u32.Event;
end;

function v25.getRotationActivated() -- Line: 196
    -- upvalues: u27 (ref), u28 (copy)
    return u27 > 0 and true or u28.Thumbstick2.Magnitude > 0;
end;

function v25.getRotation(p33: any, p34: boolean?) -- Line: 200
    -- upvalues: UserGameSettings (copy), UserFlag (copy), u29 (copy), u22 (ref), u28 (copy), u30 (copy), adjustTouchPitchSensitivity (copy), u31 (copy), u1 (ref), u2 (copy), u3 (copy), u4 (copy)
    local Vector2_new_ret = Vector2.new(1, UserGameSettings:GetCameraYInvertValue());
    local v35;

    if UserFlag then
        v35 = Vector2.new(u29.Right - u29.Left, 0) * p33;
    else
        v35 = Vector2.new(u29.Right - u29.Left, 0) * u22;
    end;

    local v36 = u28.Thumbstick2 * UserGameSettings.GamepadCameraSensitivity;

    if UserFlag then
        v36 = v36 * p33;
    end;

    local Movement = u30.Movement;
    local Pan = u30.Pan;
    local v37 = adjustTouchPitchSensitivity(u31.Move);

    if p34 then
        v35 = Vector2.new();
    end;

    return (v35 * 2.0943951023931953 + v36 * u1 + Movement * u2 + Pan * u3 + v37 * u4) * Vector2_new_ret;
end;

function v25.getZoomDelta() -- Line: 234
    -- upvalues: u29 (copy), u30 (copy), u31 (copy)
    return (u29.O - u29.I) * 0.1 + (-u30.Wheel + u30.Pinch) * 1 + -u31.Pinch * 0.04;
end;

local function thumbstick(p38, p39, p40) -- Line: 242
    -- upvalues: u28 (copy), thumbstickCurve (ref)
    local Position = p40.Position;
    u28[p40.KeyCode.Name] = Vector2.new(thumbstickCurve(Position.X), -thumbstickCurve(Position.Y));

    return Enum.ContextActionResult.Pass;
end;

local function mouseMovement(p41) -- Line: 248
    -- upvalues: u30 (copy)
    local Delta = p41.Delta;
    u30.Movement = Vector2.new(Delta.X, Delta.Y);
end;

local function mouseWheel(p42, p43, p44) -- Line: 253
    -- upvalues: u30 (copy)
    u30.Wheel = p44.Position.Z;

    return Enum.ContextActionResult.Pass;
end;

local function keypress(p45, p46, p47) -- Line: 258
    -- upvalues: u29 (copy)
    u29[p47.KeyCode.Name] = p46 == Enum.UserInputState.Begin and 1 or 0;
end;

local function gamepadZoomPress(p48, p49, p50) -- Line: 262
    -- upvalues: BindableEvent3 (copy)
    if p49 == Enum.UserInputState.Begin then
        BindableEvent3:Fire();
    end;
end;

local function gamepadReset(p51, p52, p53) -- Line: 268
    -- upvalues: u32 (copy)
    if p52 == Enum.UserInputState.Begin then
        u32:Fire();
    end;
end;

local function resetInputDevices() -- Line: 274
    -- upvalues: u28 (copy), u29 (copy), u30 (copy), u31 (copy), u6 (ref), u27 (ref)
    for _, v in pairs({
        u28,
        u29,
        u30,
        u31
    }) do
        local v54 = v;

        for i, v2 in pairs(v) do
            if type(v2) == "boolean" then
                v54[i] = false;
            else
                v54[i] = v54[i] * 0;
            end;
        end;
    end;

    if u6 then
        u27 = 0;
    end;
end;

local u55 = {};
local u56 = nil;
local u57 = nil;

local function touchBegan(p58: userdata, p59: boolean) -- Line: 302
    -- upvalues: u56 (ref), isInDynamicThumbstickArea (copy), u27 (ref), u55 (ref)
    assert(p58.UserInputType == Enum.UserInputType.Touch);
    assert(p58.UserInputState == Enum.UserInputState.Begin);

    if u56 == nil and (isInDynamicThumbstickArea(p58.Position) and not p59) then
        u56 = p58;

        return;
    end;

    if not p59 then
        u27 = math.max(0, u27 + 1);
    end;

    u55[p58] = p59;
end;

local function touchEnded(p60: userdata, p61: boolean) -- Line: 322
    -- upvalues: u56 (ref), u55 (ref), u57 (ref), u27 (ref)
    assert(p60.UserInputType == Enum.UserInputType.Touch);
    assert(p60.UserInputState == Enum.UserInputState.End);

    if p60 == u56 then
        u56 = nil;
    end;

    if u55[p60] == false then
        u57 = nil;
        u27 = math.max(0, u27 - 1);
    end;

    u55[p60] = nil;
end;

local function touchChanged(p62, p63) -- Line: 341
    -- upvalues: u56 (ref), u55 (ref), u31 (copy), u57 (ref)
    assert(p62.UserInputType == Enum.UserInputType.Touch);
    assert(p62.UserInputState == Enum.UserInputState.Change);

    if p62 == u56 then
        return;
    end;

    if u55[p62] == nil then
        u55[p62] = p63;
    end;

    local v64 = {};

    for i, v in pairs(u55) do
        if not v then
            table.insert(v64, i);
        end;
    end;

    if #v64 == 1 and u55[p62] == false then
        local Delta = p62.Delta;
        local v65 = u31;
        v65.Move = v65.Move + Vector2.new(Delta.X, Delta.Y);
    end;

    if #v64 ~= 2 then
        u57 = nil;

        return;
    end;

    local Magnitude = (v64[1].Position - v64[2].Position).Magnitude;

    if u57 then
        local v66 = u31;
        v66.Pinch = v66.Pinch + (Magnitude - u57);
    end;

    u57 = Magnitude;
end;

local function resetTouchState() -- Line: 385
    -- upvalues: u55 (ref), u56 (ref), u57 (ref), u5 (ref), u27 (ref)
    u55 = {};
    u56 = nil;
    u57 = nil;

    if u5 then
        u27 = 0;
    end;
end;

local function pointerAction(p67, p68, p69, p70) -- Line: 395
    -- upvalues: u30 (copy)
    if not p70 then
        u30.Wheel = p67;
        u30.Pan = p68;
        u30.Pinch = -p69;
    end;
end;

local function inputBegan(p71, p72) -- Line: 403
    -- upvalues: touchBegan (ref), u27 (ref)
    if p71.UserInputType == Enum.UserInputType.Touch then
        touchBegan(p71, p72);

        return;
    end;

    if p71.UserInputType == Enum.UserInputType.MouseButton2 and not p72 then
        u27 = math.max(0, u27 + 1);
    end;
end;

local function inputChanged(p73, p74) -- Line: 412
    -- upvalues: touchChanged (ref), u30 (copy)
    if p73.UserInputType == Enum.UserInputType.Touch then
        touchChanged(p73, p74);

        return;
    end;

    if p73.UserInputType == Enum.UserInputType.MouseMovement then
        local Delta = p73.Delta;
        u30.Movement = Vector2.new(Delta.X, Delta.Y);
    end;
end;

local function inputEnded(p75, p76) -- Line: 421
    -- upvalues: touchEnded (ref), u27 (ref)
    if p75.UserInputType == Enum.UserInputType.Touch then
        touchEnded(p75, p76);

        return;
    end;

    if p75.UserInputType == Enum.UserInputType.MouseButton2 then
        u27 = math.max(0, u27 - 1);
    end;
end;

local u77 = false;

function v25.setInputEnabled(p78) -- Line: 432
    -- upvalues: u77 (ref), resetInputDevices (copy), resetTouchState (ref), ContextActionService (copy), thumbstick (copy), Value (copy), keypress (copy), VRService (copy), gamepadReset (copy), gamepadZoomPress (copy), u26 (ref), UserInputService (copy), inputBegan (copy), inputChanged (copy), inputEnded (copy), pointerAction (copy), u5 (ref)
    if u77 == p78 then
        return;
    end;

    u77 = p78;
    resetInputDevices();
    resetTouchState();

    if u77 then
        ContextActionService:BindActionAtPriority("RbxCameraThumbstick", thumbstick, false, Value, Enum.KeyCode.Thumbstick2);
        ContextActionService:BindActionAtPriority("RbxCameraKeypress", keypress, false, Value, Enum.KeyCode.Left, Enum.KeyCode.Right, Enum.KeyCode.I, Enum.KeyCode.O);

        if VRService.VREnabled then
            ContextActionService:BindAction("RbxCameraGamepadReset", gamepadReset, false, Enum.KeyCode.ButtonL3);
        end;

        ContextActionService:BindAction("RbxCameraGamepadZoom", gamepadZoomPress, false, Enum.KeyCode.ButtonR3);
        table.insert(u26, UserInputService.InputBegan:Connect(inputBegan));
        table.insert(u26, UserInputService.InputChanged:Connect(inputChanged));
        table.insert(u26, UserInputService.InputEnded:Connect(inputEnded));
        table.insert(u26, UserInputService.PointerAction:Connect(pointerAction));

        if u5 then
            local MenuOpened = game:GetService("GuiService").MenuOpened;
            table.insert(u26, MenuOpened:connect(resetTouchState));
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

        for _, v in pairs(u26) do
            v:Disconnect();
        end;

        u26 = {};
    end;
end;

function v25.getInputEnabled() -- Line: 504
    -- upvalues: u77 (ref)
    return u77;
end;

function v25.resetInputForFrameEnd() -- Line: 508
    -- upvalues: u30 (copy), u31 (copy)
    u30.Movement = Vector2.new();
    u31.Move = Vector2.new();
    u31.Pinch = 0;
    u30.Wheel = 0;
    u30.Pan = Vector2.new();
    u30.Pinch = 0;
end;

UserInputService.WindowFocused:Connect(resetInputDevices);
UserInputService.WindowFocusReleased:Connect(resetInputDevices);
local u79 = false;
local u80 = false;
local u81 = 0;

function v25.getHoldPan() -- Line: 529
    -- upvalues: u79 (ref)
    return u79;
end;

function v25.getTogglePan() -- Line: 533
    -- upvalues: u80 (ref)
    return u80;
end;

function v25.getPanning() -- Line: 537
    -- upvalues: u80 (ref), u79 (ref)
    return u80 or u79;
end;

function v25.setTogglePan(p82: boolean) -- Line: 541
    -- upvalues: u80 (ref)
    u80 = p82;
end;

local u83 = false;
local u84 = nil;
local u85 = nil;

function v25.enableCameraToggleInput() -- Line: 549
    -- upvalues: u83 (ref), u79 (ref), u80 (ref), u84 (ref), u85 (ref), Event (ref), u81 (ref), Event2 (ref), UserInputService (copy)
    if u83 then
        return;
    end;

    u83 = true;
    u79 = false;
    u80 = false;

    if u84 then
        u84:Disconnect();
    end;

    if u85 then
        u85:Disconnect();
    end;

    u84 = Event:Connect(function() -- Line: 566
        -- upvalues: u79 (ref), u81 (ref)
        u79 = true;
        u81 = tick();
    end);
    u85 = Event2:Connect(function() -- Line: 571
        -- upvalues: u79 (ref), u81 (ref), u80 (ref), UserInputService (ref)
        u79 = false;

        if tick() - u81 < 0.3 and (u80 or UserInputService:GetMouseDelta().Magnitude < 2) then
            u80 = not u80;
        end;
    end);
end;

function v25.disableCameraToggleInput() -- Line: 579
    -- upvalues: u83 (ref), u84 (ref), u85 (ref)
    if not u83 then
        return;
    end;

    u83 = false;

    if u84 then
        u84:Disconnect();
        u84 = nil;
    end;

    if u85 then
        u85:Disconnect();
        u85 = nil;
    end;
end;

return v25;