  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Shared.Trove);
local Popup = require(ReplicatedStorage.Shared.Popup);
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
local StatesController = require(ReplicatedStorage.Controllers.StatesController);
local AnimationController = require(ReplicatedStorage.Controllers.AnimationController);
local BallController = require(ReplicatedStorage.Controllers.BallController);
local interface = require(ReplicatedStorage.Controllers.AbilityController.interface);
local LocalPlayer = Players.LocalPlayer;

local function resetTiki(p1, p2) -- Line: 19
    -- upvalues: AbilityBalancing (copy), interface (copy), StatesController (copy)
    local EasterTikiTaka = AbilityBalancing.EasterTikiTaka;

    if not p1 then
        interface:AbilityCooldown(2, EasterTikiTaka.Cooldown);
    end;

    p2:SetAttribute("EasterTikiTaka", nil);
    interface._easterTikiTakaCharges = nil;
    StatesController.States.SpeedBoost = 0;
end;

return function() -- Line: 29
    -- upvalues: AbilityBalancing (copy), AbilityUtils (copy), LocalPlayer (copy), interface (copy), StatesController (copy), BallController (copy), RunService (copy), ReplicatedStorage (copy), Players (copy), Popup (copy), AnimationController (copy)
    local _ = AbilityBalancing.EasterTikiTaka;

    if not AbilityUtils.rules.slotReady(2) then
        return;
    end;

    local Character, _, _, _ = AbilityUtils.getCharacter();
    local v3 = LocalPlayer;
    interface:AbilityCooldown(2, 1);

    if interface._easterTikiTakaCharges then
        local v4 = interface;
        v4._easterTikiTakaCharges = v4._easterTikiTakaCharges - 1;
    else
        Character:SetAttribute("EasterTikiTaka", true);
        interface._easterTikiTakaCharges = 3;
        StatesController.States.SpeedBoost = 5;
        task.delay(10, function() -- Line: 45
            -- upvalues: AbilityUtils (ref), Character (copy), AbilityBalancing (ref), interface (ref), StatesController (ref)
            if not AbilityUtils.rules.slotReady(2) then
                return;
            end;

            interface:AbilityCooldown(2, AbilityBalancing.EasterTikiTaka.Cooldown);
            Character:SetAttribute("EasterTikiTaka", nil);
            interface._easterTikiTakaCharges = nil;
            StatesController.States.SpeedBoost = 0;
        end);
    end;

    local Closest = BallController.Closest;

    if RunService:IsStudio() then
        if ReplicatedStorage.Football.Value.Char.Value == workspace.PassRig then
            Closest = Character;
        else
            Closest = workspace.PassRig;
        end;
    elseif interface._easterTikiTakaCharges == 2 then
        Character:SetAttribute("EasterTikiTaka", true);
        local v5 = 230;
        local v6 = nil;
        local Value = ReplicatedStorage.Football.Value.Char.Value;

        if not ReplicatedStorage.Football.Value.OnPlayer.Value or Players:GetPlayerFromCharacter(Value).Team ~= v3.Team then
            Popup.Popup(v3, "Teammate kicked it away");
            interface:AbilityCooldown(2, AbilityBalancing.EasterTikiTaka.Cooldown);
            Character:SetAttribute("EasterTikiTaka", nil);
            interface._easterTikiTakaCharges = nil;
            StatesController.States.SpeedBoost = 0;

            return;
        end;

        for _, v in Players:GetPlayers() do
            if v ~= v3 and (v.Character ~= Value and v.Team == v3.Team) then
                local Magnitude = (v.Character.HumanoidRootPart.Position - Character.HumanoidRootPart.Position).Magnitude;

                if Magnitude < v5 then
                    v6 = v;
                    v5 = Magnitude;
                end;
            end;
        end;

        if not v6 then
            Popup.Popup(v3, "Teammates too far, sending back to player");
            interface:AbilityCooldown(2, AbilityBalancing.EasterTikiTaka.Cooldown);
            Character:SetAttribute("EasterTikiTaka", nil);
            interface._easterTikiTakaCharges = nil;
            StatesController.States.SpeedBoost = 0;

            return;
        end;

        Closest = v6.Character;
    elseif interface._easterTikiTakaCharges == 1 then
        Character:SetAttribute("EasterTikiTaka", true);

        if not ReplicatedStorage.Football.Value.OnPlayer.Value or Players:GetPlayerFromCharacter(ReplicatedStorage.Football.Value.Char.Value).Team ~= v3.Team then
            Popup.Popup(v3, "Teammate kicked it away");
            interface:AbilityCooldown(2, AbilityBalancing.EasterTikiTaka.Cooldown);
            Character:SetAttribute("EasterTikiTaka", nil);
            interface._easterTikiTakaCharges = nil;
            StatesController.States.SpeedBoost = 0;

            return;
        end;

        Closest = Character;
    end;

    if not (Closest and Character) then
        return;
    end;

    if (Closest.HumanoidRootPart.Position - Character.HumanoidRootPart.Position).Magnitude <= 230 then
        StatesController.States.Ability = true;
        local ABC = interface.ABC;
        ABC:Clean();

        if interface._easterTikiTakaCharges == 3 then
            AnimationController:StopAnims();
            local Track = AnimationController:GetTrack("Abilities", "TikiTaka1");
            Track.Priority = Enum.AnimationPriority.Action4;
            Track:Play();
        elseif interface._easterTikiTakaCharges == 1 then
            interface:AbilityCooldown(2, AbilityBalancing.EasterTikiTaka.Cooldown);
            Character:SetAttribute("EasterTikiTaka", nil);
            interface._easterTikiTakaCharges = nil;
            StatesController.States.SpeedBoost = 0;
        end;

        interface.AbilityService.Ability:Fire("EasterTikiTaka", Closest);
        ABC:Connect(interface.AbilityService.Ability, function(u7) -- Line: 140
            -- upvalues: StatesController (ref), Closest (ref), BallController (ref), ABC (copy), RunService (ref)
            StatesController.States.Ability = false;
            local HumanoidRootPart = u7.Char.Value.HumanoidRootPart;
            local HumanoidRootPart2 = Closest.HumanoidRootPart;
            local u8 = (HumanoidRootPart2.Position + HumanoidRootPart2.AssemblyLinearVelocity * Vector3.new(1, 0, 1) - HumanoidRootPart.Position).Unit + Vector3.new(0, 0.5, 0);
            local math_clamp_ret = math.clamp((HumanoidRootPart2.Position - HumanoidRootPart.Position).Magnitude * 1.5, 0, 150);
            u7.AssemblyLinearVelocity = u8 * math_clamp_ret;
            BallController:DragBall(u7);
            local u9 = tick();
            ABC:Connect(RunService.Heartbeat, function(p10) -- Line: 158
                -- upvalues: u9 (copy), u7 (copy), ABC (ref), HumanoidRootPart2 (copy), u8 (ref), math_clamp_ret (ref), HumanoidRootPart (copy)
                if tick() > u9 + 4 or (not u7 or u7.OnPlayer.Value) then
                    return ABC:Clean();
                end;

                local _ = HumanoidRootPart2.AssemblyLinearVelocity * Vector3.new(1, 0, 1);
                local v11 = tick() > u9 + 0.55;
                u8 = u8:Lerp((HumanoidRootPart2.Position - u7.Position).Unit + Vector3.new(0, v11 and 0.15 or 0.35, 0), 6.5 * p10);
                math_clamp_ret = math.clamp((HumanoidRootPart2.Position - HumanoidRootPart.Position).Magnitude * 2.75, 0, 150);

                if u7.Position.Y < 5 or (HumanoidRootPart2.Position - u7.Position).Magnitude <= 7 then
                    return ABC:Clean();
                end;

                u7.AssemblyLinearVelocity = u7.AssemblyLinearVelocity:Lerp(u8 * math_clamp_ret, 6.5 * p10);
            end);
        end);

        return true;
    end;

    local _ = AbilityBalancing.EasterTikiTaka;
    Character:SetAttribute("EasterTikiTaka", nil);
    interface._easterTikiTakaCharges = nil;
    StatesController.States.SpeedBoost = 0;
    Popup.Popup(v3, "Player too far!");
end;