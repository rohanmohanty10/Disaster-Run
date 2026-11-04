  

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
require(ReplicatedStorage2.AbilityBalancing);
local AbilityUtils = require(ReplicatedStorage2.Shared.AbilityUtils);
require(ReplicatedStorage2.Controllers.StatesController);
local AnimationController = require(ReplicatedStorage2.Controllers.AnimationController);
require(ReplicatedStorage2.Controllers.CameraController);
require(ReplicatedStorage2.Controllers.BallController);
require(ReplicatedStorage2.Modules.getPlayerTarget);
local interface = require(ReplicatedStorage2.Controllers.AbilityController.interface);
local _ = Players.LocalPlayer;
local _ = workspace.CurrentCamera;

return function() -- Line: 29, Name: AirDash
    -- upvalues: AbilityUtils (copy), interface (copy), AnimationController (copy)
    if not AbilityUtils.rules.slotReady(2) then
        return;
    end;

    local Character, _, _, _ = AbilityUtils.getCharacter();
    Character.HumanoidRootPart.Anchored = false;
    local _ = interface.ABC;
    interface:AbilityCooldown(2, 30);
    local v1 = Character.HumanoidRootPart.CFrame:VectorToObjectSpace(Character.Humanoid.MoveDirection).X < 0 and "Left" or "Right";
    local v2;

    if v1 == "Right" then
        v2 = Character.HumanoidRootPart.CFrame.RightVector;
    else
        v2 = -Character.HumanoidRootPart.CFrame.RightVector;
    end;

    interface.AbilityService.Ability:Fire("AirDash", v2);
    local Track = AnimationController:GetTrack("Abilities", "AirDribble" .. v1);
    Track.Looped = false;
    Track.Priority = Enum.AnimationPriority.Action3;
    Track:Play();
    local BallTrack = AnimationController:GetBallTrack("AirDribble" .. v1);
    BallTrack.Looped = false;
    BallTrack.Priority = Enum.AnimationPriority.Action4;
    BallTrack:Play();
end;