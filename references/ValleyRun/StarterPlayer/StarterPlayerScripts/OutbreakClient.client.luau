 

 

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local UserInputService = game:GetService("UserInputService");
local ProximityPromptService = game:GetService("ProximityPromptService");
local LocalPlayer = Players.LocalPlayer;
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");
local ChickenOrHero = game:GetService("ReplicatedStorage"):WaitForChild("ChickenOrHero");
local OutbreakConfig = require(ChickenOrHero:WaitForChild("Game"):WaitForChild("OutbreakConfig"));
local HudNavigation = require(ChickenOrHero:WaitForChild("Presentation"):WaitForChild("HudNavigation"));
local CrateCatalog = require(ChickenOrHero:WaitForChild("Crates"):WaitForChild("CrateCatalog"));
local MapLocator = require(ChickenOrHero.Game:WaitForChild("MapLocator"));
local Font_new_ret = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.ExtraBold);
local Font_new_ret2 = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy);
local Color3_fromRGB_ret = Color3.fromRGB(166, 255, 106);
local Color3_fromRGB_ret2 = Color3.fromRGB(14, 20, 16);
local Color3_fromRGB_ret3 = Color3.fromRGB(22, 28, 24);
local Color3_fromRGB_ret4 = Color3.fromRGB(28, 36, 30);
local Color3_fromRGB_ret5 = Color3.fromRGB(58, 92, 54);
local Color3_fromRGB_ret6 = Color3.fromRGB(170, 190, 170);
local Color3_new_ret = Color3.new(1, 1, 1);

local function place(p1, p2) -- Line: 42
    return { (p1 + 180) / 360, (84 - p2) / 142 };
end;

local u3 = {};

for _, v in { { -98, 42 }, { -80, 40 }, { -118, 35 }, { -90, 31 }, { -74, 45 }, { -112, 54 }, { -96, 60 }, { -150, 63 }, { -100, 21 }, { -84, 10 }, { -74, 4 }, { -60, -8 }, { -47, -16 }, { -64, -28 }, { -68, -42 }, { -4, 40 }, { 2, 48 }, { 13, 51 }, { 12, 43 }, { 25, 62 }, { 32, 55 }, { -5, 10 }, { 5, 18 }, { 32, 2 }, { 20, -14 }, { 26, -28 }, { 40, 9 }, { 46, 25 }, { 44, 40 }, { 62, 57 }, { 78, 24 }, { 84, 56 }, { 104, 62 }, { 106, 32 }, { 116, 40 }, { 132, 64 }, { 139, 36 }, { 103, 15 }, { 112, -1 }, { 134, -25 }, { 147, -32 }, { 120, -28 }, { 174, -39 } } do
    table.insert(u3, { (v[1] + 180) / 360, (84 - v[2]) / 142 });
end;

local u4 = {};

local function on(p5, p6) -- Line: 59
    -- upvalues: u4 (copy)
    local v7 = p5:Connect(p6);
    table.insert(u4, v7);

    return v7;
end;

local function now() -- Line: 64
    local ServerTimeNow = workspace:GetServerTimeNow();

    if ServerTimeNow > 1000000000 then
        return ServerTimeNow;
    end;

    return os.time();
end;

local function make(p8, p9, p10) -- Line: 69
    local Instance_new_ret = Instance.new(p8);

    for i, v in p10 do
        Instance_new_ret[i] = v;
    end;

    Instance_new_ret.Parent = p9;

    return Instance_new_ret;
end;

local function text(p11, p12) -- Line: 77
    -- upvalues: Font_new_ret (copy), Color3_new_ret (copy)
    p12.BackgroundTransparency = 1;
    p12.FontFace = p12.FontFace or Font_new_ret;
    p12.TextColor3 = p12.TextColor3 or Color3_new_ret;
    p12.TextXAlignment = p12.TextXAlignment or Enum.TextXAlignment.Left;
    local TextLabel = Instance.new("TextLabel");

    for i, v in p12 do
        TextLabel[i] = v;
    end;

    TextLabel.Parent = p11;

    return TextLabel;
end;

local function round(p13, p14) -- Line: 84
    local v15 = {
        CornerRadius = UDim.new(0, p14)
    };
    local UICorner = Instance.new("UICorner");

    for i, v in v15 do
        UICorner[i] = v;
    end;

    UICorner.Parent = p13;
end;

local function stroke(p16, p17, p18) -- Line: 87
    local v19 = {
        Color = p17,
        Thickness = p18 or 2,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    };
    local UIStroke = Instance.new("UIStroke");

    for i, v in v19 do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = p16;

    return UIStroke;
end;

local function pct(p20) -- Line: 90
    local math_floor_ret = math.floor(p20 * 100 + 0.5);

    return tostring(math_floor_ret) .. "%";
end;

local function pctLive(p21) -- Line: 94
    return string.format("%.2f%%", p21 * 100);
end;

local function hash(p22) -- Line: 102
    return p22 * 2654435761 % 4294967296;
end;

local function newMap(p23) -- Line: 106
    -- upvalues: Color3_fromRGB_ret (copy), Color3_new_ret (copy), u3 (copy)
    local v24 = {
        Name = "World",
        BackgroundTransparency = 1,
        Image = "rbxassetid://118106301906216",
        ZIndex = 2,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(0.94, 0.94),
        ScaleType = Enum.ScaleType.Fit
    };
    local ImageLabel = Instance.new("ImageLabel");

    for i, v in v24 do
        ImageLabel[i] = v;
    end;

    ImageLabel.Parent = p23;
    local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint");

    for i, v in {
        AspectRatio = 2
    } do
        UIAspectRatioConstraint[i] = v;
    end;

    UIAspectRatioConstraint.Parent = ImageLabel;
    local u25 = {};

    local function spot(p26) -- Line: 119
        -- upvalues: u25 (copy), ImageLabel (copy), Color3_fromRGB_ret (ref), Color3_new_ret (ref)
        local v27 = u25[p26];

        if not v27 then
            local v28 = {
                BackgroundTransparency = 1,
                Image = "rbxassetid://120639974824188",
                ZIndex = 3,
                AnchorPoint = Vector2.new(0.5, 0.5),
                ImageColor3 = Color3_fromRGB_ret
            };
            local ImageLabel2 = Instance.new("ImageLabel");

            for i, v in v28 do
                ImageLabel2[i] = v;
            end;

            ImageLabel2.Parent = ImageLabel;
            local v29 = {
                BorderSizePixel = 0,
                ZIndex = 4,
                AnchorPoint = Vector2.new(0.5, 0.5),
                Size = UDim2.fromScale(0.012, 0.024),
                BackgroundColor3 = Color3_new_ret
            };
            local Frame = Instance.new("Frame");

            for i, v in v29 do
                Frame[i] = v;
            end;

            Frame.Parent = ImageLabel;
            local v30 = {
                CornerRadius = UDim.new(0, 99)
            };
            local UICorner = Instance.new("UICorner");

            for i, v in v30 do
                UICorner[i] = v;
            end;

            UICorner.Parent = Frame;
            v27 = {
                glow = ImageLabel2,
                dot = Frame
            };
            u25[p26] = v27;
        end;

        return v27;
    end;

    local u31 = 0;

    return ImageLabel, function(p32, p33, p34) -- Line: 144, Name: update
        -- upvalues: u3 (ref), spot (copy), u31 (ref), u25 (copy)
        local v35 = 0;
        local v36;

        if p32 > 0 then
            local math_floor_ret = math.floor(p32 * #u3 + 0.5);
            v36 = math.max(1, math_floor_ret);
        else
            v36 = 0;
        end;

        for i = 1, v36 do
            v35 = v35 + 1;
            local v37 = spot(v35);
            local v38 = u3[i];
            local v39 = 0.05 + p32 * 0.07;
            v37.glow.Position = UDim2.fromScale(v38[1], v38[2]);
            v37.glow.Size = UDim2.fromScale(v39, v39 * 2);
            v37.glow.ImageTransparency = 0.35;
            v37.dot.Position = v37.glow.Position;
            v37.dot.BackgroundTransparency = 0.15;
            local dot = v37.dot;
            v37.glow.Visible = true;
            dot.Visible = true;
            local _ = i;
        end;

        for _, v in p33 do
            v35 = v35 + 1;
            local v40 = spot(v35);
            local v41 = v * 2654435761 % 4294967296;
            local v42 = u3[v41 % #u3 + 1];
            local v43 = (math.sin(p34 * 3 + v41 % 7) + 1) / 2 * 0.03 + 0.1;
            v40.glow.Position = UDim2.fromScale(v42[1] + (v41 // 97 % 100 / 100 - 0.5) * 0.04, v42[2] + (v41 // 9973 % 100 / 100 - 0.5) * 0.06);
            v40.glow.Size = UDim2.fromScale(v43, v43 * 2);
            v40.glow.ImageTransparency = 0.05;
            v40.dot.Position = v40.glow.Position;
            v40.dot.BackgroundTransparency = 0;
            local dot = v40.dot;
            v40.glow.Visible = true;
            dot.Visible = true;
        end;

        for i = v35 + 1, u31 do
            local dot = u25[i].dot;
            u25[i].glow.Visible = false;
            dot.Visible = false;
            local _ = i;
        end;

        u31 = math.max(u31, v35);
    end;
end;

local function infectedHere() -- Line: 183
    -- upvalues: Players (copy)
    local v44 = {};

    for _, v in Players:GetPlayers() do
        if v:GetAttribute("OutbreakInfected") == true then
            table.insert(v44, v.UserId);
        end;
    end;

    return v44;
end;

local u45 = {
    gui = nil,
    update = nil,
    label = nil
};

local function standParts() -- Line: 197
    -- upvalues: MapLocator (copy)
    local v46 = MapLocator.interactable("OutbreakEvent");
    local v47;

    if v46 then
        v47 = v46:FindFirstChild("Prompt");
    else
        v47 = v46;
    end;

    if not (v47 and (v47:IsA("BasePart") and v47)) then
        v47 = nil;
    end;

    return v46, v47;
end;

local function buildStand() -- Line: 202
    -- upvalues: MapLocator (copy), u45 (copy), Color3_fromRGB_ret2 (copy), Color3_fromRGB_ret5 (copy), newMap (copy), Color3_fromRGB_ret3 (copy), Color3_fromRGB_ret (copy), Font_new_ret2 (copy), Font_new_ret (copy), Color3_new_ret (copy)
    local v48 = MapLocator.interactable("OutbreakEvent");

    if v48 then
        v48 = v48:FindFirstChild("Prompt");
    end;

    if not (v48 and (v48:IsA("BasePart") and v48)) then
        v48 = nil;
    end;

    if not (v48 and (not u45.gui or u45.gui.Parent ~= v48)) then
        return;
    end;

    if u45.gui then
        u45.gui:Destroy();
    end;

    local v49 = v48:FindFirstChildWhichIsA("Decal");

    if v49 then
        v49.Transparency = 1;
    end;

    local v50 = {
        Name = "OutbreakMap",
        PixelsPerStud = 40,
        LightInfluence = 0,
        MaxDistance = 160,
        Face = Enum.NormalId.Front,
        SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    };
    local SurfaceGui = Instance.new("SurfaceGui");

    for i, v in v50 do
        SurfaceGui[i] = v;
    end;

    SurfaceGui.Parent = v48;
    local v51 = {
        BorderSizePixel = 0,
        Size = UDim2.fromScale(1, 1),
        BackgroundColor3 = Color3_fromRGB_ret2
    };
    local Frame = Instance.new("Frame");

    for i, v in v51 do
        Frame[i] = v;
    end;

    Frame.Parent = SurfaceGui;
    local v52 = {
        Thickness = 6,
        Color = Color3_fromRGB_ret5,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    };
    local UIStroke = Instance.new("UIStroke");

    for i, v in v52 do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = Frame;
    local _, v53 = newMap(Frame);
    local v54 = {
        BackgroundTransparency = 0.1,
        ZIndex = 5,
        AnchorPoint = Vector2.new(0, 1),
        Position = UDim2.new(0, 16, 1, -16),
        Size = UDim2.fromScale(0.42, 0.16),
        BackgroundColor3 = Color3_fromRGB_ret3
    };
    local Frame2 = Instance.new("Frame");

    for i, v in v54 do
        Frame2[i] = v;
    end;

    Frame2.Parent = Frame;
    local v55 = {
        CornerRadius = UDim.new(0, 18)
    };
    local UICorner = Instance.new("UICorner");

    for i, v in v55 do
        UICorner[i] = v;
    end;

    UICorner.Parent = Frame2;
    local v56 = {
        Thickness = 3,
        Color = Color3_fromRGB_ret,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    };
    local UIStroke2 = Instance.new("UIStroke");

    for i, v in v56 do
        UIStroke2[i] = v;
    end;

    UIStroke2.Parent = Frame2;
    local v57 = {
        TextScaled = true,
        Text = "",
        ZIndex = 6,
        Position = UDim2.fromScale(0.06, 0),
        Size = UDim2.fromScale(0.9, 1),
        FontFace = Font_new_ret2,
        TextColor3 = Color3_fromRGB_ret,
        BackgroundTransparency = 1
    };
    v57.FontFace = v57.FontFace or Font_new_ret;
    v57.TextColor3 = v57.TextColor3 or Color3_new_ret;
    v57.TextXAlignment = v57.TextXAlignment or Enum.TextXAlignment.Left;
    local TextLabel = Instance.new("TextLabel");

    for i, v in v57 do
        TextLabel[i] = v;
    end;

    TextLabel.Parent = Frame2;
    u45.gui = SurfaceGui;
    u45.update = v53;
    u45.label = TextLabel;
    local v58 = v48:FindFirstChildWhichIsA("ProximityPrompt", true);

    if v58 then
        v58.ObjectText = "The Outbreak";
    end;
end;

local u59 = nil;
local u60 = {
    kills = 0,
    infected = false,
    claimed = {},
    milestones = {}
};
local u61 = nil;

local function claim(p62, p63) -- Line: 259
    -- upvalues: u61 (ref), u59 (ref)
    if u61 or not u59 then
        return;
    end;

    u61 = p62 .. ":" .. tostring(p63);
    u59:FireServer("Claim", p62, p63);
    task.delay(8, function() -- Line: 265
        -- upvalues: u61 (ref)
        u61 = nil;
    end);
end;

local function claimButton(p64, p65, p66) -- Line: 270
    -- upvalues: Color3_fromRGB_ret (copy), Font_new_ret2 (copy), Color3_fromRGB_ret2 (copy)
    p65.BackgroundColor3 = Color3_fromRGB_ret;
    p65.FontFace = Font_new_ret2;
    p65.Text = "CLAIM";
    p65.TextSize = 20;
    p65.TextColor3 = Color3_fromRGB_ret2;
    p65.Visible = false;
    p65.ZIndex = 4;
    p65.AutoButtonColor = true;
    local TextButton = Instance.new("TextButton");

    for i, v in p65 do
        TextButton[i] = v;
    end;

    TextButton.Parent = p64;
    local v67 = {
        CornerRadius = UDim.new(0, 12)
    };
    local UICorner = Instance.new("UICorner");

    for i, v in v67 do
        UICorner[i] = v;
    end;

    UICorner.Parent = TextButton;
    TextButton.Activated:Connect(p66);

    return TextButton;
end;

local u68 = nil;

local function rewardIcon(p69) -- Line: 287
    -- upvalues: CrateCatalog (copy)
    local reward = p69.reward;

    if reward.candy then
        return "rbxassetid://119759573303359";
    end;

    if reward.coins then
        return "rbxassetid://78008558948307";
    end;

    if not (reward.crate or reward.crates) then
        return "rbxassetid://131836773879206";
    end;

    local v70 = CrateCatalog.get(reward.crate or reward.crates[1]);

    return v70 and v70.Icon or "rbxassetid://131836773879206";
end;

local function close() -- Line: 300
    -- upvalues: u68 (ref), LocalPlayer (copy)
    if u68 and u68.gui.Enabled then
        u68.gui.Enabled = false;
        LocalPlayer:SetAttribute("OutbreakOpen", nil);
    end;
end;

local function buildWindow() -- Line: 307
    -- upvalues: PlayerGui (copy), Color3_fromRGB_ret3 (copy), Color3_fromRGB_ret5 (copy), Color3_fromRGB_ret (copy), Color3_fromRGB_ret2 (copy), Font_new_ret2 (copy), Font_new_ret (copy), Color3_new_ret (copy), Color3_fromRGB_ret6 (copy), Color3_fromRGB_ret4 (copy), newMap (copy), OutbreakConfig (copy), claim (copy), CrateCatalog (copy), close (copy), u68 (ref)
    local v71 = {
        Name = "Outbreak",
        ResetOnSpawn = false,
        IgnoreGuiInset = true,
        DisplayOrder = 74,
        Enabled = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    };
    local ScreenGui = Instance.new("ScreenGui");

    for i, v in v71 do
        ScreenGui[i] = v;
    end;

    ScreenGui.Parent = PlayerGui;
    ScreenGui:SetAttribute("SelfManagedText", true);
    local v72 = {
        Name = "Shade",
        BackgroundTransparency = 0.45,
        Text = "",
        AutoButtonColor = false,
        Size = UDim2.fromScale(1, 1),
        BackgroundColor3 = Color3.new(0, 0, 0)
    };
    local TextButton = Instance.new("TextButton");

    for i, v in v72 do
        TextButton[i] = v;
    end;

    TextButton.Parent = ScreenGui;
    local v73 = {
        Active = true,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromOffset(1700, 990),
        BackgroundColor3 = Color3_fromRGB_ret3
    };
    local Frame = Instance.new("Frame");

    for i, v in v73 do
        Frame[i] = v;
    end;

    Frame.Parent = TextButton;
    local v74 = {
        CornerRadius = UDim.new(0, 40)
    };
    local UICorner = Instance.new("UICorner");

    for i, v in v74 do
        UICorner[i] = v;
    end;

    UICorner.Parent = Frame;
    local v75 = {
        Thickness = 3,
        Color = Color3_fromRGB_ret5,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    };
    local UIStroke = Instance.new("UIStroke");

    for i, v in v75 do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = Frame;
    local UIScale = Instance.new("UIScale");

    for i, v in {} do
        UIScale[i] = v;
    end;

    UIScale.Parent = Frame;
    local v76 = {
        Position = UDim2.fromOffset(40, 32),
        Size = UDim2.fromOffset(70, 70),
        BackgroundColor3 = Color3_fromRGB_ret
    };
    local Frame2 = Instance.new("Frame");

    for i, v in v76 do
        Frame2[i] = v;
    end;

    Frame2.Parent = Frame;
    local v77 = {
        CornerRadius = UDim.new(0, 16)
    };
    local UICorner2 = Instance.new("UICorner");

    for i, v in v77 do
        UICorner2[i] = v;
    end;

    UICorner2.Parent = Frame2;
    local v78 = {
        BackgroundTransparency = 1,
        Image = "rbxassetid://131836773879206",
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(0.68, 0.68),
        ImageColor3 = Color3_fromRGB_ret2
    };
    local ImageLabel = Instance.new("ImageLabel");

    for i, v in v78 do
        ImageLabel[i] = v;
    end;

    ImageLabel.Parent = Frame2;
    local v79 = {
        TextSize = 52,
        Text = "THE OUTBREAK",
        Position = UDim2.fromOffset(128, 26),
        Size = UDim2.fromOffset(900, 56),
        FontFace = Font_new_ret2,
        BackgroundTransparency = 1
    };
    v79.FontFace = v79.FontFace or Font_new_ret;
    v79.TextColor3 = v79.TextColor3 or Color3_new_ret;
    v79.TextXAlignment = v79.TextXAlignment or Enum.TextXAlignment.Left;
    local TextLabel = Instance.new("TextLabel");

    for i, v in v79 do
        TextLabel[i] = v;
    end;

    TextLabel.Parent = Frame;
    local v80 = {
        TextSize = 24,
        Text = "The Infected Knife is spreading across Valley Run",
        Position = UDim2.fromOffset(128, 84),
        Size = UDim2.fromOffset(900, 30),
        TextColor3 = Color3_fromRGB_ret6,
        BackgroundTransparency = 1
    };
    v80.FontFace = v80.FontFace or Font_new_ret;
    v80.TextColor3 = v80.TextColor3 or Color3_new_ret;
    v80.TextXAlignment = v80.TextXAlignment or Enum.TextXAlignment.Left;
    local TextLabel2 = Instance.new("TextLabel");

    for i, v in v80 do
        TextLabel2[i] = v;
    end;

    TextLabel2.Parent = Frame;
    local v81 = {
        Text = "X",
        TextSize = 34,
        Position = UDim2.fromOffset(1588, 34),
        Size = UDim2.fromOffset(68, 68),
        BackgroundColor3 = Color3_fromRGB_ret4,
        FontFace = Font_new_ret2,
        TextColor3 = Color3_new_ret
    };
    local TextButton2 = Instance.new("TextButton");

    for i, v in v81 do
        TextButton2[i] = v;
    end;

    TextButton2.Parent = Frame;
    local v82 = {
        CornerRadius = UDim.new(0, 16)
    };
    local UICorner3 = Instance.new("UICorner");

    for i, v in v82 do
        UICorner3[i] = v;
    end;

    UICorner3.Parent = TextButton2;
    local v83 = {
        Thickness = 2,
        Color = Color3_fromRGB_ret5,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    };
    local UIStroke2 = Instance.new("UIStroke");

    for i, v in v83 do
        UIStroke2[i] = v;
    end;

    UIStroke2.Parent = TextButton2;
    local v84 = {
        Position = UDim2.fromOffset(40, 140),
        Size = UDim2.fromOffset(780, 470),
        BackgroundColor3 = Color3_fromRGB_ret2
    };
    local Frame3 = Instance.new("Frame");

    for i, v in v84 do
        Frame3[i] = v;
    end;

    Frame3.Parent = Frame;
    local v85 = {
        CornerRadius = UDim.new(0, 26)
    };
    local UICorner4 = Instance.new("UICorner");

    for i, v in v85 do
        UICorner4[i] = v;
    end;

    UICorner4.Parent = Frame3;
    local v86 = {
        Thickness = 2,
        Color = Color3_fromRGB_ret5,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    };
    local UIStroke3 = Instance.new("UIStroke");

    for i, v in v86 do
        UIStroke3[i] = v;
    end;

    UIStroke3.Parent = Frame3;
    local _, v87 = newMap(Frame3);
    local v88 = {
        ZIndex = 5,
        Position = UDim2.new(0, 18, 1, -58),
        Size = UDim2.fromOffset(200, 40),
        BackgroundColor3 = Color3_fromRGB_ret4
    };
    local Frame4 = Instance.new("Frame");

    for i, v in v88 do
        Frame4[i] = v;
    end;

    Frame4.Parent = Frame3;
    local v89 = {
        CornerRadius = UDim.new(0, 99)
    };
    local UICorner5 = Instance.new("UICorner");

    for i, v in v89 do
        UICorner5[i] = v;
    end;

    UICorner5.Parent = Frame4;
    local v90 = {
        ZIndex = 6,
        Position = UDim2.fromOffset(14, 13),
        Size = UDim2.fromOffset(14, 14),
        BackgroundColor3 = Color3_fromRGB_ret
    };
    local Frame5 = Instance.new("Frame");

    for i, v in v90 do
        Frame5[i] = v;
    end;

    Frame5.Parent = Frame4;
    local v91 = {
        CornerRadius = UDim.new(0, 99)
    };
    local UICorner6 = Instance.new("UICorner");

    for i, v in v91 do
        UICorner6[i] = v;
    end;

    UICorner6.Parent = Frame5;
    local v92 = {
        TextSize = 19,
        Text = "Infected players",
        ZIndex = 6,
        Position = UDim2.fromOffset(38, 0),
        Size = UDim2.fromOffset(160, 40),
        BackgroundTransparency = 1
    };
    v92.FontFace = v92.FontFace or Font_new_ret;
    v92.TextColor3 = v92.TextColor3 or Color3_new_ret;
    v92.TextXAlignment = v92.TextXAlignment or Enum.TextXAlignment.Left;
    local TextLabel3 = Instance.new("TextLabel");

    for i, v in v92 do
        TextLabel3[i] = v;
    end;

    TextLabel3.Parent = Frame4;
    local v93 = {
        TextSize = 30,
        Text = "Global infection",
        Position = UDim2.fromOffset(40, 628),
        Size = UDim2.fromOffset(400, 36),
        FontFace = Font_new_ret2,
        BackgroundTransparency = 1
    };
    v93.FontFace = v93.FontFace or Font_new_ret;
    v93.TextColor3 = v93.TextColor3 or Color3_new_ret;
    v93.TextXAlignment = v93.TextXAlignment or Enum.TextXAlignment.Left;
    local TextLabel4 = Instance.new("TextLabel");

    for i, v in v93 do
        TextLabel4[i] = v;
    end;

    TextLabel4.Parent = Frame;
    local v94 = {
        TextSize = 22,
        Text = "",
        Position = UDim2.fromOffset(420, 628),
        Size = UDim2.fromOffset(400, 36),
        TextColor3 = Color3_fromRGB_ret6,
        TextXAlignment = Enum.TextXAlignment.Right,
        BackgroundTransparency = 1
    };
    v94.FontFace = v94.FontFace or Font_new_ret;
    v94.TextColor3 = v94.TextColor3 or Color3_new_ret;
    v94.TextXAlignment = v94.TextXAlignment or Enum.TextXAlignment.Left;
    local TextLabel5 = Instance.new("TextLabel");

    for i, v in v94 do
        TextLabel5[i] = v;
    end;

    TextLabel5.Parent = Frame;
    local v95 = {
        Position = UDim2.fromOffset(40, 674),
        Size = UDim2.fromOffset(780, 36),
        BackgroundColor3 = Color3_fromRGB_ret2
    };
    local Frame6 = Instance.new("Frame");

    for i, v in v95 do
        Frame6[i] = v;
    end;

    Frame6.Parent = Frame;
    local v96 = {
        CornerRadius = UDim.new(0, 99)
    };
    local UICorner7 = Instance.new("UICorner");

    for i, v in v96 do
        UICorner7[i] = v;
    end;

    UICorner7.Parent = Frame6;
    local v97 = {
        Thickness = 2,
        Color = Color3_fromRGB_ret5,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    };
    local UIStroke4 = Instance.new("UIStroke");

    for i, v in v97 do
        UIStroke4[i] = v;
    end;

    UIStroke4.Parent = Frame6;
    local v98 = {
        BorderSizePixel = 0,
        Size = UDim2.fromScale(0, 1),
        BackgroundColor3 = Color3_fromRGB_ret
    };
    local Frame7 = Instance.new("Frame");

    for i, v in v98 do
        Frame7[i] = v;
    end;

    Frame7.Parent = Frame6;
    local v99 = {
        CornerRadius = UDim.new(0, 99)
    };
    local UICorner8 = Instance.new("UICorner");

    for i, v in v99 do
        UICorner8[i] = v;
    end;

    UICorner8.Parent = Frame7;
    local v100 = {};

    for i, v in OutbreakConfig.Milestones do
        local at = v.at;
        local v101, u102;

        if v.at < 1 then
            local v103 = {
                BorderSizePixel = 0,
                ZIndex = 3,
                AnchorPoint = Vector2.new(0.5, 0),
                Position = UDim2.fromScale(at, 0),
                Size = UDim2.new(0, 4, 1, 0),
                BackgroundColor3 = Color3_fromRGB_ret2
            };
            local Frame8 = Instance.new("Frame");
            v101 = i;
            u102 = v;

            for i2, v2 in v103 do
                Frame8[i2] = v2;
            end;

            Frame8.Parent = Frame6;
        else
            v101 = i;
            u102 = v;
        end;

        local v104 = {
            TextSize = 21,
            AnchorPoint = Vector2.new(0.5, 0),
            Position = UDim2.fromOffset(40 + 780 * at - (u102.at >= 1 and 30 or 0), 716),
            Size = UDim2.fromOffset(100, 28),
            TextXAlignment = Enum.TextXAlignment.Center
        };
        local math_floor_ret = math.floor(u102.at * 100 + 0.5);
        v104.Text = tostring(math_floor_ret) .. "%";
        v104.BackgroundTransparency = 1;
        v104.FontFace = v104.FontFace or Font_new_ret;
        v104.TextColor3 = v104.TextColor3 or Color3_new_ret;
        v104.TextXAlignment = v104.TextXAlignment or Enum.TextXAlignment.Left;
        local TextLabel6 = Instance.new("TextLabel");

        for i2, v2 in v104 do
            TextLabel6[i2] = v2;
        end;

        TextLabel6.Parent = Frame;
        local v105 = {
            Position = UDim2.fromOffset(40 + (v101 - 1) * 198, 760),
            Size = UDim2.fromOffset(186, 150),
            BackgroundColor3 = Color3_fromRGB_ret4
        };
        local Frame8 = Instance.new("Frame");

        for i2, v2 in v105 do
            Frame8[i2] = v2;
        end;

        Frame8.Parent = Frame;
        local v106 = {
            CornerRadius = UDim.new(0, 20)
        };
        local UICorner9 = Instance.new("UICorner");

        for i2, v2 in v106 do
            UICorner9[i2] = v2;
        end;

        UICorner9.Parent = Frame8;
        local v107 = {
            Thickness = 2,
            Color = Color3_fromRGB_ret5,
            ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        };
        local UIStroke5 = Instance.new("UIStroke");

        for i2, v2 in v107 do
            UIStroke5[i2] = v2;
        end;

        UIStroke5.Parent = Frame8;
        local v108 = {
            Position = UDim2.fromOffset(14, 14),
            Size = UDim2.fromOffset(66, 30),
            BackgroundColor3 = Color3_fromRGB_ret
        };
        local Frame9 = Instance.new("Frame");

        for i2, v2 in v108 do
            Frame9[i2] = v2;
        end;

        Frame9.Parent = Frame8;
        local v109 = {
            CornerRadius = UDim.new(0, 99)
        };
        local UICorner10 = Instance.new("UICorner");

        for i2, v2 in v109 do
            UICorner10[i2] = v2;
        end;

        UICorner10.Parent = Frame9;
        local v110 = {
            TextSize = 18,
            Size = UDim2.fromScale(1, 1),
            FontFace = Font_new_ret2,
            TextColor3 = Color3_fromRGB_ret2,
            TextXAlignment = Enum.TextXAlignment.Center
        };
        local math_floor_ret2 = math.floor(u102.at * 100 + 0.5);
        v110.Text = tostring(math_floor_ret2) .. "%";
        v110.BackgroundTransparency = 1;
        v110.FontFace = v110.FontFace or Font_new_ret;
        v110.TextColor3 = v110.TextColor3 or Color3_new_ret;
        v110.TextXAlignment = v110.TextXAlignment or Enum.TextXAlignment.Left;
        local TextLabel7 = Instance.new("TextLabel");

        for i2, v2 in v110 do
            TextLabel7[i2] = v2;
        end;

        TextLabel7.Parent = Frame9;
        local v111 = {
            TextSize = 26,
            Text = "",
            Position = UDim2.fromOffset(140, 12),
            Size = UDim2.fromOffset(34, 34),
            FontFace = Font_new_ret2,
            TextColor3 = Color3_fromRGB_ret,
            TextXAlignment = Enum.TextXAlignment.Center,
            BackgroundTransparency = 1
        };
        v111.FontFace = v111.FontFace or Font_new_ret;
        v111.TextColor3 = v111.TextColor3 or Color3_new_ret;
        v111.TextXAlignment = v111.TextXAlignment or Enum.TextXAlignment.Left;
        local TextLabel8 = Instance.new("TextLabel");

        for i2, v2 in v111 do
            TextLabel8[i2] = v2;
        end;

        TextLabel8.Parent = Frame8;
        local v112 = {
            TextSize = 22,
            TextWrapped = true,
            Position = UDim2.fromOffset(14, 52),
            Size = UDim2.fromOffset(160, 50),
            FontFace = Font_new_ret2,
            TextYAlignment = Enum.TextYAlignment.Top,
            Text = u102.name,
            BackgroundTransparency = 1
        };
        v112.FontFace = v112.FontFace or Font_new_ret;
        v112.TextColor3 = v112.TextColor3 or Color3_new_ret;
        v112.TextXAlignment = v112.TextXAlignment or Enum.TextXAlignment.Left;
        local TextLabel9 = Instance.new("TextLabel");

        for i2, v2 in v112 do
            TextLabel9[i2] = v2;
        end;

        TextLabel9.Parent = Frame8;
        local v113 = {
            TextSize = 16,
            TextWrapped = true,
            Position = UDim2.fromOffset(14, 104),
            Size = UDim2.fromOffset(160, 40),
            TextColor3 = Color3_fromRGB_ret6,
            TextYAlignment = Enum.TextYAlignment.Top,
            Text = u102.detail,
            BackgroundTransparency = 1
        };
        v113.FontFace = v113.FontFace or Font_new_ret;
        v113.TextColor3 = v113.TextColor3 or Color3_new_ret;
        v113.TextXAlignment = v113.TextXAlignment or Enum.TextXAlignment.Left;
        local TextLabel10 = Instance.new("TextLabel");

        for i2, v2 in v113 do
            TextLabel10[i2] = v2;
        end;

        TextLabel10.Parent = Frame8;
        local reward = u102.reward;

        if reward then
            local v114 = {
                Position = UDim2.fromOffset(14, 104),
                Size = UDim2.fromOffset(158, 34)
            };

            local function v115() -- Line: 422
                -- upvalues: claim (ref), u102 (copy)
                claim("Milestone", u102.id);
            end;

            v114.BackgroundColor3 = Color3_fromRGB_ret;
            v114.FontFace = Font_new_ret2;
            v114.Text = "CLAIM";
            v114.TextSize = 20;
            v114.TextColor3 = Color3_fromRGB_ret2;
            v114.Visible = false;
            v114.ZIndex = 4;
            v114.AutoButtonColor = true;
            reward = Instance.new("TextButton");

            for i2, v2 in v114 do
                reward[i2] = v2;
            end;

            reward.Parent = Frame8;
            local v116 = {
                CornerRadius = UDim.new(0, 12)
            };
            local UICorner11 = Instance.new("UICorner");

            for i2, v2 in v116 do
                UICorner11[i2] = v2;
            end;

            UICorner11.Parent = reward;
            reward.Activated:Connect(v115);
        end;

        v100[v101] = {
            card = Frame8,
            stroke = UIStroke5,
            mark = TextLabel8,
            chip = Frame9,
            detail = TextLabel10,
            button = reward
        };
    end;

    local v117 = {
        TextSize = 160,
        TextScaled = true,
        Text = "0.00%",
        Position = UDim2.fromOffset(860, 120),
        Size = UDim2.fromOffset(500, 170),
        FontFace = Font_new_ret2,
        TextColor3 = Color3_fromRGB_ret,
        BackgroundTransparency = 1
    };
    v117.FontFace = v117.FontFace or Font_new_ret;
    v117.TextColor3 = v117.TextColor3 or Color3_new_ret;
    v117.TextXAlignment = v117.TextXAlignment or Enum.TextXAlignment.Left;
    local TextLabel6 = Instance.new("TextLabel");

    for i, v in v117 do
        TextLabel6[i] = v;
    end;

    TextLabel6.Parent = Frame;
    local v118 = {
        TextSize = 26,
        Text = "of Valley Run infected",
        Position = UDim2.fromOffset(864, 286),
        Size = UDim2.fromOffset(500, 34),
        TextColor3 = Color3_fromRGB_ret6,
        BackgroundTransparency = 1
    };
    v118.FontFace = v118.FontFace or Font_new_ret;
    v118.TextColor3 = v118.TextColor3 or Color3_new_ret;
    v118.TextXAlignment = v118.TextXAlignment or Enum.TextXAlignment.Left;
    local TextLabel7 = Instance.new("TextLabel");

    for i, v in v118 do
        TextLabel7[i] = v;
    end;

    TextLabel7.Parent = Frame;
    local v119 = {
        Position = UDim2.fromOffset(1340, 224),
        Size = UDim2.fromOffset(320, 68),
        BackgroundColor3 = Color3_fromRGB_ret4
    };
    local Frame8 = Instance.new("Frame");

    for i, v in v119 do
        Frame8[i] = v;
    end;

    Frame8.Parent = Frame;
    local v120 = {
        CornerRadius = UDim.new(0, 22)
    };
    local UICorner9 = Instance.new("UICorner");

    for i, v in v120 do
        UICorner9[i] = v;
    end;

    UICorner9.Parent = Frame8;
    local v121 = {
        Thickness = 3,
        Color = Color3_fromRGB_ret,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    };
    local UIStroke5 = Instance.new("UIStroke");

    for i, v in v121 do
        UIStroke5[i] = v;
    end;

    UIStroke5.Parent = Frame8;
    local v122 = {
        BackgroundTransparency = 1,
        Image = "rbxassetid://131836773879206",
        Position = UDim2.fromOffset(22, 17),
        Size = UDim2.fromOffset(34, 34),
        ImageColor3 = Color3_fromRGB_ret
    };
    local ImageLabel2 = Instance.new("ImageLabel");

    for i, v in v122 do
        ImageLabel2[i] = v;
    end;

    ImageLabel2.Parent = Frame8;
    local v123 = {
        TextSize = 24,
        Text = "",
        Position = UDim2.fromOffset(66, 0),
        Size = UDim2.fromOffset(240, 68),
        FontFace = Font_new_ret2,
        TextColor3 = Color3_fromRGB_ret,
        BackgroundTransparency = 1
    };
    v123.FontFace = v123.FontFace or Font_new_ret;
    v123.TextColor3 = v123.TextColor3 or Color3_new_ret;
    v123.TextXAlignment = v123.TextXAlignment or Enum.TextXAlignment.Left;
    local TextLabel8 = Instance.new("TextLabel");

    for i, v in v123 do
        TextLabel8[i] = v;
    end;

    TextLabel8.Parent = Frame8;
    local v124 = {
        Position = UDim2.fromOffset(860, 340),
        Size = UDim2.fromOffset(800, 610),
        BackgroundColor3 = Color3.fromRGB(19, 25, 21)
    };
    local Frame9 = Instance.new("Frame");

    for i, v in v124 do
        Frame9[i] = v;
    end;

    Frame9.Parent = Frame;
    local v125 = {
        CornerRadius = UDim.new(0, 30)
    };
    local UICorner10 = Instance.new("UICorner");

    for i, v in v125 do
        UICorner10[i] = v;
    end;

    UICorner10.Parent = Frame9;
    local v126 = {
        Thickness = 2,
        Color = Color3_fromRGB_ret5,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    };
    local UIStroke6 = Instance.new("UIStroke");

    for i, v in v126 do
        UIStroke6[i] = v;
    end;

    UIStroke6.Parent = Frame9;
    local v127 = {
        TextSize = 36,
        Text = "YOUR SPREAD",
        Position = UDim2.fromOffset(30, 26),
        Size = UDim2.fromOffset(500, 44),
        FontFace = Font_new_ret2,
        BackgroundTransparency = 1
    };
    v127.FontFace = v127.FontFace or Font_new_ret;
    v127.TextColor3 = v127.TextColor3 or Color3_new_ret;
    v127.TextXAlignment = v127.TextXAlignment or Enum.TextXAlignment.Left;
    local TextLabel9 = Instance.new("TextLabel");

    for i, v in v127 do
        TextLabel9[i] = v;
    end;

    TextLabel9.Parent = Frame9;
    local v128 = {
        TextSize = 20,
        Text = "Catch players with the Infected Knife to earn rewards",
        Position = UDim2.fromOffset(30, 74),
        Size = UDim2.fromOffset(560, 30),
        TextColor3 = Color3_fromRGB_ret6,
        BackgroundTransparency = 1
    };
    v128.FontFace = v128.FontFace or Font_new_ret;
    v128.TextColor3 = v128.TextColor3 or Color3_new_ret;
    v128.TextXAlignment = v128.TextXAlignment or Enum.TextXAlignment.Left;
    local TextLabel10 = Instance.new("TextLabel");

    for i, v in v128 do
        TextLabel10[i] = v;
    end;

    TextLabel10.Parent = Frame9;
    local v129 = {
        TextSize = 70,
        Text = "0",
        Position = UDim2.fromOffset(560, 16),
        Size = UDim2.fromOffset(110, 80),
        FontFace = Font_new_ret2,
        TextColor3 = Color3_fromRGB_ret,
        TextXAlignment = Enum.TextXAlignment.Right,
        BackgroundTransparency = 1
    };
    v129.FontFace = v129.FontFace or Font_new_ret;
    v129.TextColor3 = v129.TextColor3 or Color3_new_ret;
    v129.TextXAlignment = v129.TextXAlignment or Enum.TextXAlignment.Left;
    local TextLabel11 = Instance.new("TextLabel");

    for i, v in v129 do
        TextLabel11[i] = v;
    end;

    TextLabel11.Parent = Frame9;
    local v130 = {
        TextSize = 22,
        Text = "infected",
        Position = UDim2.fromOffset(678, 50),
        Size = UDim2.fromOffset(110, 34),
        BackgroundTransparency = 1
    };
    v130.FontFace = v130.FontFace or Font_new_ret;
    v130.TextColor3 = v130.TextColor3 or Color3_new_ret;
    v130.TextXAlignment = v130.TextXAlignment or Enum.TextXAlignment.Left;
    local TextLabel12 = Instance.new("TextLabel");

    for i, v in v130 do
        TextLabel12[i] = v;
    end;

    TextLabel12.Parent = Frame9;
    local Tiers = OutbreakConfig.Tiers;
    local v131 = {
        Position = UDim2.fromOffset(30, 126),
        Size = UDim2.fromOffset(740, 36),
        BackgroundColor3 = Color3_fromRGB_ret2
    };
    local Frame10 = Instance.new("Frame");

    for i, v in v131 do
        Frame10[i] = v;
    end;

    Frame10.Parent = Frame9;
    local v132 = {
        CornerRadius = UDim.new(0, 99)
    };
    local UICorner11 = Instance.new("UICorner");

    for i, v in v132 do
        UICorner11[i] = v;
    end;

    UICorner11.Parent = Frame10;
    local v133 = {
        Thickness = 2,
        Color = Color3_fromRGB_ret5,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    };
    local UIStroke7 = Instance.new("UIStroke");

    for i, v in v133 do
        UIStroke7[i] = v;
    end;

    UIStroke7.Parent = Frame10;
    local v134 = {
        BorderSizePixel = 0,
        Size = UDim2.fromScale(0, 1),
        BackgroundColor3 = Color3_fromRGB_ret
    };
    local Frame11 = Instance.new("Frame");

    for i, v in v134 do
        Frame11[i] = v;
    end;

    Frame11.Parent = Frame10;
    local v135 = {
        CornerRadius = UDim.new(0, 99)
    };
    local UICorner12 = Instance.new("UICorner");

    for i, v in v135 do
        UICorner12[i] = v;
    end;

    UICorner12.Parent = Frame11;
    local v136 = {};

    for i, v in Tiers do
        local v137 = i / #Tiers;
        local v138, u139;

        if i < #Tiers then
            local v140 = {
                BorderSizePixel = 0,
                ZIndex = 3,
                AnchorPoint = Vector2.new(0.5, 0),
                Position = UDim2.fromScale(v137, 0),
                Size = UDim2.new(0, 4, 1, 0),
                BackgroundColor3 = Color3_fromRGB_ret2
            };
            local Frame12 = Instance.new("Frame");
            v138 = v;
            u139 = i;

            for i2, v2 in v140 do
                Frame12[i2] = v2;
            end;

            Frame12.Parent = Frame10;
        else
            v138 = v;
            u139 = i;
        end;

        local v141 = {
            TextSize = 21,
            AnchorPoint = Vector2.new(0.5, 0),
            Position = UDim2.fromOffset(30 + 740 * v137 - (u139 == #Tiers and 18 or 0), 170),
            Size = UDim2.fromOffset(60, 28),
            TextXAlignment = Enum.TextXAlignment.Center,
            Text = tostring(v138.kills),
            BackgroundTransparency = 1
        };
        v141.FontFace = v141.FontFace or Font_new_ret;
        v141.TextColor3 = v141.TextColor3 or Color3_new_ret;
        v141.TextXAlignment = v141.TextXAlignment or Enum.TextXAlignment.Left;
        local TextLabel13 = Instance.new("TextLabel");

        for i2, v2 in v141 do
            TextLabel13[i2] = v2;
        end;

        TextLabel13.Parent = Frame9;
        local v142 = {
            Position = UDim2.fromOffset(30 + (u139 - 1) * 150, 214),
            Size = UDim2.fromOffset(140, 186),
            BackgroundColor3 = Color3_fromRGB_ret4
        };
        local Frame12 = Instance.new("Frame");

        for i2, v2 in v142 do
            Frame12[i2] = v2;
        end;

        Frame12.Parent = Frame9;
        local v143 = {
            CornerRadius = UDim.new(0, 20)
        };
        local UICorner13 = Instance.new("UICorner");

        for i2, v2 in v143 do
            UICorner13[i2] = v2;
        end;

        UICorner13.Parent = Frame12;
        local v144 = {
            Thickness = 2,
            Color = Color3_fromRGB_ret5,
            ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        };
        local UIStroke8 = Instance.new("UIStroke");

        for i2, v2 in v144 do
            UIStroke8[i2] = v2;
        end;

        UIStroke8.Parent = Frame12;
        local v145 = {
            AnchorPoint = Vector2.new(0.5, 0),
            Position = UDim2.new(0.5, 0, 0, 16),
            Size = UDim2.fromOffset(62, 62),
            BackgroundColor3 = Color3_fromRGB_ret
        };
        local Frame13 = Instance.new("Frame");

        for i2, v2 in v145 do
            Frame13[i2] = v2;
        end;

        Frame13.Parent = Frame12;
        local v146 = {
            CornerRadius = UDim.new(0, 16)
        };
        local UICorner14 = Instance.new("UICorner");

        for i2, v2 in v146 do
            UICorner14[i2] = v2;
        end;

        UICorner14.Parent = Frame13;
        local v147 = {
            BackgroundTransparency = 1,
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromScale(0.5, 0.5),
            Size = UDim2.fromScale(0.72, 0.72)
        };
        local reward = v138.reward;
        local v148;

        if reward.candy then
            v148 = "rbxassetid://119759573303359";
        elseif reward.coins then
            v148 = "rbxassetid://78008558948307";
        elseif reward.crate or reward.crates then
            local v149 = CrateCatalog.get(reward.crate or reward.crates[1]);
            v148 = v149 and v149.Icon or "rbxassetid://131836773879206";
        else
            v148 = "rbxassetid://131836773879206";
        end;

        v147.Image = v148;
        local v150;

        if v138.reward.title then
            v150 = Color3_fromRGB_ret2;
        else
            v150 = Color3_new_ret;
        end;

        v147.ImageColor3 = v150;
        v147.ScaleType = Enum.ScaleType.Fit;
        local ImageLabel3 = Instance.new("ImageLabel");

        for i2, v2 in v147 do
            ImageLabel3[i2] = v2;
        end;

        ImageLabel3.Parent = Frame13;
        local v151 = {
            TextSize = 19,
            TextWrapped = true,
            Position = UDim2.fromOffset(8, 86),
            Size = UDim2.fromOffset(124, 54),
            FontFace = Font_new_ret2,
            TextXAlignment = Enum.TextXAlignment.Center,
            Text = v138.name,
            BackgroundTransparency = 1
        };
        v151.FontFace = v151.FontFace or Font_new_ret;
        v151.TextColor3 = v151.TextColor3 or Color3_new_ret;
        v151.TextXAlignment = v151.TextXAlignment or Enum.TextXAlignment.Left;
        local TextLabel14 = Instance.new("TextLabel");

        for i2, v2 in v151 do
            TextLabel14[i2] = v2;
        end;

        TextLabel14.Parent = Frame12;
        local v152 = {
            TextSize = 18,
            Text = "",
            Position = UDim2.fromOffset(8, 146),
            Size = UDim2.fromOffset(124, 28),
            TextXAlignment = Enum.TextXAlignment.Center,
            BackgroundTransparency = 1
        };
        v152.FontFace = v152.FontFace or Font_new_ret;
        v152.TextColor3 = v152.TextColor3 or Color3_new_ret;
        v152.TextXAlignment = v152.TextXAlignment or Enum.TextXAlignment.Left;
        local TextLabel15 = Instance.new("TextLabel");

        for i2, v2 in v152 do
            TextLabel15[i2] = v2;
        end;

        TextLabel15.Parent = Frame12;
        local v153 = {
            Position = UDim2.fromOffset(12, 142),
            Size = UDim2.fromOffset(116, 34)
        };

        local function v154() -- Line: 478
            -- upvalues: claim (ref), u139 (copy)
            claim("Tier", u139);
        end;

        v153.BackgroundColor3 = Color3_fromRGB_ret;
        v153.FontFace = Font_new_ret2;
        v153.Text = "CLAIM";
        v153.TextSize = 20;
        v153.TextColor3 = Color3_fromRGB_ret2;
        v153.Visible = false;
        v153.ZIndex = 4;
        v153.AutoButtonColor = true;
        local TextButton3 = Instance.new("TextButton");

        for i2, v2 in v153 do
            TextButton3[i2] = v2;
        end;

        TextButton3.Parent = Frame12;
        local v155 = {
            CornerRadius = UDim.new(0, 12)
        };
        local UICorner15 = Instance.new("UICorner");

        for i2, v2 in v155 do
            UICorner15[i2] = v2;
        end;

        UICorner15.Parent = TextButton3;
        TextButton3.Activated:Connect(v154);
        v136[u139] = {
            stroke = UIStroke8,
            status = TextLabel15,
            card = Frame12,
            button = TextButton3
        };
    end;

    local v156 = {
        Position = UDim2.fromOffset(30, 424),
        Size = UDim2.fromOffset(740, 64),
        BackgroundColor3 = Color3.fromRGB(19, 25, 21)
    };
    local Frame12 = Instance.new("Frame");

    for i, v in v156 do
        Frame12[i] = v;
    end;

    Frame12.Parent = Frame9;
    local v157 = {
        CornerRadius = UDim.new(0, 18)
    };
    local UICorner13 = Instance.new("UICorner");

    for i, v in v157 do
        UICorner13[i] = v;
    end;

    UICorner13.Parent = Frame12;
    local v158 = {
        Thickness = 2,
        Color = Color3_fromRGB_ret5,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    };
    local UIStroke8 = Instance.new("UIStroke");

    for i, v in v158 do
        UIStroke8[i] = v;
    end;

    UIStroke8.Parent = Frame12;
    local v159 = {
        TextSize = 22,
        Text = "",
        Position = UDim2.fromOffset(24, 0),
        Size = UDim2.fromOffset(700, 64),
        FontFace = Font_new_ret2,
        BackgroundTransparency = 1
    };
    v159.FontFace = v159.FontFace or Font_new_ret;
    v159.TextColor3 = v159.TextColor3 or Color3_new_ret;
    v159.TextXAlignment = v159.TextXAlignment or Enum.TextXAlignment.Left;
    local TextLabel13 = Instance.new("TextLabel");

    for i, v in v159 do
        TextLabel13[i] = v;
    end;

    TextLabel13.Parent = Frame12;
    local v160 = {
        TextSize = 19,
        Text = "",
        Position = UDim2.fromOffset(30, 510),
        Size = UDim2.fromOffset(740, 30),
        TextColor3 = Color3_fromRGB_ret6,
        BackgroundTransparency = 1
    };
    v160.FontFace = v160.FontFace or Font_new_ret;
    v160.TextColor3 = v160.TextColor3 or Color3_new_ret;
    v160.TextXAlignment = v160.TextXAlignment or Enum.TextXAlignment.Left;
    local TextLabel14 = Instance.new("TextLabel");

    for i, v in v160 do
        TextLabel14[i] = v;
    end;

    TextLabel14.Parent = Frame9;
    TextButton2.Activated:Connect(close);
    TextButton.Activated:Connect(close);
    u68 = {
        gui = ScreenGui,
        panel = Frame,
        scale = UIScale,
        mapUpdate = v87,
        fill = Frame7,
        nextUnlock = TextLabel5,
        cards = v100,
        big = TextLabel6,
        you = Frame8,
        youStroke = UIStroke5,
        youIcon = ImageLabel2,
        youText = TextLabel8,
        kills = TextLabel11,
        tierFill = Frame11,
        rewardCards = v136,
        footerText = TextLabel13,
        when = TextLabel14
    };
end;

local function paintWindow(p161) -- Line: 512
    -- upvalues: u68 (ref), OutbreakConfig (copy), infectedHere (copy), u60 (copy), Color3_fromRGB_ret (copy), Color3_fromRGB_ret5 (copy), u61 (ref), Color3_fromRGB_ret6 (copy)
    local v162 = u68;
    local v163 = OutbreakConfig.progress(p161);
    local AbsoluteSize = v162.gui.AbsoluteSize;
    local v164 = AbsoluteSize.X < 900 and true or AbsoluteSize.Y < 500;
    v162.scale.Scale = math.min(0.9, AbsoluteSize.X * (v164 and 0.96 or 0.78) / 1700, AbsoluteSize.Y * (v164 and 0.94 or 0.86) / 990);
    v162.mapUpdate(v163, infectedHere(), os.clock());
    v162.fill.Size = UDim2.fromScale(math.max(v163, 0.02), 1);
    v162.big.Text = string.format("%.2f%%", v163 * 100);
    local v165 = nil;

    for i, v in OutbreakConfig.Milestones do
        local v166 = v.at - 1e-9 <= v163;
        local v167 = v162.cards[i];
        local v168 = v.reward and u60.milestones[v.id] == true;
        local reward = v.reward;

        if reward then
            if v166 then
                reward = u60.infected and not v168;
            else
                reward = v166;
            end;
        end;

        v167.mark.Text = v166 and (not v.reward or v168) and "✓" or "";
        local v169;

        if v166 then
            v169 = Color3_fromRGB_ret;
        else
            v169 = Color3_fromRGB_ret5;
        end;

        v167.stroke.Color = v169;
        v167.chip.BackgroundTransparency = v166 and 0 or 0.55;

        if v167.button then
            v167.button.Visible = reward;
            v167.button.Text = u61 == "Milestone:" .. v.id and "..." or "CLAIM";
            v167.detail.Visible = not reward;
            v167.detail.Text = v168 and "Claimed" or (v166 and not u60.infected and "Get infected to claim" or v.detail);
            local v170;

            if v168 then
                v170 = Color3_fromRGB_ret;
            else
                v170 = Color3_fromRGB_ret6;
            end;

            v167.detail.TextColor3 = v170;
        end;

        if not (v166 or v165) then
            v165 = v;
        end;
    end;

    local nextUnlock = v162.nextUnlock;
    local v171;

    if v165 then
        local math_floor_ret = math.floor(v165.at * 100 + 0.5);
        v171 = "Next unlock at " .. tostring(math_floor_ret) .. "%";
    else
        v171 = "Every milestone reached";
    end;

    nextUnlock.Text = v171;
    v162.youText.Text = u60.infected and "YOU ARE INFECTED" or "NOT INFECTED";
    local v172;

    if u60.infected then
        v172 = Color3_fromRGB_ret;
    else
        v172 = Color3_fromRGB_ret6;
    end;

    v162.youText.TextColor3 = v172;
    v162.youIcon.ImageColor3 = v162.youText.TextColor3;
    local v173;

    if u60.infected then
        v173 = Color3_fromRGB_ret;
    else
        v173 = Color3_fromRGB_ret5;
    end;

    v162.youStroke.Color = v173;
    v162.kills.Text = tostring(u60.kills);
    local Tiers = OutbreakConfig.Tiers;
    local v174 = 0;
    local v175 = 0;

    for i, v in Tiers do
        if u60.kills < v.kills then
            v175 = v175 + math.clamp((u60.kills - v174) / (v.kills - v174), 0, 1);
            break;
        end;

        v174 = v.kills;
        v175 = i;
    end;

    v162.tierFill.Size = UDim2.fromScale(math.clamp(v175 / #Tiers, 0, 1), 1);
    local v176 = nil;
    local v177 = nil;

    for i, v in Tiers do
        local v178 = u60.claimed[tostring(i)] == true;
        local v179 = not v178 and u60.kills >= v.kills;
        local v180 = v162.rewardCards[i];
        v180.status.Text = v178 and "Claimed" or v.kills - u60.kills .. " to go";
        local v181;

        if v178 then
            v181 = Color3_fromRGB_ret;
        else
            v181 = Color3_fromRGB_ret6;
        end;

        v180.status.TextColor3 = v181;
        v180.status.Visible = not v179;
        v180.button.Visible = v179;
        v180.button.Text = u61 == "Tier:" .. i and "..." or "CLAIM";
        local v182;

        if v178 or v179 then
            v182 = Color3_fromRGB_ret;
        else
            v182 = Color3_fromRGB_ret5;
        end;

        v180.stroke.Color = v182;

        if v179 then
            v177 = true;
        elseif not (v178 or v176) then
            v176 = v;
        end;
    end;

    v162.footerText.Text = v177 and "→  You have rewards to claim!" or (not v176 and "→  All personal rewards claimed!" or "→  Next: " .. v176.name .. " at " .. v176.kills .. " infected");
    local v183 = OutbreakConfig.endsAt() - p161;
    v162.when.Text = p161 < OutbreakConfig.startsAt() and "The outbreak begins soon." or (v183 <= 0 and "The outbreak is over." or ("The outbreak ends in %dd %dh"):format(v183 // 86400, v183 % 86400 // 3600));
end;

local function open() -- Line: 588
    -- upvalues: LocalPlayer (copy), u68 (ref), buildWindow (copy), HudNavigation (copy), u59 (ref), paintWindow (copy)
    if LocalPlayer:GetAttribute("InMatch") == true then
        return;
    end;

    if not u68 then
        buildWindow();
    end;

    HudNavigation.opening("Outbreak");
    u68.gui.Enabled = true;
    LocalPlayer:SetAttribute("OutbreakOpen", true);

    if u59 then
        u59:FireServer("Get");
    end;

    local ServerTimeNow = workspace:GetServerTimeNow();

    if ServerTimeNow <= 1000000000 then
        ServerTimeNow = os.time();
    end;

    paintWindow(ServerTimeNow);
end;

local ScreenGui = Instance.new("ScreenGui");

for i, v in {
    Name = "OutbreakNotice",
    ResetOnSpawn = false,
    DisplayOrder = 240,
    IgnoreGuiInset = true
} do
    ScreenGui[i] = v;
end;

ScreenGui.Parent = PlayerGui;
ScreenGui:SetAttribute("SelfManagedText", true);
local SkinCatalog = require(ChickenOrHero:WaitForChild("Weapons"):WaitForChild("SkinCatalog"));
local Telemetry = require(ChickenOrHero:WaitForChild("Interface"):WaitForChild("Telemetry"));
local u184 = nil;
local u185 = nil;
local u186 = nil;
local u187 = nil;
local u188 = nil;

local function dismiss(p189) -- Line: 624
    -- upvalues: u185 (ref), u188 (ref), u186 (ref), u187 (ref), LocalPlayer (copy), TweenService (copy)
    local u190 = u185;

    if not u190 then
        return;
    end;

    u185 = nil;

    if p189 == true then
        u188 = u188 or u186;
    end;

    u186 = nil;

    if u187 then
        u187:Disconnect();
        u187 = nil;
    end;

    LocalPlayer:SetAttribute("OutbreakNoticeOpen", nil);
    local v191 = u190:FindFirstChildOfClass("UIScale");

    if v191 then
        TweenService:Create(v191, TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Scale = 0
        }):Play();
    end;

    task.delay(0.2, function() -- Line: 643
        -- upvalues: u190 (copy)
        u190:Destroy();
    end);
end;

local function knifeStage(p192) -- Line: 648
    -- upvalues: ChickenOrHero (copy), OutbreakConfig (copy)
    local Models = ChickenOrHero.Weapons:FindFirstChild("Models");

    if Models then
        Models = Models:FindFirstChild(OutbreakConfig.Knife);
    end;

    local v193;

    if Models then
        v193 = Models:FindFirstChild("Blade");
    else
        v193 = Models;
    end;

    if not (v193 and v193:IsA("BasePart")) then
        return nil;
    end;

    local v194 = {
        Name = "Knife",
        BackgroundTransparency = 1,
        LightDirection = Vector3.new(-1, -1, -0.6),
        ZIndex = 3,
        Size = UDim2.fromScale(1, 1),
        Ambient = Color3.fromRGB(150, 175, 150),
        LightColor = Color3.fromRGB(235, 255, 225)
    };
    local ViewportFrame = Instance.new("ViewportFrame");

    for i, v in v194 do
        ViewportFrame[i] = v;
    end;

    ViewportFrame.Parent = p192;
    local v195 = v193:Clone();

    for _, descendant in v195:GetDescendants() do
        if not (descendant:IsA("DataModelMesh") or (descendant:IsA("Decal") or descendant:IsA("SurfaceAppearance"))) then
            descendant:Destroy();
        end;
    end;

    v195.Anchored = true;
    v195.Transparency = 0;
    v195.CFrame = CFrame.fromAxisAngle(Vector3.new(0.8660254, 0.5, 0), 3.141592653589793) * (Models:GetAttribute("PreviewRotation") or CFrame.Angles(-0.4363323129985824, -0.20943951023931956, -0.5585053606381855));
    v195.Parent = ViewportFrame;
    local Camera = Instance.new("Camera");

    for i, v in {
        FieldOfView = 30
    } do
        Camera[i] = v;
    end;

    Camera.Parent = ViewportFrame;
    ViewportFrame.CurrentCamera = Camera;
    local math_max_ret = math.max(v195.Size.X, v195.Size.Y, v195.Size.Z);
    local u196 = 0;

    return function(p197) -- Line: 683
        -- upvalues: u196 (ref), math_max_ret (copy), Camera (copy)
        u196 = u196 + p197 * 0.7;
        local v198 = math_max_ret * 1.8;
        local CFrame_lookAt = CFrame.lookAt;
        local v199 = math.sin(u196) * v198;
        local v200 = math_max_ret * (math.sin(u196 * 1.7) * 0.05 + 0.08);
        local v201 = math.cos(u196) * v198;
        Camera.CFrame = CFrame_lookAt(Vector3.new(v199, v200, v201), Vector3.new(0, 0, 0));
    end;
end;

local function showInfected(p202) -- Line: 689
    -- upvalues: dismiss (copy), SkinCatalog (copy), OutbreakConfig (copy), ScreenGui (copy), Color3_fromRGB_ret (copy), Color3_new_ret (copy), Color3_fromRGB_ret2 (copy), Color3_fromRGB_ret5 (copy), Font_new_ret2 (copy), Font_new_ret (copy), knifeStage (copy), Color3_fromRGB_ret6 (copy), ChickenOrHero (copy), Telemetry (copy), LocalPlayer (copy), TweenService (copy), u185 (ref), u186 (ref), u187 (ref), RunService (copy)
    dismiss();
    local v203 = SkinCatalog.get(OutbreakConfig.Knife);
    local string_upper_ret = string.upper(v203 and v203.Name or "Infected Knife");
    local v204 = {
        Name = "Popup",
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(0.5, 0),
        Position = UDim2.fromScale(0.5, 0.1),
        Size = UDim2.fromOffset(600, 236)
    };
    local Frame = Instance.new("Frame");

    for i, v in v204 do
        Frame[i] = v;
    end;

    Frame.Parent = ScreenGui;
    local v205 = {
        Name = "Glow",
        BackgroundTransparency = 1,
        Image = "rbxassetid://120639974824188",
        ImageTransparency = 0.82,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.new(1, 160, 1, 160),
        ImageColor3 = Color3_fromRGB_ret
    };
    local ImageLabel = Instance.new("ImageLabel");

    for i, v in v205 do
        ImageLabel[i] = v;
    end;

    ImageLabel.Parent = Frame;
    local v206 = {
        Name = "Card",
        Active = true,
        Size = UDim2.fromScale(1, 1),
        BackgroundColor3 = Color3_new_ret
    };
    local Frame2 = Instance.new("Frame");

    for i, v in v206 do
        Frame2[i] = v;
    end;

    Frame2.Parent = Frame;
    local v207 = {
        CornerRadius = UDim.new(0, 20)
    };
    local UICorner = Instance.new("UICorner");

    for i, v in v207 do
        UICorner[i] = v;
    end;

    UICorner.Parent = Frame2;
    local v208 = {
        Thickness = 1.5,
        Transparency = 0.15,
        Color = Color3_fromRGB_ret,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    };
    local UIStroke = Instance.new("UIStroke");

    for i, v in v208 do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = Frame2;
    local v209 = {
        Rotation = 15,
        Color = ColorSequence.new(Color3.fromRGB(30, 46, 28), Color3.fromRGB(11, 14, 12))
    };
    local UIGradient = Instance.new("UIGradient");

    for i, v in v209 do
        UIGradient[i] = v;
    end;

    UIGradient.Parent = Frame2;
    local ViewportSize = workspace.CurrentCamera.ViewportSize;
    local math_min_ret = math.min(ViewportSize.X * 0.9 / 600, ViewportSize.Y * 0.42 / 236);
    local math_clamp_ret = math.clamp(math_min_ret, 0.5, 1);
    local UIScale = Instance.new("UIScale");

    for i, v in {
        Scale = 0.6
    } do
        UIScale[i] = v;
    end;

    UIScale.Parent = Frame;
    local v210 = {
        Name = "Stage",
        ClipsDescendants = true,
        Position = UDim2.fromOffset(20, 20),
        Size = UDim2.fromOffset(196, 196),
        BackgroundColor3 = Color3_fromRGB_ret2
    };
    local Frame3 = Instance.new("Frame");

    for i, v in v210 do
        Frame3[i] = v;
    end;

    Frame3.Parent = Frame2;
    local v211 = {
        CornerRadius = UDim.new(0, 16)
    };
    local UICorner2 = Instance.new("UICorner");

    for i, v in v211 do
        UICorner2[i] = v;
    end;

    UICorner2.Parent = Frame3;
    local v212 = {
        Thickness = 1,
        Color = Color3_fromRGB_ret5,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    };
    local UIStroke2 = Instance.new("UIStroke");

    for i, v in v212 do
        UIStroke2[i] = v;
    end;

    UIStroke2.Parent = Frame3;
    local v213 = {
        Name = "Glow",
        BackgroundTransparency = 1,
        Image = "rbxassetid://120639974824188",
        ImageTransparency = 0.5,
        ZIndex = 2,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(1.25, 1.25),
        ImageColor3 = Color3_fromRGB_ret
    };
    local ImageLabel2 = Instance.new("ImageLabel");

    for i, v in v213 do
        ImageLabel2[i] = v;
    end;

    ImageLabel2.Parent = Frame3;
    local v214 = {
        TextSize = 11,
        Text = "NEW KNIFE",
        ZIndex = 4,
        AnchorPoint = Vector2.new(0.5, 1),
        Position = UDim2.new(0.5, 0, 1, -8),
        Size = UDim2.fromOffset(92, 20),
        FontFace = Font_new_ret2,
        TextColor3 = Color3_fromRGB_ret2,
        TextXAlignment = Enum.TextXAlignment.Center,
        BackgroundTransparency = 1
    };
    v214.FontFace = v214.FontFace or Font_new_ret;
    v214.TextColor3 = v214.TextColor3 or Color3_new_ret;
    v214.TextXAlignment = v214.TextXAlignment or Enum.TextXAlignment.Left;
    local TextLabel = Instance.new("TextLabel");

    for i, v in v214 do
        TextLabel[i] = v;
    end;

    TextLabel.Parent = Frame3;
    TextLabel.BackgroundColor3 = Color3_fromRGB_ret;
    TextLabel.BackgroundTransparency = 0;
    local v215 = {
        CornerRadius = UDim.new(0, 10)
    };
    local UICorner3 = Instance.new("UICorner");

    for i, v in v215 do
        UICorner3[i] = v;
    end;

    UICorner3.Parent = TextLabel;
    local u216 = knifeStage(Frame3);
    local v217 = {
        Position = UDim2.fromOffset(236, 24),
        Size = UDim2.fromOffset(24, 24),
        BackgroundColor3 = Color3_fromRGB_ret
    };
    local Frame4 = Instance.new("Frame");

    for i, v in v217 do
        Frame4[i] = v;
    end;

    Frame4.Parent = Frame2;
    local v218 = {
        CornerRadius = UDim.new(0, 7)
    };
    local UICorner4 = Instance.new("UICorner");

    for i, v in v218 do
        UICorner4[i] = v;
    end;

    UICorner4.Parent = Frame4;
    local v219 = {
        BackgroundTransparency = 1,
        Image = "rbxassetid://131836773879206",
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(0.74, 0.74),
        ImageColor3 = Color3_fromRGB_ret2
    };
    local ImageLabel3 = Instance.new("ImageLabel");

    for i, v in v219 do
        ImageLabel3[i] = v;
    end;

    ImageLabel3.Parent = Frame4;
    local v220 = {
        TextSize = 15,
        Text = "YOU WERE INFECTED",
        Position = UDim2.fromOffset(268, 24),
        Size = UDim2.fromOffset(274, 24),
        FontFace = Font_new_ret2,
        TextColor3 = Color3_fromRGB_ret,
        BackgroundTransparency = 1
    };
    v220.FontFace = v220.FontFace or Font_new_ret;
    v220.TextColor3 = v220.TextColor3 or Color3_new_ret;
    v220.TextXAlignment = v220.TextXAlignment or Enum.TextXAlignment.Left;
    local TextLabel2 = Instance.new("TextLabel");

    for i, v in v220 do
        TextLabel2[i] = v;
    end;

    TextLabel2.Parent = Frame2;
    local v221 = {
        TextScaled = true,
        Position = UDim2.fromOffset(236, 56),
        Size = UDim2.fromOffset(344, 40),
        FontFace = Font_new_ret2,
        Text = string_upper_ret,
        BackgroundTransparency = 1
    };
    v221.FontFace = v221.FontFace or Font_new_ret;
    v221.TextColor3 = v221.TextColor3 or Color3_new_ret;
    v221.TextXAlignment = v221.TextXAlignment or Enum.TextXAlignment.Left;
    local TextLabel3 = Instance.new("TextLabel");

    for i, v in v221 do
        TextLabel3[i] = v;
    end;

    TextLabel3.Parent = Frame2;
    local UITextSizeConstraint = Instance.new("UITextSizeConstraint");

    for i, v in {
        MaxTextSize = 36
    } do
        UITextSizeConstraint[i] = v;
    end;

    UITextSizeConstraint.Parent = TextLabel3;
    local v222 = {
        Rotation = 90,
        Color = ColorSequence.new(Color3_new_ret, Color3.fromRGB(200, 255, 170))
    };
    local UIGradient2 = Instance.new("UIGradient");

    for i, v in v222 do
        UIGradient2[i] = v;
    end;

    UIGradient2.Parent = TextLabel3;
    local v223 = {
        TextSize = 15,
        RichText = true,
        Position = UDim2.fromOffset(236, 100),
        Size = UDim2.fromOffset(344, 20),
        TextColor3 = Color3_fromRGB_ret6,
        Text = ("Caught by <font color=\"#FFFFFF\">%s</font>"):format((tostring(p202):gsub("[<>&]", ""))),
        BackgroundTransparency = 1
    };
    v223.FontFace = v223.FontFace or Font_new_ret;
    v223.TextColor3 = v223.TextColor3 or Color3_new_ret;
    v223.TextXAlignment = v223.TextXAlignment or Enum.TextXAlignment.Left;
    local TextLabel4 = Instance.new("TextLabel");

    for i, v in v223 do
        TextLabel4[i] = v;
    end;

    TextLabel4.Parent = Frame2;
    local v224 = {
        TextSize = 13,
        TextWrapped = true,
        Text = "Every runner you catch with it gets infected too. Spread it to unlock the outbreak\'s rewards.",
        Position = UDim2.fromOffset(236, 126),
        Size = UDim2.fromOffset(344, 38),
        TextColor3 = Color3.fromRGB(215, 228, 212),
        TextYAlignment = Enum.TextYAlignment.Top,
        BackgroundTransparency = 1
    };
    v224.FontFace = v224.FontFace or Font_new_ret;
    v224.TextColor3 = v224.TextColor3 or Color3_new_ret;
    v224.TextXAlignment = v224.TextXAlignment or Enum.TextXAlignment.Left;
    local TextLabel5 = Instance.new("TextLabel");

    for i, v in v224 do
        TextLabel5[i] = v;
    end;

    TextLabel5.Parent = Frame2;
    local v225 = {
        Name = "EquipNow",
        TextSize = 20,
        Text = "EQUIP NOW",
        AutoButtonColor = true,
        ClipsDescendants = true,
        Position = UDim2.fromOffset(236, 170),
        Size = UDim2.fromOffset(344, 46),
        BackgroundColor3 = Color3_fromRGB_ret,
        FontFace = Font_new_ret2,
        TextColor3 = Color3_fromRGB_ret2
    };
    local TextButton = Instance.new("TextButton");

    for i, v in v225 do
        TextButton[i] = v;
    end;

    TextButton.Parent = Frame2;
    local v226 = {
        CornerRadius = UDim.new(0, 12)
    };
    local UICorner5 = Instance.new("UICorner");

    for i, v in v226 do
        UICorner5[i] = v;
    end;

    UICorner5.Parent = TextButton;
    local v227 = {
        BackgroundTransparency = 0.55,
        Active = false,
        Size = UDim2.fromScale(1, 1),
        BackgroundColor3 = Color3_new_ret
    };
    local Frame5 = Instance.new("Frame");

    for i, v in v227 do
        Frame5[i] = v;
    end;

    Frame5.Parent = TextButton;
    local v228 = {
        CornerRadius = UDim.new(0, 12)
    };
    local UICorner6 = Instance.new("UICorner");

    for i, v in v228 do
        UICorner6[i] = v;
    end;

    UICorner6.Parent = Frame5;
    local v229 = {
        Rotation = 20,
        Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 1),
            NumberSequenceKeypoint.new(0.42, 1),
            NumberSequenceKeypoint.new(0.5, 0.2),
            NumberSequenceKeypoint.new(0.58, 1),
            NumberSequenceKeypoint.new(1, 1)
        }),
        Offset = Vector2.new(-1, 0)
    };
    local UIGradient3 = Instance.new("UIGradient");

    for i, v in v229 do
        UIGradient3[i] = v;
    end;

    UIGradient3.Parent = Frame5;
    TextButton.Activated:Connect(function() -- Line: 824
        -- upvalues: ChickenOrHero (ref), OutbreakConfig (ref), Telemetry (ref), LocalPlayer (ref), dismiss (ref)
        ChickenOrHero.Weapons.ArmoryEvent:FireServer("Equip", OutbreakConfig.Knife);
        Telemetry.track("outbreak_notice_equip", LocalPlayer:GetAttribute("InMatch") == true and "match" or "lobby");
        dismiss();
    end);
    local v230 = {
        Name = "Close",
        BackgroundTransparency = 0.92,
        TextSize = 16,
        Text = "X",
        AutoButtonColor = true,
        AnchorPoint = Vector2.new(1, 0),
        Position = UDim2.new(1, -12, 0, 12),
        Size = UDim2.fromOffset(30, 30),
        BackgroundColor3 = Color3_new_ret,
        FontFace = Font_new_ret2,
        TextColor3 = Color3_fromRGB_ret6
    };
    local TextButton2 = Instance.new("TextButton");

    for i, v in v230 do
        TextButton2[i] = v;
    end;

    TextButton2.Parent = Frame2;
    local v231 = {
        CornerRadius = UDim.new(0, 15)
    };
    local UICorner7 = Instance.new("UICorner");

    for i, v in v231 do
        UICorner7[i] = v;
    end;

    UICorner7.Parent = TextButton2;
    TextButton2.Activated:Connect(function() -- Line: 843
        -- upvalues: dismiss (ref)
        dismiss();
    end);

    if LocalPlayer:GetAttribute("InMatch") == true then
        local v232 = {
            Name = "Timer",
            BorderSizePixel = 0,
            AnchorPoint = Vector2.new(0, 1),
            Position = UDim2.new(0, 20, 1, -6),
            Size = UDim2.new(1, -40, 0, 3),
            BackgroundColor3 = Color3_fromRGB_ret
        };
        local Frame6 = Instance.new("Frame");

        for i, v in v232 do
            Frame6[i] = v;
        end;

        Frame6.Parent = Frame2;
        local v233 = {
            CornerRadius = UDim.new(0, 2)
        };
        local UICorner8 = Instance.new("UICorner");

        for i, v in v233 do
            UICorner8[i] = v;
        end;

        UICorner8.Parent = Frame6;
        TweenService:Create(Frame6, TweenInfo.new(10, Enum.EasingStyle.Linear), {
            Size = UDim2.new(0, 0, 0, 3)
        }):Play();
        task.delay(10, function() -- Line: 858
            -- upvalues: u185 (ref), Frame (copy), dismiss (ref)
            if u185 == Frame then
                dismiss(true);
            end;
        end);
    end;

    u185 = Frame;
    u186 = p202;
    Telemetry.track("outbreak_notice", LocalPlayer:GetAttribute("InMatch") == true and "match" or "lobby");
    LocalPlayer:SetAttribute("OutbreakNoticeOpen", true);
    local u234 = 0;

    if u216 then
        u216(0);
    end;

    u187 = RunService.RenderStepped:Connect(function(p235) -- Line: 872
        -- upvalues: u216 (copy), u234 (ref), UIGradient3 (copy)
        if u216 then
            u216(p235);
        end;

        u234 = (u234 + p235) % 2.6;
        UIGradient3.Offset = Vector2.new(math.min(u234 / 0.9, 1) * 2 - 1, 0);
    end);
    Frame.Position = UDim2.fromScale(0.5, 0.06);
    TweenService:Create(Frame, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Position = UDim2.fromScale(0.5, 0.1)
    }):Play();
    TweenService:Create(UIScale, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Scale = math_clamp_ret
    }):Play();
end;

local function infectedNow() -- Line: 885
    -- upvalues: u60 (copy), LocalPlayer (copy)
    return u60.infected == true and true or LocalPlayer:GetAttribute("OutbreakInfected") == true;
end;

local function tryInfected() -- Line: 889
    -- upvalues: u184 (ref), u60 (copy), LocalPlayer (copy), OutbreakConfig (copy), showInfected (copy)
    if u184 and (u60.infected ~= true and LocalPlayer:GetAttribute("OutbreakInfected") ~= true or LocalPlayer:GetAttribute("EquippedKnife") == OutbreakConfig.Knife) then
        u184 = nil;
    end;

    if not u184 or LocalPlayer:GetAttribute("MatchSummaryVisible") == true then
        return;
    end;

    local u236 = u184;
    u184 = nil;
    task.delay(0.3, function() -- Line: 898
        -- upvalues: LocalPlayer (ref), OutbreakConfig (ref), showInfected (ref), u236 (copy), u184 (ref)
        if LocalPlayer:GetAttribute("EquippedKnife") == OutbreakConfig.Knife then
            return;
        end;

        if LocalPlayer:GetAttribute("MatchSummaryVisible") == true then
            u184 = u184 or u236;

            return;
        end;

        showInfected(u236);
    end);
end;

local function infectedNotice(p237) -- Line: 909
    -- upvalues: u184 (ref), u188 (ref), tryInfected (copy)
    u184 = p237;
    u188 = nil;
    tryInfected();
end;

local v238 = LocalPlayer:GetAttributeChangedSignal("MatchSummaryVisible"):Connect(tryInfected);
table.insert(u4, v238);
local v239 = LocalPlayer:GetAttributeChangedSignal("InMatch"):Connect(function() -- Line: 915
    -- upvalues: LocalPlayer (copy), dismiss (copy), u188 (ref), u184 (ref), tryInfected (copy)
    if LocalPlayer:GetAttribute("InMatch") == true then
        dismiss(true);
    elseif u188 then
        u184 = u184 or u188;
        u188 = nil;
    end;

    tryInfected();
end);
table.insert(u4, v239);
local u240 = setmetatable({}, {
    __mode = "k"
});

local function knifeFx(p241, p242) -- Line: 933
    -- upvalues: u240 (copy)
    local v243 = u240[p241];

    if not v243 then
        v243 = {};

        for _, descendant in p241:GetDescendants() do
            if descendant:GetAttribute("OutbreakFx") == true and (descendant:IsA("ParticleEmitter") or (descendant:IsA("Trail") or (descendant:IsA("Beam") or descendant:IsA("Light")))) then
                table.insert(v243, descendant);
            end;
        end;

        u240[p241] = v243;
    end;

    for _, v in v243 do
        if v.Enabled ~= p242 then
            v.Enabled = p242;

            if not p242 and v:IsA("ParticleEmitter") then
                v:Clear();
            end;
        end;
    end;
end;

local function stepKnives(p244) -- Line: 953
    -- upvalues: Players (copy), OutbreakConfig (copy), knifeFx (copy)
    for _, v in Players:GetPlayers() do
        local Character = v.Character;

        if Character then
            if Character:GetAttribute("DaggerSkin") == OutbreakConfig.Knife then
                Character = Character:FindFirstChild("EquippedDagger");
            else
                Character = false;
            end;
        end;

        for _, v2 in { "Blade", "StowedBlade" } do
            local v245;

            if Character then
                v245 = Character:FindFirstChild(v2);
            else
                v245 = Character;
            end;

            if v245 and v245:IsA("BasePart") then
                local v246;

                if p244 then
                    if v245.Transparency < 0.95 then
                        v246 = v245.LocalTransparencyModifier < 0.95;
                    else
                        v246 = false;
                    end;
                else
                    v246 = p244;
                end;

                knifeFx(v245, v246);
            end;
        end;
    end;
end;

local function u253(p247) -- Line: 970
    -- upvalues: Players (copy), PlayerGui (copy), Font_new_ret2 (copy), Color3_fromRGB_ret (copy), Font_new_ret (copy), Color3_new_ret (copy), Color3_fromRGB_ret2 (copy), TweenService (copy)
    local PlayerByUserId = Players:GetPlayerByUserId(p247);
    local v248;

    if PlayerByUserId then
        v248 = PlayerByUserId.Character;
    else
        v248 = PlayerByUserId;
    end;

    if v248 then
        v248 = v248:FindFirstChild("Head") or v248:FindFirstChild("HumanoidRootPart");
    end;

    if not v248 then
        return;
    end;

    local v249 = {
        Name = "OutbreakInfectedTag",
        AlwaysOnTop = true,
        LightInfluence = 0,
        StudsOffset = Vector3.new(0, 2.6, 0),
        MaxDistance = 250,
        ResetOnSpawn = false,
        Adornee = v248,
        Size = UDim2.fromOffset(340, 70)
    };
    local BillboardGui = Instance.new("BillboardGui");

    for i, v in v249 do
        BillboardGui[i] = v;
    end;

    BillboardGui.Parent = PlayerGui;
    local v250 = {
        TextSize = 34,
        Rotation = -8,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(1, 1),
        FontFace = Font_new_ret2,
        TextColor3 = Color3_fromRGB_ret,
        TextXAlignment = Enum.TextXAlignment.Center,
        Text = "INFECTED: " .. PlayerByUserId.DisplayName .. "!",
        BackgroundTransparency = 1
    };
    v250.FontFace = v250.FontFace or Font_new_ret;
    v250.TextColor3 = v250.TextColor3 or Color3_new_ret;
    v250.TextXAlignment = v250.TextXAlignment or Enum.TextXAlignment.Left;
    local TextLabel = Instance.new("TextLabel");

    for i, v in v250 do
        TextLabel[i] = v;
    end;

    TextLabel.Parent = BillboardGui;
    local v251 = {
        Thickness = 3,
        Color = Color3_fromRGB_ret2
    };
    local UIStroke = Instance.new("UIStroke");

    for i, v in v251 do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = TextLabel;
    local UIScale = Instance.new("UIScale");

    for i, v in {
        Scale = 0.4
    } do
        UIScale[i] = v;
    end;

    UIScale.Parent = TextLabel;
    TweenService:Create(UIScale, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Scale = 1
    }):Play();
    TweenService:Create(BillboardGui, TweenInfo.new(1.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        StudsOffset = Vector3.new(0, 4.4, 0)
    }):Play();
    task.delay(1.1500000000000001, function() -- Line: 1002
        -- upvalues: TextLabel (copy), TweenService (ref)
        if TextLabel.Parent then
            TweenService:Create(TextLabel, TweenInfo.new(0.45), {
                TextTransparency = 1
            }):Play();
            local v252 = TextLabel:FindFirstChildOfClass("UIStroke");

            if v252 then
                TweenService:Create(v252, TweenInfo.new(0.45), {
                    Transparency = 1
                }):Play();
            end;
        end;
    end);
    task.delay(1.6, function() -- Line: 1011
        -- upvalues: BillboardGui (copy)
        BillboardGui:Destroy();
    end);
end;

task.spawn(function() -- Line: 1019
    -- upvalues: u59 (ref), ChickenOrHero (copy), u60 (copy), u184 (ref), u188 (ref), tryInfected (copy), u61 (ref), u68 (ref), OutbreakConfig (copy), u253 (ref), u4 (copy)
    u59 = ChickenOrHero.Game:WaitForChild("OutbreakEvent", 60);

    if not u59 then
        return;
    end;

    local v258 = u59.OnClientEvent:Connect(function(p254, p255) -- Line: 1024
        -- upvalues: u60 (ref), u184 (ref), u188 (ref), tryInfected (ref), u61 (ref), u68 (ref), OutbreakConfig (ref), ChickenOrHero (ref), u253 (ref)
        if p254 == "State" and type(p255) == "table" then
            u60.kills = tonumber(p255.kills) or 0;
            u60.claimed = type(p255.claimed) == "table" and (p255.claimed or {}) or {};
            u60.milestones = type(p255.milestones) == "table" and (p255.milestones or {}) or {};
            u60.infected = p255.infected == true;

            return;
        end;

        if p254 ~= "Infected" or type(p255) ~= "table" then
            if p254 == "Claimed" and type(p255) == "table" then
                u61 = nil;

                if type(p255.given) == "table" then
                    local v256 = nil;
                    local v257 = u68;

                    if v257 then
                        if p255.kind == "Tier" then
                            v257 = u68.rewardCards[p255.key];
                        else
                            v257 = nil;
                        end;
                    end;

                    if not (v257 or (not u68 or p255.kind ~= "Milestone")) then
                        for i, v in OutbreakConfig.Milestones do
                            if v.id == p255.key then
                                v257 = u68.cards[i];
                            end;
                        end;
                    end;

                    if v257 and v257.card then
                        v256 = v257.card.AbsolutePosition + v257.card.AbsoluteSize / 2;
                    end;

                    require(ChickenOrHero.Interface.ClaimPop).given(p255.given, v256, {
                        heading = "OUTBREAK REWARD",
                        displayOrder = 90
                    });

                    return;
                end;
            elseif p254 == "Spread" and type(p255) == "number" then
                u253(p255);
            end;

            return;
        end;

        u60.infected = true;
        u184 = p255.by;
        u188 = nil;
        tryInfected();
    end);
    table.insert(u4, v258);
    u59:FireServer("Get");
end);
local v262 = ProximityPromptService.PromptTriggered:Connect(function(p259, p260) -- Line: 1057
    -- upvalues: MapLocator (copy), LocalPlayer (copy), open (copy)
    local v261 = MapLocator.interactable("OutbreakEvent");

    if v261 then
        v261 = v261:FindFirstChild("Prompt");
    end;

    if not (v261 and (v261:IsA("BasePart") and v261)) then
        v261 = nil;
    end;

    if p260 == LocalPlayer and (v261 and p259:IsDescendantOf(v261)) then
        open();
    end;
end);
table.insert(u4, v262);
local v264 = HudNavigation.Opening.Event:Connect(function(p263) -- Line: 1063
    -- upvalues: u68 (ref), LocalPlayer (copy)
    if p263 ~= "Outbreak" and (u68 and u68.gui.Enabled) then
        u68.gui.Enabled = false;
        LocalPlayer:SetAttribute("OutbreakOpen", nil);
    end;
end);
table.insert(u4, v264);
local v266 = UserInputService.InputBegan:Connect(function(p265) -- Line: 1068
    -- upvalues: u68 (ref), LocalPlayer (copy)
    if u68 and (u68.gui.Enabled and (p265.KeyCode == Enum.KeyCode.Escape or p265.KeyCode == Enum.KeyCode.ButtonB)) and (u68 and u68.gui.Enabled) then
        u68.gui.Enabled = false;
        LocalPlayer:SetAttribute("OutbreakOpen", nil);
    end;
end);
table.insert(u4, v266);
local v267 = LocalPlayer:GetAttributeChangedSignal("InMatch"):Connect(function() -- Line: 1073
    -- upvalues: LocalPlayer (copy), u68 (ref)
    if LocalPlayer:GetAttribute("InMatch") == true and (u68 and u68.gui.Enabled) then
        u68.gui.Enabled = false;
        LocalPlayer:SetAttribute("OutbreakOpen", nil);
    end;
end);
table.insert(u4, v267);
local u268 = 0;
local v272 = RunService.Heartbeat:Connect(function(p269) -- Line: 1080
    -- upvalues: u268 (ref), OutbreakConfig (copy), buildStand (copy), u45 (copy), infectedHere (copy), u68 (ref), paintWindow (copy), stepKnives (copy)
    u268 = u268 + p269;

    if u268 < 0.25 then
        return;
    end;

    u268 = 0;
    local ServerTimeNow = workspace:GetServerTimeNow();

    if ServerTimeNow <= 1000000000 then
        ServerTimeNow = os.time();
    end;

    local v270 = OutbreakConfig.active(ServerTimeNow);
    local v271 = OutbreakConfig.progress(ServerTimeNow);

    if v270 or OutbreakConfig.endsAt() <= ServerTimeNow then
        buildStand();
    end;

    if u45.gui and u45.gui.Parent then
        u45.update(not v270 and OutbreakConfig.endsAt() > ServerTimeNow and 0 or v271, infectedHere(), os.clock());
        u45.label.Text = ServerTimeNow < OutbreakConfig.startsAt() and "COMING SOON" or (not v270 and "OUTBREAK OVER" or string.format("%.2f%%", v271 * 100) .. " INFECTED");
    end;

    if u68 and u68.gui.Enabled then
        paintWindow(ServerTimeNow);
    end;

    if v270 then
        v270 = OutbreakConfig.reached("Knife", ServerTimeNow);
    end;

    stepKnives(v270);
end);
table.insert(u4, v272);
script.Destroying:Connect(function() -- Line: 1105
    -- upvalues: u4 (copy), LocalPlayer (copy), ScreenGui (copy), u68 (ref), u45 (copy)
    for _, v in u4 do
        v:Disconnect();
    end;

    table.clear(u4);
    LocalPlayer:SetAttribute("OutbreakOpen", nil);
    LocalPlayer:SetAttribute("OutbreakNoticeOpen", nil);
    local v273 = {};
    v273[1], v273[2], v273[3] = ScreenGui, u68 and u68.gui, u45.gui;

    for _, v in v273 do
        if v then
            v:Destroy();
        end;
    end;
end);