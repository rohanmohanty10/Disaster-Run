  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local UserInputService = game:GetService("UserInputService");
local Players = game:GetService("Players");
local GuiService = game:GetService("GuiService");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
require(ReplicatedStorage.ReplicatedModules.AnimationHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(Knit.Util.Trove);
local Signal = require(ReplicatedStorage.ReplicatedRoot.Libraries.Classes.Signal);
local InputUtil = require(ReplicatedStorage.ReplicatedRoot.Libraries.Utility.InputUtil);
local LocalPlayer = Players.LocalPlayer;
local u1 = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled;
local u2 = GuiService:IsTenFootInterface();
local u3 = Random.new();
local u4 = {
    Enum.KeyCode.E,
    Enum.KeyCode.Q,
    Enum.KeyCode.F,
    Enum.KeyCode.R,
    Enum.KeyCode.G,
    Enum.KeyCode.X,
    Enum.KeyCode.C,
    Enum.KeyCode.V
};
local u5 = {
    Enum.KeyCode.ButtonA,
    Enum.KeyCode.ButtonB,
    Enum.KeyCode.ButtonX,
    Enum.KeyCode.ButtonY,
    Enum.KeyCode.ButtonL1,
    Enum.KeyCode.ButtonR1,
    Enum.KeyCode.ButtonL2,
    Enum.KeyCode.ButtonR2
};
local u6 = {
    [Enum.KeyCode.ButtonA] = "A",
    [Enum.KeyCode.ButtonB] = "B",
    [Enum.KeyCode.ButtonX] = "X",
    [Enum.KeyCode.ButtonY] = "Y",
    [Enum.KeyCode.ButtonL1] = "LB",
    [Enum.KeyCode.ButtonR1] = "RB",
    [Enum.KeyCode.ButtonL2] = "LT",
    [Enum.KeyCode.ButtonR2] = "RT",
    [Enum.KeyCode.ButtonL3] = "L3",
    [Enum.KeyCode.ButtonR3] = "R3",
    [Enum.KeyCode.DPadUp] = "↑",
    [Enum.KeyCode.DPadDown] = "↓",
    [Enum.KeyCode.DPadLeft] = "←",
    [Enum.KeyCode.DPadRight] = "→"
};

local function GetKeyDisplay(p7) -- Line: 51
    -- upvalues: u6 (copy)
    return u6[p7] or p7.Name;
end;

local function IsGamepadInput(p8) -- Line: 55
    return (p8 == Enum.UserInputType.Gamepad1 or (p8 == Enum.UserInputType.Gamepad2 or p8 == Enum.UserInputType.Gamepad3)) and true or p8 == Enum.UserInputType.Gamepad4;
end;

local function IsValidQTEInput(p9) -- Line: 62
    return (p9 == Enum.UserInputType.Keyboard or (p9 == Enum.UserInputType.Gamepad1 or (p9 == Enum.UserInputType.Gamepad2 or p9 == Enum.UserInputType.Gamepad3))) and true or p9 == Enum.UserInputType.Gamepad4;
end;

local function TransformKeys(p10) -- Line: 68
    -- upvalues: InputUtil (copy)
    local v11 = {};

    for _, v in typeof(p10) ~= "table" and { p10 } or p10 do
        if typeof(v) == "string" then
            local v = InputUtil.FromLegacyString(v).KeyCode;
        end;

        if typeof(v) == "EnumItem" then
            table.insert(v11, v);
        end;
    end;

    return v11;
end;

local function ScaleUDim2(p12, p13) -- Line: 90
    return UDim2.fromScale(p12.X.Scale * p13, p12.Y.Scale * p13);
end;

local u14 = {};
u14.__index = u14;

function u14.new(p15) -- Line: 97
    -- upvalues: Trove (copy), u1 (copy), TransformKeys (copy), u4 (copy), u5 (copy), u14 (copy), u2 (copy), UserInputService (copy), Signal (copy)
    local v16 = {
        Hits = 0,
        Misses = 0,
        Total = 0,
        Spawned = 0,
        NextSpawn = 0,
        StartTime = 0,
        MinigameEnded = false,
        Active = false,
        Destroyed = false,
        UseGamepad = false,
        RingBaseSize = nil,
        FrameBaseSize = nil,
        Hit = nil,
        Ended = nil,
        Trove = Trove.new(),
        Amount = p15.Amount or 1,
        Duration = p15.Duration,
        MaxMisses = p15.MaxMisses,
        Goal = p15.Goal,
        ShrinkTime = p15.ShrinkTime or Vector2.new(0.4, 0.6),
        HitWindow = p15.HitWindow or 0.15,
        Interval = p15.Interval or { 0.8, 2 },
        RandomPosition = p15.RandomPosition or false,
        TapOnly = p15.TapOnly or u1,
        Keys = TransformKeys(p15.Keys or u4),
        GamepadKeys = TransformKeys(p15.GamepadKeys or u5),
        RingMaxScale = p15.RingScale or 2.5,
        ShowUI = p15.ShowUI or false,
        Prompts = {}
    };
    local v17 = setmetatable(v16, u14);
    local v18 = u2;

    if not v18 then
        local v19 = UserInputService:GetLastInputType();
        v18 = (v19 == Enum.UserInputType.Gamepad1 or (v19 == Enum.UserInputType.Gamepad2 or v19 == Enum.UserInputType.Gamepad3)) and true or v19 == Enum.UserInputType.Gamepad4;
    end;

    v17.UseGamepad = v18;
    v17.Hit = v17.Trove:Construct(Signal);
    v17.Ended = v17.Trove:Construct(Signal);

    return v17;
end;

function u14.Setup(p20) -- Line: 142
    -- upvalues: LocalPlayer (copy)
    local ScreenGui = Instance.new("ScreenGui");
    ScreenGui.Name = "QTEMiniMinigame";
    ScreenGui.IgnoreGuiInset = true;
    ScreenGui.DisplayOrder = 50;
    ScreenGui.ResetOnSpawn = false;
    ScreenGui.Parent = LocalPlayer.PlayerGui;
    p20.Trove:Add(ScreenGui);
    p20.Gui = ScreenGui;
    local QTE = script.QTE;
    p20.RingBaseSize = QTE.Ring.Size;
    p20.FrameBaseSize = QTE.Frame.Size;

    if p20.ShowUI then
        if p20.Duration then
            local TextLabel = Instance.new("TextLabel");
            TextLabel.Size = UDim2.fromScale(0.2, 0.04);
            TextLabel.Position = UDim2.fromScale(0.5, 0.08);
            TextLabel.AnchorPoint = Vector2.new(0.5, 0.5);
            TextLabel.BackgroundTransparency = 1;
            TextLabel.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold);
            TextLabel.TextSize = 24;
            TextLabel.TextColor3 = Color3.new(1, 1, 1);
            TextLabel.TextStrokeTransparency = 0.5;
            TextLabel.TextStrokeColor3 = Color3.new(0, 0, 0);
            TextLabel.Parent = ScreenGui;
            p20.TimeLabel = TextLabel;
        end;

        local TextLabel = Instance.new("TextLabel");
        TextLabel.Size = UDim2.fromScale(0.25, 0.04);
        TextLabel.Position = UDim2.fromScale(0.5, p20.Duration and 0.12 or 0.08);
        TextLabel.AnchorPoint = Vector2.new(0.5, 0.5);
        TextLabel.BackgroundTransparency = 1;
        TextLabel.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold);
        TextLabel.TextSize = 20;
        TextLabel.TextColor3 = Color3.new(1, 1, 1);
        TextLabel.TextStrokeTransparency = 0.5;
        TextLabel.TextStrokeColor3 = Color3.new(0, 0, 0);
        TextLabel.Parent = ScreenGui;
        p20.AccLabel = TextLabel;
    end;
end;

function u14.RollShrinkTime(p21) -- Line: 187
    -- upvalues: u3 (copy)
    if typeof(p21.ShrinkTime) == "Vector2" then
        return u3:NextNumber(p21.ShrinkTime.X, p21.ShrinkTime.Y);
    end;

    return p21.ShrinkTime;
end;

function u14.GetActiveKey(p22, p23) -- Line: 194
    if p22.UseGamepad then
        return p23.GamepadKey;
    end;

    return p23.KeyboardKey;
end;

function u14.GetKeyLabelText(p24, p25) -- Line: 198
    -- upvalues: u6 (copy)
    if p24.TapOnly then
        return "TAP";
    end;

    local v26 = p24:GetActiveKey(p25);

    return u6[v26] or v26.Name;
end;

function u14.RefreshPromptLabels(p27) -- Line: 205
    for _, v in p27.Prompts do
        if v.Alive and v.KeyLabel then
            v.KeyLabel.Text = p27:GetKeyLabelText(v);
        end;
    end;
end;

function u14.UpdateInputMode(p28, p29) -- Line: 213
    -- upvalues: UserInputService (copy)
    local v30 = p29 or UserInputService:GetLastInputType();
    local v31 = false;

    if (v30 == Enum.UserInputType.Gamepad1 or (v30 == Enum.UserInputType.Gamepad2 or v30 == Enum.UserInputType.Gamepad3)) and true or v30 == Enum.UserInputType.Gamepad4 then
        if not p28.UseGamepad then
            p28.UseGamepad = true;
            v31 = true;
        end;
    elseif v30 == Enum.UserInputType.Keyboard and p28.UseGamepad then
        p28.UseGamepad = false;
        v31 = true;
    end;

    if v31 then
        p28:RefreshPromptLabels();
    end;
end;

function u14.UpdatePromptRing(p32, p33) -- Line: 234
    p33.Ring.Size = UDim2.fromScale(p32.RingBaseSize.X.Scale * p33.RingScale, p32.RingBaseSize.Y.Scale * p33.RingScale);
    local v34 = math.clamp((p33.RingScale - 1) / (p32.RingMaxScale - 1) * 0.25, 0, 1) + 0.75;
    p33.Ring.Transparency = v34;
end;

function u14.GetPromptAccuracy(p35, p36) -- Line: 245
    local v37 = p35.HitWindow * (p35.RingMaxScale - 1);
    local v38 = 1 - math.abs(p36.RingScale - 1) / v37;

    return math.clamp(v38, 0, 1);
end;

function u14.Flash(p39, u40, p41) -- Line: 250
    -- upvalues: TweenService (copy), u3 (copy)
    u40.Frame.Visible = false;
    u40.Ring.Visible = false;
    local FrameBaseSize = p39.FrameBaseSize;

    if p41 then
        local v42 = p39:GetPromptAccuracy(u40);
        local Frame = Instance.new("Frame");
        Frame.Size = FrameBaseSize;
        Frame.Position = u40.Frame.Position;
        Frame.AnchorPoint = u40.Frame.AnchorPoint;
        Frame.BackgroundColor3 = Color3.fromRGB(80, 255, 120);
        Frame.BackgroundTransparency = 0.2;
        Frame.Parent = u40.Root;
        Instance.new("UICorner", Frame).CornerRadius = UDim.new(1, 0);
        local TextLabel = Instance.new("TextLabel");
        TextLabel.Size = UDim2.fromScale(1, 1);
        TextLabel.BackgroundTransparency = 1;
        TextLabel.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.ExtraBold);
        TextLabel.TextSize = 32;
        TextLabel.TextColor3 = Color3.new(1, 1, 1);
        TextLabel.TextStrokeTransparency = 0.2;
        TextLabel.Text = v42 >= 0.8 and "PERFECT" or "HIT";
        TextLabel.Parent = Frame;
        TweenService:Create(Frame, TweenInfo.new(0.1, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Size = UDim2.fromScale(FrameBaseSize.X.Scale * 1.15, FrameBaseSize.Y.Scale * 1.15)
        }):Play();
        task.delay(0.1, function() -- Line: 282
            -- upvalues: Frame (copy), TweenService (ref), FrameBaseSize (copy), TextLabel (copy)
            if not Frame.Parent then
                return;
            end;

            local v43 = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
            local v44 = {
                BackgroundTransparency = 1
            };
            local v45 = FrameBaseSize;
            v44.Size = UDim2.fromScale(v45.X.Scale * 1.25, v45.Y.Scale * 1.25);
            TweenService:Create(Frame, v43, v44):Play();
            TweenService:Create(TextLabel, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                TextTransparency = 1,
                TextStrokeTransparency = 1
            }):Play();
        end);
        TweenService:Create(u40.Root, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            BackgroundTransparency = 1
        }):Play();
        task.delay(0.35, function() -- Line: 298
            -- upvalues: u40 (copy)
            u40.Root:Destroy();
        end);

        return;
    end;

    local Frame = Instance.new("Frame");
    Frame.Size = FrameBaseSize;
    Frame.Position = u40.Frame.Position;
    Frame.AnchorPoint = u40.Frame.AnchorPoint;
    Frame.BackgroundColor3 = Color3.fromRGB(255, 80, 80);
    Frame.BackgroundTransparency = 0.3;
    Frame.Parent = u40.Root;
    Instance.new("UICorner", Frame).CornerRadius = UDim.new(1, 0);
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Size = UDim2.fromScale(1, 1);
    TextLabel.BackgroundTransparency = 1;
    TextLabel.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.ExtraBold);
    TextLabel.TextSize = 28;
    TextLabel.TextColor3 = Color3.new(1, 1, 1);
    TextLabel.TextStrokeTransparency = 0.3;
    TextLabel.Text = "MISS";
    TextLabel.Parent = Frame;
    local Position = u40.Root.Position;
    task.spawn(function() -- Line: 320
        -- upvalues: u40 (copy), Position (copy), u3 (ref)
        for _ = 1, 3 do
            u40.Root.Position = Position + UDim2.fromScale((u3:NextNumber() - 0.5) * 0.012, (u3:NextNumber() - 0.5) * 0.012);
            task.wait();
        end;

        u40.Root.Position = Position;
    end);
    TweenService:Create(Frame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        BackgroundTransparency = 1,
        Size = UDim2.fromScale(FrameBaseSize.X.Scale * 0.85, FrameBaseSize.Y.Scale * 0.85)
    }):Play();
    TweenService:Create(TextLabel, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        TextTransparency = 1,
        TextStrokeTransparency = 1
    }):Play();
    TweenService:Create(u40.Root, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        BackgroundTransparency = 1
    }):Play();
    task.delay(0.35, function() -- Line: 344
        -- upvalues: u40 (copy)
        u40.Root:Destroy();
    end);
end;

function u14.KillPrompt(p46, p47, p48) -- Line: 348
    -- upvalues: EffectsHandler (copy)
    if not p47.Alive then
        return;
    end;

    p47.Alive = false;

    if p48 then
        p46.Hits = p46.Hits + 1;
    else
        p46.Misses = p46.Misses + 1;
    end;

    task.spawn(EffectsHandler.CallEffect, "Yuki_Vignette", {
        LifeTime = 0.2,
        Transparency = 0.5,
        TweenIn = { 0.05, Enum.EasingStyle.Sine, Enum.EasingDirection.In },
        TweenOut = { 0.225, Enum.EasingStyle.Sine, Enum.EasingDirection.Out },
        Size = UDim2.fromScale(1.25, 1.25),
        Color = p48 and Color3.fromRGB(180, 255, 180) or Color3.fromRGB(255, 52, 52)
    });
    p46:Flash(p47, p48);
    p46.Hit:Fire(p48, p46:GetPromptAccuracy(p47));
end;

function u14.CanSpawn(p49) -- Line: 371
    return (not p49.Amount or p49.Spawned < p49.Amount) and true or false;
end;

function u14.CheckEnd(p50) -- Line: 376
    return p50.MaxMisses and p50.Misses >= p50.MaxMisses and true or (p50.Duration and os.clock() - p50.StartTime >= p50.Duration and true or (p50.Amount and (p50.Spawned >= p50.Amount and #p50.Prompts == 0) and true or (p50.Goal and p50.Hits >= p50.Goal and true or false)));
end;

function u14.SpawnPrompt(u51) -- Line: 383
    -- upvalues: u3 (copy), TweenService (copy)
    if not u51:CanSpawn() then
        return;
    end;

    u51.Spawned = u51.Spawned + 1;
    local v52 = script.QTE:Clone();
    v52.Visible = false;
    v52.Parent = u51.Gui;
    local Ring = v52.Ring;
    local Frame = v52.Frame;
    local v53 = Frame:FindFirstChildOfClass("TextLabel");
    local v54 = u3:NextInteger(1, (math.min(#u51.Keys, #u51.GamepadKeys)));
    local v55 = u51.Keys[v54];
    local v56 = u51.GamepadKeys[v54];
    Frame.Active = u51.TapOnly;

    if u51.RandomPosition then
        v52.Position = UDim2.fromScale(u3:NextInteger(15, 85) / 100, u3:NextInteger(15, 75) / 100);
    else
        v52.Position = UDim2.fromScale(0.5, 0.84);
    end;

    v52.Visible = true;
    local u57 = {
        Alive = true,
        Root = v52,
        Ring = Ring,
        Frame = Frame,
        KeyLabel = v53,
        KeyboardKey = v55,
        GamepadKey = v56,
        RingScale = u51.RingMaxScale,
        ShrinkTime = u51:RollShrinkTime(),
        SpawnTime = os.clock()
    };
    v53.Text = u51:GetKeyLabelText(u57);
    u51:UpdatePromptRing(u57);
    u51.Total = u51.Total + 1;
    table.insert(u51.Prompts, u57);
    v52.Size = UDim2.fromScale(0.135, 0.135);
    TweenService:Create(v52, TweenInfo.new(0.15, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.fromScale(0.12, 0.12)
    }):Play();

    if u51.TapOnly then
        u51.Trove:Connect(Frame.Activated, function() -- Line: 438
            -- upvalues: u57 (copy), u51 (copy)
            if not u57.Alive then
                return;
            end;

            if u51:GetPromptAccuracy(u57) > 0 then
                u51:KillPrompt(u57, true);

                return;
            end;

            u51:KillPrompt(u57, false);
        end);
    end;
end;

function u14.TryHitKey(p58, p59) -- Line: 449
    for _, v in p58.Prompts do
        if v.Alive and (v.KeyboardKey == p59 or v.GamepadKey == p59) then
            if p58:GetPromptAccuracy(v) > 0 then
                p58:KillPrompt(v, true);

                return;
            end;

            p58:KillPrompt(v, false);

            return;
        end;
    end;
end;

function u14.UpdateUI(p60) -- Line: 462
    if not p60.ShowUI then
        return;
    end;

    if p60.TimeLabel and p60.Duration then
        local v61 = p60.Duration - (os.clock() - p60.StartTime);
        local v62 = math.max(0, v61);
        p60.TimeLabel.Text = string.format("%d:%02d", math.floor(v62 / 60), (math.floor(v62 % 60)));
    end;

    if p60.AccLabel then
        local v63 = {};
        local v64 = `{p60.Total <= 0 and 100 or math.floor(p60.Hits / p60.Total * 100)}%`;
        table.insert(v63, v64);

        if p60.Goal then
            local v65 = `{p60.Hits}/{p60.Goal}`;
            table.insert(v63, v65);
        end;

        if p60.Amount then
            local v66 = `{p60.Spawned}/{p60.Amount}`;
            table.insert(v63, v66);
        end;

        p60.AccLabel.Text = table.concat(v63, "  |  ");

        if p60.MaxMisses and p60.Misses >= p60.MaxMisses - 1 then
            p60.AccLabel.TextColor3 = Color3.fromRGB(255, 80, 80);

            return;
        end;

        p60.AccLabel.TextColor3 = Color3.new(1, 1, 1);
    end;
end;

function u14.Run(u67) -- Line: 494
    -- upvalues: UserInputService (copy), RunService (copy), u3 (copy)
    u67.Active = true;
    u67:Setup();
    u67.StartTime = os.clock();
    u67.NextSpawn = 0;

    if not u67.TapOnly then
        u67.Trove:Connect(UserInputService.InputBegan, function(p68, p69) -- Line: 502
            -- upvalues: u67 (copy)
            if p69 or u67.MinigameEnded then
                return;
            end;

            local UserInputType = p68.UserInputType;

            if UserInputType ~= Enum.UserInputType.Keyboard and (UserInputType ~= Enum.UserInputType.Gamepad1 and (UserInputType ~= Enum.UserInputType.Gamepad2 and UserInputType ~= Enum.UserInputType.Gamepad3)) and UserInputType ~= Enum.UserInputType.Gamepad4 then
                return;
            end;

            u67:TryHitKey(p68.KeyCode);
        end);
        u67.Trove:Connect(UserInputService.LastInputTypeChanged, function(p70) -- Line: 508
            -- upvalues: u67 (copy)
            if u67.MinigameEnded then
                return;
            end;

            u67:UpdateInputMode(p70);
        end);
    end;

    u67.Trove:Connect(RunService.RenderStepped, function(p71) -- Line: 514
        -- upvalues: u67 (copy), u3 (ref)
        if u67.MinigameEnded then
            return;
        end;

        u67:UpdateUI();

        for _, v in u67.Prompts do
            if v.Alive then
                v.RingScale = v.RingScale - (u67.RingMaxScale - 1) / v.ShrinkTime * p71;

                if v.RingScale <= 1 - u67.HitWindow * (u67.RingMaxScale - 1) then
                    u67:KillPrompt(v, false);
                else
                    u67:UpdatePromptRing(v);
                    local v72 = (os.clock() - v.SpawnTime) * 6;
                    local v73 = math.sin(v72) * 0.015 + 1;
                    v.Frame.Size = UDim2.fromScale(u67.FrameBaseSize.X.Scale * v73, u67.FrameBaseSize.Y.Scale * v73);
                end;
            end;
        end;

        for i = #u67.Prompts, 1, -1 do
            if not u67.Prompts[i].Alive then
                table.remove(u67.Prompts, i);
            end;
        end;

        if os.clock() >= u67.NextSpawn and u67:CanSpawn() then
            u67:SpawnPrompt();
            u67.NextSpawn = os.clock() + u67.Interval[1] + u3:NextNumber() * (u67.Interval[2] - u67.Interval[1]);
        end;

        if u67:CheckEnd() then
            u67.MinigameEnded = true;

            for _, v in u67.Prompts do
                if v.Alive then
                    v.Alive = false;
                    v.Root:Destroy();
                end;
            end;

            table.clear(u67.Prompts);
            u67.Ended:Fire({
                Accuracy = u67.Total <= 0 and 0 or math.floor(u67.Hits / u67.Total * 100),
                Hits = u67.Hits,
                Misses = u67.Misses,
                Total = u67.Total,
                GoalMet = not u67.Goal and true or u67.Hits >= u67.Goal
            });
        end;
    end);
end;

function u14.Destroy(u74) -- Line: 571
    if u74.Destroyed then
        return;
    end;

    u74.Destroyed = true;

    for _, v in u74.Prompts do
        if v.Alive then
            v.Root:Destroy();
        end;
    end;

    table.clear(u74.Prompts);
    u74.Trove:Destroy();
    task.defer(function() -- Line: 584
        -- upvalues: u74 (copy)
        table.clear(u74);
        table.freeze(u74);
    end);
end;

local function FireResult(p75, p76) -- Line: 590
    if p75:IsA("RemoteEvent") then
        p75:FireServer(p76);

        return;
    end;

    if p75:IsA("BindableEvent") then
        p75:Fire(p76);
    end;
end;

local function CreateMinigame(u77, p78) -- Line: 598
    -- upvalues: Trove (copy), u14 (copy)
    local u79 = Trove.new();
    u79:AttachToInstance(u77);
    local u80 = u14.new(p78);
    u79:Add(function() -- Line: 603
        -- upvalues: u80 (copy)
        u80:Destroy();
    end);
    local u81 = {};
    u79:Connect(u80.Hit, function(p82, p83) -- Line: 609
        -- upvalues: u81 (copy)
        table.insert(u81, {
            Success = p82,
            Accuracy = p83
        });
    end);
    u79:Connect(u80.Ended, function(p84) -- Line: 618
        -- upvalues: u77 (copy), u79 (copy)
        local v85 = u77;

        if v85:IsA("RemoteEvent") then
            v85:FireServer(p84);
        elseif v85:IsA("BindableEvent") then
            v85:Fire(p84);
        end;

        task.delay(0.5, u79.Destroy, u79);
    end);
    task.spawn(u80.Run, u80);
end;

return function(p86, p87) -- Line: 626
    -- upvalues: CreateMinigame (copy)
    CreateMinigame(p86, p87);
end;