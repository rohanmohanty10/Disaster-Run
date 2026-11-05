 

 

if #game:GetService("ServerStorage"):GetChildren() <= 0 then
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
    u1.ColorShortcuts.ReallyRed = BrickColor.new("Really red").Color;
    u1.ColorShortcuts.DarkRed = BrickColor.new("Dark red").Color;
    u1.ColorShortcuts.Green = Color3.new(0.4, 1, 0.4);
    u1.ColorShortcuts.Pink = BrickColor.new("Pink").Color;
    u1.ColorShortcuts.Blue = Color3.new(0.4, 0.4, 1);
    u1.ColorShortcuts.ReallyBlue = BrickColor.new("Really blue").Color;
    u1.ColorShortcuts.MediumBlue = BrickColor.new("Medium blue").Color;
    u1.ColorShortcuts.Purple = BrickColor.new("Magenta").Color;
    u1.ColorShortcuts.Cyan = Color3.new(0.4, 0.85, 1);
    u1.ColorShortcuts.Orange = Color3.new(1, 0.5, 0.2);
    u1.ColorShortcuts.Yellow = Color3.new(1, 0.9, 0.2);
    u1.ColorShortcuts.CoolYellow = BrickColor.new("Cool yellow").Color;
    u1.ColorShortcuts.Gold = BrickColor.new("Gold").Color;
    u1.ColorShortcuts.LightGrey = BrickColor.new("Light Grey").Color;
    u1.ColorShortcuts.Grey = BrickColor.new("Medium stone grey").Color;
    u1.ImageShortcuts = {};
    u1.ImageShortcuts.Eggplant = 639588687;
    u1.ImageShortcuts.Thinking = 955646496;
    u1.ImageShortcuts.Sad = 947900188;
    u1.ImageShortcuts.Happy = 414889555;
    u1.ImageShortcuts.Despicable = 711674643;
    local u3 = {
        ContainerHorizontalAlignment = "Left",
        ContainerVerticalAlignment = "Center",
        TextYAlignment = "Center",
        TextXAlignment = "Center",
        TextScaled = true,
        TextScaleRelativeTo = "Frame",
        TextScale = 0.2,
        TextSize = 20,
        Font = "Code",
        TextColor3 = "White",
        TextStrokeColor3 = "Black",
        TextTransparency = 0,
        TextStrokeTransparency = 0,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ImageColor3 = "White",
        ImageTransparency = 0,
        ImageRectOffset = "0,0",
        ImageRectSize = "0,0",
        AnimateStepTime = 0,
        AnimateStepGrouping = "Letter",
        AnimateStepFrequency = 1,
        AnimateYield = 0,
        AnimateStyle = "Appear",
        AnimateStyleTime = 0.5,
        AnimateStyleNumPeriods = 3,
        AnimateStyleAmplitude = 0.5
    };
    local u37 = {
        Appear = function(p4) --[[ Name: Appear, Line 239 ]]
            p4.Visible = true;
        end,
        WiggleFade = function(p5, p6, p7) --[[ Name: WiggleFade, Line 243 ]]
            p5.Visible = true;
            if p5:IsA("TextLabel") then
                p5.TextTransparency = 1 - p6 * (1 - p7.TextTransparency);
            elseif p5:IsA("ImageLabel") then
                p5.ImageTransparency = 1 - p6 * (1 - p7.ImageTransparency);
            end;
            local v8 = p7.InitialSize.Y.Offset * (1 - p6) * p7.AnimateStyleAmplitude;
            p5.Position = p7.InitialPosition + UDim2.new(0, 0, 0, math.sin(p6 * 3.141592653589793 * 2 * p7.AnimateStyleNumPeriods) * v8 / 2);
        end,
        Fade = function(p9, p10, p11) --[[ Name: Fade, Line 258 ]]
            p9.Visible = true;
            if p9:IsA("TextLabel") then
                p9.TextTransparency = 1 - p10 * (1 - p11.TextTransparency);
            else
                if p9:IsA("ImageLabel") then
                    p9.ImageTransparency = 1 - p10 * (1 - p11.ImageTransparency);
                end;
            end;
        end,
        SwingWiggle = function(p12, p13, p14) --[[ Name: SwingWiggle, Line 267 ]]
            p12.Visible = true;
            local v15 = 90 * (1 - p13) * p14.AnimateStyleAmplitude;
            p12.Rotation = math.sin(p13 * 3.141592653589793 * 2 * p14.AnimateStyleNumPeriods) * v15;
            local v16 = p14.InitialSize.Y.Offset * (1 - p13) * p14.AnimateStyleAmplitude;
            p12.Position = p14.InitialPosition + UDim2.new(0, 0, 0, math.sin(p13 * 3.141592653589793 * 2 * p14.AnimateStyleNumPeriods) * v16 / 2);
        end,
        Wiggle = function(p17, p18, p19) --[[ Name: Wiggle, Line 279 ]]
            p17.Visible = true;
            local v20 = p19.InitialSize.Y.Offset * (1 - p18) * p19.AnimateStyleAmplitude;
            p17.Position = p19.InitialPosition + UDim2.new(0, 0, 0, math.sin(p18 * 3.141592653589793 * 2 * p19.AnimateStyleNumPeriods) * v20 / 2);
        end,
        Swing = function(p21, p22, p23) --[[ Name: Swing, Line 285 ]]
            p21.Visible = true;
            local v24 = 90 * (1 - p22) * p23.AnimateStyleAmplitude;
            p21.Rotation = math.sin(p22 * 3.141592653589793 * 2 * p23.AnimateStyleNumPeriods) * v24;
        end,
        Spin = function(p25, p26, p27) --[[ Name: Spin, Line 291 ]]
            p25.Visible = true;
            p25.Position = p27.InitialPosition + UDim2.new(0, p27.InitialSize.X.Offset / 2, 0, p27.InitialSize.Y.Offset / 2);
            p25.AnchorPoint = Vector2.new(0.5, 0.5);
            p25.Rotation = p26 * p27.AnimateStyleNumPeriods * 360;
        end,
        Appear2 = function(p28, p29, p30) --[[ Name: Appear2, Line 298 ]]
            p28.Visible = true;
            p28.Position = p30.InitialPosition + UDim2.new(0, 0, 0, -p30.InitialSize.Y.Offset * (1 - p29));
        end,
        Rainbow = function(p31, p32, p33) --[[ Name: Rainbow, Line 305 ]]
            p31.Visible = true;
            local v34 = Color3.fromHSV(p32 * p33.AnimateStyleNumPeriods % 1, 1, 1);
            if p31:IsA("TextLabel") then
                local v35 = getColorFromString(p33.TextColor3);
                p31.TextColor3 = Color3.new(v34.r + p32 * (v35.r - v34.r), v34.g + p32 * (v35.g - v34.g), v34.b + p32 * (v35.b - v34.b));
            else
                local v36 = getColorFromString(p33.ImageColor3);
                p31.ImageColor3 = Color3.new(v34.r + p32 * (v36.r - v34.r), v34.g + p32 * (v36.g - v34.g), v34.b + p32 * (v36.b - v34.b));
            end;
        end
    };
    local l__TextService__1 = game:GetService("TextService");
    local l__RunService__2 = game:GetService("RunService");
    local u38 = 0;
    function getLayerCollector(p39)
        if p39 then
            if p39:IsA("LayerCollector") then
                return p39;
            elseif p39 and p39.Parent then
                return getLayerCollector(p39.Parent);
            else
                return nil;
            end;
        else
            return nil;
        end;
    end;
    function shallowCopy(p40)
        local v41 = {};
        for v42, v43 in pairs(p40) do
            v41[v42] = v43;
        end;
        return v41;
    end;
    function getColorFromString(p44)
        -- upvalues: u1 (copy)
        if u1.ColorShortcuts[p44] then
            return u1.ColorShortcuts[p44];
        end;
        local v45, v46, v47 = p44:match("(%d+),(%d+),(%d+)");
        return Color3.new(v45 / 255, v46 / 255, v47 / 255);
    end;
    function getVector2FromString(p48)
        local v49, v50 = p48:match("(%d+),(%d+)");
        return Vector2.new(v49, v50);
    end;
    function setHorizontalAlignment(p51, p52)
        if p52 == "Left" then
            p51.AnchorPoint = Vector2.new(0, 0);
            p51.Position = UDim2.new(0, 0, 0, 0);
        elseif p52 == "Center" then
            p51.AnchorPoint = Vector2.new(0.5, 0);
            p51.Position = UDim2.new(0.5, 0, 0, 0);
        else
            if p52 == "Right" then
                p51.AnchorPoint = Vector2.new(1, 0);
                p51.Position = UDim2.new(1, 0, 0, 0);
            end;
        end;
    end;
    function u1.New(_, u53, p54, p55, p56, p57, ...) --[[ Line: 371 ]]
        -- upvalues: u2 (copy), u3 (copy), l__TextService__1 (copy), u1 (copy), u38 (ref), l__RunService__2 (copy), u37 (copy)
        local u58 = ... or {};
        for _, v59 in pairs(u53:GetChildren()) do
            v59:Destroy();
        end;
        local u60 = p56 == nil and true or p56;
        local u61 = {};
        local u62 = {};
        if p57 then
            p54 = p57.Text;
            p55 = p57.StartingProperties;
        end;
        local u63 = {};
        local u64 = {};
        local u65 = {};
        local u66 = 0;
        local u67 = false;
        local u68 = Instance.new("TextLabel");
        local u69 = Instance.new("ImageLabel");
        local u70 = getLayerCollector(u53);
        u68.AutoLocalize = false;
        local u71 = nil;
        local u72 = nil;
        local function u76(p73, p74) --[[ Line: 402 ]]
            -- upvalues: u2 (ref), u62 (copy), u61 (ref), u71 (ref), u63 (copy), u3 (ref), u72 (ref)
            local v75 = u2[p73] or p73;
            if p74 == "/" then
                if u62[v75] then
                    p74 = u62[v75];
                else
                    warn("Attempt to default <" .. v75 .. "> to value with no default");
                end;
            end;
            if tonumber(p74) then
                p74 = tonumber(p74);
            elseif p74 == "false" or p74 == "true" then
                p74 = p74 == "true";
            end;
            u61[v75] = p74;
            if not u71(v75, p74) then
                if v75 == "ContainerHorizontalAlignment" and u63[#u63] then
                    setHorizontalAlignment(u63[#u63].Container, p74);
                elseif not u3[v75] then
                    if v75 ~= "Img" then
                        return false;
                    end;
                    u72(p74);
                end;
            end;
            return true;
        end;
        u71 = function(u77, p78, p79) --[[ Name: applyProperty, Line 433 ]]
            -- upvalues: u68 (copy), u69 (copy)
            local u80 = nil;
            local v81 = false;
            for _, u82 in pairs(p79 and { p79 } or { u68, u69 }) do
                if pcall(function() --[[ Line: 437 ]]
                    -- upvalues: u80 (ref), u82 (copy), u77 (copy)
                    u80 = typeof(u82[u77]);
                end) then
                    if u80 == "Color3" then
                        u82[u77] = getColorFromString(p78);
                    elseif u80 == "Vector2" then
                        u82[u77] = getVector2FromString(p78);
                    else
                        u82[u77] = p78;
                    end;
                    v81 = true;
                end;
            end;
            return v81;
        end;
        local u83 = u71;
        for v84, v85 in pairs(u3) do
            u76(v84, v85);
            u62[u2[v84] or v84] = u61[u2[v84] or v84];
        end;
        for v86, v87 in pairs(p55 or {}) do
            u76(v86, v87);
            u62[u2[v86] or v86] = u61[u2[v86] or v86];
        end;
        if p57 then
            u61 = p57.OverflowPickupProperties;
            for v88, v89 in pairs(u61) do
                u76(v88, v89);
            end;
        end;
        local u90 = 0;
        local function u97() --[[ Line: 486 ]]
            -- upvalues: u63 (copy), u90 (ref), u60 (ref), u61 (ref), u70 (copy), u53 (copy), u67 (ref), u64 (copy), u66 (ref)
            local v91 = u63[#u63];
            if v91 then
                u90 = u90 + v91.Size.Y.Offset;
                if not u60 then
                    local v92 = u90;
                    local v93;
                    if u61.TextScaled == true then
                        local v94 = nil;
                        if u61.TextScaleRelativeTo == "Screen" then
                            v94 = u70.AbsoluteSize.Y;
                        elseif u61.TextScaleRelativeTo == "Frame" then
                            v94 = u53.AbsoluteSize.Y;
                        end;
                        v93 = math.min(u61.TextScale * v94, 100);
                    else
                        v93 = u61.TextSize;
                    end;
                    if v92 + v93 > u53.AbsoluteSize.Y then
                        u67 = true;
                        return;
                    end;
                end;
            end;
            local v95 = Instance.new("Frame");
            v95.Name = string.format("Line%03d", #u63 + 1);
            v95.Size = UDim2.new(0, 0, 0, 0);
            v95.BackgroundTransparency = 1;
            local v96 = Instance.new("Frame", v95);
            v96.Name = "Container";
            v96.Size = UDim2.new(0, 0, 0, 0);
            v96.BackgroundTransparency = 1;
            setHorizontalAlignment(v96, u61.ContainerHorizontalAlignment);
            v95.Parent = u53;
            table.insert(u63, v95);
            u64[#u63] = {};
            u66 = 0;
        end;
        u97();
        local function u108(p98, p99, p100, p101) --[[ Line: 519 ]]
            -- upvalues: u63 (copy), u61 (ref), u66 (ref), u53 (copy), u64 (copy), u97 (copy), u65 (copy)
            local v102 = u63[#u63];
            local v103 = tostring(u61.TextYAlignment);
            local v104 = tostring(u61.TextXAlignment);
            local v105 = UDim2.new(0, 0, 0, 0);
            local v106 = Vector2.new(0, 0);
            if v103 == "Top" then
                v105 = v105 + UDim2.new(0, u66, 0, 0);
                v106 = v106 + Vector2.new(0, 1);
            elseif v103 == "Center" then
                v105 = v105 + UDim2.new(0, u66, 0.5, 0);
                v106 = v106 + Vector2.new(0, 0.5);
            elseif v103 == "Bottom" then
                v105 = v105 + UDim2.new(0, u66, 1, 0);
                v106 = v106 + Vector2.new(0, 0);
            end;
            if v104 ~= "Left" and v104 ~= "Center" then
                local _ = v104 == "Right";
            end;
            p98.Position = v105;
            p98.AnchorPoint = v106;
            u66 = u66 + p100;
            if u66 > u53.AbsoluteSize.X and u66 ~= p100 then
                p98:Destroy();
                local v107 = u64[#u63][#u64[#u63]];
                if v107:IsA("TextLabel") and v107.Text == " " then
                    v102.Container.Size = UDim2.new(0, u66 - p100 - v107.Size.X.Offset, 1, 0);
                    v107:Destroy();
                    table.remove(u64[#u63]);
                end;
                u97();
                p101();
            else
                p98.Size = UDim2.new(0, p100, 0, p99);
                v102.Container.Size = UDim2.new(0, u66, 1, 0);
                v102.Size = UDim2.new(1, 0, 0, (math.max(v102.Size.Y.Offset, p99)));
                p98.Name = string.format("Group%03d", #u64[#u63] + 1);
                p98.Parent = v102.Container;
                table.insert(u64[#u63], p98);
                u65[p98] = shallowCopy(u61);
                u65[p98].InitialSize = p98.Size;
                u65[p98].InitialPosition = p98.Position;
                u65[p98].InitialAnchorPoint = p98.AnchorPoint;
                u61.AnimateYield = 0;
            end;
        end;
        local function u119(u109) --[[ Line: 576 ]]
            -- upvalues: u97 (copy), u66 (ref), u61 (ref), u70 (copy), u53 (copy), l__TextService__1 (ref), u68 (copy), u65 (copy), u108 (ref), u67 (ref), u119 (ref)
            if u109 == "\n" then
                u97();
            elseif u109 == " " and u66 == 0 then
            else
                local v110;
                if u61.TextScaled == true then
                    local v111 = nil;
                    if u61.TextScaleRelativeTo == "Screen" then
                        v111 = u70.AbsoluteSize.Y;
                    elseif u61.TextScaleRelativeTo == "Frame" then
                        v111 = u53.AbsoluteSize.Y;
                    end;
                    v110 = math.min(u61.TextScale * v111, 100);
                else
                    v110 = u61.TextSize;
                end;
                local l__X__3 = l__TextService__1:GetTextSize(u109, v110, u68.Font, Vector2.new(u70.AbsoluteSize.X, v110)).X;
                local v112 = u68:Clone();
                v112.TextScaled = false;
                v112.TextSize = v110;
                v112.Text = u109;
                v112.TextTransparency = 1;
                v112.TextStrokeTransparency = 1;
                v112.TextWrapped = false;
                local v113 = 1;
                local v114 = 0;
                for v115, v116 in utf8.graphemes(u109) do
                    local v117 = string.sub(u109, v115, v116);
                    local l__X__4 = l__TextService__1:GetTextSize(v117, v110, u68.Font, Vector2.new(u70.AbsoluteSize.X, v110)).X;
                    local v118 = u68:Clone();
                    v118.Text = v117;
                    v118.TextScaled = false;
                    v118.TextSize = v110;
                    v118.Position = UDim2.new(0, v114, 0, 0);
                    v118.Size = UDim2.new(0, l__X__4 + 1, 0, v110);
                    v118.Name = string.format("Char%03d", v113);
                    v118.Parent = v112;
                    v118.Visible = false;
                    u65[v118] = shallowCopy(u61);
                    u65[v118].InitialSize = v118.Size;
                    u65[v118].InitialPosition = v118.Position;
                    u65[v118].InitialAnchorPoint = v118.AnchorPoint;
                    v114 = v114 + l__X__4;
                    v113 = v113 + 1;
                end;
                u108(v112, v110, l__X__3, function() --[[ Line: 615 ]]
                    -- upvalues: u67 (ref), u119 (ref), u109 (copy)
                    if not u67 then
                        u119(u109);
                    end;
                end);
            end;
        end;
        u72 = function(u120) --[[ Name: printImage, Line 618 ]]
            -- upvalues: u61 (ref), u70 (copy), u53 (copy), u69 (copy), u1 (ref), u108 (ref), u67 (ref), u72 (ref)
            local v121;
            if u61.TextScaled == true then
                local v122 = nil;
                if u61.TextScaleRelativeTo == "Screen" then
                    v122 = u70.AbsoluteSize.Y;
                elseif u61.TextScaleRelativeTo == "Frame" then
                    v122 = u53.AbsoluteSize.Y;
                end;
                v121 = math.min(u61.TextScale * v122, 100);
            else
                v121 = u61.TextSize;
            end;
            local v123 = u69:Clone();
            if u1.ImageShortcuts[u120] then
                v123.Image = typeof(u1.ImageShortcuts[u120]) == "number" and "rbxassetid://" .. u1.ImageShortcuts[u120] or u1.ImageShortcuts[u120];
            else
                v123.Image = "rbxassetid://" .. u120;
            end;
            v123.Size = UDim2.new(0, v121, 0, v121);
            v123.Visible = false;
            u108(v123, v121, v121, function() --[[ Line: 632 ]]
                -- upvalues: u67 (ref), u72 (ref), u120 (copy)
                if not u67 then
                    u72(u120);
                end;
            end);
        end;
        local function v128(p124) --[[ Line: 635 ]]
            -- upvalues: u76 (ref), u119 (ref)
            for _, v125 in pairs(p124) do
                local v126, v127 = string.match(v125, "<(.+)=(.+)>");
                if v126 and v127 then
                    if not u76(v126, v127) then
                        warn("Could not apply markup: ", v125);
                    end;
                else
                    u119(v125);
                end;
            end;
        end;
        local v129 = #p54;
        local v130 = {};
        local v131;
        if p57 then
            v131 = p57.OverflowPickupIndex;
        else
            v131 = 1;
        end;
        local v132;
        while true do
            if not v131 or v131 > v129 then
                v132 = v131;
                break;
            end;
            local v133;
            v132, v133 = string.find(p54, "<.->", v131);
            local v134, v135 = string.find(p54, "[ \t\n]", v131);
            local v136;
            if v132 and (v133 and (not v134 or v132 < v134)) then
                v136 = nil;
            else
                v132 = v134 or v129 + 1;
                v133 = v135 or v129 + 1;
                v136 = true;
            end;
            local v137;
            if v131 < v132 then
                v137 = string.sub(p54, v131, v132 - 1) or nil;
            else
                v137 = nil;
            end;
            local v138;
            if v132 <= v129 then
                v138 = string.sub(p54, v132, v133) or nil;
            else
                v138 = nil;
            end;
            table.insert(v130, v137);
            if v136 then
                v128(v130);
                if u67 then
                    v132 = v131;
                    break;
                end;
                v128({ v138 });
                if u67 then
                    break;
                end;
                v130 = {};
            else
                table.insert(v130, v138);
            end;
            v131 = v133 + 1;
        end;
        if not u67 then
            v128(v130);
        end;
        local v139 = Instance.new("UIListLayout");
        v139.HorizontalAlignment = u61.ContainerHorizontalAlignment;
        v139.VerticalAlignment = u61.ContainerVerticalAlignment;
        v139.Parent = u53;
        local l__X__5 = u53.AbsoluteSize.X;
        local v140 = 0;
        local v141 = 0;
        for _, v142 in pairs(u63) do
            v140 = v140 + v142.Size.Y.Offset;
            local l__Container__6 = v142.Container;
            local v143 = nil;
            local v144 = nil;
            if l__Container__6.AnchorPoint.X == 0 then
                v143 = l__Container__6.Position.X.Offset;
                v144 = l__Container__6.Size.X.Offset;
            elseif l__Container__6.AnchorPoint.X == 0.5 then
                v143 = v142.AbsoluteSize.X / 2 - l__Container__6.Size.X.Offset / 2;
                v144 = v142.AbsoluteSize.X / 2 + l__Container__6.Size.X.Offset / 2;
            elseif l__Container__6.AnchorPoint.X == 1 then
                v143 = v142.AbsoluteSize.X - l__Container__6.Size.X.Offset;
                v144 = v142.AbsoluteSize.X;
            end;
            l__X__5 = math.min(l__X__5, v143);
            v141 = math.max(v141, v144);
        end;
        u38 = u38 + 1;
        local u145 = false;
        local u146 = false;
        local u147 = false;
        local u148 = "TextAnimation" .. u38;
        local u149 = {};
        local function u155() --[[ Line: 733 ]]
            -- upvalues: u146 (ref), u149 (ref), u145 (ref), l__RunService__2 (ref), u148 (copy), u37 (ref)
            if u146 and #u149 == 0 or u145 then
                u145 = true;
                l__RunService__2:UnbindFromRenderStep(u148);
                u149 = {};
            else
                local v150 = tick();
                for v151 = #u149, 1, -1 do
                    local v152 = u149[v151];
                    local l__Settings__7 = v152.Settings;
                    local v153 = u37[l__Settings__7.AnimateStyle];
                    if not v153 then
                        warn("No animation style found for: ", l__Settings__7.AnimateStyle, ", defaulting to Appear");
                        v153 = u37.Appear;
                    end;
                    local v154 = math.min((v150 - v152.Start) / l__Settings__7.AnimateStyleTime, 1);
                    v153(v152.Char, v154, l__Settings__7);
                    if v154 >= 1 then
                        table.remove(u149, v151);
                    end;
                end;
            end;
        end;
        local function u159(p156) --[[ Line: 758 ]]
            -- upvalues: u65 (copy), u83 (ref)
            p156.Position = u65[p156].InitialPosition;
            p156.Size = u65[p156].InitialSize;
            p156.AnchorPoint = u65[p156].InitialAnchorPoint;
            for v157, v158 in pairs(u65[p156]) do
                u83(v157, v158, p156);
            end;
        end;
        local function u186(p160) --[[ Line: 780 ]]
            -- upvalues: u145 (ref), l__RunService__2 (ref), u148 (copy), u155 (copy), u64 (copy), u149 (ref), u147 (ref), u53 (copy), u65 (copy), u146 (ref)
            u145 = false;
            l__RunService__2:BindToRenderStep(u148, Enum.RenderPriority.Last.Value, u155);
            local u161 = nil;
            local u162 = nil;
            local u163 = nil;
            local v164 = nil;
            for _, v165 in pairs(u64) do
                for _, v166 in pairs(v165) do
                    v166.Visible = false;
                    for _, v167 in pairs(v166:GetChildren()) do
                        v167.Visible = false;
                    end;
                end;
            end;
            local u168 = false;
            local function v170() --[[ Line: 802 ]]
                -- upvalues: u147 (ref), u161 (ref), u162 (ref), u163 (ref), u168 (ref), u53 (ref), l__RunService__2 (ref)
                if not u147 and (u161 % u162 == 0 and u163 >= 0) then
                    local v169 = u163 > 0 and u163 or nil;
                    if not u168 then
                        u168 = true;
                        u53.Parent.TypeWriter.TimePosition = 0.1;
                        u53.Parent.TypeWriter:Play();
                        coroutine.resume(coroutine.create(function() --[[ Line: 817 ]]
                            -- upvalues: u168 (ref)
                            wait(0.1);
                            u168 = false;
                        end));
                    end;
                    if not v169 or v169 <= 0 then
                        l__RunService__2.RenderStepped:Wait();
                        return;
                    end;
                    wait(v169);
                end;
            end;
            for _, v171 in pairs(u64) do
                for _, v172 in pairs(v171) do
                    local v173 = u65[v172];
                    u161 = (v173.AnimateStepGrouping ~= v164 or v173.AnimateStepFrequency ~= u162) and 0 or u161;
                    v164 = v173.AnimateStepGrouping;
                    local _ = v173.AnimateStepTime;
                    local l__AnimateStepFrequency__8 = v173.AnimateStepFrequency;
                    if v173.AnimateYield > 0 then
                        wait(v173.AnimateYield);
                    end;
                    local v174;
                    if v164 == "Word" or v164 == "All" then
                        if v172:IsA("TextLabel") then
                            v172.Visible = true;
                            u162 = l__AnimateStepFrequency__8;
                            for _, v175 in pairs(v172:GetChildren()) do
                                local v176 = u149;
                                local v177 = {
                                    Char = v175,
                                    Settings = u65[v175],
                                    Start = tick()
                                };
                                table.insert(v176, v177);
                            end;
                        else
                            local v178 = u149;
                            local v179 = {
                                Char = v172,
                                Settings = v173,
                                Start = tick()
                            };
                            table.insert(v178, v179);
                            u162 = l__AnimateStepFrequency__8;
                        end;
                        if v164 == "Word" then
                            v174 = u161 + 1;
                            v170();
                            u161 = v174;
                        end;
                    elseif v164 == "Letter" then
                        if v172:IsA("TextLabel") then
                            v172.Visible = true;
                            local _ = v172.Text;
                            u162 = l__AnimateStepFrequency__8;
                            local v180 = 1;
                            while true do
                                local v181 = v172:FindFirstChild(string.format("Char%03d", v180));
                                if not v181 then
                                    break;
                                end;
                                local v182 = u149;
                                local v183 = {
                                    Char = v181,
                                    Settings = u65[v181],
                                    Start = tick()
                                };
                                table.insert(v182, v183);
                                v174 = u161 + 1;
                                v170();
                                if u145 then
                                    return;
                                end;
                                v180 = v180 + 1;
                                u161 = v174;
                            end;
                        else
                            local v184 = u149;
                            local v185 = {
                                Char = v172,
                                Settings = v173,
                                Start = tick()
                            };
                            table.insert(v184, v185);
                            v174 = u161 + 1;
                            v170();
                            u161 = v174;
                            u162 = l__AnimateStepFrequency__8;
                        end;
                    else
                        warn("Invalid step grouping: ", v164);
                        u162 = l__AnimateStepFrequency__8;
                    end;
                    if u145 then
                        return;
                    end;
                end;
            end;
            u146 = true;
            if p160 then
                while #u149 > 0 do
                    l__RunService__2.RenderStepped:Wait();
                end;
            end;
        end;
        local u187 = {
            Overflown = u67,
            OverflowPickupIndex = v132,
            StartingProperties = p55,
            OverflowPickupProperties = u61,
            Text = p54
        };
        if p57 then
            p57.NextTextObject = u187;
        end;
        local u188 = false;
        local u189 = false;
        u187.ContentSize = Vector2.new(v141 - l__X__5, v140);
        u187.Tweens = {};
        function u187.Animate(p190, p191) --[[ Line: 926 ]]
            -- upvalues: u58 (copy), u189 (ref), u188 (ref), u187 (copy), u186 (copy)
            if u58.LastFrame and u58.NewFrame then
                u58.LastFrame.Parent.ClipsDescendants = true;
                u58.LastFrame.Parent.Parent.ClickContinue.Visible = true;
                tick();
                u189 = true;
                while not u188 do
                    wait();
                end;
                u189 = false;
                u188 = false;
                u58.LastFrame.Parent.Parent.ClickContinue.Visible = false;
                local u192 = tick();
                u58.NewFrame.Visible = true;
                local v193 = game:GetService("TweenService"):Create(u58.LastFrame, TweenInfo.new(1, Enum.EasingStyle.Linear), {
                    Position = UDim2.new(0, 0, -1, 0)
                });
                v193:Play();
                u187.Tweens[v193] = {
                    Position = UDim2.new(0, 0, -1, 0)
                };
                local v194 = game:GetService("TweenService"):Create(u58.NewFrame, TweenInfo.new(1, Enum.EasingStyle.Linear), {
                    Position = UDim2.new(0, 0, 0, 0)
                });
                v194:Play();
                u187.Tweens[v194] = {
                    Position = UDim2.new(0, 0, 0, 0)
                };
                v194.Completed:connect(function() --[[ Line: 958 ]]
                    -- upvalues: u58 (ref), u192 (ref)
                    u58.LastFrame.Visible = false;
                    if tick() - u192 >= 1 and (u58.LastFrame and u58.LastFrame.Parent) then
                        u58.LastFrame.Parent.ClipsDescendants = false;
                    end;
                end);
            end;
            if p191 then
                u186();
            else
                coroutine.wrap(u186)();
            end;
            if p190.NextTextObject then
                p190.NextTextObject:Animate(p191);
            end;
        end;
        function u187.CancelTweens(_) --[[ Line: 980 ]]
            -- upvalues: u187 (copy)
            for v195, v196 in pairs(u187.Tweens) do
                v195:Cancel();
                if v196.Position then
                    v195.Instance.Position = v196.Position;
                end;
            end;
        end;
        function u187.Show(p197, p198) --[[ Line: 990 ]]
            -- upvalues: u187 (copy), u189 (ref), u188 (ref), u147 (ref), u145 (ref), u64 (copy), u159 (copy)
            u187:CancelTweens();
            if u189 then
                u188 = true;
            end;
            u187:CancelTweens();
            if p198 then
                u147 = true;
            else
                u145 = true;
                for _, v199 in pairs(u64) do
                    for _, v200 in pairs(v199) do
                        v200.Visible = true;
                        for _, v201 in pairs(v200:GetChildren()) do
                            v201.Visible = true;
                            u159(v201);
                        end;
                        if v200:IsA("ImageLabel") then
                            u159(v200);
                        end;
                    end;
                end;
            end;
            if p197.NextTextObject then
                p197.NextTextObject:Show(p198);
            end;
        end;
        function u187.Hide(p202) --[[ Line: 1012 ]]
            -- upvalues: u145 (ref), u64 (copy)
            u145 = true;
            for _, v203 in pairs(u64) do
                for _, v204 in pairs(v203) do
                    v204.Visible = false;
                    for _, v205 in pairs(v204:GetChildren()) do
                        v205.Visible = false;
                    end;
                end;
            end;
            if p202.NextTextObject then
                p202.NextTextObject:Hide();
            end;
        end;
        return u187;
    end;
    function u1.ContinueOverflow(_, p206, p207, ...) --[[ Line: 1028 ]]
        -- upvalues: u1 (copy)
        return u1:New(p206, nil, nil, false, p207, ...);
    end;
    return u1;
end;