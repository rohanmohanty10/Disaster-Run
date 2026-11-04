 
 

local LocalPlayer = game:GetService("Players").LocalPlayer;
local TweenService = game:GetService("TweenService");
local Lighting = game:GetService("Lighting");
local RunService = game:GetService("RunService");
local l_script = script;
local u1 = nil;

local function getAnimId() -- Line: 26
    -- upvalues: u1 (ref), l_script (copy)
    if u1 then
        return u1;
    end;

    local v2 = l_script:FindFirstChild("SKELETON ARM");

    if v2 then
        v2 = v2:GetAttribute("AssetId");
    end;

    if v2 then
        u1 = "rbxassetid://" .. tostring(v2):gsub("%D", "");

        return u1;
    end;
end;

local u3 = require("@game/ReplicatedStorage/Shared/Utility/ForgeVFX");

local function emitAll(p4, p5) -- Line: 36
    -- upvalues: u3 (copy)
    if u3 then
        local v6;

        if p5 then
            v6 = p4:FindFirstChild(p5) or p4;
        else
            v6 = p4;
        end;

        if v6 then
            local success, result = pcall(u3.emit, v6);

            if success then
                return;
            end;

            warn("Forge emit failed, using the fallback: " .. tostring(result));
        end;
    end;

    for _, descendant in ipairs(p4:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") and (descendant.Name ~= "Old" and (not p5 or descendant.Parent.Name == p5)) then
            local u7 = descendant:GetAttribute("EmitCount") or 0;

            if u7 > 0 then
                local v8 = descendant:GetAttribute("EmitDelay") or 0;

                if v8 > 0 then
                    task.delay(v8, function() -- Line: 51
                        -- upvalues: descendant (copy), u7 (copy)
                        if descendant.Parent then
                            descendant:Emit(u7);
                        end;
                    end);
                else
                    descendant:Emit(u7);
                end;
            end;
        end;
    end;
end;

local function longestLife(p9) -- Line: 56
    local v10 = 0;

    for _, descendant in ipairs(p9:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            local v11 = descendant.Lifetime.Max + (descendant:GetAttribute("EmitDelay") or 0) + (descendant:GetAttribute("EmitDuration") or 0) + 0.5;
            v10 = math.max(v10, v11);
        end;
    end;

    return v10;
end;

local _ = CFrame.identity;

local function impactFrame(u12) -- Line: 71
    -- upvalues: Lighting (copy), TweenService (copy)
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.Name = "SkeletonArm_ImpactFrame";
    local BlurEffect = Instance.new("BlurEffect");
    BlurEffect.Name = "SkeletonArm_Blur";
    ColorCorrectionEffect.Saturation = -1;
    ColorCorrectionEffect.Contrast = 1.4 * u12;
    ColorCorrectionEffect.Brightness = -0.1 * u12;
    BlurEffect.Size = 22 * u12;
    ColorCorrectionEffect.Parent = Lighting;
    BlurEffect.Parent = Lighting;
    task.delay(0.045, function() -- Line: 77
        -- upvalues: ColorCorrectionEffect (copy), u12 (copy)
        ColorCorrectionEffect.Brightness = 0.22 * u12;
        ColorCorrectionEffect.Contrast = 0.8 * u12;
    end);
    task.delay(0.09, function() -- Line: 78
        -- upvalues: TweenService (ref), ColorCorrectionEffect (copy)
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Saturation = 0,
            Contrast = 0,
            Brightness = 0
        }):Play();
    end);
    TweenService:Create(BlurEffect, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = 0
    }):Play();
    game:GetService("Debris"):AddItem(ColorCorrectionEffect, 0.4);
    game:GetService("Debris"):AddItem(BlurEffect, 0.45);
end;

local u13 = {
    strength = 0.45,
    size = 0.3,
    inTime = 0.15,
    hold = 0.35,
    outTime = 0.8,
    color = Color3.fromRGB(20, 200, 160)
};
local u14 = nil;

local function vignette(p15) -- Line: 88
    -- upvalues: LocalPlayer (copy), u14 (ref), u13 (copy), TweenService (copy)
    local v16 = LocalPlayer:FindFirstChildOfClass("PlayerGui");

    if not v16 then
        return;
    end;

    if not (u14 and u14.gui.Parent) then
        local ScreenGui = Instance.new("ScreenGui");
        ScreenGui.Name = "SkeletonVignette";
        ScreenGui.IgnoreGuiInset = true;
        ScreenGui.ScreenInsets = Enum.ScreenInsets.None;
        ScreenGui.ResetOnSpawn = false;
        ScreenGui.DisplayOrder = 40;
        ScreenGui.Parent = v16;
        local u17 = {};
        local size = u13.size;

        local function edge(p18, p19, p20, p21) -- Line: 96
            -- upvalues: u13 (ref), ScreenGui (copy), u17 (copy)
            local Frame = Instance.new("Frame");
            Frame.AnchorPoint = p19;
            Frame.Position = p20;
            Frame.Size = p21;
            Frame.BackgroundColor3 = u13.color;
            Frame.BackgroundTransparency = 1;
            Frame.BorderSizePixel = 0;
            Frame.Parent = ScreenGui;
            local UIGradient = Instance.new("UIGradient");
            UIGradient.Rotation = p18;
            UIGradient.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.35, 0.6), NumberSequenceKeypoint.new(1, 1) });
            UIGradient.Parent = Frame;
            table.insert(u17, Frame);
        end;

        edge(0, Vector2.new(0, 0), UDim2.fromScale(0, 0), UDim2.fromScale(size, 1));
        edge(180, Vector2.new(1, 0), UDim2.fromScale(1, 0), UDim2.fromScale(size, 1));
        edge(90, Vector2.new(0, 0), UDim2.fromScale(0, 0), UDim2.fromScale(1, size));
        edge(-90, Vector2.new(0, 1), UDim2.fromScale(0, 1), UDim2.fromScale(1, size));
        u14 = {
            id = 0,
            gui = ScreenGui,
            edges = u17
        };
    end;

    local v22 = u14;
    v22.id = v22.id + 1;
    local id = u14.id;
    local v23 = 1 - (1 - u13.strength) * math.min(1, p15);

    for _, v in ipairs(u14.edges) do
        TweenService:Create(v, TweenInfo.new(u13.inTime, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            BackgroundTransparency = v23
        }):Play();
    end;

    task.delay(u13.inTime + u13.hold, function() -- Line: 116
        -- upvalues: u14 (ref), id (copy), TweenService (ref), u13 (ref)
        if u14.id ~= id then
            return;
        end;

        for _, v in ipairs(u14.edges) do
            TweenService:Create(v, TweenInfo.new(u13.outTime, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                BackgroundTransparency = 1
            }):Play();
        end;
    end);
end;

local function cameraHit(p24, p25) -- Line: 124
    -- upvalues: vignette (copy), impactFrame (copy)
    vignette(p24);
    impactFrame(p24);
end;

local u26 = { 0.03, 0.14 };
local u27 = { 0.8, 1.1 };
local u28 = { 8.5, 12 };
local u29 = { 1.3, 2.4 };
local u30 = { 1, 7 };

local function ghost(p31, p32, p33, p34, p35, p36) -- Line: 142
    -- upvalues: u29 (copy), u28 (copy), u30 (copy), u27 (copy), RunService (copy)
    local u37 = p36 or 1;
    local u38 = p31:Clone();

    if u37 ~= 1 then
        for _, descendant in ipairs(u38:GetDescendants()) do
            if descendant:IsA("Attachment") then
                descendant.Position = descendant.Position * u37;
            end;
        end;
    end;

    u38.Name = "Ghost";
    u38.Anchored = true;
    u38.CanCollide = false;
    u38.CanQuery = false;
    u38.CanTouch = false;
    u38.CastShadow = false;
    local u39 = u38:FindFirstChildWhichIsA("Trail", true);

    if u39 then
        u39.Enabled = false;
    end;

    local u40 = (p33 - 1) / 3 * 3.141592653589793 * 2 + p34:NextNumber(-0.9, 0.9) * 1;
    local u41 = p34:NextNumber(u29[1], u29[2]) * 3.141592653589793 * 2 * p35;
    local u42 = p34:NextNumber(u28[1], u28[2]) * u37;
    local u43 = u30[2] * p34:NextNumber(0.7, 1.15) * u37;
    local u44 = p34:NextNumber(u27[1], u27[2]) * (1 + (u37 - 1) * 0.15);
    local u45 = p34:NextNumber(0, 1000);
    local v46 = p34:NextNumber(-1, 1);
    local u47 = Vector3.new(v46, 0, p34:NextNumber(-1, 1)) * 1.6 * 1 * u37;
    local u48 = p32 + Vector3.new(0, -1.5 * u37, 0);

    local function posAt(p49) -- Line: 161
        -- upvalues: u40 (copy), u41 (copy), u45 (copy), u30 (ref), u37 (ref), u43 (copy), u42 (copy), u48 (copy), u47 (copy)
        local v50 = u40 + u41 * (p49 + math.noise(u45, p49 * 1.1) * 0.07 * 1);
        local v51 = (u30[1] * u37 + (u43 - u30[1] * u37) * p49 ^ 0.8) * (1 + math.noise(u45 + 11, p49 * 1.4) * 0.28 * 1);
        local v52 = (u42 + 4 * u37) * p49 ^ 0.9 + math.noise(u45 + 23, p49 * 1.5) * 0.7 * 1 * p49 * u37;
        local math_noise_ret = math.noise(u45 + 37, p49 * 0.9);
        local v53 = Vector3.new(math_noise_ret, 0, math.noise(u45 + 53, p49 * 0.9)) * 2.2 * 1 * p49 * u37;
        local v54 = math.cos(v50) * v51;
        local v55 = math.sin(v50) * v51;

        return u48 + u47 * p49 + v53 + Vector3.new(v54, v52, v55);
    end;

    local u56 = nil;

    local function frameAt(p57, p58) -- Line: 174
        -- upvalues: u48 (copy), u56 (ref)
        local Vector3_new_ret = Vector3.new(p57.X - u48.X, 0, p57.Z - u48.Z);
        local v59 = Vector3_new_ret.Magnitude > 0.001 and Vector3_new_ret.Unit or Vector3.new(1, 0, 0);
        local v60;

        if u56 then
            v60 = u56:Lerp(v59, 0.35) or v59;
        else
            v60 = v59;
        end;

        u56 = v60;

        if u56.Magnitude > 0.001 then
            v59 = u56.Unit or v59;
        end;

        local v61 = v59:Dot(p58.Unit);
        local v62 = math.abs(v61) > 0.98 and Vector3.new(0, 1, 0) or v59;

        return CFrame.lookAt(p57, p57 + p58, v62);
    end;

    local function at(p63) -- Line: 183
        -- upvalues: posAt (copy), frameAt (copy)
        local v64 = posAt(p63);
        local v65 = posAt((math.min(1, p63 + 0.01))) - posAt((math.max(0, p63 - 0.01)));
        local v66 = v65.Magnitude < 0.001 and Vector3.new(0, 1, 0) or v65;

        return frameAt(v64, v66), v64, v66;
    end;

    local v67 = posAt(0);
    local v68 = posAt(0.01) - posAt(0);
    u38.CFrame = frameAt(v67, v68.Magnitude < 0.001 and Vector3.new(0, 1, 0) or v68);
    u38.Parent = workspace;

    if u39 then
        u39.Enabled = true;
    end;

    local u69;

    if u39 then
        u69 = u39.Transparency;
    else
        u69 = u39;
    end;

    local function setFade(p70) -- Line: 194
        -- upvalues: u39 (copy), u69 (copy)
        if not u39 then
            return;
        end;

        local v71 = {};

        for _, v in ipairs(u69.Keypoints) do
            table.insert(v71, NumberSequenceKeypoint.new(v.Time, v.Value + (1 - v.Value) * p70, v.Envelope));
        end;

        u39.Transparency = NumberSequence.new(v71);
    end;

    local os_clock_ret = os.clock();
    local u72 = nil;
    local u73 = nil;
    local u74 = nil;
    local u75 = nil;
    u75 = RunService.RenderStepped:Connect(function(p76) -- Line: 205
        -- upvalues: os_clock_ret (copy), u44 (copy), u72 (ref), posAt (copy), frameAt (copy), u73 (ref), u74 (ref), u38 (copy), setFade (copy), u75 (ref), u39 (copy)
        local os_clock_ret2 = os.clock();
        local math_min_ret = math.min(1, (os_clock_ret2 - os_clock_ret) / u44);

        if u72 then
            local math_min_ret2 = math.min(1, (os_clock_ret2 - u72) / 0.4);
            u74 = (u74 or Vector3.new(0, 10, 0)) * math.exp(-p76 * 4);
            u38.CFrame = frameAt(u38.Position + u74 * p76, u74.Magnitude > 0.001 and u74 or Vector3.new(0, 1, 0));
            setFade(math_min_ret2 * math_min_ret2 * (3 - math_min_ret2 * 2));

            if math_min_ret2 >= 1 then
                u75:Disconnect();

                if u39 then
                    u39.Enabled = false;
                end;

                game:GetService("Debris"):AddItem(u38, 0.1);
            end;
        else
            local v77 = math_min_ret * (2 - math_min_ret) * 0.35 + math_min_ret * 0.65;
            local v78 = posAt(v77);
            local v79 = posAt((math.min(1, v77 + 0.01))) - posAt((math.max(0, v77 - 0.01)));
            local v80 = frameAt(v78, v79.Magnitude < 0.001 and Vector3.new(0, 1, 0) or v79);

            if u73 and p76 > 0 then
                u74 = (v78 - u73) / p76;
            end;

            u73 = v78;
            u38.CFrame = v80;

            if math_min_ret >= 1 then
                u72 = os_clock_ret2;
            end;
        end;
    end);
end;

local function releaseGhosts(p81, p82) -- Line: 230
    -- upvalues: l_script (copy), u26 (copy), ghost (copy)
    local v83 = l_script:FindFirstChild("Ghost Trail");

    if not v83 then
        return;
    end;

    local Random_new_ret = Random.new();
    local v84 = Random_new_ret:NextNumber() < 0.5 and -1 or 1;

    for i = 1, 3 do
        task.delay((i - 1) * Random_new_ret:NextNumber(u26[1], u26[2]) * 1.5, ghost, v83, p81, i, Random_new_ret, v84, p82);
        local _ = i;
    end;
end;

local function scaleNS(p85, p86) -- Line: 242
    local v87 = {};

    for _, v in ipairs(p85.Keypoints) do
        table.insert(v87, NumberSequenceKeypoint.new(v.Time, v.Value * p86, v.Envelope * p86));
    end;

    return NumberSequence.new(v87);
end;

local function scaleFx(p88, u89) -- Line: 247
    -- upvalues: scaleNS (copy)
    if u89 == 1 then
        return;
    end;

    if p88:IsA("BasePart") then
        p88.Size = p88.Size * u89;
    end;

    for _, descendant in ipairs(p88:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            descendant.Size = scaleNS(descendant.Size, u89);
            descendant.Speed = NumberRange.new(descendant.Speed.Min * u89, descendant.Speed.Max * u89);
            descendant.Acceleration = descendant.Acceleration * u89;
        elseif descendant:IsA("Attachment") then
            descendant.Position = descendant.Position * u89;
        elseif descendant:IsA("Beam") then
            descendant.Width0 = descendant.Width0 * u89;
            descendant.Width1 = descendant.Width1 * u89;
        elseif descendant:IsA("Light") then
            pcall(function() -- Line: 257
                -- upvalues: descendant (copy), u89 (copy)
                descendant.Range = math.min(60, descendant.Range * u89);
            end);
        end;
    end;
end;

local function scaledOffset(p90, p91) -- Line: 261
    return CFrame.new(p90.Position * p91) * p90.Rotation;
end;

return function(u92, u93, p94, p95) -- Line: 263, Name: play
    -- upvalues: l_script (copy), scaleFx (copy), emitAll (copy), u1 (ref), TweenService (copy), releaseGhosts (copy), LocalPlayer (copy), vignette (copy), impactFrame (copy), longestLife (copy)
    local u96 = tonumber(p95) or 1;
    local v97 = l_script:FindFirstChild("SKELETON ARM");
    local Spawn = l_script:FindFirstChild("Spawn");

    if not (v97 and Spawn) then
        return;
    end;

    local v98 = 0.16 * (u96 > 1 and 1.6 or 1);
    local u99 = 0.4 * (u96 > 1 and 1.5 or 1);
    local Vector3_new_ret = Vector3.new(p94.X - u93.X, 0, p94.Z - u93.Z);
    local v100 = Vector3_new_ret.Magnitude > 0.1 and CFrame.lookAt(Vector3.new(0, 0, 0), Vector3_new_ret.Unit) or CFrame.new();
    local v101 = CFrame.new(u93) * v100;
    local v102 = u96 > 1 and (u96 * 0.6666666666666666 or 1) or 1;
    local v103 = l_script:GetAttribute("ArmOffset") or CFrame.new(0, 4, 0);
    local v104 = v101 * (CFrame.new(v103.Position * u96) * v103.Rotation);
    local v105 = l_script:GetAttribute("FxOffset") or CFrame.new(0, 2, 0);
    local v106 = v101 * (CFrame.new(v105.Position * v102) * v105.Rotation);

    if u96 > 1 then
        local _, v107 = v97:GetBoundingBox();
        v104 = v104 - Vector3.new(0, v107.Y * u96 * 0.13, 0);
    end;

    local u108 = v97:Clone();
    u108.Name = "SkeletonArm";

    if u96 ~= 1 then
        pcall(function() -- Line: 283
            -- upvalues: u108 (copy), u96 (ref)
            u108:ScaleTo(u96);
        end);
    end;

    local v109 = u108.PrimaryPart or u108:FindFirstChild("RootPart");

    for _, descendant in ipairs(u108:GetDescendants()) do
        if descendant:IsA("BasePart") then
            descendant.CanCollide = false;
            descendant.CanQuery = false;
            descendant.CanTouch = false;
            descendant.Anchored = descendant == v109;
        end;
    end;

    local _, v110 = u108:GetBoundingBox();
    local _, v111 = v97:GetBoundingBox();
    local v112 = math.max(v110.Y, v111.Y * u96) + 2;
    local u113 = v104 - Vector3.new(0, v112, 0);
    u108:PivotTo(u113);
    u108.Parent = workspace;
    local u114 = Spawn:Clone();
    u114.Anchored = true;
    u114.CanCollide = false;
    u114.CanQuery = false;
    u114.CanTouch = false;
    u114.Transparency = 1;
    u114.CFrame = v106;
    scaleFx(u114, v102);
    u114.Parent = workspace;
    emitAll(u114);
    local u115 = u108:FindFirstChildOfClass("AnimationController") or u108:FindFirstChildOfClass("Humanoid");

    if u115 then
        u115 = u115:FindFirstChildOfClass("Animator") or Instance.new("Animator", u115);
    end;

    local u116 = nil;
    local v117 = 0.72;
    local v118;

    if u1 then
        v118 = u1;
    else
        local v119 = l_script:FindFirstChild("SKELETON ARM");

        if v119 then
            v119 = v119:GetAttribute("AssetId");
        end;

        if v119 then
            u1 = "rbxassetid://" .. tostring(v119):gsub("%D", "");
            v118 = u1;
        else
            v118 = nil;
        end;
    end;

    if u115 and v118 then
        local Animation = Instance.new("Animation");
        Animation.AnimationId = v118;
        local success, result = pcall(function() -- Line: 310
            -- upvalues: u115 (copy), Animation (copy)
            return u115:LoadAnimation(Animation);
        end);

        if success and result then
            u116 = result;
            u116.Looped = false;
            u116.Priority = Enum.AnimationPriority.Action;
            u116:Play(0, 1, 0);

            if u116.Length > 0 then
                v117 = u116.Length;
            end;
        end;

        Animation:Destroy();
    end;

    local CFrameValue = Instance.new("CFrameValue");
    CFrameValue.Value = u113;
    CFrameValue.Changed:Connect(function(p120) -- Line: 323
        -- upvalues: u108 (copy)
        if u108.Parent then
            u108:PivotTo(p120);
        end;
    end);
    TweenService:Create(CFrameValue, TweenInfo.new(v98, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        Value = v104
    }):Play();
    task.delay(v98 * 0.6, function() -- Line: 325
        -- upvalues: u116 (ref)
        if u116 then
            u116:AdjustSpeed(0.75);
        end;
    end);
    task.delay(0.03, releaseGhosts, u93, v102);
    task.delay(0.06, function() -- Line: 331
        -- upvalues: LocalPlayer (ref), u92 (copy), u93 (copy), u96 (ref), vignette (ref), impactFrame (ref)
        local v121 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart");
        local v122;

        if u92 == LocalPlayer then
            v122 = 1;
        else
            local v123 = v121 and (v121.Position - u93).Magnitude or (1 / 0);

            if v123 > 160 then
                return;
            end;

            v122 = math.clamp(1 - v123 / (160 * (u96 > 1 and 1.8 or 1)), 0.2, 0.75);
        end;

        if u92 == LocalPlayer then
            local v124 = v122 * (u96 > 1 and 1.3 or 1);
            vignette(v124);
            impactFrame(v124);
        end;
    end);
    task.delay(v98 * 0.6 + v117 / 0.75 - 0.03, function() -- Line: 345
        -- upvalues: u116 (ref), emitAll (ref), u114 (copy), TweenService (ref), CFrameValue (copy), u99 (copy), u113 (copy), u108 (copy), longestLife (ref)
        if u116 then
            u116:AdjustSpeed(0);
        end;

        task.wait(0.12);
        emitAll(u114, "Specs");
        TweenService:Create(CFrameValue, TweenInfo.new(u99, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Value = u113
        }):Play();
        task.wait(u99 + 0.05);

        if u116 then
            u116:Stop(0);
        end;

        u108:Destroy();
        CFrameValue:Destroy();
        task.delay(longestLife(u114), function() -- Line: 353
            -- upvalues: u114 (ref)
            u114:Destroy();
        end);
    end);
end;