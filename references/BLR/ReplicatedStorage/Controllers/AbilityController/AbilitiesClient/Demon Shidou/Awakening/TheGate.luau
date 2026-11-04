  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
local Popup = require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.AbilityUtils);
require(ReplicatedStorage.AbilityBalancing);

return function(u1, p2, u3) -- Line: 18
    -- upvalues: ReplicatedStorage (copy), Players (copy), RunService (copy), Popup (copy)
    if p2.Character.Values.HasBall.Value == true then
        return;
    end;

    if u1.AbilityTwo > tick() then
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

    local Value = ReplicatedStorage.Football.Value;
    local Value2 = Value.OnPlayer.Value;
    local Value3 = Value.Char.Value;
    local PlayerFromCharacter = Players:GetPlayerFromCharacter(Value3);
    local v4;

    if Value3 then
        v4 = Value3:GetAttribute("IsTrainingDummy");
    else
        v4 = Value3;
    end;

    if RunService:IsStudio() then
        Value3 = workspace.PassRig;
    else
        if not (Value2 and (Value3 and (PlayerFromCharacter and (PlayerFromCharacter.Team ~= p2.Team and (Value3.Values.Goalie.Value == false or Value3.Values.IsInPenalty.Value == false)))) or Value2 and v4) then
            Popup.Popup(p2, "Must be near player with ball!");

            return;
        end;

        if (Value3.HumanoidRootPart.Position - u3.HumanoidRootPart.Position).Magnitude >= 25 then
            Popup.Popup(p2, "Must be near player with ball!");

            return;
        end;
    end;

    u1.Camera.Cutscene = true;
    u1.InAbility = true;
    u1.StatesController.States.Ability = true;
    u3.HumanoidRootPart.Anchored = true;
    u1.ABC:Add(function() -- Line: 54
        -- upvalues: u1 (copy), u3 (copy)
        u1.Camera.Cutscene = false;
        u1.InAbility = false;
        u1.StatesController.States.Ability = false;
        u3.HumanoidRootPart.Anchored = false;
    end);
    u1:AbilityCooldown("2", 75);
    u1.AbilityService.Ability:Fire("TheGate", Value3);
    u1.ABC:Add(task.delay(25, function() -- Line: 65
        -- upvalues: u1 (copy)
        u1.ABC:Clean();
    end));
    u1.ABC:Connect(u1.AbilityService.Ability, function(p5) -- Line: 69
        -- upvalues: u1 (copy)
        u1.ABC:Clean();
    end);
end;