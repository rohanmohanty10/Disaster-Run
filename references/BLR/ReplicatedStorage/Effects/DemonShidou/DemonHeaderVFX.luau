  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("Debris");
game:GetService("Lighting");
local Essentials = require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Controllers.CameraController);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);

return function(p1) -- Line: 12
    -- upvalues: SpectatorController (copy), SoundManager (copy), VfxManager (copy), Essentials (copy)
    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local Char = p1.Char;
    SoundManager.SpawnSound("DemonHeader", 0.7, Char.HumanoidRootPart, 130, false);
    local v2 = script.Smoke2:Clone();
    v2.CFrame = Char.HumanoidRootPart.CFrame * CFrame.new(0, -2, 0);
    v2.Parent = workspace.Debris;
    VfxManager.Emit2(v2);
    task.wait(0.2);
    local v3 = script.Header:Clone();
    v3.CFrame = Char.Head.CFrame * CFrame.new(0, 3, -3);
    v3.Parent = workspace.Debris;
    Essentials:Weld(v3, Char.Head);
    VfxManager.Emit2(v3);
    task.wait(2);
    v3:Destroy();
    v2:Destroy();
end;