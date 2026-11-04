 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local LocalPlayer = game.Players.LocalPlayer;

return function(u7) -- Line: 22, Name: EmperorsDefense
    -- upvalues: LocalPlayer (copy), u1 (ref), u3 (ref), u4 (ref), u2 (ref), u5 (ref), u6 (ref), Effects (copy), Essentials (copy), TweenService (copy), ReplicatedStorage (copy), RunService (copy)
    local HumanoidRootPart = LocalPlayer.Character.HumanoidRootPart;
    u1 = u7.AbilityService;
    u3 = u7.Animations;
    u4 = u7.BallController;
    u2 = u7.MovementController;
    u5 = u7.CameraController;
    u6 = u7.Pass;

    if u7.UltimatePass then
        require(script.Parent.EmperorDribble)(u7);
        u7:ResetCD(4);

        return;
    end;

    if not u7.EmperorsDefense then
        if u7.Network.CharValues.HasBall then
            u7:ResetCD(4);
            Effects:Popup("Not usable with ball!");

            return;
        end;

        if u7.Network.CharValues.Blocked + 2 > tick() then
            u7:ResetCD(4);
            Effects:Popup("Can\'t use after block!");

            return;
        end;

        u1.Ability:Fire("EmperorsDefense", {
            TimeSent = workspace:GetServerTimeNow()
        });
        Effects:Popup("Emperor\'s Defense activated.");
        u7.AC:Connect(u7.AbilityService.Ability, function() -- Line: 120
            -- upvalues: u7 (copy), u2 (ref), u3 (ref), RunService (ref), LocalPlayer (ref), HumanoidRootPart (copy)
            u7.AC:Clean();
            u2.States.Ability = true;
            u2.States.NoWalk = true;
            task.delay(1.0166666666666666, function() -- Line: 125
                -- upvalues: u2 (ref)
                u2.States.Ability = false;
                u2.States.NoWalk = false;
            end);
            task.wait(0.5);
            u3:StopAll();
            u3:PlayChar("Emperor", "EmperorsDefenseBlock", Enum.AnimationPriority.Action4);
            u3:PlayBall("Emperor", "EmperorsDefenseBlockBall", Enum.AnimationPriority.Action4);
            u7.EmperorsDefense = true;
            u7:ResetCD(4);
            local u8 = 1;
            local u9 = false;
            local u10 = nil;
            u10 = RunService.Heartbeat:Connect(function(p11) -- Line: 143
                -- upvalues: u7 (ref), u10 (ref), LocalPlayer (ref), HumanoidRootPart (ref), u8 (ref), u9 (ref)
                if not u7.EmperorsDefense then
                    u10:Disconnect();
                    LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = 1;

                    return;
                end;

                if not u7.Network.CharValues.InAwakening then
                    if u7.EmperorsDefense then
                        if u7.FirstCooldown then
                            u7.CDS[1] = u7.FirstCooldown;
                        end;

                        if not (workspace:GetAttribute("NoAbilityCooldowns") or (LocalPlayer:GetAttribute("NoAbilityCooldowns") or LocalPlayer.Style.Value == "Copycat" and LocalPlayer:GetAttribute("TrueCopycat")) or LocalPlayer.Style.Value == "Thief" and u7.TotalTheft) then
                            u7.CDS[4] = tick() + 115;
                        end;
                    end;

                    u7.EmperorsDefense = nil;
                    u7:ResetCopy();

                    return;
                end;

                local _ = (HumanoidRootPart.Position - workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position).Magnitude;
                LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = u8;

                if u8 > 0.5 and not u9 then
                    p11 = -p11 or p11;
                end;

                u8 = u8 + p11;

                if u8 <= 0.5 then
                    u9 = true;
                end;

                if u8 >= 1 then
                    u9 = false;
                end;

                LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "Emperor\'s Nutmeg";
            end);
            task.delay(4, function() -- Line: 174
                -- upvalues: u7 (ref), LocalPlayer (ref), u10 (ref)
                if not (not u7.EmperorsDefense or (workspace:GetAttribute("NoAbilityCooldowns") or (LocalPlayer:GetAttribute("NoAbilityCooldowns") or LocalPlayer.Style.Value == "Copycat" and LocalPlayer:GetAttribute("TrueCopycat"))) or LocalPlayer.Style.Value == "Thief" and u7.TotalTheft) then
                    u7.CDS[4] = tick() + 115;
                end;

                u7.EmperorsDefense = nil;
                LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = 1;
                u10:Disconnect();
                u7:ResetCopy();
            end);
        end);
        u7.AC:Connect(RunService.Heartbeat, function() -- Line: 187
            -- upvalues: u7 (copy)
            if u7.Network.CharValues.HasBall then
                u7.AC:Clean();
            end;
        end);
        u7.AC:Add(function() -- Line: 193
            -- upvalues: Effects (ref)
            Effects:Popup("Ability ended.");
        end);
        u7.AC:Add(task.delay(15, function() -- Line: 197
            -- upvalues: u7 (copy)
            u7.AC:Clean();
        end));

        return;
    end;

    if not u7.Network.CharValues.HasBall then
        Effects:Popup("Not usable without ball!");
        u7:ResetCD(4);

        return;
    end;

    local v12 = u7:CheckInfront(25);

    if not v12 then
        u7:ResetCD(4);
        Effects:Popup("Someone must be infront of you!");

        return;
    end;

    u7.EmperorsDefense = nil;
    u7:ResetCopy();
    u2.States.Ability = true;
    u2.Boost = 20;
    u7.AC:Add(function() -- Line: 60
        -- upvalues: u2 (ref)
        u2.States.Ability = false;
        u2.Boost = 0;
    end);
    u7.AC:Add(task.delay(0.5, function() -- Line: 65
        -- upvalues: u7 (copy)
        u7.AC:Clean();
    end));
    u1.Ability:Fire("UltimatePass", {
        Style = "Dribble",
        TimeSent = workspace:GetServerTimeNow(),
        Other = v12
    });
    u3:StopAll();
    u3:PlayChar("Emperor", `EmperorsSpinDribble{Essentials:ReturnRorL(u7.Network.CharValues)}`, Enum.AnimationPriority.Action3);
    u3:PlayBall("Emperor", `EmperorsSpinDribble{Essentials:ReturnRorL(u7.Network.CharValues)}Ball`, Enum.AnimationPriority.Action3);
    local u13 = Essentials:ReturnRorL(u7.Network.CharValues) == "L" and -1 or 1;
    local u14 = u7.AC:Add(Instance.new("LinearVelocity"));
    u14.ForceLimitMode = Enum.ForceLimitMode.PerAxis;
    u14.MaxAxesForce = Vector3.new(20000, 0, 20000);
    u14.Attachment0 = HumanoidRootPart.RootAttachment;
    u14.Parent = HumanoidRootPart;
    u14.VectorVelocity = HumanoidRootPart.CFrame.LookVector * 5;
    TweenService:Create(u14, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        VectorVelocity = HumanoidRootPart.CFrame.LookVector * 45 + HumanoidRootPart.CFrame.RightVector * u13 * 45
    }):Play();
    task.delay(0.25, function() -- Line: 86
        -- upvalues: TweenService (ref), u14 (copy), HumanoidRootPart (copy), u13 (copy), u2 (ref)
        TweenService:Create(u14, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
            VectorVelocity = HumanoidRootPart.CFrame.LookVector * 90 + HumanoidRootPart.CFrame.RightVector * u13 * -90
        }):Play();
        u2.Boost = 0;
    end);
    local u15 = nil;
    u15 = u1.Ability:Connect(function() -- Line: 93
        -- upvalues: u15 (ref), ReplicatedStorage (ref), u4 (ref), HumanoidRootPart (copy)
        u15:Disconnect();
        local Value = ReplicatedStorage.Basketball.Value;
        Value.CFrame = u4:GetLastCharacterToPossessBall().PlrBall.Anims.BALL.CFrame + Vector3.new(0, 0.5, 0);
        Value.AssemblyLinearVelocity = (HumanoidRootPart.CFrame.LookVector - Vector3.new(0, 1, 0)).Unit * 60;
    end);
    u7.AC:Add(u15);
end;