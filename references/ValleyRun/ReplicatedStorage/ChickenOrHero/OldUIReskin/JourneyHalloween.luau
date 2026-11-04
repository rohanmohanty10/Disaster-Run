 

 

local RunService = game:GetService("RunService");
game:GetService("ContentProvider");
local Skin = require(script.Parent:WaitForChild("Skin"));
local u1 = {};
local u2 = {
    Pumpkin = "rbxassetid://122172980164834",
    Bat = "rbxassetid://70771941159898",
    Moon = "rbxassetid://108163343124811",
    Web = "rbxassetid://77897902869831",
    Spider = "rbxassetid://100826167291348",
    Ghost = "rbxassetid://121891052662054",
    Tombstone = "rbxassetid://109374624586738",
    WitchHat = "rbxassetid://78688261007229",
    Cauldron = "rbxassetid://83317730984861",
    Graveyard = "rbxassetid://126547294477184"
};
u1.Images = u2;
local u3 = {
    night = Color3.fromRGB(34, 16, 48),
    deep = Color3.fromRGB(11, 6, 17),
    shade = Color3.fromRGB(14, 6, 22),
    pumpkin = Color3.fromRGB(255, 132, 28),
    ember = Color3.fromRGB(255, 184, 72),
    witch = Color3.fromRGB(176, 98, 255),
    mist = Color3.fromRGB(196, 170, 255),
    fog = Color3.fromRGB(120, 78, 170),
    moon = Color3.fromRGB(255, 238, 196),
    web = Color3.fromRGB(226, 220, 240)
};
u1.Colors = u3;
local Font_fromEnum_ret = Font.fromEnum(Enum.Font.Creepster);
local u4 = { { 0.37, 26, 54, 1.6, 0 }, { 0.47, 54, 40, 2.1, 1.7 }, { 0.69, 20, 48, 1.8, 3.1 }, { 0.76, 50, 36, 2.4, 4.6 } };

local function make(p5, p6, p7) -- Line: 56
    local Instance_new_ret = Instance.new(p5);

    for i, v in p7 do
        Instance_new_ret[i] = v;
    end;

    Instance_new_ret.Parent = p6;

    return Instance_new_ret;
end;

local function deco(p8, p9, p10) -- Line: 65
    p10.BorderSizePixel = 0;
    p10.Active = false;
    p10.Interactable = false;

    if p8 ~= "Frame" then
        p10.BackgroundTransparency = 1;
    end;

    local Instance_new_ret = Instance.new(p8);

    for i, v in p10 do
        Instance_new_ret[i] = v;
    end;

    Instance_new_ret.Parent = p9;

    return Instance_new_ret;
end;

local function round(p11) -- Line: 74
    local v12 = {
        CornerRadius = UDim.new(1, 0)
    };
    local UICorner = Instance.new("UICorner");

    for i, v in v12 do
        UICorner[i] = v;
    end;

    UICorner.Parent = p11;

    return p11;
end;

local function picture(p13, p14, p15, p16, p17) -- Line: 78
    -- upvalues: u2 (copy)
    local v18 = p17 or {};
    v18.Name = p14;
    v18.Image = u2[p15];
    v18.ScaleType = Enum.ScaleType.Fit;
    v18.Size = v18.Size or UDim2.fromOffset(p16, p16);
    v18.AnchorPoint = v18.AnchorPoint or Vector2.new(0.5, 0.5);
    v18.BorderSizePixel = 0;
    v18.Active = false;
    v18.Interactable = false;
    v18.BackgroundTransparency = 1;
    local ImageLabel = Instance.new("ImageLabel");

    for i, v in v18 do
        ImageLabel[i] = v;
    end;

    ImageLabel.Parent = p13;

    return ImageLabel;
end;

function u1.apply(u19) -- Line: 90
    -- upvalues: Skin (copy), u3 (copy), Font_fromEnum_ret (copy), picture (copy), u4 (copy), u1 (copy)
    local panel = u19.panel;
    Skin.panel(panel, {
        color = u3.night,
        accent = u3.pumpkin,
        radius = UDim.new(0, 15)
    });
    panel.BackgroundColor3 = Color3.new(1, 1, 1);
    local v20 = {
        Name = "HalloweenGradient",
        Rotation = 90,
        Color = ColorSequence.new(u3.night, u3.deep)
    };
    local UIGradient = Instance.new("UIGradient");
    local u21 = {
        connection = nil,
        preloaded = false,
        parts = u19
    };

    for i, v in v20 do
        UIGradient[i] = v;
    end;

    UIGradient.Parent = panel;

    if u19.shade then
        u19.shade.BackgroundColor3 = u3.shade;
    end;

    local heading = u19.heading;
    heading.FontFace = Font_fromEnum_ret;
    heading.TextColor3 = u3.pumpkin;
    local v22 = Skin.textStroke(heading, 2);

    if v22 then
        v22.Color = Color3.fromRGB(40, 8, 30);
    end;

    if u19.edition then
        u19.edition.TextColor3 = u3.mist;
    end;

    if u19.tierText then
        u19.tierText.TextColor3 = u3.ember;
    end;

    if u19.ends then
        u19.ends.TextColor3 = u3.ember;
    end;

    if u19.progress and u19.fill then
        Skin.bar(u19.progress, u19.fill, u3.pumpkin);
        u19.fill.BackgroundColor3 = Color3.new(1, 1, 1);
        local fill = u19.fill;
        local v23 = {
            Name = "HalloweenGradient",
            Color = ColorSequence.new(u3.pumpkin, u3.witch)
        };
        local UIGradient2 = Instance.new("UIGradient");

        for i, v in v23 do
            UIGradient2[i] = v;
        end;

        UIGradient2.Parent = fill;
    end;

    for _, v in u19.cards do
        local v24 = v.lane == "Free";
        local v25;

        if v24 then
            v25 = u3.pumpkin;
        else
            v25 = u3.witch;
        end;

        v.accent = v25;
        Skin.card(v.card, v25, {
            radius = UDim.new(0, 10)
        });
        v.route.TextColor3 = v25;

        if v.number then
            v.number.TextColor3 = u3.ember;
        end;

        picture(v.card, "HalloweenMark", v24 and "Pumpkin" or "WitchHat", 30, {
            AnchorPoint = Vector2.new(1, 0),
            Position = UDim2.new(1, -4, 0, 2),
            Rotation = v24 and -8 or 12,
            ZIndex = v.route.ZIndex + 1
        });
    end;

    local v26 = {
        Name = "HalloweenNight",
        BackgroundTransparency = 1,
        ClipsDescendants = true,
        ZIndex = -1,
        Size = UDim2.fromScale(1, 1),
        BorderSizePixel = 0,
        Active = false,
        Interactable = false
    };
    local Frame = Instance.new("Frame");

    for i, v in v26 do
        Frame[i] = v;
    end;

    Frame.Parent = panel;
    u21.night = Frame;
    local v27 = {
        Name = "Moon",
        BackgroundTransparency = 1,
        ZIndex = 0,
        AnchorPoint = Vector2.new(0.5, 0),
        Position = UDim2.new(0.58, 0, 0, -62),
        Size = UDim2.fromOffset(150, 150),
        BorderSizePixel = 0,
        Active = false,
        Interactable = false
    };
    local Frame2 = Instance.new("Frame");

    for i, v in v27 do
        Frame2[i] = v;
    end;

    Frame2.Parent = Frame;

    for i, v in { { 1.5, 0.94 }, { 1.22, 0.88 } } do
        local v28 = {
            Name = "Halo" .. i,
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromScale(0.5, 0.5),
            Size = UDim2.fromScale(v[1], v[1]),
            BackgroundColor3 = u3.moon,
            BackgroundTransparency = v[2],
            BorderSizePixel = 0,
            Active = false,
            Interactable = false
        };
        local Frame3 = Instance.new("Frame");

        for i2, v2 in v28 do
            Frame3[i2] = v2;
        end;

        Frame3.Parent = Frame2;
        local v29 = {
            CornerRadius = UDim.new(1, 0)
        };
        local UICorner = Instance.new("UICorner");

        for i2, v2 in v29 do
            UICorner[i2] = v2;
        end;

        UICorner.Parent = Frame3;
    end;

    picture(Frame2, "Face", "Moon", 150, {
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(1, 1)
    });
    u21.moon = Frame2;
    picture(Frame, "WebLeft", "Web", 104, {
        ImageTransparency = 0.68,
        AnchorPoint = Vector2.new(0, 0),
        Position = UDim2.fromOffset(0, 0)
    });
    picture(Frame, "WebRight", "Web", 110, {
        Rotation = 90,
        ImageTransparency = 0.6,
        AnchorPoint = Vector2.new(1, 0),
        Position = UDim2.new(1, 0, 0, 0)
    });
    local v30 = {
        Name = "Thread",
        BackgroundTransparency = 0.45,
        AnchorPoint = Vector2.new(0.5, 0),
        Position = UDim2.new(0.3, 0, 0, 0),
        Size = UDim2.fromOffset(2, 44),
        BackgroundColor3 = u3.web,
        BorderSizePixel = 0,
        Active = false,
        Interactable = false
    };
    local Frame3 = Instance.new("Frame");

    for i, v in v30 do
        Frame3[i] = v;
    end;

    Frame3.Parent = Frame;
    picture(Frame3, "Spider", "Spider", 42, {
        Position = UDim2.new(0.5, 0, 1, 14)
    });
    u21.thread = Frame3;
    u21.bats = {};

    for i, v in u4 do
        local v31 = picture(Frame, "Bat" .. i, "Bat", v[3]);
        u21.bats[i] = {
            label = v31,
            x = v[1],
            y = v[2],
            size = v[3],
            speed = v[4],
            phase = v[5]
        };
    end;

    local v32 = {
        Name = "Lantern",
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(0, 0.5),
        Size = UDim2.fromOffset(44, 44),
        BorderSizePixel = 0,
        Active = false,
        Interactable = false
    };
    local Frame4 = Instance.new("Frame");

    for i, v in v32 do
        Frame4[i] = v;
    end;

    Frame4.Parent = Frame;
    local v33 = {
        Name = "Glow",
        BackgroundTransparency = 0.6,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.58),
        Size = UDim2.fromScale(1.5, 1.5),
        BackgroundColor3 = u3.pumpkin,
        BorderSizePixel = 0,
        Active = false,
        Interactable = false
    };
    local Frame5 = Instance.new("Frame");

    for i, v in v33 do
        Frame5[i] = v;
    end;

    Frame5.Parent = Frame4;
    local v34 = {
        CornerRadius = UDim.new(1, 0)
    };
    local UICorner = Instance.new("UICorner");

    for i, v in v34 do
        UICorner[i] = v;
    end;

    UICorner.Parent = Frame5;
    u21.lanternGlow = Frame5;
    u21.pumpkin = picture(Frame4, "Pumpkin", "Pumpkin", 44, {
        Position = UDim2.fromScale(0.5, 0.5)
    });
    u21.lantern = Frame4;
    local v35 = picture(Frame, "Graveyard", "Graveyard", 0, {
        ImageTransparency = 0.2,
        ZIndex = 1,
        AnchorPoint = Vector2.new(0.5, 0),
        Position = UDim2.new(0.5, 0, 0, -96),
        Size = UDim2.new(1, 0, 0, 256),
        ScaleType = Enum.ScaleType.Crop
    });
    local v36 = {
        Rotation = 90,
        Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.62, 0), NumberSequenceKeypoint.new(1, 1) })
    };
    local UIGradient2 = Instance.new("UIGradient");

    for i, v in v36 do
        UIGradient2[i] = v;
    end;

    UIGradient2.Parent = v35;
    local v37 = {
        Name = "Fog",
        ZIndex = 2,
        AnchorPoint = Vector2.new(0, 1),
        Position = UDim2.fromScale(0, 1),
        Size = UDim2.fromScale(1, 0.34),
        BackgroundColor3 = u3.fog,
        BorderSizePixel = 0,
        Active = false,
        Interactable = false
    };
    local Frame6 = Instance.new("Frame");

    for i, v in v37 do
        Frame6[i] = v;
    end;

    Frame6.Parent = Frame;
    local v38 = {
        Rotation = 90,
        Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.6, 0.85), NumberSequenceKeypoint.new(1, 0.66) })
    };
    local UIGradient3 = Instance.new("UIGradient");

    for i, v in v38 do
        UIGradient3[i] = v;
    end;

    UIGradient3.Parent = Frame6;
    u21.embers = {};

    for i = 1, 12 do
        local v39 = i % 3 + 3;
        local v40 = {
            BackgroundTransparency = 1,
            ZIndex = 3,
            Name = "Ember" .. i,
            AnchorPoint = Vector2.new(0.5, 0.5),
            Size = UDim2.fromOffset(v39, v39)
        };
        local v41;

        if i % 4 == 0 then
            v41 = u3.witch;
        else
            v41 = u3.ember;
        end;

        v40.BackgroundColor3 = v41;
        v40.BorderSizePixel = 0;
        v40.Active = false;
        v40.Interactable = false;
        local Frame7 = Instance.new("Frame");
        local v42 = i;

        for i2, v in v40 do
            Frame7[i2] = v;
        end;

        Frame7.Parent = Frame;
        local v43 = {
            CornerRadius = UDim.new(1, 0)
        };
        local UICorner2 = Instance.new("UICorner");

        for i2, v in v43 do
            UICorner2[i2] = v;
        end;

        UICorner2.Parent = Frame7;
        u21.embers[v42] = {
            frame = Frame7,
            x = (v42 - 0.5) / 12 + math.sin(v42 * 12.9898) * 0.03,
            period = v42 * 37 % 40 / 10 + 5,
            phase = v42 * 0.618 % 1,
            sway = v42 % 5 * 0.004 + 0.01
        };
    end;

    local v44 = {
        Name = "HalloweenEdge",
        BackgroundTransparency = 1,
        ZIndex = 50,
        Size = UDim2.fromScale(1, 1),
        BorderSizePixel = 0,
        Active = false,
        Interactable = false
    };
    local Frame7 = Instance.new("Frame");

    for i, v in v44 do
        Frame7[i] = v;
    end;

    Frame7.Parent = panel;
    picture(Frame7, "Tombstone", "Tombstone", 104, {
        Rotation = -6,
        Position = UDim2.new(0, -64, 1, -34)
    });
    local v45 = {
        Name = "PumpkinGlow",
        BackgroundTransparency = 0.85,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0, -26, 1, 4),
        Size = UDim2.fromOffset(120, 120),
        BackgroundColor3 = u3.pumpkin,
        BorderSizePixel = 0,
        Active = false,
        Interactable = false
    };
    local Frame8 = Instance.new("Frame");

    for i, v in v45 do
        Frame8[i] = v;
    end;

    Frame8.Parent = Frame7;
    local v46 = {
        CornerRadius = UDim.new(1, 0)
    };
    local UICorner2 = Instance.new("UICorner");

    for i, v in v46 do
        UICorner2[i] = v;
    end;

    UICorner2.Parent = Frame8;
    u21.cornerGlow = Frame8;
    picture(Frame7, "Pumpkin", "Pumpkin", 92, {
        Position = UDim2.new(0, -26, 1, -4)
    });
    u21.cauldron = picture(Frame7, "Cauldron", "Cauldron", 112, {
        Position = UDim2.new(1, 34, 1, -6)
    });
    u21.hat = picture(Frame7, "WitchHat", "WitchHat", 88, {
        Rotation = 16,
        Position = UDim2.new(1, -6, 0, -32)
    });
    u21.ghost = picture(Frame7, "Ghost", "Ghost", 104, {
        ImageTransparency = 0.08,
        Position = UDim2.new(1, 34, 0.46, 0)
    });
    u21.edge = Frame7;

    function u21.step() -- Line: 307
        -- upvalues: u19 (copy), Frame4 (copy), u21 (copy)
        local os_clock_ret = os.clock();
        local heading2 = u19.heading;
        Frame4.Position = UDim2.fromOffset(heading2.Position.X.Offset + heading2.TextBounds.X + 6, heading2.Position.Y.Offset + heading2.Size.Y.Offset / 2);
        local v47 = math.sin(os_clock_ret * 9.1) * 0.5 * math.sin(os_clock_ret * 3.7 + 1.3) + 0.5;
        u21.lanternGlow.BackgroundTransparency = v47 * 0.2 + 0.5;
        u21.cornerGlow.BackgroundTransparency = (math.sin(os_clock_ret * 7.3 + 2) * 0.5 * math.sin(os_clock_ret * 2.9) + 0.5) * 0.16 + 0.66;
        u21.pumpkin.Rotation = math.sin(os_clock_ret * 1.4) * 6;

        for _, v in u21.bats do
            local v48 = os_clock_ret * v.speed + v.phase;
            local math_sin_ret = math.sin(v48 * 4);
            local v49 = math.abs(math_sin_ret) * 0.38 + 0.62;
            v.label.Position = UDim2.new(v.x + math.sin(v48 * 0.5) * 0.02, 0, 0, v.y + math.sin(v48) * 7);
            v.label.Size = UDim2.fromOffset(v.size, v.size * v49);
            v.label.Rotation = math.sin(v48 * 0.9) * 10;
        end;

        u21.thread.Rotation = math.sin(os_clock_ret * 0.9) * 9;
        u21.thread.Size = UDim2.fromOffset(2, math.sin(os_clock_ret * 0.6) * 10 + 44);
        u21.moon.Rotation = math.sin(os_clock_ret * 0.2) * 2;
        u21.hat.Rotation = math.sin(os_clock_ret * 1.1) * 4 + 16;
        u21.cauldron.Rotation = math.sin(os_clock_ret * 5.3) * 1.5;
        u21.ghost.Position = UDim2.new(1, math.sin(os_clock_ret * 0.7) * 8 + 34, 0.46, math.sin(os_clock_ret * 1.3) * 10);
        u21.ghost.ImageTransparency = (math.sin(os_clock_ret * 0.5) * 0.5 + 0.5) * 0.3 + 0.08;

        for _, v in u21.embers do
            local v50 = (os_clock_ret / v.period + v.phase) % 1;
            v.frame.Position = UDim2.fromScale(v.x + math.sin(os_clock_ret * 0.8 + v.phase * 6) * v.sway, 1 - v50 * 0.62);
            local v51;

            if v50 < 0.15 then
                v51 = 1 - v50 / 0.15 * 0.75;
            else
                v51 = 0.25 + (v50 - 0.15) / 0.85 * 0.75;
            end;

            v.frame.BackgroundTransparency = v51;
        end;
    end;

    u21.step();

    return setmetatable(u21, {
        __index = u1
    });
end;

function u1.open(p52, p53) -- Line: 345
    -- upvalues: RunService (copy)
    if p53 and not p52.connection then
        p52.connection = RunService.RenderStepped:Connect(p52.step);

        return;
    end;

    if not p53 and p52.connection then
        p52.connection:Disconnect();
        p52.connection = nil;
    end;
end;

function u1.destroy(p54) -- Line: 354
    p54:open(false);

    for _, v in { p54.night, p54.edge } do
        v:Destroy();
    end;

    p54.night = nil;
    p54.edge = nil;
    p54.embers = nil;
    p54.bats = nil;
    p54.parts = nil;
end;

return u1;