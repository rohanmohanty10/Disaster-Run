 

 

local Lighting = game:GetService("Lighting");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local Game = game.ReplicatedStorage:WaitForChild("ChickenOrHero"):WaitForChild("Game");
local u1 = { "Ambient", "Brightness", "ClockTime", "ColorShift_Bottom", "ColorShift_Top", "EnvironmentDiffuseScale", "EnvironmentSpecularScale", "ExposureCompensation", "FogColor", "FogEnd", "FogStart", "GeographicLatitude", "OutdoorAmbient", "ShadowSoftness", "ShadowColor", "GlobalShadows", "LightingStyle", "PrioritizeLightingQuality", "Outlines" };
local u2 = {
    FogEnd = true,
    FogStart = true
};
local u3 = {
    BloomEffect = {
        props = { "Intensity", "Size", "Threshold" },
        none = {
            Intensity = 0
        }
    },
    ColorCorrectionEffect = {
        props = { "Brightness", "Contrast", "Saturation", "TintColor" },
        none = {
            Brightness = 0,
            Contrast = 0,
            Saturation = 0,
            TintColor = Color3.new(1, 1, 1)
        }
    },
    BlurEffect = {
        props = { "Size" },
        none = {
            Size = 0
        }
    },
    SunRaysEffect = {
        props = { "Intensity", "Spread" },
        none = {
            Intensity = 0
        }
    },
    DepthOfFieldEffect = {
        props = { "FarIntensity", "FocusDistance", "InFocusRadius", "NearIntensity" },
        none = {
            FarIntensity = 0,
            NearIntensity = 0
        }
    },
    Atmosphere = {
        props = { "Density", "Offset", "Color", "Decay", "Glare", "Haze" },
        none = {
            Density = 0,
            Glare = 0,
            Haze = 0
        }
    },
    ColorGradingEffect = {
        props = { "TonemapperPreset" },
        none = {}
    }
};
local u4 = { "SkyboxBk", "SkyboxDn", "SkyboxFt", "SkyboxLf", "SkyboxRt", "SkyboxUp", "SunTextureId", "MoonTextureId", "SunAngularSize", "MoonAngularSize", "StarCount", "CelestialBodiesShown", "SkyboxOrientation" };

local function keyOf(p5) -- Line: 82
    -- upvalues: u3 (copy)
    if p5:IsA("Atmosphere") then
        return "Atmosphere";
    end;

    if u3[p5.ClassName] then
        return p5.ClassName .. "|" .. p5.Name;
    end;

    return nil;
end;

local u6 = {};
local u7 = nil;
local u8 = nil;
local u9 = nil;

local function stopFade() -- Line: 93
    -- upvalues: u9 (ref)
    if u9 then
        u9.connection:Disconnect();
        u9 = nil;
    end;
end;

local function read(u10, u11) -- Line: 100
    local success, result = pcall(function() -- Line: 101
        -- upvalues: u10 (copy), u11 (copy)
        return u10[u11];
    end);

    if success then
        return result;
    end;

    return nil;
end;

local function write(u12, u13, u14) -- Line: 106
    pcall(function() -- Line: 107
        -- upvalues: u12 (copy), u13 (copy), u14 (copy)
        u12[u13] = u14;
    end);
end;

local function paintSky(u15) -- Line: 115
    -- upvalues: u7 (ref), u4 (copy)
    if not u7 then
        return;
    end;

    for _, v in u4 do
        local u16 = u7;
        local success, result = pcall(function() -- Line: 101
            -- upvalues: u16 (copy), v (copy)
            return u16[v];
        end);

        if not success then
            result = nil;
        end;

        if result ~= nil then
            pcall(function() -- Line: 107
                -- upvalues: u15 (copy), v (copy), result (copy)
                u15[v] = result;
            end);
        end;
    end;
end;

local u18 = Lighting.ChildAdded:Connect(function(p17) -- Line: 126
    -- upvalues: paintSky (copy)
    if p17:IsA("Sky") then
        paintSky(p17);
    end;
end);

local function apply(p19, u20) -- Line: 132
    -- upvalues: u9 (ref), Lighting (copy), u2 (copy), u1 (copy), u3 (copy), u6 (copy), u8 (ref), u7 (ref), paintSky (copy), TweenService (copy), RunService (copy)
    if u9 then
        u9.connection:Disconnect();
        u9 = nil;
    end;

    local u21 = {};
    local u22 = {};

    local function glide(u23, u24, u25, p26, p27) -- Line: 138
        -- upvalues: u22 (copy), u21 (copy), Lighting (ref), u2 (ref)
        local success, result = pcall(function() -- Line: 101
            -- upvalues: u23 (copy), u24 (copy)
            return u23[u24];
        end);

        if not success then
            result = nil;
        end;

        if result == nil or (u25 == nil or result == u25) then
            return;
        end;

        local v28 = typeof(u25);

        if typeof(result) ~= v28 or v28 ~= "number" and v28 ~= "Color3" then
            table.insert(u22, function() -- Line: 145
                -- upvalues: u23 (copy), u24 (copy), u25 (copy)
                local u29 = u23;
                local u30 = u24;
                local u31 = u25;
                pcall(function() -- Line: 107
                    -- upvalues: u29 (copy), u30 (copy), u31 (copy)
                    u29[u30] = u31;
                end);
            end);

            return;
        end;

        local v32 = {
            object = u23,
            prop = u24,
            from = result,
            to = u25,
            w0 = p26 or 0,
            w1 = p27 or 1
        };
        local v33;

        if u23 == Lighting then
            v33 = u2[u24] or nil;
        else
            v33 = nil;
        end;

        v32.log = v33;
        v32.clock = u23 == Lighting and u24 == "ClockTime" and true or nil;
        table.insert(u21, v32);
    end;

    local DefaultLighting = game.ReplicatedStorage:FindFirstChild("DefaultLighting");
    local u34 = {};

    for _, v in u1 do
        local Attribute = p19:GetAttribute(v);

        if Attribute == nil and (DefaultLighting and DefaultLighting ~= p19) then
            Attribute = DefaultLighting:GetAttribute(v);
        end;

        if Attribute ~= nil then
            glide(Lighting, v, Attribute);
        end;
    end;

    local v35 = {};

    for _, child in Lighting:GetChildren() do
        local v36;

        if child:IsA("Atmosphere") then
            v36 = "Atmosphere";
        elseif u3[child.ClassName] then
            v36 = child.ClassName .. "|" .. child.Name;
        else
            v36 = nil;
        end;

        if v36 and not v35[v36] then
            v35[v36] = child;
        end;
    end;

    local v37 = {};
    local v38 = false;
    local v39 = false;

    for _, child in p19:GetChildren() do
        local v40;

        if child:IsA("Atmosphere") then
            v40 = "Atmosphere";
        elseif u3[child.ClassName] then
            v40 = child.ClassName .. "|" .. child.Name;
        else
            v40 = nil;
        end;

        if v40 then
            v37[v40] = child;
            u6[v40] = true;
        end;
    end;

    for i, v in v37 do
        local u41 = u3[v.ClassName];
        local u42 = v35[i];

        if i == "Atmosphere" and not u42 then
            local u43 = u8 or v:Clone();
            u8 = nil;
            local u44 = v;

            for i2, v2 in u41.none do
                pcall(function() -- Line: 107
                    -- upvalues: u43 (copy), i2 (copy), v2 (copy)
                    u43[i2] = v2;
                end);
            end;

            for _, v2 in u41.props do
                local success, result = pcall(function() -- Line: 101
                    -- upvalues: u44 (copy), v2 (copy)
                    return u44[v2];
                end);

                if not success then
                    result = nil;
                end;

                glide(u43, v2, result, 0.5, 1);
            end;

            table.insert(u22, function() -- Line: 205
                -- upvalues: u43 (copy), Lighting (ref)
                u43.Parent = Lighting;
            end);
            v39 = true;
        else
            local u45;

            if u42 then
                u45 = v;
            else
                u42 = v:Clone();
                u45 = v;

                for i2, v2 in u41.none do
                    pcall(function() -- Line: 107
                        -- upvalues: u42 (copy), i2 (copy), v2 (copy)
                        u42[i2] = v2;
                    end);
                end;

                u42.Parent = Lighting;
            end;

            local u46 = "Enabled";
            local success, result = pcall(function() -- Line: 101
                -- upvalues: u45 (copy), u46 (copy)
                return u45[u46];
            end);

            if not success then
                result = nil;
            end;

            if result == false then
                for i2, v2 in u41.none do
                    glide(u42, i2, v2);
                end;

                table.insert(u34, function() -- Line: 224
                    -- upvalues: u42 (ref), u41 (copy), u45 (copy)
                    local u47 = u42;
                    local u48 = "Enabled";
                    local u49 = false;
                    pcall(function() -- Line: 107
                        -- upvalues: u47 (copy), u48 (copy), u49 (copy)
                        u47[u48] = u49;
                    end);

                    for _, v2 in u41.props do
                        local u50 = u42;
                        local u51 = u45;
                        local success2, result2 = pcall(function() -- Line: 101
                            -- upvalues: u51 (copy), v2 (copy)
                            return u51[v2];
                        end);

                        if not success2 then
                            result2 = nil;
                        end;

                        pcall(function() -- Line: 107
                            -- upvalues: u50 (copy), v2 (copy), result2 (copy)
                            u50[v2] = result2;
                        end);
                    end;
                end);
            else
                local u52 = "Enabled";
                local u53 = true;
                pcall(function() -- Line: 107
                    -- upvalues: u42 (copy), u52 (copy), u53 (copy)
                    u42[u52] = u53;
                end);

                for _, v2 in u41.props do
                    local success2, result2 = pcall(function() -- Line: 101
                        -- upvalues: u45 (copy), v2 (copy)
                        return u45[v2];
                    end);

                    if not success2 then
                        result2 = nil;
                    end;

                    glide(u42, v2, result2);
                end;
            end;
        end;
    end;

    for i, v in v35 do
        if not v37[i] and u6[i] then
            local v54 = u3[v.ClassName];

            if i == "Atmosphere" then
                local u55 = v;

                for i2, v2 in v54.none do
                    glide(u55, i2, v2, 0, 0.5);
                end;

                table.insert(u22, function() -- Line: 246
                    -- upvalues: u55 (copy), u8 (ref)
                    u55.Parent = nil;
                    u8 = u55;
                end);
                v38 = true;
            else
                local u56 = v;

                for i2, v2 in v54.none do
                    glide(u56, i2, v2);
                end;

                table.insert(u34, function() -- Line: 256
                    -- upvalues: u56 (copy)
                    local u57 = u56;
                    local u58 = "Enabled";
                    local u59 = false;
                    pcall(function() -- Line: 107
                        -- upvalues: u57 (copy), u58 (copy), u59 (copy)
                        u57[u58] = u59;
                    end);
                end);
            end;
        end;
    end;

    if v38 or v39 then
        for _, v in u21 do
            if v.object == Lighting and (v.prop == "FogEnd" or (v.prop == "FogStart" or v.prop == "FogColor")) then
                v.w0 = v38 and 0.5 or 0;
                v.w1 = v38 and 1 or 0.5;
            end;
        end;
    end;

    local u60 = p19:FindFirstChildOfClass("Sky");

    if u60 then
        table.insert(u22, function() -- Line: 275
            -- upvalues: u7 (ref), u60 (copy), Lighting (ref), paintSky (ref)
            u7 = u60;
            local v61 = false;

            for _, child in Lighting:GetChildren() do
                if child:IsA("Sky") then
                    paintSky(child);
                    v61 = true;
                end;
            end;

            if not v61 then
                u60:Clone().Parent = Lighting;
            end;
        end);
    end;

    local function set(p62) -- Line: 291
        -- upvalues: u21 (copy), TweenService (ref)
        for _, v in u21 do
            local Value = TweenService:GetValue(math.clamp((p62 - v.w0) / (v.w1 - v.w0), 0, 1), Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
            local u63;

            if typeof(v.to) == "Color3" then
                u63 = v.from:Lerp(v.to, Value);
            elseif v.log then
                local math_max_ret = math.max(v.from, 1);
                local math_log_ret = math.log(math_max_ret);
                local math_max_ret2 = math.max(v.to, 1);
                local v64 = math_log_ret + (math.log(math_max_ret2) - math_log_ret) * Value;
                u63 = math.exp(v64);

                if Value >= 1 then
                    u63 = v.to;
                end;
            elseif v.clock then
                u63 = (v.from + ((v.to - v.from + 12) % 24 - 12) * Value) % 24;
            else
                u63 = v.from + (v.to - v.from) * Value;
            end;

            local object = v.object;
            local prop = v.prop;
            pcall(function() -- Line: 107
                -- upvalues: object (copy), prop (copy), u63 (copy)
                object[prop] = u63;
            end);
        end;
    end;

    local function run(p65) -- Line: 317
        for _, v in p65 do
            v();
        end;

        table.clear(p65);
    end;

    if u20 > 0 then
        local os_clock_ret = os.clock();
        u9 = {
            connection = nil,
            connection = RunService.RenderStepped:Connect(function() -- Line: 332
                -- upvalues: os_clock_ret (copy), u20 (copy), u22 (copy), set (copy), u34 (copy), u9 (ref)
                local v66 = (os.clock() - os_clock_ret) / u20;
                local math_clamp_ret = math.clamp(v66, 0, 1);

                if math_clamp_ret >= 0.5 then
                    local v67 = u22;

                    for _, v in v67 do
                        v();
                    end;

                    table.clear(v67);
                end;

                set(math_clamp_ret);

                if math_clamp_ret >= 1 then
                    local v68 = u34;

                    for _, v in v68 do
                        v();
                    end;

                    table.clear(v68);

                    if u9 then
                        u9.connection:Disconnect();
                        u9 = nil;
                    end;
                end;
            end)
        };

        return;
    end;

    for _, v in u22 do
        v();
    end;

    table.clear(u22);
    set(1);

    for _, v in u34 do
        v();
    end;

    table.clear(u34);
end;

local DefaultLighting = game.ReplicatedStorage:FindFirstChild("DefaultLighting");

if DefaultLighting then
    for _, child in DefaultLighting:GetChildren() do
        local v69;

        if child:IsA("Atmosphere") then
            v69 = "Atmosphere";
        elseif u3[child.ClassName] then
            v69 = child.ClassName .. "|" .. child.Name;
        else
            v69 = nil;
        end;

        if v69 then
            u6[v69] = true;
        end;
    end;
end;

local u70 = true;
local LocalPlayer = game:GetService("Players").LocalPlayer;
local u71 = nil;

local function lightingFolder(p72) -- Line: 363
    if p72 then
        p72 = p72:IsA("Folder") or p72:IsA("Configuration");
    end;

    return p72;
end;

local function pick() -- Line: 366
    -- upvalues: Game (copy), LocalPlayer (copy)
    local MapLightingBase = Game:FindFirstChild("MapLightingBase");

    if LocalPlayer:GetAttribute("BloodMoonHidden") == true then
        local v73;

        if MapLightingBase then
            v73 = MapLightingBase:IsA("Folder") or MapLightingBase:IsA("Configuration");
        else
            v73 = MapLightingBase;
        end;

        if v73 then
            return MapLightingBase;
        end;
    end;

    local MapLighting = Game:FindFirstChild("MapLighting");
    local v74;

    if MapLighting then
        v74 = MapLighting:IsA("Folder") or MapLighting:IsA("Configuration");
    else
        v74 = MapLighting;
    end;

    if v74 then
        return MapLighting;
    end;

    return nil;
end;

local function refresh() -- Line: 374
    -- upvalues: pick (copy), u71 (ref), apply (copy), u70 (ref)
    local v75 = pick();

    if not v75 or v75 == u71 then
        return;
    end;

    u71 = v75;
    local Attribute = v75:GetAttribute("Fade");
    apply(v75, u70 and 0 or ((type(Attribute) ~= "number" or Attribute <= 0) and 3 or Attribute));
    u70 = false;
end;

local function changed(p76) -- Line: 385
    -- upvalues: pick (copy), u71 (ref), apply (copy), u70 (ref)
    local v77 = (p76.Name == "MapLighting" or p76.Name == "MapLightingBase") and pick();

    if v77 then
        if v77 == u71 then
            return;
        end;

        u71 = v77;
        local Attribute = v77:GetAttribute("Fade");
        apply(v77, u70 and 0 or ((type(Attribute) ~= "number" or Attribute <= 0) and 3 or Attribute));
        u70 = false;
    end;
end;

Game.ChildAdded:Connect(changed);
Game.ChildRemoved:Connect(changed);
LocalPlayer:GetAttributeChangedSignal("BloodMoonHidden"):Connect(refresh);
local v78 = pick();

if v78 and v78 ~= u71 then
    u71 = v78;
    local Attribute = v78:GetAttribute("Fade");
    apply(v78, u70 and 0 or ((type(Attribute) ~= "number" or Attribute <= 0) and 3 or Attribute));
    u70 = false;
end;

script.Destroying:Connect(function() -- Line: 394
    -- upvalues: u9 (ref), u18 (copy), u7 (ref)
    if u9 then
        u9.connection:Disconnect();
        u9 = nil;
    end;

    u18:Disconnect();
    u7 = nil;
end);