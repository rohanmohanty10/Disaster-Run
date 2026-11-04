  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("UserInputService");
game:GetService("RunService");
game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);
local EmitModule = require(ReplicatedStorage.Shared.EmitModule);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);

return function(p1) -- Line: 14
    -- upvalues: SpectatorController (copy), EmitModule (copy)
    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local HumanoidRootPart = p1.Char.HumanoidRootPart;
    local v2 = script.Startup:Clone();
    v2:PivotTo(HumanoidRootPart.CFrame * CFrame.new(0, -2.75, 0));
    v2.Parent = workspace.Debris;
    EmitModule.emit(v2);
    task.wait(0.45);
    local v3 = script.boneflickemit2:Clone();
    v3:PivotTo(HumanoidRootPart.CFrame * CFrame.new(0, -0.5, 2) * CFrame.fromOrientation(-0.17453292519943295, 0, 0));
    v3.Parent = workspace.Debris;
    EmitModule.emit(v3);
    task.wait(0.6);
    local v4 = script.boneflickemit2:Clone();
    v4:PivotTo(HumanoidRootPart.CFrame * CFrame.new(0, -2.75, -3));
    v4.Parent = workspace.Debris;
    EmitModule.emit(v4);
    task.wait(2);
    v4:Destroy();
    v3:Destroy();
    v2:Destroy();
end;