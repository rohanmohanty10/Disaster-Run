  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
local Players = game:GetService("Players");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("RunService");
require(ReplicatedStorage.Controllers.StylePassiveController);
local AnimationController = require(ReplicatedStorage.Controllers.AnimationController);
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
require(ReplicatedStorage.Packages.Trove);
local StatesController = require(ReplicatedStorage.Controllers.StatesController);
require(ReplicatedStorage.Controllers.CameraController);
require(ReplicatedStorage.Shared.Spring);
require(ReplicatedStorage.Shared.AbilityCleanupTrove);
require(ReplicatedStorage.Packages.Observers);
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local interface = require(ReplicatedStorage.Controllers.AbilityController.interface);
local GodspeedFreeze = require(ReplicatedStorage.AbilityBalancing).GodspeedFreeze;
local LocalPlayer = Players.LocalPlayer;

return function() -- Line: 27
    -- upvalues: AbilityUtils (copy), interface (copy), GodspeedFreeze (copy), AnimationController (copy), StatesController (copy), LocalPlayer (copy), ReplicatedStorage (copy)
    AbilityUtils.rules.offball(nil, false);

    if not (AbilityUtils.rules.offball() and AbilityUtils.rules.slotReady(2)) then
        return;
    end;

    local ABC = interface.ABC;
    local Character, u1, _, _ = AbilityUtils.getCharacter();

    if ABC then
        ABC:Clean();
    end;

    interface:AbilityCooldown("2", GodspeedFreeze.Cooldown);
    interface.Animations:StopAnims();
    local Track = AnimationController:GetTrack("Abilities", "GodspeedFreezeStart");
    Track:Play();
    Track:AdjustSpeed(2);
    task.delay(0.375, function() -- Line: 50
        -- upvalues: u1 (copy)
        local BodyVelocity = Instance.new("BodyVelocity");
        BodyVelocity.MaxForce = Vector3.new(1000000000, 1000000000, 1000000000);
        BodyVelocity.P = 100000;
        BodyVelocity.Velocity = u1.CFrame.LookVector * 30 + Vector3.new(0, 100, 0);
        BodyVelocity.Parent = u1;

        for i = 1, 8 do
            BodyVelocity.Velocity = Vector3.new(BodyVelocity.Velocity.X, BodyVelocity.Velocity.Y * 0.9, BodyVelocity.Velocity.Z);
            task.wait(0.02);
            local _ = i;
        end;

        BodyVelocity.Velocity = Vector3.new(0, 0, 0);
        BodyVelocity:Destroy();
    end);
    StatesController.States.Ability = true;
    interface.AbilityService.Ability:Fire("GodspeedFreeze");
    ABC:Add(task.delay(1.5, function() -- Line: 72
        -- upvalues: ABC (copy)
        ABC:Clean();
    end));
    ABC:Add(interface.AbilityService.Ability:Connect(function(p2, p3) -- Line: 76
        -- upvalues: LocalPlayer (ref), Character (copy), ReplicatedStorage (ref), interface (ref), Track (copy), AnimationController (ref), u1 (copy), AbilityUtils (ref), GodspeedFreeze (ref), ABC (copy)
        if p2 and p3 == "Start" then
            local v4 = tick();
            local v5;

            if LocalPlayer:GetNetworkPing() * 2000 >= 120 then
                v5 = 30;
            else
                v5 = 20;
            end;

            repeat
                task.wait();
            until Character.Values.HasBall.Value or (p2.Char.Value == nil or p2.Char.Value.Values.HasBall.Value == false) and ((Character.HumanoidRootPart.Position - ReplicatedStorage.Football.Value.Position).Magnitude <= v5 and ReplicatedStorage.Football.Value.Position.Y - 9 >= 5) or tick() - v4 >= 0.3;

            if Character.Values.HasBall.Value or (p2.Char.Value == nil or p2.Char.Value.Values.HasBall.Value == false) and ((Character.HumanoidRootPart.Position - ReplicatedStorage.Football.Value.Position).Magnitude <= v5 and ReplicatedStorage.Football.Value.Position.Y - 9 >= 5) then
                interface.AbilityService.Ability:Fire("GodspeedFreeze", "Hit");
                Track:Stop(0);
                local Track2 = AnimationController:GetTrack("Abilities", "GodspeedFreezeHit");
                Track2:Play(0);
                Track2:AdjustSpeed(1.5);
                u1.AssemblyLinearVelocity = Vector3.new(0, 0, 0);
                AbilityUtils.clearMovers(Character);
                local BodyVelocity = Instance.new("BodyVelocity");
                BodyVelocity.MaxForce = Vector3.new(1000000000, 1000000000, 1000000000);
                BodyVelocity.P = 100000;
                BodyVelocity.Velocity = u1.CFrame.LookVector * 10 + Vector3.new(0, 10, 0);
                BodyVelocity.Parent = u1;
                task.delay(0.55, function() -- Line: 113
                    -- upvalues: BodyVelocity (copy)
                    BodyVelocity.Velocity = Vector3.new(0, 0, 0);
                end);
                task.wait(1.0333333333333334);

                if BodyVelocity then
                    BodyVelocity:Destroy();
                end;

                local v6 = AbilityUtils.rules.friendlyTarget(1000, true, false);

                if v6 then
                    p2.AssemblyLinearVelocity = ((v6.HumanoidRootPart.Position - u1.Position).Unit + Vector3.new(0, 0.1, 0)) * math.clamp((v6.HumanoidRootPart.Position - u1.Position).Magnitude * 1.5, 0, 150);
                else
                    p2.AssemblyLinearVelocity = workspace.CurrentCamera.CFrame.LookVector * GodspeedFreeze.ShotPower + GodspeedFreeze.ShotTiltVector;
                end;

                interface.BallController:DragBall(p2);

                if ABC then
                    ABC:Clean();
                end;
            elseif ABC then
                ABC:Clean();
            end;
        end;
    end));
    ABC:Add(function() -- Line: 143
        -- upvalues: ABC (copy), StatesController (ref)
        ABC:Destroy();
        StatesController.States.Ability = false;
    end);
end;