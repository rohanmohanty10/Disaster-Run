  

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
local interface = require(ReplicatedStorage.Controllers.AbilityController.interface);

return function(u1, p2, p3) -- Line: 18, Name: Opposite
    -- upvalues: Popup (copy), Players (copy), interface (copy)
    if p3.Values.HasBall.Value == false then
        Popup.Popup(p2, "Must have ball!");

        return;
    end;

    if u1.AbilityTwo > tick() then
        return;
    end;

    if u1.ABC then
        u1.ABC:Clean();
    end;

    local Players2 = Players:GetPlayers();
    local v4 = {};
    local v5 = 23;
    local v6 = nil;

    for _, v in pairs(Players2) do
        if v.Team ~= game.Teams.Visitor and (v.Character:FindFirstChild("HumanoidRootPart") ~= nil and (v.Team ~= p2.Team and not (v.Character.Values.Goalie.Value and v.Character.Values.IsInPenalty.Value))) then
            local v7 = p3.HumanoidRootPart.CFrame.LookVector:Dot((v.Character.HumanoidRootPart.Position - p3.HumanoidRootPart.Position).Unit);
            local math_acos_ret = math.acos(v7);
            local _ = math_acos_ret < 1.9039955476301778;

            if math_acos_ret < 1.5707963267948966 then
                table.insert(v4, v.Character);
            end;
        end;
    end;

    for _, v in pairs(v4) do
        local Magnitude = (v.HumanoidRootPart.Position - p3.HumanoidRootPart.Position).Magnitude;

        if Magnitude < v5 then
            v6 = v;
            v5 = Magnitude;
        end;
    end;

    local v8;

    if v6 then
        v8 = v6;
    else
        v8 = workspace:FindFirstChild("PassRig");

        if v8 and (v8:GetAttribute("IsTrainingDummy") and v8:FindFirstChild("HumanoidRootPart")) then
            local v9 = p3.HumanoidRootPart.CFrame.LookVector:Dot((v8.HumanoidRootPart.Position - p3.HumanoidRootPart.Position).Unit);
            local math_acos_ret = math.acos(v9);
            local Magnitude = (v8.HumanoidRootPart.Position - p3.HumanoidRootPart.Position).Magnitude;

            if math_acos_ret < 1.5707963267948966 then
                if Magnitude >= 23 then
                    v8 = v6;
                end;
            else
                v8 = v6;
            end;
        else
            v8 = v6;
        end;
    end;

    if v8 == nil then
        Popup.Popup(p2, "Another player must be infront of you!");

        return;
    end;

    local u10 = p2.PlayerStats.Style.Value == "Reo";
    u1:AbilityCooldown("2", u10 and 45 or 1);
    u1.Animations:StopAnims();
    u1.Animations.Abilities.Opposite.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Abilities.Opposite:Play();
    u1.Animations.Ball.Opposite.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Ball.Opposite:Play();
    u1.AbilityService.Ability:Fire("Opposite", {
        NEL = true,
        Target = v8
    });
    u1.StatesController.States.Ability = true;
    task.delay(0.7, function() -- Line: 84
        -- upvalues: u1 (copy)
        u1.StatesController.States.Ability = false;
    end);
    interface.PredatorStrike = true;
    task.delay(3, function() -- Line: 90
        -- upvalues: interface (ref), u10 (copy), u1 (copy)
        if interface.PredatorStrike and not u10 then
            interface.PredatorStrike = false;
            u1:AbilityCooldown("2", 45);
        end;
    end);
end;