  

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
require(ReplicatedStorage2.Controllers.SpectatorController);
local LocalPlayer = Players.LocalPlayer;

return function(p1) -- Line: 20
    -- upvalues: SoundManager (copy), LocalPlayer (copy), CutsceneUtils (copy)
    local Char = p1.Char;

    if not Char then
        return;
    end;

    SoundManager.SpawnSound("NewYearEvent1", 0.6, workspace, 150);
    local v2 = { {
            Timestamp = "7:00",
            Duration = 2,
            Speaker = "Ego",
            Text = "Hello there, egoist."
        }, {
            Timestamp = "10:00",
            Duration = 4,
            Speaker = "Ego",
            Text = "I want to start 2026 off right with a firework show"
        }, {
            Timestamp = "15:00",
            Duration = 4,
            Speaker = "Ego",
            Text = "I need your help fueling the rocket with all the different types of playstyles"
        }, {
            Timestamp = "24:00",
            Duration = 2,
            Speaker = "Ego",
            Text = "Build it and you\'ll be rewarded with a nice show..."
        }, {
            Timestamp = "5:70",
            Duration = 2,
            Speaker = "Ego",
            Text = "Hahaha"
        }, {
            Timestamp = "7:00",
            Duration = 5,
            Speaker = "Ego",
            Text = "It\'s time to launch the rocket, stay back!"
        }, {
            Timestamp = "18:00",
            Duration = 3,
            Speaker = "Ego",
            Text = "Thank you egoist,"
        }, {
            Timestamp = "21:00",
            Duration = 2,
            Speaker = "Ego",
            Text = "take this for your help"
        }, {
            Timestamp = "25:00",
            Duration = 2,
            Speaker = "Ego",
            Text = "Happy New Year!"
        } };
    local u3 = true;
    task.spawn(function() -- Line: 87
        -- upvalues: u3 (ref)
        while u3 do
            task.wait();
            workspace.CurrentCamera.FieldOfView = 35;
        end;
    end);
    local CFrame = Char.HumanoidRootPart.CFrame;
    Char.HumanoidRootPart.Anchored = true;
    Char:PivotTo(workspace.NewYearsEventCutscenePos.CFrame);
    local v4 = {};

    for _, child in LocalPlayer.PlayerGui:GetChildren() do
        if child:IsA("ScreenGui") and (child.Name ~= "Vignette" and child.Enabled) then
            table.insert(v4, child);
            child.Enabled = false;
        end;
    end;

    CutsceneUtils.PlayCutscene(Char, {
        reekais = Char
    }, "EgoEventCutsceneEntrance", nil, 29, v2);
    u3 = false;
    Char.HumanoidRootPart.Anchored = false;

    if LocalPlayer.Team == game.Teams.Visitor then
        Char:PivotTo(CFrame);
    end;

    for _, v in v4 do
        v.Enabled = true;
    end;
end;