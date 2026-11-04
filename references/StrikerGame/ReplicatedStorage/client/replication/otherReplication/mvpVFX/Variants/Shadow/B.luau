 

 

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
local Brightness = Lighting.Brightness;
local _ = Lighting.ClockTime;
local Ambient = Lighting.Ambient;
local _ = Lighting.ExposureCompensation;
local _ = Lighting.Bloom.Threshold;
local EnvironmentDiffuseScale = Lighting.EnvironmentDiffuseScale;
local EnvironmentSpecularScale = Lighting.EnvironmentSpecularScale;
local ColorShift_Top = Lighting.ColorShift_Top;
local _ = Lighting.GlobalShadows;
local OutdoorAmbient = Lighting.OutdoorAmbient;
local _ = Lighting.ShadowSoftness;
local ClockTime = Lighting.ClockTime;
local GeographicLatitude = Lighting.GeographicLatitude;
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
require(ReplicatedStorage.util.MoonPropertyAnimator);
require(ReplicatedStorage.client.replication.mainreplication);

return function(p1: any, p2: number) -- Line: 72
    -- upvalues: vfxUtil (copy), animationUtil (copy), trove (copy), soundUtil (copy), SoundService (copy), Lighting (copy), mainreplication (copy), Ambient (copy), Brightness (copy), ColorShift_Top (copy), EnvironmentDiffuseScale (copy), EnvironmentSpecularScale (copy), OutdoorAmbient (copy), ClockTime (copy), GeographicLatitude (copy)
    local B = vfxUtil.getResources().mvpAssets.Shadow.B;
    local Compiled = require(B.Compiled);
    local Root = vfxUtil.getRoot(p1);
    local v3 = animationUtil:Load(p1, B.Animation);
    local u4 = trove.new();
    local v5 = u4:Add(B.Aura:Clone());
    local v6 = u4:Add(B.World:Clone());
    u4:Add(task.delay(0.6, function() -- Line: 87
        -- upvalues: B (copy), soundUtil (ref), SoundService (ref)
        if B:FindFirstChild("Sound") then
            soundUtil:play(B.Sound, SoundService);
        end;
    end));
    Lighting.Ambient = Color3.fromRGB(70, 70, 70);
    Lighting.Brightness = 3;
    Lighting.ColorShift_Top = Color3.new(0, 0, 0);
    Lighting.ColorShift_Bottom = Color3.new(0, 0, 0);
    Lighting.EnvironmentDiffuseScale = 1;
    Lighting.EnvironmentSpecularScale = 1;
    Lighting.OutdoorAmbient = Color3.fromRGB(70, 70, 70);
    Lighting.ClockTime = 19.071;
    Lighting.GeographicLatitude = 73.957;
    local u7 = {};

    for _, child in B.Lighting:GetChildren() do
        local v8 = u4:Add(child:Clone());

        for _, child2 in Lighting:GetChildren() do
            if child2:IsA(v8.ClassName) then
                child2.Parent = workspace;
                table.insert(u7, child2);
            end;
        end;

        v8.Parent = Lighting;
    end;

    vfxUtil.setupAura(p1, v5, true);
    v5.Parent = workspace.Effects;
    p1.HumanoidRootPart.Anchored = true;
    local HumanoidRootPart = p1.HumanoidRootPart;
    HumanoidRootPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 1500, 0);
    v6.Parent = workspace.Effects;
    v6:PivotTo(p1.HumanoidRootPart.CFrame);
    mainreplication.sceneEnabled(true);
    local v9, v10 = mainreplication.cutsceneCamRigWithLetterBox(Root, B.Camera, B.FOV, nil, CFrame.new(0, -3, 0), B.camer, "CamPart");

    if v10 then
        u4:Add(v10);
    end;

    v3:Play(0);

    for _, v in ipairs(Compiled) do
        u4:Add(task.delay(v[1] / 60, v[2], v5, v6, v9));
    end;

    u4:Add(function() -- Line: 140
        -- upvalues: mainreplication (ref), u7 (copy), Lighting (ref), Ambient (ref), Brightness (ref), ColorShift_Top (ref), EnvironmentDiffuseScale (ref), EnvironmentSpecularScale (ref), OutdoorAmbient (ref), ClockTime (ref), GeographicLatitude (ref)
        mainreplication.sceneEnabled(false);

        for _, v in u7 do
            pcall(function() -- Line: 143
                -- upvalues: v (copy), Lighting (ref)
                v.Parent = Lighting;
            end);
        end;

        Lighting.Ambient = Ambient;
        Lighting.Brightness = Brightness;
        Lighting.ColorShift_Top = ColorShift_Top;
        Lighting.ColorShift_Bottom = ColorShift_Top;
        Lighting.EnvironmentDiffuseScale = EnvironmentDiffuseScale;
        Lighting.EnvironmentSpecularScale = EnvironmentSpecularScale;
        Lighting.OutdoorAmbient = OutdoorAmbient;
        Lighting.ClockTime = ClockTime;
        Lighting.GeographicLatitude = GeographicLatitude;
    end);
    u4:Add(task.delay(p2 - 0.5, function() -- Line: 159
        -- upvalues: mainreplication (ref)
        mainreplication.blackscene(0.5);
    end));
    u4:Add(task.delay(p2, function() -- Line: 163
        -- upvalues: u4 (copy)
        u4:Destroy();
    end));
end;