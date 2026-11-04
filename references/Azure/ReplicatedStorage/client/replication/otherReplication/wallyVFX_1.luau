 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Lighting = game:GetService("Lighting");
game:GetService("RunService");
local Debris = game:GetService("Debris");
local _ = Players.LocalPlayer;
local mainreplication = require(ReplicatedStorage.client.replication.mainreplication);
local vfxUtil = require(ReplicatedStorage.util.vfxUtil);
require(ReplicatedStorage:WaitForChild("Part_Icles"));
require(ReplicatedStorage.forum.trove);
local MoonPropertyAnimator = require(ReplicatedStorage.util.MoonPropertyAnimator);
local TekrinnDialogue = require(ReplicatedStorage.client.replication.TekrinnDialogue);
local raycast = require(ReplicatedStorage.util.raycast);
local soundUtil = require(ReplicatedStorage.util.soundUtil);
require(ReplicatedStorage.util.animationUtil);
vfxUtil.getStyleData("wally");
local wally = vfxUtil.getResources().wally;
local _ = Players.LocalPlayer;
local v1 = {};

local function enableall(u2, p3, p4) -- Line: 32
    if not u2 then
        return;
    end;

    for _, descendant in pairs(u2:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            descendant.Enabled = true;
        end;
    end;

    if p3 then
        for _, descendant in pairs(u2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                task.delay(descendant:GetAttribute("EmitDuration"), function() -- Line: 44
                    -- upvalues: descendant (copy)
                    descendant.Enabled = false;
                end);
            end;
        end;

        return;
    end;

    task.delay(p4, function() -- Line: 50
        -- upvalues: u2 (copy)
        if not u2 then
            return;
        end;

        for _, descendant in pairs(u2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
end;

local function makeweld(p5, p6, p7, p8) -- Line: 63
    local Weld = Instance.new("Weld");
    Weld.Parent = p5;
    Weld.Part0 = p6;
    Weld.Part1 = p7;

    if p8 then
        Weld.C0 = p8;
    end;
end;

local function emitall(p9, p10) -- Line: 73
    if not p9 then
        return;
    end;

    for _, descendant in pairs(p9:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            descendant:Emit(p10 or descendant:GetAttribute("EmitCount"));
        end;
    end;
end;

function v1.excusemesirwouldyoupassmetheballforasecond(p11: any, p12: number) -- Line: 85
    -- upvalues: vfxUtil (copy), wally (copy), mainreplication (copy), Lighting (copy), MoonPropertyAnimator (copy), soundUtil (copy)
    local Root = vfxUtil.getRoot(p11);

    if not Root then
        return;
    end;

    local newFlow = wally.newFlow;
    local CFrame_new_ret = CFrame.new(
        0,
        3,
        0,
        0.9999999403953552,
        1.862645149230957e-9,
        -3.725290298461914e-8,
        1.862645149230957e-9,
        1,
        0,
        -3.725290298461914e-8,
        0,
        0.9999998807907104
    );
    local u13 = vfxUtil.character_trove(p11);
    vfxUtil.buildFromRig(p11, newFlow.Rig, u13);
    mainreplication.sceneEnabled(true);
    u13:Add(function() -- Line: 96
        -- upvalues: mainreplication (ref), vfxUtil (ref)
        mainreplication.sceneEnabled(false);
        vfxUtil.cutscene_ball(false);
    end);
    vfxUtil.cutscene_invisiball(p11, u13);
    vfxUtil.cutscene_ball(true);
    local u14 = u13:Clone(newFlow.VFX);
    u14:PivotTo(Root.CFrame * CFrame_new_ret:ToObjectSpace(newFlow.VFX:GetPivot()));
    u14.Parent = workspace.Effects;
    local v15 = u13:Clone(newFlow.Highlight);
    v15.Adornee = p11;
    v15.Parent = u14;
    local u16, v17 = mainreplication.cutsceneBlender(Root, newFlow.Animations.Cam, newFlow.FOV_WallyRen);

    if v17 then
        u13:Add(v17);
    end;

    if u16 then
        local CFrame_new_ret2 = CFrame.new(
            0.00024175643920898438,
            0.00006532669067382812,
            0.000030040740966796875,
            1,
            1.7024576663970947e-6,
            -3.8743019104003906e-7,
            -1.7061829566955566e-6,
            0.9999999403953552,
            -5.699694156646729e-7,
            3.2782554626464844e-7,
            5.62518835067749e-7,
            1
        );
        u14.VFXCaM.AutoWeld:Destroy();
        u14.VFXCaM.CFrame = u16.CamPart.CFrame * CFrame_new_ret2;
        u13:BindToRenderStep("WallyVFXCamera_" .. game:GetService("HttpService"):GenerateGUID(false), Enum.RenderPriority.Camera.Value + 1, function() -- Line: 125
            -- upvalues: u16 (copy), u14 (copy), CFrame_new_ret2 (copy)
            if u16.Parent then
                u14.VFXCaM.CFrame = u16.CamPart.CFrame * CFrame_new_ret2;
            end;
        end);
    end;

    local _baseplate_controller, u18 = vfxUtil.get_baseplate_controller();
    local Transparency = u18.Transparency;
    u13:Add(function() -- Line: 139
        -- upvalues: u18 (copy), Transparency (copy), _baseplate_controller (copy)
        u18.Transparency = Transparency;

        for i, v in _baseplate_controller.savedTransparency do
            i.Transparency = v;
        end;
    end);
    local v19 = u13:Add(vfxUtil.getMoonEffects());
    local v20 = {
        Workspace = u14,
        Lighting = Lighting,
        Highlight = v15,
        Vignette = v19.Vignette,
        ["Screen Cover"] = v19["Screen Cover"]
    };
    local v21 = {
        Brightness = 3,
        ClockTime = 14.5,
        ExposureCompensation = 0.15,
        GeographicLatitude = 201,
        ShadowSoftness = 1,
        EnvironmentDiffuseScale = 1,
        EnvironmentSpecularScale = 1,
        Ambient = Color3.new(1, 1, 1),
        OutdoorAmbient = Color3.fromRGB(47, 47, 47)
    };
    local u22 = {};

    local function updateBaseplate(p23: number) -- Line: 134
        -- upvalues: u18 (copy), _baseplate_controller (copy)
        u18.Transparency = p23;
        _baseplate_controller.update();
    end;

    for i in v21 do
        u22[i] = Lighting[i];
    end;

    vfxUtil.cutscene_lighting(u13, v20, newFlow.Lighting, v21);
    u13:Add(function() -- Line: 171
        -- upvalues: u22 (copy), Lighting (ref)
        for i, v in u22 do
            Lighting[i] = v;
        end;
    end);
    local v24 = u13:Construct(MoonPropertyAnimator);
    v24:SetOriginalRoot(CFrame_new_ret);
    v24:SetRoot(Root);
    v24:LoadAndConvertSave(newFlow.Moon, v20);
    v24:PlayAll();
    vfxUtil.execute_compiled(newFlow.Compiled, u13, u14, p11, u13, updateBaseplate);
    u13:Add(soundUtil:play(newFlow.SFX, "default"));
    u13:Add(task.delay(p12, function() -- Line: 186
        -- upvalues: u13 (copy)
        u13:Destroy();
    end));
end;

function v1.LokiDashSuper(p25) -- Line: 191
    -- upvalues: ReplicatedStorage (copy), Debris (copy), emitall (copy), raycast (copy), mainreplication (copy)
    local v26 = p25.HumanoidRootPart or p25.PrimaryPart;
    local v27 = ReplicatedStorage.Resources.wally.ExtraLineSpecs:Clone();
    v27.CFrame = v26.CFrame * CFrame.new(0, 0, -32.5);
    v27.Parent = workspace.Effects;
    Debris:AddItem(v27, 6);
    emitall(v27, 50);
    local v28 = raycast(v26.Position, v26.CFrame.LookVector * 65, nil, { workspace.map });

    if v28 then
        v26.CFrame = CFrame.new(v28.Position);
    else
        v26.CFrame = v26.CFrame * CFrame.new(0, 0, -65);
    end;

    mainreplication.fov(false, 75);
    mainreplication.fov(true, 70, 0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
end;

function v1.LokiFlow(p29, p30) -- Line: 213
    -- upvalues: mainreplication (copy), TekrinnDialogue (copy)
    if not p29.HumanoidRootPart then
        local _ = p29.PrimaryPart;
    end;

    mainreplication.sceneEnabled(true);
    task.delay(2.867, function() -- Line: 217
        -- upvalues: mainreplication (ref)
        mainreplication.sceneEnabled(false);
    end);
    TekrinnDialogue.Speak(p29, {
        {
            Text = "/ball",
            Bold = false,
            Italic = false,
            TypeSpeed = 0.3,
            Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 251, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
            TextStrokeColor = Color3.new(0, 0, 0),
            Shake = {
                Enabled = true,
                Intensity = 10,
                Lifetime = 1
            }
        }
    }, 2.867);
end;

function v1.LokiKick(p31, p32) -- Line: 246
    -- upvalues: ReplicatedStorage (copy), mainreplication (copy), Debris (copy), emitall (copy)
    local v33 = p31.HumanoidRootPart or p31.PrimaryPart;
    local wally2 = ReplicatedStorage.Resources.wally;
    mainreplication.cameraShake(12, 3, 6);
    mainreplication.fov(false, 80);
    mainreplication.fov(true, 70, 0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
    local v34 = wally2.lowkikick.DashEmit:Clone();
    local CFrame_new_ret = CFrame.new(0, 2, 3);
    local Weld = Instance.new("Weld");
    Weld.Parent = v34;
    Weld.Part0 = v34;
    Weld.Part1 = v33;

    if CFrame_new_ret then
        Weld.C0 = CFrame_new_ret;
    end;

    v34.Parent = p31;
    Debris:AddItem(v34, 5);
    emitall(v34);
end;

function v1.lokicatch(p35) -- Line: 261
    -- upvalues: ReplicatedStorage (copy), mainreplication (copy), Lighting (copy), TweenService (copy), Debris (copy), soundUtil (copy)
    local wally2 = ReplicatedStorage.Resources.wally;
    local v36 = p35.HumanoidRootPart or p35.PrimaryPart;
    p35:FindFirstChild("Ball");
    local _ = p35.Torso;
    mainreplication.sceneEnabled(true);
    local v37 = ReplicatedStorage.Resources.DepthOfField:Clone();
    v37.Parent = Lighting;
    v37.FarIntensity = 0;
    TweenService:Create(v37, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        FarIntensity = 1
    }):Play();
    local u38 = wally2.MYBALL:Clone();
    local Weld = Instance.new("Weld");
    Weld.Parent = u38;
    Weld.Part0 = u38;
    Weld.Part1 = v36;
    u38.Parent = p35;
    Debris:AddItem(u38, 2);

    if u38 then
        for _, descendant in pairs(u38:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        task.delay(2, function() -- Line: 50
            -- upvalues: u38 (copy)
            if not u38 then
                return;
            end;

            for _, descendant in pairs(u38:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end);
    end;

    soundUtil:play(ReplicatedStorage.Resources.wally.isthisok, "default");
    mainreplication.cutsceneBlender(v36, ReplicatedStorage.Resources.donlorenzo.Skill4Cam, ReplicatedStorage.Resources.donlorenzo.FOV);
    local BodyPosition = Instance.new("BodyPosition");
    BodyPosition.P = 12500;
    BodyPosition.MaxForce = Vector3.new(30000, 30000, 30000);
    BodyPosition.D = 300;
    BodyPosition.Parent = v36;
    BodyPosition.Position = v36.Position;
    task.wait(2);
    BodyPosition:Destroy();
    v37:Destroy();
    mainreplication.sceneEnabled(false);
end;

return v1;