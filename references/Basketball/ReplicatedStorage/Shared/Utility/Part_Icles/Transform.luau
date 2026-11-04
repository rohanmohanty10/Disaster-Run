 
 

local Graph = require(script.Parent.Graph);
local TypeRegistry = require(script.Parent.TypeRegistry);
local PartConstants = require(script.Parent.PartConstants);
local DirectionVectors = PartConstants.DirectionVectors;

return function(u1) -- Line: 13
    -- upvalues: TypeRegistry (copy), PartConstants (copy), Graph (copy), DirectionVectors (copy)
    if not u1.TransformCompleted then
        u1.TransformCompleted = Instance.new("BindableEvent");
    end;

    function u1.Transform(p2, u3) -- Line: 22
        -- upvalues: TypeRegistry (ref), u1 (copy)
        if u3:GetAttribute("Transformed") then
            return;
        end;

        local TypeFor = TypeRegistry.getTypeFor(u3);

        if not TypeFor then
            return;
        end;

        if TypeFor.directAccess then
            if u3:IsA("Trail") and TypeRegistry.Types.TrailEmitter then
                TypeFor = TypeRegistry.Types.TrailEmitter;
            else
                if not (u3:IsA("Beam") and TypeRegistry.Types.Beam) then
                    return;
                end;

                TypeFor = TypeRegistry.Types.Beam;
            end;
        end;

        if u3:IsA("Model") then
            if u3.PrimaryPart then
                return p2:TransformModel(u3, TypeFor);
            end;

            local Parent = script.Parent.Parent;

            if Parent then
                Parent = Parent:FindFirstChild("UIBuilder");
            end;

            if Parent then
                Parent = Parent:FindFirstChild("Widgets");
            end;

            local v4;

            if Parent then
                local v5;
                v5, v4 = pcall(require, Parent);

                if not v5 then
                    v4 = nil;
                end;
            else
                v4 = nil;
            end;

            if v4 and v4.showToast then
                v4.showToast("Model requires a PrimaryPart to be transformed.", "warn", 4);
            end;

            warn("Part-Icles: Model requires PrimaryPart");

            return;
        end;

        local v6 = TypeRegistry.createConfig(u3, TypeFor);
        local v7 = u3:Clone();
        v7.Name = "RenderTemplate";

        for _, child in v7:GetChildren() do
            if not (child:GetAttribute("Transformed") or child:IsA("Attachment")) then
                if child.Name == TypeRegistry.CONFIG_NAME or (child.Name == "EmitParent" or (child.Name == "Link" or (child.Name == "AccelTarget" or child.Name == "ImageFlipbooks"))) then
                    child:Destroy();
                elseif u3:IsA("PointLight") or u3:IsA("Highlight") then
                    child:Destroy();
                elseif u3:IsA("Attachment") then
                    if child.Name == "MeshFlipbooks" or (child.Name == "BeamFlipbooks" or child.Name == "GraphBlender") then
                        child:Destroy();
                    end;
                elseif u3:IsA("ImageLabel") then
                    if not child:IsA("UIComponent") then
                        child:Destroy();
                    end;
                elseif not (child:IsA("SpecialMesh") or (child:IsA("Decal") or (child:IsA("Texture") or child:IsA("SurfaceAppearance")))) then
                    child:Destroy();
                end;
            end;
        end;

        for _, v in ipairs({ "Transformed", "Qwinkle", "IsEmitter", "EmitCount", "EmitDuration", "EmitDelay", "EmissionMode", "AnimateLoop", "PreloadTexture", "LinkMode", "LinkSource" }) do
            v7:SetAttribute(v, nil);
        end;

        if v7:IsA("BasePart") then
            v7.Anchored = true;
            v7.CanCollide = false;
            v7.CanQuery = false;
            v7.CanTouch = false;
            v7.CastShadow = false;
            v7.Massless = true;
            v7.Locked = true;
            v7.Transparency = 1;

            for _, child in ipairs(v7:GetChildren()) do
                if child:IsA("Decal") or child:IsA("Texture") then
                    child.Transparency = 1;
                end;
            end;
        end;

        if v7:IsA("Attachment") then
            v7.CFrame = CFrame.new();
        end;

        for _, descendant in ipairs(v7:GetDescendants()) do
            if (descendant:IsA("ParticleEmitter") or descendant:IsA("Trail")) and not descendant:GetAttribute("Transformed") then
                descendant.Enabled = false;
            end;
        end;

        v7.Parent = u3;

        if u3:IsA("BasePart") and not u3:IsA("Terrain") then
            local Size = u3.Size;
            local v8 = u3:FindFirstChildWhichIsA("SpecialMesh");

            if v8 then
                Size = v8.Scale;
            end;

            local Color = u3.Color;
            local Transparency = u3.Transparency;

            if u3:FindFirstChildWhichIsA("SurfaceAppearance") == nil then
                local v9 = u3:FindFirstChildWhichIsA("Decal");

                if v9 then
                    Color = v9.Color3;
                    Transparency = v9.Transparency;
                end;
            end;

            v6:SetAttribute("SizeX", NumberSequence.new(Size.X));
            v6:SetAttribute("SizeY", NumberSequence.new(Size.Y));
            v6:SetAttribute("SizeZ", NumberSequence.new(Size.Z));
            v6:SetAttribute("Color", ColorSequence.new(Color));
            v6:SetAttribute("Transparency", NumberSequence.new(Transparency));
        end;

        if u3:IsA("BasePart") then
            for _, child in ipairs(u3:GetChildren()) do
                if child ~= v7 and (child:IsA("SpecialMesh") or (child:IsA("Decal") or child:IsA("Texture"))) then
                    child:Destroy();
                end;
            end;

            u3.Transparency = 1;
        elseif u3:IsA("PointLight") then
            u3.Enabled = false;
        elseif u3:IsA("Highlight") then
            u3.Enabled = false;
        elseif u3:IsA("PostProcessEffect") then
            u3.Enabled = false;
        elseif u3:IsA("ImageLabel") then
            u3.Visible = false;
        end;

        if u3:IsA("PointLight") then
            v6:SetAttribute("Shadows", u3.Shadows);
        end;

        if u3:IsA("BlurEffect") then
            v6:SetAttribute("BlurSize", NumberSequence.new(u3.Size));
        elseif u3:IsA("BloomEffect") then
            v6:SetAttribute("BloomIntensity", NumberSequence.new(u3.Intensity));
            v6:SetAttribute("BloomSize", NumberSequence.new(u3.Size));
            v6:SetAttribute("BloomThreshold", NumberSequence.new(u3.Threshold));
        elseif u3:IsA("ColorCorrectionEffect") then
            v6:SetAttribute("CCBrightness", NumberSequence.new(u3.Brightness));
            v6:SetAttribute("CCContrast", NumberSequence.new(u3.Contrast));
            v6:SetAttribute("CCSaturation", NumberSequence.new(u3.Saturation));
            v6:SetAttribute("CCTintColor", ColorSequence.new(u3.TintColor));
        elseif u3:IsA("Atmosphere") then
            v6:SetAttribute("AtmDensity", NumberSequence.new(u3.Density));
            v6:SetAttribute("AtmOffset", NumberSequence.new(u3.Offset));
            v6:SetAttribute("AtmGlare", NumberSequence.new(u3.Glare));
            v6:SetAttribute("AtmHaze", NumberSequence.new(u3.Haze));
            v6:SetAttribute("AtmColor", ColorSequence.new(u3.Color));
            v6:SetAttribute("AtmDecay", ColorSequence.new(u3.Decay));
        elseif u3:IsA("Highlight") then
            v6:SetAttribute("HLFillColor", ColorSequence.new(u3.FillColor));
            v6:SetAttribute("HLFillTransparency", NumberSequence.new(u3.FillTransparency));
            v6:SetAttribute("HLOutlineColor", ColorSequence.new(u3.OutlineColor));
            v6:SetAttribute("HLOutlineTransparency", NumberSequence.new(u3.OutlineTransparency));
            v6:SetAttribute("HLDepthMode", u3.DepthMode.Name);

            if not u3:FindFirstChild("Adornee") then
                local ObjectValue = Instance.new("ObjectValue");
                ObjectValue.Name = "Adornee";
                ObjectValue.Value = nil;
                ObjectValue.Parent = u3;
            end;
        end;

        if v7:IsA("PostProcessEffect") then
            v7.Enabled = false;
        end;

        if u3:IsA("ImageLabel") then
            if v7:IsA("ImageLabel") then
                v7.Visible = false;
            end;

            if u3.BackgroundTransparency == 0 then
                u3.BackgroundTransparency = 1;
            end;

            v6:SetAttribute("Image", u3.Image);
            v6:SetAttribute("Position", u3.Position);
            v6:SetAttribute("ImgSize", u3.Size);
            v6:SetAttribute("AnchorPoint", u3.AnchorPoint);
            v6:SetAttribute("ZIndex", u3.ZIndex);
            v6:SetAttribute("ScaleType", u3.ScaleType.Name);
            v6:SetAttribute("ResampleMode", u3.ResampleMode.Name);

            if not u3:FindFirstChild("ImageFlipbooks") then
                local Folder = Instance.new("Folder");
                Folder.Name = "ImageFlipbooks";
                Folder.Parent = u3;
            end;
        end;

        if u3:IsA("BasePart") and not (u3:IsA("Terrain") or u3:FindFirstChild("MeshFlipbooks")) then
            local Folder = Instance.new("Folder");
            Folder.Name = "MeshFlipbooks";
            Folder.Parent = u3;
        end;

        if u3:IsA("Trail") then
            u3.Enabled = false;

            if v7:IsA("Trail") then
                v7.Enabled = false;
            end;

            if not u3:FindFirstChild("GraphBlender") then
                local Folder = Instance.new("Folder");
                Folder.Name = "GraphBlender";
                local Configuration = Instance.new("Configuration");
                Configuration.Name = "1";
                Configuration:SetAttribute("Time", 0);
                Configuration:SetAttribute("Width", u3.WidthScale or NumberSequence.new(1));
                Configuration:SetAttribute("Transparency", u3.Transparency or NumberSequence.new(0));
                Configuration:SetAttribute("Color", u3.Color or ColorSequence.new(Color3.new(1, 1, 1)));
                Configuration:SetAttribute("_AutoTime", true);
                Configuration.Parent = Folder;
                Folder.Parent = u3;
            end;

            if not u3:FindFirstChild("TrailFlipbooks") then
                local Folder = Instance.new("Folder");
                Folder.Name = "TrailFlipbooks";
                Folder.Parent = u3;
            end;
        end;

        if u3:IsA("Beam") then
            u3.Enabled = false;
            u3.LightInfluence = 0;

            if v7:IsA("Beam") then
                v7.Enabled = false;
                v7.LightInfluence = 0;
            end;

            if not u3:FindFirstChild("BeamFlipbooks") then
                local Folder = Instance.new("Folder");
                Folder.Name = "BeamFlipbooks";
                Folder.Parent = u3;
            end;

            v6:SetAttribute("BeamBrightness", NumberSequence.new(u3.Brightness));
            v6:SetAttribute("CurveSize0", NumberSequence.new(u3.CurveSize0));
            v6:SetAttribute("CurveSize1", NumberSequence.new(u3.CurveSize1));
            v6:SetAttribute("Width0", NumberSequence.new(u3.Width0));
            v6:SetAttribute("Width1", NumberSequence.new(u3.Width1));
            v6:SetAttribute("LightEmission", NumberSequence.new(u3.LightEmission));
            v6:SetAttribute("BeamLightInfluence", NumberSequence.new(0));
            v6:SetAttribute("Segments", NumberSequence.new(u3.Segments));
            v6:SetAttribute("TextureLength", NumberSequence.new(u3.TextureLength));
            v6:SetAttribute("TextureSpeed", NumberSequence.new(u3.TextureSpeed));
            v6:SetAttribute("FaceCamera", u3.FaceCamera);
            v6:SetAttribute("ZOffset", u3.ZOffset);
            v6:SetAttribute("BeamTextureMode", u3.TextureMode.Name);
            local Folder = Instance.new("Folder");
            Folder.Name = "GraphBlender";
            local Configuration = Instance.new("Configuration");
            Configuration.Name = "1";
            Configuration:SetAttribute("Time", 0);
            Configuration:SetAttribute("Transparency", u3.Transparency);
            Configuration:SetAttribute("Color", u3.Color);
            Configuration:SetAttribute("_AutoTime", true);
            Configuration.Parent = Folder;
            Folder.Parent = u3;
        end;

        if not u3:FindFirstChild("EmitParent") then
            local ObjectValue = Instance.new("ObjectValue");
            ObjectValue.Name = "EmitParent";
            ObjectValue.Value = nil;
            ObjectValue.Parent = u3;
        end;

        if (u3:IsA("BasePart") or u3:IsA("Attachment")) and not u3:FindFirstChild("Link") then
            local ObjectValue = Instance.new("ObjectValue");
            ObjectValue.Name = "Link";
            ObjectValue.Parent = u3;
        end;

        if u3:IsA("BasePart") and not u3:FindFirstChild("AccelTarget") then
            local ObjectValue = Instance.new("ObjectValue");
            ObjectValue.Name = "AccelTarget";
            ObjectValue.Value = nil;
            ObjectValue.Parent = u3;
        end;

        if u3:IsA("BasePart") and not u3:FindFirstChild("ShapePart") then
            local ObjectValue = Instance.new("ObjectValue");
            ObjectValue.Name = "ShapePart";
            ObjectValue.Value = u3;
            ObjectValue.Parent = u3;
        end;

        u3:SetAttribute("Transformed", true);
        u3:SetAttribute("Qwinkle", true);
        u3:SetAttribute("EmitCount", u3:IsA("Beam") and 1 or 0);
        u3:SetAttribute("EmitDuration", 0);
        u3:SetAttribute("EmitDelay", 0);
        u3:SetAttribute("IsEmitter", true);

        if u3:IsA("BasePart") or (u3:IsA("Beam") or (u3:IsA("Trail") or u3:IsA("ImageLabel"))) then
            u3:SetAttribute("PreloadTexture", false);
        end;

        u3:SetAttribute("EmissionMode", u3:IsA("Atmosphere") and "Animate" or "Emit");
        u3:SetAttribute("AnimateLoop", false);

        if u3:IsA("BasePart") or (u3:IsA("Beam") or (u3:IsA("Attachment") or u3:IsA("Model"))) then
            u3:SetAttribute("LinkMode", "Follow");
            u3:SetAttribute("LinkSource", "None");
        end;

        pcall(function() -- Line: 316
            -- upvalues: u1 (ref), u3 (copy)
            u1.TransformCompleted:Fire(u3);
        end);
    end;

    function u1.PreSimulateForward(p10, p11, p12, p13, p14, p15, p16, p17, p18, p19) -- Line: 323
        -- upvalues: PartConstants (ref), Graph (ref), DirectionVectors (ref)
        local v20 = p11.LinkMode or "Follow";
        local v21;

        if p16 then
            v21 = PartConstants.resolveLinkCFrame(p16);

            if v20 == "Follow" or v20 == "Pivot" then
                v21 = CFrame.new(v21.Position);
            end;
        else
            v21 = CFrame.new();
        end;

        local v22;

        if v20 == "Weld" or v20 == "WeldWithoutRotation" then
            v22 = p16 ~= nil;
        else
            v22 = false;
        end;

        local math_max_ret = math.max(1, p11.TotalKeyFrames);

        if not p18 or p18 >= math_max_ret then
            p18 = p11.InvertMotion and math_max_ret > 500 and 500 or math_max_ret;
        end;

        local v23 = p17 / p18;
        local Position = p13.Position;
        local v24 = v21:ToObjectSpace(p13);
        local EmissionDirection = p11.EmissionDirection;
        local v25 = p11.RotMode or "OverLife";
        local v26 = 0;
        local v27 = 0;
        local v28 = 0;
        local v29;

        if p11.AccelerationTowardsInstance == true and (p11.AccelTarget ~= nil and p11.AccelStrength ~= nil) then
            v29 = not p11.InvertMotion;
        else
            v29 = false;
        end;

        local v30 = nil;

        if v29 then
            local AccelTarget = p11.AccelTarget;

            if AccelTarget:IsA("Bone") then
                v30 = AccelTarget.TransformedWorldCFrame.Position;
            elseif AccelTarget:IsA("BasePart") then
                v30 = AccelTarget.Position;
            elseif AccelTarget:IsA("Attachment") then
                v30 = AccelTarget.WorldPosition;
            elseif AccelTarget:IsA("Model") then
                local success, result = pcall(AccelTarget.GetPivot, AccelTarget);

                if success and result then
                    v30 = result.Position;
                end;
            end;

            if not v30 then
                v29 = false;
            end;
        end;

        local v31 = p12.AccelStrength or {};
        local v32 = (p11.PosOffsetX ~= nil or p11.PosOffsetY ~= nil) and true or p11.PosOffsetZ ~= nil;
        local Rotation = p13.Rotation;
        local v33 = { v21:ToObjectSpace(p13) };
        local v34 = Vector3.new(0, 0, 0);
        local v35 = Vector3.new(0, 0, 0);

        for i = 1, p18 do
            local v36 = i / p18;
            local v37 = v36 * p17;
            local v38 = (p14 * (Graph.QueryPointsWithTime(v36, p11.Speed, p12.Speed) * math.exp(-p11.ParticleData.Drag * v37)) + p11.ParticleData.Acceleration * v37) * v23;

            if v29 then
                local v39 = v30 - Position;
                local Magnitude = v39.Magnitude;

                if Magnitude > 0.0001 then
                    local v40 = Graph.QueryPointsWithTime(v36, p11.AccelStrength, v31);

                    if v40 and v40 ~= 0 then
                        v35 = v35 + v39 * (v40 * v23 / Magnitude);
                        v38 = v38 + v35 * v23;
                    end;
                end;
            end;

            local v41;

            if v32 then
                local v42 = p11.PosOffsetX and (Graph.QueryPointsWithTime(v36, p11.PosOffsetX, p12.PosOffsetX) or 0) or 0;
                local v43 = p11.PosOffsetY and (Graph.QueryPointsWithTime(v36, p11.PosOffsetY, p12.PosOffsetY) or 0) or 0;
                local v44 = p11.PosOffsetZ and (Graph.QueryPointsWithTime(v36, p11.PosOffsetZ, p12.PosOffsetZ) or 0) or 0;
                v41 = PartConstants.resolveDisplacement(Vector3.new(v42, v43, v44), p11.DisplacementMode or "Global", Rotation, p19 or Rotation);
                v38 = v38 + (v41 - v34);
            else
                v41 = v34;
            end;

            if v22 then
                v38 = v21:VectorToObjectSpace(v38) or v38;
            end;

            v24 = CFrame.new(v38) * v24;
            local v45 = Graph.QueryPointsWithTime(v36, p11.RotSpeedX, p12.RotSpeedX);
            local v46 = Graph.QueryPointsWithTime(v36, p11.RotSpeedY, p12.RotSpeedY);
            local v47 = Graph.QueryPointsWithTime(v36, p11.RotSpeedZ, p12.RotSpeedZ);
            local v48 = p11.RotOrder or "Global";
            local v49;

            if v25 == "Speed" then
                v26 = v26 + v45 * v23;
                v27 = v27 + v46 * v23;
                v28 = v28 + v47 * v23;
                v49 = PartConstants.composeRotation(v48, v26, v27, v28);
            else
                v49 = PartConstants.composeRotation(v48, v45, v46, v47);
            end;

            local v50 = v21 * v24 * v49;
            Position = v50.Position;

            if p11.VelocityVectored then
                local v51 = DirectionVectors[EmissionDirection] or DirectionVectors[Enum.NormalId.Top];
                p14 = (v50 * p15)[v51.vector] * v51.multiplier;
            end;

            v33[i] = v21:ToObjectSpace(v50);
            v34 = v41;
            local _ = i;
        end;

        return v33, p18;
    end;

    function u1.PreSimulateAttachmentForward(p52, p53, p54, p55, p56, p57, p58, p59, p60) -- Line: 446
        -- upvalues: Graph (ref), PartConstants (ref), DirectionVectors (ref)
        local math_max_ret = math.max(1, p53.TotalKeyFrames);

        if not p59 or p59 >= math_max_ret then
            p59 = p53.InvertMotion and math_max_ret > 500 and 500 or math_max_ret;
        end;

        local v61 = p58 / p59;
        local EmissionDirection = p53.EmissionDirection;
        local v62 = p53.RotMode or "OverLife";
        local v63 = (p53.PosOffsetX ~= nil or p53.PosOffsetY ~= nil) and true or p53.PosOffsetZ ~= nil;
        local Rotation = p55.Rotation;
        local v64 = { p55 };
        local v65 = 0;
        local v66 = 0;
        local v67 = 0;
        local v68 = Vector3.new(0, 0, 0);

        for i = 1, p59 do
            local v69 = i / p59;
            local v70 = v69 * p58;
            local v71 = (p56 * (Graph.QueryPointsWithTime(v69, p53.Speed, p54.Speed) * math.exp(-p53.ParticleData.Drag * v70)) + p53.ParticleData.Acceleration * v70) * v61;
            local v72;

            if v63 then
                local v73 = p53.PosOffsetX and (Graph.QueryPointsWithTime(v69, p53.PosOffsetX, p54.PosOffsetX) or 0) or 0;
                local v74 = p53.PosOffsetY and (Graph.QueryPointsWithTime(v69, p53.PosOffsetY, p54.PosOffsetY) or 0) or 0;
                local v75 = p53.PosOffsetZ and (Graph.QueryPointsWithTime(v69, p53.PosOffsetZ, p54.PosOffsetZ) or 0) or 0;
                v72 = PartConstants.resolveDisplacement(Vector3.new(v73, v74, v75), p53.DisplacementMode or "Global", Rotation, p60 or Rotation);
                v71 = v71 + (v72 - v68);
            else
                v72 = v68;
            end;

            p55 = CFrame.new(v71) * p55;
            local v76 = Graph.QueryPointsWithTime(v69, p53.RotSpeedX, p54.RotSpeedX);
            local v77 = Graph.QueryPointsWithTime(v69, p53.RotSpeedY, p54.RotSpeedY);
            local v78 = Graph.QueryPointsWithTime(v69, p53.RotSpeedZ, p54.RotSpeedZ);
            local v79 = p53.RotOrder or "Global";
            local v80;

            if v62 == "Speed" then
                v65 = v65 + v76 * v61;
                v66 = v66 + v77 * v61;
                v67 = v67 + v78 * v61;
                v80 = PartConstants.composeRotation(v79, v65, v66, v67);
            else
                v80 = PartConstants.composeRotation(v79, v76, v77, v78);
            end;

            local v81 = p55 * v80;

            if p53.VelocityVectored then
                local v82 = DirectionVectors[EmissionDirection] or DirectionVectors[Enum.NormalId.Top];
                p56 = (v81 * p57)[v82.vector] * v82.multiplier;
            end;

            v64[i] = v81;
            v68 = v72;
            local _ = i;
        end;

        return v64, p59;
    end;

    function u1.TransformModel(p83, u84, p85) -- Line: 527
        -- upvalues: TypeRegistry (ref), u1 (copy)
        if u84:GetAttribute("Transformed") then
            return;
        end;

        TypeRegistry.createConfig(u84, p85);
        local v86 = u84:Clone();
        v86.Name = "RenderTemplate";

        for _, child in v86:GetChildren() do
            if child.Name == TypeRegistry.CONFIG_NAME or (child.Name == "EmitParent" or (child.Name == "Link" or child.Name == "AccelTarget")) then
                child:Destroy();
            end;
        end;

        for _, v in ipairs({ "Transformed", "Qwinkle", "IsEmitter", "EmitCount", "EmitDuration", "EmitDelay", "EmissionMode", "AnimateLoop" }) do
            v86:SetAttribute(v, nil);
        end;

        for _, descendant in v86:GetDescendants() do
            if descendant:IsA("BasePart") then
                descendant.Anchored = true;
                descendant.CanCollide = false;
                descendant.CanQuery = false;
                descendant.CanTouch = false;
                descendant.CastShadow = false;
                descendant.Massless = true;
                descendant.Locked = true;
            elseif (descendant:IsA("ParticleEmitter") or descendant:IsA("Trail")) and not descendant:GetAttribute("Transformed") then
                descendant.Enabled = false;
            end;
        end;

        v86.Parent = u84;

        for _, descendant in ipairs(u84:GetDescendants()) do
            if not descendant:IsDescendantOf(v86) then
                if descendant:IsA("BasePart") then
                    descendant.Transparency = 1;
                elseif descendant:IsA("SpecialMesh") or (descendant:IsA("Decal") or descendant:IsA("Texture")) then
                    descendant:Destroy();
                end;
            end;
        end;

        if not u84:FindFirstChild("EmitParent") then
            local ObjectValue = Instance.new("ObjectValue");
            ObjectValue.Name = "EmitParent";
            ObjectValue.Value = nil;
            ObjectValue.Parent = u84;
        end;

        if not u84:FindFirstChild("Link") then
            local ObjectValue = Instance.new("ObjectValue");
            ObjectValue.Name = "Link";
            ObjectValue.Parent = u84;
        end;

        u84:SetAttribute("Transformed", true);
        u84:SetAttribute("Qwinkle", true);
        u84:SetAttribute("EmitCount", 0);
        u84:SetAttribute("EmitDuration", 0);
        u84:SetAttribute("EmitDelay", 0);
        u84:SetAttribute("IsEmitter", true);
        u84:SetAttribute("PreloadTexture", false);
        u84:SetAttribute("EmissionMode", "Emit");
        u84:SetAttribute("AnimateLoop", false);
        u84:SetAttribute("LinkMode", "Follow");
        u84:SetAttribute("LinkSource", "None");
        pcall(function() -- Line: 590
            -- upvalues: u1 (ref), u84 (copy)
            u1.TransformCompleted:Fire(u84);
        end);
    end;
end;