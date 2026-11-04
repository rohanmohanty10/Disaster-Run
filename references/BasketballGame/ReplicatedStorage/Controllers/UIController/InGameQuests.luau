 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local LocalPlayer = game:GetService("Players").LocalPlayer;
local RunService = game:GetService("RunService");
local MarketplaceService = game:GetService("MarketplaceService");
local Knit = require(ReplicatedStorage.Packages.Knit);
local Trove = require(ReplicatedStorage.Packages.Trove);
local Quests = require(ReplicatedStorage.Shared.Tables.Quests);
local NumberUtil = require(ReplicatedStorage.Shared.Utility.NumberUtil);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local GetUnixTime = require(ReplicatedStorage.Shared.Utility.GetUnixTime);
local script_UIEffects = require(script.UIEffects);
local script_TopBar = require(script.TopBar);
local InGame = LocalPlayer.PlayerGui:WaitForChild("InGame");
local ZoneQuests = InGame.BG:WaitForChild("ZoneQuests");
local QuestFrame = InGame.BG:WaitForChild("QuestFrame");
local EntryFrame = QuestFrame:WaitForChild("EntryFrame");
local TimeLeft = EntryFrame:WaitForChild("Title"):WaitForChild("TimeLeft");
local RefreshAll = EntryFrame:WaitForChild("RefreshAll");
local UIScale = RefreshAll:WaitForChild("UIScale");
local CloseFrame = QuestFrame:WaitForChild("CloseFrame");
local ImageButton = CloseFrame:WaitForChild("ImageButton");
local Arrow = CloseFrame:WaitForChild("Arrow");
local BoostMultiplier = LocalPlayer.PlayerGui:WaitForChild("HUD").Top.Currency.BoostMultiplier;
local u1 = Trove.new();
local u7 = {
    Money = function(p2: userdata) -- Line: 29
        p2.Image = "rbxassetid://127166941152746";
    end,

    ["Style Spins"] = function(p3: userdata) -- Line: 32
        p3.Image = "rbxassetid://111333169806568";
    end,

    ["Lucky Style Spins"] = function(p4: userdata) -- Line: 35
        p4.Image = "rbxassetid://111333169806568";
        script.Rainbow:Clone().Parent = p4;
    end,

    ["Zone Spins"] = function(p5: userdata) -- Line: 40
        p5.Image = "rbxassetid://71537410313776";
    end,

    ["Lucky Zone Spins"] = function(p6: userdata) -- Line: 43
        p6.Image = "rbxassetid://71537410313776";
        script.Rainbow:Clone().Parent = p6;
    end
};
local u8 = {
    CATEGORY = "Daily",
    MONEY_REWARD = "Money",
    REFRESH_PRODUCT = 3238866681,
    REFRESH_INTERVAL = 86400,
    COMPLETE_TEXT = "COMPLETED!",
    RESET_FORMAT = "RESETS IN %s",
    POPULATE_STAGGER = 0.09,
    POPULATE_HOLD = 0.8,
    TICK_DELAY = 0.12,
    REWARD_DELAY = 0.35,
    PAYOUT_DELAY = 0.15,
    GREEN_TIME = 0.35,
    COMPLETE_GAP = 0.6,
    COIN_COUNT = 8,
    COIN_STAGGER = 0.045,
    COIN_SCATTER = 45,
    COIN_DURATION = 0.42,
    COIN_SIZE = 0.75,
    GEM_BURST = 10,
    GEM_DISTANCE = 75,
    REFRESH_HOVER_SCALE = 1.08,
    REFRESH_PRESS_SCALE = 0.92,
    REFRESH_CLICK_SCALE = 1.15,
    CLOSE_HOVER_SCALE = 1.12,
    CLOSE_PRESS_SCALE = 0.88,
    MINIMISE_OFFSET = UDim2.fromScale(-1.25, 0),
    GREEN_COLOR = Color3.fromRGB(85, 255, 110),
    GREEN_TINT = Color3.fromRGB(170, 255, 160),
    GOLD_COLOR = Color3.fromRGB(255, 214, 92),
    WHITE = Color3.fromRGB(255, 255, 255),
    CLAIMED_COLOR = Color3.fromRGB(140, 140, 140),
    GREEN_SEQUENCE = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(25, 140, 45)), ColorSequenceKeypoint.new(0.912, Color3.fromRGB(110, 235, 100)), ColorSequenceKeypoint.new(1, Color3.fromRGB(130, 255, 110)) }),
    DONE_BG_TRANSPARENCY = 0.6,
    DONE_TRANSPARENCY = 0.4,
    POP_IN_INFO = TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
    FILL_INFO = TweenInfo.new(0.7, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
    CHARGE_INFO = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
    TICK_INFO = TweenInfo.new(0.55, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
    DONE_INFO = TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
    COLOR_INFO = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
    HOVER_INFO = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
    PRESS_INFO = TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
    RELEASE_INFO = TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
    MINIMISE_INFO = TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In),
    RESTORE_INFO = TweenInfo.new(0.55, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
    ARROW_INFO = TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
};
local u9 = {};
local u10 = {};
local u11 = {};
local u12 = nil;
local u13 = false;
local u14 = false;
local u15 = true;
local u16 = 0;
local u17 = 0;
local u18 = false;
local u19 = false;
local Position = EntryFrame.Position;
local Scale = script_UIEffects.GetScale(CloseFrame);
local v20 = Knit.CreateController({
    Name = "InGameQuestsController"
});

local function GetProgress(p21) -- Line: 131
    return math.clamp(p21.Metadata[p21.Metadata.Index] or 0, 0, p21.Metadata.Target);
end;

local function GetDailyQuests(p22: table) -- Line: 135
    -- upvalues: u8 (copy), Quests (copy)
    local v23 = {};

    for _, v in p22 do
        if v.Category == u8.CATEGORY and Quests[v.QuestName] then
            table.insert(v23, v);
        end;
    end;

    return v23;
end;

local function FormatProgress(p24: any, p25: number) -- Line: 147
    -- upvalues: Knit (copy)
    return Knit.GetController("QuestsController").FormatProgress(p24.Index, p25, p24.Target);
end;

local function FormatReward(p26) -- Line: 153
    -- upvalues: NumberUtil (copy)
    if typeof(p26.Value) == "number" then
        return `+{string.upper(NumberUtil.TruncateNumber(p26.Value, 1))}`;
    end;

    return `+{p26.Value}`;
end;

local function CanAnimate() -- Line: 161
    -- upvalues: InGame (copy), QuestFrame (copy)
    return InGame.Enabled and QuestFrame.Visible and workspace.CurrentCamera.CameraType ~= Enum.CameraType.Scriptable;
end;

local function UpdateVisibility() -- Line: 165
    -- upvalues: QuestFrame (copy), u15 (ref), u13 (ref), ZoneQuests (copy)
    QuestFrame.Visible = u15 and u13 and not ZoneQuests.Visible;
end;

local function UpdateTimeLeft() -- Line: 169
    -- upvalues: Knit (copy), TimeLeft (copy), u8 (copy), GetUnixTime (copy), NumberUtil (copy)
    local LastDailyQuestRefresh = Knit.GetController("Network").Player.LastDailyQuestRefresh;

    if not LastDailyQuestRefresh then
        TimeLeft.Text = "REFRESHING...";

        return;
    end;

    local v27 = u8.REFRESH_INTERVAL - (GetUnixTime() - LastDailyQuestRefresh);
    local math_max_ret = math.max(v27, 0);
    TimeLeft.Text = string.format(u8.RESET_FORMAT, math_max_ret > 0 and NumberUtil.SecondsToClock(math_max_ret) or "00:00:00");
end;

local function LerpSequence(p28: userdata, p29: userdata, p30: number) -- Line: 184
    local Keypoints = p28.Keypoints;
    local Keypoints2 = p29.Keypoints;

    if #Keypoints ~= #Keypoints2 then
        return p29;
    end;

    local v31 = {};

    for i = 1, #Keypoints do
        v31[i] = ColorSequenceKeypoint.new(Keypoints[i].Time + (Keypoints2[i].Time - Keypoints[i].Time) * p30, Keypoints[i].Value:Lerp(Keypoints2[i].Value, p30));
        local _ = i;
    end;

    return ColorSequence.new(v31);
end;

local function TweenGradient(u32: userdata, u33: userdata, u34: number) -- Line: 202
    -- upvalues: LerpSequence (copy), RunService (copy)
    local Color = u32.Color;
    task.spawn(function() -- Line: 205
        -- upvalues: u34 (copy), u32 (copy), LerpSequence (ref), Color (copy), u33 (copy), RunService (ref)
        local os_clock_ret = os.clock();

        while true do
            local v35 = (os.clock() - os_clock_ret) / u34;
            local math_min_ret = math.min(v35, 1);
            u32.Color = LerpSequence(Color, u33, math_min_ret);

            if math_min_ret >= 1 then
                break;
            end;

            RunService.RenderStepped:Wait();
        end;
    end);
end;

local function CreateEntry(p36: any, p37: number) -- Line: 222
    -- upvalues: Quests (copy), script_UIEffects (copy), NumberUtil (copy), Knit (copy), u7 (copy), EntryFrame (copy)
    local v38 = Quests[p36.QuestName];
    local v39 = script.Quest:Clone();
    local Reward = v39.Reward;
    local u40 = {
        Queued = false,
        Completed = false,
        UniqueId = p36.UniqueId,
        Index = p36.Metadata.Index,
        Target = p36.Metadata.Target,
        Progress = math.clamp(p36.Metadata[p36.Metadata.Index] or 0, 0, p36.Metadata.Target),
        Reward = p36.Metadata.Reward,
        Frame = v39,
        Scale = script_UIEffects.GetScale(v39),
        Title = v39.Title,
        ProgressLabel = v39.Progress,
        Bar = v39.ProgressBar,
        Fill = v39.ProgressBar.Progress,
        FillGradient = v39.ProgressBar.Progress.UIGradient,
        Tick = v39.Tick,
        TickScale = v39.Tick.UIScale,
        RewardFrame = Reward,
        RewardIcon = Reward.RewardIcon,
        AmountLabel = Reward.AmountLabel,
        Display = Instance.new("NumberValue")
    };
    v39.Name = p36.UniqueId;
    v39.LayoutOrder = p37;
    u40.Title.Text = typeof(v38.Description) == "function" and v38.Description(p36) or v38.Description;
    local AmountLabel = u40.AmountLabel;
    local Reward2 = u40.Reward;
    local v41;

    if typeof(Reward2.Value) == "number" then
        v41 = `+{string.upper(NumberUtil.TruncateNumber(Reward2.Value, 1))}`;
    else
        v41 = `+{Reward2.Value}`;
    end;

    AmountLabel.Text = v41;
    local Progress = u40.Progress;
    u40.ProgressLabel.Text = Knit.GetController("QuestsController").FormatProgress(u40.Index, Progress, u40.Target);
    u40.Fill.Size = UDim2.fromScale(u40.Progress / u40.Target, 1);
    u40.Tick.Visible = false;
    u40.TickScale.Scale = 0;
    u40.Scale.Scale = 0;
    u40.Display.Value = u40.Progress;

    if u7[u40.Reward.Reward] then
        u7[u40.Reward.Reward](u40.RewardIcon);
    else
        u40.RewardIcon.Image = "rbxassetid://82949801556287";
    end;

    u40.Display.Changed:Connect(function(p42) -- Line: 268
        -- upvalues: u40 (copy), Knit (ref)
        if u40.Completed then
            return;
        end;

        local ProgressLabel = u40.ProgressLabel;
        local v43 = u40;
        local math_floor_ret = math.floor(p42 + 0.5);
        ProgressLabel.Text = Knit.GetController("QuestsController").FormatProgress(v43.Index, math_floor_ret, v43.Target);
    end);
    v39.Parent = EntryFrame;

    return u40;
end;

local function FadeDone(p44) -- Line: 281
    -- upvalues: script_UIEffects (copy), u8 (copy)
    script_UIEffects.Tween(p44.Frame, u8.DONE_INFO, {
        BackgroundTransparency = u8.DONE_BG_TRANSPARENCY
    });
    script_UIEffects.Tween(p44.Bar, u8.DONE_INFO, {
        GroupTransparency = u8.DONE_TRANSPARENCY
    });
    script_UIEffects.Tween(p44.RewardIcon, u8.DONE_INFO, {
        ImageColor3 = u8.CLAIMED_COLOR,
        ImageTransparency = u8.DONE_TRANSPARENCY
    });
    script_UIEffects.Tween(p44.RewardFrame.Bg, u8.DONE_INFO, {
        ImageTransparency = u8.DONE_TRANSPARENCY
    });

    for _, v in { p44.Title, p44.ProgressLabel, p44.AmountLabel } do
        script_UIEffects.Tween(v, u8.DONE_INFO, {
            TextTransparency = u8.DONE_TRANSPARENCY
        });
        local v45 = v:FindFirstChildOfClass("UIStroke");

        if v45 then
            script_UIEffects.Tween(v45, u8.DONE_INFO, {
                Transparency = u8.DONE_TRANSPARENCY
            });
        end;
    end;
end;

local function Claim(u46) -- Line: 298
    -- upvalues: Knit (copy), u10 (copy), u8 (copy)
    local Controller = Knit.GetController("Network");
    local Service = Knit.GetService("QuestsService");
    local Money = Controller.Player.Money;
    local v47 = {};
    u10[u46.UniqueId] = v47;
    local success, result = pcall(function() -- Line: 306
        -- upvalues: Service (copy), u46 (copy)
        return Service:CompleteQuest(u46.UniqueId);
    end);

    if success then
        success = result == true;
    end;

    if success and u46.Reward.Reward == u8.MONEY_REWARD then
        local os_clock_ret = os.clock();

        while Controller.Player.Money == Money and os.clock() - os_clock_ret < 1 do
            task.wait();
        end;
    end;

    v47.Balance = Controller.Player.Money;
    v47.Claimed = success;
end;

local function Payout(p48) -- Line: 324
    -- upvalues: u16 (ref), u8 (copy), script_UIEffects (copy), script_TopBar (copy)
    local u49 = u16;
    local X = p48.RewardIcon.AbsoluteSize.X;

    if p48.Reward.Reward ~= u8.MONEY_REWARD then
        script_UIEffects.Punch(p48.RewardIcon, 1.6);
        script_UIEffects.Wiggle(p48.RewardIcon, 20, 0.6);
        script_UIEffects.Sparkles(p48.RewardIcon, u8.GEM_BURST, nil, u8.GEM_DISTANCE, p48.RewardIcon.Image, X * 0.5);
        script_UIEffects.Sparkles(p48.RewardIcon, 8, u8.GOLD_COLOR, u8.GEM_DISTANCE * 0.8);
        script_UIEffects.Ring(p48.RewardIcon, u8.WHITE, 3, 4);
        script_UIEffects.FloatText(p48.RewardFrame, p48.AmountLabel, p48.AmountLabel.Text, 60, 1.8);
        task.wait(0.9);

        return;
    end;

    local Target = script_TopBar.GetTarget();
    local u50 = p48.Reward.Value / u8.COIN_COUNT;
    local u51 = 0;

    for i = 1, u8.COIN_COUNT do
        task.spawn(script_UIEffects.Fly, p48.RewardIcon.Image, p48.RewardIcon, Target, {
            StartSize = X * u8.COIN_SIZE,
            Scatter = u8.COIN_SCATTER,
            Delay = (i - 1) * u8.COIN_STAGGER,
            Duration = u8.COIN_DURATION,

            OnArrive = function() -- Line: 351, Name: OnArrive
                -- upvalues: u51 (ref), u49 (copy), u16 (ref), script_TopBar (ref), u50 (copy)
                u51 = u51 + 1;

                if u49 == u16 then
                    script_TopBar.Arrive(u50);
                end;
            end
        });
        local _ = i;
    end;

    script_UIEffects.Punch(p48.RewardIcon, 0.8);
    local os_clock_ret = os.clock();

    while u51 < u8.COIN_COUNT and os.clock() - os_clock_ret < 3 do
        task.wait();
    end;

    script_TopBar.Finish(p48.AmountLabel.Text);
    script_TopBar.Release();
    task.wait(0.4);
end;

local function Complete(u52) -- Line: 375
    -- upvalues: u16 (ref), u10 (copy), u8 (copy), Knit (copy), script_TopBar (copy), BoostMultiplier (copy), script_UIEffects (copy), LerpSequence (copy), RunService (copy), Payout (copy), FadeDone (copy)
    local u53 = u16;
    local v54 = u10[u52.UniqueId];

    while v54.Claimed == nil do
        task.wait();
    end;

    if v54.Claimed and u52.Reward.Reward == u8.MONEY_REWARD then
        local Controller = Knit.GetController("Network");
        script_TopBar.SetCash(v54.Balance - u52.Reward.Value);
        script_TopBar.SetLevel(Controller.Player.Level, Controller.Player.Exp);
        script_TopBar.SetBoost(BoostMultiplier.Visible);
        task.spawn(script_TopBar.Show);
    end;

    if u52.Progress < u52.Target then
        u52.Progress = u52.Target;
        script_UIEffects.Tween(u52.Fill, u8.CHARGE_INFO, {
            Size = UDim2.fromScale(1, 1)
        });
        script_UIEffects.Tween(u52.Display, u8.CHARGE_INFO, {
            Value = u52.Target
        });
        task.wait(u8.CHARGE_INFO.Time);
    end;

    u52.Completed = true;
    script_UIEffects.Punch(u52.Frame, 1.08);
    script_UIEffects.Flash(u52.Frame, u8.GREEN_TINT, 0.2);
    script_UIEffects.Flash(u52.Bar, u8.WHITE, 0);
    script_UIEffects.Shine(u52.Frame, 0.5, 15);
    script_UIEffects.Shine(u52.Bar, 0.9);
    local FillGradient = u52.FillGradient;
    local GREEN_SEQUENCE = u8.GREEN_SEQUENCE;
    local GREEN_TIME = u8.GREEN_TIME;
    local Color = FillGradient.Color;
    task.spawn(function() -- Line: 205
        -- upvalues: GREEN_TIME (copy), FillGradient (copy), LerpSequence (ref), Color (copy), GREEN_SEQUENCE (copy), RunService (ref)
        local os_clock_ret = os.clock();

        while true do
            local v55 = (os.clock() - os_clock_ret) / GREEN_TIME;
            local math_min_ret = math.min(v55, 1);
            FillGradient.Color = LerpSequence(Color, GREEN_SEQUENCE, math_min_ret);

            if math_min_ret >= 1 then
                break;
            end;

            RunService.RenderStepped:Wait();
        end;
    end);
    u52.ProgressLabel.Text = u8.COMPLETE_TEXT;
    script_UIEffects.Tween(u52.ProgressLabel, u8.COLOR_INFO, {
        TextColor3 = u8.GREEN_COLOR
    });
    script_UIEffects.Punch(u52.ProgressLabel, 1.35);
    task.wait(u8.TICK_DELAY);
    u52.Tick.Visible = true;
    u52.Tick.Rotation = -120;
    u52.TickScale.Scale = 0;
    script_UIEffects.Tween(u52.TickScale, u8.TICK_INFO, {
        Scale = 1
    });
    script_UIEffects.Tween(u52.Tick, u8.TICK_INFO, {
        Rotation = 0
    });
    task.delay(u8.TICK_INFO.Time * 0.35, function() -- Line: 425
        -- upvalues: u53 (copy), u16 (ref), script_UIEffects (ref), u52 (copy), u8 (ref)
        if u53 ~= u16 then
            return;
        end;

        script_UIEffects.Ring(u52.Tick, u8.GREEN_COLOR, 2.8, 4);
        script_UIEffects.Sparkles(u52.Tick, 8, u8.GREEN_TINT, u52.Tick.AbsoluteSize.X * 1.6);
    end);
    task.wait(u8.REWARD_DELAY);

    if not v54.Claimed then
        return;
    end;

    script_UIEffects.Punch(u52.RewardFrame, 1.3);
    script_UIEffects.Wiggle(u52.RewardIcon, 14, 0.5);
    script_UIEffects.Ring(u52.RewardFrame, u8.GOLD_COLOR, 2.4, 3);
    task.wait(u8.PAYOUT_DELAY);
    Payout(u52);
    FadeDone(u52);
end;

local function RunQueue() -- Line: 450
    -- upvalues: u11 (copy), InGame (copy), QuestFrame (copy), u17 (ref), u8 (copy), Complete (copy), script_TopBar (copy), u12 (ref)
    -- failed to decompile: called `Option::unwrap()` on a `None` value
    -- Backtrace:
    -- disabled backtrace
end;

local function Enqueue(p56) -- Line: 469
    -- upvalues: u10 (copy), Claim (copy), u11 (copy), u12 (ref), RunQueue (copy)
    local v57 = u10[p56.UniqueId];
    p56.Queued = true;

    if not v57 or v57.Claimed == false then
        task.spawn(Claim, p56);
    end;

    table.insert(u11, p56);

    if not u12 then
        u12 = task.defer(RunQueue);
    end;
end;

local function Clear() -- Line: 485
    -- upvalues: u16 (ref), u12 (ref), u11 (copy), u9 (copy), script_TopBar (copy)
    u16 = u16 + 1;

    if u12 then
        task.cancel(u12);
        u12 = nil;
    end;

    table.clear(u11);

    for i, v in u9 do
        v.Frame:Destroy();
        v.Display:Destroy();
        u9[i] = nil;
    end;

    script_TopBar.Reset();
end;

local function Populate(p58: table) -- Line: 504
    -- upvalues: Clear (copy), u17 (ref), CreateEntry (copy), u9 (copy), u8 (copy), script_UIEffects (copy), u10 (copy), Claim (copy), u11 (copy), u12 (ref), RunQueue (copy)
    Clear();
    u17 = os.clock();

    for i, v in p58 do
        local u59 = CreateEntry(v, i);
        u9[u59.UniqueId] = u59;
        task.delay((i - 1) * u8.POPULATE_STAGGER, function() -- Line: 513
            -- upvalues: script_UIEffects (ref), u59 (copy), u8 (ref)
            script_UIEffects.Tween(u59.Scale, u8.POP_IN_INFO, {
                Scale = 1
            });
        end);

        if u59.Progress >= u59.Target then
            local v60 = u10[u59.UniqueId];
            u59.Queued = true;

            if not v60 or v60.Claimed == false then
                task.spawn(Claim, u59);
            end;

            table.insert(u11, u59);

            if not u12 then
                u12 = task.defer(RunQueue);
            end;
        end;
    end;
end;

local function SetProgress(p61: any, p62: number) -- Line: 523
    -- upvalues: Knit (copy), script_UIEffects (copy), u8 (copy)
    local Progress = p61.Progress;
    local v63 = Knit.GetController("QuestsController").FormatProgress(p61.Index, Progress, p61.Target);
    p61.Progress = p62;
    script_UIEffects.Tween(p61.Fill, u8.FILL_INFO, {
        Size = UDim2.fromScale(p62 / p61.Target, 1)
    });
    script_UIEffects.Tween(p61.Display, u8.FILL_INFO, {
        Value = p62
    });

    if Knit.GetController("QuestsController").FormatProgress(p61.Index, p62, p61.Target) ~= v63 then
        script_UIEffects.Flash(p61.Bar, u8.WHITE, 0.4);
        script_UIEffects.Punch(p61.ProgressLabel, 1.25);
    end;
end;

local function Sync(p64: table) -- Line: 537
    -- upvalues: GetDailyQuests (copy), u9 (copy), Populate (copy), u10 (copy), Claim (copy), u11 (copy), u12 (ref), RunQueue (copy), SetProgress (copy)
    local v65 = GetDailyQuests(p64);
    local v66 = {};
    local v67 = false;

    for _, v in v65 do
        v66[v.UniqueId] = true;

        if not u9[v.UniqueId] then
            v67 = true;
        end;
    end;

    for i, v in u9 do
        if not (v66[i] or v.Queued) then
            v67 = true;
        end;
    end;

    if v67 then
        Populate(v65);

        return;
    end;

    for _, v in v65 do
        local v68 = u9[v.UniqueId];
        local math_clamp_ret = math.clamp(v.Metadata[v.Metadata.Index] or 0, 0, v.Metadata.Target);

        if not v68.Queued then
            if v68.Target <= math_clamp_ret then
                local v69 = u10[v68.UniqueId];
                v68.Queued = true;

                if not v69 or v69.Claimed == false then
                    task.spawn(Claim, v68);
                end;

                table.insert(u11, v68);

                if not u12 then
                    u12 = task.defer(RunQueue);
                end;
            elseif math_clamp_ret ~= v68.Progress then
                SetProgress(v68, math_clamp_ret);
            end;
        end;
    end;
end;

local function SetMinimised(p70: boolean) -- Line: 576
    -- upvalues: u14 (ref), script_UIEffects (copy), EntryFrame (copy), u8 (copy), Position (copy), Arrow (copy)
    u14 = p70;

    if u14 then
        script_UIEffects.Tween(EntryFrame, u8.MINIMISE_INFO, {
            Position = Position + u8.MINIMISE_OFFSET
        });
        script_UIEffects.Tween(Arrow, u8.ARROW_INFO, {
            Rotation = 180
        });

        return;
    end;

    script_UIEffects.Tween(EntryFrame, u8.RESTORE_INFO, {
        Position = Position
    });
    script_UIEffects.Tween(Arrow, u8.ARROW_INFO, {
        Rotation = 0
    });
end;

local function UpdateMatch() -- Line: 588
    -- upvalues: LocalPlayer (copy), u13 (ref), Knit (copy), Populate (copy), GetDailyQuests (copy), UpdateTimeLeft (copy), u1 (copy), RunService (copy), GetUnixTime (copy), Clear (copy), QuestFrame (copy), u15 (ref), ZoneQuests (copy)
    local v71;

    if LocalPlayer.Team == nil then
        v71 = false;
    else
        v71 = LocalPlayer.Team ~= game.Teams.Visitor;
    end;

    if v71 == u13 then
        return;
    end;

    u13 = v71;

    if u13 then
        local u72 = nil;
        Populate((GetDailyQuests(Knit.GetController("Network").Player.Quests or {})));
        UpdateTimeLeft();
        u1:Connect(RunService.Heartbeat, function() -- Line: 604
            -- upvalues: GetUnixTime (ref), u72 (ref), UpdateTimeLeft (ref)
            local v73 = GetUnixTime();

            if u72 == v73 then
                return;
            end;

            u72 = v73;
            UpdateTimeLeft();
        end);
    else
        u1:Clean();
        Clear();
    end;

    QuestFrame.Visible = u15 and u13 and not ZoneQuests.Visible;
end;

function v20.SetVisible(p74: table, p75: boolean) -- Line: 623
    -- upvalues: u15 (ref), script_UIEffects (copy), script_TopBar (copy), QuestFrame (copy), u13 (ref), ZoneQuests (copy)
    u15 = p75;
    script_UIEffects.Layer.Visible = p75;

    if not p75 then
        script_TopBar.Reset();
    end;

    QuestFrame.Visible = u15 and u13 and not ZoneQuests.Visible;
end;

function v20.KnitInit(p76) -- Line: 634
end;

function v20.KnitStart(p77) -- Line: 638
    -- upvalues: Knit (copy), u13 (ref), Sync (copy), LocalPlayer (copy), UpdateMatch (copy), ZoneQuests (copy), UpdateVisibility (copy), ImageButton (copy), u19 (ref), script_UIEffects (copy), Scale (copy), u8 (copy), SetMinimised (copy), u14 (ref), RefreshAll (copy), u18 (ref), UIScale (copy), Effects (copy), MarketplaceService (copy)
    local Controller = Knit.GetController("Network");
    Knit.GetService("QuestsService").QuestsChanged:Connect(function(p78) -- Line: 642
        -- upvalues: Controller (copy), u13 (ref), Sync (ref)
        Controller.Player.Quests = p78;

        if u13 then
            Sync(p78);
        end;
    end);
    LocalPlayer:GetPropertyChangedSignal("Team"):Connect(UpdateMatch);
    ZoneQuests:GetPropertyChangedSignal("Visible"):Connect(UpdateVisibility);
    ImageButton.MouseEnter:Connect(function() -- Line: 653
        -- upvalues: u19 (ref), script_UIEffects (ref), Scale (ref), u8 (ref)
        u19 = true;
        script_UIEffects.Tween(Scale, u8.HOVER_INFO, {
            Scale = u8.CLOSE_HOVER_SCALE
        });
    end);
    ImageButton.MouseLeave:Connect(function() -- Line: 659
        -- upvalues: u19 (ref), script_UIEffects (ref), Scale (ref), u8 (ref)
        u19 = false;
        script_UIEffects.Tween(Scale, u8.HOVER_INFO, {
            Scale = 1
        });
    end);
    ImageButton.MouseButton1Down:Connect(function() -- Line: 665
        -- upvalues: script_UIEffects (ref), Scale (ref), u8 (ref)
        script_UIEffects.Tween(Scale, u8.PRESS_INFO, {
            Scale = u8.CLOSE_PRESS_SCALE
        });
    end);
    ImageButton.MouseButton1Up:Connect(function() -- Line: 669
        -- upvalues: script_UIEffects (ref), Scale (ref), u8 (ref), u19 (ref)
        script_UIEffects.Tween(Scale, u8.RELEASE_INFO, {
            Scale = u19 and u8.CLOSE_HOVER_SCALE or 1
        });
    end);
    ImageButton.Activated:Connect(function() -- Line: 673
        -- upvalues: SetMinimised (ref), u14 (ref)
        SetMinimised(not u14);
    end);
    RefreshAll.MouseEnter:Connect(function() -- Line: 677
        -- upvalues: u18 (ref), script_UIEffects (ref), UIScale (ref), u8 (ref)
        u18 = true;
        script_UIEffects.Tween(UIScale, u8.HOVER_INFO, {
            Scale = u8.REFRESH_HOVER_SCALE
        });
    end);
    RefreshAll.MouseLeave:Connect(function() -- Line: 683
        -- upvalues: u18 (ref), script_UIEffects (ref), UIScale (ref), u8 (ref)
        u18 = false;
        script_UIEffects.Tween(UIScale, u8.HOVER_INFO, {
            Scale = 1
        });
    end);
    RefreshAll.MouseButton1Down:Connect(function() -- Line: 689
        -- upvalues: script_UIEffects (ref), UIScale (ref), u8 (ref)
        script_UIEffects.Tween(UIScale, u8.PRESS_INFO, {
            Scale = u8.REFRESH_PRESS_SCALE
        });
    end);
    RefreshAll.MouseButton1Up:Connect(function() -- Line: 693
        -- upvalues: script_UIEffects (ref), UIScale (ref), u8 (ref), u18 (ref)
        script_UIEffects.Tween(UIScale, u8.RELEASE_INFO, {
            Scale = u18 and u8.REFRESH_HOVER_SCALE or 1
        });
    end);
    RefreshAll.Activated:Connect(function() -- Line: 697
        -- upvalues: script_UIEffects (ref), UIScale (ref), u8 (ref), u18 (ref), Effects (ref), MarketplaceService (ref), LocalPlayer (ref)
        script_UIEffects.Tween(UIScale, u8.PRESS_INFO, {
            Scale = u8.REFRESH_CLICK_SCALE
        });
        task.delay(u8.PRESS_INFO.Time, function() -- Line: 700
            -- upvalues: script_UIEffects (ref), UIScale (ref), u8 (ref), u18 (ref)
            script_UIEffects.Tween(UIScale, u8.RELEASE_INFO, {
                Scale = u18 and u8.REFRESH_HOVER_SCALE or 1
            });
        end);

        if workspace:GetAttribute("IsPrivateServer") then
            Effects:Popup("Cannot purchase in a Private Server!", 5, Color3.fromRGB(255, 53, 53));

            return;
        end;

        MarketplaceService:PromptProductPurchase(LocalPlayer, u8.REFRESH_PRODUCT);
    end);
    p77:SetVisible(Controller.Player.Customization.Settings.MatchQuests ~= false);
    UpdateMatch();
end;

return v20;