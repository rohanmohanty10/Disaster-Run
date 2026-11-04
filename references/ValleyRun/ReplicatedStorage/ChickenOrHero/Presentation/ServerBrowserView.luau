 

 

local Skin = require(game:GetService("ReplicatedStorage"):WaitForChild("ChickenOrHero"):WaitForChild("OldUIReskin"):WaitForChild("Skin"));
local Theme = Skin.Theme;
local u3 = {
    styleCountry = function(p1, p2) -- Line: 6, Name: styleCountry
        -- upvalues: Theme (copy), Skin (copy)
        Theme.button(p1, p2 and Theme.Mint or Theme.Blue);
        Skin.button(p1, "dark", {
            shimmer = false
        });
        Skin.select(p1, p2, Theme.Mint);
        p1.BackgroundTransparency = 0.2;
        p1.TextColor3 = p2 and Theme.Mint or Theme.Paper;
        p1.Font = Enum.Font.GothamBold;
        p1.TextScaled = true;
        p1.TextWrapped = true;
    end
};

local function make(p4, p5, p6, p7) -- Line: 17
    local v8 = p5:FindFirstChild(p6);

    if not v8 then
        v8 = Instance.new(p4);
        v8.Name = p6;
        v8.Parent = p5;
    end;

    for i, v in p7 do
        v8[i] = v;
    end;

    return v8;
end;

local function label(p9, p10, p11, p12) -- Line: 29
    -- upvalues: Skin (copy)
    p9.BackgroundTransparency = 1;
    p9.BorderSizePixel = 0;
    p9.Active = false;
    p9.TextScaled = false;
    p9.TextSize = p10;
    p9.TextColor3 = p11;
    p9.Font = p12 and Enum.Font.GothamBold or Enum.Font.Gotham;
    p9.TextXAlignment = Enum.TextXAlignment.Left;
    p9.TextYAlignment = Enum.TextYAlignment.Center;
    p9.TextWrapped = false;
    p9.TextTruncate = Enum.TextTruncate.AtEnd;
    Skin.textStroke(p9, 1.5);
end;

local function cleanLegacy(p13) -- Line: 43
    p13:SetAttribute("UIProportionalGroup", nil);

    for _, descendant in p13:GetDescendants() do
        if descendant:IsA("UITextSizeConstraint") or (descendant:IsA("UIAspectRatioConstraint") or (descendant:IsA("UISizeConstraint") or (descendant:IsA("UIPadding") or descendant:IsA("UIScale") and descendant.Name == "ProportionalScale"))) then
            descendant:Destroy();
        end;
    end;
end;

function u3.styleRow(p14, p15) -- Line: 57
    -- upvalues: Theme (copy), Skin (copy)
    if p15 then
        p15 = p15.current;
    end;

    if not (p15 and Theme.Mint) then
        local _ = Theme.Blue;
    end;

    Skin.card(p14, p15 and "green" or nil, {
        radius = UDim.new(0, 10)
    });
    p14.BackgroundTransparency = p15 and 0 or 0.2;
    p14.Accent.BackgroundColor3 = p15 and Theme.Mint or Theme.Border;
    p14.Accent.BackgroundTransparency = p15 and 0.12 or 0.65;
    Skin.button(p14.Join, p14.Join.Active and "primary" or "secondary", {
        shimmer = false
    });
    p14.Join.TextTransparency = p15 and 0.1 or (p14.Join.Active and 0 or 0.45);
    p14.Title.TextColor3 = p15 and Theme.Mint or Theme.Paper;
end;

function u3.apply(p16) -- Line: 69
    -- upvalues: cleanLegacy (copy), Theme (copy), Skin (copy), label (copy), u3 (copy)
    local Panel = p16.Panel;
    local ServerRow = p16.Templates.ServerRow;
    cleanLegacy(Panel);
    cleanLegacy(ServerRow);
    Panel.Active = false;
    Panel.BackgroundTransparency = 0;
    Theme.surface(Panel, Theme.Ink, Theme.Blue, 8, 0.55);
    Skin.panel(Panel, {
        transparency = 0.2,
        radius = UDim.new(0, 12)
    });
    local v17 = {
        Scale = 1
    };
    local Scale = Panel:FindFirstChild("Scale");

    if not Scale then
        Scale = Instance.new("UIScale");
        Scale.Name = "Scale";
        Scale.Parent = Panel;
    end;

    for i, v in v17 do
        Scale[i] = v;
    end;

    local v18 = {
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 3),
        BackgroundColor3 = Theme.Blue
    };
    local TopRule = Panel:FindFirstChild("TopRule");

    if not TopRule then
        TopRule = Instance.new("Frame");
        TopRule.Name = "TopRule";
        TopRule.Parent = Panel;
    end;

    for i, v in v18 do
        TopRule[i] = v;
    end;

    Panel.TopRule.BackgroundTransparency = 1;
    local v19 = {
        Text = "VALLEY RUN  /  FIND YOUR PEOPLE"
    };
    local Eyebrow = Panel:FindFirstChild("Eyebrow");

    if not Eyebrow then
        Eyebrow = Instance.new("TextLabel");
        Eyebrow.Name = "Eyebrow";
        Eyebrow.Parent = Panel;
    end;

    for i, v in v19 do
        Eyebrow[i] = v;
    end;

    label(Eyebrow, 11, Theme.Gold, true);
    label(Panel.Title, 28, Theme.Paper, true);
    Panel.Title.Text = "SERVER LIST";
    label(Panel.Connection, 12, Theme.Mint, true);
    local v20 = {
        BackgroundTransparency = 0.78,
        BorderSizePixel = 0,
        BackgroundColor3 = Theme.Blue
    };
    local HeaderRule = Panel:FindFirstChild("HeaderRule");

    if not HeaderRule then
        HeaderRule = Instance.new("Frame");
        HeaderRule.Name = "HeaderRule";
        HeaderRule.Parent = Panel;
    end;

    for i, v in v20 do
        HeaderRule[i] = v;
    end;

    Skin.band(Panel.HeaderRule, {
        color = Skin.Palette.neutral
    });
    Panel.HeaderRule.BackgroundTransparency = 0;
    local v21 = {
        Text = "PUBLIC SERVERS"
    };
    local Count = Panel:FindFirstChild("Count");

    if not Count then
        Count = Instance.new("TextLabel");
        Count.Name = "Count";
        Count.Parent = Panel;
    end;

    for i, v in v21 do
        Count[i] = v;
    end;

    label(Count, 11, Theme.Muted, true);
    local v22 = {
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 3,
        ClipsDescendants = true,
        CanvasSize = UDim2.new(),
        ScrollBarImageColor3 = Theme.Blue
    };
    local Countries = Panel:FindFirstChild("Countries");

    if not Countries then
        Countries = Instance.new("ScrollingFrame");
        Countries.Name = "Countries";
        Countries.Parent = Panel;
    end;

    for i, v in v22 do
        Countries[i] = v;
    end;

    Skin.scroll(Countries);
    local v23 = {
        Padding = UDim.new(0, 7),
        SortOrder = Enum.SortOrder.LayoutOrder
    };
    local Layout = Countries:FindFirstChild("Layout");

    if not Layout then
        Layout = Instance.new("UIListLayout");
        Layout.Name = "Layout";
        Layout.Parent = Countries;
    end;

    for i, v in v23 do
        Layout[i] = v;
    end;

    local v24 = {
        Text = "‹ PREVIOUS"
    };
    local PreviousPage = Panel:FindFirstChild("PreviousPage");

    if not PreviousPage then
        PreviousPage = Instance.new("TextButton");
        PreviousPage.Name = "PreviousPage";
        PreviousPage.Parent = Panel;
    end;

    for i, v in v24 do
        PreviousPage[i] = v;
    end;

    local v25 = {
        Text = "NEXT ›"
    };
    local NextPage = Panel:FindFirstChild("NextPage");

    if not NextPage then
        NextPage = Instance.new("TextButton");
        NextPage.Name = "NextPage";
        NextPage.Parent = Panel;
    end;

    for i, v in v25 do
        NextPage[i] = v;
    end;

    local v26 = {
        Text = "PAGE 1 / 1"
    };
    local PageLabel = Panel:FindFirstChild("PageLabel");

    if not PageLabel then
        PageLabel = Instance.new("TextLabel");
        PageLabel.Name = "PageLabel";
        PageLabel.Parent = Panel;
    end;

    for i, v in v26 do
        PageLabel[i] = v;
    end;

    label(PageLabel, 12, Theme.Paper, true);
    PageLabel.TextXAlignment = Enum.TextXAlignment.Center;

    for _, v in { "Close", "Refresh", "Sort", "PreviousPage", "NextPage" } do
        local v27 = Panel[v];
        v27.TextScaled = false;
        v27.TextSize = v == "Close" and 27 or 13;
        v27.BackgroundTransparency = 0;
        Theme.button(v27, Theme.Blue);
        Skin.button(v27, v == "Close" and "close" or (v == "Refresh" and "primary" or (v == "Sort" and "dark" or "secondary")), {
            shimmer = false
        });
        v27.TextWrapped = false;
        v27.TextXAlignment = Enum.TextXAlignment.Center;
    end;

    Panel.Close.Modal = true;
    Panel.Close.Text = "×";
    local Explanation = Panel.Explanation;
    local Muted = Theme.Muted;
    Explanation.BackgroundTransparency = 1;
    Explanation.BorderSizePixel = 0;
    Explanation.Active = false;
    Explanation.TextScaled = false;
    Explanation.TextSize = 12;
    Explanation.TextColor3 = Muted;
    Explanation.Font = Enum.Font.Gotham;
    Explanation.TextXAlignment = Enum.TextXAlignment.Left;
    Explanation.TextYAlignment = Enum.TextYAlignment.Center;
    Explanation.TextWrapped = false;
    Explanation.TextTruncate = Enum.TextTruncate.AtEnd;
    Skin.textStroke(Explanation, 1.5);
    Panel.Explanation.Text = "Your ping is live. Other pings are player averages, updated about every 20s. Locations are approximate.";
    Panel.Explanation.TextWrapped = true;
    Panel.Explanation.TextTruncate = Enum.TextTruncate.None;
    local Status = Panel.Status;
    local Gold = Theme.Gold;
    Status.BackgroundTransparency = 1;
    Status.BorderSizePixel = 0;
    Status.Active = false;
    Status.TextScaled = false;
    Status.TextSize = 12;
    Status.TextColor3 = Gold;
    Status.Font = Enum.Font.Gotham;
    Status.TextXAlignment = Enum.TextXAlignment.Left;
    Status.TextYAlignment = Enum.TextYAlignment.Center;
    Status.TextWrapped = false;
    Status.TextTruncate = Enum.TextTruncate.AtEnd;
    Skin.textStroke(Status, 1.5);
    Panel.Status.TextWrapped = true;
    Panel.Status.TextTruncate = Enum.TextTruncate.None;
    local Empty = Panel.Empty;
    local Muted2 = Theme.Muted;
    Empty.BackgroundTransparency = 1;
    Empty.BorderSizePixel = 0;
    Empty.Active = false;
    Empty.TextScaled = false;
    Empty.TextSize = 15;
    Empty.TextColor3 = Muted2;
    Empty.Font = Enum.Font.Gotham;
    Empty.TextXAlignment = Enum.TextXAlignment.Left;
    Empty.TextYAlignment = Enum.TextYAlignment.Center;
    Empty.TextWrapped = false;
    Empty.TextTruncate = Enum.TextTruncate.AtEnd;
    Skin.textStroke(Empty, 1.5);
    Panel.Empty.TextXAlignment = Enum.TextXAlignment.Center;
    Panel.Empty.TextWrapped = true;
    Panel.List.Active = true;
    Panel.List.BackgroundTransparency = 1;
    Panel.List.BorderSizePixel = 0;
    Panel.List.ClipsDescendants = true;
    Panel.List.ScrollingDirection = Enum.ScrollingDirection.Y;
    Panel.List.ScrollingEnabled = true;
    Panel.List.AutomaticCanvasSize = Enum.AutomaticSize.Y;
    Panel.List.CanvasSize = UDim2.new();
    Panel.List.ScrollBarThickness = 4;
    Panel.List.ScrollBarImageColor3 = Theme.Blue;
    Skin.scroll(Panel.List);
    Panel.List.VerticalScrollBarInset = Enum.ScrollBarInset.Always;
    Panel.List.Layout.Padding = UDim.new(0, 10);
    Panel.List.Layout.SortOrder = Enum.SortOrder.LayoutOrder;
    local List = Panel.List;
    local v28 = {
        PaddingTop = UDim.new(0, 2),
        PaddingBottom = UDim.new(0, 4),
        PaddingLeft = UDim.new(0, 1),
        PaddingRight = UDim.new(0, 8)
    };
    local Padding = List:FindFirstChild("Padding");

    if not Padding then
        Padding = Instance.new("UIPadding");
        Padding.Name = "Padding";
        Padding.Parent = List;
    end;

    for i, v in v28 do
        Padding[i] = v;
    end;

    ServerRow.Size = UDim2.new(1, 0, 0, 112);
    ServerRow.Active = false;
    ServerRow.BorderSizePixel = 0;
    local v29 = {
        BorderSizePixel = 0,
        Position = UDim2.fromOffset(0, 12),
        Size = UDim2.new(0, 2, 1, -24)
    };
    local Accent = ServerRow:FindFirstChild("Accent");

    if not Accent then
        Accent = Instance.new("Frame");
        Accent.Name = "Accent";
        Accent.Parent = ServerRow;
    end;

    for i, v in v29 do
        Accent[i] = v;
    end;

    local Title = ServerRow.Title;
    local Paper = Theme.Paper;
    Title.BackgroundTransparency = 1;
    Title.BorderSizePixel = 0;
    Title.Active = false;
    Title.TextScaled = false;
    Title.TextSize = 16;
    Title.TextColor3 = Paper;
    Title.Font = Enum.Font.GothamBold or Enum.Font.Gotham;
    Title.TextXAlignment = Enum.TextXAlignment.Left;
    Title.TextYAlignment = Enum.TextYAlignment.Center;
    Title.TextWrapped = false;
    Title.TextTruncate = Enum.TextTruncate.AtEnd;
    Skin.textStroke(Title, 1.5);
    local Details = ServerRow.Details;
    local Muted3 = Theme.Muted;
    Details.BackgroundTransparency = 1;
    Details.BorderSizePixel = 0;
    Details.Active = false;
    Details.TextScaled = false;
    Details.TextSize = 13;
    Details.TextColor3 = Muted3;
    Details.Font = Enum.Font.Gotham;
    Details.TextXAlignment = Enum.TextXAlignment.Left;
    Details.TextYAlignment = Enum.TextYAlignment.Center;
    Details.TextWrapped = false;
    Details.TextTruncate = Enum.TextTruncate.AtEnd;
    Skin.textStroke(Details, 1.5);
    local Region = ServerRow.Region;
    local Muted4 = Theme.Muted;
    Region.BackgroundTransparency = 1;
    Region.BorderSizePixel = 0;
    Region.Active = false;
    Region.TextScaled = false;
    Region.TextSize = 12;
    Region.TextColor3 = Muted4;
    Region.Font = Enum.Font.Gotham;
    Region.TextXAlignment = Enum.TextXAlignment.Left;
    Region.TextYAlignment = Enum.TextYAlignment.Center;
    Region.TextWrapped = false;
    Region.TextTruncate = Enum.TextTruncate.AtEnd;
    Skin.textStroke(Region, 1.5);
    local Ping = ServerRow.Ping;
    local Gold2 = Theme.Gold;
    Ping.BackgroundTransparency = 1;
    Ping.BorderSizePixel = 0;
    Ping.Active = false;
    Ping.TextScaled = false;
    Ping.TextSize = 12;
    Ping.TextColor3 = Gold2;
    Ping.Font = Enum.Font.GothamBold or Enum.Font.Gotham;
    Ping.TextXAlignment = Enum.TextXAlignment.Left;
    Ping.TextYAlignment = Enum.TextYAlignment.Center;
    Ping.TextWrapped = false;
    Ping.TextTruncate = Enum.TextTruncate.AtEnd;
    Skin.textStroke(Ping, 1.5);
    ServerRow.Title.Position = UDim2.fromOffset(16, 12);
    ServerRow.Title.Size = UDim2.new(1, -156, 0, 23);
    ServerRow.Details.Position = UDim2.fromOffset(16, 40);
    ServerRow.Details.Size = UDim2.new(1, -156, 0, 22);
    ServerRow.Region.Position = UDim2.fromOffset(16, 82);
    ServerRow.Region.Size = UDim2.new(1, -178, 0, 18);
    ServerRow.Ping.AnchorPoint = Vector2.new(1, 0);
    ServerRow.Ping.Position = UDim2.new(1, -14, 0, 82);
    ServerRow.Ping.Size = UDim2.fromOffset(144, 18);
    ServerRow.Ping.TextXAlignment = Enum.TextXAlignment.Right;
    ServerRow.Join.AnchorPoint = Vector2.new(1, 0);
    ServerRow.Join.Position = UDim2.new(1, -14, 0, 18);
    ServerRow.Join.Size = UDim2.fromOffset(116, 44);
    ServerRow.Join.TextScaled = false;
    ServerRow.Join.TextSize = 14;
    ServerRow.Join.TextWrapped = false;
    u3.styleRow(ServerRow);
end;

function u3.layout(p30) -- Line: 179
    local AbsoluteSize = p30.AbsoluteSize;

    if AbsoluteSize.X <= 0 or AbsoluteSize.Y <= 0 then
        return;
    end;

    local v31 = AbsoluteSize.X / AbsoluteSize.Y < 1.1;
    local v32 = not v31 and AbsoluteSize.Y < 500;
    local v33 = v31 and 460 or 980;
    local v34 = v31 and 720 or (v32 and 430 or 620);
    local Panel = p30.Panel;
    Panel.Size = UDim2.fromOffset(v33, v34);
    Panel.AnchorPoint = Vector2.new(0.5, 0.5);
    local v35 = game:GetService("GuiService"):GetGuiInset().Y + 6;
    local math_max_ret = math.max(14, v35);
    local math_max_ret2 = math.max(120, AbsoluteSize.Y - math_max_ret - 14);
    Panel.Position = UDim2.new(0.5, 0, 0, math_max_ret + math_max_ret2 * 0.5);
    Panel.Scale.Scale = math.min(1.05, AbsoluteSize.X * 0.94 / v33, math_max_ret2 / v34);
    Panel.Eyebrow.Position = UDim2.fromOffset(24, v32 and 14 or 20);
    Panel.Eyebrow.Size = UDim2.fromOffset(v33 - 112, 18);
    Panel.Title.Position = UDim2.fromOffset(24, v32 and 34 or 44);
    Panel.Title.Size = UDim2.fromOffset(v33 - 104, 38);
    Panel.Close.AnchorPoint = Vector2.zero;
    Panel.Close.Position = UDim2.fromOffset(v33 - 68, v32 and 14 or 20);
    Panel.Close.Size = UDim2.fromOffset(44, 44);
    Panel.Connection.Position = UDim2.fromOffset(24, v32 and 79 or 98);
    Panel.Connection.Size = UDim2.fromOffset(v33 - 48, 22);
    Panel.HeaderRule.Position = UDim2.fromOffset(24, v32 and 110 or 135);
    Panel.HeaderRule.Size = UDim2.fromOffset(v33 - 48, 1);
    local v36 = v32 and 120 or 148;
    Panel.Sort.Position = UDim2.fromOffset(24, v36);
    Panel.Sort.Size = UDim2.fromOffset(v31 and 200 or 212, 36);
    Panel.Refresh.Position = UDim2.fromOffset(v33 - 144, v36);
    Panel.Refresh.Size = UDim2.fromOffset(120, 36);
    Panel.Count.Visible = not v31;
    Panel.Count.Position = UDim2.fromOffset(252, v36);
    Panel.Count.Size = UDim2.fromOffset(v33 - 412, 36);
    local v37 = v32 and 168 or 196;
    local Countries = Panel.Countries;
    Countries.Layout.FillDirection = v31 and Enum.FillDirection.Horizontal or Enum.FillDirection.Vertical;
    Countries.AutomaticCanvasSize = v31 and Enum.AutomaticSize.X or Enum.AutomaticSize.Y;
    Countries.ScrollingDirection = v31 and Enum.ScrollingDirection.X or Enum.ScrollingDirection.Y;
    Countries.CanvasSize = UDim2.new();
    Countries.Position = UDim2.fromOffset(24, v37);
    Countries.Size = UDim2.fromOffset(v31 and (v33 - 48 or 174) or 174, v31 and 46 or v34 - v37 - 104);

    for _, child in Countries:GetChildren() do
        if child:IsA("TextButton") then
            child.Size = v31 and UDim2.fromOffset(140, 38) or UDim2.new(1, -8, 0, 42);
        end;
    end;

    local v38 = v31 and 24 or 216;
    local v39 = v37 + (v31 and 56 or 0);
    Panel.List.Position = UDim2.fromOffset(v38, v39);
    Panel.List.Size = UDim2.fromOffset(v33 - v38 - 24, v34 - v39 - 144);
    Panel.PreviousPage.Position = UDim2.fromOffset(v38, v34 - 134);
    Panel.PreviousPage.Size = UDim2.fromOffset(116, 30);
    Panel.NextPage.Position = UDim2.fromOffset(v33 - 140, v34 - 134);
    Panel.NextPage.Size = UDim2.fromOffset(116, 30);
    Panel.PageLabel.Position = UDim2.fromOffset(v38 + 120, v34 - 134);
    Panel.PageLabel.Size = UDim2.fromOffset(v33 - v38 - 264, 30);
    Panel.Empty.Position = Panel.List.Position;
    Panel.Empty.Size = Panel.List.Size;
    Panel.Explanation.Position = UDim2.fromOffset(24, v34 - 92);
    Panel.Explanation.Size = UDim2.fromOffset(v33 - 48, 38);
    Panel.Status.Position = UDim2.fromOffset(24, v34 - 46);
    Panel.Status.Size = UDim2.fromOffset(v33 - 48, 32);
end;

return u3;