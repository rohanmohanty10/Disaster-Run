  

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
local LocalPlayer = Players.LocalPlayer;

return function(p1) -- Line: 20
    -- upvalues: SpectatorController (copy), Players (copy), LocalPlayer (copy), SoundManager (copy), CutsceneUtils (copy)
    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local Char = p1.Char;

    if not Char then
        return;
    end;

    local v2 = {};

    for _, v in Players:GetPlayers() do
        if v ~= LocalPlayer and (v.Team ~= game.Teams.Visitor and v.Team ~= LocalPlayer.Team) then
            table.insert(v2, v);
        end;
    end;

    SoundManager.SpawnSound("SkeletonImprisonmentJune", 0.6, workspace, 150);
    SoundManager.SpawnSound("SkeletonImprisonmentVA", 0.6, workspace, 150);
    local v3 = {
        {
            Timestamp = "3:20",
            Duration = 3,
            Text = "Your souls make the perfect halloween decorations",
            Bold = false,
            Italic = false,
            TypeSpeed = 0.026,
            Speaker = {
                Icon = "rbxassetid://88803183173623",
                Name = Char.Name
            },
            Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(177, 236, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
            TextStrokeColor = Color3.fromRGB(29, 63, 85)
        }
    };
    local u4 = true;
    task.spawn(function() -- Line: 64
        -- upvalues: u4 (ref)
        while u4 do
            workspace.CurrentCamera.FieldOfView = 40;
            task.wait();
        end;
    end);
    CutsceneUtils.PlayCutscene(Char, {
        Neo_Hex = Char,
        Isagi = v2[1],
        Kaizer = v2[2],
        Shidou = v2[3],
        lorenzo = v2[4]
    }, "Skeleton NagiPrison", script.CodeEvents, 16, v3);
    u4 = false;
end;