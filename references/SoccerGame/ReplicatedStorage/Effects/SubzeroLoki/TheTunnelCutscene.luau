  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ContentProvider");
game:GetService("RunService");
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
local _ = Players.LocalPlayer;

return function(p1) -- Line: 20
    -- upvalues: SpectatorController (copy), SoundManager (copy), CutsceneUtils (copy), ReplicatedStorage2 (copy)
    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local Char = p1.Char;

    if not Char then
        return;
    end;

    local EnemyChar = p1.EnemyChar;
    SoundManager.SpawnSound("TheTunnel", 0.6, workspace, 150);
    local v2 = {
        Icon = "rbxassetid://87138537697523",
        Name = Char.Name
    };
    local v3 = {
        {
            Timestamp = "1:00",
            Duration = 3,
            Text = "Finally 1 on 1 with Loki, I can win from here",
            Bold = false,
            Italic = true,
            TypeSpeed = 0.028,
            Speaker = EnemyChar and (EnemyChar.Name or "") or "",
            Color = Color3.fromRGB(255, 52, 52),
            TextStrokeColor = Color3.fromRGB(42, 0, 0)
        },
        {
            Timestamp = "6:50",
            Duration = 1,
            Text = "Oh you think so?",
            Bold = false,
            Italic = false,
            TypeSpeed = 0.024,
            Speaker = v2,
            Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(106, 242, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
            TextStrokeColor = Color3.fromRGB(9, 40, 51)
        },
        {
            Timestamp = "8:00",
            Duration = 1,
            Text = "Try this",
            Bold = true,
            Italic = false,
            TypeSpeed = 0.022,
            Speaker = v2,
            Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(106, 242, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
            TextStrokeColor = Color3.fromRGB(9, 40, 51),
            Shake = {
                Enabled = true,
                Intensity = 1,
                Lifetime = 0.3
            }
        }
    };
    task.spawn(function() -- Line: 83
        local u4 = true;
        task.delay(0.4, function() -- Line: 85
            -- upvalues: u4 (ref)
            u4 = false;
        end);

        while u4 do
            task.wait();
            workspace.CurrentCamera.FieldOfView = 30;
        end;
    end);
    CutsceneUtils.ChangeLighting(script.LightingConfig, false);
    CutsceneUtils.PlayCutscene(Char, {
        reekais = Char,
        npc = EnemyChar
    }, "Subzero LokiTunnel", script.CodeEvents, v3);
    CutsceneUtils.ChangeLighting(ReplicatedStorage2.Assets.MainLighting, false);
end;