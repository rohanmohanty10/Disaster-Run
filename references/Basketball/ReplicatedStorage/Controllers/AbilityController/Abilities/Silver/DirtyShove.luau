 
 

game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
local CameraShaker = require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local Abilities = require(ReplicatedStorage.Shared.Tables.Cooldowns).Abilities;
require(ReplicatedStorage.Shared.Tables.Zones);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local LocalPlayer = game.Players.LocalPlayer;

return function(u7) -- Line: 23
    -- upvalues: LocalPlayer (copy), u1 (ref), u2 (ref), u3 (ref), u4 (ref), u5 (ref), u6 (ref), Abilities (copy), Essentials (copy), RunService (copy), TweenService (copy), CameraShaker (copy), Effects (copy)
    local Character = LocalPlayer.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local _ = Character.Humanoid;
    u1 = u7.BallController;
    u2 = u7.CameraController;
    u3 = u7.MovementController;
    u4 = u7.AbilityService;
    u5 = u7.Animations;
    u6 = u7.Network;

    if not u6.CharValues.HasBall then
        local v8 = nil;
        local PlayerPossessingBall = u1:GetPlayerPossessingBall();

        if PlayerPossessingBall then
            if PlayerPossessingBall and (PlayerPossessingBall.Team ~= LocalPlayer.Team and (PlayerPossessingBall.Character and (PlayerPossessingBall.Character:FindFirstChild("HumanoidRootPart") and (PlayerPossessingBall.Character.HumanoidRootPart.Position - HumanoidRootPart.Position).Magnitude <= 25))) then
                v8 = PlayerPossessingBall.Character;
            end;

            if not v8 then
                u7:ResetCD(2);
                Effects:Popup("Must be close to the ball!");

                return;
            end;
        elseif not u7:CheckInfront(15) then
            u7:ResetCD(2);
            Effects:Popup("Someone must be infront of you!");

            return;
        end;

        u3.States.Ability = true;
        u7.AC:Add(function() -- Line: 196
            -- upvalues: u3 (ref)
            u3.States.Ability = false;
        end);
        u7.AC:Add(task.delay(0.25, function() -- Line: 200
            -- upvalues: u7 (copy)
            u7.AC:Clean();
        end));
        u5:StopAll();
        u5:PlayChar("Silver", "DirtyShove", Enum.AnimationPriority.Action3);
        u4.Ability:Fire("Dirty Shove", {
            State = "Shove",
            TimeSent = workspace:GetServerTimeNow()
        });
        local LinearVelocity = Instance.new("LinearVelocity");
        LinearVelocity.ForceLimitMode = Enum.ForceLimitMode.PerAxis;
        LinearVelocity.MaxAxesForce = Vector3.new(40000, 0, 40000);
        LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
        LinearVelocity.Parent = HumanoidRootPart;
        u7.AC:Add(LinearVelocity);
        local u9 = u1:GetServerBallPosition() - HumanoidRootPart.Position;

        if not PlayerPossessingBall or u9.Magnitude <= 0 then
            u9 = HumanoidRootPart.CFrame.LookVector;
        end;

        local u10 = 90;
        u7.AC:Connect(RunService.Heartbeat, function(p11) -- Line: 224
            -- upvalues: u10 (ref), LinearVelocity (copy), u9 (ref)
            u10 = u10 - p11 * 30;
            LinearVelocity.VectorVelocity = u9.Unit * u10;
        end);

        return;
    end;

    if not u7.InPush then
        local Hoop = workspace.Hoops[LocalPlayer.Team.Name].Hoop;
        local Vector3_new_ret = Vector3.new(Hoop.Position.X, HumanoidRootPart.Position.Y, Hoop.Position.Z);

        if (HumanoidRootPart.Position - Vector3_new_ret).Magnitude <= 25 then
            u7:ResetCD(2);
            Effects:Popup("Too close to Hoop!");

            return;
        end;

        if math.abs(Vector3_new_ret.X - HumanoidRootPart.Position.X) > 55.308 or math.abs(Vector3_new_ret.Z - HumanoidRootPart.Position.Z) > 27.5 then
            u7:ResetCD(2);
            Effects:Popup("Only usable past the free throw line!");

            return;
        end;

        if u7.MovementController.States.PumpFake then
            u7:ResetCD(2);
            Effects:Popup("Can\'t use after a fake!");

            return;
        end;

        u3.States.Ability = true;
        u3.States.NoWalk = true;
        task.delay(0.8333333333333334, function() -- Line: 144
            -- upvalues: u3 (ref)
            u3.States.Ability = false;
            u3.States.NoWalk = false;
        end);
        u2.CamShake:Shake(CameraShaker.Presets.Bump);
        local Position = workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position;
        local Unit = (Vector3.new(Position.X, HumanoidRootPart.Position.Y, Position.Z) - HumanoidRootPart.Position).Unit;
        local LinearVelocity = Instance.new("LinearVelocity");
        LinearVelocity.MaxForce = (1 / 0);
        LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
        LinearVelocity.Parent = HumanoidRootPart;
        LinearVelocity.VectorVelocity = Unit * 90 + Vector3.new(0, 10, 0);
        task.delay(0.2, function() -- Line: 160
            -- upvalues: LinearVelocity (copy)
            LinearVelocity:Destroy();
        end);
        u5:StopAll();
        local v12 = u5:PlayChar("Silver", "TitanSmash", Enum.AnimationPriority.Action3, true);
        local v13 = u5:PlayBall("Silver", "TitanSmashBall", Enum.AnimationPriority.Action3, true);
        v12:AdjustSpeed(1.5);
        v13:AdjustSpeed(1.5);
        u4.Ability:Fire("Dirty Shove", {
            State = "Dunk",
            TimeSent = workspace:GetServerTimeNow()
        });

        return;
    end;

    u7.CDS[1] = Abilities.Silver[1];
    u7.InPush = nil;
    u3.States.AbilitiesUsable = 0;
    LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "Silver Push";
    LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.AbilityName.Text = "Titan Smash";
    LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = 1;
    LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.Flash.BackgroundTransparency = 1;
    local v14 = nil;
    local v15 = nil;

    for _, v in game.Teams[Essentials:ActualTeam(LocalPlayer.Team.Name)]:GetPlayers() do
        if v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
            local Magnitude = (v.Character.HumanoidRootPart.Position - HumanoidRootPart.Position).Magnitude;

            if Magnitude <= 35 and (not v14 or Magnitude < v14) then
                v15 = v.Character;
                v14 = Magnitude;
            end;
        end;
    end;

    u4.Ability:Fire("Skyhand", {
        State = "Dribble",
        TimeSent = workspace:GetServerTimeNow(),
        Other = v15
    });
    task.wait(0.1);
    RunService.Heartbeat:Wait();
    u7.AC:Clean();
    u5:StopAll();
    u5:PlayChar("Silver", "DribblePush", Enum.AnimationPriority.Action3, true);
    u5:PlayBall("Silver", "DribblePushBall", Enum.AnimationPriority.Action3, true);
    u3.States.Ability = true;
    u3.States.NoWalk = false;
    u7.AC:Add(function() -- Line: 77
        -- upvalues: u3 (ref)
        u3.States.Ability = false;
    end);
    local FieldOfView = workspace.CurrentCamera.FieldOfView;
    u7.AC:Connect(RunService.Heartbeat, function(p16) -- Line: 82
        -- upvalues: FieldOfView (ref), Essentials (ref)
        FieldOfView = Essentials:Lerp(FieldOfView, 40, p16 * 5);
        workspace.CurrentCamera.FieldOfView = FieldOfView;
    end);
    u7.AC:Add(task.delay(0.9333333333333333, function() -- Line: 87
        -- upvalues: u3 (ref)
        u3.States.Ability = false;
    end));
    u7.AC:Add(task.delay(1.0666666666666667, function() -- Line: 90
        -- upvalues: u7 (copy)
        u7.AC:Clean();
    end));
    local LinearVelocity = Instance.new("LinearVelocity");
    LinearVelocity.ForceLimitMode = Enum.ForceLimitMode.PerAxis;
    LinearVelocity.MaxAxesForce = Vector3.new(40000, 0, 40000);
    LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
    LinearVelocity.Parent = HumanoidRootPart;
    u7.AC:Add(LinearVelocity);
    local LookVector = HumanoidRootPart.CFrame.LookVector;
    local RightVector = HumanoidRootPart.CFrame.RightVector;
    local Vector3_new_ret = Vector3.new(LookVector.X, 0, LookVector.Z);
    local Vector3_new_ret2 = Vector3.new(RightVector.X, 0, RightVector.Z);
    LinearVelocity.VectorVelocity = Vector3_new_ret2 * 60;
    TweenService:Create(LinearVelocity, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
        VectorVelocity = Vector3_new_ret2 * 5
    }):Play();
    task.wait(0.3);
    LinearVelocity.VectorVelocity = -Vector3_new_ret2 * 90;
    TweenService:Create(LinearVelocity, TweenInfo.new(0.43333333333333335, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
        VectorVelocity = -Vector3_new_ret2 * 5
    }):Play();
    task.wait(0.43333333333333335);
    LinearVelocity.VectorVelocity = Vector3_new_ret2 * 120;
    u2.CamShake:Shake(CameraShaker.Presets.Bump);
    task.wait(0.2);
    TweenService:Create(LinearVelocity, TweenInfo.new(0.13333333333333333, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        VectorVelocity = (Vector3_new_ret + Vector3_new_ret2) * 120
    }):Play();
    u2.CamShake:Shake(CameraShaker.Presets.Bump);
end;