  

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
require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local AbilityBalancing = require(ReplicatedStorage2.AbilityBalancing);
local AbilityUtils = require(ReplicatedStorage2.Shared.AbilityUtils);
local StatesController = require(ReplicatedStorage2.Controllers.StatesController);
local AnimationController = require(ReplicatedStorage2.Controllers.AnimationController);
require(ReplicatedStorage2.Controllers.CameraController);
require(ReplicatedStorage2.Controllers.BallController);
require(ReplicatedStorage2.Modules.getPlayerTarget);
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
    -- upvalues: AbilityBalancing (copy), AbilityUtils (copy), interface (copy), StatesController (copy), RunService (copy), ReplicatedStorage (copy), Players (copy), AnimationController (copy), LocalPlayer (copy)
    local MetaBurstPoint = AbilityBalancing.MetaBurstPoint;

    if AbilityUtils.rules.offball() and (AbilityUtils.rules.grounded() and (AbilityUtils.rules.slotReady(2) and not interface.__trapped)) then
        local Character, u9, _, _ = AbilityUtils.getCharacter();
        local Cooldown = MetaBurstPoint.Cooldown;
        interface.VisionStoppage = true;
        interface:AbilityCooldown(2, 3);
        local ABC = interface.ABC;
        local u10 = false;
        StatesController.States.Ability = true;
        StatesController.OwnWalkState = true;
        StatesController.SpeedBoost = 20;
        ABC:Add(function() -- Line: 66
            -- upvalues: u10 (ref), StatesController (ref)
            u10 = true;
            StatesController.States.Ability = false;
            StatesController.OwnWalkState = false;
            StatesController.SpeedBoost = 0;
        end);
        local u11 = false;
        ABC:Connect(RunService.Heartbeat, function() -- Line: 75
            -- upvalues: ReplicatedStorage (ref), RunService (ref), Players (ref), u11 (ref), Character (copy), AnimationController (ref), ABC (copy), LocalPlayer (ref), u9 (copy), interface (ref)
            local v12 = ReplicatedStorage.Football.Value.Char.Value or RunService:IsStudio() and workspace.PassRig;
            local PlayerFromCharacter = Players:GetPlayerFromCharacter(v12);

            if u11 or not v12 then
                return;
            end;

            if Character.Values.HasBall.Value then
                u11 = true;
                local Track = AnimationController:GetTrack("Abilities", "MetaBurstPoint");
                Track.Looped = false;
                Track.Priority = Enum.AnimationPriority.Action3;
                Track:Play();
                ABC:Clean();
            end;

            if (not PlayerFromCharacter or v12 and (v12.Values.HasBall.Value == true and (PlayerFromCharacter.Team ~= LocalPlayer.Team and (v12.Values.Goalie.Value and v12.Values.IsInPenalty.Value)))) and (u9.Position - v12.HumanoidRootPart.Position).Magnitude < 12 then
                print("Passed");
                u11 = true;
                local Track = AnimationController:GetTrack("Abilities", "MetaBurstPoint");
                Track.Looped = false;
                Track.Priority = Enum.AnimationPriority.Action3;
                Track:Play();
                local _ = (Vector3.new(v12.HumanoidRootPart.Position.X, u9.Position.Y, v12.HumanoidRootPart.Position.Z) - u9.Position).Unit;
                interface.AbilityService.Ability:Fire("MetaBurstPoint", v12);
                ABC:Add(task.delay(0.2, function() -- Line: 109
                    -- upvalues: ABC (ref)
                    ABC:Clean();
                end));
            end;
        end);
        task.delay(3, function() -- Line: 118
            -- upvalues: u10 (ref), ABC (copy)
            if not u10 then
                ABC:Clean();
            end;
        end);
        interface.AbilityService.Ability:Fire("MetaBurstPoint");
        task.wait(5);

        if interface.VisionStoppage then
            interface.VisionStoppage = false;
            interface:AbilityCooldown(2, Cooldown);
        end;

        return true;
    end;
end;