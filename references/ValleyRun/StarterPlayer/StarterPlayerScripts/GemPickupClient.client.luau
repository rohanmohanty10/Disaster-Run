 

 

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local LocalPlayer = Players.LocalPlayer;
local ChickenOrHero = game.ReplicatedStorage:WaitForChild("ChickenOrHero");
local Collectibles = ChickenOrHero:WaitForChild("Collectibles");
local GemEvent = Collectibles:WaitForChild("GemEvent");
local GemConfig = require(Collectibles:WaitForChild("GemConfig"));
local GemBillboard = Collectibles:WaitForChild("GemBillboard");
local PresentationCues = ChickenOrHero:WaitForChild("Audio"):WaitForChild("PresentationCues");
local Session = ChickenOrHero:WaitForChild("Game"):WaitForChild("Session");
local u1 = {
    GroupRun = true,
    HeroRun = true,
    FinalRun = true
};
local Folder = Instance.new("Folder");
Folder.Name = "LocalRunnerGems";
Folder.Parent = workspace;
local u2 = {};
local u3 = nil;

local function eligible() -- Line: 16
    -- upvalues: LocalPlayer (copy), u1 (copy), Session (copy)
    local v4;

    if LocalPlayer:GetAttribute("GameRole") == "Runner" and (LocalPlayer:GetAttribute("RunState") == "Active" and LocalPlayer:GetAttribute("InMatch") == true) then
        v4 = u1[Session:GetAttribute("Phase")] == true;
    else
        v4 = false;
    end;

    return v4;
end;

local function clear() -- Line: 20
    -- upvalues: u2 (copy), u3 (ref)
    for _, v in u2 do
        v.part:Destroy();
    end;

    table.clear(u2);
    u3 = nil;
end;

local function show(p5) -- Line: 29
    -- upvalues: u2 (copy), u3 (ref), Folder (copy), GemBillboard (copy), GemConfig (copy), eligible (copy)
    for _, v in u2 do
        v.part:Destroy();
    end;

    table.clear(u2);
    u3 = nil;
    u3 = p5.token;

    for _, v in p5.points do
        local Part = Instance.new("Part");
        Part.Name = "Gem_" .. v.id;
        Part.Size = Vector3.new(0.1, 0.1, 0.1);
        Part.Transparency = 1;
        Part.Anchored = true;
        Part.CanCollide = false;
        Part.CanTouch = false;
        Part.CanQuery = false;
        Part.CastShadow = false;
        Part.Position = v.position;
        Part.Parent = Folder;
        local v6 = GemBillboard:Clone();
        v6.Adornee = Part;
        v6.MaxDistance = GemConfig.MaxVisibleDistance;
        v6.Enabled = eligible();
        v6.Parent = Part;
        v6.Amount.Text = v.amount > 0 and ("+" .. v.amount or "") or "";
        v6.StackLeft.Visible = v.amount >= 3;
        v6.StackRight.Visible = v.amount >= 6;
        local v7 = v.amount >= 6 and 4.2 or (v.amount >= 3 and 3.8 or 3.25);
        v6.Size = UDim2.fromScale(v7, v7 * 1.15);
        u2[v.id] = {
            part = Part,
            gui = v6,
            phase = v.id * 2.1
        };
    end;
end;

local function collected(p8) -- Line: 44
    -- upvalues: u3 (ref), u2 (copy), PresentationCues (copy), TweenService (copy)
    if p8.token ~= u3 then
        return;
    end;

    local u9 = u2[p8.id];

    if not u9 then
        return;
    end;

    u2[p8.id] = nil;
    PresentationCues:Fire("GemCollect", (math.min(1.3, 1 + (p8.amount - 1) * 0.04)));
    u9.gui.Gem.Visible = false;
    u9.gui.StackLeft.Visible = false;
    u9.gui.StackRight.Visible = false;
    u9.gui.Amount.Text = p8.amount > 0 and "+" .. p8.amount or "";
    u9.gui.Amount.TextColor3 = Color3.fromRGB(215, 255, 236);
    TweenService:Create(u9.gui, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        StudsOffsetWorldSpace = Vector3.new(0, 2.4, 0)
    }):Play();
    TweenService:Create(u9.gui.Amount, TweenInfo.new(0.5), {
        TextTransparency = 1,
        TextStrokeTransparency = 1
    }):Play();
    task.delay(0.55, function() -- Line: 54
        -- upvalues: u9 (copy)
        u9.part:Destroy();
    end);
end;

local u12 = GemEvent.OnClientEvent:Connect(function(p10, p11) -- Line: 56
    -- upvalues: show (copy), u3 (ref), u2 (copy), collected (copy)
    if p10 == "Layout" then
        show(p11);

        return;
    end;

    if p10 == "Clear" then
        if p11 == nil or p11 == u3 then
            for _, v in u2 do
                v.part:Destroy();
            end;

            table.clear(u2);
            u3 = nil;
        end;
    elseif p10 == "Collected" then
        collected(p11);
    end;
end);
local u14 = RunService.RenderStepped:Connect(function() -- Line: 61
    -- upvalues: u2 (copy)
    local os_clock_ret = os.clock();

    for _, v in u2 do
        local gui = v.gui;
        local v13 = math.sin(os_clock_ret * 2 + v.phase) * 0.23;
        gui.StudsOffsetWorldSpace = Vector3.new(0, v13, 0);
    end;
end);
local u15 = {};

local function refresh() -- Line: 24
    -- upvalues: eligible (copy), u2 (copy), GemEvent (copy)
    local v16 = eligible();

    for _, v in u2 do
        v.gui.Enabled = v16;
    end;

    if v16 then
        GemEvent:FireServer("Sync");
    end;
end;

for _, v in { "GameRole", "RunState", "InMatch" } do
    local AttributeChangedSignal = LocalPlayer:GetAttributeChangedSignal(v);
    table.insert(u15, AttributeChangedSignal:Connect(refresh));
end;

local AttributeChangedSignal = Session:GetAttributeChangedSignal("Phase");
table.insert(u15, AttributeChangedSignal:Connect(refresh));
table.insert(u15, LocalPlayer.CharacterRemoving:Connect(clear));
GemEvent:FireServer("Sync");
script.Destroying:Connect(function() -- Line: 72
    -- upvalues: u12 (copy), u14 (copy), u15 (copy), u2 (copy), u3 (ref), Folder (copy)
    u12:Disconnect();
    u14:Disconnect();

    for _, v in u15 do
        v:Disconnect();
    end;

    for _, v in u2 do
        v.part:Destroy();
    end;

    table.clear(u2);
    u3 = nil;
    Folder:Destroy();
end);