  

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
local Cobra = require(ReplicatedStorage.AbilityBalancing).Cobra;

return function(u1, u2, u3) -- Line: 16, Name: NinjaShot
    -- upvalues: Popup (copy), Cobra (copy), Players (copy), RunService (copy)
    if u2.Character.Values.HasBall.Value == true then
        Popup.Popup(u2, "Must not have ball!)");

        return;
    end;

    if u1.AbilityOne > tick() then
        return;
    end;

    if u1.AbilityUsed > tick() then
        return;
    end;

    if u1.ABC then
        u1.ABC:Clean();
    end;

    local ActivationRangePlayer = Cobra.ActivationRangePlayer;
    local Players2 = Players:GetPlayers();
    local v4 = {};
    local v5 = nil;

    for _, v in pairs(Players2) do
        if v.Team ~= game.Teams.Visitor and (v.Character:FindFirstChild("HumanoidRootPart") ~= nil and (v.Team ~= u2.Team and not (v.Character.Values.Goalie.Value and v.Character.Values.IsInPenalty.Value))) then
            local v6 = u3.HumanoidRootPart.CFrame.LookVector:Dot((v.Character.HumanoidRootPart.Position - u3.HumanoidRootPart.Position).Unit);
            local math_acos_ret = math.acos(v6);

            if math_acos_ret < 1.5707963267948966 or math_acos_ret < 1.9039955476301778 then
                table.insert(v4, v.Character);
            end;
        end;
    end;

    for _, v in pairs(v4) do
        local Magnitude = (v.HumanoidRootPart.Position - u3.HumanoidRootPart.Position).Magnitude;

        if v.Values.HasBall.Value and Magnitude < ActivationRangePlayer then
            v5 = v;
            ActivationRangePlayer = Magnitude;
        end;
    end;

    if not v5 then
        v5 = RunService:IsStudio() and workspace.PassRig;
    end;

    if not v5 then
        Popup.Popup(u2, "Must be infront of player with ball!");

        return;
    end;

    u1.AbilityService.Ability:Fire("Cobra", {
        enemy = v5
    });
    u1.ABC:Connect(u1.AbilityService.Ability, function(p7) -- Line: 64
        -- upvalues: u1 (copy), u3 (copy), Cobra (ref), Popup (ref), u2 (copy)
        print(p7);

        if not p7 then
            Popup.Popup(u2, "Cannot steal from this player!");

            return;
        end;

        local Shiftlock = u1.Camera.Shiftlock;
        u1.Camera:SetShiftlock(false);
        u1.Camera.Cutscene = true;
        u1.InAbility = true;
        u1.StatesController.States.Ability = true;
        u3.HumanoidRootPart.Anchored = true;
        u1:AbilityCooldown("1", Cobra.Cooldown);
        task.wait(0.1);
        print("Steal!");
        u1.ABC:Clean();
        u1.StatesController.States.Ability = false;
        u1.InAbility = false;
        u1.Camera.Cutscene = false;
        u3.HumanoidRootPart.Anchored = false;
        u1.Camera:SetShiftlock(Shiftlock);
    end);
end;