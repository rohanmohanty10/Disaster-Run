  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("Players");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("RunService");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
local Popup = require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);

return function(p1, p2, p3) -- Line: 14, Name: Blast
    -- upvalues: Popup (copy), AbilityBalancing (copy)
    if p1.AbilityUsed > tick() then
        return;
    end;

    if p1.AbilityThree > tick() then
        return;
    end;

    if p3.IsRagdoll.Value then
        return;
    end;

    if p2.PlayerStats.InAwakening.Value == false then
        return;
    end;

    if p1.AwakenCopied and p1.AwakenCopied == script.Name then
        Popup.Popup(p2, "0 Uses left!");
        p1:AbilityCooldown("3", AbilityBalancing.Blast.Cooldown);
        print("COPIED");
        p1.AbilityService.Ability:Fire("Blast", {
            Pos = p3.HumanoidRootPart.CFrame * CFrame.fromEulerAnglesXYZ(-1.5707963267948966, 0, 0)
        });

        return;
    end;

    p1.Used = p1.Used + 1;
    Popup.Popup(p2, (`{2 - p1.Used} Use{2 - p1.Used == 1 and "" or "s"} left!`));

    if p1.Used >= 2 then
        p1.Used = 0;
        p1:AbilityCooldown("3", AbilityBalancing.Blast.Cooldown);
    else
        p1:AbilityCooldown("3", 1.5);
    end;

    p1.AbilityService.Ability:Fire("Blast", {
        Pos = p3.HumanoidRootPart.CFrame * CFrame.fromEulerAnglesXYZ(-1.5707963267948966, 0, 0)
    });
end;