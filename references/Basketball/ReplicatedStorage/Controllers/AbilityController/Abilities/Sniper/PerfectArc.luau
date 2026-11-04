 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
local CameraShaker = require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local Zones = require(ReplicatedStorage.Shared.Tables.Zones);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local LocalPlayer = game.Players.LocalPlayer;

return function(u7) -- Line: 20, Name: PerfectArc
    -- upvalues: LocalPlayer (copy), Effects (copy), u1 (ref), u3 (ref), u2 (ref), u4 (ref), u6 (ref), u5 (ref), Zones (copy), RunService (copy), TweenService (copy), CameraShaker (copy), ReplicatedStorage (copy)
    local Character = LocalPlayer.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local Humanoid = Character.Humanoid;
    local Attribute = LocalPlayer:GetAttribute("TrueSniper");

    if not u7:LookingAtNet() then
        u7:ResetCD(1);
        Effects:Popup("Must look towards the hoop to use ability!");

        return;
    end;

    if not Attribute and math.abs(HumanoidRootPart.Position.X - workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position.X) > 145 then
        u7:ResetCD(1);
        Effects:Popup("Only shootable from your half of the court!");

        return;
    end;

    if Humanoid:GetState() == Enum.HumanoidStateType.Freefall or Humanoid:GetState() == Enum.HumanoidStateType.Jumping then
        u7:ResetCD(1);
        Effects:Popup("Can\'t shoot while in the air!");

        return;
    end;

    u1 = u7.AbilityService;
    u3 = u7.Animations;
    u2 = u7.MovementController;
    u4 = u7.BallController;
    u6 = u7.Network;
    u5 = u7.CameraController;
    local u8 = u7.PerfectArcSpeed or 1.3;

    if Zones.ZoneIncreasedShootingSpeed[LocalPlayer.Zone.Value] and u6.CharValues.InZone then
        u8 = u8 + 0.2;
    end;

    if u6.CharValues.InAwakening then
        u8 = u8 + 0.75;
    end;

    u2.States.Shooting = true;
    task.delay(1.5 / u8, function() -- Line: 44
        -- upvalues: u2 (ref)
        u2.States.Shooting = false;
    end);
    u2.States.Ability = true;
    u2.States.NoWalk = true;
    task.delay(1.5 / u8, function() -- Line: 48
        -- upvalues: u2 (ref)
        u2.States.Ability = false;
        u2.States.NoWalk = false;
    end);
    RunService.Heartbeat:Wait();
    local Position = workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position;
    HumanoidRootPart.CFrame = CFrame.lookAt(HumanoidRootPart.Position, (Vector3.new(Position.X, HumanoidRootPart.Position.Y, Position.Z)));
    u3:StopAll();
    local v9 = u3:PlayChar("Sniper", "Ability1", Enum.AnimationPriority.Action3, true);
    local v10 = u3:PlayBall("Sniper", "Ability1Ball", Enum.AnimationPriority.Action3, true);
    v9:AdjustSpeed(u8 - 0.25);
    v10:AdjustSpeed(u8 - 0.25);
    task.spawn(function() -- Line: 61
        -- upvalues: TweenService (ref), u8 (ref), u5 (ref), CameraShaker (ref)
        local workspace_CurrentCamera = workspace.CurrentCamera;
        local v11 = TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.9, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            FieldOfView = 35
        });
        local v12 = TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            FieldOfView = 90
        });
        v11:Play();
        task.wait(0.9 / u8);
        u5.CamShake:Shake(CameraShaker.Presets.Ankle);
        v12:Play();
    end);
    task.delay(0.2 / u8, function() -- Line: 78
        -- upvalues: u8 (ref), Character (copy)
        task.delay(0.3 / u8, function() -- Line: 79
            workspace.Gravity = 50;
        end);
        task.delay(0.65 / u8, function() -- Line: 82
            workspace.Gravity = 100;
        end);
        Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping);
    end);
    u1.Ability:Fire("PerfectArc", {
        TimeSent = workspace:GetServerTimeNow(),
        PerfectArcSpeed = u7.PerfectArcSpeed
    });
    task.wait(1 / u8);

    if u7.Network.CharValues.HasBall == false then
        return;
    end;

    u7.AC:Connect(u1.Ability, function(p13) -- Line: 92
        -- upvalues: u7 (copy), Effects (ref), ReplicatedStorage (ref), u2 (ref), u4 (ref), LocalPlayer (ref)
        if p13 then
            if p13.Fail then
                local v14 = u7;
                v14.PerfectArcSpeed = v14.PerfectArcSpeed - 0.5;

                if u7.PerfectArcSpeed <= 1.3 then
                    u7.PerfectArcSpeed = 1.3;
                else
                    Effects:Popup("You missed! Perfect Arc speed reduced!");
                end;
            elseif p13.Success then
                Effects:Popup("You\'re on fire! Perfect Arc speed increased!");
                local v15 = u7;
                v15.PerfectArcSpeed = v15.PerfectArcSpeed + 0.25;

                if u7.PerfectArcSpeed >= 2.05 then
                    u7.PerfectArcSpeed = 2.05;
                end;
            end;

            u7.AC:Clean();

            return;
        end;

        if not u7.PerfectArcSpeed then
            u7.PerfectArcSpeed = 1.3;
        end;

        local Value = ReplicatedStorage.Basketball.Value;
        u2.States.Shooting = false;
        u2.States.Ability = false;
        u2.States.NoWalk = false;
        Value.CFrame = u4:GetLastCharacterToPossessBall().PlrBall.Anims.BALL.CFrame;
        local Position2 = Value.Position;
        local _ = (workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position - Position2).Magnitude;
        local v16 = workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position - Position2;
        local math_log_ret = math.log(v16.Magnitude * 0.045);
        Value.AssemblyLinearVelocity = v16 / math_log_ret + Vector3.new(0, workspace.Gravity * math_log_ret * 0.5, 0);
    end);
end;