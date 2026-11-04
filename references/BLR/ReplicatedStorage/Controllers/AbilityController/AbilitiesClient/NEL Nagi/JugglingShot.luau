  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("Players");
game:GetService("RunService");
game:GetService("TweenService");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
local AbilityBalancing = require(ReplicatedStorage2.AbilityBalancing);
local AbilityUtils = require(ReplicatedStorage2.Shared.AbilityUtils);
require(ReplicatedStorage.Shared.Popup);

function Shot(u1, u2)
    -- upvalues: AbilityBalancing (copy)
    u1.AbilityService.Ability:Fire("JuggleShot", {
        State = "Shot"
    });
    u1.JuggleFeints = nil;
    u2:SetAttribute("JuggleFeint", nil);
    u1:AbilityCooldown("3", 40);
    u1.Animations.Abilities.JuggleShot.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Abilities.JuggleShot:Play();
    u1.Animations.Ball.JuggleShotBall.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Ball.JuggleShotBall:Play();
    local Shiftlock = u1.Camera.Shiftlock;
    u1.ABC:Connect(u1.AbilityService.Ability, function(p3) -- Line: 31
        -- upvalues: u1 (copy), u2 (copy), AbilityBalancing (ref), Shiftlock (copy)
        u1.ABC:Clean();
        u1.StatesController.States.Ability = false;
        u1.InAbility = false;
        u1.Camera.Cutscene = false;
        p3.AssemblyLinearVelocity = (u2.HumanoidRootPart.CFrame.LookVector + AbilityBalancing.JugglingShot.ShotTiltVector) * AbilityBalancing.JugglingShot.ShotPower;
        u1.BallController:DragBall(p3);
        u2.HumanoidRootPart.Anchored = false;
        u1.Camera:SetShiftlock(Shiftlock);
    end);
end;

return function(u4, p5, u6) -- Line: 49
    -- upvalues: AbilityBalancing (copy), AbilityUtils (copy)
    local MaxUses = AbilityBalancing.JugglingShot.MaxUses;

    if u4.AbilityThree > tick() then
        return;
    end;

    if u4.AbilityUsed > tick() then
        return;
    end;

    if p5.Character.Humanoid:GetState() == Enum.HumanoidStateType.Freefall or p5.Character.Humanoid:GetState() == Enum.HumanoidStateType.Jumping then
        return;
    end;

    if p5.Character.IsRagdoll.Value or not p5.Character.Values.HasBall.Value then
        return;
    end;

    local Shiftlock = u4.Camera.Shiftlock;
    u4.ABC:Add(function() -- Line: 69
        -- upvalues: u4 (copy), u6 (copy), Shiftlock (copy)
        u4.InAbility = false;
        u4.Camera.Cutscene = false;
        u4.StatesController.States.Ability = false;
        u6.HumanoidRootPart.Anchored = false;
        u4.Camera:SetShiftlock(Shiftlock);
    end);
    local Humanoid = u6:FindFirstChild("Humanoid");
    local HumanoidRootPart = u6.HumanoidRootPart;
    u4.StatesController.States.Ability = true;
    u4.JuggleFeints = not u4.JuggleFeints and 1 or u4.JuggleFeints + 1;
    local JuggleFeints = u4.JuggleFeints;
    u6:SetAttribute("JuggleFeint", JuggleFeints);
    u4.Animations.Abilities.JuggleFeint.Priority = Enum.AnimationPriority.Action4;
    u4.Animations.Abilities.JuggleFeint:Play();
    u4.Animations.Ball.JuggleFeintBall.Priority = Enum.AnimationPriority.Action4;
    u4.Animations.Ball.JuggleFeintBall:Play();
    u4:AbilityCooldown("3", 0.6);
    local CFrame = HumanoidRootPart.CFrame;
    local TravelDistance = AbilityBalancing.JugglingShot.TravelDistance;
    local v7 = CFrame:VectorToObjectSpace(Humanoid.MoveDirection).X < 0 and -1 or 1;
    u4.AbilityService.Ability:Fire("JuggleShot", {
        State = "Feint",
        x = v7
    });
    AbilityUtils.FastDashTo(u6, CFrame.Position + CFrame.RightVector * (TravelDistance * v7), 2, 0.4);
    task.wait(0.4);
    os.clock();
    local v8 = 0.75;

    if u4.JuggleFeints == MaxUses then
        v8 = 0;
    else
        local v9 = p5.PlayerGui.InGameUI.Bottom.Abilities:FindFirstChild("3");

        if v9 then
            local UIScale = v9:FindFirstChild("UIScale");
            UIScale.Scale = 1.25;
            v9.ImageColor3 = Color3.fromRGB(26, 255, 53);
            u4.UITween1 = game:GetService("TweenService"):Create(UIScale, TweenInfo.new(0.85, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                Scale = 1
            });
            u4.UITween1:Play();
            u4.UITween2 = game:GetService("TweenService"):Create(v9, TweenInfo.new(0.85, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                ImageColor3 = Color3.fromRGB(255, 255, 255)
            });
            u4.UITween2:Play();
        end;

        u4.StatesController.States.Ability = false;
    end;

    local _ = u4.AbilityOne > tick();
    local _ = u4.AbilityTwo > tick();
    task.wait(v8);

    if u6.Values.HasBall.Value and not (p5.Character.IsRagdoll.Value or (u4.AbilityUsed > tick() or u6:GetAttribute("Trapped"))) then
        if JuggleFeints == u6:GetAttribute("JuggleFeint") then
            print(2);
            u4.StatesController.States.Ability = true;
            Shot(u4, u6);
            task.wait(1);
            u4.ABC:Clean();
        end;

        return;
    end;

    print("1");
    u6:SetAttribute("JuggleFeint", nil);

    if p5.PlayerStats.Style.Value ~= "Reo" then
        u4:AbilityCooldown("3", 40);
    end;

    u4.ABC:Clean();
end;