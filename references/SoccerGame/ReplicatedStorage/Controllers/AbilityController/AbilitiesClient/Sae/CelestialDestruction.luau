  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("Players");
local RunService = game:GetService("RunService");
game:GetService("TweenService");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage2.AbilityBalancing);
local AbilityUtils = require(ReplicatedStorage2.Shared.AbilityUtils);
local interface = require(ReplicatedStorage2.Controllers.AbilityController.interface);

local function Lerp(p1, p2, p3) -- Line: 17
    return p1 + (p2 - p1) * p3;
end;

local function QuadBezier(p4, p5, p6, p7) -- Line: 21
    local v8 = p4 + (p5 - p4) * p7;

    return v8 + (p5 + (p6 - p5) * p7 - v8) * p7;
end;

return function(u9, u10, u11) -- Line: 29
    -- upvalues: AbilityUtils (copy), interface (copy), RunService (copy)
    if not (AbilityUtils.rules.onball() and (AbilityUtils.rules.grounded() and AbilityUtils.rules.slotReady(2))) then
        print("returned");

        return;
    end;

    u9.StatesController.States.Ability = true;
    u9.StatesController.OwnWalkState = true;
    u9.Animations.Abilities.CelestialDestruction.Priority = Enum.AnimationPriority.Action4;
    u9.Animations.Abilities.CelestialDestruction:Play();
    local u12 = u10.PlayerStats.Style.Value == "Reo";
    interface:AbilityCooldown(2, u12 and 40 or 1.5);
    local HumanoidRootPart = u11.HumanoidRootPart;
    u9.AbilityService.Ability:Fire("CelestialDestruction");
    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.MaxForce = Vector3.new(500000, 0, 500000);
    BodyVelocity.Parent = HumanoidRootPart;
    u9.ABC:Connect(RunService.Heartbeat, function() -- Line: 57
        -- upvalues: BodyVelocity (copy), HumanoidRootPart (copy)
        if BodyVelocity then
            BodyVelocity.Velocity = HumanoidRootPart.CFrame.LookVector * 30;
        end;
    end);
    u9.ABC:Add(function() -- Line: 63
        -- upvalues: u9 (copy)
        u9.StatesController.OwnWalkState = false;
        u9.StatesController.States.Ability = false;
        u9.StatesController.SpeedBoost = 0;
    end);
    u9.ABC:Add(task.delay(1, function() -- Line: 69
        -- upvalues: BodyVelocity (copy), HumanoidRootPart (copy), AbilityUtils (ref), u11 (copy), u9 (copy)
        BodyVelocity:Destroy();
        local LookVector = HumanoidRootPart.CFrame.LookVector;
        local Unit = Vector3.new(LookVector.X, 0, LookVector.Z).Unit;
        local v13, v14 = AbilityUtils.FastDashTo(u11, HumanoidRootPart.Position + Unit * 50, -2, 0.5);
        u9.ABC:Add(v13);
        u9.ABC:Add(v14);
    end));
    u9.ABC:Add(task.delay(1.5, function() -- Line: 81
        -- upvalues: u9 (copy), u12 (copy), u11 (copy), u10 (copy), interface (ref)
        u9.StatesController.States.Ability = false;

        if u12 then
            return;
        end;

        if u11.Values.HasBall.Value then
            local v15 = u10.PlayerGui.InGameUI.Bottom.Abilities:FindFirstChild("2");

            if v15 then
                local UIScale = v15:FindFirstChild("UIScale");
                UIScale.Scale = 1.25;
                v15.ImageColor3 = Color3.fromRGB(26, 255, 53);
                u9.UITween1 = game:GetService("TweenService"):Create(UIScale, TweenInfo.new(0.85, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                    Scale = 1
                });
                u9.UITween1:Play();
                u9.UITween2 = game:GetService("TweenService"):Create(v15, TweenInfo.new(0.85, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                    ImageColor3 = Color3.fromRGB(255, 255, 255)
                });
                u9.UITween2:Play();
                interface.HeelFlick = true;
                task.wait(2);
                u9.UITween2 = nil;
                u9.UITween1 = nil;
                interface.HeelFlick = false;
                u9:AbilityCooldown("2", 40);
            end;
        else
            u9:AbilityCooldown("2", 40);
        end;

        u9.ABC:Clean();
    end));
end;