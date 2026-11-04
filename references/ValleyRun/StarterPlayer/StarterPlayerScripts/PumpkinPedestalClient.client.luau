 

 

local Players = game:GetService("Players");
local CollectionService = game:GetService("CollectionService");
local TweenService = game:GetService("TweenService");
local ChickenOrHero = game.ReplicatedStorage:WaitForChild("ChickenOrHero");
local PumpkinHuntConfig = require(ChickenOrHero:WaitForChild("Game"):WaitForChild("PumpkinHuntConfig"));
local HudNavigation = require(ChickenOrHero:WaitForChild("Presentation"):WaitForChild("HudNavigation"));
local SacrificeScreen = require(ChickenOrHero:WaitForChild("Presentation"):WaitForChild("SacrificeScreen"));
local PumpkinScreen = require(ChickenOrHero:WaitForChild("Presentation"):WaitForChild("PumpkinScreen"));
local LocalPlayer = Players.LocalPlayer;
local Color3_fromRGB_ret = Color3.fromRGB(176, 98, 255);
local Color3_fromRGB_ret2 = Color3.fromRGB(255, 132, 28);
local Color3_fromRGB_ret3 = Color3.fromRGB(255, 184, 72);
local Color3_fromRGB_ret4 = Color3.fromRGB(255, 220, 110);
local u1 = nil;
local u2 = {};

local function live() -- Line: 30
    -- upvalues: u1 (ref)
    local v3;

    if u1 == nil then
        v3 = false;
    else
        v3 = u1:GetAttribute("Live") == true;
    end;

    return v3;
end;

local function fireLook() -- Line: 35
    -- upvalues: u1 (ref), PumpkinHuntConfig (copy), Color3_fromRGB_ret (copy), Color3_fromRGB_ret2 (copy), Color3_fromRGB_ret3 (copy), Color3_fromRGB_ret4 (copy)
    local v4 = u1 and u1:GetAttribute("Pot") or 0;
    local v5 = u1 and u1:GetAttribute("Goal") or PumpkinHuntConfig.Pot.Goal;
    local v6 = u1 and u1:GetAttribute("Max") or PumpkinHuntConfig.Pot.Max;
    local v7 = u1 and u1:GetAttribute("Phase") or "Filling";
    local v8;

    if u1 == nil then
        v8 = false;
    else
        v8 = u1:GetAttribute("Live") == true;
    end;

    if not v8 or v7 == "Cooldown" then
        return 0.15, Color3_fromRGB_ret, Color3_fromRGB_ret;
    end;

    if v4 < v5 then
        local v9 = v4 / math.max(1, v5);

        return 0.25 + 0.35 * v9, Color3_fromRGB_ret, Color3_fromRGB_ret:Lerp(Color3_fromRGB_ret2, v9);
    end;

    local v10 = (v4 - v5) / math.max(1, v6 - v5);

    return 0.6 + 0.4 * v10, Color3_fromRGB_ret2, Color3_fromRGB_ret3:Lerp(Color3_fromRGB_ret4, v10);
end;

local function dress(p11) -- Line: 51
    -- upvalues: fireLook (copy)
    local v12, v13, v14 = fireLook();
    local fire = p11.fire;
    local embers = p11.embers;
    local light = p11.light;
    fire.Color = ColorSequence.new(v14, v13);
    fire.Rate = 6 + 34 * v12;
    fire.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.6 + 1.6 * v12), NumberSequenceKeypoint.new(1, 0.1) });
    fire.Speed = NumberRange.new(2 + 4 * v12, 3 + 6 * v12);
    embers.Color = ColorSequence.new(v14);
    embers.Rate = 2 + 10 * v12;
    light.Color = v14;
    p11.brightness = 0.3 + 0.5 * v12;

    if not p11.flash then
        light.Brightness = p11.brightness;
    end;

    light.Range = 6 + 4 * v12;
end;

local function promptShown(p15) -- Line: 72
    -- upvalues: LocalPlayer (copy)
    local prompt = p15.prompt;
    local v16;

    if LocalPlayer:GetAttribute("PumpkinSacrificeOpen") == true or LocalPlayer:GetAttribute("InMatch") == true then
        v16 = false;
    else
        v16 = LocalPlayer:GetAttribute("PumpkinsOpen") ~= true;
    end;

    prompt.Enabled = v16;
end;

local Vector2_new_ret = Vector2.new(0, -80);

local function pumpkinsPrompt(p17) -- Line: 81
    -- upvalues: PumpkinHuntConfig (copy), Vector2_new_ret (copy)
    local ProximityPrompt = Instance.new("ProximityPrompt");
    ProximityPrompt.Name = "PumpkinsPrompt";
    ProximityPrompt.HoldDuration = 0;
    ProximityPrompt.MaxActivationDistance = PumpkinHuntConfig.PromptDistance;
    ProximityPrompt.RequiresLineOfSight = false;
    ProximityPrompt.KeyboardKeyCode = Enum.KeyCode.F;
    ProximityPrompt.GamepadKeyCode = Enum.KeyCode.ButtonY;
    ProximityPrompt.UIOffset = Vector2_new_ret;
    ProximityPrompt.Enabled = false;
    ProximityPrompt.Parent = p17;

    return ProximityPrompt;
end;

local function pumpkinsLive() -- Line: 94
    -- upvalues: ChickenOrHero (copy)
    local PumpkinEvent = ChickenOrHero.Game:FindFirstChild("PumpkinEvent");
    local v18;

    if PumpkinEvent == nil then
        v18 = false;
    else
        v18 = PumpkinEvent:GetAttribute("Live") == true;
    end;

    return v18;
end;

local function pumpkinsShown(p19) -- Line: 100
    -- upvalues: PumpkinScreen (copy), LocalPlayer (copy)
    local pumpkins = p19.pumpkins;
    local v20 = PumpkinScreen.count or 0;

    if v20 > 0 then
        pumpkins.ObjectText = v20 == 1 and "1 Pumpkin" or v20 .. " Pumpkins";
        pumpkins.ActionText = "Open";
    end;

    local v21;

    if v20 > 0 and (LocalPlayer:GetAttribute("InMatch") ~= true and (LocalPlayer:GetAttribute("PumpkinsOpen") ~= true and LocalPlayer:GetAttribute("PumpkinSacrificeOpen") ~= true)) then
        v21 = LocalPlayer:GetAttribute("PumpkinAltarActive") ~= true;
    else
        v21 = false;
    end;

    pumpkins.Enabled = v21;
end;

local function sign(p22) -- Line: 118
    -- upvalues: PumpkinHuntConfig (copy), Color3_fromRGB_ret2 (copy)
    local BillboardGui = Instance.new("BillboardGui");
    BillboardGui.Name = "PumpkinHuntSign";
    BillboardGui.Adornee = p22;
    BillboardGui.Size = UDim2.fromScale(9, 2.2);
    BillboardGui.StudsOffsetWorldSpace = Vector3.new(0, p22.Size.Y / 2 + 1.7, 0);
    BillboardGui.MaxDistance = 75;
    BillboardGui.LightInfluence = 0;
    BillboardGui.AlwaysOnTop = false;
    BillboardGui.ResetOnSpawn = false;
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Name = "Title";
    TextLabel.BackgroundTransparency = 1;
    TextLabel.Size = UDim2.fromScale(1, 1);
    TextLabel.FontFace = Font.fromEnum(Enum.Font.Creepster);
    TextLabel.Text = string.upper(PumpkinHuntConfig.EventName);
    TextLabel.TextScaled = true;
    TextLabel.TextColor3 = Color3_fromRGB_ret2;
    TextLabel.Parent = BillboardGui;
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Color = Color3.fromRGB(40, 8, 30);
    UIStroke.Thickness = 3;
    UIStroke.Parent = TextLabel;
    BillboardGui.Parent = p22;

    return BillboardGui;
end;

local function signShown(p23) -- Line: 144
    -- upvalues: u1 (ref), LocalPlayer (copy)
    local sign2 = p23.sign;
    local v24;

    if u1 == nil then
        v24 = false;
    else
        v24 = u1:GetAttribute("Live") == true;
    end;

    if v24 then
        if LocalPlayer:GetAttribute("InMatch") == true or LocalPlayer:GetAttribute("PumpkinSacrificeOpen") == true then
            v24 = false;
        else
            v24 = LocalPlayer:GetAttribute("PumpkinAltarActive") ~= true;
        end;
    end;

    sign2.Enabled = v24;
end;

local function setup(u25) -- Line: 151
    -- upvalues: u2 (copy), PumpkinHuntConfig (copy), Vector2_new_ret (copy), sign (copy), dress (copy), LocalPlayer (copy), pumpkinsShown (copy), u1 (ref), SacrificeScreen (copy), HudNavigation (copy), ChickenOrHero (copy), PumpkinScreen (copy)
    if u2[u25] or not u25:IsDescendantOf(workspace) then
        return;
    end;

    local Bowl = u25:FindFirstChild("Bowl", true);

    if not (Bowl and Bowl:IsA("BasePart")) then
        Bowl = u25:FindFirstChildWhichIsA("BasePart", true);
    end;

    if not Bowl then
        return;
    end;

    local v26 = {
        connections = {}
    };
    u2[u25] = v26;

    local function promptOf() -- Line: 165
        -- upvalues: u25 (copy)
        local SacrificePrompt = u25:FindFirstChild("SacrificePrompt", true);

        if SacrificePrompt and SacrificePrompt:IsA("ProximityPrompt") then
            return SacrificePrompt;
        end;

        return nil;
    end;

    local SacrificePrompt = u25:FindFirstChild("SacrificePrompt", true);

    if not (SacrificePrompt and SacrificePrompt:IsA("ProximityPrompt")) then
        SacrificePrompt = nil;
    end;

    local v27 = 0;
    local v28 = false;

    while not SacrificePrompt and u2[u25] == v26 do
        task.wait(0.25);
        v27 = v27 + 0.25;

        if v27 >= 30 and not v28 then
            warn("PumpkinPedestalClient: no SacrificePrompt on " .. u25:GetFullName() .. " after 30 s; waiting for it");
            v28 = true;
        end;

        SacrificePrompt = u25:FindFirstChild("SacrificePrompt", true);

        if not (SacrificePrompt and SacrificePrompt:IsA("ProximityPrompt")) then
            SacrificePrompt = nil;
        end;
    end;

    if u2[u25] ~= v26 then
        return;
    end;

    v26.bowl = Bowl;
    v26.prompt = SacrificePrompt;
    local Parent = SacrificePrompt.Parent;
    local ProximityPrompt = Instance.new("ProximityPrompt");
    ProximityPrompt.Name = "PumpkinsPrompt";
    ProximityPrompt.HoldDuration = 0;
    ProximityPrompt.MaxActivationDistance = PumpkinHuntConfig.PromptDistance;
    ProximityPrompt.RequiresLineOfSight = false;
    ProximityPrompt.KeyboardKeyCode = Enum.KeyCode.F;
    ProximityPrompt.GamepadKeyCode = Enum.KeyCode.ButtonY;
    ProximityPrompt.UIOffset = Vector2_new_ret;
    ProximityPrompt.Enabled = false;
    ProximityPrompt.Parent = Parent;
    v26.pumpkins = ProximityPrompt;
    local Attachment = Instance.new("Attachment");
    Attachment.Name = "PumpkinFire";
    Attachment.Position = Vector3.new(0, Bowl.Size.Y / 2, 0);
    Attachment.Parent = Bowl;
    v26.attachment = Attachment;
    local ParticleEmitter = Instance.new("ParticleEmitter");
    ParticleEmitter.Name = "Fire";
    ParticleEmitter.Texture = "rbxasset://textures/particles/fire_main.dds";
    ParticleEmitter.LightEmission = 0.8;
    ParticleEmitter.LightInfluence = 0;
    ParticleEmitter.Lifetime = NumberRange.new(0.5, 0.9);
    ParticleEmitter.SpreadAngle = Vector2.new(12, 12);
    ParticleEmitter.Rotation = NumberRange.new(-30, 30);
    ParticleEmitter.RotSpeed = NumberRange.new(-40, 40);
    ParticleEmitter.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.3), NumberSequenceKeypoint.new(1, 1) });
    ParticleEmitter.Parent = Attachment;
    local ParticleEmitter2 = Instance.new("ParticleEmitter");
    ParticleEmitter2.Name = "Embers";
    ParticleEmitter2.Texture = "rbxasset://textures/particles/sparkles_main.dds";
    ParticleEmitter2.LightEmission = 1;
    ParticleEmitter2.LightInfluence = 0;
    ParticleEmitter2.Lifetime = NumberRange.new(1, 1.8);
    ParticleEmitter2.Speed = NumberRange.new(3, 7);
    ParticleEmitter2.SpreadAngle = Vector2.new(30, 30);
    ParticleEmitter2.Acceleration = Vector3.new(0, 2, 0);
    ParticleEmitter2.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.25), NumberSequenceKeypoint.new(1, 0) });
    ParticleEmitter2.Parent = Attachment;
    local Attachment2 = Instance.new("Attachment");
    Attachment2.Name = "PumpkinLight";
    Attachment2.Position = Vector3.new(0, Bowl.Size.Y / 2 + 2.5, 0);
    Attachment2.Parent = Bowl;
    v26.lamp = Attachment2;
    local PointLight = Instance.new("PointLight");
    PointLight.Name = "Glow";
    PointLight.Shadows = false;
    PointLight.Parent = Attachment2;
    v26.fire = ParticleEmitter;
    v26.embers = ParticleEmitter2;
    v26.light = PointLight;
    v26.sign = sign(Bowl);
    dress(v26);
    local prompt = v26.prompt;
    local v29;

    if LocalPlayer:GetAttribute("PumpkinSacrificeOpen") == true or LocalPlayer:GetAttribute("InMatch") == true then
        v29 = false;
    else
        v29 = LocalPlayer:GetAttribute("PumpkinsOpen") ~= true;
    end;

    prompt.Enabled = v29;
    pumpkinsShown(v26);
    local sign2 = v26.sign;
    local v30;

    if u1 == nil then
        v30 = false;
    else
        v30 = u1:GetAttribute("Live") == true;
    end;

    if v30 then
        if LocalPlayer:GetAttribute("InMatch") == true or LocalPlayer:GetAttribute("PumpkinSacrificeOpen") == true then
            v30 = false;
        else
            v30 = LocalPlayer:GetAttribute("PumpkinAltarActive") ~= true;
        end;
    end;

    sign2.Enabled = v30;
    table.insert(v26.connections, SacrificePrompt.Triggered:Connect(function(p31) -- Line: 235
        -- upvalues: LocalPlayer (ref), u1 (ref), SacrificeScreen (ref), HudNavigation (ref)
        if p31 ~= LocalPlayer then
            return;
        end;

        local v32;

        if u1 == nil then
            v32 = false;
        else
            v32 = u1:GetAttribute("Live") == true;
        end;

        if v32 then
            HudNavigation.activate("PumpkinSacrifice");

            return;
        end;

        SacrificeScreen.notice(SacrificeScreen.UNAVAILABLE);
    end));
    table.insert(v26.connections, v26.pumpkins.Triggered:Connect(function() -- Line: 245
        -- upvalues: ChickenOrHero (ref), PumpkinScreen (ref), HudNavigation (ref)
        local PumpkinEvent = ChickenOrHero.Game:FindFirstChild("PumpkinEvent");
        local v33;

        if PumpkinEvent == nil then
            v33 = false;
        else
            v33 = PumpkinEvent:GetAttribute("Live") == true;
        end;

        if not v33 then
            PumpkinScreen.notice(PumpkinScreen.UNAVAILABLE);

            return;
        end;

        if (PumpkinScreen.count or 0) <= 0 then
            return;
        end;

        HudNavigation.activate("Pumpkins");
    end));
end;

local function flash(u34) -- Line: 282
    -- upvalues: TweenService (copy)
    local light = u34.light;

    if u34.flash then
        u34.flash:Cancel();
    end;

    local u35 = u34.brightness or light.Brightness;
    light.Brightness = u35 + 1.2;
    local u36 = TweenService:Create(light, TweenInfo.new(0.5), {
        Brightness = u35
    });
    u34.flash = u36;
    u36.Completed:Connect(function() -- Line: 291
        -- upvalues: u34 (copy), u36 (copy), light (copy), u35 (copy)
        if u34.flash == u36 then
            u34.flash = nil;
            light.Brightness = u34.brightness or u35;
        end;
    end);
    u36:Play();
end;

local function refreshAll() -- Line: 308
    -- upvalues: u2 (copy), dress (copy), LocalPlayer (copy), pumpkinsShown (copy), u1 (ref)
    for _, v in u2 do
        if v.fire then
            dress(v);
        end;

        if v.prompt then
            local prompt = v.prompt;
            local v37;

            if LocalPlayer:GetAttribute("PumpkinSacrificeOpen") == true or LocalPlayer:GetAttribute("InMatch") == true then
                v37 = false;
            else
                v37 = LocalPlayer:GetAttribute("PumpkinsOpen") ~= true;
            end;

            prompt.Enabled = v37;
        end;

        if v.pumpkins then
            pumpkinsShown(v);
        end;

        if v.sign then
            local sign2 = v.sign;
            local v38;

            if u1 == nil then
                v38 = false;
            else
                v38 = u1:GetAttribute("Live") == true;
            end;

            if v38 then
                if LocalPlayer:GetAttribute("InMatch") == true or LocalPlayer:GetAttribute("PumpkinSacrificeOpen") == true then
                    v38 = false;
                else
                    v38 = LocalPlayer:GetAttribute("PumpkinAltarActive") ~= true;
                end;
            end;

            sign2.Enabled = v38;
        end;
    end;
end;

LocalPlayer:GetAttributeChangedSignal("PumpkinSacrificeOpen"):Connect(refreshAll);
LocalPlayer:GetAttributeChangedSignal("InMatch"):Connect(refreshAll);
LocalPlayer:GetAttributeChangedSignal("PumpkinAltarActive"):Connect(refreshAll);
LocalPlayer:GetAttributeChangedSignal("PumpkinsOpen"):Connect(refreshAll);
PumpkinScreen.counted.Event:Connect(refreshAll);
CollectionService:GetInstanceAddedSignal(PumpkinHuntConfig.Tag):Connect(function(p39) -- Line: 330
    -- upvalues: setup (copy)
    task.spawn(setup, p39);
end);
CollectionService:GetInstanceRemovedSignal(PumpkinHuntConfig.Tag):Connect(function(p40) -- Line: 257, Name: teardown
    -- upvalues: u2 (copy)
    local v41 = u2[p40];

    if not v41 then
        return;
    end;

    u2[p40] = nil;

    for _, v in v41.connections do
        v:Disconnect();
    end;

    if v41.lamp then
        v41.lamp:Destroy();
    end;

    if v41.pumpkins then
        v41.pumpkins:Destroy();
    end;

    if v41.sign then
        v41.sign:Destroy();
    end;

    if v41.attachment then
        v41.attachment:Destroy();
    end;
end);

local function burst(p42) -- Line: 299
    -- upvalues: u2 (copy), PumpkinHuntConfig (copy), flash (copy)
    for _, v in u2 do
        if v.embers then
            local embers = v.embers;
            local v43 = p42 / math.max(1, PumpkinHuntConfig.Pot.Amounts[1]) * 2;
            local v44 = math.floor(v43) + 8;
            embers:Emit((math.clamp(v44, 8, 40)));
            flash(v);
        end;
    end;
end;

for _, v in CollectionService:GetTagged(PumpkinHuntConfig.Tag) do
    task.spawn(setup, v);
end;

local PumpkinHuntEvent = ChickenOrHero:WaitForChild("Game"):WaitForChild("PumpkinHuntEvent", 60);

if not PumpkinHuntEvent then
    warn("PumpkinPedestalClient: Game.PumpkinHuntEvent never arrived after 60 s; waiting for it");
    PumpkinHuntEvent = ChickenOrHero:WaitForChild("Game"):WaitForChild("PumpkinHuntEvent");
end;

u1 = PumpkinHuntEvent;
u1.AttributeChanged:Connect(refreshAll);
SacrificeScreen.sacrificed.Event:Connect(burst);
u1.OnClientEvent:Connect(function(p45, p46, p47) -- Line: 348
    -- upvalues: LocalPlayer (copy), burst (copy)
    if p45 == "Burst" and p46 ~= LocalPlayer.UserId then
        burst(tonumber(p47) or 0);
    end;
end);
refreshAll();