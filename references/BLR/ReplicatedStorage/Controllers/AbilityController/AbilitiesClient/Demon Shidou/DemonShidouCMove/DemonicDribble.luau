  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("Players");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("RunService");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local DemonicDribble = require(ReplicatedStorage.AbilityBalancing).DemonicDribble;
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);

return function(u1, p2, u3) -- Line: 16, Name: DemonicDribble
    -- upvalues: DemonicDribble (copy), AbilityUtils (copy)
    u1.AbilityService.Ability:Fire("DemonicDribble");
    u1.Animations:StopAnims();
    local MoveSpeedValue = DemonicDribble.MoveSpeedValue;
    u1.StatesController.States.Ability = true;
    u1.Animations.Abilities.DemonicDribble.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Abilities.DemonicDribble:Play();
    u1.Animations.Ball.DemonicDribbleBall.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Ball.DemonicDribbleBall:Play();
    task.wait(0.38);
    local LookVector = u3.HumanoidRootPart.CFrame.LookVector;
    local Unit = Vector3.new(LookVector.X, 0, LookVector.Z).Unit;
    AbilityUtils.FastDashTo(u3, u3.HumanoidRootPart.Position + Unit * MoveSpeedValue, 2, DemonicDribble.MoveSpeedDuration);
    u3:SetAttribute("DemonicDribble", true);
    task.delay(2.5, function() -- Line: 39
        -- upvalues: u3 (copy), u1 (copy), DemonicDribble (ref)
        if u3:GetAttribute("DemonicDribble") then
            u3:SetAttribute("DemonicDribble", false);
            u1:AbilityCooldown("1", DemonicDribble.Cooldown);
        end;
    end);
    u1.ABC:Add(function() -- Line: 46
        -- upvalues: u1 (copy)
        u1.StatesController.States.Ability = false;
    end);
    task.delay(1, function() -- Line: 50
        -- upvalues: u1 (copy)
        if u1.ABC then
            u1.ABC:Clean();
        end;
    end);
end;