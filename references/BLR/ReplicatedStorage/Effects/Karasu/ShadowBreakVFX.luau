  

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
    -- upvalues: SpectatorController (copy), EmitModule (copy), VfxManager (copy), RunService (copy)
    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local Char = p1.Char;
    local HumanoidRootPart = Char.HumanoidRootPart;

    if p1.Type == "Pass" then
        local v2 = script.ShOOT:Clone();
        v2:PivotTo(HumanoidRootPart.CFrame);
        v2.Parent = workspace.Debris;
        EmitModule.emit(v2);
        task.wait(2);
        v2:Destroy();

        return;
    end;

    local v3 = script.Startup:Clone();
    v3:PivotTo(HumanoidRootPart.CFrame);
    v3.Parent = workspace.Debris;
    EmitModule.emit(v3);
    local u4 = script.KarasuTrail:Clone();
    u4.Parent = workspace.Debris;
    VfxManager.Enable(u4, true);
    local u5 = nil;
    u5 = RunService.Heartbeat:Connect(function() -- Line: 43
        -- upvalues: u4 (copy), u5 (ref), Char (copy)
        if not (u4 and u4.Parent) then
            u5:Disconnect();
        end;

        u4:PivotTo(Char.Torso.CFrame * CFrame.new(0, 0.65, -0.25));
    end);
    task.wait(0.2);
    local v6 = script.GroundFX:Clone();
    v6:PivotTo(HumanoidRootPart.CFrame * CFrame.new(0, 0, -3));
    v6.Parent = workspace.Debris;
    EmitModule.emit(v6);
    task.wait(0.5);
    VfxManager.Enable(u4, false);
    task.wait(2);
    u5:Disconnect();
    u4:Destroy();
    v3:Destroy();
    v6:Destroy();
end;