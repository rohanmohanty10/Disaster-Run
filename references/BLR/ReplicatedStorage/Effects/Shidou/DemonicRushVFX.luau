  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
game:GetService("TweenService");
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
    local u2 = script.Dash1:Clone();
    u2:PivotTo(Char.HumanoidRootPart.CFrame);
    u2.Parent = workspace.Debris;
    EmitModule.emit(u2);
    local v3 = RunService.Heartbeat:Connect(function() -- Line: 23
        -- upvalues: u2 (copy), Char (copy)
        u2:PivotTo(Char.Torso.CFrame);
        u2:PivotTo(Char.HumanoidRootPart.CFrame);
    end);
    task.wait(1);
    local u4 = script.Dash2:Clone();
    u4:PivotTo(Char.HumanoidRootPart.CFrame * CFrame.new(0, 1, 0) * CFrame.Angles(0, 1.5707963267948966, 0));
    u4.Parent = workspace.Debris;
    EmitModule.emit(u4);
    RunService.Heartbeat:Connect(function() -- Line: 36
        -- upvalues: u4 (copy), Char (copy)
        u4.Dash2:PivotTo(Char.HumanoidRootPart.CFrame * CFrame.Angles(-1.5707963267948966, 1.5707963267948966, 0));
        u4.Model:PivotTo(Char.HumanoidRootPart.CFrame * CFrame.new(0, 0, -5) * CFrame.Angles(1.5707963267948966, -1.5707963267948966, 0));
    end);
    task.wait(2);
    v3:Disconnect();
    u2:Destroy();
end;