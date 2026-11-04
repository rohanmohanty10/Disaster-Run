  

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
local BallController = require(ReplicatedStorage2.Controllers.BallController);
local interface = require(ReplicatedStorage2.Controllers.AbilityController.interface);
local _ = Players.LocalPlayer;
local _ = workspace.CurrentCamera;

return function() -- Line: 28, Name: TrapTower
    -- upvalues: AbilityUtils (copy), interface (copy), AnimationController (copy), TrapTower (copy), TweenService (copy), StatesController (copy), BallController (copy)
    if not (AbilityUtils.rules.offball() and (AbilityUtils.rules.grounded() and AbilityUtils.rules.slotReady(1))) then
        return;
    end;

    local ABC = interface.ABC;
    local Character, v1, _, _ = AbilityUtils.getCharacter();
    interface.StatesController.States.Ability = true;
    local Unit = (v1.CFrame.LookVector + Vector3.new(0, 0.1, 0)).Unit;
    interface:AbilityCooldown(1, 40);
    local Track = AnimationController:GetTrack("Abilities", "RationalDefenseOffBall");
    Track.Looped = false;
    Track.Priority = Enum.AnimationPriority.Action3;
    Track:Play();
    interface.AbilityService.Ability:Fire("RationalDefenseOffBall");
    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.MaxForce = Vector3.new(20000, 20000, 20000);
    BodyVelocity.Velocity = Unit * TrapTower.MoveSpeedValue;
    BodyVelocity.Parent = Character.PrimaryPart;
    TweenService:Create(BodyVelocity, TweenInfo.new(0.75), {
        Velocity = BodyVelocity.Velocity * 0.1
    }):Play();
    ABC:Add(BodyVelocity);
    task.delay(0.5, BodyVelocity.Destroy, BodyVelocity);
    local u2 = false;
    task.delay(0.8, function() -- Line: 69
        -- upvalues: u2 (ref), Track (copy), ABC (copy), StatesController (ref)
        if u2 then
            Track:Stop();
            ABC:Clean();
            StatesController.States.Ability = false;
        end;
    end);
    ABC:Connect(interface.AbilityService.Ability, function(p3, p4) -- Line: 73
        -- upvalues: Track (copy), u2 (ref), BallController (ref), ABC (copy)
        Track:Stop(0);
        u2 = true;
        p3.AssemblyLinearVelocity = p4;
        BallController:DragBall(p3);
        ABC:Clean();
    end);
    task.delay(1.2, function() -- Line: 83
        -- upvalues: ABC (copy), interface (ref)
        if ABC then
            ABC:Clean();
            interface.StatesController.States.Ability = false;
        end;
    end);
end;