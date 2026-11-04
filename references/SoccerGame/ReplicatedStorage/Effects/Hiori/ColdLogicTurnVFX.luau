  

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

    if p1.Dash then
        return;
    end;

    local u2 = script.SideToSideDribble:Clone();
    u2:PivotTo(HumanoidRootPart.CFrame);
    u2.Parent = workspace.Debris;
    EmitModule.emit(u2);
    local v3 = RunService.Heartbeat:Connect(function() -- Line: 31
        -- upvalues: u2 (copy), HumanoidRootPart (copy)
        u2:PivotTo(HumanoidRootPart.CFrame);
    end);
    task.wait(0.6);
    local v4 = script.Dash1:Clone();
    v4:PivotTo(HumanoidRootPart.CFrame);
    v4.Parent = workspace.Debris;
    EmitModule.emit(v4);
    task.wait(0.1);
    v3:Disconnect();
    task.wait(1);
    local v5 = script.Dash2:Clone();
    v5:PivotTo(HumanoidRootPart.CFrame);
    v5.Parent = workspace.Debris;
    EmitModule.emit(v5);
    task.wait(1.1);
    local v6 = script.Dash3:Clone();
    v6:PivotTo(HumanoidRootPart.CFrame);
    v6.Parent = workspace.Debris;
    EmitModule.emit(v6);
    task.wait(2);
    v6:Destroy();
    u2:Destroy();
    v4:Destroy();
    v5:Destroy();
end;