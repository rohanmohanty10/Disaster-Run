 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerStorage");
game:GetService("RunService");
game:GetService("UserInputService");
game:GetService("TweenService");
game:GetService("Debris");
game:GetService("CollectionService");
local Lighting = game:GetService("Lighting");
game:GetService("SoundService");
game:GetService("TextService");
game:GetService("ContentProvider");
local v1 = {};
local _ = workspace.CurrentCamera;
local LocalPlayer = Players.LocalPlayer;
local _ = LocalPlayer.PlayerGui;
LocalPlayer:GetMouse();
local _ = Lighting.Atmosphere.Color;
local _ = Lighting.Atmosphere.Density;
local _ = Lighting.Brightness;
local _ = Lighting.ClockTime;
local _ = Lighting.Ambient;
local _ = Lighting.ColorCorrection.Contrast;
local _ = Lighting.ColorCorrection.Saturation;
require(script.Parent.Parent.MeshEmitter);
require(ReplicatedStorage.util.raycast);
local animationUtil = require(ReplicatedStorage.util.animationUtil);
local soundUtil = require(ReplicatedStorage.util.soundUtil);
require(ReplicatedStorage.util.actionUtil);
local mainreplication = require(script.Parent.Parent.mainreplication);
require(script.Parent.Parent.TekrinnDialogue);
local vfxUtil = require(ReplicatedStorage.util.vfxUtil);
local trove = require(ReplicatedStorage.forum.trove);
local MoonPropertyAnimator = require(ReplicatedStorage.util.MoonPropertyAnimator);

function v1.slifer(p2, p3) -- Line: 42
    -- upvalues: vfxUtil (copy), mainreplication (copy), trove (copy), soundUtil (copy), animationUtil (copy), Lighting (copy), MoonPropertyAnimator (copy)
    local Root = vfxUtil.getRoot(p2);

    if not Root then
        return;
    end;

    mainreplication.sceneEnabled(true);
    local slifer = vfxUtil.getResources().jimmyNew.slifer;
    local u4 = trove.new();
    soundUtil:play(slifer.SFX, soundUtil);
    local v5 = u4:Clone(slifer.VFX.SliferRigs);
    v5.Parent = p2;
    v5:PivotTo(Root.CFrame);
    local v6 = animationUtil:loadAnimation(v5, slifer.Animations.Slifer);
    v6:Play(0);
    u4:Add(v6, "Stop");
    local v7 = u4:Clone(slifer.VFX.YugiyohMVP);
    v7.Parent = workspace;
    v7:PivotTo(Root.CFrame * CFrame.new(1, 221.973, -36.67) * CFrame.Angles(-0.1813746158672507, 0.10267771989482641, -0.01858775653373961));
    local ToHand = v7.SliferCard.ToHand;
    ToHand.Parent = p2["Right Arm"];
    u4:Add(ToHand);
    local SliferCard = v7.SliferCard.SliferCard;
    SliferCard.Part0 = p2["Right Arm"];
    SliferCard.Parent = p2["Right Arm"];
    u4:Add(SliferCard);
    local v8, v9 = mainreplication.cutsceneBlender(Root, slifer.Animations.Cam, slifer.FOV_Slifer, nil, nil, nil, slifer.VFX.Cam);
    u4:Add(v9);
    vfxUtil.cache_lighting();
    local v10 = {
        Vignette = u4:Add(vfxUtil.getMoonEffects()).Vignette
    };

    for _, child in slifer.VFX.Lighting:GetChildren() do
        local v11 = u4:Clone(child);
        v11.Parent = Lighting;
        v10[child.Name] = v11;
    end;

    u4:Add(vfxUtil.restore_lighting);
    Lighting.Ambient = Color3.fromRGB(70, 70, 70);
    Lighting.OutdoorAmbient = Color3.fromRGB(70, 70, 70);
    Lighting.ClockTime = 14.5;
    Lighting.ShadowSoftness = 0.2;
    u4:Add(vfxUtil.restore_lighting_properties);
    local v12 = u4:Construct(MoonPropertyAnimator);
    v12:LoadAndConvertSave(slifer.Moon, v10);
    v12:SetRoot(Root);
    v12:PlayAll();
    vfxUtil.execute_compiled(slifer.Compiled, u4, v7, v8, v5);
    u4:Add(function() -- Line: 109
        -- upvalues: mainreplication (ref)
        mainreplication.sceneEnabled(false);
    end);
    u4:Add(task.delay(p3 or 18.5, function() -- Line: 113
        -- upvalues: u4 (copy)
        u4:Destroy();
    end));
end;

return v1;