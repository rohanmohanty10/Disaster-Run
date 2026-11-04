 

 

local Skin = require(game:GetService("ReplicatedStorage"):WaitForChild("ChickenOrHero"):WaitForChild("OldUIReskin"):WaitForChild("Skin"));
local Panels = Skin.Panels;
local Theme = Skin.Theme;
local u1 = {
    Slots = 6,
    PadImage = "rbxasset://textures/ui/Controls/dpadUp.png"
};
local Center = Enum.TextXAlignment.Center;

local function centred(p2) -- Line: 12
    -- upvalues: Center (copy)
    p2.TextXAlignment = Center;

    return p2;
end;

function u1.build(p3) -- Line: 13
    -- upvalues: Panels (copy), Theme (copy), Skin (copy), Center (copy), u1 (copy)
    local v4 = Panels.make("ScreenGui", p3, "ValleyEmotes", {
        ResetOnSpawn = false,
        IgnoreGuiInset = false,
        DisplayOrder = 72,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    });
    local v5 = Panels.button(v4, "Open", "", 8, 180, 44, 44, Theme.Ink);
    Theme.button(v5, Theme.Purple);
    v5.AutoButtonColor = true;
    v5.BackgroundTransparency = 0.25;
    local icon = Skin.icon;
    local v6 = Panels.text(v5, "Face", "☺", 0, 0, 44, 28, 23, Theme.Purple);
    v6.TextXAlignment = Center;
    icon(v6, "emoteButton");
    Panels.text(v5, "Label", "EMOTES", 0, 28, 44, 14, 8, Theme.Paper).TextXAlignment = Center;
    local v7 = Panels.make("Frame", v5, "Badge", {
        BorderSizePixel = 0,
        Visible = false,
        ZIndex = 2,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(1, -3, 0, 3),
        Size = UDim2.fromOffset(18, 18),
        BackgroundColor3 = Theme.Ink
    });
    Panels.corner(v7, 5);
    Panels.stroke(v7, Theme.Purple, 0.35);
    Skin.ring(v7, Skin.Palette.neutral, 1.5);
    local v8 = Panels.text(v7, "Key", "G", 0, 0, 18, 18, 11, Theme.Paper);
    v8.TextXAlignment = Center;
    v8.Font = Enum.Font.GothamBold;
    v8.ZIndex = 2;
    v8.Visible = false;
    Panels.make("ImageLabel", v7, "Pad", {
        BackgroundTransparency = 1,
        Visible = false,
        ZIndex = 2,
        Position = UDim2.fromOffset(2, 2),
        Size = UDim2.fromOffset(14, 14),
        Image = u1.PadImage,
        ImageColor3 = Theme.Paper
    });
    local v9 = Panels.make("Frame", v4, "Shade", {
        BackgroundTransparency = 0.3,
        BorderSizePixel = 0,
        Visible = false,
        Active = false,
        Size = UDim2.fromScale(1, 1),
        BackgroundColor3 = Theme.Ink
    });
    Panels.fullscreenShade(v4, v9);
    Skin.shade(v9);
    local v10 = Panels.make("Frame", v9, "Wheel", {
        BackgroundTransparency = 1,
        Size = UDim2.fromOffset(600, 645),
        Position = UDim2.fromScale(0.5, 0.5),
        AnchorPoint = Vector2.new(0.5, 0.5)
    });
    Panels.make("UIScale", v10, "Scale", {});
    Panels.text(v10, "Eyebrow", "VALLEY RUN  /  A LITTLE PERSONALITY", 30, 0, 500, 22, 11, Theme.Purple);
    Panels.text(v10, "Title", "EMOTES", 30, 24, 190, 38, 29, Theme.Paper).Font = Enum.Font.GothamBold;
    local v11 = Panels.button(v10, "Close", "×", 526, 12, 44, 44, Theme.Ink);
    Theme.button(v11, Theme.Purple);
    v11.Modal = true;
    v11.TextSize = 25;
    Skin.button(v11, "close");
    local v12 = Panels.make("Frame", v10, "Ring", {
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromOffset(300, 294),
        Size = UDim2.fromOffset(400, 400)
    });
    Panels.corner(v12, 200);
    Panels.stroke(v12, Theme.Purple, 0.55);
    Skin.panel(v12, {
        transparency = 0.45
    });
    local v13 = Panels.make("Frame", v10, "Center", {
        BorderSizePixel = 0,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = v12.Position,
        Size = UDim2.fromOffset(170, 170),
        BackgroundColor3 = Theme.Ink
    });
    Panels.corner(v13, 100);
    Panels.stroke(v13, Theme.Purple, 0.45);
    Skin.panel(v13, {
        transparency = 0.1
    });
    local icon2 = Skin.icon;
    local v14 = Panels.text(v13, "Glyph", "☺", 20, 33, 130, 30, 28, Theme.Purple);
    v14.TextXAlignment = Center;
    icon2(v14, "emote");
    local v15 = Panels.text(v13, "EmoteName", "EMOTES", 20, 63, 130, 34, 15, Theme.Paper);
    v15.TextXAlignment = Center;
    v15.Font = Enum.Font.GothamBold;
    local v16 = Panels.button(v13, "MyEmotes", "MY EMOTES", 26, 103, 118, 28, Theme.Ink);
    Theme.button(v16, Theme.Purple);
    v16.TextSize = 11;
    Skin.button(v16, "dark");
    local v17 = Panels.button(v13, "Stop", "STOP EMOTE", 26, 137, 118, 28, Theme.Ink);
    Theme.button(v17, Theme.Mint);
    v17.TextSize = 11;
    v17.Visible = false;
    Skin.button(v17, "primary");
    local v18 = {};

    for i = 1, u1.Slots do
        local v19 = Panels.button(v10, "Slot" .. i, "", 0, 0, 146, 80, Theme.Ink);
        v19.AnchorPoint = Vector2.new(0.5, 0.5);
        Theme.button(v19, Theme.Purple);
        Skin.slot(v19, "idle", {
            transparency = 0.12
        });
        Panels.text(v19, "Number", tostring(i), 10, 6, 20, 18, 10, Skin.Palette.gold).Font = Enum.Font.GothamBold;
        local v20 = Panels.text(v19, "Caption", "", 12, 14, 122, 34, 15, Theme.Paper);
        v20.TextXAlignment = Center;
        v20.Font = Enum.Font.GothamBold;
        Panels.text(v19, "Source", "", 6, 52, 134, 22, 10, Theme.Purple).TextXAlignment = Center;
        v18[i] = v19;
        local _ = i;
    end;

    local v21 = Panels.button(v10, "GetEmotes", "GET EMOTES", 210, 545, 180, 38, Theme.Ink);
    Theme.button(v21, Theme.Gold);
    v21.TextSize = 13;
    Skin.button(v21, "primary");
    local v22 = Panels.button(v10, "Ultimate", "ULTIMATE", 20, 545, 180, 38, Theme.Ink);
    Theme.button(v22, Theme.Gold);
    v22.TextSize = 13;
    v22.Visible = false;
    Skin.button(v22, "buy-coins");
    Panels.text(v10, "Hint", "CHOOSE AN EMOTE · WALK AWAY TO STOP", 40, 591, 520, 20, 11, Theme.Muted).TextXAlignment = Center;
    Panels.text(v10, "Status", "", 40, 613, 520, 28, 12, Theme.Gold).TextXAlignment = Center;

    return v4, v18;
end;

local function compactFor(p23) -- Line: 53
    local v24;

    if p23.X > p23.Y then
        v24 = p23.Y < 500;
    else
        v24 = false;
    end;

    return v24;
end;

local function stack(p25, p26) -- Line: 55
    local u27 = p26 and 144 or 170;
    local v28 = p26 and 104 or 118;
    local v29 = p26 and 24 or 28;
    local u30 = p26 and 5 or 6;
    local Glyph = p25.Glyph;
    local EmoteName = p25.EmoteName;
    local MyEmotes = p25.MyEmotes;
    local Stop = p25.Stop;
    Glyph.Visible = not p26 and not Stop.Visible;
    EmoteName.TextSize = p26 and 13 or 15;
    MyEmotes.TextSize = p26 and 10 or 11;
    Stop.TextSize = MyEmotes.TextSize;
    local math_floor_ret = math.floor((u27 - (34 + u30 + v29 + (Glyph.Visible and (30 + u30 or 0) or 0) + (Stop.Visible and (v29 + u30 or 0) or 0))) / 2);

    local function place(p31, p32, p33) -- Line: 63
        -- upvalues: u27 (copy), math_floor_ret (ref), u30 (copy)
        p31.Size = UDim2.fromOffset(p32, p33);
        p31.Position = UDim2.fromOffset(math.floor((u27 - p32) / 2), math_floor_ret);
        math_floor_ret = math_floor_ret + (p33 + u30);
    end;

    if Glyph.Visible then
        local v34 = u27 - 40;
        Glyph.Size = UDim2.fromOffset(v34, 30);
        Glyph.Position = UDim2.fromOffset(math.floor((u27 - v34) / 2), math_floor_ret);
        math_floor_ret = math_floor_ret + (30 + u30);
    end;

    local v35 = p26 and 110 or 130;
    EmoteName.Size = UDim2.fromOffset(v35, 34);
    EmoteName.Position = UDim2.fromOffset(math.floor((u27 - v35) / 2), math_floor_ret);
    math_floor_ret = math_floor_ret + (34 + u30);
    MyEmotes.Size = UDim2.fromOffset(v28, v29);
    MyEmotes.Position = UDim2.fromOffset(math.floor((u27 - v28) / 2), math_floor_ret);
    math_floor_ret = math_floor_ret + (v29 + u30);

    if Stop.Visible then
        Stop.Size = UDim2.fromOffset(v28, v29);
        Stop.Position = UDim2.fromOffset(math.floor((u27 - v28) / 2), math_floor_ret);
        math_floor_ret = math_floor_ret + (v29 + u30);
    end;
end;

function u1.setStop(p36, p37) -- Line: 69
    -- upvalues: stack (copy)
    local Center2 = p36.Shade.Wheel.Center;

    if Center2.Stop.Visible == p37 then
        return;
    end;

    Center2.Stop.Visible = p37;
    local AbsoluteSize = p36.AbsoluteSize;
    local v38;

    if AbsoluteSize.X > AbsoluteSize.Y then
        v38 = AbsoluteSize.Y < 500;
    else
        v38 = false;
    end;

    stack(Center2, v38);
end;

function u1.badge(p39, p40) -- Line: 75
    local Badge = p39.Open.Badge;
    local v41 = p40 == Enum.PreferredInput.KeyboardAndMouse;
    local v42 = p40 == Enum.PreferredInput.Gamepad;
    Badge.Visible = v41 or v42;
    Badge.Key.Visible = v41;
    Badge.Pad.Visible = v42;
end;

function u1.dim(p43, p44) -- Line: 81
    -- upvalues: Theme (copy)
    local Open = p43.Open;
    local SkinIcon = Open.Face:FindFirstChild("SkinIcon");

    if SkinIcon then
        SkinIcon.ImageTransparency = p44 and 0.55 or 0;
    else
        Open.Face.TextTransparency = p44 and 0.55 or 0;
    end;

    Open.Label.TextColor3 = p44 and Theme.Muted or Theme.Paper;
    Open.BackgroundTransparency = p44 and 0.5 or 0.25;
    Open.Badge.Outline.Transparency = p44 and 0.7 or 0.35;
end;

function u1.layout(p45, p46) -- Line: 90
    -- upvalues: stack (copy), u1 (copy)
    local v47 = p46 or p45.AbsoluteSize;

    if v47.X < 1 or v47.Y < 1 then
        return;
    end;

    local v48;

    if v47.X > v47.Y then
        v48 = v47.Y < 500;
    else
        v48 = false;
    end;

    local Wheel = p45.Shade.Wheel;
    local v49 = v48 and 700 or 600;
    local v50 = v48 and 365 or 645;
    Wheel.Size = UDim2.fromOffset(v49, v50);
    Wheel.Scale.Scale = math.min(1.1, v47.X * 0.96 / v49, v47.Y * 0.96 / v50);
    Wheel.Eyebrow.Visible = not v48;
    Wheel.Title.Position = UDim2.fromOffset(30, v48 and 5 or 24);
    Wheel.Close.Position = UDim2.fromOffset(v49 - 66, v48 and 5 or 12);
    local Vector2_new_ret = Vector2.new(v49 / 2, v48 and 177 or 294);
    Wheel.Ring.Position = UDim2.fromOffset(Vector2_new_ret.X, Vector2_new_ret.Y);
    Wheel.Ring.Size = UDim2.fromOffset(v48 and 405 or 400, v48 and 250 or 400);
    Wheel.Center.Position = Wheel.Ring.Position;
    Wheel.Center.Size = UDim2.fromOffset(v48 and 144 or 170, v48 and 144 or 170);
    stack(Wheel.Center, v48);

    for i = 1, u1.Slots do
        local v51 = -1.5707963267948966 + (i - 1) * 3.141592653589793 * 2 / u1.Slots;
        local v52 = Wheel["Slot" .. i];
        v52.Position = UDim2.fromOffset(Vector2_new_ret.X + math.cos(v51) * (v48 and 232 or 212), Vector2_new_ret.Y + math.sin(v51) * (v48 and 108 or 201));
        v52.Size = UDim2.fromOffset(146, v48 and 70 or 80);
        v52.Caption.Position = UDim2.fromOffset(12, v48 and 8 or 14);
        v52.Caption.Size = UDim2.fromOffset(122, v48 and 30 or 34);
        v52.Source.Position = UDim2.fromOffset(6, v48 and 42 or 52);
        local _ = i;
    end;

    Wheel.GetEmotes.Size = UDim2.fromOffset(180, v48 and 34 or 38);
    Wheel.GetEmotes.Position = v48 and UDim2.fromOffset(v49 - 196, 300) or UDim2.fromOffset(v49 / 2 - 90, 545);
    Wheel.Ultimate.Size = Wheel.GetEmotes.Size;
    Wheel.Ultimate.Position = v48 and UDim2.fromOffset(16, 300) or UDim2.fromOffset(v49 / 2 - 280, 545);
    Wheel.Hint.Position = UDim2.fromOffset(v49 / 2 - 260, 591);
    Wheel.Hint.Visible = not v48;
    Wheel.Status.Position = UDim2.fromOffset(v49 / 2 - 260, v48 and 337 or 613);
    Wheel.Status.TextSize = v48 and 10 or 12;
end;

return u1;