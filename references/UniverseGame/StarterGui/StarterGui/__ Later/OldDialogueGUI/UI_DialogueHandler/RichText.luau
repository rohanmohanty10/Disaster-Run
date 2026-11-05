  

 

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
u1.ColorShortcuts.Blue = Color3.new(0, 0.666667, 1);
u1.ColorShortcuts.Purple = Color3.new(0.4, 0.4, 1);
u1.ColorShortcuts.Cyan = Color3.new(0.4, 0.85, 1);
u1.ColorShortcuts.Orange = Color3.new(1, 0.5, 0.2);
u1.ColorShortcuts.Yellow = Color3.new(1, 0.9, 0.2);
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
    TextScale = 0.25,
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
    AnimateStyle = "Appear",
    AnimateStyleTime = 0.5,
    AnimateStyleNumPeriods = 3,
    AnimateStyleAmplitude = 0.5
};
local u25 = {
    Appear = function(p4) -- Line: 227, Name: Appear
        p4.Visible = true;
    end,

    Fade = function(p5, p6, p7) -- Line: 231, Name: Fade
        p5.Visible = true;

        if p5:IsA("TextLabel") then
            p5.TextTransparency = 1 - p6 * (1 - p7.TextTransparency);

            return;
        end;

        if p5:IsA("ImageLabel") then
            p5.ImageTransparency = 1 - p6 * (1 - p7.ImageTransparency);
        end;
    end,

    Wiggle = function(p8, p9, p10) -- Line: 240, Name: Wiggle
        p8.Visible = true;
        local v11 = p10.InitialSize.Y.Offset * (1 - p9) * p10.AnimateStyleAmplitude;
        p8.Position = p10.InitialPosition + UDim2.new(0, 0, 0, math.sin(p9 * 3.141592653589793 * 2 * p10.AnimateStyleNumPeriods) * v11 / 2);
    end,

    Swing = function(p12, p13, p14) -- Line: 246, Name: Swing
        p12.Visible = true;
        local v15 = 90 * (1 - p13) * p14.AnimateStyleAmplitude;
        p12.Rotation = math.sin(p13 * 3.141592653589793 * 2 * p14.AnimateStyleNumPeriods) * v15;
    end,

    Spin = function(p16, p17, p18) -- Line: 252, Name: Spin
        p16.Visible = true;
        p16.Position = p18.InitialPosition + UDim2.new(0, p18.InitialSize.X.Offset / 2, 0, p18.InitialSize.Y.Offset / 2);
        p16.AnchorPoint = Vector2.new(0.5, 0.5);
        p16.Rotation = p17 * p18.AnimateStyleNumPeriods * 360;
    end,

    Rainbow = function(p19, p20, p21) -- Line: 259, Name: Rainbow
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

    local v31, v32, v33 = p30:match("(%d+),(%d+),(%d+)");

    return Color3.new(v31 / 255, v32 / 255, v33 / 255);
end;

function getVector2FromString(p34)
    local v35, v36 = p34:match("(%d+),(%d+)");

    return Vector2.new(v35, v36);
end;

function setHorizontalAlignment(p37, p38)
    if p38 == "Left" then
        p37.AnchorPoint = Vector2.new(0, 0);
        p37.Position = UDim2.new(0, 0, 0, 0);

        return;
    end;

    if p38 ~= "Center" then
        if p38 == "Right" then
            p37.AnchorPoint = Vector2.new(1, 0);
            p37.Position = UDim2.new(1, 0, 0, 0);
        end;

        return;
    end;

    p37.AnchorPoint = Vector2.new(0.5, 0);
    p37.Position = UDim2.new(0.5, 0, 0, 0);
end;

function u1.New(p39, u40, p41, p42, p43, p44) -- Line: 325
    -- upvalues: u2 (copy), u3 (copy), TextService (copy), u1 (copy), u26 (ref), RunService (copy), u25 (copy)
    for _, child in pairs(u40:GetChildren()) do
        child:Destroy();
    end;

    local u45 = p43 == nil and true or p43;
    local u46 = {};
    local u47 = {};

    if p44 then
        p41 = p44.Text;
        p42 = p44.StartingProperties;
    end;

    local u48 = {};
    local u49 = {};
    local u50 = {};
    local u51 = 0;
    local u52 = false;
    local TextLabel = Instance.new("TextLabel");
    local ImageLabel = Instance.new("ImageLabel");
    local u53 = getLayerCollector(u40);
    TextLabel.AutoLocalize = false;
    local u54 = nil;
    local u55 = nil;

    local function applyMarkup(p56, p57) -- Line: 353
        -- upvalues: u2 (ref), u47 (copy), u46 (ref), u54 (ref), u48 (copy), u3 (ref), u55 (ref)
        local v58 = u2[p56] or p56;

        if p57 == "/" then
            if u47[v58] then
                p57 = u47[v58];
            else
                warn("Attempt to default <" .. v58 .. "> to value with no default");
            end;
        end;

        if tonumber(p57) then
            p57 = tonumber(p57);
        elseif p57 == "false" or p57 == "true" then
            p57 = p57 == "true";
        end;

        u46[v58] = p57;

        if not u54(v58, p57) then
            if v58 == "ContainerHorizontalAlignment" and u48[#u48] then
                setHorizontalAlignment(u48[#u48].Container, p57);
            elseif not u3[v58] then
                if v58 ~= "Img" then
                    return false;
                end;

                u55(p57);
            end;
        end;

        return true;
    end;

    u54 = function(u59, p60, p61) -- Line: 384, Name: applyProperty
        -- upvalues: TextLabel (copy), ImageLabel (copy)
        local u62 = nil;
        local v63 = false;

        for _, v in pairs(p61 and { p61 } or { TextLabel, ImageLabel }) do
            if pcall(function() -- Line: 388
                -- upvalues: u62 (ref), v (copy), u59 (copy)
                u62 = typeof(v[u59]);
            end) then
                if u62 == "Color3" then
                    v[u59] = getColorFromString(p60);
                elseif u62 == "Vector2" then
                    v[u59] = getVector2FromString(p60);
                else
                    v[u59] = p60;
                end;

                v63 = true;
            end;
        end;

        return v63;
    end;

    for i, v in pairs(u3) do
        applyMarkup(i, v);
        u47[u2[i] or i] = u46[u2[i] or i];
    end;

    for i, v in pairs(p42 or {}) do
        applyMarkup(i, v);
        u47[u2[i] or i] = u46[u2[i] or i];
    end;

    if p44 then
        u46 = p44.OverflowPickupProperties;

        for i, v in pairs(u46) do
            applyMarkup(i, v);
        end;
    end;

    local function getTextSize() -- Line: 421
        -- upvalues: u46 (ref), u53 (copy), u40 (copy)
        if u46.TextScaled ~= true then
            return u46.TextSize;
        end;

        local v64 = nil;

        if u46.TextScaleRelativeTo == "Screen" then
            v64 = u53.AbsoluteSize.Y;
        elseif u46.TextScaleRelativeTo == "Frame" then
            v64 = u40.AbsoluteSize.Y;
        end;

        return math.min(u46.TextScale * v64, 100);
    end;

    local u65 = 0;

    local function newLine() -- Line: 437
        -- upvalues: u48 (copy), u65 (ref), u45 (ref), u46 (ref), u53 (copy), u40 (copy), u52 (ref), u49 (copy), u51 (ref)
        local v66 = u48[#u48];

        if v66 then
            u65 = u65 + v66.Size.Y.Offset;

            if not u45 then
                local v67;

                if u46.TextScaled == true then
                    local v68 = nil;

                    if u46.TextScaleRelativeTo == "Screen" then
                        v68 = u53.AbsoluteSize.Y;
                    elseif u46.TextScaleRelativeTo == "Frame" then
                        v68 = u40.AbsoluteSize.Y;
                    end;

                    v67 = math.min(u46.TextScale * v68, 100);
                else
                    v67 = u46.TextSize;
                end;

                if u65 + v67 > u40.AbsoluteSize.Y then
                    u52 = true;

                    return;
                end;
            end;
        end;

        local Frame = Instance.new("Frame");
        Frame.Name = string.format("Line%03d", #u48 + 1);
        Frame.Size = UDim2.new(0, 0, 0, 0);
        Frame.BackgroundTransparency = 1;
        local Frame2 = Instance.new("Frame", Frame);
        Frame2.Name = "Container";
        Frame2.Size = UDim2.new(0, 0, 0, 0);
        Frame2.BackgroundTransparency = 1;
        setHorizontalAlignment(Frame2, u46.ContainerHorizontalAlignment);
        Frame.Parent = u40;
        table.insert(u48, Frame);
        u49[#u48] = {};
        u51 = 0;
    end;

    newLine();

    local function addFrameProperties(p69) -- Line: 463
        -- upvalues: u50 (copy), u46 (ref)
        u50[p69] = shallowCopy(u46);
        u50[p69].InitialSize = p69.Size;
        u50[p69].InitialPosition = p69.Position;
        u50[p69].InitialAnchorPoint = p69.AnchorPoint;
    end;

    local function formatLabel(p70, p71, p72, p73) -- Line: 470
        -- upvalues: u48 (copy), u46 (ref), u51 (ref), u40 (copy), u49 (copy), newLine (copy), u50 (copy)
        local v74 = u48[#u48];
        local v75 = tostring(u46.TextYAlignment);

        if v75 == "Top" then
            p70.Position = UDim2.new(0, u51, 0, 0);
            p70.AnchorPoint = Vector2.new(0, 0);
        elseif v75 == "Center" then
            p70.Position = UDim2.new(0, u51, 0.5, 0);
            p70.AnchorPoint = Vector2.new(0, 0.5);
        elseif v75 == "Bottom" then
            p70.Position = UDim2.new(0, u51, 1, 0);
            p70.AnchorPoint = Vector2.new(0, 1);
        end;

        u51 = u51 + p72;

        if u51 > u40.AbsoluteSize.X and u51 ~= p72 then
            p70:Destroy();
            local v76 = u49[#u48][#u49[#u48]];

            if v76:IsA("TextLabel") and v76.Text == " " then
                v74.Container.Size = UDim2.new(0, u51 - p72 - v76.Size.X.Offset, 1, 0);
                v76:Destroy();
                table.remove(u49[#u48]);
            end;

            newLine();
            p73();

            return;
        end;

        p70.Size = UDim2.new(0, p72, 0, p71);
        v74.Container.Size = UDim2.new(0, u51, 1, 0);
        v74.Size = UDim2.new(1, 0, 0, (math.max(v74.Size.Y.Offset, p71)));
        p70.Name = string.format("Group%03d", #u49[#u48] + 1);
        p70.Parent = v74.Container;
        table.insert(u49[#u48], p70);
        u50[p70] = shallowCopy(u46);
        u50[p70].InitialSize = p70.Size;
        u50[p70].InitialPosition = p70.Position;
        u50[p70].InitialAnchorPoint = p70.AnchorPoint;
        u46.AnimateYield = 0;
    end;

    local function printText(u77) -- Line: 510
        -- upvalues: newLine (copy), u51 (ref), u46 (ref), u53 (copy), u40 (copy), TextService (ref), TextLabel (copy), u50 (copy), formatLabel (ref), u52 (ref), printText (ref)
        if u77 == "\n" then
            newLine();

            return;
        end;

        if u77 == " " and u51 == 0 then
            return;
        end;

        local v78;

        if u46.TextScaled == true then
            local v79 = nil;

            if u46.TextScaleRelativeTo == "Screen" then
                v79 = u53.AbsoluteSize.Y;
            elseif u46.TextScaleRelativeTo == "Frame" then
                v79 = u40.AbsoluteSize.Y;
            end;

            v78 = math.min(u46.TextScale * v79, 100);
        else
            v78 = u46.TextSize;
        end;

        local X = TextService:GetTextSize(u77, v78, TextLabel.Font, Vector2.new(u53.AbsoluteSize.X, v78)).X;
        local v80 = TextLabel:Clone();
        v80.TextScaled = false;
        v80.TextSize = v78;
        v80.Text = u77;
        v80.TextTransparency = 1;
        v80.TextStrokeTransparency = 1;
        v80.TextWrapped = false;
        local v81 = 1;
        local v82 = 0;

        for i, v in utf8.graphemes(u77) do
            local v83 = string.sub(u77, i, v);
            local X2 = TextService:GetTextSize(v83, v78, TextLabel.Font, Vector2.new(u53.AbsoluteSize.X, v78)).X;
            local v84 = TextLabel:Clone();
            v84.Text = v83;
            v84.TextScaled = false;
            v84.TextSize = v78;
            v84.Position = UDim2.new(0, v82, 0, 0);
            v84.Size = UDim2.new(0, X2 + 1, 0, v78);
            v84.Name = string.format("Char%03d", v81);
            v84.Parent = v80;
            v84.Visible = false;
            u50[v84] = shallowCopy(u46);
            u50[v84].InitialSize = v84.Size;
            u50[v84].InitialPosition = v84.Position;
            u50[v84].InitialAnchorPoint = v84.AnchorPoint;
            v82 = v82 + X2;
            v81 = v81 + 1;
        end;

        formatLabel(v80, v78, X, function() -- Line: 549
            -- upvalues: u52 (ref), printText (ref), u77 (copy)
            if not u52 then
                printText(u77);
            end;
        end);
    end;

    u55 = function(u85) -- Line: 552, Name: printImage
        -- upvalues: u46 (ref), u53 (copy), u40 (copy), ImageLabel (copy), u1 (ref), formatLabel (ref), u52 (ref), u55 (ref)
        local v86;

        if u46.TextScaled == true then
            local v87 = nil;

            if u46.TextScaleRelativeTo == "Screen" then
                v87 = u53.AbsoluteSize.Y;
            elseif u46.TextScaleRelativeTo == "Frame" then
                v87 = u40.AbsoluteSize.Y;
            end;

            v86 = math.min(u46.TextScale * v87, 100);
        else
            v86 = u46.TextSize;
        end;

        local v88 = ImageLabel:Clone();

        if u1.ImageShortcuts[u85] then
            v88.Image = typeof(u1.ImageShortcuts[u85]) == "number" and "rbxassetid://" .. u1.ImageShortcuts[u85] or u1.ImageShortcuts[u85];
        else
            v88.Image = "rbxassetid://" .. u85;
        end;

        v88.Size = UDim2.new(0, v86, 0, v86);
        v88.Visible = false;
        formatLabel(v88, v86, v86, function() -- Line: 566
            -- upvalues: u52 (ref), u55 (ref), u85 (copy)
            if not u52 then
                u55(u85);
            end;
        end);
    end;

    local function printSeries(p89) -- Line: 569
        -- upvalues: applyMarkup (ref), printText (ref)
        for _, v in pairs(p89) do
            local v90, v91 = string.match(v, "<(.+)=(.+)>");

            if v90 and v91 then
                if not applyMarkup(v90, v91) then
                    warn("Could not apply markup: ", v);
                end;
            else
                printText(v);
            end;
        end;
    end;

    local v92 = #p41;
    local v93 = {};
    local v94;

    if p44 then
        v94 = p44.OverflowPickupIndex;
    else
        v94 = 1;
    end;

    local v95;

    while true do
        if not v94 or v94 > v92 then
            v95 = v94;
            break;
        end;

        local v96;
        v95, v96 = string.find(p41, "<.->", v94);
        local v97, v98 = string.find(p41, "[ \t\n]", v94);
        local v99;

        if v95 and (v96 and (not v97 or v95 < v97)) then
            v99 = nil;
        else
            v95 = v97 or v92 + 1;
            v96 = v98 or v92 + 1;
            v99 = true;
        end;

        local v100;

        if v94 < v95 then
            v100 = string.sub(p41, v94, v95 - 1) or nil;
        else
            v100 = nil;
        end;

        local v101;

        if v95 <= v92 then
            v101 = string.sub(p41, v95, v96) or nil;
        else
            v101 = nil;
        end;

        table.insert(v93, v100);

        if v99 then
            printSeries(v93);

            if u52 then
                v95 = v94;
                break;
            end;

            printSeries({ v101 });

            if u52 then
                break;
            end;

            v93 = {};
        else
            table.insert(v93, v101);
        end;

        v94 = v96 + 1;
    end;

    if not u52 then
        printSeries(v93);
    end;

    local UIListLayout = Instance.new("UIListLayout");
    UIListLayout.HorizontalAlignment = u46.ContainerHorizontalAlignment;
    UIListLayout.VerticalAlignment = u46.ContainerVerticalAlignment;
    UIListLayout.Parent = u40;
    local X = u40.AbsoluteSize.X;
    local v102 = 0;
    local v103 = 0;

    for _, v in pairs(u48) do
        v102 = v102 + v.Size.Y.Offset;
        local Container = v.Container;
        local v104 = nil;
        local v105 = nil;

        if Container.AnchorPoint.X == 0 then
            v104 = Container.Position.X.Offset;
            v105 = Container.Size.X.Offset;
        elseif Container.AnchorPoint.X == 0.5 then
            v104 = v.AbsoluteSize.X / 2 - Container.Size.X.Offset / 2;
            v105 = v.AbsoluteSize.X / 2 + Container.Size.X.Offset / 2;
        elseif Container.AnchorPoint.X == 1 then
            v104 = v.AbsoluteSize.X - Container.Size.X.Offset;
            v105 = v.AbsoluteSize.X;
        end;

        X = math.min(X, v104);
        v103 = math.max(v103, v105);
    end;

    u26 = u26 + 1;
    local u106 = false;
    local u107 = false;
    local u108 = false;
    local u109 = "TextAnimation" .. u26;
    local u110 = {};

    local function updateAnimations() -- Line: 667
        -- upvalues: u107 (ref), u110 (ref), u106 (ref), RunService (ref), u109 (copy), u25 (ref)
        if (not u107 or #u110 ~= 0) and not u106 then
            local v111 = tick();

            for i = #u110, 1, -1 do
                local v112 = u110[i];
                local Settings = v112.Settings;
                local v113 = u25[Settings.AnimateStyle];

                if not v113 then
                    warn("No animation style found for: ", Settings.AnimateStyle, ", defaulting to Appear");
                    v113 = u25.Appear;
                end;

                local v114 = math.min((v111 - v112.Start) / Settings.AnimateStyleTime, 1);
                v113(v112.Char, v114, Settings);

                if v114 >= 1 then
                    table.remove(u110, i);
                end;
            end;

            return;
        end;

        u106 = true;
        RunService:UnbindFromRenderStep(u109);
        u110 = {};
    end;

    local function setFrameToDefault(p115) -- Line: 692
        -- upvalues: u50 (copy), u54 (ref)
        p115.Position = u50[p115].InitialPosition;
        p115.Size = u50[p115].InitialSize;
        p115.AnchorPoint = u50[p115].InitialAnchorPoint;

        for i, v in pairs(u50[p115]) do
            u54(i, v, p115);
        end;
    end;

    local function setGroupVisible(p116, p117) -- Line: 701
        -- upvalues: setFrameToDefault (copy)
        p116.Visible = p117;

        for _, child in pairs(p116:GetChildren()) do
            child.Visible = p117;

            if p117 then
                setFrameToDefault(child);
            end;
        end;

        if p117 and p116:IsA("ImageLabel") then
            setFrameToDefault(p116);
        end;
    end;

    local function animate(p118) -- Line: 714
        -- upvalues: u106 (ref), RunService (ref), u109 (copy), updateAnimations (copy), u49 (copy), u110 (ref), u108 (ref), u50 (copy), u107 (ref)
        u106 = false;
        RunService:BindToRenderStep(u109, Enum.RenderPriority.Last.Value, updateAnimations);
        local u119 = nil;
        local u120 = nil;
        local u121 = nil;
        local v122 = nil;

        for _, v in pairs(u49) do
            for _, v2 in pairs(v) do
                v2.Visible = false;

                for _, child in pairs(v2:GetChildren()) do
                    child.Visible = false;
                end;
            end;
        end;

        local function animateCharacter(p123, p124) -- Line: 730
            -- upvalues: u110 (ref)
            local v125 = {
                Char = p123,
                Settings = p124,
                Start = tick()
            };
            table.insert(u110, v125);
        end;

        local function yield() -- Line: 734
            -- upvalues: u108 (ref), u119 (ref), u120 (ref), u121 (ref)
            if not u108 and (u119 % u120 == 0 and u121 >= 0) then
                task.wait(u121 > 0 and u121 or nil);
            end;
        end;

        local Character = game:GetService("SoundService").DialogueSounds.Character;

        for _, v in pairs(u49) do
            for _, v2 in pairs(v) do
                local v126 = u50[v2];
                u119 = (v126.AnimateStepGrouping ~= v122 or v126.AnimateStepFrequency ~= u120) and 0 or u119;
                v122 = v126.AnimateStepGrouping;
                u121 = v126.AnimateStepTime;
                u120 = v126.AnimateStepFrequency;

                if v126.AnimateYield > 0 then
                    task.wait(v126.AnimateYield);
                end;

                if v122 == "Word" or v122 == "All" then
                    if v2:IsA("TextLabel") then
                        v2.Visible = true;

                        for _, child in pairs(v2:GetChildren()) do
                            local v127 = {
                                Char = child,
                                Settings = u50[child],
                                Start = tick()
                            };
                            table.insert(u110, v127);
                        end;
                    else
                        local v128 = {
                            Char = v2,
                            Settings = v126,
                            Start = tick()
                        };
                        table.insert(u110, v128);
                    end;

                    if v122 == "Word" then
                        u119 = u119 + 1;

                        if not u108 and (u119 % u120 == 0 and u121 >= 0) then
                            task.wait(u121 > 0 and u121 or nil);
                        end;
                    end;
                elseif v122 == "Letter" then
                    if v2:IsA("TextLabel") then
                        v2.Visible = true;
                        local _ = v2.Text;
                        local v129 = 1;

                        while true do
                            local v130 = v2:FindFirstChild(string.format("Char%03d", v129));

                            if not v130 then
                                break;
                            end;

                            local v131 = {
                                Char = v130,
                                Settings = u50[v130],
                                Start = tick()
                            };
                            table.insert(u110, v131);
                            u119 = u119 + 1;
                            Character:Play();

                            if not u108 and (u119 % u120 == 0 and u121 >= 0) then
                                local v132;

                                if u121 > 0 then
                                    v132 = u121 or nil;
                                else
                                    v132 = nil;
                                end;

                                task.wait(v132);
                            end;

                            if u106 then
                                return;
                            end;

                            v129 = v129 + 1;
                        end;
                    else
                        local v133 = {
                            Char = v2,
                            Settings = v126,
                            Start = tick()
                        };
                        table.insert(u110, v133);
                        u119 = u119 + 1;

                        if not u108 and (u119 % u120 == 0 and u121 >= 0) then
                            task.wait(u121 > 0 and u121 or nil);
                        end;
                    end;
                else
                    warn("Invalid step grouping: ", v122);
                end;

                if u106 then
                    return;
                end;
            end;
        end;

        u107 = true;

        if p118 then
            while #u110 > 0 do
                RunService.RenderStepped:Wait();
            end;
        end;
    end;

    local v134 = {
        Overflown = u52,
        OverflowPickupIndex = v95,
        StartingProperties = p42,
        OverflowPickupProperties = u46,
        Text = p41
    };

    if p44 then
        p44.NextTextObject = v134;
    end;

    v134.ContentSize = Vector2.new(v103 - X, v102);

    function v134.Animate(p135, p136) -- Line: 838
        -- upvalues: animate (copy)
        if p136 then
            animate();
        else
            coroutine.wrap(animate)();
        end;

        if p135.NextTextObject then
            p135.NextTextObject:Animate(p136);
        end;
    end;

    function v134.Show(p137, p138) -- Line: 849
        -- upvalues: u108 (ref), u106 (ref), u49 (copy), setFrameToDefault (copy)
        if p138 then
            u108 = true;
        else
            u106 = true;

            for _, v in pairs(u49) do
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

        if p137.NextTextObject then
            p137.NextTextObject:Show(p138);
        end;
    end;

    function v134.Hide(p139) -- Line: 865
        -- upvalues: u106 (ref), u49 (copy)
        u106 = true;

        for _, v in pairs(u49) do
            for _, v2 in pairs(v) do
                v2.Visible = false;

                for _, child in pairs(v2:GetChildren()) do
                    child.Visible = false;
                end;
            end;
        end;

        if p139.NextTextObject then
            p139.NextTextObject:Hide();
        end;
    end;

    return v134;
end;

function u1.ContinueOverflow(p140, p141, p142) -- Line: 881
    -- upvalues: u1 (copy)
    return u1:New(p141, nil, nil, false, p142);
end;

return u1;