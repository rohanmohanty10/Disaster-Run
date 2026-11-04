 

 

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local HttpService = game:GetService("HttpService");
local Lighting = game:GetService("Lighting");
local SoundService = game:GetService("SoundService");
local Debris = game:GetService("Debris");
local LocalPlayer = Players.LocalPlayer;
local ChickenOrHero = game.ReplicatedStorage:WaitForChild("ChickenOrHero");
local Session = ChickenOrHero:WaitForChild("Game"):WaitForChild("Session");
local CreatorVisibility = require(ChickenOrHero:WaitForChild("Presentation"):WaitForChild("CreatorVisibility"));
local LocalHide = require(ChickenOrHero.Presentation:WaitForChild("LocalHide"));
local u1 = SoundService:WaitForChild("GameAudio"):WaitForChild("10_Football", 10);
local LazySound = require(game:GetService("ReplicatedFirst"):WaitForChild("LazySound"));
local Folder = Instance.new("Folder");
Folder.Name = "FootballSequenceAudio";
Folder.Parent = SoundService;

local function sequenceSound(p2, p3, p4, p5) -- Line: 36
    -- upvalues: Folder (copy)
    local Sound = Instance.new("Sound");
    Sound.Name = p2;
    Sound.SoundId = "rbxassetid://" .. p3;
    Sound.Volume = p4;
    Sound.Looped = p5 == true;
    Sound:SetAttribute("Volume", p4);
    Sound.Parent = Folder;

    return Sound;
end;

local Sound = Instance.new("Sound");
Sound.Name = "Sting";
Sound.SoundId = "rbxassetid://" .. 128362753120295;
Sound.Volume = 0.8;
Sound.Looped = false;
Sound:SetAttribute("Volume", 0.8);
Sound.Parent = Folder;
local Sound2 = Instance.new("Sound");
Sound2.Name = "Song";
Sound2.SoundId = "rbxassetid://" .. 105536563312044;
Sound2.Volume = 0.45;
Sound2.Looped = true;
Sound2:SetAttribute("Volume", 0.45);
Sound2.Parent = Folder;
local u6 = {};
local v7 = { 135253349004273, 74366241162938 };
local u8 = {};

for i, v in { 82217872102044, 72037374064818, 107586207514159 } do
    local Sound3 = Instance.new("Sound");
    Sound3.Name = "Cheer" .. i;
    Sound3.SoundId = "rbxassetid://" .. v;
    Sound3.Volume = 0.8;
    Sound3.Looped = false;
    Sound3:SetAttribute("Volume", 0.8);
    Sound3.Parent = Folder;
    u6[i] = Sound3;
end;

for i, v in v7 do
    local Sound3 = Instance.new("Sound");
    Sound3.Name = "Groan" .. i;
    Sound3.SoundId = "rbxassetid://" .. v;
    Sound3.Volume = 0.8;
    Sound3.Looped = false;
    Sound3:SetAttribute("Volume", 0.8);
    Sound3.Parent = Folder;
    u8[i] = Sound3;
end;

local u9 = nil;
local u10 = nil;

local function musicLevel() -- Line: 59
    -- upvalues: LocalPlayer (copy)
    if LocalPlayer:GetAttribute("MusicMuted") == true then
        return 0;
    end;

    local Attribute = LocalPlayer:GetAttribute("MusicVolume");

    return type(Attribute) == "number" and (Attribute == Attribute and math.clamp(Attribute, 0, 1)) or 1;
end;

local u11 = false;

local function holdMusic(p12) -- Line: 68
    -- upvalues: u11 (ref), LocalPlayer (copy)
    if p12 == u11 then
        return;
    end;

    u11 = p12;
    LocalPlayer:SetAttribute("MusicPaused", p12 or nil);
end;

local function fadeSong(p13, p14) -- Line: 75
    -- upvalues: u10 (ref), TweenService (copy), Sound2 (copy)
    if u10 then
        u10:Cancel();
    end;

    u10 = TweenService:Create(Sound2, TweenInfo.new(p14), {
        Volume = p13
    });
    u10:Play();

    return u10;
end;

local u15 = {};

local function pick(p16, p17) -- Line: 86
    -- upvalues: u15 (copy), TweenService (copy)
    local u18 = p16[math.random(1, #p16)];
    local u19 = u15[u18] or {
        play = 0
    };
    u15[u18] = u19;
    u19.play = u19.play + 1;
    local play = u19.play;

    if u19.fade then
        u19.fade:Cancel();
        u19.fade = nil;
    end;

    u18.Volume = u18:GetAttribute("Volume") or u18.Volume;
    u18.TimePosition = 0;
    u18:Play();
    task.delay(p17, function() -- Line: 99
        -- upvalues: u19 (copy), play (copy), u18 (copy), TweenService (ref)
        if u19.play ~= play or not u18.IsPlaying then
            return;
        end;

        local v20 = TweenService:Create(u18, TweenInfo.new(0.8), {
            Volume = 0
        });
        u19.fade = v20;
        v20.Completed:Once(function(p21) -- Line: 105
            -- upvalues: u19 (ref), play (ref), u18 (ref)
            if p21 == Enum.PlaybackState.Completed and u19.play == play then
                u19.fade = nil;
                u18:Stop();
                u18.Volume = u18:GetAttribute("Volume") or u18.Volume;
            end;
        end);
        v20:Play();
    end);
end;

local function playSting(p22) -- Line: 116
    -- upvalues: LazySound (copy), Sound (copy)
    LazySound.arm(Sound);
    Sound.TimePosition = p22 or 0;
    Sound:Play();
end;

local function startSequence() -- Line: 121
    -- upvalues: u9 (ref), LazySound (copy), Sound2 (copy), fadeSong (copy), LocalPlayer (copy), u11 (ref)
    u9 = {
        scored = false
    };
    LazySound.arm(Sound2);
    Sound2.TimePosition = 0;
    Sound2.Volume = 0;
    Sound2:Play();
    local Attribute = Sound2:GetAttribute("Volume");
    local v23;

    if LocalPlayer:GetAttribute("MusicMuted") == true then
        v23 = 0;
    else
        local Attribute2 = LocalPlayer:GetAttribute("MusicVolume");
        v23 = type(Attribute2) == "number" and (Attribute2 == Attribute2 and math.clamp(Attribute2, 0, 1)) or 1;
    end;

    fadeSong(Attribute * v23, 0.8);

    if u11 == true then
        return;
    end;

    u11 = true;
    LocalPlayer:SetAttribute("MusicPaused", true);
end;

local function cheer() -- Line: 130
    -- upvalues: u9 (ref), pick (copy), u6 (copy)
    if u9 then
        u9.scored = true;
    end;

    pick(u6, 3);
end;

local function stopSong() -- Line: 136
    -- upvalues: u11 (ref), LocalPlayer (copy), fadeSong (copy), u9 (ref), Sound2 (copy)
    if u11 ~= false then
        u11 = false;
        LocalPlayer:SetAttribute("MusicPaused", nil);
    end;

    fadeSong(0, 1.5).Completed:Once(function(p24) -- Line: 138
        -- upvalues: u9 (ref), Sound2 (ref)
        if p24 == Enum.PlaybackState.Completed and not u9 then
            Sound2:Stop();
        end;
    end);
end;

local function endSequence() -- Line: 145
    -- upvalues: u9 (ref), Session (copy), u11 (ref), LocalPlayer (copy), fadeSong (copy), Sound2 (copy), pick (copy), u8 (copy)
    local u25 = u9;

    if not u25 then
        return;
    end;

    task.delay(0.6, function() -- Line: 151
        -- upvalues: u9 (ref), u25 (copy), Session (ref), u11 (ref), LocalPlayer (ref), fadeSong (ref), Sound2 (ref), pick (ref), u8 (ref)
        if u9 ~= u25 or (Session:GetAttribute("FootballField") ~= nil or Session:GetAttribute("FootballRun") ~= nil) then
            return;
        end;

        u9 = nil;

        if u11 ~= false then
            u11 = false;
            LocalPlayer:SetAttribute("MusicPaused", nil);
        end;

        fadeSong(0, 1.5).Completed:Once(function(p26) -- Line: 138
            -- upvalues: u9 (ref), Sound2 (ref)
            if p26 == Enum.PlaybackState.Completed and not u9 then
                Sound2:Stop();
            end;
        end);

        if not u25.scored then
            pick(u8, 2.5);
        end;
    end);
end;

local Font_new_ret = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.ExtraBold);
local Color3_new_ret = Color3.new(1, 1, 1);
local Color3_fromRGB_ret = Color3.fromRGB(255, 202, 58);
local u27 = 116.5;
local u28 = 82;
local u29 = {};

local function on(p30, p31) -- Line: 178
    -- upvalues: u29 (copy)
    table.insert(u29, p30:Connect(p31));
end;

local function decode(p32) -- Line: 181
    -- upvalues: Session (copy), HttpService (copy)
    local Attribute = Session:GetAttribute(p32);

    if type(Attribute) ~= "string" or Attribute == "" then
        return nil;
    end;

    local success, result = pcall(HttpService.JSONDecode, HttpService, Attribute);

    if not (success and (type(result) == "table" and result)) then
        result = nil;
    end;

    return result;
end;

local FootballShots = require(ChickenOrHero:WaitForChild("Presentation"):WaitForChild("FootballShots"));
local smoother = FootballShots.smoother;
local orbit = FootballShots.orbit;
local glide = FootballShots.glide;
local u33 = nil;
local u34 = nil;
local u35 = nil;

local function piece(p36, p37, p38, p39) -- Line: 196
    local Part = Instance.new("Part");
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.CastShadow = false;
    Part.Locked = true;
    Part.Size = p38;
    Part.CFrame = p37;
    Part.Color = p39;
    Part.Material = Enum.Material.SmoothPlastic;
    Part.Transparency = 1;
    Part.Parent = p36;

    return Part;
end;

local function lettering(p40, p41, p42, p43, p44, p45, p46) -- Line: 213
    -- upvalues: Color3_new_ret (copy), Font_new_ret (copy)
    local v47 = p43:Cross(Vector3.new(0, 1, 0));
    local v48 = p41 * CFrame.fromMatrix(p42, -p43, Vector3.new(0, 1, 0), -v47);
    local Vector3_new_ret = Vector3.new(p45, 0.02, p44);
    local Part = Instance.new("Part");
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.CastShadow = false;
    Part.Locked = true;
    Part.Size = Vector3_new_ret;
    Part.CFrame = v48;
    Part.Color = Color3_new_ret;
    Part.Material = Enum.Material.SmoothPlastic;
    Part.Transparency = 1;
    Part.Parent = p40;
    local SurfaceGui = Instance.new("SurfaceGui");
    SurfaceGui.Face = Enum.NormalId.Top;
    SurfaceGui.SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud;
    SurfaceGui.PixelsPerStud = 16;
    SurfaceGui.LightInfluence = 0.6;
    SurfaceGui:SetAttribute("CreatorCaptureExempt", true);
    SurfaceGui.Parent = Part;
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Size = UDim2.fromScale(1, 1);
    TextLabel.BackgroundTransparency = 1;
    TextLabel.FontFace = Font_new_ret;
    TextLabel.Text = p46;
    TextLabel.TextScaled = true;
    TextLabel.TextColor3 = Color3_new_ret;
    TextLabel.TextTransparency = 1;
    TextLabel.Rotation = 0;
    TextLabel.Parent = SurfaceGui;

    return TextLabel;
end;

local function clearField() -- Line: 235
    -- upvalues: u33 (ref), TweenService (copy), Debris (copy)
    local v49 = u33;
    u33 = nil;

    if not v49 then
        return;
    end;

    for _, v in v49.items do
        TweenService:Create(v[1], TweenInfo.new(0.5), {
            [v[2]] = 1
        }):Play();
    end;

    Debris:AddItem(v49.folder, 0.6);
end;

local function gridiron(p50, p51, p52, p53, p54, p55, p56, p57) -- Line: 249
    -- upvalues: u27 (ref), u28 (ref), Color3_new_ret (copy), lettering (copy)
    if not p56 then
        for i = 1, 19 do
            local v58 = -u27 + i * 5 * 2.33;
            local v59 = p51 * CFrame.new(0, 0, v58);
            local Vector3_new_ret = Vector3.new(u28 * 2, 0.02, i % 2 == 0 and 0.6 or 0.35);
            local Part = Instance.new("Part");
            Part.Anchored = true;
            Part.CanCollide = false;
            Part.CanQuery = false;
            Part.CanTouch = false;
            Part.CastShadow = false;
            Part.Locked = true;
            Part.Size = Vector3_new_ret;
            Part.CFrame = v59;
            Part.Color = Color3_new_ret;
            Part.Material = Enum.Material.SmoothPlastic;
            Part.Transparency = 1;
            Part.Parent = p50;
            p52(Part, "Transparency", 0.05, v58);
            local _ = i;
        end;

        for _, v in { -1, 1 } do
            local v60 = p51 * CFrame.new(v * u28, 0, 0);
            local Vector3_new_ret = Vector3.new(0.7, 0.02, u27 * 2);
            local Part = Instance.new("Part");
            Part.Anchored = true;
            Part.CanCollide = false;
            Part.CanQuery = false;
            Part.CanTouch = false;
            Part.CastShadow = false;
            Part.Locked = true;
            Part.Size = Vector3_new_ret;
            Part.CFrame = v60;
            Part.Color = Color3_new_ret;
            Part.Material = Enum.Material.SmoothPlastic;
            Part.Transparency = 1;
            Part.Parent = p50;
            p52(Part, "Transparency", 0.05, 0);
        end;
    end;

    local v61 = math.min(p53[3] / 2, p54) - u27;

    if v61 > 2 then
        for _, v in { -1, 1 } do
            local v62 = v * (u27 + v61 / 2);
            local v63 = v < 0 and Color3.fromRGB(196, 46, 52) or Color3.fromRGB(44, 92, 196);
            local v64 = p51 * CFrame.new(0, -0.01 - p55 + p57, v62);
            local Vector3_new_ret = Vector3.new(u28 * 2, 0.02, v61);
            local Part = Instance.new("Part");
            Part.Anchored = true;
            Part.CanCollide = false;
            Part.CanQuery = false;
            Part.CanTouch = false;
            Part.CastShadow = false;
            Part.Locked = true;
            Part.Size = Vector3_new_ret;
            Part.CFrame = v64;
            Part.Color = v63;
            Part.Material = Enum.Material.SmoothPlastic;
            Part.Transparency = 1;
            Part.Parent = p50;
            p52(Part, "Transparency", 0.4, u27);
            p52(lettering(p50, p51, Vector3.new(0, 0.005 - p55 + p57, v62), Vector3.new(0, 0, -v), u28 * 1.3, math.min(v61 * 0.7, 14), "VALLEY RUN"), "TextTransparency", 0.1, u27);
        end;
    end;

    if p56 then
        return;
    end;

    for i = 2, 18, 2 do
        local v65 = -u27 + i * 5 * 2.33;
        local v66 = i <= 10 and i * 5 or (20 - i) * 5;
        local _ = i;

        for _, v in { -1, 1 } do
            p52(lettering(p50, p51, Vector3.new(v * (u28 - 13), 0.005, v65), Vector3.new(v, 0, 0), 13, 7, (tostring(v66))), "TextTransparency", 0.05, v65);
        end;
    end;

    p52(lettering(p50, p51, Vector3.new(0, 0.005, 0), Vector3.new(0, 0, 1), 18, 18, utf8.char(127944)), "TextTransparency", 0, 0);
end;

local u67 = u27 * 2 / 105;

local function pitch(u68, u69, u70, p71, p72) -- Line: 295
    -- upvalues: Color3_new_ret (copy), u28 (ref), u27 (ref), u67 (ref), lettering (copy), ChickenOrHero (copy)
    local function strip(p73, p74, p75, p76) -- Line: 297
        -- upvalues: u70 (copy), u68 (copy), u69 (copy), Color3_new_ret (ref)
        local v77 = u69 * CFrame.new(p73, 0, p74);
        local Vector3_new_ret = Vector3.new(p75, 0.02, p76);
        local Part = Instance.new("Part");
        Part.Anchored = true;
        Part.CanCollide = false;
        Part.CanQuery = false;
        Part.CanTouch = false;
        Part.CastShadow = false;
        Part.Locked = true;
        Part.Size = Vector3_new_ret;
        Part.CFrame = v77;
        Part.Color = Color3_new_ret;
        Part.Material = Enum.Material.SmoothPlastic;
        Part.Transparency = 1;
        Part.Parent = u68;
        u70(Part, "Transparency", 0.05, p74);
    end;

    local function arc(p78, p79, p80, p81, p82, p83) -- Line: 301
        -- upvalues: u69 (copy), u70 (copy), u68 (copy), Color3_new_ret (ref)
        local v84 = (p82 - p81) / p83;
        local v85 = math.abs(v84) / 2;
        local v86 = 2 * p80 * math.sin(v85) + 0.12;

        for i = 0, p83 - 1 do
            local v87 = p81 + (i + 0.5) * v84;
            local v88 = p78 + p80 * math.sin(v87);
            local v89 = p79 + p80 * math.cos(v87);
            local v90 = u69 * CFrame.new(v88, 0, v89) * CFrame.Angles(0, v87, 0);
            local Vector3_new_ret = Vector3.new(v86, 0.02, 0.6);
            local Part = Instance.new("Part");
            Part.Anchored = true;
            Part.CanCollide = false;
            Part.CanQuery = false;
            Part.CanTouch = false;
            Part.CastShadow = false;
            Part.Locked = true;
            Part.Size = Vector3_new_ret;
            Part.CFrame = v90;
            Part.Color = Color3_new_ret;
            Part.Material = Enum.Material.SmoothPlastic;
            Part.Transparency = 1;
            Part.Parent = u68;
            u70(Part, "Transparency", 0.05, v89);
            local _ = i;
        end;
    end;

    if not p72 then
        local v91 = u69 * CFrame.new(0, 0, 0);
        local Vector3_new_ret = Vector3.new(u28 * 2, 0.02, 0.6);
        local Part = Instance.new("Part");
        Part.Anchored = true;
        Part.CanCollide = false;
        Part.CanQuery = false;
        Part.CanTouch = false;
        Part.CastShadow = false;
        Part.Locked = true;
        Part.Size = Vector3_new_ret;
        Part.CFrame = v91;
        Part.Color = Color3_new_ret;
        Part.Material = Enum.Material.SmoothPlastic;
        Part.Transparency = 1;
        Part.Parent = u68;
        u70(Part, "Transparency", 0.05, 0);

        for _, v in { -1, 1 } do
            local v92 = u69 * CFrame.new(v * u28, 0, 0);
            local Vector3_new_ret2 = Vector3.new(0.6, 0.02, u27 * 2);
            local Part2 = Instance.new("Part");
            Part2.Anchored = true;
            Part2.CanCollide = false;
            Part2.CanQuery = false;
            Part2.CanTouch = false;
            Part2.CastShadow = false;
            Part2.Locked = true;
            Part2.Size = Vector3_new_ret2;
            Part2.CFrame = v92;
            Part2.Color = Color3_new_ret;
            Part2.Material = Enum.Material.SmoothPlastic;
            Part2.Transparency = 1;
            Part2.Parent = u68;
            u70(Part2, "Transparency", 0.05, 0);
        end;

        arc(0, 0, u67 * 9.15, 0, 6.283185307179586, 40);
        local v93 = u69 * CFrame.new(0, 0, 0);
        local Part2 = Instance.new("Part");
        Part2.Anchored = true;
        Part2.CanCollide = false;
        Part2.CanQuery = false;
        Part2.CanTouch = false;
        Part2.CastShadow = false;
        Part2.Locked = true;
        Part2.Size = Vector3.new(1.2, 0.02, 1.2);
        Part2.CFrame = v93;
        Part2.Color = Color3_new_ret;
        Part2.Material = Enum.Material.SmoothPlastic;
        Part2.Transparency = 1;
        Part2.Parent = u68;
        u70(Part2, "Transparency", 0.05, 0);
        u70(lettering(u68, u69, Vector3.new(0, 0.005, 0), Vector3.new(0, 0, 1), 12, 12, utf8.char(9917)), "TextTransparency", 0, 0);
    end;

    local v94 = u67 * 16.5;
    local v95 = u67 * 40.32;
    local v96 = u67 * 5.5;
    local v97 = u67 * 18.32;
    local v98 = u67 * 11;
    local v99 = u67 * 9.15;
    local SoccerNet = ChickenOrHero:WaitForChild("Presentation"):FindFirstChild("SoccerNet");

    for _, v in { -1, 1 } do
        local v100;

        if p72 then
            v100 = v;
        else
            local v101 = v * (u27 - v94);
            local v102 = u69 * CFrame.new(0, 0, v101);
            local Vector3_new_ret = Vector3.new(v95, 0.02, 0.6);
            local Part = Instance.new("Part");
            Part.Anchored = true;
            Part.CanCollide = false;
            Part.CanQuery = false;
            Part.CanTouch = false;
            Part.CastShadow = false;
            Part.Locked = true;
            Part.Size = Vector3_new_ret;
            Part.CFrame = v102;
            Part.Color = Color3_new_ret;
            Part.Material = Enum.Material.SmoothPlastic;
            Part.Transparency = 1;
            Part.Parent = u68;
            u70(Part, "Transparency", 0.05, v101);
            local v103 = v * (u27 - v96);
            local v104 = u69 * CFrame.new(0, 0, v103);
            local Vector3_new_ret2 = Vector3.new(v97, 0.02, 0.6);
            local Part2 = Instance.new("Part");
            Part2.Anchored = true;
            Part2.CanCollide = false;
            Part2.CanQuery = false;
            Part2.CanTouch = false;
            Part2.CastShadow = false;
            Part2.Locked = true;
            Part2.Size = Vector3_new_ret2;
            Part2.CFrame = v104;
            Part2.Color = Color3_new_ret;
            Part2.Material = Enum.Material.SmoothPlastic;
            Part2.Transparency = 1;
            Part2.Parent = u68;
            u70(Part2, "Transparency", 0.05, v103);
            v100 = v;

            for _, v2 in { -1, 1 } do
                local v105 = v100 * (u27 - v94 / 2);
                local v106 = u69 * CFrame.new(v2 * v95 / 2, 0, v105);
                local Vector3_new_ret3 = Vector3.new(0.6, 0.02, v94);
                local Part3 = Instance.new("Part");
                Part3.Anchored = true;
                Part3.CanCollide = false;
                Part3.CanQuery = false;
                Part3.CanTouch = false;
                Part3.CastShadow = false;
                Part3.Locked = true;
                Part3.Size = Vector3_new_ret3;
                Part3.CFrame = v106;
                Part3.Color = Color3_new_ret;
                Part3.Material = Enum.Material.SmoothPlastic;
                Part3.Transparency = 1;
                Part3.Parent = u68;
                u70(Part3, "Transparency", 0.05, v105);
                local v107 = v100 * (u27 - v96 / 2);
                local v108 = u69 * CFrame.new(v2 * v97 / 2, 0, v107);
                local Vector3_new_ret4 = Vector3.new(0.6, 0.02, v96);
                local Part4 = Instance.new("Part");
                Part4.Anchored = true;
                Part4.CanCollide = false;
                Part4.CanQuery = false;
                Part4.CanTouch = false;
                Part4.CastShadow = false;
                Part4.Locked = true;
                Part4.Size = Vector3_new_ret4;
                Part4.CFrame = v108;
                Part4.Color = Color3_new_ret;
                Part4.Material = Enum.Material.SmoothPlastic;
                Part4.Transparency = 1;
                Part4.Parent = u68;
                u70(Part4, "Transparency", 0.05, v107);
            end;

            local v109 = v100 * (u27 - v98);
            local v110 = u69 * CFrame.new(0, 0, v109);
            local Part3 = Instance.new("Part");
            Part3.Anchored = true;
            Part3.CanCollide = false;
            Part3.CanQuery = false;
            Part3.CanTouch = false;
            Part3.CastShadow = false;
            Part3.Locked = true;
            Part3.Size = Vector3.new(1, 0.02, 1);
            Part3.CFrame = v110;
            Part3.Color = Color3_new_ret;
            Part3.Material = Enum.Material.SmoothPlastic;
            Part3.Transparency = 1;
            Part3.Parent = u68;
            u70(Part3, "Transparency", 0.05, v109);
            local math_clamp_ret = math.clamp((v94 - v98) / v99, -1, 1);
            local math_acos_ret = math.acos(math_clamp_ret);
            local v111 = v100 > 0 and 3.141592653589793 or 0;
            arc(0, v100 * (u27 - v98), v99, v111 - math_acos_ret, v111 + math_acos_ret, 10);

            for _, v2 in { -1, 1 } do
                local math_atan2_ret = math.atan2(-v2, 0);
                local v112 = (math.atan2(0, -v100) - math_atan2_ret + 3.141592653589793) % 6.283185307179586 - 3.141592653589793;
                arc(v2 * u28, v100 * u27, u67, math_atan2_ret, math_atan2_ret + v112, 4);
            end;
        end;

        if SoccerNet then
            local v113 = SoccerNet:Clone();
            v113.Anchored = true;
            v113.CanCollide = false;
            v113.CanQuery = false;
            v113.CanTouch = false;
            v113.CFrame = u69 * CFrame.new(0, v113.Size.Y / 2 - 0.07 - p71, v100 * (u27 + v113.Size.Z / 2 - 0.25)) * CFrame.Angles(0, v100 > 0 and 3.141592653589793 or 0, 0);
            v113.Transparency = 1;
            v113.Parent = u68;
            u70(v113, "Transparency", SoccerNet.Transparency, u27);
        end;
    end;
end;

local function paintEnds(p114, p115, p116, p117) -- Line: 365
    -- upvalues: ChickenOrHero (copy), u27 (ref), lettering (copy)
    local v118;

    if p115.style == "Futbol" then
        v118 = ChickenOrHero:WaitForChild("Presentation"):FindFirstChild("SoccerNet");
    else
        v118 = false;
    end;

    for _, v in p115.ends do
        if type(v) == "table" and (type(v.cf) == "table" and #v.cf == 12) then
            local v119 = CFrame.new(table.unpack(v.cf)) * CFrame.new(0, 0.07 + p117, 0);
            local zone = v.zone;

            if type(zone) == "table" and (type(zone.cf) == "table" and (#zone.cf == 12 and type(zone.size) == "table")) then
                local v120 = v119:PointToObjectSpace(CFrame.new(table.unpack(zone.cf)).Position);
                local v121 = v119 * CFrame.new(v120.X, -0.01 - p117, v120.Z);
                local v122;

                if v.side == "A" then
                    v122 = Color3.fromRGB(196, 46, 52);
                else
                    v122 = Color3.fromRGB(44, 92, 196);
                end;

                local Vector3_new_ret = Vector3.new(zone.size[1], 0.02, zone.size[2]);
                local Part = Instance.new("Part");
                Part.Anchored = true;
                Part.CanCollide = false;
                Part.CanQuery = false;
                Part.CanTouch = false;
                Part.CastShadow = false;
                Part.Locked = true;
                Part.Size = Vector3_new_ret;
                Part.CFrame = v121;
                Part.Color = v122;
                Part.Material = Enum.Material.SmoothPlastic;
                Part.Transparency = 1;
                Part.Parent = p114;
                p116(Part, "Transparency", 0.4, u27);
                p116(lettering(p114, v121, Vector3.new(0, 0.015, 0), Vector3.new(0, 0, -1), zone.size[1] * 0.75, math.min(zone.size[2] * 0.7, 14), "VALLEY RUN"), "TextTransparency", 0.1, u27);
            end;

            if v118 then
                local v123 = v118:Clone();
                v123.Anchored = true;
                v123.CanCollide = false;
                v123.CanQuery = false;
                v123.CanTouch = false;
                v123.CFrame = v119 * CFrame.new(0, v123.Size.Y / 2 - 0.07 - p117, -(v123.Size.Z / 2 - 0.25));
                v123.Transparency = 1;
                v123.Parent = p114;
                p116(v123, "Transparency", v118.Transparency, u27);
            end;
        end;
    end;
end;

local function buildField(p124) -- Line: 394
    -- upvalues: u27 (ref), u28 (ref), u67 (ref), paintEnds (copy), pitch (copy), gridiron (copy), u33 (ref), TweenService (copy)
    local cf = p124.cf;
    local size = p124.size;

    if type(cf) ~= "table" or (#cf ~= 12 or (type(size) ~= "table" or #size ~= 3)) then
        return;
    end;

    local v125 = tonumber(p124.lift) or 0;
    local math_clamp_ret = math.clamp(v125, 0, 2);
    local v126 = tonumber(p124.endBack) or 140;
    local v127 = tonumber(p124.zoneLift) or 0;
    local math_clamp_ret2 = math.clamp(v127, 0, 2);
    local v128 = p124.bare == true;
    local v129 = tonumber(p124.goal) or 116.5;
    u27 = math.clamp(v129, 20, 1000);
    local v130 = tonumber(p124.halfWidth) or 82;
    u28 = math.clamp(v130, 10, 500);
    u67 = u27 * 2 / 105;
    local v131 = CFrame.new(table.unpack(cf)) * CFrame.new(0, size[2] / 2 + 0.07 + math_clamp_ret, 0);
    local Folder2 = Instance.new("Folder");
    Folder2.Name = "FootballFieldLocal";
    local u132 = {};

    local function add(p133, p134, p135, p136) -- Line: 412
        -- upvalues: u132 (copy), u27 (ref)
        local v137 = {
            p133,
            p134,
            p135,
            math.abs(p136) / u27 * 0.7
        };
        table.insert(u132, v137);
    end;

    if type(p124.ends) == "table" then
        paintEnds(Folder2, p124, add, math_clamp_ret);
    elseif p124.style == "Futbol" then
        pitch(Folder2, v131, add, math_clamp_ret, v128);
    else
        gridiron(Folder2, v131, add, size, v126, math_clamp_ret, v128, math_clamp_ret2);
    end;

    Folder2.Parent = workspace;
    u33 = {
        folder = Folder2,
        items = u132
    };

    for _, v in u132 do
        TweenService:Create(v[1], TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, v[4]), {
            [v[2]] = v[3]
        }):Play();
    end;
end;

local function refreshField() -- Line: 433
    -- upvalues: Session (copy), u34 (ref), clearField (copy), HttpService (copy), buildField (copy), u9 (ref), u11 (ref), LocalPlayer (copy), fadeSong (copy), Sound2 (copy), pick (copy), u8 (copy), u35 (ref)
    local Attribute = Session:GetAttribute("FootballField");

    if Attribute == u34 then
        return;
    end;

    u34 = Attribute;
    clearField();
    local Attribute2 = Session:GetAttribute("FootballField");
    local v138;

    if type(Attribute2) == "string" and Attribute2 ~= "" then
        local v139;
        v139, v138 = pcall(HttpService.JSONDecode, HttpService, Attribute2);

        if not (v139 and (type(v138) == "table" and v138)) then
            v138 = nil;
        end;
    else
        v138 = nil;
    end;

    if v138 then
        buildField(v138);

        return;
    end;

    local u140 = u9;

    if u140 then
        task.delay(0.6, function() -- Line: 151
            -- upvalues: u9 (ref), u140 (copy), Session (ref), u11 (ref), LocalPlayer (ref), fadeSong (ref), Sound2 (ref), pick (ref), u8 (ref)
            if u9 ~= u140 or (Session:GetAttribute("FootballField") ~= nil or Session:GetAttribute("FootballRun") ~= nil) then
                return;
            end;

            u9 = nil;

            if u11 ~= false then
                u11 = false;
                LocalPlayer:SetAttribute("MusicPaused", nil);
            end;

            fadeSong(0, 1.5).Completed:Once(function(p141) -- Line: 138
                -- upvalues: u9 (ref), Sound2 (ref)
                if p141 == Enum.PlaybackState.Completed and not u9 then
                    Sound2:Stop();
                end;
            end);

            if not u140.scored then
                pick(u8, 2.5);
            end;
        end);
    end;

    if u35 then
        u35();
    end;
end;

local AttributeChangedSignal = Session:GetAttributeChangedSignal("FootballField");
table.insert(u29, AttributeChangedSignal:Connect(refreshField));
refreshField();
local AttributeChangedSignal2 = Session:GetAttributeChangedSignal("FootballRun");
table.insert(u29, AttributeChangedSignal2:Connect(function() -- Line: 454
    -- upvalues: Session (copy), u9 (ref), u11 (ref), LocalPlayer (copy), fadeSong (copy), Sound2 (copy), pick (copy), u8 (copy)
    if Session:GetAttribute("FootballRun") == nil then
        local u142 = u9;

        if not u142 then
            return;
        end;

        task.delay(0.6, function() -- Line: 151
            -- upvalues: u9 (ref), u142 (copy), Session (ref), u11 (ref), LocalPlayer (ref), fadeSong (ref), Sound2 (ref), pick (ref), u8 (ref)
            if u9 ~= u142 or (Session:GetAttribute("FootballField") ~= nil or Session:GetAttribute("FootballRun") ~= nil) then
                return;
            end;

            u9 = nil;

            if u11 ~= false then
                u11 = false;
                LocalPlayer:SetAttribute("MusicPaused", nil);
            end;

            fadeSong(0, 1.5).Completed:Once(function(p143) -- Line: 138
                -- upvalues: u9 (ref), Sound2 (ref)
                if p143 == Enum.PlaybackState.Completed and not u9 then
                    Sound2:Stop();
                end;
            end);

            if not u142.scored then
                pick(u8, 2.5);
            end;
        end);
    end;
end));

for _, v in { "MusicMuted", "MusicVolume" } do
    local AttributeChangedSignal3 = LocalPlayer:GetAttributeChangedSignal(v);
    table.insert(u29, AttributeChangedSignal3:Connect(function() -- Line: 461
        -- upvalues: u9 (ref), fadeSong (copy), Sound2 (copy), LocalPlayer (copy)
        if u9 then
            local Attribute = Sound2:GetAttribute("Volume");
            local v144;

            if LocalPlayer:GetAttribute("MusicMuted") == true then
                v144 = 0;
            else
                local Attribute2 = LocalPlayer:GetAttribute("MusicVolume");
                v144 = type(Attribute2) == "number" and (Attribute2 == Attribute2 and math.clamp(Attribute2, 0, 1)) or 1;
            end;

            fadeSong(Attribute * v144, 0.2);
        end;
    end));
end;

local Color3_fromRGB_ret2 = Color3.fromRGB(255, 247, 236);
local u145 = {
    Catch = true,
    Touchdown = true,
    Juggle = true,
    Goal = true
};
local RaycastParams_new_ret = RaycastParams.new();
RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
RaycastParams_new_ret.IgnoreWater = true;
local RaycastParams_new_ret2 = RaycastParams.new();
RaycastParams_new_ret2.FilterType = Enum.RaycastFilterType.Exclude;
RaycastParams_new_ret2.IgnoreWater = true;
local u146 = nil;

local function showKeep(u147) -- Line: 484
    -- upvalues: Players (copy)
    return function(p148) -- Line: 485
        -- upvalues: u147 (copy), Players (ref)
        if p148 == u147 then
            return true;
        end;

        local v149 = p148:IsA("Model") and Players:GetPlayerFromCharacter(p148);

        return (v149 or p148):GetAttribute("GameRole") == "Catcher";
    end;
end;

local function cue(p150, p151, p152) -- Line: 493
    -- upvalues: u1 (copy)
    local v153 = u1 and u1:FindFirstChild(p151);

    if not v153 then
        return nil;
    end;

    local v154 = v153:Clone();
    v154.Volume = p152 or v153.Volume;
    v154.Parent = p150.gui;
    v154:Play();

    return v154;
end;

local function textLabel(p155, p156, p157, p158, p159, p160) -- Line: 504
    -- upvalues: Font_new_ret (copy)
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Name = p156;
    TextLabel.AnchorPoint = Vector2.new(0.5, 0.5);
    TextLabel.Position = UDim2.fromScale(0.5, p157);
    TextLabel.Size = UDim2.fromScale(0.8, p158);
    TextLabel.BackgroundTransparency = 1;
    TextLabel.FontFace = Font_new_ret;
    TextLabel.TextColor3 = p159;
    TextLabel.TextScaled = true;
    TextLabel.TextTransparency = 1;
    TextLabel.Text = "";
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Thickness = 3;
    UIStroke.Transparency = 1;
    UIStroke.Parent = TextLabel;
    local UITextSizeConstraint = Instance.new("UITextSizeConstraint");
    UITextSizeConstraint.MaxTextSize = p160;
    UITextSizeConstraint.Parent = TextLabel;
    Instance.new("UIScale").Parent = TextLabel;
    TextLabel.Parent = p155;

    return TextLabel;
end;

local function pop(p161, p162) -- Line: 529
    -- upvalues: TweenService (copy)
    p161.Text = p162;
    p161.UIScale.Scale = 1.35;
    TweenService:Create(p161, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
        TextTransparency = 0
    }):Play();
    TweenService:Create(p161.UIStroke, TweenInfo.new(0.2), {
        Transparency = 0.2
    }):Play();
    TweenService:Create(p161.UIScale, TweenInfo.new(0.35, Enum.EasingStyle.Back), {
        Scale = 1
    }):Play();
end;

local function fadeOut(p163) -- Line: 536
    -- upvalues: TweenService (copy)
    TweenService:Create(p163, TweenInfo.new(0.35), {
        TextTransparency = 1
    }):Play();
    TweenService:Create(p163.UIStroke, TweenInfo.new(0.35), {
        Transparency = 1
    }):Play();
end;

local function flash(p164, p165) -- Line: 540
    -- upvalues: TweenService (copy)
    p164.flash.BackgroundTransparency = 1 - p165;
    TweenService:Create(p164.flash, TweenInfo.new(0.25), {
        BackgroundTransparency = 1
    }):Play();
end;

local function confetti(p166) -- Line: 544
    -- upvalues: Color3_fromRGB_ret (copy), Color3_new_ret (copy), Debris (copy)
    local Part = Instance.new("Part");
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.Transparency = 1;
    Part.Size = Vector3.new(1, 1, 1);
    Part.CFrame = CFrame.new(p166 + Vector3.new(0, 2, 0));
    Part.Parent = workspace;

    for _, v in {
        Color3_fromRGB_ret,
        Color3.fromRGB(196, 46, 52),
        Color3.fromRGB(44, 92, 196),
        Color3_new_ret
    } do
        local ParticleEmitter = Instance.new("ParticleEmitter");
        ParticleEmitter.Color = ColorSequence.new(v);
        ParticleEmitter.Size = NumberSequence.new(0.35, 0.2);
        ParticleEmitter.Lifetime = NumberRange.new(1.6, 2.4);
        ParticleEmitter.Speed = NumberRange.new(18, 30);
        ParticleEmitter.SpreadAngle = Vector2.new(55, 55);
        ParticleEmitter.Acceleration = Vector3.new(0, -26, 0);
        ParticleEmitter.Drag = 1.5;
        ParticleEmitter.Rotation = NumberRange.new(0, 360);
        ParticleEmitter.RotSpeed = NumberRange.new(-300, 300);
        ParticleEmitter.Rate = 0;
        ParticleEmitter.EmissionDirection = Enum.NormalId.Top;
        ParticleEmitter.Texture = "rbxasset://textures/particles/sparkles_main.dds";
        ParticleEmitter.Parent = Part;
        ParticleEmitter:Emit(45);
    end;

    Debris:AddItem(Part, 3);
end;

local function cover(p167, p168, p169, p170) -- Line: 574
    local Frame = Instance.new("Frame");
    Frame.Name = p168;
    Frame.AnchorPoint = Vector2.new(0.5, 0.5);
    Frame.Position = UDim2.fromScale(0.5, 0.5);
    Frame.Size = UDim2.fromScale(1.5, 1.5);
    Frame.BackgroundColor3 = p169;
    Frame.BackgroundTransparency = p170;
    Frame.BorderSizePixel = 0;
    Frame.Parent = p167;

    return Frame;
end;

local function bar(p171, p172, p173) -- Line: 587
    local Frame = Instance.new("Frame");
    Frame.Name = p172;
    Frame.AnchorPoint = Vector2.new(0.5, p173 and 1 or 0);
    Frame.Position = UDim2.fromScale(0.5, p173 and 0 or 1);
    Frame.Size = UDim2.new(1.5, 0, 0.11, 1200);
    Frame.BackgroundColor3 = Color3.new(0, 0, 0);
    Frame.BorderSizePixel = 0;
    Frame.Parent = p171;

    return Frame;
end;

local function letterbox(p174, p175) -- Line: 598
    p174.bars = p175;
    p174.top.Position = UDim2.fromScale(0.5, 0.11 * p175);
    p174.bottom.Position = UDim2.fromScale(0.5, 1 - 0.11 * p175);
end;

local function cameraZoom(p176) -- Line: 604
    -- upvalues: LocalPlayer (copy)
    local PlayerScripts = LocalPlayer:FindFirstChild("PlayerScripts");

    if PlayerScripts then
        PlayerScripts = PlayerScripts:FindFirstChild("PlayerModule");
    end;

    local v177, v178;

    if PlayerScripts then
        v177, v178 = pcall(function() -- Line: 609
            -- upvalues: PlayerScripts (copy)
            return require(PlayerScripts):GetCameras().activeCameraController:GetCameraToSubjectDistance();
        end);
    else
        v177 = false;
        v178 = nil;
    end;

    if not (v177 and (type(v178) == "number" and v178 == v178)) then
        v178 = (p176.CFrame.Position - p176.Focus.Position).Magnitude;
    end;

    local CameraMinZoomDistance = LocalPlayer.CameraMinZoomDistance;
    local math_max_ret = math.max(CameraMinZoomDistance, LocalPlayer.CameraMaxZoomDistance);

    return math.clamp(v178, CameraMinZoomDistance, math_max_ret);
end;

local function home(p179) -- Line: 621
    -- upvalues: RaycastParams_new_ret (copy)
    local homeSubject = p179.homeSubject;
    local v180 = homeSubject and (homeSubject.Parent and homeSubject:IsA("Humanoid")) and homeSubject.RootPart;
    local v181 = v180 and v180.Position + v180.CFrame:VectorToWorldSpace(Vector3.new(0, 1.5, 0) + homeSubject.CameraOffset) or homeSubject and (homeSubject.Parent and homeSubject:IsA("BasePart")) and homeSubject.Position;

    if not v181 then
        return nil;
    end;

    local v182 = -p179.homeLook * p179.zoom;
    RaycastParams_new_ret.FilterDescendantsInstances = p179.ignore;

    for i = 1, 4 do
        local v183 = workspace:Raycast(v181, v182, RaycastParams_new_ret);

        if not v183 then
            break;
        end;

        if v183.Instance.CanCollide and v183.Instance.Transparency < 0.25 then
            v182 = v182.Unit * math.max(0.5, v183.Distance - 0.3);
            break;
        end;

        RaycastParams_new_ret:AddToFilter(v183.Instance);
        local _ = i;
    end;

    local v184 = v181 + v182;

    return CFrame.lookAt(v184, v184 + p179.homeLook), v181;
end;

local function unblocked(p185, p186, p187, p188, p189) -- Line: 649
    -- upvalues: RaycastParams_new_ret2 (copy)
    local v190 = p186.Position - p187;
    local Magnitude = v190.Magnitude;
    local v191 = 0;

    if Magnitude >= 0.6 then
        RaycastParams_new_ret2.FilterDescendantsInstances = p185.occluders;

        for i = 1, 4 do
            local v192 = workspace:Raycast(p187, v190, RaycastParams_new_ret2);

            if not v192 then
                break;
            end;

            if v192.Instance.CanCollide and (v192.Instance.Transparency < 0.25 and v192.Instance.LocalTransparencyModifier < 1) then
                v191 = Magnitude - math.max(0.5, v192.Distance - 0.4);
                break;
            end;

            RaycastParams_new_ret2:AddToFilter(v192.Instance);
            local _ = i;
        end;
    end;

    local pull = p185.pull;

    if pull ~= nil and (pull >= v191 or p189) then
        v191 = pull + (v191 - pull) * math.min(1, p188 * 6);
    end;

    p185.pull = v191;

    if v191 <= 0.01 or Magnitude < 0.6 then
        return p186;
    end;

    return p186 - v190.Unit * math.min(v191, Magnitude - 0.5);
end;

local DaggerDive = require(ChickenOrHero:WaitForChild("Animation"):WaitForChild("AnimationConfig")).PublishedIds.DaggerDive;
local u193 = nil;

u35 = function() -- Line: 680, Name: clearDefenders
    -- upvalues: u193 (ref)
    local v194 = u193;
    u193 = nil;

    for _, v in v194 and v194.models or {} do
        v:Destroy();
    end;
end;

local function defenderModel(p195) -- Line: 687
    -- upvalues: Players (copy)
    local v196;

    if p195 then
        local success, result = pcall(Players.GetHumanoidDescriptionFromUserId, Players, p195);
        v196 = success and result and result or nil;
    else
        v196 = nil;
    end;

    local v197 = v196 or Instance.new("HumanoidDescription");
    local success, result = pcall(Players.CreateHumanoidModelFromDescription, Players, v197, Enum.HumanoidRigType.R6);
    v197:Destroy();

    if not (success and result) then
        return nil;
    end;

    result.Name = "Defender";
    result.PrimaryPart = result:FindFirstChild("HumanoidRootPart") or result.PrimaryPart;

    for _, descendant in result:GetDescendants() do
        if descendant:IsA("BasePart") then
            descendant.Anchored = descendant.Name == "HumanoidRootPart";
            descendant.CanCollide = false;
            descendant.CanQuery = false;
            descendant.CanTouch = false;
        end;
    end;

    local v198 = result:FindFirstChildOfClass("Humanoid");

    if v198 then
        v198.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None;

        if not v198:FindFirstChildOfClass("Animator") then
            Instance.new("Animator").Parent = v198;
        end;
    end;

    return result;
end;

local function prepareDefenders(u199) -- Line: 719
    -- upvalues: u193 (ref), u35 (ref), Players (copy), FootballShots (copy), defenderModel (copy)
    if u193 and u193.userId == u199 then
        return;
    end;

    u35();
    local u200 = {
        userId = u199,
        models = {}
    };
    u193 = u200;
    task.spawn(function() -- Line: 726
        -- upvalues: Players (ref), u199 (copy), FootballShots (ref), defenderModel (ref), u193 (ref), u200 (copy)
        local v201 = {};
        local success, result = pcall(Players.GetFriendsAsync, Players, u199);
        local v202, v203;

        if success and result then
            v202, v203 = pcall(result.GetCurrentPage, result);
        else
            v202 = false;
            v203 = nil;
        end;

        for _, v in v202 and v203 and v203 or {} do
            if #v201 >= #FootballShots.Dodge.Cuts then
                break;
            end;

            table.insert(v201, v.Id);
        end;

        for i = 1, #FootballShots.Dodge.Cuts do
            local v204 = defenderModel(v201[i]);

            if u193 ~= u200 then
                if v204 then
                    v204:Destroy();
                end;

                return;
            end;

            u200.models[i] = v204;
            local _ = i;
        end;
    end);
end;

local function whip(p205) -- Line: 752
    return p205 <= 0 and 0 or p205 / 0.09 * math.exp(1 - p205 / 0.09);
end;

local function runShot(p206, p207, p208, p209) -- Line: 757
    -- upvalues: FootballShots (copy), smoother (copy)
    local run = p206.run;
    local forward = run.forward;
    local v210 = -9.8 * forward + 5 * run.right + Vector3.new(0, 3.2, 0);
    local v211 = 0;
    local v212 = 0;

    for i, v in FootballShots.Dodge.Cuts do
        local v213 = FootballShots.Dodge.Lanes[i + 1] - FootballShots.Dodge.Lanes[i];
        local v214 = p207 - v * FootballShots.Dodge.Run + FootballShots.Dodge.Dash * 0.5;
        local v215 = v214 <= 0 and 0 or v214 / 0.09 * math.exp(1 - v214 / 0.09);
        v211 = v211 + (v213 > 0 and -1 or 1) * 0.38 * v215;
        v212 = math.max(v212, v215);
    end;

    local v216 = p208 + CFrame.Angles(0, v211, 0):VectorToWorldSpace(v210);

    if run.cam then
        v216 = run.cam:Lerp(v216, 1 - math.exp(-p209 * 14));
    end;

    run.cam = v216;
    local v217 = 1 - smoother((p207 - (run.ends - 0.5)) / 0.5);

    return CFrame.lookAt(run.cam, p208 + forward * 6 * v217 + Vector3.new(0, 1.2, 0)), 56 + 8 * v217 + v212 * 6;
end;

local function placeDefenders(p218, p219) -- Line: 776
    -- upvalues: u193 (ref), FootballShots (copy)
    local run = p218.run;
    local v220 = u193;

    if not v220 or v220.userId ~= p218.show.userId then
        return;
    end;

    local specs = run.specs;

    if not specs then
        specs = FootballShots.dodgeDefenders(run.x0);
        run.specs = specs;
        run.placed = {};
    end;

    for i, v in specs do
        local v221 = v220.models[i];

        if not (run.placed[i] or (not v221 or v.diveAt <= p219)) then
            run.placed[i] = true;

            if not run.folder then
                run.folder = Instance.new("Folder");
                run.folder.Name = "FootballDefenders";
                run.folder.Parent = workspace;
            end;

            local RaycastParams_new_ret3 = RaycastParams.new();
            RaycastParams_new_ret3.FilterType = Enum.RaycastFilterType.Exclude;
            RaycastParams_new_ret3.FilterDescendantsInstances = { run.folder, p218.root.Parent };
            local v222 = run.frame:PointToWorldSpace(v.position);
            local v223 = workspace:Raycast(Vector3.new(v222.X, p218.root.Position.Y + 20, v222.Z), Vector3.new(0, -60, 0), RaycastParams_new_ret3);
            local v224;

            if v223 then
                v224 = v223.Position.Y;
            else
                v224 = p218.root.Position.Y - 3;
            end;

            local Vector3_new_ret = Vector3.new(v222.X, v224 + 3, v222.Z);
            local CFrame_lookAt_ret = CFrame.lookAt(Vector3_new_ret, Vector3_new_ret + run.frame:VectorToWorldSpace(Vector3.new(0, 0, 1)));
            v221:PivotTo(CFrame_lookAt_ret);
            v221.Parent = run.folder;
            table.insert(run.entries, {
                model = v221,
                base = CFrame_lookAt_ret,
                diveAt = v.diveAt
            });
        end;
    end;
end;

local function moveDefenders(p225, p226) -- Line: 811
    -- upvalues: smoother (copy), DaggerDive (copy)
    for _, v in p225.run.entries do
        local v227 = smoother((p226 - v.diveAt) / 0.35);

        if v.diveAt <= p226 and not v.track then
            local v228 = v.model:FindFirstChildOfClass("Humanoid");

            if v228 then
                v228 = v228:FindFirstChildOfClass("Animator");
            end;

            if v228 then
                local Animation = Instance.new("Animation");
                Animation.AnimationId = DaggerDive;
                local success, result = pcall(v228.LoadAnimation, v228, Animation);
                Animation:Destroy();

                if success then
                    result.Priority = Enum.AnimationPriority.Action3;
                    result.Looped = false;
                    result:Play(0.05, 1, 1.2);
                    task.delay(0.5, function() -- Line: 827
                        -- upvalues: result (copy)
                        if result.IsPlaying then
                            result:AdjustSpeed(0);
                        end;
                    end);
                    v.track = result;
                end;
            end;

            v.track = v.track or true;
        end;

        if v227 > 0 and v.model.Parent then
            v.model:PivotTo(v.base * CFrame.new(0, -0.4 * v227, -3 * v227));
        end;
    end;
end;

local function kickShot(p229, p230, p231, p232) -- Line: 846
    -- upvalues: smoother (copy)
    local kick = p229.kick;
    local root = p229.root;
    local v233;

    if root.Parent then
        v233 = root.CFrame.LookVector * Vector3.new(1, 0, 1);
    else
        v233 = p229.forward;
    end;

    local v234;

    if v233.Magnitude > 0.01 then
        v234 = v233.Unit;
    else
        v234 = p229.forward;
    end;

    local Unit = v234:Cross(Vector3.new(0, 1, 0)).Unit;
    local ball = kick.ball;

    if not (ball and ball.Parent) then
        local v235 = root.Parent and root.Parent:FindFirstChild("EquippedDagger");
        local v236;

        if v235 then
            v236 = v235:GetAttribute("RootPart");
        else
            v236 = v235;
        end;

        if v235 and type(v236) == "string" then
            ball = v235:FindFirstChild(v236) or nil;
        else
            ball = nil;
        end;

        kick.ball = ball;
    end;

    local v237 = smoother(p230 / math.max(0.1, kick.at + 0.4));
    local v238 = p231 - v234 * (9 - 1.5 * v237) + Unit * 3 + Vector3.new(0, 1, 0) * (2.8 - 0.4 * v237);
    local v239 = p231 + v234 * 16 + Vector3.new(0, 1.2, 0);
    local v240;

    if ball == nil or kick.at > p230 then
        v240 = false;
    else
        v240 = p230 < kick.ends - 0.1;
    end;

    if v240 and (ball.Position - p231).Magnitude > 2.5 then
        kick.flying = true;
    end;

    if kick.flying then
        if v240 then
            kick.last = ball.Position;
        end;

        v239 = kick.last or v239;
        v238 = v239 - v234 * 11 + Unit * 4 + Vector3.new(0, 3.5, 0);
    end;

    if kick.cam then
        v238 = kick.cam:Lerp(v238, 1 - math.exp(-p232 * (kick.flying and 5 or 12)));
    end;

    kick.cam = v238;

    if kick.look then
        v239 = kick.look:Lerp(v239, 1 - math.exp(-p232 * 9));
    end;

    kick.look = v239;

    return CFrame.lookAt(kick.cam, kick.look), 55 - 6 * v237, kick.look;
end;

local function stop() -- Line: 877
    -- upvalues: u146 (ref), RunService (copy), LocalPlayer (copy), SoundService (copy), TweenService (copy), Debris (copy), fadeOut (copy)
    local v241 = u146;

    if not v241 then
        return;
    end;

    u146 = nil;
    RunService:UnbindFromRenderStep("CoHFootballShow");

    for _, v in v241.connections do
        v:Disconnect();
    end;

    if v241.hide then
        v241.hide:restore();
        v241.hide = nil;
    end;

    if v241.run and v241.run.folder then
        for _, v in v241.run.entries do
            if typeof(v.track) == "Instance" then
                v.track:Stop(0);
                v.track:Destroy();
            end;

            v.model.Parent = nil;
        end;

        v241.run.folder:Destroy();
    end;

    local workspace_CurrentCamera = workspace.CurrentCamera;

    if workspace_CurrentCamera then
        workspace_CurrentCamera.FieldOfView = v241.fov;

        if v241.spectating and LocalPlayer:GetAttribute("Spectating") then
            workspace_CurrentCamera.CameraType = v241.cameraType;
            workspace_CurrentCamera.CameraSubject = v241.subject;
        else
            workspace_CurrentCamera.CameraType = v241.cameraType == Enum.CameraType.Scriptable and Enum.CameraType.Custom or v241.cameraType;
            local v242 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid");
            workspace_CurrentCamera.CameraSubject = v242 or v241.subject;
        end;
    end;

    if v241.visibility then
        v241.visibility:destroy();
    end;

    for _, v in v241.effects do
        v:Destroy();
    end;

    for _, child in v241.gui:GetChildren() do
        if child:IsA("Sound") and child.IsPlaying then
            child.Parent = SoundService;
            TweenService:Create(child, TweenInfo.new(0.7), {
                Volume = 0
            }):Play();
            Debris:AddItem(child, 0.75);
        end;
    end;

    v241.fade.BackgroundTransparency = 1;

    if v241.bars > 0.01 then
        local TweenInfo_new_ret = TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.In);
        TweenService:Create(v241.top, TweenInfo_new_ret, {
            Position = UDim2.fromScale(0.5, 0)
        }):Play();
        TweenService:Create(v241.bottom, TweenInfo_new_ret, {
            Position = UDim2.fromScale(0.5, 1)
        }):Play();
        fadeOut(v241.eyebrow);
        fadeOut(v241.title);
        fadeOut(v241.subtitle);
        Debris:AddItem(v241.gui, 0.45);
    else
        v241.gui:Destroy();
    end;

    LocalPlayer:SetAttribute("FootballCutsceneActive", nil);
end;

local function start(u243) -- Line: 946
    -- upvalues: stop (copy), LocalPlayer (copy), u145 (copy), Session (copy), HttpService (copy), Players (copy), u146 (ref), ChickenOrHero (copy), bar (copy), cover (copy), Color3_new_ret (copy), cameraZoom (copy), LocalHide (copy), textLabel (copy), Color3_fromRGB_ret (copy), TweenService (copy), LazySound (copy), Sound (copy), startSequence (copy), CreatorVisibility (copy), Lighting (copy), u1 (copy), FootballShots (copy), RunService (copy), pop (copy), u9 (ref), pick (copy), u6 (copy), confetti (copy), fadeOut (copy), placeDefenders (copy), moveDefenders (copy), runShot (copy), kickShot (copy), smoother (copy), orbit (copy), home (copy), glide (copy), unblocked (copy), Color3_fromRGB_ret2 (copy)
    stop();

    if LocalPlayer:GetAttribute("InMatch") ~= true and LocalPlayer:GetAttribute("Spectating") ~= true or LocalPlayer:GetAttribute("ScreenPresentationActive") == true then
        return;
    end;

    if not u145[u243.kind] then
        return;
    end;

    local v244 = os.clock() + 1;

    while LocalPlayer:GetAttribute("ChoiceSpotlightActive") == true and os.clock() < v244 do
        task.wait(0.05);
    end;

    local Attribute = Session:GetAttribute("FootballShow");
    local v245;

    if type(Attribute) == "string" and Attribute ~= "" then
        local v246;
        v246, v245 = pcall(HttpService.JSONDecode, HttpService, Attribute);

        if not (v246 and (type(v245) == "table" and v245)) then
            v245 = nil;
        end;
    else
        v245 = nil;
    end;

    local PlayerByUserId = Players:GetPlayerByUserId(u243.userId);
    local u247;

    if PlayerByUserId then
        u247 = PlayerByUserId.Character;
    else
        u247 = PlayerByUserId;
    end;

    local v248;

    if u247 then
        v248 = u247:FindFirstChild("HumanoidRootPart");
    else
        v248 = u247;
    end;

    local workspace_CurrentCamera = workspace.CurrentCamera;
    local ServerTimeNow = workspace:GetServerTimeNow();

    if u146 or not (v245 and (v245.version == u243.version and (v248 and (workspace_CurrentCamera and (type(u243.startedAt) == "number" and (type(u243.endsAt) == "number" and u243.endsAt - 1.6 >= ServerTimeNow)))))) then
        return;
    end;

    local u249 = u243.kind == "Catch" and true or u243.kind == "Juggle";
    local u250 = u243.kind == "Juggle" and true or u243.kind == "Goal";
    local v251 = PlayerByUserId == LocalPlayer;
    local v252 = u243.endsAt - u243.startedAt;
    local v253 = v248.CFrame.LookVector * Vector3.new(1, 0, 1);
    local v254 = v253.Magnitude > 0.01 and v253.Unit or Vector3.new(0, 0, 1);
    local LookVector = workspace_CurrentCamera.CFrame.LookVector;

    if v251 and u249 then
        local math_clamp_ret = math.clamp(LookVector.Y, -1, 1);
        local math_asin_ret = math.asin(math_clamp_ret);
        local math_clamp_ret2 = math.clamp(math_asin_ret, -0.6981317007977318, -0.10471975511965978);
        LookVector = v254 * math.cos(math_clamp_ret2) + Vector3.new(0, 1, 0) * math.sin(math_clamp_ret2);
    end;

    local v255 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid");
    local FootballShow = require(ChickenOrHero.Presentation:WaitForChild("CutsceneScreen")).new("FootballShow", 1001);
    FootballShow:SetAttribute("CreatorCaptureExempt", true);
    FootballShow:SetAttribute("SelfManagedText", true);
    local math_max_ret = math.max(0, ServerTimeNow - u243.startedAt);
    local throwAt = u243.throwAt;
    local catchAt = u243.catchAt;

    if u250 then
        throwAt = u243.juggleAt;
        catchAt = u243.loopAt;
    end;

    local v256 = type(throwAt) == "number" and (throwAt - u243.startedAt or 1.2) or 1.2;
    local u257 = {
        version = u243.version,
        show = u243,
        gui = FootballShow,
        top = bar(FootballShow, "Top", true),
        bottom = bar(FootballShow, "Bottom", false),
        flash = cover(FootballShow, "Flash", Color3_new_ret, 1),
        fade = cover(FootballShow, "Fade", Color3.new(0, 0, 0), v251 and 1 or 0),
        bars = 0,
        weight = -1,
        root = v248,
        origin = v248.Position,
        forward = v254,
        right = v254:Cross(Vector3.new(0, 1, 0)).Unit,
        duration = v252,
        throw = v256,
        catch = type(catchAt) == "number" and catchAt - u243.startedAt or v256 + 0.67,
        spike = type(u243.spikeAt) == "number" and (u243.spikeAt - u243.startedAt or 0.7) or 0.7,
        back = v252 - (u249 and 1.4 or 1.25),
        homeAt = v252 - 0.2,
        glide = v251,
        introStart = math_max_ret,
        introEnd = math.max(math_max_ret + 0.35, u249 and v256 and v256 or 0.7),
        startCF = workspace_CurrentCamera.CFrame,
        cameraType = workspace_CurrentCamera.CameraType,
        subject = workspace_CurrentCamera.CameraSubject,
        homeSubject = v255 or workspace_CurrentCamera.CameraSubject
    };
    local v258;

    if LocalPlayer:GetAttribute("Spectating") == true then
        v258 = LocalPlayer:GetAttribute("InMatch") ~= true;
    else
        v258 = false;
    end;

    u257.spectating = v258;
    u257.homeLook = LookVector;
    u257.zoom = cameraZoom(workspace_CurrentCamera);
    u257.ignore = { LocalPlayer.Character };
    u257.occluders = {};
    u257.fov = workspace_CurrentCamera.FieldOfView;
    u257.effects = {};
    u257.connections = {};
    u257.fired = {};
    u257.shakeUntil = 0;

    for _, v in { LocalPlayer.Character, v248.Parent } do
        table.insert(u257.occluders, v);
    end;

    if u243.kind == "Goal" and (type(u243.kickAt) == "number" and type(u243.celebrateAt) == "number") then
        u257.kick = {
            at = u243.kickAt - u243.startedAt,
            ends = (tonumber(u243.kickEndsAt) or u243.celebrateAt) - u243.startedAt,
            celebrate = u243.celebrateAt - u243.startedAt
        };
    end;

    local v259;

    if u243.kind == "Touchdown" and type(u243.run) == "table" then
        v259 = u243.run;
    else
        v259 = false;
    end;

    if v259 and (type(v259.endsAt) == "number" and (type(v259.frame) == "table" and #v259.frame == 12)) then
        local CFrame_new_ret = CFrame.new(table.unpack(v259.frame));
        local v260 = CFrame_new_ret:VectorToWorldSpace(Vector3.new(0, 0, -1));
        u257.run = {
            ends = v259.endsAt - u243.startedAt,
            touchdown = (tonumber(v259.touchdownAt) or v259.endsAt) - u243.startedAt,
            frame = CFrame_new_ret,
            x0 = tonumber(v259.x0) or 0,
            forward = v260,
            right = v260:Cross(Vector3.new(0, 1, 0)).Unit,
            entries = {}
        };
        u257.hide = LocalHide.new(function(p261) -- Line: 485
            -- upvalues: u247 (copy), Players (ref)
            if p261 == u247 then
                return true;
            end;

            local v262 = p261:IsA("Model") and Players:GetPlayerFromCharacter(p261);

            return (v262 or p261):GetAttribute("GameRole") == "Catcher";
        end);
        u257.hide:sweep();
        u257.sweptAt = os.clock();
    end;

    u257.eyebrow = textLabel(FootballShow, "Eyebrow", 0.67, 0.045, Color3_fromRGB_ret, 30);
    u257.title = textLabel(FootballShow, "Title", 0.75, 0.1, u249 and Color3_new_ret or Color3_fromRGB_ret, 84);
    u257.subtitle = textLabel(FootballShow, "Subtitle", 0.83, 0.04, Color3_new_ret, 26);
    FootballShow.Parent = LocalPlayer:WaitForChild("PlayerGui");

    if not v251 then
        TweenService:Create(u257.fade, TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            BackgroundTransparency = 1
        }):Play();
    end;

    u146 = u257;
    LocalPlayer:SetAttribute("FootballCutsceneActive", true);

    if u249 then
        u257.hide = LocalHide.new(function(p263) -- Line: 485
            -- upvalues: u247 (copy), Players (ref)
            if p263 == u247 then
                return true;
            end;

            local v264 = p263:IsA("Model") and Players:GetPlayerFromCharacter(p263);

            return (v264 or p263):GetAttribute("GameRole") == "Catcher";
        end);
        u257.hide:sweep();
        u257.sweptAt = os.clock();
        task.delay(math.max(0, u243.endsAt - ServerTimeNow) + 2, function() -- Line: 1093
            -- upvalues: u257 (copy)
            if u257.hide then
                u257.hide:restore();
                u257.hide = nil;
            end;
        end);
    end;

    local v265 = u243.kind == "Juggle" and 1.3 or (u243.kind == "Catch" and 0.8 or 0);
    LazySound.arm(Sound);
    Sound.TimePosition = v265 or 0;
    Sound:Play();

    if u249 then
        startSequence();
    end;

    workspace_CurrentCamera.CameraType = Enum.CameraType.Scriptable;

    if LocalPlayer:GetAttribute("CreatorUIHidden") ~= true then
        u257.visibility = CreatorVisibility.new(LocalPlayer);
        u257.visibility:setHidden(true);
    end;

    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.Name = "FootballShowGrade";
    ColorCorrectionEffect.Parent = Lighting;
    local DepthOfFieldEffect = Instance.new("DepthOfFieldEffect");
    DepthOfFieldEffect.Name = "FootballShowFocus";
    DepthOfFieldEffect.FarIntensity = 0;
    DepthOfFieldEffect.NearIntensity = 0;
    DepthOfFieldEffect.InFocusRadius = 9;
    DepthOfFieldEffect.FocusDistance = 12;
    DepthOfFieldEffect.Parent = Lighting;
    u257.effects = { ColorCorrectionEffect, DepthOfFieldEffect };
    local v266 = u1 and u1:FindFirstChild("CrowdBed");
    local v267;

    if v266 then
        v267 = v266:Clone();
        v267.Volume = 0;
        v267.Parent = u257.gui;
        v267:Play();
    else
        v267 = nil;
    end;

    if v267 then
        TweenService:Create(v267, TweenInfo.new(1.2), {
            Volume = u1.CrowdBed.Volume
        }):Play();
    end;

    if u243.kind == "Touchdown" and not u257.run then
        local v268 = u1 and u1:FindFirstChild("TouchdownCelebration");

        if v268 then
            local v269 = v268:Clone();
            v269.Volume = v268.Volume;
            v269.Parent = u257.gui;
            v269:Play();
        end;
    end;

    local connections = u257.connections;
    local AttributeChangedSignal3 = LocalPlayer:GetAttributeChangedSignal("InMatch");
    table.insert(connections, AttributeChangedSignal3:Connect(function() -- Line: 1134
        -- upvalues: LocalPlayer (ref), stop (ref)
        if LocalPlayer:GetAttribute("InMatch") ~= true and LocalPlayer:GetAttribute("Spectating") ~= true then
            stop();
        end;
    end));
    local connections2 = u257.connections;
    local AttributeChangedSignal4 = LocalPlayer:GetAttributeChangedSignal("Spectating");
    table.insert(connections2, AttributeChangedSignal4:Connect(function() -- Line: 1142
        -- upvalues: LocalPlayer (ref), stop (ref)
        if LocalPlayer:GetAttribute("InMatch") ~= true and LocalPlayer:GetAttribute("Spectating") ~= true then
            stop();
        end;
    end));
    local string_upper_ret = string.upper(PlayerByUserId.DisplayName);
    local u270 = u250 and "MATCH DAY" or "GAME DAY";
    local u271;

    if u250 then
        u271 = u249 and FootballShots.juggle or FootballShots.goal;
    else
        u271 = u249 and FootballShots.catch or FootballShots.touchdown;
    end;

    local function once(p272, p273, p274, p275) -- Line: 1151
        -- upvalues: u257 (copy)
        if not u257.fired[p272] and p274 <= p273 then
            u257.fired[p272] = true;
            p275();
        end;
    end;

    RunService:BindToRenderStep("CoHFootballShow", Enum.RenderPriority.Camera.Value + 10, function(p276) -- Line: 1157
        -- upvalues: u146 (ref), u257 (copy), workspace_CurrentCamera (copy), u243 (copy), stop (ref), u249 (copy), u1 (ref), pop (ref), u270 (copy), TweenService (ref), string_upper_ret (copy), u9 (ref), pick (ref), u6 (ref), u250 (copy), confetti (ref), fadeOut (ref), placeDefenders (ref), moveDefenders (ref), runShot (ref), u271 (copy), kickShot (ref), smoother (ref), orbit (ref), home (ref), glide (ref), unblocked (ref), ColorCorrectionEffect (copy), Color3_new_ret (ref), Color3_fromRGB_ret2 (ref), DepthOfFieldEffect (copy)
        if u146 ~= u257 then
            return;
        end;

        local CFrame2 = workspace_CurrentCamera.CFrame;
        local Position = workspace_CurrentCamera.Focus.Position;
        local v277 = workspace:GetServerTimeNow() - u243.startedAt;

        if u257.duration <= v277 then
            stop();

            return;
        end;

        if u257.hide and os.clock() - u257.sweptAt > 0.3 then
            u257.sweptAt = os.clock();
            u257.hide:sweep();
        end;

        if u249 then
            local function _() -- Line: 1173
                -- upvalues: u257 (ref), u1 (ref)
                local v278 = u1 and u1:FindFirstChild("Whistle");

                if not v278 then
                    return;
                end;

                local v279 = v278:Clone();
                v279.Volume = v278.Volume;
                v279.Parent = u257.gui;
                v279:Play();
            end;

            if not u257.fired.whistle and v277 >= 0.05 then
                u257.fired.whistle = true;
                local v280 = u257;
                local v281 = u1 and u1:FindFirstChild("Whistle");

                if v281 then
                    local v282 = v281:Clone();
                    v282.Volume = v281.Volume;
                    v282.Parent = v280.gui;
                    v282:Play();
                end;
            end;

            local function _() -- Line: 1176
                -- upvalues: pop (ref), u257 (ref), u270 (ref)
                pop(u257.eyebrow, u270);
            end;

            if not u257.fired.eyebrow and v277 >= 0.3 then
                u257.fired.eyebrow = true;
                pop(u257.eyebrow, u270);
            end;

            local function _() -- Line: 1179
                -- upvalues: u257 (ref), u1 (ref), TweenService (ref), pop (ref), string_upper_ret (ref)
                local v283 = u257;
                local v284 = u1 and u1:FindFirstChild("CrowdSurge");

                if v284 then
                    local v285 = v284:Clone();
                    v285.Volume = v284.Volume;
                    v285.Parent = v283.gui;
                    v285:Play();
                end;

                local v286 = u257;
                v286.flash.BackgroundTransparency = 0.65;
                TweenService:Create(v286.flash, TweenInfo.new(0.25), {
                    BackgroundTransparency = 1
                }):Play();
                pop(u257.title, string_upper_ret .. " HAS THE BALL");
                u257.shakeUntil = os.clock() + 0.3;
            end;

            if not u257.fired.catch and u257.catch - 0.02 <= v277 then
                u257.fired.catch = true;
                local v287 = u257;
                local v288 = u1 and u1:FindFirstChild("CrowdSurge");

                if v288 then
                    local v289 = v288:Clone();
                    v289.Volume = v288.Volume;
                    v289.Parent = v287.gui;
                    v289:Play();
                end;

                local v290 = u257;
                v290.flash.BackgroundTransparency = 0.65;
                TweenService:Create(v290.flash, TweenInfo.new(0.25), {
                    BackgroundTransparency = 1
                }):Play();
                pop(u257.title, string_upper_ret .. " HAS THE BALL");
                u257.shakeUntil = os.clock() + 0.3;
            end;

            local function _() -- Line: 1185
                -- upvalues: pop (ref), u257 (ref), u243 (ref)
                pop(u257.subtitle, u243.run == "FinalRun" and "FINAL RUN  ·  ONE AGAINST ALL" or "HERO RUN  ·  CROSS ALONE");
            end;

            if not u257.fired.subtitle and u257.catch + 0.55 <= v277 then
                u257.fired.subtitle = true;
                pop(u257.subtitle, u243.run == "FinalRun" and "FINAL RUN  ·  ONE AGAINST ALL" or "HERO RUN  ·  CROSS ALONE");
            end;
        else
            local function _() -- Line: 1189
                -- upvalues: pop (ref), u257 (ref), u270 (ref)
                pop(u257.eyebrow, u270);
            end;

            if not u257.fired.eyebrow and v277 >= 0.1 then
                u257.fired.eyebrow = true;
                pop(u257.eyebrow, u270);
            end;

            if u257.run then
                local function _() -- Line: 1193
                    -- upvalues: u257 (ref), u1 (ref), u9 (ref), pick (ref), u6 (ref)
                    local v291 = u257;
                    local v292 = u1 and u1:FindFirstChild("TouchdownCelebration");

                    if v292 then
                        local v293 = v292:Clone();
                        v293.Volume = v292.Volume;
                        v293.Parent = v291.gui;
                        v293:Play();
                    end;

                    if u9 then
                        u9.scored = true;
                    end;

                    pick(u6, 3);
                end;

                if not u257.fired.touchdownSound and u257.run.touchdown <= v277 then
                    u257.fired.touchdownSound = true;
                    local v294 = u257;
                    local v295 = u1 and u1:FindFirstChild("TouchdownCelebration");

                    if v295 then
                        local v296 = v295:Clone();
                        v296.Volume = v295.Volume;
                        v296.Parent = v294.gui;
                        v296:Play();
                    end;

                    if u9 then
                        u9.scored = true;
                    end;

                    pick(u6, 3);
                end;
            end;

            local function v297() -- Line: 1198
                -- upvalues: u257 (ref), u9 (ref), pick (ref), u6 (ref), pop (ref), u250 (ref), confetti (ref)
                if not u257.run then
                    if u9 then
                        u9.scored = true;
                    end;

                    pick(u6, 3);
                end;

                pop(u257.title, u250 and "GOAL!" or "TOUCHDOWN!");
                confetti(u257.kick and u257.kick.last or (u257.root.Parent and u257.root.Position or u257.origin));
                u257.shakeUntil = os.clock() + 0.35;
            end;

            if not u257.fired.spike and u257.spike - 0.05 <= v277 then
                u257.fired.spike = true;
                v297();
            end;

            local function _() -- Line: 1208
                -- upvalues: pop (ref), u257 (ref), string_upper_ret (ref)
                pop(u257.subtitle, string_upper_ret .. " SCORES");
            end;

            if not u257.fired.name and u257.spike + 0.45 <= v277 then
                u257.fired.name = true;
                pop(u257.subtitle, string_upper_ret .. " SCORES");
            end;
        end;

        local function _() -- Line: 1212
            -- upvalues: fadeOut (ref), u257 (ref)
            fadeOut(u257.eyebrow);
            fadeOut(u257.title);
            fadeOut(u257.subtitle);
        end;

        if not u257.fired.titles and u257.back <= v277 then
            u257.fired.titles = true;
            fadeOut(u257.eyebrow);
            fadeOut(u257.title);
            fadeOut(u257.subtitle);
        end;

        local v298 = u257.root.Parent and u257.root.Position or u257.origin;
        local v299 = v298 + Vector3.new(0, 1.5, 0);
        local v300 = nil;

        if u257.run then
            placeDefenders(u257, v277);
            moveDefenders(u257, v277);

            if u257.run.ends <= v277 and u257.hide then
                u257.hide:restore();
                u257.hide = nil;
            end;
        end;

        local v301, v302;

        if u257.run and v277 < u257.run.ends then
            v301, v302 = runShot(u257, v277, v298, p276);
        elseif u257.run then
            u257.run.view = u257.run.view or {
                forward = u257.run.forward,
                right = u257.run.right,
                back = u257.back - u257.run.ends,
                spike = u257.spike - u257.run.ends
            };
            v301, v302 = u271(u257.run.view, v277 - u257.run.ends, v298);
        elseif u257.kick and v277 < u257.kick.celebrate then
            v301, v302, v300 = kickShot(u257, v277, v298, p276);
        elseif u257.kick then
            if not u257.kick.view then
                local v303 = u257.root.CFrame.LookVector * Vector3.new(1, 0, 1);
                local v304;

                if v303.Magnitude > 0.01 then
                    v304 = v303.Unit;
                else
                    v304 = u257.forward;
                end;

                u257.kick.view = {
                    spike = (1 / 0),
                    forward = v304,
                    right = v304:Cross(Vector3.new(0, 1, 0)).Unit,
                    back = u257.back - u257.kick.celebrate
                };
                u257.fade.BackgroundTransparency = 0;
                TweenService:Create(u257.fade, TweenInfo.new(0.35, Enum.EasingStyle.Quad), {
                    BackgroundTransparency = 1
                }):Play();
            end;

            v301, v302 = u271(u257.kick.view, v277 - u257.kick.celebrate, v298);
        else
            v301, v302 = u271(u257, v277, v298);
        end;

        local v305 = v300 or v299;
        local v306;

        if u257.glide and v277 < u257.introEnd then
            v306 = smoother((v277 - u257.introStart) / (u257.introEnd - u257.introStart));
            v301 = orbit(u257.startCF, v301, v306, v299);
            v302 = u257.fov + (v302 - u257.fov) * v306;
        else
            v306 = 1;
        end;

        if u257.back < v277 then
            if not u257.spectating then
                CFrame2, Position = home(u257);
            end;

            if CFrame2 then
                local v307 = smoother((v277 - u257.back) / (u257.homeAt - u257.back));
                v301 = (Position - v299).Magnitude < 12 and orbit(v301, CFrame2, v307, v299) or glide(v301, CFrame2, v307, v299, Position);
                v302 = v302 + (u257.fov - v302) * v307;
                v306 = 1 - v307;
                v305 = v299:Lerp(Position, v307);
            end;
        end;

        if u257.homeAt <= v277 then
            u257.pull = nil;
        else
            v301 = unblocked(u257, v301, v305, p276, u257.back < v277);
        end;

        if u257.shakeUntil > os.clock() then
            local v308 = (u257.shakeUntil - os.clock()) * 2.2;
            local CFrame_Angles = CFrame.Angles;
            local v309 = (math.random() - 0.5) * v308;
            local math_rad_ret = math.rad(v309);
            local v310 = (math.random() - 0.5) * v308;
            v301 = v301 * CFrame_Angles(math_rad_ret, math.rad(v310), 0);
        end;

        workspace_CurrentCamera.CFrame = v301;
        workspace_CurrentCamera.FieldOfView = v302;
        local v311 = smoother(v277 / 0.75) * (1 - smoother((v277 - u257.duration + 0.75) / 0.7));

        if v311 ~= u257.bars then
            local v312 = u257;
            v312.bars = v311;
            v312.top.Position = UDim2.fromScale(0.5, 0.11 * v311);
            v312.bottom.Position = UDim2.fromScale(0.5, 1 - 0.11 * v311);
        end;

        if v306 ~= u257.weight then
            u257.weight = v306;
            ColorCorrectionEffect.Saturation = v306 * 0.15;
            ColorCorrectionEffect.Contrast = v306 * 0.08;
            ColorCorrectionEffect.TintColor = Color3_new_ret:Lerp(Color3_fromRGB_ret2, v306);
            DepthOfFieldEffect.FarIntensity = v306 * 0.35;
        end;

        DepthOfFieldEffect.FocusDistance = (v301.Position - v298).Magnitude;
    end);
end;

local KnifeClips = require(ChickenOrHero:WaitForChild("Weapons"):WaitForChild("KnifeClips"));
local u313 = {
    Football = { "CatchAnim", "TouchdownAnim" },
    Futbol = { "IntroAnim", "IntroLoopAnim", "CelebrateAnim", "CelebrateLoopAnim", "ScoreCenterAnim", "ScoreLeftAnim", "ScoreRightAnim" }
};
local u314 = {
    Football = { "CatchAnim", "TouchdownAnim" },
    Futbol = { "IntroAnim", "CelebrateAnim", "ScoreCenterAnim", "ScoreLeftAnim", "ScoreRightAnim" }
};
local u315 = nil;
local u316 = nil;
local u317 = nil;

local function animatorOf(p318) -- Line: 1333
    -- upvalues: Players (copy)
    if p318 then
        p318 = Players:GetPlayerByUserId(p318);
    end;

    if p318 then
        p318 = p318.Character;
    end;

    local v319;

    if p318 then
        v319 = p318:FindFirstChildOfClass("Humanoid");
    else
        v319 = p318;
    end;

    if v319 then
        v319 = v319:FindFirstChildOfClass("Animator");
    end;

    return v319, p318;
end;

local function clipIds(p320, p321) -- Line: 1340
    -- upvalues: ChickenOrHero (copy), KnifeClips (copy)
    local v322 = ChickenOrHero.Weapons.Models:FindFirstChild(p320);
    local v323 = {};

    for _, v in p321 do
        local v324;

        if v322 then
            v324 = KnifeClips.normalize(v322:GetAttribute(v));
        else
            v324 = v322;
        end;

        if v324 then
            v323[v324] = true;
        end;
    end;

    return v323;
end;

local function stopClips(p325, p326) -- Line: 1352
    -- upvalues: Players (copy), u313 (copy), clipIds (copy)
    local v327 = p326 or "Football";

    if p325 then
        p325 = Players:GetPlayerByUserId(p325);
    end;

    if p325 then
        p325 = p325.Character;
    end;

    local v328;

    if p325 then
        v328 = p325:FindFirstChildOfClass("Humanoid");
    else
        v328 = p325;
    end;

    if v328 then
        v328 = v328:FindFirstChildOfClass("Animator");
    end;

    if not (v328 and (u313[v327] and p325:GetAttribute("EmoteId") == nil)) then
        return;
    end;

    local v329 = clipIds(v327, u313[v327]);

    for _, v in v328:GetPlayingAnimationTracks() do
        local Animation = v.Animation;

        if Animation and v329[Animation.AnimationId] then
            v:Stop(0.2);
        end;
    end;
end;

local function watchOnce(p330) -- Line: 1366
    -- upvalues: u317 (ref), u314 (copy), Players (copy), clipIds (copy)
    if u317 then
        u317:Disconnect();
        u317 = nil;
    end;

    local v331 = p330 and u314[p330.skin];

    if v331 then
        v331 = p330.userId;

        if v331 then
            v331 = Players:GetPlayerByUserId(v331);
        end;

        if v331 then
            v331 = v331.Character;
        end;

        if v331 then
            v331 = v331:FindFirstChildOfClass("Humanoid");
        end;

        if v331 then
            v331 = v331:FindFirstChildOfClass("Animator");
        end;
    end;

    if not v331 then
        return;
    end;

    local u332 = clipIds(p330.skin, u314[p330.skin]);

    local function v337(u333) -- Line: 1376
        -- upvalues: u332 (copy)
        local Animation = u333.Animation;

        if not (Animation and u332[Animation.AnimationId]) then
            return;
        end;

        u333.Looped = false;
        local u334 = nil;
        local u335 = nil;
        local u336 = nil;

        local function release() -- Line: 1385
            -- upvalues: u334 (ref), u335 (ref), u336 (ref)
            for _, v in { u334, u335, u336 } do
                v:Disconnect();
            end;
        end;

        u334 = u333:GetPropertyChangedSignal("Length"):Connect(function() -- Line: 1390
            -- upvalues: u333 (copy)
            u333.Looped = false;
        end);
        u335 = u333.DidLoop:Connect(function() -- Line: 1393
            -- upvalues: release (copy), u333 (copy)
            release();
            u333.Looped = false;
            u333:Stop(0.15);
        end);
        u336 = u333.Stopped:Connect(release);
    end;

    u317 = v331.AnimationPlayed:Connect(v337);

    for _, v in v331:GetPlayingAnimationTracks() do
        v337(v);
    end;
end;

local function refreshShow() -- Line: 1405
    -- upvalues: Session (copy), HttpService (copy), watchOnce (copy), prepareDefenders (copy), stopClips (copy), u315 (ref), u316 (ref), stop (copy), u146 (ref), start (copy)
    local Attribute = Session:GetAttribute("FootballShow");
    local v338;

    if type(Attribute) == "string" and Attribute ~= "" then
        local v339;
        v339, v338 = pcall(HttpService.JSONDecode, HttpService, Attribute);

        if not (v339 and (type(v338) == "table" and v338)) then
            v338 = nil;
        end;
    else
        v338 = nil;
    end;

    watchOnce(v338);

    if v338 and (v338.skin == "Football" and (v338.kind == "Catch" or v338.kind == "Touchdown")) and type(v338.userId) == "number" then
        prepareDefenders(v338.userId);
    end;

    if not v338 then
        stopClips(u315, u316);
        u315 = nil;
        u316 = nil;
        stop();

        return;
    end;

    if u315 and (u315 ~= v338.userId or u316 ~= v338.skin) then
        stopClips(u315, u316);
    end;

    u315 = v338.userId;
    u316 = v338.skin;

    if u146 and u146.version == v338.version then
        return;
    end;

    task.spawn(start, v338);
end;

local AttributeChangedSignal3 = Session:GetAttributeChangedSignal("FootballShow");
table.insert(u29, AttributeChangedSignal3:Connect(refreshShow));
refreshShow();

local function leftMatch() -- Line: 1431
    -- upvalues: u9 (ref), LocalPlayer (copy), u11 (ref), fadeSong (copy), Sound2 (copy)
    if u9 and (LocalPlayer:GetAttribute("InMatch") ~= true and LocalPlayer:GetAttribute("Spectating") ~= true) then
        u9 = nil;

        if u11 ~= false then
            u11 = false;
            LocalPlayer:SetAttribute("MusicPaused", nil);
        end;

        fadeSong(0, 1.5).Completed:Once(function(p340) -- Line: 138
            -- upvalues: u9 (ref), Sound2 (ref)
            if p340 == Enum.PlaybackState.Completed and not u9 then
                Sound2:Stop();
            end;
        end);
    end;
end;

local AttributeChangedSignal4 = LocalPlayer:GetAttributeChangedSignal("InMatch");
table.insert(u29, AttributeChangedSignal4:Connect(leftMatch));
local AttributeChangedSignal5 = LocalPlayer:GetAttributeChangedSignal("Spectating");
table.insert(u29, AttributeChangedSignal5:Connect(leftMatch));
script.Destroying:Connect(function() -- Line: 1439
    -- upvalues: u11 (ref), LocalPlayer (copy), Folder (copy), u35 (ref), u29 (copy), u317 (ref), stop (copy), u33 (ref)
    if u11 ~= false then
        u11 = false;
        LocalPlayer:SetAttribute("MusicPaused", nil);
    end;

    Folder:Destroy();
    u35();

    for _, v in u29 do
        v:Disconnect();
    end;

    if u317 then
        u317:Disconnect();
        u317 = nil;
    end;

    stop();

    if u33 then
        u33.folder:Destroy();
        u33 = nil;
    end;
end);