 

 

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local u1 = {};
local Color3_fromRGB_ret = Color3.fromRGB(110, 205, 255);
local OneHitShield = game:GetService("ReplicatedStorage"):WaitForChild("ChickenOrHero"):WaitForChild("Gear"):WaitForChild("Assets"):WaitForChild("OneHitShield");
local KnifeChains = require(game:GetService("ReplicatedStorage"):WaitForChild("ChickenOrHero"):WaitForChild("Weapons"):WaitForChild("KnifeChains"));
local LocalLooks = require(game:GetService("ReplicatedStorage"):WaitForChild("ChickenOrHero"):WaitForChild("Presentation"):WaitForChild("LocalLooks"));
local PumpkinSmoke = require(game:GetService("ReplicatedStorage"):WaitForChild("ChickenOrHero"):WaitForChild("Gear"):WaitForChild("PumpkinSmoke"));

local function cloakAlpha(p2) -- Line: 23
    -- upvalues: Players (copy)
    local Character = Players.LocalPlayer.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    local v3;

    if Character then
        v3 = Character.Position;
    else
        v3 = workspace.CurrentCamera.CFrame.Position;
    end;

    return math.clamp(((p2.Position - v3).Magnitude - 0.5) / 19.5, 0, 1);
end;

local Folder = Instance.new("Folder");
Folder.Name = "LocalShieldBubbles";
Folder.Parent = workspace;

local function dropShield(p4) -- Line: 34
    if p4.shield then
        p4.shield:Destroy();
        p4.shield = nil;
        p4.shieldAlpha = nil;
    end;
end;

local NumberSequence_new_ret = NumberSequence.new(1);

local function isEffect(p5) -- Line: 77
    return p5:IsA("ParticleEmitter") or (p5:IsA("Trail") or p5:IsA("Beam"));
end;

local function showEffect(p6, p7) -- Line: 80
    p6.watches[p7]:Disconnect();
    p7.Transparency = p6.effects[p7];
    local watches = p6.watches;
    p6.effects[p7] = nil;
    watches[p7] = nil;
end;

local function hideEffect(u8, u9) -- Line: 86
    -- upvalues: NumberSequence_new_ret (copy)
    if u8.effects[u9] then
        return;
    end;

    u8.effects[u9] = u9.Transparency;
    u8.watches[u9] = u9:GetPropertyChangedSignal("Transparency"):Connect(function() -- Line: 92
        -- upvalues: u9 (copy), u8 (copy), NumberSequence_new_ret (ref)
        local Transparency = u9.Transparency;

        if u8.effects and (u8.effects[u9] and Transparency ~= NumberSequence_new_ret) then
            u8.effects[u9] = Transparency;
            u9.Transparency = NumberSequence_new_ret;
        end;
    end);
    u9.Transparency = NumberSequence_new_ret;

    if not u9:IsA("Beam") then
        u9:Clear();
    end;
end;

local function reveal(p10) -- Line: 128
    if not p10.effects then
        return;
    end;

    p10.added:Disconnect();
    p10.removing:Disconnect();

    for i in p10.effects do
        p10.watches[i]:Disconnect();
        i.Transparency = p10.effects[i];
        local watches = p10.watches;
        p10.effects[i] = nil;
        watches[i] = nil;
    end;

    p10.effects = nil;
    p10.watches = nil;
    p10.added = nil;
    p10.removing = nil;
end;

local function watch(p11) -- Line: 233
    -- upvalues: u1 (copy)
    u1[p11] = {
        hidden = {}
    };
end;

Players.PlayerAdded:Connect(function(p12) -- Line: 236, Name: playerAdded
    -- upvalues: watch (copy), u1 (copy)
    p12.CharacterAdded:Connect(watch);

    if p12.Character then
        u1[p12.Character] = {
            hidden = {}
        };
    end;
end);

local function unlight(p13, p14) -- Line: 199
    -- upvalues: LocalLooks (copy)
    local os_clock_ret = os.clock();

    if p13.unlitAt and os_clock_ret - p13.unlitAt < 0.25 then
        return;
    end;

    p13.unlitAt = os_clock_ret;

    for _, descendant in p14:GetDescendants() do
        if descendant:IsA("Highlight") then
            if not p13.hidden[descendant] then
                local v15 = {
                    Enabled = LocalLooks.hold(descendant, "Enabled", p13)
                };
                p13.hidden[descendant] = v15;
            end;

            if descendant.Enabled then
                descendant.Enabled = false;
            end;
        end;
    end;
end;

local function restore(p16) -- Line: 139
    -- upvalues: reveal (copy), LocalLooks (copy)
    p16.unlitAt = nil;
    reveal(p16);

    for i, v in p16.hidden do
        local u17 = i;

        for i2 in v do
            local v18, u19 = LocalLooks.release(u17, i2, p16);

            if v18 then
                pcall(function() -- Line: 149
                    -- upvalues: u17 (copy), i2 (copy), u19 (copy)
                    u17[i2] = u19;
                end);
            end;
        end;
    end;

    table.clear(p16.hidden);
end;

local function resetBlade(p20) -- Line: 218
    if p20.blade and p20.blade.Parent then
        p20.blade.Size = p20.size;
    end;

    if p20.weld and p20.weld.Parent then
        local weld = p20.weld;
        local c1 = p20.c1;
        p20.weld.C0 = p20.c0;
        weld.C1 = c1;
    end;

    if p20.glow then
        p20.glow:Destroy();
    end;

    if p20.light then
        p20.light:Destroy();
    end;

    p20.blade = nil;
    p20.weld = nil;
    p20.glow = nil;
    p20.light = nil;
end;

local function showShield(p21, p22, p23) -- Line: 40
    -- upvalues: OneHitShield (copy), Color3_fromRGB_ret (copy), Folder (copy)
    local shield = p21.shield;

    if not shield then
        local v24 = OneHitShield:FindFirstChildWhichIsA("BasePart", true);

        if v24 then
            shield = v24:Clone();

            for _, child in shield:GetChildren() do
                if child:IsA("JointInstance") or (child:IsA("Constraint") or child:IsA("LuaSourceContainer")) then
                    child:Destroy();
                end;
            end;
        else
            shield = Instance.new("Part");
            shield.Shape = Enum.PartType.Ball;
            shield.Size = Vector3.new(6.4, 6.4, 6.4);
            shield.Material = Enum.Material.ForceField;
            shield.Color = Color3_fromRGB_ret;
        end;

        shield.Name = "OneHitShieldBubble";
        shield.Anchored = true;
        shield.CanCollide = false;
        shield.CanTouch = false;
        shield.CanQuery = false;
        shield.CastShadow = false;
        shield.Parent = Folder;
        p21.shield = shield;
    end;

    if p21.shieldAlpha ~= p23 then
        p21.shieldAlpha = p23;
        shield.Transparency = p23;
    end;

    shield.CFrame = p22.CFrame;
end;

local function conceal(u25, p26) -- Line: 106
    -- upvalues: hideEffect (copy)
    if u25.effects then
        return;
    end;

    u25.effects = {};
    u25.watches = {};

    for _, descendant in p26:GetDescendants() do
        if descendant:IsA("ParticleEmitter") or (descendant:IsA("Trail") or descendant:IsA("Beam")) then
            hideEffect(u25, descendant);
        end;
    end;

    u25.added = p26.DescendantAdded:Connect(function(p27) -- Line: 116
        -- upvalues: u25 (copy), hideEffect (ref)
        if u25.effects and (p27:IsA("ParticleEmitter") or (p27:IsA("Trail") or p27:IsA("Beam"))) then
            hideEffect(u25, p27);
        end;
    end);
    u25.removing = p26.DescendantRemoving:Connect(function(p28) -- Line: 122
        -- upvalues: u25 (copy)
        if u25.effects and u25.effects[p28] then
            local v29 = u25;
            v29.watches[p28]:Disconnect();
            p28.Transparency = v29.effects[p28];
            local watches = v29.watches;
            v29.effects[p28] = nil;
            watches[p28] = nil;
        end;
    end);
end;

local function hide(p30, p31, p32) -- Line: 157
    -- upvalues: LocalLooks (copy)
    for _, descendant in p31:GetDescendants() do
        local v33 = p30.hidden[descendant];

        if not v33 then
            local v34 = descendant:IsA("BasePart") and "LocalTransparencyModifier" or (descendant:IsA("Decal") and "Transparency" or (descendant:IsA("Humanoid") and "DisplayDistanceType" or ((descendant:IsA("BillboardGui") or (descendant:IsA("Highlight") or (descendant:IsA("Light") or (descendant:IsA("Fire") or (descendant:IsA("Smoke") or descendant:IsA("Sparkles")))))) and "Enabled" or nil)));
            v33 = v34 and {
                [v34] = LocalLooks.hold(descendant, v34, p30)
            } or v33;
            p30.hidden[descendant] = v33;
        end;

        if v33 then
            local v35 = descendant;

            for i, v in v33 do
                if i == "Enabled" then
                    v35[i] = false;
                elseif i == "DisplayDistanceType" then
                    v35[i] = Enum.HumanoidDisplayDistanceType.None;
                else
                    v35[i] = v + (1 - v) * p32;
                end;
            end;
        end;
    end;
end;

for _, v in Players:GetPlayers() do
    v.CharacterAdded:Connect(watch);

    if v.Character then
        u1[v.Character] = {
            hidden = {}
        };
    end;
end;

local function scaled(p36, p37) -- Line: 246
    return CFrame.new(p36.Position * p37) * p36.Rotation;
end;

RunService:BindToRenderStep("AbilityBuffVisuals", Enum.RenderPriority.Last.Value, function() -- Line: 249
    -- upvalues: u1 (copy), restore (copy), resetBlade (copy), Players (copy), PumpkinSmoke (copy), showShield (copy), conceal (copy), hide (copy), unlight (copy), KnifeChains (copy)
    for i, v in u1 do
        if i.Parent then
            local HumanoidRootPart = i:FindFirstChild("HumanoidRootPart");
            local v38 = i == Players.LocalPlayer.Character;
            local v39 = i:GetAttribute("Cloaked") == true;
            local v40;

            if v38 then
                v40 = 0.8;
            elseif HumanoidRootPart then
                local Character = Players.LocalPlayer.Character;

                if Character then
                    Character = Character:FindFirstChild("HumanoidRootPart");
                end;

                local v41;

                if Character then
                    v41 = Character.Position;
                else
                    v41 = workspace.CurrentCamera.CFrame.Position;
                end;

                v40 = math.clamp(((HumanoidRootPart.Position - v41).Magnitude - 0.5) / 19.5, 0, 1);
            else
                v40 = 1;
            end;

            local v42 = PumpkinSmoke.hidden(i);

            if HumanoidRootPart and i:GetAttribute("HitShielded") == true then
                showShield(v, HumanoidRootPart, not v39 and 0 or (v38 and 0.6 or v40));
            elseif v.shield and v.shield then
                v.shield:Destroy();
                v.shield = nil;
                v.shieldAlpha = nil;
            end;

            if i:GetAttribute("Ghosted") == true then
                conceal(v, i);
                hide(v, i, 0.8);
            elseif v39 then
                conceal(v, i);
                hide(v, i, v40);
            elseif v42 then
                if v.effects then
                    restore(v);
                end;

                unlight(v, i);
            elseif v.effects or next(v.hidden) then
                restore(v);
            end;

            local v43 = i:GetAttribute("BigDaggerActive") == true;
            local EquippedDagger = i:FindFirstChild("EquippedDagger");
            local v44;

            if EquippedDagger then
                v44 = EquippedDagger:FindFirstChild("Blade");
            else
                v44 = EquippedDagger;
            end;

            if v.blade and v.blade ~= v44 then
                resetBlade(v);
            end;

            if v43 and (v44 and not v.blade) then
                local Handle = EquippedDagger:FindFirstChild("Handle");

                if Handle then
                    Handle = Handle:FindFirstChild("BladeWeld");
                end;

                if Handle then
                    local Size = v44.Size;
                    local C0 = Handle.C0;
                    local C1 = Handle.C1;
                    v.blade = v44;
                    v.size = Size;
                    v.weld = Handle;
                    v.c0 = C0;
                    v.c1 = C1;
                    local v45 = KnifeChains.of(EquippedDagger);
                    v.chained = v45 ~= nil;
                    local Highlight = Instance.new("Highlight");
                    Highlight.Name = "BigDaggerGlow";

                    if not v45 then
                        EquippedDagger = v44;
                    end;

                    Highlight.Adornee = EquippedDagger;
                    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
                    Highlight.FillColor = Color3.fromRGB(255, 207, 64);
                    Highlight.OutlineColor = Color3.fromRGB(255, 235, 120);
                    Highlight.FillTransparency = 0.55;
                    Highlight.OutlineTransparency = 0.08;
                    Highlight.Parent = v44;
                    v.glow = Highlight;
                    local PointLight = Instance.new("PointLight");
                    PointLight.Name = "BigDaggerLight";
                    PointLight.Color = Color3.fromRGB(255, 216, 86);
                    PointLight.Brightness = 1.1;
                    PointLight.Range = 7;
                    PointLight.Shadows = false;

                    if v45 then
                        v44 = v45[1]:FindFirstChild("Top") or v44;
                    end;

                    PointLight.Parent = v44;
                    v.light = PointLight;
                end;
            end;

            if v.blade then
                if v43 then
                    if not v.chained then
                        v.blade.Size = v.size * 2;
                        local weld = v.weld;
                        local weld2 = v.weld;
                        local c0 = v.c0;
                        local v46 = CFrame.new(c0.Position * 2) * c0.Rotation;
                        local c1 = v.c1;
                        local v47 = CFrame.new(c1.Position * 2) * c1.Rotation;
                        weld.C0 = v46;
                        weld2.C1 = v47;
                    end;
                else
                    resetBlade(v);
                end;
            end;
        else
            restore(v);
            resetBlade(v);

            if v.shield then
                v.shield:Destroy();
                v.shield = nil;
                v.shieldAlpha = nil;
            end;

            if Players:GetPlayerFromCharacter(i) == nil then
                u1[i] = nil;
            end;
        end;
    end;
end);
script.Destroying:Connect(function() -- Line: 332
    -- upvalues: RunService (copy), u1 (copy), restore (copy), resetBlade (copy), Folder (copy)
    RunService:UnbindFromRenderStep("AbilityBuffVisuals");

    for _, v in u1 do
        restore(v);
        resetBlade(v);

        if v.shield then
            v.shield:Destroy();
            v.shield = nil;
            v.shieldAlpha = nil;
        end;
    end;

    Folder:Destroy();
end);