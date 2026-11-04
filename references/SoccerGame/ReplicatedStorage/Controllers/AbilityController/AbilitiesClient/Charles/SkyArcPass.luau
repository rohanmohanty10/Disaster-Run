  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("Players");
game:GetService("RunService");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
game:GetService("TweenService");
game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
local Popup = require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local getPlayerTarget = require(ReplicatedStorage.Modules.getPlayerTarget);
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);

return function(u1, p2, u3) -- Line: 18, Name: SkyArcPass
    -- upvalues: Popup (copy), getPlayerTarget (copy), AbilityBalancing (copy), RunService (copy)
    if u1.AbilityOne > tick() then
        return;
    end;

    if u1.AbilityUsed > tick() then
        return;
    end;

    if u3.Humanoid:GetState() == Enum.HumanoidStateType.Jumping or u3.Humanoid:GetState() == Enum.HumanoidStateType.Freefall then
        return;
    end;

    if not u3.Values.HasBall.Value then
        Popup.Popup(p2, "You NEED the ball vro 🥀💔");

        return;
    end;

    if p2.Character.IsRagdoll.Value then
        return;
    end;

    local u4 = getPlayerTarget(false);

    if not u4 then
        Popup.Popup("U NEED A TEAMMATE TO PASS TO BRUH!!!! - SaynDev");

        return;
    end;

    u1.StatesController.States.Ability = true;

    if u1.ABC then
        u1.ABC:Clean();
    end;

    local v5 = u3:GetAttribute("DartboardLens") and 1.5 or 1;
    u1.Animations.Abilities.ContrarianPass.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Abilities.ContrarianPass:Play();
    u1.Animations.Abilities.ContrarianPass:AdjustSpeed(v5);
    u1.AbilityService.Ability:Fire("SkyArcPass", { u4 });
    u1:AbilityCooldown("1", AbilityBalancing.SkyArcPass.Cooldown);
    task.delay(1, function() -- Line: 42
        -- upvalues: u1 (copy)
        u1.StatesController.States.Ability = false;
    end);
    u1.ABC:Connect(u1.AbilityService.Ability, function(u6) -- Line: 46
        -- upvalues: u1 (copy), u3 (copy), u4 (copy), RunService (ref)
        u1.StatesController.States.Ability = false;
        local HumanoidRootPart = u3.HumanoidRootPart;
        local HumanoidRootPart2 = u4.HumanoidRootPart;
        local u7 = (HumanoidRootPart2.Position + HumanoidRootPart2.AssemblyLinearVelocity * Vector3.new(1, 0, 1) - HumanoidRootPart.Position).Unit + Vector3.new(0, 0.65, 0) + -HumanoidRootPart.CFrame.RightVector * 0.8;
        local math_clamp_ret = math.clamp((HumanoidRootPart2.Position - HumanoidRootPart.Position).Magnitude * 1.5, 0, 200);
        u6.AssemblyLinearVelocity = u7 * math_clamp_ret;
        u1.BallController:DragBall(u6);
        local u8 = tick();
        task.wait(0.2);
        u1.ABC:Connect(RunService.Heartbeat, function(p9) -- Line: 65
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