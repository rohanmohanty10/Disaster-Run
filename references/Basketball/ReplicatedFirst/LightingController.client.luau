 
 

local ReplicatedFirst = game:GetService("ReplicatedFirst");
game:GetService("RunService");
local UserInputService = game:GetService("UserInputService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ContentProvider");
local TweenService = game:GetService("TweenService");
local TeleportService = game:GetService("TeleportService");
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local StarterGui = game:GetService("StarterGui");
local Lighting = game:GetService("Lighting");
local workspace_CurrentCamera = workspace.CurrentCamera;
local LocalPlayer = Players.LocalPlayer;
local Mouse = LocalPlayer:GetMouse();
local LoadingScreen = script:WaitForChild("LoadingScreen");
LoadingScreen.Parent = LocalPlayer:WaitForChild("PlayerGui");
StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, false);
local ArrivingTeleportGui = TeleportService:GetArrivingTeleportGui();

if ArrivingTeleportGui then
    ArrivingTeleportGui.Parent = LocalPlayer.PlayerGui;
else
    local Teleporting = ReplicatedStorage:WaitForChild("Assets"):WaitForChild("UI"):WaitForChild("Teleporting");
    local BG = Teleporting:WaitForChild("BG");
    BG:WaitForChild("Overlay");
    BG:WaitForChild("Spinner");
    BG:WaitForChild("Text");
    ArrivingTeleportGui = Teleporting:Clone();
end;

RunService.PreRender:Connect(function(p1) -- Line: 36
    -- upvalues: ArrivingTeleportGui (ref)
    if ArrivingTeleportGui.Parent == nil then
        return;
    end;

    local Spinner = ArrivingTeleportGui.BG.Spinner;
    Spinner.Rotation = Spinner.Rotation + 720 * p1;
end);
TeleportService:SetTeleportGui(ArrivingTeleportGui);

if workspace:GetAttribute("TransitionServer") then
    ArrivingTeleportGui.Parent = LocalPlayer.PlayerGui;

    return;
end;

LocalPlayer:GetAttributeChangedSignal("IsTeleporting"):Connect(function() -- Line: 48
    -- upvalues: ArrivingTeleportGui (ref), LocalPlayer (copy)
    ArrivingTeleportGui.Parent = LocalPlayer.PlayerGui;
end);
LocalPlayer.OnTeleport:Connect(function(p2) -- Line: 52
    -- upvalues: ArrivingTeleportGui (ref), LocalPlayer (copy)
    if p2 == Enum.TeleportState.RequestedFromServer then
        ArrivingTeleportGui.Parent = LocalPlayer.PlayerGui;
    end;
end);
ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("VFX").OnClientEvent:Connect(function() -- Line: 58
end);
ReplicatedFirst:RemoveDefaultLoadingScreen();
local v3;

repeat
    v3 = pcall(function() -- Line: 63
        -- upvalues: StarterGui (copy)
        StarterGui:SetCore("ResetButtonCallback", false);
    end);
    task.wait();
until v3;

local function Lerp(p4, p5, p6, p7) -- Line: 70
    return p5 + (p4 - p5) * math.exp(-p6 * p7);
end;

local u8 = 0;
local u9 = 0;
local ClockTime = Lighting.ClockTime;
local u13 = RunService.RenderStepped:Connect(function(p10: number) -- Line: 79
    -- upvalues: Mouse (copy), u8 (ref), u9 (ref), workspace_CurrentCamera (copy), Lighting (copy), ClockTime (ref)
    local v11 = (Mouse.Y / Mouse.ViewSizeY - 0.5) * 3.141592653589793 * -0.05;
    local v12 = (Mouse.X / Mouse.ViewSizeX - 0.5) * 3.141592653589793 * -0.05;
    u8 = v11 + (u8 - v11) * math.exp(-3 * p10);
    u9 = v12 + (u9 - v12) * math.exp(-3 * p10);
    local CFrame_fromEulerAnglesYXZ_ret = CFrame.fromEulerAnglesYXZ(u8, u9, 0);
    workspace_CurrentCamera.CameraType = Enum.CameraType.Scriptable;
    workspace_CurrentCamera.CFrame = script:WaitForChild("LoadingScreenCamera").Value * CFrame_fromEulerAnglesYXZ_ret;
    workspace_CurrentCamera.FieldOfView = script:WaitForChild("LoadingScreenFOV").Value;
    local Value = script:WaitForChild("LoadingScreenClockTime").Value;

    if math.round(Lighting.ClockTime * 10) ~= math.round(Value * 10) then
        ClockTime = Lighting.ClockTime;
        Lighting.ClockTime = Value;
    end;
end);
local script_promise = require(script.promise);
local v14 = {};
local u15 = nil;
local v16 = LoadingScreen.Skip.MouseButton1Click:Once(function() -- Line: 108
    -- upvalues: u15 (ref)
    u15:cancel();
end);
LoadingScreen.ClickToPlay.Text = "LOADING GAME..";
LoadingScreen.ClickToPlay.TextTransparency = 1;
LoadingScreen.ClickToPlay.UIStroke.Transparency = 1;
LoadingScreen.Skip.Visible = false;
local u17 = false;
local TweenInfo_new_ret = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, -1, true);
TweenService:Create(LoadingScreen.ClickToPlay, TweenInfo_new_ret, {
    TextTransparency = 0
}):Play();
TweenService:Create(LoadingScreen.ClickToPlay.UIStroke, TweenInfo_new_ret, {
    Transparency = 0
}):Play();
local v18 = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("FullProfile").OnClientEvent:Connect(function() -- Line: 128
    -- upvalues: u17 (ref)
    u17 = true;
end);
task.delay(5, function() -- Line: 132
    -- upvalues: u17 (ref)
    if not u17 then
        u17 = true;
    end;
end);
local u19 = nil;
table.insert(v14, script_promise.new(function(p20) -- Line: 140
    -- upvalues: u19 (ref), ReplicatedFirst (copy)
    u19 = ReplicatedFirst.Characters:Clone();
    u19.Parent = workspace;

    for _, child in u19:GetChildren() do
        local Humanoid = child:FindFirstChild("Humanoid");

        if Humanoid then
            local AnimBall = child:FindFirstChild("AnimBall");

            if AnimBall then
                local v21 = child:FindFirstChildWhichIsA("Animation");

                if v21 then
                    Humanoid.Animator:LoadAnimation(v21):Play();
                end;

                local v22 = AnimBall:FindFirstChildWhichIsA("Animation");

                if v22 then
                    AnimBall.AnimationController.Animator:LoadAnimation(v22):Play();
                end;
            end;
        end;
    end;

    return p20();
end));
table.insert(v14, script_promise.new(function(p23) -- Line: 166
    while not game:IsLoaded() do
        game.Loaded:Wait();
    end;

    p23();
end));
u15 = script_promise.allSettled(v14);

while not ReplicatedFirst.KnitReady.Value do
    ReplicatedFirst.KnitReady.Changed:Wait();
end;

while not u17 do
    task.wait(0.1);
end;

if LocalPlayer.Team ~= game.Teams.Visitor then
    task.wait(3);
end;

ArrivingTeleportGui.Parent = nil;
local u24 = nil;
local v27 = UserInputService.InputBegan:Connect(function(p25, p26) -- Line: 193
    -- upvalues: u24 (ref)
    if p26 then
        return;
    end;

    if p25.UserInputType == Enum.UserInputType.MouseButton1 or (p25.UserInputType == Enum.UserInputType.Touch or (p25.KeyCode == Enum.KeyCode.Return or (p25.KeyCode == Enum.KeyCode.ButtonA or (p25.KeyCode == Enum.KeyCode.ButtonB or (p25.KeyCode == Enum.KeyCode.ButtonX or (p25.KeyCode == Enum.KeyCode.ButtonY or (p25.KeyCode == Enum.KeyCode.ButtonL2 or p25.KeyCode == Enum.KeyCode.ButtonR2))))))) then
        u24 = true;
    end;
end);
LoadingScreen.ClickToPlay.Text = "CLICK ANYWHERE TO CONTINUE";

while not u24 and LocalPlayer.Team == game.Teams.Visitor do
    task.wait(0.1);
end;

LoadingScreen.Skip.Visible = true;
u15:await();
v18:Disconnect();
v16:Disconnect();
v27:Disconnect();
LoadingScreen.ClickToPlay.Text = "LOADED!";
LoadingScreen.Skip.Visible = false;
local BindableEvent = Instance.new("BindableEvent");
BindableEvent.Event:Connect(function() -- Line: 219
    -- upvalues: LocalPlayer (copy), StarterGui (copy), BindableEvent (copy)
    while workspace:GetAttribute("ServerType") == nil do
        workspace:GetAttributeChangedSignal("ServerType"):Wait();
    end;

    local Attribute = workspace:GetAttribute("ServerType");

    if Attribute == "Match-3v3" or (Attribute == "Match-2v2" or Attribute == "Match-1v1") then
        return;
    end;

    LocalPlayer.Character.Humanoid.Health = 0;

    if LocalPlayer.Team ~= game.Teams.Visitor then
        StarterGui:SetCore("ResetButtonCallback", false);
        task.delay(60, function() -- Line: 236
            -- upvalues: StarterGui (ref), BindableEvent (ref)
            StarterGui:SetCore("ResetButtonCallback", BindableEvent);
        end);
    end;
end);
StarterGui:SetCore("ResetButtonCallback", BindableEvent);
(function() -- Line: 244, Name: finishLoading
    -- upvalues: TweenService (copy), LoadingScreen (copy), u13 (copy), u19 (ref), workspace_CurrentCamera (copy), Lighting (copy), ClockTime (ref), StarterGui (copy)
    TweenService:Create(LoadingScreen.ClickToPlay, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        TextTransparency = 1
    }):Play();
    TweenService:Create(LoadingScreen.ClickToPlay.UIStroke, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Transparency = 1
    }):Play();
    TweenService:Create(LoadingScreen.BlackOut, TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
        BackgroundTransparency = 0
    }):Play();
    task.wait(1);
    u13:Disconnect();
    LoadingScreen.BarTop.Visible = false;
    LoadingScreen.BarBottom.Visible = false;
    LoadingScreen.Logo.Visible = false;

    if u19 then
        u19:Destroy();
    end;

    script.Parent.InLoadingScreen.Value = false;
    workspace_CurrentCamera.FieldOfView = 70;
    workspace_CurrentCamera.CameraType = Enum.CameraType.Custom;
    Lighting.ClockTime = ClockTime;
    TweenService:Create(LoadingScreen.BlackOut, TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
        BackgroundTransparency = 1
    }):Play();
    task.wait(0.5);
    LoadingScreen:Destroy();

    if workspace:FindFirstChild("LoadingScreen") then
        workspace.LoadingScreen:Destroy();
    end;

    StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, true);
end)();