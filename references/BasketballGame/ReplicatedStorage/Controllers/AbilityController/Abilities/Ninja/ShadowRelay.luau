 
 

local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local LocalPlayer = Players.LocalPlayer;
local workspace_CurrentCamera = workspace.CurrentCamera;
require("../../Abilities");
local u1 = require("../../../../Shared/Tables/Cooldowns");
local u2 = require("@game/ReplicatedStorage/Shared/Utility/CameraShaker");
local u3 = require("@game/ReplicatedStorage/Shared/Utility/Effects");
local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = nil;
local u8 = nil;
local u9 = require("@self/ShadowLaunch");
local u10 = require("@self/OtherVariant");

local function ClampAim(p11, p12, p13: number) -- Line: 33
    local v14 = p11.X * p12.Y - p11.Y * p12.X;
    local v15 = p11:Dot(p12);
    local math_atan2_ret = math.atan2(v14, v15);
    local math_clamp_ret = math.clamp(math_atan2_ret, -p13, p13);
    local math_cos_ret = math.cos(math_clamp_ret);
    local math_sin_ret = math.sin(math_clamp_ret);

    return Vector2.new(p11.X * math_cos_ret - p11.Y * math_sin_ret, p11.X * math_sin_ret + p11.Y * math_cos_ret);
end;

return function(u16) -- Line: 39
    -- upvalues: LocalPlayer (copy), u5 (ref), u6 (ref), u4 (ref), u7 (ref), u8 (ref), u3 (copy), u2 (copy), TweenService (copy), workspace_CurrentCamera (copy), RunService (copy), u10 (copy), u9 (copy), u1 (copy), ClampAim (copy)
    if u16.NinjaTransform == true then
        return;
    end;

    local Character = LocalPlayer.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local Humanoid = Character.Humanoid;
    u5 = u16.AbilityService;
    u6 = u16.Animations;
    u4 = u16.MovementController;
    u7 = u16.Network;
    u8 = u16.CameraController;

    if u7.CharValues.HasBall == true then
        u4.States.Ability = true;
        u4.States.NoWalk = true;
        u16.AC:Add(function() -- Line: 159
            -- upvalues: u4 (ref)
            u4.States.Ability = false;
            u4.States.NoWalk = false;
        end);

        if u16.NinjaAbility2 == true then
            u16.NinjaAbility2 = nil;

            if u16:HoopDist() <= 110 and u7.CharValues.Inside == false then
                u10(u16);

                return;
            end;

            u9(u16);

            return;
        end;

        u16.AC:Add(task.delay(1.55, function() -- Line: 173
            -- upvalues: u16 (copy), LocalPlayer (ref), u1 (ref), RunService (ref), u7 (ref)
            u16.AC:Clean();
            local v17 = u16:HoopDist();

            if v17 > 110 then
                return;
            end;

            if v17 <= 10 then
                return;
            end;

            local u18 = LocalPlayer.Style.Value == "Copycat" and true or LocalPlayer.Style.Value == "Thief";
            u16.NinjaAbility2 = true;
            u16:ResetCD(u18 and 1 or 2);
            local u19 = 1;
            local u20 = false;
            local u21 = nil;
            local u22 = false;
            local u23 = u18 and LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1 or LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2;

            local function endAll() -- Line: 193
                -- upvalues: u22 (ref), u16 (ref), LocalPlayer (ref), u18 (copy), u1 (ref), u21 (ref), u23 (copy)
                if u22 == true then
                    return;
                end;

                u22 = true;
                u16:ResetCopy();

                if not (workspace:GetAttribute("NoAbilityCooldowns") or (LocalPlayer:GetAttribute("NoAbilityCooldowns") or LocalPlayer.Style.Value == "Copycat" and LocalPlayer:GetAttribute("TrueCopycat")) or LocalPlayer.Style.Value == "Thief" and u16.TotalTheft) then
                    u16.CDS[u18 and 1 or 2] = tick() + u1.Abilities.Ninja[2];
                end;

                u21:Disconnect();
                u16.NinjaAbility2 = nil;
                u23.Flash.BackgroundTransparency = 1;
            end;

            u21 = RunService.Heartbeat:Connect(function(p24) -- Line: 207
                -- upvalues: u16 (ref), endAll (copy), u7 (ref), u23 (copy), u19 (ref), u20 (ref)
                if u16.NinjaAbility2 == nil then
                    endAll();

                    return;
                end;

                if u7.CharValues.HasBall ~= true then
                    endAll();

                    return;
                end;

                local v25 = u16:HoopDist();

                if v25 > 110 then
                    endAll();

                    return;
                end;

                if v25 <= 10 then
                    endAll();

                    return;
                end;

                u23.Flash.BackgroundTransparency = u19;

                if u19 > 0.5 and not u20 then
                    p24 = -p24 or p24;
                end;

                u19 = u19 + p24;

                if u19 <= 0.5 then
                    u20 = true;
                end;

                if u19 >= 1 then
                    u20 = false;
                end;

                if u7.CharValues.Inside == false then
                    u23.AbilityName.Text = "Ninja Fade";

                    return;
                end;

                u23.AbilityName.Text = "Shadow Launch";
            end);
            task.delay(3, function() -- Line: 226
                -- upvalues: endAll (copy)
                endAll();
            end);
        end));
        u6:StopAll();
        local v26 = u6:PlayChar("Ninja", "Ability2", Enum.AnimationPriority.Action3, true);
        local v27 = u6:PlayBall("Ninja", "Ability2Ball", Enum.AnimationPriority.Action4, true);
        u16.AC:Add(v26, "Stop");
        u16.AC:Add(v27, "Stop");
        u5.Ability:Fire("ShadowRelay", {
            TimeSent = workspace:GetServerTimeNow()
        });
        u16.AC:Add(TweenService:Create(workspace_CurrentCamera, TweenInfo.new(1.1), {
            FieldOfView = 40
        }), "Cancel"):Play();
        local LinearVelocity = Instance.new("LinearVelocity");
        LinearVelocity.MaxForce = (1 / 0);
        LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
        LinearVelocity.Parent = HumanoidRootPart;
        LinearVelocity.VelocityConstraintMode = Enum.VelocityConstraintMode.Plane;
        LinearVelocity.RelativeTo = Enum.ActuatorRelativeTo.World;
        LinearVelocity.PrimaryTangentAxis = Vector3.new(1, 0, 0);
        LinearVelocity.SecondaryTangentAxis = Vector3.new(0, 0, 1);
        u16.AC:Add(LinearVelocity);
        local BodyGyro = Instance.new("BodyGyro");
        BodyGyro.Name = "GyroBasketball";
        BodyGyro.MaxTorque = Vector3.new(9000000000, 9000000000, 9000000000);
        BodyGyro.CFrame = HumanoidRootPart.CFrame;
        BodyGyro.P = 1250;
        BodyGyro.Parent = HumanoidRootPart;
        u16.AC:Add(BodyGyro);
        local LookVector = HumanoidRootPart.CFrame.LookVector;
        local Vector2_new_ret = Vector2.new(LookVector.X, LookVector.Z);
        local u28 = Vector2_new_ret;
        LinearVelocity.PlaneVelocity = Vector2_new_ret * 50;
        TweenService:Create(LinearVelocity, TweenInfo.new(0.55, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
            PlaneVelocity = Vector2_new_ret * 20
        }):Play();
        u16.AC:Add(task.delay(0.55, function() -- Line: 270
            -- upvalues: LinearVelocity (copy), BodyGyro (copy), u16 (copy), RunService (ref), Humanoid (copy), Vector2_new_ret (copy), ClampAim (ref), HumanoidRootPart (copy), u28 (ref), u8 (ref), u2 (ref), TweenService (ref), workspace_CurrentCamera (ref), u4 (ref)
            LinearVelocity.Enabled = false;
            BodyGyro.P = 20000;
            BodyGyro.D = 1000;
            local u31 = u16.AC:Add(RunService.PreSimulation:Connect(function(p29: number) -- Line: 276
                -- upvalues: Humanoid (ref), Vector2_new_ret (ref), ClampAim (ref), BodyGyro (ref), HumanoidRootPart (ref)
                local MoveDirection = Humanoid.MoveDirection;
                local Vector2_new_ret2 = Vector2.new(MoveDirection.X, MoveDirection.Z);

                if Vector2_new_ret2.Magnitude < 0.001 or Vector2_new_ret:Dot(Vector2_new_ret2.Unit) < -0.9 then
                    return;
                end;

                local v30 = ClampAim(Vector2_new_ret, Vector2_new_ret2.Unit, 0.7853981633974483);
                BodyGyro.CFrame = CFrame.lookAt(HumanoidRootPart.Position, HumanoidRootPart.Position + Vector3.new(v30.X, 0, v30.Y));
            end));
            u16.AC:Add(task.delay(0.2, function() -- Line: 286
                -- upvalues: u31 (copy), HumanoidRootPart (ref), u28 (ref), BodyGyro (ref)
                u31:Disconnect();
                local LookVector2 = HumanoidRootPart.CFrame.LookVector;
                u28 = Vector2.new(LookVector2.X, LookVector2.Z).Unit;
                BodyGyro.CFrame = HumanoidRootPart.CFrame;
            end));
            u16.AC:Add(task.delay(0.55, function() -- Line: 293
                -- upvalues: u8 (ref), u2 (ref), u16 (ref), TweenService (ref), workspace_CurrentCamera (ref), LinearVelocity (ref), u28 (ref), u4 (ref)
                u8.CamShake:Shake(u2.Presets.Dunk);
                u16.AC:Add(TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.3), {
                    FieldOfView = 100
                }), "Cancel"):Play();
                LinearVelocity.PlaneVelocity = u28 * 250;
                LinearVelocity.Enabled = true;
                TweenService:Create(LinearVelocity, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.InOut), {
                    PlaneVelocity = u28 * 35
                }):Play();
                u16.AC:Add(task.delay(0.3, function() -- Line: 304
                    -- upvalues: u4 (ref), LinearVelocity (ref), u16 (ref), TweenService (ref), workspace_CurrentCamera (ref)
                    u4.States.NoWalk = false;
                    LinearVelocity.Enabled = false;
                    u16.AC:Add(TweenService:Create(workspace_CurrentCamera, TweenInfo.new(1), {
                        FieldOfView = 70
                    }), "Cancel"):Play();
                end));
            end));
        end));

        return;
    end;

    u4.States.Ability = true;
    u4.States.NoWalk = false;

    if u16.TailDribble == true then
        u3:Popup("You can\'t do this right now!", 4);
        u4.States.Ability = false;
        u4.States.NoWalk = false;

        return u16:ResetCD(2);
    end;

    u5.Ability:Fire("ShadowRelay", {
        Run = true,
        TimeSent = workspace:GetServerTimeNow()
    });
    u8.CamShake:Shake(u2.Presets.Bump);
    u16.AC:Add(TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        FieldOfView = 90
    }), "Cancel"):Play();
    u6:StopAll();
    local v32 = u6:PlayChar("Ninja", "NinjaRun", Enum.AnimationPriority.Action3, true);
    u16.AC:Add(v32, "Stop");
    local LinearVelocity = Instance.new("LinearVelocity");
    LinearVelocity.MaxForce = (1 / 0);
    LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
    LinearVelocity.Parent = HumanoidRootPart;
    LinearVelocity.VelocityConstraintMode = Enum.VelocityConstraintMode.Plane;
    LinearVelocity.RelativeTo = Enum.ActuatorRelativeTo.World;
    LinearVelocity.PrimaryTangentAxis = Vector3.new(1, 0, 0);
    LinearVelocity.SecondaryTangentAxis = Vector3.new(0, 0, 1);
    u16.AC:Add(LinearVelocity);
    local BodyGyro = Instance.new("BodyGyro");
    BodyGyro.Name = "GyroBasketball";
    BodyGyro.MaxTorque = Vector3.new(9000000000, 9000000000, 9000000000);
    BodyGyro.CFrame = HumanoidRootPart.CFrame;
    BodyGyro.P = 1250;
    BodyGyro.Parent = HumanoidRootPart;
    u16.AC:Add(BodyGyro);
    u4.ExtraBoosts.NinjaRun = 10;
    u16.AC:Add(function() -- Line: 94
        -- upvalues: u4 (ref)
        u4.ExtraBoosts.NinjaRun = nil;
    end);
    local AssemblyLinearVelocity = HumanoidRootPart.AssemblyLinearVelocity;
    local u33 = u16.AC:Add(Instance.new("NumberValue"));
    local Magnitude = Vector2.new(AssemblyLinearVelocity.X, AssemblyLinearVelocity.Z).Magnitude;
    u33.Value = math.min(Magnitude, 50);
    TweenService:Create(u33, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        Value = 50
    }):Play();
    u16.AC:Add(task.delay(1.75, function() -- Line: 106
        -- upvalues: TweenService (ref), u33 (copy), Humanoid (copy)
        TweenService:Create(u33, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
            Value = Humanoid.WalkSpeed
        }):Play();
    end));
    u16.AC:Add(RunService.RenderStepped:Connect(function(p34: number) -- Line: 112
        -- upvalues: HumanoidRootPart (copy), BodyGyro (copy), LinearVelocity (copy), u33 (copy)
        local CFrame2 = HumanoidRootPart.CFrame;
        BodyGyro.CFrame = CFrame2;
        local LookVector = CFrame2.LookVector;
        LinearVelocity.PlaneVelocity = Vector2.new(LookVector.X, LookVector.Z) * u33.Value;
    end));
    u16.AC:Add(task.delay(2, function() -- Line: 121
        -- upvalues: u16 (copy), u4 (ref), RunService (ref), u7 (ref)
        u16.AC:Clean();
        u4.States.Ability = false;
        u16.NinjaRun = true;
        local u35 = tick();
        u4.ExtraBoosts.NinjaRun = 10;
        local u36 = nil;
        u36 = RunService.Heartbeat:Connect(function() -- Line: 130
            -- upvalues: u35 (copy), u36 (ref), u4 (ref), u16 (ref), u7 (ref)
            if tick() - u35 >= 35 then
                u36:Disconnect();
                u36 = nil;
                u4.ExtraBoosts.NinjaRun = nil;
                u16.NinjaRun = nil;

                return;
            end;

            if u7.CharValues.HasBall then
                u4.ExtraBoosts.NinjaRun = nil;
            else
                u4.ExtraBoosts.NinjaRun = 10;
            end;

            if u16.Network.CharValues.InAwakening ~= true then
                return;
            end;

            u36:Disconnect();
            u36 = nil;
            u4.ExtraBoosts.NinjaRun = nil;
            u16.NinjaRun = nil;
        end);
    end));
end;