  

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
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);
local Graveyard = require(ReplicatedStorage.AbilityBalancing).Graveyard;

return function(u1, u2, p3) -- Line: 18, Name: Graveyard
    -- upvalues: SoundManager (copy), ReplicatedStorage (copy), Graveyard (copy), RunService (copy), SpectatorController (copy), Players (copy)
    if u1.AbilityThree > tick() then
        return;
    end;

    if u1.AbilityUsed > tick() then
        return;
    end;

    if u1.ABC then
        u1.ABC:Clean();
    end;

    u1:AbilityCooldown("3", 45);
    SoundManager.SpawnSound("NELIsagiMetavisionStart", 3, workspace, 150, false, false);
    require(ReplicatedStorage.Effects.ReaperSae.Graveyard)();
    u1.AbilityService.Ability:Fire("Graveyard");
    local u4 = {};
    local u5 = {};
    local u6 = {};
    local u7 = nil;

    local function DISABLE() -- Line: 36
        -- upvalues: u1 (copy), u6 (copy), u7 (ref), u4 (copy), u5 (copy), DISABLE (ref)
        if u1.ABC then
            u1.ABC:Clean();
        end;

        for _, v in pairs(u6) do
            task.defer(function() -- Line: 40
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
    end;

    u1.StatesController.SpeedBoost = Graveyard.MoveSpeedValue;
    u7 = RunService.RenderStepped:Connect(function(p8) -- Line: 66
        -- upvalues: ReplicatedStorage (ref), DISABLE (ref), SpectatorController (ref), u2 (copy), RunService (ref), u6 (copy), Players (ref), u4 (copy)
        if ReplicatedStorage.GameValues.State.Value ~= "Playing" then
            if DISABLE then
                DISABLE();
            end;

            return;
        end;

        if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
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
    end);
    task.delay(Graveyard.Duration, function() -- Line: 100
        -- upvalues: DISABLE (ref)
        DISABLE();
    end);
    table.insert(u5, u2.CharacterRemoving:Once(function() -- Line: 105
        -- upvalues: DISABLE (ref)
        if DISABLE then
            DISABLE();
        end;
    end));
end;