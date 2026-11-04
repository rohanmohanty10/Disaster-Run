  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
local Players = game:GetService("Players");
game:GetService("RunService");
game:GetService("TweenService");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
local Popup = require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage2.AbilityBalancing);

return function(u1, p2, p3) -- Line: 15, Name: Charge
    -- upvalues: ReplicatedStorage (copy), Popup (copy), Players (copy)
    if ReplicatedStorage.Football.Value.Anchored then
        return;
    end;

    local Home = workspace.Goals.Home;
    local v4 = workspace.Goals:FindFirstChild(p2.Team.Name) or Home;
    local Magnitude = (p3.HumanoidRootPart.Position - v4.Position).Magnitude;

    if #game.CollectionService:GetTagged("GoalPart") > 1 then
        local v5 = false;

        for _, v in game.CollectionService:GetTagged("GoalPart") do
            if v4 ~= v and (p3.HumanoidRootPart.Position - v.Position).Magnitude * 0.75 < Magnitude then
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
        Popup.Popup(p2, "Ball must be on a rival team!");

        return;
    end;

    if ReplicatedStorage.Football.Value.OnPlayer.Value == false then
        Popup.Popup(p2, "Ball must be on a rival team!");

        return;
    end;

    local v6 = Players:FindFirstChild(ReplicatedStorage.Football.Value.Char.Value.Name);

    if not v6 then
        return;
    end;

    if v6.Team == p2.Team then
        Popup.Popup(p2, "Ball must be on a rival team!");

        return;
    end;

    if u1.ABC then
        u1.ABC:Clean();
    end;

    if (ReplicatedStorage.Football.Value.Position - p3.HumanoidRootPart.Position).Magnitude >= 37 then
        return;
    end;

    local v7 = v6.Character.HumanoidRootPart.CFrame.LookVector:Dot((p3.HumanoidRootPart.Position - v6.Character.HumanoidRootPart.Position).Unit);
    local math_acos_ret = math.acos(v7);

    if math_acos_ret < 1.9039955476301778 == false and math_acos_ret < 1.5707963267948966 == false then
        Popup.Popup(p2, "Must be next or infront of player!");

        return;
    end;

    if u1.AbilityTwo > tick() then
        return;
    end;

    if u1.ABC then
        u1.ABC:Clean();
    end;

    u1:AbilityCooldown("2", 70);
    u1.StatesController.States.Ability = true;
    task.delay(0.35, function() -- Line: 77
        -- upvalues: u1 (copy)
        u1.StatesController.States.Ability = false;
    end);
    u1.Animations:StopAnims();
    u1.Animations.Abilities.ChargeSteal.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Abilities.ChargeSteal:Play();
    u1.AbilityService.Ability:Fire("ChargeAiku", v6.Character);
end;