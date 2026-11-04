  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
game:GetService("Debris");
game:GetService("Lighting");
require(ReplicatedStorage.Shared.Essentials);
local EmitModule = require(ReplicatedStorage.Shared.EmitModule);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Controllers.CameraController);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);

return function(p1) -- Line: 13
    -- upvalues: SpectatorController (copy), EmitModule (copy), RunService (copy)
    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local Char = p1.Char;
    local u2 = script.StartupSimple:Clone();
    u2:PivotTo(Char.HumanoidRootPart.CFrame * CFrame.Angles(0, 1.5707963267948966, 0) * CFrame.new(0, -1.5, 0));
    u2.Parent = workspace.Debris;
    EmitModule.emit(u2);
    local v3 = RunService.Heartbeat:Connect(function() -- Line: 23
        -- upvalues: u2 (copy), Char (copy)
        u2:PivotTo(Char.HumanoidRootPart.CFrame * CFrame.Angles(0, 1.5707963267948966, 0) * CFrame.new(0, -1.5, 0));
    end);
    task.wait(0.6);
    v3:Disconnect();
    local v4 = script.Hit4Emit:Clone();
    v4.CFrame = Char.HumanoidRootPart.CFrame;
    v4.Parent = workspace.Debris;
    EmitModule.emit(v4);
    task.wait(2);
    u2:Destroy();
end;