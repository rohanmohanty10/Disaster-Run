  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ContentProvider");
local RunService = game:GetService("RunService");
game:GetService("TweenService");
game:GetService("Debris");
local Players = game:GetService("Players");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
game:GetService("Lighting");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.VfxManager);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
local CutsceneUtils = require(ReplicatedStorage2.Modules.CutsceneUtils);
local SpectatorController = require(ReplicatedStorage2.Controllers.SpectatorController);
local AbilityUtils = require(ReplicatedStorage2.Shared.AbilityUtils);
local _ = Players.LocalPlayer;

return function(p1) -- Line: 21
    -- upvalues: SpectatorController (copy), Players (copy), SoundManager (copy), RunService (copy), AbilityUtils (copy), CutsceneUtils (copy), ReplicatedStorage2 (copy)
    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local Char = p1.Char;
    Players:GetPlayerFromCharacter(p1.Char);

    if not Char then
        return;
    end;

    SoundManager.SpawnSound("NoFear", 1.25, workspace, 150);
    ({
        Icon = "rbxassetid://73072513968910"
    }).Name = Char.Name;
    local v2 = {
        {
            Timestamp = "1:50",
            Duration = 2,
            Text = "To win this game I must become a tool for victory...",
            Speaker = Char.Name
        },
        {
            Timestamp = "5:00",
            Duration = 1,
            Text = "With no fear of death.",
            Speaker = Char.Name
        }
    };
    local v3 = RunService.Heartbeat:Connect(function() -- Line: 51
        workspace.CurrentCamera.FieldOfView = 35;
    end);
    local v4 = AbilityUtils.findNearestPlayer({
        distance = (1 / 0),
        team = "Enemy"
    });

    if v4 then
        v4:SetAttribute("IsagiPlr");
    end;

    CutsceneUtils.ChangeLighting(script.LightingConfig);
    CutsceneUtils.PlayCutscene(Char, {
        Rin = Char,
        passer = p1.EnemyChar,
        isagi = v4
    }, "RinNoFear", script.CodeEvents, v2);

    if v3 then
        v3:Disconnect();
    end;

    if v4 then
        v4:SetAttribute("IsagiPlr", nil);
    end;

    CutsceneUtils.ChangeLighting(ReplicatedStorage2.Assets.MainLighting);
end;