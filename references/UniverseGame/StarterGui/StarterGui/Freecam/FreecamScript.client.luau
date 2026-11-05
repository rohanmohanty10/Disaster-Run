  

 

local abs = math.abs;
local clamp = math.clamp;
local exp = math.exp;
local rad = math.rad;
local sign = math.sign;
local sqrt = math.sqrt;
local tan = math.tan;
local ContextActionService = game:GetService("ContextActionService");
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local StarterGui = game:GetService("StarterGui");
local UserInputService = game:GetService("UserInputService");
local Workspace = game:GetService("Workspace");
local GameSettings = UserSettings().GameSettings;
local LocalPlayer = Players.LocalPlayer;

if not LocalPlayer then
    Players:GetPropertyChangedSignal("LocalPlayer"):Wait();
    LocalPlayer = Players.LocalPlayer;
end;

local CurrentCamera = Workspace.CurrentCamera;
Workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function() -- Line: 31
    -- upvalues: Workspace (copy), CurrentCamera (ref)
    local CurrentCamera2 = Workspace.CurrentCamera;

    if CurrentCamera2 then
        CurrentCamera = CurrentCamera2;
    end;
end);
local success, result = pcall(function() -- Line: 40
    return UserSettings():IsUserFeatureEnabled("UserExitFreecamBreaksWithShiftlock");
end);
local u1 = success and result;
local Value = Enum.ContextActionPriority.Low.Value;
local Value2 = Enum.ContextActionPriority.High.Value;
local u2 = { Enum.KeyCode.LeftShift, Enum.KeyCode.P };
local u3 = Vector2.new(0.75, 1) * 8;
local u4 = {};
u4.__index = u4;

function u4.new(p5, p6) -- Line: 67
    -- upvalues: u4 (copy)
    local v7 = setmetatable({}, u4);
    v7.f = p5;
    v7.p = p6;
    v7.v = p6 * 0;

    return v7;
end;

function u4.Update(p8, p9, p10) -- Line: 75
    -- upvalues: exp (copy)
    local v11 = p8.f * 2 * 3.141592653589793;
    local v = p8.v;
    local v12 = p10 - p8.p;
    local v13 = exp(-v11 * p9);
    local v14 = p10 + (v * p9 - v12 * (v11 * p9 + 1)) * v13;
    p8.p = v14;
    p8.v = (v11 * p9 * (v12 * v11 - v) + v) * v13;

    return v14;
end;

function u4.Reset(p15, p16) -- Line: 92
    p15.p = p16;
    p15.v = p16 * 0;
end;

local u17 = Vector3.new();
local u18 = Vector2.new();
local u19 = 0;
local u20 = u4.new(1.5, (Vector3.new()));
local u21 = u4.new(1, Vector2.new());
local u22 = u4.new(4, 0);
local u23 = {};

local function fCurve(p24) -- Line: 115
    -- upvalues: exp (copy)
    return (exp(2 * p24) - 1) / 6.38905609893065;
end;

local function fDeadzone(p25) -- Line: 119
    -- upvalues: exp (copy)
    return (exp(2 * ((p25 - 0.15) / 0.85)) - 1) / 6.38905609893065;
end;

local function thumbstickCurve(p26) -- Line: 123
    -- upvalues: sign (copy), abs (copy), exp (copy), clamp (copy)
    return sign(p26) * clamp((exp(2 * ((abs(p26) - 0.15) / 0.85)) - 1) / 6.38905609893065, 0, 1);
end;

local u27 = {
    ButtonX = 0,
    ButtonY = 0,
    DPadDown = 0,
    DPadUp = 0,
    ButtonL2 = 0,
    ButtonR2 = 0,
    Thumbstick1 = Vector2.new(),
    Thumbstick2 = Vector2.new()
};
local u28 = {
    W = 0,
    A = 0,
    S = 0,
    D = 0,
    E = 0,
    Q = 0,
    U = 0,
    H = 0,
    J = 0,
    K = 0,
    I = 0,
    Y = 0,
    Up = 0,
    Down = 0,
    LeftShift = 0,
    RightShift = 0
};
local u29 = {
    MouseWheel = 0,
    Delta = Vector2.new()
};
local u30 = Vector2.new(1, 1) * 0.04908738521234052;
local u31 = Vector2.new(1, 1) * 0.39269908169872414;
local u32 = 1;

function u23.Vel(p33) -- Line: 174
    -- upvalues: u32 (ref), u28 (copy), clamp (copy), thumbstickCurve (ref), u27 (copy), UserInputService (copy)
    u32 = clamp(u32 + p33 * (u28.Up - u28.Down) * 0.75, 0.01, 4);
    local v34 = thumbstickCurve(u27.Thumbstick1.X);
    local v35 = thumbstickCurve(u27.ButtonR2) - thumbstickCurve(u27.ButtonL2);
    local v36 = Vector3.new(v34, v35, thumbstickCurve(-u27.Thumbstick1.Y)) * Vector3.new(1, 1, 1);
    local v37 = Vector3.new(u28.D - u28.A + u28.K - u28.H, u28.E - u28.Q + u28.I - u28.Y, u28.S - u28.W + u28.J - u28.U) * Vector3.new(1, 1, 1);
    local v38 = UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) or UserInputService:IsKeyDown(Enum.KeyCode.RightShift);

    return (v36 + v37) * (u32 * (v38 and 0.25 or 1));
end;

function u23.Pan(p39) -- Line: 194
    -- upvalues: thumbstickCurve (ref), u27 (copy), u31 (copy), u29 (copy), u30 (copy)
    local v40 = Vector2.new(thumbstickCurve(u27.Thumbstick2.Y), thumbstickCurve(-u27.Thumbstick2.X)) * u31;
    local v41 = u29.Delta * u30;
    u29.Delta = Vector2.new();

    return v40 + v41;
end;

function u23.Fov(p42) -- Line: 204
    -- upvalues: u27 (copy), u29 (copy)
    local v43 = (u27.ButtonX - u27.ButtonY) * 0.25;
    local v44 = u29.MouseWheel * 1;
    u29.MouseWheel = 0;

    return v43 + v44;
end;

local function Keypress(p45, p46, p47) -- Line: 212
    -- upvalues: u28 (copy)
    u28[p47.KeyCode.Name] = p46 == Enum.UserInputState.Begin and 1 or 0;

    return Enum.ContextActionResult.Sink;
end;

local function GpButton(p48, p49, p50) -- Line: 217
    -- upvalues: u27 (copy)
    u27[p50.KeyCode.Name] = p49 == Enum.UserInputState.Begin and 1 or 0;

    return Enum.ContextActionResult.Sink;
end;

local function MousePan(p51, p52, p53) -- Line: 222
    -- upvalues: u29 (copy)
    local Delta = p53.Delta;
    u29.Delta = Vector2.new(-Delta.y, -Delta.x);

    return Enum.ContextActionResult.Sink;
end;

local function Thumb(p54, p55, p56) -- Line: 228
    -- upvalues: u27 (copy)
    u27[p56.KeyCode.Name] = p56.Position;

    return Enum.ContextActionResult.Sink;
end;

local function Trigger(p57, p58, p59) -- Line: 233
    -- upvalues: u27 (copy)
    u27[p59.KeyCode.Name] = p59.Position.z;

    return Enum.ContextActionResult.Sink;
end;

local function MouseWheel(p60, p61, p62) -- Line: 238
    -- upvalues: u29 (copy)
    u29[p62.UserInputType.Name] = -p62.Position.z;

    return Enum.ContextActionResult.Sink;
end;

local function Zero(p63) -- Line: 243
    for i, v in pairs(p63) do
        p63[i] = v * 0;
    end;
end;

function u23.StartCapture() -- Line: 249
    -- upvalues: ContextActionService (copy), Keypress (copy), Value2 (copy), MousePan (copy), MouseWheel (copy), GpButton (copy), Trigger (copy), Thumb (copy)
    ContextActionService:BindActionAtPriority("FreecamKeyboard", Keypress, false, Value2, Enum.KeyCode.W, Enum.KeyCode.U, Enum.KeyCode.A, Enum.KeyCode.H, Enum.KeyCode.S, Enum.KeyCode.J, Enum.KeyCode.D, Enum.KeyCode.K, Enum.KeyCode.E, Enum.KeyCode.I, Enum.KeyCode.Q, Enum.KeyCode.Y, Enum.KeyCode.Up, Enum.KeyCode.Down);
    ContextActionService:BindActionAtPriority("FreecamMousePan", MousePan, false, Value2, Enum.UserInputType.MouseMovement);
    ContextActionService:BindActionAtPriority("FreecamMouseWheel", MouseWheel, false, Value2, Enum.UserInputType.MouseWheel);
    ContextActionService:BindActionAtPriority("FreecamGamepadButton", GpButton, false, Value2, Enum.KeyCode.ButtonX, Enum.KeyCode.ButtonY);
    ContextActionService:BindActionAtPriority("FreecamGamepadTrigger", Trigger, false, Value2, Enum.KeyCode.ButtonR2, Enum.KeyCode.ButtonL2);
    ContextActionService:BindActionAtPriority("FreecamGamepadThumbstick", Thumb, false, Value2, Enum.KeyCode.Thumbstick1, Enum.KeyCode.Thumbstick2);
end;

function u23.StopCapture() -- Line: 266
    -- upvalues: u32 (ref), u27 (copy), u28 (copy), u29 (copy), ContextActionService (copy)
    u32 = 1;
    local v64 = u27;

    for i, v in pairs(v64) do
        v64[i] = v * 0;
    end;

    local v65 = u28;

    for i, v in pairs(v65) do
        v65[i] = v * 0;
    end;

    local v66 = u29;

    for i, v in pairs(v66) do
        v66[i] = v * 0;
    end;

    ContextActionService:UnbindAction("FreecamKeyboard");
    ContextActionService:UnbindAction("FreecamMousePan");
    ContextActionService:UnbindAction("FreecamMouseWheel");
    ContextActionService:UnbindAction("FreecamGamepadButton");
    ContextActionService:UnbindAction("FreecamGamepadTrigger");
    ContextActionService:UnbindAction("FreecamGamepadThumbstick");
end;

local function GetFocusDistance(p67) -- Line: 281
    -- upvalues: CurrentCamera (ref), u19 (ref), tan (copy), Workspace (copy)
    local ViewportSize = CurrentCamera.ViewportSize;
    local v68 = tan(u19 / 2) * 2;
    local v69 = ViewportSize.x / ViewportSize.y * v68;
    local rightVector = p67.rightVector;
    local upVector = p67.upVector;
    local lookVector = p67.lookVector;
    local v70 = Vector3.new();
    local v71 = 512;

    for i = 0, 1, 0.5 do
        for i2 = 0, 1, 0.5 do
            local v72 = rightVector * ((i - 0.5) * v69) - upVector * ((i2 - 0.5) * v68) + lookVector;
            local v73 = p67.p + v72 * 0.1;
            local _, v74 = Workspace:FindPartOnRay(Ray.new(v73, v72.unit * v71));
            local magnitude = (v74 - v73).magnitude;

            if magnitude < v71 then
                v70 = v72.unit;
                v71 = magnitude;
            end;
        end;
    end;

    return lookVector:Dot(v70) * v71;
end;

local function StepFreecam(p75) -- Line: 313
    -- upvalues: u20 (copy), u23 (copy), u21 (copy), u22 (copy), u19 (ref), rad (copy), tan (copy), sqrt (copy), clamp (copy), u18 (ref), u3 (copy), u17 (ref), CurrentCamera (ref), GetFocusDistance (copy)
    local v76 = u20:Update(p75, u23.Vel(p75));
    local v77 = u21:Update(p75, u23.Pan(p75));
    local v78 = u22:Update(p75, u23.Fov(p75));
    local v79 = sqrt(0.7002075382097097 / tan((rad(u19 / 2))));
    u19 = clamp(u19 + v78 * 300 * (p75 / v79), 1, 120);
    u18 = u18 + v77 * u3 * (p75 / v79);
    u18 = Vector2.new(clamp(u18.x, -1.5707963267948966, 1.5707963267948966), u18.y % 6.283185307179586);
    local v80 = CFrame.new(u17) * CFrame.fromOrientation(u18.x, u18.y, 0) * CFrame.new(v76 * Vector3.new(64, 64, 64) * p75);
    u17 = v80.p;
    CurrentCamera.CFrame = v80;
    CurrentCamera.Focus = v80 * CFrame.new(0, 0, -GetFocusDistance(v80));
    CurrentCamera.FieldOfView = u19;
end;

local function CheckMouseLockAvailability() -- Line: 332
    -- upvalues: Players (copy), GameSettings (copy)
    return Players.LocalPlayer.DevEnableMouseLock and (GameSettings.ControlMode == Enum.ControlMode.MouseLockSwitch and GameSettings.ComputerMovementMode ~= Enum.ComputerMovementMode.ClickToMove) and not (Players.LocalPlayer.DevComputerMovementMode == Enum.DevComputerMovementMode.Scriptable);
end;

local u81 = {};
local u82 = nil;
local u83 = nil;
local u84 = nil;
local u85 = nil;
local u86 = nil;
local u87 = nil;
local u88 = {};
local u89 = {
    Backpack = true,
    Chat = true,
    Health = true,
    PlayerList = true
};
local u90 = {
    BadgesNotificationsActive = true,
    PointsNotificationsActive = true
};

function u81.Push() -- Line: 364
    -- upvalues: u89 (copy), StarterGui (copy), u90 (copy), LocalPlayer (ref), u88 (copy), u87 (ref), CurrentCamera (ref), u84 (ref), u86 (ref), u85 (ref), u83 (ref), UserInputService (copy), u1 (ref), Players (copy), GameSettings (copy), u82 (ref)
    for i in pairs(u89) do
        u89[i] = StarterGui:GetCoreGuiEnabled(Enum.CoreGuiType[i]);
        StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType[i], false);
    end;

    for i in pairs(u90) do
        u90[i] = StarterGui:GetCore(i);
        StarterGui:SetCore(i, false);
    end;

    local v91 = LocalPlayer:FindFirstChildOfClass("PlayerGui");

    if v91 then
        for _, child in pairs(v91:GetChildren()) do
            if child:IsA("ScreenGui") and child.Enabled then
                u88[#u88 + 1] = child;
                child.Enabled = false;
            end;
        end;
    end;

    u87 = CurrentCamera.FieldOfView;
    CurrentCamera.FieldOfView = 70;
    u84 = CurrentCamera.CameraType;
    CurrentCamera.CameraType = Enum.CameraType.Custom;
    u86 = CurrentCamera.CFrame;
    u85 = CurrentCamera.Focus;
    u83 = UserInputService.MouseIconEnabled;
    UserInputService.MouseIconEnabled = false;

    if u1 then
        if Players.LocalPlayer.DevEnableMouseLock and (GameSettings.ControlMode == Enum.ControlMode.MouseLockSwitch and GameSettings.ComputerMovementMode ~= Enum.ComputerMovementMode.ClickToMove) and not (Players.LocalPlayer.DevComputerMovementMode == Enum.DevComputerMovementMode.Scriptable) then
            u82 = Enum.MouseBehavior.Default;
        else
            u82 = UserInputService.MouseBehavior;
        end;
    else
        u82 = UserInputService.MouseBehavior;
    end;

    UserInputService.MouseBehavior = Enum.MouseBehavior.Default;
end;

function u81.Pop() -- Line: 404
    -- upvalues: u89 (copy), StarterGui (copy), u90 (copy), u88 (copy), CurrentCamera (ref), u87 (ref), u84 (ref), u86 (ref), u85 (ref), UserInputService (copy), u83 (ref), u82 (ref)
    for i, v in pairs(u89) do
        StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType[i], v);
    end;

    for i, v in pairs(u90) do
        StarterGui:SetCore(i, v);
    end;

    for _, v in pairs(u88) do
        if v.Parent then
            v.Enabled = true;
        end;
    end;

    CurrentCamera.FieldOfView = u87;
    u87 = nil;
    CurrentCamera.CameraType = u84;
    u84 = nil;
    CurrentCamera.CFrame = u86;
    u86 = nil;
    CurrentCamera.Focus = u85;
    u85 = nil;
    UserInputService.MouseIconEnabled = u83;
    u83 = nil;
    UserInputService.MouseBehavior = u82;
    u82 = nil;
end;

local function StartFreecam() -- Line: 437
    -- upvalues: CurrentCamera (ref), u18 (ref), u17 (ref), u19 (ref), u20 (copy), u21 (copy), u22 (copy), u81 (copy), RunService (copy), StepFreecam (copy), u23 (copy)
    local CFrame2 = CurrentCamera.CFrame;
    u18 = Vector2.new(CFrame2:toEulerAnglesYXZ());
    u17 = CFrame2.p;
    u19 = CurrentCamera.FieldOfView;
    u20:Reset((Vector3.new()));
    u21:Reset(Vector2.new());
    u22:Reset(0);
    u81.Push();
    RunService:BindToRenderStep("Freecam", Enum.RenderPriority.Camera.Value, StepFreecam);
    u23.StartCapture();
end;

local function StopFreecam() -- Line: 452
    -- upvalues: u23 (copy), RunService (copy), u81 (copy)
    u23.StopCapture();
    RunService:UnbindFromRenderStep("Freecam");
    u81.Pop();
end;

local u92 = false;

local function ToggleFreecam() -- Line: 463
    -- upvalues: u92 (ref), u23 (copy), RunService (copy), u81 (copy), StartFreecam (copy)
    if u92 then
        u23.StopCapture();
        RunService:UnbindFromRenderStep("Freecam");
        u81.Pop();
    else
        StartFreecam();
    end;

    u92 = not u92;
end;

local function CheckMacro(p93) -- Line: 472
    -- upvalues: UserInputService (copy), u92 (ref), u23 (copy), RunService (copy), u81 (copy), StartFreecam (copy)
    for i = 1, #p93 - 1 do
        if not UserInputService:IsKeyDown(p93[i]) then
            return;
        end;
    end;

    if u92 then
        u23.StopCapture();
        RunService:UnbindFromRenderStep("Freecam");
        u81.Pop();
    else
        StartFreecam();
    end;

    u92 = not u92;
end;

ContextActionService:BindActionAtPriority("FreecamToggle", function(p94, p95, p96) -- Line: 481, Name: HandleActivationInput
    -- upvalues: u2 (copy), CheckMacro (copy)
    if p95 == Enum.UserInputState.Begin and p96.KeyCode == u2[#u2] then
        CheckMacro(u2);
    end;

    return Enum.ContextActionResult.Pass;
end, false, Value, u2[#u2]);