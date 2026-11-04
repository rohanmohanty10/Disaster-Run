  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
local Players = game:GetService("Players");
game:GetService("RunService");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
game:GetService("TweenService");
game:GetService("Debris");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
local Popup = require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);
local StatesController = require(ReplicatedStorage.Controllers.StatesController);
local BallController = require(ReplicatedStorage.Controllers.BallController);
local AnimationController = require(ReplicatedStorage.Controllers.AnimationController);
local interface = require(ReplicatedStorage2.Controllers.AbilityController.interface);
local LocalPlayer = Players.LocalPlayer;
local HeelCenter = AbilityBalancing.HeelCenter;

local function resetHC(p1, p2, p3) -- Line: 29
    -- upvalues: HeelCenter (copy), StatesController (copy)
    if not p2 then
        p1:AbilityCooldown(3, HeelCenter.Cooldown);
    end;

    p1.HeelCenter = nil;
    p1.HeelCenterCharges = nil;
    StatesController.SpeedBoost = 0;
    StatesController.OwnWalkState = false;
    p1.HCPassedTo = nil;
end;

return function() -- Line: 40
    -- upvalues: AbilityUtils (copy), LocalPlayer (copy), interface (copy), BallController (copy), Popup (copy), HeelCenter (copy), StatesController (copy), ReplicatedStorage (copy), Players (copy), AnimationController (copy), RunService (copy)
    local v4 = AbilityUtils.rules.onball(nil, false);

    if not (AbilityUtils.rules.grounded() and AbilityUtils.rules.slotReady(3)) then
        return;
    end;

    local character = LocalPlayer.character;
    local HeelCenterCharges = interface.HeelCenterCharges;
    local Closest = BallController.Closest;
    print(interface.HeelCenterCharges);

    if interface.HeelCenterCharges == 2 or not interface.HeelCenterCharges then
        if not AbilityUtils.rules.onball(LocalPlayer) then
            if interface.HeelCenterCharges == 2 then
                Popup.Popup(LocalPlayer, "Teammate kicked it away");
                local v5 = interface;
                v5:AbilityCooldown(3, HeelCenter.Cooldown);
                v5.HeelCenter = nil;
                v5.HeelCenterCharges = nil;
                StatesController.SpeedBoost = 0;
                StatesController.OwnWalkState = false;
                v5.HCPassedTo = nil;
            end;

            return;
        end;

        interface.HeelCenter = true;
        local ActivationRangePlayer = HeelCenter.ActivationRangePlayer;
        local v6 = nil;
        local Value = ReplicatedStorage.Football.Value.Char.Value;
        local Value2 = ReplicatedStorage.Football.Value.OnPlayer.Value;
        local PlayerFromCharacter = Players:GetPlayerFromCharacter(Value);
        local v7;

        if Value then
            v7 = Value:GetAttribute("IsTrainingDummy");
        else
            v7 = Value;
        end;

        if not (Value2 and (v7 or PlayerFromCharacter and PlayerFromCharacter.Team == LocalPlayer.Team)) then
            if interface.HeelCenterCharges == 2 then
                Popup.Popup(LocalPlayer, "Teammate kicked it away");
                local v8 = interface;
                v8:AbilityCooldown(3, HeelCenter.Cooldown);
                v8.HeelCenter = nil;
                v8.HeelCenterCharges = nil;
                StatesController.SpeedBoost = 0;
                StatesController.OwnWalkState = false;
                v8.HCPassedTo = nil;
            end;

            return;
        end;

        for _, v in Players:GetPlayers() do
            if v ~= LocalPlayer and (v.Character ~= Value and (v.Team == LocalPlayer.Team and not v.Character.Values.InCutscene.Value)) then
                local Magnitude = (v.Character.HumanoidRootPart.Position - character.HumanoidRootPart.Position).Magnitude;

                if Magnitude < ActivationRangePlayer then
                    v6 = v;
                    ActivationRangePlayer = Magnitude;
                end;
            end;
        end;

        if not v6 then
            local PassRig = workspace:FindFirstChild("PassRig");
            v6 = PassRig and (PassRig:GetAttribute("IsTrainingDummy") and (PassRig:FindFirstChild("HumanoidRootPart") and (PassRig.HumanoidRootPart.Position - character.HumanoidRootPart.Position).Magnitude < ActivationRangePlayer)) and {
                Character = PassRig
            } or v6;
        end;

        if not v6 then
            if interface.HeelCenterCharges == 2 then
                Popup.Popup(LocalPlayer, "Teammates too far, sending back to player");
                local v9 = interface;
                v9:AbilityCooldown(3, HeelCenter.Cooldown);
                v9.HeelCenter = nil;
                v9.HeelCenterCharges = nil;
                StatesController.SpeedBoost = 0;
                StatesController.OwnWalkState = false;
                v9.HCPassedTo = nil;
            end;

            return;
        end;

        Closest = v6.Character;
        interface.HCPassedTo = Closest;
    elseif interface.HeelCenterCharges == 3 then
        interface.HeelCenter = true;
        local Value = ReplicatedStorage.Football.Value.Char.Value;
        local Value2 = ReplicatedStorage.Football.Value.OnPlayer.Value;
        print(interface.HCPassedTo);
        local PlayerFromCharacter = Players:GetPlayerFromCharacter(Value);

        if Value then
            Value = Value:GetAttribute("IsTrainingDummy");
        end;

        if Value then
            if not Value2 then
                Popup.Popup(LocalPlayer, "Teammate kicked it away");
                local v10 = interface;
                v10:AbilityCooldown(3, HeelCenter.Cooldown);
                v10.HeelCenter = nil;
                v10.HeelCenterCharges = nil;
                StatesController.SpeedBoost = 0;
                StatesController.OwnWalkState = false;
                v10.HCPassedTo = nil;

                return;
            end;

            Closest = character;
        else
            if not (PlayerFromCharacter and (PlayerFromCharacter.Team == LocalPlayer.Team and (Value2 and (PlayerFromCharacter ~= LocalPlayer and (PlayerFromCharacter.Character == interface.HCPassedTo and not PlayerFromCharacter.Character.Values.InCutscene.Value))))) then
                Popup.Popup(LocalPlayer, "Teammate kicked it away");
                local v11 = interface;
                v11:AbilityCooldown(3, HeelCenter.Cooldown);
                v11.HeelCenter = nil;
                v11.HeelCenterCharges = nil;
                StatesController.SpeedBoost = 0;
                StatesController.OwnWalkState = false;
                v11.HCPassedTo = nil;

                return;
            end;

            Closest = character;
        end;
    end;

    if not character and character.Humanoid.Health > 0 then
        return;
    end;

    if interface.HeelCenterCharges == 3 and v4 then
        local v12 = interface;
        v12.HeelCenter = nil;
        v12.HeelCenterCharges = nil;
        StatesController.SpeedBoost = 0;
        StatesController.OwnWalkState = false;
        v12.HCPassedTo = nil;

        return Popup.Popup(LocalPlayer, "No player found to pass!");
    end;

    if not Closest then
        return Popup.Popup(LocalPlayer, "No player found to pass!");
    end;

    if (Closest.HumanoidRootPart.Position - character.HumanoidRootPart.Position).Magnitude > HeelCenter.ActivationRangePlayer then
        local v13 = interface;
        v13.HeelCenter = nil;
        v13.HeelCenterCharges = nil;
        StatesController.SpeedBoost = 0;
        StatesController.OwnWalkState = false;
        v13.HCPassedTo = nil;

        return Popup.Popup(LocalPlayer, "Player too far!");
    end;

    if interface.HeelCenterCharges then
        local v14 = interface;
        v14.HeelCenterCharges = v14.HeelCenterCharges - 1;
    else
        interface.HeelCenter = true;
        interface.HeelCenterCharges = 3;
        StatesController.OwnWalkState = true;
        task.delay(10, function() -- Line: 172
            -- upvalues: AbilityUtils (ref), interface (ref), character (copy), HeelCenter (ref), StatesController (ref)
            if AbilityUtils.rules.slotReady(3) then
                return;
            end;

            local v15 = interface;
            v15:AbilityCooldown(3, HeelCenter.Cooldown);
            v15.HeelCenter = nil;
            v15.HeelCenterCharges = nil;
            StatesController.SpeedBoost = 0;
            StatesController.OwnWalkState = false;
            v15.HCPassedTo = nil;
        end);
    end;

    StatesController.States.Ability = true;

    if interface.ABC then
        interface.ABC:Clean();
    end;

    local ABC = interface.ABC;

    local function PlayAnim() -- Line: 187
        -- upvalues: AnimationController (ref)
        local Track = AnimationController:GetTrack("Abilities", "HeelCenter");
        Track.Looped = false;
        Track.Priority = Enum.AnimationPriority.Action3;
        Track:Play();
        local BallTrack = AnimationController:GetBallTrack("HeelCenterBall");
        BallTrack.Looped = false;
        BallTrack.Priority = Enum.AnimationPriority.Action4;
        BallTrack:Play();
    end;

    if interface.HeelCenterCharges == 3 then
        PlayAnim();
    elseif interface.HeelCenterCharges == 1 then
        PlayAnim();
        local v16 = interface;
        v16:AbilityCooldown(3, HeelCenter.Cooldown);
        v16.HeelCenter = nil;
        v16.HeelCenterCharges = nil;
        StatesController.SpeedBoost = 0;
        StatesController.OwnWalkState = false;
        v16.HCPassedTo = nil;
    end;

    interface.AbilityService.Ability:Fire("HeelCenter", Closest);
    ABC:Connect(interface.AbilityService.Ability, function(u17) -- Line: 208
        -- upvalues: StatesController (ref), Closest (ref), BallController (ref), ABC (copy), RunService (ref), HeelCenterCharges (copy), interface (ref), character (copy), HeelCenter (ref)
        StatesController.States.Ability = false;
        local HumanoidRootPart = u17.Char.Value.HumanoidRootPart;
        local HumanoidRootPart2 = Closest.HumanoidRootPart;
        local u18 = (HumanoidRootPart2.Position + HumanoidRootPart2.AssemblyLinearVelocity * Vector3.new(1, 0, 1) - HumanoidRootPart.Position).Unit + Vector3.new(0, 0.25, 0);
        local math_clamp_ret = math.clamp((HumanoidRootPart2.Position - HumanoidRootPart.Position).Magnitude, 0, 150);
        u17.AssemblyLinearVelocity = u18 * math_clamp_ret;
        BallController:DragBall(u17);
        local u19 = tick();
        ABC:Connect(RunService.Heartbeat, function(p20) -- Line: 228
            -- upvalues: u19 (copy), u17 (copy), HeelCenterCharges (ref), interface (ref), character (ref), HeelCenter (ref), StatesController (ref), ABC (ref), HumanoidRootPart2 (copy), u18 (ref), math_clamp_ret (ref), HumanoidRootPart (copy)
            if tick() > u19 + 4 or (not u17 or u17.OnPlayer.Value) then
                task.delay(3, function() -- Line: 230
                    -- upvalues: HeelCenterCharges (ref), interface (ref), character (ref), HeelCenter (ref), StatesController (ref)
                    print(HeelCenterCharges, interface.HeelCenterCharges);

                    if HeelCenterCharges ~= 1 and HeelCenterCharges == interface.HeelCenterCharges then
                        local v21 = interface;
                        v21:AbilityCooldown(3, HeelCenter.Cooldown);
                        v21.HeelCenter = nil;
                        v21.HeelCenterCharges = nil;
                        StatesController.SpeedBoost = 0;
                        StatesController.OwnWalkState = false;
                        v21.HCPassedTo = nil;
                    end;
                end);

                return ABC:Clean();
            end;

            local _ = HumanoidRootPart2.AssemblyLinearVelocity * Vector3.new(1, 0, 1);
            local v22 = tick() > u19 + 0.55;
            u18 = u18:Lerp((HumanoidRootPart2.Position - u17.Position).Unit + Vector3.new(0, v22 and 0.15 or 0.35, 0), 6.5 * p20);
            math_clamp_ret = math.clamp((HumanoidRootPart2.Position - HumanoidRootPart.Position).Magnitude * 2.75, 0, 150);

            if u17.Position.Y < 5 or (HumanoidRootPart2.Position - u17.Position).Magnitude <= 7 then
                return ABC:Clean();
            end;

            u17.AssemblyLinearVelocity = u17.AssemblyLinearVelocity:Lerp(u18 * math_clamp_ret, 6.5 * p20);
        end);
    end);
end;