  

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

return function(u1, u2, u3) -- Line: 16
    -- upvalues: Popup (copy), Players (copy)
    if u2.Character.Values.HasBall.Value == true then
        Popup.Popup(u2, "Must not have ball!)");

        return;
    end;

    if u1.AbilityTwo > tick() then
        return;
    end;

    if u1.AbilityUsed > tick() then
        return;
    end;

    if u3.Humanoid:GetState() == Enum.HumanoidStateType.Freefall then
        return;
    end;

    if u1.ABC then
        u1.ABC:Clean();
    end;

    local Players2 = Players:GetPlayers();
    local v4 = {};
    local v5 = 60;
    local v6 = nil;

    for _, v in pairs(Players2) do
        if v.Team ~= game.Teams.Visitor and (v.Character:FindFirstChild("HumanoidRootPart") ~= nil and (v.Team ~= u2.Team and not (v.Character.Values.Goalie.Value and v.Character.Values.IsInPenalty.Value))) then
            local v7 = u3.HumanoidRootPart.CFrame.LookVector:Dot((v.Character.HumanoidRootPart.Position - u3.HumanoidRootPart.Position).Unit);
            local math_acos_ret = math.acos(v7);

            if math_acos_ret < 1.5707963267948966 or math_acos_ret < 1.9039955476301778 then
                table.insert(v4, v.Character);
            end;
        end;
    end;

    local PassRig = workspace:FindFirstChild("PassRig");

    if PassRig and (PassRig:GetAttribute("IsTrainingDummy") and PassRig:FindFirstChild("HumanoidRootPart")) then
        table.insert(v4, PassRig);
    end;

    for _, v in pairs(v4) do
        local Magnitude = (v.HumanoidRootPart.Position - u3.HumanoidRootPart.Position).Magnitude;

        if v.Values.HasBall.Value and Magnitude < v5 then
            v6 = v;
            v5 = Magnitude;
        end;
    end;

    local v8;

    if v6 then
        v8 = v6;
    else
        v8 = workspace:FindFirstChild("PassRig");

        if v8 then
            if not v8:GetAttribute("IsTrainingDummy") then
                v8 = v6;
            end;
        else
            v8 = v6;
        end;
    end;

    if not v8 then
        Popup.Popup(u2, "Must be infront of player with ball!");

        return;
    end;

    if u2.PlayerStats.Style.Value == "Reo" then
        u1:AbilityCooldown("1", 80);
    end;

    u1.AbilityService.Ability:Fire("TooSlow", {
        enemy = v8
    });
    u1.ABC:Connect(u1.AbilityService.Ability, function(p9) -- Line: 79
        -- upvalues: u1 (copy), u3 (copy), u2 (copy), Popup (ref)
        if not p9 then
            Popup.Popup(u2, "Cannot steal from this player!");

            return;
        end;

        local Shiftlock = u1.Camera.Shiftlock;
        u1.Camera:SetShiftlock(false);
        u1.Camera.Cutscene = true;
        u1.InAbility = true;
        u1.StatesController.States.Ability = true;
        u3.HumanoidRootPart.Anchored = true;
        u1:AbilityCooldown(u2.PlayerStats.Style.Value == "Reo" and "1" or "2", 80);
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