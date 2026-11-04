  

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
local StatesController = require(ReplicatedStorage2.Controllers.StatesController);
local AnimationController = require(ReplicatedStorage2.Controllers.AnimationController);
require(ReplicatedStorage2.Controllers.CameraController);
require(ReplicatedStorage2.Controllers.BallController);
local getPlayerTarget = require(ReplicatedStorage2.Modules.getPlayerTarget);
local interface = require(ReplicatedStorage2.Controllers.AbilityController.interface);
local LocalPlayer = Players.LocalPlayer;
local _ = workspace.CurrentCamera;

local function Lerp(p1, p2, p3) -- Line: 29
    return p1 + (p2 - p1) * p3;
end;

local function QuadBezier(p4, p5, p6, p7) -- Line: 33
    local v8 = p4 + (p5 - p4) * p7;

    return v8 + (p5 + (p6 - p5) * p7 - v8) * p7;
end;

return function() -- Line: 41
    -- upvalues: AbilityBalancing (copy), AbilityUtils (copy), getPlayerTarget (copy), Players (copy), LocalPlayer (copy), RunService (copy), Popup (copy), interface (copy), StatesController (copy), AnimationController (copy), TweenService (copy)
    local ElfDribble = AbilityBalancing.ElfDribble;

    if AbilityUtils.rules.onball() and (AbilityUtils.rules.grounded() and AbilityUtils.rules.slotReady(3)) then
        local Character, u9, v10, _ = AbilityUtils.getCharacter();
        local v13 = getPlayerTarget(false, function(p11, p12) -- Line: 52
            -- upvalues: u9 (copy), ElfDribble (copy), Players (ref), LocalPlayer (ref), RunService (ref)
            if p11:GetAttribute("IsTrainingDummy") then
                return (p11.HumanoidRootPart.Position - u9.Position).Magnitude <= ElfDribble.ActivationRangePlayer;
            end;

            local PlayerFromCharacter = Players:GetPlayerFromCharacter(p11);

            if PlayerFromCharacter and (PlayerFromCharacter.Team ~= LocalPlayer.Team and ((p11.HumanoidRootPart.Position - u9.Position).Magnitude <= ElfDribble.ActivationRangePlayer and not (PlayerFromCharacter.Character.Values.Goalie.Value and PlayerFromCharacter.Character.Values.IsInPenalty.Value))) or RunService:IsStudio() then
                return true;
            end;
        end);

        if not v13 then
            return Popup.Popup(LocalPlayer, "Must be near an enemy player");
        end;

        interface:AbilityCooldown(3, ElfDribble.Cooldown);
        local ABC = interface.ABC;
        local _ = v10.MoveDirection.Unit;
        StatesController.States.Ability = true;
        local Track = AnimationController:GetTrack("Abilities", "ElfDribble");
        Track.Looped = false;
        Track.Priority = Enum.AnimationPriority.Action3;
        Track:Play();
        local BallTrack = AnimationController:GetBallTrack("ElfDribbleBall");
        BallTrack.Looped = false;
        BallTrack.Priority = Enum.AnimationPriority.Action4;
        BallTrack:Play();
        interface.AbilityService.Ability:Fire("ElfDribble");
        local BodyVelocity = Instance.new("BodyVelocity");
        BodyVelocity.Parent = u9;
        BodyVelocity.MaxForce = Vector3.new(40000, 40000, 40000);
        local BodyGyro = Instance.new("BodyGyro");
        BodyGyro.Parent = u9;
        BodyGyro.MaxTorque = Vector3.new(40000, 40000, 40000);
        ABC:Add(BodyVelocity);
        ABC:Add(BodyGyro);
        local u14 = ElfDribble.Distance * 0.75;
        local Vector3Value = Instance.new("Vector3Value");
        local CFrame_new_ret = CFrame.new(u9.Position, v13.HumanoidRootPart.Position);
        Vector3Value.Value = (v13.HumanoidRootPart.Position - CFrame_new_ret.Position).Unit;
        local Position = u9.Position;
        local Position2 = (CFrame_new_ret * CFrame.new(u14 / 2, 0, u14 / 2)).Position;
        local v15 = u9.CFrame * CFrame.new(u14, 0, 0);
        local v17 = RunService.Heartbeat:Connect(function(p16) -- Line: 110
            -- upvalues: BodyVelocity (copy), Vector3Value (copy), u14 (copy)
            BodyVelocity.Velocity = Vector3Value.Value * u14 * (185 * p16);
        end);

        for i = 1, 10 do
            local v18 = i / 10;
            local v19 = Position + (Position2 - Position) * v18;
            local v20 = v19 + (Position2 + (v15.Position - Position2) * v18 - v19) * v18;
            local v21 = TweenService:Create(Vector3Value, TweenInfo.new(0.02), {
                Value = (v20 - u9.Position).Unit
            });
            v21:Play();
            v21.Completed:Wait();
            v21:Destroy();
            local _ = i;
        end;

        v17:Disconnect();
        BodyVelocity:Destroy();
        BodyGyro:Destroy();
        local v22, v23 = AbilityUtils.FastDashTo(Character, (v15 * CFrame.new(0, 0, -ElfDribble.Distance)).Position, 2, 0.4);
        ABC:Add(v22);
        ABC:Add(v23);
        ABC:Add(function() -- Line: 133
            -- upvalues: StatesController (ref)
            StatesController.States.Ability = false;
        end);
        ABC:Add(task.delay(0.4, function() -- Line: 138
            -- upvalues: ABC (copy)
            ABC:Clean();
        end));

        return true;
    end;
end;