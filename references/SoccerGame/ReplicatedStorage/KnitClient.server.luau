  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Shared.LightingStorage);
local ReplicatorClient = require(ReplicatedStorage.Modules.ReplicatorClient);
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.VfxManager);
local LocalPlayer = game.Players.LocalPlayer;
task.spawn(function() -- Line: 14
    -- upvalues: LocalPlayer (copy)
    local success, result = pcall(function() -- Line: 15
        -- upvalues: LocalPlayer (ref)
        if game.PlaceId == 88233429548268 then
            local _ = LocalPlayer.UserId > 0;
        end;
    end);

    if not success then
        warn(result);
    end;
end);
local StarterGuiContainer = ReplicatedStorage:WaitForChild("StarterGuiContainer");
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");

for _, child in StarterGuiContainer:GetChildren() do
    child.Parent = PlayerGui;
end;

ReplicatorClient.init();
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
game:GetService("ContentProvider");
local UserInputService = game:GetService("UserInputService");
local TeleportService = game:GetService("TeleportService");
local ReplicatedStorage3 = game:GetService("ReplicatedStorage");
local Knit = require(ReplicatedStorage2.Packages.Knit);
local Promise = require(ReplicatedStorage2.Packages.Promise);
local environment = require(ReplicatedStorage2.Shared.environment);
require(ReplicatedStorage3.Shared.MoonCutsceneStreamer);
local SoundManager = require(ReplicatedStorage2.Shared.SoundManager);
LocalPlayer:SetAttribute("SmartBones", true);
local workspace_CurrentCamera = workspace.CurrentCamera;
local LobbyCam = workspace:WaitForChild("LoadingCutscene"):WaitForChild("LobbyCam");
local Mouse = game:GetService("Players").LocalPlayer:GetMouse();
local Popup = require(ReplicatedStorage2.Shared.Popup);
xpcall(function() -- Line: 62
    require(game.ReplicatedStorage.Shared.DebugUtil);
end, warn);
game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false);
game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false);
local ArrivingTeleportGui = TeleportService:GetArrivingTeleportGui();

if ArrivingTeleportGui ~= nil then
    ArrivingTeleportGui.Parent = game.Players.LocalPlayer.PlayerGui;
end;

repeat
    task.wait();
    workspace_CurrentCamera.CameraType = Enum.CameraType.Scriptable;
until workspace_CurrentCamera.CameraType == Enum.CameraType.Scriptable;

local v1 = workspace_CurrentCamera:GetPropertyChangedSignal("CameraType"):Connect(function() -- Line: 81
    -- upvalues: workspace_CurrentCamera (copy)
    workspace_CurrentCamera.CameraType = Enum.CameraType.Scriptable;
end);
game.SoundService:WaitForChild("SoundGroup"):WaitForChild("OST").Volume = 0.35;
game.SoundService:WaitForChild("SoundGroup"):WaitForChild("Stadium").Volume = 0;
game.Lighting:WaitForChild("Blur").Size = 0;
LocalPlayer.PlayerGui:WaitForChild("Misc", (1 / 0)):WaitForChild("Logo").Visible = true;
task.spawn(function() -- Line: 95
    -- upvalues: ReplicatedStorage3 (copy)
    local lahvinho = workspace:WaitForChild("LoadingCutscene").Model.lahvinho;
    require(ReplicatedStorage3.Shared.Emotes.New.Standard["Beach Rest"]).play(lahvinho, "VisualWorld");
end);
Popup.BlackoutLocalSemi(LocalPlayer, "Loading1", "Loading2");
Mouse.Icon = "";
local v2 = game:GetService("RunService").RenderStepped:Connect(function() -- Line: 123
    -- upvalues: workspace_CurrentCamera (copy), LobbyCam (copy), Mouse (copy)
    workspace_CurrentCamera.CFrame = LobbyCam.CFrame * CFrame.Angles(math.rad((Mouse.Y - Mouse.ViewSizeY / 2) / Mouse.ViewSizeY * -10), math.rad((Mouse.X - Mouse.ViewSizeX / 2) / Mouse.ViewSizeX * -10), 0);
end);
LocalPlayer.PlayerGui:WaitForChild("Misc"):WaitForChild("Loading").Visible = true;

if ArrivingTeleportGui ~= nil then
    ArrivingTeleportGui.Parent = nil;
    ArrivingTeleportGui = true;
end;

local v4 = Promise.new(function(p3) -- Line: 138
    -- upvalues: LocalPlayer (copy), ReplicatedStorage2 (copy)
    game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("HUD");
    game.Players.LocalPlayer.PlayerGui:WaitForChild("Mobile");
    LocalPlayer.PlayerGui:WaitForChild("Misc");

    for _, descendant in pairs(ReplicatedStorage2.Controllers:GetDescendants()) do
        if descendant:IsA("ModuleScript") then
            require(descendant);
        end;
    end;

    p3();
end):andThen(function() -- Line: 150
    -- upvalues: Knit (copy)
    return Knit.Start({
        ServicePromises = false
    });
end):catch(warn);
local v5;

if workspace:GetAttribute("liveDataAvailable") then
    v5 = Promise.resolve();
else
    v5 = Promise.new(function(p6) -- Line: 160
        workspace:GetAttributeChangedSignal("liveDataAvailable"):Once(p6);
    end);
end;

v5:await();
local v7 = {
    { "Starting client", v4 }
};

if workspace:GetAttribute("PrivateServerId") ~= "" and (workspace:GetAttribute("PrivateServerOwnerId") ~= 0 and environment.mode == "Normal") then
    local v8 = { "Teleporting to custom server", Promise.new(function() -- Line: 173
        end) };
    table.insert(v7, v8);
    LocalPlayer.PlayerGui.TPGui.Enabled = true;
    TeleportService:SetTeleportGui(LocalPlayer.PlayerGui.TPGui);
end;

for i, v in v7 do
    LocalPlayer.PlayerGui.Misc.Loading.Text = `{v[1]:upper()} ({i}/{#v7})`;
    v[2]:await();
end;

if ArrivingTeleportGui == nil then
    if UserInputService.TouchEnabled then
        LocalPlayer.PlayerGui.Misc.Loading.Text = "TOUCH ANYWHERE TO CONTINUE";
        LocalPlayer.PlayerGui.Misc.Loading.Icon.Visible = false;
    elseif UserInputService.GamepadEnabled then
        local v9 = UserInputService:GetStringForKeyCode(Enum.KeyCode.ButtonA) == "ButtonA" and "rbxassetid://117557825423309" or "rbxassetid://95717013376600";
        LocalPlayer.PlayerGui.Misc.Loading.Icon.Visible = true;
        LocalPlayer.PlayerGui.Misc.Loading.Icon.Image = v9;
        LocalPlayer.PlayerGui.Misc.Loading.Text = "PRESS TO CONTINUE";
    else
        LocalPlayer.PlayerGui.Misc.Loading.Text = "CLICK ANYWHERE TO CONTINUE";
        LocalPlayer.PlayerGui.Misc.Loading.Icon.Visible = false;
    end;

    local u10 = false;
    local v13 = UserInputService.InputBegan:Connect(function(p11, p12) -- Line: 207
        -- upvalues: u10 (ref)
        if p11.UserInputType == Enum.UserInputType.Touch or (p11.UserInputType == Enum.UserInputType.MouseButton1 or p11.UserInputType == Enum.UserInputType.Gamepad1) then
            u10 = true;
        end;
    end);

    if not (game:GetService("RunService"):IsStudio() and workspace.SPAWN_ON_PITCH.Value or (environment.mode == "Noob" or environment.config.SkipLoadingScreen)) then
        while u10 == false do
            game:GetService("RunService").RenderStepped:Wait();
        end;
    end;

    task.spawn(function() -- Line: 220
        -- upvalues: SoundManager (copy), LocalPlayer (copy)
        SoundManager.SpawnSound("Click", 0.55, LocalPlayer.PlayerGui, 1);
    end);
    game:GetService("Players").LocalPlayer:SetAttribute("FullyLoaded", true);
    v13:Disconnect();
end;

local Frame = Instance.new("Frame");
Frame.BackgroundColor3 = Color3.new(0, 0, 0);
Frame.Size = UDim2.new(1, 0, 1, 0);
Frame.Position = UDim2.new(1, 0, 0, 0);
Frame.ZIndex = 2;
Frame.Parent = LocalPlayer.PlayerGui.Misc;
game:GetService("TweenService"):Create(Frame, TweenInfo.new(0.75, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
    Position = UDim2.new(0, 0, 0, 0)
}):Play();
task.wait(0.75);
game.Lighting:WaitForChild("Blur").Size = 0;

if not LocalPlayer:GetAttribute("RankedPickPhase") then
    LocalPlayer.PlayerGui.HUD.Enabled = true;
end;

LocalPlayer.PlayerGui.Misc.CURSOR.Visible = true;
LocalPlayer.PlayerGui.Misc.Loading.Visible = false;
LocalPlayer.PlayerGui:WaitForChild("Misc"):WaitForChild("Logo").Visible = false;
task.spawn(function() -- Line: 259
    -- upvalues: LocalPlayer (copy)
    game.SoundService.SoundGroup.OST.Playing = true;
    game:GetService("TweenService"):Create(game.SoundService.SoundGroup.OST, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        Volume = 0.05
    }):Play();
    LocalPlayer.PlayerGui.Misc:FindFirstChild("Loading1"):Destroy();
    LocalPlayer.PlayerGui.Misc:FindFirstChild("Loading2"):Destroy();
end);
v2:Disconnect();
local v14 = game:GetService("TweenService"):Create(Frame, TweenInfo.new(0.75, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
    Position = UDim2.new(-1, 0, 0, 0)
});
v14:Play();
v14.Completed:Connect(function() -- Line: 276
    -- upvalues: Frame (copy)
    Frame:Destroy();
end);
v1:Disconnect();
task.spawn(function() -- Line: 281
    -- upvalues: workspace_CurrentCamera (copy)
    task.wait(0.3);
    workspace_CurrentCamera.CameraType = Enum.CameraType.Custom;
    task.wait(0.1);
    workspace_CurrentCamera.CameraType = Enum.CameraType.Custom;
end);
v14.Completed:Wait();
local Attribute = workspace:GetAttribute("loadedMessage");

if Attribute then
    Popup.Popup(LocalPlayer, Attribute);
end;

workspace:GetAttributeChangedSignal("loadedMessage"):Connect(function() -- Line: 294
    -- upvalues: Popup (copy), LocalPlayer (copy)
    local Attribute2 = workspace:GetAttribute("loadedMessage");

    if Attribute2 then
        Popup.Popup(LocalPlayer, Attribute2);
    end;
end);
ReplicatedStorage2.ClientDestroyInstance.OnClientEvent:Connect(function(p15, u16) -- Line: 301
    local v17 = p15 - workspace:GetServerTimeNow();
    task.delay(v17, function() -- Line: 303
        -- upvalues: u16 (copy)
        for _, v in u16 do
            if v and v:IsDescendantOf(game) then
                v:Destroy();
            end;
        end;
    end);
end);

for _, child in ReplicatedStorage2.ClientComponents:GetChildren() do
    local success, result = pcall(function() -- Line: 313
        -- upvalues: child (copy)
        return require(child);
    end);

    if not success then
        warn("ERROR BOOTING CLIENT COMPONENT", child.Name, result);
    end;
end;

ReplicatedStorage2.Loaded:FireServer();
script.Loaded:Fire();
game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, true);
workspace.LoadingCutscene.Parent = ReplicatedStorage2;

for _, child in ReplicatedStorage3.ClientModules.Observers:GetChildren() do
    require(child);
end;