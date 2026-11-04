  

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

return function(u1, p2, p3) -- Line: 16, Name: Freestyle
    -- upvalues: Players (copy), Popup (copy)
    if p3.Values.HasBall.Value == false then
        return;
    end;

    if u1.AbilityOne > tick() then
        return;
    end;

    if p3.Humanoid:GetState() ~= Enum.HumanoidStateType.Running then
        return;
    end;

    if p2.PlayerStats.Stamina.Value <= 1 then
        return;
    end;

    if u1.ABC then
        u1.ABC:Clean();
    end;

    local Players2 = Players:GetPlayers();
    local v4 = {};
    local v5 = 18;
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

    table.clear(v4);
    table.clear(Players2);

    if v6 == nil then
        Popup.Popup(p2, "Another player must be infront of you!");

        return;
    end;

    if u1.DribbleUsed == nil then
        u1.DribbleUsed = 0;
    end;

    u1.DribbleUsed = u1.DribbleUsed + 1;

    if u1.DribbleUsed >= 1 then
        u1.DribbleUsed = 0;
        u1:AbilityCooldown("1", 60);
    else
        u1:AbilityCooldown("1", 1.5);
    end;

    u1.StatesController.SpeedBoost = 8;
    u1.Animations:StopAnims();
    local v8 = tostring(math.random(1, 4));
    u1.Animations.Abilities[`YukiDribble{v8}`].Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Abilities[`YukiDribble{v8}`]:Play();
    u1.Animations.Ball[`YukiDribble{v8}`].Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Ball[`YukiDribble{v8}`]:Play();
    u1.AbilityService.Ability:Fire("Freestyle", v6);
    task.delay(0.8, function() -- Line: 87
        -- upvalues: u1 (copy)
        u1.StatesController.SpeedBoost = 0;
    end);
end;