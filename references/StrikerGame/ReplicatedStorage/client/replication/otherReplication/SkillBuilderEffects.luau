 

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local TextService = game:GetService("TextService");
require(ReplicatedStorage.util.vfxUtil);
require(ReplicatedStorage.wiki);
local mainreplication = require(ReplicatedStorage.client.replication.mainreplication);
local trove = require(ReplicatedStorage:WaitForChild("forum"):WaitForChild("trove"));
local vfxUtil = require(ReplicatedStorage.util.vfxUtil);
local TekrinnDialogue = require(ReplicatedStorage.client.replication.TekrinnDialogue);
local actionUtil = require(ReplicatedStorage.util.actionUtil);
local workspace2 = ReplicatedStorage:WaitForChild("workspace");
local Players = game:GetService("Players");
local BackgroundHighlightSKILLBUILDER = require(ReplicatedStorage.client.replication.BackgroundHighlightSKILLBUILDER);
local workspace_CurrentCamera = workspace.CurrentCamera;
local u1 = {};

local function parseColor(p2, p3, p4) -- Line: 23
    return ((p2 > 1 or p3 > 1) and true or p4 > 1) and Color3.fromRGB(p2, p3, p4) or Color3.new(p2, p3, p4);
end;

local AssetService = game:GetService("AssetService");
local u5 = {};
local u6 = {};

local function filter_string(u7, u8) -- Line: 32
    -- upvalues: u6 (copy), TextService (copy)
    if u6[u7] then
        return u6[u7];
    end;

    local success, result = pcall(function() -- Line: 36
        -- upvalues: TextService (ref), u7 (copy), u8 (copy)
        return TextService:FilterStringAsync(u7, u8);
    end);
    print(result);

    if not success then
        return "filter failed";
    end;

    local NonChatStringForBroadcastAsync = result:GetNonChatStringForBroadcastAsync();

    if success then
        u6[u7] = NonChatStringForBroadcastAsync;
    end;

    return success and NonChatStringForBroadcastAsync and NonChatStringForBroadcastAsync or "filter failed";
end;

local function check_type(u9: string) -- Line: 50
    local u10 = nil;
    local u11 = false;
    local u12 = nil;

    return pcall(function() -- Line: 55
        -- upvalues: u9 (copy), u11 (ref), u10 (ref), u12 (ref)
        local buffer_fromstring_ret = buffer.fromstring(u9);
        local success, _ = pcall(function() -- Line: 58
            -- upvalues: buffer_fromstring_ret (ref)
            buffer_fromstring_ret = game:GetService("EncodingService"):Base64Decode(buffer_fromstring_ret);
        end);

        if success then
            local _, _ = pcall(function() -- Line: 63
                -- upvalues: buffer_fromstring_ret (ref)
                buffer_fromstring_ret = game:GetService("EncodingService"):DecompressBuffer(buffer_fromstring_ret, Enum.CompressionAlgorithm.Zstd);
            end);
        end;

        local success2, result = pcall(function() -- Line: 68
            -- upvalues: buffer_fromstring_ret (ref)
            return game:GetService("HttpService"):JSONDecode(buffer.tostring(buffer_fromstring_ret));
        end);

        if success2 then
            u11 = true;
            u10 = u9;
            u12 = result;
        else
            local success3, result2 = pcall(function() -- Line: 77
                -- upvalues: u9 (ref)
                return game:GetService("HttpService"):JSONDecode(u9);
            end);

            if success3 then
                u12 = result2;
                local buffer_fromstring_ret2 = buffer.fromstring(u9);
                local _, _ = pcall(function() -- Line: 86
                    -- upvalues: buffer_fromstring_ret2 (ref)
                    buffer_fromstring_ret2 = game:GetService("EncodingService"):CompressBuffer(buffer_fromstring_ret2, Enum.CompressionAlgorithm.Zstd);
                end);
                local _, _ = pcall(function() -- Line: 90
                    -- upvalues: buffer_fromstring_ret2 (ref)
                    buffer_fromstring_ret2 = game:GetService("EncodingService"):Base64Encode(buffer_fromstring_ret2);
                end);
                u10 = buffer.tostring(buffer_fromstring_ret2);
            end;
        end;

        return u11, u10, u9, u12;
    end);
end;

function u1.CustomHighlight(p13: any, p14: table) -- Line: 103
    -- upvalues: TweenService (copy)
    local Highlight = Instance.new("Highlight");
    local v15 = p14.Color[2];
    local v16 = p14.Color[3];
    local v17 = p14.Color[4];
    Highlight.FillColor = ((v15 > 1 or v16 > 1) and true or v17 > 1) and Color3.fromRGB(v15, v16, v17) or Color3.new(v15, v16, v17);
    local v18 = p14.OutlineColor[2];
    local v19 = p14.OutlineColor[3];
    local v20 = p14.OutlineColor[4];
    Highlight.OutlineColor = ((v18 > 1 or v19 > 1) and true or v20 > 1) and Color3.fromRGB(v18, v19, v20) or Color3.new(v18, v19, v20);
    Highlight.FillTransparency = 1;
    Highlight.OutlineTransparency = 1;
    Highlight.Parent = p13;
    local v21 = p14.Opacity or 0.5;
    local v22 = p14.OutlineOpacity or 0.5;
    TweenService:Create(Highlight, TweenInfo.new(p14.FadeIn, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
        FillTransparency = v21,
        OutlineTransparency = v22
    }):Play();
    task.wait(p14.FadeIn + p14.WaitPeriod);
    TweenService:Create(Highlight, TweenInfo.new(p14.FadeOut, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
        FillTransparency = 1,
        OutlineTransparency = 1
    }):Play();
    task.wait(p14.FadeOut);
    pcall(game.Destroy, Highlight);
end;

function u1.SkillbuilderCC(p23: any, p24: table) -- Line: 121
    -- upvalues: TweenService (copy)
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.Parent = game:GetService("Lighting");
    local v25 = p24.FadeOutTime or 0;

    if not p24.FadeIn then
        local v26 = p24.TintColor[2];
        local v27 = p24.TintColor[3];
        local v28 = p24.TintColor[4];
        ColorCorrectionEffect.TintColor = ((v26 > 1 or v27 > 1) and true or v28 > 1) and Color3.fromRGB(v26, v27, v28) or Color3.new(v26, v27, v28);
        ColorCorrectionEffect.Saturation = p24.Saturation;
        ColorCorrectionEffect.Contrast = p24.Contrast;
        ColorCorrectionEffect.Brightness = p24.Brightness;
        task.wait(p24.Lifetime);

        if v25 == 0 then
            pcall(game.Destroy, ColorCorrectionEffect);

            return;
        end;

        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(v25, Enum.EasingStyle[p24.EasingStyle[2]], Enum.EasingDirection[p24.EasingDirection[2]]), {
            Brightness = 0,
            Contrast = 0,
            Saturation = 0,
            TintColor = Color3.new(1, 1, 1)
        }):Play();
        task.wait(v25);
        pcall(game.Destroy, ColorCorrectionEffect);

        return;
    end;

    local TweenInfo_new_ret = TweenInfo.new(p24.FadeTime, Enum.EasingStyle[p24.EasingStyle[2]], Enum.EasingDirection[p24.EasingDirection[2]]);
    local v29 = {};
    local v30 = p24.TintColor[2];
    local v31 = p24.TintColor[3];
    local v32 = p24.TintColor[4];
    v29.TintColor = ((v30 > 1 or v31 > 1) and true or v32 > 1) and Color3.fromRGB(v30, v31, v32) or Color3.new(v30, v31, v32);
    v29.Brightness = p24.Brightness;
    v29.Contrast = p24.Contrast;
    v29.Saturation = p24.Saturation;
    TweenService:Create(ColorCorrectionEffect, TweenInfo_new_ret, v29):Play();
    task.wait(p24.FadeTime + p24.Lifetime);

    if v25 == 0 then
        pcall(game.Destroy, ColorCorrectionEffect);

        return;
    end;

    TweenService:Create(ColorCorrectionEffect, TweenInfo.new(v25, Enum.EasingStyle[p24.EasingStyle[2]], Enum.EasingDirection[p24.EasingDirection[2]]), {
        Brightness = 0,
        Contrast = 0,
        Saturation = 0,
        TintColor = Color3.new(1, 1, 1)
    }):Play();
    task.wait(v25);
    pcall(game.Destroy, ColorCorrectionEffect);
end;

function u1.Overlay(p33: any, p34: table) -- Line: 172
    -- upvalues: Players (copy), TweenService (copy)
    local v35 = script.OverlayGui:Clone();
    v35.ImageLabel.ImageTransparency = 1;
    v35.ImageLabel.Image = p34.ImageID[2];
    local v36 = p34.TintColor[2];
    local v37 = p34.TintColor[3];
    local v38 = p34.TintColor[4];
    v35.ImageLabel.ImageColor3 = ((v36 > 1 or v37 > 1) and true or v38 > 1) and Color3.fromRGB(v36, v37, v38) or Color3.new(v36, v37, v38);
    v35.ImageLabel.Size = UDim2.fromScale(p34.ScaleX or 1, p34.ScaleY or 1);
    v35.ImageLabel.Position = UDim2.fromScale(p34.PositionX or 0.5, p34.PositionY or 0.5);
    v35.Parent = Players.LocalPlayer.PlayerGui;
    local v39 = TweenService:Create(v35.ImageLabel, TweenInfo.new(p34.FadeIn, Enum.EasingStyle[p34.FadeInEasing[2]], Enum.EasingDirection[p34.FadeInEasingDirection[2]]), {
        ImageTransparency = p34.ImageTransparency
    });
    local v40 = TweenService:Create(v35.ImageLabel, TweenInfo.new(p34.FadeOut, Enum.EasingStyle[p34.FadeOutEasing[2]], Enum.EasingDirection[p34.FadeOutEasingDirection[2]]), {
        ImageTransparency = 1
    });
    v39:Play();
    task.wait(p34.FadeIn);
    task.wait(p34.Lifetime);
    v40:Play();
    task.wait(p34.FadeOut);
    pcall(game.Destroy, v35);
end;

function u1.Afterimage(p41: any, p42: table) -- Line: 197
    -- upvalues: BackgroundHighlightSKILLBUILDER (copy)
    BackgroundHighlightSKILLBUILDER(p41, p42);
end;

function u1.SB_Flash(p43, p44) -- Line: 203
    -- upvalues: mainreplication (copy)
    local v45 = p44.Color[2];
    local v46 = p44.Color[3];
    local v47 = p44.Color[4];
    print(p44.Brightness, p44.Length, ((v45 > 1 or v46 > 1) and true or v47 > 1) and Color3.fromRGB(v45, v46, v47) or Color3.new(v45, v46, v47));
    local v48 = p44.Color[2];
    local v49 = p44.Color[3];
    local v50 = p44.Color[4];
    mainreplication.ultFlash(p44.Brightness, p44.Length, nil, ((v48 > 1 or v49 > 1) and true or v50 > 1) and Color3.fromRGB(v48, v49, v50) or Color3.new(v48, v49, v50));
end;

function u1.FOV(p51, p52) -- Line: 210
    -- upvalues: mainreplication (copy)
    mainreplication.fov(p52.FadeIn, p52.FOV, p52.FadeTime, Enum[p52.EasingStyle[4]][p52.EasingStyle[2]], Enum[p52.EasingDirection[4]][p52.EasingDirection[2]]);
end;

function u1.SpringCameraShake(p53, p54) -- Line: 219
    -- upvalues: u1 (copy)
    task.spawn(u1.SBSpringCameraShake, p53, p54);
end;

function u1.SBSpringCameraShake(p55, p56) -- Line: 223
    -- upvalues: mainreplication (copy)
    mainreplication.springcamerashake(p56.Strength, p56.Sharpness, p56.ShakeTime);
end;

function u1.SBCameraShake(p57, p58) -- Line: 229
    -- upvalues: mainreplication (copy)
    mainreplication.cameraShake(p58.Roughness, p58.Duration, p58.Rate);
end;

function u1.BigShockwave(p59, p60) -- Line: 234
    -- upvalues: mainreplication (copy)
    if p59:FindFirstChild("HumanoidRootPart") then
        mainreplication.biggershockwave(p59:FindFirstChild("HumanoidRootPart"));
    end;
end;

function u1.PlayerTransparency(p61: any, p62: table) -- Line: 240
    -- upvalues: TweenService (copy)
    local v63 = {};
    local u64 = {};

    for _, descendant in p61:GetDescendants() do
        if (descendant:IsA("BasePart") or descendant:IsA("Decal")) and descendant.Name ~= "HumanoidRootPart" then
            if not descendant:GetAttribute("OriginalTransparency") then
                descendant:SetAttribute("OriginalTransparency", descendant.Transparency);
            end;

            table.insert(v63, descendant);
        end;

        if descendant:IsA("SurfaceGui") and descendant.Name == "BackDecal" then
            task.spawn(function() -- Line: 261
                -- upvalues: descendant (copy), u64 (copy)
                if not descendant.DisplayName:GetAttribute("OriginalTransparency") then
                    descendant.DisplayName:SetAttribute("OriginalTransparency", descendant.DisplayName.TextTransparency);
                end;

                if not descendant.DisplayName.UIStroke:GetAttribute("OriginalTransparency") then
                    descendant.DisplayName.UIStroke:SetAttribute("OriginalTransparency", descendant.DisplayName.UIStroke.Transparency);
                end;

                if not descendant.Number:GetAttribute("OriginalTransparency") then
                    descendant.Number:SetAttribute("OriginalTransparency", descendant.Number.TextTransparency);
                end;

                if not descendant.Number.UIStroke:GetAttribute("OriginalTransparency") then
                    descendant.Number.UIStroke:SetAttribute("OriginalTransparency", descendant.Number.UIStroke.Transparency);
                end;

                table.insert(u64, descendant.Number);
                table.insert(u64, descendant.DisplayName);
                table.insert(u64, descendant.Number.UIStroke);
                table.insert(u64, descendant.DisplayName.UIStroke);
            end);
        end;
    end;

    for _, v in v63 do
        local Attribute = v:GetAttribute("OriginalTransparency");
        local TweenInfo_new_ret = TweenInfo.new(p62.FadeTime, Enum[p62.EasingStyle[4]][p62.EasingStyle[2]], Enum[p62.EasingDirection[4]][p62.EasingDirection[2]]);
        local v65 = {};
        local math_clamp_ret = math.clamp(p62.Transparency / 1, 0, 1);
        v65.Transparency = math.lerp(Attribute, 1, math_clamp_ret);
        TweenService:Create(v, TweenInfo_new_ret, v65):Play();
    end;

    for _, v in u64 do
        local Attribute = v:GetAttribute("OriginalTransparency");
        local v66;

        if v:IsA("TextLabel") then
            v66 = {};
            local math_clamp_ret = math.clamp(p62.Transparency / 1, 0, 1);
            v66.TextTransparency = math.lerp(Attribute, 1, math_clamp_ret);
        else
            v66 = {};
            local math_clamp_ret = math.clamp(p62.Transparency / 1, 0, 1);
            v66.Transparency = math.lerp(Attribute, 1, math_clamp_ret);
        end;

        TweenService:Create(v, TweenInfo.new(p62.FadeTime, Enum[p62.EasingStyle[4]][p62.EasingStyle[2]], Enum[p62.EasingDirection[4]][p62.EasingDirection[2]]), v66):Play();
    end;

    task.wait(p62.FadeTime + p62.Lifetime);

    if not p62.DontFadeOut then
        for _, v in v63 do
            local Attribute = v:GetAttribute("OriginalTransparency");
            TweenService:Create(v, TweenInfo.new(p62.FadeOutTime, Enum[p62.EasingStyle[4]][p62.EasingStyle[2]], Enum[p62.EasingDirection[4]][p62.EasingDirection[2]]), {
                Transparency = Attribute
            }):Play();
        end;

        for _, v in u64 do
            local Attribute = v:GetAttribute("OriginalTransparency");
            local v67 = v:IsA("TextLabel") and {
                TextTransparency = Attribute
            } or {
                Transparency = Attribute
            };
            TweenService:Create(v, TweenInfo.new(p62.FadeTime, Enum[p62.EasingStyle[4]][p62.EasingStyle[2]], Enum[p62.EasingDirection[4]][p62.EasingDirection[2]]), v67):Play();
        end;
    end;
end;

local u68 = {};
local u69 = {};

local function FETCHPARTICLE(p70) -- Line: 327
    -- upvalues: ReplicatedStorage (copy)
    local Resources = ReplicatedStorage.Resources;
    local v71 = false;

    for _, v in string.split(p70, "/") do
        if not Resources:FindFirstChild(v) then
            v71 = true;
            break;
        end;

        Resources = Resources:FindFirstChild(v);
    end;

    if v71 or not Resources then
        Resources = nil;
    end;

    return Resources;
end;

local function FETCHMESHPARTICLE(p72) -- Line: 341
    -- upvalues: ReplicatedStorage (copy)
    local Resources = ReplicatedStorage.Resources;
    local v73 = false;
    p72 = p72;
    local u74;

    if tonumber(p72) then
        u74 = "rbxassetid://" .. p72;
    end;

    if Resources:FindFirstChild("CustomMeshes") and Resources.CustomMeshes:FindFirstChild(u74) then
        return Resources.CustomMeshes:FindFirstChild(u74);
    end;

    for _, v in string.split(p72, "/") do
        if not Resources:FindFirstChild(v) then
            v73 = true;
            break;
        end;

        Resources = Resources:FindFirstChild(v);
    end;

    if v73 then
        local success, result = pcall(function() -- Line: 365
            -- upvalues: u74 (ref)
            return game:GetService("AssetService"):CreateMeshPartAsync(u74);
        end);

        if success then
            local v75 = ReplicatedStorage.Resources:FindFirstChild("CustomMeshes") or Instance.new("Folder");

            if v75.Parent ~= ReplicatedStorage.Resources then
                v75.Name = "CustomMeshes";
                v75.Parent = ReplicatedStorage.Resources;
            end;

            result.Name = p72;
            result.Anchored = true;
            result.CanQuery = false;
            result.CanCollide = false;
            result.Parent = v75;
        end;
    end;

    if v73 or not Resources then
        Resources = nil;
    end;

    return Resources;
end;

function u1.EmitSB(u76: any, p77: table) -- Line: 386
    -- upvalues: trove (copy), u68 (copy), FETCHPARTICLE (copy), vfxUtil (copy), RunService (copy), workspace_CurrentCamera (copy)
    local v78 = p77.Particle[2];
    local u79 = p77.Part[2];
    local u80 = nil;
    local u81 = trove.new();
    u81:AttachToInstance(u76);
    local PlayerFromCharacter = game:GetService("Players"):GetPlayerFromCharacter(u76);
    local CFrame_new_ret = CFrame.new(-p77.Offset[2], p77.Offset[3], -p77.Offset[4]);
    local CFrame_Angles_ret = CFrame.Angles(math.rad(p77.Rotation[2]), math.rad(p77.Rotation[3]), (math.rad(p77.Rotation[4])));
    local math_clamp_ret = math.clamp(p77.Color[2], 0, 255);
    local math_clamp_ret2 = math.clamp(p77.Color[3], 0, 255);
    local math_clamp_ret3 = math.clamp(p77.Color[4], 0, 255);
    local v82 = ((math_clamp_ret > 1 or math_clamp_ret2 > 1) and true or math_clamp_ret3 > 1) and Color3.fromRGB(math_clamp_ret, math_clamp_ret2, math_clamp_ret3) or Color3.new(math_clamp_ret, math_clamp_ret2, math_clamp_ret3);
    local v83 = p77.ZoneName and (p77.ZoneName[2] or "") or "";
    local u84;

    if v83 == "" or not PlayerFromCharacter then
        u84 = nil;
    else
        u84 = workspace.Effects:FindFirstChild(string.format("%s_%s_zone", tostring(PlayerFromCharacter.UserId), v83));
    end;

    if u79 == "Zone" and not u84 then
        return;
    end;

    local Ball = workspace.Terrain:FindFirstChild("Ball");

    if not Ball then
        for _, child in workspace.characters:GetChildren() do
            if child:FindFirstChild("Ball") then
                Ball = child:FindFirstChild("Ball");
            end;
        end;
    end;

    if u79 == "Ball" and not Ball then
        return;
    end;

    if u68[v78] then
        u80 = u68[v78]:Clone();
    else
        u68[v78] = FETCHPARTICLE(v78);

        if u68[v78] then
            u80 = u68[v78]:Clone();
        end;
    end;

    if not u80 then
        return;
    end;

    u81:Add(u80);
    local Model = Instance.new("Model");
    Model.PrimaryPart = u80;
    u80.Parent = Model;
    u80.Name = "ParticlePart";

    for _, descendant in Model:GetDescendants() do
        if descendant:IsA("BasePart") then
            descendant.Transparency = 1;
            descendant.CanCollide = false;
            descendant.CanTouch = false;
            descendant.Massless = true;
            descendant.Anchored = true;
        end;
    end;

    Model.Parent = workspace.Effects;

    for _, descendant in u80:GetDescendants() do
        if descendant:IsA("ParticleEmitter") then
            descendant.TimeScale = p77.Speed;
        end;
    end;

    Model:ScaleTo(p77.Scale);

    for _, descendant in Model:GetDescendants() do
        if descendant:IsA("ParticleEmitter") then
            vfxUtil.LeanTowardsColor(descendant, v82, (math.clamp(p77.ColorPower, 0, 1)));
        end;
    end;

    if p77.isAttached then
        u81:Add(RunService.PreRender:Connect(function(p85) -- Line: 466
            -- upvalues: Ball (ref), u79 (copy), CFrame_new_ret (copy), CFrame_Angles_ret (copy), u84 (ref), workspace_CurrentCamera (ref), u76 (copy), Model (copy)
            Ball = workspace.Terrain:FindFirstChild("Ball");

            if not Ball then
                for _, child in workspace.characters:GetChildren() do
                    if child:FindFirstChild("Ball") then
                        Ball = child:FindFirstChild("Ball");
                    end;
                end;
            end;

            if u79 == "Ball" and not Ball then
                return;
            end;

            local v86 = u79 == "Ball" and CFrame.new(Ball.Position) * CFrame_new_ret * CFrame_Angles_ret or (u79 == "Zone" and u84.CFrame * CFrame_new_ret * CFrame_Angles_ret or u79 == "Camera" and workspace_CurrentCamera.CFrame * CFrame_new_ret * CFrame_Angles_ret) or u76 and u76:FindFirstChild(u79) and u76:FindFirstChild(u79).CFrame * CFrame_new_ret * CFrame_Angles_ret;
            Model:PivotTo(v86 or Model.WorldPivot);
        end));
    else
        local v87 = u79 == "Ball" and CFrame.new(Ball.Position) * CFrame_new_ret * CFrame_Angles_ret or (u79 == "Zone" and u84.CFrame * CFrame_new_ret * CFrame_Angles_ret or u79 == "Camera" and workspace_CurrentCamera.CFrame * CFrame_new_ret * CFrame_Angles_ret) or u76 and u76:FindFirstChild(u79) and u76:FindFirstChild(u79).CFrame * CFrame_new_ret * CFrame_Angles_ret;
        Model:PivotTo(v87 or Model.WorldPivot);
        u80.Anchored = true;
    end;

    if p77.Emits then
        for _, descendant in u80:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(descendant:GetAttribute("EmitCount") or 1);
            end;
        end;

        u81:Add(task.delay(p77.Duration, function() -- Line: 496
            -- upvalues: u81 (copy)
            u81:Destroy();
        end));
    else
        for _, descendant in u80:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        u81:Add(task.delay(p77.Duration, function() -- Line: 505
            -- upvalues: u80 (ref), u81 (copy)
            for _, descendant in u80:GetDescendants() do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;

            u81:Add(task.delay(10, function() -- Line: 511
                -- upvalues: u81 (ref)
                u81:Destroy();
            end));
        end));
    end;
end;

function u1.MeshEmitSB(u88: any, p89: table) -- Line: 567
    -- upvalues: trove (copy), u69 (copy), FETCHMESHPARTICLE (copy), TweenService (copy), RunService (copy), workspace_CurrentCamera (copy)
    local v90 = p89.Particle[2];
    local u91 = p89.Part[2];
    local u92 = nil;
    local CFrame_new_ret = CFrame.new(-p89.StartOffset[2], p89.StartOffset[3], -p89.StartOffset[4]);
    local Vector3_new_ret = Vector3.new(p89.StartSize[2], p89.StartSize[3], p89.StartSize[4]);
    local CFrame_Angles_ret = CFrame.Angles(math.rad(p89.StartRotation[2]), math.rad(p89.StartRotation[3]), (math.rad(p89.StartRotation[4])));
    local math_clamp_ret = math.clamp(p89.StartColor[2], 0, 255);
    local math_clamp_ret2 = math.clamp(p89.StartColor[3], 0, 255);
    local math_clamp_ret3 = math.clamp(p89.StartColor[4], 0, 255);
    local v93 = ((math_clamp_ret > 1 or math_clamp_ret2 > 1) and true or math_clamp_ret3 > 1) and Color3.fromRGB(math_clamp_ret, math_clamp_ret2, math_clamp_ret3) or Color3.new(math_clamp_ret, math_clamp_ret2, math_clamp_ret3);
    local v94 = p89.StartTransparency or 0;
    local CFrame_new_ret2 = CFrame.new(-p89.EndOffset[2], p89.EndOffset[3], -p89.EndOffset[4]);
    local CFrame_Angles_ret2 = CFrame.Angles(math.rad(p89.EndRotation[2]), math.rad(p89.EndRotation[3]), (math.rad(p89.EndRotation[4])));
    local math_clamp_ret4 = math.clamp(p89.EndColor[2], 0, 255);
    local math_clamp_ret5 = math.clamp(p89.EndColor[3], 0, 255);
    local math_clamp_ret6 = math.clamp(p89.EndColor[4], 0, 255);
    local v95 = ((math_clamp_ret4 > 1 or math_clamp_ret5 > 1) and true or math_clamp_ret6 > 1) and Color3.fromRGB(math_clamp_ret4, math_clamp_ret5, math_clamp_ret6) or Color3.new(math_clamp_ret4, math_clamp_ret5, math_clamp_ret6);
    local v96 = p89.EndTransparency or 0;
    local Vector3_new_ret2 = Vector3.new(p89.EndSize[2], p89.EndSize[3], p89.EndSize[4]);
    local Repeats = p89.Repeats;
    local v97 = Repeats and (p89.RepeatCount or 1) or 1;
    local _ = Repeats and p89.RepeatInterval;
    local PlayerFromCharacter = game:GetService("Players"):GetPlayerFromCharacter(u88);
    local v98 = p89.ZoneName and (p89.ZoneName[2] or "") or "";
    local u99;

    if v98 == "" or not PlayerFromCharacter then
        u99 = nil;
    else
        u99 = workspace.Effects:FindFirstChild(string.format("%s_%s_zone", tostring(PlayerFromCharacter.UserId), v98));
    end;

    if u91 == "Zone" and not u99 then
        return;
    end;

    local Ball = workspace.Terrain:FindFirstChild("Ball");

    if not Ball then
        for _, child in workspace.characters:GetChildren() do
            if child:FindFirstChild("Ball") then
                Ball = child:FindFirstChild("Ball");
            end;
        end;
    end;

    if u91 == "Ball" and not Ball then
        return;
    end;

    local v100 = trove.new();
    v100:AttachToInstance(u88);

    for i = 1, v97 do
        if u69[v90] then
            u92 = u69[v90];
        else
            u69[v90] = FETCHMESHPARTICLE(v90);

            if u69[v90] then
                u92 = u69[v90];
            end;
        end;

        if not u92 then
            print("failed here");
            break;
        end;

        local MeshId = u92.MeshId;
        u92 = game:GetService("AssetService"):CreateMeshPartAsync(MeshId);
        local u101 = {
            offset = {
                start = CFrame_new_ret,
                finish = CFrame_new_ret2,
                value = v100:Add(Instance.new("NumberValue")),
                EasingDirection = p89.EasingDirectionForOffset[2],
                EasingStyle = p89.EasingStyleForOffset[2],
                timer = p89.OffsetTime
            },
            rotation = {
                start = CFrame_Angles_ret,
                finish = CFrame_Angles_ret2,
                value = v100:Add(Instance.new("NumberValue")),
                EasingDirection = p89.EasingDirectionForRotation[2],
                EasingStyle = p89.EasingStyleForRotation[2],
                timer = p89.RotationTime
            },
            color = {
                start = v93,
                finish = v95,
                value = v100:Add(Instance.new("NumberValue")),
                EasingDirection = p89.EasingDirectionForColor[2],
                EasingStyle = p89.EasingStyleForColor[2],
                timer = p89.ColorTime
            },
            transparency = {
                start = v94,
                finish = v96,
                value = v100:Add(Instance.new("NumberValue")),
                EasingDirection = p89.EasingDirectionForTransparency[2],
                EasingStyle = p89.EasingStyleForTransparency[2],
                timer = p89.TransparencyTime
            },
            size = {
                start = Vector3_new_ret,
                finish = Vector3_new_ret2,
                value = v100:Add(Instance.new("NumberValue")),
                EasingDirection = p89.EasingDirectionForSize[2],
                EasingStyle = p89.EasingStyleForSize[2],
                timer = p89.SizeTime
            }
        };
        local _ = i;

        for _, v in u101 do
            TweenService:Create(v.value, TweenInfo.new(v.timer, Enum.EasingStyle[v.EasingStyle], Enum.EasingDirection[v.EasingDirection]), {
                Value = 1
            }):Play();
        end;

        u92.Size = Vector3_new_ret;
        u92.Color = v93;

        if p89.TextureID[2] ~= "" then
            u92.TextureID = p89.TextureID[2];
        end;

        u92.Material = Enum[p89.Material[4]][p89.Material[2]];
        v100:Add(u92);
        local Model = Instance.new("Model");
        Model.PrimaryPart = u92;
        u92.Parent = Model;
        u92.Name = "ParticlePart";

        for _, descendant in Model:GetDescendants() do
            if descendant:IsA("BasePart") then
                descendant.Transparency = 1;
                descendant.CanCollide = false;
                descendant.CanTouch = false;
                descendant.Massless = true;
                descendant.Anchored = true;
            end;
        end;

        Model.Parent = workspace.Effects;

        if p89.isAttached then
            v100:Add(RunService.PreRender:Connect(function(p102) -- Line: 730
                -- upvalues: u101 (copy), u92 (ref), Ball (ref), u91 (copy), u99 (ref), workspace_CurrentCamera (ref), u88 (copy), Model (copy)
                local v103 = u101.offset.start:Lerp(u101.offset.finish, u101.offset.value.Value);
                local v104 = u101.rotation.start:Lerp(u101.rotation.finish, u101.rotation.value.Value);

                if u92 then
                    u92.Transparency = math.lerp(u101.transparency.start, u101.transparency.finish, u101.transparency.value.Value);
                    u92.Size = u101.size.start:Lerp(u101.size.finish, u101.size.value.Value);
                    u92.Color = u101.color.start:Lerp(u101.color.finish, u101.color.value.Value);
                end;

                Ball = workspace.Terrain:FindFirstChild("Ball");

                if not Ball then
                    for _, child in workspace.characters:GetChildren() do
                        if child:FindFirstChild("Ball") then
                            Ball = child:FindFirstChild("Ball");
                        end;
                    end;
                end;

                if not Ball then
                    return;
                end;

                local v105 = u91 == "Ball" and CFrame.new(Ball.Position) * v103 * v104 or (u91 == "Zone" and u99.CFrame * v103 * v104 or u91 == "Camera" and workspace_CurrentCamera.CFrame * v103 * v104) or u88 and u88:FindFirstChild(u91) and u88:FindFirstChild(u91).CFrame * v103 * v104;
                Model:PivotTo(v105 or Model.WorldPivot);
            end));
        else
            local u106 = u91 == "Ball" and CFrame.new(Ball.Position) * CFrame_new_ret * CFrame_Angles_ret or (u91 == "Zone" and u99.CFrame * CFrame_new_ret * CFrame_Angles_ret or u91 == "Camera" and workspace_CurrentCamera.CFrame) or u88 and u88:FindFirstChild(u91) and u88:FindFirstChild(u91).CFrame;
            u92.Anchored = true;
            v100:Add(RunService.PreRender:Connect(function(p107) -- Line: 765
                -- upvalues: u101 (copy), u92 (ref), Model (copy), u106 (copy)
                local v108 = u101.offset.start:Lerp(u101.offset.finish, u101.offset.value.Value);
                local v109 = u101.rotation.start:Lerp(u101.rotation.finish, u101.rotation.value.Value);

                if u92 then
                    u92.Transparency = math.lerp(u101.transparency.start, u101.transparency.finish, u101.transparency.value.Value);
                    u92.Size = u101.size.start:Lerp(u101.size.finish, u101.size.value.Value);
                    u92.Color = u101.color.start:Lerp(u101.color.finish, u101.color.value.Value);
                end;

                Model:PivotTo(u106 and u106 * v108 * v109 or Model.WorldPivot);
            end));
        end;

        v100:Add(task.delay(p89.Lifetime + 1, function() -- Line: 783
            -- upvalues: Model (copy)
            pcall(game.Destroy, Model);
        end));
    end;

    task.wait(p89.Lifetime + 10);
    v100:Destroy();
end;

function u1.SBAccessory(p110: any, p111: table) -- Line: 810
    -- upvalues: u5 (copy), AssetService (copy)
    local v112 = p111.Action[2];
    local Vector3_new_ret = Vector3.new(p111.Size[2], p111.Size[3], p111.Size[4]);
    local CFrame_new_ret = CFrame.new(-p111.Offset[2], p111.Offset[3], -p111.Offset[4]);
    local CFrame_Angles_ret = CFrame.Angles(math.rad(p111.Rotation[2]), math.rad(p111.Rotation[3]), (math.rad(p111.Rotation[4])));
    local v113 = p111.TextureID[2];
    local _ = p111.Name[2];
    local v114 = Enum.Material[p111.Material[2]];
    local Transparency = p111.Transparency;
    local u115 = p111.Mesh[2];
    local v116 = p111.Name[2];
    local v117 = p111.Part[2];
    local CanCollide = p111.CanCollide;
    local Color3_new_ret = Color3.new(p111.Color[2], p111.Color[3], p111.Color[4]);
    local v118 = p110:FindFirstChild(v117);

    if not v118 then
        return warn("part not found");
    end;

    if v112 == "Add" then
        if p110:FindFirstChild("Accessory_" .. v116) then
            return warn("accessory by that name already exists so you cant do that lalala");
        end;

        if not u5[u115] then
            local success, result = pcall(function() -- Line: 838
                -- upvalues: AssetService (ref), u115 (copy)
                return AssetService:CreateMeshPartAsync(u115);
            end);

            if not success then
                return warn("MeshID is invalid");
            end;

            u5[u115] = result;
        end;

        local v119 = u5[u115];

        if v119 then
            local v120 = v119:Clone();
            v120.CanCollide = false;
            v120.Massless = true;
            v120.CanQuery = false;
            v120.CFrame = v118.CFrame;
            v120.Transparency = Transparency;
            v120.Material = v114;
            v120.CanCollide = CanCollide;
            v120.Size = Vector3_new_ret;
            v120.Color = Color3_new_ret;

            if v113 ~= "" then
                v120.TextureID = v113;
            end;

            v120.Name = "Accessory_" .. v116;
            local Motor6D = Instance.new("Motor6D");
            Motor6D.Parent = v120;
            Motor6D.C0 = CFrame_new_ret * CFrame_Angles_ret;
            Motor6D.Part0 = v118;
            Motor6D.Part1 = v120;
            Motor6D.Name = "AccessoryMotor_" .. v116;
            v120.Parent = p110;
        end;
    end;

    if v112 == "Update" then
        if not p110:FindFirstChild("Accessory_" .. v116) then
            return warn("YOU NEED IT");
        end;

        local v121 = p110:FindFirstChild("Accessory_" .. v116);

        if v121 then
            v121.Transparency = Transparency;
            v121.Material = v114;
            v121.Color = Color3_new_ret;
            v121.CanCollide = CanCollide;

            if v113 ~= "" then
                v121.TextureID = v113;
            end;

            if v121:FindFirstChild("AccessoryMotor_" .. v116) then
                v121:FindFirstChild("AccessoryMotor_" .. v116).C0 = CFrame_new_ret * CFrame_Angles_ret;
            end;
        end;
    end;

    if v112 ~= "Delete" or not p110:FindFirstChild("Accessory_" .. v116) then
        return;
    end;

    pcall(game.Destroy, p110:FindFirstChild("Accessory_" .. v116));
end;

function TweenCamera(u122, p123, p124, p125)
    -- upvalues: TweenService (copy)
    local Vector3_new_ret = Vector3.new(p123[2][1], p123[2][2], p123[2][3]);
    local Vector3_new_ret2 = Vector3.new(p123[3][1], p123[3][2], p123[3][3]);
    local v126 = p125[4] == "Constant" and "Constant" or (Enum.EasingStyle[p125[4]] or "Constant");
    local v127 = Enum.EasingDirection[p125[5]];
    local u128 = CFrame.new(Vector3_new_ret) * CFrame.fromOrientation(Vector3_new_ret2.x, Vector3_new_ret2.y, Vector3_new_ret2.z);

    if p125[4] == "Constant" then
        return task.delay(p124, function() -- Line: 918
            -- upvalues: u122 (copy), u128 (copy)
            u122.C0 = u128;
        end);
    end;

    local v129 = TweenService:Create(u122, TweenInfo.new(p124, v126, v127), {
        C0 = u128
    });
    v129:Play();

    return v129;
end;

function TweenFov(p130, p131, p132)
    -- upvalues: workspace_CurrentCamera (copy), TweenService (copy)
    local u133 = p130[2];
    local v134 = p132[3] == "Constant" and "Constant" or (Enum.EasingStyle[p132[3]] or "Constant");
    local v135 = Enum.EasingDirection[p132[4]];

    if p132[4] == "Constant" then
        return task.delay(p131, function() -- Line: 934
            -- upvalues: workspace_CurrentCamera (ref), u133 (copy)
            workspace_CurrentCamera.FieldOfView = u133;
        end);
    end;

    local v136 = TweenService:Create(workspace_CurrentCamera, TweenInfo.new(p131, v134, v135), {
        FieldOfView = u133
    });
    v136:Play();

    return v136;
end;

local u165 = {
    ["{player}"] = function(p137, p138) -- Line: 945
        return p137 and p137.Name or "someone I used to know";
    end,

    ["{tplayer}"] = function(p139, p140) -- Line: 949
        return p140 and p140.Name or "someone I used to know";
    end,

    ["{displayplayer}"] = function(p141, p142) -- Line: 953
        local v143;

        if p141 then
            v143 = p141:FindFirstChild("Humanoid");
        else
            v143 = p141;
        end;

        local v144 = p141 and p141.Name or "someone I used to know";

        if v143 then
            v144 = v143.DisplayName;
        end;

        return v144;
    end,

    ["{displaytplayer}"] = function(p145, p146) -- Line: 962
        local v147;

        if p146 then
            v147 = p146:FindFirstChild("Humanoid");
        else
            v147 = p146;
        end;

        local v148 = p146 and p146.Name or "someone I used to know";

        if v147 then
            v148 = v147.DisplayName;
        end;

        return v148;
    end,

    ["{teammate}"] = function(p149, p150) -- Line: 971
        -- upvalues: actionUtil (copy)
        local v151 = {};

        for _, child in workspace.characters:GetChildren() do
            if actionUtil.checksameTeam(p149, child) and p149 ~= child then
                table.insert(v151, child);
            end;
        end;

        return #v151 > 0 and v151[math.random(1, #v151)].Name or "someone";
    end,

    ["{enemy}"] = function(p152, p153) -- Line: 980
        -- upvalues: actionUtil (copy)
        local v154 = {};

        for _, child in workspace.characters:GetChildren() do
            if not actionUtil.checksameTeam(p152, child) then
                table.insert(v154, child);
            end;
        end;

        return #v154 > 0 and v154[math.random(1, #v154)].Name or "someone";
    end,

    ["{team}"] = function(p155, p156) -- Line: 990
        -- upvalues: actionUtil (copy)
        return actionUtil.checkteam(p155);
    end,

    ["{teamscore}"] = function(p157, p158) -- Line: 994
        -- upvalues: actionUtil (copy), workspace2 (copy)
        local v159 = actionUtil.checkteam(p157);

        if not (v159 and workspace2:FindFirstChild(string.upper(v159) .. "score")) then
            return "0";
        end;

        local Value = workspace2:FindFirstChild(string.upper(v159) .. "score").Value;

        return tostring(Value);
    end,

    ["{enemyteam}"] = function(p160, p161) -- Line: 1004
        -- upvalues: actionUtil (copy)
        return string.upper(actionUtil.checkteam(p160)) == "A" and "B" or "A";
    end,

    ["{enemyteamscore}"] = function(p162, p163) -- Line: 1008
        -- upvalues: actionUtil (copy), workspace2 (copy)
        local v164 = string.upper(actionUtil.checkteam(p162)) == "A" and "B" or "A";

        if not (v164 and workspace2:FindFirstChild(string.upper(v164) .. "score")) then
            return "0";
        end;

        local Value = workspace2:FindFirstChild(string.upper(v164) .. "score").Value;

        return tostring(Value);
    end
};

for i, v in u165 do
    if not (string.find(i, "nocaps") or string.find(i, "allcaps")) then
        u165["nocaps" .. i] = function(p166, p167) -- Line: 1021
            -- upvalues: v (copy)
            return string.lower(v(p166, p167));
        end;

        u165["allcaps" .. i] = function(p168, p169) -- Line: 1024
            -- upvalues: v (copy)
            return string.upper(v(p168, p169));
        end;
    end;
end;

local function ParseText(p170, p171, p172) -- Line: 1030
    -- upvalues: u165 (copy)
    for i, v in u165 do
        local v173 = v(p171, p172);
        p170 = string.gsub(p170, i, v173);
    end;

    return p170;
end;

function u1.SBDialogue(p174, p175, p176, p177) -- Line: 1038
    -- upvalues: ParseText (copy), TekrinnDialogue (copy)
    if p176 then
        local _ = p176.UserId;
    end;

    for _, v in p175 do
        local v178 = v;

        for i, v2 in v do
            if table.find({ "TextStrokeColor", "Color" }, i) then
                v178[i] = Color3.new(tonumber(v2[1]), tonumber(v2[2]), (tonumber(v2[3])));
            end;

            if i == "Text" then
                v178[i] = ParseText(v2, p174, p177);
            end;
        end;
    end;

    task.spawn(TekrinnDialogue.Speak, p174, p175);
end;

local function debugtable(p179) -- Line: 1057
    -- upvalues: debugtable (copy)
    for i, v in p179 do
        print(i, v);

        if typeof(v) == "table" then
            debugtable(v);
        end;
    end;
end;

function u1.SBCamera(p180, p181) -- Line: 1066
    -- upvalues: actionUtil (copy), workspace_CurrentCamera (copy), trove (copy), mainreplication (copy), RunService (copy)
    local v182 = p181[1];
    local v183 = p181[2];
    local v184 = p181[3];
    local u185;

    if typeof(v182) == "Instance" then
        u185 = v182.Value or v182;
    else
        u185 = v182;
    end;

    if typeof(v182) == "Instance" then
        local u186 = nil;
        local u187 = false;
        local u188 = nil;
        local v189, v190, v191, v192;
        v189, v190, v191, v192, u185 = pcall(function() -- Line: 55
            -- upvalues: u185 (copy), u187 (ref), u186 (ref), u188 (ref)
            local buffer_fromstring_ret = buffer.fromstring(u185);
            local success, _ = pcall(function() -- Line: 58
                -- upvalues: buffer_fromstring_ret (ref)
                buffer_fromstring_ret = game:GetService("EncodingService"):Base64Decode(buffer_fromstring_ret);
            end);

            if success then
                local _, _ = pcall(function() -- Line: 63
                    -- upvalues: buffer_fromstring_ret (ref)
                    buffer_fromstring_ret = game:GetService("EncodingService"):DecompressBuffer(buffer_fromstring_ret, Enum.CompressionAlgorithm.Zstd);
                end);
            end;

            local success2, result = pcall(function() -- Line: 68
                -- upvalues: buffer_fromstring_ret (ref)
                return game:GetService("HttpService"):JSONDecode(buffer.tostring(buffer_fromstring_ret));
            end);

            if success2 then
                u187 = true;
                u186 = u185;
                u188 = result;
            else
                local success3, result2 = pcall(function() -- Line: 77
                    -- upvalues: u185 (ref)
                    return game:GetService("HttpService"):JSONDecode(u185);
                end);

                if success3 then
                    u188 = result2;
                    local buffer_fromstring_ret2 = buffer.fromstring(u185);
                    local _, _ = pcall(function() -- Line: 86
                        -- upvalues: buffer_fromstring_ret2 (ref)
                        buffer_fromstring_ret2 = game:GetService("EncodingService"):CompressBuffer(buffer_fromstring_ret2, Enum.CompressionAlgorithm.Zstd);
                    end);
                    local _, _ = pcall(function() -- Line: 90
                        -- upvalues: buffer_fromstring_ret2 (ref)
                        buffer_fromstring_ret2 = game:GetService("EncodingService"):Base64Encode(buffer_fromstring_ret2);
                    end);
                    u186 = buffer.tostring(buffer_fromstring_ret2);
                end;
            end;

            return u187, u186, u185, u188;
        end);

        if not v189 then
            return;
        end;
    end;

    print(u185);
    local u193 = {};
    local u194 = u185[3];
    local u195 = u185[4];
    local v196 = v184[2] or "HumanoidRootPart";

    if actionUtil.checkGK(p180) then
        return;
    end;

    local CFrame2 = workspace_CurrentCamera.CFrame;

    if p180:FindFirstChild(v196) then
        local u197 = trove.new();
        u197:AttachToInstance(p180);

        if v183 then
            mainreplication.sceneEnabled(true);
            u197:Add(function() -- Line: 1104
                -- upvalues: mainreplication (ref)
                mainreplication.sceneEnabled(false);
            end);
        end;

        local v198 = p180:FindFirstChild(v196);
        local u199 = u197:Add(Instance.new("Part"));
        u199:SetAttribute("IgnoresTheKid", true);
        u199.Transparency = 1;
        u199.CanCollide = false;
        u199.Massless = true;
        u199.Size = Vector3.new(1, 1, 1);
        u199.CFrame = v198.CFrame;
        local u200 = u197:Add(Instance.new("Motor6D"));
        u200.Parent = v198;
        u200.Part0 = v198;
        u200.Part1 = u199;
        u197:Add(function() -- Line: 1125
            -- upvalues: u193 (copy), workspace_CurrentCamera (ref), CFrame2 (copy)
            for _, v in u193 do
                if typeof(v) == "thread" then
                    task.cancel(v);
                end;

                if typeof(v) == "Instance" then
                    pcall(function() -- Line: 1132
                        -- upvalues: v (copy)
                        v:Cancel();
                    end);
                end;
            end;

            workspace_CurrentCamera.CameraType = Enum.CameraType.Custom;
            workspace_CurrentCamera.FieldOfView = 70;
            workspace_CurrentCamera.CFrame = CFrame2;
        end);
        local u201 = tick();
        u199.Parent = workspace.Effects;
        workspace_CurrentCamera.CameraType = Enum.CameraType.Scriptable;
        u197:Add(task.spawn(function() -- Line: 1150
            -- upvalues: RunService (ref), workspace_CurrentCamera (ref), u199 (copy), u197 (copy), u194 (copy), u201 (copy)
            u197:Add((RunService.PreRender:Connect(function(p202) -- Line: 1151
                -- upvalues: workspace_CurrentCamera (ref), u199 (ref)
                workspace_CurrentCamera.CFrame = u199.CFrame;
            end)));

            repeat
                task.wait();
            until u194[#u194][1] <= tick() - u201;

            u197:Destroy();
        end));
        u197:Add(task.spawn(function() -- Line: 1162
            -- upvalues: u195 (copy), workspace_CurrentCamera (ref), u193 (copy), u194 (copy), u200 (copy)
            for i, v in ipairs(u195) do
                local v203 = v[1];

                if v203 == 0 then
                    workspace_CurrentCamera.FieldOfView = v[2];
                elseif v[5] == 1 then
                    workspace_CurrentCamera.FieldOfView = v[2];
                else
                    local v204 = not u195[i - 1] and 0 or u195[i - 1][1];
                    local u205;

                    if u195[i - 1] then
                        u205 = u195[i - 1];
                    else
                        u205 = u195[i];
                    end;

                    local u206 = v203 - v204;
                    task.delay(v204, function() -- Line: 1184
                        -- upvalues: u193 (ref), v (copy), u206 (copy), u205 (ref)
                        table.insert(u193, TweenFov(v, u206, u205));
                    end);
                end;
            end;

            for i, v in ipairs(u194) do
                print(i, v);
                local v207 = v[1];

                if v207 == 0 or i == 1 then
                    table.insert(u193, TweenCamera(u200, v, v207, v));
                else
                    local u208;

                    if u194[i - 1] then
                        u208 = u194[i - 1];
                    else
                        u208 = u194[i];
                    end;

                    if v[6] == 1 then
                        table.insert(u193, TweenCamera(u200, v, 0, u208));
                    else
                        local v209 = u194[i - 1][1];
                        local u210 = v207 - v209;
                        task.delay(v209, function() -- Line: 1210
                            -- upvalues: u193 (ref), u200 (ref), v (copy), u210 (copy), u208 (ref)
                            table.insert(u193, TweenCamera(u200, v, u210, u208));
                        end);
                    end;
                end;
            end;
        end));
    end;
end;

local function clone(p211) -- Line: 1224
    -- upvalues: clone (copy)
    local v212 = {};

    for i, v in pairs(p211) do
        if type(v) == "table" then
            v212[i] = clone(v);
        else
            v212[i] = v;
        end;
    end;

    return v212;
end;

local u213 = { "Head", "Right Arm", "Left Arm", "Left Leg", "Right Leg", "Torso", "Ball", "Camera" };

local function findbone(p214) -- Line: 1247
    -- upvalues: u213 (copy)
    if tonumber(p214) then
        return tonumber(p214);
    end;

    for i, v in u213 do
        if string.lower(v) == string.lower(p214) then
            return i;
        end;
    end;
end;

local function GetSortedFOV(p215: table) -- Line: 1259
    local u216 = {};

    for i, v in p215 do
        table.insert(u216, {
            Index = i,
            Value = v
        });
    end;

    table.sort(u216, function(p217, p218) -- Line: 1264
        return p217.Index < p218.Index;
    end);

    return function(p219) -- Line: 1267
        -- upvalues: u216 (copy)
        local v220 = #u216;

        if v220 == 0 then
            return nil;
        end;

        local v221 = 1;

        while v221 < v220 do
            local v222 = (v221 + v220) // 2;

            if u216[v222].Index < p219 then
                v221 = v222 + 1;
            else
                v220 = v222;
            end;
        end;

        if v221 > 1 then
            local v223 = u216[v221 - 1];
            local v224 = u216[v221];

            if math.abs(v223.Index - p219) <= math.abs(v224.Index - p219) then
                return v223;
            end;
        end;

        return u216[v221];
    end;
end;

function u1.SBAnimate(p225, p226, p227, p228, p229, p230) -- Line: 1292
    -- upvalues: trove (copy), workspace_CurrentCamera (copy), RunService (copy), GetSortedFOV (copy), mainreplication (copy), u213 (copy), findbone (copy), clone (copy), TweenService (copy)
    local Value = p226.Value;
    local u231 = nil;
    local u232 = false;
    local u233 = nil;
    local v234, _, _, _, v235 = pcall(function() -- Line: 55
        -- upvalues: Value (copy), u232 (ref), u231 (ref), u233 (ref)
        local buffer_fromstring_ret = buffer.fromstring(Value);
        local success, _ = pcall(function() -- Line: 58
            -- upvalues: buffer_fromstring_ret (ref)
            buffer_fromstring_ret = game:GetService("EncodingService"):Base64Decode(buffer_fromstring_ret);
        end);

        if success then
            local _, _ = pcall(function() -- Line: 63
                -- upvalues: buffer_fromstring_ret (ref)
                buffer_fromstring_ret = game:GetService("EncodingService"):DecompressBuffer(buffer_fromstring_ret, Enum.CompressionAlgorithm.Zstd);
            end);
        end;

        local success2, result = pcall(function() -- Line: 68
            -- upvalues: buffer_fromstring_ret (ref)
            return game:GetService("HttpService"):JSONDecode(buffer.tostring(buffer_fromstring_ret));
        end);

        if success2 then
            u232 = true;
            u231 = Value;
            u233 = result;
        else
            local success3, result2 = pcall(function() -- Line: 77
                -- upvalues: Value (ref)
                return game:GetService("HttpService"):JSONDecode(Value);
            end);

            if success3 then
                u233 = result2;
                local buffer_fromstring_ret2 = buffer.fromstring(Value);
                local _, _ = pcall(function() -- Line: 86
                    -- upvalues: buffer_fromstring_ret2 (ref)
                    buffer_fromstring_ret2 = game:GetService("EncodingService"):CompressBuffer(buffer_fromstring_ret2, Enum.CompressionAlgorithm.Zstd);
                end);
                local _, _ = pcall(function() -- Line: 90
                    -- upvalues: buffer_fromstring_ret2 (ref)
                    buffer_fromstring_ret2 = game:GetService("EncodingService"):Base64Encode(buffer_fromstring_ret2);
                end);
                u231 = buffer.tostring(buffer_fromstring_ret2);
            end;
        end;

        return u232, u231, Value, u233;
    end);
    local u236 = v235;

    if not v234 then
        return;
    end;

    local u237 = 0;
    local u238 = trove.new();
    u238:AttachToInstance(p227);
    local v239 = u236.FOV or nil;
    local v240 = {
        HasCamera = p230[1],
        playsGlobally = p230[2],
        disableinterface = p230[3],
        freezegame = p230[4],
        freezetype = p230[5]
    };
    local u241;

    if v240.HasCamera then
        u241 = u238:Add(Instance.new("Part"));
        u241.Size = Vector3.new(1, 1, 1);
        u241.Transparency = 1;
        u241.CanCollide = false;
        u241.Massless = true;
        u241.Parent = p225;
        u241.Name = "Camera";
        local Motor6D = Instance.new("Motor6D");
        Motor6D.Name = "Camera";
        Motor6D.Parent = u241;
        Motor6D.Part0 = p225:FindFirstChild("HumanoidRootPart");
        Motor6D.Part1 = u241;
    else
        u241 = nil;
    end;

    local CFrame2 = workspace_CurrentCamera.CFrame;
    local u242 = {
        Torso = p225.HumanoidRootPart.RootJoint,
        ["Right Arm"] = p225.Torso["Right Shoulder"],
        ["Left Arm"] = p225.Torso["Left Shoulder"],
        ["Right Leg"] = p225.Torso["Right Hip"],
        ["Left Leg"] = p225.Torso["Left Hip"],
        Head = p225.Torso.Neck
    };
    local u243 = {};
    local u244 = p228 or 0;
    local u245 = p229 or 0;
    local u246 = u244 == 0 and 1 or 0;
    local u247 = 0;

    if p225:FindFirstChild("Ball") then
        u242.Ball = p225.Ball.ball;
    end;

    if u241 then
        u242.Camera = u241.Camera;
        u238:Add(function() -- Line: 1361
            -- upvalues: workspace_CurrentCamera (ref), CFrame2 (copy)
            workspace_CurrentCamera.CameraType = Enum.CameraType.Custom;
            workspace_CurrentCamera.FieldOfView = 70;
            workspace_CurrentCamera.CFrame = CFrame2;
        end);
        tick();
        workspace_CurrentCamera.CameraType = Enum.CameraType.Scriptable;
        local v249 = RunService.PreRender:Connect(function(p248) -- Line: 1370
            -- upvalues: workspace_CurrentCamera (ref), u241 (ref)
            workspace_CurrentCamera.CFrame = u241.CFrame;
        end);

        if v239 then
            local u250 = u236.FPS or 60;
            local u251 = GetSortedFOV(v239);
            u238:Add(RunService.PreRender:Connect(function(p252) -- Line: 1378
                -- upvalues: u237 (ref), u250 (copy), u251 (copy), workspace_CurrentCamera (ref)
                local v253 = u251(u237 * u250);

                if v253 then
                    workspace_CurrentCamera.FieldOfView = v253.Value;
                end;
            end));
        end;

        u238:Add(v249);

        if v240.disableinterface then
            mainreplication.sceneEnabled(true);
            u238:Add(function() -- Line: 1391
                -- upvalues: mainreplication (ref)
                mainreplication.sceneEnabled(false);
            end);
        end;
    end;

    local u254 = {};

    for i, v in u242 do
        local Weld = Instance.new("Weld");
        Weld.Name = v.Name;
        Weld.Part0 = v.Part0;
        Weld.Part1 = v.Part1;
        Weld.Parent = v.Parent;
        Weld.C0 = v.C0;
        Weld.C1 = v.C1;
        u254[Weld] = v.C0;
        v.Enabled = false;
        u243[i] = Weld;
    end;

    local v255 = p225:FindFirstChildWhichIsA("Humanoid");

    if v255 then
        v255 = v255:FindFirstChildWhichIsA("Animator");
    end;

    for i, v in u236.Data do
        local v256 = {};

        for i2, v2 in v do
            local v257 = u213[findbone(i2)];

            if v257 and u243[v257] then
                local v258 = clone(v2);
                local Part1 = u243[v257].Part1;

                if v258.C0 then
                    if #v258.C0 == 6 then
                        local v259 = v258.C0[1];
                        local v260 = v258.C0[2];
                        local v261 = v258.C0[3];
                        local v262 = v258.C0[4];
                        local v263 = v258.C0[5];
                        local v264 = v258.C0[6];

                        if u236.OptimizedLoad then
                            v258.C0 = CFrame.new(v259, v260, v261) * CFrame.fromEulerAnglesYXZ(math.rad(v262), math.rad(v263), (math.rad(v264)));
                        else
                            v258.C0 = CFrame.new(v259, v260, v261) * CFrame.fromEulerAnglesYXZ(v262, v263, v264);
                        end;
                    else
                        v258.C0 = CFrame.new(table.unpack(v258.C0));
                    end;
                end;

                v256[Part1] = v258;
            end;
        end;

        u236.Data[i] = v256;
    end;

    local function get_current_pose() -- Line: 1447
        -- upvalues: u237 (ref), u236 (copy), u243 (copy), TweenService (ref), u244 (copy), u242 (copy), u246 (ref), u245 (copy), u247 (ref), u254 (copy)
        local v265 = u237;
        local v266 = {};

        for i, v in u236.Data do
            table.insert(v266, {
                Timer = i,
                Data = v
            });
        end;

        table.sort(v266, function(p267, p268) -- Line: 1459
            return tonumber(p267.Timer) < tonumber(p268.Timer);
        end);
        local v269 = {};

        for _, v in u243 do
            local CFrame_identity = CFrame.identity;
            local v270 = v265;
            local v271 = v270;
            local v272 = v;
            local v273 = v270;
            v270 = v271;
            v273 = v271;
            v271 = v270;
            local v274 = false;
            local v275 = nil;
            local v276 = "Linear";
            local v277 = "In";

            for i, v2 in v266 do
                if v265 <= tonumber(v2.Timer) and (v2.Data[v272.Part1] and not v274) then
                    local _ = v2.Timer;
                    v270 = v2.Timer;
                    v275 = v2.Data[v272.Part1].C0;
                    local v278 = v2;
                    v274 = true;

                    for i2 = i - 1, 1, -1 do
                        if v266[i2] and v266[i2].Data[v272.Part1] then
                            v271 = v266[i2].Timer;
                            CFrame_identity = v266[i2].Data[v272.Part1].C0;

                            if v266[i2].Data[v272.Part1].EasingStyle then
                                v276 = v266[i2].Data[v272.Part1].EasingStyle;
                                v277 = v278.Data[v272.Part1].EasingDirection;
                            end;

                            break;
                        end;

                        local _ = i2;
                    end;
                end;
            end;

            if not v275 then
                v270 = v271;
                v275 = CFrame_identity;
            end;

            v269[v272] = {
                PrevC0 = CFrame_identity,
                NewC0 = v275,
                PrevTimer = v271,
                OldTimer = v270,
                EasingStyle = v276,
                EasingDirection = v277
            };
        end;

        for i, v in v269 do
            if v.PrevTimer == v.OldTimer then
                if i:GetAttribute("lastC0") then
                    i.C0 = u254[i] * i:GetAttribute("lastC0");
                end;
            else
                local v279 = v.EasingStyle == "Constant" and 0 or (TweenService:GetValue(math.lerp(0, 1, (v265 - v.PrevTimer) / (v.OldTimer - v.PrevTimer)), Enum.EasingStyle[v.EasingStyle], Enum.EasingDirection[v.EasingDirection]) or 0);
                local v280 = v.PrevC0:Lerp(v.NewC0, v279);
                i:SetAttribute("lastC0", v.NewC0);

                if u244 ~= 0 then
                    v280 = u242[i.Part1.Name].Transform:Lerp(v280, u246);
                end;

                if u245 ~= 0 then
                    v280 = v280:Lerp(u242[i.Part1.Name].Transform, u247);
                end;

                i.C0 = u254[i] * v280;
            end;
        end;
    end;

    for _, v in v255:GetPlayingAnimationTracks() do
        v:Stop();
    end;

    u238:Add((RunService.PostSimulation:Connect(function(p281) -- Line: 1543
        -- upvalues: u237 (ref), u244 (copy), u246 (ref), u245 (copy), u236 (copy), u247 (ref), u238 (copy), get_current_pose (copy)
        u237 = u237 + p281;

        if u244 ~= 0 then
            u246 = math.clamp(u237 / u244, 0, 1);
        end;

        if u245 ~= 0 then
            local v282 = u236.TimelineLength - u245;

            if v282 <= u236.TimelineLength then
                local math_clamp_ret = math.clamp((u237 - v282) / u245, 0, 1);
                u247 = math.lerp(0, 1, math_clamp_ret);
            end;
        end;

        if u236.TimelineLength and u237 >= u236.TimelineLength then
            if u236.Loop then
                u237 = 0;
            else
                u238:Destroy();
            end;
        end;

        get_current_pose();
    end)));
    Instance.new("NumberValue").Value = 1;
    u238:Add(function() -- Line: 1573
        -- upvalues: u242 (copy), u243 (copy)
        for _, v in u242 do
            v.Enabled = true;
        end;

        for _, v in u243 do
            v.Enabled = false;
            pcall(game.Destroy, v);
        end;
    end);
end;

function u1.fadeoutsound(u283: userdata, u284: number) -- Line: 1586
    -- upvalues: TweenService (copy)
    local v285 = tick();

    repeat
        task.wait();
    until not (tick() - v285 < 3 and (not u283 or u283.TimeLength == 0) and u283);

    if not u283 then
        return;
    end;

    local TimeLength = u283.TimeLength;

    if u283.PlaybackRegion.Max < TimeLength then
        TimeLength = u283.PlaybackRegion.Max;
    end;

    task.delay(TimeLength - u283.TimePosition - u284, function() -- Line: 1604
        -- upvalues: u283 (copy), TweenService (ref), u284 (copy)
        if u283 then
            TweenService:Create(u283, TweenInfo.new(u284, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                Volume = 0
            }):Play();
        end;
    end);
end;

return u1;