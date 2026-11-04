 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local LocalPlayer = game:GetService("Players").LocalPlayer;
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local Knit = require(ReplicatedStorage.Packages.Knit);
local Trove = require(ReplicatedStorage.Packages.Trove);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local StyleQuests = require(ReplicatedStorage.Shared.Tables.StyleQuests);
local StyleQuestMilestone = require(ReplicatedStorage.Shared.Tables.StyleQuestMilestone);
local script_StyleQuestsFrontEnd = require(script.StyleQuestsFrontEnd);
local Customization = require(ReplicatedStorage.Shared.Tables.Customization);
local Rarities = require(ReplicatedStorage.Shared.Tables.Rarities);
local Content = LocalPlayer.PlayerGui:WaitForChild("StyleQuests"):WaitForChild("Content");
local u1 = Trove.new();

local function deep_equals(p2, p3, p4) -- Line: 24
    -- upvalues: deep_equals (copy)
    if p2 == p3 then
        return true;
    end;

    local v5 = type(p2);

    if v5 ~= type(p3) then
        return false;
    end;

    if v5 ~= "table" then
        return false;
    end;

    if not p4 then
        local v6 = getmetatable(p2);

        if v6 and v6.__eq then
            return p2 == p3;
        end;
    end;

    for i, v in pairs(p2) do
        local v7 = p3[i];

        if v7 == nil or deep_equals(v, v7, p4) == false then
            return false;
        end;
    end;

    for i, _ in pairs(p3) do
        if p2[i] == nil then
            return false;
        end;
    end;

    return true;
end;

local u8 = Knit.CreateController({
    Name = "StyleQuestsController"
});
local CloseButton = Content:WaitForChild("CloseButton");
local ParticlesMask = Content:WaitForChild("ParticlesMask");
local StarTemplate = ParticlesMask:WaitForChild("StarTemplate");
StarTemplate.Visible = false;
local ImageTransparency = StarTemplate.ImageTransparency;
local SunburstMask = Content:WaitForChild("SunburstMask");
local Sunburst = SunburstMask:WaitForChild("Sunburst");
local SunburstCounter = SunburstMask:WaitForChild("SunburstCounter");
local Bg = Content:WaitForChild("Bg");
local UIGradient = Bg:WaitForChild("UIGradient");
local TitleFrame = Content:WaitForChild("TitleFrame");
local UIGradient2 = TitleFrame:WaitForChild("VertLine"):WaitForChild("UIGradient");
local UIGradient3 = TitleFrame:WaitForChild("HorizontalLine"):WaitForChild("UIGradient");
local SideTextMask = TitleFrame:WaitForChild("SideTextMask");
local TextLabelTemplate = SideTextMask:WaitForChild("TextLabelTemplate");
TextLabelTemplate.Visible = false;
local TextFrame = TitleFrame:WaitForChild("TextFrame");
local TitleFrame2 = TextFrame:WaitForChild("TitleFrame");
local Title = TitleFrame2:WaitForChild("Title");
local TitleDs = TitleFrame2:WaitForChild("TitleDs");
local CanvasGroup = Content:WaitForChild("QuestsFrame"):WaitForChild("CanvasGroup");
local UIGradient4 = CanvasGroup:WaitForChild("UIGradient");
local ScrollingFrame = CanvasGroup:WaitForChild("ScrollingFrame");
local Template = ScrollingFrame:WaitForChild("Template");
Template.Visible = false;
local ScrollingFrame2 = Content:WaitForChild("CategoryFrame"):WaitForChild("CanvasGroup"):WaitForChild("ScrollingFrame");
local ButtonTemplate = ScrollingFrame2:WaitForChild("ButtonTemplate");
ButtonTemplate.Visible = false;
local u9 = {
    Token = 0,
    Container = Content:FindFirstChild("RewardContainer", true)
};
local Position = Bg.Position;
local Position2 = TextFrame.Position;
local Position3 = Sunburst.Position;
local Position4 = SunburstCounter.Position;
local u10 = {
    CATEGORY_ORDER = { "General", "Ninja" },
    BGMASK_SLIDE_TIME = 0.55,
    BGMASK_SLIDE_STAGGER = 0.07,
    BGMASK_START_OFFSET = 1.15,
    BGMASK_DRIFT = 0.05,
    BGMASK_DRIFT_MIN_TIME = 2.4,
    BGMASK_DRIFT_MAX_TIME = 3.6,
    BGMASK2_PARALLAX = 0.55,
    STAR_PREFILL = 7,
    STAR_MIN_DELAY = 0.35,
    STAR_MAX_DELAY = 0.95,
    STAR_MIN_RISE_TIME = 4.5,
    STAR_MAX_RISE_TIME = 9,
    STAR_MIN_SPIN_TIME = 6,
    STAR_MAX_SPIN_TIME = 14,
    STAR_MIN_SCALE = 0.45,
    STAR_MAX_SCALE = 1.1,
    STAR_SPAWN_Y = 1.15,
    STAR_DESPAWN_Y = -0.15,
    STAR_BURST_COUNT = 9,
    STAR_BURST_STAGGER = 0.035,
    STAR_FADE_IN_TIME = 0.55,
    STAR_FADE_OUT_TIME = 0.9,
    SUNBURSTMASK_SLIDE_TIME = 0.55,
    SUNBURSTMASK_SLIDE_STAGGER = 0.07,
    SUNBURSTMASK_START_OFFSET = 1.15,
    SUNBURSTMASK_DRIFT = 0.05,
    SUNBURSTMASK_DRIFT_MIN_TIME = 2.4,
    SUNBURSTMASK_DRIFT_MAX_TIME = 3.6,
    SUNBURSTMASK2_PARALLAX = 0.55,
    SUNBURST_SPIN_TIME = 14,
    SUNBURST_COUNTER_SPIN_TIME = 22,
    SUNBURST_KICK_TIME = 1.4,
    SUNBURST_KICK_DEGREES = 200,
    SUNBURST_INTRO_SCALE = 1.35,
    SUNBURST_BREATHE_TIME = 3.2,
    SUNBURST_BREATHE_SCALE = 1.035,
    BG_SWOOP_TIME = 0.6,
    BG_SWOOP_START_OFFSET = 1.05,
    HERO_INTRO_TIME = 0.4,
    HERO_PARTICLE_START_DELAY = 0.1,
    HERO_EXIT_TIME = 0.32,
    HERO_EXIT_OFFSET = 1.15
};
u10.HERO_INTRO_INFO = TweenInfo.new(u10.HERO_INTRO_TIME, Enum.EasingStyle.Back, Enum.EasingDirection.Out);
u10.HERO_SLIDE_OUT_INFO = TweenInfo.new(u10.HERO_EXIT_TIME, Enum.EasingStyle.Quart, Enum.EasingDirection.In);
u10.PAGE_SWAP_DELAY = 0.24;
u10.COLOR_TWEEN_INFO = TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
u10.TITLE_POP_OUT_INFO = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.In);
u10.TITLE_POP_IN_INFO = TweenInfo.new(0.32, Enum.EasingStyle.Back, Enum.EasingDirection.Out);
u10.PARTICLE_MIN_TIME = 1.2;
u10.PARTICLE_MAX_TIME = 2.6;
u10.PARTICLE_MIN_RISE = 5;
u10.PARTICLE_MAX_RISE = 14;
u10.PARTICLE_DRIFT = 4;
u10.PARTICLE_SCALE = 0.06;
u10.PARTICLE_ROTATION = 5;
u10.LINE_DRAW_TIME = 0.65;
u10.LINE_DRAW_EASING_STYLE = Enum.EasingStyle.Quint;
u10.LINE_DRAW_EASING_DIRECTION = Enum.EasingDirection.Out;
u10.LINE_DRAW_SOFTNESS = 0.05;
u10.LINE_DRAW_STAGGER = 0.1;
u10.LINE_DRAW_START_DELAY = 0.55;
u10.LINE_ERASE_TIME = 0.22;
u10.TEXT_FRAME_INTRO_TIME = 0.5;
u10.TEXT_FRAME_START_Y_OFFSET = -0.6;
u10.HOLDER_FADE_TIME = 0.32;
u10.BG_SWOOP_EXIT_TIME = 0.28;
u10.TEXT_FRAME_EXIT_TIME = 0.24;
u10.HERO_EXIT_SCALE_TIME = 0.2;
u10.QUEST_EXIT_INFO = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.In);
u10.CAROUSEL_SPACING = 0.52;
u10.CAROUSEL_SPEED = 0.12;
u10.CAROUSEL_START_X = -0.65;
u10.CAROUSEL_FINISH_X = 1.65;
u10.QUEST_ENTRY_REVEAL_INFO = TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out);
u10.QUEST_FILL_INFO = TweenInfo.new(0.55, Enum.EasingStyle.Quint, Enum.EasingDirection.Out);
u10.QUEST_ENTRY_STAGGER = 0.07;
u10.CATEGORY_REVEAL_INFO = TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out);
u10.CATEGORY_REVEAL_STAGGER = 0.06;
u10.CATEGORY_REVEAL_DELAY = 0.2;
u10.SCROLL_BAR_THICKNESS = 3;
u10.BUTTON_HOVER_SCALE = 1.08;
u10.BUTTON_PRESS_SCALE = 0.94;
u10.BUTTON_HOVER_INFO = TweenInfo.new(0.16, Enum.EasingStyle.Back, Enum.EasingDirection.Out);
u10.BUTTON_LEAVE_INFO = TweenInfo.new(0.14, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
u10.BUTTON_PRESS_INFO = TweenInfo.new(0.07, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
u10.BUTTON_RELEASE_INFO = TweenInfo.new(0.18, Enum.EasingStyle.Back, Enum.EasingDirection.Out);
u10.NAV_ACTIVE_COLOR = Color3.fromRGB(255, 255, 255);
u10.NAV_INACTIVE_COLOR = Color3.fromRGB(108, 108, 108);
u10.NAV_ACTIVE_CONTENT_TRANSPARENCY = 0;
u10.NAV_INACTIVE_CONTENT_TRANSPARENCY = 0.25;
u10.NAV_STATE_TWEEN_INFO = TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
u10.CLAIMED_BG_IMAGE = "rbxassetid://94412427368421";
u10.CLAIMED_PROGRESS_IMAGE = "rbxassetid://136839331952002";
u10.CLAIMED_TEXT_COLOR = Color3.fromRGB(0, 255, 0);
u10.TITLE_GRADIENT_DARKEN = 0.7;
u10.CATEGORY_END_PADDING = 64;
u10.QUEST_END_PADDING = 32;
u10.REWARD_END_PADDING = 24;
u10.REWARD_EXIT_OFFSET = 1.15;
u10.REWARD_INTRO_DELAY = 0.12;
u10.REWARD_INTRO_INFO = TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out);
u10.REWARD_EXIT_INFO = TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In);
u10.DEFAULT_BG_IMAGE = Template:WaitForChild("Bg").Image;
u10.DEFAULT_BG_COLOR = Template:WaitForChild("Bg").ImageColor3;
u10.DEFAULT_QUEST_TITLE_COLOR = Template:WaitForChild("QuestTitle").TextColor3;
u10.DEFAULT_PROGRESS_TEXT_COLOR = Template:WaitForChild("Progress").TextColor3;
u10.DEFAULT_PROGRESS_IMAGE = Template:WaitForChild("ProgressBar"):WaitForChild("Fill"):WaitForChild("ImageLabel").Image;
u10.DEFAULT_PROGRESS_FILL_COLOR = Template:WaitForChild("ProgressBar"):WaitForChild("Fill"):WaitForChild("ImageLabel").BackgroundColor3;
local u11 = {};
local v12 = {};
local u13 = false;
local u14 = 0;
local u15 = 0;
local u16 = false;

for _, v in u10.CATEGORY_ORDER do
    if script_StyleQuestsFrontEnd[v] then
        table.insert(u11, v);
        v12[v] = true;
    end;
end;

local v17 = {};

for i in script_StyleQuestsFrontEnd do
    if not v12[i] then
        table.insert(v17, i);
    end;
end;

table.sort(v17);

for _, v in v17 do
    table.insert(u11, v);
end;

local u18 = u11[1];
local u19 = u18;
local u20 = {};
local u21 = {};
local u22 = {};
local u23 = nil;
local u24 = {};
local u25 = {};
local u26 = nil;
local u27 = {};
local u28 = {};
local u29 = {};
local u30 = {};
local u31 = {};

local function Tween(p32, p33, p34) -- Line: 304
    -- upvalues: TweenService (copy)
    local v35 = TweenService:Create(p32, p33, p34);
    v35:Play();

    return v35;
end;

local function GetScale(p36) -- Line: 310
    local v37 = p36:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
    v37.Parent = p36;

    return v37;
end;

local function IsCurrentSequence(p38) -- Line: 316
    -- upvalues: u13 (ref), u15 (ref)
    return u13 and p38 == u15;
end;

local function IsCurrentPage(p39, p40) -- Line: 320
    -- upvalues: u13 (ref), u15 (ref), u14 (ref)
    local v41 = u13;

    if v41 then
        if p39 == u15 then
            v41 = p40 == u14;
        else
            v41 = false;
        end;
    end;

    return v41;
end;

local function OffsetPositionX(p42, p43) -- Line: 324
    return UDim2.new(p42.X.Scale + p43, p42.X.Offset, p42.Y.Scale, p42.Y.Offset);
end;

local function OffsetPositionY(p44, p45) -- Line: 328
    return UDim2.new(p44.X.Scale, p44.X.Offset, p44.Y.Scale + p45, p44.Y.Offset);
end;

local function SrgbToLinear(p46) -- Line: 333
    if p46 <= 0.04045 then
        return p46 / 12.92;
    end;

    return ((p46 + 0.055) / 1.055) ^ 2.4;
end;

local function LinearToSrgb(p47) -- Line: 341
    local math_max_ret = math.max(p47, 0);

    if math_max_ret <= 0.0031308 then
        return math_max_ret * 12.92;
    end;

    return 1.055 * math_max_ret ^ 0.4166666666666667 - 0.055;
end;

local function CubeRoot(p48) -- Line: 351
    return math.sign(p48) * math.abs(p48) ^ 0.3333333333333333;
end;

local function ColorToOklab(p49) -- Line: 355
    local R = p49.R;
    local v50;

    if R <= 0.04045 then
        v50 = R / 12.92;
    else
        v50 = ((R + 0.055) / 1.055) ^ 2.4;
    end;

    local G = p49.G;
    local v51;

    if G <= 0.04045 then
        v51 = G / 12.92;
    else
        v51 = ((G + 0.055) / 1.055) ^ 2.4;
    end;

    local B = p49.B;
    local v52;

    if B <= 0.04045 then
        v52 = B / 12.92;
    else
        v52 = ((B + 0.055) / 1.055) ^ 2.4;
    end;

    local v53 = 0.4122214708 * v50 + 0.5363325363 * v51 + 0.0514459929 * v52;
    local v54 = math.sign(v53) * math.abs(v53) ^ 0.3333333333333333;
    local v55 = 0.2119034982 * v50 + 0.6806995451 * v51 + 0.1073969566 * v52;
    local v56 = math.sign(v55) * math.abs(v55) ^ 0.3333333333333333;
    local v57 = 0.0883024619 * v50 + 0.2817188376 * v51 + 0.6299787005 * v52;
    local v58 = math.sign(v57) * math.abs(v57) ^ 0.3333333333333333;

    return Vector3.new(0.2104542553 * v54 + 0.793617785 * v56 - 0.0040720468 * v58, 1.9779984951 * v54 - 2.428592205 * v56 + 0.4505937099 * v58, 0.0259040371 * v54 + 0.7827717662 * v56 - 0.808675766 * v58);
end;

local function OklabToColor(p59) -- Line: 371
    local v60 = (p59.X + 0.3963377774 * p59.Y + 0.2158037573 * p59.Z) ^ 3;
    local v61 = (p59.X - 0.1055613458 * p59.Y - 0.0638541728 * p59.Z) ^ 3;
    local v62 = (p59.X - 0.0894841775 * p59.Y - 1.291485548 * p59.Z) ^ 3;
    local Color3_new = Color3.new;
    local math_max_ret = math.max(4.0767416621 * v60 - 3.3077115913 * v61 + 0.2309699292 * v62, 0);
    local v63;

    if math_max_ret <= 0.0031308 then
        v63 = math_max_ret * 12.92;
    else
        v63 = 1.055 * math_max_ret ^ 0.4166666666666667 - 0.055;
    end;

    local math_clamp_ret = math.clamp(v63, 0, 1);
    local math_max_ret2 = math.max(-1.2684380046 * v60 + 2.6097574011 * v61 - 0.3413193965 * v62, 0);
    local v64;

    if math_max_ret2 <= 0.0031308 then
        v64 = math_max_ret2 * 12.92;
    else
        v64 = 1.055 * math_max_ret2 ^ 0.4166666666666667 - 0.055;
    end;

    local math_clamp_ret2 = math.clamp(v64, 0, 1);
    local math_max_ret3 = math.max(-0.0041960863 * v60 - 0.7034186147 * v61 + 1.707614701 * v62, 0);
    local v65;

    if math_max_ret3 <= 0.0031308 then
        v65 = math_max_ret3 * 12.92;
    else
        v65 = 1.055 * math_max_ret3 ^ 0.4166666666666667 - 0.055;
    end;

    return Color3_new(math_clamp_ret, math_clamp_ret2, (math.clamp(v65, 0, 1)));
end;

local u66 = { "BgOne", "BgTwo", "SunburstMain", "SunburstCounter" };
local u67 = {
    BgOne = UIGradient.Color.Keypoints[1].Value,
    BgTwo = UIGradient.Color.Keypoints[#UIGradient.Color.Keypoints].Value,
    SunburstMain = Sunburst.ImageColor3,
    SunburstCounter = SunburstCounter.ImageColor3
};
local u68 = {};
local u69 = {};
local NumberValue = Instance.new("NumberValue");
NumberValue.Name = "PageColorAlpha";
NumberValue.Value = 1;
NumberValue.Parent = Bg;
local u70 = nil;

local function ApplyPageColors(p71) -- Line: 407
    -- upvalues: u66 (copy), u68 (copy), u69 (copy), u67 (copy), OklabToColor (copy), UIGradient (copy), Sunburst (copy), SunburstCounter (copy), u9 (copy)
    for _, v in u66 do
        local v72 = u68[v];
        local v73 = u69[v];

        if v72 and v73 then
            u67[v] = OklabToColor(v72:Lerp(v73, p71));
        end;
    end;

    UIGradient.Color = ColorSequence.new(u67.BgOne, u67.BgTwo);
    Sunburst.ImageColor3 = u67.SunburstMain;
    SunburstCounter.ImageColor3 = u67.SunburstCounter;

    if u9.CanTint then
        u9.Container.ImageColor3 = u67.SunburstMain;
    end;
end;

NumberValue.Changed:Connect(ApplyPageColors);

local function SetPageColors(p74, p75) -- Line: 428
    -- upvalues: u70 (ref), u66 (copy), u68 (copy), ColorToOklab (copy), u67 (copy), u69 (copy), NumberValue (copy), ApplyPageColors (copy), u10 (copy), TweenService (copy)
    if u70 then
        u70:Cancel();
        u70 = nil;
    end;

    local v76 = {
        BgOne = p74.Bg.ColorOne,
        BgTwo = p74.Bg.ColorTwo,
        SunburstMain = p74.Sunburst.Main,
        SunburstCounter = p74.Sunburst.Counter
    };

    for _, v in u66 do
        u68[v] = ColorToOklab(u67[v]);
        u69[v] = ColorToOklab(v76[v]);
    end;

    if not p75 then
        for _, v in u66 do
            u67[v] = v76[v];
        end;

        NumberValue.Value = 1;
        ApplyPageColors(1);

        return;
    end;

    NumberValue.Value = 0;
    local v77 = TweenService:Create(NumberValue, u10.COLOR_TWEEN_INFO, {
        Value = 1
    });
    v77:Play();
    u70 = v77;
end;

local function SetPageTitle(u78, p79, u80) -- Line: 460
    -- upvalues: TitleFrame2 (copy), Title (copy), TitleDs (copy), u10 (copy), TweenService (copy), u14 (ref)
    local v81 = TitleFrame2;
    local u82 = v81:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
    u82.Parent = v81;

    local function ApplyText() -- Line: 463
        -- upvalues: Title (ref), u78 (copy), TitleDs (ref)
        Title.Text = u78;
        TitleDs.Text = u78;
    end;

    if p79 then
        local v83 = TweenService:Create(u82, u10.TITLE_POP_OUT_INFO, {
            Scale = 0
        });
        v83:Play();
        v83.Completed:Once(function() -- Line: 474
            -- upvalues: u80 (copy), u14 (ref), Title (ref), u78 (copy), TitleDs (ref), u82 (copy), u10 (ref), TweenService (ref)
            if u80 ~= u14 then
                return;
            end;

            Title.Text = u78;
            TitleDs.Text = u78;
            TweenService:Create(u82, u10.TITLE_POP_IN_INFO, {
                Scale = 1
            }):Play();
        end);

        return;
    end;

    u82.Scale = 1;
    Title.Text = u78;
    TitleDs.Text = u78;
end;

local function GetNaturalContentSize(p84, p85, p86, p87) -- Line: 485
    local v88 = 0;

    for _, child in p84:GetChildren() do
        if child:IsA("GuiObject") and (child.Visible and child ~= p85) then
            v88 = v88 + 1;
        end;
    end;

    if v88 == 0 then
        return 0;
    end;

    local AbsoluteWindowSize = p84.AbsoluteWindowSize;
    local v89 = p87 and p85.AbsoluteSize.Y or p85.AbsoluteSize.X;

    if v89 <= 0 then
        return p87 and p86.AbsoluteContentSize.Y or p86.AbsoluteContentSize.X;
    end;

    return v88 * v89 + (v88 - 1) * (p86.Padding.Offset + p86.Padding.Scale * (p87 and AbsoluteWindowSize.Y or AbsoluteWindowSize.X));
end;

(function(u90) -- Line: 510, Name: BindQuestScroll
    -- upvalues: GetNaturalContentSize (copy), Template (copy), UIGradient4 (copy), u10 (copy)
    local u91 = u90:FindFirstChildOfClass("UIListLayout");
    local u92 = u90:FindFirstChildOfClass("UIPadding");

    if not u91 then
        warn("StyleQuestsController:", u90:GetFullName(), "requires a UIListLayout");

        return;
    end;

    u90.AutomaticCanvasSize = Enum.AutomaticSize.None;
    u90.ScrollingDirection = Enum.ScrollingDirection.Y;
    u90.VerticalScrollBarInset = Enum.ScrollBarInset.None;

    local function Update() -- Line: 523
        -- upvalues: GetNaturalContentSize (ref), u90 (copy), Template (ref), u91 (copy), u92 (copy), UIGradient4 (ref), u10 (ref)
        local v93 = GetNaturalContentSize(u90, Template, u91, true);

        if u92 then
            v93 = v93 + (u92.PaddingTop.Offset + u92.PaddingBottom.Offset);
        end;

        local v94 = u90.AbsoluteWindowSize.Y + 1 < v93;
        UIGradient4.Enabled = v94;

        if v94 then
            v93 = v93 + u10.QUEST_END_PADDING or v93;
        end;

        u90.CanvasSize = UDim2.fromOffset(0, v93);
        u90.ScrollingEnabled = v94;
        u90.ScrollBarThickness = v94 and u10.SCROLL_BAR_THICKNESS or 0;

        if not v94 then
            u90.CanvasPosition = Vector2.zero;
        end;
    end;

    Update();
    u91:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(Update);
    u90:GetPropertyChangedSignal("AbsoluteWindowSize"):Connect(Update);
    Template:GetPropertyChangedSignal("AbsoluteSize"):Connect(Update);
    u90.ChildAdded:Connect(Update);
    u90.ChildRemoved:Connect(Update);
end)(ScrollingFrame);
ScrollingFrame2.ScrollingDirection = Enum.ScrollingDirection.X;
ScrollingFrame2.AutomaticCanvasSize = Enum.AutomaticSize.None;
ScrollingFrame2.CanvasPosition = Vector2.zero;
local u95 = ScrollingFrame2:FindFirstChildOfClass("UIListLayout");
local u96 = ScrollingFrame2:FindFirstChildOfClass("UIPadding");

local function UpdateCategoryCanvas() -- Line: 561
    -- upvalues: u95 (copy), GetNaturalContentSize (copy), ScrollingFrame2 (copy), ButtonTemplate (copy), u96 (copy), u10 (copy)
    if not u95 then
        return;
    end;

    local v97 = GetNaturalContentSize(ScrollingFrame2, ButtonTemplate, u95, false);

    if u96 then
        v97 = v97 + (u96.PaddingLeft.Offset + u96.PaddingRight.Offset);
    end;

    if ScrollingFrame2.AbsoluteWindowSize.X + 1 < v97 then
        v97 = v97 + u10.CATEGORY_END_PADDING or v97;
    end;

    ScrollingFrame2.CanvasSize = UDim2.fromOffset(v97, 0);
end;

if u95 then
    u95:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(UpdateCategoryCanvas);
    ButtonTemplate:GetPropertyChangedSignal("AbsoluteSize"):Connect(UpdateCategoryCanvas);
    ScrollingFrame2.ChildAdded:Connect(UpdateCategoryCanvas);
    ScrollingFrame2.ChildRemoved:Connect(UpdateCategoryCanvas);
else
    warn("StyleQuestsController:", ScrollingFrame2:GetFullName(), "has no UIListLayout, cannot size the canvas");
end;

ScrollingFrame2:GetPropertyChangedSignal("AbsoluteSize"):Connect(UpdateCategoryCanvas);
UpdateCategoryCanvas();

local function LockCategoryToX() -- Line: 589
    -- upvalues: ScrollingFrame2 (copy)
    if ScrollingFrame2.ScrollingDirection ~= Enum.ScrollingDirection.X then
        ScrollingFrame2.ScrollingDirection = Enum.ScrollingDirection.X;
    end;

    if ScrollingFrame2.CanvasSize.Y.Scale ~= 0 or ScrollingFrame2.CanvasSize.Y.Offset ~= 0 then
        ScrollingFrame2.CanvasSize = UDim2.new(ScrollingFrame2.CanvasSize.X.Scale, ScrollingFrame2.CanvasSize.X.Offset, 0, 0);
    end;

    if ScrollingFrame2.CanvasPosition.Y ~= 0 then
        ScrollingFrame2.CanvasPosition = Vector2.new(ScrollingFrame2.CanvasPosition.X, 0);
    end;
end;

ScrollingFrame2:GetPropertyChangedSignal("CanvasPosition"):Connect(LockCategoryToX);
ScrollingFrame2:GetPropertyChangedSignal("CanvasSize"):Connect(LockCategoryToX);
ScrollingFrame2:GetPropertyChangedSignal("ScrollingDirection"):Connect(LockCategoryToX);

local function StartDriftLoop(u98, u99, u100, u101, u102, u103) -- Line: 608
    -- upvalues: TweenService (copy)
    return task.spawn(function() -- Line: 609
        -- upvalues: u103 (copy), u101 (copy), u102 (copy), u100 (copy), u98 (copy), u99 (copy), TweenService (ref)
        local Random_new = Random.new;
        local v104 = os.clock() * 1000000;
        local v105 = Random_new(math.floor(v104) + math.random(1, 100000));
        local v106;

        if v105:NextInteger(0, 1) == 0 then
            v106 = true;
        else
            v106 = false;
        end;

        while u103() do
            local v107 = v105:NextNumber(u101, u102);
            local v108 = v105:NextNumber(u100 * 0.5, u100);
            local TweenInfo_new_ret = TweenInfo.new(v107, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
            local v109 = {};

            if v106 then
                v108 = -v108 or v108;
            end;

            v109.Position = UDim2.new(u99.X.Scale, u99.X.Offset, u99.Y.Scale + v108, u99.Y.Offset);
            local v110 = TweenService:Create(u98, TweenInfo_new_ret, v109);
            v110:Play();
            v110.Completed:Wait();
            v106 = not v106;
        end;
    end);
end;

local function CreateMaskIntro(u111) -- Line: 636
    -- upvalues: u13 (ref), u15 (ref), TweenService (copy)
    local u112 = nil;
    local u113 = nil;
    local u114 = 0;

    local function StopDrift() -- Line: 641
        -- upvalues: u112 (ref), u113 (ref)
        if u112 then
            task.cancel(u112);
            u112 = nil;
        end;

        if u113 then
            task.cancel(u113);
            u113 = nil;
        end;
    end;

    return {
        Reset = function() -- Line: 653, Name: Reset
            -- upvalues: u114 (ref), u112 (ref), u113 (ref), u111 (copy)
            u114 = u114 + 1;

            if u112 then
                task.cancel(u112);
                u112 = nil;
            end;

            if u113 then
                task.cancel(u113);
                u113 = nil;
            end;

            local TargetA = u111.TargetA;
            u111.ImageA.Position = UDim2.new(TargetA.X.Scale + u111.StartOffset, TargetA.X.Offset, TargetA.Y.Scale, TargetA.Y.Offset);
            local TargetB = u111.TargetB;
            u111.ImageB.Position = UDim2.new(TargetB.X.Scale + -u111.StartOffset, TargetB.X.Offset, TargetB.Y.Scale, TargetB.Y.Offset);
        end,

        Play = function(u115) -- Line: 661, Name: Play
            -- upvalues: u114 (ref), u112 (ref), u113 (ref), u111 (copy), u13 (ref), u15 (ref), TweenService (ref)
            u114 = u114 + 1;

            if u112 then
                task.cancel(u112);
                u112 = nil;
            end;

            if u113 then
                task.cancel(u113);
                u113 = nil;
            end;

            local TargetA = u111.TargetA;
            u111.ImageA.Position = UDim2.new(TargetA.X.Scale + u111.StartOffset, TargetA.X.Offset, TargetA.Y.Scale, TargetA.Y.Offset);
            local TargetB = u111.TargetB;
            u111.ImageB.Position = UDim2.new(TargetB.X.Scale + -u111.StartOffset, TargetB.X.Offset, TargetB.Y.Scale, TargetB.Y.Offset);
            local u116 = u114;

            local function IsStillValid() -- Line: 666
                -- upvalues: u116 (copy), u114 (ref), u115 (copy), u13 (ref), u15 (ref)
                local v117;

                if u116 == u114 then
                    v117 = u13 and u115 == u15;
                else
                    v117 = false;
                end;

                return v117;
            end;

            local v118 = TweenService:Create(u111.ImageA, TweenInfo.new(u111.SlideTime, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                Position = u111.TargetA
            });
            v118:Play();
            v118.Completed:Once(function() -- Line: 676
                -- upvalues: u116 (copy), u114 (ref), u115 (copy), u13 (ref), u15 (ref), u112 (ref), u111 (ref), IsStillValid (copy), TweenService (ref)
                local v119;

                if u116 == u114 then
                    v119 = u13 and u115 == u15;
                else
                    v119 = false;
                end;

                if v119 then
                    local ImageA = u111.ImageA;
                    local TargetA2 = u111.TargetA;
                    local DriftAmount = u111.DriftAmount;
                    local DriftMinTime = u111.DriftMinTime;
                    local DriftMaxTime = u111.DriftMaxTime;
                    local u120 = IsStillValid;
                    u112 = task.spawn(function() -- Line: 609
                        -- upvalues: u120 (copy), DriftMinTime (copy), DriftMaxTime (copy), DriftAmount (copy), ImageA (copy), TargetA2 (copy), TweenService (ref)
                        local Random_new = Random.new;
                        local v121 = os.clock() * 1000000;
                        local v122 = Random_new(math.floor(v121) + math.random(1, 100000));
                        local v123;

                        if v122:NextInteger(0, 1) == 0 then
                            v123 = true;
                        else
                            v123 = false;
                        end;

                        while u120() do
                            local v124 = v122:NextNumber(DriftMinTime, DriftMaxTime);
                            local v125 = v122:NextNumber(DriftAmount * 0.5, DriftAmount);
                            local TweenInfo_new_ret = TweenInfo.new(v124, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
                            local v126 = {};

                            if v123 then
                                v125 = -v125 or v125;
                            end;

                            v126.Position = UDim2.new(TargetA2.X.Scale, TargetA2.X.Offset, TargetA2.Y.Scale + v125, TargetA2.Y.Offset);
                            local v127 = TweenService:Create(ImageA, TweenInfo_new_ret, v126);
                            v127:Play();
                            v127.Completed:Wait();
                            v123 = not v123;
                        end;
                    end);
                end;
            end);
            task.delay(u111.Stagger, function() -- Line: 685
                -- upvalues: u116 (copy), u114 (ref), u115 (copy), u13 (ref), u15 (ref), u111 (ref), TweenService (ref), u113 (ref), IsStillValid (copy)
                local v128;

                if u116 == u114 then
                    v128 = u13 and u115 == u15;
                else
                    v128 = false;
                end;

                if not v128 then
                    return;
                end;

                local v129 = TweenService:Create(u111.ImageB, TweenInfo.new(u111.SlideTime, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                    Position = u111.TargetB
                });
                v129:Play();
                v129.Completed:Once(function() -- Line: 696
                    -- upvalues: u116 (ref), u114 (ref), u115 (ref), u13 (ref), u15 (ref), u113 (ref), u111 (ref), IsStillValid (ref), TweenService (ref)
                    local v130;

                    if u116 == u114 then
                        v130 = u13 and u115 == u15;
                    else
                        v130 = false;
                    end;

                    if v130 then
                        local ImageB = u111.ImageB;
                        local TargetB2 = u111.TargetB;
                        local u131 = u111.DriftAmount * u111.Parallax;
                        local DriftMinTime = u111.DriftMinTime;
                        local DriftMaxTime = u111.DriftMaxTime;
                        local u132 = IsStillValid;
                        u113 = task.spawn(function() -- Line: 609
                            -- upvalues: u132 (copy), DriftMinTime (copy), DriftMaxTime (copy), u131 (copy), ImageB (copy), TargetB2 (copy), TweenService (ref)
                            local Random_new = Random.new;
                            local v133 = os.clock() * 1000000;
                            local v134 = Random_new(math.floor(v133) + math.random(1, 100000));
                            local v135;

                            if v134:NextInteger(0, 1) == 0 then
                                v135 = true;
                            else
                                v135 = false;
                            end;

                            while u132() do
                                local v136 = v134:NextNumber(DriftMinTime, DriftMaxTime);
                                local v137 = v134:NextNumber(u131 * 0.5, u131);
                                local TweenInfo_new_ret = TweenInfo.new(v136, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
                                local v138 = {};

                                if v135 then
                                    v137 = -v137 or v137;
                                end;

                                v138.Position = UDim2.new(TargetB2.X.Scale, TargetB2.X.Offset, TargetB2.Y.Scale + v137, TargetB2.Y.Offset);
                                local v139 = TweenService:Create(ImageB, TweenInfo_new_ret, v138);
                                v139:Play();
                                v139.Completed:Wait();
                                v135 = not v135;
                            end;
                        end);
                    end;
                end);
            end);
        end,

        PlayExit = function() -- Line: 707, Name: PlayExit
            -- upvalues: u114 (ref), u112 (ref), u113 (ref), u111 (copy), TweenService (ref)
            u114 = u114 + 1;

            if u112 then
                task.cancel(u112);
                u112 = nil;
            end;

            if u113 then
                task.cancel(u113);
                u113 = nil;
            end;

            local ImageA = u111.ImageA;
            local TweenInfo_new_ret = TweenInfo.new(0.28, Enum.EasingStyle.Quad, Enum.EasingDirection.In);
            local v140 = {};
            local TargetA = u111.TargetA;
            v140.Position = UDim2.new(TargetA.X.Scale + u111.StartOffset, TargetA.X.Offset, TargetA.Y.Scale, TargetA.Y.Offset);
            TweenService:Create(ImageA, TweenInfo_new_ret, v140):Play();
            local ImageB = u111.ImageB;
            local TweenInfo_new_ret2 = TweenInfo.new(0.28, Enum.EasingStyle.Quad, Enum.EasingDirection.In);
            local v141 = {};
            local TargetB = u111.TargetB;
            v141.Position = UDim2.new(TargetB.X.Scale + -u111.StartOffset, TargetB.X.Offset, TargetB.Y.Scale, TargetB.Y.Offset);
            TweenService:Create(ImageB, TweenInfo_new_ret2, v141):Play();
        end
    };
end;

local u142 = CreateMaskIntro({
    ImageA = Sunburst,
    TargetA = Position3,
    ImageB = SunburstCounter,
    TargetB = Position4,
    StartOffset = u10.SUNBURSTMASK_START_OFFSET,
    SlideTime = u10.SUNBURSTMASK_SLIDE_TIME,
    Stagger = u10.SUNBURSTMASK_SLIDE_STAGGER,
    DriftAmount = u10.SUNBURSTMASK_DRIFT,
    DriftMinTime = u10.SUNBURSTMASK_DRIFT_MIN_TIME,
    DriftMaxTime = u10.SUNBURSTMASK_DRIFT_MAX_TIME,
    Parallax = u10.SUNBURSTMASK2_PARALLAX
});

for _, v in u11 do
    local v143 = Content:FindFirstChild(v .. "Mask");

    if v143 and v143:IsA("CanvasGroup") then
        local ImageLabel = v143:FindFirstChild("ImageLabel");
        local ImageLabel2 = v143:FindFirstChild("ImageLabel2");

        if ImageLabel and ImageLabel2 then
            u28[v] = CreateMaskIntro({
                ImageA = ImageLabel,
                TargetA = ImageLabel.Position,
                ImageB = ImageLabel2,
                TargetB = ImageLabel2.Position,
                StartOffset = u10.BGMASK_START_OFFSET,
                SlideTime = u10.BGMASK_SLIDE_TIME,
                Stagger = u10.BGMASK_SLIDE_STAGGER,
                DriftAmount = u10.BGMASK_DRIFT,
                DriftMinTime = u10.BGMASK_DRIFT_MIN_TIME,
                DriftMaxTime = u10.BGMASK_DRIFT_MAX_TIME,
                Parallax = u10.BGMASK2_PARALLAX
            });
        end;
    end;
end;

local u144 = nil;
local u145 = nil;
local u146 = nil;

local function StopSunburstSpin() -- Line: 767
    -- upvalues: u144 (ref), u145 (ref), u146 (ref)
    if u144 then
        u144:Cancel();
        u144 = nil;
    end;

    if u145 then
        u145:Cancel();
        u145 = nil;
    end;

    if u146 then
        u146:Cancel();
        u146 = nil;
    end;
end;

local function PlaySunburstSpin(u147) -- Line: 784
    -- upvalues: u144 (ref), u145 (ref), u146 (ref), SunburstMask (copy), u10 (copy), TweenService (copy), u13 (ref), u15 (ref), SunburstCounter (copy), Sunburst (copy)
    if u144 then
        u144:Cancel();
        u144 = nil;
    end;

    if u145 then
        u145:Cancel();
        u145 = nil;
    end;

    if u146 then
        u146:Cancel();
        u146 = nil;
    end;

    local v148 = SunburstMask;
    local u149 = v148:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
    u149.Parent = v148;
    u149.Scale = u10.SUNBURST_INTRO_SCALE;
    local v150 = TweenService:Create(u149, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Scale = 1
    });
    v150:Play();
    v150.Completed:Once(function() -- Line: 792
        -- upvalues: u147 (copy), u13 (ref), u15 (ref), u146 (ref), u149 (copy), u10 (ref), TweenService (ref)
        if not (u13 and u147 == u15) then
            return;
        end;

        local v151 = TweenService:Create(u149, TweenInfo.new(u10.SUNBURST_BREATHE_TIME, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
            Scale = u10.SUNBURST_BREATHE_SCALE
        });
        v151:Play();
        u146 = v151;
    end);
    local v152 = TweenService:Create(SunburstCounter, TweenInfo.new(u10.SUNBURST_COUNTER_SPIN_TIME, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1), {
        Rotation = SunburstCounter.Rotation - 360
    });
    v152:Play();
    u145 = v152;
    local v153 = TweenService:Create(Sunburst, TweenInfo.new(u10.SUNBURST_KICK_TIME, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        Rotation = Sunburst.Rotation + u10.SUNBURST_KICK_DEGREES
    });
    v153:Play();
    v153.Completed:Once(function() -- Line: 816
        -- upvalues: u147 (copy), u13 (ref), u15 (ref), u144 (ref), Sunburst (ref), u10 (ref), TweenService (ref)
        if not (u13 and u147 == u15) then
            return;
        end;

        local v154 = TweenService:Create(Sunburst, TweenInfo.new(u10.SUNBURST_SPIN_TIME, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1), {
            Rotation = Sunburst.Rotation + 360
        });
        v154:Play();
        u144 = v154;
    end);
end;

local function SetLineGradientReveal(p155, p156) -- Line: 830
    -- upvalues: u10 (copy)
    local math_clamp_ret = math.clamp(p156, 0, 1);

    if math_clamp_ret <= 0 then
        p155.Transparency = NumberSequence.new(1);

        return;
    end;

    if math_clamp_ret >= 1 then
        p155.Transparency = NumberSequence.new(0);

        return;
    end;

    local math_clamp_ret2 = math.clamp(math_clamp_ret - u10.LINE_DRAW_SOFTNESS, 0, 1);
    local math_clamp_ret3 = math.clamp(math_clamp_ret + u10.LINE_DRAW_SOFTNESS, 0, 1);
    p155.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0),
        NumberSequenceKeypoint.new(math_clamp_ret2, 0),
        NumberSequenceKeypoint.new(math_clamp_ret, 0.35),
        NumberSequenceKeypoint.new(math_clamp_ret3, 1),
        NumberSequenceKeypoint.new(1, 1)
    });
end;

local function AnimateLineDraw(p157, p158) -- Line: 855
    -- upvalues: u10 (copy), SetLineGradientReveal (copy), u13 (ref), u15 (ref), RunService (copy), TweenService (copy)
    local LINE_DRAW_TIME = u10.LINE_DRAW_TIME;
    SetLineGradientReveal(p157, 0);
    local v159 = 0;

    while v159 < LINE_DRAW_TIME do
        if not (u13 and p158 == u15) then
            return;
        end;

        v159 = v159 + RunService.RenderStepped:Wait();
        SetLineGradientReveal(p157, (TweenService:GetValue(math.clamp(v159 / LINE_DRAW_TIME, 0, 1), u10.LINE_DRAW_EASING_STYLE, u10.LINE_DRAW_EASING_DIRECTION)));
    end;

    if u13 and p158 == u15 then
        SetLineGradientReveal(p157, 1);
    end;
end;

local function AnimateLineErase(p160, p161) -- Line: 879
    -- upvalues: u10 (copy), u15 (ref), RunService (copy), TweenService (copy), SetLineGradientReveal (copy)
    local LINE_ERASE_TIME = u10.LINE_ERASE_TIME;
    local v162 = 0;

    while v162 < LINE_ERASE_TIME do
        if p161 ~= u15 then
            return;
        end;

        v162 = v162 + RunService.RenderStepped:Wait();
        SetLineGradientReveal(p160, 1 - TweenService:GetValue(math.clamp(v162 / LINE_ERASE_TIME, 0, 1), Enum.EasingStyle.Quad, Enum.EasingDirection.In));
    end;

    if p161 == u15 then
        SetLineGradientReveal(p160, 0);
    end;
end;

local function SpawnCarouselText(p163) -- Line: 902
    -- upvalues: TextLabelTemplate (copy), u10 (copy), SideTextMask (copy), u25 (copy), TweenService (copy)
    local v164 = p163 or 0;
    local u165 = TextLabelTemplate:Clone();
    u165.Visible = true;
    local v166 = u10.CAROUSEL_FINISH_X - u10.CAROUSEL_START_X;
    u165.Position = UDim2.new(u10.CAROUSEL_START_X + v166 * v164, TextLabelTemplate.Position.X.Offset, TextLabelTemplate.Position.Y.Scale, TextLabelTemplate.Position.Y.Offset);
    u165.Parent = SideTextMask;
    table.insert(u25, u165);
    local v167 = TweenService:Create(u165, TweenInfo.new(v166 * (1 - v164) / u10.CAROUSEL_SPEED, Enum.EasingStyle.Linear), {
        Position = UDim2.new(u10.CAROUSEL_FINISH_X, TextLabelTemplate.Position.X.Offset, TextLabelTemplate.Position.Y.Scale, TextLabelTemplate.Position.Y.Offset)
    });
    v167:Play();
    v167.Completed:Once(function() -- Line: 931
        -- upvalues: u25 (ref), u165 (copy)
        local table_find_ret = table.find(u25, u165);

        if table_find_ret then
            table.remove(u25, table_find_ret);
        end;

        u165:Destroy();
    end);
end;

local function StopCarouselLoop() -- Line: 942
    -- upvalues: u26 (ref), u25 (copy)
    if u26 then
        task.cancel(u26);
        u26 = nil;
    end;

    for _, v in u25 do
        v:Destroy();
    end;

    table.clear(u25);
end;

local function PlayCarouselLoop() -- Line: 955
    -- upvalues: StopCarouselLoop (copy), u10 (copy), SpawnCarouselText (copy), u26 (ref), u13 (ref)
    StopCarouselLoop();
    local v168 = u10.CAROUSEL_FINISH_X - u10.CAROUSEL_START_X;

    for i = 0, math.floor(v168 / u10.CAROUSEL_SPACING) do
        SpawnCarouselText(i * u10.CAROUSEL_SPACING / v168);
        local _ = i;
    end;

    local u169 = u10.CAROUSEL_SPACING / u10.CAROUSEL_SPEED;
    u26 = task.spawn(function() -- Line: 967
        -- upvalues: u13 (ref), u169 (copy), SpawnCarouselText (ref)
        while u13 do
            task.wait(u169);
            SpawnCarouselText(0);
        end;
    end);
end;

local function SpawnStar(p170) -- Line: 976
    -- upvalues: StarTemplate (copy), u10 (copy), ParticlesMask (copy), u24 (copy), TweenService (copy), ImageTransparency (copy)
    local v171 = p170 or 0;
    local u172 = StarTemplate:Clone();
    local v173 = u172:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
    v173.Parent = u172;
    local v174 = math.random(2, 98) / 100;
    local v175 = math.random(-8, 8) / 100;
    local STAR_SPAWN_Y = u10.STAR_SPAWN_Y;
    local STAR_DESPAWN_Y = u10.STAR_DESPAWN_Y;
    u172.AnchorPoint = Vector2.new(0.5, 0.5);
    u172.Position = UDim2.fromScale(v174, STAR_SPAWN_Y + (STAR_DESPAWN_Y - STAR_SPAWN_Y) * v171);
    u172.Rotation = math.random(0, 359);
    u172.ImageTransparency = 1;
    u172.Visible = true;
    v173.Scale = math.random(u10.STAR_MIN_SCALE * 100, u10.STAR_MAX_SCALE * 100) / 100;
    u172.Parent = ParticlesMask;
    table.insert(u24, u172);
    local v176 = math.random(u10.STAR_MIN_RISE_TIME * 10, u10.STAR_MAX_RISE_TIME * 10) / 10;
    local v177 = math.random(u10.STAR_MIN_SPIN_TIME * 10, u10.STAR_MAX_SPIN_TIME * 10) / 10;
    local v178 = math.random(0, 1) == 0 and -1 or 1;
    TweenService:Create(u172, TweenInfo.new(v177, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1), {
        Rotation = u172.Rotation + 360 * v178
    }):Play();
    local v179 = v176 * (1 - v171);
    TweenService:Create(u172, TweenInfo.new(u10.STAR_FADE_IN_TIME, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        ImageTransparency = ImageTransparency
    }):Play();
    task.delay(math.max(v179 - u10.STAR_FADE_OUT_TIME, u10.STAR_FADE_IN_TIME), function() -- Line: 1017
        -- upvalues: u172 (copy), u10 (ref), TweenService (ref)
        if u172.Parent then
            TweenService:Create(u172, TweenInfo.new(u10.STAR_FADE_OUT_TIME, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                ImageTransparency = 1
            }):Play();
        end;
    end);
    local v180 = TweenService:Create(u172, TweenInfo.new(v179, Enum.EasingStyle.Linear), {
        Position = UDim2.fromScale(v174 + v175, STAR_DESPAWN_Y)
    });
    v180:Play();
    v180.Completed:Once(function() -- Line: 1031
        -- upvalues: u24 (ref), u172 (copy)
        local table_find_ret = table.find(u24, u172);

        if table_find_ret then
            table.remove(u24, table_find_ret);
        end;

        u172:Destroy();
    end);
end;

local function PlayStarBurst() -- Line: 1042
    -- upvalues: u10 (copy), u13 (ref), SpawnStar (copy)
    task.spawn(function() -- Line: 1043
        -- upvalues: u10 (ref), u13 (ref), SpawnStar (ref)
        for i = 1, u10.STAR_BURST_COUNT do
            if not u13 then
                break;
            end;

            SpawnStar(math.random(0, 25) / 100);
            task.wait(u10.STAR_BURST_STAGGER);
            local _ = i;
        end;
    end);
end;

local function StopStarLoop() -- Line: 1056
    -- upvalues: u23 (ref), u24 (copy)
    if u23 then
        task.cancel(u23);
        u23 = nil;
    end;

    for _, v in u24 do
        v:Destroy();
    end;

    table.clear(u24);
end;

local function PlayStarLoop() -- Line: 1069
    -- upvalues: StopStarLoop (copy), u10 (copy), SpawnStar (copy), u23 (ref), u13 (ref)
    StopStarLoop();

    for i = 1, u10.STAR_PREFILL do
        SpawnStar(math.random(5, 90) / 100);
        local _ = i;
    end;

    u23 = task.spawn(function() -- Line: 1076
        -- upvalues: u13 (ref), u10 (ref), SpawnStar (ref)
        while u13 do
            task.wait(math.random(u10.STAR_MIN_DELAY * 100, u10.STAR_MAX_DELAY * 100) / 100);
            SpawnStar();
        end;
    end);
end;

local function CacheParticle(p181) -- Line: 1085
    -- upvalues: u20 (copy), u21 (copy)
    if not u20[p181] then
        u20[p181] = p181.Position;
        u21[p181] = p181.Rotation;
    end;
end;

local function CancelParticleTweens(p182) -- Line: 1092
    -- upvalues: u22 (copy)
    local v183 = u22[p182];

    if v183 then
        for _, v in v183 do
            v:Cancel();
        end;

        u22[p182] = nil;
    end;
end;

local function StopParticleFloat(p184, p185) -- Line: 1104
    -- upvalues: u22 (copy), u20 (copy), u21 (copy)
    for _, v in p184 do
        task.cancel(v);
    end;

    table.clear(p184);

    for _, child in p185:GetChildren() do
        if child:IsA("ImageLabel") and child.Name == "Particles" then
            local v186 = u22[child];
            local v187;

            if v186 then
                v187 = child;

                for _, v in v186 do
                    v:Cancel();
                end;

                u22[v187] = nil;
            else
                v187 = child;
            end;

            if u20[v187] then
                v187.Position = u20[v187];
                v187.Rotation = u21[v187];
            end;

            local v188 = v187:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
            v188.Parent = v187;
            v188.Scale = 1;
        end;
    end;
end;

local function StartParticleFloat(p189, p190, u191, u192) -- Line: 1125
    -- upvalues: StopParticleFloat (copy), u20 (copy), u21 (copy), u10 (copy), TweenService (copy), u22 (copy)
    StopParticleFloat(p190, p189);

    for _, child in p189:GetChildren() do
        if child:IsA("ImageLabel") and child.Name == "Particles" then
            if not u20[child] then
                u20[child] = child.Position;
                u21[child] = child.Rotation;
            end;

            local u193 = u20[child];
            local u194 = u21[child];
            local u195 = child:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
            u195.Parent = child;
            local Random_new = Random.new;
            local v196 = os.clock() * 1000000;
            local u197 = Random_new(math.floor(v196) + math.random(1, 100000));
            local task_spawn_ret = task.spawn(function() -- Line: 1138
                -- upvalues: u192 (copy), u197 (copy), u191 (copy), child (copy), u10 (ref), u193 (copy), u194 (copy), TweenService (ref), u195 (copy), u22 (ref)
                task.wait((u192 or 0) + u197:NextNumber(0, 1.2));
                local v198 = u197:NextInteger(0, 1) == 0;

                while u191() and child.Parent do
                    local v199 = u197:NextNumber(u10.PARTICLE_MIN_TIME, u10.PARTICLE_MAX_TIME);
                    local TweenInfo_new_ret = TweenInfo.new(v199, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
                    local v200 = u197:NextInteger(u10.PARTICLE_MIN_RISE, u10.PARTICLE_MAX_RISE);
                    local v201 = u197:NextInteger(-u10.PARTICLE_DRIFT, u10.PARTICLE_DRIFT);
                    local v202 = {};

                    if v198 then
                        v200 = -v200 or v200;
                    end;

                    v202.Position = u193 + UDim2.fromOffset(v201, v200);
                    v202.Rotation = u194 + u197:NextNumber(-u10.PARTICLE_ROTATION, u10.PARTICLE_ROTATION);
                    local v203 = TweenService:Create(child, TweenInfo_new_ret, v202);
                    v203:Play();
                    local v204 = TweenService:Create(u195, TweenInfo_new_ret, {
                        Scale = 1 + u197:NextNumber(-u10.PARTICLE_SCALE, u10.PARTICLE_SCALE)
                    });
                    v204:Play();
                    u22[child] = { v203, v204 };
                    v203.Completed:Wait();
                    v198 = not v198;
                end;

                if child.Parent then
                    child.Position = u193;
                    child.Rotation = u194;
                    u195.Scale = 1;
                end;
            end);
            table.insert(p190, task_spawn_ret);
        end;
    end;
end;

for _, v in u11 do
    local v205 = Content:FindFirstChild(v .. "Hero");

    if v205 and v205:IsA("GuiObject") then
        local v206 = {
            ExitToken = 0,
            IntroTween = nil,
            ExitTween = nil,
            Instance = v205
        };
        local v207 = v205:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
        v207.Parent = v205;
        v206.Scale = v207;
        v206.BasePosition = v205.Position;
        v206.Threads = {};
        u27[v] = v206;
    else
        warn("StyleQuestsController: missing " .. v .. "Hero in Content");
    end;
end;

local function CancelHeroTweens(p208) -- Line: 1196
    if p208.IntroTween then
        p208.IntroTween:Cancel();
        p208.IntroTween = nil;
    end;

    if p208.ExitTween then
        p208.ExitTween:Cancel();
        p208.ExitTween = nil;
    end;
end;

local function HideHero(p209) -- Line: 1208
    -- upvalues: u27 (copy), StopParticleFloat (copy)
    local v210 = u27[p209];

    if not v210 then
        return;
    end;

    v210.ExitToken = v210.ExitToken + 1;

    if v210.IntroTween then
        v210.IntroTween:Cancel();
        v210.IntroTween = nil;
    end;

    if v210.ExitTween then
        v210.ExitTween:Cancel();
        v210.ExitTween = nil;
    end;

    StopParticleFloat(v210.Threads, v210.Instance);
    v210.Instance.Visible = false;
    v210.Instance.Position = v210.BasePosition;
    v210.Scale.Scale = 0;
end;

local function LeaveHero(p211) -- Line: 1224
    -- upvalues: u27 (copy), StopParticleFloat (copy), u10 (copy), TweenService (copy)
    local u212 = u27[p211];

    if not (u212 and u212.Instance.Visible) then
        return;
    end;

    u212.ExitToken = u212.ExitToken + 1;
    local ExitToken = u212.ExitToken;

    if u212.IntroTween then
        u212.IntroTween:Cancel();
        u212.IntroTween = nil;
    end;

    if u212.ExitTween then
        u212.ExitTween:Cancel();
        u212.ExitTween = nil;
    end;

    StopParticleFloat(u212.Threads, u212.Instance);
    local Instance2 = u212.Instance;
    local HERO_SLIDE_OUT_INFO = u10.HERO_SLIDE_OUT_INFO;
    local v213 = {};
    local BasePosition = u212.BasePosition;
    v213.Position = UDim2.new(BasePosition.X.Scale + -u10.HERO_EXIT_OFFSET, BasePosition.X.Offset, BasePosition.Y.Scale, BasePosition.Y.Offset);
    local v214 = TweenService:Create(Instance2, HERO_SLIDE_OUT_INFO, v213);
    v214:Play();
    u212.ExitTween = v214;
    u212.ExitTween.Completed:Once(function() -- Line: 1241
        -- upvalues: u212 (copy), ExitToken (copy)
        if u212.ExitToken ~= ExitToken then
            return;
        end;

        u212.ExitTween = nil;
        u212.Instance.Visible = false;
        u212.Instance.Position = u212.BasePosition;
        u212.Scale.Scale = 0;
    end);
end;

local function ShowHero(u215, u216, u217, u218) -- Line: 1253
    -- upvalues: u27 (copy), u13 (ref), u15 (ref), u14 (ref), u10 (copy), SpawnStar (copy), TweenService (copy), u19 (ref), StartParticleFloat (copy)
    local u219 = u27[u215];

    local function Finish() -- Line: 1256
        -- upvalues: u216 (copy), u217 (copy), u13 (ref), u15 (ref), u14 (ref), u10 (ref), SpawnStar (ref), u218 (copy)
        local v220 = u216;
        local v221 = u217;
        local v222 = u13;

        if v222 then
            if v220 == u15 then
                v222 = v221 == u14;
            else
                v222 = false;
            end;
        end;

        if not v222 then
            return;
        end;

        task.spawn(function() -- Line: 1043
            -- upvalues: u10 (ref), u13 (ref), SpawnStar (ref)
            for i = 1, u10.STAR_BURST_COUNT do
                if not u13 then
                    break;
                end;

                SpawnStar(math.random(0, 25) / 100);
                task.wait(u10.STAR_BURST_STAGGER);
                local _ = i;
            end;
        end);

        if u218 then
            u218();
        end;
    end;

    if not u219 then
        task.delay(u10.HERO_INTRO_TIME, Finish);

        return;
    end;

    u219.ExitToken = u219.ExitToken + 1;

    if u219.IntroTween then
        u219.IntroTween:Cancel();
        u219.IntroTween = nil;
    end;

    if u219.ExitTween then
        u219.ExitTween:Cancel();
        u219.ExitTween = nil;
    end;

    u219.Instance.Position = u219.BasePosition;
    u219.Instance.Visible = true;
    u219.Scale.Scale = 0;
    local v223 = TweenService:Create(u219.Scale, u10.HERO_INTRO_INFO, {
        Scale = 1
    });
    v223:Play();
    u219.IntroTween = v223;
    v223.Completed:Once(function(p224) -- Line: 1283
        -- upvalues: u219 (copy), u216 (copy), u217 (copy), u13 (ref), u15 (ref), u14 (ref), u19 (ref), u215 (copy), StartParticleFloat (ref), u10 (ref), SpawnStar (ref), u218 (copy)
        if p224 ~= Enum.PlaybackState.Completed then
            return;
        end;

        u219.IntroTween = nil;
        local v225 = u216;
        local v226 = u217;
        local v227 = u13;

        if v227 then
            if v225 == u15 then
                v227 = v226 == u14;
            else
                v227 = false;
            end;
        end;

        if not v227 or u19 ~= u215 then
            return;
        end;

        StartParticleFloat(u219.Instance, u219.Threads, function() -- Line: 1294
            -- upvalues: u216 (ref), u217 (ref), u13 (ref), u15 (ref), u14 (ref), u19 (ref), u215 (ref)
            local v228 = u216;
            local v229 = u217;
            local v230 = u13;

            if v230 then
                if v228 == u15 then
                    v230 = v229 == u14;
                else
                    v230 = false;
                end;
            end;

            if v230 then
                v230 = u19 == u215;
            end;

            return v230;
        end, u10.HERO_PARTICLE_START_DELAY);
        local v231 = u216;
        local v232 = u217;
        local v233 = u13;

        if v233 then
            if v231 == u15 then
                v233 = v232 == u14;
            else
                v233 = false;
            end;
        end;

        if not v233 then
            return;
        end;

        task.spawn(function() -- Line: 1043
            -- upvalues: u10 (ref), u13 (ref), SpawnStar (ref)
            for i = 1, u10.STAR_BURST_COUNT do
                if not u13 then
                    break;
                end;

                SpawnStar(math.random(0, 25) / 100);
                task.wait(u10.STAR_BURST_STAGGER);
                local _ = i;
            end;
        end);

        if u218 then
            u218();
        end;
    end);
end;

local function GetSortedNumericIndexes(p234) -- Line: 1303
    local v235 = {};

    for i in p234 do
        if typeof(i) == "number" then
            table.insert(v235, i);
        end;
    end;

    table.sort(v235);

    return v235;
end;

local function FormatQuestNumber(p236) -- Line: 1317
    return string.format("%02d", p236);
end;

local function ClampProgress(p237, p238) -- Line: 1321
    return p238 <= 0 and 0 or math.clamp(p237 / p238, 0, 1);
end;

local function SetHorizontalScale(p239, p240) -- Line: 1329
    p239.Size = UDim2.new(math.clamp(p240, 0, 1), 0, p239.Size.Y.Scale, p239.Size.Y.Offset);
end;

local function CreateScaleChannels(p241) -- Line: 1333
    local u242 = p241:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
    u242.Parent = p241;
    local NumberValue2 = Instance.new("NumberValue");
    NumberValue2.Name = "RevealScale";
    NumberValue2.Value = 1;
    NumberValue2.Parent = p241;
    local NumberValue3 = Instance.new("NumberValue");
    NumberValue3.Name = "InteractScale";
    NumberValue3.Value = 1;
    NumberValue3.Parent = p241;

    local function v243() -- Line: 1346
        -- upvalues: u242 (copy), NumberValue2 (copy), NumberValue3 (copy)
        u242.Scale = NumberValue2.Value * NumberValue3.Value;
    end;

    NumberValue2.Changed:Connect(v243);
    NumberValue3.Changed:Connect(v243);
    u242.Scale = NumberValue2.Value * NumberValue3.Value;

    return {
        Reveal = NumberValue2,
        Interact = NumberValue3
    };
end;

local function SetNavButtonState(p244, p245, p246) -- Line: 1357
    -- upvalues: u10 (copy), TweenService (copy)
    local Icon = p244:FindFirstChild("Icon");
    local TextLabel = p244:FindFirstChild("TextLabel");
    local v247 = p245 and u10.NAV_ACTIVE_COLOR or u10.NAV_INACTIVE_COLOR;
    local v248 = p245 and u10.NAV_ACTIVE_CONTENT_TRANSPARENCY or u10.NAV_INACTIVE_CONTENT_TRANSPARENCY;

    if p246 then
        TweenService:Create(p244, u10.NAV_STATE_TWEEN_INFO, {
            ImageColor3 = v247
        }):Play();

        if Icon and Icon:IsA("ImageLabel") then
            TweenService:Create(Icon, u10.NAV_STATE_TWEEN_INFO, {
                ImageTransparency = v248
            }):Play();
        end;

        if TextLabel and TextLabel:IsA("TextLabel") then
            TweenService:Create(TextLabel, u10.NAV_STATE_TWEEN_INFO, {
                TextTransparency = v248
            }):Play();
        end;
    else
        p244.ImageColor3 = v247;

        if Icon and Icon:IsA("ImageLabel") then
            Icon.ImageTransparency = v248;
        end;

        if TextLabel and TextLabel:IsA("TextLabel") then
            TextLabel.TextTransparency = v248;
        end;
    end;
end;

local function UpdateCategoryButtonStates(p249) -- Line: 1390
    -- upvalues: u29 (copy), SetNavButtonState (copy), u19 (ref)
    for i, v in u29 do
        SetNavButtonState(v.Button, i == u19, p249);
    end;
end;

local function BuildCategoryButtons() -- Line: 1396
    -- upvalues: u29 (copy), u11 (copy), script_StyleQuestsFrontEnd (copy), ButtonTemplate (copy), ScrollingFrame2 (copy), CreateScaleChannels (copy), u19 (ref), u10 (copy), u8 (copy)
    for _, v in u29 do
        v.Button:Destroy();
    end;

    table.clear(u29);

    for i, v in u11 do
        local v250 = script_StyleQuestsFrontEnd[v];
        local v251 = ButtonTemplate:Clone();
        v251.Name = v;
        v251.LayoutOrder = i;
        v251.Visible = true;
        v251.Parent = ScrollingFrame2;
        local TextLabel = v251:FindFirstChild("TextLabel");

        if TextLabel and TextLabel:IsA("TextLabel") then
            TextLabel.Text = v250.Title;
        end;

        local Icon = v251:FindFirstChild("Icon");

        if v250.Icon and (Icon and Icon:IsA("ImageLabel")) then
            Icon.Image = typeof(v250.Icon) == "number" and "rbxassetid://" .. tostring(v250.Icon) or v250.Icon;
        end;

        local v252 = CreateScaleChannels(v251);
        v252.Reveal.Value = 0;
        local v253 = {
            Button = v251,
            Reveal = v252.Reveal,
            Interact = v252.Interact
        };
        u29[v] = v253;
        local v254 = v == u19;
        local Icon2 = v251:FindFirstChild("Icon");
        local TextLabel2 = v251:FindFirstChild("TextLabel");
        local v255 = v254 and u10.NAV_ACTIVE_CONTENT_TRANSPARENCY or u10.NAV_INACTIVE_CONTENT_TRANSPARENCY;
        v251.ImageColor3 = v254 and u10.NAV_ACTIVE_COLOR or u10.NAV_INACTIVE_COLOR;

        if Icon2 and Icon2:IsA("ImageLabel") then
            Icon2.ImageTransparency = v255;
        end;

        if TextLabel2 and TextLabel2:IsA("TextLabel") then
            TextLabel2.TextTransparency = v255;
        end;

        v253.Button.Activated:Connect(function() -- Line: 1437
            -- upvalues: u8 (ref), v (copy)
            u8.SetCategory(v);
        end);
    end;
end;

local function PlayCategoryReveal(u256) -- Line: 1443
    -- upvalues: u10 (copy), u11 (copy), u13 (ref), u15 (ref), u29 (copy), TweenService (copy)
    task.spawn(function() -- Line: 1444
        -- upvalues: u10 (ref), u11 (ref), u256 (copy), u13 (ref), u15 (ref), u29 (ref), TweenService (ref)
        task.wait(u10.CATEGORY_REVEAL_DELAY);

        for _, v in u11 do
            if not (u13 and u256 == u15) then
                return;
            end;

            local v257 = u29[v];

            if v257 then
                TweenService:Create(v257.Reveal, u10.CATEGORY_REVEAL_INFO, {
                    Value = 1
                }):Play();
            end;

            task.wait(u10.CATEGORY_REVEAL_STAGGER);
        end;
    end);
end;

local function PlayCategoryExit() -- Line: 1463
    -- upvalues: u29 (copy), u10 (copy), TweenService (copy)
    for _, v in u29 do
        TweenService:Create(v.Reveal, u10.QUEST_EXIT_INFO, {
            Value = 0
        }):Play();
    end;
end;

local function DarkenColor(p258, p259) -- Line: 1470
    local v260, v261, v262 = p258:ToHSV();

    return Color3.fromHSV(v260, v261, v262 * p259);
end;

local function ApplyQuestState(p263, p264, p265) -- Line: 1475
    -- upvalues: u10 (copy), DarkenColor (copy)
    local v266 = p264.Claimed == true;
    local Bg2 = p263:WaitForChild("Bg");
    local QuestTitle = p263:WaitForChild("QuestTitle");
    local Progress = p263:WaitForChild("Progress");
    local v267 = QuestTitle:FindFirstChildOfClass("UIGradient");
    local v268 = Progress:FindFirstChildOfClass("UIGradient");
    local ImageLabel = p263:WaitForChild("ProgressBar"):WaitForChild("Fill"):WaitForChild("ImageLabel");

    if v266 then
        Bg2.Image = u10.CLAIMED_BG_IMAGE;
        Bg2.ImageColor3 = u10.DEFAULT_BG_COLOR;
        QuestTitle.TextColor3 = u10.CLAIMED_TEXT_COLOR;
        Progress.TextColor3 = u10.CLAIMED_TEXT_COLOR;

        if v267 then
            v267.Enabled = false;
        end;

        if v268 then
            v268.Enabled = false;
        end;

        ImageLabel.Image = u10.CLAIMED_PROGRESS_IMAGE;
        ImageLabel.BackgroundColor3 = u10.DEFAULT_PROGRESS_FILL_COLOR;

        return;
    end;

    Bg2.Image = u10.DEFAULT_BG_IMAGE;
    Bg2.ImageColor3 = p265;
    QuestTitle.TextColor3 = u10.DEFAULT_QUEST_TITLE_COLOR;
    Progress.TextColor3 = u10.DEFAULT_PROGRESS_TEXT_COLOR;

    if v267 then
        v267.Enabled = true;
        v267.Color = ColorSequence.new(p265, DarkenColor(p265, u10.TITLE_GRADIENT_DARKEN));
    end;

    if v268 then
        v268.Enabled = true;
        v268.Color = ColorSequence.new(p265, DarkenColor(p265, u10.TITLE_GRADIENT_DARKEN));
    end;

    ImageLabel.Image = u10.DEFAULT_PROGRESS_IMAGE;
    ImageLabel.BackgroundColor3 = p265;
end;

local function IsQuestComplete(p269) -- Line: 1519
    local v270 = tonumber(p269.Progress) or 0;
    local v271 = tonumber(p269.Goal) or 0;
    local math_max_ret = math.max(v271, 0);
    local v272;

    if p269.Claimed == true or p269.ToClaim == true then
        v272 = true;
    elseif math_max_ret > 0 then
        v272 = math_max_ret <= v270;
    else
        v272 = false;
    end;

    return v272;
end;

local function GetCategoryCompletionPercent(p273) -- Line: 1526
    -- upvalues: u30 (ref)
    local v274 = u30[p273];

    if not v274 then
        return 0;
    end;

    local v275 = 0;
    local v276 = 0;

    for i in v274 do
        if typeof(i) == "number" then
            v275 = v275 + 1;
            local v277 = v274[i];
            local v278 = tonumber(v277.Progress) or 0;
            local v279 = tonumber(v277.Goal) or 0;
            local math_max_ret = math.max(v279, 0);
            local v280;

            if v277.Claimed == true or v277.ToClaim == true then
                v280 = true;
            elseif math_max_ret > 0 then
                v280 = math_max_ret <= v278;
            else
                v280 = false;
            end;

            if v280 then
                v276 = v276 + 1;
            end;
        end;
    end;

    return v275 == 0 and 0 or math.floor(v276 / v275 * 100 + 0.5);
end;

local function CreateQuestEntry(p281, p282, p283) -- Line: 1553
    -- upvalues: Template (copy), ScrollingFrame (copy), ApplyQuestState (copy), script_StyleQuestsFrontEnd (copy)
    local v284 = Template:Clone();
    v284.Name = "Quest" .. tostring(p282);
    v284.LayoutOrder = p282;
    v284.Visible = true;
    v284.Parent = ScrollingFrame;
    local v285 = v284:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
    v285.Parent = v284;
    v285.Scale = 0;
    local QuestNumber = v284:WaitForChild("QuestNumber");
    local QuestTitle = v284:WaitForChild("QuestTitle");
    local QuestSubtitle = v284:WaitForChild("QuestSubtitle");
    local CompleteStatus = v284:WaitForChild("CompleteStatus");
    local Progress = v284:WaitForChild("Progress");
    local Fill = v284:WaitForChild("ProgressBar"):WaitForChild("Fill");
    local v286 = tonumber(p283.Progress) or 0;
    local v287 = tonumber(p283.Goal) or 0;
    local math_max_ret = math.max(v287, 0);
    local v288 = tonumber(p283.Progress) or 0;
    local v289 = tonumber(p283.Goal) or 0;
    local math_max_ret2 = math.max(v289, 0);
    local v290;

    if p283.Claimed == true or p283.ToClaim == true then
        v290 = true;
    elseif math_max_ret2 > 0 then
        v290 = math_max_ret2 <= v288;
    else
        v290 = false;
    end;

    QuestNumber.Text = string.format("%02d", p282);
    QuestTitle.Text = string.upper((tostring(p283.Title or "QUEST")));
    QuestSubtitle.Text = tostring(p283.Subtitle or "");
    CompleteStatus.Text = v290 and "COMPLETE" or "INCOMPLETE";
    Progress.Text = tostring(v286) .. "/" .. tostring(math_max_ret);
    v284:SetAttribute("ProgressAlpha", math_max_ret <= 0 and 0 or math.clamp(v286 / math_max_ret, 0, 1));
    Fill.Size = UDim2.new(0, 0, Fill.Size.Y.Scale, Fill.Size.Y.Offset);
    ApplyQuestState(v284, p283, script_StyleQuestsFrontEnd[p281].Sunburst.Main);

    return v284;
end;

local function ClearQuestEntries() -- Line: 1591
    -- upvalues: u31 (copy)
    for _, v in u31 do
        if v and v.Parent then
            v:Destroy();
        end;
    end;

    table.clear(u31);
end;

local function PopulateQuestEntries(p291, p292) -- Line: 1601
    -- upvalues: ScrollingFrame (copy), ClearQuestEntries (copy), u30 (ref), GetSortedNumericIndexes (copy), u31 (copy), CreateQuestEntry (copy)
    local CanvasPosition = ScrollingFrame.CanvasPosition;
    ClearQuestEntries();
    local v293 = u30[p291] or {};

    for _, v in GetSortedNumericIndexes(v293) do
        u31[v] = CreateQuestEntry(p291, v, v293[v]);
    end;

    ScrollingFrame.CanvasPosition = p292 and CanvasPosition and CanvasPosition or Vector2.zero;
end;

local function PlayQuestsReveal(u294, u295, u296) -- Line: 1615
    -- upvalues: GetSortedNumericIndexes (copy), u31 (copy), u13 (ref), u15 (ref), u14 (ref), u10 (copy), TweenService (copy)
    task.spawn(function() -- Line: 1616
        -- upvalues: GetSortedNumericIndexes (ref), u31 (ref), u294 (copy), u295 (copy), u13 (ref), u15 (ref), u14 (ref), u296 (copy), u10 (ref), TweenService (ref)
        for _, v in GetSortedNumericIndexes(u31) do
            local v297 = u294;
            local v298 = u295;
            local v299 = u13;

            if v299 then
                if v297 == u15 then
                    v299 = v298 == u14;
                else
                    v299 = false;
                end;
            end;

            if not v299 then
                return;
            end;

            local v300 = u31[v];

            if not (v300 and v300.Parent) then
                return;
            end;

            local v301 = v300:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
            v301.Parent = v300;
            local Fill = v300:WaitForChild("ProgressBar"):WaitForChild("Fill");
            local u302 = v300:GetAttribute("ProgressAlpha") or 0;

            if u296 then
                v301.Scale = 1;
                Fill.Size = UDim2.new(u302, 0, Fill.Size.Y.Scale, Fill.Size.Y.Offset);
            else
                TweenService:Create(v301, u10.QUEST_ENTRY_REVEAL_INFO, {
                    Scale = 1
                }):Play();
                task.delay(0.07, function() -- Line: 1640
                    -- upvalues: u294 (ref), u295 (ref), u13 (ref), u15 (ref), u14 (ref), Fill (copy), u10 (ref), u302 (copy), TweenService (ref)
                    local v303 = u294;
                    local v304 = u295;
                    local v305 = u13;

                    if v305 then
                        if v303 == u15 then
                            v305 = v304 == u14;
                        else
                            v305 = false;
                        end;
                    end;

                    if not (v305 and Fill.Parent) then
                        return;
                    end;

                    TweenService:Create(Fill, u10.QUEST_FILL_INFO, {
                        Size = UDim2.new(u302, 0, Fill.Size.Y.Scale, Fill.Size.Y.Offset)
                    }):Play();
                end);
                task.wait(u10.QUEST_ENTRY_STAGGER);
            end;
        end;
    end);
end;

local Container = u9.Container;

if Container then
    u9.BasePosition = Container.Position;
    u9.CanTint = Container:IsA("ImageLabel") or Container:IsA("ImageButton");
    u9.Scroll = Container:WaitForChild("ScrollingFrame");
    u9.Layout = u9.Scroll:FindFirstChildOfClass("UIListLayout");
    u9.Padding = u9.Scroll:FindFirstChildOfClass("UIPadding");
    u9.TitleLabel = Container:FindFirstChild("Title");
    u9.Scroll.ScrollingDirection = Enum.ScrollingDirection.X;
    u9.Scroll.AutomaticCanvasSize = Enum.AutomaticSize.None;
    u9.Scroll.CanvasPosition = Vector2.zero;
else
    warn("StyleQuestsController: no RewardContainer found in Content, rewards are disabled");
end;

local function GetRewardOffPosition() -- Line: 1675
    -- upvalues: OffsetPositionX (copy), u9 (copy), u10 (copy)
    return OffsetPositionX(u9.BasePosition, -u10.REWARD_EXIT_OFFSET);
end;

local function PopulateRewards(p306) -- Line: 1679
    -- upvalues: u9 (copy), StyleQuestMilestone (copy), Customization (copy), Rarities (copy), ReplicatedStorage (copy)
    local Scroll = u9.Scroll;

    if not Scroll then
        return false;
    end;

    for _, child in Scroll:GetChildren() do
        if child:IsA("GuiObject") then
            child:Destroy();
        end;
    end;

    for i, v in pairs(StyleQuestMilestone) do
        local v307 = Customization[`{v.Type}s`][v.Template(p306)];

        if v307 then
            local v308 = script.Item:Clone();
            v308.Name = "Reward" .. tostring(i);
            v308.LayoutOrder = i;
            v308.Visible = true;
            v308.Parent = Scroll;
            v308.LockerItem_Outline.UIGradient.Color = ColorSequence.new(Rarities.Colors[v307.Rarity]);

            if v.Type == "ChatTag" then
                v308.TextLabel.Text = ReplicatedStorage.Assets.ChatTags.Items:FindFirstChild(v.Template(p306), true).Value;
                ReplicatedStorage.Assets.ChatTags.Items:FindFirstChild(v.Template(p306), true).UIGradient:Clone().Parent = v308.TextLabel;
            end;
        end;
    end;

    return #StyleQuestMilestone > 0;
end;

local function CancelRewardTween() -- Line: 1715
    -- upvalues: u9 (copy)
    if u9.Tween then
        u9.Tween:Cancel();
        u9.Tween = nil;
    end;
end;

local function HideRewardsInstant() -- Line: 1722
    -- upvalues: u9 (copy), u10 (copy)
    if not u9.Container then
        return;
    end;

    local v309 = u9;
    v309.Token = v309.Token + 1;

    if u9.Tween then
        u9.Tween:Cancel();
        u9.Tween = nil;
    end;

    u9.Container.Visible = false;
    local BasePosition = u9.BasePosition;
    u9.Container.Position = UDim2.new(BasePosition.X.Scale + -u10.REWARD_EXIT_OFFSET, BasePosition.X.Offset, BasePosition.Y.Scale, BasePosition.Y.Offset);
end;

local function SlideRewardsOut() -- Line: 1734
    -- upvalues: u9 (copy), u10 (copy), TweenService (copy)
    local Container2 = u9.Container;

    if not (Container2 and Container2.Visible) then
        return;
    end;

    local v310 = u9;
    v310.Token = v310.Token + 1;
    local Token = u9.Token;

    if u9.Tween then
        u9.Tween:Cancel();
        u9.Tween = nil;
    end;

    local REWARD_EXIT_INFO = u10.REWARD_EXIT_INFO;
    local v311 = {};
    local BasePosition = u9.BasePosition;
    v311.Position = UDim2.new(BasePosition.X.Scale + -u10.REWARD_EXIT_OFFSET, BasePosition.X.Offset, BasePosition.Y.Scale, BasePosition.Y.Offset);
    local v312 = TweenService:Create(Container2, REWARD_EXIT_INFO, v311);
    v312:Play();
    u9.Tween = v312;
    u9.Tween.Completed:Once(function() -- Line: 1748
        -- upvalues: u9 (ref), Token (copy), Container2 (copy)
        if u9.Token ~= Token then
            return;
        end;

        u9.Tween = nil;
        Container2.Visible = false;
    end);
end;

local function SlideRewardsIn(p313) -- Line: 1758
    -- upvalues: u9 (copy), PopulateRewards (copy), u10 (copy), TweenService (copy)
    local Container2 = u9.Container;

    if not Container2 then
        return;
    end;

    local v314 = u9;
    v314.Token = v314.Token + 1;

    if u9.Tween then
        u9.Tween:Cancel();
        u9.Tween = nil;
    end;

    if not PopulateRewards(p313) then
        Container2.Visible = false;
        local BasePosition = u9.BasePosition;
        Container2.Position = UDim2.new(BasePosition.X.Scale + -u10.REWARD_EXIT_OFFSET, BasePosition.X.Offset, BasePosition.Y.Scale, BasePosition.Y.Offset);

        return;
    end;

    local BasePosition = u9.BasePosition;
    Container2.Position = UDim2.new(BasePosition.X.Scale + -u10.REWARD_EXIT_OFFSET, BasePosition.X.Offset, BasePosition.Y.Scale, BasePosition.Y.Offset);
    Container2.Visible = true;
    local v315 = TweenService:Create(Container2, u10.REWARD_INTRO_INFO, {
        Position = u9.BasePosition
    });
    v315:Play();
    u9.Tween = v315;
end;

local function ApplyCategoryInstant(p316) -- Line: 1781
    -- upvalues: u19 (ref), script_StyleQuestsFrontEnd (copy), SetPageColors (copy), u14 (ref), TitleFrame2 (copy), Title (copy), TitleDs (copy), u27 (copy), StopParticleFloat (copy), u28 (copy), u29 (copy), u10 (copy), PopulateQuestEntries (copy), u9 (copy)
    u19 = p316;
    local v317 = script_StyleQuestsFrontEnd[p316];
    SetPageColors(v317, false);
    local Title2 = v317.Title;
    local v318 = TitleFrame2;
    local v319 = v318:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
    v319.Parent = v318;

    local function _() -- Line: 463
        -- upvalues: Title (ref), Title2 (copy), TitleDs (ref)
        Title.Text = Title2;
        TitleDs.Text = Title2;
    end;

    v319.Scale = 1;
    Title.Text = Title2;
    TitleDs.Text = Title2;

    for i in u27 do
        local v320 = u27[i];

        if v320 then
            v320.ExitToken = v320.ExitToken + 1;

            if v320.IntroTween then
                v320.IntroTween:Cancel();
                v320.IntroTween = nil;
            end;

            if v320.ExitTween then
                v320.ExitTween:Cancel();
                v320.ExitTween = nil;
            end;

            StopParticleFloat(v320.Threads, v320.Instance);
            v320.Instance.Visible = false;
            v320.Instance.Position = v320.BasePosition;
            v320.Scale.Scale = 0;
        end;
    end;

    for _, v in u28 do
        v.Reset();
    end;

    for i, v in u29 do
        local Button = v.Button;
        local v321 = i == u19;
        local Icon = Button:FindFirstChild("Icon");
        local TextLabel = Button:FindFirstChild("TextLabel");
        local v322 = v321 and u10.NAV_ACTIVE_CONTENT_TRANSPARENCY or u10.NAV_INACTIVE_CONTENT_TRANSPARENCY;
        Button.ImageColor3 = v321 and u10.NAV_ACTIVE_COLOR or u10.NAV_INACTIVE_COLOR;

        if Icon and Icon:IsA("ImageLabel") then
            Icon.ImageTransparency = v322;
        end;

        if TextLabel and TextLabel:IsA("TextLabel") then
            TextLabel.TextTransparency = v322;
        end;
    end;

    PopulateQuestEntries(p316);

    if not u9.Container then
        return;
    end;

    local v323 = u9;
    v323.Token = v323.Token + 1;

    if u9.Tween then
        u9.Tween:Cancel();
        u9.Tween = nil;
    end;

    u9.Container.Visible = false;
    local BasePosition = u9.BasePosition;
    u9.Container.Position = UDim2.new(BasePosition.X.Scale + -u10.REWARD_EXIT_OFFSET, BasePosition.X.Offset, BasePosition.Y.Scale, BasePosition.Y.Offset);
end;

local function ResetVisuals() -- Line: 1802
    -- upvalues: u144 (ref), u145 (ref), u146 (ref), StopStarLoop (copy), StopCarouselLoop (copy), u28 (copy), u142 (copy), SunburstMask (copy), u27 (copy), StopParticleFloat (copy), u29 (copy), u9 (copy), u10 (copy), Bg (copy), Position (copy), TextFrame (copy), Position2 (copy), SetLineGradientReveal (copy), UIGradient2 (copy), UIGradient3 (copy), Content (copy)
    if u144 then
        u144:Cancel();
        u144 = nil;
    end;

    if u145 then
        u145:Cancel();
        u145 = nil;
    end;

    if u146 then
        u146:Cancel();
        u146 = nil;
    end;

    StopStarLoop();
    StopCarouselLoop();

    for _, v in u28 do
        v.Reset();
    end;

    u142.Reset();
    local v324 = SunburstMask;
    local v325 = v324:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
    v325.Parent = v324;
    v325.Scale = 1;

    for i in u27 do
        local v326 = u27[i];

        if v326 then
            v326.ExitToken = v326.ExitToken + 1;

            if v326.IntroTween then
                v326.IntroTween:Cancel();
                v326.IntroTween = nil;
            end;

            if v326.ExitTween then
                v326.ExitTween:Cancel();
                v326.ExitTween = nil;
            end;

            StopParticleFloat(v326.Threads, v326.Instance);
            v326.Instance.Visible = false;
            v326.Instance.Position = v326.BasePosition;
            v326.Scale.Scale = 0;
        end;
    end;

    for _, v in u29 do
        v.Reveal.Value = 0;
    end;

    if u9.Container then
        local v327 = u9;
        v327.Token = v327.Token + 1;

        if u9.Tween then
            u9.Tween:Cancel();
            u9.Tween = nil;
        end;

        u9.Container.Visible = false;
        local BasePosition = u9.BasePosition;
        u9.Container.Position = UDim2.new(BasePosition.X.Scale + -u10.REWARD_EXIT_OFFSET, BasePosition.X.Offset, BasePosition.Y.Scale, BasePosition.Y.Offset);
    end;

    local v328 = Position;
    Bg.Position = UDim2.new(v328.X.Scale + u10.BG_SWOOP_START_OFFSET, v328.X.Offset, v328.Y.Scale, v328.Y.Offset);
    local v329 = Position2;
    TextFrame.Position = UDim2.new(v329.X.Scale, v329.X.Offset, v329.Y.Scale + u10.TEXT_FRAME_START_Y_OFFSET, v329.Y.Offset);
    SetLineGradientReveal(UIGradient2, 0);
    SetLineGradientReveal(UIGradient3, 0);
    Content.Visible = false;
    Content.GroupTransparency = 0;
end;

local function BuildQuestData() -- Line: 1834
    -- upvalues: Knit (copy), StyleQuests (copy)
    local v330 = {};

    for i, v in Knit.GetController("Network").Player.StyleQuests do
        local v331 = StyleQuests[i];

        if v331 then
            local v332 = {};

            for _, v2 in v do
                local v333 = v331[v2.Index];

                if v333 then
                    local Metadata = v2.Metadata;
                    v332[v2.Index] = {
                        UniqueId = v2.UniqueId,
                        Title = v333.Name,
                        Subtitle = v333.Description,
                        Progress = typeof(Metadata[Metadata.Index]) == "number" and Metadata[Metadata.Index] or (typeof(Metadata[Metadata.Index]) == "table" and (#Metadata[Metadata.Index] or 0) or 0),
                        Goal = typeof(Metadata.Target) == "number" and Metadata.Target or (typeof(Metadata.Target) == "table" and #Metadata.Target or 0),
                        Claimed = v2.Claimed
                    };
                end;
            end;

            v330[i] = v332;
        end;
    end;

    return v330;
end;

function u8.PopulateQuests(p334) -- Line: 1867
    -- upvalues: u30 (ref), u13 (ref), PopulateQuestEntries (copy), u19 (ref), u15 (ref), u14 (ref), GetSortedNumericIndexes (copy), u31 (copy), u10 (copy), TweenService (copy), u9 (copy), PopulateRewards (copy)
    u30 = p334 or {};

    if u13 then
        PopulateQuestEntries(u19, true);
        local u335 = u15;
        local u336 = u14;
        local u337 = true;
        task.spawn(function() -- Line: 1616
            -- upvalues: GetSortedNumericIndexes (ref), u31 (ref), u335 (copy), u336 (copy), u13 (ref), u15 (ref), u14 (ref), u337 (copy), u10 (ref), TweenService (ref)
            for _, v in GetSortedNumericIndexes(u31) do
                local v338 = u335;
                local v339 = u336;
                local v340 = u13;

                if v340 then
                    if v338 == u15 then
                        v340 = v339 == u14;
                    else
                        v340 = false;
                    end;
                end;

                if not v340 then
                    return;
                end;

                local v341 = u31[v];

                if not (v341 and v341.Parent) then
                    return;
                end;

                local v342 = v341:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
                v342.Parent = v341;
                local Fill = v341:WaitForChild("ProgressBar"):WaitForChild("Fill");
                local u343 = v341:GetAttribute("ProgressAlpha") or 0;

                if u337 then
                    v342.Scale = 1;
                    Fill.Size = UDim2.new(u343, 0, Fill.Size.Y.Scale, Fill.Size.Y.Offset);
                else
                    TweenService:Create(v342, u10.QUEST_ENTRY_REVEAL_INFO, {
                        Scale = 1
                    }):Play();
                    task.delay(0.07, function() -- Line: 1640
                        -- upvalues: u335 (ref), u336 (ref), u13 (ref), u15 (ref), u14 (ref), Fill (copy), u10 (ref), u343 (copy), TweenService (ref)
                        local v344 = u335;
                        local v345 = u336;
                        local v346 = u13;

                        if v346 then
                            if v344 == u15 then
                                v346 = v345 == u14;
                            else
                                v346 = false;
                            end;
                        end;

                        if not (v346 and Fill.Parent) then
                            return;
                        end;

                        TweenService:Create(Fill, u10.QUEST_FILL_INFO, {
                            Size = UDim2.new(u343, 0, Fill.Size.Y.Scale, Fill.Size.Y.Offset)
                        }):Play();
                    end);
                    task.wait(u10.QUEST_ENTRY_STAGGER);
                end;
            end;
        end);

        if u9.Container and u9.Container.Visible then
            PopulateRewards(u19);
        end;
    end;
end;

function u8.UpdateQuestsGui() -- Line: 1880
    -- upvalues: u1 (copy), Knit (copy), u8 (copy), BuildQuestData (copy), ReplicatedStorage (copy), deep_equals (copy)
    u1:Clean();
    local Controller = Knit.GetController("Network");
    local StyleQuests2 = Controller.Player.StyleQuests;
    u8.PopulateQuests((BuildQuestData()));
    u1:Add(ReplicatedStorage.Controllers.NewData.Changed:Connect(function() -- Line: 1889
        -- upvalues: deep_equals (ref), StyleQuests2 (copy), Controller (copy), u8 (ref)
        if not deep_equals(StyleQuests2, Controller.Player.StyleQuests) then
            u8.UpdateQuestsGui();
        end;
    end));
end;

function u8.GetCategory() -- Line: 1897
    -- upvalues: u19 (ref)
    return u19;
end;

function u8.IsOpen() -- Line: 1901
    -- upvalues: u13 (ref)
    return u13;
end;

function u8.SetCategory(u347) -- Line: 1905
    -- upvalues: u13 (ref), u16 (ref), u19 (ref), script_StyleQuestsFrontEnd (copy), u14 (ref), u15 (ref), u29 (copy), SetNavButtonState (copy), SetPageColors (copy), SetPageTitle (copy), u27 (copy), StopParticleFloat (copy), LeaveHero (copy), SlideRewardsOut (copy), u28 (copy), u31 (copy), u10 (copy), TweenService (copy), PopulateQuestEntries (copy), GetSortedNumericIndexes (copy), ShowHero (copy), SlideRewardsIn (copy)
    if not u13 or u16 then
        return;
    end;

    if u347 == u19 or not script_StyleQuestsFrontEnd[u347] then
        return;
    end;

    u14 = u14 + 1;
    local u348 = u15;
    local u349 = u14;
    local v350 = u19;
    local v351 = script_StyleQuestsFrontEnd[u347];
    u19 = u347;

    for i, v in u29 do
        SetNavButtonState(v.Button, i == u19, true);
    end;

    SetPageColors(v351, true);
    SetPageTitle(v351.Title, true, u349);

    for i in u27 do
        if i ~= v350 then
            local v352 = u27[i];

            if v352 then
                v352.ExitToken = v352.ExitToken + 1;

                if v352.IntroTween then
                    v352.IntroTween:Cancel();
                    v352.IntroTween = nil;
                end;

                if v352.ExitTween then
                    v352.ExitTween:Cancel();
                    v352.ExitTween = nil;
                end;

                StopParticleFloat(v352.Threads, v352.Instance);
                v352.Instance.Visible = false;
                v352.Instance.Position = v352.BasePosition;
                v352.Scale.Scale = 0;
            end;
        end;
    end;

    LeaveHero(v350);
    SlideRewardsOut();
    local v353 = u28[v350];

    if v353 then
        v353.PlayExit();
    end;

    for _, v in u31 do
        if v.Parent then
            local v354 = v:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
            v354.Parent = v;
            TweenService:Create(v354, u10.QUEST_EXIT_INFO, {
                Scale = 0
            }):Play();
        end;
    end;

    task.delay(u10.PAGE_SWAP_DELAY, function() -- Line: 1948
        -- upvalues: u348 (copy), u349 (copy), u13 (ref), u15 (ref), u14 (ref), u28 (ref), u347 (copy), PopulateQuestEntries (ref), GetSortedNumericIndexes (ref), u31 (ref), u10 (ref), TweenService (ref), ShowHero (ref), SlideRewardsIn (ref)
        local v355 = u348;
        local v356 = u349;
        local v357 = u13;

        if v357 then
            if v355 == u15 then
                v357 = v356 == u14;
            else
                v357 = false;
            end;
        end;

        if not v357 then
            return;
        end;

        local v358 = u28[u347];

        if v358 then
            v358.Play(u348);
        end;

        PopulateQuestEntries(u347);
        local u359 = u348;
        local u360 = u349;
        local u361 = nil;
        task.spawn(function() -- Line: 1616
            -- upvalues: GetSortedNumericIndexes (ref), u31 (ref), u359 (copy), u360 (copy), u13 (ref), u15 (ref), u14 (ref), u361 (copy), u10 (ref), TweenService (ref)
            for _, v in GetSortedNumericIndexes(u31) do
                local v362 = u359;
                local v363 = u360;
                local v364 = u13;

                if v364 then
                    if v362 == u15 then
                        v364 = v363 == u14;
                    else
                        v364 = false;
                    end;
                end;

                if not v364 then
                    return;
                end;

                local v365 = u31[v];

                if not (v365 and v365.Parent) then
                    return;
                end;

                local v366 = v365:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
                v366.Parent = v365;
                local Fill = v365:WaitForChild("ProgressBar"):WaitForChild("Fill");
                local u367 = v365:GetAttribute("ProgressAlpha") or 0;

                if u361 then
                    v366.Scale = 1;
                    Fill.Size = UDim2.new(u367, 0, Fill.Size.Y.Scale, Fill.Size.Y.Offset);
                else
                    TweenService:Create(v366, u10.QUEST_ENTRY_REVEAL_INFO, {
                        Scale = 1
                    }):Play();
                    task.delay(0.07, function() -- Line: 1640
                        -- upvalues: u359 (ref), u360 (ref), u13 (ref), u15 (ref), u14 (ref), Fill (copy), u10 (ref), u367 (copy), TweenService (ref)
                        local v368 = u359;
                        local v369 = u360;
                        local v370 = u13;

                        if v370 then
                            if v368 == u15 then
                                v370 = v369 == u14;
                            else
                                v370 = false;
                            end;
                        end;

                        if not (v370 and Fill.Parent) then
                            return;
                        end;

                        TweenService:Create(Fill, u10.QUEST_FILL_INFO, {
                            Size = UDim2.new(u367, 0, Fill.Size.Y.Scale, Fill.Size.Y.Offset)
                        }):Play();
                    end);
                    task.wait(u10.QUEST_ENTRY_STAGGER);
                end;
            end;
        end);
        ShowHero(u347, u348, u349);
        SlideRewardsIn(u347);
    end);
end;

function u8.Open(p371) -- Line: 1967
    -- upvalues: u13 (ref), u16 (ref), u15 (ref), u14 (ref), Content (copy), u8 (copy), u28 (copy), u19 (ref), u142 (copy), PlaySunburstSpin (copy), PlayStarLoop (copy), Bg (copy), Position (copy), u10 (copy), TweenService (copy), TextFrame (copy), Position2 (copy), SetLineGradientReveal (copy), UIGradient2 (copy), UIGradient3 (copy), PlayCarouselLoop (copy), u11 (copy), u29 (copy), ShowHero (copy), GetSortedNumericIndexes (copy), u31 (copy), SlideRewardsIn (copy), AnimateLineDraw (copy)
    if u13 or u16 then
        return;
    end;

    u13 = true;
    u16 = true;
    u15 = u15 + 1;
    u14 = u14 + 1;
    local u372 = u15;
    local u373 = u14;
    Content.Parent.Enabled = true;
    u8.UpdateQuestsGui();
    Content.Visible = true;
    Content.GroupTransparency = 0;
    local v374 = u28[u19];

    if v374 then
        v374.Play(u372);
    end;

    u142.Play(u372);
    PlaySunburstSpin(u372);
    PlayStarLoop();
    local v375 = Position;
    Bg.Position = UDim2.new(v375.X.Scale + u10.BG_SWOOP_START_OFFSET, v375.X.Offset, v375.Y.Scale, v375.Y.Offset);
    TweenService:Create(Bg, TweenInfo.new(u10.BG_SWOOP_TIME, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        Position = Position
    }):Play();
    local v376 = Position2;
    TextFrame.Position = UDim2.new(v376.X.Scale, v376.X.Offset, v376.Y.Scale + u10.TEXT_FRAME_START_Y_OFFSET, v376.Y.Offset);
    TweenService:Create(TextFrame, TweenInfo.new(u10.TEXT_FRAME_INTRO_TIME, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Position = Position2
    }):Play();
    SetLineGradientReveal(UIGradient2, 0);
    SetLineGradientReveal(UIGradient3, 0);
    PlayCarouselLoop();
    task.spawn(function() -- Line: 1444
        -- upvalues: u10 (ref), u11 (ref), u372 (copy), u13 (ref), u15 (ref), u29 (ref), TweenService (ref)
        task.wait(u10.CATEGORY_REVEAL_DELAY);

        for _, v in u11 do
            if not (u13 and u372 == u15) then
                return;
            end;

            local v377 = u29[v];

            if v377 then
                TweenService:Create(v377.Reveal, u10.CATEGORY_REVEAL_INFO, {
                    Value = 1
                }):Play();
            end;

            task.wait(u10.CATEGORY_REVEAL_STAGGER);
        end;
    end);
    ShowHero(u19, u372, u373, function() -- Line: 2013
        -- upvalues: u16 (ref)
        u16 = false;
    end);
    local u378 = nil;
    task.spawn(function() -- Line: 1616
        -- upvalues: GetSortedNumericIndexes (ref), u31 (ref), u372 (copy), u373 (copy), u13 (ref), u15 (ref), u14 (ref), u378 (copy), u10 (ref), TweenService (ref)
        for _, v in GetSortedNumericIndexes(u31) do
            local v379 = u372;
            local v380 = u373;
            local v381 = u13;

            if v381 then
                if v379 == u15 then
                    v381 = v380 == u14;
                else
                    v381 = false;
                end;
            end;

            if not v381 then
                return;
            end;

            local v382 = u31[v];

            if not (v382 and v382.Parent) then
                return;
            end;

            local v383 = v382:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
            v383.Parent = v382;
            local Fill = v382:WaitForChild("ProgressBar"):WaitForChild("Fill");
            local u384 = v382:GetAttribute("ProgressAlpha") or 0;

            if u378 then
                v383.Scale = 1;
                Fill.Size = UDim2.new(u384, 0, Fill.Size.Y.Scale, Fill.Size.Y.Offset);
            else
                TweenService:Create(v383, u10.QUEST_ENTRY_REVEAL_INFO, {
                    Scale = 1
                }):Play();
                task.delay(0.07, function() -- Line: 1640
                    -- upvalues: u372 (ref), u373 (ref), u13 (ref), u15 (ref), u14 (ref), Fill (copy), u10 (ref), u384 (copy), TweenService (ref)
                    local v385 = u372;
                    local v386 = u373;
                    local v387 = u13;

                    if v387 then
                        if v385 == u15 then
                            v387 = v386 == u14;
                        else
                            v387 = false;
                        end;
                    end;

                    if not (v387 and Fill.Parent) then
                        return;
                    end;

                    TweenService:Create(Fill, u10.QUEST_FILL_INFO, {
                        Size = UDim2.new(u384, 0, Fill.Size.Y.Scale, Fill.Size.Y.Offset)
                    }):Play();
                end);
                task.wait(u10.QUEST_ENTRY_STAGGER);
            end;
        end;
    end);
    task.delay(u10.REWARD_INTRO_DELAY, function() -- Line: 2019
        -- upvalues: u372 (copy), u373 (copy), u13 (ref), u15 (ref), u14 (ref), SlideRewardsIn (ref), u19 (ref)
        local v388 = u372;
        local v389 = u373;
        local v390 = u13;

        if v390 then
            if v388 == u15 then
                v390 = v389 == u14;
            else
                v390 = false;
            end;
        end;

        if v390 then
            SlideRewardsIn(u19);
        end;
    end);
    task.delay(u10.LINE_DRAW_START_DELAY, function() -- Line: 2025
        -- upvalues: u372 (copy), u13 (ref), u15 (ref), AnimateLineDraw (ref), UIGradient2 (ref), u10 (ref), UIGradient3 (ref)
        if u13 and u372 == u15 then
            task.spawn(function() -- Line: 2027
                -- upvalues: AnimateLineDraw (ref), UIGradient2 (ref), u372 (ref)
                AnimateLineDraw(UIGradient2, u372);
            end);
            task.delay(u10.LINE_DRAW_STAGGER, function() -- Line: 2031
                -- upvalues: u372 (ref), u13 (ref), u15 (ref), AnimateLineDraw (ref), UIGradient3 (ref)
                if u13 and u372 == u15 then
                    task.spawn(function() -- Line: 2033
                        -- upvalues: AnimateLineDraw (ref), UIGradient3 (ref), u372 (ref)
                        AnimateLineDraw(UIGradient3, u372);
                    end);
                end;
            end);
        end;
    end);
end;

function u8.Close(p391) -- Line: 2042
    -- upvalues: u13 (ref), u16 (ref), Knit (copy), Content (copy), LocalPlayer (copy), u15 (ref), u14 (ref), u23 (ref), u26 (ref), u28 (copy), u142 (copy), Bg (copy), u10 (copy), Position (copy), TweenService (copy), TextFrame (copy), Position2 (copy), AnimateLineErase (copy), UIGradient2 (copy), UIGradient3 (copy), u27 (copy), u19 (ref), StopParticleFloat (copy), u31 (copy), PlayCategoryExit (copy), SlideRewardsOut (copy), ResetVisuals (copy)
    if not u13 or u16 then
        return;
    end;

    Knit.GetController("UIController"):Focus(false, Content.Parent);
    LocalPlayer.PlayerGui.HUD.Enabled = true;
    u13 = false;
    u16 = true;
    u15 = u15 + 1;
    u14 = u14 + 1;
    local u392 = u15;

    if u23 then
        task.cancel(u23);
        u23 = nil;
    end;

    if u26 then
        task.cancel(u26);
        u26 = nil;
    end;

    for _, v in u28 do
        v.PlayExit();
    end;

    u142.PlayExit();
    local TweenInfo_new_ret = TweenInfo.new(u10.BG_SWOOP_EXIT_TIME, Enum.EasingStyle.Quad, Enum.EasingDirection.In);
    local v393 = {};
    local v394 = Position;
    v393.Position = UDim2.new(v394.X.Scale + u10.BG_SWOOP_START_OFFSET, v394.X.Offset, v394.Y.Scale, v394.Y.Offset);
    TweenService:Create(Bg, TweenInfo_new_ret, v393):Play();
    local TweenInfo_new_ret2 = TweenInfo.new(u10.TEXT_FRAME_EXIT_TIME, Enum.EasingStyle.Back, Enum.EasingDirection.In);
    local v395 = {};
    local v396 = Position2;
    v395.Position = UDim2.new(v396.X.Scale, v396.X.Offset, v396.Y.Scale + u10.TEXT_FRAME_START_Y_OFFSET, v396.Y.Offset);
    TweenService:Create(TextFrame, TweenInfo_new_ret2, v395):Play();
    task.spawn(function() -- Line: 2082
        -- upvalues: AnimateLineErase (ref), UIGradient2 (ref), u392 (copy)
        AnimateLineErase(UIGradient2, u392);
    end);
    task.spawn(function() -- Line: 2086
        -- upvalues: AnimateLineErase (ref), UIGradient3 (ref), u392 (copy)
        AnimateLineErase(UIGradient3, u392);
    end);

    for i, v in u27 do
        if i == u19 and v.Instance.Visible then
            v.ExitToken = v.ExitToken + 1;

            if v.IntroTween then
                v.IntroTween:Cancel();
                v.IntroTween = nil;
            end;

            if v.ExitTween then
                v.ExitTween:Cancel();
                v.ExitTween = nil;
            end;

            StopParticleFloat(v.Threads, v.Instance);
            TweenService:Create(v.Scale, TweenInfo.new(u10.HERO_EXIT_SCALE_TIME, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
                Scale = 0
            }):Play();
        else
            local v397 = u27[i];

            if v397 then
                v397.ExitToken = v397.ExitToken + 1;

                if v397.IntroTween then
                    v397.IntroTween:Cancel();
                    v397.IntroTween = nil;
                end;

                if v397.ExitTween then
                    v397.ExitTween:Cancel();
                    v397.ExitTween = nil;
                end;

                StopParticleFloat(v397.Threads, v397.Instance);
                v397.Instance.Visible = false;
                v397.Instance.Position = v397.BasePosition;
                v397.Scale.Scale = 0;
            end;
        end;
    end;

    for _, v in u31 do
        if v.Parent then
            local v398 = v:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
            v398.Parent = v;
            TweenService:Create(v398, u10.QUEST_EXIT_INFO, {
                Scale = 0
            }):Play();
        end;
    end;

    PlayCategoryExit();
    SlideRewardsOut();
    local v399 = TweenService:Create(Content, TweenInfo.new(u10.HOLDER_FADE_TIME, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        GroupTransparency = 1
    });
    v399:Play();
    v399.Completed:Wait();
    ResetVisuals();
    u16 = false;
    Content.Parent.Enabled = false;
end;

function u8.Reset() -- Line: 2125
    -- upvalues: u13 (ref), u16 (ref), u15 (ref), u14 (ref), ResetVisuals (copy)
    u13 = false;
    u16 = false;
    u15 = u15 + 1;
    u14 = u14 + 1;
    ResetVisuals();
end;

function u8.KnitInit(p400) -- Line: 2134
end;

function u8.KnitStart(p401) -- Line: 2138
    -- upvalues: Knit (copy), BuildCategoryButtons (copy), ApplyCategoryInstant (copy), u18 (copy), ResetVisuals (copy), CloseButton (copy), u8 (copy), Content (copy), Effects (copy), u1 (copy), u10 (copy), LocalPlayer (copy)
    Knit.GetService("StyleQuestsService");
    BuildCategoryButtons();
    ApplyCategoryInstant(u18);
    ResetVisuals();
    CloseButton.Activated:Connect(function() -- Line: 2145
        -- upvalues: u8 (ref)
        u8:Close();
    end);
    Content.Parent:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 2149
        -- upvalues: Content (ref), u8 (ref), Effects (ref), u1 (ref)
        if Content.Parent.Enabled then
            u8:Open();
            Effects:Popup("At least 2 players per side are required for achievement progress!", 3, Color3.fromRGB(255, 0, 0));

            return;
        end;

        u8.Reset();
        u1:Clean();
    end);

    while not workspace:FindFirstChild("Rigs") do
        task.wait(0.1);
    end;

    for _, child in workspace.Rigs:GetChildren() do
        if table.find(u10.CATEGORY_ORDER, child.Name) then
            local ProximityPrompt = Instance.new("ProximityPrompt");
            ProximityPrompt.Parent = child.HumanoidRootPart;
            ProximityPrompt.Style = Enum.ProximityPromptStyle.Custom;
            ProximityPrompt.ActionText = string.upper(child.Name);
            ProximityPrompt.ObjectText = "ACHIEVEMENTS";
            ProximityPrompt.HoldDuration = 0.25;
            ProximityPrompt.RequiresLineOfSight = false;
            ProximityPrompt.Triggered:Connect(function() -- Line: 2173
                -- upvalues: LocalPlayer (ref), ApplyCategoryInstant (ref), child (copy), Knit (ref), Content (ref)
                if LocalPlayer.PlayerGui.StyleQuests.Enabled then
                    return;
                end;

                if LocalPlayer.PlayerGui.PickTeam.Enabled then
                    return;
                end;

                ApplyCategoryInstant(child.Name);
                Knit.GetController("UIController"):Focus(true, Content.Parent);
                LocalPlayer.PlayerGui.HUD.Enabled = false;
                Content.Parent.Enabled = true;
            end);
        end;
    end;
end;

return u8;