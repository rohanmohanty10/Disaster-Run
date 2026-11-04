  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("Players");
game:GetService("RunService");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
game:GetService("TweenService");
game:GetService("Debris");
local Popup = require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.AbilityUtils);
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);
require(ReplicatedStorage.Shared.SoundManager);
local getPlayerTarget = require(ReplicatedStorage.Modules.getPlayerTarget);

return function(u1, p2, u3) -- Line: 16, Name: LobPass
    -- upvalues: getPlayerTarget (copy), AbilityBalancing (copy), Popup (copy), RunService (copy)
    local u4 = getPlayerTarget(true);

    if not u4 or (u4.HumanoidRootPart.Position - p2.Character.HumanoidRootPart.Position).Magnitude > AbilityBalancing.LobPass.ActivationRangePlayer then
        Popup.Popup(p2, "Need a teammate to pass to!");

        return;
    end;

    if u1.ABC then
        u1.ABC:Clean();
    end;

    local _ = u3.HumanoidRootPart;
    u3:RemoveTag("CrownHopped");
    u1:AbilityCooldown("2", AbilityBalancing.LobPass.Cooldown);
    u1.AbilityService.Ability:Fire("LobPass", { u4 });
    u1.Animations:StopAnims();
    u1.StatesController.States.Ability = true;
    u1.Animations.Abilities.LobPass.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Abilities.LobPass:Play();
    u1.Animations.Ball.LobPassBall.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Ball.LobPassBall:Play();
    u1.ABC:Add(function() -- Line: 43
        -- upvalues: u1 (copy)
        u1.StatesController.States.Ability = false;
    end);
    task.delay(1.5, function() -- Line: 47
        -- upvalues: u1 (copy)
        if u1.ABC then
            u1.ABC:Clean();
        end;
    end);
    u1.ABC:Connect(u1.AbilityService.Ability, function(u5) -- Line: 51
        -- upvalues: u4 (copy), u3 (copy), u1 (copy), RunService (ref)
        local Vector3_new_ret = Vector3.new(u4.HumanoidRootPart.AssemblyLinearVelocity.X, 0, u4.HumanoidRootPart.AssemblyLinearVelocity.Z);
        local u6 = (u4.HumanoidRootPart.Position + Vector3_new_ret - u3.HumanoidRootPart.Position).Unit + Vector3.new(0, 0.5, 0);
        local math_clamp_ret = math.clamp((u4.HumanoidRootPart.Position - u3.HumanoidRootPart.Position).Magnitude * 1.5, 0, 150);
        u5.AssemblyLinearVelocity = u6 * math_clamp_ret;
        u1.BallController:DragBall(u5);
        local u7 = tick();
        u1.ABC:Connect(RunService.Heartbeat, function(p8) -- Line: 63
            -- upvalues: u7 (copy), u1 (ref), u5 (copy), Vector3_new_ret (ref), u4 (ref), u6 (ref), math_clamp_ret (ref), u3 (ref)
            if tick() > u7 + 1.5 then
                u1.ABC:Clean();

                return;
            end;

            if u5.OnPlayer.Value then
                u1.ABC:Clean();

                return;
            end;

            if u5 == nil then
                u1.ABC:Clean();

                return;
            end;

            Vector3_new_ret = Vector3.new(u4.HumanoidRootPart.AssemblyLinearVelocity.X, 0, u4.HumanoidRootPart.AssemblyLinearVelocity.Z);

            if tick() > u7 + 0.55 then
                u6 = u6:Lerp((u4.HumanoidRootPart.Position - u5.Position).Unit + Vector3.new(0, 0.15, 0), 10 * p8);
            else
                u6 = u6:Lerp((u4.HumanoidRootPart.Position - u5.Position).Unit + Vector3.new(0, 0.1, 0), 10 * p8);
            end;

            math_clamp_ret = (u4.HumanoidRootPart.Position - u3.HumanoidRootPart.Position).Magnitude * 1.5;
            math_clamp_ret = math.clamp(math_clamp_ret, 0, 150);

            if math_clamp_ret <= 7 then
                u1.ABC:Clean();

                return;
            end;

            u5.AssemblyLinearVelocity = u5.AssemblyLinearVelocity:Lerp(u6 * math_clamp_ret, 6.5 * p8);
        end);
    end);
end;