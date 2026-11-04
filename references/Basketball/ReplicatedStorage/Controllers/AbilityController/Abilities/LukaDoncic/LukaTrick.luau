 
 

game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
require(ReplicatedStorage.Shared.Utility.Essentials);
local Abilities = require(ReplicatedStorage.Shared.Tables.Cooldowns).Abilities;
local Zones = require(ReplicatedStorage.Shared.Tables.Zones);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = nil;
local LocalPlayer = game.Players.LocalPlayer;
local workspace_CurrentCamera = workspace.CurrentCamera;

return function(u8) -- Line: 24
    -- upvalues: LocalPlayer (copy), u1 (ref), u2 (ref), u3 (ref), u4 (ref), u5 (ref), u6 (ref), u7 (ref), Zones (copy), RunService (copy), TweenService (copy), ReplicatedStorage (copy), workspace_CurrentCamera (copy), Effects (copy), Abilities (copy)
    local Character = LocalPlayer.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local Humanoid = Character.Humanoid;
    u1 = u8.BallService;
    u2 = u8.AbilityService;
    u3 = u8.MovementController;
    u4 = u8.BallController;
    u5 = u8.CameraController;
    u6 = u8.Animations;
    u7 = u8.Network;

    if not u8.LukaTrick then
        if u3.States.PumpFake then
            u8:ResetCD(2);
            Effects:Popup("Can\'t use after a fake!");

            return;
        end;

        u2.Ability:Fire("Luka Trick", {
            TimeSent = workspace:GetServerTimeNow()
        });
        u6:StopAll();
        local u9 = nil;

        if u7.CharValues.HasBall then
            u6:PlayChar("LukaDoncic", "LukaTrick", Enum.AnimationPriority.Action3);
            u6:PlayBall("LukaDoncic", "LukaTrickBall", Enum.AnimationPriority.Action3);
        else
            u9 = u6:PlayChar("LukaDoncic", "LukaTrickWithout", Enum.AnimationPriority.Action3, true);
        end;

        local u10 = 50;
        local LinearVelocity = Instance.new("LinearVelocity");
        LinearVelocity.ForceLimitMode = Enum.ForceLimitMode.PerAxis;
        LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
        LinearVelocity.MaxAxesForce = Vector3.new(inf, 0, inf);
        LinearVelocity.VectorVelocity = Vector3.new(0, 0, 0);
        LinearVelocity.Parent = HumanoidRootPart;
        u8.AC:Add(LinearVelocity);
        u8.AC:Connect(RunService.Heartbeat, function() -- Line: 228
            -- upvalues: u7 (ref), u9 (ref), u6 (ref), LinearVelocity (copy), HumanoidRootPart (copy), u10 (ref)
            if u7.CharValues.HasBall and u9 then
                local v11 = u6:PlayChar("LukaDoncic", "LukaTrick", Enum.AnimationPriority.Action3, true);
                local v12 = u6:PlayBall("LukaDoncic", "LukaTrickBall", Enum.AnimationPriority.Action3, true);
                v11.TimePosition = u9.TimePosition;
                v12.TimePosition = u9.TimePosition;
                u9:Stop(0);
                u9:Destroy();
                u9 = nil;
            end;

            LinearVelocity.VectorVelocity = HumanoidRootPart.CFrame.LookVector * Vector3.new(1, 0, 1) * u10;
        end);
        task.spawn(function() -- Line: 244
            -- upvalues: u10 (ref), LinearVelocity (copy)
            task.wait(0.45);
            u10 = 100;
            task.wait(0.2);
            u10 = 50;
            task.wait(0.4);

            if LinearVelocity then
                LinearVelocity:Destroy();
            end;
        end);
        u3.States.Ability = true;
        task.delay(1.05, function() -- Line: 257
            -- upvalues: u3 (ref)
            u3.States.Ability = false;
        end);
        u8.AC:Add(task.delay(1.05, function() -- Line: 261
            -- upvalues: u8 (copy), LocalPlayer (ref), RunService (ref), u7 (ref), Abilities (ref), Humanoid (copy)
            u8.LukaTrick = true;
            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = u8.LukaTrick == "Moved" and "Angle Stepback" or "Fake and Stepback";
            u8:ResetCD(4);
            local u13 = 1;
            local u14 = false;
            local u15 = nil;
            u15 = RunService.Heartbeat:Connect(function(p16) -- Line: 272
                -- upvalues: u8 (ref), u15 (ref), LocalPlayer (ref), u7 (ref), Abilities (ref), Humanoid (ref), u13 (ref), u14 (ref)
                if not u8.LukaTrick then
                    u15:Disconnect();
                    LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = 1;

                    return;
                end;

                if not u7.CharValues.HasBall then
                    u15:Disconnect();
                    u8.AC:Clean();
                    u8.CDS[4] = tick() + Abilities.LukaDoncic[4];
                    u8.LukaTrick = nil;
                    LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = 1;

                    return;
                end;

                if (Humanoid.MoveDirection * Vector3.new(1, 0, 1)).Magnitude > 0 then
                    u8.LukaTrick = "Moved";
                end;

                LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = u13;

                if u13 > 0.5 and not u14 then
                    p16 = -p16 or p16;
                end;

                u13 = u13 + p16;

                if u13 <= 0.5 then
                    u14 = true;
                end;

                if u13 >= 1 then
                    u14 = false;
                end;

                LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = u8.LukaTrick == "Moved" and "Angle Stepback" or "Fake and Stepback";
            end);
        end));

        return;
    end;

    local v17 = u8.LukaTrick ~= "Moved";
    u8.LukaTrick = nil;
    LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "Luka Trick";
    LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = 1;
    u2.Ability:Fire("Isolation", {
        Task = "Angle Stepback",
        TimeSent = workspace:GetServerTimeNow(),
        Fake = v17
    });
    local u18 = 1;

    if Zones.ZoneIncreasedShootingSpeed[LocalPlayer.Zone.Value] and u7.CharValues.InZone then
        u18 = u18 + 0.15;
    end;

    u3.States.Ability = true;
    u3.States.NoWalk = true;
    u3.States.AimAssist = true;

    if v17 then
        u1.Throw:Fire(nil, true);
        u6:StopAll();
        u6:PlayChar("Shots", "PumpFake", Enum.AnimationPriority.Action3);
        u6:PlayBall("Shots", "PumpFake", Enum.AnimationPriority.Action3);
        task.wait(1);
    end;

    local v19 = HumanoidRootPart.CFrame:VectorToObjectSpace(HumanoidRootPart.AssemblyLinearVelocity);
    local v20 = {};
    local math_clamp_ret = math.clamp(v19.X / Humanoid.WalkSpeed, 0.01, 1);
    v20.R = math.abs(math_clamp_ret);
    local math_clamp_ret2 = math.clamp(v19.X / Humanoid.WalkSpeed, -1, -0.01);
    v20.L = math.abs(math_clamp_ret2);
    local v21 = 0.1;
    local v22 = nil;

    for i, v in v20 do
        if v21 < v then
            v22 = i;
            v21 = v;
        end;
    end;

    local u23 = v22 or (math.random(1, 2) == 1 and "R" or "L");
    task.wait(0.1);
    RunService.Heartbeat:Wait();
    u8.AC:Clean();
    local Shiftlock = u5.Shiftlock;
    u5:SetShiftlock(true);
    u6:StopAll();
    local v24 = u6:PlayChar("LukaDoncic", `Stepback{u23}`, Enum.AnimationPriority.Action3, true);
    local v25 = u6:PlayBall("LukaDoncic", `Stepback{u23}Ball`, Enum.AnimationPriority.Action3, true);
    v24:AdjustSpeed(u18);
    v25:AdjustSpeed(u18);
    local LinearVelocity = Instance.new("LinearVelocity");
    LinearVelocity.MaxForce = (1 / 0);
    LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
    LinearVelocity.VectorVelocity = (-HumanoidRootPart.CFrame.LookVector + HumanoidRootPart.CFrame.RightVector * (u23 == "R" and 1 or -1)) * 60;
    LinearVelocity.Parent = HumanoidRootPart;
    TweenService:Create(LinearVelocity, TweenInfo.new(0.5 / u18, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        VectorVelocity = Vector3.new(0, 0, 0)
    }):Play();
    task.delay(0.5 / u18, function() -- Line: 108
        -- upvalues: LinearVelocity (copy)
        LinearVelocity:Destroy();
    end);
    task.delay(0.6666666666666666 / u18, function() -- Line: 112
        -- upvalues: HumanoidRootPart (copy), RunService (ref), u23 (ref), u18 (ref)
        local u26 = 33;
        local u27 = 0.65;
        local BodyVelocity = Instance.new("BodyVelocity");
        BodyVelocity.Name = "BodyVelocityBasketball";
        BodyVelocity.Parent = HumanoidRootPart;
        BodyVelocity.MaxForce = Vector3.new(inf, inf, inf);
        local u28 = tick();
        local u30 = RunService.Heartbeat:Connect(function(p29) -- Line: 123
            -- upvalues: u26 (ref), u28 (copy), BodyVelocity (copy), HumanoidRootPart (ref), u23 (ref), u27 (ref)
            if u26 >= 10 then
                if u28 + 0.125 < tick() then
                    BodyVelocity.Velocity = (HumanoidRootPart.CFrame.RightVector * (u23 == "R" and 1 or -1) + Vector3.new(0, u27, 0)) * u26;
                    u27 = u27 - p29 * 1.75;
                else
                    BodyVelocity.Velocity = HumanoidRootPart.CFrame.RightVector * (u23 == "R" and 1 or -1) * u26;
                end;

                u26 = u26 - p29;
            end;
        end);
        task.delay(0.5 / u18, function() -- Line: 135
            -- upvalues: u30 (ref), BodyVelocity (copy)
            if u30 then
                u30:Disconnect();
            end;

            BodyVelocity:Destroy();
        end);
    end);
    u8.AC:Connect(u2.Ability, function(p31) -- Line: 144
        -- upvalues: ReplicatedStorage (ref), Character (copy), HumanoidRootPart (copy), LocalPlayer (ref)
        if not (p31 and p31.Pos2) then
            return;
        end;

        local Pos2 = p31.Pos2;
        local Value = ReplicatedStorage.Basketball.Value;
        Value.CFrame = Character.PlrBall.Anims.BALL.CFrame;
        local Magnitude = (HumanoidRootPart.Position - workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position).Magnitude;

        if Magnitude <= 115 then
            Pos2 = workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position;
        end;

        local v32 = Pos2 - Value.Position;
        local v33, v34;

        if Magnitude <= 30 then
            v33 = v32.Magnitude * 0.0455;
            v34 = 1.35;
        else
            v33 = v32.Magnitude * 0.04;
            v34 = 0.5;
        end;

        local math_log_ret = math.log(v34 + v33);
        Value.AssemblyLinearVelocity = v32 / math_log_ret + Vector3.new(0, workspace.Gravity * math_log_ret * 0.5, 0);
    end);
    u8.AC:Add(function() -- Line: 177
        -- upvalues: u3 (ref), u5 (ref), Shiftlock (copy)
        u3.States.Ability = false;
        u3.States.NoWalk = false;
        u3.States.AimAssist = false;
        u5:SetShiftlock(Shiftlock);
    end);
    u8.AC:Add(task.delay(1.9 / u18, function() -- Line: 185
        -- upvalues: u8 (copy)
        u8.AC:Clean();
    end));
    task.spawn(function() -- Line: 189
        -- upvalues: TweenService (ref), workspace_CurrentCamera (ref), u18 (ref)
        TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.5 / u18), {
            FieldOfView = 50
        }):Play();
        task.wait(0.6666666666666666 / u18);
        TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.55), {
            FieldOfView = 100
        }):Play();
        task.wait(0.55 / u18);
        TweenService:Create(workspace_CurrentCamera, TweenInfo.new(1), {
            FieldOfView = 70
        }):Play();
    end);
end;