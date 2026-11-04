  

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
require(ReplicatedStorage.AbilityBalancing);
local u1 = false;

return function(u2, p3, p4, p5) -- Line: 19
    -- upvalues: u1 (ref), ReplicatedStorage (copy)
    if u1 then
        return;
    end;

    if p4.Humanoid:GetState() == Enum.HumanoidStateType.Freefall then
        return;
    end;

    local Name = p3.Team.Name;

    if not ReplicatedStorage.Teams:FindFirstChild(Name .. "Team") then
        return;
    end;

    if (ReplicatedStorage.Teams[Name .. "Team"].CF.Value.Character.HumanoidRootPart.Position - ReplicatedStorage.Teams[(Name == "Home" and "Away" or "Home") .. "Team"].CF.Value.Character.HumanoidRootPart.Position).Magnitude >= 30 then
        return;
    end;

    u1 = true;
    u2.Camera.Cutscene = true;
    u2.InAbility = true;
    u2.StatesController.States.Ability = true;
    u2.ABC:Add(function() -- Line: 44
        -- upvalues: u2 (copy), u1 (ref)
        u2.Camera.Cutscene = false;
        u2.InAbility = false;
        u2.StatesController.States.Ability = false;
        task.wait(30);
        u1 = false;
    end);
    u2.ABC:Add(task.delay(25, function() -- Line: 52
        -- upvalues: u1 (ref), u2 (copy)
        u1 = true;
        u2.ABC:Clean();
    end));
    u2.AbilityService.Ability:Fire("RivalsReaction" .. p5);
    task.wait(13);
    u2.ABC:Clean();
end;