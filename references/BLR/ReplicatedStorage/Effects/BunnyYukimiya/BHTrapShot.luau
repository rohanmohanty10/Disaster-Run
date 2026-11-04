  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("UserInputService");
game:GetService("RunService");
game:GetService("Debris");
game:GetService("Lighting");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);
local EmitModule = require(ReplicatedStorage.Shared.EmitModule);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);
local _ = game.Players.LocalPlayer;

return function(p1) -- Line: 17
    -- upvalues: SpectatorController (copy), EmitModule (copy)
    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local HumanoidRootPart = p1.Char.HumanoidRootPart;
    task.wait(0.8667);
    local v2 = script.MiniPop:Clone();
    v2:PivotTo(HumanoidRootPart.CFrame);
    v2.Parent = workspace.Debris;
    EmitModule.emit(v2);
    task.wait(0.4333);
    local v3 = script.ShotEmit:Clone();
    v3:PivotTo(HumanoidRootPart.CFrame * CFrame.new(0, -2.5, 0));
    v3.Parent = workspace.Debris;
    EmitModule.emit(v3);
    task.wait(2);
    v3:Destroy();
    v2:Destroy();
end;