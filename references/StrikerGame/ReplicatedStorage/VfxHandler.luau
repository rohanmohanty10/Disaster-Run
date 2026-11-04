 

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
game:GetService("GuiService");
local Debris = game:GetService("Debris");
local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
game:GetService("StarterGui");
local Lighting = game:GetService("Lighting");
game:GetService("SoundService");
RunService:IsClient();
local CameraShaker = require(ReplicatedStorage.client.replication.mainreplication.CameraShaker);
local raycast = require(ReplicatedStorage.util.raycast);
local Welder = require(ReplicatedStorage.Welder);
local Temp = require(ReplicatedStorage.Temp);
local actionUtil = require(ReplicatedStorage.util.actionUtil);
local workspace_CurrentCamera = workspace.CurrentCamera;
CameraShaker.new(Enum.RenderPriority.Camera.Value, function(p1) -- Line: 39
    -- upvalues: workspace_CurrentCamera (copy)
    workspace_CurrentCamera.CFrame = workspace_CurrentCamera.CFrame * p1;
end);
local LocalPlayer = Players.LocalPlayer;
local u2 = Players.LocalPlayer:FindFirstChild("PlayerGui") or nil;
local Children = script:GetChildren();
local u3 = {};

local function IsSettingOn(p4) -- Line: 23
    local LocalPlayer2 = game:GetService("Players").LocalPlayer;
    local v5 = false;

    if LocalPlayer2:FindFirstChild("setting") and (not v5 and LocalPlayer2.setting:FindFirstChild(p4)) then
        v5 = LocalPlayer2.setting:FindFirstChild(p4).Value;
    end;

    return v5;
end;

for i = 1, #Children do
    local v6 = Children[i];
    local v7;

    if v6:IsA("ModuleScript") then
        u3[v6.Name] = require(v6);
        v7 = i;
    else
        v7 = i;
    end;
end;

local workspace_CurrentCamera2 = workspace.CurrentCamera;

local function GetSortedFOV(p8: userdata) -- Line: 63
    local u9 = {};

    for i, v in require(p8) do
        local v10 = tonumber(i);

        if v10 then
            table.insert(u9, {
                Index = v10,
                Value = v
            });
        end;
    end;

    table.sort(u9, function(p11, p12) -- Line: 71
        return p11.Index < p12.Index;
    end);

    return function(p13) -- Line: 74
        -- upvalues: u9 (copy)
        local v14 = #u9;

        if v14 == 0 then
            return nil;
        end;

        local v15 = 1;

        while v15 < v14 do
            local v16 = (v15 + v14) // 2;

            if u9[v16].Index < p13 then
                v15 = v16 + 1;
            else
                v14 = v16;
            end;
        end;

        if v15 > 1 then
            local v17 = u9[v15 - 1];
            local v18 = u9[v15];

            if math.abs(v17.Index - p13) <= math.abs(v18.Index - p13) then
                return v17;
            end;
        end;

        return u9[v15];
    end;
end;

function u3.FrameAnimation(u19: userdata, p20: number, p21: number) -- Line: 100
    -- upvalues: RunService (copy), TweenService (copy)
    local u22 = p20 or 24;
    local u23 = p21 or 0.5;
    local Children2 = u19:GetChildren();
    local os_clock_ret = os.clock();
    local u24 = nil;
    u24 = RunService.RenderStepped:Connect(function(p25) -- Line: 107
        -- upvalues: os_clock_ret (copy), u22 (ref), u19 (copy), Children2 (copy), u24 (ref), TweenService (ref), u23 (ref)
        local v26 = (os.clock() - os_clock_ret) * u22;
        local v27 = u19:FindFirstChild((math.ceil(v26)));

        if v27 and v27.Name ~= #Children2 then
            for _, v in pairs(Children2) do
                if v:IsA("ImageLabel") then
                    v.ImageTransparency = 0.999;
                end;
            end;

            v27.ImageTransparency = 0;

            return;
        end;

        u24:Disconnect();
        TweenService:Create(u19[#Children2], TweenInfo.new(u23), {
            ImageTransparency = 1
        }):Play();
    end);
end;

function u3.CutsceneEndFade(p28: string) -- Line: 128
    -- upvalues: u3 (copy), workspace_CurrentCamera2 (copy), Debris (copy), TweenService (copy)
    if p28 == "BlackZoom" then
        u3.FadeBright(0.75, Color3.fromRGB(0, 0, 0), 0, 0, 0);
        u3.Fov(false, 30);
        u3.Fov(true, 70, 1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);

        return;
    end;

    local u29 = script.FlashCorrection:Clone();
    u29.Parent = workspace_CurrentCamera2;
    Debris:AddItem(u29, 1);
    task.delay(0.05, function() -- Line: 138
        -- upvalues: TweenService (ref), u29 (copy)
        TweenService:Create(u29, TweenInfo.new(0.7, Enum.EasingStyle.Quad), {
            Brightness = 0,
            Saturation = 0
        }):Play();
    end);
    workspace_CurrentCamera2.FieldOfView = 50;
    TweenService:Create(workspace_CurrentCamera2, TweenInfo.new(0.7, Enum.EasingStyle.Sine), {
        FieldOfView = 70
    }):Play();
end;

function u3.HideCharacters(p30: table, p31: any, p32: boolean?) -- Line: 150
    -- upvalues: u3 (copy)
    if not table.find({ "Instance", "number", "string" }, (typeof(p31))) then
        return warn("Invalid Time Check Type! >>", p31);
    end;

    local _ = p32 == nil;
    local v33 = p30 or {};

    for _, child in ipairs(workspace.characters:GetChildren()) do
        if not table.find(v33, child) then
            u3.Invisible({
                Character = child,
                Time = p31
            });
        end;
    end;
end;

function u3.HideChar(p34: userdata, p35: any) -- Line: 168
    -- upvalues: u3 (copy)
    if not table.find({ "Instance", "number", "string" }, (typeof(p35))) then
        return warn("Invalid Time Check Type! >>", p35);
    end;

    u3.Invisible({
        Character = p34,
        Time = p35
    });
end;

function u3.CutsceneVictim(p36: userdata, p37: userdata, p38, p39: userdata, p40: table, p41: boolean?) -- Line: 178
    local v42 = p41 or false;
    local v43 = p38 or CFrame.new(0, 0, 0);

    if p36 == nil then
        warn("Need Character to clone Cutscene Victim");

        return;
    end;

    if p37 == nil then
        warn("Need Victim to clone Cutscene Victim");

        return;
    end;

    if p40 ~= nil then
        local HumanoidRootPart = p36.HumanoidRootPart;
        p37.Archivable = true;
        local v44 = p37:Clone();
        p37.Archivable = false;

        if p37:IsDescendantOf(workspace.characters) then
            for _, descendant in pairs(v44:GetDescendants()) do
                if descendant:IsA("Script") or (descendant:IsA("LocalScript") or (descendant:IsA("ParticleEmitter") or (descendant.Name == "BallDisplay" or (descendant:IsA("Highlight") or descendant:IsA("Beam"))))) then
                    descendant:Destroy();
                end;
            end;
        end;

        v44.Humanoid.PlatformStand = true;
        v44.HumanoidRootPart.CFrame = HumanoidRootPart.CFrame;
        v44.HumanoidRootPart.Massless = true;
        v44.HumanoidRootPart.RootJoint.C0 = CFrame.Angles(1.5707963267948966, -3.141592653589793, 0);

        if v42 then
            v44.HumanoidRootPart.Anchored = true;
            v44.HumanoidRootPart.CFrame = v42;
        else
            local Weld = Instance.new("Weld");
            Weld.C0 = v43;
            Weld.Part0 = HumanoidRootPart;
            Weld.Part1 = v44.HumanoidRootPart;
            Weld.Parent = v44.HumanoidRootPart;
        end;

        v44.Parent = workspace.Effects;

        if p39 then
            v44.Humanoid:LoadAnimation(p39):Play();
        end;

        p40[#p40 + 1] = v44;

        return v44;
    end;

    warn("Need TempTable to clone Cutscene Victim");
end;

function u3.debris(u45, p46) -- Line: 233
    task.delay(p46, function() -- Line: 234
        -- upvalues: u45 (copy)
        u45:Destroy();
    end);
end;

function u3.CheckCamera(p47: any, p48: number) -- Line: 237
    -- upvalues: workspace_CurrentCamera2 (copy)
    if typeof(p48) == "number" then
        local v49 = typeof(p47);

        if v49 ~= "Vector3" then
            if v49 == "Instance" then
                local _ = p47.Position;
            else
                if v49 ~= "CFrame" then
                    warn("CheckCamera got " .. v49 .. " Which does not support");

                    return;
                end;

                local _ = p47.Position;
            end;
        end;

        return (workspace_CurrentCamera2.CFrame.Position - p47).Magnitude <= p48;
    end;

    warn("Invalid Distance type got " .. typeof(p48) .. " Instead of number");
end;

function u3.StartParticles(p50) -- Line: 261
    -- upvalues: IsSettingOn (copy)
    if IsSettingOn("NoVFXAtAll") then
        return;
    end;

    for _, descendant in pairs(p50:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            local v51 = 0;
            local u52 = 0;
            local u53 = 0;

            if descendant:GetAttribute("EmitCount") == nil then
                if descendant:GetAttribute("Emit") ~= nil then
                    u52 = descendant:GetAttribute("Emit");
                end;
            else
                u52 = descendant:GetAttribute("EmitCount");
            end;

            if descendant:GetAttribute("EmitDuration") then
                u53 = descendant:GetAttribute("EmitDuration");
            end;

            if typeof(descendant:GetAttribute("EmitDelay")) ~= nil then
                v51 = descendant:GetAttribute("EmitDelay");
            end;

            if v51 == 0 then
                descendant:Emit(u52);

                if u53 ~= 0 then
                    descendant.Enabled = true;
                    task.delay(u53, function() -- Line: 299
                        -- upvalues: descendant (copy)
                        descendant.Enabled = false;
                    end);
                end;
            else
                task.delay(v51, function() -- Line: 285
                    -- upvalues: descendant (copy), u52 (ref), u53 (ref)
                    descendant:Emit(u52);

                    if u53 ~= 0 then
                        descendant.Enabled = true;
                        task.delay(u53, function() -- Line: 290
                            -- upvalues: descendant (ref)
                            descendant.Enabled = false;
                        end);
                    end;
                end);
            end;
        end;
    end;
end;

function u3.HideMap(p54) -- Line: 309
    if typeof(p54) == "table" then
        for i, _ in pairs(p54.Transparency) do
            i.Transparency = 1;
        end;

        for _, v in pairs(p54.Enabled) do
            v.Enabled = false;
        end;

        return p54;
    end;

    local v55 = {
        Transparency = {},
        Enabled = {}
    };

    for _, descendant in ipairs(workspace.map:GetDescendants()) do
        if descendant:IsA("Beam") or (descendant:IsA("Light") or (descendant:IsA("SurfaceGui") or descendant:IsA("ParticleEmitter"))) then
            if p54 ~= "MapOnly" and descendant.Enabled == true then
                v55.Enabled[#v55.Enabled + 1] = descendant;
                descendant.Enabled = false;
            end;
        elseif (descendant:IsA("BasePart") or (descendant:IsA("Texture") or descendant:IsA("Decal"))) and (p54 ~= "LightingOnly" and descendant.Transparency < 1) then
            v55.Transparency[descendant] = tonumber(descendant.Transparency);
            descendant.Transparency = 1;
        end;
    end;

    return v55;
end;

function u3.ShowMap(p56: userdata) -- Line: 349
    if typeof(p56) ~= "table" then
        warn(">> SavedData type is " .. typeof(p56) .. " Instead of table");

        return;
    end;

    local v57 = p56.Transparency or {};
    local v58 = p56.Enabled or {};

    for i, v in pairs(v57) do
        i.Transparency = v;
    end;

    for _, v in v58 do
        v.Enabled = true;
    end;
end;

function u3.ShowParticles(p59) -- Line: 366
    if p59:IsA("ParticleEmitter") then
        p59.Enabled = true;
    end;

    for _, descendant in pairs(p59:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            descendant.Enabled = true;
        elseif descendant:IsA("Trail") then
            descendant.Enabled = true;
        elseif descendant:IsA("Beam") then
            descendant.Enabled = true;
        end;
    end;
end;

function u3.EndParticles(p60) -- Line: 381
    if p60:IsA("ParticleEmitter") then
        p60.Enabled = false;
    end;

    for _, descendant in pairs(p60:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            descendant.Enabled = false;
        elseif descendant:IsA("Trail") then
            descendant.Enabled = false;
        elseif descendant:IsA("Beam") then
            descendant.Enabled = false;
        end;
    end;
end;

function u3.FadeBlur(p61, p62) -- Line: 396
    -- upvalues: Debris (copy), TweenService (copy)
    local v63 = p61 or 0.5;
    local BlurEffect = Instance.new("BlurEffect");
    BlurEffect.Parent = workspace.CurrentCamera;
    BlurEffect.Size = p62 or 25;
    Debris:AddItem(BlurEffect, v63);
    TweenService:Create(BlurEffect, TweenInfo.new(v63), {
        Size = 0
    }):Play();
end;

function u3.LookAt(p64: table) -- Line: 407
    -- upvalues: Debris (copy)
    local part = p64.part;
    local target = p64.target;
    local u65 = p64.tim or 0.25;
    task.delay(p64.dur or 0, function() -- Line: 413
        -- upvalues: part (copy), Debris (ref), u65 (copy), target (ref)
        local AlignOrientation = Instance.new("AlignOrientation");
        AlignOrientation.Parent = part;
        AlignOrientation.Mode = Enum.OrientationAlignmentMode.OneAttachment;

        if part:FindFirstChild("RootAttachment") then
            AlignOrientation.Attachment0 = part:FindFirstChild("RootAttachment");
        else
            local Attachment = Instance.new("Attachment");
            Attachment.Parent = part;
            AlignOrientation.Attachment0 = Attachment;
            Debris:AddItem(Attachment, u65);
        end;

        AlignOrientation.MaxTorque = 999999999999;
        AlignOrientation.Responsiveness = 200;

        if typeof(target) == "Vector3" then
            target = CFrame.new(target);
        end;

        AlignOrientation.CFrame = CFrame.lookAt(part.Position, (Vector3.new(target.Position.X, part.Position.Y, target.Position.Z)));
        Debris:AddItem(AlignOrientation, u65);
    end);
end;

function u3.TweenNumber(p66, p67, p68, p69, p70, p71, p72) -- Line: 442
    -- upvalues: TweenService (copy)
    local v73 = p71 or 0;
    local v74 = p69 or Enum.EasingStyle.Linear;
    local v75 = p70 or Enum.EasingDirection.In;
    local NumberValue = Instance.new("NumberValue");
    NumberValue.Value = p66 or 100;
    NumberValue.Parent = workspace.Effects;
    task.delay((p72 or p68) + v73, function() -- Line: 453
        -- upvalues: NumberValue (copy)
        NumberValue:Destroy();
    end);
    local u76 = TweenService:Create(NumberValue, TweenInfo.new(p68, v74, v75), {
        Value = p67 or 0
    });

    if v73 > 0 then
        task.delay(v73, function() -- Line: 459
            -- upvalues: u76 (copy)
            u76:Play();
        end);
    else
        u76:Play();
    end;

    return function() -- Line: 466, Name: GetNumber
        -- upvalues: NumberValue (copy)
        if NumberValue:IsDescendantOf(game) then
            return NumberValue.Value;
        end;

        return nil;
    end;
end;

function u3.FadeBright(p77, p78, p79, p80, p81) -- Line: 476
    -- upvalues: workspace_CurrentCamera2 (copy), Debris (copy), TweenService (copy)
    local v82 = p77 or 0.7;
    local v83 = p78 or Color3.fromRGB(255, 255, 255);
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.Brightness = p79 or 1;
    ColorCorrectionEffect.Contrast = p80 or 0;
    ColorCorrectionEffect.Saturation = p81 or 0;
    ColorCorrectionEffect.TintColor = v83;
    ColorCorrectionEffect.Parent = workspace_CurrentCamera2;
    Debris:AddItem(ColorCorrectionEffect, v82);
    TweenService:Create(ColorCorrectionEffect, TweenInfo.new(v82), {
        Brightness = 0,
        Saturation = 0,
        Contrast = 0,
        TintColor = Color3.fromRGB(255, 255, 255)
    }):Play();
end;

local u84 = nil;

function u3.Fov(p85, p86, p87, p88, p89) -- Line: 496
    -- upvalues: Temp (copy), u84 (ref), TweenService (copy), workspace_CurrentCamera2 (copy)
    Temp.ClearTemp(u84);

    if not p85 then
        workspace_CurrentCamera2.FieldOfView = p86;

        return;
    end;

    u84 = TweenService:Create(workspace_CurrentCamera2, TweenInfo.new(p87 or 0.15, p88 or Enum.EasingStyle.Linear, p89 or Enum.EasingDirection.In), {
        FieldOfView = p86 or 70
    });
    u84:Play();
end;

function u3.rockFlakes(u90, p91, u92) -- Line: 511
    -- upvalues: RunService (copy), raycast (copy), TweenService (copy), Debris (copy), ReplicatedStorage (copy)
    local l_time = time;
    local u93 = l_time() + 0.085;
    Random.new();
    local u98 = RunService.PreRender:Connect(function() -- Line: 521
        -- upvalues: l_time (copy), u93 (ref), u90 (copy), u92 (ref), raycast (ref), TweenService (ref), Debris (ref), ReplicatedStorage (ref)
        if l_time and u93 then
            local v94 = l_time();

            if u93 > v94 then
                return;
            end;

            u93 = v94 + 0.085;
        end;

        if not u90:IsDescendantOf(game) then
            return;
        end;

        u92 = u92 or 0.55;
        local v95 = raycast(CFrame.new(u90.Position) * CFrame.new(math.random(-u92 * 4.5, u92 * 4.5), -u92, math.random(-u92 * 4.5, u92 * 4.5)).Position, (Vector3.new(0, -u90.Size.Y * 2, 0)));

        if v95 and v95.Instance.Transparency < 1 then
            local Part = Instance.new("Part");
            Part.CanCollide = false;
            Part.Anchored = true;
            Part.CFrame = CFrame.new(v95.Position);
            Part.Size = Vector3.new(0, 0, 0);
            Part.Parent = workspace.Effects;
            Part.Material = v95.Material;
            Part.MaterialVariant = v95.Instance.MaterialVariant;
            Part.Color = v95.Instance.Color;
            TweenService:Create(Part, TweenInfo.new(0.2), {
                CFrame = CFrame.new(v95.Position) * CFrame.Angles(math.random(0, 180), math.random(0, 180), math.random(0, 180)),
                Size = Vector3.new(u92, u92, u92)
            }):Play();
            task.delay(Random.new():NextNumber(3, 6), function() -- Line: 552
                -- upvalues: TweenService (ref), Part (copy), Debris (ref)
                TweenService:Create(Part, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
                    Position = Part.Position - Vector3.new(0, Part.Size.Y * 2, 0)
                }):Play();
                Debris:AddItem(Part, 1.5);
            end);
        end;

        local v96 = raycast(u90.Position, Vector3.new(0, 1, 0) * -u90.Size.Y * 2);

        if v96 and v96.Instance.Transparency < 1 then
            local v97 = ReplicatedStorage.Assets.Effects.Parts.DashSmoke:Clone();
            v97.Parent = workspace.Effects;
            v97.CFrame = CFrame.new(v96.Position);

            for _, descendant in ipairs(v97:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Color = ColorSequence.new(v96.Instance.Color);
                end;
            end;

            task.delay(3, v97.Destroy, v97);
        end;
    end);
    task.delay(p91, function() -- Line: 578
        -- upvalues: u98 (copy)
        u98:Disconnect();
    end);
end;

function u3.highlight(p99: any, p100: any, p101: any, p102: boolean) -- Line: 583
    -- upvalues: TweenService (copy)
    local v103 = p100 or Color3.fromRGB(255, 255, 255);
    local v104 = p101 or 0.5;

    for _, child in pairs(p99:GetChildren()) do
        if child:GetAttribute("Effecthighlight") == true then
            child:Destroy();
        end;
    end;

    local Highlight = Instance.new("Highlight");
    Highlight:GetAttribute("Effecthighlight", true);
    Highlight.FillColor = v103;
    Highlight.OutlineColor = v103;
    Highlight.FillTransparency = 0.5;
    Highlight.OutlineTransparency = 0;
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.Parent = p99;

    if not p102 then
        TweenService:Create(Highlight, TweenInfo.new(v104), {
            FillTransparency = 1,
            OutlineTransparency = 1
        }):Play();
    end;

    task.delay(v104, function() -- Line: 605
        -- upvalues: Highlight (copy)
        Highlight:Destroy();
    end);
end;

function DefineCutsceneType(p105: userdata)
    local CamPart = p105:FindFirstChild("CamPart");

    for _, v in pairs({ "CamPart", "Cam", "camera" }) do
        local v106 = p105:FindFirstChild(v);

        if v106 then
            CamPart = v106;
            break;
        end;
    end;

    local RootPart = p105:FindFirstChild("RootPart");

    for _, v in pairs({ "RootPart", "HumanoidRootPart", "camerarootpart" }) do
        local v107 = p105:FindFirstChild(v);

        if v107 then
            RootPart = v107;
            break;
        end;
    end;

    return CamPart and RootPart and "Blender" or "Default";
end;

function u3.PlayCutsceneLite(u108: userdata, p109: userdata, u110: any, p111) -- Line: 640
    -- upvalues: Players (copy), actionUtil (copy), Welder (copy), LocalPlayer (copy), u2 (copy), Lighting (copy), workspace_CurrentCamera2 (copy), Temp (copy), Debris (copy), GetSortedFOV (copy), RunService (copy)
    local u112 = DefineCutsceneType(p109);
    print(u112);
    local u113 = p111 or (u112 == "Blender" and CFrame.new(0, 3, 0) or CFrame.new(0, 0, 0));
    local HumanoidRootPart = u108.HumanoidRootPart;
    local Humanoid = u108.Humanoid;
    local Character = Players.LocalPlayer.Character;
    local u114;

    if u108 == Character then
        u114 = false;
    else
        u114 = actionUtil.checkGK(Character) and not actionUtil.checksameTeam(u108, Character);
    end;

    local u115 = {};
    local u116 = p109:Clone();
    u116.Parent = u108;
    local BindableEvent = Instance.new("BindableEvent");
    BindableEvent.Parent = workspace.Effects;
    local v117 = { "CamPart", "Cam", "camera" };
    local CamPart = u116:FindFirstChild("CamPart");

    if not CamPart then
        for _, v in pairs(v117) do
            CamPart = u116:FindFirstChild(v);

            if CamPart then
                break;
            end;
        end;
    end;

    if not CamPart then
        print("Camera Part not found in Cutscene Pack");

        return;
    end;

    if u112 == "Blender" then
        for _, descendant in ipairs(u116:GetDescendants()) do
            if descendant:IsA("BasePart") then
                descendant.Anchored = false;
                descendant.CanCollide = false;
                descendant.Massless = true;
                descendant.Transparency = 1;
            elseif descendant:IsA("Decal") then
                descendant.Transparency = 1;
            end;
        end;

        local RootPart = u116:FindFirstChild("RootPart");

        for _, v in pairs({ "RootPart", "HumanoidRootPart", "camerarootpart" }) do
            local v118 = u116:FindFirstChild(v);

            if v118 then
                RootPart = v118;
                break;
            end;
        end;

        if not RootPart then
            return print("Not Avilable Cutscene RootPart");
        end;

        Welder:Weld(RootPart, HumanoidRootPart, u113);
        local v119 = u116:FindFirstChildWhichIsA("AnimationController");

        if not v119 then
            return print("Not Avilable Animation Controller");
        end;

        local v120 = v119:FindFirstChildWhichIsA("Animator");

        if not v120 then
            return print("Not Available Cutscene Animator");
        end;

        local v121 = v120:FindFirstChildWhichIsA("Animation");

        if not v121 then
            return print("Not Available Camera Animation");
        end;

        v120:LoadAnimation(v121):Play();
    else
        local v122 = CamPart:FindFirstChildWhichIsA("Motor6D");

        if not v122 then
            for _, descendant in ipairs(u116:GetDescendants()) do
                if descendant:IsA("Motor6D") and descendant.Name == "CamPart" then
                    v122 = descendant;
                    break;
                end;
            end;
        end;

        v122.Part0 = HumanoidRootPart;
    end;

    local u123 = (Humanoid:FindFirstChild("Animator") or Instance.new("Animator", Humanoid)):LoadAnimation(u116.Animation);

    if Players:GetPlayerFromCharacter(u108) == Players.LocalPlayer then
        u123.Priority = Enum.AnimationPriority.Action3;
    else
        u123.Priority = Enum.AnimationPriority.Action4;
    end;

    u123:Play(0);
    LocalPlayer:SetAttribute("InCutscene", true);
    u108:SetAttribute("HideBallDisplay", true);
    HumanoidRootPart.Anchored = true;
    local ImpactFrame = u116:FindFirstChild("ImpactFrame");

    if ImpactFrame and not u114 then
        ImpactFrame.Parent = u2;
        ImpactFrame.DisplayOrder = 100;

        for _, child in pairs(ImpactFrame:GetChildren()) do
            u115[#u115 + 1] = u123:GetMarkerReachedSignal(child.Name):Once(function() -- Line: 755
                -- upvalues: ImpactFrame (copy), child (copy)
                for _, child2 in pairs(ImpactFrame:GetChildren()) do
                    child2.ImageTransparency = 0.995;
                end;

                child.ImageTransparency = 0;

                if child:GetAttribute("LastFrame") then
                    task.delay(0.05, function() -- Line: 761
                        -- upvalues: child (ref)
                        child.ImageTransparency = 1;
                    end);
                end;
            end);
        end;
    end;

    if u114 then
        local Folder = Instance.new("Folder");
        Folder.Name = "CutsceneLighting";
        Folder.Parent = Lighting;
        u115[#u115 + 1] = Folder;
        Lighting.Atmosphere.Density = 0.75;
    end;

    local CFrame2 = workspace_CurrentCamera2.CFrame;

    local function CutsceneEnded(p124) -- Line: 779
        -- upvalues: workspace_CurrentCamera2 (ref), CFrame2 (copy), HumanoidRootPart (copy), Temp (ref), u115 (copy), Debris (ref), ImpactFrame (copy), u116 (copy), BindableEvent (copy), u123 (copy), u108 (copy), LocalPlayer (ref)
        workspace_CurrentCamera2.CFrame = CFrame2;
        HumanoidRootPart.Anchored = false;
        Temp.ClearTemp(u115);
        workspace_CurrentCamera2.CameraType = Enum.CameraType.Custom;
        workspace_CurrentCamera2.FieldOfView = 70;
        Debris:AddItem(ImpactFrame, 0);
        Debris:AddItem(u116, 0);
        BindableEvent:Fire(p124);
        Debris:AddItem(BindableEvent, 1);
        u123:Destroy();
        u108:SetAttribute("HideBallDisplay", nil);
        LocalPlayer:SetAttribute("InCutscene", nil);
    end;

    u115[#u115 + 1] = u123.Stopped:Once(function() -- Line: 799
        -- upvalues: CutsceneEnded (copy)
        CutsceneEnded();
    end);

    local function CamCFrame(p125) -- Line: 803
        -- upvalues: u112 (copy), CamPart (ref), u113 (ref), u110 (copy), workspace_CurrentCamera2 (ref)
        local v126 = u112 == "Blender" and CamPart.CFrame or CamPart.CFrame * u113;

        if u110 == true then
            workspace_CurrentCamera2.CFrame = workspace_CurrentCamera2.CFrame:Lerp(v126, p125 * 20);

            return;
        end;

        if typeof(u110) == "number" then
            workspace_CurrentCamera2.CFrame = workspace_CurrentCamera2.CFrame:Lerp(v126, p125 * u110);

            return;
        end;

        workspace_CurrentCamera2.CFrame = v126;
    end;

    local FOV = u116:FindFirstChild("FOV");
    local u127 = FOV and GetSortedFOV(FOV) or nil;

    if not u114 then
        workspace_CurrentCamera2.CameraType = Enum.CameraType.Scriptable;

        if u110 == nil then
            CamCFrame();
        end;
    end;

    local os_clock_ret = os.clock();
    u115[#u115 + 1] = RunService.RenderStepped:Connect(function(p128) -- Line: 824
        -- upvalues: u108 (copy), u116 (copy), CutsceneEnded (copy), u114 (copy), os_clock_ret (copy), CamCFrame (copy), u127 (copy), workspace_CurrentCamera2 (ref)
        if not (u108:IsDescendantOf(game) and u116:IsDescendantOf(game)) then
            CutsceneEnded(true);

            return;
        end;

        if u114 then
            return;
        end;

        local v129 = os.clock() - os_clock_ret;
        CamCFrame(p128);
        local v130 = u127 and u127(v129 * 60);

        if v130 then
            workspace_CurrentCamera2.FieldOfView = v130.Value;
        end;
    end);

    return BindableEvent, CamPart;
end;

return u3;