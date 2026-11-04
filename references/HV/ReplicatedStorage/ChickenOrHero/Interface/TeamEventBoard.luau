 

 

local TweenService = game:GetService("TweenService");
local TeamEventConfig = require(script.Parent.Parent:WaitForChild("Progression"):WaitForChild("TeamEventConfig"));
local u1 = {};
local Font_new_ret = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.ExtraBold);
local Font_new_ret2 = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy);
local Font_new_ret3 = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Italic);
local Font_new_ret4 = Font.new("rbxasset://fonts/families/Sarpanch.json", Enum.FontWeight.Heavy);
local Color3_fromRGB_ret = Color3.fromRGB(16, 22, 44);
local Color3_fromRGB_ret2 = Color3.fromRGB(5, 7, 15);
local Color3_fromRGB_ret3 = Color3.fromRGB(214, 218, 232);
local Color3_fromRGB_ret4 = Color3.fromRGB(150, 156, 180);
local Color3_fromRGB_ret5 = Color3.fromRGB(255, 202, 58);
local Color3_fromRGB_ret6 = Color3.fromRGB(255, 146, 24);
local Color3_fromRGB_ret7 = Color3.fromRGB(255, 170, 60);
local Color3_fromRGB_ret8 = Color3.fromRGB(58, 62, 82);
local Color3_fromRGB_ret9 = Color3.fromRGB(30, 96, 52);
local Color3_fromRGB_ret10 = Color3.fromRGB(22, 76, 41);
local Color3_new_ret = Color3.new(1, 1, 1);
local Color3_new_ret2 = Color3.new(0, 0, 0);
local UDim_new_ret = UDim.new(1, 0);
local Vector2_new_ret = Vector2.new(0.5, 0.5);
local u2 = #TeamEventConfig.TeamLevels;
local u3 = {
    Football = true
};
local u4 = {
    {
        top = Color3.fromRGB(255, 238, 150),
        bottom = Color3_fromRGB_ret6,
        text = Color3.fromRGB(74, 40, 0)
    },
    {
        top = Color3.fromRGB(250, 252, 255),
        bottom = Color3.fromRGB(146, 154, 176),
        text = Color3.fromRGB(30, 34, 48)
    },
    {
        top = Color3.fromRGB(246, 176, 116),
        bottom = Color3.fromRGB(146, 78, 34),
        text = Color3.fromRGB(50, 20, 2)
    }
};
local u5 = {
    loading = {
        words = "LOADING TEAM TOTALS...",
        pulse = true,
        top = Color3_fromRGB_ret8,
        bottom = Color3.fromRGB(28, 30, 44),
        edge = Color3.fromRGB(96, 102, 128),
        text = Color3_fromRGB_ret3
    },
    delayed = {
        words = "UPDATE DELAYED · LAST TOTALS",
        pulse = true,
        top = Color3.fromRGB(96, 70, 14),
        bottom = Color3.fromRGB(34, 24, 6),
        edge = Color3_fromRGB_ret7,
        text = Color3_fromRGB_ret7
    },
    final = {
        words = "FINAL RESULTS",
        sport = true,
        top = Color3.fromRGB(70, 74, 92),
        bottom = Color3.fromRGB(34, 36, 48),
        edge = Color3_new_ret,
        text = Color3_new_ret
    },
    winner = {
        words = "👑 WINNER · FINAL 👑",
        sport = true,
        shine = true,
        top = Color3.fromRGB(255, 238, 150),
        bottom = Color3_fromRGB_ret6,
        edge = Color3_new_ret,
        text = Color3.fromRGB(74, 40, 0)
    }
};
local NumberSequence_new_ret = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 1),
    NumberSequenceKeypoint.new(0.4, 1),
    NumberSequenceKeypoint.new(0.5, 0.55),
    NumberSequenceKeypoint.new(0.6, 1),
    NumberSequenceKeypoint.new(1, 1)
});
local TweenInfo_new_ret = TweenInfo.new(1.1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, -1, false, 4);
local TweenInfo_new_ret2 = TweenInfo.new(0.9, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true);

local function make(p6, p7, p8) -- Line: 59
    local Instance_new_ret = Instance.new(p6);

    for i, v in p8 do
        Instance_new_ret[i] = v;
    end;

    Instance_new_ret.Parent = p7;

    return Instance_new_ret;
end;

local function stroke(p9, p10, p11, p12) -- Line: 67
    local v13 = {
        Color = p10,
        Thickness = p11,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    };
    local UIStroke = Instance.new("UIStroke");

    for i, v in v13 do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = p9;

    for i, v in p12 or {} do
        UIStroke[i] = v;
    end;

    return UIStroke;
end;

local function corner(p14, p15) -- Line: 74
    local UICorner = Instance.new("UICorner");

    for i, v in {
        CornerRadius = p15
    } do
        UICorner[i] = v;
    end;

    UICorner.Parent = p14;

    return UICorner;
end;

local function gradient(p16, p17, p18, p19) -- Line: 77
    local v20 = {
        Color = ColorSequence.new(p17, p18),
        Rotation = p19 or 90
    };
    local UIGradient = Instance.new("UIGradient");

    for i, v in v20 do
        UIGradient[i] = v;
    end;

    UIGradient.Parent = p16;

    return UIGradient;
end;

local function label(p21, p22, p23, p24, p25) -- Line: 80
    -- upvalues: Font_new_ret (copy)
    local v26 = {
        BackgroundTransparency = 1,
        FontFace = Font_new_ret,
        Text = p22,
        TextSize = p23,
        TextColor3 = p24,
        TextXAlignment = Enum.TextXAlignment.Left
    };
    local TextLabel = Instance.new("TextLabel");

    for i, v in v26 do
        TextLabel[i] = v;
    end;

    TextLabel.Parent = p21;

    for i, v in p25 do
        TextLabel[i] = v;
    end;

    return TextLabel;
end;

local function outline(p27, p28, p29) -- Line: 94
    local v30 = {
        Name = "Outline",
        Color = p28,
        Thickness = p29,
        LineJoinMode = Enum.LineJoinMode.Round
    };
    local UIStroke = Instance.new("UIStroke");

    for i, v in v30 do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = p27;

    return p27;
end;

local function play(p31, p32, p33, p34, p35) -- Line: 98
    -- upvalues: TweenService (copy)
    local v36 = p31.tweens[p32];

    if v36 then
        v36:Cancel();
    end;

    local v37 = TweenService:Create(p33, p34, p35);
    p31.tweens[p32] = v37;
    v37:Play();
end;

local function stop(p38, p39) -- Line: 107
    local v40 = p38.tweens[p39];

    if v40 then
        p38.tweens[p39] = nil;
        v40:Cancel();
    end;
end;

local function shine(p41, p42) -- Line: 115
    -- upvalues: Color3_new_ret (copy), NumberSequence_new_ret (copy)
    local v43 = {
        Name = "Shine",
        ZIndex = 9,
        Size = UDim2.fromScale(1, 1),
        BackgroundColor3 = Color3_new_ret
    };
    local Frame = Instance.new("Frame");

    for i, v in v43 do
        Frame[i] = v;
    end;

    Frame.Parent = p41;
    local UICorner = Instance.new("UICorner");

    for i, v in {
        CornerRadius = p42
    } do
        UICorner[i] = v;
    end;

    UICorner.Parent = Frame;
    local v44 = {
        Rotation = 20,
        Offset = Vector2.new(-1, 0),
        Transparency = NumberSequence_new_ret
    };
    local UIGradient = Instance.new("UIGradient");

    for i, v in v44 do
        UIGradient[i] = v;
    end;

    UIGradient.Parent = Frame;

    return UIGradient;
end;

function u1.team(p45) -- Line: 127
    -- upvalues: TeamEventConfig (copy)
    for _, v in TeamEventConfig.Teams do
        if TeamEventConfig.Team[v].BoardKey == p45 then
            return v;
        end;
    end;

    return nil;
end;

function u1.status(p46) -- Line: 137
    return (p46.status == "loading" or p46.updatedAt == 0) and "loading" or (p46.final == true and (p46.winner == true and "winner" or "final") or (p46.status == "retrying" and "delayed" or "live"));
end;

function u1.medal(p47, p48) -- Line: 148
    -- upvalues: u4 (copy)
    return u4[p47] or p48;
end;

function u1.build(p49, p50) -- Line: 154
    -- upvalues: u1 (copy), TeamEventConfig (copy), u2 (copy), Color3_new_ret (copy), Color3_new_ret2 (copy), Color3_fromRGB_ret5 (copy), Color3_fromRGB_ret2 (copy), Color3_fromRGB_ret (copy), stroke (copy), Vector2_new_ret (copy), UDim_new_ret (copy), label (copy), Font_new_ret3 (copy), Font_new_ret2 (copy), shine (copy), Font_new_ret4 (copy), Color3_fromRGB_ret8 (copy), Color3_fromRGB_ret4 (copy), Color3_fromRGB_ret9 (copy), u3 (copy), Color3_fromRGB_ret10 (copy), Color3_fromRGB_ret3 (copy), Font_new_ret (copy), TweenInfo_new_ret (copy), TweenService (copy)
    local v51 = u1.team(p50);
    local v52;

    if v51 then
        v52 = TeamEventConfig.Team[v51];
    else
        v52 = v51;
    end;

    if not v52 then
        return nil;
    end;

    local Color = v52.Color;
    local MainFrame = p49.MainFrame;
    local v53 = {
        tweens = {},
        pips = table.create(u2),
        look = {
            outline = true,
            top = Color:Lerp(Color3_new_ret, 0.25),
            bottom = Color:Lerp(Color3_new_ret2, 0.3),
            text = Color3_new_ret
        },
        fill = ColorSequence.new(Color:Lerp(Color3_new_ret2, 0.4), Color3.fromRGB(14, 16, 28)),
        mine = ColorSequence.new(Color:Lerp(Color3_fromRGB_ret5, 0.35), Color:Lerp(Color3_new_ret2, 0.45)),
        edge = Color:Lerp(Color3_new_ret, 0.35)
    };
    p49.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
    MainFrame.Title.Visible = false;
    MainFrame.Status.Visible = false;
    MainFrame.BackgroundColor3 = Color3_fromRGB_ret2;
    MainFrame.BackgroundTransparency = 0;
    MainFrame.BorderSizePixel = 0;
    MainFrame.ClipsDescendants = true;
    local v54 = {
        Name = "Stadium",
        ZIndex = 0,
        Position = UDim2.fromOffset(6, 6),
        Size = UDim2.new(1, -12, 1, -12),
        BackgroundColor3 = Color3_new_ret
    };
    local Frame = Instance.new("Frame");

    for i, v in v54 do
        Frame[i] = v;
    end;

    Frame.Parent = MainFrame;
    local v55 = {
        CornerRadius = UDim.new(0, 18)
    };
    local UICorner = Instance.new("UICorner");

    for i, v in v55 do
        UICorner[i] = v;
    end;

    UICorner.Parent = Frame;
    local v56 = {
        Rotation = 90,
        Color = ColorSequence.new(Color3_fromRGB_ret, Color3_fromRGB_ret2)
    };
    local UIGradient = Instance.new("UIGradient");

    for i, v in v56 do
        UIGradient[i] = v;
    end;

    UIGradient.Parent = Frame;
    stroke(Frame, Color3_new_ret2, 4);
    local v57 = stroke(Frame, Color3_new_ret, 3, {
        ZIndex = 2
    });
    local v58 = {
        Rotation = 90,
        Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color:Lerp(Color3_new_ret, 0.2)), ColorSequenceKeypoint.new(0.5, Color3_fromRGB_ret5), ColorSequenceKeypoint.new(1, Color:Lerp(Color3_new_ret, 0.2)) })
    };
    local UIGradient2 = Instance.new("UIGradient");

    for i, v in v58 do
        UIGradient2[i] = v;
    end;

    UIGradient2.Parent = v57;

    for _, v in { 0.05, 0.95 } do
        local v59 = {
            Name = "Lights",
            BackgroundTransparency = 1,
            Image = "rbxassetid://120639974824188",
            ImageTransparency = 0.68,
            AnchorPoint = Vector2_new_ret,
            Position = UDim2.fromScale(v, 0.02),
            Size = UDim2.fromScale(0.95, 0.5),
            ImageColor3 = Color:Lerp(Color3_new_ret, 0.15)
        };
        local ImageLabel = Instance.new("ImageLabel");

        for i, v2 in v59 do
            ImageLabel[i] = v2;
        end;

        ImageLabel.Parent = Frame;
    end;

    local v60 = {
        Name = "EventTag",
        BackgroundTransparency = 0.3,
        ZIndex = 2,
        AnchorPoint = Vector2.new(0.5, 0),
        Position = UDim2.new(0.5, 0, 0, 14),
        Size = UDim2.fromOffset(0, 36),
        AutomaticSize = Enum.AutomaticSize.X,
        BackgroundColor3 = Color3_new_ret2
    };
    local Frame2 = Instance.new("Frame");

    for i, v in v60 do
        Frame2[i] = v;
    end;

    Frame2.Parent = MainFrame;
    local v61 = {
        CornerRadius = UDim_new_ret
    };
    local UICorner2 = Instance.new("UICorner");

    for i, v in v61 do
        UICorner2[i] = v;
    end;

    UICorner2.Parent = Frame2;
    local v62 = stroke(Frame2, Color3_new_ret, 2);
    local v63 = {
        Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, TeamEventConfig.Team[TeamEventConfig.Teams[1]].Color), ColorSequenceKeypoint.new(0.5, Color3_fromRGB_ret5), ColorSequenceKeypoint.new(1, TeamEventConfig.Team[TeamEventConfig.Teams[2]].Color) })
    };
    local UIGradient3 = Instance.new("UIGradient");

    for i, v in v63 do
        UIGradient3[i] = v;
    end;

    UIGradient3.Parent = v62;
    local v64 = {
        PaddingLeft = UDim.new(0, 16),
        PaddingRight = UDim.new(0, 16)
    };
    local UIPadding = Instance.new("UIPadding");

    for i, v in v64 do
        UIPadding[i] = v;
    end;

    UIPadding.Parent = Frame2;
    local v65 = {
        FillDirection = Enum.FillDirection.Horizontal,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 8)
    };
    local UIListLayout = Instance.new("UIListLayout");

    for i, v in v65 do
        UIListLayout[i] = v;
    end;

    UIListLayout.Parent = Frame2;

    for i, v in TeamEventConfig.Teams do
        local v66 = label(Frame2, TeamEventConfig.Team[v].Name, 20, TeamEventConfig.Team[v].Color:Lerp(Color3_new_ret, 0.5), {
            AutoLocalize = false,
            Name = v,
            LayoutOrder = i == 1 and 1 or 3,
            Size = UDim2.fromOffset(0, 30),
            AutomaticSize = Enum.AutomaticSize.X,
            FontFace = Font_new_ret3
        });
        local v67 = {
            Name = "Outline",
            Thickness = 1.5,
            Color = Color3_new_ret2,
            LineJoinMode = Enum.LineJoinMode.Round
        };
        local UIStroke = Instance.new("UIStroke");

        for i2, v2 in v67 do
            UIStroke[i2] = v2;
        end;

        UIStroke.Parent = v66;
    end;

    local v68 = {
        Name = "Versus",
        LayoutOrder = 2,
        BackgroundTransparency = 1,
        Size = UDim2.fromOffset(30, 30)
    };
    local Frame3 = Instance.new("Frame");

    for i, v in v68 do
        Frame3[i] = v;
    end;

    Frame3.Parent = Frame2;
    local v69 = {
        Name = "Glow",
        BackgroundTransparency = 1,
        Image = "rbxassetid://120639974824188",
        ImageTransparency = 0.35,
        AnchorPoint = Vector2_new_ret,
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(2.2, 2.2),
        ImageColor3 = Color3_fromRGB_ret5
    };
    local ImageLabel = Instance.new("ImageLabel");

    for i, v in v69 do
        ImageLabel[i] = v;
    end;

    ImageLabel.Parent = Frame3;
    local v70 = {
        Name = "Badge",
        ZIndex = 2,
        AnchorPoint = Vector2_new_ret,
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(1, 1),
        BackgroundColor3 = Color3_new_ret
    };
    local Frame4 = Instance.new("Frame");

    for i, v in v70 do
        Frame4[i] = v;
    end;

    Frame4.Parent = Frame3;
    local v71 = {
        CornerRadius = UDim_new_ret
    };
    local UICorner3 = Instance.new("UICorner");

    for i, v in v71 do
        UICorner3[i] = v;
    end;

    UICorner3.Parent = Frame4;
    local Color2 = TeamEventConfig.Team[TeamEventConfig.Teams[1]].Color;
    local Color4 = TeamEventConfig.Team[TeamEventConfig.Teams[2]].Color;
    local v72 = {
        Rotation = 35,
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color2:Lerp(Color3_new_ret, 0.2)),
            ColorSequenceKeypoint.new(0.47, Color2),
            ColorSequenceKeypoint.new(0.53, Color4),
            ColorSequenceKeypoint.new(1, Color4:Lerp(Color3_new_ret, 0.2))
        })
    };
    local UIGradient4 = Instance.new("UIGradient");

    for i, v in v72 do
        UIGradient4[i] = v;
    end;

    UIGradient4.Parent = Frame4;
    stroke(Frame4, Color3_fromRGB_ret5, 2);
    local v73 = label(Frame4, "VS", 13, Color3_new_ret, {
        Name = "Text",
        AutoLocalize = false,
        Size = UDim2.fromScale(1, 1),
        TextXAlignment = Enum.TextXAlignment.Center,
        FontFace = Font_new_ret3
    });
    local v74 = {
        Name = "Outline",
        Thickness = 1.5,
        Color = Color3_new_ret2,
        LineJoinMode = Enum.LineJoinMode.Round
    };
    local UIStroke = Instance.new("UIStroke");

    for i, v in v74 do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = v73;
    local v75 = {
        Name = "TeamHeader",
        ZIndex = 2,
        Position = UDim2.fromOffset(18, 58),
        Size = UDim2.new(1, -36, 0, 96),
        BackgroundColor3 = Color3_new_ret
    };
    local Frame5 = Instance.new("Frame");

    for i, v in v75 do
        Frame5[i] = v;
    end;

    Frame5.Parent = MainFrame;
    local v76 = {
        CornerRadius = UDim.new(0, 16)
    };
    local UICorner4 = Instance.new("UICorner");

    for i, v in v76 do
        UICorner4[i] = v;
    end;

    UICorner4.Parent = Frame5;
    local v77 = Color:Lerp(Color3_new_ret, 0.12);
    local v78, v79 = Color:Lerp(Color3_new_ret2, 0.4);
    local v80 = {
        Color = ColorSequence.new(v77, v78),
        Rotation = v79 or 90
    };
    local UIGradient5 = Instance.new("UIGradient");

    for i, v in v80 do
        UIGradient5[i] = v;
    end;

    UIGradient5.Parent = Frame5;
    stroke(Frame5, Color3_new_ret2, 3);
    stroke(Frame5, Color3_fromRGB_ret5, 1.5, {
        ZIndex = 2
    });
    label(Frame5, v52.Icon, 92, Color3_new_ret, {
        Name = "Watermark",
        TextTransparency = 0.82,
        Rotation = 14,
        AutoLocalize = false,
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, -6, 0.5, 0),
        Size = UDim2.fromOffset(110, 96),
        TextXAlignment = Enum.TextXAlignment.Center
    });
    local v81 = {
        Name = "Emblem",
        ZIndex = 2,
        AnchorPoint = Vector2.new(0, 0.5),
        Position = UDim2.new(0, 12, 0.5, 0),
        Size = UDim2.fromOffset(72, 72),
        BackgroundColor3 = Color3_new_ret
    };
    local Frame6 = Instance.new("Frame");

    for i, v in v81 do
        Frame6[i] = v;
    end;

    Frame6.Parent = Frame5;
    local v82 = {
        CornerRadius = UDim_new_ret
    };
    local UICorner5 = Instance.new("UICorner");

    for i, v in v82 do
        UICorner5[i] = v;
    end;

    UICorner5.Parent = Frame6;
    local v83 = Color:Lerp(Color3_new_ret, 0.3);
    local v84, v85 = Color:Lerp(Color3_new_ret2, 0.45);
    local v86 = {
        Color = ColorSequence.new(v83, v84),
        Rotation = v85 or 90
    };
    local UIGradient6 = Instance.new("UIGradient");

    for i, v in v86 do
        UIGradient6[i] = v;
    end;

    UIGradient6.Parent = Frame6;
    stroke(Frame6, Color3_new_ret2, 4);
    stroke(Frame6, Color3_new_ret, 2, {
        ZIndex = 2
    });
    label(Frame6, v52.Icon, 44, Color3_new_ret, {
        Name = "Ball",
        AutoLocalize = false,
        Size = UDim2.fromScale(1, 1),
        TextXAlignment = Enum.TextXAlignment.Center
    });
    local v87 = label(Frame5, v52.Label, 46, Color3_new_ret, {
        Name = "Title",
        TextScaled = true,
        AutoLocalize = false,
        ZIndex = 2,
        Position = UDim2.fromOffset(98, 6),
        Size = UDim2.new(1, -112, 0, 56),
        FontFace = Font_new_ret3
    });
    local v88 = {
        Name = "Outline",
        Thickness = 3,
        Color = Color:Lerp(Color3_new_ret2, 0.55),
        LineJoinMode = Enum.LineJoinMode.Round
    };
    local UIStroke2 = Instance.new("UIStroke");

    for i, v in v88 do
        UIStroke2[i] = v;
    end;

    UIStroke2.Parent = v87;
    local UITextSizeConstraint = Instance.new("UITextSizeConstraint");

    for i, v in {
        MaxTextSize = 46
    } do
        UITextSizeConstraint[i] = v;
    end;

    UITextSizeConstraint.Parent = v87;
    local v89, v90 = Color:Lerp(Color3_new_ret, 0.6);
    local v91 = {
        Color = ColorSequence.new(Color3_new_ret, v89),
        Rotation = v90 or 90
    };
    local UIGradient7 = Instance.new("UIGradient");

    for i, v in v91 do
        UIGradient7[i] = v;
    end;

    UIGradient7.Parent = v87;
    label(Frame5, v52.Subtitle .. " · TEAM BOARD", 18, Color3_new_ret, {
        Name = "Subtitle",
        TextTransparency = 0.2,
        ZIndex = 2,
        Position = UDim2.fromOffset(100, 62),
        Size = UDim2.new(1, -112, 0, 22),
        FontFace = Font_new_ret2,
        TextTruncate = Enum.TextTruncate.AtEnd
    });
    v53.headerSweep = shine(Frame5, UDim.new(0, 16));
    local v92 = {
        Name = "Jumbotron",
        ZIndex = 2,
        Position = UDim2.fromOffset(18, 166),
        Size = UDim2.new(1, -36, 0, 132),
        BackgroundColor3 = Color3_new_ret
    };
    local Frame7 = Instance.new("Frame");

    for i, v in v92 do
        Frame7[i] = v;
    end;

    Frame7.Parent = MainFrame;
    local v93 = {
        CornerRadius = UDim.new(0, 14)
    };
    local UICorner6 = Instance.new("UICorner");

    for i, v in v93 do
        UICorner6[i] = v;
    end;

    UICorner6.Parent = Frame7;
    local Color3_fromRGB_ret11 = Color3.fromRGB(24, 30, 56);
    local Color3_fromRGB_ret12, v94 = Color3.fromRGB(6, 8, 18);
    local v95 = {
        Color = ColorSequence.new(Color3_fromRGB_ret11, Color3_fromRGB_ret12),
        Rotation = v94 or 90
    };
    local UIGradient8 = Instance.new("UIGradient");

    for i, v in v95 do
        UIGradient8[i] = v;
    end;

    UIGradient8.Parent = Frame7;
    stroke(Frame7, Color3_new_ret2, 3);
    v53.jumboEdge = stroke(Frame7, Color:Lerp(Color3_new_ret, 0.3), 2, {
        ZIndex = 2
    });
    local v96 = {
        Name = "TeamGlow",
        Size = UDim2.fromScale(0.7, 1),
        BackgroundColor3 = Color
    };
    local Frame8 = Instance.new("Frame");

    for i, v in v96 do
        Frame8[i] = v;
    end;

    Frame8.Parent = Frame7;
    local v97 = {
        CornerRadius = UDim.new(0, 14)
    };
    local UICorner7 = Instance.new("UICorner");

    for i, v in v97 do
        UICorner7[i] = v;
    end;

    UICorner7.Parent = Frame8;
    local v98 = {
        Transparency = NumberSequence.new(0.45, 1)
    };
    local UIGradient9 = Instance.new("UIGradient");

    for i, v in v98 do
        UIGradient9[i] = v;
    end;

    UIGradient9.Parent = Frame8;
    label(Frame7, "TEAM TOTAL", 18, Color3_fromRGB_ret5, {
        Name = "TotalCaption",
        ZIndex = 2,
        Position = UDim2.fromOffset(22, 12),
        Size = UDim2.fromOffset(300, 20),
        FontFace = Font_new_ret2
    });
    local v99 = label(Frame7, "–", 92, Color3_new_ret, {
        Name = "Total",
        AutoLocalize = false,
        ZIndex = 2,
        Position = UDim2.fromOffset(18, 32),
        Size = UDim2.fromOffset(330, 90),
        FontFace = Font_new_ret4
    });
    local v100 = {
        Name = "Outline",
        Thickness = 3,
        Color = Color3_new_ret2,
        LineJoinMode = Enum.LineJoinMode.Round
    };
    local UIStroke3 = Instance.new("UIStroke");

    for i, v in v100 do
        UIStroke3[i] = v;
    end;

    UIStroke3.Parent = v99;
    v53.total = v99;
    local total = v53.total;
    local Color3_fromRGB_ret13, v101 = Color3.fromRGB(255, 228, 150);
    local v102 = {
        Color = ColorSequence.new(Color3_new_ret, Color3_fromRGB_ret13),
        Rotation = v101 or 90
    };
    local UIGradient10 = Instance.new("UIGradient");

    for i, v in v102 do
        UIGradient10[i] = v;
    end;

    UIGradient10.Parent = total;
    local v103 = {
        Name = "Divider",
        BorderSizePixel = 0,
        ZIndex = 2,
        AnchorPoint = Vector2.new(0, 0.5),
        Position = UDim2.new(0, 356, 0.5, 0),
        Size = UDim2.new(0, 2, 1, -24),
        BackgroundColor3 = Color3_fromRGB_ret5
    };
    local Frame9 = Instance.new("Frame");

    for i, v in v103 do
        Frame9[i] = v;
    end;

    Frame9.Parent = Frame7;
    local v104 = {
        Rotation = 90,
        Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.5, 0.1), NumberSequenceKeypoint.new(1, 1) })
    };
    local UIGradient11 = Instance.new("UIGradient");

    for i, v in v104 do
        UIGradient11[i] = v;
    end;

    UIGradient11.Parent = Frame9;
    v53.playersCaption = label(Frame7, "PLAYERS", 16, Color3_fromRGB_ret5, {
        Name = "PlayersCaption",
        ZIndex = 2,
        Position = UDim2.fromOffset(374, 12),
        Size = UDim2.new(1, -386, 0, 20),
        FontFace = Font_new_ret2
    });
    local v105 = label(Frame7, "–", 40, Color3_new_ret, {
        Name = "Players",
        AutoLocalize = false,
        ZIndex = 2,
        Position = UDim2.fromOffset(372, 30),
        Size = UDim2.new(1, -384, 0, 42),
        FontFace = Font_new_ret4
    });
    local v106 = {
        Name = "Outline",
        Thickness = 2,
        Color = Color3_new_ret2,
        LineJoinMode = Enum.LineJoinMode.Round
    };
    local UIStroke4 = Instance.new("UIStroke");

    for i, v in v106 do
        UIStroke4[i] = v;
    end;

    UIStroke4.Parent = v105;
    v53.players = v105;
    v53.level = label(Frame7, "LEVEL", 16, Color3_fromRGB_ret5, {
        Name = "Level",
        ZIndex = 2,
        Position = UDim2.fromOffset(374, 76),
        Size = UDim2.new(1, -386, 0, 20),
        FontFace = Font_new_ret2
    });

    for i = 1, u2 do
        local v107 = {
            ZIndex = 2,
            Name = "Pip" .. i,
            Position = UDim2.fromOffset((i - 1) * 30 + 374, 100),
            Size = UDim2.fromOffset(22, 22),
            BackgroundColor3 = Color3_fromRGB_ret8
        };
        local Frame10 = Instance.new("Frame");

        for i2, v in v107 do
            Frame10[i2] = v;
        end;

        Frame10.Parent = Frame7;
        local v108 = {
            CornerRadius = UDim_new_ret
        };
        local UICorner8 = Instance.new("UICorner");

        for i2, v in v108 do
            UICorner8[i2] = v;
        end;

        UICorner8.Parent = Frame10;
        stroke(Frame10, Color3_new_ret2, 2);
        v53.pips[i] = Frame10;
    end;

    local v109 = {
        Name = "Ribbon",
        BackgroundTransparency = 1,
        ZIndex = 2,
        Position = UDim2.fromOffset(18, 310),
        Size = UDim2.new(1, -36, 0, 40)
    };
    local Frame10 = Instance.new("Frame");

    for i, v in v109 do
        Frame10[i] = v;
    end;

    Frame10.Parent = MainFrame;
    local v110 = {
        Name = "Captions",
        BackgroundTransparency = 1,
        Size = UDim2.fromScale(1, 1)
    };
    local Frame11 = Instance.new("Frame");

    for i, v in v110 do
        Frame11[i] = v;
    end;

    Frame11.Parent = Frame10;
    v53.captions = Frame11;

    for _, v in { { "RANK", 12, 0 }, { "PLAYER", 120, 0 }, { "POINTS", 0, -20 } } do
        local captions = v53.captions;
        local v111 = v[1];
        local v112 = {
            Name = v[1],
            Position = UDim2.fromOffset(v[2], 0),
            Size = UDim2.new(1, v[3] - v[2], 1, 0)
        };
        local v113;

        if v[3] < 0 then
            v113 = Enum.TextXAlignment.Right;
        else
            v113 = Enum.TextXAlignment.Left;
        end;

        v112.TextXAlignment = v113;
        v112.FontFace = Font_new_ret2;
        label(captions, v111, 17, Color3_fromRGB_ret4, v112);
    end;

    local v114 = {
        Name = "Banner",
        Visible = false,
        Size = UDim2.fromScale(1, 1),
        BackgroundColor3 = Color3_new_ret
    };
    local Frame12 = Instance.new("Frame");

    for i, v in v114 do
        Frame12[i] = v;
    end;

    Frame12.Parent = Frame10;
    v53.banner = Frame12;
    local banner = v53.banner;
    local v115 = {
        CornerRadius = UDim.new(0, 10)
    };
    local UICorner8 = Instance.new("UICorner");

    for i, v in v115 do
        UICorner8[i] = v;
    end;

    UICorner8.Parent = banner;
    local banner2 = v53.banner;
    local v116 = {
        Rotation = 90,
        Color = ColorSequence.new(Color3_new_ret, Color3_new_ret)
    };
    local UIGradient12 = Instance.new("UIGradient");

    for i, v in v116 do
        UIGradient12[i] = v;
    end;

    UIGradient12.Parent = banner2;
    v53.bannerFill = UIGradient12;
    stroke(v53.banner, Color3_new_ret2, 3);
    v53.bannerEdge = stroke(v53.banner, Color3_new_ret, 1.5, {
        ZIndex = 2
    });
    v53.bannerText = label(v53.banner, "", 22, Color3_new_ret, {
        Name = "Text",
        ZIndex = 2,
        Size = UDim2.fromScale(1, 1),
        TextXAlignment = Enum.TextXAlignment.Center,
        FontFace = Font_new_ret2
    });
    local banner3 = v53.banner;
    local v117 = {
        Name = "Dot",
        ZIndex = 2,
        AnchorPoint = Vector2.new(0, 0.5),
        Position = UDim2.new(0, 16, 0.5, 0),
        Size = UDim2.fromOffset(12, 12),
        BackgroundColor3 = Color3_new_ret
    };
    local Frame13 = Instance.new("Frame");

    for i, v in v117 do
        Frame13[i] = v;
    end;

    Frame13.Parent = banner3;
    v53.dot = Frame13;
    local dot = v53.dot;
    local v118 = {
        CornerRadius = UDim_new_ret
    };
    local UICorner9 = Instance.new("UICorner");

    for i, v in v118 do
        UICorner9[i] = v;
    end;

    UICorner9.Parent = dot;
    v53.bannerSweep = shine(v53.banner, UDim.new(0, 10));
    local v119 = {
        Name = "Turf",
        BackgroundTransparency = 0.35,
        ClipsDescendants = true,
        ZIndex = 2,
        Position = UDim2.fromOffset(18, 356),
        Size = UDim2.new(1, -36, 1, -374),
        BackgroundColor3 = Color3_fromRGB_ret9
    };
    local Frame14 = Instance.new("Frame");

    for i, v in v119 do
        Frame14[i] = v;
    end;

    Frame14.Parent = MainFrame;
    local v120 = {
        CornerRadius = UDim.new(0, 14)
    };
    local UICorner10 = Instance.new("UICorner");

    for i, v in v120 do
        UICorner10[i] = v;
    end;

    UICorner10.Parent = Frame14;
    stroke(Frame14, Color3_new_ret2, 3);
    local v121 = u3[v51];

    for i = v121 and 52 or 0, 600, v121 and 52 or 104 do
        local v122 = {
            BorderSizePixel = 0,
            Name = v121 and "Line" or "Stripe",
            Position = UDim2.fromOffset(i, 0),
            Size = UDim2.new(0, v121 and 3 or 52, 1, 0)
        };
        local v123;

        if v121 then
            v123 = Color3_new_ret;
        else
            v123 = Color3_fromRGB_ret10;
        end;

        v122.BackgroundColor3 = v123;
        v122.BackgroundTransparency = v121 and 0.8 or 0.25;
        local Frame15 = Instance.new("Frame");
        local _ = i;

        for i2, v in v122 do
            Frame15[i2] = v;
        end;

        Frame15.Parent = Frame14;
    end;

    local v124 = {
        Name = "Shade",
        BackgroundTransparency = 0.6,
        BorderSizePixel = 0,
        ZIndex = 2,
        Size = UDim2.fromScale(1, 1),
        BackgroundColor3 = Color3_fromRGB_ret2
    };
    local Frame15 = Instance.new("Frame");

    for i, v in v124 do
        Frame15[i] = v;
    end;

    Frame15.Parent = Frame14;
    v53.empty = label(Frame14, "", 28, Color3_fromRGB_ret3, {
        Name = "Empty",
        ZIndex = 3,
        Size = UDim2.fromScale(1, 1),
        TextXAlignment = Enum.TextXAlignment.Center,
        FontFace = Font_new_ret3
    });
    local ScrollingFrame = MainFrame.ScrollingFrame;
    ScrollingFrame.Position = UDim2.fromOffset(26, 364);
    ScrollingFrame.Size = UDim2.new(1, -48, 1, -390);
    ScrollingFrame.ScrollBarImageColor3 = Color3_fromRGB_ret5;
    ScrollingFrame.ScrollBarThickness = 4;
    ScrollingFrame.BorderSizePixel = 0;
    ScrollingFrame.ZIndex = 3;
    local v125 = ScrollingFrame:FindFirstChildOfClass("UIListLayout");

    if v125 then
        v125.Padding = UDim.new(0, 6);
    end;

    local SlotFrame = ScrollingFrame.SlotFrame;
    SlotFrame.Size = UDim2.new(1, -8, 0, 54);
    local Frame16 = SlotFrame.Frame;
    Frame16.Size = UDim2.fromScale(1, 1);
    Frame16.BackgroundColor3 = Color3_new_ret;
    Frame16.BackgroundTransparency = 0.15;
    local v126 = Frame16:FindFirstChildOfClass("UICorner");

    if not v126 then
        local v127 = {
            CornerRadius = UDim.new(0, 12)
        };
        v126 = Instance.new("UICorner");

        for i, v in v127 do
            v126[i] = v;
        end;

        v126.Parent = Frame16;
    end;

    v126.CornerRadius = UDim.new(0, 12);
    local v128 = {
        Name = "Fill",
        Rotation = 0,
        Color = v53.fill
    };
    local UIGradient13 = Instance.new("UIGradient");

    for i, v in v128 do
        UIGradient13[i] = v;
    end;

    UIGradient13.Parent = Frame16;
    stroke(Frame16, v53.edge, 2, {
        Name = "Edge",
        Transparency = 0.35
    });
    local v129 = {
        Name = "Rank",
        AnchorPoint = Vector2.new(0, 0.5),
        Position = UDim2.new(0, 8, 0.5, 0),
        Size = UDim2.fromOffset(42, 42),
        BackgroundColor3 = Color3_new_ret
    };
    local Frame17 = Instance.new("Frame");

    for i, v in v129 do
        Frame17[i] = v;
    end;

    Frame17.Parent = Frame16;
    local v130 = {
        CornerRadius = UDim_new_ret
    };
    local UICorner11 = Instance.new("UICorner");

    for i, v in v130 do
        UICorner11[i] = v;
    end;

    UICorner11.Parent = Frame17;
    local UIGradient14 = Instance.new("UIGradient");

    for i, v in {
        Name = "Fill",
        Rotation = 90
    } do
        UIGradient14[i] = v;
    end;

    UIGradient14.Parent = Frame17;
    stroke(Frame17, Color3_new_ret2, 2);
    local v131 = label(Frame17, "", 24, Color3_new_ret, {
        Name = "Number",
        AutoLocalize = false,
        Size = UDim2.fromScale(1, 1),
        TextXAlignment = Enum.TextXAlignment.Center,
        FontFace = Font_new_ret3
    });
    local v132 = {
        Name = "Outline",
        Thickness = 1.5,
        Color = Color3_new_ret2,
        LineJoinMode = Enum.LineJoinMode.Round
    };
    local UIStroke5 = Instance.new("UIStroke");

    for i, v in v132 do
        UIStroke5[i] = v;
    end;

    UIStroke5.Parent = v131;
    local PFP = Frame16.PFP;
    PFP.AnchorPoint = Vector2.new(0, 0.5);
    PFP.Position = UDim2.new(0, 58, 0.5, 0);
    PFP.Size = UDim2.fromOffset(44, 44);
    PFP.BackgroundColor3 = Color3.fromRGB(24, 30, 56);
    PFP.BackgroundTransparency = 0;
    local v133 = {
        CornerRadius = UDim_new_ret
    };
    local UICorner12 = Instance.new("UICorner");

    for i, v in v133 do
        UICorner12[i] = v;
    end;

    UICorner12.Parent = PFP;
    stroke(PFP, Color3_new_ret, 2, {
        Name = "Edge"
    });
    local Username = Frame16.Username;
    Username.AnchorPoint = Vector2.new(0, 0.5);
    Username.Position = UDim2.new(0, 112, 0.5, 0);
    Username.Size = UDim2.new(1, -270, 1, 0);
    Username.TextScaled = false;
    Username.TextSize = 26;
    Username.FontFace = Font_new_ret;
    Username.TextColor3 = Color3_new_ret;
    Username.TextXAlignment = Enum.TextXAlignment.Left;
    Username.TextTruncate = Enum.TextTruncate.AtEnd;
    Username.RichText = true;
    Username.AutoLocalize = false;
    local Stat = Frame16.Stat;
    Stat.AnchorPoint = Vector2.new(1, 0.5);
    Stat.Position = UDim2.new(1, -14, 0.5, 0);
    Stat.Size = UDim2.new(0, 150, 1, 0);
    Stat.TextScaled = false;
    Stat.TextSize = 34;
    Stat.FontFace = Font_new_ret4;
    Stat.TextColor3 = Color3_fromRGB_ret5;
    Stat.TextXAlignment = Enum.TextXAlignment.Right;
    Stat.RichText = true;
    local v134 = label(Frame16, "YOU", 16, Color3_new_ret2, {
        Name = "You",
        BackgroundTransparency = 0,
        Visible = false,
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, -170, 0.5, 0),
        Size = UDim2.fromOffset(50, 26),
        BackgroundColor3 = Color3_fromRGB_ret5,
        TextXAlignment = Enum.TextXAlignment.Center,
        FontFace = Font_new_ret2
    });
    local v135 = {
        CornerRadius = UDim.new(0, 7)
    };
    local UICorner13 = Instance.new("UICorner");

    for i, v in v135 do
        UICorner13[i] = v;
    end;

    UICorner13.Parent = v134;
    local headerSweep = v53.headerSweep;
    local v136 = {
        Offset = Vector2.new(1, 0)
    };
    local header = v53.tweens.header;

    if header then
        header:Cancel();
    end;

    local v137 = TweenService:Create(headerSweep, TweenInfo_new_ret, v136);
    v53.tweens.header = v137;
    v137:Play();

    return v53;
end;

function u1.row(p138, p139, p140, p141, p142, p143) -- Line: 594
    -- upvalues: u1 (copy), Color3_fromRGB_ret5 (copy)
    local v144 = u1.medal(p140, p138.look);
    local Frame = p139.Frame;
    local Rank = Frame.Rank;
    Rank.Fill.Color = ColorSequence.new(v144.top, v144.bottom);
    Rank.Number.Text = tostring(p140);
    Rank.Number.TextColor3 = v144.text;
    Rank.Number.Outline.Enabled = v144.outline == true;
    Frame.PFP.Edge.Color = v144.top;
    Frame.Username.Text = p141;
    Frame.Username.Size = UDim2.new(1, p143 and -330 or -270, 1, 0);
    Frame.Stat.Text = p142 .. "<font size=\"18\" color=\"#D6DAE8\"> PTS</font>";
    Frame.You.Visible = p143;
    local v145;

    if p143 then
        v145 = p138.mine;
    else
        v145 = p138.fill;
    end;

    Frame.Fill.Color = v145;
    local v146;

    if p143 then
        v146 = Color3_fromRGB_ret5;
    else
        v146 = p138.edge;
    end;

    Frame.Edge.Color = v146;
    Frame.Edge.Thickness = p143 and 3 or 2;
    Frame.Edge.Transparency = p143 and 0 or 0.35;
end;

function u1.paint(p147, p148, p149, p150, p151) -- Line: 614
    -- upvalues: u1 (copy), u2 (copy), Color3_fromRGB_ret5 (copy), Color3_fromRGB_ret8 (copy), u5 (copy), Font_new_ret3 (copy), Font_new_ret2 (copy), TweenInfo_new_ret2 (copy), TweenService (copy), TweenInfo_new_ret (copy)
    local v152 = u1.status(p148);
    local v153 = v152 == "loading";
    local v154;

    if v153 then
        v154 = 0;
    else
        local v155 = tonumber(p148.level) or 0;
        local math_floor_ret = math.floor(v155);
        v154 = math.clamp(math_floor_ret, 0, u2);
    end;

    p147.total.Text = v153 and "– – –" or p149;
    p147.players.Text = v153 and "–" or p150;
    local playersCaption = p147.playersCaption;
    local v156 = tonumber(p148.members) or 0;
    playersCaption.Text = math.floor(v156) == 1 and "PLAYER" or "PLAYERS";
    p147.level.Text = ("LEVEL %s/%d"):format(v153 and "–" or tostring(v154), u2);

    for i, v in p147.pips do
        local v157;

        if i <= v154 then
            v157 = Color3_fromRGB_ret5;
        else
            v157 = Color3_fromRGB_ret8;
        end;

        v.BackgroundColor3 = v157;
    end;

    p147.empty.Visible = p151 == 0;
    p147.empty.Text = v153 and "LOADING..." or "NO POINTS YET";

    if v152 == p147.kind then
        return;
    end;

    p147.kind = v152;
    local v158 = u5[v152];
    p147.captions.Visible = v158 == nil;
    p147.banner.Visible = v158 ~= nil;
    local v159;

    if v152 == "winner" then
        v159 = Color3_fromRGB_ret5;
    else
        v159 = p147.edge;
    end;

    p147.jumboEdge.Color = v159;
    local dot = p147.tweens.dot;

    if dot then
        p147.tweens.dot = nil;
        dot:Cancel();
    end;

    local banner = p147.tweens.banner;

    if banner then
        p147.tweens.banner = nil;
        banner:Cancel();
    end;

    if not v158 then
        return;
    end;

    p147.bannerFill.Color = ColorSequence.new(v158.top, v158.bottom);
    p147.bannerEdge.Color = v158.edge;
    p147.bannerText.Text = v158.words;
    p147.bannerText.TextColor3 = v158.text;
    local v160;

    if v158.sport then
        v160 = Font_new_ret3;
    else
        v160 = Font_new_ret2;
    end;

    p147.bannerText.FontFace = v160;
    p147.bannerText.TextSize = v158.sport and 26 or 20;
    p147.dot.Visible = v158.pulse == true;
    p147.dot.BackgroundColor3 = v158.text;
    p147.dot.BackgroundTransparency = 0;
    p147.bannerSweep.Parent.Visible = v158.shine == true;
    p147.bannerSweep.Offset = Vector2.new(-1, 0);

    if not v158.pulse then
        if v158.shine then
            local bannerSweep = p147.bannerSweep;
            local v161 = {
                Offset = Vector2.new(1, 0)
            };
            local banner2 = p147.tweens.banner;

            if banner2 then
                banner2:Cancel();
            end;

            local v162 = TweenService:Create(bannerSweep, TweenInfo_new_ret, v161);
            p147.tweens.banner = v162;
            v162:Play();
        end;

        return;
    end;

    local dot2 = p147.dot;
    local v163 = {
        BackgroundTransparency = 0.85
    };
    local dot3 = p147.tweens.dot;

    if dot3 then
        dot3:Cancel();
    end;

    local v164 = TweenService:Create(dot2, TweenInfo_new_ret2, v163);
    p147.tweens.dot = v164;
    v164:Play();
end;

function u1.destroy(p165) -- Line: 659
    for _, v in p165.tweens do
        v:Cancel();
    end;

    table.clear(p165.tweens);
end;

return u1;