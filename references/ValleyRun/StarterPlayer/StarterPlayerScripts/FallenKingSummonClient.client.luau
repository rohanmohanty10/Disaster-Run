 

 

local Players = game:GetService("Players");
local ChickenOrHero = game:GetService("ReplicatedStorage"):WaitForChild("ChickenOrHero");
local Presentation = ChickenOrHero:WaitForChild("Presentation");
local FallenKingBossConfig = require(ChickenOrHero:WaitForChild("Game"):WaitForChild("FallenKingBossConfig"));
local FallenKingAltar = require(Presentation:WaitForChild("FallenKingAltar"));
local LocalPlayer = Players.LocalPlayer;
local Color3_fromRGB_ret = Color3.fromRGB(120, 255, 170);
local Color3_fromRGB_ret2 = Color3.fromRGB(255, 220, 110);
local Color3_fromRGB_ret3 = Color3.fromRGB(12, 16, 18);
local Game = ChickenOrHero:WaitForChild("Game");
local FallenKingEvent = Game:WaitForChild("FallenKingEvent", 10);
local u1 = { "FallenKingAltarOpen", "FallenKingSpoilsOpen", "CutsceneActive", "PumpkinAltarActive", "GhostTraderActive" };

while not FallenKingEvent do
    warn("[FallenKingSummon] still waiting for ReplicatedStorage.ChickenOrHero.Game.FallenKingEvent");
    FallenKingEvent = Game:WaitForChild("FallenKingEvent", 30);
end;

FallenKingAltar.start(FallenKingEvent);

local function commas(p2) -- Line: 36
    local math_floor_ret = math.floor(p2);

    return tostring(math_floor_ret):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "");
end;

local function busy() -- Line: 41
    -- upvalues: LocalPlayer (copy), u1 (copy)
    if LocalPlayer:GetAttribute("InMatch") == true then
        return true;
    end;

    for _, v in u1 do
        if LocalPlayer:GetAttribute(v) == true then
            return true;
        end;
    end;

    return false;
end;

local Part = Instance.new("Part");
Part.Name = "FallenKingSummonSpot";
Part.Anchored = true;
Part.CanCollide = false;
Part.CanQuery = false;
Part.CanTouch = false;
Part.Transparency = 1;
Part.Size = Vector3.new(1, 1, 1);
Part.CFrame = CFrame.new(0, -500, 0);
local Attachment = Instance.new("Attachment");
Attachment.Name = "Middle";
Attachment.Parent = Part;
local Attachment2 = Instance.new("Attachment");
Attachment2.Name = "Top";
Attachment2.Parent = Part;
local ProximityPrompt = Instance.new("ProximityPrompt");
ProximityPrompt.Name = "SummonPrompt";
ProximityPrompt.ActionText = "Offer coins or souls";
ProximityPrompt.ObjectText = "The Fallen King";
ProximityPrompt.HoldDuration = FallenKingBossConfig.Summon.HoldSeconds;
ProximityPrompt.MaxActivationDistance = FallenKingBossConfig.Summon.PromptDistance;
ProximityPrompt.RequiresLineOfSight = false;
ProximityPrompt.KeyboardKeyCode = Enum.KeyCode.E;
ProximityPrompt.GamepadKeyCode = Enum.KeyCode.ButtonY;
ProximityPrompt.Enabled = false;
ProximityPrompt.Parent = Attachment;
local ParticleEmitter = Instance.new("ParticleEmitter");
ParticleEmitter.Name = "Souls";
ParticleEmitter.Texture = "rbxasset://textures/particles/sparkles_main.dds";
ParticleEmitter.Color = ColorSequence.new(Color3_fromRGB_ret, Color3.fromRGB(215, 255, 228));
ParticleEmitter.LightEmission = 1;
ParticleEmitter.LightInfluence = 0;
ParticleEmitter.Lifetime = NumberRange.new(0.8, 1.5);
ParticleEmitter.Speed = NumberRange.new(4, 9);
ParticleEmitter.SpreadAngle = Vector2.new(60, 60);
ParticleEmitter.Acceleration = Vector3.new(0, 4, 0);
ParticleEmitter.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.4), NumberSequenceKeypoint.new(1, 0) });
ParticleEmitter.Rate = 0;
ParticleEmitter.Parent = Attachment;
local BillboardGui = Instance.new("BillboardGui");
BillboardGui.Name = "FallenKingMeterSign";
BillboardGui.Size = UDim2.fromScale(12, 3.4);
BillboardGui.MaxDistance = 75;
BillboardGui.LightInfluence = 0;
BillboardGui.AlwaysOnTop = false;
BillboardGui.ResetOnSpawn = false;
BillboardGui.Enabled = false;
BillboardGui.Adornee = Attachment2;

local function text(p3, p4) -- Line: 107
    -- upvalues: BillboardGui (copy)
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Name = p3;
    TextLabel.BackgroundTransparency = 1;
    TextLabel.TextScaled = true;
    TextLabel.AnchorPoint = Vector2.new(0.5, 0.5);

    for i, v in p4 do
        TextLabel[i] = v;
    end;

    local UIStroke = Instance.new("UIStroke");
    UIStroke.Color = Color3.new(0, 0, 0);
    UIStroke.Thickness = 2.5;
    UIStroke.Parent = TextLabel;
    TextLabel.Parent = BillboardGui;

    return TextLabel;
end;

local u5 = text("Title", {
    Text = "SUMMON THE FALLEN KING",
    Position = UDim2.fromScale(0.5, 0.2),
    Size = UDim2.fromScale(1, 0.4),
    FontFace = Font.fromEnum(Enum.Font.Creepster),
    TextColor3 = Color3_fromRGB_ret
});
local Frame = Instance.new("Frame");
Frame.Name = "Meter";
Frame.AnchorPoint = Vector2.new(0.5, 0.5);
Frame.Position = UDim2.fromScale(0.5, 0.68);
Frame.Size = UDim2.fromScale(0.86, 0.4);
Frame.BackgroundColor3 = Color3_fromRGB_ret3;
Frame.BackgroundTransparency = 0.15;
Frame.BorderSizePixel = 0;
Frame.Parent = BillboardGui;
Instance.new("UICorner", Frame).CornerRadius = UDim.new(0.5, 0);
local UIStroke = Instance.new("UIStroke");
UIStroke.Color = Color3_fromRGB_ret2;
UIStroke.Thickness = 2;
UIStroke.Parent = Frame;
local Frame2 = Instance.new("Frame");
Frame2.Name = "Fill";
Frame2.Size = UDim2.fromScale(0, 1);
Frame2.BackgroundColor3 = Color3_fromRGB_ret;
Frame2.BorderSizePixel = 0;
Frame2.Parent = Frame;
Instance.new("UICorner", Frame2).CornerRadius = UDim.new(0.5, 0);
local u6 = text("Amount", {
    ZIndex = 3,
    Position = UDim2.fromScale(0.5, 0.68),
    Size = UDim2.fromScale(0.8, 0.28),
    FontFace = Font.fromEnum(Enum.Font.GothamBlack),
    TextColor3 = Color3.new(1, 1, 1)
});
BillboardGui.Parent = Attachment2;
local u7 = nil;
local u8 = 0;

local function refresh() -- Line: 163
    -- upvalues: FallenKingAltar (copy), u7 (ref), u8 (ref), Part (copy), Attachment2 (copy), busy (copy), ProximityPrompt (copy), BillboardGui (copy), FallenKingEvent (ref), u5 (copy), Color3_fromRGB_ret (copy), Frame2 (copy), u6 (copy), Color3_fromRGB_ret2 (copy)
    local v9 = FallenKingAltar.stone();
    local v10 = FallenKingAltar.state();

    if v9 ~= u7 or v9 and os.clock() - u8 > 3 then
        u7 = v9;
        u8 = os.clock();

        if v9 then
            local BoundingBox, v11 = v9:GetBoundingBox();
            Part.CFrame = CFrame.new(BoundingBox.Position);
            Attachment2.Position = Vector3.new(0, v11.Y / 2 + 2.2, 0);
            Part.Parent = workspace;
        else
            Part.Parent = nil;
        end;
    end;

    local v12;

    if v9 == nil then
        v12 = false;
    else
        v12 = not busy();
    end;

    local v13;

    if v12 then
        v13 = v10 == "Filling" and true or v10 == "Unavailable";
    else
        v13 = v12;
    end;

    ProximityPrompt.Enabled = v13;

    if v12 then
        v12 = (v10 == "Filling" or (v10 == "Countdown" or v10 == "Summoning")) and true or v10 == "Resting";
    end;

    BillboardGui.Enabled = v12;

    if not v12 then
        return;
    end;

    local v14 = tonumber(FallenKingEvent:GetAttribute("SummonPot")) or 0;
    local v15 = tonumber(FallenKingEvent:GetAttribute("SummonTarget")) or 0;

    if v10 == "Resting" then
        local v16 = (tonumber(FallenKingEvent:GetAttribute("SummonRestUntil")) or 0) - workspace:GetServerTimeNow();
        local math_ceil_ret = math.ceil(v16);
        local math_max_ret = math.max(0, math_ceil_ret);
        u5.Text = "THE KING RESTS";
        u5.TextColor3 = Color3_fromRGB_ret;
        Frame2.BackgroundColor3 = Color3_fromRGB_ret;
        Frame2.Size = UDim2.fromScale(0, 1);
        u6.Text = ("RESET IN %d:%02d"):format(math_max_ret // 60, math_max_ret % 60);

        return;
    end;

    if v10 ~= "Filling" then
        local v17 = (tonumber(FallenKingEvent:GetAttribute("SummonEndsAt")) or 0) - workspace:GetServerTimeNow();
        local math_ceil_ret = math.ceil(v17);
        local math_max_ret = math.max(0, math_ceil_ret);
        u5.Text = "THE KING RISES";
        u5.TextColor3 = Color3_fromRGB_ret2;
        Frame2.BackgroundColor3 = Color3_fromRGB_ret2;
        Frame2.Size = UDim2.fromScale(1, 1);
        u6.Text = (v10 ~= "Countdown" or math_max_ret <= 0) and "SOON" or ("IN %d:%02d"):format(math_max_ret // 60, math_max_ret % 60);

        return;
    end;

    u5.Text = "SUMMON THE FALLEN KING";
    u5.TextColor3 = Color3_fromRGB_ret;
    Frame2.BackgroundColor3 = Color3_fromRGB_ret;
    Frame2.Size = UDim2.fromScale(v15 <= 0 and 0 or math.clamp(v14 / v15, 0, 1), 1);
    local math_floor_ret = math.floor(v14);
    local v18 = tostring(math_floor_ret):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "");
    local math_floor_ret2 = math.floor(v15);
    u6.Text = ("%s / %s"):format(v18, (tostring(math_floor_ret2):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")));
end;

ProximityPrompt.Triggered:Connect(function(p19) -- Line: 214
    -- upvalues: LocalPlayer (copy), FallenKingAltar (copy)
    if p19 ~= LocalPlayer then
        return;
    end;

    local v20 = FallenKingAltar.state();

    if v20 == "Unavailable" or v20 == "Closed" then
        FallenKingAltar.notice(FallenKingAltar.UNAVAILABLE);

        return;
    end;

    FallenKingAltar.open();
end);
FallenKingEvent.AttributeChanged:Connect(refresh);

for _, v in { "InMatch", table.unpack(u1) } do
    LocalPlayer:GetAttributeChangedSignal(v):Connect(refresh);
end;

FallenKingEvent.OnClientEvent:Connect(function(p21, p22) -- Line: 229
    -- upvalues: Part (copy), ParticleEmitter (copy)
    if p21 == "Summon" and (type(p22) == "table" and (p22.kind == "Burst" and Part.Parent)) then
        local v23 = (tonumber(p22.amount) or 0) / 500;
        local v24 = math.floor(v23) + 10;
        ParticleEmitter:Emit((math.clamp(v24, 10, 40)));
    end;
end);

while true do
    local success, result = pcall(refresh);

    if not success then
        warn("[FallenKingSummon] " .. tostring(result));
    end;

    task.wait(0.25);
end;