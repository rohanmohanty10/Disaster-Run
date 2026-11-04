  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);

return function(u1, u2, p3) -- Line: 16, Name: NELMetavision
    -- upvalues: ReplicatedStorage (copy), RunService (copy), Players (copy)
    if u1.AbilityTwo > tick() then
        return;
    end;

    if u1.AbilityUsed > tick() then
        return;
    end;

    if u1.ABC then
        u1.ABC:Clean();
    end;

    u1:AbilityCooldown("2", 45);
    require(ReplicatedStorage.Effects.NELMetavision)({
        Player = u2,
        Upgraded = false
    });
    u1.AbilityService.Ability:Fire("NELMetavision");
    local u4 = {};
    local u5 = {};
    local u6 = nil;

    local function DISABLE() -- Line: 30
        -- upvalues: u6 (ref), u4 (ref), u5 (ref), u1 (copy), DISABLE (ref)
        if u6 then
            u6:Disconnect();
            u6 = nil;
        end;

        for _, v in pairs(u4) do
            v:Destroy();
        end;

        for _, v in pairs(u5) do
            if v and v.Connected then
                v:Disconnect();
            end;
        end;

        u1.StatesController.SpeedBoost = 0;

        if DISABLE then
            DISABLE = nil;
        end;

        table.clear(u5);
        u5 = nil;
        table.clear(u4);
        u4 = nil;
    end;

    u1.StatesController.SpeedBoost = 6;
    u6 = RunService.RenderStepped:Connect(function(p7) -- Line: 52
        -- upvalues: ReplicatedStorage (ref), DISABLE (ref), u2 (copy), RunService (ref), Players (ref), u4 (ref)
        if ReplicatedStorage.GameValues.State.Value ~= "Playing" then
            if DISABLE then
                DISABLE();
            end;

            return;
        end;

        if u2.Team == game.Teams.Visitor then
            if DISABLE then
                DISABLE();
            end;

            return;
        end;

        local v8 = {};

        for _, v in pairs(game.Players:GetPlayers()) do
            if v ~= u2 and v.Character then
                table.insert(v8, v.Character);
            end;
        end;

        if RunService:IsStudio() and workspace:FindFirstChild("PassRig") then
            table.insert(v8, workspace.PassRig);
        end;

        for _, v in pairs(v8) do
            if not v:FindFirstChild("Metavision") then
                local v9 = script.Metavision:Clone();
                v9.AlwaysOnTop = true;
                v9.Adornee = v;
                v9.Parent = v;
                v9.Timer.Text = `{Players:GetPlayerFromCharacter(v) and Players:GetPlayerFromCharacter(v).PlayerStats.Style.Value or "Nagi"}`;
                v9.Enabled = true;
                table.insert(u4, v9);
            end;
        end;

        table.clear(v8);
    end);
    table.insert(u5, u2.CharacterRemoving:Once(function() -- Line: 88
        -- upvalues: DISABLE (ref)
        if DISABLE then
            DISABLE();
        end;
    end));
    task.delay(15, function() -- Line: 94
        -- upvalues: DISABLE (ref)
        if DISABLE then
            DISABLE();
        end;
    end);
end;