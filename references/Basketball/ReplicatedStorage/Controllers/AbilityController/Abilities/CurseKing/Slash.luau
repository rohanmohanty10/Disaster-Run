 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
require(script.Parent.Parent);
local Abilities = require(ReplicatedStorage.Shared.Tables.Cooldowns).Abilities;
require(ReplicatedStorage.Shared.Tables.Zones);
require(ReplicatedStorage.Shared.Utility.Trove);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local LocalPlayer = game.Players.LocalPlayer;
local _ = workspace.CurrentCamera;

return function(u7) -- Line: 25
    -- upvalues: LocalPlayer (copy), u1 (ref), u2 (ref), u3 (ref), u4 (ref), u5 (ref), u6 (ref), ReplicatedStorage (copy), Effects (copy), Essentials (copy), Players (copy), RunService (copy), Abilities (copy)
    local Character = LocalPlayer.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local _ = Character.Humanoid;
    u1 = u7.AbilityService;
    u2 = u7.MovementController;
    u3 = u7.CameraController;
    u4 = u7.BallController;
    u5 = u7.Animations;
    u6 = u7.Network;

    if not u6.CharValues.HasBall then
        if ReplicatedStorage.GameValues.Scoring.Value then
            u7:ResetCD(1);
            Effects:Popup("Can\'t use after a goal!");

            return;
        end;

        local PlayerPossessingBall = u4:GetPlayerPossessingBall();
        local LastCharacterToPossessBall = u4:GetLastCharacterToPossessBall();

        if PlayerPossessingBall or not (LastCharacterToPossessBall and (Players:GetPlayerFromCharacter(LastCharacterToPossessBall) and Players:GetPlayerFromCharacter(LastCharacterToPossessBall).Team == LocalPlayer.Team)) then
            u7:ResetCD(1);
            Effects:Popup("Ball must just have been shot by yourself or a teammate!");

            return;
        end;

        local Value = ReplicatedStorage.Basketball.Value;

        if Value.Parent ~= workspace then
            u7:ResetCD(1);
            Effects:Popup("Ball must be in air!");

            return;
        end;

        local ServerBallPosition = u4:GetServerBallPosition();

        if (HumanoidRootPart.Position * Vector3.new(1, 0, 1) - ServerBallPosition * Vector3.new(1, 0, 1)).Magnitude > (LastCharacterToPossessBall == Character and 10 or 5) and Value.Position.Y < 4 or Value.Position.Y < 8 then
            u7:ResetCD(1);
            Effects:Popup("Ball is too close to the ground!");

            return;
        end;

        local ServerBallPosition2 = u4:GetServerBallPosition();

        if (HumanoidRootPart.Position * Vector3.new(1, 0, 1) - ServerBallPosition2 * Vector3.new(1, 0, 1)).Magnitude > (LastCharacterToPossessBall == Character and 50 or 25) then
            u7:ResetCD(1);
            Effects:Popup("Ball is too far away!");

            return;
        end;

        if LastCharacterToPossessBall:GetAttribute("Unblockable") and LastCharacterToPossessBall:GetAttribute("Unblockable") > workspace:GetServerTimeNow() then
            u7:ResetCD(1);
            Effects:Popup("Can\'t rebound shot!");

            return;
        end;

        u1.Ability:Fire("Slash", {
            State = "Rebound",
            TimeSent = workspace:GetServerTimeNow()
        });
        u7.AC:Connect(u1.Ability, function(p8) -- Line: 153
            -- upvalues: u7 (copy), u2 (ref), ReplicatedStorage (ref), u4 (ref), HumanoidRootPart (copy), u6 (ref), RunService (ref), LocalPlayer (ref), Abilities (ref), Effects (ref)
            u7.AC:Clean();

            if p8 then
                if p8.State == "Success" then
                    u2.States.Ability = true;
                    u2.States.NoWalk = true;
                    task.delay(1.25, function() -- Line: 160
                        -- upvalues: u2 (ref)
                        u2.States.Ability = false;
                        u2.States.NoWalk = false;
                    end);
                    local Value2 = ReplicatedStorage.Basketball.Value;
                    local ServerBallPosition3 = u4:GetServerBallPosition();
                    local Unit = (HumanoidRootPart.Position - ServerBallPosition3).Unit;
                    local Magnitude = (HumanoidRootPart.Position - ServerBallPosition3).Magnitude;
                    local LinearVelocity = Instance.new("LinearVelocity");
                    LinearVelocity.Attachment0 = Value2.Root;
                    LinearVelocity.MaxForce = 40000;
                    LinearVelocity.VectorVelocity = Unit * Magnitude / 0.75;
                    LinearVelocity.Parent = Value2;
                    u7.AC:Add(LinearVelocity);
                    task.wait(0.75);
                    LinearVelocity:Destroy();
                    local v9 = tick();

                    repeat
                        task.wait();
                    until tick() - v9 > 1.5 or u6.CharValues.HasBall;

                    if not u6.CharValues.HasBall then
                        return;
                    end;

                    u7.Rebound = true;
                    u7:ResetCD(1);
                    local u10 = nil;
                    task.delay(5, function() -- Line: 190
                        -- upvalues: u10 (ref)
                        u10 = true;
                    end);
                    local u11 = 1;
                    local u12 = false;
                    local u13 = nil;
                    u13 = RunService.Heartbeat:Connect(function(p14) -- Line: 198
                        -- upvalues: u7 (ref), ReplicatedStorage (ref), u10 (ref), LocalPlayer (ref), Abilities (ref), u6 (ref), u13 (ref), u11 (ref), u12 (ref)
                        if not u7.Rebound or (ReplicatedStorage.GameValues.Scoring.Value or u10) then
                            if not (workspace:GetAttribute("NoAbilityCooldowns") or (LocalPlayer:GetAttribute("NoAbilityCooldowns") or LocalPlayer.Style.Value == "Copycat" and LocalPlayer:GetAttribute("TrueCopycat")) or LocalPlayer.Style.Value == "Thief" and u7.TotalTheft) then
                                u7.CDS[1] = tick() + Abilities.CurseKing[1];
                            end;

                            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = 1;

                            if u6.CharValues.HasBall then
                                LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "World Red Slash";
                            else
                                LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "Rebound";
                            end;

                            u13:Disconnect();
                            u7.AC:Clean();
                            u7:ResetCopy();
                            u7.Rebound = nil;

                            return;
                        end;

                        if u6.CharValues.HasBall then
                            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = u11;

                            if u11 > 0.5 and not u12 then
                                p14 = -p14 or p14;
                            end;

                            u11 = u11 + p14;

                            if u11 <= 0.5 then
                                u12 = true;
                            end;

                            if u11 >= 1 then
                                u12 = false;
                            end;

                            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "Slash Layup";

                            return;
                        end;

                        if not (workspace:GetAttribute("NoAbilityCooldowns") or (LocalPlayer:GetAttribute("NoAbilityCooldowns") or LocalPlayer.Style.Value == "Copycat" and LocalPlayer:GetAttribute("TrueCopycat")) or LocalPlayer.Style.Value == "Thief" and u7.TotalTheft) then
                            u7.CDS[1] = tick() + Abilities.CurseKing[1];
                        end;

                        LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = 1;

                        if u6.CharValues.HasBall then
                            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "World Red Slash";
                        else
                            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "Rebound";
                        end;

                        u13:Disconnect();
                        u7.AC:Clean();
                        u7:ResetCopy();
                        u7.Rebound = nil;
                    end);

                    return;
                end;

                if p8.State == "Fail" then
                    u7:ResetCD(1);
                    Effects:Popup("Can\'t rebound shot!");
                end;
            end;
        end);

        return;
    end;

    if u7.Rebound then
        if ReplicatedStorage.GameValues.Scoring.Value then
            u7:ResetCD(1);
            Effects:Popup("Can\'t use after a goal!");

            return;
        end;

        if u7.MovementController.States.PumpFake then
            u7:ResetCD(1);
            Effects:Popup("Can\'t use after a fake!");

            return;
        end;

        if u7:HoopDist() > 85 then
            u7:ResetCD(1);
            Effects:Popup("Too for away from hoop!");

            return;
        end;

        u7.Rebound = nil;
        u7:ResetCopy();
        u1.Ability:Fire("Slash", {
            State = "Layup",
            TimeSent = workspace:GetServerTimeNow()
        });
        u2.States.Ability = true;
        u2.States.NoWalk = true;
        task.delay(1.8, function() -- Line: 65
            -- upvalues: u2 (ref)
            u2.States.Ability = false;
            u2.States.NoWalk = false;
        end);
        u5:StopAll();
        local v15 = u5:PlayChar("CurseKing", "SlashLayup", Enum.AnimationPriority.Action3, true);
        local v16 = u5:PlayBall("CurseKing", "SlashLayupBall", Enum.AnimationPriority.Action3, true);
        v15:AdjustSpeed(1.5);
        v16:AdjustSpeed(1.5);

        return;
    end;

    local v17 = nil;

    for _, v in game.Teams[Essentials:ActualTeam(LocalPlayer.Team.Name)]:GetPlayers() do
        if v.Team ~= game.Teams.Visitor and (v.Character and (v.Character:FindFirstChild("HumanoidRootPart") and (v.Character.HumanoidRootPart.Position - HumanoidRootPart.Position).Magnitude <= 25)) then
            v17 = true;
            break;
        end;
    end;

    if not v17 then
        u7:ResetCD(1);
        Effects:Popup("Enemy player must be close to you!");

        return;
    end;

    if u7.MovementController.States.PumpFake then
        u7:ResetCD(1);
        Effects:Popup("Can\'t use after a fake!");

        return;
    end;

    u7:ResetCopy();
    u5:StopAll();
    u5:PlayChar("CurseKing", "WorldRedSlash", Enum.AnimationPriority.Action3);
    u5:PlayBall("CurseKing", "WorldRedSlashBall", Enum.AnimationPriority.Action3);
    u1.Ability:Fire("Slash", {
        State = "Dribble",
        TimeSent = workspace:GetServerTimeNow()
    });
    u2.States.Ability = true;
    u2.States.NoWalk = true;
    task.delay(2.0166666666666666, function() -- Line: 108
        -- upvalues: u2 (ref)
        u2.States.Ability = false;
        u2.States.NoWalk = false;
    end);
end;