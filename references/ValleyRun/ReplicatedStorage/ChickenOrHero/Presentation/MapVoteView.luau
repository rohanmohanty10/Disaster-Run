 

 

local TweenService = game:GetService("TweenService");
local UserInputService = game:GetService("UserInputService");
local Skin = require(game:GetService("ReplicatedStorage"):WaitForChild("ChickenOrHero"):WaitForChild("OldUIReskin"):WaitForChild("Skin"));
local Panels = Skin.Panels;
local Theme = Skin.Theme;
local NotificationDock = require(script.Parent.NotificationDock);
local MapVoteConfig = require(script.Parent.Parent.Game.MapVoteConfig);
local MapPreviewCopy = require(game:GetService("ReplicatedStorage"):WaitForChild("ChickenOrHero"):WaitForChild("Presentation"):WaitForChild("MapPreviewCopy"));
local Game = script.Parent.Parent.Game;
local u1 = {};
u1.__index = u1;

local function text(p2, p3, p4, p5, p6) -- Line: 17
    -- upvalues: Panels (copy), Theme (copy)
    local v7 = Panels.text(p2, p3, p4, 0, 0, 100, 20, p5, p6);
    v7.Active = false;
    v7.TextWrapped = false;
    v7.TextTruncate = Enum.TextTruncate.AtEnd;
    v7.TextStrokeColor3 = Theme.Ink;
    v7.TextStrokeTransparency = 0.45;

    return v7;
end;

function u1.new(p8) -- Line: 26
    -- upvalues: Panels (copy), Theme (copy), Skin (copy), u1 (copy), UserInputService (copy)
    local v9 = Panels.make("ScreenGui", p8, "MapVoteUI", {
        ResetOnSpawn = false,
        IgnoreGuiInset = true,
        DisplayOrder = 73,
        ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    });
    v9:SetAttribute("SelfManagedText", true);
    local v10 = Panels.make("Frame", v9, "Shade", {
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Visible = false,
        Active = false,
        Size = UDim2.fromScale(1, 1),
        BackgroundColor3 = Theme.Ink
    });
    Panels.fullscreenShade(v9, v10);
    Skin.shade(v10);
    local BlurEffect = Instance.new("BlurEffect");
    BlurEffect.Name = "MapVoteBlur";
    BlurEffect.Size = 0;
    BlurEffect.Enabled = false;
    BlurEffect.Parent = game:GetService("Lighting");
    local v11 = Panels.make("CanvasGroup", v9, "Ballot", {
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Visible = false,
        GroupTransparency = 1,
        Active = false,
        AnchorPoint = Vector2.new(0.5, 0)
    });
    Theme.surface(v11, Theme.Ink, Theme.Gold, 8, 1);
    Skin.ring(v11, Skin.Palette.neutral, 2, 1);
    v11.Border.Enabled = false;
    v11.ZIndex = 2;
    local v12 = Panels.text(v11, "Heading", "Vote for the next map", 0, 0, 100, 20, 17, Theme.Paper);
    v12.Active = false;
    v12.TextWrapped = false;
    v12.TextTruncate = Enum.TextTruncate.AtEnd;
    v12.TextStrokeColor3 = Theme.Ink;
    v12.TextStrokeTransparency = 0.45;
    v12.Font = Enum.Font.GothamBold;
    local v13 = Panels.text(v11, "Timer", "12s", 0, 0, 100, 20, 13, Theme.Gold);
    v13.Active = false;
    v13.TextWrapped = false;
    v13.TextTruncate = Enum.TextTruncate.AtEnd;
    v13.TextStrokeColor3 = Theme.Ink;
    v13.TextStrokeTransparency = 0.45;
    v13.Font = Enum.Font.GothamBold;
    v13.TextXAlignment = Enum.TextXAlignment.Right;
    local v14 = Panels.button(v11, "Close", "×", 0, 0, 34, 30);
    Theme.button(v14, Theme.Muted);
    Skin.button(v14, "dark");
    v14.TextSize = 21;
    v14.BackgroundTransparency = 0.2;
    v14.Modal = false;
    local v15 = Panels.make("ScrollingFrame", v11, "Maps", {
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Active = true,
        ScrollBarThickness = 3,
        ClipsDescendants = true,
        CanvasSize = UDim2.new(),
        ScrollBarImageColor3 = Theme.Gold,
        ScrollingDirection = Enum.ScrollingDirection.X
    });
    Skin.scroll(v15);
    local v16 = Panels.text(v11, "Footer", "Optional · no votes keeps this map", 0, 0, 100, 20, 11, Theme.Muted);
    v16.Active = false;
    v16.TextWrapped = false;
    v16.TextTruncate = Enum.TextTruncate.AtEnd;
    v16.TextStrokeColor3 = Theme.Ink;
    v16.TextStrokeTransparency = 0.45;
    local v17 = Panels.make("NumberValue", v11, "Reveal", {
        Value = 0
    });
    local v18 = Panels.make("NumberValue", v11, "Expansion", {
        Value = 0
    });
    local u19 = setmetatable({
        expanded = false,
        signature = "",
        shown = false,
        gui = v9,
        shade = v10,
        blur = BlurEffect,
        expansion = v18,
        panel = v11,
        heading = v12,
        timer = v13,
        cards = v15,
        footer = v16,
        reveal = v17,
        records = {},
        connections = {},
        close = v14
    }, u1);
    table.insert(u19.connections, v18.Changed:Connect(function() -- Line: 109
        -- upvalues: u19 (copy)
        u19:layout();
    end));
    table.insert(u19.connections, v17.Changed:Connect(function() -- Line: 115
        -- upvalues: u19 (copy)
        u19:layout();
    end));
    local connections = u19.connections;
    local PropertyChangedSignal = v9:GetPropertyChangedSignal("AbsoluteSize");
    table.insert(connections, PropertyChangedSignal:Connect(function() -- Line: 121
        -- upvalues: u19 (copy)
        u19:layout();
    end));
    table.insert(u19.connections, UserInputService.InputChanged:Connect(function(p20) -- Line: 127
        -- upvalues: u19 (copy)
        local press = u19.press;

        if press and (p20 == press.input or p20.UserInputType == Enum.UserInputType.MouseMovement and press.input.UserInputType == Enum.UserInputType.MouseButton1) and (Vector2.new(p20.Position.X, p20.Position.Y) - press.position).Magnitude > 10 then
            press.dragged = true;
        end;
    end));
    u19:layout();

    return u19;
end;

function u1.setVisible(u21, p22) -- Line: 146
    -- upvalues: TweenService (copy)
    local v23 = p22 == true;

    if u21.shown == v23 then
        return;
    end;

    u21.shown = v23;

    if u21.tween then
        u21.tween:Cancel();
    end;

    if v23 then
        u21.panel.Visible = true;
    end;

    local u24 = TweenService:Create(u21.reveal, TweenInfo.new(v23 and 0.24 or 0.16, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Value = v23 and 1 or 0
    });
    u21.tween = u24;
    u24.Completed:Once(function(p25) -- Line: 164
        -- upvalues: u21 (copy), u24 (copy)
        if u21.tween == u24 and p25 == Enum.PlaybackState.Completed then
            u21.tween = nil;

            if not u21.shown then
                u21.panel.Visible = false;
            end;
        end;
    end);
    u24:Play();
end;

function u1.setExpanded(p26, p27) -- Line: 175
    -- upvalues: TweenService (copy)
    local v28 = p27 == true;
    local v29;

    if v28 then
        v29 = p26.shown;
    else
        v29 = v28;
    end;

    p26.close.Modal = v29;

    if p26.expanded == v28 then
        return;
    end;

    p26.expanded = v28;
    p26.cards.CanvasPosition = Vector2.zero;

    if p26.expandTween then
        p26.expandTween:Cancel();
    end;

    p26.expandTween = TweenService:Create(p26.expansion, TweenInfo.new(0.24, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Value = v28 and 1 or 0
    });
    p26.expandTween:Play();
end;

function u1.layout(p30) -- Line: 193
    -- upvalues: NotificationDock (copy), MapVoteConfig (copy)
    local AbsoluteSize = p30.gui.AbsoluteSize;

    if AbsoluteSize.X <= 0 or AbsoluteSize.Y <= 0 then
        return;
    end;

    local Value = p30.expansion.Value;

    local function mix(p31, p32) -- Line: 199
        -- upvalues: Value (copy)
        return p31 + (p32 - p31) * Value;
    end;

    local u33;

    if AbsoluteSize.X >= 700 then
        u33 = AbsoluteSize.Y >= 500;
    else
        u33 = false;
    end;

    local function textSize(p34) -- Line: 204
        -- upvalues: u33 (copy)
        if not u33 then
            return math.round(p34);
        end;

        local math_round_ret = math.round(p34 * 1.12);

        return math.clamp(math_round_ret, 12, 40);
    end;

    p30.close.TextSize = u33 and 24 or 21;
    local math_max_ret = math.max(300, AbsoluteSize.X * 0.6);
    local math_min_ret = math.min(600, math_max_ret, AbsoluteSize.X - 28);
    local v35 = AbsoluteSize.Y < 500;
    local v36, v37;

    if v35 then
        math_min_ret = math.min(340, AbsoluteSize.X - 28);
        v36 = 98;
        v37 = 64;
    else
        v36 = 156;
        v37 = 102;
    end;

    local math_min_ret2 = math.min(980, AbsoluteSize.X * 0.92);
    local math_min_ret3 = math.min(520, AbsoluteSize.Y * 0.84);
    local v38 = math_min_ret + (math_min_ret2 - math_min_ret) * Value;
    local v39 = v36 + (math_min_ret3 - v36) * Value;
    local v40 = NotificationDock.bottom(p30.gui.Parent, p30.gui);
    local v41 = v40 + ((AbsoluteSize.Y - math_min_ret3) / 2 - v40) * Value;
    p30.panel.Size = UDim2.fromOffset(v38, v39);
    p30.panel.Position = UDim2.new(0.5, 0, 0, v41 - 12 * (1 - p30.reveal.Value));
    p30.panel.GroupTransparency = 1 - p30.reveal.Value;
    p30.panel.BackgroundTransparency = 1 - 0.82 * Value;
    local Border = p30.panel:FindFirstChild("Border");
    local SkinOutline = p30.panel:FindFirstChild("SkinOutline");

    if Border then
        Border.Enabled = Value > 0.005;
        Border.Transparency = 1 - Value;
    end;

    if SkinOutline then
        SkinOutline.Transparency = 1 - Value;
    end;

    p30.shade.Visible = p30.reveal.Value * Value > 0.005;
    p30.shade.Active = false;
    p30.shade.BackgroundTransparency = 1 - 0.19 * p30.reveal.Value * Value;
    p30.blur.Size = (MapVoteConfig.BackgroundBlurSize or 8) * p30.reveal.Value * Value;
    p30.blur.Enabled = p30.blur.Size > 0.05;
    p30.close.Modal = p30.expanded and p30.shown;
    p30.close.Text = p30.expanded and "×" or "↗";
    p30.close.Size = UDim2.fromOffset(34 + 6 * Value, 30 + 10 * Value);
    local v42 = 0 + 18 * Value;
    local heading = p30.heading;
    local v43 = 14 + ((AbsoluteSize.Y < 450 and 20 or 27) - 14) * Value;
    local v44;

    if u33 then
        local math_round_ret = math.round(v43 * 1.12);
        v44 = math.clamp(math_round_ret, 12, 40);
    else
        v44 = math.round(v43);
    end;

    heading.TextSize = v44;
    p30.heading.Position = UDim2.fromOffset(v42 + 2, 4 + 12 * Value);
    p30.heading.Size = UDim2.fromOffset(v38 - 2 * v42 - 98, 22 + 14 * Value);
    local timer = p30.timer;
    local v45 = 11 + 3 * Value;
    local v46;

    if u33 then
        local math_round_ret = math.round(v45 * 1.12);
        v46 = math.clamp(math_round_ret, 12, 40);
    else
        v46 = math.round(v45);
    end;

    timer.TextSize = v46;
    p30.timer.Position = UDim2.fromOffset(v38 - v42 - 94, 5 + 17 * Value);
    p30.timer.Size = UDim2.fromOffset(44, 20);
    p30.close.Position = UDim2.fromOffset(v38 - v42 - (36 + 4 * Value), 0 + 14 * Value);
    local v47 = v37 + (math_min_ret3 - 111 - v37) * Value;
    local v48 = v38 - v42 * 2;
    p30.cards.Position = UDim2.fromOffset(v42, 30 + 38 * Value);
    p30.cards.Size = UDim2.fromOffset(v48, v47);
    local footer = p30.footer;
    local v49 = 10 + 2 * Value;
    local v50;

    if u33 then
        local math_round_ret = math.round(v49 * 1.12);
        v50 = math.clamp(math_round_ret, 12, 40);
    else
        v50 = math.round(v49);
    end;

    footer.TextSize = v50;
    p30.footer.Position = UDim2.fromOffset(v42 + 2, v39 - (16 + 13 * Value));
    p30.footer.Size = UDim2.fromOffset(v38 - v42 * 2 - 4, 18);
    p30.footer.Visible = not v35 or Value > 0.5;
    local v51 = p30.expanded and AbsoluteSize.X < AbsoluteSize.Y;
    p30.cards.ScrollingDirection = v51 and Enum.ScrollingDirection.Y or Enum.ScrollingDirection.X;
    local math_max_ret2 = math.max(1, #p30.records);
    local v52 = 8 + 4 * Value;
    local v53 = v51 and v48 - 5 - 14 or math.max(100, (v48 - 14 - v52 * (math_max_ret2 - 1)) / math_max_ret2);
    local v54 = v51 and math.max(150, (v47 - v52 * (math_max_ret2 - 1)) / math_max_ret2) or v47 - 14;

    for i, v in p30.records do
        v.card.Position = v51 and UDim2.fromOffset(7, 7 + (i - 1) * (v54 + v52)) or UDim2.fromOffset(7 + (i - 1) * (v53 + v52), 7);
        v.card.Size = UDim2.fromOffset(v53, v54);
        v.card.BackgroundTransparency = 0;
        v.preview.Position = UDim2.fromOffset(0, 0);
        v.preview.Size = UDim2.fromOffset(v53, v54);
        local v55 = 17 + 9 * Value;
        local v56 = 14 + 4 * Value;
        v.fade.Position = UDim2.fromOffset(0, v54 * 0.4);
        v.fade.Size = UDim2.fromOffset(v53, v54 * 0.6);
        local name = v.name;
        local v57 = 12 + 9 * Value;
        local v58;

        if u33 then
            local math_round_ret = math.round(v57 * 1.12);
            v58 = math.clamp(math_round_ret, 12, 40);
        else
            v58 = math.round(v57);
        end;

        name.TextSize = v58;
        v.name.Position = UDim2.fromOffset(8 + 6 * Value, v54 - v55 - v56 - (6 + 6 * Value));
        v.name.Size = UDim2.fromOffset(v53 - (16 + 12 * Value), v55);
        local detail = v.detail;
        local v59 = 10 + 3 * Value;
        local v60;

        if u33 then
            local math_round_ret = math.round(v59 * 1.12);
            v60 = math.clamp(math_round_ret, 12, 40);
        else
            v60 = math.round(v59);
        end;

        detail.TextSize = v60;
        v.detail.Position = UDim2.fromOffset(8 + 6 * Value, v54 - v56 - (5 + 5 * Value));
        v.detail.Size = UDim2.fromOffset(v53 - (16 + 12 * Value), v56);
        local v61 = 26 + 14 * Value;
        v.votes.Size = UDim2.fromOffset(v61, 18 + 8 * Value);
        v.votes.Position = UDim2.fromOffset(v53 - v61 - (5 + 5 * Value), 5 + 5 * Value);
        local votes = v.votes;
        local v62 = 11 + 4 * Value;
        local v63;

        if u33 then
            local math_round_ret = math.round(v62 * 1.12);
            v63 = math.clamp(math_round_ret, 12, 40);
        else
            v63 = math.round(v62);
        end;

        votes.TextSize = v63;
        v.ribbon.Size = UDim2.fromOffset(math.min(v53 - v61 - 20, 86 + 50 * Value), 20 + 10 * Value);
        v.ribbon.Position = UDim2.fromOffset(5 + 5 * Value, 5 + 5 * Value);
        local ribbon = v.ribbon;
        local v64 = 11 + 5 * Value;
        local v65;

        if u33 then
            local math_round_ret = math.round(v64 * 1.12);
            v65 = math.clamp(math_round_ret, 12, 40);
        else
            v65 = math.round(v64);
        end;

        ribbon.TextSize = v65;

        if v.badge and v.tagged then
            v.badge.Size = UDim2.fromOffset(math.min(v53 - v61 - 20, 112 + 60 * Value), 22 + 10 * Value);
            v.badge.Position = UDim2.fromOffset(5 + 5 * Value, 5 + 5 * Value);
            local badge = v.badge;
            local v66 = 12 + 5 * Value;
            local v67;

            if u33 then
                local math_round_ret = math.round(v66 * 1.12);
                v67 = math.clamp(math_round_ret, 12, 40);
            else
                v67 = math.round(v66);
            end;

            badge.TextSize = v67;
        elseif v.badge then
            v.badge.Size = UDim2.fromOffset(math.min(v53 - v61 - 20, 78 + 46 * Value), 16 + 8 * Value);
            v.badge.Position = UDim2.fromOffset(5 + 5 * Value, 6 + 5 * Value);
            local badge = v.badge;
            local v68 = 9 + 4 * Value;
            local v69;

            if u33 then
                local math_round_ret = math.round(v68 * 1.12);
                v69 = math.clamp(math_round_ret, 12, 40);
            else
                v69 = math.round(v68);
            end;

            badge.TextSize = v69;
        end;
    end;

    p30.cards.CanvasSize = v51 and UDim2.fromOffset(0, #p30.records * (v54 + v52) - v52 + 14) or UDim2.fromOffset(math.max(0, #p30.records * (v53 + v52) - v52 + 14), 0);
end;

function u1.preview(p70, p71) -- Line: 306
    -- upvalues: Game (copy), MapPreviewCopy (copy)
    if p71.image then
        return;
    end;

    local MapPreviews = Game:FindFirstChild("MapPreviews");

    if MapPreviews then
        MapPreviews = MapPreviews:FindFirstChild(p71.previewId or p71.id);
    end;

    if not MapPreviews or p71.previewSource == MapPreviews then
        return;
    end;

    p71.previewSource = MapPreviews;
    p71.preview:ClearAllChildren();
    local v72 = MapPreviewCopy.clone(MapPreviews);
    v72.Parent = p71.preview;
    local BoundingBox, v73 = v72:GetBoundingBox();
    local Camera = Instance.new("Camera");
    Camera.FieldOfView = 35;
    Camera.CFrame = CFrame.lookAt(BoundingBox.Position + (Vector3.new(-0.8, 0.8, 1)).Unit * math.max(1, v73.Magnitude) * 1.03, BoundingBox.Position);
    Camera.Parent = p71.preview;
    p71.preview.CurrentCamera = Camera;
end;

function u1.build(u74, p75) -- Line: 328
    -- upvalues: Panels (copy), Theme (copy), Skin (copy)
    for _, v in u74.records do
        for _, v2 in v.connections do
            v2:Disconnect();
        end;

        v.card:Destroy();
    end;

    table.clear(u74.records);
    u74.press = nil;

    if u74.glow then
        u74.glow:Cancel();
        u74.glow = nil;
    end;

    u74.glowBorder = nil;

    for _, v in p75 do
        local Color3_new_ret = Color3.new(table.unpack(v.accent));
        local u76 = Panels.make("TextButton", u74.cards, v.id, {
            Text = "",
            AutoButtonColor = false,
            BorderSizePixel = 0,
            ClipsDescendants = true,
            Modal = false,
            Active = true,
            BackgroundTransparency = 0.58
        });
        Theme.surface(u76, Theme.Ink:Lerp(Color3_new_ret, 0.07), Color3_new_ret, 5, 0.72);
        Skin.ring(u76, Skin.Palette.neutral, 2);
        Skin.corner(u76, UDim.new(0, 10));
        local v77;

        if type(v.image) == "string" and v.image ~= "" then
            v77 = Panels.make("ImageLabel", u76, "Arena", {
                BackgroundTransparency = 0,
                BorderSizePixel = 0,
                Active = false,
                ZIndex = 1,
                Image = v.image,
                ScaleType = Enum.ScaleType.Crop,
                BackgroundColor3 = Color3.fromRGB(14, 18, 26):Lerp(Color3_new_ret, 0.28)
            });
        else
            v77 = Panels.make("ViewportFrame", u76, "Arena", {
                BackgroundTransparency = 0,
                BorderSizePixel = 0,
                Active = false,
                LightDirection = Vector3.new(-1, -1, -0.5),
                ZIndex = 1,
                BackgroundColor3 = Color3.fromRGB(14, 18, 26):Lerp(Color3_new_ret, v.tag and 0.5 or 0.28),
                Ambient = Color3.fromRGB(190, 194, 203),
                LightColor = Color3.fromRGB(255, 240, 215)
            });
        end;

        local v78 = Panels.make("Frame", u76, "Fade", {
            BorderSizePixel = 0,
            Active = false,
            ZIndex = 2,
            BackgroundColor3 = Color3.fromRGB(6, 8, 12)
        });
        local u79 = v;

        for _, v2 in { v77, v78 } do
            local UICorner = Instance.new("UICorner");
            UICorner.CornerRadius = UDim.new(0, 10);
            UICorner.Parent = v2;
        end;

        local UIGradient = Instance.new("UIGradient");
        UIGradient.Rotation = 90;
        UIGradient.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.55, 0.35), NumberSequenceKeypoint.new(1, 0.08) });
        UIGradient.Parent = v78;
        local v80 = Panels.text(u76, "Name", u79.name, 0, 0, 100, 20, 14, Theme.Paper);
        v80.Active = false;
        v80.TextWrapped = false;
        v80.TextTruncate = Enum.TextTruncate.AtEnd;
        v80.TextStrokeColor3 = Theme.Ink;
        v80.TextStrokeTransparency = 0.45;
        v80.Font = Enum.Font.GothamBlack;
        v80.ZIndex = 3;
        v80.TextStrokeTransparency = 0.2;
        local v81 = Panels.text(u76, "Detail", "Tap to vote", 0, 0, 100, 20, 11, Theme.Muted);
        v81.Active = false;
        v81.TextWrapped = false;
        v81.TextTruncate = Enum.TextTruncate.AtEnd;
        v81.TextStrokeColor3 = Theme.Ink;
        v81.TextStrokeTransparency = 0.45;
        v81.Font = Enum.Font.GothamBold;
        v81.ZIndex = 3;
        local Color3_new_ret2 = Color3.new(1, 1, 1);
        local v82 = Panels.text(u76, "Votes", "0", 0, 0, 100, 20, 12, Color3_new_ret2);
        v82.Active = false;
        v82.TextWrapped = false;
        v82.TextTruncate = Enum.TextTruncate.AtEnd;
        v82.TextStrokeColor3 = Theme.Ink;
        v82.TextStrokeTransparency = 0.45;
        v82.Font = Enum.Font.GothamBlack;
        v82.TextXAlignment = Enum.TextXAlignment.Center;
        v82.TextYAlignment = Enum.TextYAlignment.Center;
        v82.TextTruncate = Enum.TextTruncate.None;
        v82.BackgroundColor3 = Color3.fromRGB(10, 12, 18);
        v82.BackgroundTransparency = 0.25;
        v82.ZIndex = 4;
        local UICorner = Instance.new("UICorner");
        UICorner.CornerRadius = UDim.new(1, 0);
        UICorner.Parent = v82;
        local UIStroke = Instance.new("UIStroke");
        UIStroke.Color = Color3_new_ret;
        UIStroke.Thickness = 1.5;
        UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
        UIStroke.Parent = v82;
        local v83 = u79.tag or u79.limitedTime and "LIMITED TIME";
        local v84;

        if v83 then
            local v85 = u79.tag and "Tag" or "LimitedTime";
            local Color3_new_ret3 = Color3.new(1, 1, 1);
            v84 = Panels.text(u76, v85, v83, 0, 0, 100, 20, 12, Color3_new_ret3);
            v84.Active = false;
            v84.TextWrapped = false;
            v84.TextTruncate = Enum.TextTruncate.AtEnd;
            v84.TextStrokeColor3 = Theme.Ink;
            v84.TextStrokeTransparency = 0.45;
            v84.Font = Enum.Font.GothamBold;
            v84.TextScaled = false;
            v84.TextWrapped = false;
            v84.TextTruncate = Enum.TextTruncate.None;
            v84.TextXAlignment = Enum.TextXAlignment.Center;
            v84.TextYAlignment = Enum.TextYAlignment.Center;
            v84.TextStrokeTransparency = 0.75;
            v84.BackgroundColor3 = Theme.Ink;
            v84.BackgroundTransparency = 0.3;
            v84.ZIndex = 5;
            local UICorner2 = Instance.new("UICorner");
            UICorner2.CornerRadius = UDim.new(0.25, 0);
            UICorner2.Parent = v84;
            local UIStroke2 = Instance.new("UIStroke");
            UIStroke2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
            UIStroke2.Color = Color3.new(0, 0, 0);
            UIStroke2.Thickness = 1;
            UIStroke2.Transparency = 0.45;
            UIStroke2.Parent = v84;
            local badge = Skin.badge;
            local v86 = {
                kind = "tag"
            };
            local v87;

            if u79.tag then
                v87 = Skin.Palette[u79.tagColor] or Skin.Palette.danger;
            else
                v87 = nil;
            end;

            v86.color = v87;
            badge(v84, v86);
            v84.BackgroundTransparency = 0;
            v84.TextStrokeTransparency = 1;
            local SkinTextStroke = v84:FindFirstChild("SkinTextStroke");

            if SkinTextStroke and SkinTextStroke:IsA("UIStroke") then
                SkinTextStroke.Enabled = false;
            end;

            if u79.tag then
                v84.Font = Enum.Font.GothamBlack;
            end;
        else
            v84 = nil;
        end;

        local Color3_new_ret3 = Color3.new(1, 1, 1);
        local v88 = Panels.text(u76, "Winner", "★ WINNER", 0, 0, 100, 20, 12, Color3_new_ret3);
        v88.Active = false;
        v88.TextWrapped = false;
        v88.TextTruncate = Enum.TextTruncate.AtEnd;
        v88.TextStrokeColor3 = Theme.Ink;
        v88.TextStrokeTransparency = 0.45;
        v88.Font = Enum.Font.GothamBlack;
        v88.TextXAlignment = Enum.TextXAlignment.Center;
        v88.TextYAlignment = Enum.TextYAlignment.Center;
        v88.TextTruncate = Enum.TextTruncate.None;
        v88.TextStrokeTransparency = 0.5;
        v88.BackgroundColor3 = Theme.Gold;
        v88.BackgroundTransparency = 0;
        v88.ZIndex = 6;
        v88.Visible = false;
        local UICorner2 = Instance.new("UICorner");
        UICorner2.CornerRadius = UDim.new(0.3, 0);
        UICorner2.Parent = v88;
        local v89 = {
            ribbon = v88,
            id = u79.id,
            previewId = u79.previewId or u79.mapId
        };
        local v90;

        if type(u79.image) == "string" and u79.image ~= "" then
            v90 = u79.image;
        else
            v90 = nil;
        end;

        v89.image = v90;
        v89.tagged = u79.tag ~= nil;
        v89.name = v80;
        v89.detail = v81;
        v89.fade = v78;
        v89.votes = v82;
        v89.badge = v84;
        v89.card = u76;
        v89.preview = v77;
        v89.color = Color3_new_ret;
        v89.connections = {};
        table.insert(v89.connections, u76.InputBegan:Connect(function(p91) -- Line: 496
            -- upvalues: u74 (copy), u76 (copy)
            if p91.UserInputType == Enum.UserInputType.Touch or p91.UserInputType == Enum.UserInputType.MouseButton1 then
                u74.press = {
                    input = p91,
                    button = u76,
                    position = Vector2.new(p91.Position.X, p91.Position.Y),
                    canvas = u74.cards.CanvasPosition
                };
            end;
        end));
        table.insert(v89.connections, u76.Activated:Connect(function(p92) -- Line: 512
            -- upvalues: u74 (copy), u76 (copy), u79 (copy)
            if not u74.shown or u74.result then
                return;
            end;

            local press = u74.press;

            if p92 and (p92.UserInputType == Enum.UserInputType.Touch or p92.UserInputType == Enum.UserInputType.MouseButton1) and (press and (press.button == u76 and (press.dragged or (u74.cards.CanvasPosition - press.canvas).Magnitude > 6))) then
                return;
            end;

            if u74.onVote then
                u74.onVote(u79.id);
            end;
        end));
        table.insert(u74.records, v89);
        u74:preview(v89);
    end;

    u74:layout();
end;

function u1.render(p93, p94, p95) -- Line: 536
    -- upvalues: TweenService (copy), Theme (copy), Skin (copy)
    local v96 = "";

    for _, v in p94.options or {} do
        v96 = v96 .. v.id .. "|" .. v.name .. "|" .. tostring(v.limitedTime) .. "|" .. tostring(v.tag) .. "|";
    end;

    if v96 ~= p93.signature then
        p93.signature = v96;
        p93:build(p94.options or {});
    end;

    local v97 = p94.votes and p94.votes[tostring(p95)];
    p93.result = p94.phase == "Result";
    local v98 = p94.counts or {};
    local v99 = false;
    local v100 = nil;

    if p93.result then
        for _, v in p93.records do
            if v.id == p94.winner then
                v100 = v;
            elseif (v98[v.id] or 0) == (v98[p94.winner] or 0) and (v98[p94.winner] or 0) > 0 then
                v99 = true;
            end;
        end;
    end;

    local v101;

    if v100 then
        v101 = v100.card.Border or nil;
    else
        v101 = nil;
    end;

    if p93.glowBorder ~= v101 then
        if p93.glow then
            p93.glow:Cancel();
            p93.glow = nil;
        end;

        p93.glowBorder = v101;

        if v101 then
            v101.Thickness = 3;
            p93.glow = TweenService:Create(v101, TweenInfo.new(0.55, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
                Thickness = 6
            });
            p93.glow:Play();
        end;
    end;

    for _, v in p93.records do
        p93:preview(v);
        local v102;

        if p93.result and p94.winner == v.id then
            v102 = true;
        else
            v102 = not p93.result and v97 == v.id;
        end;

        local v103 = p93.result and not v102;
        v.card.Border.Transparency = v103 and 0.8 or 0;
        local v104;

        if v == v100 then
            v104 = Theme.Gold;
        elseif v102 or v.tagged then
            v104 = v.color;
        else
            v104 = Skin.Palette.neutral;
        end;

        v.card.Border.Color = v104;

        if v ~= v100 then
            v.card.Border.Thickness = v102 and 3 or 1.5;
        end;

        local SkinOutline = v.card:FindFirstChild("SkinOutline");

        if SkinOutline then
            SkinOutline.Enabled = not (v102 or v.tagged);
        end;

        v.card.BackgroundColor3 = Theme.Ink:Lerp(v.color, v102 and 0.2 or 0.07);
        v.ribbon.Visible = v == v100;

        if v.badge then
            v.badge.Visible = v ~= v100;
        end;

        local fade = v.fade;
        local v105;

        if v == v100 then
            v105 = Theme.Gold:Lerp(Color3.new(0, 0, 0), 0.6);
        else
            v105 = Color3.fromRGB(6, 8, 12);
        end;

        fade.BackgroundColor3 = v105;
        v.votes.Text = tostring(v98[v.id] or 0);
        v.name.TextTransparency = v103 and 0.45 or 0;
        v.votes.TextTransparency = v103 and 0.45 or 0;
        local v106;

        if p93.result then
            v106 = p94.winner == v.id and (v99 and "★ WON THE TIE" or "★ NEXT MAP") or "Voting ended";
        else
            v106 = v97 == v.id and "✓ YOUR VOTE" or (p93.gamepad and "◀ ▶ TO VOTE" or "TAP TO VOTE");
        end;

        v.detail.Text = v106;
        local detail = v.detail;
        local v107;

        if v == v100 then
            v107 = Theme.Gold;
        elseif v102 then
            v107 = v.color:Lerp(Color3.new(1, 1, 1), 0.35);
        else
            v107 = Color3.fromRGB(205, 210, 220);
        end;

        detail.TextColor3 = v107;
        v.preview.ImageTransparency = v103 and 0.78 or 0;
    end;

    local v108;

    if p93.result then
        v108 = v99 and "TIE · NEXT MAP" or "NEXT MAP";
    else
        v108 = p93.expanded and "CHOOSE A MAP" or "Vote for the next map";
    end;

    p93.heading.Text = v108;
    local v109;

    if p93.result then
        v109 = "Taking the lobby with us.";
    elseif v97 then
        v109 = p93.gamepad and "Vote counted · D-pad ◀ ▶ to change" or "Vote counted · tap another map to change";
    elseif p93.expanded then
        v109 = p93.gamepad and "Optional · D-pad ◀ ▶ to vote · B to minimize" or "Optional · close to explore, then reopen from the top";
    else
        v109 = p93.gamepad and "Optional · D-pad ◀ ▶ to vote" or "Optional · tap a map to vote · ↗ expand";
    end;

    p93.footer.Text = v109;
end;

function u1.clock(p110, p111, p112) -- Line: 619
    p110.timer.Text = p112 and "PAUSED" or (p110.result and "✓" or p111 .. "s");
end;

function u1.destroy(p113) -- Line: 622
    if p113.tween then
        p113.tween:Cancel();
    end;

    if p113.expandTween then
        p113.expandTween:Cancel();
    end;

    if p113.glow then
        p113.glow:Cancel();
    end;

    p113.blur:Destroy();

    for _, v in p113.connections do
        v:Disconnect();
    end;

    for _, v in p113.records do
        for _, v2 in v.connections do
            v2:Disconnect();
        end;
    end;

    p113.gui:Destroy();
end;

return u1;