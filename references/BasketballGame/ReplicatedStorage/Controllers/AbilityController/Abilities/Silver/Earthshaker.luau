 
 

game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
local CameraShaker = require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
require(ReplicatedStorage.Shared.Utility.Essentials);
local Zones = require(ReplicatedStorage.Shared.Tables.Zones);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local LocalPlayer = game.Players.LocalPlayer;
local _ = workspace.CurrentCamera;

return function(u7) -- Line: 23
    -- upvalues: LocalPlayer (copy), u1 (ref), u2 (ref), u3 (ref), u4 (ref), u5 (ref), u6 (ref), Effects (copy), Zones (copy), RunService (copy), CameraShaker (copy), ReplicatedStorage (copy)
    local Character = LocalPlayer.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local Humanoid = Character.Humanoid;
    u1 = u7.BallController;
    u2 = u7.CameraController;
    u3 = u7.MovementController;
    u4 = u7.AbilityService;
    u5 = u7.Animations;
    u6 = u7.Network;

    if not u6.CharValues.HasBall then
        local u8 = tick();
        u3.States.Ability = true;
        u4.Ability:Fire("Earthshaker", {
            State = "Earthshaker Start",
            TimeSent = workspace:GetServerTimeNow()
        });
        local v9 = u7.AC:Add(Instance.new("LinearVelocity"));
        v9.Attachment0 = HumanoidRootPart.RootAttachment;
        v9.MaxForce = 40000;
        v9.Parent = HumanoidRootPart;
        u7.AC:Add(function() -- Line: 180
            -- upvalues: Character (copy), u5 (ref), u8 (copy), u3 (ref), u2 (ref), CameraShaker (ref), HumanoidRootPart (copy), Zones (ref), LocalPlayer (ref), u6 (ref), u4 (ref)
            if not Character.Parent then
                return;
            end;

            u5:StopAll();
            u5:PlayChar("Silver", "EarthshakerJump", Enum.AnimationPriority.Action3, true);
            local v10 = tick() - u8;
            local v11 = math.clamp(v10, 0.5, 2) * 2;
            u3.States.Ability = false;
            u3.Boost = v11 * 10;
            task.delay(1, function() -- Line: 192
                -- upvalues: u3 (ref)
                u3.Boost = 0;
            end);
            u2.CamShake:Shake(CameraShaker.Presets.Meteor);
            local LinearVelocity = Instance.new("LinearVelocity");
            LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
            LinearVelocity.MaxForce = 40000;
            LinearVelocity.Parent = HumanoidRootPart;
            task.delay(0.05, function() -- Line: 202
                -- upvalues: LinearVelocity (copy)
                LinearVelocity:Destroy();
            end);
            LinearVelocity.VectorVelocity = (HumanoidRootPart.CFrame.LookVector * (v11 / 2) + Vector3.new(0, 1, 0) * ((Zones.JumpHeight[LocalPlayer.Zone.Value] and (u6.CharValues.InZone and Zones.JumpHeight[LocalPlayer.Zone.Value]) or 7.2) / 7.2)) * 60 * v11;
            u4.Ability:Fire("Earthshaker", {
                State = "Earthshaker Jump",
                TimeSent = workspace:GetServerTimeNow(),
                Multiplier = v11
            });
        end);
        u7.AC:Connect(RunService.Heartbeat, function() -- Line: 211
            -- upvalues: u6 (ref), u7 (copy)
            if u6.CharValues.HasBall then
                u7.AC:Clean();
            end;
        end);
        u5:StopAll();
        u5:PlayChar("Silver", "Earthshaker", Enum.AnimationPriority.Action3);
        u7.AC:Add(task.delay((LocalPlayer.Style.Value == "Copycat" or LocalPlayer.Style.Value == "Thief") and 0 or 2, function() -- Line: 220
            -- upvalues: u7 (copy)
            u7.AC:Clean();
        end));

        return;
    end;

    if not u7:LookingAtNet() then
        u7:ResetCD(4);
        Effects:Popup("Must look towards the hoop to use ability!");

        return;
    end;

    if Humanoid:GetState() == Enum.HumanoidStateType.Freefall or Humanoid:GetState() == Enum.HumanoidStateType.Jumping then
        u7:ResetCD(4);
        Effects:Popup("Can\'t shoot while in the air!");

        return;
    end;

    local Hoop = workspace.Hoops[LocalPlayer.Team.Name].Hoop;
    local Vector3_new_ret = Vector3.new(Hoop.Position.X, HumanoidRootPart.Position.Y, Hoop.Position.Z);
    local v12 = Vector3_new_ret - HumanoidRootPart.Position;

    if v12:Dot(v12) < 8100 then
        u7:ResetCD(4);
        Effects:Popup("Too close to hoop!", 1);

        return;
    end;

    if v12:Dot(v12) > 22500 then
        u7:ResetCD(4);
        Effects:Popup("Too far away from hoop!", 1);

        return;
    end;

    local u13 = 1;

    if Zones.ZoneIncreasedShootingSpeed[LocalPlayer.Zone.Value] and u6.CharValues.InZone then
        u13 = u13 + 0.2;
    end;

    u3.States.Shooting = true;
    u3.States.Ability = true;
    u3.States.NoWalk = true;
    task.delay(2.5 / u13, function() -- Line: 67
        -- upvalues: u3 (ref)
        u3.States.Shooting = false;
        u3.States.Ability = false;
        u3.States.NoWalk = false;
    end);
    RunService.Heartbeat:Wait();
    HumanoidRootPart.CFrame = CFrame.lookAt(HumanoidRootPart.Position, (Vector3.new(Vector3_new_ret.X, HumanoidRootPart.Position.Y, Vector3_new_ret.Z)));
    u5:StopAll();
    local v14 = u5:PlayChar("Silver", "MonsterAscend", Enum.AnimationPriority.Action3, true);
    local v15 = u5:PlayBall("Silver", "MonsterAscendBall", Enum.AnimationPriority.Action3, true);
    v14:AdjustSpeed(u13);
    v15:AdjustSpeed(u13);
    task.delay(1 / u13, function() -- Line: 83
        -- upvalues: u2 (ref), CameraShaker (ref)
        u2.CamShake:Shake(CameraShaker.Presets.Ankle);
    end);
    task.delay(0.43333333333333335 / u13, function() -- Line: 87
        -- upvalues: HumanoidRootPart (copy), Zones (ref), LocalPlayer (ref), u6 (ref), Character (copy), RunService (ref), u13 (ref)
        local BodyVelocity = Instance.new("BodyVelocity");
        BodyVelocity.Name = "BodyVelocityBasketball";
        BodyVelocity.MaxForce = Vector3.new(inf, inf, inf);
        BodyVelocity.Parent = HumanoidRootPart;
        local u16 = HumanoidRootPart.CFrame.LookVector * -0.25;
        local u17 = 30;
        local u18 = 1.5 * ((Zones.JumpHeight[LocalPlayer.Zone.Value] and (u6.CharValues.InZone and Zones.JumpHeight[LocalPlayer.Zone.Value]) or 7.2) / 7.2);
        local RaycastParams_new_ret = RaycastParams.new();
        RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
        RaycastParams_new_ret.FilterDescendantsInstances = { Character };
        local u19 = tick();
        local u20 = nil;
        u20 = RunService.Heartbeat:Connect(function(p21) -- Line: 103
            -- upvalues: HumanoidRootPart (ref), u16 (copy), RaycastParams_new_ret (copy), u20 (ref), BodyVelocity (copy), u17 (ref), u19 (copy), u18 (ref)
            local v22 = workspace:Raycast(HumanoidRootPart.Position, u16 * 4, RaycastParams_new_ret);

            if v22 and (not v22.Instance.Parent:FindFirstChild("Humanoid") and v22.Instance.CanCollide) then
                u20:Disconnect();
                BodyVelocity:Destroy();
            end;

            if u17 >= 10 then
                if u19 + 0.125 < tick() then
                    BodyVelocity.Velocity = (u16 + Vector3.new(0, u18, 0)) * u17;
                    u18 = u18 - p21 * 1.75;
                else
                    BodyVelocity.Velocity = (u16 + Vector3.new(0, 0, 0)) * u17;
                end;

                u17 = u17 - p21;
            end;
        end);
        task.delay(1.5666666666666667 / u13, function() -- Line: 122
            -- upvalues: u20 (ref), BodyVelocity (copy)
            u20:Disconnect();
            BodyVelocity:Destroy();
        end);
    end);
    u4.Ability:Fire("Earthshaker", {
        State = "Monster Ascend",
        TimeSent = workspace:GetServerTimeNow()
    });
    task.wait(1 / u13);

    if not u7.Network.CharValues.HasBall then
        return;
    end;

    u7.AC:Connect(u4.Ability, function() -- Line: 136
        -- upvalues: u7 (copy), ReplicatedStorage (ref), u3 (ref), u1 (ref), Vector3_new_ret (copy), Hoop (copy), HumanoidRootPart (copy)
        u7.AC:Clean();
        local Value = ReplicatedStorage.Basketball.Value;
        u3.States.Shooting = false;
        u3.States.Ability = false;
        u3.States.NoWalk = false;
        local LastCharacterToPossessBall = u1:GetLastCharacterToPossessBall();
        Value.CFrame = CFrame.new(LastCharacterToPossessBall.PlrBall.Anims.BALL.Position, Vector3_new_ret);
        local _ = Value.Position;
        local v23 = Hoop.Position - Value.Position;
        local v24, v25;

        if (HumanoidRootPart.Position - Hoop.Position).Magnitude <= 30 then
            v24 = v23.Magnitude * 0.0455;
            v25 = 1.35;
        else
            v24 = v23.Magnitude * 0.04;
            v25 = 0.5;
        end;

        local math_log_ret = math.log(v25 + v24);
        Value.AssemblyLinearVelocity = v23 / math_log_ret + Vector3.new(0, workspace.Gravity * math_log_ret * 0.5, 0);
    end);
end;