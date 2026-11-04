 

 

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local HttpService = game:GetService("HttpService");
local UserInputService = game:GetService("UserInputService");
local ContextActionService = game:GetService("ContextActionService");
local Lighting = game:GetService("Lighting");
local Parent = script.Parent.Parent;
local Parent2 = Parent.Parent;
local Registry = require(Parent.Registry);
local Panels = require(Parent.Panels);
local Widgets = require(Parent.Widgets);
local ProgressionMath = require(Parent2.Progression.ProgressionMath);
local VerifiedName = require(Parent2.Presentation.VerifiedName);
local ParticipantDirectory = require(Parent2.Presentation.ParticipantDirectory);
local AvatarPortrait = require(Parent.AvatarPortrait);
local MatchSummaryConfig = require(Parent2.Presentation.MatchSummaryConfig);
local JourneyConfig = require(Parent2.Progression.JourneyConfig);
local JourneyMath = require(Parent2.Progression.JourneyMath);
local SkinCatalog = require(Parent2.Weapons.SkinCatalog);
local EmoteCatalog = require(Parent2.Emotes.EmoteCatalog);
local ClaimPop = require(Parent.ClaimPop);
local EmotePose = require(Parent.EmotePose);
local HudNavigation = require(Parent2.Presentation.HudNavigation);
local LocalPlayer = Players.LocalPlayer;
local v1 = {};
local u2 = {
    CrossyRoad = true,
    DonkeyKong = true,
    FFACatchers = true,
    BladeBall = true
};
local u3 = {
    {
        key = "mvp",
        title = "Match MVP",
        empty = "No scoring actions this match",
        color = Color3.fromRGB(255, 205, 112)
    },
    {
        key = "survival",
        title = "Longest Survival",
        empty = "No runner time recorded",
        color = Color3.fromRGB(107, 226, 186)
    },
    {
        key = "catches",
        title = "Most Catches",
        empty = "Everyone got away",
        color = Color3.fromRGB(255, 130, 136)
    }
};
local u4 = { "1stPlace", "2ndPlace", "3rdPlace" };
local u5 = { "InMatch", "InitialLoadingComplete", "ScreenPresentationActive", "ClientReady", "AdminRefreshActive", "EventIntroSkipsRecap" };
local u6 = {
    Button = true,
    Back = true,
    Toggle = true,
    Replaced = true
};
local u7 = { "AnnouncementComposerOpen", "CreatorPanelOpen", "AdminConsoleActive" };
local u8 = {};
local u9 = 0;

local function thumbnail(u10, p11) -- Line: 58
    -- upvalues: u8 (copy), u9 (ref), Players (copy)
    local v12 = u8[u10];

    if v12 and v12.image then
        p11(v12.image);

        return;
    end;

    if v12 and v12.waiting then
        table.insert(v12.waiting, p11);

        return;
    end;

    if v12 and os.clock() < v12.retryAt then
        return;
    end;

    if u9 >= 64 then
        table.clear(u8);
        u9 = 0;
    end;

    local u13 = {
        retryAt = 0,
        waiting = { p11 }
    };
    u8[u10] = u13;
    u9 = u9 + 1;
    task.spawn(function() -- Line: 76
        -- upvalues: Players (ref), u10 (copy), u13 (ref)
        local v14 = nil;

        for i = 1, 3 do
            local v15, v16, v17 = pcall(Players.GetUserThumbnailAsync, Players, u10, Enum.ThumbnailType.AvatarBust, Enum.ThumbnailSize.Size180x180);

            if v15 and (v17 and (type(v16) == "string" and v16 ~= "")) then
                v14 = v16;
                break;
            end;

            local v18;

            if i < 3 then
                task.wait(i * 0.5);
                v18 = i;
            else
                v18 = i;
            end;
        end;

        local waiting = u13.waiting;
        u13.waiting = nil;
        u13.image = v14;
        u13.retryAt = os.clock() + 30;

        if v14 then
            for _, v in waiting do
                v(v14);
            end;
        end;
    end);
end;

local function characterOf(p19) -- Line: 107
    -- upvalues: Players (copy), ParticipantDirectory (copy)
    if type(p19) ~= "number" then
        return nil;
    end;

    local PlayerByUserId = Players:GetPlayerByUserId(p19);

    if PlayerByUserId then
        return PlayerByUserId.Character;
    end;

    for _, v in ParticipantDirectory.list() do
        if type(v) == "table" and v.UserId == p19 then
            return v.Character;
        end;
    end;

    return nil;
end;

local u20 = setmetatable({}, {
    __mode = "k"
});
local u21 = setmetatable({}, {
    __mode = "k"
});

local function portrait(u22, u23, p24, p25) -- Line: 128
    -- upvalues: u21 (copy), characterOf (copy), u20 (copy), thumbnail (copy)
    if u21[u22] == nil then
        u21[u22] = u22.ImageTransparency;
    end;

    if p25 and (u23 and p25:show((characterOf(u23.userId)))) then
        u20[u22] = nil;
        u22.ImageTransparency = 1;

        return;
    end;

    if p25 then
        p25:clear();
    end;

    u22.ImageTransparency = u21[u22];
    u22.Image = p24;

    if u23 then
        u23 = u23.avatarUserId;
    end;

    u20[u22] = u23;

    if type(u23) == "number" and u23 > 0 then
        thumbnail(u23, function(p26) -- Line: 145
            -- upvalues: u20 (ref), u22 (copy), u23 (copy)
            if u20[u22] == u23 then
                u22.Image = p26;
            end;
        end);
    end;
end;

local function timeText(p27) -- Line: 153
    local v28 = math.floor(p27 * 10 + 0.5) / 10;
    local math_max_ret = math.max(0, v28);

    return math_max_ret >= 60 and ("%dm %04.1fs"):format(math.floor(math_max_ret / 60), math_max_ret % 60) or ("%.1fs"):format(math_max_ret);
end;

local function metricText(p29, p30) -- Line: 158
    -- upvalues: Widgets (copy)
    if p29 == "mvp" then
        return Widgets.number(p30) .. " XP";
    end;

    if p29 ~= "survival" then
        return p30 == 1 and "1 Catch" or Widgets.number(p30) .. " Catches";
    end;

    local v31 = math.floor(p30 * 10 + 0.5) / 10;
    local math_max_ret = math.max(0, v31);

    return math_max_ret >= 60 and ("%dm %04.1fs"):format(math.floor(math_max_ret / 60), math_max_ret % 60) or ("%.1fs"):format(math_max_ret);
end;

local function soloWinner(p32) -- Line: 168
    if type(p32.soloWinnerUserId) ~= "number" then
        return nil;
    end;

    for _, v in p32.participants do
        if v.userId == p32.soloWinnerUserId and (v.won == true and not (v.left or (v.caught or not v.hasRun))) then
            return v;
        end;
    end;

    return nil;
end;

local function outcomeText(p33) -- Line: 180
    local v34 = tostring(p33.result);

    if string.find(v34, "CATCHERS WIN", 1, true) then
        return "Chasers Win";
    end;

    if string.find(v34, "RUNNERS WIN", 1, true) then
        return "Runners Win";
    end;

    local v35 = 0;
    local v36 = nil;

    for _, v in p33.participants do
        if v.won then
            v35 = v35 + 1;
            v36 = v;
        end;
    end;

    return v35 == 1 and tostring(v36.name) .. " Wins" or "Match Complete";
end;

local function decode(p37) -- Line: 196
    -- upvalues: HttpService (copy), MatchSummaryConfig (copy), u2 (copy), LocalPlayer (copy)
    if p37 == "" then
        return nil;
    end;

    local success, result = pcall(HttpService.JSONDecode, HttpService, p37);

    if not (success and (type(result) == "table" and (result.version == 2 and (type(result.matchId) == "string" and (type(result.expiresAt) == "number" and (type(result.shownAt) == "number" and (type(result.result) == "string" and (type(result.rankings) == "table" and (type(result.participants) == "table" and #result.participants <= MatchSummaryConfig.MaxParticipants))))))))) then
        return nil;
    end;

    if result.tournament ~= nil then
        return nil;
    end;

    if not u2[result.mode] then
        return result;
    end;

    for _, v in result.participants do
        if v.userId == LocalPlayer.UserId then
            return result;
        end;
    end;

    return nil;
end;

local Font_new_ret = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.ExtraBold);
local Font_new_ret2 = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Italic);
local Color3_new_ret = Color3.new(1, 1, 1);
local Color3_new_ret2 = Color3.new(0, 0, 0);
local Color3_fromRGB_ret = Color3.fromRGB(255, 202, 58);
local Color3_fromRGB_ret2 = Color3.fromRGB(64, 156, 255);
local Color3_fromRGB_ret3 = Color3.fromRGB(236, 72, 236);
local TweenInfo_new_ret = TweenInfo.new(0.32, Enum.EasingStyle.Back, Enum.EasingDirection.Out);

local function make(p38, p39, p40) -- Line: 250
    local Instance_new_ret = Instance.new(p38);

    for i, v in p40 do
        Instance_new_ret[i] = v;
    end;

    Instance_new_ret.Parent = p39;

    return Instance_new_ret;
end;

local function corner(p41, p42) -- Line: 258
    local v43 = {
        CornerRadius = UDim.new(p42 or 0.12, 0)
    };
    local UICorner = Instance.new("UICorner");

    for i, v in v43 do
        UICorner[i] = v;
    end;

    UICorner.Parent = p41;
end;

local function outline(p44, p45, p46) -- Line: 261
    local v47 = {
        Color = p45,
        Thickness = p46,
        StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    };
    local UIStroke = Instance.new("UIStroke");

    for i, v in v47 do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = p44;

    return UIStroke;
end;

local function gradient(p48, p49, p50, p51) -- Line: 270
    local v52 = {
        Rotation = p51 or 90,
        Color = ColorSequence.new(p49, p50)
    };
    local UIGradient = Instance.new("UIGradient");

    for i, v in v52 do
        UIGradient[i] = v;
    end;

    UIGradient.Parent = p48;

    return UIGradient;
end;

local function text(p53, p54, p55, p56, p57, p58, p59, p60, p61, p62) -- Line: 274
    -- upvalues: Font_new_ret (copy), Color3_new_ret (copy), Color3_new_ret2 (copy)
    local v63 = {
        BackgroundTransparency = 1,
        TextScaled = true,
        ZIndex = 3,
        Name = p54,
        Position = UDim2.fromScale(p56, p57),
        Size = UDim2.fromScale(p58, p59),
        FontFace = p62 or Font_new_ret,
        Text = p55,
        TextColor3 = p60 or Color3_new_ret,
        TextXAlignment = p61 or Enum.TextXAlignment.Center
    };
    local TextLabel = Instance.new("TextLabel");

    for i, v in v63 do
        TextLabel[i] = v;
    end;

    TextLabel.Parent = p53;
    local v64 = {
        Thickness = 0.09,
        Color = Color3_new_ret2,
        StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize
    };
    local UIStroke = Instance.new("UIStroke");

    for i, v in v64 do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = TextLabel;

    return TextLabel;
end;

local function button(p65, p66, p67, p68, p69, p70, p71, p72, p73) -- Line: 290
    -- upvalues: Color3_new_ret (copy), Color3_new_ret2 (copy), text (copy), Font_new_ret2 (copy)
    local v74 = {
        AutoButtonColor = true,
        Text = "",
        ZIndex = 3,
        Name = p66,
        Position = UDim2.fromScale(p68, p69),
        Size = UDim2.fromScale(p70, p71),
        BackgroundColor3 = Color3_new_ret
    };
    local TextButton = Instance.new("TextButton");

    for i, v in v74 do
        TextButton[i] = v;
    end;

    TextButton.Parent = p65;
    local v75 = {
        CornerRadius = UDim.new(0.28, 0)
    };
    local UICorner = Instance.new("UICorner");

    for i, v in v75 do
        UICorner[i] = v;
    end;

    UICorner.Parent = TextButton;
    local v76 = {
        Thickness = 0.045,
        Color = Color3_new_ret2,
        StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    };
    local UIStroke = Instance.new("UIStroke");

    for i, v in v76 do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = TextButton;
    local v77 = {
        Rotation = 90,
        Color = ColorSequence.new(p72, p73)
    };
    local UIGradient = Instance.new("UIGradient");

    for i, v in v77 do
        UIGradient[i] = v;
    end;

    UIGradient.Parent = TextButton;
    local v78 = text(TextButton, "Label", p67, 0.05, 0.12, 0.9, 0.76, Color3_new_ret, nil, Font_new_ret2);
    v78.ZIndex = 4;

    return TextButton, v78;
end;

local function card(p79, p80, p81, p82, p83, p84, p85, p86, p87, p88) -- Line: 308
    -- upvalues: Color3_new_ret (copy)
    local v89 = {
        ClipsDescendants = true,
        Name = p80,
        Position = UDim2.fromScale(p81, p82),
        Size = UDim2.fromScale(p83, p84),
        BackgroundColor3 = Color3_new_ret
    };
    local Frame = Instance.new("Frame");

    for i, v in v89 do
        Frame[i] = v;
    end;

    Frame.Parent = p79;
    local v90 = {
        CornerRadius = UDim.new(0.09, 0)
    };
    local UICorner = Instance.new("UICorner");

    for i, v in v90 do
        UICorner[i] = v;
    end;

    UICorner.Parent = Frame;
    local v91 = {
        Rotation = 90,
        Color = ColorSequence.new(p85, p86)
    };
    local UIGradient = Instance.new("UIGradient");

    for i, v in v91 do
        UIGradient[i] = v;
    end;

    UIGradient.Parent = Frame;
    local v92 = {
        Thickness = 0.018,
        Color = p87,
        StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    };
    local UIStroke = Instance.new("UIStroke");

    for i, v in v92 do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = Frame;
    local v93 = {
        Name = "Rays",
        BackgroundTransparency = 1,
        Image = "rbxassetid://129028976496842",
        ImageTransparency = 0.55,
        ZIndex = 1,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = p88,
        Size = UDim2.fromScale(1.1, 1.1),
        ImageColor3 = p87
    };
    local ImageLabel = Instance.new("ImageLabel");

    for i, v in v93 do
        ImageLabel[i] = v;
    end;

    ImageLabel.Parent = Frame;
    local v94 = {
        AspectRatio = 1,
        DominantAxis = Enum.DominantAxis.Width
    };
    local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint");

    for i, v in v94 do
        UIAspectRatioConstraint[i] = v;
    end;

    UIAspectRatioConstraint.Parent = ImageLabel;

    return Frame, ImageLabel;
end;

local u95 = nil;

local function tile(p96, u97, p98, p99) -- Line: 337
    -- upvalues: Color3_new_ret (copy), EmotePose (copy), u95 (ref), Parent (copy), ClaimPop (copy), Color3_fromRGB_ret (copy), Color3_new_ret2 (copy), text (copy)
    local v100 = {
        Name = "Tile",
        BackgroundTransparency = 1,
        ZIndex = 2,
        Position = UDim2.fromScale(p98 + p99 / 2, 0.5),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Size = UDim2.fromScale(p99, 1)
    };
    local Frame = Instance.new("Frame");

    for i, v in v100 do
        Frame[i] = v;
    end;

    Frame.Parent = p96;
    local v101 = {
        Name = "Art",
        BackgroundTransparency = 1,
        ZIndex = 2,
        AnchorPoint = Vector2.new(0.5, 0),
        Position = UDim2.fromScale(0.5, 0),
        Size = UDim2.fromScale(1, 0.74)
    };
    local Frame2 = Instance.new("Frame");

    for i, v in v101 do
        Frame2[i] = v;
    end;

    Frame2.Parent = Frame;
    local v102 = {
        AspectRatio = 1,
        DominantAxis = Enum.DominantAxis.Height
    };
    local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint");

    for i, v in v102 do
        UIAspectRatioConstraint[i] = v;
    end;

    UIAspectRatioConstraint.Parent = Frame2;
    local v103 = nil;

    local function image(p104) -- Line: 356
        -- upvalues: Frame2 (copy)
        local v105 = {
            BackgroundTransparency = 1,
            ZIndex = 2,
            Size = UDim2.fromScale(1, 1),
            Image = p104 or "",
            ScaleType = Enum.ScaleType.Fit
        };
        local ImageLabel = Instance.new("ImageLabel");

        for i, v in v105 do
            ImageLabel[i] = v;
        end;

        ImageLabel.Parent = Frame2;
    end;

    if u97.emote or u97.knife then
        local v106 = {
            Name = "View",
            BackgroundTransparency = 1,
            LightDirection = Vector3.new(-1, -1, -1),
            ZIndex = 2,
            Size = UDim2.fromScale(1.2, 1.2),
            Position = UDim2.fromScale(-0.1, -0.12),
            Ambient = Color3.fromRGB(200, 200, 210),
            LightColor = Color3_new_ret
        };
        local ViewportFrame = Instance.new("ViewportFrame");

        for i, v in v106 do
            ViewportFrame[i] = v;
        end;

        ViewportFrame.Parent = Frame2;
        local success, result = pcall(function() -- Line: 376
            -- upvalues: u97 (copy), EmotePose (ref), ViewportFrame (copy), u95 (ref), Parent (ref)
            if u97.emote then
                return EmotePose.new(ViewportFrame, u97.emote);
            end;

            u95 = u95 or require(Parent.Shop.Preview);

            return u95.knife(ViewportFrame, u97.knife, nil);
        end);

        if success and result then
            v103 = result;
        else
            ViewportFrame:Destroy();
            image(u97.image);
        end;
    elseif u97.wheel then
        local v107 = ClaimPop.wheel();

        if v107 then
            local v108 = v107:Clone();
            v108.AnchorPoint = Vector2.new(0.5, 0.5);
            v108.Position = UDim2.fromScale(0.5, 0.5);
            v108.Size = UDim2.fromScale(0.92, 0.92);
            v108.Parent = Frame2;
        end;
    elseif u97.title then
        local v109 = {
            ZIndex = 2,
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromScale(0.5, 0.5),
            Size = UDim2.fromScale(1.2, 0.46),
            BackgroundColor3 = Color3_new_ret
        };
        local Frame3 = Instance.new("Frame");

        for i, v in v109 do
            Frame3[i] = v;
        end;

        Frame3.Parent = Frame2;
        local v110 = u97.color or Color3_fromRGB_ret;
        local v111 = v110:Lerp(Color3_new_ret, 0.3);
        local v112, v113 = v110:Lerp(Color3_new_ret2, 0.25);
        local v114 = {
            Rotation = v113 or 90,
            Color = ColorSequence.new(v111, v112)
        };
        local UIGradient = Instance.new("UIGradient");

        for i, v in v114 do
            UIGradient[i] = v;
        end;

        UIGradient.Parent = Frame3;
        local v115 = {
            CornerRadius = UDim.new(0.3, 0)
        };
        local UICorner = Instance.new("UICorner");

        for i, v in v115 do
            UICorner[i] = v;
        end;

        UICorner.Parent = Frame3;
        local v116 = {
            Thickness = 0.05,
            Color = Color3_new_ret2,
            StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize,
            ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        };
        local UIStroke = Instance.new("UIStroke");

        for i, v in v116 do
            UIStroke[i] = v;
        end;

        UIStroke.Parent = Frame3;
        text(Frame3, "Title", u97.title, 0.06, 0.12, 0.88, 0.76, Color3_new_ret);
    else
        image(u97.image);
    end;

    text(Frame, "Caption", u97.amount or (u97.caption or ""), -0.1, 0.72, 1.2, 0.28, Color3_new_ret).TextTruncate = Enum.TextTruncate.AtEnd;
    local UIScale = Instance.new("UIScale");

    for i, v in {
        Scale = 0
    } do
        UIScale[i] = v;
    end;

    UIScale.Parent = Frame;

    return Frame, v103, UIScale;
end;

local Icon = require(game.ReplicatedStorage.ChickenOrHero.Game.CandyCorn).Icon;

local function keyIcon(p117) -- Line: 425
    local v118 = require(game.ReplicatedStorage.ChickenOrHero.Crates.CrateCatalog).get(p117 and p117.KeyCrate or "HalloweenEmote");

    if v118 then
        v118 = v118.Icon;
    end;

    return v118;
end;

local function rewardSpecs(p119) -- Line: 429
    -- upvalues: SkinCatalog (copy), ClaimPop (copy), EmoteCatalog (copy), JourneyConfig (copy), Widgets (copy), Icon (copy)
    local v120 = {};

    if not p119 then
        return v120;
    end;

    local v121 = p119.SkinId and SkinCatalog.get(p119.SkinId);

    if v121 then
        local v122 = {};
        local v123;

        if p119.KnifeIcon then
            v123 = nil;
        else
            v123 = v121;
        end;

        v122.knife = v123;
        v122.image = p119.KnifeIcon;
        v122.caption = ClaimPop.titleCase(v121.SourceName or v121.Name);
        table.insert(v120, v122);
    end;

    local v124 = p119.EmoteId and EmoteCatalog.get(p119.EmoteId);

    if v124 then
        local v125 = {
            emote = p119.EmoteId,
            image = ClaimPop.EMOTE_IMAGE,
            caption = tostring(v124.Name)
        };
        table.insert(v120, v125);
    end;

    local v126 = p119.Badge and JourneyConfig.Badges[p119.Badge];

    if v126 then
        table.insert(v120, {
            caption = "Title",
            title = v126.Name,
            color = v126.Color
        });
    end;

    if (p119.Spins or 0) > 0 then
        table.insert(v120, {
            wheel = true,
            amount = "×" .. p119.Spins
        });
    end;

    if (p119.Gems or 0) > 0 then
        local v127 = {
            image = ClaimPop.GEM_IMAGE,
            amount = "×" .. Widgets.number(p119.Gems)
        };
        table.insert(v120, v127);
    end;

    if (p119.Coins or 0) > 0 then
        local v128 = {
            image = ClaimPop.COIN_IMAGE,
            amount = "×" .. Widgets.number(p119.Coins)
        };
        table.insert(v120, v128);
    end;

    if (p119.CandyCorn or 0) > 0 then
        local v129 = {
            image = Icon,
            amount = "×" .. Widgets.number(p119.CandyCorn)
        };
        table.insert(v120, v129);
    end;

    if (p119.Keys or 0) > 0 then
        local v130 = {
            caption = "Crate Key"
        };
        local v131 = require(game.ReplicatedStorage.ChickenOrHero.Crates.CrateCatalog).get(p119 and (p119.KeyCrate or "HalloweenEmote") or "HalloweenEmote");

        if v131 then
            v131 = v131.Icon;
        end;

        v130.image = v131;
        v130.amount = "×" .. p119.Keys;
        table.insert(v120, v130);
    end;

    return v120;
end;

local function buildJourney(p132) -- Line: 469
    -- upvalues: Color3_new_ret (copy), text (copy), Font_new_ret2 (copy), Color3_fromRGB_ret (copy), Color3_fromRGB_ret2 (copy), card (copy), Color3_fromRGB_ret3 (copy), button (copy)
    local v133 = {
        on = false,
        frame = p132,
        live = {},
        signatures = {},
        rays = {},
        pops = {},
        parts = {}
    };

    for _, child in p132:GetChildren() do
        if child:IsA("GuiObject") then
            v133.parts[child] = { child.Position, child.Size };
        end;
    end;

    v133.frameSize = p132.Size;
    v133.aspect = p132:FindFirstChildOfClass("UIAspectRatioConstraint");
    v133.aspectRatio = v133.aspect and v133.aspect.AspectRatio;
    local v134 = {
        Name = "Journey",
        Visible = false,
        AnchorPoint = Vector2.new(0.5, 0),
        Position = UDim2.fromScale(0.5, 0.605),
        Size = UDim2.fromScale(0.97, 0.38),
        BackgroundColor3 = Color3_new_ret
    };
    local Frame = Instance.new("Frame");

    for i, v in v134 do
        Frame[i] = v;
    end;

    Frame.Parent = p132;
    local v135 = {
        CornerRadius = UDim.new(0.06, 0)
    };
    local UICorner = Instance.new("UICorner");

    for i, v in v135 do
        UICorner[i] = v;
    end;

    UICorner.Parent = Frame;
    local Color3_fromRGB_ret4 = Color3.fromRGB(24, 34, 52);
    local Color3_fromRGB_ret5, v136 = Color3.fromRGB(10, 13, 22);
    local v137 = {
        Rotation = v136 or 90,
        Color = ColorSequence.new(Color3_fromRGB_ret4, Color3_fromRGB_ret5)
    };
    local UIGradient = Instance.new("UIGradient");

    for i, v in v137 do
        UIGradient[i] = v;
    end;

    UIGradient.Parent = Frame;
    local v138 = {
        Thickness = 0.005,
        Color = Color3.fromRGB(76, 76, 81),
        StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    };
    local UIStroke = Instance.new("UIStroke");

    for i, v in v138 do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = Frame;
    v133.section = Frame;
    local UIScale = Instance.new("UIScale");

    for i, v in {
        Scale = 1
    } do
        UIScale[i] = v;
    end;

    UIScale.Parent = Frame;
    v133.sectionScale = UIScale;
    local v139 = text(Frame, "Heading", "JOURNEY", 0.02, 0.03, 0.27, 0.16, Color3_new_ret, Enum.TextXAlignment.Left, Font_new_ret2);
    local Color3_fromRGB_ret6, v140 = Color3.fromRGB(190, 220, 255);
    local v141 = {
        Rotation = v140 or 90,
        Color = ColorSequence.new(Color3_new_ret, Color3_fromRGB_ret6)
    };
    local UIGradient2 = Instance.new("UIGradient");

    for i, v in v141 do
        UIGradient2[i] = v;
    end;

    UIGradient2.Parent = v139;
    v133.tier = text(Frame, "Tier", "", 0.02, 0.19, 0.27, 0.085, Color3_fromRGB_ret, Enum.TextXAlignment.Left, Font_new_ret2);
    local v142 = {
        Name = "SeasonBar",
        Position = UDim2.fromScale(0.31, 0.05),
        Size = UDim2.fromScale(0.67, 0.12),
        BackgroundColor3 = Color3_new_ret
    };
    local Frame2 = Instance.new("Frame");

    for i, v in v142 do
        Frame2[i] = v;
    end;

    Frame2.Parent = Frame;
    local v143 = {
        CornerRadius = UDim.new(0.5, 0)
    };
    local UICorner2 = Instance.new("UICorner");

    for i, v in v143 do
        UICorner2[i] = v;
    end;

    UICorner2.Parent = Frame2;
    local Color3_fromRGB_ret7 = Color3.fromRGB(14, 26, 48);
    local Color3_fromRGB_ret8, v144 = Color3.fromRGB(8, 14, 28);
    local v145 = {
        Rotation = v144 or 90,
        Color = ColorSequence.new(Color3_fromRGB_ret7, Color3_fromRGB_ret8)
    };
    local UIGradient3 = Instance.new("UIGradient");

    for i, v in v145 do
        UIGradient3[i] = v;
    end;

    UIGradient3.Parent = Frame2;
    local v146 = {
        Thickness = 0.012,
        Color = Color3_fromRGB_ret2,
        StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    };
    local UIStroke2 = Instance.new("UIStroke");

    for i, v in v146 do
        UIStroke2[i] = v;
    end;

    UIStroke2.Parent = Frame2;
    local v147 = {
        Name = "Fill",
        Size = UDim2.fromScale(0, 1),
        BackgroundColor3 = Color3_new_ret
    };
    local Frame3 = Instance.new("Frame");

    for i, v in v147 do
        Frame3[i] = v;
    end;

    Frame3.Parent = Frame2;
    v133.fill = Frame3;
    local fill = v133.fill;
    local v148 = {
        CornerRadius = UDim.new(0.5, 0)
    };
    local UICorner3 = Instance.new("UICorner");

    for i, v in v148 do
        UICorner3[i] = v;
    end;

    UICorner3.Parent = fill;
    local fill2 = v133.fill;
    local Color3_fromRGB_ret9 = Color3.fromRGB(110, 225, 255);
    local Color3_fromRGB_ret10, v149 = Color3.fromRGB(20, 120, 235);
    local v150 = {
        Rotation = v149 or 90,
        Color = ColorSequence.new(Color3_fromRGB_ret9, Color3_fromRGB_ret10)
    };
    local UIGradient4 = Instance.new("UIGradient");

    for i, v in v150 do
        UIGradient4[i] = v;
    end;

    UIGradient4.Parent = fill2;
    local fill3 = v133.fill;
    local v151 = {
        Name = "Shine",
        BackgroundTransparency = 0.6,
        ZIndex = 2,
        Position = UDim2.fromScale(0.02, 0.1),
        Size = UDim2.fromScale(0.96, 0.28),
        BackgroundColor3 = Color3_new_ret
    };
    local Frame4 = Instance.new("Frame");

    for i, v in v151 do
        Frame4[i] = v;
    end;

    Frame4.Parent = fill3;
    local v152 = {
        CornerRadius = UDim.new(0.5, 0)
    };
    local UICorner4 = Instance.new("UICorner");

    for i, v in v152 do
        UICorner4[i] = v;
    end;

    UICorner4.Parent = Frame4;
    v133.gain = text(Frame2, "Gain", "", 0.03, 0.14, 0.45, 0.72, Color3_new_ret);
    v133.count = text(Frame2, "Count", "", 0.52, 0.14, 0.45, 0.72, Color3_new_ret);
    v133.next = text(Frame, "Next", "", 0.31, 0.2, 0.67, 0.075, Color3.fromRGB(215, 222, 235), Enum.TextXAlignment.Right);
    local v153, v154 = card(Frame, "Free", 0.015, 0.31, 0.32, 0.66, Color3.fromRGB(34, 86, 176), Color3.fromRGB(10, 26, 66), Color3_fromRGB_ret2, UDim2.fromScale(0.5, 0.45));
    table.insert(v133.rays, v154);
    local v155 = text(v153, "Title", "FREE", 0.05, 0.03, 0.9, 0.17, Color3_new_ret, nil, Font_new_ret2);
    local Color3_fromRGB_ret11 = Color3.fromRGB(190, 235, 255);
    local Color3_fromRGB_ret12, v156 = Color3.fromRGB(90, 180, 255);
    local v157 = {
        Rotation = v156 or 90,
        Color = ColorSequence.new(Color3_fromRGB_ret11, Color3_fromRGB_ret12)
    };
    local UIGradient5 = Instance.new("UIGradient");

    for i, v in v157 do
        UIGradient5[i] = v;
    end;

    UIGradient5.Parent = v155;
    local v158 = {
        Name = "Art",
        BackgroundTransparency = 1,
        ZIndex = 2,
        Position = UDim2.fromScale(0.04, 0.2),
        Size = UDim2.fromScale(0.92, 0.58)
    };
    local Frame5 = Instance.new("Frame");

    for i, v in v158 do
        Frame5[i] = v;
    end;

    Frame5.Parent = v153;
    v133.freeArt = Frame5;
    local v159 = {
        Name = "Status",
        AutoButtonColor = true,
        Text = "",
        ZIndex = 3,
        Position = UDim2.fromScale(0.07, 0.8),
        Size = UDim2.fromScale(0.86, 0.15),
        BackgroundColor3 = Color3_new_ret
    };
    local TextButton = Instance.new("TextButton");

    for i, v in v159 do
        TextButton[i] = v;
    end;

    TextButton.Parent = v153;
    local v160 = {
        CornerRadius = UDim.new(0.3, 0)
    };
    local UICorner5 = Instance.new("UICorner");

    for i, v in v160 do
        UICorner5[i] = v;
    end;

    UICorner5.Parent = TextButton;
    local Color3_fromRGB_ret13 = Color3.fromRGB(36, 64, 110);
    local Color3_fromRGB_ret14, v161 = Color3.fromRGB(18, 36, 70);
    local v162 = {
        Rotation = v161 or 90,
        Color = ColorSequence.new(Color3_fromRGB_ret13, Color3_fromRGB_ret14)
    };
    local UIGradient6 = Instance.new("UIGradient");

    for i, v in v162 do
        UIGradient6[i] = v;
    end;

    UIGradient6.Parent = TextButton;
    local v163 = {
        Thickness = 0.025,
        Color = Color3_fromRGB_ret2,
        StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    };
    local UIStroke3 = Instance.new("UIStroke");

    for i, v in v163 do
        UIStroke3[i] = v;
    end;

    UIStroke3.Parent = TextButton;
    v133.freeStatus = text(TextButton, "Label", "", 0.04, 0.12, 0.92, 0.76, Color3.fromRGB(205, 225, 255));
    v133.freeStatus.ZIndex = 4;
    v133.freePill = TextButton;
    local v164, v165 = card(Frame, "Premium", 0.35, 0.31, 0.635, 0.66, Color3.fromRGB(112, 34, 150), Color3.fromRGB(40, 10, 66), Color3_fromRGB_ret3, UDim2.fromScale(0.5, 0.45));
    table.insert(v133.rays, v165);
    v133.premiumTitle = text(v164, "Title", "PREMIUM", 0.03, 0.03, 0.42, 0.17, Color3_new_ret, Enum.TextXAlignment.Left, Font_new_ret2);
    local premiumTitle = v133.premiumTitle;
    local Color3_fromRGB_ret15 = Color3.fromRGB(255, 200, 255);
    local Color3_fromRGB_ret16, v166 = Color3.fromRGB(205, 110, 255);
    local v167 = {
        Rotation = v166 or 90,
        Color = ColorSequence.new(Color3_fromRGB_ret15, Color3_fromRGB_ret16)
    };
    local UIGradient7 = Instance.new("UIGradient");

    for i, v in v167 do
        UIGradient7[i] = v;
    end;

    UIGradient7.Parent = premiumTitle;
    v133.premiumNote = text(v164, "Note", "", 0.44, 0.05, 0.53, 0.12, Color3.fromRGB(245, 215, 255), Enum.TextXAlignment.Right, Font_new_ret2);
    local v168 = {
        Name = "Art",
        BackgroundTransparency = 1,
        ZIndex = 2,
        Position = UDim2.fromScale(0.02, 0.2),
        Size = UDim2.fromScale(0.96, 0.57)
    };
    local Frame6 = Instance.new("Frame");

    for i, v in v168 do
        Frame6[i] = v;
    end;

    Frame6.Parent = v164;
    v133.premiumArt = Frame6;

    for _, v in { { 0.04, 0.22 }, { 0.92, 0.25 }, { 0.48, 0.18 }, { 0.27, 0.66 }, { 0.72, 0.64 } } do
        local v169 = {
            Name = "Sparkle",
            BackgroundTransparency = 1,
            Image = "rbxasset://textures/particles/sparkles_main.dds",
            ZIndex = 2,
            Position = UDim2.fromScale(v[1], v[2]),
            Size = UDim2.fromScale(0.06, 0.14),
            ImageColor3 = Color3.fromRGB(255, 236, 140),
            ScaleType = Enum.ScaleType.Fit
        };
        local ImageLabel = Instance.new("ImageLabel");

        for i, v2 in v169 do
            ImageLabel[i] = v2;
        end;

        ImageLabel.Parent = v164;
        local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint");

        for i, v2 in {
            AspectRatio = 1
        } do
            UIAspectRatioConstraint[i] = v2;
        end;

        UIAspectRatioConstraint.Parent = ImageLabel;
    end;

    local v170, v171 = button(v164, "Unlock", "Unlock Premium", 0.03, 0.79, 0.62, 0.17, Color3.fromRGB(110, 235, 90), Color3.fromRGB(30, 160, 50));
    v133.unlock = v170;
    v133.unlockLabel = v171;
    v133.view = button(v164, "View", "View Rewards", 0.67, 0.79, 0.3, 0.17, Color3.fromRGB(130, 130, 138), Color3.fromRGB(70, 70, 78));
    v133.premiumStatus = text(v164, "Status", "", 0.03, 0.8, 0.62, 0.15, Color3.fromRGB(245, 215, 255));

    return v133;
end;

local function journeyLayout(p172, p173) -- Line: 571
    if p172.on == p173 then
        return;
    end;

    p172.on = p173;
    local v174 = p173 and 1.12 or 1;
    local v175 = p173 and 0.6 or 1;
    local frameSize = p172.frameSize;
    p172.frame.Size = UDim2.new(frameSize.X.Scale, frameSize.X.Offset, frameSize.Y.Scale * v174, frameSize.Y.Offset);

    if p172.aspect then
        p172.aspect.AspectRatio = p172.aspectRatio / v174;
    end;

    for i, v in p172.parts do
        if i.Parent == p172.frame then
            local v176 = v[1];
            local v177 = v[2];
            i.Position = UDim2.new(v176.X.Scale, v176.X.Offset, v176.Y.Scale * v175, v176.Y.Offset);
            i.Size = UDim2.new(v177.X.Scale, v177.X.Offset, v177.Y.Scale * v175, v177.Y.Offset);
        end;
    end;

    p172.section.Visible = p173;
end;

local function fillArt(p178, p179, p180, p181, p182, p183) -- Line: 595
    -- upvalues: tile (copy), TweenService (copy)
    if p178.signatures[p179] == p182 then
        return;
    end;

    p178.signatures[p179] = p182;

    for _, v in p178.live[p179] or {} do
        pcall(v.destroy, v);
    end;

    p178.live[p179] = {};
    p180:ClearAllChildren();
    local math_min_ret = math.min(#p181, p183);
    local v184 = 1 / math.max(math_min_ret, 1);

    for i = 1, math_min_ret do
        local _, v185, v186 = tile(p180, p181[i], (i - 1) * v184, v184);

        if v185 then
            table.insert(p178.live[p179], v185);
        end;

        local v187 = TweenService:Create(v186, TweenInfo.new(0.32, Enum.EasingStyle.Back, Enum.EasingDirection.Out, 0, false, (i - 1) * 0.07), {
            Scale = 1
        });
        table.insert(p178.pops, v187);
        v187:Play();
        local _ = i;
    end;
end;

local function clearJourney(p188) -- Line: 618
    for _, v in p188.pops do
        v:Cancel();
    end;

    table.clear(p188.pops);

    for i, v in p188.live do
        for _, v2 in v do
            pcall(v2.destroy, v2);
        end;

        p188.live[i] = nil;
    end;

    table.clear(p188.signatures);
    p188.freeArt:ClearAllChildren();
    p188.premiumArt:ClearAllChildren();
end;

local function popJourney(p189) -- Line: 635
    -- upvalues: TweenService (copy), TweenInfo_new_ret (copy)
    p189.sectionScale.Scale = 0.9;
    local v190 = TweenService:Create(p189.sectionScale, TweenInfo_new_ret, {
        Scale = 1
    });
    table.insert(p189.pops, v190);
    v190:Play();
end;

local function spinJourney(p191, p192) -- Line: 643
    for i, v in p191.rays do
        v.Rotation = (v.Rotation + p192 * (i == 1 and 14 or -10)) % 360;
    end;

    for _, v in p191.live do
        for _, v2 in v do
            if v2.step then
                v2:step(p192);
            end;
        end;
    end;
end;

local function premiumSummary(p193, p194) -- Line: 658
    -- upvalues: JourneyConfig (copy), rewardSpecs (copy), ClaimPop (copy), Widgets (copy), Icon (copy), Color3_fromRGB_ret3 (copy)
    local v195 = {
        skins = p193.skins or {},
        emotes = p193.emotes or {},
        badges = p193.badges or {}
    };
    local v196 = 0;
    local v197 = 0;
    local v198 = 0;
    local v199 = nil;
    local v200 = {};
    local v201 = 0;
    local v202 = 0;
    local v203 = 0;

    for i = 1, p194 do
        local v204 = JourneyConfig.Rewards[i];

        if v204 then
            v204 = JourneyConfig.effective(v204.Premium, p193.rebirths or 0, v195);
        end;

        local v205;

        if v204 then
            v205 = i;
            local v206 = false;

            for _, v in rewardSpecs({
                SkinId = v204.SkinId,
                KnifeIcon = v204.KnifeIcon,
                EmoteId = v204.EmoteId,
                Badge = v204.Badge
            }) do
                table.insert(v200, v);
                v206 = true;
            end;

            v201 = v201 + (v204.Spins or 0);
            v202 = v202 + (v204.Gems or 0);
            v196 = v196 + (v204.Coins or 0);
            v197 = v197 + (v204.CandyCorn or 0);
            v198 = v198 + (v204.Keys or 0);
            v199 = v199 or ((v204.Keys or 0) > 0 and v204 and v204 or nil);

            if v206 or ((v204.Spins or 0) > 0 or ((v204.Gems or 0) > 0 or ((v204.Coins or 0) > 0 or ((v204.CandyCorn or 0) > 0 or (v204.Keys or 0) > 0)))) then
                v203 = v203 + 1;
            end;
        else
            v205 = i;
        end;
    end;

    local function rank(p207) -- Line: 684
        return p207.emote and 2 or (p207.title and 3 or 1);
    end;

    for i, v in v200 do
        v.order = i;
    end;

    table.sort(v200, function(p208, p209) -- Line: 690
        if (p208.emote and 2 or (p208.title and 3 or 1)) == (p209.emote and 2 or (p209.title and 3 or 1)) then
            return p208.order < p209.order;
        end;

        return (p208.emote and 2 or (p208.title and 3 or 1)) < (p209.emote and 2 or (p209.title and 3 or 1));
    end);
    local v210 = {};

    if v200[1] then
        table.insert(v210, v200[1]);
    end;

    if v202 > 0 then
        local v211 = {
            image = ClaimPop.GEM_IMAGE,
            amount = "×" .. Widgets.number(v202)
        };
        table.insert(v210, v211);
    end;

    if v201 > 0 then
        table.insert(v210, {
            wheel = true,
            amount = "×" .. v201
        });
    end;

    if v197 > 0 then
        local v212 = {
            image = Icon,
            amount = "×" .. Widgets.number(v197)
        };
        table.insert(v210, v212);
    end;

    if v198 > 0 then
        local v213 = {
            caption = "Crate Keys"
        };
        local v214 = require(game.ReplicatedStorage.ChickenOrHero.Crates.CrateCatalog).get(v199 and v199.KeyCrate or "HalloweenEmote");

        if v214 then
            v214 = v214.Icon;
        end;

        v213.image = v214;
        v213.amount = "×" .. v198;
        table.insert(v210, v213);
    end;

    local v215 = #v200 - 1;

    if v215 > 0 then
        table.insert(v210, {
            caption = "Emotes & more",
            title = "+" .. v215 .. " MORE",
            color = Color3_fromRGB_ret3
        });
    elseif v196 > 0 then
        local v216 = {
            image = ClaimPop.COIN_IMAGE,
            amount = "×" .. Widgets.number(v196)
        };
        table.insert(v210, v216);
    end;

    return v210, v203;
end;

local function nextReward(p217, p218, p219) -- Line: 726
    -- upvalues: JourneyConfig (copy)
    local v220 = {
        skins = p217.skins or {},
        emotes = p217.emotes or {},
        badges = p217.badges or {}
    };
    local v221 = p217.claims or {};

    for i = 1, p219 do
        local v222 = JourneyConfig.Rewards[i];

        if v222 then
            v222 = v222[p218];
        end;

        if v222 and v221[JourneyConfig.TrackId .. ":" .. v222.Key] ~= true then
            return JourneyConfig.effective(v222, p217.rebirths or 0, v220), i, true;
        end;

        local _ = i;
    end;

    local v223 = p219 + 1;
    local v224 = JourneyConfig.Rewards[v223];

    if v224 and v224[p218] then
        return JourneyConfig.effective(v224[p218], p217.rebirths or 0, v220), v223, false;
    end;

    return nil, nil, false;
end;

local function signatureOf(p225) -- Line: 744
    local v226 = {};

    for _, v in p225 do
        local v227 = tostring(v.caption) .. "=" .. tostring(v.amount) .. "/" .. tostring(v.emote or (v.title or v.image));
        table.insert(v226, v227);
    end;

    return table.concat(v226, ";");
end;

local function drawJourney(p228, p229, p230, p231) -- Line: 754
    -- upvalues: Widgets (copy), JourneyMath (copy), JourneyConfig (copy), nextReward (copy), rewardSpecs (copy), fillArt (copy), signatureOf (copy), premiumSummary (copy)
    if not (p229 and p229.loaded) then
        Widgets.setText(p228.tier, "");
        Widgets.setText(p228.next, "Loading your Journey…");

        return;
    end;

    local v232 = p229.xp or 0;
    local math_max_ret = math.max(0, v232 - p230);
    local v233 = JourneyMath.state(math_max_ret + (v232 - math_max_ret) * p231, JourneyConfig);
    local complete = v233.complete;
    local setText = Widgets.setText;
    local tier = p228.tier;
    local v234;

    if complete then
        v234 = ("TIER %d · MAX"):format(v233.tier);
    else
        v234 = ("TIER %d → %d"):format(v233.tier, v233.tier + 1);
    end;

    setText(tier, v234);
    local fill = p228.fill;
    local UDim2_fromScale = UDim2.fromScale;
    local v235;

    if complete then
        v235 = 1;
    else
        local math_clamp_ret = math.clamp(v233.ratio, 0, 1);
        v235 = math.max(0.08, math_clamp_ret);
    end;

    fill.Size = UDim2_fromScale(v235, 1);
    Widgets.setText(p228.gain, p230 <= 0 and "" or ("+%s SEASON XP"):format(Widgets.number((math.round(p230 * p231)))));
    Widgets.setText(p228.count, complete and "MAX TIER" or ("%s / %s XP"):format(Widgets.number((math.floor(v233.earned))), Widgets.number(v233.needed)));
    Widgets.setText(p228.next, complete and "Every tier unlocked this season" or ("%s XP to your next rewards"):format(Widgets.number((math.ceil(v233.needed - v233.earned)))));
    local tier2 = JourneyMath.state(v232, JourneyConfig).tier;
    local v236, v237, v238 = nextReward(p229, "Free", tier2);
    local v239 = rewardSpecs(v236);
    fillArt(p228, "free", p228.freeArt, v239, signatureOf(v239), 2);
    Widgets.setText(p228.freeStatus, not v236 and "All collected" or (v238 and "Ready · claim in Journey" or ("Unlocks at Tier %d"):format(v237)));
    local v240;

    if JourneyConfig.PremiumPassId > 0 then
        v240 = JourneyConfig.PurchasesEnabledUniverses[game.GameId] == true;
    else
        v240 = false;
    end;

    if not p229.premium then
        local v241, v242 = premiumSummary(p229, tier2);
        fillArt(p228, "premium", p228.premiumArt, v241, signatureOf(v241), 4);
        Widgets.setText(p228.premiumTitle, "🔒 PREMIUM");
        Widgets.setText(p228.premiumNote, v242 <= 1 and "Get these rewards too" or ("%d tiers of rewards waiting"):format(v242));
        p228.unlock.Visible = v240;
        p228.premiumStatus.Visible = not v240;
        Widgets.setText(p228.premiumStatus, "Premium unlocks in the Journey");

        return;
    end;

    local v243, v244, v245 = nextReward(p229, "Premium", tier2);
    local v246 = rewardSpecs(v243);
    fillArt(p228, "premium", p228.premiumArt, v246, signatureOf(v246), 4);
    Widgets.setText(p228.premiumTitle, "PREMIUM");
    Widgets.setText(p228.premiumNote, "Your pass");
    Widgets.setText(p228.premiumStatus, not v243 and "All collected" or (v245 and "Ready · claim in Journey" or ("Unlocks at Tier %d"):format(v244)));
    p228.unlock.Visible = false;
    p228.premiumStatus.Visible = true;
end;

function v1.start(p247) -- Line: 800
    -- upvalues: Parent2 (copy), Registry (copy), AvatarPortrait (copy), u4 (copy), u3 (copy), buildJourney (copy), Widgets (copy), TweenService (copy), Lighting (copy), MatchSummaryConfig (copy), VerifiedName (copy), portrait (copy), LocalPlayer (copy), ProgressionMath (copy), u2 (copy), soloWinner (copy), outcomeText (copy), clearJourney (copy), journeyLayout (copy), JourneyConfig (copy), TweenInfo_new_ret (copy), drawJourney (copy), spinJourney (copy), UserInputService (copy), Panels (copy), ContextActionService (copy), RunService (copy), u6 (copy), HudNavigation (copy), u7 (copy), decode (copy), u5 (copy)
    local Game = Parent2.Game;
    local MatchSummary = Game:WaitForChild("MatchSummary");
    local Session = Game:WaitForChild("Session");
    local PresentationCues = Parent2.Audio:WaitForChild("PresentationCues");
    local u248 = p247 or Registry.screen("UI");
    local v249 = Registry.get(u248, "HolderFrame.MatchResult");
    local u250 = Registry.get(v249, "Header.Title.Winner");
    local u251 = Registry.get(v249, "Header.Title.Description");
    local u252 = Registry.get(v249, "Header.Countdown");
    local u253 = Registry.get(v249, "MVPContainer");
    local u254 = Registry.get(v249, "Tabs");
    local u255 = Registry.get(v249, "Empty");
    local u256 = Registry.get(v249, "SoloWin");
    local u257 = Registry.get(v249, "EventRewards");
    local u258 = Registry.get(u257, "Reward");
    u258.RichText = true;
    local u259 = Registry.get(u257, "Caption");
    local u260 = Registry.get(v249, "Personal.Earned");
    local u261 = Registry.get(v249, "Personal.Breakdown");
    local u262 = Registry.get(v249, "Personal.LevelUp");
    local u263 = Registry.get(v249, "Footer.CurrentLevel");
    local u264 = Registry.get(v249, "Footer.NextLevel");
    local u265 = Registry.get(v249, "Footer.Bar.InnerBar");
    local u266 = Registry.get(v249, "Footer.Bar.XP");
    local u267 = Registry.get(u256, "Card.NameXP.NameText");
    local u268 = Registry.get(u256, "Card.PlayerIcon");
    local u269 = AvatarPortrait.new(Registry.get(u268, "Viewport"));
    local Image = Registry.get(u253, "1stPlace.PlayerIcon").Image;
    local TextColor3 = u251.TextColor3;
    u265.AnchorPoint = Vector2.new(0, 0.5);
    u265.Position = UDim2.fromScale(0, 0.5);
    u267.RichText = true;
    local u270 = {};

    for i, v in u4 do
        local v271 = Registry.get(u253, v);
        local UIScale = Instance.new("UIScale");
        UIScale.Parent = v271;
        local v272 = {
            frame = v271,
            scale = UIScale,
            spot = Registry.get(v271, "Spot"),
            icon = Registry.get(v271, "PlayerIcon"),
            view = AvatarPortrait.new(Registry.get(v271, "PlayerIcon.Viewport")),
            name = Registry.get(v271, "NameXP.NameText"),
            metric = Registry.get(v271, "NameXP.Xp")
        };
        v272.name.RichText = true;
        u270[i] = v272;
    end;

    local u273 = {};

    for i, v in u3 do
        u273[i] = Registry.get(u254, v.key);
    end;

    local u274 = buildJourney(v249);
    local JourneyEvent = Parent2.Progression:FindFirstChild("JourneyEvent");
    local u275 = nil;
    local u276 = (1 / 0);

    if JourneyEvent then
        JourneyEvent.OnClientEvent:Connect(function(p277, p278) -- Line: 862
            -- upvalues: u275 (ref), u276 (ref)
            if p277 == "State" and type(p278) == "table" then
                u275 = p278;
                u276 = (1 / 0);
            end;
        end);
    end;

    local u279 = Widgets.looks(u273[1], u273[2]);
    local u280 = nil;
    local u281 = nil;
    local u282 = nil;
    local u283 = nil;
    local u284 = nil;
    local u285 = {};
    local u286 = nil;
    local u287 = false;
    local u288 = nil;
    local u289 = 0;
    local u290 = nil;
    local u291 = 0;
    local u292 = nil;
    local u293 = 0;
    local u294 = nil;
    local u295 = {};
    local u296 = nil;
    local u297 = nil;
    local u298 = nil;
    local u299 = 0;

    local function cue(p300, p301) -- Line: 881
        -- upvalues: PresentationCues (copy)
        PresentationCues:Fire(p300, p301);
    end;

    local function cancelTweens() -- Line: 885
        -- upvalues: u295 (copy)
        for _, v in u295 do
            v:Cancel();
        end;

        table.clear(u295);
    end;

    local function pop(p302, p303) -- Line: 892
        -- upvalues: TweenService (ref), u295 (copy)
        p302.scale.Scale = 0.9;
        local v304 = TweenService:Create(p302.scale, TweenInfo.new(0.32, Enum.EasingStyle.Back, Enum.EasingDirection.Out, 0, false, p303), {
            Scale = 1
        });
        table.insert(u295, v304);
        v304:Play();
    end;

    local function focus(p305) -- Line: 904
        -- upvalues: u298 (ref), u297 (ref), Lighting (ref), TweenService (ref), MatchSummaryConfig (ref)
        if u298 then
            u298:Cancel();
            u298 = nil;
        end;

        if p305 and not u297 then
            u297 = Instance.new("BlurEffect");
            u297.Name = "MatchResultBlur";
            u297.Size = 0;
            u297.Parent = Lighting;
        end;

        if not u297 then
            return;
        end;

        local u306 = TweenService:Create(u297, TweenInfo.new(p305 and MatchSummaryConfig.FadeIn or MatchSummaryConfig.FadeOut, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = p305 and (MatchSummaryConfig.BackgroundBlurSize or 8) or 0
        });
        u298 = u306;

        if not p305 then
            u306.Completed:Once(function(p307) -- Line: 925
                -- upvalues: u298 (ref), u306 (copy), u297 (ref)
                if u298 == u306 and p307 == Enum.PlaybackState.Completed then
                    u298 = nil;
                    u297:Destroy();
                    u297 = nil;
                end;
            end);
        end;

        u306:Play();
    end;

    local function layout(p308) -- Line: 936
        -- upvalues: u288 (ref), u289 (ref), u253 (copy), u287 (ref), u254 (copy), u256 (copy), u257 (copy), u255 (copy)
        local v309;

        if u288 == nil then
            v309 = false;
        else
            v309 = p308 < u289;
        end;

        u253.Visible = not u287 and not v309;
        u254.Visible = not u287 and not v309;
        u256.Visible = v309;
        u257.Visible = u287;

        if u287 or v309 then
            u255.Visible = false;
        end;
    end;

    local function setStage(p310, p311) -- Line: 947
        -- upvalues: u290 (ref), u295 (copy), u291 (ref), u3 (ref), u282 (ref), Widgets (ref), u251 (copy), u273 (copy), u279 (copy), u255 (copy), u270 (copy), u285 (copy), VerifiedName (ref), portrait (ref), Image (copy), pop (copy), MatchSummaryConfig (ref), PresentationCues (copy)
        if u290 == p310 then
            return;
        end;

        for _, v in u295 do
            v:Cancel();
        end;

        table.clear(u295);
        u290 = p310;
        u291 = p311;
        local v312 = u3[p310];
        local v313 = u282.rankings[v312.key] or {};
        Widgets.setText(u251, v312.title);
        u251.TextColor3 = v312.color;

        for i, v in u273 do
            u279(v, i == p310);
        end;

        Widgets.setText(u255, v312.empty);
        u255.Visible = #v313 == 0;

        for i, v in u270 do
            local v314 = v313[i];
            local v315;

            if v314 then
                v315 = u285[v314.userId];
            else
                v315 = v314;
            end;

            v.award = v315 and v314 and v314 or nil;
            v.frame.Visible = v315 ~= nil;

            if not v315 then
                v.view:clear();
            end;

            if v315 then
                Widgets.setText(v.spot, (v314.tiedCount > 1 and "Joint #" or "#") .. tostring(v314.rank));
                Widgets.setText(v.name, VerifiedName.format(v315.name, v315.verified, v315.userId));
                local setText = Widgets.setText;
                local metric = v.metric;
                local key = v312.key;
                local v316;

                if key == "mvp" then
                    v316 = Widgets.number(0) .. " XP";
                elseif key == "survival" then
                    local v317 = math.floor(0 * 10 + 0.5) / 10;
                    local math_max_ret = math.max(0, v317);
                    v316 = math_max_ret >= 60 and ("%dm %04.1fs"):format(math.floor(math_max_ret / 60), math_max_ret % 60) or ("%.1fs"):format(math_max_ret);
                else
                    v316 = Widgets.number(0) .. " Catches";
                end;

                setText(metric, v316);
                portrait(v.icon, v315, Image, v.view);
                pop(v, i == 1 and 0 or MatchSummaryConfig.SideRevealDelay);
            end;
        end;

        PresentationCues:Fire("RecapOpen", nil);
    end;

    local function stepPodium(p318) -- Line: 982
        -- upvalues: u289 (ref), MatchSummaryConfig (ref), u3 (ref), u292 (ref), u293 (ref), setStage (copy), u291 (ref), u290 (ref), u270 (copy), Widgets (ref)
        local v319 = math.max(0, p318 - u289) / MatchSummaryConfig.StageSeconds;
        local v320 = math.floor(v319) + 1;
        local math_clamp_ret = math.clamp(v320, 1, #u3);

        if u292 and p318 < u293 then
            math_clamp_ret = u292;
        else
            u292 = nil;
        end;

        setStage(math_clamp_ret, p318);
        local v321 = 1 - (1 - math.clamp((p318 - u291) / 0.9, 0, 1)) ^ 3;
        local key = u3[u290].key;
        local v322 = key == "survival" and 10 or 1;

        for _, v in u270 do
            if v.award then
                local v323 = math.floor(v.award.value * v321 * v322 + 0.5) / v322;
                local setText = Widgets.setText;
                local metric = v.metric;
                local v324;

                if key == "mvp" then
                    v324 = Widgets.number(v323) .. " XP";
                elseif key == "survival" then
                    local v325 = math.floor(v323 * 10 + 0.5) / 10;
                    local math_max_ret = math.max(0, v325);
                    v324 = math_max_ret >= 60 and ("%dm %04.1fs"):format(math.floor(math_max_ret / 60), math_max_ret % 60) or ("%.1fs"):format(math_max_ret);
                else
                    v324 = v323 == 1 and "1 Catch" or Widgets.number(v323) .. " Catches";
                end;

                setText(metric, v324);
            end;
        end;
    end;

    local function stepPersonal(p326) -- Line: 1002
        -- upvalues: u294 (ref), MatchSummaryConfig (ref), u286 (ref), Widgets (ref), u260 (copy), u261 (copy), LocalPlayer (ref), ProgressionMath (ref), u263 (copy), u264 (copy), u266 (copy), u265 (copy), PresentationCues (copy), u262 (copy)
        local math_clamp_ret = math.clamp((p326 - u294.started) / MatchSummaryConfig.CountDuration, 0, 1);
        local v327 = 1 - (1 - math_clamp_ret) ^ 3;
        local math_round_ret = math.round((u286 and u286.crossingXP or 0) * v327);
        local math_round_ret2 = math.round((u286 and u286.catchXP or 0) * v327);
        local math_round_ret3 = math.round((u286 and u286.winXP or 0) * v327);
        local math_round_ret4 = math.round((u286 and u286.bonusXP or 0) * v327);
        local v328 = math_round_ret + math_round_ret2 + math_round_ret3 + math_round_ret4;
        Widgets.setText(u260, u286 and ("+" .. Widgets.number(v328) .. " XP" or "Ready for the next match") or "Ready for the next match");
        local v329 = {};

        if u286 then
            if (u286.crossingXP or 0) > 0 then
                table.insert(v329, "Crossings +" .. math_round_ret);
            end;

            if (u286.catchXP or 0) > 0 then
                table.insert(v329, "Catches +" .. math_round_ret2);
            end;

            if (u286.winXP or 0) > 0 then
                table.insert(v329, "Win +" .. math_round_ret3);
            end;

            if (u286.bonusXP or 0) > 0 then
                table.insert(v329, "Bonus +" .. math_round_ret4);
            end;
        end;

        Widgets.setText(u261, table.concat(v329, "  ·  "));
        local v330 = u286 and u286.xpBefore;

        if v330 == nil and LocalPlayer:GetAttribute("StatsLoaded") == true then
            local v331 = LocalPlayer:GetAttribute("TotalXP") or 0;
            v330 = math.max(0, v331 - (u286 and u286.earnedXP or 0));
        end;

        local v332 = false;

        if v330 == nil then
            Widgets.setText(u266, "Syncing progress…");
            u265.Size = UDim2.fromScale(0, 1);
        else
            local v333 = ProgressionMath.state(v330);
            local v334 = ProgressionMath.state(v330 + v328);
            Widgets.setText(u263, "Lvl " .. v334.level);
            Widgets.setText(u264, "Lvl " .. v334.level + 1);
            Widgets.setText(u266, ("%s/%s XP"):format(Widgets.number(v334.earned), Widgets.number(v334.needed)));
            u265.Size = UDim2.fromScale(math.clamp(v334.ratio, 0, 1), 1);
            v332 = v334.level > v333.level;
        end;

        if math_clamp_ret > 0 and (math_clamp_ret < 1 and (v328 ~= u294.lastEarned and p326 - u294.lastTick >= MatchSummaryConfig.CountTickInterval)) then
            PresentationCues:Fire("RecapTick", v327 * 0.3 + 0.92);
            u294.lastTick = p326;
        end;

        u294.lastEarned = v328;

        if math_clamp_ret >= 1 and not u294.done then
            u294.done = true;

            if v332 then
                u262.Visible = true;
                PresentationCues:Fire("RecapLevelUp", nil);
            elseif v328 > 0 then
                PresentationCues:Fire("RecapComplete", nil);
            end;
        end;

        u294.settled = u294.done and v330 ~= nil;
    end;

    local function earnedXP() -- Line: 1061
        -- upvalues: u286 (ref)
        return not u286 and 0 or (u286.earnedXP or (u286.crossingXP or 0) + (u286.catchXP or 0) + (u286.winXP or 0) + (u286.bonusXP or 0));
    end;

    local function present(p335) -- Line: 1068
        -- upvalues: u283 (ref), u282 (ref), u285 (copy), u286 (ref), LocalPlayer (ref), u287 (ref), u2 (ref), u288 (ref), soloWinner (ref), u289 (ref), MatchSummaryConfig (ref), u290 (ref), u292 (ref), u295 (copy), u262 (copy), u294 (ref), u251 (copy), TextColor3 (copy), Widgets (ref), u250 (copy), u258 (copy), u259 (copy), outcomeText (ref), u267 (copy), VerifiedName (ref), portrait (ref), u268 (copy), Image (copy), u269 (copy), clearJourney (ref), u274 (copy), journeyLayout (ref), JourneyEvent (copy), JourneyConfig (ref), u276 (ref), TweenService (ref), TweenInfo_new_ret (ref), u253 (copy), u254 (copy), u256 (copy), u257 (copy), u255 (copy)
        u283 = u282.matchId;
        table.clear(u285);
        u286 = nil;

        for _, v in u282.participants do
            u285[v.userId] = v;

            if v.userId == LocalPlayer.UserId then
                u286 = v;
            end;
        end;

        u287 = u2[u282.mode] == true;
        local v336;

        if u287 then
            v336 = nil;
        else
            v336 = soloWinner(u282);
        end;

        u288 = v336;
        u289 = u282.shownAt + (u288 and MatchSummaryConfig.SoloWinSeconds or 0);
        u290 = nil;
        u292 = nil;

        for _, v in u295 do
            v:Cancel();
        end;

        table.clear(u295);
        u262.Visible = false;
        u294 = {
            lastTick = (-1 / 0),
            lastEarned = 0,
            done = false,
            started = os.clock() + MatchSummaryConfig.CountDelay
        };
        u251.TextColor3 = TextColor3;

        if u287 then
            local v337 = u282.mode == "FFACatchers" and true or u282.mode == "BladeBall";
            Widgets.setText(u250, v337 and "Last One Standing" or "Your Rewards");
            local setText = Widgets.setText;
            local v338;

            if v337 then
                v338 = tostring(u282.lastStandingName or "No survivor");
            else
                v338 = u282.mode == "CrossyRoad" and "Crossy Roads" or "Donkey Kong";
            end;

            setText(u251, v338);
            local v339, v340;

            if v337 then
                v339 = ("+%s Coins  ·  <font color=\"#57EB9F\">+%s Gems</font>"):format(Widgets.number(u286 and u286.eventCoins or 0), Widgets.number(u286 and u286.eventGems or 0));
                v340 = "Earned in this event";
            elseif u286 and u286.won then
                v339 = u282.mode == "CrossyRoad" and "2× Coins · 15 Minutes" or "2× Gems · 15 Minutes";
                v340 = "Your boost is active";
            else
                v339 = "Finish the course to earn a 15-minute boost.";
                v340 = "";
            end;

            Widgets.setText(u258, v339);
            Widgets.setText(u259, v340);
            u259.Visible = v340 ~= "";
        else
            Widgets.setText(u250, (outcomeText(u282)));
        end;

        if u288 then
            Widgets.setText(u267, VerifiedName.format(u288.name, u288.verified, u288.userId));
            portrait(u268, u288, Image, u269);
        end;

        clearJourney(u274);
        local v341 = not u287;

        if v341 then
            if JourneyEvent == nil or JourneyConfig.Enabled ~= true then
                v341 = false;
            else
                v341 = JourneyConfig.Visible ~= false;
            end;
        end;

        journeyLayout(u274, v341);

        if u274.on then
            u276 = (1 / 0);
            local v342 = u274;
            v342.sectionScale.Scale = 0.9;
            local v343 = TweenService:Create(v342.sectionScale, TweenInfo_new_ret, {
                Scale = 1
            });
            table.insert(v342.pops, v343);
            v343:Play();
            pcall(JourneyEvent.FireServer, JourneyEvent, "Get");
        end;

        local v344;

        if u288 == nil then
            v344 = false;
        else
            v344 = p335 < u289;
        end;

        u253.Visible = not u287 and not v344;
        u254.Visible = not u287 and not v344;
        u256.Visible = v344;
        u257.Visible = u287;

        if u287 or v344 then
            u255.Visible = false;
        end;
    end;

    local function step(p345) -- Line: 1131
        -- upvalues: u282 (ref), u280 (ref), u299 (ref), Widgets (ref), u252 (copy), u288 (ref), u289 (ref), u253 (copy), u287 (ref), u254 (copy), u256 (copy), u257 (copy), u255 (copy), stepPodium (copy), u294 (ref), stepPersonal (copy), u274 (copy), MatchSummaryConfig (ref), u276 (ref), drawJourney (ref), u275 (ref), u286 (ref), spinJourney (ref)
        local ServerTimeNow = workspace:GetServerTimeNow();

        if not u282 or u282.expiresAt <= ServerTimeNow then
            u280:close("Hidden");

            return;
        end;

        u299 = u299 + p345;

        if u299 >= 0.1 then
            u299 = 0;
            local setText = Widgets.setText;
            local math_ceil_ret = math.ceil(u282.expiresAt - ServerTimeNow);
            setText(u252, ("Next match · %ds"):format((math.max(0, math_ceil_ret))));
            local v346;

            if u288 == nil then
                v346 = false;
            else
                v346 = ServerTimeNow < u289;
            end;

            u253.Visible = not u287 and not v346;
            u254.Visible = not u287 and not v346;
            u256.Visible = v346;
            u257.Visible = u287;

            if u287 or v346 then
                u255.Visible = false;
            end;
        end;

        if not u287 and u289 <= ServerTimeNow then
            stepPodium(ServerTimeNow);
        end;

        if u294 and not u294.settled then
            stepPersonal(os.clock());
        end;

        if u274.on and u294 then
            local v347 = (os.clock() - u294.started) / MatchSummaryConfig.CountDuration;
            local math_clamp_ret = math.clamp(v347, 0, 1);
            u276 = u276 + p345;

            if math_clamp_ret < 1 or u276 >= 0.25 then
                u276 = 0;
                drawJourney(u274, u275, not u286 and 0 or (u286.earnedXP or (u286.crossingXP or 0) + (u286.catchXP or 0) + (u286.winXP or 0) + (u286.bonusXP or 0)), 1 - (1 - math_clamp_ret) ^ 3);
            end;

            spinJourney(u274, p345);
        end;
    end;

    local function dismissInput(p348, p349) -- Line: 1162
        -- upvalues: UserInputService (ref), u280 (ref)
        if p349 ~= Enum.UserInputState.Begin or UserInputService:GetFocusedTextBox() then
            return Enum.ContextActionResult.Pass;
        end;

        u280:close("Back");

        return Enum.ContextActionResult.Sink;
    end;

    u280 = Panels.define({
        id = "MatchResult",
        attribute = "MatchSummaryVisible",
        lobbyOnly = true,
        closeOnRespawn = false,
        register = false,
        frame = v249,
        closeButton = Registry.get(v249, "Header.CloseButton"),

        onOpen = function() -- Line: 1178, Name: onOpen
            -- upvalues: u299 (ref), focus (copy), u287 (ref), u248 (copy), u281 (ref), PresentationCues (copy), u288 (ref), u289 (ref), ContextActionService (ref), dismissInput (copy), u296 (ref), RunService (ref), step (copy)
            u299 = 0;
            focus(not u287);

            if u248:IsA("ScreenGui") then
                u281 = u281 or u248.DisplayOrder;
                u248.DisplayOrder = math.max(u281, 64);
            end;

            if u287 then
                PresentationCues:Fire("RecapOpen", nil);
            elseif u288 and workspace:GetServerTimeNow() < u289 then
                PresentationCues:Fire("RecapOpen", 0.9);
            end;

            ContextActionService:BindAction("CoHDismissRecap", dismissInput, false, Enum.KeyCode.Return);
            u296 = RunService.RenderStepped:Connect(step);
            step(0);
        end,

        onClose = function(p350) -- Line: 1197, Name: onClose
            -- upvalues: u6 (ref), u284 (ref), u283 (ref), u281 (ref), u248 (copy), u296 (ref), ContextActionService (ref), u295 (copy), focus (copy), PresentationCues (copy), u270 (copy), u269 (copy), clearJourney (ref), u274 (copy)
            if u6[p350] then
                u284 = u283;
            end;

            if u281 and u248:IsA("ScreenGui") then
                u248.DisplayOrder = u281;
            end;

            if u296 then
                u296:Disconnect();
                u296 = nil;
            end;

            ContextActionService:UnbindAction("CoHDismissRecap");

            for _, v in u295 do
                v:Cancel();
            end;

            table.clear(u295);
            focus(false);
            PresentationCues:Fire("RecapStop", nil);

            for _, v in u270 do
                v.view:clear();
            end;

            u269:clear();
            clearJourney(u274);
        end
    });

    local function openJourney() -- Line: 1222
        -- upvalues: u280 (ref), HudNavigation (ref)
        if u280.isOpen then
            u280:close("Button");
        end;

        task.defer(function() -- Line: 1226
            -- upvalues: HudNavigation (ref)
            pcall(HudNavigation.activate, "Journey");
        end);
    end;

    u274.unlock.Activated:Connect(function() -- Line: 1230
        -- upvalues: JourneyConfig (ref), LocalPlayer (ref)
        if JourneyConfig.PremiumPassId > 0 then
            pcall(function() -- Line: 1232
                -- upvalues: LocalPlayer (ref), JourneyConfig (ref)
                game:GetService("MarketplaceService"):PromptGamePassPurchase(LocalPlayer, JourneyConfig.PremiumPassId);
            end);
        end;
    end);
    u274.view.Activated:Connect(openJourney);
    u274.freePill.Activated:Connect(openJourney);

    local function busy() -- Line: 1241
        -- upvalues: Panels (ref), u7 (ref), LocalPlayer (ref)
        if Panels.anyOpen() then
            return true;
        end;

        for _, v in u7 do
            if LocalPlayer:GetAttribute(v) == true then
                return true;
            end;
        end;

        return false;
    end;

    local u351 = nil;

    local function evaluate() -- Line: 1254
        -- upvalues: u282 (ref), u284 (ref), Session (copy), LocalPlayer (ref), u280 (ref), u283 (ref), present (copy), busy (copy), u351 (ref)
        local ServerTimeNow = workspace:GetServerTimeNow();
        local v352;

        if u282 == nil or (u282.matchId == u284 or (ServerTimeNow >= u282.expiresAt or (Session:GetAttribute("Phase") ~= "Intermission" or (LocalPlayer:GetAttribute("InMatch") == true or (LocalPlayer:GetAttribute("InitialLoadingComplete") ~= true or LocalPlayer:GetAttribute("ScreenPresentationActive") == true))))) then
            v352 = false;
        else
            v352 = LocalPlayer:GetAttribute("EventIntroSkipsRecap") ~= true;
        end;

        if not v352 then
            if u280.isOpen then
                u280:close("Hidden");
            end;

            return;
        end;

        if u283 ~= u282.matchId then
            if u280.isOpen then
                u280:close("Hidden");
            end;

            present(ServerTimeNow);
        end;

        if not u280.isOpen then
            if busy() then
                u351();

                return;
            end;

            u280:open();
        end;
    end;

    local u353 = false;

    u351 = function() -- Line: 1287, Name: waitUntilFree
        -- upvalues: u353 (ref), u282 (ref), busy (copy), evaluate (copy)
        if u353 then
            return;
        end;

        u353 = true;
        task.spawn(function() -- Line: 1292
            -- upvalues: u353 (ref), u282 (ref), busy (ref), evaluate (ref)
            while u353 do
                task.wait(0.5);

                if u282 and workspace:GetServerTimeNow() < u282.expiresAt then
                    if not busy() then
                        u353 = false;
                        evaluate();
                    end;
                else
                    u353 = false;
                end;
            end;
        end);
    end;

    local function read() -- Line: 1305
        -- upvalues: u282 (ref), decode (ref), MatchSummary (copy), u285 (copy), u286 (ref), u288 (ref), u294 (ref), evaluate (copy)
        u282 = decode(MatchSummary.Value);

        if not u282 then
            table.clear(u285);
            u286 = nil;
            u288 = nil;
            u294 = nil;
        end;

        evaluate();
    end;

    for i, v in u273 do
        v.Activated:Connect(function() -- Line: 1315
            -- upvalues: u280 (ref), u282 (ref), u287 (ref), u289 (ref), u292 (ref), u293 (ref), i (copy), MatchSummaryConfig (ref), setStage (copy)
            local ServerTimeNow = workspace:GetServerTimeNow();

            if u280.isOpen and (u282 and (not u287 and u289 <= ServerTimeNow)) then
                u292 = i;
                u293 = ServerTimeNow + MatchSummaryConfig.StageSeconds;
                setStage(i, ServerTimeNow);
            end;
        end);
    end;

    MatchSummary.Changed:Connect(read);
    Session:GetAttributeChangedSignal("Phase"):Connect(evaluate);

    for _, v in u5 do
        LocalPlayer:GetAttributeChangedSignal(v):Connect(evaluate);
    end;

    u282 = decode(MatchSummary.Value);

    if not u282 then
        table.clear(u285);
        u286 = nil;
        u288 = nil;
        u294 = nil;
    end;

    evaluate();
end;

return v1;