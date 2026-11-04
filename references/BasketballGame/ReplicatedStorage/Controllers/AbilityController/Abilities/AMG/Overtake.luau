 
 

game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local Abilities = require(ReplicatedStorage.Shared.Tables.Cooldowns).Abilities;
require(ReplicatedStorage.Shared.Functions.CalculateBallTrajectory);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local LocalPlayer = game.Players.LocalPlayer;
local _ = workspace.CurrentCamera;

return function(u7) -- Line: 23
    -- upvalues: LocalPlayer (copy), u1 (ref), u2 (ref), u3 (ref), u4 (ref), u5 (ref), u6 (ref), ReplicatedStorage (copy), RunService (copy), Essentials (copy), Effects (copy), Abilities (copy)
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
        local PlayerPossessingBall = u3:GetPlayerPossessingBall();

        if not (PlayerPossessingBall and (PlayerPossessingBall.Character and PlayerPossessingBall.Team ~= LocalPlayer.Team)) then
            u7:ResetCD(2);
            Effects:Popup("An enemy player with the ball must be close to you!", 4);

            return;
        end;

        local Character2 = PlayerPossessingBall.Character;
        u1.Ability:Fire("Overtake", {
            State = "Overtake",
            TimeSent = workspace:GetServerTimeNow(),
            Other = Character2
        });
        u5:StopAll();
        u5:PlayChar("AMG", "Overtake", Enum.AnimationPriority.Action3);
        u2.States.Ability = true;
        u7.AC:Add(function() -- Line: 175
            -- upvalues: u2 (ref)
            u2.States.Ability = false;
        end);
        u7.AC:Add(task.delay(0.3333333333333333, function() -- Line: 179
            -- upvalues: u7 (copy), u6 (ref), LocalPlayer (ref), Abilities (ref), RunService (ref)
            u7.AC:Clean();

            if u6.CharValues.HasBall then
                u7:ResetCD(2);
                u7.Overtake = true;
                local u8 = 1;
                local u9 = false;
                u7.AC:Add(function() -- Line: 190
                    -- upvalues: u7 (ref), LocalPlayer (ref), Abilities (ref), u6 (ref)
                    task.delay(0.25, function() -- Line: 191
                        -- upvalues: u7 (ref)
                        u7.Overtake = nil;
                    end);

                    if not (workspace:GetAttribute("NoAbilityCooldowns") or (LocalPlayer:GetAttribute("NoAbilityCooldowns") or LocalPlayer.Style.Value == "Copycat" and LocalPlayer:GetAttribute("TrueCopycat")) or LocalPlayer.Style.Value == "Thief" and u7.TotalTheft) then
                        u7.CDS[2] = tick() + Abilities.AMG[2];
                    end;

                    LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.Flash.BackgroundTransparency = 1;

                    if u6.CharValues.HasBall then
                        LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.AbilityName.Text = "Weave";

                        return;
                    end;

                    LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.AbilityName.Text = "Overtake";
                end);
                u7.AC:Connect(RunService.Heartbeat, function(p10) -- Line: 208
                    -- upvalues: u6 (ref), u7 (ref), LocalPlayer (ref), u8 (ref), u9 (ref)
                    if not u6.CharValues.HasBall then
                        u7.AC:Clean();

                        return;
                    end;

                    LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.Flash.BackgroundTransparency = u8;

                    if u8 > 0.5 and not u9 then
                        p10 = -p10 or p10;
                    end;

                    u8 = u8 + p10;

                    if u8 <= 0.5 then
                        u9 = true;
                    end;

                    if u8 >= 1 then
                        u9 = false;
                    end;

                    LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.AbilityName.Text = "Downforce";
                end);
                u7.AC:Add(task.delay(5, function() -- Line: 228
                    -- upvalues: u7 (ref)
                    u7.Overtake = nil;
                    u7.AC:Clean();
                end));
            end;
        end));

        return;
    end;

    if u7.Overtake then
        u7.Overtake = nil;
        u1.Ability:Fire("Overtake", {
            State = "Downforce",
            TimeSent = workspace:GetServerTimeNow()
        });
        u2.States.Ability = true;
        u2.States.NoWalk = true;
        u7.AC:Add(function() -- Line: 43
            -- upvalues: u2 (ref)
            u2.States.Ability = false;
            u2.States.NoWalk = false;
        end);
        u5:StopAll();
        u5:PlayChar("AMG", "Downforce", Enum.AnimationPriority.Action3);
        u5:PlayBall("AMG", "DownforceBall", Enum.AnimationPriority.Action3);
        u7.AC:Add(task.delay(0.9166666666666666, function() -- Line: 52
            -- upvalues: u7 (copy)
            u7.AC:Clean();
        end));

        return;
    end;

    local v11 = HumanoidRootPart.CFrame:VectorToObjectSpace(Humanoid.MoveDirection).X < 0 and "R" or "L";
    local v12 = u7:HoopDist();
    u1.Ability:Fire("Overtake", {
        State = "Weave",
        TimeSent = workspace:GetServerTimeNow(),
        Shot = v12 <= 110
    });
    u2.States.Ability = true;
    u7.AC:Add(function() -- Line: 67
        -- upvalues: u2 (ref)
        u2.States.Ability = false;
    end);
    u5:StopAll();
    local LinearVelocity = Instance.new("LinearVelocity");
    LinearVelocity.ForceLimitMode = Enum.ForceLimitMode.PerAxis;
    LinearVelocity.MaxAxesForce = Vector3.new(40000, 0, 40000);
    LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
    LinearVelocity.Parent = HumanoidRootPart;
    u7.AC:Add(LinearVelocity);
    local u13 = v11 == "R";
    local u14 = "Fake";
    local u15 = 50;

    if v12 > 110 then
        u5:PlayChar("AMG", `Weave{v11}`, Enum.AnimationPriority.Action3);
        u5:PlayBall("AMG", `Weave{v11}Ball`, Enum.AnimationPriority.Action3);
        u7.AC:Add(task.delay(0.65, function() -- Line: 89
            -- upvalues: u7 (copy)
            u7.AC:Clean();
        end));
    else
        u5:PlayChar("AMG", `Weave{v11}Shot`, Enum.AnimationPriority.Action3);
        u5:PlayBall("AMG", `Weave{v11}ShotBall`, Enum.AnimationPriority.Action3);
        u7.AC:Add(task.delay(0.65, function() -- Line: 96
            -- upvalues: u14 (ref)
            u14 = "Roll";
        end));
        u7.AC:Connect(u1.Ability, function(p16) -- Line: 100
            -- upvalues: u7 (copy), ReplicatedStorage (ref), u3 (ref), HumanoidRootPart (copy), LocalPlayer (ref)
            if not p16 or p16.State ~= "Shot" then
                return;
            end;

            u7.AC:Clean();
            local Value = ReplicatedStorage.Basketball.Value;
            Value.CFrame = u3:GetLastCharacterToPossessBall().PlrBall.Anims.BALL.CFrame;
            local v17 = workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position - Value.Position;
            local v18, v19;

            if (HumanoidRootPart.Position - workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position).Magnitude <= 30 then
                v18 = v17.Magnitude * 0.0455;
                v19 = 1.35;
            else
                v18 = v17.Magnitude * 0.04;
                v19 = 0.5;
            end;

            local math_log_ret = math.log(v19 + v18);
            Value.AssemblyLinearVelocity = v17 / math_log_ret + Vector3.new(0, workspace.Gravity * math_log_ret * 0.5, 0);
        end);
        u7.AC:Add(task.delay(1.4666666666666666, function() -- Line: 132
            -- upvalues: u7 (copy)
            u7.AC:Clean();
        end));
    end;

    u7.AC:Connect(RunService.Heartbeat, function(p20) -- Line: 137
        -- upvalues: u14 (ref), u15 (ref), Essentials (ref), HumanoidRootPart (copy), LinearVelocity (copy), u13 (ref)
        if u14 == "Fake" then
            u15 = Essentials:Lerp(u15, 25, (math.clamp(p20 * 5, 0, 1)));
        elseif u14 == "Boost" then
            u15 = Essentials:Lerp(u15, 150, (math.clamp(p20 * 50, 0, 1)));
        elseif u14 == "Roll" then
            u15 = Essentials:Lerp(u15, 25, (math.clamp(p20 * 50, 0, 1)));
        end;

        local Unit = (HumanoidRootPart.CFrame.RightVector * Vector3.new(1, 0, 1)).Unit;
        LinearVelocity.VectorVelocity = (Unit ~= Unit and Vector3.new(0, 0, 0) or Unit) * (u13 and 1 or -1) * u15;
    end);
    u7.AC:Add(task.delay(0.38333333333333336, function() -- Line: 155
        -- upvalues: u13 (ref), u14 (ref)
        u13 = not u13;
        u14 = "Boost";
    end));
end;