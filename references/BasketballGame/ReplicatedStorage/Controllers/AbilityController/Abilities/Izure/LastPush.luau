 
 

game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
local CameraShaker = require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
require(ReplicatedStorage.Shared.Utility.Essentials);
local _ = require(ReplicatedStorage.Shared.Tables.Cooldowns).Abilities;
require(ReplicatedStorage.Shared.Tables.Zones);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local LocalPlayer = game.Players.LocalPlayer;
local workspace_CurrentCamera = workspace.CurrentCamera;

return function(u7) -- Line: 23
    -- upvalues: LocalPlayer (copy), u1 (ref), u2 (ref), u3 (ref), u4 (ref), u5 (ref), u6 (ref), Effects (copy), TweenService (copy), workspace_CurrentCamera (copy), CameraShaker (copy), ReplicatedStorage (copy), RunService (copy)
    local Character = LocalPlayer.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local Humanoid = Character.Humanoid;
    u1 = u7.AbilityService;
    u2 = u7.Animations;
    u3 = u7.MovementController;
    u4 = u7.BallController;
    u5 = u7.CameraController;
    u6 = u7.Network;

    if u7.MovementController.States.PumpFake then
        u7:ResetCD(2);
        Effects:Popup("Can\'t use after a fake!");

        return;
    end;

    local Hoop = workspace.Hoops[LocalPlayer.Team.Name].Hoop;
    local Vector3_new_ret = Vector3.new(Hoop.Position.X, HumanoidRootPart.Position.Y, Hoop.Position.Z);

    if (HumanoidRootPart.Position - Vector3_new_ret).Magnitude > 85 then
        u1.Ability:Fire("Last Push", {
            State = "Counter Activate",
            TimeSent = workspace:GetServerTimeNow()
        });
        Effects:Popup("Special auto dribble for 3 seconds!");
        u3.Boost = 20;
        u7.AC:Add(function() -- Line: 144
            -- upvalues: u3 (ref), u1 (ref), u7 (copy)
            u3.Boost = 0;
            u1.Ability:Fire("Last Push", {
                State = "Counter Deactivate",
                TimeSent = workspace:GetServerTimeNow()
            });
            u7:ResetCopy();
        end);
        u7.AC:Add(task.delay(3, function() -- Line: 152
            -- upvalues: u7 (copy)
            u7.AC:Clean();
        end));
        u7.AC:Connect(RunService.Heartbeat, function() -- Line: 156
            -- upvalues: u4 (ref), LocalPlayer (ref), u7 (copy)
            if u4:GetPlayerPossessingBall() ~= LocalPlayer then
                u7.AC:Clean();
            end;
        end);
        local v8 = Humanoid.MoveDirection * Vector3.new(1, 0, 1);
        local u9;

        if v8.Magnitude > 0 then
            local v10 = HumanoidRootPart.CFrame:VectorToObjectSpace(v8);
            local v11 = v10.X > 0.01 and "R" or (v10.X < -0.01 and "L" or (v10.Z > 0.01 and "B" or "F"));
            u9 = Instance.new("LinearVelocity");
            u9.ForceLimitMode = Enum.ForceLimitMode.PerAxis;
            u9.MaxAxesForce = Vector3.new(20000, 0, 20000);
            u9.VectorVelocity = v8 * ((v11 == "R" or v11 == "L") and 60 or (v11 == "B" and 70 or (v11 == "F" and 50 or false)));
            u9.Attachment0 = HumanoidRootPart.RootAttachment;
            u9.Parent = HumanoidRootPart;
        else
            u9 = nil;
        end;

        task.delay(0.5, function() -- Line: 177
            -- upvalues: u3 (ref), u9 (ref)
            u3.Boost = 0;

            if u9 then
                u9:Destroy();
            end;
        end);
        u7.AC:Connect(u1.Ability, function(p12) -- Line: 185
            -- upvalues: u7 (copy), u3 (ref), HumanoidRootPart (copy), Vector3_new_ret (copy), u2 (ref), TweenService (ref)
            if not (p12 and p12.Other) then
                return;
            end;

            u7.AC:Clean();
            u3.States.Ability = true;
            u3.Boost = 20;
            u7.AC:Add(function() -- Line: 193
                -- upvalues: u3 (ref)
                u3.States.Ability = false;
                u3.Boost = 0;
            end);
            u7.AC:Add(task.delay(0.5, function() -- Line: 198
                -- upvalues: u7 (ref)
                u7.AC:Clean();
            end));
            local v13 = (HumanoidRootPart.Position - Vector3_new_ret).Magnitude > 0 and CFrame.new(HumanoidRootPart.Position, Vector3_new_ret):PointToObjectSpace(p12.Other.HumanoidRootPart.Position).X > 0 and "R" or "L";
            u2:StopAll();
            u2:PlayChar("Izure", `LastPush{v13}`, Enum.AnimationPriority.Action3);
            u2:PlayBall("Izure", `LastPush{v13}Ball`, Enum.AnimationPriority.Action3);
            local u14 = u7.AC:Add(Instance.new("LinearVelocity"));
            u14.ForceLimitMode = Enum.ForceLimitMode.PerAxis;
            u14.MaxAxesForce = Vector3.new(20000, 0, 20000);
            u14.Attachment0 = HumanoidRootPart.RootAttachment;
            u14.Parent = HumanoidRootPart;
            local _ = HumanoidRootPart.CFrame.LookVector;
            local u15 = p12.Other:FindFirstChild("HumanoidRootPart") and ((p12.Other.HumanoidRootPart.Position - HumanoidRootPart.Position).Magnitude > 0 and (p12.Other.HumanoidRootPart.Position - HumanoidRootPart.Position).Unit) or HumanoidRootPart.CFrame.LookVector;
            local u16 = u15:Cross(Vector3.new(0, 1, 0)) * (v13 == "R" and 1 or -1);
            u14.VectorVelocity = u15 * 5;
            TweenService:Create(u14, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                VectorVelocity = (u15 + u16) * 60
            }):Play();
            task.delay(0.2, function() -- Line: 222
                -- upvalues: TweenService (ref), u14 (copy), u15 (copy), u16 (copy), u3 (ref)
                TweenService:Create(u14, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
                    VectorVelocity = (u15 - u16) * 60
                }):Play();
                u3.Boost = 0;
            end);
        end);

        return;
    end;

    local v17 = u7:CheckInfront(25);

    if not v17 then
        u7:ResetCD(2);
        Effects:Popup("Someone must be infront of you!");

        return;
    end;

    u7:ResetCopy();
    u1.Ability:Fire("Last Push", {
        State = "Shoot",
        TimeSent = workspace:GetServerTimeNow(),
        Other = v17
    });
    local Shiftlock = u5.Shiftlock;
    u5:SetShiftlock(true);
    u3.States.Ability = true;
    u3.States.NoWalk = true;
    u3.States.AimAssist = true;
    u7.AC:Add(function() -- Line: 64
        -- upvalues: u3 (ref), u5 (ref), Shiftlock (copy)
        u3.States.Ability = false;
        u3.States.NoWalk = false;
        u3.States.AimAssist = false;
        u5:SetShiftlock(Shiftlock);
    end);
    u7.AC:Add(task.delay(1.5, function() -- Line: 72
        -- upvalues: u7 (copy)
        u7.AC:Clean();
    end));
    task.spawn(function() -- Line: 76
        -- upvalues: TweenService (ref), workspace_CurrentCamera (ref), u5 (ref), CameraShaker (ref)
        TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.8333333333333334), {
            FieldOfView = 40
        }):Play();
        task.wait(0.75);
        TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.2833333333333333), {
            FieldOfView = 100
        }):Play();
        task.wait(0.2833333333333333);
        TweenService:Create(workspace_CurrentCamera, TweenInfo.new(1), {
            FieldOfView = 70
        }):Play();
        u5.CamShake:Shake(CameraShaker.Presets.Ankle);
    end);
    u2:StopAll();
    u2:PlayChar("Izure", "LastPush", Enum.AnimationPriority.Action3, true);
    u2:PlayBall("Izure", "LastPushBall", Enum.AnimationPriority.Action3, true);
    local u18 = u7.AC:Add(Instance.new("LinearVelocity"));
    u18.MaxForce = (1 / 0);
    u18.Attachment0 = HumanoidRootPart.RootAttachment;
    u18.Parent = HumanoidRootPart;
    task.delay(0.4, function() -- Line: 94
        -- upvalues: u5 (ref), CameraShaker (ref), u18 (copy), HumanoidRootPart (copy), TweenService (ref)
        u5.CamShake:Shake(CameraShaker.Presets.Dunk);
        u18.VectorVelocity = HumanoidRootPart.CFrame.LookVector * 60;
        TweenService:Create(u18, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
            VectorVelocity = HumanoidRootPart.CFrame.LookVector * 5
        }):Play();
    end);
    task.delay(0.75, function() -- Line: 100
        -- upvalues: u18 (copy), HumanoidRootPart (copy), TweenService (ref)
        u18.VectorVelocity = -HumanoidRootPart.CFrame.LookVector * 120 + Vector3.new(0, 45, 0);
        TweenService:Create(u18, TweenInfo.new(0.2833333333333333, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
            VectorVelocity = -HumanoidRootPart.CFrame.LookVector * 30 + Vector3.new(0, -30, 0)
        }):Play();
    end);
    task.delay(1.0333333333333334, function() -- Line: 105
        -- upvalues: u18 (copy)
        u18:Destroy();
    end);
    task.wait(0.75);
    u7.AC:Connect(u1.Ability, function() -- Line: 111
        -- upvalues: ReplicatedStorage (ref), u4 (ref), Vector3_new_ret (copy), Hoop (copy), HumanoidRootPart (copy)
        local Value = ReplicatedStorage.Basketball.Value;
        local LastCharacterToPossessBall = u4:GetLastCharacterToPossessBall();
        Value.CFrame = CFrame.new(LastCharacterToPossessBall.PlrBall.Anims.BALL.Position, Vector3_new_ret);
        local _ = Value.Position;
        local v19 = Hoop.Position - Value.Position;
        local v20, v21;

        if (HumanoidRootPart.Position - Hoop.Position).Magnitude <= 30 then
            v20 = v19.Magnitude * 0.0455;
            v21 = 1.35;
        else
            v20 = v19.Magnitude * 0.04;
            v21 = 0.5;
        end;

        local math_log_ret = math.log(v21 + v20);
        Value.AssemblyLinearVelocity = v19 / math_log_ret + Vector3.new(0, workspace.Gravity * math_log_ret * 0.5, 0);
    end);
end;