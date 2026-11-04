  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("Players");
game:GetService("RunService");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
local Popup = require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);

return function(u1, p2, u3) -- Line: 15
    -- upvalues: AbilityBalancing (copy), Popup (copy), RunService (copy)
    if u1.AbilityTwo > tick() then
        return;
    end;

    if u3.Values.HasBall.Value then
        return;
    end;

    if p2.PlayerStats.Stamina.Value <= AbilityBalancing.SlitherStep.Stamina then
        Popup.Popup(p2, "Not enough stamina!");

        return;
    end;

    if u1.ABC then
        u1.ABC:Clean();
    end;

    u1:AbilityCooldown("2", AbilityBalancing.SlitherStep.Cooldown);
    u1.StaminaService.DecreaseStamina:Fire(AbilityBalancing.SlitherStep.Stamina);
    u1.Animations:StopAnims();
    u1.Animations.Abilities.Ambush1.Priority = Enum.AnimationPriority.Action;
    u1.Animations.Abilities.Ambush1:Play();
    u1.AbilityService.Ability:Fire("SlitherStep");
    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.Parent = u3.HumanoidRootPart;
    BodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000);
    u1.ABC:Add(BodyVelocity);
    local MoveSpeedValue = AbilityBalancing.SlitherStep.MoveSpeedValue;
    local LookVector = u3.HumanoidRootPart.CFrame.LookVector;
    u1.ABC:Connect(RunService.Heartbeat, function(p4) -- Line: 47
        -- upvalues: BodyVelocity (copy), LookVector (copy), MoveSpeedValue (ref), u3 (copy), u1 (copy)
        BodyVelocity.Velocity = LookVector * MoveSpeedValue;
        MoveSpeedValue = MoveSpeedValue - p4 * 60;

        if MoveSpeedValue <= 50 or u3.IsRagdoll.Value then
            u1.ABC:Destroy();
        end;
    end);
    task.wait(AbilityBalancing.SlitherStep.MoveSpeedDuration);
    u1.ABC:Clean();
    u1.Animations.Abilities.Ambush1:Stop();
end;