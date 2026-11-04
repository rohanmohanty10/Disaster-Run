  

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Popup = require(ReplicatedStorage.Shared.Popup);
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
local interface = require(ReplicatedStorage.Controllers.AbilityController.interface);

return function(u1, p2, u3) -- Line: 11
    -- upvalues: AbilityUtils (copy), Players (copy), Popup (copy), interface (copy), RunService (copy)
    local HumanoidRootPart = u3.HumanoidRootPart;

    if not (AbilityUtils.rules.onball() and (AbilityUtils.rules.grounded() and AbilityUtils.rules.slotReady(1))) then
        print("Cleaned");

        return;
    end;

    local u4 = u3:HasTag("PlanetHotline");

    if not (u4 or u3.Values.HasBall.Value) then
        return;
    end;

    local Closest = u1.BallController.Closest;

    if u4 then
        local v5 = Players:FindFirstChild(u3:GetAttribute("PlanetHotline_OtherPlayer") or "");

        if v5 then
            v5 = v5.Character;
        end;

        Closest = v5 or Closest;
        print("did planet hotline:", Closest);
    end;

    local v6 = Closest and Players:GetPlayerFromCharacter(Closest);
    local u7 = Closest and Closest:FindFirstChild("HumanoidRootPart");
    local v8 = u7 and ((HumanoidRootPart.Position - u7.Position).Magnitude or 9e99) or 9e99;

    if not u7 then
        return Popup.Popup(u1.Player, "No player found to pass!");
    end;

    if v8 > 150 then
        return Popup.Popup(u1.Player, "Too far!");
    end;

    if v6 and v6.PlayerStats.Style.Value == "Kurona" then
        return Popup.Popup(u1.Player, "Can\'t One-Two with another Kurona!");
    end;

    if u4 and not (u3.Values.HasBall.Value or Closest.Values.HasBall.Value) then
        return Popup.Popup(u1.Player, "Your partner doesn\'t have the ball!");
    end;

    if u4 then
        u1:AbilityCooldown("1", 2);
    else
        interface:AbilityCooldown(1, 40);
    end;

    u1.AbilityService.Ability:Fire("OneTwo", Closest);
    u1.StatesController.States.Ability = true;
    u1.StatesController.OwnWalkState = true;
    u1.StatesController.SpeedBoost = 5;
    u1.ABC:Add(function() -- Line: 74
        -- upvalues: u1 (copy)
        u1.StatesController.OwnWalkState = false;
        u1.StatesController.States.Ability = false;
        u1.StatesController.SpeedBoost = 0;
    end);
    print("one two");
    u1.ABC:Connect(u1.AbilityService.Ability, function(p9, u10) -- Line: 81
        -- upvalues: u7 (copy), HumanoidRootPart (copy), u1 (copy), RunService (ref), u4 (copy), Closest (ref)
        print("fire ability client", p9);

        if p9 == "shoot" then
            local u11 = (u7.Position + u7.AssemblyLinearVelocity * Vector3.new(1, 0, 1) - HumanoidRootPart.Position).Unit + Vector3.new(0, 0.5, 0);
            local math_clamp_ret = math.clamp((u7.Position - HumanoidRootPart.Position).Magnitude * 2.75, 0, 150);
            u1.Animations:StopAnims();
            u1.Animations.Abilities.OneTwo_Pass.Priority = Enum.AnimationPriority.Action4;
            u1.Animations.Abilities.OneTwo_Pass:Play();
            u10.AssemblyLinearVelocity = u11 * math_clamp_ret;
            local u12 = tick();
            local u13 = nil;
            u13 = u1.ABC:Connect(RunService.Heartbeat, function(p14) -- Line: 98
                -- upvalues: u12 (copy), u10 (copy), u7 (ref), u4 (ref), u1 (ref), u13 (ref), u11 (ref), math_clamp_ret (ref), HumanoidRootPart (ref), Closest (ref)
                if tick() > u12 + 3 then
                    u10.Position = u7.Position - Vector3.new(0, 1, 0);

                    if u4 then
                        return u1.ABC:Clean();
                    end;

                    return u13:Disconnect();
                end;

                local _ = u7.AssemblyLinearVelocity * Vector3.new(1, 0, 1);
                u11 = u11:Lerp((u7.Position - u10.Position).Unit + Vector3.new(0, 0.1, 0), 6.5 * p14);
                math_clamp_ret = math.clamp((u7.Position - HumanoidRootPart.Position).Magnitude * 2.75, 0, 150);
                local _ = (u7.Position - u10.Position).Magnitude <= 7;

                if Closest.Values.HasBall.Value then
                    if u4 then
                        return u1.ABC:Clean();
                    end;

                    return u13:Disconnect();
                end;

                u10.AssemblyLinearVelocity = u10.AssemblyLinearVelocity:Lerp(u11 * math_clamp_ret, 7 * p14);
            end);
        end;
    end);
    u1.ABC:Connect(u1.AbilityService.Ability, function(p15, u16) -- Line: 135
        -- upvalues: HumanoidRootPart (copy), u7 (copy), u1 (copy), RunService (ref), u3 (copy)
        print("fire ability client", p15);

        if p15 == "receive" then
            local u17 = (HumanoidRootPart.Position + HumanoidRootPart.AssemblyLinearVelocity * Vector3.new(1, 0, 1) - u7.Position).Unit + Vector3.new(0, 0.5, 0);
            local math_clamp_ret = math.clamp((HumanoidRootPart.Position - u7.Position).Magnitude * 2.75, 0, 150);
            u16.AssemblyLinearVelocity = u17 * math_clamp_ret;
            local u18 = tick();
            u1.ABC:Connect(RunService.Heartbeat, function(p19) -- Line: 149
                -- upvalues: u18 (copy), u16 (copy), HumanoidRootPart (ref), u1 (ref), u7 (ref), u17 (ref), math_clamp_ret (ref), u3 (ref)
                if tick() > u18 + 3 then
                    u16.Position = HumanoidRootPart.Position - Vector3.new(0, 1, 0);

                    return u1.ABC:Clean();
                end;

                local _ = u7.AssemblyLinearVelocity * Vector3.new(1, 0, 1);
                u17 = u17:Lerp((HumanoidRootPart.Position - u16.Position).Unit + Vector3.new(0, 0.1, 0), 6.5 * p19);
                math_clamp_ret = math.clamp((HumanoidRootPart.Position - u7.Position).Magnitude * 2.75, 0, 150);
                local _ = (HumanoidRootPart.Position - u16.Position).Magnitude <= 7;

                if u3.Values.HasBall.Value then
                    u1.Animations:StopAnims();
                    u1.Animations.Abilities.OneTwo_Receive.Priority = Enum.AnimationPriority.Action4;
                    u1.Animations.Abilities.OneTwo_Receive:Play();
                    u1.ABC:Clean();
                end;

                u16.AssemblyLinearVelocity = u16.AssemblyLinearVelocity:Lerp(u17 * math_clamp_ret, 7 * p19);
            end);
        end;
    end);
    u1.ABC:Connect(u1.AbilityService.Ability, function(p20, p21) -- Line: 183
        -- upvalues: u1 (copy)
        print("fire ability client", p20);

        if p20 == "cancel" then
            return u1.ABC:Clean();
        end;
    end);
end;