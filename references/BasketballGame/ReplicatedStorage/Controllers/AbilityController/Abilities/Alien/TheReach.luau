 
 

game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
require(ReplicatedStorage.Shared.Functions.CalculateBallTrajectory);
local Abilities = require(ReplicatedStorage.Shared.Tables.Cooldowns).Abilities;
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local LocalPlayer = game.Players.LocalPlayer;

return function(u6) -- Line: 21
    -- upvalues: LocalPlayer (copy), u1 (ref), u2 (ref), u3 (ref), u4 (ref), u5 (ref), Effects (copy), RunService (copy), Essentials (copy), TweenService (copy), Abilities (copy), ReplicatedStorage (copy)
    local Character = LocalPlayer.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local _ = Character.Humanoid;
    u1 = u6.AbilityService;
    u2 = u6.MovementController;
    u3 = u6.BallController;
    u4 = u6.Animations;
    u5 = u6.Network;

    if not u5.CharValues.HasBall then
        if Character:GetAttribute("Nutmeg") then
            u6:ResetCD(2);

            return;
        end;

        if ReplicatedStorage.Cooldowns.TheReachCD.Value > workspace:GetServerTimeNow() then
            u6:ResetCD(2);
            local v7 = ReplicatedStorage.Cooldowns.TheReachCD.Value - workspace:GetServerTimeNow();
            Effects:Popup(`Ability is on global cooldown! Ready in {math.round(v7)} seconds`, 2);

            return;
        end;

        u1.Ability:Fire("The Reach", {
            State = "Reach",
            TimeSent = workspace:GetServerTimeNow()
        });
        Effects:Popup("The Reach activated.");
        u6.AC:Add(function() -- Line: 247
            -- upvalues: Effects (ref)
            Effects:Popup("Ability ended.");
        end);
        u6.AC:Connect(u6.AbilityService.Ability, function() -- Line: 251
            -- upvalues: u6 (copy), u4 (ref)
            u6.AC:Clean();
            u4:StopAll();
            u4:PlayChar("Blocks", "Blocked", Enum.AnimationPriority.Action3);
        end);
        u6.AC:Connect(RunService.Heartbeat, function() -- Line: 258
            -- upvalues: u5 (ref), u6 (copy)
            if u5.CharValues.HasBall then
                u6.AC:Clean();
            end;
        end);
        u6.AC:Add(task.delay(15, function() -- Line: 264
            -- upvalues: u6 (copy)
            u6.AC:Clean();
        end));

        return;
    end;

    if not u6.InDominance then
        local v8 = u6:CheckInfront(50);

        if u2.States.PumpFake then
            Effects:Popup("Can\'t use after a fake!");
            u6:ResetCD(2);

            return;
        end;

        if u6:HoopDist() > 85 then
            Effects:Popup("Need to be closer to hoop!");
            u6:ResetCD(2);

            return;
        end;

        if u6:HoopDist() < 30 then
            Effects:Popup("Too close to the hoop!");
            u6:ResetCD(2);

            return;
        end;

        u6.InDominance = true;
        u6.WasInAwakening = u5.CharValues.InAwakening;
        u6.FirstCooldown = u6.Dribble and tick() + Abilities.Alien[1] or (u5.CharValues.InAwakening and u6.CDS[4] or u6.CDS[1]);
        u6:ResetCD(u5.CharValues.InAwakening and 4 or 1);
        u6:ResetCD(2);
        u6.AC:Add(task.delay(0.25, function() -- Line: 135
            -- upvalues: u2 (ref), u6 (copy)
            if not u2.States.NoWalk then
                return;
            end;

            u6:ResetCD(2);
        end));
        u2.States.Ability = true;
        u2.States.NoWalk = true;
        u2.States.AbilitiesUsable = -1;
        u4:StopAll();
        u4:PlayChar("Alien", "Dominance", Enum.AnimationPriority.Action3);
        u4:PlayBall("Alien", "DominanceBall", Enum.AnimationPriority.Action3);
        u1.Ability:Fire("The Reach", {
            State = "Dominance",
            TimeSent = workspace:GetServerTimeNow(),
            Other = v8
        });
        local u9 = nil;
        task.delay(6, function() -- Line: 151
            -- upvalues: u9 (ref)
            u9 = true;
        end);
        local u10 = 1;
        local u11 = false;
        local u12 = nil;
        local u13 = nil;

        local function End() -- Line: 161
            -- upvalues: u6 (copy), LocalPlayer (ref), u5 (ref), Abilities (ref), u12 (ref), u13 (ref), u4 (ref), u2 (ref)
            u6.AC:Clean();

            if not (workspace:GetAttribute("NoAbilityCooldowns") or (LocalPlayer:GetAttribute("NoAbilityCooldowns") or LocalPlayer.Style.Value == "Copycat" and LocalPlayer:GetAttribute("TrueCopycat")) or LocalPlayer.Style.Value == "Thief" and u6.TotalTheft) then
                if u6.FirstCooldown then
                    if u5.CharValues.InAwakening then
                        u6.CDS[4] = u6.FirstCooldown;
                    elseif not u6.WasInAwakening then
                        u6.CDS[1] = u6.FirstCooldown;
                    end;
                end;

                u6.CDS[2] = tick() + Abilities.Alien[2];
            end;

            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = 1;
            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.Flash.BackgroundTransparency = 1;
            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "Alien Dribble";

            if u5.CharValues.HasBall then
                LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.AbilityName.Text = "Dominance";
            else
                LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.AbilityName.Text = "The Reach";
            end;

            u12:Disconnect();
            u13:Disconnect();

            if u6.InDominance then
                u6.InDominance = nil;
                u4:StopAll();
                u2.States.Ability = false;
                u2.States.NoWalk = false;
            end;

            u2.States.AbilitiesUsable = 0;
        end;

        u12 = RunService.Heartbeat:Connect(function(p14) -- Line: 201
            -- upvalues: u6 (copy), u9 (ref), End (copy), u5 (ref), LocalPlayer (ref), u10 (ref), u11 (ref)
            if not u6.InDominance or u9 then
                End();

                return;
            end;

            if not u5.CharValues.HasBall then
                End();

                return;
            end;

            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = u10;
            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.Flash.BackgroundTransparency = u10;

            if u10 > 0.5 and not u11 then
                p14 = -p14 or p14;
            end;

            u10 = u10 + p14;

            if u10 <= 0.5 then
                u11 = true;
            end;

            if u10 >= 1 then
                u11 = false;
            end;

            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "Layup";
            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.AbilityName.Text = "Hop Step";
        end);
        u13 = u1.Ability:Connect(function() -- Line: 228
            -- upvalues: End (copy)
            End();
        end);

        return;
    end;

    if u6:HoopDist() > 65 then
        Effects:Popup("Too far away from hoop!");
        u6:ResetCD(2);

        return;
    end;

    if u6.FirstCooldown then
        if u5.CharValues.InAwakening then
            u6.CDS[4] = u6.FirstCooldown;
        elseif not u6.WasInAwakening then
            u6.CDS[1] = u6.FirstCooldown;
        end;
    end;

    u6.InDominance = nil;
    u6.FirstCooldown = nil;
    u2.States.AbilitiesUsable = 0;
    LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "Alien Dribble";
    LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.AbilityName.Text = "Dominance";
    LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = 1;
    LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.Flash.BackgroundTransparency = 1;
    u1.Ability:Fire("The Reach", {
        State = "Dunk",
        TimeSent = workspace:GetServerTimeNow()
    });
    u4:StopAll();
    u4:PlayChar("Alien", "Dunk", Enum.AnimationPriority.Action3);
    u4:PlayBall("Alien", "DunkBall", Enum.AnimationPriority.Action3);

    if Character:FindFirstChild(script.Name .. "AlignPosition") then
        Character:FindFirstChild(script.Name .. "AlignPosition"):Destroy();
    end;

    local FieldOfView = workspace.CurrentCamera.FieldOfView;
    local u16 = RunService.Heartbeat:Connect(function(p15) -- Line: 71
        -- upvalues: FieldOfView (ref), Essentials (ref), HumanoidRootPart (copy)
        FieldOfView = Essentials:Lerp(FieldOfView, 45 + HumanoidRootPart.AssemblyLinearVelocity.Magnitude, p15 * 4);
        workspace.CurrentCamera.FieldOfView = FieldOfView;
    end);
    task.delay(1.2, function() -- Line: 76
        -- upvalues: u16 (copy), u2 (ref)
        u16:Disconnect();
        u2.States.Ability = false;
        u2.States.NoWalk = false;
    end);
    u2.States.Boost = 10;
    task.wait(0.2);
    u2.States.Boost = 0;
    local Position = workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position;
    local Unit = (Vector3.new(Position.X, HumanoidRootPart.Position.Y, Position.Z) - HumanoidRootPart.Position).Unit;
    local LinearVelocity = Instance.new("LinearVelocity");
    LinearVelocity.MaxForce = (1 / 0);
    LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
    LinearVelocity.Parent = HumanoidRootPart;
    LinearVelocity.VectorVelocity = (Unit + Vector3.new(0, 1, 0)) * 100;
    TweenService:Create(LinearVelocity, TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        VectorVelocity = Unit * 50
    }):Play();
    task.delay(0.2, function() -- Line: 99
        -- upvalues: LinearVelocity (copy)
        LinearVelocity:Destroy();
    end);
end;