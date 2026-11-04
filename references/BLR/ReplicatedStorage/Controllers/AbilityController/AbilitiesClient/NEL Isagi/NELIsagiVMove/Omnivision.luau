  

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
local Popup = require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);

return function(u1, u2, u3) -- Line: 16, Name: Move
    -- upvalues: Popup (copy), ReplicatedStorage (copy), RunService (copy), Players (copy)
    local v4 = u3:GetAttribute("RageBar") or 0;

    if u1.AbilityThree > tick() then
        return;
    end;

    if u1.ABC then
        u1.ABC:Clean();
    end;

    if v4 < 1 then
        return Popup.Popup(u2, "You need a full adaptation bar to use this!");
    end;

    if u3.Values.HasBall.Value == true then
        return Popup.Popup(u2, "You cannot have the ball while using this!");
    end;

    if u2.PlayerStats.InFlow.Value then
        return Popup.Popup(u2, "You cannot use this while having flow active!");
    end;

    u1.AbilityService.Ability:Fire("Omnivision", {
        State = "Enable"
    });
    local u5 = {};
    local u6 = {};
    u1.ABC:Connect(u1.AbilityService.Ability, function(p7) -- Line: 32
        -- upvalues: u1 (copy), ReplicatedStorage (ref), u2 (copy), u5 (ref), u6 (ref), RunService (ref), u2 (copy), Players (ref), u3 (copy), Popup (ref)
        if p7 ~= true then
            return Popup.Popup(u2, "You need a full adaptation bar to use this!");
        end;

        u1.StatesController.OwnWalkState = true;
        u1.StatesController.SpeedBoost = 7;
        u1.ABC:Add(function() -- Line: 37
            -- upvalues: u1 (ref)
            u1.StatesController.OwnWalkState = true;
            u1.StatesController.SpeedBoost = 0;
        end);
        require(ReplicatedStorage.Effects.NelIsagi.OmnivisionVFX)({
            Player = u2
        });
        local u8 = nil;

        local function DISABLE() -- Line: 45
            -- upvalues: u1 (ref), u8 (ref), u5 (ref), u6 (ref), DISABLE (ref)
            u1.AbilityService.Ability:Fire("Omnivision", {
                State = "Disable"
            });

            if u8 then
                u8:Disconnect();
                u8 = nil;
            end;

            for _, v in pairs(u5) do
                v:Destroy();
            end;

            for _, v in pairs(u6) do
                if v and v.Connected then
                    v:Disconnect();
                end;
            end;

            if DISABLE then
                DISABLE = nil;
            end;

            table.clear(u6);
            u6 = nil;
            table.clear(u5);
            u5 = nil;

            if u1.ABC then
                u1.ABC:Clean();
            end;
        end;

        u8 = RunService.RenderStepped:Connect(function(p9) -- Line: 66
            -- upvalues: ReplicatedStorage (ref), DISABLE (ref), u2 (ref), RunService (ref), Players (ref), u5 (ref)
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

            local v10 = {};

            for _, v in pairs(game.Players:GetPlayers()) do
                if v ~= u2 and v.Character then
                    table.insert(v10, v.Character);
                end;
            end;

            if RunService:IsStudio() and workspace:FindFirstChild("PassRig") then
                table.insert(v10, workspace.PassRig);
            end;

            for _, v in pairs(v10) do
                if not v:FindFirstChild("Metavision") then
                    local v11 = script.Metavision:Clone();
                    v11.AlwaysOnTop = true;
                    v11.Adornee = v;
                    v11.Parent = v;
                    v11.Timer.Text = `{Players:GetPlayerFromCharacter(v) and Players:GetPlayerFromCharacter(v).PlayerStats.Style.Value or "Nagi"}`;
                    v11.Enabled = true;
                    table.insert(u5, v11);
                end;
            end;

            table.clear(v10);
        end);
        table.insert(u6, u2.CharacterRemoving:Once(function() -- Line: 102
            -- upvalues: DISABLE (ref)
            if DISABLE then
                DISABLE();
            end;
        end));
        local u12 = nil;
        u12 = u3.Values.HasBall.Changed:Connect(function() -- Line: 108
            -- upvalues: u3 (ref), DISABLE (ref), u12 (ref), u1 (ref)
            if u3.Values.HasBall.Value == true then
                if DISABLE then
                    DISABLE();
                end;

                u12:Disconnect();

                if u1.ABC then
                    u1.ABC:Clean();
                end;
            end;
        end);
        task.delay(8, function() -- Line: 115
            -- upvalues: DISABLE (ref), u12 (ref), u1 (ref)
            if DISABLE then
                DISABLE();
            end;

            u12:Disconnect();

            if u1.ABC then
                u1.ABC:Clean();
            end;
        end);
    end);
end;