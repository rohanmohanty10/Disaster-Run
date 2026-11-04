  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("UserInputService");
local RunService = game:GetService("RunService");
game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);
local EmitModule = require(ReplicatedStorage.Shared.EmitModule);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);

return function(p1) -- Line: 14
    -- upvalues: SpectatorController (copy), EmitModule (copy), RunService (copy), VfxManager (copy)
    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local HumanoidRootPart = p1.Char.HumanoidRootPart;
    task.wait(0.1);
    local v2 = script.Startup:Clone();
    v2:PivotTo(HumanoidRootPart.CFrame * CFrame.new(0, -2.5, 0));
    v2.Parent = workspace.Debris;
    EmitModule.emit(v2);
    task.wait(0.5);
    local v3 = script.startup2:Clone();
    v3:PivotTo(HumanoidRootPart.CFrame);
    v3.Parent = workspace.Debris;
    EmitModule.emit(v3);
    task.wait(0.6);
    local u4 = script.Dash:Clone();
    u4.Parent = workspace.Debris;
    local v5 = RunService.Heartbeat:Connect(function() -- Line: 43
        -- upvalues: u4 (copy), HumanoidRootPart (copy)
        u4:PivotTo(HumanoidRootPart.CFrame);
    end);
    VfxManager.Enable(u4, true);
    task.wait(0.5);
    VfxManager.Enable(u4, false);
    v5:Disconnect();

    for _, descendant in pairs(u4:GetDescendants()) do
        if descendant:IsA("Trail") then
            descendant.Enabled = false;
        end;
    end;

    task.wait(2);
    v2:Destroy();
    u4:Destroy();
    v3:Destroy();
end;