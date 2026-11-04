  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("UserInputService");
local RunService = game:GetService("RunService");
game:GetService("Debris");
game:GetService("Lighting");
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);
local EmitModule = require(ReplicatedStorage.Shared.EmitModule);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);
local _ = game.Players.LocalPlayer;

return function(p1) -- Line: 17
    -- upvalues: SpectatorController (copy), EmitModule (copy), RunService (copy), VfxManager (copy)
    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local HumanoidRootPart = p1.Char.HumanoidRootPart;
    local u2 = script.dribble:Clone();
    u2:PivotTo(HumanoidRootPart.CFrame);
    u2.Parent = workspace.Debris;
    EmitModule.emit(u2);
    local v3 = RunService.Heartbeat:Connect(function() -- Line: 31
        -- upvalues: u2 (copy), HumanoidRootPart (copy)
        u2:PivotTo(HumanoidRootPart.CFrame);
    end);
    task.wait(2.3);
    EmitModule.emit(u2);
    task.wait(0.4);
    VfxManager.Enable(u2, false);
    v3:Disconnect();
    task.wait(4);
    u2:Destroy();
end;