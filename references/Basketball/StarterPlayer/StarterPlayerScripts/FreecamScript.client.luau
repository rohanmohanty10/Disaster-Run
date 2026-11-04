 
 

local math_abs = math.abs;
local math_clamp = math.clamp;
local math_exp = math.exp;
local math_rad = math.rad;
local math_sign = math.sign;
local math_sqrt = math.sqrt;
local math_tan = math.tan;
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
Workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function() -- Line: 32
    -- upvalues: Workspace (copy), CurrentCamera (ref)
    local CurrentCamera2 = Workspace.CurrentCamera;

    if CurrentCamera2 then
        CurrentCamera = CurrentCamera2;
    end;
end);
local success, result = pcall(function() -- Line: 41
    return UserSettings():IsUserFeatureEnabled("UserExitFreecamBreaksWithShiftlock");
end);
local u1 = success and result;
local success2, result2 = pcall(function() -- Line: 49
    return UserSettings():IsUserFeatureEnabled("UserShowGuiHideToggles");
end);
local u2 = success2 and result2;
local Value = Enum.ContextActionPriority.Low.Value;
local Value2 = Enum.ContextActionPriority.High.Value;
local u3 = { Enum.KeyCode.LeftShift, Enum.KeyCode.P };
local u4 = Vector2.new(0.75, 1) * 8;
local u5 = {};
u5.__index = u5;

function u5.new(p6, p7) -- Line: 77
    -- upvalues: u5 (copy)
    local v8 = setmetatable({}, u5);
    v8.f = p6;
    v8.p = p7;
    v8.v = p7 * 0;

    return v8;
end;

function u5.Update(p9, p10, p11) -- Line: 85
    -- upvalues: math_exp (copy)
    local v12 = p9.f * 2 * 3.141592653589793;
    local v = p9.v;
    local v13 = p11 - p9.p;
    local v14 = math_exp(-v12 * p10);
    local v15 = p11 + (v * p10 - v13 * (v12 * p10 + 1)) * v14;
    p9.p = v15;
    p9.v = (v12 * p10 * (v13 * v12 - v) + v) * v14;

    return v15;
end;

function u5.Reset(p16, p17) -- Line: 102
    p16.p = p17;
    p16.v = p17 * 0;
end;

local Vector3_new_ret = Vector3.new();
local Vector2_new_ret = Vector2.new();
local u18 = 0;
local u19 = u5.new(1.5, (Vector3.new()));
local u20 = u5.new(1, Vector2.new());
local u21 = u5.new(4, 0);
local u22 = {};

local function fCurve(p23) -- Line: 125
    -- upvalues: math_exp (copy)
    return (math_exp(2 * p23) - 1) / 6.38905609893065;
end;

local function fDeadzone(p24) -- Line: 129
    -- upvalues: math_exp (copy)
    return (math_exp(2 * ((p24 - 0.15) / 0.85)) - 1) / 6.38905609893065;
end;

local function thumbstickCurve(p25) -- Line: 133
    -- upvalues: math_sign (copy), math_abs (copy), math_exp (copy), math_clamp (copy)
    return math_sign(p25) * math_clamp((math_exp(2 * ((math_abs(p25) - 0.15) / 0.85)) - 1) / 6.38905609893065, 0, 1);
end;

local u26 = {
    ButtonX = 0,
    ButtonY = 0,
    DPadDown = 0,
    DPadUp = 0,
    ButtonL2 = 0,
    ButtonR2 = 0,
    Thumbstick1 = Vector2.new(),
    Thumbstick2 = Vector2.new()
};
local u27 = {
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
local u28 = {
    MouseWheel = 0,
    Delta = Vector2.new()
};
local u29 = Vector2.new(1, 1) * 0.04908738521234052;
local u30 = Vector2.new(1, 1) * 0.39269908169872414;
local u31 = 1;

function u22.Vel(p32) -- Line: 184
    -- upvalues: u31 (ref), u27 (copy), math_clamp (copy), thumbstickCurve (ref), u26 (copy), UserInputService (copy)
    u31 = math_clamp(u31 + p32 * (u27.Up - u27.Down) * 0.75, 0.01, 4);
    local v33 = thumbstickCurve(u26.Thumbstick1.X);
    local v34 = thumbstickCurve(u26.ButtonR2) - thumbstickCurve(u26.ButtonL2);
    local v35 = Vector3.new(v33, v34, thumbstickCurve(-u26.Thumbstick1.Y)) * Vector3.new(1, 1, 1);
    local v36 = Vector3.new(u27.D - u27.A + u27.K - u27.H, u27.E - u27.Q + u27.I - u27.Y, u27.S - u27.W + u27.J - u27.U) * Vector3.new(1, 1, 1);
    local v37 = UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) or UserInputService:IsKeyDown(Enum.KeyCode.RightShift);

    return (v35 + v36) * (u31 * (v37 and 0.25 or 1));
end;

function u22.Pan(p38) -- Line: 204
    -- upvalues: thumbstickCurve (ref), u26 (copy), u30 (copy), u28 (copy), u29 (copy)
    local v39 = Vector2.new(thumbstickCurve(u26.Thumbstick2.Y), thumbstickCurve(-u26.Thumbstick2.X)) * u30;
    local v40 = u28.Delta * u29;
    u28.Delta = Vector2.new();

    return v39 + v40;
end;

function u22.Fov(p41) -- Line: 214
    -- upvalues: u26 (copy), u28 (copy)
    local v42 = (u26.ButtonX - u26.ButtonY) * 0.25;
    local v43 = u28.MouseWheel * 1;
    u28.MouseWheel = 0;

    return v42 + v43;
end;

local function Keypress(p44, p45, p46) -- Line: 222
    -- upvalues: u27 (copy)
    u27[p46.KeyCode.Name] = p45 == Enum.UserInputState.Begin and 1 or 0;

    return Enum.ContextActionResult.Sink;
end;

local function GpButton(p47, p48, p49) -- Line: 227
    -- upvalues: u26 (copy)
    u26[p49.KeyCode.Name] = p48 == Enum.UserInputState.Begin and 1 or 0;

    return Enum.ContextActionResult.Sink;
end;

local function MousePan(p50, p51, p52) -- Line: 232
    -- upvalues: u28 (copy)
    local Delta = p52.Delta;
    u28.Delta = Vector2.new(-Delta.y, -Delta.x);

    return Enum.ContextActionResult.Sink;
end;

local function Thumb(p53, p54, p55) -- Line: 238
    -- upvalues: u26 (copy)
    u26[p55.KeyCode.Name] = p55.Position;

    return Enum.ContextActionResult.Sink;
end;

local function Trigger(p56, p57, p58) -- Line: 243
    -- upvalues: u26 (copy)
    u26[p58.KeyCode.Name] = p58.Position.z;

    return Enum.ContextActionResult.Sink;
end;

local function MouseWheel(p59, p60, p61) -- Line: 248
    -- upvalues: u28 (copy)
    u28[p61.UserInputType.Name] = -p61.Position.z;

    return Enum.ContextActionResult.Sink;
end;

local function Zero(p62) -- Line: 253
    for i, v in pairs(p62) do
        p62[i] = v * 0;
    end;
end;

function u22.StartCapture() -- Line: 259
    -- upvalues: ContextActionService (copy), Keypress (copy), Value2 (copy), MousePan (copy), MouseWheel (copy), GpButton (copy), Trigger (copy), Thumb (copy)
    ContextActionService:BindActionAtPriority("FreecamKeyboard", Keypress, false, Value2, Enum.KeyCode.W, Enum.KeyCode.U, Enum.KeyCode.A, Enum.KeyCode.H, Enum.KeyCode.S, Enum.KeyCode.J, Enum.KeyCode.D, Enum.KeyCode.K, Enum.KeyCode.E, Enum.KeyCode.I, Enum.KeyCode.Q, Enum.KeyCode.Y, Enum.KeyCode.Up, Enum.KeyCode.Down);
    ContextActionService:BindActionAtPriority("FreecamMousePan", MousePan, false, Value2, Enum.UserInputType.MouseMovement);
    ContextActionService:BindActionAtPriority("FreecamMouseWheel", MouseWheel, false, Value2, Enum.UserInputType.MouseWheel);
    ContextActionService:BindActionAtPriority("FreecamGamepadButton", GpButton, false, Value2, Enum.KeyCode.ButtonX, Enum.KeyCode.ButtonY);
    ContextActionService:BindActionAtPriority("FreecamGamepadTrigger", Trigger, false, Value2, Enum.KeyCode.ButtonR2, Enum.KeyCode.ButtonL2);
    ContextActionService:BindActionAtPriority("FreecamGamepadThumbstick", Thumb, false, Value2, Enum.KeyCode.Thumbstick1, Enum.KeyCode.Thumbstick2);
end;

function u22.StopCapture() -- Line: 276
    -- upvalues: u31 (ref), u26 (copy), u27 (copy), u28 (copy), ContextActionService (copy)
    u31 = 1;
    local v63 = u26;

    for i, v in pairs(v63) do
        v63[i] = v * 0;
    end;

    local v64 = u27;

    for i, v in pairs(v64) do
        v64[i] = v * 0;
    end;

    local v65 = u28;

    for i, v in pairs(v65) do
        v65[i] = v * 0;
    end;

    ContextActionService:UnbindAction("FreecamKeyboard");
    ContextActionService:UnbindAction("FreecamMousePan");
    ContextActionService:UnbindAction("FreecamMouseWheel");
    ContextActionService:UnbindAction("FreecamGamepadButton");
    ContextActionService:UnbindAction("FreecamGamepadTrigger");
    ContextActionService:UnbindAction("FreecamGamepadThumbstick");
end;

local function StepFreecam(p66) -- Line: 293
    -- upvalues: u19 (copy), u22 (copy), u20 (copy), u21 (copy), u18 (ref), math_rad (copy), math_tan (copy), math_sqrt (copy), math_clamp (copy), Vector2_new_ret (ref), u4 (copy), Vector3_new_ret (ref), CurrentCamera (ref)
    local v67 = u19:Update(p66, u22.Vel(p66));
    local v68 = u20:Update(p66, u22.Pan(p66));
    local v69 = u21:Update(p66, u22.Fov(p66));
    local v70 = math_sqrt(0.7002075382097097 / math_tan((math_rad(u18 / 2))));
    u18 = math_clamp(u18 + v69 * 300 * (p66 / v70), 1, 120);
    Vector2_new_ret = Vector2_new_ret + v68 * u4 * (p66 / v70);
    Vector2_new_ret = Vector2.new(math_clamp(Vector2_new_ret.x, -1.5707963267948966, 1.5707963267948966), Vector2_new_ret.y % 6.283185307179586);
    local v71 = CFrame.new(Vector3_new_ret) * CFrame.fromOrientation(Vector2_new_ret.x, Vector2_new_ret.y, 0) * CFrame.new(v67 * Vector3.new(64, 64, 64) * p66);
    Vector3_new_ret = v71.p;
    CurrentCamera.CFrame = v71;
    CurrentCamera.Focus = v71;
    CurrentCamera.FieldOfView = u18;
end;

local function CheckMouseLockAvailability() -- Line: 312
    -- upvalues: Players (copy), GameSettings (copy)
    return Players.LocalPlayer.DevEnableMouseLock and (GameSettings.ControlMode == Enum.ControlMode.MouseLockSwitch and GameSettings.ComputerMovementMode ~= Enum.ComputerMovementMode.ClickToMove) and not (Players.LocalPlayer.DevComputerMovementMode == Enum.DevComputerMovementMode.Scriptable);
end;

local u72 = {};
local u73 = nil;
local u74 = nil;
local u75 = nil;
local u76 = nil;
local u77 = nil;
local u78 = nil;
local u79 = {};
local u80 = {
    Backpack = true,
    Chat = true,
    Health = true,
    PlayerList = true
};
local u81 = {
    BadgesNotificationsActive = true,
    PointsNotificationsActive = true
};

function u72.Push() -- Line: 344
    -- upvalues: u80 (copy), StarterGui (copy), u81 (copy), LocalPlayer (ref), u79 (copy), u78 (ref), CurrentCamera (ref), u75 (ref), u77 (ref), u76 (ref), u74 (ref), UserInputService (copy), u1 (ref), Players (copy), GameSettings (copy), u73 (ref)
    for i in pairs(u80) do
        u80[i] = StarterGui:GetCoreGuiEnabled(Enum.CoreGuiType[i]);
        StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType[i], false);
    end;

    for i in pairs(u81) do
        u81[i] = StarterGui:GetCore(i);
        StarterGui:SetCore(i, false);
    end;

    local v82 = LocalPlayer:FindFirstChildOfClass("PlayerGui");

    if v82 then
        for _, child in pairs(v82:GetChildren()) do
            if child:IsA("ScreenGui") and child.Enabled then
                u79[#u79 + 1] = child;
                child.Enabled = false;
            end;
        end;
    end;

    u78 = CurrentCamera.FieldOfView;
    CurrentCamera.FieldOfView = 70;
    u75 = CurrentCamera.CameraType;
    CurrentCamera.CameraType = Enum.CameraType.Custom;
    u77 = CurrentCamera.CFrame;
    u76 = CurrentCamera.Focus;
    u74 = UserInputService.MouseIconEnabled;
    UserInputService.MouseIconEnabled = false;

    if u1 then
        if Players.LocalPlayer.DevEnableMouseLock and (GameSettings.ControlMode == Enum.ControlMode.MouseLockSwitch and GameSettings.ComputerMovementMode ~= Enum.ComputerMovementMode.ClickToMove) and not (Players.LocalPlayer.DevComputerMovementMode == Enum.DevComputerMovementMode.Scriptable) then
            u73 = Enum.MouseBehavior.Default;
        else
            u73 = UserInputService.MouseBehavior;
        end;
    else
        u73 = UserInputService.MouseBehavior;
    end;

    UserInputService.MouseBehavior = Enum.MouseBehavior.Default;
end;

function u72.Pop() -- Line: 384
    -- upvalues: u80 (copy), StarterGui (copy), u81 (copy), u79 (copy), CurrentCamera (ref), u78 (ref), u75 (ref), u77 (ref), u76 (ref), UserInputService (copy), u74 (ref), u73 (ref)
    for i, v in pairs(u80) do
        StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType[i], v);
    end;

    for i, v in pairs(u81) do
        StarterGui:SetCore(i, v);
    end;

    for _, v in pairs(u79) do
        if v.Parent then
            v.Enabled = true;
        end;
    end;

    CurrentCamera.FieldOfView = u78;
    u78 = nil;
    CurrentCamera.CameraType = u75;
    u75 = nil;
    CurrentCamera.CFrame = u77;
    u77 = nil;
    CurrentCamera.Focus = u76;
    u76 = nil;
    UserInputService.MouseIconEnabled = u74;
    u74 = nil;
    UserInputService.MouseBehavior = u73;
    u73 = nil;
end;

local function StartFreecam() -- Line: 417
    -- upvalues: u2 (ref), CurrentCamera (ref), Vector2_new_ret (ref), Vector3_new_ret (ref), u18 (ref), u19 (copy), u20 (copy), u21 (copy), u72 (copy), RunService (copy), StepFreecam (copy), u22 (copy)
    if u2 then
        script:SetAttribute("FreecamEnabled", true);
    end;

    local CFrame2 = CurrentCamera.CFrame;
    Vector2_new_ret = Vector2.new(CFrame2:toEulerAnglesYXZ());
    Vector3_new_ret = CFrame2.p;
    u18 = CurrentCamera.FieldOfView;
    u19:Reset((Vector3.new()));
    u20:Reset(Vector2.new());
    u21:Reset(0);
    u72.Push();
    RunService:BindToRenderStep("Freecam", Enum.RenderPriority.Camera.Value, StepFreecam);
    u22.StartCapture();
end;

local function StopFreecam() -- Line: 436
    -- upvalues: u2 (ref), u22 (copy), RunService (copy), u72 (copy)
    if u2 then
        script:SetAttribute("FreecamEnabled", false);
    end;

    u22.StopCapture();
    RunService:UnbindFromRenderStep("Freecam");
    u72.Pop();
end;

local u83 = false;

local function ToggleFreecam() -- Line: 451
    -- upvalues: u83 (ref), u2 (ref), u22 (copy), RunService (copy), u72 (copy), StartFreecam (copy)
    if u83 then
        if u2 then
            script:SetAttribute("FreecamEnabled", false);
        end;

        u22.StopCapture();
        RunService:UnbindFromRenderStep("Freecam");
        u72.Pop();
    else
        StartFreecam();
    end;

    u83 = not u83;
end;

local function CheckMacro(p84) -- Line: 460
    -- upvalues: UserInputService (copy), u83 (ref), u2 (ref), u22 (copy), RunService (copy), u72 (copy), StartFreecam (copy)
    for i = 1, #p84 - 1 do
        if not UserInputService:IsKeyDown(p84[i]) then
            return;
        end;

        local _ = i;
    end;

    if u83 then
        if u2 then
            script:SetAttribute("FreecamEnabled", false);
        end;

        u22.StopCapture();
        RunService:UnbindFromRenderStep("Freecam");
        u72.Pop();
    else
        StartFreecam();
    end;

    u83 = not u83;
end;

ContextActionService:BindActionAtPriority("FreecamToggle", function(p85, p86, p87) -- Line: 469, Name: HandleActivationInput
    -- upvalues: u3 (copy), CheckMacro (copy)
    if p86 == Enum.UserInputState.Begin and p87.KeyCode == u3[#u3] then
        CheckMacro(u3);
    end;

    return Enum.ContextActionResult.Pass;
end, false, Value, u3[#u3]);

if u2 then
    script:SetAttribute("FreecamEnabled", u83);
    script:GetAttributeChangedSignal("FreecamEnabled"):Connect(function() -- Line: 482
        -- upvalues: u83 (ref), StartFreecam (copy), u2 (ref), u22 (copy), RunService (copy), u72 (copy)
        local Attribute = script:GetAttribute("FreecamEnabled");

        if typeof(Attribute) == "boolean" then
            if Attribute ~= u83 then
                if Attribute then
                    StartFreecam();
                    u83 = true;

                    return;
                end;

                if u2 then
                    script:SetAttribute("FreecamEnabled", false);
                end;

                u22.StopCapture();
                RunService:UnbindFromRenderStep("Freecam");
                u72.Pop();
                u83 = false;
            end;

            return;
        end;

        script:SetAttribute("FreecamEnabled", u83);
    end);
end;