  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("Players");
game:GetService("RunService");
game:GetService("TweenService");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
local script_GodspeedDistortion = require(script.GodspeedDistortion);
local script_GodspeedDash = require(script.GodspeedDash);
local Popup = require(ReplicatedStorage.Shared.Popup);

return function(p1, p2, p3) -- Line: 14
    -- upvalues: ReplicatedStorage2 (copy), Popup (copy), script_GodspeedDistortion (copy), script_GodspeedDash (copy)
    if p1.AbilityOne > tick() then
        return;
    end;

    if p1.AbilityUsed > tick() then
        return;
    end;

    if p2.Character.Humanoid:GetState() == Enum.HumanoidStateType.Freefall then
        return;
    end;

    if p2.Character.IsRagdoll.Value then
        return;
    end;

    local LokiDashCharges = p1.LokiDashCharges;

    if ReplicatedStorage2.Football.Value.Char.Value == nil then
        p1:AbilityCooldown("1", 1);
        Popup.Popup(p2, "Can\'t use skill on immediate reset!");

        return;
    end;

    if LokiDashCharges then
        p1.LokiDashCharges = nil;
        p1:AbilityCooldown("1", 30);
    else
        p1.LokiDashCharges = 1;
        p1:AbilityCooldown("1", 1);
        Popup.Popup(p2, "One charge left");
    end;

    if p3.Values.HasBall.Value then
        script_GodspeedDistortion(p1, p2, p3);

        return;
    end;

    script_GodspeedDash(p1, p2, p3);
end;