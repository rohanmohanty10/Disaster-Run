  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("Debris");
game:GetService("Lighting");
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Controllers.CameraController);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);

return function(p1) -- Line: 12
    -- upvalues: SpectatorController (copy), SoundManager (copy), VfxManager (copy), ReplicatedStorage (copy)
    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local Char = p1.Char;
    SoundManager.SpawnSound("DragonHeader", 0.7, Char.HumanoidRootPart, 130, false);
    local LocalPlayer = game.Players.LocalPlayer;
    task.wait(0.22);
    local v2 = script.dragonheaderemit05:Clone();
    v2.CFrame = Char.HumanoidRootPart.CFrame * CFrame.new(-0.31846046, -2.71664762, 0.3980732, 1, 0, 0, 0, 1, 0, 0, 0, 1);
    v2.Parent = workspace.Debris;
    VfxManager.Emit(v2);
    task.wait(0.5);
    local v3 = script.dragonheaderemit2:Clone();
    v3.CFrame = Char.HumanoidRootPart.CFrame * CFrame.new(-0.1174221, -2.71700001, 0.39789581, 1, 0, 0, 0, 1, 0, 0, 0, 1);
    v3.Parent = workspace.Debris;
    VfxManager.Emit(v3);
    task.wait(0.01);
    local v4 = script.dragonheaderemit1:Clone();
    v4.CFrame = Char.HumanoidRootPart.CFrame * CFrame.new(
        -0.31911278,
        -0.42343545,
        2.31942272,
        1,
        0,
        0,
        0,
        0.08715563,
        0.99619454,
        0,
        -0.99619466,
        0.08715599
    );
    v4.Parent = workspace.Debris;
    VfxManager.Emit(v4);
    task.wait(0.04);
    local _ = (Char.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 100;
    local v5 = script.dragonheaderhit:Clone();
    v5.CFrame = ReplicatedStorage.Football.Value.BallAnims.BALL.CFrame;
    v5.Parent = workspace.Debris;
    VfxManager.Emit(v5);
    task.wait(0.73);
    local v6 = script.dragonheaderemit3:Clone();
    v6.CFrame = Char.HumanoidRootPart.CFrame * CFrame.new(-0.41133118, -2.68983674, -1.01484394, 1, 0, 0, 0, 1, 0, 0, 0, 1);
    v6.Parent = workspace.Debris;
    VfxManager.Emit(v6);
end;