 

 

local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local ChickenOrHero = game:GetService("ReplicatedStorage"):WaitForChild("ChickenOrHero");
local Weapons = ChickenOrHero:WaitForChild("Weapons");
local CombineConfig = require(Weapons:WaitForChild("CombineConfig"));
local SkinCatalog = require(Weapons:WaitForChild("SkinCatalog"));
local KnifeIconCopy = require(Weapons:WaitForChild("KnifeIconCopy"));
local ArmoryEvent = Weapons:WaitForChild("ArmoryEvent");
local LocalPlayer = Players.LocalPlayer;
local u1 = {};
u1.__index = u1;

local function openFamilies() -- Line: 37
    -- upvalues: Weapons (copy), CombineConfig (copy)
    local CombineEvent = Weapons:FindFirstChild("CombineEvent");

    if CombineEvent then
        CombineEvent = CombineEvent:GetAttribute("Families");
    end;

    local v2 = {};

    if type(CombineEvent) == "string" then
        for i in string.gmatch(CombineEvent, "[^,]+") do
            v2[i] = true;
        end;
    end;

    local v3 = {};

    for _, v in CombineConfig.Order do
        if v2[v] and (type(CombineConfig.Families[v]) == "table" and not table.find(v3, v)) then
            table.insert(v3, v);
        end;
    end;

    return v3;
end;

local function fusionOpen() -- Line: 56
    -- upvalues: Weapons (copy), CombineConfig (copy)
    local CombineEvent = Weapons:FindFirstChild("CombineEvent");

    if CombineEvent then
        CombineEvent = CombineEvent:GetAttribute("Fusion");
    end;

    if type(CombineConfig.Fusion) == "table" and CombineEvent == CombineConfig.Fusion.Output then
        return CombineEvent;
    end;

    return nil;
end;

local Font_new_ret = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.ExtraBold);
local Color3_fromRGB_ret = Color3.fromRGB(23, 23, 25);
local Color3_fromRGB_ret2 = Color3.fromRGB(76, 76, 81);
local Color3_new_ret = Color3.new(1, 1, 1);
local Color3_fromRGB_ret3 = Color3.fromRGB(222, 222, 222);
local Color3_fromRGB_ret4 = Color3.fromRGB(255, 202, 58);
local Color3_fromRGB_ret5 = Color3.fromRGB(55, 55, 60);
local Color3_fromRGB_ret6 = Color3.fromRGB(253, 60, 85);
local u4 = {
    green = {
        Color3.fromRGB(80, 255, 100),
        Color3.fromRGB(17, 213, 40),
        Color3.fromRGB(80, 255, 100),
        0.2
    },
    idle = {
        Color3.fromRGB(158, 158, 158),
        Color3.fromRGB(136, 136, 136),
        Color3.fromRGB(189, 189, 189),
        0
    },
    grey = {
        Color3.fromRGB(125, 125, 125),
        Color3.fromRGB(80, 80, 80),
        Color3.fromRGB(110, 110, 110),
        0
    },
    [2] = {
        Color3.fromRGB(128, 205, 255),
        Color3.fromRGB(44, 128, 214),
        Color3.fromRGB(92, 173, 238),
        0.1
    },
    [3] = {
        Color3.fromRGB(199, 155, 255),
        Color3.fromRGB(143, 79, 216),
        Color3.fromRGB(183, 123, 244),
        0.1
    },
    [4] = {
        Color3.fromRGB(255, 215, 106),
        Color3.fromRGB(230, 161, 0),
        Color3.fromRGB(242, 191, 89),
        0.1
    }
};
local u5 = {
    NotEnough = "You don\'t have enough copies for that yet.",
    InMatch = "Combine knives in the lobby.",
    Busy = "Still working on your last combine.",
    Loading = "Your knives are still loading.",
    Unavailable = "That can\'t be combined right now.",
    AlreadyMade = "You\'ve already forged your Ultimate Void Blades.",
    QuoteChanged = "Your knives changed. Try again.",
    QuoteExpired = "That took too long. Try again.",
    Failed = "That didn\'t save, and nothing was used. Try again.",
    Full = "You can\'t hold any more of that knife."
};
u1.UNAVAILABLE = "This feature is currently not available.";

local function make(p6, p7, p8, p9) -- Line: 104
    local Instance_new_ret = Instance.new(p6);
    Instance_new_ret.Name = p8;

    for i, v in p9 or {} do
        Instance_new_ret[i] = v;
    end;

    Instance_new_ret.Parent = p7;

    return Instance_new_ret;
end;

local function corner(p10, p11) -- Line: 113
    local v12 = {
        CornerRadius = UDim.new(p11, 0)
    };
    local UICorner = Instance.new("UICorner");
    UICorner.Name = "UICorner";

    for i, v in v12 or {} do
        UICorner[i] = v;
    end;

    UICorner.Parent = p10;
end;

local function rings(p13, p14, p15, p16) -- Line: 119
    -- upvalues: Color3_fromRGB_ret2 (copy)
    local v17 = {
        ZIndex = 1,
        Color = Color3.new(0, 0, 0),
        Thickness = p15,
        LineJoinMode = Enum.LineJoinMode.Round,
        StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize
    };
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Name = "Outline";

    for i, v in v17 or {} do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = p13;
    local v18 = {
        ZIndex = 2,
        Color = p14 or Color3_fromRGB_ret2,
        Thickness = p16,
        LineJoinMode = Enum.LineJoinMode.Round,
        StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize
    };
    local UIStroke2 = Instance.new("UIStroke");
    UIStroke2.Name = "Ring";

    for i, v in v18 or {} do
        UIStroke2[i] = v;
    end;

    UIStroke2.Parent = p13;

    return UIStroke2, UIStroke;
end;

local function label(p19, p20, p21, p22, p23) -- Line: 137
    -- upvalues: Font_new_ret (copy), Color3_new_ret (copy)
    local v24 = {
        BackgroundTransparency = 1,
        TextScaled = true,
        TextWrapped = true,
        FontFace = Font_new_ret,
        Text = p21,
        TextColor3 = Color3_new_ret
    };
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Name = p20;

    for i, v in v24 or {} do
        TextLabel[i] = v;
    end;

    TextLabel.Parent = p19;

    for i, v in p22 or {} do
        TextLabel[i] = v;
    end;

    local v25 = {
        Color = Color3.new(0, 0, 0),
        Thickness = p23 or 0.1,
        LineJoinMode = Enum.LineJoinMode.Round,
        StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize
    };
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Name = "UIStroke";

    for i, v in v25 or {} do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = TextLabel;

    return TextLabel;
end;

local function gradient(p26, p27, p28, p29) -- Line: 157
    local v30 = {
        Rotation = 90,
        Color = ColorSequence.new(p27, p28),
        Transparency = NumberSequence.new(p29 or 0)
    };
    local UIGradient = Instance.new("UIGradient");
    UIGradient.Name = "UIGradient";

    for i, v in v30 or {} do
        UIGradient[i] = v;
    end;

    UIGradient.Parent = p26;

    return UIGradient;
end;

local function showcase(p31, p32) -- Line: 165
    -- upvalues: Color3_new_ret (copy), Color3_fromRGB_ret (copy)
    p31.BackgroundColor3 = Color3_new_ret;
    p31.BackgroundTransparency = 0;
    local Fill = p31:FindFirstChild("Fill");

    if not Fill then
        Fill = Instance.new("UIGradient");
        Fill.Name = "Fill";

        for i, v in {
            Rotation = 90
        } or {} do
            Fill[i] = v;
        end;

        Fill.Parent = p31;
    end;

    Fill.Color = ColorSequence.new(Color3_fromRGB_ret, p32);
    Fill.Transparency = NumberSequence.new(0.2, 0.6);
    local Ring = p31:FindFirstChild("Ring");

    if Ring then
        Ring.Color = p32;
    end;
end;

local function plain(p33) -- Line: 177
    -- upvalues: Color3_fromRGB_ret (copy), Color3_fromRGB_ret2 (copy)
    p33.BackgroundColor3 = Color3_fromRGB_ret;
    p33.BackgroundTransparency = 0.1;
    local Fill = p33:FindFirstChild("Fill");

    if Fill then
        Fill:Destroy();
    end;

    local Ring = p33:FindFirstChild("Ring");

    if Ring then
        Ring.Color = Color3_fromRGB_ret2;
    end;
end;

local function setLook(p34, p35) -- Line: 191
    -- upvalues: u4 (copy), Color3_fromRGB_ret (copy), Color3_fromRGB_ret2 (copy), Color3_new_ret (copy)
    local v36 = u4[p35];
    local UIGradient = p34:FindFirstChild("UIGradient");
    local Texture = p34:FindFirstChild("Texture");
    local Ring = p34:FindFirstChild("Ring");
    local TextLabel = p34:FindFirstChild("TextLabel");

    if p35 == "dark" then
        p34.BackgroundColor3 = Color3_fromRGB_ret;
        p34.BackgroundTransparency = 0.2;
        UIGradient.Enabled = false;
        Texture.Visible = false;
        Ring.Color = Color3_fromRGB_ret2;
    else
        p34.BackgroundColor3 = Color3_new_ret;
        p34.BackgroundTransparency = 0;
        UIGradient.Enabled = true;
        UIGradient.Color = ColorSequence.new(v36[1], v36[2]);
        UIGradient.Transparency = NumberSequence.new(v36[4]);
        local v37;

        if p35 == "idle" then
            v37 = false;
        else
            v37 = p35 ~= "grey";
        end;

        Texture.Visible = v37;
        Ring.Color = v36[3];
    end;

    local v38;

    if p35 == "grey" then
        v38 = Color3.fromRGB(165, 165, 165);
    else
        v38 = Color3_new_ret;
    end;

    TextLabel.TextColor3 = v38;
    p34:SetAttribute("Look", p35);
end;

local function button(p39, p40, p41, p42, p43) -- Line: 216
    -- upvalues: Color3_new_ret (copy), rings (copy), gradient (copy), label (copy), setLook (copy)
    local v44 = {
        AutoButtonColor = true,
        BorderSizePixel = 0,
        BackgroundColor3 = Color3_new_ret
    };
    local ImageButton = Instance.new("ImageButton");
    ImageButton.Name = p40;

    for i, v in v44 or {} do
        ImageButton[i] = v;
    end;

    ImageButton.Parent = p39;

    for i, v in p43 or {} do
        ImageButton[i] = v;
    end;

    local v45 = {
        CornerRadius = UDim.new(0.2, 0)
    };
    local UICorner = Instance.new("UICorner");
    UICorner.Name = "UICorner";

    for i, v in v45 or {} do
        UICorner[i] = v;
    end;

    UICorner.Parent = ImageButton;
    rings(ImageButton, nil, 0.05, 0.033);
    gradient(ImageButton, Color3_new_ret, Color3_new_ret, 0.2);
    local v46 = {
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(0.992, 0.933)
    };
    local CanvasGroup = Instance.new("CanvasGroup");
    CanvasGroup.Name = "Texture";

    for i, v in v46 or {} do
        CanvasGroup[i] = v;
    end;

    CanvasGroup.Parent = ImageButton;
    local v47 = {
        CornerRadius = UDim.new(0.17, 0)
    };
    local UICorner2 = Instance.new("UICorner");
    UICorner2.Name = "UICorner";

    for i, v in v47 or {} do
        UICorner2[i] = v;
    end;

    UICorner2.Parent = CanvasGroup;
    local v48 = {
        Rotation = 45,
        BackgroundTransparency = 1,
        Image = "rbxassetid://140022482252277",
        ImageTransparency = 0.8,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(0.87, 8),
        ScaleType = Enum.ScaleType.Tile,
        TileSize = UDim2.fromScale(0.35, 0.35)
    };
    local ImageLabel = Instance.new("ImageLabel");
    ImageLabel.Name = "ImageLabel";

    for i, v in v48 or {} do
        ImageLabel[i] = v;
    end;

    ImageLabel.Parent = CanvasGroup;
    local v49 = {
        Rotation = 90,
        Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.5, 1), NumberSequenceKeypoint.new(1, 0) })
    };
    local UIGradient = Instance.new("UIGradient");
    UIGradient.Name = "UIGradient";

    for i, v in v49 or {} do
        UIGradient[i] = v;
    end;

    UIGradient.Parent = ImageLabel;
    label(ImageButton, "TextLabel", p41, {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(0.8, 0.5),
        ZIndex = ImageButton.ZIndex
    }, 0.103);
    setLook(ImageButton, p42);

    return ImageButton;
end;

local function setEnabled(p50, p51, p52) -- Line: 263
    -- upvalues: setLook (copy)
    p50.Interactable = p51;
    p50.AutoButtonColor = p51;
    setLook(p50, not p51 and "grey" or p52);
end;

local CFrame_lookAt_ret = CFrame.lookAt(Vector3.new(0, 0, 0), Vector3.new(1, 1, 0.35));

local function iconPose(p53, p54) -- Line: 275
    -- upvalues: CFrame_lookAt_ret (copy)
    local Attribute = p54:GetAttribute("ThumbAxis");
    local Attribute2 = p54:GetAttribute("ThumbNormal");

    if typeof(Attribute) ~= "Vector3" or (typeof(Attribute2) ~= "Vector3" or Attribute.Magnitude <= 0.5) then
        local Size = p53.Size;

        if Size.Z >= Size.X and Size.Z >= Size.Y then
            return CFrame_lookAt_ret;
        end;

        if Size.X >= Size.Y then
            return CFrame_lookAt_ret * CFrame.Angles(0, 1.5707963267948966, 0);
        end;

        return CFrame_lookAt_ret * CFrame.Angles(-1.5707963267948966, 0, 0);
    end;

    local Unit = Attribute.Unit;
    local Unit2 = (Attribute2 - Unit * Attribute2:Dot(Unit)).Unit;
    local LookVector = CFrame_lookAt_ret.LookVector;
    local Unit3 = (Vector3.new(0, 0, 1) - LookVector * LookVector.Z).Unit;

    return CFrame.fromMatrix(Vector3.new(0, 0, 0), LookVector, Unit3, LookVector:Cross(Unit3)) * CFrame.fromMatrix(Vector3.new(0, 0, 0), Unit, Unit2, Unit:Cross(Unit2)):Inverse();
end;

local function knifeIcon(p55, p56, p57, p58) -- Line: 291
    -- upvalues: SkinCatalog (copy), CombineConfig (copy), Weapons (copy), Color3_new_ret (copy), KnifeIconCopy (copy), iconPose (copy)
    local v59 = SkinCatalog.get(p56);
    local v60 = CombineConfig.tierOf(p56);
    local Models = Weapons:FindFirstChild("Models");

    if Models then
        if v59 then
            local v61 = Models:FindFirstChild(v59.Model);

            if v61 then
                v60 = v61;
            elseif v60 then
                v60 = Models:FindFirstChild(CombineConfig.Families[v60].Tiers[1]);
            end;
        else
            v60 = v59;
        end;
    else
        v60 = Models;
    end;

    local v62;

    if v60 then
        v62 = v60:FindFirstChild("Blade") or v60:FindFirstChildWhichIsA("BasePart", true);
    else
        v62 = v60;
    end;

    local v63 = {
        BackgroundTransparency = 1,
        LightDirection = Vector3.new(-0.4, -0.8, -1),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(0.82, 0.82),
        Ambient = Color3.fromRGB(200, 200, 210),
        LightColor = Color3.fromRGB(255, 250, 235)
    };
    local v64;

    if p57 then
        v64 = Color3.fromRGB(10, 10, 14);
    else
        v64 = Color3_new_ret;
    end;

    v63.ImageColor3 = v64;
    v63.ImageTransparency = p57 and 0.1 or 0;
    v63.ZIndex = p58 or p55.ZIndex + 1;
    local ViewportFrame = Instance.new("ViewportFrame");
    ViewportFrame.Name = "Knife";

    for i, v in v63 or {} do
        ViewportFrame[i] = v;
    end;

    ViewportFrame.Parent = p55;

    if not v62 then
        return ViewportFrame;
    end;

    local WorldModel = Instance.new("WorldModel");
    WorldModel.Name = "World";

    for i, v in {} do
        WorldModel[i] = v;
    end;

    WorldModel.Parent = ViewportFrame;
    local v65, _, v66, v67 = KnifeIconCopy.new(v62);
    v65.Parent = WorldModel;
    local v68 = iconPose(v65, v60);
    v65.CFrame = CFrame.new(-v68:VectorToWorldSpace(v67)) * v68;
    local _, v69 = KnifeIconCopy.cross(WorldModel, v60, iconPose, Vector3.new(0, 1, 0), v65);

    if v69 then
        v65.CFrame = v65.CFrame - WorldModel:GetBoundingBox().Position;
    end;

    local X = v66.X;
    local Y = v66.Y;
    local Z = v66.Z;
    local v70 = v69 and math.max(v69.X, v69.Y, v69.Z) or 0;
    local math_max_ret = math.max(X, Y, Z, v70);
    local Camera = Instance.new("Camera");
    Camera.Name = "Camera";

    for i, v in {
        FieldOfView = 35
    } or {} do
        Camera[i] = v;
    end;

    Camera.Parent = ViewportFrame;
    Camera.CFrame = CFrame.lookAt(Vector3.new(0, 0, math_max_ret * 1.3), Vector3.new(0, 0, 0));
    ViewportFrame.CurrentCamera = Camera;

    return ViewportFrame;
end;

local function plural(p71, p72) -- Line: 334
    return p71 .. " " .. p72 .. (p71 == 1 and "" or "s");
end;

local function tierColor(p73) -- Line: 337
    -- upvalues: CombineConfig (copy)
    return CombineConfig.TierColors[math.clamp(p73, 1, #CombineConfig.TierColors)];
end;

local function tierLook(p74) -- Line: 340
    -- upvalues: u4 (copy)
    return u4[p74] and p74 and p74 or 4;
end;

local u75 = {
    equipped = nil,
    loaded = false,
    owned = {},
    stacks = {}
};

local function count(p76) -- Line: 348
    -- upvalues: u75 (ref)
    local v77 = u75.stacks[p76];

    if not v77 then
        if u75.owned[p76] == true then
            return 1;
        end;

        v77 = 0;
    end;

    return v77;
end;

local function timeLeft(p78) -- Line: 352
    local v79 = p78 // 86400;
    local v80 = p78 % 86400 // 3600;
    local v81 = p78 % 3600 // 60;

    if v79 > 0 then
        return ("%dd %dh"):format(v79, v80);
    end;

    if v80 > 0 then
        return ("%dh %dm"):format(v80, v81);
    end;

    return ("%dm"):format((math.max(v81, 1)));
end;

local function endsIn() -- Line: 362
    -- upvalues: CombineConfig (copy)
    if type(CombineConfig.EndsAt) ~= "number" then
        return "";
    end;

    local v82 = CombineConfig.EndsAt - workspace:GetServerTimeNow();

    if v82 <= 0 then
        return "Event over";
    end;

    local v83 = v82 // 86400;
    local v84 = v82 % 86400 // 3600;
    local v85 = v82 % 3600 // 60;
    local v86;

    if v83 > 0 then
        v86 = ("%dd %dh"):format(v83, v84);
    elseif v84 > 0 then
        v86 = ("%dh %dm"):format(v84, v85);
    else
        v86 = ("%dm"):format((math.max(v85, 1)));
    end;

    return "Ends in " .. v86;
end;

local function pathProgress(p87) -- Line: 371
    -- upvalues: u75 (ref)
    local v88 = 1;
    local v89 = 0;

    for i, v in p87.Tiers do
        v89 = v89 + (u75.stacks[v] or (u75.owned[v] == true and 1 or 0)) * v88;

        if i < #p87.Tiers then
            v88 = v88 * p87.Costs[i];
        end;
    end;

    return math.min(v89, v88), v88;
end;

local function forged() -- Line: 382
    -- upvalues: CombineConfig (copy), u75 (ref)
    local v90;

    if type(CombineConfig.Fusion) == "table" then
        local Output = CombineConfig.Fusion.Output;
        v90 = (u75.stacks[Output] or (u75.owned[Output] == true and 1 or 0)) > 0;
    else
        v90 = false;
    end;

    return v90;
end;

local function pathDone(p91) -- Line: 387
    -- upvalues: u75 (ref), CombineConfig (copy)
    local v92 = p91.Tiers[#p91.Tiers];
    local v93;

    if (u75.stacks[v92] or (u75.owned[v92] == true and 1 or 0)) > 0 then
        v93 = true;
    elseif type(CombineConfig.Fusion) == "table" then
        local Output = CombineConfig.Fusion.Output;
        v93 = (u75.stacks[Output] or (u75.owned[Output] == true and 1 or 0)) > 0;
    else
        v93 = false;
    end;

    return v93;
end;

local function nextStep(p94, p95) -- Line: 394
    -- upvalues: CombineConfig (copy), u75 (ref)
    local v96;

    if p95 == nil or type(CombineConfig.Fusion) ~= "table" then
        v96 = false;
    else
        local Output = CombineConfig.Fusion.Output;
        v96 = (u75.stacks[Output] or (u75.owned[Output] == true and 1 or 0)) > 0;
    end;

    if p95 and not v96 then
        local v97 = true;

        for _, v in CombineConfig.Fusion.Inputs do
            if v97 then
                v97 = (u75.stacks[v] or (u75.owned[v] == true and 1 or 0)) > 0;
            end;
        end;

        if v97 then
            return {
                kind = "Fuse",
                title = "FUSE THE ULTIMATE!",
                note = "Both Duals are ready. Fuse them now!",
                output = p95,
                skin = p95
            };
        end;
    end;

    for i = 3, 1, -1 do
        local v98 = i;

        for _, v in p94 do
            local v99 = CombineConfig.Families[v];
            local v100 = v99.Costs[v98];

            if v98 < #v99.Tiers and v100 then
                local v101 = v99.Tiers[v98];

                if v100 <= (u75.stacks[v101] or (u75.owned[v101] == true and 1 or 0)) then
                    local v102;

                    if v96 then
                        v102 = v99.Tiers[v98 + 1];

                        return {
                            kind = "Combine",
                            title = "READY TO COMBINE!",
                            output = v102,
                            skin = v102,
                            note = ("Merge %d into 1 %s!"):format(v100, v99.Names[v98 + 1])
                        };
                    end;

                    local v103 = v99.Tiers[#v99.Tiers];
                    local v104;

                    if (u75.stacks[v103] or (u75.owned[v103] == true and 1 or 0)) > 0 then
                        v104 = true;
                    elseif type(CombineConfig.Fusion) == "table" then
                        local Output = CombineConfig.Fusion.Output;
                        v104 = (u75.stacks[Output] or (u75.owned[Output] == true and 1 or 0)) > 0;
                    else
                        v104 = false;
                    end;

                    if not v104 then
                        v102 = v99.Tiers[v98 + 1];

                        return {
                            kind = "Combine",
                            title = "READY TO COMBINE!",
                            output = v102,
                            skin = v102,
                            note = ("Merge %d into 1 %s!"):format(v100, v99.Names[v98 + 1])
                        };
                    end;
                end;
            end;
        end;
    end;

    if v96 then
        if u75.equipped ~= p95 then
            return {
                kind = "Done",
                title = "ULTIMATE FORGED!",
                note = "Only 1 per player, and it\'s yours!",
                skin = p95
            };
        end;

        local v105 = {};

        for _, v in p94 do
            local v106 = CombineConfig.Families[v];

            if v106.Wheel then
                table.insert(v105, v106.Names[1] .. "s");
            end;
        end;

        return {
            kind = "Spin",
            skin = "Wheel",
            title = "KEEP COLLECTING!",
            note = #v105 <= 0 and "Merge your knives up." or ("Spin for more %s and merge them up."):format(table.concat(v105, " and "))
        };
    end;

    local v107 = false;
    local v108 = {};
    local v109 = nil;

    for _, v in p94 do
        local v110 = CombineConfig.Families[v];
        local v111 = v;

        for _, v2 in v110.Tiers do
            v107 = v107 or (u75.stacks[v2] or (u75.owned[v2] == true and 1 or 0)) > 0;
        end;

        if v110.Wheel then
            table.insert(v108, v110.Names[1]);
        end;

        local v112 = v110.Tiers[#v110.Tiers];
        local v113;

        if (u75.stacks[v112] or (u75.owned[v112] == true and 1 or 0)) > 0 then
            v113 = true;
        elseif type(CombineConfig.Fusion) == "table" then
            local Output = CombineConfig.Fusion.Output;
            v113 = (u75.stacks[Output] or (u75.owned[Output] == true and 1 or 0)) > 0;
        else
            v113 = false;
        end;

        if not v113 then
            local v114 = v110.Tiers[1];
            local v115 = u75.stacks[v114] or (u75.owned[v114] == true and 1 or 0);
            local v116 = v110.Costs[1] - v115;

            if not v109 or v116 < v109.need then
                v109 = {
                    need = v116,
                    have = v115,
                    name = v110.Names[1],
                    familyId = v111
                };
            end;
        end;
    end;

    local v117 = "SPIN THE WHEEL";

    if v109 and not v107 then
        v117 = "NEXT: SPIN FOR " .. string.upper(table.concat(v108, " OR "));
    elseif v109 then
        local need = v109.need;
        v117 = ("NEXT: GET %s"):format(string.upper(need .. " " .. ((v109.have > 0 and "more " or "") .. v109.name) .. (need == 1 and "" or "s")));
    end;

    if v107 then
        v107 = v109 ~= nil;
    end;

    local v118 = {
        kind = "Spin",
        skin = "Wheel"
    };
    local v119;

    if v107 then
        v119 = v109.familyId;
    else
        v119 = nil;
    end;

    v118.familyId = v119;
    v118.title = v117;
    v118.note = not v107 and "Each has a 3% chance every Spin Wheel spin." or ("%s: 3%% chance every Spin Wheel spin."):format(v109.name);

    return v118;
end;

local u120 = {};

local function tell(p121, p122) -- Line: 497
    -- upvalues: u120 (copy)
    for _, v in u120 do
        task.spawn(v, p121, p122);
    end;
end;

function u1.listen(p123) -- Line: 502
    -- upvalues: u120 (copy)
    table.insert(u120, p123);
end;

function u1.floating(p124) -- Line: 510
    -- upvalues: openFamilies (copy), Weapons (copy), CombineConfig (copy), nextStep (copy), u75 (ref)
    local v125 = openFamilies();
    local CombineEvent = Weapons:FindFirstChild("CombineEvent");

    if CombineEvent then
        CombineEvent = CombineEvent:GetAttribute("Fusion");
    end;

    if type(CombineConfig.Fusion) ~= "table" or CombineEvent ~= CombineConfig.Fusion.Output then
        CombineEvent = nil;
    end;

    local v126 = nextStep(v125, CombineEvent);

    if v126.kind == "Fuse" then
        return table.move(CombineConfig.Fusion.Inputs, 1, math.min(p124, #CombineConfig.Fusion.Inputs), 1, {}), v126.output;
    end;

    if v126.kind == "Combine" then
        local v127, v128 = CombineConfig.tierOf(v126.output);
        local v129 = CombineConfig.Families[v127];

        return table.create(math.min(v129.Costs[v128 - 1], p124), v129.Tiers[v128 - 1]), v126.output;
    end;

    if v126.familyId and table.find(v125, v126.familyId) then
        table.remove(v125, table.find(v125, v126.familyId));
        table.insert(v125, 1, v126.familyId);
    end;

    for _, v in v125 do
        local v130 = CombineConfig.Families[v];
        local v131 = {};

        for i = 1, #v130.Tiers - 1 do
            local v132 = v130.Tiers[i];
            local v133 = i;

            for i2 = 1, math.min(u75.stacks[v132] or (u75.owned[v132] == true and 1 or 0), p124 - #v131) do
                table.insert(v131, v130.Tiers[v133]);
                local _ = i2;
            end;
        end;

        if #v131 > 0 then
            local _, v134 = CombineConfig.tierOf(v131[1]);

            return v131, v130.Tiers[v134 + 1];
        end;
    end;

    if CombineEvent then
        local v135;

        if type(CombineConfig.Fusion) == "table" then
            local Output = CombineConfig.Fusion.Output;
            v135 = (u75.stacks[Output] or (u75.owned[Output] == true and 1 or 0)) > 0;
        else
            v135 = false;
        end;

        if not v135 then
            local v136 = {};

            for _, v in CombineConfig.Fusion.Inputs do
                if (u75.stacks[v] or (u75.owned[v] == true and 1 or 0)) > 0 and #v136 < p124 then
                    table.insert(v136, v);
                end;
            end;

            if #v136 > 0 then
                return v136, CombineEvent;
            end;
        end;
    end;

    return {}, nil;
end;

function u1.new() -- Line: 557
    -- upvalues: u1 (copy), Color3_fromRGB_ret (copy), rings (copy), Color3_fromRGB_ret2 (copy), label (copy), CombineConfig (copy), Color3_fromRGB_ret3 (copy), Color3_fromRGB_ret4 (copy), Color3_fromRGB_ret6 (copy), button (copy), Color3_fromRGB_ret5 (copy), Color3_new_ret (copy), gradient (copy), u4 (copy)
    local v137 = setmetatable({
        lanes = {},
        links = {},
        bannerIcons = {}
    }, u1);
    local v138 = {
        BackgroundTransparency = 0.08,
        Visible = false,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(0.599, 0.654),
        BackgroundColor3 = Color3_fromRGB_ret
    };
    local Frame = Instance.new("Frame");
    Frame.Name = "Combine";

    for i, v in v138 or {} do
        Frame[i] = v;
    end;

    Frame.Parent = nil;
    Frame:SetAttribute("SelfManagedText", true);
    local v139 = {
        CornerRadius = UDim.new(0.021, 0)
    };
    local UICorner = Instance.new("UICorner");
    UICorner.Name = "UICorner";

    for i, v in v139 or {} do
        UICorner[i] = v;
    end;

    UICorner.Parent = Frame;
    rings(Frame, nil, 0.00425, 0.00283);
    local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint");
    UIAspectRatioConstraint.Name = "FixedAspectRatio";

    for i, v in {
        AspectRatio = 1.63
    } or {} do
        UIAspectRatioConstraint[i] = v;
    end;

    UIAspectRatioConstraint.Parent = Frame;
    local UIScale = Instance.new("UIScale");
    UIScale.Name = "Pop";

    for i, v in {} do
        UIScale[i] = v;
    end;

    UIScale.Parent = Frame;
    v137.pop = UIScale;
    local v140 = {
        BackgroundTransparency = 0.5,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.0637),
        Size = UDim2.fromScale(0.998, 0.126),
        BackgroundColor3 = Color3.new(0, 0, 0)
    };
    local Frame2 = Instance.new("Frame");
    Frame2.Name = "Header";

    for i, v in v140 or {} do
        Frame2[i] = v;
    end;

    Frame2.Parent = Frame;
    local v141 = {
        CornerRadius = UDim.new(0.157, 0)
    };
    local UICorner2 = Instance.new("UICorner");
    UICorner2.Name = "UICorner";

    for i, v in v141 or {} do
        UICorner2[i] = v;
    end;

    UICorner2.Parent = Frame2;
    local v142 = {
        Thickness = 0.0112,
        Color = Color3_fromRGB_ret2,
        LineJoinMode = Enum.LineJoinMode.Round,
        StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize
    };
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Name = "UIStroke";

    for i, v in v142 or {} do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = Frame2;
    local v143 = {
        BackgroundTransparency = 1,
        Image = "rbxassetid://111671278699403",
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.0375, 0.506),
        Size = UDim2.fromScale(0.054, 0.73),
        ScaleType = Enum.ScaleType.Fit
    };
    local ImageLabel = Instance.new("ImageLabel");
    ImageLabel.Name = "Icon";

    for i, v in v143 or {} do
        ImageLabel[i] = v;
    end;

    ImageLabel.Parent = Frame2;
    local v144 = {
        BackgroundTransparency = 1,
        ZIndex = 2,
        AnchorPoint = Vector2.new(0, 0.5),
        Position = UDim2.fromScale(0.0725, 0.506),
        Size = UDim2.fromScale(0.5, 0.764)
    };
    local Frame3 = Instance.new("Frame");
    Frame3.Name = "Title";

    for i, v in v144 or {} do
        Frame3[i] = v;
    end;

    Frame3.Parent = Frame2;
    local v145 = {
        SortOrder = Enum.SortOrder.LayoutOrder
    };
    local UIListLayout = Instance.new("UIListLayout");
    UIListLayout.Name = "UIListLayout";

    for i, v in v145 or {} do
        UIListLayout[i] = v;
    end;

    UIListLayout.Parent = Frame3;
    label(Frame3, "Title", (CombineConfig.EventName or "Combine") .. " Event", {
        LayoutOrder = 1,
        Size = UDim2.fromScale(1, 0.647),
        TextXAlignment = Enum.TextXAlignment.Left
    }, 0.0682);
    label(Frame3, "Info", "Spin the wheel · Merge 5 into 1 · Forge the Ultimate!", {
        LayoutOrder = 2,
        Size = UDim2.fromScale(1, 0.353),
        TextColor3 = Color3_fromRGB_ret3,
        TextXAlignment = Enum.TextXAlignment.Left
    }, 0.125);
    v137.timerText = label(Frame2, "EndsIn", "", {
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.fromScale(0.92, 0.506),
        Size = UDim2.fromScale(0.26, 0.42),
        TextColor3 = Color3_fromRGB_ret4,
        TextXAlignment = Enum.TextXAlignment.Right
    }, 0.1);
    local v146 = {
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.961, 0.506),
        Size = UDim2.fromScale(0.0531, 0.685)
    };
    local ImageButton = Instance.new("ImageButton");
    ImageButton.Name = "CloseButton";

    for i, v in v146 or {} do
        ImageButton[i] = v;
    end;

    ImageButton.Parent = Frame2;
    label(ImageButton, "TextLabel", "x", {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.508, 0.41),
        Size = UDim2.fromScale(0.656, 1.28),
        TextColor3 = Color3_fromRGB_ret6
    }, 0.0385);
    v137.frame = Frame;
    v137.closeButton = ImageButton;
    local v147 = {
        Position = UDim2.fromScale(0.015, 0.145),
        Size = UDim2.fromScale(0.97, 0.135)
    };
    local Frame4 = Instance.new("Frame");
    Frame4.Name = "NextStep";

    for i, v in v147 or {} do
        Frame4[i] = v;
    end;

    Frame4.Parent = Frame;
    local v148 = {
        CornerRadius = UDim.new(0.16, 0)
    };
    local UICorner3 = Instance.new("UICorner");
    UICorner3.Name = "UICorner";

    for i, v in v148 or {} do
        UICorner3[i] = v;
    end;

    UICorner3.Parent = Frame4;
    rings(Frame4, Color3_fromRGB_ret2, 0.012, 0.018);
    Frame4.BackgroundColor3 = Color3_fromRGB_ret;
    Frame4.BackgroundTransparency = 0.1;
    local Fill = Frame4:FindFirstChild("Fill");

    if Fill then
        Fill:Destroy();
    end;

    local Ring = Frame4:FindFirstChild("Ring");

    if Ring then
        Ring.Color = Color3_fromRGB_ret2;
    end;

    local v149 = {
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(0, 0.5),
        Position = UDim2.fromScale(0.012, 0.5),
        Size = UDim2.fromScale(0.9, 0.9),
        SizeConstraint = Enum.SizeConstraint.RelativeYY
    };
    local Frame5 = Instance.new("Frame");
    Frame5.Name = "Icon";

    for i, v in v149 or {} do
        Frame5[i] = v;
    end;

    Frame5.Parent = Frame4;
    local v150 = {
        BackgroundTransparency = 1,
        Image = "rbxassetid://129028976496842",
        ImageTransparency = 0.5,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(1.3, 1.3),
        ImageColor3 = Color3_fromRGB_ret4
    };
    local ImageLabel2 = Instance.new("ImageLabel");
    ImageLabel2.Name = "Glow";

    for i, v in v150 or {} do
        ImageLabel2[i] = v;
    end;

    ImageLabel2.Parent = Frame5;
    v137.bannerGlow = ImageLabel2;
    v137.bannerIcon = Frame5;
    v137.bannerTitle = label(Frame4, "Title", "", {
        Position = UDim2.fromScale(0.1, 0.1),
        Size = UDim2.fromScale(0.58, 0.46),
        TextXAlignment = Enum.TextXAlignment.Left
    }, 0.08);
    v137.bannerNote = label(Frame4, "Note", "", {
        Position = UDim2.fromScale(0.1, 0.58),
        Size = UDim2.fromScale(0.58, 0.3),
        TextColor3 = Color3_fromRGB_ret3,
        TextXAlignment = Enum.TextXAlignment.Left
    }, 0.12);
    v137.cta = button(Frame4, "Action", "SPIN THE WHEEL", 4, {
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.fromScale(0.985, 0.5),
        Size = UDim2.fromScale(0.27, 0.72)
    });
    v137.banner = Frame4;
    local v151 = {
        BackgroundTransparency = 1,
        Position = UDim2.fromScale(0.015, 0.3),
        Size = UDim2.fromScale(0.97, 0.56)
    };
    local Frame6 = Instance.new("Frame");
    Frame6.Name = "Roadmap";

    for i, v in v151 or {} do
        Frame6[i] = v;
    end;

    Frame6.Parent = Frame;
    v137.road = Frame6;
    v137.ultimate = v137:ultimateCard(v137.road);
    local v152 = {
        BackgroundTransparency = 1,
        Position = UDim2.fromScale(0.015, 0.88),
        Size = UDim2.fromScale(0.97, 0.085)
    };
    local Frame7 = Instance.new("Frame");
    Frame7.Name = "Progress";

    for i, v in v152 or {} do
        Frame7[i] = v;
    end;

    Frame7.Parent = Frame;
    label(Frame7, "Label", "ULTIMATE PROGRESS", {
        Position = UDim2.fromScale(0, 0.15),
        Size = UDim2.fromScale(0.22, 0.7),
        TextColor3 = Color3_fromRGB_ret4,
        TextXAlignment = Enum.TextXAlignment.Left
    }, 0.1);
    local v153 = {
        AnchorPoint = Vector2.new(0, 0.5),
        Position = UDim2.fromScale(0.235, 0.5),
        Size = UDim2.fromScale(0.64, 0.34),
        BackgroundColor3 = Color3_fromRGB_ret5
    };
    local Frame8 = Instance.new("Frame");
    Frame8.Name = "Track";

    for i, v in v153 or {} do
        Frame8[i] = v;
    end;

    Frame8.Parent = Frame7;
    local v154 = {
        CornerRadius = UDim.new(1, 0)
    };
    local UICorner4 = Instance.new("UICorner");
    UICorner4.Name = "UICorner";

    for i, v in v154 or {} do
        UICorner4[i] = v;
    end;

    UICorner4.Parent = Frame8;
    local v155 = {
        Size = UDim2.fromScale(0, 1),
        BackgroundColor3 = Color3_new_ret
    };
    local Frame9 = Instance.new("Frame");
    Frame9.Name = "Fill";

    for i, v in v155 or {} do
        Frame9[i] = v;
    end;

    Frame9.Parent = Frame8;
    v137.progressFill = Frame9;
    local progressFill = v137.progressFill;
    local v156 = {
        CornerRadius = UDim.new(1, 0)
    };
    local UICorner5 = Instance.new("UICorner");
    UICorner5.Name = "UICorner";

    for i, v in v156 or {} do
        UICorner5[i] = v;
    end;

    UICorner5.Parent = progressFill;
    gradient(v137.progressFill, u4[4][1], u4[4][2], 0.1);
    v137.progressText = label(Frame7, "Percent", "", {
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.fromScale(1, 0.5),
        Size = UDim2.fromScale(0.11, 0.7),
        TextXAlignment = Enum.TextXAlignment.Right
    }, 0.1);
    v137.footer = Frame7;
    v137.placeholder = label(Frame, "Placeholder", "Not available yet", {
        Visible = false,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.45),
        Size = UDim2.fromScale(0.6, 0.09)
    }, 0.1);
    v137.placeholderNote = label(Frame, "PlaceholderNote", "No knives can be combined right now. Check back soon!", {
        Visible = false,
        AnchorPoint = Vector2.new(0.5, 0),
        Position = UDim2.fromScale(0.5, 0.52),
        Size = UDim2.fromScale(0.6, 0.07),
        TextColor3 = Color3_fromRGB_ret3
    }, 0.12);

    return v137;
end;

local function arrow(p157, p158, p159, p160, p161) -- Line: 738
    -- upvalues: label (copy)
    local Frame = Instance.new("Frame");
    Frame.Name = p158;

    for i, v in {
        BackgroundTransparency = 1,
        Position = p159,
        Size = p160
    } or {} do
        Frame[i] = v;
    end;

    Frame.Parent = p157;
    local v162 = {
        BorderSizePixel = 0,
        AnchorPoint = Vector2.new(0, 0.5),
        Position = UDim2.fromScale(0.1, 0.55),
        Size = UDim2.fromScale(0.62, 0.035)
    };
    local Frame2 = Instance.new("Frame");
    Frame2.Name = "Line";

    for i, v in v162 or {} do
        Frame2[i] = v;
    end;

    Frame2.Parent = Frame;
    local v163 = {
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.fromScale(0.92, 0.55),
        Size = UDim2.fromScale(0.5, 0.3),
        SizeConstraint = Enum.SizeConstraint.RelativeXX
    };
    local Frame3 = Instance.new("Frame");
    Frame3.Name = "Head";

    for i, v in v163 or {} do
        Frame3[i] = v;
    end;

    Frame3.Parent = Frame;
    local v164 = { Frame2 };

    for _, v in { -1, 1 } do
        local v165 = {
            BorderSizePixel = 0,
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromScale(0.7701866670643066, 0.5 + v * 0.3 * 0.6427876096865393),
            Size = UDim2.fromScale(0.6, 0.14),
            Rotation = -v * 40
        };
        local Frame4 = Instance.new("Frame");
        Frame4.Name = "Arm";

        for i, v2 in v165 or {} do
            Frame4[i] = v2;
        end;

        Frame4.Parent = Frame3;
        local v166 = {
            CornerRadius = UDim.new(1, 0)
        };
        local UICorner = Instance.new("UICorner");
        UICorner.Name = "UICorner";

        for i, v2 in v166 or {} do
            UICorner[i] = v2;
        end;

        UICorner.Parent = Frame4;
        table.insert(v164, Frame4);
    end;

    return {
        parts = v164,
        cost = label(Frame, "Cost", p161, {
            AnchorPoint = Vector2.new(0.5, 1),
            Position = UDim2.fromScale(0.5, 0.47),
            Size = UDim2.fromScale(1, 0.16)
        }, 0.12)
    };
end;

local function light(p167, p168) -- Line: 772
    -- upvalues: Color3_fromRGB_ret2 (copy), Color3_fromRGB_ret3 (copy)
    for _, v in p167.parts do
        v.BackgroundColor3 = p168;
    end;

    if p168 == Color3_fromRGB_ret2 then
        p168 = Color3_fromRGB_ret3;
    end;

    p167.cost.TextColor3 = p168;
end;

function u1.ultimateCard(u169, p170) -- Line: 780
    -- upvalues: CombineConfig (copy), rings (copy), showcase (copy), label (copy), knifeIcon (copy), Color3_fromRGB_ret3 (copy), button (copy)
    local Fusion = CombineConfig.Fusion;
    local v171 = CombineConfig.TierColors[math.clamp(#CombineConfig.TierNames, 1, #CombineConfig.TierColors)];
    local v172 = {
        Visible = false,
        Position = UDim2.fromScale(0.765, 0),
        Size = UDim2.fromScale(0.235, 1)
    };
    local Frame = Instance.new("Frame");
    Frame.Name = "Ultimate";

    for i, v in v172 or {} do
        Frame[i] = v;
    end;

    Frame.Parent = p170;
    local v173 = {
        CornerRadius = UDim.new(0.06, 0)
    };
    local UICorner = Instance.new("UICorner");
    UICorner.Name = "UICorner";

    for i, v in v173 or {} do
        UICorner[i] = v;
    end;

    UICorner.Parent = Frame;
    rings(Frame, v171, 0.012, 0.018);
    showcase(Frame, v171);
    label(Frame, "TierName", CombineConfig.TierNames[#CombineConfig.TierNames] or "", {
        AnchorPoint = Vector2.new(0.5, 0),
        Position = UDim2.fromScale(0.5, 0.03),
        Size = UDim2.fromScale(0.86, 0.07),
        TextColor3 = v171
    }, 0.1);
    local v174 = {
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.31),
        Size = UDim2.fromScale(0.82, 0.4)
    };
    local Frame2 = Instance.new("Frame");
    Frame2.Name = "Icon";

    for i, v in v174 or {} do
        Frame2[i] = v;
    end;

    Frame2.Parent = Frame;
    local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint");
    UIAspectRatioConstraint.Name = "Square";

    for i, v in {
        AspectRatio = 1
    } or {} do
        UIAspectRatioConstraint[i] = v;
    end;

    UIAspectRatioConstraint.Parent = Frame2;
    local v175 = {
        BackgroundTransparency = 1,
        Image = "rbxassetid://129028976496842",
        ImageTransparency = 0.35,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(1.35, 1.35),
        ImageColor3 = v171
    };
    local ImageLabel = Instance.new("ImageLabel");
    ImageLabel.Name = "Glow";

    for i, v in v175 or {} do
        ImageLabel[i] = v;
    end;

    ImageLabel.Parent = Frame2;
    local u176 = {
        root = Frame,
        glow = ImageLabel
    };

    if type(Fusion) ~= "table" then
        return u176;
    end;

    u176.icon = knifeIcon(Frame2, Fusion.Output);
    label(Frame, "NameText", Fusion.Name, {
        AnchorPoint = Vector2.new(0.5, 0),
        Position = UDim2.fromScale(0.5, 0.53),
        Size = UDim2.fromScale(0.9, 0.12)
    }, 0.09);
    label(Frame, "Perks", "ONLY 1 PER PLAYER", {
        AnchorPoint = Vector2.new(0.5, 0),
        Position = UDim2.fromScale(0.5, 0.66),
        Size = UDim2.fromScale(0.9, 0.14),
        TextColor3 = v171
    }, 0.1);
    u176.status = label(Frame, "Status", "", {
        AnchorPoint = Vector2.new(0.5, 0),
        Position = UDim2.fromScale(0.5, 0.83),
        Size = UDim2.fromScale(0.9, 0.12),
        TextColor3 = Color3_fromRGB_ret3
    }, 0.1);
    local UIScale = Instance.new("UIScale");
    UIScale.Name = "Pulse";

    for i, v in {} do
        UIScale[i] = v;
    end;

    UIScale.Parent = Frame;
    u176.pulse = UIScale;
    u176.fuse = button(Frame, "Fuse", "FUSE", 4, {
        Visible = false,
        AnchorPoint = Vector2.new(0.5, 0),
        Position = UDim2.fromScale(0.5, 0.825),
        Size = UDim2.fromScale(0.86, 0.14)
    });
    u176.fuse.TextLabel.Size = UDim2.fromScale(0.86, 0.7);
    u176.fuse.Activated:Connect(function() -- Line: 846
        -- upvalues: u176 (copy), u169 (copy), Fusion (copy)
        if u176.fuse.Interactable then
            u169:send("Combine", Fusion.Output);
        end;
    end);

    return u176;
end;

function u1.lane(u177, p178, p179, p180) -- Line: 856
    -- upvalues: CombineConfig (copy), rings (copy), Color3_fromRGB_ret2 (copy), Color3_fromRGB_ret (copy), label (copy), knifeIcon (copy), Color3_fromRGB_ret4 (copy), Color3_fromRGB_ret5 (copy), Color3_new_ret (copy), gradient (copy), u4 (copy), button (copy), arrow (copy)
    local v181 = CombineConfig.Families[p178];
    local v182 = #v181.Tiers;
    local v183 = (1 - (v182 - 1) * 0.085) / v182;
    local road = u177.road;
    local v184 = {
        BackgroundTransparency = 1,
        Position = UDim2.fromScale(0, p179),
        Size = UDim2.fromScale(0.735, p180)
    };
    local Frame = Instance.new("Frame");
    Frame.Name = p178;

    for i, v in v184 or {} do
        Frame[i] = v;
    end;

    Frame.Parent = road;
    local v185 = {
        root = Frame,
        cards = {},
        arrows = {}
    };

    for i, v in v181.Tiers do
        local v186 = (i - 1) * (v183 + 0.085);
        local v187 = {
            Position = UDim2.fromScale(v186, 0),
            Size = UDim2.fromScale(v183, 1)
        };
        local Frame2 = Instance.new("Frame");
        Frame2.Name = "Tier" .. i;
        local v188 = i;

        for i2, v2 in v187 or {} do
            Frame2[i2] = v2;
        end;

        Frame2.Parent = Frame;
        local v189 = {
            CornerRadius = UDim.new(0.1, 0)
        };
        local UICorner = Instance.new("UICorner");
        UICorner.Name = "UICorner";

        for i2, v2 in v189 or {} do
            UICorner[i2] = v2;
        end;

        UICorner.Parent = Frame2;
        rings(Frame2, Color3_fromRGB_ret2, 0.018, 0.026);
        Frame2.BackgroundColor3 = Color3_fromRGB_ret;
        Frame2.BackgroundTransparency = 0.1;
        local Fill = Frame2:FindFirstChild("Fill");

        if Fill then
            Fill:Destroy();
        end;

        local Ring = Frame2:FindFirstChild("Ring");

        if Ring then
            Ring.Color = Color3_fromRGB_ret2;
        end;

        label(Frame2, "TierName", CombineConfig.TierNames[v188] or "", {
            Position = UDim2.fromScale(0.06, 0.04),
            Size = UDim2.fromScale(0.6, 0.15),
            TextColor3 = CombineConfig.TierColors[math.clamp(v188, 1, #CombineConfig.TierColors)],
            TextXAlignment = Enum.TextXAlignment.Left
        }, 0.1);
        local v190 = {
            BackgroundTransparency = 1,
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromScale(0.5, 0.42),
            Size = UDim2.fromScale(0.8, 0.46)
        };
        local Frame3 = Instance.new("Frame");
        Frame3.Name = "Icon";

        for i2, v2 in v190 or {} do
            Frame3[i2] = v2;
        end;

        Frame3.Parent = Frame2;
        local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint");
        UIAspectRatioConstraint.Name = "Square";

        for i2, v2 in {
            AspectRatio = 1
        } or {} do
            UIAspectRatioConstraint[i2] = v2;
        end;

        UIAspectRatioConstraint.Parent = Frame3;
        local v191 = {
            BackgroundTransparency = 1,
            Image = "rbxassetid://129028976496842",
            ImageTransparency = 0.55,
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromScale(0.5, 0.5),
            Size = UDim2.fromScale(1.25, 1.25),
            ImageColor3 = CombineConfig.TierColors[math.clamp(v188, 1, #CombineConfig.TierColors)]
        };
        local ImageLabel = Instance.new("ImageLabel");
        ImageLabel.Name = "Glow";

        for i2, v2 in v191 or {} do
            ImageLabel[i2] = v2;
        end;

        ImageLabel.Parent = Frame3;
        local u192 = {
            frame = Frame2,
            icon = knifeIcon(Frame3, v),
            name = label(Frame2, "NameText", v181.Names[v188], {
                AnchorPoint = Vector2.new(0.5, 0),
                Position = UDim2.fromScale(0.5, 0.645),
                Size = UDim2.fromScale(0.9, 0.12)
            }, 0.1),
            count = label(Frame2, "Owned", "", {
                AnchorPoint = Vector2.new(1, 0),
                Position = UDim2.fromScale(0.95, 0.05),
                Size = UDim2.fromScale(0.3, 0.13),
                TextColor3 = Color3_fromRGB_ret4,
                TextXAlignment = Enum.TextXAlignment.Right
            }, 0.1)
        };
        local v193 = {
            Position = UDim2.fromScale(0.06, 0.84),
            Size = UDim2.fromScale(0.6, 0.065),
            BackgroundColor3 = Color3_fromRGB_ret5
        };
        local Frame4 = Instance.new("Frame");
        Frame4.Name = "Track";

        for i2, v2 in v193 or {} do
            Frame4[i2] = v2;
        end;

        Frame4.Parent = Frame2;
        u192.track = Frame4;
        local track = u192.track;
        local v194 = {
            CornerRadius = UDim.new(1, 0)
        };
        local UICorner2 = Instance.new("UICorner");
        UICorner2.Name = "UICorner";

        for i2, v2 in v194 or {} do
            UICorner2[i2] = v2;
        end;

        UICorner2.Parent = track;
        local track2 = u192.track;
        local v195 = {
            Size = UDim2.fromScale(0, 1),
            BackgroundColor3 = Color3_new_ret
        };
        local Frame5 = Instance.new("Frame");
        Frame5.Name = "Fill";

        for i2, v2 in v195 or {} do
            Frame5[i2] = v2;
        end;

        Frame5.Parent = track2;
        u192.fill = Frame5;
        local fill = u192.fill;
        local v196 = {
            CornerRadius = UDim.new(1, 0)
        };
        local UICorner3 = Instance.new("UICorner");
        UICorner3.Name = "UICorner";

        for i2, v2 in v196 or {} do
            UICorner3[i2] = v2;
        end;

        UICorner3.Parent = fill;
        local v197 = v188 + 1;
        local v198 = v188 + 1;
        gradient(u192.fill, u4[u4[v197] and v197 and v197 or 4][1], u4[u4[v198] and v198 and v198 or 4][2], 0.1);
        u192.progress = label(Frame2, "Progress", "", {
            AnchorPoint = Vector2.new(1, 0.5),
            Position = UDim2.fromScale(0.95, 0.872),
            Size = UDim2.fromScale(0.28, 0.14),
            TextXAlignment = Enum.TextXAlignment.Right
        }, 0.12);

        if v188 < v182 then
            local u199 = v181.Tiers[v188 + 1];
            u192.combine = button(Frame2, "Combine", "COMBINE", "green", {
                Visible = false,
                Position = UDim2.fromScale(0.05, 0.78),
                Size = UDim2.fromScale(0.9, 0.19)
            });
            u192.combine.TextLabel.Size = UDim2.fromScale(0.86, 0.72);
            u192.combine.Activated:Connect(function() -- Line: 938
                -- upvalues: u192 (copy), u177 (copy), u199 (copy)
                if u192.combine.Interactable then
                    u177:send("Combine", u199);
                end;
            end);
            v185.arrows[v188] = arrow(Frame, "Arrow" .. v188, UDim2.fromScale(v186 + v183, 0), UDim2.fromScale(0.085, 1), "×" .. v181.Costs[v188]);
        end;

        v185.cards[v188] = u192;
    end;

    return v185;
end;

function u1.layout(p200, p201) -- Line: 952
    -- upvalues: Color3_fromRGB_ret2 (copy)
    local table_concat_ret = table.concat(p201, ",");

    if p200.laidOut == table_concat_ret then
        return;
    end;

    p200.laidOut = table_concat_ret;

    for _, v in p200.lanes do
        v.root:Destroy();
    end;

    for _, v in p200.links do
        v:Destroy();
    end;

    p200.lanes = {};
    p200.links = {};
    local v202 = (1 - math.max(#p201 - 1, 0) * 0.06) / math.max(#p201, 1);
    local v203 = nil;
    local v204 = nil;

    for i, v in p201 do
        local v205 = (i - 1) * (v202 + 0.06);
        p200.lanes[v] = p200:lane(v, v205, v202);
        v204 = v205 + v202 * 0.5;
        local links = p200.links;
        local road = p200.road;
        local v206 = {
            BorderSizePixel = 0,
            AnchorPoint = Vector2.new(0, 0.5),
            Position = UDim2.fromScale(0.735, v204),
            Size = UDim2.new(0.015000000000000013, 2, 0, 3),
            BackgroundColor3 = Color3_fromRGB_ret2
        };
        local Frame = Instance.new("Frame");
        Frame.Name = "Link" .. i;
        v203 = v203 or v204;

        for i2, v2 in v206 or {} do
            Frame[i2] = v2;
        end;

        Frame.Parent = road;
        table.insert(links, Frame);
    end;

    if v203 then
        local links = p200.links;
        local road = p200.road;
        local v207 = {
            BorderSizePixel = 0,
            AnchorPoint = Vector2.new(0.5, 0),
            Position = UDim2.fromScale(0.75, v203),
            Size = UDim2.new(0, 3, v204 - v203, 0),
            BackgroundColor3 = Color3_fromRGB_ret2
        };
        local Frame = Instance.new("Frame");
        Frame.Name = "LinkJoin";

        for i, v in v207 or {} do
            Frame[i] = v;
        end;

        Frame.Parent = road;
        table.insert(links, Frame);
        local links2 = p200.links;
        local road2 = p200.road;
        local v208 = {
            BorderSizePixel = 0,
            AnchorPoint = Vector2.new(0, 0.5),
            Position = UDim2.fromScale(0.75, 0.5),
            Size = UDim2.new(0.015000000000000013, 0, 0, 3),
            BackgroundColor3 = Color3_fromRGB_ret2
        };
        local Frame2 = Instance.new("Frame");
        Frame2.Name = "LinkIn";

        for i, v in v208 or {} do
            Frame2[i] = v;
        end;

        Frame2.Parent = road2;
        table.insert(links2, Frame2);
    end;
end;

local function wheelIcon(p209) -- Line: 1001
    local SpinWheel = game:GetService("StarterGui"):FindFirstChild("SpinWheel");

    if SpinWheel then
        SpinWheel = SpinWheel:FindFirstChild("Main");
    end;

    if SpinWheel then
        SpinWheel = SpinWheel:FindFirstChild("Wheel");
    end;

    if not (SpinWheel and SpinWheel:IsA("GuiObject")) then
        return nil;
    end;

    local v210 = SpinWheel:Clone();

    for _, descendant in v210:GetDescendants() do
        if descendant:IsA("LuaSourceContainer") then
            descendant:Destroy();
        elseif descendant:IsA("TextLabel") then
            descendant.Visible = false;
        end;
    end;

    v210.AnchorPoint = Vector2.new(0.5, 0.5);
    v210.Position = UDim2.fromScale(0.5, 0.5);
    v210.Size = UDim2.fromScale(1, 1);
    v210.Parent = p209;

    return v210;
end;

function u1.setBannerIcon(p211, p212, p213) -- Line: 1023
    -- upvalues: wheelIcon (copy), knifeIcon (copy)
    for i, v in p211.bannerIcons do
        if v then
            v.Visible = i == p212;
        end;
    end;

    if p212 and p211.bannerIcons[p212] == nil then
        local bannerIcons = p211.bannerIcons;
        local v214;

        if p212 == "Wheel" then
            v214 = wheelIcon(p211.bannerIcon);
        else
            v214 = knifeIcon(p211.bannerIcon, p212);
        end;

        bannerIcons[p212] = v214 or false;
    end;

    p211.bannerGlow.ImageColor3 = p213;
end;

function u1.refresh(p215) -- Line: 1037
    -- upvalues: u75 (ref), openFamilies (copy), Weapons (copy), CombineConfig (copy), nextStep (copy), Color3_new_ret (copy), u4 (copy), Color3_fromRGB_ret4 (copy), setLook (copy), Color3_fromRGB_ret2 (copy), Color3_fromRGB_ret3 (copy), showcase (copy), Color3_fromRGB_ret (copy), pathProgress (copy)
    local v216 = not u75.loaded and {} or openFamilies();
    local v217;

    if u75.loaded then
        v217 = Weapons:FindFirstChild("CombineEvent");

        if v217 then
            v217 = v217:GetAttribute("Fusion");
        end;

        if type(CombineConfig.Fusion) ~= "table" or v217 ~= CombineConfig.Fusion.Output then
            v217 = nil;
        end;
    else
        v217 = nil;
    end;

    local v218 = #v216 > 0;
    p215:layout(v216);
    p215.road.Visible = v218;
    p215.banner.Visible = v218;
    p215.footer.Visible = v218;
    p215.placeholder.Visible = not v218;
    p215.placeholder.Text = u75.loaded and "Not available yet" or "Loading your knives…";
    p215.placeholderNote.Visible = not v218 and u75.loaded;
    p215:setTimer();
    p215.ultimate.root.Visible = v217 ~= nil;

    for _, v in p215.links do
        v.Visible = v217 ~= nil;
    end;

    if not v218 then
        return;
    end;

    local v219 = p215.waiting ~= nil and true or p215.animating;
    local v220 = nextStep(v216, v217);

    for i, v in p215.lanes do
        local v221 = CombineConfig.Families[i];
        local v222 = v221.Tiers[#v221.Tiers];
        local v223;

        if (u75.stacks[v222] or (u75.owned[v222] == true and 1 or 0)) > 0 then
            v223 = true;
        elseif type(CombineConfig.Fusion) == "table" then
            local Output = CombineConfig.Fusion.Output;
            v223 = (u75.stacks[Output] or (u75.owned[Output] == true and 1 or 0)) > 0;
        else
            v223 = false;
        end;

        local v224 = i;
        local v225 = v;

        for i2, v2 in v.cards do
            local v226 = v221.Tiers[i2];
            local v227 = u75.stacks[v226] or (u75.owned[v226] == true and 1 or 0);
            local v228 = v221.Costs[i2];
            local v229 = i2 == #v221.Tiers;
            local v230 = not v229 and v228 <= v227;
            v2.count.Text = v227 <= 0 and "" or "x" .. v227;

            if v227 > 0 or v223 then
                local icon = v2.icon;
                v2.icon.ImageColor3 = Color3_new_ret;
                icon.ImageTransparency = 0;
            elseif i2 == 1 then
                local icon = v2.icon;
                v2.icon.ImageColor3 = Color3_new_ret;
                icon.ImageTransparency = 0.25;
            else
                local icon = v2.icon;
                v2.icon.ImageColor3 = Color3.fromRGB(110, 110, 125);
                icon.ImageTransparency = 0.15;
            end;

            local v231 = Color3_new_ret;
            local v232;

            if v229 and v227 > 0 then
                local v233;

                if type(CombineConfig.Fusion) == "table" then
                    local Output = CombineConfig.Fusion.Output;
                    v233 = (u75.stacks[Output] or (u75.owned[Output] == true and 1 or 0)) > 0;
                else
                    v233 = false;
                end;

                v232 = v233 and "OWNED ✓" or "READY ✓";
                local v234;

                if type(CombineConfig.Fusion) == "table" then
                    local Output = CombineConfig.Fusion.Output;
                    v234 = (u75.stacks[Output] or (u75.owned[Output] == true and 1 or 0)) > 0;
                else
                    v234 = false;
                end;

                if v234 then
                    v231 = u4.green[1];
                else
                    v231 = Color3_fromRGB_ret4;
                end;
            elseif v229 then
                v232 = "0/1";
            else
                v232 = ("%d/%d"):format(math.min(v227, v228), v228);
            end;

            local progress = v2.progress;
            v2.progress.Text = v232;
            progress.TextColor3 = v231;
            local fill = v2.fill;
            local UDim2_fromScale = UDim2.fromScale;
            local v235;

            if v229 then
                v235 = v227 > 0 and 1 or 0;
            else
                v235 = math.clamp(v227 / v228, 0, 1);
            end;

            fill.Size = UDim2_fromScale(v235, 1);
            local v236;

            if v229 then
                v236 = v227 > 0;
            else
                v236 = v229;
            end;

            local v237 = not v236 and not v230;
            v2.track.Visible = v237;
            v2.progress.Visible = not v230;
            local progress2 = v2.progress;
            local v238;

            if v237 then
                v238 = Vector2.new(1, 0.5);
            else
                v238 = Vector2.new(0.5, 0.5);
            end;

            progress2.AnchorPoint = v238;
            local progress3 = v2.progress;
            local v239;

            if v237 then
                v239 = UDim2.fromScale(0.95, 0.872);
            else
                v239 = UDim2.fromScale(0.5, 0.872);
            end;

            progress3.Position = v239;
            local progress4 = v2.progress;
            local v240;

            if v237 then
                v240 = UDim2.fromScale(0.28, 0.14);
            else
                v240 = UDim2.fromScale(0.9, 0.16);
            end;

            progress4.Size = v240;
            local v241;

            if v237 then
                v241 = Enum.TextXAlignment.Right;
            else
                v241 = Enum.TextXAlignment.Center;
            end;

            v2.progress.TextXAlignment = v241;
            local v242, v243;

            if v229 then
                v242 = i2;
                v243 = v2;
            else
                v2.combine.Visible = v230;
                local combine = v2.combine;
                local v244 = not v219;
                combine.Interactable = v244;
                combine.AutoButtonColor = v244;
                setLook(combine, v244 and "green" or "grey");
                local v245 = v225.arrows[i2];
                local v246;

                if v230 or v223 then
                    v246 = CombineConfig.TierColors[math.clamp(i2 + 1, 1, #CombineConfig.TierColors)];
                else
                    v246 = Color3_fromRGB_ret2;
                end;

                v243 = v2;
                v242 = i2;

                for _, v3 in v245.parts do
                    v3.BackgroundColor3 = v246;
                end;

                if v246 == Color3_fromRGB_ret2 then
                    v246 = Color3_fromRGB_ret3;
                end;

                v245.cost.TextColor3 = v246;
            end;

            if v230 then
                showcase(v243.frame, u4.green[3]);
            elseif v220.kind == "Spin" and (v242 == 1 and not (v223 or v220.familyId ~= v224 and v220.familyId ~= nil)) then
                showcase(v243.frame, Color3_fromRGB_ret4);
            elseif v227 > 0 or v223 then
                showcase(v243.frame, CombineConfig.TierColors[math.clamp(v242, 1, #CombineConfig.TierColors)]);
            else
                local frame = v243.frame;
                frame.BackgroundColor3 = Color3_fromRGB_ret;
                frame.BackgroundTransparency = 0.1;
                local Fill = frame:FindFirstChild("Fill");

                if Fill then
                    Fill:Destroy();
                end;

                local Ring = frame:FindFirstChild("Ring");

                if Ring then
                    Ring.Color = Color3_fromRGB_ret2;
                end;
            end;
        end;
    end;

    if v217 then
        local v247;

        if type(CombineConfig.Fusion) == "table" then
            local Output = CombineConfig.Fusion.Output;
            v247 = (u75.stacks[Output] or (u75.owned[Output] == true and 1 or 0)) > 0;
        else
            v247 = false;
        end;

        local v248 = v220.kind == "Fuse";

        for _, v in { p215.ultimate.icon, p215.ultimate.twin } do
            v.ImageColor3 = Color3_new_ret;
            v.ImageTransparency = (v247 or v248) and 0 or 0.2;
        end;

        p215.ultimate.glow.ImageTransparency = (v247 or v248) and 0.15 or 0.45;
        p215.ultimate.fuse.Visible = v248;
        local fuse = p215.ultimate.fuse;
        local v249 = not v219;
        fuse.Interactable = v249;
        fuse.AutoButtonColor = v249;
        setLook(fuse, v249 and 4 or "grey");
        p215.ultimate.status.Visible = not v248;
        local v250 = 0;

        for _, v in CombineConfig.Fusion.Inputs do
            v250 = v250 + ((u75.stacks[v] or (u75.owned[v] == true and 1 or 0)) > 0 and 1 or 0);
        end;

        p215.ultimate.status.Text = v247 and "OWNED ✓" or ("DUALS %d/%d"):format(v250, #CombineConfig.Fusion.Inputs);
        local status = p215.ultimate.status;
        local v251;

        if v247 then
            v251 = UDim2.fromScale(0.9, 0.12);
        else
            v251 = UDim2.fromScale(0.9, 0.085);
        end;

        status.Size = v251;
        local v252;

        if v247 then
            v252 = u4.green[1];
        else
            v252 = Color3_fromRGB_ret3;
        end;

        p215.ultimate.status.TextColor3 = v252;
        p215.ultimate.state = v247 and "Forged" or (v248 and "Ready" or "Locked");

        for _, v in p215.links do
            local v253;

            if v247 or v248 then
                v253 = CombineConfig.TierColors[math.clamp(#CombineConfig.TierNames, 1, #CombineConfig.TierColors)];
            else
                v253 = Color3_fromRGB_ret2;
            end;

            v.BackgroundColor3 = v253;
        end;
    end;

    local v254 = 0;
    local v255 = 0;

    for _, v in v216 do
        local v256, v257 = pathProgress(CombineConfig.Families[v]);
        v254 = v254 + v256;
        v255 = v255 + v257;
    end;

    local v258;

    if v217 then
        local v259;

        if type(CombineConfig.Fusion) == "table" then
            local Output = CombineConfig.Fusion.Output;
            v259 = (u75.stacks[Output] or (u75.owned[Output] == true and 1 or 0)) > 0;
        else
            v259 = false;
        end;

        if v259 then
            v258 = 1;
        else
            v258 = v255 <= 0 and 0 or (v217 and 0.9 or 1) * v254 / v255;
        end;
    else
        v258 = v255 <= 0 and 0 or (v217 and 0.9 or 1) * v254 / v255;
    end;

    p215.progressFill.Size = UDim2.fromScale(v258, 1);
    p215.progressText.Text = math.floor(v258 * 100) .. "%";
    p215.step = v220;
    local v260;

    if v220.kind == "Combine" then
        v260 = u4.green[3];
    elseif v220.kind == "Done" then
        v260 = u4.green[3];
    else
        v260 = Color3_fromRGB_ret4;
    end;

    p215.bannerTitle.Text = v220.title;
    local v261;

    if v220.kind == "Spin" then
        v261 = Color3_new_ret;
    else
        v261 = v260;
    end;

    p215.bannerTitle.TextColor3 = v261;
    local v262 = p215.status or "";
    local v263;

    if v262 == "" then
        v263 = v220.note;
    else
        v263 = v262;
    end;

    p215.bannerNote.Text = v263;
    local v264;

    if v262 == "" then
        v264 = Color3_fromRGB_ret3;
    else
        v264 = Color3_fromRGB_ret4;
    end;

    p215.bannerNote.TextColor3 = v264;
    p215:setBannerIcon(v220.skin, v260);
    showcase(p215.banner, v260);
    local v265 = "SPIN THE WHEEL";
    local v266 = 4;
    local v267 = true;

    if v220.kind == "Combine" then
        v265 = "COMBINE";
        v266 = "green";
    elseif v220.kind == "Fuse" then
        v265 = "FUSE";
        v266 = 4;
    elseif v220.kind == "Done" then
        local v268 = u75.equipped == v220.skin;
        v265 = v268 and "EQUIPPED" or "EQUIP";
        v267 = not v268;
        v266 = "green";
    end;

    p215.cta.TextLabel.Text = v265;
    local cta = p215.cta;

    if v267 then
        v267 = not v219;
    end;

    cta.Interactable = v267;
    cta.AutoButtonColor = v267;
    setLook(cta, not v267 and "grey" or v266);
end;

function u1.setTimer(p269) -- Line: 1172
    -- upvalues: CombineConfig (copy), Color3_fromRGB_ret6 (copy), Color3_fromRGB_ret4 (copy)
    local v270;

    if type(CombineConfig.EndsAt) == "number" then
        local v271 = CombineConfig.EndsAt - workspace:GetServerTimeNow();

        if v271 > 0 then
            local v272 = v271 // 86400;
            local v273 = v271 % 86400 // 3600;
            local v274 = v271 % 3600 // 60;
            local v275;

            if v272 > 0 then
                v275 = ("%dd %dh"):format(v272, v273);
            elseif v273 > 0 then
                v275 = ("%dh %dm"):format(v273, v274);
            else
                v275 = ("%dm"):format((math.max(v274, 1)));
            end;

            v270 = "Ends in " .. v275;
        else
            v270 = "Event over";
        end;
    else
        v270 = "";
    end;

    local v276 = type(CombineConfig.EndsAt) ~= "number" and (1 / 0) or CombineConfig.EndsAt - workspace:GetServerTimeNow();
    local v277;

    if v276 > 0 then
        v277 = v276 < 259200;
    else
        v277 = false;
    end;

    if v277 then
        v270 = v270 .. "!";
    end;

    p269.timerText.Text = v270;
    local v278;

    if v277 then
        v278 = Color3_fromRGB_ret6;
    else
        v278 = Color3_fromRGB_ret4;
    end;

    p269.timerText.TextColor3 = v278;
end;

function u1.act(p279) -- Line: 1181
    -- upvalues: ArmoryEvent (copy)
    local step = p279.step;

    if not (step and p279.cta.Interactable) then
        return;
    end;

    if step.kind == "Spin" then
        p279:goToWheel();

        return;
    end;

    if step.kind == "Combine" or step.kind == "Fuse" then
        p279:send("Combine", step.output);

        return;
    end;

    if step.kind == "Done" then
        ArmoryEvent:FireServer("Equip", step.skin);
    end;
end;

function u1.goToWheel(p280) -- Line: 1197
    -- upvalues: LocalPlayer (copy), u1 (copy)
    if LocalPlayer:GetAttribute("InMatch") == true then
        u1.notice("The Spin Wheel is in the lobby.");

        return;
    end;

    p280.host.close();
    task.delay(0.2, function() -- Line: 1203
        -- upvalues: LocalPlayer (ref)
        local v281 = LocalPlayer:FindFirstChildOfClass("PlayerGui");
        local v282 = v281 and v281:FindFirstChild("SpinWheel") and v281.SpinWheel:FindFirstChild("OpenRequest");

        if v282 and v282:IsA("BindableEvent") then
            v282:Fire();
        end;
    end);
end;

function u1.send(u283, u284, p285) -- Line: 1213
    -- upvalues: CombineConfig (copy), Weapons (copy), openFamilies (copy)
    if u283.waiting or (u283.animating or not u283.remote) then
        return;
    end;

    local v286;

    if u284 == "Combine" and CombineConfig.isFusion(p285) then
        local CombineEvent = Weapons:FindFirstChild("CombineEvent");

        if CombineEvent then
            CombineEvent = CombineEvent:GetAttribute("Fusion");
        end;

        if type(CombineConfig.Fusion) ~= "table" or CombineEvent ~= CombineConfig.Fusion.Output then
            CombineEvent = nil;
        end;

        v286 = CombineEvent ~= nil;
    else
        local v287;

        if u284 == "Combine" then
            v287 = CombineConfig.tierOf(p285);
        else
            v287 = nil;
        end;

        v286 = v287 == nil and true or table.find(openFamilies(), v287) ~= nil;
    end;

    if not (u283:available() and v286) then
        u283.status = "That can\'t be combined right now.";
        u283:refresh();

        return;
    end;

    local os_clock_ret = os.clock();
    u283.waiting = u284;
    u283.waitingSince = os_clock_ret;
    u283.status = "Combining…";
    u283:refresh();
    u283.remote:FireServer(u284, p285);
    task.delay(20, function() -- Line: 1234
        -- upvalues: u283 (copy), u284 (copy), os_clock_ret (copy)
        if u283.waiting == u284 and u283.waitingSince == os_clock_ret then
            u283.waiting = nil;
            u283.status = "No answer yet. Try again in a moment.";
            u283:refresh();
        end;
    end);
end;

local u288 = { 1.3, 1.3, 1.5 };
local u289 = { 1.8, 1.8, 2.3 };
local u290 = { 2, 2, 4 };

local function recipeOf(p291) -- Line: 1260
    -- upvalues: CombineConfig (copy)
    if p291.mode == "Fuse" then
        local Fusion = CombineConfig.Fusion;

        if type(Fusion) ~= "table" then
            return nil;
        end;

        local v292 = #CombineConfig.TierNames;

        return {
            key = "Fusion",
            family = "Fusion",
            tier = v292,
            output = Fusion.Output,
            inputs = table.clone(Fusion.Inputs),
            color = CombineConfig.TierColors[math.clamp(v292, 1, #CombineConfig.TierColors)],
            inputColor = CombineConfig.TierColors[math.clamp(v292 - 1, 1, #CombineConfig.TierColors)]
        };
    end;

    local v293 = CombineConfig.Families[p291.family];

    if not v293 then
        return nil;
    end;

    local math_clamp_ret = math.clamp(p291.tier or 2, 2, #v293.Tiers);

    return {
        key = p291.family .. ":" .. math_clamp_ret,
        family = p291.family,
        tier = math_clamp_ret,
        output = v293.Tiers[math_clamp_ret],
        inputs = table.create(v293.Costs[math_clamp_ret - 1], v293.Tiers[math_clamp_ret - 1]),
        color = CombineConfig.TierColors[math.clamp(math_clamp_ret, 1, #CombineConfig.TierColors)],
        inputColor = CombineConfig.TierColors[math.clamp(math_clamp_ret - 1, 1, #CombineConfig.TierColors)]
    };
end;

function u1.play(p294, p295) -- Line: 1293
    -- upvalues: recipeOf (copy), u289 (copy), u288 (copy), u290 (copy), u120 (copy)
    local v296 = recipeOf(p295);

    if not v296 then
        p294:refresh();

        return;
    end;

    local math_clamp_ret = math.clamp(v296.tier - 1, 1, 3);
    local v297 = 0.7 + u289[math_clamp_ret];
    local v298 = {
        gather = 0.7,
        charge = 1.2,
        result = p295,
        family = v296.family,
        tier = v296.tier,
        level = math_clamp_ret,
        output = v296.output,
        input = v296.inputs[1],
        inputs = v296.inputs,
        color = v296.color,
        inputColor = v296.inputColor,
        tracks = 0.7 + u288[math_clamp_ret],
        converge = v297,
        done = v297 + 1 + u290[math_clamp_ret]
    };
    p294.animating = true;
    p294:setHidden(true);
    p294:refresh();

    for _, v in u120 do
        task.spawn(v, "Start", v298);
    end;

    task.wait(v298.done);
    p294.animating = false;
    p294:setHidden(false);
    p294:refresh();
end;

local TweenInfo_new_ret = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In);
local TweenInfo_new_ret2 = TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);

function u1.setHidden(p299, p300) -- Line: 1332
    -- upvalues: TweenInfo_new_ret (copy), TweenInfo_new_ret2 (copy), TweenService (copy)
    if p299.hidden == p300 then
        return;
    end;

    p299.hidden = p300;
    local v301;

    if p300 then
        v301 = TweenInfo_new_ret;
    else
        v301 = TweenInfo_new_ret2;
    end;

    if p299.host.setHidden then
        p299.host.setHidden(p300, v301.Time);
    end;

    if p299.popTween then
        p299.popTween:Cancel();
    end;

    p299.popTween = TweenService:Create(p299.pop, v301, {
        Scale = p300 and 0 or 1
    });
    p299.popTween:Play();
end;

function u1.fetch(p302) -- Line: 1349
    -- upvalues: ArmoryEvent (copy)
    local os_clock_ret = os.clock();

    if os_clock_ret - (p302.fetchedAt or (-1 / 0)) >= 0.75 then
        p302.fetchedAt = os_clock_ret;
        ArmoryEvent:FireServer("Get");
    end;
end;

function u1.available(p303) -- Line: 1358
    local v304;

    if p303.remote == nil then
        v304 = false;
    else
        v304 = p303.remote:GetAttribute("MergeEventLive") == true;
    end;

    return v304;
end;

function u1.opened(p305) -- Line: 1362
    -- upvalues: u1 (copy)
    if not p305:available() then
        task.defer(p305.host.close);
        u1.notice(u1.UNAVAILABLE);

        return;
    end;

    p305:fetch();
    p305.status = "";
    p305:refresh();

    if p305.hidden and p305.host.setHidden then
        p305.host.setHidden(true);
    end;
end;

function u1.closed(p306) -- Line: 1378
end;

function u1.start(u307, u308) -- Line: 1380
    -- upvalues: LocalPlayer (copy), u1 (copy), u75 (ref), u120 (copy), ArmoryEvent (copy), RunService (copy), Weapons (copy), openFamilies (copy), CombineConfig (copy), u5 (copy)
    u307.host = u308;
    u307.cta.Activated:Connect(function() -- Line: 1382
        -- upvalues: u307 (copy)
        u307:act();
    end);

    local function lobby() -- Line: 1387
        -- upvalues: LocalPlayer (ref), u307 (copy), u308 (copy), u1 (ref)
        local v309 = LocalPlayer:GetAttribute("InMatch") ~= true;
        local v310 = u307:available();
        u308.setAvailable(v309 and v310);

        if u308.isOpen() and not (v309 and v310) then
            u308.close();

            if not v310 then
                u1.notice(u1.UNAVAILABLE);
            end;
        end;
    end;

    LocalPlayer:GetAttributeChangedSignal("InMatch"):Connect(lobby);
    lobby();

    local function update(p311) -- Line: 1399
        -- upvalues: u75 (ref), u120 (ref), u307 (copy)
        if type(p311) ~= "table" then
            return;
        end;

        u75 = {
            owned = type(p311.owned) ~= "table" and {} or p311.owned,
            stacks = type(p311.knifeStacks) ~= "table" and {} or p311.knifeStacks,
            equipped = p311.equipped,
            loaded = p311.loaded == true
        };

        for _, v in u120 do
            task.spawn(v, "Knives", nil);
        end;

        if not u307.animating then
            u307:refresh();
        end;
    end;

    ArmoryEvent.OnClientEvent:Connect(function(p312, p313) -- Line: 1414
        -- upvalues: update (copy)
        if p312 == "State" then
            update(p313);
        end;
    end);
    u307:fetch();
    u307:refresh();
    task.spawn(function() -- Line: 1422
        -- upvalues: u307 (copy), u308 (copy)
        while u307.frame do
            if u308.isOpen() and not u307.animating then
                u307:setTimer();
            end;

            task.wait(1);
        end;
    end);
    RunService.Heartbeat:Connect(function(p314) -- Line: 1431
        -- upvalues: u307 (copy), u308 (copy)
        local ultimate = u307.ultimate;

        if not (u308.isOpen() and (ultimate.state ~= nil and ultimate.state ~= "Locked")) then
            if ultimate.pulse then
                ultimate.pulse.Scale = 1;
            end;

            return;
        end;

        ultimate.glow.Rotation = (ultimate.glow.Rotation + p314 * 20) % 360;
        local pulse = ultimate.pulse;
        local v315;

        if ultimate.state == "Ready" then
            local v316 = os.clock() * 3.141592653589793 * 2 / 0.8;
            v315 = (math.sin(v316) + 1) * 0.02 + 1;
        else
            v315 = 1;
        end;

        pulse.Scale = v315;
    end);
    u307.remote = Weapons:WaitForChild("CombineEvent", 60);

    if not u307.remote then
        warn("COMBINE: Weapons.CombineEvent never arrived");

        return;
    end;

    u307.remote:GetAttributeChangedSignal("MergeEventLive"):Connect(lobby);
    lobby();
    local u317 = {};

    local function families() -- Line: 1454
        -- upvalues: openFamilies (ref), u307 (copy), CombineConfig (ref), u317 (copy), u120 (ref)
        local v318 = openFamilies();

        if type(u307.remote:GetAttribute("Families")) == "string" then
            for _, v in CombineConfig.Order do
                if not (table.find(v318, v) or u317[v]) then
                    u317[v] = true;
                    warn("COMBINE: the " .. tostring(v) .. " family is off on the server, so it isn\'t shown (the server\'s output says why)");
                end;
            end;
        end;

        for _, v in u120 do
            task.spawn(v, "Knives", nil);
        end;

        if not u307.animating then
            u307:refresh();
        end;
    end;

    u307.remote:GetAttributeChangedSignal("Families"):Connect(families);
    u307.remote:GetAttributeChangedSignal("Fusion"):Connect(families);
    families();
    u307.remote.OnClientEvent:Connect(function(p319, p320) -- Line: 1472
        -- upvalues: u307 (copy), u5 (ref)
        if type(p320) ~= "table" then
            return;
        end;

        if p319 == "Result" and u307.waiting then
            u307.waiting = nil;

            if p320.ok == true then
                u307.status = "";
                task.spawn(u307.play, u307, p320);

                return;
            end;

            u307.status = u5[p320.reason] or "That didn\'t save, and nothing was used. Try again.";
            u307:refresh();
        end;
    end);
end;

function u1.notice(u321) -- Line: 1491
    -- upvalues: ChickenOrHero (copy)
    task.spawn(function() -- Line: 1492
        -- upvalues: ChickenOrHero (ref), u321 (copy)
        local success, result = pcall(function() -- Line: 1493
            -- upvalues: ChickenOrHero (ref), u321 (ref)
            local v322;

            if require(game:GetService("ReplicatedFirst"):WaitForChild("FFlags")).awaitUIVersion() == "NewGui" then
                v322 = ChickenOrHero:WaitForChild("Interface"):WaitForChild("Toasts", 5);
            else
                v322 = ChickenOrHero:WaitForChild("Presentation"):WaitForChild("ValleyToast", 5);
            end;

            require(v322).show(u321);
        end);

        if not success then
            warn("COMBINE notice: " .. tostring(result));
        end;
    end);
end;

function u1.preview(p323) -- Line: 1507
    -- upvalues: u75 (ref), u1 (copy)
    u75 = p323;
    local v324 = u1.new();
    v324.host = {
        isOpen = function() -- Line: 1510, Name: isOpen
            return true;
        end
    };

    return v324;
end;

return u1;