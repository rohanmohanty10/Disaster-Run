 
 

game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
require(ReplicatedStorage.Shared.Functions.CalculateBallTrajectory);
local Abilities = require(ReplicatedStorage.Shared.Tables.Cooldowns).Abilities;
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local LocalPlayer = game.Players.LocalPlayer;

return function(u7) -- Line: 22
    -- upvalues: LocalPlayer (copy), u1 (ref), u2 (ref), u3 (ref), u4 (ref), u5 (ref), u6 (ref), Effects (copy), Abilities (copy), RunService (copy), Essentials (copy), ReplicatedStorage (copy), TweenService (copy)
    local Character = LocalPlayer.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local Humanoid = Character.Humanoid;
    u1 = u7.AbilityService;
    u2 = u7.MovementController;
    u3 = u7.CameraController;
    u4 = u7.BallController;
    u5 = u7.Animations;
    u6 = u7.Network;

    if u6.CharValues.HasBall then
        if u7.InDominance then
            if u7:HoopDist() > 100 then
                Effects:Popup("Too far away from hoop!");
                u7:ResetCD(4);

                return;
            end;

            u7.CDS[2] = Abilities.Alien[2];
            u7.InDominance = nil;
            u2.States.AbilitiesUsable = 0;
            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "Alien Dribble";
            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.AbilityName.Text = "Dominance";
            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = 1;
            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.Flash.BackgroundTransparency = 1;
            u1.Ability:Fire("The Reach", {
                State = "Layup",
                TimeSent = workspace:GetServerTimeNow()
            });
            u5:StopAll();
            u5:PlayChar("Alien", "Layup", Enum.AnimationPriority.Action3);
            u5:PlayBall("Alien", "LayupBall", Enum.AnimationPriority.Action3);

            if Character:FindFirstChild(script.Name .. "AlignPosition") then
                Character:FindFirstChild(script.Name .. "AlignPosition"):Destroy();
            end;

            local FieldOfView = workspace.CurrentCamera.FieldOfView;
            local u9 = RunService.Heartbeat:Connect(function(p8) -- Line: 66
                -- upvalues: FieldOfView (ref), Essentials (ref), HumanoidRootPart (copy)
                FieldOfView = Essentials:Lerp(FieldOfView, 45 + HumanoidRootPart.AssemblyLinearVelocity.Magnitude, p8 * 4);
                workspace.CurrentCamera.FieldOfView = FieldOfView;
            end);
            task.delay(0.6, function() -- Line: 71
                -- upvalues: u9 (copy)
                u9:Disconnect();
            end);
            task.wait(0.2);
            local _ = workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position;
            u2.States.Ability = false;
            u2.States.NoWalk = false;
            u2.States.Dunking = true;
            task.spawn(function() -- Line: 82
                -- upvalues: RunService (ref), Humanoid (copy), u2 (ref)
                RunService.Heartbeat:Wait();
                Humanoid:ChangeState(Enum.HumanoidStateType.Jumping);
                u2.States.Boost = 10;
                task.wait(0.4);
                u2.States.Dunking = false;
                u2.States.Boost = 0;
            end);
            u7.AC:Connect(u1.Ability, function() -- Line: 91
                -- upvalues: u7 (copy), ReplicatedStorage (ref), u4 (ref), LocalPlayer (ref)
                u7.AC:Clean();
                local Value = ReplicatedStorage.Basketball.Value;
                Value.CFrame = u4:GetLastCharacterToPossessBall().PlrBall.Anims.BALL.CFrame;
                local Position = Value.Position;
                local _ = (workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position - Position).Magnitude;
                local v10 = workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position - Position;
                local math_log_ret = math.log(1 + v10.Magnitude * 0.045);
                Value.AssemblyLinearVelocity = v10 / math_log_ret + Vector3.new(0, workspace.Gravity * math_log_ret * 0.5, 0);
            end);

            return;
        end;

        if #LocalPlayer.Team:GetPlayers() > 1 then
            u7:ResetCD(4);
            Effects:Popup("Not usable with ball!");

            return;
        end;
    end;

    if u7:HoopDist() > 85 then
        Effects:Popup("Too far away from hoop!");
        u7:ResetCD(4);

        return;
    end;

    local PlayerPossessingBall = u4:GetPlayerPossessingBall();

    if not PlayerPossessingBall or PlayerPossessingBall.Team ~= LocalPlayer.Team then
        Effects:Popup("Teammate must have the ball!");
        u7:ResetCD(4);

        return;
    end;

    if not u4:LocalPlayerIsWithinDistanceOfBall(100) then
        u7:ResetCD(4);
        Effects:Popup("Must be close to the ball!");

        return;
    end;

    u1.Ability:Fire("Alley", {
        TimeSent = workspace:GetServerTimeNow()
    });
    u5:StopAll();
    local u11 = u5:PlayChar("Alien", "Alley", Enum.AnimationPriority.Action3, true);
    local u12 = u5:PlayBall("Alien", "AlleyBall", Enum.AnimationPriority.Action3, true);
    local u13 = nil;
    u7.AC:Connect(u1.Ability, function(p14) -- Line: 148
        -- upvalues: u7 (copy), Effects (ref), u11 (copy), u12 (copy), u2 (ref), u13 (ref), u3 (ref), TweenService (ref), HumanoidRootPart (copy), LocalPlayer (ref), RunService (ref)
        u7.AC:Clean();

        if p14 then
            u7:ResetCD(4);
            Effects:Popup("Ball is on iframes!");

            return;
        end;

        u11.TimePosition = 0.5;
        u12.TimePosition = 0.5;

        if u2.States.PumpFake then
            u7:ResetCD(4);
            Effects:Popup("Can\'t use move after fake!");

            return;
        end;

        u2.States.Ability = true;
        task.delay(1, function() -- Line: 163
            -- upvalues: u2 (ref)
            u2.States.Ability = false;
        end);
        u13 = u3.Shiftlock;
        u3:SetShiftlock(false);
        task.wait(0.1);
        task.spawn(function() -- Line: 172
            -- upvalues: TweenService (ref)
            local workspace_CurrentCamera = workspace.CurrentCamera;
            TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {
                FieldOfView = 40
            }):Play();
            task.wait(0.75);
            TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
                FieldOfView = 100
            }):Play();
            task.wait(0.25);
            TweenService:Create(workspace_CurrentCamera, TweenInfo.new(1), {
                FieldOfView = 70
            }):Play();
        end);
        local LinearVelocity = Instance.new("LinearVelocity");
        LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
        LinearVelocity.MaxForce = 40000;
        LinearVelocity.VectorVelocity = HumanoidRootPart.CFrame.LookVector * 50;
        LinearVelocity.Parent = HumanoidRootPart;
        u7.AC:Add(LinearVelocity);
        local u15 = 50;
        local _ = HumanoidRootPart.CFrame.LookVector;
        local Position = workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position;
        local u16 = tick();
        u7.AC:Connect(RunService.Heartbeat, function(p17) -- Line: 200
            -- upvalues: u16 (copy), u7 (ref), u2 (ref), HumanoidRootPart (ref), Position (copy), LinearVelocity (copy), u15 (ref), u11 (ref), u12 (ref)
            if u16 + 5 < tick() then
                u7.AC:Clean();

                return;
            end;

            if u2.States.Stunned then
                u7.AC:Clean();

                return;
            end;

            if HumanoidRootPart.Position.Y >= 8 then
                HumanoidRootPart.CFrame = CFrame.new(HumanoidRootPart.Position, Position);
            end;

            LinearVelocity.VectorVelocity = (HumanoidRootPart.CFrame.LookVector + Vector3.new(0, 0.8, 0)) * u15;
            u15 = u15 - p17 * 50;
            u11:AdjustSpeed(u15 / 200);
            u12:AdjustSpeed(u15 / 200);
        end);
        task.wait(0.9);
        u7.AC:Clean();
        u11:AdjustSpeed(1);
        u12:AdjustSpeed(1);

        if not u3.Shiftlock then
            u3:SetShiftlock(u13);
        end;
    end);
end;