  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("Players");
game:GetService("RunService");
game:GetService("TweenService");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
local Popup = require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local AbilityBalancing = require(ReplicatedStorage2.AbilityBalancing);
local AbilityUtils = require(ReplicatedStorage2.Shared.AbilityUtils);

return function(u1, u2, u3, p4) -- Line: 17
    -- upvalues: AbilityUtils (copy), AbilityBalancing (copy), Popup (copy)
    if not u3.Values.HasBall.Value then
        u1.ABC:Clean();

        return;
    end;

    if not AbilityUtils.findNearestPlayer({
        team = "Enemy",
        includeGK = false,
        distance = AbilityBalancing.ContrarianDribble.ActivationRangePlayer
    }) then
        Popup.Popup(u2, "Player must be in front of you!");

        return;
    end;

    local u5 = u2.PlayerStats.Style.Value == "Reo";
    u1.StatesController.States.Ability = true;
    u1.StatesController.OwnWalkState = true;
    local v6 = u3:GetAttribute("DartboardLens") and 1.5 or 1;
    u1.ABC:Add(function() -- Line: 39
        -- upvalues: u1 (copy), u5 (copy), u3 (copy), u2 (copy), AbilityBalancing (ref)
        u1.StatesController.OwnWalkState = false;
        u1.StatesController.States.Ability = false;

        if u5 then
            return;
        end;

        if u3.Values.HasBall.Value then
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
                u3:SetAttribute("ContrarianPass", true);
                task.delay(2, function() -- Line: 62
                    -- upvalues: u1 (ref), u3 (ref), AbilityBalancing (ref)
                    u1.UITween2 = nil;
                    u1.UITween1 = nil;
                    u3:SetAttribute("ContrarianPass", nil);
                    u1:AbilityCooldown("2", AbilityBalancing.ContrarianDribble.Cooldown);
                end);
            end;
        else
            u1:AbilityCooldown("2", AbilityBalancing.ContrarianDribble.Cooldown);
        end;
    end);
    u1.Animations.Abilities.ContrarianDribble.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Abilities.ContrarianDribble:Play();
    u1.Animations.Abilities.ContrarianDribble:AdjustSpeed(1.5 * v6);
    u1.Animations.Ball.CreativeDribbleBall.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Ball.CreativeDribbleBall:Play();
    u1.Animations.Ball.CreativeDribbleBall:AdjustSpeed(1.5 * v6);
    u1:AbilityCooldown("2", u5 and AbilityBalancing.ContrarianDribble.Cooldown or 1);
    u1.AbilityService.Ability:Fire("ContrarianDribble");
    local HumanoidRootPart = u3.HumanoidRootPart;
    local TravelDistance = AbilityBalancing.ContrarianDribble.TravelDistance;
    task.wait(0.247 / v6);

    if not u3.Values.HasBall.Value then
        u1.ABC:Clean();

        return;
    end;

    local v8 = HumanoidRootPart.CFrame * CFrame.new(TravelDistance / 2, 0, -TravelDistance / 2);
    AbilityUtils.FastDashTo(u3, v8.Position, -2, 0.4 / v6);
    task.wait(0.475 / v6);
    local v9 = HumanoidRootPart.CFrame * CFrame.new(-TravelDistance / 2, 0, -TravelDistance / 2);
    AbilityUtils.FastDashTo(u3, v9.Position, -2, 0.433 / v6);
    task.wait(0.666 / v6);
    local v10 = HumanoidRootPart.CFrame * CFrame.new(0, 0, -TravelDistance * 1.25);
    AbilityUtils.FastDashTo(u3, v10.Position, -2, 0.533 / v6);
    task.wait(0.533 / v6);
    u1.ABC:Clean();
end;