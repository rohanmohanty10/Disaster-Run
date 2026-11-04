  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
local Players = game:GetService("Players");
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

return function(u1, p2, u3) -- Line: 16, Name: Surpass
    -- upvalues: Players (copy), Popup (copy), ReplicatedStorage (copy)
    if p2.Character.Values.HasBall.Value == false then
        return;
    end;

    if p2.PlayerStats.InAwakening.Value == false then
        return;
    end;

    if u1.AbilityOne > tick() then
        return;
    end;

    if u1.AbilityUsed > tick() then
        return;
    end;

    if u1.ABC then
        u1.ABC:Clean();
    end;

    local Players2 = Players:GetPlayers();
    local v4 = {};
    local v5 = 30;
    local v6 = nil;

    for _, v in pairs(Players2) do
        if v.Team ~= game.Teams.Visitor and (v.Character:FindFirstChild("HumanoidRootPart") ~= nil and (v.Team ~= p2.Team and not (v.Character.Values.Goalie.Value and v.Character.Values.IsInPenalty.Value))) then
            local v7 = u3.HumanoidRootPart.CFrame.LookVector:Dot((v.Character.HumanoidRootPart.Position - u3.HumanoidRootPart.Position).Unit);
            local math_acos_ret = math.acos(v7);

            if math_acos_ret < 1.5707963267948966 or math_acos_ret < 1.9039955476301778 then
                table.insert(v4, v.Character);
            end;
        end;
    end;

    for _, v in pairs(v4) do
        local Magnitude = (v.HumanoidRootPart.Position - u3.HumanoidRootPart.Position).Magnitude;

        if Magnitude < v5 then
            v6 = v;
            v5 = Magnitude;
        end;
    end;

    table.clear(v4);
    table.clear(Players2);

    if v6 == nil then
        Popup.Popup(p2, "Another player must be infront of you!");

        return;
    end;

    if u1.ABC then
        u1.ABC:Clean();
    end;

    local Shiftlock = u1.Camera.Shiftlock;
    u1.Camera:SetShiftlock(false);
    u1.Camera.Cutscene = true;
    u1.InAbility = true;
    u1.StatesController.States.Ability = true;
    u3.HumanoidRootPart.Anchored = true;
    u1:AbilityCooldown("1", 70);
    task.delay(10, function() -- Line: 75
        -- upvalues: u1 (copy), u3 (copy)
        u1.StatesController.States.Ability = false;
        u1.InAbility = false;
        u1.Camera.Cutscene = false;
        u3.HumanoidRootPart.Anchored = false;
    end);
    task.wait(0.1);
    u1.AbilityService.Ability:Fire("Surpass", v6);
    u1.Animations:StopAnims();
    u1.Animations.Ball.Surpass.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Ball.Surpass:Play();
    u1.Animations.Abilities.Surpass.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Abilities.Surpass:Play();
    task.delay(7, function() -- Line: 94
        -- upvalues: u1 (copy)
        u1.Animations.Ball.Surpass:AdjustSpeed(0.2);
    end);
    task.delay(9, function() -- Line: 98
        -- upvalues: u1 (copy), u3 (copy)
        if u1.ABC then
            u1.ABC:Clean();
            u1.StatesController.States.Ability = false;
            u1.InAbility = false;
            u1.Camera.Cutscene = false;
            u3.HumanoidRootPart.Anchored = false;
        end;
    end);
    u1.ABC:Connect(u1.AbilityService.Ability, function() -- Line: 108
        -- upvalues: u1 (copy), ReplicatedStorage (ref), u3 (copy), Shiftlock (copy)
        u1.ABC:Clean();
        u1.StatesController.States.Ability = false;
        u1.InAbility = false;
        u1.Camera.Cutscene = false;
        ReplicatedStorage.Football.Value.AssemblyLinearVelocity = (u3.HumanoidRootPart.CFrame.LookVector + Vector3.new(0, 0.2, 0)) * 225;
        u1.BallController:DragBall(ReplicatedStorage.Football.Value);
        u3.HumanoidRootPart.Anchored = false;
        u1.Camera:SetShiftlock(Shiftlock);
    end);
end;