  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("Players");
game:GetService("RunService");
game:GetService("TweenService");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
local Popup = require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);

return function(u1, p2, p3) -- Line: 13, Name: Header
    -- upvalues: ReplicatedStorage (copy), Popup (copy)
    if p2.PlayerStats.InAwakening.Value == false then
        return;
    end;

    if ReplicatedStorage.Football.Value.Anchored then
        return;
    end;

    local Home = workspace.Goals.Home;
    local v4 = workspace.Goals:FindFirstChild(p2.Team.Name) or Home;
    local Magnitude = (p3.HumanoidRootPart.Position - v4.Position).Magnitude;

    if #game.CollectionService:GetTagged("GoalPart") > 1 then
        local v5 = false;

        for _, v in game.CollectionService:GetTagged("GoalPart") do
            if v4 ~= v and (p3.HumanoidRootPart.Position - v.Position).Magnitude < Magnitude then
                v5 = true;
                break;
            end;
        end;

        if v5 == false then
            Popup.Popup(p2, "Must be on your side of the field!");

            return;
        end;
    end;

    if p3.Values.HasBall.Value then
        Popup.Popup(p2, "Ball must be in air!");

        return;
    end;

    if ReplicatedStorage.Football.Value.Position.Y <= 14 then
        Popup.Popup(p2, "Ball must be higher in air!");

        return;
    end;

    if ReplicatedStorage.Football.Value.OnPlayer.Value then
        Popup.Popup(p2, "Ball must be in air!");

        return;
    end;

    if (ReplicatedStorage.Football.Value.Position - p3.HumanoidRootPart.Position).Magnitude >= 75 then
        return;
    end;

    if u1.AbilityThree > tick() then
        return;
    end;

    if u1.ABC then
        u1.ABC:Clean();
    end;

    u1:AbilityCooldown("3", 75);
    local Shiftlock = u1.Camera.Shiftlock;
    u1.Camera:SetShiftlock(false);
    u1.StatesController.States.Ability = true;
    task.delay(0.7, function() -- Line: 76
        -- upvalues: u1 (copy), Shiftlock (copy)
        u1.StatesController.States.Ability = false;
        u1.Camera:SetShiftlock(Shiftlock);
    end);
    task.delay(1, function() -- Line: 81
        -- upvalues: u1 (copy)
        if u1.ABC then
            u1.ABC:Clean();
        end;
    end);
    u1:AbilityCooldown("3", 75);
    u1.Animations:StopAnims();
    u1.Animations.Abilities.AikuHeader.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Abilities.AikuHeader:Play();
    u1.AbilityService.Ability:Fire("Header");
    u1.ABC:Connect(u1.AbilityService.Ability, function(p6) -- Line: 94
        -- upvalues: u1 (copy)
        u1.ABC:Clean();
        p6.AssemblyLinearVelocity = (workspace.CurrentCamera.CFrame.LookVector + Vector3.new(0, 0.225, 0)) * 170;
        u1.BallController:DragBall(p6);
    end);
end;