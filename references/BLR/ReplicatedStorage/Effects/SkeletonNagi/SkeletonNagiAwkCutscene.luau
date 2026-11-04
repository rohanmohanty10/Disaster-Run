  

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

    SoundManager.SpawnSound("SkeletonNagiAwk", 0.6, workspace, 150);
    SoundManager.SpawnSound("SkeletonNagiAwkVA", 0.6, workspace, 150);
    local v2 = {
        Icon = "rbxassetid://88803183173623",
        Name = Char.Name
    };
    local v3 = {
        {
            Timestamp = "3:20",
            Duration = 1.5,
            Text = "In the realm of the dead...",
            Bold = false,
            Italic = false,
            TypeSpeed = 0.026,
            Speaker = v2,
            Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(177, 236, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
            TextStrokeColor = Color3.fromRGB(29, 63, 85)
        },
        {
            Timestamp = "7:80",
            Duration = 0.7,
            Text = "I alone..",
            Bold = false,
            Italic = false,
            TypeSpeed = 0.024,
            Speaker = v2,
            Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(177, 236, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
            TextStrokeColor = Color3.fromRGB(29, 63, 85)
        },
        {
            Timestamp = "11:60",
            Duration = 1.5,
            Speaker = v2,
            Dialogue = {
                {
                    Text = "Am the ",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.026,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(177, 236, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.fromRGB(29, 63, 85),
                    Shake = {
                        Enabled = false,
                        Intensity = 1,
                        Lifetime = 0.5
                    }
                },
                {
                    Text = "skeleton king.",
                    Bold = true,
                    Italic = false,
                    TypeSpeed = 0.02,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(177, 236, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(42, 52, 66)) }),
                    TextStrokeColor = Color3.fromRGB(22, 27, 36),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 0.4
                    }
                }
            }
        }
    };
    CutsceneUtils.ChangeLighting(script.LightingConfig);
    local u4 = {};
    task.spawn(function() -- Line: 107
        -- upvalues: Char (copy), u4 (copy)
        local os_clock_ret = os.clock();

        repeat
            task.wait();
        until Char.HumanoidRootPart:WaitForChild("Back") or os.clock() - os_clock_ret > 10;

        task.wait();
        local v5 = script["Skeleton chair"]:Clone();
        v5:PivotTo(Char.HumanoidRootPart.CFrame);
        v5.Parent = Char;

        for _, child in v5:GetChildren() do
            local v6 = Char.HumanoidRootPart:FindFirstChild(child.Name);

            if v6 then
                v6.Part1 = child;
            end;
        end;

        local v7 = script.Skull:Clone();
        v7:PivotTo(Char.HumanoidRootPart.CFrame);
        v7.Parent = Char;

        for _, child in v7:GetChildren() do
            local v8 = Char.HumanoidRootPart:FindFirstChild(child.Name);

            if v8 then
                v8.Part1 = child;
            end;
        end;

        local v9 = script.Left:Clone();
        v9.CFrame = Char.HumanoidRootPart.CFrame;
        v9.Parent = Char;
        local v10 = Char.HumanoidRootPart:FindFirstChild(v9.Name);

        if v10 then
            v10.Part1 = v9;
        end;

        local v11 = script.Right:Clone();
        v11.CFrame = Char.HumanoidRootPart.CFrame;
        v11.Parent = Char;
        local v12 = Char.HumanoidRootPart:FindFirstChild(v11.Name);

        if v12 then
            v12.Part1 = v11;
        end;

        table.insert(u4, v5);
        table.insert(u4, v7);
        table.insert(u4, v9);
        table.insert(u4, v11);
    end);
    local u13 = true;
    task.spawn(function() -- Line: 169
        -- upvalues: u13 (ref)
        while u13 do
            workspace.CurrentCamera.FieldOfView = 40;
            task.wait();
        end;
    end);
    CutsceneUtils.PlayCutscene(Char, {
        reekais = Char
    }, "Skeleton NagiAwk", nil, v3);
    CutsceneUtils.ChangeLighting(ReplicatedStorage2.Assets.MainLighting);
    u13 = false;

    for _, v in u4 do
        v:Destroy();
    end;
end;