 

 

local TypeRegistry = require(script.Parent.TypeRegistry);
require(script.Parent.PartConstants);
local DragModel = require(script.Parent.DragModel);
local AtRest = require(script.Parent.AtRest);

return function(u1) -- Line: 12
    -- upvalues: TypeRegistry (copy), DragModel (copy), AtRest (copy)
    if not u1.TransformCompleted then
        u1.TransformCompleted = Instance.new("BindableEvent");
    end;

    local function isWithin(p2, p3) -- Line: 20
        return p2 == p3 and true or p2:IsDescendantOf(p3);
    end;

    local function isNestedContent(p4, p5) -- Line: 27
        if p4:GetAttribute("Transformed") or p4:IsA("Attachment") then
            return true;
        end;

        if p4:IsA("ParticleEmitter") or p4:IsA("Light") then
            return true;
        end;

        if not (p4:IsA("Beam") or p4:IsA("Trail")) then
            return false;
        end;

        local Attachment0 = p4.Attachment0;
        local Attachment1 = p4.Attachment1;
        local v6 = (Attachment0 == nil or (Attachment0 == p5 and true or Attachment0:IsDescendantOf(p5))) and (Attachment1 == nil and true or (Attachment1 == p5 and true or Attachment1:IsDescendantOf(p5)));

        return v6;
    end;

    local function carriedChildren(p7, p8, p9) -- Line: 40
        -- upvalues: isNestedContent (copy)
        local v10 = {};
        local v11 = {};

        for _, child in ipairs(p7:GetChildren()) do
            if p8 and isNestedContent(child, p7) then
                table.insert(v10, child);
            elseif p9 and (child:IsA("SpecialMesh") or child:IsA("Decal")) then
                table.insert(v11, child);
            end;
        end;

        return v10, v11;
    end;

    local function cloneWithout(p12, p13) -- Line: 57
        local table_create_ret = table.create(#p13);

        for i, v in ipairs(p13) do
            table_create_ret[i] = v.Archivable;
            v.Archivable = false;
        end;

        local v14 = p12:Clone();

        for i, v in ipairs(p13) do
            v.Archivable = table_create_ret[i];
        end;

        return v14;
    end;

    local u15 = {
        EmitParent = true,
        Link = true,
        AccelTarget = true,
        [TypeRegistry.CONFIG_NAME] = true
    };

    function u1.Transform(p16, u17) -- Line: 76
        -- upvalues: TypeRegistry (ref), DragModel (ref), carriedChildren (copy), cloneWithout (copy), AtRest (ref), u1 (copy)
        if u17:GetAttribute("Transformed") then
            return;
        end;

        local TypeFor = TypeRegistry.getTypeFor(u17);

        if not TypeFor and (u17:IsA("Model") or u17:IsA("BasePart")) and (u17:GetAttribute("IsReactor") and TypeRegistry.Types.Reactor) then
            return p16:TransformReactor(u17, TypeRegistry.Types.Reactor);
        end;

        if not TypeFor then
            if u17:IsA("BasePart") and (u17:GetAttribute("IsLightning") and TypeRegistry.Types.Lightning) then
                TypeFor = TypeRegistry.Types.Lightning;
            elseif u17:IsA("BasePart") and (u17:GetAttribute("IsCameraShake") and TypeRegistry.Types.CameraShake) then
                TypeFor = TypeRegistry.Types.CameraShake;
            elseif u17:IsA("BasePart") and (u17:GetAttribute("IsRocks") and TypeRegistry.Types.Rocks) then
                TypeFor = TypeRegistry.Types.Rocks;
            elseif u17:IsA("BasePart") and (u17:GetAttribute("IsRope") and TypeRegistry.Types.Rope) then
                TypeFor = TypeRegistry.Types.Rope;
            elseif u17:IsA("BasePart") and (u17:GetAttribute("IsDistortion") and TypeRegistry.Types.Distortion) then
                TypeFor = TypeRegistry.Types.Distortion;
            elseif (u17:IsA("BasePart") or u17:IsA("Attachment")) and (u17:GetAttribute("IsContainer") and TypeRegistry.Types.Container) then
                TypeFor = TypeRegistry.Types.Container;
            elseif (u17:IsA("BasePart") or u17:IsA("Attachment")) and (u17:GetAttribute("IsForce") and TypeRegistry.Types.Force) then
                TypeFor = TypeRegistry.Types.Force;
            else
                if not (u17:IsA("BasePart") and (u17:GetAttribute("IsMatte") and TypeRegistry.Types.Matte)) then
                    return;
                end;

                TypeFor = TypeRegistry.Types.Matte;
            end;
        end;

        local v18 = TypeFor == TypeRegistry.Types.Lightning;
        local v19 = TypeFor == TypeRegistry.Types.CameraShake;
        local v20 = TypeFor == TypeRegistry.Types.Rocks;
        local v21 = TypeFor == TypeRegistry.Types.Rope;
        local v22 = TypeFor == TypeRegistry.Types.Distortion;
        local v23 = TypeFor == TypeRegistry.Types.Container and true or TypeFor == TypeRegistry.Types.Matte;
        local v24 = TypeFor == TypeRegistry.Types.Force;

        if TypeFor.directAccess then
            if u17:IsA("Trail") and TypeRegistry.Types.TrailEmitter then
                TypeFor = TypeRegistry.Types.TrailEmitter;
            else
                if not (u17:IsA("Beam") and TypeRegistry.Types.Beam) then
                    return;
                end;

                TypeFor = TypeRegistry.Types.Beam;
            end;
        end;

        if u17:IsA("Model") then
            return p16:TransformModel(u17, TypeFor);
        end;

        local v25 = TypeRegistry.createConfig(u17, TypeFor);
        DragModel.mark(v25);
        local v26 = not (v19 or (v22 or v24)) and (u17:IsA("BasePart") or u17:IsA("Attachment"));
        local v27 = u17:IsA("BasePart") and not v23;
        local v28, v29 = carriedChildren(u17, v26, v27);
        local v30 = cloneWithout(u17, table.move(v29, 1, #v29, #v28 + 1, table.clone(v28)));
        v30.Name = "RenderTemplate";

        for _, child in v30:GetChildren() do
            if not (child:GetAttribute("Transformed") or child:IsA("Attachment")) then
                if child.Name == TypeRegistry.CONFIG_NAME or (child.Name == "EmitParent" or (child.Name == "Link" or (child.Name == "AccelTarget" or (child.Name == "Target" or child.Name == "ImageFlipbooks")))) then
                    child:Destroy();
                elseif u17:IsA("Light") or (u17:IsA("Highlight") or u17:IsA("Sound")) then
                    child:Destroy();
                elseif u17:IsA("Attachment") then
                    if child.Name == "MeshFlipbooks" or (child.Name == "BeamFlipbooks" or child.Name == "GraphBlender") then
                        child:Destroy();
                    end;
                elseif u17:IsA("ImageLabel") then
                    if not child:IsA("UIComponent") then
                        child:Destroy();
                    end;
                elseif not (child:IsA("SpecialMesh") or (child:IsA("Decal") or (child:IsA("Texture") or child:IsA("SurfaceAppearance")))) then
                    child:Destroy();
                end;
            end;
        end;

        for _, v in ipairs({ "Transformed", "Qwinkle", "IsEmitter", "EmitCount", "EmitDuration", "EmitDelay", "EmissionMode", "AnimateLoop", "PreloadTexture", "LinkMode", "LinkSource" }) do
            v30:SetAttribute(v, nil);
        end;

        if v30:IsA("BasePart") then
            v30.Anchored = true;
            v30.CanCollide = false;
            v30.CanQuery = false;
            v30.CanTouch = false;
            v30.CastShadow = false;
            v30.Massless = true;
            v30.Locked = true;
            v30.Transparency = 1;

            for _, child in ipairs(v30:GetChildren()) do
                if child:IsA("Decal") or child:IsA("Texture") then
                    child.Transparency = 1;
                end;
            end;
        end;

        if v30:IsA("Attachment") then
            v30.CFrame = CFrame.new();
        end;

        v30.Parent = u17;

        for _, v in ipairs(v28) do
            v.Parent = v30;
        end;

        for _, descendant in ipairs(v30:GetDescendants()) do
            if (descendant:IsA("ParticleEmitter") or descendant:IsA("Trail")) and not descendant:GetAttribute("Transformed") then
                descendant.Enabled = false;
            end;
        end;

        AtRest.silence(v30);

        if u17:IsA("BasePart") and not (u17:IsA("Terrain") or (v19 or (v22 or (v23 or v24)))) then
            local Size = u17.Size;
            local v31 = u17:FindFirstChildWhichIsA("SpecialMesh");

            if v31 then
                Size = v31.Scale;
            end;

            local Color = u17.Color;
            local Transparency = u17.Transparency;

            if v18 or v21 then
                local NumberSequence_new = NumberSequence.new;
                local math_min_ret = math.min(u17.Size.X, u17.Size.Y);
                v25:SetAttribute("Thickness", NumberSequence_new((math.max(0.05, math_min_ret))));
            elseif not v20 then
                v25:SetAttribute("SizeX", NumberSequence.new(Size.X));
                v25:SetAttribute("SizeY", NumberSequence.new(Size.Y));
                v25:SetAttribute("SizeZ", NumberSequence.new(Size.Z));
                v25:SetAttribute("DecalLayers", true);
            end;

            v25:SetAttribute("Color", ColorSequence.new(Color));
            v25:SetAttribute("Transparency", NumberSequence.new(Transparency));
        end;

        if u17:IsA("BasePart") and not v23 then
            for _, v in ipairs(v29) do
                v.Parent = v30;

                if v:IsA("Decal") then
                    v.Transparency = 1;
                end;
            end;

            u17.Transparency = 1;

            if v20 then
                u17.CanCollide = false;
            end;
        elseif u17:IsA("Light") then
            u17.Enabled = false;
        elseif u17:IsA("Sound") then
            u17:Stop();
            u17.Playing = false;
        elseif u17:IsA("Highlight") then
            u17.Enabled = false;
        elseif u17:IsA("PostProcessEffect") then
            u17.Enabled = false;
        elseif u17:IsA("ImageLabel") then
            u17.Visible = false;
        end;

        if u17:IsA("Light") then
            v25:SetAttribute("PLRange", NumberSequence.new(u17.Range));
            v25:SetAttribute("PLBrightness", NumberSequence.new(u17.Brightness));
            v25:SetAttribute("PLColor", ColorSequence.new(u17.Color));
            v25:SetAttribute("Shadows", u17.Shadows);

            if u17:IsA("SpotLight") or u17:IsA("SurfaceLight") then
                v25:SetAttribute("PLAngle", NumberSequence.new(u17.Angle));
                v25:SetAttribute("PLFace", u17.Face.Name);
            end;
        end;

        if u17:IsA("Sound") then
            v25:SetAttribute("SndVolume", NumberSequence.new(u17.Volume));
            v25:SetAttribute("SndPlaybackSpeed", NumberSequence.new(u17.PlaybackSpeed));
            v25:SetAttribute("RollOffMin", u17.RollOffMinDistance);
            v25:SetAttribute("RollOffMax", u17.RollOffMaxDistance);
            v25:SetAttribute("Looped", u17.Looped);
            v30.Playing = false;
        end;

        if u17:IsA("BlurEffect") then
            v25:SetAttribute("BlurSize", NumberSequence.new(u17.Size));
        elseif u17:IsA("BloomEffect") then
            v25:SetAttribute("BloomIntensity", NumberSequence.new(u17.Intensity));
            v25:SetAttribute("BloomSize", NumberSequence.new(u17.Size));
            v25:SetAttribute("BloomThreshold", NumberSequence.new(u17.Threshold));
        elseif u17:IsA("ColorCorrectionEffect") then
            v25:SetAttribute("CCBrightness", NumberSequence.new(u17.Brightness));
            v25:SetAttribute("CCContrast", NumberSequence.new(u17.Contrast));
            v25:SetAttribute("CCSaturation", NumberSequence.new(u17.Saturation));
            v25:SetAttribute("CCTintColor", ColorSequence.new(u17.TintColor));
        elseif u17:IsA("Atmosphere") then
            v25:SetAttribute("AtmDensity", NumberSequence.new(u17.Density));
            v25:SetAttribute("AtmOffset", NumberSequence.new(u17.Offset));
            v25:SetAttribute("AtmGlare", NumberSequence.new(u17.Glare));
            v25:SetAttribute("AtmHaze", NumberSequence.new(u17.Haze));
            v25:SetAttribute("AtmColor", ColorSequence.new(u17.Color));
            v25:SetAttribute("AtmDecay", ColorSequence.new(u17.Decay));
        elseif u17:IsA("Highlight") then
            v25:SetAttribute("HLFillColor", ColorSequence.new(u17.FillColor));
            v25:SetAttribute("HLFillTransparency", NumberSequence.new(u17.FillTransparency));
            v25:SetAttribute("HLOutlineColor", ColorSequence.new(u17.OutlineColor));
            v25:SetAttribute("HLOutlineTransparency", NumberSequence.new(u17.OutlineTransparency));
            v25:SetAttribute("HLDepthMode", u17.DepthMode.Name);

            if not u17:FindFirstChild("Adornee") then
                local ObjectValue = Instance.new("ObjectValue");
                ObjectValue.Name = "Adornee";
                ObjectValue.Value = nil;
                ObjectValue.Parent = u17;
            end;
        end;

        if v30:IsA("PostProcessEffect") then
            v30.Enabled = false;
        end;

        if u17:IsA("ImageLabel") then
            if v30:IsA("ImageLabel") then
                v30.Visible = false;
            end;

            if u17.BackgroundTransparency == 0 then
                u17.BackgroundTransparency = 1;
            end;

            v25:SetAttribute("Image", u17.Image);
            v25:SetAttribute("Position", u17.Position);
            v25:SetAttribute("ImgSize", u17.Size);
            v25:SetAttribute("AnchorPoint", u17.AnchorPoint);
            v25:SetAttribute("ZIndex", u17.ZIndex);
            v25:SetAttribute("ScaleType", u17.ScaleType.Name);
            v25:SetAttribute("ResampleMode", u17.ResampleMode.Name);

            if not u17:FindFirstChild("ImageFlipbooks") then
                local Folder = Instance.new("Folder");
                Folder.Name = "ImageFlipbooks";
                Folder.Parent = u17;
            end;
        end;

        if u17:IsA("BasePart") and not (u17:IsA("Terrain") or (v18 or (v19 or (v20 or (v21 or (v22 or (v23 or (v24 or u17:FindFirstChild("MeshFlipbooks"))))))))) then
            local Folder = Instance.new("Folder");
            Folder.Name = "MeshFlipbooks";
            Folder.Parent = u17;
        end;

        if u17:IsA("Trail") then
            u17.Enabled = false;

            if v30:IsA("Trail") then
                v30.Enabled = false;
            end;

            v25:SetAttribute("TEmitBrightness", NumberSequence.new(u17.Brightness));
            v25:SetAttribute("TEmitLightEmission", NumberSequence.new(u17.LightEmission));
            v25:SetAttribute("TEmitLightInfluence", NumberSequence.new(u17.LightInfluence));
            v25:SetAttribute("TEmitTextureLength", NumberSequence.new(u17.TextureLength));
            v25:SetAttribute("TEmitMinLength", NumberSequence.new(u17.MinLength));
            v25:SetAttribute("TEmitMaxLength", NumberSequence.new(u17.MaxLength));
            v25:SetAttribute("TEmitTrailLife", NumberRange.new(u17.Lifetime));

            if not u17:FindFirstChild("GraphBlender") then
                local Folder = Instance.new("Folder");
                Folder.Name = "GraphBlender";
                local Configuration = Instance.new("Configuration");
                Configuration.Name = "1";
                Configuration:SetAttribute("Time", 0);
                Configuration:SetAttribute("Width", u17.WidthScale or NumberSequence.new(1));
                Configuration:SetAttribute("Transparency", u17.Transparency or NumberSequence.new(0));
                Configuration:SetAttribute("Color", u17.Color or ColorSequence.new(Color3.new(1, 1, 1)));
                Configuration:SetAttribute("_AutoTime", true);
                Configuration.Parent = Folder;
                Folder.Parent = u17;
            end;

            if not u17:FindFirstChild("TrailFlipbooks") then
                local Folder = Instance.new("Folder");
                Folder.Name = "TrailFlipbooks";
                Folder.Parent = u17;
            end;
        end;

        if u17:IsA("Beam") then
            u17.Enabled = false;
            u17.LightInfluence = 0;

            if v30:IsA("Beam") then
                v30.Enabled = false;
                v30.LightInfluence = 0;
            end;

            if not u17:FindFirstChild("BeamFlipbooks") then
                local Folder = Instance.new("Folder");
                Folder.Name = "BeamFlipbooks";
                Folder.Parent = u17;
            end;

            v25:SetAttribute("BeamBrightness", NumberSequence.new(u17.Brightness));
            v25:SetAttribute("CurveSize0", NumberSequence.new(u17.CurveSize0));
            v25:SetAttribute("CurveSize1", NumberSequence.new(u17.CurveSize1));
            v25:SetAttribute("Width0", NumberSequence.new(u17.Width0));
            v25:SetAttribute("Width1", NumberSequence.new(u17.Width1));
            v25:SetAttribute("LightEmission", NumberSequence.new(u17.LightEmission));
            v25:SetAttribute("BeamLightInfluence", NumberSequence.new(0));
            v25:SetAttribute("Segments", NumberSequence.new(u17.Segments));
            v25:SetAttribute("TextureLength", NumberSequence.new(u17.TextureLength));
            v25:SetAttribute("TextureSpeed", NumberSequence.new(u17.TextureSpeed));
            v25:SetAttribute("FaceCamera", u17.FaceCamera);
            v25:SetAttribute("ZOffset", u17.ZOffset);
            v25:SetAttribute("BeamTextureMode", u17.TextureMode.Name);
            local Folder = Instance.new("Folder");
            Folder.Name = "GraphBlender";
            local Configuration = Instance.new("Configuration");
            Configuration.Name = "1";
            Configuration:SetAttribute("Time", 0);
            Configuration:SetAttribute("Transparency", u17.Transparency);
            Configuration:SetAttribute("Color", u17.Color);
            Configuration:SetAttribute("_AutoTime", true);
            Configuration.Parent = Folder;
            Folder.Parent = u17;
        end;

        if not u17:FindFirstChild("EmitParent") then
            local ObjectValue = Instance.new("ObjectValue");
            ObjectValue.Name = "EmitParent";
            ObjectValue.Value = nil;
            ObjectValue.Parent = u17;
        end;

        if (u17:IsA("BasePart") or u17:IsA("Attachment")) and not (v19 or (v20 or (v21 or (v22 or (v23 or u17:FindFirstChild("Link")))))) then
            local ObjectValue = Instance.new("ObjectValue");
            ObjectValue.Name = "Link";
            ObjectValue.Parent = u17;
        end;

        if (u17:IsA("BasePart") or v24) and not (v18 or (v19 or (v20 or (v21 or (v22 or (v23 or u17:FindFirstChild("AccelTarget"))))))) then
            local ObjectValue = Instance.new("ObjectValue");
            ObjectValue.Name = "AccelTarget";
            ObjectValue.Value = nil;
            ObjectValue.Parent = u17;
        end;

        if u17:IsA("BasePart") and not (v19 or (v20 or (v21 or (v22 or (v23 or (v24 or u17:FindFirstChild("ShapePart"))))))) then
            local ObjectValue = Instance.new("ObjectValue");
            ObjectValue.Name = "ShapePart";
            ObjectValue.Value = u17;
            ObjectValue.Parent = u17;
        end;

        if (v18 or v21) and not u17:FindFirstChild("Target") then
            local ObjectValue = Instance.new("ObjectValue");
            ObjectValue.Name = "Target";
            ObjectValue.Value = nil;
            ObjectValue.Parent = u17;
        end;

        u17:SetAttribute("Transformed", true);
        u17:SetAttribute("Qwinkle", true);
        u17:SetAttribute("_EvenCycleId", game:GetService("HttpService"):GenerateGUID(false));
        u17:SetAttribute("EmitCount", 1);
        u17:SetAttribute("EmitDuration", 0);
        u17:SetAttribute("EmitDelay", 0);
        u17:SetAttribute("IsEmitter", true);

        if u17:IsA("BasePart") or (u17:IsA("Beam") or (u17:IsA("Trail") or u17:IsA("ImageLabel"))) then
            u17:SetAttribute("PreloadTexture", false);
        end;

        u17:SetAttribute("EmissionMode", u17:IsA("Atmosphere") and "Animate" or "Emit");
        u17:SetAttribute("AnimateLoop", false);

        if not v23 and (u17:IsA("BasePart") and not (v19 or (v20 or (v21 or v22))) or (u17:IsA("Beam") or (u17:IsA("Attachment") or u17:IsA("Model")))) then
            u17:SetAttribute("LinkMode", "Follow");
            u17:SetAttribute("LinkSource", "None");
        end;

        pcall(function() -- Line: 451
            -- upvalues: u1 (ref), u17 (copy)
            u1.TransformCompleted:Fire(u17);
        end);
    end;

    function u1.TransformModel(p32, u33, p34) -- Line: 458
        -- upvalues: DragModel (ref), TypeRegistry (ref), u15 (copy), cloneWithout (copy), u1 (copy)
        if u33:GetAttribute("Transformed") then
            return;
        end;

        DragModel.mark(TypeRegistry.createConfig(u33, p34));
        local Pivot = u33:GetPivot();
        local PrimaryPart = u33.PrimaryPart;
        local v35 = {};

        for _, child in ipairs(u33:GetChildren()) do
            if not u15[child.Name] then
                table.insert(v35, child);
            end;
        end;

        local v36 = cloneWithout(u33, v35);
        v36.Name = "RenderTemplate";

        for _, child in v36:GetChildren() do
            child:Destroy();
        end;

        for _, v in ipairs({ "Transformed", "Qwinkle", "IsEmitter", "EmitCount", "EmitDuration", "EmitDelay", "EmissionMode", "AnimateLoop" }) do
            v36:SetAttribute(v, nil);
        end;

        u33.PrimaryPart = nil;
        v36.Parent = u33;

        for _, v in ipairs(v35) do
            v.Parent = v36;
        end;

        v36.PrimaryPart = PrimaryPart;
        v36.WorldPivot = Pivot;
        u33.WorldPivot = Pivot;

        for _, descendant in v36:GetDescendants() do
            if descendant:IsA("BasePart") then
                descendant.Anchored = true;
                descendant.CanCollide = false;
                descendant.CanQuery = false;
                descendant.CanTouch = false;
                descendant.CastShadow = false;
                descendant.Massless = true;
            elseif (descendant:IsA("ParticleEmitter") or descendant:IsA("Trail")) and not descendant:GetAttribute("Transformed") then
                descendant.Enabled = false;
            end;
        end;

        if not u33:FindFirstChild("EmitParent") then
            local ObjectValue = Instance.new("ObjectValue");
            ObjectValue.Name = "EmitParent";
            ObjectValue.Value = nil;
            ObjectValue.Parent = u33;
        end;

        if not u33:FindFirstChild("Link") then
            local ObjectValue = Instance.new("ObjectValue");
            ObjectValue.Name = "Link";
            ObjectValue.Parent = u33;
        end;

        u33:SetAttribute("Transformed", true);
        u33:SetAttribute("Qwinkle", true);
        u33:SetAttribute("EmitCount", 1);
        u33:SetAttribute("EmitDuration", 0);
        u33:SetAttribute("EmitDelay", 0);
        u33:SetAttribute("IsEmitter", true);
        u33:SetAttribute("PreloadTexture", false);
        u33:SetAttribute("EmissionMode", "Emit");
        u33:SetAttribute("AnimateLoop", false);
        u33:SetAttribute("LinkMode", "Follow");
        u33:SetAttribute("LinkSource", "None");
        pcall(function() -- Line: 531
            -- upvalues: u1 (ref), u33 (copy)
            u1.TransformCompleted:Fire(u33);
        end);
    end;
end;