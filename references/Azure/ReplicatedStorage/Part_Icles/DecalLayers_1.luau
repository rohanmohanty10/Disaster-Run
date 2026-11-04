 
 

local Graph = require(script.Parent.Graph);
local Range = require(script.Parent.Range);
local Flipbook = require(script.Parent.Flipbook);
local Colors = require(script.Parent.Container.Colors);
local u1 = {};
local Color3_new_ret = Color3.new(1, 1, 1);

local function isLayerInstance(p2) -- Line: 36
    return p2:IsA("Decal") or p2:IsA("Texture");
end;

local function readLayers(p3) -- Line: 41
    local v4 = {};

    if not p3 then
        return v4;
    end;

    local v5 = {};

    for _, child in ipairs(p3:GetChildren()) do
        if child:IsA("Decal") or child:IsA("Texture") then
            v5[child.Name] = (v5[child.Name] or 0) + 1;
            local Attribute = child:GetAttribute("LayerColor");

            if typeof(Attribute) ~= "ColorSequence" then
                Attribute = ColorSequence.new(child.Color3);
            end;

            local v6 = {
                name = child.Name,
                occurrence = v5[child.Name],
                texture = child.Texture,
                transparency = child:GetAttribute("LayerTransparency"),
                color = Attribute,
                brightness = child:GetAttribute("LayerBrightness"),
                flipbook = child:GetAttribute("LayerFlipbook"),
                mode = child:GetAttribute("LayerFlipbookMode"),
                framerate = child:GetAttribute("LayerFlipbookFramerate"),
                startRandom = child:GetAttribute("LayerFlipbookStartRandom"),
                reverse = child:GetAttribute("LayerFlipbookReverse")
            };
            table.insert(v4, v6);
        end;
    end;

    return v4;
end;

function u1.readInto(p7, p8, p9) -- Line: 69
    -- upvalues: Flipbook (copy), readLayers (copy)
    p7.DecalLayersMode = p9:GetAttribute("DecalLayers") == true;
    p7.MeshFlipbooks = p8:FindFirstChild("MeshFlipbooks");
    p7.MeshFlipbookSets = p7.MeshFlipbooks and (Flipbook.GetFlipbookSets(p7.MeshFlipbooks) or {}) or {};
    p7.CachedMeshTextures = p7.MeshFlipbookSets[""];

    if not p7.CachedMeshTextures then
        local v10 = {};

        for i in pairs(p7.MeshFlipbookSets) do
            table.insert(v10, i);
        end;

        table.sort(v10);

        if v10[1] then
            p7.CachedMeshTextures = p7.MeshFlipbookSets[v10[1]];
        end;
    end;

    p7.DecalLayers = p7.DecalLayersMode and readLayers(p8:FindFirstChild("RenderTemplate")) or {};
end;

local function framesFor(p11, p12, p13) -- Line: 84
    local flipbook = p12.flipbook;

    if flipbook == "None" then
        return nil;
    end;

    if flipbook ~= nil and flipbook ~= "" then
        return p11.MeshFlipbookSets[flipbook];
    end;

    if p13 == 1 then
        return p11.MeshFlipbookSets[""];
    end;

    return nil;
end;

function u1.attach(p14, p15, p16, p17, p18) -- Line: 96
    -- upvalues: Graph (copy), Range (copy), Flipbook (copy), u1 (copy)
    p14.Layers = nil;
    local DecalLayers = p15.DecalLayers;

    if not (p15.DecalLayersMode and (DecalLayers and #DecalLayers ~= 0)) then
        return;
    end;

    local ParticleData = p15.ParticleData;
    local v19 = {};

    for i, v in ipairs(DecalLayers) do
        v19[v.name .. "#" .. v.occurrence] = i;
    end;

    local v20;

    if p15.MeshFramesTextured == true then
        v20 = p16:FindFirstChildOfClass("SpecialMesh") ~= nil;
    else
        v20 = false;
    end;

    local v21 = {};
    local v22 = {};

    for _, child in ipairs(p16:GetChildren()) do
        if child:IsA("Decal") or child:IsA("Texture") then
            v22[child.Name] = (v22[child.Name] or 0) + 1;
            local v23 = v19[child.Name .. "#" .. v22[child.Name]];
            local v24;

            if v23 then
                v24 = DecalLayers[v23];
            else
                v24 = v23;
            end;

            if v24 then
                local v25 = {
                    decal = child,
                    transparency = v24.transparency,
                    color = v24.color,
                    brightness = v24.brightness,
                    transparencySeed = Graph.GenerateSeed(v24.transparency),
                    brightnessSeed = Graph.GenerateSeed(v24.brightness)
                };

                if p18 then
                    v25.snapshot = {
                        transparency = child.Transparency,
                        color = child.Color3,
                        texture = child.Texture
                    };
                elseif not v20 or v23 ~= 1 then
                    local flipbook = v24.flipbook;
                    local v26;

                    if flipbook == "None" then
                        v26 = nil;
                    elseif flipbook == nil or flipbook == "" then
                        if v23 == 1 then
                            v26 = p15.MeshFlipbookSets[""];
                        else
                            v26 = nil;
                        end;
                    else
                        v26 = p15.MeshFlipbookSets[flipbook];
                    end;

                    local v27 = v24.mode or (ParticleData.FlipbookMode and (ParticleData.FlipbookMode.Name or "None") or "None");

                    if v26 and (#v26 > 0 and v27 ~= "None") then
                        local v28 = Range.RandomValueFromRange(v24.framerate or (ParticleData.FlipbookFramerate or NumberRange.new(30)));
                        local startRandom = v24.startRandom;

                        if startRandom == nil then
                            startRandom = ParticleData.FlipbookStartRandom;
                        end;

                        local reverse = v24.reverse;

                        if reverse == nil then
                            reverse = ParticleData.FlipbookReverse;
                        end;

                        v25.flip = Flipbook.layerState(child, v26, v27, v28, startRandom, reverse);
                    else
                        child.Texture = v24.texture;
                    end;
                end;

                table.insert(v21, v25);
            end;
        end;
    end;

    if #v21 == 0 then
        return;
    end;

    p14.Layers = v21;
    u1.write(p14, 0);

    if not p18 then
        Flipbook.FlipLayers(p14, v21, p17);
    end;
end;

function u1.write(p29, p30) -- Line: 146
    -- upvalues: Graph (copy), Color3_new_ret (copy), Colors (copy)
    local Layers = p29.Layers;

    if not Layers then
        return;
    end;

    for i = 1, #Layers do
        local v31 = Layers[i];
        local decal = v31.decal;
        local v32 = v31.transparency and (Graph.QueryPointsWithTime(p30, v31.transparency, v31.transparencySeed) or 0) or 0;
        local v33 = v31.brightness and (Graph.QueryPointsWithTime(p30, v31.brightness, v31.brightnessSeed) or 1) or 1;
        local v34 = v31.color and Graph.QueryColorPointWithTime(p30, v31.color) or Color3_new_ret;
        local _drive = p29._drive;

        if _drive then
            v33 = v33 * _drive.brightness;

            if _drive.look then
                v34 = Colors.driven(v31, v34, _drive);
            end;
        end;

        if not p29.SkipTransparency then
            decal.Transparency = v32;
        end;

        local v35;

        if p29.SkipColor then
            v35 = i;
        else
            decal.Color3 = Color3.fromRGB(v34.R * 255 * v33, v34.G * 255 * v33, v34.B * 255 * v33);
            v35 = i;
        end;
    end;
end;

function u1.restore(p36) -- Line: 169
    local Layers = p36.Layers;

    if not Layers then
        return;
    end;

    for i = 1, #Layers do
        local u37 = Layers[i];
        local snapshot = u37.snapshot;
        local v38;

        if snapshot and u37.decal.Parent then
            pcall(function() -- Line: 176
                -- upvalues: u37 (copy), snapshot (copy)
                u37.decal.Transparency = snapshot.transparency;
                u37.decal.Color3 = snapshot.color;
                u37.decal.Texture = snapshot.texture;
            end);
            v38 = i;
        else
            v38 = i;
        end;
    end;
end;

function u1.refresh(p39, p40) -- Line: 186
    -- upvalues: Graph (copy)
    local Layers = p39.Layers;

    if not (Layers and p40.DecalLayers) then
        return;
    end;

    local v41 = {};

    for _, v in ipairs(p40.DecalLayers) do
        v41[v.name .. "#" .. v.occurrence] = v;
    end;

    local v42 = {};

    for i = 1, #Layers do
        local v43 = Layers[i];
        local Name = v43.decal.Name;
        v42[Name] = (v42[Name] or 0) + 1;
        local v44 = v41[Name .. "#" .. v42[Name]];
        local v45;

        if v44 then
            local color = v44.color;
            local brightness = v44.brightness;
            v43.transparency = v44.transparency;
            v43.color = color;
            v43.brightness = brightness;
            v43.transparencySeed = Graph.GenerateSeed(v44.transparency);
            v43.brightnessSeed = Graph.GenerateSeed(v44.brightness);
            v45 = i;
        else
            v45 = i;
        end;
    end;
end;

return u1;