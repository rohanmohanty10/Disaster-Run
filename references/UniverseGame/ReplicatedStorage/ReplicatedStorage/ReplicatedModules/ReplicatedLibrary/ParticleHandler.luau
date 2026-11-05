  

 

local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
local ParticleInfo = require(game.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleInfo);
local u1 = {};

local function ShiftValueWithRatio(p2, p3, p4) -- Line: 18
    if p3 == 0 then
        return p2;
    end;

    local v5 = p2 * p4 + p3;

    if v5 < 0 then
        v5 = v5 + p4;
    end;

    return v5 % p4 / (p4 - 1);
end;

local function ShiftValue(p6, p7) -- Line: 28
    if p7 == 0 then
        return p6;
    end;

    local v8 = p6 + p7;

    if v8 < 0 then
        v8 = v8 + 360;
    end;

    return v8 % 360 / 359;
end;

local function HSVShift(p9, p10) -- Line: 36
    -- upvalues: ShiftValueWithRatio (copy), ShiftValue (copy)
    local v11 = math.max(p9.R, p9.G, p9.B);
    local v12 = v11 - math.min(p9.R, p9.G, p9.B);
    local v13;

    if p10.V2Shift then
        v13 = ShiftValueWithRatio;
    else
        v13 = ShiftValue;
    end;

    local Hue = p10.Hue;
    local HueShift = p10.HueShift;
    local v14;

    if Hue and Hue > 9000000000 then
        v14 = true;
    elseif HueShift then
        v14 = HueShift > 9000000000;
    else
        v14 = HueShift;
    end;

    local v15 = v11 <= (p10.BlackThreshold or 0.08);
    local v16 = v12 <= (p10.NeutralThreshold or 0.02);

    if v14 then
        return Color3.new(1, 1, 1), false;
    end;

    if v15 then
        local v17 = math.clamp(p10.Value or v11, 0, 1);
        local v18;

        if v17 < 0.08 then
            v17 = 0.08;
            v18 = true;
        else
            v18 = false;
        end;

        return Color3.new(v17, v17, v17), v18;
    end;

    if Hue ~= Hue and true or HueShift ~= HueShift then
        return Color3.new(0.08, 0.08, 0.08), true;
    end;

    if v16 and not (p10.Saturation or p10.SaturationShift) then
        local v19 = math.clamp(p10.Value or v11, 0, 1);

        return Color3.new(v19, v19, v19), false;
    end;

    local v20, v21, v22 = p9:ToHSV();
    local v23 = Hue or v13(v20, HueShift or 0, 360);
    local v24 = p10.Saturation or v13(v21, p10.SaturationShift or 0, 256);
    local v25 = p10.Value or v13(v22, p10.ValueShift or 0, 256);
    local v26 = math.clamp(v23, 0, 1);
    local v27 = math.clamp(v24, 0, 1);
    local v28 = math.clamp(v25, 0, 1);

    return Color3.fromHSV(v26, v27, v28), false;
end;

local function HueShift(p29, p30) -- Line: 88
    local v31, v32, v33 = p29:ToHSV();
    local v34 = v31 + p30 / 360;

    if v34 > 1 then
        v34 = v34 - 1;
    end;

    return Color3.fromHSV(v34, v32, v33);
end;

local function CCR(p35) -- Line: 98
    return p35 % 1;
end;

local function GenerateCode(p36) -- Line: 104
    local v37 = "";

    for _ = 1, (type(p36) ~= "number" or (p36 < 5 or not p36)) and 5 or p36 do
        v37 = v37 .. string.char(math.random(65, 90));
    end;

    return v37;
end;

function u1.HueShift(p38, p39) -- Line: 113
    -- upvalues: HueShift (copy)
    local Color = p38.Color;

    if typeof(Color) == "ColorSequence" then
        local v40 = {};

        for i = 1, #Color.Keypoints do
            local v41, v42, v43 = Color.Keypoints[i].Value:ToHSV();
            local v44 = v41 + p39 / 360;

            if v44 > 1 then
                v44 = v44 - 1;
            end;

            local v45 = Color3.fromHSV(v44, v42, v43);
            table.insert(v40, ColorSequenceKeypoint.new(Color.Keypoints[i].Time, v45));
        end;

        return ColorSequence.new(v40);
    end;

    if typeof(Color) == "Color3" then
        return HueShift(Color, p39);
    end;
end;

function u1.HueShiftParticles(p46, p47) -- Line: 128
    -- upvalues: u1 (copy)
    for _, v in ipairs(p46:QueryDescendants("ParticleEmitter, Trail")) do
        if not v:GetAttribute("IgnoreShift") then
            v.Color = u1.HueShift(v, p47);
        end;
    end;
end;

function u1.HSVShift(p48, p49) -- Line: 135
    -- upvalues: HSVShift (copy)
    if p49 and (p49.SaturationThreshold and not p49.SaturationShift) then
        local v50 = typeof(p48) == "ColorSequence" and ({ p48.Keypoints[1].Value:ToHSV() })[2];

        if not v50 then
            if typeof(p48) == "Color3" then
                v50 = ({ p48:ToHSV() })[2];
            else
                v50 = false;
            end;
        end;

        local v51 = v50 * 256;

        if v51 and v51 <= p49.SaturationThreshold then
            p49.SaturationShift = p49.SaturationThreshold;
        end;
    end;

    if typeof(p48) == "ColorSequence" then
        local v52 = {};
        local v53 = false;

        for i = 1, #p48.Keypoints do
            local v54, v55 = HSVShift(p48.Keypoints[i].Value, p49);
            table.insert(v52, ColorSequenceKeypoint.new(p48.Keypoints[i].Time, v54));
            v53 = v55 and true or v53;
        end;

        return ColorSequence.new(v52), v53;
    end;

    if typeof(p48) == "Color3" then
        return HSVShift(p48, p49);
    end;
end;

function u1.TryHSVShift(p56, p57) -- Line: 165
    -- upvalues: u1 (copy)
    if p57 == nil then
        return p56;
    end;

    return u1.HSVShift(p56, p57);
end;

function u1.HSVShiftParticles(p58, p59) -- Line: 170
    -- upvalues: u1 (copy)
    if typeof(p58) == "Instance" then
        p58 = p58:GetDescendants();
    end;

    for _, v in p58 do
        if not v:GetAttribute("IgnoreShift") then
            if v:IsA("ParticleEmitter") or (v:IsA("Trail") or (v:IsA("Beam") or (v:IsA("Light") or (v:IsA("Sparkles") or v:IsA("Smoke"))))) then
                v.Color = u1.HSVShift(v.Color, p59);
            elseif v:IsA("Fire") then
                v.Color = u1.HSVShift(v.Color, p59);
                v.SecondaryColor = u1.HSVShift(v.SecondaryColor, p59);
            end;
        end;
    end;
end;

function u1.HueShiftModel(p60, p61) -- Line: 185
    for _, descendant in ipairs(p60:GetDescendants()) do
        if not descendant:GetAttribute("IgnoreShift") and descendant:IsA("BasePart") then
            local v62, v63, v64 = descendant.Color:ToHSV();
            local v65 = v62 + p61 / 360;

            if v65 > 1 then
                v65 = v65 - 1;
            end;

            descendant.Color = Color3.fromHSV(v65, v63, v64);
        end;
    end;
end;

function u1.HSVShiftModel(p66, p67) -- Line: 194
    -- upvalues: u1 (copy)
    if typeof(p66) == "Instance" then
        p66 = p66:GetDescendants();
    end;

    for _, v in p66 do
        if not v:GetAttribute("IgnoreShift") and v:IsA("BasePart") then
            v.Color = u1.HSVShift(v.Color, p67);
        end;
    end;
end;

function u1.HSVShiftTable(p68, p69) -- Line: 206
    -- upvalues: u1 (copy)
    if p69 == nil then
        return p68;
    end;

    for i, v in p68 do
        if typeof(v) == "Color3" or typeof(v) == "ColorSequence" then
            p68[i] = u1.HSVShift(v, p69);
        end;
    end;

    return p68;
end;

function u1.HSVShiftInstances(p70, p71) -- Line: 216
    -- upvalues: u1 (copy)
    if typeof(p70) == "Instance" then
        p70 = p70:GetDescendants() or p70;
    end;

    local IncludeParts = p71.IncludeParts;
    local IncludeSurfaces = p71.IncludeSurfaces;
    local IncludeTextures = p71.IncludeTextures;

    for _, v in p70 do
        if not v:GetAttribute("IgnoreShift") then
            if v:IsA("ParticleEmitter") or (v:IsA("Trail") or (v:IsA("Beam") or (v:IsA("Light") or (v:IsA("Sparkles") or v:IsA("Smoke"))))) then
                local v72, _ = u1.HSVShift(v.Color, p71);
                v.Color = v72;
            elseif IncludeParts == true and v:IsA("BasePart") then
                v.Color = u1.HSVShift(v.Color, p71);
            elseif IncludeSurfaces == true and v:IsA("SurfaceAppearance") then
                v.Color = u1.HSVShift(v.Color, p71);
            elseif IncludeTextures == true and (v:IsA("Texture") or v:IsA("Decal")) then
                v.Color3 = u1.HSVShift(v.Color3, p71);
            elseif v:IsA("Fire") then
                v.Color = u1.HSVShift(v.Color, p71);
                v.SecondaryColor = u1.HSVShift(v.SecondaryColor, p71);
            end;
        end;
    end;
end;

function u1.IsUnusualValue(p73) -- Line: 254
    return p73 > 0 and true or p73 ~= p73;
end;

function u1.GetUnusualType(p74) -- Line: 258
    -- upvalues: Players (copy)
    if typeof(p74) == "Instance" then
        local v75;

        if p74:IsA("Model") then
            v75 = Players:GetPlayerFromCharacter(p74);

            if v75 == nil then
                v75 = p74;
            end;
        else
            v75 = p74;
        end;

        p74 = v75 ~= nil and (v75.Data.Skin:GetAttribute("UnusualHueId") or 0) or p74;
    end;

    if p74 <= 0 then
        return "NONE";
    end;

    if p74 > 9000000000 then
        return "WHITE";
    end;

    if p74 > 0 then
        return "COLOR";
    end;

    if p74 ~= p74 then
        return "BLACK";
    end;
end;

function u1.GetUnusualHSVData(p76) -- Line: 281
    -- upvalues: Players (copy), u1 (copy), TableUtil (copy)
    local v77 = p76.Player or p76.Character;

    if v77 == nil then
        return nil;
    end;

    local v78;

    if v77:IsA("Model") then
        v78 = Players:GetPlayerFromCharacter(v77);

        if v78 == nil then
            v78 = v77;
        end;
    else
        v78 = v77;
    end;

    if p76.SkinName == nil and v78 ~= nil then
        p76.SkinName = v78.Data.Skin:GetAttribute("SkinName");
    end;

    local v79 = nil;
    local v80 = nil;

    if p76.UseSkinData == nil or p76.UseSkinData == true then
        local SkinName = p76.SkinName;

        if SkinName ~= nil then
            v79 = u1.GetSkinInfo(SkinName);

            if v79 ~= nil then
                local v81 = v79.Trail and v79.Trail.HSVShift or v79.Metadata and v79.Metadata.HSVShift;

                if v81 then
                    v80 = TableUtil.Copy(v81, true);
                end;
            end;
        end;
    end;

    if v78 ~= nil then
        local Skin = v78.Data.Skin;
        local v82 = Skin:GetAttribute("UnusualHueId");
        local v83 = Skin:GetAttribute("UnusualSaturation");
        local v84 = Skin:GetAttribute("UnusualValue");

        if v82 then
            local v85 = v82 * 5;

            if v79 ~= nil and (v79.UnusualMetadata ~= nil and v79.UnusualMetadata.HSVShift) then
                v80 = TableUtil.Reconcile(v79.UnusualMetadata.HSVShift, v80 or {});
            end;

            local v86 = {};

            if v85 == 0 then
                v85 = nil;
            end;

            v86.HueShift = v85;
            v86.Saturation = v83;
            v86.Value = v84;
            v86.Chroma = Skin and Skin:GetAttribute("ChromaUnusual") == true and true or nil;

            if v80 == nil then
                return v86;
            end;

            v80 = TableUtil.Reconcile(v86, v80);
        end;
    end;

    return v80;
end;

function u1.Unusualify(p87, p88) -- Line: 332
    -- upvalues: u1 (copy)
    local HSVData = p88.HSVData;

    if HSVData == nil then
        HSVData = u1.GetUnusualHSVData(p88);
    end;

    if HSVData == nil then
        return;
    end;

    local v89;

    if typeof(p87) == "Instance" then
        v89 = p87:GetDescendants();
        table.insert(v89, p87);
    else
        v89 = p87;
    end;

    if p88.IncludeParts then
        HSVData.IncludeParts = true;
    end;

    if p88.IncludeTextures then
        HSVData.IncludeTextures = true;
    end;

    if p88.IncludeSurfaces then
        HSVData.IncludeSurfaces = true;
    end;

    u1.HSVShiftInstances(v89, HSVData);
end;

function u1.ChangeProperties(p90, p91) -- Line: 358
    for i, v in pairs(p91) do
        p90[i] = v;
    end;
end;

function u1.AttachTo(p92, p93) -- Line: 364
    -- upvalues: u1 (copy)
    if type(p93) ~= "table" then
        return;
    end;

    if not (p93.Part and p93.Part:IsDescendantOf(workspace)) then
        return;
    end;

    if not p92:IsA("Model") or p92.PrimaryPart then
        local Part = p93.Part;
        local v94 = u1.TranslateToCFrame(p93.Offset);

        if p92:IsA("Model") then
            p92 = p92.PrimaryPart;
        end;

        p92.Anchored = false;
        p92.CanCollide = false;
        p92.Massless = true;
        local v95 = Instance.new(p93.UseMotor6D and "Motor6D" or "Weld");
        local v96 = p93.MakePartP0 or p93.InverseAttach;
        v95.Part0 = v96 and Part and Part or p92;
        v95.Part1 = v96 and p92 and p92 or Part;

        if p93.MakePartParent then
            p92 = Part or p92;
        end;

        v95.Parent = p92;

        if p93.C0 then
            v95.C0 = p93.C0;
        end;

        if p93.C1 then
            v95.C1 = p93.C1;
        end;

        if v94 then
            v95.C0 = v95.C0 * v94;
        end;

        if p93.Duration then
            task.delay(p93.Duration, v95.Destroy, v95);
        end;

        return v95;
    end;

    warn(p92, "needs a PrimaryPart");
end;

function u1.AttachParticle(p97, p98, p99) -- Line: 399
    -- upvalues: u1 (copy)
    local v100 = p99 or {};
    v100.Part = p98;

    return u1.AttachTo(p97, v100);
end;

function u1.MoveTo(p101, p102) -- Line: 405
    if not p102 then
        return;
    end;

    if p101:IsA("Model") and not p101.PrimaryPart then
        warn(p101, "needs a PrimaryPart");

        return;
    end;

    if p101:IsA("Model") then
        p101:PivotTo(p102);

        return;
    end;

    p101.CFrame = p102;
end;

function u1.TranslateToCFrame(p103) -- Line: 415
    local v104 = typeof(p103);

    if v104 == "CFrame" then
        return p103;
    end;

    if v104 == "Vector3" then
        return CFrame.new(p103);
    end;

    if v104 == "Instance" and p103:IsDescendantOf(game) then
        if p103:IsA("BasePart") then
            return p103.CFrame;
        end;

        if p103:IsA("Attachment") then
            return p103.WorldCFrame;
        end;

        if p103:IsA("Model") then
            local v105 = p103:FindFirstChild("Torso") or p103.PrimaryPart;

            if v105 then
                return v105.CFrame;
            end;

            for _, descendant in p103:GetDescendants() do
                if descendant:IsA("BasePart") then
                    return descendant.CFrame;
                end;
            end;
        end;
    end;
end;

function u1.TranslateToPosition(p106) -- Line: 437
    -- upvalues: u1 (copy)
    return u1.TranslateToCFrame(p106).Position;
end;

function u1.GenerateEmitInfo(p107) -- Line: 441
    -- upvalues: GenerateCode (copy)
    local v108 = {};

    for _, v in ipairs(p107:QueryDescendants("ParticleEmitter")) do
        local v109 = GenerateCode(5);
        v.Name = v109;
        v108[v109] = {
            State = "Emit",
            EmitAmount = v:GetAttribute("EmitCount") or 16,
            EmitDelay = v:GetAttribute("EmitDelay") or 0,
            EmitDuration = v:GetAttribute("EmitDuration") or 0
        };
    end;

    return v108;
end;

function u1.ColorParticle(p110, p111) -- Line: 458
    for _, v in next, p110 do
        if v:IsA("ParticleEmitter") then
            v.Color = typeof(p111) == "ColorSequence" and p111 and p111 or ColorSequence.new(p111);
        end;
    end;
end;

function u1.Emit(p112, p113) -- Line: 466
    -- upvalues: u1 (copy)
    for _, v in ipairs(p112:QueryDescendants("ParticleEmitter")) do
        local v114 = p113[v.Name];

        if v114 then
            if v114.HueShift then
                v.Color = u1.HueShift(v, v114.HueShift);
            end;

            local v115 = v114.EmitDelay or v114.Delay;
            local u116 = v114.EmitAmount or v114.Emit;
            local u117 = v114.EmitDuration or v114.Duration;

            if v115 and v115 > 0 then
                task.delay(v115, function() -- Line: 476
                    -- upvalues: v (copy), u116 (copy), u117 (copy)
                    v:Emit(u116);

                    if u117 and u117 > 0 then
                        v.Enabled = true;
                        task.delay(u117, function() -- Line: 480
                            -- upvalues: v (ref)
                            v.Enabled = false;
                        end);
                    end;
                end);
            else
                v:Emit(u116);

                if u117 and u117 > 0 then
                    v.Enabled = true;
                    task.delay(u117, function() -- Line: 490
                        -- upvalues: v (copy)
                        v.Enabled = false;
                    end);
                end;
            end;
        end;
    end;
end;

function u1.EmitFromAttribute(p118) -- Line: 499
    for _, v in p118:QueryDescendants("ParticleEmitter") do
        if v:GetAttribute("EmitCount") then
            if v:GetAttribute("EmitDelay") then
                task.delay(v:GetAttribute("EmitDelay"), function() -- Line: 504
                    -- upvalues: v (copy)
                    v:Emit(v:GetAttribute("EmitCount"));
                end);
            else
                v:Emit(v:GetAttribute("EmitCount"));
            end;
        end;
    end;
end;

function u1.LockToPart(p119, p120) -- Line: 513
    for _, v in pairs(p119:QueryDescendants("ParticleEmitter")) do
        v.LockedToPart = p120;
    end;
end;

function u1.GetMaxLifetime(p121) -- Line: 521
    if p121:GetAttribute("Lifetime") then
        return p121:GetAttribute("Lifetime");
    end;

    local v122 = 0;

    for _, v in pairs(p121:QueryDescendants("ParticleEmitter")) do
        local v123 = v:GetAttribute("EmitDuration") or 0;
        local v124 = v:GetAttribute("EmitDelay") or 0;
        local v125 = (v.Lifetime.Max + v123 + v124) / v.TimeScale;

        if v:GetAttribute("Lifetime") then
            v125 = math.max(v125, v:GetAttribute("Lifetime"));
        end;

        if v122 < v125 and v125 < (1 / 0) then
            v122 = v125;
        end;
    end;

    return v122;
end;

function u1.DestroyEmit(u126, u127) -- Line: 542
    -- upvalues: u1 (copy)
    if u126 then
        local u128 = u127 or u1.GetMaxLifetime(u126);
        task.delay(u128, function() -- Line: 545
            -- upvalues: u127 (copy), u1 (ref), u126 (copy), u128 (copy)
            local v129 = u127 or u1.GetMaxLifetime(u126);

            if u128 < v129 then
                task.delay(math.clamp(v129, u128, u128 * 5), u126.Destroy, u126);

                return;
            end;

            u126:Destroy();
        end);

        return u128;
    end;
end;

function u1._ScaleParticle(p130, p131) -- Line: 556
    local Size = p130.Size;
    local Speed = p130.Speed;

    if typeof(Size) == "NumberSequence" then
        local v132 = {};

        for i = 1, #Size.Keypoints do
            local v133 = Size.Keypoints[i];
            table.insert(v132, NumberSequenceKeypoint.new(v133.Time, v133.Value * p131, v133.Envelope * p131));
        end;

        p130.Size = NumberSequence.new(v132);
    end;

    p130.Speed = NumberRange.new(Speed.Min * p131, Speed.Max * p131);
    p130.Acceleration = p130.Acceleration * p131;
end;

function u1.ScaleParticle(p134, p135) -- Line: 584
    -- upvalues: u1 (copy)
    for _, v in ipairs(p134:QueryDescendants("ParticleEmitter")) do
        u1._ScaleParticle(v, p135);
    end;

    if p134:IsA("ParticleEmitter") then
        u1._ScaleParticle(p134, p135);
    end;
end;

function u1.TweenScale(u136, u137, u138) -- Line: 594
    -- upvalues: TweenService (copy)
    local Size = u136.Size;
    local Speed = u136.Speed;
    task.spawn(function() -- Line: 598
        -- upvalues: u138 (copy), u136 (copy), TweenService (ref), u137 (copy), Size (copy), Speed (copy)
        local v139 = 0;

        for i = 1, 60 * u138.Time do
            repeat
                v139 = v139 + task.wait();
            until v139 > 0.016666666666666666;

            v139 = v139 - 0.016666666666666666;

            if not u136:IsDescendantOf(game) then
                break;
            end;

            local v140 = TweenService:GetValue(i / (60 * u138.Time), u138.EasingStyle, u138.EasingDirection);
            local v141 = 1 + (u137 - 1) * v140;
            local v142 = {};

            for i2 = 1, #Size.Keypoints do
                local v143 = Size.Keypoints[i2];
                v142[i2] = NumberSequenceKeypoint.new(v143.Time, v143.Value * v141, v143.Envelope * v141);
            end;

            u136.Size = NumberSequence.new(v142);
            u136.Speed = NumberRange.new(Speed.Min * v141, Speed.Max * v141);
        end;
    end);
end;

function u1.ScaleLifetime(p144, p145) -- Line: 630
    if p144 and p144:IsA("ParticleEmitter") then
        p144.Lifetime = NumberRange.new(p144.Lifetime.Min / p145, p144.Lifetime.Max / p145);
    end;

    for _, v in ipairs(p144:QueryDescendants("ParticleEmitter")) do
        v.Lifetime = NumberRange.new(v.Lifetime.Min / p145, v.Lifetime.Max / p145);
    end;
end;

function u1.EnableParticle(p146, p147) -- Line: 644
    -- upvalues: u1 (copy)
    if p146 then
        for _, v in ipairs(p146:QueryDescendants("ParticleEmitter")) do
            v.Enabled = p147;
        end;

        return u1.GetMaxLifetime(p146);
    end;
end;

function u1.EnableParticleBeams(p148, p149) -- Line: 653
    -- upvalues: u1 (copy)
    if p148 then
        for _, descendant in ipairs(p148:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = p149;
            end;
        end;

        return u1.GetMaxLifetime(p148);
    end;
end;

function u1.EnableParticleTrails(p150, p151, p152) -- Line: 662
    -- upvalues: u1 (copy)
    if p150 then
        for _, v in ipairs(p150:QueryDescendants("Trail")) do
            if typeof(p152) ~= "table" or not table.find(p152, v.Name) then
                v.Enabled = p151;
            end;
        end;

        return u1.GetMaxLifetime(p150);
    end;
end;

function u1.EnableAllParticles(p153, p154, p155) -- Line: 675
    -- upvalues: u1 (copy)
    if p153 then
        local v156 = next;
        local v157, v158 = p153:QueryDescendants("ParticleEmitter, Trail, Beam, Light");

        for _, v in v156, v157, v158 do
            if not p155 or v.Name == p155 then
                v.Enabled = p154;
            end;
        end;

        return u1.GetMaxLifetime(p153);
    end;
end;

function u1.DestroyParticle(p159, p160) -- Line: 691
    -- upvalues: u1 (copy)
    if p159 then
        local v161 = p160 or u1.GetMaxLifetime(p159);
        task.delay(v161, p159.Destroy, p159);

        return v161;
    end;
end;

function u1.ClearParticles(p162, p163) -- Line: 698
    if not p162 then
        return;
    end;

    if p162:IsA("ParticleEmitter") then
        if p163 and p162.Name == p163 then
            p162:Clear();
        elseif not p163 then
            p162:Clear();
        end;
    end;

    local v164 = next;
    local v165, v166 = p162:QueryDescendants("ParticleEmitter");

    for _, v in v164, v165, v166 do
        if not p163 or v.Name == p163 then
            v:Clear();
        end;
    end;
end;

function u1.EnableVFX(p167, p168, p169) -- Line: 720
    if table.find(p169, p167.ClassName) then
        p167.Enabled = p168;
    end;

    for _, descendant in p167:GetDescendants() do
        if table.find(p169, descendant.ClassName) then
            descendant.Enabled = p168;
        end;
    end;
end;

function u1.UpdateAttributeColors(p170, p171) -- Line: 731
    local v172 = p171 or {};

    if not p170 then
        return;
    end;

    for _, v in pairs(p170:QueryDescendants("ParticleEmitter")) do
        for i, v2 in v172 do
            if typeof(i) == "string" and v:GetAttribute(i) then
                local v173 = typeof(v2);

                if v173 == "Color3" then
                    v.Color = ColorSequence.new(v2);
                elseif v173 == "ColorSequence" then
                    v.Color = v2;
                end;
            end;
        end;
    end;
end;

function u1.SetBeamAttachments(p174, p175, p176) -- Line: 752
    if not p174 then
        return;
    end;

    for _, v in ipairs(p174:QueryDescendants("Beam")) do
        v.Attachment0 = p175;

        if p176 then
            v.Attachment1 = p176;
        end;
    end;
end;

local u177 = RaycastParams.new();
u177.FilterType = Enum.RaycastFilterType.Include;
u177.FilterDescendantsInstances = { workspace.Map };

function u1.UpdateGroundColors(p178, p179) -- Line: 767
    -- upvalues: u1 (copy), u177 (copy)
    if not p179 then
        return;
    end;

    local v180 = u1.TranslateToCFrame(p179);
    local v181 = workspace:Raycast(v180.Position, Vector3.new(0, -10, 0), u177);

    if v181 then
        local v182, v183, v184 = v181.Instance.Color:ToHSV();

        for _, descendant in p178:GetDescendants() do
            if descendant:GetAttribute("UseGroundColor") then
                descendant.Color = u1.HSVShift(descendant.Color, {
                    Hue = v182,
                    Saturation = v183,
                    Value = v184
                });
            end;
        end;
    end;
end;

function u1.GetHSVShift(p185) -- Line: 786
    -- upvalues: u1 (copy)
    local v186 = u1.GetSkinInfo(p185.SkinName) or {};

    if p185.Metadata.UnusualHueShift then
        return {
            HueShift = p185.Metadata.UnusualHueShift
        };
    end;

    if p185.Stats.HSVShift then
        return p185.Stats.HSVShift;
    end;

    if v186.Metadata then
        return v186.Metadata.HSVShift;
    end;

    return nil;
end;

u1.EnableParticles = u1.EnableParticle;
u1.GetParticleInfo = ParticleInfo.GetParticleInfo;
u1.GetSkinInfo = ParticleInfo.GetSkinInfo;
u1.DestroyByMaxLifetime = u1.DestroyParticle;
u1.HSVShiftColor = u1.HSVShift;

local function GetCharacter(p187) -- Line: 804
    local v188 = p187.Player or p187.Character;

    if not v188 then
        return nil;
    end;

    if v188:IsA("Player") then
        v188 = v188.Character;
    end;

    return v188;
end;

if RunService:IsClient() then
    function u1.Chromaify(p189, p190) -- Line: 814
        -- upvalues: PathShortcuts (copy)
        local v191 = p190.Player or p190.Character;

        if v191 then
            if v191:IsA("Player") then
                v191 = v191.Character;
            end;
        else
            v191 = nil;
        end;

        if v191 == nil then
            return;
        end;

        PathShortcuts.Remotes.ClientBind:Fire(v191, "Chroma", p189);
    end;
else
    function u1.Chromaify(u192, p193) -- Line: 820
        -- upvalues: PathShortcuts (copy)
        local u194 = p193.Player or p193.Character;

        if u194 then
            if u194:IsA("Player") then
                u194 = u194.Character;
            end;
        else
            u194 = nil;
        end;

        if u194 == nil then
            return;
        end;

        if p193.Delay then
            task.delay(p193.Delay, function() -- Line: 824
                -- upvalues: PathShortcuts (ref), u194 (copy), u192 (copy)
                PathShortcuts.Remotes.ClientBindR:FireAllClients(u194, "Chroma", u192);
            end);

            return;
        end;

        PathShortcuts.Remotes.ClientBindR:FireAllClients(u194, "Chroma", u192);
    end;
end;

if RunService:IsServer() then
    function u1.GetChromaHueShift() -- Line: 835
        local v195 = tick() * 0.25 % 1 * 360;

        return math.floor(v195);
    end;

    return u1;
end;

local u196 = ReplicatedStorage:GetAttribute("ChromaHue");
ReplicatedStorage:GetAttributeChangedSignal("ChromaHue"):Connect(function() -- Line: 840
    -- upvalues: u196 (ref), ReplicatedStorage (copy)
    u196 = ReplicatedStorage:GetAttribute("ChromaHue");
end);

function u1.GetChromaHueShift() -- Line: 844
    -- upvalues: u196 (ref)
    return u196;
end;

return u1;