  

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
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);

return function(u1, u2, u3) -- Line: 16, Name: UndeadMode
    -- upvalues: AbilityBalancing (copy)
    if u1.AbilityThree > tick() then
        return;
    end;

    if u2.PlayerStats.InAwakening.Value == false then
        return;
    end;

    if u1.ABC then
        u1.ABC:Clean();
    end;

    u1:AbilityCooldown("3", AbilityBalancing.UndeadMode.Cooldown);
    u1.Animations:StopAnims();
    u1.StatesController.States.Ability = true;
    u1.StatesController.OwnWalkState = true;
    u1.StatesController.SpeedBoost = AbilityBalancing.UndeadMode.MoveSpeedValue;
    u1.AbilityService.Ability:Fire("UndeadMode");
    u1.Animations.Abilities.UndeadModeRun.Priority = Enum.AnimationPriority.Action3;
    u1.Animations.Abilities.UndeadModeRun:Play();
    local u4 = tick();
    u1.ABC:Connect(u3.Hitbox.Touched, function(p5) -- Line: 35
        -- upvalues: u4 (ref), u2 (copy), u3 (copy), u1 (copy)
        if u4 > tick() then
            return;
        end;

        if p5.Parent:FindFirstChild("Humanoid") == nil then
            return;
        end;

        if p5.Parent.Name == u2.Character.Name then
            return;
        end;

        if u3.Values.HasBall.Value == false then
            return;
        end;

        u4 = tick() + 0.8;

        if u1.Animations.Abilities[`InfiniteDribble{1}`].IsPlaying then
            return;
        end;

        if u1.Animations.Abilities[`InfiniteDribble{2}`].IsPlaying then
            return;
        end;

        if u1.Animations.Abilities[`InfiniteDribble{3}`].IsPlaying then
            return;
        end;

        local v6 = tostring(math.random(1, 3));
        u1.Animations.Abilities[`InfiniteDribble{v6}`].Priority = Enum.AnimationPriority.Action4;
        u1.Animations.Abilities[`InfiniteDribble{v6}`]:Play();
        u1.Animations.Ball[`InfiniteDribble{v6}`].Priority = Enum.AnimationPriority.Action4;
        u1.Animations.Ball[`InfiniteDribble{v6}`]:Play();
    end);
    task.delay(5, function() -- Line: 57
        -- upvalues: u1 (copy)
        if u1.ABC then
            u1.Animations.Abilities.UndeadModeRun:Stop();
            u1.StatesController.States.Ability = false;
            u1.StatesController.OwnWalkState = false;
            u1.StatesController.SpeedBoost = 0;
            u1.ABC:Clean();
        end;
    end);
end;