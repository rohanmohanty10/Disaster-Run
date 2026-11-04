 

 

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local UserInputService = game:GetService("UserInputService");
local GuiService = game:GetService("GuiService");
local ChickenOrHero = game:GetService("ReplicatedStorage"):WaitForChild("ChickenOrHero");
local Session = ChickenOrHero:WaitForChild("Game"):WaitForChild("Session");
local FallenKingBossConfig = require(ChickenOrHero.Game:WaitForChild("FallenKingBossConfig"));
local LocalPlayer = Players.LocalPlayer;
local Color3_fromRGB_ret = Color3.fromRGB(150, 70, 230);
local Font_new_ret = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.Bold);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = 1;
local u7 = 1;
local u8 = nil;

local function showing(p9, p10) -- Line: 28
    while p9 and p9 ~= p10 do
        if p9:IsA("GuiObject") and not p9.Visible then
            return false;
        end;

        p9 = p9.Parent;
    end;

    return true;
end;

local function barTop() -- Line: 37
    -- upvalues: UserInputService (copy), LocalPlayer (copy), showing (copy), GuiService (copy)
    if not UserInputService.TouchEnabled then
        return 52;
    end;

    local Notifications = LocalPlayer.PlayerGui:FindFirstChild("Notifications");
    local v11;

    if Notifications then
        v11 = Notifications:FindFirstChild("MainFrame");
    else
        v11 = Notifications;
    end;

    if v11 then
        v11 = v11:FindFirstChild("NotificationsF");
    end;

    if v11 then
        v11 = v11:FindFirstChild("Frame");
    end;

    if not (Notifications and (Notifications:IsA("ScreenGui") and (Notifications.Enabled and (v11 and showing(v11, Notifications))))) then
        return 52;
    end;

    local v12 = nil;

    for _, descendant in v11:GetDescendants() do
        if descendant:IsA("TextLabel") and (descendant.Text ~= "" and (descendant.TextTransparency < 1 and showing(descendant, v11))) then
            local Y = descendant.AbsolutePosition.Y;
            local Y2 = descendant.AbsoluteSize.Y;
            local Y3 = descendant.TextBounds.Y;
            local v13;

            if descendant.TextYAlignment == Enum.TextYAlignment.Top then
                v13 = Y + Y3;
            elseif descendant.TextYAlignment == Enum.TextYAlignment.Bottom then
                v13 = Y + Y2;
            else
                v13 = Y + (Y2 + Y3) / 2;
            end;

            v12 = math.max(v12 or v13, v13);
        end;
    end;

    if not v12 then
        return 52;
    end;

    local Y = GuiService:GetGuiInset().Y;
    local math_floor_ret = math.floor(v12 + (Notifications.IgnoreGuiInset and 0 or Y) - Y + 6);

    return math.clamp(math_floor_ret, 0, 52);
end;

local function text(p14, p15, p16, p17, p18, p19) -- Line: 68
    -- upvalues: Font_new_ret (copy)
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Name = p15;
    TextLabel.BackgroundTransparency = 1;
    TextLabel.Size = p16;
    TextLabel.Position = p17;
    TextLabel.FontFace = Font_new_ret;
    TextLabel.TextColor3 = p19 or Color3.new(1, 1, 1);
    TextLabel.TextScaled = true;
    TextLabel.TextStrokeTransparency = 0.6;
    local UITextSizeConstraint = Instance.new("UITextSizeConstraint");
    UITextSizeConstraint.MaxTextSize = p18;
    UITextSizeConstraint.MinTextSize = 10;
    UITextSizeConstraint.Parent = TextLabel;
    TextLabel.Parent = p14;

    return TextLabel;
end;

local function build() -- Line: 86
    -- upvalues: u1 (ref), text (copy), u3 (ref), u2 (ref), Color3_fromRGB_ret (copy), FallenKingBossConfig (copy), u5 (ref), u4 (ref), LocalPlayer (copy)
    u1 = Instance.new("ScreenGui");
    u1.Name = "FallenKingBossBar";
    u1.ResetOnSpawn = false;
    u1.IgnoreGuiInset = false;
    u1.DisplayOrder = 20;
    local Frame = Instance.new("Frame");
    Frame.Name = "Bar";
    Frame.AnchorPoint = Vector2.new(0.5, 0);
    Frame.Position = UDim2.new(0.5, 0, 0, 52);
    Frame.Size = UDim2.new(0.42, 0, 0, 58);
    Frame.BackgroundTransparency = 1;
    Frame.Parent = u1;
    local UISizeConstraint = Instance.new("UISizeConstraint");
    UISizeConstraint.MaxSize = Vector2.new(620, 58);
    UISizeConstraint.MinSize = Vector2.new(280, 58);
    UISizeConstraint.Parent = Frame;
    text(Frame, "Title", UDim2.new(1, 0, 0, 20), UDim2.new(0, 0, 0, 0), 20, Color3.fromRGB(235, 210, 255)).Text = "THE FALLEN KING";
    local Frame2 = Instance.new("Frame");
    Frame2.Name = "Track";
    Frame2.Position = UDim2.new(0, 0, 0, 22);
    Frame2.Size = UDim2.new(1, 0, 0, 16);
    Frame2.BackgroundColor3 = Color3.fromRGB(22, 14, 30);
    Frame2.BorderSizePixel = 0;
    Frame2.Parent = Frame;
    local UICorner = Instance.new("UICorner");
    UICorner.CornerRadius = UDim.new(0, 6);
    UICorner.Parent = Frame2;
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Color = Color3.fromRGB(90, 50, 130);
    UIStroke.Thickness = 2;
    UIStroke.Parent = Frame2;
    u3 = Instance.new("Frame");
    u3.Name = "Trail";
    u3.Size = UDim2.fromScale(1, 1);
    u3.BackgroundColor3 = Color3.fromRGB(255, 225, 255);
    u3.BackgroundTransparency = 0.35;
    u3.BorderSizePixel = 0;
    u3.Parent = Frame2;
    UICorner:Clone().Parent = u3;
    u2 = Instance.new("Frame");
    u2.Name = "Fill";
    u2.Size = UDim2.fromScale(1, 1);
    u2.BackgroundColor3 = Color3_fromRGB_ret;
    u2.BorderSizePixel = 0;
    u2.Parent = Frame2;
    UICorner:Clone().Parent = u2;
    local UIGradient = Instance.new("UIGradient");
    UIGradient.Color = ColorSequence.new(Color3.fromRGB(200, 120, 255), Color3.fromRGB(110, 40, 190));
    UIGradient.Rotation = 90;
    UIGradient.Parent = u2;

    for _, v in FallenKingBossConfig.Phases do
        if v.Until > 0 then
            local Frame3 = Instance.new("Frame");
            Frame3.AnchorPoint = Vector2.new(0.5, 0);
            Frame3.Position = UDim2.fromScale(v.Until, 0);
            Frame3.Size = UDim2.new(0, 2, 1, 0);
            Frame3.BackgroundColor3 = Color3.new(1, 1, 1);
            Frame3.BackgroundTransparency = 0.3;
            Frame3.BorderSizePixel = 0;
            Frame3.ZIndex = 3;
            Frame3.Parent = Frame2;
        end;
    end;

    u5 = text(Frame2, "Percent", UDim2.fromScale(1, 1), UDim2.fromScale(0, 0), 14);
    u5.ZIndex = 4;
    u4 = text(Frame, "Phase", UDim2.new(1, 0, 0, 16), UDim2.new(0, 0, 0, 40), 16, Color3.fromRGB(200, 170, 230));
    u1.Parent = LocalPlayer:WaitForChild("PlayerGui");
end;

local function phaseText() -- Line: 159
    -- upvalues: Session (copy), FallenKingBossConfig (copy)
    local v20 = Session:GetAttribute("BossPhase") or 1;
    local v21 = FallenKingBossConfig.Phases[v20];

    return ("PHASE %d · %s"):format(v20, v21 and v21.Name or "");
end;

local function refresh() -- Line: 165
    -- upvalues: Session (copy), u1 (ref), build (copy), u8 (ref), u6 (ref), u7 (ref), u4 (ref), FallenKingBossConfig (copy), RunService (copy), u2 (ref), u3 (ref), u5 (ref)
    local v22 = Session:GetAttribute("BossActive") == true;

    if v22 and not u1 then
        build();
    end;

    if not u1 then
        return;
    end;

    u1.Enabled = true;
    local Bar = u1:FindFirstChild("Bar");

    if Bar then
        Bar.Visible = v22;
    end;

    if not v22 then
        if u8 then
            u8:Disconnect();
            u8 = nil;
        end;

        u6 = 1;
        u7 = 1;

        return;
    end;

    local v23 = Session:GetAttribute("BossPhase") or 1;
    local v24 = FallenKingBossConfig.Phases[v23];
    u4.Text = ("PHASE %d · %s"):format(v23, v24 and v24.Name or "");

    if not u8 then
        u8 = RunService.RenderStepped:Connect(function(p25) -- Line: 192
            -- upvalues: Session (ref), u6 (ref), u7 (ref), u2 (ref), u3 (ref), u5 (ref)
            local v26 = Session:GetAttribute("BossHealth") or 1;
            u6 = u6 + (v26 - u6) * (1 - math.exp(-10 * p25));

            if u7 < u6 then
                u7 = u6;
            else
                u7 = u7 + (u6 - u7) * (1 - math.exp(-2.5 * p25));
            end;

            u2.Size = UDim2.fromScale(u6, 1);
            u3.Size = UDim2.fromScale(u7, 1);
            u5.Text = math.ceil(v26 * 100) .. "%";
        end);
    end;
end;

local Color3_fromRGB_ret2 = Color3.fromRGB(120, 140, 125);
local u27 = nil;
local u28 = nil;
local u29 = nil;
local u30 = nil;

local function dropFog() -- Line: 211
    -- upvalues: u28 (ref), u27 (ref), u29 (ref)
    if u28 then
        u28:Disconnect();
        u28 = nil;
    end;

    if u27 then
        u27:Destroy();
        u27 = nil;
    end;

    u29 = nil;
end;

local function buildFog() -- Line: 222
    -- upvalues: u27 (ref), Color3_fromRGB_ret2 (copy), u28 (ref), RunService (copy), Session (copy), u29 (ref), LocalPlayer (copy), u30 (ref), FallenKingBossConfig (copy)
    u27 = Instance.new("Folder");
    u27.Name = "FallenKingFog";
    local u31 = {};

    for i = 1, 48 do
        local Part = Instance.new("Part");
        Part.Anchored = true;
        Part.CanCollide = false;
        Part.CanQuery = false;
        Part.CanTouch = false;
        Part.CastShadow = false;
        Part.Material = Enum.Material.SmoothPlastic;
        Part.Color = Color3_fromRGB_ret2;
        Part.Transparency = 0.55;
        Part.Size = Vector3.new(14, 34, 1);

        if i % 4 == 0 then
            local ParticleEmitter = Instance.new("ParticleEmitter");
            ParticleEmitter.Texture = "rbxasset://textures/particles/smoke_main.dds";
            ParticleEmitter.Color = ColorSequence.new(Color3_fromRGB_ret2);
            ParticleEmitter.Size = NumberSequence.new(10, 18);
            ParticleEmitter.Transparency = NumberSequence.new(0.5, 1);
            ParticleEmitter.Lifetime = NumberRange.new(3, 5);
            ParticleEmitter.Rate = 2;
            ParticleEmitter.Speed = NumberRange.new(1, 3);
            ParticleEmitter.SpreadAngle = Vector2.new(60, 60);
            ParticleEmitter.Parent = Part;
        end;

        Part.Parent = u27;
        u31[i] = Part;
        local _ = i;
    end;

    u27.Parent = workspace;
    u28 = RunService.RenderStepped:Connect(function(p32) -- Line: 250
        -- upvalues: Session (ref), u29 (ref), u31 (copy), LocalPlayer (ref), u30 (ref), FallenKingBossConfig (ref)
        local Attribute = Session:GetAttribute("BossFogCentre");
        local Attribute2 = Session:GetAttribute("BossFogRadius");

        if typeof(Attribute) ~= "Vector3" or type(Attribute2) ~= "number" then
            return;
        end;

        if u29 then
            Attribute2 = u29 + (Attribute2 - u29) * (1 - math.exp(-6 * p32));
        end;

        u29 = Attribute2;

        for i, v in u31 do
            local v33 = i / 48 * 3.141592653589793 * 2;
            local v34 = math.cos(v33) * u29;
            local v35 = math.sin(v33) * u29;
            local v36 = Attribute + Vector3.new(v34, 15, v35);
            v.Size = Vector3.new(u29 * 3.141592653589793 * 2 / 48 + 1, 34, 1);
            v.CFrame = CFrame.lookAt(v36, (Vector3.new(Attribute.X, v36.Y, Attribute.Z)));
        end;

        local Attribute3 = LocalPlayer:GetAttribute("BossFogAt");

        if not (Attribute3 and u30) then
            if u30 then
                u30.Visible = false;
            end;

            return;
        end;

        local v37 = FallenKingBossConfig.Fog.CatchSeconds - (workspace:GetServerTimeNow() - Attribute3);
        u30.Visible = true;
        u30.Text = ("IN THE GRAVE FOG — GET OUT! %.1f"):format((math.max(0, v37)));
    end);
end;

local function refreshFog() -- Line: 274
    -- upvalues: Session (copy), u27 (ref), buildFog (copy), u1 (ref), u30 (ref), text (copy), u28 (ref), u29 (ref)
    local Attribute = Session:GetAttribute("BossFogRadius");

    if type(Attribute) == "number" and not u27 then
        buildFog();

        if u1 and not u30 then
            u30 = text(u1, "FogWarning", UDim2.fromOffset(520, 40), UDim2.new(0.5, -260, 0.42, 0), 34, Color3.fromRGB(255, 70, 70));
            u30.Visible = false;
        end;
    elseif Attribute == nil and u27 then
        if u28 then
            u28:Disconnect();
            u28 = nil;
        end;

        if u27 then
            u27:Destroy();
            u27 = nil;
        end;

        u29 = nil;

        if u30 then
            u30.Visible = false;
        end;
    end;
end;

Session:GetAttributeChangedSignal("BossFogRadius"):Connect(refreshFog);
refreshFog();
Session:GetAttributeChangedSignal("BossActive"):Connect(refresh);
Session:GetAttributeChangedSignal("BossPhase"):Connect(refresh);
refresh();
local u38 = false;
LocalPlayer:GetAttributeChangedSignal("CutsceneActive"):Connect(function() -- Line: 299
    -- upvalues: u1 (ref), LocalPlayer (copy), Session (copy), TweenService (copy), barTop (copy), u38 (ref)
    local v39 = u1 and u1:FindFirstChild("Bar");

    if v39 and (LocalPlayer:GetAttribute("CutsceneActive") == nil and Session:GetAttribute("BossActive") == true) then
        v39.Position = UDim2.new(0.5, 0, 0, -70);
        local v40 = TweenService:Create(v39, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Position = UDim2.new(0.5, 0, 0, (barTop()))
        });
        u38 = true;
        v40.Completed:Once(function() -- Line: 307
            -- upvalues: u38 (ref)
            u38 = false;
        end);
        v40:Play();
    end;
end);
RunService.Heartbeat:Connect(function() -- Line: 314
    -- upvalues: u1 (ref), u38 (ref), barTop (copy)
    local v41 = u1 and u1:FindFirstChild("Bar");

    if v41 and (v41.Visible and not u38) then
        local v42 = barTop();

        if v41.Position.Y.Offset ~= v42 then
            v41.Position = UDim2.new(0.5, 0, 0, v42);
        end;
    end;
end);
local SoundService = game:GetService("SoundService");
local LazySound = require(game:GetService("ReplicatedFirst"):WaitForChild("LazySound"));
local Music = FallenKingBossConfig.Music;
local u43 = nil;
local u44 = false;
local u45 = nil;
local u46 = false;

local function musicLevel() -- Line: 338
    -- upvalues: LocalPlayer (copy)
    if LocalPlayer:GetAttribute("MusicMuted") == true then
        return 0;
    end;

    local Attribute = LocalPlayer:GetAttribute("MusicVolume");

    return type(Attribute) == "number" and (Attribute == Attribute and math.clamp(Attribute, 0, 1)) or 1;
end;

local function musicSound() -- Line: 345
    -- upvalues: u43 (ref), Music (copy), SoundService (copy), LazySound (copy)
    if not u43 then
        u43 = Instance.new("Sound");
        u43.Name = "FallenKingFightMusic";
        u43.SoundId = "rbxassetid://" .. Music.Id;
        u43.Looped = true;
        u43.Volume = 0;
        u43.Parent = SoundService;
    end;

    return LazySound.arm(u43);
end;

local function fadeMusic(p47, p48) -- Line: 356
    -- upvalues: u45 (ref), TweenService (copy), u43 (ref)
    if u45 then
        u45:Cancel();
    end;

    u45 = TweenService:Create(u43, TweenInfo.new(p48), {
        Volume = p47
    });
    u45:Play();

    return u45;
end;

local function holdMusic(p49) -- Line: 366
    -- upvalues: u46 (ref), LocalPlayer (copy)
    if p49 == u46 then
        return;
    end;

    u46 = p49;

    if p49 then
        LocalPlayer:SetAttribute("MusicPaused", true);

        return;
    end;

    if LocalPlayer:GetAttribute("CutsceneActive") == nil then
        LocalPlayer:SetAttribute("MusicPaused", nil);
    end;
end;

local function refreshMusic() -- Line: 377
    -- upvalues: Music (copy), Session (copy), u43 (ref), SoundService (copy), LazySound (copy), LocalPlayer (copy), u44 (ref), fadeMusic (copy), u46 (ref)
    if type(Music) ~= "table" then
        return;
    end;

    local v50 = Session:GetAttribute("BossActive") == true;

    if v50 then
        if not u43 then
            u43 = Instance.new("Sound");
            u43.Name = "FallenKingFightMusic";
            u43.SoundId = "rbxassetid://" .. Music.Id;
            u43.Looped = true;
            u43.Volume = 0;
            u43.Parent = SoundService;
        end;

        LazySound.arm(u43);
    end;

    if v50 then
        if Session:GetAttribute("BossFighting") == true then
            v50 = LocalPlayer:GetAttribute("CutsceneActive") == nil;
        else
            v50 = false;
        end;
    end;

    if v50 == u44 then
        return;
    end;

    u44 = v50;

    if not v50 then
        if u43 then
            if u46 ~= false then
                u46 = false;

                if LocalPlayer:GetAttribute("CutsceneActive") == nil then
                    LocalPlayer:SetAttribute("MusicPaused", nil);
                end;
            end;

            fadeMusic(0, Music.FadeOut).Completed:Once(function(p51) -- Line: 408
                -- upvalues: u44 (ref), u43 (ref)
                if p51 == Enum.PlaybackState.Completed and not u44 then
                    u43:Stop();
                end;
            end);
        end;

        return;
    end;

    if not u43 then
        u43 = Instance.new("Sound");
        u43.Name = "FallenKingFightMusic";
        u43.SoundId = "rbxassetid://" .. Music.Id;
        u43.Looped = true;
        u43.Volume = 0;
        u43.Parent = SoundService;
    end;

    local v52 = LazySound.arm(u43);
    v52.TimePosition = 0;
    v52.Volume = 0;
    v52:Play();

    if v52.IsLoaded then
        local Volume = Music.Volume;
        local v53;

        if LocalPlayer:GetAttribute("MusicMuted") == true then
            v53 = 0;
        else
            local Attribute = LocalPlayer:GetAttribute("MusicVolume");
            v53 = type(Attribute) == "number" and (Attribute == Attribute and math.clamp(Attribute, 0, 1)) or 1;
        end;

        fadeMusic(Volume * v53, Music.FadeIn);
    else
        v52.Loaded:Once(function() -- Line: 399
            -- upvalues: u44 (ref), fadeMusic (ref), Music (ref), LocalPlayer (ref)
            if u44 then
                local Volume = Music.Volume;
                local v54;

                if LocalPlayer:GetAttribute("MusicMuted") == true then
                    v54 = 0;
                else
                    local Attribute = LocalPlayer:GetAttribute("MusicVolume");
                    v54 = type(Attribute) == "number" and (Attribute == Attribute and math.clamp(Attribute, 0, 1)) or 1;
                end;

                fadeMusic(Volume * v54, Music.FadeIn);
            end;
        end);
    end;

    if u46 == true then
        return;
    end;

    u46 = true;
    LocalPlayer:SetAttribute("MusicPaused", true);
end;

for _, v in { "MusicMuted", "MusicVolume" } do
    LocalPlayer:GetAttributeChangedSignal(v):Connect(function() -- Line: 417
        -- upvalues: u44 (ref), u43 (ref), fadeMusic (copy), Music (copy), LocalPlayer (copy)
        if u44 and u43 then
            local Volume = Music.Volume;
            local v55;

            if LocalPlayer:GetAttribute("MusicMuted") == true then
                v55 = 0;
            else
                local Attribute = LocalPlayer:GetAttribute("MusicVolume");
                v55 = type(Attribute) == "number" and (Attribute == Attribute and math.clamp(Attribute, 0, 1)) or 1;
            end;

            fadeMusic(Volume * v55, 0.2);
        end;
    end);
end;

Session:GetAttributeChangedSignal("BossActive"):Connect(refreshMusic);
Session:GetAttributeChangedSignal("BossFighting"):Connect(refreshMusic);
LocalPlayer:GetAttributeChangedSignal("CutsceneActive"):Connect(refreshMusic);
refreshMusic();
script.Destroying:Connect(function() -- Line: 427
    -- upvalues: u46 (ref), LocalPlayer (copy), u43 (ref)
    if u46 then
        LocalPlayer:SetAttribute("MusicPaused", nil);
    end;

    if u43 then
        u43:Destroy();
    end;
end);