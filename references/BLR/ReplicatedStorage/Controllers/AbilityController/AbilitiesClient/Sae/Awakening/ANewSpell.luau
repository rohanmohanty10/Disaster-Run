  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
local Popup = require(ReplicatedStorage.Shared.Popup);
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);
local StatesController = require(ReplicatedStorage.Controllers.StatesController);
local BallController = require(ReplicatedStorage.Controllers.BallController);
local getPlayerTarget = require(ReplicatedStorage.Modules.getPlayerTarget);
local interface = require(ReplicatedStorage2.Controllers.AbilityController.interface);
local LocalPlayer = Players.LocalPlayer;

return function() -- Line: 26
    -- upvalues: AbilityBalancing (copy), AbilityUtils (copy), LocalPlayer (copy), getPlayerTarget (copy), Players (copy), Popup (copy), interface (copy), StatesController (copy), BallController (copy), RunService (copy)
    local ANewSpell = AbilityBalancing.ANewSpell;

    if not (AbilityUtils.rules.grounded(LocalPlayer) and (AbilityUtils.rules.airBall(LocalPlayer, ANewSpell.BallRange, ANewSpell.BallAirHeight) and AbilityUtils.rules.slotReady(3))) then
        return;
    end;

    local Character, u1 = AbilityUtils.getCharacter();

    if not (Character and u1) then
        return;
    end;

    local u3 = getPlayerTarget(false, function(p2) -- Line: 41
        -- upvalues: Players (ref), LocalPlayer (ref), u1 (copy), ANewSpell (copy)
        local PlayerFromCharacter = Players:GetPlayerFromCharacter(p2);

        if p2:GetAttribute("IsTrainingDummy") then
            return true;
        end;

        if not PlayerFromCharacter then
            return false;
        end;

        if PlayerFromCharacter.Team ~= LocalPlayer.Team then
            return false;
        end;

        if PlayerFromCharacter == LocalPlayer then
            return false;
        end;

        local Values = p2:FindFirstChild("Values");

        if Values and (Values:FindFirstChild("InCutscene") and Values.InCutscene.Value) then
            return false;
        end;

        local HumanoidRootPart = p2:FindFirstChild("HumanoidRootPart");

        if HumanoidRootPart then
            return (HumanoidRootPart.Position - u1.Position).Magnitude < ANewSpell.PassRange;
        end;

        return false;
    end);

    if not u3 then
        Popup.Popup(LocalPlayer, "No teammate in range!");

        return;
    end;

    interface.AbilityService.Ability:Fire(script.Name, u3);
    AbilityUtils.clientCutsceneSkill(interface, ANewSpell, 20, 3, false, nil, true);
    local ABC = interface.ABC;
    ABC:Connect(interface.AbilityService.Ability, function(u4) -- Line: 69
        -- upvalues: StatesController (ref), Character (copy), u3 (copy), BallController (ref), ABC (copy), RunService (ref)
        if not u4 then
            return;
        end;

        StatesController.States.Ability = false;
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
        local HumanoidRootPart2 = u3:FindFirstChild("HumanoidRootPart");

        if not (HumanoidRootPart and HumanoidRootPart2) then
            return;
        end;

        local u5 = (HumanoidRootPart2.Position + HumanoidRootPart2.AssemblyLinearVelocity * Vector3.new(1, 0, 1) - HumanoidRootPart.Position).Unit + Vector3.new(0, 0.5, 0);
        local math_clamp_ret = math.clamp((HumanoidRootPart2.Position - HumanoidRootPart.Position).Magnitude * 1.5, 0, 150);
        u4.AssemblyLinearVelocity = u5 * math_clamp_ret;
        BallController:DragBall(u4);
        local u6 = tick();
        ABC:Connect(RunService.Heartbeat, function(p7) -- Line: 88
            -- upvalues: u6 (copy), u4 (copy), ABC (ref), u5 (ref), HumanoidRootPart2 (copy), math_clamp_ret (ref)
            if tick() > u6 + 2 or (not u4 or u4.OnPlayer.Value) then
                return ABC:Clean();
            end;

            local v8 = tick() > u6 + 0.55;
            u5 = u5:Lerp((HumanoidRootPart2.Position - u4.Position).Unit + Vector3.new(0, v8 and 0.15 or 0.35, 0), 6.5 * p7);
            math_clamp_ret = math.clamp((HumanoidRootPart2.Position - u4.Position).Magnitude * 2.75, 0, 150);

            if u4.Position.Y < 5 or (HumanoidRootPart2.Position - u4.Position).Magnitude <= 7 then
                return ABC:Clean();
            end;

            u4.AssemblyLinearVelocity = u4.AssemblyLinearVelocity:Lerp(u5 * math_clamp_ret, 6.5 * p7);
        end);
    end);
end;