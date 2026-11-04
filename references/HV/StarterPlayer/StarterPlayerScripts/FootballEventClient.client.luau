 

 

local Players = game:GetService("Players");
local UserInputService = game:GetService("UserInputService");
local ContextActionService = game:GetService("ContextActionService");
local GamepadService = game:GetService("GamepadService");
local ProximityPromptService = game:GetService("ProximityPromptService");
local RunService = game:GetService("RunService");
local HttpService = game:GetService("HttpService");
local TweenService = game:GetService("TweenService");
local ChickenOrHero = game:GetService("ReplicatedStorage"):WaitForChild("ChickenOrHero");
local Interface = ChickenOrHero:WaitForChild("Interface");
local HudNavigation = require(ChickenOrHero:WaitForChild("Presentation"):WaitForChild("HudNavigation"));
local Cursor = require(Interface:WaitForChild("Cursor"));
local Telemetry = require(Interface:WaitForChild("Telemetry"));
local Widgets = require(Interface:WaitForChild("Widgets"));
local ClaimPop = require(Interface:WaitForChild("ClaimPop"));
local EmotePose = require(Interface:WaitForChild("EmotePose"));
local Preview = require(Interface:WaitForChild("Shop"):WaitForChild("Preview"));
local Skin = require(ChickenOrHero:WaitForChild("OldUIReskin"):WaitForChild("Skin"));
local TeamEventConfig = require(ChickenOrHero:WaitForChild("Progression"):WaitForChild("TeamEventConfig"));
local JourneyConfig = require(ChickenOrHero.Progression:WaitForChild("JourneyConfig"));
local EmoteCatalog = require(ChickenOrHero:WaitForChild("Emotes"):WaitForChild("EmoteCatalog"));
local CrateCatalog = require(ChickenOrHero:WaitForChild("Crates"):WaitForChild("CrateCatalog"));
local GearCatalog = require(ChickenOrHero:WaitForChild("Gear"):WaitForChild("GearCatalog"));
local SkinCatalog = require(ChickenOrHero:WaitForChild("Weapons"):WaitForChild("SkinCatalog"));
local OfferRules = require(ChickenOrHero.Weapons:WaitForChild("OfferRules"));
local Game = ChickenOrHero:WaitForChild("Game");
local TeamEventRemote = Game:WaitForChild("TeamEventRemote");
local LocalPlayer = Players.LocalPlayer;
local Vector2_new_ret = Vector2.new(860, 532);
local Vector2_new_ret2 = Vector2.new(760, 396);
local Vector2_new_ret3 = Vector2.new(1000, 556);
local Vector2_new_ret4 = Vector2.new(720, 430);
local u1 = #TeamEventConfig.TeamLevels;
local Font_new_ret = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.ExtraBold);
local Font_new_ret2 = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy);
local Font_new_ret3 = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Italic);
local Color3_fromRGB_ret = Color3.fromRGB(23, 23, 25);
local Color3_fromRGB_ret2 = Color3.fromRGB(16, 22, 44);
local Color3_fromRGB_ret3 = Color3.fromRGB(5, 7, 15);
local Color3_fromRGB_ret4 = Color3.fromRGB(76, 80, 100);
local Color3_fromRGB_ret5 = Color3.fromRGB(80, 255, 100);
local Color3_fromRGB_ret6 = Color3.fromRGB(17, 213, 40);
local Color3_fromRGB_ret7 = Color3.fromRGB(214, 218, 232);
local Color3_fromRGB_ret8 = Color3.fromRGB(150, 156, 180);
local Color3_fromRGB_ret9 = Color3.fromRGB(253, 60, 85);
local Color3_fromRGB_ret10 = Color3.fromRGB(255, 202, 58);
local Color3_fromRGB_ret11 = Color3.fromRGB(255, 146, 24);
local Color3_fromRGB_ret12 = Color3.fromRGB(255, 120, 200);
local Color3_new_ret = Color3.new(1, 1, 1);
local Color3_new_ret2 = Color3.new(0, 0, 0);
local GEM_TEXT = ClaimPop.GEM_TEXT;
local Palette = Skin.Palette;
local Vector2_new_ret5 = Vector2.new(0.5, 0.5);
local UDim_new_ret = UDim.new(1, 0);
local ColorSequence_new_ret = ColorSequence.new({ ColorSequenceKeypoint.new(0, TeamEventConfig.Team[TeamEventConfig.Teams[1]].Color), ColorSequenceKeypoint.new(0.5, Color3_fromRGB_ret10), ColorSequenceKeypoint.new(1, TeamEventConfig.Team[TeamEventConfig.Teams[2]].Color) });
local TweenInfo_new_ret = TweenInfo.new(12, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1);
local TweenInfo_new_ret2 = TweenInfo.new(0.9, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true);
local TweenInfo_new_ret3 = TweenInfo.new(0.55, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true);
local TweenInfo_new_ret4 = TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, -1, true);
local TweenInfo_new_ret5 = TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out);
local TweenInfo_new_ret6 = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
local u2 = {
    fill = ColorSequence.new(Color3_fromRGB_ret5, Color3_fromRGB_ret6),
    edge = Color3_fromRGB_ret5,
    text = Color3_new_ret
};
local u3 = {
    fill = ColorSequence.new(Color3.fromRGB(125, 125, 125), Color3.fromRGB(80, 80, 80)),
    edge = Color3.fromRGB(110, 110, 110),
    text = Color3.fromRGB(165, 165, 165)
};
local u4 = {
    fill = ColorSequence.new(Color3.fromRGB(70, 74, 92), Color3.fromRGB(40, 43, 56)),
    edge = Color3_fromRGB_ret4,
    text = Color3_new_ret
};
local u5 = {};

for i, v in TeamEventConfig.Team do
    u5[i] = {
        fill = ColorSequence.new(v.Color, v.Color:Lerp(Color3_new_ret2, 0.35)),
        edge = v.Color:Lerp(Color3_new_ret, 0.3),
        text = Color3_new_ret
    };
end;

local u6 = { "Team", "Personal" };
local u7 = { { 1000000000, "B" }, { 1000000, "M" }, { 1000, "K" } };
local u8 = ("Every crossing, catch and win scores a point, up to %d a match."):format(TeamEventConfig.MatchCap);
local u9 = nil;
local u10 = {};
local u11 = nil;
local u12 = 0;
local u13 = nil;
local u14 = 0;
local u15 = "Team";
local u16 = nil;
local u17 = false;
local u18 = nil;
local u19 = nil;
local u20 = nil;

local function make(p21, p22, p23) -- Line: 138
    local Instance_new_ret = Instance.new(p21);

    for i, v in p23 do
        Instance_new_ret[i] = v;
    end;

    Instance_new_ret.Parent = p22;

    return Instance_new_ret;
end;

local function stroke(p24, p25, p26, p27) -- Line: 146
    local v28 = {
        Color = p25,
        Thickness = p26,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        ZIndex = p27 or 1
    };
    local UIStroke = Instance.new("UIStroke");

    for i, v in v28 do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = p24;

    return UIStroke;
end;

local function corner(p29, p30) -- Line: 154
    local UICorner = Instance.new("UICorner");

    for i, v in {
        CornerRadius = p30
    } do
        UICorner[i] = v;
    end;

    UICorner.Parent = p29;

    return UICorner;
end;

local function gradient(p31, p32, p33, p34) -- Line: 157
    local v35 = {
        Color = ColorSequence.new(p32, p33),
        Rotation = p34 or 90
    };
    local UIGradient = Instance.new("UIGradient");

    for i, v in v35 do
        UIGradient[i] = v;
    end;

    UIGradient.Parent = p31;

    return UIGradient;
end;

local function label(p36, p37, p38, p39, p40) -- Line: 160
    -- upvalues: Font_new_ret (copy)
    local v41 = {
        BackgroundTransparency = 1,
        FontFace = Font_new_ret,
        Text = p37,
        TextSize = p38,
        TextColor3 = p39,
        TextXAlignment = Enum.TextXAlignment.Left
    };
    local TextLabel = Instance.new("TextLabel");

    for i, v in v41 do
        TextLabel[i] = v;
    end;

    TextLabel.Parent = p36;

    for i, v in p40 do
        TextLabel[i] = v;
    end;

    return TextLabel;
end;

local function outline(p42, p43, p44) -- Line: 175
    local v45 = {
        Color = p43,
        Thickness = p44,
        LineJoinMode = Enum.LineJoinMode.Round
    };
    local UIStroke = Instance.new("UIStroke");

    for i, v in v45 do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = p42;

    return p42;
end;

local function image(p46, p47, p48) -- Line: 179
    local v49 = {
        BackgroundTransparency = 1,
        Image = p47,
        ScaleType = Enum.ScaleType.Fit
    };
    local ImageLabel = Instance.new("ImageLabel");

    for i, v in v49 do
        ImageLabel[i] = v;
    end;

    ImageLabel.Parent = p46;

    for i, v in p48 do
        ImageLabel[i] = v;
    end;

    return ImageLabel;
end;

local function row(p50, p51, p52, p53) -- Line: 187
    local Frame = Instance.new("Frame");

    for i, v in {
        BackgroundTransparency = 1
    } do
        Frame[i] = v;
    end;

    Frame.Parent = p50;

    for i, v in p51 do
        Frame[i] = v;
    end;

    local v54 = {
        FillDirection = Enum.FillDirection.Horizontal,
        HorizontalAlignment = p52 or Enum.HorizontalAlignment.Left,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, p53 or 6)
    };
    local UIListLayout = Instance.new("UIListLayout");

    for i, v in v54 do
        UIListLayout[i] = v;
    end;

    UIListLayout.Parent = Frame;

    return Frame;
end;

local function play(p55, p56, p57, p58, p59) -- Line: 204
    -- upvalues: TweenService (copy)
    local v60 = p55.tweens[p56];

    if v60 then
        v60:Cancel();
    end;

    local v61 = TweenService:Create(p57, p58, p59);
    p55.tweens[p56] = v61;
    v61:Play();

    return v61;
end;

local function stop(p62, p63) -- Line: 214
    local v64 = p62.tweens[p63];

    if v64 then
        p62.tweens[p63] = nil;
        v64:Cancel();
    end;
end;

local function short(p65) -- Line: 223
    -- upvalues: Widgets (copy), u7 (copy)
    local v66 = tonumber(p65) or 0;
    local math_floor_ret = math.floor(v66);
    local math_max_ret = math.max(0, math_floor_ret);

    if math_max_ret < 10000 then
        return Widgets.number(math_max_ret);
    end;

    for _, v in u7 do
        if v[1] <= math_max_ret then
            local v67 = math.floor(math_max_ret / v[1] * 10) / 10;

            return string.gsub(("%.1f"):format(v67), "%.0$", "") .. v[2];
        end;
    end;
end;

local function players(p68) -- Line: 235
    -- upvalues: Widgets (copy)
    local v69 = tonumber(p68) or 0;
    local math_floor_ret = math.floor(v69);
    local math_max_ret = math.max(0, math_floor_ret);

    return Widgets.number(math_max_ret) .. (math_max_ret == 1 and " PLAYER" or " PLAYERS");
end;

local function minutes(p70) -- Line: 240
    local math_floor_ret = math.floor(p70);
    local v71 = math_floor_ret // 60;
    local v72 = math_floor_ret % 60;

    if v71 > 0 and v72 > 0 then
        return ("%dh %dm"):format(v71, v72);
    end;

    if v71 > 0 then
        return v71 .. "h";
    end;

    return v72 .. "m";
end;

local function cardState(p73, p74, p75) -- Line: 250
    -- upvalues: short (copy), TeamEventConfig (copy), Widgets (copy)
    if p75.claimed then
        return "collected", "COLLECTED";
    end;

    if p75.wiped then
        return "locked", "LOCKED";
    end;

    local v76 = p75.phase == "Final";

    if p73 == "Team" and p75.reached < p74 then
        if v76 then
            return "missed", "MISSED";
        end;

        return "locked", short((math.max(0, p75.levels[p74] - p75.teamPoints))) .. " PTS TO GO";
    end;

    local v77;

    if p73 == "Team" then
        v77 = TeamEventConfig.Participation[p74];
    else
        v77 = TeamEventConfig.PersonalLevels[p74];
    end;

    if p75.points < v77 then
        if v76 or p75.phase == "Settling" then
            return "missed", "MISSED";
        end;

        if p73 == "Team" then
            return "needs", (p75.compact and "NEED %d PTS" or "NEEDS %d OF YOUR PTS"):format(v77);
        end;

        return "locked", Widgets.number(v77 - p75.points) .. " PTS TO GO";
    end;

    if p75.claimsOpen then
        return "claim", "CLAIM!";
    end;

    if v76 then
        return "owed", "ARRIVES ON REJOIN";
    end;

    return "paused", "CLAIMS PAUSED";
end;

local function busy() -- Line: 279
    -- upvalues: u12 (ref)
    local v78;

    if u12 > 0 then
        v78 = os.clock() - u12 < 15;
    else
        v78 = false;
    end;

    return v78;
end;

local function live() -- Line: 282
    -- upvalues: u9 (ref)
    local v79;

    if u9 == nil then
        v79 = false;
    else
        v79 = u9.enabled == true;
    end;

    return v79;
end;

local function permitted(p80) -- Line: 287
    -- upvalues: LocalPlayer (copy)
    local v81;

    if LocalPlayer:GetAttribute("ClientReady") == true and (LocalPlayer:GetAttribute("ScreenPresentationActive") ~= true and LocalPlayer:GetAttribute("AdminRefreshActive") ~= true) then
        v81 = p80 or LocalPlayer:GetAttribute("MatchSummaryVisible") ~= true;
    else
        v81 = false;
    end;

    return v81;
end;

local function phaseNow() -- Line: 293
    -- upvalues: u9 (ref), TeamEventConfig (copy)
    if u9 and type(u9.phase) == "string" then
        return u9.phase;
    end;

    return TeamEventConfig.phaseAt(workspace:GetServerTimeNow());
end;

local function has(p82, p83) -- Line: 299
    local v84;

    if type(p82) == "table" then
        v84 = p82[p83] == true and true or p82[tostring(p83)] == true;
    else
        v84 = false;
    end;

    return v84;
end;

local function accent(p85, p86) -- Line: 302
    if typeof(p85) == "Color3" then
        return p85;
    end;

    return p86;
end;

local function rewardItems(p87) -- Line: 311
    -- upvalues: SkinCatalog (copy), ClaimPop (copy), Color3_fromRGB_ret10 (copy), EmoteCatalog (copy), Color3_fromRGB_ret12 (copy), JourneyConfig (copy), GearCatalog (copy), CrateCatalog (copy), TeamEventConfig (copy), Widgets (copy), GEM_TEXT (copy)
    local v88 = {};

    if type(p87) ~= "table" then
        return v88;
    end;

    local v89 = tonumber(p87.Gems) or 0;

    for _, v in p87.Knives or {} do
        local v90 = SkinCatalog.get(v);

        if v90 then
            local v91 = {
                image = "rbxassetid://127106171586822",
                knife = v90,
                name = ClaimPop.titleCase(v90.SourceName or v90.Name) .. " Knife"
            };
            local Accent = v90.Accent;
            local v92 = Color3_fromRGB_ret10;

            if typeof(Accent) ~= "Color3" then
                Accent = v92;
            end;

            v91.color = Accent;
            table.insert(v88, v91);
        end;
    end;

    for _, v in p87.Emotes or {} do
        local v93 = EmoteCatalog.get(v);

        if v93 then
            local v94 = {
                emote = v,
                image = ClaimPop.EMOTE_IMAGE,
                name = tostring(v93.Name) .. " Emote",
                color = Color3_fromRGB_ret12
            };
            table.insert(v88, v94);
        end;
    end;

    for _, v in p87.Titles or {} do
        local v95 = JourneyConfig.Badges[v];

        if v95 then
            local v96 = {
                title = v95,
                name = string.gsub(ClaimPop.titleCase(v95.Name), "%f[%w]Mvp%f[%W]", "MVP") .. " Title"
            };
            local Color = v95.Color;
            local v97 = Color3_fromRGB_ret10;

            if typeof(Color) == "Color3" then
                v97 = Color;
            end;

            v96.color = v97;
            table.insert(v88, v96);
        end;
    end;

    for _, v in p87.Abilities or {} do
        local v98 = GearCatalog.get(v);

        if v98 then
            local v99 = {
                gear = v98,
                image = v98.IconImage or "rbxassetid://81361668939419",
                name = ClaimPop.titleCase(v98.Name)
            };
            local Accent = v98.Accent;
            local v100 = Color3_fromRGB_ret10;

            if typeof(Accent) == "Color3" then
                v100 = Accent;
            end;

            v99.color = v100;
            table.insert(v88, v99);
        end;
    end;

    for i, v in p87.Crates or {} do
        local v101 = tonumber(v) or 0;
        local v102 = CrateCatalog.get(i);

        if v101 > 0 and v102 then
            local v103;

            if type(v102.Icon) == "string" then
                v103 = v102.Icon or nil;
            else
                v103 = nil;
            end;

            local v104 = {
                emote = CrateCatalog.poseEmote(i),
                image = v103 or "rbxassetid://115583741443536"
            };
            local v105;

            if v103 then
                v105 = nil;
            else
                local Accent = v102.Accent;
                v105 = Color3_fromRGB_ret10;

                if typeof(Accent) == "Color3" then
                    v105 = Accent;
                end;
            end;

            v104.tint = v105;
            local v106;

            if v101 > 1 then
                v106 = "×" .. v101;
            else
                v106 = nil;
            end;

            v104.amount = v106;
            v104.name = (v101 <= 1 and "" or v101 .. "× ") .. v102.Name;
            local Accent = v102.Accent;
            Color3_fromRGB_ret10 = Color3_fromRGB_ret10;
            local _ = typeof(Accent) == "Color3";
            v104.color = Accent;
            table.insert(v88, v104);
        elseif v101 > 0 then
            v89 = v89 + (TeamEventConfig.CrateGems[i] or 0) * v101;
        end;
    end;

    for i, v in p87.Gear or {} do
        local v107 = tonumber(v) or 0;
        local v108 = GearCatalog.get(i);

        if v107 > 0 and v108 then
            local v109 = {
                gear = v108,
                image = v108.IconImage,
                amount = "×" .. v107,
                name = ClaimPop.titleCase(v108.Name)
            };
            local Accent = v108.Accent;
            local v110 = Color3_fromRGB_ret10;

            if typeof(Accent) == "Color3" then
                v110 = Accent;
            end;

            v109.color = v110;
            table.insert(v88, v109);
        end;
    end;

    local v111 = tonumber(p87.Spins) or 0;

    if v111 > 0 then
        local v112 = {
            glyph = "🎡",
            icon = ClaimPop.wheel(),
            amount = "×" .. v111,
            name = v111 .. (v111 == 1 and " Wheel Spin" or " Wheel Spins"),
            color = Color3_fromRGB_ret10
        };
        table.insert(v88, v112);
    end;

    if v89 > 0 then
        local v113 = {
            image = ClaimPop.GEM_IMAGE,
            amount = "+" .. Widgets.number(v89),
            amountColor = GEM_TEXT,
            name = Widgets.number(v89) .. " Gems",
            color = GEM_TEXT
        };
        table.insert(v88, v113);
    end;

    local v114 = tonumber(p87.Coins) or 0;

    if v114 > 0 then
        local v115 = {
            image = ClaimPop.COIN_IMAGE,
            amount = "+" .. Widgets.number(v114),
            amountColor = Color3_fromRGB_ret10,
            name = Widgets.number(v114) .. " Coins",
            color = Color3_fromRGB_ret10
        };
        table.insert(v88, v115);
    end;

    local v116 = tonumber(p87.GemBoostMinutes) or 0;

    if v116 > 0 then
        local v117 = {
            boost = true,
            image = ClaimPop.GEM_IMAGE
        };
        local math_floor_ret = math.floor(v116);
        local v118 = math_floor_ret // 60;
        local v119 = math_floor_ret % 60;
        local v120;

        if v118 > 0 and v119 > 0 then
            v120 = ("%dh %dm"):format(v118, v119);
        elseif v118 > 0 then
            v120 = v118 .. "h";
        else
            v120 = v119 .. "m";
        end;

        v117.amount = v120;
        v117.amountColor = GEM_TEXT;
        local math_floor_ret2 = math.floor(v116);
        local v121 = math_floor_ret2 // 60;
        local v122 = math_floor_ret2 % 60;
        local v123;

        if v121 > 0 and v122 > 0 then
            v123 = ("%dh %dm"):format(v121, v122);
        elseif v121 > 0 then
            v123 = v121 .. "h";
        else
            v123 = v122 .. "m";
        end;

        v117.name = "2× Gems · " .. v123;
        v117.color = GEM_TEXT;
        table.insert(v88, v117);
    end;

    local v124 = tonumber(p87.CoinBoostMinutes) or 0;

    if v124 > 0 then
        local v125 = {
            boost = true,
            image = ClaimPop.COIN_IMAGE
        };
        local math_floor_ret = math.floor(v124);
        local v126 = math_floor_ret // 60;
        local v127 = math_floor_ret % 60;
        local v128;

        if v126 > 0 and v127 > 0 then
            v128 = ("%dh %dm"):format(v126, v127);
        elseif v126 > 0 then
            v128 = v126 .. "h";
        else
            v128 = v127 .. "m";
        end;

        v125.amount = v128;
        v125.amountColor = Color3_fromRGB_ret10;
        local math_floor_ret2 = math.floor(v124);
        local v129 = math_floor_ret2 // 60;
        local v130 = math_floor_ret2 % 60;
        local v131;

        if v129 > 0 and v130 > 0 then
            v131 = ("%dh %dm"):format(v129, v130);
        elseif v129 > 0 then
            v131 = v129 .. "h";
        else
            v131 = v130 .. "m";
        end;

        v125.name = "2× Coins · " .. v131;
        v125.color = Color3_fromRGB_ret10;
        table.insert(v88, v125);
    end;

    local v132 = tonumber(p87.QuestSkips) or 0;

    if v132 > 0 then
        table.insert(v88, {
            glyph = "⏭",
            amount = "×" .. v132,
            name = v132 .. (v132 == 1 and " Quest Skip" or " Quest Skips"),
            color = Color3_fromRGB_ret10
        });
    end;

    return v88;
end;

local function snapshotValue() -- Line: 449
    -- upvalues: Game (copy)
    local TeamEvent = Game:FindFirstChild("TeamEvent");

    if TeamEvent then
        TeamEvent = TeamEvent:FindFirstChild("Snapshot");
    end;

    if TeamEvent and TeamEvent:IsA("StringValue") then
        return TeamEvent;
    end;

    return nil;
end;

local function decode(p133) -- Line: 454
    -- upvalues: HttpService (copy)
    local success, result = pcall(HttpService.JSONDecode, HttpService, p133.Value);

    if success and type(result) == "table" then
        return result;
    end;

    return nil;
end;

local function teamTotals(p134, p135) -- Line: 458
    if p134 then
        p134 = p134.teams;
    end;

    local v136;

    if type(p134) == "table" then
        v136 = p134[p135];
    else
        v136 = false;
    end;

    if type(v136) == "table" then
        return v136;
    end;

    return nil;
end;

local function thresholds(p137) -- Line: 464
    -- upvalues: u1 (copy), TeamEventConfig (copy)
    if p137 then
        p137 = p137.thresholds;
    end;

    if type(p137) ~= "table" or #p137 ~= u1 then
        return TeamEventConfig.TeamLevels;
    end;

    for _, v in p137 do
        if type(v) ~= "number" then
            return TeamEventConfig.TeamLevels;
        end;
    end;

    return p137;
end;

local function champion(p138) -- Line: 476
    -- upvalues: u9 (ref)
    if p138 then
        p138 = p138.final;
    end;

    if type(p138) == "table" and type(p138.champion) == "string" then
        return p138.champion;
    end;

    return u9 and u9.finalChampion;
end;

local function rankText(p139, p140) -- Line: 483
    -- upvalues: u9 (ref), TeamEventConfig (copy), Widgets (copy), LocalPlayer (copy)
    local v141;

    if u9 and type(u9.phase) == "string" then
        v141 = u9.phase;
    else
        v141 = TeamEventConfig.phaseAt(workspace:GetServerTimeNow());
    end;

    if v141 == "Final" and tonumber(u9.rank) then
        return " · FINAL RANK #" .. Widgets.number(u9.rank);
    end;

    local v142;

    if p139 then
        v142 = p139.boards;
    else
        v142 = p139;
    end;

    local v143;

    if type(v142) == "table" then
        v143 = v142[p140];
    else
        v143 = false;
    end;

    if type(v143) == "table" then
        for i, v in v143 do
            if type(v) == "table" and tonumber(v.userId) == LocalPlayer.UserId then
                return " · #" .. Widgets.number(tonumber(v.rank) or i) .. " ON YOUR TEAM";
            end;
        end;
    end;

    if p139 then
        p139 = p139.cutoff;
    end;

    local v144;

    if type(p139) == "table" then
        v144 = tonumber(p139[p140]);
    else
        v144 = false;
    end;

    return (not v144 or v144 >= (tonumber(u9.saved) or 0)) and "" or " · TOP " .. Widgets.number(TeamEventConfig.LegendRank);
end;

local function countdown(p145, p146) -- Line: 507
    -- upvalues: u9 (ref), TeamEventConfig (copy), Color3_fromRGB_ret8 (copy), OfferRules (copy), Color3_fromRGB_ret9 (copy), Color3_fromRGB_ret10 (copy)
    local v147;

    if u9 and type(u9.phase) == "string" then
        v147 = u9.phase;
    else
        v147 = TeamEventConfig.phaseAt(workspace:GetServerTimeNow());
    end;

    if v147 == "Final" then
        return "EVENT OVER", "FINAL RESULTS", Color3_fromRGB_ret8;
    end;

    if v147 == "Settling" then
        return "EVENT ENDED", "RESULTS SOON", Color3_fromRGB_ret8;
    end;

    local v148, v149 = TeamEventConfig.window();
    local string_gsub_ret = string.gsub(OfferRules.countdown({
        StartsAt = v148,
        EndsAt = v149
    }, p145), "^%u+ IN ", "");

    if string_gsub_ret == "" then
        return "TEAM EVENT", "LIVE NOW", Color3_fromRGB_ret9;
    end;

    if v147 == "Upcoming" then
        return "STARTS IN", string_gsub_ret, Color3_fromRGB_ret10;
    end;

    return p146 and "ENDS IN" or "LIVE · ENDS IN", string_gsub_ret, Color3_fromRGB_ret9;
end;

local function ticker(p150, p151, p152) -- Line: 525
    -- upvalues: u9 (ref), TeamEventConfig (copy), Widgets (copy)
    local v153;

    if u9 and type(u9.phase) == "string" then
        v153 = u9.phase;
    else
        v153 = TeamEventConfig.phaseAt(workspace:GetServerTimeNow());
    end;

    if v153 == "Final" then
        return "THE RESULTS", "ARE FINAL";
    end;

    local v154;

    if p150 then
        v154 = tonumber(p150.nextAt);
    else
        v154 = p150;
    end;

    if not v154 then
        local v155 = "TEAM TOTALS";

        if p152 then
            return v155, "5 MIN";
        end;

        return v155, "EVERY 5 MIN";
    end;

    if p150.status == "delayed" then
        return "TOTALS DELAYED", "RETRYING…";
    end;

    local v156 = v154 + 60 - p151;

    if v156 <= 0 then
        return p152 and "NEXT UPDATE" or "UPDATES EVERY 5 MIN", "UPDATING…";
    end;

    if p152 then
        return "NEXT UPDATE", Widgets.clock(v156);
    end;

    return "UPDATES EVERY 5 MIN", "NEXT IN " .. Widgets.clock(v156);
end;

local u157 = {};

local function setupPrompt(p158) -- Line: 548
    -- upvalues: u9 (ref), TeamEventConfig (copy), permitted (copy), u11 (ref)
    p158.ActionText = u9 and TeamEventConfig.Team[u9.team] and "Event progress" or "Pick a side";
    p158.ObjectText = "FOOTBALL vs FÚTBOL";
    p158.Exclusivity = Enum.ProximityPromptExclusivity.OneGlobally;
    local v159;

    if u9 == nil then
        v159 = false;
    else
        v159 = u9.enabled == true;
    end;

    local v160 = v159 and permitted() and u11 == nil;
    p158.Enabled = v160;
end;

local function setupPrompts(p161) -- Line: 554
    -- upvalues: u9 (ref), TeamEventConfig (copy), permitted (copy), u11 (ref)
    for _, descendant in p161:GetDescendants() do
        if descendant:IsA("ProximityPrompt") then
            descendant.ActionText = u9 and TeamEventConfig.Team[u9.team] and "Event progress" or "Pick a side";
            descendant.ObjectText = "FOOTBALL vs FÚTBOL";
            descendant.Exclusivity = Enum.ProximityPromptExclusivity.OneGlobally;
            local v162;

            if u9 == nil then
                v162 = false;
            else
                v162 = u9.enabled == true;
            end;

            local v163 = v162 and permitted() and u11 == nil;
            descendant.Enabled = v163;
        end;
    end;
end;

local function refreshPrompts() -- Line: 561
    -- upvalues: u157 (copy), setupPrompts (copy)
    for i in u157 do
        setupPrompts(i);
    end;
end;

local function button(p164, p165, p166, p167, p168) -- Line: 569
    -- upvalues: Color3_new_ret (copy), Color3_new_ret2 (copy), Color3_fromRGB_ret5 (copy), u2 (copy), label (copy), Font_new_ret2 (copy)
    local v169 = {
        AutoButtonColor = true,
        Text = "",
        Name = p165,
        Position = p166,
        Size = p167,
        BackgroundColor3 = Color3_new_ret
    };
    local TextButton = Instance.new("TextButton");

    for i, v in v169 do
        TextButton[i] = v;
    end;

    TextButton.Parent = p164;
    local v170 = {
        CornerRadius = UDim.new(0.22, 0)
    };
    local UICorner = Instance.new("UICorner");

    for i, v in v170 do
        UICorner[i] = v;
    end;

    UICorner.Parent = TextButton;
    local v171 = {
        Thickness = 3,
        ZIndex = 1,
        Color = Color3_new_ret2,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    };
    local UIStroke = Instance.new("UIStroke");

    for i, v in v171 do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = TextButton;
    local v172 = {
        Thickness = 2,
        ZIndex = 2,
        Color = Color3_fromRGB_ret5,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    };
    local UIStroke2 = Instance.new("UIStroke");
    local v173 = {
        button = TextButton
    };

    for i, v in v172 do
        UIStroke2[i] = v;
    end;

    UIStroke2.Parent = TextButton;
    v173.edge = UIStroke2;
    local v174 = {
        Rotation = 90,
        Color = u2.fill
    };
    local UIGradient = Instance.new("UIGradient");

    for i, v in v174 do
        UIGradient[i] = v;
    end;

    UIGradient.Parent = TextButton;
    v173.fill = UIGradient;
    v173.text = label(TextButton, "", p168, Color3_new_ret, {
        Name = "TextLabel",
        TextWrapped = true,
        ZIndex = 2,
        Position = UDim2.fromScale(0.04, 0),
        Size = UDim2.fromScale(0.92, 1),
        TextXAlignment = Enum.TextXAlignment.Center,
        FontFace = Font_new_ret2
    });
    local text = v173.text;
    local v175 = {
        Thickness = 2,
        Color = Color3_new_ret2,
        LineJoinMode = Enum.LineJoinMode.Round
    };
    local UIStroke3 = Instance.new("UIStroke");

    for i, v in v175 do
        UIStroke3[i] = v;
    end;

    UIStroke3.Parent = text;

    return v173;
end;

local function paintButton(p176, p177, p178, p179) -- Line: 597
    -- upvalues: Widgets (copy)
    if p176.look ~= p177 then
        p176.look = p177;
        p176.fill.Color = p177.fill;
        p176.edge.Color = p177.edge;
        p176.text.TextColor3 = p177.text;
    end;

    Widgets.setText(p176.text, p178);

    if p176.button.Interactable ~= p179 then
        p176.button.Interactable = p179;
        p176.button.AutoButtonColor = p179;
    end;
end;

local function setFill(p180, p181) -- Line: 610
    local math_clamp_ret = math.clamp(p181, 0, 1);

    if p180.Size.X.Scale ~= math_clamp_ret then
        p180.Size = UDim2.fromScale(math_clamp_ret, 1);
    end;

    p180.Visible = math_clamp_ret > 0;
end;

local function screenOf(p182) -- Line: 619
    local AbsoluteSize = p182.AbsoluteSize;

    if AbsoluteSize.X > 0 and AbsoluteSize.Y > 0 then
        return AbsoluteSize;
    end;

    local workspace_CurrentCamera = workspace.CurrentCamera;

    if workspace_CurrentCamera then
        return workspace_CurrentCamera.ViewportSize;
    end;

    return Vector2.new(1280, 720);
end;

local function scaleFor(p183, p184) -- Line: 627
    return math.min(p183.X * 0.96 / p184.X, p183.Y * 0.94 / p184.Y, 1.2);
end;

local function compactScreen(p185, p186) -- Line: 631
    local AbsoluteSize = p185.AbsoluteSize;

    if AbsoluteSize.X <= 0 or AbsoluteSize.Y <= 0 then
        local workspace_CurrentCamera = workspace.CurrentCamera;

        if workspace_CurrentCamera then
            AbsoluteSize = workspace_CurrentCamera.ViewportSize;
        else
            AbsoluteSize = Vector2.new(1280, 720);
        end;
    end;

    return math.min(AbsoluteSize.X * 0.96 / p186.X, AbsoluteSize.Y * 0.94 / p186.Y, 1.2) < 0.85;
end;

local function fit(p187) -- Line: 634
    local pop = p187.tweens.pop;

    if pop then
        p187.tweens.pop = nil;
        pop:Cancel();
    end;

    local scale = p187.scale;
    local AbsoluteSize = p187.gui.AbsoluteSize;

    if AbsoluteSize.X <= 0 or AbsoluteSize.Y <= 0 then
        local workspace_CurrentCamera = workspace.CurrentCamera;

        if workspace_CurrentCamera then
            AbsoluteSize = workspace_CurrentCamera.ViewportSize;
        else
            AbsoluteSize = Vector2.new(1280, 720);
        end;
    end;

    local size = p187.size;
    scale.Scale = math.min(AbsoluteSize.X * 0.96 / size.X, AbsoluteSize.Y * 0.94 / size.Y, 1.2) * (p187.mode == "progress" and not p187.compact and 0.8 or 1);
end;

local function ball(p188, p189, p190, p191) -- Line: 640
    -- upvalues: Vector2_new_ret5 (copy), Color3_new_ret (copy), Preview (copy), SkinCatalog (copy), label (copy), TeamEventConfig (copy)
    local v192 = {
        Name = "Ball",
        BackgroundTransparency = 1,
        AnchorPoint = Vector2_new_ret5,
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(1, 1),
        Ambient = Color3.fromRGB(200, 200, 200),
        LightColor = Color3_new_ret
    };
    local ViewportFrame = Instance.new("ViewportFrame");

    for i, v in v192 do
        ViewportFrame[i] = v;
    end;

    ViewportFrame.Parent = p189;
    local knife = Preview.knife;
    local v193 = SkinCatalog.get(p190);
    local success, result = pcall(knife, ViewportFrame, v193, nil);

    if success and result then
        table.insert(p188.previews, result);

        return ViewportFrame;
    end;

    ViewportFrame:Destroy();

    return label(p189, TeamEventConfig.Team[p190].Icon, math.floor(p191 * 0.72), Color3_new_ret, {
        Name = "Ball",
        AutoLocalize = false,
        Size = UDim2.fromScale(1, 1),
        TextXAlignment = Enum.TextXAlignment.Center
    });
end;

local function versus(p194, p195, p196, p197) -- Line: 665
    -- upvalues: Vector2_new_ret5 (copy), Color3_fromRGB_ret10 (copy), Color3_new_ret (copy), UDim_new_ret (copy), Color3_new_ret2 (copy), label (copy), Font_new_ret3 (copy), TweenInfo_new_ret (copy), TweenService (copy), TweenInfo_new_ret2 (copy)
    local v198 = {
        Name = "Versus",
        BackgroundTransparency = 1,
        Size = UDim2.fromOffset(p196, p196)
    };
    local Frame = Instance.new("Frame");

    for i, v in v198 do
        Frame[i] = v;
    end;

    Frame.Parent = p195;
    local v199 = {
        Name = "Rays",
        ImageTransparency = 0.55,
        AnchorPoint = Vector2_new_ret5,
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(2.4, 2.4),
        ImageColor3 = Color3_fromRGB_ret10
    };
    local v200 = {
        BackgroundTransparency = 1,
        Image = "rbxassetid://129028976496842",
        ScaleType = Enum.ScaleType.Fit
    };
    local ImageLabel = Instance.new("ImageLabel");

    for i, v in v200 do
        ImageLabel[i] = v;
    end;

    ImageLabel.Parent = Frame;

    for i, v in v199 do
        ImageLabel[i] = v;
    end;

    local v201 = {
        Name = "Glow",
        ImageTransparency = 0.3,
        AnchorPoint = Vector2_new_ret5,
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(1.9, 1.9),
        ImageColor3 = Color3_fromRGB_ret10
    };
    local v202 = {
        BackgroundTransparency = 1,
        Image = "rbxassetid://120639974824188",
        ScaleType = Enum.ScaleType.Fit
    };
    local ImageLabel2 = Instance.new("ImageLabel");

    for i, v in v202 do
        ImageLabel2[i] = v;
    end;

    ImageLabel2.Parent = Frame;

    for i, v in v201 do
        ImageLabel2[i] = v;
    end;

    local v203 = {
        Name = "Badge",
        ZIndex = 2,
        AnchorPoint = Vector2_new_ret5,
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(0.86, 0.86),
        BackgroundColor3 = Color3_new_ret
    };
    local Frame2 = Instance.new("Frame");

    for i, v in v203 do
        Frame2[i] = v;
    end;

    Frame2.Parent = Frame;
    local v204 = {
        CornerRadius = UDim_new_ret
    };
    local UICorner = Instance.new("UICorner");

    for i, v in v204 do
        UICorner[i] = v;
    end;

    UICorner.Parent = Frame2;
    local Color3_fromRGB_ret13 = Color3.fromRGB(255, 36, 56);
    local Color3_fromRGB_ret14 = Color3.fromRGB(24, 118, 255);
    local v205 = {
        Rotation = 35,
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3_fromRGB_ret13:Lerp(Color3_new_ret, 0.2)),
            ColorSequenceKeypoint.new(0.47, Color3_fromRGB_ret13),
            ColorSequenceKeypoint.new(0.53, Color3_fromRGB_ret14),
            ColorSequenceKeypoint.new(1, Color3_fromRGB_ret14:Lerp(Color3_new_ret, 0.2))
        })
    };
    local UIGradient = Instance.new("UIGradient");

    for i, v in v205 do
        UIGradient[i] = v;
    end;

    UIGradient.Parent = Frame2;
    local v206 = {
        ZIndex = 1,
        Color = Color3_new_ret2,
        Thickness = math.max(3, p196 / 14),
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    };
    local UIStroke = Instance.new("UIStroke");

    for i, v in v206 do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = Frame2;
    local v207 = {
        ZIndex = 2,
        Color = Color3_fromRGB_ret10,
        Thickness = math.max(2, p196 / 28),
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    };
    local UIStroke2 = Instance.new("UIStroke");

    for i, v in v207 do
        UIStroke2[i] = v;
    end;

    UIStroke2.Parent = Frame2;
    local v208 = label(Frame2, "VS", math.floor(p196 * 0.4), Color3_new_ret, {
        Name = "Text",
        AutoLocalize = false,
        ZIndex = 3,
        Size = UDim2.fromScale(1, 1),
        TextXAlignment = Enum.TextXAlignment.Center,
        FontFace = Font_new_ret3
    });
    local v209 = {
        Color = Color3_new_ret2,
        Thickness = math.max(2, p196 / 20),
        LineJoinMode = Enum.LineJoinMode.Round
    };
    local UIStroke3 = Instance.new("UIStroke");

    for i, v in v209 do
        UIStroke3[i] = v;
    end;

    UIStroke3.Parent = v208;
    local v210 = p197 .. ":rays";
    local v211 = {
        Rotation = 360
    };
    local v212 = p194.tweens[v210];

    if v212 then
        v212:Cancel();
    end;

    local v213 = TweenService:Create(ImageLabel, TweenInfo_new_ret, v211);
    p194.tweens[v210] = v213;
    v213:Play();
    local v214 = p197 .. ":glow";
    local v215 = {
        ImageTransparency = 0.7
    };
    local v216 = p194.tweens[v214];

    if v216 then
        v216:Cancel();
    end;

    local v217 = TweenService:Create(ImageLabel2, TweenInfo_new_ret2, v215);
    p194.tweens[v214] = v217;
    v217:Play();

    return Frame;
end;

local function buildLogo(p218, p219, p220, p221) -- Line: 720
    -- upvalues: row (copy), Vector2_new_ret5 (copy), TeamEventConfig (copy), label (copy), Color3_new_ret (copy), Font_new_ret3 (copy), Color3_new_ret2 (copy), ball (copy), TweenInfo_new_ret4 (copy), TweenService (copy), versus (copy)
    local v222 = row(p219, {
        Name = "Logo",
        AnchorPoint = Vector2_new_ret5,
        Position = UDim2.new(0.5, p221, 0.5, 0),
        Size = UDim2.fromOffset(0, (math.floor(p220 * 1.8))),
        AutomaticSize = Enum.AutomaticSize.X
    }, Enum.HorizontalAlignment.Center, -math.floor(p220 * 0.15));
    local math_floor_ret = math.floor(p220 * 1.5);

    for i, v in TeamEventConfig.Teams do
        local v223 = TeamEventConfig.Team[v];
        local v224 = i == 1;
        local v225 = label(v222, v223.Name, p220, Color3_new_ret, {
            AutoLocalize = false,
            ZIndex = 4,
            Name = v .. "Name",
            LayoutOrder = v224 and 1 or 5,
            Size = UDim2.fromOffset(0, (math.floor(p220 * 1.3))),
            AutomaticSize = Enum.AutomaticSize.X,
            FontFace = Font_new_ret3
        });
        local v226 = {
            Color = v223.Color:Lerp(Color3_new_ret2, 0.45),
            Thickness = math.max(2, p220 / 10),
            LineJoinMode = Enum.LineJoinMode.Round
        };
        local UIStroke = Instance.new("UIStroke");
        local v227 = v;

        for i2, v2 in v226 do
            UIStroke[i2] = v2;
        end;

        UIStroke.Parent = v225;
        local v228, v229 = v223.Color:Lerp(Color3_new_ret, 0.55);
        local v230 = {
            Color = ColorSequence.new(Color3_new_ret, v228),
            Rotation = v229 or 90
        };
        local UIGradient = Instance.new("UIGradient");

        for i2, v2 in v230 do
            UIGradient[i2] = v2;
        end;

        UIGradient.Parent = v225;
        local v231 = {
            PaddingLeft = UDim.new(0, 4),
            PaddingRight = UDim.new(0, 6)
        };
        local UIPadding = Instance.new("UIPadding");

        for i2, v2 in v231 do
            UIPadding[i2] = v2;
        end;

        UIPadding.Parent = v225;
        local v232 = {
            BackgroundTransparency = 1,
            ZIndex = 3,
            Name = v227 .. "Ball",
            LayoutOrder = v224 and 2 or 4,
            Size = UDim2.fromOffset(math_floor_ret, math_floor_ret)
        };
        local Frame = Instance.new("Frame");

        for i2, v2 in v232 do
            Frame[i2] = v2;
        end;

        Frame.Parent = v222;
        local v233 = {
            Name = "Rider",
            BackgroundTransparency = 1,
            AnchorPoint = Vector2_new_ret5,
            Position = UDim2.fromScale(0.5, 0.5),
            Size = UDim2.fromScale(1, 1)
        };
        local Frame2 = Instance.new("Frame");

        for i2, v2 in v233 do
            Frame2[i2] = v2;
        end;

        Frame2.Parent = Frame;
        ball(p218, Frame2, v227, math_floor_ret);
        local v234 = "logo:" .. v227;
        local v235 = {
            Position = UDim2.new(0.5, v224 and 5 or -5, 0.5, 0)
        };
        local v236 = p218.tweens[v234];

        if v236 then
            v236:Cancel();
        end;

        local v237 = TweenService:Create(Frame2, TweenInfo_new_ret4, v235);
        p218.tweens[v234] = v237;
        v237:Play();
    end;

    local v238 = versus(p218, v222, math.floor(p220 * 1.75), "logo");
    v238.LayoutOrder = 3;
    v238.ZIndex = 2;

    return v222;
end;

local function buildHeader(p239, p240) -- Line: 769
    -- upvalues: Color3_new_ret2 (copy), Color3_fromRGB_ret9 (copy), UDim_new_ret (copy), TweenInfo_new_ret3 (copy), TweenService (copy), label (copy), Color3_fromRGB_ret7 (copy), Color3_fromRGB_ret10 (copy), Font_new_ret2 (copy), Color3_new_ret (copy), u19 (ref), Color3_fromRGB_ret4 (copy), Color3_fromRGB_ret8 (copy), ColorSequence_new_ret (copy)
    local ui = p239.ui;
    local v241 = p240 and 8 or 12;
    local v242 = p240 and 48 or 58;
    local panel = p239.panel;
    local v243 = {
        Name = "Header",
        BackgroundTransparency = 1,
        ZIndex = 2,
        Position = UDim2.fromOffset(v241, v241),
        Size = UDim2.new(1, v241 * -2, 0, v242)
    };
    local Frame = Instance.new("Frame");

    for i, v in v243 do
        Frame[i] = v;
    end;

    Frame.Parent = panel;
    local v244 = p240 and 116 or 186;
    local v245 = {
        Name = "Countdown",
        BackgroundTransparency = 0.35,
        AnchorPoint = Vector2.new(0, 0.5),
        Position = UDim2.fromScale(0, 0.5),
        Size = UDim2.fromOffset(v244, v242 - 6),
        BackgroundColor3 = Color3_new_ret2
    };
    local Frame2 = Instance.new("Frame");

    for i, v in v245 do
        Frame2[i] = v;
    end;

    Frame2.Parent = Frame;
    local v246 = {
        CornerRadius = UDim.new(0, 10)
    };
    local UICorner = Instance.new("UICorner");

    for i, v in v246 do
        UICorner[i] = v;
    end;

    UICorner.Parent = Frame2;
    local v247 = {
        Thickness = 2,
        ZIndex = 1,
        Color = Color3_fromRGB_ret9,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    };
    local UIStroke = Instance.new("UIStroke");

    for i, v in v247 do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = Frame2;
    ui.chipEdge = UIStroke;
    local v248 = {
        Name = "Dot",
        AnchorPoint = Vector2.new(0, 0.5),
        Position = UDim2.fromOffset(10, p240 and 11 or 13),
        Size = UDim2.fromOffset(8, 8),
        BackgroundColor3 = Color3_fromRGB_ret9
    };
    local Frame3 = Instance.new("Frame");

    for i, v in v248 do
        Frame3[i] = v;
    end;

    Frame3.Parent = Frame2;
    ui.dot = Frame3;
    local dot = ui.dot;
    local v249 = {
        CornerRadius = UDim_new_ret
    };
    local UICorner2 = Instance.new("UICorner");

    for i, v in v249 do
        UICorner2[i] = v;
    end;

    UICorner2.Parent = dot;
    local dot2 = ui.dot;
    local v250 = {
        BackgroundTransparency = 0.8
    };
    local dot3 = p239.tweens.dot;

    if dot3 then
        dot3:Cancel();
    end;

    local v251 = TweenService:Create(dot2, TweenInfo_new_ret3, v250);
    p239.tweens.dot = v251;
    v251:Play();
    ui.clockTop = label(Frame2, "", p240 and 10 or 11, Color3_fromRGB_ret7, {
        Name = "Status",
        Position = UDim2.fromOffset(23, p240 and 3 or 4),
        Size = UDim2.new(1, -28, 0, p240 and 15 or 18),
        TextTruncate = Enum.TextTruncate.AtEnd
    });
    ui.clock = label(Frame2, "", p240 and 13 or 18, Color3_fromRGB_ret10, {
        Name = "Time",
        AutoLocalize = false,
        Position = UDim2.fromOffset(10, p240 and 19 or 22),
        Size = UDim2.new(1, -16, 0, p240 and 18 or 24),
        FontFace = Font_new_ret2,
        TextTruncate = Enum.TextTruncate.AtEnd
    });
    local v252 = v242 - 8;
    local v253 = {
        Name = "CloseButton",
        AutoButtonColor = true,
        Text = "",
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.fromScale(1, 0.5),
        Size = UDim2.fromOffset(v252, v252),
        BackgroundColor3 = Color3_new_ret
    };
    local TextButton = Instance.new("TextButton");

    for i, v in v253 do
        TextButton[i] = v;
    end;

    TextButton.Parent = Frame;
    local v254 = {
        CornerRadius = UDim_new_ret
    };
    local UICorner3 = Instance.new("UICorner");

    for i, v in v254 do
        UICorner3[i] = v;
    end;

    UICorner3.Parent = TextButton;
    local Color3_fromRGB_ret13 = Color3.fromRGB(255, 96, 112);
    local Color3_fromRGB_ret14, v255 = Color3.fromRGB(186, 22, 46);
    local v256 = {
        Color = ColorSequence.new(Color3_fromRGB_ret13, Color3_fromRGB_ret14),
        Rotation = v255 or 90
    };
    local UIGradient = Instance.new("UIGradient");

    for i, v in v256 do
        UIGradient[i] = v;
    end;

    UIGradient.Parent = TextButton;
    local v257 = {
        Thickness = 3,
        ZIndex = 1,
        Color = Color3_new_ret2,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    };
    local UIStroke2 = Instance.new("UIStroke");

    for i, v in v257 do
        UIStroke2[i] = v;
    end;

    UIStroke2.Parent = TextButton;
    local v258 = label(TextButton, "X", p240 and 20 or 24, Color3_new_ret, {
        Name = "TextLabel",
        AutoLocalize = false,
        Size = UDim2.fromScale(1, 1),
        TextXAlignment = Enum.TextXAlignment.Center,
        FontFace = Font_new_ret2
    });
    local v259 = {
        Thickness = 2,
        Color = Color3_new_ret2,
        LineJoinMode = Enum.LineJoinMode.Round
    };
    local UIStroke3 = Instance.new("UIStroke");

    for i, v in v259 do
        UIStroke3[i] = v;
    end;

    UIStroke3.Parent = v258;
    table.insert(p239.content, TextButton.Activated:Connect(function() -- Line: 834
        -- upvalues: u19 (ref)
        u19("Button");
    end));
    local v260 = p240 and 92 or 152;
    local v261 = {
        Name = "Updates",
        BackgroundTransparency = 0.35,
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, -(v252 + 8), 0.5, 0),
        Size = UDim2.fromOffset(v260, v242 - 6),
        BackgroundColor3 = Color3_new_ret2
    };
    local Frame4 = Instance.new("Frame");

    for i, v in v261 do
        Frame4[i] = v;
    end;

    Frame4.Parent = Frame;
    local v262 = {
        CornerRadius = UDim.new(0, 10)
    };
    local UICorner4 = Instance.new("UICorner");

    for i, v in v262 do
        UICorner4[i] = v;
    end;

    UICorner4.Parent = Frame4;
    local v263 = {
        Thickness = 2,
        ZIndex = 1,
        Color = Color3_fromRGB_ret4,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    };
    local UIStroke4 = Instance.new("UIStroke");

    for i, v in v263 do
        UIStroke4[i] = v;
    end;

    UIStroke4.Parent = Frame4;
    ui.tickTop = label(Frame4, "", p240 and 9 or 10, Color3_fromRGB_ret8, {
        Name = "Every",
        Position = UDim2.fromOffset(8, p240 and 4 or 5),
        Size = UDim2.new(1, -16, 0, 14),
        TextXAlignment = Enum.TextXAlignment.Right,
        TextTruncate = Enum.TextTruncate.AtEnd
    });
    ui.tick = label(Frame4, "", p240 and 13 or 16, Color3_new_ret, {
        Name = "Next",
        Position = UDim2.fromOffset(8, p240 and 19 or 22),
        Size = UDim2.new(1, -16, 0, p240 and 18 or 22),
        TextXAlignment = Enum.TextXAlignment.Right,
        FontFace = Font_new_ret2,
        TextTruncate = Enum.TextTruncate.AtEnd
    });
    local panel2 = p239.panel;
    local v264 = {
        Name = "HeaderLine",
        BorderSizePixel = 0,
        Position = UDim2.fromOffset(v241 + 30, v241 + v242 + 2),
        Size = UDim2.new(1, v241 * -2 - 60, 0, 2),
        BackgroundColor3 = Color3_new_ret
    };
    local Frame5 = Instance.new("Frame");

    for i, v in v264 do
        Frame5[i] = v;
    end;

    Frame5.Parent = panel2;
    local v265 = {
        Color = ColorSequence_new_ret,
        Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 1),
            NumberSequenceKeypoint.new(0.2, 0.2),
            NumberSequenceKeypoint.new(0.8, 0.2),
            NumberSequenceKeypoint.new(1, 1)
        })
    };
    local UIGradient2 = Instance.new("UIGradient");

    for i, v in v265 do
        UIGradient2[i] = v;
    end;

    UIGradient2.Parent = Frame5;

    return Frame, v241 + v242, (v244 - (v260 + v252 + 8)) / 2;
end;

local function paintHeader(p266, p267) -- Line: 881
    -- upvalues: countdown (copy), Widgets (copy), ticker (copy)
    local ui = p266.ui;
    local v268, v269, v270 = countdown(p267, p266.compact);
    Widgets.setText(ui.clockTop, v268);
    Widgets.setText(ui.clock, v269);
    ui.dot.BackgroundColor3 = v270;
    ui.chipEdge.Color = v270;
    local v271, v272 = ticker(p266.snapshot, p267, p266.compact);
    Widgets.setText(ui.tickTop, v271);
    Widgets.setText(ui.tick, v272);
end;

local function picture(p273, p274, u275, p276, p277) -- Line: 896
    -- upvalues: Color3_new_ret (copy), label (copy), Color3_new_ret2 (copy), Font_new_ret3 (copy), Vector2_new_ret5 (copy), Preview (copy), EmotePose (copy)
    if not u275.title then
        if u275.icon then
            local v278 = u275.icon:Clone();
            v278.AnchorPoint = Vector2_new_ret5;
            v278.Position = UDim2.fromScale(0.5, 0.5);
            v278.Size = UDim2.fromScale(0.86, 0.86);
            v278.Parent = p274;
        elseif u275.glyph then
            label(p274, u275.glyph, math.floor(p276 * 0.6), Color3_new_ret, {
                Name = "Glyph",
                AutoLocalize = false,
                Size = UDim2.fromScale(1, 1),
                TextXAlignment = Enum.TextXAlignment.Center
            });
        else
            local v279 = u275.image or "";
            local v280 = {
                Name = "Image",
                AnchorPoint = Vector2_new_ret5,
                Position = UDim2.fromScale(0.5, 0.5),
                Size = UDim2.fromScale(0.92, 0.92),
                ImageColor3 = u275.tint or Color3_new_ret
            };
            local v281 = {
                BackgroundTransparency = 1,
                Image = v279,
                ScaleType = Enum.ScaleType.Fit
            };
            local ImageLabel = Instance.new("ImageLabel");

            for i, v in v281 do
                ImageLabel[i] = v;
            end;

            ImageLabel.Parent = p274;

            for i, v in v280 do
                ImageLabel[i] = v;
            end;

            if u275.knife or (u275.emote or u275.gear and not u275.image) then
                local v282 = {
                    Name = "View",
                    BackgroundTransparency = 1,
                    Size = UDim2.fromScale(1, 1),
                    Ambient = Color3.fromRGB(200, 200, 200),
                    LightColor = Color3_new_ret
                };
                local ViewportFrame = Instance.new("ViewportFrame");

                for i, v in v282 do
                    ViewportFrame[i] = v;
                end;

                ViewportFrame.Parent = p274;
                local success, result = pcall(function() -- Line: 962
                    -- upvalues: u275 (copy), Preview (ref), ViewportFrame (copy), EmotePose (ref)
                    if u275.knife then
                        return Preview.knife(ViewportFrame, u275.knife, nil);
                    end;

                    if u275.emote then
                        return EmotePose.new(ViewportFrame, u275.emote);
                    end;

                    return Preview.gear(ViewportFrame, u275.gear, 0);
                end);

                if success and result then
                    table.insert(p273.previews, result);
                    ImageLabel.Visible = false;
                else
                    ViewportFrame:Destroy();
                end;
            end;
        end;

        if u275.boost then
            local v283 = label(p274, "2×", p277, Color3_new_ret, {
                Name = "Boost",
                BackgroundTransparency = 0,
                AutoLocalize = false,
                ZIndex = 3,
                AnchorPoint = Vector2.new(1, 0),
                Position = UDim2.new(1, 2, 0, -2),
                Size = UDim2.fromOffset(math.floor(p277 * 2), p277 + 4),
                BackgroundColor3 = u275.color:Lerp(Color3_new_ret2, 0.45),
                TextXAlignment = Enum.TextXAlignment.Center,
                FontFace = Font_new_ret3
            });
            local v284 = {
                Thickness = 1.5,
                Color = Color3_new_ret2,
                LineJoinMode = Enum.LineJoinMode.Round
            };
            local UIStroke = Instance.new("UIStroke");

            for i, v in v284 do
                UIStroke[i] = v;
            end;

            UIStroke.Parent = v283;
            local v285 = {
                CornerRadius = UDim.new(0, 5)
            };
            local UICorner = Instance.new("UICorner");

            for i, v in v285 do
                UICorner[i] = v;
            end;

            UICorner.Parent = v283;
        end;

        if u275.amount then
            local v286 = label(p274, u275.amount, p277, u275.amountColor or Color3_new_ret, {
                Name = "Amount",
                AutoLocalize = false,
                ZIndex = 3,
                AnchorPoint = Vector2.new(0.5, 1),
                Position = UDim2.new(0.5, 0, 1, 3),
                Size = UDim2.new(1.5, 0, 0, p277 + 2),
                TextXAlignment = Enum.TextXAlignment.Center,
                FontFace = Font_new_ret3
            });
            local v287 = {
                Thickness = 2,
                Color = Color3_new_ret2,
                LineJoinMode = Enum.LineJoinMode.Round
            };
            local UIStroke = Instance.new("UIStroke");

            for i, v in v287 do
                UIStroke[i] = v;
            end;

            UIStroke.Parent = v286;
        end;

        return;
    end;

    local title = u275.title;
    local v288 = u275.color:Lerp(Color3_new_ret, 0.45);
    local v289 = p276 >= 40;
    label(p274, tostring(title.Icon or "🏆"), math.floor(p276 * (v289 and 0.36 or 0.55)), Color3_new_ret, {
        Name = "Glyph",
        AutoLocalize = false,
        Size = UDim2.fromScale(1, v289 and 0.46 or 0.72),
        TextXAlignment = Enum.TextXAlignment.Center
    });
    local v290 = {
        Name = "Plate",
        BackgroundTransparency = 0.05,
        AnchorPoint = Vector2.new(0.5, 0),
        Position = UDim2.fromScale(0.5, v289 and 0.46 or 0.74),
        Size = UDim2.fromScale(v289 and 1.14 or 0.9, v289 and 0.52 or 0.22),
        BackgroundColor3 = u275.color:Lerp(Color3_new_ret2, 0.62)
    };
    local Frame = Instance.new("Frame");

    for i, v in v290 do
        Frame[i] = v;
    end;

    Frame.Parent = p274;
    local v291 = {
        CornerRadius = UDim.new(0.3, 0)
    };
    local UICorner = Instance.new("UICorner");

    for i, v in v291 do
        UICorner[i] = v;
    end;

    UICorner.Parent = Frame;
    local v292 = {
        ZIndex = 1,
        Color = v288,
        Thickness = math.max(1, p276 / 40),
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    };
    local UIStroke = Instance.new("UIStroke");

    for i, v in v292 do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = Frame;

    if not v289 then
        return;
    end;

    local v293 = tostring(title.Name);
    local math_floor_ret = math.floor(p276 * 0.17);
    local v294 = label(Frame, v293, math.max(9, math_floor_ret), v288, {
        Name = "Title",
        TextWrapped = true,
        AutoLocalize = false,
        Position = UDim2.fromScale(0.04, 0),
        Size = UDim2.fromScale(0.92, 1),
        TextXAlignment = Enum.TextXAlignment.Center,
        FontFace = Font_new_ret3
    });
    local v295 = {
        Thickness = 1.5,
        Color = Color3_new_ret2,
        LineJoinMode = Enum.LineJoinMode.Round
    };
    local UIStroke2 = Instance.new("UIStroke");

    for i, v in v295 do
        UIStroke2[i] = v;
    end;

    UIStroke2.Parent = v294;
end;

local function art(u296, u297, p298, p299, p300, u301) -- Line: 1008
    -- upvalues: Vector2_new_ret5 (copy), Color3_fromRGB_ret10 (copy), picture (copy)
    local v302 = #p298;

    if v302 == 0 then
        return;
    end;

    local v303 = u301 and 4 or 6;
    local math_min_ret = math.min(p300, (p299 - (v302 - 1) * v303) / v302);
    local math_floor_ret = math.floor(math_min_ret);
    local v304, v305, v306;

    if v302 > 2 and math_floor_ret < p300 * 0.8 then
        v304 = v302 - 1 > 6 and 3 or 2;
        v305 = math.ceil((v302 - 1) / v304);
        local math_floor_ret2 = math.floor((p300 - (v304 - 1) * v303) / v304);
        local math_clamp_ret = math.clamp(p299 - v305 * (math_floor_ret2 + v303), p300 * 0.5, p300);
        math_floor_ret = math.floor(math_clamp_ret);
        local v307 = math.floor((p299 - math_floor_ret) / v305) - v303;
        local math_min_ret2 = math.min(math_floor_ret2, v307);
        v306 = math.max(1, math_min_ret2);
    else
        v305 = 0;
        v306 = 0;
        v304 = 2;
    end;

    local v308;

    if v305 > 0 then
        v308 = math_floor_ret + v305 * (v306 + v303);
    else
        v308 = v302 * math_floor_ret + (v302 - 1) * v303;
    end;

    local math_floor_ret2 = math.floor((p299 - v308) / 2);
    local v309 = {
        Name = "Glow",
        ImageTransparency = 0.5,
        AnchorPoint = Vector2_new_ret5,
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromOffset(math.min(p299 + 10, v308 + 50), p300 + 24),
        ImageColor3 = p298[1].color or Color3_fromRGB_ret10
    };
    local v310 = {
        BackgroundTransparency = 1,
        Image = "rbxassetid://120639974824188",
        ScaleType = Enum.ScaleType.Fit
    };
    local ImageLabel = Instance.new("ImageLabel");

    for i, v in v310 do
        ImageLabel[i] = v;
    end;

    ImageLabel.Parent = u297;

    for i, v in v309 do
        ImageLabel[i] = v;
    end;

    local function place(p311, p312, p313, p314, p315) -- Line: 1033
        -- upvalues: u297 (copy), picture (ref), u296 (copy), u301 (copy)
        local v316 = {
            BackgroundTransparency = 1,
            Name = "Item" .. p311,
            Position = UDim2.fromOffset(p313, p314),
            Size = UDim2.fromOffset(p315, p315)
        };
        local Frame = Instance.new("Frame");

        for i, v in v316 do
            Frame[i] = v;
        end;

        Frame.Parent = u297;
        local math_floor_ret3 = math.floor(p315 * 0.27);
        picture(u296, Frame, p312, p315, (math.clamp(math_floor_ret3, 11, u301 and 15 or 18)));
    end;

    for i, v in p298 do
        if v305 == 0 then
            place(i, v, math_floor_ret2 + (i - 1) * (math_floor_ret + v303), math.floor((p300 - math_floor_ret) / 2), math_floor_ret);
        elseif i == 1 then
            place(i, v, math_floor_ret2, math.floor((p300 - math_floor_ret) / 2), math_floor_ret);
        else
            local v317 = (i - 2) // v304;
            local math_min_ret2 = math.min(v304, v302 - 1 - v317 * v304);
            local math_floor_ret3 = math.floor((p300 - math_min_ret2 * v306 - (math_min_ret2 - 1) * v303) / 2);
            place(i, v, math_floor_ret2 + math_floor_ret + v303 + v317 * (v306 + v303), math_floor_ret3 + (i - 2) % v304 * (v306 + v303), v306);
        end;
    end;
end;

local function jlabel(p318, p319, p320, p321, p322, p323, p324) -- Line: 1059
    -- upvalues: Skin (copy)
    local v325 = {
        BackgroundTransparency = 1,
        Name = p319,
        Text = p320,
        TextSize = p321,
        TextColor3 = p322
    };
    local v326;

    if p323 then
        v326 = Enum.Font.GothamBold;
    else
        v326 = Enum.Font.Gotham;
    end;

    v325.Font = v326;
    v325.TextXAlignment = Enum.TextXAlignment.Left;
    v325.TextTruncate = Enum.TextTruncate.AtEnd;
    local TextLabel = Instance.new("TextLabel");

    for i, v in v325 do
        TextLabel[i] = v;
    end;

    TextLabel.Parent = p318;

    for i, v in p324 do
        TextLabel[i] = v;
    end;

    Skin.textStroke(TextLabel, 1);

    return TextLabel;
end;

local function bar(p327, p328, p329, p330, p331, p332) -- Line: 1077
    -- upvalues: Palette (copy), Skin (copy)
    local v333 = {
        Name = p328,
        Position = UDim2.fromOffset(p329, p330),
        Size = UDim2.fromOffset(p331, 5),
        BackgroundColor3 = Palette.track
    };
    local Frame = Instance.new("Frame");

    for i, v in v333 do
        Frame[i] = v;
    end;

    Frame.Parent = p327;
    local v334 = {
        Name = "Fill",
        Size = UDim2.fromScale(0, 1),
        BackgroundColor3 = Palette.gold
    };
    local Frame2 = Instance.new("Frame");

    for i, v in v334 do
        Frame2[i] = v;
    end;

    Frame2.Parent = Frame;
    Skin.bar(Frame, Frame2, p332);

    return Frame2;
end;

local function buildCard(p335, p336, u337, p338, p339, p340, p341, p342) -- Line: 1091
    -- upvalues: TeamEventConfig (copy), u9 (ref), Palette (copy), Skin (copy), jlabel (copy), Color3_new_ret (copy), rewardItems (copy), u10 (ref), SkinCatalog (copy), Color3_new_ret2 (copy), label (copy), Font_new_ret3 (copy), art (copy), u20 (ref)
    local v343;

    if u337 == "Team" then
        v343 = TeamEventConfig.Team[u9.team].Color;
    else
        v343 = Palette.gold;
    end;

    local v344 = {
        BackgroundTransparency = 0.22,
        Name = u337,
        Position = UDim2.fromOffset(0, p341),
        Size = UDim2.fromOffset(p339, p340),
        BackgroundColor3 = Palette.surface
    };
    local Frame = Instance.new("Frame");

    for i, v in v344 do
        Frame[i] = v;
    end;

    Frame.Parent = p336;
    Skin.Theme.surface(Frame, Palette.surface:Lerp(v343, 0.1), v343, 7, 0.72);
    Skin.card(Frame, v343, {
        radius = UDim.new(0, 10)
    });
    local u345 = {
        card = Frame,
        route = jlabel(Frame, "Route", "", 10, v343:Lerp(Color3_new_ret, 0.3), false, {
            AutoLocalize = false,
            Position = UDim2.fromOffset(12, 7),
            Size = UDim2.fromOffset(p339 - 24, 15)
        })
    };
    local v346 = rewardItems(TeamEventConfig.shown(TeamEventConfig.reward(u337, p338, u9.team), u10, SkinCatalog));
    local v347 = p340 >= 145;
    local v348;

    if v347 then
        local math_max_ret = math.max(35, p340 - 125);
        local v349 = {};
        local v350 = {};

        for _, v in v346 do
            local v351;

            if v.title and #v346 > 1 then
                v351 = v349;
            else
                v351 = v350;
            end;

            table.insert(v351, v);
        end;

        local v352 = 27;
        local v353 = p342 and 20 or 24;
        local v354 = p342 and 12 or 14;

        for i, v in v349 do
            local title = v.title;
            local v355 = v.color:Lerp(Color3_new_ret, 0.45);
            local v356 = {
                Name = "Title" .. i,
                Position = UDim2.fromOffset(12, v352),
                Size = UDim2.fromOffset(p339 - 24, v353),
                BackgroundColor3 = v.color:Lerp(Color3_new_ret2, 0.62)
            };
            local Frame2 = Instance.new("Frame");

            for i2, v2 in v356 do
                Frame2[i2] = v2;
            end;

            Frame2.Parent = Frame;
            local v357 = {
                CornerRadius = UDim.new(0.3, 0)
            };
            local UICorner = Instance.new("UICorner");

            for i2, v2 in v357 do
                UICorner[i2] = v2;
            end;

            UICorner.Parent = Frame2;
            local v358 = {
                Thickness = 1.5,
                ZIndex = 1,
                Color = v355,
                ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            };
            local UIStroke = Instance.new("UIStroke");

            for i2, v2 in v358 do
                UIStroke[i2] = v2;
            end;

            UIStroke.Parent = Frame2;
            local v359 = label(Frame2, tostring(title.Icon or "") .. " " .. tostring(title.Name), v354, v355, {
                Name = "TitleName",
                TextScaled = true,
                AutoLocalize = false,
                Position = UDim2.fromScale(0.04, 0),
                Size = UDim2.fromScale(0.92, 1),
                TextXAlignment = Enum.TextXAlignment.Center,
                FontFace = Font_new_ret3
            });
            local v360 = {
                Thickness = 1.5,
                Color = Color3_new_ret2,
                LineJoinMode = Enum.LineJoinMode.Round
            };
            local UIStroke2 = Instance.new("UIStroke");

            for i2, v2 in v360 do
                UIStroke2[i2] = v2;
            end;

            UIStroke2.Parent = v359;
            local UITextSizeConstraint = Instance.new("UITextSizeConstraint");

            for i2, v2 in {
                MaxTextSize = v354
            } do
                UITextSizeConstraint[i2] = v2;
            end;

            UITextSizeConstraint.Parent = v359;
            v352 = v352 + (v353 + 4);
        end;

        local v361 = math_max_ret - (v352 - 27);

        if #v350 > 0 and v361 >= 20 then
            local v362 = {
                Name = "RewardArt",
                BackgroundTransparency = 1,
                Position = UDim2.fromOffset(12, v352),
                Size = UDim2.fromOffset(p339 - 24, v361)
            };
            local Frame2 = Instance.new("Frame");
            v348 = p335;

            for i, v in v362 do
                Frame2[i] = v;
            end;

            Frame2.Parent = Frame;
            art(p335, Frame2, v350, p339 - 24, v361, p342);
        else
            v348 = p335;
        end;
    else
        v348 = p335;
    end;

    local table_create_ret = table.create(#v346);

    for i, v in v346 do
        table_create_ret[i] = string.gsub(string.upper(v.name), "ú", "Ú");
    end;

    local v363 = p342 and 11 or 13;
    local table_concat_ret = table.concat(table_create_ret, "\n");
    local v364 = {
        TextWrapped = true,
        TextScaled = true,
        AutoLocalize = false,
        Position = UDim2.fromOffset(12, not v347 and 25 or p340 - 91),
        Size = UDim2.fromOffset(p339 - 24, v347 and 48 or math.max(26, p340 - 69))
    };
    local v365;

    if v347 then
        v365 = Enum.TextXAlignment.Center;
    else
        v365 = Enum.TextXAlignment.Left;
    end;

    v364.TextXAlignment = v365;
    v364.TextTruncate = Enum.TextTruncate.None;
    local v366 = jlabel(Frame, "Reward", table_concat_ret, v363, Color3_new_ret, true, v364);
    local UITextSizeConstraint = Instance.new("UITextSizeConstraint");

    for i, v in {
        MinTextSize = 7,
        MaxTextSize = v363
    } do
        UITextSizeConstraint[i] = v;
    end;

    UITextSizeConstraint.Parent = v366;
    u345.button = Skin.Panels.button(Frame, "Claim", "", 10, p340 - 38, p339 - 20, 32);
    u345.button.TextSize = 11;
    table.insert(v348.content, u345.button.Activated:Connect(function() -- Line: 1173
        -- upvalues: u345 (copy), u20 (ref), u337 (copy)
        if u345.button.Active then
            u20(u337, u345.button);
        end;
    end));

    return u345;
end;

local u367 = {
    claim = "primary",
    collected = "dark",
    missed = "disabled",
    owed = "buy-coins"
};

local function paintCard(p368, p369, p370, p371) -- Line: 1182
    -- upvalues: Widgets (copy), u12 (ref), Skin (copy), u367 (copy), Palette (copy)
    Widgets.setText(p368.route, p371);
    local v372;

    if p369 == "claim" and u12 > 0 then
        v372 = os.clock() - u12 < 15;
    else
        v372 = false;
    end;

    Widgets.setText(p368.button, v372 and "SAVING…" or (p369 == "collected" and "COLLECTED ✓" or p370));
    local v373;

    if p369 == "claim" then
        v373 = not v372;
    else
        v373 = false;
    end;

    if p368.button.Active ~= v373 then
        p368.button.Active = v373;
        p368.button.AutoButtonColor = v373;
    end;

    if p368.kind ~= p369 then
        p368.kind = p369;
        local v374 = p369 == "collected";
        Skin.button(p368.button, u367[p369] or "secondary");
        Skin.select(p368.button, v374, Palette.green);
        Skin.select(p368.card, v374, Palette.green);
    end;
end;

local function race(p375, p376) -- Line: 1200
    -- upvalues: u9 (ref), TeamEventConfig (copy)
    local v377 = false;
    local v378;

    if u9 and type(u9.phase) == "string" then
        v378 = u9.phase;
    else
        v378 = TeamEventConfig.phaseAt(workspace:GetServerTimeNow());
    end;

    if v378 == "Final" then
        local v379;

        if p375 then
            v379 = p375.final;
        else
            v379 = p375;
        end;

        if type(v379) == "table" and type(v379.champion) == "string" then
            v377 = v379.champion;
        else
            v377 = u9 and u9.finalChampion;
        end;
    end;

    if v377 then
        return v377 == "Both" and "👑 CHAMPIONS: BOTH TEAMS" or (not TeamEventConfig.Team[v377] and "" or "👑 CHAMPION: " .. TeamEventConfig.Team[v377].Name);
    end;

    local v380 = TeamEventConfig.Teams[1];
    local v381 = TeamEventConfig.Teams[2];
    local v382;

    if p375 then
        v382 = p375.teams;
    else
        v382 = p375;
    end;

    local v383;

    if type(v382) == "table" then
        v383 = v382[v380];
    else
        v383 = false;
    end;

    if type(v383) ~= "table" then
        v383 = nil;
    end;

    if p375 then
        p375 = p375.teams;
    end;

    local v384;

    if type(p375) == "table" then
        v384 = p375[v381];
    else
        v384 = false;
    end;

    if type(v384) ~= "table" then
        v384 = nil;
    end;

    local v385 = v383 and tonumber(v383.average) or 0;
    local v386 = v384 and tonumber(v384.average) or 0;

    if v385 == v386 then
        return v385 > 0 and "CHAMPION RACE: TIED" or "";
    end;

    if v386 < v385 then
        v381 = v380;
    end;

    local Name = TeamEventConfig.Team[v381].Name;

    if p376 then
        return "👑 " .. Name .. " LEADS";
    end;

    return ("👑 %s LEADS THE CHAMPION RACE · %.1f vs %.1f AVG PTS PER PLAYER"):format(Name, math.max(v385, v386), (math.min(v385, v386)));
end;

local function paintPick(p387, p388) -- Line: 1221
    -- upvalues: paintHeader (copy), u9 (ref), TeamEventConfig (copy), UserInputService (copy), Widgets (copy), u13 (ref), u14 (ref), u3 (copy), u12 (ref), u2 (copy), u5 (copy), TweenInfo_new_ret3 (copy), TweenService (copy)
    local ui = p387.ui;
    local snapshot = p387.snapshot;
    paintHeader(p387, p388);
    local v389 = false;
    local v390;

    if u9 and type(u9.phase) == "string" then
        v390 = u9.phase;
    else
        v390 = TeamEventConfig.phaseAt(workspace:GetServerTimeNow());
    end;

    if v390 == "Final" then
        if snapshot then
            snapshot = snapshot.final;
        end;

        if type(snapshot) == "table" and type(snapshot.champion) == "string" then
            v389 = snapshot.champion;
        else
            v389 = u9 and u9.finalChampion;
        end;
    end;

    local v391;

    if u9.joinsOpen == true then
        v391 = not TeamEventConfig.Team[u9.team];
    else
        v391 = false;
    end;

    local v392 = UserInputService.PreferredInput == Enum.PreferredInput.Gamepad and "PRESS AGAIN TO JOIN" or "TAP AGAIN TO JOIN";

    for i, v in ui.cards do
        Widgets.setText(v.stats, "");
        v.winner.Visible = v389 == i and true or v389 == "Both";
        local v393;

        if u13 == i then
            v393 = os.clock() < u14;
        else
            v393 = false;
        end;

        if v391 then
            local v394;

            if u12 > 0 then
                v394 = os.clock() - u12 < 15;
            else
                v394 = false;
            end;

            if v394 then
                local join = v.join;
                local v395 = u3;

                if join.look ~= v395 then
                    join.look = v395;
                    join.fill.Color = v395.fill;
                    join.edge.Color = v395.edge;
                    join.text.TextColor3 = v395.text;
                end;

                Widgets.setText(join.text, "JOINING…");

                if join.button.Interactable ~= false then
                    join.button.Interactable = false;
                    join.button.AutoButtonColor = false;
                end;
            elseif v393 then
                local join = v.join;
                local v396 = u2;

                if join.look ~= v396 then
                    join.look = v396;
                    join.fill.Color = v396.fill;
                    join.edge.Color = v396.edge;
                    join.text.TextColor3 = v396.text;
                end;

                Widgets.setText(join.text, v392);

                if join.button.Interactable ~= true then
                    join.button.Interactable = true;
                    join.button.AutoButtonColor = true;
                end;
            else
                local join = v.join;
                local v397 = u5[i];

                if join.look ~= v397 then
                    join.look = v397;
                    join.fill.Color = v397.fill;
                    join.edge.Color = v397.edge;
                    join.text.TextColor3 = v397.text;
                end;

                Widgets.setText(join.text, "JOIN");

                if join.button.Interactable ~= true then
                    join.button.Interactable = true;
                    join.button.AutoButtonColor = true;
                end;
            end;
        else
            local join = v.join;
            local v398 = u3;

            if join.look ~= v398 then
                join.look = v398;
                join.fill.Color = v398.fill;
                join.edge.Color = v398.edge;
                join.text.TextColor3 = v398.text;
            end;

            Widgets.setText(join.text, "SIGN-UPS CLOSED");

            if join.button.Interactable ~= false then
                join.button.Interactable = false;
                join.button.AutoButtonColor = false;
            end;
        end;

        if v393 then
            if v391 then
                local v399;

                if u12 > 0 then
                    v399 = os.clock() - u12 < 15;
                else
                    v399 = false;
                end;

                v393 = not v399;
            else
                v393 = v391;
            end;
        end;

        if v.armed ~= v393 then
            v.armed = v393;

            if v393 then
                local beatKey = v.beatKey;
                local scale = v.scale;
                local v400 = {
                    Scale = 1.06
                };
                local v401 = p387.tweens[beatKey];

                if v401 then
                    v401:Cancel();
                end;

                local v402 = TweenService:Create(scale, TweenInfo_new_ret3, v400);
                p387.tweens[beatKey] = v402;
                v402:Play();
            else
                local beatKey = v.beatKey;
                local v403 = p387.tweens[beatKey];

                if v403 then
                    p387.tweens[beatKey] = nil;
                    v403:Cancel();
                end;

                v.scale.Scale = 1;
            end;
        end;
    end;
end;

local function paintProgress(p404, p405) -- Line: 1258
    -- upvalues: u9 (ref), u1 (copy), thresholds (copy), countdown (copy), Widgets (copy), TeamEventConfig (copy), short (copy), rankText (copy), u6 (copy), cardState (copy), u15 (ref), paintCard (copy), u12 (ref), Skin (copy), ticker (copy), race (copy), u8 (copy)
    local ui = p404.ui;
    local snapshot = p404.snapshot;
    local team = u9.team;
    local v406;

    if snapshot then
        v406 = snapshot.teams;
    else
        v406 = snapshot;
    end;

    local v407;

    if type(v406) == "table" then
        v407 = v406[team];
    else
        v407 = false;
    end;

    if type(v407) ~= "table" then
        v407 = nil;
    end;

    local v408 = v407 and (tonumber(v407.points) or 0) or 0;
    local v409 = v407 and (tonumber(v407.reached) or 0) or 0;
    local math_clamp_ret = math.clamp(v409, 0, u1);
    local v410 = thresholds(snapshot);
    local v411 = tonumber(u9.points) or 0;
    local v412, v413 = countdown(p405, true);
    local setText = Widgets.setText;
    local ends = ui.ends;
    local v414;

    if string.sub(v412, -3) == " IN" then
        v414 = v412 .. " " .. v413;
    else
        v414 = v412 .. " · " .. v413;
    end;

    setText(ends, v414);

    if ui.teamLevel then
        Widgets.setText(ui.teamLevel, ("TEAM LV %d / %d"):format(math_clamp_ret, u1));
        local boost = TeamEventConfig.boost;
        local v415 = {
            [team] = v407
        };
        local v416 = TeamEventConfig.other(team) or "";
        local v417 = TeamEventConfig.other(team);
        local v418;

        if snapshot then
            v418 = snapshot.teams;
        else
            v418 = snapshot;
        end;

        local v419;

        if type(v418) == "table" then
            v419 = v418[v417];
        else
            v419 = false;
        end;

        if type(v419) ~= "table" then
            v419 = nil;
        end;

        v415[v416] = v419;
        local v420 = boost(v415, team);
        local v421 = v420 <= 1 and "" or (" · ×%.1f TEAM BOOST"):format(v420);

        if v407 then
            if u1 <= math_clamp_ret then
                Widgets.setText(ui.teamInfo, short(v408) .. " TEAM PTS · EVERY LEVEL REACHED" .. v421);
                local teamFill = ui.teamFill;
                local math_clamp_ret2 = math.clamp(1, 0, 1);

                if teamFill.Size.X.Scale ~= math_clamp_ret2 then
                    teamFill.Size = UDim2.fromScale(math_clamp_ret2, 1);
                end;

                teamFill.Visible = math_clamp_ret2 > 0;
            else
                local v422 = v410[math_clamp_ret] or 0;
                local v423 = v410[math_clamp_ret + 1];
                Widgets.setText(ui.teamInfo, ("%s / %s TEAM PTS · NEXT LEVEL"):format(short(v408), short(v423)) .. v421);
                local teamFill = ui.teamFill;
                local v424 = (v408 - v422) / math.max(1, v423 - v422);
                local math_clamp_ret2 = math.clamp(v424, 0, 1);

                if teamFill.Size.X.Scale ~= math_clamp_ret2 then
                    teamFill.Size = UDim2.fromScale(math_clamp_ret2, 1);
                end;

                teamFill.Visible = math_clamp_ret2 > 0;
            end;
        else
            Widgets.setText(ui.teamInfo, "TEAM TOTALS UPDATE EVERY 5 MIN");
            local teamFill = ui.teamFill;
            local math_clamp_ret2 = math.clamp(0, 0, 1);

            if teamFill.Size.X.Scale ~= math_clamp_ret2 then
                teamFill.Size = UDim2.fromScale(math_clamp_ret2, 1);
            end;

            teamFill.Visible = math_clamp_ret2 > 0;
        end;

        local v425;

        if TeamEventConfig.Teams[1] == team then
            v425 = TeamEventConfig.Teams[2];
        else
            v425 = TeamEventConfig.Teams[1];
        end;

        local v426;

        if snapshot then
            v426 = snapshot.teams;
        else
            v426 = snapshot;
        end;

        local v427;

        if type(v426) == "table" then
            v427 = v426[v425];
        else
            v427 = false;
        end;

        if type(v427) ~= "table" then
            v427 = nil;
        end;

        local setText2 = Widgets.setText;
        local rival = ui.rival;
        local v428;

        if v427 then
            local Name = TeamEventConfig.Team[v425].Name;
            local v429 = short(v427.points);
            local v430 = tonumber(v427.reached) or 0;
            v428 = ("VS %s  %s PTS · LV %d"):format(Name, v429, (math.clamp(v430, 0, u1)));
        else
            v428 = "VS " .. TeamEventConfig.Team[v425].Name;
        end;

        setText2(rival, v428);
    end;

    if ui.youLevel then
        local v431 = 0;

        for i, v in TeamEventConfig.PersonalLevels do
            if v <= v411 then
                v431 = i;
            end;
        end;

        Widgets.setText(ui.youLevel, ("YOUR LV %d / %d"):format(v431, u1));
        local v432 = rankText(snapshot, team);

        if u1 <= v431 then
            Widgets.setText(ui.youInfo, Widgets.number(v411) .. " PTS · EVERY LEVEL REACHED" .. v432);
            local youFill = ui.youFill;
            local math_clamp_ret2 = math.clamp(1, 0, 1);

            if youFill.Size.X.Scale ~= math_clamp_ret2 then
                youFill.Size = UDim2.fromScale(math_clamp_ret2, 1);
            end;

            youFill.Visible = math_clamp_ret2 > 0;
        else
            local v433 = TeamEventConfig.PersonalLevels[v431] or 0;
            local v434 = TeamEventConfig.PersonalLevels[v431 + 1];
            Widgets.setText(ui.youInfo, ("%s / %s PTS · NEXT LEVEL%s"):format(Widgets.number(v411), Widgets.number(v434), v432));
            local youFill = ui.youFill;
            local v435 = (v411 - v433) / math.max(1, v434 - v433);
            local math_clamp_ret2 = math.clamp(v435, 0, 1);

            if youFill.Size.X.Scale ~= math_clamp_ret2 then
                youFill.Size = UDim2.fromScale(math_clamp_ret2, 1);
            end;

            youFill.Visible = math_clamp_ret2 > 0;
        end;
    end;

    local ctx = p404.ctx;
    local v436;

    if u9 and type(u9.phase) == "string" then
        v436 = u9.phase;
    else
        v436 = TeamEventConfig.phaseAt(workspace:GetServerTimeNow());
    end;

    ctx.points = v411;
    ctx.reached = math_clamp_ret;
    ctx.phase = v436;
    local compact = p404.compact;
    ctx.teamPoints = v408;
    ctx.levels = v410;
    ctx.compact = compact;
    local v437 = u9.claimsOpen == true;
    ctx.wiped = u9.wiped == true;
    ctx.claimsOpen = v437;
    local v438 = 0;
    local v439 = 0;
    local v440 = 0;

    for _, v in u6 do
        local v441;

        if v == "Team" then
            v441 = u9.teamClaims;
        else
            v441 = u9.personal;
        end;

        local v442 = p404.kinds[v];
        local v443 = ui.rows[v];
        local v444 = v;

        for i = 1, u1 do
            local v445;

            if type(v441) == "table" then
                v445 = v441[i] == true and true or v441[tostring(i)] == true;
            else
                v445 = false;
            end;

            ctx.claimed = v445;
            local v446, v447 = cardState(v444, i, ctx);
            v442[i] = v446;

            if v446 == "claim" then
                v438 = v438 + 1;

                if v444 ~= u15 then
                    v439 = v439 + 1;
                end;
            elseif v446 == "collected" then
                v440 = v440 + 1;
            end;

            local v448 = v443[i];
            local v449;

            if v448 then
                local v450;

                if v444 == "Team" then
                    v450 = "TEAM  ·  " .. short(v410[i]) .. " PTS";
                else
                    v450 = "YOU  ·  " .. Widgets.number(TeamEventConfig.PersonalLevels[i]) .. " PTS";
                end;

                if p404.compact then
                    v450 = ("LEVEL %d  /  %s"):format(i, v450);
                end;

                paintCard(v448, v446, v447, v450);
                v449 = i;
            else
                v449 = i;
            end;
        end;
    end;

    if ui.laneBadge then
        ui.laneBadge.Visible = v439 > 0;
        Widgets.setText(ui.laneBadge, (tostring(v439)));
    end;

    if not ui.scrolled then
        ui.scrolled = true;
        local v451 = nil;

        for i, v in p404.kinds[u15] do
            if v == "claim" then
                v451 = i;
                break;
            end;

            if not v451 and v ~= "collected" then
                v451 = i;
            end;
        end;

        local u452 = ((v451 or 1) - 1) * ui.columnWidth;
        local scroll = ui.scroll;
        scroll.CanvasPosition = Vector2.new(u452 * scroll.AbsoluteCanvasSize.X / ui.canvasWidth, 0);
        local u453 = scroll:GetPropertyChangedSignal("AbsoluteCanvasSize"):Connect(function() -- Line: 1364, Name: apply
            -- upvalues: scroll (copy), u452 (copy), ui (copy)
            scroll.CanvasPosition = Vector2.new(u452 * scroll.AbsoluteCanvasSize.X / ui.canvasWidth, 0);
        end);
        table.insert(p404.content, u453);
        task.delay(1, function() -- Line: 1370
            -- upvalues: u453 (copy)
            u453:Disconnect();
        end);
    end;

    local v454;

    if u12 > 0 then
        v454 = os.clock() - u12 < 15;
    else
        v454 = false;
    end;

    local setText2 = Widgets.setText;
    local claimAll = ui.claimAll;
    local v455;

    if v454 then
        v455 = "SAVING…";
    elseif v438 > 0 then
        v455 = ("CLAIM ALL  ·  %d"):format(v438);
    else
        v455 = v440 == u1 * 2 and "ALL COLLECTED ✓" or (ctx.phase == "Final" and "EVENT OVER" or "NOTHING TO CLAIM");
    end;

    setText2(claimAll, v455);
    local v456;

    if v438 > 0 then
        v456 = not v454;
    else
        v456 = false;
    end;

    if ui.claimAllActive ~= v456 then
        ui.claimAllActive = v456;
        ui.claimAll.Active = v456;
        ui.claimAll.AutoButtonColor = v456;
        Skin.button(ui.claimAll, v456 and "primary" or "secondary");
    end;

    local v457, v458 = ticker(snapshot, p405, p404.compact);
    local v459 = v457 .. " · " .. v458;
    local v460 = race(snapshot, p404.compact);
    local v461;

    if p404.compact then
        v461 = ui.notice;
    else
        v461 = ui.updates;
    end;

    if v460 ~= "" then
        v459 = v460 .. "  ·  " .. v459;
    end;

    Widgets.setText(v461, v459);
    local v462;

    if u9.wiped then
        v462 = "Your event points are frozen.";
    elseif p404.compact and u15 == "Team" then
        v462 = TeamEventConfig.Note;
    else
        v462 = u8;
    end;

    ui.statusDefault = v462;
end;

local function paint(p463) -- Line: 1400
    -- upvalues: paintPick (copy), paintProgress (copy), Widgets (copy), Color3_fromRGB_ret7 (copy)
    local ServerTimeNow = workspace:GetServerTimeNow();

    if p463.mode == "pick" then
        paintPick(p463, ServerTimeNow);
    else
        paintProgress(p463, ServerTimeNow);
    end;

    local v464;

    if os.clock() < p463.statusUntil then
        v464 = p463.statusText;
    else
        v464 = false;
    end;

    Widgets.setText(p463.ui.status, v464 or (p463.ui.statusDefault or ""));
    local v465;

    if v464 then
        v465 = p463.statusColor;
    else
        v465 = Color3_fromRGB_ret7;
    end;

    p463.ui.status.TextColor3 = v465;
end;

local function setStatus(p466, p467) -- Line: 1411
    -- upvalues: u11 (ref), paint (copy)
    local v468 = u11;

    if v468 then
        local v469 = os.clock() + 8;
        v468.statusText = p466;
        v468.statusColor = p467;
        v468.statusUntil = v469;
        paint(v468);
    end;
end;

local function waitReply() -- Line: 1418
    -- upvalues: u12 (ref), Color3_fromRGB_ret9 (copy), u11 (ref), paint (copy)
    local os_clock_ret = os.clock();
    u12 = os_clock_ret;
    task.delay(15, function() -- Line: 1421
        -- upvalues: u12 (ref), os_clock_ret (copy), Color3_fromRGB_ret9 (ref), u11 (ref), paint (ref)
        if u12 == os_clock_ret then
            u12 = 0;
            local v470 = Color3_fromRGB_ret9;
            local v471 = u11;

            if v471 then
                local v472 = os.clock() + 8;
                v471.statusText = "Still waiting for confirmation. You can retry safely.";
                v471.statusColor = v470;
                v471.statusUntil = v472;
                paint(v471);
            end;
        end;
    end);
end;

local function pressJoin(p473) -- Line: 1429
    -- upvalues: u12 (ref), u9 (ref), TeamEventConfig (copy), LocalPlayer (copy), u19 (ref), u13 (ref), u14 (ref), Color3_fromRGB_ret9 (copy), u11 (ref), paint (copy), Telemetry (copy), TeamEventRemote (copy)
    local v474;

    if u12 > 0 then
        v474 = os.clock() - u12 < 15;
    else
        v474 = false;
    end;

    if v474 or not (u9 and (u9.joinsOpen == true and not TeamEventConfig.Team[u9.team])) then
        return;
    end;

    if LocalPlayer:GetAttribute("EventIntroUnseen") == true and (LocalPlayer:GetAttribute("EventIntroActive") ~= true and LocalPlayer:GetAttribute("InMatch") ~= true) then
        u19("Intro");
        LocalPlayer:SetAttribute("EventIntroRequested", os.clock());

        return;
    end;

    if u13 == p473 and os.clock() < u14 then
        u13 = nil;
        u14 = 0;
        local os_clock_ret = os.clock();
        u12 = os_clock_ret;
        task.delay(15, function() -- Line: 1421
            -- upvalues: u12 (ref), os_clock_ret (copy), Color3_fromRGB_ret9 (ref), u11 (ref), paint (ref)
            if u12 == os_clock_ret then
                u12 = 0;
                local v475 = Color3_fromRGB_ret9;
                local v476 = u11;

                if v476 then
                    local v477 = os.clock() + 8;
                    v476.statusText = "Still waiting for confirmation. You can retry safely.";
                    v476.statusColor = v475;
                    v476.statusUntil = v477;
                    paint(v476);
                end;
            end;
        end);
        Telemetry.track("team_pick", p473);
        TeamEventRemote:FireServer("Join", p473);
    else
        local v478 = os.clock() + 4;
        u13 = p473;
        u14 = v478;
        task.delay(4.05, function() -- Line: 1451
            -- upvalues: u11 (ref), paint (ref)
            if u11 then
                paint(u11);
            end;
        end);
    end;

    if u11 then
        paint(u11);
    end;
end;

u20 = function(p479, p480) -- Line: 1462
    -- upvalues: u12 (ref), u9 (ref), u16 (ref), Color3_fromRGB_ret9 (copy), u11 (ref), paint (copy), TeamEventRemote (copy)
    local v481;

    if u12 > 0 then
        v481 = os.clock() - u12 < 15;
    else
        v481 = false;
    end;

    if v481 or (not u9 or u9.claimsOpen ~= true) then
        return;
    end;

    u16 = p480.AbsolutePosition + p480.AbsoluteSize * 0.5;
    local os_clock_ret = os.clock();
    u12 = os_clock_ret;
    task.delay(15, function() -- Line: 1421
        -- upvalues: u12 (ref), os_clock_ret (copy), Color3_fromRGB_ret9 (ref), u11 (ref), paint (ref)
        if u12 == os_clock_ret then
            u12 = 0;
            local v482 = Color3_fromRGB_ret9;
            local v483 = u11;

            if v483 then
                local v484 = os.clock() + 8;
                v483.statusText = "Still waiting for confirmation. You can retry safely.";
                v483.statusColor = v482;
                v483.statusUntil = v484;
                paint(v483);
            end;
        end;
    end);
    TeamEventRemote:FireServer("Claim", p479);

    if u11 then
        paint(u11);
    end;
end;

local function buildPick(p485) -- Line: 1477
    -- upvalues: buildHeader (copy), Vector2_new_ret5 (copy), label (copy), Color3_fromRGB_ret10 (copy), Font_new_ret2 (copy), Color3_new_ret (copy), Font_new_ret3 (copy), Color3_new_ret2 (copy), Color3_fromRGB_ret11 (copy), TeamEventConfig (copy), Color3_fromRGB_ret (copy), Color3_fromRGB_ret3 (copy), ball (copy), Color3_fromRGB_ret7 (copy), JourneyConfig (copy), row (copy), Color3_fromRGB_ret8 (copy), button (copy), pressJoin (copy), versus (copy), TweenInfo_new_ret4 (copy), TweenService (copy), u4 (copy), Widgets (copy), u19 (ref)
    local ui = p485.ui;
    local compact = p485.compact;
    local X = p485.size.X;
    local v486, v487, v488 = buildHeader(p485, compact);
    local v489 = {
        Name = "Heading",
        BackgroundTransparency = 1,
        AnchorPoint = Vector2_new_ret5,
        Position = UDim2.new(0.5, v488, 0.5, 0),
        Size = UDim2.new(0, compact and 300 or 440, 1, 0)
    };
    local Frame = Instance.new("Frame");
    local v490 = compact and 8 or 12;

    for i, v in v489 do
        Frame[i] = v;
    end;

    Frame.Parent = v486;
    label(Frame, "FOOTBALL vs FÚTBOL · TEAM EVENT", compact and 10 or 12, Color3_fromRGB_ret10, {
        Name = "Event",
        AutoLocalize = false,
        Size = UDim2.new(1, 0, 0, compact and 13 or 16),
        TextXAlignment = Enum.TextXAlignment.Center,
        FontFace = Font_new_ret2
    });
    local v491 = label(Frame, "PICK A SIDE", compact and 25 or 34, Color3_new_ret, {
        Name = "PickASide",
        Position = UDim2.fromOffset(0, compact and 12 or 15),
        Size = UDim2.new(1, 0, 1, compact and -12 or -15),
        TextXAlignment = Enum.TextXAlignment.Center,
        FontFace = Font_new_ret3
    });
    local v492 = {
        Thickness = 2.5,
        Color = Color3_new_ret2,
        LineJoinMode = Enum.LineJoinMode.Round
    };
    local UIStroke = Instance.new("UIStroke");

    for i, v in v492 do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = v491;
    local Color3_fromRGB_ret13 = Color3.fromRGB(255, 248, 200);
    local v493 = {
        Rotation = 90,
        Color = ColorSequence.new(Color3_fromRGB_ret13, Color3_fromRGB_ret11)
    };
    local UIGradient = Instance.new("UIGradient");

    for i, v in v493 do
        UIGradient[i] = v;
    end;

    UIGradient.Parent = v491;
    ui.cards = {};
    local v494 = v487 + (compact and 8 or 12);
    local v495 = (X - v490 * 2 - (compact and 92 or 100)) / 2;
    local v496 = compact and 252 or 354;
    local v497 = compact and 98 or 160;
    local v498 = compact and 6 or 14;
    local v499 = compact and 46 or 52;

    for i, v in TeamEventConfig.Teams do
        local v500 = TeamEventConfig.Team[v];
        local v501 = i == 1;
        local panel = p485.panel;
        local v502 = {
            ClipsDescendants = true,
            Name = v
        };
        local v503;

        if v501 then
            v503 = v490;
        else
            v503 = X - v490 - v495;
        end;

        v502.Position = UDim2.fromOffset(v503, v494);
        v502.Size = UDim2.fromOffset(v495, v496);
        v502.BackgroundColor3 = Color3_new_ret;
        local Frame2 = Instance.new("Frame");
        local u504 = v;

        for i2, v2 in v502 do
            Frame2[i2] = v2;
        end;

        Frame2.Parent = panel;
        local v505 = {
            CornerRadius = UDim.new(0, 16)
        };
        local UICorner = Instance.new("UICorner");

        for i2, v2 in v505 do
            UICorner[i2] = v2;
        end;

        UICorner.Parent = Frame2;
        local v506 = v500.Color:Lerp(Color3_fromRGB_ret, 0.3);
        local v507 = {
            Rotation = 90,
            Color = ColorSequence.new(v506, Color3_fromRGB_ret3)
        };
        local UIGradient2 = Instance.new("UIGradient");

        for i2, v2 in v507 do
            UIGradient2[i2] = v2;
        end;

        UIGradient2.Parent = Frame2;
        local v508 = {
            Thickness = 3,
            ZIndex = 1,
            Color = Color3_new_ret2,
            ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        };
        local UIStroke2 = Instance.new("UIStroke");

        for i2, v2 in v508 do
            UIStroke2[i2] = v2;
        end;

        UIStroke2.Parent = Frame2;
        local v509 = {
            Thickness = 2,
            ZIndex = 2,
            Color = v500.Color:Lerp(Color3_new_ret, 0.3),
            ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        };
        local UIStroke3 = Instance.new("UIStroke");

        for i2, v2 in v509 do
            UIStroke3[i2] = v2;
        end;

        UIStroke3.Parent = Frame2;
        local v510 = {
            Name = "Lights",
            ImageTransparency = 0.82,
            AnchorPoint = Vector2_new_ret5,
            Position = UDim2.fromOffset(v495 / 2, v498 + v497 / 2),
            Size = UDim2.fromOffset(v497 * 2.6, v497 * 2.6),
            ImageColor3 = v500.Color:Lerp(Color3_new_ret, 0.5)
        };
        local v511 = {
            BackgroundTransparency = 1,
            Image = "rbxassetid://129028976496842",
            ScaleType = Enum.ScaleType.Fit
        };
        local ImageLabel = Instance.new("ImageLabel");

        for i2, v2 in v511 do
            ImageLabel[i2] = v2;
        end;

        ImageLabel.Parent = Frame2;

        for i2, v2 in v510 do
            ImageLabel[i2] = v2;
        end;

        local v512 = {
            Name = "Ball",
            BackgroundTransparency = 1,
            AnchorPoint = Vector2_new_ret5,
            Position = UDim2.fromOffset(v495 / 2, v498 + v497 / 2),
            Size = UDim2.fromOffset(v497, v497)
        };
        local Frame3 = Instance.new("Frame");
        local v513 = p485;

        for i2, v2 in v512 do
            Frame3[i2] = v2;
        end;

        Frame3.Parent = Frame2;
        ball(p485, Frame3, u504, v497);
        local v514 = v498 + v497 + (compact and 2 or 6);
        local v515 = label(Frame2, v500.Label, compact and 22 or 28, Color3_new_ret, {
            Name = "TeamName",
            AutoLocalize = false,
            Position = UDim2.fromOffset(8, v514),
            Size = UDim2.new(1, -16, 0, compact and 24 or 32),
            TextXAlignment = Enum.TextXAlignment.Center,
            FontFace = Font_new_ret3
        });
        local v516 = {
            Thickness = 2.5,
            Color = v500.Color:Lerp(Color3_new_ret2, 0.5),
            LineJoinMode = Enum.LineJoinMode.Round
        };
        local UIStroke4 = Instance.new("UIStroke");

        for i2, v2 in v516 do
            UIStroke4[i2] = v2;
        end;

        UIStroke4.Parent = v515;
        local v517 = v514 + (compact and 23 or 32);
        label(Frame2, v500.Subtitle, compact and 12 or 14, Color3_fromRGB_ret7, {
            Name = "Subtitle",
            Position = UDim2.fromOffset(8, v517),
            Size = UDim2.new(1, -16, 0, compact and 15 or 18),
            TextXAlignment = Enum.TextXAlignment.Center
        });
        local v518 = v517 + (compact and 17 or 23);
        local v519 = JourneyConfig.Badges[v500.Title];
        local v520;

        if v519 then
            local Color = v519.Color;
            v520 = v500.Color;

            if typeof(Color) == "Color3" then
                v520 = Color;
            end;
        else
            v520 = v500.Color;
        end;

        local v521 = row(Frame2, {
            Name = "Title",
            Position = UDim2.fromOffset(8, v518),
            Size = UDim2.new(1, -16, 0, compact and 22 or 28)
        }, Enum.HorizontalAlignment.Center, 6);
        label(v521, "TITLE", 11, Color3_fromRGB_ret8, {
            Name = "Caption",
            LayoutOrder = 1,
            Size = UDim2.new(0, 0, 1, 0),
            AutomaticSize = Enum.AutomaticSize.X,
            FontFace = Font_new_ret2
        });
        local v522 = {
            Name = "Badge",
            LayoutOrder = 2,
            BackgroundTransparency = 0.3,
            Size = UDim2.new(0, 0, 1, 0),
            AutomaticSize = Enum.AutomaticSize.X,
            BackgroundColor3 = Color3_new_ret2
        };
        local Frame4 = Instance.new("Frame");

        for i2, v2 in v522 do
            Frame4[i2] = v2;
        end;

        Frame4.Parent = v521;
        local v523 = {
            CornerRadius = UDim.new(0, 8)
        };
        local UICorner2 = Instance.new("UICorner");

        for i2, v2 in v523 do
            UICorner2[i2] = v2;
        end;

        UICorner2.Parent = Frame4;
        local v524 = {
            Thickness = 2,
            ZIndex = 1,
            Color = v520,
            ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        };
        local UIStroke5 = Instance.new("UIStroke");

        for i2, v2 in v524 do
            UIStroke5[i2] = v2;
        end;

        UIStroke5.Parent = Frame4;
        local v525 = {
            PaddingLeft = UDim.new(0, 10),
            PaddingRight = UDim.new(0, 10)
        };
        local UIPadding = Instance.new("UIPadding");

        for i2, v2 in v525 do
            UIPadding[i2] = v2;
        end;

        UIPadding.Parent = Frame4;
        local v526;

        if v519 then
            v526 = v519.Name;
        else
            v526 = v500.Label;
        end;

        local v527 = label(Frame4, v526, compact and 13 or 15, v520:Lerp(Color3_new_ret, 0.5), {
            Name = "Text",
            AutoLocalize = false,
            Size = UDim2.new(0, 0, 1, 0),
            AutomaticSize = Enum.AutomaticSize.X,
            FontFace = Font_new_ret3
        });
        local v528 = {
            Thickness = 1.5,
            Color = Color3_new_ret2,
            LineJoinMode = Enum.LineJoinMode.Round
        };
        local UIStroke6 = Instance.new("UIStroke");

        for i2, v2 in v528 do
            UIStroke6[i2] = v2;
        end;

        UIStroke6.Parent = v527;
        local v529 = {
            stats = label(Frame2, "", compact and 13 or 15, Color3_new_ret, {
                Name = "Players",
                AutoLocalize = false,
                Position = UDim2.fromOffset(8, v518 + (compact and 26 or 34)),
                Size = UDim2.new(1, -16, 0, compact and 16 or 19),
                TextXAlignment = Enum.TextXAlignment.Center
            })
        };
        local v530 = {
            Name = "Winner",
            Visible = false,
            ZIndex = 5,
            AnchorPoint = Vector2.new(v501 and 0 or 1, 0),
            Position = UDim2.new(v501 and 0 or 1, v501 and 10 or -10, 0, 8),
            Size = UDim2.fromOffset(110, 20)
        };
        local v531;

        if v501 then
            v531 = Enum.TextXAlignment.Left;
        else
            v531 = Enum.TextXAlignment.Right;
        end;

        v530.TextXAlignment = v531;
        v530.FontFace = Font_new_ret2;
        v529.winner = label(Frame2, "👑 WINNER", compact and 12 or 15, Color3_fromRGB_ret10, v530);
        v529.join = button(Frame2, "Join", UDim2.new(0.5, 0, 1, -(v499 / 2 + (compact and 7 or 12))), UDim2.new(1, -24, 0, v499), compact and 17 or 21);
        v529.beatKey = "armed:" .. u504;
        v529.join.button.AnchorPoint = Vector2_new_ret5;
        v529.join.text.AutoLocalize = false;
        local button2 = v529.join.button;
        local UIScale = Instance.new("UIScale");

        for i2, v2 in {} do
            UIScale[i2] = v2;
        end;

        UIScale.Parent = button2;
        v529.scale = UIScale;
        table.insert(v513.content, v529.join.button.Activated:Connect(function() -- Line: 1624
            -- upvalues: pressJoin (ref), u504 (copy)
            pressJoin(u504);
        end));
        ui.cards[u504] = v529;
        p485 = v513;
    end;

    local v532 = compact and 64 or 86;
    local panel = p485.panel;
    local v533 = {
        Name = "FaceOff",
        BackgroundTransparency = 1,
        ZIndex = 3,
        AnchorPoint = Vector2_new_ret5,
        Position = UDim2.fromOffset(X / 2, v494 + v498 + v497 / 2),
        Size = UDim2.fromOffset(v532, v532)
    };
    local Frame2 = Instance.new("Frame");
    local v534 = compact and 42 or 58;

    for i, v in v533 do
        Frame2[i] = v;
    end;

    Frame2.Parent = panel;
    versus(p485, Frame2, v532, "pick");

    for i, v in TeamEventConfig.Teams do
        local v535 = i == 1;
        local v536 = {
            BackgroundTransparency = 1,
            ZIndex = 3,
            Name = v .. "Ball",
            AnchorPoint = Vector2_new_ret5,
            Position = UDim2.new(0.5, (v535 and -1 or 1) * (v532 * 0.5 + v534 * 0.22), 0.5, 0),
            Size = UDim2.fromOffset(v534, v534)
        };
        local Frame3 = Instance.new("Frame");
        local v537 = v;

        for i2, v2 in v536 do
            Frame3[i2] = v2;
        end;

        Frame3.Parent = Frame2;
        local v538 = {
            Name = "Rider",
            BackgroundTransparency = 1,
            AnchorPoint = Vector2_new_ret5,
            Position = UDim2.fromScale(0.5, 0.5),
            Size = UDim2.fromScale(1, 1)
        };
        local Frame4 = Instance.new("Frame");

        for i2, v2 in v538 do
            Frame4[i2] = v2;
        end;

        Frame4.Parent = Frame3;
        ball(p485, Frame4, v537, v534);
        local v539 = "pick:" .. v537;
        local v540 = {
            Position = UDim2.new(0.5, v535 and 6 or -6, 0.5, 0)
        };
        local v541 = p485.tweens[v539];

        if v541 then
            v541:Cancel();
        end;

        local v542 = TweenService:Create(Frame4, TweenInfo_new_ret4, v540);
        p485.tweens[v539] = v542;
        v542:Play();
    end;

    local v543 = v494 + v496 + (compact and 3 or 8);
    label(p485.panel, TeamEventConfig.Note, compact and 11 or 13, Color3_fromRGB_ret8, {
        Name = "Note",
        TextWrapped = true,
        Position = UDim2.fromOffset(v490, v543),
        Size = UDim2.new(1, v490 * -2, 0, compact and 14 or 18),
        TextXAlignment = Enum.TextXAlignment.Center
    });
    local v544 = v543 + (compact and 15 or 24);
    local v545 = compact and 38 or 44;
    local v546 = compact and 150 or 170;
    ui.status = label(p485.panel, "", compact and 12 or 14, Color3_fromRGB_ret7, {
        Name = "Status",
        TextWrapped = true,
        Position = UDim2.fromOffset(v490 + 4, v544),
        Size = UDim2.new(1, v490 * -2 - v546 - 16, 0, v545)
    });
    ui.statusDefault = "Your team is locked for the event.";

    if p485.once then
        local v547 = button(p485.panel, "NotNow", UDim2.new(1, -v490 - v546, 0, v544), UDim2.fromOffset(v546, v545), compact and 15 or 18);
        local v548 = u4;

        if v547.look ~= v548 then
            v547.look = v548;
            v547.fill.Color = v548.fill;
            v547.edge.Color = v548.edge;
            v547.text.TextColor3 = v548.text;
        end;

        Widgets.setText(v547.text, "NOT NOW");

        if v547.button.Interactable ~= true then
            v547.button.Interactable = true;
            v547.button.AutoButtonColor = true;
        end;

        table.insert(p485.content, v547.button.Activated:Connect(function() -- Line: 1688
            -- upvalues: u19 (ref)
            u19("NotNow");
        end));
    end;
end;

local function showBoardRewards(p549) -- Line: 1700
    -- upvalues: u9 (ref), TeamEventConfig (copy), JourneyConfig (copy), Color3_new_ret2 (copy), Vector2_new_ret5 (copy), Palette (copy), Skin (copy), jlabel (copy), Widgets (copy), Color3_new_ret (copy), Color3_fromRGB_ret7 (copy)
    local panel = p549.panel;

    if not panel or panel:FindFirstChild("BoardRewardsFrame") then
        return;
    end;

    local u550 = u9 and u9.team;

    local function titleOf(p551) -- Line: 1707
        -- upvalues: TeamEventConfig (ref), u550 (copy), JourneyConfig (ref)
        local v552 = TeamEventConfig.Team[u550] and TeamEventConfig.placementReward(p551, u550);
        local v553 = v552 and v552.Titles and v552.Titles[1];

        if v553 then
            v553 = JourneyConfig.Badges[v553];
        end;

        return not v553 and "LEGEND" or v553.Name;
    end;

    local compact = p549.compact;
    local v554 = {
        Name = "BoardRewardsFrame",
        BackgroundTransparency = 0.35,
        Text = "",
        AutoButtonColor = false,
        ZIndex = 20,
        Size = UDim2.fromScale(1, 1),
        BackgroundColor3 = Color3_new_ret2
    };
    local TextButton = Instance.new("TextButton");

    for i, v in v554 do
        TextButton[i] = v;
    end;

    TextButton.Parent = panel;
    local u555 = compact and 380 or 460;
    local v556 = compact and 300 or 340;
    local v557 = {
        Name = "Box",
        Active = true,
        ZIndex = 21,
        AnchorPoint = Vector2_new_ret5,
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromOffset(u555, v556),
        BackgroundColor3 = Palette.surface
    };
    local Frame = Instance.new("Frame");

    for i, v in v557 do
        Frame[i] = v;
    end;

    Frame.Parent = TextButton;
    Skin.Theme.surface(Frame, Palette.surface, Palette.gold, 10, 0.62);
    Skin.panel(Frame, {
        radius = UDim.new(0, 14)
    });

    local function line(p558, p559, p560, p561, p562, p563) -- Line: 1735
        -- upvalues: jlabel (ref), Frame (copy), u555 (copy)
        return jlabel(Frame, p558, p559, p561, p562, p563, {
            ZIndex = 22,
            AutoLocalize = false,
            Position = UDim2.fromOffset(18, p560),
            Size = UDim2.fromOffset(u555 - 36, p561 + 8)
        });
    end;

    line("Heading", "LEADERBOARD REWARDS", 14, compact and 18 or 20, Palette.gold, true);
    line("Sub", "Your rank on your team\'s board when the event ends.", compact and 40 or 44, compact and 11 or 12, Palette.textSecondary, false);
    local v564 = {};

    for _, v in TeamEventConfig.Placement do
        local v565 = {};
        local v566 = v.Rank == 1 and "#1" or "TOP " .. Widgets.number(v.Rank);
        local v567 = Widgets.number(v.Gems);
        local v568 = TeamEventConfig.Team[u550] and TeamEventConfig.placementReward(v.Rank, u550);
        local v569 = v568 and v568.Titles and v568.Titles[1];

        if v569 then
            v569 = JourneyConfig.Badges[v569];
        end;

        v565[1], v565[2] = v566, v567 .. " gems + " .. (not v569 and "LEGEND" or v569.Name) .. " title";
        table.insert(v564, v565);
    end;

    local v570 = {};
    local v571 = "TOP " .. Widgets.number(TeamEventConfig.LegendRank);
    local v572 = TeamEventConfig.Team[u550] and TeamEventConfig.placementReward(TeamEventConfig.LegendRank, u550);
    local v573 = v572 and v572.Titles and v572.Titles[1];

    if v573 then
        v573 = JourneyConfig.Badges[v573];
    end;

    v570[1], v570[2] = v571, (not v573 and "LEGEND" or v573.Name) .. " title";
    table.insert(v564, v570);
    local v574 = compact and 70 or 78;
    local v575 = compact and 40 or 46;

    for i, v in v564 do
        local v576 = {
            BackgroundTransparency = 0.15,
            BorderSizePixel = 0,
            ZIndex = 22,
            Name = "Tier" .. i,
            Position = UDim2.fromOffset(18, v574),
            Size = UDim2.fromOffset(u555 - 36, v575 - 6),
            BackgroundColor3 = Color3.fromRGB(26, 30, 46)
        };
        local Frame2 = Instance.new("Frame");
        local v577 = v;

        for i2, v2 in v576 do
            Frame2[i2] = v2;
        end;

        Frame2.Parent = Frame;
        local v578 = {
            CornerRadius = UDim.new(0, 8)
        };
        local UICorner = Instance.new("UICorner");

        for i2, v2 in v578 do
            UICorner[i2] = v2;
        end;

        UICorner.Parent = Frame2;
        jlabel(Frame2, "Rank", v577[1], compact and 14 or 16, Palette.gold, true, {
            ZIndex = 23,
            AutoLocalize = false,
            Position = UDim2.fromOffset(12, 0),
            Size = UDim2.fromOffset(100, v575 - 6)
        });
        jlabel(Frame2, "Reward", v577[2], compact and 11 or 13, Color3_new_ret, true, {
            ZIndex = 23,
            AutoLocalize = false,
            Position = UDim2.fromOffset(110, 0),
            Size = UDim2.fromOffset(u555 - 36 - 122, v575 - 6),
            TextXAlignment = Enum.TextXAlignment.Right
        });
        v574 = v574 + v575;
    end;

    line("Foot", "Only the best tier you reach pays. Paid once the results are final.", v556 - 30, compact and 10 or 11, Color3_fromRGB_ret7, false);
    local v579 = Skin.Panels.button(Frame, "Close", "×", u555 - 46, 10, 36, 36);
    v579.TextSize = 24;
    v579.ZIndex = 23;
    Skin.button(v579, "close");

    local function shut() -- Line: 1786
        -- upvalues: TextButton (copy)
        TextButton:Destroy();
    end;

    table.insert(p549.content, v579.Activated:Connect(shut));
    table.insert(p549.content, TextButton.Activated:Connect(shut));
end;

local function buildProgress(u580) -- Line: 1793
    -- upvalues: TeamEventConfig (copy), u9 (ref), jlabel (copy), Palette (copy), Color3_new_ret (copy), Skin (copy), u19 (ref), u15 (ref), Color3_fromRGB_ret7 (copy), u18 (ref), Vector2_new_ret5 (copy), bar (copy), u1 (copy), buildCard (copy), u20 (ref), showBoardRewards (ref)
    local ui = u580.ui;
    local compact = u580.compact;
    local panel = u580.panel;
    local X = u580.size.X;
    local Y = u580.size.Y;
    local v581 = TeamEventConfig.Team[u9.team];
    local v582;

    if TeamEventConfig.Teams[1] == u9.team then
        v582 = TeamEventConfig.Teams[2];
    else
        v582 = TeamEventConfig.Teams[1];
    end;

    local v583 = TeamEventConfig.Team[v582];
    local u584 = compact and 14 or 22;
    local u585 = X - u584 * 2;
    local v586 = compact and 36 or 40;
    local v587 = compact and 140 or 190;
    local v588 = u585 - v586 - v587 - 16;
    jlabel(panel, "Edition", "FOOTBALL vs FÚTBOL  /  TEAM EVENT", compact and 10 or 12, Palette.gold, true, {
        AutoLocalize = false,
        Position = UDim2.fromOffset(u584, compact and 8 or 12),
        Size = UDim2.fromOffset(v588, 18)
    });
    jlabel(panel, "Heading", v581.Label .. " " .. v581.Icon, compact and 22 or 28, v581.Color:Lerp(Color3_new_ret, 0.35), true, {
        AutoLocalize = false,
        Position = UDim2.fromOffset(u584, compact and 22 or 31),
        Size = UDim2.fromOffset(v588, compact and 26 or 33)
    });
    local v589 = Skin.Panels.button(panel, "Close", "×", X - u584 - v586, compact and 8 or 12, v586, v586);
    v589.TextSize = 24;
    Skin.button(v589, "close");
    table.insert(u580.content, v589.Activated:Connect(function() -- Line: 1819
        -- upvalues: u19 (ref)
        u19("Button");
    end));
    ui.ends = jlabel(panel, "EndsTimer", "", compact and 10 or 12, Palette.gold, true, {
        Position = UDim2.fromOffset(X - u584 - v586 - 8 - v587, compact and 16 or 22),
        Size = UDim2.fromOffset(v587, 20),
        TextXAlignment = Enum.TextXAlignment.Right
    });
    local v590 = compact and 28 or 32;
    local v591 = compact and 48 or 66;
    local Color = v581.Color;
    local v592 = {
        Name = "TabLine",
        BorderSizePixel = 0,
        Position = UDim2.fromOffset(u584, v591 + v590),
        Size = UDim2.fromOffset(u585, 2),
        BackgroundColor3 = Color
    };
    local Frame = Instance.new("Frame");
    local v593 = compact and 112 or 140;

    for i, v in v592 do
        Frame[i] = v;
    end;

    Frame.Parent = panel;

    for i, v in { "Team", "Personal" } do
        local v594 = u15 == v;
        local v595 = u584 + (i - 1) * (v593 + 6);
        local v596 = {
            BackgroundTransparency = 1,
            ClipsDescendants = true,
            Name = v .. "Tab",
            Position = UDim2.fromOffset(v595 - 2, v591 - 2),
            Size = UDim2.fromOffset(v593 + 4, v590 + 2)
        };
        local Frame2 = Instance.new("Frame");
        local u597 = v;

        for i2, v2 in v596 do
            Frame2[i2] = v2;
        end;

        Frame2.Parent = panel;
        local v598 = {
            Name = "Button",
            BorderSizePixel = 0,
            Text = "",
            Position = UDim2.fromOffset(2, 2),
            Size = UDim2.fromOffset(v593, v590 + 12)
        };
        local v599;

        if v594 then
            v599 = Color;
        else
            v599 = Color3.fromRGB(26, 30, 46);
        end;

        v598.BackgroundColor3 = v599;
        v598.AutoButtonColor = not v594;
        v598.Selectable = not v594;
        local TextButton = Instance.new("TextButton");

        for i2, v2 in v598 do
            TextButton[i2] = v2;
        end;

        TextButton.Parent = Frame2;
        local v600 = {
            CornerRadius = UDim.new(0, 8)
        };
        local UICorner = Instance.new("UICorner");

        for i2, v2 in v600 do
            UICorner[i2] = v2;
        end;

        UICorner.Parent = TextButton;
        local v601 = {
            Thickness = 1.5
        };
        local v602;

        if v594 then
            v602 = Color:Lerp(Color3_new_ret, 0.45);
        else
            v602 = Color3.fromRGB(70, 78, 102);
        end;

        v601.Color = v602;
        v601.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
        local UIStroke = Instance.new("UIStroke");

        for i2, v2 in v601 do
            UIStroke[i2] = v2;
        end;

        UIStroke.Parent = TextButton;
        local string_upper_ret = string.upper(u597);
        local v603;

        if v594 then
            v603 = Color3_new_ret;
        else
            v603 = Color3_fromRGB_ret7;
        end;

        jlabel(TextButton, "Label", string_upper_ret, compact and 13 or 15, v603, true, {
            AutoLocalize = false,
            Size = UDim2.fromOffset(v593, v590),
            TextXAlignment = Enum.TextXAlignment.Center,
            TextTransparency = v594 and 0 or 0.2,
            Font = Enum.Font.GothamBlack
        });

        if not v594 then
            table.insert(u580.content, TextButton.Activated:Connect(function() -- Line: 1874
                -- upvalues: u15 (ref), u597 (copy), u18 (ref), u580 (copy)
                u15 = u597;
                u18(u580);
            end));
            local v604 = {
                Name = "Ready",
                Text = "",
                TextSize = 12,
                Visible = false,
                ZIndex = 3,
                AutoLocalize = false,
                AnchorPoint = Vector2_new_ret5,
                Position = UDim2.fromOffset(v595 + v593 - 4, v591 + 2),
                Size = UDim2.fromOffset(20, 20),
                Font = Enum.Font.GothamBold
            };
            local TextLabel = Instance.new("TextLabel");

            for i2, v2 in v604 do
                TextLabel[i2] = v2;
            end;

            TextLabel.Parent = panel;
            ui.laneBadge = TextLabel;
            Skin.badge(ui.laneBadge);
        end;
    end;

    local u605 = compact and 104 or 136;
    local v606 = compact and 170 or 240;

    local function progressRow(p607, p608, p609, p610, p611) -- Line: 1898
        -- upvalues: jlabel (ref), panel (copy), compact (copy), u584 (copy), u605 (copy), Palette (ref), bar (ref), u585 (copy)
        return jlabel(panel, p607, "", compact and 12 or 14, p609, true, {
            Position = UDim2.fromOffset(u584, p608),
            Size = UDim2.fromOffset(u605, 20)
        }), jlabel(panel, p607 .. "Info", "", compact and 10 or 12, Palette.textSecondary, false, {
            AutoLocalize = false,
            Position = UDim2.fromOffset(u584 + u605 + 6, p608),
            Size = UDim2.fromOffset(p611, 20)
        }), bar(panel, p607 .. "Bar", u584, p608 + (compact and 20 or 24), u585, p610);
    end;

    local v612 = v591 + v590 + (compact and 8 or 12);

    if u15 == "Team" then
        local v613, v614, v615 = progressRow("TeamLevel", v612, v581.Color:Lerp(Color3_new_ret, 0.35), v581.Color, u585 - u605 - v606 - 12);
        ui.teamLevel = v613;
        ui.teamInfo = v614;
        ui.teamFill = v615;
        ui.rival = jlabel(panel, "Rival", "", compact and 10 or 12, v583.Color:Lerp(Color3_new_ret, 0.35), true, {
            AutoLocalize = false,
            Position = UDim2.fromOffset(u584 + u585 - v606, v612),
            Size = UDim2.fromOffset(v606, 20),
            TextXAlignment = Enum.TextXAlignment.Right
        });
    else
        local v616, v617, v618 = progressRow("YourLevel", v612, Palette.gold, "xp", u585 - u605 - 6);
        ui.youLevel = v616;
        ui.youInfo = v617;
        ui.youFill = v618;
    end;

    local v619 = v612 + (compact and 34 or 36);
    local v620 = Y - (compact and 62 or 93);
    local v621 = v620 - 8 - v619;
    local v622 = compact and 200 or math.floor((u585 - (u1 - 1) * 12) / u1);
    local v623 = compact and 0 or 22;
    local v624 = v621 - v623 - (compact and 8 or 6);
    local v625 = {
        Name = "Track",
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 4,
        Selectable = false,
        Position = UDim2.fromOffset(u584, v619),
        Size = UDim2.fromOffset(u585, v621),
        CanvasSize = UDim2.fromOffset(u1 * (v622 + 12) - 12, 0),
        ScrollingDirection = Enum.ScrollingDirection.X
    };
    local ScrollingFrame = Instance.new("ScrollingFrame");

    for i, v in v625 do
        ScrollingFrame[i] = v;
    end;

    ScrollingFrame.Parent = panel;
    Skin.scroll(ScrollingFrame);
    ui.scroll = ScrollingFrame;
    ui.columnWidth = v622 + 12;
    ui.canvasWidth = u1 * (v622 + 12) - 12;
    ui.rows = {
        Team = {},
        Personal = {}
    };

    for i = 1, u1 do
        local v626 = {
            BackgroundTransparency = 1,
            Name = "Level" .. i,
            Position = UDim2.fromOffset((i - 1) * (v622 + 12), 0),
            Size = UDim2.fromOffset(v622, v621 - 6)
        };
        local Frame2 = Instance.new("Frame");
        local v627 = i;

        for i2, v in v626 do
            Frame2[i2] = v;
        end;

        Frame2.Parent = ScrollingFrame;

        if not compact then
            jlabel(Frame2, "Level", "LEVEL " .. v627, 12, Palette.gold, true, {
                Size = UDim2.fromOffset(v622, 18)
            });
        end;

        ui.rows[u15][v627] = buildCard(u580, Frame2, u15, v627, v622, v624, v623, compact);
    end;

    local v628 = compact and 34 or 38;
    local math_floor_ret = math.floor((u585 - 20) / 3);
    ui.claimAll = Skin.Panels.button(panel, "ClaimAll", "", u584, v620, math_floor_ret, v628);
    ui.claimAll.TextSize = compact and 12 or 14;
    table.insert(u580.content, ui.claimAll.Activated:Connect(function() -- Line: 1962
        -- upvalues: ui (copy), u20 (ref)
        if ui.claimAll.Active then
            u20("All", ui.claimAll);
        end;
    end));
    local v629 = Skin.Panels.button(panel, "BoardRewards", "LEADERBOARD REWARDS", u584 + u585 - math_floor_ret, v620, math_floor_ret, v628);
    v629.TextSize = compact and 11 or 13;
    Skin.button(v629, "secondary");
    table.insert(u580.content, v629.Activated:Connect(function() -- Line: 1971
        -- upvalues: showBoardRewards (ref), u580 (copy)
        showBoardRewards(u580);
    end));
    ui.status = jlabel(panel, "Status", "", compact and 11 or 12, Color3_fromRGB_ret7, false, {
        TextWrapped = true,
        Position = UDim2.fromOffset(u584 + math_floor_ret + 12, v620),
        Size = UDim2.fromOffset(u585 - math_floor_ret * 2 - 24, v628),
        TextTruncate = Enum.TextTruncate.None
    });
    ui.notice = jlabel(panel, "Notice", compact and "" or TeamEventConfig.Note, compact and 10 or 11, Palette.textSecondary, false, {
        Position = UDim2.fromOffset(u584, v620 + v628 + 5),
        Size = UDim2.fromOffset(u585, 16),
        AutoLocalize = compact ~= true
    });

    if not compact then
        ui.updates = jlabel(panel, "Updates", "", 11, Palette.textSecondary, false, {
            AutoLocalize = false,
            Position = UDim2.fromOffset(u584, Y - 25),
            Size = UDim2.fromOffset(u585, 18)
        });
    end;
end;

local function clear(p630) -- Line: 1995
    for _, v in p630.tweens do
        v:Cancel();
    end;

    table.clear(p630.tweens);

    for _, v in p630.previews do
        pcall(v.destroy, v);
    end;

    table.clear(p630.previews);

    for _, v in p630.content do
        v:Disconnect();
    end;

    table.clear(p630.content);
end;

u18 = function(p631) -- Line: 2012
    -- upvalues: clear (copy), TeamEventConfig (copy), u9 (ref), Vector2_new_ret3 (copy), Vector2_new_ret (copy), Vector2_new_ret4 (copy), Vector2_new_ret2 (copy), Vector2_new_ret5 (copy), Color3_new_ret (copy), Palette (copy), Skin (copy), Color3_fromRGB_ret2 (copy), Color3_fromRGB_ret3 (copy), Color3_new_ret2 (copy), ColorSequence_new_ret (copy), buildProgress (copy), buildPick (copy), paint (copy)
    clear(p631);

    if p631.panel then
        p631.panel:Destroy();
    end;

    local v632 = TeamEventConfig.Team[u9.team];
    local v633;

    if v632 then
        v633 = Vector2_new_ret3;
    else
        v633 = Vector2_new_ret;
    end;

    p631.mode = v632 and "progress" or "pick";
    local AbsoluteSize = p631.gui.AbsoluteSize;

    if AbsoluteSize.X <= 0 or AbsoluteSize.Y <= 0 then
        local workspace_CurrentCamera = workspace.CurrentCamera;

        if workspace_CurrentCamera then
            AbsoluteSize = workspace_CurrentCamera.ViewportSize;
        else
            AbsoluteSize = Vector2.new(1280, 720);
        end;
    end;

    p631.compact = math.min(AbsoluteSize.X * 0.96 / v633.X, AbsoluteSize.Y * 0.94 / v633.Y, 1.2) < 0.85;

    if p631.compact then
        if v632 then
            v633 = Vector2_new_ret4;
        else
            v633 = Vector2_new_ret2;
        end;
    end;

    p631.size = v633;
    p631.ui = {};
    local gui = p631.gui;
    local v634 = {
        Name = "Panel",
        ClipsDescendants = true,
        Active = true,
        AnchorPoint = Vector2_new_ret5,
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromOffset(p631.size.X, p631.size.Y),
        BackgroundColor3 = Color3_new_ret
    };
    local Frame = Instance.new("Frame");

    for i, v in v634 do
        Frame[i] = v;
    end;

    Frame.Parent = gui;
    p631.panel = Frame;

    if v632 then
        p631.panel.BackgroundColor3 = Palette.surface;
        p631.panel.BackgroundTransparency = 0.08;
        Skin.Theme.surface(p631.panel, Palette.surface, Palette.gold, 10, 0.62);
        Skin.panel(p631.panel, {
            radius = UDim.new(0, 15)
        });
    else
        local panel = p631.panel;
        local v635 = {
            CornerRadius = UDim.new(0, 16)
        };
        local UICorner = Instance.new("UICorner");

        for i, v in v635 do
            UICorner[i] = v;
        end;

        UICorner.Parent = panel;
        local panel2 = p631.panel;
        local v636 = {
            Rotation = 90,
            Color = ColorSequence.new(Color3_fromRGB_ret2, Color3_fromRGB_ret3)
        };
        local UIGradient = Instance.new("UIGradient");

        for i, v in v636 do
            UIGradient[i] = v;
        end;

        UIGradient.Parent = panel2;
        local panel3 = p631.panel;
        local v637 = {
            Thickness = 4,
            ZIndex = 1,
            Color = Color3_new_ret2,
            ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        };
        local UIStroke = Instance.new("UIStroke");

        for i, v in v637 do
            UIStroke[i] = v;
        end;

        UIStroke.Parent = panel3;
        local panel4 = p631.panel;
        local v638 = {
            Thickness = 2.5,
            ZIndex = 2,
            Color = Color3_new_ret,
            ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        };
        local UIStroke2 = Instance.new("UIStroke");

        for i, v in v638 do
            UIStroke2[i] = v;
        end;

        UIStroke2.Parent = panel4;
        local v639 = {
            Color = ColorSequence_new_ret
        };
        local UIGradient2 = Instance.new("UIGradient");

        for i, v in v639 do
            UIGradient2[i] = v;
        end;

        UIGradient2.Parent = UIStroke2;

        for i, v in TeamEventConfig.Teams do
            local panel5 = p631.panel;
            local v640 = {
                ImageTransparency = 0.72,
                Name = v .. "Lights",
                AnchorPoint = Vector2_new_ret5,
                Position = UDim2.fromScale(i == 1 and 0.05 or 0.95, 0.02),
                Size = UDim2.fromScale(0.7, 0.75),
                ImageColor3 = TeamEventConfig.Team[v].Color:Lerp(Color3_new_ret, 0.15)
            };
            local v641 = {
                BackgroundTransparency = 1,
                Image = "rbxassetid://120639974824188",
                ScaleType = Enum.ScaleType.Fit
            };
            local ImageLabel = Instance.new("ImageLabel");

            for i2, v2 in v641 do
                ImageLabel[i2] = v2;
            end;

            ImageLabel.Parent = panel5;

            for i2, v2 in v640 do
                ImageLabel[i2] = v2;
            end;
        end;
    end;

    local panel = p631.panel;
    local UIScale = Instance.new("UIScale");

    for i, v in {} do
        UIScale[i] = v;
    end;

    UIScale.Parent = panel;
    p631.scale = UIScale;
    local pop = p631.tweens.pop;

    if pop then
        p631.tweens.pop = nil;
        pop:Cancel();
    end;

    local scale = p631.scale;
    local AbsoluteSize2 = p631.gui.AbsoluteSize;

    if AbsoluteSize2.X <= 0 or AbsoluteSize2.Y <= 0 then
        local workspace_CurrentCamera = workspace.CurrentCamera;

        if workspace_CurrentCamera then
            AbsoluteSize2 = workspace_CurrentCamera.ViewportSize;
        else
            AbsoluteSize2 = Vector2.new(1280, 720);
        end;
    end;

    local size = p631.size;
    scale.Scale = math.min(AbsoluteSize2.X * 0.96 / size.X, AbsoluteSize2.Y * 0.94 / size.Y, 1.2) * (p631.mode == "progress" and not p631.compact and 0.8 or 1);

    if v632 then
        buildProgress(p631);
    else
        buildPick(p631);
    end;

    paint(p631);
end;

local function watchSnapshot(u642) -- Line: 2066
    -- upvalues: Game (copy), HttpService (copy), paint (copy)
    local TeamEvent = Game:FindFirstChild("TeamEvent");

    if TeamEvent then
        TeamEvent = TeamEvent:FindFirstChild("Snapshot");
    end;

    if not (TeamEvent and TeamEvent:IsA("StringValue")) then
        TeamEvent = nil;
    end;

    if TeamEvent == u642.snapshotValue then
        return;
    end;

    if u642.snapshotChanged then
        u642.snapshotChanged:Disconnect();
        u642.snapshotChanged = nil;
    end;

    u642.snapshotValue = TeamEvent;
    local v643;

    if TeamEvent then
        local v644;
        v644, v643 = pcall(HttpService.JSONDecode, HttpService, TeamEvent.Value);

        if not v644 or type(v643) ~= "table" then
            v643 = nil;
        end;
    else
        v643 = TeamEvent;
    end;

    u642.snapshot = v643;

    if TeamEvent then
        u642.snapshotChanged = TeamEvent.Changed:Connect(function() -- Line: 2078
            -- upvalues: u642 (copy), TeamEvent (copy), HttpService (ref), paint (ref)
            local success, result = pcall(HttpService.JSONDecode, HttpService, TeamEvent.Value);

            if not success or type(result) ~= "table" then
                result = nil;
            end;

            u642.snapshot = result;
            paint(u642);
        end);
    end;
end;

u19 = function(p645) -- Line: 2085
    -- upvalues: u11 (ref), clear (copy), ContextActionService (copy), Cursor (copy), u17 (ref), GamepadService (copy), LocalPlayer (copy), u13 (ref), Telemetry (copy), u157 (copy), setupPrompts (copy)
    local v646 = u11;

    if not v646 then
        return;
    end;

    u11 = nil;
    clear(v646);

    for _, v in v646.connections do
        v:Disconnect();
    end;

    if v646.snapshotChanged then
        v646.snapshotChanged:Disconnect();
    end;

    ContextActionService:UnbindAction("FootballEventBack");
    Cursor.release(v646.gui);

    if u17 then
        u17 = false;

        if GamepadService.GamepadCursorEnabled then
            pcall(GamepadService.DisableGamepadCursor, GamepadService);
        end;
    end;

    v646.gui:Destroy();
    LocalPlayer:SetAttribute("FootballEventOpen", nil);
    u13 = nil;

    if p645 ~= "NotReady" and p645 ~= "Destroyed" then
        local track = Telemetry.track;
        local v647 = os.clock() - v646.openedAt;
        track("panel_close", "FootballEvent" .. ":" .. p645, (math.floor(v647)));
    end;

    for i in u157 do
        setupPrompts(i);
    end;
end;

local function back(p648, p649) -- Line: 2117
    -- upvalues: u19 (ref)
    if p649 ~= Enum.UserInputState.Begin then
        return Enum.ContextActionResult.Pass;
    end;

    u19("Back");

    return Enum.ContextActionResult.Sink;
end;

local function open(p650) -- Line: 2126
    -- upvalues: LocalPlayer (copy), u11 (ref), u9 (ref), permitted (copy), HudNavigation (copy), ChickenOrHero (copy), Cursor (copy), Color3_new_ret2 (copy), u19 (ref), watchSnapshot (copy), u18 (ref), TweenInfo_new_ret5 (copy), TweenService (copy), TweenInfo_new_ret6 (copy), Vector2_new_ret3 (copy), Vector2_new_ret (copy), UserInputService (copy), RunService (copy), paint (copy), ContextActionService (copy), back (copy), Telemetry (copy), u157 (copy), setupPrompts (copy), TeamEventRemote (copy), u17 (ref), GamepadService (copy)
    local v651 = LocalPlayer:FindFirstChildOfClass("PlayerGui");

    if not u11 then
        local v652;

        if u9 == nil then
            v652 = false;
        else
            v652 = u9.enabled == true;
        end;

        if v652 and (permitted() and v651) then
            HudNavigation.opening("FootballEvent");
            local v653 = {
                Name = "FootballEventPanel",
                DisplayOrder = 900,
                IgnoreGuiInset = true,
                ResetOnSpawn = false,
                ZIndexBehavior = Enum.ZIndexBehavior.Sibling
            };
            local ScreenGui = Instance.new("ScreenGui");

            for i, v in v653 do
                ScreenGui[i] = v;
            end;

            ScreenGui.Parent = v651;
            require(ChickenOrHero.Presentation:WaitForChild("CutsceneScreen")).apply(ScreenGui);
            ScreenGui:SetAttribute("SelfManagedText", true);
            local u654 = {
                statusUntil = 0,
                gui = ScreenGui,
                connections = {},
                content = {},
                tweens = {},
                previews = {},
                kinds = {
                    Team = {},
                    Personal = {}
                },
                ctx = {},
                once = p650 == true,
                openedAt = os.clock()
            };
            u11 = u654;
            Cursor.request(ScreenGui);
            local v655 = {
                Name = "Shade",
                BackgroundTransparency = 1,
                AutoButtonColor = false,
                Selectable = false,
                Text = "",
                AnchorPoint = Vector2.new(0.5, 0.5),
                Position = UDim2.fromScale(0.5, 0.5),
                Size = UDim2.fromScale(1.5, 1.5),
                BackgroundColor3 = Color3_new_ret2
            };
            local TextButton = Instance.new("TextButton");

            for i, v in v655 do
                TextButton[i] = v;
            end;

            TextButton.Parent = ScreenGui;
            table.insert(u654.connections, TextButton.Activated:Connect(function() -- Line: 2169
                -- upvalues: u19 (ref)
                u19("Outside");
            end));
            watchSnapshot(u654);
            u18(u654);
            local Scale = u654.scale.Scale;
            u654.scale.Scale = Scale * 0.86;
            local scale = u654.scale;
            local v656 = {
                Scale = Scale
            };
            local pop = u654.tweens.pop;

            if pop then
                pop:Cancel();
            end;

            local v657 = TweenService:Create(scale, TweenInfo_new_ret5, v656);
            u654.tweens.pop = v657;
            v657:Play();
            local v658 = {
                BackgroundTransparency = 0.35
            };
            local shade = u654.tweens.shade;

            if shade then
                shade:Cancel();
            end;

            local v659 = TweenService:Create(TextButton, TweenInfo_new_ret6, v658);
            u654.tweens.shade = v659;
            v659:Play();
            local connections = u654.connections;
            local PropertyChangedSignal = ScreenGui:GetPropertyChangedSignal("AbsoluteSize");
            table.insert(connections, PropertyChangedSignal:Connect(function() -- Line: 2179
                -- upvalues: ScreenGui (copy), u654 (copy), Vector2_new_ret3 (ref), Vector2_new_ret (ref), u18 (ref)
                local v660;

                if u654.mode == "progress" then
                    v660 = Vector2_new_ret3;
                else
                    v660 = Vector2_new_ret;
                end;

                local AbsoluteSize = ScreenGui.AbsoluteSize;

                if AbsoluteSize.X <= 0 or AbsoluteSize.Y <= 0 then
                    local workspace_CurrentCamera = workspace.CurrentCamera;

                    if workspace_CurrentCamera then
                        AbsoluteSize = workspace_CurrentCamera.ViewportSize;
                    else
                        AbsoluteSize = Vector2.new(1280, 720);
                    end;
                end;

                if math.min(AbsoluteSize.X * 0.96 / v660.X, AbsoluteSize.Y * 0.94 / v660.Y, 1.2) < 0.85 ~= u654.compact then
                    u18(u654);

                    return;
                end;

                local v661 = u654;
                local pop2 = v661.tweens.pop;

                if pop2 then
                    v661.tweens.pop = nil;
                    pop2:Cancel();
                end;

                local scale2 = v661.scale;
                local AbsoluteSize2 = v661.gui.AbsoluteSize;

                if AbsoluteSize2.X <= 0 or AbsoluteSize2.Y <= 0 then
                    local workspace_CurrentCamera = workspace.CurrentCamera;

                    if workspace_CurrentCamera then
                        AbsoluteSize2 = workspace_CurrentCamera.ViewportSize;
                    else
                        AbsoluteSize2 = Vector2.new(1280, 720);
                    end;
                end;

                local size = v661.size;
                scale2.Scale = math.min(AbsoluteSize2.X * 0.96 / size.X, AbsoluteSize2.Y * 0.94 / size.Y, 1.2) * (v661.mode == "progress" and not v661.compact and 0.8 or 1);
            end));
            table.insert(u654.connections, UserInputService.InputBegan:Connect(function(p662, p663) -- Line: 2186
                -- upvalues: u19 (ref)
                if not p663 and p662.KeyCode == Enum.KeyCode.Escape then
                    u19("Back");
                end;
            end));
            local u664 = 0;
            table.insert(u654.connections, RunService.Heartbeat:Connect(function(p665) -- Line: 2192
                -- upvalues: ScreenGui (copy), u19 (ref), u664 (ref), watchSnapshot (ref), u654 (copy), paint (ref)
                if not ScreenGui.Parent then
                    u19("Destroyed");

                    return;
                end;

                u664 = u664 + p665;

                if u664 >= 1 then
                    u664 = 0;
                    watchSnapshot(u654);
                    paint(u654);
                end;
            end));
            ContextActionService:BindActionAtPriority("FootballEventBack", back, false, Enum.ContextActionPriority.High.Value + 100, Enum.KeyCode.ButtonB);
            LocalPlayer:SetAttribute("FootballEventOpen", true);
            LocalPlayer:SetAttribute("SpectateRequestedExit", os.clock());
            Telemetry.track("panel_open", "FootballEvent", u654.once and 1 or nil);

            for i in u157 do
                setupPrompts(i);
            end;

            TeamEventRemote:FireServer("Get");
            task.defer(function() -- Line: 2219
                -- upvalues: u11 (ref), u654 (copy), u17 (ref), UserInputService (ref), GamepadService (ref)
                if u11 == u654 and not (u17 or (UserInputService.PreferredInput ~= Enum.PreferredInput.Gamepad or GamepadService.GamepadCursorEnabled)) then
                    u17 = pcall(GamepadService.EnableGamepadCursor, GamepadService, u654.panel);
                end;
            end);

            return true;
        end;
    end;

    return false;
end;

local function celebrate(p666) -- Line: 2233
    -- upvalues: LocalPlayer (copy), u9 (ref), TeamEventConfig (copy), ClaimPop (copy), u11 (ref), u16 (ref)
    if LocalPlayer:GetAttribute("TeamEventClaimInFrame") == true then
        return;
    end;

    local v667 = u9 and TeamEventConfig.Team[u9.team];
    local given = ClaimPop.given;
    local v668;

    if u11 then
        v668 = u16;
    else
        v668 = nil;
    end;

    local v669 = {
        displayOrder = 901
    };
    local v670;

    if v667 then
        v670 = v667.Label .. " REWARDS!";
    else
        v670 = nil;
    end;

    v669.heading = v670;
    local success, result = pcall(given, p666, v668, v669);

    if not success then
        warn("Football event claim celebration failed: " .. tostring(result));
    end;
end;

local u671 = {
    MapVote = true,
    MatchResult = true
};
HudNavigation.Opening.Event:Connect(function(p672) -- Line: 2251
    -- upvalues: u671 (copy), u19 (ref)
    if p672 ~= "FootballEvent" and not u671[p672] then
        u19("Replaced");
    end;
end);

for _, v in { "ClientReady", "InMatch", "ScreenPresentationActive", "AdminRefreshActive", "MatchSummaryVisible" } do
    LocalPlayer:GetAttributeChangedSignal(v):Connect(function() -- Line: 2257
        -- upvalues: u11 (ref), v (copy), LocalPlayer (copy), u19 (ref), u157 (copy), setupPrompts (copy)
        if u11 and (v == "InMatch" and LocalPlayer:GetAttribute("InMatch") == true) then
            u19("Match");
        elseif u11 and (LocalPlayer:GetAttribute("ClientReady") ~= true or (LocalPlayer:GetAttribute("ScreenPresentationActive") == true or LocalPlayer:GetAttribute("AdminRefreshActive") == true)) then
            u19("NotReady");
        end;

        for i in u157 do
            setupPrompts(i);
        end;
    end);
end;

LocalPlayer.CharacterAdded:Connect(function() -- Line: 2266
    -- upvalues: u19 (ref)
    u19("Respawn");
end);
TeamEventRemote.OnClientEvent:Connect(function(p673, p674, p675, p676) -- Line: 2271
    -- upvalues: u9 (ref), HudNavigation (copy), u12 (ref), Color3_fromRGB_ret5 (copy), u11 (ref), paint (copy), celebrate (copy), TeamEventConfig (copy), Color3_fromRGB_ret9 (copy), Interface (copy), u19 (ref), u18 (ref), u157 (copy), setupPrompts (copy), ChickenOrHero (copy)
    if p673 ~= "State" or type(p674) ~= "table" then
        return;
    end;

    u9 = p674;
    local v677;

    if u9 == nil then
        v677 = false;
    else
        v677 = u9.enabled == true;
    end;

    HudNavigation.setAvailable("FootballEvent", v677);
    local v678 = false;

    if type(p675) == "string" and p675 ~= "auto" then
        u12 = 0;

        if p675 == "claimed" then
            local v679 = Color3_fromRGB_ret5;
            local v680 = u11;

            if v680 then
                local v681 = os.clock() + 8;
                v680.statusText = "Rewards collected!";
                v680.statusColor = v679;
                v680.statusUntil = v681;
                paint(v680);
            end;

            celebrate(p676);
        elseif p675 == "joined" then
            local v682 = Color3_fromRGB_ret5;
            local v683 = u11;

            if v683 then
                local v684 = os.clock() + 8;
                v683.statusText = "Welcome to the team! Every crossing, catch and win scores a point.";
                v683.statusColor = v682;
                v683.statusUntil = v684;
                paint(v683);
            end;

            v678 = TeamEventConfig.Team[u9.team] ~= nil;
        elseif u11 then
            local v685 = Color3_fromRGB_ret9;
            local v686 = u11;

            if v686 then
                local v687 = os.clock() + 8;
                v686.statusText = p675;
                v686.statusColor = v685;
                v686.statusUntil = v687;
                paint(v686);
            end;
        else
            local success, result = pcall(require, Interface:FindFirstChild("TeamEventCelebration"));

            if success and (type(result) == "table" and result.notice) then
                result.notice(p675);
            else
                HudNavigation.Notice:Fire(p675);
            end;
        end;
    end;

    local v688 = u11;

    if v688 then
        local v689;

        if u9 == nil then
            v689 = false;
        else
            v689 = u9.enabled == true;
        end;

        if v689 then
            if (TeamEventConfig.Team[u9.team] and "progress" or "pick") == v688.mode then
                paint(v688);
            else
                u18(v688);
            end;
        else
            u19("Disabled");
        end;
    end;

    for i in u157 do
        setupPrompts(i);
    end;

    if v678 then
        local success, result = pcall(require, ChickenOrHero.Weapons:FindFirstChild("EventKnivesOffer"));

        if success and (type(result) == "table" and (result.popup and result.active())) then
            u19("Shop");
            task.defer(result.popup, {
                heading = "WELCOME TO " .. TeamEventConfig.Team[u9.team].Label .. "! GEAR UP FOR GAME DAY"
            });
        end;
    end;
end);
local ArmoryEvent = ChickenOrHero.Weapons:WaitForChild("ArmoryEvent");
ArmoryEvent.OnClientEvent:Connect(function(p690, p691) -- Line: 2320
    -- upvalues: TeamEventConfig (copy), u10 (ref), u11 (ref), u18 (ref)
    if p690 ~= "State" or (type(p691) ~= "table" or type(p691.owned) ~= "table") then
        return;
    end;

    local v692 = false;

    for _, v in TeamEventConfig.Team do
        local v693 = v;

        for _, v2 in { "PersonalKnife", "TeamKnife", "EventKnife" } do
            local v694 = v693[v2];

            if v694 and u10[v694] == true ~= (p691.owned[v694] == true) then
                v692 = true;
            end;
        end;
    end;

    u10 = p691.owned;

    if v692 and u11 then
        u18(u11);
    end;
end);
ArmoryEvent:FireServer("Get");

local function enter() -- Line: 2342
    -- upvalues: u11 (ref), LocalPlayer (copy), u9 (ref), permitted (copy), open (copy)
    if u11 then
        return;
    end;

    if LocalPlayer:GetAttribute("EventIntroUnseen") == true and LocalPlayer:GetAttribute("InMatch") ~= true then
        if LocalPlayer:GetAttribute("EventIntroActive") ~= true then
            local v695;

            if u9 == nil then
                v695 = false;
            else
                v695 = u9.enabled == true;
            end;

            if v695 and permitted() then
                LocalPlayer:SetAttribute("EventIntroRequested", os.clock());
            end;
        end;

        return;
    end;

    open(false);
end;

ProximityPromptService.PromptTriggered:Connect(function(p696, p697) -- Line: 2354
    -- upvalues: LocalPlayer (copy), u157 (copy), Telemetry (copy), enter (copy)
    if p697 ~= LocalPlayer then
        return;
    end;

    for i in u157 do
        if p696:IsDescendantOf(i) then
            Telemetry.track("event_prompt", "FootballEvent");
            enter();

            return;
        end;
    end;
end);

local function watchPlace(p698) -- Line: 2367
    -- upvalues: u157 (copy), u9 (ref), TeamEventConfig (copy), permitted (copy), u11 (ref), setupPrompts (copy)
    if u157[p698] or (not p698:IsA("Model") or string.sub(p698.Name, 1, 13) ~= "FootballEvent") then
        return;
    end;

    u157[p698] = p698.DescendantAdded:Connect(function(p699) -- Line: 2371
        -- upvalues: u9 (ref), TeamEventConfig (ref), permitted (ref), u11 (ref)
        if p699:IsA("ProximityPrompt") then
            p699.ActionText = u9 and TeamEventConfig.Team[u9.team] and "Event progress" or "Pick a side";
            p699.ObjectText = "FOOTBALL vs FÚTBOL";
            p699.Exclusivity = Enum.ProximityPromptExclusivity.OneGlobally;
            local v700;

            if u9 == nil then
                v700 = false;
            else
                v700 = u9.enabled == true;
            end;

            local v701 = v700 and permitted() and u11 == nil;
            p699.Enabled = v701;
        end;
    end);
    setupPrompts(p698);
end;

workspace.ChildAdded:Connect(watchPlace);
workspace.ChildRemoved:Connect(function(p702) -- Line: 2379
    -- upvalues: u157 (copy)
    local v703 = u157[p702];

    if v703 then
        u157[p702] = nil;
        v703:Disconnect();
    end;
end);

for _, child in workspace:GetChildren() do
    watchPlace(child);
end;

HudNavigation.register("FootballEvent", function() -- Line: 2389
    -- upvalues: u11 (ref), u19 (ref), open (copy)
    if u11 then
        u19("Toggle");

        return;
    end;

    open(false);
end);
HudNavigation.register("FootballEventOpen", function() -- Line: 2397
    -- upvalues: Telemetry (copy), enter (copy)
    Telemetry.track("event_topbar", "FootballEvent");
    enter();
end);
HudNavigation.setAvailable("FootballEvent", false);
TeamEventRemote:FireServer("Get");