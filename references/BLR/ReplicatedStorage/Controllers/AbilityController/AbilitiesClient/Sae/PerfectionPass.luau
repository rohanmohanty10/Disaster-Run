  

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

    if v5 < u1.AbilityOne then
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
    u1.Animations.Abilities.PerfectionPass.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Abilities.PerfectionPass:Play();
    local X = u3.HumanoidRootPart.CFrame:vectorToObjectSpace(u3.Humanoid.MoveDirection).X;

    if X <= 0.45 then
        local _ = X < -0.45;
    end;

    print();
    u1.AbilityService.Ability:Fire("PerfectionPass", { target });
    task.delay(1, function() -- Line: 60
        -- upvalues: u1 (copy)
        u1.StatesController.States.Ability = false;
    end);
    u1.ABC:Connect(u1.AbilityService.Ability, function(u6) -- Line: 66
        -- upvalues: u1 (copy), u3 (copy), target (copy), X (copy), RunService (ref)
        u1.StatesController.States.Ability = false;
        local HumanoidRootPart = u3.HumanoidRootPart;
        local HumanoidRootPart2 = target.HumanoidRootPart;
        local u7 = (HumanoidRootPart2.Position + HumanoidRootPart2.AssemblyLinearVelocity * Vector3.new(1, 0, 1) - HumanoidRootPart.Position).Unit + Vector3.new(0, 0.35, 0) + HumanoidRootPart.CFrame.RightVector * 0.8 * X;
        local math_clamp_ret = math.clamp((HumanoidRootPart2.Position - HumanoidRootPart.Position).Magnitude * 1.5, 0, 200);
        u6.AssemblyLinearVelocity = u7 * math_clamp_ret;
        u1.BallController:DragBall(u6);
        local u8 = tick();
        task.wait(0.1);
        u1.ABC:Connect(RunService.Heartbeat, function(p9) -- Line: 85
            -- upvalues: u8 (copy), u6 (copy), u1 (ref), HumanoidRootPart2 (copy), u7 (ref), math_clamp_ret (ref), HumanoidRootPart (copy)
            if tick() > u8 + 1.25 or (not u6 or u6.OnPlayer.Value) then
                return u1.ABC:Clean();
            end;

            local _ = HumanoidRootPart2.AssemblyLinearVelocity * Vector3.new(1, 0, 1);
            local v10 = tick() > u8 + 0.55;
            u7 = u7:Lerp((HumanoidRootPart2.Position - u6.Position).Unit + Vector3.new(0, v10 and 0.15 or 0.35, 0), 6.5 * p9);
            math_clamp_ret = math.clamp((HumanoidRootPart2.Position - HumanoidRootPart.Position).Magnitude * 2.75, 0, 150);

            if u6.Position.Y < 5 or (HumanoidRootPart2.Position - u6.Position).Magnitude <= 7 then
                return u1.ABC:Clean();
            end;

            u6.AssemblyLinearVelocity = u6.AssemblyLinearVelocity:Lerp(u7 * math_clamp_ret, 6.5 * p9);
        end);
    end);
end;

return function(p11, p12, p13, ...) -- Line: 114
    -- upvalues: PerfectPass (copy)
    return PerfectPass(p11, p12, p13, ...);
end;