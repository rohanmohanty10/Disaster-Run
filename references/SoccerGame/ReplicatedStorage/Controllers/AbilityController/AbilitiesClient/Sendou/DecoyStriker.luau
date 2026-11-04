  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("UserInputService");
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
game:GetService("TweenService");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
local Popup = require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local AbilityBalancing = require(ReplicatedStorage2.AbilityBalancing);
local AbilityUtils = require(ReplicatedStorage2.Shared.AbilityUtils);
local StatesController = require(ReplicatedStorage2.Controllers.StatesController);
local AnimationController = require(ReplicatedStorage2.Controllers.AnimationController);
require(ReplicatedStorage2.Controllers.CameraController);
local BallController = require(ReplicatedStorage2.Controllers.BallController);
local interface = require(ReplicatedStorage2.Controllers.AbilityController.interface);
local DecoyStriker = AbilityBalancing.DecoyStriker;
local LocalPlayer = Players.LocalPlayer;
local _ = workspace.CurrentCamera;

local function resetTiki(p1, p2) -- Line: 30
    -- upvalues: LocalPlayer (copy), interface (copy), DecoyStriker (copy), StatesController (copy)
    if not p1 then
        if LocalPlayer.PlayerStats.Style.Value == "Reo" then
            interface:AbilityCooldown(1, DecoyStriker.Cooldown);
        else
            interface:AbilityCooldown(2, DecoyStriker.Cooldown);
        end;
    end;

    p2:SetAttribute("TikiTaka", nil);
    interface.TikiTakaCharges = nil;
    StatesController.SpeedBoost = 0;
    StatesController.OwnWalkState = false;
end;

return function() -- Line: 46
    -- upvalues: AbilityUtils (copy), interface (copy), BallController (copy), ReplicatedStorage (copy), Players (copy), LocalPlayer (copy), Popup (copy), DecoyStriker (copy), StatesController (copy), AnimationController (copy), RunService (copy)
    if not (AbilityUtils.rules.grounded() and AbilityUtils.rules.slotReady(2)) then
        return;
    end;

    local ABC = interface.ABC;
    local Character, _, _, _ = AbilityUtils.getCharacter();
    local TikiTakaCharges = interface.TikiTakaCharges;
    local v3 = not TikiTakaCharges and 2 or TikiTakaCharges - 1;
    local Closest = BallController.Closest;
    print(interface.TikiTakaCharges);

    if v3 == 1 then
        Character:SetAttribute("TikiTaka", true);
        local v4 = 230;
        local v5 = nil;
        local Value = ReplicatedStorage.Football.Value.Char.Value;

        if not ReplicatedStorage.Football.Value.OnPlayer.Value or Players:GetPlayerFromCharacter(Value).Team ~= LocalPlayer.Team then
            Popup.Popup(LocalPlayer, "Teammate kicked it away");

            if LocalPlayer.PlayerStats.Style.Value == "Reo" then
                interface:AbilityCooldown(1, DecoyStriker.Cooldown);
            else
                interface:AbilityCooldown(2, DecoyStriker.Cooldown);
            end;

            Character:SetAttribute("TikiTaka", nil);
            interface.TikiTakaCharges = nil;
            StatesController.SpeedBoost = 0;
            StatesController.OwnWalkState = false;

            return;
        end;

        for _, v in Players:GetPlayers() do
            if v ~= LocalPlayer and (v.Character ~= Value and v.Team == LocalPlayer.Team) then
                local Magnitude = (v.Character.HumanoidRootPart.Position - Character.HumanoidRootPart.Position).Magnitude;

                if Magnitude < v4 then
                    v5 = v;
                    v4 = Magnitude;
                end;
            end;
        end;

        print(v5);

        if not v5 then
            Popup.Popup(LocalPlayer, "Teammates too far, sending back to player");

            if LocalPlayer.PlayerStats.Style.Value == "Reo" then
                interface:AbilityCooldown(1, DecoyStriker.Cooldown);
            else
                interface:AbilityCooldown(2, DecoyStriker.Cooldown);
            end;

            Character:SetAttribute("TikiTaka", nil);
            interface.TikiTakaCharges = nil;
            StatesController.SpeedBoost = 0;
            StatesController.OwnWalkState = false;

            return;
        end;

        Closest = v5.Character;
        print(v5);
    end;

    print(Closest);

    if not (Closest and Character) then
        Popup.Popup(LocalPlayer, "No player found to pass!");

        return;
    end;

    if (Closest.HumanoidRootPart.Position - Character.HumanoidRootPart.Position).Magnitude > 230 then
        Character:SetAttribute("TikiTaka", nil);
        interface.TikiTakaCharges = nil;
        StatesController.SpeedBoost = 0;
        StatesController.OwnWalkState = false;

        return Popup.Popup(LocalPlayer, "Player too far!");
    end;

    if not Closest then
        Character:SetAttribute("TikiTaka", nil);
        interface.TikiTakaCharges = nil;
        StatesController.SpeedBoost = 0;
        StatesController.OwnWalkState = false;

        return Popup.Popup(LocalPlayer, "No player found to pass!");
    end;

    interface.TikiTakaCharges = v3;
    interface:AbilityCooldown(2, 1);
    StatesController.States.Ability = true;
    ABC:Add(function() -- Line: 150
        print("cleaning");
    end);

    if interface.TikiTakaCharges == 2 then
        Character:SetAttribute("TikiTaka", true);
        StatesController.SpeedBoost = 5;
        StatesController.OwnWalkState = true;
        task.delay(7, function() -- Line: 158
            -- upvalues: AbilityUtils (ref), Character (copy), LocalPlayer (ref), interface (ref), DecoyStriker (ref), StatesController (ref)
            print(not AbilityUtils.rules.slotReady(2));

            if not AbilityUtils.rules.slotReady(2) then
                return;
            end;

            if LocalPlayer.PlayerStats.Style.Value == "Reo" then
                interface:AbilityCooldown(1, DecoyStriker.Cooldown);
            else
                interface:AbilityCooldown(2, DecoyStriker.Cooldown);
            end;

            Character:SetAttribute("TikiTaka", nil);
            interface.TikiTakaCharges = nil;
            StatesController.SpeedBoost = 0;
            StatesController.OwnWalkState = false;
        end);
        local Track = AnimationController:GetTrack("Abilities", "DecoyStriker");
        Track.Looped = false;
        Track.Priority = Enum.AnimationPriority.Action3;
        Track:Play();
    elseif interface.TikiTakaCharges == 1 then
        if LocalPlayer.PlayerStats.Style.Value == "Reo" then
            interface:AbilityCooldown(1, DecoyStriker.Cooldown);
        else
            interface:AbilityCooldown(2, DecoyStriker.Cooldown);
        end;

        Character:SetAttribute("TikiTaka", nil);
        interface.TikiTakaCharges = nil;
        StatesController.SpeedBoost = 0;
        StatesController.OwnWalkState = false;
    end;

    interface.AbilityService.Ability:Fire("DecoyStriker", Closest);
    ABC:Connect(interface.AbilityService.Ability, function(u6) -- Line: 175
        -- upvalues: StatesController (ref), Closest (ref), BallController (ref), ABC (copy), RunService (ref)
        StatesController.States.Ability = false;
        local HumanoidRootPart = u6.Char.Value.HumanoidRootPart;
        local HumanoidRootPart2 = Closest.HumanoidRootPart;
        local u7 = (HumanoidRootPart2.Position + HumanoidRootPart2.AssemblyLinearVelocity * Vector3.new(1, 0, 1) - HumanoidRootPart.Position).Unit + Vector3.new(0, 0.5, 0);
        local math_clamp_ret = math.clamp((HumanoidRootPart2.Position - HumanoidRootPart.Position).Magnitude * 1.5, 0, 150);
        u6.AssemblyLinearVelocity = u7 * math_clamp_ret;
        BallController:DragBall(u6);
        local u8 = tick();
        ABC:Connect(RunService.Heartbeat, function(p9) -- Line: 195
            -- upvalues: u8 (copy), u6 (copy), ABC (ref), HumanoidRootPart2 (copy), u7 (ref), math_clamp_ret (ref), HumanoidRootPart (copy)
            if tick() > u8 + 4 or (not u6 or u6.OnPlayer.Value) then
                return ABC:Clean();
            end;

            local _ = HumanoidRootPart2.AssemblyLinearVelocity * Vector3.new(1, 0, 1);
            local v10 = tick() > u8 + 0.55;
            u7 = u7:Lerp((HumanoidRootPart2.Position - u6.Position).Unit + Vector3.new(0, v10 and 0.15 or 0.35, 0), 6.5 * p9);
            math_clamp_ret = math.clamp((HumanoidRootPart2.Position - HumanoidRootPart.Position).Magnitude * 2.75, 0, 150);

            if u6.Position.Y < 5 or (HumanoidRootPart2.Position - u6.Position).Magnitude <= 7 then
                return ABC:Clean();
            end;

            u6.AssemblyLinearVelocity = u6.AssemblyLinearVelocity:Lerp(u7 * math_clamp_ret, 6.5 * p9);
        end);
    end);
end;