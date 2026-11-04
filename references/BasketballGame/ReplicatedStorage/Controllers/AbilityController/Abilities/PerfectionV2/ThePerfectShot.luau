 
 

game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local CalculateBallTrajectory = require(ReplicatedStorage.Shared.Functions.CalculateBallTrajectory);
local Abilities = require(ReplicatedStorage.Shared.Tables.Cooldowns).Abilities;
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local LocalPlayer = game.Players.LocalPlayer;
local RaycastParams_new_ret = RaycastParams.new();
RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Include;
RaycastParams_new_ret.FilterDescendantsInstances = { workspace.Barriers };

return function(u6) -- Line: 25
    -- upvalues: LocalPlayer (copy), u1 (ref), u2 (ref), u3 (ref), u4 (ref), u5 (ref), Essentials (copy), Effects (copy), Abilities (copy), ReplicatedStorage (copy), TweenService (copy), CalculateBallTrajectory (copy), RunService (copy), RaycastParams_new_ret (copy)
    local Character = LocalPlayer.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local _ = Character.Humanoid;
    u1 = u6.AbilityService;
    u2 = u6.MovementController;
    u3 = u6.BallController;
    u4 = u6.Animations;
    u5 = u6.Network;
    local u7 = Essentials:ReturnRorL(u5.CharValues);

    if not u5.CharValues.HasBall then
        local CharacterPossessingBall = u3:GetCharacterPossessingBall();
        local PlayerPossessingBall = u3:GetPlayerPossessingBall();

        local function RandomOpponent() -- Line: 261
            -- upvalues: Essentials (ref), LocalPlayer (ref), u6 (copy), PlayerPossessingBall (copy)
            local v8 = {};
            local v9 = nil;

            for _, v in game.Teams[Essentials:ActualTeam(LocalPlayer.Team.Name)]:GetPlayers() do
                if v.Character and (u6.PerfectDefense ~= v.Character and v.Character:FindFirstChild("HumanoidRootPart")) then
                    if PlayerPossessingBall == v then
                        v9 = v.Character;
                    end;

                    table.insert(v8, v.Character);
                end;
            end;

            if not v9 and #v8 > 0 then
                v9 = v8[#v8 > 1 and (math.random(1, #v8) or 1) or 1];
            end;

            return v9;
        end;

        if u6.PerfectDefense then
            local v10 = RandomOpponent();

            if not v10 then
                if not u6.PerfectDefense:FindFirstChild("HumanoidRootPart") then
                    u6.PerfectDefense = nil;

                    return;
                end;

                v10 = u6.PerfectDefense;
            end;

            u6:ResetCD(2);
            u6.PerfectDefense = v10;
            u1.Ability:Fire("The Perfect Shot", {
                State = "Defense",
                TimeSent = workspace:GetServerTimeNow(),
                Opponent = v10
            });
            u2.States.Ability = true;
            u6.AC:Add(task.delay(0.25, function() -- Line: 300
                -- upvalues: u2 (ref)
                u2.States.Ability = false;
            end));

            return;
        end;

        if not (CharacterPossessingBall and (PlayerPossessingBall and PlayerPossessingBall.Team ~= LocalPlayer.Team)) then
            u6:ResetCD(2);
            Effects:Popup("Ball must be on opponent!");

            return;
        end;

        if (CharacterPossessingBall.HumanoidRootPart.Position - HumanoidRootPart.Position).Magnitude > 45 then
            u6:ResetCD(2);
            Effects:Popup("Opponent must be close to you!");

            return;
        end;

        local v11 = RandomOpponent();

        if not v11 then
            u6:ResetCD(2);
            Effects:Popup("No opponents to guard!");

            return;
        end;

        Effects:Popup("Pumpfakes are stealable and some unblockable passes are blockable.", 3);
        u6:ResetCD(2);
        u6.PerfectDefense = v11;
        u1.Ability:Fire("The Perfect Shot", {
            Start = true,
            State = "Defense",
            TimeSent = workspace:GetServerTimeNow(),
            Opponent = v11
        });
        u2.States.Ability = true;
        u6.AC:Add(task.delay(0.25, function() -- Line: 334
            -- upvalues: u2 (ref)
            u2.States.Ability = false;
        end));
        u4:StopAll();
        local u12 = u4:PlayChar("PerfectionV2", "PerfectDefense", Enum.AnimationPriority.Action3, true);
        local AlignPosition = Instance.new("AlignPosition");
        AlignPosition.Mode = Enum.PositionAlignmentMode.OneAttachment;
        AlignPosition.Attachment0 = HumanoidRootPart.RootAttachment;
        AlignPosition.ForceLimitMode = Enum.ForceLimitMode.PerAxis;
        AlignPosition.MaxAxesForce = Vector3.new(40000, 0, 40000);
        AlignPosition.Responsiveness = 80;
        AlignPosition.Parent = HumanoidRootPart;
        local u13 = nil;
        task.delay(2, function() -- Line: 350
            -- upvalues: u13 (ref)
            u13 = true;
        end);
        local u14 = 1;
        local u15 = false;
        local u16 = nil;

        local function End() -- Line: 359
            -- upvalues: AlignPosition (copy), u12 (copy), LocalPlayer (ref), u6 (copy), Abilities (ref), u5 (ref), u16 (ref)
            AlignPosition:Destroy();

            if u12 then
                u12:Stop();
            end;

            if not (workspace:GetAttribute("NoAbilityCooldowns") or (LocalPlayer:GetAttribute("NoAbilityCooldowns") or LocalPlayer.Style.Value == "Copycat" and LocalPlayer:GetAttribute("TrueCopycat")) or LocalPlayer.Style.Value == "Thief" and u6.TotalTheft) then
                u6.CDS[2] = tick() + Abilities.PerfectionV2[2];
            end;

            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.Flash.BackgroundTransparency = 1;

            if u5.CharValues.HasBall then
                LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.AbilityName.Text = "The Perfect Shot";
            else
                LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.AbilityName.Text = "Perfect Defense";
            end;

            u16:Disconnect();

            if u6.PerfectDefense then
                u6.PerfectDefense = nil;
            end;

            u6:ResetCopy();
        end;

        u16 = RunService.Heartbeat:Connect(function(p17) -- Line: 387
            -- upvalues: u6 (copy), u13 (ref), End (copy), u3 (ref), u5 (ref), LocalPlayer (ref), RaycastParams_new_ret (ref), AlignPosition (copy), u14 (ref), u15 (ref)
            if not (u6.PerfectDefense and (u6.PerfectDefense:FindFirstChild("HumanoidRootPart") and not u13)) then
                End();

                return;
            end;

            local PlayerPossessingBall2 = u3:GetPlayerPossessingBall();

            if u5.CharValues.HasBall or (not PlayerPossessingBall2 or PlayerPossessingBall2.Team == LocalPlayer.Team) then
                End();

                return;
            end;

            local HumanoidRootPart2 = u6.PerfectDefense.HumanoidRootPart;
            local v18 = workspace:Raycast(HumanoidRootPart2.Position, (HumanoidRootPart2.CFrame.LookVector * Vector3.new(1, 0, 1)).Unit * 5, RaycastParams_new_ret);

            if v18 then
                AlignPosition.Position = v18.Position;
            else
                AlignPosition.Position = HumanoidRootPart2.Position + (HumanoidRootPart2.CFrame.LookVector * Vector3.new(1, 0, 1)).Unit * 5;
            end;

            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.Flash.BackgroundTransparency = u14;

            if u14 > 0.5 and not u15 then
                p17 = -p17 or p17;
            end;

            u14 = u14 + p17;

            if u14 <= 0.5 then
                u15 = true;
            end;

            if u14 >= 1 then
                u15 = false;
            end;
        end);

        return;
    end;

    if u6.Dribble and u6.Dribble ~= "Too Far" then
        if u2.States.PumpFake then
            u6:ResetCD(2);
            Effects:Popup("Can\'t use after a fake!");

            return;
        end;

        u6.CDS[1] = Abilities.PerfectionV2[1];
        u6.Dribble = nil;

        if u6:HoopDist() >= 70 then
            u2.States.Ability = true;
            u6.AC:Add(function() -- Line: 52
                -- upvalues: u2 (ref)
                u2.States.Ability = false;
            end);
            u6.AC:Add(task.delay(1.5, function() -- Line: 55
                -- upvalues: u6 (copy)
                u6.AC:Clean();
            end));
            u1.Ability:Fire("Perfect Dribble", {
                State = "Slam",
                TimeSent = workspace:GetServerTimeNow()
            });
            u4:StopAll();
            u4:PlayChar("PerfectionV2", `PerfectSlam{u7}`, Enum.AnimationPriority.Action3);
            u4:PlayBall("PerfectionV2", `PerfectSlam{u7}Ball`, Enum.AnimationPriority.Action3);
            task.wait(0.35);
            u6.AC:Connect(u1.Ability, function(p19) -- Line: 67
                -- upvalues: ReplicatedStorage (ref), u3 (ref), HumanoidRootPart (copy), TweenService (ref), Character (copy), LocalPlayer (ref), u6 (copy), CalculateBallTrajectory (ref)
                if not p19 then
                    return;
                end;

                if not p19.Slam then
                    if p19.Shoot then
                        u6.AC:Clean();
                        local Value = ReplicatedStorage.Basketball.Value;
                        Value.CFrame = u3:GetLastCharacterToPossessBall().PlrBall.Anims.BALL.CFrame;
                        Value.AssemblyLinearVelocity = CalculateBallTrajectory(Value.Position, workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position, 70);
                    end;

                    return;
                end;

                local Value = ReplicatedStorage.Basketball.Value;
                Value.CFrame = u3:GetLastCharacterToPossessBall().PlrBall.Anims.BALL.CFrame;
                Value.AssemblyLinearVelocity = Vector3.new(0, workspace.Gravity * 0.5666666666666667, 0);
                task.wait(0.2833333333333333);
                Value.AssemblyLinearVelocity = Value.AssemblyLinearVelocity + (Vector3.new(0, -workspace.Gravity * 0.5666666666666667, 0) + (HumanoidRootPart.Position * Vector3.new(1, 0, 1) - Value.Position * Vector3.new(1, 0, 1)) / 0.2833333333333333);
                local LinearVelocity = Instance.new("LinearVelocity");
                LinearVelocity.MaxForce = 40000;
                LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
                LinearVelocity.Parent = HumanoidRootPart;
                TweenService:Create(LinearVelocity, TweenInfo.new(0.2833333333333333, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
                    VectorVelocity = -HumanoidRootPart.CFrame.LookVector * 30 + Vector3.new(0, 12, 0)
                }):Play();
                task.wait(0.2833333333333333);
                local RaycastParams_new_ret2 = RaycastParams.new();
                RaycastParams_new_ret2.FilterType = Enum.RaycastFilterType.Exclude;
                RaycastParams_new_ret2.FilterDescendantsInstances = { Character };
                RaycastParams_new_ret2.CollisionGroup = "Player";
                local v20 = -HumanoidRootPart.CFrame.LookVector * 12 + Vector3.new(0, 0.25, 0);
                local v21 = workspace:Raycast(HumanoidRootPart.Position, v20, RaycastParams_new_ret2);
                local Position = workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position;

                if v21 then
                    local v22 = HumanoidRootPart.Position + (v21.Position - HumanoidRootPart.Position).Unit * (v21.Distance - 1);
                    HumanoidRootPart.CFrame = CFrame.new(v22, (Vector3.new(Position.X, v22.Y, Position.Z)));
                else
                    local v23 = HumanoidRootPart.Position + v20;
                    HumanoidRootPart.CFrame = CFrame.new(v23, (Vector3.new(Position.X, v23.Y, Position.Z)));
                end;

                local u24 = -HumanoidRootPart.CFrame.LookVector;
                TweenService:Create(LinearVelocity, TweenInfo.new(0.31666666666666665, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                    VectorVelocity = (u24 + Vector3.new(0, 0.25, 0)) * 8
                }):Play();
                task.delay(0.31666666666666665, function() -- Line: 109
                    -- upvalues: TweenService (ref), LinearVelocity (copy), u24 (copy)
                    TweenService:Create(LinearVelocity, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                        VectorVelocity = (u24 + Vector3.new(0, -1, 0)) * 55
                    }):Play();
                    task.wait(0.175);
                    LinearVelocity:Destroy();
                end);
            end);

            return;
        end;

        u2.States.Ability = true;
        u2.States.Dunking = true;
        u2.States.NoWalk = true;
        u6.AC:Add(function() -- Line: 132
            -- upvalues: u2 (ref)
            u2.States.Ability = false;
            u2.States.Dunking = false;
            u2.States.NoWalk = false;
        end);
        u6.AC:Add(task.delay(1.5, function() -- Line: 137
            -- upvalues: u6 (copy)
            u6.AC:Clean();
        end));
        u1.Ability:Fire("Perfect Dribble", {
            State = "Dunk",
            TimeSent = workspace:GetServerTimeNow()
        });
        u4:StopAll();
        u4:PlayChar("PerfectionV2", `PerfectSlamDunk{u7}`, Enum.AnimationPriority.Action3);
        u4:PlayBall("PerfectionV2", `PerfectSlamDunk{u7}Ball`, Enum.AnimationPriority.Action3);

        return;
    end;

    if u2.States.PumpFake then
        u6:ResetCD(2);
        Effects:Popup("Can\'t use after a fake!");

        return;
    end;

    if u6:HoopDist() > 115 then
        u6:ResetCD(2);
        Effects:Popup("Too far away from hoop!");

        return;
    end;

    u2.States.Ability = true;
    u6.AC:Add(function() -- Line: 165
        -- upvalues: u2 (ref)
        u2.States.Ability = false;
    end);
    u6.AC:Add(task.delay(1.45, function() -- Line: 168
        -- upvalues: u6 (copy)
        u6.AC:Clean();
    end));
    u1.Ability:Fire("The Perfect Shot", {
        State = "Fade",
        TimeSent = workspace:GetServerTimeNow()
    });
    u4:StopAll();
    u4:PlayChar("PerfectionV2", `ThePerfectShot{u7}`, Enum.AnimationPriority.Action3);
    u4:PlayBall("PerfectionV2", `ThePerfectShot{u7}Ball`, Enum.AnimationPriority.Action3);
    local LinearVelocity = Instance.new("LinearVelocity");
    LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
    LinearVelocity.MaxForce = (1 / 0);
    LinearVelocity.Parent = HumanoidRootPart;
    local Position = HumanoidRootPart.Position;
    local RaycastParams_new_ret2 = RaycastParams.new();
    RaycastParams_new_ret2.FilterType = Enum.RaycastFilterType.Exclude;
    RaycastParams_new_ret2.FilterDescendantsInstances = { Character };
    RaycastParams_new_ret2.CollisionGroup = "Player";
    local v25 = HumanoidRootPart.CFrame.RightVector * (u7 == "R" and -1 or 1) * 12 + Vector3.new(0, 6, 0);
    LinearVelocity.VectorVelocity = HumanoidRootPart.CFrame.RightVector * (u7 == "R" and -1 or 1) * 30;
    task.wait(0.2833333333333333);
    u1.Ability:Fire("Perfect Dribble", {
        State = "Afterimage",
        TimeSent = workspace:GetServerTimeNow(),
        CFrame = HumanoidRootPart.CFrame
    });
    local v26 = workspace:Raycast(HumanoidRootPart.Position, v25, RaycastParams_new_ret2);

    if v26 then
        HumanoidRootPart.CFrame = CFrame.new(HumanoidRootPart.Position + (v26.Position - HumanoidRootPart.Position).Unit * (v26.Distance - 1)) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation());
    else
        HumanoidRootPart.CFrame = CFrame.new(HumanoidRootPart.Position + v25) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation());
    end;

    LinearVelocity.VectorVelocity = Vector3.new(0, -30, 0);
    TweenService:Create(LinearVelocity, TweenInfo.new(0.2833333333333333, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
        VectorVelocity = Vector3.new(0, 0, 0)
    }):Play();
    task.wait(0.2833333333333333);
    local v27 = HumanoidRootPart.CFrame.RightVector * (u7 == "R" and 1 or -1) * 12 + Vector3.new(0, 0.25, 0);
    local v28 = workspace:Raycast(Position, v27, RaycastParams_new_ret2);
    local Position2 = workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position;

    if v28 then
        local v29 = Position + (v28.Position - Position).Unit * (v28.Distance - 1);
        HumanoidRootPart.CFrame = CFrame.new(v29, (Vector3.new(Position2.X, v29.Y, Position2.Z)));
    else
        local v30 = Position + v27;
        HumanoidRootPart.CFrame = CFrame.new(v30, (Vector3.new(Position2.X, v30.Y, Position2.Z)));
    end;

    local u31 = 40;
    local u32 = 0.75;
    local u33 = tick();
    local u35 = RunService.Heartbeat:Connect(function(p34) -- Line: 226
        -- upvalues: u31 (ref), u33 (copy), LinearVelocity (copy), HumanoidRootPart (copy), u32 (ref), u7 (copy)
        if u31 >= 10 then
            if u33 + 0.125 < tick() then
                LinearVelocity.VectorVelocity = (HumanoidRootPart.CFrame.LookVector * -1.1 + Vector3.new(0, u32, 0)) * u31 + HumanoidRootPart.CFrame.RightVector * (u7 == "R" and 1 or -1) * 30;
                u32 = u32 - p34 * 1.75;
            else
                LinearVelocity.VectorVelocity = (HumanoidRootPart.CFrame.LookVector * -1.1 + Vector3.new(0, 0, 0)) * u31 + HumanoidRootPart.CFrame.RightVector * (u7 == "R" and 1 or -1) * 30;
            end;

            u31 = u31 - p34;
        end;
    end);
    task.delay(0.75, function() -- Line: 239
        -- upvalues: u35 (copy), LinearVelocity (copy)
        u35:Disconnect();
        LinearVelocity:Destroy();
    end);
    u6.AC:Connect(u1.Ability, function() -- Line: 244
        -- upvalues: u6 (copy), ReplicatedStorage (ref), u3 (ref), CalculateBallTrajectory (ref), LocalPlayer (ref)
        u6.AC:Clean();
        local Value = ReplicatedStorage.Basketball.Value;
        Value.CFrame = u3:GetLastCharacterToPossessBall().PlrBall.Anims.BALL.CFrame;
        Value.AssemblyLinearVelocity = CalculateBallTrajectory(Value.Position, workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position, 70);
    end);
end;