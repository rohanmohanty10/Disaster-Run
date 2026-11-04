  

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
local Popup = require(ReplicatedStorage.Shared.Popup);
local LocalPlayer = Players.LocalPlayer;

return function(u1, p2) -- Line: 10, Name: Move
    -- upvalues: AbilityUtils (copy), LocalPlayer (copy), ReplicatedStorage (copy), Players (copy), Popup (copy), RunService (copy)
    local Character = AbilityUtils.getCharacter(LocalPlayer);

    if u1.AbilityOne > tick() then
        return;
    end;

    if u1.ABC then
        u1.ABC:Clean();
    end;

    u1.StatesController.States.Ability = true;
    u1.StatesController.OwnWalkState = true;
    u1.StatesController.SpeedBoost = 20;
    u1.ABC:Add(function() -- Line: 20
        -- upvalues: u1 (copy)
        u1.StatesController.States.Ability = false;
        u1.StatesController.OwnWalkState = false;
        u1.StatesController.SpeedBoost = 0;
    end);
    u1.ABC:Add(task.delay(2, function() -- Line: 26
        -- upvalues: u1 (copy)
        u1.ABC:Clean();
    end));
    u1:AbilityCooldown("1", 30);
    u1.Animations:StopAnims();
    u1.Animations.Abilities.RouletteRunPart.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Abilities.RouletteRunPart.Looped = true;
    u1.Animations.Abilities.RouletteRunPart:Play();
    task.wait(0.5);

    local function findClosestPlayer() -- Line: 39
        -- upvalues: ReplicatedStorage (ref), Players (ref), Character (copy)
        local Value = ReplicatedStorage.Football.Value;
        local Value2 = Value.Char.Value;
        local v3 = Value.OnPlayer.Value and Players:GetPlayerFromCharacter(Value2);

        if not v3 then
            return;
        end;

        if not (Value2 and Value2.PrimaryPart) then
            return;
        end;

        if not Value2.Values.HasBall.Value then
            return;
        end;

        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");

        if not HumanoidRootPart then
            return;
        end;

        local Magnitude = (Value2.PrimaryPart.Position - HumanoidRootPart.Position).Magnitude;

        if Magnitude <= 27 then
            return Value2, Magnitude;
        end;
    end;

    Popup.Popup(Players.LocalPlayer, "Get Close To Player with the Ball");
    local u4 = 0;
    local v7 = RunService.Heartbeat:Connect(function(p5: number) -- Line: 79
        -- upvalues: u4 (ref), u1 (copy), findClosestPlayer (copy), Players (ref), LocalPlayer (ref)
        u4 = u4 + p5;

        if u4 >= 5 then
            u1.ABC:Clean();

            return;
        end;

        local v6, _ = findClosestPlayer();
        local PlayerFromCharacter = Players:GetPlayerFromCharacter(v6);

        if PlayerFromCharacter and PlayerFromCharacter.Team == LocalPlayer.Team then
            return;
        end;

        if v6 then
            u1.ABC:Clean();
            u1.AbilityService.Ability:Fire("Roulette", {
                Action = "RouletteMove",
                Type = "OffBall",
                Enemy = v6
            });
        end;
    end);
    u1.ABC:Add(function() -- Line: 98
        -- upvalues: u1 (copy)
        u1.Animations.Abilities.RouletteRunPart:Stop();
    end);
    u1.ABC:Add(v7);
    u1.ABC:Connect(u1.AbilityService.Ability, function(p8) -- Line: 104
        -- upvalues: u1 (copy)
        u1.ABC:Clean();
    end);
end;