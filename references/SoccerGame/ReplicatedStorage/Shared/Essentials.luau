  

local v1 = {};
local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
local Lighting = game:GetService("Lighting");

function v1.HideCharacter(p2: table, p3: userdata, p4: any) -- Line: 7
    -- upvalues: TweenService (copy)
    if p3:GetAttribute("Invis") then
        return;
    end;

    p3:SetAttribute("Invis", true);

    for _, descendant in p3:GetDescendants() do
        if descendant.Name ~= "BALL" then
            if descendant:IsA("BasePart") or (descendant:IsA("Decal") or (descendant:IsA("ParticleEmitter") or descendant:IsA("Beam"))) then
                if not (table.find(p4, descendant) or (descendant.Parent.Name == "Marker" or descendant:GetAttribute("Invis"))) then
                    descendant:SetAttribute("Invis", true);
                    TweenService:Create(descendant, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        LocalTransparencyModifier = 1
                    }):Play();
                end;
            elseif descendant:IsA("SurfaceGui") and (descendant.Enabled and not descendant:GetAttribute("Invis")) then
                descendant:SetAttribute("Invis", true);
                descendant.Enabled = false;
            end;
        end;
    end;
end;

function v1.UnhideCharacter(p5: table, p6: userdata, p7: any) -- Line: 29
    -- upvalues: TweenService (copy)
    if not p6:GetAttribute("Invis") then
        return;
    end;

    p6:SetAttribute("Invis", nil);

    for _, descendant in p6:GetDescendants() do
        if descendant.Name ~= "BALL" then
            if descendant:IsA("BasePart") or (descendant:IsA("Decal") or (descendant:IsA("ParticleEmitter") or descendant:IsA("Beam"))) then
                if not table.find(p7, descendant) and descendant:GetAttribute("Invis") then
                    descendant:SetAttribute("Invis", false);
                    TweenService:Create(descendant, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        LocalTransparencyModifier = 0
                    }):Play();
                end;
            elseif descendant:IsA("SurfaceGui") and descendant:GetAttribute("Invis") then
                descendant:SetAttribute("Invis", nil);
                descendant.Enabled = true;
            end;
        end;
    end;
end;

function v1.HideCosmetics(p8: table, p9: userdata) -- Line: 49
    -- upvalues: CollectionService (copy), ReplicatedStorage (copy)
    local v10 = {
        Char = p9,
        Items = {}
    };

    for _, descendant in p9:GetDescendants() do
        local v11 = descendant;

        for i = 1, 2 do
            local v12;

            if CollectionService:HasTag(v11, (`Cosmetic{i}`)) then
                table.insert(v10.Items, {
                    Item = v11,
                    Parent = v11.Parent
                });
                v11.Parent = ReplicatedStorage;
                v12 = i;
            else
                v12 = i;
            end;
        end;
    end;

    return v10;
end;

function v1.UnhideCosmetics(p13: table, p14: table?) -- Line: 65
    -- upvalues: CollectionService (copy)
    if not (p14 and p14.Items) then
        return p14;
    end;

    local Char = p14.Char;
    local v15;

    if Char == nil then
        v15 = false;
    else
        v15 = Char:IsDescendantOf(workspace);
    end;

    if not v15 then
        for _, v in p14.Items do
            if v.Item then
                v.Item:Destroy();
            end;
        end;

        return p14;
    end;

    local v16 = {};
    local v17 = {};

    for _, v in p14.Items do
        if v.Item then
            v16[v.Item] = true;

            for _, v2 in CollectionService:GetTags(v.Item) do
                if string.match(v2, "^Cosmetic%d+$") then
                    v17[v2] = true;
                end;
            end;
        end;
    end;

    for _, descendant in Char:GetDescendants() do
        if not v16[descendant] then
            local v18 = descendant;

            for i in v17 do
                if CollectionService:HasTag(v18, i) then
                    v18:Destroy();
                    break;
                end;
            end;
        end;
    end;

    for _, v in p14.Items do
        if v.Item then
            v.Item.Parent = v.Parent;
        end;
    end;

    return p14;
end;

function v1.CreateClone(p19: table, p20: userdata, p21: any) -- Line: 125
    -- upvalues: TweenService (copy)
    p20.Archivable = true;
    local v22 = p20:Clone();
    v22.Parent = workspace.Debris;
    local v23 = p21 or 0.5;

    for _, descendant in v22:GetDescendants() do
        if descendant:IsA("Script") or (descendant:IsA("LocalScript") or (descendant:IsA("Highlight") or (descendant:IsA("Sound") or (descendant:IsA("SurfaceGui") or (descendant:IsA("Decal") or (descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail")))))))) then
            descendant:Destroy();
        elseif descendant:IsA("BasePart") or descendant:IsA("MeshPart") then
            descendant.Anchored = true;
            descendant.CanCollide = false;
            descendant.CanTouch = false;
            descendant.CanQuery = false;

            if v22:GetAttribute("Invis") and descendant.Name ~= "BALL" then
                descendant.Transparency = descendant.Transparency - 1;
                TweenService:Create(descendant, TweenInfo.new(v23), {
                    Transparency = 1
                }):Play();
            else
                TweenService:Create(descendant, TweenInfo.new(v23), {
                    Transparency = 1
                }):Play();
            end;
        elseif descendant:IsA("Humanoid") then
            descendant.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None;
        end;
    end;

    p20.Archivable = false;

    return v22;
end;

function v1.FixAlignment(p24, p25) -- Line: 156
    local Torso = p25:FindFirstChild("Torso");
    local v26 = Torso and Torso:FindFirstChild("Left Hip");

    if v26 then
        v26.C0 = CFrame.new(-1, -1, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0) * CFrame.new(0, 0.01, 0);
        task.wait(0.15);
        v26.C0 = CFrame.new(-1, -1, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0);
    end;
end;

function v1.Lerp(p27, p28, p29, p30) -- Line: 168
    return p28 + (p29 - p28) * p30;
end;

function v1.Highlight(p31, p32) -- Line: 172
    local Highlight = Instance.new("Highlight");
    Highlight.Parent = p32;
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.FillTransparency = 1;
    Highlight.OutlineTransparency = 1;
    Highlight.FillColor = Color3.new(1, 1, 1);

    return Highlight;
end;

function v1.Aura(p33, p34, p35, p36) -- Line: 183
    if not p34:IsA("Model") then
        p34 = p34.Character;
    end;

    if not p36 then
        local Descendants = p34:GetDescendants();

        for _, v in pairs(Descendants) do
            if v ~= nil and (v.Parent ~= nil and (v.Name == "AuraParticle" or v.Parent.Name == "AuraParticle")) then
                if v.Parent:IsA("Attachment") then
                    v.Parent:Destroy();
                else
                    v:Destroy();
                end;
            end;
        end;

        table.clear(Descendants);

        return;
    end;

    local Descendants = p35:GetDescendants();
    local v37 = {};

    for _, v in pairs(Descendants) do
        if v:IsA("ParticleEmitter") == false and v:IsA("Beam") == false then
            if v:IsA("Highlight") then
                local v38 = v:Clone();
                v38.Name = "AuraParticle";
                v38.Parent = p34;
            end;
        elseif not v37[v.Parent] then
            if v:IsA("ParticleEmitter") then
                if v.Parent:IsA("Attachment") then
                    if v.Parent.Parent:IsA("Attachment") then
                        v37[v.Parent] = true;
                        local v39 = v.Parent.Parent:Clone();
                        v39.Name = "AuraParticle";
                        v39.Parent = p34[v.Parent.Parent.Parent.Name];
                    else
                        v37[v.Parent] = true;
                        local v40 = v.Parent:Clone();
                        v40.Name = "AuraParticle";
                        v40.Parent = p34[v.Parent.Parent.Name];
                    end;
                else
                    local v41 = v:Clone();
                    v41.Name = "AuraParticle";
                    v41.Parent = p34[v.Parent.Name];
                end;
            elseif v:IsA("Beam") then
                local v42;

                if v.Parent:IsA("Attachment") then
                    if v.Parent.Parent:IsA("Attachment") then
                        v42 = v.Parent.Parent.Parent.Name;
                    else
                        v42 = v.Parent.Parent.Name;
                    end;
                else
                    v42 = v.Parent.Name;
                end;

                local v43 = v:Clone();
                v43.Name = "AuraParticle";
                local v44 = v.Attachment0:Clone();
                v44.Name = "AuraParticle";
                v44.Parent = p34[v42];
                local v45 = v.Attachment1:Clone();
                v45.Name = "AuraParticle";
                v45.Parent = p34[v42];
                v43.Attachment0 = v44;
                v43.Attachment1 = v45;
                v43.Parent = p34[v42];
            end;
        end;
    end;

    table.clear(v37);
    table.clear(Descendants);
end;

function v1.HasItem(p46, p47, p48, p49) -- Line: 282
    for _, v in pairs(p47.Data.Customization[p48]) do
        if v == p49 then
            return true;
        end;
    end;

    return false;
end;

function v1.TableLength(p50, p51) -- Line: 291
    local v52 = 0;

    for _, _ in pairs(p51) do
        v52 = v52 + 1;
    end;

    return v52;
end;

function v1.formatTime(p53, p54) -- Line: 299
    local math_floor_ret = math.floor(p54 / 3600);
    local math_floor_ret2 = math.floor((p54 - math_floor_ret * 3600) / 60);

    return ("%01d:%02d"):format(math_floor_ret2, (math.floor(p54 - math_floor_ret * 3600 - math_floor_ret2 * 60)));
end;

function v1.formatLimited(p55, p56) -- Line: 307
    local math_floor_ret = math.floor(p56 / 3600);
    local math_floor_ret2 = math.floor((p56 - math_floor_ret * 3600) / 60);
    math.floor(p56 - math_floor_ret * 3600 - math_floor_ret2 * 60);

    return ("%01d:%02d"):format(math_floor_ret, math_floor_ret2);
end;

function v1.ShouldGive(p57) -- Line: 315
    -- upvalues: CollectionService (copy)
    if game:GetService("RunService"):IsStudio() then
        return true;
    end;

    local v58 = 0;

    for _, v in CollectionService:GetTagged("PlayingTeam") do
        v58 = v58 + #v:GetPlayers();
    end;

    return v58 >= 4;
end;

function v1.formatCompleteTime(p59, p60) -- Line: 330
    local math_floor_ret = math.floor(p60 / 3600);
    local math_floor_ret2 = math.floor((p60 - math_floor_ret * 3600) / 60);

    return ("%02d:%02d:%02d"):format(math_floor_ret, math_floor_ret2, (math.floor(p60 - math_floor_ret * 3600 - math_floor_ret2 * 60)));
end;

function v1.Weld(p61, p62, p63, p64) -- Line: 338
    local WeldConstraint = Instance.new("WeldConstraint");
    WeldConstraint.Part0 = p62;
    WeldConstraint.Part1 = p63;
    WeldConstraint.Parent = p64 or p62;

    return WeldConstraint;
end;

function v1.WeldOffset(p65: table, p66: userdata, p67: userdata, p68) -- Line: 346
    local Weld = Instance.new("Weld");
    Weld.Part0 = p66;
    Weld.Part1 = p67;
    Weld.C0 = p68;
    Weld.Parent = p67;

    return Weld;
end;

function v1.formatNumberWithCommas(p69, p70) -- Line: 356
    local string_format_ret = string.format("%d", p70);
    local string_match_ret, v71, v72 = string.match(string_format_ret, "^([^%d]*%d)(%d*)(.-)$");

    return string_match_ret .. v71:reverse():gsub("(%d%d%d)", "%1,"):reverse() .. v72;
end;

function v1.GetRandomPositionInVolume(p73: table, p74, p75: vector, p76: any) -- Line: 362
    local Random_new_ret = Random.new();
    local v77 = p75 * 0.5;
    local v78 = Random_new_ret:NextNumber(-v77.X, v77.X);
    local v79 = Random_new_ret:NextNumber(-v77.Z, v77.Z);
    local v80 = p76 == true and Random_new_ret:NextNumber(-v77.Y, v77.Y) or 0;

    return p74:PointToWorldSpace((Vector3.new(v78, v80, v79)));
end;

function v1.StoreInitialData(p81: table, p82: any, p83: table?, p84: boolean?) -- Line: 387
    local v85 = p83 or p81:_getInitialDataProperties(p82);

    if v85 then
        for _, v in p83 or (v85 or {}) do
            if p84 or not p82:GetAttribute((`Original{v}`)) then
                p82:SetAttribute(`Original{v}`, p82[v]);
            end;
        end;

        return v85;
    end;
end;

function v1.GetInitialData(p86, p87, p88) -- Line: 408
    local v89 = p86:StoreInitialData(p87, p88);

    if v89 then
        local v90 = {};

        for _, v in v89 do
            v90[v] = p87:GetAttribute((`Original{v}`));
        end;

        return v90;
    end;
end;

function v1._getInitialDataProperties(p91: table, p92: userdata) -- Line: 425
    local ClassName = p92.ClassName;

    return ClassName == "Atmosphere" and { "Density", "Offset", "Color", "Decay", "Glare", "Haze" } or (ClassName == "BloomEffect" and { "Intensity", "Size", "Threshold" } or (ClassName == "BlurEffect" and { "Size" } or (ClassName == "ColorCorrection" and { "Brightness", "Contrast", "Saturation", "TintColor" } or (ClassName == "DepthOfFieldEffect" and { "FarIntensity", "FocusDistance", "InFocusRadius", "NearIntensity" } or (ClassName == "SunRaysEffect" and { "Intensity", "Spread" } or (ClassName == "Lighting" and { "Ambient", "Brightness", "ColorShift_Bottom", "ColorShift_Top", "EnvironmentDiffuseScale", "EnvironmentSpecularScale", "OutdoorAmbient", "ShadowSoftness", "TimeOfDay", "GeographicLatitude", "ExposureCompensation" } or {}))))));
end;

v1:StoreInitialData(Lighting);

for _, child in Lighting:GetChildren() do
    v1:StoreInitialData(child);
end;

v1:StoreInitialData(workspace.Field.Field, { "Color" });

return v1;