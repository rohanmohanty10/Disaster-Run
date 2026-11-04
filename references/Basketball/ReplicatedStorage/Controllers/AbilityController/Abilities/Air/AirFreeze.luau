 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
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

return function(u8) -- Line: 21
    -- upvalues: LocalPlayer (copy), u3 (ref), u5 (ref), u4 (ref), u6 (ref), u7 (ref), u1 (ref), u2 (ref), Effects (copy), TweenService (copy), RunService (copy), ReplicatedStorage (copy), Players (copy)
    local Character = LocalPlayer.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local Humanoid = Character.Humanoid;
    u3 = u8.AbilityService;
    u5 = u8.Animations;
    u4 = u8.MovementController;
    u6 = u8.BallController;
    u7 = u8.CameraController;
    u1 = u8.Network;
    u2 = u8.BallService;

    if not u1.CharValues.HasBall then
        if ReplicatedStorage.Cooldowns.AirFreezeCD.Value > workspace:GetServerTimeNow() then
            u8:ResetCD(2);
            local v9 = ReplicatedStorage.Cooldowns.AirFreezeCD.Value - workspace:GetServerTimeNow();
            Effects:Popup(`Ability is on global cooldown! Ready in {math.round(v9)} seconds`, 2);

            return;
        end;

        if u8.Network.CharValues.Blocked + 2 > tick() then
            u8:ResetCD(2);
            Effects:Popup("Can\'t use after block!");

            return;
        end;

        local PlayerPossessingBall = u6:GetPlayerPossessingBall();
        local LastCharacterToPossessBall = u6:GetLastCharacterToPossessBall();

        if PlayerPossessingBall or not (LastCharacterToPossessBall and (Players:GetPlayerFromCharacter(LastCharacterToPossessBall) and Players:GetPlayerFromCharacter(LastCharacterToPossessBall).Team ~= LocalPlayer.Team)) then
            u8:ResetCD(2);
            Effects:Popup("Ball must have been shot by an enemy player!");

            return;
        end;

        if LastCharacterToPossessBall:GetAttribute("Unblockable") and LastCharacterToPossessBall:GetAttribute("Unblockable") > workspace:GetServerTimeNow() then
            u8:ResetCD(2);
            Effects:Popup("Can\'t block shot!");

            return;
        end;

        local ServerBallPosition = u6:GetServerBallPosition();

        if (HumanoidRootPart.Position * Vector3.new(1, 0, 1) - ServerBallPosition * Vector3.new(1, 0, 1)).Magnitude > 40 or ServerBallPosition.Y > 30 then
            u8:ResetCD(2);
            Effects:Popup("Ball is too far away!");

            return;
        end;

        u3.Ability:Fire("Air Freeze", {
            Task = "Air Freeze",
            TimeSent = workspace:GetServerTimeNow()
        });
        u8.AC:Connect(u3.Ability, function(p10) -- Line: 124
            -- upvalues: u8 (copy), u4 (ref), u5 (ref), Effects (ref)
            u8.AC:Clean();

            if p10 then
                if p10.Success then
                    u4.States.NoWalk = true;
                    u4.States.Ability = true;
                    task.delay(1.8333333333333333, function() -- Line: 131
                        -- upvalues: u4 (ref)
                        u4.States.NoWalk = false;
                        u4.States.Ability = false;
                    end);
                    u5:StopAll();
                    u5:PlayChar("Air", "AirFreeze", Enum.AnimationPriority.Action3);

                    return;
                end;

                if p10.Fail then
                    u8:ResetCD(2);
                    Effects:Popup("Ball must have been shot!");
                end;
            end;
        end);

        return;
    end;

    if u4.States.PumpFake then
        u8:ResetCD(2);
        Effects:Popup("Can\'t use after a fake!");

        return;
    end;

    u5:StopAll();
    u5:PlayChar("Air", "AirDribble", Enum.AnimationPriority.Action3);
    u5:PlayBall("Air", "AirDribbleBall", Enum.AnimationPriority.Action3);
    u3.Ability:Fire("Air Freeze", {
        Task = "Air Dribble",
        TimeSent = workspace:GetServerTimeNow()
    });
    local _ = HumanoidRootPart.CFrame;
    local LinearVelocity = Instance.new("LinearVelocity");
    LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
    LinearVelocity.MaxForce = (1 / 0);
    LinearVelocity.VectorVelocity = Vector3.new(0, 0, 0);
    LinearVelocity.Parent = HumanoidRootPart;
    u8.AC:Add(LinearVelocity);
    u4.States.Ability = true;
    task.delay(1.2, function() -- Line: 58
        -- upvalues: u4 (ref)
        u4.States.Ability = false;
    end);
    u8.AC:Add(task.delay(1.2, function() -- Line: 61
        -- upvalues: u8 (copy)
        u8.AC:Clean();
    end));
    u8.AC:Add(task.delay(0.9, function() -- Line: 65
        -- upvalues: Humanoid (copy), HumanoidRootPart (copy), TweenService (ref), LinearVelocity (copy), Character (copy), RunService (ref)
        local v11 = Humanoid.MoveDirection:Dot(HumanoidRootPart.CFrame.RightVector);
        local u12 = HumanoidRootPart.CFrame.RightVector * (v11 < 0 and -150 or 150);
        TweenService:Create(LinearVelocity, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            VectorVelocity = u12
        }):Play();
        local RaycastParams_new_ret = RaycastParams.new();
        RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
        RaycastParams_new_ret.FilterDescendantsInstances = { Character };
        tick();
        local u13 = nil;
        u13 = RunService.Heartbeat:Connect(function(p14) -- Line: 76
            -- upvalues: HumanoidRootPart (ref), u12 (copy), RaycastParams_new_ret (copy), u13 (ref), LinearVelocity (ref)
            local v15 = workspace:Raycast(HumanoidRootPart.Position, u12.Unit * 4, RaycastParams_new_ret);

            if v15 and not v15.Instance.Parent:FindFirstChild("Humanoid") then
                u13:Disconnect();
                LinearVelocity:Destroy();
            end;
        end);
        task.delay(0.5, function() -- Line: 84
            -- upvalues: u13 (ref)
            u13:Disconnect();
        end);
    end));
end;