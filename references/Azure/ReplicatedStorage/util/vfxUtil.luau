 

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local Lighting = game:GetService("Lighting");
local TweenService = game:GetService("TweenService");
game:GetService("ServerScriptService");
local RunService = game:GetService("RunService");

if RunService:IsClient() and RunService:IsStudio() then
    RunService:IsRunning();
end;

require(ReplicatedStorage.allTypes.rig);
local script_ForgeVFX = require(script.ForgeVFX);
local script_AvatarLoading = require(script.AvatarLoading);
local trove = require(ReplicatedStorage.forum.trove);
local Util = require(ReplicatedStorage.util.Util);
local styles = require(ReplicatedStorage.wiki.styles);
local LocalPlayer = Players.LocalPlayer;
local u1 = {};

for _, child in Lighting:GetChildren() do
    table.insert(u1, child);
end;

local u7 = {
    addDurations = function(p2: table, p3: any) -- Line: 37, Name: addDurations
        local v4 = 0;

        if typeof(p3) == "table" then
            for _, v in ipairs(p3) do
                v4 = v4 + p2[v].Duration;
            end;

            return v4;
        end;

        if typeof(p3) == "number" then
            for i = 1, p3 do
                v4 = v4 + p2[i].Duration;
                local _ = i;
            end;

            return v4;
        end;

        for _, v in ipairs(p2) do
            v4 = v4 + v.Duration;
        end;

        return v4;
    end,

    getEmitterLifetime = function(p5: userdata?) -- Line: 55, Name: getEmitterLifetime
        local v6 = 0;

        if typeof(p5) ~= "Instance" then
            return v6;
        end;

        if p5:IsA("ParticleEmitter") then
            return p5.Lifetime.Max / p5.TimeScale;
        end;

        if p5:IsA("Trail") then
            return p5.Lifetime;
        end;

        if p5:IsA("Model") and typeof(p5:GetAttribute("EffectDuration")) == "NumberRange" then
            return p5:GetAttribute("EffectDuration").Max;
        end;

        if p5:IsA("RayValue") and typeof(p5:GetAttribute("Duration")) == "number" then
            return p5:GetAttribute("Duration");
        end;

        if p5:IsA("Sound") then
            v6 = p5.TimeLength;
        end;

        return v6;
    end
};

function u7.getEmittersLifetime(p8: userdata) -- Line: 74
    -- upvalues: u7 (copy)
    local EmitterLifetime = u7.getEmitterLifetime(p8);

    if typeof(p8) == "Instance" then
        for _, descendant in p8:GetDescendants() do
            local EmitterLifetime2 = u7.getEmitterLifetime(descendant);

            if EmitterLifetime < EmitterLifetime2 then
                EmitterLifetime = EmitterLifetime2;
            end;
        end;
    end;

    return EmitterLifetime;
end;

function u7.getBulkEmittersLifetime(...) -- Line: 87
    -- upvalues: u7 (copy)
    local v9 = 0;

    for _, v in { ... } do
        local EmittersLifetime = u7.getEmittersLifetime(v);

        if v9 < EmittersLifetime then
            v9 = EmittersLifetime;
        end;
    end;

    return v9;
end;

function u7.onBallLost(u10: any, u11: function?) -- Line: 98
    local Ball = u10:FindFirstChild("Ball");
    local u12 = nil;
    local BoolValue = Instance.new("BoolValue");

    if Ball then
        u12 = Ball.AncestryChanged:Connect(function() -- Line: 103
            -- upvalues: Ball (copy), u10 (copy), BoolValue (copy), u12 (ref), u11 (copy)
            if Ball.Parent ~= u10 then
                BoolValue.Value = true;
                u12:Disconnect();

                if typeof(u11) == "function" then
                    u11();
                end;
            end;
        end);
    elseif typeof(u11) == "function" then
        u11();
    end;

    return u12, Ball, BoolValue;
end;

function u7.getRoot(p13) -- Line: 118
    return p13:FindFirstChild("HumanoidRootPart") or p13.PrimaryPart;
end;

u7.VFX_CANCEL_ATTRIBUTE = "trovecancel";

function u7.character_trove(p14: userdata) -- Line: 124
    -- upvalues: trove (copy), u7 (copy)
    local u15 = trove.new();

    if typeof(p14) == "Instance" and p14:IsDescendantOf(game) then
        u15:AttachToInstance(p14);
        u15:Add(p14:GetAttributeChangedSignal(u7.VFX_CANCEL_ATTRIBUTE):Connect(function() -- Line: 128
            -- upvalues: u15 (copy)
            u15:Destroy();
        end));
    end;

    return u15;
end;

function u7.isLocalPlayer(...) -- Line: 135
    -- upvalues: LocalPlayer (copy)
    local Character = LocalPlayer.Character;

    for _, v in { ... } do
        if Character == v or v:GetAttribute("DummyOwner") == Character.Name then
            return true;
        end;
    end;

    return false;
end;

function u7.emit(u16: userdata, u17: boolean?) -- Line: 147
    -- upvalues: TweenService (copy)
    local u18 = {
        Particle = u16:IsA("ParticleEmitter"),
        Beam = u16:IsA("Beam")
    };
    local v19 = false;

    for _, v in u18 do
        if v then
            v19 = true;
            break;
        end;
    end;

    if not v19 then
        return;
    end;

    task.delay(u16:GetAttribute("EmitDelay") or 0, function() -- Line: 160
        -- upvalues: u18 (copy), u16 (copy), u17 (copy), TweenService (ref)
        if u18.Particle then
            u16:Emit(not u17 and (shared.allvfxcheck and shared.allvfxcheck()) and 0 or u16:GetAttribute("EmitCount"));
            u16.TimeScale = u16:GetAttribute("TimeScale_Start") or u16.TimeScale;
            local Attribute = u16:GetAttribute("TimeScale_Duration");
            local Attribute2 = u16:GetAttribute("TimeScale_End");

            if Attribute2 then
                TweenService:Create(u16, TweenInfo.new(Attribute or 0, Enum.EasingStyle.Linear), {
                    TimeScale = Attribute2
                }):Play();
            end;
        end;

        local Attribute = u16:GetAttribute("EmitDuration");

        if Attribute then
            u16.Enabled = Attribute > 0;
            task.delay(Attribute, function() -- Line: 175
                -- upvalues: u16 (ref)
                u16.Enabled = false;
            end);
        end;
    end);
end;

function u7.emitAll(...) -- Line: 182
    -- upvalues: u7 (copy)
    local v20 = {};

    for _, v in ipairs({ ... }) do
        if typeof(v) == "Instance" then
            u7.emit(v);
            local v21 = v;

            for _, v2 in ipairs({ "ParticleEmitter", "Beam", "Model" }) do
                for _, v3 in v21:QueryDescendants(v2) do
                    u7.emit(v3);
                    table.insert(v20, v3);
                end;
            end;
        else
            for _, v2 in v do
                u7.emit(v2);
                table.insert(v20, v2);
            end;
        end;
    end;

    return v20;
end;

function u7.dispose(u22: userdata) -- Line: 203
    xpcall(function() -- Line: 204
        -- upvalues: u22 (copy)
        u22:Destroy();
    end, warn);
end;

function u7.disposal(u23: any, p24: number?) -- Line: 209
    -- upvalues: u7 (copy)
    local u25;

    if typeof(u23) == "table" then
        u25 = typeof(u23.Destroy) ~= "function";
    else
        u25 = false;
    end;

    if typeof(p24) ~= "number" then
        p24 = u7.getEmittersLifetime(u23);

        if u25 then
            for _, v in u23 do
                local EmittersLifetime = u7.getEmittersLifetime(v);

                if p24 < EmittersLifetime then
                    p24 = EmittersLifetime;
                end;
            end;
        end;
    end;

    task.delay(p24, function() -- Line: 222
        -- upvalues: u25 (copy), u23 (copy), u7 (ref)
        if u25 then
            for _, v in u23 do
                u7.dispose(v);
            end;

            return;
        end;

        u7.dispose(u23);
    end);
end;

function u7.highlight(p26: userdata, p27: table) -- Line: 233
    local Highlight = Instance.new("Highlight");

    for i, v in p27 do
        Highlight[i] = v;
    end;

    Highlight.Parent = p26;

    return Highlight;
end;

function u7.build_highlights(p28: userdata, u29: any, u30: string) -- Line: 242
    -- upvalues: u7 (copy)
    local function build(p31: userdata) -- Line: 243
        -- upvalues: u30 (copy), u29 (copy), u7 (ref)
        local v32 = p31:FindFirstChild(u30);
        local Attributes = v32:GetAttributes();
        Attributes.Name = p31.Name;
        Attributes.DepthMode = Enum.HighlightDepthMode[Attributes.DepthMode];
        local Adornee = v32:FindFirstChild("Adornee");

        if Adornee then
            Attributes.Adornee = Adornee.Value;
        end;

        local v33 = u29:Add(u7.highlight(p31.Parent, Attributes));

        for i, v in p31:GetAttributes() do
            v33:SetAttribute(i, v);
        end;

        for _, v in p31:GetTags() do
            v33:AddTag(v);
        end;

        for _, child in p31:GetChildren() do
            if child ~= v32 then
                child.Parent = v33;
            end;
        end;

        p31:Destroy();

        return v33;
    end;

    if p28:IsA("Folder") and p28:FindFirstChild(u30) then
        p28 = build(p28);
    end;

    for _, descendant in p28:GetDescendants() do
        if descendant:IsA("Folder") and descendant:FindFirstChild(u30) then
            build(descendant);
        end;
    end;

    return p28;
end;

function u7.createVFX(p34, p35, p36) -- Line: 281
    local v37 = p34:Clone();

    if typeof(p36) == "Instance" and p36:IsA("BasePart") then
        if v37:FindFirstChild("Weld") or not v37:IsA("BasePart") then
            if v37:FindFirstChild("Weld") then
                local Weld = v37.Weld;
                Weld.Part0 = p36;

                if not Weld.Part1 and v37:IsA("BasePart") then
                    Weld.Part1 = v37;
                end;
            end;
        else
            local Weld = Instance.new("Weld");
            Weld.Part0 = p36;
            Weld.Part1 = v37;
            Weld.Parent = v37;
        end;
    elseif typeof(p36) == "CFrame" then
        v37.CFrame = p36;
    end;

    if p35 == "default" then
        v37.Parent = workspace.Effects;

        return v37;
    end;

    v37.Parent = p35;

    return v37;
end;

function u7.quickVFX(p38: userdata, p39: any, p40: any) -- Line: 308
    -- upvalues: u7 (copy)
    local v41 = u7.createVFX(p38, p39, p40);
    u7.emitAll(v41);
    u7.disposal(v41);
end;

function u7.regenerate(p42: userdata) -- Line: 314
    local Instance_new_ret = Instance.new(p42.Name);

    for i, v in p42:GetAttributes() do
        pcall(function() -- Line: 317
            -- upvalues: Instance_new_ret (copy), i (copy), v (copy)
            Instance_new_ret[i] = v;
        end);
    end;

    return Instance_new_ret;
end;

function u7.setupAura(p43: any, p44: userdata, p45: boolean?, p46: boolean?) -- Line: 324
    for _, child in p44:GetChildren() do
        if child:IsA("BasePart") then
            local v47 = p43:FindFirstChild(child.Name);

            if v47 then
                if v47:IsA("BasePart") then
                    if not p45 then
                        child.Name = `{child.Name} Aura`;
                    end;

                    child.Massless = true;
                    child.CanCollide = false;
                    local v48 = child:FindFirstChild("Weld") or Instance.new("Weld");
                    v48.Part0 = v47;
                    v48.Part1 = child;
                    v48.Parent = child;
                end;
            elseif not p46 then
                child:Destroy();
            end;
        end;
    end;
end;

local u49 = {};

function u49.__index(p50, p51) -- Line: 349
    -- upvalues: u49 (copy)
    if u49[p51] then
        return u49[p51];
    end;

    for _, v in ipairs(p50) do
        if v.Name == p51 then
            return v;
        end;
    end;
end;

function u49.__iter(p52) -- Line: 360
    return ipairs(p52);
end;

function u49.GetChildren(p53) -- Line: 364
    local v54 = {};

    for i, v in ipairs(p53) do
        v54[i] = v;
    end;

    return v54;
end;

function u49.GetDescendants(p55) -- Line: 372
    local v56 = {};

    for _, v in ipairs(p55) do
        table.insert(v56, v);

        for _, descendant in v:GetDescendants() do
            table.insert(v56, descendant);
        end;
    end;

    return v56;
end;

local function canPivot(p57) -- Line: 383
    local v58;

    if typeof(p57) == "Instance" then
        v58 = p57:IsA("Model");
    else
        v58 = false;
    end;

    return v58;
end;

function u7.buildFromRig(p59, p60, p61) -- Line: 389
    -- upvalues: trove (copy), u49 (copy)
    local v62 = p61 or trove.new();
    local u63 = setmetatable({}, u49);
    local v64 = p60:Clone();
    local v65;

    if typeof(v64) == "Instance" then
        v65 = v64:IsA("Model");
    else
        v65 = false;
    end;

    if v65 then
        local v66;

        if typeof(p59) == "Instance" then
            v66 = p59:IsA("Model");
        else
            v66 = false;
        end;

        if v66 then
            v64:PivotTo(p59:GetPivot());
        end;
    end;

    local u67 = {};

    local function mapMatches(p68, p69, p70) -- Line: 401
        -- upvalues: u67 (copy), mapMatches (copy)
        for _, child in p68:GetChildren() do
            if not (child:IsA("Weld") or (child:IsA("Motor6D") or p70 > 0 and not (child:IsA("BasePart") or (child:IsA("Model") or child:IsA("Folder"))))) then
                local v71 = p69:FindFirstChild(child.Name);

                if v71 then
                    u67[child] = v71;
                    mapMatches(child, v71, p70 + 1);
                end;
            end;
        end;
    end;

    mapMatches(v64, p59, 0);
    local u72 = {};

    for _, descendant in v64:GetDescendants() do
        if descendant:IsA("Weld") or descendant:IsA("Motor6D") then
            local v73 = u67[descendant.Part0];
            local v74 = u67[descendant.Part1];

            if v73 and v74 then
                u72[descendant] = true;
            elseif v73 then
                descendant.Part0 = v73;
            elseif v74 then
                descendant.Part1 = v74;
            end;
        end;
    end;

    local function merge(p75, p76) -- Line: 435
        -- upvalues: u72 (copy), u67 (copy), merge (copy), u63 (copy)
        for _, child in p75:GetChildren() do
            if not u72[child] then
                local v77 = u67[child];

                if v77 then
                    merge(child, v77);
                else
                    child.Parent = p76;
                    table.insert(u63, child);
                end;
            end;
        end;
    end;

    merge(v64, p59);
    v64:Destroy();

    for _, v in u63 do
        v62:Add(v);
    end;

    return v62, u63;
end;

function u7.getPlayer(p78) -- Line: 461
    -- upvalues: Players (copy)
    return Players:GetPlayerFromCharacter(p78) or false;
end;

function u7.getPlayerGui() -- Line: 470
    -- upvalues: LocalPlayer (copy)
    return LocalPlayer.PlayerGui;
end;

function u7.getMoonEffects() -- Line: 474
    -- upvalues: u7 (copy), LocalPlayer (copy)
    local v79 = u7.getResources().MoonAnimatorEffects:Clone();
    local Subtitles = v79.Subtitles;
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local u80 = workspace_CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function() -- Line: 479, Name: updateSubtitleScale
        -- upvalues: workspace_CurrentCamera (copy), Subtitles (copy)
        local ViewportSize = workspace_CurrentCamera.ViewportSize;
        Subtitles:SetAttribute("MoonTextScale", (math.min(ViewportSize.X / 1920, ViewportSize.Y / 1080)));
    end);
    v79.Destroying:Once(function() -- Line: 485
        -- upvalues: u80 (copy)
        u80:Disconnect();
    end);
    local ViewportSize = workspace_CurrentCamera.ViewportSize;
    Subtitles:SetAttribute("MoonTextScale", (math.min(ViewportSize.X / 1920, ViewportSize.Y / 1080)));
    local Vignette = v79.Vignette;
    Vignette.Changed:Connect(function(p81) -- Line: 491
        -- upvalues: Vignette (copy)
        if not table.find({ "ImageTransparency", "ImageColor3" }, p81) then
            return;
        end;

        for _, descendant in Vignette:GetDescendants() do
            if descendant:IsA("ImageLabel") then
                descendant[p81] = Vignette[p81];
            end;
        end;
    end);
    local Letterbox = v79.Letterbox.Letterbox;
    Letterbox.Changed:Connect(function(p82) -- Line: 500
        -- upvalues: Letterbox (copy)
        if table.find({ "BackgroundTransparency", "BackgroundColor3", "Size" }, p82) then
            Letterbox.Parent.Top[p82] = Letterbox[p82];
        end;
    end);
    v79.Parent = LocalPlayer.PlayerGui;

    return v79;
end;

function u7.enableEffects(p83: userdata, p84: boolean, p85: string) -- Line: 509
    for _, v in p83:QueryDescendants(p85) do
        v.Enabled = p84;
    end;
end;

function u7.getStyleData(p86) -- Line: 515
    -- upvalues: styles (copy)
    local v87;

    if styles[p86] == nil then
        v87 = false;
    else
        v87 = styles[p86];
    end;

    return v87;
end;

function u7.getResources() -- Line: 519
    -- upvalues: ReplicatedStorage (copy)
    return ReplicatedStorage:WaitForChild("Resources");
end;

function u7.newRig(p88: any, p89) -- Line: 523
    -- upvalues: u7 (copy)
    local v90 = u7.getResources().Rig:Clone();
    local CFrame = p88.CFrame;

    if p89 then
        CFrame = CFrame * p89;
    end;

    v90.HumanoidRootPart.CFrame = CFrame;
    v90.Parent = workspace.Effects;

    for _, descendant in v90:GetDescendants() do
        if descendant:IsA("BasePart") then
            descendant.CollisionGroup = "none";
        end;
    end;

    return v90;
end;

function u7.newRigForFriend(u91: any, u92: userdata?, p93) -- Line: 539
    -- upvalues: u7 (copy), script_AvatarLoading (copy), Players (copy)
    local u94 = u7.newRig(u91, p93);
    local BoolValue = Instance.new("BoolValue");
    task.defer(function() -- Line: 542
        -- upvalues: u94 (copy), script_AvatarLoading (ref), u92 (copy), Players (ref), u91 (copy), BoolValue (copy)
        u94.Name = "???";
        local l_warn = warn;
        local v95 = u92 or Players:GetPlayerFromCharacter(u91.Parent);
        xpcall(script_AvatarLoading, l_warn, v95, u94);
        BoolValue.Value = true;
    end);

    return u94, BoolValue;
end;

local table_freeze_ret = table.freeze({});

function u7.characterHasAccessory(p96: userdata?, p97: string) -- Line: 552
    if typeof(p96) ~= "Instance" then
        return false;
    end;

    local v98 = nil;

    if p96:IsA("Model") then
        v98 = p96;
    elseif p96:IsA("Player") then
        v98 = p96.Character;
    end;

    if not v98 then
        return false;
    end;

    for _, child in v98:GetChildren() do
        if child:IsA("Accessory") and string.find(child.Name, p97, 1, true) then
            return true;
        end;
    end;

    return false;
end;

function u7.resolveAccessoryVfxRecolor(p99: userdata?, p100: number?) -- Line: 577
    -- upvalues: table_freeze_ret (copy), u7 (copy)
    if not (p100 and table_freeze_ret[p100]) then
        return nil, nil;
    end;

    if u7.characterHasAccessory(p99, "Pastel Blue") then
        return Color3.fromRGB(140, 220, 255), 0.985;
    end;

    return Color3.fromRGB(255, 30, 30), 0.985;
end;

function u7.applyAccessoryVfxRecolor(p101: userdata?, p102: number?) -- Line: 589
    -- upvalues: u7 (copy)
    if typeof(p101) ~= "Instance" or not p101:IsA("Model") then
        return false;
    end;

    local v103, v104 = u7.resolveAccessoryVfxRecolor(p101, p102);

    if not v103 then
        return false;
    end;

    p101:SetAttribute("CustomColor", v103);
    p101:SetAttribute("CustomAlpha", v104);

    return true;
end;

function u7.flash(p105, p106: number, p107: number?) -- Line: 604
    -- upvalues: Lighting (copy), TweenService (copy)
    local TweenInfo_new_ret = TweenInfo.new(p106);
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.TintColor = p105 or Color3.new(1, 1, 1);
    ColorCorrectionEffect.Contrast = 0.5;
    ColorCorrectionEffect.Parent = Lighting;
    local BlurEffect = Instance.new("BlurEffect");
    BlurEffect.Size = p107 or 4;
    BlurEffect.Parent = Lighting;
    TweenService:Create(ColorCorrectionEffect, TweenInfo_new_ret, {
        Contrast = 0,
        TintColor = Color3.new(1, 1, 1)
    }):Play();
    TweenService:Create(BlurEffect, TweenInfo_new_ret, {
        Size = 0
    }):Play();
    task.delay(TweenInfo_new_ret.Time, ColorCorrectionEffect.Destroy, ColorCorrectionEffect);
    task.delay(TweenInfo_new_ret.Time, BlurEffect.Destroy, BlurEffect);
end;

function u7.IsOptimizationSettingOn(p108, p109, p110) -- Line: 619
    if p110 == nil or not p110 then
        p110 = p110 == nil;
    end;

    local v111 = false;

    if p108:FindFirstChild("setting") then
        if p110 and p108.setting:FindFirstChild("LowerVFX") then
            v111 = p108.setting:FindFirstChild("LowerVFX").Value;
        end;

        if not v111 and (p108.setting:FindFirstChild("AdvancedSettings") and p108.setting.AdvancedSettings:FindFirstChild(p109)) then
            v111 = p108.setting.AdvancedSettings:FindFirstChild(p109).Value;
        end;
    end;

    return v111;
end;

function u7.IsSettingOn(p112, p113) -- Line: 638
    local v114 = false;

    if p112:FindFirstChild("setting") and (not v114 and p112.setting:FindFirstChild(p113)) then
        v114 = p112.setting:FindFirstChild(p113).Value;
    end;

    return v114;
end;

function u7.getScreenDimmer() -- Line: 650
    -- upvalues: Util (copy), u7 (copy), TweenService (copy)
    local u115 = script.ScreenDim:Clone();

    if Util.isepilepsysafe() then
        u115.Parent = u7.getPlayerGui();
    end;

    return {
        Destroy = function(p116) -- Line: 656, Name: Destroy
            -- upvalues: TweenService (ref), u115 (copy)
            local TweenInfo_new_ret = TweenInfo.new(1);
            TweenService:Create(u115.Frame, TweenInfo_new_ret, {
                BackgroundTransparency = 1
            }):Play();
            task.delay(TweenInfo_new_ret.Time, function() -- Line: 661
                -- upvalues: u115 (ref)
                u115:Destroy();
            end);
        end
    };
end;

local function isColorable(p117) -- Line: 668
    return p117:IsA("ParticleEmitter") or (p117:IsA("Trail") or p117:IsA("Beam"));
end;

local function isEzColorable(p118) -- Line: 672
    return p118:IsA("ParticleEmitter") or (p118:IsA("Trail") or p118:IsA("Beam")) or p118:IsA("ImageLabel");
end;

local function forEachEmitter(p119, p120, p121) -- Line: 676
    -- upvalues: isColorable (copy), forEachEmitter (copy)
    local v122 = p121 or isColorable;

    if typeof(p119) ~= "Instance" then
        if typeof(p119) == "table" then
            for _, v in p119 do
                forEachEmitter(v, p120, v122);
            end;
        end;

        return;
    end;

    if v122(p119) then
        p120(p119);
    end;

    for _, descendant in p119:GetDescendants() do
        if v122(descendant) then
            p120(descendant);
        end;
    end;
end;

local function lerpHue(p123, p124, p125) -- Line: 694
    local v126 = (p124 - p123) % 1;

    if v126 > 0.5 then
        v126 = v126 - 1;
    end;

    return (p123 + v126 * p125) % 1;
end;

function u7.LeanTowardsColor(p127, u128, u129) -- Line: 702
    -- upvalues: forEachEmitter (copy)
    forEachEmitter(p127, function(p130) -- Line: 703
        -- upvalues: u128 (copy), u129 (copy)
        local v131 = {};

        for _, v in ipairs(p130.Color.Keypoints) do
            table.insert(v131, ColorSequenceKeypoint.new(v.Time, v.Value:Lerp(u128, u129)));
        end;

        p130.Color = ColorSequence.new(v131);
    end);
end;

function u7.LeanHueTowardsColor(p132, p133, u134) -- Line: 712
    -- upvalues: forEachEmitter (copy)
    local u135 = p133:ToHSV();
    forEachEmitter(p132, function(p136) -- Line: 715
        -- upvalues: u135 (copy), u134 (copy)
        local v137 = {};

        for _, v in ipairs(p136.Color.Keypoints) do
            local v138, v139, v140 = v.Value:ToHSV();
            local v141 = (u135 - v138) % 1;

            if v141 > 0.5 then
                v141 = v141 - 1;
            end;

            local Color3_fromHSV_ret = Color3.fromHSV((v138 + v141 * u134) % 1, v139, v140);
            table.insert(v137, ColorSequenceKeypoint.new(v.Time, Color3_fromHSV_ret));
        end;

        p136.Color = ColorSequence.new(v137);
    end);
end;

function u7.EzLeanTowardsColor(p142, p143, p144) -- Line: 726
    -- upvalues: Players (copy), Util (copy), forEachEmitter (copy), isEzColorable (copy)
    if Util.canshiftcolor(p142 or Players.LocalPlayer, p143) then
        local u145 = p143:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127);
        local u146 = p143:GetAttribute("CustomAlpha") or 0.985;
        forEachEmitter(p144, function(p147) -- Line: 734
            -- upvalues: u145 (copy), u146 (copy)
            if p147:IsA("ImageLabel") then
                p147.ImageColor3 = p147.ImageColor3:Lerp(u145, u146);

                return;
            end;

            local v148 = {};

            for _, v in ipairs(p147.Color.Keypoints) do
                table.insert(v148, ColorSequenceKeypoint.new(v.Time, v.Value:Lerp(u145, u146)));
            end;

            p147.Color = ColorSequence.new(v148);
        end, isEzColorable);
    end;
end;

function u7.EzLeanHueTowardsColor(p149, p150, p151) -- Line: 748
    -- upvalues: Players (copy), Util (copy), forEachEmitter (copy), isEzColorable (copy)
    if Util.canshiftcolor(p149 or Players.LocalPlayer, p150) then
        local v152 = p150:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127);
        local u153 = p150:GetAttribute("CustomAlpha") or 0.985;
        local u154 = v152:ToHSV();
        forEachEmitter(p151, function(p155) -- Line: 757
            -- upvalues: u154 (copy), u153 (copy)
            if not p155:IsA("ImageLabel") then
                local v156 = {};

                for _, v in ipairs(p155.Color.Keypoints) do
                    local v157, v158, v159 = v.Value:ToHSV();
                    local v160 = (u154 - v157) % 1;

                    if v160 > 0.5 then
                        v160 = v160 - 1;
                    end;

                    local Color3_fromHSV_ret = Color3.fromHSV((v157 + v160 * u153) % 1, v158, v159);
                    table.insert(v156, ColorSequenceKeypoint.new(v.Time, Color3_fromHSV_ret));
                end;

                p155.Color = ColorSequence.new(v156);

                return;
            end;

            local v161, v162, v163 = p155.ImageColor3:ToHSV();
            local v164 = (u154 - v161) % 1;

            if v164 > 0.5 then
                v164 = v164 - 1;
            end;

            p155.ImageColor3 = Color3.fromHSV((v161 + v164 * u153) % 1, v162, v163);
        end, isEzColorable);
    end;
end;

function u7.cache_lighting() -- Line: 774
    -- upvalues: u1 (copy)
    for _, v in u1 do
        pcall(function() -- Line: 776
            -- upvalues: v (copy)
            v.Parent = script.Lighting;
        end);
    end;
end;

function u7.restore_lighting() -- Line: 782
    -- upvalues: u1 (copy), Lighting (copy)
    for _, v in u1 do
        pcall(function() -- Line: 784
            -- upvalues: v (copy), Lighting (ref)
            v.Parent = Lighting;
        end);
    end;
end;

local u165 = {
    Ambient = Lighting.Ambient,
    Brightness = Lighting.Brightness,
    ColorShift_Top = Lighting.ColorShift_Top,
    ColorShift_Bottom = Lighting.ColorShift_Bottom,
    EnvironmentDiffuseScale = Lighting.EnvironmentDiffuseScale,
    EnvironmentSpecularScale = Lighting.EnvironmentSpecularScale,
    GlobalShadows = Lighting.GlobalShadows,
    OutdoorAmbient = Lighting.OutdoorAmbient,
    ShadowSoftness = Lighting.ShadowSoftness,
    ExposureCompensation = Lighting.ExposureCompensation,
    ClockTime = Lighting.ClockTime,
    GeographicLatitude = Lighting.GeographicLatitude
};

function u7.restore_lighting_properties() -- Line: 805
    -- upvalues: LocalPlayer (copy), u165 (copy), Lighting (copy)
    local v166 = LocalPlayer and LocalPlayer:FindFirstChild("setting") and LocalPlayer.setting:FindFirstChild("ClockTime");

    for i, v in u165 do
        if i == "ClockTime" then
            local v167;

            if v166 then
                v167 = v166.Value or v;
            else
                v167 = v;
            end;

            Lighting[i] = v167;
        else
            Lighting[i] = v;
        end;
    end;

    local Clouds = workspace.Terrain:FindFirstChild("Clouds");

    if Clouds then
        for i, v in Clouds:GetAttributes() do
            Clouds[i] = v;
        end;
    end;
end;

local function update_map_transparency(p168, p169, p170) -- Line: 824
    if p168.cached then
        for i, v in p168.savedTransparency do
            i.Transparency = p169 + v;
        end;

        return;
    end;

    for _, descendant in workspace.map:GetDescendants() do
        if (descendant:IsA("BasePart") or (descendant:IsA("Texture") or descendant:IsA("Decal"))) and ((not p170 or p170 ~= descendant) and descendant.Transparency < 1) then
            local Transparency = descendant.Transparency;
            p168.savedTransparency[descendant] = Transparency;
            descendant.Transparency = p169 + Transparency;
        end;
    end;

    p168.cached = true;
end;

function u7.get_map_controller() -- Line: 841
    -- upvalues: update_map_transparency (copy)
    local u171 = {
        cached = false,
        savedTransparency = {}
    };

    function u171.update(p172: number) -- Line: 846
        -- upvalues: update_map_transparency (ref), u171 (copy)
        update_map_transparency(u171, p172);
    end;

    return u171;
end;

function u7.get_baseplate_controller() -- Line: 855
    -- upvalues: update_map_transparency (copy)
    local main = workspace.map.map.sanam.main;
    local u173 = {
        cached = false,
        savedTransparency = {}
    };

    function u173.update() -- Line: 863
        -- upvalues: update_map_transparency (ref), u173 (copy), main (copy)
        update_map_transparency(u173, main.Transparency, main);
    end;

    return u173, main;
end;

function u7.make_baseplate_connection(p174) -- Line: 870
    local main = workspace.map.map.sanam.main;

    if typeof(p174) == "table" then
        if p174.update then
            p174 = p174.update;
        else
            error("No baseplate controller in the table provided");
        end;
    end;

    return main:GetPropertyChangedSignal("Transparency"):Connect(p174);
end;

function u7.cache_module(p175: userdata) -- Line: 885
    local success, result = pcall(require, p175);

    if success then
        return result;
    end;

    warn("Failed to require module:", p175:GetFullName(), result);

    return nil;
end;

function u7.execute_compiled_ex(p176: userdata, p177: any, p178: number?, ...) -- Line: 898
    -- upvalues: u7 (copy)
    local v179 = p178 or 60;

    if p176:IsA("Folder") then
        for _, child in p176:GetChildren() do
            u7.execute_compiled_ex(child, p177, v179, ...);
        end;

        return;
    end;

    local v180 = u7.cache_module(p176);

    if p177 then
        for _, v in ipairs(v180) do
            p177:Add(task.delay(v[1] / v179, v[2], ...));
        end;

        return;
    end;

    for _, v in ipairs(v180) do
        task.delay(v[1] / v179, v[2], ...);
    end;
end;

function u7.execute_compiled(p181: userdata, p182: any, ...) -- Line: 918
    -- upvalues: u7 (copy)
    u7.execute_compiled_ex(p181, p182, nil, ...);
end;

function u7.cutscene_ball(p183: boolean) -- Line: 922
    for _, child in workspace.characters:GetChildren() do
        local Ball = child:FindFirstChild("Ball");

        if Ball and Ball:IsA("BasePart") then
            Ball.Size = Vector3.new(1, 1, 1) * (p183 and 1.5 or 1.95);
        end;
    end;
end;

function u7.cutscene_invisiball(p184, p185) -- Line: 932
    if p184:FindFirstChild("Ball") then
        local Ball = p184.Ball;
        Ball.Transparency = 1;
        local BallMotor = p184:FindFirstChild("BallMotor");

        if BallMotor then
            BallMotor.Enabled = false;
        end;

        p185:Add(function() -- Line: 941
            -- upvalues: Ball (copy), BallMotor (copy)
            Ball.Transparency = 0;

            if BallMotor then
                BallMotor.Enabled = true;
            end;
        end);
    end;
end;

function u7.mvp_cutscene_defaults(u186: any, p187: number, u188: any) -- Line: 954
    -- upvalues: trove (copy), u7 (copy)
    u186.sceneEnabled(true);
    local u189 = trove.new();
    u189:Add(task.delay(p187 - 1, function() -- Line: 957
        -- upvalues: u188 (copy), u186 (copy)
        if u188 and u188.NoFade then
            return;
        end;

        u186.blackscene(1);
    end));
    u189:Add(task.delay(p187, function() -- Line: 963
        -- upvalues: u189 (copy), u188 (copy), u186 (copy)
        if u189 then
            u189:Destroy();
        end;

        if u188 and u188.BackScene then
            u186.sceneEnabled(false);
        end;
    end));

    if u188 and u188.Dim then
        u189:Add(u7.getScreenDimmer());
    end;

    return u189;
end;

function u7.contain_lighting(p190: any, p191: table, p192: userdata) -- Line: 979
    -- upvalues: Lighting (copy)
    for _, child in p192:GetChildren() do
        local v193 = p190:Clone(child);
        v193.Parent = Lighting;
        p191[child.Name] = v193;
    end;
end;

function u7.cutscene_lighting(p194: any, p195: table, p196: userdata?, p197: any) -- Line: 987
    -- upvalues: u7 (copy), Lighting (copy)
    if p196 then
        u7.cache_lighting();
        p194:Add(u7.restore_lighting);
        u7.contain_lighting(p194, p195, p196);
    end;

    if p197 then
        p195.Lighting = Lighting;

        for i, v in p197 do
            Lighting[i] = v;
        end;

        p194:Add(u7.restore_lighting_properties);
    end;
end;

function u7.pick(p198: userdata, p199: string?) -- Line: 1004
    -- upvalues: u7 (copy)
    if p199 then
        for _, child in p198:GetChildren() do
            if child.Name == p199 then
                u7.pick(child);
            end;
        end;

        return;
    end;

    u7.enableEffects(p198, false, "Trail,ParticleEmitter");
    u7.disposal(p198);
end;

if RunService:IsServer() then
    function u7.earlyCancel(p200, p201) -- Line: 1018
        local BoolValue = Instance.new("BoolValue");
        BoolValue.Parent = p200;
        p201:Add(function() -- Line: 1021
            -- upvalues: BoolValue (copy)
            task.delay(1, function() -- Line: 1022
                -- upvalues: BoolValue (ref)
                BoolValue:Destroy();
            end);
        end);

        return BoolValue, false;
    end;
else
    function u7.earlyCancel(p202: userdata, p203: any) -- Line: 1029
        -- upvalues: trove (copy)
        local u204 = trove.new();

        if p203 then
            u204:AttachToInstance(p203);
        end;

        u204:Connect(p202.Changed, function(p205) -- Line: 1034
            -- upvalues: u204 (copy)
            if p205 then
                u204:Destroy();
            end;
        end);

        return u204, false;
    end;
end;

function u7.get_hotbar() -- Line: 1043
    -- upvalues: u7 (copy)
    return u7.getPlayerGui():FindFirstChild("Hotbar");
end;

function u7.pseudo_tween(p206: userdata, p207: number?, u208: function?) -- Line: 1047
    -- upvalues: trove (copy), TweenService (copy), RunService (copy)
    local u209 = type(u208) == "function";
    local u210 = p207 or 1;
    local u211 = trove.new();
    local NumberValue = Instance.new("NumberValue");
    NumberValue.Value = 1 - u210;
    u211:Add(NumberValue);
    local u212 = TweenService:Create(NumberValue, p206, {
        Value = u210
    });
    u212:Play();
    u211:Add(u212);
    u211:Connect(RunService.RenderStepped, function() -- Line: 1062
        -- upvalues: u209 (copy), u208 (copy), NumberValue (copy), u210 (ref), u212 (copy), u211 (copy)
        if u209 then
            u208(NumberValue.Value);
        end;

        if NumberValue.Value == u210 or u212.PlaybackState == Enum.PlaybackState.Completed then
            u211:Destroy();
        end;
    end);

    return NumberValue;
end;

script_ForgeVFX.init();
u7.forge = script_ForgeVFX;

return u7;