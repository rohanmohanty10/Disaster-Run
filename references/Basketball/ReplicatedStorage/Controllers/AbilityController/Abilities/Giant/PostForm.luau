 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
game:GetService("UserInputService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local LocalPlayer = game.Players.LocalPlayer;

return function(u6, p7) -- Line: 22, Name: PostForm
    -- upvalues: LocalPlayer (copy), u2 (ref), u4 (ref), u1 (ref), u3 (ref), u5 (ref), Effects (copy), RunService (copy), TweenService (copy), ReplicatedStorage (copy)
    local HumanoidRootPart = LocalPlayer.Character.HumanoidRootPart;
    local Attribute = LocalPlayer:GetAttribute("TrueGiant");
    u2 = u6.MovementController;
    u4 = u6.BallController;
    u1 = u6.AbilityService;
    u3 = u6.Animations;
    u5 = u6.Network;

    if u2.States.Dunking then
        Effects:Popup("Can\'t use while dunking");

        return;
    end;

    if not u6.InPostForm then
        local v8 = u6:CheckInfront(Attribute and 52 or 27);

        if v8 == nil and RunService:IsStudio() then
            v8 = workspace.DefenseRig;
        end;

        if u2.States.PumpFake then
            Effects:Popup("Can\'t use after a fake!");
            u6:ResetCD(1);

            return;
        end;

        local Magnitude = (workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position - HumanoidRootPart.Position).Magnitude;

        if (Attribute and 110 or 85) <= Magnitude then
            Effects:Popup("Need to be closer to hoop!");
            u6:ResetCD(1);

            return;
        end;

        if Magnitude <= 30 then
            Effects:Popup("Too close to the hoop!");
            u6:ResetCD(1);

            return;
        end;

        u6.InPostForm = true;
        LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "Post-Hook";
        u6.AC:Add(task.delay(0.25, function() -- Line: 181
            -- upvalues: u2 (ref), u6 (copy)
            if not u2.States.NoWalk then
                return;
            end;

            u6:ResetCD(1);
        end));
        u2.States.NoWalk = true;
        u2.States.Ability = true;
        u2.States.AbilitiesUsable = p7;
        u3:StopAll();
        u3:PlayChar("Giant", "Ability1Start", Enum.AnimationPriority.Action3);
        u3:PlayChar("Giant", "Ability1Loop", Enum.AnimationPriority.Action3);
        u3:PlayBall("Giant", "Ability1StartBall", Enum.AnimationPriority.Action3);
        u3:PlayBall("Giant", "Ability1LoopBall", Enum.AnimationPriority.Action3);
        u1.Ability:Fire("PostForm", {
            TimeSent = workspace:GetServerTimeNow(),
            Other = v8
        });
        local u9 = 1;
        local u10 = false;
        u6.AC:Connect(RunService.Heartbeat, function(p11) -- Line: 202
            -- upvalues: u5 (ref), LocalPlayer (ref), u6 (copy), u3 (ref), u2 (ref), HumanoidRootPart (copy), u9 (ref), u10 (ref)
            if not u5.CharValues.HasBall then
                if not (workspace:GetAttribute("NoAbilityCooldowns") or (LocalPlayer:GetAttribute("NoAbilityCooldowns") or LocalPlayer.Style.Value == "Copycat" and LocalPlayer:GetAttribute("TrueCopycat")) or LocalPlayer.Style.Value == "Thief" and u6.TotalTheft) then
                    u6.CDS[1] = tick() + 70;
                end;

                u6.AC:Clean();
                u3:StopAll();
                u6.InPostForm = false;
                u2.States.NoWalk = false;
                u2.States.Ability = false;
                u2.States.AbilitiesUsable = 0;
                LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = 1;

                return;
            end;

            if u2.States.PumpFake then
                u6.AC:Clean();
                u2.States.NoWalk = false;
                u2.States.Ability = false;
                u2.States.AbilitiesUsable = 0;
                LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = 1;

                return;
            end;

            local Magnitude2 = (HumanoidRootPart.Position - workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position).Magnitude;
            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = u9;

            if u9 > 0.5 and not u10 then
                p11 = -p11 or p11;
            end;

            u9 = u9 + p11;

            if u9 <= 0.5 then
                u10 = true;
            end;

            if u9 >= 1 then
                u10 = false;
            end;

            if Magnitude2 <= 40 then
                LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "Post-Dunk";

                return;
            end;

            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "Post-Hook";
        end);
        u6.AC:Connect(u1.Ability, function() -- Line: 243
            -- upvalues: u6 (copy), LocalPlayer (ref), u3 (ref), u2 (ref)
            u6.AC:Clean();

            if not (workspace:GetAttribute("NoAbilityCooldowns") or (LocalPlayer:GetAttribute("NoAbilityCooldowns") or LocalPlayer.Style.Value == "Copycat" and LocalPlayer:GetAttribute("TrueCopycat")) or LocalPlayer.Style.Value == "Thief" and u6.TotalTheft) then
                u6.CDS[1] = tick() + 70;
            end;

            u6.InPostForm = false;
            u3:StopAll();
            u6.AC:Clean();
            u2.States.NoWalk = false;
            u2.States.Ability = false;
            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "Post-Form";
            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = 1;
            u6:ResetCopy();
        end);
        u6.AC:Add(task.delay(5, function() -- Line: 263
            -- upvalues: u6 (copy), u2 (ref), LocalPlayer (ref), u3 (ref)
            if not u6.InPostForm then
                return;
            end;

            if not u2.States.NoWalk then
                return;
            end;

            if not (workspace:GetAttribute("NoAbilityCooldowns") or (LocalPlayer:GetAttribute("NoAbilityCooldowns") or LocalPlayer.Style.Value == "Copycat" and LocalPlayer:GetAttribute("TrueCopycat")) or LocalPlayer.Style.Value == "Thief" and u6.TotalTheft) then
                u6.CDS[1] = tick() + 70;
            end;

            u6.InPostForm = false;
            u3:StopAll();
            u6.AC:Clean();
            u2.States.NoWalk = false;
            u2.States.Ability = false;
            u2.States.AbilitiesUsable = 0;
            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "Post-Form";
            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = 1;
            u6:ResetCopy();
        end));

        return;
    end;

    u6.InPostForm = false;
    u2.States.AbilitiesUsable = 0;

    if (HumanoidRootPart.Position - workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position).Magnitude <= 40 then
        u6.AC:Clean();
        u6.InPostForm = false;
        u2.States.NoWalk = false;
        u2.States.Ability = false;
        u6.BallController:Dunk("GiantHanging", "GiantHanging", true);
        RunService.Heartbeat:Wait();
        LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "Post-Form";
        LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = 1;
        u6:ResetCopy();

        return;
    end;

    RunService.Heartbeat:Wait();
    task.delay(0.5, function() -- Line: 59
        -- upvalues: LocalPlayer (ref)
        LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = 1;
    end);
    task.spawn(function() -- Line: 63
        -- upvalues: TweenService (ref)
        local workspace_CurrentCamera = workspace.CurrentCamera;
        task.delay(0.1, function() -- Line: 65
            -- upvalues: TweenService (ref), workspace_CurrentCamera (copy)
            TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.3), {
                FieldOfView = 30
            }):Play();
        end);
        task.delay(0.6, function() -- Line: 69
            -- upvalues: TweenService (ref), workspace_CurrentCamera (copy)
            TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.3), {
                FieldOfView = 100
            }):Play();
        end);
        task.delay(0.9, function() -- Line: 73
            -- upvalues: TweenService (ref), workspace_CurrentCamera (copy)
            TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.3), {
                FieldOfView = 70
            }):Play();
        end);
    end);
    u2.States.Ability = true;
    u2.States.NoWalk = true;
    LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "Post-Form";
    local u12 = -HumanoidRootPart.CFrame.RightVector;
    u3:StopAll();
    u3:PlayChar("Giant", "Ability1PostHook", Enum.AnimationPriority.Action3);
    u3:PlayBall("Giant", "Ability1PostHookBall", Enum.AnimationPriority.Action3);
    local u13 = 65;
    local u14 = 2;
    local LinearVelocity = Instance.new("LinearVelocity");
    LinearVelocity.MaxForce = (1 / 0);
    LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
    LinearVelocity.Parent = HumanoidRootPart;
    u6.AC:Add(LinearVelocity);
    local u15 = tick();
    u6.AC:Connect(RunService.Heartbeat, function(p16) -- Line: 99
        -- upvalues: u6 (copy), u13 (ref), u15 (copy), u14 (ref), LinearVelocity (copy), u12 (copy), LocalPlayer (ref), HumanoidRootPart (copy)
        u6.InPostForm = false;
        u13 = u13 - p16 * 27;

        if u15 + 0.7 < tick() then
            u14 = u14 - p16 * 5;
            local v17 = u12 + Vector3.new(0, u14, 0);
            local v18 = math.cos(u13) * u13 + 1;
            LinearVelocity.VectorVelocity = v17 * math.abs(v18);
        else
            local v19 = math.cos(u13) * u13 + 1;
            LinearVelocity.VectorVelocity = u12 * math.abs(v19);
        end;

        local Position = workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position;
        HumanoidRootPart.CFrame = CFrame.new(HumanoidRootPart.Position, (Vector3.new(Position.X, HumanoidRootPart.Position.Y, Position.Z)));

        if u13 <= 15 then
            u13 = 15;
        end;
    end);
    u6.AC:Connect(u1.Ability, function() -- Line: 116
        -- upvalues: ReplicatedStorage (ref), u2 (ref), u4 (ref), LocalPlayer (ref), u6 (copy)
        local Value = ReplicatedStorage.Basketball.Value;
        u2.States.Shooting = false;
        u2.States.NoWalk = false;
        Value.CFrame = u4:GetLastCharacterToPossessBall().PlrBall.Anims.BALL.CFrame;
        local Position = Value.Position;
        local _ = (workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position - Position).Magnitude;
        local v20 = workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position - Position;
        local math_log_ret = math.log(2.5 + v20.Magnitude * 0.045);
        Value.AssemblyLinearVelocity = v20 / math_log_ret + Vector3.new(0, workspace.Gravity * math_log_ret * 0.5, 0);
        u6.InPostForm = false;
        task.delay(0.5, function() -- Line: 141
            -- upvalues: u6 (ref)
            u6.AC:Clean();
            u6:ResetCopy();
        end);
        task.delay(1, function() -- Line: 147
            -- upvalues: u2 (ref)
            u2.States.Ability = false;
        end);
    end);
    u6.AC:Add(task.delay(2, function() -- Line: 153
        -- upvalues: u2 (ref), u6 (copy)
        u2.States.Shooting = false;
        u2.States.Ability = false;
        u2.States.NoWalk = false;
        u6.AC:Clean();
        u6:ResetCopy();
    end));
    u1.Ability:Fire("PostForm", {
        Post = true,
        TimeSent = workspace:GetServerTimeNow()
    });
end;