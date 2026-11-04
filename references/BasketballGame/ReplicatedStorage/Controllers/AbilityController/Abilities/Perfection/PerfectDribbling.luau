 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
require(script.Parent.Parent);
require(ReplicatedStorage.Shared.Tables.Cooldowns);
local CalculateBallTrajectory = require(ReplicatedStorage.Shared.Functions.CalculateBallTrajectory);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local LocalPlayer = game.Players.LocalPlayer;

return function(u7) -- Line: 23, Name: PerfectDribbling
    -- upvalues: LocalPlayer (copy), u1 (ref), u3 (ref), u2 (ref), u4 (ref), u6 (ref), u5 (ref), Essentials (copy), TweenService (copy), ReplicatedStorage (copy), CalculateBallTrajectory (copy), RunService (copy), Effects (copy)
    local Character = LocalPlayer.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local _ = Character.Humanoid;
    u1 = u7.AbilityService;
    u3 = u7.Animations;
    u2 = u7.MovementController;
    u4 = u7.BallController;
    u6 = u7.Network;
    u5 = u7.CameraController;

    if u2.States.PumpFake then
        u7:ResetCD(1);

        return;
    end;

    if not u7.PerfectDribbled then
        local v8 = u7:CheckInfront(25);

        if not v8 then
            u7:ResetCD(1);
            Effects:Popup("Someone must be infront of you!");

            return;
        end;

        u2.States.Ability = true;
        u2.Boost = 5;
        u1.Ability:Fire("PerfectDribbling", {
            Style = "Dribbling",
            TimeSent = workspace:GetServerTimeNow(),
            Other = v8
        });
        task.delay(0.55, function() -- Line: 221
            -- upvalues: u2 (ref), u7 (copy), LocalPlayer (ref), RunService (ref), u6 (ref)
            u2.States.NoWalk = false;
            task.delay(0.15, function() -- Line: 224
                -- upvalues: u2 (ref), u7 (ref), LocalPlayer (ref), RunService (ref), u6 (ref)
                u2.States.Ability = false;
                u2.Boost = 0;

                if u7:HoopDist() > 115 then
                    return;
                end;

                u7.PerfectDribbled = true;
                u7:ResetCD(1);
                local u9 = 1;
                local u10 = false;
                local u11 = nil;

                local function endAll() -- Line: 238
                    -- upvalues: u7 (ref), LocalPlayer (ref), u11 (ref)
                    u7:ResetCopy();

                    if not (workspace:GetAttribute("NoAbilityCooldowns") or (LocalPlayer:GetAttribute("NoAbilityCooldowns") or LocalPlayer.Style.Value == "Copycat" and LocalPlayer:GetAttribute("TrueCopycat")) or LocalPlayer.Style.Value == "Thief" and u7.TotalTheft) then
                        u7.CDS[1] = tick() + 60;
                    end;

                    u11:Disconnect();
                    u7.PerfectDribbled = false;
                    LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = 1;
                end;

                u11 = RunService.Heartbeat:Connect(function(p12) -- Line: 247
                    -- upvalues: u7 (ref), endAll (copy), u6 (ref), LocalPlayer (ref), u9 (ref), u10 (ref)
                    if not u7.PerfectDribbled then
                        endAll();

                        return;
                    end;

                    if not u6.CharValues.HasBall then
                        endAll();

                        return;
                    end;

                    if u7:HoopDist() >= 110 then
                        endAll();

                        return;
                    end;

                    LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = u9;

                    if u9 > 0.5 and not u10 then
                        p12 = -p12 or p12;
                    end;

                    u9 = u9 + p12;

                    if u9 <= 0.5 then
                        u10 = true;
                    end;

                    if u9 >= 1 then
                        u10 = false;
                    end;

                    LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "Perfect Step";
                end);
                task.delay(3, function() -- Line: 261
                    -- upvalues: endAll (copy)
                    endAll();
                end);
            end);
            u7.AC:Clean();
        end);
        u3:StopAll();
        local v13 = u3:PlayChar("Perfection", `PD{Essentials:ReturnRorL(u6.CharValues)}`, Enum.AnimationPriority.Action3, true);
        local v14 = u3:PlayBall("Perfection", `PD{Essentials:ReturnRorL(u6.CharValues)}Ball`, Enum.AnimationPriority.Action3, true);
        v13.TimePosition = 0.4;
        v14.TimePosition = 0.4;
        local LinearVelocity = Instance.new("LinearVelocity");
        LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
        LinearVelocity.MaxForce = (1 / 0);
        LinearVelocity.Parent = HumanoidRootPart;
        local BodyGyro = Instance.new("BodyGyro");
        BodyGyro.Name = "GyroBasketball";
        BodyGyro.MaxTorque = Vector3.new(1, 1, 1) * (1 / 0);
        BodyGyro.Parent = HumanoidRootPart;
        u7.AC:Add(LinearVelocity);
        u7.AC:Add(BodyGyro);
        local v15 = Essentials:ReturnRorL(u6.CharValues) == "L" and -HumanoidRootPart.CFrame.RightVector or HumanoidRootPart.CFrame.RightVector;
        local Unit = (v8.HumanoidRootPart.Position - HumanoidRootPart.Position).Unit;
        local Vector3_new_ret = Vector3.new(Unit.X, 0, Unit.Z);
        LinearVelocity.VectorVelocity = Vector3_new_ret * 30;
        TweenService:Create(LinearVelocity, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
            VectorVelocity = ((v8.HumanoidRootPart.Position - HumanoidRootPart.Position).Unit + v15 * 1.5) * 40
        }):Play();
        task.wait(0.2);
        TweenService:Create(LinearVelocity, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            VectorVelocity = (Vector3_new_ret * 1.5 + -v15 * 1.05) * 50
        }):Play();
        task.wait(0.2);
        TweenService:Create(LinearVelocity, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
            VectorVelocity = Vector3_new_ret * 40
        }):Play();

        return;
    end;

    u7.PerfectDribbled = false;
    local v16 = u7:HoopDist();
    u7:ResetCopy();

    if v16 <= 35 then
        u4:Dunk("PDDunk", "PDDunk", true);
        u1.Ability:Fire("PerfectDribbling", {
            Style = "Dunk",
            TimeSent = workspace:GetServerTimeNow()
        });

        return;
    end;

    if v16 < 70 then
        u1.Ability:Fire("PerfectDribbling", {
            Shot = true,
            Style = "Euro",
            TimeSent = workspace:GetServerTimeNow()
        });
        task.delay(0.3, function() -- Line: 140
            -- upvalues: u1 (ref)
            u1.Ability:Fire("PerfectDribbling", {
                Shot = true,
                TimeSent = workspace:GetServerTimeNow()
            });
        end);
        u2.States.Ability = true;
        u3:PlayChar("Perfection", `PDLayup{Essentials:ReturnRorL(u6.CharValues)}`, Enum.AnimationPriority.Action3, true);
        u3:PlayBall("Perfection", `PDLayup{Essentials:ReturnRorL(u6.CharValues)}Ball`, Enum.AnimationPriority.Action3, true);
        local LinearVelocity = Instance.new("LinearVelocity");
        LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
        LinearVelocity.MaxForce = (1 / 0);
        LinearVelocity.Parent = HumanoidRootPart;
        local Hoop = workspace.Hoops[LocalPlayer.Team.Name].Hoop;
        local Unit = (Vector3.new(Hoop.Position.X, HumanoidRootPart.Position.Y, Hoop.Position.Z) - HumanoidRootPart.Position).Unit;
        local Vector3_new_ret = Vector3.new(Unit.X, 0, Unit.Z);
        local u17 = Essentials:ReturnRorL(u6.CharValues) == "L" and -HumanoidRootPart.CFrame.RightVector or HumanoidRootPart.CFrame.RightVector;
        LinearVelocity.VectorVelocity = (Vector3_new_ret + u17 / 2) * 55;
        TweenService:Create(LinearVelocity, TweenInfo.new(0.42, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
            VectorVelocity = (Vector3_new_ret * 1.55 + u17 / 2) * 30
        }):Play();
        task.delay(0.42, function() -- Line: 163
            -- upvalues: TweenService (ref), LinearVelocity (copy), Vector3_new_ret (ref), u17 (copy)
            TweenService:Create(LinearVelocity, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                VectorVelocity = ((Vector3_new_ret + -u17 / 1.5) / 2 + Vector3.new(0, 1, 0)) * 40
            }):Play();
        end);
        task.delay(0.7, function() -- Line: 166
            -- upvalues: TweenService (ref), LinearVelocity (copy), Vector3_new_ret (ref)
            TweenService:Create(LinearVelocity, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                VectorVelocity = (Vector3_new_ret + Vector3.new(0, -0.25, 0)) * 50
            }):Play();
        end);
        task.delay(1, function() -- Line: 169
            -- upvalues: u2 (ref), LinearVelocity (copy)
            u2.States.Ability = false;
            LinearVelocity:Destroy();
        end);
        local u18 = nil;
        u18 = RunService.Heartbeat:Connect(function() -- Line: 174
            -- upvalues: Hoop (copy), HumanoidRootPart (copy), LinearVelocity (copy), u18 (ref)
            if (Vector3.new(Hoop.Position.X, HumanoidRootPart.Position.Y, Hoop.Position.Z) - HumanoidRootPart.Position).Magnitude < 10 then
                LinearVelocity.Enabled = false;
                u18:Disconnect();
            end;
        end);
        u7.AC:Add(u18);
        u7.AC:Connect(u1.Ability, function() -- Line: 184
            -- upvalues: u7 (copy), ReplicatedStorage (ref), u4 (ref), CalculateBallTrajectory (ref), LocalPlayer (ref)
            u7.AC:Clean();
            local Value = ReplicatedStorage.Basketball.Value;
            Value.CFrame = u4:GetLastCharacterToPossessBall().PlrBall.Anims.BALL.CFrame;
            Value.AssemblyLinearVelocity = CalculateBallTrajectory(Value.Position, workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position, 50);
        end);

        return;
    end;

    u2.States.Ability = true;
    u2.States.NoWalk = true;
    u7.AC:Add(task.delay(1.25, function() -- Line: 51
        -- upvalues: u2 (ref), u7 (copy)
        u2.States.Ability = false;
        u2.States.NoWalk = false;
        u7.AC:Clean();
    end));
    local v19 = u3:PlayChar("Perfection", `PDPoint{Essentials:ReturnRorL(u6.CharValues)}`, Enum.AnimationPriority.Action3, true);
    local v20 = u3:PlayBall("Perfection", `PDPoint{Essentials:ReturnRorL(u6.CharValues)}Ball`, Enum.AnimationPriority.Action3, true);
    v19.TimePosition = 0.7;
    v20.TimePosition = 0.7;
    local RaycastParams_new_ret = RaycastParams.new();
    RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
    RaycastParams_new_ret.FilterDescendantsInstances = { Character };
    local v21 = HumanoidRootPart.CFrame.LookVector * -12 + Vector3.new(0, 2.5, 0);
    local v22 = workspace:Raycast(HumanoidRootPart.Position, v21, RaycastParams_new_ret);
    local Position = workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position;

    if v22 then
        HumanoidRootPart.CFrame = CFrame.new(HumanoidRootPart.Position + (v22.Position - HumanoidRootPart.Position) * (v22.Distance / 2), (Vector3.new(Position.X, HumanoidRootPart.Position.Y, Position.Z)));
    else
        HumanoidRootPart.CFrame = CFrame.new(HumanoidRootPart.Position + v21, (Vector3.new(Position.X, HumanoidRootPart.Position.Y, Position.Z)));
    end;

    local LinearVelocity = Instance.new("LinearVelocity");
    LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
    LinearVelocity.MaxForce = (1 / 0);
    LinearVelocity.Parent = HumanoidRootPart;
    LinearVelocity.VectorVelocity = (-HumanoidRootPart.CFrame.LookVector + Vector3.new(0, 0.25, 0)) * 45;
    local BodyGyro = Instance.new("BodyGyro");
    BodyGyro.Name = "GyroBasketball";
    BodyGyro.MaxTorque = Vector3.new(1, 1, 1) * (1 / 0);
    BodyGyro.CFrame = CFrame.new(HumanoidRootPart.Position, (Vector3.new(Position.X, HumanoidRootPart.Position.Y, Position.Z)));
    BodyGyro.Parent = HumanoidRootPart;
    local u23 = -HumanoidRootPart.CFrame.LookVector;
    TweenService:Create(LinearVelocity, TweenInfo.new(0.75, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        VectorVelocity = (-HumanoidRootPart.CFrame.LookVector + Vector3.new(0, 0.25, 0)) * 8
    }):Play();
    task.delay(0.75, function() -- Line: 99
        -- upvalues: TweenService (ref), LinearVelocity (copy), u23 (copy), BodyGyro (copy)
        TweenService:Create(LinearVelocity, TweenInfo.new(0.5, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
            VectorVelocity = (u23 - Vector3.new(0, 1, 0)) * 55
        }):Play();
        task.wait(0.175);
        LinearVelocity:Destroy();
        BodyGyro:Destroy();
    end);
    u7.AC:Connect(u1.Ability, function() -- Line: 106
        -- upvalues: u7 (copy), u2 (ref), ReplicatedStorage (ref), u4 (ref), CalculateBallTrajectory (ref), LocalPlayer (ref)
        u7.AC:Clean();
        u2.States.Ability = false;
        u2.States.NoWalk = false;
        local Value = ReplicatedStorage.Basketball.Value;
        Value.CFrame = u4:GetLastCharacterToPossessBall().PlrBall.Anims.BALL.CFrame;
        Value.AssemblyLinearVelocity = CalculateBallTrajectory(Value.Position, workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position, 70);
    end);
    u1.Ability:Fire("PerfectDribbling", {
        Shot = true,
        Style = "Fadeaway",
        TimeSent = workspace:GetServerTimeNow()
    });
end;