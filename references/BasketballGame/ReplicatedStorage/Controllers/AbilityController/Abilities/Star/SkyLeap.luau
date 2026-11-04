 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
local CameraShaker = require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local LocalPlayer = game.Players.LocalPlayer;

return function(u7) -- Line: 20, Name: SkyLeap
    -- upvalues: LocalPlayer (copy), u4 (ref), u1 (ref), u3 (ref), u2 (ref), u6 (ref), u5 (ref), Effects (copy), TweenService (copy), Essentials (copy), RunService (copy), ReplicatedStorage (copy), CameraShaker (copy)
    local HumanoidRootPart = LocalPlayer.Character.HumanoidRootPart;
    u4 = u7.BallController;
    u1 = u7.AbilityService;
    u3 = u7.Animations;
    u2 = u7.MovementController;
    u6 = u7.CameraController;
    u5 = u7.Network;

    if not u5.CharValues.HasBall then
        if u5.CharValues.Blocked + 2 > tick() then
            u7:ResetCD(1);
            Effects:Popup("Can\'t use after block!");

            return;
        end;

        u3:StopAll();
        u3:PlayChar("Star", "Ability1Jump", Enum.AnimationPriority.Action3);
        u2.States.Ability = true;
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
        LinearVelocity.VectorVelocity = HumanoidRootPart.CFrame.LookVector * 30;
        LinearVelocity.Parent = HumanoidRootPart;
        u7.AC:Add(AlignOrientation);
        u7.AC:Add(LinearVelocity);
        local u8 = 30;
        local LookVector = HumanoidRootPart.CFrame.LookVector;
        local u9 = 0.25;
        local FieldOfView = workspace.CurrentCamera.FieldOfView;
        local u10 = false;
        u7.AC:Add(function() -- Line: 216
            -- upvalues: u2 (ref), u3 (ref)
            u2.States.Ability = false;
            u3:StopAll();
        end);
        u7.AC:Connect(RunService.Heartbeat, function(p11) -- Line: 221
            -- upvalues: u5 (ref), u7 (copy), u4 (ref), HumanoidRootPart (copy), LookVector (ref), LinearVelocity (copy), u9 (ref), u8 (ref), u10 (ref), FieldOfView (ref), Essentials (ref)
            if u5.CharValues.HasBall then
                u7.AC:Clean();

                return;
            end;

            local ServerBallPosition = u4:GetServerBallPosition();
            local Vector3_new_ret = Vector3.new(ServerBallPosition.X, HumanoidRootPart.Position.Y, ServerBallPosition.Z);
            LookVector = HumanoidRootPart.CFrame.LookVector;

            if not ServerBallPosition:FuzzyEq(HumanoidRootPart.Position) then
                LookVector = LookVector + (Vector3_new_ret - HumanoidRootPart.Position).Unit;
            end;

            LinearVelocity.VectorVelocity = (LookVector + Vector3.new(0, u9, 0)) * u8;
            u8 = u8 - p11 * 5;

            if u10 then
                FieldOfView = Essentials:Lerp(FieldOfView, u8 + 40, p11 * 12);
            else
                FieldOfView = Essentials:Lerp(FieldOfView, u8 + 10, p11 * 12);
            end;

            workspace.CurrentCamera.FieldOfView = FieldOfView;
            u9 = u9 - p11;
        end);
        u7.AC:Add(task.delay(0.5, function() -- Line: 250
            -- upvalues: u10 (ref), u8 (ref), u9 (ref), u1 (ref), u7 (copy)
            u10 = true;
            u8 = 50;
            u9 = 1;
            u1.Ability:Fire("SkyLeap", {
                State = "Leap",
                TimeSent = workspace:GetServerTimeNow()
            });
            u7.AC:Add(task.delay(0.5, function() -- Line: 257
                -- upvalues: u7 (ref)
                u7.AC:Clean();
            end));
        end));

        return;
    end;

    local Magnitude = (HumanoidRootPart.Position - workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position).Magnitude;

    if Magnitude >= 70 then
        u7:ResetCD(1);
        Effects:Popup("Too far away from hoop!");

        return;
    end;

    if Magnitude <= 32.5 then
        u7:ResetCD(1);
        Effects:Popup("Too close to hoop!");

        return;
    end;

    if u2.States.PumpFake then
        u7:ResetCD(1);
        Effects:Popup("Can\'t use move after fake!");

        return;
    end;

    u2.States.Ability = true;
    task.delay(2.5, function() -- Line: 39
        -- upvalues: u2 (ref)
        u2.States.Ability = false;
    end);
    local Shiftlock = u6.Shiftlock;
    u6:SetShiftlock(false);
    task.wait(0.1);
    task.spawn(function() -- Line: 48
        -- upvalues: TweenService (ref)
        local workspace_CurrentCamera = workspace.CurrentCamera;
        local v12 = TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.3, Enum.EasingStyle.Sine), {
            FieldOfView = 40
        });
        local v13 = TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.3, Enum.EasingStyle.Sine), {
            FieldOfView = 35
        });
        local v14 = TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.3, Enum.EasingStyle.Sine), {
            FieldOfView = 120
        });
        local u15 = TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.3, Enum.EasingStyle.Sine), {
            FieldOfView = 100
        });
        v12:Play();
        task.wait(0.3);
        v14:Play();
        task.delay(0.5, function() -- Line: 71
            -- upvalues: u15 (copy)
            u15:Play();
        end);
        task.wait(0.8);
        v13:Play();
    end);
    u3:StopAll();
    local u16 = u3:PlayChar("Star", `Ability1Dunk{Essentials:ReturnRorL(u5.CharValues)}`, Enum.AnimationPriority.Action3, true);
    local u17 = u3:PlayBall("Star", `Ability1Dunk{Essentials:ReturnRorL(u5.CharValues)}Ball`, Enum.AnimationPriority.Action3, true);
    u1.Ability:Fire("SkyLeap", {
        State = "Dunk",
        TimeSent = workspace:GetServerTimeNow()
    });
    local LinearVelocity = Instance.new("LinearVelocity");
    LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
    LinearVelocity.MaxForce = 40000;
    LinearVelocity.VectorVelocity = HumanoidRootPart.CFrame.LookVector * 30;
    LinearVelocity.Parent = HumanoidRootPart;
    local LinearVelocity2 = Instance.new("LinearVelocity");
    LinearVelocity2.MaxForce = 40000;
    LinearVelocity2.VectorVelocity = Vector3.new(0, 0, 0);
    u7.AC:Add(LinearVelocity);
    u7.AC:Add(LinearVelocity2);
    local u18 = 39;
    local u19 = false;
    local u20 = false;
    local u21 = 0.25;
    local LookVector = HumanoidRootPart.CFrame.LookVector;
    local Position = workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position;
    local u22 = tick();
    u7.AC:Connect(RunService.Heartbeat, function(p23) -- Line: 107
        -- upvalues: u22 (ref), u7 (copy), u2 (ref), u20 (ref), u19 (ref), HumanoidRootPart (copy), Position (copy), LookVector (ref), LinearVelocity (copy), u18 (ref), u16 (copy), u17 (copy), u21 (ref), ReplicatedStorage (ref), u4 (ref), LinearVelocity2 (copy)
        if u22 + 5 < tick() then
            u7.AC:Clean();

            return;
        end;

        if u2.States.Stunned then
            u7.AC:Clean();

            return;
        end;

        if not u20 then
            if not u19 then
                LinearVelocity.VectorVelocity = (LookVector + Vector3.new(0, u21, 0)) * u18;
                u18 = u18 - p23 * 15;
                u21 = u21 - p23 * 2;

                return;
            end;

            if HumanoidRootPart.Position.Y >= 8 then
                HumanoidRootPart.CFrame = CFrame.new(HumanoidRootPart.Position, Position);
            end;

            local _ = (Vector3.new(Position.X, HumanoidRootPart.Position.Y, Position.Z) - HumanoidRootPart.Position).Unit;
            LookVector = Vector3.new(0, 1, 0) + HumanoidRootPart.CFrame.LookVector;
            LinearVelocity.VectorVelocity = LookVector * u18;
            u18 = u18 - p23 * 50;
            u16:AdjustSpeed(u18 / 42);
            u17:AdjustSpeed(u18 / 42);

            return;
        end;

        HumanoidRootPart.CFrame = CFrame.new(HumanoidRootPart.Position, (Vector3.new(Position.X, HumanoidRootPart.Position.Y, Position.Z)));
        u16:AdjustSpeed(1);
        u17:AdjustSpeed(1);
        local Value = ReplicatedStorage.Basketball.Value;
        local ServerBallPosition = u4:GetServerBallPosition();
        local v24 = Position + Vector3.new(0, 2.25, 0) - ServerBallPosition;
        local Magnitude2 = v24.Magnitude;
        LinearVelocity2.VectorVelocity = v24.Unit * 100;

        if Magnitude2 <= 1 then
            Value.AssemblyLinearVelocity = Vector3.new(0, -15, 0);
            LinearVelocity2:Destroy();
            u7.AC:Clean();
        end;
    end);
    task.delay(0.3, function() -- Line: 156
        -- upvalues: u19 (ref), u18 (ref)
        u19 = true;
        u18 = 50;
    end);
    u7.AC:Connect(u1.Ability, function(p25) -- Line: 161
        -- upvalues: u22 (ref), u6 (ref), CameraShaker (ref), u2 (ref), ReplicatedStorage (ref), u4 (ref), LinearVelocity2 (copy), LinearVelocity (copy), u20 (ref), Shiftlock (copy), u7 (copy)
        if not p25.Dunk then
            u7.AC:Clean();
            u6:SetShiftlock(Shiftlock);

            return;
        end;

        u22 = tick();
        u6.CamShake:Shake(CameraShaker.Presets.FormlessShot);
        u2.States.Ability = false;
        local Value = ReplicatedStorage.Basketball.Value;
        Value.CFrame = u4:GetLastCharacterToPossessBall().PlrBall.Anims.BALL.CFrame;
        LinearVelocity2.Attachment0 = Value.Root;
        LinearVelocity2.Parent = Value;
        LinearVelocity:Destroy();
        u20 = true;
        task.wait(0.25);
        u6:SetShiftlock(Shiftlock);
    end);
end;