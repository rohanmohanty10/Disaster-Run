 
 

local RunService = game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
local LocalPlayer = Players.LocalPlayer;
local workspace_CurrentCamera = workspace.CurrentCamera;
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
require("../../Abilities");
local u7 = require("../../../../Shared/Tables/Cooldowns");
local u8 = require("@game/ReplicatedStorage/Shared/Utility/Effects");
local u9 = require("@game/ReplicatedStorage/Shared/Utility/CameraShaker");
local u10 = require("@game/ReplicatedStorage/Shared/Functions/CalculateBallTrajectory");
local RaycastParams_new_ret = RaycastParams.new();
RaycastParams_new_ret.IncludeInstances = { workspace.Barriers };

return function(u11) -- Line: 35
    -- upvalues: LocalPlayer (copy), u5 (ref), u2 (ref), u3 (ref), u1 (ref), u4 (ref), u6 (ref), ReplicatedStorage (copy), u8 (copy), TweenService (copy), workspace_CurrentCamera (copy), u9 (copy), RunService (copy), RaycastParams_new_ret (copy), u10 (copy), u7 (copy)
    local HumanoidRootPart = LocalPlayer.Character.HumanoidRootPart;
    u5 = u11.BallController;
    u2 = u11.AbilityService;
    u3 = u11.Animations;
    u1 = u11.MovementController;
    u4 = u11.Network;
    u6 = u11.CameraController;

    if u4.CharValues.HasBall ~= true then
        local ServerBallPosition = u5:GetServerBallPosition();
        local CharacterPossessingBall = u5:GetCharacterPossessingBall();
        local LastPlayerToPossessBall = u5:GetLastPlayerToPossessBall();

        if ReplicatedStorage.Cooldowns.NinjaBlockCD.Value > workspace:GetServerTimeNow() then
            local v12 = ReplicatedStorage.Cooldowns.NinjaBlockCD.Value - workspace:GetServerTimeNow();
            local math_abs_ret = math.abs(v12);
            u8:Popup(`Ability on global cooldown! Ready in {math.ceil(math_abs_ret)} seconds`, 2);
            u11:ResetCD(1);

            return;
        end;

        if not LastPlayerToPossessBall or LastPlayerToPossessBall.Team == LocalPlayer.Team then
            u8:Popup("Ball must have been shot by an enemy player!");

            return u11:ResetCD(1);
        end;

        if CharacterPossessingBall then
            u8:Popup("The ball must not be on a player!");

            return u11:ResetCD(1);
        end;

        if (HumanoidRootPart.Position - ServerBallPosition).Magnitude >= 50 then
            u8:Popup("The ball is too far away!");

            return u11:ResetCD(1);
        end;

        local LastPlayerToPossessBall2 = u5:GetLastPlayerToPossessBall();

        if LastPlayerToPossessBall2 then
            LastPlayerToPossessBall2 = LastPlayerToPossessBall2.Character;
        end;

        if LastPlayerToPossessBall2 and (LastPlayerToPossessBall2:GetAttribute("Unblockable") and LastPlayerToPossessBall2:GetAttribute("Unblockable") > workspace:GetServerTimeNow()) then
            u8:Popup("Can\'t block shot!");
            u11:ResetCD(1);

            return;
        end;

        if ServerBallPosition.Y > 37.5 then
            u8:Popup("The ball is too high!");

            return u11:ResetCD(1);
        end;

        u3:StopAll();
        local v13 = u3:PlayChar("Ninja", "BlockShot", Enum.AnimationPriority.Action3, true);
        local v14 = u3:PlayBall("Ninja", "BlockShotBall", Enum.AnimationPriority.Action4, true);
        u11.AC:Add(v13, "Stop");
        u11.AC:Add(v14, "Stop");
        u1.States.Ability = true;
        u1.States.NoWalk = true;
        u11.AC:Add(function() -- Line: 96
            -- upvalues: u1 (ref)
            u1.States.Ability = false;
            u1.States.NoWalk = false;
        end);
        HumanoidRootPart.CFrame = CFrame.new(HumanoidRootPart.Position, (Vector3.new(ServerBallPosition.X, HumanoidRootPart.Position.Y, ServerBallPosition.Z)));
        u11.AC:Add(task.delay(1.2833333333333334, function() -- Line: 103
            -- upvalues: u11 (copy)
            u11.AC:Clean();
        end));
        u2.Ability:Fire("CloneBlitz", {
            Steal = true,
            TimeSent = workspace:GetServerTimeNow()
        });
        u11.AC:Add(TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            FieldOfView = 30
        }), "Cancel"):Play();
        u11.AC:Add(task.delay(0.36666666666666664, function() -- Line: 111
            -- upvalues: u6 (ref), u9 (ref), u11 (copy), TweenService (ref), workspace_CurrentCamera (ref)
            u6.CamShake:Shake(u9.Presets.Dunk);
            u11.AC:Add(TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                FieldOfView = 90
            }), "Cancel"):Play();
            u11.AC:Add(task.delay(0.2, function() -- Line: 115
                -- upvalues: u11 (ref), TweenService (ref), workspace_CurrentCamera (ref)
                u11.AC:Add(TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    FieldOfView = 70
                }), "Cancel"):Play();
            end));
        end));

        return;
    end;

    u1.States.Ability = true;
    u11.AC:Add(function() -- Line: 125
        -- upvalues: u1 (ref)
        u1.States.Ability = false;
        u1.States.NoWalk = false;
    end);

    if u11.CloneBlitz ~= true then
        u11.AC:Add(task.delay(1.5, function() -- Line: 266
            -- upvalues: u11 (copy), u4 (ref), LocalPlayer (ref), u7 (ref), RunService (ref)
            u11.AC:Clean();

            if u4.CharValues.Inside == false then
                return;
            end;

            local v15 = u11:HoopDist();

            if v15 <= 10 or v15 > 130 then
                return;
            end;

            u11.CloneBlitz = true;
            u11:ResetCD(1);
            local u16 = 1;
            local u17 = false;
            local u18 = nil;
            local u19 = false;

            local function endAll() -- Line: 286
                -- upvalues: u19 (ref), u11 (ref), LocalPlayer (ref), u7 (ref), u18 (ref)
                if u19 == true then
                    return;
                end;

                u19 = true;
                u11:ResetCopy();

                if not (workspace:GetAttribute("NoAbilityCooldowns") or (LocalPlayer:GetAttribute("NoAbilityCooldowns") or LocalPlayer.Style.Value == "Copycat" and LocalPlayer:GetAttribute("TrueCopycat")) or LocalPlayer.Style.Value == "Thief" and u11.TotalTheft) then
                    u11.CDS[1] = tick() + u7.Abilities.Ninja[1];
                end;

                u18:Disconnect();
                u11.CloneBlitz = nil;
                LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = 1;
            end;

            u18 = RunService.Heartbeat:Connect(function(p20) -- Line: 300
                -- upvalues: u11 (ref), endAll (copy), u4 (ref), LocalPlayer (ref), u16 (ref), u17 (ref)
                if u11.CloneBlitz == nil then
                    endAll();

                    return;
                end;

                if u4.CharValues.HasBall ~= true then
                    endAll();

                    return;
                end;

                local v21 = u11:HoopDist();

                if v21 > 130 then
                    endAll();

                    return;
                end;

                if u4.CharValues.Inside == false then
                    endAll();

                    return;
                end;

                if v21 <= 10 then
                    endAll();

                    return;
                end;

                LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = u16;

                if u16 > 0.5 and not u17 then
                    p20 = -p20 or p20;
                end;

                u16 = u16 + p20;

                if u16 <= 0.5 then
                    u17 = true;
                end;

                if u16 >= 1 then
                    u17 = false;
                end;

                LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "Ninja Step";
            end);
            task.delay(3, function() -- Line: 322
                -- upvalues: endAll (copy)
                endAll();
            end);
        end));
        u3:StopAll();
        u3:PlayChar("Ninja", "Ability1", Enum.AnimationPriority.Action3);
        u3:PlayBall("Ninja", "Ability1Ball", Enum.AnimationPriority.Action4);
        local LinearVelocity = Instance.new("LinearVelocity");
        LinearVelocity.MaxForce = (1 / 0);
        LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
        LinearVelocity.Parent = HumanoidRootPart;
        LinearVelocity.VelocityConstraintMode = Enum.VelocityConstraintMode.Plane;
        LinearVelocity.RelativeTo = Enum.ActuatorRelativeTo.World;
        LinearVelocity.PrimaryTangentAxis = Vector3.new(1, 0, 0);
        LinearVelocity.SecondaryTangentAxis = Vector3.new(0, 0, 1);
        u11.AC:Add(LinearVelocity);
        local BodyGyro = Instance.new("BodyGyro");
        BodyGyro.Name = "GyroBasketball";
        BodyGyro.MaxTorque = Vector3.new(9000000000, 9000000000, 9000000000);
        BodyGyro.CFrame = HumanoidRootPart.CFrame;
        BodyGyro.P = 1250;
        BodyGyro.Parent = HumanoidRootPart;
        u11.AC:Add(BodyGyro);
        u2.Ability:Fire("CloneBlitz", {
            TimeSent = workspace:GetServerTimeNow()
        });
        u6.CamShake:Shake(u9.Presets.Bump);
        u11.AC:Add(TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            FieldOfView = 90
        }), "Cancel"):Play();
        local u22 = u11.AC:Add(Instance.new("NumberValue"));
        u22.Value = 80;
        TweenService:Create(u22, TweenInfo.new(0.3333333333333333, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Value = 50
        }):Play();
        u11.AC:Add(task.delay(1.1666666666666667, function() -- Line: 361
            -- upvalues: TweenService (ref), u22 (copy)
            TweenService:Create(u22, TweenInfo.new(0.3333333333333333, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
                Value = 20
            }):Play();
        end));
        u11.AC:Add(RunService.PreSimulation:Connect(function(p23: number) -- Line: 367
            -- upvalues: HumanoidRootPart (copy), BodyGyro (copy), LinearVelocity (copy), u22 (copy)
            local CFrame2 = HumanoidRootPart.CFrame;
            BodyGyro.CFrame = CFrame2;
            local LookVector = CFrame2.LookVector;
            LinearVelocity.PlaneVelocity = Vector2.new(LookVector.X, LookVector.Z) * u22.Value;
        end));

        return;
    end;

    u11.CloneBlitz = nil;
    u1.States.NoWalk = true;
    u11.AC:Add(task.delay(1.0333333333333334, function() -- Line: 134
        -- upvalues: u11 (copy)
        u11.AC:Clean();
    end));
    u2.Ability:Fire("CloneBlitz", {
        Shoot = true,
        TimeSent = workspace:GetServerTimeNow()
    });
    u11.AC:Add(TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.6666666666666666, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        FieldOfView = 45
    }), "Cancel"):Play();
    local Position = workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position;
    HumanoidRootPart.CFrame = CFrame.lookAt(HumanoidRootPart.Position, (Vector3.new(Position.X, HumanoidRootPart.Position.Y, Position.Z)));
    local RightVector = HumanoidRootPart.CFrame.RightVector;
    local LookVector = HumanoidRootPart.CFrame.LookVector;
    local Vector2_new_ret = Vector2.new(RightVector.X, RightVector.Z);
    local Vector2_new_ret2 = Vector2.new(LookVector.X, LookVector.Z);
    u3:StopAll();
    u3:PlayChar("Ninja", "Fadeaway", Enum.AnimationPriority.Action3, true);
    u3:PlayBall("Ninja", "FadeawayBall", Enum.AnimationPriority.Action4, true);
    local LinearVelocity = Instance.new("LinearVelocity");
    LinearVelocity.MaxForce = (1 / 0);
    LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
    LinearVelocity.Parent = HumanoidRootPart;
    LinearVelocity.VelocityConstraintMode = Enum.VelocityConstraintMode.Plane;
    LinearVelocity.RelativeTo = Enum.ActuatorRelativeTo.World;
    LinearVelocity.PrimaryTangentAxis = Vector3.new(1, 0, 0);
    LinearVelocity.SecondaryTangentAxis = Vector3.new(0, 0, 1);
    u11.AC:Add(LinearVelocity);
    local BodyGyro = Instance.new("BodyGyro");
    BodyGyro.Name = "GyroBasketball";
    BodyGyro.MaxTorque = Vector3.new(9000000000, 9000000000, 9000000000);
    BodyGyro.CFrame = HumanoidRootPart.CFrame;
    BodyGyro.P = 1250;
    BodyGyro.Parent = HumanoidRootPart;
    u11.AC:Add(BodyGyro);
    local u24 = u11.AC:Add(Instance.new("NumberValue"));
    u24.Value = -80;
    local u25 = u11.AC:Add(Instance.new("NumberValue"));
    u25.Value = -120;
    TweenService:Create(u24, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
        Value = 20
    }):Play();
    TweenService:Create(u25, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
        Value = -20
    }):Play();
    u11.AC:Add(task.delay(0.25, function() -- Line: 189
        -- upvalues: u6 (ref), u9 (ref), u24 (copy), u25 (copy), TweenService (ref), u11 (copy), HumanoidRootPart (copy)
        u6.CamShake:Shake(u9.Presets.Bump);
        u24.Value = 80;
        u25.Value = -120;
        TweenService:Create(u24, TweenInfo.new(0.21666666666666667, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
            Value = -20
        }):Play();
        TweenService:Create(u25, TweenInfo.new(0.21666666666666667, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
            Value = -20
        }):Play();
        u11.AC:Add(task.delay(0.21666666666666667, function() -- Line: 201
            -- upvalues: u6 (ref), u9 (ref), u24 (ref), u25 (ref), TweenService (ref), u11 (ref), HumanoidRootPart (ref)
            u6.CamShake:Shake(u9.Presets.Bump);
            u24.Value = -135;
            u25.Value = -7;
            TweenService:Create(u24, TweenInfo.new(0.21666666666666667, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                Value = 0
            }):Play();
            u11.AC:Add(task.delay(0.16666666666666666, function() -- Line: 209
                -- upvalues: u24 (ref), HumanoidRootPart (ref), u25 (ref)
                u24.Value = 0;
                local v26 = HumanoidRootPart;
                v26.AssemblyLinearVelocity = v26.AssemblyLinearVelocity + Vector3.new(0, 32.5, 0);
                u25.Value = -66;
            end));
        end));
    end));

    local function GetVectorVelocity() -- Line: 217
        -- upvalues: u24 (copy), u25 (copy), Vector2_new_ret (copy), Vector2_new_ret2 (copy)
        local v27 = u24 ~= nil and u24.Value or 0;
        local v28 = u25 == nil and 0 or (u25.Value or 0);
        local Vector2_zero = Vector2.zero;

        if v27 ~= 0 then
            Vector2_zero = Vector2_zero + Vector2_new_ret * v27;
        end;

        if v28 ~= 0 then
            Vector2_zero = Vector2_zero + Vector2_new_ret2 * v28;
        end;

        return Vector2_zero;
    end;

    u11.AC:Add(RunService.Heartbeat:Connect(function(p29) -- Line: 234
        -- upvalues: LinearVelocity (copy), u24 (copy), u25 (copy), Vector2_new_ret (copy), Vector2_new_ret2 (copy), HumanoidRootPart (copy), RaycastParams_new_ret (ref)
        if LinearVelocity.Enabled == false then
            return;
        end;

        local v30 = u24 ~= nil and u24.Value or 0;
        local v31 = u25 == nil and 0 or (u25.Value or 0);
        local Vector2_zero = Vector2.zero;

        if v30 ~= 0 then
            Vector2_zero = Vector2_zero + Vector2_new_ret * v30;
        end;

        if v31 ~= 0 then
            Vector2_zero = Vector2_zero + Vector2_new_ret2 * v31;
        end;

        local v32 = workspace:Raycast(HumanoidRootPart.Position, Vector3.new(Vector2_zero.X, 0, Vector2_zero.Y).Unit, RaycastParams_new_ret);

        if v32 and v32.Instance then
            LinearVelocity.PlaneVelocity = Vector2.zero;

            return;
        end;

        LinearVelocity.PlaneVelocity = Vector2_zero;
    end));
    u11.AC:Add(u2.Ability:Connect(function(p33) -- Line: 250
        -- upvalues: u6 (ref), u9 (ref), u11 (copy), TweenService (ref), workspace_CurrentCamera (ref), ReplicatedStorage (ref), u10 (ref), Position (copy)
        u6.CamShake:Shake(u9.Presets.Ankle);
        u11.AC:Add(TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.08333333333333333, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            FieldOfView = 90
        }), "Cancel"):Play();
        local Value = ReplicatedStorage.Basketball.Value;
        Value.AssemblyLinearVelocity = u10(Value.Position, Position, 80);
    end));
    u11.AC:Add(HumanoidRootPart.ChildAdded:Connect(function(p34) -- Line: 258
        -- upvalues: LinearVelocity (copy)
        if p34:IsA("AlignPosition") then
            LinearVelocity.Enabled = false;
        end;
    end));
end;