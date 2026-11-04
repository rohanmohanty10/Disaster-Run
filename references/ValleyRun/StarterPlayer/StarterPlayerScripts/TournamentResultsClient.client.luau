 

 

local Players = game:GetService("Players");
local HttpService = game:GetService("HttpService");
local UserInputService = game:GetService("UserInputService");
local LocalPlayer = Players.LocalPlayer;
local ChickenOrHero = game.ReplicatedStorage:WaitForChild("ChickenOrHero");
local FFlags = require(game:GetService("ReplicatedFirst"):WaitForChild("FFlags"));
local Game = ChickenOrHero:WaitForChild("Game");
local MatchSummary = Game:WaitForChild("MatchSummary");
local Session = Game:WaitForChild("Session");
local u1 = { Color3.fromRGB(255, 202, 58), Color3.fromRGB(169, 169, 169), Color3.fromRGB(142, 104, 59) };
local u2 = { "HostPanelOpen", "ArmoryOpen", "JourneyOpen", "SettingsOpen", "CrateOpen", "ServerBrowserOpen", "ScreenPresentationActive" };
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = nil;
local u8 = nil;
local u9 = nil;
local u10 = nil;
local u11 = nil;
local u12 = nil;
local u13 = nil;
local u14 = nil;
local u15 = nil;
local u16 = {};
local u17 = nil;
local u18 = nil;
local u19 = nil;
local u20 = nil;

local function px(p21) -- Line: 38
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local v22 = workspace_CurrentCamera and workspace_CurrentCamera.ViewportSize or Vector2.new(1280, 720);

    if v22.X < 700 or v22.Y < 500 then
        return p21;
    end;

    local math_round_ret = math.round(p21 * 1.12);

    return math.clamp(math_round_ret, 12, 40);
end;

local function text(p23, p24, p25, p26, p27, p28, p29, p30, p31, p32) -- Line: 47
    -- upvalues: u3 (ref), u16 (copy), u4 (ref)
    local text = u3.text;
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local v33 = workspace_CurrentCamera and workspace_CurrentCamera.ViewportSize or Vector2.new(1280, 720);
    local v34;

    if v33.X < 700 or v33.Y < 500 then
        v34 = p30;
    else
        local math_round_ret = math.round(p30 * 1.12);
        v34 = math.clamp(math_round_ret, 12, 40);
    end;

    local v35 = text(p23, p24, p25, p26, p27, p28, p29, v34, p31);
    u16[v35] = p30;

    if u4 then
        u4.text(v35, p32 or p31, {
            stroke = 1
        });
    end;

    return v35;
end;

local function list(p36, p37) -- Line: 56
    -- upvalues: u3 (ref), u7 (ref), u4 (ref)
    local v38 = u3.make("ScrollingFrame", u7, p36, {
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 4,
        Position = UDim2.fromOffset(p37, 140),
        Size = UDim2.fromOffset(268, 260),
        CanvasSize = UDim2.new(),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        ScrollingDirection = Enum.ScrollingDirection.Y
    });

    if u4 then
        u4.scroll(v38);
    end;

    u3.make("UIListLayout", v38, "List", {
        Padding = UDim.new(0, 4),
        SortOrder = Enum.SortOrder.LayoutOrder
    });

    return v38;
end;

local function clear() -- Line: 74
    -- upvalues: u13 (ref), u14 (ref), u16 (copy)
    for _, v in { u13, u14 } do
        for _, child in v:GetChildren() do
            if child:IsA("Frame") then
                local v39 = child;

                for i in u16 do
                    if i:IsDescendantOf(v39) then
                        u16[i] = nil;
                    end;
                end;

                v39:Destroy();
            end;
        end;
    end;
end;

local function setOpen(p40) -- Line: 89
    -- upvalues: u5 (ref), u6 (ref), LocalPlayer (copy), clear (copy)
    if not u5 then
        return;
    end;

    u6.Visible = p40;
    LocalPlayer:SetAttribute("TournamentResultsOpen", p40 or nil);
    LocalPlayer:SetAttribute("MatchSummaryVisible", p40 or nil);

    if not p40 then
        clear();
    end;
end;

local function dismiss() -- Line: 101
    -- upvalues: u19 (ref), u18 (ref), u5 (ref), u6 (ref), LocalPlayer (copy), clear (copy)
    u19 = u18;
    u18 = nil;

    if not u5 then
        return;
    end;

    u6.Visible = false;
    LocalPlayer:SetAttribute("TournamentResultsOpen", nil);
    LocalPlayer:SetAttribute("MatchSummaryVisible", nil);
    clear();
end;

local function build() -- Line: 107
    -- upvalues: u5 (ref), FFlags (copy), ChickenOrHero (copy), u4 (ref), u3 (ref), u1 (ref), LocalPlayer (copy), u6 (ref), u7 (ref), u8 (ref), text (copy), u9 (ref), u10 (ref), u11 (ref), u12 (ref), u13 (ref), list (copy), u14 (ref), u15 (ref), dismiss (copy), UserInputService (copy), u18 (ref), u19 (ref), clear (copy)
    if u5 then
        return;
    end;

    local v41;

    if FFlags.awaitUIVersion() == "OldUIReskin" then
        v41 = ChickenOrHero:FindFirstChild("OldUIReskin");
    else
        v41 = false;
    end;

    u4 = v41 and require(v41:WaitForChild("Skin")) or nil;
    u3 = u4 and u4.Panels or require(ChickenOrHero:WaitForChild("Presentation"):WaitForChild("ValleyPanels"));

    if u4 and u4.Places then
        u1 = u4.Places;
    end;

    u5 = u3.screen(LocalPlayer, "TournamentResults", 64);
    u5:SetAttribute("SelfManagedText", true);
    local v42, v43, v44 = u3.panel(u5, "TournamentResults", 600, 452);
    u6 = v42;
    u7 = v43;
    u8 = text(u7, "Title", "", 24, 20, 490, 34, 22, u3.Gold, "gold");
    u8.Font = Enum.Font.GothamBold;
    u9 = text(u7, "Rules", "", 24, 56, 552, 20, 13, u3.Muted, "secondary");
    u10 = text(u7, "Champion", "", 24, 80, 552, 28, 18, u3.Paper, "primary");
    u10.Font = Enum.Font.GothamBold;
    u11 = text(u7, "MatchHead", "", 24, 112, 268, 22, 13, u3.Gold, "gold");
    u11.Font = Enum.Font.GothamBold;
    u12 = text(u7, "StandingsHead", "", 308, 112, 268, 22, 13, u3.Gold, "gold");
    u12.Font = Enum.Font.GothamBold;
    u13 = list("Match", 24);
    u14 = list("Standings", 308);
    u15 = text(u7, "You", "", 24, 408, 552, 26, 15, u3.Gold, "gold");
    u15.Font = Enum.Font.GothamBold;
    v44.Activated:Connect(dismiss);
    UserInputService.InputBegan:Connect(function(p45) -- Line: 136
        -- upvalues: u18 (ref), u19 (ref), u5 (ref), u6 (ref), LocalPlayer (ref), clear (ref)
        if u18 and p45.KeyCode == Enum.KeyCode.Escape then
            u19 = u18;
            u18 = nil;

            if not u5 then
                return;
            end;

            u6.Visible = false;
            LocalPlayer:SetAttribute("TournamentResultsOpen", nil);
            LocalPlayer:SetAttribute("MatchSummaryVisible", nil);
            clear();
        end;
    end);
end;

local function row(p46, p47, p48, p49, p50) -- Line: 144
    -- upvalues: u3 (ref), text (copy)
    local v51 = p50 or 26;
    local v52 = u3.make("Frame", p46, "Row" .. p47, {
        BorderSizePixel = 0,
        Size = UDim2.new(1, -8, 0, v51),
        BackgroundColor3 = u3.Gold,
        BackgroundTransparency = p49 and 0.82 or 1,
        LayoutOrder = p47
    });
    u3.corner(v52, 6);

    for _, v in p48 do
        local v53 = text(v52, v.name, v.text, v.x, 0, v.w, v51, v.size or 14, v.color or u3.Paper);
        v53.TextWrapped = false;
        v53.TextTruncate = Enum.TextTruncate.AtEnd;
        v53.TextYAlignment = Enum.TextYAlignment.Center;

        if v.right then
            v53.TextXAlignment = Enum.TextXAlignment.Right;
        end;

        if v.bold or p49 then
            v53.Font = Enum.Font.GothamBold;
        end;
    end;
end;

local function ordinal(p54) -- Line: 168
    local v55 = p54 % 100;

    return p54 .. (v55 >= 11 and v55 <= 13 and "th" or (({ "st", "nd", "rd" })[p54 % 10] or "th"));
end;

local function fill(p56) -- Line: 174
    -- upvalues: clear (copy), u8 (ref), u9 (ref), u10 (ref), u11 (ref), u12 (ref), LocalPlayer (copy), row (copy), u13 (ref), u3 (ref), u1 (ref), u14 (ref), u15 (ref)
    clear();
    local v57 = p56.final == true;
    local v58 = type(p56.standings) == "table" and (p56.standings or {}) or {};
    local v59 = type(p56.rows) == "table" and (p56.rows or {}) or {};
    u8.Text = v57 and "TOURNAMENT FINAL" or ("TOURNAMENT · MATCH %d OF %d"):format(p56.match or 0, p56.matches or 0);
    u9.Text = tostring(p56.rules or "") .. " (tiers stack)";
    local v60;

    if v57 then
        v60 = v58[1] ~= nil;
    else
        v60 = v57;
    end;

    u10.Visible = v60;

    if u10.Visible then
        local v61 = {};

        for _, v in v58 do
            if v.rank == 1 then
                local v62 = tostring(v.name);
                table.insert(v61, v62);
            end;
        end;

        u10.Text = ("CHAMPION%s: %s  ·  %d pts"):format(#v61 > 1 and "S" or "", table.concat(v61, " & "), v58[1].total or 0);
    end;

    u11.Text = not v57 and "THIS MATCH" or ("LAST MATCH (%d OF %d)"):format(p56.match or 0, p56.matches or 0);
    u12.Text = v57 and "FINAL TOP 5" or "STANDINGS";
    local v63 = nil;
    local v64 = nil;

    for i, v in v59 do
        local v65 = v.userId == LocalPlayer.UserId;

        if v65 then
            v63 = v;
        end;

        local v66 = {};

        if v.rank then
            local v67 = tonumber(v.survival) or 0;
            table.insert(v66, ("%.1fs"):format(v67));
        end;

        if v.lms then
            table.insert(v66, "LMS");
        end;

        local v68 = tonumber(v.revives) or 0;

        if v68 > 0 then
            table.insert(v66, v68 .. " rev");
        end;

        local v69 = tonumber(v.catches) or 0;

        if v69 > 0 then
            table.insert(v66, v69 .. (v69 == 1 and " catch" or " catches"));
        end;

        local table_concat_ret = table.concat(v66, " · ");
        local v70 = tonumber(v.points) or 0;
        local v71 = {};
        local v72 = {
            name = "Rank",
            x = 6,
            w = 34,
            text = not v.rank and "—" or "#" .. v.rank,
            color = u3.Muted
        };
        local v73 = {
            name = "Name",
            x = 42,
            w = 96,
            text = tostring(v.name)
        };
        local v74 = {
            name = "Detail",
            x = 140,
            w = 86,
            size = 12,
            text = table_concat_ret
        };
        local v75;

        if v.lms then
            v75 = u3.Gold;
        else
            v75 = u3.Muted;
        end;

        v74.color = v75;
        local v76 = {
            name = "Points",
            x = 222,
            w = 36,
            right = true,
            bold = true,
            text = "+" .. v70
        };
        local v77;

        if v70 > 0 then
            v77 = u3.Gold;
        else
            v77 = u3.Muted;
        end;

        v76.color = v77;
        v71[1], v71[2], v71[3], v71[4] = v72, v73, v74, v76;
        row(u13, i, v71, v65);
    end;

    for _, v in v58 do
        if v.userId == LocalPlayer.UserId then
            v64 = v;
        end;
    end;

    local v78;

    if v57 then
        v78 = math.min(#v58, 5);
    else
        v78 = #v58;
    end;

    for i = 1, v78 do
        local v79 = v58[i];
        local v80 = v79.userId == LocalPlayer.UserId;
        local v81;

        if v57 then
            v81 = u1[v79.rank] or nil;
        else
            v81 = nil;
        end;

        local v82 = tonumber(v79.gained) or 0;
        row(u14, i, {
            {
                name = "Rank",
                x = 6,
                w = 30,
                text = v79.rank .. ".",
                size = v57 and 18 or 14,
                color = v81 or u3.Muted,
                bold = v81 ~= nil
            },
            {
                name = "Name",
                x = 38,
                text = tostring(v79.name),
                w = v57 and 170 or 132,
                size = v57 and 17 or 14
            },
            {
                name = "Gained",
                x = 172,
                w = 44,
                size = 12,
                text = (v57 or v82 <= 0) and "" or ("+%d"):format(v82),
                color = u3.Muted
            },
            {
                name = "Total",
                x = 212,
                w = 46,
                right = true,
                bold = true,
                text = tostring(v79.total or 0),
                size = v57 and 18 or 14,
                color = v81 or u3.Gold
            }
        }, v80, v57 and 36 or 26);
        local _ = i;
    end;

    local v83 = {};

    if v63 then
        local v84 = tonumber(v63.points) or 0;
        table.insert(v83, ("+%d this match"):format(v84));
    end;

    if v64 then
        local rank = v64.rank;
        local v85 = rank % 100;
        table.insert(v83, ("%s%s with %d pts"):format(v57 and "you finished " or "", rank .. (v85 >= 11 and v85 <= 13 and "th" or (({ "st", "nd", "rd" })[rank % 10] or "th")), v64.total or 0));
    end;

    u15.Text = #v83 <= 0 and "" or "You: " .. table.concat(v83, "  ·  ");
end;

local function decode(p86) -- Line: 282
    -- upvalues: HttpService (copy)
    if p86 == "" then
        return nil;
    end;

    local success, result = pcall(HttpService.JSONDecode, HttpService, p86);

    if success and (type(result) == "table" and (type(result.tournament) == "table" and (type(result.matchId) == "string" and type(result.expiresAt) == "number"))) then
        return result;
    end;

    return nil;
end;

local function busy() -- Line: 299
    -- upvalues: u2 (copy), LocalPlayer (copy)
    for _, v in u2 do
        if LocalPlayer:GetAttribute(v) == true then
            return true;
        end;
    end;

    return false;
end;

local function evaluate() -- Line: 308
    -- upvalues: u17 (ref), u19 (ref), Session (copy), LocalPlayer (copy), u18 (ref), u5 (ref), u6 (ref), clear (copy), u2 (copy), build (copy), fill (copy), u16 (copy), u20 (ref), evaluate (copy)
    local ServerTimeNow = workspace:GetServerTimeNow();
    local v87;

    if u17 == nil or (u17.matchId == u19 or (ServerTimeNow >= u17.expiresAt or (Session:GetAttribute("Phase") ~= "Intermission" or LocalPlayer:GetAttribute("InMatch") == true))) then
        v87 = false;
    else
        v87 = LocalPlayer:GetAttribute("InitialLoadingComplete") == true;
    end;

    if not v87 then
        if u18 then
            u18 = nil;

            if not u5 then
                return;
            end;

            u6.Visible = false;
            LocalPlayer:SetAttribute("TournamentResultsOpen", nil);
            LocalPlayer:SetAttribute("MatchSummaryVisible", nil);
            clear();
        end;

        return;
    end;

    if u18 ~= u17.matchId then
        local v88 = false;

        for _, v in u2 do
            if LocalPlayer:GetAttribute(v) == true then
                v88 = true;
                break;
            end;
        end;

        if not v88 then
            build();
            fill(u17.tournament);

            for i, v in u16 do
                local workspace_CurrentCamera = workspace.CurrentCamera;
                local v89 = workspace_CurrentCamera and workspace_CurrentCamera.ViewportSize or Vector2.new(1280, 720);
                local v90;

                if v89.X < 700 or v89.Y < 500 then
                    v90 = v;
                else
                    local math_round_ret = math.round(v * 1.12);
                    v90 = math.clamp(math_round_ret, 12, 40);
                end;

                i.TextSize = v90;
            end;

            u18 = u17.matchId;

            if u5 then
                u6.Visible = true;
                LocalPlayer:SetAttribute("TournamentResultsOpen", true);
                LocalPlayer:SetAttribute("MatchSummaryVisible", true);
            end;

            if u20 then
                task.cancel(u20);
            end;

            u20 = task.delay(math.max(0.1, u17.expiresAt - ServerTimeNow + 0.05), function() -- Line: 336
                -- upvalues: u20 (ref), evaluate (ref)
                u20 = nil;
                evaluate();
            end);
        end;
    end;
end;

MatchSummary.Changed:Connect(function(p91) -- Line: 342
    -- upvalues: u17 (ref), decode (copy), evaluate (copy)
    u17 = decode(p91);
    evaluate();
end);
Session:GetAttributeChangedSignal("Phase"):Connect(evaluate);

for _, v in { "InMatch", "InitialLoadingComplete", table.unpack(u2) } do
    LocalPlayer:GetAttributeChangedSignal(v):Connect(evaluate);
end;

u17 = decode(MatchSummary.Value);
evaluate();