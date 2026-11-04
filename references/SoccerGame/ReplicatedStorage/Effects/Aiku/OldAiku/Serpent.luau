  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Debris = game:GetService("Debris");
game:GetService("RunService");
local Essentials = require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);

return function(u1) -- Line: 11
    -- upvalues: ReplicatedStorage (copy), Essentials (copy), TweenService (copy), Debris (copy)
    local u2 = ReplicatedStorage.Assets.Misc.Snake:Clone();
    u2.Parent = u1.Char;
    u2.PrimaryPart.CFrame = u1.Char.HumanoidRootPart.CFrame * CFrame.new(0, -3, 14) * CFrame.fromEulerAnglesXYZ(0, 3.141592653589793, 0);
    Essentials:Weld(u2.PrimaryPart, u1.Char.HumanoidRootPart);
    local u3 = u2.AnimationController.Animator:LoadAnimation(ReplicatedStorage.Assets.ReplicatedAnims.Abilities.SnakeUp);
    u3:Play();
    u3:AdjustSpeed(1.8);
    task.delay(0.5, function() -- Line: 21
        -- upvalues: u3 (copy)
        u3:AdjustSpeed(0);
    end);
    task.delay(2, function() -- Line: 25
        -- upvalues: TweenService (ref), u2 (copy), Debris (ref), u3 (copy), ReplicatedStorage (ref), u1 (ref)
        local v4 = TweenService:Create(u2.PrimaryPart, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Transparency = 1
        });
        v4:Play();
        Debris:AddItem(v4, 1);
        u3:Stop();
        local u5 = u2.AnimationController.Animator:LoadAnimation(ReplicatedStorage.Assets.ReplicatedAnims.Abilities.SnakeDown);
        u5:Play();
        u5:AdjustSpeed(1.5);
        task.delay(2, function() -- Line: 37
            -- upvalues: u3 (ref), u5 (copy), u1 (ref)
            u3:Destroy();
            u5:Destroy();
            table.clear(u1);
            u1 = nil;
        end);
    end);
    task.delay(3, function() -- Line: 45
        -- upvalues: u2 (copy)
        u2:Destroy();
    end);
end;