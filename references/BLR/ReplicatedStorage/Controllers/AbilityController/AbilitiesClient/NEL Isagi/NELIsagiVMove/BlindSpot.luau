  

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

return function(p1, p2, p3) -- Line: 16, Name: BlindSpot
    -- upvalues: Players (copy), RunService (copy), Popup (copy)
    if p3.Values.HasBall.Value then
        return;
    end;

    if p1.AbilityTwo > tick() then
        return;
    end;

    if p1.AbilityUsed > tick() then
        return;
    end;

    if p1.ABC then
        p1.ABC:Clean();
    end;

    local Players2 = Players:GetPlayers();
    local v4 = {};
    local v5 = 27;
    local v6 = nil;

    for _, v in Players2 do
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

    table.clear(v4);
    table.clear(Players2);

    if RunService:IsStudio() then
        v6 = workspace.PassRig;
    end;

    if v6 == nil then
        Popup.Popup(p2, "Another player must be infront of you!");

        return;
    end;

    p1:AbilityCooldown("2", 45);
    p1.AbilityUsed = tick() + 1;
    p1.Animations:StopAnims();
    p1.Animations.Abilities.BlindSpot.Priority = Enum.AnimationPriority.Action4;
    p1.Animations.Abilities.BlindSpot:Play();
    p1.Animations.Ball.BlindSpotBall.Priority = Enum.AnimationPriority.Action4;
    p1.Animations.Ball.BlindSpotBall:Play();
    p1.AbilityService.Ability:Fire("NELBlindSpot", v6);
end;