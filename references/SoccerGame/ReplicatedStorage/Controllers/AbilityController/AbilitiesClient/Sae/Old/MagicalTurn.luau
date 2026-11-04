  

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
local HeelFlick = require(script.Parent.HeelFlick);

return function(u1, p2, u3) -- Line: 17, Name: MagicalTurn
    -- upvalues: HeelFlick (copy), Players (copy), RunService (copy), Popup (copy)
    if u3.Values.HasBall.Value == false then
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

    if u3:GetAttribute("HeelFlick") then
        return HeelFlick(u1, p2, u3);
    end;

    local Players2 = Players:GetPlayers();
    local v4 = {};
    local v5 = 27;
    local v6 = nil;

    for _, v in pairs(Players2) do
        if v.Team ~= game.Teams.Visitor and (v.Character:FindFirstChild("HumanoidRootPart") ~= nil and (v.Team ~= p2.Team and not (v.Character.Values.Goalie.Value and v.Character.Values.IsInPenalty.Value))) then
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

    if RunService:IsStudio() then
        v6 = workspace.PassRig;
    end;

    if v6 == nil then
        Popup.Popup(p2, "Another player must be infront of you!");

        return;
    end;

    u1:AbilityCooldown("2", 1);
    u1.AbilityUsed = tick() + 1;
    u1.Animations:StopAnims();
    u1.Animations.Abilities.MagicalTurn.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Abilities.MagicalTurn:Play();
    u1.Animations.Ball.MagicalTurn.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Ball.MagicalTurn:Play();
    u1.AbilityService.Ability:Fire("MagicalTurn", v6);
    u3:SetAttribute("HeelFlick", true);
    task.delay(2, function() -- Line: 80
        -- upvalues: u3 (copy), u1 (copy)
        u3:SetAttribute("HeelFlick", nil);
        u1:AbilityCooldown("2", 45);
    end);
end;