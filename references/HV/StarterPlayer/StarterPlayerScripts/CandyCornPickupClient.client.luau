 

 

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local LocalPlayer = Players.LocalPlayer;
local ChickenOrHero = game.ReplicatedStorage:WaitForChild("ChickenOrHero");
local Collectibles = ChickenOrHero:WaitForChild("Collectibles");
local CandyCornEvent = Collectibles:WaitForChild("CandyCornEvent");
local CandyCornConfig = require(Collectibles:WaitForChild("CandyCornConfig"));
local CandyCorn = require(ChickenOrHero:WaitForChild("Game"):WaitForChild("CandyCorn"));
local PresentationCues = ChickenOrHero:WaitForChild("Audio"):WaitForChild("PresentationCues");
local Session = ChickenOrHero:WaitForChild("Game"):WaitForChild("Session");
local u1 = {
    GroupRun = true,
    HeroRun = true,
    FinalRun = true
};
local Folder = Instance.new("Folder");
local Font_new_ret = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.ExtraBold);
Folder.Name = "LocalRunnerCandyCorn";
Folder.Parent = workspace;
local u2 = {};
local u3 = nil;

local function eligible() -- Line: 23
    -- upvalues: LocalPlayer (copy), u1 (copy), Session (copy)
    local v4;

    if LocalPlayer:GetAttribute("GameRole") == "Runner" and (LocalPlayer:GetAttribute("RunState") == "Active" and LocalPlayer:GetAttribute("InMatch") == true) then
        v4 = u1[Session:GetAttribute("Phase")] == true;
    else
        v4 = false;
    end;

    return v4;
end;

local function clear() -- Line: 29
    -- upvalues: u2 (copy), u3 (ref)
    for _, v in u2 do
        v.part:Destroy();
    end;

    table.clear(u2);
    u3 = nil;
end;

local function billboard(p5) -- Line: 46
    -- upvalues: CandyCornConfig (copy), CandyCorn (copy), Font_new_ret (copy)
    local BillboardGui = Instance.new("BillboardGui");
    BillboardGui.Name = "CandyCorn";
    BillboardGui.LightInfluence = 0;
    BillboardGui.AlwaysOnTop = false;
    BillboardGui.MaxDistance = CandyCornConfig.MaxVisibleDistance;
    local v6 = p5 >= 5 and 4 or (p5 >= 2 and 3.5 or 3);
    BillboardGui.Size = UDim2.fromScale(v6, v6 * 1.15);
    local ImageLabel = Instance.new("ImageLabel");
    ImageLabel.Name = "Candy";
    ImageLabel.BackgroundTransparency = 1;
    ImageLabel.Image = CandyCorn.Icon;
    ImageLabel.ScaleType = Enum.ScaleType.Fit;
    ImageLabel.Size = UDim2.fromScale(1, 0.8);
    ImageLabel.Parent = BillboardGui;
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Name = "Amount";
    TextLabel.BackgroundTransparency = 1;
    TextLabel.AnchorPoint = Vector2.new(0.5, 1);
    TextLabel.Position = UDim2.fromScale(0.5, 1);
    TextLabel.Size = UDim2.fromScale(1, 0.3);
    TextLabel.FontFace = Font_new_ret;
    TextLabel.TextScaled = true;
    TextLabel.TextColor3 = Color3.fromRGB(255, 214, 120);
    TextLabel.TextStrokeTransparency = 0.2;
    TextLabel.Text = p5 <= 0 and "" or "+" .. p5;
    TextLabel.Parent = BillboardGui;

    return BillboardGui;
end;

local function show(p7) -- Line: 75
    -- upvalues: u2 (copy), u3 (ref), Folder (copy), billboard (copy), eligible (copy)
    for _, v in u2 do
        v.part:Destroy();
    end;

    table.clear(u2);
    u3 = nil;
    u3 = p7.token;

    for _, v in p7.points do
        local Part = Instance.new("Part");
        Part.Name = "Candy_" .. v.id;
        Part.Size = Vector3.new(0.1, 0.1, 0.1);
        Part.Transparency = 1;
        Part.Anchored = true;
        Part.CanCollide = false;
        Part.CanTouch = false;
        Part.CanQuery = false;
        Part.CastShadow = false;
        Part.Position = v.position;
        Part.Parent = Folder;
        local v8 = billboard(v.amount);
        v8.Adornee = Part;
        v8.Enabled = eligible();
        v8.Parent = Part;
        u2[v.id] = {
            part = Part,
            gui = v8,
            phase = v.id * 2.1
        };
    end;
end;

local function collected(p9) -- Line: 97
    -- upvalues: u3 (ref), u2 (copy), PresentationCues (copy), TweenService (copy)
    if p9.token ~= u3 then
        return;
    end;

    local u10 = u2[p9.id];

    if not u10 then
        return;
    end;

    u2[p9.id] = nil;
    PresentationCues:Fire("GemCollect", (math.min(1.4, 1.1 + (p9.amount - 1) * 0.05)));
    u10.gui.Candy.Visible = false;
    u10.gui.Amount.Text = p9.amount <= 0 and "" or "+" .. p9.amount;
    TweenService:Create(u10.gui, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        StudsOffsetWorldSpace = Vector3.new(0, 2.4, 0)
    }):Play();
    TweenService:Create(u10.gui.Amount, TweenInfo.new(0.5), {
        TextTransparency = 1,
        TextStrokeTransparency = 1
    }):Play();
    task.delay(0.55, function() -- Line: 112
        -- upvalues: u10 (copy)
        u10.part:Destroy();
    end);
end;

local function round(p11) -- Line: 117
    -- upvalues: CandyCorn (copy), Font_new_ret (copy), LocalPlayer (copy), PresentationCues (copy), TweenService (copy)
    if type(p11) ~= "table" or type(p11.amount) ~= "number" then
        return;
    end;

    local v12 = {};

    if p11.bloodMoon and game:GetService("Players").LocalPlayer:GetAttribute("BloodMoonHidden") ~= true then
        table.insert(v12, "BLOOD MOON ×2");
    end;

    if p11.safe then
        table.insert(v12, "SAFE");
    end;

    if (p11.catches or 0) > 0 then
        table.insert(v12, p11.catches .. (p11.catches == 1 and " CATCH" or " CATCHES"));
    end;

    if (p11.rescues or 0) > 0 then
        table.insert(v12, p11.rescues .. (p11.rescues == 1 and " RESCUE" or " RESCUES"));
    end;

    local ScreenGui = Instance.new("ScreenGui");
    ScreenGui.Name = "RoundCandyCorn";
    ScreenGui.ResetOnSpawn = false;
    ScreenGui.IgnoreGuiInset = true;
    ScreenGui.DisplayOrder = 35;
    local Frame = Instance.new("Frame");
    Frame.AnchorPoint = Vector2.new(0.5, 0.5);
    Frame.Position = UDim2.fromScale(0.5, 0.36);
    Frame.Size = UDim2.fromOffset(360, 74);
    Frame.BackgroundTransparency = 1;
    Frame.Parent = ScreenGui;
    local ImageLabel = Instance.new("ImageLabel");
    ImageLabel.BackgroundTransparency = 1;
    ImageLabel.Image = CandyCorn.Icon;
    ImageLabel.Size = UDim2.fromOffset(46, 46);
    ImageLabel.Position = UDim2.fromOffset(18, 2);
    ImageLabel.Parent = Frame;
    local TextLabel = Instance.new("TextLabel");
    TextLabel.BackgroundTransparency = 1;
    TextLabel.Position = UDim2.fromOffset(70, 0);
    TextLabel.Size = UDim2.new(1, -80, 0, 48);
    TextLabel.FontFace = Font_new_ret;
    TextLabel.TextScaled = true;
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel.Text = "+" .. p11.amount .. " CANDY CORN";
    TextLabel.TextColor3 = Color3.fromRGB(255, 196, 64);
    TextLabel.TextStrokeTransparency = 0;
    TextLabel.Parent = Frame;
    local TextLabel2 = Instance.new("TextLabel");
    TextLabel2.BackgroundTransparency = 1;
    TextLabel2.Position = UDim2.fromOffset(0, 50);
    TextLabel2.Size = UDim2.new(1, 0, 0, 22);
    TextLabel2.FontFace = Font_new_ret;
    TextLabel2.TextScaled = true;
    TextLabel2.Text = #v12 <= 0 and "ROUND PLAYED" or table.concat(v12, "  ·  ");
    TextLabel2.TextColor3 = Color3.new(1, 1, 1);
    TextLabel2.TextStrokeTransparency = 0;
    TextLabel2.Parent = Frame;
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui");
    PresentationCues:Fire("GemCollect", 1.2);
    local TweenInfo_new_ret = TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.In, 0, false, 1.6);
    TweenService:Create(Frame, TweenInfo.new(2.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Position = UDim2.fromScale(0.5, 0.3)
    }):Play();
    TweenService:Create(TextLabel, TweenInfo_new_ret, {
        TextTransparency = 1,
        TextStrokeTransparency = 1
    }):Play();
    TweenService:Create(TextLabel2, TweenInfo_new_ret, {
        TextTransparency = 1,
        TextStrokeTransparency = 1
    }):Play();
    TweenService:Create(ImageLabel, TweenInfo_new_ret, {
        ImageTransparency = 1
    }):Play();
    task.delay(2.4, function() -- Line: 180
        -- upvalues: ScreenGui (copy)
        ScreenGui:Destroy();
    end);
end;

local u15 = CandyCornEvent.OnClientEvent:Connect(function(p13, p14) -- Line: 184
    -- upvalues: round (copy), show (copy), u3 (ref), u2 (copy), collected (copy)
    if p13 == "Round" then
        round(p14);

        return;
    end;

    if p13 == "Layout" then
        show(p14);

        return;
    end;

    if p13 == "Clear" then
        if p14 == nil or p14 == u3 then
            for _, v in u2 do
                v.part:Destroy();
            end;

            table.clear(u2);
            u3 = nil;
        end;
    elseif p13 == "Collected" then
        collected(p14);
    end;
end);
local u17 = RunService.RenderStepped:Connect(function() -- Line: 199
    -- upvalues: u2 (copy)
    local os_clock_ret = os.clock();

    for _, v in u2 do
        local gui = v.gui;
        local v16 = math.sin(os_clock_ret * 2 + v.phase) * 0.23;
        gui.StudsOffsetWorldSpace = Vector3.new(0, v16, 0);
    end;
end);
local u18 = {};

local function refresh() -- Line: 36
    -- upvalues: eligible (copy), u2 (copy), CandyCornEvent (copy)
    local v19 = eligible();

    for _, v in u2 do
        v.gui.Enabled = v19;
    end;

    if v19 then
        CandyCornEvent:FireServer("Sync");
    end;
end;

for _, v in { "GameRole", "RunState", "InMatch" } do
    local AttributeChangedSignal = LocalPlayer:GetAttributeChangedSignal(v);
    table.insert(u18, AttributeChangedSignal:Connect(refresh));
end;

local AttributeChangedSignal = Session:GetAttributeChangedSignal("Phase");
table.insert(u18, AttributeChangedSignal:Connect(refresh));
table.insert(u18, LocalPlayer.CharacterRemoving:Connect(clear));
CandyCornEvent:FireServer("Sync");
script.Destroying:Connect(function() -- Line: 212
    -- upvalues: u15 (copy), u17 (copy), u18 (copy), u2 (copy), u3 (ref), Folder (copy)
    u15:Disconnect();
    u17:Disconnect();

    for _, v in u18 do
        v:Disconnect();
    end;

    for _, v in u2 do
        v.part:Destroy();
    end;

    table.clear(u2);
    u3 = nil;
    Folder:Destroy();
end);