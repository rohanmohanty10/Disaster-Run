 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local Knit = require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
require(ReplicatedStorage.Shared.Utility.Essentials);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = nil;
local LocalPlayer = game.Players.LocalPlayer;

return function(u8) -- Line: 21, Name: TendrilSnatch
    -- upvalues: LocalPlayer (copy), u1 (ref), u2 (ref), u4 (ref), u3 (ref), u5 (ref), u6 (ref), u7 (ref), Knit (copy), ReplicatedStorage (copy), Effects (copy), RunService (copy), TweenService (copy)
    local Character = LocalPlayer.Character;
    local _ = Character.Humanoid;
    local HumanoidRootPart = Character.HumanoidRootPart;
    u1 = u8.Network;
    u2 = u8.AbilityService;
    u4 = u8.Animations;
    u3 = u8.MovementController;
    u5 = u8.BallController;
    u6 = u8.CameraController;
    u7 = Knit.GetService("CustomServerService");

    if ReplicatedStorage.Cooldowns.TendrilSnatchCD.Value > workspace:GetServerTimeNow() then
        local v9 = ReplicatedStorage.Cooldowns.TendrilSnatchCD.Value - workspace:GetServerTimeNow();
        Effects:Popup((`Ability is on global cooldown. Try again in {math.round(v9)}`));

        return u8:ResetCD(1);
    end;

    if not u5:LocalPlayerPossessesBall() then
        local ServerBallPosition = u5:GetServerBallPosition();
        u5:GetCharacterPossessingBall();
        local LastPlayerToPossessBall = u5:GetLastPlayerToPossessBall();

        if not LastPlayerToPossessBall or LastPlayerToPossessBall.Team == LocalPlayer.Team then
            Effects:Popup("Ball must have been shot by an enemy player!");

            return u8:ResetCD(1);
        end;

        if (Character.HumanoidRootPart.Position - ServerBallPosition).Magnitude >= 33 then
            Effects:Popup("The ball is too far away!");

            return u8:ResetCD(1);
        end;

        local LastPlayerToPossessBall2 = u5:GetLastPlayerToPossessBall();

        if LastPlayerToPossessBall2 then
            LastPlayerToPossessBall2 = LastPlayerToPossessBall2.Character;
        end;

        if LastPlayerToPossessBall2 and (LastPlayerToPossessBall2:GetAttribute("Unblockable") and LastPlayerToPossessBall2:GetAttribute("Unblockable") > workspace:GetServerTimeNow()) then
            Effects:Popup("Can\'t block shot!");
            u8:ResetCD(1);

            return;
        end;

        if ServerBallPosition.Y > 20 then
            Effects:Popup("The ball is too high!");

            return u8:ResetCD(1);
        end;

        u3.States.Ability = true;
        u3.States.NoWalk = true;
        u4:StopAll();
        u4:PlayChar("Symbiote", "TendrilSnatch", Enum.AnimationPriority.Action3);
        u4:PlayBall("Symbiote", "TendrilSnatchBall", Enum.AnimationPriority.Action3);
        u8.AC:Connect(RunService.Heartbeat, function(p10) -- Line: 165
            -- upvalues: u5 (ref), Character (copy), ServerBallPosition (ref), HumanoidRootPart (copy)
            if u5:GetCharacterPossessingBall() ~= Character then
                ServerBallPosition = u5:GetServerBallPosition();

                if (HumanoidRootPart.Position - ServerBallPosition).Magnitude > 0 then
                    HumanoidRootPart.CFrame = CFrame.new(HumanoidRootPart.Position, (Vector3.new(ServerBallPosition.X, HumanoidRootPart.Position.Y, ServerBallPosition.Z)));
                end;
            end;
        end);
        task.delay(1.5833333333333333, function() -- Line: 174
            -- upvalues: u3 (ref), u8 (copy)
            u3.States.Ability = false;
            u3.States.NoWalk = false;
            u8.AC:Clean();
        end);
        u2.Ability:Fire("TendrilSnatch", {
            Ability = "Off-Ball",
            TimeSent = workspace:GetServerTimeNow()
        });

        return;
    end;

    local u11 = u8:CheckInfront(30);

    if not u11 then
        Effects:Popup("An enemy must be close to you!");

        return u8:ResetCD(1);
    end;

    u3.States.Ability = true;
    u3.States.NoWalk = true;
    u4:StopAll();
    u4:PlayChar("Symbiote", "TendrilDribble", Enum.AnimationPriority.Action3);
    u4:PlayBall("Symbiote", "TendrilDribbleBall", Enum.AnimationPriority.Action3);
    task.delay(2.4166666666666665, function() -- Line: 56
        -- upvalues: u3 (ref), u8 (copy)
        u3.States.Ability = false;
        u3.States.NoWalk = false;
        u8.AC:Clean();
    end);
    local LinearVelocity = Instance.new("LinearVelocity");
    LinearVelocity.MaxForce = (1 / 0);
    LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
    LinearVelocity.Parent = HumanoidRootPart;
    u8.AC:Add(LinearVelocity);
    local BodyGyro = Instance.new("BodyGyro");
    BodyGyro.Name = "GyroBasketball";
    BodyGyro.MaxTorque = Vector3.new(9000000000, 9000000000, 9000000000);
    BodyGyro.CFrame = HumanoidRootPart.CFrame;
    BodyGyro.P = 1250;
    BodyGyro.Parent = HumanoidRootPart;
    u8.AC:Add(BodyGyro);
    local AlignOrientation = Instance.new("AlignOrientation");
    AlignOrientation.Parent = HumanoidRootPart;
    AlignOrientation.Attachment0 = HumanoidRootPart.RootAttachment;
    AlignOrientation.Attachment1 = u11.HumanoidRootPart.RootAttachment;
    u8.AC:Add(AlignOrientation);
    local RaycastParams_new_ret = RaycastParams.new();
    RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Include;
    RaycastParams_new_ret.FilterDescendantsInstances = { workspace.Barriers };
    local u12 = false;
    u8.AC:Connect(RunService.Heartbeat, function(p13) -- Line: 88
        -- upvalues: BodyGyro (copy), HumanoidRootPart (copy), LinearVelocity (copy), RaycastParams_new_ret (copy), u12 (ref)
        BodyGyro.CFrame = HumanoidRootPart.CFrame;

        if LinearVelocity then
            local v14 = workspace:Raycast(HumanoidRootPart.Position, LinearVelocity.VectorVelocity.Unit * 5, RaycastParams_new_ret);

            if v14 and (v14.Instance and not u12) then
                u12 = true;

                if LinearVelocity then
                    LinearVelocity:Destroy();
                end;
            end;
        end;
    end);
    task.delay(0.8333333333333334, function() -- Line: 99
        -- upvalues: AlignOrientation (copy), u11 (copy), HumanoidRootPart (copy), LinearVelocity (copy), TweenService (ref)
        AlignOrientation.Enabled = false;
        local v15 = u11.HumanoidRootPart.Position - HumanoidRootPart.Position;
        local u16 = v15.Magnitude > 0 and v15.Unit or HumanoidRootPart.CFrame.LookVector;
        local RightVector = (u11.HumanoidRootPart.CFrame * u11.HumanoidRootPart.CFrame:ToObjectSpace(HumanoidRootPart.CFrame)).RightVector;
        LinearVelocity.VectorVelocity = u16 * Vector3.new(1, 0, 1) * 70;
        task.delay(0.25, function() -- Line: 105
            -- upvalues: TweenService (ref), LinearVelocity (ref), u16 (copy), RightVector (copy)
            TweenService:Create(LinearVelocity, TweenInfo.new(0.16666666666666666, Enum.EasingStyle.Sine), {
                VectorVelocity = u16 * Vector3.new(1, 0, 1) * 65 + RightVector * 60
            }):Play();
            task.delay(0.16666666666666666, function() -- Line: 109
                -- upvalues: TweenService (ref), LinearVelocity (ref), u16 (ref), RightVector (ref)
                TweenService:Create(LinearVelocity, TweenInfo.new(0.16666666666666666, Enum.EasingStyle.Sine), {
                    VectorVelocity = u16 * Vector3.new(1, 0, 1) * 65 + RightVector * -60
                }):Play();
                task.delay(0.16666666666666666, function() -- Line: 113
                    -- upvalues: TweenService (ref), LinearVelocity (ref), u16 (ref)
                    TweenService:Create(LinearVelocity, TweenInfo.new(0.8333333333333334, Enum.EasingStyle.Sine), {
                        VectorVelocity = u16 * Vector3.new(1, 0, 1) * 25
                    }):Play();
                end);
            end);
        end);
    end);
    u2.Ability:Fire("TendrilSnatch", {
        Ability = "On-Ball",
        TimeSent = workspace:GetServerTimeNow(),
        Target = u11
    });
end;