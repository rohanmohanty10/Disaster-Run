  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
local Popup = require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local Passive_LandingMetavision = require(ReplicatedStorage.Controllers.StylePassiveController.Passive_LandingMetavision);
require(ReplicatedStorage.Controllers.AbilityController.interface);

return function(u1, u2, p3) -- Line: 18, Name: Move
    -- upvalues: Popup (copy), ReplicatedStorage (copy), Passive_LandingMetavision (copy), TweenService (copy), RunService (copy), Players (copy)
    if u1.AbilityThree > tick() then
        return;
    end;

    if u1.ABC then
        u1.ABC:Clean();
    end;

    if p3.Values.HasBall.Value == true then
        return Popup.Popup(u2, "You cannot have the ball while using this!");
    end;

    if u2.PlayerStats.InFlow.Value then
        return Popup.Popup(u2, "You cannot use this while having flow active!");
    end;

    u1.AbilityService.Ability:Fire("TacticalVision", {
        State = "Enable"
    });
    local u4 = {};
    local u5 = {};
    u1:AbilityCooldown("3", 45);
    u1.ABC:Add(function() -- Line: 34
        -- upvalues: u1 (copy)
        u1.StatesController.OwnWalkState = false;
        u1.StatesController.SpeedBoost = 0;
    end);
    u1.ABC:Connect(u1.AbilityService.Ability, function(p6) -- Line: 39
        -- upvalues: u1 (copy), ReplicatedStorage (ref), u2 (copy), Passive_LandingMetavision (ref), TweenService (ref), u4 (ref), u5 (ref), RunService (ref), u2 (copy), Players (ref), Popup (ref)
        if p6 ~= true then
            return Popup.Popup(u2, "You need a full adaptation bar to use this!");
        end;

        u1.StatesController.OwnWalkState = true;
        u1.StatesController.SpeedBoost = 7;
        require(ReplicatedStorage.Effects.Snuffy.TacticalVisionVFX)({
            Player = u2
        });
        local u7 = select(1, Passive_LandingMetavision:hook("Omnivisioon"));
        local u8 = nil;

        local function DISABLE() -- Line: 50
            -- upvalues: u1 (ref), TweenService (ref), u8 (ref), u4 (ref), u5 (ref), DISABLE (ref), u7 (copy)
            u1.AbilityService.Ability:Fire("TacticalVision", {
                State = "Disable"
            });
            TweenService:Create(game.Lighting.ColorCorrection, TweenInfo.new(0.5), {
                TintColor = Color3.fromRGB(255, 255, 255)
            }):Play();

            if u8 then
                u8:Disconnect();
                u8 = nil;
            end;

            for _, v in pairs(u4) do
                v:Destroy();
            end;

            for _, v in pairs(u5) do
                if v and v.Connected then
                    v:Disconnect();
                end;
            end;

            if DISABLE then
                DISABLE = nil;
            end;

            if u7 then
                u7:Destroy();
            end;

            table.clear(u5);
            u5 = nil;
            table.clear(u4);
            u4 = nil;
            u1.ABC:Clean();
        end;

        u8 = RunService.RenderStepped:Connect(function(p9) -- Line: 80
            -- upvalues: ReplicatedStorage (ref), DISABLE (ref), u1 (ref), u2 (ref), RunService (ref), Players (ref), u4 (ref)
            if ReplicatedStorage.GameValues.State.Value ~= "Playing" then
                if DISABLE then
                    DISABLE();
                end;

                u1.ABC:Clean();

                return;
            end;

            if u2.Team == game.Teams.Visitor then
                if DISABLE then
                    DISABLE();
                end;

                u1.ABC:Clean();

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
                    table.insert(u4, v11);
                end;
            end;

            table.clear(v10);
        end);
        table.insert(u5, u2.CharacterRemoving:Once(function() -- Line: 118
            -- upvalues: DISABLE (ref), u1 (ref)
            if DISABLE then
                DISABLE();
                u1.ABC:Clean();
            end;
        end));
        u1.ABC:Add(task.delay(8, function() -- Line: 132
            -- upvalues: DISABLE (ref), u1 (ref)
            if DISABLE then
                DISABLE();
            end;

            u1.ABC:Clean();
        end));
    end);
end;