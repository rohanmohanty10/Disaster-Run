  

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
local AbilityUtils = require(ReplicatedStorage2.Shared.AbilityUtils);
local StatesController = require(ReplicatedStorage2.Controllers.StatesController);
local AnimationController = require(ReplicatedStorage2.Controllers.AnimationController);
require(ReplicatedStorage2.Controllers.CameraController);
require(ReplicatedStorage2.Controllers.BallController);
local interface = require(ReplicatedStorage2.Controllers.AbilityController.interface);
local LocalPlayer = Players.LocalPlayer;
local _ = workspace.CurrentCamera;
local ChristmasStampede = require(ReplicatedStorage2.AbilityBalancing).ChristmasStampede;

return function() -- Line: 29
    -- upvalues: AbilityUtils (copy), ChristmasStampede (copy), Popup (copy), LocalPlayer (copy), interface (copy), StatesController (copy), AnimationController (copy), ReplicatedStorage2 (copy), RunService (copy)
    local Football = workspace:FindFirstChild("Football");

    if not (AbilityUtils.rules.offball() and (AbilityUtils.rules.grounded() and AbilityUtils.rules.slotReady(3))) then
        return;
    end;

    if not (Football or AbilityUtils.checks.enemyTarget(ChristmasStampede.ActivationRangeBall, true)) then
        Popup.Popup(LocalPlayer, "Ball must be loose or on an enemy player!");

        return;
    end;

    local Character, u1, _, _ = AbilityUtils.getCharacter();
    local u2 = AbilityUtils.rules.enemyTarget(ChristmasStampede.ActivationRangeBall, true);

    if not (u2 or (not Football or (u1.Position - Football.Position).Magnitude <= ChristmasStampede.ActivationRangeBall)) then
        Popup.Popup(LocalPlayer, "Ball not in range!");

        return;
    end;

    interface:AbilityCooldown(3, ChristmasStampede.Cooldown);
    local ABC = interface.ABC;
    StatesController.States.Ability = true;
    local UseJumpPower = Character.Humanoid.UseJumpPower;

    if not UseJumpPower then
        Character.Humanoid.UseJumpPower = true;
    end;

    Character.Humanoid.JumpPower = 0;
    AbilityUtils.clearMovers(Character);
    local Track = AnimationController:GetTrack("Abilities", "ChristmasStampede");
    Track:Play();
    interface.AbilityService.Ability:Fire("ChristmasStampede", {
        Time = workspace:GetServerTimeNow(),
        Pos = Track.TimePosition
    });
    local u3 = nil;
    local u4 = nil;
    ABC:Add(task.delay(0.3, function() -- Line: 77
        -- upvalues: ReplicatedStorage2 (ref), u1 (copy), u2 (copy), AbilityUtils (ref), Character (copy), ChristmasStampede (ref), ABC (copy), u3 (ref), u4 (ref), RunService (ref), interface (ref)
        local Value = ReplicatedStorage2.Football.Value;
        local LookVector = u1.CFrame.LookVector;

        if Value then
            LookVector = CFrame.new(u1.Position, (Vector3.new(Value.Position.X, u1.Position.Y, Value.Position.Z))).LookVector;
        elseif u2 then
            LookVector = CFrame.new(u1.Position, (Vector3.new(u2.HumanoidRootPart.Position.X, u1.Position.Y, u2.HumanoidRootPart.Position.Z))).LookVector;
        end;

        local u5 = tick();
        local Unit = Vector3.new(LookVector.X, 0, LookVector.Z).Unit;
        local v6, v7 = AbilityUtils.FastDashTo(Character, u1.Position + Vector3.new(LookVector.X, 0, LookVector.Z) * ChristmasStampede.Distance, 4, 0.4);
        ABC:Add(v6);
        ABC:Add(v7);
        task.delay(0.5, function() -- Line: 93
            -- upvalues: u3 (ref), u1 (ref), ChristmasStampede (ref), u4 (ref)
            u3 = Instance.new("BodyVelocity");
            u3.MaxForce = Vector3.new(50000, 0, 50000);
            u3.Velocity = u1.CFrame.LookVector * ChristmasStampede.MoveSpeedValue;
            u3.Parent = u1;
            u4 = Instance.new("BodyGyro");
            u4.Parent = u1;
            u4.MaxTorque = Vector3.new(inf, inf, inf);
        end);
        ABC:Add(RunService.Heartbeat:Connect(function() -- Line: 105
            -- upvalues: u5 (copy), u1 (ref), Unit (copy), u3 (ref), ChristmasStampede (ref), Value (copy), Character (ref), interface (ref)
            if tick() - u5 <= 0.5 then
                u1.CFrame = CFrame.new(u1.Position, u1.Position + Unit);
            end;

            if u3 then
                u3.Velocity = u1.CFrame.LookVector * ChristmasStampede.MoveSpeedValue;
            end;

            if Value and (Value.Char.Value ~= Character and (u1.Position - Value.Position).Magnitude <= 5) then
                interface.AbilityService.Ability:Fire("ChristmasStampede", {
                    Steal = true
                });
            end;
        end));
    end));
    ABC:Add(function() -- Line: 118
        -- upvalues: u3 (ref), u4 (ref), StatesController (ref), UseJumpPower (copy), Character (copy)
        if u3 then
            u3:Destroy();
        end;

        if u4 then
            u4:Destroy();
        end;

        StatesController.States.Ability = false;

        if not UseJumpPower then
            Character.Humanoid.UseJumpPower = false;
        end;

        Character.Humanoid.JumpPower = 50;
    end);
    task.delay(1.87, function() -- Line: 128
        -- upvalues: ABC (copy)
        ABC:Clean();
    end);
end;