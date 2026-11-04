  

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
local ClientGlobals = require(ReplicatedStorage2.ClientModules.ClientGlobals);
local countStyleMastery = require(ReplicatedStorage2.Shared.utils.countStyleMastery);
local LocalPlayer = Players.LocalPlayer;
local PlayerData = ClientGlobals.PlayerData;
local _ = workspace.CurrentCamera;

return function() -- Line: 38
    -- upvalues: AbilityBalancing (copy), AbilityUtils (copy), PlayerData (copy), countStyleMastery (copy), interface (copy), getPlayerTarget (copy), Players (copy), LocalPlayer (copy), RunService (copy), Popup (copy), StatesController (copy), AnimationController (copy), BallController (copy), ReplicatedStorage2 (copy)
    local CrossElasticoNutmeg = AbilityBalancing.CrossElasticoNutmeg;

    if not (AbilityUtils.rules.onball() and (AbilityUtils.rules.grounded() and AbilityUtils.rules.slotReady(2))) then
        return;
    end;

    local v1, v2;

    if PlayerData.Data then
        v1 = countStyleMastery(PlayerData.Data, "Reo");
        v2 = PlayerData.Data.DisabledMasteryLevels.Reo;
    else
        v1 = 0;
        v2 = {};
    end;

    local v3;

    if v1 >= 3 then
        v3 = not v2[3];
    else
        v3 = false;
    end;

    local Character, u4, _, _ = AbilityUtils.getCharacter();
    local ABC = interface.ABC;
    local v7 = getPlayerTarget(false, function(p5, p6) -- Line: 59
        -- upvalues: u4 (copy), CrossElasticoNutmeg (copy), Players (ref), LocalPlayer (ref)
        if p5:GetAttribute("IsTrainingDummy") then
            return (p5.HumanoidRootPart.Position - u4.Position).Magnitude < CrossElasticoNutmeg.ActivationRangePlayer;
        end;

        local PlayerFromCharacter = Players:GetPlayerFromCharacter(p5);

        if not PlayerFromCharacter then
            return false;
        end;

        if PlayerFromCharacter.Team == LocalPlayer.Team then
            return false;
        end;

        local Values = p5.Values;
        local _ = Values.HasBall.Value;

        if Values.IsInPenalty.Value then
            local _ = Values.Goalie.Value;
        end;

        if Values.InCutscene.Value then
            return false;
        end;

        if (p5.HumanoidRootPart.Position - u4.Position).Magnitude < CrossElasticoNutmeg.ActivationRangePlayer then
            return true;
        end;
    end);

    if RunService:isStudio() and v7 == nil then
        v7 = workspace.PassRig;
    end;

    if not v7 then
        Popup.Popup(LocalPlayer, "Must be near an enemy");

        return;
    end;

    interface:AbilityCooldown(2, v3 and 1 or CrossElasticoNutmeg.Cooldown);
    interface.TrivelaShot = v3;
    StatesController.States.Ability = true;
    StatesController.OwnWalkState = true;
    ABC:Add(function() -- Line: 93
        -- upvalues: StatesController (ref)
        StatesController.States.Ability = false;
        StatesController.OwnWalkState = false;
    end);
    local Track = AnimationController:GetTrack("Abilities", "CEMeg");
    Track.Looped = false;
    Track.Priority = Enum.AnimationPriority.Action3;
    Track:Play();
    interface.AbilityService.Ability:Fire("ElasticoNutmeg", v7);
    ABC:Connect(interface.AbilityService.Ability, function() -- Line: 105
        -- upvalues: BallController (ref), ReplicatedStorage2 (ref)
        BallController:DragBall(ReplicatedStorage2.Football.Value);
    end);
    task.delay(0.2, function() -- Line: 109
        -- upvalues: u4 (copy), CrossElasticoNutmeg (copy), AbilityUtils (ref), Character (copy), ABC (copy)
        local v8 = u4.CFrame.RightVector + u4.CFrame.LookVector;
        local Unit = Vector3.new(v8.X, 0, v8.Z).Unit;
        local v9, v10 = AbilityUtils.FastDashTo(Character, u4.Position + Unit * CrossElasticoNutmeg.TravelDistance, -2, 0.3);
        ABC:Add(v9);
        ABC:Add(v10);
    end);
    task.delay(1.8, function() -- Line: 119
        -- upvalues: ABC (copy)
        ABC:Clean();
    end);

    if v3 then
        task.wait(4);

        if interface.TrivelaShot then
            interface.TrivelaShot = nil;
            interface:AbilityCooldown(2, CrossElasticoNutmeg.Cooldown);
        end;
    end;
end;