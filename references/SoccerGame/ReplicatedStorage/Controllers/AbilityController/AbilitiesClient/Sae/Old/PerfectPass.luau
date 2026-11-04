  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("Players");
game:GetService("RunService");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
game:GetService("TweenService");
game:GetService("Debris");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
local Popup = require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local AbilityBalancing = require(ReplicatedStorage2.AbilityBalancing);
local AbilityUtils = require(ReplicatedStorage2.Shared.AbilityUtils);

local function PerfectPass(u1, p2, u3, p4) -- Line: 19
    -- upvalues: AbilityBalancing (copy), AbilityUtils (copy), Popup (copy), RunService (copy)
    local PerfectPass = AbilityBalancing.PerfectPass;

    if not p4 then
        if not AbilityUtils.rules.friendlyTarget(PerfectPass.PassRange) then
            return;
        end;

        p4 = {
            chemReaction = false,
            target = u1.BallController.Closest
        };
    end;

    local v5 = tick();
    local target = p4.target;

    if not u3.Values.HasBall.Value then
        return;
    end;

    if not p4.chemReaction and v5 < u1.AbilityOne then
        return;
    end;

    if not target then
        return Popup.Popup(u1.Player, "No player found to pass!");
    end;

    u1.StatesController.States.Ability = true;

    if not p4.chemReaction then
        u1:AbilityCooldown("1", 25);
    end;

    if u1.ABC then
        u1.ABC:Clean();
    end;

    u1.Animations:StopAnims();
    u1.Animations.Abilities.PerfectPass.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Abilities.PerfectPass:Play();
    u1.Animations.Ball.PerfectPass.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Ball.PerfectPass:Play();
    u1.AbilityService.Ability:Fire("PerfectPass", { "PerfectPass", target, p4.chemReaction });
    task.delay(1, function() -- Line: 58
        -- upvalues: u1 (copy)
        u1.StatesController.States.Ability = false;
    end);
    u1.ABC:Connect(u1.AbilityService.Ability, function(u6, p7) -- Line: 64
        -- upvalues: u1 (copy), u3 (copy), target (copy), RunService (ref)
        u1.StatesController.States.Ability = false;
        local HumanoidRootPart = u3.HumanoidRootPart;
        local HumanoidRootPart2 = target.HumanoidRootPart;
        local u8 = (HumanoidRootPart2.Position + HumanoidRootPart2.AssemblyLinearVelocity * Vector3.new(1, 0, 1) - HumanoidRootPart.Position).Unit + Vector3.new(0, 0.5, 0);
        local math_clamp_ret = math.clamp((HumanoidRootPart2.Position - HumanoidRootPart.Position).Magnitude * 1.5, 0, 150);
        u6.AssemblyLinearVelocity = u8 * math_clamp_ret;
        u1.BallController:DragBall(u6);
        local u9 = tick();
        u1.ABC:Connect(RunService.Heartbeat, function(p10) -- Line: 82
            -- upvalues: u9 (copy), u6 (copy), u1 (ref), HumanoidRootPart2 (copy), u8 (ref), math_clamp_ret (ref), HumanoidRootPart (copy)
            if tick() > u9 + 3 or (not u6 or u6.OnPlayer.Value) then
                return u1.ABC:Clean();
            end;

            local _ = HumanoidRootPart2.AssemblyLinearVelocity * Vector3.new(1, 0, 1);
            local v11 = tick() > u9 + 0.55;
            u8 = u8:Lerp((HumanoidRootPart2.Position - u6.Position).Unit + Vector3.new(0, v11 and 0.15 or 0.35, 0), 6.5 * p10);
            math_clamp_ret = math.clamp((HumanoidRootPart2.Position - HumanoidRootPart.Position).Magnitude * 2.75, 0, 150);

            if u6.Position.Y < 5 or (HumanoidRootPart2.Position - u6.Position).Magnitude <= 7 then
                return u1.ABC:Clean();
            end;

            u6.AssemblyLinearVelocity = u6.AssemblyLinearVelocity:Lerp(u8 * math_clamp_ret, 6.5 * p10);
        end);
    end);
end;

return function(p12, p13, p14, ...) -- Line: 111
    -- upvalues: PerfectPass (copy)
    return PerfectPass(p12, p13, p14, ...);
end;