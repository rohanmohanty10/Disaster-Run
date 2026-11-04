 
 

local script_Parent = script.Parent;
local useChild = require(script_Parent.useChild);
local useTagged = require(script_Parent.useTagged);
local useAttribute = require(script_Parent.useAttribute);

local function useColor3(p1: userdata?, p2: string, u3) -- Line: 6
    -- upvalues: useAttribute (copy)
    return useAttribute(p1, p2, function(p4) -- Line: 7
        -- upvalues: u3 (copy)
        if typeof(p4) == "Color3" then
            return p4;
        end;

        return u3 or Color3.fromHex("#FFFFFF");
    end);
end;

local function useColorSequence(p5: userdata?, p6: string, u7: userdata?) -- Line: 16
    -- upvalues: useAttribute (copy)
    return useAttribute(p5, p6, function(p8) -- Line: 17
        -- upvalues: u7 (copy)
        if typeof(p8) == "ColorSequence" then
            return p8;
        end;

        return u7 or ColorSequence.new(Color3.fromHex("#FFFFFF"));
    end);
end;

local function useFont(p9: userdata?, p10: string, u11: userdata?) -- Line: 26
    -- upvalues: useAttribute (copy)
    return useAttribute(p9, p10, function(p12) -- Line: 27
        -- upvalues: u11 (copy)
        if typeof(p12) == "Font" then
            return p12;
        end;

        return u11 or Font.fromEnum(Enum.Font.SourceSans);
    end);
end;

local function useString(p13: userdata?, p14: string, u15: string?) -- Line: 36
    -- upvalues: useAttribute (copy)
    return useAttribute(p13, p14, function(p16) -- Line: 37
        -- upvalues: u15 (copy)
        return typeof(p16) ~= "string" and (u15 or "") or p16;
    end);
end;

local function useUDim(p17: userdata?, p18: string, u19) -- Line: 46
    -- upvalues: useAttribute (copy)
    return useAttribute(p17, p18, function(p20) -- Line: 47
        -- upvalues: u19 (copy)
        if typeof(p20) == "UDim" then
            return p20;
        end;

        return u19 or UDim.new();
    end);
end;

local function useNumber(p21: userdata?, p22: string, u23: number?) -- Line: 56
    -- upvalues: useAttribute (copy)
    return useAttribute(p21, p22, function(p24) -- Line: 57
        -- upvalues: u23 (copy)
        return tonumber(p24) or (u23 or 0);
    end);
end;

local function useBoolean(p25: userdata?, p26: string, u27: boolean?) -- Line: 62
    -- upvalues: useAttribute (copy)
    return useAttribute(p25, p26, function(p28) -- Line: 63
        -- upvalues: u27 (copy)
        if p28 == nil and u27 ~= nil then
            return u27;
        end;

        return p28 and true or false;
    end);
end;

return function() -- Line: 72, Name: useTheme
    -- upvalues: useTagged (copy), useChild (copy), useAttribute (copy), useColor3 (copy)
    local v29 = useTagged("RelicsTheme")[1];
    local v30 = useChild(v29, "Branding");
    local v31 = useChild(v29, "Palette");
    local v32 = useChild(v29, "Sounds");
    local v33 = useChild(v29, "Images");
    local v34 = useChild(v29, "Tweaks");
    local v35 = useChild(v29, "Fonts");
    local v36 = useChild(v33, "NavOverlays");
    local v37 = useChild(v33, "Favorite");
    local v38 = useChild(v33, "Volume");
    local v39 = useChild(v33, "NavBar");
    local Font_fromId_ret = Font.fromId(12187365364, Enum.FontWeight.Regular);
    local v41 = useAttribute(v35, "Main", function(p40) -- Line: 27
        -- upvalues: Font_fromId_ret (copy)
        if typeof(p40) == "Font" then
            return p40;
        end;

        return Font_fromId_ret or Font.fromEnum(Enum.Font.SourceSans);
    end);
    local v42 = {};
    local v43;

    if v30 then
        v43 = {};
        local u44 = "rbxassetid://17420381909";
        v43.Image = useAttribute(v30, "Image", function(p45) -- Line: 37
            -- upvalues: u44 (copy)
            return typeof(p45) ~= "string" and (u44 or "") or p45;
        end);
        v43.Size = useAttribute(v30, "Size", function(p46) -- Line: 96
            return typeof(p46) == "UDim2" and p46 and p46 or UDim2.fromOffset(125, 28);
        end);
    else
        v43 = v30;
    end;

    v42.Branding = v43;
    local v50 = {
        AnchorPoint = useAttribute(v29, "AnchorPoint", function(p47) -- Line: 102
            return typeof(p47) == "Vector2" and p47 and p47 or Vector2.one;
        end),
        Scale = useAttribute(v29, "Scale", function(p48) -- Line: 106
            return type(p48) == "number" and p48 and p48 or 1;
        end),
        Position = useAttribute(v29, "Position", function(p49) -- Line: 110
            return typeof(p49) == "UDim2" and p49 and p49 or UDim2.new(1, -64, 1, -64);
        end)
    };
    local u51 = true;
    v50.ScrollingFrameScaleHack = useAttribute(v29, "ScrollingFrameScaleHack", function(p52) -- Line: 63
        -- upvalues: u51 (copy)
        if p52 == nil and u51 ~= nil then
            return u51;
        end;

        return p52 and true or false;
    end);
    v42.Window = v50;
    local v53 = {
        BLACK = Color3.new(),
        WHITE = Color3.fromHex("#FFFFFF")
    };
    local Color3_fromHex_ret = Color3.fromHex("#FFFFFF");
    v53.TEXT = useAttribute(v31, "TEXT", function(p54) -- Line: 7
        -- upvalues: Color3_fromHex_ret (copy)
        if typeof(p54) == "Color3" then
            return p54;
        end;

        return Color3_fromHex_ret or Color3.fromHex("#FFFFFF");
    end);
    local Color3_fromHex_ret2 = Color3.fromHex("#FFFFFF");
    v53.TITLE = useAttribute(v31, "TITLE", function(p55) -- Line: 7
        -- upvalues: Color3_fromHex_ret2 (copy)
        if typeof(p55) == "Color3" then
            return p55;
        end;

        return Color3_fromHex_ret2 or Color3.fromHex("#FFFFFF");
    end);
    local Color3_fromHex_ret3 = Color3.fromHex("#868686");
    v53.DIM_TEXT = useAttribute(v31, "DIM_TEXT", function(p56) -- Line: 7
        -- upvalues: Color3_fromHex_ret3 (copy)
        if typeof(p56) == "Color3" then
            return p56;
        end;

        return Color3_fromHex_ret3 or Color3.fromHex("#FFFFFF");
    end);
    local Color3_fromHex_ret4 = Color3.fromHex("#FFFFFF");
    v53.BRIGHT = useAttribute(v31, "BRIGHT", function(p57) -- Line: 7
        -- upvalues: Color3_fromHex_ret4 (copy)
        if typeof(p57) == "Color3" then
            return p57;
        end;

        return Color3_fromHex_ret4 or Color3.fromHex("#FFFFFF");
    end);
    local Color3_fromHex_ret5 = Color3.fromHex("#868686");
    v53.GRAY = useAttribute(v31, "GRAY", function(p58) -- Line: 7
        -- upvalues: Color3_fromHex_ret5 (copy)
        if typeof(p58) == "Color3" then
            return p58;
        end;

        return Color3_fromHex_ret5 or Color3.fromHex("#FFFFFF");
    end);
    local Color3_fromHex_ret6 = Color3.fromHex("#999999");
    v53.LIGHT = useAttribute(v31, "LIGHT", function(p59) -- Line: 7
        -- upvalues: Color3_fromHex_ret6 (copy)
        if typeof(p59) == "Color3" then
            return p59;
        end;

        return Color3_fromHex_ret6 or Color3.fromHex("#FFFFFF");
    end);
    local Color3_fromHex_ret7 = Color3.fromHex("#E51BE7");
    v53.ACTIVE = useAttribute(v31, "ACTIVE", function(p60) -- Line: 7
        -- upvalues: Color3_fromHex_ret7 (copy)
        if typeof(p60) == "Color3" then
            return p60;
        end;

        return Color3_fromHex_ret7 or Color3.fromHex("#FFFFFF");
    end);
    local Color3_fromHex_ret8 = Color3.fromHex("E9BAEA");
    v53.LIGHT_ACTIVE = useAttribute(v31, "LIGHT_ACTIVE", function(p61) -- Line: 7
        -- upvalues: Color3_fromHex_ret8 (copy)
        if typeof(p61) == "Color3" then
            return p61;
        end;

        return Color3_fromHex_ret8 or Color3.fromHex("#FFFFFF");
    end);
    local Color3_fromHex_ret9 = Color3.fromHex("#262626");
    v53.BACKGROUND_LIGHT = useAttribute(v31, "BACKGROUND_LIGHT", function(p62) -- Line: 7
        -- upvalues: Color3_fromHex_ret9 (copy)
        if typeof(p62) == "Color3" then
            return p62;
        end;

        return Color3_fromHex_ret9 or Color3.fromHex("#FFFFFF");
    end);
    local Color3_fromHex_ret10 = Color3.fromHex("#1C1C1C");
    v53.BACKGROUND_MID_PANEL = useAttribute(v31, "BACKGROUND_MID_PANEL", function(p63) -- Line: 7
        -- upvalues: Color3_fromHex_ret10 (copy)
        if typeof(p63) == "Color3" then
            return p63;
        end;

        return Color3_fromHex_ret10 or Color3.fromHex("#FFFFFF");
    end);
    local Color3_fromHex_ret11 = Color3.fromHex("#111111");
    v53.BACKGROUND_FORE_PANEL = useAttribute(v31, "BACKGROUND_FORE_PANEL", function(p64) -- Line: 7
        -- upvalues: Color3_fromHex_ret11 (copy)
        if typeof(p64) == "Color3" then
            return p64;
        end;

        return Color3_fromHex_ret11 or Color3.fromHex("#FFFFFF");
    end);
    local Color3_fromHex_ret12 = Color3.fromHex("#1A1A1A");
    v53.BACKGROUND_HEADER_FOOTER = useAttribute(v31, "BACKGROUND_HEADER_FOOTER", function(p65) -- Line: 7
        -- upvalues: Color3_fromHex_ret12 (copy)
        if typeof(p65) == "Color3" then
            return p65;
        end;

        return Color3_fromHex_ret12 or Color3.fromHex("#FFFFFF");
    end);
    local ColorSequence_new = ColorSequence.new;
    local Color3_fromHex_ret13 = Color3.fromHex("#1A1A1A");
    v53.BACKGROUND_GRADIENT = ColorSequence_new(useAttribute(v31, "BACKGROUND_HEADER_FOOTER", function(p66) -- Line: 7
        -- upvalues: Color3_fromHex_ret13 (copy)
        if typeof(p66) == "Color3" then
            return p66;
        end;

        return Color3_fromHex_ret13 or Color3.fromHex("#FFFFFF");
    end), useColor3(v31, "BACKGROUND_LIGHT", Color3.fromHex("#262626")));
    local ColorSequence_new_ret = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromHex("#7F00FF")), ColorSequenceKeypoint.new(0.875, Color3.fromHex("#0000FF")), ColorSequenceKeypoint.new(1, Color3.fromHex("#FF00FF")) });
    v53.SPECTROGRAM_GRADIENT = useAttribute(v31, "SPECTROGRAM_GRADIENT", function(p67) -- Line: 17
        -- upvalues: ColorSequence_new_ret (copy)
        if typeof(p67) == "ColorSequence" then
            return p67;
        end;

        return ColorSequence_new_ret or ColorSequence.new(Color3.fromHex("#FFFFFF"));
    end);
    local Color3_fromHex_ret14 = Color3.fromHex("#FFFFFF");
    v53.CONTROLS = useAttribute(v31, "CONTROLS", function(p68) -- Line: 7
        -- upvalues: Color3_fromHex_ret14 (copy)
        if typeof(p68) == "Color3" then
            return p68;
        end;

        return Color3_fromHex_ret14 or Color3.fromHex("#FFFFFF");
    end);
    v42.Colors = v53;
    local v69 = {
        Regular = v41,
        Medium = Font.new(v41.Family, Enum.FontWeight.Medium),
        Bold = Font.new(v41.Family, Enum.FontWeight.Bold)
    };
    local Font_new_ret = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Medium);
    v69.Card = useAttribute(v35, "Card", function(p70) -- Line: 27
        -- upvalues: Font_new_ret (copy)
        if typeof(p70) == "Font" then
            return p70;
        end;

        return Font_new_ret or Font.fromEnum(Enum.Font.SourceSans);
    end);
    v42.Fonts = v69;
    local v71 = {};
    local u72 = "rbxassetid://138925436887230";
    v71.Logo = useAttribute(v33, "Logo", function(p73) -- Line: 37
        -- upvalues: u72 (copy)
        return typeof(p73) ~= "string" and (u72 or "") or p73;
    end);
    local u74 = "rbxassetid://123357296109011";
    v71.Loop = useAttribute(v33, "Loop", function(p75) -- Line: 37
        -- upvalues: u74 (copy)
        return typeof(p75) ~= "string" and (u74 or "") or p75;
    end);
    local u76 = "rbxassetid://17571564173";
    v71.Star = useAttribute(v33, "Star", function(p77) -- Line: 37
        -- upvalues: u76 (copy)
        return typeof(p77) ~= "string" and (u76 or "") or p77;
    end);
    local u78 = "rbxassetid://17515231818";
    v71.Close = useAttribute(v33, "Close", function(p79) -- Line: 37
        -- upvalues: u78 (copy)
        return typeof(p79) ~= "string" and (u78 or "") or p79;
    end);
    local u80 = "rbxassetid://17515231973";
    v71.Return = useAttribute(v33, "Return", function(p81) -- Line: 37
        -- upvalues: u80 (copy)
        return typeof(p81) ~= "string" and (u80 or "") or p81;
    end);
    local u82 = "rbxassetid://17813164012";
    v71.Search = useAttribute(v33, "Search", function(p83) -- Line: 37
        -- upvalues: u82 (copy)
        return typeof(p83) ~= "string" and (u82 or "") or p83;
    end);
    local u84 = "rbxassetid://89284325793514";
    v71.Locked = useAttribute(v33, "Locked", function(p85) -- Line: 37
        -- upvalues: u84 (copy)
        return typeof(p85) ~= "string" and (u84 or "") or p85;
    end);
    local u86 = "rbxassetid://17515231750";
    v71.Compress = useAttribute(v33, "Compress", function(p87) -- Line: 37
        -- upvalues: u86 (copy)
        return typeof(p87) ~= "string" and (u86 or "") or p87;
    end);
    local u88 = "rbxassetid://17732143513";
    v71.Background = useAttribute(v33, "Background", function(p89) -- Line: 37
        -- upvalues: u88 (copy)
        return typeof(p89) ~= "string" and (u88 or "") or p89;
    end);
    local u90 = "rbxassetid://18233920231";
    v71.LockedPlaylist = useAttribute(v33, "LockedPlaylist", function(p91) -- Line: 37
        -- upvalues: u90 (copy)
        return typeof(p91) ~= "string" and (u90 or "") or p91;
    end);
    local v92 = {};
    local u93 = "rbxassetid://17583155277";
    v92.On = useAttribute(v37, "On", function(p94) -- Line: 37
        -- upvalues: u93 (copy)
        return typeof(p94) ~= "string" and (u93 or "") or p94;
    end);
    local u95 = "rbxassetid://17515231689";
    v92.Off = useAttribute(v37, "Off", function(p96) -- Line: 37
        -- upvalues: u95 (copy)
        return typeof(p96) ~= "string" and (u95 or "") or p96;
    end);
    v71.Favorite = v92;
    local u97 = "rbxassetid://17515304509";
    v71.Forward = useAttribute(v33, "Forward", function(p98) -- Line: 37
        -- upvalues: u97 (copy)
        return typeof(p98) ~= "string" and (u97 or "") or p98;
    end);
    local u99 = "rbxassetid://17515304661";
    v71.Backward = useAttribute(v33, "Backward", function(p100) -- Line: 37
        -- upvalues: u99 (copy)
        return typeof(p100) ~= "string" and (u99 or "") or p100;
    end);
    local v101 = {};
    local u102 = "rbxassetid://17515231455";
    v101.Play = useAttribute(v39, "Play", function(p103) -- Line: 37
        -- upvalues: u102 (copy)
        return typeof(p103) ~= "string" and (u102 or "") or p103;
    end);
    local u104 = "rbxassetid://17515231883";
    v101.Browse = useAttribute(v39, "Browse", function(p105) -- Line: 37
        -- upvalues: u104 (copy)
        return typeof(p105) ~= "string" and (u104 or "") or p105;
    end);
    local u106 = "rbxassetid://17515231689";
    v101.Favorites = useAttribute(v39, "Favorites", function(p107) -- Line: 37
        -- upvalues: u106 (copy)
        return typeof(p107) ~= "string" and (u106 or "") or p107;
    end);
    local u108 = "rbxassetid://17515230993";
    v101.Upgrades = useAttribute(v39, "Upgrades", function(p109) -- Line: 37
        -- upvalues: u108 (copy)
        return typeof(p109) ~= "string" and (u108 or "") or p109;
    end);
    local u110 = "rbxassetid://17515231104";
    v101.Settings = useAttribute(v39, "Settings", function(p111) -- Line: 37
        -- upvalues: u110 (copy)
        return typeof(p111) ~= "string" and (u110 or "") or p111;
    end);
    local u112 = "rbxassetid://86646413851888";
    v101.Auras = useAttribute(v39, "Auras", function(p113) -- Line: 37
        -- upvalues: u112 (copy)
        return typeof(p113) ~= "string" and (u112 or "") or p113;
    end);
    v71.NavBar = v101;
    local v114 = {};
    local u115 = "rbxassetid://17582128393";
    v114.Favorites = useAttribute(v36, "Favorites", function(p116) -- Line: 37
        -- upvalues: u115 (copy)
        return typeof(p116) ~= "string" and (u115 or "") or p116;
    end);
    v71.NavOverlays = v114;
    local v117 = {};
    local u118 = "rbxassetid://17515231538";
    v117.Low = useAttribute(v38, "Low", function(p119) -- Line: 37
        -- upvalues: u118 (copy)
        return typeof(p119) ~= "string" and (u118 or "") or p119;
    end);
    local u120 = "rbxassetid://17515231605";
    v117.High = useAttribute(v38, "High", function(p121) -- Line: 37
        -- upvalues: u120 (copy)
        return typeof(p121) ~= "string" and (u120 or "") or p121;
    end);
    v71.Volume = v117;
    v42.Images = v71;
    local v122 = {};
    local u123 = "rbxassetid://10066936758";
    v122.Hover = useAttribute(v32, "Hover", function(p124) -- Line: 37
        -- upvalues: u123 (copy)
        return typeof(p124) ~= "string" and (u123 or "") or p124;
    end);
    local u125 = "rbxassetid://6895079853";
    v122.Press = useAttribute(v32, "Press", function(p126) -- Line: 37
        -- upvalues: u125 (copy)
        return typeof(p126) ~= "string" and (u125 or "") or p126;
    end);
    local u127 = "rbxassetid://12221996";
    v122.Volume = useAttribute(v32, "Volume", function(p128) -- Line: 37
        -- upvalues: u127 (copy)
        return typeof(p128) ~= "string" and (u127 or "") or p128;
    end);
    v42.Sounds = v122;
    local v129 = {};
    local u130 = 390;
    v129.CoreWidth = useAttribute(v34, "CoreWidth", function(p131) -- Line: 57
        -- upvalues: u130 (copy)
        return tonumber(p131) or (u130 or 0);
    end);
    local UDim_new_ret = UDim.new(0, 9);
    v129.PanelCornerRadius = useAttribute(v34, "PanelCornerRadius", function(p132) -- Line: 47
        -- upvalues: UDim_new_ret (copy)
        if typeof(p132) == "UDim" then
            return p132;
        end;

        return UDim_new_ret or UDim.new();
    end);
    local Color3_fromHex_ret15 = Color3.fromHex("#FFFFFF");
    v129.LogoTint = useAttribute(v34, "LogoTint", function(p133) -- Line: 7
        -- upvalues: Color3_fromHex_ret15 (copy)
        if typeof(p133) == "Color3" then
            return p133;
        end;

        return Color3_fromHex_ret15 or Color3.fromHex("#FFFFFF");
    end);
    local ColorSequence_new_ret2 = ColorSequence.new(Color3.new(1, 1, 1));
    v129.PanelGradientColor = useAttribute(v34, "PanelGradientColor", function(p134) -- Line: 17
        -- upvalues: ColorSequence_new_ret2 (copy)
        if typeof(p134) == "ColorSequence" then
            return p134;
        end;

        return ColorSequence_new_ret2 or ColorSequence.new(Color3.fromHex("#FFFFFF"));
    end);
    local u135 = 0;
    v129.PanelGradientAngle = useAttribute(v34, "PanelGradientAngle", function(p136) -- Line: 57
        -- upvalues: u135 (copy)
        return tonumber(p136) or (u135 or 0);
    end);
    local u137 = 1;
    v129.PanelTransparency = useAttribute(v34, "PanelTransparency", function(p138) -- Line: 57
        -- upvalues: u137 (copy)
        return tonumber(p138) or (u137 or 0);
    end);
    local u139 = false;
    v129.UseTallWindow = useAttribute(v34, "UseTallWindow", function(p140) -- Line: 63
        -- upvalues: u139 (copy)
        if p140 == nil and u139 ~= nil then
            return u139;
        end;

        return p140 and true or false;
    end);
    local u141 = true;
    v129.ShowCloseButton = useAttribute(v34, "ShowCloseButton", function(p142) -- Line: 63
        -- upvalues: u141 (copy)
        if p142 == nil and u141 ~= nil then
            return u141;
        end;

        return p142 and true or false;
    end);
    local u143 = true;
    v129.ShowCollapseButton = useAttribute(v34, "ShowCollapseButton", function(p144) -- Line: 63
        -- upvalues: u143 (copy)
        if p144 == nil and u143 ~= nil then
            return u143;
        end;

        return p144 and true or false;
    end);
    v42.Tweaks = v129;

    return v42;
end;