  

 

local ContextActionService = game:GetService("ContextActionService");
local UserInputService = game:GetService("UserInputService");
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local UserGameSettings = UserSettings():GetService("UserGameSettings");
local LocalPlayer = Players.LocalPlayer;
local Value = Enum.ContextActionPriority.Default.Value;
local u1 = Vector2.new(1, 0.77) * 0.008726646259971648;
local u2 = Vector2.new(1, 0.77) * 0.12217304763960307;
local u3 = Vector2.new(1, 0.66) * 0.017453292519943295;
local u4 = Vector2.new(1, 0.77) * 0.06981317007977318;
local BindableEvent = Instance.new("BindableEvent");
local BindableEvent2 = Instance.new("BindableEvent");
local Event = BindableEvent.Event;
local Event2 = BindableEvent2.Event;
UserInputService.InputBegan:Connect(function(p5, p6) -- Line: 32
    -- upvalues: BindableEvent (copy)
    if not p6 and p5.UserInputType == Enum.UserInputType.MouseButton2 then
        BindableEvent:Fire();
    end;
end);
UserInputService.InputEnded:Connect(function(p7, p8) -- Line: 38
    -- upvalues: BindableEvent2 (copy)
    if p7.UserInputType == Enum.UserInputType.MouseButton2 then
        BindableEvent2:Fire();
    end;
end);

local function thumbstickCurve(p9) -- Line: 49
    local v10 = (math.abs(p9) - 0.1) / 0.9 * 2;
    local v11 = (math.exp(v10) - 1) / 6.38905609893065;

    return math.sign(p9) * math.clamp(v11, 0, 1);
end;

local function adjustTouchPitchSensitivity(p12) -- Line: 63
    local CurrentCamera = workspace.CurrentCamera;

    if not CurrentCamera then
        return p12;
    end;

    local v13 = CurrentCamera.CFrame:ToEulerAnglesYXZ();

    if p12.Y * v13 >= 0 then
        return p12;
    end;

    local v14 = (1 - (math.abs(v13) * 2 / 3.141592653589793) ^ 0.75) * 0.75 + 0.25;

    return Vector2.new(1, v14) * p12;
end;

local function isInDynamicThumbstickArea(p15) -- Line: 89
    -- upvalues: LocalPlayer (copy)
    local v16 = LocalPlayer:FindFirstChildOfClass("PlayerGui");

    if v16 then
        v16 = v16:FindFirstChild("TouchGui");
    end;

    local v17;

    if v16 then
        v17 = v16:FindFirstChild("TouchControlFrame");
    else
        v17 = v16;
    end;

    if v17 then
        v17 = v17:FindFirstChild("DynamicThumbstickFrame");
    end;

    if not v17 then
        return false;
    end;

    if not v16.Enabled then
        return false;
    end;

    local AbsolutePosition = v17.AbsolutePosition;
    local v18 = AbsolutePosition + v17.AbsoluteSize;
    local v19;

    if p15.X >= AbsolutePosition.X and (p15.Y >= AbsolutePosition.Y and p15.X <= v18.X) then
        v19 = p15.Y <= v18.Y;
    else
        v19 = false;
    end;

    return v19;
end;

local u20 = 0.016666666666666666;
RunService.Stepped:Connect(function(p21, p22) -- Line: 114
    -- upvalues: u20 (ref)
    u20 = p22;
end);
local v23 = {};
local u24 = {};
local u25 = 0;

local function incPanInputCount() -- Line: 124
    -- upvalues: u25 (ref)
    u25 = math.max(0, u25 + 1);
end;

local function decPanInputCount() -- Line: 128
    -- upvalues: u25 (ref)
    u25 = math.max(0, u25 - 1);
end;

local u26 = {
    Thumbstick2 = Vector2.new()
};
local u27 = {
    Left = 0,
    Right = 0,
    I = 0,
    O = 0
};
local u28 = {
    Wheel = 0,
    Pinch = 0,
    Movement = Vector2.new(),
    Pan = Vector2.new()
};
local u29 = {
    Pinch = 0,
    Move = Vector2.new()
};
local BindableEvent3 = Instance.new("BindableEvent");
v23.gamepadZoomPress = BindableEvent3.Event;

function v23.getRotationActivated() -- Line: 156
    -- upvalues: u25 (ref), u26 (copy)
    return u25 > 0 and true or u26.Thumbstick2.Magnitude > 0;
end;

function v23.getRotation(p30) -- Line: 160
    -- upvalues: UserGameSettings (copy), u27 (copy), u20 (ref), u26 (copy), u28 (copy), adjustTouchPitchSensitivity (copy), u29 (copy), u4 (copy), u1 (copy), u2 (copy), u3 (copy)
    local v31 = Vector2.new(1, UserGameSettings:GetCameraYInvertValue());
    local v32 = Vector2.new(u27.Right - u27.Left, 0) * u20;
    local Thumbstick2 = u26.Thumbstick2;
    local Movement = u28.Movement;
    local Pan = u28.Pan;
    local v33 = adjustTouchPitchSensitivity(u29.Move);

    if p30 then
        v32 = Vector2.new();
    end;

    return (v32 * 2.0943951023931953 + Thumbstick2 * u4 + Movement * u1 + Pan * u2 + v33 * u3) * v31;
end;

function v23.getZoomDelta() -- Line: 184
    -- upvalues: u27 (copy), u28 (copy), u29 (copy)
    return (u27.O - u27.I) * 0.1 + (-u28.Wheel + u28.Pinch) * 1 + -u29.Pinch * 0.04;
end;

local function thumbstick(p34, p35, p36) -- Line: 192
    -- upvalues: u26 (copy), thumbstickCurve (ref)
    local Position = p36.Position;
    u26[p36.KeyCode.Name] = Vector2.new(thumbstickCurve(Position.X), -thumbstickCurve(Position.Y));
end;

local function mouseMovement(p37) -- Line: 197
    -- upvalues: u28 (copy)
    local Delta = p37.Delta;
    u28.Movement = Vector2.new(Delta.X, Delta.Y);
end;

local function mouseWheel(p38, p39, p40) -- Line: 202
    -- upvalues: u28 (copy)
    u28.Wheel = p40.Position.Z;

    return Enum.ContextActionResult.Pass;
end;

local function keypress(p41, p42, p43) -- Line: 207
    -- upvalues: u27 (copy)
    u27[p43.KeyCode.Name] = p42 == Enum.UserInputState.Begin and 1 or 0;
end;

local function gamepadZoomPress(p44, p45, p46) -- Line: 211
    -- upvalues: BindableEvent3 (copy)
    if p45 == Enum.UserInputState.Begin then
        BindableEvent3:Fire();
    end;
end;

local function resetInputDevices() -- Line: 217
    -- upvalues: u26 (copy), u27 (copy), u28 (copy), u29 (copy)
    for _, v in pairs({
        u26,
        u27,
        u28,
        u29
    }) do
        for i, v2 in pairs(v) do
            if type(v2) == "boolean" then
                v[i] = false;
            else
                v[i] = v[i] * 0;
            end;
        end;
    end;
end;

local u47 = {};
local u48 = nil;
local u49 = nil;

local function touchBegan(p50, p51) -- Line: 241
    -- upvalues: u48 (ref), isInDynamicThumbstickArea (copy), u25 (ref), u47 (ref)
    assert(p50.UserInputType == Enum.UserInputType.Touch);
    assert(p50.UserInputState == Enum.UserInputState.Begin);

    if u48 == nil and (isInDynamicThumbstickArea(p50.Position) and not p51) then
        u48 = p50;

        return;
    end;

    if not p51 then
        u25 = math.max(0, u25 + 1);
    end;

    u47[p50] = p51;
end;

local function touchEnded(p52, p53) -- Line: 261
    -- upvalues: u48 (ref), u47 (ref), u49 (ref), u25 (ref)
    assert(p52.UserInputType == Enum.UserInputType.Touch);
    assert(p52.UserInputState == Enum.UserInputState.End);

    if p52 == u48 then
        u48 = nil;
    end;

    if u47[p52] == false then
        u49 = nil;
        u25 = math.max(0, u25 - 1);
    end;

    u47[p52] = nil;
end;

local function touchChanged(p54, p55) -- Line: 280
    -- upvalues: u48 (ref), u47 (ref), u29 (copy), u49 (ref)
    assert(p54.UserInputType == Enum.UserInputType.Touch);
    assert(p54.UserInputState == Enum.UserInputState.Change);

    if p54 == u48 then
        return;
    end;

    if u47[p54] == nil then
        u47[p54] = p55;
    end;

    local v56 = {};

    for i, v in pairs(u47) do
        if not v then
            table.insert(v56, i);
        end;
    end;

    if #v56 == 1 and u47[p54] == false then
        local Delta = p54.Delta;
        local v57 = u29;
        v57.Move = v57.Move + Vector2.new(Delta.X, Delta.Y);
    end;

    if #v56 ~= 2 then
        u49 = nil;

        return;
    end;

    local Magnitude = (v56[1].Position - v56[2].Position).Magnitude;

    if u49 then
        local v58 = u29;
        v58.Pinch = v58.Pinch + (Magnitude - u49);
    end;

    u49 = Magnitude;
end;

local function resetTouchState() -- Line: 324
    -- upvalues: u47 (ref), u48 (ref), u49 (ref)
    u47 = {};
    u48 = nil;
    u49 = nil;
end;

local function pointerAction(p59, p60, p61, p62) -- Line: 331
    -- upvalues: u28 (copy)
    if not p62 then
        u28.Wheel = p59;
        u28.Pan = p60;
        u28.Pinch = -p61;
    end;
end;

local function inputBegan(p63, p64) -- Line: 339
    -- upvalues: touchBegan (ref), u25 (ref)
    if p63.UserInputType == Enum.UserInputType.Touch then
        touchBegan(p63, p64);

        return;
    end;

    if p63.UserInputType == Enum.UserInputType.MouseButton2 and not p64 then
        u25 = math.max(0, u25 + 1);
    end;
end;

local function inputChanged(p65, p66) -- Line: 348
    -- upvalues: touchChanged (ref), u28 (copy)
    if p65.UserInputType == Enum.UserInputType.Touch then
        touchChanged(p65, p66);

        return;
    end;

    if p65.UserInputType == Enum.UserInputType.MouseMovement then
        local Delta = p65.Delta;
        u28.Movement = Vector2.new(Delta.X, Delta.Y);
    end;
end;

local function inputEnded(p67, p68) -- Line: 357
    -- upvalues: touchEnded (ref), u25 (ref)
    if p67.UserInputType == Enum.UserInputType.Touch then
        touchEnded(p67, p68);

        return;
    end;

    if p67.UserInputType == Enum.UserInputType.MouseButton2 then
        u25 = math.max(0, u25 - 1);
    end;
end;

local u69 = false;

function v23.setInputEnabled(p70) -- Line: 368
    -- upvalues: u69 (ref), resetInputDevices (copy), resetTouchState (ref), ContextActionService (copy), thumbstick (copy), Value (copy), keypress (copy), gamepadZoomPress (copy), u24 (ref), UserInputService (copy), inputBegan (copy), inputChanged (copy), inputEnded (copy), pointerAction (copy)
    if u69 == p70 then
        return;
    end;

    u69 = p70;
    resetInputDevices();
    resetTouchState();

    if not u69 then
        ContextActionService:UnbindAction("RbxCameraThumbstick");
        ContextActionService:UnbindAction("RbxCameraMouseMove");
        ContextActionService:UnbindAction("RbxCameraMouseWheel");
        ContextActionService:UnbindAction("RbxCameraKeypress");

        for _, v in pairs(u24) do
            v:Disconnect();
        end;

        u24 = {};

        return;
    end;

    ContextActionService:BindActionAtPriority("RbxCameraThumbstick", thumbstick, false, Value, Enum.KeyCode.Thumbstick2);
    ContextActionService:BindActionAtPriority("RbxCameraKeypress", keypress, false, Value, Enum.KeyCode.Left, Enum.KeyCode.Right, Enum.KeyCode.I, Enum.KeyCode.O);
    ContextActionService:BindAction("RbxCameraGamepadZoom", gamepadZoomPress, false, Enum.KeyCode.ButtonR3);
    table.insert(u24, UserInputService.InputBegan:Connect(inputBegan));
    table.insert(u24, UserInputService.InputChanged:Connect(inputChanged));
    table.insert(u24, UserInputService.InputEnded:Connect(inputEnded));
    table.insert(u24, UserInputService.PointerAction:Connect(pointerAction));
end;

function v23.getInputEnabled() -- Line: 422
    -- upvalues: u69 (ref)
    return u69;
end;

function v23.resetInputForFrameEnd() -- Line: 426
    -- upvalues: u28 (copy), u29 (copy)
    u28.Movement = Vector2.new();
    u29.Move = Vector2.new();
    u29.Pinch = 0;
    u28.Wheel = 0;
    u28.Pan = Vector2.new();
    u28.Pinch = 0;
end;

UserInputService.WindowFocused:Connect(resetInputDevices);
UserInputService.WindowFocusReleased:Connect(resetInputDevices);
local u71 = false;
local u72 = false;
local u73 = 0;

function v23.getHoldPan() -- Line: 447
    -- upvalues: u71 (ref)
    return u71;
end;

function v23.getTogglePan() -- Line: 451
    -- upvalues: u72 (ref)
    return u72;
end;

function v23.getPanning() -- Line: 455
    -- upvalues: u72 (ref), u71 (ref)
    return u72 or u71;
end;

function v23.setTogglePan(p74) -- Line: 459
    -- upvalues: u72 (ref)
    u72 = p74;
end;

local u75 = false;
local u76 = nil;
local u77 = nil;

function v23.enableCameraToggleInput() -- Line: 467
    -- upvalues: u75 (ref), u71 (ref), u72 (ref), u76 (ref), u77 (ref), Event (ref), u73 (ref), Event2 (ref), UserInputService (copy)
    if u75 then
        return;
    end;

    u75 = true;
    u71 = false;
    u72 = false;

    if u76 then
        u76:Disconnect();
    end;

    if u77 then
        u77:Disconnect();
    end;

    u76 = Event:Connect(function() -- Line: 484
        -- upvalues: u71 (ref), u73 (ref)
        u71 = true;
        u73 = tick();
    end);
    u77 = Event2:Connect(function() -- Line: 489
        -- upvalues: u71 (ref), u73 (ref), u72 (ref), UserInputService (ref)
        u71 = false;

        if tick() - u73 < 0.3 and (u72 or UserInputService:GetMouseDelta().Magnitude < 2) then
            u72 = not u72;
        end;
    end);
end;

function v23.disableCameraToggleInput() -- Line: 497
    -- upvalues: u75 (ref), u76 (ref), u77 (ref)
    if not u75 then
        return;
    end;

    u75 = false;

    if u76 then
        u76:Disconnect();
        u76 = nil;
    end;

    if u77 then
        u77:Disconnect();
        u77 = nil;
    end;
end;

return v23;