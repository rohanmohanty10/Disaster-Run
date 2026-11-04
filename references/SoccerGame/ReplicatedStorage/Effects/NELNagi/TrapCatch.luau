  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local Debris = game:GetService("Debris");
local Essentials = require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Controllers.CameraController);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);

return function(p1) -- Line: 12
    -- upvalues: SpectatorController (copy), SoundManager (copy), ReplicatedStorage (copy), Essentials (copy), VfxManager (copy), Debris (copy)
    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    SoundManager.SpawnSound("NELNagiTrapCatch", 0.9, p1.Char.HumanoidRootPart, 130, false);
    local v2 = script.TrapCatch:Clone();
    v2.CFrame = ReplicatedStorage.Football.Value.BallAnims.BALL.CFrame;
    v2.Parent = ReplicatedStorage.Football.Value.BallAnims.BALL;
    Essentials:Weld(v2, ReplicatedStorage.Football.Value.BallAnims.BALL);
    VfxManager.Emit(v2);
    Debris:AddItem(v2, 5);
end;