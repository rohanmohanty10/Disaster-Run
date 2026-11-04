 
 

game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("UserInputService");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
local CameraShaker = require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local Abilities = require(ReplicatedStorage.Shared.Tables.Cooldowns).Abilities;
require(ReplicatedStorage.Shared.Functions.CalculateBallTrajectory);
require(ReplicatedStorage.Shared.Utility.Trove);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local LocalPlayer = game.Players.LocalPlayer;
local workspace_CurrentCamera = workspace.CurrentCamera;

return function(u7) -- Line: 25
    -- upvalues: LocalPlayer (copy), u1 (ref), u2 (ref), u3 (ref), u4 (ref), u5 (ref), u6 (ref), Essentials (copy), CameraShaker (copy), ReplicatedStorage (copy), Effects (copy), TweenService (copy), workspace_CurrentCamera (copy), Abilities (copy), RunService (copy)
    local Character = LocalPlayer.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local Humanoid = Character.Humanoid;
    u1 = u7.AbilityService;
    u2 = u7.MovementController;
    u3 = u7.BallController;
    u4 = u7.CameraController;
    u5 = u7.Animations;
    u6 = u7.Network;

    if not u6.CharValues.HasBall then
        u1.Ability:Fire("Liberty", {
            State = "Crown",
            TimeSent = workspace:GetServerTimeNow()
        });
        u5:StopAll();
        u5:PlayChar("KingOfNYC", "LibertyCrown", Enum.AnimationPriority.Action3);
        u2.States.Ability = true;
        u2.States.NoWalk = true;
        u7.AC:Add(function() -- Line: 218
            -- upvalues: u2 (ref)
            u2.States.Ability = false;
            u2.States.NoWalk = false;
        end);
        u7.AC:Add(task.delay(1.5, function() -- Line: 223
            -- upvalues: u7 (copy)
            u7.AC:Clean();
        end));

        return;
    end;

    if not u7.Dribble then
        if u7.MovementController.States.PumpFake then
            u7:ResetCD(4);
            Effects:Popup("Can\'t use after a fake!");

            return;
        end;

        Essentials:ReturnRorL(u6.CharValues);
        u1.Ability:Fire("Liberty", {
            State = "Drive",
            TimeSent = workspace:GetServerTimeNow()
        });
        u5:StopAll();
        u5:PlayChar("KingOfNYC", "LibertyDrive", Enum.AnimationPriority.Action3);
        u5:PlayBall("KingOfNYC", "LibertyDriveBall", Enum.AnimationPriority.Action3);
        u2.States.Ability = true;
        u7.AC:Add(function() -- Line: 130
            -- upvalues: u2 (ref)
            u2.States.Ability = false;
        end);
        local LinearVelocity = Instance.new("LinearVelocity");
        LinearVelocity.ForceLimitMode = Enum.ForceLimitMode.PerAxis;
        LinearVelocity.MaxAxesForce = Vector3.new(20000, 0, 20000);
        LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
        LinearVelocity.Parent = HumanoidRootPart;
        LinearVelocity.VectorVelocity = HumanoidRootPart.CFrame.LookVector * 200;
        TweenService:Create(LinearVelocity, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            VectorVelocity = HumanoidRootPart.CFrame.LookVector * 50
        }):Play();
        task.delay(0.5, function() -- Line: 142
            -- upvalues: LinearVelocity (copy)
            LinearVelocity:Destroy();
        end);
        u4.CamShake:Shake(CameraShaker.Presets.Bump);
        TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            FieldOfView = 90
        }):Play();
        u7.AC:Add(task.delay(0.5, function() -- Line: 149
            -- upvalues: u7 (copy), LocalPlayer (ref), Abilities (ref), u6 (ref), RunService (ref)
            u7.AC:Clean();

            if u7:HoopDist() > 125 then
                u7:ResetCopy();

                return;
            end;

            u7.Dribble = true;
            u7:ResetCD(4);
            local u8 = 1;
            local u9 = false;
            u7.AC:Add(function() -- Line: 165
                -- upvalues: u7 (ref), LocalPlayer (ref), Abilities (ref), u6 (ref)
                task.delay(0.25, function() -- Line: 166
                    -- upvalues: u7 (ref)
                    u7.Dribble = nil;
                    u7:ResetCopy();
                end);

                if not (workspace:GetAttribute("NoAbilityCooldowns") or LocalPlayer:GetAttribute("NoAbilityCooldowns")) then
                    u7.CDS[4] = tick() + Abilities.KingOfNYC[4];
                end;

                LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = 1;

                if u6.CharValues.HasBall then
                    LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "Liberty Drive";

                    return;
                end;

                LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "Liberty Crown";
            end);
            u7.AC:Connect(RunService.Heartbeat, function(p10) -- Line: 184
                -- upvalues: u6 (ref), u7 (ref), LocalPlayer (ref), u8 (ref), u9 (ref)
                if not (u6.CharValues.HasBall and u6.CharValues.InAwakening) then
                    u7.AC:Clean();

                    return;
                end;

                LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = u8;

                if u8 > 0.5 and not u9 then
                    p10 = -p10 or p10;
                end;

                u8 = u8 + p10;

                if u8 <= 0.5 then
                    u9 = true;
                end;

                if u8 >= 1 then
                    u9 = false;
                end;

                LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "Liberty Floater";
            end);
            u7.AC:Add(task.delay(3, function() -- Line: 204
                -- upvalues: u7 (ref)
                u7.Dribble = nil;
                u7:ResetCopy();
                u7.AC:Clean();
            end));
        end));

        return;
    end;

    u7.Dribble = nil;
    u7:ResetCopy();
    u1.Ability:Fire("Liberty", {
        State = "Shot",
        TimeSent = workspace:GetServerTimeNow(),
        CFrame = HumanoidRootPart.CFrame
    });
    u2.States.Ability = true;
    u7.AC:Add(function() -- Line: 46
        -- upvalues: u2 (ref)
        u2.States.Ability = false;
    end);
    u7.AC:Add(task.delay(0.7, function() -- Line: 50
        -- upvalues: u7 (copy)
        u7.AC:Clean();
    end));
    u5:StopAll();
    local v11 = u5:PlayChar("Flash", `Ability2Layup{Essentials:ReturnRorL(u7.Network.CharValues)}`, Enum.AnimationPriority.Action3, true);
    local v12 = u5:PlayBall("Flash", `Ability2Layup{Essentials:ReturnRorL(u7.Network.CharValues)}Ball`, Enum.AnimationPriority.Action3, true);
    v11.TimePosition = 0.5;
    v12.TimePosition = 0.5;
    u4.CamShake:Shake(CameraShaker.Presets.Bump);
    local RaycastParams_new_ret = RaycastParams.new();
    RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
    RaycastParams_new_ret.FilterDescendantsInstances = { Character };
    RaycastParams_new_ret.CollisionGroup = "Player";
    local Position = workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position;
    local v13 = (HumanoidRootPart.Position - Vector3.new(Position.X, HumanoidRootPart.Position.Y, Position.Z)).Unit * 30 + Vector3.new(0, 0.25, 0);
    local v14 = workspace:Raycast(HumanoidRootPart.Position, v13, RaycastParams_new_ret);

    if v14 then
        HumanoidRootPart.CFrame = CFrame.new(HumanoidRootPart.Position + (v14.Position - HumanoidRootPart.Position).Unit * (v14.Distance - 1)) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation());
    else
        HumanoidRootPart.CFrame = CFrame.new(HumanoidRootPart.Position + v13) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation());
    end;

    Humanoid.JumpHeight = 7.2;
    Humanoid:ChangeState(Enum.HumanoidStateType.Jumping);

    for _, child in HumanoidRootPart:GetChildren() do
        if child:IsA("BodyVelocity") or child:IsA("LinearVelocity") then
            child:Destroy();
        end;
    end;

    u7.AC:Connect(u1.Ability, function() -- Line: 89
        -- upvalues: u7 (copy), u4 (ref), CameraShaker (ref), u2 (ref), ReplicatedStorage (ref), u3 (ref), LocalPlayer (ref)
        u7.AC:Clean();
        u4.CamShake:Shake(CameraShaker.Presets.Dunk);
        u2.States.Ability = false;
        local Value = ReplicatedStorage.Basketball.Value;
        Value.CFrame = u3:GetLastCharacterToPossessBall().PlrBall.Anims.BALL.CFrame;
        local Position2 = Value.Position;
        local _ = (workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position - Position2).Magnitude;
        local v15 = workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position - Position2;
        local math_log_ret = math.log(1 + v15.Magnitude * 0.045);
        Value.AssemblyLinearVelocity = v15 / math_log_ret + Vector3.new(0, workspace.Gravity * math_log_ret * 0.5, 0);
    end);
end;