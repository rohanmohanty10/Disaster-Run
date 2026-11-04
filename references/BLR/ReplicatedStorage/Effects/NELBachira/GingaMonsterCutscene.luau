  

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
    -- upvalues: SpectatorController (copy), SoundManager (copy), Players (copy), LocalPlayer (copy), CutsceneUtils (copy), ReplicatedStorage2 (copy)
    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local Char = p1.Char;

    if not Char then
        return;
    end;

    local EnemyChar = p1.EnemyChar;
    SoundManager.SpawnSound("GingaMonsterCutscene", 0.6, workspace, 150);
    task.delay(1, function() -- Line: 30
        -- upvalues: SoundManager (ref)
        SoundManager.SpawnSound("GingaVoiceline", 0.6, workspace, 150);
    end);
    local v2 = {
        Icon = "rbxassetid://110236362600449",
        Name = Char.Name
    };
    local v3 = {
        {
            Timestamp = "2:00",
            Duration = 1,
            Text = "Play with me one more time...",
            Bold = false,
            Italic = false,
            TypeSpeed = 0.026,
            Speaker = v2,
            Color = ColorSequence.new(Color3.fromRGB(243, 214, 137)),
            TextStrokeColor = Color3.fromRGB(87, 58, 21)
        },
        {
            Timestamp = "4:80",
            Duration = 1,
            Text = "Monster",
            Bold = true,
            Italic = false,
            TypeSpeed = 0.02,
            Speaker = v2,
            Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(239, 198, 109)), ColorSequenceKeypoint.new(1, Color3.fromRGB(63, 50, 25)) }),
            TextStrokeColor = Color3.fromRGB(44, 29, 10),
            Shake = {
                Enabled = true,
                Intensity = 1,
                Lifetime = 0.35
            }
        }
    };
    local v4 = script.FACE:Clone();
    v4.CFrame = Char.Head.CFrame;
    v4.Parent = Char.Head;
    local WeldConstraint = Instance.new("WeldConstraint");
    WeldConstraint.Part0 = v4;
    WeldConstraint.Part1 = Char.Head;
    WeldConstraint.Parent = v4;
    local u5 = true;
    task.spawn(function() -- Line: 83
        -- upvalues: u5 (ref)
        while u5 do
            workspace.CurrentCamera.FieldOfView = 35;
            task.wait();
        end;
    end);
    local v6 = nil;

    for _, v in Players:GetPlayers() do
        if v ~= LocalPlayer and (v.Team ~= LocalPlayer.Team and (v.Character ~= EnemyChar and v.Team ~= game.Teams.Visitor)) then
            v6 = v.Character;
            break;
        end;
    end;

    local v7;

    if v6 == nil then
        v6 = script.Nagi:Clone();
        v7 = v6;
    else
        v7 = nil;
    end;

    CutsceneUtils.ChangeLighting(script.LightingConfig, false);
    CutsceneUtils.PlayCutscene(Char, {
        bachira = Char,
        ["1"] = EnemyChar,
        ["2"] = v6
    }, "Bachira NEL GingaMonster", script.CodeEvents, v3);
    CutsceneUtils.ChangeLighting(ReplicatedStorage2.Assets.MainLighting, false);
    u5 = false;

    if v7 then
        v7:Destroy();
    end;
end;