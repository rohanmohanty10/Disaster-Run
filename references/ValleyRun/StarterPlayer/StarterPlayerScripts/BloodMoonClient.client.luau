 

 

local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
local SoundService = game:GetService("SoundService");
local Debris = game:GetService("Debris");
local LocalPlayer = Players.LocalPlayer;
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");
local ChickenOrHero = game:GetService("ReplicatedStorage"):WaitForChild("ChickenOrHero");
local Session = ChickenOrHero:WaitForChild("Game"):WaitForChild("Session");
local BloodMoonConfig = require(ChickenOrHero.Game:WaitForChild("BloodMoonConfig"));
local ClientBotKnockdown = require(ChickenOrHero:WaitForChild("Bots"):WaitForChild("ClientBotKnockdown"));
local Skin = require(ChickenOrHero:WaitForChild("OldUIReskin"):WaitForChild("Skin"));
local Palette = Skin.Palette;
local Color3_fromRGB_ret = Color3.fromRGB(255, 52, 52);
local Color3_fromRGB_ret2 = Color3.fromRGB(150, 0, 8);
local Color3_fromRGB_ret3 = Color3.fromRGB(255, 205, 205);
local TweenInfo_new_ret = TweenInfo.new(0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.Out);

local function up() -- Line: 25
    -- upvalues: Session (copy), LocalPlayer (copy)
    local v1;

    if Session:GetAttribute("BloodMoon") == true then
        v1 = LocalPlayer:GetAttribute("BloodMoonHidden") ~= true;
    else
        v1 = false;
    end;

    return v1;
end;

local function clock(p2) -- Line: 28
    local math_ceil_ret = math.ceil(p2);
    local math_max_ret = math.max(0, math_ceil_ret);

    return string.format("%d:%02d", math_max_ret // 60, math_max_ret % 60);
end;

local ScreenGui = Instance.new("ScreenGui");
ScreenGui.Name = "BloodMoonNotice";
ScreenGui.ResetOnSpawn = false;
ScreenGui.IgnoreGuiInset = true;
ScreenGui.ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets;
ScreenGui.DisplayOrder = 11;
ScreenGui:SetAttribute("SelfManagedText", true);
local Frame = Instance.new("Frame");
Frame.Name = "Holder";
Frame.AnchorPoint = Vector2.new(0.5, 0);
Frame.Position = UDim2.new(0.5, 0, 0, 106);
Frame.Size = UDim2.fromOffset(440, 70);
Frame.BackgroundTransparency = 1;
Frame.Parent = ScreenGui;
local UIScale = Instance.new("UIScale");
UIScale.Parent = Frame;

local function label(p3, p4) -- Line: 51
    -- upvalues: Skin (copy)
    local TextLabel = Instance.new("TextLabel");
    TextLabel.BackgroundTransparency = 1;
    TextLabel.TextXAlignment = Enum.TextXAlignment.Center;

    for i, v in p4 do
        TextLabel[i] = v;
    end;

    TextLabel.Parent = p3;
    Skin.textStroke(TextLabel, 1.5);

    return TextLabel;
end;

local Frame2 = Instance.new("Frame");
Frame2.Name = "Banner";
Frame2.AnchorPoint = Vector2.new(0.5, 0);
Frame2.Position = UDim2.new(0.5, 0, 0, -12);
Frame2.Size = UDim2.fromOffset(440, 64);
Frame2.BackgroundTransparency = 1;
Frame2.Visible = false;
Frame2.Parent = Frame;
local CanvasGroup = Instance.new("CanvasGroup");
CanvasGroup.Name = "Plate";
CanvasGroup.Size = UDim2.fromScale(1, 1);
CanvasGroup.BackgroundColor3 = Palette.surface;
CanvasGroup.Parent = Frame2;
Skin.card(CanvasGroup, Color3_fromRGB_ret2, {
    radius = UDim.new(0, 12)
});
local v5 = {
    Name = "Title",
    TextSize = 24,
    Position = UDim2.fromOffset(0, 8),
    Size = UDim2.new(1, 0, 0, 28),
    Font = Enum.Font.GothamBlack,
    TextColor3 = Color3_fromRGB_ret
};
local TextLabel = Instance.new("TextLabel");
TextLabel.BackgroundTransparency = 1;
TextLabel.TextXAlignment = Enum.TextXAlignment.Center;

for i, v in v5 do
    TextLabel[i] = v;
end;

TextLabel.Parent = CanvasGroup;
Skin.textStroke(TextLabel, 1.5);
local v6 = {
    Name = "Sub",
    TextSize = 13,
    Position = UDim2.fromOffset(0, 38),
    Size = UDim2.new(1, 0, 0, 18),
    Font = Enum.Font.GothamBold,
    TextColor3 = Color3_fromRGB_ret3
};
local TextLabel2 = Instance.new("TextLabel");
TextLabel2.BackgroundTransparency = 1;
TextLabel2.TextXAlignment = Enum.TextXAlignment.Center;

for i, v in v6 do
    TextLabel2[i] = v;
end;

TextLabel2.Parent = CanvasGroup;
Skin.textStroke(TextLabel2, 1.5);
local ScreenGui2 = Instance.new("ScreenGui");
ScreenGui2.Name = "BloodMoonTimer";
ScreenGui2.ResetOnSpawn = false;
ScreenGui2.IgnoreGuiInset = false;
ScreenGui2.DisplayOrder = 11;
ScreenGui2:SetAttribute("SelfManagedText", true);
local Frame3 = Instance.new("Frame");
Frame3.Name = "Timer";
Frame3.Position = UDim2.fromOffset(12, 8);
Frame3.Size = UDim2.fromOffset(0, 30);
Frame3.AutomaticSize = Enum.AutomaticSize.X;
Frame3.BackgroundColor3 = Palette.surface;
Frame3.Visible = false;
Frame3.Parent = ScreenGui2;
Skin.card(Frame3, Color3_fromRGB_ret2, {
    radius = UDim.new(0, 8)
});
local UIPadding = Instance.new("UIPadding");
UIPadding.PaddingLeft = UDim.new(0, 12);
UIPadding.PaddingRight = UDim.new(0, 12);
UIPadding.Parent = Frame3;
local v7 = {
    Name = "Countdown",
    TextSize = 14,
    Size = UDim2.fromOffset(0, 30),
    AutomaticSize = Enum.AutomaticSize.X,
    Font = Enum.Font.GothamBlack,
    TextColor3 = Color3_fromRGB_ret
};
local TextLabel3 = Instance.new("TextLabel");
TextLabel3.BackgroundTransparency = 1;
TextLabel3.TextXAlignment = Enum.TextXAlignment.Center;

for i, v in v7 do
    TextLabel3[i] = v;
end;

TextLabel3.Parent = Frame3;
Skin.textStroke(TextLabel3, 1.5);
local u8 = 0;

local function showBanner(p9, p10, p11) -- Line: 111
    -- upvalues: u8 (ref), TextLabel (copy), TextLabel2 (copy), Frame2 (copy), CanvasGroup (copy), TweenService (copy), TweenInfo_new_ret (copy)
    u8 = u8 + 1;
    local u12 = u8;
    TextLabel.Text = p9;
    TextLabel.TextColor3 = p11;
    TextLabel2.Text = p10;
    Frame2.Visible = true;
    Frame2.Position = UDim2.new(0.5, 0, 0, -12);
    CanvasGroup.GroupTransparency = 1;
    TweenService:Create(Frame2, TweenInfo_new_ret, {
        Position = UDim2.new(0.5, 0, 0, 0)
    }):Play();
    TweenService:Create(CanvasGroup, TweenInfo_new_ret, {
        GroupTransparency = 0
    }):Play();
    task.delay(6, function() -- Line: 122
        -- upvalues: u8 (ref), u12 (copy), TweenService (ref), CanvasGroup (ref), Frame2 (ref)
        if u8 ~= u12 then
            return;
        end;

        TweenService:Create(CanvasGroup, TweenInfo.new(0.5), {
            GroupTransparency = 1
        }):Play();
        task.delay(0.5, function() -- Line: 127
            -- upvalues: u8 (ref), u12 (ref), Frame2 (ref)
            if u8 == u12 then
                Frame2.Visible = false;
            end;
        end);
    end);
end;

local function refreshLine() -- Line: 136
    -- upvalues: LocalPlayer (copy), Session (copy), Frame3 (copy), TextLabel3 (copy)
    local ServerTimeNow = workspace:GetServerTimeNow();
    local v13 = nil;

    if LocalPlayer:GetAttribute("InMatch") ~= true then
        local Attribute = Session:GetAttribute("BloodMoonEndsAt");
        local v14;

        if Session:GetAttribute("BloodMoon") == true then
            v14 = LocalPlayer:GetAttribute("BloodMoonHidden") ~= true;
        else
            v14 = false;
        end;

        if v14 and type(Attribute) == "number" then
            local math_ceil_ret = math.ceil(Attribute - ServerTimeNow);
            local math_max_ret = math.max(0, math_ceil_ret);
            v13 = "BLOOD MOON  ·  " .. string.format("%d:%02d", math_max_ret // 60, math_max_ret % 60) .. " LEFT";
        end;
    end;

    Frame3.Visible = v13 ~= nil;

    if v13 then
        TextLabel3.Text = v13;
    end;
end;

local u15 = {};

local function anchorTo(p16) -- Line: 153
    -- upvalues: u15 (copy), UIScale (copy), Frame (copy), ScreenGui (copy)
    for _, v in u15 do
        v:Disconnect();
    end;

    table.clear(u15);
    local MainFrame = p16:WaitForChild("MainFrame", 10);

    if MainFrame then
        MainFrame = MainFrame:WaitForChild("NotificationsF", 10);
    end;

    if not MainFrame then
        return;
    end;

    local EscapeStreak = MainFrame:FindFirstChild("EscapeStreak");

    local function place() -- Line: 164
        -- upvalues: MainFrame (copy), EscapeStreak (copy), UIScale (ref), Frame (ref), ScreenGui (ref)
        local v17 = MainFrame.AbsolutePosition.Y + MainFrame.AbsoluteSize.Y;

        if EscapeStreak and (EscapeStreak.Visible and (EscapeStreak:IsA("CanvasGroup") and EscapeStreak.GroupTransparency < 0.95)) then
            v17 = EscapeStreak.AbsolutePosition.Y + EscapeStreak.AbsoluteSize.Y;
        end;

        UIScale.Scale = math.clamp(MainFrame.AbsoluteSize.X / 640, 0.55, 1.2);
        Frame.Position = UDim2.fromOffset(MainFrame.AbsolutePosition.X + MainFrame.AbsoluteSize.X / 2 - ScreenGui.AbsolutePosition.X, v17 - ScreenGui.AbsolutePosition.Y + 8);
    end;

    for _, v in { MainFrame:GetPropertyChangedSignal("AbsolutePosition"), MainFrame:GetPropertyChangedSignal("AbsoluteSize"), ScreenGui:GetPropertyChangedSignal("AbsoluteSize") } do
        table.insert(u15, v:Connect(place));
    end;

    if EscapeStreak then
        local PropertyChangedSignal = EscapeStreak:GetPropertyChangedSignal("Visible");
        table.insert(u15, PropertyChangedSignal:Connect(place));
    end;

    place();
end;

ScreenGui.Parent = PlayerGui;
ScreenGui2.Parent = PlayerGui;
task.spawn(function() -- Line: 182
    -- upvalues: PlayerGui (copy), anchorTo (copy)
    local Notifications = PlayerGui:WaitForChild("Notifications", 60);

    if Notifications then
        anchorTo(Notifications);
    end;

    PlayerGui.ChildAdded:Connect(function(p18) -- Line: 187
        -- upvalues: anchorTo (ref)
        if p18.Name == "Notifications" and p18:IsA("ScreenGui") then
            anchorTo(p18);
        end;
    end);
end);

local function howl() -- Line: 195
    -- upvalues: BloodMoonConfig (copy), SoundService (copy), Debris (copy)
    local Sound = Instance.new("Sound");
    Sound.SoundId = BloodMoonConfig.Howl;
    Sound.Volume = 0.7;
    Sound.Parent = SoundService;
    Sound:Play();
    Debris:AddItem(Sound, 12);
end;

local u19;

if Session:GetAttribute("BloodMoon") == true then
    u19 = LocalPlayer:GetAttribute("BloodMoonHidden") ~= true;
else
    u19 = false;
end;

local function changed() -- Line: 204
    -- upvalues: Session (copy), LocalPlayer (copy), u19 (ref), showBanner (copy), BloodMoonConfig (copy), Color3_fromRGB_ret (copy), Color3_fromRGB_ret3 (copy), SoundService (copy), Debris (copy)
    local v20;

    if Session:GetAttribute("BloodMoon") == true then
        v20 = LocalPlayer:GetAttribute("BloodMoonHidden") ~= true;
    else
        v20 = false;
    end;

    if v20 == u19 then
        return;
    end;

    u19 = v20;

    if v20 then
        local Attribute = Session:GetAttribute("BloodMoonEndsAt");
        local v21;

        if type(Attribute) == "number" then
            local v22 = Attribute - workspace:GetServerTimeNow();
            local math_ceil_ret = math.ceil(v22);
            local math_max_ret = math.max(0, math_ceil_ret);
            v21 = "  ·  " .. string.format("%d:%02d", math_max_ret // 60, math_max_ret % 60);
        else
            v21 = "";
        end;

        showBanner("THE BLOOD MOON RISES", "Haunts rise more often  ·  Round candy ×" .. BloodMoonConfig.CandyMultiplier .. v21, Color3_fromRGB_ret);

        return;
    end;

    showBanner("THE BLOOD MOON SETS", "The night is calm again.", Color3_fromRGB_ret3);
    local Sound = Instance.new("Sound");
    Sound.SoundId = BloodMoonConfig.Howl;
    Sound.Volume = 0.7;
    Sound.Parent = SoundService;
    Sound:Play();
    Debris:AddItem(Sound, 12);
end;

Session:GetAttributeChangedSignal("BloodMoon"):Connect(changed);
LocalPlayer:GetAttributeChangedSignal("BloodMoonHidden"):Connect(changed);

if u19 then
    task.delay(4, function() -- Line: 223
        -- upvalues: Session (copy), LocalPlayer (copy), showBanner (copy), BloodMoonConfig (copy), Color3_fromRGB_ret (copy)
        local v23;

        if Session:GetAttribute("BloodMoon") == true then
            v23 = LocalPlayer:GetAttribute("BloodMoonHidden") ~= true;
        else
            v23 = false;
        end;

        if v23 then
            local Attribute = Session:GetAttribute("BloodMoonEndsAt");
            local CandyMultiplier = BloodMoonConfig.CandyMultiplier;
            local v24;

            if type(Attribute) == "number" then
                local v25 = Attribute - workspace:GetServerTimeNow();
                local math_ceil_ret = math.ceil(v25);
                local math_max_ret = math.max(0, math_ceil_ret);
                v24 = "  ·  " .. string.format("%d:%02d", math_max_ret // 60, math_max_ret % 60) .. " left";
            else
                v24 = "";
            end;

            showBanner("THE BLOOD MOON IS UP", "Haunts rise more often  ·  Round candy ×" .. CandyMultiplier .. v24, Color3_fromRGB_ret);
        end;
    end);
end;

task.spawn(function() -- Line: 230
    -- upvalues: refreshLine (copy)
    while true do
        task.wait(0.5);
        refreshLine();
    end;
end);

local function burst(p26) -- Line: 238
    -- upvalues: Color3_fromRGB_ret (copy), Color3_fromRGB_ret2 (copy), Debris (copy)
    local Attachment = Instance.new("Attachment");
    Attachment.WorldPosition = p26;
    Attachment.Parent = workspace.Terrain;
    local ParticleEmitter = Instance.new("ParticleEmitter");
    ParticleEmitter.Texture = "rbxasset://textures/particles/smoke_main.dds";
    ParticleEmitter.Color = ColorSequence.new(Color3_fromRGB_ret, Color3_fromRGB_ret2);
    ParticleEmitter.LightEmission = 0.6;
    ParticleEmitter.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1.2), NumberSequenceKeypoint.new(1, 3.5) });
    ParticleEmitter.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.25), NumberSequenceKeypoint.new(1, 1) });
    ParticleEmitter.Lifetime = NumberRange.new(0.5, 0.9);
    ParticleEmitter.Speed = NumberRange.new(6, 14);
    ParticleEmitter.SpreadAngle = Vector2.new(180, 180);
    ParticleEmitter.Drag = 4;
    ParticleEmitter.Rate = 0;
    ParticleEmitter.Parent = Attachment;
    ParticleEmitter:Emit(26);
    Debris:AddItem(Attachment, 1.5);
end;

local function flash(p27) -- Line: 257
    -- upvalues: Color3_fromRGB_ret (copy), Color3_fromRGB_ret2 (copy), TweenService (copy), Debris (copy)
    local Highlight = Instance.new("Highlight");
    Highlight.Name = "BloodMoonFlash";
    Highlight.FillColor = Color3_fromRGB_ret;
    Highlight.OutlineColor = Color3_fromRGB_ret2;
    Highlight.FillTransparency = 0.25;
    Highlight.OutlineTransparency = 0;
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.Parent = p27;
    TweenService:Create(Highlight, TweenInfo.new(0.9, Enum.EasingStyle.Quad, Enum.EasingDirection.In, 0, false, 0.3), {
        FillTransparency = 1,
        OutlineTransparency = 1
    }):Play();
    Debris:AddItem(Highlight, 1.4);
end;

local u28 = setmetatable({}, {
    __mode = "k"
});

local function watch(u29) -- Line: 270
    -- upvalues: u28 (copy), Session (copy), LocalPlayer (copy), flash (copy), burst (copy)
    if u28[u29] then
        return;
    end;

    u28[u29] = u29:GetAttributeChangedSignal("Ragdolled"):Connect(function() -- Line: 274
        -- upvalues: Session (ref), LocalPlayer (ref), u29 (copy), flash (ref), burst (ref)
        local v30;

        if Session:GetAttribute("BloodMoon") == true then
            v30 = LocalPlayer:GetAttribute("BloodMoonHidden") ~= true;
        else
            v30 = false;
        end;

        local v31 = v30 and u29:GetAttribute("Ragdolled") == true and (u29:FindFirstChild("Torso") or u29:FindFirstChild("HumanoidRootPart"));

        if v31 then
            flash(u29);
            burst(v31.Position);
        end;
    end);
    u29.Destroying:Connect(function() -- Line: 283
        -- upvalues: u28 (ref), u29 (copy)
        local v32 = u28[u29];

        if v32 then
            v32:Disconnect();
            u28[u29] = nil;
        end;
    end);
end;

local function added(p33) -- Line: 291
    -- upvalues: watch (copy)
    if p33.Character then
        watch(p33.Character);
    end;

    p33.CharacterAdded:Connect(watch);
end;

for _, v in Players:GetPlayers() do
    if v.Character then
        watch(v.Character);
    end;

    v.CharacterAdded:Connect(watch);
end;

Players.PlayerAdded:Connect(added);
ClientBotKnockdown.onDown(function(p34) -- Line: 302
    -- upvalues: Session (copy), LocalPlayer (copy), burst (copy)
    local v35;

    if Session:GetAttribute("BloodMoon") == true then
        v35 = LocalPlayer:GetAttribute("BloodMoonHidden") ~= true;
    else
        v35 = false;
    end;

    if v35 and typeof(p34) == "Vector3" then
        burst(p34);
    end;
end);