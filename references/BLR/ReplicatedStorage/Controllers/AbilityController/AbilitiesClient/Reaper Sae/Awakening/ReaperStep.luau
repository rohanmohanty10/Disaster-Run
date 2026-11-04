  

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
require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);

return function(u1, p2, u3) -- Line: 17
    -- upvalues: AbilityUtils (copy), Players (copy)
    if p2.Character.Values.HasBall.Value == false then
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

    if u3.Humanoid:GetState() == Enum.HumanoidStateType.Freefall then
        return;
    end;

    local v4 = AbilityUtils.findNearestPlayer({
        distance = 900,
        includeGK = false,
        team = "Enemy"
    });
    local v5 = nil;

    for _, v in Players:GetPlayers() do
        if v.Team ~= p2.Team and (not v4 or v ~= v4) then
            v5 = v.Character;
        end;
    end;

    u1.Camera.Cutscene = true;
    u1.InAbility = true;
    u1.StatesController.States.Ability = true;
    u3.HumanoidRootPart.Anchored = true;
    u1.ABC:Add(function() -- Line: 38
        -- upvalues: u1 (copy), u3 (copy)
        u1.Camera.Cutscene = false;
        u1.InAbility = false;
        u1.StatesController.States.Ability = false;
        u3.HumanoidRootPart.Anchored = false;
    end);
    u1:AbilityCooldown("1", 75);
    u1.AbilityService.Ability:Fire("ReaperStep", {
        EnemyChar1 = v4,
        EnemyChar2 = v5
    });
    local _ = u3.HumanoidRootPart.CFrame.LookVector;
    u1.ABC:Add(task.delay(25, function() -- Line: 51
        -- upvalues: u1 (copy)
        u1.ABC:Clean();
    end));
    u1.ABC:Connect(u1.AbilityService.Ability, function(p6) -- Line: 55
        -- upvalues: u1 (copy)
        u1.ABC:Clean();
    end);
end;