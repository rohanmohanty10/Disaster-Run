 

 

local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
local LocalPlayer = Players.LocalPlayer;
local ChickenOrHero = game.ReplicatedStorage:WaitForChild("ChickenOrHero");
local AdminEvent = ChickenOrHero:WaitForChild("Admin"):WaitForChild("AdminEvent");
local ValleyPanels = require(ChickenOrHero.Presentation.ValleyPanels);
local ValleyTheme = require(ChickenOrHero.Presentation.ValleyTheme);
local u1 = ValleyPanels.make("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"), "ValleyAwards", {
    ResetOnSpawn = false,
    IgnoreGuiInset = true,
    DisplayOrder = 91,
    ScreenInsets = Enum.ScreenInsets.None,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling
});
local u2 = {};

for i, v in {
    { UDim2.new(), UDim2.new(1, 0, 0, 3) },
    { UDim2.new(0, 0, 1, -3), UDim2.new(1, 0, 0, 3) },
    { UDim2.new(), UDim2.new(0, 3, 1, 0) },
    { UDim2.new(1, -3, 0, 0), UDim2.new(0, 3, 1, 0) }
} do
    u2[i] = ValleyPanels.make("Frame", u1, "Edge" .. i, {
        BorderSizePixel = 0,
        BackgroundTransparency = 1,
        Active = false,
        Position = v[1],
        Size = v[2]
    });
end;

local u3 = ValleyPanels.make("CanvasGroup", u1, "Card", {
    BackgroundTransparency = 0.04,
    BorderSizePixel = 0,
    GroupTransparency = 1,
    Visible = false,
    Active = false,
    AnchorPoint = Vector2.new(0.5, 0),
    Position = UDim2.fromScale(0.5, 0.18),
    Size = UDim2.fromOffset(430, 146),
    BackgroundColor3 = ValleyTheme.Ink
});
ValleyPanels.corner(u3, 8);
ValleyPanels.stroke(u3, ValleyTheme.Gold, 0.35);
local Outline = u3.Outline;
ValleyPanels.make("UIScale", u3, "Scale", {});
local u4 = ValleyPanels.make("Frame", u3, "Rule", {
    BorderSizePixel = 0,
    Size = UDim2.new(1, 0, 0, 3),
    BackgroundColor3 = ValleyTheme.Gold
});
local u5 = ValleyPanels.make("Frame", u3, "Mark", {
    BackgroundTransparency = 1,
    Position = UDim2.fromOffset(15, 27),
    Size = UDim2.fromOffset(55, 56)
});
local u6 = ValleyPanels.make("Frame", u5, "Gift", {
    BackgroundTransparency = 1,
    Size = UDim2.fromScale(1, 1)
});
local u7 = ValleyPanels.make("Frame", u5, "Rank", {
    BackgroundTransparency = 1,
    Visible = false,
    Size = UDim2.fromScale(1, 1)
});
ValleyPanels.make("Frame", u6, "Box", {
    BackgroundTransparency = 1,
    Position = UDim2.fromOffset(13, 25),
    Size = UDim2.fromOffset(29, 23)
});
ValleyPanels.stroke(u6.Box, ValleyTheme.Gold, 0);
ValleyPanels.make("Frame", u6, "Lid", {
    BorderSizePixel = 0,
    Position = UDim2.fromOffset(10, 20),
    Size = UDim2.fromOffset(35, 5),
    BackgroundColor3 = ValleyTheme.Gold
});
ValleyPanels.make("Frame", u6, "Ribbon", {
    BorderSizePixel = 0,
    Position = UDim2.fromOffset(26, 20),
    Size = UDim2.fromOffset(3, 28),
    BackgroundColor3 = ValleyTheme.Gold
});

for i, v in { 18, 29 } do
    local v8 = ValleyPanels.make("Frame", u6, "Bow" .. i, {
        BackgroundTransparency = 1,
        Position = UDim2.fromOffset(v, 10),
        Size = UDim2.fromOffset(9, 9),
        Rotation = i == 1 and -25 or 25
    });
    ValleyPanels.stroke(v8, ValleyTheme.Gold, 0);
end;

local v9 = ValleyPanels.make("Frame", u7, "Diamond", {
    Rotation = 45,
    BackgroundTransparency = 1,
    Position = UDim2.fromOffset(14, 14),
    Size = UDim2.fromOffset(27, 27)
});
ValleyPanels.stroke(v9, ValleyTheme.Gold, 0);
ValleyPanels.make("Frame", u7, "Center", {
    Rotation = 45,
    BorderSizePixel = 0,
    Position = UDim2.fromOffset(22, 22),
    Size = UDim2.fromOffset(11, 11),
    BackgroundColor3 = ValleyTheme.Gold
});
local u10 = ValleyPanels.make("ImageLabel", u5, "Avatar", {
    BorderSizePixel = 0,
    Visible = false,
    Image = "",
    Size = UDim2.fromScale(1, 1),
    BackgroundColor3 = ValleyTheme.Ink
});
ValleyPanels.corner(u10, 28);
local u11 = ValleyPanels.text(u3, "Eyebrow", "", 82, 17, 300, 19, 11, ValleyTheme.Gold);
u11.Font = Enum.Font.GothamBold;
local u12 = ValleyPanels.text(u3, "Title", "", 82, 42, 308, 42, 23, ValleyTheme.Paper);
u12.Font = Enum.Font.GothamBold;
u12.TextScaled = true;
ValleyPanels.make("UITextSizeConstraint", u12, "Limits", {
    MinTextSize = 14,
    MaxTextSize = 23
});
local u13 = ValleyPanels.text(u3, "Detail", "", 82, 87, 322, 44, 12, ValleyTheme.Muted);
local v14 = ValleyPanels.button(u3, "Close", "×", 396, 6, 28, 28, ValleyTheme.Ink);
v14.BackgroundTransparency = 1;
v14.TextSize = 21;
local u15 = {};
local u16 = {};
local u17 = nil;
local u18 = false;
local u19 = true;
local u20 = { "GlobalWheelOpen", "ScreenPresentationActive", "AdminRefreshActive", "MatchSummaryVisible", "BalloonOfferOpen", "FairPlayNoticeOpen", "ChoiceSpotlightActive" };

local function ready() -- Line: 42
    -- upvalues: LocalPlayer (copy), u20 (copy)
    if LocalPlayer:GetAttribute("ClientReady") ~= true then
        return false;
    end;

    for _, v in u20 do
        if LocalPlayer:GetAttribute(v) then
            return false;
        end;
    end;

    return true;
end;

local function tween(p21, p22, p23) -- Line: 51
    -- upvalues: TweenService (copy)
    TweenService:Create(p21, TweenInfo.new(p22, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), p23):Play();
end;

local function present(p24) -- Line: 52
    -- upvalues: u17 (ref), u18 (ref), ValleyTheme (copy), u2 (copy), TweenService (copy), u4 (copy), Outline (copy), u11 (copy), u10 (copy), u6 (copy), u7 (copy), u5 (copy), u12 (copy), u13 (copy), u3 (copy), u1 (copy), ChickenOrHero (copy), u19 (ref), ready (copy), AdminEvent (copy)
    u17 = p24;
    u18 = false;
    local v25 = p24.kind == "Gift" and ValleyTheme.Purple or (p24.kind == "AccessRemoved" and ValleyTheme.Blue or ValleyTheme.Gold);

    for _, v in u2 do
        v.BackgroundColor3 = v25;
        TweenService:Create(v, TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            BackgroundTransparency = 0.35
        }):Play();
    end;

    u4.BackgroundColor3 = v25;
    Outline.Color = v25;
    u11.TextColor3 = v25;
    local v26;

    if p24.kind == "Gift" and (type(p24.senderId) == "number" and (p24.senderId > 0 and p24.senderId % 1 == 0)) then
        v26 = p24.senderId or nil;
    else
        v26 = nil;
    end;

    u10.Visible = v26 ~= nil;
    u10.Image = v26 and (("rbxthumb://type=AvatarHeadShot&id=%d&w=150&h=150"):format(v26) or "") or "";
    local v27;

    if p24.kind == "Gift" then
        v27 = not v26;
    else
        v27 = false;
    end;

    u6.Visible = v27;
    u7.Visible = p24.kind ~= "Gift";

    for _, descendant in u5:GetDescendants() do
        if descendant:IsA("Frame") and descendant.BackgroundTransparency < 1 then
            descendant.BackgroundColor3 = v25;
        elseif descendant:IsA("UIStroke") then
            descendant.Color = v25;
        end;
    end;

    u11.Text = (p24.kind == "Gift" and "GIFT FROM " or (p24.kind == "Rank" and "RANKED BY " or (p24.kind == "Title" and "TITLE FROM " or "ACCESS UPDATE · "))) .. (p24.from or "THE OWNER");
    u12.Text = p24.label;
    u13.Text = p24.detail or "";
    u3.Visible = true;
    u3.GroupTransparency = 1;
    u3.Position = UDim2.fromScale(0.5, 0.16);
    local AbsoluteSize = u1.AbsoluteSize;
    u3.Scale.Scale = math.min(1, AbsoluteSize.X * 0.88 / 430, AbsoluteSize.Y * 0.38 / 146);
    local v28 = {
        GroupTransparency = 0,
        Position = UDim2.fromScale(0.5, 0.18)
    };
    TweenService:Create(u3, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), v28):Play();
    local v29;

    if p24.kind == "Gift" then
        ChickenOrHero.Weapons.ArmoryEvent:FireServer("CheckRewards");
        v29 = 0;
    else
        v29 = 0;
    end;

    while u19 and (not u18 and v29 < 7) do
        task.wait(0.1);

        if ready() then
            u3.Visible = true;
            v29 = v29 + 0.1;
        else
            u3.Visible = false;

            for _, v in u2 do
                v.BackgroundTransparency = 1;
            end;
        end;
    end;

    TweenService:Create(u3, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        GroupTransparency = 1
    }):Play();

    for _, v in u2 do
        TweenService:Create(v, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            BackgroundTransparency = 1
        }):Play();
    end;

    task.wait(0.4);
    u3.Visible = false;

    if u19 then
        AdminEvent:FireServer("AwardAck", p24.id);
    end;

    u17 = nil;
end;

local RunService = game:GetService("RunService");
local SoundService = game:GetService("SoundService");
local Font_new_ret = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy);
local Font_new_ret2 = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.ExtraBold);
local Color3_fromRGB_ret = Color3.fromRGB(170, 90, 255);
local Color3_fromRGB_ret2 = Color3.fromRGB(86, 38, 150);
local Color3_fromRGB_ret3 = Color3.fromRGB(255, 202, 58);
local Color3_new_ret = Color3.new(1, 1, 1);
local Color3_new_ret2 = Color3.new(0, 0, 0);
local Color3_fromRGB_ret4 = Color3.fromRGB(80, 255, 100);
local Color3_fromRGB_ret5 = Color3.fromRGB(17, 213, 40);
local Vector2_new_ret = Vector2.new(560, 470);

local function new(p30, p31, p32) -- Line: 95
    local Instance_new_ret = Instance.new(p30);

    for i, v in p32 do
        Instance_new_ret[i] = v;
    end;

    Instance_new_ret.Parent = p31;

    return Instance_new_ret;
end;

local function round(p33, p34) -- Line: 101
    local v35 = {
        CornerRadius = p34 or UDim.new(0, 12)
    };
    local UICorner = Instance.new("UICorner");

    for i, v in v35 do
        UICorner[i] = v;
    end;

    UICorner.Parent = p33;
end;

local function edge(p36, p37, p38) -- Line: 102
    local v39 = {
        Color = p37,
        Thickness = p38,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    };
    local UIStroke = Instance.new("UIStroke");

    for i, v in v39 do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = p36;

    return UIStroke;
end;

local function words(p40, p41, p42, p43, p44, p45, p46) -- Line: 103
    -- upvalues: Font_new_ret2 (copy), Color3_new_ret2 (copy)
    local v47 = {
        BackgroundTransparency = 1,
        TextScaled = true,
        TextTransparency = 1,
        AutoLocalize = false,
        AnchorPoint = Vector2.new(0.5, 0),
        Position = UDim2.new(0.5, 0, 0, p45),
        Size = UDim2.new(1, -20, 0, p46),
        FontFace = p44 or Font_new_ret2,
        Text = p41,
        TextColor3 = p43,
        TextSize = p42
    };
    local TextLabel = Instance.new("TextLabel");

    for i, v in v47 do
        TextLabel[i] = v;
    end;

    TextLabel.Parent = p40;
    local UITextSizeConstraint = Instance.new("UITextSizeConstraint");

    for i, v in {
        MaxTextSize = p42
    } do
        UITextSizeConstraint[i] = v;
    end;

    UITextSizeConstraint.Parent = TextLabel;
    local v48 = {
        Transparency = 1,
        Color = Color3_new_ret2,
        Thickness = math.max(2, p42 / 12)
    };
    local UIStroke = Instance.new("UIStroke");

    for i, v in v48 do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = TextLabel;

    return TextLabel;
end;

local function show(p49, p50) -- Line: 109
    -- upvalues: TweenService (copy)
    TweenService:Create(p49, TweenInfo.new(p50 or 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        TextTransparency = 0
    }):Play();
    TweenService:Create(p49.UIStroke, TweenInfo.new(p50 or 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Transparency = 0
    }):Play();
end;

local function cue(p51) -- Line: 110
    -- upvalues: SoundService (copy)
    local GameAudio = SoundService:FindFirstChild("GameAudio");

    if GameAudio then
        GameAudio = GameAudio:FindFirstChild("04_UI");
    end;

    if GameAudio then
        GameAudio = GameAudio:FindFirstChild(p51);
    end;

    if GameAudio and GameAudio:IsA("Sound") then
        require(game:GetService("ReplicatedFirst"):WaitForChild("LazySound")).playLocal(GameAudio);
    end;
end;

local function need(p52) -- Line: 115
    -- upvalues: ChickenOrHero (copy)
    local v53 = ChickenOrHero;

    for i in p52:gmatch("[^%.]+") do
        if v53 then
            v53 = v53:FindFirstChild(i);
        end;
    end;

    local success, result = pcall(require, v53);

    return success and result and result or nil;
end;

local function reveal(p54, p55) -- Line: 122
    -- upvalues: need (copy), Color3_new_ret (copy), Font_new_ret (copy), Color3_fromRGB_ret3 (copy), Color3_new_ret2 (copy)
    local v56 = need("Interface.ClaimPop");

    if p55.item == "Knife" or (p55.item == "Bundle" or p55.item == "Perk" and p55.skin) then
        local v57 = need("Weapons.SkinCatalog");
        local v58 = need("Interface.Shop.Preview");

        if v57 then
            if type(p55.skin) == "string" then
                v57 = v57.get(p55.skin);
            else
                v57 = false;
            end;
        end;

        if v57 and v58 then
            local v59 = {
                BackgroundTransparency = 1,
                LightDirection = Vector3.new(-1, -1, -1),
                Size = UDim2.fromScale(1, 1),
                Ambient = Color3.fromRGB(205, 205, 210),
                LightColor = Color3_new_ret
            };
            local ViewportFrame = Instance.new("ViewportFrame");

            for i, v in v59 do
                ViewportFrame[i] = v;
            end;

            ViewportFrame.Parent = p54;
            local success, result = pcall(v58.knife, ViewportFrame, v57, nil);

            if success and result then
                if p55.item == "Perk" then
                    local v60 = {
                        BackgroundTransparency = 1,
                        Text = "👑",
                        TextScaled = true,
                        AnchorPoint = Vector2.new(1, 0),
                        Position = UDim2.fromScale(1, 0),
                        Size = UDim2.fromScale(0.34, 0.34)
                    };
                    local TextLabel = Instance.new("TextLabel");

                    for i, v in v60 do
                        TextLabel[i] = v;
                    end;

                    TextLabel.Parent = p54;
                end;

                return result;
            end;

            ViewportFrame:Destroy();
        end;
    end;

    local v61 = p55.item == "Pack" and v56 and (p55.currency == "coins" and v56.COIN_IMAGE or v56.GEM_IMAGE) or (p55.item == "Emote" and (v56 and v56.EMOTE_IMAGE) or nil);

    if v61 then
        local v62 = {
            BackgroundTransparency = 1,
            Size = UDim2.fromScale(1, 1),
            Image = v61,
            ScaleType = Enum.ScaleType.Fit
        };
        local ImageLabel = Instance.new("ImageLabel");

        for i, v in v62 do
            ImageLabel[i] = v;
        end;

        ImageLabel.Parent = p54;
    else
        local v63 = p55.perk == "DoubleXP" and "2×" or (p55.item == "Perk" and "👑" or "🎁");
        local v64 = {
            BackgroundTransparency = 1,
            TextScaled = true,
            Size = UDim2.fromScale(1, 1),
            FontFace = Font_new_ret,
            Text = v63,
            TextColor3 = Color3_fromRGB_ret3
        };
        local TextLabel = Instance.new("TextLabel");

        for i, v in v64 do
            TextLabel[i] = v;
        end;

        TextLabel.Parent = p54;
        local v65 = {
            Thickness = 4,
            Color = Color3_new_ret2
        };
        local UIStroke = Instance.new("UIStroke");

        for i, v in v65 do
            UIStroke[i] = v;
        end;

        UIStroke.Parent = TextLabel;
    end;

    return nil;
end;

local function giftBox(p66) -- Line: 148
    -- upvalues: Color3_fromRGB_ret (copy), Color3_new_ret2 (copy), Color3_fromRGB_ret2 (copy), Color3_fromRGB_ret3 (copy), Color3_new_ret (copy)
    local v67 = {
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.56),
        Size = UDim2.fromOffset(170, 170)
    };
    local Frame = Instance.new("Frame");

    for i, v in v67 do
        Frame[i] = v;
    end;

    Frame.Parent = p66;
    local v68 = {
        Name = "Body",
        BorderSizePixel = 0,
        AnchorPoint = Vector2.new(0.5, 1),
        Position = UDim2.fromScale(0.5, 1),
        Size = UDim2.fromOffset(150, 112),
        BackgroundColor3 = Color3_fromRGB_ret
    };
    local Frame2 = Instance.new("Frame");

    for i, v in v68 do
        Frame2[i] = v;
    end;

    Frame2.Parent = Frame;
    local v69 = {
        CornerRadius = UDim.new(0, 10) or UDim.new(0, 12)
    };
    local UICorner = Instance.new("UICorner");

    for i, v in v69 do
        UICorner[i] = v;
    end;

    UICorner.Parent = Frame2;
    local v70 = {
        Thickness = 3,
        Color = Color3_new_ret2,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    };
    local UIStroke = Instance.new("UIStroke");

    for i, v in v70 do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = Frame2;
    local v71 = {
        Rotation = 90,
        Color = ColorSequence.new(Color3_fromRGB_ret, Color3_fromRGB_ret2)
    };
    local UIGradient = Instance.new("UIGradient");

    for i, v in v71 do
        UIGradient[i] = v;
    end;

    UIGradient.Parent = Frame2;
    local v72 = {
        BorderSizePixel = 0,
        AnchorPoint = Vector2.new(0.5, 0),
        Position = UDim2.fromScale(0.5, 0),
        Size = UDim2.new(0, 22, 1, 0),
        BackgroundColor3 = Color3_fromRGB_ret3
    };
    local Frame3 = Instance.new("Frame");

    for i, v in v72 do
        Frame3[i] = v;
    end;

    Frame3.Parent = Frame2;
    local v73 = {
        Name = "Lid",
        BorderSizePixel = 0,
        AnchorPoint = Vector2.new(0.5, 1),
        Position = UDim2.new(0.5, 0, 1, -104),
        Size = UDim2.fromOffset(170, 36),
        BackgroundColor3 = Color3_fromRGB_ret
    };
    local Frame4 = Instance.new("Frame");

    for i, v in v73 do
        Frame4[i] = v;
    end;

    Frame4.Parent = Frame;
    local v74 = {
        CornerRadius = UDim.new(0, 8) or UDim.new(0, 12)
    };
    local UICorner2 = Instance.new("UICorner");

    for i, v in v74 do
        UICorner2[i] = v;
    end;

    UICorner2.Parent = Frame4;
    local v75 = {
        Thickness = 3,
        Color = Color3_new_ret2,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    };
    local UIStroke2 = Instance.new("UIStroke");

    for i, v in v75 do
        UIStroke2[i] = v;
    end;

    UIStroke2.Parent = Frame4;
    local v76 = {
        Rotation = 90,
        Color = ColorSequence.new(Color3_fromRGB_ret:Lerp(Color3_new_ret, 0.2), Color3_fromRGB_ret)
    };
    local UIGradient2 = Instance.new("UIGradient");

    for i, v in v76 do
        UIGradient2[i] = v;
    end;

    UIGradient2.Parent = Frame4;
    local v77 = {
        BorderSizePixel = 0,
        AnchorPoint = Vector2.new(0.5, 0),
        Position = UDim2.fromScale(0.5, 0),
        Size = UDim2.new(0, 24, 1, 0),
        BackgroundColor3 = Color3_fromRGB_ret3
    };
    local Frame5 = Instance.new("Frame");

    for i, v in v77 do
        Frame5[i] = v;
    end;

    Frame5.Parent = Frame4;

    for _, v in { -1, 1 } do
        local v78 = {
            BackgroundTransparency = 1,
            AnchorPoint = Vector2.new(0.5, 1),
            Position = UDim2.new(0.5, v * 20, 0, 6),
            Size = UDim2.fromOffset(38, 26),
            Rotation = v * 22
        };
        local Frame6 = Instance.new("Frame");

        for i, v2 in v78 do
            Frame6[i] = v2;
        end;

        Frame6.Parent = Frame4;
        local v79 = {
            CornerRadius = UDim.new(1, 0) or UDim.new(0, 12)
        };
        local UICorner3 = Instance.new("UICorner");

        for i, v2 in v79 do
            UICorner3[i] = v2;
        end;

        UICorner3.Parent = Frame6;
        local v80 = {
            Thickness = 6,
            Color = Color3_fromRGB_ret3,
            ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        };
        local UIStroke3 = Instance.new("UIStroke");

        for i, v2 in v80 do
            UIStroke3[i] = v2;
        end;

        UIStroke3.Parent = Frame6;
    end;

    return Frame, Frame4;
end;

local function confetti(p81) -- Line: 164
    -- upvalues: Color3_fromRGB_ret3 (copy), Color3_fromRGB_ret (copy), Color3_new_ret (copy), Color3_fromRGB_ret4 (copy), TweenService (copy)
    for i = 1, 30 do
        local v82 = {
            BorderSizePixel = 0,
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromScale(0.5, 0.5),
            Size = UDim2.fromOffset(math.random(7, 12), math.random(10, 16)),
            BackgroundColor3 = ({
                Color3_fromRGB_ret3,
                Color3_fromRGB_ret,
                Color3_new_ret,
                Color3_fromRGB_ret4,
                Color3.fromRGB(255, 110, 150)
            })[i % 5 + 1],
            Rotation = math.random(0, 360)
        };
        local Frame = Instance.new("Frame");
        local _ = i;

        for i2, v in v82 do
            Frame[i2] = v;
        end;

        Frame.Parent = p81;
        local math_random_ret = math.random(0, 360);
        local math_rad_ret = math.rad(math_random_ret);
        local math_random_ret2 = math.random(140, 300);
        TweenService:Create(Frame, TweenInfo.new(1.1 + math.random() * 0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            BackgroundTransparency = 1,
            Position = UDim2.new(0.5, math.cos(math_rad_ret) * math_random_ret2, 0.5, math.sin(math_rad_ret) * math_random_ret2 * 0.7 + 90),
            Rotation = Frame.Rotation + math.random(-260, 260)
        }):Play();
    end;
end;

local u83 = nil;

local function presentGift(p84, p85) -- Line: 174
    -- upvalues: u17 (ref), u18 (ref), Vector2_new_ret (copy), Color3_fromRGB_ret (copy), Color3_fromRGB_ret3 (copy), Color3_fromRGB_ret2 (copy), words (copy), Font_new_ret2 (copy), Color3_new_ret (copy), Font_new_ret (copy), giftBox (copy), Color3_new_ret2 (copy), Color3_fromRGB_ret4 (copy), Color3_fromRGB_ret5 (copy), u83 (ref), LocalPlayer (copy), RunService (copy), TweenService (copy), show (copy), cue (copy), confetti (copy), reveal (copy), need (copy), ChickenOrHero (copy), u19 (ref), ready (copy), AdminEvent (copy)
    u17 = p84;
    u18 = false;
    local v86 = {
        Name = "ValleyGiftReveal",
        ResetOnSpawn = false,
        IgnoreGuiInset = true,
        DisplayOrder = 92,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    };
    local ScreenGui = Instance.new("ScreenGui");

    for i, v in v86 do
        ScreenGui[i] = v;
    end;

    ScreenGui.Parent = nil;
    ScreenGui:SetAttribute("SelfManagedText", true);
    local v87 = {
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Active = false,
        Size = UDim2.fromScale(1, 1),
        BackgroundColor3 = Color3.fromRGB(20, 8, 36)
    };
    local Frame = Instance.new("Frame");

    for i, v in v87 do
        Frame[i] = v;
    end;

    Frame.Parent = ScreenGui;
    local v88 = {
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromOffset(Vector2_new_ret.X, Vector2_new_ret.Y)
    };
    local Frame2 = Instance.new("Frame");

    for i, v in v88 do
        Frame2[i] = v;
    end;

    Frame2.Parent = ScreenGui;
    local UIScale = Instance.new("UIScale");

    for i, v in {
        Scale = 0.6
    } do
        UIScale[i] = v;
    end;

    UIScale.Parent = Frame2;

    local function fit() -- Line: 181
        -- upvalues: ScreenGui (copy), Vector2_new_ret (ref)
        local AbsoluteSize = ScreenGui.AbsoluteSize;

        return math.min(1, AbsoluteSize.X * 0.94 / Vector2_new_ret.X, AbsoluteSize.Y * 0.9 / Vector2_new_ret.Y);
    end;

    local v89 = {
        BackgroundTransparency = 1,
        Image = "rbxassetid://129028976496842",
        ImageTransparency = 1,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.56),
        Size = UDim2.fromOffset(520, 520),
        ImageColor3 = Color3_fromRGB_ret:Lerp(Color3_fromRGB_ret3, 0.35)
    };
    local ImageLabel = Instance.new("ImageLabel");

    for i, v in v89 do
        ImageLabel[i] = v;
    end;

    ImageLabel.Parent = Frame2;
    local v90 = {
        ImageTransparency = 1,
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(0.5, 0),
        Position = UDim2.fromOffset(Vector2_new_ret.X / 2, 0),
        Size = UDim2.fromOffset(72, 72),
        BackgroundColor3 = Color3_fromRGB_ret2,
        Image = ("rbxthumb://type=AvatarHeadShot&id=%d&w=150&h=150"):format(p85)
    };
    local ImageLabel2 = Instance.new("ImageLabel");

    for i, v in v90 do
        ImageLabel2[i] = v;
    end;

    ImageLabel2.Parent = Frame2;
    local v91 = {
        CornerRadius = UDim.new(1, 0) or UDim.new(0, 12)
    };
    local UICorner = Instance.new("UICorner");

    for i, v in v91 do
        UICorner[i] = v;
    end;

    UICorner.Parent = ImageLabel2;
    local v92 = {
        Thickness = 4,
        Color = Color3_fromRGB_ret3,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    };
    local UIStroke = Instance.new("UIStroke");

    for i, v in v92 do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = ImageLabel2;
    UIStroke.Transparency = 1;
    local v93 = words(Frame2, tostring(p84.from or ""), 22, Color3_fromRGB_ret3, Font_new_ret2, 78, 26);
    local v94 = words(Frame2, "SENT YOU A GIFT!", 40, Color3_new_ret, Font_new_ret, 104, 46);
    local v95, v96 = giftBox(Frame2);
    v95.Size = UDim2.fromOffset(0, 0);
    local v97 = {
        BackgroundTransparency = 1,
        Visible = false,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.56),
        Size = UDim2.fromOffset(190, 190)
    };
    local Frame3 = Instance.new("Frame");

    for i, v in v97 do
        Frame3[i] = v;
    end;

    Frame3.Parent = Frame2;
    local UIScale2 = Instance.new("UIScale");

    for i, v in {
        Scale = 0
    } do
        UIScale2[i] = v;
    end;

    UIScale2.Parent = Frame3;
    local v98 = words(Frame2, p84.label, 32, Color3_fromRGB_ret3, Font_new_ret, 340, 38);
    local v99 = words(Frame2, p84.detail or "", 17, Color3.fromRGB(230, 226, 240), Font_new_ret2, 378, 22);
    local v100 = {
        AutoButtonColor = true,
        Text = "",
        Visible = false,
        AnchorPoint = Vector2.new(0.5, 0),
        Position = UDim2.fromOffset(Vector2_new_ret.X / 2, 410),
        Size = UDim2.fromOffset(230, 54),
        BackgroundColor3 = Color3_new_ret
    };
    local TextButton = Instance.new("TextButton");

    for i, v in v100 do
        TextButton[i] = v;
    end;

    TextButton.Parent = Frame2;
    local v101 = {
        CornerRadius = UDim.new(0, 14) or UDim.new(0, 12)
    };
    local UICorner2 = Instance.new("UICorner");

    for i, v in v101 do
        UICorner2[i] = v;
    end;

    UICorner2.Parent = TextButton;
    local v102 = {
        Thickness = 3,
        Color = Color3_new_ret2,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    };
    local UIStroke2 = Instance.new("UIStroke");

    for i, v in v102 do
        UIStroke2[i] = v;
    end;

    UIStroke2.Parent = TextButton;
    local v103 = {
        Rotation = 90,
        Color = ColorSequence.new(Color3_fromRGB_ret4, Color3_fromRGB_ret5)
    };
    local UIGradient = Instance.new("UIGradient");

    for i, v in v103 do
        UIGradient[i] = v;
    end;

    UIGradient.Parent = TextButton;
    local v104 = {
        BackgroundTransparency = 1,
        Text = "THANK YOU!",
        TextSize = 24,
        AutoLocalize = false,
        Size = UDim2.fromScale(1, 1),
        FontFace = Font_new_ret,
        TextColor3 = Color3_new_ret
    };
    local TextLabel = Instance.new("TextLabel");

    for i, v in v104 do
        TextLabel[i] = v;
    end;

    TextLabel.Parent = TextButton;
    local v105 = {
        Thickness = 2.5,
        Color = Color3_new_ret2
    };
    local UIStroke3 = Instance.new("UIStroke");

    for i, v in v105 do
        UIStroke3[i] = v;
    end;

    UIStroke3.Parent = TextLabel;
    local u106 = {};
    local u107 = nil;

    u83 = function() -- Line: 200
        -- upvalues: u83 (ref), u106 (copy), u107 (ref), ScreenGui (copy)
        u83 = nil;

        for _, v in u106 do
            v:Disconnect();
        end;

        table.clear(u106);

        if u107 then
            pcall(u107.destroy, u107);
            u107 = nil;
        end;

        ScreenGui:Destroy();
    end;

    table.insert(u106, TextButton.Activated:Connect(function() -- Line: 207
        -- upvalues: u18 (ref)
        u18 = true;
    end));
    local PropertyChangedSignal = ScreenGui:GetPropertyChangedSignal("AbsoluteSize");
    table.insert(u106, PropertyChangedSignal:Connect(function() -- Line: 208
        -- upvalues: UIScale (copy), ScreenGui (copy), Vector2_new_ret (ref)
        if UIScale.Scale > 0.95 then
            local AbsoluteSize = ScreenGui.AbsoluteSize;
            UIScale.Scale = math.min(1, AbsoluteSize.X * 0.94 / Vector2_new_ret.X, AbsoluteSize.Y * 0.9 / Vector2_new_ret.Y);
        end;
    end));
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui");
    table.insert(u106, RunService.RenderStepped:Connect(function(p108) -- Line: 210
        -- upvalues: ImageLabel (copy), u107 (ref)
        ImageLabel.Rotation = (ImageLabel.Rotation + p108 * 18) % 360;

        if u107 then
            u107:step(p108);
        end;
    end));
    TweenService:Create(Frame, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        BackgroundTransparency = 0.4
    }):Play();
    local TweenInfo_new_ret = TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out);
    local v109 = {};
    local AbsoluteSize = ScreenGui.AbsoluteSize;
    v109.Scale = math.min(1, AbsoluteSize.X * 0.94 / Vector2_new_ret.X, AbsoluteSize.Y * 0.9 / Vector2_new_ret.Y);
    TweenService:Create(UIScale, TweenInfo_new_ret, v109):Play();
    TweenService:Create(ImageLabel2, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        ImageTransparency = 0,
        BackgroundTransparency = 0
    }):Play();
    TweenService:Create(UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Transparency = 0
    }):Play();
    show(v93);
    show(v94);
    cue("PanelOpen");
    TweenService:Create(v95, TweenInfo.new(0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.fromOffset(170, 170)
    }):Play();
    task.wait(0.55);

    for i = 1, 6 do
        TweenService:Create(v95, TweenInfo.new(0.07, Enum.EasingStyle.Sine), {
            Rotation = (i % 2 == 1 and 9 or -9) * (1 - i / 8)
        }):Play();
        task.wait(0.08);
        local _ = i;
    end;

    v95.Rotation = 0;
    TweenService:Create(v96, TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Rotation = 28,
        BackgroundTransparency = 1,
        Position = UDim2.new(0.5, 40, 1, -260)
    }):Play();

    for _, descendant in v96:GetDescendants() do
        if descendant:IsA("Frame") then
            TweenService:Create(descendant, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                BackgroundTransparency = 1
            }):Play();
        elseif descendant:IsA("UIStroke") then
            TweenService:Create(descendant, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Transparency = 1
            }):Play();
        end;
    end;

    local v110 = {
        BackgroundTransparency = 0.35,
        BorderSizePixel = 0,
        Active = false,
        Size = UDim2.fromScale(1, 1),
        BackgroundColor3 = Color3_new_ret
    };
    local Frame4 = Instance.new("Frame");

    for i, v in v110 do
        Frame4[i] = v;
    end;

    Frame4.Parent = ScreenGui;
    TweenService:Create(Frame4, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        BackgroundTransparency = 1
    }):Play();
    TweenService:Create(ImageLabel, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        ImageTransparency = 0.25
    }):Play();
    confetti(Frame2);

    for _, descendant in v95:GetDescendants() do
        if descendant:IsA("Frame") then
            TweenService:Create(descendant, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                BackgroundTransparency = 1
            }):Play();
        elseif descendant:IsA("UIStroke") then
            TweenService:Create(descendant, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Transparency = 1
            }):Play();
        end;
    end;

    u107 = reveal(Frame3, p84);
    Frame3.Visible = true;
    TweenService:Create(UIScale2, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Scale = 1
    }):Play();
    show(v98, 0.35);
    show(v99, 0.35);
    TextButton.Visible = true;
    cue("Purchase");
    local v111 = need("Interface.RewardPop");

    if v111 and v111.chime then
        pcall(v111.chime, 1);
    end;

    local v112;

    if p84.kind == "Gift" then
        ChickenOrHero.Weapons.ArmoryEvent:FireServer("CheckRewards");
        v112 = 0;
    else
        v112 = 0;
    end;

    while u19 and (not u18 and v112 < 9) do
        task.wait(0.1);

        if ready() then
            ScreenGui.Enabled = true;
            v112 = v112 + 0.1;
        else
            ScreenGui.Enabled = false;
        end;
    end;

    local TweenInfo_new_ret2 = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In);
    local v113 = {};
    local AbsoluteSize2 = ScreenGui.AbsoluteSize;
    v113.Scale = math.min(1, AbsoluteSize2.X * 0.94 / Vector2_new_ret.X, AbsoluteSize2.Y * 0.9 / Vector2_new_ret.Y) * 0.8;
    TweenService:Create(UIScale, TweenInfo_new_ret2, v113):Play();

    for _, descendant in ScreenGui:GetDescendants() do
        if descendant:IsA("TextLabel") then
            TweenService:Create(descendant, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                TextTransparency = 1
            }):Play();
        elseif descendant:IsA("ImageLabel") then
            TweenService:Create(descendant, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                ImageTransparency = 1,
                BackgroundTransparency = 1
            }):Play();
        elseif descendant:IsA("UIStroke") then
            TweenService:Create(descendant, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Transparency = 1
            }):Play();
        elseif descendant:IsA("Frame") or descendant:IsA("TextButton") then
            TweenService:Create(descendant, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                BackgroundTransparency = 1
            }):Play();
        end;
    end;

    task.wait(0.3);

    if u83 then
        u83();
    end;

    if u19 then
        AdminEvent:FireServer("AwardAck", p84.id);
    end;

    u17 = nil;
end;

v14.Activated:Connect(function() -- Line: 265
    -- upvalues: u18 (ref)
    u18 = true;
end);
AdminEvent.OnClientEvent:Connect(function(p114, p115) -- Line: 266
    -- upvalues: u16 (copy), u15 (copy), u17 (ref), AdminEvent (copy)
    if p114 ~= "Awards" or type(p115) ~= "table" then
        return;
    end;

    for _, v in p115 do
        if type(v) == "table" and (type(v.id) == "string" and type(v.label) == "string") then
            if u16[v.id] then
                if not u17 or u17.id ~= v.id then
                    local v116 = v;
                    local v117 = false;

                    for _, v2 in u15 do
                        if v2.id == v116.id then
                            v117 = true;
                            break;
                        end;
                    end;

                    if not v117 then
                        AdminEvent:FireServer("AwardAck", v116.id);
                    end;
                end;
            else
                u16[v.id] = true;
                table.insert(u15, v);
            end;
        end;
    end;
end);
u1:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 47, Name: layout
    -- upvalues: u1 (copy), u3 (copy)
    local AbsoluteSize = u1.AbsoluteSize;
    u3.Scale.Scale = math.min(1, AbsoluteSize.X * 0.88 / 430, AbsoluteSize.Y * 0.38 / 146);
end);
LocalPlayer:GetAttributeChangedSignal("ClientReady"):Connect(function() -- Line: 279, Name: sync
    -- upvalues: ready (copy), AdminEvent (copy)
    if ready() then
        AdminEvent:FireServer("AwardReady");
    end;
end);
task.spawn(function() -- Line: 281
    -- upvalues: u19 (ref), ready (copy), u15 (copy), presentGift (copy), u83 (ref), present (copy)
    while u19 do
        if ready() and #u15 > 0 then
            local table_remove_ret = table.remove(u15, 1);
            local v118;

            if table_remove_ret.kind == "Gift" and (type(table_remove_ret.senderId) == "number" and (table_remove_ret.senderId > 0 and table_remove_ret.senderId % 1 == 0)) then
                v118 = table_remove_ret.senderId or nil;
            else
                v118 = nil;
            end;

            if v118 then
                local success, result = pcall(presentGift, table_remove_ret, v118);

                if not success then
                    warn("Gift reveal failed: " .. tostring(result));

                    if u83 then
                        u83();
                    end;

                    present(table_remove_ret);
                end;
            else
                present(table_remove_ret);
            end;
        else
            task.wait(0.2);
        end;
    end;
end);
local AbsoluteSize = u1.AbsoluteSize;
u3.Scale.Scale = math.min(1, AbsoluteSize.X * 0.88 / 430, AbsoluteSize.Y * 0.38 / 146);

if ready() then
    AdminEvent:FireServer("AwardReady");
end;

script.Destroying:Connect(function() -- Line: 295
    -- upvalues: u19 (ref), u83 (ref), u1 (copy)
    u19 = false;

    if u83 then
        u83();
    end;

    u1:Destroy();
end);