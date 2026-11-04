  

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
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);

return function(u1, p2, p3) -- Line: 17
    -- upvalues: AbilityBalancing (copy), Players (copy), Popup (copy)
    if p3.Values.HasBall.Value == false then
        return;
    end;

    if u1.ABC then
        u1.ABC:Clean();
    end;

    local ActivationRangePlayer = AbilityBalancing.ReaperTurn.ActivationRangePlayer;
    local Players2 = Players:GetPlayers();
    local v4 = {};
    local v5 = nil;

    for _, v in pairs(Players2) do
        if v.Team ~= game.Teams.Visitor and (v.Character:FindFirstChild("HumanoidRootPart") ~= nil and (v.Team ~= p2.Team and not (v.Character.Values.Goalie.Value and v.Character.Values.IsInPenalty.Value))) then
            local v6 = p3.HumanoidRootPart.CFrame.LookVector:Dot((v.Character.HumanoidRootPart.Position - p3.HumanoidRootPart.Position).Unit);
            local math_acos_ret = math.acos(v6);
            local _ = math_acos_ret < 1.9039955476301778;

            if math_acos_ret < 1.5707963267948966 then
                table.insert(v4, v.Character);
            end;
        end;
    end;

    for _, v in pairs(v4) do
        local Magnitude = (v.HumanoidRootPart.Position - p3.HumanoidRootPart.Position).Magnitude;

        if Magnitude < ActivationRangePlayer then
            v5 = v;
            ActivationRangePlayer = Magnitude;
        end;
    end;

    local PassRig = workspace:FindFirstChild("PassRig");

    if v5 or not (PassRig and (PassRig:GetAttribute("IsTrainingDummy") and PassRig:FindFirstChild("HumanoidRootPart"))) then
        PassRig = v5;
    elseif (PassRig.HumanoidRootPart.Position - p3.HumanoidRootPart.Position).Magnitude >= ActivationRangePlayer then
        PassRig = v5;
    end;

    if PassRig == nil then
        Popup.Popup(p2, "Another player must be infront of you!");

        return;
    end;

    u1.StatesController.States.Ability = true;
    task.delay(0.6, function() -- Line: 67
        -- upvalues: u1 (copy)
        u1.StatesController.States.Ability = false;
    end);
    u1:AbilityCooldown("2", 45);
    u1.AbilityUsed = tick() + 1;
    u1.Animations:StopAnims();
    u1.Animations.Abilities.ReaperTurn.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Abilities.ReaperTurn:Play();
    u1.Animations.Ball.ReaperTurnBall.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Ball.ReaperTurnBall:Play();
    u1.AbilityService.Ability:Fire("ReaperTurn", PassRig);
end;