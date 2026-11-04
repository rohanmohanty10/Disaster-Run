 

 

local TweenService = game:GetService("TweenService");
local HttpService = game:GetService("HttpService");
local Skin = require(game:GetService("ReplicatedStorage"):WaitForChild("ChickenOrHero"):WaitForChild("OldUIReskin"):WaitForChild("Skin"));
local Theme = Skin.Theme;
local NotificationDock = require(script.Parent.NotificationDock);
local u1 = {};
u1.__index = u1;

local function metric(p2, p3, p4) -- Line: 9
    local v5 = math.round(p2 * 10) / 10;

    if math.abs(v5) < 0.05 then
        return p4 and "Standard " .. p3 or p3:sub(1, 1):upper() .. p3:sub(2) .. " unchanged";
    end;

    return ("%+.1f%% %s"):format(v5, p3);
end;

function u1.describe(p6) -- Line: 14
    -- upvalues: metric (copy)
    local v7 = metric(p6.speed, "speed", p6.baseline);
    local v8 = metric(p6.acceleration, "acceleration", p6.baseline);
    local v9 = math.round(p6.turning * 10) / 10;
    local v10 = (p6.role == "Catcher" and "CHASER" or p6.role:upper()) .. " · " .. (p6.baseline and "TEAM BALANCE" or "CROSSING UPDATE");

    if v9 >= 0.1 then
        v10 = v10 .. " · SHARPER TURNS";
    elseif v9 <= -0.1 then
        v10 = v10 .. " · TURNING RESET";
    end;

    return v10, v7 .. "  ·  " .. v8;
end;

function u1.new(p11, p12) -- Line: 22
    -- upvalues: Theme (copy), Skin (copy), u1 (copy)
    local CanvasGroup = Instance.new("CanvasGroup");
    CanvasGroup.Name = "CrossingBalanceNotice";
    CanvasGroup.BackgroundTransparency = 1;
    CanvasGroup.AnchorPoint = Vector2.new(0.5, 0);
    CanvasGroup.Size = UDim2.fromOffset(520, 44);
    CanvasGroup.Visible = false;
    CanvasGroup.GroupTransparency = 1;
    CanvasGroup.Active = false;
    CanvasGroup.Parent = p11.MainFrame;

    local function label(p13, p14, p15, p16, p17, p18) -- Line: 25
        -- upvalues: Theme (ref), CanvasGroup (copy), Skin (ref)
        local TextLabel = Instance.new("TextLabel");
        TextLabel.Name = p13;
        TextLabel.BackgroundTransparency = 1;
        TextLabel.Size = UDim2.new(1, 0, 0, p18);
        TextLabel.Position = UDim2.fromOffset(0, p17);
        TextLabel.Font = p15;
        TextLabel.TextSize = p14;
        TextLabel.TextScaled = true;
        TextLabel.TextColor3 = p16;
        TextLabel.TextStrokeColor3 = Theme.Ink;
        TextLabel.TextStrokeTransparency = 0.55;
        TextLabel.Text = "";
        TextLabel.Active = false;
        TextLabel.Parent = CanvasGroup;
        Skin.textStroke(TextLabel, 1.5);
        local UITextSizeConstraint = Instance.new("UITextSizeConstraint");
        UITextSizeConstraint.MinTextSize = 9;
        UITextSizeConstraint.MaxTextSize = p14;
        UITextSizeConstraint.Parent = TextLabel;

        return TextLabel;
    end;

    local v19 = {
        gui = p11,
        frame = CanvasGroup,
        caption = label("Caption", 10, Enum.Font.GothamMedium, Theme.Muted, 0, 14),
        stats = label("Stats", 16, Enum.Font.GothamBold, Theme.Paper, 18, 22),
        player = p12
    };

    return setmetatable(v19, u1);
end;

function u1.hide(u20, p21) -- Line: 36
    -- upvalues: TweenService (copy)
    if u20.tween then
        u20.tween:Cancel();
        u20.tween = nil;
    end;

    u20.showing = false;

    if p21 then
        u20.frame.Visible = false;
        u20.frame.GroupTransparency = 1;

        return;
    end;

    local u22 = TweenService:Create(u20.frame, TweenInfo.new(0.22), {
        GroupTransparency = 1
    });
    u20.tween = u22;
    u22.Completed:Once(function(p23) -- Line: 41
        -- upvalues: u20 (copy), u22 (copy)
        if u20.tween == u22 and p23 == Enum.PlaybackState.Completed then
            u20.frame.Visible = false;
            u20.tween = nil;
        end;
    end);
    u22:Play();
end;

function u1.update(p24, p25) -- Line: 43
    -- upvalues: HttpService (copy), u1 (copy), Theme (copy), TweenService (copy), NotificationDock (copy)
    local player = p24.player;
    local ServerTimeNow = workspace:GetServerTimeNow();
    local Attribute = player:GetAttribute("CrossingBalanceNotice");

    if Attribute ~= p24.raw then
        p24.raw = Attribute;
        p24:hide(true);
        p24.pending = nil;
        local success, result = pcall(HttpService.JSONDecode, HttpService, Attribute or "");

        if success and (type(result) == "table" and (type(result.speed) == "number" and (type(result.acceleration) == "number" and (type(result.turning) == "number" and (type(result.expiresAt) == "number" and (result.role == "Runner" or result.role == "Catcher")))))) then
            p24.pending = result;
        end;
    end;

    if player:GetAttribute("InMatch") ~= true or (player:GetAttribute("GameRole") == "Lobby" or (p25 == "Results" or p25 == "Intermission")) then
        p24.pending = nil;
        p24:hide(true);

        return;
    end;

    if player:GetAttribute("ScreenPresentationActive") or player:GetAttribute("GlobalWheelOpen") or (player:GetAttribute("MatchSummaryVisible") or p24.gui.MainFrame.Choices.Visible) then
        p24:hide(true);

        return;
    end;

    if p24.pending and p24.pending.expiresAt <= ServerTimeNow then
        p24.pending = nil;
    end;

    if p24.pending then
        local pending = p24.pending;
        p24.pending = nil;

        if p24.tween then
            p24.tween:Cancel();
            p24.tween = nil;
        end;

        local caption = p24.caption;
        local stats = p24.stats;
        local v26, v27 = u1.describe(pending);
        caption.Text = v26;
        stats.Text = v27;
        p24.stats.TextColor3 = pending.role == "Runner" and Theme.Blue or Theme.Paper;
        p24.untilAt = ServerTimeNow + 3.2;
        p24.showing = true;
        p24.frame.Visible = true;
        p24.frame.GroupTransparency = 1;
        p24.tween = TweenService:Create(p24.frame, TweenInfo.new(0.18), {
            GroupTransparency = 0
        });
        p24.tween:Play();
    end;

    if p24.showing and p24.untilAt <= ServerTimeNow then
        p24:hide(false);
    end;

    if p24.frame.Visible then
        local MainFrame = p24.gui.MainFrame;
        p24.frame.Position = UDim2.new(0.5, 0, 0, NotificationDock.bottom(p24.gui.Parent, MainFrame));
        p24.frame.Size = UDim2.fromOffset(math.min(MainFrame.AbsoluteSize.X - 28, 520), 44);
    end;
end;

function u1.destroy(p28) -- Line: 74
    p28:hide(true);
    p28.frame:Destroy();
end;

return u1;