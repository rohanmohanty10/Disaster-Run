 

 

local Skin = require(game:GetService("ReplicatedStorage"):WaitForChild("ChickenOrHero"):WaitForChild("OldUIReskin"):WaitForChild("Skin"));
local Theme = Skin.Theme;
local row = Skin.Palette.row;
local u1 = Theme.Ink:Lerp(Color3.fromHex("365B79"), 0.5);
local u2 = Theme.Ink:Lerp(Color3.fromHex("7F6827"), 0.5);
local u3 = {};

local function make(p4, p5, p6, p7) -- Line: 9
    local v8 = p5:FindFirstChild(p6) or Instance.new(p4);
    v8.Name = p6;

    for i, v in p7 do
        v8[i] = v;
    end;

    v8.Parent = p5;

    return v8;
end;

local function text(p9, p10, p11, p12) -- Line: 13
    -- upvalues: Theme (copy), Skin (copy)
    p9.BackgroundTransparency = 1;
    p9.BorderSizePixel = 0;
    p9.Active = false;
    p9.TextScaled = false;
    p9.TextSize = p10;
    p9.Font = p12 and Enum.Font.GothamBold or Enum.Font.Gotham;
    p9.TextColor3 = p11 or Theme.Paper;
    p9.TextStrokeColor3 = Theme.Ink;
    p9.TextStrokeTransparency = 0.45;
    p9.TextWrapped = false;
    p9.TextTruncate = Enum.TextTruncate.AtEnd;
    p9.TextXAlignment = Enum.TextXAlignment.Left;
    Skin.textStroke(p9, 1.5);
end;

function u3.card(p13) -- Line: 20
    -- upvalues: Theme (copy), row (copy), Skin (copy), text (copy)
    p13.Text = "";
    p13.AutoButtonColor = false;
    p13.Active = true;
    p13.Modal = true;
    p13.BackgroundTransparency = 0.1;
    Theme.button(p13, Theme.Blue, row);
    Skin.ring(p13, Skin.Palette.neutral, 2);
    p13.Border.Transparency = 0;
    p13.Avatar.BackgroundTransparency = 1;
    p13.Avatar.Active = false;
    p13.Avatar.Position = UDim2.fromOffset(6, 6);
    p13.Avatar.Size = UDim2.fromOffset(32, 32);
    local v14 = p13.Avatar:FindFirstChildOfClass("UICorner") or Instance.new("UICorner");
    v14.CornerRadius = UDim.new(0, 4);
    v14.Parent = p13.Avatar;
    text(p13.Title, 14, Theme.Paper, true);
    text(p13.Description, 10, Theme.Paper, false);
    p13.Title.Position = UDim2.fromOffset(46, 5);
    p13.Title.Size = UDim2.new(1, -72, 0, 18);
    p13.Description.Position = UDim2.fromOffset(46, 23);
    p13.Description.Size = UDim2.new(1, -72, 0, 16);
    local v15 = {
        Text = "›",
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, -8, 0.5, 0),
        Size = UDim2.fromOffset(16, 24)
    };
    local v16 = p13:FindFirstChild("Choose") or Instance.new("TextLabel");
    v16.Name = "Choose";

    for i, v in v15 do
        v16[i] = v;
    end;

    v16.Parent = p13;
    text(v16, 20, Theme.Blue, true);
    v16.TextXAlignment = Enum.TextXAlignment.Center;
    local Avatar = p13.Avatar;
    local v17 = {
        Text = "?",
        Size = UDim2.fromScale(1, 1)
    };
    local v18 = Avatar:FindFirstChild("Fallback") or Instance.new("TextLabel");
    v18.Name = "Fallback";

    for i, v in v17 do
        v18[i] = v;
    end;

    v18.Parent = Avatar;
    text(v18, 18, Theme.Muted, true);
    v18.TextXAlignment = Enum.TextXAlignment.Center;
    v18.Visible = false;
end;

function u3.apply(p19) -- Line: 34
    -- upvalues: Theme (copy), text (copy), Skin (copy), u2 (copy), u3 (copy), u1 (copy)
    local Choices = p19.MainFrame.Choices;
    Choices:SetAttribute("UIProportionalGroup", nil);

    for _, v in { Choices, p19.Templates.ChoiceOption } do
        for _, descendant in v:GetDescendants() do
            if descendant:IsA("UITextSizeConstraint") or (descendant:IsA("UISizeConstraint") or (descendant:IsA("UIAspectRatioConstraint") or descendant:IsA("UIScale") and descendant.Name == "ProportionalScale")) then
                descendant:Destroy();
            end;
        end;
    end;

    Choices.Active = false;
    Choices.BackgroundTransparency = 1;
    Theme.surface(Choices, Theme.Ink, Theme.Gold, 6, 1);
    Choices.Border.Enabled = false;
    local v20 = Choices:FindFirstChild("ChoiceScale") or Instance.new("UIScale");
    v20.Name = "ChoiceScale";

    for i, v in {
        Scale = 1
    } do
        v20[i] = v;
    end;

    v20.Parent = Choices;
    Choices.HeaderBackground.Visible = false;
    local v21 = Choices:FindFirstChild("TopRule") or Instance.new("Frame");
    v21.Name = "TopRule";

    for i, v in {
        Visible = false
    } do
        v21[i] = v;
    end;

    v21.Parent = Choices;
    local v22 = Choices:FindFirstChild("Eyebrow") or Instance.new("TextLabel");
    v22.Name = "Eyebrow";

    for i, v in {
        Text = "",
        Visible = false
    } do
        v22[i] = v;
    end;

    v22.Parent = Choices;
    text(v22, 10, Theme.Gold, true);
    text(Choices.Title, 17, Theme.Paper, true);
    text(Choices.Hint, 11, Theme.Muted, false);
    Choices.Hint.Visible = false;
    text(Choices.Status, 11, Theme.Gold, true);
    Choices.Status.TextXAlignment = Enum.TextXAlignment.Right;
    local v23 = Choices:FindFirstChild("Count") or Instance.new("TextLabel");
    v23.Name = "Count";

    for i, v in {
        Text = ""
    } do
        v23[i] = v;
    end;

    v23.Parent = Choices;
    text(v23, 10, Theme.Paper, false);
    local v24 = {
        Text = "",
        PlaceholderText = "Find a runner…",
        ClearTextOnFocus = false,
        TextSize = 12,
        BackgroundTransparency = 0.58,
        BorderSizePixel = 0,
        MultiLine = false,
        Font = Enum.Font.Gotham,
        TextColor3 = Theme.Paper,
        PlaceholderColor3 = Theme.Paper,
        TextXAlignment = Enum.TextXAlignment.Left
    };
    local v25 = Choices:FindFirstChild("Search") or Instance.new("TextBox");
    v25.Name = "Search";

    for i, v in v24 do
        v25[i] = v;
    end;

    v25.Parent = Choices;
    Theme.surface(v25, Theme.Ink, Theme.Blue, 4, 0.8);
    Skin.input(v25);
    v25.BackgroundTransparency = 0.15;
    local v26 = {
        PaddingLeft = UDim.new(0, 10),
        PaddingRight = UDim.new(0, 10)
    };
    local v27 = v25:FindFirstChild("Inset") or Instance.new("UIPadding");
    v27.Name = "Inset";

    for i, v in v26 do
        v27[i] = v;
    end;

    v27.Parent = v25;
    local v28 = Choices:FindFirstChild("Random") or Instance.new("TextButton");
    v28.Name = "Random";

    for i, v in {
        Text = "RANDOM",
        AutoButtonColor = false,
        Modal = true,
        Visible = false
    } do
        v28[i] = v;
    end;

    v28.Parent = Choices;
    text(v28, 12, Theme.Gold, true);
    v28.Active = true;
    v28.TextXAlignment = Enum.TextXAlignment.Center;
    Theme.button(v28, Theme.Gold, u2);
    Skin.ring(v28, Theme.Gold, 2);
    v28.Border.Transparency = 0;
    v28.BackgroundTransparency = 0;
    v28.TextColor3 = Theme.Gold;
    local Options = Choices.PlayerPicker.Options;
    Options.Active = true;
    Options.BackgroundTransparency = 1;
    Options.ScrollingEnabled = true;
    Options.ScrollingDirection = Enum.ScrollingDirection.Y;
    Options.AutomaticCanvasSize = Enum.AutomaticSize.Y;
    Options.CanvasSize = UDim2.new();
    Options.ClipsDescendants = true;
    Options.ScrollBarThickness = 3;
    Options.ScrollBarImageColor3 = Theme.Blue;
    Skin.scroll(Options);
    Options.VerticalScrollBarInset = Enum.ScrollBarInset.Always;
    local Layout = Options:FindFirstChild("Layout");

    if Layout and not Layout:IsA("UIGridLayout") then
        Layout:Destroy();
        Layout = nil;
    end;

    local v29 = Layout or Instance.new("UIGridLayout");
    v29.Name = "Layout";
    v29.SortOrder = Enum.SortOrder.LayoutOrder;
    v29.FillDirection = Enum.FillDirection.Horizontal;
    v29.FillDirectionMaxCells = 1;
    v29.CellPadding = UDim2.fromOffset(0, 6);
    v29.Parent = Options;
    v29.CellSize = UDim2.new(1, -8, 0, 44);
    local v30 = {
        PaddingLeft = UDim.new(0, 1),
        PaddingTop = UDim.new(0, 1),
        PaddingRight = UDim.new(0, 5),
        PaddingBottom = UDim.new(0, 4)
    };
    local v31 = Options:FindFirstChild("Padding") or Instance.new("UIPadding");
    v31.Name = "Padding";

    for i, v in v30 do
        v31[i] = v;
    end;

    v31.Parent = Options;
    local PlayerPicker = Choices.PlayerPicker;
    local v32 = {
        Text = "No matching runners.",
        Visible = false,
        Size = UDim2.fromScale(1, 1)
    };
    local v33 = PlayerPicker:FindFirstChild("Empty") or Instance.new("TextLabel");
    v33.Name = "Empty";

    for i, v in v32 do
        v33[i] = v;
    end;

    v33.Parent = PlayerPicker;
    text(v33, 13, Theme.Paper, false);
    v33.TextXAlignment = Enum.TextXAlignment.Center;
    Choices.PlayerPicker.BackgroundTransparency = 1;
    Choices.RunnerChoice.BackgroundTransparency = 1;
    Choices.RunnerChoice.Options.BackgroundTransparency = 1;
    u3.card(p19.Templates.ChoiceOption);

    for _, v in { "Chicken", "Hero" } do
        local v34 = Choices.RunnerChoice.Options[v];
        v34.AutoButtonColor = false;
        v34.Modal = true;
        v34.Active = true;
        v34.BackgroundTransparency = 0;
        local v35 = v == "Hero" and Theme.Gold or Theme.Blue;
        Theme.button(v34, v35, v == "Hero" and u2 or u1);
        Skin.ring(v34, v35, 2);
        v34.Border.Transparency = 0;
        text(v34.Title, 17, v35, true);
        text(v34.Description, 11, Theme.Paper, false);
        v34.Description.TextWrapped = true;
        v34.Description.TextTruncate = Enum.TextTruncate.None;
        v34.Description.TextYAlignment = Enum.TextYAlignment.Top;
        v34.Eyebrow.Visible = false;
        v34.Accent.Visible = false;
    end;
end;

function u3.selected(p36, p37) -- Line: 81
    -- upvalues: row (copy), Theme (copy), Skin (copy)
    p36.BackgroundColor3 = p37 and row:Lerp(Theme.Mint, 0.15) or row;
    p36.Border.Color = p37 and Theme.Mint or Skin.Palette.neutral;
    p36.Border.Transparency = 0;

    if p36:FindFirstChild("Choose") then
        p36.Choose.Text = p37 and "✓" or "›";
        p36.Choose.TextColor3 = p37 and Theme.Mint or Theme.Blue;
    end;
end;

function u3.layout(p38, p39) -- Line: 86
    local Choices = p38.MainFrame.Choices;
    local AbsoluteSize = p38.MainFrame.AbsoluteSize;

    if AbsoluteSize.X < 1 or AbsoluteSize.Y < 1 then
        return;
    end;

    local v40 = p39 == "choice";
    local v41;

    if v40 then
        local math_max_ret = math.max(300, AbsoluteSize.X * 0.4);
        v41 = math.min(420, math_max_ret, AbsoluteSize.X - 32) or math.min(360, AbsoluteSize.X - 56);
    else
        v41 = math.min(360, AbsoluteSize.X - 56);
    end;

    local v42;

    if v40 then
        v42 = 124;
    else
        local math_max_ret = math.max(176, AbsoluteSize.Y * 0.34);
        v42 = math.min(258, math_max_ret);
    end;

    local NotificationsF = p38.MainFrame.NotificationsF;
    local math_max_ret = math.max(8, NotificationsF.AbsolutePosition.Y + NotificationsF.AbsoluteSize.Y - p38.MainFrame.AbsolutePosition.Y + 10);
    local math_min_ret = math.min(1, (AbsoluteSize.X - 24) / v41, (AbsoluteSize.Y - 24) / v42);
    Choices.Size = UDim2.fromOffset(v41, v42);
    Choices.AnchorPoint = Vector2.new(0.5, 0);
    local UDim2_new = UDim2.new;
    local math_max_ret2 = math.max(math_max_ret, AbsoluteSize.Y * 0.42 - v42 * math_min_ret * 0.5);
    local math_max_ret3 = math.max(8, AbsoluteSize.Y - v42 * math_min_ret - 12);
    Choices.Position = UDim2_new(0.5, 0, 0, (math.clamp(math_max_ret2, 8, math_max_ret3)));
    Choices.ChoiceScale.Scale = math_min_ret * (Choices.Reveal.Value or 1);
    Choices.Hint.Visible = false;
    Choices.Eyebrow.Visible = false;
    Choices.TopRule.Visible = false;
    Choices.Title.Position = UDim2.fromOffset(2, 0);
    Choices.Title.Size = UDim2.fromOffset(v41 - 106, 24);
    Choices.Title.TextSize = 17;
    Choices.Status.Position = UDim2.fromOffset(v41 - 100, 2);
    Choices.Status.Size = UDim2.fromOffset(98, 22);
    Choices.Status.TextSize = 11;
    Choices.Search.Visible = not v40 and p39 == "select";
    Choices.Count.Visible = not v40 and p39 == "select";
    Choices.Random.Visible = not v40 and p39 == "select";
    Choices.Search.Position = UDim2.fromOffset(0, 28);
    Choices.Search.Size = UDim2.fromOffset(v41 - 92, 30);
    Choices.Random.Position = UDim2.fromOffset(v41 - 86, 28);
    Choices.Random.Size = UDim2.fromOffset(86, 30);
    Choices.PlayerPicker.Position = UDim2.fromOffset(0, 66);
    Choices.PlayerPicker.Size = UDim2.fromOffset(v41, v42 - 88);
    Choices.Count.Position = UDim2.fromOffset(2, v42 - 18);
    Choices.Count.Size = UDim2.fromOffset(v41 - 4, 16);
    Choices:SetAttribute("PickerColumns", 1);
    local RunnerChoice = Choices.RunnerChoice;
    RunnerChoice.Position = UDim2.fromOffset(0, 32);
    RunnerChoice.Size = UDim2.fromOffset(v41, 84);

    for i, v in { "Chicken", "Hero" } do
        local v43 = RunnerChoice.Options[v];
        v43.Position = UDim2.new((i - 1) * 0.5, (i - 1) * 4, 0, 0);
        v43.Size = UDim2.new(0.5, -4, 1, 0);
        v43.Title.Position = UDim2.fromOffset(12, 9);
        v43.Title.Size = UDim2.new(1, -24, 0, 22);
        v43.Description.Position = UDim2.fromOffset(12, 37);
        v43.Description.Size = UDim2.new(1, -24, 0, 38);
        v43.Description.Text = v == "Hero" and "Cross solo.\nSafe? Skip the group run." or "Cross together\nwith the other runners.";
    end;
end;

return u3;