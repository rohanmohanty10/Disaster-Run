 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
require(ReplicatedStorage.Shared.Utility.Essentials);
local CalculateBallTrajectory = require(ReplicatedStorage.Shared.Functions.CalculateBallTrajectory);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local LocalPlayer = game.Players.LocalPlayer;
RunService:IsStudio();

return function(u6) -- Line: 25, Name: Nutmeg
    -- upvalues: LocalPlayer (copy), u1 (ref), u3 (ref), u2 (ref), u4 (ref), u5 (ref), Effects (copy), TweenService (copy), ReplicatedStorage (copy), CalculateBallTrajectory (copy)
    local HumanoidRootPart = LocalPlayer.Character.HumanoidRootPart;
    u1 = u6.AbilityService;
    u3 = u6.Animations;
    u2 = u6.MovementController;
    u4 = u6.Pass;
    u5 = u6.Network;
    local Position = workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position;
    local Gamemode = u5.Gamemode;
    local v7 = 0;

    for _, v in LocalPlayer.Team:GetPlayers() do
        if LocalPlayer ~= v then
            v7 = v7 + 1;
        end;
    end;

    if Gamemode ~= "Match-1v1" then
        local LookingAt = u4.LookingAt;

        if not u4.LookingAt then
            u6:ResetCD(2);
            Effects:Popup("Must be looking at team-mate!");

            return;
        end;

        if (LookingAt.HumanoidRootPart.Position - Position).Magnitude > 65 then
            u6:ResetCD(2);
            Effects:Popup("Team-mate too far away from hoop!");

            return;
        end;

        if (LookingAt.HumanoidRootPart.Position - HumanoidRootPart.Position).Magnitude > 110 then
            u6:ResetCD(2);
            Effects:Popup("Team-mate is too far away from you!");

            return;
        end;

        u2.States.Ability = true;
        task.delay(0.6, function() -- Line: 121
            -- upvalues: u2 (ref)
            u2.States.Ability = false;
        end);
        u3:StopAll();
        u3:PlayChar("Playmaker", "AlleyOop", Enum.AnimationPriority.Action3);
        u3:PlayBall("Playmaker", "AlleyOopBall", Enum.AnimationPriority.Action3);
        u1.Ability:Fire("AlleyOop", {
            TimeSent = workspace:GetServerTimeNow(),
            Other = LookingAt
        });

        return;
    end;

    local v8 = u6:HoopDist();

    if v8 < 20 then
        Effects:Popup("You are too close to the hoop!");
        u6:ResetCD(2);

        return;
    end;

    if v8 >= 75 then
        Effects:Popup("You are too far away from the hoop!");
        u6:ResetCD(2);

        return;
    end;

    u3:StopAll();
    u3:PlayChar("Playmaker", "Layup", Enum.AnimationPriority.Action3);
    u3:PlayBall("Playmaker", "LayupBall", Enum.AnimationPriority.Action3);
    u2.States.Ability = true;
    u2.States.NoWalk = true;
    local LinearVelocity = Instance.new("LinearVelocity");
    LinearVelocity.MaxForce = (1 / 0);
    LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
    LinearVelocity.Parent = HumanoidRootPart;
    u6.AC:Add(LinearVelocity);
    local Unit = (Position - HumanoidRootPart.Position).Unit;
    local u9 = 85 * (Unit.Z > 0 and 1 or -1);
    LinearVelocity.VectorVelocity = Unit * (v8 * 1.8) * Vector3.new(1, 0, 1);
    TweenService:Create(LinearVelocity, TweenInfo.new(1.5, Enum.EasingStyle.Sine), {
        VectorVelocity = Vector3.new(0, 0, 0)
    }):Play();
    task.delay(0.36666666666666664, function() -- Line: 80
        -- upvalues: LinearVelocity (copy), HumanoidRootPart (copy), u9 (copy)
        LinearVelocity.Enabled = false;
        task.wait();
        local v10 = HumanoidRootPart;
        v10.AssemblyLinearVelocity = v10.AssemblyLinearVelocity + (Vector3.new(0, 35, u9) + LinearVelocity.VectorVelocity * Vector3.new(0.9, 0, 0));
    end);
    u6.AC:Add(task.delay(2, function() -- Line: 86
        -- upvalues: u6 (copy), u2 (ref)
        u6.AC:Clean();
        u2.States.Ability = false;
        u2.States.NoWalk = false;
    end));
    u6.AC:Connect(u1.Ability, function(p11) -- Line: 92
        -- upvalues: u6 (copy), u2 (ref), ReplicatedStorage (ref), CalculateBallTrajectory (ref), Position (copy)
        u6.AC:Clean();
        u2.States.Ability = false;
        u2.States.NoWalk = false;
        local Value = ReplicatedStorage.Basketball.Value;
        Value.AssemblyLinearVelocity = CalculateBallTrajectory(Value.Position, Position, 70, 1 * workspace.Gravity);
    end);
    u1.Ability:Fire("AlleyOop", {
        Layup = true,
        TimeSent = workspace:GetServerTimeNow()
    });
end;