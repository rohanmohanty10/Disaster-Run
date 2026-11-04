 
 

game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
require(ReplicatedStorage.Shared.Utility.Essentials);
require(script.Parent.Parent);
local Abilities = require(ReplicatedStorage.Shared.Tables.Cooldowns).Abilities;
local CalculateBallTrajectory = require(ReplicatedStorage.Shared.Functions.CalculateBallTrajectory);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local LocalPlayer = game.Players.LocalPlayer;
local workspace_CurrentCamera = workspace.CurrentCamera;

return function(u7) -- Line: 24
    -- upvalues: LocalPlayer (copy), u1 (ref), u2 (ref), u3 (ref), u4 (ref), u5 (ref), u6 (ref), Effects (copy), TweenService (copy), workspace_CurrentCamera (copy), RunService (copy), ReplicatedStorage (copy), CalculateBallTrajectory (copy), Abilities (copy)
    local Character = LocalPlayer.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local Humanoid = Character.Humanoid;
    u1 = u7.AbilityService;
    u2 = u7.MovementController;
    u3 = u7.BallController;
    u4 = u7.CameraController;
    u5 = u7.Animations;
    u6 = u7.Network;

    if not u6.CharValues.HasBall then
        local v8 = u7:CheckInfront(50);

        if not v8 then
            u7:ResetCD(1);
            Effects:Popup("Someone must be infront of you!");

            return;
        end;

        u7:ResetCopy();
        u1.Ability:Fire("Lapse", {
            State = "Pull",
            TimeSent = workspace:GetServerTimeNow(),
            Other = v8
        });
        u5:StopAll();
        u5:PlayChar("HonoredOne", "PullBlue", Enum.AnimationPriority.Action3);
        u2.States.Ability = true;
        u2.States.NoWalk = true;
        task.delay(0.6666666666666666, function() -- Line: 307
            -- upvalues: u2 (ref)
            u2.States.Ability = false;
            u2.States.NoWalk = false;
        end);

        return;
    end;

    if not u7.Dribble then
        if u2.States.PumpFake then
            Effects:Popup("Can\'t use after a fake!");
            u7:ResetCD(1);

            return;
        end;

        u1.Ability:Fire("Lapse", {
            State = "Dribble",
            TimeSent = workspace:GetServerTimeNow()
        });
        u5:StopAll();
        u5:PlayChar("HonoredOne", "DribbleBlue", Enum.AnimationPriority.Action3);
        u5:PlayBall("HonoredOne", "DribbleBlueBall", Enum.AnimationPriority.Action3);
        u7.Dribble = true;
        u2.States.Ability = true;
        u7.AC:Add(task.delay(2.1, function() -- Line: 213
            -- upvalues: u2 (ref)
            u2.States.Ability = false;
        end));
        local LinearVelocity = Instance.new("LinearVelocity");
        LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
        LinearVelocity.MaxForce = (1 / 0);
        LinearVelocity.Parent = HumanoidRootPart;
        u7.AC:Add(LinearVelocity);
        u7.AC:Connect(RunService.Heartbeat, function() -- Line: 224
            -- upvalues: LinearVelocity (ref), Humanoid (copy)
            if not LinearVelocity then
                return;
            end;

            LinearVelocity.VectorVelocity = Humanoid.MoveDirection * Vector3.new(1, 0, 1) * Humanoid.WalkSpeed;
        end);
        u7.AC:Add(task.delay(2.1, function() -- Line: 229
            -- upvalues: u7 (copy), LinearVelocity (ref), LocalPlayer (ref), Abilities (ref), u6 (ref), RunService (ref)
            u7:ResetCD(1);
            LinearVelocity:Destroy();
            LinearVelocity = nil;
            local u9 = nil;
            task.delay(3, function() -- Line: 236
                -- upvalues: u9 (ref)
                u9 = true;
            end);
            local u10 = 1;
            local u11 = false;
            local u12 = nil;

            local function End() -- Line: 245
                -- upvalues: LocalPlayer (ref), u7 (ref), Abilities (ref), u6 (ref), u12 (ref)
                if not (workspace:GetAttribute("NoAbilityCooldowns") or (LocalPlayer:GetAttribute("NoAbilityCooldowns") or LocalPlayer.Style.Value == "Copycat" and LocalPlayer:GetAttribute("TrueCopycat")) or LocalPlayer.Style.Value == "Thief" and u7.TotalTheft) then
                    u7.CDS[1] = tick() + Abilities.HonoredOne[1];
                end;

                LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = 1;

                if u6.CharValues.HasBall then
                    LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "Lapse Dribble";
                else
                    LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "Lapse Pull";
                end;

                u12:Disconnect();
                u7.AC:Clean();
                u7.Dribble = nil;
                u7:ResetCopy();
            end;

            u12 = RunService.Heartbeat:Connect(function(p13) -- Line: 265
                -- upvalues: u7 (ref), u9 (ref), End (copy), u6 (ref), LocalPlayer (ref), u10 (ref), u11 (ref)
                if not u7.Dribble or u9 then
                    End();

                    return;
                end;

                if not u6.CharValues.HasBall then
                    End();

                    return;
                end;

                LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = u10;

                if u10 > 0.5 and not u11 then
                    p13 = -p13 or p13;
                end;

                u10 = u10 + p13;

                if u10 <= 0.5 then
                    u11 = true;
                end;

                if u10 >= 1 then
                    u11 = false;
                end;

                LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "Lapse Shot";
            end);
        end));

        return;
    end;

    local Hoop = workspace.Hoops[LocalPlayer.Team.Name].Hoop;
    local v14 = Vector3.new(Hoop.Position.X, HumanoidRootPart.Position.Y, Hoop.Position.Z) - HumanoidRootPart.Position;

    if v14:Dot(v14) < 8100 then
        u7:ResetCD(1);
        Effects:Popup("Too close to hoop!", 1);

        return;
    end;

    if v14:Dot(v14) > 22500 then
        u7:ResetCD(1);
        Effects:Popup("Too far away from hoop!", 1);

        return;
    end;

    u7:ResetCopy();
    Effects:Popup("Enemies must block the curve to stop the shot!");
    u7.Dribble = nil;
    u1.Ability:Fire("Lapse", {
        State = "Shot",
        TimeSent = workspace:GetServerTimeNow()
    });
    u2.States.Ability = true;
    u2.States.NoWalk = true;
    u2.States.AimAssist = true;
    task.delay(2.1, function() -- Line: 64
        -- upvalues: u2 (ref)
        u2.States.Ability = false;
        u2.States.NoWalk = false;
        u2.States.AimAssist = false;
    end);
    u5:StopAll();
    u5:PlayChar("HonoredOne", "ShotBlue", Enum.AnimationPriority.Action3);
    u5:PlayBall("HonoredOne", "ShotBlueBall", Enum.AnimationPriority.Action3);
    task.spawn(function() -- Line: 74
        -- upvalues: TweenService (ref), workspace_CurrentCamera (ref)
        TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.5), {
            FieldOfView = 50
        }):Play();
        task.wait(0.5);
        TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.31666666666666665), {
            FieldOfView = 100
        }):Play();
        task.wait(0.31666666666666665);
        TweenService:Create(workspace_CurrentCamera, TweenInfo.new(1), {
            FieldOfView = 70
        }):Play();
    end);
    task.wait(0.13333333333333333);
    local u15 = 30;
    local u16 = 0.75;
    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.Name = "BodyVelocityBasketball";
    BodyVelocity.Parent = HumanoidRootPart;
    BodyVelocity.MaxForce = Vector3.new(inf, inf, inf);
    local u17 = tick();
    local u19 = RunService.Heartbeat:Connect(function(p18) -- Line: 94
        -- upvalues: u15 (ref), u17 (copy), BodyVelocity (copy), HumanoidRootPart (copy), u16 (ref)
        if u15 >= 10 then
            if u17 + 0.125 < tick() then
                BodyVelocity.Velocity = (-HumanoidRootPart.CFrame.LookVector / 2 + Vector3.new(0, u16, 0)) * u15;
                u16 = u16 - p18 * 1.75;
            else
                BodyVelocity.Velocity = (-HumanoidRootPart.CFrame.LookVector / 2 + Vector3.new(0, 0, 0)) * u15;
            end;

            u15 = u15 - p18;
        end;
    end);
    task.delay(1, function() -- Line: 106
        -- upvalues: u19 (ref), BodyVelocity (copy)
        if u19 then
            u19:Disconnect();
        end;

        BodyVelocity:Destroy();
    end);
    local v20 = Humanoid.MoveDirection:Dot(HumanoidRootPart.CFrame.RightVector);
    local u21 = v20 > 0 and 1 or (v20 < 0 and -1 or (math.random(1, 2) == 1 and 1 or -1));
    u7.AC:Connect(u1.Ability, function(p22) -- Line: 117
        -- upvalues: u21 (copy), u2 (ref), ReplicatedStorage (ref), LocalPlayer (ref), HumanoidRootPart (copy), CalculateBallTrajectory (ref), u7 (copy)
        local v23 = 30 * u21;

        if p22.State == "Shot Blue" then
            u2.States.AimAssist = false;
            local Value = ReplicatedStorage.Basketball.Value;
            local Hoop2 = workspace.Hoops[LocalPlayer.Team.Name].Hoop;
            local v24 = HumanoidRootPart.CFrame * CFrame.new(0, 0, -(Value.Position - Hoop2.Position).Magnitude / 2);
            Value.AssemblyLinearVelocity = CalculateBallTrajectory(Value.Position, Vector3.new(v24.Position.X, Hoop2.Position.Y, v24.Position.Z), 35, workspace.Gravity);

            return;
        end;

        if p22.State == "Shot Blue Curve" then
            u7.AC:Clean();
            local Value = ReplicatedStorage.Basketball.Value;
            local Hoop2 = workspace.Hoops[LocalPlayer.Team.Name].Hoop;
            local RaycastParams_new_ret = RaycastParams.new();
            RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Include;
            RaycastParams_new_ret.FilterDescendantsInstances = { workspace.Barriers };

            if workspace:Raycast(Value.Position, Value.CFrame.RightVector * v23, RaycastParams_new_ret) then
                v23 = v23 * -1;
            end;

            local v25 = CalculateBallTrajectory(Value.Position, Hoop2.Position, 70, workspace.Gravity);
            local Unit = Vector3.new(v25.X, 0, v25.Z).Unit:Cross(Vector3.new(0, 1, 0)).Unit;
            local v26 = (math.sqrt(4900 - 2 * (Hoop2.Position - Value.Position).Y * workspace.Gravity) + 70) / workspace.Gravity;
            local Mass = Value:GetMass();
            local BodyForce = Instance.new("BodyForce");
            BodyForce.Name = "CurveVelocity";
            BodyForce.Force = -Unit * (2 * (v23 * v26) / v26 ^ 2 * Mass);
            BodyForce.Parent = Value;
            Value.AssemblyLinearVelocity = v25 + Unit * v23;
            local v27 = 0;

            while v27 < v26 do
                local v28 = Value.Position - Hoop2.Position;

                if v28:Dot(v28) <= 4 then
                    break;
                end;

                v27 = v27 + task.wait();
            end;

            BodyForce:Destroy();
        end;
    end);
end;