 

 

local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
local Debris = game:GetService("Debris");
local ChickenOrHero = game:GetService("ReplicatedStorage"):WaitForChild("ChickenOrHero");
local Models = ChickenOrHero:WaitForChild("Weapons"):WaitForChild("Models");
local u1 = {
    EclipseFang = Color3.fromRGB(255, 170, 60),
    Soulbinder = Color3.fromRGB(90, 200, 255),
    JackInTheBox = Color3.fromRGB(255, 140, 40),
    GhostPepper = Color3.fromRGB(255, 85, 20),
    WitchfireAthame = Color3.fromRGB(120, 255, 90),
    GrinnerBlades = Color3.fromRGB(255, 70, 90),
    Hallowreapers = Color3.fromRGB(255, 120, 30),
    AlbiesCutlass = Color3.fromRGB(66, 157, 255),
    PumpkinSovereign = Color3.fromRGB(255, 176, 52),
    TheLastDoor = Color3.fromRGB(62, 56, 219),
    FallenAxes = Color3.fromRGB(220, 39, 39),
    FallenAxesBlue = Color3.fromRGB(39, 69, 220),
    DrownedCutlass = Color3.fromRGB(54, 111, 83)
};
local Color3_fromRGB_ret = Color3.fromRGB(255, 72, 96);

local function characterOf(p2) -- Line: 32
    -- upvalues: Players (copy)
    local PlayerByUserId = Players:GetPlayerByUserId(p2);

    if PlayerByUserId then
        return PlayerByUserId.Character, false;
    end;

    local ClientBots = workspace:FindFirstChild("ClientBots");

    for _, v in ClientBots and ClientBots:GetChildren() or {} do
        if v:GetAttribute("BotUserId") == p2 then
            return v, true;
        end;

        if v:GetAttribute("BotUserId") == nil then
            for _, child in v:GetChildren() do
                if child:GetAttribute("BotUserId") == p2 then
                    return child, true;
                end;
            end;
        end;
    end;

    return nil;
end;

local function particles(p3, p4, u5) -- Line: 56
    -- upvalues: Models (copy)
    local v6 = Models:FindFirstChild(p3);

    if v6 then
        v6 = v6:FindFirstChild("Blade");
    end;

    if not v6 then
        return;
    end;

    local Attachment = Instance.new("Attachment");
    Attachment.Name = "MythicKillParticles";
    local v7 = {};
    local v8 = 0;

    for _, descendant in v6:GetDescendants() do
        if descendant:IsA("ParticleEmitter") and (not v7[descendant.Texture] and v8 < 6) then
            v7[descendant.Texture] = true;
            v8 = v8 + 1;
            local v9 = descendant:Clone();
            v9.Enabled = true;
            v9.Rate = math.max(v9.Rate, 6);
            v9.Parent = Attachment;
        end;
    end;

    if v8 == 0 then
        Attachment:Destroy();

        return;
    end;

    Attachment.Parent = p4;
    task.spawn(function() -- Line: 80
        -- upvalues: Attachment (copy), u5 (copy)
        local os_clock_ret = os.clock();

        while Attachment.Parent and (u5() and os.clock() - os_clock_ret < 20) do
            task.wait(0.25);
        end;

        for _, child in Attachment:GetChildren() do
            child.Enabled = false;
        end;

        task.wait(1);
        Attachment:Destroy();
    end);
end;

local function flash(p10, p11) -- Line: 93
    -- upvalues: TweenService (copy), Debris (copy)
    local Highlight = Instance.new("Highlight");
    Highlight.Name = "MythicKillFlash";
    Highlight.FillColor = p11;
    Highlight.OutlineColor = p11;
    Highlight.FillTransparency = 0.15;
    Highlight.OutlineTransparency = 0;
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.Parent = p10;
    task.delay(0.6, function() -- Line: 102
        -- upvalues: Highlight (copy), TweenService (ref)
        if Highlight.Parent then
            TweenService:Create(Highlight, TweenInfo.new(0.5), {
                FillTransparency = 1,
                OutlineTransparency = 1
            }):Play();
        end;
    end);
    Debris:AddItem(Highlight, 1.2);
end;

local function rescued(u12) -- Line: 112
    local u13 = u12:GetAttribute("Ragdolled") == true;

    return function() -- Line: 114
        -- upvalues: u12 (copy), u13 (ref)
        local v14 = u12:GetAttribute("Ragdolled") == true;
        u13 = u13 or v14;

        return u13 and not v14 or (u12:GetAttribute("LifelineHelperId") ~= nil and true or u12:GetAttribute("LifelineDragged") == true);
    end;
end;

local BalloonLift = require(ChickenOrHero:WaitForChild("Presentation"):WaitForChild("BalloonLift"));
local PumpkinRoll = require(ChickenOrHero.Presentation:WaitForChild("PumpkinRoll"));
local BoneRattle = require(ChickenOrHero.Presentation:WaitForChild("BoneRattle"));
local SoulShock = require(ChickenOrHero.Presentation:WaitForChild("SoulShock"));
ChickenOrHero:WaitForChild("Game"):WaitForChild("MythicKillEvent").OnClientEvent:Connect(function(p15, p16) -- Line: 132
    -- upvalues: characterOf (copy), u1 (copy), Color3_fromRGB_ret (copy), ChickenOrHero (copy), Players (copy), BalloonLift (copy), PumpkinRoll (copy), BoneRattle (copy), SoulShock (copy), flash (copy), particles (copy)
    if type(p15) ~= "number" or type(p16) ~= "string" then
        return;
    end;

    local u17, u18 = characterOf(p15);
    local v19;

    if u17 then
        v19 = u17:FindFirstChild("Torso") or (u17:FindFirstChild("UpperTorso") or u17:FindFirstChild("HumanoidRootPart"));
    else
        v19 = u17;
    end;

    if not v19 then
        return;
    end;

    local v20 = u1[p16] or Color3_fromRGB_ret;

    if ChickenOrHero.Game.Session:GetAttribute("BloodMoon") == true and Players.LocalPlayer:GetAttribute("BloodMoonHidden") ~= true then
        v20 = v20:Lerp(Color3.fromRGB(255, 30, 30), 0.75);
    end;

    local u21 = u17:GetAttribute("Ragdolled") == true;

    local function u23() -- Line: 114
        -- upvalues: u17 (copy), u21 (ref)
        local v22 = u17:GetAttribute("Ragdolled") == true;
        u21 = u21 or v22;

        return u21 and not v22 or (u17:GetAttribute("LifelineHelperId") ~= nil and true or u17:GetAttribute("LifelineDragged") == true);
    end;

    if p16 == "GrinnerBlades" and BalloonLift.play(u17, v20, {
        cancel = u23
    }) then
        return;
    end;

    if p16 == "PumpkinSovereign" and PumpkinRoll.play(u17, v20, {
        cancel = u23
    }) then
        return;
    end;

    if p16 == "AlbiesCutlass" and BoneRattle.play(u17, v20, {
        cancel = u23
    }) then
        return;
    end;

    if p16 == "Soulbinder" and SoulShock.play(u17, v20, {
        cancel = u23
    }) then
        return;
    end;

    flash(u17, v20);
    local u24 = os.clock() + 6;
    particles(p16, v19, function() -- Line: 165
        -- upvalues: u23 (copy), u18 (copy), u24 (copy), u17 (copy)
        if u23() then
            return false;
        end;

        if u18 then
            local v25;

            if os.clock() < u24 then
                v25 = u17.Parent ~= nil;
            else
                v25 = false;
            end;

            return v25;
        end;

        local v26;

        if u17.Parent == nil then
            v26 = false;
        else
            v26 = u17:GetAttribute("Ragdolled") == true;
        end;

        return v26;
    end);
end);