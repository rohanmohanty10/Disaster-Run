  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("UserInputService");
local Players = game:GetService("Players");
game:GetService("RunService");
game:GetService("TweenService");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local AbilityBalancing = require(ReplicatedStorage2.AbilityBalancing);
local AbilityUtils = require(ReplicatedStorage2.Shared.AbilityUtils);
local _ = AbilityUtils.Lerp;
local _ = AbilityUtils.QuadBezier;
local StatesController = require(ReplicatedStorage2.Controllers.StatesController);
local AnimationController = require(ReplicatedStorage2.Controllers.AnimationController);
require(ReplicatedStorage2.Controllers.CameraController);
local BallController = require(ReplicatedStorage2.Controllers.BallController);
require(ReplicatedStorage2.Modules.getPlayerTarget);
local interface = require(ReplicatedStorage2.Controllers.AbilityController.interface);
local ClientGlobals = require(ReplicatedStorage2.ClientModules.ClientGlobals);
local countStyleMastery = require(ReplicatedStorage2.Shared.utils.countStyleMastery);
local _ = Players.LocalPlayer;
local PlayerData = ClientGlobals.PlayerData;
local _ = workspace.CurrentCamera;

return function() -- Line: 38
    -- upvalues: AbilityBalancing (copy), AbilityUtils (copy), PlayerData (copy), countStyleMastery (copy), interface (copy), StatesController (copy), AnimationController (copy), BallController (copy), ReplicatedStorage2 (copy)
    local CloseQuarterDribble = AbilityBalancing.CloseQuarterDribble;

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

    local Character, u3, _, _ = AbilityUtils.getCharacter();
    local ABC = interface.ABC;
    local v4;

    if v1 >= 3 then
        v4 = not v2[3];
    else
        v4 = false;
    end;

    interface:AbilityCooldown(2, v4 and 1 or CloseQuarterDribble.Cooldown);
    interface.LobPass = v4;
    StatesController.States.Ability = true;
    StatesController.OwnWalkState = true;
    ABC:Add(function() -- Line: 66
        -- upvalues: StatesController (ref)
        StatesController.States.Ability = false;
        StatesController.OwnWalkState = false;
    end);
    local Track = AnimationController:GetTrack("Abilities", "CQDribble");
    Track.Looped = false;
    Track.Priority = Enum.AnimationPriority.Action3;
    Track:Play();
    interface.AbilityService.Ability:Fire("CloseQuarterDribble", {
        Type = "Effect"
    });
    ABC:Connect(interface.AbilityService.Ability, function() -- Line: 78
        -- upvalues: BallController (ref), ReplicatedStorage2 (ref)
        BallController:DragBall(ReplicatedStorage2.Football.Value);
    end);
    task.delay(1.2, function() -- Line: 82
        -- upvalues: u3 (copy), CloseQuarterDribble (copy), AbilityUtils (ref), Character (copy), ABC (copy)
        local v5 = -u3.CFrame.RightVector;
        local Unit = Vector3.new(v5.X, 0, v5.Z).Unit;
        local v6, v7 = AbilityUtils.FastDashTo(Character, u3.Position + Unit * (CloseQuarterDribble.TravelDistance / 2), -2, 0.3);
        ABC:Add(v6);
        ABC:Add(v7);
    end);
    task.delay(1.5, function() -- Line: 92
        -- upvalues: u3 (copy), CloseQuarterDribble (copy), AbilityUtils (ref), Character (copy), ABC (copy)
        local v8 = u3.CFrame.RightVector + u3.CFrame.LookVector * 0.25;
        local Unit = Vector3.new(v8.X, 0, v8.Z).Unit;
        local v9, v10 = AbilityUtils.FastDashTo(Character, u3.Position + Unit * CloseQuarterDribble.TravelDistance, -2, 0.3);
        ABC:Add(v9);
        ABC:Add(v10);
    end);
    task.delay(1.8, function() -- Line: 102
        -- upvalues: ABC (copy)
        ABC:Clean();
    end);

    if v4 then
        task.wait(4);

        if interface.LobPass then
            interface.LobPass = nil;
            interface:AbilityCooldown(2, CloseQuarterDribble.Cooldown);
        end;
    end;
end;