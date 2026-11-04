  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Debris = game:GetService("Debris");
game:GetService("Lighting");
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Controllers.CameraController);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);

return function(u1) -- Line: 13
    -- upvalues: SpectatorController (copy), VfxManager (copy), RunService (copy), Debris (copy)
    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local Char = u1.Char;
    local u2 = script.DashVFX:Clone();
    u2:PivotTo(u1.Char.PrimaryPart.CFrame);
    u2.Parent = workspace.Debris;
    VfxManager.Enable(u2, true);
    RunService.Heartbeat:Connect(function() -- Line: 23
        -- upvalues: u1 (copy), u2 (copy)
        if not u1 then
            return;
        end;

        u2:PivotTo(u1.Char.PrimaryPart.CFrame);
    end);

    repeat
        task.wait();
    until not (Char:GetAttribute("Bloodlust") and Char.Parent);

    VfxManager.Enable(u2, false);
    Debris:AddItem(u2, 1);
end;