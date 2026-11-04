 
 

local ContextActionService = game:GetService("ContextActionService");
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local UserInputService = game:GetService("UserInputService");
local packets = require(ReplicatedStorage.packets);
local LocalPlayer = Players.LocalPlayer;
local workspace_CurrentCamera = workspace.CurrentCamera;
local Value = Enum.ContextActionPriority.High.Value;
local u1 = false;
local u2 = 0;
local u3 = 0.25;
local u4 = 16;
local u5 = 1;
local u6 = 0;
local u7 = false;
local u8 = nil;
local u9 = nil;
local u10 = nil;
local u11 = nil;
local u12 = nil;
local u13 = nil;
local u14 = {
    W = false,
    A = false,
    S = false,
    D = false
};
local v15 = {};

local function getWorldWishDir() -- Line: 45
    -- upvalues: u14 (copy), workspace_CurrentCamera (copy)
    local v16 = Vector3.new(0, 0, 0);

    if u14.W then
        v16 = v16 - Vector3.new(0, 0, 1);
    end;

    if u14.S then
        v16 = v16 + Vector3.new(0, 0, 1);
    end;

    if u14.A then
        v16 = v16 - Vector3.new(1, 0, 0);
    end;

    if u14.D then
        v16 = v16 + Vector3.new(1, 0, 0);
    end;

    if v16.Magnitude < 0.01 then
        return Vector3.new(0, 0, 0);
    end;

    local Vector3_new_ret = Vector3.new(workspace_CurrentCamera.CFrame.LookVector.X, 0, workspace_CurrentCamera.CFrame.LookVector.Z);
    local v17 = Vector3_new_ret.Magnitude < 0.01 and Vector3.new(0, 0, -1) or Vector3_new_ret.Unit;
    local Unit = v17:Cross(Vector3.new(0, 1, 0)).Unit;

    return (v17 * -v16.Z + Unit * v16.X).Unit;
end;

local function getEffectiveSpeedMult() -- Line: 66
    -- upvalues: u5 (ref), UserInputService (copy)
    local v18 = u5;

    if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) or UserInputService:IsKeyDown(Enum.KeyCode.RightShift) then
        v18 = v18 * 0.35;
    end;

    return v18;
end;

local function sendInput() -- Line: 74
    -- upvalues: ReplicatedStorage (copy), packets (copy), getWorldWishDir (copy), workspace_CurrentCamera (copy), u5 (ref), UserInputService (copy), u6 (ref)
    if not ReplicatedStorage:FindFirstChild("CFBall") then
        return;
    end;

    local send = packets.bytenet_ballControlInput.send;
    local v19 = {
        wishDir = getWorldWishDir(),
        look = workspace_CurrentCamera.CFrame.LookVector
    };
    local v20 = u5;

    if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) or UserInputService:IsKeyDown(Enum.KeyCode.RightShift) then
        v20 = v20 * 0.35;
    end;

    v19.speedMult = v20;
    v19.flags = u6;
    send(v19);
    u6 = 0;
end;

local function updateCamera(p21: number) -- Line: 88
    -- upvalues: ReplicatedStorage (copy), u8 (ref), u2 (ref), u3 (ref), u4 (ref), u9 (ref), workspace_CurrentCamera (copy)
    local CFBall = ReplicatedStorage:FindFirstChild("CFBall");

    if not CFBall then
        return;
    end;

    local Position = CFBall.Value.Position;

    if not u8 then
        u8 = Position;
    end;

    u8 = u8:Lerp(Position, 1 - math.exp(p21 * -28));
    local v22 = u8 + Vector3.new(0, 0.85, 0);
    local v23 = v22 + (CFrame.Angles(0, u2, 0) * CFrame.Angles(u3, 0, 0)).LookVector * -u4;
    local CFrame_lookAt_ret = CFrame.lookAt(v23, v22);

    if not u9 then
        u9 = CFrame_lookAt_ret;
    end;

    u9 = u9:Lerp(CFrame_lookAt_ret, 1 - math.exp(p21 * -10));
    workspace_CurrentCamera.CameraType = Enum.CameraType.Scriptable;
    workspace_CurrentCamera.CFrame = u9;
    workspace_CurrentCamera.Focus = CFrame.new(v22);
end;

local function onKeypress(p24, p25, p26) -- Line: 116
    -- upvalues: u6 (ref), u14 (copy)
    if p25 == Enum.UserInputState.Begin then
        if p26.KeyCode == Enum.KeyCode.Space then
            u6 = u6 + 1;
        elseif p26.KeyCode == Enum.KeyCode.Q then
            u6 = u6 + 4;
        elseif p26.KeyCode == Enum.KeyCode.E then
            u6 = u6 + 2;
        elseif p26.KeyCode == Enum.KeyCode.R then
            u6 = u6 + 8;
        elseif p26.KeyCode == Enum.KeyCode.W then
            u14.W = true;
        elseif p26.KeyCode == Enum.KeyCode.A then
            u14.A = true;
        elseif p26.KeyCode == Enum.KeyCode.S then
            u14.S = true;
        elseif p26.KeyCode == Enum.KeyCode.D then
            u14.D = true;
        end;
    elseif p25 == Enum.UserInputState.End then
        if p26.KeyCode == Enum.KeyCode.W then
            u14.W = false;
        elseif p26.KeyCode == Enum.KeyCode.A then
            u14.A = false;
        elseif p26.KeyCode == Enum.KeyCode.S then
            u14.S = false;
        elseif p26.KeyCode == Enum.KeyCode.D then
            u14.D = false;
        end;
    end;

    return Enum.ContextActionResult.Sink;
end;

local function onMouseButton(p27, p28, p29) -- Line: 149
    -- upvalues: u7 (ref), UserInputService (copy)
    if p29.UserInputType == Enum.UserInputType.MouseButton2 then
        u7 = p28 == Enum.UserInputState.Begin;
        UserInputService.MouseBehavior = u7 and Enum.MouseBehavior.LockCurrentPosition or Enum.MouseBehavior.Default;
    end;

    return Enum.ContextActionResult.Sink;
end;

local function onMousePan(p30, p31, p32) -- Line: 158
    -- upvalues: u7 (ref), u2 (ref), u3 (ref)
    if not u7 or p31 ~= Enum.UserInputState.Change then
        return Enum.ContextActionResult.Pass;
    end;

    local Delta = p32.Delta;
    u2 = u2 - Delta.X * 0.003;
    u3 = math.clamp(u3 - Delta.Y * 0.003, -0.35, 1.15);

    return Enum.ContextActionResult.Sink;
end;

local function onMouseWheel(p33, p34, p35) -- Line: 169
    -- upvalues: UserInputService (copy), u5 (ref), u4 (ref)
    if p34 ~= Enum.UserInputState.Change then
        return Enum.ContextActionResult.Pass;
    end;

    local Z = p35.Position.Z;

    if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or UserInputService:IsKeyDown(Enum.KeyCode.RightControl) then
        u5 = math.clamp(u5 + Z * 0.12, 0.4, 4);
    else
        u4 = math.clamp(u4 - Z * 1.25, 7, 45);
    end;

    return Enum.ContextActionResult.Sink;
end;

local function bindActions() -- Line: 187
    -- upvalues: ContextActionService (copy), onKeypress (copy), Value (copy), onMouseButton (copy), onMousePan (copy), onMouseWheel (copy)
    ContextActionService:BindActionAtPriority("BallControlKeys", onKeypress, false, Value, Enum.KeyCode.W, Enum.KeyCode.A, Enum.KeyCode.S, Enum.KeyCode.D, Enum.KeyCode.Space, Enum.KeyCode.LeftShift, Enum.KeyCode.RightShift, Enum.KeyCode.Q, Enum.KeyCode.E, Enum.KeyCode.R);
    ContextActionService:BindActionAtPriority("BallControlMouseButton", onMouseButton, false, Value, Enum.UserInputType.MouseButton2);
    ContextActionService:BindActionAtPriority("BallControlMousePan", onMousePan, false, Value, Enum.UserInputType.MouseMovement);
    ContextActionService:BindActionAtPriority("BallControlMouseWheel", onMouseWheel, false, Value, Enum.UserInputType.MouseWheel);
end;

local function unbindActions() -- Line: 205
    -- upvalues: ContextActionService (copy)
    ContextActionService:UnbindAction("BallControlKeys");
    ContextActionService:UnbindAction("BallControlMouseButton");
    ContextActionService:UnbindAction("BallControlMousePan");
    ContextActionService:UnbindAction("BallControlMouseWheel");
end;

local function step(p36: number) -- Line: 212
    -- upvalues: updateCamera (copy), sendInput (copy)
    updateCamera(p36);
    sendInput();
end;

function v15.stop() -- Line: 217
    -- upvalues: u1 (ref), RunService (copy), ContextActionService (copy), u7 (ref), u8 (ref), u9 (ref), u5 (ref), u6 (ref), u14 (copy), LocalPlayer (copy), workspace_CurrentCamera (copy), u11 (ref), UserInputService (copy), u10 (ref), u12 (ref), u13 (ref)
    u1 = false;
    RunService:UnbindFromRenderStep("BallControl");
    ContextActionService:UnbindAction("BallControlKeys");
    ContextActionService:UnbindAction("BallControlMouseButton");
    ContextActionService:UnbindAction("BallControlMousePan");
    ContextActionService:UnbindAction("BallControlMouseWheel");
    u7 = false;
    u8 = nil;
    u9 = nil;
    u5 = 1;
    u6 = 0;
    table.clear(u14);
    local Character = LocalPlayer.Character;

    if Character then
        Character = Character:FindFirstChildOfClass("Humanoid");
    end;

    workspace_CurrentCamera.CameraType = Enum.CameraType.Custom;

    if Character then
        workspace_CurrentCamera.CameraSubject = Character;
    elseif u11 then
        workspace_CurrentCamera.CameraSubject = u11;
    end;

    UserInputService.MouseBehavior = Enum.MouseBehavior.Default;
    UserInputService.MouseIconEnabled = true;
    u10 = nil;
    u11 = nil;
    u12 = nil;
    u13 = nil;
end;

function v15.start() -- Line: 249
    -- upvalues: u1 (ref), u10 (ref), workspace_CurrentCamera (copy), u11 (ref), u12 (ref), UserInputService (copy), u13 (ref), ReplicatedStorage (copy), u8 (ref), u2 (ref), bindActions (copy), RunService (copy), step (copy)
    if u1 then
        return;
    end;

    u1 = true;
    u10 = workspace_CurrentCamera.CameraType;
    u11 = workspace_CurrentCamera.CameraSubject;
    u12 = UserInputService.MouseBehavior;
    u13 = UserInputService.MouseIconEnabled;
    UserInputService.MouseBehavior = Enum.MouseBehavior.Default;
    UserInputService.MouseIconEnabled = true;
    local CFBall = ReplicatedStorage:FindFirstChild("CFBall");

    if CFBall then
        u8 = CFBall.Value.Position;
        u2 = select(2, CFBall.Value:ToEulerAnglesYXZ());
    end;

    bindActions();
    RunService:BindToRenderStep("BallControl", Enum.RenderPriority.Camera.Value, step);
end;

function v15.isActive() -- Line: 273
    -- upvalues: u1 (ref)
    return u1;
end;

return v15;