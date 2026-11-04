 
 

game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
require(ReplicatedStorage.Shared.Utility.Essentials);
local CalculateBallTrajectory = require(ReplicatedStorage.Shared.Functions.CalculateBallTrajectory);
local Abilities = require(ReplicatedStorage.Shared.Tables.Cooldowns).Abilities;
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local LocalPlayer = game.Players.LocalPlayer;
local RaycastParams_new_ret = RaycastParams.new();
RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Include;
RaycastParams_new_ret.FilterDescendantsInstances = { workspace.Barriers };

return function(u7) -- Line: 26
    -- upvalues: LocalPlayer (copy), u1 (ref), u2 (ref), u3 (ref), u4 (ref), u5 (ref), u6 (ref), Effects (copy), ReplicatedStorage (copy), CalculateBallTrajectory (copy), RunService (copy), Abilities (copy)
    local Character = LocalPlayer.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local Humanoid = Character.Humanoid;
    u1 = u7.AbilityService;
    u2 = u7.MovementController;
    u3 = u7.BallController;
    u4 = u7.CameraController;
    u5 = u7.Animations;
    u6 = u7.Network;

    if u7.Unwilling then
        if not u7.Unwilling:FindFirstChild("HumanoidRootPart") then
            u7.Unwilling = nil;

            return;
        end;

        if not u6.CharValues.HasBall then
            Effects:Popup("Not usable without ball!");
            u7:ResetCD(4);

            return;
        end;

        if (u7.Unwilling.HumanoidRootPart.Position - HumanoidRootPart.Position).Magnitude > 25 then
            u7:ResetCD(4);
            Effects:Popup("Opponent must be close to you!");

            return;
        end;

        local v8 = u7:HoopDist();

        if v8 > 115 then
            u7:ResetCD(4);
            Effects:Popup("Too far away from hoop!");

            return;
        end;

        local Unwilling = u7.Unwilling;
        local Position = workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position;
        u7.Unwilling = nil;
        local Shiftlock = u4.Shiftlock;
        u4:SetShiftlock(false);
        u2.States.Ability = true;
        u2.States.NoWalk = true;
        u7.AC:Add(function() -- Line: 73
            -- upvalues: u2 (ref), u4 (ref), Shiftlock (copy)
            u2.States.Ability = false;
            u2.States.NoWalk = false;
            u4:SetShiftlock(Shiftlock);
        end);
        HumanoidRootPart.CFrame = CFrame.new(Unwilling.HumanoidRootPart.Position, (Vector3.new(Position.X, Unwilling.HumanoidRootPart.Position.Y, Position.Z)));

        if v8 < 70 then
            u7.AC:Add(task.delay(2.033333333333333, function() -- Line: 105
                -- upvalues: u7 (copy)
                u7.AC:Clean();
            end));
            u1.Ability:Fire("Unwilling", {
                State = "Dunk",
                TimeSent = workspace:GetServerTimeNow(),
                Other = Unwilling
            });

            return;
        end;

        u7.AC:Add(task.delay(2.566666666666667, function() -- Line: 83
            -- upvalues: u7 (copy)
            u7.AC:Clean();
        end));
        u1.Ability:Fire("Unwilling", {
            State = "Shoot",
            TimeSent = workspace:GetServerTimeNow(),
            Other = Unwilling
        });
        task.wait(2.2);
        u7.AC:Connect(u1.Ability, function() -- Line: 91
            -- upvalues: u7 (copy), ReplicatedStorage (ref), u3 (ref), CalculateBallTrajectory (ref), LocalPlayer (ref)
            u7.AC:Clean();
            local Value = ReplicatedStorage.Basketball.Value;
            Value.CFrame = u3:GetLastCharacterToPossessBall().PlrBall.Anims.BALL.CFrame;
            Value.AssemblyLinearVelocity = CalculateBallTrajectory(Value.Position, workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position, 70);
        end);

        return;
    end;

    if u6.CharValues.HasBall then
        Effects:Popup("Not usable with ball!");
        u7:ResetCD(4);

        return;
    end;

    local CharacterPossessingBall = u3:GetCharacterPossessingBall();
    local PlayerPossessingBall = u3:GetPlayerPossessingBall();

    if not (CharacterPossessingBall and (PlayerPossessingBall and PlayerPossessingBall.Team ~= LocalPlayer.Team)) then
        u7:ResetCD(4);
        Effects:Popup("Ball must be on opponent!");

        return;
    end;

    if (CharacterPossessingBall.HumanoidRootPart.Position - HumanoidRootPart.Position).Magnitude > 45 then
        u7:ResetCD(4);
        Effects:Popup("Opponent must be close to you!");

        return;
    end;

    u2.States.Ability = true;
    u2.States.NoWalk = true;
    u7.AC:Add(function() -- Line: 138
        -- upvalues: u2 (ref)
        u2.States.Ability = false;
        u2.States.NoWalk = false;
        u2.States.AbilitiesUsable = 0;
    end);
    u7.AC:Add(task.delay(0.75, function() -- Line: 143
        -- upvalues: u2 (ref), RunService (ref), HumanoidRootPart (copy), Humanoid (copy), u7 (copy)
        u2.States.NoWalk = false;
        u2.States.AbilitiesUsable = 4;
        local u9 = RunService.Heartbeat:Connect(function() -- Line: 147
            -- upvalues: HumanoidRootPart (ref), Humanoid (ref)
            HumanoidRootPart.AssemblyLinearVelocity = HumanoidRootPart.CFrame.LookVector * Humanoid.WalkSpeed + Vector3.new(0, HumanoidRootPart.AssemblyLinearVelocity.Y, 0);
        end);
        u2.Boost = 20;
        u7.AC:Add(function() -- Line: 153
            -- upvalues: u9 (copy), u2 (ref)
            u9:Disconnect();
            u2.Boost = 0;
        end);
    end));
    u7.AC:Add(task.delay(2.566666666666667, function() -- Line: 159
        -- upvalues: u7 (copy)
        u7.AC:Clean();
    end));
    u1.Ability:Fire("Unwilling", {
        State = "Run",
        TimeSent = workspace:GetServerTimeNow(),
        Other = CharacterPossessingBall
    });
    HumanoidRootPart.CFrame = CharacterPossessingBall.HumanoidRootPart.CFrame * CFrame.Angles(0, 3.141592653589793, 0);
    u7:ResetCD(4);
    u7.Unwilling = CharacterPossessingBall;
    local u10 = nil;
    task.delay(3, function() -- Line: 171
        -- upvalues: u10 (ref)
        u10 = true;
    end);
    local u11 = 1;
    local u12 = false;
    local u13 = nil;

    local function End() -- Line: 180
        -- upvalues: LocalPlayer (ref), u7 (copy), Abilities (ref), u6 (ref), u13 (ref)
        if not (workspace:GetAttribute("NoAbilityCooldowns") or (LocalPlayer:GetAttribute("NoAbilityCooldowns") or LocalPlayer.Style.Value == "Copycat" and LocalPlayer:GetAttribute("TrueCopycat")) or LocalPlayer.Style.Value == "Thief" and u7.TotalTheft) then
            u7.CDS[4] = tick() + Abilities.PerfectionV2[4];
        end;

        LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = 1;

        if u6.CharValues.InAwakening then
            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "Unwilling Run";
        elseif u6.CharValues.HasBall then
            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "Perfect Dribble";
        else
            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "Instant Grab";
        end;

        u13:Disconnect();

        if u7.Unwilling then
            u7.Unwilling = nil;
        end;

        u7:ResetCopy();
    end;

    u13 = RunService.Heartbeat:Connect(function(p14) -- Line: 206
        -- upvalues: u7 (copy), u10 (ref), End (copy), u6 (ref), LocalPlayer (ref), u11 (ref), u12 (ref)
        if not u7.Unwilling or u10 then
            End();

            return;
        end;

        if not u6.CharValues.InAwakening then
            End();

            return;
        end;

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

        LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "Unwilling Assist";
    end);
end;