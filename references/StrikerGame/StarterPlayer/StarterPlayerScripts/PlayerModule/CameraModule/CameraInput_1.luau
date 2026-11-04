 
 

local ContextActionService = game:GetService("ContextActionService");
local UserInputService = game:GetService("UserInputService");
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local UserGameSettings = UserSettings():GetService("UserGameSettings");
local VRService = game:GetService("VRService");
game:GetService("StarterGui");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.util.actionUtil);
local LocalPlayer = Players.LocalPlayer;
local Value = Enum.ContextActionPriority.Medium.Value;
local u1 = Vector2.new(1, 0.77) * 0.008726646259971648;
local u2 = Vector2.new(1, 0.77) * 0.12217304763960307;
local u3 = Vector2.new(1, 0.66) * 0.017453292519943295;
local u4 = Vector2.new(1, 0.77) * 0.06981317007977318;
local success, result = pcall(function() -- Line: 32
    return UserSettings():IsUserFeatureEnabled("UserResetTouchStateOnMenuOpen");
end);
local u5 = success and result;
local BindableEvent = Instance.new("BindableEvent");
local BindableEvent2 = Instance.new("BindableEvent");
local Event = BindableEvent.Event;
local Event2 = BindableEvent2.Event;
UserInputService.InputBegan:Connect(function(p6, p7) -- Line: 46
    -- upvalues: BindableEvent (copy)
    if not p7 and p6.UserInputType == Enum.UserInputType.MouseButton2 then
        BindableEvent:Fire();
    end;
end);
UserInputService.InputEnded:Connect(function(p8, p9) -- Line: 52
    -- upvalues: BindableEvent2 (copy)
    if p8.UserInputType == Enum.UserInputType.MouseButton2 then
        BindableEvent2:Fire();
    end;
end);

local function thumbstickCurve(p10) -- Line: 63
    local v11 = (math.abs(p10) - 0.1) / 0.9 * 2;
    local v12 = (math.exp(v11) - 1) / 6.38905609893065;

    return math.sign(p10) * math.clamp(v12, 0, 1);
end;

local function adjustTouchPitchSensitivity(p13) -- Line: 77
    local workspace_CurrentCamera = workspace.CurrentCamera;

    if not workspace_CurrentCamera then
        return p13;
    end;

    local v14 = workspace_CurrentCamera.CFrame:ToEulerAnglesYXZ();

    if p13.Y * v14 >= 0 then
        return p13;
    end;

    local v15 = (1 - (math.abs(v14) * 2 / 3.141592653589793) ^ 0.75) * 0.75 + 0.25;

    return Vector2.new(1, v15) * p13;
end;

local function isInDynamicThumbstickArea(p16: vector) -- Line: 103
    -- upvalues: LocalPlayer (copy)
    local v17 = LocalPlayer:FindFirstChildOfClass("PlayerGui");

    if v17 then
        v17 = v17:FindFirstChild("TouchGui");
    end;

    local v18;

    if v17 then
        v18 = v17:FindFirstChild("TouchControlFrame");
    else
        v18 = v17;
    end;

    if v18 then
        v18 = v18:FindFirstChild("DynamicThumbstickFrame");
    end;

    if not v18 then
        return false;
    end;

    if not v17.Enabled then
        return false;
    end;

    local AbsolutePosition = v18.AbsolutePosition;
    local v19 = AbsolutePosition + v18.AbsoluteSize;
    local v20;

    if p16.X >= AbsolutePosition.X and (p16.Y >= AbsolutePosition.Y and p16.X <= v19.X) then
        v20 = p16.Y <= v19.Y;
    else
        v20 = false;
    end;

    return v20;
end;

local u21 = 0.016666666666666666;
RunService.Stepped:Connect(function(p22, p23) -- Line: 128
    -- upvalues: u21 (ref)
    u21 = p23;
end);
local v24 = {};
local u25 = {};
local u26 = 0;

local function incPanInputCount() -- Line: 138
    -- upvalues: u26 (ref)
    u26 = math.max(0, u26 + 1);
end;

local function decPanInputCount() -- Line: 142
    -- upvalues: u26 (ref)
    u26 = math.max(0, u26 - 1);
end;

local function resetPanInputCount() -- Line: 146
    -- upvalues: u26 (ref)
    u26 = 0;
end;

local u27 = {
    Thumbstick2 = Vector2.new()
};
local u28 = {
    Left = 0,
    Right = 0,
    I = 0,
    O = 0
};
local u29 = {
    Wheel = 0,
    Pinch = 0,
    Movement = Vector2.new(),
    Pan = Vector2.new()
};
local u30 = {
    Pinch = 0,
    Move = Vector2.new()
};
local BindableEvent3 = Instance.new("BindableEvent");
v24.gamepadZoomPress = BindableEvent3.Event;
local u31 = VRService.VREnabled and Instance.new("BindableEvent") or nil;

if VRService.VREnabled then
    v24.gamepadReset = u31.Event;
end;

function v24.getRotationActivated() -- Line: 179
    -- upvalues: u26 (ref), u27 (copy)
    return u26 > 0 and true or u27.Thumbstick2.Magnitude > 0;
end;

function v24.getRotation(p32: boolean?) -- Line: 184
    -- upvalues: UserGameSettings (copy), u28 (copy), u21 (ref), u27 (copy), u29 (copy), adjustTouchPitchSensitivity (copy), u30 (copy), u4 (copy), u1 (copy), u2 (copy), u3 (copy)
    local Vector2_new_ret = Vector2.new(1, UserGameSettings:GetCameraYInvertValue());
    local v33 = Vector2.new(u28.Right - u28.Left, 0) * u21;
    local Thumbstick2 = u27.Thumbstick2;
    local Movement = u29.Movement;
    local Pan = u29.Pan;
    local v34 = adjustTouchPitchSensitivity(u30.Move);

    if p32 then
        v33 = Vector2.new();
    end;

    return (v33 * 2.0943951023931953 + Thumbstick2 * u4 + Movement * u1 + Pan * u2 + v34 * u3) * Vector2_new_ret;
end;

function v24.getZoomDelta() -- Line: 208
    -- upvalues: u28 (copy), u29 (copy), u30 (copy)
    return (u28.O - u28.I) * 0.1 + (-u29.Wheel + u29.Pinch) * 1 + -u30.Pinch * 0.04;
end;

local function thumbstick(p35, p36, p37) -- Line: 216
    -- upvalues: u27 (copy), thumbstickCurve (ref)
    local Position = p37.Position;
    u27[p37.KeyCode.Name] = Vector2.new(thumbstickCurve(Position.X), -thumbstickCurve(Position.Y));

    return Enum.ContextActionResult.Pass;
end;

local function mouseMovement(p38) -- Line: 222
    -- upvalues: u29 (copy)
    local Delta = p38.Delta;
    u29.Movement = Vector2.new(Delta.X, Delta.Y);
end;

local function mouseWheel(p39, p40, p41) -- Line: 227
    -- upvalues: u29 (copy)
    u29.Wheel = p41.Position.Z;

    return Enum.ContextActionResult.Pass;
end;

local function keypress(p42, p43, p44) -- Line: 232
    -- upvalues: u28 (copy)
    u28[p44.KeyCode.Name] = p43 == Enum.UserInputState.Begin and 1 or 0;
end;

local function gamepadZoomPress(p45, p46, p47) -- Line: 236
    -- upvalues: BindableEvent3 (copy)
    if p46 == Enum.UserInputState.Begin then
        BindableEvent3:Fire();
    end;
end;

local function gamepadReset(p48, p49, p50) -- Line: 242
    -- upvalues: u31 (copy)
    if p49 == Enum.UserInputState.Begin then
        u31:Fire();
    end;
end;

local function resetInputDevices() -- Line: 248
    -- upvalues: u27 (copy), u28 (copy), u29 (copy), u30 (copy)
    for _, v in pairs({
        u27,
        u28,
        u29,
        u30
    }) do
        local v51 = v;

        for i, v2 in pairs(v) do
            if type(v2) == "boolean" then
                v51[i] = false;
            else
                v51[i] = v51[i] * 0;
            end;
        end;
    end;
end;

local u52 = {};
local u53 = nil;
local u54 = nil;

local function touchBegan(p55: userdata, p56: boolean) -- Line: 272
    -- upvalues: u53 (ref), isInDynamicThumbstickArea (copy), u26 (ref), u52 (ref)
    assert(p55.UserInputType == Enum.UserInputType.Touch);
    assert(p55.UserInputState == Enum.UserInputState.Begin);

    if u53 == nil and (isInDynamicThumbstickArea(p55.Position) and not p56) then
        u53 = p55;

        return;
    end;

    if not p56 then
        u26 = math.max(0, u26 + 1);
    end;

    u52[p55] = p56;
end;

local function touchEnded(p57: userdata, p58: boolean) -- Line: 292
    -- upvalues: u53 (ref), u52 (ref), u54 (ref), u26 (ref)
    assert(p57.UserInputType == Enum.UserInputType.Touch);
    assert(p57.UserInputState == Enum.UserInputState.End);

    if p57 == u53 then
        u53 = nil;
    end;

    if u52[p57] == false then
        u54 = nil;
        u26 = math.max(0, u26 - 1);
    end;

    u52[p57] = nil;
end;

local function touchChanged(p59, p60) -- Line: 311
    -- upvalues: u53 (ref), u52 (ref), u30 (copy), u54 (ref)
    assert(p59.UserInputType == Enum.UserInputType.Touch);
    assert(p59.UserInputState == Enum.UserInputState.Change);

    if p59 == u53 then
        return;
    end;

    if u52[p59] == nil then
        u52[p59] = p60;
    end;

    local v61 = {};

    for i, v in pairs(u52) do
        if not v then
            table.insert(v61, i);
        end;
    end;

    if #v61 == 1 and u52[p59] == false then
        local Delta = p59.Delta;
        local v62 = u30;
        v62.Move = v62.Move + Vector2.new(Delta.X, Delta.Y);
    end;

    if #v61 ~= 2 then
        u54 = nil;

        return;
    end;

    local Magnitude = (v61[1].Position - v61[2].Position).Magnitude;

    if u54 then
        local v63 = u30;
        v63.Pinch = v63.Pinch + (Magnitude - u54);
    end;

    u54 = Magnitude;
end;

local function resetTouchState() -- Line: 355
    -- upvalues: u52 (ref), u53 (ref), u54 (ref), u5 (ref), u26 (ref)
    u52 = {};
    u53 = nil;
    u54 = nil;

    if u5 then
        u26 = 0;
    end;
end;

local function pointerAction(p64, p65, p66, p67) -- Line: 365
    -- upvalues: u29 (copy)
    if not p67 then
        u29.Wheel = p64;
        u29.Pan = p65;
        u29.Pinch = -p66;
    end;
end;

local function inputBegan(p68, p69) -- Line: 373
    -- upvalues: touchBegan (ref), u26 (ref)
    if p68.UserInputType == Enum.UserInputType.Touch then
        touchBegan(p68, p69);

        return;
    end;

    if p68.UserInputType == Enum.UserInputType.MouseButton2 and not p69 then
        u26 = math.max(0, u26 + 1);
    end;
end;

local function inputChanged(p70, p71) -- Line: 382
    -- upvalues: touchChanged (ref), u29 (copy)
    if p70.UserInputType == Enum.UserInputType.Touch then
        touchChanged(p70, p71);

        return;
    end;

    if p70.UserInputType == Enum.UserInputType.MouseMovement then
        local Delta = p70.Delta;
        u29.Movement = Vector2.new(Delta.X, Delta.Y);
    end;
end;

local function inputEnded(p72, p73) -- Line: 391
    -- upvalues: touchEnded (ref), u26 (ref)
    if p72.UserInputType == Enum.UserInputType.Touch then
        touchEnded(p72, p73);

        return;
    end;

    if p72.UserInputType == Enum.UserInputType.MouseButton2 then
        u26 = math.max(0, u26 - 1);
    end;
end;

local u74 = false;

function v24.setInputEnabled(p75) -- Line: 402
    -- upvalues: u74 (ref), resetInputDevices (copy), resetTouchState (ref), ContextActionService (copy), thumbstick (copy), Value (copy), keypress (copy), VRService (copy), gamepadReset (copy), gamepadZoomPress (copy), u25 (ref), UserInputService (copy), inputBegan (copy), inputChanged (copy), inputEnded (copy), pointerAction (copy), u5 (ref)
    if u74 == p75 then
        return;
    end;

    u74 = p75;
    resetInputDevices();
    resetTouchState();

    if u74 then
        ContextActionService:BindActionAtPriority("RbxCameraThumbstick", thumbstick, false, Value, Enum.KeyCode.Thumbstick2);
        ContextActionService:BindActionAtPriority("RbxCameraKeypress", keypress, false, Value, Enum.KeyCode.Left, Enum.KeyCode.Right, Enum.KeyCode.I, Enum.KeyCode.O);

        if VRService.VREnabled then
            ContextActionService:BindAction("RbxCameraGamepadReset", gamepadReset, false, Enum.KeyCode.ButtonL3);
        end;

        ContextActionService:BindAction("RbxCameraGamepadZoom", gamepadZoomPress, false, Enum.KeyCode.ButtonR3);
        table.insert(u25, UserInputService.InputBegan:Connect(inputBegan));
        table.insert(u25, UserInputService.InputChanged:Connect(inputChanged));
        table.insert(u25, UserInputService.InputEnded:Connect(inputEnded));
        table.insert(u25, UserInputService.PointerAction:Connect(pointerAction));

        if u5 then
            local MenuOpened = game:GetService("GuiService").MenuOpened;
            table.insert(u25, MenuOpened:connect(resetTouchState));
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

        for _, v in pairs(u25) do
            v:Disconnect();
        end;

        u25 = {};
    end;
end;

function v24.getInputEnabled() -- Line: 474
    -- upvalues: u74 (ref)
    return u74;
end;

function v24.resetInputForFrameEnd() -- Line: 478
    -- upvalues: u29 (copy), u30 (copy)
    u29.Movement = Vector2.new();
    u30.Move = Vector2.new();
    u30.Pinch = 0;
    u29.Wheel = 0;
    u29.Pan = Vector2.new();
    u29.Pinch = 0;
end;

UserInputService.WindowFocused:Connect(resetInputDevices);
UserInputService.WindowFocusReleased:Connect(resetInputDevices);
local u76 = false;
local u77 = false;
local u78 = 0;

function v24.getHoldPan() -- Line: 499
    -- upvalues: u76 (ref)
    return u76;
end;

function v24.getTogglePan() -- Line: 503
    -- upvalues: u77 (ref)
    return u77;
end;

function v24.getPanning() -- Line: 507
    -- upvalues: u77 (ref), u76 (ref)
    return u77 or u76;
end;

function v24.setTogglePan(p79: boolean) -- Line: 511
    -- upvalues: u77 (ref)
    u77 = p79;
end;

local u80 = false;
local u81 = nil;
local u82 = nil;

function v24.enableCameraToggleInput() -- Line: 519
    -- upvalues: u80 (ref), u76 (ref), u77 (ref), u81 (ref), u82 (ref), Event (ref), u78 (ref), Event2 (ref), UserInputService (copy)
    if u80 then
        return;
    end;

    u80 = true;
    u76 = false;
    u77 = false;

    if u81 then
        u81:Disconnect();
    end;

    if u82 then
        u82:Disconnect();
    end;

    u81 = Event:Connect(function() -- Line: 536
        -- upvalues: u76 (ref), u78 (ref)
        u76 = true;
        u78 = tick();
    end);
    u82 = Event2:Connect(function() -- Line: 541
        -- upvalues: u76 (ref), u78 (ref), u77 (ref), UserInputService (ref)
        u76 = false;

        if tick() - u78 < 0.3 and (u77 or UserInputService:GetMouseDelta().Magnitude < 2) then
            u77 = not u77;
        end;
    end);
end;

function v24.disableCameraToggleInput() -- Line: 549
    -- upvalues: u80 (ref), u81 (ref), u82 (ref)
    if not u80 then
        return;
    end;

    u80 = false;

    if u81 then
        u81:Disconnect();
        u81 = nil;
    end;

    if u82 then
        u82:Disconnect();
        u82 = nil;
    end;
end;

return v24;