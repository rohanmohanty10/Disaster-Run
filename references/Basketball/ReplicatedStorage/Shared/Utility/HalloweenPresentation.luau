 
 

return function(u1, p2, u3) -- Line: 1
    local TweenService = game:GetService("TweenService");
    local RunService = game:GetService("RunService");
    local ReplicatedStorage = game:GetService("ReplicatedStorage");
    game:GetService("SoundService");
    local Customization = require(ReplicatedStorage.Shared.Tables.Customization);
    game:GetService("Lighting");
    local Rows = u3.Catalog.Rows;
    local HalloweenFlames = require(ReplicatedStorage.Shared.Tables.HalloweenFlames);
    local PlayerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui");
    local HalloweenEvent = u1:WaitForChild("HalloweenEvent");
    local Position = HalloweenEvent.Position;
    local TitleFrame = HalloweenEvent:WaitForChild("TitleFrame");
    local VertLine = TitleFrame:WaitForChild("VertLine");
    local UIGradient = VertLine:WaitForChild("UIGradient");
    local HorizontalLine = TitleFrame:WaitForChild("HorizontalLine");
    local UIGradient2 = HorizontalLine:WaitForChild("UIGradient");
    local TextFrame = TitleFrame:WaitForChild("TextFrame");
    local Tag = TextFrame:WaitForChild("Tag");
    local TitleFrame2 = TextFrame:WaitForChild("TitleFrame");
    local SubtitleFrame = TextFrame:WaitForChild("SubtitleFrame");
    local SideTextMask = TitleFrame:WaitForChild("SideTextMask");
    local TextLabelTemplate = SideTextMask:WaitForChild("TextLabelTemplate");
    TextLabelTemplate.Visible = false;
    local Position2 = TextFrame.Position;
    local CloseButton = HalloweenEvent:WaitForChild("CloseButton");
    local CandyFrame = HalloweenEvent:WaitForChild("CandyFrame");
    local Icon = CandyFrame:WaitForChild("Icon");
    local AmountLabel = CandyFrame:WaitForChild("AmountLabel");
    local Position3 = CandyFrame.Position;
    local Character = HalloweenEvent:WaitForChild("Character");
    local Position4 = Character.Position;
    local Flame = HalloweenEvent:WaitForChild("Flame");
    local Position5 = Flame.Position;
    local Rotation = Flame.Rotation;
    local ImageTransparency = Flame.ImageTransparency;
    local Image = Flame.Image;
    local u4 = {};
    local u5 = {};
    local u6 = {};

    for i = 1, #HalloweenFlames do
        local v7 = "rbxassetid://" .. tostring(HalloweenFlames[i]);
        table.insert(u4, v7);
        local _ = i;
    end;

    task.spawn(function() -- Line: 76
        -- upvalues: u4 (copy)
        pcall(function() -- Line: 77
            -- upvalues: u4 (ref)
            game:GetService("ContentProvider"):PreloadAsync(u4);
        end);
    end);
    local u8 = {};

    for _, child in HalloweenEvent:GetChildren() do
        if child:IsA("ImageLabel") and child.Name == "Cobweb" then
            local v9 = child:FindFirstChildOfClass("UIScale");
            table.insert(u8, {
                Instance = child,
                BaseScale = v9 and v9.Scale or 1
            });
        end;
    end;

    local HalloweenJumpScareGui = PlayerGui:FindFirstChild("HalloweenJumpScareGui");

    if not HalloweenJumpScareGui then
        HalloweenJumpScareGui = Instance.new("ScreenGui");
        HalloweenJumpScareGui.Name = "HalloweenJumpScareGui";
        HalloweenJumpScareGui.IgnoreGuiInset = true;
        HalloweenJumpScareGui.ScreenInsets = Enum.ScreenInsets.None;
        HalloweenJumpScareGui.ResetOnSpawn = false;
        HalloweenJumpScareGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
        HalloweenJumpScareGui.DisplayOrder = u1.DisplayOrder + 10;
        HalloweenJumpScareGui.Parent = PlayerGui;
    end;

    local u10 = HalloweenEvent:FindFirstChild("JumpScareFrame") or HalloweenJumpScareGui:WaitForChild("JumpScareFrame");
    u10.Parent = HalloweenJumpScareGui;
    local Main = u10:WaitForChild("Main");
    local UIScale = Main:WaitForChild("UIScale");
    local u11 = {};
    local BgMask = HalloweenEvent:WaitForChild("BgMask");
    local Texture = BgMask:WaitForChild("Container"):WaitForChild("Texture");
    local GroupTransparency = BgMask.GroupTransparency;
    local SmokeMask = HalloweenEvent:WaitForChild("SmokeMask");
    local SmokeTemplate = SmokeMask:WaitForChild("SmokeTemplate");
    SmokeTemplate.Visible = false;
    local MistMask = HalloweenEvent:WaitForChild("MistMask");
    local MistTemplate = MistMask:WaitForChild("MistTemplate");
    MistTemplate.Visible = false;
    local Eyeglow = Character:FindFirstChild("Eyeglow");

    if Eyeglow then
        Eyeglow = Eyeglow:FindFirstChildOfClass("UIShadow");
    end;

    local Frame = Instance.new("Frame");
    Frame.Name = "LightningFlash";
    Frame.BackgroundColor3 = Color3.fromRGB(205, 225, 255);
    Frame.BackgroundTransparency = 1;
    Frame.BorderSizePixel = 0;
    Frame.AnchorPoint = Vector2.new(0.5, 0.5);
    Frame.Position = UDim2.fromScale(0.5, 0.5);
    Frame.Size = UDim2.fromScale(1, 1);
    Frame.ZIndex = -3;
    Frame.Parent = HalloweenEvent;
    local BatMask = HalloweenEvent:WaitForChild("BatMask");
    local BatTemplate = BatMask:WaitForChild("BatTemplate");
    BatTemplate.Visible = false;
    local Size = BatTemplate.Size;
    local ShopCg = HalloweenEvent:WaitForChild("ShopCg");
    local Content = ShopCg:WaitForChild("Content");
    local Position6 = Content.Position;
    local Tag2 = Content:WaitForChild("Tag");
    local LockedCg = Content:WaitForChild("LockedCg");
    local BatChestFrame = Content:WaitForChild("BatChestFrame");
    local ImageButton = BatChestFrame:WaitForChild("ImageButton");
    local Holder = BatChestFrame:WaitForChild("Holder");
    local Chest = BatChestFrame:WaitForChild("Chest");
    local Title = Holder:WaitForChild("Title");
    local ContentsFrame = Holder:WaitForChild("ContentsFrame");
    local Shine = Holder:WaitForChild("ShineHolder"):FindFirstChild("Shine");
    local CandyCorn = Holder:FindFirstChild("CandyCorn");
    ImageButton.ZIndex = Holder.ZIndex - 1;
    local BindableEvent = Instance.new("BindableEvent");
    u5.BatChestPressed = BindableEvent.Event;
    local ScrollingFrame = Content:WaitForChild("ScrollingFrame");
    local UIListLayout = ScrollingFrame:WaitForChild("UIListLayout");
    local DoubleRowFrame = ScrollingFrame:WaitForChild("DoubleRowFrame");
    local TripleRowFrame = ScrollingFrame:WaitForChild("TripleRowFrame");
    DoubleRowFrame.Visible = false;
    TripleRowFrame.Visible = false;
    local BindableEvent2 = Instance.new("BindableEvent");
    u5.PurchaseRequested = BindableEvent2.Event;
    local Frame2 = Instance.new("Frame");
    Frame2.Name = "EntryFlash";
    Frame2.BackgroundColor3 = Color3.new(1, 1, 1);
    Frame2.BackgroundTransparency = 1;
    Frame2.BorderSizePixel = 0;
    Frame2.AnchorPoint = Vector2.new(0.5, 0.5);
    Frame2.Position = UDim2.fromScale(0.5, 0.5);
    Frame2.Size = UDim2.fromScale(1, 1);
    Frame2.ZIndex = 1001;
    Frame2.Parent = HalloweenJumpScareGui;
    u6.JUMPSCARE_ZINDEX = 1000;
    u6.JUMPSCARE_SEAL = 0.03;
    u6.JUMPSCARE_BAR_MARGIN = 0.8;
    u6.JUMPSCARE_START_SCALE = 0.16;
    u6.JUMPSCARE_CREEP_TIME = 0.6;
    u6.JUMPSCARE_CREEP_GROWTH = 1.4;
    u6.JUMPSCARE_RECOIL_TIME = 0.07;
    u6.JUMPSCARE_RECOIL = 0.72;
    u6.JUMPSCARE_TIME = 0.46;
    u6.JUMPSCARE_END_SCALE = 11;
    u6.JUMPSCARE_FADE_AT = 0.5;
    u6.JUMPSCARE_HOLD = 0.1;
    u6.JUMPSCARE_JUDDER = 0.085;
    u6.JUMPSCARE_SHAKE = 16;
    u6.JUMPSCARE_TILT = 2.2;
    u6.JUMPSCARE_HITCHES = 3;
    u6.JUMPSCARE_HITCH_DROP = 0.22;
    u6.JUMPSCARE_HITCH_FRAMES = 2;
    u6.FLASH_TIME = 0.22;
    u6.FLASH_PEAK = 0.12;
    u6.FLASH_WHITE = Color3.fromRGB(255, 255, 255);
    u6.FLASH_AMBER = Color3.fromRGB(255, 140, 40);
    u6.SMOKE = {
        Prefill = 7,
        MinDelay = 1.1,
        MaxDelay = 2.2,
        MinTime = 16,
        MaxTime = 26,
        StartX = -0.35,
        EndX = 1.35,
        MinY = -0.05,
        MaxY = 1.05,
        DriftY = 0.08,
        MinScale = 0.7,
        MaxScale = 1.35,
        MinTransparency = 0.55,
        MaxTransparency = 0.8,
        FadeInTime = 2.2,
        FadeOutTime = 2.6,
        Spin = 14
    };
    u6.MIST = {
        Prefill = 16,
        MinDelay = 0.35,
        MaxDelay = 0.75,
        MinTime = 30,
        MaxTime = 44,
        StartX = -0.35,
        EndX = 1.35,
        MinY = 0.45,
        MaxY = 1.05,
        DriftY = 0.04,
        MinScale = 1,
        MaxScale = 1.6,
        MinTransparency = 0,
        MaxTransparency = 0.12,
        FadeInTime = 2,
        FadeOutTime = 2.4,
        Spin = 8
    };
    u6.LIGHTNING_FIRST_DELAY = 2.5;
    u6.LIGHTNING_MIN_INTERVAL = 7;
    u6.LIGHTNING_MAX_INTERVAL = 14;
    u6.LIGHTNING_PEAK = 0.55;
    u6.LIGHTNING_ECHO_PEAK = 0.75;
    u6.LIGHTNING_GAP = 0.09;
    u6.LIGHTNING_STRIKE_INFO = TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
    u6.LIGHTNING_FADE_INFO = TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
    u6.EYE_GLOW_TRANSPARENCY = 0.35;
    u6.EYE_GLOW_DELAY = 0.15;
    u6.EYE_GLOW_PULSE_INFO = TweenInfo.new(1.1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true);
    u6.BAT_FIRST_DELAY = 0.8;
    u6.BAT_MIN_INTERVAL = 3.5;
    u6.BAT_MAX_INTERVAL = 8;
    u6.BAT_MIN_COUNT = 4;
    u6.BAT_MAX_COUNT = 7;
    u6.BAT_MIN_TIME = 2.6;
    u6.BAT_MAX_TIME = 3.8;
    u6.BAT_STAGGER = 0.09;
    u6.BAT_SPREAD = 0.09;
    u6.BAT_START_X = -0.12;
    u6.BAT_START_Y = 1.18;
    u6.BAT_END_X_MIN = 0.45;
    u6.BAT_END_X_MAX = 0.8;
    u6.BAT_END_Y = -0.3;
    u6.BAT_START_SCALE_MIN = 0.85;
    u6.BAT_START_SCALE_MAX = 1.25;
    u6.BAT_END_SCALE = 0.45;
    u6.BAT_FLAP_MIN = 0.07;
    u6.BAT_FLAP_MAX = 0.11;
    u6.BAT_FLAP_SQUASH = 0.55;
    u6.BAT_WAVE = 0.025;
    u6.BAT_CURVE_X = 0.45;
    u6.BAT_CURVE_Y = 0.55;
    u6.BAT_TILT = 14;
    u6.LINE_DRAW_TIME = 0.65;
    u6.LINE_DRAW_EASING_STYLE = Enum.EasingStyle.Quint;
    u6.LINE_DRAW_EASING_DIRECTION = Enum.EasingDirection.Out;
    u6.LINE_DRAW_SOFTNESS = 0.05;
    u6.LINE_DRAW_STAGGER = 0.1;
    u6.LINE_DRAW_START_DELAY = 0.3;
    u6.LINE_ERASE_TIME = 0.22;
    u6.SPIDER_CRAWL_TIME = 1.6;
    u6.SPIDER_CRAWL_STYLE = Enum.EasingStyle.Sine;
    u6.SPIDER_CRAWL_DIRECTION = Enum.EasingDirection.Out;
    u6.SPIDER_STAGGER = 0.25;
    u6.SPIDER_LINE_FINISH_TIME = 0.9;
    u6.SPIDER_WIGGLE_PIXELS = 3;
    u6.SPIDER_WIGGLE_SPEED = 18;
    u6.SPIDER_WALK_ROTATION = 8;
    u6.SPIDER_WALK_SPEED = 22;
    u6.SPIDER_LAND_SCALE = 1.15;
    u6.SPIDER_LAND_INFO = TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out);
    u6.SPIDER_TWITCH_MIN_DELAY = 1.5;
    u6.SPIDER_TWITCH_MAX_DELAY = 3.5;
    u6.SPIDER_TWITCH_ROTATION = 12;
    u6.SPIDER_TWITCH_INFO = TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
    u6.SPIDER_SETTLE_INFO = TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out);
    u6.TEXT_FRAME_INTRO_TIME = 0.5;
    u6.TEXT_FRAME_START_Y_OFFSET = -0.6;
    u6.CAROUSEL_SPACING = 0.52;
    u6.CAROUSEL_SPEED = 0.12;
    u6.CAROUSEL_START_X = -0.65;
    u6.CAROUSEL_FINISH_X = 1.65;
    u6.TITLE_POP_INFO = TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out);
    u6.FADE_INFO = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
    u6.CHARACTER_JOLT_SCALE = 1.08;
    u6.CHARACTER_SETTLE_INFO = TweenInfo.new(0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out);
    u6.CHARACTER_DRIFT = 0.012;
    u6.CHARACTER_DRIFT_MIN_TIME = 2.2;
    u6.CHARACTER_DRIFT_MAX_TIME = 3.2;
    u6.CANDY_START_Y_OFFSET = -0.2;
    u6.CANDY_INTRO_INFO = TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out);
    u6.CANDY_COUNT_TIME = 0.9;
    u6.CLOSE_POP_INFO = TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out);
    u6.FLAME_RISE = 0.35;
    u6.FLAME_INTRO_INFO = TweenInfo.new(0.7, Enum.EasingStyle.Quint, Enum.EasingDirection.Out);
    u6.FLAME_FPS = 15;
    u6.COBWEB_INTRO_INFO = TweenInfo.new(0.55, Enum.EasingStyle.Back, Enum.EasingDirection.Out);
    u6.COBWEB_STAGGER = 0.08;
    u6.COBWEB_BREATHE_INFO = TweenInfo.new(3.4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true);
    u6.COBWEB_BREATHE_SCALE = 1.03;
    u6.BG_FADE_INFO = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
    u6.BG_BREATHE_INFO = TweenInfo.new(6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true);
    u6.BG_BREATHE_SCALE = 1.06;
    u6.PARTICLE_MIN_TIME = 1.2;
    u6.PARTICLE_MAX_TIME = 2.6;
    u6.PARTICLE_MIN_RISE = 5;
    u6.PARTICLE_MAX_RISE = 14;
    u6.PARTICLE_DRIFT = 4;
    u6.PARTICLE_SCALE = 0.06;
    u6.PARTICLE_ROTATION = 5;
    u6.SHOP_START_SCALE = 0.85;
    u6.SHOP_RISE = 0.08;
    u6.SHOP_INTRO_INFO = TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out);
    u6.SHOP_FADE_INFO = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
    u6.SHOP_ENTRY_DELAY = 0.2;
    u6.SHOP_ENTRY_STAGGER = 0.07;
    u6.ENTRY_REVEAL_INFO = TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out);
    u6.ENTRY_FADE_INFO = TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
    u6.ENTRY_ICON_INFO = TweenInfo.new(0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out);
    u6.ENTRY_SHINE_INFO = TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
    u6.ENTRY_ICON_START_ROTATION = -25;
    u6.ENTRY_ICON_BOB = 4;
    u6.ENTRY_ICON_BOB_MIN_TIME = 1.4;
    u6.ENTRY_ICON_BOB_MAX_TIME = 2.2;
    u6.ENTRY_HOVER_SCALE = 1.04;
    u6.ENTRY_HOVER_ICON_SCALE = 1.12;
    u6.ENTRY_HOVER_ICON_ROTATION = 6;
    u6.ENTRY_HOVER_SHINE_ROTATION = 180;
    u6.ENTRY_HOVER_INFO = TweenInfo.new(0.18, Enum.EasingStyle.Back, Enum.EasingDirection.Out);
    u6.ENTRY_LEAVE_INFO = TweenInfo.new(0.16, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
    u6.ENTRY_SHINE_HOVER_INFO = TweenInfo.new(0.45, Enum.EasingStyle.Quint, Enum.EasingDirection.Out);
    u6.BUTTON_HOVER_SCALE = 1.08;
    u6.BUTTON_PRESS_SCALE = 0.94;
    u6.BUTTON_HOVER_INFO = TweenInfo.new(0.16, Enum.EasingStyle.Back, Enum.EasingDirection.Out);
    u6.BUTTON_LEAVE_INFO = TweenInfo.new(0.14, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
    u6.BUTTON_PRESS_INFO = TweenInfo.new(0.07, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
    u6.BUTTON_RELEASE_INFO = TweenInfo.new(0.18, Enum.EasingStyle.Back, Enum.EasingDirection.Out);
    u6.LOCK_FADE_INFO = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
    u6.CHANCES_START_SCALE = 0.85;
    u6.CHANCES_FADE_INFO = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
    u6.CHANCES_BACKDROP_TRANSPARENCY = 0.45;
    u6.CHANCES_ENTRY_DELAY = 0.15;
    u6.CHANCES_ENTRY_STAGGER = 0.06;
    u6.UNBOX_FADE_INFO = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
    u6.UNBOX_DROP_HEIGHT = 0.7;
    u6.UNBOX_DROP_INFO = TweenInfo.new(0.38, Enum.EasingStyle.Quart, Enum.EasingDirection.In);
    u6.UNBOX_LAND_SQUASH = 1.25;
    u6.UNBOX_LAND_INFO = TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out);
    u6.UNBOX_LAND_SHAKE = 14;
    u6.UNBOX_SETTLE_TIME = 0.35;
    u6.UNBOX_RATTLES = { { 4, 5, 1.05 }, { 6, 8, 1.1 }, { 9, 12, 1.15 } };
    u6.UNBOX_RATTLE_TIME = 0.3;
    u6.UNBOX_RATTLE_GAP = 0.22;
    u6.UNBOX_CHARGE_TIME = 0.65;
    u6.UNBOX_CHARGE_SCALE = 1.3;
    u6.UNBOX_CHARGE_PIXELS = 12;
    u6.UNBOX_CHARGE_DEGREES = 18;
    u6.UNBOX_BURST_SCALE = 1.8;
    u6.UNBOX_BURST_INFO = TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
    u6.UNBOX_FLASH_TIME = 0.45;
    u6.UNBOX_FLASH_PEAK = 0.05;
    u6.UNBOX_IMPACT = { 30, 26, 22, 18, 15, 12, 9, 7, 5, 3, 2 };
    u6.UNBOX_CANDY_COUNT = 22;
    u6.UNBOX_CANDY_SIZE = 0.055;
    u6.UNBOX_CANDY_MIN_DISTANCE = 0.18;
    u6.UNBOX_CANDY_MAX_DISTANCE = 0.45;
    u6.UNBOX_CANDY_GRAVITY = 0.35;
    u6.UNBOX_CANDY_MIN_LIFE = 0.9;
    u6.UNBOX_CANDY_MAX_LIFE = 1.4;
    u6.UNBOX_CANDY_SPIN = 540;
    u6.UNBOX_SUNBURST_INFO = TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out);
    u6.UNBOX_SUNBURST_IDLE_SCALE = 1;
    u6.UNBOX_SUNBURST_CHARGE_SCALE = 1.2;
    u6.UNBOX_SUNBURST_BOOM_SCALE = 1.5;
    u6.UNBOX_SUNBURST_SPIN_TIME = 10;
    u6.UNBOX_COUNTER_SPIN_TIME = 16;
    u6.UNBOX_SUNBURST_BREATHE_SCALE = 1.06;
    u6.UNBOX_SUNBURST_BREATHE_INFO = TweenInfo.new(2.4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true);
    u6.UNBOX_REWARD_INFO = TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out);
    u6.UNBOX_REWARD_START_ROTATION = -25;
    u6.UNBOX_REWARD_BOB = 6;
    u6.UNBOX_REWARD_BOB_INFO = TweenInfo.new(1.6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true);
    u6.UNBOX_NAME_DELAY = 0.2;
    u6.UNBOX_NAME_TYPE_TIME = 0.4;
    u6.UNBOX_STRIP_Y = 0.97;
    u6.UNBOX_STRIP_WIDTH = 0.55;
    u6.UNBOX_STRIP_HEIGHT = 0.26;
    u6.UNBOX_STRIP_STAGGER = 0.05;
    u6.UNBOX_STRIP_JIGGLE = 1.5;
    u6.UNBOX_SKIP_DELAY = 0.35;
    u6.UNBOX_SKIP_SHINE_INFO = TweenInfo.new(0.55, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);
    u6.UNBOX_SKIP_SHINE_INTERVAL = 1.4;
    u6.UNBOX_SKIP_SHINE_MARGIN = 0.3;
    u6.UNBOX_HOLD_TIME = 2.4;
    u6.CHEST_REVEAL_DELAY = 0.1;
    u6.CHEST_POP_INFO = TweenInfo.new(0.55, Enum.EasingStyle.Back, Enum.EasingDirection.Out);
    u6.CHEST_START_ROTATION = -18;
    u6.CHEST_ENTRY_DELAY = 0.18;
    u6.CHEST_ENTRY_STAGGER = 0.06;
    u6.CHEST_FLOAT = 0.05;
    u6.CHEST_FLOAT_INFO = TweenInfo.new(1.7, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true);
    u6.CHEST_SWAY = 4;
    u6.CHEST_SWAY_TIME = 2.4;
    u6.CHEST_BREATHE_SCALE = 1.03;
    u6.CHEST_BREATHE_INFO = TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true);
    u6.CHEST_ENTRY_BOB = 3;
    u6.CHEST_ENTRY_BOB_MIN_TIME = 1.3;
    u6.CHEST_ENTRY_BOB_MAX_TIME = 2.1;
    u6.CHEST_SHINE_START_X = 0;
    u6.CHEST_SHINE_END_X = 1;
    u6.CHEST_SHINE_MARGIN = 0.06;
    u6.CHEST_CANDY_DELAY = 0.42;
    u6.HUD_SUNBURST_SPIN_TIME = 14;
    u6.HUD_BOB_PIXELS = 5;
    u6.HUD_BOB_MIN_TIME = 1.3;
    u6.HUD_BOB_MAX_TIME = 2.1;
    u6.HUD_CANDY_WOBBLE = 8;
    u6.HUD_ALERT_PULSE_SCALE = 1.15;
    u6.HUD_ALERT_PULSE_INFO = TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true);
    u6.HUD_HOVER_SCALE = 1.08;
    u6.HUD_CHARACTER_HOVER_SCALE = 1.075;
    u6.HUD_CHARACTER_HOVER_TILT = 8;
    u6.HUD_SHOW_INFO = TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out);
    u6.CHEST_SHINE_INFO = TweenInfo.new(0.75, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);
    u6.CHEST_SHINE_FIRST_DELAY = 0.45;
    u6.CHEST_SHINE_MIN_INTERVAL = 2.5;
    u6.CHEST_SHINE_MAX_INTERVAL = 4.5;
    u6.CHEST_HOVER_SCALE = 1.12;
    u6.CHEST_PRESS_SCALE = 0.92;
    u6.CHEST_EXIT_STAGGER = 0.03;
    u6.CHEST_ENTRY_HOVER_SCALE = 1.06;
    u6.EXIT_INFO = TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.In);
    u6.EXIT_FADE_INFO = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.In);
    u6.EVENT_FADE_TIME = 0.32;
    u6.BLUR_SIZE = 14;
    local u12 = 0;
    local u13 = 0;
    local u14 = false;
    local u15 = true;
    local u16 = false;
    local u17 = false;
    local u18 = 0;
    local u19 = {};
    local u20 = {};
    local u21 = {};

    local function tween(p22, p23, p24) -- Line: 588
        -- upvalues: TweenService (copy)
        local v25 = TweenService:Create(p22, p23, p24);
        v25:Play();

        return v25;
    end;

    local function isCurrentSequence(p26: number) -- Line: 600
        -- upvalues: u16 (ref), u18 (ref)
        return u16 and p26 == u18;
    end;

    local function offsetPositionY(p27, p28: number) -- Line: 604
        return UDim2.new(p27.X.Scale, p27.X.Offset, p27.Y.Scale + p28, p27.Y.Offset);
    end;

    local function playSound(p29: string) -- Line: 608
        -- upvalues: u3 (copy)
        u3.Sound(p29);
    end;

    local function toAssetId(p30) -- Line: 612
        if typeof(p30) == "number" then
            return "rbxassetid://" .. tostring(p30);
        end;

        return tostring(p30 or "");
    end;

    local function rewardIcon(p31, p32) -- Line: 620
        -- upvalues: Customization (copy)
        local v33 = p31 and p31.Category and Customization[p31.Category];

        if v33 then
            v33 = v33[p31.Item];
        end;

        return p31 and p31.Icon or v33 and (v33.IconId or v33.Icon) or (p32 or 130432201459489);
    end;

    local function abbreviateNumber(p34: number) -- Line: 641
        for _, v in { { 1000000000, "B" }, { 1000000, "M" }, { 1000, "K" } } do
            if v[1] <= p34 then
                local v35 = math.floor(p34 / v[1] * 10) / 10;

                return string.format("%.1f", v35):gsub("%.0$", "") .. v[2];
            end;
        end;

        local math_floor_ret = math.floor(p34);

        return tostring(math_floor_ret);
    end;

    local function trackTween(p36: userdata) -- Line: 655
        -- upvalues: u19 (copy)
        table.insert(u19, p36);

        return p36;
    end;

    local function trackThread(p37: thread) -- Line: 660
        -- upvalues: u20 (copy)
        table.insert(u20, p37);

        return p37;
    end;

    local function destroyAll(p38) -- Line: 680
        for _, v in p38 do
            if v.Parent then
                v:Destroy();
            end;
        end;

        table.clear(p38);
    end;

    local function removeFrom(p39, p40) -- Line: 690
        local table_find_ret = table.find(p39, p40);

        if table_find_ret then
            table.remove(p39, table_find_ret);
        end;
    end;

    local function startDriftLoop(u41: userdata, u42, u43: number, u44: number, u45: number, u46: function) -- Line: 774
        -- upvalues: TweenService (copy)
        return task.spawn(function() -- Line: 782
            -- upvalues: u46 (copy), u44 (copy), u45 (copy), u43 (copy), u41 (copy), u42 (copy), TweenService (ref)
            local Random_new_ret = Random.new();
            local v47;

            if Random_new_ret:NextInteger(0, 1) == 0 then
                v47 = true;
            else
                v47 = false;
            end;

            while u46() do
                local v48 = Random_new_ret:NextNumber(u44, u45);
                local v49 = Random_new_ret:NextNumber(u43 * 0.5, u43);
                local TweenInfo_new_ret = TweenInfo.new(v48, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
                local v50 = {};
                local v51 = u42;

                if v47 then
                    v49 = -v49 or v49;
                end;

                v50.Position = UDim2.new(v51.X.Scale, v51.X.Offset, v51.Y.Scale + v49, v51.Y.Offset);
                local v52 = TweenService:Create(u41, TweenInfo_new_ret, v50);
                v52:Play();
                v52.Completed:Wait();
                v47 = not v47;
            end;
        end);
    end;

    local function playEntryFlash(p53: number, p54: number, p55) -- Line: 805
        -- upvalues: Frame2 (copy), u6 (copy), TweenService (copy)
        Frame2.BackgroundColor3 = p55 or u6.FLASH_WHITE;
        Frame2.BackgroundTransparency = p54;
        TweenService:Create(Frame2, TweenInfo.new(p53, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            BackgroundTransparency = 1
        }):Play();
    end;

    local function playMainImpact(u56) -- Line: 815
        -- upvalues: u16 (ref), HalloweenEvent (copy), Position (copy)
        task.spawn(function() -- Line: 816
            -- upvalues: u56 (copy), u16 (ref), HalloweenEvent (ref), Position (ref)
            for _, v in u56 do
                if not u16 then
                    break;
                end;

                HalloweenEvent.Position = UDim2.new(Position.X.Scale, Position.X.Offset + math.random(-v, v), Position.Y.Scale, Position.Y.Offset + math.random(-v, v));
                task.wait(0.02);
            end;

            HalloweenEvent.Position = Position;
        end);
    end;

    local function buildJumpScareBars() -- Line: 840
        -- upvalues: Main (copy), u6 (copy), u11 (copy)
        Main.ZIndex = u6.JUMPSCARE_ZINDEX;
        Main.ClipsDescendants = false;

        if #u11 > 0 then
            return;
        end;

        for _, v in {
            {
                anchor = Vector2.new(1, 0.5),
                position = UDim2.fromScale(u6.JUMPSCARE_SEAL, 0.5)
            },
            {
                anchor = Vector2.new(0, 0.5),
                position = UDim2.fromScale(1 - u6.JUMPSCARE_SEAL, 0.5)
            },
            {
                anchor = Vector2.new(0.5, 1),
                position = UDim2.fromScale(0.5, u6.JUMPSCARE_SEAL)
            },
            {
                anchor = Vector2.new(0.5, 0),
                position = UDim2.fromScale(0.5, 1 - u6.JUMPSCARE_SEAL)
            }
        } do
            local Frame3 = Instance.new("Frame");
            Frame3.Name = "Blackout";
            Frame3.BackgroundColor3 = Color3.new(0, 0, 0);
            Frame3.BorderSizePixel = 0;
            Frame3.AnchorPoint = v.anchor;
            Frame3.Position = v.position;
            Frame3.ZIndex = u6.JUMPSCARE_ZINDEX;
            Frame3.Parent = Main;
            table.insert(u11, Frame3);
        end;
    end;

    local function layoutJumpScareBars() -- Line: 870
        -- upvalues: u11 (copy), Main (copy), u10 (copy), u6 (copy)
        if #u11 < 4 then
            return;
        end;

        local AbsoluteSize = Main.AbsoluteSize;
        local AbsoluteSize2 = u10.AbsoluteSize;

        if AbsoluteSize.X < 1 or (AbsoluteSize.Y < 1 or (AbsoluteSize2.X < 1 or AbsoluteSize2.Y < 1)) then
            return;
        end;

        local v57 = math.max(AbsoluteSize2.X / AbsoluteSize.X, AbsoluteSize2.Y / AbsoluteSize.Y) * 3 + u6.JUMPSCARE_BAR_MARGIN;
        local UDim2_fromScale_ret = UDim2.fromScale(v57, v57);

        for _, v in u11 do
            v.Size = UDim2_fromScale_ret;
        end;
    end;

    local function setJumpScareFade(p58: number) -- Line: 890
        -- upvalues: Main (copy), u11 (copy)
        Main.ImageTransparency = p58;

        for _, v in u11 do
            v.BackgroundTransparency = p58;
        end;
    end;

    local function hideJumpScare() -- Line: 898
        -- upvalues: u10 (copy), UIScale (copy), u6 (copy), Main (copy), u11 (copy)
        u10.Visible = false;
        UIScale.Scale = u6.JUMPSCARE_START_SCALE;
        Main.ImageTransparency = 0;

        for _, v in u11 do
            v.BackgroundTransparency = 0;
        end;
    end;

    local function playJumpScare(u59: number) -- Line: 906
        -- upvalues: buildJumpScareBars (copy), u10 (copy), UIScale (copy), u6 (copy), Main (copy), u11 (copy), layoutJumpScareBars (copy), u3 (copy), RunService (copy), u16 (ref), u18 (ref), playEntryFlash (copy), HalloweenEvent (copy), Position (copy)
        buildJumpScareBars();
        local Position7 = u10.Position;
        u10.Visible = true;
        u10.Rotation = 0;
        UIScale.Scale = u6.JUMPSCARE_START_SCALE;
        Main.ImageTransparency = 0;

        for _, v in u11 do
            v.BackgroundTransparency = 0;
        end;

        layoutJumpScareBars();
        u3.Sound("OpenMusic");
        u3.Sound("EvilChime");
        local u60 = u6.JUMPSCARE_START_SCALE * u6.JUMPSCARE_CREEP_GROWTH;
        local u61 = u60 * u6.JUMPSCARE_RECOIL;
        local JUMPSCARE_CREEP_TIME = u6.JUMPSCARE_CREEP_TIME;
        local u62 = JUMPSCARE_CREEP_TIME + u6.JUMPSCARE_RECOIL_TIME;
        local u63 = u62 + u6.JUMPSCARE_TIME;
        local u64 = {};

        for i = 1, u6.JUMPSCARE_HITCHES do
            table.insert(u64, i / (u6.JUMPSCARE_HITCHES + 1));
            local _ = i;
        end;

        local u65 = 1;
        local u66 = 0;
        local u67 = 0;
        local u68 = nil;
        u68 = RunService.RenderStepped:Connect(function(p69) -- Line: 939
            -- upvalues: u67 (ref), JUMPSCARE_CREEP_TIME (copy), u6 (ref), u60 (copy), u62 (copy), u61 (copy), u65 (ref), u64 (copy), u66 (ref), Main (ref), u11 (ref), u10 (ref), Position7 (copy), UIScale (ref), layoutJumpScareBars (ref), u63 (copy), u68 (ref)
            u67 = u67 + p69;
            local v70 = 0;
            local v71;

            if u67 < JUMPSCARE_CREEP_TIME then
                local v72 = u67 / JUMPSCARE_CREEP_TIME;
                v71 = u6.JUMPSCARE_START_SCALE + (u60 - u6.JUMPSCARE_START_SCALE) * v72 * v72;
            elseif u67 < u62 then
                v71 = u60 + (u61 - u60) * ((u67 - JUMPSCARE_CREEP_TIME) / u6.JUMPSCARE_RECOIL_TIME);
            else
                local math_clamp_ret = math.clamp((u67 - u62) / u6.JUMPSCARE_TIME, 0, 1);
                local v73 = u61 + (u6.JUMPSCARE_END_SCALE - u61) * math_clamp_ret * math_clamp_ret * math_clamp_ret * math_clamp_ret * math_clamp_ret;

                if u65 <= #u64 and u64[u65] <= math_clamp_ret then
                    u65 = u65 + 1;
                    u66 = u6.JUMPSCARE_HITCH_FRAMES;
                end;

                if u66 > 0 then
                    u66 = u66 - 1;
                    v73 = v73 * (1 - u6.JUMPSCARE_HITCH_DROP);
                end;

                v70 = math.sin(math_clamp_ret * 3.141592653589793);
                v71 = v73 * (1 + (math.random() - 0.5) * 2 * u6.JUMPSCARE_JUDDER * v70);

                if u6.JUMPSCARE_FADE_AT < math_clamp_ret then
                    local v74 = (math_clamp_ret - u6.JUMPSCARE_FADE_AT) / (1 - u6.JUMPSCARE_FADE_AT);
                    Main.ImageTransparency = v74;

                    for _, v in u11 do
                        v.BackgroundTransparency = v74;
                    end;
                end;
            end;

            u10.Position = Position7 + UDim2.fromOffset(math.random(-u6.JUMPSCARE_SHAKE, u6.JUMPSCARE_SHAKE) * v70, math.random(-u6.JUMPSCARE_SHAKE, u6.JUMPSCARE_SHAKE) * v70);
            u10.Rotation = (math.random() - 0.5) * 2 * u6.JUMPSCARE_TILT * v70;
            UIScale.Scale = v71;
            layoutJumpScareBars();

            if u63 <= u67 then
                u68:Disconnect();
            end;
        end);
        task.delay(JUMPSCARE_CREEP_TIME, function() -- Line: 992
            -- upvalues: u59 (copy), u16 (ref), u18 (ref), playEntryFlash (ref), u6 (ref), HalloweenEvent (ref), Position (ref)
            if u16 and u59 == u18 then
                playEntryFlash(u6.FLASH_TIME * 0.4, u6.FLASH_PEAK * 0.6, u6.FLASH_WHITE);
                local u75 = { 34, 29, 24, 20, 16, 13, 10, 8, 6, 4, 2 };
                task.spawn(function() -- Line: 816
                    -- upvalues: u75 (copy), u16 (ref), HalloweenEvent (ref), Position (ref)
                    for _, v in u75 do
                        if not u16 then
                            break;
                        end;

                        HalloweenEvent.Position = UDim2.new(Position.X.Scale, Position.X.Offset + math.random(-v, v), Position.Y.Scale, Position.Y.Offset + math.random(-v, v));
                        task.wait(0.02);
                    end;

                    HalloweenEvent.Position = Position;
                end);
            end;
        end);
        task.wait(u63);

        if u68.Connected then
            u68:Disconnect();
        end;

        u10.Position = Position7;
        u10.Rotation = 0;
        u10.Visible = false;
        UIScale.Scale = u6.JUMPSCARE_START_SCALE;
        Main.ImageTransparency = 0;

        for _, v in u11 do
            v.BackgroundTransparency = 0;
        end;
    end;

    local function spawnDrifter(u76: any, p77: userdata, p78: userdata, u79: any, p80: number?) -- Line: 1016
        -- upvalues: TweenService (copy)
        local Random_new_ret = Random.new();
        local v81 = p80 or 0;
        local v82 = Random_new_ret:NextInteger(0, 1) == 0;
        local v83 = v82 and u76.StartX or u76.EndX;
        local v84 = v82 and u76.EndX or u76.StartX;
        local v85 = Random_new_ret:NextNumber(u76.MinY, u76.MaxY);
        local v86 = v85 + Random_new_ret:NextNumber(-u76.DriftY, u76.DriftY);
        local u87 = p77:Clone();
        u87.Name = p77.Name .. "Puff";
        u87.Position = UDim2.fromScale(v83 + (v84 - v83) * v81, v85 + (v86 - v85) * v81);
        u87.Rotation = Random_new_ret:NextNumber(0, 360);
        u87.ImageTransparency = 1;
        u87.Visible = true;
        local v88 = u87:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
        v88.Parent = u87;
        v88.Scale = Random_new_ret:NextNumber(u76.MinScale, u76.MaxScale);
        u87.Parent = p78;
        table.insert(u79, u87);
        local v89 = Random_new_ret:NextNumber(u76.MinTime, u76.MaxTime) * (1 - v81);
        local v90 = Random_new_ret:NextNumber(u76.MinTransparency, u76.MaxTransparency);
        TweenService:Create(u87, TweenInfo.new(u76.FadeInTime, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            ImageTransparency = v90
        }):Play();
        TweenService:Create(u87, TweenInfo.new(v89, Enum.EasingStyle.Linear), {
            Rotation = u87.Rotation + Random_new_ret:NextNumber(-u76.Spin, u76.Spin)
        }):Play();
        task.delay(math.max(v89 - u76.FadeOutTime, u76.FadeInTime), function() -- Line: 1050
            -- upvalues: u87 (copy), u76 (copy), TweenService (ref)
            if u87.Parent then
                TweenService:Create(u87, TweenInfo.new(u76.FadeOutTime, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                    ImageTransparency = 1
                }):Play();
            end;
        end);
        local v91 = TweenService:Create(u87, TweenInfo.new(v89, Enum.EasingStyle.Linear), {
            Position = UDim2.fromScale(v84, v86)
        });
        v91:Play();
        v91.Completed:Once(function() -- Line: 1060
            -- upvalues: u79 (copy), u87 (copy)
            local v92 = u79;
            local table_find_ret = table.find(v92, u87);

            if table_find_ret then
                table.remove(v92, table_find_ret);
            end;

            u87:Destroy();
        end);
    end;

    local function playDriftLoop(u93: any, u94: userdata, u95: userdata, u96: any, u97: number) -- Line: 1066
        -- upvalues: spawnDrifter (copy), u16 (ref), u18 (ref), u20 (copy)
        local Random_new_ret = Random.new();

        for i = 1, u93.Prefill do
            spawnDrifter(u93, u94, u95, u96, Random_new_ret:NextNumber(0.1, 0.85));
            local _ = i;
        end;

        local task_spawn_ret = task.spawn(function() -- Line: 1074
            -- upvalues: u97 (copy), u16 (ref), u18 (ref), Random_new_ret (copy), u93 (copy), spawnDrifter (ref), u94 (copy), u95 (copy), u96 (copy)
            while true do
                if not (u16 and u97 == u18) then
                    return;
                end;

                task.wait(Random_new_ret:NextNumber(u93.MinDelay, u93.MaxDelay));

                if u16 and u97 == u18 then
                    spawnDrifter(u93, u94, u95, u96);
                end;
            end;
        end);
        table.insert(u20, task_spawn_ret);
    end;

    local function playLightningLoop(u98: number) -- Line: 1089
        -- upvalues: u6 (copy), u16 (ref), u18 (ref), u3 (copy), Frame (copy), TweenService (copy), u20 (copy)
        local task_spawn_ret = task.spawn(function() -- Line: 1090
            -- upvalues: u6 (ref), u98 (copy), u16 (ref), u18 (ref), u3 (ref), Frame (ref), TweenService (ref)
            local Random_new_ret = Random.new();
            task.wait(u6.LIGHTNING_FIRST_DELAY);

            while true do
                if not (u16 and u98 == u18) then
                    break;
                end;

                u3.Sound("Lightning");
                Frame.BackgroundTransparency = u6.LIGHTNING_PEAK;
                TweenService:Create(Frame, u6.LIGHTNING_STRIKE_INFO, {
                    BackgroundTransparency = 1
                }):Play();
                task.wait(u6.LIGHTNING_GAP);

                if not (u16 and u98 == u18) then
                    break;
                end;

                Frame.BackgroundTransparency = u6.LIGHTNING_ECHO_PEAK;
                TweenService:Create(Frame, u6.LIGHTNING_FADE_INFO, {
                    BackgroundTransparency = 1
                }):Play();
                task.wait(Random_new_ret:NextNumber(u6.LIGHTNING_MIN_INTERVAL, u6.LIGHTNING_MAX_INTERVAL));
            end;
        end);
        table.insert(u20, task_spawn_ret);
    end;

    local function bezier(p99, p100, p101, p102: number) -- Line: 1118
        local v103 = 1 - p102;

        return p99 * v103 * v103 + p100 * 2 * v103 * p102 + p101 * p102 * p102;
    end;

    local function flyBat(u104, u105, p106: number) -- Line: 1124
        -- upvalues: u18 (ref), u16 (ref), u6 (copy), BatTemplate (copy), BatMask (copy), u21 (copy), Size (copy), TweenService (copy)
        local u107 = u18;
        task.delay(p106, function() -- Line: 1126
            -- upvalues: u107 (copy), u16 (ref), u18 (ref), u104 (copy), u105 (copy), u6 (ref), BatTemplate (ref), BatMask (ref), u21 (ref), Size (ref), TweenService (ref)
            if not (u16 and u107 == u18) then
                return;
            end;

            local Random_new_ret = Random.new();
            local Vector2_new_ret = Vector2.new(u104.X + (u105.X - u104.X) * u6.BAT_CURVE_X, u104.Y + (u105.Y - u104.Y) * u6.BAT_CURVE_Y);
            local u108 = Random_new_ret:NextNumber(u6.BAT_START_SCALE_MIN, u6.BAT_START_SCALE_MAX);
            local u109 = u108 * u6.BAT_END_SCALE;
            local u110 = Random_new_ret:NextNumber(0, 6.283185307179586);
            local u111 = Random_new_ret:NextNumber(2, 4);
            local u112 = BatTemplate:Clone();
            u112.Name = "Bat";
            u112.Position = UDim2.fromScale(u104.X, u104.Y);
            u112.Visible = true;
            local u113 = u112:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
            u113.Parent = u112;
            u113.Scale = u108;
            u112.Parent = BatMask;
            table.insert(u21, u112);
            TweenService:Create(u112, TweenInfo.new(Random_new_ret:NextNumber(u6.BAT_FLAP_MIN, u6.BAT_FLAP_MAX), Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
                Size = UDim2.new(Size.X.Scale, Size.X.Offset, Size.Y.Scale * u6.BAT_FLAP_SQUASH, Size.Y.Offset)
            }):Play();
            local NumberValue = Instance.new("NumberValue");
            NumberValue.Value = 0;
            NumberValue.Parent = u112;
            NumberValue.Changed:Connect(function(p114) -- Line: 1166
                -- upvalues: u104 (ref), Vector2_new_ret (copy), u105 (ref), u111 (copy), u110 (copy), u112 (copy), u6 (ref), u113 (copy), u108 (copy), u109 (copy)
                local v115 = 1 - p114;
                local v116 = u104 * v115 * v115 + Vector2_new_ret * 2 * v115 * p114 + u105 * p114 * p114;
                local math_sin_ret = math.sin(p114 * 3.141592653589793 * u111 + u110);
                u112.Position = UDim2.fromScale(v116.X + math_sin_ret * u6.BAT_WAVE, v116.Y + math_sin_ret * u6.BAT_WAVE * 0.5);
                u112.Rotation = math_sin_ret * u6.BAT_TILT;
                u113.Scale = u108 + (u109 - u108) * p114;
            end);
            local v117 = TweenService:Create(NumberValue, TweenInfo.new(Random_new_ret:NextNumber(u6.BAT_MIN_TIME, u6.BAT_MAX_TIME), Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
                Value = 1
            });
            v117:Play();
            v117.Completed:Once(function() -- Line: 1177
                -- upvalues: u21 (ref), u112 (copy)
                local v118 = u21;
                local table_find_ret = table.find(v118, u112);

                if table_find_ret then
                    table.remove(v118, table_find_ret);
                end;

                u112:Destroy();
            end);
        end);
    end;

    local function releaseFlock() -- Line: 1184
        -- upvalues: u6 (copy), u3 (copy), u18 (ref), u16 (ref), BatTemplate (copy), BatMask (copy), u21 (copy), Size (copy), TweenService (copy)
        local Random_new_ret = Random.new();
        local v119 = Random_new_ret:NextInteger(u6.BAT_MIN_COUNT, u6.BAT_MAX_COUNT);
        u3.Sound("Bats");
        local v120 = Random_new_ret:NextNumber(u6.BAT_END_X_MIN, u6.BAT_END_X_MAX);

        for i = 1, v119 do
            local Vector2_new_ret = Vector2.new(u6.BAT_START_X + Random_new_ret:NextNumber(-u6.BAT_SPREAD, u6.BAT_SPREAD), u6.BAT_START_Y + Random_new_ret:NextNumber(-u6.BAT_SPREAD, u6.BAT_SPREAD) * 0.5);
            local Vector2_new_ret2 = Vector2.new(v120 + Random_new_ret:NextNumber(-u6.BAT_SPREAD, u6.BAT_SPREAD) * 1.5, u6.BAT_END_Y + Random_new_ret:NextNumber(-u6.BAT_SPREAD, u6.BAT_SPREAD) * 0.5);
            local v121 = (i - 1) * u6.BAT_STAGGER + Random_new_ret:NextNumber(0, u6.BAT_STAGGER);
            local u122 = u18;
            task.delay(v121, function() -- Line: 1126
                -- upvalues: u122 (copy), u16 (ref), u18 (ref), Vector2_new_ret (copy), Vector2_new_ret2 (copy), u6 (ref), BatTemplate (ref), BatMask (ref), u21 (ref), Size (ref), TweenService (ref)
                if not (u16 and u122 == u18) then
                    return;
                end;

                local Random_new_ret2 = Random.new();
                local Vector2_new_ret3 = Vector2.new(Vector2_new_ret.X + (Vector2_new_ret2.X - Vector2_new_ret.X) * u6.BAT_CURVE_X, Vector2_new_ret.Y + (Vector2_new_ret2.Y - Vector2_new_ret.Y) * u6.BAT_CURVE_Y);
                local u123 = Random_new_ret2:NextNumber(u6.BAT_START_SCALE_MIN, u6.BAT_START_SCALE_MAX);
                local u124 = u123 * u6.BAT_END_SCALE;
                local u125 = Random_new_ret2:NextNumber(0, 6.283185307179586);
                local u126 = Random_new_ret2:NextNumber(2, 4);
                local u127 = BatTemplate:Clone();
                u127.Name = "Bat";
                u127.Position = UDim2.fromScale(Vector2_new_ret.X, Vector2_new_ret.Y);
                u127.Visible = true;
                local u128 = u127:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
                u128.Parent = u127;
                u128.Scale = u123;
                u127.Parent = BatMask;
                table.insert(u21, u127);
                TweenService:Create(u127, TweenInfo.new(Random_new_ret2:NextNumber(u6.BAT_FLAP_MIN, u6.BAT_FLAP_MAX), Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
                    Size = UDim2.new(Size.X.Scale, Size.X.Offset, Size.Y.Scale * u6.BAT_FLAP_SQUASH, Size.Y.Offset)
                }):Play();
                local NumberValue = Instance.new("NumberValue");
                NumberValue.Value = 0;
                NumberValue.Parent = u127;
                NumberValue.Changed:Connect(function(p129) -- Line: 1166
                    -- upvalues: Vector2_new_ret (ref), Vector2_new_ret3 (copy), Vector2_new_ret2 (ref), u126 (copy), u125 (copy), u127 (copy), u6 (ref), u128 (copy), u123 (copy), u124 (copy)
                    local v130 = 1 - p129;
                    local v131 = Vector2_new_ret * v130 * v130 + Vector2_new_ret3 * 2 * v130 * p129 + Vector2_new_ret2 * p129 * p129;
                    local math_sin_ret = math.sin(p129 * 3.141592653589793 * u126 + u125);
                    u127.Position = UDim2.fromScale(v131.X + math_sin_ret * u6.BAT_WAVE, v131.Y + math_sin_ret * u6.BAT_WAVE * 0.5);
                    u127.Rotation = math_sin_ret * u6.BAT_TILT;
                    u128.Scale = u123 + (u124 - u123) * p129;
                end);
                local v132 = TweenService:Create(NumberValue, TweenInfo.new(Random_new_ret2:NextNumber(u6.BAT_MIN_TIME, u6.BAT_MAX_TIME), Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
                    Value = 1
                });
                v132:Play();
                v132.Completed:Once(function() -- Line: 1177
                    -- upvalues: u21 (ref), u127 (copy)
                    local v133 = u21;
                    local table_find_ret = table.find(v133, u127);

                    if table_find_ret then
                        table.remove(v133, table_find_ret);
                    end;

                    u127:Destroy();
                end);
            end);
            local _ = i;
        end;
    end;

    local function playBatLoop(u134: number) -- Line: 1207
        -- upvalues: u6 (copy), u16 (ref), u18 (ref), releaseFlock (copy), u20 (copy)
        local Random_new_ret = Random.new();
        local task_spawn_ret = task.spawn(function() -- Line: 1210
            -- upvalues: u6 (ref), u134 (copy), u16 (ref), u18 (ref), releaseFlock (ref), Random_new_ret (copy)
            task.wait(u6.BAT_FIRST_DELAY);

            while true do
                if not (u16 and u134 == u18) then
                    return;
                end;

                releaseFlock();
                task.wait(Random_new_ret:NextNumber(u6.BAT_MIN_INTERVAL, u6.BAT_MAX_INTERVAL));
            end;
        end);
        table.insert(u20, task_spawn_ret);
    end;

    local function setLineGradientReveal(p135: userdata, p136: number) -- Line: 1223
        -- upvalues: u6 (copy)
        local math_clamp_ret = math.clamp(p136, 0, 1);

        if math_clamp_ret <= 0 then
            p135.Transparency = NumberSequence.new(1);

            return;
        end;

        if math_clamp_ret >= 1 then
            p135.Transparency = NumberSequence.new(0);

            return;
        end;

        local math_clamp_ret2 = math.clamp(math_clamp_ret - u6.LINE_DRAW_SOFTNESS, 0, 1);
        local math_clamp_ret3 = math.clamp(math_clamp_ret + u6.LINE_DRAW_SOFTNESS, 0, 1);
        p135.Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0),
            NumberSequenceKeypoint.new(math_clamp_ret2, 0),
            NumberSequenceKeypoint.new(math_clamp_ret, 0.35),
            NumberSequenceKeypoint.new(math_clamp_ret3, 1),
            NumberSequenceKeypoint.new(1, 1)
        });
    end;

    local function animateLineDraw(p137: userdata, p138: number, p139: number?, p140: number?) -- Line: 1248
        -- upvalues: u6 (copy), setLineGradientReveal (copy), u16 (ref), u18 (ref), RunService (copy), TweenService (copy)
        local v141 = p139 or 0;
        local v142 = p140 or u6.LINE_DRAW_TIME;
        setLineGradientReveal(p137, v141);
        local v143 = 0;

        while v143 < v142 do
            if not (u16 and p138 == u18) then
                return;
            end;

            v143 = v143 + RunService.RenderStepped:Wait();
            local Value = TweenService:GetValue(math.clamp(v143 / v142, 0, 1), u6.LINE_DRAW_EASING_STYLE, u6.LINE_DRAW_EASING_DIRECTION);
            setLineGradientReveal(p137, v141 + (1 - v141) * Value);
        end;

        if u16 and p138 == u18 then
            setLineGradientReveal(p137, 1);
        end;
    end;

    local u144 = {
        {
            Line = VertLine,
            Gradient = UIGradient,
            Spider = TitleFrame:FindFirstChild("VertSpider")
        },
        {
            Line = HorizontalLine,
            Gradient = UIGradient2,
            Spider = TitleFrame:FindFirstChild("HorizontalSpider")
        }
    };
    local u145 = {};
    local u146 = {};
    local u147 = nil;
    local u148 = {};
    local u149 = {};

    local function createScaleChannels(p150: userdata) -- Line: 750
        local u151 = p150:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
        u151.Parent = p150;
        local NumberValue = Instance.new("NumberValue");
        NumberValue.Name = "RevealScale";
        NumberValue.Value = 1;
        NumberValue.Parent = p150;
        local NumberValue2 = Instance.new("NumberValue");
        NumberValue2.Name = "InteractScale";
        NumberValue2.Value = 1;
        NumberValue2.Parent = p150;

        local function update() -- Line: 763
            -- upvalues: u151 (copy), NumberValue (copy), NumberValue2 (copy)
            u151.Scale = NumberValue.Value * NumberValue2.Value;
        end;

        NumberValue.Changed:Connect(update);
        NumberValue2.Changed:Connect(update);
        u151.Scale = NumberValue.Value * NumberValue2.Value;

        return {
            Reveal = NumberValue,
            Interact = NumberValue2
        };
    end;

    local function formatNumber(p152: number) -- Line: 626
        local math_floor_ret = math.floor(p152);
        local v153 = tostring(math_floor_ret);
        local v154;

        repeat
            v153, v154 = string.gsub(v153, "^(-?%d+)(%d%d%d)", "%1,%2");
        until v154 == 0;

        return v153;
    end;

    local u155 = 0;
    local u156 = {};
    local u157 = {};

    local function setupButton(p158: userdata, u159: any, u160: function?) -- Line: 698
        -- upvalues: u3 (copy), u6 (copy), TweenService (copy)
        local u161 = p158:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
        u161.Parent = p158;
        local u162 = false;
        u161.Scale = 1;
        p158.MouseEnter:Connect(function() -- Line: 704
            -- upvalues: u160 (copy), u162 (ref), u3 (ref), u161 (copy), u6 (ref), TweenService (ref)
            if u160 and not u160() then
                return;
            end;

            u162 = true;
            u3.Sound("UIHover");
            TweenService:Create(u161, u6.BUTTON_HOVER_INFO, {
                Scale = u6.BUTTON_HOVER_SCALE
            }):Play();
        end);
        p158.MouseLeave:Connect(function() -- Line: 714
            -- upvalues: u162 (ref), u160 (copy), u161 (copy), u6 (ref), TweenService (ref)
            u162 = false;

            if u160 and not u160() then
                return;
            end;

            TweenService:Create(u161, u6.BUTTON_LEAVE_INFO, {
                Scale = 1
            }):Play();
        end);
        p158.MouseButton1Down:Connect(function() -- Line: 723
            -- upvalues: u160 (copy), u161 (copy), u6 (ref), TweenService (ref)
            if u160 and not u160() then
                return;
            end;

            TweenService:Create(u161, u6.BUTTON_PRESS_INFO, {
                Scale = u6.BUTTON_PRESS_SCALE
            }):Play();
        end);
        p158.MouseButton1Up:Connect(function() -- Line: 731
            -- upvalues: u160 (copy), u161 (copy), u6 (ref), u162 (ref), TweenService (ref)
            if u160 and not u160() then
                return;
            end;

            TweenService:Create(u161, u6.BUTTON_RELEASE_INFO, {
                Scale = u162 and u6.BUTTON_HOVER_SCALE or 1
            }):Play();
        end);
        p158.Activated:Connect(function() -- Line: 739
            -- upvalues: u160 (copy), u3 (ref), u159 (copy)
            if u160 and not u160() then
                return;
            end;

            u3.Sound("UIClick");
            u159();
        end);
    end;

    local u163 = {};

    local function getScale(p164) -- Line: 594
        local v165 = p164:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
        v165.Parent = p164;

        return v165;
    end;

    local function stopLoops() -- Line: 665
        -- upvalues: u19 (copy), u20 (copy)
        for _, v in u19 do
            v:Cancel();
        end;

        for _, v in u20 do
            if coroutine.status(v) ~= "dead" then
                task.cancel(v);
            end;
        end;

        table.clear(u19);
        table.clear(u20);
    end;

    for _, v in u144 do
        if v.Spider then
            v.RestPosition = v.Spider.Position;
            v.RestRotation = v.Spider.Rotation;
        end;
    end;

    local function rotateVector(p166, p167: number) -- Line: 1287
        local math_rad_ret = math.rad(p167);
        local math_cos_ret = math.cos(math_rad_ret);
        local math_sin_ret = math.sin(math_rad_ret);

        return Vector2.new(p166.X * math_cos_ret - p166.Y * math_sin_ret, p166.X * math_sin_ret + p166.Y * math_cos_ret);
    end;

    local function toPixels(p168, p169) -- Line: 1294
        return Vector2.new(p168.X.Scale * p169.X + p168.X.Offset, p168.Y.Scale * p169.Y + p168.Y.Offset);
    end;

    local function getLineAxis(p170: userdata, p171: userdata, p172) -- Line: 1304
        local Size2 = p170.Size;
        local Vector2_new_ret = Vector2.new(Size2.X.Scale * p172.X + Size2.X.Offset, Size2.Y.Scale * p172.Y + Size2.Y.Offset);
        local Position7 = p170.Position;
        local v173 = Vector2.new(Position7.X.Scale * p172.X + Position7.X.Offset, Position7.Y.Scale * p172.Y + Position7.Y.Offset) + (Vector2.new(0.5, 0.5) - p170.AnchorPoint) * Vector2_new_ret;
        local math_rad_ret = math.rad(p171.Rotation);
        local Vector2_new_ret2 = Vector2.new(math.cos(math_rad_ret), (math.sin(math_rad_ret)));
        local v174 = math.abs(Vector2_new_ret2.X) * Vector2_new_ret.X * 0.5 + math.abs(Vector2_new_ret2.Y) * Vector2_new_ret.Y * 0.5;
        local math_rad_ret2 = math.rad(p170.Rotation);
        local math_cos_ret = math.cos(math_rad_ret2);
        local math_sin_ret = math.sin(math_rad_ret2);
        local Vector2_new_ret3 = Vector2.new(Vector2_new_ret2.X * math_cos_ret - Vector2_new_ret2.Y * math_sin_ret, Vector2_new_ret2.X * math_sin_ret + Vector2_new_ret2.Y * math_cos_ret);

        return v173 - Vector2_new_ret3 * v174, Vector2_new_ret3, v174 * 2;
    end;

    local function getTitleFrameSize() -- Line: 1317
        -- upvalues: TitleFrame (copy), u1 (copy)
        local AbsoluteSize = TitleFrame.AbsoluteSize;

        if AbsoluteSize.X < 1 or AbsoluteSize.Y < 1 then
            AbsoluteSize = u1.AbsoluteSize;
        end;

        return AbsoluteSize;
    end;

    local function resetSpider(p175) -- Line: 1327
        local Spider = p175.Spider;

        if not Spider then
            return;
        end;

        Spider.Visible = false;
        Spider.Position = p175.RestPosition;
        Spider.Rotation = p175.RestRotation;
        local v176 = Spider:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
        v176.Parent = Spider;
        v176.Scale = 1;
    end;

    local function startSpiderChill(u177: any, u178: number) -- Line: 1341
        -- upvalues: u16 (ref), u18 (ref), u6 (copy), TweenService (copy), u20 (copy)
        local Spider = u177.Spider;
        local task_spawn_ret = task.spawn(function() -- Line: 1344
            -- upvalues: u178 (copy), u16 (ref), u18 (ref), u6 (ref), Spider (copy), u177 (copy), TweenService (ref)
            local Random_new_ret = Random.new();

            while true do
                if not (u16 and u178 == u18) then
                    return;
                end;

                task.wait(Random_new_ret:NextNumber(u6.SPIDER_TWITCH_MIN_DELAY, u6.SPIDER_TWITCH_MAX_DELAY));

                if not (u16 and u178 == u18) then
                    return;
                end;

                local v179 = Random_new_ret:NextNumber(-u6.SPIDER_TWITCH_ROTATION, u6.SPIDER_TWITCH_ROTATION);
                local v180 = TweenService:Create(Spider, u6.SPIDER_TWITCH_INFO, {
                    Rotation = u177.RestRotation + v179
                });
                v180:Play();
                v180.Completed:Wait();
                TweenService:Create(Spider, u6.SPIDER_SETTLE_INFO, {
                    Rotation = u177.RestRotation
                }):Play();
            end;
        end);
        table.insert(u20, task_spawn_ret);
    end;

    local function animateSpiderLine(u181: any, u182: number) -- Line: 1364
        -- upvalues: animateLineDraw (copy), TitleFrame (copy), u1 (copy), getLineAxis (copy), setLineGradientReveal (copy), u6 (copy), u16 (ref), u18 (ref), RunService (copy), TweenService (copy), u20 (copy)
        local Spider = u181.Spider;

        if not Spider then
            animateLineDraw(u181.Gradient, u182);

            return;
        end;

        local AbsoluteSize = TitleFrame.AbsoluteSize;

        if AbsoluteSize.X < 1 or AbsoluteSize.Y < 1 then
            AbsoluteSize = u1.AbsoluteSize;
        end;

        local v183, u184, u185 = getLineAxis(u181.Line, u181.Gradient, AbsoluteSize);
        local RestPosition = u181.RestPosition;
        local v186 = (Vector2.new(RestPosition.X.Scale * AbsoluteSize.X + RestPosition.X.Offset, RestPosition.Y.Scale * AbsoluteSize.Y + RestPosition.Y.Offset) - v183):Dot(u184) / u185;
        local math_clamp_ret = math.clamp(v186, 0, 1);
        local Vector2_new_ret = Vector2.new(-u184.Y, u184.X);

        local function placeSpider(p187: number, p188: number) -- Line: 1379
            -- upvalues: u184 (copy), u185 (copy), math_clamp_ret (copy), Vector2_new_ret (copy), Spider (copy), u181 (copy), AbsoluteSize (copy)
            local v189 = u184 * u185 * (p187 - math_clamp_ret) + Vector2_new_ret * p188;
            Spider.Position = u181.RestPosition + UDim2.fromScale(v189.X / AbsoluteSize.X, v189.Y / AbsoluteSize.Y);
        end;

        local v190 = u184 * u185 * (0 - math_clamp_ret) + Vector2_new_ret * 0;
        Spider.Position = u181.RestPosition + UDim2.fromScale(v190.X / AbsoluteSize.X, v190.Y / AbsoluteSize.Y);
        Spider.Visible = true;
        setLineGradientReveal(u181.Gradient, 0);
        local v191 = 0;

        while v191 < u6.SPIDER_CRAWL_TIME do
            if not (u16 and u182 == u18) then
                return;
            end;

            v191 = v191 + RunService.RenderStepped:Wait();
            local math_clamp_ret2 = math.clamp(v191 / u6.SPIDER_CRAWL_TIME, 0, 1);
            local v192 = math_clamp_ret * TweenService:GetValue(math_clamp_ret2, u6.SPIDER_CRAWL_STYLE, u6.SPIDER_CRAWL_DIRECTION);
            local v193 = 1 - math_clamp_ret2;
            local v194 = math.sin(v191 * u6.SPIDER_WIGGLE_SPEED) * u6.SPIDER_WIGGLE_PIXELS * v193;
            local v195 = u184 * u185 * (v192 - math_clamp_ret) + Vector2_new_ret * v194;
            Spider.Position = u181.RestPosition + UDim2.fromScale(v195.X / AbsoluteSize.X, v195.Y / AbsoluteSize.Y);
            Spider.Rotation = u181.RestRotation + math.sin(v191 * u6.SPIDER_WALK_SPEED) * u6.SPIDER_WALK_ROTATION * v193;
            setLineGradientReveal(u181.Gradient, v192);
        end;

        if not (u16 and u182 == u18) then
            return;
        end;

        Spider.Position = u181.RestPosition;
        Spider.Rotation = u181.RestRotation;
        local v196 = Spider:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
        v196.Parent = Spider;
        v196.Scale = u6.SPIDER_LAND_SCALE;
        TweenService:Create(v196, u6.SPIDER_LAND_INFO, {
            Scale = 1
        }):Play();
        local Spider2 = u181.Spider;
        local task_spawn_ret = task.spawn(function() -- Line: 1344
            -- upvalues: u182 (copy), u16 (ref), u18 (ref), u6 (ref), Spider2 (copy), u181 (copy), TweenService (ref)
            local Random_new_ret = Random.new();

            while true do
                if not (u16 and u182 == u18) then
                    return;
                end;

                task.wait(Random_new_ret:NextNumber(u6.SPIDER_TWITCH_MIN_DELAY, u6.SPIDER_TWITCH_MAX_DELAY));

                if not (u16 and u182 == u18) then
                    return;
                end;

                local v197 = Random_new_ret:NextNumber(-u6.SPIDER_TWITCH_ROTATION, u6.SPIDER_TWITCH_ROTATION);
                local v198 = TweenService:Create(Spider2, u6.SPIDER_TWITCH_INFO, {
                    Rotation = u181.RestRotation + v197
                });
                v198:Play();
                v198.Completed:Wait();
                TweenService:Create(Spider2, u6.SPIDER_SETTLE_INFO, {
                    Rotation = u181.RestRotation
                }):Play();
            end;
        end);
        table.insert(u20, task_spawn_ret);
        animateLineDraw(u181.Gradient, u182, math_clamp_ret, u6.SPIDER_LINE_FINISH_TIME);
    end;

    local function animateLineErase(p199: userdata, p200: number) -- Line: 1425
        -- upvalues: u6 (copy), u18 (ref), RunService (copy), setLineGradientReveal (copy), TweenService (copy)
        local v201 = 0;

        while v201 < u6.LINE_ERASE_TIME do
            if p200 ~= u18 then
                return;
            end;

            v201 = v201 + RunService.RenderStepped:Wait();
            setLineGradientReveal(p199, 1 - TweenService:GetValue(math.clamp(v201 / u6.LINE_ERASE_TIME, 0, 1), Enum.EasingStyle.Quad, Enum.EasingDirection.In));
        end;

        if p200 == u18 then
            setLineGradientReveal(p199, 0);
        end;
    end;

    local function spawnCarouselText(p202: number?) -- Line: 1445
        -- upvalues: TextLabelTemplate (copy), u6 (copy), SideTextMask (copy), u145 (copy), TweenService (copy)
        local v203 = p202 or 0;
        local u204 = TextLabelTemplate:Clone();
        u204.Visible = true;
        local v205 = u6.CAROUSEL_FINISH_X - u6.CAROUSEL_START_X;
        u204.Position = UDim2.new(u6.CAROUSEL_START_X + v205 * v203, TextLabelTemplate.Position.X.Offset, TextLabelTemplate.Position.Y.Scale, TextLabelTemplate.Position.Y.Offset);
        u204.Parent = SideTextMask;
        table.insert(u145, u204);
        local v206 = TweenService:Create(u204, TweenInfo.new(v205 * (1 - v203) / u6.CAROUSEL_SPEED, Enum.EasingStyle.Linear), {
            Position = UDim2.new(u6.CAROUSEL_FINISH_X, TextLabelTemplate.Position.X.Offset, TextLabelTemplate.Position.Y.Scale, TextLabelTemplate.Position.Y.Offset)
        });
        v206:Play();
        v206.Completed:Once(function() -- Line: 1462
            -- upvalues: u145 (ref), u204 (copy)
            local v207 = u145;
            local table_find_ret = table.find(v207, u204);

            if table_find_ret then
                table.remove(v207, table_find_ret);
            end;

            u204:Destroy();
        end);
    end;

    local function playCarouselLoop(u208: number) -- Line: 1468
        -- upvalues: u6 (copy), spawnCarouselText (copy), u16 (ref), u18 (ref), u20 (copy)
        local v209 = u6.CAROUSEL_FINISH_X - u6.CAROUSEL_START_X;

        for i = 0, math.floor(v209 / u6.CAROUSEL_SPACING) do
            spawnCarouselText(i * u6.CAROUSEL_SPACING / v209);
            local _ = i;
        end;

        local task_spawn_ret = task.spawn(function() -- Line: 1475
            -- upvalues: u208 (copy), u16 (ref), u18 (ref), u6 (ref), spawnCarouselText (ref)
            while true do
                if not (u16 and u208 == u18) then
                    return;
                end;

                task.wait(u6.CAROUSEL_SPACING / u6.CAROUSEL_SPEED);

                if u16 and u208 == u18 then
                    spawnCarouselText(0);
                end;
            end;
        end);
        table.insert(u20, task_spawn_ret);
    end;

    local u210 = {};

    for _, child in SubtitleFrame:GetChildren() do
        if child:IsA("TextLabel") then
            table.insert(u210, {
                Instance = child,
                Transparency = child.TextTransparency
            });
        end;
    end;

    local function resetTitle() -- Line: 1495
        -- upvalues: TextFrame (copy), Position2 (copy), u6 (copy), Tag (copy), TitleFrame2 (copy), u210 (copy), setLineGradientReveal (copy), UIGradient (copy), UIGradient2 (copy), u144 (copy)
        local v211 = Position2;
        TextFrame.Position = UDim2.new(v211.X.Scale, v211.X.Offset, v211.Y.Scale + u6.TEXT_FRAME_START_Y_OFFSET, v211.Y.Offset);
        local v212 = Tag;
        local v213 = v212:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
        v213.Parent = v212;
        v213.Scale = 0;
        local v214 = TitleFrame2;
        local v215 = v214:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
        v215.Parent = v214;
        v215.Scale = 0;

        for _, v in u210 do
            v.Instance.TextTransparency = 1;
        end;

        setLineGradientReveal(UIGradient, 0);
        setLineGradientReveal(UIGradient2, 0);

        for _, v in u144 do
            local Spider = v.Spider;

            if Spider then
                Spider.Visible = false;
                Spider.Position = v.RestPosition;
                Spider.Rotation = v.RestRotation;
                local v216 = Spider:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
                v216.Parent = Spider;
                v216.Scale = 1;
            end;
        end;
    end;

    local function playTitleReveal(u217: number) -- Line: 1513
        -- upvalues: TextFrame (copy), u6 (copy), Position2 (copy), TweenService (copy), u16 (ref), u18 (ref), Tag (copy), TitleFrame2 (copy), u210 (copy), u144 (copy), animateSpiderLine (copy), playCarouselLoop (copy)
        TweenService:Create(TextFrame, TweenInfo.new(u6.TEXT_FRAME_INTRO_TIME, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Position = Position2
        }):Play();
        task.delay(0.08, function() -- Line: 1518
            -- upvalues: u217 (copy), u16 (ref), u18 (ref), Tag (ref), u6 (ref), TweenService (ref)
            if u16 and u217 == u18 then
                local v218 = Tag;
                local v219 = v218:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
                v219.Parent = v218;
                TweenService:Create(v219, u6.TITLE_POP_INFO, {
                    Scale = 1
                }):Play();
            end;
        end);
        task.delay(0.16, function() -- Line: 1524
            -- upvalues: u217 (copy), u16 (ref), u18 (ref), TitleFrame2 (ref), u6 (ref), TweenService (ref)
            if u16 and u217 == u18 then
                local v220 = TitleFrame2;
                local v221 = v220:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
                v221.Parent = v220;
                TweenService:Create(v221, u6.TITLE_POP_INFO, {
                    Scale = 1
                }):Play();
            end;
        end);
        task.delay(0.28, function() -- Line: 1530
            -- upvalues: u217 (copy), u16 (ref), u18 (ref), u210 (ref), u6 (ref), TweenService (ref)
            if not (u16 and u217 == u18) then
                return;
            end;

            for _, v in u210 do
                TweenService:Create(v.Instance, u6.FADE_INFO, {
                    TextTransparency = v.Transparency
                }):Play();
            end;
        end);
        task.delay(u6.LINE_DRAW_START_DELAY, function() -- Line: 1540
            -- upvalues: u217 (copy), u16 (ref), u18 (ref), u144 (ref), u6 (ref), animateSpiderLine (ref)
            if not (u16 and u217 == u18) then
                return;
            end;

            for i, v in u144 do
                task.delay((i - 1) * u6.SPIDER_STAGGER, function() -- Line: 1546
                    -- upvalues: u217 (ref), u16 (ref), u18 (ref), animateSpiderLine (ref), v (copy)
                    if u16 and u217 == u18 then
                        animateSpiderLine(v, u217);
                    end;
                end);
            end;
        end);
        playCarouselLoop(u217);
    end;

    local function cacheParticle(p222: userdata) -- Line: 1560
        -- upvalues: u148 (copy), u156 (copy)
        if not u148[p222] then
            u148[p222] = p222.Position;
            u156[p222] = p222.Rotation;
        end;
    end;

    local function resetParticles() -- Line: 1567
        -- upvalues: u148 (copy), u156 (copy)
        for i, v in u148 do
            if i.Parent then
                i.Position = v;
                i.Rotation = u156[i];
            end;
        end;
    end;

    local function startParticleFloat(p223: userdata, u224: number) -- Line: 1576
        -- upvalues: u148 (copy), u156 (copy), u16 (ref), u18 (ref), u6 (copy), TweenService (copy), u19 (copy), u20 (copy)
        for _, child in p223:GetChildren() do
            if child:IsA("ImageLabel") and child.Name == "Particles" then
                if not u148[child] then
                    u148[child] = child.Position;
                    u156[child] = child.Rotation;
                end;

                local u225 = u148[child];
                local u226 = u156[child];
                local u227 = child:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
                u227.Parent = child;
                local Scale = u227.Scale;
                local task_spawn_ret = task.spawn(function() -- Line: 1586
                    -- upvalues: u224 (copy), u16 (ref), u18 (ref), child (copy), u6 (ref), u225 (copy), u226 (copy), TweenService (ref), u19 (ref), u227 (copy), Scale (copy)
                    local Random_new_ret = Random.new();
                    local v228 = Random_new_ret:NextInteger(0, 1) == 0;
                    task.wait(Random_new_ret:NextNumber(0, 1.2));

                    while true do
                        if not (u16 and u224 == u18 and child.Parent) then
                            return;
                        end;

                        local TweenInfo_new_ret = TweenInfo.new(Random_new_ret:NextNumber(u6.PARTICLE_MIN_TIME, u6.PARTICLE_MAX_TIME), Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
                        local v229 = Random_new_ret:NextInteger(u6.PARTICLE_MIN_RISE, u6.PARTICLE_MAX_RISE);
                        local v230 = {};
                        local UDim2_fromOffset = UDim2.fromOffset;
                        local v231 = Random_new_ret:NextInteger(-u6.PARTICLE_DRIFT, u6.PARTICLE_DRIFT);

                        if v228 then
                            v229 = -v229 or v229;
                        end;

                        v230.Position = u225 + UDim2_fromOffset(v231, v229);
                        v230.Rotation = u226 + Random_new_ret:NextNumber(-u6.PARTICLE_ROTATION, u6.PARTICLE_ROTATION);
                        local v232 = TweenService:Create(child, TweenInfo_new_ret, v230);
                        v232:Play();
                        table.insert(u19, v232);
                        local v233 = TweenService:Create(u227, TweenInfo_new_ret, {
                            Scale = Scale * (1 + Random_new_ret:NextNumber(-u6.PARTICLE_SCALE, u6.PARTICLE_SCALE))
                        });
                        v233:Play();
                        table.insert(u19, v233);
                        v232.Completed:Wait();
                        v228 = not v228;
                    end;
                end);
                table.insert(u20, task_spawn_ret);
            end;
        end;
    end;

    local function playCharacterJolt(u234: number) -- Line: 1613
        -- upvalues: Character (copy), u6 (copy), TweenService (copy), Position4 (copy), u16 (ref), u18 (ref), u20 (copy), startParticleFloat (copy), Eyeglow (copy), u19 (copy)
        local v235 = Character;
        local v236 = v235:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
        v236.Parent = v235;
        v236.Scale = u6.CHARACTER_JOLT_SCALE;
        TweenService:Create(v236, u6.CHARACTER_SETTLE_INFO, {
            Scale = 1
        }):Play();
        local u237 = Character;
        local u238 = Position4;
        local CHARACTER_DRIFT = u6.CHARACTER_DRIFT;
        local CHARACTER_DRIFT_MIN_TIME = u6.CHARACTER_DRIFT_MIN_TIME;
        local CHARACTER_DRIFT_MAX_TIME = u6.CHARACTER_DRIFT_MAX_TIME;

        local function u239() -- Line: 1619
            -- upvalues: u234 (copy), u16 (ref), u18 (ref)
            return u16 and u234 == u18;
        end;

        local task_spawn_ret = task.spawn(function() -- Line: 782
            -- upvalues: u239 (copy), CHARACTER_DRIFT_MIN_TIME (copy), CHARACTER_DRIFT_MAX_TIME (copy), CHARACTER_DRIFT (copy), u237 (copy), u238 (copy), TweenService (ref)
            local Random_new_ret = Random.new();
            local v240;

            if Random_new_ret:NextInteger(0, 1) == 0 then
                v240 = true;
            else
                v240 = false;
            end;

            while u239() do
                local v241 = Random_new_ret:NextNumber(CHARACTER_DRIFT_MIN_TIME, CHARACTER_DRIFT_MAX_TIME);
                local v242 = Random_new_ret:NextNumber(CHARACTER_DRIFT * 0.5, CHARACTER_DRIFT);
                local TweenInfo_new_ret = TweenInfo.new(v241, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
                local v243 = {};
                local v244 = u238;

                if v240 then
                    v242 = -v242 or v242;
                end;

                v243.Position = UDim2.new(v244.X.Scale, v244.X.Offset, v244.Y.Scale + v242, v244.Y.Offset);
                local v245 = TweenService:Create(u237, TweenInfo_new_ret, v243);
                v245:Play();
                v245.Completed:Wait();
                v240 = not v240;
            end;
        end);
        table.insert(u20, task_spawn_ret);
        startParticleFloat(Character, u234);

        if Eyeglow then
            task.delay(u6.EYE_GLOW_DELAY, function() -- Line: 1626
                -- upvalues: u234 (copy), u16 (ref), u18 (ref), Eyeglow (ref), u6 (ref), TweenService (ref), u19 (ref)
                if u16 and u234 == u18 then
                    Eyeglow.Transparency = 1;
                    local v246 = TweenService:Create(Eyeglow, u6.EYE_GLOW_PULSE_INFO, {
                        Transparency = u6.EYE_GLOW_TRANSPARENCY
                    });
                    v246:Play();
                    table.insert(u19, v246);
                end;
            end);
        end;
    end;

    local function setCandyText(p247: number) -- Line: 1635
        -- upvalues: AmountLabel (copy), formatNumber (copy)
        AmountLabel.Text = formatNumber(p247);
    end;

    local function playCandyReveal(u248: number) -- Line: 1639
        -- upvalues: CandyFrame (copy), u6 (copy), Position3 (copy), TweenService (copy), Icon (copy), u16 (ref), u18 (ref), u147 (ref), u155 (ref), RunService (copy), AmountLabel (copy), formatNumber (copy)
        TweenService:Create(CandyFrame, u6.CANDY_INTRO_INFO, {
            Position = Position3
        }):Play();
        local v249 = Icon;
        local u250 = v249:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
        u250.Parent = v249;
        u250.Scale = 0;
        Icon.Rotation = -30;
        task.delay(0.12, function() -- Line: 1646
            -- upvalues: u248 (copy), u16 (ref), u18 (ref), u250 (copy), u6 (ref), TweenService (ref), Icon (ref), u147 (ref), u155 (ref), RunService (ref), AmountLabel (ref), formatNumber (ref)
            if not (u16 and u248 == u18) then
                return;
            end;

            TweenService:Create(u250, u6.ENTRY_ICON_INFO, {
                Scale = 1
            }):Play();
            TweenService:Create(Icon, u6.ENTRY_ICON_INFO, {
                Rotation = 0
            }):Play();

            if not u147 then
                return;
            end;

            local v251 = u147;
            local v252 = u155;
            local v253 = 0;

            while v253 < u6.CANDY_COUNT_TIME do
                if not (u16 and u248 == u18) or u147 ~= v251 then
                    return;
                end;

                v253 = v253 + RunService.RenderStepped:Wait();

                if not (u16 and u248 == u18) or u155 ~= v252 then
                    return;
                end;

                AmountLabel.Text = formatNumber(v251 * TweenService:GetValue(math.clamp(v253 / u6.CANDY_COUNT_TIME, 0, 1), Enum.EasingStyle.Quart, Enum.EasingDirection.Out));
            end;

            if u16 and u248 == u18 and u155 == v252 then
                AmountLabel.Text = formatNumber(v251);
            end;
        end);
    end;

    local function playFlameLoop(u254: number) -- Line: 1680
        -- upvalues: Flame (copy), u6 (copy), Position5 (copy), TweenService (copy), u4 (copy), u16 (ref), u18 (ref), RunService (copy), u20 (copy)
        TweenService:Create(Flame, u6.FLAME_INTRO_INFO, {
            Position = Position5
        }):Play();

        if #u4 == 0 then
            return;
        end;

        local task_spawn_ret = task.spawn(function() -- Line: 1687
            -- upvalues: u254 (copy), u16 (ref), u18 (ref), RunService (ref), u6 (ref), u4 (ref), Flame (ref)
            local v255 = 0;
            local v256 = 0;

            while true do
                if not (u16 and u254 == u18) then
                    return;
                end;

                v255 = v255 + RunService.RenderStepped:Wait();
                local v257 = math.floor(v255 * u6.FLAME_FPS) % #u4 + 1;

                if v257 == v256 then
                    v257 = v256;
                else
                    Flame.Image = u4[v257];
                end;

                v256 = v257;
            end;
        end);
        table.insert(u20, task_spawn_ret);
    end;

    local function playCobwebs(u258: number) -- Line: 1704
        -- upvalues: u8 (copy), u6 (copy), u16 (ref), u18 (ref), TweenService (copy), u19 (copy)
        for i, v in u8 do
            local Instance2 = v.Instance;
            local u259 = Instance2:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
            u259.Parent = Instance2;
            task.delay((i - 1) * u6.COBWEB_STAGGER, function() -- Line: 1708
                -- upvalues: u258 (copy), u16 (ref), u18 (ref), u259 (copy), u6 (ref), v (copy), TweenService (ref), u19 (ref)
                if not (u16 and u258 == u18) then
                    return;
                end;

                local v260 = TweenService:Create(u259, u6.COBWEB_INTRO_INFO, {
                    Scale = v.BaseScale
                });
                v260:Play();
                v260.Completed:Once(function() -- Line: 1713
                    -- upvalues: u258 (ref), u16 (ref), u18 (ref), u259 (ref), u6 (ref), v (ref), TweenService (ref), u19 (ref)
                    if u16 and u258 == u18 then
                        local v261 = TweenService:Create(u259, u6.COBWEB_BREATHE_INFO, {
                            Scale = v.BaseScale * u6.COBWEB_BREATHE_SCALE
                        });
                        v261:Play();
                        table.insert(u19, v261);
                    end;
                end);
            end);
        end;
    end;

    local function playBackdrop(u262: number) -- Line: 1722
        -- upvalues: BgMask (copy), u6 (copy), GroupTransparency (copy), TweenService (copy), Texture (copy), u19 (copy), playDriftLoop (copy), SmokeTemplate (copy), SmokeMask (copy), u163 (copy), MistTemplate (copy), MistMask (copy), u149 (copy), u16 (ref), u18 (ref), u3 (copy), Frame (copy), u20 (copy), releaseFlock (copy), playFlameLoop (copy), playCobwebs (copy)
        TweenService:Create(BgMask, u6.BG_FADE_INFO, {
            GroupTransparency = GroupTransparency
        }):Play();
        local v263 = Texture;
        local v264 = v263:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
        v264.Parent = v263;
        local v265 = TweenService:Create(v264, u6.BG_BREATHE_INFO, {
            Scale = u6.BG_BREATHE_SCALE
        });
        v265:Play();
        table.insert(u19, v265);
        playDriftLoop(u6.SMOKE, SmokeTemplate, SmokeMask, u163, u262);
        playDriftLoop(u6.MIST, MistTemplate, MistMask, u149, u262);
        local task_spawn_ret = task.spawn(function() -- Line: 1090
            -- upvalues: u6 (ref), u262 (copy), u16 (ref), u18 (ref), u3 (ref), Frame (ref), TweenService (ref)
            local Random_new_ret = Random.new();
            task.wait(u6.LIGHTNING_FIRST_DELAY);

            while true do
                if not (u16 and u262 == u18) then
                    break;
                end;

                u3.Sound("Lightning");
                Frame.BackgroundTransparency = u6.LIGHTNING_PEAK;
                TweenService:Create(Frame, u6.LIGHTNING_STRIKE_INFO, {
                    BackgroundTransparency = 1
                }):Play();
                task.wait(u6.LIGHTNING_GAP);

                if not (u16 and u262 == u18) then
                    break;
                end;

                Frame.BackgroundTransparency = u6.LIGHTNING_ECHO_PEAK;
                TweenService:Create(Frame, u6.LIGHTNING_FADE_INFO, {
                    BackgroundTransparency = 1
                }):Play();
                task.wait(Random_new_ret:NextNumber(u6.LIGHTNING_MIN_INTERVAL, u6.LIGHTNING_MAX_INTERVAL));
            end;
        end);
        table.insert(u20, task_spawn_ret);
        local Random_new_ret = Random.new();
        local task_spawn_ret2 = task.spawn(function() -- Line: 1210
            -- upvalues: u6 (ref), u262 (copy), u16 (ref), u18 (ref), releaseFlock (ref), Random_new_ret (copy)
            task.wait(u6.BAT_FIRST_DELAY);

            while true do
                if not (u16 and u262 == u18) then
                    return;
                end;

                releaseFlock();
                task.wait(Random_new_ret:NextNumber(u6.BAT_MIN_INTERVAL, u6.BAT_MAX_INTERVAL));
            end;
        end);
        table.insert(u20, task_spawn_ret2);
        playFlameLoop(u262);
        playCobwebs(u262);
    end;

    local u266 = false;

    local function applyShopCanvas() -- Line: 1742
        -- upvalues: u266 (ref), UIListLayout (copy), ScrollingFrame (copy)
        u266 = false;
        local math_ceil_ret = math.ceil(UIListLayout.AbsoluteContentSize.Y);
        local v267 = ScrollingFrame.AbsoluteWindowSize.Y + 1 < math_ceil_ret;

        if math.abs(ScrollingFrame.CanvasSize.Y.Offset - math_ceil_ret) > 2 or ScrollingFrame.CanvasSize.Y.Scale ~= 0 then
            ScrollingFrame.CanvasSize = UDim2.fromOffset(0, math_ceil_ret);
        end;

        ScrollingFrame.ScrollingEnabled = v267;

        if not v267 then
            ScrollingFrame.CanvasPosition = Vector2.zero;
        end;
    end;

    local function updateShopCanvas() -- Line: 1759
        -- upvalues: u266 (ref), applyShopCanvas (copy)
        if u266 then
            return;
        end;

        u266 = true;
        task.defer(applyShopCanvas);
    end;

    ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.None;
    ScrollingFrame.ScrollingDirection = Enum.ScrollingDirection.Y;
    UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateShopCanvas);
    ScrollingFrame:GetPropertyChangedSignal("AbsoluteWindowSize"):Connect(updateShopCanvas);

    local function setPriceButton(p268: userdata?, p269: any, p270: any, p271: boolean, u272: any) -- Line: 1773
        -- upvalues: formatNumber (copy), setupButton (copy), u16 (ref), u17 (ref), u14 (ref), u15 (ref)
        if not p268 then
            return;
        end;

        p268.Visible = p269 ~= nil;

        if p271 then
            p271 = p269 ~= nil;
        end;

        p268.Active = p271;
        p268.Selectable = p268.Active;
        p268.Interactable = p268.Active;
        p268.AutoButtonColor = false;

        if p269 == nil then
            return;
        end;

        local TextLabel = p268:FindFirstChild("TextLabel", true);

        if TextLabel and TextLabel:IsA("TextLabel") then
            local v273;

            if typeof(p269) == "number" then
                v273 = formatNumber(p269);
            else
                v273 = tostring(p269);
            end;

            TextLabel.Text = v273;
        end;

        if p268.Active then
            setupButton(p268, p270, function() -- Line: 1795
                -- upvalues: u16 (ref), u17 (ref), u14 (ref), u15 (ref), u272 (copy)
                local v274 = u16 and not (u17 or u14) and (not u15 or u272 and u272());

                return v274;
            end);
        end;
    end;

    local function hasCredit(p275) -- Line: 1801
        -- upvalues: u3 (copy), u12 (ref), u13 (ref)
        local v276;

        if p275 == u3.Catalog.CandyChest and u12 > 0 then
            v276 = true;
        elseif p275 == u3.Catalog.Broom then
            v276 = u13 > 0;
        else
            v276 = false;
        end;

        return v276;
    end;

    local function resetShopInteractions() -- Line: 1806
        -- upvalues: u146 (copy), TweenService (copy)
        local TweenInfo_new_ret = TweenInfo.new(0);

        for _, v in u146 do
            TweenService:Create(v.Channels.Interact, TweenInfo_new_ret, {
                Value = 1
            }):Play();
            TweenService:Create(v.IconHover, TweenInfo_new_ret, {
                Value = 1
            }):Play();

            if v.Revealed then
                TweenService:Create(v.Icon, TweenInfo_new_ret, {
                    Rotation = v.IconRotation
                }):Play();
            end;

            if v.Shine then
                TweenService:Create(v.Shine, TweenInfo_new_ret, {
                    Rotation = v.ShineRotation
                }):Play();
            end;

            for _, descendant in v.Holder:GetDescendants() do
                if descendant:IsA("GuiButton") then
                    local v277 = descendant:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
                    v277.Parent = descendant;
                    TweenService:Create(v277, TweenInfo_new_ret, {
                        Scale = 1
                    }):Play();
                end;
            end;
        end;
    end;

    local function setupEntryHover(u278) -- Line: 1825
        -- upvalues: u15 (ref), u14 (ref), u3 (copy), u6 (copy), TweenService (copy)
        local MainButton = u278.Holder:FindFirstChild("MainButton");

        if not (MainButton and MainButton:IsA("GuiButton")) then
            return;
        end;

        MainButton:AddTag("AnimationExempt");
        MainButton.MouseEnter:Connect(function() -- Line: 1834
            -- upvalues: u15 (ref), u14 (ref), u278 (copy), u3 (ref), u6 (ref), TweenService (ref)
            if u15 or (u14 or not u278.Revealed) then
                return;
            end;

            u3.Sound("UIHover");
            TweenService:Create(u278.Channels.Interact, u6.ENTRY_HOVER_INFO, {
                Value = u6.ENTRY_HOVER_SCALE
            }):Play();
            TweenService:Create(u278.IconHover, u6.ENTRY_HOVER_INFO, {
                Value = u6.ENTRY_HOVER_ICON_SCALE
            }):Play();
            TweenService:Create(u278.Icon, u6.ENTRY_HOVER_INFO, {
                Rotation = u278.IconRotation + u6.ENTRY_HOVER_ICON_ROTATION
            }):Play();

            if u278.Shine then
                TweenService:Create(u278.Shine, u6.ENTRY_SHINE_HOVER_INFO, {
                    Rotation = u278.ShineRotation + u6.ENTRY_HOVER_SHINE_ROTATION
                }):Play();
            end;
        end);
        MainButton.MouseLeave:Connect(function() -- Line: 1850
            -- upvalues: u15 (ref), u14 (ref), u278 (copy), u6 (ref), TweenService (ref)
            if u15 or (u14 or not u278.Revealed) then
                return;
            end;

            TweenService:Create(u278.Channels.Interact, u6.ENTRY_LEAVE_INFO, {
                Value = 1
            }):Play();
            TweenService:Create(u278.IconHover, u6.ENTRY_LEAVE_INFO, {
                Value = 1
            }):Play();
            TweenService:Create(u278.Icon, u6.ENTRY_LEAVE_INFO, {
                Rotation = u278.IconRotation
            }):Play();

            if u278.Shine then
                TweenService:Create(u278.Shine, u6.ENTRY_SHINE_HOVER_INFO, {
                    Rotation = u278.ShineRotation
                }):Play();
            end;
        end);
    end;

    local function createShopEntry(p279: userdata, p280: userdata, u281: number, u282: number, u283: any) -- Line: 1865
        -- upvalues: Customization (copy), u3 (copy), formatNumber (copy), setPriceButton (copy), u15 (ref), u12 (ref), u13 (ref), BindableEvent2 (copy), setupButton (copy), u5 (copy), u16 (ref), u17 (ref), u14 (ref), createScaleChannels (copy), u6 (copy), setupEntryHover (copy)
        local v284 = p280:Clone();
        v284.Name = "Entry" .. tostring(u282);
        v284.LayoutOrder = u282;
        v284.Visible = true;
        v284.Parent = p279;
        local Holder2 = v284:WaitForChild("Holder");
        local Title2 = Holder2:WaitForChild("Title");
        local Icon2 = Holder2:WaitForChild("Icon");
        local Amount = Holder2:WaitForChild("Amount");
        local ButtonsFrame = Holder2:WaitForChild("ButtonsFrame");
        local Outline = Holder2:FindFirstChild("Outline");
        Title2.Text = string.upper((tostring(u283.ItemName or "ITEM")));
        local Icon3 = u283.Icon;

        if not Icon3 then
            local Reward = u283.Reward;
            local v285 = Reward and Reward.Category and Customization[Reward.Category];

            if v285 then
                v285 = v285[Reward.Item];
            end;

            Icon3 = Reward and Reward.Icon or (v285 and (v285.IconId or (v285.Icon or 130432201459489)) or 130432201459489);
        end;

        local v286;

        if typeof(Icon3) == "number" then
            v286 = "rbxassetid://" .. tostring(Icon3);
        else
            v286 = tostring(Icon3 or "");
        end;

        Icon2.Image = v286;

        if u3.RenderReward then
            u3.RenderReward(Icon2, u283.Reward);
        end;

        local v287;

        if u283.Enabled == true then
            v287 = u283.Amount ~= nil;
        else
            v287 = false;
        end;

        Amount.Visible = v287;

        if u283.Amount ~= nil then
            Amount.Text = "+" .. formatNumber(tonumber(u283.Amount) or 0);
        end;

        local CandyCorn2 = ButtonsFrame:FindFirstChild("CandyCorn");

        local function v290() -- Line: 1889
            -- upvalues: u15 (ref), u283 (copy), u3 (ref), u12 (ref), u13 (ref), BindableEvent2 (ref), u281 (copy), u282 (copy)
            if u15 or u283.Enabled ~= true then
                local v288 = u283;
                local v289;

                if v288 == u3.Catalog.CandyChest and u12 > 0 then
                    v289 = true;
                elseif v288 == u3.Catalog.Broom then
                    v289 = u13 > 0;
                else
                    v289 = false;
                end;

                if not v289 then
                    return;
                end;
            end;

            BindableEvent2:Fire(u281, u282, "Candy", u283);
        end;

        local v291;

        if u283.Enabled == true then
            v291 = u283.Candy ~= nil;
        else
            if u283 == u3.Catalog.CandyChest and u12 > 0 then
                v291 = true;
            elseif u283 == u3.Catalog.Broom then
                v291 = u13 > 0;
            else
                v291 = false;
            end;

            if v291 then
                v291 = u283.Candy ~= nil;
            end;
        end;

        setPriceButton(CandyCorn2, u283.Candy or u283.DisplayCandy, v290, v291, function() -- Line: 1892
            -- upvalues: u283 (copy), u3 (ref), u12 (ref), u13 (ref)
            local v292 = u283;
            local v293;

            if v292 == u3.Catalog.CandyChest and u12 > 0 then
                v293 = true;
            elseif v292 == u3.Catalog.Broom then
                v293 = u13 > 0;
            else
                v293 = false;
            end;

            return v293;
        end);
        local Robux = ButtonsFrame:FindFirstChild("Robux");

        local function v294() -- Line: 1894
            -- upvalues: u15 (ref), BindableEvent2 (ref), u281 (copy), u282 (copy), u283 (copy)
            if u15 then
                return;
            end;

            BindableEvent2:Fire(u281, u282, "Robux", u283);
        end;

        local v295;

        if u283.Enabled == true then
            v295 = u283.RobuxEnabled == true;
        else
            v295 = false;
        end;

        setPriceButton(Robux, u283.Robux or u283.DisplayRobux, v294, v295);
        local Contents = Holder2:FindFirstChild("Contents");
        local MainButton = Holder2:FindFirstChild("MainButton");

        if Contents and Contents:IsA("GuiButton") then
            local v296 = u283 == u3.Catalog.CandyChest;
            Contents.Visible = v296;
            Contents.Active = v296;
            Contents.Selectable = v296;
            Contents.Interactable = v296;
            Contents:AddTag("AnimationExempt");

            if v296 then
                if MainButton then
                    Contents.ZIndex = MainButton.ZIndex + 1;
                end;

                setupButton(Contents, function() -- Line: 1910
                    -- upvalues: u5 (ref), u283 (copy)
                    u5.OpenChances(u283);
                end, function() -- Line: 1912
                    -- upvalues: u16 (ref), u17 (ref), u15 (ref), u14 (ref)
                    return u16 and not (u17 or u15) and not u14;
                end);
            end;
        end;

        local v297 = createScaleChannels(Icon2);

        if Outline then
            Outline = Outline:FindFirstChildOfClass("UIGradient");
        end;

        local v298 = {
            Revealed = false,
            Frame = v284,
            Holder = Holder2,
            Offer = u283
        };
        local v299;

        if u283 == u3.Catalog.CandyChest or u283 == u3.Catalog.Broom then
            v299 = ButtonsFrame.CandyCorn:FindFirstChild("TextLabel", true);
        else
            v299 = false;
        end;

        v298.CreditLabel = v299;
        v298.Channels = createScaleChannels(Holder2);
        v298.Icon = Icon2;
        v298.IconReveal = v297.Reveal;
        v298.IconHover = v297.Interact;
        v298.IconPosition = Icon2.Position;
        v298.IconRotation = Icon2.Rotation;
        v298.Shine = Outline;
        v298.ShineRotation = Outline and (Outline.Rotation or 0) or 0;
        v298.ShineOffset = Outline and Outline.Offset or Vector2.zero;
        v298.Channels.Reveal.Value = 0;
        v298.IconReveal.Value = 0;
        Holder2.GroupTransparency = 1;
        Icon2.Rotation = v298.IconRotation + u6.ENTRY_ICON_START_ROTATION;

        if v298.CreditLabel then
            local v300;

            if u283 == u3.Catalog.CandyChest and u12 > 0 then
                v300 = true;
            elseif u283 == u3.Catalog.Broom then
                v300 = u13 > 0;
            else
                v300 = false;
            end;

            if v300 then
                local v301;

                if u283 == u3.Catalog.CandyChest then
                    v301 = u12;
                else
                    v301 = u13;
                end;

                v298.CreditLabel.Text = (u283 == u3.Catalog.CandyChest and "OPEN (" or "CLAIM (") .. tostring(v301) .. ")";
            end;
        end;

        setupEntryHover(v298);

        return v298;
    end;

    local function clearShop() -- Line: 1954
        -- upvalues: u157 (copy), u146 (copy)
        local v302 = u157;

        for _, v in v302 do
            if v.Parent then
                v:Destroy();
            end;
        end;

        table.clear(v302);
        table.clear(u146);
    end;

    local function populateShop() -- Line: 1959
        -- upvalues: u157 (copy), u146 (copy), Rows (copy), TripleRowFrame (copy), DoubleRowFrame (copy), ScrollingFrame (copy), createShopEntry (copy), u266 (ref), applyShopCanvas (copy)
        local v303 = u157;

        for _, v in v303 do
            if v.Parent then
                v:Destroy();
            end;
        end;

        table.clear(v303);
        table.clear(u146);

        for i, v in ipairs(Rows) do
            local v304 = #v;

            if v304 ~= 0 then
                if v304 > 3 then
                    warn("HalloweenEventHandler: row", i, "has", v304, "items, only 3 fit");
                end;

                local v305 = v304 >= 3 and TripleRowFrame or DoubleRowFrame;
                local EntryFrame = v305:WaitForChild("EntryFrame");
                local v306 = v305:Clone();
                v306.Name = "Row" .. tostring(i);
                v306.LayoutOrder = i;
                v306.Visible = true;
                local EntryFrame2 = v306:FindFirstChild("EntryFrame");

                if EntryFrame2 then
                    EntryFrame2:Destroy();
                end;

                v306.Parent = ScrollingFrame;
                table.insert(u157, v306);
                local v307 = v;
                local v308 = i;

                for i2 = 1, math.min(v304, 3) do
                    local v309 = createShopEntry(v306, EntryFrame, v308, i2, v307[i2]);
                    table.insert(u146, v309);
                    local _ = i2;
                end;
            end;
        end;

        ScrollingFrame.CanvasPosition = Vector2.zero;

        if u266 then
            return;
        end;

        u266 = true;
        task.defer(applyShopCanvas);
    end;

    local function revealShopEntry(u310: any, u311: number) -- Line: 2000
        -- upvalues: u6 (copy), TweenService (copy), u16 (ref), u18 (ref), u19 (copy)
        TweenService:Create(u310.Channels.Reveal, u6.ENTRY_REVEAL_INFO, {
            Value = 1
        }):Play();
        TweenService:Create(u310.Holder, u6.ENTRY_FADE_INFO, {
            GroupTransparency = 0
        }):Play();

        if u310.Shine then
            u310.Shine.Offset = Vector2.new(-1, 0);
            TweenService:Create(u310.Shine, u6.ENTRY_SHINE_INFO, {
                Offset = u310.ShineOffset
            }):Play();
        end;

        task.delay(0.08, function() -- Line: 2010
            -- upvalues: u311 (copy), u16 (ref), u18 (ref), u310 (copy), u6 (ref), TweenService (ref), u19 (ref)
            if not (u16 and u311 == u18 and u310.Frame.Parent) then
                return;
            end;

            TweenService:Create(u310.IconReveal, u6.ENTRY_ICON_INFO, {
                Value = 1
            }):Play();
            local v312 = TweenService:Create(u310.Icon, u6.ENTRY_ICON_INFO, {
                Rotation = u310.IconRotation
            });
            v312:Play();
            v312.Completed:Once(function() -- Line: 2017
                -- upvalues: u311 (ref), u16 (ref), u18 (ref), u310 (ref), u6 (ref), TweenService (ref), u19 (ref)
                if not (u16 and u311 == u18 and u310.Frame.Parent) then
                    return;
                end;

                u310.Revealed = true;
                local Random_new_ret = Random.new();
                local v313 = TweenService:Create(u310.Icon, TweenInfo.new(Random_new_ret:NextNumber(u6.ENTRY_ICON_BOB_MIN_TIME, u6.ENTRY_ICON_BOB_MAX_TIME), Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
                    Position = u310.IconPosition + UDim2.fromOffset(0, -u6.ENTRY_ICON_BOB)
                });
                v313:Play();
                table.insert(u19, v313);
            end);
        end);
    end;

    local u314 = {
        ShineTween = nil,
        Revealed = false,
        Hovering = false,
        ChestChannels = createScaleChannels(Chest),
        ChestPosition = Chest.Position,
        ChestRotation = Chest.Rotation
    };
    local v315;

    if Shine then
        v315 = Shine.Position;
    else
        v315 = Shine;
    end;

    u314.ShinePosition = v315;
    local v316;

    if CandyCorn then
        v316 = createScaleChannels(CandyCorn);
    else
        v316 = CandyCorn;
    end;

    u314.CandyChannels = v316;
    u314.Entries = {};

    for _, child in ContentsFrame:GetChildren() do
        if child:IsA("GuiObject") and child.Name == "Entry" then
            local Icon2 = child:FindFirstChild("Icon");
            local Entries = u314.Entries;
            local v317 = {
                Frame = child,
                Scale = getScale(child),
                Icon = Icon2
            };
            v317.IconPosition = Icon2 and Icon2.Position;
            table.insert(Entries, v317);
        end;
    end;

    local function getShinePosition(p318: number) -- Line: 2065
        -- upvalues: u314 (copy), Shine (copy), u6 (copy)
        local ShinePosition = u314.ShinePosition;
        local v319 = Shine.Size.X.Scale * 0.5 + u6.CHEST_SHINE_MARGIN;
        local v320;

        if p318 <= 0.5 then
            v320 = p318 - v319;
        else
            v320 = p318 + v319;
        end;

        return UDim2.new(v320, 0, ShinePosition.Y.Scale, ShinePosition.Y.Offset);
    end;

    local function sweepBatChestShine() -- Line: 2074
        -- upvalues: Shine (copy), u314 (copy), u6 (copy), TweenService (copy)
        if not Shine then
            return;
        end;

        if u314.ShineTween then
            u314.ShineTween:Cancel();
        end;

        local CHEST_SHINE_START_X = u6.CHEST_SHINE_START_X;
        local ShinePosition = u314.ShinePosition;
        local v321 = Shine.Size.X.Scale * 0.5 + u6.CHEST_SHINE_MARGIN;
        local v322;

        if CHEST_SHINE_START_X <= 0.5 then
            v322 = CHEST_SHINE_START_X - v321;
        else
            v322 = CHEST_SHINE_START_X + v321;
        end;

        Shine.Position = UDim2.new(v322, 0, ShinePosition.Y.Scale, ShinePosition.Y.Offset);
        local CHEST_SHINE_INFO = u6.CHEST_SHINE_INFO;
        local v323 = {};
        local CHEST_SHINE_END_X = u6.CHEST_SHINE_END_X;
        local ShinePosition2 = u314.ShinePosition;
        local v324 = Shine.Size.X.Scale * 0.5 + u6.CHEST_SHINE_MARGIN;
        local v325;

        if CHEST_SHINE_END_X <= 0.5 then
            v325 = CHEST_SHINE_END_X - v324;
        else
            v325 = CHEST_SHINE_END_X + v324;
        end;

        v323.Position = UDim2.new(v325, 0, ShinePosition2.Y.Scale, ShinePosition2.Y.Offset);
        local v326 = TweenService:Create(Shine, CHEST_SHINE_INFO, v323);
        v326:Play();
        u314.ShineTween = v326;
    end;

    local function resetBatChest() -- Line: 2087
        -- upvalues: u314 (copy), u3 (copy), Holder (copy), Chest (copy), u6 (copy), Shine (copy)
        for _, v in u314.Entries do
            if v.Icon and u3.ClearRewardPreview then
                u3.ClearRewardPreview(v.Icon);
            end;
        end;

        u314.Revealed = false;
        Holder.GroupTransparency = 1;
        u314.ChestChannels.Reveal.Value = 0;
        u314.ChestChannels.Interact.Value = 1;
        Chest.Position = u314.ChestPosition;
        Chest.Rotation = u314.ChestRotation + u6.CHEST_START_ROTATION;

        if u314.CandyChannels then
            u314.CandyChannels.Reveal.Value = 0;
            u314.CandyChannels.Interact.Value = 1;
        end;

        for _, v in u314.Entries do
            v.Scale.Scale = 0;

            if v.Icon then
                v.Icon.Position = v.IconPosition;
            end;
        end;

        if Shine then
            if u314.ShineTween then
                u314.ShineTween:Cancel();
                u314.ShineTween = nil;
            end;

            local CHEST_SHINE_START_X = u6.CHEST_SHINE_START_X;
            local ShinePosition = u314.ShinePosition;
            local v327 = Shine.Size.X.Scale * 0.5 + u6.CHEST_SHINE_MARGIN;
            local v328;

            if CHEST_SHINE_START_X <= 0.5 then
                v328 = CHEST_SHINE_START_X - v327;
            else
                v328 = CHEST_SHINE_START_X + v327;
            end;

            Shine.Position = UDim2.new(v328, 0, ShinePosition.Y.Scale, ShinePosition.Y.Offset);
        end;
    end;

    local function startChestFloat(u329: number) -- Line: 2124
        -- upvalues: Chest (copy), u6 (copy), u314 (copy), TweenService (copy), u19 (copy), u16 (ref), u18 (ref), u20 (copy), sweepBatChestShine (copy)
        local v330 = TweenService:Create(Chest, u6.CHEST_FLOAT_INFO, {
            Position = u314.ChestPosition + UDim2.fromScale(0, -u6.CHEST_FLOAT)
        });
        v330:Play();
        table.insert(u19, v330);
        local v331 = TweenService:Create(u314.ChestChannels.Reveal, u6.CHEST_BREATHE_INFO, {
            Value = u6.CHEST_BREATHE_SCALE
        });
        v331:Play();
        table.insert(u19, v331);
        local task_spawn_ret = task.spawn(function() -- Line: 2131
            -- upvalues: Chest (ref), u6 (ref), u314 (ref), TweenService (ref), u329 (copy), u16 (ref), u18 (ref), u19 (ref)
            local v332 = TweenService:Create(Chest, TweenInfo.new(u6.CHEST_SWAY_TIME * 0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                Rotation = u314.ChestRotation - u6.CHEST_SWAY
            });
            v332:Play();
            v332.Completed:Wait();

            if u16 and u329 == u18 then
                local v333 = TweenService:Create(Chest, TweenInfo.new(u6.CHEST_SWAY_TIME, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
                    Rotation = u314.ChestRotation + u6.CHEST_SWAY
                });
                v333:Play();
                table.insert(u19, v333);
            end;
        end);
        table.insert(u20, task_spawn_ret);
        local task_spawn_ret2 = task.spawn(function() -- Line: 2147
            -- upvalues: u329 (copy), u16 (ref), u18 (ref), u6 (ref), u314 (ref), sweepBatChestShine (ref)
            local Random_new_ret = Random.new();

            while true do
                if not (u16 and u329 == u18) then
                    return;
                end;

                task.wait(Random_new_ret:NextNumber(u6.CHEST_SHINE_MIN_INTERVAL, u6.CHEST_SHINE_MAX_INTERVAL));

                if u16 and u329 == u18 and not u314.Hovering then
                    sweepBatChestShine();
                end;
            end;
        end);
        table.insert(u20, task_spawn_ret2);
    end;

    local function playBatChestReveal(u334: number) -- Line: 2160
        -- upvalues: u314 (copy), u3 (copy), Holder (copy), u6 (copy), TweenService (copy), Chest (copy), u16 (ref), u18 (ref), startChestFloat (copy), u19 (copy), sweepBatChestShine (copy)
        for i, v in u314.Entries do
            if v.Icon and u3.RenderReward then
                u3.RenderReward(v.Icon, u3.Catalog.Chest.Grants[i]);
            end;
        end;

        TweenService:Create(Holder, u6.SHOP_FADE_INFO, {
            GroupTransparency = 0
        }):Play();
        TweenService:Create(u314.ChestChannels.Reveal, u6.CHEST_POP_INFO, {
            Value = 1
        }):Play();
        local v335 = TweenService:Create(Chest, u6.CHEST_POP_INFO, {
            Rotation = u314.ChestRotation
        });
        v335:Play();
        v335.Completed:Once(function() -- Line: 2170
            -- upvalues: u334 (copy), u16 (ref), u18 (ref), u314 (ref), startChestFloat (ref)
            if not (u16 and u334 == u18) then
                return;
            end;

            u314.Revealed = true;
            startChestFloat(u334);
        end);

        for i, v in u314.Entries do
            task.delay(u6.CHEST_ENTRY_DELAY + (i - 1) * u6.CHEST_ENTRY_STAGGER, function() -- Line: 2180
                -- upvalues: u334 (copy), u16 (ref), u18 (ref), v (copy), u6 (ref), TweenService (ref), u19 (ref)
                if not (u16 and u334 == u18) then
                    return;
                end;

                local v336 = TweenService:Create(v.Scale, u6.ENTRY_ICON_INFO, {
                    Scale = 1
                });
                v336:Play();
                v336.Completed:Once(function() -- Line: 2185
                    -- upvalues: u334 (ref), u16 (ref), u18 (ref), v (ref), u6 (ref), TweenService (ref), u19 (ref)
                    if not (u16 and u334 == u18 and v.Icon) then
                        return;
                    end;

                    local Random_new_ret = Random.new();
                    local v337 = TweenService:Create(v.Icon, TweenInfo.new(Random_new_ret:NextNumber(u6.CHEST_ENTRY_BOB_MIN_TIME, u6.CHEST_ENTRY_BOB_MAX_TIME), Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
                        Position = v.IconPosition + UDim2.fromOffset(0, -u6.CHEST_ENTRY_BOB)
                    });
                    v337:Play();
                    table.insert(u19, v337);
                end);
            end);
        end;

        if u314.CandyChannels then
            task.delay(u6.CHEST_CANDY_DELAY, function() -- Line: 2203
                -- upvalues: u334 (copy), u16 (ref), u18 (ref), u314 (ref), u6 (ref), TweenService (ref)
                if u16 and u334 == u18 then
                    TweenService:Create(u314.CandyChannels.Reveal, u6.ENTRY_ICON_INFO, {
                        Value = 1
                    }):Play();
                end;
            end);
        end;

        task.delay(u6.CHEST_SHINE_FIRST_DELAY, function() -- Line: 2210
            -- upvalues: u334 (copy), u16 (ref), u18 (ref), sweepBatChestShine (ref)
            if u16 and u334 == u18 then
                sweepBatChestShine();
            end;
        end);
    end;

    ImageButton.MouseEnter:Connect(function() -- Line: 2217
        -- upvalues: u314 (copy), u3 (copy), u6 (copy), TweenService (copy), sweepBatChestShine (copy)
        u314.Hovering = true;

        if not u314.Revealed then
            return;
        end;

        u3.Sound("UIHover");
        TweenService:Create(u314.ChestChannels.Interact, u6.ENTRY_HOVER_INFO, {
            Value = u6.CHEST_HOVER_SCALE
        }):Play();

        for i, v in u314.Entries do
            task.delay((i - 1) * u6.CHEST_EXIT_STAGGER, function() -- Line: 2230
                -- upvalues: u314 (ref), v (copy), u6 (ref), TweenService (ref)
                if u314.Hovering and u314.Revealed then
                    TweenService:Create(v.Scale, u6.ENTRY_HOVER_INFO, {
                        Scale = u6.CHEST_ENTRY_HOVER_SCALE
                    }):Play();
                end;
            end);
        end;

        sweepBatChestShine();
    end);
    ImageButton.MouseLeave:Connect(function() -- Line: 2240
        -- upvalues: u314 (copy), u6 (copy), TweenService (copy)
        u314.Hovering = false;

        if u314.Revealed then
            for _, v in u314.Entries do
                TweenService:Create(v.Scale, u6.ENTRY_LEAVE_INFO, {
                    Scale = 1
                }):Play();
            end;
        end;

        TweenService:Create(u314.ChestChannels.Interact, u6.ENTRY_LEAVE_INFO, {
            Value = 1
        }):Play();
    end);
    ImageButton.MouseButton1Down:Connect(function() -- Line: 2252
        -- upvalues: u3 (copy), u314 (copy), u6 (copy), TweenService (copy)
        if u3.Catalog.Chest.Enabled ~= true then
            return;
        end;

        if u314.Revealed then
            TweenService:Create(u314.ChestChannels.Interact, u6.BUTTON_PRESS_INFO, {
                Value = u6.CHEST_PRESS_SCALE
            }):Play();
        end;
    end);
    ImageButton.MouseButton1Up:Connect(function() -- Line: 2259
        -- upvalues: u3 (copy), u314 (copy), u6 (copy), TweenService (copy)
        if u3.Catalog.Chest.Enabled ~= true then
            return;
        end;

        if u314.Revealed then
            TweenService:Create(u314.ChestChannels.Interact, u6.BUTTON_RELEASE_INFO, {
                Value = u314.Hovering and u6.CHEST_HOVER_SCALE or 1
            }):Play();
        end;
    end);
    ImageButton.Activated:Connect(function() -- Line: 2268
        -- upvalues: u3 (copy), u15 (ref), u314 (copy), BindableEvent (copy)
        if u3.Catalog.Chest.Enabled ~= true then
            return;
        end;

        if u15 or not u314.Revealed then
            return;
        end;

        u3.Sound("UIClick");
        BindableEvent:Fire(nil);
    end);

    if CandyCorn and u314.CandyChannels then
        local Interact = u314.CandyChannels.Interact;
        local u338 = false;
        CandyCorn.MouseEnter:Connect(function() -- Line: 2283
            -- upvalues: u338 (ref), u314 (copy), u3 (copy), Interact (copy), u6 (copy), TweenService (copy)
            u338 = true;

            if u314.Revealed then
                u3.Sound("UIHover");
                TweenService:Create(Interact, u6.BUTTON_HOVER_INFO, {
                    Value = u6.BUTTON_HOVER_SCALE
                }):Play();
            end;
        end);
        CandyCorn.MouseLeave:Connect(function() -- Line: 2292
            -- upvalues: u338 (ref), Interact (copy), u6 (copy), TweenService (copy)
            u338 = false;
            TweenService:Create(Interact, u6.BUTTON_LEAVE_INFO, {
                Value = 1
            }):Play();
        end);
        CandyCorn.MouseButton1Down:Connect(function() -- Line: 2297
            -- upvalues: u3 (copy), u314 (copy), Interact (copy), u6 (copy), TweenService (copy)
            if u3.Catalog.Chest.Enabled ~= true then
                return;
            end;

            if u314.Revealed then
                TweenService:Create(Interact, u6.BUTTON_PRESS_INFO, {
                    Value = u6.BUTTON_PRESS_SCALE
                }):Play();
            end;
        end);
        CandyCorn.MouseButton1Up:Connect(function() -- Line: 2304
            -- upvalues: u3 (copy), Interact (copy), u6 (copy), u338 (ref), TweenService (copy)
            if u3.Catalog.Chest.Enabled ~= true then
                return;
            end;

            TweenService:Create(Interact, u6.BUTTON_RELEASE_INFO, {
                Value = u338 and u6.BUTTON_HOVER_SCALE or 1
            }):Play();
        end);
        CandyCorn.Activated:Connect(function() -- Line: 2309
            -- upvalues: u3 (copy), u15 (ref), u314 (copy), BindableEvent (copy)
            if u3.Catalog.Chest.Enabled ~= true then
                return;
            end;

            if u15 or not u314.Revealed then
                return;
            end;

            u3.Sound("UIClick");
            BindableEvent:Fire("Candy");
        end);
    end;

    local function resetShop() -- Line: 2321
        -- upvalues: Content (copy), Position6 (copy), u6 (copy), ShopCg (copy), Tag2 (copy), resetBatChest (copy)
        local v339 = Position6;
        Content.Position = UDim2.new(v339.X.Scale, v339.X.Offset, v339.Y.Scale + u6.SHOP_RISE * Content.Size.Y.Scale, v339.Y.Offset);
        ShopCg.GroupTransparency = 1;
        local v340 = Content;
        local v341 = v340:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
        v341.Parent = v340;
        v341.Scale = u6.SHOP_START_SCALE;
        local v342 = Tag2;
        local v343 = v342:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
        v343.Parent = v342;
        v343.Scale = 0;
        resetBatChest();
    end;

    local function playShopReveal(u344: number) -- Line: 2330
        -- upvalues: Content (copy), u6 (copy), Position6 (copy), TweenService (copy), ShopCg (copy), u16 (ref), u18 (ref), Tag2 (copy), playBatChestReveal (copy), u146 (copy), revealShopEntry (copy)
        TweenService:Create(Content, u6.SHOP_INTRO_INFO, {
            Position = Position6
        }):Play();
        TweenService:Create(ShopCg, u6.SHOP_FADE_INFO, {
            GroupTransparency = 0
        }):Play();
        local v345 = Content;
        local v346 = v345:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
        v346.Parent = v345;
        TweenService:Create(v346, u6.SHOP_INTRO_INFO, {
            Scale = 1
        }):Play();
        task.delay(0.12, function() -- Line: 2335
            -- upvalues: u344 (copy), u16 (ref), u18 (ref), Tag2 (ref), u6 (ref), TweenService (ref)
            if u16 and u344 == u18 then
                local v347 = Tag2;
                local v348 = v347:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
                v348.Parent = v347;
                TweenService:Create(v348, u6.TITLE_POP_INFO, {
                    Scale = 1
                }):Play();
            end;
        end);
        task.delay(u6.CHEST_REVEAL_DELAY, function() -- Line: 2341
            -- upvalues: u344 (copy), u16 (ref), u18 (ref), playBatChestReveal (ref)
            if u16 and u344 == u18 then
                playBatChestReveal(u344);
            end;
        end);
        task.delay(u6.SHOP_ENTRY_DELAY, function() -- Line: 2347
            -- upvalues: u146 (ref), u344 (copy), u16 (ref), u18 (ref), revealShopEntry (ref), u6 (ref)
            for _, v in u146 do
                if not (u16 and u344 == u18) then
                    return;
                end;

                revealShopEntry(v, u344);
                task.wait(u6.SHOP_ENTRY_STAGGER);
            end;
        end);
    end;

    local function cancelModalTweens(p349) -- Line: 2362
        for i in p349.Tweens do
            i:Cancel();
        end;

        table.clear(p349.Tweens);
    end;

    local u350 = {};

    local function modalTween(u351, p352, p353, p354) -- Line: 2369
        -- upvalues: TweenService (copy)
        local u355 = TweenService:Create(p352, p353, p354);
        u351.Tweens[u355] = true;
        u355.Completed:Once(function() -- Line: 2372
            -- upvalues: u351 (copy), u355 (copy)
            u351.Tweens[u355] = nil;
        end);
        u355:Play();

        return u355;
    end;

    for _, child in HalloweenEvent.ChancesFrame.Holder.Contents:GetChildren() do
        if child:IsA("GuiObject") and child.Name == "Template" then
            table.insert(u350, child:Clone());
        end;
    end;

    table.sort(u350, function(p356, p357) -- Line: 2385
        return p356.LayoutOrder < p357.LayoutOrder;
    end);
    local u358 = {
        Tweens = {},
        Cg = HalloweenEvent:WaitForChild("ChestUnboxing")
    };
    u358.Chest = u358.Cg:WaitForChild("ChestIcon");
    u358.Sunburst = u358.Cg:WaitForChild("Sunburst");
    u358.CounterSunburst = u358.Cg:WaitForChild("CounterSunburst");
    u358.BgMask = u358.Cg:WaitForChild("BgMask");
    u358.Reward = u358.Cg:WaitForChild("Reward");
    u358.Name = u358.Cg:WaitForChild("RewardName");
    u358.BasePosition = u358.Cg.Position;
    u358.ChestPosition = u358.Chest.Position;
    u358.ChestRotation = u358.Chest.Rotation;
    u358.RewardPosition = u358.Reward.Position;
    u358.RewardRotation = u358.Reward.Rotation;
    u358.SunburstRotation = u358.Sunburst.Rotation;
    u358.CounterRotation = u358.CounterSunburst.Rotation;
    u358.BgMaskTransparency = u358.BgMask.GroupTransparency;
    u358.NameTransparency = u358.Name.TextTransparency;
    u358.Playing = false;
    u358.ReadyToDismiss = false;
    u358.Generation = 0;
    u358.Loops = {};
    u358.Particles = {};
    u358.SuspenseSounds = {};
    u358.SUSPENSE_SOUND_NAMES = { "Shake", "Riser" };

    function u358.stopShakeSound() -- Line: 2455
        -- upvalues: u358 (copy)
        for _, v in u358.SuspenseSounds do
            v:Stop();
            v:Destroy();
        end;

        table.clear(u358.SuspenseSounds);
    end;

    function u358.startShakeSound() -- Line: 2464
        -- upvalues: u358 (copy), u3 (copy)
        u358.stopShakeSound();

        for _, v in u358.SUSPENSE_SOUND_NAMES do
            local v359 = u3.Sound(v);

            if v359 then
                table.insert(u358.SuspenseSounds, v359);
            end;
        end;
    end;

    u358.Catcher = Instance.new("TextButton");
    u358.Catcher.Name = "UnboxCatcher";
    u358.Catcher.Text = "";
    u358.Catcher.AutoButtonColor = false;
    u358.Catcher.BackgroundTransparency = 1;
    u358.Catcher.AnchorPoint = Vector2.new(0.5, 0.5);
    u358.Catcher.Position = UDim2.fromScale(0.5, 0.5);
    u358.Catcher.Size = UDim2.fromScale(1, 1);
    u358.Catcher.ZIndex = 50;
    u358.Catcher.Parent = u358.Cg;
    u358.Strip = HalloweenEvent:WaitForChild("ChancesFrame"):WaitForChild("Holder"):WaitForChild("Contents"):Clone();
    u358.Strip.Name = "ContentsStrip";
    u358.Strip.AnchorPoint = Vector2.new(0.5, 1);
    u358.Strip.Position = UDim2.fromScale(0.5, u6.UNBOX_STRIP_Y);
    u358.Strip.Size = UDim2.fromScale(u6.UNBOX_STRIP_WIDTH, u6.UNBOX_STRIP_HEIGHT);
    u358.Strip.ZIndex = 3;
    u358.Strip.Visible = false;
    u358.Strip.Parent = u358.Cg;
    u358.StripItems = {};

    local function setRewardContents(p360, p361) -- Line: 2387
        -- upvalues: u350 (copy), Customization (copy), u3 (copy)
        for _, child in p360:GetChildren() do
            if child:IsA("GuiObject") and child.Name == "Template" then
                child:Destroy();
            end;
        end;

        local v362;

        if p361 then
            v362 = p361.Rewards or p361.Grants;

            if not v362 then
                v362 = p361.Reward and { p361.Reward };
            end;
        else
            v362 = p361;
        end;

        local v363;

        if typeof(v362) == "table" then
            v363 = #v362 > 0;
        else
            v363 = false;
        end;

        local v364;

        if v363 then
            v364 = #v362;
        else
            v364 = #u350;
        end;

        local v365 = {};

        for i = 1, v364 do
            local v366;

            if v363 then
                v366 = u350[1];
            else
                v366 = u350[i];
            end;

            local v367 = v366:Clone();
            v367.LayoutOrder = i;

            if v363 then
                local v368 = v362[i];
                v367.Size = UDim2.new(math.min(u350[1].Size.X.Scale, 0.9 / v364), 0, v367.Size.Y.Scale, v367.Size.Y.Offset);
                v367:FindFirstChild("Name").Text = v368.Name or (v368.Item or "+" .. tostring(v368.Amount) .. " " .. tostring(v368.Category));
                v367.Chance.Text = p361.Grants and "INCLUDED" or tostring(v368.Chance or 100) .. "%";
                v367.No.Text = tostring(i);
                local Entry = v367.Entry;
                local v369 = v368 and v368.Category and Customization[v368.Category];

                if v369 then
                    v369 = v369[v368.Item];
                end;

                local v370 = v368 and v368.Icon or (v369 and (v369.IconId or (v369.Icon or 130432201459489)) or 130432201459489);
                local v371;

                if typeof(v370) == "number" then
                    v371 = "rbxassetid://" .. tostring(v370);
                else
                    v371 = tostring(v370 or "");
                end;

                Entry.Image = v371;

                if u3.RenderReward then
                    u3.RenderReward(v367.Entry, v368);
                end;
            end;

            v367.Parent = p360;
            local Entry = v367:FindFirstChild("Entry");
            local v372 = {};
            local v373 = v367:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
            v373.Parent = v367;
            v372.Scale = v373;
            v372.Entry = Entry;
            v372.EntryRotation = Entry and (Entry.Rotation or 0) or 0;
            v372.Texts = {};

            if Entry then
                local v374 = Entry:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
                v374.Parent = Entry;
                v372.EntryScale = v374;
            end;

            local _ = i;

            for _, child in v367:GetChildren() do
                if child:IsA("TextLabel") then
                    table.insert(v372.Texts, {
                        Instance = child,
                        Transparency = child.TextTransparency
                    });
                end;
            end;

            table.insert(v365, v372);
        end;

        return v365;
    end;

    for _, child in u358.Strip:GetChildren() do
        if child:IsA("GuiObject") and child.Name == "Template" then
            local Entry = child:FindFirstChild("Entry");
            local StripItems = u358.StripItems;
            local v375 = {
                Scale = getScale(child),
                Entry = Entry,
                EntryRotation = Entry and Entry.Rotation or 0
            };
            table.insert(StripItems, v375);
        end;
    end;

    function u358.revealStrip(u376: number) -- Line: 2506
        -- upvalues: u358 (copy), u6 (copy), modalTween (copy)
        u358.Strip.Visible = true;

        for i, v in u358.StripItems do
            task.delay((i - 1) * u6.UNBOX_STRIP_STAGGER, function() -- Line: 2510
                -- upvalues: u358 (ref), u376 (copy), modalTween (ref), v (copy), u6 (ref)
                if not u358.isCurrent(u376) then
                    return;
                end;

                modalTween(u358, v.Scale, u6.ENTRY_ICON_INFO, {
                    Scale = 1
                });

                if v.Entry then
                    modalTween(u358, v.Entry, u6.ENTRY_ICON_INFO, {
                        Rotation = v.EntryRotation
                    });
                end;
            end);
        end;
    end;

    function u358.jiggleStrip(p377: number) -- Line: 2524
        -- upvalues: u358 (copy), modalTween (copy), u6 (copy)
        for _, v in u358.StripItems do
            v.Scale.Scale = p377;
            modalTween(u358, v.Scale, TweenInfo.new(u6.UNBOX_RATTLE_TIME, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Scale = 1
            });
        end;
    end;

    function u358.clearStrip(u378: number) -- Line: 2531
        -- upvalues: u358 (copy), u6 (copy), modalTween (copy)
        for i, v in u358.StripItems do
            task.delay((i - 1) * u6.CHEST_EXIT_STAGGER, function() -- Line: 2533
                -- upvalues: u358 (ref), u378 (copy), modalTween (ref), v (copy), u6 (ref)
                if u358.isCurrent(u378) then
                    modalTween(u358, v.Scale, u6.EXIT_INFO, {
                        Scale = 0
                    });
                end;
            end);
        end;
    end;

    function u358.isCurrent(p379: number) -- Line: 2541
        -- upvalues: u358 (copy)
        return u358.Playing and u358.Generation == p379;
    end;

    function u358.inBuildUp(p380: number) -- Line: 2545
        -- upvalues: u358 (copy)
        local v381 = u358.isCurrent(p380) and not u358.Opened;

        return v381;
    end;

    function u358.stopLoops() -- Line: 2549
        -- upvalues: u358 (copy)
        for _, v in u358.Loops do
            v:Cancel();
        end;

        table.clear(u358.Loops);
    end;

    function u358.loop(p382: userdata) -- Line: 2557
        -- upvalues: u358 (copy)
        table.insert(u358.Loops, p382);
    end;

    function u358.shake(p383: userdata, p384, p385: number?, p386: number, p387: number, p388: number, p389: number, p390: number, p391: number) -- Line: 2561
        -- upvalues: u358 (copy), RunService (copy)
        local v392 = 0;

        while v392 < p386 and u358.inBuildUp(p391) do
            v392 = v392 + RunService.RenderStepped:Wait();
            local math_clamp_ret = math.clamp(v392 / p386, 0, 1);
            local v393 = p387 + (p388 - p387) * math_clamp_ret;
            local v394 = p389 + (p390 - p389) * math_clamp_ret;
            p383.Position = p384 + UDim2.fromOffset((math.random() * 2 - 1) * v393, (math.random() * 2 - 1) * v393);

            if p385 then
                p383.Rotation = p385 + (math.random() * 2 - 1) * v394;
            end;
        end;

        if u358.Generation == p391 then
            p383.Position = p384;

            if p385 then
                p383.Rotation = p385;
            end;
        end;
    end;

    function u358.impact(u395: any, u396: number) -- Line: 2584
        -- upvalues: u358 (copy)
        task.spawn(function() -- Line: 2585
            -- upvalues: u395 (copy), u358 (ref), u396 (copy)
            for _, v in u395 do
                if not u358.isCurrent(u396) then
                    break;
                end;

                u358.Cg.Position = u358.BasePosition + UDim2.fromOffset(math.random(-v, v), math.random(-v, v));
                task.wait(0.02);
            end;

            if u358.Generation == u396 then
                u358.Cg.Position = u358.BasePosition;
            end;
        end);
    end;

    function u358.candyBurst() -- Line: 2599
        -- upvalues: u358 (copy), u6 (copy), Icon (copy), modalTween (copy)
        local Random_new_ret = Random.new();
        local v397 = u358.Cg.AbsoluteSize.X / math.max(u358.Cg.AbsoluteSize.Y, 1);

        for i = 1, u6.UNBOX_CANDY_COUNT do
            local ImageLabel = Instance.new("ImageLabel");
            ImageLabel.Name = "CandyBurst";
            ImageLabel.BackgroundTransparency = 1;
            ImageLabel.Image = Icon.Image;
            ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5);
            ImageLabel.Position = UDim2.fromScale(0.5, 0.5);
            ImageLabel.ZIndex = 3;
            local v398 = u6.UNBOX_CANDY_SIZE * Random_new_ret:NextNumber(0.6, 1.25);
            ImageLabel.Size = UDim2.fromScale(v398, v398 * v397);
            ImageLabel.Parent = u358.Cg;
            table.insert(u358.Particles, ImageLabel);
            local v399 = Random_new_ret:NextNumber(0, 6.283185307179586);
            local u400 = Random_new_ret:NextNumber(u6.UNBOX_CANDY_MIN_DISTANCE, u6.UNBOX_CANDY_MAX_DISTANCE);
            local Vector2_new_ret = Vector2.new(math.cos(v399), math.sin(v399) * v397);
            local u401 = Random_new_ret:NextNumber(0, 360);
            local u402 = Random_new_ret:NextNumber(-u6.UNBOX_CANDY_SPIN, u6.UNBOX_CANDY_SPIN);
            local NumberValue = Instance.new("NumberValue");
            NumberValue.Parent = ImageLabel;
            NumberValue.Changed:Connect(function(p403) -- Line: 2627
                -- upvalues: Vector2_new_ret (copy), u400 (copy), u6 (ref), ImageLabel (copy), u401 (copy), u402 (copy)
                local v404 = Vector2.new(0.5, 0.5) + Vector2_new_ret * u400 * (1 - (1 - p403) ^ 3) + Vector2.new(0, u6.UNBOX_CANDY_GRAVITY * p403 * p403);
                ImageLabel.Position = UDim2.fromScale(v404.X, v404.Y);
                ImageLabel.Rotation = u401 + u402 * p403;
                ImageLabel.ImageTransparency = p403 <= 0.6 and 0 or (p403 - 0.6) / 0.4;
            end);
            modalTween(u358, NumberValue, TweenInfo.new(Random_new_ret:NextNumber(u6.UNBOX_CANDY_MIN_LIFE, u6.UNBOX_CANDY_MAX_LIFE), Enum.EasingStyle.Linear), {
                Value = 1
            }).Completed:Once(function() -- Line: 2638
                -- upvalues: u358 (ref), ImageLabel (copy)
                local Particles = u358.Particles;
                local table_find_ret = table.find(Particles, ImageLabel);

                if table_find_ret then
                    table.remove(Particles, table_find_ret);
                end;

                ImageLabel:Destroy();
            end);
            local _ = i;
        end;
    end;

    function u358.reset() -- Line: 2645
        -- upvalues: u358 (copy), u14 (ref), u3 (copy), u6 (copy)
        local v405 = u358;

        for i in v405.Tweens do
            i:Cancel();
        end;

        table.clear(v405.Tweens);
        u14 = false;
        local v406 = u358;
        v406.Generation = v406.Generation + 1;

        if u3.ClearRewardPreview then
            u3.ClearRewardPreview(u358.Reward);

            for _, v in u358.StripItems do
                if v.Entry then
                    u3.ClearRewardPreview(v.Entry);
                end;
            end;
        end;

        u358.Playing = false;
        u358.ReadyToDismiss = false;
        u358.Opened = false;
        u358.Spinning = false;
        u358.hideSkip(true);
        u358.stopLoops();
        u358.stopShakeSound();
        local Particles = u358.Particles;

        for _, v in Particles do
            if v.Parent then
                v:Destroy();
            end;
        end;

        table.clear(Particles);
        u358.Cg.Visible = false;
        u358.Cg.GroupTransparency = 0;
        u358.Cg.Position = u358.BasePosition;
        u358.BgMask.GroupTransparency = u358.BgMaskTransparency;
        u358.Chest.Visible = true;
        u358.Chest.Position = u358.ChestPosition;
        u358.Chest.Rotation = u358.ChestRotation;
        u358.Chest.ImageTransparency = 0;
        local Chest2 = u358.Chest;
        local v407 = Chest2:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
        v407.Parent = Chest2;
        v407.Scale = 1;
        local Sunburst = u358.Sunburst;
        local v408 = Sunburst:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
        v408.Parent = Sunburst;
        v408.Scale = 0;
        local CounterSunburst = u358.CounterSunburst;
        local v409 = CounterSunburst:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
        v409.Parent = CounterSunburst;
        v409.Scale = 0;
        u358.Sunburst.Rotation = u358.SunburstRotation;
        u358.CounterSunburst.Rotation = u358.CounterRotation;
        u358.Reward.Visible = false;
        u358.Reward.Position = u358.RewardPosition;
        u358.Reward.Rotation = u358.RewardRotation;
        local Reward = u358.Reward;
        local v410 = Reward:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
        v410.Parent = Reward;
        v410.Scale = 0;
        u358.Strip.Visible = false;

        for _, v in u358.StripItems do
            v.Scale.Scale = 0;

            if v.Entry then
                v.Entry.Rotation = v.EntryRotation + u6.ENTRY_ICON_START_ROTATION;
            end;
        end;

        u358.Name.Visible = false;
        u358.Name.MaxVisibleGraphemes = -1;
        u358.Name.TextTransparency = u358.NameTransparency;
        local Name = u358.Name;
        local v411 = Name:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
        v411.Parent = Name;
        v411.Scale = 1;
    end;

    function u358.dismiss() -- Line: 2702
        -- upvalues: u358 (copy), modalTween (copy), u6 (copy)
        if not u358.ReadyToDismiss then
            return;
        end;

        u358.ReadyToDismiss = false;
        u358.Playing = false;
        local v412 = u358;
        v412.Generation = v412.Generation + 1;
        local Generation = u358.Generation;
        u358.stopLoops();
        local v413 = u358;

        for i in v413.Tweens do
            i:Cancel();
        end;

        table.clear(v413.Tweens);
        local Reward = u358.Reward;
        local v414 = Reward:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
        v414.Parent = Reward;
        modalTween(u358, v414, u6.EXIT_INFO, {
            Scale = 0
        });
        local Sunburst = u358.Sunburst;
        local v415 = Sunburst:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
        v415.Parent = Sunburst;
        modalTween(u358, v415, u6.EXIT_INFO, {
            Scale = 0
        });
        local CounterSunburst = u358.CounterSunburst;
        local v416 = CounterSunburst:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
        v416.Parent = CounterSunburst;
        modalTween(u358, v416, u6.EXIT_INFO, {
            Scale = 0
        });
        modalTween(u358, u358.Name, u6.EXIT_FADE_INFO, {
            TextTransparency = 1
        });
        modalTween(u358, u358.Cg, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            GroupTransparency = 1
        }).Completed:Once(function() -- Line: 2723
            -- upvalues: u358 (ref), Generation (copy)
            if u358.Generation == Generation then
                u358.reset();
            end;
        end);
    end;

    function u358.play(p417, p418, p419, p420) -- Line: 2730
        -- upvalues: u14 (ref), u16 (ref), u358 (copy), resetShopInteractions (copy), setRewardContents (copy), u3 (copy), modalTween (copy), u6 (copy)
        if u14 or not u16 then
            return;
        end;

        u358.reset();
        u14 = true;
        resetShopInteractions();
        u358.StripItems = setRewardContents(u358.Strip, p419);

        for _, v in u358.StripItems do
            v.Scale.Scale = 0;
        end;

        u358.Playing = true;
        local Generation = u358.Generation;
        local Chest2 = u358.Chest;
        (Chest2:FindFirstChildOfClass("UIScale") or Instance.new("UIScale")).Parent = Chest2;

        if p417 ~= nil then
            local Reward = u358.Reward;
            local v421;

            if typeof(p417) == "number" then
                v421 = "rbxassetid://" .. tostring(p417);
            else
                v421 = tostring(p417 or "");
            end;

            Reward.Image = v421;
        end;

        u358.Name.Text = string.upper((tostring(p418 or "REWARD")));

        if u3.RenderReward then
            if p420 then
                p419 = p420;
            elseif p419 then
                p419 = p419.Reward;
            end;

            u3.RenderReward(u358.Reward, p419);
        end;

        u358.Cg.Visible = true;
        u358.Cg.GroupTransparency = 1;
        u358.BgMask.GroupTransparency = 1;
        modalTween(u358, u358.Cg, u6.UNBOX_FADE_INFO, {
            GroupTransparency = 0
        });
        modalTween(u358, u358.BgMask, u6.UNBOX_FADE_INFO, {
            GroupTransparency = u358.BgMaskTransparency
        });
        u358.showSkip(Generation);
        u358.buildUp(Generation);

        if u358.inBuildUp(Generation) then
            u358.boom(Generation);
        end;
    end;

    function u358.startSpins() -- Line: 2769
        -- upvalues: u358 (copy), modalTween (copy), u6 (copy)
        if u358.Spinning then
            return;
        end;

        u358.Spinning = true;
        u358.loop((modalTween(u358, u358.Sunburst, TweenInfo.new(u6.UNBOX_SUNBURST_SPIN_TIME, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1), {
            Rotation = u358.SunburstRotation + 360
        })));
        u358.loop((modalTween(u358, u358.CounterSunburst, TweenInfo.new(u6.UNBOX_COUNTER_SPIN_TIME, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1), {
            Rotation = u358.CounterRotation - 360
        })));
    end;

    function u358.buildUp(p422: number) -- Line: 2785
        -- upvalues: u358 (copy), u6 (copy), modalTween (copy), u3 (copy)
        local Chest2 = u358.Chest;
        local v423 = Chest2:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
        v423.Parent = Chest2;
        local ChestPosition = u358.ChestPosition;
        Chest2.Position = UDim2.new(ChestPosition.X.Scale, ChestPosition.X.Offset, ChestPosition.Y.Scale + -u6.UNBOX_DROP_HEIGHT, ChestPosition.Y.Offset);
        modalTween(u358, Chest2, u6.UNBOX_DROP_INFO, {
            Position = u358.ChestPosition
        }).Completed:Wait();

        if not u358.inBuildUp(p422) then
            return;
        end;

        u3.Sound("Appear");
        v423.Scale = u6.UNBOX_LAND_SQUASH;
        modalTween(u358, v423, u6.UNBOX_LAND_INFO, {
            Scale = 1
        });
        u358.impact({
            u6.UNBOX_LAND_SHAKE,
            10,
            7,
            4,
            2
        }, p422);
        local Sunburst = u358.Sunburst;
        local v424 = Sunburst:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
        v424.Parent = Sunburst;
        modalTween(u358, v424, u6.UNBOX_SUNBURST_INFO, {
            Scale = u6.UNBOX_SUNBURST_IDLE_SCALE
        });
        local CounterSunburst = u358.CounterSunburst;
        local v425 = CounterSunburst:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
        v425.Parent = CounterSunburst;
        modalTween(u358, v425, u6.UNBOX_SUNBURST_INFO, {
            Scale = u6.UNBOX_SUNBURST_IDLE_SCALE
        });
        u358.startSpins();
        u358.revealStrip(p422);
        task.wait(u6.UNBOX_SETTLE_TIME);

        if not u358.inBuildUp(p422) then
            return;
        end;

        u358.startShakeSound();

        for _, v in u6.UNBOX_RATTLES do
            if not u358.inBuildUp(p422) then
                return;
            end;

            v423.Scale = v[3];
            u358.jiggleStrip(1 + (v[3] - 1) * u6.UNBOX_STRIP_JIGGLE);
            modalTween(u358, v423, TweenInfo.new(u6.UNBOX_RATTLE_TIME, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Scale = 1
            });
            u358.shake(Chest2, u358.ChestPosition, u358.ChestRotation, u6.UNBOX_RATTLE_TIME, v[1], 0, v[2], 0, p422);
            task.wait(u6.UNBOX_RATTLE_GAP);
        end;

        if not u358.inBuildUp(p422) then
            return;
        end;

        modalTween(u358, v423, TweenInfo.new(u6.UNBOX_CHARGE_TIME, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Scale = u6.UNBOX_CHARGE_SCALE
        });
        local TweenInfo_new_ret = TweenInfo.new(u6.UNBOX_CHARGE_TIME, Enum.EasingStyle.Quad, Enum.EasingDirection.In);
        local Sunburst2 = u358.Sunburst;
        local v426 = Sunburst2:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
        v426.Parent = Sunburst2;
        modalTween(u358, v426, TweenInfo_new_ret, {
            Scale = u6.UNBOX_SUNBURST_CHARGE_SCALE
        });
        local CounterSunburst2 = u358.CounterSunburst;
        local v427 = CounterSunburst2:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
        v427.Parent = CounterSunburst2;
        modalTween(u358, v427, TweenInfo_new_ret, {
            Scale = u6.UNBOX_SUNBURST_CHARGE_SCALE
        });
        u358.shake(Chest2, u358.ChestPosition, u358.ChestRotation, u6.UNBOX_CHARGE_TIME, 2, u6.UNBOX_CHARGE_PIXELS, 3, u6.UNBOX_CHARGE_DEGREES, p422);
    end;

    function u358.boom(u428: number) -- Line: 2844
        -- upvalues: u358 (copy), modalTween (copy), u3 (copy), playEntryFlash (copy), u6 (copy), RunService (copy)
        if not u358.isCurrent(u428) or u358.Opened then
            return;
        end;

        u358.Opened = true;
        u358.hideSkip();
        local Chest2 = u358.Chest;
        local v429 = Chest2:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
        v429.Parent = Chest2;
        modalTween(u358, Chest2, TweenInfo.new(0.05), {
            Position = u358.ChestPosition,
            Rotation = u358.ChestRotation
        });
        u358.startSpins();
        u358.stopShakeSound();
        u3.Sound("ChestOpen");
        playEntryFlash(u6.UNBOX_FLASH_TIME, u6.UNBOX_FLASH_PEAK, u6.FLASH_WHITE);
        u358.impact(u6.UNBOX_IMPACT, u428);
        modalTween(u358, v429, u6.UNBOX_BURST_INFO, {
            Scale = u6.UNBOX_BURST_SCALE
        });
        modalTween(u358, Chest2, u6.UNBOX_BURST_INFO, {
            ImageTransparency = 1
        }).Completed:Once(function() -- Line: 2864
            -- upvalues: u358 (ref), u428 (copy), Chest2 (copy)
            if u358.isCurrent(u428) then
                Chest2.Visible = false;
            end;
        end);
        u358.candyBurst();
        u358.clearStrip(u428);
        local Sunburst = u358.Sunburst;
        local v430 = Sunburst:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
        v430.Parent = Sunburst;
        v430.Scale = u6.UNBOX_SUNBURST_BOOM_SCALE;
        local CounterSunburst = u358.CounterSunburst;
        local v431 = CounterSunburst:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
        v431.Parent = CounterSunburst;
        v431.Scale = u6.UNBOX_SUNBURST_BOOM_SCALE;
        local Sunburst2 = u358.Sunburst;
        local v432 = Sunburst2:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
        v432.Parent = Sunburst2;
        modalTween(u358, v432, u6.UNBOX_SUNBURST_INFO, {
            Scale = 1
        }).Completed:Once(function() -- Line: 2876
            -- upvalues: u358 (ref), u428 (copy), modalTween (ref), u6 (ref)
            if u358.isCurrent(u428) then
                local loop = u358.loop;
                local Sunburst3 = u358.Sunburst;
                local v433 = Sunburst3:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
                v433.Parent = Sunburst3;
                loop((modalTween(u358, v433, u6.UNBOX_SUNBURST_BREATHE_INFO, {
                    Scale = u6.UNBOX_SUNBURST_BREATHE_SCALE
                })));
            end;
        end);
        local CounterSunburst2 = u358.CounterSunburst;
        local v434 = CounterSunburst2:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
        v434.Parent = CounterSunburst2;
        modalTween(u358, v434, u6.UNBOX_SUNBURST_INFO, {
            Scale = 1
        });
        u3.Sound("Cash");
        local Reward = u358.Reward;
        local v435 = Reward:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
        v435.Parent = Reward;
        u358.Reward.Visible = true;
        u358.Reward.Rotation = u358.RewardRotation + u6.UNBOX_REWARD_START_ROTATION;
        v435.Scale = 0;
        modalTween(u358, v435, u6.UNBOX_REWARD_INFO, {
            Scale = 1
        });
        modalTween(u358, u358.Reward, u6.UNBOX_REWARD_INFO, {
            Rotation = u358.RewardRotation
        }).Completed:Once(function() -- Line: 2894
            -- upvalues: u358 (ref), u428 (copy), modalTween (ref), u6 (ref)
            if u358.isCurrent(u428) then
                u358.loop((modalTween(u358, u358.Reward, u6.UNBOX_REWARD_BOB_INFO, {
                    Position = u358.RewardPosition + UDim2.fromOffset(0, -u6.UNBOX_REWARD_BOB)
                })));
            end;
        end);
        task.delay(u6.UNBOX_NAME_DELAY, function() -- Line: 2902
            -- upvalues: u358 (ref), u428 (copy), modalTween (ref), u6 (ref), RunService (ref)
            if not u358.isCurrent(u428) then
                return;
            end;

            local Name = u358.Name;
            local v436 = Name:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
            v436.Parent = Name;
            u358.Name.Visible = true;
            v436.Scale = 0.6;
            modalTween(u358, v436, u6.TITLE_POP_INFO, {
                Scale = 1
            });
            local v437 = utf8.len(u358.Name.ContentText) or #u358.Name.ContentText;
            u358.Name.MaxVisibleGraphemes = 0;
            local v438 = 0;

            while v438 < u6.UNBOX_NAME_TYPE_TIME and u358.isCurrent(u428) do
                v438 = v438 + RunService.RenderStepped:Wait();
                local Name2 = u358.Name;
                local v439 = v437 * math.clamp(v438 / u6.UNBOX_NAME_TYPE_TIME, 0, 1) + 0.5;
                Name2.MaxVisibleGraphemes = math.floor(v439);
            end;

            if u358.isCurrent(u428) then
                u358.Name.MaxVisibleGraphemes = -1;
            end;
        end);
        task.delay(u6.UNBOX_HOLD_TIME, function() -- Line: 2926
            -- upvalues: u358 (ref), u428 (copy)
            if u358.isCurrent(u428) then
                u358.ReadyToDismiss = true;
                u358.dismiss();
            end;
        end);
    end;

    u358.SkipButton = u358.Cg:FindFirstChild("SkipSpin");

    if u358.SkipButton then
        u358.SkipButton.ZIndex = u358.Catcher.ZIndex + 1;
        u358.SkipChannels = createScaleChannels(u358.SkipButton);
        local Container = u358.SkipButton:FindFirstChild("Container");
        local v440 = Container and Container:FindFirstChild("Shine");
        u358.SkipShine = v440;
        u358.SkipShinePosition = u358.SkipShine and u358.SkipShine.Position;
    end;

    function u358.sweepSkipShine() -- Line: 2947
        -- upvalues: u358 (copy), u6 (copy), modalTween (copy)
        local SkipShine = u358.SkipShine;

        if not SkipShine then
            return;
        end;

        local SkipShinePosition = u358.SkipShinePosition;
        SkipShine.Position = UDim2.new(-u6.UNBOX_SKIP_SHINE_MARGIN, 0, SkipShinePosition.Y.Scale, SkipShinePosition.Y.Offset);
        modalTween(u358, SkipShine, u6.UNBOX_SKIP_SHINE_INFO, {
            Position = UDim2.new(1 + u6.UNBOX_SKIP_SHINE_MARGIN, 0, SkipShinePosition.Y.Scale, SkipShinePosition.Y.Offset)
        });
    end;

    function u358.showSkip(u441: number) -- Line: 2960
        -- upvalues: u358 (copy), u6 (copy), modalTween (copy)
        local SkipButton = u358.SkipButton;

        if not SkipButton then
            return;
        end;

        SkipButton.Visible = true;
        SkipButton.Interactable = true;
        u358.SkipChannels.Reveal.Value = 0;
        u358.SkipChannels.Interact.Value = 1;

        if u358.SkipShine then
            u358.SkipShine.Position = UDim2.new(-u6.UNBOX_SKIP_SHINE_MARGIN, 0, u358.SkipShinePosition.Y.Scale, u358.SkipShinePosition.Y.Offset);
        end;

        task.delay(u6.UNBOX_SKIP_DELAY, function() -- Line: 2976
            -- upvalues: u358 (ref), u441 (copy), modalTween (ref), u6 (ref)
            if u358.inBuildUp(u441) then
                modalTween(u358, u358.SkipChannels.Reveal, u6.ENTRY_ICON_INFO, {
                    Value = 1
                });
            end;
        end);
        u358.SkipThread = task.spawn(function() -- Line: 2982
            -- upvalues: u6 (ref), u358 (ref), u441 (copy)
            task.wait(u6.UNBOX_SKIP_DELAY + 0.3);

            while u358.inBuildUp(u441) do
                u358.sweepSkipShine();
                task.wait(u6.UNBOX_SKIP_SHINE_INTERVAL);
            end;
        end);
    end;

    function u358.hideSkip(p442: boolean?) -- Line: 2992
        -- upvalues: u358 (copy), modalTween (copy), u6 (copy)
        if u358.SkipThread and (coroutine.status(u358.SkipThread) ~= "dead" and coroutine.running() ~= u358.SkipThread) then
            task.cancel(u358.SkipThread);
        end;

        u358.SkipThread = nil;

        if not u358.SkipButton then
            return;
        end;

        u358.SkipButton.Interactable = false;

        if not p442 then
            modalTween(u358, u358.SkipChannels.Reveal, u6.EXIT_INFO, {
                Value = 0
            });

            return;
        end;

        u358.SkipButton.Visible = false;
        u358.SkipChannels.Reveal.Value = 0;
        u358.SkipChannels.Interact.Value = 1;
    end;

    if u358.SkipButton then
        local Interact = u358.SkipChannels.Interact;
        local u443 = false;
        u358.SkipButton.MouseEnter:Connect(function() -- Line: 3017
            -- upvalues: u443 (ref), u358 (copy), u3 (copy), modalTween (copy), Interact (copy), u6 (copy)
            u443 = true;

            if u358.Playing and not u358.Opened then
                u3.Sound("UIHover");
                modalTween(u358, Interact, u6.BUTTON_HOVER_INFO, {
                    Value = u6.BUTTON_HOVER_SCALE
                });
            end;
        end);
        u358.SkipButton.MouseLeave:Connect(function() -- Line: 3026
            -- upvalues: u443 (ref), modalTween (copy), u358 (copy), Interact (copy), u6 (copy)
            u443 = false;
            modalTween(u358, Interact, u6.BUTTON_LEAVE_INFO, {
                Value = 1
            });
        end);
        u358.SkipButton.MouseButton1Down:Connect(function() -- Line: 3031
            -- upvalues: modalTween (copy), u358 (copy), Interact (copy), u6 (copy)
            modalTween(u358, Interact, u6.BUTTON_PRESS_INFO, {
                Value = u6.BUTTON_PRESS_SCALE
            });
        end);
        u358.SkipButton.MouseButton1Up:Connect(function() -- Line: 3035
            -- upvalues: modalTween (copy), u358 (copy), Interact (copy), u6 (copy), u443 (ref)
            modalTween(u358, Interact, u6.BUTTON_RELEASE_INFO, {
                Value = u443 and u6.BUTTON_HOVER_SCALE or 1
            });
        end);
        u358.SkipButton.Activated:Connect(function() -- Line: 3039
            -- upvalues: u358 (copy), u3 (copy)
            if not u358.Playing or u358.Opened then
                return;
            end;

            u3.Sound("UIClick");
            task.spawn(u358.boom, u358.Generation);
        end);
    end;

    local u444 = {
        Tweens = {},
        Frame = HalloweenEvent:WaitForChild("ChancesFrame")
    };
    u444.Holder = u444.Frame:WaitForChild("Holder");
    u444.Scale = getScale(u444.Frame);
    u444.CloseButton = u444.Holder:WaitForChild("Header"):WaitForChild("CloseButton");
    u444.Open = false;
    u444.Generation = 0;
    u444.Templates = {};
    u444.Cobwebs = {};

    for _, child in u444.Holder:WaitForChild("Contents"):GetChildren() do
        if child:IsA("GuiObject") and child.Name == "Template" then
            local v445 = {
                Entry = child:FindFirstChild("Entry"),
                Texts = {}
            };

            if v445.Entry then
                v445.EntryScale = getScale(v445.Entry);
                v445.EntryRotation = v445.Entry.Rotation;
            end;

            for _, child2 in child:GetChildren() do
                if child2:IsA("TextLabel") then
                    table.insert(v445.Texts, {
                        Instance = child2,
                        Transparency = child2.TextTransparency
                    });
                end;
            end;

            table.insert(u444.Templates, v445);
        end;
    end;

    for _, child in u444.Holder:GetChildren() do
        if child:IsA("ImageLabel") and child.Name == "Cobweb" then
            local v446 = getScale(child);
            table.insert(u444.Cobwebs, {
                Scale = v446,
                BaseScale = v446.Scale
            });
        end;
    end;

    u444.Backdrop = Instance.new("TextButton");
    u444.Backdrop.Name = "ChancesBackdrop";
    u444.Backdrop.Text = "";
    u444.Backdrop.AutoButtonColor = false;
    u444.Backdrop.BackgroundColor3 = Color3.new(0, 0, 0);
    u444.Backdrop.BackgroundTransparency = 1;
    u444.Backdrop.BorderSizePixel = 0;
    u444.Backdrop.AnchorPoint = Vector2.new(0.5, 0.5);
    u444.Backdrop.Position = UDim2.fromScale(0.5, 0.5);
    u444.Backdrop.Size = UDim2.fromScale(1, 1);
    u444.Backdrop.ZIndex = u444.Frame.ZIndex - 1;
    u444.Backdrop.Visible = false;
    u444.Backdrop.Parent = HalloweenEvent;

    function u444.hide() -- Line: 3102
        -- upvalues: u444 (copy), u14 (ref)
        local v447 = u444;

        for i in v447.Tweens do
            i:Cancel();
        end;

        table.clear(v447.Tweens);
        u14 = false;
        u444.Open = false;
        local v448 = u444;
        v448.Generation = v448.Generation + 1;
        u444.Frame.Visible = false;
        u444.Backdrop.Visible = false;
        u444.Backdrop.BackgroundTransparency = 1;
        u444.Holder.GroupTransparency = 0;
        u444.Scale.Scale = 1;
    end;

    function u444.open(p449) -- Line: 3115
        -- upvalues: u14 (ref), u16 (ref), resetShopInteractions (copy), u444 (copy), setRewardContents (copy), modalTween (copy), u6 (copy)
        if u14 or not u16 then
            return;
        end;

        u14 = true;
        resetShopInteractions();
        u444.Templates = setRewardContents(u444.Holder.Contents, p449);
        u444.Open = true;
        local v450 = u444;
        v450.Generation = v450.Generation + 1;
        local Generation = u444.Generation;

        local function isCurrent() -- Line: 3128
            -- upvalues: u444 (ref), Generation (copy)
            return u444.Open and u444.Generation == Generation;
        end;

        u444.Item = p449;
        u444.Backdrop.Visible = true;
        u444.Backdrop.BackgroundTransparency = 1;
        modalTween(u444, u444.Backdrop, u6.CHANCES_FADE_INFO, {
            BackgroundTransparency = u6.CHANCES_BACKDROP_TRANSPARENCY
        });
        u444.Frame.Visible = true;
        u444.Holder.GroupTransparency = 1;
        u444.Scale.Scale = u6.CHANCES_START_SCALE;
        modalTween(u444, u444.Holder, u6.CHANCES_FADE_INFO, {
            GroupTransparency = 0
        });
        modalTween(u444, u444.Scale, u6.SHOP_INTRO_INFO, {
            Scale = 1
        });
        local CloseButton2 = u444.CloseButton;
        local u451 = CloseButton2:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
        u451.Parent = CloseButton2;
        u451.Scale = 0;
        u444.CloseButton.Rotation = -90;
        task.delay(0.15, function() -- Line: 3149
            -- upvalues: u444 (ref), Generation (copy), modalTween (ref), u451 (copy), u6 (ref)
            if u444.Open and u444.Generation == Generation then
                modalTween(u444, u451, u6.CLOSE_POP_INFO, {
                    Scale = 1
                });
                modalTween(u444, u444.CloseButton, u6.CLOSE_POP_INFO, {
                    Rotation = 0
                });
            end;
        end);

        for i, v in u444.Cobwebs do
            v.Scale.Scale = 0;
            task.delay(0.1 + (i - 1) * u6.COBWEB_STAGGER, function() -- Line: 3159
                -- upvalues: u444 (ref), Generation (copy), modalTween (ref), v (copy), u6 (ref)
                if u444.Open and u444.Generation == Generation then
                    modalTween(u444, v.Scale, u6.COBWEB_INTRO_INFO, {
                        Scale = v.BaseScale
                    });
                end;
            end);
        end;

        for i, v in u444.Templates do
            if v.Entry then
                v.EntryScale.Scale = 0;
                v.Entry.Rotation = v.EntryRotation + u6.ENTRY_ICON_START_ROTATION;
            end;

            local u452 = v;

            for _, v2 in v.Texts do
                v2.Instance.TextTransparency = 1;
            end;

            task.delay(u6.CHANCES_ENTRY_DELAY + (i - 1) * u6.CHANCES_ENTRY_STAGGER, function() -- Line: 3176
                -- upvalues: u444 (ref), Generation (copy), u452 (copy), modalTween (ref), u6 (ref)
                if not (u444.Open and u444.Generation == Generation) then
                    return;
                end;

                if u452.Entry then
                    modalTween(u444, u452.EntryScale, u6.ENTRY_ICON_INFO, {
                        Scale = 1
                    });
                    modalTween(u444, u452.Entry, u6.ENTRY_ICON_INFO, {
                        Rotation = u452.EntryRotation
                    });
                end;

                for _, v2 in u452.Texts do
                    modalTween(u444, v2.Instance, u6.FADE_INFO, {
                        TextTransparency = v2.Transparency
                    });
                end;
            end);
        end;
    end;

    function u444.close() -- Line: 3193
        -- upvalues: u444 (copy), modalTween (copy), u6 (copy)
        if not u444.Open then
            return;
        end;

        u444.Open = false;
        local v453 = u444;
        v453.Generation = v453.Generation + 1;
        local v454 = u444;

        for i in v454.Tweens do
            i:Cancel();
        end;

        table.clear(v454.Tweens);
        local Generation = u444.Generation;
        modalTween(u444, u444.Scale, u6.EXIT_INFO, {
            Scale = u6.CHANCES_START_SCALE
        });
        modalTween(u444, u444.Holder, u6.EXIT_FADE_INFO, {
            GroupTransparency = 1
        });
        modalTween(u444, u444.Backdrop, u6.CHANCES_FADE_INFO, {
            BackgroundTransparency = 1
        }).Completed:Once(function() -- Line: 3207
            -- upvalues: u444 (ref), Generation (copy)
            if u444.Generation == Generation then
                u444.hide();
            end;
        end);
    end;

    setupButton(u444.CloseButton, u444.close);
    u444.Backdrop.Activated:Connect(function() -- Line: 3216
        -- upvalues: u444 (copy), u3 (copy)
        if u444.Open then
            u3.Sound("UIClick");
            u444.close();
        end;
    end);

    local function resetAll() -- Line: 3225
        -- upvalues: stopLoops (copy), u358 (copy), u444 (copy), u163 (copy), u149 (copy), Frame (copy), Eyeglow (copy), u21 (copy), u145 (copy), u10 (copy), UIScale (copy), u6 (copy), Main (copy), u11 (copy), Frame2 (copy), HalloweenEvent (copy), Position (copy), BgMask (copy), Texture (copy), Flame (copy), Position5 (copy), Rotation (copy), ImageTransparency (copy), Image (copy), u8 (copy), Character (copy), Position4 (copy), u148 (copy), u156 (copy), CandyFrame (copy), Position3 (copy), CloseButton (copy), resetTitle (copy), Content (copy), Position6 (copy), ShopCg (copy), Tag2 (copy), resetBatChest (copy)
        stopLoops();
        u358.reset();
        u444.hide();
        local v455 = u163;

        for _, v in v455 do
            if v.Parent then
                v:Destroy();
            end;
        end;

        table.clear(v455);
        local v456 = u149;

        for _, v in v456 do
            if v.Parent then
                v:Destroy();
            end;
        end;

        table.clear(v456);
        Frame.BackgroundTransparency = 1;

        if Eyeglow then
            Eyeglow.Transparency = 1;
        end;

        local v457 = u21;

        for _, v in v457 do
            if v.Parent then
                v:Destroy();
            end;
        end;

        table.clear(v457);
        local v458 = u145;

        for _, v in v458 do
            if v.Parent then
                v:Destroy();
            end;
        end;

        table.clear(v458);
        u10.Visible = false;
        UIScale.Scale = u6.JUMPSCARE_START_SCALE;
        Main.ImageTransparency = 0;

        for _, v in u11 do
            v.BackgroundTransparency = 0;
        end;

        Frame2.BackgroundTransparency = 1;
        HalloweenEvent.Position = Position;
        BgMask.GroupTransparency = 1;
        local v459 = Texture;
        local v460 = v459:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
        v460.Parent = v459;
        v460.Scale = 1;
        local v461 = Position5;
        Flame.Position = UDim2.new(v461.X.Scale, v461.X.Offset, v461.Y.Scale + u6.FLAME_RISE, v461.Y.Offset);
        Flame.Rotation = Rotation;
        Flame.ImageTransparency = ImageTransparency;
        Flame.Image = Image;

        for _, v in u8 do
            local Instance2 = v.Instance;
            local v462 = Instance2:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
            v462.Parent = Instance2;
            v462.Scale = 0;
        end;

        Character.Position = Position4;
        local v463 = Character;
        local v464 = v463:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
        v464.Parent = v463;
        v464.Scale = 1;

        for i, v in u148 do
            if i.Parent then
                i.Position = v;
                i.Rotation = u156[i];
            end;
        end;

        local v465 = Position3;
        CandyFrame.Position = UDim2.new(v465.X.Scale, v465.X.Offset, v465.Y.Scale + u6.CANDY_START_Y_OFFSET, v465.Y.Offset);
        local v466 = CloseButton;
        local v467 = v466:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
        v467.Parent = v466;
        v467.Scale = 0;
        CloseButton.Rotation = -90;
        resetTitle();
        local v468 = Position6;
        Content.Position = UDim2.new(v468.X.Scale, v468.X.Offset, v468.Y.Scale + u6.SHOP_RISE * Content.Size.Y.Scale, v468.Y.Offset);
        ShopCg.GroupTransparency = 1;
        local v469 = Content;
        local v470 = v469:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
        v470.Parent = v469;
        v470.Scale = u6.SHOP_START_SCALE;
        local v471 = Tag2;
        local v472 = v471:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
        v472.Parent = v471;
        v472.Scale = 0;
        resetBatChest();
    end;

    local function playEntrance(u473: number) -- Line: 3271
        -- upvalues: playEntryFlash (copy), u6 (copy), playCharacterJolt (copy), playTitleReveal (copy), playShopReveal (copy), playCandyReveal (copy), u16 (ref), u18 (ref), CloseButton (copy), TweenService (copy)
        playEntryFlash(u6.FLASH_TIME * 0.6, u6.FLASH_PEAK + 0.3, u6.FLASH_AMBER);
        playCharacterJolt(u473);
        playTitleReveal(u473);
        playShopReveal(u473);
        playCandyReveal(u473);
        task.delay(0.2, function() -- Line: 3279
            -- upvalues: u473 (copy), u16 (ref), u18 (ref), CloseButton (ref), u6 (ref), TweenService (ref)
            if not (u16 and u473 == u18) then
                return;
            end;

            local v474 = CloseButton;
            local v475 = v474:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
            v475.Parent = v474;
            TweenService:Create(v475, u6.CLOSE_POP_INFO, {
                Scale = 1
            }):Play();
            TweenService:Create(CloseButton, u6.CLOSE_POP_INFO, {
                Rotation = 0
            }):Play();
        end);
    end;

    local u476;

    if p2 then
        u476 = {
            Hovering = false,
            Channels = createScaleChannels(p2),
            Button = p2:FindFirstChild("ImageButton"),
            Sunburst = p2:FindFirstChild("Sunburst"),
            Character = p2:FindFirstChild("Character"),
            Alert = p2:FindFirstChild("Alert"),
            Floaters = {}
        };

        for _, child in p2:GetChildren() do
            if child:IsA("ImageLabel") and (child.Name == "Character" or child.Name == "Candy") then
                table.insert(u476.Floaters, {
                    Instance = child,
                    Position = child.Position,
                    Rotation = child.Rotation,
                    Wobble = child.Name == "Candy"
                });
            end;
        end;
    else
        u476 = nil;
    end;

    local function startHudButtonIdle() -- Line: 3322
        -- upvalues: u476 (ref), u6 (copy), TweenService (copy)
        local u477 = u476;

        if u477.Sunburst then
            TweenService:Create(u477.Sunburst, TweenInfo.new(u6.HUD_SUNBURST_SPIN_TIME, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1), {
                Rotation = u477.Sunburst.Rotation + 360
            }):Play();
        end;

        if u477.Alert then
            local Alert = u477.Alert;
            local v478 = Alert:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
            v478.Parent = Alert;
            TweenService:Create(v478, u6.HUD_ALERT_PULSE_INFO, {
                Scale = u6.HUD_ALERT_PULSE_SCALE
            }):Play();
        end;

        for _, v in u477.Floaters do
            local Random_new_ret = Random.new();
            local TweenInfo_new_ret = TweenInfo.new(Random_new_ret:NextNumber(u6.HUD_BOB_MIN_TIME, u6.HUD_BOB_MAX_TIME), Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true);

            if v.Instance ~= u477.Character then
                TweenService:Create(v.Instance, TweenInfo_new_ret, {
                    Position = v.Position + UDim2.fromOffset(0, -u6.HUD_BOB_PIXELS)
                }):Play();
            end;

            if v.Wobble then
                v.Instance.Rotation = v.Rotation - u6.HUD_CANDY_WOBBLE;
                TweenService:Create(v.Instance, TweenInfo.new(Random_new_ret:NextNumber(u6.HUD_BOB_MIN_TIME, u6.HUD_BOB_MAX_TIME), Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
                    Rotation = v.Rotation + u6.HUD_CANDY_WOBBLE
                }):Play();
            end;
        end;

        if u477.Character then
            task.spawn(function() -- Line: 3355
                -- upvalues: u477 (copy), u6 (ref), TweenService (ref)
                local Random_new_ret = Random.new();
                local Position7 = u477.Character.Position;
                local v479 = true;

                while u477.Character.Parent do
                    if u477.Hovering then
                        task.wait(0.15);
                    else
                        local v480 = TweenService:Create(u477.Character, TweenInfo.new(Random_new_ret:NextNumber(u6.HUD_BOB_MIN_TIME, u6.HUD_BOB_MAX_TIME), Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                            Position = Position7 + UDim2.fromOffset(0, v479 and -u6.HUD_BOB_PIXELS or u6.HUD_BOB_PIXELS)
                        });
                        v480:Play();
                        v480.Completed:Wait();
                        v479 = not v479;
                    end;
                end;
            end);
        end;
    end;

    local function setupHudButton() -- Line: 3378
        -- upvalues: u476 (ref), u3 (copy), u6 (copy), TweenService (copy), startHudButtonIdle (copy)
        local u481 = u476;

        if not (u481 and (u481.Button and not u481.Setup)) then
            return;
        end;

        u481.Setup = true;
        local Button = u481.Button;
        local Character2 = u481.Character;
        local u482;

        if Character2 then
            u482 = Character2:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
            u482.Parent = Character2;
        else
            u482 = Character2;
        end;

        local u483;

        if Character2 then
            u483 = Character2.Position;
        else
            u483 = Character2;
        end;

        Button.MouseEnter:Connect(function() -- Line: 3392
            -- upvalues: u481 (copy), u3 (ref), u6 (ref), TweenService (ref), Character2 (copy), u482 (copy)
            u481.Hovering = true;
            u3.Sound("UIHover");
            TweenService:Create(u481.Channels.Interact, u6.BUTTON_HOVER_INFO, {
                Value = u6.HUD_HOVER_SCALE
            }):Play();

            if Character2 then
                TweenService:Create(u482, u6.BUTTON_HOVER_INFO, {
                    Scale = u6.HUD_CHARACTER_HOVER_SCALE
                }):Play();
                TweenService:Create(Character2, u6.BUTTON_HOVER_INFO, {
                    Rotation = math.random(0, 1) == 0 and -u6.HUD_CHARACTER_HOVER_TILT or u6.HUD_CHARACTER_HOVER_TILT
                }):Play();
            end;
        end);
        Button.MouseLeave:Connect(function() -- Line: 3406
            -- upvalues: u481 (copy), u6 (ref), TweenService (ref), Character2 (copy), u482 (copy), u483 (copy)
            u481.Hovering = false;
            TweenService:Create(u481.Channels.Interact, u6.BUTTON_LEAVE_INFO, {
                Value = 1
            }):Play();

            if Character2 then
                TweenService:Create(u482, u6.BUTTON_LEAVE_INFO, {
                    Scale = 1
                }):Play();
                TweenService:Create(Character2, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                    Rotation = 0,
                    Position = u483
                }):Play();
            end;
        end);
        Button.MouseButton1Down:Connect(function() -- Line: 3420
            -- upvalues: u481 (copy), u6 (ref), TweenService (ref)
            TweenService:Create(u481.Channels.Interact, u6.BUTTON_PRESS_INFO, {
                Value = u6.BUTTON_PRESS_SCALE
            }):Play();
        end);
        Button.MouseButton1Up:Connect(function() -- Line: 3424
            -- upvalues: u481 (copy), u6 (ref), TweenService (ref)
            TweenService:Create(u481.Channels.Interact, u6.BUTTON_RELEASE_INFO, {
                Value = u481.Hovering and u6.HUD_HOVER_SCALE or 1
            }):Play();
        end);
        Button.Activated:Connect(function() -- Line: 3428
            -- upvalues: u3 (ref)
            u3.Sound("UIClick");
            u3.Open();
        end);
        startHudButtonIdle();
    end;

    local function hideHudButton() -- Line: 3437
        -- upvalues: u476 (ref), u6 (copy), TweenService (copy)
        if u476 then
            u476.Hovering = false;
            u476.Channels.Interact.Value = 1;
            TweenService:Create(u476.Channels.Reveal, u6.EXIT_INFO, {
                Value = 0
            }):Play();
        end;
    end;

    local function showHudButton() -- Line: 3445
        -- upvalues: u476 (ref), u6 (copy), TweenService (copy)
        if u476 then
            TweenService:Create(u476.Channels.Reveal, u6.HUD_SHOW_INFO, {
                Value = 1
            }):Play();
        end;
    end;

    function u5.Open() -- Line: 3452
        -- upvalues: u16 (ref), u17 (ref), u18 (ref), u3 (copy), u476 (ref), u6 (copy), TweenService (copy), resetAll (copy), populateShop (copy), HalloweenEvent (copy), playBackdrop (copy), playJumpScare (copy), playEntrance (copy)
        if u16 or u17 then
            return;
        end;

        u16 = true;
        u17 = true;
        u18 = u18 + 1;
        local v484 = u18;
        u3.Hide();

        if u476 then
            u476.Hovering = false;
            u476.Channels.Interact.Value = 1;
            TweenService:Create(u476.Channels.Reveal, u6.EXIT_INFO, {
                Value = 0
            }):Play();
        end;

        resetAll();
        populateShop();
        HalloweenEvent.Visible = true;
        HalloweenEvent.GroupTransparency = 0;
        playBackdrop(v484);
        playJumpScare(v484);

        if not (u16 and v484 == u18) then
            return;
        end;

        playEntrance(v484);
        task.wait(u6.JUMPSCARE_HOLD);
        u17 = false;
    end;

    function u5.Close() -- Line: 3497
        -- upvalues: u358 (copy), u444 (copy), u16 (ref), u17 (ref), u18 (ref), stopLoops (copy), u146 (copy), u6 (copy), TweenService (copy), u314 (copy), Content (copy), ShopCg (copy), TextFrame (copy), Position2 (copy), animateLineErase (copy), UIGradient (copy), UIGradient2 (copy), u144 (copy), Character (copy), CandyFrame (copy), Position3 (copy), CloseButton (copy), Flame (copy), Position5 (copy), u8 (copy), HalloweenEvent (copy), resetAll (copy), u157 (copy), u3 (copy), u476 (ref)
        u358.reset();
        u444.hide();

        if not u16 or u17 then
            return;
        end;

        u16 = false;
        u17 = true;
        u18 = u18 + 1;
        local u485 = u18;
        stopLoops();

        for _, v in u146 do
            v.Revealed = false;
            TweenService:Create(v.Channels.Reveal, u6.EXIT_FADE_INFO, {
                Value = 0
            }):Play();
        end;

        u314.Revealed = false;
        TweenService:Create(u314.ChestChannels.Reveal, u6.EXIT_INFO, {
            Value = 0
        }):Play();
        TweenService:Create(u314.ChestChannels.Interact, u6.EXIT_INFO, {
            Value = 1
        }):Play();

        for i, v in u314.Entries do
            task.delay((i - 1) * u6.CHEST_EXIT_STAGGER, function() -- Line: 3524
                -- upvalues: u485 (copy), u18 (ref), v (copy), u6 (ref), TweenService (ref)
                if u485 == u18 then
                    TweenService:Create(v.Scale, u6.EXIT_INFO, {
                        Scale = 0
                    }):Play();
                end;
            end);
        end;

        if u314.CandyChannels then
            TweenService:Create(u314.CandyChannels.Reveal, u6.EXIT_INFO, {
                Value = 0
            }):Play();
        end;

        local v486 = Content;
        local v487 = v486:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
        v487.Parent = v486;
        TweenService:Create(v487, u6.EXIT_INFO, {
            Scale = u6.SHOP_START_SCALE
        }):Play();
        TweenService:Create(ShopCg, u6.EXIT_FADE_INFO, {
            GroupTransparency = 1
        }):Play();
        local TweenInfo_new_ret = TweenInfo.new(0.24, Enum.EasingStyle.Back, Enum.EasingDirection.In);
        local v488 = {};
        local v489 = Position2;
        v488.Position = UDim2.new(v489.X.Scale, v489.X.Offset, v489.Y.Scale + u6.TEXT_FRAME_START_Y_OFFSET, v489.Y.Offset);
        TweenService:Create(TextFrame, TweenInfo_new_ret, v488):Play();
        task.spawn(animateLineErase, UIGradient, u485);
        task.spawn(animateLineErase, UIGradient2, u485);

        for _, v in u144 do
            if v.Spider and v.Spider.Visible then
                local Spider = v.Spider;
                local v490 = Spider:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
                v490.Parent = Spider;
                TweenService:Create(v490, u6.EXIT_INFO, {
                    Scale = 0
                }):Play();
            end;
        end;

        local v491 = Character;
        local v492 = v491:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
        v492.Parent = v491;
        TweenService:Create(v492, u6.EXIT_INFO, {
            Scale = 0
        }):Play();
        local EXIT_INFO = u6.EXIT_INFO;
        local v493 = {};
        local v494 = Position3;
        v493.Position = UDim2.new(v494.X.Scale, v494.X.Offset, v494.Y.Scale + u6.CANDY_START_Y_OFFSET, v494.Y.Offset);
        TweenService:Create(CandyFrame, EXIT_INFO, v493):Play();
        local v495 = CloseButton;
        local v496 = v495:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
        v496.Parent = v495;
        TweenService:Create(v496, u6.EXIT_INFO, {
            Scale = 0
        }):Play();
        local EXIT_INFO2 = u6.EXIT_INFO;
        local v497 = {};
        local v498 = Position5;
        v497.Position = UDim2.new(v498.X.Scale, v498.X.Offset, v498.Y.Scale + u6.FLAME_RISE, v498.Y.Offset);
        TweenService:Create(Flame, EXIT_INFO2, v497):Play();

        for _, v in u8 do
            local Instance2 = v.Instance;
            local v499 = Instance2:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
            v499.Parent = Instance2;
            TweenService:Create(v499, u6.EXIT_INFO, {
                Scale = 0
            }):Play();
        end;

        local v500 = TweenService:Create(HalloweenEvent, TweenInfo.new(u6.EVENT_FADE_TIME, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            GroupTransparency = 1
        });
        v500:Play();
        v500.Completed:Wait();

        if u485 ~= u18 then
            return;
        end;

        resetAll();
        local v501 = u157;

        for _, v in v501 do
            if v.Parent then
                v:Destroy();
            end;
        end;

        table.clear(v501);
        table.clear(u146);
        HalloweenEvent.Visible = false;
        HalloweenEvent.GroupTransparency = 0;
        u3.Show();

        if u476 then
            TweenService:Create(u476.Channels.Reveal, u6.HUD_SHOW_INFO, {
                Value = 1
            }):Play();
        end;

        u17 = false;
    end;

    function u5.Toggle() -- Line: 3585
        -- upvalues: u16 (ref), u5 (copy)
        if u16 then
            u5.Close();

            return;
        end;

        u5.Open();
    end;

    function u5.IsOpen() -- Line: 3593
        -- upvalues: u16 (ref)
        return u16;
    end;

    local function updateCreditLabels() -- Line: 3598
        -- upvalues: u146 (copy), u3 (copy), u12 (ref), u13 (ref), formatNumber (copy)
        for _, v in u146 do
            if v.CreditLabel then
                local v502;

                if v.Offer == u3.Catalog.CandyChest then
                    v502 = u12;
                else
                    v502 = u13;
                end;

                local v503 = v.Offer == u3.Catalog.CandyChest and "OPEN (" or "CLAIM (";
                local CreditLabel = v.CreditLabel;
                local v504;

                if v502 > 0 then
                    v504 = v503 .. tostring(v502) .. ")";
                else
                    v504 = formatNumber(v.Offer.Candy);
                end;

                CreditLabel.Text = v504;
            end;
        end;
    end;

    function u5.SetChestCredits(p505: number) -- Line: 3608
        -- upvalues: u12 (ref), updateCreditLabels (copy)
        local math_floor_ret = math.floor(p505);
        u12 = math.max(0, math_floor_ret);
        updateCreditLabels();
    end;

    function u5.SetBroomCredits(p506: number) -- Line: 3613
        -- upvalues: u13 (ref), updateCreditLabels (copy)
        local math_floor_ret = math.floor(p506);
        u13 = math.max(0, math_floor_ret);
        updateCreditLabels();
    end;

    function u5.SetRobuxPrice(p507: number, p508: number) -- Line: 3618
        -- upvalues: u3 (copy), u146 (copy), formatNumber (copy)
        for _, v in u3.Catalog.Offers do
            if v.ProductId == p507 then
                v.Robux = p508;
            end;
        end;

        for _, v in u146 do
            if v.Offer.ProductId == p507 then
                local Robux = v.Holder.ButtonsFrame:FindFirstChild("Robux");

                if Robux then
                    Robux = Robux:FindFirstChild("TextLabel", true);
                end;

                if Robux then
                    Robux.Text = formatNumber(p508);
                end;
            end;
        end;
    end;

    function u5.SetCandy(p509: number) -- Line: 3631
        -- upvalues: u147 (ref), u155 (ref), AmountLabel (copy), formatNumber (copy)
        local v510 = tonumber(p509) or 0;
        local math_floor_ret = math.floor(v510);
        local math_max_ret = math.max(0, math_floor_ret);

        if math_max_ret ~= u147 then
            u155 = u155 + 1;
        end;

        u147 = math_max_ret;
        AmountLabel.Text = formatNumber(u147);
    end;

    function u5.SetLocked(p511: boolean) -- Line: 3638
        -- upvalues: u15 (ref), resetShopInteractions (copy), LockedCg (copy), u6 (copy), TweenService (copy)
        u15 = p511;

        if not p511 then
            local v512 = TweenService:Create(LockedCg, u6.LOCK_FADE_INFO, {
                GroupTransparency = 1
            });
            v512:Play();
            v512.Completed:Once(function() -- Line: 3646
                -- upvalues: u15 (ref), LockedCg (ref)
                if not u15 and LockedCg.GroupTransparency >= 1 then
                    LockedCg.Visible = false;
                end;
            end);

            return;
        end;

        resetShopInteractions();
        LockedCg.GroupTransparency = 1;
        LockedCg.Visible = true;
        TweenService:Create(LockedCg, u6.LOCK_FADE_INFO, {
            GroupTransparency = 0
        }):Play();
    end;

    function u5.PlayUnboxing(p513: any, p514: string?, p515: any, p516: any) -- Line: 3654
        -- upvalues: u358 (copy)
        u358.play(p513, p514, p515, p516);
    end;

    function u5.IsUnboxing() -- Line: 3658
        -- upvalues: u358 (copy)
        return u358.Playing;
    end;

    function u5.OpenChances(p517) -- Line: 3662
        -- upvalues: u444 (copy)
        u444.open(p517);
    end;

    function u5.CloseOverlay() -- Line: 3666
        -- upvalues: u444 (copy), u358 (copy), u14 (ref)
        if u444.Open then
            u444.close();

            return true;
        end;

        if not u358.Playing then
            return u14;
        end;

        u358.reset();

        return true;
    end;

    function u5.IsAnimating() -- Line: 3677
        -- upvalues: u17 (ref)
        return u17;
    end;

    function u5.ForceClose() -- Line: 3681
        -- upvalues: u16 (ref), u17 (ref), u18 (ref), resetAll (copy), u157 (copy), u146 (copy), HalloweenEvent (copy), u3 (copy), u476 (ref), u6 (copy), TweenService (copy)
        if not (u16 or u17) then
            return;
        end;

        u16 = false;
        u17 = false;
        u18 = u18 + 1;
        resetAll();
        local v518 = u157;

        for _, v in v518 do
            if v.Parent then
                v:Destroy();
            end;
        end;

        table.clear(v518);
        table.clear(u146);
        HalloweenEvent.Visible = false;
        HalloweenEvent.GroupTransparency = 0;
        u3.Show();

        if u476 then
            TweenService:Create(u476.Channels.Reveal, u6.HUD_SHOW_INFO, {
                Value = 1
            }):Play();
        end;
    end;

    function u5.Init() -- Line: 3694
        -- upvalues: u16 (ref), u17 (ref), HalloweenEvent (copy), resetAll (copy), Title (copy), u3 (copy), u314 (copy), Customization (copy), ImageButton (copy), CandyCorn (copy), formatNumber (copy), setupButton (copy), CloseButton (copy), setupHudButton (copy)
        u16 = false;
        u17 = false;
        HalloweenEvent.Visible = false;
        HalloweenEvent.GroupTransparency = 0;
        resetAll();
        Title.Text = string.upper(u3.Catalog.Chest.ItemName);
        table.sort(u314.Entries, function(p519, p520) -- Line: 3703
            return p519.Frame.LayoutOrder < p520.Frame.LayoutOrder;
        end);

        for i, v in u314.Entries do
            if v.Icon then
                local Icon2 = v.Icon;
                local v521 = u3.Catalog.Chest.Grants[i];
                local v522 = v521 and v521.Category and Customization[v521.Category];

                if v522 then
                    v522 = v522[v521.Item];
                end;

                local v523 = v521 and v521.Icon or (v522 and (v522.IconId or (v522.Icon or 130432201459489)) or 130432201459489);
                local v524;

                if typeof(v523) == "number" then
                    v524 = "rbxassetid://" .. tostring(v523);
                else
                    v524 = tostring(v523 or "");
                end;

                Icon2.Image = v524;
            end;
        end;

        ImageButton.Active = u3.Catalog.Chest.Enabled == true;
        ImageButton.Selectable = u3.Catalog.Chest.Enabled == true;
        ImageButton.Interactable = u3.Catalog.Chest.Enabled == true;

        if CandyCorn then
            CandyCorn.Visible = true;
            CandyCorn.Active = u3.Catalog.Chest.Enabled == true;
            CandyCorn.Selectable = CandyCorn.Active;
            CandyCorn.Interactable = CandyCorn.Active;
            local TextLabel = CandyCorn:FindFirstChild("TextLabel", true);

            if TextLabel then
                TextLabel.Text = formatNumber(u3.Catalog.Chest.Candy);
            end;
        end;

        setupButton(CloseButton, u3.Close);
        setupHudButton();
    end;

    return u5;
end;