  

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
local _ = Players.LocalPlayer;

return function(p1) -- Line: 20
    -- upvalues: SpectatorController (copy), Players (copy), SoundManager (copy), RunService (copy), CutsceneUtils (copy), ReplicatedStorage2 (copy)
    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local Char = p1.Char;
    local PlayerFromCharacter = Players:GetPlayerFromCharacter(p1.Char);

    if not Char then
        return;
    end;

    local v2 = nil;

    for _, v in Players:GetPlayers() do
        if v.Team ~= PlayerFromCharacter.Team and (v ~= PlayerFromCharacter and (v.Character and v.Character:FindFirstChild("HumanoidRootPart"))) then
            v2 = v.Character;
            break;
        end;
    end;

    SoundManager.SpawnSound("PlanetHotlineNew", 0.6, workspace, 150);
    local v3 = {
        {
            Timestamp = "4:00",
            Duration = 1,
            Speaker = p1.TeammateChar and (p1.TeammateChar.Name or "Isagi") or "Isagi",
            Dialogue = {
                {
                    Text = "Go, ",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.026,
                    Color = ColorSequence.new(Color3.fromRGB(255, 244, 252)),
                    TextStrokeColor = Color3.fromRGB(63, 24, 58),
                    Shake = {
                        Enabled = false,
                        Intensity = 1,
                        Lifetime = 0.5
                    }
                },
                {
                    Text = "Shark",
                    Bold = true,
                    Italic = false,
                    TypeSpeed = 0.02,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 134, 220)), ColorSequenceKeypoint.new(1, Color3.fromRGB(58, 27, 55)) }),
                    TextStrokeColor = Color3.fromRGB(44, 10, 35),
                    Shake = {
                        Enabled = true,
                        Intensity = 1,
                        Lifetime = 0.35
                    }
                }
            }
        },
        {
            Timestamp = "6:30",
            Duration = 2.5,
            Speaker = v2 and (v2.Name or "Reo") or "Reo",
            Dialogue = {
                {
                    Text = "You\'re going nowhere ",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.026,
                    Color = ColorSequence.new(Color3.fromRGB(169, 104, 236)),
                    TextStrokeColor = Color3.fromRGB(53, 21, 88),
                    Shake = {
                        Enabled = false,
                        Intensity = 1,
                        Lifetime = 0.5
                    }
                },
                {
                    Text = "shark",
                    Bold = true,
                    Italic = false,
                    TypeSpeed = 0.02,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 134, 220)), ColorSequenceKeypoint.new(1, Color3.fromRGB(58, 27, 55)) }),
                    TextStrokeColor = Color3.fromRGB(44, 10, 35),
                    Shake = {
                        Enabled = true,
                        Intensity = 1,
                        Lifetime = 0.35
                    }
                }
            }
        }
    };
    local u4 = RunService.Heartbeat:Connect(function() -- Line: 118
        workspace.CurrentCamera.FieldOfView = 40;
    end);
    task.delay(2, function() -- Line: 121
        -- upvalues: u4 (ref)
        u4:Disconnect();
    end);
    CutsceneUtils.ChangeLighting(script.LightingConfig);
    local v5, v6 = CutsceneUtils.HideMap();
    CutsceneUtils.PlayCutscene(Char, {
        kurona = Char,
        isagi = p1.TeammateChar,
        reo = v2
    }, "KuronaPlanetHotline", script.CodeEvents, v3);
    CutsceneUtils.UnhideMap(v5, v6);

    if u4 then
        u4:Disconnect();
    end;

    CutsceneUtils.ChangeLighting(ReplicatedStorage2.Assets.MainLighting);
end;