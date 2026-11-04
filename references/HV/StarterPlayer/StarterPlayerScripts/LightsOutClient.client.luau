 

 

local Players = game:GetService("Players");
local Lighting = game:GetService("Lighting");
local RunService = game:GetService("RunService");
local StarterGui = game:GetService("StarterGui");
local SoundService = game:GetService("SoundService");
local TweenService = game:GetService("TweenService");
local UserInputService = game:GetService("UserInputService");
local LocalPlayer = Players.LocalPlayer;
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");
local ChickenOrHero = game:GetService("ReplicatedStorage"):WaitForChild("ChickenOrHero");
local Session = ChickenOrHero:WaitForChild("Game"):WaitForChild("Session");
local ParticipantDirectory = require(ChickenOrHero:WaitForChild("Presentation"):WaitForChild("ParticipantDirectory"));
local u1 = {
    Brightness = -0.1,
    Contrast = 0.15,
    Saturation = -0.35,
    TintColor = Color3.fromRGB(170, 180, 230)
};
local u2 = {
    Brightness = 0,
    Contrast = 0,
    Saturation = 0,
    TintColor = Color3.new(1, 1, 1)
};
local u3 = {
    ClockTime = 0,
    ExposureCompensation = 1.6,
    Brightness = 3,
    Ambient = Color3.fromRGB(95, 100, 125),
    OutdoorAmbient = Color3.fromRGB(120, 125, 155),
    FogColor = Color3.fromRGB(3, 3, 8)
};
local Color3_fromRGB_ret = Color3.fromRGB(255, 40, 40);
local Color3_fromRGB_ret2 = Color3.fromRGB(70, 235, 110);
local u4 = {
    Enum.CoreGuiType.PlayerList,
    Enum.CoreGuiType.Backpack,
    Enum.CoreGuiType.Health,
    Enum.CoreGuiType.EmotesMenu
};
local u5 = {
    TouchGui = true,
    Freecam = true,
    Notifications = true,
    ChoiceSpotlight = true,
    ValleyEmotes = true
};

for _, v in { "CatchConfirmation", "KnockdownStreak", "OutcomeScreen", "AdrenalineFeel", "PerfectDodgeFeedback", "HauntHud", "RescueStatus", "VowSeal" } do
    u5[v] = true;
end;

local u6 = {
    HUD = true,
    AbilityControls = true,
    GearControls = true,
    KnifeAbilityHUD = true,
    GhostAbilityHUD = true,
    TruckAbilityHUD = true
};
local u7 = false;
local u8 = {};
local u9 = {};
local u10 = {};
local u11 = {};
local u12 = {};
local u13 = nil;
local u14 = nil;

local function touchOnly() -- Line: 97
    -- upvalues: UserInputService (copy)
    return UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled;
end;

local function involved() -- Line: 102
    -- upvalues: LocalPlayer (copy)
    return LocalPlayer:GetAttribute("InMatch") == true;
end;

local function kept(p15) -- Line: 106
    -- upvalues: PlayerGui (copy), u5 (copy), u6 (copy), UserInputService (copy)
    if p15:GetAttribute("LightsOutKeep") == true then
        return true;
    end;

    local v16 = p15.Name:match("^(.-)_") or p15.Name;
    local v17;

    if p15.Parent == PlayerGui then
        if u5[p15.Name] == true or u5[v16] == true then
            v17 = true;
        elseif u6[p15.Name] == true then
            v17 = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled;
        else
            v17 = false;
        end;
    else
        v17 = false;
    end;

    return v17;
end;

local function onRig(p18) -- Line: 117
    local v19 = p18:FindFirstAncestorWhichIsA("Model");

    while v19 do
        if v19:FindFirstChildOfClass("Humanoid") or v19:FindFirstChildOfClass("AnimationController") then
            return true;
        end;

        v19 = v19:FindFirstAncestorWhichIsA("Model");
    end;

    return false;
end;

local function hold(u20) -- Line: 131
    -- upvalues: u8 (copy), kept (copy), u9 (copy), u7 (ref)
    if u8[u20] or (kept(u20) or not (u20.Enabled or u20:IsA("Highlight"))) then
        return;
    end;

    if u20.Enabled then
        u20.Enabled = false;
        u9[u20] = true;
    end;

    u8[u20] = u20:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 139
        -- upvalues: u7 (ref), u20 (copy), u9 (ref)
        if u7 and u20.Enabled then
            u20.Enabled = false;
            u9[u20] = true;
        end;
    end);
end;

local function hide(u21) -- Line: 147
    -- upvalues: u10 (copy), u7 (ref)
    if u10[u21] or not u21.Visible then
        return;
    end;

    u21.Visible = false;
    u10[u21] = u21:GetPropertyChangedSignal("Visible"):Connect(function() -- Line: 152
        -- upvalues: u7 (ref), u21 (copy)
        if u7 and u21.Visible then
            u21.Visible = false;
        end;
    end);
end;

local function hideFeed(p22) -- Line: 158
    -- upvalues: PlayerGui (copy), u10 (copy), u7 (ref)
    local u23;

    if p22.Name == "Notifications" and p22.Parent == PlayerGui then
        u23 = p22:FindFirstChild("MainFrame");
    else
        u23 = false;
    end;

    if u23 then
        u23 = u23:FindFirstChild("NotificationsF");
    end;

    if u23 and (u23:IsA("GuiObject") and not u10[u23]) then
        if not u23.Visible then
            return;
        end;

        u23.Visible = false;
        u10[u23] = u23:GetPropertyChangedSignal("Visible"):Connect(function() -- Line: 152
            -- upvalues: u7 (ref), u23 (copy)
            if u7 and u23.Visible then
                u23.Visible = false;
            end;
        end);
    end;
end;

local function consider(p24) -- Line: 165
    -- upvalues: onRig (copy), hold (copy)
    if p24:IsA("Highlight") or p24:IsA("BillboardGui") and (p24.Name ~= "RoleMarker" and onRig(p24)) then
        hold(p24);
    end;
end;

local function switchSound() -- Line: 173
    -- upvalues: SoundService (copy)
    local Sound = Instance.new("Sound");
    Sound.SoundId = "rbxassetid://9120484192";
    Sound.Volume = 0.6;
    Sound.Parent = SoundService;
    Sound.Ended:Once(function() -- Line: 178
        -- upvalues: Sound (copy)
        Sound:Destroy();
    end);
    Sound:Play();
    task.delay(4, function() -- Line: 182
        -- upvalues: Sound (copy)
        if Sound.Parent then
            Sound:Destroy();
        end;
    end);
end;

local function fadeTo(p25, p26, u27) -- Line: 189
    -- upvalues: u14 (ref), TweenService (copy), u13 (ref)
    if u14 then
        u14:Cancel();
    end;

    u14 = TweenService:Create(u13, TweenInfo.new(p26, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), p25);

    if u27 then
        u14.Completed:Once(function(p28) -- Line: 195
            -- upvalues: u27 (copy)
            if p28 == Enum.PlaybackState.Completed then
                u27();
            end;
        end);
    end;

    u14:Play();
end;

local u29 = nil;
local u30 = {};

local function park(p31) -- Line: 209
    -- upvalues: u7 (ref), Lighting (copy), u30 (copy)
    if u7 and (p31:IsA("Atmosphere") and p31.Parent == Lighting) then
        table.insert(u30, p31);
        p31.Parent = nil;
    end;
end;

local function sightFor() -- Line: 215
    -- upvalues: LocalPlayer (copy)
    return LocalPlayer:GetAttribute("GameRole") == "Runner" and LocalPlayer:GetAttribute("RunState") == "Active" and 50 or 120;
end;

local function applySight() -- Line: 220
    -- upvalues: LocalPlayer (copy), Lighting (copy)
    local v32 = LocalPlayer:GetAttribute("GameRole") == "Runner" and LocalPlayer:GetAttribute("RunState") == "Active" and 50 or 120;
    Lighting.FogStart = v32 * 0.5;
    Lighting.FogEnd = v32;
end;

local function nightOn() -- Line: 225
    -- upvalues: u29 (ref), Lighting (copy), u3 (copy), LocalPlayer (copy), u7 (ref), u30 (copy), u12 (copy), park (copy)
    u29 = {
        FogStart = Lighting.FogStart,
        FogEnd = Lighting.FogEnd
    };

    for i, v in u3 do
        u29[i] = Lighting[i];
        Lighting[i] = v;
    end;

    local v33 = LocalPlayer:GetAttribute("GameRole") == "Runner" and LocalPlayer:GetAttribute("RunState") == "Active" and 50 or 120;
    Lighting.FogStart = v33 * 0.5;
    Lighting.FogEnd = v33;

    for _, child in Lighting:GetChildren() do
        if u7 and (child:IsA("Atmosphere") and child.Parent == Lighting) then
            table.insert(u30, child);
            child.Parent = nil;
        end;
    end;

    table.insert(u12, Lighting.ChildAdded:Connect(park));

    for _, v in { "GameRole", "RunState" } do
        local AttributeChangedSignal = LocalPlayer:GetAttributeChangedSignal(v);
        table.insert(u12, AttributeChangedSignal:Connect(function() -- Line: 238
            -- upvalues: u7 (ref), LocalPlayer (ref), Lighting (ref)
            if u7 then
                local v34 = LocalPlayer:GetAttribute("GameRole") == "Runner" and LocalPlayer:GetAttribute("RunState") == "Active" and 50 or 120;
                Lighting.FogStart = v34 * 0.5;
                Lighting.FogEnd = v34;
            end;
        end));
    end;
end;

local function nightOff() -- Line: 245
    -- upvalues: u29 (ref), Lighting (copy), u30 (copy)
    if u29 then
        for i, v in u29 do
            Lighting[i] = v;
        end;

        u29 = nil;
    end;

    for _, v in u30 do
        if v.Parent == nil and not Lighting:FindFirstChildOfClass("Atmosphere") then
            v.Parent = Lighting;
        end;
    end;

    table.clear(u30);
end;

local u35 = {};
local u36 = nil;
local u37 = nil;

local function edges() -- Line: 266
    -- upvalues: u36 (ref), u37 (ref), Color3_fromRGB_ret (copy), PlayerGui (copy)
    if u36 then
        return u37;
    end;

    u36 = Instance.new("ScreenGui");
    u36.Name = "LightsOutSpotted";
    u36:SetAttribute("LightsOutKeep", true);
    u36.IgnoreGuiInset = true;
    u36.ResetOnSpawn = false;
    u36.DisplayOrder = 60;
    u37 = {};

    for _, v in {
        { UDim2.new(1, 0, 0.22, 0), UDim2.fromScale(0, 0), 90 },
        { UDim2.new(1, 0, 0.22, 0), UDim2.fromScale(0, 0.78), -90 },
        { UDim2.new(0.16, 0, 1, 0), UDim2.fromScale(0, 0), 0 },
        { UDim2.new(0.16, 0, 1, 0), UDim2.fromScale(0.84, 0), 180 }
    } do
        local Frame = Instance.new("Frame");
        local v38 = v[2];
        Frame.Size = v[1];
        Frame.Position = v38;
        Frame.BackgroundColor3 = Color3_fromRGB_ret;
        Frame.BorderSizePixel = 0;
        Frame.BackgroundTransparency = 1;
        local UIGradient = Instance.new("UIGradient");
        UIGradient.Rotation = v[3];
        UIGradient.Transparency = NumberSequence.new(0.1, 1);
        UIGradient.Parent = Frame;
        Frame.Parent = u36;
        table.insert(u37, Frame);
    end;

    u36.Parent = PlayerGui;

    return u37;
end;

local u39 = { { 0, 0.06 }, { 1, 0.08 }, { 0.15, 0.05 }, { 0.7, 0.07 }, { 0, 0 } };
local u40 = nil;

local function hideTitle() -- Line: 300
    -- upvalues: u40 (ref)
    if u40 then
        u40:Destroy();
        u40 = nil;
    end;
end;

local function showTitle() -- Line: 306
    -- upvalues: u40 (ref), PlayerGui (copy), u39 (copy), TweenService (copy)
    if u40 then
        u40:Destroy();
        u40 = nil;
    end;

    local ScreenGui = Instance.new("ScreenGui");
    ScreenGui.Name = "LightsOutTitle";
    ScreenGui:SetAttribute("LightsOutKeep", true);
    ScreenGui:SetAttribute("SelfManagedText", true);
    ScreenGui.IgnoreGuiInset = true;
    ScreenGui.ResetOnSpawn = false;
    ScreenGui.DisplayOrder = 61;
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Name = "Title";
    TextLabel.AnchorPoint = Vector2.new(0.5, 0.5);
    TextLabel.Position = UDim2.fromScale(0.5, 0.3);
    TextLabel.Size = UDim2.fromScale(0.8, 0.11);
    TextLabel.BackgroundTransparency = 1;
    TextLabel.Font = Enum.Font.GothamBlack;
    TextLabel.Text = "LIGHTS OUT MODE";
    TextLabel.TextScaled = true;
    TextLabel.TextColor3 = Color3.fromRGB(235, 240, 255);
    TextLabel.TextStrokeColor3 = Color3.new(0, 0, 0);
    TextLabel.TextStrokeTransparency = 1;
    TextLabel.TextTransparency = 1;
    local UITextSizeConstraint = Instance.new("UITextSizeConstraint");
    UITextSizeConstraint.MinTextSize = 24;
    UITextSizeConstraint.MaxTextSize = 72;
    UITextSizeConstraint.Parent = TextLabel;
    TextLabel.Parent = ScreenGui;
    ScreenGui.Parent = PlayerGui;
    u40 = ScreenGui;
    task.spawn(function() -- Line: 336
        -- upvalues: u39 (ref), u40 (ref), ScreenGui (copy), TextLabel (copy), TweenService (ref)
        for _, v in u39 do
            if u40 ~= ScreenGui then
                return;
            end;

            TextLabel.TextTransparency = v[1];
            TextLabel.TextStrokeTransparency = 0.35 + 0.65 * v[1];

            if v[2] > 0 then
                task.wait(v[2]);
            end;
        end;

        task.wait(2.2);

        if u40 ~= ScreenGui then
            return;
        end;

        TweenService:Create(TextLabel, TweenInfo.new(0.8), {
            TextTransparency = 1,
            TextStrokeTransparency = 1
        }):Play();
        task.wait(0.8500000000000001);

        if u40 == ScreenGui and u40 then
            u40:Destroy();
            u40 = nil;
        end;
    end);
end;

local function warnSpotted() -- Line: 359
    -- upvalues: edges (copy), TweenService (copy), SoundService (copy)
    for _, v in edges() do
        v.BackgroundTransparency = 0.1;
        TweenService:Create(v, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            BackgroundTransparency = 1
        }):Play();
    end;

    local Sound = Instance.new("Sound");
    Sound.SoundId = "rbxassetid://1841354543";
    Sound.Volume = 0.55;
    Sound.PlaybackSpeed = 1.15;
    Sound.Parent = SoundService;
    Sound:Play();
    task.delay(4, function() -- Line: 370
        -- upvalues: Sound (copy)
        Sound:Destroy();
    end);
end;

local function markChaser(p41, p42) -- Line: 376
    if p41.dot and p41.dot.Parent == p42 then
        return;
    end;

    if p41.dot then
        p41.dot:SetAttribute("LightsOutSpotted", nil);
    end;

    local RoleMarker = p42:FindFirstChild("RoleMarker");

    if RoleMarker then
        RoleMarker:SetAttribute("LightsOutSpotted", true);
    end;

    p41.dot = RoleMarker;
end;

local function unmarkChaser(p43) -- Line: 389
    if p43.dot then
        p43.dot:SetAttribute("LightsOutSpotted", nil);
        p43.dot = nil;
    end;
end;

local function unmarkAll() -- Line: 395
    -- upvalues: u35 (copy)
    for _, v in u35 do
        if v.dot then
            v.dot:SetAttribute("LightsOutSpotted", nil);
            v.dot = nil;
        end;
    end;
end;

local u44 = 0;

local function watchChasers(p45) -- Line: 404
    -- upvalues: u44 (ref), LocalPlayer (copy), unmarkAll (copy), ParticipantDirectory (copy), u35 (copy), warnSpotted (copy), markChaser (copy)
    u44 = u44 + p45;

    if u44 < 0.1 then
        return;
    end;

    u44 = 0;
    local v46 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart");

    if not (v46 and (LocalPlayer:GetAttribute("GameRole") == "Runner" and LocalPlayer:GetAttribute("RunState") == "Active")) then
        unmarkAll();

        return;
    end;

    local os_clock_ret = os.clock();
    local v47 = {};

    for _, v in ParticipantDirectory.list() do
        local v48;

        if v == LocalPlayer then
            v48 = false;
        else
            v48 = v.Character;
        end;

        local v49;

        if v48 then
            v49 = v48:FindFirstChild("HumanoidRootPart") or v48.PrimaryPart;
        else
            v49 = v48;
        end;

        if v49 and (v:GetAttribute("GameRole") == "Catcher" and v:GetAttribute("RunState") == "Active") then
            v47[v] = true;
            local v50 = u35[v];

            if not v50 then
                v50 = {
                    seen = false,
                    lastSeen = (-1 / 0)
                };
                u35[v] = v50;
            end;

            if (v49.Position - v46.Position).Magnitude <= 25 then
                if not v50.seen and os_clock_ret - v50.lastSeen >= 3 then
                    warnSpotted();
                end;

                v50.seen = true;
                v50.lastSeen = os_clock_ret;
                markChaser(v50, v48);
            elseif v50.seen then
                v50.seen = false;
                v50.lastSeen = os_clock_ret;

                if v50.dot then
                    v50.dot:SetAttribute("LightsOutSpotted", nil);
                    v50.dot = nil;
                end;
            end;
        end;
    end;

    for i, v in u35 do
        if not v47[i] then
            if v.dot then
                v.dot:SetAttribute("LightsOutSpotted", nil);
                v.dot = nil;
            end;

            u35[i] = nil;
        end;
    end;
end;

local Color3_fromRGB_ret3 = Color3.fromRGB(75, 170, 255);
local u51 = {};

local function clearRunnerMarks() -- Line: 459
    -- upvalues: u51 (copy)
    for _, v in u51 do
        v:Destroy();
    end;

    table.clear(u51);
end;

local u52 = 0;

local function watchRunners(p53) -- Line: 466
    -- upvalues: u52 (ref), LocalPlayer (copy), u51 (copy), ParticipantDirectory (copy), Color3_fromRGB_ret3 (copy)
    u52 = u52 + p53;

    if u52 < 0.15 then
        return;
    end;

    u52 = 0;
    local v54 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart");

    if not v54 or LocalPlayer:GetAttribute("GameRole") ~= "Catcher" then
        for _, v in u51 do
            v:Destroy();
        end;

        table.clear(u51);

        return;
    end;

    local v55 = LocalPlayer:GetAttribute("GameRole") == "Runner" and LocalPlayer:GetAttribute("RunState") == "Active" and 50 or 120;
    local v56 = {};

    for _, v in ParticipantDirectory.list() do
        local v57;

        if v == LocalPlayer then
            v57 = false;
        else
            v57 = v.Character;
        end;

        local v58;

        if v57 then
            v58 = v57:FindFirstChild("HumanoidRootPart") or v57.PrimaryPart;
        else
            v58 = v57;
        end;

        if v58 and (v:GetAttribute("GameRole") == "Runner" and (v:GetAttribute("RunState") == "Active" and (v58.Position - v54.Position).Magnitude <= v55)) then
            v56[v] = true;
            local v59 = u51[v];

            if not v59 or v59.Parent ~= v57 then
                if v59 then
                    v59:Destroy();
                end;

                local Highlight = Instance.new("Highlight");
                Highlight.Name = "LightsOutRunner";
                Highlight:SetAttribute("LightsOutKeep", true);
                Highlight.FillTransparency = 1;
                Highlight.OutlineColor = Color3_fromRGB_ret3;
                Highlight.OutlineTransparency = 0;
                Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
                Highlight.Adornee = v57;
                Highlight.Parent = v57;
                u51[v] = Highlight;
            end;
        end;
    end;

    for i, v in u51 do
        if not v56[i] then
            v:Destroy();
            u51[i] = nil;
        end;
    end;
end;

local u60 = nil;
local u61 = nil;

local function farZone(p62) -- Line: 521
    -- upvalues: LocalPlayer (copy)
    local v63 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart");
    local v64;

    if v63 then
        v64 = v63.Position;
    else
        v64 = workspace.CurrentCamera.CFrame.Position;
    end;

    local v65 = nil;
    local v66 = nil;

    for _, child in workspace:GetChildren() do
        local Field = child:FindFirstChild("Field");

        if Field then
            for _, child2 in Field:GetChildren() do
                if child2.Name == "Line" and child2:IsA("BasePart") then
                    local Magnitude = (child2.Position - v64).Magnitude;

                    if not v65 or Magnitude < v65 then
                        v66 = Field;
                        v65 = Magnitude;
                    end;
                end;
            end;
        end;
    end;

    local v67;

    if v66 then
        v67 = v66:FindFirstChild(p62 == "A" and "SafezoneBSide" or "SafezoneASide");
    else
        v67 = v66;
    end;

    if v66 then
        v66 = v66:FindFirstChild(p62 == "A" and "SafezoneASide" or "SafezoneBSide");
    end;

    if v67 and v67:IsA("BasePart") then
        return v67, v66;
    end;

    return nil;
end;

local function findGoal() -- Line: 545
    -- upvalues: Session (copy), u60 (ref), farZone (copy), u61 (ref)
    local Attribute = Session:GetAttribute("StartSide");

    if Attribute ~= "A" and Attribute ~= "B" then
        u60 = nil;

        return;
    end;

    local v68, v69 = farZone(Attribute);

    if not v68 then
        u60 = nil;

        return;
    end;

    local v70 = not (v69 and v69:IsA("BasePart")) and Vector3.new(0, 0, -1) or v68.CFrame:VectorToObjectSpace(v69.Position - v68.Position);
    local v71 = math.abs(v70.Z) >= math.abs(v70.X);
    local v72;

    if v71 then
        local v73 = math.sign(v70.Z) * v68.Size.Z / 2;
        v72 = Vector3.new(0, 0, v73);
    else
        local v74 = math.sign(v70.X) * v68.Size.X / 2;
        v72 = Vector3.new(v74, 0, 0);
    end;

    local v75;

    if v71 then
        v75 = Vector3.new(v68.Size.X / 2, 0, 0);
    else
        v75 = Vector3.new(0, 0, v68.Size.Z / 2);
    end;

    u60 = { v68.CFrame:PointToWorldSpace(v72 - v75), v68.CFrame:PointToWorldSpace(v72 + v75) };
    u61 = Attribute;
end;

local CFrame_fromMatrix_ret = CFrame.fromMatrix(Vector3.new(0.75, 0, -1.2), Vector3.new(0, -1, 0), Vector3.new(1, 0, 0), Vector3.new(0, 0, 1));
local CFrame_fromMatrix_ret2 = CFrame.fromMatrix(Vector3.new(-0.75, 0, -1.2), Vector3.new(0, 1, 0), Vector3.new(-1, 0, 0), Vector3.new(0, 0, 1));
local CFrame_new_ret = CFrame.new(0, 0, 1.3);
local u76 = nil;
local RaycastParams_new_ret = RaycastParams.new();
RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;

local function arrow() -- Line: 575
    -- upvalues: u76 (ref), Color3_fromRGB_ret2 (copy)
    if u76 then
        return u76;
    end;

    local Model = Instance.new("Model");
    Model.Name = "LightsOutArrow";
    u76 = {
        model = Model
    };

    local function piece(p77, p78, p79) -- Line: 582
        -- upvalues: Color3_fromRGB_ret2 (ref), Model (copy), u76 (ref)
        local Instance_new_ret = Instance.new(p78);
        Instance_new_ret.Name = p77;
        Instance_new_ret.Anchored = true;
        Instance_new_ret.CanCollide = false;
        Instance_new_ret.CanQuery = false;
        Instance_new_ret.CanTouch = false;
        Instance_new_ret.CastShadow = false;
        Instance_new_ret.Material = Enum.Material.Neon;
        Instance_new_ret.Color = Color3_fromRGB_ret2;
        Instance_new_ret.Size = p79;
        Instance_new_ret.Parent = Model;
        u76[p77] = Instance_new_ret;

        return Instance_new_ret;
    end;

    local WedgePart = Instance.new("WedgePart");
    WedgePart.Name = "HeadRight";
    WedgePart.Anchored = true;
    WedgePart.CanCollide = false;
    WedgePart.CanQuery = false;
    WedgePart.CanTouch = false;
    WedgePart.CastShadow = false;
    WedgePart.Material = Enum.Material.Neon;
    WedgePart.Color = Color3_fromRGB_ret2;
    WedgePart.Size = Vector3.new(0.2, 1.5, 2.4);
    WedgePart.Parent = Model;
    u76.HeadRight = WedgePart;
    local WedgePart2 = Instance.new("WedgePart");
    WedgePart2.Name = "HeadLeft";
    WedgePart2.Anchored = true;
    WedgePart2.CanCollide = false;
    WedgePart2.CanQuery = false;
    WedgePart2.CanTouch = false;
    WedgePart2.CastShadow = false;
    WedgePart2.Material = Enum.Material.Neon;
    WedgePart2.Color = Color3_fromRGB_ret2;
    WedgePart2.Size = Vector3.new(0.2, 1.5, 2.4);
    WedgePart2.Parent = Model;
    u76.HeadLeft = WedgePart2;
    local Part = Instance.new("Part");
    Part.Name = "Shaft";
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.CastShadow = false;
    Part.Material = Enum.Material.Neon;
    Part.Color = Color3_fromRGB_ret2;
    Part.Size = Vector3.new(1.15, 0.2, 2.6);
    Part.Parent = Model;
    u76.Shaft = Part;
    local PointLight = Instance.new("PointLight");
    PointLight.Color = Color3_fromRGB_ret2;
    PointLight.Range = 18;
    PointLight.Brightness = 0.6;
    PointLight.Shadows = false;
    PointLight.Parent = u76.Shaft;
    Model.Parent = workspace;

    return u76;
end;

local function hideArrow() -- Line: 607
    -- upvalues: u76 (ref)
    if u76 then
        u76.model:Destroy();
        u76 = nil;
    end;
end;

local function nearest(p80, p81, p82) -- Line: 614
    local v83 = p82 - p81;
    local v84 = v83:Dot(v83);
    local v85;

    if v84 > 1e-6 then
        local v86 = (p80 - p81):Dot(v83) / v84;
        v85 = math.clamp(v86, 0, 1);
    else
        v85 = 0;
    end;

    return p81 + v83 * v85;
end;

local function drawArrow() -- Line: 620
    -- upvalues: LocalPlayer (copy), u60 (ref), u76 (ref), arrow (copy), RaycastParams_new_ret (copy), CFrame_fromMatrix_ret (copy), CFrame_fromMatrix_ret2 (copy), CFrame_new_ret (copy)
    local Character = LocalPlayer.Character;
    local v87;

    if Character then
        v87 = Character:FindFirstChild("HumanoidRootPart");
    else
        v87 = Character;
    end;

    local v88;

    if Character then
        v88 = Character:FindFirstChildOfClass("Humanoid");
    else
        v88 = Character;
    end;

    if not (u60 and (v87 and (v88 and (v88.Health > 0 and (LocalPlayer:GetAttribute("GameRole") == "Runner" and LocalPlayer:GetAttribute("RunState") == "Active"))))) then
        if u76 then
            u76.model:Destroy();
            u76 = nil;
        end;

        return;
    end;

    local Position = v87.Position;
    local v89 = u60[1];
    local v90 = u60[2] - v89;
    local v91 = v90:Dot(v90);
    local v92;

    if v91 > 1e-6 then
        local v93 = (Position - v89):Dot(v90) / v91;
        v92 = math.clamp(v93, 0, 1);
    else
        v92 = 0;
    end;

    local v94 = v89 + v90 * v92 - v87.Position;
    local Vector3_new_ret = Vector3.new(v94.X, 0, v94.Z);

    if Vector3_new_ret.Magnitude < 1 then
        if u76 then
            u76.model:Destroy();
            u76 = nil;
        end;

        return;
    end;

    local Unit = Vector3_new_ret.Unit;
    local v95 = arrow();
    RaycastParams_new_ret.FilterDescendantsInstances = { Character, v95.model };
    local v96 = workspace:Raycast(v87.Position, Vector3.new(0, -12, 0), RaycastParams_new_ret);
    local v97;

    if v96 then
        v97 = v96.Position.Y;
    else
        v97 = v87.Position.Y - v88.HipHeight - v87.Size.Y / 2;
    end;

    local os_clock_ret = os.clock();
    local v98 = Vector3.new(v87.Position.X, v97 + 0.1 + 0.06, v87.Position.Z) + Unit * (math.sin(os_clock_ret * 4.5) * 0.35 + 5.2);
    local CFrame_lookAt_ret = CFrame.lookAt(v98, v98 + Unit);
    v95.HeadRight.CFrame = CFrame_lookAt_ret * CFrame_fromMatrix_ret;
    v95.HeadLeft.CFrame = CFrame_lookAt_ret * CFrame_fromMatrix_ret2;
    v95.Shaft.CFrame = CFrame_lookAt_ret * CFrame_new_ret;
    local v99 = (1 - (math.sin(os_clock_ret * 3.141592653589793 * 2 / 1.5) + 1) / 2) * 0.2 + 0.05;
    v95.HeadRight.Transparency = v99;
    v95.HeadLeft.Transparency = v99;
    v95.Shaft.Transparency = v99;
end;

local u100 = 0;

local function keepGoal(p101) -- Line: 659
    -- upvalues: u100 (ref), u60 (ref), u61 (ref), Session (copy), findGoal (copy)
    u100 = u100 + p101;

    if u100 >= 0.5 then
        u100 = 0;

        if not u60 or u61 ~= Session:GetAttribute("StartSide") then
            findGoal();
        end;
    end;
end;

local function start() -- Line: 673
    -- upvalues: u7 (ref), LocalPlayer (copy), switchSound (copy), nightOn (copy), unmarkAll (copy), u35 (copy), u51 (copy), u12 (copy), RunService (copy), watchChasers (copy), watchRunners (copy), u100 (ref), findGoal (copy), keepGoal (copy), drawArrow (copy), Session (copy), u13 (ref), u2 (copy), u1 (copy), u14 (ref), TweenService (copy), showTitle (copy), PlayerGui (copy), hold (copy), hideFeed (copy), onRig (copy), u4 (copy), StarterGui (copy), u11 (copy)
    if u7 then
        return;
    end;

    u7 = true;
    LocalPlayer:SetAttribute("LightsOutDark", true);
    switchSound();
    nightOn();
    unmarkAll();
    table.clear(u35);

    for _, v in u51 do
        v:Destroy();
    end;

    table.clear(u51);
    table.insert(u12, RunService.Heartbeat:Connect(watchChasers));
    table.insert(u12, RunService.Heartbeat:Connect(watchRunners));
    u100 = 0;
    findGoal();
    table.insert(u12, RunService.Heartbeat:Connect(keepGoal));
    table.insert(u12, RunService.RenderStepped:Connect(drawArrow));
    local AttributeChangedSignal = Session:GetAttributeChangedSignal("StartSide");
    table.insert(u12, AttributeChangedSignal:Connect(findGoal));

    if not u13 then
        u13 = Instance.new("ColorCorrectionEffect");
        u13.Name = "LightsOutDark";

        for i, v in u2 do
            u13[i] = v;
        end;
    end;

    u13.Parent = workspace.CurrentCamera;

    if u14 then
        u14:Cancel();
    end;

    u14 = TweenService:Create(u13, TweenInfo.new(0.35, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), u1);
    u14:Play();
    showTitle();

    for _, child in PlayerGui:GetChildren() do
        if child:IsA("LayerCollector") then
            hold(child);
            hideFeed(child);
        end;
    end;

    for _, descendant in workspace:GetDescendants() do
        if descendant:IsA("Highlight") or descendant:IsA("BillboardGui") and (descendant.Name ~= "RoleMarker" and onRig(descendant)) then
            hold(descendant);
        end;
    end;

    table.insert(u12, PlayerGui.ChildAdded:Connect(function(u102) -- Line: 711
        -- upvalues: hold (ref), u7 (ref), hideFeed (ref)
        if u102:IsA("LayerCollector") then
            hold(u102);
            task.defer(function() -- Line: 714
                -- upvalues: u7 (ref), u102 (copy), hideFeed (ref)
                if u7 and u102.Parent then
                    hideFeed(u102);
                end;
            end);
        end;
    end));
    table.insert(u12, workspace.DescendantAdded:Connect(function(u103) -- Line: 721
        -- upvalues: u7 (ref), onRig (ref), hold (ref)
        if u103:IsA("Highlight") or u103:IsA("BillboardGui") then
            task.defer(function() -- Line: 724
                -- upvalues: u7 (ref), u103 (copy), onRig (ref), hold (ref)
                if u7 and u103.Parent then
                    local v104 = u103;

                    if v104:IsA("Highlight") or v104:IsA("BillboardGui") and (v104.Name ~= "RoleMarker" and onRig(v104)) then
                        hold(v104);
                    end;
                end;
            end);
        end;
    end));

    for _, v in u4 do
        local success, result = pcall(StarterGui.GetCoreGuiEnabled, StarterGui, v);

        if success and result then
            u11[v] = true;
            pcall(StarterGui.SetCoreGuiEnabled, StarterGui, v, false);
        end;
    end;
end;

local function stop() -- Line: 740
    -- upvalues: u7 (ref), LocalPlayer (copy), switchSound (copy), u12 (copy), nightOff (copy), unmarkAll (copy), u35 (copy), u51 (copy), u60 (ref), u61 (ref), u76 (ref), u40 (ref), u36 (ref), u37 (ref), u8 (copy), u9 (copy), u10 (copy), u11 (copy), StarterGui (copy), u13 (ref), fadeTo (copy), u2 (copy)
    if not u7 then
        return;
    end;

    u7 = false;
    LocalPlayer:SetAttribute("LightsOutDark", nil);
    switchSound();

    for _, v in u12 do
        v:Disconnect();
    end;

    table.clear(u12);
    nightOff();
    unmarkAll();
    table.clear(u35);

    for _, v in u51 do
        v:Destroy();
    end;

    table.clear(u51);
    u60 = nil;
    u61 = nil;

    if u76 then
        u76.model:Destroy();
        u76 = nil;
    end;

    if u40 then
        u40:Destroy();
        u40 = nil;
    end;

    if u36 then
        u36:Destroy();
        u36 = nil;
        u37 = nil;
    end;

    for i, v in u8 do
        v:Disconnect();

        if u9[i] and i.Parent then
            i.Enabled = true;
        end;
    end;

    table.clear(u8);
    table.clear(u9);

    for i, v in u10 do
        v:Disconnect();

        if i.Parent then
            i.Visible = true;
        end;
    end;

    table.clear(u10);

    for i in u11 do
        pcall(StarterGui.SetCoreGuiEnabled, StarterGui, i, true);
    end;

    table.clear(u11);

    if u13 then
        fadeTo(u2, 0.8, function() -- Line: 782
            -- upvalues: u7 (ref), u13 (ref)
            if not u7 and u13 then
                u13:Destroy();
                u13 = nil;
            end;
        end);
    end;
end;

local function refresh() -- Line: 791
    -- upvalues: Session (copy), LocalPlayer (copy), start (copy), stop (copy)
    if Session:GetAttribute("LightsOut") == true and LocalPlayer:GetAttribute("InMatch") == true then
        start();

        return;
    end;

    stop();
end;

local u105 = { Session:GetAttributeChangedSignal("LightsOut"):Connect(refresh), LocalPlayer:GetAttributeChangedSignal("InMatch"):Connect(refresh), workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function() -- Line: 802
        -- upvalues: u13 (ref)
        if u13 and workspace.CurrentCamera then
            u13.Parent = workspace.CurrentCamera;
        end;
    end) };

if Session:GetAttribute("LightsOut") == true and LocalPlayer:GetAttribute("InMatch") == true then
    start();
else
    stop();
end;

script.Destroying:Connect(function() -- Line: 810
    -- upvalues: u105 (copy), stop (copy), u14 (ref), u13 (ref)
    for _, v in u105 do
        v:Disconnect();
    end;

    stop();

    if u14 then
        u14:Cancel();
    end;

    if u13 then
        u13:Destroy();
    end;
end);