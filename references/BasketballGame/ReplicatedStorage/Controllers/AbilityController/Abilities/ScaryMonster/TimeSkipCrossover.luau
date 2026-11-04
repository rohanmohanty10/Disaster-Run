 
 

game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
local CameraShaker = require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local Cooldowns = require(ReplicatedStorage.Shared.Tables.Cooldowns);
local Zones = require(ReplicatedStorage.Shared.Tables.Zones);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local LocalPlayer = game.Players.LocalPlayer;
local workspace_CurrentCamera = workspace.CurrentCamera;

return function(u7) -- Line: 23
    -- upvalues: LocalPlayer (copy), u1 (ref), u2 (ref), u3 (ref), u4 (ref), u5 (ref), u6 (ref), Effects (copy), ReplicatedStorage (copy), CameraShaker (copy), RunService (copy), Zones (copy), workspace_CurrentCamera (copy), Essentials (copy), TweenService (copy), Cooldowns (copy)
    local Character = LocalPlayer.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local Humanoid = Character.Humanoid;
    u1 = u7.AbilityService;
    u2 = u7.Animations;
    u3 = u7.MovementController;
    u4 = u7.BallController;
    u5 = u7.CameraController;
    u6 = u7.Network;

    if u7.Dribble then
        local LookingAt = u7.Pass.LookingAt;

        if game:GetService("RunService"):IsStudio() then
            LookingAt = workspace.DefenseRig;
        end;

        if not LookingAt then
            Effects:Popup("You must be looking at a teammate!");
            u7:ResetCD(1);

            return;
        end;

        u7:ResetCopy();
        u7.Dribble = nil;
        u3.States.Ability = true;
        u3.States.NoWalk = true;
        u7.AC:Add(function() -- Line: 53
            -- upvalues: u3 (ref)
            u3.States.Ability = false;
            u3.States.NoWalk = false;
        end);
        u7.AC:Add(task.delay(0.9555555555555556, function() -- Line: 58
            -- upvalues: u7 (copy)
            u7.AC:Clean();
        end));
        u2:StopAll();
        local v8 = u2:PlayChar("ScaryMonster", "RevolverPass", Enum.AnimationPriority.Action3, true);
        local v9 = u2:PlayBall("ScaryMonster", "RevolverPassBall", Enum.AnimationPriority.Action3, true);
        v8:AdjustSpeed(1.5);
        v9:AdjustSpeed(1.5);
        local v10 = Humanoid:LoadAnimation(ReplicatedStorage.Assets.StyleAnimations.ScaryMonster.RevolverPassRevolver);
        v10:Play();
        v10:AdjustSpeed(1.5);
        v10.Priority = Enum.AnimationPriority.Action3;
        u1.Ability:Fire("Time Skip Crossover", {
            State = "Pass",
            TimeSent = workspace:GetServerTimeNow(),
            Passing = LookingAt
        });
        u7.AC:Connect(u1.Ability, function() -- Line: 75
            -- upvalues: u5 (ref), CameraShaker (ref), ReplicatedStorage (ref), u4 (ref), Character (copy), LookingAt (ref), u7 (copy), RunService (ref), u6 (ref), Zones (ref), LocalPlayer (ref)
            u5.CamShake:Shake(CameraShaker.Presets.Dunk);
            local Value = ReplicatedStorage.Basketball.Value;
            Value.CFrame = (u4:GetLastCharacterToPossessBall() or Character).PlrBall.Anims.BALL.CFrame;
            local Position = Value.Position;
            local Position2 = LookingAt.HumanoidRootPart.Position;
            local Unit = ((Position2 - Position) * Vector3.new(1, 0, 1)).Unit;
            local Magnitude = ((Position2 - Position) * Vector3.new(1, 0, 1)).Magnitude;
            Value.AssemblyLinearVelocity = (Unit + Vector3.new(0, 0.62, 0)) * Magnitude;
            local LinearVelocity = Instance.new("LinearVelocity", Value);
            LinearVelocity.Attachment0 = Value.Root;
            LinearVelocity.MaxForce = 40000;
            LinearVelocity.VectorVelocity = (Unit + Vector3.new(0, 0.62, 0)) * Magnitude;
            u7.AC:Add(LinearVelocity);
            local u11 = tick();
            local u12 = nil;
            task.delay(0.15, function() -- Line: 101
                -- upvalues: u12 (ref), RunService (ref), u4 (ref), LinearVelocity (copy), LookingAt (ref), u11 (copy), Value (copy), u6 (ref), Zones (ref), LocalPlayer (ref)
                u12 = RunService.Heartbeat:Connect(function(p13) -- Line: 102
                    -- upvalues: u4 (ref), u12 (ref), LinearVelocity (ref), LookingAt (ref), u11 (ref), Value (ref), u6 (ref), Zones (ref), LocalPlayer (ref)
                    if u4:GetPlayerPossessingBall() then
                        u12:Disconnect();
                        LinearVelocity:Destroy();

                        return;
                    end;

                    local ServerBallPosition = u4:GetServerBallPosition();
                    local Magnitude2 = (LookingAt.HumanoidRootPart.Position - ServerBallPosition).Magnitude;

                    if Magnitude2 <= 10 then
                        u12:Disconnect();
                        LinearVelocity:Destroy();

                        return;
                    end;

                    if u11 + 3 < tick() or not Value.Parent then
                        u12:Disconnect();
                        LinearVelocity:Destroy();
                        Value.AssemblyLinearVelocity = LinearVelocity.VectorVelocity;

                        return;
                    end;

                    local Unit2 = (LookingAt.HumanoidRootPart.Position - ServerBallPosition).Unit;
                    local v14 = 1;

                    if u6.CharValues.InZone and Zones.ZoneIncreasedPassingSpeed[LocalPlayer.Zone.Value] then
                        v14 = v14 + Zones.ZoneIncreasedPassingSpeed[LocalPlayer.Zone.Value];
                    end;

                    LinearVelocity.VectorVelocity = Unit2 * 150 * v14;
                    LinearVelocity.VectorVelocity = (Unit2 * v14 + Vector3.new(0, Magnitude2 / 150 / 2.2 - 0.05, 0)) * 150;
                end);
            end);
        end);

        return;
    end;

    if u7.MovementController.States.PumpFake then
        u7:ResetCD(1);
        Effects:Popup("Can\'t use after a fake!");

        return;
    end;

    u3.States.Ability = true;
    u7.AC:Add(function() -- Line: 148
        -- upvalues: u3 (ref)
        u3.States.Ability = false;
    end);
    u7.AC:Add(task.delay(0.5, function() -- Line: 152
        -- upvalues: u3 (ref)
        u3.States.Ability = false;
    end));
    u7.AC:Add(task.delay(0.7, function() -- Line: 156
        -- upvalues: Character (copy), HumanoidRootPart (copy), u7 (copy)
        local RaycastParams_new_ret = RaycastParams.new();
        RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
        RaycastParams_new_ret.FilterDescendantsInstances = { Character };
        RaycastParams_new_ret.CollisionGroup = "Player";
        local v15 = -HumanoidRootPart.CFrame.RightVector * 25;
        local v16 = workspace:Raycast(HumanoidRootPart.Position, v15, RaycastParams_new_ret);

        if v16 then
            HumanoidRootPart.CFrame = CFrame.new(HumanoidRootPart.Position + (v16.Position - HumanoidRootPart.Position).Unit * (v16.Distance - 1)) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation());
        else
            HumanoidRootPart.CFrame = CFrame.new(HumanoidRootPart.Position + v15) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation());
        end;

        u7.AC:Clean();
    end));
    u2:StopAll();
    u2:PlayChar("ScaryMonster", "TimeSkipCrossover", Enum.AnimationPriority.Action3);
    u2:PlayBall("ScaryMonster", "TimeSkipCrossoverBall", Enum.AnimationPriority.Action3);
    u1.Ability:Fire("Time Skip Crossover", {
        State = "Dribble",
        TimeSent = workspace:GetServerTimeNow()
    });
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u7.AC:Connect(RunService.Heartbeat, function(p17) -- Line: 183
        -- upvalues: FieldOfView (ref), Essentials (ref), workspace_CurrentCamera (ref)
        FieldOfView = Essentials:Lerp(FieldOfView, 40, p17 * 5);
        workspace_CurrentCamera.FieldOfView = FieldOfView;
    end);
    local u18 = u7.AC:Add(Instance.new("LinearVelocity"));
    u18.ForceLimitMode = Enum.ForceLimitMode.PerAxis;
    u18.MaxAxesForce = Vector3.new(40000, 0, 40000);
    u18.Attachment0 = HumanoidRootPart.RootAttachment;
    u18.Parent = HumanoidRootPart;
    u18.VectorVelocity = HumanoidRootPart.CFrame.RightVector * 50;
    TweenService:Create(u18, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
        VectorVelocity = HumanoidRootPart.CFrame.RightVector * 25
    }):Play();
    task.delay(0.5, function() -- Line: 197
        -- upvalues: TweenService (ref), u18 (copy), HumanoidRootPart (copy)
        TweenService:Create(u18, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            VectorVelocity = -HumanoidRootPart.CFrame.RightVector * 50
        }):Play();
    end);
    u7.Dribble = true;
    u7:ResetCD(1);
    local u19 = nil;
    task.delay(3, function() -- Line: 205
        -- upvalues: u19 (ref)
        u19 = true;
    end);
    local u20 = 1;
    local u21 = false;
    local u22 = nil;

    local function End() -- Line: 214
        -- upvalues: LocalPlayer (ref), u7 (copy), u6 (ref), Cooldowns (ref), u22 (ref)
        if not (workspace:GetAttribute("NoAbilityCooldowns") or (LocalPlayer:GetAttribute("NoAbilityCooldowns") or LocalPlayer.Style.Value == "Copycat" and LocalPlayer:GetAttribute("TrueCopycat")) or LocalPlayer.Style.Value == "Thief" and u7.TotalTheft) then
            local v23 = LocalPlayer.Zone.Value == "Vampiric" and u6.CharValues.InZone and 0.75 or 1;
            u7.CDS[1] = tick() + Cooldowns.Abilities.ScaryMonster[1] * v23;
        end;

        LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = 1;
        LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "Time Skip Crossover";
        u22:Disconnect();
        u7.Dribble = nil;
        u7:ResetCopy();
    end;

    u22 = RunService.Heartbeat:Connect(function(p24) -- Line: 233
        -- upvalues: u7 (copy), u19 (ref), End (copy), u6 (ref), LocalPlayer (ref), u20 (ref), u21 (ref)
        if not u7.Dribble or u19 then
            End();

            return;
        end;

        if not u6.CharValues.HasBall then
            End();

            return;
        end;

        LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = u20;

        if u20 > 0.5 and not u21 then
            p24 = -p24 or p24;
        end;

        u20 = u20 + p24;

        if u20 <= 0.5 then
            u21 = true;
        end;

        if u20 >= 1 then
            u21 = false;
        end;

        LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "Revolver Pass";
    end);
end;