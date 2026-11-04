 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local Cooldowns = require(ReplicatedStorage.Shared.Tables.Cooldowns);
local CalculateBallTrajectory = require(ReplicatedStorage.Shared.Functions.CalculateBallTrajectory);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local LocalPlayer = game.Players.LocalPlayer;
local RaycastParams_new_ret = RaycastParams.new();
RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Include;
RaycastParams_new_ret.FilterDescendantsInstances = { workspace.Barriers };

return function(u7) -- Line: 25, Name: Dash
    -- upvalues: LocalPlayer (copy), u1 (ref), u3 (ref), u2 (ref), u4 (ref), u5 (ref), u6 (ref), Effects (copy), RaycastParams_new_ret (copy), RunService (copy), ReplicatedStorage (copy), CalculateBallTrajectory (copy), TweenService (copy), Cooldowns (copy)
    local Character = LocalPlayer.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local Humanoid = Character.Humanoid;
    u1 = u7.AbilityService;
    u3 = u7.Animations;
    u2 = u7.MovementController;
    u4 = u7.BallController;
    u5 = u7.CameraController;
    u6 = u7.Network;

    if u2.States.PumpFake then
        u7:ResetCD(1);
        Effects:Popup("Can\'t use after a fake!");

        return;
    end;

    if u7.DashAwakening then
        local Position = workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position;
        u7.DashAwakening = nil;
        u2.States.Ability = true;
        u2.States.NoWalk = true;
        LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "Dash";

        if not (workspace:GetAttribute("NoAbilityCooldowns") or (LocalPlayer:GetAttribute("NoAbilityCooldowns") or LocalPlayer.Style.Value == "Copycat" and LocalPlayer:GetAttribute("TrueCopycat")) or LocalPlayer.Style.Value == "Thief" and u7.TotalTheft) then
            u7.CDS[1] = tick() + 40;
        end;

        local v8 = HumanoidRootPart.CFrame + HumanoidRootPart.CFrame.RightVector * 40 * Vector3.new(1, 0, 1);
        local v9 = v8.Position - HumanoidRootPart.Position;
        local v10 = workspace:Raycast(HumanoidRootPart.Position, v9.Unit * v9.Magnitude, RaycastParams_new_ret);

        if v10 then
            v8 = CFrame.new(v10.Position) * CFrame.Angles(v8:ToOrientation());
        end;

        HumanoidRootPart.CFrame = v8;
        u3:StopAll();
        u3:PlayChar("Flash", "DashShoot", Enum.AnimationPriority.Action3);
        u3:PlayBall("Flash", "DashShootBall", Enum.AnimationPriority.Action3);
        local u11 = 40;
        local u12 = 0.75;
        local BodyVelocity = Instance.new("BodyVelocity");
        BodyVelocity.Name = "BodyVelocityBasketball";
        BodyVelocity.MaxForce = Vector3.new(1, 1, 1) * (1 / 0);
        BodyVelocity.Parent = HumanoidRootPart;
        local u13 = tick();
        local u15 = RunService.Heartbeat:Connect(function(p14) -- Line: 73
            -- upvalues: u11 (ref), u13 (copy), BodyVelocity (copy), HumanoidRootPart (copy), u12 (ref)
            if u11 >= 10 then
                if u13 + 0.125 < tick() then
                    BodyVelocity.Velocity = (HumanoidRootPart.CFrame.LookVector * -1.1 + Vector3.new(0, u12, 0)) * u11 + HumanoidRootPart.CFrame.RightVector * 30;
                    u12 = u12 - p14 * 1.75;
                else
                    BodyVelocity.Velocity = (HumanoidRootPart.CFrame.LookVector * -1.1 + Vector3.new(0, 0, 0)) * u11 + HumanoidRootPart.CFrame.RightVector * 30;
                end;

                u11 = u11 - p14;
            end;
        end);
        task.delay(0.75, function() -- Line: 85
            -- upvalues: u15 (ref), BodyVelocity (copy)
            if u15 then
                u15:Disconnect();
                u15 = nil;
            end;

            BodyVelocity:Destroy();
        end);
        u7.AC:Add(task.delay(0.75, function() -- Line: 93
            -- upvalues: u2 (ref)
            u2.States.Ability = false;
            u2.States.NoWalk = false;
        end));
        u7.AC:Connect(u1.Ability, function(p16) -- Line: 98
            -- upvalues: u7 (copy), u2 (ref), ReplicatedStorage (ref), CalculateBallTrajectory (ref), Position (copy)
            u7.AC:Clean();
            u2.States.Ability = false;
            u2.States.NoWalk = false;
            local Value = ReplicatedStorage.Basketball.Value;
            Value.AssemblyLinearVelocity = CalculateBallTrajectory(Value.Position, Position, 70, 1 * workspace.Gravity);
        end);
        u1.Ability:Fire("DashFlash", {
            Shot = true,
            TimeSent = workspace:GetServerTimeNow()
        });

        return;
    end;

    local _ = u7.BallController.DribbleDB;
    u2.States.Ability = true;
    task.delay(0.35, function() -- Line: 166
        -- upvalues: u2 (ref), u7 (copy), u6 (ref), LocalPlayer (ref), u4 (ref), TweenService (ref), Effects (ref), RunService (ref), Cooldowns (ref)
        u2.States.Ability = false;
        u7.AC:Clean();

        if u6.CharValues.InAwakening and (LocalPlayer.Style.Value ~= "Thief" and (u4:LocalPlayerPossessesBall() and u7:HoopDist() <= 125)) then
            u7.DashAwakening = true;
            local u17 = tick();
            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = 0.25;
            local u18 = TweenService:Create(LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash, TweenInfo.new(5, Enum.EasingStyle.Linear), {
                BackgroundTransparency = 1
            });
            u18:Play();
            Effects:Popup("Press the ability again to shoot!", 4);
            u7:ResetCD(1);
            local u19 = nil;
            u19 = RunService.Heartbeat:Connect(function() -- Line: 179
                -- upvalues: u7 (ref), LocalPlayer (ref), u18 (copy), u19 (ref), u17 (copy), Cooldowns (ref), u4 (ref), Effects (ref)
                local v20 = u7:HoopDist();
                LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "SHOOT!";

                if not u7.DashAwakening then
                    LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "Dash";

                    if u18 then
                        u18:Cancel();
                        LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = 1;
                        u18:Destroy();
                    end;

                    if u19 then
                        u19:Disconnect();
                        u19 = nil;
                    end;
                end;

                if tick() - u17 >= 5 then
                    u7.CDS[1] = tick() + Cooldowns.Abilities.Flash[1];
                    LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "Dash";
                    u7.DashAwakening = nil;

                    if u18 then
                        u18:Cancel();
                        LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = 1;
                        u18:Destroy();
                    end;

                    if u19 then
                        u19:Disconnect();
                        u19 = nil;
                    end;
                end;

                if not u4:LocalPlayerPossessesBall() or v20 > 125 then
                    LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "Dash";

                    if v20 > 125 then
                        u7.CDS[1] = tick() + 25;
                        Effects:Popup("Get closer to the hoop to use the ability!");
                    else
                        u7.CDS[1] = tick() + Cooldowns.Abilities.Flash[1];
                    end;

                    u7.DashAwakening = nil;

                    if u18 then
                        u18:Cancel();
                        LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = 1;
                        u18:Destroy();
                    end;

                    if u19 then
                        u19:Disconnect();
                        u19 = nil;
                    end;
                end;
            end);
        end;
    end);
    local AssemblyLinearVelocity = HumanoidRootPart.AssemblyLinearVelocity;
    local v21 = HumanoidRootPart.CFrame:VectorToObjectSpace(HumanoidRootPart.AssemblyLinearVelocity);
    local v22 = {};
    local math_clamp_ret = math.clamp(v21.X / Humanoid.WalkSpeed, 0.01, 1);
    v22.R = math.abs(math_clamp_ret);
    local math_clamp_ret2 = math.clamp(v21.X / Humanoid.WalkSpeed, -1, -0.01);
    v22.L = math.abs(math_clamp_ret2);
    local math_clamp_ret3 = math.clamp(v21.Z / Humanoid.WalkSpeed, -1, -0.01);
    v22.F = math.abs(math_clamp_ret3);
    local math_clamp_ret4 = math.clamp(v21.Z / Humanoid.WalkSpeed, 0.01, 1);
    v22.B = math.abs(math_clamp_ret4);

    if AssemblyLinearVelocity.Magnitude < 5 then
        AssemblyLinearVelocity = HumanoidRootPart.CFrame.LookVector;
    end;

    if AssemblyLinearVelocity.Y > 3 and (AssemblyLinearVelocity.X < 5 and AssemblyLinearVelocity.Z < 5) then
        AssemblyLinearVelocity = HumanoidRootPart.CFrame.LookVector;
    end;

    local v23 = 0.1;
    local v24 = "F";

    for i, v in v22 do
        if v23 < v then
            v24 = i;
            v23 = v;
        end;
    end;

    local v25 = u7.Network.CharValues.HasBall and "B" or "";
    u3:StopAll();
    u3:PlayChar("Flash", `Dash{v24}{v25}`, Enum.AnimationPriority.Action3);
    u3:PlayBall("Flash", `Dash{v24}Ball`, Enum.AnimationPriority.Action3);
    local LinearVelocity = Instance.new("LinearVelocity");
    LinearVelocity.ForceLimitMode = Enum.ForceLimitMode.PerAxis;
    LinearVelocity.MaxAxesForce = Vector3.new(20000, 0, 20000);
    LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
    LinearVelocity.Parent = HumanoidRootPart;
    u7.AC:Add(LinearVelocity);
    local u26 = 90;
    u7.AC:Connect(RunService.Heartbeat, function(p27) -- Line: 246
        -- upvalues: u26 (ref), LinearVelocity (copy), AssemblyLinearVelocity (ref)
        u26 = u26 - p27 * 30;
        LinearVelocity.VectorVelocity = AssemblyLinearVelocity.Unit * u26;
    end);
    u1.Ability:Fire("DashFlash", {
        TimeSent = workspace:GetServerTimeNow()
    });
end;