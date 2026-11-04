 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
local CameraShaker = require(ReplicatedStorage.Shared.Utility.CameraShaker);
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

return function(u8) -- Line: 23
    -- upvalues: LocalPlayer (copy), u1 (ref), u2 (ref), u3 (ref), u4 (ref), u5 (ref), u6 (ref), u7 (ref), Effects (copy), RunService (copy), Abilities (copy), Zones (copy), ReplicatedStorage (copy), Players (copy), CameraShaker (copy)
    local Character = LocalPlayer.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local Humanoid = Character.Humanoid;
    u1 = u8.AbilityService;
    u2 = u8.MovementController;
    u3 = u8.BallController;
    u4 = u8.CameraController;
    u5 = u8.Animations;
    u6 = u8.Network;
    u7 = u8.Pass;
    local v9 = "Bounce";

    if u8.Isolation then
        if u2.States.PumpFake then
            u8:ResetCD(2);
            Effects:Popup("Can\'t use after a fake!");

            return;
        end;

        u8.Isolation = nil;
        u8.MagicDrive = true;
        u8:ResetCD(1);
        u8:ResetCD(2);
        u1.Ability:Fire("Luka Illusion", {
            Task = "Magic Drive",
            TimeSent = workspace:GetServerTimeNow()
        });
        u5:StopAll();
        u5:PlayChar("LukaDoncic", "MagicDrive", Enum.AnimationPriority.Action3);
        u5:PlayBall("LukaDoncic", "MagicDriveBall", Enum.AnimationPriority.Action3);
        local u10 = 50;
        local LinearVelocity = Instance.new("LinearVelocity");
        LinearVelocity.ForceLimitMode = Enum.ForceLimitMode.PerAxis;
        LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
        LinearVelocity.MaxAxesForce = Vector3.new(inf, 0, inf);
        LinearVelocity.VectorVelocity = Vector3.new(0, 0, 0);
        LinearVelocity.Parent = HumanoidRootPart;
        u8.AC:Add(LinearVelocity);
        local RaycastParams_new_ret = RaycastParams.new();
        RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
        RaycastParams_new_ret.FilterDescendantsInstances = { Character };
        u8.AC:Connect(RunService.Heartbeat, function() -- Line: 72
            -- upvalues: HumanoidRootPart (copy), RaycastParams_new_ret (copy), LinearVelocity (copy), u10 (ref)
            local v11 = workspace:Raycast(HumanoidRootPart.Position, HumanoidRootPart.CFrame.LookVector * 4, RaycastParams_new_ret);

            if v11 and not v11.Instance.Parent:FindFirstChild("Humanoid") then
                LinearVelocity.VectorVelocity = Vector3.new(0, 0, 0);

                return;
            end;

            LinearVelocity.VectorVelocity = HumanoidRootPart.CFrame.LookVector * Vector3.new(1, 0, 1) * u10;
        end);
        task.spawn(function() -- Line: 81
            -- upvalues: u10 (ref), LinearVelocity (copy)
            task.wait(0.4);
            u10 = 100;
            task.wait(0.2833333333333333);
            u10 = 50;
            task.wait(0.4166666666666667);

            if LinearVelocity then
                LinearVelocity:Destroy();
            end;
        end);
        u2.States.Ability = true;
        u2.States.AbilitiesUsable = -1;
        u8.AC:Add(function() -- Line: 95
            -- upvalues: LocalPlayer (ref), u8 (copy), Abilities (ref), u5 (ref), u2 (ref)
            if not (workspace:GetAttribute("NoAbilityCooldowns") or (LocalPlayer:GetAttribute("NoAbilityCooldowns") or LocalPlayer.Style.Value == "Copycat" and LocalPlayer:GetAttribute("TrueCopycat")) or LocalPlayer.Style.Value == "Thief" and u8.TotalTheft) then
                u8.CDS[1] = tick() + Abilities.LukaDoncic[1];
                u8.CDS[2] = u8.SecCooldown;
            end;

            u8.SecCooldown = nil;
            u8.Isolation = nil;
            task.delay(0.25, function() -- Line: 103
                -- upvalues: u8 (ref)
                u8.MagicDrive = nil;
            end);
            u5:StopAll();
            u2.States.Ability = false;
            u2.States.AbilitiesUsable = 0;
            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "Isolation";
            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.AbilityName.Text = "Luka Illusion";
            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = 1;
            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.Flash.BackgroundTransparency = 1;
        end);
        local u12 = 1;
        local u13 = false;
        u8.AC:Connect(RunService.Heartbeat, function(p14) -- Line: 122
            -- upvalues: u6 (ref), LocalPlayer (ref), u12 (ref), u13 (ref)
            if not u6.CharValues.HasBall then
                LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = 1;
                LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.Flash.BackgroundTransparency = 1;

                return;
            end;

            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = u12;
            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.Flash.BackgroundTransparency = u12;

            if u12 > 0.5 and not u13 then
                p14 = -p14 or p14;
            end;

            u12 = u12 + p14;

            if u12 <= 0.5 then
                u13 = true;
            end;

            if u12 >= 1 then
                u13 = false;
            end;

            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "Floater";
            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.AbilityName.Text = "Magic Sneak Pass";
        end);
        u8.AC:Add(task.delay(2, function() -- Line: 145
            -- upvalues: u8 (copy)
            u8.AC:Clean();
        end));

        return;
    end;

    if u8.MagicDrive then
        u8.MagicDrive = nil;
        u8.SecCooldown = nil;
        u2.States.AbilitiesUsable = 0;
        LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "Isolation";
        LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.AbilityName.Text = "Luka Illusion";
        LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = 1;
        LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.Flash.BackgroundTransparency = 1;
        v9 = "Sneak";
        local u15 = 30;
        local u16 = (Zones.JumpHeight[LocalPlayer.Zone.Value] and (u6.CharValues.InZone and Zones.JumpHeight[LocalPlayer.Zone.Value]) or 7.2) / 7.2;
        local BodyVelocity = Instance.new("BodyVelocity");
        BodyVelocity.Name = "BodyVelocityBasketball";
        BodyVelocity.Parent = HumanoidRootPart;
        BodyVelocity.MaxForce = Vector3.new(inf, inf, inf);
        local u17 = tick();
        local u19 = RunService.Heartbeat:Connect(function(p18) -- Line: 174
            -- upvalues: u15 (ref), u17 (copy), BodyVelocity (copy), HumanoidRootPart (copy), u16 (ref)
            if u15 >= 10 then
                if u17 + 0.125 < tick() then
                    BodyVelocity.Velocity = (HumanoidRootPart.CFrame.LookVector + Vector3.new(0, u16, 0)) * u15;
                    u16 = u16 - p18 * 1.75;
                else
                    BodyVelocity.Velocity = (HumanoidRootPart.CFrame.LookVector + Vector3.new(0, 0, 0)) * u15;
                end;

                u15 = u15 - p18;
            end;
        end);
        task.delay(0.43333333333333335, function() -- Line: 186
            -- upvalues: u19 (ref), BodyVelocity (copy)
            if u19 then
                u19:Disconnect();
            end;

            BodyVelocity:Destroy();
        end);
    elseif not u8.LukaIllusion then
        if ReplicatedStorage.Cooldowns.LukaIllusionCD.Value > workspace:GetServerTimeNow() then
            u8:ResetCD(2);
            local v20 = ReplicatedStorage.Cooldowns.LukaIllusionCD.Value - workspace:GetServerTimeNow();
            Effects:Popup(`Ability is on global cooldown! Ready in {math.round(v20)} seconds`, 2);

            return;
        end;

        u8.LukaIllusion = true;

        if math.abs(HumanoidRootPart.Position.X - workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position.X) > 145 then
            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.AbilityName.Text = "Magic Full Pass";
        else
            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.AbilityName.Text = "Magic Bounce Pass";
        end;

        u8:ResetCD(2);
        u1.Ability:Fire("Luka Illusion", {
            Task = "Luka Illusion",
            TimeSent = workspace:GetServerTimeNow(),
            WalkSpeed = Humanoid.WalkSpeed
        });
        u2.States.Ability = true;
        u2.States.AbilitiesUsable = 2;
        u8.AC:Add(function() -- Line: 215
            -- upvalues: u8 (copy), Abilities (ref), u2 (ref), LocalPlayer (ref)
            u8.CDS[2] = tick() + Abilities.LukaDoncic[2];
            task.delay(0.25, function() -- Line: 218
                -- upvalues: u8 (ref)
                u8.LukaIllusion = nil;
            end);
            u2.States.Ability = false;
            u2.States.AbilitiesUsable = 0;
            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.AbilityName.Text = "Luka Illusion";
            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.Flash.BackgroundTransparency = 1;
        end);
        local u21 = 1;
        local u22 = false;
        u8.AC:Connect(RunService.Heartbeat, function(p23) -- Line: 232
            -- upvalues: u6 (ref), LocalPlayer (ref), u21 (ref), u22 (ref), HumanoidRootPart (copy)
            if not u6.CharValues.HasBall then
                LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.Flash.BackgroundTransparency = 1;

                return;
            end;

            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.Flash.BackgroundTransparency = u21;

            if u21 > 0.5 and not u22 then
                p23 = -p23 or p23;
            end;

            u21 = u21 + p23;

            if u21 <= 0.5 then
                u22 = true;
            end;

            if u21 >= 1 then
                u22 = false;
            end;

            if math.abs(HumanoidRootPart.Position.X - workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position.X) > 145 then
                LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.AbilityName.Text = "Magic Full Pass";

                return;
            end;

            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.AbilityName.Text = "Magic Bounce Pass";
        end);
        u8.AC:Add(task.delay(3, function() -- Line: 256
            -- upvalues: u8 (copy)
            u8.LukaIllusion = nil;
            u8.AC:Clean();
        end));

        return;
    end;

    local LookingAt = u7.LookingAt;
    local PlayerFromCharacter = Players:GetPlayerFromCharacter(LookingAt);

    if RunService:IsStudio() then
        LookingAt = workspace:WaitForChild("DefenseRig");
    elseif LookingAt == nil or PlayerFromCharacter ~= nil and PlayerFromCharacter.Team ~= LocalPlayer.Team then
        local v24 = nil;

        for _, v in LocalPlayer.Team:GetPlayers() do
            if v.Character and (v.Character:FindFirstChild("HumanoidRootPart") and (v.Team == LocalPlayer.Team and v ~= LocalPlayer)) then
                if not v24 or (v.Character.HumanoidRootPart.Position - HumanoidRootPart.Position).Magnitude < v24 then
                    LookingAt = v.Character;
                end;

                break;
            end;
        end;
    end;

    if not LookingAt then
        Effects:Popup("No teammates to pass to!");

        return;
    end;

    local HumanoidRootPart2 = LookingAt.HumanoidRootPart;
    local u25 = v9 == "Bounce" and math.abs(HumanoidRootPart.Position.X - workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position.X) > 145 and "Full" or v9;
    u2.States.Ability = true;
    u2.States.NoWalk = true;
    task.delay(1, function() -- Line: 303
        -- upvalues: u2 (ref)
        u2.States.Ability = false;
        u2.States.NoWalk = false;
    end);
    u5:StopAll();
    u5:PlayChar("LukaDoncic", `Magic{u25}Pass`, Enum.AnimationPriority.Action3);
    u5:PlayBall("LukaDoncic", `Magic{u25}PassBall`, Enum.AnimationPriority.Action3);
    u1.Ability:Fire("Luka Illusion", {
        Task = "Pass",
        TimeSent = workspace:GetServerTimeNow(),
        PassType = u25,
        PassingTo = LookingAt
    });
    u8.AC:Connect(u1.Ability, function() -- Line: 314
        -- upvalues: u4 (ref), CameraShaker (ref), ReplicatedStorage (ref), u3 (ref), Character (copy), HumanoidRootPart2 (copy), u25 (ref), u8 (copy), RunService (ref), u6 (ref), Zones (ref), LocalPlayer (ref)
        u4.CamShake:Shake(CameraShaker.Presets.Dunk);
        local Value = ReplicatedStorage.Basketball.Value;
        Value.CFrame = (u3:GetLastCharacterToPossessBall() or Character).PlrBall.Anims.BALL.CFrame;
        local Position = Value.Position;
        local Position2 = HumanoidRootPart2.Position;
        local Unit = (Position2 - Position).Unit;
        local Magnitude = (Position2 - Position).Magnitude;
        local u26 = u25 == "Full" and 300 or 150;
        Value.AssemblyLinearVelocity = (Unit + Vector3.new(0, 0.62, 0)) * Magnitude;
        local LinearVelocity = Instance.new("LinearVelocity", Value);
        LinearVelocity.Attachment0 = Value.Root;
        LinearVelocity.MaxForce = 40000;
        LinearVelocity.VectorVelocity = (Unit + Vector3.new(0, 0.62, 0)) * Magnitude;
        u8.AC:Add(LinearVelocity);
        local u27 = tick();
        local u28 = nil;
        local u29 = nil;
        task.delay(0.15, function() -- Line: 340
            -- upvalues: u29 (ref), RunService (ref), u3 (ref), LinearVelocity (copy), HumanoidRootPart2 (ref), u28 (ref), u27 (copy), Value (copy), u25 (ref), u6 (ref), Zones (ref), LocalPlayer (ref), u26 (copy)
            u29 = RunService.Heartbeat:Connect(function(p30) -- Line: 341
                -- upvalues: u3 (ref), u29 (ref), LinearVelocity (ref), HumanoidRootPart2 (ref), u28 (ref), u27 (ref), Value (ref), u25 (ref), u6 (ref), Zones (ref), LocalPlayer (ref), u26 (ref)
                if u3:GetPlayerPossessingBall() then
                    u29:Disconnect();
                    LinearVelocity:Destroy();

                    return;
                end;

                local ServerBallPosition = u3:GetServerBallPosition();

                if ServerBallPosition.Y <= 2 then
                    u28 = true;
                end;

                if (HumanoidRootPart2.Position - ServerBallPosition).Magnitude <= 10 then
                    u29:Disconnect();
                    LinearVelocity:Destroy();

                    return;
                end;

                if u27 + 1.5 < tick() or not Value.Parent then
                    u29:Disconnect();
                    LinearVelocity:Destroy();
                    Value.AssemblyLinearVelocity = LinearVelocity.VectorVelocity;

                    return;
                end;

                local Unit2 = (HumanoidRootPart2.Position - ServerBallPosition).Unit;
                local v31 = 1;

                if u25 == "Bounce" and not u28 then
                    Unit2 = (Vector3.new(HumanoidRootPart2.Position.X, 0, HumanoidRootPart2.Position.Z) - ServerBallPosition).Unit;
                end;

                if u6.CharValues.InZone and Zones.ZoneIncreasedPassingSpeed[LocalPlayer.Zone.Value] then
                    v31 = v31 + Zones.ZoneIncreasedPassingSpeed[LocalPlayer.Zone.Value];
                end;

                LinearVelocity.VectorVelocity = Unit2 * u26 * v31;
            end);
        end);
    end);
end;