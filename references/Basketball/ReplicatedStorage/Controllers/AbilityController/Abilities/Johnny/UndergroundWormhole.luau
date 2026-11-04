 
 

game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
require(ReplicatedStorage.Shared.Utility.Essentials);
local Abilities = require(ReplicatedStorage.Shared.Tables.Cooldowns).Abilities;
require(ReplicatedStorage.Shared.Functions.CalculateBallTrajectory);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local LocalPlayer = game.Players.LocalPlayer;
local workspace_CurrentCamera = workspace.CurrentCamera;

return function(u6) -- Line: 22
    -- upvalues: LocalPlayer (copy), u1 (ref), u2 (ref), u3 (ref), u4 (ref), u5 (ref), Effects (copy), RunService (copy), TweenService (copy), Abilities (copy), workspace_CurrentCamera (copy), ReplicatedStorage (copy)
    local Character = LocalPlayer.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local Humanoid = Character.Humanoid;
    u1 = u6.AbilityService;
    u2 = u6.MovementController;
    u3 = u6.BallController;
    u4 = u6.Animations;
    u5 = u6.Network;

    if u6.Wormhole or not u5.CharValues.HasBall then
        local function Emerge() -- Line: 211
            -- upvalues: u6 (copy), LocalPlayer (ref), Abilities (ref), workspace_CurrentCamera (ref), Humanoid (copy), u2 (ref), u4 (ref)
            if u6.Wormhole then
                if not (workspace:GetAttribute("NoAbilityCooldowns") or (LocalPlayer:GetAttribute("NoAbilityCooldowns") or LocalPlayer.Style.Value == "Copycat" and LocalPlayer:GetAttribute("TrueCopycat")) or LocalPlayer.Style.Value == "Thief" and u6.TotalTheft) then
                    u6.CDS[1] = tick() + Abilities.Johnny[1];
                end;

                u6:ResetCopy();
                u6.Wormhole = nil;
                u6.AC:Clean();
                workspace_CurrentCamera.CameraSubject = Humanoid;
                u2.Boost = 0;
                u2.States.Ability = false;
                u2.States.AbilitiesUsable = 0;
                u4:StopAll();
                u4:PlayChar("Johnny", "UndergroundWormholeEmerge", Enum.AnimationPriority.Action3);
            end;
        end;

        if u6.Wormhole then
            Emerge();

            if u6.Wormhole ~= "NoSteal" then
                u1.Ability:Fire("Underground Wormhole", {
                    State = "Emerge",
                    TimeSent = workspace:GetServerTimeNow()
                });

                return;
            end;
        else
            u6.Wormhole = true;
            u2.States.Ability = true;
            u4:StopAll();
            u4:PlayChar("Johnny", "UndergroundWormholeDive", Enum.AnimationPriority.Action3);
            local LinearVelocity = Instance.new("LinearVelocity");
            LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
            LinearVelocity.MaxForce = (1 / 0);
            LinearVelocity.Parent = HumanoidRootPart;
            u6.AC:Add(LinearVelocity);
            u6.AC:Connect(RunService.Heartbeat, function() -- Line: 252
                -- upvalues: LinearVelocity (copy), Humanoid (copy)
                if not LinearVelocity then
                    return;
                end;

                LinearVelocity.VectorVelocity = Humanoid.MoveDirection * Vector3.new(1, 0, 1) * Humanoid.WalkSpeed;
            end);
            u6.AC:Add(task.delay(0.8, function() -- Line: 257
                -- upvalues: u6 (copy), workspace_CurrentCamera (ref), HumanoidRootPart (copy), u2 (ref), u1 (ref), RunService (ref), ReplicatedStorage (ref), u3 (ref), LocalPlayer (ref), Emerge (copy)
                u6.AC:Clean();
                u6:ResetCD(1);
                workspace_CurrentCamera.CameraSubject = HumanoidRootPart;
                u2.Boost = 10;
                u2.States.AbilitiesUsable = 1;
                u1.Ability:Fire("Underground Wormhole", {
                    State = "Dive",
                    TimeSent = workspace:GetServerTimeNow()
                });
                local u7 = 1;
                local u8 = false;
                local u9 = nil;
                u9 = RunService.Heartbeat:Connect(function(p10) -- Line: 271
                    -- upvalues: ReplicatedStorage (ref), u6 (ref), u3 (ref), LocalPlayer (ref), Emerge (ref), u9 (ref), u7 (ref), u8 (ref)
                    if ReplicatedStorage.GameValues.Scoring.Value then
                        u6.Wormhole = "NoSteal";
                    end;

                    if u3:GetPlayerPossessingBall() == LocalPlayer then
                        Emerge();
                    end;

                    if not u6.Wormhole then
                        u9:Disconnect();
                        LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = 1;

                        return;
                    end;

                    LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = u7;

                    if u7 > 0.5 and not u8 then
                        p10 = -p10 or p10;
                    end;

                    u7 = u7 + p10;

                    if u7 <= 0.5 then
                        u8 = true;
                    end;

                    if u7 >= 1 then
                        u8 = false;
                    end;

                    LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "Emerge";
                end);
                task.delay(5, function() -- Line: 299
                    -- upvalues: Emerge (ref)
                    Emerge();
                end);
                u6.AC:Connect(u1.Ability, function() -- Line: 303
                    -- upvalues: Emerge (ref)
                    Emerge();
                end);
            end));
        end;

        return;
    end;

    if u6.Dribble then
        local LookingAt = u6.Pass.LookingAt;

        if game:GetService("RunService"):IsStudio() then
            LookingAt = workspace.DefenseRig;
        end;

        if not LookingAt then
            Effects:Popup("You must be looking at a teammate!");
            u6:ResetCD(1);

            return;
        end;

        u6:ResetCopy();
        u6.Dribble = nil;
        u1.Ability:Fire("Underground Wormhole", {
            State = "Pass",
            TimeSent = workspace:GetServerTimeNow(),
            Passing = LookingAt
        });
        u4:StopAll();
        u4:PlayChar("Johnny", "WormholePass", Enum.AnimationPriority.Action3);
        u4:PlayBall("Johnny", "WormholePassBall", Enum.AnimationPriority.Action3);
        u2.States.Ability = true;
        u2.States.NoWalk = true;
        task.delay(2.15, function() -- Line: 58
            -- upvalues: u2 (ref)
            u2.States.Ability = false;
            u2.States.NoWalk = false;
        end);

        return;
    end;

    if u2.States.PumpFake then
        Effects:Popup("Can\'t use after a fake!");
        u6:ResetCD(1);

        return;
    end;

    u1.Ability:Fire("Underground Wormhole", {
        State = "Dribble",
        TimeSent = workspace:GetServerTimeNow()
    });
    u4:StopAll();
    local v11 = u4:PlayChar("Johnny", "WormholeDribble", Enum.AnimationPriority.Action3, true);
    local v12 = u4:PlayBall("Johnny", "WormholeDribbleBall", Enum.AnimationPriority.Action3, true);
    v11:AdjustSpeed(1.5);
    v12:AdjustSpeed(1.5);
    u6.Dribble = true;
    u2.States.Ability = true;
    u6.AC:Add(function() -- Line: 83
        -- upvalues: u2 (ref)
        u2.States.Ability = false;
    end);
    local u13 = 32;
    local Vector3Value = Instance.new("Vector3Value");
    local LinearVelocity = Instance.new("LinearVelocity");
    LinearVelocity.ForceLimitMode = Enum.ForceLimitMode.PerAxis;
    LinearVelocity.MaxAxesForce = Vector3.new(inf, 0, inf);
    LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
    LinearVelocity.MaxForce = (1 / 0);
    LinearVelocity.Parent = HumanoidRootPart;
    u6.AC:Add(Vector3Value);
    u6.AC:Add(LinearVelocity);
    u6.AC:Connect(RunService.Heartbeat, function(p14) -- Line: 100
        -- upvalues: u5 (ref), u4 (ref), u6 (copy), HumanoidRootPart (copy), Vector3Value (copy), LinearVelocity (copy), u13 (ref)
        if u5.CharValues.HasBall then
            LinearVelocity.VectorVelocity = (HumanoidRootPart.CFrame.LookVector + Vector3Value.Value * 3) * Vector3.new(1, 0, 1) * (u13 / 1.7);
            u13 = u13 - p14 * 4;

            return;
        end;

        u4:StopAll();
        u6.AC:Clean();
    end);
    task.delay(0.13333333333333333, function() -- Line: 115
        -- upvalues: Vector3Value (copy), HumanoidRootPart (copy), u13 (ref)
        Vector3Value.Value = -HumanoidRootPart.CFrame.RightVector / 2;
        u13 = 25;
    end);
    task.delay(0.39999999999999997, function() -- Line: 119
        -- upvalues: Vector3Value (copy), HumanoidRootPart (copy), TweenService (ref), u13 (ref)
        Vector3Value.Value = HumanoidRootPart.CFrame.RightVector / 1.5;
        TweenService:Create(Vector3Value, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
            Value = Vector3.new(0, 0, 0)
        }):Play();
        u13 = 35;
    end);
    task.delay(0.6666666666666666, function() -- Line: 124
        -- upvalues: Vector3Value (copy), HumanoidRootPart (copy), TweenService (ref), u13 (ref)
        Vector3Value.Value = HumanoidRootPart.CFrame.LookVector;
        TweenService:Create(Vector3Value, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
            Value = Vector3.new(0, 0, 0)
        }):Play();
        u13 = 50;
    end);
    task.delay(0.7999999999999999, function() -- Line: 129
        -- upvalues: Vector3Value (copy), HumanoidRootPart (copy), u13 (ref), TweenService (ref)
        Vector3Value.Value = -HumanoidRootPart.CFrame.RightVector / 1.5;
        u13 = 25;
        TweenService:Create(Vector3Value, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Value = Vector3.new(0, 0, 0)
        }):Play();
    end);
    task.delay(1.0666666666666667, function() -- Line: 134
        -- upvalues: Vector3Value (copy), HumanoidRootPart (copy), u13 (ref), TweenService (ref)
        Vector3Value.Value = HumanoidRootPart.CFrame.LookVector;
        u13 = 50;
        TweenService:Create(Vector3Value, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Value = Vector3.new(0, 0, 0)
        }):Play();
    end);
    task.delay(1.288888888888889, function() -- Line: 139
        -- upvalues: Vector3Value (copy), HumanoidRootPart (copy), u13 (ref), TweenService (ref)
        Vector3Value.Value = HumanoidRootPart.CFrame.RightVector * 2;
        u13 = 25;
        TweenService:Create(Vector3Value, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Value = Vector3.new(0, 0, 0)
        }):Play();
    end);
    task.delay(1.9111111111111112, function() -- Line: 144
        -- upvalues: Vector3Value (copy), HumanoidRootPart (copy), u13 (ref), TweenService (ref)
        Vector3Value.Value = -HumanoidRootPart.CFrame.RightVector * 2;
        u13 = 25;
        TweenService:Create(Vector3Value, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Value = Vector3.new(0, 0, 0)
        }):Play();
    end);
    u6.AC:Add(task.delay(2.788888888888889, function() -- Line: 150
        -- upvalues: u6 (copy), LocalPlayer (ref), Abilities (ref), u5 (ref), RunService (ref)
        u6.AC:Clean();
        u6:ResetCD(1);
        local u15 = nil;
        task.delay(3, function() -- Line: 156
            -- upvalues: u15 (ref)
            u15 = true;
        end);
        local u16 = 1;
        local u17 = false;
        local u18 = nil;

        local function End() -- Line: 165
            -- upvalues: LocalPlayer (ref), u6 (ref), Abilities (ref), u5 (ref), u18 (ref)
            if not (workspace:GetAttribute("NoAbilityCooldowns") or (LocalPlayer:GetAttribute("NoAbilityCooldowns") or LocalPlayer.Style.Value == "Copycat" and LocalPlayer:GetAttribute("TrueCopycat")) or LocalPlayer.Style.Value == "Thief" and u6.TotalTheft) then
                u6.CDS[1] = tick() + Abilities.Johnny[1];
            end;

            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = 1;

            if u5.CharValues.HasBall then
                LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "Wormhole Dribble";
            else
                LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "Underground Wormhole";
            end;

            u18:Disconnect();
            u6.AC:Clean();
            u6.Dribble = nil;
            u6:ResetCopy();
        end;

        u18 = RunService.Heartbeat:Connect(function(p19) -- Line: 185
            -- upvalues: u6 (ref), u15 (ref), End (copy), u5 (ref), LocalPlayer (ref), u16 (ref), u17 (ref)
            if not u6.Dribble or u15 then
                End();

                return;
            end;

            if not u5.CharValues.HasBall then
                End();

                return;
            end;

            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = u16;

            if u16 > 0.5 and not u17 then
                p19 = -p19 or p19;
            end;

            u16 = u16 + p19;

            if u16 <= 0.5 then
                u17 = true;
            end;

            if u16 >= 1 then
                u17 = false;
            end;

            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "Wormhole Pass";
        end);
    end));
end;