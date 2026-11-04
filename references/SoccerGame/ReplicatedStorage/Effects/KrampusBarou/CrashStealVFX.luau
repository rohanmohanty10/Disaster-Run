  

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
    local v2 = script.Startup:Clone();
    v2:PivotTo(HumanoidRootPart.CFrame * CFrame.new(0, -2.5, 0));
    v2.Parent = workspace.Debris;
    EmitModule.emit(v2);
    task.wait(0.3);
    local v3 = script.DashEmit:Clone();
    v3:PivotTo(HumanoidRootPart.CFrame);
    v3.Parent = workspace.Debris;
    EmitModule.emit(v3.Mesh1);
    EmitModule.emit(v3.ShootMesh);
    local u4 = script.Dash:Clone();
    u4.Parent = workspace.Debris;
    RunService.Heartbeat:Connect(function() -- Line: 40
        -- upvalues: u4 (copy), HumanoidRootPart (copy)
        u4:PivotTo(HumanoidRootPart.CFrame * CFrame.new(0, 0, -3));
    end);
    EmitModule.emit(u4);
    task.wait(2);
    v2:Destroy();
    u4:Destroy();
    v3:Destroy();
end;