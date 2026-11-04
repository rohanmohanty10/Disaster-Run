  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("UserInputService");
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
game:GetService("TweenService");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
local Popup = require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local AbilityBalancing = require(ReplicatedStorage2.AbilityBalancing);
local AbilityUtils = require(ReplicatedStorage2.Shared.AbilityUtils);
require(ReplicatedStorage2.Controllers.StatesController);
require(ReplicatedStorage2.Controllers.AnimationController);
require(ReplicatedStorage2.Controllers.CameraController);
require(ReplicatedStorage2.Controllers.BallController);
require(ReplicatedStorage2.Modules.getPlayerTarget);
require(ReplicatedStorage2.Controllers.AbilityController.interface);
local _ = Players.LocalPlayer;
local _ = workspace.CurrentCamera;

return function(u1, p2, u3, u4) -- Line: 29, Name: ChameleonDefense
    -- upvalues: AbilityBalancing (copy), AbilityUtils (copy), Popup (copy), RunService (copy)
    local ChameleonDefense = AbilityBalancing.ChameleonDefense;
    print(AbilityUtils.rules.grounded(p2, false));

    if AbilityUtils.rules.grounded(p2, false) then
        Popup.Popup(p2, "Must be in air!");
        print("Need to be grounded");

        return;
    end;

    if not (AbilityUtils.rules.offball() and AbilityUtils.rules.slotReady(3)) then
        return;
    end;

    local u5 = false;
    print("defending");
    u1.AbilityService.Ability:Fire("ChameleonDefense", u4);
    u1.StatesController.States.Ability = true;
    u1.StatesController.OwnWalkState = true;
    u1.ABC:Connect(u1.AbilityService.Ability, function(u6) -- Line: 57
        -- upvalues: u4 (copy), u3 (copy), u1 (copy), RunService (ref), ChameleonDefense (copy), u5 (ref)
        if u6 then
            if not u4 then
                u6.AssemblyLinearVelocity = (workspace.CurrentCamera.CFrame.LookVector + Vector3.new(0, 0.1, 0)) * 85;
                u1.BallController:DragBall(u6);

                return;
            end;

            local Vector3_new_ret = Vector3.new(u4.HumanoidRootPart.AssemblyLinearVelocity.X, 0, u4.HumanoidRootPart.AssemblyLinearVelocity.Z);
            local u7 = (u4.HumanoidRootPart.Position + Vector3_new_ret - u3.HumanoidRootPart.Position).Unit + Vector3.new(0, 0.05, 0);
            u6.AssemblyLinearVelocity = u7 * math.clamp((u4.HumanoidRootPart.Position - u3.HumanoidRootPart.Position).Magnitude * 1.5, 0, 150);
            u1.BallController:DragBall(u6);
            local u8 = tick();
            local v9 = workspace:GetRealPhysicsFPS() / 60;
            local math_clamp_ret = math.clamp(v9, 1, 4);
            u1.ABC:Connect(RunService.Heartbeat, function(p10) -- Line: 76
                -- upvalues: u8 (copy), math_clamp_ret (ref), u1 (ref), u6 (copy), u7 (ref), u4 (ref), u3 (ref)
                if tick() > u8 + 0.4 * math_clamp_ret then
                    u1.ABC:Clean();

                    return;
                end;

                if u6.OnPlayer.Value or not u6 then
                    u1.ABC:Clean();

                    return;
                end;

                local v11 = 1 - math.exp(-6.5 * p10);
                local v12 = tick() > u8 + 0.15 * math_clamp_ret and Vector3.new(0, 0.1, 0) or Vector3.new(0, 0.25, 0);
                u7 = u7:Lerp((u4.HumanoidRootPart.Position - u6.Position).Unit + v12, v11);
                local math_clamp_ret2 = math.clamp((u4.HumanoidRootPart.Position - u3.HumanoidRootPart.Position).Magnitude * 3.5, 0, 220);

                if math_clamp_ret2 <= 7 then
                    u1.ABC:Clean();

                    return;
                end;

                u6.AssemblyLinearVelocity = u6.AssemblyLinearVelocity:Lerp(u7 * math_clamp_ret2, v11);
            end);

            return;
        end;

        u1:AbilityCooldown("3", ChameleonDefense.Cooldown);
        u1.Animations:StopAnims();
        u5 = true;
        u1.Animations.Abilities.ChameleonDefense.Priority = Enum.AnimationPriority.Action4;
        u1.Animations.Abilities.ChameleonDefense:Play();
        task.wait(1.4);
        u1.ABC:Clean();
        u1.Animations.Abilities.ChameleonDefense:Stop();
        u1.StatesController.States.Ability = false;
        u1.StatesController.OwnWalkState = false;
    end);
    task.delay(0.3, function() -- Line: 134
        -- upvalues: u5 (ref), u1 (copy)
        if u5 == false then
            u1.StatesController.States.Ability = false;
            u1.StatesController.OwnWalkState = false;
            u1.ABC:Clean();
        end;
    end);
end;