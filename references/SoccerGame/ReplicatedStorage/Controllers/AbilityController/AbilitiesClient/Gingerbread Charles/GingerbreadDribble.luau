  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("UserInputService");
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
local Popup = require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local AbilityBalancing = require(ReplicatedStorage2.AbilityBalancing);
local AbilityUtils = require(ReplicatedStorage2.Shared.AbilityUtils);
local _ = AbilityUtils.Lerp;
local QuadBezier = AbilityUtils.QuadBezier;
local StatesController = require(ReplicatedStorage2.Controllers.StatesController);
local AnimationController = require(ReplicatedStorage2.Controllers.AnimationController);
require(ReplicatedStorage2.Controllers.CameraController);
require(ReplicatedStorage2.Controllers.BallController);
local getPlayerTarget = require(ReplicatedStorage2.Modules.getPlayerTarget);
local interface = require(ReplicatedStorage2.Controllers.AbilityController.interface);
local LocalPlayer = Players.LocalPlayer;
local _ = workspace.CurrentCamera;

return function() -- Line: 33
    -- upvalues: AbilityBalancing (copy), AbilityUtils (copy), getPlayerTarget (copy), Players (copy), LocalPlayer (copy), RunService (copy), Popup (copy), interface (copy), StatesController (copy), AnimationController (copy), QuadBezier (copy), TweenService (copy)
    local GingerbreadDribble = AbilityBalancing.GingerbreadDribble;

    if AbilityUtils.rules.onball() and (AbilityUtils.rules.grounded() and AbilityUtils.rules.slotReady(1)) then
        local _, u1, v2, _ = AbilityUtils.getCharacter();
        local u5 = getPlayerTarget(false, function(p3, p4) -- Line: 44
            -- upvalues: u1 (copy), GingerbreadDribble (copy), Players (ref), LocalPlayer (ref), RunService (ref)
            if p3:GetAttribute("IsTrainingDummy") then
                return (p3.HumanoidRootPart.Position - u1.Position).Magnitude <= GingerbreadDribble.ActivationRangePlayer;
            end;

            local PlayerFromCharacter = Players:GetPlayerFromCharacter(p3);

            if PlayerFromCharacter and (PlayerFromCharacter.Team ~= LocalPlayer.Team and ((p3.HumanoidRootPart.Position - u1.Position).Magnitude <= GingerbreadDribble.ActivationRangePlayer and not (PlayerFromCharacter.Character.Values.Goalie.Value and PlayerFromCharacter.Character.Values.IsInPenalty.Value))) or RunService:IsStudio() then
                return true;
            end;
        end);

        if not u5 then
            return Popup.Popup(LocalPlayer, "Must be near an enemy player");
        end;

        local ABC = interface.ABC;
        local _ = v2.MoveDirection.Unit;
        StatesController.States.Ability = true;
        interface:AbilityCooldown(1, 1);
        local Track = AnimationController:GetTrack("Abilities", "GingerbreadDribble");
        Track.Looped = false;
        Track.Priority = Enum.AnimationPriority.Action3;
        Track:Play();
        local BallTrack = AnimationController:GetBallTrack("GingerbreadDribbleBall");
        BallTrack.Looped = false;
        BallTrack.Priority = Enum.AnimationPriority.Action4;
        BallTrack:Play();
        ABC:Add(task.delay(0.1, function() -- Line: 76
            -- upvalues: u1 (copy), ABC (copy), GingerbreadDribble (copy), u5 (copy), RunService (ref), QuadBezier (ref), TweenService (ref)
            local BodyVelocity = Instance.new("BodyVelocity");
            BodyVelocity.Parent = u1;
            BodyVelocity.MaxForce = Vector3.new(40000, 40000, 40000);
            local BodyGyro = Instance.new("BodyGyro");
            BodyGyro.Parent = u1;
            BodyGyro.MaxTorque = Vector3.new(40000, 40000, 40000);
            ABC:Add(BodyVelocity);
            ABC:Add(BodyGyro);
            local Distance = GingerbreadDribble.Distance;
            local Vector3Value = Instance.new("Vector3Value");
            local Vector3_new_ret = Vector3.new(u5.HumanoidRootPart.Position.X, u1.Position.Y, u5.HumanoidRootPart.Position.Z);
            local CFrame_new_ret = CFrame.new(u1.Position, Vector3_new_ret);
            Vector3Value.Value = (Vector3_new_ret - CFrame_new_ret.Position).Unit;
            local Position = u1.Position;
            local Position2 = (CFrame_new_ret * CFrame.new(-Distance, 0, -Distance / 2)).Position;
            local v6 = u1.CFrame * CFrame.new(0, 0, -Distance);
            local u7 = 0;
            local v9 = RunService.Heartbeat:Connect(function(p8) -- Line: 103
                -- upvalues: u7 (ref), BodyVelocity (copy), Vector3Value (copy), Distance (copy)
                u7 = u7 + p8;

                if u7 >= 0.016666666666666666 then
                    u7 = 0;
                    BodyVelocity.Velocity = Vector3Value.Value * Distance * (60 * p8);
                end;
            end);
            ABC:Add(v9);

            for i = 1, 10 do
                local v10 = QuadBezier(Position, Position2, v6.Position, i / 10);
                local v11 = TweenService:Create(Vector3Value, TweenInfo.new(0.03), {
                    Value = (v10 - u1.Position).Unit
                });
                v11:Play();
                task.wait(0.03);
                v11:Destroy();
                local _ = i;
            end;

            v9:Disconnect();
            BodyVelocity:Destroy();
            BodyGyro:Destroy();
        end));
        interface.AbilityService.Ability:Fire("GingerbreadDribble");
        ABC:Add(function() -- Line: 132
            -- upvalues: StatesController (ref)
            StatesController.States.Ability = false;
        end);
        ABC:Add(task.delay(0.7, function() -- Line: 137
            -- upvalues: ABC (copy)
            ABC:Clean();
        end));
        task.delay(0.5, function() -- Line: 141
            -- upvalues: interface (ref), GingerbreadDribble (copy)
            interface.CookieStep = true;
            task.wait(2);

            if interface.CookieStep then
                interface.CookieStep = false;
                interface:AbilityCooldown(1, GingerbreadDribble.Cooldown);
            end;
        end);

        return true;
    end;
end;