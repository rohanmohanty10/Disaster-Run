  

local Players = game:GetService("Players");
game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local Popup = require(ReplicatedStorage.Shared.Popup);

return function(u1, p2, u3, p4) -- Line: 7
    -- upvalues: Players (copy), Popup (copy)
    local v5;

    if u3 then
        v5 = u3:FindFirstChild("HumanoidRootPart");
    else
        v5 = u3;
    end;

    if not v5 then
        return;
    end;

    print(p4);

    if u3:HasTag("PlanetHotline") then
        u1:AbilityCooldown("3", 90);
        u1.AbilityService.Ability:Fire("PlanetHotline");

        return;
    end;

    u1:AbilityCooldown("1", 0);

    if u1.AbilityThree > tick() then
        return;
    end;

    if not u3.Values.HasBall.Value then
        return;
    end;

    local Closest = u1.BallController.Closest;

    if u3:HasTag("Kurona-NELIsagi-CR") then
        local _ = Players:FindFirstChild(u3:GetAttribute("CR_OtherPlayer")) and Players:FindFirstChild(Closest);
        Closest = workspace.PassRig;
    end;

    local v6;

    if Closest then
        v6 = Players:GetPlayerFromCharacter(Closest);
    else
        v6 = Closest;
    end;

    local v7;

    if Closest then
        v7 = Closest:FindFirstChild("HumanoidRootPart");
    else
        v7 = Closest;
    end;

    local v8 = v7 and ((v5.Position - v7.Position).Magnitude or 9e99) or 9e99;

    if not v7 then
        return Popup.Popup(u1.Player, "No player found to pass!");
    end;

    if v8 > 150 then
        return Popup.Popup(u1.Player, "Too far!");
    end;

    if v6 and v6.PlayerStats.Style.Value == "Kurona" then
        return Popup.Popup(u1.Player, "Can\'t Planet Hotline with another Kurona!");
    end;

    u1.Animations:StopAnims();
    u1.Animations.Abilities.PlanetHotline.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Abilities.PlanetHotline:Play();
    task.delay(5, function() -- Line: 60
        -- upvalues: u1 (copy)
        u1.Animations.Abilities.PlanetHotline:Stop();
    end);
    u1.AbilityService.Ability:Fire("PlanetHotline", Closest);
    local u9 = tick();
    local u10 = p2.PlayerGui.InGameUI.Bottom.Abilities:FindFirstChild("3");

    if u10 then
        local UIScale = u10:FindFirstChild("UIScale");
        UIScale.Scale = 1.3;
        u10.ImageColor3 = Color3.fromRGB(255, 200, 0);
        task.spawn(function() -- Line: 75
            -- upvalues: u3 (copy), u9 (copy), UIScale (copy), u10 (copy)
            repeat
                task.wait();
            until u3:HasTag("PlanetHotline") or tick() - u9 > 3;

            repeat
                task.wait();
            until not u3:HasTag("PlanetHotline");

            UIScale.Scale = 1;
            u10.ImageColor3 = Color3.fromRGB(255, 255, 255);
        end);
    end;

    task.spawn(function() -- Line: 83
        -- upvalues: u3 (copy), u9 (copy), u1 (copy)
        repeat
            task.wait();
        until u3:HasTag("PlanetHotline") or tick() - u9 > 3;

        repeat
            task.wait();
        until not u3:HasTag("PlanetHotline");

        u1:AbilityCooldown("3", 90);
    end);
    Popup.Popup(u1.Player, (`Your partner is {Closest.Name}!`));
end;