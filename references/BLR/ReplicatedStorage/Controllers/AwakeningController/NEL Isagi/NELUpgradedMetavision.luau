  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
local Trove = require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);

return function(u1, u2, p3) -- Line: 16, Name: NELUpgradedMetavision
    -- upvalues: Trove (copy), RunService (copy), ReplicatedStorage (copy), Players (copy)
    if u1.ABC then
        u1.ABC:Clean();
    end;

    if u1.UpgradedMetaVision then
        return;
    end;

    if not u1.ABC then
        u1.ABC = Trove.new();
    end;

    u1.UpgradedMetaVision = true;
    local u4 = {};
    local u5 = {};
    local u6 = {};
    local u7 = nil;

    local function DISABLE() -- Line: 31
        -- upvalues: u1 (copy), u6 (ref), u7 (ref), u4 (ref), u5 (ref), DISABLE (ref)
        u1.OkDestroyThankYou = false;

        if u1.ABC then
            u1.ABC:Clean();
        end;

        for _, v in pairs(u6) do
            task.defer(function() -- Line: 35
                -- upvalues: v (copy)
                for _, v2 in pairs(v) do
                    if v2.CooldownTween then
                        v2.CooldownTween:Cancel();
                    end;

                    if v2.Template then
                        v2.Template:Destroy();
                    end;
                end;
            end);
        end;

        table.clear(u6);
        u6 = nil;

        if u7 then
            u7:Disconnect();
            u7 = nil;
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
        u1.UpgradedMetaVision = nil;
        u1.OkDestroyThankYou = true;
    end;

    u1.StatesController.SpeedBoost = 6;
    u7 = RunService.RenderStepped:Connect(function(p8) -- Line: 67
        -- upvalues: ReplicatedStorage (ref), DISABLE (ref), u2 (copy), RunService (ref), u6 (ref), Players (ref), u4 (ref)
        if ReplicatedStorage.GameValues.State.Value ~= "Playing" then
            if DISABLE then
                DISABLE();
            end;

            return;
        end;

        if u2.PlayerStats.AwakeningBar.Value <= 0 or (u2.PlayerStats.InAwakening.Value == false or u2.Team == game.Teams.Visitor) then
            if DISABLE then
                DISABLE();
            end;

            return;
        end;

        local v9 = {};

        for _, v in pairs(game.Players:GetPlayers()) do
            if v ~= u2 and v.Character then
                table.insert(v9, v.Character);
            end;
        end;

        if RunService:IsStudio() and workspace:FindFirstChild("PassRig") then
            table.insert(v9, workspace.PassRig);
        end;

        for _, v in pairs(v9) do
            if not v:FindFirstChild("Metavision") then
                u6[v.Name] = {};
                local v10 = script.Metavision:Clone();
                v10.AlwaysOnTop = true;
                v10.Adornee = v;
                v10.Parent = v;
                v10.Abilities.Timer.Text = `{Players:GetPlayerFromCharacter(v) and Players:GetPlayerFromCharacter(v).PlayerStats.Style.Value or "Nagi"}`;
                v10.Enabled = true;
                table.insert(u4, v10);
            end;
        end;

        table.clear(v9);
    end);
    table.insert(u5, u2.CharacterRemoving:Once(function() -- Line: 104
        -- upvalues: DISABLE (ref)
        if DISABLE then
            DISABLE();
        end;
    end));
end;