  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
game:GetService("TweenService");
local RunService2 = game:GetService("RunService");
game:GetService("TweenService");
game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
local Popup = require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);

local function resetTiki(p1, p2, p3) -- Line: 16
    print("reset tiki");

    if not p2 then
        p1:AbilityCooldown("3", 45);
    end;

    p3:SetAttribute("TikiTaka", nil);
    p1.TikiTakaCharges = nil;
    p1.StatesController.SpeedBoost = 0;
    p1.StatesController.OwnWalkState = false;
end;

return function(u4, p5, u6, p7) -- Line: 27
    -- upvalues: RunService (copy), ReplicatedStorage (copy), Players (copy), Popup (copy), RunService2 (copy)
    if u4.AbilityOne > tick() then
        return;
    end;

    u4:AbilityCooldown("3", 1);

    if u4.TikiTakaCharges then
        u4.TikiTakaCharges = u4.TikiTakaCharges - 1;
    else
        u6:SetAttribute("TikiTaka", true);
        u4.TikiTakaCharges = 3;
        u4.StatesController.SpeedBoost = 5;
        u4.StatesController.OwnWalkState = true;
        task.delay(10, function() -- Line: 37
            -- upvalues: u4 (copy), u6 (copy)
            if u4.AbilityOne > tick() then
                return;
            end;

            local v8 = u4;
            print("reset tiki");
            v8:AbilityCooldown("3", 45);
            u6:SetAttribute("TikiTaka", nil);
            v8.TikiTakaCharges = nil;
            v8.StatesController.SpeedBoost = 0;
            v8.StatesController.OwnWalkState = false;
        end);
    end;

    local Closest = u4.BallController.Closest;

    if RunService:IsStudio() then
        if ReplicatedStorage.Football.Value.Char.Value == workspace.PassRig then
            Closest = u6;
        else
            Closest = workspace.PassRig;
        end;
    elseif u4.TikiTakaCharges == 2 then
        u6:SetAttribute("TikiTaka", true);
        local v9 = 230;
        local v10 = nil;
        local Value = ReplicatedStorage.Football.Value.Char.Value;

        if not ReplicatedStorage.Football.Value.OnPlayer.Value or Players:GetPlayerFromCharacter(Value).Team ~= p5.Team then
            Popup.Popup(p5, "Teammate kicked it away");
            print("reset tiki");
            u4:AbilityCooldown("3", 45);
            u6:SetAttribute("TikiTaka", nil);
            u4.TikiTakaCharges = nil;
            u4.StatesController.SpeedBoost = 0;
            u4.StatesController.OwnWalkState = false;

            return;
        end;

        for _, v in Players:GetPlayers() do
            if v ~= p5 and (v.Character ~= Value and v.Team == p5.Team) then
                local Magnitude = (v.Character.HumanoidRootPart.Position - u6.HumanoidRootPart.Position).Magnitude;

                if Magnitude < v9 then
                    v10 = v;
                    v9 = Magnitude;
                end;
            end;
        end;

        if not v10 then
            Popup.Popup(p5, "Teammates too far, sending back to player");
            print("reset tiki");
            u4:AbilityCooldown("3", 45);
            u6:SetAttribute("TikiTaka", nil);
            u4.TikiTakaCharges = nil;
            u4.StatesController.SpeedBoost = 0;
            u4.StatesController.OwnWalkState = false;

            return;
        end;

        Closest = v10.Character;
    elseif u4.TikiTakaCharges == 1 then
        u6:SetAttribute("TikiTaka", true);

        if not ReplicatedStorage.Football.Value.OnPlayer.Value or Players:GetPlayerFromCharacter(ReplicatedStorage.Football.Value.Char.Value).Team ~= p5.Team then
            Popup.Popup(p5, "Teammate kicked it away");
            print("reset tiki");
            u4:AbilityCooldown("3", 45);
            u6:SetAttribute("TikiTaka", nil);
            u4.TikiTakaCharges = nil;
            u4.StatesController.SpeedBoost = 0;
            u4.StatesController.OwnWalkState = false;

            return;
        end;

        Closest = u6;
    end;

    if not (Closest and u6) then
        return;
    end;

    if (Closest.HumanoidRootPart.Position - u6.HumanoidRootPart.Position).Magnitude > 230 then
        print("reset tiki");
        u6:SetAttribute("TikiTaka", nil);
        u4.TikiTakaCharges = nil;
        u4.StatesController.SpeedBoost = 0;
        u4.StatesController.OwnWalkState = false;

        return Popup.Popup(u4.Player, "Player too far!");
    end;

    if not Closest then
        print("reset tiki");
        u6:SetAttribute("TikiTaka", nil);
        u4.TikiTakaCharges = nil;
        u4.StatesController.SpeedBoost = 0;
        u4.StatesController.OwnWalkState = false;

        return Popup.Popup(u4.Player, "No player found to pass!");
    end;

    u4.StatesController.States.Ability = true;

    if u4.ABC then
        u4.ABC:Clean();
    end;

    if u4.TikiTakaCharges == 3 then
        u4.Animations:StopAnims();
        u4.Animations.Abilities.TikiTaka1.Priority = Enum.AnimationPriority.Action4;
        u4.Animations.Abilities.TikiTaka1:Play();
    elseif u4.TikiTakaCharges == 1 then
        print("reset tiki");
        u4:AbilityCooldown("3", 45);
        u6:SetAttribute("TikiTaka", nil);
        u4.TikiTakaCharges = nil;
        u4.StatesController.SpeedBoost = 0;
        u4.StatesController.OwnWalkState = false;
    end;

    u4.AbilityService.Ability:Fire("TikiTaka", Closest);
    u4.ABC:Connect(u4.AbilityService.Ability, function(u11) -- Line: 139
        -- upvalues: u4 (copy), Closest (ref), RunService2 (ref)
        u4.StatesController.States.Ability = false;
        local HumanoidRootPart = u11.Char.Value.HumanoidRootPart;
        local HumanoidRootPart2 = Closest.HumanoidRootPart;
        local u12 = (HumanoidRootPart2.Position + HumanoidRootPart2.AssemblyLinearVelocity * Vector3.new(1, 0, 1) - HumanoidRootPart.Position).Unit + Vector3.new(0, 0.5, 0);
        local math_clamp_ret = math.clamp((HumanoidRootPart2.Position - HumanoidRootPart.Position).Magnitude * 1.5, 0, 150);
        u11.AssemblyLinearVelocity = u12 * math_clamp_ret;
        u4.BallController:DragBall(u11);
        local u13 = tick();
        u4.ABC:Connect(RunService2.Heartbeat, function(p14) -- Line: 159
            -- upvalues: u13 (copy), u11 (copy), u4 (ref), HumanoidRootPart2 (copy), u12 (ref), math_clamp_ret (ref), HumanoidRootPart (copy)
            if tick() > u13 + 4 or (not u11 or u11.OnPlayer.Value) then
                return u4.ABC:Clean();
            end;

            local _ = HumanoidRootPart2.AssemblyLinearVelocity * Vector3.new(1, 0, 1);
            local v15 = tick() > u13 + 0.55;
            u12 = u12:Lerp((HumanoidRootPart2.Position - u11.Position).Unit + Vector3.new(0, v15 and 0.15 or 0.35, 0), 6.5 * p14);
            math_clamp_ret = math.clamp((HumanoidRootPart2.Position - HumanoidRootPart.Position).Magnitude * 2.75, 0, 150);

            if u11.Position.Y < 5 or (HumanoidRootPart2.Position - u11.Position).Magnitude <= 7 then
                return u4.ABC:Clean();
            end;

            u11.AssemblyLinearVelocity = u11.AssemblyLinearVelocity:Lerp(u12 * math_clamp_ret, 6.5 * p14);
        end);
    end);
end;