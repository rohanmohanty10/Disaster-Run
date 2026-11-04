  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);
local EmitModule = require(ReplicatedStorage.Shared.EmitModule);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);

return function(p1) -- Line: 12
    -- upvalues: SpectatorController (copy), EmitModule (copy)
    local HumanoidRootPart = p1.Char:FindFirstChild("HumanoidRootPart");

    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local v2 = script.StartupSimple:Clone();
    v2.Parent = workspace.Debris;
    v2:PivotTo(HumanoidRootPart.CFrame * CFrame.new(0, -2.5, 0));
    EmitModule.emit(v2);
    task.wait(0.5);
    local v3 = script.Shot:Clone();
    v3.Parent = workspace.Debris;
    v3:PivotTo(HumanoidRootPart.CFrame * CFrame.new(0, 0, -3) * CFrame.fromOrientation(-1.5707963267948966, 0, 0));
    EmitModule.emit(v3);
    task.wait(2);
    v3:Destroy();
    v2:Destroy();
end;