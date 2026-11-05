  

 

local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
local LocalPlayer = Players.LocalPlayer;

if not LocalPlayer then
    Players:GetPropertyChangedSignal("LocalPlayer"):Wait();
    LocalPlayer = Players.LocalPlayer;
end;

local u4 = (function(p1, p2) -- Line: 10, Name: waitForChildOfClass
    local v3 = p1:FindFirstChildOfClass(p2);

    while not v3 or v3.ClassName ~= p2 do
        v3 = p1.ChildAdded:Wait();
    end;

    return v3;
end)(LocalPlayer, "PlayerGui");
local u5 = UDim2.new(0, 326, 0, 58);
local u6 = UDim2.new(0, 80, 0, 58);
local u7 = Color3.fromRGB(32, 32, 32);
local u8 = Color3.fromRGB(200, 200, 200);

local function create(u9) -- Line: 28
    return function(p10) -- Line: 29
        -- upvalues: u9 (copy)
        local v11 = Instance.new(u9);
        local Parent = p10.Parent;
        p10.Parent = nil;

        for i, v in pairs(p10) do
            if type(i) == "string" then
                v11[i] = v;
            else
                v.Parent = v11;
            end;
        end;

        v11.Parent = Parent;

        return v11;
    end;
end;

local u12 = false;
local u13 = nil;
local u14 = nil;
local u15 = nil;
local u16 = nil;
local u17 = nil;

local function initializeUI() -- Line: 54
    -- upvalues: u12 (ref), u13 (ref), u6 (copy), u7 (copy), u8 (copy), u4 (copy), u14 (ref), u15 (ref), u16 (ref), u17 (ref)
    assert(not u12);
    local u18 = "ScreenGui";

    local function v21(p19) -- Line: 29
        -- upvalues: u18 (copy)
        local v20 = Instance.new(u18);
        local Parent = p19.Parent;
        p19.Parent = nil;

        for i, v in pairs(p19) do
            if type(i) == "string" then
                v20[i] = v;
            else
                v.Parent = v20;
            end;
        end;

        v20.Parent = Parent;

        return v20;
    end;

    local v22 = {
        Name = "RbxCameraUI",
        AutoLocalize = false,
        Enabled = true,
        DisplayOrder = -1,
        IgnoreGuiInset = false,
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    };
    local u23 = "ImageLabel";

    local function v26(p24) -- Line: 29
        -- upvalues: u23 (copy)
        local v25 = Instance.new(u23);
        local Parent = p24.Parent;
        p24.Parent = nil;

        for i, v in pairs(p24) do
            if type(i) == "string" then
                v25[i] = v;
            else
                v.Parent = v25;
            end;
        end;

        v25.Parent = Parent;

        return v25;
    end;

    local v27 = {
        Name = "Toast",
        Visible = false,
        AnchorPoint = Vector2.new(0.5, 0),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Position = UDim2.new(0.5, 0, 0, 8),
        Size = u6,
        Image = "rbxasset://textures/ui/Camera/CameraToast9Slice.png",
        ImageColor3 = u7,
        ImageRectSize = Vector2.new(6, 6),
        ImageTransparency = 1,
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(3, 3, 3, 3),
        ClipsDescendants = true
    };
    local u28 = "Frame";

    local function v31(p29) -- Line: 29
        -- upvalues: u28 (copy)
        local v30 = Instance.new(u28);
        local Parent = p29.Parent;
        p29.Parent = nil;

        for i, v in pairs(p29) do
            if type(i) == "string" then
                v30[i] = v;
            else
                v.Parent = v30;
            end;
        end;

        v30.Parent = Parent;

        return v30;
    end;

    local v32 = {
        Name = "IconBuffer",
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Position = UDim2.new(0, 0, 0, 0),
        Size = UDim2.new(0, 80, 1, 0)
    };
    local u33 = "ImageLabel";
    v32[1] = (function(p34) -- Line: 29
    -- upvalues: u33 (copy)
    local v35 = Instance.new(u33);
    local Parent = p34.Parent;
    p34.Parent = nil;

    for i, v in pairs(p34) do
        if type(i) == "string" then
            v35[i] = v;
        else
            v.Parent = v35;
        end;
    end;

    v35.Parent = Parent;

    return v35;
end)({
    Name = "Icon",
    BackgroundTransparency = 1,
    ZIndex = 2,
    Image = "rbxasset://textures/ui/Camera/CameraToastIcon.png",
    ImageTransparency = 1,
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.new(0.5, 0, 0.5, 0),
    Size = UDim2.new(0, 48, 0, 48),
    ImageColor3 = u8
});
    local v36 = v31(v32);
    local u37 = "Frame";

    local function v40(p38) -- Line: 29
        -- upvalues: u37 (copy)
        local v39 = Instance.new(u37);
        local Parent = p38.Parent;
        p38.Parent = nil;

        for i, v in pairs(p38) do
            if type(i) == "string" then
                v39[i] = v;
            else
                v.Parent = v39;
            end;
        end;

        v39.Parent = Parent;

        return v39;
    end;

    local v41 = {
        Name = "TextBuffer",
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Position = UDim2.new(0, 80, 0, 0),
        Size = UDim2.new(1, -80, 1, 0),
        ClipsDescendants = true
    };
    local u42 = "TextLabel";
    local u43 = "TextLabel";
    v41[1], v41[2] = (function(p44) -- Line: 29
    -- upvalues: u42 (copy)
    local v45 = Instance.new(u42);
    local Parent = p44.Parent;
    p44.Parent = nil;

    for i, v in pairs(p44) do
        if type(i) == "string" then
            v45[i] = v;
        else
            v.Parent = v45;
        end;
    end;

    v45.Parent = Parent;

    return v45;
end)({
    Name = "Upper",
    BackgroundTransparency = 1,
    Text = "Camera control enabled",
    TextTransparency = 1,
    TextSize = 19,
    AnchorPoint = Vector2.new(0, 1),
    Position = UDim2.new(0, 0, 0.5, 0),
    Size = UDim2.new(1, 0, 0, 19),
    Font = Enum.Font.GothamSemibold,
    TextColor3 = u8,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextYAlignment = Enum.TextYAlignment.Center
}), (function(p46) -- Line: 29
    -- upvalues: u43 (copy)
    local v47 = Instance.new(u43);
    local Parent = p46.Parent;
    p46.Parent = nil;

    for i, v in pairs(p46) do
        if type(i) == "string" then
            v47[i] = v;
        else
            v.Parent = v47;
        end;
    end;

    v47.Parent = Parent;

    return v47;
end)({
    Name = "Lower",
    BackgroundTransparency = 1,
    Text = "Right mouse button to toggle",
    TextTransparency = 1,
    TextSize = 15,
    AnchorPoint = Vector2.new(0, 0),
    Position = UDim2.new(0, 0, 0.5, 3),
    Size = UDim2.new(1, 0, 0, 15),
    Font = Enum.Font.Gotham,
    TextColor3 = u8,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextYAlignment = Enum.TextYAlignment.Center
});
    v27[1], v27[2] = v36, v40(v41);
    v22[1] = v26(v27);
    v22.Parent = u4;
    u13 = v21(v22);
    u14 = u13.Toast;
    u15 = u14.IconBuffer.Icon;
    u16 = u14.TextBuffer.Upper;
    u17 = u14.TextBuffer.Lower;
    u12 = true;
end;

local u48 = {};

function u48.setCameraModeToastEnabled(p49) -- Line: 157
    -- upvalues: u12 (ref), initializeUI (copy), u14 (ref), u48 (copy)
    if not (p49 or u12) then
        return;
    end;

    if not u12 then
        initializeUI();
    end;

    u14.Visible = p49;

    if not p49 then
        u48.setCameraModeToastOpen(false);
    end;
end;

local u50 = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);

function u48.setCameraModeToastOpen(p51) -- Line: 175
    -- upvalues: u12 (ref), TweenService (copy), u14 (ref), u50 (copy), u5 (copy), u6 (copy), u15 (ref), u16 (ref), u17 (ref)
    assert(u12);
    TweenService:Create(u14, u50, {
        Size = p51 and u5 or u6,
        ImageTransparency = p51 and 0.4 or 1
    }):Play();
    TweenService:Create(u15, u50, {
        ImageTransparency = p51 and 0 or 1
    }):Play();
    TweenService:Create(u16, u50, {
        TextTransparency = p51 and 0 or 1
    }):Play();
    TweenService:Create(u17, u50, {
        TextTransparency = p51 and 0 or 1
    }):Play();
end;

return u48;