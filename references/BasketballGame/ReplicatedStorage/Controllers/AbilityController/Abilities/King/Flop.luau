 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
local CameraShaker = require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
require(ReplicatedStorage.Shared.Utility.Essentials);
local Zones = require(ReplicatedStorage.Shared.Tables.Zones);
require(ReplicatedStorage.Shared.Utility.Trove);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = nil;
local LocalPlayer = game.Players.LocalPlayer;

return function(u8) -- Line: 23
    -- upvalues: LocalPlayer (copy), u1 (ref), u2 (ref), u3 (ref), u4 (ref), u5 (ref), u6 (ref), u7 (ref), Players (copy), RunService (copy), Effects (copy), TweenService (copy), ReplicatedStorage (copy), CameraShaker (copy), Zones (copy)
    local Character = LocalPlayer.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local _ = Character.Humanoid;
    u1 = u8.AbilityService;
    u2 = u8.MovementController;
    u3 = u8.CameraController;
    u4 = u8.BallController;
    u5 = u8.Animations;
    u6 = u8.Network;
    u7 = u8.Pass;

    if not u6.CharValues.HasBall then
        if ReplicatedStorage.Cooldowns.FlopCD.Value > workspace:GetServerTimeNow() then
            u8:ResetCD(1);
            local v9 = ReplicatedStorage.Cooldowns.FlopCD.Value - workspace:GetServerTimeNow();
            Effects:Popup(`Ability is on global cooldown! Ready in {math.round(v9)} seconds`, 2);

            return;
        end;

        local CharacterPossessingBall = u4:GetCharacterPossessingBall();
        local PlayerPossessingBall = u4:GetPlayerPossessingBall();

        if not CharacterPossessingBall then
            u8:ResetCD(1);
            Effects:Popup("Ball must be on enemy player!");

            return;
        end;

        if not PlayerPossessingBall then
            u8:ResetCD(1);
            Effects:Popup("Ball must be on enemy player!");

            return;
        end;

        if PlayerPossessingBall.Team == LocalPlayer.Team then
            u8:ResetCD(1);
            Effects:Popup("Ball must be on enemy player!");

            return;
        end;

        u1.Ability:Fire("Flop", {
            Task = "Flop",
            TimeSent = workspace:GetServerTimeNow()
        });
        Effects:Popup("Collision with enemy holding the ball calls a foul! You get the ball as long as they aren\'t moving away from you.");
        u8.AC:Connect(RunService.Heartbeat, function() -- Line: 228
            -- upvalues: u6 (ref), u8 (copy)
            if u6.CharValues.HasBall then
                u8.AC:Clean();
            end;
        end);
        u8.AC:Add(function() -- Line: 234
            -- upvalues: Effects (ref)
            Effects:Popup("Ability ended.");
        end);
        u8.AC:Connect(u1.Ability, function(p10) -- Line: 238
            -- upvalues: u8 (copy), u2 (ref)
            u8.AC:Clean();

            if p10 and p10.Charge then
                u2.States.NoWalk = true;
                u2.States.Ability = true;
                task.delay(2.5833333333333335, function() -- Line: 245
                    -- upvalues: u2 (ref)
                    u2.States.NoWalk = false;
                    u2.States.Ability = false;
                end);
            end;
        end);
        u8.AC:Add(task.delay(5, function() -- Line: 252
            -- upvalues: u8 (copy)
            u8.AC:Clean();
        end));

        return;
    end;

    local LookingAt = u7.LookingAt;
    local PlayerFromCharacter = Players:GetPlayerFromCharacter(LookingAt);

    if RunService:IsStudio() then
        LookingAt = workspace:WaitForChild("DefenseRig");
    elseif LookingAt == nil or PlayerFromCharacter ~= nil and PlayerFromCharacter.Team ~= LocalPlayer.Team then
        local v11 = nil;

        for _, v in LocalPlayer.Team:GetPlayers() do
            if v.Character and (v.Character:FindFirstChild("HumanoidRootPart") and (v.Team == LocalPlayer.Team and v ~= LocalPlayer)) then
                if not v11 or (v.Character.HumanoidRootPart.Position - HumanoidRootPart.Position).Magnitude < v11 then
                    LookingAt = v.Character;
                end;

                break;
            end;
        end;
    end;

    if not LookingAt then
        Effects:Popup("No teammates to pass to!");
        u8:ResetCD(1);

        return;
    end;

    local HumanoidRootPart2 = LookingAt.HumanoidRootPart;
    u2.States.NoWalk = true;
    u2.States.Ability = true;
    task.delay(2, function() -- Line: 74
        -- upvalues: u2 (ref)
        u2.States.NoWalk = false;
        u2.States.Ability = false;
    end);
    u5:StopAll();
    u5:PlayChar("King", "NoLookPassDribble", Enum.AnimationPriority.Action3);
    u5:PlayBall("King", "NoLookPassDribbleBall", Enum.AnimationPriority.Action3);
    u1.Ability:Fire("Flop", {
        Task = "No Look Pass",
        TimeSent = workspace:GetServerTimeNow(),
        PassingTo = LookingAt
    });
    local LinearVelocity = Instance.new("LinearVelocity");
    LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
    LinearVelocity.MaxForce = (1 / 0);
    LinearVelocity.Parent = HumanoidRootPart;
    u8.AC:Add(LinearVelocity);
    LinearVelocity.VectorVelocity = HumanoidRootPart.CFrame.LookVector * -50;
    TweenService:Create(LinearVelocity, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
        VectorVelocity = HumanoidRootPart.CFrame.LookVector * -15
    }):Play();
    task.delay(0.75, function() -- Line: 95
        -- upvalues: LinearVelocity (copy)
        LinearVelocity:Destroy();
    end);
    task.wait(0.95);
    local v12 = HumanoidRootPart.CFrame:ToObjectSpace(HumanoidRootPart2.CFrame).Position.X > 0 and "R" or "L";
    u5:PlayChar("King", `NoLookPass{v12}`, Enum.AnimationPriority.Action3);
    u5:PlayBall("King", `NoLookPass{v12}Ball`, Enum.AnimationPriority.Action3);
    u8.AC:Connect(u1.Ability, function(p13) -- Line: 111
        -- upvalues: u8 (copy), ReplicatedStorage (ref), u4 (ref), Character (copy), LocalPlayer (ref), Effects (ref), u3 (ref), CameraShaker (ref), HumanoidRootPart2 (copy), RunService (ref), u6 (ref), Zones (ref)
        if not p13 then
            return;
        end;

        if not p13.Shoot then
            if p13.Pass then
                u3.CamShake:Shake(CameraShaker.Presets.Dunk);
                local Value = ReplicatedStorage.Basketball.Value;
                Value.CFrame = (u4:GetLastCharacterToPossessBall() or Character).PlrBall.Anims.BALL.CFrame;
                local Unit = (HumanoidRootPart2.Position - Value.Position).Unit;
                Value.AssemblyLinearVelocity = Unit * 300;
                local LinearVelocity2 = Instance.new("LinearVelocity", Value);
                LinearVelocity2.Attachment0 = Value.Root;
                LinearVelocity2.MaxForce = 40000;
                LinearVelocity2.VectorVelocity = Unit * 300;
                u8.AC:Add(LinearVelocity2);
                local u14 = tick();
                local u15 = nil;
                u15 = RunService.Heartbeat:Connect(function(p16) -- Line: 162
                    -- upvalues: u4 (ref), u15 (ref), LinearVelocity2 (copy), HumanoidRootPart2 (ref), u14 (copy), Value (copy), u6 (ref), Zones (ref), LocalPlayer (ref)
                    if u4:GetPlayerPossessingBall() then
                        u15:Disconnect();
                        LinearVelocity2:Destroy();

                        return;
                    end;

                    local ServerBallPosition = u4:GetServerBallPosition();

                    if (HumanoidRootPart2.Position - ServerBallPosition).Magnitude <= 10 then
                        u15:Disconnect();
                        LinearVelocity2:Destroy();

                        return;
                    end;

                    if u14 + 1.5 < tick() or not Value.Parent then
                        u15:Disconnect();
                        LinearVelocity2:Destroy();
                        Value.AssemblyLinearVelocity = LinearVelocity2.VectorVelocity;

                        return;
                    end;

                    local v17 = 1;

                    if u6.CharValues.InZone and Zones.ZoneIncreasedPassingSpeed[LocalPlayer.Zone.Value] then
                        v17 = v17 + Zones.ZoneIncreasedPassingSpeed[LocalPlayer.Zone.Value];
                    end;

                    LinearVelocity2.VectorVelocity = (HumanoidRootPart2.Position - ServerBallPosition).Unit * 300 * v17;
                end);
            end;

            return;
        end;

        u8.AC:Clean();
        local Value = ReplicatedStorage.Basketball.Value;
        u4:GetLastCharacterToPossessBall();
        Value.CFrame = (u4:GetLastCharacterToPossessBall() or Character).PlrBall.Anims.BALL.CFrame;
        local Position = Value.Position;
        local _ = (workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position - Position).Magnitude;
        local v18 = workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position - Position;

        if not p13.Guaranteed then
            Effects:Popup("80% Chance to go in!");

            if math.random(1, 100) > 80 then
                v18 = workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position + Vector3.new(4, -5, 4) - Position;
            end;
        end;

        local math_log_ret = math.log(2.5 + v18.Magnitude * 0.045);
        Value.AssemblyLinearVelocity = v18 / math_log_ret + Vector3.new(0, workspace.Gravity * math_log_ret * 0.5, 0);
    end);
end;