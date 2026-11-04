 

 

local Players = game:GetService("Players");
local ContextActionService = game:GetService("ContextActionService");
local ChickenOrHero = game:GetService("ReplicatedStorage"):WaitForChild("ChickenOrHero");
local Game = ChickenOrHero:WaitForChild("Game");
local FallenKingConfig = require(Game:WaitForChild("FallenKingConfig"));
local MapLocator = require(Game:WaitForChild("MapLocator"));
local LocalPlayer = Players.LocalPlayer;
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");
local Color3_fromRGB_ret = Color3.fromRGB(110, 255, 140);
local Color3_fromRGB_ret2 = Color3.fromRGB(215, 255, 220);
local Folder = Instance.new("Folder");
Folder.Name = "FallenKingStatue";
Folder.Parent = workspace;

local function progress() -- Line: 35
    -- upvalues: Game (copy), FallenKingConfig (copy)
    local v1 = tonumber(Game:GetAttribute("FallenKingProgress")) or 0;

    return math.clamp(v1, 0, FallenKingConfig.OverMax or 1);
end;

local function percentText() -- Line: 38
    -- upvalues: Game (copy), FallenKingConfig (copy)
    local v2 = tonumber(Game:GetAttribute("FallenKingProgress")) or 0;

    return ("%.2f%%"):format(math.clamp(v2, 0, FallenKingConfig.OverMax or 1) * 100);
end;

local function notice(u3) -- Line: 41
    -- upvalues: ChickenOrHero (copy)
    task.spawn(function() -- Line: 42
        -- upvalues: ChickenOrHero (ref), u3 (copy)
        local success, result = pcall(function() -- Line: 43
            -- upvalues: ChickenOrHero (ref), u3 (ref)
            local v4;

            if require(game:GetService("ReplicatedFirst"):WaitForChild("FFlags")).awaitUIVersion() == "NewGui" then
                v4 = ChickenOrHero:WaitForChild("Interface"):WaitForChild("Toasts", 5);
            else
                v4 = ChickenOrHero:WaitForChild("Presentation"):WaitForChild("ValleyToast", 5);
            end;

            require(v4).show(u3);
        end);

        if not success then
            warn("FallenKingStatueClient notice: " .. tostring(result));
        end;
    end);
end;

local function numberText(p5) -- Line: 55
    if p5 >= 1000000 then
        return ("%.1fM"):format(p5 / 1000000);
    end;

    if p5 >= 10000 then
        return ("%.1fK"):format(p5 / 1000);
    end;

    local math_floor_ret = math.floor(p5);

    return tostring(math_floor_ret);
end;

local u6 = nil;
local u7 = nil;

local function findThrone() -- Line: 72
    -- upvalues: MapLocator (copy), FallenKingConfig (copy)
    local v8 = MapLocator.lobby();

    if v8 then
        v8 = v8:FindFirstChild(FallenKingConfig.ThroneName);
    end;

    if v8 and v8:IsA("Model") then
        return v8;
    end;

    return nil;
end;

local function effect(p9) -- Line: 77
    return p9:IsA("ParticleEmitter") or p9:IsA("Beam") or (p9:IsA("Trail") or p9:IsA("Light")) or (p9:IsA("Highlight") or p9:IsA("Fire") or (p9:IsA("Smoke") or p9:IsA("Sparkles")));
end;

local function isTier(p10) -- Line: 82
    -- upvalues: FallenKingConfig (copy)
    local v11 = tonumber(p10.Name);
    local v12;

    if v11 and (FallenKingConfig.Stages[v11] and not (p10.Parent and tonumber(p10.Parent.Name))) then
        v12 = v11 or nil;
    else
        v12 = nil;
    end;

    return v12;
end;

local function shownTier(p13, p14) -- Line: 87
    -- upvalues: FallenKingConfig (copy)
    for i = math.min(p14, #FallenKingConfig.Stages), 1, -1 do
        if p13:FindFirstChild((tostring(i))) then
            return i;
        end;

        local _ = i;
    end;

    return nil;
end;

local function pieceOn(p15, p16, p17) -- Line: 97
    -- upvalues: FallenKingConfig (copy), shownTier (copy)
    local v18 = tonumber(p15:GetAttribute("Stage"));

    if v18 then
        return v18 <= p16, true;
    end;

    local Parent = p15.Parent;

    while Parent and Parent ~= p17 do
        local v19 = tonumber(Parent.Name);
        local v20 = v19 and (FallenKingConfig.Stages[v19] and not (Parent.Parent and tonumber(Parent.Parent.Name))) and v19 and v19 or nil;

        if v20 then
            return shownTier(Parent.Parent, p16) == v20, false;
        end;

        Parent = Parent.Parent;
    end;

    return nil;
end;

local function tint(p21) -- Line: 112
    -- upvalues: Color3_fromRGB_ret (copy)
    local Keypoints = p21.Keypoints;

    for i, v in Keypoints do
        Keypoints[i] = ColorSequenceKeypoint.new(v.Time, Color3_fromRGB_ret);
    end;

    return ColorSequence.new(Keypoints);
end;

local function applyPiece(p22, p23, p24) -- Line: 120
    -- upvalues: effect (copy), pieceOn (copy), Color3_fromRGB_ret (copy), Color3_fromRGB_ret2 (copy), tint (copy)
    local v25 = effect(p22);
    local v26 = p22:IsA("Sound");

    if not (v25 or (v26 or (p22:IsA("BasePart") or (p22:IsA("Decal") or p22:IsA("Texture"))))) then
        return;
    end;

    local v27, v28 = pieceOn(p22, p23, p24);

    if v27 == nil or not (v25 or (v26 or v28)) then
        return;
    end;

    if not v25 then
        if v26 then
            if v27 and not p22.IsPlaying then
                p22:Play();

                return;
            end;

            if not v27 and p22.IsPlaying then
                p22:Stop();

                return;
            end;
        else
            local Attribute = p22:GetAttribute("StageShown");

            if Attribute == nil then
                Attribute = p22.Transparency;
                p22:SetAttribute("StageShown", Attribute);
            end;

            p22.Transparency = not v27 and 1 or Attribute;
        end;

        return;
    end;

    if p22:IsA("Light") or p22:IsA("Smoke") then
        p22.Color = Color3_fromRGB_ret;
    elseif p22:IsA("Highlight") then
        p22.FillColor = Color3_fromRGB_ret;
        p22.OutlineColor = Color3_fromRGB_ret;
    elseif p22:IsA("Fire") then
        p22.Color = Color3_fromRGB_ret;
        p22.SecondaryColor = Color3_fromRGB_ret2;
    elseif p22:IsA("Sparkles") then
        p22.SparkleColor = Color3_fromRGB_ret;
    else
        p22.Color = tint(p22.Color);
    end;

    p22.Enabled = v27;
end;

local function apply(p29) -- Line: 157
    -- upvalues: u6 (ref), applyPiece (copy)
    if not u6 then
        return;
    end;

    local model = u6.model;

    for _, descendant in model:GetDescendants() do
        applyPiece(descendant, p29, model);
    end;
end;

local function dropThrone() -- Line: 166
    -- upvalues: u6 (ref), apply (copy)
    if not u6 then
        return;
    end;

    u6.conn:Disconnect();

    if u6.model.Parent then
        apply(0);
    end;

    u6 = nil;
end;

local function setupThrone(u30) -- Line: 176
    -- upvalues: u6 (ref), apply (copy), FallenKingConfig (copy), applyPiece (copy), u7 (ref)
    if u6 then
        u6.conn:Disconnect();

        if u6.model.Parent then
            apply(0);
        end;

        u6 = nil;
    end;

    u6 = {
        model = u30,
        conn = u30.DescendantAdded:Connect(function(p31) -- Line: 180
            -- upvalues: FallenKingConfig (ref), u30 (copy), applyPiece (ref), u7 (ref)
            local v32 = tonumber(p31.Name);

            if (v32 and (FallenKingConfig.Stages[v32] and not (p31.Parent and tonumber(p31.Parent.Name))) and v32 and v32 or nil) and p31.Parent ~= u30 then
                for _, descendant in p31.Parent:GetDescendants() do
                    applyPiece(descendant, u7 or 0, u30);
                end;

                return;
            end;

            applyPiece(p31, u7 or 0, u30);
        end)
    };
    apply(u7 or 0);
end;

local function timerText(p33) -- Line: 194
    local math_ceil_ret = math.ceil(p33);
    local math_max_ret = math.max(0, math_ceil_ret);
    local v34 = math_max_ret // 86400;
    local v35 = math_max_ret // 3600 % 24;
    local v36 = math_max_ret // 60 % 60;
    local v37 = math_max_ret % 60;

    if v34 > 0 then
        return ("%dd %02dh %02dm %02ds"):format(v34, v35, v36, v37);
    end;

    return ("%02dh %02dm %02ds"):format(v35, v36, v37);
end;

local function paintTimer() -- Line: 199
    -- upvalues: MapLocator (copy), FallenKingConfig (copy), timerText (copy)
    local v38 = MapLocator.lobby();

    if v38 then
        v38 = v38:FindFirstChild(FallenKingConfig.ThroneName);
    end;

    if not (v38 and v38:IsA("Model")) then
        v38 = nil;
    end;

    if v38 then
        v38 = v38:FindFirstChild("KingTimer");
    end;

    if v38 then
        v38 = v38:FindFirstChild("Sign");
    end;

    local v39;

    if v38 then
        v39 = v38:FindFirstChild("Title");
    else
        v39 = v38;
    end;

    local v40;

    if v38 then
        v40 = v38:FindFirstChild("Time");
    else
        v40 = v38;
    end;

    if not (v39 and v40) then
        return;
    end;

    v38.Enabled = FallenKingConfig.active();
    local v41 = FallenKingConfig.SpawnsAt - workspace:GetServerTimeNow();
    local v42 = timerText(v41);
    local v43;

    if v41 <= 0 then
        v43 = "THE FALLEN KING";
        v42 = "IS HERE";
    else
        v43 = "THE FALLEN KING SPAWNS IN";
    end;

    if v39.Text ~= v43 then
        v39.Text = v43;
    end;

    if v40.Text ~= v42 then
        v40.Text = v42;
    end;
end;

local u44 = { "rbxassetid://81696674854338", "rbxassetid://81028687669074", "rbxassetid://126339332019777", "rbxassetid://124647158843450", "rbxassetid://127516749922764" };
local CrateCatalog = require(ChickenOrHero:WaitForChild("Crates"):WaitForChild("CrateCatalog"));
local Font_new_ret = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.ExtraBold);
local Font_new_ret2 = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.Bold);
local Font_new_ret3 = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.Bold);
local u45 = {
    panelTop = Color3.fromRGB(32, 30, 44),
    panelBottom = Color3.fromRGB(18, 18, 26),
    cardTop = Color3.fromRGB(34, 33, 46),
    cardBottom = Color3.fromRGB(22, 22, 31),
    slot = Color3.fromRGB(17, 17, 24),
    edge = Color3.fromRGB(56, 55, 72),
    purple = Color3.fromRGB(166, 92, 255),
    purpleLight = Color3.fromRGB(214, 168, 255),
    green = Color3.fromRGB(74, 222, 128),
    greenDark = Color3.fromRGB(34, 170, 88),
    grey = Color3.fromRGB(184, 186, 200),
    dim = Color3.fromRGB(110, 110, 128),
    track = Color3.fromRGB(42, 42, 56)
};
local u46 = nil;
local u47 = false;

local function make(p48, p49, p50) -- Line: 267
    local Instance_new_ret = Instance.new(p48);

    for i, v in p50 do
        Instance_new_ret[i] = v;
    end;

    Instance_new_ret.Parent = p49;

    return Instance_new_ret;
end;

local function text(p51, p52, p53, p54, p55, p56, p57, p58, p59, p60, p61) -- Line: 276
    -- upvalues: Font_new_ret3 (copy)
    local v62 = {
        BackgroundTransparency = 1,
        TextScaled = true,
        Position = UDim2.fromOffset(p53, p54),
        Size = UDim2.fromOffset(p55, p56),
        Text = p52,
        TextSize = p57,
        TextColor3 = p58 or Color3.new(1, 1, 1),
        FontFace = p59 or Font_new_ret3,
        TextXAlignment = p60 or Enum.TextXAlignment.Left
    };
    local v63;

    if p61 then
        v63 = Enum.TextYAlignment.Top;
    else
        v63 = Enum.TextYAlignment.Center;
    end;

    v62.TextYAlignment = v63;
    v62.TextWrapped = p61 == true;
    local TextLabel = Instance.new("TextLabel");

    for i, v in v62 do
        TextLabel[i] = v;
    end;

    TextLabel.Parent = p51;
    local v64 = {
        MaxTextSize = p57,
        MinTextSize = math.min(p57, 12)
    };
    local UITextSizeConstraint = Instance.new("UITextSizeConstraint");

    for i, v in v64 do
        UITextSizeConstraint[i] = v;
    end;

    UITextSizeConstraint.Parent = TextLabel;

    return TextLabel;
end;

local function gradient(p65, p66, p67, p68) -- Line: 293
    local v69 = {
        Rotation = p68 or 90,
        Color = ColorSequence.new(p66, p67)
    };
    local UIGradient = Instance.new("UIGradient");

    for i, v in v69 do
        UIGradient[i] = v;
    end;

    UIGradient.Parent = p65;

    return UIGradient;
end;

local function box(p70, p71, p72, p73, p74, p75, p76, p77, p78, p79) -- Line: 297
    -- upvalues: u45 (copy)
    local v80 = {
        BorderSizePixel = 0,
        Position = UDim2.fromOffset(p71, p72),
        Size = UDim2.fromOffset(p73, p74),
        BackgroundColor3 = Color3.new(1, 1, 1)
    };
    local Frame = Instance.new("Frame");

    for i, v in v80 do
        Frame[i] = v;
    end;

    Frame.Parent = p70;
    local v81 = {
        CornerRadius = UDim.new(0, p75)
    };
    local UICorner = Instance.new("UICorner");

    for i, v in v81 do
        UICorner[i] = v;
    end;

    UICorner.Parent = Frame;
    local v82 = {
        Rotation = 90,
        Color = ColorSequence.new(p76, p77 or p76)
    };
    local UIGradient = Instance.new("UIGradient");

    for i, v in v82 do
        UIGradient[i] = v;
    end;

    UIGradient.Parent = Frame;
    local v83 = {
        Color = p78 or u45.edge,
        Thickness = p79 or 2,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    };
    local UIStroke = Instance.new("UIStroke");

    for i, v in v83 do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = Frame;

    return Frame, UIStroke;
end;

local function image(p84, p85, p86, p87, p88, p89) -- Line: 313
    local v90 = {
        BackgroundTransparency = 1,
        Position = UDim2.fromOffset(p86, p87),
        Size = UDim2.fromOffset(p88, p89),
        Image = p85 or "",
        ScaleType = Enum.ScaleType.Fit
    };
    local ImageLabel = Instance.new("ImageLabel");

    for i, v in v90 do
        ImageLabel[i] = v;
    end;

    ImageLabel.Parent = p84;

    return ImageLabel;
end;

local function row(p91, p92, p93, p94, p95) -- Line: 323
    local v96 = {
        BackgroundTransparency = 1,
        Position = UDim2.fromOffset(p92, p93),
        Size = UDim2.fromOffset(0, p94),
        AutomaticSize = Enum.AutomaticSize.X
    };
    local Frame = Instance.new("Frame");

    for i, v in v96 do
        Frame[i] = v;
    end;

    Frame.Parent = p91;
    local v97 = {
        FillDirection = Enum.FillDirection.Horizontal,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, p95)
    };
    local UIListLayout = Instance.new("UIListLayout");

    for i, v in v97 do
        UIListLayout[i] = v;
    end;

    UIListLayout.Parent = Frame;

    return Frame;
end;

local function fitted(p98, p99, p100, p101, p102, p103, p104) -- Line: 333
    local v105 = {
        BackgroundTransparency = 1,
        Size = UDim2.fromOffset(0, p100),
        AutomaticSize = Enum.AutomaticSize.X,
        Text = p99,
        TextSize = p101,
        TextColor3 = p102,
        FontFace = p103,
        LayoutOrder = p104
    };
    local TextLabel = Instance.new("TextLabel");

    for i, v in v105 do
        TextLabel[i] = v;
    end;

    TextLabel.Parent = p98;

    return TextLabel;
end;

local u106 = nil;

local function fit() -- Line: 347
    -- upvalues: u46 (ref)
    if not u46 then
        return;
    end;

    local AbsoluteSize = u46.gui.AbsoluteSize;

    if AbsoluteSize.X > 1 and AbsoluteSize.Y > 1 then
        u46.scale.Scale = math.min(0.72, (AbsoluteSize.Y - 40) / 992, (AbsoluteSize.X - 40) / 1586);
    end;
end;

local function track(p107, p108, p109, p110, p111, p112) -- Line: 357
    -- upvalues: u45 (copy), image (copy), text (copy), Font_new_ret2 (copy)
    local v113 = {
        BorderSizePixel = 0,
        Position = UDim2.fromOffset(p108, p109),
        Size = UDim2.fromOffset(p110, 22),
        BackgroundColor3 = u45.track
    };
    local Frame = Instance.new("Frame");

    for i, v in v113 do
        Frame[i] = v;
    end;

    Frame.Parent = p107;
    local v114 = {
        CornerRadius = UDim.new(1, 0)
    };
    local UICorner = Instance.new("UICorner");

    for i, v in v114 do
        UICorner[i] = v;
    end;

    UICorner.Parent = Frame;
    local v115 = {
        BorderSizePixel = 0,
        Size = UDim2.fromOffset(22, 22),
        BackgroundColor3 = Color3.new(1, 1, 1)
    };
    local Frame2 = Instance.new("Frame");

    for i, v in v115 do
        Frame2[i] = v;
    end;

    Frame2.Parent = Frame;
    local v116 = {
        CornerRadius = UDim.new(1, 0)
    };
    local UICorner2 = Instance.new("UICorner");

    for i, v in v116 do
        UICorner2[i] = v;
    end;

    UICorner2.Parent = Frame2;
    local v117 = {
        Rotation = 0,
        Color = ColorSequence.new(p112[1], p112[2])
    };
    local UIGradient = Instance.new("UIGradient");

    for i, v in v117 do
        UIGradient[i] = v;
    end;

    UIGradient.Parent = Frame2;
    local v118 = {};

    for i, v in p111 do
        local math_floor_ret = math.floor(v[1] * p110);
        local v119;

        if v[3] then
            local v120 = {
                BorderSizePixel = 0,
                ZIndex = 3,
                AnchorPoint = Vector2.new(0.5, 0.5),
                Position = UDim2.new(0, math_floor_ret, 0.5, 0),
                Size = UDim2.fromOffset(38, 38),
                BackgroundColor3 = Color3.fromRGB(26, 26, 36)
            };
            local Frame3 = Instance.new("Frame");
            v119 = v;

            for i2, v2 in v120 do
                Frame3[i2] = v2;
            end;

            Frame3.Parent = Frame;
            local v121 = {
                CornerRadius = UDim.new(1, 0)
            };
            local UICorner3 = Instance.new("UICorner");

            for i2, v2 in v121 do
                UICorner3[i2] = v2;
            end;

            UICorner3.Parent = Frame3;
            local v122 = {
                Thickness = 3,
                Color = u45.dim
            };
            local UIStroke = Instance.new("UIStroke");

            for i2, v2 in v122 do
                UIStroke[i2] = v2;
            end;

            UIStroke.Parent = Frame3;
            local v123 = image(Frame3, "rbxassetid://72814996318422", 2, 2, 34, 34);
            v123.ZIndex = 4;
            v123.Visible = false;
            v118[i] = {
                node = Frame3,
                ring = UIStroke,
                tick = v123
            };
        else
            v119 = v;
        end;

        text(Frame, v119[2], math_floor_ret - 70, 32, 140, 30, 24, Color3.new(1, 1, 1), Font_new_ret2, Enum.TextXAlignment.Center);
    end;

    return Frame2, v118, p110;
end;

local function slot(p124, p125) -- Line: 392
    -- upvalues: box (copy), u45 (copy), image (copy), text (copy), Font_new_ret (copy)
    local v126, v127 = box(p124, 12, 0, p125 - 24, 52, 10, u45.slot, u45.slot, u45.edge, 2);

    return {
        frame = v126,
        stroke = v127,
        lock = image(v126, "rbxassetid://103537711914311", (p125 - 24) / 2 - 16, 10, 32, 32),
        tick = image(v126, "rbxassetid://72814996318422", 0, 8, 36, 36),
        word = text(v126, "", 0, 0, p125 - 24, 52, 26, Color3.new(1, 1, 1), Font_new_ret, Enum.TextXAlignment.Center)
    };
end;

local function rewardImage(p128) -- Line: 399
    -- upvalues: CrateCatalog (copy)
    local v129 = p128.Crate and CrateCatalog.Crates[p128.Crate];

    if v129 and v129.Icon then
        return v129.Icon;
    end;

    return p128.Image;
end;

local function buildPanel() -- Line: 403
    -- upvalues: box (copy), u45 (copy), row (copy), fitted (copy), Font_new_ret (copy), text (copy), Font_new_ret3 (copy), image (copy), FallenKingConfig (copy), track (copy), u44 (copy), Font_new_ret2 (copy), slot (copy), CrateCatalog (copy), PlayerGui (copy), u46 (ref), u106 (ref), fit (copy)
    local ScreenGui = Instance.new("ScreenGui");
    ScreenGui.Name = "FallenKingPanel";
    ScreenGui.ResetOnSpawn = false;
    ScreenGui.IgnoreGuiInset = true;
    ScreenGui.DisplayOrder = 74;
    ScreenGui.Enabled = false;
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
    ScreenGui:SetAttribute("SelfManagedText", true);
    local v130 = {
        Name = "Shade",
        BackgroundTransparency = 0.45,
        Text = "",
        AutoButtonColor = false,
        Size = UDim2.fromScale(1, 1),
        BackgroundColor3 = Color3.new(0, 0, 0)
    };
    local TextButton = Instance.new("TextButton");

    for i, v in v130 do
        TextButton[i] = v;
    end;

    TextButton.Parent = ScreenGui;
    local v131 = {
        Name = "Panel",
        BorderSizePixel = 0,
        Active = true,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromOffset(1586, 992),
        BackgroundColor3 = Color3.new(1, 1, 1)
    };
    local Frame = Instance.new("Frame");

    for i, v in v131 do
        Frame[i] = v;
    end;

    Frame.Parent = TextButton;
    local v132 = {
        CornerRadius = UDim.new(0, 22)
    };
    local UICorner = Instance.new("UICorner");

    for i, v in v132 do
        UICorner[i] = v;
    end;

    UICorner.Parent = Frame;
    local Color3_fromRGB_ret3 = Color3.fromRGB(22, 21, 30);
    local Color3_fromRGB_ret4, v133 = Color3.fromRGB(12, 12, 18);
    local v134 = {
        Rotation = v133 or 90,
        Color = ColorSequence.new(Color3_fromRGB_ret3, Color3_fromRGB_ret4)
    };
    local UIGradient = Instance.new("UIGradient");

    for i, v in v134 do
        UIGradient[i] = v;
    end;

    UIGradient.Parent = Frame;
    local v135 = {
        Thickness = 3,
        Color = Color3.fromRGB(46, 45, 60)
    };
    local UIStroke = Instance.new("UIStroke");

    for i, v in v135 do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = Frame;
    local UIScale = Instance.new("UIScale");

    for i, v in {
        Name = "Scale"
    } do
        UIScale[i] = v;
    end;

    UIScale.Parent = Frame;
    local v136 = box(Frame, 20, 18, 1546, 120, 14, u45.panelTop, u45.panelBottom);
    local v137 = row(v136, 34, 8, 76, 22);
    fitted(v137, "THE FALLEN KING", 76, 66, Color3.new(1, 1, 1), Font_new_ret, 1);
    local v138 = {
        BorderSizePixel = 0,
        LayoutOrder = 2,
        Size = UDim2.fromOffset(110, 42),
        BackgroundColor3 = Color3.new(1, 1, 1)
    };
    local Frame2 = Instance.new("Frame");

    for i, v in v138 do
        Frame2[i] = v;
    end;

    Frame2.Parent = v137;
    local v139 = {
        CornerRadius = UDim.new(0, 12)
    };
    local UICorner2 = Instance.new("UICorner");

    for i, v in v139 do
        UICorner2[i] = v;
    end;

    UICorner2.Parent = Frame2;
    local v140 = {
        Rotation = 90,
        Color = ColorSequence.new(u45.purpleLight, u45.purple)
    };
    local UIGradient2 = Instance.new("UIGradient");

    for i, v in v140 do
        UIGradient2[i] = v;
    end;

    UIGradient2.Parent = Frame2;
    text(Frame2, "EVENT", 0, 0, 110, 42, 24, Color3.new(1, 1, 1), Font_new_ret, Enum.TextXAlignment.Center);
    text(v136, "Collect soul essence and offer it at the cauldron to awaken the boss.", 36, 80, 1300, 32, 25, u45.grey, Font_new_ret3);
    local v141 = {
        Name = "Close",
        Text = "X",
        TextSize = 34,
        AutoButtonColor = true,
        Position = UDim2.fromOffset(1454, 30),
        Size = UDim2.fromOffset(60, 60),
        BackgroundColor3 = u45.slot,
        TextColor3 = Color3.new(1, 1, 1),
        FontFace = Font_new_ret
    };
    local TextButton2 = Instance.new("TextButton");

    for i, v in v141 do
        TextButton2[i] = v;
    end;

    TextButton2.Parent = v136;
    local v142 = {
        CornerRadius = UDim.new(0, 12)
    };
    local UICorner3 = Instance.new("UICorner");

    for i, v in v142 do
        UICorner3[i] = v;
    end;

    UICorner3.Parent = TextButton2;
    local v143 = {
        Thickness = 2,
        Color = u45.edge,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    };
    local UIStroke2 = Instance.new("UIStroke");

    for i, v in v143 do
        UIStroke2[i] = v;
    end;

    UIStroke2.Parent = TextButton2;
    local v144 = box(Frame, 20, 154, 1546, 398, 16, u45.panelTop, u45.panelBottom);
    image(v144, "rbxassetid://138046607798582", 24, 16, 60, 72);
    text(v144, "Global awakening", 102, 12, 700, 58, 52, Color3.new(1, 1, 1), Font_new_ret);
    text(v144, "Shared across all servers", 104, 66, 600, 30, 25, u45.grey, Font_new_ret3);
    local v145 = text(v144, "0.00%", 1026, 8, 494, 92, 88, Color3.new(1, 1, 1), Font_new_ret, Enum.TextXAlignment.Right);
    local v146 = {
        Rotation = 90,
        Color = ColorSequence.new(u45.purpleLight, u45.purple)
    };
    local UIGradient3 = Instance.new("UIGradient");

    for i, v in v146 do
        UIGradient3[i] = v;
    end;

    UIGradient3.Parent = v145;
    local v147 = { { 0, "0%" } };

    for _, v in FallenKingConfig.Stages do
        local v148 = { v.At, math.floor(v.At * 100) .. "%", true };
        table.insert(v147, v148);
    end;

    local v149, v150, v151 = track(v144, 46, 108, 1454, v147, { u45.purpleLight, u45.purple });
    local v152 = {};

    for i, v in FallenKingConfig.Stages do
        local v153, v154 = box(v144, 16 + (i - 1) * 306, 180, 290, 204, 12, u45.cardTop, u45.cardBottom);
        text(v153, math.floor(v.At * 100) .. "%", 20, 10, 120, 36, 30, u45.purple, Font_new_ret);
        local v155 = image(v153, u44[i], 14, 50, 80, 80);
        text(v153, v.Name, 102, 46, 180, 30, 24, Color3.new(1, 1, 1), Font_new_ret2);
        local v156;

        if v.Reward then
            v156 = u45.green;
        else
            v156 = u45.grey;
        end;

        text(v153, v.Reward or v.Line, 102, 78, 180, 52, 19, v156, Font_new_ret3, nil, true);
        local v157 = slot(v153, 290);
        v157.frame.Position = UDim2.fromOffset(12, 142);
        v152[i] = {
            card = v153,
            stroke = v154,
            icon = v155,
            bottom = v157
        };
    end;

    local v158 = box(Frame, 20, 570, 1546, 402, 16, u45.panelTop, u45.panelBottom);
    image(v158, "rbxassetid://97610590833590", 26, 14, 60, 72);
    local v159 = row(v158, 102, 10, 80, 26);
    fitted(v159, "Your offerings", 80, 52, Color3.new(1, 1, 1), Font_new_ret, 1);
    local v160 = fitted(v159, "0", 80, 70, u45.green, Font_new_ret, 2);
    local Color3_fromRGB_ret5 = Color3.fromRGB(150, 255, 170);
    local v161 = {
        Rotation = 90,
        Color = ColorSequence.new(Color3_fromRGB_ret5, u45.green)
    };
    local UIGradient4 = Instance.new("UIGradient");

    for i, v in v161 do
        UIGradient4[i] = v;
    end;

    UIGradient4.Parent = v160;
    fitted(v159, "souls offered", 80, 32, Color3.new(1, 1, 1), Font_new_ret3, 3);
    local v162 = box(v158, 948, 18, 232, 58, 12, u45.slot, u45.slot, u45.edge, 2);
    image(v162, "rbxassetid://138046607798582", 16, 11, 30, 36);
    local v163 = text(v162, "Carrying 0 / 3", 54, 0, 172, 58, 25, Color3.new(1, 1, 1), Font_new_ret2);
    local v164 = {
        BorderSizePixel = 0,
        Position = UDim2.fromOffset(1200, 22),
        Size = UDim2.fromOffset(3, 50),
        BackgroundColor3 = u45.edge
    };
    local Frame3 = Instance.new("Frame");

    for i, v in v164 do
        Frame3[i] = v;
    end;

    Frame3.Parent = v158;
    text(v158, "Offer carried souls at the cauldron to progress.", 1222, 18, 290, 58, 20, u45.grey, Font_new_ret3, nil, true);
    local v165 = #FallenKingConfig.Personal;
    local v166 = {};

    for i, v in FallenKingConfig.Personal do
        local v167 = {};
        local v168 = (i - 1) / math.max(1, v165 - 1);
        local At = v.At;
        local v169;

        if At >= 1000000 then
            v169 = ("%.1fM"):format(At / 1000000);
        elseif At >= 10000 then
            v169 = ("%.1fK"):format(At / 1000);
        else
            local math_floor_ret = math.floor(At);
            v169 = tostring(math_floor_ret);
        end;

        v167[1], v167[2], v167[3] = v168, v169, true;
        table.insert(v166, v167);
    end;

    local v170, v171, v172 = track(v158, 66, 98, 1414, v166, { Color3.fromRGB(150, 255, 170), u45.green });
    local v173 = {};

    for i, v in FallenKingConfig.Personal do
        local v174, v175 = box(v158, 16 + (i - 1) * 306, 168, 290, 214, 12, u45.cardTop, u45.cardBottom);
        local At = v.At;
        local v176;

        if At >= 1000000 then
            v176 = ("%.1fM"):format(At / 1000000);
        elseif At >= 10000 then
            v176 = ("%.1fK"):format(At / 1000);
        else
            local math_floor_ret = math.floor(At);
            v176 = tostring(math_floor_ret);
        end;

        text(v174, v176 .. (v.At == 1 and " soul" or " souls"), 20, 10, 250, 34, 26, Color3.new(1, 1, 1), Font_new_ret2);
        local v177 = v.Crate and CrateCatalog.Crates[v.Crate];
        local v178;

        if v177 and v177.Icon then
            v178 = v177.Icon;
        else
            v178 = v.Image;
        end;

        image(v174, v178, 75, 42, 140, 60);
        text(v174, v.Reward, 12, v.Sub and 104 or 110, 266, 26, 23, Color3.new(1, 1, 1), Font_new_ret2, Enum.TextXAlignment.Center);

        if v.Sub then
            text(v174, v.Sub, 12, 130, 266, 18, 17, u45.grey, Font_new_ret2, Enum.TextXAlignment.Center);
        end;

        local v179 = slot(v174, 290);
        v179.frame.Position = UDim2.fromOffset(12, 154);
        v173[i] = {
            card = v174,
            stroke = v175,
            bottom = v179
        };
    end;

    ScreenGui.Parent = PlayerGui;
    u46 = {
        gui = ScreenGui,
        scale = UIScale,
        percent = v145,
        fill = v149,
        fillWidth = v151,
        nodes = v150,
        stages = v152,
        souls = v160,
        carrying = v163,
        mineFill = v170,
        mineWidth = v172,
        mineNodes = v171,
        rewards = v173
    };
    TextButton.Activated:Connect(function() -- Line: 527
        -- upvalues: u106 (ref)
        u106();
    end);
    TextButton2.Activated:Connect(function() -- Line: 530
        -- upvalues: u106 (ref)
        u106();
    end);
    ScreenGui:GetPropertyChangedSignal("AbsoluteSize"):Connect(fit);
end;

local function paintSlot(p180, p181, p182, p183, p184, p185) -- Line: 536
    -- upvalues: u45 (copy)
    p180.lock.Visible = p181 == "lock";
    p180.word.Visible = p181 ~= "lock";
    p180.word.Text = p182 or "";
    p180.word.TextColor3 = p183 or Color3.new(1, 1, 1);
    p180.tick.Visible = p185 == true;
    p180.word.Position = UDim2.fromOffset(p185 and 44 or 10, 6);
    p180.word.Size = UDim2.new(1, p185 and -54 or -20, 1, -12);
    p180.tick.Position = UDim2.fromOffset(8, 8);
    p180.stroke.Color = p184 or u45.edge;
end;

local function paintNodes(p186, p187, p188, p189) -- Line: 547
    -- upvalues: u45 (copy)
    for i, v in p186 do
        local v190 = i <= p187;
        local v191;

        if v190 then
            v191 = p188;
        else
            v191 = u45.dim;
        end;

        v.ring.Color = v191;
        local node = v.node;
        local v192;

        if v190 and not p189 then
            v192 = p188;
        else
            v192 = Color3.fromRGB(26, 26, 36);
        end;

        node.BackgroundColor3 = v192;
        v.tick.Visible = v190 and p189;
    end;
end;

local function paintPanel() -- Line: 555
    -- upvalues: u46 (ref), u47 (ref), Game (copy), FallenKingConfig (copy), paintNodes (copy), u45 (copy), paintSlot (copy), LocalPlayer (copy)
    if not (u46 and u47) then
        return;
    end;

    local v193 = tonumber(Game:GetAttribute("FallenKingProgress")) or 0;
    local math_clamp_ret = math.clamp(v193, 0, FallenKingConfig.OverMax or 1);
    local percent = u46.percent;
    local v194 = tonumber(Game:GetAttribute("FallenKingProgress")) or 0;
    percent.Text = ("%.2f%%"):format(math.clamp(v194, 0, FallenKingConfig.OverMax or 1) * 100);
    local fill = u46.fill;
    local UDim2_fromOffset = UDim2.fromOffset;
    local v195 = u46.fillWidth * math.min(math_clamp_ret, 1);
    local math_floor_ret = math.floor(v195);
    fill.Size = UDim2_fromOffset(math.max(22, math_floor_ret), 22);
    local v196 = FallenKingConfig.stage(math_clamp_ret);
    local v197 = {};

    for i, v in u46.nodes do
        v197[i - 1] = v;
    end;

    paintNodes(v197, v196, u45.purple, false);

    for i, v in u46.stages do
        local v198 = i <= v196;
        local v199 = i == v196 + 1;
        local stroke = v.stroke;
        local v200;

        if v199 then
            v200 = u45.purple;
        elseif v198 then
            v200 = Color3.fromRGB(110, 70, 170);
        else
            v200 = u45.edge;
        end;

        stroke.Color = v200;
        v.stroke.Thickness = v199 and 3 or 2;
        v.icon.ImageTransparency = (v198 or v199) and 0 or 0.3;

        if v198 then
            paintSlot(v.bottom, "word", "Awakened", u45.purpleLight, Color3.fromRGB(110, 70, 170));
        elseif v199 then
            paintSlot(v.bottom, "word", "NEXT", Color3.new(1, 1, 1), u45.purple);
        else
            paintSlot(v.bottom, "lock");
        end;
    end;

    local v201 = tonumber(LocalPlayer:GetAttribute("FallenKingOffered")) or 0;
    local v202 = FallenKingConfig.personal(v201);
    local v203 = #FallenKingConfig.Personal;
    local v204 = 1;

    if v202 == 0 then
        v204 = 0;
    elseif v202 < v203 then
        local At = FallenKingConfig.Personal[v202].At;
        local v205 = (v201 - At) / math.max(1, FallenKingConfig.Personal[v202 + 1].At - At);
        v204 = (v202 - 1 + math.clamp(v205, 0, 1)) / math.max(1, v203 - 1);
    end;

    local souls = u46.souls;
    local v206;

    if v201 >= 1000000 then
        v206 = ("%.1fM"):format(v201 / 1000000);
    elseif v201 >= 10000 then
        v206 = ("%.1fK"):format(v201 / 1000);
    else
        local math_floor_ret2 = math.floor(v201);
        v206 = tostring(math_floor_ret2);
    end;

    souls.Text = v206;
    u46.carrying.Text = ("Carrying %d"):format(tonumber(LocalPlayer:GetAttribute("FallenKingCarried")) or 0);
    local mineFill = u46.mineFill;
    local UDim2_fromOffset2 = UDim2.fromOffset;
    local math_floor_ret2 = math.floor(u46.mineWidth * v204);
    mineFill.Size = UDim2_fromOffset2(math.max(22, math_floor_ret2), 22);
    paintNodes(u46.mineNodes, v202, u45.green, true);

    for i, v in u46.rewards do
        local v207 = i <= v202;
        local v208 = i == v202 + 1;
        local v209;

        if v208 then
            v209 = u45.green;
        elseif v207 then
            v209 = u45.greenDark;
        else
            v209 = u45.edge;
        end;

        v.stroke.Color = v209;
        v.stroke.Thickness = v208 and 3 or 2;

        if v207 then
            paintSlot(v.bottom, "word", "Reached", u45.green, u45.greenDark, true);
        elseif v208 then
            local v210 = FallenKingConfig.Personal[i].At - v201;
            local bottom = v.bottom;
            local v211;

            if v210 >= 1000000 then
                v211 = ("%.1fM"):format(v210 / 1000000);
            elseif v210 >= 10000 then
                v211 = ("%.1fK"):format(v210 / 1000);
            else
                local math_floor_ret3 = math.floor(v210);
                v211 = tostring(math_floor_ret3);
            end;

            paintSlot(bottom, "word", v211 .. (v210 == 1 and " more soul" or " more souls"), u45.green, u45.green);
        else
            paintSlot(v.bottom, "lock");
        end;
    end;
end;

u106 = function() -- Line: 612, Name: closePanel
    -- upvalues: u47 (ref), ContextActionService (copy), u46 (ref), LocalPlayer (copy)
    if not u47 then
        return;
    end;

    u47 = false;
    ContextActionService:UnbindAction("FallenKingClose");

    if u46 then
        u46.gui.Enabled = false;
    end;

    LocalPlayer:SetAttribute("FallenKingOpen", nil);
end;

local function openPanel() -- Line: 623
    -- upvalues: u47 (ref), LocalPlayer (copy), u46 (ref), buildPanel (copy), paintPanel (copy), ContextActionService (copy), u106 (ref)
    if u47 or LocalPlayer:GetAttribute("InMatch") == true then
        return;
    end;

    if not u46 then
        buildPanel();
    end;

    u47 = true;
    LocalPlayer:SetAttribute("FallenKingOpen", true);
    u46.gui.Enabled = true;

    if u46 then
        local AbsoluteSize = u46.gui.AbsoluteSize;

        if AbsoluteSize.X > 1 and AbsoluteSize.Y > 1 then
            u46.scale.Scale = math.min(0.72, (AbsoluteSize.Y - 40) / 992, (AbsoluteSize.X - 40) / 1586);
        end;
    end;

    paintPanel();
    ContextActionService:BindActionAtPriority("FallenKingClose", function(p212, p213) -- Line: 635
        -- upvalues: u106 (ref)
        if p213 == Enum.UserInputState.Begin then
            u106();
        end;

        return Enum.ContextActionResult.Sink;
    end, false, Enum.ContextActionPriority.High.Value, Enum.KeyCode.ButtonB);
end;

local u214 = nil;

local function setupPrompt(p215) -- Line: 647
    -- upvalues: u214 (ref), openPanel (copy)
    if u214 then
        u214:Destroy();
    end;

    local v216 = {
        Name = "FallenKingView",
        ActionText = "View progress",
        ObjectText = "The Fallen King",
        MaxActivationDistance = 14,
        HoldDuration = 0,
        RequiresLineOfSight = false,
        KeyboardKeyCode = Enum.KeyCode.E,
        GamepadKeyCode = Enum.KeyCode.ButtonX
    };
    local ProximityPrompt = Instance.new("ProximityPrompt");

    for i, v in v216 do
        ProximityPrompt[i] = v;
    end;

    ProximityPrompt.Parent = p215;
    u214 = ProximityPrompt;
    u214.Triggered:Connect(openPanel);
end;

for _, v in { "FallenKingOffered", "FallenKingCarried" } do
    LocalPlayer:GetAttributeChangedSignal(v):Connect(paintPanel);
end;

LocalPlayer:GetAttributeChangedSignal("InMatch"):Connect(function() -- Line: 667
    -- upvalues: LocalPlayer (copy), u106 (ref)
    if LocalPlayer:GetAttribute("InMatch") == true then
        u106();
    end;
end);

local function onProgress() -- Line: 672
    -- upvalues: FallenKingConfig (copy), Game (copy), u7 (ref), ChickenOrHero (copy), apply (copy), paintPanel (copy)
    local stage = FallenKingConfig.stage;
    local v217 = tonumber(Game:GetAttribute("FallenKingProgress")) or 0;
    local v218 = stage((math.clamp(v217, 0, FallenKingConfig.OverMax or 1)));

    if u7 and (u7 < v218 and FallenKingConfig.active()) then
        local u219 = "THE FALLEN KING · " .. string.upper(FallenKingConfig.Stages[v218].Name);
        task.spawn(function() -- Line: 42
            -- upvalues: ChickenOrHero (ref), u219 (copy)
            local success, result = pcall(function() -- Line: 43
                -- upvalues: ChickenOrHero (ref), u219 (ref)
                local v220;

                if require(game:GetService("ReplicatedFirst"):WaitForChild("FFlags")).awaitUIVersion() == "NewGui" then
                    v220 = ChickenOrHero:WaitForChild("Interface"):WaitForChild("Toasts", 5);
                else
                    v220 = ChickenOrHero:WaitForChild("Presentation"):WaitForChild("ValleyToast", 5);
                end;

                require(v220).show(u219);
            end);

            if not success then
                warn("FallenKingStatueClient notice: " .. tostring(result));
            end;
        end);
    end;

    if v218 ~= u7 then
        u7 = v218;
        apply(v218);
    end;

    paintPanel();
end;

Game:GetAttributeChangedSignal("FallenKingProgress"):Connect(onProgress);
task.spawn(function() -- Line: 687
    -- upvalues: FallenKingConfig (copy), MapLocator (copy), u6 (ref), setupThrone (copy), apply (copy), u7 (ref), onProgress (copy), u214 (ref), setupPrompt (copy), u106 (ref)
    while true do
        if FallenKingConfig.active() then
            local v221 = MapLocator.lobby();

            if v221 then
                v221 = v221:FindFirstChild(FallenKingConfig.ThroneName);
            end;

            if not (v221 and v221:IsA("Model")) then
                v221 = nil;
            end;

            if v221 ~= (u6 and u6.model) then
                if v221 then
                    setupThrone(v221);
                elseif u6 then
                    u6.conn:Disconnect();

                    if u6.model.Parent then
                        apply(0);
                    end;

                    u6 = nil;
                end;
            end;

            if u7 == nil then
                onProgress();
            end;

            local v222 = MapLocator.interactable("Deposit");

            if v222 and (v222:IsA("BasePart") and (not u214 or u214.Parent ~= v222)) then
                setupPrompt(v222);
            end;
        else
            if u6 then
                u6.conn:Disconnect();

                if u6.model.Parent then
                    apply(0);
                end;

                u6 = nil;
            end;

            u106();
        end;

        task.wait(2);
    end;
end);
task.spawn(function() -- Line: 715
    -- upvalues: paintTimer (copy), u6 (ref)
    while true do
        paintTimer();
        task.wait(u6 and 0.5 or 2);
    end;
end);