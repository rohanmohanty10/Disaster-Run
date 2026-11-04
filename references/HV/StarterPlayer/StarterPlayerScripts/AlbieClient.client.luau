 

 

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local UserInputService = game:GetService("UserInputService");
local SoundService = game:GetService("SoundService");

if require(game:GetService("ReplicatedFirst"):WaitForChild("FFlags")).Albie == false then
    return;
end;

local LocalPlayer = Players.LocalPlayer;
local ChickenOrHero = game:GetService("ReplicatedStorage"):WaitForChild("ChickenOrHero");
local AlbieRemote = ChickenOrHero:WaitForChild("Game"):WaitForChild("AlbieRemote");
local Presentation = ChickenOrHero:WaitForChild("Presentation");
local CreatorVisibility = require(Presentation:WaitForChild("CreatorVisibility"));
local CutsceneScreen = require(Presentation:WaitForChild("CutsceneScreen"));
local Interface = ChickenOrHero:WaitForChild("Interface");
local Session = ChickenOrHero:WaitForChild("Game"):WaitForChild("Session");
local utf8_char_ret = utf8.char(57344);
local Color3_fromRGB_ret = Color3.fromRGB(255, 205, 112);
local Color3_fromRGB_ret2 = Color3.fromRGB(150, 220, 255);
local Color3_new_ret = Color3.new(1, 1, 1);
local Color3_new_ret2 = Color3.new(0, 0, 0);
local Font_new_ret = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy);
local Font_new_ret2 = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Bold);
local Font_new_ret3 = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.SemiBold);

local function gameSound(p1, p2, p3, p4, p5) -- Line: 60
    -- upvalues: SoundService (copy)
    local GameAudio = SoundService:FindFirstChild("GameAudio");

    if GameAudio then
        GameAudio = GameAudio:FindFirstChild(p1);
    end;

    if GameAudio then
        GameAudio = GameAudio:FindFirstChild(p2);
    end;

    if not (GameAudio and GameAudio:IsA("Sound")) then
        return nil;
    end;

    local v6 = GameAudio:Clone();
    v6.Volume = p3;
    v6.PlaybackSpeed = p4 or 1;
    v6.Looped = false;
    v6.Parent = p5;

    return v6;
end;

local function assetSound(p7, p8, p9) -- Line: 74
    local Sound = Instance.new("Sound");
    Sound.SoundId = p7;
    Sound.Volume = p8;
    Sound.Parent = p9;

    return Sound;
end;

local u10 = nil;
local u11 = nil;
local u12 = nil;
local u13 = false;

local function heardAll() -- Line: 86
    -- upvalues: LocalPlayer (copy)
    local Attribute = LocalPlayer:GetAttribute("AlbieTotal");
    local v14;

    if type(Attribute) == "number" then
        v14 = Attribute <= (tonumber(LocalPlayer:GetAttribute("AlbieChapter")) or 0);
    else
        v14 = false;
    end;

    return v14;
end;

local function promptText() -- Line: 91
    -- upvalues: u10 (ref), LocalPlayer (copy)
    local v15 = u10 and u10:FindFirstChild("HumanoidRootPart");

    if v15 then
        v15 = v15:FindFirstChild("AlbieTalk");
    end;

    if not v15 then
        return;
    end;

    local Attribute = LocalPlayer:GetAttribute("AlbieChapter");
    local Attribute2 = LocalPlayer:GetAttribute("AlbieNextAt");
    local v16 = type(Attribute2) ~= "number" and 0 or Attribute2 - workspace:GetServerTimeNow();
    local v17;

    if type(Attribute) == "number" then
        local Attribute3 = LocalPlayer:GetAttribute("AlbieTotal");
        local v18;

        if type(Attribute3) == "number" then
            v18 = Attribute3 <= (tonumber(LocalPlayer:GetAttribute("AlbieChapter")) or 0);
        else
            v18 = false;
        end;

        if v18 then
            v17 = "Remember albie";
        elseif v16 > 0 then
            if v16 >= 3600 then
                v17 = string.format("Stories · Next in %dh", (math.ceil(v16 / 3600)));
            else
                local string_format = string.format;
                local math_ceil_ret = math.ceil(v16 / 60);
                v17 = string_format("Stories · Next in %dm", (math.max(1, math_ceil_ret)));
            end;
        else
            local Attribute4 = LocalPlayer:GetAttribute("AlbieNextGems");

            if type(Attribute4) == "number" then
                v17 = string.format("Talk · Day %d · %d Gems", Attribute + 1, Attribute4);
            else
                v17 = string.format("Talk · Day %d", Attribute + 1);
            end;
        end;
    else
        v17 = "Talk";
    end;

    if v15.ActionText ~= v17 then
        v15.ActionText = v17;
    end;
end;

local u19 = nil;

local function tombstone(p20) -- Line: 122
    -- upvalues: u19 (ref), u10 (ref), ChickenOrHero (copy), LocalPlayer (copy)
    if not p20 then
        if u19 then
            u19:Destroy();
            u19 = nil;
        end;

        return;
    end;

    local v21 = u10 and u10:FindFirstChild("HumanoidRootPart");

    if u19 or not v21 then
        return;
    end;

    local v22 = nil;

    for _, v in { ChickenOrHero, game:GetService("ReplicatedStorage") } do
        for _, child in v:GetChildren() do
            local v23 = child.Name:lower();

            if (v23:find("tomb") or v23:find("grave")) and child:IsA("PVInstance") then
                v22 = child;
                break;
            end;
        end;

        if v22 then
            break;
        end;
    end;

    if not v22 then
        return;
    end;

    u19 = v22:Clone();

    for _, descendant in u19:GetDescendants() do
        if descendant:IsA("BaseScript") then
            descendant:Destroy();
        elseif descendant:IsA("BasePart") then
            descendant.Anchored = true;
        end;
    end;

    if u19:IsA("BasePart") then
        u19.Anchored = true;
    end;

    if (u19:GetPivot().Position - v21.Position).Magnitude > 30 then
        local RaycastParams_new_ret = RaycastParams.new();
        RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
        RaycastParams_new_ret.FilterDescendantsInstances = { u10, LocalPlayer.Character };
        local v24 = workspace:Raycast(v21.Position, Vector3.new(0, -12, 0), RaycastParams_new_ret);
        local v25;

        if v24 then
            v25 = v24.Position.Y;
        else
            v25 = v21.Position.Y - 3;
        end;

        local Rotation = u10:GetPivot().Rotation;
        u19:PivotTo(CFrame.new(v21.Position.X, v25, v21.Position.Z) * Rotation);
        local v26, v27;

        if u19:IsA("Model") then
            v26, v27 = u19:GetBoundingBox();
        else
            v26 = u19.CFrame;
            v27 = u19.Size;
        end;

        u19:PivotTo(u19:GetPivot() + Vector3.new(0, v25 - (v26.Position.Y - v27.Y / 2), 0));
    end;

    u19.Name = "AlbieTombstone";
    u19.Parent = workspace;
end;

local function daysGone() -- Line: 182
    -- upvalues: LocalPlayer (copy)
    local Attribute = LocalPlayer:GetAttribute("AlbieGoneDay");
    local Attribute2 = LocalPlayer:GetAttribute("AlbieTotal");
    local v28;

    if type(Attribute2) == "number" then
        v28 = Attribute2 <= (tonumber(LocalPlayer:GetAttribute("AlbieChapter")) or 0);
    else
        v28 = false;
    end;

    if v28 and type(Attribute) == "number" then
        return workspace:GetServerTimeNow() // 86400 - Attribute;
    end;

    return nil;
end;

local u29 = nil;

local function presence(p30) -- Line: 196
    -- upvalues: u10 (ref), tombstone (copy), LocalPlayer (copy), u29 (ref)
    if not u10 then
        return;
    end;

    local v31;

    if p30 == "Gone" then
        v31 = true;
    elseif p30 == "Memory" then
        local Attribute = LocalPlayer:GetAttribute("AlbieGoneDay");
        local Attribute2 = LocalPlayer:GetAttribute("AlbieTotal");
        local v32;

        if type(Attribute2) == "number" then
            v32 = Attribute2 <= (tonumber(LocalPlayer:GetAttribute("AlbieChapter")) or 0);
        else
            v32 = false;
        end;

        local v33;

        if v32 and type(Attribute) == "number" then
            v33 = workspace:GetServerTimeNow() // 86400 - Attribute;
        else
            v33 = nil;
        end;

        v31 = (v33 or 0) >= 4;
    else
        v31 = false;
    end;

    tombstone(v31);
    local v34 = (p30 == "Gone" or p30 == "Vanished") and 1 or ((p30 == "Memory" or p30 == "Ghost") and 0.55 or 0);

    for _, descendant in u10:GetDescendants() do
        if descendant:IsA("BasePart") and descendant.Name ~= "HumanoidRootPart" or descendant:IsA("Decal") then
            descendant.LocalTransparencyModifier = v34;
        elseif descendant:IsA("BillboardGui") then
            descendant.Enabled = p30 == "Shown" and true or p30 == "Ghost";
        end;
    end;

    local v35 = p30 == "Gone" and true or p30 == "Vanished";

    if v35 and not u29 then
        local HumanoidRootPart = u10:FindFirstChild("HumanoidRootPart");

        if HumanoidRootPart then
            u29 = Instance.new("Attachment");
            u29.Name = "AlbieWind";
            local ParticleEmitter = Instance.new("ParticleEmitter");
            ParticleEmitter.Texture = "rbxasset://textures/particles/smoke_main.dds";
            ParticleEmitter.Color = ColorSequence.new(Color3.fromRGB(235, 240, 255));
            ParticleEmitter.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.3, 0.82), NumberSequenceKeypoint.new(1, 1) });
            ParticleEmitter.Size = NumberSequence.new(0.6, 1.8);
            ParticleEmitter.Lifetime = NumberRange.new(2, 3);
            ParticleEmitter.Rate = 3;
            ParticleEmitter.Speed = NumberRange.new(0.5, 1.2);
            ParticleEmitter.SpreadAngle = Vector2.new(180, 180);
            ParticleEmitter.RotSpeed = NumberRange.new(-40, 40);
            ParticleEmitter.Acceleration = Vector3.new(1.5, 0.6, 0);
            ParticleEmitter.LightEmission = 0.3;
            ParticleEmitter.Parent = u29;
            u29.Parent = HumanoidRootPart;
        end;
    elseif not v35 and u29 then
        u29:Destroy();
        u29 = nil;
    end;
end;

local u36 = nil;

local function settle() -- Line: 236
    -- upvalues: u13 (ref), LocalPlayer (copy), u36 (ref), presence (copy)
    if u13 then
        return;
    end;

    local v37 = "Shown";
    local Attribute = LocalPlayer:GetAttribute("AlbieTotal");
    local v38;

    if type(Attribute) == "number" then
        v38 = Attribute <= (tonumber(LocalPlayer:GetAttribute("AlbieChapter")) or 0);
    else
        v38 = false;
    end;

    if v38 then
        local Attribute2 = LocalPlayer:GetAttribute("AlbieGoneDay");
        local Attribute3 = LocalPlayer:GetAttribute("AlbieTotal");
        local v39;

        if type(Attribute3) == "number" then
            v39 = Attribute3 <= (tonumber(LocalPlayer:GetAttribute("AlbieChapter")) or 0);
        else
            v39 = false;
        end;

        local v40;

        if v39 and type(Attribute2) == "number" then
            v40 = workspace:GetServerTimeNow() // 86400 - Attribute2;
        else
            v40 = nil;
        end;

        local v41 = v40 or 0;
        v37 = v41 >= 4 and "Gone" or (v41 >= 1 and "Ghost" or "Vanished");
    end;

    if v37 ~= u36 then
        u36 = v37;
        presence(v37);
    end;
end;

local function adopt(u42) -- Line: 251
    -- upvalues: u10 (ref), u19 (ref), u11 (ref), u12 (ref), u29 (ref), promptText (copy), u36 (ref), u13 (ref), LocalPlayer (copy), presence (copy)
    if u10 == u42 or not u42:GetAttribute("AlbieNPC") then
        return;
    end;

    u10 = u42;
    u42.Destroying:Once(function() -- Line: 256
        -- upvalues: u10 (ref), u42 (copy), u19 (ref), u11 (ref), u12 (ref), u29 (ref)
        if u10 == u42 then
            if u19 then
                u19:Destroy();
                u19 = nil;
            end;

            u10 = nil;
            u11 = nil;
            u12 = nil;
            u29 = nil;
        end;
    end);
    local Humanoid = u42:WaitForChild("Humanoid", 10);

    if Humanoid then
        Humanoid = Humanoid:WaitForChild("Animator", 10);
    end;

    if Humanoid then
        local Animation = Instance.new("Animation");
        Animation.AnimationId = "rbxassetid://113589223418669";
        local success, result = pcall(Humanoid.LoadAnimation, Humanoid, Animation);
        Animation:Destroy();

        if success then
            result.Looped = true;
            result.Priority = Enum.AnimationPriority.Action;
            result:Play(0);
        else
            warn("albie\'s sit couldn\'t load:", result);
        end;
    end;

    local Torso = u42:WaitForChild("Torso", 10);

    if Torso then
        Torso = Torso:WaitForChild("Neck", 10);
    end;

    if Torso and Torso:IsA("Motor6D") then
        u11 = Torso;
        u12 = Torso.C0;
    end;

    local HumanoidRootPart = u42:WaitForChild("HumanoidRootPart", 10);

    if HumanoidRootPart and HumanoidRootPart:WaitForChild("AlbieTalk", 10) then
        promptText();
    end;

    u36 = nil;

    if u13 then
        return;
    end;

    local v43 = "Shown";
    local Attribute = LocalPlayer:GetAttribute("AlbieTotal");
    local v44;

    if type(Attribute) == "number" then
        v44 = Attribute <= (tonumber(LocalPlayer:GetAttribute("AlbieChapter")) or 0);
    else
        v44 = false;
    end;

    if v44 then
        local Attribute2 = LocalPlayer:GetAttribute("AlbieGoneDay");
        local Attribute3 = LocalPlayer:GetAttribute("AlbieTotal");
        local v45;

        if type(Attribute3) == "number" then
            v45 = Attribute3 <= (tonumber(LocalPlayer:GetAttribute("AlbieChapter")) or 0);
        else
            v45 = false;
        end;

        local v46;

        if v45 and type(Attribute2) == "number" then
            v46 = workspace:GetServerTimeNow() // 86400 - Attribute2;
        else
            v46 = nil;
        end;

        local v47 = v46 or 0;
        v43 = v47 >= 4 and "Gone" or (v47 >= 1 and "Ghost" or "Vanished");
    end;

    if v43 ~= u36 then
        u36 = v43;
        presence(v43);
    end;
end;

workspace.ChildAdded:Connect(function(p48) -- Line: 289
    -- upvalues: adopt (copy)
    if p48.Name == "AlbieNPC" then
        task.spawn(adopt, p48);
    end;
end);

if workspace:FindFirstChild("AlbieNPC") then
    task.spawn(adopt, workspace.AlbieNPC);
end;

LocalPlayer:GetAttributeChangedSignal("AlbieChapter"):Connect(function() -- Line: 297
    -- upvalues: promptText (copy), u13 (ref), LocalPlayer (copy), u36 (ref), presence (copy)
    promptText();

    if u13 then
        return;
    end;

    local v49 = "Shown";
    local Attribute = LocalPlayer:GetAttribute("AlbieTotal");
    local v50;

    if type(Attribute) == "number" then
        v50 = Attribute <= (tonumber(LocalPlayer:GetAttribute("AlbieChapter")) or 0);
    else
        v50 = false;
    end;

    if v50 then
        local Attribute2 = LocalPlayer:GetAttribute("AlbieGoneDay");
        local Attribute3 = LocalPlayer:GetAttribute("AlbieTotal");
        local v51;

        if type(Attribute3) == "number" then
            v51 = Attribute3 <= (tonumber(LocalPlayer:GetAttribute("AlbieChapter")) or 0);
        else
            v51 = false;
        end;

        local v52;

        if v51 and type(Attribute2) == "number" then
            v52 = workspace:GetServerTimeNow() // 86400 - Attribute2;
        else
            v52 = nil;
        end;

        local v53 = v52 or 0;
        v49 = v53 >= 4 and "Gone" or (v53 >= 1 and "Ghost" or "Vanished");
    end;

    if v49 ~= u36 then
        u36 = v49;
        presence(v49);
    end;
end);
LocalPlayer:GetAttributeChangedSignal("AlbieGoneDay"):Connect(settle);
LocalPlayer:GetAttributeChangedSignal("AlbieNextAt"):Connect(promptText);
LocalPlayer:GetAttributeChangedSignal("AlbieNextGems"):Connect(promptText);
task.spawn(function() -- Line: 305
    -- upvalues: promptText (copy), u13 (ref), LocalPlayer (copy), u36 (ref), presence (copy)
    while true do
        repeat
            task.wait(30);
            promptText();
        until not u13;

        local v54 = "Shown";
        local Attribute = LocalPlayer:GetAttribute("AlbieTotal");
        local v55;

        if type(Attribute) == "number" then
            v55 = Attribute <= (tonumber(LocalPlayer:GetAttribute("AlbieChapter")) or 0);
        else
            v55 = false;
        end;

        if v55 then
            local Attribute2 = LocalPlayer:GetAttribute("AlbieGoneDay");
            local Attribute3 = LocalPlayer:GetAttribute("AlbieTotal");
            local v56;

            if type(Attribute3) == "number" then
                v56 = Attribute3 <= (tonumber(LocalPlayer:GetAttribute("AlbieChapter")) or 0);
            else
                v56 = false;
            end;

            local v57;

            if v56 and type(Attribute2) == "number" then
                v57 = workspace:GetServerTimeNow() // 86400 - Attribute2;
            else
                v57 = nil;
            end;

            local v58 = v57 or 0;
            v54 = v58 >= 4 and "Gone" or (v58 >= 1 and "Ghost" or "Vanished");
        end;

        if v54 ~= u36 then
            u36 = v54;
            presence(v54);
        end;
    end;
end);
local u59 = {
    want = nil,
    yaw = 0,
    pitch = 0,
    switchAt = 0,
    talk = false
};

local function eyesOn(p60) -- Line: 315
    -- upvalues: u59 (copy)
    u59.want = p60;
end;

RunService.RenderStepped:Connect(function(p61) -- Line: 318
    -- upvalues: u10 (ref), u11 (ref), LocalPlayer (copy), u59 (copy), u12 (ref)
    if not (u10 and (u11 and u11.Parent)) then
        return;
    end;

    local Head = u10:FindFirstChild("Head");
    local Character = LocalPlayer.Character;

    if Character then
        Character = Character:FindFirstChild("Head");
    end;

    if Head then
        if Character then
            Head = (Character.Position - Head.Position).Magnitude < 16;
        else
            Head = Character;
        end;
    end;

    if not u59.talk then
        local os_clock_ret = os.clock();

        if Head then
            local Attribute = LocalPlayer:GetAttribute("AlbieTotal");
            local v62;

            if type(Attribute) == "number" then
                v62 = Attribute <= (tonumber(LocalPlayer:GetAttribute("AlbieChapter")) or 0);
            else
                v62 = false;
            end;

            if v62 then
                u59.want = nil;
            elseif u59.switchAt <= os_clock_ret then
                u59.switchAt = os_clock_ret + 2.5 + math.random() * 3;
                u59.want = not u59.want and "Player" or nil;
            end;
        else
            u59.want = nil;
        end;
    end;

    local v63, v64;

    if u59.want == "Player" and (Character and u11.Part0) then
        local v65 = u11.Part0.CFrame:PointToObjectSpace(Character.Position);
        local math_atan2_ret = math.atan2(-v65.X, -v65.Z);
        v63 = math.clamp(math_atan2_ret, -0.6981317007977318, 0.6981317007977318);
        local Magnitude = Vector2.new(v65.X, v65.Z).Magnitude;
        local math_atan2_ret2 = math.atan2(v65.Y - 1.5, Magnitude);
        v64 = math.clamp(math_atan2_ret2, -0.6981317007977318, 0.6981317007977318);
    else
        v63 = 0;
        v64 = 0;
    end;

    local v66 = 1 - math.exp(-p61 * 3.2);
    local v67 = u59;
    v67.yaw = v67.yaw + (v63 - u59.yaw) * v66;
    local v68 = u59;
    v68.pitch = v68.pitch + (v64 - u59.pitch) * v66;

    if math.abs(u59.yaw) < 0.002 and (math.abs(u59.pitch) < 0.002 and u59.want == nil) then
        if u11.C0 ~= u12 then
            u11.C0 = u12;
        end;

        return;
    end;

    u11.C0 = u12 * CFrame.Angles(-u59.pitch, 0, u59.yaw);
end);

local function tween(p69, p70, p71, p72) -- Line: 356
    -- upvalues: TweenService (copy)
    local v73 = TweenService:Create(p69, TweenInfo.new(p70, p72 or Enum.EasingStyle.Quad, Enum.EasingDirection.Out), p71);
    v73:Play();

    return v73;
end;

local function make(p74, p75, p76) -- Line: 361
    local Instance_new_ret = Instance.new(p74);

    for i, v in p76 do
        Instance_new_ret[i] = v;
    end;

    Instance_new_ret.Parent = p75;

    return Instance_new_ret;
end;

local function label(p77, p78) -- Line: 370
    -- upvalues: Color3_new_ret (copy), Color3_new_ret2 (copy)
    local v79 = p78.Button and "TextButton" or "TextLabel";
    p78.Button = nil;
    p78.BackgroundTransparency = 1;
    p78.TextColor3 = p78.TextColor3 or Color3_new_ret;
    p78.TextStrokeColor3 = Color3_new_ret2;

    if p78.TextStrokeTransparency == nil then
        p78.TextStrokeTransparency = 0.55;
    end;

    local Instance_new_ret = Instance.new(v79);

    for i, v in p78 do
        Instance_new_ret[i] = v;
    end;

    Instance_new_ret.Parent = p77;

    return Instance_new_ret;
end;

local function smooth(p80) -- Line: 381
    local math_clamp_ret = math.clamp(p80, 0, 1);

    return math_clamp_ret * math_clamp_ret * (3 - 2 * math_clamp_ret);
end;

local function uiSound(p81, p82, p83) -- Line: 385
    -- upvalues: gameSound (copy)
    return gameSound("04_UI", p81, p82, p83);
end;

local function fit(p84) -- Line: 602
    local Y = p84.gui.AbsoluteSize.Y;
    local body = p84.body;
    local math_floor_ret = math.floor(Y * 0.036);
    body.TextSize = math.clamp(math_floor_ret, 16, 30);
    local speaker = p84.speaker;
    local math_floor_ret2 = math.floor(Y * 0.022);
    speaker.TextSize = math.clamp(math_floor_ret2, 12, 18);
end;

local LocalHide = require(Presentation:WaitForChild("LocalHide"));
local LocalLooks = require(Presentation:WaitForChild("LocalLooks"));
local LeaderboardConfig = require(Presentation:WaitForChild("LeaderboardConfig"));
local u85 = {};

local function buildGui() -- Line: 391
    -- upvalues: CutsceneScreen (copy), Color3_new_ret2 (copy), Font_new_ret2 (copy), Color3_new_ret (copy), Color3_fromRGB_ret (copy), Font_new_ret (copy), Font_new_ret3 (copy), gameSound (copy), LocalPlayer (copy)
    local v86 = {};
    local AlbieTalk = CutsceneScreen.new("AlbieTalk", 120);
    AlbieTalk:SetAttribute("CreatorCaptureExempt", true);
    AlbieTalk:SetAttribute("SelfManagedText", true);
    v86.gui = AlbieTalk;
    local v87 = {
        Name = "Advance",
        Text = "",
        AutoButtonColor = false,
        BackgroundTransparency = 1,
        Selectable = false,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(1.5, 1.5)
    };
    local TextButton = Instance.new("TextButton");

    for i, v in v87 do
        TextButton[i] = v;
    end;

    TextButton.Parent = AlbieTalk;
    v86.advance = TextButton;

    for _, v in { "Top", "Bottom" } do
        local v88 = {
            BorderSizePixel = 0,
            ZIndex = 2,
            Name = v,
            AnchorPoint = Vector2.new(0.5, v == "Top" and 1 or 0),
            Position = UDim2.fromScale(0.5, v == "Top" and 0 or 1),
            Size = UDim2.new(1.5, 0, 0.1, 0),
            BackgroundColor3 = Color3_new_ret2
        };
        local Frame = Instance.new("Frame");

        for i, v2 in v88 do
            Frame[i] = v2;
        end;

        Frame.Parent = AlbieTalk;
        v86[v] = Frame;
    end;

    local Top = v86.Top;
    local v89 = {
        Button = true,
        Name = "Leave",
        Text = "LEAVE",
        TextScaled = true,
        TextStrokeTransparency = 1,
        ZIndex = 3,
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(0.8333333333333334, -20, 0.5, 0),
        Size = UDim2.new(0, 110, 0.4, 0),
        FontFace = Font_new_ret2,
        TextColor3 = Color3.fromRGB(190, 190, 196),
        TextXAlignment = Enum.TextXAlignment.Right
    };
    local v90 = v89.Button and "TextButton" or "TextLabel";
    v89.Button = nil;
    v89.BackgroundTransparency = 1;
    v89.TextColor3 = v89.TextColor3 or Color3_new_ret;
    v89.TextStrokeColor3 = Color3_new_ret2;

    if v89.TextStrokeTransparency == nil then
        v89.TextStrokeTransparency = 0.55;
    end;

    local Instance_new_ret = Instance.new(v90);

    for i, v in v89 do
        Instance_new_ret[i] = v;
    end;

    Instance_new_ret.Parent = Top;
    v86.leave = Instance_new_ret;
    local leave = v86.leave;
    local UITextSizeConstraint = Instance.new("UITextSizeConstraint");

    for i, v in {
        MaxTextSize = 18
    } do
        UITextSizeConstraint[i] = v;
    end;

    UITextSizeConstraint.Parent = leave;
    local Bottom = v86.Bottom;
    local v91 = {
        Name = "Next",
        Text = "CONTINUE  ▶",
        TextScaled = true,
        TextStrokeTransparency = 1,
        Visible = false,
        ZIndex = 3,
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(0.8333333333333334, -20, 0.5, 0),
        Size = UDim2.new(0, 160, 0.3, 0),
        FontFace = Font_new_ret2,
        TextColor3 = Color3_fromRGB_ret,
        TextXAlignment = Enum.TextXAlignment.Right
    };
    local v92 = v91.Button and "TextButton" or "TextLabel";
    v91.Button = nil;
    v91.BackgroundTransparency = 1;
    v91.TextColor3 = v91.TextColor3 or Color3_new_ret;
    v91.TextStrokeColor3 = Color3_new_ret2;

    if v91.TextStrokeTransparency == nil then
        v91.TextStrokeTransparency = 0.55;
    end;

    local Instance_new_ret2 = Instance.new(v92);

    for i, v in v91 do
        Instance_new_ret2[i] = v;
    end;

    Instance_new_ret2.Parent = Bottom;
    v86.next = Instance_new_ret2;
    local next2 = v86.next;
    local UITextSizeConstraint2 = Instance.new("UITextSizeConstraint");

    for i, v in {
        MaxTextSize = 14
    } do
        UITextSizeConstraint2[i] = v;
    end;

    UITextSizeConstraint2.Parent = next2;
    local v93 = {
        Name = "Chapter",
        TextScaled = true,
        TextTransparency = 1,
        TextStrokeTransparency = 1,
        ZIndex = 4,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.3),
        Size = UDim2.fromScale(0.6, 0.03),
        FontFace = Font_new_ret2,
        TextColor3 = Color3_fromRGB_ret
    };
    local v94 = v93.Button and "TextButton" or "TextLabel";
    v93.Button = nil;
    v93.BackgroundTransparency = 1;
    v93.TextColor3 = v93.TextColor3 or Color3_new_ret;
    v93.TextStrokeColor3 = Color3_new_ret2;

    if v93.TextStrokeTransparency == nil then
        v93.TextStrokeTransparency = 0.55;
    end;

    local Instance_new_ret3 = Instance.new(v94);

    for i, v in v93 do
        Instance_new_ret3[i] = v;
    end;

    Instance_new_ret3.Parent = AlbieTalk;
    v86.chapter = Instance_new_ret3;
    local v95 = {
        Name = "Title",
        TextScaled = true,
        TextTransparency = 1,
        TextStrokeTransparency = 1,
        ZIndex = 4,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.37),
        Size = UDim2.fromScale(0.8, 0.08),
        FontFace = Font_new_ret
    };
    local v96 = v95.Button and "TextButton" or "TextLabel";
    v95.Button = nil;
    v95.BackgroundTransparency = 1;
    v95.TextColor3 = v95.TextColor3 or Color3_new_ret;
    v95.TextStrokeColor3 = Color3_new_ret2;

    if v95.TextStrokeTransparency == nil then
        v95.TextStrokeTransparency = 0.55;
    end;

    local Instance_new_ret4 = Instance.new(v96);

    for i, v in v95 do
        Instance_new_ret4[i] = v;
    end;

    Instance_new_ret4.Parent = AlbieTalk;
    v86.title = Instance_new_ret4;
    local v97 = {
        Name = "Say",
        BackgroundTransparency = 1,
        Visible = false,
        ZIndex = 3,
        AnchorPoint = Vector2.new(0.5, 1),
        Position = UDim2.new(0.5, 0, 0.9, -14),
        Size = UDim2.fromScale(0.78, 0),
        AutomaticSize = Enum.AutomaticSize.Y
    };
    local Frame = Instance.new("Frame");

    for i, v in v97 do
        Frame[i] = v;
    end;

    Frame.Parent = AlbieTalk;
    local v98 = {
        MaxSize = Vector2.new(980, (1 / 0))
    };
    local UISizeConstraint = Instance.new("UISizeConstraint");

    for i, v in v98 do
        UISizeConstraint[i] = v;
    end;

    UISizeConstraint.Parent = Frame;
    local v99 = {
        FillDirection = Enum.FillDirection.Vertical,
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        VerticalAlignment = Enum.VerticalAlignment.Bottom,
        Padding = UDim.new(0, 6),
        SortOrder = Enum.SortOrder.LayoutOrder
    };
    local UIListLayout = Instance.new("UIListLayout");

    for i, v in v99 do
        UIListLayout[i] = v;
    end;

    UIListLayout.Parent = Frame;
    v86.say = Frame;
    local v100 = {
        Name = "Speaker",
        RichText = true,
        TextSize = 16,
        TextStrokeTransparency = 0.6,
        LayoutOrder = 1,
        ZIndex = 3,
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        FontFace = Font_new_ret
    };
    local v101 = v100.Button and "TextButton" or "TextLabel";
    v100.Button = nil;
    v100.BackgroundTransparency = 1;
    v100.TextColor3 = v100.TextColor3 or Color3_new_ret;
    v100.TextStrokeColor3 = Color3_new_ret2;

    if v100.TextStrokeTransparency == nil then
        v100.TextStrokeTransparency = 0.55;
    end;

    local Instance_new_ret5 = Instance.new(v101);

    for i, v in v100 do
        Instance_new_ret5[i] = v;
    end;

    Instance_new_ret5.Parent = Frame;
    v86.speaker = Instance_new_ret5;
    local v102 = {
        Name = "Body",
        TextWrapped = true,
        TextSize = 24,
        TextStrokeTransparency = 0.45,
        LayoutOrder = 2,
        ZIndex = 3,
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        FontFace = Font_new_ret3
    };
    local v103 = v102.Button and "TextButton" or "TextLabel";
    v102.Button = nil;
    v102.BackgroundTransparency = 1;
    v102.TextColor3 = v102.TextColor3 or Color3_new_ret;
    v102.TextStrokeColor3 = Color3_new_ret2;

    if v102.TextStrokeTransparency == nil then
        v102.TextStrokeTransparency = 0.55;
    end;

    local Instance_new_ret6 = Instance.new(v103);

    for i, v in v102 do
        Instance_new_ret6[i] = v;
    end;

    Instance_new_ret6.Parent = Frame;
    v86.body = Instance_new_ret6;
    local v104 = {
        Name = "Stories",
        BackgroundTransparency = 1,
        Visible = false,
        ZIndex = 4,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(0.5, 0.66)
    };
    local Frame2 = Instance.new("Frame");

    for i, v in v104 do
        Frame2[i] = v;
    end;

    Frame2.Parent = AlbieTalk;
    local v105 = {
        MaxSize = Vector2.new(560, 480),
        MinSize = Vector2.new(280, 220)
    };
    local UISizeConstraint2 = Instance.new("UISizeConstraint");

    for i, v in v105 do
        UISizeConstraint2[i] = v;
    end;

    UISizeConstraint2.Parent = Frame2;
    v86.menu = Frame2;
    local v106 = {
        Name = "Heading",
        Text = "ALBIE\'S STORIES",
        TextScaled = true,
        TextStrokeTransparency = 0.5,
        ZIndex = 4,
        Size = UDim2.fromScale(1, 0.12),
        FontFace = Font_new_ret
    };
    local v107 = v106.Button and "TextButton" or "TextLabel";
    v106.Button = nil;
    v106.BackgroundTransparency = 1;
    v106.TextColor3 = v106.TextColor3 or Color3_new_ret;
    v106.TextStrokeColor3 = Color3_new_ret2;

    if v106.TextStrokeTransparency == nil then
        v106.TextStrokeTransparency = 0.55;
    end;

    local Instance_new_ret7 = Instance.new(v107);

    for i, v in v106 do
        Instance_new_ret7[i] = v;
    end;

    Instance_new_ret7.Parent = Frame2;
    v86.menuTitle = Instance_new_ret7;
    local v108 = {
        Name = "Sub",
        TextScaled = true,
        TextStrokeTransparency = 0.6,
        ZIndex = 4,
        Position = UDim2.fromScale(0, 0.13),
        Size = UDim2.fromScale(1, 0.06),
        FontFace = Font_new_ret2,
        TextColor3 = Color3_fromRGB_ret
    };
    local v109 = v108.Button and "TextButton" or "TextLabel";
    v108.Button = nil;
    v108.BackgroundTransparency = 1;
    v108.TextColor3 = v108.TextColor3 or Color3_new_ret;
    v108.TextStrokeColor3 = Color3_new_ret2;

    if v108.TextStrokeTransparency == nil then
        v108.TextStrokeTransparency = 0.55;
    end;

    local Instance_new_ret8 = Instance.new(v109);

    for i, v in v108 do
        Instance_new_ret8[i] = v;
    end;

    Instance_new_ret8.Parent = Frame2;
    v86.menuSub = Instance_new_ret8;
    local v110 = {
        Name = "Days",
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 3,
        ZIndex = 4,
        Position = UDim2.fromScale(0, 0.23),
        Size = UDim2.fromScale(1, 0.62),
        ScrollBarImageColor3 = Color3_fromRGB_ret,
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        CanvasSize = UDim2.new(),
        ScrollingDirection = Enum.ScrollingDirection.Y
    };
    local ScrollingFrame = Instance.new("ScrollingFrame");

    for i, v in v110 do
        ScrollingFrame[i] = v;
    end;

    ScrollingFrame.Parent = Frame2;
    v86.list = ScrollingFrame;
    local list = v86.list;
    local v111 = {
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        Padding = UDim.new(0, 4),
        SortOrder = Enum.SortOrder.LayoutOrder
    };
    local UIListLayout2 = Instance.new("UIListLayout");

    for i, v in v111 do
        UIListLayout2[i] = v;
    end;

    UIListLayout2.Parent = list;
    local v112 = {
        Button = true,
        Name = "Done",
        Text = "LEAVE",
        TextScaled = true,
        ZIndex = 4,
        AnchorPoint = Vector2.new(0.5, 1),
        Position = UDim2.fromScale(0.5, 1),
        Size = UDim2.fromScale(0.5, 0.08),
        FontFace = Font_new_ret,
        TextColor3 = Color3.fromRGB(200, 200, 206)
    };
    local v113 = v112.Button and "TextButton" or "TextLabel";
    v112.Button = nil;
    v112.BackgroundTransparency = 1;
    v112.TextColor3 = v112.TextColor3 or Color3_new_ret;
    v112.TextStrokeColor3 = Color3_new_ret2;

    if v112.TextStrokeTransparency == nil then
        v112.TextStrokeTransparency = 0.55;
    end;

    local Instance_new_ret9 = Instance.new(v113);

    for i, v in v112 do
        Instance_new_ret9[i] = v;
    end;

    Instance_new_ret9.Parent = Frame2;
    v86.menuLeave = Instance_new_ret9;
    local v114 = {
        Name = "Toast",
        TextScaled = true,
        TextTransparency = 1,
        TextStrokeTransparency = 1,
        ZIndex = 4,
        AnchorPoint = Vector2.new(0.5, 0),
        Position = UDim2.new(0.5, 0, 0.1, 18),
        Size = UDim2.fromScale(0.6, 0.06),
        FontFace = Font_new_ret,
        TextColor3 = Color3_fromRGB_ret
    };
    local v115 = v114.Button and "TextButton" or "TextLabel";
    v114.Button = nil;
    v114.BackgroundTransparency = 1;
    v114.TextColor3 = v114.TextColor3 or Color3_new_ret;
    v114.TextStrokeColor3 = Color3_new_ret2;

    if v114.TextStrokeTransparency == nil then
        v114.TextStrokeTransparency = 0.55;
    end;

    local Instance_new_ret10 = Instance.new(v115);

    for i, v in v114 do
        Instance_new_ret10[i] = v;
    end;

    Instance_new_ret10.Parent = AlbieTalk;
    v86.toast = Instance_new_ret10;
    v86.blip = gameSound("04_UI", "Hover", 0.22, nil);
    v86.sting = gameSound("04_UI", "Notice", 0.5, nil);
    v86.click = gameSound("04_UI", "Click", 0.35, nil);

    for _, v in { v86.blip, v86.sting, v86.click } do
        v.Parent = AlbieTalk;
    end;

    AlbieTalk.Parent = LocalPlayer:WaitForChild("PlayerGui");

    return v86;
end;

for _, v in { LeaderboardConfig.Boards or {}, LeaderboardConfig.EventBoards or {} } do
    for _, v2 in v do
        if type(v2) == "table" and type(v2.ModelName) == "string" then
            u85[v2.ModelName] = true;
        end;
    end;
end;

local u116 = setmetatable({}, {
    __mode = "k"
});
local u117 = setmetatable({}, {
    __mode = "k"
});
local u118 = setmetatable({}, {
    __mode = "k"
});
local u119 = {};

local function leftover(p120) -- Line: 636
    return p120 >= 1 and 0 or p120;
end;

local function copied(p121) -- Line: 641
    -- upvalues: LocalPlayer (copy)
    local v122 = LocalPlayer:FindFirstChildOfClass("PlayerGui");

    if not v122 then
        return false;
    end;

    for _, child in v122:GetChildren() do
        if child ~= p121 and (child:IsA("SurfaceGui") and child.Adornee == p121.Parent) then
            return true;
        end;
    end;

    return false;
end;

local function remember(p123) -- Line: 653
    -- upvalues: u116 (copy)
    for i, v in p123.saved do
        if u116[i] == nil then
            u116[i] = v;
        end;
    end;
end;

local function sweepLeftovers(p124) -- Line: 663
    -- upvalues: u13 (ref), u119 (copy), u116 (copy), u117 (copy), u118 (copy), LocalLooks (copy), copied (copy)
    if u13 then
        return;
    end;

    for _, v in u119 do
        if type(v) == "number" and os.clock() < v then
            return;
        end;
    end;

    for i in u119 do
        pcall(i.restore, i, true);
        u119[i] = nil;
    end;

    if next(u116) == nil and (next(u117) == nil and next(u118) == nil) then
        return;
    end;

    local u125 = 0;

    local function check(u126, u127, p128) -- Line: 681
        -- upvalues: LocalLooks (ref), u125 (ref)
        local success, result = pcall(function() -- Line: 682
            -- upvalues: u126 (copy)
            return u126.LocalTransparencyModifier;
        end);

        if success and (u126.Parent and (p128(result, u127) and not LocalLooks.has(u126, "LocalTransparencyModifier"))) then
            pcall(function() -- Line: 686
                -- upvalues: u126 (copy), u127 (copy)
                u126.LocalTransparencyModifier = u127;
            end);
            u125 = u125 + 1;
        end;
    end;

    for i, v in u116 do
        check(i, v, function(p129, p130) -- Line: 694
            local v131;

            if p129 >= 1 then
                v131 = p130 < 1;
            else
                v131 = false;
            end;

            return v131;
        end);
    end;

    for i, v in u117 do
        check(i, v, function(p132, p133) -- Line: 700
            return math.abs(p132 - p133) > 0.001;
        end);
    end;

    for i, v in u118 do
        local u134 = v.wanted and not copied(i);

        if i.Parent and i.Enabled ~= u134 then
            pcall(function() -- Line: 707
                -- upvalues: i (copy), u134 (copy)
                i.Enabled = u134;
            end);
            u125 = u125 + 1;
        end;
    end;

    table.clear(u116);
    table.clear(u117);
    table.clear(u118);

    if u125 > 0 then
        warn(("[Albie] %d hidden parts were still hidden (%s): shown again"):format(u125, p124));
    end;
end;

local function boardsNear(p135) -- Line: 721
    -- upvalues: u85 (copy)
    local v136 = {};
    local Lobby = workspace:FindFirstChild("Lobby");
    local v137 = {};
    local v138;

    if Lobby then
        v138 = Lobby:FindFirstChild("Interactables");
    else
        v138 = Lobby;
    end;

    v137[1], v137[2], v137[3] = v138, Lobby, workspace;

    for _, v in v137 do
        for _, child in v:GetChildren() do
            if child:IsA("Model") and (not table.find(v136, child) and (u85[child.Name] or (child:GetAttribute("LeaderboardKey") ~= nil or child:FindFirstChild("LeaderboardKey") ~= nil))) then
                local success, result = pcall(child.GetBoundingBox, child);

                if success and (result.Position - p135).Magnitude <= 40 then
                    table.insert(v136, child);
                end;
            end;
        end;
    end;

    return v136;
end;

local u139 = {};
u139.__index = u139;

function u139.new() -- Line: 746
    -- upvalues: u139 (copy)
    return setmetatable({
        alpha = 0,
        saved = {},
        models = {},
        guis = {}
    }, u139);
end;

function u139.suppress(p140, u141) -- Line: 754
    -- upvalues: u118 (copy)
    if p140.guis[u141] then
        return;
    end;

    local u142 = {
        own = 0,
        wanted = u141.Enabled
    };
    p140.guis[u141] = u142;
    u118[u141] = u142;

    local function off() -- Line: 761
        -- upvalues: u141 (copy), u142 (copy)
        if u141.Enabled then
            local v143 = u142;
            v143.own = v143.own + 1;
            u141.Enabled = false;
        end;
    end;

    u142.connection = u141:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 767
        -- upvalues: u141 (copy), u142 (copy)
        if u141.Enabled or u142.own <= 0 then
            u142.wanted = u141.Enabled;

            if u141.Enabled then
                local v144 = u142;
                v144.own = v144.own + 1;
                u141.Enabled = false;
            end;

            return;
        end;

        local v145 = u142;
        v145.own = v145.own - 1;
    end);

    if u141.Enabled then
        u142.own = u142.own + 1;
        u141.Enabled = false;
    end;
end;

function u139.apply(p146, u147) -- Line: 777
    p146.alpha = u147;

    for i, v in p146.saved do
        pcall(function() -- Line: 780
            -- upvalues: i (copy), v (copy), u147 (copy)
            i.LocalTransparencyModifier = v + (1 - v) * u147;
        end);
    end;
end;

function u139.run(u148, u149, u150, u151) -- Line: 786
    -- upvalues: RunService (copy)
    if u148.connection then
        u148.connection:Disconnect();
        u148.connection = nil;
    end;

    local alpha = u148.alpha;
    local os_clock_ret = os.clock();
    u148.connection = RunService.Heartbeat:Connect(function() -- Line: 792
        -- upvalues: os_clock_ret (copy), u150 (copy), u148 (copy), alpha (copy), u149 (copy), u151 (copy)
        local v152 = (os.clock() - os_clock_ret) / u150;
        local math_clamp_ret = math.clamp(v152, 0, 1);
        local apply = u148.apply;
        local math_clamp_ret2 = math.clamp(math_clamp_ret, 0, 1);
        local success = pcall(apply, u148, alpha + (u149 - alpha) * (math_clamp_ret2 * math_clamp_ret2 * (3 - 2 * math_clamp_ret2)));

        if math_clamp_ret >= 1 or not success then
            if u148.connection then
                u148.connection:Disconnect();
                u148.connection = nil;
            end;

            if u151 then
                u151();
            end;
        end;
    end);
end;

function u139.sweep(p153, p154) -- Line: 807
    -- upvalues: boardsNear (copy), LocalLooks (copy), leftover (copy), u117 (copy)
    if p153.restoring then
        return;
    end;

    for _, v in boardsNear(p154) do
        p153.models[v] = true;

        for _, descendant in v:GetDescendants() do
            if (descendant:IsA("BasePart") or descendant:IsA("Decal")) and p153.saved[descendant] == nil then
                local v155 = LocalLooks.hold(descendant, "LocalTransparencyModifier", p153, leftover);
                p153.saved[descendant] = v155;

                if u117[descendant] == nil then
                    u117[descendant] = v155;
                end;

                descendant.LocalTransparencyModifier = v155 + (1 - v155) * p153.alpha;
            elseif (descendant:IsA("SurfaceGui") or descendant:IsA("BillboardGui")) and not p153.guis[descendant] then
                p153:suppress(descendant);
            end;
        end;
    end;
end;

function u139.start(p156, p157) -- Line: 827
    -- upvalues: u119 (copy)
    u119[p156] = true;
    p156:sweep(p157);
    p156:run(1, 0.4);
end;

function u139.restore(u158, p159) -- Line: 834
    -- upvalues: u119 (copy), copied (copy), LocalLooks (copy), sweepLeftovers (copy)
    if u158.released then
        return;
    end;

    u158.restoring = true;

    local function finish() -- Line: 839
        -- upvalues: u158 (copy), u119 (ref), copied (ref), LocalLooks (ref), sweepLeftovers (ref)
        if u158.released then
            return;
        end;

        u158.released = true;
        u119[u158] = nil;

        if u158.connection then
            u158.connection:Disconnect();
            u158.connection = nil;
        end;

        for i, v in u158.guis do
            v.connection:Disconnect();
            pcall(function() -- Line: 851
                -- upvalues: i (copy), v (copy), copied (ref)
                local v160 = v.wanted and not copied(i);
                i.Enabled = v160;
            end);
        end;

        table.clear(u158.guis);

        for i in u158.saved do
            local v161, u162 = LocalLooks.release(i, "LocalTransparencyModifier", u158);

            if v161 then
                pcall(function() -- Line: 860
                    -- upvalues: i (copy), u162 (copy)
                    i.LocalTransparencyModifier = u162;
                end);
            end;
        end;

        table.clear(u158.saved);
        table.clear(u158.models);
        task.defer(sweepLeftovers, "after a talk");
    end;

    if p159 or u158.alpha <= 0 then
        finish();

        return;
    end;

    u119[u158] = os.clock() + 0.4 + 2;
    u158:run(0, 0.4, finish);
end;

LocalPlayer:GetAttributeChangedSignal("InMatch"):Connect(function() -- Line: 876
    -- upvalues: sweepLeftovers (copy)
    task.defer(sweepLeftovers, "match");
end);
Session:GetAttributeChangedSignal("MapChanging"):Connect(function() -- Line: 879
    -- upvalues: sweepLeftovers (copy)
    task.defer(sweepLeftovers, "map change");
end);
LocalPlayer.CharacterAdded:Connect(function() -- Line: 882
    -- upvalues: sweepLeftovers (copy)
    task.defer(sweepLeftovers, "respawn");
end);
task.spawn(function() -- Line: 885
    -- upvalues: sweepLeftovers (copy)
    while true do
        task.wait(5);
        sweepLeftovers("check");
    end;
end);
local u184 = {
    establish = function(p163, p164) -- Line: 896, Name: establish
        local v165 = (p163.a + p163.p) / 2;
        local v166 = p163.fwd * 9 + p163.right * p163.s * 4 + Vector3.new(0, 2.6, 0);
        local v167 = CFrame.Angles(0, 0.045 * p164 * p163.s, 0):VectorToWorldSpace(v166);

        return p163.a + v167, v165 - Vector3.new(0, 0.6, 0);
    end,

    albieClose = function(p168, p169) -- Line: 902, Name: albieClose
        return p168.a + p168.fwd * (4.8 - 0.1 * p169) + p168.right * p168.s * (1.7 + 0.05 * p169) + Vector3.new(0, 0.6, 0), p168.a - Vector3.new(0, 0.35, 0);
    end,

    albieWide = function(p170, p171) -- Line: 905, Name: albieWide
        return p170.a + p170.fwd * (6.8 - 0.16 * p171) + p170.right * p170.s * 2.6 + Vector3.new(0, 1.1, 0), p170.a - Vector3.new(0, 0.8, 0);
    end,

    two = function(p172, p173) -- Line: 908, Name: two
        local v174 = (p172.a + p172.p) / 2;

        return v174 + p172.fwd * (p172.d * 0.5 + 6.5) + p172.right * p172.s * (1.2 - 0.12 * p173) + Vector3.new(0, 1.4, 0), v174 - Vector3.new(0, 0.7, 0);
    end,

    overAlbie = function(p175, p176) -- Line: 913, Name: overAlbie
        local v177 = p175.toward:Cross(Vector3.new(0, 1, 0)) * p175.s;

        return p175.a - p175.toward * (2.3 - 0.08 * p176) + v177 * 1.3 + Vector3.new(0, 0.8, 0), p175.p - Vector3.new(0, 0.45, 0);
    end,

    playerClose = function(p178, p179) -- Line: 918, Name: playerClose
        local v180 = p178.toward:Cross(Vector3.new(0, 1, 0)) * p178.s;

        return p178.p - p178.toward * (3 - 0.08 * p179) + v180 * (0.9 + 0.06 * p179) + Vector3.new(0, 0.1, 0), p178.p - Vector3.new(0, 0.45, 0);
    end,

    overPlayer = function(p181, p182) -- Line: 923, Name: overPlayer
        local v183 = p181.toward:Cross(Vector3.new(0, 1, 0)) * p181.s;

        return p181.p + p181.toward * (4 - 0.12 * p182) - v183 * 2.1 + Vector3.new(0, 1.1, 0), p181.a - Vector3.new(0, 0.6, 0);
    end
};
local u185 = { "albieClose", "overPlayer", "albieWide", "two" };
local u186 = { "overAlbie", "playerClose" };
local u187 = { "two", "albieWide", "albieClose" };

function u184.farewell(p188, p189) -- Line: 933
    return p188.a + p188.fwd * (4.5 + p189 * 1.4) + p188.right * p188.s * (1.5 + p189 * 0.3) + Vector3.new(0, 1, 0) * (0.6 + p189 * 0.45), p188.a - Vector3.new(0, 1, 0) * (0.4 - math.min(p189, 4) * 0.05);
end;

local u190 = 0;
local u191 = nil;

local function showGems(u192) -- Line: 940
    -- upvalues: Interface (copy)
    local success, result = pcall(function() -- Line: 943
        -- upvalues: Interface (ref), u192 (copy)
        require(Interface:WaitForChild("ClaimPop")).show({}, 0, u192, nil, {
            heading = "A GIFT FROM ALBIE"
        });
    end);

    if not success then
        warn("albie\'s gems popup failed:", result);
    end;
end;

local function talk(u193, u194, u195) -- Line: 954
    -- upvalues: u13 (ref), LocalPlayer (copy), AlbieRemote (copy), u10 (ref), LocalHide (copy), u139 (copy), RunService (copy), u116 (copy), u191 (ref), u59 (copy), sweepLeftovers (copy), u36 (ref), presence (copy), u190 (ref), showGems (copy), buildGui (copy), CreatorVisibility (copy), gameSound (copy), TweenService (copy), u184 (copy), u185 (copy), u186 (copy), u187 (copy), utf8_char_ret (copy), Color3_new_ret (copy), Color3_fromRGB_ret2 (copy), Font_new_ret2 (copy), Color3_new_ret2 (copy), Color3_fromRGB_ret (copy), Font_new_ret (copy), Session (copy), UserInputService (copy)
    if u13 then
        return;
    end;

    if LocalPlayer:GetAttribute("CutsceneActive") == true then
        AlbieRemote:FireServer("Left", u193);

        return;
    end;

    local Character = LocalPlayer.Character;
    local u196;

    if Character then
        u196 = Character:FindFirstChildOfClass("Humanoid");
    else
        u196 = Character;
    end;

    local u197;

    if Character then
        u197 = Character:FindFirstChild("HumanoidRootPart");
    else
        u197 = Character;
    end;

    local u198;

    if Character then
        u198 = Character:FindFirstChild("Head");
    else
        u198 = Character;
    end;

    local u199 = u10 and u10:FindFirstChild("Head");

    if type(u194) ~= "table" or (type(u194.chapters) ~= "table" or type(u194.total) ~= "number") then
        AlbieRemote:FireServer("Left", u193);

        return;
    end;

    local u200;

    if u193 > 0 then
        u200 = u194.chapters[u193];
    else
        u200 = nil;
    end;

    local u201;

    if u200 then
        u201 = u200.lines;
    elseif type(u194.opening) == "table" then
        u201 = u194.opening;
    else
        u201 = nil;
    end;

    if not ((u193 <= 0 or u201) and (u196 and (u197 and (u198 and u199)))) then
        AlbieRemote:FireServer("Left", u193);

        return;
    end;

    u13 = true;
    LocalPlayer:SetAttribute("AlbieTalking", true);
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local u202 = { workspace_CurrentCamera.CameraType, workspace_CurrentCamera.FieldOfView };
    local u203 = {};
    local u204 = nil;
    local u205 = nil;
    local u206 = nil;
    local u207 = nil;
    local u208 = nil;
    local u209 = LocalHide.new();
    local u210 = u139.new();
    local u211 = false;
    local DisplayName = LocalPlayer.DisplayName;
    local Attribute = LocalPlayer:GetAttribute("AlbieTotal");
    local u212;

    if type(Attribute) == "number" then
        u212 = Attribute <= (tonumber(LocalPlayer:GetAttribute("AlbieChapter")) or 0);
    else
        u212 = false;
    end;

    local function cleanup(u213) -- Line: 993
        -- upvalues: u211 (ref), RunService (ref), u203 (copy), u207 (ref), u210 (copy), u209 (copy), u116 (ref), u205 (ref), u206 (ref), workspace_CurrentCamera (copy), u202 (copy), LocalPlayer (ref), u204 (ref), u191 (ref), u59 (ref), AlbieRemote (ref), u193 (copy), u13 (ref), sweepLeftovers (ref), u36 (ref), presence (ref), u190 (ref), showGems (ref)
        if u211 then
            return;
        end;

        u211 = true;

        local function undo(p214, p215) -- Line: 999
            local success, result = pcall(p215);

            if not success then
                warn("albie\'s talk couldn\'t put back " .. p214 .. ":", result);
            end;
        end;

        local success, result = pcall(function() -- Line: 1005
            -- upvalues: RunService (ref)
            RunService:UnbindFromRenderStep("AlbieTalk");
        end);

        if not success then
            warn("albie\'s talk couldn\'t put back the camera step:", result);
        end;

        for _, v in u203 do
            v:Disconnect();
        end;

        table.clear(u203);

        if u207 then
            local success2, result2 = pcall(function() -- Line: 1013
                -- upvalues: u207 (ref)
                u207:Cancel();
            end);

            if not success2 then
                warn("albie\'s talk couldn\'t put back the zoom:", result2);
            end;
        end;

        local success2, result2 = pcall(function() -- Line: 1017
            -- upvalues: u210 (ref), u213 (copy)
            u210:restore(u213 == "instant");
        end);

        if not success2 then
            warn("albie\'s talk couldn\'t put back the leaderboards:", result2);
        end;

        local success3, result3 = pcall(function() -- Line: 1020
            -- upvalues: u209 (ref), u116 (ref)
            for i, v in u209.saved do
                if u116[i] == nil then
                    u116[i] = v;
                end;
            end;

            u209:restore();
        end);

        if not success3 then
            warn("albie\'s talk couldn\'t put back the other players:", result3);
        end;

        if u205 then
            local success4, result4 = pcall(function() -- Line: 1025
                -- upvalues: u205 (ref)
                u205:destroy();
            end);

            if not success4 then
                warn("albie\'s talk couldn\'t put back the UI:", result4);
            end;
        end;

        if u206 then
            pcall(u206.Enable, u206);
        end;

        local success4, result4 = pcall(function() -- Line: 1032
            -- upvalues: workspace_CurrentCamera (ref), u202 (ref), LocalPlayer (ref)
            local v216;

            if u202[1] == Enum.CameraType.Scriptable then
                v216 = Enum.CameraType.Custom;
            else
                v216 = u202[1];
            end;

            workspace_CurrentCamera.CameraType = v216;
            local v217 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid");

            if v217 then
                workspace_CurrentCamera.CameraSubject = v217;
            end;

            workspace_CurrentCamera.FieldOfView = u202[2];
        end);

        if not success4 then
            warn("albie\'s talk couldn\'t put back the camera:", result4);
        end;

        if u204 then
            pcall(function() -- Line: 1041
                -- upvalues: u204 (ref)
                u204.gui:Destroy();
            end);
            u204 = nil;
        end;

        u191 = nil;
        u59.talk = false;
        u59.want = nil;
        LocalPlayer:SetAttribute("AlbieTalking", nil);
        AlbieRemote:FireServer("Left", u193);
        u13 = false;
        task.defer(sweepLeftovers, "after a talk");
        u36 = nil;

        if not u13 then
            local v218 = "Shown";
            local Attribute2 = LocalPlayer:GetAttribute("AlbieTotal");
            local v219;

            if type(Attribute2) == "number" then
                v219 = Attribute2 <= (tonumber(LocalPlayer:GetAttribute("AlbieChapter")) or 0);
            else
                v219 = false;
            end;

            if v219 then
                local Attribute3 = LocalPlayer:GetAttribute("AlbieGoneDay");
                local Attribute4 = LocalPlayer:GetAttribute("AlbieTotal");
                local v220;

                if type(Attribute4) == "number" then
                    v220 = Attribute4 <= (tonumber(LocalPlayer:GetAttribute("AlbieChapter")) or 0);
                else
                    v220 = false;
                end;

                local v221;

                if v220 and type(Attribute3) == "number" then
                    v221 = workspace:GetServerTimeNow() // 86400 - Attribute3;
                else
                    v221 = nil;
                end;

                local v222 = v221 or 0;
                v218 = v222 >= 4 and "Gone" or (v222 >= 1 and "Ghost" or "Vanished");
            end;

            if v218 ~= u36 then
                u36 = v218;
                presence(v218);
            end;
        end;

        if u190 > 0 then
            local v223 = u190;
            u190 = 0;
            task.delay(0.3, showGems, v223);
        end;
    end;

    local success, result = pcall(function() -- Line: 1064
        -- upvalues: u204 (ref), buildGui (ref), LocalPlayer (ref), u205 (ref), CreatorVisibility (ref), u206 (ref), u209 (copy), u210 (copy), u199 (copy), u195 (copy), u197 (copy), Character (copy), u211 (ref), AlbieRemote (ref), u193 (copy), u212 (copy), presence (ref), workspace_CurrentCamera (copy), u208 (ref), gameSound (ref), TweenService (ref)
        u204 = buildGui();
        local v224 = u204;
        local Y = v224.gui.AbsoluteSize.Y;
        local body = v224.body;
        local math_floor_ret = math.floor(Y * 0.036);
        body.TextSize = math.clamp(math_floor_ret, 16, 30);
        local speaker = v224.speaker;
        local math_floor_ret2 = math.floor(Y * 0.022);
        speaker.TextSize = math.clamp(math_floor_ret2, 12, 18);

        if LocalPlayer:GetAttribute("CreatorUIHidden") ~= true then
            u205 = CreatorVisibility.new(LocalPlayer);
            u205:setHidden(true);
        end;

        local success, result = pcall(function() -- Line: 1071
            -- upvalues: LocalPlayer (ref)
            return require(LocalPlayer:WaitForChild("PlayerScripts"):FindFirstChild("PlayerModule")):GetControls();
        end);

        if success and result then
            u206 = result;
            pcall(u206.Disable, u206);
        end;

        u209:sweep();
        u210:start(u199.Position);

        if typeof(u195) == "CFrame" then
            u197.AssemblyLinearVelocity = Vector3.new(0, 0, 0);
            u197.AssemblyAngularVelocity = Vector3.new(0, 0, 0);
            Character:PivotTo(u195 * u197.CFrame:Inverse() * Character:GetPivot());
            task.delay(0.25, function() -- Line: 1087
                -- upvalues: u211 (ref), AlbieRemote (ref), u193 (ref)
                if not u211 then
                    AlbieRemote:FireServer("Moved", u193);
                end;
            end);
        else
            local Position = u199.Position;
            u197.CFrame = CFrame.lookAt(u197.Position, (Vector3.new(Position.X, u197.Position.Y, Position.Z)));
        end;

        if u212 then
            presence("Memory");
        end;

        workspace_CurrentCamera.CameraType = Enum.CameraType.Scriptable;
        u208 = gameSound("02_Movement", "SprintWind", 0, 0.75, u204.gui);

        if u208 then
            u208.Looped = true;
            u208:Play();
            TweenService:Create(u208, TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Volume = 0.12
            }):Play();
        end;
    end);

    if not success then
        warn("albie\'s talk couldn\'t start:", result);
        cleanup("instant");

        return;
    end;

    u59.talk = true;

    u191 = function(p225) -- Line: 1114
        -- upvalues: u204 (ref), TweenService (ref), gameSound (ref)
        if not u204 then
            return;
        end;

        u204.toast.Text = p225;
        u204.toast.TextTransparency = 1;
        TweenService:Create(u204.toast, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            TextTransparency = 0,
            TextStrokeTransparency = 0.5
        }):Play();
        local v226 = gameSound("09_Collectibles", "GemCollect", 0.6, 1, u204.gui);

        if v226 then
            v226:Play();
        end;

        task.delay(3, function() -- Line: 1125
            -- upvalues: u204 (ref), TweenService (ref)
            if u204 then
                TweenService:Create(u204.toast, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    TextTransparency = 1,
                    TextStrokeTransparency = 1
                }):Play();
            end;
        end);
    end;

    local u227 = "establish";
    local os_clock_ret = os.clock();
    local CFrame2 = workspace_CurrentCamera.CFrame;
    local os_clock_ret2 = os.clock();
    local u228 = 1.3;
    local u229 = 0;
    local u230 = 0;
    local u231 = {
        s = math.random() < 0.5 and 1 or -1
    };

    local function frame() -- Line: 1137
        -- upvalues: u231 (copy), u199 (copy), u198 (copy), u10 (ref)
        u231.a = u199.Position;
        u231.p = u198.Position;
        local v232 = u10:GetPivot().LookVector * Vector3.new(1, 0, 1);
        u231.fwd = v232.Magnitude <= 0.01 and Vector3.new(0, 0, 1) or v232.Unit;
        u231.right = u231.fwd:Cross(Vector3.new(0, 1, 0));
        local v233 = (u231.p - u231.a) * Vector3.new(1, 0, 1);
        u231.d = v233.Magnitude;
        local v234;

        if u231.d > 0.1 then
            v234 = v233.Unit;
        else
            v234 = -u231.fwd;
        end;

        u231.toward = v234;

        return u231;
    end;

    local RaycastParams_new_ret = RaycastParams.new();
    RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
    RaycastParams_new_ret.IgnoreWater = true;

    local function reach(p235, p236) -- Line: 1153
        -- upvalues: LocalPlayer (ref), u10 (ref), u210 (copy), RaycastParams_new_ret (copy)
        local v237 = { LocalPlayer.Character, u10 };

        for i in u210.models do
            table.insert(v237, i);
        end;

        for i = 1, 5 do
            RaycastParams_new_ret.FilterDescendantsInstances = v237;
            local v238 = workspace:Raycast(p235, p236 - p235, RaycastParams_new_ret);

            if not v238 then
                return p236, 1;
            end;

            local v239 = v238.Instance:FindFirstAncestorOfClass("Model");

            if v238.Instance.Transparency < 0.9 and not (v239 and v239:FindFirstChildOfClass("Humanoid")) then
                local Magnitude = (p236 - p235).Magnitude;
                local math_max_ret = math.max(0, v238.Distance - 0.6);

                return p235 + (p236 - p235).Unit * math_max_ret, math_max_ret / math.max(Magnitude, 0.01);
            end;

            table.insert(v237, v238.Instance);
            local _ = i;
        end;

        return p236, 1;
    end;

    local function open(p240) -- Line: 1176
        -- upvalues: u184 (ref), frame (copy), reach (copy)
        local v241, v242 = u184[p240](frame(), 0);
        local _, v243 = reach(v242, v241);

        return v243 >= 0.7;
    end;

    local function setShot(p244, p245) -- Line: 1181
        -- upvalues: u227 (ref), os_clock_ret (ref), CFrame2 (ref), os_clock_ret2 (ref), u228 (ref), workspace_CurrentCamera (copy)
        if p244 == u227 then
            return;
        end;

        local os_clock_ret3 = os.clock();
        u227 = p244;
        os_clock_ret = os_clock_ret3;
        local CFrame3 = workspace_CurrentCamera.CFrame;
        local os_clock_ret4 = os.clock();
        CFrame2 = CFrame3;
        os_clock_ret2 = os_clock_ret4;
        u228 = p245 or 0.85;
    end;

    local function cut(p246) -- Line: 1188
        -- upvalues: u185 (ref), u186 (ref), u229 (ref), u230 (ref), u184 (ref), frame (copy), reach (copy), u187 (ref), u227 (ref), os_clock_ret (ref), CFrame2 (ref), os_clock_ret2 (ref), u228 (ref), workspace_CurrentCamera (copy)
        local v247;

        if p246 == "A" then
            v247 = u185;
        else
            v247 = u186;
        end;

        local v248;

        if p246 == "A" then
            u229 = u229 + 1;
            v248 = v247[(u229 - 1) % #v247 + 1];
        else
            u230 = u230 + 1;
            v248 = v247[(u230 - 1) % #v247 + 1];
        end;

        local v249, v250 = u184[v248](frame(), 0);
        local _, v251 = reach(v250, v249);

        if v251 < 0.7 then
            for _, v in u187 do
                if v ~= u227 then
                    local v252, v253 = u184[v](frame(), 0);
                    local _, v254 = reach(v253, v252);

                    if v254 >= 0.7 then
                        v248 = v;
                        break;
                    end;
                end;
            end;
        end;

        if v248 == u227 then
            return;
        end;

        local os_clock_ret3 = os.clock();
        u227 = v248;
        os_clock_ret = os_clock_ret3;
        local CFrame3 = workspace_CurrentCamera.CFrame;
        local os_clock_ret4 = os.clock();
        CFrame2 = CFrame3;
        os_clock_ret2 = os_clock_ret4;
        u228 = 0.85;
    end;

    local function place(p255) -- Line: 1209
        -- upvalues: u184 (ref), u227 (ref), frame (copy), os_clock_ret (ref), reach (copy), os_clock_ret2 (ref), u228 (ref), workspace_CurrentCamera (copy), CFrame2 (ref)
        local v256, v257 = u184[u227](frame(), p255 - os_clock_ret);
        local v258 = reach(v257, v256);
        local CFrame_Angles_ret = CFrame.Angles(math.sin(p255 * 0.7) * 0.004, math.sin(p255 * 0.5) * 0.006, 0);
        local v259 = CFrame.lookAt(v258, v257) * CFrame_Angles_ret;
        local math_clamp_ret = math.clamp((p255 - os_clock_ret2) / u228, 0, 1);
        local v260 = math_clamp_ret * math_clamp_ret * (3 - 2 * math_clamp_ret);

        if v260 < 1 then
            v259 = CFrame2:Lerp(v259, v260);
        end;

        workspace_CurrentCamera.CFrame = v259;
    end;

    local u261 = {
        mode = "idle",
        lines = nil,
        index = 0,
        typing = false,
        lineAt = 0,
        typedAt = 0,
        total = 0,
        shown = 0,
        titleUntil = 0
    };

    local function show(p262) -- Line: 1221
        -- upvalues: u261 (copy), DisplayName (copy), u204 (ref), utf8_char_ret (ref), Color3_new_ret (ref), Color3_fromRGB_ret2 (ref), u59 (ref), cut (copy)
        local v263 = u261.lines[p262];
        local v264 = v263[1] == "A";
        local v265 = v263[2]:gsub("{name}", DisplayName);
        local speaker = u204.speaker;
        local v266;

        if v264 then
            v266 = "ALBIE " .. utf8_char_ret .. "   <font color=\"#FFCD70\">OWNER</font>";
        else
            v266 = string.upper(DisplayName);
        end;

        speaker.Text = v266;
        local v267;

        if v264 then
            v267 = Color3_new_ret;
        else
            v267 = Color3_fromRGB_ret2;
        end;

        u204.speaker.TextColor3 = v267;
        u204.body.Text = v265;
        u204.body.MaxVisibleGraphemes = 0;
        u204.next.Visible = false;
        u204.say.Visible = true;
        u261.total = utf8.len(v265) or #v265;
        u261.shown = 0;
        u261.typing = true;
        u261.lineAt = os.clock();

        if u204.blip then
            u204.blip.PlaybackSpeed = v264 and 1.05 or 1.3;
        end;

        u59.want = (not v264 or math.random() < 0.55) and "Player" or nil;
        cut(v263[1]);
    end;

    local function advance() -- Line: 1244
        -- upvalues: u261 (copy), u204 (ref), show (copy)
        if u261.mode ~= "lines" or (u261.index == 0 or os.clock() < u261.titleUntil) then
            return;
        end;

        if u261.typing then
            u261.typing = false;
            u204.body.MaxVisibleGraphemes = -1;
            u261.typedAt = os.clock();
            u204.next.Visible = true;

            return;
        end;

        if u204.click then
            u204.click:Play();
        end;

        if u261.index >= #u261.lines then
            u261.mode = "done";

            return;
        end;

        local v268 = u261;
        v268.index = v268.index + 1;
        show(u261.index);
    end;

    local function runLines(p269, p270, p271) -- Line: 1266
        -- upvalues: u211 (ref), u261 (copy), u204 (ref), TweenService (ref), u227 (ref), os_clock_ret (ref), CFrame2 (ref), os_clock_ret2 (ref), u228 (ref), workspace_CurrentCamera (copy)
        if u211 then
            return "abort";
        end;

        u261.lines = p269;
        u261.index = 0;
        u261.typing = false;
        u261.titleUntil = os.clock() + (p271 and 1.4 or 0.2);

        if p271 then
            u204.chapter.Text = p270 or "";
            u204.title.Text = string.upper(p271);
            TweenService:Create(u204.chapter, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                TextTransparency = 0
            }):Play();
            TweenService:Create(u204.title, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                TextTransparency = 0,
                TextStrokeTransparency = 0.4
            }):Play();

            if u204.sting then
                u204.sting:Play();
            end;

            task.delay(0.8999999999999999, function() -- Line: 1280
                -- upvalues: u204 (ref), TweenService (ref)
                if u204 then
                    TweenService:Create(u204.chapter, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        TextTransparency = 1
                    }):Play();
                    TweenService:Create(u204.title, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        TextTransparency = 1,
                        TextStrokeTransparency = 1
                    }):Play();
                end;
            end);

            if u227 ~= "establish" then
                local os_clock_ret3 = os.clock();
                u227 = "establish";
                os_clock_ret = os_clock_ret3;
                local CFrame3 = workspace_CurrentCamera.CFrame;
                local os_clock_ret4 = os.clock();
                CFrame2 = CFrame3;
                os_clock_ret2 = os_clock_ret4;
                u228 = 1.1;
            end;
        end;

        u261.mode = "lines";

        while u261.mode == "lines" and not u211 do
            task.wait();
        end;

        if u204 then
            u204.say.Visible = false;
            u204.next.Visible = false;
        end;

        return u211 and "abort" or "done";
    end;

    local function runMenu(p272) -- Line: 1299
        -- upvalues: u211 (ref), u261 (copy), u59 (ref), u227 (ref), os_clock_ret (ref), CFrame2 (ref), os_clock_ret2 (ref), u228 (ref), workspace_CurrentCamera (copy), u204 (ref), LocalPlayer (ref), u194 (copy), Font_new_ret2 (ref), Color3_new_ret (ref), Color3_new_ret2 (ref), Color3_fromRGB_ret (ref)
        if u211 then
            return nil;
        end;

        u261.mode = "menu";
        u59.want = "Player";

        if u227 ~= "establish" then
            local os_clock_ret3 = os.clock();
            u227 = "establish";
            os_clock_ret = os_clock_ret3;
            local CFrame3 = workspace_CurrentCamera.CFrame;
            local os_clock_ret4 = os.clock();
            CFrame2 = CFrame3;
            os_clock_ret2 = os_clock_ret4;
            u228 = 1.4;
        end;

        for _, child in u204.list:GetChildren() do
            if child:IsA("GuiButton") then
                child:Destroy();
            end;
        end;

        local Attribute2 = LocalPlayer:GetAttribute("AlbieNextAt");
        local v273 = type(Attribute2) ~= "number" and 0 or Attribute2 - workspace:GetServerTimeNow();

        if u194.total <= p272 then
            u204.menuSub.Text = "ALL " .. u194.total .. " DAYS HEARD · PICK ONE TO HEAR AGAIN";
        elseif v273 > 0 then
            u204.menuSub.Text = string.format("DAY %d IN %dH %02dM · HEAR ONE AGAIN", p272 + 1, v273 // 3600, v273 % 3600 // 60);
        else
            u204.menuSub.Text = "PICK A DAY TO HEAR AGAIN";
        end;

        local math_floor_ret = math.floor(u204.gui.AbsoluteSize.Y * 0.05);
        local math_clamp_ret = math.clamp(math_floor_ret, 26, 40);
        local v274 = {};
        local u275 = nil;

        for i = p272, 1, -1 do
            local list = u204.list;
            local v276 = {
                Button = true,
                RichText = true,
                TextStrokeTransparency = 0.6,
                AutoButtonColor = false,
                ZIndex = 4,
                Name = "Day" .. i,
                Size = UDim2.new(1, -8, 0, math_clamp_ret),
                FontFace = Font_new_ret2,
                Text = string.format("<font color=\"#FFCD70\">DAY %d</font>   %s", i, string.upper(u194.chapters[i].title)),
                TextSize = math.floor(math_clamp_ret * 0.55),
                LayoutOrder = p272 - i
            };
            local v277 = v276.Button and "TextButton" or "TextLabel";
            v276.Button = nil;
            v276.BackgroundTransparency = 1;
            v276.TextColor3 = v276.TextColor3 or Color3_new_ret;
            v276.TextStrokeColor3 = Color3_new_ret2;

            if v276.TextStrokeTransparency == nil then
                v276.TextStrokeTransparency = 0.55;
            end;

            local Instance_new_ret = Instance.new(v277);
            local u278 = i;

            for i2, v in v276 do
                Instance_new_ret[i2] = v;
            end;

            Instance_new_ret.Parent = list;
            table.insert(v274, Instance_new_ret.MouseEnter:Connect(function() -- Line: 1337
                -- upvalues: Instance_new_ret (copy), Color3_fromRGB_ret (ref)
                Instance_new_ret.TextColor3 = Color3_fromRGB_ret;
            end));
            table.insert(v274, Instance_new_ret.MouseLeave:Connect(function() -- Line: 1340
                -- upvalues: Instance_new_ret (copy), Color3_new_ret (ref)
                Instance_new_ret.TextColor3 = Color3_new_ret;
            end));
            table.insert(v274, Instance_new_ret.Activated:Connect(function() -- Line: 1343
                -- upvalues: u275 (ref), u278 (copy)
                u275 = u278;
            end));
        end;

        table.insert(v274, u204.menuLeave.Activated:Connect(function() -- Line: 1347
            -- upvalues: u275 (ref)
            u275 = false;
        end));
        u204.menu.Visible = true;
        local os_clock_ret3 = os.clock();

        while u275 == nil and (not u211 and os.clock() - os_clock_ret3 < 90) do
            task.wait();
        end;

        for _, v in v274 do
            v:Disconnect();
        end;

        if u204 then
            u204.menu.Visible = false;

            if u275 and u204.click then
                u204.click:Play();
            end;
        end;

        u261.mode = "idle";

        return u275 or nil;
    end;

    local function farewell() -- Line: 1369
        -- upvalues: u211 (ref), u261 (copy), u59 (ref), u204 (ref), u227 (ref), os_clock_ret (ref), CFrame2 (ref), os_clock_ret2 (ref), u228 (ref), workspace_CurrentCamera (copy), u208 (ref), TweenService (ref), u231 (copy), u10 (ref), Color3_fromRGB_ret (ref), u212 (copy), Color3_new_ret (ref), Font_new_ret (ref), utf8_char_ret (ref), Color3_new_ret2 (ref), Font_new_ret2 (ref), gameSound (ref)
        if u211 then
            return;
        end;

        u261.mode = "farewell";
        u59.want = "Player";
        u204.say.Visible = false;
        u204.next.Visible = false;

        if u227 ~= "albieClose" then
            local os_clock_ret3 = os.clock();
            u227 = "albieClose";
            os_clock_ret = os_clock_ret3;
            local CFrame3 = workspace_CurrentCamera.CFrame;
            local os_clock_ret4 = os.clock();
            CFrame2 = CFrame3;
            os_clock_ret2 = os_clock_ret4;
            u228 = 1;
        end;

        local gui = u204.gui;

        if u208 then
            TweenService:Create(u208, TweenInfo.new(3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Volume = 0.65,
                PlaybackSpeed = 0.9
            }):Play();
        end;

        local Sound = Instance.new("Sound");
        Sound.SoundId = "rbxassetid://9043343295";
        Sound.Volume = 0.5;
        Sound.Parent = gui;
        Sound:Play();
        local v279 = u231.right * u231.s * 7 + Vector3.new(0, 2.2, 0);
        local v280 = {};
        local v281 = {};

        for _, descendant in u10:GetDescendants() do
            if descendant:IsA("BasePart") and descendant.Name ~= "HumanoidRootPart" then
                table.insert(v280, descendant);
                local ParticleEmitter = Instance.new("ParticleEmitter");
                ParticleEmitter.Name = "AlbieDust";
                ParticleEmitter.Texture = "rbxasset://textures/particles/smoke_main.dds";
                ParticleEmitter.Color = ColorSequence.new(Color3.fromRGB(255, 244, 220), Color3.fromRGB(190, 210, 255));
                ParticleEmitter.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.35), NumberSequenceKeypoint.new(1, 1) });
                ParticleEmitter.Size = NumberSequence.new(0.35, 1.4);
                ParticleEmitter.Lifetime = NumberRange.new(1.6, 2.6);
                ParticleEmitter.Speed = NumberRange.new(1, 3);
                ParticleEmitter.SpreadAngle = Vector2.new(60, 60);
                ParticleEmitter.Acceleration = v279;
                ParticleEmitter.RotSpeed = NumberRange.new(-90, 90);
                ParticleEmitter.LightEmission = 0.4;
                ParticleEmitter.Rate = 0;
                ParticleEmitter.Parent = descendant;
                local ParticleEmitter2 = Instance.new("ParticleEmitter");
                ParticleEmitter2.Name = "AlbieSpark";
                ParticleEmitter2.Texture = "rbxasset://textures/particles/sparkles_main.dds";
                ParticleEmitter2.Color = ColorSequence.new(Color3_fromRGB_ret);
                ParticleEmitter2.Size = NumberSequence.new(0.25, 0);
                ParticleEmitter2.Lifetime = NumberRange.new(1, 1.8);
                ParticleEmitter2.Speed = NumberRange.new(2, 5);
                ParticleEmitter2.SpreadAngle = Vector2.new(80, 80);
                ParticleEmitter2.Acceleration = v279;
                ParticleEmitter2.LightEmission = 1;
                ParticleEmitter2.Rate = 0;
                ParticleEmitter2.Parent = descendant;
                table.insert(v281, ParticleEmitter);
                table.insert(v281, ParticleEmitter2);
            end;
        end;

        local v282 = (1 / 0);
        local v283 = (-1 / 0);

        for _, v in v280 do
            v282 = math.min(v282, v.Position.Y);
            v283 = math.max(v283, v.Position.Y);
        end;

        local os_clock_ret3 = os.clock();
        local v284 = false;

        while not u211 do
            local v285 = os.clock() - os_clock_ret3;

            if v285 > 1.6 and (u227 ~= "farewell" and u227 ~= "farewell") then
                local os_clock_ret4 = os.clock();
                u227 = "farewell";
                os_clock_ret = os_clock_ret4;
                local CFrame3 = workspace_CurrentCamera.CFrame;
                local os_clock_ret5 = os.clock();
                CFrame2 = CFrame3;
                os_clock_ret2 = os_clock_ret5;
                u228 = 2.2;
            end;

            if v285 > 2.2 and not v284 then
                local Sound2 = Instance.new("Sound");
                Sound2.SoundId = "rbxassetid://9120718689";
                Sound2.Volume = 0.8;
                Sound2.Parent = gui;
                Sound2:Play();
                v284 = true;
            end;

            local v286 = false;

            for _, v in v280 do
                local v287 = (v.Position.Y - v282) / math.max(v283 - v282, 0.1);
                local math_clamp_ret = math.clamp((v285 - 0.8 - v287 * 1.8) / 1.6, 0, 1);
                local v288 = u212 and 0.55 or 0;
                v.LocalTransparencyModifier = v288 + (1 - v288) * math_clamp_ret;
                local AlbieDust = v:FindFirstChild("AlbieDust");
                local AlbieSpark = v:FindFirstChild("AlbieSpark");
                local v289 = math_clamp_ret > 0 and math_clamp_ret < 1 and 1 or 0;

                if AlbieDust then
                    AlbieDust.Rate = v289 * 26;
                end;

                if AlbieSpark then
                    AlbieSpark.Rate = v289 * 10;
                end;

                if math_clamp_ret < 1 then
                    v286 = true;
                end;
            end;

            if not v286 and v285 > 4.2 then
                break;
            end;

            task.wait();
        end;

        for _, v in v281 do
            v.Rate = 0;
        end;

        for _, descendant in u10:GetDescendants() do
            if descendant:IsA("Decal") then
                descendant.LocalTransparencyModifier = 1;
            elseif descendant:IsA("BillboardGui") then
                descendant.Enabled = false;
            end;
        end;

        if u211 then
            return;
        end;

        local v290 = {
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            ZIndex = 6,
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromScale(0.5, 0.5),
            Size = UDim2.fromScale(1.5, 1.5),
            BackgroundColor3 = Color3_new_ret
        };
        local Frame = Instance.new("Frame");

        for i, v in v290 do
            Frame[i] = v;
        end;

        Frame.Parent = gui;
        local v291 = {
            TextScaled = true,
            TextTransparency = 1,
            TextStrokeTransparency = 1,
            ZIndex = 7,
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromScale(0.5, 0.42),
            Size = UDim2.fromScale(0.6, 0.1),
            FontFace = Font_new_ret,
            Text = "albie " .. utf8_char_ret
        };
        local v292 = v291.Button and "TextButton" or "TextLabel";
        v291.Button = nil;
        v291.BackgroundTransparency = 1;
        v291.TextColor3 = v291.TextColor3 or Color3_new_ret;
        v291.TextStrokeColor3 = Color3_new_ret2;

        if v291.TextStrokeTransparency == nil then
            v291.TextStrokeTransparency = 0.55;
        end;

        local Instance_new_ret = Instance.new(v292);

        for i, v in v291 do
            Instance_new_ret[i] = v;
        end;

        Instance_new_ret.Parent = gui;
        local v293 = {
            Text = "THANKS FOR LISTENING",
            TextScaled = true,
            TextTransparency = 1,
            TextStrokeTransparency = 1,
            ZIndex = 7,
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromScale(0.5, 0.51),
            Size = UDim2.fromScale(0.6, 0.035),
            FontFace = Font_new_ret2,
            TextColor3 = Color3_fromRGB_ret
        };
        local v294 = v293.Button and "TextButton" or "TextLabel";
        v293.Button = nil;
        v293.BackgroundTransparency = 1;
        v293.TextColor3 = v293.TextColor3 or Color3_new_ret;
        v293.TextStrokeColor3 = Color3_new_ret2;

        if v293.TextStrokeTransparency == nil then
            v293.TextStrokeTransparency = 0.55;
        end;

        local Instance_new_ret2 = Instance.new(v294);

        for i, v in v293 do
            Instance_new_ret2[i] = v;
        end;

        Instance_new_ret2.Parent = gui;
        Frame.BackgroundTransparency = 0.25;
        TweenService:Create(Frame, TweenInfo.new(1.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            BackgroundTransparency = 1
        }):Play();
        local v295 = gameSound("06_PlayerEvents", "Victory", 0.45, 0.9, gui);

        if v295 then
            v295:Play();
        end;

        TweenService:Create(Instance_new_ret, TweenInfo.new(1.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            TextTransparency = 0,
            TextStrokeTransparency = 0.4
        }):Play();
        task.wait(0.6);
        TweenService:Create(Instance_new_ret2, TweenInfo.new(1.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            TextTransparency = 0,
            TextStrokeTransparency = 0.6
        }):Play();

        if u208 then
            TweenService:Create(u208, TweenInfo.new(3.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Volume = 0.08,
                PlaybackSpeed = 0.7
            }):Play();
        end;

        task.wait(3.6);

        if u211 then
            return;
        end;

        TweenService:Create(Instance_new_ret, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            TextTransparency = 1,
            TextStrokeTransparency = 1
        }):Play();
        TweenService:Create(Instance_new_ret2, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            TextTransparency = 1,
            TextStrokeTransparency = 1
        }):Play();
        task.wait(1.1);

        for _, v in v281 do
            v:Destroy();
        end;
    end;

    local function interrupted() -- Line: 1535
        -- upvalues: LocalPlayer (ref), Session (ref), u10 (ref), u199 (copy), Character (copy), u198 (copy), u196 (copy)
        return (LocalPlayer:GetAttribute("InMatch") == true or (Session:GetAttribute("MapChanging") == true or (LocalPlayer:GetAttribute("ScreenPresentationActive") == true or (LocalPlayer:GetAttribute("Spectating") == true or ((LocalPlayer:GetAttribute("GameRole") or "Lobby") ~= "Lobby" or (LocalPlayer:GetAttribute("EventIntroActive") == true or LocalPlayer:GetAttribute("CutsceneActive") == true)))))) and true or (not u10 or ((u199.Parent == nil or (LocalPlayer.Character ~= Character or u198.Parent == nil)) and true or u196.Health <= 0));
    end;

    table.insert(u203, u204.advance.Activated:Connect(advance));
    table.insert(u203, u204.leave.Activated:Connect(cleanup));
    table.insert(u203, UserInputService.InputBegan:Connect(function(p296) -- Line: 1555
        -- upvalues: advance (copy), cleanup (copy)
        local KeyCode = p296.KeyCode;

        if KeyCode == Enum.KeyCode.Space or (KeyCode == Enum.KeyCode.Return or (KeyCode == Enum.KeyCode.E or KeyCode == Enum.KeyCode.ButtonA)) then
            advance();

            return;
        end;

        if KeyCode == Enum.KeyCode.ButtonB then
            cleanup();
        end;
    end));
    local PropertyChangedSignal = u204.gui:GetPropertyChangedSignal("AbsoluteSize");
    table.insert(u203, PropertyChangedSignal:Connect(function() -- Line: 1563
        -- upvalues: u204 (ref)
        if u204 then
            local v297 = u204;
            local Y = v297.gui.AbsoluteSize.Y;
            local body = v297.body;
            local math_floor_ret = math.floor(Y * 0.036);
            body.TextSize = math.clamp(math_floor_ret, 16, 30);
            local speaker = v297.speaker;
            local math_floor_ret2 = math.floor(Y * 0.022);
            speaker.TextSize = math.clamp(math_floor_ret2, 12, 18);
        end;
    end));
    local Top = u204.Top;
    local v298 = {
        Position = UDim2.fromScale(0.5, 0.1)
    };
    TweenService:Create(Top, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), v298):Play();
    local Bottom = u204.Bottom;
    local v299 = {
        Position = UDim2.fromScale(0.5, 0.9)
    };
    TweenService:Create(Bottom, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), v299):Play();
    local v300 = TweenService:Create(workspace_CurrentCamera, TweenInfo.new(1.3, Enum.EasingStyle.Sine or Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        FieldOfView = 50
    });
    v300:Play();
    u207 = v300;
    local os_clock_ret3 = os.clock();

    local function step() -- Line: 1573
        -- upvalues: u211 (ref), interrupted (copy), cleanup (copy), place (copy), os_clock_ret3 (ref), u209 (copy), u210 (copy), u199 (copy), u261 (copy), show (copy), u204 (ref), advance (copy)
        if u211 then
            return;
        end;

        if interrupted() then
            cleanup("instant");

            return;
        end;

        local os_clock_ret4 = os.clock();
        place(os_clock_ret4);

        if os_clock_ret4 - os_clock_ret3 > 0.3 then
            os_clock_ret3 = os_clock_ret4;
            u209:sweep();
            u210:sweep(u199.Position);
        end;

        if u261.mode ~= "lines" then
            return;
        end;

        if u261.index == 0 then
            if u261.titleUntil <= os_clock_ret4 then
                u261.index = 1;
                show(1);
            end;

            return;
        end;

        if u261.typing then
            local total = u261.total;
            local math_floor_ret = math.floor((os_clock_ret4 - u261.lineAt) * 40);
            local math_min_ret = math.min(total, math_floor_ret);

            if math_min_ret ~= u261.shown then
                if u204.blip and math.floor(math_min_ret / 3) ~= math.floor(u261.shown / 3) then
                    u204.blip:Play();
                end;

                u261.shown = math_min_ret;
                u204.body.MaxVisibleGraphemes = math_min_ret;
            end;

            if u261.total <= math_min_ret then
                u261.typing = false;
                u261.typedAt = os_clock_ret4;
                u204.body.MaxVisibleGraphemes = -1;
                u204.next.Visible = true;
            end;
        else
            u204.next.TextTransparency = 0.45 - math.cos((os_clock_ret4 - u261.typedAt) * 4) * 0.45;

            if os_clock_ret4 - u261.typedAt > 2 + u261.total * 0.045 then
                advance();
            end;
        end;
    end;

    RunService:BindToRenderStep("AlbieTalk", Enum.RenderPriority.Camera.Value + 1, function() -- Line: 1622
        -- upvalues: step (copy), cleanup (copy)
        local success2, result2 = pcall(step);

        if not success2 then
            warn("albie\'s talk stopped:", result2);
            cleanup("instant");
        end;
    end);
    local success2, result2 = pcall(function() -- Line: 1631, Name: session
        -- upvalues: u194 (copy), u193 (copy), runLines (copy), u201 (copy), u200 (copy), AlbieRemote (ref), farewell (copy), u211 (ref), u261 (copy), u204 (ref), runMenu (copy), TweenService (ref), u208 (ref), cleanup (copy)
        local total = u194.total;

        if u193 > 0 then
            if runLines(u201, string.format("DAY %d OF %d", u193, total), u200.title) ~= "done" then
                return;
            end;

            AlbieRemote:FireServer("Done", u193);

            if u193 == total then
                farewell();
            end;
        elseif u201 then
            local v301 = u201;
            local v302;

            if u211 then
                v302 = "abort";
            else
                u261.lines = v301;
                u261.index = 0;
                u261.typing = false;
                u261.titleUntil = os.clock() + 0.2;
                u261.mode = "lines";

                while u261.mode == "lines" and not u211 do
                    task.wait();
                end;

                if u204 then
                    u204.say.Visible = false;
                    u204.next.Visible = false;
                end;

                if u211 then
                    v302 = "abort";
                else
                    v302 = "done";
                end;
            end;

            if v302 ~= "done" then
                return;
            end;
        end;

        local v303;

        if u193 == total then
            v303 = 0;
        else
            v303 = #u194.chapters;
        end;

        while true do
            local v304 = not u211 and (v303 > 0 and runMenu(v303));

            if not v304 then
                break;
            end;

            local v305 = u194.chapters[v304];

            if runLines(v305.lines, string.format("DAY %d · AGAIN", v304), v305.title) ~= "done" then
                return;
            end;

            if v304 == total then
                farewell();
                break;
            end;
        end;

        if not u211 and u204 then
            local Top2 = u204.Top;
            local v306 = {
                Position = UDim2.fromScale(0.5, 0)
            };
            TweenService:Create(Top2, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), v306):Play();
            local Bottom2 = u204.Bottom;
            local v307 = {
                Position = UDim2.fromScale(0.5, 1)
            };
            TweenService:Create(Bottom2, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), v307):Play();

            if u208 then
                TweenService:Create(u208, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Volume = 0
                }):Play();
            end;

            task.wait(0.36);
            cleanup();
        end;
    end);

    if not success2 then
        warn("albie\'s talk stopped:", result2);
        cleanup("instant");
    end;
end;

AlbieRemote.OnClientEvent:Connect(function(p308, p309, u310, p311, p312) -- Line: 1681
    -- upvalues: talk (copy), u13 (ref), u190 (ref), u191 (ref), Interface (copy)
    if p308 == "Talk" and type(p309) == "number" then
        task.spawn(talk, p309, u310, p311);

        return;
    end;

    if p308 == "Saved" and (type(u310) == "number" and u310 > 0) then
        if u13 then
            u190 = u190 + u310;

            if u191 then
                u191("+" .. u310 .. " GEMS");
            end;
        else
            local success, result = pcall(function() -- Line: 943
                -- upvalues: Interface (ref), u310 (copy)
                require(Interface:WaitForChild("ClaimPop")).show({}, 0, u310, nil, {
                    heading = "A GIFT FROM ALBIE"
                });
            end);

            if not success then
                warn("albie\'s gems popup failed:", result);
            end;
        end;
    end;
end);