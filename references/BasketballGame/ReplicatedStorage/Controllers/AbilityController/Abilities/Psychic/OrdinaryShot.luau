 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
game:GetService("TweenService");
game:GetService("RunService");
local Knit = require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local CalculateBallTrajectory = require(ReplicatedStorage.Shared.Functions.CalculateBallTrajectory);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local LocalPlayer = game.Players.LocalPlayer;

return function(u6) -- Line: 20, Name: OrdinaryShot
    -- upvalues: LocalPlayer (copy), u2 (ref), u3 (ref), u1 (ref), u4 (ref), u5 (ref), Effects (copy), ReplicatedStorage (copy), CalculateBallTrajectory (copy), Knit (copy)
    local HumanoidRootPart = LocalPlayer.Character.HumanoidRootPart;
    u2 = u6.MovementController;
    u3 = u6.BallController;
    u1 = u6.AbilityService;
    u4 = u6.Animations;
    u5 = u6.Network;

    if not u5.CharValues.HasBall then
        local LastCharacterToPossessBall = u3:GetLastCharacterToPossessBall();
        local v7;

        if u6.Pass.LookingAtEnemy and (LastCharacterToPossessBall == u6.Pass.LookingAtEnemy and (u6.Pass.LookingAtEnemy.HumanoidRootPart.Position - HumanoidRootPart.Position).Magnitude <= 50) then
            v7 = u6.Pass.LookingAtEnemy;
        else
            v7 = nil;
        end;

        local v8 = v7 or HumanoidRootPart.CFrame;
        u1.Ability:Fire("OrdinaryShot", {
            State = "Teleport",
            TimeSent = workspace:GetServerTimeNow(),
            Goto = v8
        });

        if u2.States.Stealing then
            u2.States.Stealing = false;

            return;
        end;

        Knit.GetController("DefenseController"):StealDb();

        return;
    end;

    if (workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position - HumanoidRootPart.Position).Magnitude > 125 then
        Effects:Popup("Too far away from hoop!", 1);

        return u6:ResetCD(1);
    end;

    Effects:Popup("Base abilities can\'t block the shot!");
    u2.States.Ability = true;
    u2.States.NoWalk = true;
    u2.States.AimAssist = true;
    u4:StopAll();
    local v9 = u4:PlayChar("Psychic", "OrdinaryShot", Enum.AnimationPriority.Action3, true);
    local v10 = u4:PlayBall("Psychic", "OrdinaryShotBall", Enum.AnimationPriority.Action3, true);
    v9:AdjustSpeed(0.5);
    v10:AdjustSpeed(0.5);
    u1.Ability:Fire("OrdinaryShot", {
        State = "OrdinaryShot",
        TimeSent = workspace:GetServerTimeNow()
    });
    u6.AC:Add(task.delay(5.265, function() -- Line: 53
        -- upvalues: u2 (ref)
        u2.States.Ability = false;
        u2.States.NoWalk = false;
        u2.States.AimAssist = false;
    end));
    u6.AC:Connect(u1.Ability, function(p11) -- Line: 60
        -- upvalues: u6 (copy), u2 (ref), ReplicatedStorage (ref), LocalPlayer (ref), u3 (ref), CalculateBallTrajectory (ref)
        u6.AC:Clean();

        if p11.State == "Shoot" then
            u2.States.Ability = false;
            u2.States.NoWalk = false;
            u2.States.AimAssist = false;
            local Value = ReplicatedStorage.Basketball.Value;
            local Hoop = workspace.Hoops[LocalPlayer.Team.Name].Hoop;
            u3:TeleportServerBallToPlayerAnimationBall();
            local v12 = (math.random(1, 2) == 1 and 1 or -1) * 30;
            local RaycastParams_new_ret = RaycastParams.new();
            RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Include;
            RaycastParams_new_ret.FilterDescendantsInstances = { workspace.Barriers };

            if workspace:Raycast(Value.Position, Value.CFrame.RightVector * v12, RaycastParams_new_ret) then
                v12 = v12 * -1;
            end;

            local v13 = CalculateBallTrajectory(Value.Position, Hoop.Position, 144.5, 1 * workspace.Gravity);
            local Unit = Vector3.new(v13.X, 0, v13.Z).Unit:Cross(Vector3.new(0, 1, 0)).Unit;
            local v14 = (math.sqrt(20880.25 - 2 * (Hoop.Position - Value.Position).Y * workspace.Gravity) + 144.5) / workspace.Gravity;
            local Mass = Value:GetMass();
            local BodyForce = Instance.new("BodyForce");
            BodyForce.Name = "CurveVelocity";
            BodyForce.Force = -Unit * (2 * (v12 * v14) / v14 ^ 2 * Mass);
            BodyForce.Parent = Value;
            Value.AssemblyLinearVelocity = v13 + Unit * v12;
            local v15 = 0;

            while v15 < v14 do
                local v16 = Value.Position - Hoop.Position;

                if v16:Dot(v16) <= 4 then
                    break;
                end;

                v15 = v15 + task.wait();
            end;

            BodyForce:Destroy();
        end;
    end);
end;