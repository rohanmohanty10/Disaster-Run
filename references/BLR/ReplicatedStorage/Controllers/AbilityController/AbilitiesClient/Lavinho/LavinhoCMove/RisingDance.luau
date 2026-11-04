  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("Players");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);

return function(u1, u2, u3) -- Line: 18, Name: RisingDance
    -- upvalues: AbilityBalancing (copy), AbilityUtils (copy)
    u1:AbilityCooldown("1", 1);
    u1.StatesController.States.Ability = true;
    u1.StatesController.OwnWalkState = true;

    if u3 and u3:FindFirstChild("Humanoid") then
        u3.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, false);
    end;

    u1.ABC:Add(function() -- Line: 29
        -- upvalues: u3 (copy)
        if u3 and u3:FindFirstChild("Humanoid") then
            u3.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, true);
        end;
    end);
    u1.Animations:StopAnims();
    u1.Animations.Abilities.RisingDance.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Abilities.RisingDance:Play();
    u1.Animations.Ball.RisingDanceBall.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Ball.RisingDanceBall:Play();
    task.wait(0.05);
    u1.AbilityService.Ability:Fire("RisingDance");
    u1.ABC:Connect(u1.AbilityService.Ability, function(p4) -- Line: 46
        -- upvalues: u1 (copy), u3 (copy), AbilityBalancing (ref), AbilityUtils (ref)
        print("Fired");
        u1.StatesController.States.Ability = false;
        u1.StatesController.OwnWalkState = false;
        p4.AssemblyLinearVelocity = (u3.HumanoidRootPart.CFrame.LookVector + Vector3.new(0, 0.75, 0)) * 55;
        local LookVector = u3.HumanoidRootPart.CFrame.LookVector;
        local Unit = Vector3.new(LookVector.X, 0, LookVector.Z).Unit;
        AbilityUtils.FastDashTo(u3, u3.HumanoidRootPart.Position + Unit * AbilityBalancing.RisingDance.TravelDistance, -2, 0.6);
        u1.BallController:DragBall(p4);
        task.wait(0.6);
        u1.ABC:Clean();
    end);
    u1.ABC:Add(function() -- Line: 67
        -- upvalues: u1 (copy), u2 (copy), u3 (copy)
        u1.StatesController.States.Ability = false;
        local v5 = u2.PlayerGui.InGameUI.Bottom.Abilities:FindFirstChild("1");

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
            u3:SetAttribute("ButterflyDribble", true);
            task.delay(2, function() -- Line: 86
                -- upvalues: u1 (ref), u3 (ref)
                u1.UITween2 = nil;
                u1.UITween1 = nil;
                u3:SetAttribute("ButterflyDribble", nil);
                u1:AbilityCooldown("1", 45);
            end);
        end;
    end);
    task.delay(1, function() -- Line: 98
        -- upvalues: u1 (copy)
        u1.StatesController.States.Ability = false;
        u1.StatesController.OwnWalkState = false;
        warn("SET OWN WALK STATE TO FALSE");
    end);
end;