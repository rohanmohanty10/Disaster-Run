  

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
local StatesController = require(ReplicatedStorage2.Controllers.StatesController);
local AnimationController = require(ReplicatedStorage2.Controllers.AnimationController);
require(ReplicatedStorage2.Controllers.CameraController);
local BallController = require(ReplicatedStorage2.Controllers.BallController);
local getPlayerTarget = require(ReplicatedStorage2.Modules.getPlayerTarget);
local interface = require(ReplicatedStorage2.Controllers.AbilityController.interface);
local LocalPlayer = Players.LocalPlayer;
local _ = workspace.CurrentCamera;

return function() -- Line: 29
    -- upvalues: AbilityBalancing (copy), AbilityUtils (copy), getPlayerTarget (copy), Players (copy), LocalPlayer (copy), RunService (copy), Popup (copy), interface (copy), StatesController (copy), AnimationController (copy), BallController (copy)
    local CookieCross = AbilityBalancing.CookieCross;

    if not (AbilityUtils.rules.onball() and (AbilityUtils.rules.grounded() and AbilityUtils.rules.slotReady(2))) then
        return;
    end;

    local Character, u1, _, _ = AbilityUtils.getCharacter();
    local u4 = getPlayerTarget(false, function(p2, p3) -- Line: 40
        -- upvalues: u1 (copy), CookieCross (copy), Players (ref), LocalPlayer (ref)
        if p2:GetAttribute("IsTrainingDummy") then
            return (p2.HumanoidRootPart.Position - u1.Position).Magnitude < CookieCross.ActivationRangePlayer;
        end;

        local PlayerFromCharacter = Players:GetPlayerFromCharacter(p2);

        if not PlayerFromCharacter then
            return false;
        end;

        if PlayerFromCharacter.Team ~= LocalPlayer.Team then
            return false;
        end;

        local Values = p2.Values;
        local _ = Values.HasBall.Value;

        if Values.IsInPenalty.Value then
            local _ = Values.Goalie.Value;
        end;

        if Values.InCutscene.Value then
            return false;
        end;

        if (p2.HumanoidRootPart.Position - u1.Position).Magnitude < CookieCross.ActivationRangePlayer then
            return true;
        end;
    end);

    if RunService:isStudio() and u4 == nil then
        u4 = workspace.PassRig;
    end;

    if not u4 then
        Popup.Popup(LocalPlayer, "Must be near a teammate");

        return;
    end;

    interface:AbilityCooldown(2, CookieCross.Cooldown);
    local ABC = interface.ABC;
    local u5 = false;
    StatesController.States.Ability = true;
    AnimationController:StopAnims();
    local Track = AnimationController:GetTrack("Abilities", "CookieCross");
    Track.Looped = false;
    Track.Priority = Enum.AnimationPriority.Action3;
    Track:Play();
    interface.AbilityService.Ability:Fire("CookieCross", u4);
    ABC:Add(function() -- Line: 83
        -- upvalues: u5 (ref)
        u5 = true;
    end);
    ABC:Connect(interface.AbilityService.Ability, function(u6, p7, p8) -- Line: 87
        -- upvalues: StatesController (ref), Character (copy), u4 (ref), BallController (ref), ABC (copy), RunService (ref)
        StatesController.States.Ability = false;
        local HumanoidRootPart = Character.HumanoidRootPart;
        local HumanoidRootPart2 = u4.HumanoidRootPart;
        local u9 = (HumanoidRootPart2.Position + HumanoidRootPart2.AssemblyLinearVelocity * Vector3.new(1, 0, 1) - HumanoidRootPart.Position).Unit + Vector3.new(0, 0.75, 0);
        local math_clamp_ret = math.clamp((HumanoidRootPart2.Position - HumanoidRootPart.Position).Magnitude * 1.5, 0, 150);
        u6.AssemblyLinearVelocity = u9 * math_clamp_ret;
        BallController:DragBall(u6);
        local u10 = tick();
        ABC:Connect(RunService.Heartbeat, function(p11) -- Line: 104
            -- upvalues: u10 (copy), u4 (ref), u6 (copy), ABC (ref), HumanoidRootPart2 (copy), u9 (ref), math_clamp_ret (ref), HumanoidRootPart (copy)
            if tick() > u10 + 2 or not (u4 and (workspace:FindFirstChild("Football") and not u6.OnPlayer.Value)) then
                return ABC:Clean();
            end;

            local _ = HumanoidRootPart2.AssemblyLinearVelocity * Vector3.new(1, 0, 1);
            local v12 = tick() > u10 + 0.55;
            u9 = u9:Lerp((HumanoidRootPart2.Position - u6.Position).Unit + Vector3.new(0, v12 and 0.15 or 0.35, 0), 6.5 * p11);
            math_clamp_ret = math.clamp((HumanoidRootPart2.Position - HumanoidRootPart.Position).Magnitude * 2.75, 0, 175);

            if u6.Position.Y < 5 or (HumanoidRootPart2.Position - u6.Position).Magnitude <= 7 then
                return ABC:Clean();
            end;

            u6.AssemblyLinearVelocity = u6.AssemblyLinearVelocity:Lerp(u9 * math_clamp_ret, 6.5 * p11);
        end);
    end);
    task.delay(2, function() -- Line: 132
        -- upvalues: u5 (ref), ABC (copy), StatesController (ref)
        if u5 then
            return;
        end;

        ABC:Clean();
        StatesController.States.Ability = false;
    end);
end;