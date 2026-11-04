  

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
local Popup = require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local Viper = require(ReplicatedStorage.AbilityBalancing).Viper;

return function(u1, p2, u3) -- Line: 16
    -- upvalues: Popup (copy), Viper (copy), ReplicatedStorage (copy)
    if p2.Character.Values.HasBall.Value == false and not workspace:FindFirstChild("Football") then
        Popup.Popup(p2, "Must have ball or be close to it!");

        return;
    end;

    if u1.AbilityThree > tick() then
        return;
    end;

    if u1.AbilityUsed > tick() then
        return;
    end;

    if u1.ABC then
        u1.ABC:Clean();
    end;

    local ActivationRangeBall = Viper.ActivationRangeBall;
    u1:AbilityCooldown("3", 0.5);

    if p2.Character.Values.HasBall.Value == false and workspace:FindFirstChild("Football") and ActivationRangeBall < (u3.HumanoidRootPart.Position - workspace.Football.Position).Magnitude then
        Popup.Popup(p2, "Must have ball or be close to it!");

        return;
    end;

    u1.Camera.Cutscene = true;
    u1.InAbility = true;
    u1.StatesController.States.Ability = true;
    u3.HumanoidRootPart.Anchored = true;
    u1.ABC:Add(function() -- Line: 37
        -- upvalues: u1 (copy), u3 (copy)
        u1.Camera.Cutscene = false;
        u1.InAbility = false;
        u1.StatesController.States.Ability = false;
        u3.HumanoidRootPart.Anchored = false;
    end);
    u1.AbilityService.Ability:Fire("Viper");
    u1.ABC:Add(task.delay(13, function() -- Line: 46
        -- upvalues: u1 (copy)
        print("clean");
        u1.ABC:Clean();
    end));
    local u4 = game.Workspace.CurrentCamera.CFrame.LookVector + Viper.ShotTiltVector;
    u1.ABC:Connect(u1.AbilityService.Ability, function(p5) -- Line: 52
        -- upvalues: u1 (copy), Viper (ref), u4 (copy), ReplicatedStorage (ref)
        u1:AbilityCooldown("3", Viper.Cooldown);
        (p5 or workspace:WaitForChild("Football", 1)).AssemblyLinearVelocity = u4 * Viper.ShotPower;
        u1.BallController:DragBall(ReplicatedStorage.Football.Value);
        u1.ABC:Clean();
    end);
end;