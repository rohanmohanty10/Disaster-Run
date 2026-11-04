 
 

game:GetService("RunService");
local Lighting = game:GetService("Lighting");
local TweenService = game:GetService("TweenService");
local Players = game:GetService("Players");
local SoundService = game:GetService("SoundService");
local Debris = game:GetService("Debris");
game:GetService("ServerScriptService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local vfxUtil = require(ReplicatedStorage.util.vfxUtil);
local mainreplication = require(ReplicatedStorage.client.replication.mainreplication);
local soundUtil = require(ReplicatedStorage.util.soundUtil);
require(ReplicatedStorage.util.actionUtil);
local TekrinnDialogue = require(ReplicatedStorage.client.replication.TekrinnDialogue);
require(ReplicatedStorage.forum.trove);
require(ReplicatedStorage.util.Util);
require(ReplicatedStorage.client.replication.BackgroundHighlight);
local styles = require(ReplicatedStorage.wiki).styles;
local LocalPlayer = Players.LocalPlayer;
local v1 = {};
local u2 = {
    NEL = {
        {
            Text = "I\'ll be reborn ",
            Bold = false,
            Italic = false,
            TypeSpeed = 0.05,
            Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
            TextStrokeColor = Color3.new(0, 0, 0),
            Shake = {
                Enabled = false,
                Intensity = 1,
                Lifetime = 1
            }
        },
        {
            Text = "again ",
            Bold = true,
            Italic = false,
            TypeSpeed = 0.03,
            Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)) }),
            TextStrokeColor = Color3.new(0, 0, 0),
            Shake = {
                Enabled = true,
                Intensity = 2.5,
                Lifetime = 50
            }
        },
        {
            Text = "and ",
            Bold = false,
            Italic = false,
            TypeSpeed = 0.01,
            Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
            TextStrokeColor = Color3.new(0, 0, 0),
            Shake = {
                Enabled = false,
                Intensity = 1,
                Lifetime = 1
            }
        },
        {
            Text = "again!",
            Bold = true,
            Italic = false,
            TypeSpeed = 0.03,
            Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)) }),
            TextStrokeColor = Color3.new(0, 0, 0),
            Shake = {
                Enabled = true,
                Intensity = 2.5,
                Lifetime = 5
            }
        }
    },
    Base = {
        {
            Text = "I\'m about to get to the good part.",
            Bold = false,
            Italic = false,
            TypeSpeed = 0.01,
            Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(85, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 85, 255)) }),
            TextStrokeColor = Color3.new(0, 0, 0),
            Shake = {
                Enabled = true,
                Intensity = 1.5,
                Lifetime = 1.5
            }
        }
    }
};

function v1.nelorisagitimeWind(p3) -- Line: 138
    -- upvalues: ReplicatedStorage (copy), LocalPlayer (copy), styles (copy), vfxUtil (copy), Debris (copy), Lighting (copy), TweenService (copy), mainreplication (copy), soundUtil (copy), SoundService (copy), TekrinnDialogue (copy), u2 (copy)
    local v4 = ReplicatedStorage:WaitForChild("Resources"):WaitForChild("nel/isagi");
    local HumanoidRootPart = p3:FindFirstChild("HumanoidRootPart");
    local v5 = LocalPlayer.Character == p3;
    local Attribute = p3:GetAttribute("hasnelActive");
    local v6 = p3:GetAttribute("CustomStyleColor") or styles.isagi.color;
    local v7 = 0;
    local v8 = v4.VFX.FullAura:Clone();
    vfxUtil.setupAura(p3, v8);
    v8.Parent = p3;
    vfxUtil.LeanTowardsColor(v8, v6, 0.75);
    Debris:AddItem(v8, 1);
    local v9 = vfxUtil.createVFX(v4.VFX.RootVFX, p3, HumanoidRootPart);
    vfxUtil.LeanTowardsColor(v9, v6, 0.75);
    shared.vfx.emit(v9);
    Debris:AddItem(v9, 3);

    if v5 then
        local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
        ColorCorrectionEffect.Brightness = 0.5;
        ColorCorrectionEffect.TintColor = v6;
        ColorCorrectionEffect.Parent = Lighting;
        Debris:AddItem(ColorCorrectionEffect, 1);
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(1), {
            Brightness = 0,
            TintColor = Color3.new(1, 1, 1)
        }):Play();
        mainreplication.fov(false, 100);
        mainreplication.fov(true, 70, 1);
        soundUtil:play(v4.Sounds[Attribute and "NELDialogue" or "BaseDialogue"], SoundService);
        TekrinnDialogue.Speak(p3, u2[Attribute and "NEL" or "Base"], 2);
    end;

    local v10;

    if v5 then
        v10 = SoundService or HumanoidRootPart;
    else
        v10 = HumanoidRootPart;
    end;

    soundUtil:play(v4.Sounds.PuzzleShatter, v10);

    if v5 then
        HumanoidRootPart = SoundService or HumanoidRootPart;
    end;

    soundUtil:play(v4.Sounds.RewindClock, HumanoidRootPart);
    local v11 = {};

    for _, v in v8:QueryDescendants("Beam") do
        local v12 = {};

        for _, v2 in ipairs(v.Transparency.Keypoints) do
            table.insert(v12, { v2.Time, v2.Value });
        end;

        table.insert(v11, { v, v12 });
    end;

    local disposal = vfxUtil.disposal;
    local EmittersLifetime = vfxUtil.getEmittersLifetime(v8);
    disposal(v8, (math.max(EmittersLifetime, 1)));

    while true do
        v7 = v7 + task.wait();

        for _, v in ipairs(v11) do
            local v13, v14 = unpack(v);
            local v15 = {};

            for _, v2 in ipairs(v14) do
                local NumberSequenceKeypoint_new = NumberSequenceKeypoint.new;
                local v16 = v2[1];
                local math_lerp_ret = math.lerp(v2[2], 1, v7 / 1);
                table.insert(v15, NumberSequenceKeypoint_new(v16, math_lerp_ret));
            end;

            v13.Transparency = NumberSequence.new(v15);
        end;

        if v7 > 1 then
            for _, v in v11 do
                v[1]:Destroy();
            end;

            return;
        end;
    end;
end;

return v1;