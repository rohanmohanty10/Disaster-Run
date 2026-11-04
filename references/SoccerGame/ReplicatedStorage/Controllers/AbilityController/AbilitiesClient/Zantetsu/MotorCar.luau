  

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
local _ = AbilityUtils.Lerp;
local _ = AbilityUtils.QuadBezier;
local StatesController = require(ReplicatedStorage2.Controllers.StatesController);
local AnimationController = require(ReplicatedStorage2.Controllers.AnimationController);
require(ReplicatedStorage2.Controllers.CameraController);
local BallController = require(ReplicatedStorage2.Controllers.BallController);
local getPlayerTarget = require(ReplicatedStorage2.Modules.getPlayerTarget);
local interface = require(ReplicatedStorage2.Controllers.AbilityController.interface);
local LocalPlayer = Players.LocalPlayer;
local _ = workspace.CurrentCamera;

return function() -- Line: 33
    -- upvalues: AbilityBalancing (copy), AbilityUtils (copy), getPlayerTarget (copy), Players (copy), RunService (copy), LocalPlayer (copy), Popup (copy), interface (copy), StatesController (copy), AnimationController (copy), BallController (copy)
    local MotorCar = AbilityBalancing.MotorCar;

    if not (AbilityUtils.rules.onball() and (AbilityUtils.rules.grounded() and AbilityUtils.rules.slotReady(1))) then
        return;
    end;

    print("Used");
    local Character, u1, _, _ = AbilityUtils.getCharacter();
    getPlayerTarget(false);
    local u4 = getPlayerTarget(false, function(p2, p3) -- Line: 48
        -- upvalues: u1 (copy), MotorCar (copy), Players (ref), RunService (ref), LocalPlayer (ref)
        if p2:GetAttribute("IsTrainingDummy") then
            return (p2.HumanoidRootPart.Position - u1.Position).Magnitude < MotorCar.ActivationRangePlayer;
        end;

        local PlayerFromCharacter = Players:GetPlayerFromCharacter(p2);

        if RunService:IsStudio() then
            return true;
        end;

        if not PlayerFromCharacter then
            return false;
        end;

        if PlayerFromCharacter.Team ~= LocalPlayer.Team then
            return false;
        end;

        if p2.Values.InCutscene.Value then
            return false;
        end;

        if (p2.HumanoidRootPart.Position - u1.Position).Magnitude < MotorCar.ActivationRangePlayer then
            return true;
        end;
    end);

    if not u4 then
        Popup.Popup(LocalPlayer, "No teammate in range!");

        return;
    end;

    interface:AbilityCooldown(1, MotorCar.Cooldown);
    local ABC = interface.ABC;
    interface.MotorCar = nil;
    StatesController.States.AllowedAbility = nil;
    local Track = AnimationController:GetTrack("Abilities", "MotorCar");
    Track.Looped = false;
    Track.Priority = Enum.AnimationPriority.Action3;
    Track:Play();
    interface.AbilityService.Ability:Fire("MotorCar", { u4 });
    ABC:Connect(interface.AbilityService.Ability, function(u5) -- Line: 89
        -- upvalues: Character (copy), u4 (copy), BallController (ref), ABC (copy), RunService (ref)
        local HumanoidRootPart = Character.HumanoidRootPart;
        local HumanoidRootPart2 = u4.HumanoidRootPart;
        local u6 = (HumanoidRootPart2.Position + HumanoidRootPart2.AssemblyLinearVelocity * Vector3.new(1, 0, 1) - HumanoidRootPart.Position).Unit + Vector3.new(0, 0.1, 0) + -HumanoidRootPart.CFrame.RightVector * 0.3;
        local math_clamp_ret = math.clamp((HumanoidRootPart2.Position - HumanoidRootPart.Position).Magnitude * 2, 0, 200);
        u5.AssemblyLinearVelocity = u6 * math_clamp_ret;
        BallController:DragBall(u5);
        local u7 = tick();
        ABC:Connect(RunService.Heartbeat, function(p8) -- Line: 105
            -- upvalues: u7 (copy), u5 (copy), ABC (ref), HumanoidRootPart2 (copy), u6 (ref), math_clamp_ret (ref), HumanoidRootPart (copy)
            if tick() > u7 + 1 or (not u5 or u5.OnPlayer.Value) then
                return ABC:Clean();
            end;

            local _ = HumanoidRootPart2.AssemblyLinearVelocity * Vector3.new(1, 0, 1);
            local v9 = tick() > u7 + 0.55;
            u6 = u6:Lerp((HumanoidRootPart2.Position - u5.Position).Unit + Vector3.new(0, v9 and 0.15 or 0.35, 0), 6.5 * p8);
            math_clamp_ret = math.clamp((HumanoidRootPart2.Position - HumanoidRootPart.Position).Magnitude * 2.75, 0, 200);

            if u5.Position.Y < 5 or (HumanoidRootPart2.Position - u5.Position).Magnitude <= 7 then
                return ABC:Clean();
            end;

            u5.AssemblyLinearVelocity = u5.AssemblyLinearVelocity:Lerp(u6 * math_clamp_ret, 6.5 * p8);
        end);
    end);
end;