  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("UserInputService");
game:GetService("RunService");
local Debris = game:GetService("Debris");
local Players = game:GetService("Players");
game:GetService("Lighting");
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Controllers.CameraController);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);
local _ = require(ReplicatedStorage.Shared.AbilityUtils).createAfterImage;
require(ReplicatedStorage.AbilityBalancing);
local _ = Players.LocalPlayer;

return function(p1) -- Line: 19
    -- upvalues: SpectatorController (copy), VfxManager (copy), Debris (copy)
    local Char = p1.Char;
    local EnemyChar = p1.EnemyChar;

    if not Char then
        return;
    end;

    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    if not Char:FindFirstChild("HumanoidRootPart") then
        return;
    end;

    local v2 = script.Stomp2:Clone();
    v2.CFrame = Char.HumanoidRootPart.CFrame * CFrame.new(-1, -2, 0);
    v2.Parent = workspace.Debris;
    VfxManager.Emit(v2);
    task.wait(0.2);
    local v3 = script.Spin:Clone();
    v3.CFrame = Char.HumanoidRootPart.CFrame * CFrame.new(0, 0, 0);
    v3.Parent = workspace.Debris;
    VfxManager.Emit(v3);
    task.wait(0.6);
    local v4 = script.Fall:Clone();
    v4.CFrame = EnemyChar.HumanoidRootPart.CFrame * CFrame.new(0, 0, 0);
    v4.Parent = workspace.Debris;
    VfxManager.Emit(v4);
    Debris:AddItem(v2, 1);
    Debris:AddItem(v3, 1);
    Debris:AddItem(v4, 1);
end;