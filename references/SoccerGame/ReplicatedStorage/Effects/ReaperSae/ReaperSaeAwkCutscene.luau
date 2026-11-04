  

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

    SoundManager.SpawnSound("ReaperSaeAwk", 0.6, workspace, 150);
    task.delay(2.67, function() -- Line: 28
        -- upvalues: SoundManager (ref)
        SoundManager.SpawnSound("ReaperSaeAwkVoiceline", 2, workspace, 150);
    end);
    local v2 = {
        Icon = "rbxassetid://124769576444407",
        Name = Char.Name
    };
    local v3 = {
        {
            Timestamp = "4:40",
            Duration = 1.5,
            Text = "Lets get this started..",
            Bold = false,
            Italic = false,
            TypeSpeed = 0.026,
            Speaker = v2,
            Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 106, 209)), ColorSequenceKeypoint.new(1, Color3.fromRGB(126, 33, 101)) }),
            TextStrokeColor = Color3.fromRGB(64, 12, 49)
        },
        {
            Timestamp = "6:40",
            Duration = 1.5,
            Text = "Soccer Game",
            Bold = true,
            Italic = false,
            TypeSpeed = 0.02,
            Speaker = v2,
            Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 116, 214)), ColorSequenceKeypoint.new(1, Color3.fromRGB(132, 36, 104)) }),
            TextStrokeColor = Color3.fromRGB(64, 12, 49),
            Shake = {
                Enabled = true,
                Intensity = 1,
                Lifetime = 0.3
            }
        }
    };
    local u4 = {};
    task.spawn(function() -- Line: 74
        -- upvalues: Char (copy), u4 (copy)
        local os_clock_ret = os.clock();

        repeat
            task.wait();
        until Char["Right Arm"]:FindFirstChild("Handle") or os.clock() - os_clock_ret > 10;

        local Handle = Char["Right Arm"].Handle;

        if not Handle then
            return;
        end;

        local v5 = script.Handle:Clone();
        v5.CFrame = Char["Right Arm"].CFrame * CFrame.new(0.2, -0.5, 0);
        v5.Parent = Char;
        Handle.Parent = Char["Right Arm"];
        Handle.Part0 = Char["Right Arm"];
        Handle.Part1 = v5;
        local v6 = script["Blr Scythe"]:Clone();
        v6.Parent = Char;

        for _, child in v5:GetChildren() do
            child.Part0 = v5;
            child.Part1 = v6:FindFirstChild(child.Name);
        end;

        table.insert(u4, v5);
        table.insert(u4, v6);
    end);
    CutsceneUtils.ChangeLighting(script.LightingConfig, false);
    CutsceneUtils.PlayCutscene(Char, {
        ["Reaper Sae"] = Char
    }, "Reaper SaeAwk", script.CodeEvents, v3);
    CutsceneUtils.ChangeLighting(ReplicatedStorage2.Assets.MainLighting, false);

    for _, v in u4 do
        v:Destroy();
    end;
end;