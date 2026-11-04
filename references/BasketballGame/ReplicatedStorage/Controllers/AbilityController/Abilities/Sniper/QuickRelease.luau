 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local LocalPlayer = game.Players.LocalPlayer;

return function(p7) -- Line: 19, Name: QuickRelease
    -- upvalues: LocalPlayer (copy), u1 (ref), u3 (ref), u2 (ref), u4 (ref), u5 (ref), u6 (ref), Effects (copy), TweenService (copy), RunService (copy), ReplicatedStorage (copy)
    local Character = LocalPlayer.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local Attribute = LocalPlayer:GetAttribute("TrueSniper");
    u1 = p7.AbilityService;
    u3 = p7.Animations;
    u2 = p7.MovementController;
    u4 = p7.BallController;
    u5 = p7.CameraController;
    u6 = p7.Network;

    if not (Attribute or u6.CharValues.HasBall) then
        p7:ResetCD(2);
        Effects:Popup("Not usable without ball!");

        return;
    end;

    if not p7:LookingAtNet() then
        p7:ResetCD(2);
        Effects:Popup("Must be looking at the hoop!");

        return;
    end;

    if not Attribute and p7.Network.CharValues.Inside == false or (Attribute and 115 or 100) < math.abs(HumanoidRootPart.Position.X - workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position.X) then
        p7:ResetCD(2);

        if Attribute then
            Effects:Popup("Too far away from hoop!");

            return;
        end;

        Effects:Popup("Only usable in 2 points Area!");

        return;
    end;

    if Attribute and not u6.CharValues.HasBall then
        if u4:GetPlayerPossessingBall() then
            p7:ResetCD(2);
            Effects:Popup("Ball must have been just passed!");

            return;
        end;

        local LastCharacterToPossessBall = u4:GetLastCharacterToPossessBall();

        if LastCharacterToPossessBall:GetAttribute("Unblockable") and LastCharacterToPossessBall:GetAttribute("Unblockable") > workspace:GetServerTimeNow() then
            p7:ResetCD(2);
            Effects:Popup("Can\'t catch pass!");

            return;
        end;

        local ServerBallPosition = u4:GetServerBallPosition();
        local Unit = (ServerBallPosition - HumanoidRootPart.Position).Unit;

        if (ServerBallPosition - HumanoidRootPart.Position).Magnitude >= 35 then
            p7:ResetCD(2);
            Effects:Popup("Ball is too far away!");

            return;
        end;

        if Unit.Y < 0 then
            Unit = Vector3.new(Unit.X, 0, Unit.Z);
        end;

        local LinearVelocity = Instance.new("LinearVelocity");
        LinearVelocity.ForceLimitMode = Enum.ForceLimitMode.PerAxis;
        LinearVelocity.MaxAxesForce = Vector3.new(2000000000, 2000000000, 2000000000);
        LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
        LinearVelocity.Parent = HumanoidRootPart;
        LinearVelocity.VectorVelocity = Unit * 50;
        u1.Ability:Fire("QuickRelease", {
            Catch = true,
            TimeSent = workspace:GetServerTimeNow()
        });
        local v8 = tick();

        repeat
            task.wait();
        until tick() - v8 > 1.5 or u6.CharValues.HasBall;

        LinearVelocity.MaxAxesForce = Vector3.new(2000000000, 0, 2000000000);
        TweenService:Create(LinearVelocity, TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            VectorVelocity = Unit
        }):Play();
        task.delay(0.15, function() -- Line: 92
            -- upvalues: LinearVelocity (copy)
            LinearVelocity:Destroy();
        end);

        if not u6.CharValues.HasBall then
            p7:ResetCD(2);
            Effects:Popup("Failed to catch pass!");

            return;
        end;
    end;

    u2.States.AimAssist = true;
    task.delay(0.7, function() -- Line: 104
        -- upvalues: u2 (ref)
        u2.States.AimAssist = false;
    end);
    u2.States.Ability = true;
    task.delay(0.7, function() -- Line: 107
        -- upvalues: u2 (ref)
        u2.States.Ability = false;
        u2.States.NoWalk = false;
    end);
    task.delay(0.1, function() -- Line: 109
        -- upvalues: LocalPlayer (ref), HumanoidRootPart (copy)
        local Position = workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position;
        HumanoidRootPart.CFrame = CFrame.new(HumanoidRootPart.Position, (Vector3.new(Position.X, HumanoidRootPart.Position.Y, Position.Z)));
    end);
    u3:StopAll();
    local v9 = u3:PlayChar("Sniper", "Ability1", Enum.AnimationPriority.Action3, true);
    local v10 = u3:PlayBall("Sniper", "Ability1Ball", Enum.AnimationPriority.Action3, true);
    v9:AdjustSpeed(2.375);
    v10:AdjustSpeed(2.375);
    Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping);
    RunService.Heartbeat:Wait();
    local Position = workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position;
    HumanoidRootPart.CFrame = CFrame.new(HumanoidRootPart.Position, (Vector3.new(Position.X, HumanoidRootPart.Position.Y, Position.Z)));
    u1.Ability:Fire("QuickRelease", {
        TimeSent = workspace:GetServerTimeNow()
    });
    task.wait(0.27999999999999997);

    if p7.Network.CharValues.HasBall == false then
        return;
    end;

    local Position2 = workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position;
    HumanoidRootPart.CFrame = CFrame.new(HumanoidRootPart.Position, (Vector3.new(Position2.X, HumanoidRootPart.Position.Y, Position2.Z)));
    p7.AC:Connect(u1.Ability, function() -- Line: 135
        -- upvalues: ReplicatedStorage (ref), u2 (ref), u4 (ref), LocalPlayer (ref)
        local Value = ReplicatedStorage.Basketball.Value;
        u2.States.Shooting = false;
        u2.States.Ability = false;
        u2.States.NoWalk = false;
        u2.States.AimAssist = false;
        Value.CFrame = u4:GetLastCharacterToPossessBall().PlrBall.Anims.BALL.CFrame;
        local ServerBallPosition = u4:GetServerBallPosition();
        local _ = (workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position - ServerBallPosition).Magnitude;
        local v11 = workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position - ServerBallPosition;
        local math_log_ret = math.log(1.75 + v11.Magnitude * 0.045);
        Value.AssemblyLinearVelocity = v11 / math_log_ret + Vector3.new(0, workspace.Gravity * math_log_ret * 0.5, 0);
    end);
end;