 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local Players = game:GetService("Players");
game:GetService("UserInputService");
local LocalPlayer = Players.LocalPlayer;
local CameraShaker = require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Knit = require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.Essentials);
local Part_Icles = require(ReplicatedStorage.Shared.Utility.Part_Icles);
local ForgeVFX = require(ReplicatedStorage.Shared.Utility.ForgeVFX);
require(ReplicatedStorage.Shared.Utility.Trove);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local v1 = Knit.CreateController({
    Name = "EffectController"
});
local u2 = nil;

function v1.KnitStart(u3) -- Line: 22
    -- upvalues: u2 (ref), Knit (copy), ReplicatedStorage (copy), LocalPlayer (copy), CameraShaker (copy), Effects (copy), Part_Icles (copy), ForgeVFX (copy)
    u2 = Knit.GetController("CameraController");
    u3.MovementController = Knit.GetController("MovementController");
    u3.AbilityController = Knit.GetController("AbilityController");
    u3.BallController = Knit.GetController("BallController");
    u3.Animations = Knit.GetController("AnimationController");
    u3.CameraController = u2;
    u3.Pass = Knit.GetController("PassController");
    u3.Network = Knit.GetController("Network");
    u3.AbilityService = Knit.GetService("AbilityService");
    u3.BallService = Knit.GetService("BallService");
    ReplicatedStorage.Remotes.VFX.OnClientEvent:Connect(function(p4, p5) -- Line: 35
        -- upvalues: LocalPlayer (ref), u3 (copy)
        if LocalPlayer.Team == game.Teams.Visitor and not LocalPlayer.PlayerGui.Spectate.Enabled then
            return;
        end;

        require(p4)(u3, p5);
    end);
    ReplicatedStorage.Remotes.Ability.OnClientEvent:Connect(function(p6) -- Line: 41
        -- upvalues: u3 (copy)
        require(p6)(u3.AbilityController);
    end);
    ReplicatedStorage.Remotes.GoalEffect.OnClientEvent:Connect(function(p7, p8) -- Line: 45
        -- upvalues: LocalPlayer (ref), u3 (copy)
        if LocalPlayer.Team == game.Teams.Visitor and not (p8.Locker or LocalPlayer.PlayerGui.Spectate.Enabled) then
            return;
        end;

        require(p7)(u3, p8);
    end);
    ReplicatedStorage.Remotes.ShotEffect.OnClientEvent:Connect(function(p9, p10) -- Line: 51
        -- upvalues: LocalPlayer (ref), u3 (copy)
        if LocalPlayer.Team == game.Teams.Visitor and not (p10.Locker or LocalPlayer.PlayerGui.Spectate.Enabled) then
            return;
        end;

        require(p9)(u3, p10);
    end);
    ReplicatedStorage.Remotes.ShakeCam.OnClientEvent:Connect(function(p11) -- Line: 57
        -- upvalues: u2 (ref), CameraShaker (ref)
        u2.CamShake:Shake(CameraShaker.Presets[p11]);
    end);
    ReplicatedStorage.Remotes.Popup.OnClientEvent:Connect(function(...) -- Line: 61
        -- upvalues: Effects (ref)
        Effects:Popup(...);
    end);
    Part_Icles:Activate();
    ForgeVFX:init();
end;

return v1;