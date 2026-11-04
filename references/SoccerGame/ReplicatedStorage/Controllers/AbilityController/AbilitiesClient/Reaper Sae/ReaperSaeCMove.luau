  

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
local Popup = require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.AbilityBalancing);
local getPlayerTarget = require(ReplicatedStorage.Modules.getPlayerTarget);
local script_ScythePass = require(script.ScythePass);
local script_DeathsCall = require(script.DeathsCall);

return function(p1, p2, p3, ...) -- Line: 21
    -- upvalues: script_DeathsCall (copy), Popup (copy), getPlayerTarget (copy), script_ScythePass (copy)
    if p1.AbilityOne > tick() then
        return;
    end;

    if p1.AbilityUsed > tick() then
        return;
    end;

    if p3.Humanoid:GetState() == Enum.HumanoidStateType.Jumping or p3.Humanoid:GetState() == Enum.HumanoidStateType.Freefall then
        return;
    end;

    if p2.Character.IsRagdoll.Value then
        return;
    end;

    if p3:GetAttribute("DeathsCall") then
        script_DeathsCall(p1, p2, p3);

        return;
    end;

    if not p3.Values.HasBall.Value then
        Popup.Popup(p2, "You NEED the ball vro 🥀💔");

        return;
    end;

    local v4 = getPlayerTarget(false);

    if v4 and (p3.HumanoidRootPart.Position - v4.HumanoidRootPart.Position).Magnitude <= 380 then
        script_ScythePass(p1, p2, p3, v4);

        return;
    end;

    Popup.Popup(p2, "Requires teammate to pass to!");
end;