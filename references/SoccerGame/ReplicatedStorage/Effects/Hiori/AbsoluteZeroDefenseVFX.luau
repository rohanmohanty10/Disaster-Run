  

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

    if p1.Type == "Pass" then
        local v2 = script.Shot:Clone();
        v2:PivotTo(HumanoidRootPart.CFrame);
        v2.Parent = workspace.Debris;
        EmitModule.emit(v2);
        task.wait(2);
        v2:Destroy();

        return;
    end;

    local v3 = script.DelayedSnowflake:Clone();
    v3:PivotTo(HumanoidRootPart.CFrame * CFrame.new(0, -2.5, 0));
    v3.Parent = workspace.Debris;
    EmitModule.emit(v3);
    task.wait(2);
    v3:Destroy();
end;