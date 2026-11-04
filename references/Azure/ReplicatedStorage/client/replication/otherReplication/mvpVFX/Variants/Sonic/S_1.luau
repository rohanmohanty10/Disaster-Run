 
 

game:GetService("CollectionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ContentProvider");
game:GetService("Debris");
local Lighting = game:GetService("Lighting");
local Players = game:GetService("Players");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
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
    -- upvalues: vfxUtil (copy), animationUtil (copy), trove (copy), MoonPropertyAnimator (copy), soundUtil (copy), SoundService (copy), RunService (copy), mainreplication (copy)
    local S = vfxUtil.getResources().mvpAssets.Sonic.S;
    local Compiled = require(S.Compiled);
    local Root = vfxUtil.getRoot(p1);
    local v3 = animationUtil:Load(p1, S.Animation);
    local u4 = trove.new();
    local v5 = u4:Add(S.Effects:Clone());
    local v6 = u4:Add(S.Aura:Clone());
    vfxUtil.setupAura(p1, v6, true);
    v6.Parent = workspace.Effects;
    local v7 = {
        ["Screen Cover"] = u4:Add(vfxUtil.getMoonEffects())["Screen Cover"]
    };
    local v8 = u4:Construct(MoonPropertyAnimator);
    v8:LoadAndConvertSave(S.Moon, v7);
    v8:PlayAll();

    if S:FindFirstChild("Sound") then
        soundUtil:play(S.Sound, SoundService);
    end;

    p1.HumanoidRootPart.Anchored = true;
    local v9 = u4:Add(S.Model:Clone());
    v9.Parent = p1;
    v9:PivotTo(p1.HumanoidRootPart.CFrame);
    local v10 = u4:Add(Instance.new("Motor6D"));
    v10.Parent = p1.HumanoidRootPart;
    v10.Part0 = v10.Parent;
    v10.Part1 = v9.PrimaryPart;
    local u11 = {
        [u4:Add(S.ExtrasCuzTheseVfxersHaveNoIdeaHowToOrganize.SonicLines:Clone())] = { p1:FindFirstChild("Torso"), CFrame.identity },
        [u4:Add(S.ExtrasCuzTheseVfxersHaveNoIdeaHowToOrganize.SonicTrailBall:Clone())] = { v9.PrimaryPart, CFrame.identity },
        [u4:Add(S.ExtrasCuzTheseVfxersHaveNoIdeaHowToOrganize.SonicTrailL:Clone())] = { p1:FindFirstChild("Left Leg"), CFrame.identity },
        [u4:Add(S.ExtrasCuzTheseVfxersHaveNoIdeaHowToOrganize.SonicTrailR:Clone())] = { p1:FindFirstChild("Right Leg"), CFrame.identity }
    };
    local v12 = {};

    for i, _ in u11 do
        i.Anchored = true;
        i.CanCollide = false;
        i.Massless = false;
        i.Parent = workspace.Effects;
        v12[i.Name] = i;
    end;

    u4:Add(RunService.RenderStepped:Connect(function() -- Line: 138
        -- upvalues: u11 (copy)
        for i, v in u11 do
            if i and v[1] then
                i.CFrame = v[1].CFrame * v[2];
            end;
        end;
    end));
    v5.Parent = workspace.Effects;
    v5:PivotTo(p1.HumanoidRootPart.CFrame);
    mainreplication.sceneEnabled(true);
    local v13, v14 = mainreplication.cutsceneCamRigWithLetterBox(Root, S.Camera, S.FOV, nil, CFrame.new(0, -3, 0), S.CameraModel, "CamPart");

    if v14 then
        u4:Add(v14);
    end;

    v3:Play(0);

    for _, v in ipairs(Compiled) do
        u4:Add(task.delay(v[1] / 60, v[2], v5, v9, v13, v12));
    end;

    u4:Add(function() -- Line: 162
        -- upvalues: mainreplication (ref)
        mainreplication.sceneEnabled(false);
    end);
    u4:Add(task.delay(p2 - 1, function() -- Line: 166
        -- upvalues: mainreplication (ref)
        mainreplication.blackscene(0.5);
    end));
    u4:Add(task.delay(p2, function() -- Line: 170
        -- upvalues: u4 (copy)
        u4:Destroy();
    end));
end;