 
 

local Graph = require(script.Parent.Graph);
local Range = require(script.Parent.Range);
local Particles = require(script.Parent.Particles);
local PartConstants = require(script.Parent.PartConstants);
local AxisLinks = require(script.Parent.AxisLinks);
local Events = require(script.Parent.Events);
local DirectionVectors = PartConstants.DirectionVectors;
local shapeFunctions = PartConstants.shapeFunctions;

return function(u1) -- Line: 17
    -- upvalues: Range (copy), PartConstants (copy), DirectionVectors (copy), shapeFunctions (copy), AxisLinks (copy), Graph (copy), Particles (copy), Events (copy)
    function u1.EmitPartAnimate(p2, p3, p4, p5) -- Line: 20
        -- upvalues: Range (ref), PartConstants (ref), DirectionVectors (ref), shapeFunctions (ref), AxisLinks (ref), Graph (ref), Particles (ref), u1 (copy), Events (ref)
        if not (p3 and p3.Parent) then
            return;
        end;

        local Data = p2:GetData(p3);

        if not (Data and Data.RenderTemplate) then
            return;
        end;

        local v6 = p4 or Data.Link;
        local v7 = Range.RandomValueFromRange(Data.Lifetime);
        local v8 = v7 <= 0 and 0.001 or v7;
        local RenderTemplate = Data.RenderTemplate;
        local CFrame2 = RenderTemplate.CFrame;
        local v9;

        if v6 then
            local v10 = PartConstants.resolveLinkCFrame(v6);
            local Position = v10.Position;

            if Data.LinkMode == "Follow" then
                v9 = CFrame.new(Position) * p3.CFrame.Rotation;
            else
                v9 = CFrame.new(Position) * v10.Rotation * p3.CFrame.Rotation;
            end;
        else
            v9 = p3.CFrame;
        end;

        local v11 = DirectionVectors[Data.EmissionDirection] or DirectionVectors[Enum.NormalId.Top];
        local v12 = v9[v11.vector] * v11.multiplier;
        local Vector3_new_ret = Vector3.new();
        local v13 = nil;
        local v14;

        if Data.UseShape then
            local v15 = shapeFunctions[Data.ParticleData.Shape];

            if v15 then
                local v16;

                if Data.ShapePart then
                    v16 = Data.ShapePart.CFrame or v9;
                else
                    v16 = v9;
                end;

                local v17, v18, v19 = v15(Data.ShapePart or p3, Data.ParticleData);
                local ShapeInOut = Data.ParticleData.ShapeInOut;

                if ShapeInOut == Enum.ParticleEmitterShapeInOut.Inward then
                    v19 = -v19;
                elseif ShapeInOut == Enum.ParticleEmitterShapeInOut.InAndOut and math.random() < 0.5 then
                    v19 = -v19;
                end;

                v13 = (v16 - v16.Position):VectorToWorldSpace(v19);

                if Data.ParticleData.LookAtInitially then
                    local v20, v21, v22 = v9:ToEulerAnglesXYZ();
                    v14 = CFrame.new((v16 * CFrame.new(v17)).Position) * v18 * CFrame.Angles(v20, v21, v22);
                else
                    v14 = CFrame.new((v16 * CFrame.new(v17)).Position) * v9.Rotation;
                end;
            else
                v14 = CFrame.new((v9 * CFrame.new(Vector3_new_ret)).Position) * v9.Rotation;
            end;
        else
            v14 = CFrame.new((v9 * CFrame.new(Vector3_new_ret)).Position) * v9.Rotation;
        end;

        local v23 = Data.DirMode or "RigidLocal";
        local v24 = AxisLinks.sampleRangeAxes(Data, Data.AxisLinks, { "RotX", "RotY", "RotZ" }, Range, p5);
        local v25 = PartConstants.composeRotation(Data.RotOrder or "Global", v24.RotX, v24.RotY, v24.RotZ);
        local v26 = PartConstants.applyPositionOffset(v14 * v25, Data, v6, p3, Range, AxisLinks, p5);

        if v23 == "Global" then
            v26 = CFrame.new(v26.Position) * v25;
        end;

        if v13 then
            v12 = v13;
        elseif v23 == "Local" then
            v12 = v26[v11.vector] * v11.multiplier;
        elseif v23 == "Global" then
            v12 = CFrame.new()[v11.vector] * v11.multiplier;
        end;

        local v27, v28;

        if Data.ParticleData.SpreadAngle.X > 0 or Data.ParticleData.SpreadAngle.Y > 0 then
            v27 = (math.random() * 2 - 1) * Data.ParticleData.SpreadAngle.X;
            v28 = (math.random() * 2 - 1) * Data.ParticleData.SpreadAngle.Y;
        else
            v28 = 0;
            v27 = 0;
        end;

        local CFrame_Angles_ret = CFrame.Angles(math.rad(v27), math.rad(v28), 0);
        local LookVector = (CFrame.lookAt(Vector3.new(), v12) * CFrame_Angles_ret).LookVector;
        local v29 = {
            SizeX = Graph.GenerateSeed(Data.SizeX),
            SizeY = Graph.GenerateSeed(Data.SizeY),
            SizeZ = Graph.GenerateSeed(Data.SizeZ),
            RotSpeedX = Graph.GenerateSeed(Data.RotSpeedX),
            RotSpeedY = Graph.GenerateSeed(Data.RotSpeedY),
            RotSpeedZ = Graph.GenerateSeed(Data.RotSpeedZ),
            PosOffsetX = Graph.GenerateSeed(Data.PosOffsetX),
            PosOffsetY = Graph.GenerateSeed(Data.PosOffsetY),
            PosOffsetZ = Graph.GenerateSeed(Data.PosOffsetZ),
            Speed = Graph.GenerateSeed(Data.Speed),
            Brightness = Graph.GenerateSeed(Data.Brightness),
            Transparency = Graph.GenerateSeed(Data.Transparency),
            AccelStrength = Graph.GenerateSeed(Data.AccelStrength),
            Timescale = Graph.GenerateSeed(Data.Timescale)
        };
        AxisLinks.applyGraphAxisAliases(Data, v29, Data.AxisLinks);
        local InvertMotion = Data.InvertMotion;
        local v30, v31;

        if InvertMotion then
            v30, v31 = p2:PreSimulateForward(Data, v29, v26, LookVector, CFrame_Angles_ret, v6, v8, nil, v26.Rotation * v25:Inverse());
        else
            v30 = nil;
            v31 = nil;
        end;

        local v32;

        if v6 then
            v32 = PartConstants.resolveLinkCFrame(v6);

            if Data.LinkMode == "Follow" or Data.LinkMode == "Pivot" then
                v32 = CFrame.new(v32.Position) or v32;
            end;
        else
            v32 = CFrame.new();
        end;

        if InvertMotion and v30 then
            v26 = v30[v31 or Data.TotalKeyFrames] or v30[0];
        elseif v6 then
            v26 = v32:ToObjectSpace(v26) or v26;
        end;

        RenderTemplate.CFrame = v32 * v26;
        local u33 = {
            Type = "Part",
            VisualPart = RenderTemplate,
            Link = v6,
            LinkMode = Data.LinkMode,
            Events = Data.Events,
            SpecialMesh = RenderTemplate:FindFirstChildOfClass("SpecialMesh"),
            Decal = RenderTemplate:FindFirstChildOfClass("Decal"),
            SurfaceAppearance = RenderTemplate:FindFirstChildOfClass("SurfaceAppearance")
        };
        local v34 = RenderTemplate:FindFirstChildOfClass("SurfaceAppearance");
        u33._initialSAColor = v34 and v34.Color or nil;
        local v35;

        if RenderTemplate:IsA("BasePart") then
            v35 = RenderTemplate.Color or nil;
        else
            v35 = nil;
        end;

        u33._initialPartColor = v35;
        u33.StartTime = os.clock();
        u33.TotalKeyFrames = InvertMotion and v31 and v31 or math.max(1, Data.TotalKeyFrames);
        u33.CurrentStep = 0;
        u33.AccumulatedDT = 0;
        u33.LifeTime = v8;
        u33.PartLife = Data.PartLife or 0;
        u33.CurrentPosition = RenderTemplate.Position;
        u33.LocalCF = v26;
        u33.BaseDirection = LookVector;
        u33._initialBaseDirection = LookVector;
        u33.EmissionDirection = Data.EmissionDirection;
        u33.SpreadRotation = CFrame_Angles_ret;
        u33.Acceleration = Data.ParticleData.Acceleration;
        u33.Drag = Data.ParticleData.Drag;
        u33.VelocityVectored = Data.VelocityVectored;
        u33.InvertMotion = InvertMotion;
        u33.SimLocalCFrames = v30;
        u33.RotMode = Data.RotMode or "OverLife";
        u33.RotOrder = Data.RotOrder or "Global";
        u33.AccRotX = 0;
        u33.AccRotY = 0;
        u33.AccRotZ = 0;
        u33.Orientation = Data.Orientation;
        u33.ZOffset = Data.ZOffset;
        u33._localWorldCF = v26;
        u33.SpawnRotation = v26.Rotation;
        u33.SpawnEmitterRotation = v26.Rotation * v25:Inverse();
        u33.DisplacementMode = Data.DisplacementMode;
        u33._sleepRadius = RenderTemplate and RenderTemplate:IsA("BasePart") and (RenderTemplate.Size.Magnitude * 0.5 or 1) or 1;
        u33._prevWorldOff = Vector3.new(0, 0, 0);
        u33.HasPosOffsetGraphs = (Data.PosOffsetX ~= nil or Data.PosOffsetY ~= nil) and true or Data.PosOffsetZ ~= nil;
        u33.NeedsFullIteration = Data.VelocityVectored;
        local v36;

        if Data.RotMode == "Speed" then
            v36 = not Data.VelocityVectored;
        else
            v36 = false;
        end;

        u33.NeedsRotAccum = v36;
        u33.HasDrag = Data.ParticleData.Drag ~= 0;
        u33.HasAccel = Data.ParticleData.Acceleration.Magnitude > 0;
        u33.HasDecal = RenderTemplate:FindFirstChildOfClass("Decal") ~= nil;
        local v37;

        if Data.AccelerationTowardsInstance == true and (Data.AccelTarget ~= nil and Data.AccelStrength ~= nil) then
            v37 = not Data.InvertMotion;
        else
            v37 = false;
        end;

        u33.HasTargetAccel = v37;
        u33.AccelTarget = Data.AccelTarget;
        u33.TargetVel = Vector3.new(0, 0, 0);
        u33.Graphs = {
            SizeX = Data.SizeX,
            SizeY = Data.SizeY,
            SizeZ = Data.SizeZ,
            RotSpeedX = Data.RotSpeedX,
            RotSpeedY = Data.RotSpeedY,
            RotSpeedZ = Data.RotSpeedZ,
            PosOffsetX = Data.PosOffsetX,
            PosOffsetY = Data.PosOffsetY,
            PosOffsetZ = Data.PosOffsetZ,
            Speed = Data.Speed,
            Brightness = Data.Brightness,
            Transparency = Data.Transparency,
            Color = Data.Color,
            AccelStrength = Data.AccelStrength,
            Timescale = Data.Timescale
        };
        u33.Seeds = v29;
        u33._effectiveElapsed = Graph.InitialEffectiveElapsed(Data.Timescale, v29.Timescale, v8);
        u33.IsAnimate = true;
        u33.AnimateItem = p3;
        u33.InitialAnchorCF = CFrame2;
        u33.InitialLocalCF = v26;

        if u33.HasPosOffsetGraphs then
            local v38 = u33.Graphs.PosOffsetX and (Graph.QueryPointsWithTime(0, u33.Graphs.PosOffsetX, u33.Seeds.PosOffsetX) or 0) or 0;
            local v39 = u33.Graphs.PosOffsetY and (Graph.QueryPointsWithTime(0, u33.Graphs.PosOffsetY, u33.Seeds.PosOffsetY) or 0) or 0;
            local v40 = u33.Graphs.PosOffsetZ and (Graph.QueryPointsWithTime(0, u33.Graphs.PosOffsetZ, u33.Seeds.PosOffsetZ) or 0) or 0;
            local v41 = PartConstants.resolveDisplacement(Vector3.new(v38, v39, v40), Data.DisplacementMode or "Global", u33.SpawnRotation, u33.SpawnEmitterRotation);
            u33._prevWorldOff = v41;

            if v38 ~= 0 or (v39 ~= 0 or v40 ~= 0) then
                u33.LocalCF = u33.LocalCF + v41;
                u33.VisualPart.CFrame = u33.VisualPart.CFrame + v41;
            end;
        end;

        local v42 = Graph.QueryPointsWithTime(0, u33.Graphs.SizeX, u33.Seeds.SizeX);
        local v43 = Graph.QueryPointsWithTime(0, u33.Graphs.SizeY, u33.Seeds.SizeY);
        local Vector3_new_ret2 = Vector3.new(v42, v43, Graph.QueryPointsWithTime(0, u33.Graphs.SizeZ, u33.Seeds.SizeZ));
        local v44 = Graph.QueryPointsWithTime(0, u33.Graphs.Transparency, u33.Seeds.Transparency);
        local u45 = Graph.QueryColorPointWithTime(0, u33.Graphs.Color);
        local u46 = Graph.QueryPointsWithTime(0, u33.Graphs.Brightness, u33.Seeds.Brightness);

        if u33.SpecialMesh then
            u33.SpecialMesh.Scale = Vector3_new_ret2;
        else
            u33.VisualPart.Size = Vector3_new_ret2;
        end;

        if u33.SurfaceAppearance then
            u33.VisualPart.Transparency = v44;
            u33.VisualPart.Color = Color3.fromRGB(u45.R * 255, u45.G * 255, u45.B * 255);
            u33.SurfaceAppearance.Color = Color3.fromRGB(u45.R * 255, u45.G * 255, u45.B * 255);
            pcall(function() -- Line: 248
                -- upvalues: u33 (copy), u45 (copy), u46 (copy)
                u33.SurfaceAppearance.EmissiveTint = Color3.new(u45.R * u46, u45.G * u46, u45.B * u46);
            end);
        elseif u33.Decal then
            u33.Decal.Transparency = v44;
            u33.Decal.Color3 = Color3.fromRGB(u45.R * 255 * u46, u45.G * 255 * u46, u45.B * 255 * u46);
        else
            u33.VisualPart.Transparency = v44;
            u33.VisualPart.Color = Color3.fromRGB(u45.R * 255, u45.G * 255, u45.B * 255);
        end;

        local v47 = p2:_makeAliveCheck();

        for _, child in RenderTemplate:GetChildren() do
            if child:IsA("Attachment") then
                Particles.EnableEmitChildrenAndRepeatForAttachments(child, v47);
            end;

            Particles.EnableEmitSingle(child, v47);
        end;

        if p2._parentScaleMap and p2._parentScaleMap[p3] then
            u33.ParentScale = p2._parentScaleMap[p3];
        end;

        u33._sourceItem = p3;
        u1._seedTsOverride(u33, p3);
        p2.ActiveAnimates[p3] = u33;
        p2:_applyEmitVisualPasses(u33);
        p2:_registerEmit(u33, p5);

        for _, descendant in RenderTemplate:GetDescendants() do
            if descendant:GetAttribute("Transformed") then
                p2:EnableEmit(descendant, descendant.Parent, Events.descendCtx(p5));
            end;
        end;
    end;

    function u1.EmitAttachmentAnimate(p48, p49, p50, p51) -- Line: 283
        -- upvalues: Range (ref), DirectionVectors (ref), AxisLinks (ref), PartConstants (ref), Graph (ref), u1 (copy), Particles (ref), Events (ref)
        if not (p49 and p49.Parent) then
            return;
        end;

        local Data = p48:GetData(p49);

        if not (Data and Data.RenderTemplate) then
            return;
        end;

        local v52 = p50 or Data.Link;
        local v53 = Range.RandomValueFromRange(Data.Lifetime);
        local v54 = v53 <= 0 and 0.001 or v53;
        local RenderTemplate = Data.RenderTemplate;
        local CFrame2 = RenderTemplate.CFrame;
        local CFrame_new_ret = CFrame.new();
        local v55 = DirectionVectors[Data.EmissionDirection] or DirectionVectors[Enum.NormalId.Top];
        local v56 = Data.DirMode or "RigidLocal";
        local v57 = AxisLinks.sampleRangeAxes(Data, Data.AxisLinks, { "RotX", "RotY", "RotZ" }, Range, p51);
        local v58 = PartConstants.composeRotation(Data.RotOrder or "Global", v57.RotX, v57.RotY, v57.RotZ);
        local v59 = CFrame_new_ret * v58;
        local v60;

        if v56 == "Local" then
            v60 = v59[v55.vector] * v55.multiplier;
        elseif v56 == "Global" then
            local v61 = CFrame.new()[v55.vector] * v55.multiplier;
            v60 = p49.WorldCFrame:VectorToObjectSpace(v61);
        else
            v60 = CFrame_new_ret[v55.vector] * v55.multiplier;
        end;

        local v62 = PartConstants.applyPositionOffset(v59, Data, v52, p49, Range, AxisLinks, p51, p49.WorldCFrame);

        if v56 == "Global" then
            v62 = CFrame.new(v62.Position) * p49.WorldCFrame.Rotation:Inverse() * v58;
        end;

        local v63, v64;

        if Data.ParticleData.SpreadAngle.X > 0 or Data.ParticleData.SpreadAngle.Y > 0 then
            v63 = (math.random() * 2 - 1) * Data.ParticleData.SpreadAngle.X;
            v64 = (math.random() * 2 - 1) * Data.ParticleData.SpreadAngle.Y;
        else
            v64 = 0;
            v63 = 0;
        end;

        local CFrame_Angles_ret = CFrame.Angles(math.rad(v63), math.rad(v64), 0);
        local LookVector = (CFrame.lookAt(Vector3.new(), v60) * CFrame_Angles_ret).LookVector;
        local v65 = {
            Speed = Graph.GenerateSeed(Data.Speed),
            RotSpeedX = Graph.GenerateSeed(Data.RotSpeedX),
            RotSpeedY = Graph.GenerateSeed(Data.RotSpeedY),
            RotSpeedZ = Graph.GenerateSeed(Data.RotSpeedZ),
            PosOffsetX = Graph.GenerateSeed(Data.PosOffsetX),
            PosOffsetY = Graph.GenerateSeed(Data.PosOffsetY),
            PosOffsetZ = Graph.GenerateSeed(Data.PosOffsetZ),
            Timescale = Graph.GenerateSeed(Data.Timescale)
        };
        AxisLinks.applyGraphAxisAliases(Data, v65, Data.AxisLinks);
        local InvertMotion = Data.InvertMotion;
        local v66, v67;

        if InvertMotion then
            v66, v67 = p48:PreSimulateAttachmentForward(Data, v65, v62, LookVector, CFrame_Angles_ret, v54, nil, v62.Rotation * v58:Inverse());
        else
            v66 = nil;
            v67 = nil;
        end;

        if InvertMotion and v66 then
            v62 = v66[v67 or Data.TotalKeyFrames] or v66[0];
        end;

        RenderTemplate.CFrame = v62;
        local v68 = {
            Type = "Attachment",
            VisualPart = RenderTemplate,
            Link = v52,
            LinkMode = Data.LinkMode,
            Events = Data.Events,
            StartTime = os.clock(),
            TotalKeyFrames = InvertMotion and v67 and v67 or math.max(1, Data.TotalKeyFrames),
            CurrentStep = 0,
            AccumulatedDT = 0,
            LifeTime = v54,
            PartLife = Data.PartLife or 0,
            LocalCF = v62,
            _localWorldCF = v62,
            BaseDirection = LookVector,
            _initialBaseDirection = LookVector,
            EmissionDirection = Data.EmissionDirection,
            SpreadRotation = CFrame_Angles_ret,
            Acceleration = Data.ParticleData.Acceleration,
            Drag = Data.ParticleData.Drag,
            VelocityVectored = Data.VelocityVectored,
            InvertMotion = InvertMotion,
            SimLocalCFrames = v66,
            RotMode = Data.RotMode or "OverLife",
            RotOrder = Data.RotOrder or "Global",
            AccRotX = 0,
            AccRotY = 0,
            AccRotZ = 0,
            Orientation = Data.Orientation,
            ZOffset = Data.ZOffset,
            NeedsFullIteration = Data.VelocityVectored
        };
        local v69;

        if Data.RotMode == "Speed" then
            v69 = not Data.VelocityVectored;
        else
            v69 = false;
        end;

        v68.NeedsRotAccum = v69;
        v68.HasDrag = Data.ParticleData.Drag ~= 0;
        v68.HasAccel = Data.ParticleData.Acceleration.Magnitude > 0;
        v68.SpawnRotation = v62.Rotation;
        v68.SpawnEmitterRotation = v62.Rotation * v58:Inverse();
        v68.DisplacementMode = Data.DisplacementMode;
        v68._sleepRadius = visualPart and (visualPart:IsA("BasePart") and visualPart.Size.Magnitude * 0.5) or 1;
        v68._prevWorldOff = Vector3.new(0, 0, 0);
        v68.HasPosOffsetGraphs = (Data.PosOffsetX ~= nil or Data.PosOffsetY ~= nil) and true or Data.PosOffsetZ ~= nil;
        v68.Graphs = {
            Speed = Data.Speed,
            RotSpeedX = Data.RotSpeedX,
            RotSpeedY = Data.RotSpeedY,
            RotSpeedZ = Data.RotSpeedZ,
            PosOffsetX = Data.PosOffsetX,
            PosOffsetY = Data.PosOffsetY,
            PosOffsetZ = Data.PosOffsetZ,
            Timescale = Data.Timescale
        };
        v68.Seeds = v65;
        v68._effectiveElapsed = Graph.InitialEffectiveElapsed(Data.Timescale, v65.Timescale, v54);
        v68.IsAnimate = true;
        v68.AnimateItem = p49;
        v68.InitialAnchorCF = CFrame2;
        v68.InitialLocalCF = v62;

        if v68.HasPosOffsetGraphs then
            local v70 = v68.Graphs.PosOffsetX and (Graph.QueryPointsWithTime(0, v68.Graphs.PosOffsetX, v68.Seeds.PosOffsetX) or 0) or 0;
            local v71 = v68.Graphs.PosOffsetY and (Graph.QueryPointsWithTime(0, v68.Graphs.PosOffsetY, v68.Seeds.PosOffsetY) or 0) or 0;
            local v72 = v68.Graphs.PosOffsetZ and (Graph.QueryPointsWithTime(0, v68.Graphs.PosOffsetZ, v68.Seeds.PosOffsetZ) or 0) or 0;
            local v73 = PartConstants.resolveDisplacement(Vector3.new(v70, v71, v72), Data.DisplacementMode or "Global", v68.SpawnRotation, v68.SpawnEmitterRotation);
            v68._prevWorldOff = v73;

            if v70 ~= 0 or (v71 ~= 0 or v72 ~= 0) then
                v68.LocalCF = v68.LocalCF + v73;
                v68.VisualPart.CFrame = v68.VisualPart.CFrame + v73;
            end;
        end;

        v68._sourceItem = p49;
        u1._seedTsOverride(v68, p49);
        p48.ActiveAnimates[p49] = v68;
        p48:_applyEmitVisualPasses(v68);
        p48:_registerEmit(v68, p51);
        local v74 = p48:_makeAliveCheck();

        for _, child in RenderTemplate:GetChildren() do
            if child:IsA("Attachment") then
                Particles.EnableEmitChildrenAndRepeatForAttachments(child, v74);
            end;

            Particles.EnableEmitSingle(child, v74);
        end;

        for _, descendant in RenderTemplate:GetDescendants() do
            if descendant:GetAttribute("Transformed") then
                p48:EnableEmit(descendant, descendant.Parent, Events.descendCtx(p51));
            end;
        end;
    end;

    function u1.EmitBeamAnimate(p75, p76, p77, p78) -- Line: 450
        -- upvalues: Graph (ref), Range (ref), u1 (copy)
        if not (p76 and p76.Parent) then
            return;
        end;

        local Data = p75:GetData(p76);

        if not (Data and Data.RenderTemplate) then
            return;
        end;

        local RenderTemplate = Data.RenderTemplate;
        local v79 = {
            Brightness = RenderTemplate.Brightness,
            CurveSize0 = RenderTemplate.CurveSize0,
            CurveSize1 = RenderTemplate.CurveSize1,
            Width0 = RenderTemplate.Width0,
            Width1 = RenderTemplate.Width1,
            LightEmission = RenderTemplate.LightEmission,
            LightInfluence = RenderTemplate.LightInfluence,
            Segments = RenderTemplate.Segments,
            TextureLength = RenderTemplate.TextureLength,
            TextureSpeed = RenderTemplate.TextureSpeed,
            Transparency = RenderTemplate.Transparency,
            Color = RenderTemplate.Color,
            FaceCamera = RenderTemplate.FaceCamera,
            Enabled = RenderTemplate.Enabled
        };

        if Data.FaceCamera ~= nil then
            RenderTemplate.FaceCamera = Data.FaceCamera;
        end;

        local v80 = {};

        for i, v in pairs(Data.BeamProps) do
            if v then
                if Graph.IsStatic(v) then
                    RenderTemplate[i] = Graph.GetStaticValue(v, RenderTemplate[i]);
                else
                    local v81 = Graph.GenerateSeed(v);
                    v80[i] = {
                        Sequence = v,
                        Seed = v81
                    };

                    if i ~= "TextureSpeed" then
                        local v82 = Graph.QueryPointsWithTime(0, v, v81);

                        if i == "Segments" then
                            local math_round_ret = math.round(v82);
                            v82 = math.max(20, math_round_ret);
                        end;

                        RenderTemplate[i] = v82;
                    end;
                end;
            end;
        end;

        if v80.TextureSpeed then
            RenderTemplate.TextureSpeed = 0;
        end;

        local v83, v84 = Graph.CollectGraphStates(Data.GraphBlender);
        local v85 = {};

        for i = 1, #v83 - 1 do
            v85[i] = Graph.PrecomputeMergedTimes(v83[i].Graph, v83[i + 1].Graph);
            local _ = i;
        end;

        local v86 = {};

        for i = 1, #v84 - 1 do
            v86[i] = Graph.PrecomputeMergedColorTimes(v84[i].Graph, v84[i + 1].Graph);
            local _ = i;
        end;

        if #v83 > 0 then
            RenderTemplate.Transparency = v83[1].Graph;
        end;

        if #v84 > 0 then
            RenderTemplate.Color = v84[1].Graph;
        end;

        RenderTemplate.Enabled = true;
        local v87 = Range.RandomValueFromRange(Data.Lifetime);
        local v88 = v87 <= 0 and 0.001 or v87;
        local v89 = Graph.GenerateSeed(Data.BeamTimescale);
        local v90 = {
            Type = "Beam",
            CurrentStep = 0,
            IsAnimate = true,
            VisualPart = RenderTemplate,
            Link = p77,
            Events = Data.Events,
            StartTime = os.clock(),
            TotalKeyFrames = math.max(1, Data.TotalKeyFrames),
            LifeTime = v88,
            PartLife = Data.PartLife or 0,
            AnimatedProps = v80,
            TransStates = v83,
            ColorStates = v84,
            TransMergedTimes = v85,
            ColorMergedTimes = v86,
            BeamSnapshot = v79,
            Graphs = {
                Timescale = Data.BeamTimescale
            },
            Seeds = {
                Timescale = v89
            },
            _effectiveElapsed = Graph.InitialEffectiveElapsed(Data.BeamTimescale, v89, v88),
            AnimateItem = p76
        };

        if p75._parentScaleMap and p75._parentScaleMap[p76] then
            v90.ParentScale = p75._parentScaleMap[p76];
            v90._baseWidth0 = RenderTemplate.Width0;
            v90._baseWidth1 = RenderTemplate.Width1;
            v90._baseCurveSize0 = RenderTemplate.CurveSize0;
            v90._baseCurveSize1 = RenderTemplate.CurveSize1;
            v90._baseTextureLength = RenderTemplate.TextureLength;
            v90._baseSegments = RenderTemplate.Segments;
        end;

        v90._sourceItem = p76;
        u1._seedTsOverride(v90, p76);
        p75.ActiveAnimates[p76] = v90;
        p75:_registerEmit(v90, p78);
    end;

    function u1._refreshAnimateNonSpatial(p91, p92, p93) -- Line: 557
        -- upvalues: Graph (ref)
        if not p93 then
            return;
        end;

        if p93.EmissionDirection then
            p92.EmissionDirection = p93.EmissionDirection;
        end;

        if p93.Orientation then
            p92.Orientation = p93.Orientation;
        end;

        if p93.ZOffset ~= nil then
            p92.ZOffset = p93.ZOffset;
        end;

        if p93.RotOrder then
            p92.RotOrder = p93.RotOrder;
        end;

        if p93.PartLife ~= nil then
            p92.PartLife = p93.PartLife;
        end;

        local v94 = p93.Timescale or p93.BeamTimescale or (p93.AtmTimescale or p93.PLTimescale);

        if v94 and p92.Graphs then
            p92.Graphs.Timescale = v94;
            p92.Seeds.Timescale = Graph.GenerateSeed(v94);
        end;

        if p93.ParticleData and p93.ParticleData.SpreadAngle then
            local SpreadAngle = p93.ParticleData.SpreadAngle;
            local v95, v96;

            if SpreadAngle.X > 0 or SpreadAngle.Y > 0 then
                v95 = (math.random() * 2 - 1) * SpreadAngle.X;
                v96 = (math.random() * 2 - 1) * SpreadAngle.Y;
            else
                v95 = 0;
                v96 = 0;
            end;

            p92.SpreadRotation = CFrame.Angles(math.rad(v95), math.rad(v96), 0);
        end;
    end;
end;