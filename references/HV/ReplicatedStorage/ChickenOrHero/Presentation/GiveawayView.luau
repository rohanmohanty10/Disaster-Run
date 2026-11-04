 

 

local ValleyPanels = require(script.Parent.ValleyPanels);
local ValleyTheme = require(script.Parent.ValleyTheme);
local SkinCatalog = require(script.Parent.Parent.Weapons.SkinCatalog);
local KnifeIconCopy = require(script.Parent.Parent.Weapons.KnifeIconCopy);
local VerifiedName = require(script.Parent.VerifiedName);
local u1 = {};
u1.__index = u1;

local function text(p2, p3, p4, p5, p6, p7, p8, p9, p10) -- Line: 7
    -- upvalues: ValleyPanels (copy)
    local v11 = ValleyPanels.text(p2, p3, p4, p5, p6, p7, p8, p9, p10);
    v11.RichText = false;

    return v11;
end;

local function circle(p12, p13, p14, p15, p16) -- Line: 10
    -- upvalues: ValleyPanels (copy)
    local v17 = ValleyPanels.make("Frame", p12, p13, {
        BorderSizePixel = 0,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromOffset(p14, p14),
        BackgroundColor3 = p15,
        BackgroundTransparency = p16 or 0
    });
    ValleyPanels.make("UICorner", v17, "Round", {
        CornerRadius = UDim.new(1, 0)
    });

    return v17;
end;

function u1.preview(p18, p19) -- Line: 14
    -- upvalues: SkinCatalog (copy), KnifeIconCopy (copy)
    p18:ClearAllChildren();
    local v20 = SkinCatalog.get(p19);

    if v20 then
        v20 = script.Parent.Parent.Weapons.Models:FindFirstChild(v20.Model);
    end;

    if not v20 then
        return;
    end;

    local WorldModel = Instance.new("WorldModel");
    WorldModel.Parent = p18;
    local v21, _, v22, v23 = KnifeIconCopy.new(v20.Blade);
    v21.Parent = WorldModel;
    local Rotation = (v20:GetAttribute("PreviewRotation") or CFrame.identity).Rotation;
    v21.CFrame = CFrame.new(-Rotation:VectorToWorldSpace(v23)) * Rotation;
    local Camera = Instance.new("Camera");
    Camera.FieldOfView = 36;
    local math_max_ret = math.max(v22.X, v22.Y, v22.Z);
    Camera.CFrame = CFrame.lookAt(Vector3.new(0, 0, math_max_ret * 1.65), Vector3.new(0, 0, 0));
    Camera.Parent = p18;
    p18.CurrentCamera = Camera;
    p18.Ambient = Color3.fromRGB(210, 210, 220);
    p18.LightColor = Color3.new(1, 1, 1);
    p18.LightDirection = Vector3.new(-1, -1, -2);
end;

function u1.new(p24) -- Line: 29
    -- upvalues: ValleyPanels (copy), ValleyTheme (copy), circle (copy), u1 (copy)
    local u25 = ValleyPanels.make("ScreenGui", p24, "GlobalGiveaway", {
        ResetOnSpawn = false,
        IgnoreGuiInset = true,
        ClipToDeviceSafeArea = false,
        DisplayOrder = 10000,
        Enabled = false,
        ScreenInsets = Enum.ScreenInsets.None,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    });
    local v26 = ValleyPanels.make("TextButton", u25, "Dim", {
        Text = "",
        AutoButtonColor = false,
        BackgroundTransparency = 0.12,
        BorderSizePixel = 0,
        Modal = true,
        Active = true,
        Size = UDim2.fromScale(1, 1),
        BackgroundColor3 = Color3.fromRGB(3, 8, 15)
    });
    ValleyPanels.cursorWhileVisible(v26);
    local u27 = ValleyPanels.make("Frame", v26, "Stage", {
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromOffset(1100, 620)
    });
    local u28 = ValleyPanels.make("UIScale", u27, "Scale", {});
    local u29 = ValleyPanels.text(u27, "Heading", "THE OWNER\'S GLOBAL GIVEAWAY", 26, 18, 1030, 28, 14, ValleyTheme.Gold);
    u29.RichText = false;
    u29.Font = Enum.Font.GothamBold;
    local u30 = ValleyPanels.text(u27, "Title", "ONE SERVER. ONE WINNER.", 26, 52, 1030, 52, 32, ValleyTheme.Paper);
    u30.RichText = false;
    u30.Font = Enum.Font.GothamBlack;
    local u31 = ValleyPanels.text(u27, "Subtitle", "The owner has begun a global wheel spin.", 28, 105, 1040, 30, 16, ValleyTheme.Muted);
    u31.RichText = false;
    local u32 = ValleyPanels.make("Frame", u27, "WheelWindow", {
        BackgroundTransparency = 1,
        ClipsDescendants = true,
        Position = UDim2.fromOffset(0, 138),
        Size = UDim2.fromOffset(690, 440)
    });
    local v33 = circle(ValleyPanels.make("Frame", u32, "Center", {
        BackgroundTransparency = 1,
        Position = UDim2.fromOffset(285, 232),
        Size = UDim2.fromOffset(0, 0)
    }), "Wheel", 580, ValleyTheme.InventoryInk, 0.05);
    ValleyPanels.stroke(v33, ValleyTheme.Gold, 0.3);
    v33.Outline.Thickness = 3;
    local v34 = circle(v33, "InnerRing", 410, ValleyTheme.Ink, 0.15);
    ValleyPanels.stroke(v34, ValleyTheme.Gold, 0.8);
    local v35 = ValleyPanels.make("Frame", v33, "Seats", {
        BackgroundTransparency = 1,
        Size = UDim2.fromScale(1, 1)
    });
    local v36 = circle(v33, "Hub", 170, ValleyTheme.Ink, 0);
    ValleyPanels.stroke(v36, ValleyTheme.Gold, 0.45);
    v36.ZIndex = 3;
    local v37 = ValleyPanels.text(v36, "Words", "VALLEY\nGIVEAWAY", 0, 40, 170, 90, 14, ValleyTheme.Gold);
    v37.RichText = false;
    v37.TextXAlignment = Enum.TextXAlignment.Center;
    v37.Font = Enum.Font.GothamBold;
    local v38 = ValleyPanels.make("ImageLabel", v36, "CurrentPlayer", {
        BackgroundTransparency = 1,
        Visible = false,
        AnchorPoint = Vector2.new(0.5, 0),
        Position = UDim2.new(0.5, 0, 0, 10),
        Size = UDim2.fromOffset(110, 110)
    });
    ValleyPanels.corner(v38, 12);
    local v39 = ValleyPanels.text(u32, "Pointer", "◀", 552, 211, 58, 54, 44, ValleyTheme.Gold);
    v39.RichText = false;
    v39.ZIndex = 8;
    local u40 = ValleyPanels.make("Frame", u27, "Prize", {
        BorderSizePixel = 0,
        Position = UDim2.fromOffset(724, 165),
        Size = UDim2.fromOffset(340, 359),
        BackgroundColor3 = ValleyTheme.Ink
    });
    ValleyTheme.surface(u40, ValleyTheme.Ink, ValleyTheme.Gold, 8, 0.35);
    ValleyPanels.text(u40, "Label", "THE PRIZE", 20, 18, 300, 24, 12, ValleyTheme.Gold).RichText = false;
    local u41 = ValleyPanels.make("ViewportFrame", u40, "Preview", {
        BackgroundTransparency = 1,
        Position = UDim2.fromOffset(20, 50),
        Size = UDim2.fromOffset(300, 190)
    });
    local u42 = ValleyPanels.text(u40, "Amount", "", 20, 75, 300, 150, 55, ValleyTheme.Gold);
    u42.RichText = false;
    u42.TextXAlignment = Enum.TextXAlignment.Center;
    u42.Font = Enum.Font.GothamBlack;
    local u43 = ValleyPanels.text(u40, "Name", "", 20, 250, 300, 55, 24, ValleyTheme.Paper);
    u43.RichText = false;
    u43.Font = Enum.Font.GothamBold;
    u43.TextXAlignment = Enum.TextXAlignment.Center;
    local u44 = ValleyPanels.text(u40, "Caption", "A gift from the owner", 20, 312, 300, 24, 13, ValleyTheme.Muted);
    u44.RichText = false;
    u44.TextXAlignment = Enum.TextXAlignment.Center;
    local u45 = ValleyPanels.text(u27, "Selected", "", 26, 564, 1040, 34, 22, ValleyTheme.Gold);
    u45.RichText = false;
    u45.Font = Enum.Font.GothamBold;
    local u46 = ValleyPanels.text(u27, "Note", "", 28, 599, 1030, 20, 12, ValleyTheme.Muted);
    u46.RichText = false;
    local v47 = {};

    for i = 1, 28 do
        v47[i] = ValleyPanels.make("Frame", u27, "Confetti" .. i, {
            BorderSizePixel = 0,
            Visible = false,
            ZIndex = 10,
            Active = false,
            Size = UDim2.fromOffset(i % 4 + 5, i % 6 + 9),
            BackgroundColor3 = i % 2 == 0 and ValleyTheme.Gold or ValleyTheme.Purple
        });
        local _ = i;
    end;

    local u48 = setmetatable({
        heroPortrait = v38,
        confetti = v47,
        gui = u25,
        root = u27,
        scale = u28,
        port = u32,
        disc = v33,
        ring = v35,
        hubText = v37,
        prize = u40,
        preview = u41,
        amount = u42,
        name = u43,
        caption = u44,
        heading = u29,
        title = u30,
        sub = u31,
        selected = u45,
        note = u46,
        cards = {},
        pointer = v39
    }, u1);

    local function layout() -- Line: 64
        -- upvalues: u25 (copy), u48 (copy), u27 (copy), u28 (copy), u29 (copy), u30 (copy), u31 (copy), u32 (copy), u40 (copy), u41 (copy), u42 (copy), u43 (copy), u44 (copy), u45 (copy), u46 (copy)
        local AbsoluteSize = u25.AbsoluteSize;
        local v49 = AbsoluteSize.X < AbsoluteSize.Y;
        u48.note.TextSize = (v49 or AbsoluteSize.Y < 520) and 18 or 12;
        local v50 = v49 and 620 or 1100;
        local v51 = v49 and 920 or 680;
        u27.Size = UDim2.fromOffset(v50, v51);
        u28.Scale = math.min(AbsoluteSize.X * 0.97 / v50, AbsoluteSize.Y * 0.96 / v51, 1.3);
        u29.Size = UDim2.fromOffset(v50 - 50, 28);
        u30.Size = UDim2.fromOffset(v50 - 50, 52);
        u30.TextSize = v49 and 26 or 32;
        u31.Size = UDim2.fromOffset(v50 - 50, 42);
        u32.Position = UDim2.fromOffset(0, v49 and 150 or 138);
        u32.Size = UDim2.fromOffset(v49 and 620 or 690, v49 and 470 or 440);
        u40.Position = v49 and UDim2.fromOffset(26, 676) or UDim2.fromOffset(724, 165);
        u40.Size = v49 and UDim2.fromOffset(568, 175) or UDim2.fromOffset(340, 359);
        u41.Position = v49 and UDim2.fromOffset(10, 10) or UDim2.fromOffset(20, 50);
        u41.Size = v49 and UDim2.fromOffset(170, 155) or UDim2.fromOffset(300, 190);
        u42.Position = u41.Position;
        u42.Size = u41.Size;
        u42.TextSize = v49 and 34 or 55;
        u40.Label.Position = v49 and UDim2.fromOffset(198, 18) or UDim2.fromOffset(20, 18);
        u43.Position = v49 and UDim2.fromOffset(190, 55) or UDim2.fromOffset(20, 250);
        u43.Size = v49 and UDim2.fromOffset(350, 70) or UDim2.fromOffset(300, 55);
        u44.Position = v49 and UDim2.fromOffset(190, 131) or UDim2.fromOffset(20, 312);
        u44.Size = v49 and UDim2.fromOffset(350, 24) or UDim2.fromOffset(300, 24);
        u45.Position = UDim2.fromOffset(26, v49 and 628 or 588);
        u45.Size = UDim2.fromOffset(v50 - 50, 40);
        u46.Position = UDim2.fromOffset(28, v49 and 875 or 637);
        u46.Size = UDim2.fromOffset(v50 - 56, 34);
    end;

    u25:GetPropertyChangedSignal("AbsoluteSize"):Connect(layout);
    layout();

    return u48;
end;

function u1.show(p52, p53, p54) -- Line: 83
    -- upvalues: ValleyPanels (copy), ValleyTheme (copy), VerifiedName (copy), SkinCatalog (copy), u1 (copy)
    p52.data = p53;
    p52.gui.Enabled = true;
    p52.ring:ClearAllChildren();
    table.clear(p52.cards);
    local pool = p53.pool;
    p52.winnerIndex = 1;

    for i, v in pool do
        if v.id == p53.winner.id then
            p52.winnerIndex = i;
        end;

        local v55 = (i - 1) / #pool * 3.141592653589793 * 2;
        local math_clamp_ret = math.clamp(1533.097214951819 / #pool * 0.72, 22, 74);
        local v56 = ValleyPanels.make("Frame", p52.ring, "Player" .. i, {
            BorderSizePixel = 0,
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.new(0.5, math.cos(v55) * 244, 0.5, math.sin(v55) * 244),
            Size = UDim2.fromOffset(math_clamp_ret, math_clamp_ret),
            BackgroundColor3 = ValleyTheme.Ink
        });
        ValleyPanels.corner(v56, 6);
        ValleyPanels.stroke(v56, ValleyTheme.Gold, 0.5);
        local v57 = ValleyPanels.make("ImageLabel", v56, "Portrait", {
            BackgroundTransparency = 1,
            Size = UDim2.fromScale(1, 1),
            Image = "rbxthumb://type=AvatarHeadShot&id=" .. v.id .. "&w=150&h=150"
        });
        ValleyPanels.corner(v57, 6);

        if #pool <= 14 then
            local v58 = VerifiedName.format(v.display, v.verified, v.id);
            local v59 = ValleyPanels.text(v56, "Name", v58, -30, math_clamp_ret + 3, math_clamp_ret + 60, 30, 11, ValleyTheme.Paper);
            v59.RichText = false;
            v59.RichText = true;
            v59.TextXAlignment = Enum.TextXAlignment.Center;
        end;

        table.insert(p52.cards, v56);
    end;

    local prize = p53.prize;
    p52.name.Text = prize.kind == "Dagger" and SkinCatalog.get(prize.skin).Name or prize.kind:upper();
    p52.preview.Visible = prize.kind == "Dagger";
    p52.amount.Visible = not p52.preview.Visible;

    if p52.preview.Visible then
        u1.preview(p52.preview, prize.skin);
    else
        p52.preview:ClearAllChildren();
        p52.amount.Text = tostring(prize.amount);
    end;

    local v60 = false;

    for _, v in pool do
        if v.id == p54 then
            v60 = true;
            break;
        end;
    end;

    p52.note.Text = p53.preview and "PREVIEW ONLY · No prizes are awarded." or (p53.excluded[tostring(p54)] or (v60 and "Match paused · It resumes automatically after the result." or "You joined after this draw opened. Enjoy the result!"));
    p52.heading.Text = p53.preview and "OWNER PREVIEW  /  NO REWARDS" or "THE OWNER\'S GLOBAL GIVEAWAY";
    p52.finalAngle = 2520 - (p52.winnerIndex - 1) * 360 / #pool;
    p52.lastIndex = nil;

    for _, v in p52.confetti do
        v.Visible = false;
    end;
end;

function u1.step(p61, p62) -- Line: 108
    -- upvalues: VerifiedName (copy), ValleyTheme (copy)
    local data = p61.data;

    if data then
        local v63 = p62 < data.spinAt;
        local math_clamp_ret = math.clamp((p62 - data.spinAt) / (data.resultAt - data.spinAt), 0, 1);
        local v64 = v63 and -80 or -80 + (p61.finalAngle + 80) * (1 - (1 - math_clamp_ret) ^ 5);
        p61.ring.Rotation = v64;

        for _, v in p61.cards do
            v.Rotation = -v64;
        end;

        local v65 = math.floor(-v64 % 360 / 360 * #data.pool + 0.5) % #data.pool + 1;
        local v66 = data.pool[v65];
        p61.title.Text = v63 and "A GLOBAL WHEEL HAS BEGUN" or (math_clamp_ret < 1 and "WHO WILL TAKE IT HOME?" or "WE HAVE A WINNER!");
        p61.sub.Text = v63 and "The owner is giving away " .. p61.name.Text .. "." or (math_clamp_ret < 1 and "Spinning for " .. #data.pool .. " eligible players in this server." or (data.preview and "Preview complete. No prize was awarded." or "Prize saved. It\'s yours to keep."));
        p61.hubText.Text = v63 and "GET\nREADY" or (math_clamp_ret < 1 and "GOOD\nLUCK" or "WINNER");

        if math_clamp_ret >= 1 then
            v66 = data.winner;
        end;

        p61.heroPortrait.Visible = not v63;
        p61.hubText.Position = UDim2.fromOffset(0, v63 and 40 or 122);
        p61.hubText.Size = UDim2.fromOffset(170, v63 and 90 or 36);

        if not v63 then
            p61.hubText.RichText = true;
            p61.hubText.Text = VerifiedName.format(v66.display, v66.verified, v66.id);
            p61.heroPortrait.Image = "rbxthumb://type=AvatarHeadShot&id=" .. v66.id .. "&w=150&h=150";
        end;

        p61.selected.RichText = true;
        p61.selected.Text = (math_clamp_ret >= 1 and "WINNER  ·  " or "") .. VerifiedName.format(v66.display, v66.verified, v66.id) .. "  @" .. v66.name;

        if math_clamp_ret >= 1 then
            for i, v in p61.cards do
                v.Outline.Color = i == p61.winnerIndex and ValleyTheme.Gold or ValleyTheme.Border;
                v.Outline.Thickness = i == p61.winnerIndex and 4 or 1;
            end;
        end;

        local v67 = p62 - data.resultAt;

        for i, v in p61.confetti do
            local v68;

            if v67 >= 0 then
                v68 = v67 < 3;
            else
                v68 = false;
            end;

            v.Visible = v68;

            if v.Visible then
                local v69 = v67 / 3;
                v.Position = UDim2.fromScale(i * 0.618 % 1 + math.sin(v67 * 3 + i) * 0.03, -0.12 + v69 * (1.2 + i % 5 * 0.12));
                v.Rotation = i * 47 + v67 * (i % 2 == 0 and 90 or -90);
                v.BackgroundTransparency = math.clamp((v69 - 0.65) / 0.35, 0, 1);
            end;
        end;

        local v70;

        if v65 == p61.lastIndex then
            v70 = false;
        else
            v70 = not v63 and math_clamp_ret < 1;
        end;

        p61.lastIndex = v65;

        return v70, math_clamp_ret >= 1;
    end;
end;

function u1.hide(p71) -- Line: 143
    p71.gui.Enabled = false;
    p71.data = nil;
    p71.preview:ClearAllChildren();
    p71.ring:ClearAllChildren();
    table.clear(p71.cards);
end;

return u1;