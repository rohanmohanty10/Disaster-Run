 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local LocalPlayer = game:GetService("Players").LocalPlayer;
local NumberUtil = require(ReplicatedStorage.Shared.Utility.NumberUtil);
local StatsSettings = require(ReplicatedStorage.Shared.Tables.StatsSettings);
local UIEffects = require(script.Parent.UIEffects);
local BG = LocalPlayer.PlayerGui:WaitForChild("InGame").BG;
local TopBarFrame = BG:WaitForChild("TopBarFrame");
local Top = BG:WaitForChild("Top");
local MatchTimer = BG:WaitForChild("TimerBG"):WaitForChild("MatchTimer");
local LevelFrame = TopBarFrame:WaitForChild("LevelFrame");
local LevelLabel = LevelFrame:WaitForChild("LevelLabel");
local Fill = LevelFrame:WaitForChild("LevelBar"):WaitForChild("Fill");
local CashFrame = TopBarFrame:WaitForChild("CashFrame");
local Icon = CashFrame:WaitForChild("Icon");
local AmountLabel = CashFrame:WaitForChild("AmountLabel");
local BoostMultiplier = CashFrame:WaitForChild("BoostMultiplier");
local u1 = {
    LEVEL_FORMAT = "LEVEL %d",
    HIDDEN_OFFSET = UDim2.fromScale(0, -0.25),
    HUD_OFFSET = UDim2.fromScale(0, -0.22),
    HUD_DELAY = 0.1,
    HOLD_TIME = 1.1,
    CASH_COLOR = Color3.fromRGB(110, 255, 120),
    SLIDE_IN_INFO = TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
    SLIDE_OUT_INFO = TweenInfo.new(0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.In),
    HUD_OUT_INFO = TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.In),
    HUD_IN_INFO = TweenInfo.new(0.55, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
    COUNT_INFO = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
};
local u2 = 0;
local u3 = false;
local u4 = false;
local u5 = 0;
local u6 = 0;
local Position = TopBarFrame.Position;
local Position2 = Top.Position;
local Position3 = MatchTimer.Position;
local NumberValue = Instance.new("NumberValue");
local v7 = {};

local function FormatCash(p8: number) -- Line: 53
    -- upvalues: NumberUtil (copy)
    return string.upper(NumberUtil.TruncateNumber(math.floor(p8 + 0.5), 1));
end;

local function InCutscene() -- Line: 57
    return workspace.CurrentCamera.CameraType == Enum.CameraType.Scriptable;
end;

function v7.GetTarget() -- Line: 61
    -- upvalues: Icon (copy)
    return Icon;
end;

function v7.SetCash(p9: number) -- Line: 65
    -- upvalues: u2 (ref), NumberValue (copy), AmountLabel (copy), NumberUtil (copy)
    u2 = p9;
    NumberValue.Value = p9;
    AmountLabel.Text = string.upper(NumberUtil.TruncateNumber(math.floor(p9 + 0.5), 1));
end;

function v7.SetLevel(p10: number, p11: number) -- Line: 71
    -- upvalues: StatsSettings (copy), LevelLabel (copy), u1 (copy), Fill (copy)
    local v12 = p10 * StatsSettings.Multiplier;
    LevelLabel.Text = string.format(u1.LEVEL_FORMAT, p10);
    Fill.Size = UDim2.fromScale(v12 > 0 and math.clamp(p11 / v12, 0, 1) or 0, 1);
end;

function v7.SetBoost(p13: boolean) -- Line: 78
    -- upvalues: BoostMultiplier (copy)
    BoostMultiplier.Visible = p13;
end;

function v7.Show() -- Line: 82
    -- upvalues: u5 (ref), u3 (ref), u4 (ref), u6 (ref), UIEffects (copy), Top (copy), u1 (copy), Position2 (copy), MatchTimer (copy), Position3 (copy), TopBarFrame (copy), Position (copy)
    u5 = u5 + 1;

    if u3 then
        return;
    end;

    u3 = true;
    u4 = true;
    UIEffects.Tween(Top, u1.HUD_OUT_INFO, {
        Position = Position2 + u1.HUD_OFFSET
    });
    UIEffects.Tween(MatchTimer, u1.HUD_OUT_INFO, {
        Position = Position3 + u1.HUD_OFFSET
    });
    task.wait(u1.HUD_DELAY);

    if u6 ~= u6 then
        return;
    end;

    TopBarFrame.Visible = true;
    UIEffects.Tween(TopBarFrame, u1.SLIDE_IN_INFO, {
        Position = Position
    });
end;

function v7.Release() -- Line: 107
    -- upvalues: u5 (ref), u1 (copy), u3 (ref), UIEffects (copy), TopBarFrame (copy), Position (copy), u4 (ref), Top (copy), Position2 (copy), MatchTimer (copy), Position3 (copy)
    u5 = u5 + 1;
    local u14 = u5;
    task.delay(u1.HOLD_TIME, function() -- Line: 112
        -- upvalues: u14 (copy), u5 (ref), u3 (ref), UIEffects (ref), TopBarFrame (ref), u1 (ref), Position (ref), u4 (ref), Top (ref), Position2 (ref), MatchTimer (ref), Position3 (ref)
        if u14 ~= u5 or not u3 then
            return;
        end;

        u3 = false;
        UIEffects.Tween(TopBarFrame, u1.SLIDE_OUT_INFO, {
            Position = Position + u1.HIDDEN_OFFSET
        });
        task.wait(u1.SLIDE_OUT_INFO.Time * 0.7);

        while workspace.CurrentCamera.CameraType == Enum.CameraType.Scriptable and u14 == u5 do
            task.wait(0.1);
        end;

        if u14 ~= u5 then
            return;
        end;

        u4 = false;
        UIEffects.Tween(Top, u1.HUD_IN_INFO, {
            Position = Position2
        });
        UIEffects.Tween(MatchTimer, u1.HUD_IN_INFO, {
            Position = Position3
        });
        task.wait(u1.SLIDE_OUT_INFO.Time * 0.3);

        if u14 == u5 then
            TopBarFrame.Visible = false;
        end;
    end);
end;

function v7.Reset() -- Line: 144
    -- upvalues: u5 (ref), u6 (ref), u3 (ref), TopBarFrame (copy), UIEffects (copy), u1 (copy), Position (copy), u4 (ref), Top (copy), Position2 (copy), MatchTimer (copy), Position3 (copy)
    u5 = u5 + 1;
    u6 = u6 + 1;
    u3 = false;
    TopBarFrame.Visible = false;
    UIEffects.Tween(TopBarFrame, u1.SLIDE_OUT_INFO, {
        Position = Position + u1.HIDDEN_OFFSET
    });

    if u4 then
        u4 = false;
        UIEffects.Tween(Top, u1.HUD_IN_INFO, {
            Position = Position2
        });
        UIEffects.Tween(MatchTimer, u1.HUD_IN_INFO, {
            Position = Position3
        });
    end;
end;

function v7.Arrive(p15: number) -- Line: 160
    -- upvalues: UIEffects (copy), Icon (copy), CashFrame (copy), AmountLabel (copy), u1 (copy), u2 (ref), NumberValue (copy)
    UIEffects.Punch(Icon, 1.4);
    UIEffects.Punch(CashFrame, 1.05);
    UIEffects.Punch(AmountLabel, 1.15);
    UIEffects.Sparkles(Icon, 3, u1.CASH_COLOR, 35);
    u2 = u2 + p15;
    UIEffects.Tween(NumberValue, u1.COUNT_INFO, {
        Value = u2
    });
end;

function v7.Finish(p16: string) -- Line: 171
    -- upvalues: UIEffects (copy), CashFrame (copy), BoostMultiplier (copy), Icon (copy), u1 (copy), AmountLabel (copy)
    UIEffects.Punch(CashFrame, 1.12);

    if BoostMultiplier.Visible then
        UIEffects.Punch(BoostMultiplier, 1.2);
    end;

    UIEffects.Wiggle(Icon, 14, 0.5);
    UIEffects.Ring(Icon, u1.CASH_COLOR, 3.2, 5);
    UIEffects.Sparkles(Icon, 10, nil, 80);
    UIEffects.FloatText(CashFrame, AmountLabel, p16, -65, 1.15);
end;

NumberValue.Changed:Connect(function(p17) -- Line: 184
    -- upvalues: AmountLabel (copy), NumberUtil (copy)
    AmountLabel.Text = string.upper(NumberUtil.TruncateNumber(math.floor(p17 + 0.5), 1));
end);
TopBarFrame.Visible = false;
TopBarFrame.Position = Position + u1.HIDDEN_OFFSET;

return v7;