 

 

game:GetService("CollectionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ContentProvider");
game:GetService("Debris");
local Lighting = game:GetService("Lighting");
local Players = game:GetService("Players");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
game:GetService("RunService");
game:GetService("ServerStorage");
local SoundService = game:GetService("SoundService");
game:GetService("TextService");
game:GetService("TweenService");
game:GetService("UserInputService");
game:GetService("ServerScriptService");
require(ReplicatedStorage.client.replication.otherReplication.camerasreplication);
local vfxUtil = require(ReplicatedStorage.util.vfxUtil);
local _ = workspace.CurrentCamera;
local LocalPlayer = Players.LocalPlayer;
local _ = LocalPlayer.PlayerGui;
LocalPlayer:GetMouse();
local _ = Lighting.Atmosphere.Color;
local _ = Lighting.Atmosphere.Density;
local _ = Lighting.Atmosphere.Offset;
local _ = Lighting.Atmosphere.Decay;
local _ = Lighting.Atmosphere.Glare;
local _ = Lighting.Atmosphere.Haze;
local _ = Lighting.Brightness;
local _ = Lighting.ClockTime;
local _ = Lighting.Ambient;
local _ = Lighting.ExposureCompensation;
local _ = Lighting.Bloom.Threshold;
local _ = Lighting.EnvironmentDiffuseScale;
local _ = Lighting.EnvironmentSpecularScale;
local _ = Lighting.ColorShift_Top;
local _ = Lighting.GlobalShadows;
local _ = Lighting.OutdoorAmbient;
local _ = Lighting.ShadowSoftness;
local _ = Lighting.ClockTime;
local _ = Lighting.GeographicLatitude;
local _ = Lighting.FogColor;
local _ = Lighting.FogEnd;
local _ = Lighting.FogStart;
local _ = Lighting.ColorCorrection.Contrast;
local _ = Lighting.ColorCorrection.Saturation;
local _ = Lighting.Bloom.Threshold;
require(ReplicatedStorage2.util.raycast);
local animationUtil = require(ReplicatedStorage2.util.animationUtil);
local soundUtil = require(ReplicatedStorage2.util.soundUtil);
require(ReplicatedStorage2.util.actionUtil);
require(ReplicatedStorage2.util.UwUEffects);
require(ReplicatedStorage2.util.Util);
require(ReplicatedStorage2.Temp);
require(ReplicatedStorage2.VfxHandler);
require(ReplicatedStorage2.Welder);
local trove = require(ReplicatedStorage.forum.trove);
require(ReplicatedStorage.util.KatUtil);
local mainreplication = require(ReplicatedStorage2.client.replication.mainreplication);
require(ReplicatedStorage2.client.replication.TekrinnDialogue);
local MoonPropertyAnimator = require(ReplicatedStorage.util.MoonPropertyAnimator);
require(ReplicatedStorage.client.replication.mainreplication);

return function(p1: any, p2: number) -- Line: 72
    -- upvalues: vfxUtil (copy), animationUtil (copy), trove (copy), MoonPropertyAnimator (copy), soundUtil (copy), SoundService (copy), mainreplication (copy)
    local B = vfxUtil.getResources().mvpAssets.Sonic.B;
    local Compiled = require(B.Compiled);
    local Root = vfxUtil.getRoot(p1);
    local v3 = animationUtil:Load(p1, B.Animation);
    local u4 = trove.new();
    local v5 = u4:Add(B.Effect:Clone());
    local v6 = u4:Add(B.Highlight:Clone());
    v6.Parent = p1;
    local v7 = MoonPropertyAnimator.new();
    v7:LoadSave(B.Moon, MoonPropertyAnimator.ConvertSave(B.Moon, {
        Hightlight = v6
    }));
    v7:PlayAll();

    if B:FindFirstChild("Sound") then
        soundUtil:play(B.Sound, SoundService);
    end;

    p1.HumanoidRootPart.Anchored = true;
    v5.Parent = workspace.Effects;
    v5:PivotTo(p1.HumanoidRootPart.CFrame);
    mainreplication.sceneEnabled(true);
    local _, v8 = mainreplication.cutsceneCamRigWithLetterBox(Root, B.Camera, B.FOV, nil, CFrame.new(0, -3, 0), B.CameraModel, "CamPart");

    if v8 then
        u4:Add(v8);
    end;

    v3:Play(0);

    for _, v in ipairs(Compiled) do
        u4:Add(task.delay(v[1] / 60, v[2], v5));
    end;

    u4:Add(function() -- Line: 118
        -- upvalues: mainreplication (ref)
        mainreplication.sceneEnabled(false);
    end);
    u4:Add(task.delay(p2 - 1, function() -- Line: 122
        -- upvalues: mainreplication (ref)
        mainreplication.blackscene(0.5);
    end));
    u4:Add(task.delay(p2, function() -- Line: 126
        -- upvalues: u4 (copy)
        u4:Destroy();
    end));
end;