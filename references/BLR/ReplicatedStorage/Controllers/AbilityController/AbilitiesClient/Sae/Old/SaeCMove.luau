  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("Players");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local script_OffBalance = require(script.OffBalance);
local script_ShoulderPush = require(script.ShoulderPush);
local PerfectPass = require(script.Parent.PerfectPass);
local DivineDestruction = require(script.Parent.DivineDestruction);

return function(p1, p2, p3, ...) -- Line: 21
    -- upvalues: DivineDestruction (copy), PerfectPass (copy), script_ShoulderPush (copy), script_OffBalance (copy)
    if p1.AbilityOne > tick() then
        return;
    end;

    if p1.AbilityUsed > tick() then
        return;
    end;

    if not p2.Character.IsRagdoll.Value then
        if p2.PlayerGui.InGameUI.Bottom.Abilities["1"].AbilityLabel.Text == "Divine Destruction" then
            print("play divine destruction");

            return DivineDestruction(p1, p2, p3, ...);
        end;

        if p3.Values.HasBall.Value then
            return PerfectPass(p1, p2, p3, ...);
        end;

        if p2.PlayerStats.InAwakening.Value then
            return script_ShoulderPush(p1, p2, p3, ...);
        end;

        return script_OffBalance(p1, p2, p3, ...);
    end;
end;