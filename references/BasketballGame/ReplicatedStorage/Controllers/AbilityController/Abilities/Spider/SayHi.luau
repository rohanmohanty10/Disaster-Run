 
 

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

return function(u8) -- Line: 21, Name: SayHi
    -- upvalues: LocalPlayer (copy), u1 (ref), u2 (ref), u4 (ref), u3 (ref), u5 (ref), u6 (ref), u7 (ref), Knit (copy), Effects (copy), RunService (copy), TweenService (copy)
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

    if not u5:LocalPlayerPossessesBall() then
        local CharacterPossessingBall = u5:GetCharacterPossessingBall();
        local v9 = CharacterPossessingBall == nil;

        if not (v9 or u5:GetEnemyWithBallWithinDistance(150)) then
            Effects:Popup("The ball must be on the ground or held by an enemy!");

            return u8:ResetCD(2);
        end;

        if v9 and (u5:GetServerBallPosition() - HumanoidRootPart.Position).Magnitude >= 150 then
            Effects:Popup("ball is too far away");

            return u8:ResetCD(2);
        end;

        local v10 = 50;
        local v11 = nil;

        for _, v in pairs(game.Players:GetPlayers()) do
            if v.Character and (v.Team == LocalPlayer.Team and (v ~= LocalPlayer and (v.Character ~= CharacterPossessingBall and v.Character:FindFirstChild("HumanoidRootPart")))) then
                local Magnitude = (v.Character.HumanoidRootPart.Position - HumanoidRootPart.Position).Magnitude;

                if Magnitude <= v10 then
                    v11 = v.Character;
                    v10 = Magnitude;
                end;
            end;
        end;

        if game:GetService("RunService"):IsStudio() and not v11 then
            v11 = workspace.DefenseRig;
        end;

        if not v11 then
            Effects:Popup("A teammate must be close to you!");

            return u8:ResetCD(2);
        end;

        local Shiftlock = u6.Shiftlock;
        u6:SetShiftlock(false);
        u3.States.Ability = true;
        u3.States.NoWalk = true;

        local function Finish() -- Line: 183
            -- upvalues: u6 (ref), Shiftlock (copy), u3 (ref)
            u6:SetShiftlock(Shiftlock);
            u3.States.Ability = false;
            u3.States.NoWalk = false;
        end;

        HumanoidRootPart.CFrame = CFrame.new(HumanoidRootPart.Position, (Vector3.new(v11.HumanoidRootPart.Position.X, HumanoidRootPart.Position.Y, v11.HumanoidRootPart.Position.Z)));
        u4:StopAll();
        u4:PlayChar("Spider", "SayHiOff", Enum.AnimationPriority.Action3, true):AdjustSpeed(2);
        u2.Ability:Fire("SayHi", {
            Ability = "Off-Ball",
            TimeSent = workspace:GetServerTimeNow(),
            Target = v11
        });
        u8.AC:Add(task.delay(1.8, Finish));
        u8.AC:Connect(u2.Ability, function() -- Line: 200
            -- upvalues: u8 (copy), u6 (ref), Shiftlock (copy), u3 (ref)
            u8.AC:Clean();
            u6:SetShiftlock(Shiftlock);
            u3.States.Ability = false;
            u3.States.NoWalk = false;
        end);

        return;
    end;

    local v12 = 40;
    local v13 = nil;

    for _, v in game.Players:GetPlayers() do
        if v.Character and (v.Team ~= LocalPlayer.Team and (v.Team ~= game.Teams.Visitor and v.Character:FindFirstChild("HumanoidRootPart"))) then
            local Magnitude = (v.Character.HumanoidRootPart.Position - HumanoidRootPart.Position).Magnitude;

            if Magnitude <= v12 and v.Character:GetAttribute("GettingUp") then
                v13 = v.Character;
                v12 = Magnitude;
            end;
        end;
    end;

    if game:GetService("RunService"):IsStudio() and not v13 then
        v13 = workspace.DefenseRig;
    end;

    if not v13 then
        Effects:Popup("A ragdolled enemy must be close to you!");

        return u8:ResetCD(2);
    end;

    local Shiftlock = u6.Shiftlock;
    u6:SetShiftlock(false);
    u3.States.Ability = true;
    u3.States.NoWalk = true;

    local function v14() -- Line: 63
        -- upvalues: u8 (copy), u6 (ref), Shiftlock (copy), u3 (ref)
        u8.AC:Clean();
        u6:SetShiftlock(Shiftlock);
        u3.States.Ability = false;
        u3.States.NoWalk = false;
    end;

    HumanoidRootPart.CFrame = CFrame.new(HumanoidRootPart.Position, (Vector3.new(v13.HumanoidRootPart.Position.X, HumanoidRootPart.Position.Y, v13.HumanoidRootPart.Position.Z)));
    u4:StopAll();
    local v15 = u4:PlayChar("Spider", "SayHiOn", Enum.AnimationPriority.Action3, true);
    local v16 = u4:PlayBall("Spider", "SayHiOnBall", Enum.AnimationPriority.Action3, true);
    v15:AdjustSpeed(1.5);
    v16:AdjustSpeed(1.5);
    u2.Ability:Fire("SayHi", {
        Ability = "On-Ball",
        TimeSent = workspace:GetServerTimeNow(),
        Target = v13
    });
    u8.AC:Add(task.delay(2.6222222222222222, v14));
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
    u8.AC:Add(task.delay(1.7, function() -- Line: 96
        -- upvalues: u8 (copy), RunService (ref), BodyGyro (copy), HumanoidRootPart (copy), LinearVelocity (copy), TweenService (ref), LocalPlayer (ref), u3 (ref)
        local NumberValue = Instance.new("NumberValue");
        NumberValue.Value = 180;
        local NumberValue2 = Instance.new("NumberValue");
        NumberValue2.Value = 30;
        local u17 = true;
        u8.AC:Connect(RunService.Heartbeat, function(p18) -- Line: 105
            -- upvalues: u17 (ref), BodyGyro (ref), HumanoidRootPart (ref), LinearVelocity (ref), NumberValue (copy), NumberValue2 (copy)
            if u17 then
                BodyGyro.CFrame = HumanoidRootPart.CFrame;
                LinearVelocity.VectorVelocity = HumanoidRootPart.CFrame.LookVector * NumberValue.Value * Vector3.new(1, 0, 1) + Vector3.new(0, 1, 0) * NumberValue2.Value;
            end;
        end);
        u8.AC:Add(task.delay(0.07777777777777778, function() -- Line: 113
            -- upvalues: TweenService (ref), NumberValue (copy), NumberValue2 (copy)
            TweenService:Create(NumberValue, TweenInfo.new(0.2, Enum.EasingStyle.Sine), {
                Value = 32
            }):Play();
            TweenService:Create(NumberValue2, TweenInfo.new(0.2, Enum.EasingStyle.Sine), {
                Value = 6
            }):Play();
        end));
        u8.AC:Add(task.delay(0.3, function() -- Line: 120
            -- upvalues: u17 (ref), LinearVelocity (ref), LocalPlayer (ref), HumanoidRootPart (ref), u3 (ref)
            u17 = false;

            if LinearVelocity then
                LinearVelocity:Destroy();
            end;

            HumanoidRootPart.AssemblyLinearVelocity = (workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position - HumanoidRootPart.Position).Unit * 160 * 1.37 * Vector3.new(1, 0, 1);
            u3.States.NoWalk = false;
        end));
    end));
    u8.AC:Connect(u2.Ability, function() -- Line: 129
        -- upvalues: u8 (copy), u6 (ref), Shiftlock (copy), u3 (ref)
        u8.AC:Clean();
        u6:SetShiftlock(Shiftlock);
        u3.States.Ability = false;
        u3.States.NoWalk = false;
    end);
end;