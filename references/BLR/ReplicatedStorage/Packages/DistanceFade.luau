  

local u1 = {};
u1.__index = u1;
local u2 = {
    DistanceOuter = 16,
    DistanceInner = 4,
    EffectRadius = 16,
    EffectRadiusMin = 0,
    EdgeDistanceCalculations = false,
    Texture = "rbxassetid://18838056070",
    TextureTransparency = 0,
    TextureTransparencyMin = 1,
    BackgroundTransparency = 1,
    BackgroundTransparencyMin = 1,
    TextureColor = Color3.fromRGB(255, 255, 255),
    BackgroundColor = Color3.fromRGB(255, 255, 255),
    TextureSize = Vector2.new(8, 8),
    TextureOffset = Vector2.new(0, 0),
    ZOffset = 0,
    AlwaysOnTop = false,
    Brightness = 1,
    LightInfluence = 0,
    MaxDistance = 1000,
    PixelsPerStud = 100,
    SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud
};

local function SetUpFolders(p3) -- Line: 53
    if p3.WorkspaceFolder == nil then
        local DistanceFade_SurfaceParts = game.Workspace:FindFirstChild("DistanceFade_SurfaceParts");

        if DistanceFade_SurfaceParts ~= nil then
            p3.WorkspaceFolder = DistanceFade_SurfaceParts;

            return;
        end;

        p3.WorkspaceFolder = Instance.new("Folder");
        p3.WorkspaceFolder.Name = "DistanceFade_SurfaceParts";
        p3.WorkspaceFolder.Parent = workspace;
    end;
end;

function u1.new() -- Line: 82
    -- upvalues: u1 (copy), u2 (copy)
    local v4 = {
        WorkspaceFolder = nil,
        Settings = {},
        FaceSettings = {},
        TargetParts = {}
    };
    setmetatable(v4, u1);
    v4.Settings = {};

    for i, v in u2 do
        v4.Settings[i] = v;
    end;

    if v4.WorkspaceFolder == nil then
        local DistanceFade_SurfaceParts = game.Workspace:FindFirstChild("DistanceFade_SurfaceParts");

        if DistanceFade_SurfaceParts ~= nil then
            v4.WorkspaceFolder = DistanceFade_SurfaceParts;

            return v4;
        end;

        v4.WorkspaceFolder = Instance.new("Folder");
        v4.WorkspaceFolder.Name = "DistanceFade_SurfaceParts";
        v4.WorkspaceFolder.Parent = workspace;
    end;

    return v4;
end;

function u1.UpdateSettings(p5, p6) -- Line: 101
    -- upvalues: u2 (copy)
    if p5.Settings == nil then
        p5.Settings = {};
    end;

    if p6 == nil then
        for i, v in u2 do
            p5.Settings[i] = v;
        end;

        return;
    end;

    local v7 = type(p6) == "table";
    assert(v7, "Expected table as parameter");

    for i, v in u2 do
        if p6[i] == nil then
            if p5.Settings[i] == nil then
                p5.Settings[i] = v;
            end;
        else
            p5.Settings[i] = p6[i];
        end;
    end;
end;

function u1.UpdateFaceSettings(p8: table, p9: userdata, p10: any, p11: any) -- Line: 124
    if p8.FaceSettings[p9] == nil then
        p8.FaceSettings[p9] = {};
    end;

    if p8.FaceSettings[p9][p10] == nil then
        p8.FaceSettings[p9][p10] = {};
    end;

    if p11 == nil then
        p8.FaceSettings[p9][p10] = nil;

        return;
    end;

    local v12 = type(p11) == "table";
    assert(v12, "Expected table as parameter");

    for i, v in pairs(p11) do
        p8.FaceSettings[p9][p10][i] = v;
    end;
end;

local function GetNormalDirection(p13, p14) -- Line: 147
    local v15 = nil;

    if p13 == Enum.NormalId.Front then
        return p14.CFrame.LookVector;
    end;

    if p13 == Enum.NormalId.Back then
        return -p14.CFrame.LookVector;
    end;

    if p13 == Enum.NormalId.Left then
        return -p14.CFrame.RightVector;
    end;

    if p13 == Enum.NormalId.Right then
        return p14.CFrame.RightVector;
    end;

    if p13 == Enum.NormalId.Top then
        return p14.CFrame.UpVector;
    end;

    if p13 == Enum.NormalId.Bottom then
        v15 = -p14.CFrame.UpVector;
    end;

    return v15;
end;

local function GetNormalOffset(p16, p17) -- Line: 168
    local Vector3_new_ret = Vector3.new();
    local CFrame_new_ret = CFrame.new();

    if p16 == Enum.NormalId.Front then
        return p17.Size.Z / 2 * p17.CFrame.LookVector, CFrame.Angles(0, 0, 0);
    end;

    if p16 == Enum.NormalId.Back then
        return p17.Size.Z / 2 * -p17.CFrame.LookVector, CFrame.Angles(0, 3.141592653589793, 0);
    end;

    if p16 == Enum.NormalId.Left then
        return p17.Size.X / 2 * -p17.CFrame.RightVector, CFrame.Angles(0, 1.5707963267948966, 0);
    end;

    if p16 == Enum.NormalId.Right then
        return p17.Size.X / 2 * p17.CFrame.RightVector, CFrame.Angles(0, -1.5707963267948966, 0);
    end;

    if p16 == Enum.NormalId.Top then
        return p17.Size.Y / 2 * p17.CFrame.UpVector, CFrame.Angles(1.5707963267948966, 0, 0);
    end;

    if p16 == Enum.NormalId.Bottom then
        Vector3_new_ret = p17.Size.Y / 2 * -p17.CFrame.UpVector;
        CFrame_new_ret = CFrame.Angles(-1.5707963267948966, 0, 0);
    end;

    return Vector3_new_ret, CFrame_new_ret;
end;

local function GetSidePositionsOfPartAlongNormal(p18, p19, p20, p21) -- Line: 196
    local v22 = nil;
    local v23 = nil;
    local v24 = nil;
    local v25 = nil;
    local v26 = nil;

    if p20 == Enum.NormalId.Front or p20 == Enum.NormalId.Back then
        v22 = p21.X / 2;
        v23 = p21.Y / 2;
        local v27 = p21.Z / 2;
        v24 = p20 == Enum.NormalId.Front and p19.RightVector or -p19.RightVector;
        v25 = p19.UpVector;
        v26 = p20 == Enum.NormalId.Front and p19.LookVector * v27 or -p19.LookVector * v27;
    elseif p20 == Enum.NormalId.Left or p20 == Enum.NormalId.Right then
        v22 = p21.Z / 2;
        v23 = p21.Y / 2;
        local v28 = p21.X / 2;
        v24 = p20 == Enum.NormalId.Left and p19.LookVector or -p19.LookVector;
        v25 = p19.UpVector;
        v26 = p20 == Enum.NormalId.Left and -p19.RightVector * v28 or p19.RightVector * v28;
    elseif p20 == Enum.NormalId.Top or p20 == Enum.NormalId.Bottom then
        v22 = p21.X / 2;
        v23 = p21.Z / 2;
        local v29 = p21.Y / 2;
        v24 = p19.RightVector;
        v25 = p20 == Enum.NormalId.Top and -p19.LookVector or p19.LookVector;
        v26 = p20 == Enum.NormalId.Top and p19.UpVector * v29 or -p19.UpVector * v29;
    end;

    local v30 = p18 + v26;

    return {
        Left = v30 - v24 * v22,
        Right = v30 + v24 * v22,
        Top = v30 + v25 * v23,
        Bottom = v30 - v25 * v23
    };
end;

local function ToNormalSpace(p31, p32, p33) -- Line: 242
    local v34 = p31:PointToObjectSpace(p32);

    if p33 == Enum.NormalId.Front then
        return v34;
    end;

    if p33 == Enum.NormalId.Back then
        return Vector3.new(-v34.X, v34.Y, v34.Z);
    end;

    if p33 == Enum.NormalId.Left then
        return Vector3.new(-v34.Z, v34.Y, v34.X);
    end;

    if p33 == Enum.NormalId.Right then
        return Vector3.new(v34.Z, v34.Y, v34.X);
    end;

    if p33 == Enum.NormalId.Top then
        return Vector3.new(v34.X, v34.Z, v34.Y);
    end;

    return Vector3.new(v34.X, -v34.Z, v34.Y);
end;

local function NewTile() -- Line: 267
    local Frame = Instance.new("Frame");
    Frame.BackgroundTransparency = 1;
    local Frame2 = Instance.new("Frame");
    Frame2.BackgroundTransparency = 1;
    Frame2.ClipsDescendants = true;
    Frame2.AnchorPoint = Vector2.new(0.5, 0.5);
    Frame2.Position = UDim2.new(0.5, 0, 0.5, 0);
    Frame2.Size = UDim2.new(1, 0, 1, 0);
    Frame2.Name = "ScaleFrame";
    Frame2.Parent = Frame;
    local ImageLabel = Instance.new("ImageLabel");
    ImageLabel.BackgroundTransparency = 1;
    ImageLabel.Parent = Frame2;
    ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5);
    ImageLabel.Position = UDim2.new(0.5, 0, 0.5, 0);
    ImageLabel.Size = UDim2.new(9, 0, 9, 0);
    ImageLabel.ScaleType = Enum.ScaleType.Tile;
    ImageLabel.TileSize = UDim2.new(0.111, 0, 0.111, 0);

    return Frame;
end;

local function CreateGrid(p35, p36) -- Line: 290
    -- upvalues: NewTile (copy)
    local v37 = {};

    for i = 1, 4 do
        local v38 = i;

        for i2 = 1, 4 do
            local v39 = NewTile();
            v39.Parent = p36.ScaleFrame;
            v39.Size = UDim2.new(0.25, 0, 0.25, 0);
            v39.Position = UDim2.new((i2 - 1) * 0.25, 0, (v38 - 1) * 0.25, 0);
            v39.BorderSizePixel = 0;
            table.insert(v37, v39);
            v39.Name = tostring(#v37);
            local _ = i2;
        end;
    end;

    return v37;
end;

local function ApplyCircularGradient(p40) -- Line: 309
    local v41 = {
        [1] = 45,
        [4] = 135,
        [13] = -45,
        [16] = -135
    };
    local v42 = {
        [2] = 75,
        [3] = 105,
        [5] = 15,
        [8] = 165,
        [9] = -15,
        [12] = -165,
        [14] = -75,
        [15] = -105
    };

    for i = 1, #p40 do
        local v43 = p40[i];
        local v44 = i;
        local v45 = false;

        for i2, v in v41 do
            if i2 == v44 then
                local UIGradient = Instance.new("UIGradient");
                UIGradient.Parent = v43.ScaleFrame.ImageLabel;
                UIGradient.Rotation = v;
                v45 = true;
                break;
            end;
        end;

        if not v45 then
            for i2, v in v42 do
                if i2 == v44 then
                    local UIGradient = Instance.new("UIGradient");
                    UIGradient.Parent = v43.ScaleFrame.ImageLabel;
                    UIGradient.Rotation = v;
                    break;
                end;
            end;
        end;
    end;
end;

local function SetUpSurface(p46, p47, p48) -- Line: 352
    -- upvalues: GetNormalOffset (copy), CreateGrid (copy), ApplyCircularGradient (copy)
    local Part = Instance.new("Part");
    Part.Transparency = 1;
    Part.Parent = p48.WorkspaceFolder;
    Part.Size = Vector3.new(0, 0, 0);
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanTouch = false;
    Part.CanQuery = false;
    Part.Locked = true;
    local v49, v50 = GetNormalOffset(p47, p46);
    Part.CFrame = p46.CFrame * CFrame.new(v49) * v50;
    local SurfaceGui = Instance.new("SurfaceGui");
    SurfaceGui.ResetOnSpawn = false;
    SurfaceGui.ClipsDescendants = true;
    SurfaceGui.Parent = game.Players.LocalPlayer.PlayerGui;
    SurfaceGui.Adornee = Part;
    SurfaceGui.Face = Enum.NormalId.Front;
    SurfaceGui.SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud;
    SurfaceGui.PixelsPerStud = 1000;
    local Frame = Instance.new("Frame");
    Frame.Size = UDim2.new(1, 0, 1, 0);
    Frame.AnchorPoint = Vector2.new(0.5, 0.5);
    Frame.Position = UDim2.new(0.5, 0, 0.5, 0);
    Frame.BackgroundTransparency = 1;
    Frame.Name = "ScaleFrame";
    Frame.Parent = SurfaceGui;
    SurfaceGui.Enabled = false;
    local EffectResolution = p48.Settings.EffectResolution;
    ApplyCircularGradient(CreateGrid(EffectResolution, SurfaceGui), EffectResolution);

    return Part, SurfaceGui;
end;

function u1.AddFace(p51: table, p52: userdata, p53: any) -- Line: 389
    -- upvalues: SetUpSurface (copy)
    if p53 == nil then
        p53 = Enum.NormalId.Front;
    end;

    local v54, v55 = SetUpSurface(p52, p53, p51);
    local v56 = {
        SurfaceNormal = p53,
        SurfacePart = v54,
        SurfaceGui = v55
    };

    if p51.TargetParts[p52] == nil then
        p51.TargetParts[p52] = {};
    end;

    p51.TargetParts[p52][p53] = v56;
end;

function u1.RemoveFace(p57: table, p58: userdata, p59: any) -- Line: 406
    if p59 == nil then
        p59 = Enum.NormalId.Front;
    end;

    if p57.TargetParts[p58] == nil then
        return;
    end;

    local v60 = p57.TargetParts[p58][p59];

    if v60 == nil then
        return;
    end;

    v60.SurfacePart:Destroy();
    v60.SurfaceGui:Destroy();
    p57.TargetParts[p58][p59] = nil;

    if next(p57.TargetParts[p58]) == nil then
        p57.TargetParts[p58] = nil;

        if p57.WorkspaceFolder ~= nil and #p57.WorkspaceFolder:GetChildren() == 0 then
            p57.WorkspaceFolder:Destroy();
            p57.WorkspaceFolder = nil;
        end;
    end;
end;

function u1.Clear(p61) -- Line: 432
    for _, v in p61.TargetParts do
        for _, v2 in v do
            v2.SurfacePart:Destroy();
            v2.SurfaceGui:Destroy();
        end;
    end;

    if p61.WorkspaceFolder ~= nil and #p61.WorkspaceFolder:GetChildren() == 0 then
        p61.WorkspaceFolder:Destroy();
        p61.WorkspaceFolder = nil;
    end;

    table.clear(p61.TargetParts);
end;

local u62 = { {
        OffsetX = 3,
        OffsetY = 3
    }, {
        OffsetX = 2,
        OffsetY = 3
    }, {
        OffsetX = 1,
        OffsetY = 3
    }, {
        OffsetX = 0,
        OffsetY = 3
    }, {
        OffsetX = 3,
        OffsetY = 2
    }, {
        OffsetX = 2,
        OffsetY = 2
    }, {
        OffsetX = 1,
        OffsetY = 2
    }, {
        OffsetX = 0,
        OffsetY = 2
    }, {
        OffsetX = 3,
        OffsetY = 1
    }, {
        OffsetX = 2,
        OffsetY = 1
    }, {
        OffsetX = 1,
        OffsetY = 1
    }, {
        OffsetX = 0,
        OffsetY = 1
    }, {
        OffsetX = 3,
        OffsetY = 0
    }, {
        OffsetX = 2,
        OffsetY = 0
    }, {
        OffsetX = 1,
        OffsetY = 0
    }, {
        OffsetX = 0,
        OffsetY = 0
    } };

local function UpdateTextureOffset(p63, p64, p65, p66) -- Line: 524
    local function ConvertToRange(p67, p68) -- Line: 525
        local v69 = math.abs(p67) / p68 % 1;

        if p67 < 0 then
            return -v69;
        end;

        return v69;
    end;

    local v70 = math.abs(p63) / p65 % 1;

    if p63 < 0 then
        v70 = -v70;
    end;

    local v71 = math.abs(p64) / p66 % 1;

    if p64 < 0 then
        v71 = -v71;
    end;

    return UDim2.new(0.5 + v70 * p65, 0, 0.5 + v71 * p66, 0);
end;

local function AdjustGradientOffset(p72, p73) -- Line: 539
    local math_rad_ret = math.rad(p72.Rotation);
    local math_cos_ret = math.cos(math_rad_ret);
    local math_sin_ret = math.sin(math_rad_ret);

    return Vector2.new(p73.X * math_cos_ret - p73.Y * math_sin_ret, p73.X * math_sin_ret + p73.Y * math_cos_ret);
end;

function UpdateSideGradient(p74)
    local UIGradient = p74.ScaleFrame.ImageLabel.UIGradient;
    local _ = p74.ScaleFrame.Size;
    local Position = p74.ScaleFrame.ImageLabel.Position;
    local v75 = (p74.Name == "2" or (p74.Name == "3" or (p74.Name == "14" or p74.Name == "15"))) and 0 or -(Position.X.Scale + 0.5) / 200;
    local v76 = (p74.Name == "5" or (p74.Name == "8" or (p74.Name == "9" or p74.Name == "12"))) and 0 or -(Position.Y.Scale + 0.5) / 200;

    if p74.Name == "5" or p74.Name == "9" then
        v75 = v75 + 0.01;
    end;

    if p74.Name == "2" or p74.Name == "3" then
        v76 = v76 + 0.01;
    end;

    local v77 = (Position.X.Scale - 0.5) / 9 + v75;
    local v78 = (Position.Y.Scale - 0.5) / 9 + v76;

    if p74.Name == "12" or (p74.Name == "9" or (p74.Name == "2" or p74.Name == "3")) then
        v78 = -v78;
    end;

    if p74.Name == "5" or (p74.Name == "9" or (p74.Name == "15" or p74.Name == "3")) then
        v77 = -v77;
    end;

    if p74.Name ~= "2" and (p74.Name ~= "3" and (p74.Name ~= "14" and p74.Name ~= "15")) then
        local v79 = v77;
        v77 = v78;
        v78 = v79;
    end;

    local v80 = {
        NumberSequenceKeypoint.new(0, 1),
        NumberSequenceKeypoint.new(0.444, 1),
        NumberSequenceKeypoint.new(0.466, 1),
        NumberSequenceKeypoint.new(0.555, 0),
        NumberSequenceKeypoint.new(1, 0)
    };
    local v81 = {};

    for i = 1, #v80 do
        local v82 = v80[i];
        v81[i] = NumberSequenceKeypoint.new(math.clamp(v82.Time + v78, 0, 1), v82.Value);
        local _ = i;
    end;

    if v81[1].Time > 0 then
        table.insert(v81, 1, NumberSequenceKeypoint.new(0, v81[1].Value));
    end;

    if v81[#v81].Time < 1 then
        table.insert(v81, NumberSequenceKeypoint.new(1, v81[#v81].Value));
    end;

    for _, v in v81 do
        if v.Time < 0 then
            v.Time = 0;
        elseif v.Time > 1 then
            v.Time = 1;
        end;
    end;

    UIGradient.Transparency = NumberSequence.new(v81);
    local Vector2_new_ret = Vector2.new(-v77 / 4, 0);
    local math_rad_ret = math.rad(UIGradient.Rotation);
    local math_cos_ret = math.cos(math_rad_ret);
    local math_sin_ret = math.sin(math_rad_ret);
    UIGradient.Offset = Vector2.new(Vector2_new_ret.X * math_cos_ret - Vector2_new_ret.Y * math_sin_ret, Vector2_new_ret.X * math_sin_ret + Vector2_new_ret.Y * math_cos_ret);
end;

function UpdateCornerGradient(p83)
    local UIGradient = p83.ScaleFrame.ImageLabel.UIGradient;
    local _ = p83.ScaleFrame.Size;
    local Position = p83.ScaleFrame.ImageLabel.Position;
    local v84 = (Position.X.Scale - 0.5) / 9 + -(Position.X.Scale + 0.5) / 75;
    local v85 = (Position.Y.Scale - 0.5) / 9 + -(Position.Y.Scale + 0.5) / 75;

    if p83.Name == "13" or p83.Name == "1" then
        v84 = -v84;
    end;

    if p83.Name == "1" or p83.Name == "4" then
        v85 = -v85;
    end;

    local v86 = p83.Name == "1" and -0.015 or (p83.Name == "4" and 0.0025 or (p83.Name == "16" and 0.02 or (p83.Name == "13" and 0.0025 or 0)));
    local v87 = (v84 + v85) / 1.4142135623730951 + v86;
    local v88 = {
        NumberSequenceKeypoint.new(0, 1),
        NumberSequenceKeypoint.new(0.444, 1),
        NumberSequenceKeypoint.new(0.51, 1),
        NumberSequenceKeypoint.new(0.555, 0.2),
        NumberSequenceKeypoint.new(1, 0.2)
    };
    local v89 = {};

    for i = 1, #v88 do
        local v90 = v88[i];
        v89[i] = NumberSequenceKeypoint.new(math.clamp(v90.Time + v87, 0, 1), v90.Value);
        local _ = i;
    end;

    if v89[1].Time > 0 then
        table.insert(v89, 1, NumberSequenceKeypoint.new(0, v89[1].Value));
    end;

    if v89[#v89].Time < 1 then
        table.insert(v89, NumberSequenceKeypoint.new(1, v89[#v89].Value));
    end;

    if p83.Name == "1" or p83.Name == "4" then
        local v91 = {};

        for i, v in v89 do
            if v.Time == 1 then
                v89 = v91;

                for i2 = 1, i do
                    table.insert(v89, v89[i2]);
                    v91 = v89;
                    local _ = i2;
                    v89 = v91;
                end;

                break;
            end;
        end;
    end;

    for _, v in v89 do
        if v.Time < 0 then
            v.Time = 0;
        elseif v.Time > 1 then
            v.Time = 1;
        end;
    end;

    UIGradient.Transparency = NumberSequence.new(v89);
    local Vector2_new_ret = Vector2.new(-((v84 + v85) / 1.4142135623730951 + v86) / 4, 0);
    local math_rad_ret = math.rad(UIGradient.Rotation);
    local math_cos_ret = math.cos(math_rad_ret);
    local math_sin_ret = math.sin(math_rad_ret);
    UIGradient.Offset = Vector2.new(Vector2_new_ret.X * math_cos_ret - Vector2_new_ret.Y * math_sin_ret, Vector2_new_ret.X * math_sin_ret + Vector2_new_ret.Y * math_cos_ret);
end;

function u1.Step(p92: table, p93: vector?) -- Line: 697
    -- upvalues: GetNormalOffset (copy), GetNormalDirection (copy), GetSidePositionsOfPartAlongNormal (copy), ToNormalSpace (copy), u62 (copy), UpdateTextureOffset (copy)
    if p92.WorkspaceFolder == nil then
        local DistanceFade_SurfaceParts = game.Workspace:FindFirstChild("DistanceFade_SurfaceParts");

        if DistanceFade_SurfaceParts == nil then
            p92.WorkspaceFolder = Instance.new("Folder");
            p92.WorkspaceFolder.Name = "DistanceFade_SurfaceParts";
            p92.WorkspaceFolder.Parent = workspace;
        else
            p92.WorkspaceFolder = DistanceFade_SurfaceParts;
        end;
    end;

    local Settings = p92.Settings;

    if Settings.EffectRadiusMin > Settings.EffectRadius then
        Settings.EffectRadiusMin = Settings.EffectRadius;
    end;

    if Settings.DistanceInner > Settings.DistanceOuter then
        Settings.DistanceInner = Settings.DistanceOuter;
    end;

    if p93 == nil then
        local Character = game.Players.LocalPlayer.Character;

        if Character == nil then
            return;
        end;

        p93 = Character.HumanoidRootPart.Position;
    end;

    for i, v in p92.TargetParts do
        local v94 = i;

        for i2, v2 in v do
            local v95, v96, v97, v98, v99, v100, v101, v102;
            local v103 = 0;

            while true do
                if v103 == 0 then
                    v103 = -1;
                    v95 = {};

                    if p92.FaceSettings[v94] == nil or p92.FaceSettings[v94][i2] == nil then
                        v101 = v2;
                    else
                        v101 = v2;
                        local v104 = i2;

                        for i3, v3 in Settings do
                            v95[i3] = v3;

                            if p92.FaceSettings[v94][v104][i3] ~= nil then
                                v95[i3] = p92.FaceSettings[v94][v104][i3];
                            end;
                        end;
                    end;

                    if next(v95) == nil then
                        v95 = Settings;
                    end;

                    v99 = v101.SurfacePart;
                    v98 = v101.SurfaceGui;
                    v98.ZOffset = v95.ZOffset;
                    v98.AlwaysOnTop = v95.AlwaysOnTop;
                    v98.Brightness = v95.Brightness;
                    v98.LightInfluence = v95.LightInfluence;
                    v98.MaxDistance = v95.MaxDistance;
                    v98.PixelsPerStud = v95.PixelsPerStud;
                    v98.SizingMode = v95.SizingMode;
                    local _ = v94.CFrame;
                    local v105, v106 = GetNormalOffset(v101.SurfaceNormal, v94);
                    v100 = GetNormalDirection(v101.SurfaceNormal, v94);
                    local v107 = p93 - (v94.Position + v105);
                    local v108 = v107 - v100 * v107:Dot(v100);
                    local v109 = v94.Position + v108 + v105;
                    local v110 = v94.CFrame * CFrame.new(v105) * v106;
                    v99.CFrame = CFrame.new(v109) * CFrame.fromMatrix(Vector3.new(), v110.RightVector, v110.UpVector);
                    local Magnitude = (p93 - v99.Position).Magnitude;
                    v96 = GetSidePositionsOfPartAlongNormal(v94.Position, v94.CFrame, v101.SurfaceNormal, v94.Size);
                    local v111;

                    if v95.EdgeDistanceCalculations then
                        local v112 = (1 / 0);
                        local v113 = ToNormalSpace(CFrame.new(v96.Top) * (v94.CFrame - v94.CFrame.Position), p93, v101.SurfaceNormal);
                        local Magnitude2 = Vector3.new(0, v113.Y, v113.Z).Magnitude;

                        if Magnitude2 >= v112 then
                            Magnitude2 = v112;
                        end;

                        local v114 = ToNormalSpace(CFrame.new(v96.Bottom) * (v94.CFrame - v94.CFrame.Position), p93, v101.SurfaceNormal);
                        local Magnitude3 = Vector3.new(0, v114.Y, v114.Z).Magnitude;

                        if Magnitude3 >= Magnitude2 then
                            Magnitude3 = Magnitude2;
                        end;

                        local v115 = ToNormalSpace(CFrame.new(v96.Left) * (v94.CFrame - v94.CFrame.Position), p93, v101.SurfaceNormal);
                        local Magnitude4 = Vector3.new(v115.X, 0, v115.Z).Magnitude;

                        if Magnitude4 >= Magnitude3 then
                            Magnitude4 = Magnitude3;
                        end;

                        local v116 = ToNormalSpace(CFrame.new(v96.Right) * (v94.CFrame - v94.CFrame.Position), p93, v101.SurfaceNormal);
                        v111 = Vector3.new(v116.X, 0, v116.Z).Magnitude;

                        if v111 >= Magnitude4 then
                            v111 = Magnitude4;
                        end;

                        if v111 >= Magnitude then
                            v111 = Magnitude;
                        end;
                    else
                        v111 = Magnitude;
                    end;

                    v97 = 1 / (v95.TextureSize.X * 2 / v95.EffectRadius);

                    if v111 < v95.DistanceInner then
                        v103 = 1;
                        continue;
                    end;

                    if v111 < v95.DistanceOuter then
                        v98.Enabled = true;
                        v102 = v97 - math.clamp((v111 - v95.DistanceInner) / (v95.DistanceOuter - v95.DistanceInner), 0, 1);
                        v103 = 2;
                        continue;
                    end;

                    v98.Enabled = false;
                    v103 = 3;
                    continue;
                elseif v103 == 1 then
                    v103 = -1;
                    v98.Enabled = true;
                    v102 = v97;
                    v103 = 2;
                    continue;
                elseif v103 == 2 then
                    v103 = -1;
                    local v117 = v95.EffectRadius / v97;
                    local v118 = (v95.EffectRadiusMin + (v95.EffectRadius - v95.EffectRadiusMin) * v102 * (v95.TextureSize.X * 2 / v95.EffectRadius)) * 2;
                    v99.Size = Vector3.new(v118, v118, v99.Size.Z);
                    local v119 = GetSidePositionsOfPartAlongNormal(v99.Position, v99.CFrame, Enum.NormalId.Front, v99.Size);
                    local v120 = {
                        Left = ToNormalSpace(v94.CFrame, v96.Left, v101.SurfaceNormal),
                        Right = ToNormalSpace(v94.CFrame, v96.Right, v101.SurfaceNormal),
                        Top = ToNormalSpace(v94.CFrame, v96.Top, v101.SurfaceNormal),
                        Bottom = ToNormalSpace(v94.CFrame, v96.Bottom, v101.SurfaceNormal)
                    };
                    local v121 = {
                        Left = ToNormalSpace(v94.CFrame, v119.Left, v101.SurfaceNormal),
                        Right = ToNormalSpace(v94.CFrame, v119.Right, v101.SurfaceNormal),
                        Top = ToNormalSpace(v94.CFrame, v119.Top, v101.SurfaceNormal),
                        Bottom = ToNormalSpace(v94.CFrame, v119.Bottom, v101.SurfaceNormal)
                    };
                    local v122 = v121.Left.X >= v120.Left.X and 1 or 1 - (v120.Left.X - v121.Left.X) / v99.Size.X;
                    local v123 = v121.Right.X <= v120.Right.X and 1 or 1 - (v121.Right.X - v120.Right.X) / v99.Size.X;
                    local v124 = v121.Bottom.Y >= v120.Bottom.Y and 1 or 1 - (v120.Bottom.Y - v121.Bottom.Y) / v99.Size.Y;
                    local v125 = v121.Top.Y <= v120.Top.Y and 1 or 1 - (v121.Top.Y - v120.Top.Y) / v99.Size.Y;

                    if v125 < 0 or (v124 < 0 or (v122 < 0 or v123 < 0)) then
                        v98.Enabled = false;
                    else
                        local v126 = 1 - (1 - v122 + (1 - v123));
                        local v127 = 1 - (1 - v125 + (1 - v124));
                        local v128 = v122 <= v123 and 1 or -1;
                        local v129 = v124 <= v125 and 1 or -1;
                        local v130 = v99.Size * Vector3.new(v126, v127, 1);
                        local v131;

                        if v123 < 1 and v122 < 1 then
                            local v132 = (v123 - v122) * 2;
                            local v133 = (v99.Size.X - v130.X) / 2 * v132;
                            local v134 = (v121.Right.X + v121.Left.X) / 2;
                            local v135 = (v120.Right.X + v120.Left.X) / 2;
                            local math_abs_ret = math.abs(v120.Right.X - v120.Left.X);
                            v131 = v133 - (v134 + v133 + v130.X - (v135 + math_abs_ret));
                            v128 = v132 / ((1 - (v123 + v122 - 1)) * 2);
                        else
                            v131 = (v99.Size.X - v130.X) / 2 * v128;
                        end;

                        local v136;

                        if v125 < 1 and v124 < 1 then
                            local v137 = (v125 - v124) * 2;
                            local v138 = (v99.Size.Y - v130.Y) / 2 * v137;
                            local v139 = (v121.Top.Y + v121.Bottom.Y) / 2;
                            local v140 = (v120.Top.Y + v120.Bottom.Y) / 2;
                            local math_abs_ret = math.abs(v120.Top.Y - v120.Bottom.Y);
                            v136 = v138 - (v139 + v138 + v130.Y - (v140 + math_abs_ret));
                            v129 = v137 / ((1 - (v125 + v124 - 1)) * 2);
                        else
                            v136 = (v99.Size.Y - v130.Y) / 2 * v129;
                        end;

                        v99.CFrame = v99.CFrame * CFrame.new(v131, v136, 0);
                        v99.Size = v130;
                        v98.ScaleFrame.Size = UDim2.new(1 / v126, 0, 1 / v127, 0);
                        v98.ScaleFrame.Position = UDim2.new(0.5 - (1 - 1 / v126) / 2 * v128, 0, 0.5 - (1 - 1 / v127) / 2 * v129, 0);
                        local v141 = math.min((1 - (v102 + (1 - v97))) / (0.8 - (1 - v97)), 1) * (v97 <= 1 and 1 or v97);
                        local v142 = v141 < 0 and 1 or v141;
                        local v143 = v95.TextureTransparency + (v95.TextureTransparencyMin - v95.TextureTransparency) * v142;
                        local v144 = v95.BackgroundTransparency + (v95.BackgroundTransparencyMin - v95.BackgroundTransparency) * v142;
                        local v145 = 1 / (v102 + (v97 - v102) * (v95.EffectRadiusMin / v95.EffectRadius));
                        local Position = v99.Position;
                        local v146 = Position - v100 * Position:Dot(v100);
                        local v147 = ToNormalSpace(v94.CFrame, v146, v101.SurfaceNormal);
                        local v148 = (1 / v145 - 1) * 3 * v145;
                        local v149 = -(1 - v126) / 0.5 * v128;
                        local v150 = -(1 - v127) / 0.5 * v129;
                        local v151 = -v95.TextureOffset.X / v95.TextureSize.X * v145;
                        local v152 = v95.TextureSize.Y / v95.TextureSize.X;
                        local v153 = v152 - 1;
                        local v154 = -v95.TextureOffset.Y / v95.TextureSize.X * v145;

                        for _, child in v98.ScaleFrame:GetChildren() do
                            local ImageLabel = child.ScaleFrame.ImageLabel;
                            ImageLabel.Image = v95.Texture;
                            ImageLabel.ImageTransparency = v143;
                            ImageLabel.ImageColor3 = v95.TextureColor;
                            ImageLabel.BackgroundTransparency = v144;
                            ImageLabel.BackgroundColor3 = v95.BackgroundColor;
                            local v155 = u62[tonumber(child.Name)];
                            local v156 = v151 + (1 / v145 - 1) * v145 * v155.OffsetX + v149 + v148 + v147.X / (v117 / 2) * v145;
                            local v157 = v154 + (1 / v145 - 1) * v145 * v155.OffsetY + v150 + v148 + v147.Y / (v117 / 2) * v145;
                            ImageLabel.TileSize = UDim2.new(math.max(0.111 * v145, 0.001), 0, math.max(0.111 * v145 * v152, 0.001), 0);

                            if child.Name == "1" or (child.Name == "2" or (child.Name == "3" or child.Name == "4")) then
                                v157 = v157 - v153 * v145;
                            elseif child.Name == "9" or (child.Name == "10" or (child.Name == "11" or child.Name == "12")) then
                                v157 = v157 + v153 * v145;
                            elseif child.Name == "13" or (child.Name == "14" or (child.Name == "15" or child.Name == "16")) then
                                v157 = v157 + v153 * v145 * 2;
                            end;

                            local v158 = UpdateTextureOffset(v156, v157, v145, v145 * v152);
                            local v159 = 0;
                            local v160 = 0;

                            if v158.X.Scale > 4.5 then
                                v159 = v158.X.Scale - 4.5;
                            elseif v158.X.Scale < -3.5 then
                                v159 = v158.X.Scale + 3.5;
                            end;

                            if v158.Y.Scale > 4.5 then
                                v160 = v158.Y.Scale - 4.5;
                            elseif v158.Y.Scale < -3.5 then
                                v160 = v158.Y.Scale + 3.5;
                            end;

                            local Vector2_new_ret = Vector2.new(-v159, -v160);

                            if v160 < 0 then
                                if v102 < 0.125 then
                                    Vector2_new_ret = Vector2.new(Vector2_new_ret.X, -v160);
                                else
                                    Vector2_new_ret = Vector2.new(Vector2_new_ret.X, 1 * v145);
                                end;
                            end;

                            if v159 < 0 then
                                if v102 < 0.125 then
                                    Vector2_new_ret = Vector2.new(-v159, Vector2_new_ret.Y);
                                else
                                    Vector2_new_ret = Vector2.new(1 * v145, Vector2_new_ret.Y);
                                end;
                            end;

                            ImageLabel.Position = UDim2.new(v158.X.Scale + Vector2_new_ret.X, 0, v158.Y.Scale + Vector2_new_ret.Y, 0);
                            local v161 = { 1, 4, 13, 16 };

                            if table.find({ 2, 3, 5, 9, 8, 12, 14, 15 }, (tonumber(child.Name))) then
                                local _, _ = pcall(function() -- Line: 972
                                    -- upvalues: child (copy)
                                    UpdateSideGradient(child);
                                end);
                            elseif table.find(v161, (tonumber(child.Name))) then
                                local _, _ = pcall(function() -- Line: 976
                                    -- upvalues: child (copy)
                                    UpdateCornerGradient(child);
                                end);
                            end;
                        end;
                    end;

                    v103 = 3;
                    continue;
                elseif v103 == 3 then
                    v103 = -1;
                    break;
                else
                    break;
                end;
            end;
        end;
    end;
end;

return u1;