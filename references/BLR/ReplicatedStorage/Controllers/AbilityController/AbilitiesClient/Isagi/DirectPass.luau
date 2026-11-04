  

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
require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local DirectPass = require(ReplicatedStorage.AbilityBalancing).DirectPass;

return function(u1, p2, p3) -- Line: 16, Name: DirectPass
    -- upvalues: DirectPass (copy), RunService (copy)
    if u1.BallController.Closest == nil then
        return;
    end;

    if u1.AbilityTwo > tick() then
        return;
    end;

    if u1.ABC then
        u1.ABC:Clean();
    end;

    if u1.BallController.Closest == nil then
        return;
    end;

    local Closest = u1.BallController.Closest;
    u1:AbilityCooldown("2", DirectPass.Cooldown);
    u1.Animations:StopAnims();
    u1.Animations.Shots.Shoot.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Shots.Shoot:Play();
    u1.Humrp = p3.HumanoidRootPart;
    u1.AbilityService.Ability:Fire("DirectPass");
    u1.ABC:Connect(u1.AbilityService.Ability, function(u4) -- Line: 35
        -- upvalues: Closest (copy), u1 (copy), RunService (ref)
        local Vector3_new_ret = Vector3.new(Closest.HumanoidRootPart.AssemblyLinearVelocity.X, 0, Closest.HumanoidRootPart.AssemblyLinearVelocity.Z);
        local u5 = (Closest.HumanoidRootPart.Position + Vector3_new_ret - u1.Humrp.Position).Unit + Vector3.new(0, 0.1, 0);
        local math_clamp_ret = math.clamp((Closest.HumanoidRootPart.Position - u1.Humrp.Position).Magnitude * 1.5, 0, 150);
        u4.AssemblyLinearVelocity = u5 * math_clamp_ret;
        u1.BallController:DragBall(u4);
        local u6 = tick();
        u1.ABC:Connect(RunService.Heartbeat, function(p7) -- Line: 49
            -- upvalues: u4 (copy), u1 (ref), u6 (copy), Vector3_new_ret (ref), Closest (ref), u5 (ref), math_clamp_ret (ref)
            if u4.OnPlayer.Value then
                u1.ABC:Clean();

                return;
            end;

            if tick() > u6 + 0.5 then
                u1.ABC:Clean();

                return;
            end;

            Vector3_new_ret = Vector3.new(Closest.HumanoidRootPart.AssemblyLinearVelocity.X, 0, Closest.HumanoidRootPart.AssemblyLinearVelocity.Z);
            u5 = u5:Lerp((Closest.HumanoidRootPart.Position + Vector3_new_ret - u4.Position).Unit + Vector3.new(0, 0.3, 0), 1.5);
            math_clamp_ret = (Closest.HumanoidRootPart.Position - u1.Humrp.Position).Magnitude * 2;
            math_clamp_ret = math.clamp(math_clamp_ret, 0, 150);

            if math_clamp_ret <= 40 then
                u1.ABC:Clean();

                return;
            end;

            u4.AssemblyLinearVelocity = u4.AssemblyLinearVelocity:Lerp(u5 * math_clamp_ret, 1);
        end);
    end);
    task.delay(1, function() -- Line: 66
        -- upvalues: u1 (copy)
        if u1.ABC then
            u1.ABC:Clean();
        end;
    end);
end;