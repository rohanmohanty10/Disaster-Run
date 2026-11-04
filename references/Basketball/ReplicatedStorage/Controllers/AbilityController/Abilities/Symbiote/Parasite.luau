 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
local RunService = game:GetService("RunService");
game:GetService("TweenService");
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
    -- upvalues: LocalPlayer (copy), u1 (ref), u2 (ref), u4 (ref), u3 (ref), u5 (ref), u6 (ref), u7 (ref), Knit (copy), Effects (copy), RunService (copy)
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
        local u9 = u8:CheckInfront(45);

        if not u9 and RunService:IsStudio() then
            u9 = workspace.DefenseRig;
        end;

        if not u9 then
            Effects:Popup("An enemy must be close to you!");

            return u8:ResetCD(4);
        end;

        u3.States.NoWalk = true;
        u8.AC:Add(function() -- Line: 79
            -- upvalues: u3 (ref)
            u3.States.Ability = false;
            u3.States.NoWalk = false;
        end);
        u8.AC:Add(task.delay(0.6666666666666666, function() -- Line: 84
            -- upvalues: u3 (ref)
            u3.States.Ability = true;
        end));
        u8.AC:Add(task.delay(1.6666666666666667, function() -- Line: 88
            -- upvalues: u8 (copy)
            u8.AC:Clean();
        end));
        u4:StopAll();
        u4:PlayChar("Symbiote", "TendrilSwing", Enum.AnimationPriority.Action3);
        local HumanoidRootPart2 = u9:FindFirstChild("HumanoidRootPart");
        local AlignOrientation = Instance.new("AlignOrientation");
        AlignOrientation.MaxTorque = (1 / 0);
        AlignOrientation.Responsiveness = 80;
        AlignOrientation.Parent = HumanoidRootPart;
        AlignOrientation.Attachment0 = HumanoidRootPart.RootAttachment;
        AlignOrientation.Mode = Enum.OrientationAlignmentMode.OneAttachment;
        AlignOrientation.CFrame = CFrame.new(HumanoidRootPart.Position, (Vector3.new(HumanoidRootPart2.Position.X, HumanoidRootPart.Position.Y, HumanoidRootPart2.Position.Z)));
        u8.AC:Add(AlignOrientation);
        local u10 = nil;
        u8.AC:Add(task.delay(0.6666666666666666, function() -- Line: 108
            -- upvalues: u9 (ref), HumanoidRootPart2 (copy), HumanoidRootPart (copy), u10 (ref), u8 (copy)
            if u9 and HumanoidRootPart2 then
                local Magnitude = (HumanoidRootPart.Position - u9.HumanoidRootPart.Position).Magnitude;
                local LinearVelocity = Instance.new("LinearVelocity");
                LinearVelocity.MaxForce = (1 / 0);
                LinearVelocity.VectorVelocity = (u9.HumanoidRootPart.Position - HumanoidRootPart.Position).Unit * Vector3.new(1, 0, 1) * (140 + Magnitude / 5);
                LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
                LinearVelocity.Parent = HumanoidRootPart;
                u10 = LinearVelocity;
                u8.AC:Add(LinearVelocity);
            end;
        end));
        u8.AC:Add(task.delay(1.1666666666666667, function() -- Line: 132
            -- upvalues: u10 (ref), u3 (ref)
            if u10 then
                u10:Destroy();
            end;

            u3.States.NoWalk = false;
        end));
        u8.AC:Connect(RunService.Heartbeat, function(p11) -- Line: 137
            -- upvalues: u9 (ref), HumanoidRootPart2 (copy), AlignOrientation (copy), HumanoidRootPart (copy)
            if u9 and HumanoidRootPart2 then
                AlignOrientation.CFrame = CFrame.new(HumanoidRootPart.Position, (Vector3.new(HumanoidRootPart2.Position.X, HumanoidRootPart.Position.Y, HumanoidRootPart2.Position.Z)));
            end;
        end);
        u2.Ability:Fire("Parasite", {
            Ability = "Off-Ball",
            TimeSent = workspace:GetServerTimeNow()
        });

        return;
    end;

    local v12 = false;

    for _, v in pairs(game.Players:GetPlayers()) do
        if v and (v.Character and (v ~= LocalPlayer and (v.Team ~= LocalPlayer.Team and (v.Character.HumanoidRootPart.Position - HumanoidRootPart.Position).Magnitude <= 22))) then
            v12 = true;
            break;
        end;
    end;

    if not v12 then
        Effects:Popup("You need an enemy close to you!!");

        return u8:ResetCD(4);
    end;

    u2.Ability:Fire("Parasite", {
        Ability = "On-Ball",
        TimeSent = workspace:GetServerTimeNow()
    });
end;