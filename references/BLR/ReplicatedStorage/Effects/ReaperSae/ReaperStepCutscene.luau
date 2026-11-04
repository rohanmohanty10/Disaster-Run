  

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

    local EnemyChar1 = p1.EnemyChar1;
    local EnemyChar2 = p1.EnemyChar2;

    if not (EnemyChar1 and (EnemyChar1:FindFirstChild("HumanoidRootPart") and EnemyChar1)) then
        EnemyChar1 = nil;
    end;

    if not (EnemyChar2 and (EnemyChar2:FindFirstChild("HumanoidRootPart") and EnemyChar2)) then
        EnemyChar2 = nil;
    end;

    SoundManager.SpawnSound("ReaperStep", 0.6, workspace, 150);
    task.delay(0.4, function() -- Line: 34
        -- upvalues: SoundManager (ref)
        SoundManager.SpawnSound("ReaperStepVoiceline", 2, workspace, 150);
    end);
    local v2 = {
        {
            Timestamp = "1:50",
            Duration = 2,
            Text = "Lets end everyone on this pitch",
            Bold = true,
            Italic = false,
            TypeSpeed = 0.024,
            Speaker = {
                Icon = "rbxassetid://124769576444407",
                Name = Char.Name
            },
            Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 106, 209)), ColorSequenceKeypoint.new(1, Color3.fromRGB(126, 33, 101)) }),
            TextStrokeColor = Color3.fromRGB(64, 12, 49)
        }
    };
    local u3 = {};
    task.spawn(function() -- Line: 60
        -- upvalues: Char (copy), u3 (copy)
        local os_clock_ret = os.clock();

        repeat
            task.wait();
        until Char["Right Arm"]:FindFirstChild("Handle") or os.clock() - os_clock_ret > 10;

        local Handle = Char["Right Arm"].Handle;

        if not Handle then
            return;
        end;

        local v4 = script.Handle:Clone();
        v4.CFrame = Char["Right Arm"].CFrame * CFrame.new(0.2, -0.5, 0);
        v4.Parent = Char;
        Handle.Parent = Char["Right Arm"];
        Handle.Part0 = Char["Right Arm"];
        Handle.Part1 = v4;
        local v5 = script["Blr Scythe"]:Clone();
        v5.Parent = Char;

        for _, child in v4:GetChildren() do
            child.Part0 = v4;
            child.Part1 = v5:FindFirstChild(child.Name);
        end;

        table.insert(u3, v4);
        table.insert(u3, v5);
    end);
    CutsceneUtils.ChangeLighting(script.LightingConfig);
    CutsceneUtils.PlayCutscene(Char, {
        ["Reaper Sae"] = Char,
        ["npc 1"] = EnemyChar1,
        ["npc 2"] = EnemyChar2
    }, "Reaper SaeReaperStep", script.CodeEvents, v2);
    CutsceneUtils.ChangeLighting(ReplicatedStorage2.Assets.MainLighting);

    for _, v in u3 do
        v:Destroy();
    end;
end;