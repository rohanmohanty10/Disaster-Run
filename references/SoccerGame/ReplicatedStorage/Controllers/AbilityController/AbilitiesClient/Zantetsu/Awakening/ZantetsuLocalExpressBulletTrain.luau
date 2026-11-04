  

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local HttpService = game:GetService("HttpService");
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);
local Trove = require(ReplicatedStorage.Shared.Trove);
local interface = require(ReplicatedStorage.Controllers.AbilityController.interface);
local ZantetsuBulletTrainState = ReplicatedStorage:WaitForChild("ZantetsuBulletTrainState");
local LocalPlayer = Players.LocalPlayer;

local function applyReadyAt(p1) -- Line: 13
    -- upvalues: interface (copy)
    local v2 = p1 - workspace:GetServerTimeNow();
    local math_max_ret = math.max(0, v2);
    interface:AbilityCooldown(3, math_max_ret, (math.max(math_max_ret, 0.01)));
    interface.AbilityThree = tick() + math_max_ret;
end;

return function() -- Line: 20
    -- upvalues: AbilityBalancing (copy), interface (copy), LocalPlayer (copy), AbilityUtils (copy), HttpService (copy), Trove (copy), ZantetsuBulletTrainState (copy)
    local ZantetsuLocalExpressBulletTrain = AbilityBalancing.ZantetsuLocalExpressBulletTrain;

    if interface.ZantetsuBulletTrainPending or (LocalPlayer.PlayerStats.Style.Value ~= "Zantetsu" or not (LocalPlayer.PlayerStats.InAwakening.Value and (AbilityUtils.rules.onball(LocalPlayer) and (AbilityUtils.rules.grounded(LocalPlayer) and AbilityUtils.rules.slotReady(3))))) then
        return;
    end;

    local Character, _, u3 = AbilityUtils.getCharacter(LocalPlayer);
    local LookVector = workspace.CurrentCamera.CFrame.LookVector;
    local u4 = HttpService:GenerateGUID(false);
    local u5 = Trove.new();
    interface.ZantetsuBulletTrainPending = u4;
    u5:Add(function() -- Line: 37
        -- upvalues: interface (ref), u4 (copy)
        if interface.ZantetsuBulletTrainPending == u4 then
            interface.ZantetsuBulletTrainPending = nil;
        end;
    end);

    local function watchLifecycle(u6) -- Line: 43
        -- upvalues: LocalPlayer (ref), u3 (copy)
        u6:Connect(LocalPlayer.CharacterAdded, function() -- Line: 44
            -- upvalues: u6 (copy)
            u6:Clean();
        end);
        u6:Connect(LocalPlayer:GetPropertyChangedSignal("Team"), function() -- Line: 45
            -- upvalues: u6 (copy)
            u6:Clean();
        end);
        u6:Connect(LocalPlayer.PlayerStats.InAwakening.Changed, function(p7) -- Line: 46
            -- upvalues: u6 (copy)
            if not p7 then
                u6:Clean();
            end;
        end);
        u6:Connect(LocalPlayer.PlayerStats.Style.Changed, function() -- Line: 49
            -- upvalues: LocalPlayer (ref), u6 (copy)
            if LocalPlayer.PlayerStats.Style.Value ~= "Zantetsu" then
                u6:Clean();
            end;
        end);
        u6:Connect(u3.Died, function() -- Line: 52
            -- upvalues: u6 (copy)
            u6:Clean();
        end);
    end;

    watchLifecycle(u5);
    u5:Connect(ZantetsuBulletTrainState.OnClientEvent, function(p8, u9) -- Line: 56
        -- upvalues: u4 (copy), u5 (copy), LocalPlayer (ref), Character (copy), interface (ref), AbilityUtils (ref), ZantetsuLocalExpressBulletTrain (copy), LookVector (copy), watchLifecycle (copy)
        if p8 ~= u4 then
            return;
        end;

        u5:Clean();

        if LocalPlayer.Character ~= Character or not (Character.Parent and (LocalPlayer.PlayerStats.Style.Value == "Zantetsu" and LocalPlayer.PlayerStats.InAwakening.Value)) then
            return;
        end;

        interface.ZantetsuBulletTrainCharges = u9.Charges;

        if not u9.Accepted then
            local v10 = u9.ReadyAt - workspace:GetServerTimeNow();
            local math_max_ret = math.max(0, v10);
            interface:AbilityCooldown(3, math_max_ret, (math.max(math_max_ret, 0.01)));
            interface.AbilityThree = tick() + math_max_ret;

            return;
        end;

        if u9.Stage ~= 3 then
            local v11 = u9.ReadyAt - workspace:GetServerTimeNow();
            local math_max_ret = math.max(0, v11);
            interface:AbilityCooldown(3, math_max_ret, (math.max(math_max_ret, 0.01)));
            interface.AbilityThree = tick() + math_max_ret;

            return;
        end;

        interface.ZantetsuBulletTrainActive = true;
        AbilityUtils.clientCutsceneSkill(interface, ZantetsuLocalExpressBulletTrain, ZantetsuLocalExpressBulletTrain.CutsceneLength + 3, 3, true, LookVector);
        local ABC = interface.ABC;
        watchLifecycle(ABC);
        ABC:Add(function() -- Line: 73
            -- upvalues: u9 (copy), interface (ref)
            local v12 = u9.ReadyAt - workspace:GetServerTimeNow();
            local math_max_ret = math.max(0, v12);
            interface:AbilityCooldown(3, math_max_ret, (math.max(math_max_ret, 0.01)));
            interface.AbilityThree = tick() + math_max_ret;
            task.defer(function() -- Line: 75
                -- upvalues: interface (ref)
                interface.ZantetsuBulletTrainActive = nil;
            end);
        end);
    end);
    task.delay(3, function() -- Line: 84
        -- upvalues: interface (ref), u4 (copy), u5 (copy)
        if interface.ZantetsuBulletTrainPending == u4 then
            u5:Clean();
        end;
    end);
    interface.AbilityService.Ability:Fire(script.Name, {
        Id = u4
    });
end;