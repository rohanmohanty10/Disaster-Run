 

 

local Players = game:GetService("Players");
local SoundService = game:GetService("SoundService");
local TweenService = game:GetService("TweenService");
local script_Parent = script.Parent;
local Parent = script_Parent.Parent;
local CombineConfig = require(script_Parent.CombineConfig);
local SkinCatalog = require(script_Parent.SkinCatalog);
local KnifeIconCopy = require(script_Parent.KnifeIconCopy);
local u1 = {};
local LocalPlayer = Players.LocalPlayer;
local Color3_new_ret = Color3.new(1, 1, 1);
local Color3_new_ret2 = Color3.new(0, 0, 0);
local Color3_fromRGB_ret = Color3.fromRGB(23, 23, 25);
local Color3_fromRGB_ret2 = Color3.fromRGB(34, 34, 39);
local Color3_fromRGB_ret3 = Color3.fromRGB(255, 202, 58);
local Color3_fromRGB_ret4 = Color3.fromRGB(205, 205, 212);
local Color3_fromRGB_ret5 = Color3.fromRGB(150, 110, 255);
local Color3_fromRGB_ret6 = Color3.fromRGB(253, 60, 85);
local ColorSequence_new_ret = ColorSequence.new(Color3.fromRGB(80, 255, 100), Color3.fromRGB(17, 213, 40));
local u2 = nil;

local function make(p3, p4, p5) -- Line: 30
    local Instance_new_ret = Instance.new(p3);

    for i, v in p5 or {} do
        Instance_new_ret[i] = v;
    end;

    Instance_new_ret.Parent = p4;

    return Instance_new_ret;
end;

local function round(p6, p7) -- Line: 38
    local v8 = {
        CornerRadius = p7 or UDim.new(0.08, 0)
    };
    local UICorner = Instance.new("UICorner");

    for i, v in v8 or {} do
        UICorner[i] = v;
    end;

    UICorner.Parent = p6;
end;

local function border(p9, p10, p11) -- Line: 41
    local v12 = {
        Color = p10,
        Thickness = p11,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    };
    local UIStroke = Instance.new("UIStroke");

    for i, v in v12 or {} do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = p9;

    return UIStroke;
end;

local function box(p13, p14, p15, p16, p17, p18) -- Line: 44
    p13.Position = UDim2.fromScale(p14, p15);
    p13.Size = UDim2.fromScale(p16, p17);
    p13.AnchorPoint = p18 or Vector2.zero;

    return p13;
end;

local function text(p19, p20, p21, p22, p23, p24, p25) -- Line: 51
    -- upvalues: Color3_new_ret (copy), Color3_new_ret2 (copy)
    local v26 = {
        BackgroundTransparency = 1,
        TextScaled = true,
        TextWrapped = true,
        RichText = true,
        Name = p20,
        Text = p21,
        TextColor3 = p22 or Color3_new_ret,
        FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", p23 or Enum.FontWeight.ExtraBold)
    };
    local TextLabel = Instance.new("TextLabel");

    for i, v in v26 or {} do
        TextLabel[i] = v;
    end;

    TextLabel.Parent = p19;
    local v27 = {
        Color = Color3_new_ret2,
        Thickness = p25 or 0.12,
        StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize
    };
    local UIStroke = Instance.new("UIStroke");

    for i, v in v27 or {} do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = TextLabel;

    for i, v in p24 or {} do
        TextLabel[i] = v;
    end;

    return TextLabel;
end;

local function sound(p28) -- Line: 68
    -- upvalues: SoundService (copy)
    local GameAudio = SoundService:FindFirstChild("GameAudio");

    if GameAudio then
        GameAudio = GameAudio:FindFirstChild("04_UI");
    end;

    if GameAudio then
        GameAudio = GameAudio:FindFirstChild(p28);
    end;

    if GameAudio and GameAudio:IsA("Sound") then
        require(game:GetService("ReplicatedFirst"):WaitForChild("LazySound")).playLocal(GameAudio);
    end;
end;

local CFrame_lookAt_ret = CFrame.lookAt(Vector3.new(0, 0, 0), Vector3.new(1, 1, 0.35));

local function iconPose(p29, p30) -- Line: 81
    -- upvalues: CFrame_lookAt_ret (copy)
    local Attribute = p30:GetAttribute("ThumbAxis");
    local Attribute2 = p30:GetAttribute("ThumbNormal");

    if typeof(Attribute) ~= "Vector3" or (typeof(Attribute2) ~= "Vector3" or Attribute.Magnitude <= 0.5) then
        local Size = p29.Size;

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

local function knifeIcon(p31, p32) -- Line: 97
    -- upvalues: SkinCatalog (copy), script_Parent (copy), KnifeIconCopy (copy), iconPose (copy)
    local v33 = SkinCatalog.get(p32);

    if v33 then
        v33 = script_Parent.Models:FindFirstChild(v33.Model);
    end;

    local v34;

    if v33 then
        v34 = v33:FindFirstChild("Blade") or v33:FindFirstChildWhichIsA("BasePart", true);
    else
        v34 = v33;
    end;

    local v35 = {
        Name = "Knife",
        BackgroundTransparency = 1,
        LightDirection = Vector3.new(-0.4, -0.8, -1),
        Ambient = Color3.fromRGB(200, 200, 210),
        LightColor = Color3.fromRGB(255, 250, 235)
    };
    local ViewportFrame = Instance.new("ViewportFrame");

    for i, v in v35 or {} do
        ViewportFrame[i] = v;
    end;

    ViewportFrame.Parent = p31;

    if not v34 then
        return ViewportFrame;
    end;

    local WorldModel = Instance.new("WorldModel");

    for i, v in {} do
        WorldModel[i] = v;
    end;

    WorldModel.Parent = ViewportFrame;
    local v36, _, v37, v38 = KnifeIconCopy.new(v34);
    v36.Parent = WorldModel;
    local v39 = iconPose(v36, v33);
    v36.CFrame = CFrame.new(-v39:VectorToWorldSpace(v38)) * v39;
    local _, v40 = KnifeIconCopy.cross(WorldModel, v33, iconPose, Vector3.new(0, 1, 0), v36);

    if v40 then
        v36.CFrame = v36.CFrame - WorldModel:GetBoundingBox().Position;
    end;

    local X = v37.X;
    local Y = v37.Y;
    local Z = v37.Z;
    local v41 = v40 and math.max(v40.X, v40.Y, v40.Z) or 0;
    local math_max_ret = math.max(X, Y, Z, v41);
    local Camera = Instance.new("Camera");

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

local function tierColor(p42) -- Line: 128
    -- upvalues: CombineConfig (copy)
    local _, v43 = CombineConfig.tierOf(p42);
    local v44 = CombineConfig.isFusion(p42) and #CombineConfig.TierColors or (v43 or 1);

    return CombineConfig.TierColors[math.clamp(v44, 1, #CombineConfig.TierColors)];
end;

local function tile(p45, p46, p47, p48, p49, p50, p51) -- Line: 133
    -- upvalues: CombineConfig (copy), Color3_fromRGB_ret2 (copy), Color3_fromRGB_ret (copy), knifeIcon (copy), text (copy), Color3_new_ret (copy)
    local _, v52 = CombineConfig.tierOf(p46);
    local v53 = CombineConfig.isFusion(p46) and #CombineConfig.TierColors or (v52 or 1);
    local v54 = CombineConfig.TierColors[math.clamp(v53, 1, #CombineConfig.TierColors)];
    local v55 = {
        Name = p46,
        BackgroundColor3 = Color3_fromRGB_ret2
    };
    local Frame = Instance.new("Frame");

    for i, v in v55 or {} do
        Frame[i] = v;
    end;

    Frame.Parent = p45;
    local Vector2_new_ret = Vector2.new(0.5, 0.5);
    Frame.Position = UDim2.fromScale(p47, p48);
    Frame.Size = UDim2.fromScale(p49, p50);
    Frame.AnchorPoint = Vector2_new_ret or Vector2.zero;
    local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint");

    for i, v in {
        AspectRatio = 1
    } or {} do
        UIAspectRatioConstraint[i] = v;
    end;

    UIAspectRatioConstraint.Parent = Frame;
    local v56 = {
        CornerRadius = UDim.new(0.18, 0) or UDim.new(0.08, 0)
    };
    local UICorner = Instance.new("UICorner");

    for i, v in v56 or {} do
        UICorner[i] = v;
    end;

    UICorner.Parent = Frame;
    local v57 = {
        Thickness = 2,
        Color = v54,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    };
    local UIStroke = Instance.new("UIStroke");

    for i, v in v57 or {} do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = Frame;
    local v58 = {
        Rotation = 90,
        Color = ColorSequence.new(Color3_fromRGB_ret2, v54:Lerp(Color3_fromRGB_ret, 0.55))
    };
    local UIGradient = Instance.new("UIGradient");

    for i, v in v58 or {} do
        UIGradient[i] = v;
    end;

    UIGradient.Parent = Frame;
    local v59 = knifeIcon(Frame, p46);
    local Vector2_new_ret2 = Vector2.new(0.5, 0.5);
    v59.Position = UDim2.fromScale(0.5, 0.45);
    v59.Size = UDim2.fromScale(0.92, 0.92);
    v59.AnchorPoint = Vector2_new_ret2 or Vector2.zero;

    if p51 then
        local Frame2 = Instance.new("Frame");

        for i, v in {
            Name = "Level",
            BackgroundColor3 = v54
        } or {} do
            Frame2[i] = v;
        end;

        Frame2.Parent = Frame;
        local Vector2_new_ret3 = Vector2.new(0.5, 0.5);
        Frame2.Position = UDim2.fromScale(0.5, 1);
        Frame2.Size = UDim2.fromScale(0.86, 0.24);
        Frame2.AnchorPoint = Vector2_new_ret3 or Vector2.zero;
        local v60 = {
            CornerRadius = UDim.new(1, 0) or UDim.new(0.08, 0)
        };
        local UICorner2 = Instance.new("UICorner");

        for i, v in v60 or {} do
            UICorner2[i] = v;
        end;

        UICorner2.Parent = Frame2;
        local v61 = text(Frame2, "Text", p51, Color3_new_ret, Enum.FontWeight.Heavy);
        local Vector2_new_ret4 = Vector2.new(0.5, 0.5);
        v61.Position = UDim2.fromScale(0.5, 0.5);
        v61.Size = UDim2.fromScale(0.86, 0.74);
        v61.AnchorPoint = Vector2_new_ret4 or Vector2.zero;
    end;

    return Frame;
end;

local function journeyLevels() -- Line: 152
    -- upvalues: Parent (copy)
    local success, result = pcall(require, Parent.Progression.JourneySeason1Rewards);
    local v62 = {};

    if success and type(result) == "table" then
        for i, v in result do
            if type(i) == "number" and (type(v) == "table" and (type(v.Free) == "table" and (v.Free.Spins or 0) > 0)) then
                table.insert(v62, i);
            end;
        end;
    end;

    table.sort(v62);

    if #v62 == 0 then
        return nil;
    end;

    local table_remove_ret = table.remove(v62);

    if #v62 > 0 then
        return table.concat(v62, ", ") .. " & " .. table_remove_ret;
    end;

    return tostring(table_remove_ret);
end;

local function countdown() -- Line: 170
    -- upvalues: CombineConfig (copy)
    local v63 = (CombineConfig.EndsAt or 0) - os.time();

    if not CombineConfig.EndsAt then
        return "";
    end;

    if v63 <= 0 then
        return "EVENT OVER";
    end;

    local math_floor_ret = math.floor(v63 / 86400);
    local math_floor_ret2 = math.floor(v63 % 86400 / 3600);

    if math_floor_ret > 0 then
        return ("ENDS IN %dD %dH"):format(math_floor_ret, math_floor_ret2);
    end;

    return ("ENDS IN %dH %dM"):format(math_floor_ret2, (math.floor(v63 % 3600 / 60)));
end;

local function card(p64, p65, p66, p67, p68, p69) -- Line: 182
    -- upvalues: Color3_fromRGB_ret2 (copy), text (copy), Color3_new_ret (copy)
    local v70 = {
        Name = "Step" .. p65,
        BackgroundColor3 = Color3_fromRGB_ret2
    };
    local Frame = Instance.new("Frame");

    for i, v in v70 or {} do
        Frame[i] = v;
    end;

    Frame.Parent = p64;
    Frame.Position = UDim2.fromScale(p66, 0.165);
    Frame.Size = UDim2.fromScale(p67, 0.66);
    Frame.AnchorPoint = Vector2.zero;
    local v71 = {
        CornerRadius = UDim.new(0.06, 0) or UDim.new(0.08, 0)
    };
    local UICorner = Instance.new("UICorner");

    for i, v in v71 or {} do
        UICorner[i] = v;
    end;

    UICorner.Parent = Frame;
    local v72 = {
        Thickness = 2,
        Color = p69,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    };
    local UIStroke = Instance.new("UIStroke");

    for i, v in v72 or {} do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = Frame;
    local Frame2 = Instance.new("Frame");

    for i, v in {
        Name = "Number",
        BackgroundColor3 = p69
    } or {} do
        Frame2[i] = v;
    end;

    Frame2.Parent = Frame;
    Frame2.Position = UDim2.fromScale(0.05, 0.04);
    Frame2.Size = UDim2.fromScale(0.2, 0.1);
    Frame2.AnchorPoint = Vector2.zero;
    local v73 = {
        AspectRatio = 1,
        DominantAxis = Enum.DominantAxis.Height
    };
    local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint");

    for i, v in v73 or {} do
        UIAspectRatioConstraint[i] = v;
    end;

    UIAspectRatioConstraint.Parent = Frame2;
    local v74 = {
        CornerRadius = UDim.new(1, 0) or UDim.new(0.08, 0)
    };
    local UICorner2 = Instance.new("UICorner");

    for i, v in v74 or {} do
        UICorner2[i] = v;
    end;

    UICorner2.Parent = Frame2;
    local v75 = text(Frame2, "Text", tostring(p65), Color3_new_ret, Enum.FontWeight.Heavy);
    local Vector2_new_ret = Vector2.new(0.5, 0.5);
    v75.Position = UDim2.fromScale(0.5, 0.5);
    v75.Size = UDim2.fromScale(0.62, 0.62);
    v75.AnchorPoint = Vector2_new_ret or Vector2.zero;
    local v76 = 0.05 + 0.066 / (p67 * 1.75) + 0.03;
    local v77 = text(Frame, "Heading", p68, p69, Enum.FontWeight.Heavy, {
        TextXAlignment = Enum.TextXAlignment.Left
    });
    v77.Position = UDim2.fromScale(v76, 0.045);
    v77.Size = UDim2.fromScale(0.95 - v76, 0.085);
    v77.AnchorPoint = Vector2.zero;
    local Frame3 = Instance.new("Frame");

    for i, v in {
        Name = "Body",
        BackgroundTransparency = 1
    } or {} do
        Frame3[i] = v;
    end;

    Frame3.Parent = Frame;
    Frame3.Position = UDim2.fromScale(0.05, 0.17);
    Frame3.Size = UDim2.fromScale(0.9, 0.8);
    Frame3.AnchorPoint = Vector2.zero;

    return Frame3;
end;

local function build(p78) -- Line: 200
    -- upvalues: Color3_fromRGB_ret (copy), Color3_fromRGB_ret5 (copy), TweenService (copy), text (copy), CombineConfig (copy), Color3_fromRGB_ret3 (copy), Color3_fromRGB_ret4 (copy), countdown (copy), Color3_new_ret (copy), Color3_fromRGB_ret6 (copy), Color3_new_ret2 (copy), card (copy), Parent (copy), journeyLevels (copy), tile (copy), ColorSequence_new_ret (copy), u1 (copy), LocalPlayer (copy), u2 (ref)
    local v79 = {
        Name = "MergeEventInfo",
        DisplayOrder = 80,
        IgnoreGuiInset = true,
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    };
    local ScreenGui = Instance.new("ScreenGui");

    for i, v in v79 or {} do
        ScreenGui[i] = v;
    end;

    ScreenGui.Parent = p78;
    ScreenGui:SetAttribute("SelfManagedText", true);
    local v80 = {
        Name = "Panel",
        BackgroundTransparency = 0.04,
        BackgroundColor3 = Color3_fromRGB_ret
    };
    local Frame = Instance.new("Frame");

    for i, v in v80 or {} do
        Frame[i] = v;
    end;

    Frame.Parent = ScreenGui;
    local Vector2_new_ret = Vector2.new(0.5, 0.5);
    Frame.Position = UDim2.fromScale(0.5, 0.5);
    Frame.Size = UDim2.fromScale(0.8, 0.8);
    Frame.AnchorPoint = Vector2_new_ret or Vector2.zero;
    local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint");

    for i, v in {
        AspectRatio = 1.75
    } or {} do
        UIAspectRatioConstraint[i] = v;
    end;

    UIAspectRatioConstraint.Parent = Frame;
    local v81 = {
        MaxSize = Vector2.new(1050, 600),
        MinSize = Vector2.new(420, 240)
    };
    local UISizeConstraint = Instance.new("UISizeConstraint");

    for i, v in v81 or {} do
        UISizeConstraint[i] = v;
    end;

    UISizeConstraint.Parent = Frame;
    local v82 = {
        CornerRadius = UDim.new(0.035, 0) or UDim.new(0.08, 0)
    };
    local UICorner = Instance.new("UICorner");

    for i, v in v82 or {} do
        UICorner[i] = v;
    end;

    UICorner.Parent = Frame;
    local v83 = {
        Thickness = 2.5,
        Color = Color3_fromRGB_ret5,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    };
    local UIStroke = Instance.new("UIStroke");

    for i, v in v83 or {} do
        UIStroke[i] = v;
    end;

    UIStroke.Parent = Frame;
    local UIScale = Instance.new("UIScale");

    for i, v in {
        Scale = 0.9
    } or {} do
        UIScale[i] = v;
    end;

    UIScale.Parent = Frame;
    TweenService:Create(UIScale, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Scale = 1
    }):Play();
    local v84 = text(Frame, "Title", (CombineConfig.EventName or "Merge"):upper() .. " EVENT", Color3_fromRGB_ret3, Enum.FontWeight.Heavy, {
        TextXAlignment = Enum.TextXAlignment.Left
    });
    v84.Position = UDim2.fromScale(0.03, 0.035);
    v84.Size = UDim2.fromScale(0.45, 0.085);
    v84.AnchorPoint = Vector2.zero;
    local v85 = text(Frame, "Subtitle", "Collect, merge and fuse your way to the <font color=\"#F2BF59\">Ultimate Void Blades</font>.", Color3_fromRGB_ret4, Enum.FontWeight.Bold, {
        TextXAlignment = Enum.TextXAlignment.Left
    }, 0.07);
    v85.Position = UDim2.fromScale(0.03, 0.115);
    v85.Size = UDim2.fromScale(0.6, 0.04);
    v85.AnchorPoint = Vector2.zero;
    local v86 = {
        Name = "TimerPill",
        BackgroundColor3 = Color3.fromRGB(12, 12, 14)
    };
    local Frame2 = Instance.new("Frame");

    for i, v in v86 or {} do
        Frame2[i] = v;
    end;

    Frame2.Parent = Frame;
    Frame2.Position = UDim2.fromScale(0.62, 0.04);
    Frame2.Size = UDim2.fromScale(0.25, 0.075);
    Frame2.AnchorPoint = Vector2.zero;
    local v87 = {
        CornerRadius = UDim.new(1, 0) or UDim.new(0.08, 0)
    };
    local UICorner2 = Instance.new("UICorner");

    for i, v in v87 or {} do
        UICorner2[i] = v;
    end;

    UICorner2.Parent = Frame2;
    local v88 = {
        Thickness = 1.5,
        Color = Color3_fromRGB_ret5,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    };
    local UIStroke2 = Instance.new("UIStroke");

    for i, v in v88 or {} do
        UIStroke2[i] = v;
    end;

    UIStroke2.Parent = Frame2;
    local u89 = text(Frame2, "Timer", countdown(), Color3_fromRGB_ret5:Lerp(Color3_new_ret, 0.35), Enum.FontWeight.ExtraBold);
    local Vector2_new_ret2 = Vector2.new(0.5, 0.5);
    u89.Position = UDim2.fromScale(0.5, 0.5);
    u89.Size = UDim2.fromScale(0.86, 0.62);
    u89.AnchorPoint = Vector2_new_ret2 or Vector2.zero;
    local v90 = {
        Name = "Close",
        Text = "X",
        TextScaled = true,
        BackgroundTransparency = 1,
        Modal = true,
        TextColor3 = Color3_fromRGB_ret6,
        FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy)
    };
    local TextButton = Instance.new("TextButton");

    for i, v in v90 or {} do
        TextButton[i] = v;
    end;

    TextButton.Parent = Frame;
    local Vector2_new_ret3 = Vector2.new(0.5, 0.5);
    TextButton.Position = UDim2.fromScale(0.968, 0.075);
    TextButton.Size = UDim2.fromScale(0.06, 0.1);
    TextButton.AnchorPoint = Vector2_new_ret3 or Vector2.zero;
    local v91 = {
        Thickness = 0.12,
        Color = Color3_new_ret2,
        StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize
    };
    local UIStroke3 = Instance.new("UIStroke");

    for i, v in v91 or {} do
        UIStroke3[i] = v;
    end;

    UIStroke3.Parent = TextButton;

    local function lines(p92, p93, p94, p95) -- Line: 239
        -- upvalues: text (ref), Color3_new_ret (ref)
        local v96 = text(p92, "Lines", table.concat(p93, "\n"), Color3_new_ret, Enum.FontWeight.Bold, {
            LineHeight = 1.15,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Top
        }, 0.07);
        v96.Position = UDim2.fromScale(0, p94);
        v96.Size = UDim2.fromScale(1, p95);
        v96.AnchorPoint = Vector2.zero;

        return v96;
    end;

    local function arrow(p97, p98, p99, p100, p101, p102, p103) -- Line: 247
        -- upvalues: text (ref), Color3_new_ret (ref)
        local v104 = text(p97, "Arrow", p102, p103 or Color3_new_ret, Enum.FontWeight.Heavy);
        local Vector2_new_ret4 = Vector2.new(0.5, 0.5);
        v104.Position = UDim2.fromScale(p98, p99);
        v104.Size = UDim2.fromScale(p100, p101);
        v104.AnchorPoint = Vector2_new_ret4 or Vector2.zero;

        return v104;
    end;

    local v105 = { 0.225, 0.17, 0.315, 0.2 };
    local v106 = {};
    local v107 = 0.03;

    for i, v in v105 do
        v106[i] = v107;
        v107 = v107 + (v + 0.015);
    end;

    local v108 = card(Frame, 1, v106[1], v105[1], "EARN SPINS", Color3_fromRGB_ret3);
    local WheelIcon = Parent.Interface:FindFirstChild("WheelIcon");

    if WheelIcon and WheelIcon:IsA("GuiObject") then
        local v109 = WheelIcon:Clone();
        v109.Parent = v108;
        local Vector2_new_ret4 = Vector2.new(0.5, 0.5);
        v109.Position = UDim2.fromScale(0.5, 0.17);
        v109.Size = UDim2.fromScale(0.42, 0.34);
        v109.AnchorPoint = Vector2_new_ret4 or Vector2.zero;
        local UIAspectRatioConstraint2 = Instance.new("UIAspectRatioConstraint");

        for i, v in {
            AspectRatio = 1
        } or {} do
            UIAspectRatioConstraint2[i] = v;
        end;

        UIAspectRatioConstraint2.Parent = v109;
    end;

    local v110 = { ("• <b>1 free spin</b> every %d min you play"):format(15), ("• <b>Spin quest</b>: +1 every %d hours"):format(2) };

    if journeyLevels() then
        table.insert(v110, "• <b>Journey rewards</b>");
    end;

    table.insert(v110, "• <b>Codes</b>: press CODES");
    local success, result = pcall(require, Parent.Progression.TeamEventConfig);

    if success and (type(result) == "table" and (type(result.EndsAt) == "number" and os.time() < result.EndsAt)) then
        table.insert(v110, "• <b>Team event</b> rewards");
    end;

    lines(v108, v110, 0.38, 0.6);
    local v111 = card(Frame, 2, v106[2], v105[2], "SPIN", CombineConfig.TierColors[1]);
    local v112 = {};

    for _, v in CombineConfig.Order do
        local v113 = CombineConfig.Families[v];

        if v113 and v113.Wheel then
            table.insert(v112, v113);
        end;
    end;

    for i, v in v112 do
        tile(v111, v.Tiers[1], 0.5, 0.14 + (i - 1) * 0.36, 0.62, 0.3, "LEVEL 1");
    end;

    lines(v111, { "Win a <b>Kitsune</b> or a <b>Kusarigama</b> on the Spin Wheel" }, 0.8, 0.2);
    local v114 = card(Frame, 3, v106[3], v105[3], "MERGE", CombineConfig.TierColors[3]);

    for i, v in CombineConfig.Order do
        local v115 = CombineConfig.Families[v];
        local v116 = 0.17 + (i - 1) * 0.43;

        for i2, v2 in v115.Tiers do
            local v117 = 0.12 + (i2 - 1) * 0.38;
            tile(v114, v2, v117, v116, 0.23, 0.26, "LEVEL " .. i2);

            if i2 < #v115.Tiers then
                local v118 = text(v114, "Arrow", ("%d× ▶"):format(v115.Costs[i2] or 5), CombineConfig.TierColors[i2 + 1] or Color3_new_ret, Enum.FontWeight.Heavy);
                local Vector2_new_ret4 = Vector2.new(0.5, 0.5);
                v118.Position = UDim2.fromScale(v117 + 0.19, v116);
                v118.Size = UDim2.fromScale(0.15, 0.1);
                v118.AnchorPoint = Vector2_new_ret4 or Vector2.zero;
            end;
        end;

        local v119 = text(v114, "Names" .. i, ("<b>%s</b>  >  %s  >  %s"):format(v115.Names[1], v115.Names[2], v115.Names[3]), Color3_fromRGB_ret4, Enum.FontWeight.Bold, nil, 0.07);
        local Vector2_new_ret4 = Vector2.new(0.5, 0.5);
        v119.Position = UDim2.fromScale(0.5, v116 + 0.2);
        v119.Size = UDim2.fromScale(1, 0.08);
        v119.AnchorPoint = Vector2_new_ret4 or Vector2.zero;
    end;

    local v120 = CombineConfig.Families[CombineConfig.Order[1]];
    lines(v114, { ("Merge <b>%d copies</b> into the next level at the <b>COMBINE</b> machine"):format(v120 and v120.Costs[1] or 5) }, 0.88, 0.12);
    local Fusion = CombineConfig.Fusion;
    local v121 = card(Frame, 4, v106[4], v105[4], "FUSE", CombineConfig.TierColors[#CombineConfig.TierColors]);

    if Fusion then
        tile(v121, Fusion.Inputs[1], 0.25, 0.13, 0.42, 0.24, "LEVEL 3");
        local v122 = text(v121, "Arrow", "+", Color3_new_ret, Enum.FontWeight.Heavy);
        local Vector2_new_ret4 = Vector2.new(0.5, 0.5);
        v122.Position = UDim2.fromScale(0.5, 0.13);
        v122.Size = UDim2.fromScale(0.12, 0.1);
        v122.AnchorPoint = Vector2_new_ret4 or Vector2.zero;
        tile(v121, Fusion.Inputs[2], 0.75, 0.13, 0.42, 0.24, "LEVEL 3");
        local v123 = text(v121, "Arrow", "▼", Color3_fromRGB_ret3 or Color3_new_ret, Enum.FontWeight.Heavy);
        local Vector2_new_ret5 = Vector2.new(0.5, 0.5);
        v123.Position = UDim2.fromScale(0.5, 0.33);
        v123.Size = UDim2.fromScale(0.2, 0.08);
        v123.AnchorPoint = Vector2_new_ret5 or Vector2.zero;
        tile(v121, Fusion.Output, 0.5, 0.56, 0.62, 0.34, "MAX LEVEL");
        lines(v121, { ("Fuse one of each into the <font color=\"#F2BF59\"><b>%s</b></font>. One per player!"):format(Fusion.Name) }, 0.8, 0.2);
    end;

    local v124 = text(Frame, "Where", "Merge and fuse at the <b>COMBINE</b> machine right next to this stand.", Color3_fromRGB_ret4, Enum.FontWeight.Bold, {
        TextXAlignment = Enum.TextXAlignment.Left
    }, 0.07);
    v124.Position = UDim2.fromScale(0.03, 0.865);
    v124.Size = UDim2.fromScale(0.6, 0.05);
    v124.AnchorPoint = Vector2.zero;
    local v125 = {
        Name = "GotIt",
        Text = "",
        AutoButtonColor = true,
        BackgroundColor3 = Color3_new_ret
    };
    local TextButton2 = Instance.new("TextButton");

    for i, v in v125 or {} do
        TextButton2[i] = v;
    end;

    TextButton2.Parent = Frame;
    local Vector2_new_ret4 = Vector2.new(1, 0.5);
    TextButton2.Position = UDim2.fromScale(0.97, 0.89);
    TextButton2.Size = UDim2.fromScale(0.22, 0.095);
    TextButton2.AnchorPoint = Vector2_new_ret4 or Vector2.zero;
    local v126 = {
        CornerRadius = UDim.new(0.3, 0) or UDim.new(0.08, 0)
    };
    local UICorner3 = Instance.new("UICorner");

    for i, v in v126 or {} do
        UICorner3[i] = v;
    end;

    UICorner3.Parent = TextButton2;
    local v127 = {
        Thickness = 2.5,
        Color = Color3_new_ret2,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    };
    local UIStroke4 = Instance.new("UIStroke");

    for i, v in v127 or {} do
        UIStroke4[i] = v;
    end;

    UIStroke4.Parent = TextButton2;
    local v128 = {
        Rotation = 90,
        Color = ColorSequence_new_ret
    };
    local UIGradient = Instance.new("UIGradient");

    for i, v in v128 or {} do
        UIGradient[i] = v;
    end;

    UIGradient.Parent = TextButton2;
    local v129 = text(TextButton2, "Label", "GOT IT", Color3_new_ret, Enum.FontWeight.Heavy);
    local Vector2_new_ret5 = Vector2.new(0.5, 0.5);
    v129.Position = UDim2.fromScale(0.5, 0.5);
    v129.Size = UDim2.fromScale(0.8, 0.6);
    v129.AnchorPoint = Vector2_new_ret5 or Vector2.zero;
    local u130 = {
        gui = ScreenGui,
        timer = u89,
        connections = {}
    };

    for _, v in { TextButton, TextButton2 } do
        table.insert(u130.connections, v.Activated:Connect(function() -- Line: 336
            -- upvalues: u1 (ref)
            u1.close();
        end));
    end;

    local connections = u130.connections;
    local AttributeChangedSignal = LocalPlayer:GetAttributeChangedSignal("InMatch");
    table.insert(connections, AttributeChangedSignal:Connect(function() -- Line: 340
        -- upvalues: LocalPlayer (ref), u1 (ref)
        if LocalPlayer:GetAttribute("InMatch") == true then
            u1.close();
        end;
    end));
    task.spawn(function() -- Line: 345
        -- upvalues: u2 (ref), u130 (copy), ScreenGui (copy), u89 (copy), countdown (ref)
        while u2 == u130 and ScreenGui.Parent do
            u89.Text = countdown();
            task.wait(30);
        end;
    end);

    return u130;
end;

function u1.open() -- Line: 354
    -- upvalues: u2 (ref), LocalPlayer (copy), build (copy), sound (copy)
    if u2 then
        return;
    end;

    local v131 = LocalPlayer:FindFirstChildOfClass("PlayerGui");

    if not v131 then
        return;
    end;

    u2 = build(v131);
    LocalPlayer:SetAttribute("MergeInfoOpen", true);
    sound("PanelOpen");
end;

function u1.close() -- Line: 367
    -- upvalues: u2 (ref), LocalPlayer (copy), sound (copy)
    local v132 = u2;

    if not v132 then
        return;
    end;

    u2 = nil;

    for _, v in v132.connections do
        v:Disconnect();
    end;

    table.clear(v132.connections);
    v132.gui:Destroy();
    LocalPlayer:SetAttribute("MergeInfoOpen", nil);
    sound("PanelClose");
end;

function u1.isOpen() -- Line: 382
    -- upvalues: u2 (ref)
    return u2 ~= nil;
end;

return u1;