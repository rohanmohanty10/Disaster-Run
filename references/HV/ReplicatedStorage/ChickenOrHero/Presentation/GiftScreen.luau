 

 

local Players = game:GetService("Players");
local GuiService = game:GetService("GuiService");
local UserInputService = game:GetService("UserInputService");
local ChickenOrHero = game:GetService("ReplicatedStorage"):WaitForChild("ChickenOrHero");
local GiftConfig = require(ChickenOrHero:WaitForChild("Weapons"):WaitForChild("GiftConfig"));
local LocalPlayer = Players.LocalPlayer;
local u1 = {};
u1.__index = u1;
local Font_new_ret = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.ExtraBold);
local Color3_fromRGB_ret = Color3.fromRGB(23, 23, 25);
local Color3_fromRGB_ret2 = Color3.fromRGB(30, 30, 33);
local Color3_fromRGB_ret3 = Color3.fromRGB(76, 76, 81);
local Color3_new_ret = Color3.new(1, 1, 1);
local Color3_fromRGB_ret4 = Color3.fromRGB(222, 222, 222);
local Color3_fromRGB_ret5 = Color3.fromRGB(137, 137, 137);
local Color3_fromRGB_ret6 = Color3.fromRGB(255, 202, 58);
local Color3_fromRGB_ret7 = Color3.fromRGB(230, 161, 0);
local Color3_fromRGB_ret8 = Color3.fromRGB(125, 125, 125);
local Color3_fromRGB_ret9 = Color3.fromRGB(80, 80, 80);
local Color3_fromRGB_ret10 = Color3.fromRGB(253, 60, 85);
local Color3_fromRGB_ret11 = Color3.fromRGB(255, 92, 92);
local u2 = {
    Busy = "Finish your other gift first.",
    Unavailable = "Gifting isn\'t available for this right now.",
    Ended = "This offer has ended.",
    InMatch = "Send gifts from the lobby.",
    Loading = "Still loading. Try again in a moment.",
    Self = "Pick someone else.",
    Left = "That player left the server.",
    Waiting = "Your last gifts of this are still going through. Try again soon.",
    Owned = "They already own this.",
    AtLimit = "They can\'t hold any more of that.",
    Reserved = "Someone else is gifting them this right now.",
    Failed = "That didn\'t go through. Try again.",
    Cooldown = "Give it a few seconds before trying that again."
};
local u3 = {
    GIFT = "GIFT",
    OWNS = "OWNS IT",
    UNAVAILABLE = "UNAVAILABLE"
};

local function make(p4, p5, p6, p7) -- Line: 47
    local Instance_new_ret = Instance.new(p4);
    Instance_new_ret.Name = p6;

    for i, v in p7 or {} do
        Instance_new_ret[i] = v;
    end;

    Instance_new_ret.Parent = p5;

    return Instance_new_ret;
end;

local function corner(p8, p9) -- Line: 56
    local UICorner = Instance.new("UICorner");
    UICorner.Name = "UICorner";

    for i, v in {
        CornerRadius = p9
    } or {} do
        UICorner[i] = v;
    end;

    UICorner.Parent = p8;
end;

local function rings(p10, p11, p12, p13) -- Line: 60
    -- upvalues: Color3_fromRGB_ret3 (copy)
    local v14 = {
        Color = Color3.new(0, 0, 0),
        Thickness = p12,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    };
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Name = "Outline";

    for i, v in v14 or {} do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = p10;
    local v15 = {
        Color = p11 or Color3_fromRGB_ret3,
        Thickness = p13,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    };
    local UIStroke2 = Instance.new("UIStroke");
    UIStroke2.Name = "Ring";

    for i, v in v15 or {} do
        UIStroke2[i] = v;
    end;

    UIStroke2.Parent = p10;

    return UIStroke2;
end;

local function label(p16, p17, p18, p19, p20, p21) -- Line: 72
    -- upvalues: Font_new_ret (copy), Color3_new_ret (copy)
    local v22 = {
        BackgroundTransparency = 1,
        FontFace = Font_new_ret,
        Text = p18,
        TextColor3 = p20 or Color3_new_ret,
        TextSize = p19,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextTruncate = Enum.TextTruncate.AtEnd
    };
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Name = p17;

    for i, v in v22 or {} do
        TextLabel[i] = v;
    end;

    TextLabel.Parent = p16;

    for i, v in p21 or {} do
        TextLabel[i] = v;
    end;

    local v23 = {
        Color = Color3.new(0, 0, 0),
        Thickness = math.max(1, p19 / 12)
    };
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Name = "UIStroke";

    for i, v in v23 or {} do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = TextLabel;

    return TextLabel;
end;

local function button(p24, p25, p26, p27) -- Line: 89
    -- upvalues: Color3_new_ret (copy), rings (copy), Color3_fromRGB_ret6 (copy), Color3_fromRGB_ret3 (copy), label (copy), Color3_fromRGB_ret7 (copy), Color3_fromRGB_ret8 (copy), Color3_fromRGB_ret9 (copy)
    local v28 = {
        Text = "",
        AutoButtonColor = true,
        BorderSizePixel = 0,
        BackgroundColor3 = Color3_new_ret
    };
    local TextButton = Instance.new("TextButton");
    TextButton.Name = p25;

    for i, v in v28 or {} do
        TextButton[i] = v;
    end;

    TextButton.Parent = p24;
    local v29 = {
        CornerRadius = UDim.new(0.2, 0)
    };
    local UICorner = Instance.new("UICorner");
    UICorner.Name = "UICorner";

    for i, v in v29 or {} do
        UICorner[i] = v;
    end;

    UICorner.Parent = TextButton;
    local u30 = rings(TextButton, p27 and Color3_fromRGB_ret6 or Color3_fromRGB_ret3, 2, 1.5);
    local UIGradient = Instance.new("UIGradient");
    UIGradient.Name = "UIGradient";

    for i, v in {
        Rotation = 90
    } or {} do
        UIGradient[i] = v;
    end;

    UIGradient.Parent = TextButton;
    local v31 = {
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(1, 1)
    };
    local CanvasGroup = Instance.new("CanvasGroup");
    CanvasGroup.Name = "Texture";

    for i, v in v31 or {} do
        CanvasGroup[i] = v;
    end;

    CanvasGroup.Parent = TextButton;
    local v32 = {
        CornerRadius = UDim.new(0.2, 0)
    };
    local UICorner2 = Instance.new("UICorner");
    UICorner2.Name = "UICorner";

    for i, v in v32 or {} do
        UICorner2[i] = v;
    end;

    UICorner2.Parent = CanvasGroup;
    local v33 = {
        Rotation = 45,
        BackgroundTransparency = 1,
        Image = "rbxassetid://140022482252277",
        ImageTransparency = 0.8,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(1.2, 6),
        ScaleType = Enum.ScaleType.Tile,
        TileSize = UDim2.fromOffset(24, 24)
    };
    local ImageLabel = Instance.new("ImageLabel");
    ImageLabel.Name = "Stripes";

    for i, v in v33 or {} do
        ImageLabel[i] = v;
    end;

    ImageLabel.Parent = CanvasGroup;
    local u34 = label(TextButton, "TextLabel", p26, 16, Color3_new_ret, {
        ZIndex = 3,
        Size = UDim2.fromScale(1, 1),
        TextXAlignment = Enum.TextXAlignment.Center
    });

    local function look(p35) -- Line: 122
        -- upvalues: UIGradient (copy), Color3_fromRGB_ret6 (ref), Color3_fromRGB_ret7 (ref), Color3_fromRGB_ret8 (ref), Color3_fromRGB_ret9 (ref), u30 (copy), Color3_fromRGB_ret3 (ref), CanvasGroup (copy), u34 (copy), Color3_new_ret (ref), TextButton (copy)
        UIGradient.Color = p35 and ColorSequence.new(Color3_fromRGB_ret6, Color3_fromRGB_ret7) or ColorSequence.new(Color3_fromRGB_ret8, Color3_fromRGB_ret9);
        u30.Color = p35 and Color3_fromRGB_ret6 or Color3_fromRGB_ret3;
        CanvasGroup.Visible = p35;
        u34.TextColor3 = p35 and Color3_new_ret or Color3.fromRGB(190, 190, 190);
        TextButton.AutoButtonColor = p35;
    end;

    look(p27);

    return TextButton, u34, look;
end;

function u1.new(p36) -- Line: 133
    -- upvalues: u1 (copy), LocalPlayer (copy), Color3_fromRGB_ret (copy), rings (copy), Color3_fromRGB_ret3 (copy), Color3_new_ret (copy), label (copy), Color3_fromRGB_ret6 (copy), Font_new_ret (copy), Color3_fromRGB_ret10 (copy), Color3_fromRGB_ret4 (copy), Color3_fromRGB_ret5 (copy), Color3_fromRGB_ret7 (copy), Players (copy)
    local u37 = setmetatable({
        open_ = false,
        inflight = false,
        remote = p36,
        rows = {},
        statuses = {}
    }, u1);
    local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");
    local v38 = {
        ResetOnSpawn = false,
        IgnoreGuiInset = true,
        DisplayOrder = 85,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    };
    local ScreenGui = Instance.new("ScreenGui");
    ScreenGui.Name = "ValleyGift";

    for i, v in v38 or {} do
        ScreenGui[i] = v;
    end;

    ScreenGui.Parent = PlayerGui;
    ScreenGui:SetAttribute("SelfManagedText", true);
    u37.gui = ScreenGui;
    local v39 = {
        Text = "",
        AutoButtonColor = false,
        BackgroundTransparency = 0.45,
        Visible = false,
        Selectable = false,
        Size = UDim2.fromScale(1, 1),
        BackgroundColor3 = Color3.new(0, 0, 0)
    };
    local TextButton = Instance.new("TextButton");
    TextButton.Name = "Backdrop";

    for i, v in v39 or {} do
        TextButton[i] = v;
    end;

    TextButton.Parent = ScreenGui;
    TextButton.Activated:Connect(function() -- Line: 153
        -- upvalues: u37 (copy)
        u37:close();
    end);
    u37.backdrop = TextButton;
    local v40 = {
        BackgroundTransparency = 0.04,
        Visible = false,
        Active = true,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromOffset(460, 560),
        BackgroundColor3 = Color3_fromRGB_ret
    };
    local Frame = Instance.new("Frame");
    Frame.Name = "Panel";

    for i, v in v40 or {} do
        Frame[i] = v;
    end;

    Frame.Parent = ScreenGui;
    local v41 = {
        CornerRadius = UDim.new(0, 16)
    };
    local UICorner = Instance.new("UICorner");
    UICorner.Name = "UICorner";

    for i, v in v41 or {} do
        UICorner[i] = v;
    end;

    UICorner.Parent = Frame;
    rings(Frame, Color3_fromRGB_ret3, 3, 2);
    local UIScale = Instance.new("UIScale");
    UIScale.Name = "Scale";

    for i, v in {} do
        UIScale[i] = v;
    end;

    UIScale.Parent = Frame;
    u37.scale = UIScale;
    u37.panel = Frame;
    local v42 = {
        BackgroundTransparency = 1,
        Image = "rbxassetid://115583741443536",
        Position = UDim2.fromOffset(22, 18),
        Size = UDim2.fromOffset(46, 46),
        ScaleType = Enum.ScaleType.Fit
    };
    local ImageLabel = Instance.new("ImageLabel");
    ImageLabel.Name = "Icon";

    for i, v in v42 or {} do
        ImageLabel[i] = v;
    end;

    ImageLabel.Parent = Frame;
    ImageLabel.ImageColor3 = Color3_new_ret;
    label(Frame, "Eyebrow", "GIFT", 14, Color3_fromRGB_ret6, {
        Position = UDim2.fromOffset(78, 18),
        Size = UDim2.fromOffset(300, 18)
    });
    u37.title = label(Frame, "Title", "", 26, Color3_new_ret, {
        Position = UDim2.fromOffset(78, 36),
        Size = UDim2.fromOffset(320, 32)
    });
    local v43 = {
        Text = "×",
        TextSize = 34,
        BackgroundTransparency = 1,
        FontFace = Font_new_ret,
        TextColor3 = Color3_fromRGB_ret10,
        Position = UDim2.fromOffset(410, 12),
        Size = UDim2.fromOffset(38, 38)
    };
    local TextButton2 = Instance.new("TextButton");
    TextButton2.Name = "Close";

    for i, v in v43 or {} do
        TextButton2[i] = v;
    end;

    TextButton2.Parent = Frame;
    local v44 = {
        Thickness = 2,
        Color = Color3.new(0, 0, 0)
    };
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Name = "UIStroke";

    for i, v in v44 or {} do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = TextButton2;
    TextButton2.Activated:Connect(function() -- Line: 190
        -- upvalues: u37 (copy)
        u37:close();
    end);
    label(Frame, "Description", "Pick who gets it. You pay, and it\'s theirs to keep.", 14, Color3_fromRGB_ret4, {
        Position = UDim2.fromOffset(24, 78),
        Size = UDim2.fromOffset(412, 18)
    });
    local v45 = {
        TextSize = 16,
        PlaceholderText = "Search players",
        Text = "",
        ClearTextOnFocus = false,
        Position = UDim2.fromOffset(24, 106),
        Size = UDim2.fromOffset(412, 40),
        BackgroundColor3 = Color3.fromRGB(15, 15, 17),
        FontFace = Font_new_ret,
        TextColor3 = Color3_new_ret,
        PlaceholderColor3 = Color3_fromRGB_ret5,
        TextXAlignment = Enum.TextXAlignment.Left
    };
    local TextBox = Instance.new("TextBox");
    TextBox.Name = "Search";

    for i, v in v45 or {} do
        TextBox[i] = v;
    end;

    TextBox.Parent = Frame;
    local v46 = {
        CornerRadius = UDim.new(0, 10)
    };
    local UICorner2 = Instance.new("UICorner");
    UICorner2.Name = "UICorner";

    for i, v in v46 or {} do
        UICorner2[i] = v;
    end;

    UICorner2.Parent = TextBox;
    rings(TextBox, Color3_fromRGB_ret3, 2, 1);
    local v47 = {
        PaddingLeft = UDim.new(0, 14),
        PaddingRight = UDim.new(0, 14)
    };
    local UIPadding = Instance.new("UIPadding");
    UIPadding.Name = "Padding";

    for i, v in v47 or {} do
        UIPadding[i] = v;
    end;

    UIPadding.Parent = TextBox;
    TextBox:GetPropertyChangedSignal("Text"):Connect(function() -- Line: 213
        -- upvalues: u37 (copy)
        u37:refresh();
    end);
    u37.search = TextBox;
    local v48 = {
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 6,
        Position = UDim2.fromOffset(24, 158),
        Size = UDim2.fromOffset(412, 318),
        ScrollBarImageColor3 = Color3_fromRGB_ret3,
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        CanvasSize = UDim2.new(),
        ScrollingDirection = Enum.ScrollingDirection.Y
    };
    local ScrollingFrame = Instance.new("ScrollingFrame");
    ScrollingFrame.Name = "List";

    for i, v in v48 or {} do
        ScrollingFrame[i] = v;
    end;

    ScrollingFrame.Parent = Frame;
    local v49 = {
        Padding = UDim.new(0, 8),
        SortOrder = Enum.SortOrder.LayoutOrder
    };
    local UIListLayout = Instance.new("UIListLayout");
    UIListLayout.Name = "Layout";

    for i, v in v49 or {} do
        UIListLayout[i] = v;
    end;

    UIListLayout.Parent = ScrollingFrame;
    local v50 = {
        PaddingRight = UDim.new(0, 10)
    };
    local UIPadding2 = Instance.new("UIPadding");
    UIPadding2.Name = "Padding";

    for i, v in v50 or {} do
        UIPadding2[i] = v;
    end;

    UIPadding2.Parent = ScrollingFrame;
    u37.list = ScrollingFrame;
    u37.empty = label(Frame, "Empty", "Nobody else is in this server yet.", 16, Color3_fromRGB_ret5, {
        Visible = false,
        Position = UDim2.fromOffset(24, 170),
        Size = UDim2.fromOffset(412, 24),
        TextXAlignment = Enum.TextXAlignment.Center
    });
    u37.message = label(Frame, "Message", "", 15, Color3_fromRGB_ret6, {
        Position = UDim2.fromOffset(24, 486),
        Size = UDim2.fromOffset(412, 22),
        TextXAlignment = Enum.TextXAlignment.Center
    });
    label(Frame, "Footnote", "Robux gifts are final once paid. Roblox shows the price before you buy.", 12, Color3_fromRGB_ret5, {
        Position = UDim2.fromOffset(24, 520),
        Size = UDim2.fromOffset(412, 18),
        TextXAlignment = Enum.TextXAlignment.Center
    });
    local v51 = {
        Visible = false,
        Active = true,
        AnchorPoint = Vector2.new(0.5, 0),
        Position = UDim2.new(0.5, 0, 0, 14),
        Size = UDim2.fromOffset(440, 58),
        BackgroundColor3 = Color3_new_ret
    };
    local Frame2 = Instance.new("Frame");
    Frame2.Name = "Banner";

    for i, v in v51 or {} do
        Frame2[i] = v;
    end;

    Frame2.Parent = ScreenGui;
    local v52 = {
        CornerRadius = UDim.new(0, 14)
    };
    local UICorner3 = Instance.new("UICorner");
    UICorner3.Name = "UICorner";

    for i, v in v52 or {} do
        UICorner3[i] = v;
    end;

    UICorner3.Parent = Frame2;
    rings(Frame2, Color3_fromRGB_ret6, 3, 2);
    local v53 = {
        Rotation = 90,
        Color = ColorSequence.new(Color3_fromRGB_ret6, Color3_fromRGB_ret7)
    };
    local UIGradient = Instance.new("UIGradient");
    UIGradient.Name = "UIGradient";

    for i, v in v53 or {} do
        UIGradient[i] = v;
    end;

    UIGradient.Parent = Frame2;
    local UIScale2 = Instance.new("UIScale");
    UIScale2.Name = "Scale";

    for i, v in {} do
        UIScale2[i] = v;
    end;

    UIScale2.Parent = Frame2;
    local v54 = {
        BackgroundTransparency = 1,
        Image = "rbxassetid://115583741443536",
        Position = UDim2.fromOffset(12, 9),
        Size = UDim2.fromOffset(40, 40),
        ScaleType = Enum.ScaleType.Fit
    };
    local ImageLabel2 = Instance.new("ImageLabel");
    ImageLabel2.Name = "Icon";

    for i, v in v54 or {} do
        ImageLabel2[i] = v;
    end;

    ImageLabel2.Parent = Frame2;
    u37.bannerTitle = label(Frame2, "Title", "", 20, Color3_new_ret, {
        Position = UDim2.fromOffset(62, 7),
        Size = UDim2.fromOffset(320, 24)
    });
    u37.bannerItem = label(Frame2, "Item", "", 14, Color3_new_ret, {
        Position = UDim2.fromOffset(62, 31),
        Size = UDim2.fromOffset(320, 18)
    });
    local v55 = {
        Text = "×",
        TextSize = 30,
        BackgroundTransparency = 1,
        FontFace = Font_new_ret,
        TextColor3 = Color3_new_ret,
        Position = UDim2.fromOffset(392, 9),
        Size = UDim2.fromOffset(40, 40)
    };
    local TextButton3 = Instance.new("TextButton");
    TextButton3.Name = "Cancel";

    for i, v in v55 or {} do
        TextButton3[i] = v;
    end;

    TextButton3.Parent = Frame2;
    local v56 = {
        Thickness = 2,
        Color = Color3.new(0, 0, 0)
    };
    local UIStroke2 = Instance.new("UIStroke");
    UIStroke2.Name = "UIStroke";

    for i, v in v56 or {} do
        UIStroke2[i] = v;
    end;

    UIStroke2.Parent = TextButton3;
    TextButton3.Activated:Connect(function() -- Line: 280
        -- upvalues: u37 (copy)
        u37.remote:FireServer("Cancel");
        u37:hideBanner();
    end);
    u37.banner = Frame2;
    local v57 = {
        BackgroundTransparency = 0.05,
        TextSize = 17,
        TextWrapped = true,
        Visible = false,
        AnchorPoint = Vector2.new(0.5, 0),
        Position = UDim2.new(0.5, 0, 0, 84),
        Size = UDim2.fromOffset(520, 44),
        BackgroundColor3 = Color3_fromRGB_ret,
        FontFace = Font_new_ret,
        TextColor3 = Color3_new_ret
    };
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Name = "Toast";

    for i, v in v57 or {} do
        TextLabel[i] = v;
    end;

    TextLabel.Parent = ScreenGui;
    local v58 = {
        CornerRadius = UDim.new(0, 12)
    };
    local UICorner4 = Instance.new("UICorner");
    UICorner4.Name = "UICorner";

    for i, v in v58 or {} do
        UICorner4[i] = v;
    end;

    UICorner4.Parent = TextLabel;
    rings(TextLabel, Color3_fromRGB_ret6, 2, 1.5);
    local UIScale3 = Instance.new("UIScale");
    UIScale3.Name = "Scale";

    for i, v in {} do
        UIScale3[i] = v;
    end;

    UIScale3.Parent = TextLabel;
    local v59 = {
        PaddingLeft = UDim.new(0, 12),
        PaddingRight = UDim.new(0, 12)
    };
    local UIPadding3 = Instance.new("UIPadding");
    UIPadding3.Name = "Padding";

    for i, v in v59 or {} do
        UIPadding3[i] = v;
    end;

    UIPadding3.Parent = TextLabel;
    u37.toast = TextLabel;
    ScreenGui:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 303, Name: layout
        -- upvalues: ScreenGui (copy), u37 (copy), Frame2 (copy), TextLabel (copy)
        local AbsoluteSize = ScreenGui.AbsoluteSize;

        if AbsoluteSize.X <= 0 then
            return;
        end;

        u37.scale.Scale = math.min(1, AbsoluteSize.X * 0.92 / 460, AbsoluteSize.Y * 0.9 / 560);
        local math_min_ret = math.min(1, AbsoluteSize.X * 0.92 / 520);
        Frame2.Scale.Scale = math_min_ret;
        TextLabel.Scale.Scale = math_min_ret;
    end);
    local AbsoluteSize = ScreenGui.AbsoluteSize;

    if AbsoluteSize.X > 0 then
        u37.scale.Scale = math.min(1, AbsoluteSize.X * 0.92 / 460, AbsoluteSize.Y * 0.9 / 560);
        local math_min_ret = math.min(1, AbsoluteSize.X * 0.92 / 520);
        Frame2.Scale.Scale = math_min_ret;
        TextLabel.Scale.Scale = math_min_ret;
    end;

    Players.PlayerAdded:Connect(function() -- Line: 315
        -- upvalues: u37 (copy)
        u37:changedPlayers();
    end);
    Players.PlayerRemoving:Connect(function(p60) -- Line: 318
        -- upvalues: u37 (copy)
        u37.statuses[tostring(p60.UserId)] = nil;
        u37:changedPlayers();
    end);
    LocalPlayer:GetAttributeChangedSignal("InMatch"):Connect(function() -- Line: 322
        -- upvalues: LocalPlayer (ref), u37 (copy)
        if LocalPlayer:GetAttribute("InMatch") == true then
            u37:close();
            u37:hideBanner();
        end;
    end);

    return u37;
end;

function u1.say(p61, p62, p63) -- Line: 331
    -- upvalues: Color3_fromRGB_ret6 (copy)
    p61.message.Text = p62 or "";
    p61.message.TextColor3 = p63 or Color3_fromRGB_ret6;
end;

function u1.open(p64, p65) -- Line: 336
    -- upvalues: GiftConfig (copy), UserInputService (copy), GuiService (copy)
    local v66 = GiftConfig.offer(p65);

    if not v66 then
        return;
    end;

    p64.key = p65;
    p64.statuses = {};
    p64.test = nil;
    p64.inflight = false;
    p64.open_ = true;
    p64.title.Text = string.upper(v66.name);
    p64.search.Text = "";
    p64:say("");
    p64.backdrop.Visible = true;
    p64.panel.Visible = true;
    p64:ask();
    p64:refresh();

    if UserInputService.GamepadEnabled then
        GuiService.SelectedObject = p64.rows[1] and p64.rows[1].button or nil;
    end;
end;

function u1.close(p67) -- Line: 358
    -- upvalues: GuiService (copy)
    p67.open_ = false;
    p67.inflight = false;
    p67.panel.Visible = false;
    p67.backdrop.Visible = false;

    if GuiService.SelectedObject and GuiService.SelectedObject:IsDescendantOf(p67.panel) then
        GuiService.SelectedObject = nil;
    end;
end;

function u1.hideBanner(p68) -- Line: 368
    p68.banner.Visible = false;
end;

function u1.ask(p69) -- Line: 372
    p69.askedAt = os.clock();
    p69.remote:FireServer("Eligible", p69.key);
end;

function u1.changedPlayers(u70) -- Line: 377
    if not u70.open_ then
        return;
    end;

    u70:refresh();

    if not u70.askQueued then
        u70.askQueued = true;
        local task_delay = task.delay;
        local v71 = 2 - (os.clock() - (u70.askedAt or 0));
        task_delay(math.max(0, v71), function() -- Line: 385
            -- upvalues: u70 (copy)
            u70.askQueued = false;

            if u70.open_ then
                u70:ask();
            end;
        end);
    end;
end;

function u1.showToast(u72, p73) -- Line: 394
    local toast = u72.toast;
    toast.Text = p73;
    toast.Visible = true;
    u72.toastToken = (u72.toastToken or 0) + 1;
    local toastToken = u72.toastToken;
    task.delay(5, function() -- Line: 400
        -- upvalues: u72 (copy), toastToken (copy), toast (copy)
        if u72.toastToken == toastToken then
            toast.Visible = false;
        end;
    end);
end;

function u1.refresh(u74) -- Line: 409
    -- upvalues: Players (copy), LocalPlayer (copy), u3 (copy)
    local v75 = {};

    for _, v in Players:GetPlayers() do
        if v ~= LocalPlayer then
            table.insert(v75, {
                userId = v.UserId,
                name = v.Name,
                display = v.DisplayName
            });
        end;
    end;

    if u74.test then
        table.insert(v75, {
            userId = u74.test.userId,
            name = u74.test.name,
            display = "TEST · " .. u74.test.name
        });
    end;

    local string_lower_ret = string.lower(u74.search.Text);
    local v76 = {};

    for _, v in v75 do
        if string_lower_ret == "" or (string.find(string.lower(v.name), string_lower_ret, 1, true) or string.find(string.lower(v.display), string_lower_ret, 1, true)) then
            table.insert(v76, v);
        end;
    end;

    table.sort(v76, function(p77, p78) -- Line: 430
        -- upvalues: u74 (copy)
        local v79 = u74.statuses[tostring(p77.userId)] == "GIFT";

        if v79 == (u74.statuses[tostring(p78.userId)] == "GIFT") then
            return string.lower(p77.display) < string.lower(p78.display);
        end;

        return v79;
    end);

    for i, v in v76 do
        local v80 = u74.rows[i] or u74:row(i);
        v80.frame.Visible = true;
        v80.frame.LayoutOrder = i;
        v80.userId = v.userId;

        if v80.avatarId ~= v.userId then
            v80.avatarId = v.userId;
            v80.avatar.Image = ("rbxthumb://type=AvatarHeadShot&id=%d&w=150&h=150"):format(v.userId);
        end;

        v80.display.Text = v.display;
        v80.name.Text = "@" .. v.name;
        local v81 = u74.statuses[tostring(v.userId)];
        v80.text.Text = v81 and (u3[v81] or "…") or "…";
        local v82;

        if v81 == "GIFT" then
            v82 = not u74.inflight;
        else
            v82 = false;
        end;

        v80.look(v82);
    end;

    for i = #v76 + 1, #u74.rows do
        u74.rows[i].frame.Visible = false;
        u74.rows[i].userId = nil;
        local _ = i;
    end;

    u74.empty.Visible = #v75 == 0;
end;

function u1.row(u83, p84) -- Line: 460
    -- upvalues: Color3_fromRGB_ret2 (copy), rings (copy), Color3_fromRGB_ret3 (copy), Color3_fromRGB_ret (copy), label (copy), Color3_new_ret (copy), Color3_fromRGB_ret5 (copy), button (copy)
    local list = u83.list;
    local v85 = {
        BackgroundTransparency = 0.1,
        Size = UDim2.new(1, 0, 0, 58),
        BackgroundColor3 = Color3_fromRGB_ret2
    };
    local Frame = Instance.new("Frame");
    Frame.Name = "Row" .. p84;

    for i, v in v85 or {} do
        Frame[i] = v;
    end;

    Frame.Parent = list;
    local v86 = {
        CornerRadius = UDim.new(0, 12)
    };
    local UICorner = Instance.new("UICorner");
    UICorner.Name = "UICorner";

    for i, v in v86 or {} do
        UICorner[i] = v;
    end;

    UICorner.Parent = Frame;
    rings(Frame, Color3_fromRGB_ret3, 2, 1);
    local v87 = {
        Image = "",
        Position = UDim2.fromOffset(8, 7),
        Size = UDim2.fromOffset(44, 44),
        BackgroundColor3 = Color3_fromRGB_ret
    };
    local ImageLabel = Instance.new("ImageLabel");
    ImageLabel.Name = "Avatar";

    for i, v in v87 or {} do
        ImageLabel[i] = v;
    end;

    ImageLabel.Parent = Frame;
    local v88 = {
        CornerRadius = UDim.new(1, 0)
    };
    local UICorner2 = Instance.new("UICorner");
    UICorner2.Name = "UICorner";

    for i, v in v88 or {} do
        UICorner2[i] = v;
    end;

    UICorner2.Parent = ImageLabel;
    local v89 = label(Frame, "Display", "", 17, Color3_new_ret, {
        Position = UDim2.fromOffset(62, 9),
        Size = UDim2.fromOffset(200, 22)
    });
    local v90 = label(Frame, "Username", "", 13, Color3_fromRGB_ret5, {
        Position = UDim2.fromOffset(62, 31),
        Size = UDim2.fromOffset(200, 18)
    });
    local v91, v92, v93 = button(Frame, "Gift", "…", false);
    v91.Position = UDim2.new(1, -136, 0, 10);
    v91.Size = UDim2.fromOffset(126, 38);
    local u94 = {
        frame = Frame,
        avatar = ImageLabel,
        display = v89,
        name = v90,
        button = v91,
        text = v92,
        look = v93
    };
    v91.Activated:Connect(function() -- Line: 481
        -- upvalues: u83 (copy), u94 (copy)
        u83:choose(u94);
    end);
    u83.rows[p84] = u94;

    return u94;
end;

function u1.choose(u95, p96) -- Line: 488
    -- upvalues: Color3_fromRGB_ret4 (copy), Color3_fromRGB_ret11 (copy)
    local userId = p96.userId;

    if not u95.open_ or (u95.inflight or (not userId or u95.statuses[tostring(userId)] ~= "GIFT")) then
        return;
    end;

    u95.inflight = true;
    u95:say("Opening the purchase…", Color3_fromRGB_ret4);
    u95:refresh();
    u95.remote:FireServer("Gift", u95.key, userId);
    local key = u95.key;
    task.delay(15, function() -- Line: 498
        -- upvalues: u95 (copy), key (copy), Color3_fromRGB_ret11 (ref)
        if u95.inflight and u95.key == key then
            u95.inflight = false;
            u95:say("That didn\'t go through. Try again.", Color3_fromRGB_ret11);
            u95:refresh();
        end;
    end);
end;

function u1.receive(p97, p98, p99, p100, p101) -- Line: 508
    -- upvalues: u2 (copy), Color3_fromRGB_ret11 (copy)
    if p98 == "Eligible" then
        if p99 == p97.key and type(p100) == "table" then
            p97.statuses = p100;
            p97.test = type(p101) == "table" and type(p101.userId) == "number" and ({
                userId = p101.userId,
                name = tostring(p101.name)
            } or nil) or nil;
            p97:refresh();
        end;
    elseif p98 == "Refused" then
        p97.inflight = false;
        p97:say(u2[p99] or "That didn\'t go through. Try again.", Color3_fromRGB_ret11);

        if p97.open_ then
            p97:refresh();
        end;
    else
        if p98 == "Opened" and type(p99) == "table" then
            p97.inflight = false;
            p97:close();
            p97.bannerTitle.Text = "GIFTING TO @" .. tostring(p99.name);
            p97.bannerItem.Text = tostring(p99.item);
            p97.banner.Visible = true;

            return;
        end;

        if p98 == "Closed" then
            p97:hideBanner();

            return;
        end;

        if p98 == "Delivered" and type(p99) == "table" then
            p97:hideBanner();
            local v102 = p99.name and ("@" .. tostring(p99.name) or "them") or "them";
            local v103 = tostring(p99.item);
            p97:showToast(p99.result == "Gifted" and ("You gifted %s to %s!"):format(v103, v102) or p99.result == "AlreadyOwned" and ("%s already had %s, so nothing was given."):format(v102, v103) or (p99.result == "AtLimit" and ("%s couldn\'t hold %s, so nothing was given."):format(v102, v103) or (p99.result == "NoRecipient" and "We couldn\'t tell who that gift was for, so nothing was given." or "That gift couldn\'t be delivered.")));

            if p99.result == "Gifted" then
                local GameAudio = game:GetService("SoundService"):FindFirstChild("GameAudio");

                if GameAudio then
                    GameAudio = GameAudio:FindFirstChild("04_UI");
                end;

                if GameAudio then
                    GameAudio = GameAudio:FindFirstChild("Purchase");
                end;

                if GameAudio and GameAudio:IsA("Sound") then
                    require(game:GetService("ReplicatedFirst"):WaitForChild("LazySound")).playLocal(GameAudio);
                end;
            end;
        end;
    end;
end;

return u1;