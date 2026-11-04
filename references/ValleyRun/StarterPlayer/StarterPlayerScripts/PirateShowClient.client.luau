 

 

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local HttpService = game:GetService("HttpService");
local Lighting = game:GetService("Lighting");
local SoundService = game:GetService("SoundService");
local Debris = game:GetService("Debris");
local LocalPlayer = Players.LocalPlayer;
local ChickenOrHero = game.ReplicatedStorage:WaitForChild("ChickenOrHero");
local Session = ChickenOrHero:WaitForChild("Game"):WaitForChild("Session");
local Presentation = ChickenOrHero:WaitForChild("Presentation");
local CreatorVisibility = require(Presentation:WaitForChild("CreatorVisibility"));
local LocalHide = require(Presentation:WaitForChild("LocalHide"));
local PirateShots = require(Presentation:WaitForChild("PirateShots"));
local CharacterClone = require(ChickenOrHero:WaitForChild("Interface"):WaitForChild("CharacterClone"));
local KnifeVisibility = require(ChickenOrHero:WaitForChild("Weapons"):WaitForChild("KnifeVisibility"));
local LazySound = require(game:GetService("ReplicatedFirst"):WaitForChild("LazySound"));
local FootballShots = require(Presentation:WaitForChild("FootballShots"));
local orbit = FootballShots.orbit;
local glide = FootballShots.glide;
local smooth = PirateShots.smooth;
local smoother = PirateShots.smoother;
local Sounds = PirateShots.Sounds;
local Intro = PirateShots.Intro;
local Finale = PirateShots.Finale;
local u1 = {};

local function on(p2, p3) -- Line: 35
    -- upvalues: u1 (copy)
    table.insert(u1, p2:Connect(p3));
end;

local function decode(p4) -- Line: 38
    -- upvalues: Session (copy), HttpService (copy)
    local Attribute = Session:GetAttribute(p4);

    if type(Attribute) ~= "string" or Attribute == "" then
        return nil;
    end;

    local success, result = pcall(HttpService.JSONDecode, HttpService, Attribute);

    if not (success and (type(result) == "table" and result)) then
        result = nil;
    end;

    return result;
end;

local Folder = Instance.new("Folder");
Folder.Name = "PirateSequenceAudio";
Folder.Parent = SoundService;
local Sound = Instance.new("Sound");
Sound.Name = "Song";
Sound.SoundId = "rbxassetid://" .. Sounds.Song;
Sound.Looped = true;
Sound.Volume = 0;
Sound:SetAttribute("Volume", 0.5);
local Attachment = Instance.new("Attachment");
Attachment.Name = "PirateSongAnchor";
Attachment.Parent = workspace.Terrain;
Sound.RollOffMinDistance = 40;
Sound.RollOffMaxDistance = 260;
Sound.Parent = Attachment;
local u5 = nil;
local u6 = false;
local u7 = nil;

local function musicLevel() -- Line: 70
    -- upvalues: LocalPlayer (copy)
    if LocalPlayer:GetAttribute("MusicMuted") == true then
        return 0;
    end;

    local Attribute = LocalPlayer:GetAttribute("MusicVolume");

    return type(Attribute) == "number" and (Attribute == Attribute and math.clamp(Attribute, 0, 1)) or 1;
end;

local function fadeSong(p8, p9) -- Line: 77
    -- upvalues: u7 (ref), TweenService (copy), Sound (copy)
    if u7 then
        u7:Cancel();
    end;

    u7 = TweenService:Create(Sound, TweenInfo.new(p9), {
        Volume = p8
    });
    u7:Play();

    return u7;
end;

local function startSong(u10) -- Line: 85
    -- upvalues: u6 (ref), u5 (ref), RunService (copy), Attachment (copy), LazySound (copy), Sound (copy), fadeSong (copy), LocalPlayer (copy)
    if u6 then
        return;
    end;

    u6 = true;

    if u5 then
        u5:Disconnect();
    end;

    u5 = RunService.Heartbeat:Connect(function() -- Line: 93
        -- upvalues: u10 (copy), Attachment (ref)
        local v11 = u10 and u10.Character;

        if v11 then
            v11 = v11:FindFirstChild("HumanoidRootPart");
        end;

        if v11 then
            Attachment.WorldPosition = v11.Position;
        end;
    end);
    LazySound.arm(Sound);
    Sound.TimePosition = 0;
    Sound.Volume = 0;
    Sound:Play();
    local Attribute = Sound:GetAttribute("Volume");
    local v12;

    if LocalPlayer:GetAttribute("MusicMuted") == true then
        v12 = 0;
    else
        local Attribute2 = LocalPlayer:GetAttribute("MusicVolume");
        v12 = type(Attribute2) == "number" and (Attribute2 == Attribute2 and math.clamp(Attribute2, 0, 1)) or 1;
    end;

    fadeSong(Attribute * v12, 0.8);
    LocalPlayer:SetAttribute("MusicPaused", true);
end;

local function stopSong() -- Line: 107
    -- upvalues: u6 (ref), LocalPlayer (copy), fadeSong (copy), Sound (copy), u5 (ref)
    if not u6 then
        return;
    end;

    u6 = false;
    LocalPlayer:SetAttribute("MusicPaused", nil);
    fadeSong(0, 1.5).Completed:Once(function(p13) -- Line: 113
        -- upvalues: u6 (ref), Sound (ref), u5 (ref)
        if p13 == Enum.PlaybackState.Completed and not u6 then
            Sound:Stop();

            if u5 then
                u5:Disconnect();
                u5 = nil;
            end;
        end;
    end);
end;

for _, v in { "MusicMuted", "MusicVolume" } do
    local AttributeChangedSignal = LocalPlayer:GetAttributeChangedSignal(v);
    table.insert(u1, AttributeChangedSignal:Connect(function() -- Line: 124
        -- upvalues: u6 (ref), fadeSong (copy), Sound (copy), LocalPlayer (copy)
        if u6 then
            local Attribute = Sound:GetAttribute("Volume");
            local v14;

            if LocalPlayer:GetAttribute("MusicMuted") == true then
                v14 = 0;
            else
                local Attribute2 = LocalPlayer:GetAttribute("MusicVolume");
                v14 = type(Attribute2) == "number" and (Attribute2 == Attribute2 and math.clamp(Attribute2, 0, 1)) or 1;
            end;

            fadeSong(Attribute * v14, 0.2);
        end;
    end));
end;

local AttributeChangedSignal = Session:GetAttributeChangedSignal("PirateRun");
table.insert(u1, AttributeChangedSignal:Connect(function() -- Line: 131
    -- upvalues: Session (copy), u6 (ref), stopSong (copy)
    if Session:GetAttribute("PirateRun") == nil and u6 then
        task.delay(0.6, function() -- Line: 133
            -- upvalues: Session (ref), stopSong (ref)
            if Session:GetAttribute("PirateRun") == nil then
                stopSong();
            end;
        end);
    end;
end));

local function leftMatch() -- Line: 140
    -- upvalues: u6 (ref), LocalPlayer (copy), stopSong (copy)
    if u6 and (LocalPlayer:GetAttribute("InMatch") ~= true and LocalPlayer:GetAttribute("Spectating") ~= true) then
        stopSong();
    end;
end;

local AttributeChangedSignal2 = LocalPlayer:GetAttributeChangedSignal("InMatch");
table.insert(u1, AttributeChangedSignal2:Connect(leftMatch));
local AttributeChangedSignal3 = LocalPlayer:GetAttributeChangedSignal("Spectating");
table.insert(u1, AttributeChangedSignal3:Connect(leftMatch));
local Font_new_ret = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.ExtraBold);
local Color3_new_ret = Color3.new(1, 1, 1);
local Gold = PirateShots.Gold;
local Color3_fromRGB_ret = Color3.fromRGB(196, 38, 46);
local Color3_fromRGB_ret2 = Color3.fromRGB(110, 92, 70);
local u15 = {
    Intro = true,
    Finale = true
};
local PirateShow = Presentation:WaitForChild("PirateShow", 30);
local RaycastParams_new_ret = RaycastParams.new();
RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
RaycastParams_new_ret.RespectCanCollide = true;
local RaycastParams_new_ret2 = RaycastParams.new();
RaycastParams_new_ret2.FilterType = Enum.RaycastFilterType.Exclude;
RaycastParams_new_ret2.IgnoreWater = true;
local RaycastParams_new_ret3 = RaycastParams.new();
RaycastParams_new_ret3.FilterType = Enum.RaycastFilterType.Exclude;
RaycastParams_new_ret3.IgnoreWater = true;
local u16 = nil;

local function sound(p17, p18, p19, p20, p21) -- Line: 170
    -- upvalues: Debris (copy)
    local Sound2 = Instance.new("Sound");
    Sound2.SoundId = "rbxassetid://" .. p18;
    Sound2.Volume = p19 or 0.7;
    Sound2.PlaybackSpeed = p20 or 1;
    local Attachment2 = Instance.new("Attachment");

    if typeof(p21) ~= "Vector3" then
        p21 = p17.origin;
    end;

    Attachment2.WorldPosition = p21;
    Attachment2.Parent = workspace.Terrain;
    Sound2.RollOffMinDistance = 20;
    Sound2.RollOffMaxDistance = 300;
    Sound2.Parent = Attachment2;
    Debris:AddItem(Attachment2, 6);
    Sound2:Play();
    Debris:AddItem(Sound2, 6);

    return Sound2;
end;

local function textLabel(p22, p23, p24, p25, p26, p27) -- Line: 186
    -- upvalues: Font_new_ret (copy)
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Name = p23;
    TextLabel.AnchorPoint = Vector2.new(0.5, 0.5);
    TextLabel.Position = UDim2.fromScale(0.5, p24);
    TextLabel.Size = UDim2.fromScale(0.8, p25);
    TextLabel.BackgroundTransparency = 1;
    TextLabel.FontFace = Font_new_ret;
    TextLabel.TextColor3 = p26;
    TextLabel.TextScaled = true;
    TextLabel.TextTransparency = 1;
    TextLabel.Text = "";
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Thickness = 3;
    UIStroke.Transparency = 1;
    UIStroke.Parent = TextLabel;
    local UITextSizeConstraint = Instance.new("UITextSizeConstraint");
    UITextSizeConstraint.MaxTextSize = p27;
    UITextSizeConstraint.Parent = TextLabel;
    Instance.new("UIScale").Parent = TextLabel;
    TextLabel.Parent = p22;

    return TextLabel;
end;

local function pop(p28, p29) -- Line: 209
    -- upvalues: TweenService (copy)
    p28.Text = p29;
    p28.UIScale.Scale = 1.35;
    TweenService:Create(p28, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
        TextTransparency = 0
    }):Play();
    TweenService:Create(p28.UIStroke, TweenInfo.new(0.2), {
        Transparency = 0.2
    }):Play();
    TweenService:Create(p28.UIScale, TweenInfo.new(0.35, Enum.EasingStyle.Back), {
        Scale = 1
    }):Play();
end;

local function fadeOut(p30) -- Line: 216
    -- upvalues: TweenService (copy)
    TweenService:Create(p30, TweenInfo.new(0.35), {
        TextTransparency = 1
    }):Play();
    TweenService:Create(p30.UIStroke, TweenInfo.new(0.35), {
        Transparency = 1
    }):Play();
end;

local function cover(p31, p32, p33, p34) -- Line: 220
    local Frame = Instance.new("Frame");
    Frame.Name = p32;
    Frame.AnchorPoint = Vector2.new(0.5, 0.5);
    Frame.Position = UDim2.fromScale(0.5, 0.5);
    Frame.Size = UDim2.fromScale(1.5, 1.5);
    Frame.BackgroundColor3 = p33;
    Frame.BackgroundTransparency = p34;
    Frame.BorderSizePixel = 0;
    Frame.Parent = p31;

    return Frame;
end;

local function bar(p35, p36, p37) -- Line: 232
    local Frame = Instance.new("Frame");
    Frame.Name = p36;
    Frame.AnchorPoint = Vector2.new(0.5, p37 and 1 or 0);
    Frame.Position = UDim2.fromScale(0.5, p37 and 0 or 1);
    Frame.Size = UDim2.new(1.5, 0, 0.11, 1200);
    Frame.BackgroundColor3 = Color3.new(0, 0, 0);
    Frame.BorderSizePixel = 0;
    Frame.Parent = p35;

    return Frame;
end;

local function letterbox(p38, p39) -- Line: 243
    p38.bars = p39;
    p38.top.Position = UDim2.fromScale(0.5, 0.11 * p39);
    p38.bottom.Position = UDim2.fromScale(0.5, 1 - 0.11 * p39);
end;

local function flash(p40, p41, p42) -- Line: 248
    -- upvalues: Color3_new_ret (copy), TweenService (copy)
    p40.flash.BackgroundColor3 = p42 or Color3_new_ret;
    p40.flash.BackgroundTransparency = 1 - p41;
    TweenService:Create(p40.flash, TweenInfo.new(0.3), {
        BackgroundTransparency = 1
    }):Play();
end;

local function floorAt(p43, p44) -- Line: 254
    -- upvalues: RaycastParams_new_ret (copy)
    RaycastParams_new_ret.FilterDescendantsInstances = p43.floorIgnore;
    local v45 = workspace:Raycast(p44 + Vector3.new(0, 6, 0), Vector3.new(-0, -40, -0), RaycastParams_new_ret);

    if v45 then
        return v45.Position;
    end;

    return p44 - Vector3.new(0, 3, 0);
end;

local function groundAt(p46, p47) -- Line: 261
    local RaycastParams_new_ret4 = RaycastParams.new();
    RaycastParams_new_ret4.FilterType = Enum.RaycastFilterType.Exclude;
    RaycastParams_new_ret4.FilterDescendantsInstances = p46.floorIgnore;
    local v48 = p47 + Vector3.new(0, 80, 0);

    for i = 1, 8 do
        local v49 = workspace:Raycast(v48, Vector3.new(-0, -200, -0), RaycastParams_new_ret4);

        if not v49 then
            break;
        end;

        if v49.Instance.Transparency < 0.95 then
            return v49.Position;
        end;

        RaycastParams_new_ret4:AddToFilter(v49.Instance);
        local _ = i;
    end;

    return nil;
end;

local function emitterPart(p50, p51, p52) -- Line: 278
    local Part = Instance.new("Part");
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.CastShadow = false;
    Part.Transparency = 1;
    Part.Size = p52 or Vector3.new(1, 1, 1);
    Part.CFrame = CFrame.new(p51);
    Part.Parent = p50.stage;

    return Part;
end;

local function smoke(p53, p54, p55, p56, p57, p58) -- Line: 287
    -- upvalues: Debris (copy)
    local Part = Instance.new("Part");
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.CastShadow = false;
    Part.Transparency = 1;
    Part.Size = Vector3.new(1, 1, 1);
    Part.CFrame = CFrame.new(p54);
    Part.Parent = p53.stage;
    local ParticleEmitter = Instance.new("ParticleEmitter");
    ParticleEmitter.Texture = "rbxasset://textures/particles/smoke_main.dds";
    ParticleEmitter.Color = ColorSequence.new(p57 or Color3.fromRGB(215, 210, 200));
    ParticleEmitter.Size = NumberSequence.new(p56 * 0.5, p56);
    ParticleEmitter.Transparency = NumberSequence.new(0.15, 1);
    ParticleEmitter.Lifetime = NumberRange.new(0.9, 1.6);
    ParticleEmitter.Speed = NumberRange.new(p58 or 4, (p58 or 4) * 2.5);
    ParticleEmitter.SpreadAngle = Vector2.new(180, 180);
    ParticleEmitter.Drag = 3;
    ParticleEmitter.Rate = 0;
    ParticleEmitter.Parent = Part;
    ParticleEmitter:Emit(p55);
    Debris:AddItem(Part, 2.2);
end;

local function fireball(p59, p60, p61) -- Line: 303
    -- upvalues: TweenService (copy), Debris (copy)
    local Part = Instance.new("Part");
    Part.Shape = Enum.PartType.Ball;
    Part.Material = Enum.Material.Neon;
    Part.Color = Color3.fromRGB(255, 176, 70);
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.CastShadow = false;
    Part.Size = Vector3.new(1, 1, 1) * p61 * 0.3;
    Part.CFrame = CFrame.new(p60);
    Part.Parent = p59.stage;
    TweenService:Create(Part, TweenInfo.new(0.22, Enum.EasingStyle.Quad), {
        Transparency = 1,
        Size = Vector3.new(1, 1, 1) * p61
    }):Play();
    local PointLight = Instance.new("PointLight");
    PointLight.Color = Part.Color;
    PointLight.Brightness = 6;
    PointLight.Range = 18;
    PointLight.Parent = Part;
    Debris:AddItem(Part, 0.3);
end;

local function sparkle(p62, p63, p64, p65, p66, p67) -- Line: 320
    -- upvalues: Debris (copy)
    local Part = Instance.new("Part");
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.CastShadow = false;
    Part.Transparency = 1;
    Part.Size = Vector3.new(1, 1, 1);
    Part.CFrame = CFrame.new(p63);
    Part.Parent = p62.stage;
    local ParticleEmitter = Instance.new("ParticleEmitter");
    ParticleEmitter.Texture = p67 or "rbxasset://textures/particles/sparkles_main.dds";
    ParticleEmitter.Color = ColorSequence.new(p64);
    ParticleEmitter.LightEmission = 0.6;
    ParticleEmitter.Size = NumberSequence.new(0.45, 0.15);
    ParticleEmitter.Lifetime = NumberRange.new(1.2, 2);
    ParticleEmitter.Speed = NumberRange.new(p66 * 0.6, p66);
    ParticleEmitter.SpreadAngle = Vector2.new(35, 35);
    ParticleEmitter.Acceleration = Vector3.new(0, -30, 0);
    ParticleEmitter.Drag = 1;
    ParticleEmitter.Rotation = NumberRange.new(0, 360);
    ParticleEmitter.RotSpeed = NumberRange.new(-300, 300);
    ParticleEmitter.EmissionDirection = Enum.NormalId.Top;
    ParticleEmitter.Rate = 0;
    ParticleEmitter.Parent = Part;
    ParticleEmitter:Emit(p65);
    Debris:AddItem(Part, 2.5);
end;

local function prop(p68, p69) -- Line: 341
    -- upvalues: PirateShow (copy)
    local v70 = PirateShow and PirateShow:FindFirstChild(p69);

    if not v70 then
        return nil;
    end;

    local v71 = v70:Clone();
    v71.Parent = p68.stage;

    return v71;
end;

local function fade(p72, p73) -- Line: 350
    for _, descendant in p72:GetDescendants() do
        if descendant:IsA("BasePart") or descendant:IsA("Decal") then
            descendant.LocalTransparencyModifier = p73;
        end;
    end;
end;

local function copyRunner(p74) -- Line: 360
    -- upvalues: CharacterClone (copy), KnifeVisibility (copy)
    local v75, _, v76 = CharacterClone.copy(p74);

    if not v75 then
        return nil;
    end;

    local EquippedDagger = p74:FindFirstChild("EquippedDagger");
    local EquippedDagger2 = v75:FindFirstChild("EquippedDagger");

    if EquippedDagger2 then
        for _, v in { "Blade", "LeftBlade" } do
            local v77 = EquippedDagger2:FindFirstChild(v);

            if v77 then
                KnifeVisibility.set(v77, true);
            end;
        end;

        for _, v in { "StowedBlade", "LeftStowedBlade" } do
            local v78 = EquippedDagger2:FindFirstChild(v);

            if v78 then
                KnifeVisibility.set(v78, false);
            end;
        end;
    end;

    if EquippedDagger and EquippedDagger2 then
        local function find(p79) -- Line: 382
            -- upvalues: EquippedDagger2 (copy)
            local v80 = EquippedDagger2;

            for _, v in p79 do
                if v80 then
                    v80 = v80:FindFirstChild(v);
                end;
            end;

            return v80;
        end;

        local function pathOf(p81) -- Line: 389
            -- upvalues: EquippedDagger (copy)
            local v82 = {};

            while p81 and p81 ~= EquippedDagger do
                table.insert(v82, 1, p81.Name);
                p81 = p81.Parent;
            end;

            return v82;
        end;

        for _, descendant in EquippedDagger:GetDescendants() do
            local v83 = descendant:IsA("Beam") and not descendant:FindFirstAncestor("StowedBlade") and not descendant:FindFirstAncestor("LeftStowedBlade");

            if v83 and (descendant.Attachment0 and descendant.Attachment1) then
                local v84 = EquippedDagger2;
                local v85 = descendant;

                for _, v in pathOf(descendant.Parent) do
                    if EquippedDagger2 then
                        EquippedDagger2 = EquippedDagger2:FindFirstChild(v);
                    end;
                end;

                local v86 = v84;

                for _, v in pathOf(v85.Attachment0) do
                    if v84 then
                        v84 = v84:FindFirstChild(v);
                    end;
                end;

                local v87 = v86;

                for _, v in pathOf(v85.Attachment1) do
                    if v86 then
                        v86 = v86:FindFirstChild(v);
                    end;
                end;

                if EquippedDagger2 and (v84 and v86) then
                    local v88 = v85:Clone();
                    v88.Attachment0 = v84;
                    v88.Attachment1 = v86;
                    v88.Enabled = true;
                    v88.Parent = EquippedDagger2;
                    EquippedDagger2 = v87;
                else
                    EquippedDagger2 = v87;
                end;
            end;
        end;
    end;

    return v75, v76;
end;

local function headOnly(p89, p90) -- Line: 414
    local Head = p89:FindFirstChild("Head");

    for _, descendant in p89:GetDescendants() do
        if descendant:IsA("BasePart") or descendant:IsA("Decal") then
            local v91;

            if Head then
                v91 = descendant == Head and true or descendant:IsDescendantOf(Head);
            else
                v91 = Head;
            end;

            if not v91 and Head then
                local v92 = descendant:FindFirstAncestorWhichIsA("Accessory");

                if v92 then
                    v92 = v92:FindFirstChild("Handle");
                end;

                if v92 then
                    v92 = v92:FindFirstChildWhichIsA("JointInstance");
                end;

                if v92 == nil then
                    v91 = false;
                else
                    v91 = v92.Part0 == Head and true or v92.Part1 == Head;
                end;
            end;

            descendant.LocalTransparencyModifier = p90 and not v91 and 1 or 0;
        end;
    end;
end;

local function cameraZoom(p93) -- Line: 431
    -- upvalues: LocalPlayer (copy)
    local PlayerScripts = LocalPlayer:FindFirstChild("PlayerScripts");

    if PlayerScripts then
        PlayerScripts = PlayerScripts:FindFirstChild("PlayerModule");
    end;

    local v94, v95;

    if PlayerScripts then
        v94, v95 = pcall(function() -- Line: 436
            -- upvalues: PlayerScripts (copy)
            return require(PlayerScripts):GetCameras().activeCameraController:GetCameraToSubjectDistance();
        end);
    else
        v94 = false;
        v95 = nil;
    end;

    if not (v94 and (type(v95) == "number" and v95 == v95)) then
        v95 = (p93.CFrame.Position - p93.Focus.Position).Magnitude;
    end;

    local CameraMinZoomDistance = LocalPlayer.CameraMinZoomDistance;
    local math_max_ret = math.max(CameraMinZoomDistance, LocalPlayer.CameraMaxZoomDistance);

    return math.clamp(v95, CameraMinZoomDistance, math_max_ret);
end;

local function home(p96) -- Line: 447
    -- upvalues: RaycastParams_new_ret2 (copy)
    local homeSubject = p96.homeSubject;
    local v97 = homeSubject and (homeSubject.Parent and homeSubject:IsA("Humanoid")) and homeSubject.RootPart;
    local v98 = v97 and v97.Position + v97.CFrame:VectorToWorldSpace(Vector3.new(0, 1.5, 0) + homeSubject.CameraOffset) or homeSubject and (homeSubject.Parent and homeSubject:IsA("BasePart")) and homeSubject.Position;

    if not v98 then
        return nil;
    end;

    local v99 = -p96.homeLook * p96.zoom;
    RaycastParams_new_ret2.FilterDescendantsInstances = p96.ignore;

    for i = 1, 4 do
        local v100 = workspace:Raycast(v98, v99, RaycastParams_new_ret2);

        if not v100 then
            break;
        end;

        if v100.Instance.CanCollide and v100.Instance.Transparency < 0.25 then
            v99 = v99.Unit * math.max(0.5, v100.Distance - 0.3);
            break;
        end;

        RaycastParams_new_ret2:AddToFilter(v100.Instance);
        local _ = i;
    end;

    local v101 = v98 + v99;

    return CFrame.lookAt(v101, v101 + p96.homeLook), v98;
end;

local function unblocked(p102, p103, p104, p105, p106) -- Line: 472
    -- upvalues: RaycastParams_new_ret3 (copy)
    local v107 = p103.Position - p104;
    local Magnitude = v107.Magnitude;
    local v108 = 0;

    if Magnitude >= 0.6 then
        RaycastParams_new_ret3.FilterDescendantsInstances = p102.occluders;

        for i = 1, 4 do
            local v109 = workspace:Raycast(p104, v107, RaycastParams_new_ret3);

            if not v109 then
                break;
            end;

            if v109.Instance.CanCollide and (v109.Instance.Transparency < 0.25 and v109.Instance.LocalTransparencyModifier < 1) then
                v108 = Magnitude - math.max(0.5, v109.Distance - 0.4);
                break;
            end;

            RaycastParams_new_ret3:AddToFilter(v109.Instance);
            local _ = i;
        end;
    end;

    local pull = p102.pull;

    if pull ~= nil and (pull >= v108 or p106) then
        v108 = pull + (v108 - pull) * math.min(1, p105 * 6);
    end;

    p102.pull = v108;

    if v108 <= 0.01 or Magnitude < 0.6 then
        return p103;
    end;

    return p103 - v107.Unit * math.min(v108, Magnitude - 0.5);
end;

local function introSetup(p110) -- Line: 500
    -- upvalues: RaycastParams_new_ret (copy), PirateShow (copy), Intro (copy), groundAt (copy), fade (copy), PirateShots (copy)
    local forward = p110.forward;
    local right = p110.right;
    local origin = p110.origin;
    RaycastParams_new_ret.FilterDescendantsInstances = p110.floorIgnore;
    local v111 = workspace:Raycast(origin + Vector3.new(0, 6, 0), Vector3.new(-0, -40, -0), RaycastParams_new_ret);
    local v112;

    if v111 then
        v112 = v111.Position;
    else
        v112 = origin - Vector3.new(0, 3, 0);
    end;

    p110.floorY = v112.Y;
    local v113 = PirateShow and PirateShow:FindFirstChild("Ship");
    local v114;

    if v113 then
        v114 = v113:Clone();
        v114.Parent = p110.stage;
    else
        v114 = nil;
    end;

    if v114 then
        local v115 = nil;

        for i = Intro.ShipBack, 6, -2 do
            local v116 = groundAt(p110, origin - forward * (i - 5));

            if v116 and groundAt(p110, origin - forward * (i + 5)) then
                v115 = groundAt(p110, origin - forward * i) or v116;
                break;
            end;

            local _ = i;
        end;

        if not v115 then
            local v117 = origin - forward * Intro.ShipBack;
            RaycastParams_new_ret.FilterDescendantsInstances = p110.floorIgnore;
            local v118 = workspace:Raycast(v117 + Vector3.new(0, 6, 0), Vector3.new(-0, -40, -0), RaycastParams_new_ret);

            if v118 then
                v115 = v118.Position;
            else
                v115 = v117 - Vector3.new(0, 3, 0);
            end;
        end;

        local v119 = v115 - Vector3.new(0, 1, 0) * Intro.ShipSink;
        p110.shipRest = CFrame.lookAt(v119, v119 + right);
        p110.ship = v114;
        fade(v114, 1);
        v114:PivotTo(p110.shipRest - right * 26);

        for _, descendant in v114:GetDescendants() do
            if descendant:IsA("BasePart") then
                descendant.Color = PirateShots.Ghost;
            end;
        end;

        local PointLight = Instance.new("PointLight");
        PointLight.Color = PirateShots.Ghost;
        PointLight.Brightness = 2.5;
        PointLight.Range = 40;
        PointLight.Parent = v114.PrimaryPart;
    end;

    local v120 = origin - forward * 6;
    RaycastParams_new_ret.FilterDescendantsInstances = p110.floorIgnore;
    local v121 = workspace:Raycast(v120 + Vector3.new(0, 6, 0), Vector3.new(-0, -40, -0), RaycastParams_new_ret);
    local v122;

    if v121 then
        v122 = v121.Position;
    else
        v122 = v120 - Vector3.new(0, 3, 0);
    end;

    local v123 = v122 + Vector3.new(0, 0.8, 0);
    local Part = Instance.new("Part");
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.CastShadow = false;
    Part.Transparency = 1;
    Part.Size = Vector3.new(70, 1, 46);
    Part.CFrame = CFrame.new(v123);
    Part.Parent = p110.stage;
    Part.CFrame = CFrame.lookAt(v123, v123 + forward);
    local ParticleEmitter = Instance.new("ParticleEmitter");
    ParticleEmitter.Texture = "rbxasset://textures/particles/smoke_main.dds";
    ParticleEmitter.Color = ColorSequence.new(Color3.fromRGB(176, 214, 196), Color3.fromRGB(120, 160, 150));
    ParticleEmitter.Shape = Enum.ParticleEmitterShape.Box;
    ParticleEmitter.ShapeStyle = Enum.ParticleEmitterShapeStyle.Volume;
    ParticleEmitter.Size = NumberSequence.new(7, 12);
    ParticleEmitter.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.3, 0.55), NumberSequenceKeypoint.new(1, 1) });
    ParticleEmitter.Lifetime = NumberRange.new(2.5, 3.5);
    ParticleEmitter.Speed = NumberRange.new(0.5, 1.5);
    ParticleEmitter.Rotation = NumberRange.new(0, 360);
    ParticleEmitter.RotSpeed = NumberRange.new(-12, 12);
    ParticleEmitter.LightInfluence = 0.6;
    ParticleEmitter.Rate = 40;
    ParticleEmitter.Parent = Part;
    ParticleEmitter:Emit(30);
    p110.fog = ParticleEmitter;
    local v124 = PirateShow and PirateShow:FindFirstChild("Flag");
    local v125;

    if v124 then
        v125 = v124:Clone();
        v125.Parent = p110.stage;
    else
        v125 = nil;
    end;

    if v125 then
        local v126 = origin + right * 4.5 - forward * 2;
        RaycastParams_new_ret.FilterDescendantsInstances = p110.floorIgnore;
        local v127 = workspace:Raycast(v126 + Vector3.new(0, 6, 0), Vector3.new(-0, -40, -0), RaycastParams_new_ret);
        local v128;

        if v127 then
            v128 = v127.Position;
        else
            v128 = v126 - Vector3.new(0, 3, 0);
        end;

        p110.flagRest = CFrame.lookAt(v128, v128 + forward);
        p110.flag = v125;
        v125:PivotTo(p110.flagRest - Vector3.new(0, 14, 0));
    end;
end;

local function introStep(u129, u130) -- Line: 567
    -- upvalues: sound (copy), Sounds (copy), pop (copy), smoother (copy), Intro (copy), smooth (copy), fade (copy), flash (copy), PirateShots (copy), smoke (copy), Color3_fromRGB_ret2 (copy), fireball (copy)
    local forward = u129.forward;
    local right = u129.right;
    local origin = u129.origin;

    local function once(p131, p132, p133) -- Line: 569
        -- upvalues: u129 (copy), u130 (copy)
        if not u129.fired[p131] and p132 <= u130 then
            u129.fired[p131] = true;
            p133();
        end;
    end;

    local function _() -- Line: 575
        -- upvalues: sound (ref), u129 (copy), Sounds (ref), origin (copy), pop (ref)
        local v134;

        if u129.shipRest then
            v134 = u129.shipRest.Position;
        else
            v134 = origin;
        end;

        sound(u129, Sounds.Bell, 0.8, 1, v134);
        pop(u129.eyebrow, "PLUNDER RUN");
    end;

    if not u129.fired.bell and u130 >= 0.05 then
        u129.fired.bell = true;
        local v135;

        if u129.shipRest then
            v135 = u129.shipRest.Position;
        else
            v135 = origin;
        end;

        sound(u129, Sounds.Bell, 0.8, 1, v135);
        pop(u129.eyebrow, "PLUNDER RUN");
    end;

    if u129.ship then
        local v136 = smoother((u130 - Intro.ShipIn) / (Intro.ShipSet - Intro.ShipIn));
        local v137 = smooth((u130 - Intro.Back - 0.4) / 0.9);
        u129.ship:PivotTo((u129.shipRest - right * 26 * (1 - v136)) * CFrame.new(0, math.sin(u130 * 1.6) * 0.35, 0) * CFrame.Angles(0, 0, math.sin(u130 * 1.1) * 0.025));
        fade(u129.ship, 1 - 0.8 * v136 * (1 - v137));
    end;

    local function _() -- Line: 585
        -- upvalues: sound (ref), u129 (copy), Sounds (ref), origin (copy), pop (ref), flash (ref), PirateShots (ref)
        sound(u129, Sounds.Whoosh, 0.6, 1.3, origin);
        pop(u129.title, u129.name .. " TAKES THE HELM");
        flash(u129, 0.25, PirateShots.Accent);
    end;

    if not u129.fired.cross and Intro.Cross <= u130 then
        u129.fired.cross = true;
        sound(u129, Sounds.Whoosh, 0.6, 1.3, origin);
        pop(u129.title, u129.name .. " TAKES THE HELM");
        flash(u129, 0.25, PirateShots.Accent);
    end;

    local function _() -- Line: 590
        -- upvalues: sound (ref), u129 (copy), Sounds (ref), origin (copy), smoke (ref), Color3_fromRGB_ret2 (ref)
        local v138;

        if u129.flagRest then
            v138 = u129.flagRest.Position;
        else
            v138 = origin;
        end;

        sound(u129, Sounds.Whoosh, 0.9, 0.85, v138);

        if u129.flagRest then
            smoke(u129, u129.flagRest.Position, 16, 3, Color3_fromRGB_ret2, 6);
        end;
    end;

    if not u129.fired.flag and Intro.Flag <= u130 then
        u129.fired.flag = true;
        local v139;

        if u129.flagRest then
            v139 = u129.flagRest.Position;
        else
            v139 = origin;
        end;

        sound(u129, Sounds.Whoosh, 0.9, 0.85, v139);

        if u129.flagRest then
            smoke(u129, u129.flagRest.Position, 16, 3, Color3_fromRGB_ret2, 6);
        end;
    end;

    if u129.flag then
        local v140 = smooth((u130 - Intro.Flag) / 0.3);
        local v141 = smooth((u130 - Intro.Back - 0.5) / 0.6);
        local v142 = (Intro.Flag >= u130 or u130 >= Intro.Flag + 0.8) and 0 or math.sin((u130 - Intro.Flag) * 26) * 0.08 * (1 - (u130 - Intro.Flag) / 0.8);
        u129.flag:PivotTo((u129.flagRest - Vector3.new(0, 14, 0) * (1 - v140 + v141)) * CFrame.Angles(v142, 0, v142 * 0.6));
    end;

    for i = 0, 2 do
        local v143 = "salute" .. i;

        local function v145() -- Line: 603
            -- upvalues: u129 (copy), i (copy), forward (copy), fireball (ref), smoke (ref), sound (ref), Sounds (ref)
            if u129.shipRest then
                local v144 = (u129.shipRest * CFrame.new((i - 1) * 7, 5, 0)).Position + forward * 4;
                fireball(u129, v144, 6);
                smoke(u129, v144, 14, 5, nil, 6);
                sound(u129, Sounds.Cannon, 0.55, i * 0.06 + 0.9, v144);
                u129.shakeUntil = os.clock() + 0.25;
            end;
        end;

        local v146;

        if u129.fired[v143] or Intro.Salute + i * Intro.Gap > u130 then
            v146 = i;
        else
            u129.fired[v143] = true;
            v145();
            v146 = i;
        end;
    end;

    local function _() -- Line: 613
        -- upvalues: pop (ref), u129 (copy)
        pop(u129.subtitle, u129.show.run == "FinalRun" and "FINAL RUN  ·  ONE AGAINST ALL" or "HERO RUN  ·  TO THE TREASURE");
    end;

    if not u129.fired.point and Intro.Point <= u130 then
        u129.fired.point = true;
        pop(u129.subtitle, u129.show.run == "FinalRun" and "FINAL RUN  ·  ONE AGAINST ALL" or "HERO RUN  ·  TO THE TREASURE");
    end;

    if Intro.Back < u130 and u129.fog then
        u129.fog.Enabled = false;
    end;

    local Neutral = PirateShots.Poses.Neutral;
    local Cross = PirateShots.Poses.Cross;
    local Point = PirateShots.Poses.Point;
    local v147;

    if u130 < Intro.Point then
        v147 = PirateShots.blend(Neutral, Cross, smooth((u130 - Intro.Cross) / 0.28));
    else
        local v148 = PirateShots.blend(Cross, Point, smooth((u130 - Intro.Point) / 0.25));
        v147 = PirateShots.blend(v148, Neutral, smooth((u130 - Intro.Back - 0.6) / 0.5));
    end;

    PirateShots.pose(u129.rig, v147);
    u129.cloneRoot.CFrame = CFrame.lookAt(origin, origin + forward);

    if u130 < Intro.Cross + 0.25 then
        local v149 = smooth(u130 / (Intro.Cross + 0.25));

        return CFrame.lookAt((origin + forward * 17 + Vector3.new(0, 1.4, 0) + right * 3.2):Lerp(origin + forward * 11.5 + Vector3.new(0, 2.1, 0) + right * 2.2, v149), origin + Vector3.new(0, 4.5, 0) - forward * 10), 60;
    end;

    if u130 >= Intro.Point then
        local v150 = smooth((u130 - Intro.Point) / 0.6);

        return CFrame.lookAt(origin - forward * (7 + v150) + Vector3.new(0, 3.3, 0) + right * 2.3, origin + forward * 30 + Vector3.new(0, 1.5, 0)), 58;
    end;

    local v151 = smooth((u130 - Intro.Cross - 0.25) / (Intro.Point - Intro.Cross - 0.25));
    local math_rad_ret = math.rad(14 + 34 * v151);
    local v152 = forward * math.cos(math_rad_ret) + right * math.sin(math_rad_ret);

    return CFrame.lookAt(origin + v152 * (13 + 2 * v151) + Vector3.new(0, 1, 0) * (2 + 1.5 * v151), origin + Vector3.new(0, 5, 0) - forward * 8), 62 + 3 * v151;
end;

local function finaleSetup(p153) -- Line: 648
    -- upvalues: RaycastParams_new_ret (copy), PirateShow (copy), Finale (copy), Gold (copy), Color3_fromRGB_ret (copy), headOnly (copy)
    local forward = p153.forward;
    local right = p153.right;
    local origin = p153.origin;
    RaycastParams_new_ret.FilterDescendantsInstances = p153.floorIgnore;
    local v154 = workspace:Raycast(origin + Vector3.new(0, 6, 0), Vector3.new(-0, -40, -0), RaycastParams_new_ret);
    local v155;

    if v154 then
        v155 = v154.Position;
    else
        v155 = origin - Vector3.new(0, 3, 0);
    end;

    p153.xFloor = v155;
    p153.standY = origin.Y;
    local v156 = PirateShow and PirateShow:FindFirstChild("Cannon");
    local v157;

    if v156 then
        v157 = v156:Clone();
        v157.Parent = p153.stage;
    else
        v157 = nil;
    end;

    if v157 then
        local v158 = origin - forward * Finale.Distance;
        RaycastParams_new_ret.FilterDescendantsInstances = p153.floorIgnore;
        local v159 = workspace:Raycast(v158 + Vector3.new(0, 6, 0), Vector3.new(-0, -40, -0), RaycastParams_new_ret);
        local v160;

        if v159 then
            v160 = v159.Position;
        else
            v160 = v158 - Vector3.new(0, 3, 0);
        end;

        p153.cannonRest = CFrame.lookAt(v160, v160 + forward);
        v157:PivotTo(p153.cannonRest);
        p153.cannon = v157;
        local Muzzle = v157.PrimaryPart:FindFirstChild("Muzzle");
        local Breech = v157.PrimaryPart:FindFirstChild("Breech");
        p153.muzzle = Muzzle and Muzzle.WorldPosition or v160 + forward * 6 + Vector3.new(0, 3, 0);
        p153.breech = Breech and Breech.WorldPosition or v160 - forward * 4 + Vector3.new(0, 3, 0);
        local breech = p153.breech;
        local Part = Instance.new("Part");
        Part.Anchored = true;
        Part.CanCollide = false;
        Part.CanQuery = false;
        Part.CanTouch = false;
        Part.CastShadow = false;
        Part.Transparency = 1;
        Part.Size = Vector3.new(1, 1, 1);
        Part.CFrame = CFrame.new(breech);
        Part.Parent = p153.stage;
        local ParticleEmitter = Instance.new("ParticleEmitter");
        ParticleEmitter.Texture = "rbxasset://textures/particles/sparkles_main.dds";
        ParticleEmitter.Color = ColorSequence.new(Color3.fromRGB(255, 210, 90), Color3.fromRGB(255, 120, 40));
        ParticleEmitter.LightEmission = 1;
        ParticleEmitter.Size = NumberSequence.new(0.35, 0.05);
        ParticleEmitter.Lifetime = NumberRange.new(0.2, 0.45);
        ParticleEmitter.Speed = NumberRange.new(4, 8);
        ParticleEmitter.SpreadAngle = Vector2.new(50, 50);
        ParticleEmitter.Acceleration = Vector3.new(0, -20, 0);
        ParticleEmitter.Rate = 70;
        ParticleEmitter.EmissionDirection = Enum.NormalId.Top;
        ParticleEmitter.Parent = Part;
        local PointLight = Instance.new("PointLight");
        PointLight.Color = Color3.fromRGB(255, 170, 70);
        PointLight.Brightness = 3;
        PointLight.Range = 8;
        PointLight.Parent = Part;
        p153.fuse = Part;
    end;

    local v161 = PirateShow and PirateShow:FindFirstChild("Chest");
    local v162;

    if v161 then
        v162 = v161:Clone();
        v162.Parent = p153.stage;
    else
        v162 = nil;
    end;

    if v162 then
        local v163 = origin + forward * 3.8;
        RaycastParams_new_ret.FilterDescendantsInstances = p153.floorIgnore;
        local v164 = workspace:Raycast(v163 + Vector3.new(0, 6, 0), Vector3.new(-0, -40, -0), RaycastParams_new_ret);
        local v165;

        if v164 then
            v165 = v164.Position;
        else
            v165 = v163 - Vector3.new(0, 3, 0);
        end;

        v162:PivotTo(CFrame.lookAt(v165, v165 - forward));
        p153.chest = v162;
        local Glow = v162.PrimaryPart:FindFirstChild("Glow");
        local PointLight = Instance.new("PointLight");
        PointLight.Color = Gold;
        PointLight.Brightness = 0;
        PointLight.Range = 14;
        PointLight.Parent = Glow or v162.PrimaryPart;
        p153.chestLight = PointLight;
        p153.chestGlow = Glow;
    end;

    local v166 = PirateShow and PirateShow:FindFirstChild("Flag");
    local v167;

    if v166 then
        v167 = v166:Clone();
        v167.Parent = p153.stage;
    else
        v167 = nil;
    end;

    if v167 then
        local v168 = origin + forward * 3 + right * 4.2;
        RaycastParams_new_ret.FilterDescendantsInstances = p153.floorIgnore;
        local v169 = workspace:Raycast(v168 + Vector3.new(0, 6, 0), Vector3.new(-0, -40, -0), RaycastParams_new_ret);
        local v170;

        if v169 then
            v170 = v169.Position;
        else
            v170 = v168 - Vector3.new(0, 3, 0);
        end;

        v167:PivotTo(CFrame.lookAt(v170, v170 + forward));
    end;

    for _, v in { 45, -45 } do
        local Part = Instance.new("Part");
        Part.Name = "X";
        Part.Anchored = true;
        Part.CanCollide = false;
        Part.CanQuery = false;
        Part.CanTouch = false;
        Part.CastShadow = false;
        Part.Material = Enum.Material.SmoothPlastic;
        Part.Color = Color3_fromRGB_ret;
        Part.Size = Vector3.new(0.9, 0.06, 6);
        Part.CFrame = CFrame.lookAt(p153.xFloor, p153.xFloor + forward) * CFrame.Angles(0, math.rad(v), 0) + Vector3.new(0, 0.04, 0);
        Part.Parent = p153.stage;
    end;

    p153.land = Vector3.new(origin.X, p153.xFloor.Y + 1.6, origin.Z) - forward * Finale.RollDistance;
    headOnly(p153.clone, true);
end;

local function finaleStep(u171, u172) -- Line: 718
    -- upvalues: PirateShots (copy), Finale (copy), pop (copy), sound (copy), Sounds (copy), headOnly (copy), fireball (copy), smoke (copy), flash (copy), Color3_fromRGB_ret2 (copy), sparkle (copy), Gold (copy), fadeOut (copy), u16 (ref), smooth (copy)
    local forward = u171.forward;
    local right = u171.right;
    local origin = u171.origin;
    local v173 = PirateShots.landAt();
    local v174 = PirateShots.poseAt();
    local v175 = v173 + Finale.Roll;

    local function _(p176, p177, p178) -- Line: 723
        -- upvalues: u171 (copy), u172 (copy)
        if not u171.fired[p176] and p177 <= u172 then
            u171.fired[p176] = true;
            p178();
        end;
    end;

    local function _() -- Line: 729
        -- upvalues: pop (ref), u171 (copy), sound (ref), Sounds (ref)
        pop(u171.eyebrow, "PLUNDER RUN");

        if u171.breech then
            sound(u171, Sounds.Fuse, 0.7, 1, u171.breech);
        end;
    end;

    if not u171.fired.eyebrow and u172 >= 0.1 then
        u171.fired.eyebrow = true;
        pop(u171.eyebrow, "PLUNDER RUN");

        if u171.breech then
            sound(u171, Sounds.Fuse, 0.7, 1, u171.breech);
        end;
    end;

    local function v179() -- Line: 735
        -- upvalues: headOnly (ref), u171 (copy), fireball (ref), forward (copy), smoke (ref), sound (ref), Sounds (ref), flash (ref), pop (ref)
        headOnly(u171.clone, false);

        if u171.fuse then
            u171.fuse:Destroy();
            u171.fuse = nil;
        end;

        if u171.muzzle then
            fireball(u171, u171.muzzle + forward * 1.5, 9);
            smoke(u171, u171.muzzle + forward * 1.5, 26, 6, nil, 8);
            sound(u171, Sounds.Cannon, 0.9, 1, u171.muzzle);
        end;

        flash(u171, 0.45, Color3.fromRGB(255, 230, 190));
        pop(u171.title, "FIRE IN THE HOLE!");
        u171.shakeUntil = os.clock() + 0.45;
    end;

    if not u171.fired.fire and Finale.Fire <= u172 then
        u171.fired.fire = true;
        v179();
    end;

    local function v180() -- Line: 750
        -- upvalues: sound (ref), u171 (copy), Sounds (ref), smoke (ref), Color3_fromRGB_ret2 (ref), sparkle (ref), Gold (ref), fadeOut (ref)
        sound(u171, Sounds.Thud, 0.8, 1, u171.land);
        smoke(u171, u171.land - Vector3.new(0, 1.4, 0), 14, 3, Color3_fromRGB_ret2, 5);
        sparkle(u171, u171.land - Vector3.new(0, 1.2, 0), Gold, 18, 14);
        u171.shakeUntil = os.clock() + 0.2;
        fadeOut(u171.title);
    end;

    if not u171.fired.land and v173 <= u172 then
        u171.fired.land = true;
        v180();
    end;

    local function v182() -- Line: 757
        -- upvalues: u171 (copy), origin (copy), forward (copy), sparkle (ref), Gold (ref), Sounds (ref), u16 (ref), sound (ref), flash (ref), pop (ref)
        local u181 = u171.chestGlow and u171.chestGlow.WorldPosition or origin + forward * 3.8 + Vector3.new(0, 1, 0);
        sparkle(u171, u181, Gold, 70, 30);
        sparkle(u171, u181, Color3.fromRGB(255, 240, 170), 30, 22);

        for i, v in Sounds.Coins do
            task.delay((i - 1) * 0.12, function() -- Line: 762
                -- upvalues: u16 (ref), u171 (ref), sound (ref), v (copy), u181 (copy)
                if u16 == u171 then
                    sound(u171, v, 0.7, 1, u181);
                end;
            end);
        end;

        flash(u171, 0.3, Gold);
        pop(u171.title, "TREASURE!");
        u171.shakeUntil = os.clock() + 0.25;
    end;

    if not u171.fired.treasure and v174 - 0.05 <= u172 then
        u171.fired.treasure = true;
        v182();
    end;

    local function _() -- Line: 772
        -- upvalues: pop (ref), u171 (copy)
        pop(u171.subtitle, u171.name .. " CLAIMS THE TREASURE");
    end;

    if not u171.fired.name and v174 + 0.45 <= u172 then
        u171.fired.name = true;
        pop(u171.subtitle, u171.name .. " CLAIMS THE TREASURE");
    end;

    if u171.chestLight then
        u171.chestLight.Brightness = 4 * smooth((u172 - v174 + 0.1) / 0.3) * (1 - smooth((u172 - Finale.Back) / 1));
    end;

    if u171.cannon then
        local v183 = u172 - Finale.Fire;
        local v184 = v183 <= 0 and 0 or math.exp(-v183 * 6) * 1.4 * math.min(1, v183 / 0.04);
        local v185 = (v183 >= 0 or Finale.Fire - 0.6 >= u172) and 0 or (math.random() - 0.5) * 0.06;
        u171.cannon:PivotTo(u171.cannonRest * CFrame.new(v185, 0, v184));
    end;

    local _ = PirateShots.Poses.Neutral;
    local v186 = nil;
    local v187, v188;

    if u172 < Finale.Fire then
        local v189 = u171.muzzle or origin - forward * (Finale.Distance - 6);
        local v190 = 0.15 + 0.55 * smooth((u172 - 0.4) / 0.4) + math.sin(u172 * 9) * 0.06;
        v187 = v189 - Vector3.new(0, 1.55, 0) + forward * v190;
        v188 = PirateShots.Poses.Neutral;
    elseif u172 < v173 then
        local v191 = (u172 - Finale.Fire) / Finale.Flight;
        v187 = PirateShots.arc(u171.muzzle or origin - forward * (Finale.Distance - 6), u171.land, Finale.Peak, v191);
        v188 = PirateShots.Poses.Tuck;
        v186 = CFrame.Angles(-6.283185307179586 * Finale.Spins * v191, 0, 0);
    elseif u172 < v175 then
        local v192 = (u172 - v173) / Finale.Roll;
        local v193 = 1 - (1 - v192) * (1 - v192);
        v187 = u171.land:Lerp(Vector3.new(origin.X, u171.land.Y, origin.Z), v193);
        v188 = PirateShots.Poses.Tuck;
        v186 = CFrame.Angles(-6.283185307179586 * Finale.RollSpins * v193, 0, 0);
    elseif u172 < v174 then
        local v194 = smooth((u172 - v175) / Finale.Settle);
        v187 = Vector3.new(origin.X, u171.land.Y + (u171.standY - u171.land.Y) * v194, origin.Z);
        v188 = PirateShots.blend(PirateShots.Poses.Tuck, PirateShots.Poses.Hero, v194);
    else
        local v195 = smooth((u172 - Finale.Rise) / Finale.Stand);
        v188 = PirateShots.blend(PirateShots.Poses.Hero, PirateShots.Poses.Neutral, v195);
        v187 = origin;
    end;

    PirateShots.pose(u171.rig, v188, v186);
    u171.cloneRoot.CFrame = CFrame.lookAt(v187, v187 + forward);
    u171.subjectAt = v187;

    if u172 < Finale.Fire then
        local v196 = smooth(u172 / Finale.Fire);
        local v197 = u171.cannonRest and u171.cannonRest.Position or origin - forward * Finale.Distance;

        return CFrame.lookAt(v197 + right * (13 - 2 * v196) + Vector3.new(0, 1, 0) * (3.4 - 0.4 * v196) + forward * (1 + 2 * v196), (u171.muzzle or v197 + forward * 6) - forward * 3), 50 - 4 * v196;
    end;

    if u172 < v173 + 0.15 then
        if u171.track then
            v187 = u171.track:Lerp(v187, 0.35);
        end;

        u171.track = v187;

        return CFrame.lookAt(u171.track + right * 17 + Vector3.new(0, 4, 0) - forward * 5, u171.track + forward * 2), 60 - math.exp(-(u172 - Finale.Fire) * 8) * 8;
    end;

    local v198 = smooth((u172 - v173 - 0.15) / (Finale.Back - v173));
    local math_rad_ret = math.rad(18 + 26 * v198);
    local v199 = forward * math.cos(math_rad_ret) + right * math.sin(math_rad_ret);
    local v200 = origin + Vector3.new(0, 1, 0) * (0.4 + 0.8 * smooth((u172 - Finale.Rise) / Finale.Stand));

    return CFrame.lookAt(origin + v199 * (9.5 - 1.5 * v198) + Vector3.new(0, 1, 0) * (1.3 + 0.5 * v198), v200), 54;
end;

local function stop() -- Line: 837
    -- upvalues: u16 (ref), RunService (copy), PirateShots (copy), LocalPlayer (copy), TweenService (copy), fadeOut (copy), Debris (copy)
    local v201 = u16;

    if not v201 then
        return;
    end;

    u16 = nil;
    RunService:UnbindFromRenderStep("CoHPirateShow");

    for _, v in v201.connections do
        v:Disconnect();
    end;

    if v201.rig then
        PirateShots.release(v201.rig);
    end;

    if v201.hide then
        v201.hide:restore();
        v201.hide = nil;
    end;

    v201.stage:Destroy();
    local workspace_CurrentCamera = workspace.CurrentCamera;

    if workspace_CurrentCamera then
        workspace_CurrentCamera.FieldOfView = v201.fov;

        if v201.spectating and LocalPlayer:GetAttribute("Spectating") then
            workspace_CurrentCamera.CameraType = v201.cameraType;
            workspace_CurrentCamera.CameraSubject = v201.subject;
        else
            workspace_CurrentCamera.CameraType = v201.cameraType == Enum.CameraType.Scriptable and Enum.CameraType.Custom or v201.cameraType;
            local v202 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid");
            workspace_CurrentCamera.CameraSubject = v202 or v201.subject;
        end;
    end;

    if v201.visibility then
        v201.visibility:destroy();
    end;

    for _, v in v201.effects do
        v:Destroy();
    end;

    v201.fade.BackgroundTransparency = 1;

    if v201.bars > 0.01 then
        local TweenInfo_new_ret = TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.In);
        TweenService:Create(v201.top, TweenInfo_new_ret, {
            Position = UDim2.fromScale(0.5, 0)
        }):Play();
        TweenService:Create(v201.bottom, TweenInfo_new_ret, {
            Position = UDim2.fromScale(0.5, 1)
        }):Play();
        fadeOut(v201.eyebrow);
        fadeOut(v201.title);
        fadeOut(v201.subtitle);
        Debris:AddItem(v201.gui, 0.45);
    else
        v201.gui:Destroy();
    end;

    LocalPlayer:SetAttribute("PirateCutsceneActive", nil);
end;

local function introKeep(p203) -- Line: 888
    -- upvalues: Players (copy)
    local v204 = p203:IsA("Model") and Players:GetPlayerFromCharacter(p203);

    return (v204 or p203):GetAttribute("GameRole") == "Catcher";
end;

local function start(u205) -- Line: 893
    -- upvalues: stop (copy), LocalPlayer (copy), u15 (copy), Session (copy), HttpService (copy), Players (copy), u16 (ref), copyRunner (copy), PirateShots (copy), Presentation (copy), bar (copy), cover (copy), Color3_new_ret (copy), Intro (copy), Finale (copy), cameraZoom (copy), textLabel (copy), Gold (copy), TweenService (copy), LocalHide (copy), introKeep (copy), introSetup (copy), startSong (copy), finaleSetup (copy), CreatorVisibility (copy), Lighting (copy), RunService (copy), introStep (copy), finaleStep (copy), smoother (copy), orbit (copy), home (copy), glide (copy), unblocked (copy), fadeOut (copy)
    stop();

    if not ((LocalPlayer:GetAttribute("InMatch") == true or LocalPlayer:GetAttribute("Spectating") == true) and (LocalPlayer:GetAttribute("ScreenPresentationActive") ~= true and u15[u205.kind])) then
        return;
    end;

    local v206 = os.clock() + 1;

    while LocalPlayer:GetAttribute("ChoiceSpotlightActive") == true and os.clock() < v206 do
        task.wait(0.05);
    end;

    local Attribute = Session:GetAttribute("PirateShow");
    local v207;

    if type(Attribute) == "string" and Attribute ~= "" then
        local v208;
        v208, v207 = pcall(HttpService.JSONDecode, HttpService, Attribute);

        if not (v208 and (type(v207) == "table" and v207)) then
            v207 = nil;
        end;
    else
        v207 = nil;
    end;

    local PlayerByUserId = Players:GetPlayerByUserId(u205.userId);
    local u209;

    if PlayerByUserId then
        u209 = PlayerByUserId.Character;
    else
        u209 = PlayerByUserId;
    end;

    local v210;

    if u209 then
        v210 = u209:FindFirstChild("HumanoidRootPart");
    else
        v210 = u209;
    end;

    local workspace_CurrentCamera = workspace.CurrentCamera;
    local ServerTimeNow = workspace:GetServerTimeNow();

    if u16 or not (v207 and (v207.version == u205.version and (v210 and (workspace_CurrentCamera and (type(u205.startedAt) == "number" and (type(u205.endsAt) == "number" and u205.endsAt - 1.6 >= ServerTimeNow)))))) then
        return;
    end;

    local u211 = u205.kind == "Intro";
    local v212 = PlayerByUserId == LocalPlayer;
    local v213;

    if type(u205.forward) == "table" then
        local v214 = tonumber(u205.forward[1]) or 0;
        local v215 = tonumber(u205.forward[2]) or 0;
        v213 = Vector3.new(v214, 0, v215);
    else
        v213 = false;
    end;

    local v216;

    if v213 and v213.Magnitude > 0.5 then
        v216 = v213.Unit;
    else
        v216 = (v210.CFrame.LookVector * Vector3.new(1, 0, 1)).Unit;
    end;

    local v217;

    if type(u205.at) == "table" then
        local v218 = tonumber(u205.at[1]) or 0;
        local v219 = tonumber(u205.at[2]) or 0;
        local v220 = tonumber(u205.at[3]) or 0;
        v217 = Vector3.new(v218, v219, v220);
    else
        v217 = false;
    end;

    if not v217 or (v217 - v210.Position).Magnitude >= 12 then
        v217 = v210.Position;
    end;

    local Folder2 = Instance.new("Folder");
    Folder2.Name = "PirateShowStage";
    Folder2.Parent = workspace;
    local v221, v222 = copyRunner(u209);

    if not v221 then
        Folder2:Destroy();

        return;
    end;

    v221.Name = "PirateShowRunner";
    v221.Parent = Folder2;
    local v223 = PirateShots.rig(v221);

    if not v223 then
        Folder2:Destroy();

        return;
    end;

    local LookVector = workspace_CurrentCamera.CFrame.LookVector;

    if v212 and u211 then
        local math_clamp_ret = math.clamp(LookVector.Y, -1, 1);
        local math_asin_ret = math.asin(math_clamp_ret);
        local math_clamp_ret2 = math.clamp(math_asin_ret, -0.6981317007977318, -0.10471975511965978);
        LookVector = v216 * math.cos(math_clamp_ret2) + Vector3.new(0, 1, 0) * math.sin(math_clamp_ret2);
    end;

    local v224 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid");
    local PirateShow2 = require(Presentation:WaitForChild("CutsceneScreen")).new("PirateShow", 1001);
    PirateShow2:SetAttribute("CreatorCaptureExempt", true);
    PirateShow2:SetAttribute("SelfManagedText", true);
    local math_max_ret = math.max(0, ServerTimeNow - u205.startedAt);
    local v225 = u205.endsAt - u205.startedAt;
    local u226 = {
        version = u205.version,
        show = u205,
        gui = PirateShow2,
        stage = Folder2,
        clone = v221,
        cloneRoot = v222,
        rig = v223,
        character = u209,
        name = string.upper(PlayerByUserId.DisplayName),
        top = bar(PirateShow2, "Top", true),
        bottom = bar(PirateShow2, "Bottom", false),
        flash = cover(PirateShow2, "Flash", Color3_new_ret, 1),
        fade = cover(PirateShow2, "Fade", Color3.new(0, 0, 0), v212 and 1 or 0),
        bars = 0,
        weight = -1,
        origin = v217,
        forward = v216,
        right = v216:Cross(Vector3.new(0, 1, 0)).Unit,
        duration = v225
    };
    local v227;

    if u211 then
        v227 = Intro.Back;
    else
        v227 = Finale.Back;
    end;

    u226.back = v227;
    u226.homeAt = v225 - 0.2;
    u226.glide = v212;
    u226.introStart = math_max_ret;
    u226.introEnd = math_max_ret + 0.7;
    u226.startCF = workspace_CurrentCamera.CFrame;
    u226.cameraType = workspace_CurrentCamera.CameraType;
    u226.subject = workspace_CurrentCamera.CameraSubject;
    u226.homeSubject = v224 or workspace_CurrentCamera.CameraSubject;
    local v228;

    if LocalPlayer:GetAttribute("Spectating") == true then
        v228 = LocalPlayer:GetAttribute("InMatch") ~= true;
    else
        v228 = false;
    end;

    u226.spectating = v228;
    u226.homeLook = LookVector;
    u226.zoom = cameraZoom(workspace_CurrentCamera);
    u226.ignore = { LocalPlayer.Character, Folder2 };
    u226.occluders = { LocalPlayer.Character, u209, Folder2 };
    u226.floorIgnore = { Folder2, u209, LocalPlayer.Character };
    u226.fov = workspace_CurrentCamera.FieldOfView;
    u226.effects = {};
    u226.connections = {};
    u226.fired = {};
    u226.shakeUntil = 0;

    for _, v in Players:GetPlayers() do
        if v.Character then
            table.insert(u226.floorIgnore, v.Character);
        end;
    end;

    u226.eyebrow = textLabel(PirateShow2, "Eyebrow", 0.67, 0.045, Gold, 30);
    u226.title = textLabel(PirateShow2, "Title", 0.75, 0.1, Color3_new_ret, 84);
    u226.subtitle = textLabel(PirateShow2, "Subtitle", 0.83, 0.04, Color3_new_ret, 26);
    PirateShow2.Parent = LocalPlayer:WaitForChild("PlayerGui");

    if not v212 then
        TweenService:Create(u226.fade, TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            BackgroundTransparency = 1
        }):Play();
    end;

    u226.hide = LocalHide.new(not u211 and function(p229) -- Line: 1010
        -- upvalues: u209 (copy)
        return p229 ~= u209;
    end or introKeep);
    u226.hide:sweep();
    u226.hide:model(u209);
    u226.sweptAt = os.clock();
    task.delay(math.max(0, u205.endsAt - ServerTimeNow) + 2, function() -- Line: 1016
        -- upvalues: u226 (copy)
        if u226.hide then
            u226.hide:restore();
            u226.hide = nil;
        end;
    end);

    if u211 then
        introSetup(u226);
        startSong(PlayerByUserId);
    else
        finaleSetup(u226);
    end;

    u16 = u226;
    LocalPlayer:SetAttribute("PirateCutsceneActive", true);
    workspace_CurrentCamera.CameraType = Enum.CameraType.Scriptable;

    if LocalPlayer:GetAttribute("CreatorUIHidden") ~= true then
        u226.visibility = CreatorVisibility.new(LocalPlayer);
        u226.visibility:setHidden(true);
    end;

    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.Name = "PirateShowGrade";
    ColorCorrectionEffect.Parent = Lighting;
    local DepthOfFieldEffect = Instance.new("DepthOfFieldEffect");
    DepthOfFieldEffect.Name = "PirateShowFocus";
    DepthOfFieldEffect.FarIntensity = 0;
    DepthOfFieldEffect.NearIntensity = 0;
    DepthOfFieldEffect.InFocusRadius = 10;
    DepthOfFieldEffect.FocusDistance = 12;
    DepthOfFieldEffect.Parent = Lighting;
    u226.effects = { ColorCorrectionEffect, DepthOfFieldEffect };
    local u230;

    if u211 then
        u230 = Color3.fromRGB(222, 246, 236);
    else
        u230 = Color3.fromRGB(255, 244, 224);
    end;

    for _, v in { "InMatch", "Spectating" } do
        local connections = u226.connections;
        local AttributeChangedSignal4 = LocalPlayer:GetAttributeChangedSignal(v);
        table.insert(connections, AttributeChangedSignal4:Connect(function() -- Line: 1051
            -- upvalues: LocalPlayer (ref), stop (ref)
            if LocalPlayer:GetAttribute("InMatch") ~= true and LocalPlayer:GetAttribute("Spectating") ~= true then
                stop();
            end;
        end));
    end;

    RunService:BindToRenderStep("CoHPirateShow", Enum.RenderPriority.Camera.Value + 10, function(p231) -- Line: 1058
        -- upvalues: u16 (ref), u226 (copy), workspace_CurrentCamera (copy), u205 (copy), stop (ref), u209 (copy), u211 (copy), introStep (ref), finaleStep (ref), smoother (ref), orbit (ref), home (ref), glide (ref), unblocked (ref), fadeOut (ref), ColorCorrectionEffect (copy), Color3_new_ret (ref), u230 (copy), DepthOfFieldEffect (copy)
        if u16 ~= u226 then
            return;
        end;

        local CFrame2 = workspace_CurrentCamera.CFrame;
        local Position = workspace_CurrentCamera.Focus.Position;
        local v232 = workspace:GetServerTimeNow() - u205.startedAt;

        if u226.duration <= v232 then
            stop();

            return;
        end;

        if u226.hide then
            if os.clock() - u226.sweptAt > 0.3 then
                u226.sweptAt = os.clock();
                u226.hide:sweep();
            end;

            if u209.Parent then
                u226.hide:model(u209);
            end;
        end;

        local v233, v234;

        if u211 then
            v233, v234 = introStep(u226, v232);
        else
            v233, v234 = finaleStep(u226, v232);
        end;

        local v235 = u226.subjectAt or u226.origin;
        local v236 = v235 + Vector3.new(0, 1.5, 0);
        local v237;

        if u226.glide and v232 < u226.introEnd then
            v237 = smoother((v232 - u226.introStart) / (u226.introEnd - u226.introStart));
            v233 = orbit(u226.startCF, v233, v237, v236);
            v234 = u226.fov + (v234 - u226.fov) * v237;
        else
            v237 = 1;
        end;

        if u226.back < v232 then
            if not u226.spectating then
                CFrame2, Position = home(u226);
            end;

            if CFrame2 then
                local v238 = smoother((v232 - u226.back) / (u226.homeAt - u226.back));
                v233 = (Position - v236).Magnitude < 12 and orbit(v233, CFrame2, v238, v236) or glide(v233, CFrame2, v238, v236, Position);
                v234 = v234 + (u226.fov - v234) * v238;
                v237 = 1 - v238;
                v236 = v236:Lerp(Position, v238);
            end;
        end;

        if u226.homeAt <= v232 then
            u226.pull = nil;
        else
            v233 = unblocked(u226, v233, v236, p231, u226.back < v232);
        end;

        if u226.shakeUntil > os.clock() then
            local v239 = (u226.shakeUntil - os.clock()) * 2.6;
            local CFrame_Angles = CFrame.Angles;
            local v240 = (math.random() - 0.5) * v239;
            local math_rad_ret = math.rad(v240);
            local v241 = (math.random() - 0.5) * v239;
            v233 = v233 * CFrame_Angles(math_rad_ret, math.rad(v241), 0);
        end;

        workspace_CurrentCamera.CFrame = v233;
        workspace_CurrentCamera.FieldOfView = v234;
        local v242 = smoother(v232 / 0.75) * (1 - smoother((v232 - u226.duration + 0.75) / 0.7));

        if v242 ~= u226.bars then
            local v243 = u226;
            v243.bars = v242;
            v243.top.Position = UDim2.fromScale(0.5, 0.11 * v242);
            v243.bottom.Position = UDim2.fromScale(0.5, 1 - 0.11 * v242);
        end;

        if u226.back + 0.2 < v232 and not u226.fired.titlesOut then
            u226.fired.titlesOut = true;
            fadeOut(u226.eyebrow);
            fadeOut(u226.title);
            fadeOut(u226.subtitle);
        end;

        if v237 ~= u226.weight then
            u226.weight = v237;
            ColorCorrectionEffect.Saturation = v237 * 0.12;
            ColorCorrectionEffect.Contrast = v237 * 0.1;
            ColorCorrectionEffect.TintColor = Color3_new_ret:Lerp(u230, v237);
            DepthOfFieldEffect.FarIntensity = v237 * 0.3;
        end;

        DepthOfFieldEffect.FocusDistance = (v233.Position - v235).Magnitude;
    end);
end;

local function refreshShow() -- Line: 1142
    -- upvalues: Session (copy), HttpService (copy), stop (copy), u16 (ref), start (copy)
    local Attribute = Session:GetAttribute("PirateShow");
    local v244;

    if type(Attribute) == "string" and Attribute ~= "" then
        local v245;
        v245, v244 = pcall(HttpService.JSONDecode, HttpService, Attribute);

        if not (v245 and (type(v244) == "table" and v244)) then
            v244 = nil;
        end;
    else
        v244 = nil;
    end;

    if not v244 then
        stop();

        return;
    end;

    if u16 and u16.version == v244.version then
        return;
    end;

    task.spawn(start, v244);
end;

local AttributeChangedSignal4 = Session:GetAttributeChangedSignal("PirateShow");
table.insert(u1, AttributeChangedSignal4:Connect(refreshShow));
local Attribute = Session:GetAttribute("PirateShow");
local v246;

if type(Attribute) == "string" and Attribute ~= "" then
    local v247;
    v247, v246 = pcall(HttpService.JSONDecode, HttpService, Attribute);

    if not (v247 and (type(v246) == "table" and v246)) then
        v246 = nil;
    end;
else
    v246 = nil;
end;

if v246 then
    if not u16 or u16.version ~= v246.version then
        task.spawn(start, v246);
    end;
else
    stop();
end;

script.Destroying:Connect(function() -- Line: 1155
    -- upvalues: u1 (copy), stop (copy), LocalPlayer (copy), u5 (ref), Attachment (copy), Folder (copy)
    for _, v in u1 do
        v:Disconnect();
    end;

    stop();
    LocalPlayer:SetAttribute("MusicPaused", nil);

    if u5 then
        u5:Disconnect();
    end;

    Attachment:Destroy();
    Folder:Destroy();
end);