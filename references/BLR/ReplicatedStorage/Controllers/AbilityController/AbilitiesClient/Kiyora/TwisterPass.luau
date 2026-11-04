  

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
    -- upvalues: AbilityBalancing (copy), AbilityUtils (copy), interface (copy), LocalPlayer (copy), StatesController (copy), AnimationController (copy), getPlayerTarget (copy), Players (copy), Popup (copy), BallController (copy), RunService (copy)
    local TwisterPass = AbilityBalancing.TwisterPass;

    if not (AbilityUtils.rules.grounded() and AbilityUtils.rules.slotReady(2)) then
        return;
    end;

    local Character, u1, _, _ = AbilityUtils.getCharacter();
    local ABC = interface.ABC;

    if not AbilityUtils.rules.onball(LocalPlayer, false) then
        StatesController.States.Ability = true;
        StatesController.OwnWalkState = true;
        local u2 = true;
        interface:AbilityCooldown(2, TwisterPass.Cooldown);
        interface.AbilityService.Ability:Fire("TwisterPass");
        local Track = AnimationController:GetTrack("Abilities", "TwisterPassSteal");
        Track.Looped = false;
        Track.Priority = Enum.AnimationPriority.Action3;
        Track:Play();
        ABC:Add(task.delay(0.3, function() -- Line: 62
            -- upvalues: u1 (copy), AbilityUtils (ref), Character (copy), TwisterPass (copy), ABC (copy)
            local LookVector = u1.CFrame.LookVector;
            local v3, v4 = AbilityUtils.FastDashTo(Character, u1.Position + Vector3.new(LookVector.X, 0, LookVector.Z) * TwisterPass.TravelDistance, 2, 0.4);
            ABC:Add(v3);
            ABC:Add(v4);
        end));
        ABC:Add(function() -- Line: 70
            -- upvalues: StatesController (ref)
            StatesController.States.Ability = false;
            StatesController.OwnWalkState = false;
        end);
        ABC:Add(task.delay(1, function() -- Line: 75
            -- upvalues: u2 (ref), ABC (copy)
            if u2 then
                ABC:Clean();
            end;
        end));
        task.wait(0.7);

        if not ABC then
            return;
        end;
    end;

    if not AbilityUtils.rules.onball(LocalPlayer, false) then
        return;
    end;

    getPlayerTarget(false);
    local u7 = getPlayerTarget(false, function(p5, p6) -- Line: 96
        -- upvalues: Players (ref), LocalPlayer (ref), u1 (copy), TwisterPass (copy)
        local PlayerFromCharacter = Players:GetPlayerFromCharacter(p5);

        if p5:GetAttribute("IsTrainingDummy") then
            return true;
        end;

        if not PlayerFromCharacter then
            return false;
        end;

        if PlayerFromCharacter.Team ~= LocalPlayer.Team then
            return false;
        end;

        if p5.Values.InCutscene.Value then
            return false;
        end;

        if (p5.HumanoidRootPart.Position - u1.Position).Magnitude < TwisterPass.ActivationRangePlayer then
            return true;
        end;
    end);

    if not u7 then
        Popup.Popup(LocalPlayer, "No teammate in range!");

        return;
    end;

    StatesController.States.Ability = true;
    StatesController.OwnWalkState = true;
    StatesController.SpeedBoost = -15;

    if true then
        interface:AbilityCooldown(2, TwisterPass.Cooldown);
    end;

    local Track = AnimationController:GetTrack("Abilities", "TwisterPass");
    Track.Looped = false;
    Track.Priority = Enum.AnimationPriority.Action3;
    Track:Play();
    local BallTrack = AnimationController:GetBallTrack("TwisterPassBall");
    BallTrack.Looped = false;
    BallTrack.Priority = Enum.AnimationPriority.Action4;
    BallTrack:Play();
    interface.AbilityService.Ability:Fire("TwisterPass", u7);
    local _ = LocalPlayer.Team;
    local u8 = false;
    ABC:Add(task.delay(2, function() -- Line: 141
        -- upvalues: u8 (ref), StatesController (ref), ABC (copy)
        if not u8 then
            StatesController.States.Ability = false;
            StatesController.OwnWalkState = false;
            StatesController.SpeedBoost = 0;
            ABC:Clean();
        end;
    end));
    ABC:Connect(interface.AbilityService.Ability, function(u9) -- Line: 150
        -- upvalues: StatesController (ref), u8 (ref), Character (copy), u7 (copy), BallController (ref), ABC (copy), RunService (ref)
        StatesController.States.Ability = false;
        StatesController.OwnWalkState = false;
        StatesController.SpeedBoost = 0;
        u8 = true;
        local HumanoidRootPart = Character.HumanoidRootPart;
        local HumanoidRootPart2 = u7.HumanoidRootPart;
        local u10 = (HumanoidRootPart2.Position + HumanoidRootPart2.AssemblyLinearVelocity * Vector3.new(1, 0, 1) - HumanoidRootPart.Position).Unit + Vector3.new(0, 0.5, 0);
        local math_clamp_ret = math.clamp((HumanoidRootPart2.Position - HumanoidRootPart.Position).Magnitude * 1.5, 0, 150);
        u9.AssemblyLinearVelocity = u10 * math_clamp_ret;
        BallController:DragBall(u9);
        local u11 = tick();
        ABC:Connect(RunService.Heartbeat, function(p12) -- Line: 171
            -- upvalues: u11 (copy), u9 (copy), ABC (ref), HumanoidRootPart2 (copy), u10 (ref), math_clamp_ret (ref), HumanoidRootPart (copy)
            if tick() > u11 + 2 or (not u9 or u9.OnPlayer.Value) then
                return ABC:Clean();
            end;

            local _ = HumanoidRootPart2.AssemblyLinearVelocity * Vector3.new(1, 0, 1);
            local v13 = tick() > u11 + 0.55;
            u10 = u10:Lerp((HumanoidRootPart2.Position - u9.Position).Unit + Vector3.new(0, v13 and 0.15 or 0.35, 0), 6.5 * p12);
            math_clamp_ret = math.clamp((HumanoidRootPart2.Position - HumanoidRootPart.Position).Magnitude * 2.75, 0, 150);

            if u9.Position.Y < 5 or (HumanoidRootPart2.Position - u9.Position).Magnitude <= 7 then
                return ABC:Clean();
            end;

            u9.AssemblyLinearVelocity = u9.AssemblyLinearVelocity:Lerp(u10 * math_clamp_ret, 6.5 * p12);
        end);
    end);
end;