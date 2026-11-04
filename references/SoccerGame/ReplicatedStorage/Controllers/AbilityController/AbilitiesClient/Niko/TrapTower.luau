  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("UserInputService");
local Players = game:GetService("Players");
game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local TrapTower = require(ReplicatedStorage2.AbilityBalancing).TrapTower;
local AbilityUtils = require(ReplicatedStorage2.Shared.AbilityUtils);
local StatesController = require(ReplicatedStorage2.Controllers.StatesController);
local AnimationController = require(ReplicatedStorage2.Controllers.AnimationController);
require(ReplicatedStorage2.Controllers.CameraController);
require(ReplicatedStorage2.Controllers.BallController);
local interface = require(ReplicatedStorage2.Controllers.AbilityController.interface);
local LocalPlayer = Players.LocalPlayer;
local _ = workspace.CurrentCamera;

return function() -- Line: 28, Name: TrapTower
    -- upvalues: AbilityUtils (copy), LocalPlayer (copy), interface (copy), AnimationController (copy), TrapTower (copy), TweenService (copy), StatesController (copy)
    if not (AbilityUtils.rules.offball() and (not AbilityUtils.rules.grounded(LocalPlayer, false) and AbilityUtils.rules.slotReady(2))) then
        return;
    end;

    local ABC = interface.ABC;
    local Character, v1, _, _ = AbilityUtils.getCharacter();
    interface.StatesController.States.Ability = true;
    local Unit = (v1.CFrame.LookVector + Vector3.new(0, 0.1, 0)).Unit;
    interface:AbilityCooldown(2, 40);
    local Track = AnimationController:GetTrack("Abilities", "TrapTower");
    Track.Looped = false;
    Track.Priority = Enum.AnimationPriority.Action3;
    Track:Play();
    interface.AbilityService.Ability:Fire("TrapTower");
    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.MaxForce = Vector3.new(20000, 20000, 20000);
    BodyVelocity.Velocity = Unit * TrapTower.MoveSpeedValue + Vector3.new(0, 25, 0);
    BodyVelocity.Parent = Character.PrimaryPart;
    TweenService:Create(BodyVelocity, TweenInfo.new(0.75), {
        Velocity = BodyVelocity.Velocity * 0.1
    }):Play();
    ABC:Add(BodyVelocity);
    task.delay(0.5, BodyVelocity.Destroy, BodyVelocity);
    local u2 = false;
    task.delay(0.8, function() -- Line: 68
        -- upvalues: u2 (ref), Track (copy), ABC (copy), StatesController (ref)
        if u2 then
            Track:Stop();
            ABC:Clean();
            StatesController.States.Ability = false;
        end;
    end);
    ABC:Connect(interface.AbilityService.Ability, function(p3, p4) -- Line: 72
        -- upvalues: Track (copy), u2 (ref)
        Track:Stop(0);
        u2 = true;
    end);
    task.delay(0.8, function() -- Line: 77
        -- upvalues: ABC (copy), interface (ref)
        if ABC then
            ABC:Clean();
            interface.StatesController.States.Ability = false;
        end;
    end);
end;