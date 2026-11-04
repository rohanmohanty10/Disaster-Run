 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ContentProvider");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Knit = require(ReplicatedStorage.Packages.Knit);
local Trove = require(ReplicatedStorage.Packages.Trove);
local NumberUtil = require(ReplicatedStorage.Shared.Utility.NumberUtil);
local GetUnixTime = require(ReplicatedStorage.Shared.Utility.GetUnixTime);
local LocalPlayer = game.Players.LocalPlayer;
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");
local HalloweenBundle = PlayerGui:WaitForChild("HalloweenBundle");
local HUD = PlayerGui:WaitForChild("HUD");
local HalloweenBundle2 = HUD:WaitForChild("Bundles"):WaitForChild("HalloweenBundle");
local ImageButton = HalloweenBundle2:WaitForChild("ImageButton");
local Reward = HalloweenBundle2:WaitForChild("Reward");
local Sunburst = HalloweenBundle2:WaitForChild("Sunburst");
local u1 = nil;
local Main = HalloweenBundle:WaitForChild("Main");
local UIScale = Main:WaitForChild("UIScale");
local CloseButton = Main:WaitForChild("CloseButton");
local BuyButton = Main:WaitForChild("BuyButton");
local SpinsOddsButton = Main:WaitForChild("SpinsOddsButton");
local ZonesOddsButton = Main:WaitForChild("ZonesOddsButton");
local Reward2 = Main:WaitForChild("Reward");
local ImageButton2 = Reward2:WaitForChild("ImageButton");
local RewardsFrame = Main:WaitForChild("RewardsFrame");
local Position = Main.Position;
local Position2 = Reward2.Position;
local u2 = {
    PANEL_POP_TIME = 0.38,
    HITSTOP_TIME = 0.09,
    IMPACT_DELAY = 0.16,
    JUMPSCARE_ZINDEX = 1000,
    JUMPSCARE_SEAL = 0.03,
    JUMPSCARE_BAR_MARGIN = 0.8,
    JUMPSCARE_START_SCALE = 0.16,
    JUMPSCARE_CREEP_TIME = 0.6,
    JUMPSCARE_CREEP_GROWTH = 1.4,
    JUMPSCARE_RECOIL_TIME = 0.07,
    JUMPSCARE_RECOIL = 0.72,
    JUMPSCARE_TIME = 0.46,
    JUMPSCARE_END_SCALE = 11,
    JUMPSCARE_FADE_AT = 0.5,
    JUMPSCARE_HOLD = 0.1,
    JUMPSCARE_JUDDER = 0.085,
    JUMPSCARE_SHAKE = 16,
    JUMPSCARE_TILT = 2.2,
    JUMPSCARE_HITCHES = 3,
    JUMPSCARE_HITCH_DROP = 0.22,
    JUMPSCARE_HITCH_FRAMES = 2,
    REWARD_CLOSED_IMAGE = "rbxassetid://113576912873176",
    REWARD_OPEN_IMAGE = "rbxassetid://130297365448427",
    REWARD_OPEN_DELAY = 0.22,
    REWARD_PARTICLES_DELAY = 0.1,
    MIST_DRIFT = 0.34,
    MIST_SWEEP_TIME = 9,
    SMOKE_START_SCALE = 0.25,
    SMOKE_END_SCALE = 1.45,
    SMOKE_GROW_TIME = 0.42,
    SMOKE_FADE_TIME = 0.85,
    SMOKE_PEAK_TRANSPARENCY = 0.04,
    GHOUL_COUNT = 9,
    GHOUL_STAGGER = 0.045,
    GHOUL_FLY_TIME = 1.05,
    GHOUL_TIME_VARIANCE = 0.3,
    GHOUL_START_SCALE = 0.25,
    GHOUL_MIN_SCALE = 1.5,
    GHOUL_MAX_SCALE = 3.4,
    GHOUL_REACH = 2.1,
    GHOUL_REACH_VARIANCE = 0.3,
    GHOUL_SPREAD = 0.85,
    GHOUL_VERTICAL_BIAS = 0.62,
    GHOUL_SPIN = 60,
    GHOUL_ARC = 0.22,
    GHOUL_CLEAR_AT = 0.45,
    GHOUL_BACK_ZINDEX = 4,
    GHOUL_FRONT_ZINDEX = 7,
    REWARD_SLAM_SCALE = 1.75,
    REWARD_SLAM_TIME = 0.26,
    REWARD_SETTLE_TIME = 0.55,
    REWARD_SLAM_TILT = 13,
    REWARD_BREATHE_MIN_TIME = 1.9,
    REWARD_BREATHE_MAX_TIME = 2.9,
    REWARD_BREATHE_SCALE = 0.024,
    REWARD_BREATHE_TILT = 1.5,
    STAR_BURST_DELAY = 0.14,
    STAR_BURST_STAGGER = 0.05,
    STAR_BURST_TIME = 0.46,
    STAR_BURST_SPREAD = 0.34,
    STAR_SPIN_MIN_TIME = 9,
    STAR_SPIN_MAX_TIME = 16,
    STAR_FADE_MIN_TIME = 1.3,
    STAR_FADE_MAX_TIME = 4.2,
    STAR_REST_TRANSPARENCY = 0.35,
    STAR_PEAK_TRANSPARENCY = 0.08,
    AURA_FLASH_TIME = 0.34,
    AURA_LOOP_TIME = 2.6,
    AURA_LOOP_HOLD = 1.1,
    AURA_START = -1.4,
    AURA_FINISH = 1.4,
    PARTICLE_MIN_TIME = 1.2,
    PARTICLE_MAX_TIME = 2.6,
    PARTICLE_RISE = 14,
    PARTICLE_DRIFT = 6,
    PARTICLE_SCALE = 0.08,
    PARTICLE_ROTATION = 5,
    PARTICLE_BURST_TIME = 0.44,
    PARTICLE_POP = 1.45,
    PARTICLE_BURST_STAGGER = 0.04,
    PARTICLE_BURST_SPREAD = 30,
    EMBER_PREFILL = 9,
    EMBER_MIN_DELAY = 0.28,
    EMBER_MAX_DELAY = 0.8,
    EMBER_MIN_TIME = 4.5,
    EMBER_MAX_TIME = 9.5,
    EMBER_MIN_SCALE = 0.35,
    EMBER_MAX_SCALE = 1.1,
    EMBER_SPAWN_Y = 1.12,
    EMBER_DESPAWN_Y = -0.12,
    EMBER_SWAY_MIN = 0.015,
    EMBER_SWAY_MAX = 0.06,
    EMBER_SPIN_MIN_TIME = 6,
    EMBER_SPIN_MAX_TIME = 14,
    EMBER_FADE_IN_TIME = 0.6,
    EMBER_FADE_OUT_TIME = 1,
    EMBER_BURST_COUNT = 12,
    EMBER_BURST_STAGGER = 0.03,
    GLOW_MIN_DELAY = 0.22,
    GLOW_MAX_DELAY = 0.6,
    GLOW_FADE_TIME = 0.45,
    GLOW_IDLE_MIN = 0,
    GLOW_IDLE_MAX = 0.3,
    GLOW_IDLE_TIME = 2.2,
    GLOW_FLICKER_MIN_DELAY = 4,
    GLOW_FLICKER_MAX_DELAY = 11,
    GRAD_SWEEP_TIME = 7,
    GRAD_SWEEP_HOLD = 0,
    GRAD_SWEEP_START = -2,
    GRAD_SWEEP_FINISH = 2,
    SUNBURST_SPIN_TIME = 15,
    SUNBURST_COUNTER_SPIN_TIME = 23,
    SUNBURST_KICK_TIME = 1.6,
    SUNBURST_KICK_DEGREES = 240,
    SUNBURST_INTRO_SCALE = 1.5,
    SUNBURST_BREATHE_TIME = 3.4,
    SUNBURST_BREATHE_SCALE = 1.04,
    BUTTON_SUNBURST_SPIN_TIME = 14,
    MOON_ENTRY_OFFSET = 0.42,
    MOON_ENTRY_TIME = 1.05,
    MOON_BOB = 0.022,
    MOON_BOB_MIN_TIME = 3,
    MOON_BOB_MAX_TIME = 4.6,
    PANEL_ENTRANCE_DELAY = 0.08,
    PANEL_ENTRANCE_TIME = 0.34,
    PANEL_ENTRANCE_STAGGER = 0.04,
    HEARTBEAT_TIME = 0.55,
    HEARTBEAT_SCALE = 1.045,
    HEARTBEAT_REST_MIN = 1.6,
    HEARTBEAT_REST_MAX = 3.2,
    EYE_CLOSED_OFFSET = 0.62,
    EYE_OPEN_OFFSET = -0.45,
    BUNDLE_EYE_STAGGER = 0.05,
    ENTRY_FADE_IN = 0.12,
    ENTRY_PREHOLD = 0.2,
    OPEN_DIM = 0.55,
    HERO_WIPE_CLOSED = 0.62,
    HERO_WIPE_OPEN = -0.45,
    HERO_WIPE_TIME = 0.42,
    HERO_INTRO_SCALE = 1,
    HERO_APPROACH_SCALE = 1.16,
    HERO_APPROACH_TIME = 1.1,
    HERO_DRIFT_SCALE = 1.05,
    HERO_PUNCH = 1.22,
    HERO_SETTLE_TIME = 0.5,
    HERO_HOLD = 0.42,
    HERO_COLD_COLOR = Color3.fromRGB(70, 98, 146),
    BAND_ROTATION = 45,
    BAND_LEFT_X = 0.19,
    BAND_RIGHT_X = 0.81,
    BAND_LENGTH = 2.8,
    BAND_COPIES = 6,
    BAND_TILE_ROTATION = 90,
    BAND_SCROLL_TIME = 3.4,
    BAND_SCROLL_FAST = 1.15,
    BAND_ENTRY_OFFSET = 0.8,
    BAND_ENTRY_TIME = 0.46,
    BAND_PUSH = 0.075,
    BAND_GAP = 1.35,
    PATTERN_ROWS = 2,
    PATTERN_SCROLL_TIME = 2.2,
    PATTERN_TILT = -8,
    PATTERN_LAYER_W = 1.9,
    PATTERN_LAYER_H = 1.7,
    PATTERN_OFFSET = 1.4,
    PATTERN_CLEARANCE = 0.1,
    BOOM_PUNCH = 1.07,
    BOOM_SETTLE = 0.55,
    BOOM_RECOIL = 0.9,
    PATTERN_COVER_TIME = 0.34,
    PATTERN_HOLD = 0.18,
    PATTERN_UNCOVER_TIME = 0.48,
    REVEAL_PIECES_AT = 0.35,
    SHOCKWAVE_COUNT = 3,
    SHOCKWAVE_TIME = 0.75,
    SHOCKWAVE_START = 0.06,
    SHOCKWAVE_END = 2.1,
    SHOCKWAVE_THICKNESS = 12,
    SHOCKWAVE_STAGGER = 0.09,
    SLASH_COUNT = 3,
    SLASH_TIME = 0.26,
    SLASH_STAGGER = 0.07,
    SLASH_THICKNESS = 18,
    SPEEDLINE_COUNT = 16,
    SPEEDLINE_BURST = 22,
    BURST_SPOKES = 18,
    BURST_TIME = 0.55,
    BURST_MIN_REACH = 0.35,
    BURST_MAX_REACH = 0.8,
    ENTRY_FADE_IN = 0.12,
    ENTRY_EXIT_TIME = 0.3,
    ENTRY_EXIT_SCALE = 1.08,
    BUNDLE_EYE_OPEN_TIME = 0.2,
    BUNDLE_BLINK_TIME = 0.06,
    BUNDLE_BLINK_MIN_DELAY = 2.2,
    BUNDLE_BLINK_MAX_DELAY = 5.5,
    BUNDLE_DOUBLE_BLINK_CHANCE = 30,
    BUNDLE_EYE_BREATHE = 0.025,
    BG_FLOAT_OFFSET = 7,
    BG_FLOAT_SCALE = 0.018,
    BG_FLOAT_MIN_TIME = 2.1,
    BG_FLOAT_MAX_TIME = 3.4,
    HEADER_FLOAT_OFFSET = 4,
    ENTRY_HITSTOP = 0.1,
    FLASH_TIME = 0.22,
    FLASH_PEAK = 0.12,
    FLASH_PEAK_SOFT = 0.45,
    HANDOFF_FLASH_IN = 0.14,
    QUIET_DIP_IN = 0.06,
    QUIET_HOLD = 0.32,
    QUIET_DIP_OUT = 0.26,
    QUIET_PEAK = 0.12,
    ENTRY_PREHOLD = 0.22,
    GRADE_COLD = Color3.fromRGB(52, 86, 148),
    GRADE_NEUTRAL = Color3.fromRGB(255, 255, 255),
    GRADE_HOT = Color3.fromRGB(255, 186, 122),
    FLASH_AMBER = Color3.fromRGB(255, 173, 84),
    FLASH_WHITE = Color3.fromRGB(255, 255, 255),
    FLASH_COLD = Color3.fromRGB(128, 186, 255),
    GRADE_DEEP_COLD = Color3.fromRGB(32, 58, 112),
    OPEN_DIM = 0.42,
    SNAP_PUNCH_SCALE = 1.07,
    TRIPLE_FLASH_GAP = 0.045,
    HANDOFF_FLASH_OUT = 0.5,
    PANEL_RISE_SCALE = 0.9
};
local YellowFill = Reward2:FindFirstChild("YellowFill");

if YellowFill then
    YellowFill = YellowFill:FindFirstChildOfClass("UIGradient");
end;

local SmokeTemplate = Main:WaitForChild("SmokeTemplate");
local JumpScareFrame = Main:WaitForChild("JumpScareFrame");
local Main2 = JumpScareFrame:WaitForChild("Main");
local UIScale2 = Main2:WaitForChild("UIScale");
local u3 = {};
local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = {};
local GhoulOne = Main:WaitForChild("GhoulOne");
local GhoulTwo = Main:WaitForChild("GhoulTwo");
local Position3 = GhoulOne.Position;
local Position4 = GhoulTwo.Position;
local Scale = GhoulOne:FindFirstChildOfClass("UIScale").Scale;
local Scale2 = GhoulTwo:FindFirstChildOfClass("UIScale").Scale;
local Position5 = SmokeTemplate.Position;
local Scale3 = SmokeTemplate:FindFirstChildOfClass("UIScale").Scale;
local u8 = nil;
local SmokeMask = Main:FindFirstChild("SmokeMask");

if SmokeMask then
    SmokeMask = SmokeMask:FindFirstChild("SmokeTemplate");
end;

local u9;

if SmokeMask then
    u9 = SmokeMask.Position;
else
    u9 = SmokeMask;
end;

local u10 = nil;
local SunburstMask = Main:WaitForChild("SunburstMask");
local Sunburst2 = SunburstMask:WaitForChild("Sunburst");
local SunburstCounter = SunburstMask:WaitForChild("SunburstCounter");
local Backdrop = Main:WaitForChild("Backdrop");
local CanvasGroup = Backdrop:WaitForChild("CanvasGroup");
local GlowTemplate = CanvasGroup:WaitForChild("GlowTemplate");
local UIGradient = Backdrop:WaitForChild("Grad"):WaitForChild("UIGradient");
local GlowMask = Main:FindFirstChild("GlowMask");
local ParticlesMask = Main:FindFirstChild("ParticlesMask");
local u11;

if ParticlesMask then
    u11 = ParticlesMask:FindFirstChild("StarTemplate");
else
    u11 = ParticlesMask;
end;

local BgMask = Main:WaitForChild("BgMask");
local Moon = BgMask:FindFirstChild("Moon");
local u12 = Moon and Moon.Position or UDim2.new();
local LeftEye = BgMask:FindFirstChild("LeftEye");
local RightEye = BgMask:FindFirstChild("RightEye");
local u13;

if LeftEye then
    u13 = LeftEye:FindFirstChild("ClosingGrad");
else
    u13 = LeftEye;
end;

local u14;

if RightEye then
    u14 = RightEye:FindFirstChild("ClosingGrad");
else
    u14 = RightEye;
end;

local u15 = BgMask:FindFirstChild("NarutoIcon") or BgMask:FindFirstChild("CentreText");
local u16 = u15 and u15.Position or UDim2.new();
local Header = Main:FindFirstChild("Header");
local u17 = Header and Header.Position or UDim2.new();
local u18 = nil;
local u19 = nil;
local Shine = BuyButton:WaitForChild("Shine");
local Shine2 = Shine:WaitForChild("Shine");
local EntryAnimation = HalloweenBundle:WaitForChild("EntryAnimation");
local RightEye2 = EntryAnimation:WaitForChild("RightEye");
local ClosingGrad = RightEye2:WaitForChild("ClosingGrad");
local Position6 = RightEye2.Position;
local ImageColor3 = RightEye2.ImageColor3;
local Frame = Instance.new("Frame");
Frame.Name = "EntryFlash";
Frame.BackgroundColor3 = Color3.new(1, 1, 1);
Frame.BorderSizePixel = 0;
Frame.AnchorPoint = Vector2.new(0.5, 0.5);
Frame.Position = UDim2.fromScale(0.5, 0.5);
Frame.Size = UDim2.fromScale(1.2, 1.2);
Frame.BackgroundTransparency = 1;
Frame.ZIndex = 500;
Frame.Parent = HalloweenBundle;
local Frame2 = Instance.new("Frame");
Frame2.Name = "EntryDim";
Frame2.BackgroundColor3 = Color3.new(0, 0, 0);
Frame2.BorderSizePixel = 0;
Frame2.AnchorPoint = Vector2.new(0.5, 0.5);
Frame2.Position = UDim2.fromScale(0.5, 0.5);
Frame2.Size = UDim2.fromScale(1.2, 1.2);
Frame2.BackgroundTransparency = 1;
Frame2.ZIndex = 499;
Frame2.Parent = HalloweenBundle;
local Frame3 = Instance.new("Frame");
Frame3.Name = "EntryFx";
Frame3.BackgroundTransparency = 1;
Frame3.BorderSizePixel = 0;
Frame3.AnchorPoint = Vector2.new(0.5, 0.5);
Frame3.Position = UDim2.fromScale(0.5, 0.5);
Frame3.Size = UDim2.fromScale(1, 1);
Frame3.ZIndex = 400;
Frame3.Parent = HalloweenBundle;
local PatternInfiniteLoop = EntryAnimation:WaitForChild("PatternInfiniteLoop");
local v20 = PatternInfiniteLoop:FindFirstChildOfClass("UIAspectRatioConstraint");
local u21 = v20 and v20.AspectRatio or 1;
local u22 = nil;
local Frame4 = Instance.new("Frame");
Frame4.Name = "EntryPatternLayer";
Frame4.BackgroundTransparency = 1;
Frame4.BorderSizePixel = 0;
Frame4.AnchorPoint = Vector2.new(0.5, 0.5);
Frame4.Position = UDim2.fromScale(0.5, 0.5);
Frame4.Size = UDim2.fromScale(1.9, 1.7);
Frame4.Rotation = -8;
Frame4.ClipsDescendants = true;
Frame4.Visible = false;
Frame4.ZIndex = 505;
Frame4.Parent = HalloweenBundle;
local math_abs_ret = math.abs(u2.PATTERN_TILT);
local math_rad_ret = math.rad(math_abs_ret);
local u23 = 0.5 + (u2.PATTERN_LAYER_W * math.cos(math_rad_ret) + u2.PATTERN_LAYER_H * math.sin(math_rad_ret)) / 2 + u2.PATTERN_CLEARANCE;
local Frame5 = Instance.new("Frame");
Frame5.Name = "EntryPatternScroller";
Frame5.BackgroundTransparency = 1;
Frame5.BorderSizePixel = 0;
Frame5.AnchorPoint = Vector2.new(0, 0);
Frame5.Position = UDim2.fromScale(0, 0);
Frame5.Size = UDim2.fromScale(1, 1);
Frame5.ZIndex = 505;
Frame5.Parent = Frame4;
local u24 = false;
local u25 = false;
local u26 = false;
local u27 = false;
local u28 = nil;
local u29 = nil;
local u30 = nil;
local u31 = nil;
local u32 = nil;
local u33 = nil;
local u34 = nil;
local u35 = 0;
local u36 = {};
local u37 = {};
local u38 = {};
local u39 = {};
local u40 = {};
local u41 = {};
local u42 = {};
local u43 = nil;
local u44 = nil;
local u45 = nil;
local u46 = nil;
local u47 = nil;
local u48 = {};
local u49 = nil;
local u50 = {};
local u51 = {};
local u52 = {};
local u53 = u11 and (u11.ImageTransparency or 0) or 0;
local ImageTransparency = SunburstCounter.ImageTransparency;
local Cash = ReplicatedStorage.Assets.SFX.UI.Cash;
local OpenMusic = ReplicatedStorage.Assets.SFX.UI.OpenMusic;
local BoxOpen = ReplicatedStorage.Assets.SFX.UI.BoxOpen;
local EvilChime = ReplicatedStorage.Assets.SFX.UI.EvilChime;
local GlitchShow = ReplicatedStorage.Assets.SFX.UI.GlitchShow;
local GlitchClose = ReplicatedStorage.Assets.SFX.UI.GlitchClose;
local GlitchFlicker = ReplicatedStorage.Assets.SFX.UI.GlitchFlicker;
SmokeTemplate.Visible = false;
GlowTemplate.Visible = false;

if u11 then
    u11.Visible = false;
end;

local u54 = Trove.new();
local u55 = Knit.CreateController({
    Name = "HalloweenBundle"
});

local function tween(p56, p57, p58) -- Line: 705
    -- upvalues: TweenService (copy)
    local v59 = TweenService:Create(p56, p57, p58);
    v59:Play();

    return v59;
end;

local function getScale(p60) -- Line: 711
    local v61 = p60:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
    v61.Parent = p60;

    return v61;
end;

local function playSound(p62: userdata?, p63: number?) -- Line: 717
    if not p62 then
        return;
    end;

    local u64 = p62:Clone();

    if p63 then
        u64.Volume = p63;
    end;

    u64.Parent = workspace.Debris;
    u64:Play();
    u64.Ended:Once(function() -- Line: 731
        -- upvalues: u64 (copy)
        u64:Destroy();
    end);
end;

local function trackEffect(p65: userdata) -- Line: 736
    -- upvalues: u51 (copy)
    u51[p65] = true;
end;

local function releaseEffect(p66: userdata) -- Line: 740
    -- upvalues: u51 (copy)
    u51[p66] = nil;

    if p66.Parent then
        p66:Destroy();
    end;
end;

local function clearEffects() -- Line: 748
    -- upvalues: u51 (copy)
    for i in u51 do
        if i and i.Parent then
            i:Destroy();
        end;
    end;

    table.clear(u51);
end;

local function cancelTween(p67) -- Line: 758
    if p67 then
        p67:Cancel();
    end;

    return nil;
end;

local function playMainImpact(u68) -- Line: 767
    -- upvalues: u24 (ref), Main (copy), Position (copy)
    task.spawn(function() -- Line: 768
        -- upvalues: u68 (copy), u24 (ref), Main (ref), Position (ref)
        for _, v in u68 do
            if not u24 then
                break;
            end;

            Main.Position = UDim2.new(Position.X.Scale, Position.X.Offset + math.random(-v, v), Position.Y.Scale, Position.Y.Offset + math.random(-v, v));
            task.wait(0.02);
        end;

        Main.Position = Position;
    end);
end;

local function stopAura() -- Line: 788
    -- upvalues: YellowFill (copy), u32 (ref), u2 (copy)
    if not YellowFill then
        return;
    end;

    local v69 = u32;

    if v69 then
        v69:Cancel();
    end;

    u32 = nil;
    YellowFill.Offset = Vector2.new(u2.AURA_START, 0);
end;

local function playAuraSweep(p70: boolean) -- Line: 798
    -- upvalues: YellowFill (copy), u32 (ref), u2 (copy), u35 (ref), TweenService (copy), u24 (ref)
    if not YellowFill then
        return;
    end;

    if YellowFill then
        local v71 = u32;

        if v71 then
            v71:Cancel();
        end;

        u32 = nil;
        YellowFill.Offset = Vector2.new(u2.AURA_START, 0);
    end;

    local u72 = u35;
    YellowFill.Offset = Vector2.new(u2.AURA_START, 0);
    local v73 = TweenService:Create(YellowFill, TweenInfo.new(u2.AURA_FLASH_TIME, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Offset = Vector2.new(u2.AURA_FINISH, 0)
    });
    v73:Play();

    if not p70 then
        return;
    end;

    v73.Completed:Once(function() -- Line: 819
        -- upvalues: u24 (ref), u72 (copy), u35 (ref), YellowFill (ref), u2 (ref), u32 (ref), TweenService (ref)
        if not u24 or u72 ~= u35 then
            return;
        end;

        YellowFill.Offset = Vector2.new(u2.AURA_START, 0);
        local v74 = TweenService:Create(YellowFill, TweenInfo.new(u2.AURA_LOOP_TIME, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, false, u2.AURA_LOOP_HOLD), {
            Offset = Vector2.new(u2.AURA_FINISH, 0)
        });
        v74:Play();
        u32 = v74;
    end);
end;

local function cacheStars() -- Line: 841
    -- upvalues: Reward2 (copy), u41 (copy), u42 (copy)
    for _, child in Reward2:GetChildren() do
        if child:IsA("ImageLabel") and (child.Name == "Star" and not u41[child]) then
            u41[child] = child.Position;
            u42[child] = child.Rotation;
        end;
    end;
end;

local function hideStars() -- Line: 850
    -- upvalues: cacheStars (copy), Reward2 (copy), u41 (copy), u42 (copy)
    cacheStars();

    for _, child in Reward2:GetChildren() do
        if child:IsA("ImageLabel") and child.Name == "Star" then
            child.Visible = false;
            child.Position = u41[child];
            child.Rotation = u42[child];
            child.ImageTransparency = 1;
            local v75 = child:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
            v75.Parent = child;
            v75.Scale = 1;
        end;
    end;
end;

local function burstStarsIn(u76) -- Line: 865
    -- upvalues: cacheStars (copy), Reward2 (copy), u41 (copy), u42 (copy), u2 (copy), TweenService (copy)
    cacheStars();
    local v77 = 0;

    for _, child in Reward2:GetChildren() do
        if child:IsA("ImageLabel") and child.Name == "Star" then
            local u78 = u41[child];
            local u79 = u42[child];
            local u80 = child:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
            u80.Parent = child;
            local v81 = u2.STAR_BURST_DELAY + v77 * u2.STAR_BURST_STAGGER;
            v77 = v77 + 1;
            local v82 = math.random() * 3.141592653589793 * 2;
            local v83 = math.random(u2.STAR_BURST_SPREAD * 50, u2.STAR_BURST_SPREAD * 100) / 100;
            child.Visible = false;
            child.ImageTransparency = 1;
            u80.Scale = 0.2;
            child.Position = u78 + UDim2.fromScale(math.cos(v82) * v83, math.sin(v82) * v83);
            child.Rotation = u79 + math.random(-140, 140);
            task.delay(v81, function() -- Line: 896
                -- upvalues: child (copy), u2 (ref), TweenService (ref), u80 (copy), u78 (copy), u79 (copy), u76 (copy)
                if not child.Parent then
                    return;
                end;

                child.Visible = true;
                TweenService:Create(child, TweenInfo.new(u2.STAR_BURST_TIME * 0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    ImageTransparency = u2.STAR_REST_TRANSPARENCY
                }):Play();
                TweenService:Create(u80, TweenInfo.new(u2.STAR_BURST_TIME, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                    Scale = 1
                }):Play();
                local v84 = TweenService:Create(child, TweenInfo.new(u2.STAR_BURST_TIME, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                    Position = u78,
                    Rotation = u79
                });
                v84:Play();
                v84.Completed:Once(function() -- Line: 914
                    -- upvalues: child (ref), u76 (ref), u2 (ref), u79 (ref), TweenService (ref)
                    if not child.Parent then
                        return;
                    end;

                    local v85 = TweenService:Create(child, TweenInfo.new(math.random(u2.STAR_SPIN_MIN_TIME, u2.STAR_SPIN_MAX_TIME), Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1), {
                        Rotation = u79 + 360
                    });
                    v85:Play();
                    table.insert(u76, v85);
                    local v86 = TweenService:Create(child, TweenInfo.new(math.random(u2.STAR_FADE_MIN_TIME * 10, u2.STAR_FADE_MAX_TIME * 10) / 10, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
                        ImageTransparency = u2.STAR_PEAK_TRANSPARENCY
                    });
                    v86:Play();
                    table.insert(u76, v86);
                end);
            end);
        end;
    end;
end;

local function cacheParticle(p87: userdata) -- Line: 946
    -- upvalues: u39 (copy), u40 (copy), u7 (copy)
    if not u39[p87] then
        u39[p87] = p87.Position;
        u40[p87] = p87.Rotation;
        u7[p87] = p87.ImageTransparency;
    end;
end;

local function stopParticleFloat(p88: any, p89: userdata) -- Line: 954
    -- upvalues: u39 (copy), u40 (copy)
    for _, v in p88 do
        task.cancel(v);
    end;

    table.clear(p88);

    for _, child in p89:GetChildren() do
        if child:IsA("ImageLabel") and child.Name == "Particles" then
            if u39[child] then
                child.Position = u39[child];
                child.Rotation = u40[child];
            end;

            local v90 = child:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
            v90.Parent = child;
            v90.Scale = 1;
        end;
    end;
end;

local function burstParticlesIn(p91: userdata) -- Line: 973
    -- upvalues: u39 (copy), u40 (copy), u7 (copy), u2 (copy), TweenService (copy)
    local v92 = 0;

    for _, child in p91:GetChildren() do
        if child:IsA("ImageLabel") and child.Name == "Particles" then
            if not u39[child] then
                u39[child] = child.Position;
                u40[child] = child.Rotation;
                u7[child] = child.ImageTransparency;
            end;

            local u93 = u39[child];
            local u94 = u40[child];
            local u95 = child:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
            u95.Parent = child;
            local v96 = v92 * u2.PARTICLE_BURST_STAGGER;
            v92 = v92 + 1;
            u95.Scale = 0;
            child.ImageTransparency = 1;
            child.Position = u93 + UDim2.fromOffset(math.random(-u2.PARTICLE_BURST_SPREAD, u2.PARTICLE_BURST_SPREAD), math.random(-u2.PARTICLE_BURST_SPREAD, u2.PARTICLE_BURST_SPREAD));
            child.Rotation = u94 + math.random(-45, 45);
            task.delay(v96, function() -- Line: 1000
                -- upvalues: child (copy), u95 (copy), u2 (ref), TweenService (ref), u93 (copy), u94 (copy), u7 (ref)
                if not child.Parent then
                    return;
                end;

                local v97 = TweenService:Create(u95, TweenInfo.new(u2.PARTICLE_BURST_TIME * 0.55, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                    Scale = u2.PARTICLE_POP
                });
                v97:Play();
                v97.Completed:Once(function() -- Line: 1009
                    -- upvalues: child (ref), u95 (ref), u2 (ref), TweenService (ref)
                    if not child.Parent then
                        return;
                    end;

                    TweenService:Create(u95, TweenInfo.new(u2.PARTICLE_BURST_TIME * 0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        Scale = 1
                    }):Play();
                end);
                TweenService:Create(child, TweenInfo.new(u2.PARTICLE_BURST_TIME, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                    Position = u93,
                    Rotation = u94
                }):Play();
                TweenService:Create(child, TweenInfo.new(u2.PARTICLE_BURST_TIME * 0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    ImageTransparency = u7[child] or 0
                }):Play();
            end);
        end;
    end;
end;

local function startParticleFloat(p98: userdata, p99: any, u100: any, u101: number?) -- Line: 1032
    -- upvalues: stopParticleFloat (copy), u39 (copy), u40 (copy), u7 (copy), u2 (copy), TweenService (copy)
    stopParticleFloat(p99, p98);

    for _, child in p98:GetChildren() do
        if child:IsA("ImageLabel") and child.Name == "Particles" then
            if not u39[child] then
                u39[child] = child.Position;
                u40[child] = child.Rotation;
                u7[child] = child.ImageTransparency;
            end;

            local u102 = u39[child];
            local u103 = u40[child];
            local u104 = child:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
            u104.Parent = child;
            local Random_new = Random.new;
            local v105 = os.clock() * 1000000;
            local u106 = Random_new(math.floor(v105) + math.random(1, 100000));
            local task_spawn_ret = task.spawn(function() -- Line: 1050
                -- upvalues: u101 (copy), u106 (copy), u100 (copy), child (copy), u2 (ref), u102 (copy), u103 (copy), TweenService (ref), u104 (copy)
                task.wait((u101 or 0) + u106:NextNumber(0, 1.2));
                local v107 = u106:NextInteger(0, 1) == 0;

                while u100() and child.Parent do
                    local v108 = u106:NextNumber(u2.PARTICLE_MIN_TIME, u2.PARTICLE_MAX_TIME);
                    local TweenInfo_new_ret = TweenInfo.new(v108, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
                    local v109 = u106:NextInteger(u2.PARTICLE_RISE * 0.4, u2.PARTICLE_RISE);
                    local v110 = u106:NextInteger(-u2.PARTICLE_DRIFT, u2.PARTICLE_DRIFT);
                    local v111 = {};

                    if v107 then
                        v109 = -v109 or v109;
                    end;

                    v111.Position = u102 + UDim2.fromOffset(v110, v109);
                    v111.Rotation = u103 + u106:NextNumber(-u2.PARTICLE_ROTATION, u2.PARTICLE_ROTATION);
                    local v112 = TweenService:Create(child, TweenInfo_new_ret, v111);
                    v112:Play();
                    TweenService:Create(u104, TweenInfo_new_ret, {
                        Scale = 1 + u106:NextNumber(-u2.PARTICLE_SCALE, u2.PARTICLE_SCALE)
                    }):Play();
                    v112.Completed:Wait();
                    v107 = not v107;
                end;

                if child.Parent then
                    child.Position = u102;
                    child.Rotation = u103;
                    u104.Scale = 1;
                end;
            end);
            table.insert(p99, task_spawn_ret);
        end;
    end;
end;

local function spawnEmber(p113: number?) -- Line: 1088
    -- upvalues: u11 (copy), ParticlesMask (copy), u2 (copy), u48 (copy), TweenService (copy), u53 (copy)
    if not (u11 and ParticlesMask) then
        return;
    end;

    local v114 = p113 or 0;
    local u115 = u11:Clone();
    local v116 = u115:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
    v116.Parent = u115;
    local math_random_ret = math.random();
    v116.Scale = u2.EMBER_MIN_SCALE + (u2.EMBER_MAX_SCALE - u2.EMBER_MIN_SCALE) * math_random_ret;
    local u117 = math.random(4, 96) / 100;
    local u118 = math.random(u2.EMBER_SWAY_MIN * 1000, u2.EMBER_SWAY_MAX * 1000) / 1000;
    local u119 = math.random(10, 24) / 10;
    local u120 = math.random() * 3.141592653589793 * 2;
    local u121 = math.random(-5, 5) / 100;
    u115.AnchorPoint = Vector2.new(0.5, 0.5);
    u115.Rotation = math.random(0, 359);
    u115.ImageTransparency = 1;
    u115.ZIndex = math_random_ret > 0.6 and 2 or 1;
    u115.Visible = true;
    u115.Parent = ParticlesMask;
    table.insert(u48, u115);
    local v122 = math.random(u2.EMBER_MIN_TIME * 10, u2.EMBER_MAX_TIME * 10) / 10 * (1 + (1 - math_random_ret) * 0.4) * (1 - v114);
    TweenService:Create(u115, TweenInfo.new(math.random(u2.EMBER_SPIN_MIN_TIME, u2.EMBER_SPIN_MAX_TIME), Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1), {
        Rotation = u115.Rotation + (math.random(0, 1) == 0 and -360 or 360)
    }):Play();
    TweenService:Create(u115, TweenInfo.new(u2.EMBER_FADE_IN_TIME, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        ImageTransparency = u53
    }):Play();
    task.delay(math.max(v122 - u2.EMBER_FADE_OUT_TIME, u2.EMBER_FADE_IN_TIME), function() -- Line: 1140
        -- upvalues: u115 (copy), u2 (ref), TweenService (ref)
        if u115.Parent then
            TweenService:Create(u115, TweenInfo.new(u2.EMBER_FADE_OUT_TIME, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                ImageTransparency = 1
            }):Play();
        end;
    end);
    local NumberValue = Instance.new("NumberValue");
    NumberValue.Value = v114;
    local u123 = NumberValue:GetPropertyChangedSignal("Value"):Connect(function() -- Line: 1153
        -- upvalues: NumberValue (copy), u115 (copy), u117 (copy), u121 (copy), u120 (copy), u119 (copy), u118 (copy), u2 (ref)
        local Value = NumberValue.Value;
        u115.Position = UDim2.fromScale(u117 + u121 * Value + math.sin(u120 + Value * 3.141592653589793 * 2 * u119) * u118, u2.EMBER_SPAWN_Y + (u2.EMBER_DESPAWN_Y - u2.EMBER_SPAWN_Y) * Value);
    end);
    u115.Position = UDim2.fromScale(u117 + math.sin(u120) * u118, u2.EMBER_SPAWN_Y + (u2.EMBER_DESPAWN_Y - u2.EMBER_SPAWN_Y) * v114);
    local v124 = TweenService:Create(NumberValue, TweenInfo.new(v122, Enum.EasingStyle.Linear), {
        Value = 1
    });
    v124:Play();
    v124.Completed:Once(function() -- Line: 1167
        -- upvalues: u123 (copy), NumberValue (copy), u48 (ref), u115 (copy)
        u123:Disconnect();
        NumberValue:Destroy();
        local table_find_ret = table.find(u48, u115);

        if table_find_ret then
            table.remove(u48, table_find_ret);
        end;

        if u115.Parent then
            u115:Destroy();
        end;
    end);
end;

local function playEmberBurst() -- Line: 1183
    -- upvalues: u2 (copy), u24 (ref), spawnEmber (copy)
    task.spawn(function() -- Line: 1184
        -- upvalues: u2 (ref), u24 (ref), spawnEmber (ref)
        for i = 1, u2.EMBER_BURST_COUNT do
            if not u24 then
                break;
            end;

            spawnEmber(math.random(0, 22) / 100);
            task.wait(u2.EMBER_BURST_STAGGER);
            local _ = i;
        end;
    end);
end;

local function stopEmberLoop() -- Line: 1197
    -- upvalues: u47 (ref), u48 (copy)
    if u47 then
        task.cancel(u47);
        u47 = nil;
    end;

    for _, v in u48 do
        v:Destroy();
    end;

    table.clear(u48);
end;

local function playEmberLoop() -- Line: 1210
    -- upvalues: stopEmberLoop (copy), u2 (copy), spawnEmber (copy), u47 (ref), u24 (ref)
    stopEmberLoop();

    for i = 1, u2.EMBER_PREFILL do
        spawnEmber(math.random(5, 90) / 100);
        local _ = i;
    end;

    u47 = task.spawn(function() -- Line: 1217
        -- upvalues: u24 (ref), u2 (ref), spawnEmber (ref)
        while u24 do
            task.wait(math.random(u2.EMBER_MIN_DELAY * 100, u2.EMBER_MAX_DELAY * 100) / 100);
            spawnEmber();
        end;
    end);
end;

local function spawnGlow() -- Line: 1225
    -- upvalues: GlowTemplate (copy), CanvasGroup (copy), u50 (copy), TweenService (copy)
    local u125 = GlowTemplate:Clone();
    local v126 = u125:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
    v126.Parent = u125;
    local v127 = math.random(-3, 103) / 100;
    local v128 = v127 + math.random(-12, 12) / 100;
    local math_clamp_ret = math.clamp(v128, -0.06, 1.06);
    u125.AnchorPoint = Vector2.new(0.5, 0.5);
    u125.Position = UDim2.fromScale(v127, math.random(101, 108) / 100);
    u125.Rotation = math.random(-18, 18);
    u125.ImageTransparency = 1;
    u125.Visible = true;
    u125.Parent = CanvasGroup;
    v126.Scale = math.random(45, 105) / 100;
    table.insert(u50, u125);
    TweenService:Create(u125, TweenInfo.new(math.random(45, 85) / 100, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        ImageTransparency = math.random(20, 52) / 100
    }):Play();
    local v129 = math.random(65, 105) / 10;
    local v130 = TweenService:Create(u125, TweenInfo.new(v129, Enum.EasingStyle.Linear), {
        Position = UDim2.fromScale(math_clamp_ret, math.random(-16, -6) / 100)
    });
    v130:Play();
    v130.Completed:Once(function() -- Line: 1250
        -- upvalues: u50 (ref), u125 (copy)
        local table_find_ret = table.find(u50, u125);

        if table_find_ret then
            table.remove(u50, table_find_ret);
        end;

        u125:Destroy();
    end);
    task.delay(v129 - 0.6, function() -- Line: 1260
        -- upvalues: u125 (copy), TweenService (ref)
        if u125.Parent then
            TweenService:Create(u125, TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                ImageTransparency = 1
            }):Play();
        end;
    end);
end;

local function stopGlowLoop() -- Line: 1269
    -- upvalues: u49 (ref), u50 (copy)
    if u49 then
        task.cancel(u49);
        u49 = nil;
    end;

    for _, v in u50 do
        v:Destroy();
    end;

    table.clear(u50);
end;

local function playGlowLoop() -- Line: 1282
    -- upvalues: stopGlowLoop (copy), u49 (ref), u24 (ref), spawnGlow (copy), u2 (copy)
    stopGlowLoop();
    u49 = task.spawn(function() -- Line: 1285
        -- upvalues: u24 (ref), spawnGlow (ref), u2 (ref)
        while u24 do
            spawnGlow();
            task.wait(math.random(u2.GLOW_MIN_DELAY * 100, u2.GLOW_MAX_DELAY * 100) / 100);
        end;
    end);
end;

local function stopGlowMask() -- Line: 1293
    -- upvalues: GlowMask (copy), u33 (ref), u46 (ref)
    if not GlowMask then
        return;
    end;

    local v131 = u33;

    if v131 then
        v131:Cancel();
    end;

    u33 = nil;

    if u46 then
        task.cancel(u46);
        u46 = nil;
    end;

    GlowMask.GroupTransparency = 1;
end;

local function playGlowMask(u132: number) -- Line: 1309
    -- upvalues: GlowMask (copy), u33 (ref), u46 (ref), u2 (copy), TweenService (copy), u24 (ref), u35 (ref), playSound (copy), GlitchFlicker (copy)
    if not GlowMask then
        return;
    end;

    if GlowMask then
        local v133 = u33;

        if v133 then
            v133:Cancel();
        end;

        u33 = nil;

        if u46 then
            task.cancel(u46);
            u46 = nil;
        end;

        GlowMask.GroupTransparency = 1;
    end;

    local v134 = TweenService:Create(GlowMask, TweenInfo.new(u2.GLOW_FADE_TIME, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        GroupTransparency = u2.GLOW_IDLE_MIN
    });
    v134:Play();
    v134.Completed:Once(function() -- Line: 1322
        -- upvalues: u24 (ref), u132 (copy), u35 (ref), u33 (ref), GlowMask (ref), u2 (ref), TweenService (ref)
        if not u24 or u132 ~= u35 then
            return;
        end;

        local v135 = TweenService:Create(GlowMask, TweenInfo.new(u2.GLOW_IDLE_TIME, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
            GroupTransparency = u2.GLOW_IDLE_MAX
        });
        v135:Play();
        u33 = v135;
    end);
    u46 = task.spawn(function() -- Line: 1334
        -- upvalues: u24 (ref), u132 (copy), u35 (ref), u2 (ref), playSound (ref), GlitchFlicker (ref), u33 (ref), GlowMask (ref), TweenService (ref)
        while u24 and u132 == u35 do
            task.wait(math.random(u2.GLOW_FLICKER_MIN_DELAY * 10, u2.GLOW_FLICKER_MAX_DELAY * 10) / 10);

            if not u24 or u132 ~= u35 then
                break;
            end;

            playSound(GlitchFlicker, 0.35);
            local v136 = u33;

            if v136 then
                v136:Cancel();
            end;

            u33 = nil;

            for i = 1, math.random(2, 4) do
                GlowMask.GroupTransparency = math.random(55, 95) / 100;
                task.wait(math.random(3, 7) / 100);
                GlowMask.GroupTransparency = u2.GLOW_IDLE_MIN;
                task.wait(math.random(3, 6) / 100);
                local _ = i;
            end;

            if not u24 or u132 ~= u35 then
                break;
            end;

            local v137 = TweenService:Create(GlowMask, TweenInfo.new(u2.GLOW_IDLE_TIME, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
                GroupTransparency = u2.GLOW_IDLE_MAX
            });
            v137:Play();
            u33 = v137;
        end;
    end);
end;

local function stopMoon() -- Line: 1366
    -- upvalues: Moon (copy), u45 (ref), u12 (copy), u2 (copy)
    if not Moon then
        return;
    end;

    if u45 then
        task.cancel(u45);
        u45 = nil;
    end;

    Moon.Position = UDim2.new(u12.X.Scale + u2.MOON_ENTRY_OFFSET, u12.X.Offset, u12.Y.Scale - u2.MOON_ENTRY_OFFSET * 0.5, u12.Y.Offset);
end;

local function playMoon(u138: number) -- Line: 1384
    -- upvalues: Moon (copy), stopMoon (copy), u2 (copy), u12 (copy), TweenService (copy), u24 (ref), u35 (ref), u45 (ref)
    if not Moon then
        return;
    end;

    stopMoon();
    local v139 = TweenService:Create(Moon, TweenInfo.new(u2.MOON_ENTRY_TIME, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        Position = u12
    });
    v139:Play();
    v139.Completed:Once(function() -- Line: 1397
        -- upvalues: u24 (ref), u138 (copy), u35 (ref), u45 (ref), u2 (ref), Moon (ref), u12 (ref), TweenService (ref)
        if not u24 or u138 ~= u35 then
            return;
        end;

        u45 = task.spawn(function() -- Line: 1402
            -- upvalues: u24 (ref), u138 (ref), u35 (ref), u2 (ref), Moon (ref), u12 (ref), TweenService (ref)
            local Random_new = Random.new;
            local v140 = os.clock() * 1000000;
            local v141 = Random_new(math.floor(v140) + math.random(1, 100000));
            local v142 = true;

            while u24 and u138 == u35 do
                local v143 = v141:NextNumber(u2.MOON_BOB_MIN_TIME, u2.MOON_BOB_MAX_TIME);
                local v144 = v141:NextNumber(u2.MOON_BOB * 0.5, u2.MOON_BOB);
                local TweenInfo_new_ret = TweenInfo.new(v143, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
                local v145 = {};

                if v142 then
                    v144 = -v144 or v144;
                end;

                v145.Position = UDim2.new(u12.X.Scale, u12.X.Offset, u12.Y.Scale + v144, u12.Y.Offset);
                local v146 = TweenService:Create(Moon, TweenInfo_new_ret, v145);
                v146:Play();
                v146.Completed:Wait();
                v142 = not v142;
            end;
        end);
    end);
end;

local function stopSunbursts() -- Line: 1434
    -- upvalues: u29 (ref), u30 (ref), u31 (ref)
    local v147 = u29;

    if v147 then
        v147:Cancel();
    end;

    u29 = nil;
    local v148 = u30;

    if v148 then
        v148:Cancel();
    end;

    u30 = nil;
    local v149 = u31;

    if v149 then
        v149:Cancel();
    end;

    u31 = nil;
end;

local function playSunbursts(u150: number) -- Line: 1441
    -- upvalues: u29 (ref), u30 (ref), u31 (ref), SunburstMask (copy), u2 (copy), TweenService (copy), u24 (ref), u35 (ref), SunburstCounter (copy), Sunburst2 (copy)
    local v151 = u29;

    if v151 then
        v151:Cancel();
    end;

    u29 = nil;
    local v152 = u30;

    if v152 then
        v152:Cancel();
    end;

    u30 = nil;
    local v153 = u31;

    if v153 then
        v153:Cancel();
    end;

    u31 = nil;
    local v154 = SunburstMask;
    local u155 = v154:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
    u155.Parent = v154;
    u155.Scale = u2.SUNBURST_INTRO_SCALE;
    local v156 = TweenService:Create(u155, TweenInfo.new(0.55, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Scale = 1
    });
    v156:Play();
    v156.Completed:Once(function() -- Line: 1449
        -- upvalues: u24 (ref), u150 (copy), u35 (ref), u31 (ref), u155 (copy), u2 (ref), TweenService (ref)
        if not u24 or u150 ~= u35 then
            return;
        end;

        local v157 = TweenService:Create(u155, TweenInfo.new(u2.SUNBURST_BREATHE_TIME, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
            Scale = u2.SUNBURST_BREATHE_SCALE
        });
        v157:Play();
        u31 = v157;
    end);
    local v158 = TweenService:Create(SunburstCounter, TweenInfo.new(u2.SUNBURST_COUNTER_SPIN_TIME, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1), {
        Rotation = SunburstCounter.Rotation - 360
    });
    v158:Play();
    u30 = v158;
    local v159 = TweenService:Create(Sunburst2, TweenInfo.new(u2.SUNBURST_KICK_TIME, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        Rotation = Sunburst2.Rotation + u2.SUNBURST_KICK_DEGREES
    });
    v159:Play();
    v159.Completed:Once(function() -- Line: 1473
        -- upvalues: u24 (ref), u150 (copy), u35 (ref), u29 (ref), Sunburst2 (ref), u2 (ref), TweenService (ref)
        if not u24 or u150 ~= u35 then
            return;
        end;

        local v160 = TweenService:Create(Sunburst2, TweenInfo.new(u2.SUNBURST_SPIN_TIME, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1), {
            Rotation = Sunburst2.Rotation + 360
        });
        v160:Play();
        u29 = v160;
    end);
end;

local function stopBackdropSweep() -- Line: 1486
    -- upvalues: u34 (ref)
    local v161 = u34;

    if v161 then
        v161:Cancel();
    end;

    u34 = nil;
end;

local function playBackdropSweep() -- Line: 1490
    -- upvalues: u34 (ref), UIGradient (copy), u2 (copy), TweenService (copy)
    local v162 = u34;

    if v162 then
        v162:Cancel();
    end;

    u34 = nil;
    UIGradient.Offset = Vector2.new(u2.GRAD_SWEEP_START, 0);
    local v163 = TweenService:Create(UIGradient, TweenInfo.new(u2.GRAD_SWEEP_TIME, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, false, u2.GRAD_SWEEP_HOLD), {
        Offset = Vector2.new(u2.GRAD_SWEEP_FINISH, 0)
    });
    v163:Play();
    u34 = v163;
end;

local function stopIdleTweens(p164) -- Line: 1509
    for _, v in p164 do
        v:Cancel();
    end;

    table.clear(p164);
end;

local function stopRewardIdle() -- Line: 1517
    -- upvalues: u43 (ref)
    if u43 then
        task.cancel(u43);
        u43 = nil;
    end;
end;

local function startRewardIdle(u165: number) -- Line: 1524
    -- upvalues: u43 (ref), Reward2 (copy), u24 (ref), u35 (ref), u27 (ref), u2 (copy), TweenService (copy)
    if u43 then
        task.cancel(u43);
        u43 = nil;
    end;

    u43 = task.spawn(function() -- Line: 1527
        -- upvalues: Reward2 (ref), u24 (ref), u165 (copy), u35 (ref), u27 (ref), u2 (ref), TweenService (ref)
        local Random_new = Random.new;
        local v166 = os.clock() * 1000000;
        local v167 = Random_new(math.floor(v166) + math.random(1, 100000));
        local v168 = Reward2;
        local v169 = v168:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
        v169.Parent = v168;
        local v170 = true;

        while u24 and u165 == u35 do
            if u27 then
                task.wait(0.15);
            else
                local v171 = v167:NextNumber(u2.REWARD_BREATHE_MIN_TIME, u2.REWARD_BREATHE_MAX_TIME);
                local TweenInfo_new_ret = TweenInfo.new(v171, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
                local v172 = TweenService:Create(v169, TweenInfo_new_ret, {
                    Scale = v170 and 1 + u2.REWARD_BREATHE_SCALE or 1 - u2.REWARD_BREATHE_SCALE * 0.5
                });
                v172:Play();
                TweenService:Create(Reward2, TweenInfo_new_ret, {
                    Rotation = v170 and u2.REWARD_BREATHE_TILT or -u2.REWARD_BREATHE_TILT
                }):Play();
                v172.Completed:Wait();
                v170 = not v170;
            end;
        end;
    end);
end;

local function playShine() -- Line: 1559
    -- upvalues: u28 (ref), Shine (copy), Shine2 (copy), TweenService (copy)
    local v173 = u28;

    if v173 then
        v173:Cancel();
    end;

    u28 = nil;
    Shine.Visible = true;
    Shine2.Position = UDim2.fromScale(-0.5, 0.5);
    local v174 = TweenService:Create(Shine2, TweenInfo.new(1.35, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, false, 0.65), {
        Position = UDim2.fromScale(1.5, 0.5)
    });
    v174:Play();
    u28 = v174;
end;

local function setupHoverFrame(p175: userdata) -- Line: 1570
    -- upvalues: TweenService (copy)
    local UIScale3 = p175:WaitForChild("UIScale");
    local ImageButton3 = p175:WaitForChild("ImageButton");
    ImageButton3.MouseEnter:Connect(function() -- Line: 1574
        -- upvalues: UIScale3 (copy), TweenService (ref)
        TweenService:Create(UIScale3, TweenInfo.new(0.12, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Scale = 1.05
        }):Play();
    end);
    ImageButton3.MouseLeave:Connect(function() -- Line: 1578
        -- upvalues: UIScale3 (copy), TweenService (ref)
        TweenService:Create(UIScale3, TweenInfo.new(0.12, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Scale = 1
        }):Play();
    end);
end;

local function setupButton(u176: userdata, u177: any) -- Line: 1583
    -- upvalues: u52 (copy), TweenService (copy)
    local u178 = u176:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
    u178.Scale = 1;
    u178.Parent = u176;
    u176.MouseEnter:Connect(function() -- Line: 1588
        -- upvalues: u52 (ref), u176 (copy), u178 (copy), TweenService (ref)
        u52[u176] = true;
        TweenService:Create(u178, TweenInfo.new(0.12, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Scale = 1.08
        }):Play();
    end);
    u176.MouseLeave:Connect(function() -- Line: 1593
        -- upvalues: u52 (ref), u176 (copy), u178 (copy), TweenService (ref)
        u52[u176] = false;
        TweenService:Create(u178, TweenInfo.new(0.12, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Scale = 1
        }):Play();
    end);
    u176.Activated:Connect(function() -- Line: 1598
        -- upvalues: u178 (copy), TweenService (ref), u177 (copy)
        local v179 = TweenService:Create(u178, TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Scale = 0.92
        });
        v179:Play();
        v179.Completed:Wait();
        TweenService:Create(u178, TweenInfo.new(0.12, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Scale = 1.08
        }):Play();
        u177();
    end);
end;

local function getPanelPieces() -- Line: 1605
    -- upvalues: CloseButton (copy), BuyButton (copy), SpinsOddsButton (copy), ZonesOddsButton (copy), RewardsFrame (copy)
    local v180 = {
        CloseButton,
        BuyButton,
        SpinsOddsButton,
        ZonesOddsButton
    };

    for _, child in RewardsFrame:GetChildren() do
        if child:IsA("Frame") then
            table.insert(v180, child);
        end;
    end;

    return v180;
end;

local function resetPanelEntrance() -- Line: 1617
    -- upvalues: getPanelPieces (copy)
    for _, v in getPanelPieces() do
        local v181 = v:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
        v181.Parent = v;
        v181.Scale = 0;
    end;
end;

local function playPanelEntrance(u182: number) -- Line: 1623
    -- upvalues: getPanelPieces (copy), u2 (copy), u24 (ref), u35 (ref), TweenService (copy)
    local v183 = 0;

    for _, v in getPanelPieces() do
        local u184 = v:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
        u184.Parent = v;
        local v185 = u2.PANEL_ENTRANCE_DELAY + v183 * u2.PANEL_ENTRANCE_STAGGER;
        v183 = v183 + 1;
        u184.Scale = 0;
        task.delay(v185, function() -- Line: 1634
            -- upvalues: u24 (ref), u182 (copy), u35 (ref), v (copy), u184 (copy), u2 (ref), TweenService (ref)
            if not (u24 and (u182 == u35 and v.Parent)) then
                return;
            end;

            TweenService:Create(u184, TweenInfo.new(u2.PANEL_ENTRANCE_TIME, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Scale = 1
            }):Play();
        end);
    end;
end;

local function stopHeartbeat() -- Line: 1646
    -- upvalues: u44 (ref)
    if u44 then
        task.cancel(u44);
        u44 = nil;
    end;
end;

local function startHeartbeat(u186: number) -- Line: 1653
    -- upvalues: u44 (ref), BuyButton (copy), u2 (copy), u24 (ref), u35 (ref), u52 (copy), TweenService (copy)
    if u44 then
        task.cancel(u44);
        u44 = nil;
    end;

    u44 = task.spawn(function() -- Line: 1656
        -- upvalues: BuyButton (ref), u2 (ref), u24 (ref), u186 (copy), u35 (ref), u52 (ref), TweenService (ref)
        local v187 = BuyButton;
        local v188 = v187:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
        v188.Parent = v187;
        task.wait(u2.HEARTBEAT_REST_MIN);

        while u24 and u186 == u35 do
            if u52[BuyButton] then
                task.wait(0.2);
            else
                local v189 = TweenService:Create(v188, TweenInfo.new(u2.HEARTBEAT_TIME * 0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Scale = u2.HEARTBEAT_SCALE
                });
                v189:Play();
                v189.Completed:Wait();

                if not u52[BuyButton] then
                    local v190 = TweenService:Create(v188, TweenInfo.new(u2.HEARTBEAT_TIME * 0.65, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                        Scale = 1
                    });
                    v190:Play();
                    v190.Completed:Wait();
                    task.wait(math.random(u2.HEARTBEAT_REST_MIN * 100, u2.HEARTBEAT_REST_MAX * 100) / 100);
                end;
            end;
        end;
    end);
end;

local function playRewardPunch() -- Line: 1684
    -- upvalues: Reward2 (copy), TweenService (copy), u27 (ref)
    local v191 = Reward2;
    local v192 = v191:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
    v192.Parent = v191;
    local v193 = TweenService:Create(v192, TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Scale = 0.93
    });
    v193:Play();
    v193.Completed:Wait();
    TweenService:Create(v192, TweenInfo.new(0.32, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Scale = u27 and 1.075 or 1
    }):Play();
end;

local function resetItems() -- Line: 1696
    -- upvalues: u35 (ref), u26 (ref), u27 (ref), u29 (ref), u30 (ref), u31 (ref), u43 (ref), u44 (ref), u34 (ref), YellowFill (copy), u32 (ref), u2 (copy), stopMoon (copy), GlowMask (copy), u33 (ref), u46 (ref), stopParticleFloat (copy), u37 (copy), Reward2 (copy), u18 (ref), u19 (ref), u15 (copy), u16 (copy), Header (copy), u17 (copy), u13 (copy), LeftEye (copy), u14 (copy), u36 (copy), clearEffects (copy), hideStars (copy), Position2 (copy), SunburstMask (copy), SunburstCounter (copy), ImageTransparency (copy), Main (copy), Position (copy), u4 (ref), u5 (ref), u6 (ref), getPanelPieces (copy)
    u35 = u35 + 1;
    u26 = false;
    u27 = false;
    local v194 = u29;

    if v194 then
        v194:Cancel();
    end;

    u29 = nil;
    local v195 = u30;

    if v195 then
        v195:Cancel();
    end;

    u30 = nil;
    local v196 = u31;

    if v196 then
        v196:Cancel();
    end;

    u31 = nil;

    if u43 then
        task.cancel(u43);
        u43 = nil;
    end;

    if u44 then
        task.cancel(u44);
        u44 = nil;
    end;

    local v197 = u34;

    if v197 then
        v197:Cancel();
    end;

    u34 = nil;

    if YellowFill then
        local v198 = u32;

        if v198 then
            v198:Cancel();
        end;

        u32 = nil;
        YellowFill.Offset = Vector2.new(u2.AURA_START, 0);
    end;

    stopMoon();

    if GlowMask then
        local v199 = u33;

        if v199 then
            v199:Cancel();
        end;

        u33 = nil;

        if u46 then
            task.cancel(u46);
            u46 = nil;
        end;

        GlowMask.GroupTransparency = 1;
    end;

    stopParticleFloat(u37, Reward2);

    if u18 then
        task.cancel(u18);
        u18 = nil;
    end;

    if u19 then
        task.cancel(u19);
        u19 = nil;
    end;

    if u15 then
        u15.Position = u16;
        local v200 = u15;
        local v201 = v200:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
        v201.Parent = v200;
        v201.Scale = 1;
    end;

    if Header then
        Header.Position = u17;
    end;

    if u13 then
        u13.Offset = Vector2.new(0, u2.EYE_CLOSED_OFFSET);
        local v202 = LeftEye;
        local v203 = v202:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
        v203.Parent = v202;
        v203.Scale = 1;
    end;

    if u14 then
        u14.Offset = Vector2.new(0, u2.EYE_CLOSED_OFFSET);
    end;

    local v204 = u36;

    for _, v in v204 do
        v:Cancel();
    end;

    table.clear(v204);
    clearEffects();
    hideStars();
    Reward2.Visible = false;
    Reward2.ImageTransparency = 1;
    Reward2.Rotation = 0;
    Reward2.Position = Position2;
    local v205 = Reward2;
    local v206 = v205:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
    v206.Parent = v205;
    v206.Scale = 0;
    local v207 = SunburstMask;
    local v208 = v207:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
    v208.Parent = v207;
    v208.Scale = 1;
    SunburstCounter.ImageTransparency = ImageTransparency;
    Main.Position = Position;
    u4();
    u5();
    u6();
    Reward2.Image = u2.REWARD_CLOSED_IMAGE;

    for _, v in getPanelPieces() do
        local v209 = v:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
        v209.Parent = v;
        v209.Scale = 0;
    end;
end;

local function setHeroWipe(p210: number) -- Line: 1768
    -- upvalues: u2 (copy), ClosingGrad (copy)
    local v211 = u2.HERO_WIPE_CLOSED + (u2.HERO_WIPE_OPEN - u2.HERO_WIPE_CLOSED) * math.clamp(p210, 0, 1);
    ClosingGrad.Offset = Vector2.new(0, v211);
end;

local function buildPattern() -- Line: 1780
    -- upvalues: u22 (ref), Frame5 (copy), Frame4 (copy), u2 (copy), HalloweenBundle (copy), u21 (copy), PatternInfiniteLoop (copy), TweenService (copy)
    if u22 then
        u22:Cancel();
        u22 = nil;
    end;

    Frame5:ClearAllChildren();
    Frame5.Position = UDim2.fromScale(0, 0);
    Frame4.Size = UDim2.fromScale(u2.PATTERN_LAYER_W, u2.PATTERN_LAYER_H);
    Frame4.Rotation = u2.PATTERN_TILT;
    local AbsoluteSize = Frame4.AbsoluteSize;
    local AbsoluteSize2 = HalloweenBundle.AbsoluteSize;

    if AbsoluteSize.X <= 0 or AbsoluteSize.Y <= 0 then
        AbsoluteSize = Vector2.new(1920 * u2.PATTERN_LAYER_W, 1080 * u2.PATTERN_LAYER_H);
    end;

    if AbsoluteSize2.X <= 0 or AbsoluteSize2.Y <= 0 then
        AbsoluteSize2 = Vector2.new(1920, 1080);
    end;

    local v212 = AbsoluteSize2.Y / u2.PATTERN_ROWS;
    local v213 = v212 / AbsoluteSize.Y;
    local v214 = v212 * u21 / AbsoluteSize.X;

    if v214 <= 0 or v213 <= 0 then
        v214 = 0.25;
        v213 = 0.5;
    end;

    local v215 = math.ceil(1 / v214) + 1;

    for i = 0, math.ceil(1 / v213) do
        local v216 = i;

        for i2 = 0, v215 do
            local v217 = PatternInfiniteLoop:Clone();
            local v218 = v217:FindFirstChildOfClass("UIAspectRatioConstraint");

            if v218 then
                v218:Destroy();
            end;

            v217.Name = "PatternTile";
            v217.Visible = true;
            v217.AnchorPoint = Vector2.new(0, 0);
            v217.Size = UDim2.fromScale(v214, v213);
            v217.Position = UDim2.fromScale(i2 * v214, v216 * v213);
            v217.ZIndex = 505;
            v217.Parent = Frame5;
            local _ = i2;
        end;
    end;

    local v219 = TweenService:Create(Frame5, TweenInfo.new(u2.PATTERN_SCROLL_TIME, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1), {
        Position = UDim2.fromScale(-v214, 0)
    });
    v219:Play();
    u22 = v219;
end;

local function coverWithPattern() -- Line: 1844
    -- upvalues: buildPattern (copy), Frame4 (copy), u23 (copy), u2 (copy), TweenService (copy)
    buildPattern();
    Frame4.Visible = true;
    Frame4.Position = UDim2.fromScale(0.5 + u23, 0.5);
    TweenService:Create(Frame4, TweenInfo.new(u2.PATTERN_COVER_TIME, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        Position = UDim2.fromScale(0.5, 0.5)
    }):Play();
    task.wait(u2.PATTERN_COVER_TIME);
end;

local function uncoverPattern() -- Line: 1858
    -- upvalues: u2 (copy), Frame4 (copy), u23 (copy), TweenService (copy), u22 (ref), Frame5 (copy)
    task.spawn(function() -- Line: 1859
        -- upvalues: u2 (ref), Frame4 (ref), u23 (ref), TweenService (ref), u22 (ref), Frame5 (ref)
        task.wait(u2.PATTERN_HOLD);
        local v220 = TweenService:Create(Frame4, TweenInfo.new(u2.PATTERN_UNCOVER_TIME, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
            Position = UDim2.fromScale(0.5 - u23, 0.5)
        });
        v220:Play();
        v220.Completed:Once(function() -- Line: 1864
            -- upvalues: Frame4 (ref), u22 (ref), Frame5 (ref)
            Frame4.Visible = false;

            if u22 then
                u22:Cancel();
                u22 = nil;
            end;

            Frame5:ClearAllChildren();
        end);
    end);
end;

local function resetEntryAnimation() -- Line: 1877
    -- upvalues: Frame (copy), Frame2 (copy), EntryAnimation (copy), u2 (copy), Frame3 (copy), PatternInfiniteLoop (copy), Frame4 (copy), u22 (ref), Frame5 (copy), ClosingGrad (copy), RightEye2 (copy), Position6 (copy)
    Frame.BackgroundTransparency = 1;
    Frame2.BackgroundTransparency = 1;
    EntryAnimation.Visible = false;
    EntryAnimation.GroupTransparency = 1;
    EntryAnimation.GroupColor3 = u2.GRADE_COLD;
    local v221 = EntryAnimation;
    local v222 = v221:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
    v222.Parent = v221;
    v222.Scale = 1;
    Frame3:ClearAllChildren();
    PatternInfiniteLoop.Visible = false;
    Frame4.Visible = false;

    if u22 then
        u22:Cancel();
        u22 = nil;
    end;

    Frame5:ClearAllChildren();
    ClosingGrad.Offset = Vector2.new(0, u2.HERO_WIPE_CLOSED + (u2.HERO_WIPE_OPEN - u2.HERO_WIPE_CLOSED) * 0);
    RightEye2.Visible = true;
    RightEye2.Position = Position6;
    RightEye2.Rotation = 0;
    RightEye2.ImageColor3 = u2.HERO_COLD_COLOR;
    local v223 = RightEye2;
    local v224 = v223:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
    v224.Parent = v223;
    v224.Scale = u2.HERO_APPROACH_SCALE;
end;

local function setBundleEye(p225: userdata?, p226: number, p227: number, p228: any, p229: any) -- Line: 1908
    -- upvalues: TweenService (copy)
    if not p225 then
        return;
    end;

    TweenService:Create(p225, TweenInfo.new(p227, p228, p229), {
        Offset = Vector2.new(0, p226)
    }):Play();
end;

local function openBundleEyes(u230: number) -- Line: 1918
    -- upvalues: setBundleEye (copy), u13 (copy), u2 (copy), u24 (ref), u35 (ref), u14 (copy), u18 (ref)
    setBundleEye(u13, u2.EYE_OPEN_OFFSET, u2.BUNDLE_EYE_OPEN_TIME, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
    task.delay(u2.BUNDLE_EYE_STAGGER, function() -- Line: 1921
        -- upvalues: u24 (ref), u230 (copy), u35 (ref), setBundleEye (ref), u14 (ref), u2 (ref)
        if u24 and u230 == u35 then
            setBundleEye(u14, u2.EYE_OPEN_OFFSET, u2.BUNDLE_EYE_OPEN_TIME, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
        end;
    end);

    if not (u13 or u14) then
        return;
    end;

    u18 = task.spawn(function() -- Line: 1931
        -- upvalues: setBundleEye (ref), u13 (ref), u2 (ref), u14 (ref), u24 (ref), u230 (copy), u35 (ref)
        local Random_new = Random.new;
        local v231 = os.clock() * 1000000;
        local v232 = Random_new(math.floor(v231) + math.random(1, 100000));

        local function blink() -- Line: 1934
            -- upvalues: setBundleEye (ref), u13 (ref), u2 (ref), u14 (ref)
            setBundleEye(u13, u2.EYE_CLOSED_OFFSET, u2.BUNDLE_BLINK_TIME, Enum.EasingStyle.Quad, Enum.EasingDirection.In);
            setBundleEye(u14, u2.EYE_CLOSED_OFFSET, u2.BUNDLE_BLINK_TIME, Enum.EasingStyle.Quad, Enum.EasingDirection.In);
            task.wait(u2.BUNDLE_BLINK_TIME);
            setBundleEye(u13, u2.EYE_OPEN_OFFSET, u2.BUNDLE_BLINK_TIME * 1.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
            setBundleEye(u14, u2.EYE_OPEN_OFFSET, u2.BUNDLE_BLINK_TIME * 1.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
            task.wait(u2.BUNDLE_BLINK_TIME * 1.8);
        end;

        while u24 and u230 == u35 do
            task.wait(v232:NextNumber(u2.BUNDLE_BLINK_MIN_DELAY, u2.BUNDLE_BLINK_MAX_DELAY));

            if not u24 or u230 ~= u35 then
                break;
            end;

            blink();

            if v232:NextInteger(1, 100) <= u2.BUNDLE_DOUBLE_BLINK_CHANCE then
                task.wait(0.1);

                if u24 and u230 == u35 then
                    blink();
                end;
            end;
        end;
    end);
end;

local function startBundleIdleMotion(u233: number) -- Line: 1968
    -- upvalues: u19 (ref), u24 (ref), u35 (ref), u2 (copy), u15 (copy), u16 (copy), TweenService (copy), Header (copy), u17 (copy), LeftEye (copy), RightEye (copy)
    u19 = task.spawn(function() -- Line: 1969
        -- upvalues: u24 (ref), u233 (copy), u35 (ref), u2 (ref), u15 (ref), u16 (ref), TweenService (ref), Header (ref), u17 (ref), LeftEye (ref), RightEye (ref)
        local Random_new = Random.new;
        local v234 = os.clock() * 1000000;
        local v235 = Random_new(math.floor(v234) + math.random(1, 100000));
        local v236 = true;

        while u24 and u233 == u35 do
            local v237 = v235:NextNumber(u2.BG_FLOAT_MIN_TIME, u2.BG_FLOAT_MAX_TIME);
            local TweenInfo_new_ret = TweenInfo.new(v237, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
            local v238 = v236 and -u2.BG_FLOAT_OFFSET or u2.BG_FLOAT_OFFSET;

            if u15 then
                TweenService:Create(u15, TweenInfo_new_ret, {
                    Position = u16 + UDim2.fromOffset(0, v238)
                }):Play();
                local v239 = u15;
                local v240 = v239:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
                v240.Parent = v239;
                TweenService:Create(v240, TweenInfo_new_ret, {
                    Scale = v236 and 1 + u2.BG_FLOAT_SCALE or 1 - u2.BG_FLOAT_SCALE * 0.5
                }):Play();
            end;

            if Header then
                TweenService:Create(Header, TweenInfo_new_ret, {
                    Position = u17 + UDim2.fromOffset(0, v236 and u2.HEADER_FLOAT_OFFSET or -u2.HEADER_FLOAT_OFFSET)
                }):Play();
            end;

            if LeftEye then
                local v241 = LeftEye;
                local v242 = v241:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
                v242.Parent = v241;
                TweenService:Create(v242, TweenInfo_new_ret, {
                    Scale = v236 and 1 + u2.BUNDLE_EYE_BREATHE or 1
                }):Play();
            end;

            if RightEye then
                local v243 = RightEye;
                local v244 = v243:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
                v244.Parent = v243;
                TweenService:Create(v244, TweenInfo_new_ret, {
                    Scale = v236 and 1 or 1 + u2.BUNDLE_EYE_BREATHE
                }):Play();
            end;

            task.wait(v237);
            v236 = not v236;
        end;
    end);
end;

local function playEntryFlash(p245: number, p246: number, p247) -- Line: 2014
    -- upvalues: Frame (copy), u2 (copy), TweenService (copy)
    Frame.BackgroundColor3 = p247 or u2.FLASH_WHITE;
    Frame.BackgroundTransparency = p246;
    TweenService:Create(Frame, TweenInfo.new(p245, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        BackgroundTransparency = 1
    }):Play();
end;

local function playTripleFlash(u248: number) -- Line: 2023
    -- upvalues: u24 (ref), u35 (ref), playEntryFlash (copy), u2 (copy)
    task.spawn(function() -- Line: 2024
        -- upvalues: u24 (ref), u248 (copy), u35 (ref), playEntryFlash (ref), u2 (ref)
        for i = 1, 3 do
            if not u24 or u248 ~= u35 then
                return;
            end;

            playEntryFlash(u2.FLASH_TIME * 0.5, u2.FLASH_PEAK + (i - 1) * 0.14, i == 2 and u2.FLASH_WHITE or u2.FLASH_AMBER);
            task.wait(u2.TRIPLE_FLASH_GAP);
            local _ = i;
        end;
    end);
end;

local function playSpeedLines(u249: number, u250: number, u251) -- Line: 2038
    -- upvalues: u24 (ref), u35 (ref), Frame3 (copy), TweenService (copy)
    task.spawn(function() -- Line: 2039
        -- upvalues: u250 (copy), u24 (ref), u249 (copy), u35 (ref), u251 (copy), Frame3 (ref), TweenService (ref)
        for i = 1, u250 do
            if not u24 or u249 ~= u35 then
                return;
            end;

            local Frame6 = Instance.new("Frame");
            local v252 = math.random(0, 1) == 0;
            local v253 = math.random(2, 98) / 100;
            local v254 = math.random(18, 55) / 100;
            Frame6.BackgroundColor3 = u251;
            Frame6.BorderSizePixel = 0;
            Frame6.AnchorPoint = Vector2.new(0.5, 0.5);
            Frame6.Size = UDim2.new(v254, 0, 0, math.random(2, 7));
            Frame6.Position = UDim2.fromScale(v252 and -v254 or 1 + v254, v253);
            Frame6.BackgroundTransparency = math.random(10, 45) / 100;
            Frame6.ZIndex = 41;
            Frame6.Parent = Frame3;
            local v255 = math.random(55, 85) / 100;
            TweenService:Create(Frame6, TweenInfo.new(v255, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                Position = UDim2.fromScale(v252 and 1 + v254 or -v254, v253)
            }):Play();
            local v256 = TweenService:Create(Frame6, TweenInfo.new(v255 * 0.9, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                BackgroundTransparency = 1
            });
            v256:Play();
            v256.Completed:Once(function() -- Line: 2067
                -- upvalues: Frame6 (copy)
                Frame6:Destroy();
            end);
            task.wait(math.random(1, 4) / 100);
            local _ = i;
        end;
    end);
end;

local function playImpactBurst(p257) -- Line: 2077
    -- upvalues: u2 (copy), Frame3 (copy), TweenService (copy)
    for i = 1, u2.BURST_SPOKES do
        local Frame6 = Instance.new("Frame");
        Frame6.BackgroundColor3 = p257;
        Frame6.BorderSizePixel = 0;
        Frame6.AnchorPoint = Vector2.new(0.5, 1);
        Frame6.Position = UDim2.fromScale(0.5, 0.5);
        Frame6.Rotation = (i - 1) * (360 / u2.BURST_SPOKES) + math.random(-8, 8);
        Frame6.Size = UDim2.new(0, math.random(3, 9), 0, 0);
        Frame6.BackgroundTransparency = 0.1;
        Frame6.ZIndex = 42;
        Frame6.Parent = Frame3;
        local v258 = math.random(u2.BURST_MIN_REACH * 100, u2.BURST_MAX_REACH * 100) / 100;
        TweenService:Create(Frame6, TweenInfo.new(u2.BURST_TIME, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 2, v258, 0)
        }):Play();
        local v259 = TweenService:Create(Frame6, TweenInfo.new(u2.BURST_TIME * 0.85, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            BackgroundTransparency = 1
        });
        v259:Play();
        v259.Completed:Once(function() -- Line: 2099
            -- upvalues: Frame6 (copy)
            Frame6:Destroy();
        end);
        local _ = i;
    end;
end;

local function playShockwaves(u260) -- Line: 2107
    -- upvalues: u2 (copy), u24 (ref), Frame3 (copy), TweenService (copy)
    for i = 1, u2.SHOCKWAVE_COUNT do
        task.delay((i - 1) * u2.SHOCKWAVE_STAGGER, function() -- Line: 2109
            -- upvalues: u24 (ref), u2 (ref), Frame3 (ref), u260 (copy), TweenService (ref)
            if not u24 then
                return;
            end;

            local Frame6 = Instance.new("Frame");
            Frame6.BackgroundTransparency = 1;
            Frame6.BorderSizePixel = 0;
            Frame6.AnchorPoint = Vector2.new(0.5, 0.5);
            Frame6.Position = UDim2.fromScale(0.5, 0.5);
            Frame6.Size = UDim2.fromScale(1, u2.SHOCKWAVE_START);
            Frame6.ZIndex = 43;
            Frame6.Parent = Frame3;
            local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint");
            UIAspectRatioConstraint.AspectRatio = 1;
            UIAspectRatioConstraint.DominantAxis = Enum.DominantAxis.Height;
            UIAspectRatioConstraint.Parent = Frame6;
            local UICorner = Instance.new("UICorner");
            UICorner.CornerRadius = UDim.new(1, 0);
            UICorner.Parent = Frame6;
            local UIStroke = Instance.new("UIStroke");
            UIStroke.Color = u260;
            UIStroke.Thickness = u2.SHOCKWAVE_THICKNESS;
            UIStroke.Transparency = 0;
            UIStroke.Parent = Frame6;
            TweenService:Create(Frame6, TweenInfo.new(u2.SHOCKWAVE_TIME, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                Size = UDim2.fromScale(1, u2.SHOCKWAVE_END)
            }):Play();
            local v261 = TweenService:Create(UIStroke, TweenInfo.new(u2.SHOCKWAVE_TIME, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Thickness = 0,
                Transparency = 1
            });
            v261:Play();
            v261.Completed:Once(function() -- Line: 2145
                -- upvalues: Frame6 (copy)
                Frame6:Destroy();
            end);
        end);
        local _ = i;
    end;
end;

local function playSlashes(u262: number, u263) -- Line: 2153
    -- upvalues: u2 (copy), u24 (ref), u35 (ref), Frame3 (copy), TweenService (copy)
    for i = 1, u2.SLASH_COUNT do
        task.delay((i - 1) * u2.SLASH_STAGGER, function() -- Line: 2155
            -- upvalues: u24 (ref), u262 (copy), u35 (ref), i (copy), u263 (copy), u2 (ref), Frame3 (ref), TweenService (ref)
            if not u24 or u262 ~= u35 then
                return;
            end;

            local Frame6 = Instance.new("Frame");
            local v264 = i % 2 == 0;
            Frame6.BackgroundColor3 = u263;
            Frame6.BorderSizePixel = 0;
            Frame6.AnchorPoint = Vector2.new(0.5, 0.5);
            Frame6.Rotation = v264 and -u2.BAND_ROTATION or u2.BAND_ROTATION;
            Frame6.Size = UDim2.new(2.6, 0, 0, u2.SLASH_THICKNESS);
            Frame6.Position = UDim2.fromScale(v264 and 1.6 or -0.6, math.random(25, 75) / 100);
            Frame6.BackgroundTransparency = 0.05;
            Frame6.ZIndex = 44;
            Frame6.Parent = Frame3;
            TweenService:Create(Frame6, TweenInfo.new(u2.SLASH_TIME, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                Position = UDim2.fromScale(v264 and -0.6 or 1.6, Frame6.Position.Y.Scale)
            }):Play();
            local v265 = TweenService:Create(Frame6, TweenInfo.new(u2.SLASH_TIME * 0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                BackgroundTransparency = 1,
                Size = UDim2.new(2.6, 0, 0, 2)
            });
            v265:Play();
            v265.Completed:Once(function() -- Line: 2180
                -- upvalues: Frame6 (copy)
                Frame6:Destroy();
            end);
        end);
        local _ = i;
    end;
end;

local function playEntryAnimation(u266: number) -- Line: 2188
    -- upvalues: resetEntryAnimation (copy), u24 (ref), u35 (ref), RightEye2 (copy), EntryAnimation (copy), Frame2 (copy), u2 (copy), GlitchShow (copy), TweenService (copy), Frame3 (copy), Main (copy), Position (copy), playSlashes (copy), ImageColor3 (copy), ClosingGrad (copy), playShockwaves (copy), playImpactBurst (copy), playEntryFlash (copy), coverWithPattern (copy)
    resetEntryAnimation();

    local function stillRunning() -- Line: 2191
        -- upvalues: u24 (ref), u266 (copy), u35 (ref)
        return u24 and u266 == u35;
    end;

    local v267 = RightEye2;
    local v268 = v267:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
    v268.Parent = v267;
    local v269 = EntryAnimation;
    local v270 = v269:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
    v270.Parent = v269;
    EntryAnimation.Visible = true;
    Frame2.BackgroundTransparency = u2.OPEN_DIM;
    local v271 = GlitchShow;

    if v271 then
        local u272 = v271:Clone();
        u272.Parent = workspace.Debris;
        u272:Play();
        u272.Ended:Once(function() -- Line: 731
            -- upvalues: u272 (copy)
            u272:Destroy();
        end);
    end;

    TweenService:Create(EntryAnimation, TweenInfo.new(u2.ENTRY_FADE_IN, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        GroupTransparency = 0
    }):Play();
    task.wait(u2.ENTRY_PREHOLD);

    if not (u24 and u266 == u35) then
        return;
    end;

    local SPEEDLINE_COUNT = u2.SPEEDLINE_COUNT;
    local FLASH_COLD = u2.FLASH_COLD;
    task.spawn(function() -- Line: 2039
        -- upvalues: SPEEDLINE_COUNT (copy), u24 (ref), u266 (copy), u35 (ref), FLASH_COLD (copy), Frame3 (ref), TweenService (ref)
        for i = 1, SPEEDLINE_COUNT do
            if not u24 or u266 ~= u35 then
                return;
            end;

            local Frame6 = Instance.new("Frame");
            local v273 = math.random(0, 1) == 0;
            local v274 = math.random(2, 98) / 100;
            local v275 = math.random(18, 55) / 100;
            Frame6.BackgroundColor3 = FLASH_COLD;
            Frame6.BorderSizePixel = 0;
            Frame6.AnchorPoint = Vector2.new(0.5, 0.5);
            Frame6.Size = UDim2.new(v275, 0, 0, math.random(2, 7));
            Frame6.Position = UDim2.fromScale(v273 and -v275 or 1 + v275, v274);
            Frame6.BackgroundTransparency = math.random(10, 45) / 100;
            Frame6.ZIndex = 41;
            Frame6.Parent = Frame3;
            local v276 = math.random(55, 85) / 100;
            TweenService:Create(Frame6, TweenInfo.new(v276, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                Position = UDim2.fromScale(v273 and 1 + v275 or -v275, v274)
            }):Play();
            local v277 = TweenService:Create(Frame6, TweenInfo.new(v276 * 0.9, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                BackgroundTransparency = 1
            });
            v277:Play();
            v277.Completed:Once(function() -- Line: 2067
                -- upvalues: Frame6 (copy)
                Frame6:Destroy();
            end);
            task.wait(math.random(1, 4) / 100);
            local _ = i;
        end;
    end);
    TweenService:Create(Frame2, TweenInfo.new(u2.BAND_ENTRY_TIME, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        BackgroundTransparency = 1
    }):Play();
    local v278 = TweenService:Create(v268, TweenInfo.new(u2.HERO_APPROACH_TIME, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        Scale = u2.HERO_INTRO_SCALE
    });
    v278:Play();
    local u279 = { 14, 11, 8, 6, 4, 2 };
    task.spawn(function() -- Line: 768
        -- upvalues: u279 (copy), u24 (ref), Main (ref), Position (ref)
        for _, v in u279 do
            if not u24 then
                break;
            end;

            Main.Position = UDim2.new(Position.X.Scale, Position.X.Offset + math.random(-v, v), Position.Y.Scale, Position.Y.Offset + math.random(-v, v));
            task.wait(0.02);
        end;

        Main.Position = Position;
    end);
    task.wait(u2.BAND_ENTRY_TIME * 0.8);

    if not (u24 and u266 == u35) then
        return;
    end;

    playSlashes(u266, u2.FLASH_WHITE);
    task.wait(u2.SLASH_TIME + u2.SLASH_STAGGER * u2.SLASH_COUNT);

    if not (u24 and u266 == u35) then
        return;
    end;

    TweenService:Create(Frame2, TweenInfo.new(u2.QUIET_DIP_IN, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        BackgroundTransparency = u2.QUIET_PEAK
    }):Play();
    TweenService:Create(EntryAnimation, TweenInfo.new(u2.QUIET_DIP_IN, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        GroupColor3 = u2.GRADE_DEEP_COLD
    }):Play();
    task.wait(u2.QUIET_DIP_IN + u2.QUIET_HOLD);

    if not (u24 and u266 == u35) then
        return;
    end;

    v278:Cancel();
    RightEye2.ImageColor3 = ImageColor3;
    EntryAnimation.GroupColor3 = u2.GRADE_HOT;
    v268.Scale = u2.HERO_INTRO_SCALE * u2.HERO_PUNCH;
    v270.Scale = u2.SNAP_PUNCH_SCALE;
    TweenService:Create(v270, TweenInfo.new(u2.HERO_SETTLE_TIME, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        Scale = 1
    }):Play();
    TweenService:Create(Frame2, TweenInfo.new(u2.QUIET_DIP_OUT, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        BackgroundTransparency = 1
    }):Play();
    local NumberValue = Instance.new("NumberValue");
    NumberValue.Value = 0;
    local u281 = NumberValue:GetPropertyChangedSignal("Value"):Connect(function() -- Line: 2276
        -- upvalues: NumberValue (copy), u2 (ref), ClosingGrad (ref)
        local v280 = u2.HERO_WIPE_CLOSED + (u2.HERO_WIPE_OPEN - u2.HERO_WIPE_CLOSED) * math.clamp(NumberValue.Value, 0, 1);
        ClosingGrad.Offset = Vector2.new(0, v280);
    end);
    local v282 = TweenService:Create(NumberValue, TweenInfo.new(u2.HERO_WIPE_TIME, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
        Value = 1
    });
    v282:Play();
    v282.Completed:Once(function() -- Line: 2282
        -- upvalues: u281 (copy), u2 (ref), ClosingGrad (ref), NumberValue (copy)
        u281:Disconnect();
        ClosingGrad.Offset = Vector2.new(0, u2.HERO_WIPE_CLOSED + (u2.HERO_WIPE_OPEN - u2.HERO_WIPE_CLOSED) * 1);
        NumberValue:Destroy();
    end);
    TweenService:Create(v268, TweenInfo.new(u2.HERO_SETTLE_TIME, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        Scale = 1
    }):Play();
    playShockwaves(u2.FLASH_AMBER);
    playImpactBurst(u2.FLASH_AMBER);
    task.spawn(function() -- Line: 2024
        -- upvalues: u24 (ref), u266 (copy), u35 (ref), playEntryFlash (ref), u2 (ref)
        for i = 1, 3 do
            if not u24 or u266 ~= u35 then
                return;
            end;

            playEntryFlash(u2.FLASH_TIME * 0.5, u2.FLASH_PEAK + (i - 1) * 0.14, i == 2 and u2.FLASH_WHITE or u2.FLASH_AMBER);
            task.wait(u2.TRIPLE_FLASH_GAP);
            local _ = i;
        end;
    end);
    playSlashes(u266, u2.FLASH_AMBER);
    local SPEEDLINE_BURST = u2.SPEEDLINE_BURST;
    local FLASH_AMBER = u2.FLASH_AMBER;
    task.spawn(function() -- Line: 2039
        -- upvalues: SPEEDLINE_BURST (copy), u24 (ref), u266 (copy), u35 (ref), FLASH_AMBER (copy), Frame3 (ref), TweenService (ref)
        for i = 1, SPEEDLINE_BURST do
            if not u24 or u266 ~= u35 then
                return;
            end;

            local Frame6 = Instance.new("Frame");
            local v283 = math.random(0, 1) == 0;
            local v284 = math.random(2, 98) / 100;
            local v285 = math.random(18, 55) / 100;
            Frame6.BackgroundColor3 = FLASH_AMBER;
            Frame6.BorderSizePixel = 0;
            Frame6.AnchorPoint = Vector2.new(0.5, 0.5);
            Frame6.Size = UDim2.new(v285, 0, 0, math.random(2, 7));
            Frame6.Position = UDim2.fromScale(v283 and -v285 or 1 + v285, v284);
            Frame6.BackgroundTransparency = math.random(10, 45) / 100;
            Frame6.ZIndex = 41;
            Frame6.Parent = Frame3;
            local v286 = math.random(55, 85) / 100;
            TweenService:Create(Frame6, TweenInfo.new(v286, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                Position = UDim2.fromScale(v283 and 1 + v285 or -v285, v284)
            }):Play();
            local v287 = TweenService:Create(Frame6, TweenInfo.new(v286 * 0.9, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                BackgroundTransparency = 1
            });
            v287:Play();
            v287.Completed:Once(function() -- Line: 2067
                -- upvalues: Frame6 (copy)
                Frame6:Destroy();
            end);
            task.wait(math.random(1, 4) / 100);
            local _ = i;
        end;
    end);
    local u288 = { 32, 26, 21, 16, 12, 9, 6, 4, 2 };
    task.spawn(function() -- Line: 768
        -- upvalues: u288 (copy), u24 (ref), Main (ref), Position (ref)
        for _, v in u288 do
            if not u24 then
                break;
            end;

            Main.Position = UDim2.new(Position.X.Scale, Position.X.Offset + math.random(-v, v), Position.Y.Scale, Position.Y.Offset + math.random(-v, v));
            task.wait(0.02);
        end;

        Main.Position = Position;
    end);
    task.wait(u2.HERO_HOLD);

    if not (u24 and u266 == u35) then
        return;
    end;

    TweenService:Create(v268, TweenInfo.new(u2.BAND_GAP, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        Scale = u2.HERO_DRIFT_SCALE
    }):Play();
    TweenService:Create(EntryAnimation, TweenInfo.new(u2.BAND_GAP, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        GroupColor3 = u2.GRADE_NEUTRAL
    }):Play();
    task.wait(u2.BAND_GAP * 0.45);

    if not (u24 and u266 == u35) then
        return;
    end;

    TweenService:Create(v270, TweenInfo.new(u2.PATTERN_COVER_TIME, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        Scale = u2.ENTRY_EXIT_SCALE
    }):Play();
    coverWithPattern();
    EntryAnimation.Visible = false;
    EntryAnimation.GroupTransparency = 1;
    Frame3:ClearAllChildren();
end;

local function playBundleBoom(u289: number) -- Line: 2336
    -- upvalues: UIScale (copy), u2 (copy), TweenService (copy), playShockwaves (copy), playImpactBurst (copy), playSlashes (copy), u24 (ref), u35 (ref), Frame3 (copy), playEntryFlash (copy), Main (copy), Position (copy)
    UIScale.Scale = u2.BOOM_PUNCH;
    TweenService:Create(UIScale, TweenInfo.new(u2.BOOM_SETTLE, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Scale = 1
    }):Play();
    playShockwaves(u2.FLASH_AMBER);
    playImpactBurst(u2.FLASH_AMBER);
    playSlashes(u289, u2.FLASH_WHITE);
    local SPEEDLINE_BURST = u2.SPEEDLINE_BURST;
    local FLASH_AMBER = u2.FLASH_AMBER;
    task.spawn(function() -- Line: 2039
        -- upvalues: SPEEDLINE_BURST (copy), u24 (ref), u289 (copy), u35 (ref), FLASH_AMBER (copy), Frame3 (ref), TweenService (ref)
        for i = 1, SPEEDLINE_BURST do
            if not u24 or u289 ~= u35 then
                return;
            end;

            local Frame6 = Instance.new("Frame");
            local v290 = math.random(0, 1) == 0;
            local v291 = math.random(2, 98) / 100;
            local v292 = math.random(18, 55) / 100;
            Frame6.BackgroundColor3 = FLASH_AMBER;
            Frame6.BorderSizePixel = 0;
            Frame6.AnchorPoint = Vector2.new(0.5, 0.5);
            Frame6.Size = UDim2.new(v292, 0, 0, math.random(2, 7));
            Frame6.Position = UDim2.fromScale(v290 and -v292 or 1 + v292, v291);
            Frame6.BackgroundTransparency = math.random(10, 45) / 100;
            Frame6.ZIndex = 41;
            Frame6.Parent = Frame3;
            local v293 = math.random(55, 85) / 100;
            TweenService:Create(Frame6, TweenInfo.new(v293, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                Position = UDim2.fromScale(v290 and 1 + v292 or -v292, v291)
            }):Play();
            local v294 = TweenService:Create(Frame6, TweenInfo.new(v293 * 0.9, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                BackgroundTransparency = 1
            });
            v294:Play();
            v294.Completed:Once(function() -- Line: 2067
                -- upvalues: Frame6 (copy)
                Frame6:Destroy();
            end);
            task.wait(math.random(1, 4) / 100);
            local _ = i;
        end;
    end);
    task.spawn(function() -- Line: 2024
        -- upvalues: u24 (ref), u289 (copy), u35 (ref), playEntryFlash (ref), u2 (ref)
        for i = 1, 3 do
            if not u24 or u289 ~= u35 then
                return;
            end;

            playEntryFlash(u2.FLASH_TIME * 0.5, u2.FLASH_PEAK + (i - 1) * 0.14, i == 2 and u2.FLASH_WHITE or u2.FLASH_AMBER);
            task.wait(u2.TRIPLE_FLASH_GAP);
            local _ = i;
        end;
    end);
    local u295 = { 28, 23, 19, 15, 12, 9, 7, 5, 3, 2 };
    task.spawn(function() -- Line: 768
        -- upvalues: u295 (copy), u24 (ref), Main (ref), Position (ref)
        for _, v in u295 do
            if not u24 then
                break;
            end;

            Main.Position = UDim2.new(Position.X.Scale, Position.X.Offset + math.random(-v, v), Position.Y.Scale, Position.Y.Offset + math.random(-v, v));
            task.wait(0.02);
        end;

        Main.Position = Position;
    end);
    task.delay(u2.BOOM_RECOIL, function() -- Line: 2351
        -- upvalues: u24 (ref), u289 (copy), u35 (ref), playShockwaves (ref), u2 (ref), Frame3 (ref), TweenService (ref)
        if not u24 or u289 ~= u35 then
            return;
        end;

        playShockwaves(u2.FLASH_COLD);
        local u296 = u289;
        local math_floor_ret = math.floor(u2.SPEEDLINE_BURST * 0.4);
        local FLASH_COLD = u2.FLASH_COLD;
        task.spawn(function() -- Line: 2039
            -- upvalues: math_floor_ret (copy), u24 (ref), u296 (copy), u35 (ref), FLASH_COLD (copy), Frame3 (ref), TweenService (ref)
            for i = 1, math_floor_ret do
                if not u24 or u296 ~= u35 then
                    return;
                end;

                local Frame6 = Instance.new("Frame");
                local v297 = math.random(0, 1) == 0;
                local v298 = math.random(2, 98) / 100;
                local v299 = math.random(18, 55) / 100;
                Frame6.BackgroundColor3 = FLASH_COLD;
                Frame6.BorderSizePixel = 0;
                Frame6.AnchorPoint = Vector2.new(0.5, 0.5);
                Frame6.Size = UDim2.new(v299, 0, 0, math.random(2, 7));
                Frame6.Position = UDim2.fromScale(v297 and -v299 or 1 + v299, v298);
                Frame6.BackgroundTransparency = math.random(10, 45) / 100;
                Frame6.ZIndex = 41;
                Frame6.Parent = Frame3;
                local v300 = math.random(55, 85) / 100;
                TweenService:Create(Frame6, TweenInfo.new(v300, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                    Position = UDim2.fromScale(v297 and 1 + v299 or -v299, v298)
                }):Play();
                local v301 = TweenService:Create(Frame6, TweenInfo.new(v300 * 0.9, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                    BackgroundTransparency = 1
                });
                v301:Play();
                v301.Completed:Once(function() -- Line: 2067
                    -- upvalues: Frame6 (copy)
                    Frame6:Destroy();
                end);
                task.wait(math.random(1, 4) / 100);
                local _ = i;
            end;
        end);
    end);
end;

u6 = function() -- Line: 2365, Name: hideRewardParticles
    -- upvalues: Reward2 (copy), u39 (copy), u40 (copy), u7 (copy)
    for _, child in Reward2:GetChildren() do
        if child:IsA("ImageLabel") and child.Name == "Particles" then
            if not u39[child] then
                u39[child] = child.Position;
                u40[child] = child.Rotation;
                u7[child] = child.ImageTransparency;
            end;

            local v302 = child:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
            v302.Parent = child;
            v302.Scale = 0;
            child.ImageTransparency = 1;
        end;
    end;
end;

local function startMist() -- Line: 2380
    -- upvalues: u10 (ref), SmokeMask (copy), u9 (copy), u2 (copy), TweenService (copy)
    if u10 or not (SmokeMask and u9) then
        return;
    end;

    SmokeMask.Visible = true;
    SmokeMask.Position = u9 - UDim2.fromScale(u2.MIST_DRIFT * 0.5, 0);
    local v303 = TweenService:Create(SmokeMask, TweenInfo.new(u2.MIST_SWEEP_TIME, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
        Position = u9 + UDim2.fromScale(u2.MIST_DRIFT * 0.5, 0)
    });
    v303:Play();
    u10 = v303;
end;

local function buildJumpScareBars() -- Line: 2404
    -- upvalues: Main2 (copy), u2 (copy), u3 (copy)
    Main2.ZIndex = u2.JUMPSCARE_ZINDEX;
    Main2.ClipsDescendants = false;

    if #u3 > 0 then
        return;
    end;

    for _, v in {
        {
            anchor = Vector2.new(1, 0.5),
            position = UDim2.fromScale(u2.JUMPSCARE_SEAL, 0.5)
        },
        {
            anchor = Vector2.new(0, 0.5),
            position = UDim2.fromScale(1 - u2.JUMPSCARE_SEAL, 0.5)
        },
        {
            anchor = Vector2.new(0.5, 1),
            position = UDim2.fromScale(0.5, u2.JUMPSCARE_SEAL)
        },
        {
            anchor = Vector2.new(0.5, 0),
            position = UDim2.fromScale(0.5, 1 - u2.JUMPSCARE_SEAL)
        }
    } do
        local Frame6 = Instance.new("Frame");
        Frame6.Name = "Blackout";
        Frame6.BackgroundColor3 = Color3.new(0, 0, 0);
        Frame6.BorderSizePixel = 0;
        Frame6.AnchorPoint = v.anchor;
        Frame6.Position = v.position;
        Frame6.ZIndex = u2.JUMPSCARE_ZINDEX;
        Frame6.Parent = Main2;
        table.insert(u3, Frame6);
    end;
end;

local function layoutJumpScareBars() -- Line: 2440
    -- upvalues: u3 (copy), Main2 (copy), JumpScareFrame (copy), u2 (copy)
    if #u3 < 4 then
        return;
    end;

    local AbsoluteSize = Main2.AbsoluteSize;
    local AbsoluteSize2 = JumpScareFrame.AbsoluteSize;

    if AbsoluteSize.X < 1 or (AbsoluteSize.Y < 1 or (AbsoluteSize2.X < 1 or AbsoluteSize2.Y < 1)) then
        return;
    end;

    local v304 = math.max(AbsoluteSize2.X / AbsoluteSize.X, AbsoluteSize2.Y / AbsoluteSize.Y) * 3 + u2.JUMPSCARE_BAR_MARGIN;
    local UDim2_fromScale_ret = UDim2.fromScale(v304, v304);

    for _, v in u3 do
        v.Size = UDim2_fromScale_ret;
    end;
end;

local function setJumpScareFade(p305: number) -- Line: 2461
    -- upvalues: Main2 (copy), u3 (copy)
    Main2.ImageTransparency = p305;

    for _, v in u3 do
        v.BackgroundTransparency = p305;
    end;
end;

u4 = function() -- Line: 2469, Name: hideJumpScare
    -- upvalues: JumpScareFrame (copy), UIScale2 (copy), u2 (copy), Main2 (copy), u3 (copy)
    JumpScareFrame.Visible = false;
    UIScale2.Scale = u2.JUMPSCARE_START_SCALE;
    Main2.ImageTransparency = 0;

    for _, v in u3 do
        v.BackgroundTransparency = 0;
    end;
end;

u5 = function() -- Line: 2476, Name: resetGhouls
    -- upvalues: GhoulOne (copy), Position3 (copy), Scale (copy), GhoulTwo (copy), Position4 (copy), Scale2 (copy)
    for _, v in {
        { GhoulOne, Position3, Scale },
        { GhoulTwo, Position4, Scale2 }
    } do
        local v306 = v[1];
        v306.Visible = false;
        v306.Position = v[2];
        v306.Rotation = 0;
        v306.ImageTransparency = 0;
        local v307 = v306:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
        v307.Parent = v306;
        v307.Scale = v[3];
    end;
end;

local function playJumpScare(u308: number) -- Line: 2499
    -- upvalues: buildJumpScareBars (copy), JumpScareFrame (copy), UIScale2 (copy), u2 (copy), Main2 (copy), u3 (copy), layoutJumpScareBars (copy), OpenMusic (copy), EvilChime (copy), RunService (copy), u24 (ref), u35 (ref), playEntryFlash (copy), Main (copy), Position (copy), u4 (ref)
    buildJumpScareBars();
    local Position7 = JumpScareFrame.Position;
    JumpScareFrame.Visible = true;
    JumpScareFrame.Position = Position7;
    JumpScareFrame.Rotation = 0;
    UIScale2.Scale = u2.JUMPSCARE_START_SCALE;
    Main2.ImageTransparency = 0;

    for _, v in u3 do
        v.BackgroundTransparency = 0;
    end;

    layoutJumpScareBars();
    local v309 = OpenMusic;

    if v309 then
        local u310 = v309:Clone();
        u310.Parent = workspace.Debris;
        u310:Play();
        u310.Ended:Once(function() -- Line: 731
            -- upvalues: u310 (copy)
            u310:Destroy();
        end);
    end;

    local v311 = EvilChime;

    if v311 then
        local u312 = v311:Clone();
        u312.Parent = workspace.Debris;
        u312:Play();
        u312.Ended:Once(function() -- Line: 731
            -- upvalues: u312 (copy)
            u312:Destroy();
        end);
    end;

    local u313 = u2.JUMPSCARE_START_SCALE * u2.JUMPSCARE_CREEP_GROWTH;
    local u314 = u313 * u2.JUMPSCARE_RECOIL;
    local JUMPSCARE_CREEP_TIME = u2.JUMPSCARE_CREEP_TIME;
    local u315 = JUMPSCARE_CREEP_TIME + u2.JUMPSCARE_RECOIL_TIME;
    local u316 = u315 + u2.JUMPSCARE_TIME;
    local u317 = {};

    for i = 1, u2.JUMPSCARE_HITCHES do
        table.insert(u317, i / (u2.JUMPSCARE_HITCHES + 1));
        local _ = i;
    end;

    local u318 = 1;
    local u319 = 0;
    local u320 = 0;
    local u321 = nil;
    u321 = RunService.RenderStepped:Connect(function(p322) -- Line: 2536
        -- upvalues: u320 (ref), JUMPSCARE_CREEP_TIME (copy), u2 (ref), u313 (copy), u315 (copy), u314 (copy), u318 (ref), u317 (copy), u319 (ref), Main2 (ref), u3 (ref), JumpScareFrame (ref), Position7 (copy), UIScale2 (ref), layoutJumpScareBars (ref), u316 (copy), u321 (ref)
        u320 = u320 + p322;
        local v323 = 0;
        local v324;

        if u320 < JUMPSCARE_CREEP_TIME then
            local v325 = u320 / JUMPSCARE_CREEP_TIME;
            v324 = u2.JUMPSCARE_START_SCALE + (u313 - u2.JUMPSCARE_START_SCALE) * v325 * v325;
        elseif u320 < u315 then
            v324 = u313 + (u314 - u313) * ((u320 - JUMPSCARE_CREEP_TIME) / u2.JUMPSCARE_RECOIL_TIME);
        else
            local math_clamp_ret = math.clamp((u320 - u315) / u2.JUMPSCARE_TIME, 0, 1);
            local v326 = u314 + (u2.JUMPSCARE_END_SCALE - u314) * math_clamp_ret * math_clamp_ret * math_clamp_ret * math_clamp_ret * math_clamp_ret;

            if u318 <= #u317 and u317[u318] <= math_clamp_ret then
                u318 = u318 + 1;
                u319 = u2.JUMPSCARE_HITCH_FRAMES;
            end;

            if u319 > 0 then
                u319 = u319 - 1;
                v326 = v326 * (1 - u2.JUMPSCARE_HITCH_DROP);
            end;

            v323 = math.sin(math_clamp_ret * 3.141592653589793);
            v324 = v326 * (1 + (math.random() - 0.5) * 2 * u2.JUMPSCARE_JUDDER * v323);

            if u2.JUMPSCARE_FADE_AT < math_clamp_ret then
                local v327 = (math_clamp_ret - u2.JUMPSCARE_FADE_AT) / (1 - u2.JUMPSCARE_FADE_AT);
                Main2.ImageTransparency = v327;

                for _, v in u3 do
                    v.BackgroundTransparency = v327;
                end;
            end;
        end;

        JumpScareFrame.Position = Position7 + UDim2.fromOffset(math.random(-u2.JUMPSCARE_SHAKE, u2.JUMPSCARE_SHAKE) * v323, math.random(-u2.JUMPSCARE_SHAKE, u2.JUMPSCARE_SHAKE) * v323);
        JumpScareFrame.Rotation = (math.random() - 0.5) * 2 * u2.JUMPSCARE_TILT * v323;
        UIScale2.Scale = v324;
        layoutJumpScareBars();

        if u316 <= u320 then
            u321:Disconnect();
        end;
    end);
    task.delay(JUMPSCARE_CREEP_TIME, function() -- Line: 2592
        -- upvalues: u24 (ref), u308 (copy), u35 (ref), playEntryFlash (ref), u2 (ref), Main (ref), Position (ref)
        if u24 and u308 == u35 then
            playEntryFlash(u2.FLASH_TIME * 0.4, u2.FLASH_PEAK * 0.6, u2.FLASH_WHITE);
            local u328 = { 34, 29, 24, 20, 16, 13, 10, 8, 6, 4, 2 };
            task.spawn(function() -- Line: 768
                -- upvalues: u328 (copy), u24 (ref), Main (ref), Position (ref)
                for _, v in u328 do
                    if not u24 then
                        break;
                    end;

                    Main.Position = UDim2.new(Position.X.Scale, Position.X.Offset + math.random(-v, v), Position.Y.Scale, Position.Y.Offset + math.random(-v, v));
                    task.wait(0.02);
                end;

                Main.Position = Position;
            end);
        end;
    end);
    task.wait(u316);

    if u321.Connected then
        u321:Disconnect();
    end;

    JumpScareFrame.Position = Position7;
    JumpScareFrame.Rotation = 0;
    u4();
end;

local function playSmoke(u329: number) -- Line: 2614
    -- upvalues: SmokeTemplate (copy), u8 (ref), Position5 (copy), Scale3 (copy), u2 (copy), TweenService (copy), u24 (ref), u35 (ref)
    local v330 = SmokeTemplate;
    local v331 = v330:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
    v331.Parent = v330;
    local v332 = u8;

    if v332 then
        v332:Cancel();
    end;

    u8 = nil;
    SmokeTemplate.Position = Position5;
    SmokeTemplate.Rotation = 0;
    SmokeTemplate.ImageTransparency = 1;
    SmokeTemplate.Visible = true;
    v331.Scale = Scale3 * u2.SMOKE_START_SCALE;
    local v333 = TweenService:Create(v331, TweenInfo.new(u2.SMOKE_GROW_TIME + u2.SMOKE_FADE_TIME, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        Scale = Scale3 * u2.SMOKE_END_SCALE
    });
    v333:Play();
    u8 = v333;
    TweenService:Create(SmokeTemplate, TweenInfo.new(u2.SMOKE_GROW_TIME * 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        ImageTransparency = u2.SMOKE_PEAK_TRANSPARENCY
    }):Play();
    task.delay(u2.SMOKE_GROW_TIME, function() -- Line: 2636
        -- upvalues: u24 (ref), u329 (copy), u35 (ref), SmokeTemplate (ref), u2 (ref), TweenService (ref), Scale3 (ref)
        if not u24 or u329 ~= u35 then
            return;
        end;

        local v334 = TweenService:Create(SmokeTemplate, TweenInfo.new(u2.SMOKE_FADE_TIME, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            ImageTransparency = 1
        });
        v334:Play();
        v334.Completed:Once(function() -- Line: 2643
            -- upvalues: SmokeTemplate (ref), Scale3 (ref)
            SmokeTemplate.Visible = false;
            local v335 = SmokeTemplate;
            local v336 = v335:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
            v336.Parent = v335;
            v336.Scale = Scale3;
        end);
    end);
end;

local function flyGhoul(u337: userdata, u338: number, u339: number, p340: number, u341: number) -- Line: 2653
    -- upvalues: u24 (ref), u35 (ref), Position2 (copy), u2 (copy), Main (copy), u51 (copy), TweenService (copy)
    task.delay(p340, function() -- Line: 2654
        -- upvalues: u24 (ref), u341 (copy), u35 (ref), u337 (copy), Position2 (ref), u339 (copy), u2 (ref), u338 (copy), Main (ref), u51 (ref), TweenService (ref)
        if not u24 or u341 ~= u35 then
            return;
        end;

        local u342 = u337:Clone();
        local v343 = u342:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
        v343.Parent = u342;
        local Scale4 = Position2.X.Scale;
        local Scale5 = Position2.Y.Scale;
        local math_cos_ret = math.cos(u339);
        local u344 = math.sin(u339) * u2.GHOUL_VERTICAL_BIAS;
        local u345 = u2.GHOUL_REACH * (1 + (math.random() - 0.5) * 2 * u2.GHOUL_REACH_VARIANCE);
        local v346 = u2.GHOUL_FLY_TIME * (1 + (math.random() - 0.5) * 2 * u2.GHOUL_TIME_VARIANCE);
        local v347 = u338 * (u2.GHOUL_MIN_SCALE + math.random() * (u2.GHOUL_MAX_SCALE - u2.GHOUL_MIN_SCALE));
        local u348 = (math.random(0, 1) == 0 and -1 or 1) * math.random() * u2.GHOUL_ARC;
        u342.Name = "Ghoul";
        u342.Visible = true;
        u342.Position = UDim2.fromScale(Scale4, Scale5);
        u342.Rotation = math.random(-25, 25);
        u342.ImageTransparency = 1;
        u342.ZIndex = math.random(0, 1) == 0 and u2.GHOUL_BACK_ZINDEX or u2.GHOUL_FRONT_ZINDEX;
        u342.Parent = Main;
        u51[u342] = true;
        v343.Scale = u338 * u2.GHOUL_START_SCALE;
        TweenService:Create(u342, TweenInfo.new(v346 * 0.14, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            ImageTransparency = 0
        }):Play();
        TweenService:Create(v343, TweenInfo.new(v346, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Scale = v347
        }):Play();
        TweenService:Create(u342, TweenInfo.new(v346, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            Rotation = u342.Rotation + math.random(-u2.GHOUL_SPIN, u2.GHOUL_SPIN)
        }):Play();
        local NumberValue = Instance.new("NumberValue");
        NumberValue.Value = 0;
        local u351 = NumberValue:GetPropertyChangedSignal("Value"):Connect(function() -- Line: 2706
            -- upvalues: NumberValue (copy), u345 (copy), u348 (copy), u342 (copy), Scale4 (copy), math_cos_ret (copy), u344 (copy), Scale5 (copy)
            local Value = NumberValue.Value;
            local v349 = u345 * Value;
            local v350 = math.sin(Value * 3.141592653589793) * u348;
            u342.Position = UDim2.fromScale(Scale4 + math_cos_ret * v349 - u344 * v350, Scale5 + u344 * v349 + math_cos_ret * v350);
        end);
        local v352 = TweenService:Create(NumberValue, TweenInfo.new(v346, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Value = 1
        });
        v352:Play();
        v352.Completed:Once(function() -- Line: 2719
            -- upvalues: u351 (copy), NumberValue (copy), u342 (copy), u51 (ref)
            u351:Disconnect();
            NumberValue:Destroy();
            local v353 = u342;
            u51[v353] = nil;

            if v353.Parent then
                v353:Destroy();
            end;
        end);
    end);
end;

local function releaseGhouls(u354: number) -- Line: 2729
    -- upvalues: u2 (copy), GhoulTwo (copy), GhoulOne (copy), Scale2 (copy), Scale (copy), u24 (ref), u35 (ref), Position2 (copy), Main (copy), u51 (copy), TweenService (copy)
    local v355 = 6.283185307179586 / u2.GHOUL_COUNT;
    local v356 = math.random() * 3.141592653589793 * 2;

    for i = 1, u2.GHOUL_COUNT do
        local v357 = i % 2 == 0;
        local u358 = v357 and GhoulTwo or GhoulOne;
        local u359 = v357 and Scale2 or Scale;
        local u360 = v356 + (i - 1) * v355 + (math.random() - 0.5) * v355 * u2.GHOUL_SPREAD;
        task.delay((i - 1) * u2.GHOUL_STAGGER, function() -- Line: 2654
            -- upvalues: u24 (ref), u354 (copy), u35 (ref), u358 (copy), Position2 (ref), u360 (copy), u2 (ref), u359 (copy), Main (ref), u51 (ref), TweenService (ref)
            if not u24 or u354 ~= u35 then
                return;
            end;

            local u361 = u358:Clone();
            local v362 = u361:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
            v362.Parent = u361;
            local Scale4 = Position2.X.Scale;
            local Scale5 = Position2.Y.Scale;
            local math_cos_ret = math.cos(u360);
            local u363 = math.sin(u360) * u2.GHOUL_VERTICAL_BIAS;
            local u364 = u2.GHOUL_REACH * (1 + (math.random() - 0.5) * 2 * u2.GHOUL_REACH_VARIANCE);
            local v365 = u2.GHOUL_FLY_TIME * (1 + (math.random() - 0.5) * 2 * u2.GHOUL_TIME_VARIANCE);
            local v366 = u359 * (u2.GHOUL_MIN_SCALE + math.random() * (u2.GHOUL_MAX_SCALE - u2.GHOUL_MIN_SCALE));
            local u367 = (math.random(0, 1) == 0 and -1 or 1) * math.random() * u2.GHOUL_ARC;
            u361.Name = "Ghoul";
            u361.Visible = true;
            u361.Position = UDim2.fromScale(Scale4, Scale5);
            u361.Rotation = math.random(-25, 25);
            u361.ImageTransparency = 1;
            u361.ZIndex = math.random(0, 1) == 0 and u2.GHOUL_BACK_ZINDEX or u2.GHOUL_FRONT_ZINDEX;
            u361.Parent = Main;
            u51[u361] = true;
            v362.Scale = u359 * u2.GHOUL_START_SCALE;
            TweenService:Create(u361, TweenInfo.new(v365 * 0.14, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                ImageTransparency = 0
            }):Play();
            TweenService:Create(v362, TweenInfo.new(v365, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                Scale = v366
            }):Play();
            TweenService:Create(u361, TweenInfo.new(v365, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                Rotation = u361.Rotation + math.random(-u2.GHOUL_SPIN, u2.GHOUL_SPIN)
            }):Play();
            local NumberValue = Instance.new("NumberValue");
            NumberValue.Value = 0;
            local u370 = NumberValue:GetPropertyChangedSignal("Value"):Connect(function() -- Line: 2706
                -- upvalues: NumberValue (copy), u364 (copy), u367 (copy), u361 (copy), Scale4 (copy), math_cos_ret (copy), u363 (copy), Scale5 (copy)
                local Value = NumberValue.Value;
                local v368 = u364 * Value;
                local v369 = math.sin(Value * 3.141592653589793) * u367;
                u361.Position = UDim2.fromScale(Scale4 + math_cos_ret * v368 - u363 * v369, Scale5 + u363 * v368 + math_cos_ret * v369);
            end);
            local v371 = TweenService:Create(NumberValue, TweenInfo.new(v365, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                Value = 1
            });
            v371:Play();
            v371.Completed:Once(function() -- Line: 2719
                -- upvalues: u370 (copy), NumberValue (copy), u361 (copy), u51 (ref)
                u370:Disconnect();
                NumberValue:Destroy();
                local v372 = u361;
                u51[v372] = nil;

                if v372.Parent then
                    v372:Destroy();
                end;
            end);
        end);
        local _ = i;
    end;
end;

local function ghoulSwarmTime() -- Line: 2745
    -- upvalues: u2 (copy)
    return u2.GHOUL_FLY_TIME * (1 + u2.GHOUL_TIME_VARIANCE) + (u2.GHOUL_COUNT - 1) * u2.GHOUL_STAGGER;
end;

local function playRewardOpen(u373: number) -- Line: 2753
    -- upvalues: Reward2 (copy), u2 (copy), TweenService (copy), u24 (ref), u35 (ref), BoxOpen (copy), playSmoke (copy), releaseGhouls (copy), playEntryFlash (copy), Main (copy), Position (copy), playAuraSweep (copy), Cash (copy), burstParticlesIn (copy), startParticleFloat (copy), u37 (copy), u26 (ref), u43 (ref), u27 (ref)
    local v374 = Reward2;
    local v375 = v374:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
    v375.Parent = v374;
    Reward2.Visible = true;
    Reward2.Image = u2.REWARD_CLOSED_IMAGE;
    Reward2.Rotation = math.random(0, 1) == 0 and -u2.REWARD_SLAM_TILT or u2.REWARD_SLAM_TILT;
    v375.Scale = u2.REWARD_SLAM_SCALE;
    TweenService:Create(Reward2, TweenInfo.new(0.14, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        ImageTransparency = 0
    }):Play();
    TweenService:Create(v375, TweenInfo.new(u2.REWARD_SLAM_TIME, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Scale = 1
    }):Play();
    TweenService:Create(Reward2, TweenInfo.new(u2.REWARD_SLAM_TIME + u2.REWARD_SETTLE_TIME, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {
        Rotation = 0
    }):Play();
    task.wait(u2.REWARD_OPEN_DELAY);

    if not u24 or u373 ~= u35 then
        return;
    end;

    Reward2.Image = u2.REWARD_OPEN_IMAGE;
    local v376 = BoxOpen;

    if v376 then
        local u377 = v376:Clone();
        u377.Parent = workspace.Debris;
        u377:Play();
        u377.Ended:Once(function() -- Line: 731
            -- upvalues: u377 (copy)
            u377:Destroy();
        end);
    end;

    playSmoke(u373);
    releaseGhouls(u373);
    playEntryFlash(u2.FLASH_TIME * 0.6, u2.FLASH_PEAK, u2.FLASH_AMBER);
    local u378 = { 24, 20, 16, 13, 10, 8, 6, 4, 2 };
    task.spawn(function() -- Line: 768
        -- upvalues: u378 (copy), u24 (ref), Main (ref), Position (ref)
        for _, v in u378 do
            if not u24 then
                break;
            end;

            Main.Position = UDim2.new(Position.X.Scale, Position.X.Offset + math.random(-v, v), Position.Y.Scale, Position.Y.Offset + math.random(-v, v));
            task.wait(0.02);
        end;

        Main.Position = Position;
    end);
    playAuraSweep(true);
    v375.Scale = 1.18;
    TweenService:Create(v375, TweenInfo.new(u2.REWARD_SETTLE_TIME, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Scale = 1
    }):Play();
    task.delay((u2.GHOUL_FLY_TIME * (1 + u2.GHOUL_TIME_VARIANCE) + (u2.GHOUL_COUNT - 1) * u2.GHOUL_STAGGER) * u2.GHOUL_CLEAR_AT + u2.REWARD_PARTICLES_DELAY, function() -- Line: 2800
        -- upvalues: u24 (ref), u373 (copy), u35 (ref), Cash (ref), burstParticlesIn (ref), Reward2 (ref), startParticleFloat (ref), u37 (ref), u2 (ref), u26 (ref), u43 (ref), u27 (ref), TweenService (ref)
        if not u24 or u373 ~= u35 then
            return;
        end;

        local v379 = Cash;

        if v379 then
            local u380 = v379:Clone();
            u380.Parent = workspace.Debris;
            u380:Play();
            u380.Ended:Once(function() -- Line: 731
                -- upvalues: u380 (copy)
                u380:Destroy();
            end);
        end;

        burstParticlesIn(Reward2);
        startParticleFloat(Reward2, u37, function() -- Line: 2810
            -- upvalues: u24 (ref), u373 (ref), u35 (ref)
            return u24 and u373 == u35;
        end, u2.PARTICLE_BURST_TIME);
        u26 = true;
        local u381 = u373;

        if u43 then
            task.cancel(u43);
            u43 = nil;
        end;

        u43 = task.spawn(function() -- Line: 1527
            -- upvalues: Reward2 (ref), u24 (ref), u381 (copy), u35 (ref), u27 (ref), u2 (ref), TweenService (ref)
            local Random_new = Random.new;
            local v382 = os.clock() * 1000000;
            local v383 = Random_new(math.floor(v382) + math.random(1, 100000));
            local v384 = Reward2;
            local v385 = v384:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
            v385.Parent = v384;
            local v386 = true;

            while u24 and u381 == u35 do
                if u27 then
                    task.wait(0.15);
                else
                    local v387 = v383:NextNumber(u2.REWARD_BREATHE_MIN_TIME, u2.REWARD_BREATHE_MAX_TIME);
                    local TweenInfo_new_ret = TweenInfo.new(v387, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
                    local v388 = TweenService:Create(v385, TweenInfo_new_ret, {
                        Scale = v386 and 1 + u2.REWARD_BREATHE_SCALE or 1 - u2.REWARD_BREATHE_SCALE * 0.5
                    });
                    v388:Play();
                    TweenService:Create(Reward2, TweenInfo_new_ret, {
                        Rotation = v386 and u2.REWARD_BREATHE_TILT or -u2.REWARD_BREATHE_TILT
                    }):Play();
                    v388.Completed:Wait();
                    v386 = not v386;
                end;
            end;
        end);
    end);
end;

function u55.Open() -- Line: 2820
    -- upvalues: u24 (ref), u25 (ref), HalloweenBundle (copy), Main (copy), UIScale (copy), resetItems (copy), u35 (ref), resetEntryAnimation (copy), getPanelPieces (copy), playShine (copy), startMist (copy), playSunbursts (copy), playEmberLoop (copy), stopGlowLoop (copy), u49 (ref), spawnGlow (copy), u2 (copy), playGlowMask (copy), playBackdropSweep (copy), u44 (ref), BuyButton (copy), u52 (copy), TweenService (copy), playJumpScare (copy), playPanelEntrance (copy), playRewardOpen (copy)
    if u24 or u25 then
        return;
    end;

    u24 = true;
    u25 = true;
    HalloweenBundle.Enabled = true;
    Main.Visible = false;
    UIScale.Scale = 0;
    resetItems();
    local u389 = u35;
    resetEntryAnimation();
    Main.Visible = true;
    UIScale.Scale = 1;

    for _, v in getPanelPieces() do
        local v390 = v:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
        v390.Parent = v;
        v390.Scale = 0;
    end;

    playShine();
    startMist();
    playSunbursts(u389);
    playEmberLoop();
    stopGlowLoop();
    u49 = task.spawn(function() -- Line: 1285
        -- upvalues: u24 (ref), spawnGlow (ref), u2 (ref)
        while u24 do
            spawnGlow();
            task.wait(math.random(u2.GLOW_MIN_DELAY * 100, u2.GLOW_MAX_DELAY * 100) / 100);
        end;
    end);
    playGlowMask(u389);
    playBackdropSweep();

    if u44 then
        task.cancel(u44);
        u44 = nil;
    end;

    u44 = task.spawn(function() -- Line: 1656
        -- upvalues: BuyButton (ref), u2 (ref), u24 (ref), u389 (copy), u35 (ref), u52 (ref), TweenService (ref)
        local v391 = BuyButton;
        local v392 = v391:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
        v392.Parent = v391;
        task.wait(u2.HEARTBEAT_REST_MIN);

        while u24 and u389 == u35 do
            if u52[BuyButton] then
                task.wait(0.2);
            else
                local v393 = TweenService:Create(v392, TweenInfo.new(u2.HEARTBEAT_TIME * 0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Scale = u2.HEARTBEAT_SCALE
                });
                v393:Play();
                v393.Completed:Wait();

                if not u52[BuyButton] then
                    local v394 = TweenService:Create(v392, TweenInfo.new(u2.HEARTBEAT_TIME * 0.65, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                        Scale = 1
                    });
                    v394:Play();
                    v394.Completed:Wait();
                    task.wait(math.random(u2.HEARTBEAT_REST_MIN * 100, u2.HEARTBEAT_REST_MAX * 100) / 100);
                end;
            end;
        end;
    end);
    playJumpScare(u389);

    if not u24 or u389 ~= u35 then
        u25 = false;

        return;
    end;

    playPanelEntrance(u389);
    task.wait(u2.JUMPSCARE_HOLD);

    if u24 and u389 == u35 then
        playRewardOpen(u389);
    end;

    u25 = false;
end;

function u55.Close() -- Line: 2868
    -- upvalues: u24 (ref), u25 (ref), HalloweenBundle2 (copy), GlitchClose (copy), GlowMask (copy), TweenService (copy), UIScale (copy), u28 (ref), Shine (copy), stopEmberLoop (copy), stopGlowLoop (copy), resetItems (copy), resetEntryAnimation (copy), HalloweenBundle (copy)
    if not u24 or u25 then
        return;
    end;

    u24 = false;
    u25 = true;
    HalloweenBundle2.Visible = true;
    local v395 = GlitchClose;

    if v395 then
        local u396 = v395:Clone();
        u396.Parent = workspace.Debris;
        u396:Play();
        u396.Ended:Once(function() -- Line: 731
            -- upvalues: u396 (copy)
            u396:Destroy();
        end);
    end;

    if GlowMask then
        TweenService:Create(GlowMask, TweenInfo.new(0.14, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            GroupTransparency = 1
        }):Play();
    end;

    local v397 = TweenService:Create(UIScale, TweenInfo.new(0.18, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
        Scale = 0
    });
    v397:Play();
    v397.Completed:Wait();
    local v398 = u28;

    if v398 then
        v398:Cancel();
    end;

    u28 = nil;
    Shine.Visible = false;
    stopEmberLoop();
    stopGlowLoop();
    resetItems();
    resetEntryAnimation();
    HalloweenBundle.Enabled = false;
    u25 = false;
end;

function u55.KnitInit(p399) -- Line: 2901
end;

function u55.KnitStart(p400) -- Line: 2905
    -- upvalues: Knit (copy), GetUnixTime (copy), u54 (copy), u55 (copy), HalloweenBundle2 (copy), RunService (copy), Main (copy), NumberUtil (copy), UIScale (copy), ReplicatedStorage (copy), BuyButton (copy), setupButton (copy), SpinsOddsButton (copy), LocalPlayer (copy), HUD (copy), ZonesOddsButton (copy), ImageButton (copy), CloseButton (copy), resetItems (copy), resetEntryAnimation (copy), stopEmberLoop (copy), stopGlowLoop (copy), startParticleFloat (copy), Reward (copy), u38 (copy), u1 (ref), Sunburst (copy), u2 (copy), TweenService (copy), ImageButton2 (copy), u26 (ref), u27 (ref), playAuraSweep (copy), Reward2 (copy), u24 (ref), Position (copy), spawnEmber (copy), playRewardPunch (copy), RewardsFrame (copy), setupHoverFrame (copy)
    local Service = Knit.GetService("MarketService");
    local Controller = Knit.GetController("Network");
    local Controller2 = Knit.GetController("UIController");
    local Controller3 = Knit.GetController("PromptController");

    local function IsElegible() -- Line: 2911
        -- upvalues: Controller (copy), GetUnixTime (ref)
        local v401 = 0;

        for _, v in Controller.Player.PurchaseHistory do
            if v == 3722675474 then
                v401 = v401 + 1;
            end;
        end;

        if v401 >= 2 then
            return false;
        end;

        return GetUnixTime() < workspace:GetAttribute("HalloweenBundleTime");
    end;

    local u402 = nil;

    local function OnDataChanged() -- Line: 2929
        -- upvalues: u54 (ref), Controller (copy), GetUnixTime (ref), u55 (ref), HalloweenBundle2 (ref), RunService (ref), u402 (ref), OnDataChanged (copy), Main (ref), NumberUtil (ref)
        u54:Clean();
        local v403 = 0;

        for _, v in Controller.Player.PurchaseHistory do
            if v == 3722675474 then
                v403 = v403 + 1;
            end;
        end;

        local v404;

        if v403 >= 2 then
            v404 = false;
        else
            v404 = GetUnixTime() < workspace:GetAttribute("HalloweenBundleTime");
        end;

        if not v404 then
            u55.Close();
            HalloweenBundle2.Visible = false;

            return;
        end;

        u54:Add(RunService.Heartbeat:Connect(function() -- Line: 2939
            -- upvalues: GetUnixTime (ref), u402 (ref), Controller (ref), OnDataChanged (ref), Main (ref), NumberUtil (ref)
            local v405 = GetUnixTime();

            if u402 == v405 then
                return;
            end;

            u402 = v405;
            local v406 = workspace:GetAttribute("HalloweenBundleTime") - v405;
            local v407 = 0;

            for _, v in Controller.Player.PurchaseHistory do
                if v == 3722675474 then
                    v407 = v407 + 1;
                end;
            end;

            local v408;

            if v407 >= 2 then
                v408 = false;
            else
                v408 = GetUnixTime() < workspace:GetAttribute("HalloweenBundleTime");
            end;

            if v408 then
                Main.Header.Contents.Subtitle.Text = `TIME LEFT: {NumberUtil.AdaptiveClockString(v406)}`;

                return;
            end;

            task.spawn(OnDataChanged);
        end));
        local v409 = 0;

        for _, v in Controller.Player.PurchaseHistory do
            if v == 3722675474 then
                v409 = v409 + 1;
            end;
        end;

        HalloweenBundle2.Visible = true;
    end;

    HalloweenBundle2.Visible = true;
    UIScale.Scale = 0;
    task.spawn(OnDataChanged);
    ReplicatedStorage.Controllers.NewData.Changed:Connect(function() -- Line: 2973
        -- upvalues: OnDataChanged (copy)
        OnDataChanged();
    end);
    local v410 = Controller3.RepeatGetProductInfo(3722675474, Enum.InfoType.Product);
    BuyButton.TextLabel.Text = v410.PriceInRobux;
    setupButton(BuyButton, function() -- Line: 2980
        -- upvalues: Service (copy)
        Service.PromptHalloweenBundle(Service);
    end);
    setupButton(SpinsOddsButton, function() -- Line: 2984
        -- upvalues: u55 (ref), Controller2 (copy), LocalPlayer (ref), HUD (ref)
        u55.Close();
        Controller2:Focus(false);
        workspace.CurrentCamera.CameraType = Enum.CameraType.Custom;
        LocalPlayer.PlayerGui.Style.Enabled = true;
        HUD.Enabled = false;
    end);
    setupButton(ZonesOddsButton, function() -- Line: 2995
        -- upvalues: u55 (ref), Controller2 (copy), LocalPlayer (ref), HUD (ref)
        u55.Close();
        Controller2:Focus(false);
        workspace.CurrentCamera.CameraType = Enum.CameraType.Custom;
        LocalPlayer.PlayerGui.Zone.Enabled = true;
        HUD.Enabled = false;
    end);
    setupButton(ImageButton, u55.Open);
    setupButton(CloseButton, u55.Close);
    resetItems();
    resetEntryAnimation();
    stopEmberLoop();
    stopGlowLoop();
    startParticleFloat(Reward, u38, function() -- Line: 3014
        return true;
    end);
    local v411 = u1;

    if v411 then
        v411:Cancel();
    end;

    u1 = nil;
    local v412 = TweenService:Create(Sunburst, TweenInfo.new(u2.BUTTON_SUNBURST_SPIN_TIME, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1), {
        Rotation = Sunburst.Rotation + 360
    });
    v412:Play();
    u1 = v412;
    ImageButton.MouseEnter:Connect(function() -- Line: 3026
        -- upvalues: Reward (ref), TweenService (ref)
        local v413 = Reward;
        local v414 = v413:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
        v414.Parent = v413;
        TweenService:Create(v414, TweenInfo.new(0.12, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Scale = 1.075
        }):Play();
        local v415 = math.random(0, 1) == 0 and -10 or 10;
        TweenService:Create(Reward, TweenInfo.new(0.12, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Rotation = v415
        }):Play();
    end);
    ImageButton.MouseLeave:Connect(function() -- Line: 3033
        -- upvalues: Reward (ref), TweenService (ref)
        local v416 = Reward;
        local v417 = v416:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
        v417.Parent = v416;
        TweenService:Create(v417, TweenInfo.new(0.12, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Scale = 1
        }):Play();
        TweenService:Create(Reward, TweenInfo.new(0.12, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Rotation = 0
        }):Play();
    end);
    ImageButton2.MouseEnter:Connect(function() -- Line: 3038
        -- upvalues: u26 (ref), u27 (ref), playAuraSweep (ref), Reward2 (ref), TweenService (ref)
        if not u26 then
            return;
        end;

        u27 = true;
        playAuraSweep(true);
        local v418 = Reward2;
        local v419 = v418:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
        v419.Parent = v418;
        TweenService:Create(v419, TweenInfo.new(0.12, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Scale = 1.075
        }):Play();
        local v420 = math.random(0, 1) == 0 and -10 or 10;
        TweenService:Create(Reward2, TweenInfo.new(0.12, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Rotation = v420
        }):Play();
    end);
    ImageButton2.MouseLeave:Connect(function() -- Line: 3053
        -- upvalues: u26 (ref), u27 (ref), Reward2 (ref), TweenService (ref)
        if not u26 then
            return;
        end;

        u27 = false;
        local v421 = Reward2;
        local v422 = v421:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
        v422.Parent = v421;
        TweenService:Create(v422, TweenInfo.new(0.12, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Scale = 1
        }):Play();
        TweenService:Create(Reward2, TweenInfo.new(0.12, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Rotation = 0
        }):Play();
    end);
    ImageButton2.Activated:Connect(function() -- Line: 3064
        -- upvalues: u26 (ref), u24 (ref), Main (ref), Position (ref), playAuraSweep (ref), u2 (ref), spawnEmber (ref), playRewardPunch (ref)
        if not u26 then
            return;
        end;

        local u423 = { 6, 5, 4, 3, 2 };
        task.spawn(function() -- Line: 768
            -- upvalues: u423 (copy), u24 (ref), Main (ref), Position (ref)
            for _, v in u423 do
                if not u24 then
                    break;
                end;

                Main.Position = UDim2.new(Position.X.Scale, Position.X.Offset + math.random(-v, v), Position.Y.Scale, Position.Y.Offset + math.random(-v, v));
                task.wait(0.02);
            end;

            Main.Position = Position;
        end);
        playAuraSweep(true);
        task.spawn(function() -- Line: 1184
            -- upvalues: u2 (ref), u24 (ref), spawnEmber (ref)
            for i = 1, u2.EMBER_BURST_COUNT do
                if not u24 then
                    break;
                end;

                spawnEmber(math.random(0, 22) / 100);
                task.wait(u2.EMBER_BURST_STAGGER);
                local _ = i;
            end;
        end);
        playRewardPunch();
    end);

    for _, child in RewardsFrame:GetChildren() do
        if child:IsA("Frame") then
            setupHoverFrame(child);
        end;
    end;
end;

return u55;