  

 

local u1 = {};
local u2 = {
    Color = "TextColor3",
    StrokeColor = "TextStrokeColor3",
    ImageColor = "ImageColor3"
};
u1.ColorShortcuts = {};
u1.ColorShortcuts.White = Color3.new(1, 1, 1);
u1.ColorShortcuts.Black = Color3.new(0, 0, 0);
u1.ColorShortcuts.Red = Color3.new(1, 0.4, 0.4);
u1.ColorShortcuts.Green = Color3.new(0.4, 1, 0.4);
u1.ColorShortcuts.Blue = Color3.fromRGB(0, 170, 255);
u1.ColorShortcuts.Purple = Color3.new(0.4, 0.4, 1);
u1.ColorShortcuts.Cyan = Color3.new(0.4, 0.85, 1);
u1.ColorShortcuts.Orange = Color3.new(1, 0.5, 0.2);
u1.ColorShortcuts.Yellow = Color3.new(1, 0.9, 0.2);
u1.ColorShortcuts.UG = Color3.fromRGB(183, 202, 255);
u1.ColorShortcuts.RareBlue = Color3.fromRGB(75, 150, 255);
u1.ColorShortcuts.Lilac = Color3.fromRGB(104, 95, 164);
u1.ColorShortcuts.Pink = Color3.fromRGB(255, 0, 255);
u1.ImageShortcuts = {};
u1.ImageShortcuts.Eggplant = 639588687;
u1.ImageShortcuts.Thinking = 955646496;
u1.ImageShortcuts.Sad = 947900188;
u1.ImageShortcuts.Happy = 414889555;
u1.ImageShortcuts.Despicable = 711674643;
local u3 = {
    ContainerHorizontalAlignment = "Left",
    ContainerVerticalAlignment = "Center",
    TextYAlignment = "Bottom",
    TextScaled = true,
    TextScaleRelativeTo = "Frame",
    TextScale = 0.2,
    TextSize = 20,
    Font = "SourceSans",
    TextColor3 = "White",
    TextStrokeColor3 = "Black",
    TextTransparency = 0,
    TextStrokeTransparency = 1,
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    ImageColor3 = "White",
    ImageTransparency = 0,
    ImageRectOffset = "0,0",
    ImageRectSize = "0,0",
    AnimateStepTime = 0,
    AnimateStepGrouping = "Letter",
    AnimateStepFrequency = 4,
    AnimateYield = 0,
    AnimateStyle = "Fade",
    AnimateStyleTime = 0.185,
    AnimateStyleNumPeriods = 3,
    AnimateStyleAmplitude = 0.5
};
local u25 = {
    Appear = function(p4) -- Line: 231, Name: Appear
        p4.Visible = true;
    end,

    Fade = function(p5, p6, p7) -- Line: 235, Name: Fade
        p5.Visible = true;

        if p5:IsA("TextLabel") then
            p5.TextTransparency = 1 - p6 * (1 - p7.TextTransparency);

            return;
        end;

        if p5:IsA("ImageLabel") then
            p5.ImageTransparency = 1 - p6 * (1 - p7.ImageTransparency);
        end;
    end,

    Wiggle = function(p8, p9, p10) -- Line: 244, Name: Wiggle
        p8.Visible = true;
        local v11 = p10.InitialSize.Y.Offset * (1 - p9) * p10.AnimateStyleAmplitude;
        p8.Position = p10.InitialPosition + UDim2.new(0, 0, 0, math.sin(p9 * 3.141592653589793 * 2 * p10.AnimateStyleNumPeriods) * v11 / 2);
    end,

    Swing = function(p12, p13, p14) -- Line: 250, Name: Swing
        p12.Visible = true;
        local v15 = 90 * (1 - p13) * p14.AnimateStyleAmplitude;
        p12.Rotation = math.sin(p13 * 3.141592653589793 * 2 * p14.AnimateStyleNumPeriods) * v15;
    end,

    Spin = function(p16, p17, p18) -- Line: 256, Name: Spin
        p16.Visible = true;
        p16.Position = p18.InitialPosition + UDim2.new(0, p18.InitialSize.X.Offset / 2, 0, p18.InitialSize.Y.Offset / 2);
        p16.AnchorPoint = Vector2.new(0.5, 0.5);
        p16.Rotation = p17 * p18.AnimateStyleNumPeriods * 360;
    end,

    Rainbow = function(p19, p20, p21) -- Line: 263, Name: Rainbow
        p19.Visible = true;
        local v22 = Color3.fromHSV(p20 * p21.AnimateStyleNumPeriods % 1, 1, 1);

        if p19:IsA("TextLabel") then
            local v23 = getColorFromString(p21.TextColor3);
            p19.TextColor3 = Color3.new(v22.r + p20 * (v23.r - v22.r), v22.g + p20 * (v23.g - v22.g), v22.b + p20 * (v23.b - v22.b));

            return;
        end;

        local v24 = getColorFromString(p21.ImageColor3);
        p19.ImageColor3 = Color3.new(v22.r + p20 * (v24.r - v22.r), v22.g + p20 * (v24.g - v22.g), v22.b + p20 * (v24.b - v22.b));
    end
};
local TextService = game:GetService("TextService");
local RunService = game:GetService("RunService");
local u26 = 0;

function getLayerCollector(p27)
    if not p27 then
        return nil;
    end;

    if p27:IsA("LayerCollector") then
        return p27;
    end;

    if p27 and p27.Parent then
        return getLayerCollector(p27.Parent);
    end;

    return nil;
end;

function shallowCopy(p28)
    local v29 = {};

    for i, v in pairs(p28) do
        v29[i] = v;
    end;

    return v29;
end;

function getColorFromString(p30)
    -- upvalues: u1 (copy)
    if u1.ColorShortcuts[p30] then
        return u1.ColorShortcuts[p30];
    end;

    if not p30:match("^#") then
        local v31, v32, v33 = p30:match("(%d+),(%d+),(%d+)");

        return Color3.new(v31 / 255, v32 / 255, v33 / 255);
    end;

    local v34 = p30:sub(2);

    if #v34 == 6 then
        local v35 = v34:sub(1, 2);
        local v36 = v34:sub(3, 4);
        local v37 = v34:sub(5, 6);

        return Color3.new(tonumber(v35, 16) / 255, tonumber(v36, 16) / 255, tonumber(v37, 16) / 255);
    end;

    if #v34 == 3 then
        local v38 = v34:sub(1, 1);
        local v39 = v34:sub(2, 2);
        local v40 = v34:sub(3, 3);

        return Color3.new(tonumber(v38, 16) / 15, tonumber(v39, 16) / 15, tonumber(v40, 16) / 15);
    end;
end;

function getVector2FromString(p41)
    local v42, v43 = p41:match("(%d+),(%d+)");

    return Vector2.new(v42, v43);
end;

function setHorizontalAlignment(p44, p45)
    if p45 == "Left" then
        p44.AnchorPoint = Vector2.new(0, 0);
        p44.Position = UDim2.new(0, 0, 0, 0);

        return;
    end;

    if p45 ~= "Center" then
        if p45 == "Right" then
            p44.AnchorPoint = Vector2.new(1, 0);
            p44.Position = UDim2.new(1, 0, 0, 0);
        end;

        return;
    end;

    p44.AnchorPoint = Vector2.new(0.5, 0);
    p44.Position = UDim2.new(0.5, 0, 0, 0);
end;

function u1.New(p46, u47, p48, p49, p50, p51) -- Line: 339
    -- upvalues: u2 (copy), u3 (copy), TextService (copy), u1 (copy), u26 (ref), RunService (copy), u25 (copy)
    for _, child in pairs(u47:GetChildren()) do
        child:Destroy();
    end;

    local u52 = p50 == nil and true or p50;
    local u53 = {};
    local u54 = {};

    if p51 then
        p48 = p51.Text;
        p49 = p51.StartingProperties;
    end;

    local u55 = {};
    local u56 = {};
    local u57 = {};
    local u58 = 0;
    local u59 = false;
    local TextLabel = Instance.new("TextLabel");
    local ImageLabel = Instance.new("ImageLabel");
    local u60 = getLayerCollector(u47);
    TextLabel.AutoLocalize = false;
    local u61 = nil;
    local u62 = nil;

    local function applyMarkup(p63, p64) -- Line: 367
        -- upvalues: u2 (ref), u54 (copy), u53 (ref), u61 (ref), u55 (copy), u3 (ref), u62 (ref)
        local v65 = u2[p63] or p63;

        if p64 == "/" then
            if u54[v65] then
                p64 = u54[v65];
            else
                warn("Attempt to default <" .. v65 .. "> to value with no default");
            end;
        end;

        if tonumber(p64) then
            p64 = tonumber(p64);
        elseif p64 == "false" or p64 == "true" then
            p64 = p64 == "true";
        end;

        u53[v65] = p64;

        if not u61(v65, p64) then
            if v65 == "ContainerHorizontalAlignment" and u55[#u55] then
                setHorizontalAlignment(u55[#u55].Container, p64);
            elseif not u3[v65] then
                if v65 ~= "Img" then
                    return false;
                end;

                u62(p64);
            end;
        end;

        return true;
    end;

    u61 = function(u66, p67, p68) -- Line: 398, Name: applyProperty
        -- upvalues: TextLabel (copy), ImageLabel (copy)
        local u69 = nil;
        local v70 = false;

        for _, v in pairs(p68 and { p68 } or { TextLabel, ImageLabel }) do
            if pcall(function() -- Line: 402
                -- upvalues: u69 (ref), v (copy), u66 (copy)
                u69 = typeof(v[u66]);
            end) then
                if u69 == "Color3" then
                    v[u66] = getColorFromString(p67);
                elseif u69 == "Vector2" then
                    v[u66] = getVector2FromString(p67);
                else
                    v[u66] = p67;
                end;

                v70 = true;
            end;
        end;

        return v70;
    end;

    for i, v in pairs(u3) do
        applyMarkup(i, v);
        u54[u2[i] or i] = u53[u2[i] or i];
    end;

    for i, v in pairs(p49 or {}) do
        applyMarkup(i, v);
        u54[u2[i] or i] = u53[u2[i] or i];
    end;

    if p51 then
        u53 = p51.OverflowPickupProperties;

        for i, v in pairs(u53) do
            applyMarkup(i, v);
        end;
    end;

    local function getTextSize() -- Line: 435
        -- upvalues: u53 (ref), u60 (copy), u47 (copy)
        if u53.TextScaled ~= true then
            return u53.TextSize;
        end;

        local v71 = nil;

        if u53.TextScaleRelativeTo == "Screen" then
            v71 = u60.AbsoluteSize.Y;
        elseif u53.TextScaleRelativeTo == "Frame" then
            v71 = u47.AbsoluteSize.Y;
        end;

        return math.min(u53.TextScale * v71, 100);
    end;

    local u72 = 0;

    local function newLine() -- Line: 451
        -- upvalues: u55 (copy), u72 (ref), u52 (ref), u53 (ref), u60 (copy), u47 (copy), u59 (ref), u56 (copy), u58 (ref)
        local v73 = u55[#u55];

        if v73 then
            u72 = u72 + v73.Size.Y.Offset;

            if not u52 then
                local v74;

                if u53.TextScaled == true then
                    local v75 = nil;

                    if u53.TextScaleRelativeTo == "Screen" then
                        v75 = u60.AbsoluteSize.Y;
                    elseif u53.TextScaleRelativeTo == "Frame" then
                        v75 = u47.AbsoluteSize.Y;
                    end;

                    v74 = math.min(u53.TextScale * v75, 100);
                else
                    v74 = u53.TextSize;
                end;

                if u72 + v74 > u47.AbsoluteSize.Y then
                    u59 = true;

                    return;
                end;
            end;
        end;

        local Frame = Instance.new("Frame");
        Frame.Name = string.format("Line%03d", #u55 + 1);
        Frame.Size = UDim2.new(0, 0, 0, 0);
        Frame.BackgroundTransparency = 1;
        local Frame2 = Instance.new("Frame", Frame);
        Frame2.Name = "Container";
        Frame2.Size = UDim2.new(0, 0, 0, 0);
        Frame2.BackgroundTransparency = 1;
        setHorizontalAlignment(Frame2, u53.ContainerHorizontalAlignment);
        Frame.Parent = u47;
        table.insert(u55, Frame);
        u56[#u55] = {};
        u58 = 0;
    end;

    newLine();

    local function addFrameProperties(p76) -- Line: 477
        -- upvalues: u57 (copy), u53 (ref)
        u57[p76] = shallowCopy(u53);
        u57[p76].InitialSize = p76.Size;
        u57[p76].InitialPosition = p76.Position;
        u57[p76].InitialAnchorPoint = p76.AnchorPoint;
        u57[p76].InitialRotation = p76.Rotation;
    end;

    local function formatLabel(p77, p78, p79, p80) -- Line: 485
        -- upvalues: u55 (copy), u53 (ref), u58 (ref), u47 (copy), u56 (copy), newLine (copy), u57 (copy)
        local v81 = u55[#u55];
        local v82 = tostring(u53.TextYAlignment);

        if v82 == "Top" then
            p77.Position = UDim2.new(0, u58, 0, 0);
            p77.AnchorPoint = Vector2.new(0, 0);
        elseif v82 == "Center" then
            p77.Position = UDim2.new(0, u58, 0.5, 0);
            p77.AnchorPoint = Vector2.new(0, 0.5);
        elseif v82 == "Bottom" then
            p77.Position = UDim2.new(0, u58, 1, 0);
            p77.AnchorPoint = Vector2.new(0, 1);
        end;

        u58 = u58 + p79;

        if u58 > u47.AbsoluteSize.X and u58 ~= p79 then
            p77:Destroy();
            local v83 = u56[#u55][#u56[#u55]];

            if v83:IsA("TextLabel") and v83.Text == " " then
                v81.Container.Size = UDim2.new(0, u58 - p79 - v83.Size.X.Offset, 1, 0);
                v83:Destroy();
                table.remove(u56[#u55]);
            end;

            newLine();
            p80();

            return;
        end;

        p77.Size = UDim2.new(0, p79, 0, p78);
        v81.Container.Size = UDim2.new(0, u58, 1, 0);
        v81.Size = UDim2.new(1, 0, 0, (math.max(v81.Size.Y.Offset, p78)));
        p77.Name = string.format("Group%03d", #u56[#u55] + 1);
        p77.Parent = v81.Container;
        table.insert(u56[#u55], p77);
        u57[p77] = shallowCopy(u53);
        u57[p77].InitialSize = p77.Size;
        u57[p77].InitialPosition = p77.Position;
        u57[p77].InitialAnchorPoint = p77.AnchorPoint;
        u57[p77].InitialRotation = p77.Rotation;
        u53.AnimateYield = 0;
    end;

    local function printText(u84) -- Line: 525
        -- upvalues: newLine (copy), u58 (ref), u53 (ref), u60 (copy), u47 (copy), TextService (ref), TextLabel (copy), u57 (copy), formatLabel (ref), u59 (ref), printText (ref)
        if u84 == "\n" then
            newLine();

            return;
        end;

        if u84 == " " and u58 == 0 then
            return;
        end;

        local v85;

        if u53.TextScaled == true then
            local v86 = nil;

            if u53.TextScaleRelativeTo == "Screen" then
                v86 = u60.AbsoluteSize.Y;
            elseif u53.TextScaleRelativeTo == "Frame" then
                v86 = u47.AbsoluteSize.Y;
            end;

            v85 = math.min(u53.TextScale * v86, 100);
        else
            v85 = u53.TextSize;
        end;

        local X = TextService:GetTextSize(u84, v85, TextLabel.Font, Vector2.new(u60.AbsoluteSize.X, v85)).X;
        local v87 = TextLabel:Clone();
        v87.TextScaled = false;
        v87.TextSize = v85;
        v87.Text = u84;
        v87.TextTransparency = 1;
        v87.TextStrokeTransparency = 1;
        v87.TextWrapped = false;
        local v88 = 0;
        local v89 = 1;

        for i, v in utf8.graphemes(u84) do
            local v90 = string.sub(u84, i, v);
            local X2 = TextService:GetTextSize(v90, v85, TextLabel.Font, Vector2.new(u60.AbsoluteSize.X, v85)).X;
            local v91 = TextLabel:Clone();
            v91.Text = v90;
            v91.TextScaled = false;
            v91.TextSize = v85;
            v91.Position = UDim2.new(0, v88, 0, 0);
            v91.Size = UDim2.new(0, X2 + 1, 0, v85);
            v91.Name = string.format("Char%03d", v89);
            v91.Parent = v87;
            v91.Visible = false;
            u57[v91] = shallowCopy(u53);
            u57[v91].InitialSize = v91.Size;
            u57[v91].InitialPosition = v91.Position;
            u57[v91].InitialAnchorPoint = v91.AnchorPoint;
            u57[v91].InitialRotation = v91.Rotation;
            v88 = v88 + X2;
            v89 = v89 + 1;
        end;

        formatLabel(v87, v85, X, function() -- Line: 564
            -- upvalues: u59 (ref), printText (ref), u84 (copy)
            if not u59 then
                printText(u84);
            end;
        end);
    end;

    u62 = function(u92) -- Line: 567, Name: printImage
        -- upvalues: u53 (ref), u60 (copy), u47 (copy), ImageLabel (copy), u1 (ref), formatLabel (ref), u59 (ref), u62 (ref)
        local v93;

        if u53.TextScaled == true then
            local v94 = nil;

            if u53.TextScaleRelativeTo == "Screen" then
                v94 = u60.AbsoluteSize.Y;
            elseif u53.TextScaleRelativeTo == "Frame" then
                v94 = u47.AbsoluteSize.Y;
            end;

            v93 = math.min(u53.TextScale * v94, 100);
        else
            v93 = u53.TextSize;
        end;

        local v95 = ImageLabel:Clone();

        if u1.ImageShortcuts[u92] then
            v95.Image = typeof(u1.ImageShortcuts[u92]) == "number" and "rbxassetid://" .. u1.ImageShortcuts[u92] or u1.ImageShortcuts[u92];
        else
            v95.Image = "rbxassetid://" .. u92;
        end;

        v95.Size = UDim2.new(0, v93, 0, v93);
        v95.Visible = false;
        formatLabel(v95, v93, v93, function() -- Line: 581
            -- upvalues: u59 (ref), u62 (ref), u92 (copy)
            if not u59 then
                u62(u92);
            end;
        end);
    end;

    local function printSeries(p96) -- Line: 584
        -- upvalues: applyMarkup (ref), printText (ref)
        for _, v in pairs(p96) do
            local v97, v98 = string.match(v, "<(.+)=(.+)>");

            if v97 and v98 then
                if not applyMarkup(v97, v98) then
                    warn("Could not apply markup: ", v);
                end;
            else
                printText(v);
            end;
        end;
    end;

    local u99 = #p48;
    local v100 = {};
    local v101;

    if p51 then
        v101 = p51.OverflowPickupIndex;
    else
        v101 = 1;
    end;

    local v102;

    while true do
        if not v101 or v101 > u99 then
            v102 = v101;
            break;
        end;

        local v103;
        v102, v103 = string.find(p48, "<.->", v101);
        local v104, v105 = string.find(p48, "[ \t\n]", v101);
        local v106;

        if v102 and (v103 and (not v104 or v102 < v104)) then
            v106 = nil;
        else
            v102 = v104 or u99 + 1;
            v103 = v105 or u99 + 1;
            v106 = true;
        end;

        local v107;

        if v101 < v102 then
            v107 = string.sub(p48, v101, v102 - 1) or nil;
        else
            v107 = nil;
        end;

        local v108;

        if v102 <= u99 then
            v108 = string.sub(p48, v102, v103) or nil;
        else
            v108 = nil;
        end;

        table.insert(v100, v107);

        if v106 then
            printSeries(v100);

            if u59 then
                v102 = v101;
                break;
            end;

            printSeries({ v108 });

            if u59 then
                break;
            end;

            v100 = {};
        else
            table.insert(v100, v108);
        end;

        v101 = v103 + 1;
    end;

    if not u59 then
        printSeries(v100);
    end;

    local UIListLayout = Instance.new("UIListLayout");
    UIListLayout.HorizontalAlignment = u53.ContainerHorizontalAlignment;
    UIListLayout.VerticalAlignment = u53.ContainerVerticalAlignment;
    UIListLayout.Parent = u47;
    local X = u47.AbsoluteSize.X;
    local v109 = 0;
    local v110 = 0;

    for _, v in pairs(u55) do
        v109 = v109 + v.Size.Y.Offset;
        local Container = v.Container;
        local v111 = nil;
        local v112 = nil;

        if Container.AnchorPoint.X == 0 then
            v111 = Container.Position.X.Offset;
            v112 = Container.Size.X.Offset;
        elseif Container.AnchorPoint.X == 0.5 then
            v111 = v.AbsoluteSize.X / 2 - Container.Size.X.Offset / 2;
            v112 = v.AbsoluteSize.X / 2 + Container.Size.X.Offset / 2;
        elseif Container.AnchorPoint.X == 1 then
            v111 = v.AbsoluteSize.X - Container.Size.X.Offset;
            v112 = v.AbsoluteSize.X;
        end;

        X = math.min(X, v111);
        v110 = math.max(v110, v112);
    end;

    u26 = u26 + 1;
    local u113 = false;
    local u114 = false;
    local u115 = false;
    local u116 = "TextAnimation" .. u26;
    local u117 = {};

    local function updateAnimations() -- Line: 682
        -- upvalues: u114 (ref), u117 (ref), u113 (ref), RunService (ref), u116 (copy), u25 (ref)
        if (not u114 or #u117 ~= 0) and not u113 then
            local v118 = tick();

            for i = #u117, 1, -1 do
                local v119 = u117[i];
                local Settings = v119.Settings;
                local v120 = u25[Settings.AnimateStyle];

                if not v120 then
                    warn("No animation style found for: ", Settings.AnimateStyle, ", defaulting to Appear");
                    v120 = u25.Appear;
                end;

                local v121 = math.min((v118 - v119.Start) / Settings.AnimateStyleTime, 1);
                v120(v119.Char, v121, Settings);

                if v121 >= 1 then
                    table.remove(u117, i);
                end;
            end;

            return;
        end;

        u113 = true;
        RunService:UnbindFromRenderStep(u116);
        u117 = {};
    end;

    local function setFrameToDefault(p122) -- Line: 707
        -- upvalues: u57 (copy), u61 (ref)
        p122.Position = u57[p122].InitialPosition;
        p122.Size = u57[p122].InitialSize;
        p122.AnchorPoint = u57[p122].InitialAnchorPoint;
        p122.Rotation = u57[p122].Rotation or 0;

        for i, v in pairs(u57[p122]) do
            u61(i, v, p122);
        end;
    end;

    local function setGroupVisible(p123, p124) -- Line: 717
        -- upvalues: setFrameToDefault (copy)
        p123.Visible = p124;

        for _, child in pairs(p123:GetChildren()) do
            child.Visible = p124;

            if p124 then
                setFrameToDefault(child);
            end;
        end;

        if p124 and p123:IsA("ImageLabel") then
            setFrameToDefault(p123);
        end;
    end;

    local function animate(p125) -- Line: 730
        -- upvalues: u113 (ref), RunService (ref), u116 (copy), updateAnimations (copy), u56 (copy), u117 (ref), u115 (ref), u57 (copy), u99 (copy), u114 (ref)
        u113 = false;
        RunService:BindToRenderStep(u116, Enum.RenderPriority.Last.Value, updateAnimations);
        local u126 = nil;
        local u127 = nil;
        local u128 = nil;
        local v129 = nil;

        for _, v in pairs(u56) do
            for _, v2 in pairs(v) do
                v2.Visible = false;

                for _, child in pairs(v2:GetChildren()) do
                    child.Visible = false;
                end;
            end;
        end;

        local function animateCharacter(p130, p131) -- Line: 746
            -- upvalues: u117 (ref)
            local v132 = {
                Char = p130,
                Settings = p131,
                Start = tick()
            };
            table.insert(u117, v132);
        end;

        local function yield() -- Line: 750
            -- upvalues: u115 (ref), u126 (ref), u127 (ref), u128 (ref)
            if not u115 and (u126 % u127 == 0 and u128 >= 0) then
                task.wait(u128 > 0 and u128 or nil);
            end;
        end;

        local Character_3 = game:GetService("SoundService").DialogueSounds.Character_3;
        local v133 = 0;

        for _, v in pairs(u56) do
            for _, v2 in pairs(v) do
                local v134 = u57[v2];
                u126 = (v134.AnimateStepGrouping ~= v129 or v134.AnimateStepFrequency ~= u127) and 0 or u126;
                v129 = v134.AnimateStepGrouping;
                u128 = v134.AnimateStepTime;
                u127 = v134.AnimateStepFrequency;

                if v134.AnimateYield > 0 then
                    task.wait(v134.AnimateYield);
                end;

                if v129 == "Word" or v129 == "All" then
                    if v2:IsA("TextLabel") then
                        v2.Visible = true;

                        for _, child in pairs(v2:GetChildren()) do
                            local v135 = {
                                Char = child,
                                Settings = u57[child],
                                Start = tick()
                            };
                            table.insert(u117, v135);
                        end;
                    else
                        local v136 = {
                            Char = v2,
                            Settings = v134,
                            Start = tick()
                        };
                        table.insert(u117, v136);
                    end;

                    if v129 == "Word" then
                        u126 = u126 + 1;

                        if not u115 and (u126 % u127 == 0 and u128 >= 0) then
                            task.wait(u128 > 0 and u128 or nil);
                        end;
                    end;
                elseif v129 == "Letter" then
                    if v2:IsA("TextLabel") then
                        v2.Visible = true;
                        local _ = v2.Text;
                        local v137 = 1;

                        while true do
                            local v138 = v2:FindFirstChild(string.format("Char%03d", v137));

                            if not v138 then
                                break;
                            end;

                            local v139 = {
                                Char = v138,
                                Settings = u57[v138],
                                Start = tick()
                            };
                            table.insert(u117, v139);
                            u126 = u126 + 1;
                            local Text = v138.Text;
                            local v140 = (Text == "." or (Text == "?" or (Text == "!" or Text == ","))) and true or Text == "/";
                            v133 = v133 + 1;

                            if v133 == 5 or v140 then
                                if v140 then
                                    Character_3.PlaybackSpeed = 0.9;
                                else
                                    Character_3.PlaybackSpeed = 1;
                                end;

                                Character_3:Play();
                                v133 = 0;
                            end;

                            if not u115 and (u126 % u127 == 0 and u128 >= 0) then
                                local v141;

                                if u128 > 0 then
                                    v141 = u128 or nil;
                                else
                                    v141 = nil;
                                end;

                                task.wait(v141);
                            end;

                            if u126 ~= u99 then
                                if Text == "." or (Text == "?" or Text == "!") then
                                    task.wait(0.325);
                                elseif Text == "," then
                                    task.wait(0.275);
                                end;
                            end;

                            if u113 then
                                return;
                            end;

                            v137 = v137 + 1;
                        end;
                    else
                        local v142 = {
                            Char = v2,
                            Settings = v134,
                            Start = tick()
                        };
                        table.insert(u117, v142);
                        u126 = u126 + 1;

                        if not u115 and (u126 % u127 == 0 and u128 >= 0) then
                            task.wait(u128 > 0 and u128 or nil);
                        end;
                    end;
                else
                    warn("Invalid step grouping: ", v129);
                end;

                if u113 then
                    return;
                end;
            end;
        end;

        u114 = true;

        if p125 then
            while #u117 > 0 do
                RunService.RenderStepped:Wait();
            end;
        end;
    end;

    local v143 = {
        Overflown = u59,
        OverflowPickupIndex = v102,
        StartingProperties = p49,
        OverflowPickupProperties = u53,
        Text = p48
    };

    if p51 then
        p51.NextTextObject = v143;
    end;

    v143.ContentSize = Vector2.new(v110 - X, v109);

    function v143.Animate(p144, p145) -- Line: 882
        -- upvalues: animate (copy)
        if p145 then
            animate();
        else
            coroutine.wrap(animate)();
        end;

        if p144.NextTextObject then
            p144.NextTextObject:Animate(p145);
        end;
    end;

    function v143.Show(p146, p147) -- Line: 893
        -- upvalues: u115 (ref), u113 (ref), u56 (copy), setFrameToDefault (copy)
        if p147 then
            u115 = true;
        else
            u113 = true;

            for _, v in pairs(u56) do
                for _, v2 in pairs(v) do
                    v2.Visible = true;

                    for _, child in pairs(v2:GetChildren()) do
                        child.Visible = true;
                        setFrameToDefault(child);
                    end;

                    if v2:IsA("ImageLabel") then
                        setFrameToDefault(v2);
                    end;
                end;
            end;
        end;

        if p146.NextTextObject then
            p146.NextTextObject:Show(p147);
        end;
    end;

    function v143.Hide(p148) -- Line: 909
        -- upvalues: u113 (ref), u56 (copy)
        u113 = true;

        for _, v in pairs(u56) do
            for _, v2 in pairs(v) do
                v2.Visible = false;

                for _, child in pairs(v2:GetChildren()) do
                    child.Visible = false;
                end;
            end;
        end;

        if p148.NextTextObject then
            p148.NextTextObject:Hide();
        end;
    end;

    return v143;
end;

function u1.ContinueOverflow(p149, p150, p151) -- Line: 925
    -- upvalues: u1 (copy)
    return u1:New(p150, nil, nil, false, p151);
end;

return u1;