  

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
local Popup = require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local MonkPass = require(ReplicatedStorage.AbilityBalancing).MonkPass;

return function(u1: any, u2: userdata, p3: any) -- Line: 13, Name: MonkPass
    -- upvalues: Players (copy), Popup (copy), MonkPass (copy), RunService (copy)
    if u1.AbilityTwo > tick() then
        return;
    end;

    if u1.ABC then
        u1.ABC:Clean();
    end;

    local HumanoidRootPart = p3.HumanoidRootPart;
    local Closest = u1.BallController.Closest;

    if Closest then
        Players:GetPlayerFromCharacter(Closest);
    end;

    local u4;

    if Closest then
        u4 = Closest:FindFirstChild("HumanoidRootPart");
    else
        u4 = Closest;
    end;

    local v5 = u4 and ((HumanoidRootPart.Position - u4.Position).Magnitude or 9e99) or 9e99;

    if not u4 then
        return Popup.Popup(u1.Player, "No player found to pass!");
    end;

    if MonkPass.ActivationRangePlayer < v5 then
        return Popup.Popup(u1.Player, "Too far!");
    end;

    u1:AbilityCooldown("2", MonkPass.Cooldown);
    u1.StatesController.States.Ability = true;
    u1.ABC:Add(function() -- Line: 36
        -- upvalues: u1 (copy)
        u1.StatesController.States.Ability = false;
    end);
    u1.ABC:Add(task.delay(4, function() -- Line: 40
        -- upvalues: u1 (copy)
        u1.ABC:Clean();
    end));
    u1.Animations:StopAnims();
    u1.Animations.Abilities.IgaguriMonkPass.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Abilities.IgaguriMonkPass:Play();
    u1.AbilityService.Ability:Fire("MonkPass", Closest);
    u1.ABC:Connect(u1.AbilityService.Ability, function(u6) -- Line: 50
        -- upvalues: u2 (copy), u4 (copy), HumanoidRootPart (copy), u1 (copy), RunService (ref), Closest (copy)
        local u7 = u2.PlayerStats.InAwakening.Value and 3.75 or 2.75;
        local u8 = (u4.Position + u4.AssemblyLinearVelocity * Vector3.new(1, 0, 1) - HumanoidRootPart.Position).Unit + Vector3.new(0, 0.5, 0);
        local math_clamp_ret = math.clamp((u4.Position - HumanoidRootPart.Position).Magnitude * u7, 0, 150);
        u6.AssemblyLinearVelocity = u8 * math_clamp_ret;
        local u9 = tick();
        local u10 = nil;
        u10 = u1.ABC:Connect(RunService.Heartbeat, function(p11) -- Line: 63
            -- upvalues: u2 (ref), u9 (copy), u6 (copy), u4 (ref), u10 (ref), u1 (ref), u8 (ref), math_clamp_ret (ref), HumanoidRootPart (ref), u7 (copy), Closest (ref)
            local v12 = u2.PlayerStats.InAwakening.Value and 6 or 4;

            if tick() > u9 + v12 then
                u6.Position = u4.Position - Vector3.new(0, 1, 0);
                u10:Disconnect();
                u1.ABC:Clean();

                return;
            end;

            local _ = u4.AssemblyLinearVelocity * Vector3.new(1, 0, 1);
            u8 = u8:Lerp((u4.Position - u6.Position).Unit + Vector3.new(0, 0.1, 0), 6.5 * p11);
            math_clamp_ret = math.clamp((u4.Position - HumanoidRootPart.Position).Magnitude * u7, 0, 150);

            if not Closest.Values.HasBall.Value and (u4.Position - u6.Position).Magnitude > 7 then
                u6.AssemblyLinearVelocity = u6.AssemblyLinearVelocity:Lerp(u8 * math_clamp_ret, 7 * p11);

                return;
            end;

            u6.AssemblyLinearVelocity = u8 * math_clamp_ret / 2;
            u10:Disconnect();
            u1.ABC:Clean();
        end);
    end);
end;