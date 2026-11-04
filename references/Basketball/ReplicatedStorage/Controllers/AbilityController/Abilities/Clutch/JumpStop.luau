 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
require(ReplicatedStorage.Shared.Utility.Essentials);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local Zones = require(ReplicatedStorage.Shared.Tables.Zones);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local LocalPlayer = game.Players.LocalPlayer;

return function(u7) -- Line: 21, Name: JumpStop
    -- upvalues: LocalPlayer (copy), u2 (ref), u6 (ref), u4 (ref), u1 (ref), u3 (ref), u5 (ref), Effects (copy), Zones (copy), RunService (copy), ReplicatedStorage (copy)
    local Character = LocalPlayer.Character;
    local Humanoid = Character.Humanoid;
    local HumanoidRootPart = Character.HumanoidRootPart;
    u2 = u7.MovementController;
    u6 = u7.CameraController;
    u4 = u7.BallController;
    u1 = u7.AbilityService;
    u3 = u7.Animations;
    u5 = u7.Network;

    if (HumanoidRootPart.Position - workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position).Magnitude >= 130 then
        u7:ResetCD(1);
        Effects:Popup("Too far away from hoop!");

        return;
    end;

    local u8 = 1.4;

    if Zones.ZoneIncreasedShootingSpeed[LocalPlayer.Zone.Value] and u5.CharValues.InZone then
        u8 = u8 + 0.2;
    end;

    u2.States.Ability = true;
    u2.States.Shooting = true;
    task.delay(1 / u8, function() -- Line: 42
        -- upvalues: u2 (ref)
        u2.States.Ability = false;
        u2.States.Shooting = false;
    end);
    u1.Ability:Fire("JumpStop", {
        TimeSent = workspace:GetServerTimeNow()
    });
    task.wait(0.1);
    u3:StopAll();
    local v9 = u3:PlayChar("Clutch", "Ability1", Enum.AnimationPriority.Action3, true);
    local v10 = u3:PlayBall("Clutch", "Ability1Ball", Enum.AnimationPriority.Action3, true);
    v9:AdjustSpeed(u8 * 1.5);
    v10:AdjustSpeed(u8 * 1.5);
    local v11 = HumanoidRootPart.CFrame:VectorToObjectSpace(Humanoid.MoveDirection);
    local v12 = v11.X > 0.01 and "R" or (v11.X < -0.01 and "L" or (v11.Z > 0.01 and "B" or "F"));
    local AlignOrientation = Instance.new("AlignOrientation");
    AlignOrientation.Mode = Enum.OrientationAlignmentMode.OneAttachment;
    AlignOrientation.CFrame = HumanoidRootPart.CFrame;
    AlignOrientation.Attachment0 = HumanoidRootPart.RootAttachment;
    AlignOrientation.MaxTorque = 40000;
    AlignOrientation.Responsiveness = 200;
    AlignOrientation.Parent = HumanoidRootPart;
    local LinearVelocity = Instance.new("LinearVelocity");
    LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
    LinearVelocity.MaxForce = 40000;
    LinearVelocity.VectorVelocity = HumanoidRootPart.CFrame.LookVector * 60;
    LinearVelocity.Parent = HumanoidRootPart;
    local Position = workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position;
    HumanoidRootPart.CFrame = CFrame.new(HumanoidRootPart.Position, (Vector3.new(Position.x, HumanoidRootPart.Position.Y, Position.Z)));
    u7.AC:Add(AlignOrientation);
    u7.AC:Add(LinearVelocity);
    local u13 = u8 * 70;
    local u14 = false;
    local u15 = 1;
    local LookVector = HumanoidRootPart.CFrame.LookVector;

    if v12 == "R" then
        LookVector = (LookVector + HumanoidRootPart.CFrame.RightVector / 2).Unit;
    elseif v12 == "L" then
        LookVector = (LookVector - HumanoidRootPart.CFrame.RightVector / 2).Unit;
    elseif v12 == "B" then
        LookVector = LookVector - HumanoidRootPart.CFrame.LookVector / 4;
    end;

    u7.AC:Connect(RunService.Heartbeat, function(p16) -- Line: 94
        -- upvalues: u14 (ref), LinearVelocity (copy), AlignOrientation (copy), LookVector (ref), u15 (ref), u13 (ref), u8 (ref)
        if u14 then
            if LinearVelocity then
                LinearVelocity:Destroy();
                AlignOrientation:Destroy();
            end;

            return;
        end;

        LinearVelocity.VectorVelocity = (LookVector + Vector3.new(0, u15, 0)) * u13;
        u13 = u13 - p16 * 15;
        u15 = u15 - p16 * 4 * u8;
    end);
    task.delay(0.375 / u8, function() -- Line: 102
        -- upvalues: u14 (ref)
        u14 = true;
    end);
    task.delay(0.6 / u8, function() -- Line: 106
        -- upvalues: HumanoidRootPart (copy)
        HumanoidRootPart.Parent.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping);
    end);
    u7.AC:Connect(u1.Ability, function() -- Line: 110
        -- upvalues: u7 (copy), u2 (ref), ReplicatedStorage (ref), u4 (ref), LocalPlayer (ref)
        u7.AC:Clean();
        u2.States.Ability = false;
        local Value = ReplicatedStorage.Basketball.Value;
        Value.CFrame = u4:GetLastCharacterToPossessBall().PlrBall.Anims.BALL.CFrame;
        local Position2 = Value.Position;
        local _ = (workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position - Position2).Magnitude;
        local v17 = workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position - Position2;
        local math_log_ret = math.log(1 + v17.Magnitude * 0.0425);
        Value.AssemblyLinearVelocity = v17 / math_log_ret + Vector3.new(0, workspace.Gravity * math_log_ret * 0.5, 0);
    end);
end;