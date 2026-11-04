  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("UserInputService");
local RunService = game:GetService("RunService");
game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);
local EmitModule = require(ReplicatedStorage.Shared.EmitModule);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);

return function(p1) -- Line: 14
    -- upvalues: SpectatorController (copy), EmitModule (copy), RunService (copy)
    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local HumanoidRootPart = p1.Char.HumanoidRootPart;
    local v2 = script.Jump:Clone();
    v2:PivotTo(HumanoidRootPart.CFrame * CFrame.new(0, -2.5, 0));
    v2.Parent = workspace.Debris;
    EmitModule.emit(v2);
    task.wait(0.25);
    local u3 = script.ShotEmit:Clone();
    u3.Parent = workspace.Debris;
    RunService.Heartbeat:Connect(function() -- Line: 33
        -- upvalues: u3 (copy), HumanoidRootPart (copy)
        u3:PivotTo(HumanoidRootPart.CFrame);
    end);
    EmitModule.emit(u3);
    task.wait(2);
    v2:Destroy();
    u3:Destroy();
end;