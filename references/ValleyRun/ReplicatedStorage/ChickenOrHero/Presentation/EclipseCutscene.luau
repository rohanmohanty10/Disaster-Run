 

 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local SoundService = game:GetService("SoundService");
local TweenService = game:GetService("TweenService");
local UserInputService = game:GetService("UserInputService");
local Lighting = game:GetService("Lighting");
local StarterGui = game:GetService("StarterGui");
local ProximityPromptService = game:GetService("ProximityPromptService");
local LocalPlayer = Players.LocalPlayer;
local ChickenOrHero = ReplicatedStorage:WaitForChild("ChickenOrHero");
local Presentation = ChickenOrHero:WaitForChild("Presentation");
local CreatorVisibility = require(Presentation:WaitForChild("CreatorVisibility"));
local LocalHide = require(Presentation:WaitForChild("LocalHide"));
local CutsceneScreen = require(Presentation:WaitForChild("CutsceneScreen"));
local u1 = {
    HAND_BACK = 0.75
};
local u2 = {
    Shirt = true,
    Pants = true,
    ShirtGraphic = true,
    BodyColors = true
};
local u3 = {
    HeadColor3 = { "Head" },
    TorsoColor3 = { "Torso", "UpperTorso" },
    LeftArmColor3 = { "Left Arm", "LeftUpperArm" },
    RightArmColor3 = { "Right Arm", "RightUpperArm" },
    LeftLegColor3 = { "Left Leg", "LeftUpperLeg" },
    RightLegColor3 = { "Right Leg", "RightUpperLeg" }
};
local u4 = { "Atmosphere", "BloomEffect", "SunRaysEffect", "DepthOfFieldEffect", "ColorCorrectionEffect", "BlurEffect" };
local u5 = {
    EventStart = {
        Id = "rbxassetid://131578930282836",
        Volume = 0.45,
        Lead = 0
    }
};
local u6 = {
    EventStart = { {
            At = 21,
            Text = "so cold…",
            For = 3.35
        }, {
            At = 26,
            Text = "where are they..",
            For = 5.35
        }, {
            At = 33,
            Text = "they carved my name into stone..\nand thought it would hold me",
            For = 5.9
        }, {
            At = 45,
            Text = "where were we.."
        } }
};
local Font_new_ret = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.SemiBold);
local success, result = pcall(function() -- Line: 129
    -- upvalues: ChickenOrHero (copy)
    return require(ChickenOrHero:WaitForChild("Movement"):WaitForChild("MovementConfig")).Camera;
end);
local u7;

if success and (type(result) == "table" and typeof(result.ShoulderOffset) == "Vector3") then
    u7 = result.ShoulderOffset;
else
    u7 = nil;
end;

local function arrivedFolder() -- Line: 140
    -- upvalues: ReplicatedStorage (copy)
    local v8 = os.clock() + 180;
    local v9 = os.clock() + 10;
    local os_clock_ret = os.clock();
    local v10 = -1;

    while os.clock() < v8 do
        local EclipseCutscenes = ReplicatedStorage:FindFirstChild("EclipseCutscenes");
        local v11;

        if EclipseCutscenes then
            v11 = EclipseCutscenes:GetAttribute("Modules");
        else
            v11 = EclipseCutscenes;
        end;

        local v12 = 0;
        local v13 = 0;

        if EclipseCutscenes then
            for _, descendant in EclipseCutscenes:GetDescendants() do
                v13 = v13 + 1;

                if descendant:IsA("ModuleScript") then
                    v12 = v12 + 1;
                end;
            end;

            if v13 ~= v10 then
                os_clock_ret = os.clock();
                v10 = v13;
            end;

            if (type(v11) ~= "number" or v11 <= v12) and os.clock() - os_clock_ret >= 1 then
                return EclipseCutscenes;
            end;
        end;

        if v9 <= os.clock() then
            v9 = os.clock() + 10;
            warn(("[EclipseCutscene] still waiting for ReplicatedStorage.EclipseCutscenes to arrive (%s of %s scripts, %d pieces)"):format(not EclipseCutscenes and "no folder yet," or tostring(v12), tostring(v11 or "?"), v13));
        end;

        task.wait(0.25);
    end;

    return nil;
end;

local u14 = {};

function u1.load(u15) -- Line: 180
    -- upvalues: u14 (copy), ReplicatedStorage (copy), arrivedFolder (copy)
    local v16 = u14[u15];

    if v16 and v16.module:IsDescendantOf(ReplicatedStorage) then
        return v16.api;
    end;

    local u17 = arrivedFolder();

    if u17 then
        u17 = u17:FindFirstChild(u15);
    end;

    if not (u17 and u17:IsA("ModuleScript")) then
        return nil, "no ReplicatedStorage.EclipseCutscenes." .. tostring(u15);
    end;

    local v18 = u14[u15];

    if v18 and v18.module == u17 then
        return v18.api;
    end;

    local success2, result2 = pcall(require, u17);

    if not success2 then
        return nil, result2;
    end;

    if type(result2) ~= "table" or type(result2.new) ~= "function" then
        return nil, u15 .. " isn\'t an Eclipse cutscene (no .new)";
    end;

    local u19 = {
        module = u17,
        api = result2
    };
    u14[u15] = u19;
    u19.gone = u17.AncestryChanged:Connect(function() -- Line: 205
        -- upvalues: u17 (copy), ReplicatedStorage (ref), u14 (ref), u15 (copy), u19 (copy)
        if not u17:IsDescendantOf(ReplicatedStorage) and u14[u15] == u19 then
            u19.gone:Disconnect();
            u14[u15] = nil;
        end;
    end);

    return result2;
end;

function u1.preload(p20) -- Line: 215
    -- upvalues: u1 (copy)
    local v21, v22 = u1.load(p20);

    if not v21 then
        return nil, v22;
    end;

    if type(v21.Preload) == "function" then
        local success2, result2 = pcall(v21.Preload);

        if not success2 then
            return nil, result2;
        end;
    end;

    return true;
end;

local function ours(p23) -- Line: 231
    if p23:GetAttribute("CreatorCaptureExempt") == true or p23:GetAttribute("EclipseEffectSurface") == true then
        return true;
    end;

    while p23 and p23 ~= game do
        local Parent = p23.Parent;

        if Parent and (Parent == workspace or Parent:IsA("PlayerGui")) and (string.sub(p23.Name, 1, 16) == "EclipseCutscene_" or p23.Name == "VermillionScreenFlipbook") then
            return true;
        end;

        p23 = Parent;
    end;

    return false;
end;

local function hideHud() -- Line: 252
    -- upvalues: LocalPlayer (copy), ours (copy), CreatorVisibility (copy), RunService (copy), ProximityPromptService (copy), StarterGui (copy)
    local v24 = LocalPlayer:GetAttribute("CreatorUIHidden") == true;

    for _, v in { LocalPlayer:FindFirstChildOfClass("PlayerGui"), workspace } do
        for _, v2 in v and v:GetDescendants() or {} do
            if v2:IsA("LayerCollector") and ours(v2) then
                v2:SetAttribute("CreatorCaptureExempt", true);
            end;
        end;
    end;

    local u25 = CreatorVisibility.new(LocalPlayer);
    u25:setHidden(true);

    if v24 then
        u25.promptEnabled = true;
        u25.topbar = true;
    end;

    local u26 = 0;
    local u28 = RunService.Heartbeat:Connect(function(p27) -- Line: 274
        -- upvalues: u26 (ref), ProximityPromptService (ref), StarterGui (ref)
        u26 = u26 + p27;

        if u26 < 0.25 then
            return;
        end;

        u26 = 0;

        if ProximityPromptService.Enabled then
            ProximityPromptService.Enabled = false;
        end;

        local success2, result2 = pcall(StarterGui.GetCore, StarterGui, "TopbarEnabled");

        if success2 and result2 then
            pcall(StarterGui.SetCore, StarterGui, "TopbarEnabled", false);
        end;
    end);

    local function release(p29) -- Line: 289
        -- upvalues: ours (ref), u25 (copy)
        if not (p29:IsA("LayerCollector") and ours(p29)) then
            return;
        end;

        p29:SetAttribute("CreatorCaptureExempt", true);
        local v30 = u25.records and u25.records[p29];

        if v30 then
            v30.connection:Disconnect();
            u25.records[p29] = nil;
            p29.Enabled = v30.wanted;
        end;
    end;

    local u31 = {};

    for _, v in { LocalPlayer:FindFirstChildOfClass("PlayerGui"), workspace } do
        if v then
            table.insert(u31, v.DescendantAdded:Connect(function(p32) -- Line: 304
                -- upvalues: release (copy)
                task.defer(release, p32);
            end));
        end;
    end;

    return function() -- Line: 309
        -- upvalues: u28 (copy), u31 (copy), u25 (copy)
        u28:Disconnect();

        for _, v in u31 do
            v:Disconnect();
        end;

        u25:destroy();
    end;
end;

local u33 = setmetatable({}, {
    __mode = "k"
});

local function muteGame() -- Line: 323
    -- upvalues: SoundService (copy), u33 (copy), TweenService (copy), LocalPlayer (copy)
    local u34 = {};

    for _, descendant in SoundService:GetDescendants() do
        if descendant:IsA("SoundGroup") then
            u34[descendant] = u33[descendant] or descendant.Volume;
            u33[descendant] = nil;
            TweenService:Create(descendant, TweenInfo.new(1), {
                Volume = 0
            }):Play();
        end;
    end;

    LocalPlayer:SetAttribute("MusicPaused", true);

    return function() -- Line: 333
        -- upvalues: LocalPlayer (ref), u34 (copy), u33 (ref), TweenService (ref)
        LocalPlayer:SetAttribute("MusicPaused", nil);

        for i, v in u34 do
            if i.Parent then
                u33[i] = v;
                local v35 = TweenService:Create(i, TweenInfo.new(1.2), {
                    Volume = v
                });
                v35.Completed:Connect(function() -- Line: 339
                    -- upvalues: u33 (ref), i (copy), v (copy)
                    if u33[i] == v then
                        u33[i] = nil;
                    end;
                end);
                v35:Play();
            end;
        end;
    end;
end;

local u36 = { "THE VALLEY GROWS COLD...", "SOMETHING STIRS BENEATH THE STONE...", "THE FALLEN KING AWAKENS", "THROW PUMPKINS. DODGE HIS AXES.", "STAY TOGETHER. SURVIVE." };
local u37 = nil;

local function openSession() -- Line: 364
    -- upvalues: u37 (ref), LocalPlayer (copy), muteGame (copy), hideHud (copy), CutsceneScreen (copy), u36 (copy)
    if u37 then
        return u37;
    end;

    local v38 = {
        playing = false,
        undo = {}
    };
    u37 = v38;
    LocalPlayer:SetAttribute("CutsceneActive", true);
    table.insert(v38.undo, function() -- Line: 371
        -- upvalues: LocalPlayer (ref)
        LocalPlayer:SetAttribute("CutsceneActive", nil);
    end);

    for i, v in {
        sound = muteGame,
        hud = hideHud
    } do
        local success2, result2 = pcall(v);

        if success2 and type(result2) == "function" then
            table.insert(v38.undo, result2);
        elseif not success2 then
            warn("[EclipseCutscene] couldn\'t hold the " .. i .. ": " .. tostring(result2));
        end;
    end;

    local CutsceneCover = CutsceneScreen.new("CutsceneCover", 10000);
    CutsceneCover:SetAttribute("CreatorCaptureExempt", true);
    local Frame = Instance.new("Frame");
    Frame.Name = "Black";
    Frame.Size = UDim2.fromScale(1, 1);
    Frame.BackgroundColor3 = Color3.new(0, 0, 0);
    Frame.BackgroundTransparency = 1;
    Frame.BorderSizePixel = 0;
    Frame.Parent = CutsceneCover;
    CutsceneCover:SetAttribute("SelfManagedText", true);

    local function line(p39, p40, p41, p42, p43, p44) -- Line: 398
        -- upvalues: Frame (copy)
        local TextLabel = Instance.new("TextLabel");
        TextLabel.Name = p39;
        TextLabel.BackgroundTransparency = 1;
        TextLabel.AnchorPoint = Vector2.new(0.5, 0.5);
        TextLabel.Position = UDim2.fromScale(0.5, p41);
        TextLabel.Size = UDim2.fromScale(0.8, p42);
        TextLabel.FontFace = Font.new("rbxasset://fonts/families/BuilderSans.json", p44);
        TextLabel.TextScaled = true;
        TextLabel.TextColor3 = p43;
        TextLabel.TextTransparency = 1;
        TextLabel.Text = p40;
        TextLabel.Parent = Frame;

        return TextLabel;
    end;

    local u45 = line("Loading", u36[1], 0.8, 0.05, Color3.fromRGB(214, 196, 240), Enum.FontWeight.Heavy);
    local u46 = line("LoadingHint", "Loading the cutscene", 0.855, 0.03, Color3.fromRGB(150, 140, 170), Enum.FontWeight.Medium);
    v38.loading = { u45, u46 };
    CutsceneCover.Parent = LocalPlayer:WaitForChild("PlayerGui");
    v38.black = Frame;
    task.spawn(function() -- Line: 418
        -- upvalues: CutsceneCover (copy), u45 (copy), u36 (ref)
        local v47 = 0;

        while true do
            if not (CutsceneCover.Parent and u45.Parent) then
                return;
            end;

            v47 = v47 % #u36 + 1;
            u45.Text = u36[v47];
            local v48 = utf8.len(u45.Text) or #u45.Text;
            local os_clock_ret = os.clock();

            while CutsceneCover.Parent and u45.Parent do
                local v49 = os.clock() - os_clock_ret;

                if v49 >= 4 then
                    break;
                end;

                local math_floor_ret = math.floor(v49 / 1.2 * v48);
                u45.MaxVisibleGraphemes = math.min(v48, math_floor_ret);
                task.wait(0.03);
            end;
        end;
    end);
    task.spawn(function() -- Line: 436
        -- upvalues: CutsceneCover (copy), u46 (copy)
        local v50 = 0;

        while CutsceneCover.Parent and u46.Parent do
            v50 = v50 % 3 + 1;
            u46.Text = "Loading the cutscene" .. string.rep(".", v50) .. string.rep(" ", 3 - v50);
            task.wait(0.45);
        end;
    end);
    table.insert(v38.undo, function() -- Line: 445
        -- upvalues: CutsceneCover (copy)
        CutsceneCover:Destroy();
    end);

    return v38;
end;

local function fade(p51, p52, p53) -- Line: 450
    -- upvalues: TweenService (copy)
    if p51.black and p51.black.Parent then
        TweenService:Create(p51.black, TweenInfo.new(p53), {
            BackgroundTransparency = p52
        }):Play();
    end;

    local v54 = p52 < 1;

    for _, v in p51.loading or {} do
        if v.Parent then
            TweenService:Create(v, TweenInfo.new(v54 and 0.6 or math.min(p53, 0.3), Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, not v54 and 0 or p53), {
                TextTransparency = p52
            }):Play();
        end;
    end;
end;

local function closeSession(p55) -- Line: 469
    -- upvalues: u37 (ref)
    if u37 ~= p55 then
        return;
    end;

    u37 = nil;

    for i = #p55.undo, 1, -1 do
        local success2, result2 = pcall(p55.undo[i]);
        local v56;

        if success2 then
            v56 = i;
        else
            warn("[EclipseCutscene] putting things back: " .. tostring(result2));
            v56 = i;
        end;
    end;
end;

task.spawn(function() -- Line: 484
    -- upvalues: u37 (ref), LocalPlayer (copy)
    while true do
        repeat
            task.wait(5);
        until u37 == nil and LocalPlayer:GetAttribute("CutsceneActive") ~= nil;

        warn("[EclipseCutscene] a cutscene hold was left behind; let go");
        LocalPlayer:SetAttribute("CutsceneActive", nil);
    end;
end);
local u57 = 0;

function u1.notice(u58, u59) -- Line: 498
    -- upvalues: u57 (ref), LocalPlayer (copy), CutsceneScreen (copy)
    u57 = u57 + 1;
    local u60 = u57;
    local v61 = LocalPlayer:FindFirstChildOfClass("PlayerGui");
    local v62;

    if v61 then
        v62 = v61:FindFirstChild("CutsceneNotice");
    else
        v62 = v61;
    end;

    if v62 then
        v62:Destroy();
    end;

    local CutsceneNotice = CutsceneScreen.new("CutsceneNotice", 10001);
    CutsceneNotice:SetAttribute("CreatorCaptureExempt", true);
    CutsceneNotice:SetAttribute("SelfManagedText", true);
    local Frame = Instance.new("Frame");
    Frame.Name = "Panel";
    Frame.AnchorPoint = Vector2.new(0.5, 0);
    Frame.Position = UDim2.fromScale(0.5, 0.14);
    Frame.Size = UDim2.fromScale(0.62, 0.11);
    Frame.BackgroundColor3 = Color3.fromRGB(14, 12, 20);
    Frame.BackgroundTransparency = 0.12;
    Frame.BorderSizePixel = 0;
    Frame.Parent = CutsceneNotice;
    local UISizeConstraint = Instance.new("UISizeConstraint");
    UISizeConstraint.MinSize = Vector2.new(260, 56);
    UISizeConstraint.MaxSize = Vector2.new(780, 112);
    UISizeConstraint.Parent = Frame;
    local UICorner = Instance.new("UICorner");
    UICorner.CornerRadius = UDim.new(0.2, 0);
    UICorner.Parent = Frame;
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Thickness = 2;
    UIStroke.Color = Color3.fromRGB(120, 255, 170);
    UIStroke.Transparency = 0.25;
    UIStroke.Parent = Frame;
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Name = "Text";
    TextLabel.AnchorPoint = Vector2.new(0.5, 0.5);
    TextLabel.Position = UDim2.fromScale(0.5, 0.5);
    TextLabel.Size = UDim2.fromScale(0.92, 0.76);
    TextLabel.BackgroundTransparency = 1;
    TextLabel.Font = Enum.Font.GothamBold;
    TextLabel.TextScaled = true;
    TextLabel.TextWrapped = true;
    TextLabel.TextColor3 = Color3.fromRGB(245, 243, 231);
    TextLabel.Text = "";
    TextLabel.Parent = Frame;
    CutsceneNotice.Parent = v61 or LocalPlayer:WaitForChild("PlayerGui");
    local os_clock_ret = os.clock();
    task.spawn(function() -- Line: 544
        -- upvalues: u57 (ref), u60 (copy), CutsceneNotice (copy), u59 (copy), TextLabel (copy), u58 (copy), os_clock_ret (copy)
        local v63 = nil;

        while u57 == u60 and CutsceneNotice.Parent do
            local v64;

            if type(u59) == "number" then
                local v65 = u59 - workspace:GetServerTimeNow();
                v64 = math.ceil(v65);
            else
                v64 = 0;
            end;

            if v64 > 0 then
                TextLabel.Text = u58:gsub("{s}", (tostring(v64)));
            else
                TextLabel.Text = type(u59) == "number" and "The fight is starting!" or u58:gsub("{s}", "a few ");
                v63 = v63 or os.clock();

                if os.clock() - v63 >= 3 and os.clock() - os_clock_ret >= 10 then
                    break;
                end;
            end;

            task.wait(0.2);
        end;

        CutsceneNotice:Destroy();
    end);
end;

local u66 = {
    Late = "The cutscene couldn\'t load in time on your screen. The fight starts in {s}s, stay where you are!",
    Error = "The cutscene stopped early on your screen. The fight starts in {s}s, stay where you are!",
    Missing = "The cutscene couldn\'t load on your screen. The fight starts in {s}s, stay where you are!",
    Server = "Something went wrong with the cutscene. The fight is starting, stay where you are!",
    NoPlay = "The cutscene couldn\'t start. The fight is starting, stay where you are!"
};

local function playerModule() -- Line: 574
    -- upvalues: LocalPlayer (copy)
    local PlayerScripts = LocalPlayer:FindFirstChild("PlayerScripts");

    if PlayerScripts then
        PlayerScripts = PlayerScripts:FindFirstChild("PlayerModule");
    end;

    if not PlayerScripts then
        return nil;
    end;

    local success2, result2 = pcall(require, PlayerScripts);

    if success2 then
        return result2;
    end;

    return nil;
end;

local function playerCameraPose() -- Line: 583
    -- upvalues: LocalPlayer (copy), UserInputService (copy), u7 (ref)
    local Character = LocalPlayer.Character;
    local v67;

    if Character then
        v67 = Character:FindFirstChild("HumanoidRootPart");
    else
        v67 = Character;
    end;

    if Character then
        Character = Character:FindFirstChildOfClass("Humanoid");
    end;

    local u68 = nil;
    local u69 = nil;
    local PlayerScripts = LocalPlayer:FindFirstChild("PlayerScripts");

    if PlayerScripts then
        PlayerScripts = PlayerScripts:FindFirstChild("PlayerModule");
    end;

    local u70;

    if PlayerScripts then
        local v71;
        v71, u70 = pcall(require, PlayerScripts);

        if not v71 then
            u70 = nil;
        end;
    else
        u70 = nil;
    end;

    if u70 then
        pcall(function() -- Line: 590
            -- upvalues: u70 (copy), u68 (ref), u69 (ref)
            local activeCameraController = u70:GetCameras().activeCameraController;

            if activeCameraController then
                u68 = activeCameraController:GetSubjectPosition();
                u69 = activeCameraController:GetCameraToSubjectDistance();
            end;
        end);
    end;

    if typeof(u68) ~= "Vector3" then
        if v67 then
            u68 = v67.Position + Vector3.new(0, 1.5, 0);
        else
            u68 = workspace.CurrentCamera.Focus.Position;
        end;
    end;

    u69 = (type(u69) ~= "number" or u69 < 0.6) and 12.5 or u69;
    local v72 = Vector3.new(0, 0, -1);

    if v67 then
        local v73 = v67.CFrame.LookVector * Vector3.new(1, 0, 1);

        if v73.Magnitude > 0.001 then
            v72 = v73.Unit;
        end;
    end;

    local LookVector = (CFrame.lookAt(Vector3.new(0, 0, 0), v72) * CFrame.Angles(-0.2617993877991494, 0, 0)).LookVector;
    local CFrame_lookAt_ret = CFrame.lookAt(u68 - LookVector * u69, u68);

    if not (u7 and ((LocalPlayer:GetAttribute("InMatch") == true or UserInputService.PreferredInput ~= Enum.PreferredInput.KeyboardAndMouse) and (v67 and Character))) then
        return CFrame_lookAt_ret, u68;
    end;

    local v74 = v67.CFrame:VectorToWorldSpace(u7 - Character.CameraOffset);

    return CFrame_lookAt_ret + v74, u68 + v74;
end;

local function handBack(u75, u76, u77, u78) -- Line: 624
    -- upvalues: RunService (copy), playerCameraPose (copy), LocalPlayer (copy), TweenService (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    workspace_CurrentCamera.CameraType = Enum.CameraType.Scriptable;
    local os_clock_ret = os.clock();
    local u79 = false;

    local function finish() -- Line: 630
        -- upvalues: u79 (ref), RunService (ref), playerCameraPose (ref), LocalPlayer (ref), workspace_CurrentCamera (copy), FieldOfView (copy), u78 (copy)
        if u79 then
            return;
        end;

        u79 = true;
        pcall(RunService.UnbindFromRenderStep, RunService, "EclipseCutsceneHandBack");
        local v80, v81 = playerCameraPose();
        local v82 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid");

        if v82 and workspace_CurrentCamera.CameraSubject ~= v82 then
            workspace_CurrentCamera.CameraSubject = v82;
        end;

        workspace_CurrentCamera.CameraType = Enum.CameraType.Custom;
        workspace_CurrentCamera.FieldOfView = FieldOfView;
        workspace_CurrentCamera.CFrame = v80;
        workspace_CurrentCamera.Focus = CFrame.new(v81);
        u78();
    end;

    if u77 <= 0 or typeof(u75) ~= "CFrame" then
        finish();

        return;
    end;

    if type(u76) ~= "number" then
        u76 = FieldOfView;
    end;

    RunService:BindToRenderStep("EclipseCutsceneHandBack", Enum.RenderPriority.Camera.Value + 5, function() -- Line: 652
        -- upvalues: os_clock_ret (copy), u77 (copy), finish (copy), TweenService (ref), workspace_CurrentCamera (copy), u75 (copy), playerCameraPose (ref), u76 (ref), FieldOfView (copy)
        local v83 = (os.clock() - os_clock_ret) / u77;
        local math_clamp_ret = math.clamp(v83, 0, 1);

        if math_clamp_ret >= 1 then
            finish();

            return;
        end;

        local Value = TweenService:GetValue(math_clamp_ret, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
        workspace_CurrentCamera.CFrame = u75:Lerp(playerCameraPose(), Value);
        workspace_CurrentCamera.FieldOfView = u76 + (FieldOfView - u76) * Value;
    end);
    task.delay(u77 + 1, finish);
end;

local function rigsIn(p84, u85, u86, u87) -- Line: 668
    -- upvalues: Players (copy)
    local function kept(p88) -- Line: 669
        -- upvalues: u85 (copy)
        local string_lower_ret = string.lower(p88);

        for _, v in u85 do
            if string.find(string_lower_ret, string.lower(v), 1, true) then
                return true;
            end;
        end;

        return false;
    end;

    local function consider(p89) -- Line: 678
        -- upvalues: u87 (copy), Players (ref), kept (copy), u86 (copy)
        if u87[p89] or not (p89:IsA("Model") and p89:FindFirstChildOfClass("Humanoid")) then
            return;
        end;

        if Players:GetPlayerFromCharacter(p89) or p89:GetAttribute("IsBot") == true then
            return;
        end;

        u87[p89] = true;

        if not kept(p89.Name) then
            table.insert(u86, p89);
        end;
    end;

    if p84:IsA("Model") then
        consider(p84);
    end;

    for _, descendant in p84:GetDescendants() do
        if descendant:IsA("Humanoid") and descendant.Parent then
            consider(descendant.Parent);
        end;
    end;
end;

local function standIns(p90, p91, p92) -- Line: 700
    -- upvalues: rigsIn (copy)
    local v93 = {};
    local v94 = {};

    if p90 then
        rigsIn(p90, p91, v93, v94);
    end;

    local u95 = {};

    for i, v in p92 do
        u95[v] = i;
    end;

    table.sort(v93, function(p96, p97) -- Line: 709
        -- upvalues: u95 (copy)
        local v98 = u95[p96.Name] or (1 / 0);
        local v99 = u95[p97.Name] or (1 / 0);

        if v98 == v99 then
            return p96.Name < p97.Name;
        end;

        return v98 < v99;
    end);

    return v93;
end;

local function attach(p100, p101) -- Line: 720
    local Handle = p101:FindFirstChild("Handle");
    local v102 = Handle and Handle:IsA("BasePart") and Handle:FindFirstChildOfClass("Attachment");
    local v103;

    if v102 then
        v103 = p100:FindFirstChild(v102.Name, true);
    else
        v103 = v102;
    end;

    if not (v103 and (v103:IsA("Attachment") and v103.Parent:IsA("BasePart"))) then
        p101:Destroy();

        return;
    end;

    for _, child in Handle:GetChildren() do
        if child:IsA("JointInstance") or child:IsA("WeldConstraint") then
            child:Destroy();
        end;
    end;

    Handle.Anchored = false;
    Handle.CanCollide = false;
    Handle.CanTouch = false;
    Handle.CanQuery = false;
    Handle.Massless = true;
    p101.Parent = p100;
    local Weld = Instance.new("Weld");
    Weld.Name = "AccessoryWeld";
    Weld.Part0 = v103.Parent;
    Weld.Part1 = Handle;
    Weld.C0 = v103.CFrame;
    Weld.C1 = v102.CFrame;
    Weld.Parent = Handle;
end;

local function dress(p104, p105) -- Line: 749
    -- upvalues: u2 (copy), u3 (copy), attach (copy)
    for _, child in p104:GetChildren() do
        if child:IsA("Accessory") or u2[child.ClassName] then
            child:Destroy();
        end;
    end;

    local v106 = p105:FindFirstChildOfClass("BodyColors");

    if v106 then
        v106:Clone().Parent = p104;
    else
        local BodyColors = Instance.new("BodyColors");

        for i, v in u3 do
            local v107 = i;

            for _, v2 in v do
                local v108 = p105:FindFirstChild(v2);

                if v108 and v108:IsA("BasePart") then
                    BodyColors[v107] = v108.Color;
                    break;
                end;
            end;
        end;

        BodyColors.Parent = p104;
    end;

    for _, child in p105:GetChildren() do
        if u2[child.ClassName] and not child:IsA("BodyColors") then
            child:Clone().Parent = p104;
        elseif child:IsA("Accessory") then
            attach(p104, child:Clone());
        end;
    end;

    local Head = p104:FindFirstChild("Head");
    local Head2 = p105:FindFirstChild("Head");

    if Head2 then
        Head2 = Head2:FindFirstChildOfClass("Decal");
    end;

    if Head and Head2 then
        for _, child in Head:GetChildren() do
            if child:IsA("Decal") and child.Name == Head2.Name then
                child:Destroy();
            end;
        end;

        Head2:Clone().Parent = Head;
    end;
end;

local function castLooks(p109) -- Line: 792
    local v110 = {};

    if not p109 then
        return v110;
    end;

    for _, child in p109:GetChildren() do
        if child:IsA("Model") and type(child:GetAttribute("Slot")) == "number" then
            table.insert(v110, child);
        end;
    end;

    table.sort(v110, function(p111, p112) -- Line: 802
        return p111:GetAttribute("Slot") < p112:GetAttribute("Slot");
    end);

    return v110;
end;

local function castAll(p113, p114) -- Line: 808
    -- upvalues: castLooks (copy), dress (copy)
    local v115 = castLooks(p114);

    for i, v in p113 do
        local v116 = v115[i];

        if not v116 then
            break;
        end;

        local success2, result2 = pcall(dress, v, v116);

        if not success2 then
            warn("[EclipseCutscene] couldn\'t dress " .. v.Name .. ": " .. tostring(result2));
        end;
    end;
end;

local u117 = nil;

function u1.current() -- Line: 824
    -- upvalues: u117 (ref)
    return u117;
end;

function u1.cover(p118, p119, p120) -- Line: 830
    -- upvalues: openSession (copy), fade (copy), u37 (ref), u1 (copy), closeSession (copy)
    local u121 = openSession();
    fade(u121, 0, type(p119) ~= "number" and 1 or p119);
    local u122 = {};
    u121.coverToken = u122;
    local v123;

    if type(p120) == "number" then
        local v124 = p120 - workspace:GetServerTimeNow();
        v123 = math.max(0, v124);
    else
        v123 = type(p118) ~= "number" and 40 or p118;
    end;

    task.delay(v123, function() -- Line: 839
        -- upvalues: u37 (ref), u121 (copy), u122 (copy), fade (ref), u1 (ref), closeSession (ref)
        if u37 == u121 and (u121.coverToken == u122 and not u121.playing) then
            fade(u121, 1, 1.5);
            u1.notice("The cutscene couldn\'t start. The fight is starting, stay where you are!", nil);
            task.wait(1.5);
            closeSession(u121);
        end;
    end);
end;

function u1.stop(p125) -- Line: 852
    -- upvalues: u117 (ref), u37 (ref), fade (copy), closeSession (copy), u1 (copy)
    if u117 then
        u117:Stop(p125 == "Error" and "Error" or "Stopped");

        return;
    end;

    if u37 and not u37.playing then
        local v126 = u37;
        fade(v126, 1, 1.5);
        task.delay(1.5, closeSession, v126);

        if p125 == "Error" then
            u1.notice("Something went wrong with the cutscene. The fight is starting, stay where you are!", nil);
        end;
    end;
end;

function u1.giveUp(p127, p128) -- Line: 867
    -- upvalues: u117 (ref), u37 (ref), fade (copy), closeSession (copy), u1 (copy), u66 (copy)
    if u117 then
        u117:Stop(p127 == "Error" and "Error" or "Late");

        return;
    end;

    if u37 and not u37.playing then
        local v129 = u37;
        fade(v129, 1, 0.4);
        task.delay(0.4, closeSession, v129);
    end;

    u1.notice(u66[p127] or "The cutscene couldn\'t load on your screen. The fight starts in {s}s, stay where you are!", p128);
end;

local function particleShare() -- Line: 882
    -- upvalues: UserInputService (copy)
    local success2, result2 = pcall(function() -- Line: 883
        return UserSettings():GetService("UserGameSettings").SavedQualityLevel.Value;
    end);
    local v130 = (not success2 or type(result2) ~= "number") and 0 or result2;

    return v130 == 0 and (UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled and 0.5 or 1) or (v130 <= 3 and 0.25 or (v130 <= 6 and 0.5 or 1));
end;

local function thinParticles(p131, u132) -- Line: 893
    if u132 >= 1 or not p131 then
        return;
    end;

    local function thin(p133) -- Line: 897
        -- upvalues: u132 (copy)
        if p133:IsA("ParticleEmitter") and not p133:GetAttribute("EclipseThinned") then
            p133:SetAttribute("EclipseThinned", true);
            p133.Rate = p133.Rate * u132;
        end;
    end;

    for _, descendant in p131:GetDescendants() do
        if descendant:IsA("ParticleEmitter") and not descendant:GetAttribute("EclipseThinned") then
            descendant:SetAttribute("EclipseThinned", true);
            descendant.Rate = descendant.Rate * u132;
        end;
    end;

    p131.DescendantAdded:Connect(thin);
end;

local function makeRoomInLighting(p134) -- Line: 910
    -- upvalues: Lighting (copy), u4 (copy)
    local v135 = {};

    for _, child in Lighting:GetChildren() do
        if not p134[child] then
            v135[child.ClassName] = true;
        end;
    end;

    local u136 = {};

    for _, v in u4 do
        if v135[v] then
            local v137 = v;

            for i in p134 do
                if i.Parent == Lighting and i.ClassName == v137 then
                    i.Parent = nil;
                    table.insert(u136, i);
                end;
            end;
        end;
    end;

    return function() -- Line: 928
        -- upvalues: u136 (copy), Lighting (ref)
        for _, v in u136 do
            pcall(function() -- Line: 930
                -- upvalues: v (copy), Lighting (ref)
                v.Parent = Lighting;
            end);
        end;
    end;
end;

local function captionTimes(p138, p139) -- Line: 940
    local v140 = {};

    for i, v in p138 do
        local v141 = utf8.len(v.Text) or #v.Text;
        local v142 = p138[i + 1];
        local v143;

        if v142 then
            v143 = v142.At - 0.15;
        else
            v143 = v.At + v141 / 40 + 2 + v141 * 0.045;
        end;

        local v144 = type(v.For) ~= "number" and (1 / 0) or v.At + v.For;
        local math_min_ret = math.min(v143, v144, p139 - 0.15);
        local v145 = math_min_ret - v.At;

        if v145 > 0.35 then
            local v146 = {
                at = v.At,
                text = v.Text,
                total = v141,
                cps = math.max(40, v141 / (v145 * 0.4)),
                fadeAt = math_min_ret - 0.35,
                goneAt = math_min_ret
            };
            table.insert(v140, v146);
        end;
    end;

    return v140;
end;

local function captionScreen(p147, p148, p149) -- Line: 969
    -- upvalues: captionTimes (copy), CutsceneScreen (copy), Font_new_ret (copy), LocalPlayer (copy)
    local u150 = captionTimes(p148, p149);
    local CutsceneCaptions = CutsceneScreen.new("CutsceneCaptions", 60);
    CutsceneCaptions:SetAttribute("CreatorCaptureExempt", true);
    CutsceneCaptions:SetAttribute("SelfManagedText", true);
    CutsceneCaptions:SetAttribute("Cutscene", p147);
    local Frame = Instance.new("Frame");
    Frame.Name = "Say";
    Frame.AnchorPoint = Vector2.new(0.5, 1);
    Frame.Position = UDim2.new(0.5, 0, 0.9, -14);
    Frame.Size = UDim2.fromScale(0.78, 0);
    Frame.AutomaticSize = Enum.AutomaticSize.Y;
    Frame.BackgroundTransparency = 1;
    Frame.Visible = false;
    Frame.ZIndex = 3;
    Frame.Parent = CutsceneCaptions;
    local UISizeConstraint = Instance.new("UISizeConstraint");
    UISizeConstraint.MaxSize = Vector2.new(980, (1 / 0));
    UISizeConstraint.Parent = Frame;
    local UIListLayout = Instance.new("UIListLayout");
    UIListLayout.FillDirection = Enum.FillDirection.Vertical;
    UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center;
    UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom;
    UIListLayout.Padding = UDim.new(0, 6);
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder;
    UIListLayout.Parent = Frame;
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Name = "Body";
    TextLabel.Size = UDim2.new(1, 0, 0, 0);
    TextLabel.AutomaticSize = Enum.AutomaticSize.Y;
    TextLabel.BackgroundTransparency = 1;
    TextLabel.FontFace = Font_new_ret;
    TextLabel.TextWrapped = true;
    TextLabel.TextSize = 24;
    TextLabel.TextColor3 = Color3.new(1, 1, 1);
    TextLabel.TextStrokeColor3 = Color3.new(0, 0, 0);
    TextLabel.TextStrokeTransparency = 0.45;
    TextLabel.Text = "";
    TextLabel.LayoutOrder = 2;
    TextLabel.ZIndex = 3;
    TextLabel.Parent = Frame;
    local u151 = CutsceneCaptions:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 1011, Name: fit
        -- upvalues: TextLabel (copy), CutsceneCaptions (copy)
        local math_floor_ret = math.floor(CutsceneCaptions.AbsoluteSize.Y * 0.036);
        TextLabel.TextSize = math.clamp(math_floor_ret, 16, 30);
    end);
    local math_floor_ret = math.floor(CutsceneCaptions.AbsoluteSize.Y * 0.036);
    TextLabel.TextSize = math.clamp(math_floor_ret, 16, 30);
    CutsceneCaptions.Parent = LocalPlayer:FindFirstChildOfClass("PlayerGui") or LocalPlayer:WaitForChild("PlayerGui");
    local v152 = {
        gui = CutsceneCaptions,
        times = u150
    };
    local u153 = nil;

    function v152.show(p154, p155) -- Line: 1019
        -- upvalues: u150 (copy), Frame (copy), u153 (ref), TextLabel (copy)
        local v156 = nil;

        for _, v in u150 do
            if v.at <= p154 and p154 < v.goneAt then
                v156 = v;
            end;
        end;

        local v157 = not v156 and 0 or math.clamp((v156.goneAt - p154) / 0.35, 0, 1);

        if type(p155) == "number" then
            local math_clamp_ret = math.clamp((p155 - 0.15) / 0.35, 0, 1);
            v157 = math.min(v157, math_clamp_ret);
        end;

        if not v156 or v157 <= 0 then
            Frame.Visible = false;

            return;
        end;

        if u153 ~= v156 then
            u153 = v156;
            TextLabel.Text = v156.text;
        end;

        local math_floor_ret2 = math.floor((p154 - v156.at) * v156.cps);
        TextLabel.MaxVisibleGraphemes = v156.total <= math_floor_ret2 and -1 or math_floor_ret2;
        TextLabel.TextTransparency = 1 - v157;
        TextLabel.TextStrokeTransparency = 1 - v157 * 0.55;
        Frame.Visible = true;
    end;

    function v152.destroy() -- Line: 1045
        -- upvalues: u151 (copy), CutsceneCaptions (copy)
        u151:Disconnect();
        CutsceneCaptions:Destroy();
    end;

    return v152;
end;

function u1.play(u158, p159, u160) -- Line: 1058
    -- upvalues: u117 (ref), u1 (copy), openSession (copy), u5 (copy), SoundService (copy), RunService (copy), TweenService (copy), u6 (copy), captionScreen (copy), LocalHide (copy), LocalPlayer (copy), fade (copy), closeSession (copy), handBack (copy), u66 (copy), Lighting (copy), u37 (ref), makeRoomInLighting (copy), thinParticles (copy), particleShare (copy), castAll (copy), standIns (copy)
    local u161 = p159 or {};

    if u117 then
        u117:Stop("Replaced");
    end;

    local u162, v163 = u1.load(u158);

    if not u162 then
        return nil, v163;
    end;

    local u164 = {
        Name = u158
    };
    u117 = u164;
    local u165 = openSession();
    u165.playing = true;
    local u166 = false;
    local u167 = nil;
    local u168 = "EclipseCutscene_" .. u158;
    local u169;

    if type(u161.StartAt) == "number" then
        u169 = u161.StartAt;
    else
        u169 = workspace:GetServerTimeNow();
    end;

    local u170 = type(u161.Seconds) ~= "number" and 60 or u161.Seconds;
    local u171 = u161.FromStart == true;
    local u172;

    if type(u161.FightAt) == "number" then
        u172 = u161.FightAt;
    else
        u172 = u169 + u170;
    end;

    local u173;

    if type(u161.HandBack) == "number" then
        u173 = u161.HandBack;
    else
        u173 = u1.HAND_BACK;
    end;

    local function u174() -- Line: 1079
    end;

    local u175;

    if u5[u158] then
        u175 = Instance.new("Sound");
        u175.Name = "EclipseCutsceneTrack";
        u175.SoundId = u5[u158].Id;
        u175.Volume = u5[u158].Volume;
        u175.Parent = SoundService;
    else
        u175 = nil;
    end;

    local u176 = nil;

    local function playTrack(u177) -- Line: 1095
        -- upvalues: u175 (ref), u5 (ref), u158 (copy), u166 (ref), u176 (ref), RunService (ref), u167 (ref)
        local u178 = u175;

        if not u178 then
            return;
        end;

        local u179 = u5[u158].Lead or 0;
        local os_clock_ret = os.clock();

        local function go() -- Line: 1102
            -- upvalues: u166 (ref), u178 (copy), u177 (copy), u179 (copy), os_clock_ret (copy)
            if not u166 and u178.Parent then
                u178.TimePosition = u177 + u179 + (os.clock() - os_clock_ret);
                u178:Play();
            end;
        end;

        if u178.IsLoaded then
            if not u166 and u178.Parent then
                u178.TimePosition = u177 + u179 + (os.clock() - os_clock_ret);
                u178:Play();
            end;
        else
            u178.Loaded:Once(go);
        end;

        local os_clock_ret2 = os.clock();
        u176 = RunService.Heartbeat:Connect(function() -- Line: 1114
            -- upvalues: u175 (ref), u178 (copy), u167 (ref), u179 (copy), os_clock_ret2 (ref)
            if u175 ~= u178 or not (u178.Playing and (u167 and u167.Status == "Playing")) then
                return;
            end;

            local v180 = u167.Time + u179;

            if v180 < u178.TimeLength and (math.abs(u178.TimePosition - v180) > 0.12 and os.clock() - os_clock_ret2 >= 0.5) then
                os_clock_ret2 = os.clock();
                u178.TimePosition = v180;
            end;
        end);
    end;

    local function stopTrack() -- Line: 1129
        -- upvalues: u175 (ref), u176 (ref), TweenService (ref)
        local v181 = u175;
        u175 = nil;

        if u176 then
            u176:Disconnect();
            u176 = nil;
        end;

        if v181 then
            TweenService:Create(v181, TweenInfo.new(1.5), {
                Volume = 0
            }):Play();
            task.delay(1.5, v181.Destroy, v181);
        end;
    end;

    local u182 = nil;
    local u183 = nil;

    local function stopCaptions() -- Line: 1145
        -- upvalues: u183 (ref), u182 (ref)
        if u183 then
            u183:Disconnect();
            u183 = nil;
        end;

        local v184 = u182;
        u182 = nil;

        if v184 then
            v184.destroy();
        end;
    end;

    if u6[u158] then
        local success2, result2 = pcall(captionScreen, u158, u6[u158], u170);

        if success2 then
            u182 = result2;
            u183 = RunService.Heartbeat:Connect(function() -- Line: 1160
                -- upvalues: u166 (ref), u182 (ref), u167 (ref), u169 (ref), u170 (copy), u183 (ref)
                if u166 or not (u182 and (u167 and u167.Status == "Playing")) then
                    return;
                end;

                local Time = u167.Time;

                if type(Time) ~= "number" then
                    return;
                end;

                local v185 = u169 + u170 - workspace:GetServerTimeNow();
                local success3, result3 = pcall(u182.show, Time, v185);

                if not success3 then
                    warn("[EclipseCutscene] the story lines stopped: " .. tostring(result3));

                    if u183 then
                        u183:Disconnect();
                        u183 = nil;
                    end;

                    local v186 = u182;
                    u182 = nil;

                    if v186 then
                        v186.destroy();
                    end;
                end;
            end);
        else
            warn("[EclipseCutscene] couldn\'t make the story lines: " .. tostring(result2));
        end;
    end;

    local u187 = LocalHide.new();
    local u188 = type(u161.Hide) ~= "table" and {} or u161.Hide;

    local function sweep() -- Line: 1182
        -- upvalues: u187 (copy), LocalPlayer (ref), u188 (copy)
        u187:sweep();

        if LocalPlayer.Character then
            u187:model(LocalPlayer.Character);
        end;

        for _, v in u188 do
            local v189;

            if type(v) == "string" then
                v189 = workspace:FindFirstChild(v);
            else
                v189 = false;
            end;

            if v189 then
                u187:model(v189);
            end;
        end;
    end;

    local u190 = nil;

    local function startHiding() -- Line: 1195
        -- upvalues: sweep (copy), u190 (ref), RunService (ref)
        sweep();
        local u191 = 0;
        u190 = RunService.Heartbeat:Connect(function(p192) -- Line: 1198
            -- upvalues: u191 (ref), sweep (ref)
            u191 = u191 + p192;

            if u191 >= 0.3 then
                u191 = 0;
                sweep();
            end;
        end);
    end;

    local function unhide() -- Line: 1207
        -- upvalues: u190 (ref), u187 (copy)
        if u190 then
            u190:Disconnect();
        end;

        u187:restore();
    end;

    local u193 = LocalPlayer.CharacterAdded:Connect(function() -- Line: 1214
        -- upvalues: u166 (ref)
        task.defer(function() -- Line: 1215
            -- upvalues: u166 (ref)
            if not u166 then
                workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable;
            end;
        end);
    end);
    local u194 = nil;
    local u195 = nil;
    local u196 = false;

    local function record() -- Line: 1226
        -- upvalues: u196 (ref), RunService (ref), u194 (ref), u195 (ref)
        u196 = true;
        RunService:BindToRenderStep("EclipseCutsceneRecord", Enum.RenderPriority.Last.Value + 20, function() -- Line: 1228
            -- upvalues: u194 (ref), u195 (ref)
            local workspace_CurrentCamera = workspace.CurrentCamera;

            if workspace_CurrentCamera and workspace_CurrentCamera.CameraType == Enum.CameraType.Scriptable then
                u194 = workspace_CurrentCamera.CFrame;
                u195 = workspace_CurrentCamera.FieldOfView;
            end;
        end);
    end;

    local function stopRecording() -- Line: 1235
        -- upvalues: u196 (ref), RunService (ref)
        if u196 then
            u196 = false;
            pcall(RunService.UnbindFromRenderStep, RunService, "EclipseCutsceneRecord");
        end;
    end;

    local function u204(u197) -- Line: 1242
        -- upvalues: u166 (ref), u117 (ref), u164 (copy), stopRecording (copy), u193 (copy), stopTrack (copy), stopCaptions (copy), u194 (ref), u195 (ref), u167 (ref), u174 (ref), unhide (copy), fade (ref), u165 (copy), closeSession (ref), u160 (copy), u173 (copy), handBack (ref), LocalPlayer (ref), u172 (copy), u1 (ref), u66 (ref)
        if u166 then
            return;
        end;

        u166 = true;

        if u117 == u164 then
            u117 = nil;
        end;

        local function try(p198, p199) -- Line: 1251
            local success2, result2 = pcall(p199);

            if not success2 then
                warn("[EclipseCutscene] " .. p198 .. ": " .. tostring(result2));
            end;
        end;

        local success2, result2 = pcall(stopRecording);

        if not success2 then
            warn("[EclipseCutscene] " .. "stopping the recording" .. ": " .. tostring(result2));
        end;

        local success3, result3 = pcall(function() -- Line: 1258
            -- upvalues: u193 (ref)
            u193:Disconnect();
        end);

        if not success3 then
            warn("[EclipseCutscene] " .. "the respawn guard" .. ": " .. tostring(result3));
        end;

        local success4, result4 = pcall(stopTrack);

        if not success4 then
            warn("[EclipseCutscene] " .. "the sound track" .. ": " .. tostring(result4));
        end;

        local success5, result5 = pcall(stopCaptions);

        if not success5 then
            warn("[EclipseCutscene] " .. "the story lines" .. ": " .. tostring(result5));
        end;

        local v200 = u194 or workspace.CurrentCamera.CFrame;

        if u167 then
            local success6, result6 = pcall(function() -- Line: 1266
                -- upvalues: u167 (ref)
                u167:Destroy();
            end);

            if not success6 then
                warn("[EclipseCutscene] " .. "taking it down" .. ": " .. tostring(result6));
            end;
        end;

        local success6, result6 = pcall(u174);

        if not success6 then
            warn("[EclipseCutscene] " .. "the lighting" .. ": " .. tostring(result6));
        end;

        local success7, result7 = pcall(unhide);

        if not success7 then
            warn("[EclipseCutscene] " .. "showing everyone again" .. ": " .. tostring(result7));
        end;

        fade(u165, 1, 0);
        local u201 = false;

        local function close() -- Line: 1274
            -- upvalues: u201 (ref), closeSession (ref), u165 (ref), u160 (ref), u197 (copy)
            if u201 then
                return;
            end;

            u201 = true;
            closeSession(u165);

            if u160 then
                task.spawn(u160, u197);
            end;
        end;

        local v202 = u197 == "Replaced" and 0 or u173;
        local success8, result8 = pcall(handBack, v200, u195, v202, close);

        if not success8 then
            warn("[EclipseCutscene] the hand-back: " .. tostring(result8));
            local success9, result9 = pcall(function() -- Line: 1288
                -- upvalues: LocalPlayer (ref)
                local workspace_CurrentCamera = workspace.CurrentCamera;
                local v203 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid");

                if v203 then
                    workspace_CurrentCamera.CameraSubject = v203;
                end;

                workspace_CurrentCamera.CameraType = Enum.CameraType.Custom;
            end);

            if not success9 then
                warn("[EclipseCutscene] " .. "the camera" .. ": " .. tostring(result9));
            end;

            if not u201 then
                u201 = true;
                closeSession(u165);

                if u160 then
                    task.spawn(u160, u197);
                end;
            end;
        end;

        task.delay(v202 + 2, close);

        if (u197 == "Late" or u197 == "Error") and workspace:GetServerTimeNow() < u172 then
            u1.notice(u66[u197], u172);
        end;
    end;

    function u164.Stop(p205, p206) -- Line: 1305
        -- upvalues: u204 (copy)
        u204(p206 or "Stopped");
    end;

    local u207 = nil;

    local function scheduleEnd() -- Line: 1314
        -- upvalues: u207 (ref), u169 (ref), u170 (copy), u166 (ref), u204 (copy)
        if u207 then
            task.cancel(u207);
        end;

        local task_delay = task.delay;
        local v208 = u169 + u170 + 0 - workspace:GetServerTimeNow();
        u207 = task_delay(math.max(0, v208), function() -- Line: 1318
            -- upvalues: u166 (ref), u204 (ref)
            if not u166 then
                u204("Finished");
            end;
        end);
    end;

    scheduleEnd();
    local u209 = false;
    local v210;

    if u171 and type(u161.GiveUpAt) == "number" then
        v210 = u161.GiveUpAt;
    else
        v210 = u169 + 5;
    end;

    local task_delay = task.delay;
    local v211 = v210 - workspace:GetServerTimeNow();
    task_delay(math.max(0, v211), function() -- Line: 1331
        -- upvalues: u166 (ref), u209 (ref), u204 (copy)
        if not (u166 or u209) then
            u204("Late");
        end;
    end);
    task.spawn(function() -- Line: 1336
        -- upvalues: u167 (ref), u162 (copy), u166 (ref), u204 (copy), u158 (copy), u169 (ref), Lighting (ref), u196 (ref), RunService (ref), u194 (ref), u195 (ref), u209 (ref), u168 (copy), LocalPlayer (ref), u37 (ref), u171 (copy), scheduleEnd (copy), u170 (copy), playTrack (copy), u174 (ref), makeRoomInLighting (ref), sweep (copy), u190 (ref), thinParticles (ref), particleShare (ref), u161 (ref), castAll (ref), standIns (ref), fade (ref), u165 (copy)
        local success2, result2 = pcall(function() -- Line: 1337
            -- upvalues: u167 (ref), u162 (ref), u166 (ref), u204 (ref), u158 (ref), u169 (ref), Lighting (ref), u196 (ref), RunService (ref), u194 (ref), u195 (ref), u209 (ref), u168 (ref), LocalPlayer (ref), u37 (ref), u171 (ref), scheduleEnd (ref), u170 (ref), playTrack (ref), u174 (ref), makeRoomInLighting (ref), sweep (ref), u190 (ref), thinParticles (ref), particleShare (ref), u161 (ref), castAll (ref), standIns (ref), fade (ref), u165 (ref)
            u167 = u162.new();

            if u166 then
                return;
            end;

            u167.Stopped:Connect(function(p212) -- Line: 1342
                -- upvalues: u204 (ref)
                u204(p212 == "Completed" and "Finished" or "Error");
            end);
            u167.Failed:Connect(function(p213) -- Line: 1346
                -- upvalues: u158 (ref), u204 (ref)
                warn("[EclipseCutscene] " .. u158 .. " failed: " .. tostring(p213));
                u204("Error");
            end);
            local v214 = u169 - workspace:GetServerTimeNow();

            if v214 > 0 then
                task.wait(v214);
            end;

            if u166 then
                return;
            end;

            local v215 = {};

            for _, child in Lighting:GetChildren() do
                v215[child] = true;
            end;

            u196 = true;
            RunService:BindToRenderStep("EclipseCutsceneRecord", Enum.RenderPriority.Last.Value + 20, function() -- Line: 1228
                -- upvalues: u194 (ref), u195 (ref)
                local workspace_CurrentCamera = workspace.CurrentCamera;

                if workspace_CurrentCamera and workspace_CurrentCamera.CameraType == Enum.CameraType.Scriptable then
                    u194 = workspace_CurrentCamera.CFrame;
                    u195 = workspace_CurrentCamera.FieldOfView;
                end;
            end);
            u167:Play();
            u209 = true;

            if u166 then
                pcall(function() -- Line: 1366
                    -- upvalues: u167 (ref)
                    u167:Destroy();
                end);
                local v216 = workspace:FindFirstChild(u168);

                if v216 then
                    v216:Destroy();
                end;

                local v217 = LocalPlayer:FindFirstChildOfClass("PlayerGui");

                if v217 then
                    v217 = v217:FindFirstChild(u168);
                end;

                if v217 then
                    v217:Destroy();
                end;

                local workspace_CurrentCamera = workspace.CurrentCamera;

                if u37 == nil and workspace_CurrentCamera.CameraType == Enum.CameraType.Scriptable then
                    local v218 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid");

                    if v218 then
                        workspace_CurrentCamera.CameraSubject = v218;
                    end;

                    workspace_CurrentCamera.CameraType = Enum.CameraType.Custom;
                end;

                return;
            end;

            local v219 = workspace:GetServerTimeNow() - u169;
            local v220 = 0;

            if u171 then
                u169 = workspace:GetServerTimeNow();
                scheduleEnd();
            elseif v219 > 0.25 and type(u167.Seek) == "function" then
                local Seek = u167.Seek;
                local math_min_ret = math.min(v219, u170);
                local success2, result2 = pcall(Seek, u167, math_min_ret);

                if success2 then
                    v220 = math.min(v219, u170);
                else
                    warn("[EclipseCutscene] couldn\'t catch up: " .. tostring(result2));
                end;
            end;

            pcall(playTrack, v220);
            u174 = makeRoomInLighting(v215);
            sweep();
            local u221 = 0;
            u190 = RunService.Heartbeat:Connect(function(p222) -- Line: 1198
                -- upvalues: u221 (ref), sweep (ref)
                u221 = u221 + p222;

                if u221 >= 0.3 then
                    u221 = 0;
                    sweep();
                end;
            end);
            local v223 = workspace:FindFirstChild(u168);
            local v224 = particleShare();
            pcall(thinParticles, v223, v224);
            local v225 = type(u161.Keep) ~= "table" and {} or u161.Keep;
            local v226 = type(u161.Order) ~= "table" and {} or u161.Order;
            local v227;

            if typeof(u161.Cast) == "Instance" then
                v227 = u161.Cast;
            else
                v227 = nil;
            end;

            castAll(standIns(v223, v225, v226), v227);
            fade(u165, 1, 1.5);
        end);

        if not success2 then
            warn("[EclipseCutscene] " .. u158 .. ": " .. tostring(result2));
            u204("Error");
        end;
    end);

    return u164;
end;

return table.freeze(u1);