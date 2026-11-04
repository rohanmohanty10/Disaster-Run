 

 

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local SoundService = game:GetService("SoundService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local LocalPlayer = Players.LocalPlayer;
local Game = ReplicatedStorage:WaitForChild("ChickenOrHero"):WaitForChild("Game");
local PumpkinHuntConfig = require(Game:WaitForChild("PumpkinHuntConfig"));
local success, result = pcall(function() -- Line: 24
    -- upvalues: Game (copy)
    return require(Game:WaitForChild("RandomPrizePolicy", 10)).start();
end);

if not success or type(result) ~= "table" then
    warn("[PumpkinPeopleClient] Game.RandomPrizePolicy didn\'t load (" .. tostring(result) .. "); nobody is treated as restricted");
    result = {
        restricted = function() -- Line: 31, Name: restricted
            return false;
        end,

        start = function() -- Line: 31, Name: start
        end,

        Changed = Instance.new("BindableEvent")
    };
end;

local Session = Game:WaitForChild("Session");

local function waitFor(p1, p2) -- Line: 35
    local v3 = p1:WaitForChild(p2, 60);

    if not v3 then
        warn("PumpkinPeopleClient: " .. p1:GetFullName() .. "." .. p2 .. " never arrived after 60 s; waiting for it");
        v3 = p1:WaitForChild(p2);
    end;

    return v3;
end;

local PumpkinHuntAssets = ReplicatedStorage:WaitForChild("PumpkinHuntAssets", 60);

if not PumpkinHuntAssets then
    warn("PumpkinPeopleClient: " .. ReplicatedStorage:GetFullName() .. ".PumpkinHuntAssets never arrived after 60 s; waiting for it");
    PumpkinHuntAssets = ReplicatedStorage:WaitForChild("PumpkinHuntAssets");
end;

local PumpkinPerson = PumpkinHuntAssets:WaitForChild("PumpkinPerson", 60);

if not PumpkinPerson then
    warn("PumpkinPeopleClient: " .. PumpkinHuntAssets:GetFullName() .. ".PumpkinPerson never arrived after 60 s; waiting for it");
    PumpkinPerson = PumpkinHuntAssets:WaitForChild("PumpkinPerson");
end;

local PumpkinPeople = Game:WaitForChild("PumpkinPeople", 60);

if not PumpkinPeople then
    warn("PumpkinPeopleClient: " .. Game:GetFullName() .. ".PumpkinPeople never arrived after 60 s; waiting for it");
    PumpkinPeople = Game:WaitForChild("PumpkinPeople");
end;

local PumpkinPeopleEvent = Game:WaitForChild("PumpkinPeopleEvent", 60);

if not PumpkinPeopleEvent then
    warn("PumpkinPeopleClient: " .. Game:GetFullName() .. ".PumpkinPeopleEvent never arrived after 60 s; waiting for it");
    PumpkinPeopleEvent = Game:WaitForChild("PumpkinPeopleEvent");
end;

local Color3_fromRGB_ret = Color3.fromRGB(255, 132, 28);
local Color3_fromRGB_ret2 = Color3.fromRGB(255, 184, 72);
local Color3_fromRGB_ret3 = Color3.fromRGB(255, 220, 110);
local Color3_fromRGB_ret4 = Color3.fromRGB(176, 98, 255);
local Color3_fromRGB_ret5 = Color3.fromRGB(235, 40, 50);
local Color3_fromRGB_ret6 = Color3.fromRGB(255, 205, 60);
local Folder = Instance.new("Folder");
Folder.Name = "PumpkinPeopleRigs";
Folder.Parent = workspace;

local function flat(p4) -- Line: 68
    return Vector3.new(p4.X, 0, p4.Z);
end;

local function unit(p5) -- Line: 71
    return p5.Magnitude <= 0.01 and Vector3.new(0, 0, 0) or p5.Unit;
end;

local function sound(p6, p7, p8) -- Line: 74
    -- upvalues: PumpkinHuntConfig (copy), SoundService (copy)
    local v9 = PumpkinHuntConfig.Sounds[p6];

    if not v9 then
        return;
    end;

    local Sound = Instance.new("Sound");
    Sound.SoundId = v9[1];
    Sound.Volume = v9[2];
    Sound.PlaybackSpeed = p8 or 0.94 + math.random() * 0.12;
    Sound.RollOffMinDistance = 10;
    Sound.RollOffMaxDistance = 160;
    Sound.Parent = p7 or SoundService;
    Sound:Play();
    Sound.Ended:Once(function() -- Line: 87
        -- upvalues: Sound (copy)
        Sound:Destroy();
    end);
    task.delay(8, function() -- Line: 90
        -- upvalues: Sound (copy)
        if Sound.Parent then
            Sound:Destroy();
        end;
    end);
end;

local function soundAt(p10, p11) -- Line: 96
    -- upvalues: Folder (copy), sound (copy)
    local Part = Instance.new("Part");
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.Transparency = 1;
    Part.Size = Vector3.new(1, 1, 1);
    Part.CFrame = CFrame.new(p11);
    Part.Parent = Folder;
    sound(p10, Part);
    task.delay(6, function() -- Line: 104
        -- upvalues: Part (copy)
        Part:Destroy();
    end);
end;

local function animation(p12) -- Line: 108
    local Animation = Instance.new("Animation");
    Animation.AnimationId = p12;

    return Animation;
end;

local u13 = {};
local Idle = PumpkinHuntConfig.Anims.Idle;
local Animation = Instance.new("Animation");
Animation.AnimationId = Idle;
u13.Idle = Animation;
local Walk = PumpkinHuntConfig.Anims.Walk;
local Animation2 = Instance.new("Animation");
Animation2.AnimationId = Walk;
u13.Walk = Animation2;
local Rise = PumpkinHuntConfig.Anims.Rise;
local Animation3 = Instance.new("Animation");
Animation3.AnimationId = Rise;
u13.Rise = Animation3;
local Lunge = PumpkinHuntConfig.Anims.Lunge;
local Animation4 = Instance.new("Animation");
Animation4.AnimationId = Lunge;
u13.Lunge = Animation4;

local function characterOf(p14) -- Line: 120
    -- upvalues: Players (copy)
    local PlayerByUserId = Players:GetPlayerByUserId(p14 or 0);

    if PlayerByUserId then
        PlayerByUserId = PlayerByUserId.Character;
    end;

    return PlayerByUserId;
end;

local function emitter(p15, p16) -- Line: 128
    local ParticleEmitter = Instance.new("ParticleEmitter");

    for i, v in p16 do
        ParticleEmitter[i] = v;
    end;

    ParticleEmitter.Parent = p15;

    return ParticleEmitter;
end;

local function flashModel(p17, p18, p19) -- Line: 138
    -- upvalues: Folder (copy), TweenService (copy)
    local Highlight = Instance.new("Highlight");
    Highlight.FillColor = p18;
    Highlight.OutlineColor = p18;
    Highlight.FillTransparency = 0.35;
    Highlight.OutlineTransparency = 0;
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.Adornee = p17;
    Highlight.Parent = Folder;
    TweenService:Create(Highlight, TweenInfo.new(p19), {
        FillTransparency = 1,
        OutlineTransparency = 1
    }):Play();
    task.delay(p19 + 0.05, function() -- Line: 148
        -- upvalues: Highlight (copy)
        Highlight:Destroy();
    end);
end;

local function burst(p20, p21, p22, p23) -- Line: 154
    -- upvalues: Folder (copy)
    local Part = Instance.new("Part");
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.Transparency = 1;
    Part.Size = Vector3.new(1, 1, 1);
    Part.CFrame = CFrame.new(p20);
    local v24 = {
        Texture = "rbxasset://textures/particles/sparkles_main.dds",
        LightEmission = 1,
        LightInfluence = 0,
        Acceleration = Vector3.new(0, -20, 0),
        Enabled = false,
        Color = ColorSequence.new(p21[1], p21[2] or p21[1]),
        Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.5), NumberSequenceKeypoint.new(1, 0) }),
        Lifetime = NumberRange.new(0.4, 0.8),
        Speed = NumberRange.new(p23 * 0.5, p23),
        SpreadAngle = Vector2.new(180, 180)
    };
    local ParticleEmitter = Instance.new("ParticleEmitter");

    for i, v in v24 do
        ParticleEmitter[i] = v;
    end;

    ParticleEmitter.Parent = Part;
    Part.Parent = Folder;
    ParticleEmitter:Emit(p22);
    task.delay(1.5, function() -- Line: 174
        -- upvalues: Part (copy)
        Part:Destroy();
    end);
end;

local function lightning(u25, u26) -- Line: 180
    -- upvalues: Folder (copy), Color3_fromRGB_ret (copy), Color3_fromRGB_ret2 (copy), TweenService (copy)
    local Folder2 = Instance.new("Folder");
    Folder2.Name = "AnkleBolt";
    Folder2.Parent = Folder;

    local function draw() -- Line: 184
        -- upvalues: Folder2 (copy), u25 (copy), u26 (copy), Color3_fromRGB_ret (ref), Color3_fromRGB_ret2 (ref)
        Folder2:ClearAllChildren();
        local v27 = { u25 };
        local v28 = u26 - u25;
        local v29 = v28:Cross(Vector3.new(0, 1, 0));
        local v30 = v29.Magnitude <= 0.01 and Vector3.new(0, 0, 0) or v29.Unit;
        local v31 = v28:Cross(v30);
        local v32 = v31.Magnitude <= 0.01 and Vector3.new(0, 0, 0) or v31.Unit;

        for i = 1, 8 do
            local v33 = (v30 * (math.random() - 0.5) + v32 * (math.random() - 0.5)) * 2.4;
            table.insert(v27, u25 + v28 * (i / 9) + v33);
            local _ = i;
        end;

        table.insert(v27, u26);

        for i = 1, #v27 - 1 do
            local v34 = v27[i];
            local v35 = v27[i + 1];
            local Part = Instance.new("Part");
            Part.Anchored = true;
            Part.CanCollide = false;
            Part.CanQuery = false;
            Part.CanTouch = false;
            Part.Material = Enum.Material.Neon;
            local v36;

            if i % 2 == 0 then
                v36 = Color3_fromRGB_ret;
            else
                v36 = Color3_fromRGB_ret2;
            end;

            Part.Color = v36;
            Part.Size = Vector3.new(0.22, 0.22, (v35 - v34).Magnitude);
            Part.CFrame = CFrame.lookAt((v34 + v35) / 2, v35);
            Part.Parent = Folder2;
            local _ = i;
        end;
    end;

    task.spawn(function() -- Line: 208
        -- upvalues: draw (copy), Folder2 (copy), TweenService (ref)
        for i = 1, 4 do
            draw();
            task.wait(0.07);
            local _ = i;
        end;

        for _, child in Folder2:GetChildren() do
            TweenService:Create(child, TweenInfo.new(0.25), {
                Transparency = 1
            }):Play();
        end;

        task.wait(0.3);
        Folder2:Destroy();
    end);
    local Part = Instance.new("Part");
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.Transparency = 1;
    Part.Size = Vector3.new(1, 1, 1);
    Part.CFrame = CFrame.new((u25 + u26) / 2);
    local PointLight = Instance.new("PointLight");
    PointLight.Color = Color3_fromRGB_ret;
    PointLight.Brightness = 6;
    PointLight.Range = 18;
    PointLight.Parent = Part;
    Part.Parent = Folder;
    TweenService:Create(PointLight, TweenInfo.new(0.5), {
        Brightness = 0
    }):Play();
    task.delay(0.55, function() -- Line: 231
        -- upvalues: Part (copy)
        Part:Destroy();
    end);
end;

local u37 = 0;
local u38 = 0;

local function kick(p39, p40) -- Line: 238
    -- upvalues: u38 (ref), u37 (ref)
    u38 = p39;
    u37 = os.clock() + (p40 or 0.25);
end;

RunService:BindToRenderStep("PumpkinHuntKick", Enum.RenderPriority.Camera.Value + 1, function() -- Line: 242
    -- upvalues: u37 (ref), u38 (ref)
    local v41 = u37 - os.clock();

    if v41 > 0 then
        local workspace_CurrentCamera = workspace.CurrentCamera;
        local v42 = u38 * v41 * 4;
        workspace_CurrentCamera.CFrame = workspace_CurrentCamera.CFrame * CFrame.Angles((math.random() - 0.5) * v42, (math.random() - 0.5) * v42, 0);
    end;
end);
local u43 = {};
local Model = Instance.new("Model");
Model.Name = "PumpkinPeople";
local Highlight = Instance.new("Highlight");
Highlight.Name = "Outline";
Highlight.Adornee = Model;
Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
Highlight.FillColor = Color3_fromRGB_ret;
Highlight.OutlineColor = Color3_fromRGB_ret;
Highlight.FillTransparency = 0.92;
Highlight.OutlineTransparency = 0.15;
Highlight.Enabled = false;
Highlight.Parent = Model;
Model.Parent = Folder;

local function refreshOutline() -- Line: 269
    -- upvalues: u43 (copy), Highlight (copy)
    local v44 = false;

    for _, v in u43 do
        if not v.dead then
            v44 = true;
            break;
        end;
    end;

    Highlight.Enabled = v44;
end;

local function stopTracks(p45, p46) -- Line: 280
    for _, v in p45.tracks do
        if v.IsPlaying then
            v:Stop(p46 or 0.15);
        end;
    end;
end;

local function shellOf(p47) -- Line: 289
    local v48;

    if p47:IsA("Model") then
        v48 = p47.PrimaryPart;

        if not v48 then
            return p47:FindFirstChildWhichIsA("BasePart");
        end;
    else
        v48 = p47;
    end;

    return v48;
end;

local function placeHead(p49, p50) -- Line: 292
    if p49:IsA("Model") then
        p49:PivotTo(p50);

        return;
    end;

    p49.CFrame = p50;
end;

local function sizeHead(p51, p52) -- Line: 299
    if p51:IsA("Model") then
        p51:ScaleTo((math.max(0.05, p52)));
    end;
end;

local function faceParts(p53) -- Line: 304
    local v54 = {};

    for _, descendant in p53:GetDescendants() do
        if descendant:IsA("BasePart") and descendant.Material == Enum.Material.Neon then
            table.insert(v54, descendant);
        end;
    end;

    return v54;
end;

local function ballStep(p55, p56, p57, p58) -- Line: 318
    p55.velocity = p55.velocity - Vector3.new(0, 75, 0) * p56;
    local v59 = p55.velocity * p56;
    local v60 = nil;

    for i = 1, 3 do
        if v59.Magnitude < 0.0001 then
            break;
        end;

        local v61 = workspace:Spherecast(p55.pos, p57, v59, p58);

        if not v61 then
            p55.pos = p55.pos + v59;
            break;
        end;

        local Normal = v61.Normal;
        local math_max_ret = math.max(0, v61.Distance - 0.02);
        p55.pos = p55.pos + v59.Unit * math_max_ret;
        local v62 = p55.velocity:Dot(Normal);

        if v62 < 0 then
            if Normal.Y > 0.6 then
                p55.velocity = p55.velocity - v62 * Normal * (-v62 > 6 and 1.32 or 1);
                v60 = Normal;
            else
                p55.velocity = (p55.velocity - 2 * v62 * Normal) * 0.45;
            end;
        end;

        local v63 = v59.Unit * math.max(0, v59.Magnitude - math_max_ret);
        v59 = v63 - v63:Dot(Normal) * Normal;
        local _ = i;
    end;

    local v64 = workspace:Raycast(p55.pos, Vector3.new(-0, -1, -0) * (p57 + 0.3), p58);
    local v65;

    if v64 and v64.Normal.Y > 0.6 then
        v65 = v64.Normal;
        local v66 = v64.Position.Y + p57 / v65.Y + 0.02;

        if p55.pos.Y <= v66 + 0.1 and p55.velocity:Dot(v65) <= 0.5 then
            local X = p55.pos.X;
            local math_max_ret = math.max(p55.pos.Y, v66);
            p55.pos = Vector3.new(X, math_max_ret, p55.pos.Z);
            local v67 = p55.velocity:Dot(v65);

            if v67 < 0 then
                p55.velocity = p55.velocity - v67 * v65;
            end;
        else
            v65 = v60;
        end;
    else
        v65 = v60;
    end;

    if v65 then
        p55.velocity = p55.velocity * (1 - math.min(1, 1.6 * p56));
    end;

    return v65;
end;

local function rollHead(u68, p69, u70) -- Line: 372
    -- upvalues: Folder (copy), Players (copy), RunService (copy), burst (copy), Color3_fromRGB_ret (copy), Color3_fromRGB_ret3 (copy), sound (copy), ballStep (copy)
    local v71;

    if u68:IsA("Model") then
        v71 = u68.PrimaryPart or u68:FindFirstChildWhichIsA("BasePart");
    else
        v71 = u68;
    end;

    local u72 = v71.Size.Y / 2;
    local RaycastParams_new_ret = RaycastParams.new();
    RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
    local v73 = { Folder };

    for _, v in Players:GetPlayers() do
        if v.Character then
            table.insert(v73, v.Character);
        end;
    end;

    local ClientBots = workspace:FindFirstChild("ClientBots");

    if ClientBots then
        table.insert(v73, ClientBots);
    end;

    RaycastParams_new_ret.FilterDescendantsInstances = v73;
    RaycastParams_new_ret.RespectCanCollide = true;
    local Pivot = u68:GetPivot();
    local u74 = Pivot - Pivot.Position;
    local u75 = {
        pos = Pivot.Position,
        velocity = p69 * 13 + Vector3.new(0, 17, 0)
    };
    local u76 = 0;
    local os_clock_ret = os.clock();

    local function settle() -- Line: 395
        -- upvalues: u74 (ref), u75 (copy), u68 (copy), RunService (ref), u70 (copy), Players (ref), burst (ref), Color3_fromRGB_ret (ref), Color3_fromRGB_ret3 (ref), sound (ref)
        local LookVector = u74.LookVector;
        local Vector3_new_ret = Vector3.new(LookVector.X, 0, LookVector.Z);
        local u77 = CFrame.new(u75.pos) * CFrame.Angles(0, math.atan2(-Vector3_new_ret.X, -Vector3_new_ret.Z), 0);
        local Pivot2 = u68:GetPivot();
        local os_clock_ret2 = os.clock();

        while os.clock() - os_clock_ret2 < 0.35 do
            local v78 = (os.clock() - os_clock_ret2) / 0.35;
            local v79 = u68;
            local v80 = Pivot2:Lerp(u77, 1 - (1 - v78) * (1 - v78));

            if v79:IsA("Model") then
                v79:PivotTo(v80);
            else
                v79.CFrame = v80;
            end;

            RunService.RenderStepped:Wait();
        end;

        local v81 = u68;

        if v81:IsA("Model") then
            v81:PivotTo(u77);
        else
            v81.CFrame = u77;
        end;

        task.wait(0.2);
        local Position = u77.Position;
        local os_clock_ret3 = os.clock();
        local u82 = nil;
        u82 = RunService.RenderStepped:Connect(function() -- Line: 411
            -- upvalues: os_clock_ret3 (copy), u70 (ref), Players (ref), Position (copy), u68 (ref), u77 (copy), u82 (ref), burst (ref), Color3_fromRGB_ret (ref), Color3_fromRGB_ret3 (ref), sound (ref)
            local v83 = (os.clock() - os_clock_ret3) / 0.5;
            local math_clamp_ret = math.clamp(v83, 0, 1);
            local PlayerByUserId = Players:GetPlayerByUserId(u70 or 0);

            if PlayerByUserId then
                PlayerByUserId = PlayerByUserId.Character;
            end;

            if PlayerByUserId then
                PlayerByUserId = PlayerByUserId:FindFirstChild("HumanoidRootPart");
            end;

            local v84;

            if PlayerByUserId then
                v84 = PlayerByUserId.Position;
            else
                v84 = Position;
            end;

            local v85 = Vector3.new(0, 1, 0) * math.sin(math_clamp_ret * 3.141592653589793) * 4;
            local v86 = u68;
            local v87 = CFrame.new(Position:Lerp(v84, math_clamp_ret * math_clamp_ret) + v85) * (u77 - u77.Position) * CFrame.Angles(0, math_clamp_ret * 6, 0);

            if v86:IsA("Model") then
                v86:PivotTo(v87);
            else
                v86.CFrame = v87;
            end;

            local v88 = u68;
            local v89 = 1 - math_clamp_ret * 0.8;

            if v88:IsA("Model") then
                v88:ScaleTo((math.max(0.05, v89)));
            end;

            if math_clamp_ret >= 1 then
                u82:Disconnect();
                burst(v84 + Vector3.new(0, 1, 0), { Color3_fromRGB_ret, Color3_fromRGB_ret3 }, 22, 14);

                if PlayerByUserId then
                    sound("Collect", PlayerByUserId);
                end;

                u68:Destroy();
            end;
        end);
    end;

    local u90 = nil;
    u90 = RunService.RenderStepped:Connect(function(p91) -- Line: 431
        -- upvalues: u68 (copy), u90 (ref), ballStep (ref), u75 (copy), u72 (copy), RaycastParams_new_ret (copy), u74 (ref), u76 (ref), os_clock_ret (copy), Pivot (copy), settle (copy)
        if not u68.Parent then
            u90:Disconnect();

            return;
        end;

        local math_min_ret = math.min(p91, 0.03333333333333333);
        local v92 = ballStep(u75, math_min_ret, u72, RaycastParams_new_ret);

        if v92 then
            local v93 = u75.velocity - u75.velocity:Dot(v92) * v92;

            if v93.Magnitude > 0.05 then
                u74 = CFrame.fromAxisAngle(v92:Cross(v93.Unit), v93.Magnitude * math_min_ret / u72) * u74;
            end;
        end;

        local v94 = u68;
        local v95 = CFrame.new(u75.pos) * u74;

        if v94:IsA("Model") then
            v94:PivotTo(v95);
        else
            v94.CFrame = v95;
        end;

        if v92 and u75.velocity.Magnitude < 1.4 then
            u76 = u76 + math_min_ret;
        else
            u76 = 0;
        end;

        if u76 > 0.2 or (os.clock() - os_clock_ret > 3.5 or u75.pos.Y < Pivot.Position.Y - 40) then
            u90:Disconnect();
            task.spawn(settle);
        end;
    end);
end;

local function plusCoins(p96) -- Line: 462
    -- upvalues: Players (copy), Folder (copy), PumpkinHuntConfig (copy), Color3_fromRGB_ret6 (copy), TweenService (copy)
    local PlayerByUserId = Players:GetPlayerByUserId(p96 or 0);

    if PlayerByUserId then
        PlayerByUserId = PlayerByUserId.Character;
    end;

    if PlayerByUserId then
        PlayerByUserId = PlayerByUserId:FindFirstChild("Head") or PlayerByUserId:FindFirstChild("HumanoidRootPart");
    end;

    if not PlayerByUserId then
        return;
    end;

    local BillboardGui = Instance.new("BillboardGui");
    BillboardGui.Name = "PumpkinCoins";
    BillboardGui.Adornee = PlayerByUserId;
    BillboardGui.Size = UDim2.fromScale(4.2, 1.4);
    BillboardGui.StudsOffsetWorldSpace = Vector3.new(0, 2.6, 0);
    BillboardGui.AlwaysOnTop = true;
    BillboardGui.LightInfluence = 0;
    BillboardGui.Parent = Folder;
    local ImageLabel = Instance.new("ImageLabel");
    ImageLabel.BackgroundTransparency = 1;
    ImageLabel.Image = "rbxassetid://78008558948307";
    ImageLabel.ScaleType = Enum.ScaleType.Fit;
    ImageLabel.Size = UDim2.fromScale(0.3, 1);
    ImageLabel.Parent = BillboardGui;
    local TextLabel = Instance.new("TextLabel");
    TextLabel.BackgroundTransparency = 1;
    TextLabel.Position = UDim2.fromScale(0.3, 0);
    TextLabel.Size = UDim2.fromScale(0.7, 1);
    TextLabel.Text = "+" .. PumpkinHuntConfig.commas(PumpkinHuntConfig.RestrictedCoins);
    TextLabel.TextScaled = true;
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel.FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json");
    TextLabel.TextColor3 = Color3_fromRGB_ret6;
    TextLabel.TextStrokeColor3 = Color3.fromRGB(70, 35, 0);
    TextLabel.TextStrokeTransparency = 0;
    TextLabel.Parent = BillboardGui;
    local UIScale = Instance.new("UIScale");
    UIScale.Scale = 0.3;
    UIScale.Parent = BillboardGui;
    TweenService:Create(UIScale, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Scale = 1
    }):Play();
    TweenService:Create(BillboardGui, TweenInfo.new(1.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        StudsOffsetWorldSpace = Vector3.new(0, 4.6, 0)
    }):Play();
    task.delay(0.9, function() -- Line: 499
        -- upvalues: TweenService (ref), TextLabel (copy), ImageLabel (copy), BillboardGui (copy)
        TweenService:Create(TextLabel, TweenInfo.new(0.5), {
            TextTransparency = 1,
            TextStrokeTransparency = 1
        }):Play();
        TweenService:Create(ImageLabel, TweenInfo.new(0.5), {
            ImageTransparency = 1
        }):Play();
        task.delay(0.55, function() -- Line: 502
            -- upvalues: BillboardGui (ref)
            BillboardGui:Destroy();
        end);
    end);
end;

local function coinBurst(u97, u98) -- Line: 507
    -- upvalues: soundAt (copy), TweenService (copy), Folder (copy), Color3_fromRGB_ret6 (copy), plusCoins (copy), RunService (copy), Players (copy)
    local v99;

    if u97:IsA("Model") then
        v99 = u97.PrimaryPart or u97:FindFirstChildWhichIsA("BasePart");
    else
        v99 = u97;
    end;

    local Position = v99.Position;
    soundAt("Coins", Position);

    for _, descendant in u97:GetDescendants() do
        if descendant:IsA("BasePart") then
            TweenService:Create(descendant, TweenInfo.new(0.18), {
                Transparency = 1
            }):Play();
        elseif descendant:IsA("SpecialMesh") then
            TweenService:Create(descendant, TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Scale = descendant.Scale * 1.4
            }):Play();
        end;
    end;

    if u97:IsA("BasePart") then
        TweenService:Create(u97, TweenInfo.new(0.18), {
            Transparency = 1
        }):Play();
    end;

    task.delay(0.25, function() -- Line: 522
        -- upvalues: u97 (copy)
        u97:Destroy();
    end);
    local Part = Instance.new("Part");
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.Transparency = 1;
    Part.Size = Vector3.new(1, 1, 1);
    Part.CFrame = CFrame.new(Position);
    Part.Parent = Folder;
    local PointLight = Instance.new("PointLight");
    PointLight.Color = Color3_fromRGB_ret6;
    PointLight.Brightness = 3;
    PointLight.Range = 12;
    PointLight.Parent = Part;
    TweenService:Create(PointLight, TweenInfo.new(0.6), {
        Brightness = 0
    }):Play();
    local ParticleEmitter = Instance.new("ParticleEmitter");
    ParticleEmitter.Texture = "rbxasset://textures/particles/sparkles_main.dds";
    ParticleEmitter.Color = ColorSequence.new(Color3_fromRGB_ret6, Color3.new(1, 1, 1));
    ParticleEmitter.LightEmission = 1;
    ParticleEmitter.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.5), NumberSequenceKeypoint.new(1, 0) });
    ParticleEmitter.Lifetime = NumberRange.new(0.4, 0.8);
    ParticleEmitter.Speed = NumberRange.new(8, 16);
    ParticleEmitter.SpreadAngle = Vector2.new(180, 180);
    ParticleEmitter.Drag = 4;
    ParticleEmitter.Enabled = false;
    ParticleEmitter.Parent = Part;
    ParticleEmitter:Emit(30);
    task.delay(1.2, function() -- Line: 550
        -- upvalues: Part (copy)
        Part:Destroy();
    end);
    local u100 = {};

    for i = 1, 16 do
        local Part2 = Instance.new("Part");
        Part2.Name = "Coin";
        Part2.Shape = Enum.PartType.Cylinder;
        Part2.Size = Vector3.new(0.16, 0.85, 0.85);
        Part2.Material = Enum.Material.SmoothPlastic;
        Part2.Reflectance = 0.25;
        Part2.Color = Color3_fromRGB_ret6;
        Part2.Anchored = true;
        Part2.CanCollide = false;
        Part2.CanQuery = false;
        Part2.CanTouch = false;
        Part2.CastShadow = false;
        Part2.CFrame = CFrame.new(Position);
        Part2.Parent = Folder;
        local v101 = i / 16 * 3.141592653589793 * 2;
        local math_cos_ret = math.cos(v101);
        local math_sin_ret = math.sin(v101);
        local v102 = {
            part = Part2,
            out = Vector3.new(math_cos_ret, 0, math_sin_ret) * (2.5 + math.random() * 2.5) + Vector3.new(0, 1, 0) * (2 + math.random() * 3),
            spin = 6 + math.random() * 8,
            delay = math.random() * 0.12
        };
        table.insert(u100, v102);
        local _ = i;
    end;

    task.delay(0.55, plusCoins, u98);
    local os_clock_ret = os.clock();
    local u103 = nil;
    u103 = RunService.RenderStepped:Connect(function() -- Line: 574
        -- upvalues: os_clock_ret (copy), u98 (copy), Players (ref), Position (copy), u100 (copy), u103 (ref)
        local v104 = os.clock() - os_clock_ret;
        local PlayerByUserId = Players:GetPlayerByUserId(u98 or 0);

        if PlayerByUserId then
            PlayerByUserId = PlayerByUserId.Character;
        end;

        if PlayerByUserId then
            PlayerByUserId = PlayerByUserId:FindFirstChild("HumanoidRootPart");
        end;

        local v105;

        if PlayerByUserId then
            v105 = PlayerByUserId.Position + Vector3.new(0, 0.5, 0);
        else
            v105 = Position;
        end;

        local v106 = 0;

        for _, v in u100 do
            if v.part.Parent then
                local v107 = v104 - v.delay;
                local v108;

                if v107 < 0.35 then
                    local v109 = math.max(v107, 0) / 0.35;
                    v108 = Position + v.out * (1 - (1 - v109) ^ 2);
                else
                    local math_clamp_ret = math.clamp((v107 - 0.35) / 0.4, 0, 1);
                    v108 = (Position + v.out):Lerp(v105, math_clamp_ret * math_clamp_ret);

                    if math_clamp_ret >= 1 then
                        v.part:Destroy();
                    end;
                end;

                if v.part.Parent then
                    v.part.CFrame = CFrame.new(v108) * CFrame.Angles(0, v104 * v.spin, 1.5707963267948966);
                    v106 = v106 + 1;
                end;
            end;
        end;

        if v106 == 0 or v104 > 2 then
            u103:Disconnect();

            for _, v in u100 do
                if v.part.Parent then
                    v.part:Destroy();
                end;
            end;
        end;
    end);
end;

local function breakRig(u110) -- Line: 611
    -- upvalues: Folder (copy), u43 (copy), Highlight (copy), Players (copy), lightning (copy), sound (copy), flashModel (copy), Color3_fromRGB_ret (copy), LocalPlayer (copy), result (copy), coinBurst (copy), rollHead (copy), u38 (ref), u37 (ref), TweenService (copy)
    if u110.dead then
        return;
    end;

    u110.dead = true;

    for _, v in u110.tracks do
        if v.IsPlaying then
            v:Stop(0);
        end;
    end;

    u110.model.Parent = Folder;
    local v111 = false;

    for _, v in u43 do
        if not v.dead then
            v111 = true;
            break;
        end;
    end;

    Highlight.Enabled = v111;
    local value = u110.value;
    local Attribute = value:GetAttribute("KilledBy");
    local Attribute2 = value:GetAttribute("HitFrom");
    local v112;

    if typeof(Attribute2) == "Vector3" then
        local v113 = u110.root.Position - Attribute2;
        local Vector3_new_ret = Vector3.new(v113.X, 0, v113.Z);
        v112 = Vector3_new_ret.Magnitude <= 0.01 and Vector3.new(0, 0, 0) or Vector3_new_ret.Unit;
    else
        v112 = -u110.root.CFrame.LookVector;
    end;

    local PlayerByUserId = Players:GetPlayerByUserId(Attribute or 0);

    if PlayerByUserId then
        PlayerByUserId = PlayerByUserId.Character;
    end;

    if PlayerByUserId then
        PlayerByUserId = PlayerByUserId:FindFirstChild("HumanoidRootPart");
    end;

    local PumpkinHead = u110.model:FindFirstChild("PumpkinHead");
    local v114;

    if PumpkinHead and PumpkinHead:IsA("Model") then
        v114 = PumpkinHead.PrimaryPart or PumpkinHead:FindFirstChildWhichIsA("BasePart");
    else
        v114 = PumpkinHead;
    end;

    if PlayerByUserId and v114 then
        lightning(PlayerByUserId.Position + Vector3.new(0, 0.5, 0), v114.Position);
    end;

    sound("AnkleBreak", u110.root, 1);
    flashModel(u110.model, Color3_fromRGB_ret, 0.3);

    if PumpkinHead then
        for _, descendant in PumpkinHead:GetDescendants() do
            if descendant:IsA("WeldConstraint") and (descendant.Part0 == u110.model:FindFirstChild("Head") or descendant.Part1 == u110.model:FindFirstChild("Head")) then
                descendant:Destroy();
            end;
        end;

        for _, descendant in PumpkinHead:GetDescendants() do
            if descendant:IsA("BasePart") then
                descendant.Anchored = true;
            end;
        end;

        PumpkinHead.Parent = Folder;
        sound("HeadPop", v114);

        if Attribute == LocalPlayer.UserId and result.restricted() then
            task.spawn(coinBurst, PumpkinHead, Attribute);
        else
            task.spawn(rollHead, PumpkinHead, v112, Attribute);
        end;
    end;

    if Attribute == LocalPlayer.UserId then
        u38 = 0.04;
        u37 = os.clock() + 0.3;
    end;

    local root = u110.root;
    local CFrame2 = root.CFrame;
    local v115 = (Vector3.new(0, 1, 0)):Cross(v112);
    local u116 = CFrame.new(CFrame2.Position - Vector3.new(0, 2, 0)) * CFrame.fromAxisAngle(v115.Magnitude <= 0.01 and Vector3.new(1, 0, 0) or v115.Unit, 1.4835298641951802) * (CFrame2 - CFrame2.Position);
    TweenService:Create(root, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        CFrame = u116
    }):Play();
    task.delay(0.5, function() -- Line: 661
        -- upvalues: sound (ref), root (copy), TweenService (ref), u116 (copy), u110 (copy)
        sound("Haunted", root);
        TweenService:Create(root, TweenInfo.new(1.8, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            CFrame = u116 - Vector3.new(0, 5, 0)
        }):Play();

        for _, descendant in u110.model:GetDescendants() do
            if descendant:IsA("BasePart") and descendant.Transparency < 1 then
                TweenService:Create(descendant, TweenInfo.new(1.8), {
                    Transparency = 1
                }):Play();
            end;
        end;

        task.delay(2, function() -- Line: 669
            -- upvalues: u110 (ref)
            u110.model:Destroy();
        end);
    end);
end;

local function onState(p117) -- Line: 675
    -- upvalues: breakRig (copy), sound (copy)
    if p117.dead then
        return;
    end;

    local Attribute = p117.value:GetAttribute("State");

    if Attribute == p117.state then
        return;
    end;

    local state = p117.state;
    p117.state = Attribute;

    if Attribute == "Broken" then
        breakRig(p117);

        return;
    end;

    if Attribute == "Rise" then
        p117.risePending = os.clock();

        return;
    end;

    if Attribute == "Tell" then
        sound("Tell", p117.root);

        return;
    end;

    if Attribute ~= "Lunge" then
        if state == "Rise" then
            if p117.risePending then
                p117.risePending = nil;
                p117.rise = os.clock();
            end;

            p117.tracks.Rise:Stop(0.25);
        end;

        return;
    end;

    p117.tracks.Walk:Stop(0.05);
    p117.tracks.Lunge:Play(0.05);
    sound("Lunge", p117.root);
end;

local function build(p118) -- Line: 705
    -- upvalues: u43 (copy), PumpkinPerson (copy), Model (copy), Color3_fromRGB_ret3 (copy), Color3_fromRGB_ret (copy), u13 (copy), faceParts (copy), onState (copy), Highlight (copy)
    if u43[p118] then
        return;
    end;

    local v119 = PumpkinPerson:Clone();

    for _, descendant in v119:GetDescendants() do
        if descendant:IsA("LuaSourceContainer") then
            descendant:Destroy();
        elseif descendant:IsA("BasePart") then
            descendant.CanCollide = false;
            descendant.CanQuery = false;
            descendant.CanTouch = false;
            descendant.Massless = true;
            descendant.Anchored = false;
        end;
    end;

    local HumanoidRootPart = v119:FindFirstChild("HumanoidRootPart");
    local v120 = v119:FindFirstChildOfClass("Humanoid");
    local PumpkinHead = v119:FindFirstChild("PumpkinHead");
    local v121;

    if PumpkinHead and PumpkinHead:IsA("Model") then
        v121 = PumpkinHead.PrimaryPart or PumpkinHead:FindFirstChildWhichIsA("BasePart");
    else
        v121 = PumpkinHead;
    end;

    if not (HumanoidRootPart and v120) then
        v119:Destroy();

        return;
    end;

    HumanoidRootPart.Anchored = true;
    v119.PrimaryPart = HumanoidRootPart;
    v120.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None;
    v120.HealthDisplayType = Enum.HumanoidHealthDisplayType.AlwaysOff;
    local v122 = p118:GetAttribute("P") or Vector3.new(0, 0, 0);
    local v123 = p118:GetAttribute("Yaw") or 0;
    local v124 = p118:GetAttribute("State") == "Rise" and 7.5 or 0;
    HumanoidRootPart.CFrame = CFrame.new(v122 - Vector3.new(0, 1, 0) * v124) * CFrame.Angles(0, v123, 0);
    v119.Name = p118.Name;
    v119.Parent = Model;
    local v125, v126;

    if PumpkinHead and v121 then
        local v127 = v121:FindFirstChild("Flame") or v121;
        local v128 = {
            Name = "HeadFlame",
            Texture = "rbxasset://textures/particles/fire_main.dds",
            LightEmission = 0.9,
            LightInfluence = 0,
            Rate = 22,
            Color = ColorSequence.new(Color3_fromRGB_ret3, Color3_fromRGB_ret),
            Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1.1), NumberSequenceKeypoint.new(1, 0.2) }),
            Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.25), NumberSequenceKeypoint.new(1, 1) }),
            Lifetime = NumberRange.new(0.4, 0.7),
            Speed = NumberRange.new(3, 6),
            SpreadAngle = Vector2.new(15, 15),
            RotSpeed = NumberRange.new(-60, 60)
        };
        v125 = Instance.new("ParticleEmitter");

        for i, v in v128 do
            v125[i] = v;
        end;

        v125.Parent = v127;
        v126 = Instance.new("PointLight");
        v126.Color = Color3_fromRGB_ret;
        v126.Brightness = 1.6;
        v126.Range = 10;
        v126.Shadows = false;
        v126.Parent = v121:FindFirstChild("Glow") or v121;
    else
        v125 = nil;
        v126 = nil;
    end;

    local Torso = v119:FindFirstChild("Torso");

    if Torso then
        local v129 = {
            Name = "Smoke",
            Texture = "rbxasset://textures/particles/smoke_main.dds",
            LightInfluence = 0,
            Acceleration = Vector3.new(0, 1.5, 0),
            Rate = 10,
            Color = ColorSequence.new(Color3.fromRGB(12, 8, 16), Color3.fromRGB(40, 22, 52)),
            Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1.2), NumberSequenceKeypoint.new(1, 2.6) }),
            Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.55), NumberSequenceKeypoint.new(1, 1) }),
            Lifetime = NumberRange.new(0.8, 1.4),
            Speed = NumberRange.new(0.5, 1.5),
            SpreadAngle = Vector2.new(180, 180)
        };
        local ParticleEmitter = Instance.new("ParticleEmitter");

        for i, v in v129 do
            ParticleEmitter[i] = v;
        end;

        ParticleEmitter.Parent = Torso;
    end;

    local v130 = v120:FindFirstChildOfClass("Animator") or Instance.new("Animator", v120);
    local v131 = {};

    for i, v in u13 do
        v131[i] = v130:LoadAnimation(v);
    end;

    local Walk2 = v131.Walk;
    v131.Idle.Looped = true;
    Walk2.Looped = true;
    local Lunge2 = v131.Lunge;
    v131.Rise.Looped = false;
    Lunge2.Looped = false;
    v131.Idle:Play(0);
    local u132 = {
        value = p118,
        model = v119,
        root = HumanoidRootPart,
        pos = v122,
        yaw = v123,
        tracks = v131,
        flame = v125,
        light = v126,
        face = not PumpkinHead and {} or faceParts(PumpkinHead)
    };
    local v133;

    if v121 then
        v133 = v121:FindFirstChildOfClass("SpecialMesh");
    else
        v133 = nil;
    end;

    u132.mesh = v133;
    u132.seed = math.random() * 10;
    u43[p118] = u132;
    u132.connection = p118:GetAttributeChangedSignal("State"):Connect(function() -- Line: 801
        -- upvalues: onState (ref), u132 (copy)
        onState(u132);
    end);
    onState(u132);
    local v134 = false;

    for _, v in u43 do
        if not v.dead then
            v134 = true;
            break;
        end;
    end;

    Highlight.Enabled = v134;
end;

PumpkinPeople.ChildAdded:Connect(build);
PumpkinPeople.ChildRemoved:Connect(function(p135) -- Line: 808, Name: unbuild
    -- upvalues: u43 (copy), Folder (copy), TweenService (copy), Highlight (copy)
    local u136 = u43[p135];

    if not u136 then
        return;
    end;

    u43[p135] = nil;
    u136.connection:Disconnect();

    if not u136.dead then
        for _, v in u136.tracks do
            if v.IsPlaying then
                v:Stop(0.2);
            end;
        end;

        u136.dead = true;
        u136.model.Parent = Folder;

        for _, descendant in u136.model:GetDescendants() do
            if descendant:IsA("BasePart") and descendant.Transparency < 1 then
                TweenService:Create(descendant, TweenInfo.new(0.6), {
                    Transparency = 1
                }):Play();
            end;
        end;

        task.delay(0.7, function() -- Line: 825
            -- upvalues: u136 (copy)
            u136.model:Destroy();
        end);
    end;

    local v137 = false;

    for _, v in u43 do
        if not v.dead then
            v137 = true;
            break;
        end;
    end;

    Highlight.Enabled = v137;
end);

for _, child in PumpkinPeople:GetChildren() do
    build(child);
end;

RunService.RenderStepped:Connect(function(p138) -- Line: 838
    -- upvalues: u43 (copy), sound (copy), Color3_fromRGB_ret5 (copy), Color3_fromRGB_ret (copy)
    local v139 = 1 - math.exp(-12 * p138);
    local os_clock_ret = os.clock();

    for i, v in u43 do
        if not v.dead and v.root.Parent then
            local Attribute = i:GetAttribute("P");
            local Attribute2 = i:GetAttribute("Yaw");

            if typeof(Attribute) == "Vector3" and type(Attribute2) == "number" then
                local Magnitude = (Attribute - v.pos).Magnitude;

                if Magnitude <= 30 then
                    Attribute = v.pos:Lerp(Attribute, v139);
                end;

                v.pos = Attribute;
                v.yaw = v.yaw + ((Attribute2 - v.yaw + 3.141592653589793) % 6.283185307179586 - 3.141592653589793) * v139;
                local v140;

                if v.risePending then
                    v140 = 7.5;

                    if v.tracks.Rise.Length > 0 or os_clock_ret - v.risePending > 1 then
                        v.risePending = nil;
                        v.rise = os_clock_ret;
                        v.tracks.Rise:Play(0);
                        sound("Rise", v.root);
                    end;
                else
                    v140 = 0;
                end;

                if v.rise then
                    local math_clamp_ret = math.clamp((os_clock_ret - v.rise) / 1.3, 0, 1);
                    v140 = (1 - math_clamp_ret) * 7.5 * (1 - math_clamp_ret);

                    if math_clamp_ret >= 1 then
                        v.rise = nil;
                    end;
                end;

                v.root.CFrame = CFrame.new(v.pos - Vector3.new(0, 1, 0) * v140) * CFrame.Angles(0, v.yaw, 0);
                local v141 = not (v.tracks.Rise.IsPlaying or v.tracks.Lunge.IsPlaying) and Magnitude > 0.35;

                if v141 and not v.tracks.Walk.IsPlaying then
                    v.tracks.Walk:Play(0.2);
                elseif not v141 and v.tracks.Walk.IsPlaying then
                    v.tracks.Walk:Stop(0.25);
                end;

                local v142 = v.state == "Tell" and true or v.state == "Lunge";
                local v143 = math.sin(os_clock_ret * 17 + v.seed) * 0.15 + 0.85 + math.sin(os_clock_ret * 7 + v.seed) * 0.1;

                if v.light then
                    v.light.Brightness = (v142 and 5 or 1.6) * v143;
                    local v144;

                    if v142 then
                        v144 = Color3_fromRGB_ret5;
                    else
                        v144 = Color3_fromRGB_ret;
                    end;

                    v.light.Color = v144;
                end;

                if v.flame then
                    v.flame.Rate = v142 and 70 or 22;
                end;

                local v145;

                if v142 then
                    v145 = Color3.fromRGB(255, 70, 30);
                else
                    v145 = Color3.fromRGB(255, 196, 64);
                end;

                local v146 = v;

                for _, v2 in v.face do
                    v2.Color = v145;
                end;

                if v146.mesh then
                    local v147;

                    if v142 then
                        v147 = Vector3.new(2.3, 1.25, 0.75) * v143;
                    else
                        v147 = Vector3.new(1.2, 1.2, 1.2) * (v143 * 0.05 + 0.95);
                    end;

                    v146.mesh.VertexColor = v147;
                end;
            end;
        end;
    end;
end);
local Font_new_ret = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.ExtraBold);
local Font_fromEnum_ret = Font.fromEnum(Enum.Font.Creepster);
local ScreenGui = Instance.new("ScreenGui");
ScreenGui.Name = "PumpkinHuntHud";
ScreenGui.ResetOnSpawn = false;
ScreenGui.DisplayOrder = 63;
ScreenGui.IgnoreGuiInset = true;
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
ScreenGui:SetAttribute("SelfManagedText", true);
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui");
local Color3_fromRGB_ret7 = Color3.fromRGB(255, 125, 25);
local u148 = {};
local u149 = 0;
local u150 = {};

local function label(p151, p152, p153, p154, p155) -- Line: 913
    -- upvalues: Font_new_ret (copy)
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Name = p152;
    TextLabel.BackgroundTransparency = 1;
    TextLabel.FontFace = p155 or Font_new_ret;
    TextLabel.Text = p153;
    TextLabel.TextColor3 = Color3.new(1, 1, 1);
    TextLabel.TextScaled = true;

    for i, v in p154 do
        TextLabel[i] = v;
    end;

    local UIStroke = Instance.new("UIStroke");
    UIStroke.Color = Color3.new(0, 0, 0);
    UIStroke.Thickness = 0.08;
    UIStroke.StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize;
    UIStroke.LineJoinMode = Enum.LineJoinMode.Round;
    UIStroke.Parent = TextLabel;
    TextLabel.Parent = p151;

    return TextLabel;
end;

for _, v in {
    { UDim2.fromScale(1, 0.3), UDim2.fromScale(0, 0), 90 },
    { UDim2.fromScale(1, 0.3), UDim2.fromScale(0, 0.7), -90 },
    { UDim2.fromScale(0.2, 1), UDim2.fromScale(0, 0), 0 },
    { UDim2.fromScale(0.2, 1), UDim2.fromScale(0.8, 0), 180 }
} do
    local Frame = Instance.new("Frame");
    Frame.Name = "Edge";
    local v156 = v[2];
    Frame.Size = v[1];
    Frame.Position = v156;
    Frame.BackgroundColor3 = Color3_fromRGB_ret7;
    Frame.BackgroundTransparency = 1;
    Frame.BorderSizePixel = 0;
    local UIGradient = Instance.new("UIGradient");
    UIGradient.Rotation = v[3];
    UIGradient.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 1) });
    UIGradient.Parent = Frame;
    Frame.Parent = ScreenGui;
    table.insert(u148, Frame);
end;

local function setEdges(p157, p158) -- Line: 956
    -- upvalues: u150 (copy), u148 (copy), TweenService (copy)
    for _, v in u150 do
        v:Cancel();
    end;

    table.clear(u150);

    for _, v in u148 do
        if p158 and p158 > 0 then
            local v159 = TweenService:Create(v, TweenInfo.new(p158), {
                BackgroundTransparency = p157
            });
            table.insert(u150, v159);
            v159:Play();
        else
            v.BackgroundTransparency = p157;
        end;
    end;
end;

local function restEdges() -- Line: 971
    -- upvalues: LocalPlayer (copy), PumpkinHuntConfig (copy)
    return (LocalPlayer:GetAttribute("HuntHits") or 0) == PumpkinHuntConfig.HitsToOut - 1 and LocalPlayer:GetAttribute("HuntOut") ~= true and 0.8 or 1;
end;

local Frame = Instance.new("Frame");
Frame.Name = "Heads";
Frame.AnchorPoint = Vector2.new(1, 0.5);
Frame.Position = UDim2.fromScale(0.985, 0.42);
Frame.Size = UDim2.fromScale(0.17, 0.15);
Frame.BackgroundColor3 = Color3.fromRGB(34, 16, 48);
Frame.BackgroundTransparency = 0.15;
Frame.Visible = false;
Frame.Parent = ScreenGui;
local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint");
UIAspectRatioConstraint.AspectRatio = 2.4;
UIAspectRatioConstraint.Parent = Frame;
local UICorner = Instance.new("UICorner");
UICorner.CornerRadius = UDim.new(0.18, 0);
UICorner.Parent = Frame;
local UIStroke = Instance.new("UIStroke");
UIStroke.Color = Color3_fromRGB_ret;
UIStroke.Thickness = 0.03;
UIStroke.StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize;
UIStroke.Parent = Frame;
local UIScale = Instance.new("UIScale");
UIScale.Parent = Frame;
local ImageLabel = Instance.new("ImageLabel");
ImageLabel.Name = "Icon";
ImageLabel.BackgroundTransparency = 1;
ImageLabel.Image = "rbxassetid://122172980164834";
ImageLabel.ScaleType = Enum.ScaleType.Fit;
ImageLabel.AnchorPoint = Vector2.new(0, 0.5);
ImageLabel.Position = UDim2.fromScale(0.03, 0.5);
ImageLabel.Size = UDim2.fromScale(0.32, 0.86);
ImageLabel.Parent = Frame;
local u160 = label(Frame, "Title", "HEADS COLLECTED", {
    AnchorPoint = Vector2.new(0, 0),
    Position = UDim2.fromScale(0.36, 0.1),
    Size = UDim2.fromScale(0.6, 0.24),
    TextColor3 = Color3_fromRGB_ret2
});
local u161 = label(Frame, "Count", "0", {
    AnchorPoint = Vector2.new(0, 0),
    Position = UDim2.fromScale(0.36, 0.34),
    Size = UDim2.fromScale(0.6, 0.56),
    TextColor3 = Color3_fromRGB_ret
}, Font_fromEnum_ret);
local u162 = label(Frame, "Out", "OUT · your heads are safe", {
    Visible = false,
    AnchorPoint = Vector2.new(0.5, 0),
    Position = UDim2.fromScale(0.5, 1.08),
    Size = UDim2.fromScale(1, 0.26),
    TextColor3 = Color3.fromRGB(255, 120, 120)
});
local u163 = {
    Healthy = {
        Color3.fromRGB(30, 170, 60),
        Color3.fromRGB(70, 225, 95),
        Color3.fromRGB(80, 220, 100),
        Color3.fromRGB(140, 255, 150)
    },
    Hurt = {
        Color3.fromRGB(230, 150, 0),
        Color3.fromRGB(255, 200, 40),
        Color3.fromRGB(255, 190, 40),
        Color3.fromRGB(255, 230, 110)
    },
    Last = {
        Color3.fromRGB(190, 20, 35),
        Color3.fromRGB(245, 60, 60),
        Color3.fromRGB(240, 70, 70),
        Color3.fromRGB(255, 130, 120)
    }
};

local function pill(p164) -- Line: 1042
    local UICorner2 = Instance.new("UICorner");
    UICorner2.CornerRadius = UDim.new(1, 0);
    UICorner2.Parent = p164;
end;

local function rim(p165, p166, p167) -- Line: 1047
    local UIStroke2 = Instance.new("UIStroke");
    UIStroke2.Color = p166;
    UIStroke2.Thickness = p167;
    UIStroke2.StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize;
    UIStroke2.LineJoinMode = Enum.LineJoinMode.Round;
    UIStroke2.Parent = p165;

    return UIStroke2;
end;

local BillboardGui = Instance.new("BillboardGui");
BillboardGui.Name = "PumpkinHuntHealth";
BillboardGui.Size = UDim2.fromScale(3.2, 0.42);
BillboardGui.SizeOffset = Vector2.new(0, 0.5);
BillboardGui.AlwaysOnTop = true;
BillboardGui.LightInfluence = 0;
BillboardGui.ResetOnSpawn = false;
BillboardGui.Enabled = false;
BillboardGui.Parent = ScreenGui.Parent;
local Frame2 = Instance.new("Frame");
Frame2.Name = "HealthBar";
Frame2.AnchorPoint = Vector2.new(0.5, 0.5);
Frame2.Position = UDim2.fromScale(0.5, 0.5);
Frame2.Size = UDim2.fromScale(0.94, 0.7);
Frame2.BackgroundColor3 = Color3.fromRGB(55, 55, 55);
Frame2.BorderSizePixel = 0;
local UICorner2 = Instance.new("UICorner");
UICorner2.CornerRadius = UDim.new(1, 0);
UICorner2.Parent = Frame2;
local Color3_new_ret = Color3.new(0, 0, 0);
local UIStroke2 = Instance.new("UIStroke");
UIStroke2.Color = Color3_new_ret;
UIStroke2.Thickness = 0.15;
UIStroke2.StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize;
UIStroke2.LineJoinMode = Enum.LineJoinMode.Round;
UIStroke2.Parent = Frame2;
local Color3_fromRGB_ret8 = Color3.fromRGB(93, 93, 93);
local UIStroke3 = Instance.new("UIStroke");
UIStroke3.Color = Color3_fromRGB_ret8;
UIStroke3.Thickness = 0.1;
UIStroke3.StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize;
UIStroke3.LineJoinMode = Enum.LineJoinMode.Round;
UIStroke3.Parent = Frame2;
Frame2.Parent = BillboardGui;
local Frame3 = Instance.new("Frame");
Frame3.Name = "Lost";
Frame3.Size = UDim2.fromScale(1, 1);
Frame3.BackgroundColor3 = Color3.fromRGB(255, 236, 220);
Frame3.BorderSizePixel = 0;
Frame3.ZIndex = 1;
local UICorner3 = Instance.new("UICorner");
UICorner3.CornerRadius = UDim.new(1, 0);
UICorner3.Parent = Frame3;
Frame3.Parent = Frame2;
local Frame4 = Instance.new("Frame");
Frame4.Name = "Fill";
Frame4.Size = UDim2.fromScale(1, 1);
Frame4.BackgroundColor3 = Color3.new(1, 1, 1);
Frame4.BorderSizePixel = 0;
Frame4.ZIndex = 2;
local UICorner4 = Instance.new("UICorner");
UICorner4.CornerRadius = UDim.new(1, 0);
UICorner4.Parent = Frame4;
local UIGradient = Instance.new("UIGradient");
UIGradient.Parent = Frame4;
local Color3_new_ret2 = Color3.new(1, 1, 1);
local UIStroke4 = Instance.new("UIStroke");
UIStroke4.Color = Color3_new_ret2;
UIStroke4.Thickness = 0.1;
UIStroke4.StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize;
UIStroke4.LineJoinMode = Enum.LineJoinMode.Round;
UIStroke4.Parent = Frame4;
local UIGradient2 = Instance.new("UIGradient");
UIGradient2.Parent = UIStroke4;
Frame4.Parent = Frame2;
local u168 = {
    { Frame2, "BackgroundTransparency", 0 },
    { UIStroke2, "Transparency", 0 },
    { UIStroke3, "Transparency", 0 },
    { Frame3, "BackgroundTransparency", 0.25 },
    { Frame4, "BackgroundTransparency", 0 },
    { UIStroke4, "Transparency", 0 }
};

local function fadeHealth(p169, p170) -- Line: 1107
    -- upvalues: u168 (copy), TweenService (copy)
    local TweenInfo_new_ret = TweenInfo.new(p170);

    for _, v in u168 do
        TweenService:Create(v[1], TweenInfo_new_ret, {
            [v[2]] = not p169 and 1 or v[3]
        }):Play();
    end;
end;

fadeHealth(false, 0);
local TweenInfo_new_ret = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0.1);
local TweenInfo_new_ret2 = TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, 0, false, 0.45);
local u171 = 1;
local u172 = {};

local function setHealth(p173) -- Line: 1118
    -- upvalues: PumpkinHuntConfig (copy), u163 (copy), UIGradient (copy), UIGradient2 (copy), u171 (ref), u172 (copy), Frame4 (copy), TweenService (copy), TweenInfo_new_ret (copy), Frame3 (copy), TweenInfo_new_ret2 (copy)
    local math_clamp_ret = math.clamp(1 - p173 / PumpkinHuntConfig.HitsToOut, 0, 1);
    local v174;

    if PumpkinHuntConfig.HitsToOut - 1 <= p173 then
        v174 = u163.Last;
    elseif math_clamp_ret <= 0.5 then
        v174 = u163.Hurt;
    else
        v174 = u163.Healthy;
    end;

    UIGradient.Color = ColorSequence.new(v174[1], v174[2]);
    UIGradient2.Color = ColorSequence.new(v174[3], v174[4]);

    if math_clamp_ret == u171 then
        return;
    end;

    for _, v in u172 do
        v:Cancel();
    end;

    table.clear(u172);
    Frame4.Visible = math_clamp_ret > 0;

    if math_clamp_ret < u171 then
        local v175 = {
            Size = UDim2.fromScale(math_clamp_ret, 1)
        };
        table.insert(u172, TweenService:Create(Frame4, TweenInfo_new_ret, v175));
        local v176 = {
            Size = UDim2.fromScale(math_clamp_ret, 1)
        };
        table.insert(u172, TweenService:Create(Frame3, TweenInfo_new_ret2, v176));

        for _, v in u172 do
            v:Play();
        end;
    else
        Frame4.Size = UDim2.fromScale(math_clamp_ret, 1);
        Frame3.Size = Frame4.Size;
    end;

    u171 = math_clamp_ret;
end;

local u177 = 0;

local function showHealth(p178) -- Line: 1150
    -- upvalues: LocalPlayer (copy), setHealth (copy), ScreenGui (copy), BillboardGui (copy), fadeHealth (copy), u177 (ref)
    local v179 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Head");

    if not v179 then
        setHealth(p178);

        return;
    end;

    local v180 = ScreenGui.Parent:FindFirstChild("PlayerOverhead_" .. tostring(LocalPlayer.UserId));
    local v181 = not (v180 and (v180:IsA("BillboardGui") and (v180.Enabled and v180.Adornee == v179))) and 1.5 or v180.StudsOffsetWorldSpace.Y + (v180.SizeOffset.Y + 0.5) * v180.Size.Y.Scale + 0.2;
    BillboardGui.StudsOffsetWorldSpace = Vector3.new(0, v181, 0);
    BillboardGui.Adornee = v179;
    BillboardGui.Enabled = true;
    fadeHealth(true, 0.12);
    setHealth(p178);
    u177 = u177 + 1;
    local u182 = u177;
    task.delay(2, function() -- Line: 1168
        -- upvalues: u177 (ref), u182 (copy), fadeHealth (ref), BillboardGui (ref)
        if u177 ~= u182 then
            return;
        end;

        fadeHealth(false, 0.5);
        task.delay(0.5, function() -- Line: 1173
            -- upvalues: u177 (ref), u182 (ref), BillboardGui (ref)
            if u177 == u182 then
                BillboardGui.Enabled = false;
            end;
        end);
    end);
end;

local function hideHealth() -- Line: 1180
    -- upvalues: BillboardGui (copy), u177 (ref), fadeHealth (copy)
    if BillboardGui.Enabled then
        u177 = u177 + 1;
        fadeHealth(false, 0);
        BillboardGui.Enabled = false;
    end;
end;

local Frame5 = Instance.new("Frame");
Frame5.Name = "Popups";
Frame5.BackgroundTransparency = 1;
Frame5.Size = UDim2.fromScale(1, 1);
Frame5.Parent = ScreenGui;

local function pop(p183, p184, p185) -- Line: 1193
    -- upvalues: label (copy), Frame5 (copy), Font_fromEnum_ret (copy), TweenService (copy)
    local u186 = label(Frame5, "Popup", p183, {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.3),
        Size = UDim2.fromScale(0.5, 0.07),
        TextColor3 = p184
    }, Font_fromEnum_ret);
    local UIScale2 = Instance.new("UIScale");
    UIScale2.Scale = 1.5;
    UIScale2.Parent = u186;
    TweenService:Create(UIScale2, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Scale = 1
    }):Play();
    task.delay(p185, function() -- Line: 1204
        -- upvalues: TweenService (ref), u186 (copy)
        TweenService:Create(u186, TweenInfo.new(0.4), {
            TextTransparency = 1,
            Position = UDim2.fromScale(0.5, 0.25)
        }):Play();
        TweenService:Create(u186.UIStroke, TweenInfo.new(0.4), {
            Transparency = 1
        }):Play();
        task.delay(0.45, function() -- Line: 1207
            -- upvalues: u186 (ref)
            u186:Destroy();
        end);
    end);
end;

local u187 = 0;

local function refresh() -- Line: 1214
    -- upvalues: Session (copy), LocalPlayer (copy), Frame (copy), result (copy), u160 (copy), ImageLabel (copy), u161 (copy), PumpkinHuntConfig (copy), u162 (copy), BillboardGui (copy), u177 (ref), fadeHealth (copy), setHealth (copy), u187 (ref), UIScale (copy), TweenService (copy), u150 (copy), u148 (copy), u149 (ref)
    local v188;

    if Session:GetAttribute("AdminMatchMode") == "PumpkinHunt" then
        v188 = LocalPlayer:GetAttribute("InMatch") == true;
    else
        v188 = false;
    end;

    Frame.Visible = v188;
    local v189 = LocalPlayer:GetAttribute("HuntHeads") or 0;
    local v190 = LocalPlayer:GetAttribute("HuntHits") or 0;
    local v191 = result.restricted();
    u160.Text = v191 and "COINS COLLECTED" or "HEADS COLLECTED";
    ImageLabel.Image = v191 and "rbxassetid://78008558948307" or "rbxassetid://122172980164834";
    local v192;

    if v191 then
        v192 = PumpkinHuntConfig.commas(v189 * PumpkinHuntConfig.RestrictedCoins);
    else
        v192 = tostring(v189);
    end;

    u161.Text = v192;
    u162.Visible = LocalPlayer:GetAttribute("HuntOut") == true;

    if not v188 and BillboardGui.Enabled then
        u177 = u177 + 1;
        fadeHealth(false, 0);
        BillboardGui.Enabled = false;
    end;

    if v190 == 0 then
        setHealth(0);
    end;

    if v189 ~= u187 then
        if u187 < v189 then
            UIScale.Scale = 1.3;
            TweenService:Create(UIScale, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Scale = 1
            }):Play();
        end;

        u187 = v189;
    end;

    if v188 then
        if u149 <= os.clock() then
            local v193 = (LocalPlayer:GetAttribute("HuntHits") or 0) == PumpkinHuntConfig.HitsToOut - 1 and LocalPlayer:GetAttribute("HuntOut") ~= true and 0.8 or 1;

            for _, v in u150 do
                v:Cancel();
            end;

            table.clear(u150);

            for _, v in u148 do
                v.BackgroundTransparency = v193;
            end;
        end;

        return;
    end;

    for _, v in u150 do
        v:Cancel();
    end;

    table.clear(u150);

    for _, v in u148 do
        v.BackgroundTransparency = 1;
    end;
end;

for _, v in { "HuntHeads", "HuntHits", "HuntOut", "InMatch" } do
    LocalPlayer:GetAttributeChangedSignal(v):Connect(refresh);
end;

Session:GetAttributeChangedSignal("AdminMatchMode"):Connect(refresh);
result.Changed.Event:Connect(refresh);
refresh();
LocalPlayer:GetAttributeChangedSignal("HuntHeads"):Connect(function() -- Line: 1253
    -- upvalues: LocalPlayer (copy), result (copy), pop (copy), PumpkinHuntConfig (copy), Color3_fromRGB_ret6 (copy), Color3_fromRGB_ret (copy)
    if (LocalPlayer:GetAttribute("HuntHeads") or 0) > 0 then
        if result.restricted() then
            pop("ANKLES BROKEN!  +" .. PumpkinHuntConfig.commas(PumpkinHuntConfig.RestrictedCoins) .. " COINS", Color3_fromRGB_ret6, 1.1);

            return;
        end;

        pop("ANKLES BROKEN!  +1 HEAD", Color3_fromRGB_ret, 1.1);
    end;
end);
PumpkinPeopleEvent.OnClientEvent:Connect(function(p194, p195, p196, p197, p198) -- Line: 1265
    -- upvalues: Players (copy), flashModel (copy), Color3_fromRGB_ret5 (copy), burst (copy), Color3_fromRGB_ret4 (copy), sound (copy), LocalPlayer (copy), u150 (copy), u148 (copy), setEdges (copy), PumpkinHuntConfig (copy), u149 (ref), u38 (ref), u37 (ref), showHealth (copy), pop (copy), Color3_fromRGB_ret7 (copy), refresh (copy)
    if p194 ~= "Hit" then
        return;
    end;

    local PlayerByUserId = Players:GetPlayerByUserId(p195 or 0);

    if PlayerByUserId then
        PlayerByUserId = PlayerByUserId.Character;
    end;

    local v199;

    if PlayerByUserId then
        v199 = PlayerByUserId:FindFirstChild("HumanoidRootPart");
    else
        v199 = PlayerByUserId;
    end;

    if PlayerByUserId then
        flashModel(PlayerByUserId, Color3_fromRGB_ret5, 0.35);
    end;

    if v199 then
        burst(v199.Position + Vector3.new(0, 0.5, 0), { Color3_fromRGB_ret5, Color3_fromRGB_ret4 }, 14, 16);
        sound(p198 and "Out" or "Hit", v199);
    end;

    if p195 ~= LocalPlayer.UserId then
        return;
    end;

    for _, v in u150 do
        v:Cancel();
    end;

    table.clear(u150);

    for _, v in u148 do
        v.BackgroundTransparency = 0.05;
    end;

    setEdges((LocalPlayer:GetAttribute("HuntHits") or 0) == PumpkinHuntConfig.HitsToOut - 1 and LocalPlayer:GetAttribute("HuntOut") ~= true and 0.8 or 1, 0.9);
    u149 = os.clock() + 0.95;
    u38 = p198 and 0.08 or 0.05;
    u37 = os.clock() + 0.25;
    showHealth(p196);

    if p198 then
        pop("YOU\'RE OUT!  You keep your heads", Color3_fromRGB_ret5, 2);
    else
        pop(PumpkinHuntConfig.HitsToOut - 1 <= p196 and "HIT!  LOW HEALTH" or "HIT!", Color3_fromRGB_ret7, 0.9);
    end;

    refresh();
end);