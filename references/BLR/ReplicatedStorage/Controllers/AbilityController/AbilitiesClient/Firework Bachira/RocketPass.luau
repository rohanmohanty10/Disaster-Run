  

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
local RocketPass = require(ReplicatedStorage2.AbilityBalancing).RocketPass;
local AbilityUtils = require(ReplicatedStorage2.Shared.AbilityUtils);
local StatesController = require(ReplicatedStorage2.Controllers.StatesController);
local AnimationController = require(ReplicatedStorage2.Controllers.AnimationController);
require(ReplicatedStorage2.Controllers.CameraController);
local BallController = require(ReplicatedStorage2.Controllers.BallController);
local GetPlayersByDistanceAndAngle = require(ReplicatedStorage2.Shared.GetPlayersByDistanceAndAngle);
local interface = require(ReplicatedStorage2.Controllers.AbilityController.interface);
local LocalPlayer = Players.LocalPlayer;
local _ = workspace.CurrentCamera;

return function() -- Line: 29
    -- upvalues: AbilityUtils (copy), GetPlayersByDistanceAndAngle (copy), LocalPlayer (copy), Popup (copy), StatesController (copy), interface (copy), RocketPass (copy), AnimationController (copy), ReplicatedStorage2 (copy), BallController (copy), RunService (copy)
    if not (AbilityUtils.rules.onball() and (AbilityUtils.rules.grounded() and AbilityUtils.rules.slotReady(2))) then
        return;
    end;

    local Character, v1, _, _ = AbilityUtils.getCharacter();
    local v3 = GetPlayersByDistanceAndAngle(45, 500, LocalPlayer, nil, function(p2) -- Line: 39
        -- upvalues: LocalPlayer (ref)
        if not p2 then
            return false;
        end;

        if p2.Team == LocalPlayer.Team then
            return not p2.Character.Values.InCutscene.Value;
        end;

        return false;
    end);
    local v4 = v3 and v3[1];
    local u5;

    if v4 then
        u5 = v4;
    else
        u5 = workspace:FindFirstChild("PassRig");

        if u5 and (u5:GetAttribute("IsTrainingDummy") and u5:FindFirstChild("HumanoidRootPart")) then
            local v6 = v1.CFrame.LookVector:Dot((u5.HumanoidRootPart.Position - v1.Position).Unit);

            if math.acos(v6) >= 0.7853981633974483 then
                u5 = v4;
            end;
        else
            u5 = v4;
        end;
    end;

    if not u5 then
        Popup.Popup(LocalPlayer, "No teammate in line of site");

        return;
    end;

    StatesController.States.Ability = true;
    local u7 = false;
    interface:AbilityCooldown(2, RocketPass.Cooldown);
    local ABC = interface.ABC;
    AbilityUtils.clearMovers(Character);
    AnimationController:StopAnims();
    local Track = AnimationController:GetTrack("Abilities", "RocketPass");
    Track.Looped = false;
    Track.Priority = Enum.AnimationPriority.Action3;
    Track:Play();
    local BallTrack = AnimationController:GetBallTrack("Hide");
    BallTrack:Play();
    interface.AbilityService.Ability:Fire("RocketPass", u5);
    ABC:Add(function() -- Line: 90
        -- upvalues: StatesController (ref), u7 (ref)
        StatesController.States.Ability = false;
        u7 = true;
    end);
    ABC:Connect(interface.AbilityService.Ability, function(u8, p9, p10) -- Line: 95
        -- upvalues: StatesController (ref), BallTrack (copy), ReplicatedStorage2 (ref), ABC (copy), Character (copy), u5 (ref), BallController (ref), RunService (ref)
        StatesController.States.Ability = false;
        BallTrack:Stop();

        if ReplicatedStorage2.GameValues.AwakeningCutscene.Value then
            return;
        end;

        if not u8 then
            ABC:Clean();

            return;
        end;

        local HumanoidRootPart = Character.HumanoidRootPart;
        local HumanoidRootPart2 = u5.HumanoidRootPart;
        local u11 = (HumanoidRootPart2.Position + HumanoidRootPart2.AssemblyLinearVelocity * Vector3.new(1, 0, 1) - HumanoidRootPart.Position).Unit + Vector3.new(0, 0.15, 0);
        local math_clamp_ret = math.clamp((HumanoidRootPart2.Position - HumanoidRootPart.Position).Magnitude * 1.5, 0, 250);
        u8.CFrame = CFrame.new(HumanoidRootPart.Position, HumanoidRootPart2.Position) * CFrame.new(3, 5.5, 0);
        u8.AssemblyLinearVelocity = u11 * math_clamp_ret;
        BallController:DragBall(u8);
        local u12 = tick();
        ABC:Connect(RunService.Heartbeat, function(p13) -- Line: 122
            -- upvalues: u12 (copy), u5 (ref), u8 (copy), ABC (ref), HumanoidRootPart2 (copy), u11 (ref), math_clamp_ret (ref)
            if tick() > u12 + 3.5 or not (u5 and (workspace:FindFirstChild("Football") and not u8.OnPlayer.Value)) then
                return ABC:Clean();
            end;

            local v14 = HumanoidRootPart2.AssemblyLinearVelocity * Vector3.new(1, 0, 1);
            local v15 = tick() > u12 + 0.55;
            u11 = u11:Lerp((HumanoidRootPart2.Position - u8.Position).Unit + Vector3.new(0, v14.Magnitude < 1 and 0 or (v15 and 0.1 or 0.25), 0), 6.5 * p13);
            math_clamp_ret = math.clamp((HumanoidRootPart2.Position - u8.Position).Magnitude * 2.5, 0, 140);
            local v16 = u8.Position.Y < 5;
            local Magnitude = (Vector3.new(HumanoidRootPart2.Position.X, 0, HumanoidRootPart2.Position.Z) - Vector3.new(u8.Position.X, 0, u8.Position.Z)).Magnitude;
            local math_abs_ret = math.abs(HumanoidRootPart2.Position.Y - u8.Position.Y);
            local v17;

            if Magnitude <= 6 then
                v17 = math_abs_ret <= 4;
            else
                v17 = false;
            end;

            if v16 or v17 then
                print("Ended Here");

                return ABC:Clean();
            end;

            u8.AssemblyLinearVelocity = u8.AssemblyLinearVelocity:Lerp(u11 * math_clamp_ret, 6.5 * p13);
        end);
    end);
    task.delay(2.5, function() -- Line: 161
        -- upvalues: u7 (ref), ABC (copy), StatesController (ref)
        if u7 then
            return;
        end;

        print("ended");
        ABC:Clean();
        StatesController.States.Ability = false;
    end);
end;