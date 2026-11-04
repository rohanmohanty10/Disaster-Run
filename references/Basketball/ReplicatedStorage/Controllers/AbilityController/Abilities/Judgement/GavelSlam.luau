 
 

game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
require(ReplicatedStorage.Shared.Utility.Essentials);
local _ = require(ReplicatedStorage.Shared.Tables.Cooldowns).Abilities;
local CalculateBallTrajectory = require(ReplicatedStorage.Shared.Functions.CalculateBallTrajectory);
local PositionIsInTwoPointZone = require(ReplicatedStorage.Shared.Functions.PositionIsInTwoPointZone);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local LocalPlayer = game.Players.LocalPlayer;
local _ = workspace.CurrentCamera;

return function(u6) -- Line: 23
    -- upvalues: LocalPlayer (copy), u1 (ref), u2 (ref), u3 (ref), u4 (ref), u5 (ref), Effects (copy), PositionIsInTwoPointZone (copy), ReplicatedStorage (copy), CalculateBallTrajectory (copy), TweenService (copy)
    local Character = LocalPlayer.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local Humanoid = Character.Humanoid;
    u1 = u6.AbilityService;
    u2 = u6.MovementController;
    u3 = u6.BallController;
    u4 = u6.Animations;
    u5 = u6.Network;

    if not u5.CharValues.HasBall then
        u1.Ability:Fire("Gavel Slam", {
            State = "Gavel Slam",
            TimeSent = workspace:GetServerTimeNow()
        });
        u2.States.Ability = true;
        task.delay(0.8333333333333334, function() -- Line: 120
            -- upvalues: u2 (ref)
            u2.States.NoWalk = true;
            task.delay(1.1666666666666667, function() -- Line: 122
                -- upvalues: u2 (ref)
                u2.States.NoWalk = false;
            end);
        end);
        task.delay(2, function() -- Line: 126
            -- upvalues: u2 (ref)
            u2.States.Ability = false;
        end);
        u4:StopAll();
        u4:PlayChar("Judgement", "GavelSlam", Enum.AnimationPriority.Action3);
        local LinearVelocity = Instance.new("LinearVelocity");
        LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
        LinearVelocity.ForceLimitMode = Enum.ForceLimitMode.PerAxis;
        LinearVelocity.MaxAxesForce = Vector3.new(inf, 0, inf);
        LinearVelocity.VectorVelocity = HumanoidRootPart.CFrame.LookVector * Vector3.new(1, 0, 1) * 100;
        LinearVelocity.Parent = HumanoidRootPart;

        if HumanoidRootPart.AssemblyLinearVelocity.Y > 0 then
            HumanoidRootPart.AssemblyLinearVelocity = HumanoidRootPart.AssemblyLinearVelocity * Vector3.new(1, 0, 1);
        end;

        HumanoidRootPart.AssemblyLinearVelocity = HumanoidRootPart.AssemblyLinearVelocity + Vector3.new(0, workspace.Gravity * 50 / 60 / 2, 0);
        u6.AC:Add(LinearVelocity);
        TweenService:Create(LinearVelocity, TweenInfo.new(0.8333333333333334, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            VectorVelocity = HumanoidRootPart.CFrame.LookVector * Vector3.new(1, 0, 1) * 5
        }):Play();
        u6.AC:Add(task.delay(0.8333333333333334, function() -- Line: 149
            -- upvalues: u6 (copy)
            u6.AC:Clean();
        end));

        return;
    end;

    if u6:HoopDist() > 120 then
        Effects:Popup("Too far away from hoop!");
        u6:ResetCD(2);

        return;
    end;

    if PositionIsInTwoPointZone((u5.Gamemode == "Match-2v2" or u5.Gamemode == "Match-1v1") and "Ranked" or LocalPlayer.Team.Name, HumanoidRootPart.Position) then
        u2.States.NoWalk = true;
        u2.States.Ability = true;
        task.delay(1.8833333333333333, function() -- Line: 105
            -- upvalues: u2 (ref)
            u2.States.NoWalk = false;
            u2.States.Ability = false;
        end);
        u4:StopAll();
        u4:PlayChar("Judgement", "GavelDunk", Enum.AnimationPriority.Action3);
        u4:PlayBall("Judgement", "GavelDunkBall", Enum.AnimationPriority.Action3);
        u1.Ability:Fire("Gavel Slam", {
            State = "Dunk",
            TimeSent = workspace:GetServerTimeNow()
        });

        return;
    end;

    u1.Ability:Fire("Gavel Slam", {
        State = "Shot",
        TimeSent = workspace:GetServerTimeNow()
    });
    u2.States.Ability = true;
    u2.States.NoWalk = true;
    u2.States.AimAssist = true;
    task.delay(1.5444444444444445, function() -- Line: 54
        -- upvalues: u2 (ref)
        u2.States.Ability = false;
        u2.States.NoWalk = false;
        u2.States.AimAssist = false;
    end);
    u4:StopAll();
    local v7 = u4:PlayChar("Judgement", "GavelShot", Enum.AnimationPriority.Action3, true);
    local v8 = u4:PlayBall("Judgement", "GavelShotBall", Enum.AnimationPriority.Action3, true);
    v7:AdjustSpeed(1.5);
    v8:AdjustSpeed(1.5);
    task.wait(0.4666666666666666);
    local v9 = Humanoid.MoveDirection:Dot(HumanoidRootPart.CFrame.RightVector);
    local v10 = v9 > 0 and 1 or (v9 < 0 and -1 or (math.random(1, 2) == 1 and 1 or -1));
    local RaycastParams_new_ret = RaycastParams.new();
    RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
    RaycastParams_new_ret.FilterDescendantsInstances = { Character };
    local Position = workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position;
    local v11 = CFrame.new(HumanoidRootPart.Position, (Vector3.new(Position.X, HumanoidRootPart.Position.Y, Position.Z))).RightVector * v10 * 25;
    local v12 = workspace:Raycast(HumanoidRootPart.Position, v11, RaycastParams_new_ret);

    if v12 then
        HumanoidRootPart.CFrame = CFrame.new(HumanoidRootPart.Position + v11.Unit * (v12.Distance / 2)) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation());
    else
        HumanoidRootPart.CFrame = CFrame.new(HumanoidRootPart.Position + v11) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation());
    end;

    u6.AC:Connect(u1.Ability, function(p13) -- Line: 87
        -- upvalues: u6 (copy), ReplicatedStorage (ref), u3 (ref), CalculateBallTrajectory (ref), LocalPlayer (ref)
        if not p13 or p13.State ~= "Shot" then
            return;
        end;

        u6.AC:Clean();
        local Value = ReplicatedStorage.Basketball.Value;
        Value.CFrame = u3:GetLastCharacterToPossessBall().PlrBall.Anims.BALL.CFrame;
        Value.AssemblyLinearVelocity = CalculateBallTrajectory(Value.Position, workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position, 70);
    end);
end;