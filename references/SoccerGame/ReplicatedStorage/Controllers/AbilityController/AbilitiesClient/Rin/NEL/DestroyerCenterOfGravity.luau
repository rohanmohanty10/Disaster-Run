  

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
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
require(ReplicatedStorage.Controllers.AbilityController.interface);

return function(u1, p2, u3) -- Line: 18, Name: CenterOfGravity
    -- upvalues: AbilityUtils (copy), Players (copy), Popup (copy)
    if not AbilityUtils.rules.grounded() then
        return;
    end;

    if u1.AbilityOne > tick() then
        return;
    end;

    local Players2 = Players:GetPlayers();
    local v4 = {};
    local v5 = 15;
    local v6 = nil;

    for _, v in pairs(Players2) do
        if v.Team ~= game.Teams.Visitor and (v.Character:FindFirstChild("HumanoidRootPart") ~= nil and (v.Team ~= p2.Team and not (v.Character.Values.Goalie.Value and v.Character.Values.IsInPenalty.Value))) and (v.Character.Values.HasBall.Value and not (v.Character.Values.Dribbling.Value or v.Character.Values.InCutscene.Value)) then
            local v7 = u3.HumanoidRootPart.CFrame.LookVector:Dot((v.Character.HumanoidRootPart.Position - u3.HumanoidRootPart.Position).Unit);
            local math_acos_ret = math.acos(v7);
            local _ = math_acos_ret < 1.9039955476301778;

            if math_acos_ret < 1.5707963267948966 then
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

    print(v6);

    if not v6 then
        Popup.Popup(p2, "Another player must be infront of you!");

        return;
    end;

    if u1.ABC then
        u1.ABC:Clean();
    end;

    u1:AbilityCooldown("1", 45);
    u1.InAbility = true;
    u1.StatesController.States.Ability = true;
    u3.HumanoidRootPart.Anchored = true;
    task.delay(0.5, function() -- Line: 72
        -- upvalues: u1 (copy), u3 (copy)
        u1.InAbility = false;
        u1.StatesController.States.Ability = false;
        u3.HumanoidRootPart.Anchored = false;
    end);
    u1.Animations:StopAnims();
    u1.Animations.Abilities.CenterGravity.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Abilities.CenterGravity:Play();
    u1.AbilityService.Ability:Fire("CenterOfGravityBase", v6);
end;