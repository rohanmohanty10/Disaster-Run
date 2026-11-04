  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("UserInputService");
local RunService = game:GetService("RunService");
local Debris = game:GetService("Debris");
local Players = game:GetService("Players");
local Lighting = game:GetService("Lighting");
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);
local CameraController = require(ReplicatedStorage.Controllers.CameraController);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);
local _ = require(ReplicatedStorage.Shared.AbilityUtils).createAfterImage;
local _ = Players.LocalPlayer;

return function(p1) -- Line: 18
    -- upvalues: SpectatorController (copy), VfxManager (copy), SoundManager (copy), CameraController (copy), RunService (copy), Debris (copy), Lighting (copy), TweenService (copy)
    local Char = p1.Char;

    if not Char then
        return;
    end;

    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    if p1.State ~= "Start" then
        if p1.State == "Pass" then
            SoundManager.SpawnSound("LongPass", 0.7, workspace, 150);
            local v2 = script.New.Pass:Clone();
            v2.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -2, 0);
            v2.Parent = workspace.Debris;
            VfxManager.Emit(v2);
            CameraController:Shake("Hit");
            task.wait(2);
            v2:Destroy();
        end;

        return;
    end;

    Char:FindFirstChild("Football");
    Char:FindFirstChild("BALL", true);
    local v3 = script.New.Debree:Clone();
    v3.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -1, 0) * CFrame.Angles(0, 3.141592653589793, 0);
    v3.Parent = workspace.Debris;
    VfxManager.Emit(v3);
    local u4 = script.New.Trail:Clone();
    u4:PivotTo(HumanoidRootPart.CFrame);
    u4.Parent = workspace.Debris;
    VfxManager.Enable(u4, true);
    SoundManager.SpawnSound("CQDReo", 0.7, workspace, 150);
    CameraController:Shake("Hit");
    local v5 = RunService.Heartbeat:Connect(function() -- Line: 49
        -- upvalues: u4 (copy), HumanoidRootPart (copy)
        u4:PivotTo(HumanoidRootPart.CFrame);
    end);
    task.wait(0.8);
    v3.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -1, 0) * CFrame.Angles(0, 3.141592653589793, 0);
    VfxManager.Emit(v3);
    local v6 = script.New["Charmelaon Dash"]:Clone();
    v6:PivotTo(HumanoidRootPart.CFrame);
    v6.Parent = workspace.Debris;
    VfxManager.Emit(v6);
    Debris:AddItem(v6, 2);
    CameraController:Shake("Hit");
    local Saturation = Lighting.ColorCorrection.Saturation;
    TweenService:Create(Lighting.ColorCorrection, TweenInfo.new(0.1), {
        Saturation = 0,
        TintColor = Color3.new(0.584314, 0.419608, 1)
    }):Play();
    task.wait(0.2);
    TweenService:Create(Lighting.ColorCorrection, TweenInfo.new(0.8), {
        TintColor = Color3.new(1, 1, 1),
        Saturation = Saturation
    }):Play();
    task.wait(0.2);
    VfxManager.Enable(u4, false);
    v5:Disconnect();
    task.wait(1);
    v3:Destroy();
    u4:Destroy();
end;