 

 

local Players = game:GetService("Players");
game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local UserInputService = game:GetService("UserInputService");
local GuiService = game:GetService("GuiService");
local ChickenOrHero = game:GetService("ReplicatedStorage"):WaitForChild("ChickenOrHero");
local FallenKingBossConfig = require(ChickenOrHero:WaitForChild("Game"):WaitForChild("FallenKingBossConfig"));
local EquipmentHudLayoutLegacy = require(ChickenOrHero:WaitForChild("Presentation"):WaitForChild("EquipmentHudLayoutLegacy"));
local FallenKingEvent = ChickenOrHero.Game:WaitForChild("FallenKingEvent");
local LocalPlayer = Players.LocalPlayer;
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");
local u1 = FallenKingBossConfig.Hearts and (FallenKingBossConfig.Hearts.Count or 3) or 3;
local ScreenGui = Instance.new("ScreenGui");
ScreenGui.Name = "FallenKingHearts";
ScreenGui.ResetOnSpawn = false;
ScreenGui.IgnoreGuiInset = true;
ScreenGui.DisplayOrder = 62;
ScreenGui:SetAttribute("SelfManagedText", true);
local Frame = Instance.new("Frame");
Frame.Name = "Hearts";
Frame.BackgroundTransparency = 1;
Frame.AnchorPoint = Vector2.new(0.5, 1);
Frame.Visible = false;
Frame.Parent = ScreenGui;
local UIScale = Instance.new("UIScale");
UIScale.Parent = Frame;
local u2 = {};

for i = 1, u1 do
    local ImageLabel = Instance.new("ImageLabel");
    ImageLabel.Name = "Heart" .. i;
    ImageLabel.BackgroundTransparency = 1;
    ImageLabel.Image = "rbxassetid://77000589962060";
    ImageLabel.ImageRectSize = Vector2.new(128, 128);
    ImageLabel.ImageRectOffset = Vector2.new(0, 384);
    ImageLabel.ScaleType = Enum.ScaleType.Fit;
    ImageLabel.Parent = Frame;
    local UIScale2 = Instance.new("UIScale");
    UIScale2.Parent = ImageLabel;
    local Frame2 = Instance.new("Frame");
    Frame2.Name = "Partial";
    Frame2.BackgroundTransparency = 1;
    Frame2.Size = UDim2.fromScale(1, 1);
    Frame2.Visible = false;
    Frame2.Parent = ImageLabel;
    local ImageLabel2 = Instance.new("ImageLabel");
    ImageLabel2.BackgroundTransparency = 1;
    ImageLabel2.Size = UDim2.fromScale(1, 1);
    ImageLabel2.Image = "rbxassetid://77000589962060";
    ImageLabel2.ImageRectSize = Vector2.new(128, 128);
    ImageLabel2.ImageRectOffset = Vector2.new(256, 384);
    ImageLabel2.Parent = Frame2;
    local Frame3 = Instance.new("Frame");
    Frame3.BackgroundTransparency = 1;
    Frame3.ClipsDescendants = true;
    Frame3.Size = UDim2.fromScale(0.5, 1);
    Frame3.Parent = Frame2;
    local ImageLabel3 = Instance.new("ImageLabel");
    ImageLabel3.BackgroundTransparency = 1;
    ImageLabel3.Image = "rbxassetid://77000589962060";
    ImageLabel3.ImageRectSize = Vector2.new(128, 128);
    ImageLabel3.ImageRectOffset = Vector2.new(0, 384);
    ImageLabel3.Parent = Frame3;
    u2[i] = {
        halves = 2,
        playing = nil,
        image = ImageLabel,
        pulse = UIScale2,
        partial = Frame2,
        clip = Frame3,
        over = ImageLabel3
    };
    local _ = i;
end;

local TextLabel = Instance.new("TextLabel");
TextLabel.Name = "Dodged";
TextLabel.BackgroundTransparency = 1;
TextLabel.AnchorPoint = Vector2.new(0.5, 1);
TextLabel.Position = UDim2.new(0.5, 0, 0, -2);
TextLabel.Size = UDim2.fromOffset(160, 22);
TextLabel.FontFace = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.Heavy);
TextLabel.Text = "DODGED!";
TextLabel.TextSize = 20;
TextLabel.TextColor3 = Color3.fromRGB(140, 235, 255);
TextLabel.TextStrokeTransparency = 0.25;
TextLabel.TextTransparency = 1;
TextLabel.TextStrokeColor3 = Color3.fromRGB(10, 30, 45);
TextLabel.Parent = Frame;
local TextLabel2 = Instance.new("TextLabel");
TextLabel2.Name = "Protected";
TextLabel2.BackgroundTransparency = 1;
TextLabel2.AnchorPoint = Vector2.new(0.5, 1);
TextLabel2.Position = UDim2.new(0.5, 0, 0, -4);
TextLabel2.Size = UDim2.fromOffset(200, 20);
TextLabel2.FontFace = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.Heavy);
TextLabel2.TextSize = 18;
TextLabel2.TextColor3 = Color3.fromRGB(150, 220, 255);
TextLabel2.TextStrokeColor3 = Color3.fromRGB(10, 30, 50);
TextLabel2.TextStrokeTransparency = 0.25;
TextLabel2.Visible = false;
TextLabel2.Parent = Frame;
local ImageLabel = Instance.new("ImageLabel");
ImageLabel.Name = "HurtFlash";
ImageLabel.BackgroundTransparency = 1;
ImageLabel.Size = UDim2.fromScale(1, 1);
ImageLabel.Image = "rbxassetid://1316045217";
ImageLabel.ImageColor3 = Color3.fromRGB(255, 30, 50);
ImageLabel.ImageTransparency = 1;
ImageLabel.Parent = ScreenGui;
ScreenGui.Parent = PlayerGui;

local function still(p3) -- Line: 124
    local halves = p3.halves;

    if halves % 1 == 0 then
        p3.image.ImageTransparency = 0;
        p3.partial.Visible = false;
        p3.image.ImageRectOffset = Vector2.new(({
            [2] = 0,
            [1] = 1,
            [0] = 2
        })[halves] * 128, 384);

        return;
    end;

    p3.image.ImageTransparency = 1;
    p3.partial.Visible = true;
    p3.clip.Size = UDim2.fromScale(halves / 2, 1);
end;

local function halvesOf(p4, p5) -- Line: 137
    return math.clamp(p4 - (p5 - 1) * 2, 0, 2);
end;

local function play(u6, u7) -- Line: 142
    -- upvalues: still (copy)
    local u8 = {};
    u6.playing = u8;
    u6.image.ImageTransparency = 0;
    u6.partial.Visible = false;
    task.spawn(function() -- Line: 147
        -- upvalues: u6 (copy), u8 (copy), u7 (copy), still (ref)
        for i = 0, 7 do
            if u6.playing ~= u8 then
                return;
            end;

            u6.image.ImageRectOffset = Vector2.new(i * 128, u7 * 128);
            task.wait(0.045);
            local _ = i;
        end;

        if u6.playing == u8 then
            u6.playing = nil;
            still(u6);
        end;
    end);
end;

local u9 = nil;

local function refresh() -- Line: 163
    -- upvalues: LocalPlayer (copy), u9 (ref), Frame (copy), u2 (copy), play (copy), still (copy), UIScale (copy), TweenService (copy), ImageLabel (copy)
    local Attribute = LocalPlayer:GetAttribute("BossHearts");

    if type(Attribute) ~= "number" then
        u9 = nil;
        Frame.Visible = false;

        return;
    end;

    Frame.Visible = LocalPlayer:GetAttribute("BossDownedUntil") == nil;
    local v10;

    if u9 == nil then
        v10 = false;
    else
        v10 = Attribute < u9;
    end;

    for i, v in u2 do
        local math_clamp_ret = math.clamp(Attribute - (i - 1) * 2, 0, 2);
        local halves = v.halves;
        v.halves = math_clamp_ret;

        if v10 and (math_clamp_ret < halves and (halves % 1 == 0 and math_clamp_ret % 1 == 0)) then
            play(v, halves == 2 and math_clamp_ret == 1 and 0 or (halves == 1 and 1 or 2));
        else
            v.playing = nil;
            still(v);
        end;
    end;

    if v10 then
        UIScale.Scale = 1.18;
        TweenService:Create(UIScale, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Scale = 1
        }):Play();
        ImageLabel.ImageTransparency = 0.35;
        TweenService:Create(ImageLabel, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            ImageTransparency = 1
        }):Play();
    elseif u9 ~= nil and u9 < Attribute then
        for _, v in u2 do
            v.pulse.Scale = 1.3;
            TweenService:Create(v.pulse, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Scale = 1
            }):Play();
        end;
    end;

    u9 = Attribute;
end;

local u11 = LocalPlayer:GetAttributeChangedSignal("BossHearts"):Connect(refresh);
local u13 = LocalPlayer:GetAttributeChangedSignal("BossDownedUntil"):Connect(function() -- Line: 202
    -- upvalues: Frame (copy), LocalPlayer (copy)
    local v12;

    if type(LocalPlayer:GetAttribute("BossHearts")) == "number" then
        v12 = LocalPlayer:GetAttribute("BossDownedUntil") == nil;
    else
        v12 = false;
    end;

    Frame.Visible = v12;
end);
refresh();
local Debris = game:GetService("Debris");
local AnimationLibrary = require(ChickenOrHero:WaitForChild("Animation"):WaitForChild("AnimationLibrary"));

local function rootOf(p14) -- Line: 212
    -- upvalues: Players (copy)
    local PlayerByUserId = Players:GetPlayerByUserId(p14);

    if PlayerByUserId then
        PlayerByUserId = PlayerByUserId.Character;
    end;

    if PlayerByUserId then
        PlayerByUserId = PlayerByUserId:FindFirstChild("HumanoidRootPart");
    end;

    return PlayerByUserId;
end;

local function sound(p15, p16, p17) -- Line: 217
    -- upvalues: Debris (copy)
    if not (p15 and p16) then
        return;
    end;

    local Sound = Instance.new("Sound");
    Sound.SoundId = "rbxassetid://" .. p15.Id;
    Sound.Volume = p15.Volume or 1;
    Sound.PlaybackSpeed = p17 or 1;
    Sound.RollOffMinDistance = 14;
    Sound.RollOffMaxDistance = 180;
    Sound.Parent = p16;
    Sound:Play();
    Debris:AddItem(Sound, 4);
end;

local function dust(p18) -- Line: 231
    -- upvalues: Debris (copy)
    local Part = Instance.new("Part");
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.Transparency = 1;
    Part.Size = Vector3.new(1, 1, 1);
    Part.CFrame = CFrame.new(p18 - Vector3.new(0, 2.6, 0));
    Part.Parent = workspace;
    local ParticleEmitter = Instance.new("ParticleEmitter");
    ParticleEmitter.Texture = "rbxasset://textures/particles/smoke_main.dds";
    ParticleEmitter.Color = ColorSequence.new(Color3.fromRGB(205, 195, 180), Color3.fromRGB(120, 110, 100));
    ParticleEmitter.Size = NumberSequence.new(1.2, 4.5);
    ParticleEmitter.Transparency = NumberSequence.new(0.35, 1);
    ParticleEmitter.Lifetime = NumberRange.new(0.45, 0.8);
    ParticleEmitter.Speed = NumberRange.new(12, 20);
    ParticleEmitter.SpreadAngle = Vector2.new(5, 180);
    ParticleEmitter.EmissionDirection = Enum.NormalId.Front;
    ParticleEmitter.Drag = 4;
    ParticleEmitter.Rate = 0;
    ParticleEmitter.Parent = Part;

    for i = 0, 11 do
        Part.CFrame = CFrame.new(Part.Position) * CFrame.Angles(0, i / 12 * 3.141592653589793 * 2, 0);
        ParticleEmitter:Emit(3);
        local _ = i;
    end;

    Debris:AddItem(Part, 1.2);

    return Part;
end;

local function shake(p19) -- Line: 260
    -- upvalues: LocalPlayer (copy)
    local Character = LocalPlayer.Character;

    if Character then
        Character:SetAttribute("CameraKickPower", p19);
        Character:SetAttribute("CameraKickAt", os.clock());
    end;
end;

local RunService = game:GetService("RunService");

local function skidDust(p20) -- Line: 271
    -- upvalues: Debris (copy)
    local Part = Instance.new("Part");
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.Transparency = 1;
    Part.Size = Vector3.new(1, 1, 1);
    Part.CFrame = CFrame.new(p20);
    Part.Parent = workspace;
    local ParticleEmitter = Instance.new("ParticleEmitter");
    ParticleEmitter.Texture = "rbxasset://textures/particles/smoke_main.dds";
    ParticleEmitter.Color = ColorSequence.new(Color3.fromRGB(205, 195, 180));
    ParticleEmitter.Size = NumberSequence.new(0.8, 2.6);
    ParticleEmitter.Transparency = NumberSequence.new(0.45, 1);
    ParticleEmitter.Lifetime = NumberRange.new(0.35, 0.6);
    ParticleEmitter.Speed = NumberRange.new(2, 5);
    ParticleEmitter.SpreadAngle = Vector2.new(60, 60);
    ParticleEmitter.Rate = 0;
    ParticleEmitter.Parent = Part;
    ParticleEmitter:Emit(3);
    Debris:AddItem(Part, 0.8);
end;

local function landPose(p21) -- Line: 291
    -- upvalues: LocalPlayer (copy), AnimationLibrary (copy), RunService (copy), skidDust (copy)
    local Character = LocalPlayer.Character;
    local v22;

    if Character then
        v22 = Character:FindFirstChildOfClass("Humanoid");
    else
        v22 = Character;
    end;

    local u23;

    if Character then
        u23 = Character:FindFirstChild("HumanoidRootPart");
    else
        u23 = Character;
    end;

    if v22 then
        v22 = v22:FindFirstChildOfClass("Animator");
    end;

    local u24 = tonumber(p21.pose) or 0;

    if not (u23 and (v22 and u24 > 0)) then
        return;
    end;

    local v25 = typeof(p21.direction) ~= "Vector3" and Vector3.new(0, 0, 0) or p21.direction * Vector3.new(1, 0, 1);
    local u26;

    if v25.Magnitude > 0.1 then
        u26 = -v25.Unit;
    elseif typeof(p21.facing) == "Vector3" then
        u26 = p21.facing;
    else
        u26 = nil;
    end;

    if u26 then
        u23.CFrame = CFrame.lookAt(u23.Position, u23.Position + u26);
    end;

    local success, success = pcall(AnimationLibrary.prepare);

    if success then
        if success then
            success = success.DashBack or success.DashLeft;
        end;
    end;

    local u27;

    if success and success.animation then
        u27 = v22:LoadAnimation(success.animation);
        u27.Priority = Enum.AnimationPriority.Action4;
        u27.Looped = false;
        u27:Play(0.05, 1, (math.max(0.35, (u27.Length <= 0 and 0.4 or u27.Length) / u24)));
    else
        u27 = nil;
    end;

    local v28 = typeof(p21.direction) ~= "Vector3" and Vector3.new(0, 0, 0) or p21.direction * Vector3.new(1, 0, 1);
    local v29 = tonumber(p21.slide) or 0;
    local u30 = v28.Magnitude <= 0.1 and 0 or v29 * 2.5 / u24;
    local u31 = v28.Magnitude <= 0.1 and Vector3.new(0, 0, 0) or v28.Unit;
    local os_clock_ret = os.clock();
    local u32 = 0;
    local u33 = nil;
    u33 = RunService.Heartbeat:Connect(function() -- Line: 324
        -- upvalues: os_clock_ret (copy), u24 (copy), u23 (copy), LocalPlayer (ref), Character (copy), u33 (ref), u27 (ref), u30 (copy), u31 (ref), u26 (copy), u32 (ref), skidDust (ref)
        local v34 = os.clock() - os_clock_ret;

        if u24 <= v34 or (not u23.Parent or LocalPlayer.Character ~= Character) then
            u33:Disconnect();

            if u23.Parent then
                u23.AssemblyLinearVelocity = Vector3.new(0, u23.AssemblyLinearVelocity.Y, 0);
            end;

            if u27 then
                u27:Stop(0.2);
                task.delay(0.3, function() -- Line: 334
                    -- upvalues: u27 (ref)
                    u27:Destroy();
                end);
            end;

            return;
        end;

        local v35 = u30 * (1 - v34 / u24) ^ 1.5;
        u23.AssemblyLinearVelocity = Vector3.new(u31.X * v35, u23.AssemblyLinearVelocity.Y, u31.Z * v35);

        if u26 then
            u23.CFrame = CFrame.lookAt(u23.Position, u23.Position + u26);
        end;

        if v35 > 3 and v34 - u32 >= 0.06 then
            u32 = v34;
            skidDust(u23.Position - Vector3.new(0, 2.8, 0));
        end;
    end);
end;

local u40 = FallenKingEvent.OnClientEvent:Connect(function(p36, p37) -- Line: 353
    -- upvalues: sound (copy), FallenKingBossConfig (copy), dust (copy), LocalPlayer (copy), landPose (copy), Players (copy), TextLabel (copy), TweenService (copy)
    if type(p37) ~= "table" then
        return;
    end;

    if p36 == "Landed" and typeof(p37.position) == "Vector3" then
        sound(FallenKingBossConfig.HitSounds and FallenKingBossConfig.HitSounds.Land, (dust(p37.position)));

        if p37.userId == LocalPlayer.UserId then
            local Character = LocalPlayer.Character;

            if Character then
                Character:SetAttribute("CameraKickPower", 0.9);
                Character:SetAttribute("CameraKickAt", os.clock());
            end;

            landPose(p37);
        end;

        return;
    end;

    if p36 ~= "Hurt" then
        return;
    end;

    if p37.dodged then
        if p37.userId ~= LocalPlayer.UserId then
            return;
        end;

        TextLabel.TextTransparency = 0;
        TextLabel.TextStrokeTransparency = 0.25;
        TextLabel.Position = UDim2.new(0.5, 0, 0, -2);
        TweenService:Create(TextLabel, TweenInfo.new(0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            TextTransparency = 1,
            TextStrokeTransparency = 1,
            Position = UDim2.new(0.5, 0, 0, -16)
        }):Play();

        return;
    end;

    local v38 = FallenKingBossConfig.HitSounds and FallenKingBossConfig.HitSounds.Hurt;
    local PlayerByUserId = Players:GetPlayerByUserId(p37.userId);

    if PlayerByUserId then
        PlayerByUserId = PlayerByUserId.Character;
    end;

    if PlayerByUserId then
        PlayerByUserId = PlayerByUserId:FindFirstChild("HumanoidRootPart");
    end;

    sound(v38, PlayerByUserId, 0.95 + math.random() * 0.1);

    if p37.userId == LocalPlayer.UserId then
        local v39 = (p37.halves or 2) >= 2 and 1.3 or 0.8;
        local Character = LocalPlayer.Character;

        if Character then
            Character:SetAttribute("CameraKickPower", v39);
            Character:SetAttribute("CameraKickAt", os.clock());
        end;
    end;
end);

local function place() -- Line: 391
    -- upvalues: UserInputService (copy), Frame (copy), u1 (copy), u2 (copy), ScreenGui (copy), PlayerGui (copy), EquipmentHudLayoutLegacy (copy), GuiService (copy)
    local TouchEnabled = UserInputService.TouchEnabled;
    local v41 = TouchEnabled and 27 or 37;
    Frame.Size = UDim2.fromOffset(u1 * v41 + (u1 - 1) * 3, v41);

    for i, v in u2 do
        v.image.Size = UDim2.fromOffset(v41, v41);
        v.image.Position = UDim2.fromOffset((i - 1) * (v41 + 3), 0);
        v.over.Size = UDim2.fromOffset(v41, v41);
    end;

    local AbsoluteSize = ScreenGui.AbsoluteSize;
    local HUD = PlayerGui:FindFirstChild("HUD");
    local v42;

    if HUD then
        v42 = HUD:FindFirstChild("MainFrame");
    else
        v42 = HUD;
    end;

    if v42 then
        v42 = v42:FindFirstChild("BarMainFrame");
    end;

    local v43;

    if v42 then
        v43 = v42.AbsolutePosition.X + v42.AbsoluteSize.X / 2;
    else
        v43 = AbsoluteSize.X / 2;
    end;

    local v44 = not TouchEnabled and EquipmentHudLayoutLegacy.rowTop();

    if v44 then
        Frame.Position = UDim2.fromOffset(v43, v44 - 8);

        return;
    end;

    if not v42 or v42.AbsoluteSize.Y <= 0 then
        Frame.Position = UDim2.new(0.5, 0, 1, -150);

        return;
    end;

    local v45 = HUD.IgnoreGuiInset and 0 or GuiService:GetGuiInset().Y;
    Frame.Position = UDim2.fromOffset(v43, v42.AbsolutePosition.Y + v45 - 6);
end;

local u46 = 0;
local u50 = RunService.RenderStepped:Connect(function(p47) -- Line: 417
    -- upvalues: Frame (copy), u46 (ref), place (copy), LocalPlayer (copy), TextLabel2 (copy), TextLabel (copy), u9 (ref), u2 (copy)
    if not Frame.Visible then
        return;
    end;

    u46 = u46 + p47;
    place();
    local Attribute = LocalPlayer:GetAttribute("BossGraceUntil");
    local v48 = type(Attribute) ~= "number" and 0 or Attribute - workspace:GetServerTimeNow();
    TextLabel2.Visible = v48 > 0;

    if v48 > 0 then
        TextLabel2.Text = ("PROTECTED · %ds"):format((math.ceil(v48)));
        TextLabel.Position = UDim2.new(0.5, 0, 0, -26);
    end;

    local v49 = u9 or 0;

    for _, v in u2 do
        if v49 <= 2 and (v.halves > 0 and not v.playing) then
            local pulse = v.pulse;
            local math_sin_ret = math.sin(u46 * 9);
            pulse.Scale = math.max(0, math_sin_ret) * 0.08 + 1;
        elseif not (v.playing or (v.pulse.Scale == 1 or v49 <= 2)) then
            v.pulse.Scale = 1;
        end;
    end;
end);
local u51 = {};
local u52 = {};

local function stopDaze(p53) -- Line: 445
    -- upvalues: u51 (copy)
    local v54 = u51[p53];

    if v54 then
        u51[p53] = nil;
        v54.gui:Destroy();
    end;
end;

local function refreshDaze(p55) -- Line: 452
    -- upvalues: u51 (copy), PlayerGui (copy)
    local Attribute = p55:GetAttribute("BossDazedUntil");
    local v56 = p55.Character and p55.Character:FindFirstChild("Head");

    if type(Attribute) ~= "number" or not v56 then
        local v57 = u51[p55];

        if v57 then
            u51[p55] = nil;
            v57.gui:Destroy();
        end;

        return;
    end;

    local v58 = u51[p55];

    if not v58 then
        local BillboardGui = Instance.new("BillboardGui");
        BillboardGui.Name = "DazedStars";
        BillboardGui.Size = UDim2.fromScale(3.2, 1.5);
        BillboardGui.StudsOffset = Vector3.new(0, 1.9, 0);
        BillboardGui.LightInfluence = 0;
        BillboardGui.MaxDistance = 160;
        local v59 = {};

        for i = 1, 3 do
            local TextLabel3 = Instance.new("TextLabel");
            TextLabel3.BackgroundTransparency = 1;
            TextLabel3.AnchorPoint = Vector2.new(0.5, 0.5);
            TextLabel3.Size = UDim2.fromScale(0.2, 1);
            local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint");
            UIAspectRatioConstraint.AspectRatio = 1;
            UIAspectRatioConstraint.DominantAxis = Enum.DominantAxis.Width;
            UIAspectRatioConstraint.Parent = TextLabel3;
            TextLabel3.FontFace = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.Heavy);
            TextLabel3.Text = "★";
            TextLabel3.TextScaled = true;
            TextLabel3.TextColor3 = Color3.fromRGB(255, 226, 90);
            TextLabel3.TextStrokeColor3 = Color3.fromRGB(90, 50, 0);
            TextLabel3.TextStrokeTransparency = 0.2;
            TextLabel3.Parent = BillboardGui;
            v59[i] = TextLabel3;
            local _ = i;
        end;

        BillboardGui.Parent = PlayerGui;
        v58 = {
            gui = BillboardGui,
            stars = v59
        };
        u51[p55] = v58;
    end;

    v58.gui.Adornee = v56;
    v58.untilAt = Attribute;
end;

local function watchDaze(u60) -- Line: 494
    -- upvalues: u52 (copy), refreshDaze (copy)
    if u52[u60] then
        return;
    end;

    u52[u60] = u60:GetAttributeChangedSignal("BossDazedUntil"):Connect(function() -- Line: 498
        -- upvalues: refreshDaze (ref), u60 (copy)
        refreshDaze(u60);
    end);
    refreshDaze(u60);
end;

for _, v in Players:GetPlayers() do
    if not u52[v] then
        u52[v] = v:GetAttributeChangedSignal("BossDazedUntil"):Connect(function() -- Line: 498
            -- upvalues: refreshDaze (copy), v (copy)
            refreshDaze(v);
        end);
        refreshDaze(v);
    end;
end;

local u61 = Players.PlayerAdded:Connect(watchDaze);
local u64 = Players.PlayerRemoving:Connect(function(p62) -- Line: 507
    -- upvalues: u51 (copy), u52 (copy)
    local v63 = u51[p62];

    if v63 then
        u51[p62] = nil;
        v63.gui:Destroy();
    end;

    if u52[p62] then
        u52[p62]:Disconnect();
        u52[p62] = nil;
    end;
end);
local u67 = RunService.RenderStepped:Connect(function() -- Line: 514
    -- upvalues: u51 (copy)
    if next(u51) == nil then
        return;
    end;

    local ServerTimeNow = workspace:GetServerTimeNow();
    local os_clock_ret = os.clock();

    for i, v in u51 do
        if v.untilAt <= ServerTimeNow or not (v.gui.Adornee and v.gui.Adornee.Parent) then
            local v65 = u51[i];

            if v65 then
                u51[i] = nil;
                v65.gui:Destroy();
            end;
        else
            for i2, v2 in v.stars do
                local v66 = os_clock_ret * 5 + i2 * 2.0943951023931953;
                local math_sin_ret = math.sin(v66);
                v2.Position = UDim2.fromScale(math.cos(v66) * 0.31 + 0.5, math_sin_ret * 0.16 + 0.5);
                v2.Size = UDim2.fromScale(math_sin_ret * 0.05 + 0.16, 1);
                v2.ZIndex = math_sin_ret > 0 and 2 or 1;
                v2.TextTransparency = 0.25 - math_sin_ret * 0.25;
            end;
        end;
    end;
end);
local u68 = u1 * 2;
local u69 = {};

local function wantsHearts() -- Line: 542
    -- upvalues: LocalPlayer (copy), u68 (copy)
    local Attribute = LocalPlayer:GetAttribute("BossHearts");
    local v70;

    if type(Attribute) == "number" then
        v70 = Attribute <= u68 - 2;
    else
        v70 = false;
    end;

    return v70;
end;

local function dropRemove(p71) -- Line: 546
    -- upvalues: u69 (copy)
    local v72 = u69[p71];

    if v72 then
        u69[p71] = nil;
        v72.part:Destroy();
    end;
end;

local function dropAdd(p73) -- Line: 553
    -- upvalues: u69 (copy), LocalPlayer (copy), u68 (copy)
    if not p73:IsA("Vector3Value") or u69[p73] then
        return;
    end;

    local Part = Instance.new("Part");
    Part.Name = "HeartPickup";
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.Transparency = 1;
    Part.Size = Vector3.new(1, 1, 1);
    Part.CFrame = CFrame.new(p73.Value);
    local BillboardGui = Instance.new("BillboardGui");
    BillboardGui.Size = UDim2.fromScale(3, 3);
    BillboardGui.LightInfluence = 0;
    BillboardGui.MaxDistance = 400;
    BillboardGui.Parent = Part;
    local ImageLabel2 = Instance.new("ImageLabel");
    ImageLabel2.BackgroundTransparency = 1;
    ImageLabel2.Size = UDim2.fromScale(1, 1);
    ImageLabel2.Image = "rbxassetid://77000589962060";
    ImageLabel2.ImageRectSize = Vector2.new(128, 128);
    ImageLabel2.ImageRectOffset = Vector2.new(0, 384);
    ImageLabel2.Parent = BillboardGui;
    local PointLight = Instance.new("PointLight");
    PointLight.Color = Color3.fromRGB(255, 70, 90);
    PointLight.Range = 10;
    PointLight.Brightness = 1.2;
    PointLight.Parent = Part;
    local ParticleEmitter = Instance.new("ParticleEmitter");
    ParticleEmitter.Texture = "rbxasset://textures/particles/sparkles_main.dds";
    ParticleEmitter.Color = ColorSequence.new(Color3.fromRGB(255, 120, 140));
    ParticleEmitter.LightEmission = 1;
    ParticleEmitter.Size = NumberSequence.new(0.5, 0);
    ParticleEmitter.Lifetime = NumberRange.new(0.6, 1);
    ParticleEmitter.Speed = NumberRange.new(0.5, 1.5);
    ParticleEmitter.SpreadAngle = Vector2.new(180, 180);
    ParticleEmitter.Rate = 6;
    ParticleEmitter.Parent = Part;
    u69[p73] = {
        part = Part,
        board = BillboardGui,
        base = p73.Value,
        phase = math.random() * 6
    };
    local Attribute = LocalPlayer:GetAttribute("BossHearts");
    local v74;

    if type(Attribute) == "number" then
        v74 = Attribute <= u68 - 2;
    else
        v74 = false;
    end;

    local v75;

    if v74 then
        v75 = workspace;
    else
        v75 = nil;
    end;

    Part.Parent = v75;
end;

local u76 = {};

local function watchDrops(p77) -- Line: 594
    -- upvalues: u76 (copy), u69 (copy), dropAdd (copy), dropRemove (copy)
    for _, v in u76 do
        v:Disconnect();
    end;

    table.clear(u76);

    for i in u69 do
        local v78 = u69[i];

        if v78 then
            u69[i] = nil;
            v78.part:Destroy();
        end;
    end;

    if not p77 then
        return;
    end;

    table.insert(u76, p77.ChildAdded:Connect(dropAdd));
    table.insert(u76, p77.ChildRemoved:Connect(dropRemove));

    for _, child in p77:GetChildren() do
        dropAdd(child);
    end;
end;

local function findFight() -- Line: 611
    -- upvalues: watchDrops (copy)
    local FallenKingFight = workspace:FindFirstChild("FallenKingFight");

    if FallenKingFight then
        FallenKingFight = FallenKingFight:FindFirstChild("HeartDrops");
    end;

    watchDrops(FallenKingFight);
end;

local u80 = workspace.ChildAdded:Connect(function(p79) -- Line: 615
    -- upvalues: watchDrops (copy)
    if p79.Name == "FallenKingFight" then
        p79:WaitForChild("HeartDrops", 5);
        local FallenKingFight = workspace:FindFirstChild("FallenKingFight");

        if FallenKingFight then
            FallenKingFight = FallenKingFight:FindFirstChild("HeartDrops");
        end;

        watchDrops(FallenKingFight);
    end;
end);
local u83 = workspace.ChildRemoved:Connect(function(p81) -- Line: 621
    -- upvalues: u76 (copy), u69 (copy)
    if p81.Name == "FallenKingFight" then
        for _, v in u76 do
            v:Disconnect();
        end;

        table.clear(u76);

        for i in u69 do
            local v82 = u69[i];

            if v82 then
                u69[i] = nil;
                v82.part:Destroy();
            end;
        end;
    end;
end);
local FallenKingFight = workspace:FindFirstChild("FallenKingFight");

if FallenKingFight then
    FallenKingFight = FallenKingFight:FindFirstChild("HeartDrops");
end;

watchDrops(FallenKingFight);
local u87 = RunService.RenderStepped:Connect(function() -- Line: 627
    -- upvalues: u69 (copy), LocalPlayer (copy), u68 (copy)
    if next(u69) == nil then
        return;
    end;

    local Attribute = LocalPlayer:GetAttribute("BossHearts");
    local v84;

    if type(Attribute) == "number" then
        v84 = Attribute <= u68 - 2;
    else
        v84 = false;
    end;

    local os_clock_ret = os.clock();

    for _, v in u69 do
        local v85;

        if v84 then
            v85 = workspace;
        else
            v85 = nil;
        end;

        if v.part.Parent ~= v85 then
            v.part.Parent = v85;
        end;

        if v84 then
            local part = v.part;
            local CFrame_new = CFrame.new;
            local base = v.base;
            local v86 = math.sin(os_clock_ret * 2.4 + v.phase) * 0.5;
            part.CFrame = CFrame_new(base + Vector3.new(0, v86, 0));
        end;
    end;
end);
local u90 = FallenKingEvent.OnClientEvent:Connect(function(p88, p89) -- Line: 643
    -- upvalues: LocalPlayer (copy), sound (copy), FallenKingBossConfig (copy), Debris (copy)
    if p88 ~= "Heal" or (type(p89) ~= "table" or typeof(p89.position) ~= "Vector3") then
        return;
    end;

    local Part = Instance.new("Part");
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.Transparency = 1;
    Part.Size = Vector3.new(1, 1, 1);
    Part.CFrame = CFrame.new(p89.position);
    Part.Parent = workspace;
    local ParticleEmitter = Instance.new("ParticleEmitter");
    ParticleEmitter.Texture = "rbxasset://textures/particles/sparkles_main.dds";
    ParticleEmitter.Color = ColorSequence.new(Color3.fromRGB(255, 110, 130), Color3.new(1, 1, 1));
    ParticleEmitter.LightEmission = 1;
    ParticleEmitter.Size = NumberSequence.new(1, 0);
    ParticleEmitter.Lifetime = NumberRange.new(0.4, 0.7);
    ParticleEmitter.Speed = NumberRange.new(8, 14);
    ParticleEmitter.SpreadAngle = Vector2.new(180, 180);
    ParticleEmitter.Rate = 0;
    ParticleEmitter.Parent = Part;
    ParticleEmitter:Emit(24);

    if p89.userId == LocalPlayer.UserId then
        sound(FallenKingBossConfig.HeartDrops and FallenKingBossConfig.HeartDrops.Sound, Part);
    end;

    Debris:AddItem(Part, 1.5);
end);
script.Destroying:Connect(function() -- Line: 670
    -- upvalues: u80 (copy), u83 (copy), u87 (copy), u90 (copy), u76 (copy), u69 (copy), u61 (copy), u64 (copy), u67 (copy), u52 (copy), u51 (copy), u11 (copy), u13 (copy), u40 (copy), u50 (copy), ScreenGui (copy)
    u80:Disconnect();
    u83:Disconnect();
    u87:Disconnect();
    u90:Disconnect();

    for _, v in u76 do
        v:Disconnect();
    end;

    table.clear(u76);

    for i in u69 do
        local v91 = u69[i];

        if v91 then
            u69[i] = nil;
            v91.part:Destroy();
        end;
    end;

    u61:Disconnect();
    u64:Disconnect();
    u67:Disconnect();

    for i, v in u52 do
        v:Disconnect();
        local v92 = u51[i];

        if v92 then
            u51[i] = nil;
            v92.gui:Destroy();
        end;
    end;

    u11:Disconnect();
    u13:Disconnect();
    u40:Disconnect();
    u50:Disconnect();
    ScreenGui:Destroy();
end);