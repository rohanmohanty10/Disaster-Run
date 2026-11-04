 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = nil;
local LocalPlayer = game.Players.LocalPlayer;

return function(u8) -- Line: 21
    -- upvalues: LocalPlayer (copy), u3 (ref), u5 (ref), u4 (ref), u6 (ref), u7 (ref), u1 (ref), u2 (ref), Effects (copy), Essentials (copy), RunService (copy), TweenService (copy), ReplicatedStorage (copy)
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

    if u1.CharValues.HasBall then
        if Humanoid:GetState() == Enum.HumanoidStateType.Freefall or Humanoid:GetState() == Enum.HumanoidStateType.Jumping then
            u8:ResetCD(1);
            Effects:Popup("Can\'t use in air!");

            return;
        end;

        if u4.States.PumpFake then
            u8:ResetCD(1);
            Effects:Popup("Can\'t use after a fake!");

            return;
        end;

        u4.States.Ability = true;
        local u9 = 0;
        local u10 = {};
        local u11 = 0;
        local u12 = 0;
        local u13 = 0;
        local u14 = false;
        local u15 = { { "Forward", 0.5 }, { "Left", 0.3 }, { "Right", 0.3, 0.2 }, { "Left", 0.3 }, { "Right", 0.3 } };
        local LinearVelocity = Instance.new("LinearVelocity");
        LinearVelocity.ForceLimitMode = Enum.ForceLimitMode.PerAxis;
        LinearVelocity.MaxAxesForce = Vector3.new(400000, 0, 400000);
        LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
        LinearVelocity.Parent = HumanoidRootPart;
        u8.AC:Add(LinearVelocity);
        local RaycastParams_new_ret = RaycastParams.new();
        RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Include;
        RaycastParams_new_ret.FilterDescendantsInstances = { workspace.Barriers };

        local function UpdatePhase() -- Line: 77
            -- upvalues: u9 (ref), u15 (copy), u14 (ref), u10 (ref), u12 (ref), u13 (ref), u11 (ref)
            u9 = u9 + 1;

            if not u15[u9] then
                return;
            end;

            u14 = false;
            u10 = u15[u9];
            u12 = tick();
            u13 = tick() + u10[2] + (not u10[3] and 0 or u10[3]);

            if u10[3] then
                u11 = tick() + u10[3];
            end;
        end;

        u5:StopAll();
        u5:PlayChar("Ace", `Ability1Start{Essentials:ReturnRorL(u1.CharValues)}`, Enum.AnimationPriority.Action3);
        u5:PlayBall("Ace", `Ability1StartBall{Essentials:ReturnRorL(u1.CharValues)}`, Enum.AnimationPriority.Action3);
        u3.Ability:Fire("FormlessDrive", {
            TimeSent = workspace:GetServerTimeNow()
        });
        UpdatePhase();
        u8.AC:Connect(RunService.Heartbeat, function(p16) -- Line: 97
            -- upvalues: u10 (ref), u11 (ref), u13 (ref), u12 (ref), UpdatePhase (copy), HumanoidRootPart (copy), RaycastParams_new_ret (copy), u14 (ref), TweenService (ref), u9 (ref), LinearVelocity (copy)
            if u10[1] == nil or u11 > tick() then
                if tick() < u11 then
                    LinearVelocity.VectorVelocity = Vector3.new(0, 0, 0);
                end;

                return;
            end;

            if u13 <= tick() then
                u12 = 0;
                UpdatePhase();

                return;
            end;

            local v17 = u10[1];
            local v18;

            if v17 == "Forward" then
                v18 = HumanoidRootPart.CFrame.LookVector * 5;
            elseif v17 == "Right" then
                v18 = HumanoidRootPart.CFrame.RightVector * 5 + HumanoidRootPart.CFrame.LookVector * 10;
            else
                v18 = v17 ~= "Left" and Vector3.new(0, 0, 0) or HumanoidRootPart.CFrame.RightVector * -5 + HumanoidRootPart.CFrame.LookVector * 10;
            end;

            local v19 = workspace:Raycast(HumanoidRootPart.Position, v18, RaycastParams_new_ret);

            if v19 and v19.Instance then
                if u10[1] == "Right" then
                    u14 = true;
                    u10[1] = "Left";
                elseif u10[1] == "Left" then
                    u14 = true;
                    u10[1] = "Right";
                elseif u10[1] == "Forward" then
                    u10[1] = "Backward";
                end;
            end;

            local v20 = Vector3.new(0, 0, 0);

            if u10[1] == "Forward" then
                v20 = HumanoidRootPart.CFrame.LookVector;
            elseif u10[1] == "Right" or u10[1] == "Left" then
                v20 = HumanoidRootPart.CFrame.RightVector;
            elseif u10[1] == "Backward" then
                v20 = HumanoidRootPart.CFrame.LookVector;
            end;

            local v21;

            if u10[1] == "Left" or u10[1] == "Backward" then
                v21 = v20 * -50;
            else
                v21 = v20 * 50;
            end;

            if u10[1] ~= "Forward" and u10[1] ~= "Backward" then
                if u14 then
                    v21 = v21 - HumanoidRootPart.CFrame.LookVector * 75;
                else
                    v21 = v21 + HumanoidRootPart.CFrame.LookVector * 75;
                end;
            end;

            local v22 = (u13 - tick()) / (u13 - u12);
            local Value = TweenService:GetValue(math.clamp(v22, 0.2, 1), Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
            local v23 = u9 == 1 and 1 or Value;
            LinearVelocity.VectorVelocity = v21 * (Vector3.new(v23, 0, v23) * 1.35);
        end);
        u8.AC:Add(function() -- Line: 180
            -- upvalues: u4 (ref)
            u4.States.Ability = false;
        end);
        u8.AC:Add(task.delay(2.3, function() -- Line: 183
            -- upvalues: u8 (copy)
            u8.AC:Clean();
        end));

        return;
    end;

    u4.States.Ability = true;
    u5:StopAll();
    local u24 = u5:PlayChar("Ace", "InstinctDash", Enum.AnimationPriority.Action3, true);
    u24:AdjustSpeed(1.35);
    u3.Ability:Fire("FormlessDrive", {
        switch = true,
        TimeSent = workspace:GetServerTimeNow()
    });
    local Value = ReplicatedStorage.Basketball.Value;
    local Shiftlock = u8.CameraController.Shiftlock;
    u8.CameraController:SetShiftlock(false);
    local u25 = 125;
    local ServerBallPosition = u6:GetServerBallPosition();
    local Unit = (ServerBallPosition + Value.AssemblyLinearVelocity / 6 - HumanoidRootPart.Position).Unit;
    local u26 = ServerBallPosition;
    local u27 = u25 * Vector3.new(1, 0, 1);
    local BodyGyro = Instance.new("BodyGyro");
    BodyGyro.Name = "GyroBasketball";
    BodyGyro.MaxTorque = Vector3.new(9000000000, 9000000000, 9000000000);
    BodyGyro.P = 1250;
    BodyGyro.CFrame = CFrame.lookAt(HumanoidRootPart.Position, u26);
    BodyGyro.Parent = HumanoidRootPart;
    local LinearVelocity = Instance.new("LinearVelocity");
    LinearVelocity.ForceLimitMode = Enum.ForceLimitMode.PerAxis;
    LinearVelocity.MaxAxesForce = Vector3.new(40000, 0, 40000);
    LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
    LinearVelocity.Parent = HumanoidRootPart;
    u8.AC:Add(LinearVelocity);
    u8.AC:Add(BodyGyro);

    local function endAll() -- Line: 234
        -- upvalues: u24 (copy), u8 (copy), u4 (ref), Shiftlock (copy)
        u24:Stop(0.5);
        u8.AC:Clean();
        u4.States.Ability = false;

        if not u8.CameraController.Shiftlock then
            u8.CameraController:SetShiftlock(Shiftlock);
        end;
    end;

    u8.AC:Connect(RunService.Heartbeat, function(p28) -- Line: 243
        -- upvalues: u6 (ref), Unit (ref), Value (copy), HumanoidRootPart (copy), BodyGyro (copy), u26 (ref), u25 (ref), TweenService (ref), u27 (ref), LinearVelocity (copy), u24 (copy), u8 (copy), u4 (ref), Shiftlock (copy)
        local ServerBallPosition2 = u6:GetServerBallPosition();
        Unit = (ServerBallPosition2 + Value.AssemblyLinearVelocity / 6 - HumanoidRootPart.Position).Unit;
        BodyGyro.CFrame = CFrame.lookAt(HumanoidRootPart.Position, u26);
        u26 = ServerBallPosition2;
        u25 = u25 - p28 * TweenService:GetValue(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out) * 25;
        u27 = u25 * Vector3.new(1, 0, 1);
        HumanoidRootPart.CFrame = CFrame.new(HumanoidRootPart.Position, (Vector3.new(u26.X, HumanoidRootPart.Position.Y, u26.Z)));
        LinearVelocity.VectorVelocity = Unit * u27;

        if (HumanoidRootPart.Position - ServerBallPosition2).Magnitude < 15 then
            u24:Stop(0.5);
            u8.AC:Clean();
            u4.States.Ability = false;

            if not u8.CameraController.Shiftlock then
                u8.CameraController:SetShiftlock(Shiftlock);
            end;
        end;
    end);
    u8.AC:Connect(ReplicatedStorage.Controllers.NewData:GetPropertyChangedSignal("Value"), function() -- Line: 261
        -- upvalues: u1 (ref), u24 (copy), u8 (copy), u4 (ref), Shiftlock (copy)
        if u1.CharValues.HasBall then
            u24:Stop(0.5);
            u8.AC:Clean();
            u4.States.Ability = false;

            if not u8.CameraController.Shiftlock then
                u8.CameraController:SetShiftlock(Shiftlock);
            end;
        end;
    end);
    u8.AC:Add(task.delay(0.7407407407407407, endAll));
end;