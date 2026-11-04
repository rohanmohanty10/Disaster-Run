  

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

    SoundManager.SpawnSound("NewYearScene2", 0.6, workspace, 150);
    task.spawn(function() -- Line: 67
        local u2 = true;
        task.delay(1, function() -- Line: 69
            -- upvalues: u2 (ref)
            u2 = false;
        end);

        while u2 do
            task.wait();
            workspace.CurrentCamera.FieldOfView = 50;
        end;
    end);
    local CFrame = Char.HumanoidRootPart.CFrame;
    Char.HumanoidRootPart.Anchored = true;
    Char:PivotTo(workspace.NewYearsEventCutscenePos.CFrame);
    local v3 = {};
    local v4 = { {
            Timestamp = "1:00",
            Duration = 2,
            Speaker = "Ego",
            Text = "Very good job, you\'ve built the rocket."
        }, {
            Timestamp = "6:70",
            Duration = 2,
            Speaker = "Ego",
            Text = "Hahaha"
        }, {
            Timestamp = "8:00",
            Duration = 5,
            Speaker = "Ego",
            Text = "It\'s time to launch the rocket, stay back!"
        }, {
            Timestamp = "19:00",
            Duration = 3,
            Speaker = "Ego",
            Text = "Thank you egoist,"
        }, {
            Timestamp = "22:00",
            Duration = 2,
            Speaker = "Ego",
            Text = "take this for your help"
        }, {
            Timestamp = "26:00",
            Duration = 2,
            Speaker = "Ego",
            Text = "Happy New Year!"
        } };

    for _, child in LocalPlayer.PlayerGui:GetChildren() do
        if child:IsA("ScreenGui") and (child.Name ~= "Vignette" and child.Enabled) then
            table.insert(v3, child);
            child.Enabled = false;
        end;
    end;

    CutsceneUtils.PlayCutscene(Char, {
        agrement26 = Char
    }, "EgoEventCutscene", script.CodeEvents, 27.5, v4);
    Char.HumanoidRootPart.Anchored = false;

    if LocalPlayer.Team == game.Teams.Visitor then
        Char:PivotTo(CFrame);
    end;

    for _, v in v3 do
        v.Enabled = true;
    end;
end;