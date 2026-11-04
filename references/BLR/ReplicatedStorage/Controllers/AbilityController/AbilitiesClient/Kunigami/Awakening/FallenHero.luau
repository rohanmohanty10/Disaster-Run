  

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

return function(u1, p2, u3) -- Line: 16, Name: FallenHero
    -- upvalues: Popup (copy), ReplicatedStorage (copy)
    if p2.Character.Values.HasBall.Value == false then
        return;
    end;

    if p2.PlayerStats.InAwakening.Value == false then
        return;
    end;

    if u1.AbilityThree > tick() then
        return;
    end;

    if u1.ABC then
        u1.ABC:Clean();
    end;

    if u3.Humanoid:GetState() == Enum.HumanoidStateType.Freefall then
        return;
    end;

    local v4 = nil;

    for _, v in game.CollectionService:GetTagged("PlayingTeam") do
        if p2.Team ~= v then
            for _, v2 in v:GetPlayers() do
                if v2.Character and (v2.Character:FindFirstChild("HumanoidRootPart") and not (v2.Character.Values.Goalie.Value and v2.Character.Values.IsInPenalty.Value)) and (v2.Character.HumanoidRootPart.Position - p2.Character.HumanoidRootPart.Position).Magnitude < 12 then
                    v4 = v2.Character;
                    break;
                end;
            end;
        end;
    end;

    local v5;

    if v4 then
        v5 = v4;
    else
        v5 = workspace:FindFirstChild("PassRig");

        if v5 and v5:GetAttribute("IsTrainingDummy") then
            local HumanoidRootPart = v5:FindFirstChild("HumanoidRootPart");

            if HumanoidRootPart then
                if (HumanoidRootPart.Position - p2.Character.HumanoidRootPart.Position).Magnitude >= 30 then
                    v5 = v4;
                end;
            else
                v5 = v4;
            end;
        else
            v5 = v4;
        end;
    end;

    if v5 == nil then
        Popup.Popup(p2, "Need enemy player to be close!");

        return;
    end;

    u1.AbilityService.Ability:Fire("FallenHero", v5);
    local Shiftlock = u1.Camera.Shiftlock;
    u1.Camera:SetShiftlock(false);
    u1.StatesController.States.Ability = true;
    u1.Animations.Abilities.FallenHeroNew.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Abilities.FallenHeroNew:Play();
    u1:AbilityCooldown("3", 45);
    task.delay(1, function() -- Line: 68
        -- upvalues: u1 (copy)
        u1.StatesController.States.Ability = false;
    end);
    u1.ABC:Connect(u1.AbilityService.Ability, function() -- Line: 73
        -- upvalues: u1 (copy), ReplicatedStorage (ref), u3 (copy), Shiftlock (copy)
        u1.ABC:Clean();
        ReplicatedStorage.Football.Value.AssemblyLinearVelocity = (u3.HumanoidRootPart.CFrame.LookVector + Vector3.new(0, 0.15, 0)) * 220;
        u1.BallController:DragBall(ReplicatedStorage.Football.Value);
        u1.Camera:SetShiftlock(Shiftlock);
    end);
end;