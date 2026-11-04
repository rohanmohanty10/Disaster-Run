 

 

local TextService = game:GetService("TextService");
local ValleyTheme = require(script.Parent.ValleyTheme);
local u1 = {
    Width = 8,
    MaxDistance = 70,
    HeadOffset = 1.45
};
local Color3_fromRGB_ret = Color3.fromRGB(8, 18, 20);

local function textWidth(p2, p3) -- Line: 11
    -- upvalues: TextService (copy)
    local X = TextService:GetTextSize(p2.RichText and p2.Text:gsub("<[^>]->", "") or p2.Text, p3, p2.Font, Vector2.new(2000, 100)).X;

    return math.ceil(X) + 2;
end;

local function place(p4, p5, p6, p7, p8, p9) -- Line: 15
    p4.Position = UDim2.fromScale(p5 / 260, p6 / p9);
    p4.Size = UDim2.fromScale(p7 / 260, p8 / p9);
end;

local function separator(p10, p11) -- Line: 18
    -- upvalues: ValleyTheme (copy), Color3_fromRGB_ret (copy)
    local v12 = p10:FindFirstChild(p11);

    if not v12 then
        v12 = Instance.new("TextLabel");
        v12.Name = p11;
        v12.Parent = p10;
    end;

    v12.BackgroundTransparency = 1;
    v12.BorderSizePixel = 0;
    v12.Text = "·";
    v12.TextScaled = true;
    v12.Font = Enum.Font.GothamMedium;
    v12.TextColor3 = ValleyTheme.Muted;
    v12.TextStrokeColor3 = Color3_fromRGB_ret;
    v12.TextStrokeTransparency = 0.78;
    v12.TextXAlignment = Enum.TextXAlignment.Center;
    v12.TextYAlignment = Enum.TextYAlignment.Center;

    return v12;
end;

local function row(p13, p14, p15, p16, p17, p18) -- Line: 27
    -- upvalues: textWidth (copy)
    local v19 = {};

    for _, v in p13 do
        if v.Visible and v.Text ~= "" then
            table.insert(v19, v);
        end;
    end;

    for _, v in p14 do
        v.Visible = false;
    end;

    local v20 = math.max(0, #v19 - 1) * 10;
    local v21 = {};

    for i, v in v19 do
        v21[i] = textWidth(v, p18);
        v20 = v20 + v21[i];
    end;

    local v22;

    if v20 > 248 then
        v22 = math.max(0, #v19 - 1) * 10;
        local v23 = (248 - v22) / math.max(1, v20 - v22);

        for i in v19 do
            v21[i] = math.floor(v21[i] * v23);
            v22 = v22 + v21[i];
        end;
    else
        v22 = v20;
    end;

    local v24 = (260 - v22) / 2;

    for i, v in v19 do
        local v25 = v21[i];
        v.Position = UDim2.fromScale(v24 / 260, p15 / p17);
        v.Size = UDim2.fromScale(v25 / 260, p16 / p17);
        v24 = v24 + v21[i];
        local v26 = p14[i];

        if i < #v19 and v26 then
            v26.Visible = true;
            v26.Position = UDim2.fromScale(v24 / 260, p15 / p17);
            v26.Size = UDim2.fromScale(0.038461538461538464, p16 / p17);
            v24 = v24 + 10;
        end;
    end;
end;

function u1.apply(p27) -- Line: 46
    -- upvalues: u1 (copy), Color3_fromRGB_ret (copy), ValleyTheme (copy), separator (copy)
    p27.Size = UDim2.fromScale(u1.Width, u1.Width * 48 / 260);
    p27.SizeOffset = Vector2.new(0, 0.5);
    p27.StudsOffset = Vector3.new(0, 0, 0);
    p27.StudsOffsetWorldSpace = Vector3.new(0, u1.HeadOffset, 0);
    p27.ExtentsOffset = Vector3.new(0, 0, 0);
    p27.ExtentsOffsetWorldSpace = Vector3.new(0, 0, 0);
    p27.ResetOnSpawn = false;
    p27.MaxDistance = u1.MaxDistance;
    p27.AlwaysOnTop = false;
    p27.LightInfluence = 0;
    p27.ClipsDescendants = false;
    local Content = p27.Content;
    Content.BackgroundTransparency = 1;
    Content.BorderSizePixel = 0;
    Content.AnchorPoint = Vector2.zero;
    Content.Position = UDim2.fromScale(0, 0);
    Content.Size = UDim2.fromScale(1, 1);

    for _, descendant in Content:GetDescendants() do
        if descendant:IsA("UIListLayout") or (descendant:IsA("UIAspectRatioConstraint") or (descendant:IsA("UISizeConstraint") or (descendant:IsA("UITextSizeConstraint") or (descendant:IsA("UIScale") or descendant:IsA("UIStroke"))))) then
            descendant:Destroy();
        end;
    end;

    for _, v in { "DisplayName", "SpecialRank", "JourneyTitle", "Wins", "Lvl", "AFK", "Username" } do
        local v28 = Content[v];
        v28.BackgroundTransparency = 1;
        v28.BorderSizePixel = 0;
        v28.AnchorPoint = Vector2.zero;
        v28.TextWrapped = true;
        v28.TextScaled = true;
        v28.RichText = v == "DisplayName";
        v28.TextTruncate = Enum.TextTruncate.None;
        v28.TextXAlignment = Enum.TextXAlignment.Center;
        v28.TextYAlignment = Enum.TextYAlignment.Center;
        v28.TextStrokeColor3 = Color3_fromRGB_ret;
        v28.TextStrokeTransparency = v == "DisplayName" and 0.65 or 0.76;
        v28.TextTransparency = 0;
        v28.Font = v == "DisplayName" and Enum.Font.GothamBold or Enum.Font.GothamMedium;

        if v == "DisplayName" then
            v28.TextColor3 = Color3.fromRGB(247, 248, 241);
        elseif v == "Wins" or v == "Lvl" then
            v28.TextColor3 = Color3.fromRGB(205, 220, 211);
        end;
    end;

    Content.Username.Visible = false;
    Content.AFK.Text = "AFK";
    Content.AFK.TextColor3 = ValleyTheme.Gold;
    separator(Content, "TitleDot");
    separator(Content, "StatDot1");
    separator(Content, "StatDot2");
    local RankIcon = Content:FindFirstChild("RankIcon");

    if not RankIcon then
        RankIcon = Instance.new("ImageLabel");
        RankIcon.Name = "RankIcon";
        RankIcon.Visible = false;
        RankIcon.Parent = Content;
    end;

    RankIcon.BackgroundTransparency = 1;
    RankIcon.BorderSizePixel = 0;
    RankIcon.AnchorPoint = Vector2.zero;
    RankIcon.ScaleType = Enum.ScaleType.Fit;
end;

function u1.layout(p29) -- Line: 74
    -- upvalues: textWidth (copy), row (copy), u1 (copy)
    local Content = p29.Content;
    local v30 = (Content.SpecialRank.Visible or Content.JourneyTitle.Visible) and 12 or 0;
    local v31 = v30 + 36;
    local v32 = 0;

    for _, v in { Content.SpecialRank, Content.JourneyTitle } do
        if v.Visible then
            v32 = v32 + textWidth(v, 11);
        end;
    end;

    if Content.SpecialRank.Visible and Content.JourneyTitle.Visible then
        v32 = v32 + 10;
    end;

    local v33;

    if v32 > 248 then
        local math_floor_ret = math.floor(2728 / v32);
        v33 = math.max(9, math_floor_ret) or 11;
    else
        v33 = 11;
    end;

    local v34 = 12 * v33 / 11;
    row({ Content.SpecialRank, Content.JourneyTitle }, { Content.TitleDot }, (12 - v34) / 2, v34, v31, v33);
    local RankIcon = Content:FindFirstChild("RankIcon");

    if RankIcon and RankIcon.Visible then
        local v35 = textWidth(Content.DisplayName, 22);
        local math_min_ret = math.min(218, v35);
        local v36 = (260 - (math_min_ret + 27)) / 2;
        RankIcon.Position = UDim2.fromScale(v36 / 260, v30 / v31);
        RankIcon.Size = UDim2.fromScale(0.09230769230769231, 24 / v31);
        local DisplayName = Content.DisplayName;
        DisplayName.Position = UDim2.fromScale((v36 + 27) / 260, v30 / v31);
        DisplayName.Size = UDim2.fromScale(math_min_ret / 260, 24 / v31);
    else
        local DisplayName = Content.DisplayName;
        DisplayName.Position = UDim2.fromScale(0.023076923076923078, v30 / v31);
        DisplayName.Size = UDim2.fromScale(0.9538461538461539, 24 / v31);
    end;

    row({ Content.Lvl, Content.Wins, Content.AFK }, { Content.StatDot1, Content.StatDot2 }, v30 + 23, 13, v31, 11);
    p29.Size = UDim2.fromScale(u1.Width, u1.Width * v31 / 260);
    Content.Username.Visible = false;
end;

return u1;