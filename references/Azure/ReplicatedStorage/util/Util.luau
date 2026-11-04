 

 

local HttpService = game:GetService("HttpService");
local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local Lighting = game:GetService("Lighting");
local Color3_fromRGB_ret = Color3.fromRGB(178, 208, 255);
local Color3_fromRGB_ret2 = Color3.fromRGB(255, 255, 255);
local Color3_fromRGB_ret3 = Color3.fromRGB(47, 47, 47);
local u1, u2, u3;

if workspace:GetAttribute("11v11") then
    u1 = 0.5;
    u2 = 0.898;
    u3 = 0;
else
    u1 = 3;
    u2 = 1;
    u3 = 0.2;
end;

workspace:GetAttributeChangedSignal("11v11"):Connect(function() -- Line: 26
    -- upvalues: u1 (ref), u2 (ref), u3 (ref)
    if workspace:GetAttribute("11v11") then
        u1 = 0.5;
        u2 = 0.898;
        u3 = 0;

        return;
    end;

    u1 = 3;
    u2 = 1;
    u3 = 0.2;
end);
local LocalPlayer = Players.LocalPlayer;
local u4;

if LocalPlayer then
    u4 = LocalPlayer:FindFirstChild("PlayerGui") or LocalPlayer:WaitForChild("PlayerGui");
else
    u4 = LocalPlayer;
end;

local u5 = require(ReplicatedStorage.util.Ray).new({
    FilterType = Enum.RaycastFilterType.Exclude,
    Ignore = { workspace.characters, workspace.gks, workspace.CF }
});
local u6 = {};

function PropertyConvert(p7, p8, p9)
    local v10 = nil;

    if p8 == "CFrame" then
        return p7.CFrame * CFrame.new(unpack(string.split(p9, ", ")));
    end;

    if p8 == "boolean" then
        return p9 == "true";
    end;

    if p8 == "Color3" then
        return Color3.new(unpack(string.split(p9, ", ")));
    end;

    if p8 == "Vector3" then
        return Vector3.new(unpack(string.split(p9, ", ")));
    end;

    if p8 == "number" then
        v10 = tonumber(p9);
    end;

    return v10;
end;

local function getLastValue(p11, p12) -- Line: 65
    local v13 = {};

    for i, _ in pairs(p11) do
        table.insert(v13, i);
    end;

    table.sort(v13);

    for i = 1, #v13 do
        if v13[i] == p12 then
            return v13[i - 1];
        end;

        local _ = i;
    end;

    return nil;
end;

local function getSortedKeys(p14) -- Line: 82
    local v15 = {};

    for i in p14 do
        table.insert(v15, i);
    end;

    return v15;
end;

function u6.DarkLighting() -- Line: 90
    -- upvalues: Lighting (copy)
    Lighting.ClockTime = 0;
    Lighting.Brightness = 3;
    Lighting.ExposureCompensation = 0.2;
    Lighting.GeographicLatitude = 0;
    Lighting.EnvironmentDiffuseScale = 1;
    Lighting.EnvironmentSpecularScale = 1;
    Lighting.Ambient = Color3.fromRGB(70, 70, 70);
    Lighting.OutdoorAmbient = Color3.fromRGB(70, 70, 70);
end;

function u6.MidDarkLighting() -- Line: 101
    -- upvalues: Lighting (copy)
    Lighting.ClockTime = 14.5;
    Lighting.Brightness = 3;
    Lighting.ExposureCompensation = 0.2;
    Lighting.GeographicLatitude = 0;
    Lighting.EnvironmentDiffuseScale = 1;
    Lighting.EnvironmentSpecularScale = 1;
    Lighting.Ambient = Color3.fromRGB(70, 70, 70);
    Lighting.OutdoorAmbient = Color3.fromRGB(70, 70, 70);
end;

function u6.MidLighting() -- Line: 112
    -- upvalues: Lighting (copy)
    Lighting.ClockTime = 14.5;
    Lighting.Brightness = 3;
    Lighting.ExposureCompensation = 1.5;
    Lighting.GeographicLatitude = 0;
    Lighting.EnvironmentDiffuseScale = 1;
    Lighting.EnvironmentSpecularScale = 1;
    Lighting.Ambient = Color3.fromRGB(70, 70, 70);
    Lighting.OutdoorAmbient = Color3.fromRGB(70, 70, 70);
end;

function u6.ReturnLighting() -- Line: 123
    -- upvalues: Lighting (copy), Color3_fromRGB_ret (copy), u1 (ref), Color3_fromRGB_ret3 (copy), Color3_fromRGB_ret2 (copy), u3 (ref), u2 (ref)
    Lighting.Atmosphere.Color = Color3_fromRGB_ret;
    Lighting.Atmosphere.Density = 0.25;
    Lighting.GeographicLatitude = 23;
    Lighting.Brightness = u1;
    Lighting.OutdoorAmbient = Color3_fromRGB_ret3;
    Lighting.Ambient = Color3_fromRGB_ret2;
    Lighting.ClockTime = 12;
    Lighting.ExposureCompensation = u3;
    Lighting.Bloom.Threshold = 1.856;
    Lighting.EnvironmentDiffuseScale = u2;
    Lighting.EnvironmentSpecularScale = 1;
end;

function u6.DetectWall(p16, p17) -- Line: 137
    -- upvalues: u5 (copy)
    local v18 = u5:fire(p16, p17, true);

    if v18 then
        return p16 + p17.Unit * v18.Distance;
    end;

    return p16 + p17;
end;

function u6.TweenTimeline(p19) -- Line: 149
    -- upvalues: TweenService (copy)
    local u20 = {};
    local v21 = {};

    for i, v in p19 do
        local v22 = v[1];
        local u23 = v[2];
        local u24 = v[3][1];
        local u25 = v[3][2];
        local u26 = v[4];
        local u27 = v22 - (p19[i - 1] and (p19[i - 1][1] or 0) or 0);
        v21[#v21 + 1] = task.delay(v22, function() -- Line: 161
            -- upvalues: TweenService (ref), u23 (copy), u27 (copy), u24 (copy), u25 (copy), u26 (copy), u20 (copy)
            local u28 = TweenService:Create(u23, TweenInfo.new(u27, u24, u25), u26);
            u20[#u20 + 1] = u28;
            u28.Completed:Once(function() -- Line: 164
                -- upvalues: u28 (copy)
                u28:Destroy();
            end);
            u28:Play();
        end);
    end;

    return v21, u20;
end;

function u6.CameraEffect(p29, p30) -- Line: 174
    local v31 = p29:Clone();

    for _, child in v31:GetChildren() do
        if child:IsA("Weld") then
            child.Part0 = p30;
        end;

        child.Parent = p30;
    end;

    return v31;
end;

function u6.OnFoundInstance(u32, u33, u34) -- Line: 185
    task.spawn(function() -- Line: 186
        -- upvalues: u32 (copy), u33 (copy), u34 (copy)
        local v35 = false;

        while true do
            task.wait(0.1);

            if u32:FindFirstChild(u33) and u32:FindFirstChild(u33):GetAttribute("Compiled") then
                break;
            end;

            if v35 then
                return;
            end;
        end;

        task.spawn(u34, u32:FindFirstChild(u33));
    end);
end;

local function runPreload(u36, u37, u38) -- Line: 198
    -- upvalues: u4 (copy)
    task.spawn(function() -- Line: 199
        -- upvalues: u37 (copy), u4 (ref), u36 (copy), u38 (copy)
        for _, child in u37:GetChildren() do
            local v39 = child:Clone();
            v39.Visible = true;
            v39.Parent = u4:WaitForChild("Preload"):WaitForChild("Frame");

            if not (v39:IsA("MeshPart") or v39:IsA("BasePart")) then
                table.insert(u36, v39);

                if u38 then
                    task.wait(0.1);
                end;
            end;
        end;
    end);
end;

function u6.Preload(u40: any, u41: boolean) -- Line: 224
    -- upvalues: u4 (copy)
    local u42 = {};
    local u43 = nil;
    u43 = {
        Destroy = function(p44) -- Line: 228, Name: Destroy
            -- upvalues: u42 (copy), u43 (ref)
            for _, v in u42 do
                v:Destroy();
            end;

            table.clear(u42);
            table.clear(u43);
        end
    };

    if typeof(u40) == "table" then
        for _, v in u40 do
            task.spawn(function() -- Line: 199
                -- upvalues: v (copy), u4 (ref), u42 (copy), u41 (copy)
                for _, child in v:GetChildren() do
                    local v45 = child:Clone();
                    v45.Visible = true;
                    v45.Parent = u4:WaitForChild("Preload"):WaitForChild("Frame");

                    if not (v45:IsA("MeshPart") or v45:IsA("BasePart")) then
                        table.insert(u42, v45);

                        if u41 then
                            task.wait(0.1);
                        end;
                    end;
                end;
            end);
        end;
    else
        task.spawn(function() -- Line: 199
            -- upvalues: u40 (copy), u4 (ref), u42 (copy), u41 (copy)
            for _, child in u40:GetChildren() do
                local v46 = child:Clone();
                v46.Visible = true;
                v46.Parent = u4:WaitForChild("Preload"):WaitForChild("Frame");

                if not (v46:IsA("MeshPart") or v46:IsA("BasePart")) then
                    table.insert(u42, v46);

                    if u41 then
                        task.wait(0.1);
                    end;
                end;
            end;
        end);
    end;

    return u43;
end;

function u6.EpilepsySafeGif(u47, p48, p49) -- Line: 249
    -- upvalues: u4 (copy), RunService (copy)
    local u50 = p48 or 24;
    local u51 = nil;
    local u52 = 0;
    local u53 = 1;
    local u54 = p49 and p49:Clone() or u47[u53]:Clone();
    u54.BackgroundColor3 = Color3.new(0, 0, 0);
    u54.Parent = u4.Preload;
    u54.Visible = true;
    u51 = RunService.RenderStepped:Connect(function(p55) -- Line: 260
        -- upvalues: u52 (ref), u50 (copy), u47 (copy), u53 (ref), u54 (copy), u51 (ref)
        if u52 > 1 / u50 then
            u52 = u52 - 1 / u50;

            if u47:FindFirstChild(u53) then
                u54.Image = u47[u53].Image;
            else
                u51:Disconnect();
                u54:Destroy();
            end;

            u53 = u53 + 1;
        end;

        u52 = u52 + p55;
    end);

    return u54;
end;

function u6.Gif(p56, p57, p58, p59) -- Line: 280
    -- upvalues: u6 (copy)
    local v60 = u6.EpilepsySafeGif(p56, p57, p58);

    if u6.isepilepsysafe() then
        v60.ImageColor3 = Color3.new(0, 0, 0);
    end;

    return v60;
end;

function u6.Weld(p61, p62, p63, p64) -- Line: 288
    local Weld = Instance.new("Weld");
    Weld.Parent = p61;
    Weld.Part0 = p62;
    Weld.Part1 = p63;

    if p64 then
        Weld.C0 = p64;
    end;

    return Weld;
end;

function u6.AttributeTween(u65) -- Line: 299
    -- upvalues: HttpService (copy), TweenService (copy), u6 (copy)
    local Attribute = u65:GetAttribute("MeshEmitter");

    if Attribute then
        local v66 = HttpService:JSONDecode(Attribute);

        for _, v in pairs(v66) do
            local v67 = v;

            for i, v2 in pairs(v) do
                local Direction = v2.Direction;
                local Style = v2.Style;
                local Property = v2.Property;
                local Time = v2.Time;
                local Value = v2.Value;
                local v68 = v67[i + 1];

                if v68 ~= nil then
                    local _ = v68.Direction;
                    local _ = v68.Style;
                    local _ = v68.Property;
                    local Time2 = v68.Time;
                    local Value2 = v68.Value;

                    local function Getval(p69) -- Line: 324
                        -- upvalues: u65 (copy), Property (copy)
                        local v70 = typeof(u65[Property]);
                        local v71 = PropertyConvert(u65:IsA("Model") and u65.PrimaryPart or u65, v70, p69);

                        if (Property == "Size" or Property == "Scale") and v70 == "Vector3" then
                            v71 = Vector3.new(v71.X, v71.Y, v71.Z);
                        end;

                        return v71;
                    end;

                    local v72 = Style == "Circ" and "Circular" or ((Style == "Expo" or Style == "Sextic") and "Exponential" or Style);

                    if v72 == "Constant" then
                        if Time > 0 then
                            task.delay(Time, function() -- Line: 345
                                -- upvalues: u65 (copy), Property (copy), Getval (copy), Value (copy)
                                u65[Property] = Getval(Value);
                            end);
                        else
                            u65[Property] = Getval(Value);
                        end;

                        task.delay(Time2, function() -- Line: 351
                            -- upvalues: u65 (copy), Property (copy), Getval (copy), Value2 (copy)
                            u65[Property] = Getval(Value2);
                        end);
                    else
                        local v73 = Enum.EasingStyle:FromName(v72);

                        if v73 == nil then
                            v73 = Enum.EasingStyle.Linear;
                            warn("MeshEmitter does not support", v72, "yet. has been redirected to Linear");
                        end;

                        local TweenInfo_new_ret = TweenInfo.new(Time2 - Time, v73, Enum.EasingDirection[Direction]);

                        if Time > 0 then
                            task.delay(Time, function() -- Line: 364
                                -- upvalues: u65 (copy), Property (copy), Getval (copy), Value (copy), TweenService (ref), TweenInfo_new_ret (copy), Value2 (copy)
                                u65[Property] = Getval(Value);
                                TweenService:Create(u65, TweenInfo_new_ret, {
                                    [Property] = Getval(Value2)
                                }):Play();
                            end);
                        else
                            u65[Property] = Getval(Value);
                            TweenService:Create(u65, TweenInfo_new_ret, {
                                [Property] = Getval(Value2)
                            }):Play();
                        end;
                    end;
                end;
            end;
        end;
    end;

    for _, child in u65:GetChildren() do
        u6.AttributeTween(child);
    end;
end;

function u6.Timeline(p74: table, p75: number?, p76: any) -- Line: 383
    for i, v in p74 do
        local v77;

        if p75 then
            v77 = i / p75;
        else
            v77 = i;
        end;

        local task_delay_ret = task.delay(v77, v);

        if p76 then
            p76:Add(task_delay_ret);
        end;
    end;
end;

function u6.CreateHighlight(p78, p79) -- Line: 393
    -- upvalues: getLastValue (copy), TweenService (copy)
    local v80 = p79[0];
    local Highlight = Instance.new("Highlight");
    Highlight.Parent = p78;
    Highlight.Adornee = p78;
    Highlight.FillColor = v80.Properties.FillColor;
    Highlight.FillTransparency = v80.Properties.FillTransparency;
    Highlight.OutlineColor = v80.Properties.OutlineColor;
    Highlight.OutlineTransparency = v80.Properties.OutlineTransparency;
    local u81 = nil;

    for i, v in p79 do
        if i ~= 0 then
            local u82 = getLastValue(p79, i);

            if u82 ~= 0 then
                task.delay(i, function() -- Line: 409
                    -- upvalues: u81 (ref), TweenService (ref), Highlight (copy), u82 (copy), i (copy), v (copy)
                    if u81 then
                        u81:Cancel();
                    end;

                    u81 = TweenService:Create(Highlight, TweenInfo.new(u82 and i - u82 or i, v.EasingStyle, v.EasingDirection), v.Properties);
                    u81:Play();
                end);
            end;
        end;
    end;

    return Highlight;
end;

function u6.EnableAll(u83, p84, p85) -- Line: 421
    if shared.allvfxcheck and shared.allvfxcheck() then
        return;
    end;

    if not u83 then
        return;
    end;

    for _, descendant in pairs(u83:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            descendant.Enabled = true;
        end;
    end;

    if p84 then
        for _, descendant in pairs(u83:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                task.delay(descendant:GetAttribute("EmitDuration"), function() -- Line: 432
                    -- upvalues: descendant (copy)
                    descendant.Enabled = false;
                end);
            end;
        end;

        return;
    end;

    task.delay(p85, function() -- Line: 438
        -- upvalues: u83 (copy)
        if not u83 then
            return;
        end;

        for _, descendant in pairs(u83:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
end;

function u6.EmitAll(p86, p87) -- Line: 449
    if shared.allvfxcheck and shared.allvfxcheck() then
        return;
    end;

    if not p86 then
        return;
    end;

    for _, descendant in pairs(p86:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            descendant:Emit(p87 or descendant:GetAttribute("EmitCount"));
        end;
    end;
end;

function u6.IsInZone(p88: userdata, p89: any, p90: number?) -- Line: 459
    if typeof(p88) == "string" then
        p88 = workspace.map.gkzone:FindFirstChild(p88);

        if not p88 then
            return false;
        end;
    end;

    if typeof(p89) == "Instance" then
        if not p89:IsA("BasePart") then
            warn("Invalid Instance input for IsInZone, got", p89.ClassName);

            return false;
        end;

        p89 = p89.Position;
    end;

    if not (p88 and (typeof(p88) ~= "Instance" or (p88:IsA("BasePart") or type(p88) == "table"))) then
        return false;
    end;

    local v91 = p88.Size * (p90 or 1) / 2;
    local v92 = p88.CFrame:PointToObjectSpace(p89);
    local v93;

    if math.abs(v92.X) <= v91.X and math.abs(v92.Y) <= v91.Y then
        v93 = math.abs(v92.Z) <= v91.Z;
    else
        v93 = false;
    end;

    return v93;
end;

function u6.blendTables(p94, p95, p96) -- Line: 484
    local v97 = p96 and ({} or p94) or p94;

    if not p96 then
        for i, v in p94 do
            v97[i] = v;
        end;
    end;

    for i, v in p95 do
        v97[i] = v;
    end;

    return v97;
end;

function u6.now() -- Line: 497
    return workspace:GetServerTimeNow();
end;

function u6.isSettingEnabled(p98: any, p99: string) -- Line: 501
    -- upvalues: LocalPlayer (copy)
    if p98 == "localplayer" then
        p98 = LocalPlayer;
    end;

    return typeof(p98) == "Instance" and (p98:FindFirstChild("setting") and (p98.setting:FindFirstChild(p99) and p98.setting[p99].Value)) and true or false;
end;

function u6.isepilepsysafe(p100) -- Line: 511
    -- upvalues: LocalPlayer (copy), u6 (copy)
    return u6.isSettingEnabled(p100 or LocalPlayer, "epilepsysafe");
end;

function u6.canshiftcolor(p101, p102) -- Line: 518
    -- upvalues: u6 (copy)
    if u6.isepilepsysafe() then
        return false;
    end;

    if not p102 then
        return false;
    end;

    local Attribute = p102:GetAttribute("ReoCopy");
    local Attribute2 = p102:GetAttribute("CustomColor");

    if Attribute then
        return true;
    end;

    if not (Attribute2 and p101) then
        return false;
    end;

    if p102 == p101.Character then
        return true;
    end;

    local setting = p101:FindFirstChild("setting");

    if setting then
        setting = setting:FindFirstChild("CustomVFXEnabled");
    end;

    if setting then
        setting = setting.Value == true;
    end;

    return setting;
end;

function u6.random(p103, p104) -- Line: 548
    return Random.new():NextNumber(p103, p104);
end;

function u6.frame_delay(p105, p106, ...) -- Line: 552
    return task.delay(p105 / 60, p106, ...);
end;

function u6.copy(p107: any, p108: table?) -- Line: 556
    -- upvalues: u6 (copy)
    if typeof(p107) ~= "table" then
        return p107;
    end;

    local v109 = p108 or {};

    if v109[p107] then
        return v109[p107];
    end;

    local v110 = {};
    v109[p107] = v110;
    local v111 = getmetatable(p107);
    setmetatable(v110, v111);

    for i, v in p107 do
        v110[u6.copy(i, v109)] = u6.copy(v, v109);
    end;

    return v110;
end;

function u6.reconcile(p112: any, p113: table, p114: table?) -- Line: 569
    -- upvalues: u6 (copy)
    if typeof(p112) ~= "table" or typeof(p113) ~= "table" then
        return p112;
    end;

    local v115 = p114 or {};

    if v115[p113] then
        return v115[p113];
    end;

    v115[p113] = p112;

    for i, v in p113 do
        if p112[i] == nil then
            p112[i] = u6.copy(v, v115);
        elseif typeof(p112[i]) == "table" and typeof(v) == "table" then
            u6.reconcile(p112[i], v, v115);
        end;
    end;

    return p112;
end;

function u6.overwrite(p116: any, p117: table, p118: table?) -- Line: 584
    -- upvalues: u6 (copy)
    if typeof(p116) ~= "table" or typeof(p117) ~= "table" then
        return p116;
    end;

    local v119 = p118 or {};

    if v119[p117] then
        return v119[p117];
    end;

    v119[p117] = p116;

    for i, v in p117 do
        if typeof(v) == "table" and typeof(p116[i]) == "table" then
            u6.overwrite(p116[i], v, v119);
        else
            p116[i] = u6.copy(v, v119);
        end;
    end;

    return p116;
end;

function u6.cleanup_any(p120) -- Line: 599
    -- upvalues: u6 (copy)
    if typeof(p120) == "table" then
        for _, v in p120 do
            u6.cleanup_any(v);
        end;

        return;
    end;

    if typeof(p120) == "Instance" then
        p120:Destroy();

        return;
    end;

    if typeof(p120) == "function" then
        p120();

        return;
    end;

    if typeof(p120) == "RBXScriptConnection" then
        p120:Disconnect();

        return;
    end;

    if typeof(p120) == "thread" and coroutine.status(p120) == "suspended" then
        task.cancel(p120);
    end;
end;

function u6.flowCancel(u121: any, p122: any, u123: table) -- Line: 615
    -- upvalues: u6 (copy)
    if u121.is_kat then
        u121 = u121.trove;
    end;

    if typeof(p122) == "Instance" then
        u121:AttachToInstance(p122);
        u121:Connect(p122.Changed, function(p124) -- Line: 621
            -- upvalues: u6 (ref), u123 (copy), u121 (ref)
            if p124 then
                u6.cleanup_any(u123);
                u121:Destroy();
            end;
        end);
    end;
end;

function u6.remove_nils(p125) -- Line: 633
    local v126 = 0;

    for i in pairs(p125) do
        if type(i) == "number" and v126 < i then
            v126 = i;
        end;
    end;

    local v127 = 1;

    for i = 1, v126 do
        local v128 = p125[i];
        local v129;

        if v128 == nil then
            v129 = i;
        else
            p125[v127] = v128;
            v127 = v127 + 1;
            v129 = i;
        end;
    end;

    for i = v127, v126 do
        p125[i] = nil;
        local _ = i;
    end;

    return p125;
end;

function u6.flatten_cframe(p130) -- Line: 657
    return CFrame.new(p130.Position) * CFrame.Angles(0, select(2, p130:ToEulerAnglesYXZ()), 0);
end;

function u6.isDebugTest() -- Line: 661
    -- upvalues: ReplicatedStorage (copy)
    if ReplicatedStorage:FindFirstChild("debugTest") then
        return ReplicatedStorage.debugTest.Value;
    end;

    return false;
end;

return u6;