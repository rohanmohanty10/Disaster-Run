 

 

local Lighting = game:GetService("Lighting");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local ContentProvider = game:GetService("ContentProvider");
local SoundService = game:GetService("SoundService");
require("@game/ReplicatedStorage/util/animationUtil");
local u1 = require("@game/ReplicatedStorage/client/replication/mainreplication");
local u2 = require("@game/ReplicatedStorage/util/MoonPropertyAnimator");
require("@game/ReplicatedStorage/util/Util");
local u3 = require("@game/ReplicatedStorage/util/vfxUtil");
local u4 = require("@game/ReplicatedStorage/util/soundUtil");
local u5 = require("@game/ReplicatedStorage/client/replication/TekrinnDialogue");
local v6 = {};
local TweenInfo_new_ret = TweenInfo.new(0.31666666666666665, Enum.EasingStyle.Quad, Enum.EasingDirection.In);

local function set_transparency(p7: userdata, p8: number) -- Line: 28
    if p7:IsA("BasePart") then
        p7.Transparency = p8;

        return;
    end;

    if p7:IsA("Decal") then
        p7.Transparency = p8;
    end;
end;

local function get_transparency(p9: userdata) -- Line: 36
    if p9:IsA("BasePart") then
        return p9.Transparency;
    end;

    if p9:IsA("Decal") then
        return p9.Transparency;
    end;

    return nil;
end;

local function reveal_clone(p10: userdata) -- Line: 45
    -- upvalues: ContentProvider (copy)
    local v11 = {};

    for _, descendant in p10:GetDescendants() do
        if descendant:IsA("Clothing") or (descendant:IsA("ShirtGraphic") or (descendant:IsA("Decal") or (descendant:IsA("MeshPart") or descendant:IsA("SpecialMesh")))) then
            table.insert(v11, descendant);
        end;
    end;

    ContentProvider:PreloadAsync(v11);

    for _, descendant in p10:GetDescendants() do
        local Attribute = descendant:GetAttribute("CloneTransparency");

        if typeof(Attribute) == "number" then
            if descendant:IsA("BasePart") then
                descendant.Transparency = Attribute;
            elseif descendant:IsA("Decal") then
                descendant.Transparency = Attribute;
            end;
        end;
    end;
end;

local function fade_clone(p12: userdata) -- Line: 61
    -- upvalues: TweenService (copy), TweenInfo_new_ret (copy)
    for _, descendant in p12:GetDescendants() do
        local v13;

        if descendant:IsA("BasePart") then
            v13 = descendant.Transparency;
        elseif descendant:IsA("Decal") then
            v13 = descendant.Transparency;
        else
            v13 = nil;
        end;

        if v13 and v13 < 1 then
            TweenService:Create(descendant, TweenInfo_new_ret, {
                Transparency = 1
            }):Play();
        end;
    end;
end;

function v6.imaginary_impact(p14: any, p15: userdata?, u16) -- Line: 70
    -- upvalues: u3 (copy), RunService (copy), reveal_clone (copy), fade_clone (copy)
    local Root = u3.getRoot(p14);
    local ImaginaryImpact = u3.getResources().gremmy.ImaginaryImpact;
    local v17 = u3.character_trove(p14);
    local v18 = v17:Clone(ImaginaryImpact.VFX);
    v18:PivotTo(Root.CFrame);
    v18.Parent = workspace.Effects;
    u3.execute_compiled(ImaginaryImpact.Compiled, v17, v18, p15);

    if p15 then
        local PrimaryPart = p15.PrimaryPart;
        PrimaryPart.CFrame = Root.CFrame * u16;
        local u19 = v17:Add(RunService.RenderStepped:Connect(function() -- Line: 85
            -- upvalues: PrimaryPart (copy), Root (copy), u16 (copy)
            PrimaryPart.CFrame = Root.CFrame * u16;
        end));
        v17:Add(task.delay(0.6166666666666667, function() -- Line: 88
            -- upvalues: u19 (copy)
            u19:Disconnect();
        end));
        task.spawn(reveal_clone, p15);
        task.delay(1.5833333333333333, fade_clone, p15);
    end;

    v17:Add(task.delay(1.9, v17.Destroy, v17));
end;

function v6.weltraum(u20, p21) -- Line: 100
    -- upvalues: u3 (copy), u1 (copy), SoundService (copy), u4 (copy), Lighting (copy), u2 (copy), u5 (copy)
    local Root = u3.getRoot(u20);
    local Weltraum = u3.getResources().gremmy.Weltraum;
    local u22 = u3.character_trove(u20);
    u22:Add(task.delay(10.683333333333334, u22.Destroy, u22));
    u3.cutscene_invisiball(u20, u22);
    u3.cutscene_invisiball(p21, u22);
    u1.sceneEnabled(true);
    u22:Add(function() -- Line: 110
        -- upvalues: u1 (ref)
        u1.sceneEnabled(false);
    end);
    local _, v23 = u1.cutsceneCamRigWithLetterBox(Root, Weltraum.Animations.Cam, Weltraum.FOV, u20, "default", Weltraum.Cam, "Camera");

    if v23 then
        u22:Add(v23);
    end;

    for _, v in { SoundService, p21 } do
        for _, v2 in v:QueryDescendants("Sound") do
            if v2.IsPlaying and not v2.Looped then
                v2:Stop();
            end;
        end;
    end;

    u4:play(Weltraum.SFX, "default");
    u3.buildFromRig(u20, Weltraum.Rig, u22);
    u22:Clone(Weltraum.VictimFX).Parent = p21.Head;
    local v24 = u22:Clone(Weltraum.VFX);
    v24:PivotTo(Root.CFrame);
    v24.Parent = workspace.Effects;
    local v25 = {
        Workspace = v24,
        Vignette = u22:Add(u3.getMoonEffects()).Vignette,
        Lighting = Lighting
    };
    u3.contain_lighting(u22, v25, Weltraum.Lighting);
    local v26 = u22:Construct(u2);
    v26:LoadAndConvertSave(Weltraum.Moon, v25);
    v26:SetOriginalRoot(Weltraum.VFX.PrimaryPart.CFrame);
    v26:SetRoot(Root);
    v26:PlayAll();
    u3.execute_compiled(Weltraum.Compiled, u22, v24, u20, p21);
    u22:Add(task.delay(8.616666666666667, function() -- Line: 152
        -- upvalues: u22 (copy), u5 (ref), u20 (copy)
        u22:Add(u5.Speak(u20, {
            {
                Text = "See what I did just now?",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.05,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 222, 38)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 2,
                    Lifetime = 1
                }
            }
        }));
    end));
end;

local TweenInfo_new_ret2 = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In);

local function set_travel(p27: any, p28: boolean) -- Line: 181
    for _, descendant in p27.TRAVEL:GetDescendants() do
        if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
            descendant.Enabled = p28;
        end;
    end;

    for _, v in p27.Main.Trail:QueryDescendants("Trail") do
        v.Enabled = p28;
    end;
end;

function v6.gremmy_pillar_surf(p29) -- Line: 192
    -- upvalues: u3 (copy)
    u3.buildFromRig(p29, u3.getResources().gremmy.PillarSurf.Rig, u3.character_trove(p29));
end;

function v6.gremmy_pillar_ride(p30: any, p31: boolean) -- Line: 196
    -- upvalues: set_travel (copy), u3 (copy)
    local cylinderofdoom = p30.cylinderofdoom;
    set_travel(cylinderofdoom, p31);

    if p31 then
        for _, child in cylinderofdoom:GetChildren() do
            if child:IsA("ParticleEmitter") then
                u3.emit(child);
            end;
        end;

        u3.emitAll(cylinderofdoom.Main.VFX);
    end;
end;

local function pillar_landed(p32) -- Line: 209
    -- upvalues: set_travel (copy), TweenService (copy), TweenInfo_new_ret2 (copy), u3 (copy)
    set_travel(p32, false);
    TweenService:Create(p32.PillarMesh, TweenInfo_new_ret2, {
        Transparency = 1
    }):Play();
    u3.disposal(p32);
end;

function v6.gremmy_pillar_fly(p33: any, p34: vector, p35: number) -- Line: 215
    -- upvalues: u3 (copy), set_travel (copy), TweenService (copy), pillar_landed (copy)
    local cylinderofdoom = p33.cylinderofdoom;
    cylinderofdoom.PillarMesh.LocalTransparencyModifier = 1;
    local v36 = u3.getResources().gremmy.PillarSurf.Rig.cylinderofdoom:Clone();
    v36.Anchored = true;
    v36.CFrame = cylinderofdoom.CFrame;
    v36.Parent = workspace.Effects;
    set_travel(v36, true);
    TweenService:Create(v36, TweenInfo.new(p35, Enum.EasingStyle.Linear), {
        CFrame = cylinderofdoom.CFrame + p34
    }):Play();
    task.delay(p35, pillar_landed, v36);
end;

return v6;