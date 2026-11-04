  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
game:GetService("TweenService");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
local Popup = require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local AbilityBalancing = require(ReplicatedStorage2.AbilityBalancing);
local AbilityUtils = require(ReplicatedStorage2.Shared.AbilityUtils);
local interface = require(ReplicatedStorage2.Controllers.AbilityController.interface);

return function(u1, u2, u3) -- Line: 17
    -- upvalues: interface (copy), Popup (copy), AbilityUtils (copy), RunService (copy), ReplicatedStorage2 (copy), Players (copy), AbilityBalancing (copy)
    if interface.TrivelaShot then
        Popup.Popup(u2, "You cannot use this skill right now!");

        return;
    end;

    if not (AbilityUtils.rules.grounded() and AbilityUtils.rules.slotReady(2)) then
        return;
    end;

    if u3:GetAttribute("CloseQuartersDribble") then
        return;
    end;

    u1.StatesController.States.Ability = true;
    u1.StatesController.OwnWalkState = true;
    u1.StatesController.SpeedBoost = 10;
    u1.Animations.Abilities.Camouflage.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Abilities.Camouflage:Play();
    u1.AbilityService.Ability:Fire("Camouflage", {
        State = "Dash"
    });
    local HumanoidRootPart = u3.HumanoidRootPart;

    for _, descendant in HumanoidRootPart:GetDescendants() do
        if descendant:IsA("AlignPosition") or descendant:IsA("BodyVelocity") then
            descendant:Destroy();
        end;
    end;

    task.wait(0.2);
    local u4 = nil;
    u4 = RunService.Heartbeat:Connect(function() -- Line: 54
        -- upvalues: u3 (copy), u4 (ref), ReplicatedStorage2 (ref), u1 (copy), u2 (copy), Players (ref), HumanoidRootPart (copy)
        if u3.Values.HasBall.Value then
            u4:Disconnect();

            return;
        end;

        local Value = ReplicatedStorage2.Football.Value;

        if ReplicatedStorage2.Football.Value.IFrame.Value > workspace:GetServerTimeNow() then
            return;
        end;

        if Value.Parent == workspace and Value.Position.Y < 12 then
            if Value.OnPlayer.Value then
                print("Ball on player");

                return;
            end;

            if (Value.Position - u3.HumanoidRootPart.Position).Magnitude <= 10 then
                u4:Disconnect();
                u1.AbilityService.Ability:Fire("Camouflage", {
                    State = "Steal"
                });
                local v5 = u2.PlayerGui.InGameUI.Bottom.Abilities:FindFirstChild("2");

                if v5 then
                    local UIScale = v5:FindFirstChild("UIScale");
                    UIScale.Scale = 1.25;
                    v5.ImageColor3 = Color3.fromRGB(26, 255, 53);
                    u1.UITween1 = game:GetService("TweenService"):Create(UIScale, TweenInfo.new(0.85, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                        Scale = 1
                    });
                    u1.UITween1:Play();
                    u1.UITween2 = game:GetService("TweenService"):Create(v5, TweenInfo.new(0.85, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                        ImageColor3 = Color3.fromRGB(255, 255, 255)
                    });
                    u1.UITween2:Play();
                    u1:AbilityCooldown("2", 40);
                    u3:SetAttribute("LastV", workspace:GetServerTimeNow() + 40);
                end;
            end;
        else
            for _, v in Players:GetPlayers() do
                if v ~= u2 and (v.Character and (v.Character.Values.HasBall.Value and (u2.Team ~= v.Team and (v.Character.HumanoidRootPart.Position - HumanoidRootPart.Position).Magnitude <= 10))) then
                    local Character = v.Character;
                    local v6;

                    if v then
                        v6 = v.PlayerStats.InAwakening.Value or false;
                    else
                        v6 = false;
                    end;

                    if not (v6 or (v.Character.Values.Dribbling.Value or v.Character.Values.Goalie.Value and v.Character.Values.IsInPenalty.Value)) then
                        u4:Disconnect();
                        u1.AbilityService.Ability:Fire("Camouflage", {
                            State = "Steal",
                            enemy = Character
                        });
                        local v7 = u2.PlayerGui.InGameUI.Bottom.Abilities:FindFirstChild("2");

                        if v7 then
                            local UIScale = v7:FindFirstChild("UIScale");
                            UIScale.Scale = 1.25;
                            v7.ImageColor3 = Color3.fromRGB(26, 255, 53);
                            u1.UITween1 = game:GetService("TweenService"):Create(UIScale, TweenInfo.new(0.85, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                                Scale = 1
                            });
                            u1.UITween1:Play();
                            u1.UITween2 = game:GetService("TweenService"):Create(v7, TweenInfo.new(0.85, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                                ImageColor3 = Color3.fromRGB(255, 255, 255)
                            });
                            u1.UITween2:Play();
                            u1:AbilityCooldown("2", 40);
                            u3:SetAttribute("LastV", workspace:GetServerTimeNow() + 40);
                        end;
                    end;
                end;
            end;

            local PassRig = workspace:FindFirstChild("PassRig");

            if PassRig and PassRig:GetAttribute("IsTrainingDummy") then
                local Values = PassRig:FindFirstChild("Values");

                if Values then
                    Values = Values:FindFirstChild("HasBall");
                end;

                if Values and Values.Value then
                    local HumanoidRootPart2 = PassRig:FindFirstChild("HumanoidRootPart");

                    if HumanoidRootPart2 and (HumanoidRootPart2.Position - HumanoidRootPart.Position).Magnitude <= 10 then
                        u4:Disconnect();
                        u1.AbilityService.Ability:Fire("Camouflage", {
                            State = "Steal",
                            enemy = PassRig
                        });
                        u1:AbilityCooldown("2", 40);
                        u3:SetAttribute("LastV", workspace:GetServerTimeNow() + 40);
                    end;
                end;
            end;
        end;
    end);
    u1.ABC:Add(function() -- Line: 148
        -- upvalues: u4 (ref), u3 (copy), u1 (copy)
        if u4 then
            u4:Disconnect();
        end;

        if not (u3:GetAttribute("Trivela") or u3:GetAttribute("LongPass")) then
            u1:AbilityCooldown("2", 40);
            u3:SetAttribute("LastV", workspace:GetServerTimeNow() + 40);
        end;

        u1.StatesController.OwnWalkState = false;
        u1.StatesController.States.Ability = false;
        u1.StatesController.SpeedBoost = 0;
    end);

    for i = 1, 3 do
        local Unit = (HumanoidRootPart.CFrame.LookVector + (i == 2 and HumanoidRootPart.CFrame.RightVector or (i == 3 and Vector3.new(0, 0, 0) or -HumanoidRootPart.CFrame.RightVector)) / 2).Unit;
        local Unit2 = Vector3.new(Unit.X, 0, Unit.Z).Unit;
        AbilityUtils.FastDashTo(u3, HumanoidRootPart.Position + Unit2 * AbilityBalancing.Camouflage.TravelDistance, -2, 0.2);
        task.wait(0.2);
        local _ = i;
    end;

    u1.ABC:Clean();
end;