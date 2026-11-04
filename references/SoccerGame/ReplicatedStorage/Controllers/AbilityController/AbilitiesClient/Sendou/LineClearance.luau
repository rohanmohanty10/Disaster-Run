  

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
local AbilityBalancing = require(ReplicatedStorage2.AbilityBalancing);
local AbilityUtils = require(ReplicatedStorage2.Shared.AbilityUtils);
local StatesController = require(ReplicatedStorage2.Controllers.StatesController);
local AnimationController = require(ReplicatedStorage2.Controllers.AnimationController);
require(ReplicatedStorage2.Controllers.CameraController);
local BallController = require(ReplicatedStorage2.Controllers.BallController);
local interface = require(ReplicatedStorage2.Controllers.AbilityController.interface);
local _ = Players.LocalPlayer;
local _ = workspace.CurrentCamera;

return function() -- Line: 28
    -- upvalues: AbilityUtils (copy), AbilityBalancing (copy), StatesController (copy), interface (copy), AnimationController (copy), TweenService (copy), BallController (copy)
    if not (AbilityUtils.rules.offball() and (AbilityUtils.rules.grounded() and AbilityUtils.rules.slotReady(2))) then
        return;
    end;

    local LineClearance = AbilityBalancing.LineClearance;
    StatesController.States.Ability = true;
    interface:AbilityCooldown(2, LineClearance.Cooldown);
    local ABC = interface.ABC;
    local Character, v1, v2, _ = AbilityUtils.getCharacter();
    local v3 = v1.CFrame:VectorToObjectSpace(v2.MoveDirection);
    local Unit = v2.MoveDirection.Unit;

    if v3 == Vector3.new(0, 0, 0) then
        Unit = v1.CFrame.LookVector;
        v3 = Vector3.new(0, 0, -1);
    end;

    local v4 = v3.X > 0.1 and "R" or (v3.X < -0.1 and "L" or 0);
    local Track = AnimationController:GetTrack("Abilities", "LineClearance");
    Track.Looped = false;
    Track.Priority = Enum.AnimationPriority.Action3;
    Track:Play();
    interface.AbilityService.Ability:Fire("LineClearance", v4 == 0 and "R" or v4);
    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.MaxForce = Vector3.new(15000, 0, 15000);
    BodyVelocity.Velocity = Unit * LineClearance.MoveSpeedValue;
    BodyVelocity.Parent = Character.PrimaryPart;
    TweenService:Create(BodyVelocity, TweenInfo.new(0.5), {
        Velocity = BodyVelocity.Velocity * 0.1
    }):Play();
    ABC:Add(BodyVelocity);
    task.delay(0.5, BodyVelocity.Destroy, BodyVelocity);
    local BodyGyro = Instance.new("BodyGyro");
    BodyGyro.MaxTorque = Vector3.new(0, 1000000000, 0);
    BodyGyro.CFrame = CFrame.lookAlong(Vector3.new(0, 0, 0), v1.CFrame.LookVector);
    BodyVelocity.Parent = Character.PrimaryPart;
    TweenService:Create(BodyVelocity, TweenInfo.new(0.5), {
        Velocity = BodyVelocity.Velocity * 0.5
    }):Play();
    ABC:Add(BodyVelocity);
    task.delay(0.5, BodyVelocity.Destroy, BodyVelocity);
    local u5 = false;
    task.delay(0.6, function() -- Line: 91
        -- upvalues: u5 (ref), Track (copy), ABC (copy), StatesController (ref)
        if not u5 then
            Track:Stop();
            ABC:Clean();
            StatesController.States.Ability = false;
        end;
    end);
    ABC:Connect(interface.AbilityService.Ability, function(p6, p7) -- Line: 95
        -- upvalues: Track (copy), u5 (ref), BallController (ref)
        Track:Stop(0);
        u5 = true;
        p6.AssemblyLinearVelocity = p7;
        BallController:DragBall(p6);
    end);
    ABC:Add(task.delay(1, function() -- Line: 103
        -- upvalues: ABC (copy), StatesController (ref)
        if ABC then
            ABC:Clean();
            StatesController.States.Ability = false;
        end;
    end));
end;