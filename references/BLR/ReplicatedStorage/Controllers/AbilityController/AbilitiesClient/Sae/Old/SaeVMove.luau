  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
local Players = game:GetService("Players");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("Debris");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
local Popup = require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);
local AbilityUtils = require(ReplicatedStorage2.Shared.AbilityUtils);
local DivineLift = require(script.Parent.DivineLift);
local script_CreativeDribble = require(script.CreativeDribble);

return function(p1, p2, p3, ...) -- Line: 21
    -- upvalues: AbilityUtils (copy), AbilityBalancing (copy), DivineLift (copy), Players (copy), Popup (copy), script_CreativeDribble (copy)
    if p1.AbilityTwo > tick() then
        return;
    end;

    if p1.AbilityUsed > tick() then
        return;
    end;

    if p3.Humanoid:GetState() == Enum.HumanoidStateType.Jumping or p3.Humanoid:GetState() == Enum.HumanoidStateType.Freefall then
        return;
    end;

    if p2.Character.IsRagdoll.Value then
        return;
    end;

    if p2.Character.Values.Stunned.Value then
        return;
    end;

    if not AbilityUtils.rules.onball() then
        return;
    end;

    local v4 = AbilityUtils.checks.enemyTarget(AbilityBalancing.CreativeDribble.ActivationRangePlayer);

    if p3:GetAttribute("DivineLift") or not v4 then
        return DivineLift(p1, p2, p3, ...);
    end;

    local v5 = nil;

    if not p3.Values.HasBall.Value then
        Popup.Popup(p2, "Must have ball and enemy must be in front of you!");

        return;
    end;

    local ActivationRangePlayer = AbilityBalancing.CreativeDribble.ActivationRangePlayer;
    local Players2 = Players:GetPlayers();

    for _, v in pairs(Players2) do
        if v.Team ~= game.Teams.Visitor and (v.Character:FindFirstChild("HumanoidRootPart") ~= nil and (v.Team ~= p2.Team and not (v.Character.Values.Goalie.Value and v.Character.Values.IsInPenalty.Value))) then
            local v6 = p3.HumanoidRootPart.CFrame.LookVector:Dot((v.Character.HumanoidRootPart.Position - p3.HumanoidRootPart.Position).Unit);
            local math_acos_ret = math.acos(v6);
            print(math_acos_ret < 1.5707963267948966);

            if math_acos_ret < 1.5707963267948966 and (not v.Character.Values.HasBall.Value and (p3.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).Magnitude <= ActivationRangePlayer) then
                v5 = v.Character;
                break;
            end;
        end;
    end;

    if not (v5 or (not workspace:FindFirstChild("PassRig") or (p3.HumanoidRootPart.Position - workspace.PassRig.HumanoidRootPart.Position).Magnitude > ActivationRangePlayer)) then
        local v7 = p3.HumanoidRootPart.CFrame.LookVector:Dot((workspace.PassRig.HumanoidRootPart.Position - p3.HumanoidRootPart.Position).Unit);

        if math.acos(v7) < 1.5707963267948966 then
            v5 = workspace.PassRig;
        end;
    end;

    if v5 then
        return script_CreativeDribble(p1, p2, p3, v5, ...);
    end;

    Popup.Popup(p2, "Player must be infront of you!");
end;