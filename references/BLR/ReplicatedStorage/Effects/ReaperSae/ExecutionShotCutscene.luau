  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ContentProvider");
game:GetService("RunService");
game:GetService("TweenService");
local Debris = game:GetService("Debris");
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
    -- upvalues: SpectatorController (copy), SoundManager (copy), Debris (copy), CutsceneUtils (copy)
    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local Char = p1.Char;

    if not Char then
        return;
    end;

    SoundManager.SpawnSound("ExecutionShot", 0.6, workspace, 150);
    task.delay(1.8, function() -- Line: 36
        -- upvalues: SoundManager (ref)
        SoundManager.SpawnSound("ExecutionShotVoiceline", 2, workspace, 150);
    end);
    local v2 = {
        Icon = "rbxassetid://124769576444407",
        Name = Char.Name
    };
    local v3 = {
        {
            Timestamp = "2:3",
            Duration = 2,
            Text = "That isn\'t right..",
            Bold = false,
            Italic = false,
            TypeSpeed = 0.026,
            Speaker = v2,
            Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 106, 209)), ColorSequenceKeypoint.new(1, Color3.fromRGB(126, 33, 101)) }),
            TextStrokeColor = Color3.fromRGB(64, 12, 49)
        },
        {
            Timestamp = "4:3",
            Duration = 2,
            Text = "Let\'s change it",
            Bold = true,
            Italic = false,
            TypeSpeed = 0.022,
            Speaker = v2,
            Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 106, 209)), ColorSequenceKeypoint.new(1, Color3.fromRGB(126, 33, 101)) }),
            TextStrokeColor = Color3.fromRGB(64, 12, 49),
            Shake = {
                Enabled = true,
                Intensity = 1,
                Lifetime = 0.3
            }
        }
    };
    local u4 = {};
    task.spawn(function() -- Line: 82
        -- upvalues: Char (copy), Debris (ref), u4 (copy)
        local os_clock_ret = os.clock();

        repeat
            task.wait();
        until Char["Right Arm"]:FindFirstChild("Handle") or os.clock() - os_clock_ret > 7;

        local Handle = Char["Right Arm"].Handle;

        if not Handle then
            return;
        end;

        local v5 = script.Handle:Clone();
        v5.CFrame = Char["Right Arm"].CFrame * CFrame.new(0.2, -0.5, 0);
        v5.Parent = Char;
        Debris:AddItem(v5, 7.4);
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
        Debris:AddItem(v6, 7.4);
    end);
    CutsceneUtils.PlayCutscene(Char, {
        ["Reaper Sae"] = Char
    }, "Reaper SaeExecutionShot", script.CodeEvents, 7.4, v3);

    for _, v in u4 do
        v:Destroy();
    end;
end;