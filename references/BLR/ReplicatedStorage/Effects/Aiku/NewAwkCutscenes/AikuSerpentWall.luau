  

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
    SoundManager.SpawnSound("AikuSerpentWall", 0.6, workspace, 150);
    local v2 = {
        {
            Timestamp = "0:95",
            Duration = 3,
            Speaker = {
                Icon = "rbxassetid://96797711723599",
                Name = EnemyChar and (EnemyChar.Name or "Isagi") or "Isagi"
            },
            Dialogue = {
                {
                    Text = "Our style of soccer will ",
                    Bold = false,
                    Italic = true,
                    TypeSpeed = 0.028,
                    Color = ColorSequence.new(Color3.fromRGB(216, 255, 222)),
                    TextStrokeColor = Color3.fromRGB(28, 72, 40),
                    Shake = {
                        Enabled = false,
                        Intensity = 1,
                        Lifetime = 0.5
                    }
                },
                {
                    Text = "slice right through them",
                    Bold = true,
                    Italic = false,
                    TypeSpeed = 0.022,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(120, 1, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(142, 255, 140)) }),
                    TextStrokeColor = Color3.fromRGB(5, 16, 11),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 0.45
                    }
                }
            }
        }
    };
    CutsceneUtils.ChangeLighting(script.LightingConfig, false);
    Char:SetAttribute("SnakeVision", nil);
    task.delay(9, function() -- Line: 78
        local os_clock_ret = os.clock();

        while true do
            task.wait();

            if os.clock() - os_clock_ret > 2 then
                break;
            end;

            local v3 = game.Lighting:FindFirstChild("ColorCorrection") or workspace.CurrentCamera:FindFirstChild("ColorCorrection");

            if v3 then
                print("destroy");
                v3:Destroy();
            end;
        end;
    end);
    CutsceneUtils.PlayCutscene(Char, {
        Aiku = Char,
        Isagi = EnemyChar
    }, "AikuSerpentWall", script.CodeEvents, 14, v2);
    CutsceneUtils.ChangeLighting(ReplicatedStorage2.Assets.MainLighting, false);
end;