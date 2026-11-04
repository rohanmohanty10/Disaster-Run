 
 

local Graph = require(script.Parent.Graph);
local Range = require(script.Parent.Range);
local AxisLinks = require(script.Parent.AxisLinks);
local Particles = require(script.Parent.Particles);
local Flipbook = require(script.Parent.Flipbook);
local PartConstants = require(script.Parent.PartConstants);
local Pool = require(script.Parent.Pool);
local NestedEmit = require(script.Parent.NestedEmit);
local NestedScale = require(script.Parent.NestedScale);
local StaticPass = require(script.Parent.StaticPass);
local LinkCF = require(script.Parent.LinkCF);
local Turbulence = require(script.Parent.Turbulence);
local DecalLayers = require(script.Parent.DecalLayers);
local MeshFrames = require(script.Parent.MeshFrames);
local Colors = require(script.Parent.Container.Colors);
local Lines = require(script.Parent.Container.Lines);
local DirectionVectors = PartConstants.DirectionVectors;
local shapeFunctions = PartConstants.shapeFunctions;

return function(u1) -- Line: 26
    -- upvalues: Range (copy), LinkCF (copy), DirectionVectors (copy), shapeFunctions (copy), AxisLinks (copy), PartConstants (copy), Graph (copy), Pool (copy), NestedScale (copy), Turbulence (copy), Colors (copy), Particles (copy), StaticPass (copy), DecalLayers (copy), MeshFrames (copy), Flipbook (copy), NestedEmit (copy), Lines (copy)
    function u1.EmitPart(p2, p3, p4, p5) -- Line: 32
        -- upvalues: Range (ref), LinkCF (ref), DirectionVectors (ref), shapeFunctions (ref), AxisLinks (ref), PartConstants (ref), Graph (ref), Pool (ref), NestedScale (ref), Turbulence (ref), Colors (ref), Particles (ref), u1 (copy), StaticPass (ref), DecalLayers (ref), MeshFrames (ref), Flipbook (ref), NestedEmit (ref)
        if not (p3 and p3.Parent) then
            return;
        end;

        local EmitData = p2:GetEmitData(p3, p5);

        if not (EmitData and EmitData.RenderTemplate) then
            return;
        end;

        local v6;

        if p5 and p5.IgnoreLink then
            v6 = nil;
        else
            v6 = p4 or EmitData.Link;
        end;

        local v7 = Range.RandomValueFromRange(EmitData.Lifetime);
        local v8 = v7 <= 0 and 0.001 or v7;
        local v9 = LinkCF.spawnAxes(EmitData, p5);
        local v10 = nil;

        if p5 then
            if p5.EventOriginResolver then
                v10 = p5.EventOriginResolver();
            end;

            v10 = v10 or p5.EventOriginCF;
        end;

        if v10 then
            if not (p5 and p5.UseFullOrigin) then
                v10 = CFrame.new(v10.Position) * p3.CFrame.Rotation;
            end;
        elseif v6 then
            local v11;

            if p5 then
                v11 = p5._linkLocal;
            else
                v11 = p5;
            end;

            local v12;

            if p5 then
                v12 = p5._sourceParentCF;
            else
                v12 = p5;
            end;

            v10 = LinkCF.spawnFrame(EmitData.LinkMode, v6, p3, p3.CFrame, v11, v12, v9);
        else
            v10 = p3.CFrame;
        end;

        local v13 = DirectionVectors[EmitData.EmissionDirection] or DirectionVectors[Enum.NormalId.Top];
        local v14 = v10[v13.vector] * v13.multiplier;
        local Vector3_new_ret = Vector3.new();
        local v15 = nil;
        local v16;

        if EmitData.UseShape then
            local v17 = shapeFunctions[EmitData.ParticleData.Shape];

            if v17 then
                local v18;

                if EmitData.ShapePart then
                    v18 = EmitData.ShapePart.CFrame or v10;
                else
                    v18 = v10;
                end;

                local v19, v20, v21 = v17(EmitData.ShapePart or p3, EmitData.ParticleData);
                local ShapeInOut = EmitData.ParticleData.ShapeInOut;

                if ShapeInOut == Enum.ParticleEmitterShapeInOut.Inward then
                    v21 = -v21;
                elseif ShapeInOut == Enum.ParticleEmitterShapeInOut.InAndOut and math.random() < 0.5 then
                    v21 = -v21;
                end;

                v15 = (v18 - v18.Position):VectorToWorldSpace(v21);

                if EmitData.ParticleData.LookAtInitially then
                    local v22, v23, v24 = v10:ToEulerAnglesXYZ();
                    v16 = CFrame.new((v18 * CFrame.new(v19)).Position) * v20 * CFrame.Angles(v22, v23, v24);
                else
                    v16 = CFrame.new((v18 * CFrame.new(v19)).Position) * v10.Rotation;
                end;
            else
                v16 = CFrame.new((v10 * CFrame.new(Vector3_new_ret)).Position) * v10.Rotation;
            end;
        else
            v16 = CFrame.new((v10 * CFrame.new(Vector3_new_ret)).Position) * v10.Rotation;
        end;

        local v25 = EmitData.DirMode or "RigidLocal";
        local v26 = AxisLinks.sampleRangeAxes(EmitData, EmitData.AxisLinks, { "RotX", "RotY", "RotZ" }, Range, p5);
        local v27 = PartConstants.composeRotation(EmitData.RotOrder or "Global", v26.RotX, v26.RotY, v26.RotZ);
        local v28 = 1;
        local v29;

        if p5 then
            v29 = p5.ParentScale;
        else
            v29 = p5;
        end;

        if v29 and v29.ScaleMotion ~= false then
            v28 = PartConstants.getParentScaleFactor(v29, os.clock(), Graph);
        end;

        local v30 = PartConstants.applyPositionOffset(v16 * v27, EmitData, v6, p3, Range, AxisLinks, p5, nil, v28);

        if v25 == "Global" then
            v30 = CFrame.new(v30.Position) * v27;
        end;

        if v15 then
            v14 = v15;
        elseif v25 == "Local" then
            v14 = v30[v13.vector] * v13.multiplier;
        elseif v25 == "Global" then
            v14 = CFrame.new()[v13.vector] * v13.multiplier;
        end;

        local v31;

        if p5 then
            v31 = p5._containerDrive;
        else
            v31 = p5;
        end;

        local X = EmitData.ParticleData.SpreadAngle.X;
        local Y = EmitData.ParticleData.SpreadAngle.Y;

        if v31 then
            X = X + v31.spreadX;
            Y = Y + v31.spreadY;
        end;

        local v32, v33;

        if X > 0 or Y > 0 then
            v32 = (math.random() * 2 - 1) * X;
            v33 = (math.random() * 2 - 1) * Y;
        else
            v32 = 0;
            v33 = 0;
        end;

        local CFrame_Angles_ret = CFrame.Angles(math.rad(v32), math.rad(v33), 0);
        local LookVector = (CFrame.lookAt(Vector3.new(), v14) * CFrame_Angles_ret).LookVector;
        local v34 = {
            SizeX = Graph.GenerateSeed(EmitData.SizeX),
            SizeY = Graph.GenerateSeed(EmitData.SizeY),
            SizeZ = Graph.GenerateSeed(EmitData.SizeZ),
            RotSpeedX = Graph.GenerateSeed(EmitData.RotSpeedX),
            RotSpeedY = Graph.GenerateSeed(EmitData.RotSpeedY),
            RotSpeedZ = Graph.GenerateSeed(EmitData.RotSpeedZ),
            PosOffsetX = Graph.GenerateSeed(EmitData.PosOffsetX),
            PosOffsetY = Graph.GenerateSeed(EmitData.PosOffsetY),
            PosOffsetZ = Graph.GenerateSeed(EmitData.PosOffsetZ),
            Speed = Graph.GenerateSeed(EmitData.Speed),
            Brightness = Graph.GenerateSeed(EmitData.Brightness),
            Transparency = Graph.GenerateSeed(EmitData.Transparency),
            AccelStrength = Graph.GenerateSeed(EmitData.AccelStrength),
            Timescale = Graph.GenerateSeed(EmitData.Timescale)
        };
        AxisLinks.applyGraphAxisAliases(EmitData, v34, EmitData.AxisLinks);
        local InvertMotion = EmitData.InvertMotion;
        local v35, v36;

        if InvertMotion then
            local v37 = v30.Rotation * v27:Inverse();
            local v38;

            if p5 then
                v38 = p5._linkLocal;
            else
                v38 = p5;
            end;

            local v39;

            if v9 then
                v39 = p3.CFrame or nil;
            else
                v39 = nil;
            end;

            v35, v36 = p2:PreSimulateForward(EmitData, v34, v30, LookVector, CFrame_Angles_ret, v6, v8, nil, v37, v38, v39);
        else
            v35 = nil;
            v36 = nil;
        end;

        local v40 = Pool.acquireOrCopyBare(EmitData.RenderTemplate, "Part", EmitData.Pool);
        v40.Archivable = false;
        local v41;

        if v29 or v31 then
            local v42 = v29 and (PartConstants.getParentScaleFactor(v29, os.clock(), Graph) or 1) or 1;
            local v43;

            if v31 then
                v43 = v31.scale;
            else
                v43 = v31;
            end;

            v41 = NestedScale.start(v40, v29, v42, v43);
        else
            v41 = nil;
        end;

        local v44 = p2:_matteFor(p5, v40);
        local v45;

        if p5 then
            v45 = p5._linkLocal;
        else
            v45 = p5;
        end;

        local v46 = LinkCF.emitParentFrame(EmitData.LinkMode, v6, v45, v9, p3.CFrame);

        if InvertMotion and v35 then
            v30 = v35[v36 or EmitData.TotalKeyFrames] or v35[0];
            v40.CFrame = v46 * v30;
        else
            if v6 then
                v30 = v46:ToObjectSpace(v30) or v30;
            end;

            v40.CFrame = v46 * v30;
        end;

        local u47 = {
            Type = "Part",
            VisualPart = v40,
            Link = v6,
            LinkMode = EmitData.LinkMode,
            LinkAxes = EmitData.LinkAxes
        };
        local v48;

        if p5 then
            v48 = p5._linkLocal or nil;
        else
            v48 = nil;
        end;

        u47._linkLocal = v48;
        u47._rigidLocalParentCF = LinkCF.rigidSnapshot(EmitData.LinkMode, v6, v46);
        u47.Events = EmitData.Events;
        u47.SpecialMesh = v40:FindFirstChildOfClass("SpecialMesh");
        u47.Decal = v40:FindFirstChildOfClass("Decal");
        u47.SurfaceAppearance = v40:FindFirstChildOfClass("SurfaceAppearance");
        u47.StartTime = os.clock();
        u47.TotalKeyFrames = InvertMotion and v36 or math.max(1, EmitData.TotalKeyFrames);
        u47.CurrentStep = 0;
        u47.AccumulatedDT = 0;
        u47.LifeTime = v8;
        u47.PartLife = EmitData.PartLife;
        u47.CurrentPosition = v40.Position;
        u47.LocalCF = v30;
        u47.BaseDirection = LookVector;
        u47._accelVel = Vector3.new(0, 0, 0);
        u47.SpeedMultiplier = 1;
        u47._spinRate = Vector3.new(0, 0, 0);
        u47._spinAccumX = 0;
        u47._spinAccumY = 0;
        u47._spinAccumZ = 0;
        u47.EmissionDirection = EmitData.EmissionDirection;
        u47.SpreadRotation = CFrame_Angles_ret;
        u47.Acceleration = EmitData.ParticleData.Acceleration;
        u47.Drag = EmitData.ParticleData.Drag;
        u47.VelocityVectored = EmitData.VelocityVectored;
        u47.InvertMotion = InvertMotion;
        u47.SimLocalCFrames = v35;
        u47.RotMode = EmitData.RotMode or "OverLife";
        u47.RotOrder = EmitData.RotOrder or "Global";
        u47.AccRotX = 0;
        u47.AccRotY = 0;
        u47.AccRotZ = 0;
        u47.Orientation = EmitData.Orientation;
        u47.ZOffset = EmitData.ZOffset;
        u47._localWorldCF = v30;
        u47.SpawnRotation = v30.Rotation;
        u47.SpawnEmitterRotation = v30.Rotation * v27:Inverse();
        u47.DisplacementMode = EmitData.DisplacementMode;
        u47._sleepRadius = v40 and v40:IsA("BasePart") and (v40.Size.Magnitude * 0.5 or 1) or 1;
        u47._prevWorldOff = Vector3.new(0, 0, 0);
        u47.HasPosOffsetGraphs = (EmitData.PosOffsetX ~= nil or EmitData.PosOffsetY ~= nil) and true or EmitData.PosOffsetZ ~= nil;
        local v49;

        if EmitData.AccelerationTowardsInstance == true and (EmitData.AccelTarget ~= nil and EmitData.AccelStrength ~= nil) then
            v49 = not EmitData.InvertMotion;
        else
            v49 = false;
        end;

        u47.HasTargetAccel = v49;
        u47.AccelTarget = EmitData.AccelTarget;
        u47.TargetVel = Vector3.new(0, 0, 0);
        u47.NeedsFullIteration = EmitData.VelocityVectored;
        local v50;

        if EmitData.RotMode == "Speed" then
            v50 = not EmitData.VelocityVectored;
        else
            v50 = false;
        end;

        u47.NeedsRotAccum = v50;
        u47.HasDrag = EmitData.ParticleData.Drag ~= 0;
        u47.HasAccel = EmitData.ParticleData.Acceleration.Magnitude > 0;
        u47.HasDecal = v40:FindFirstChildOfClass("Decal") ~= nil;
        u47.DecalLayersMode = EmitData.DecalLayersMode;
        u47.Graphs = {
            SizeX = EmitData.SizeX,
            SizeY = EmitData.SizeY,
            SizeZ = EmitData.SizeZ,
            RotSpeedX = EmitData.RotSpeedX,
            RotSpeedY = EmitData.RotSpeedY,
            RotSpeedZ = EmitData.RotSpeedZ,
            PosOffsetX = EmitData.PosOffsetX,
            PosOffsetY = EmitData.PosOffsetY,
            PosOffsetZ = EmitData.PosOffsetZ,
            Speed = EmitData.Speed,
            Brightness = EmitData.Brightness,
            Transparency = EmitData.Transparency,
            Color = EmitData.Color,
            AccelStrength = EmitData.AccelStrength,
            Timescale = EmitData.Timescale
        };
        u47.Seeds = v34;
        u47._effectiveElapsed = Graph.InitialEffectiveElapsed(EmitData.Timescale, v34.Timescale, v8);

        if u47.HasPosOffsetGraphs then
            local v51 = u47.Graphs.PosOffsetX and (Graph.QueryPointsWithTime(0, u47.Graphs.PosOffsetX, u47.Seeds.PosOffsetX) or 0) or 0;
            local v52 = u47.Graphs.PosOffsetY and (Graph.QueryPointsWithTime(0, u47.Graphs.PosOffsetY, u47.Seeds.PosOffsetY) or 0) or 0;
            local v53 = u47.Graphs.PosOffsetZ and (Graph.QueryPointsWithTime(0, u47.Graphs.PosOffsetZ, u47.Seeds.PosOffsetZ) or 0) or 0;
            local v54 = PartConstants.resolveDisplacement(Vector3.new(v51, v52, v53), EmitData.DisplacementMode or "Global", u47.SpawnRotation, u47.SpawnEmitterRotation);
            u47._prevWorldOff = v54;

            if v51 ~= 0 or (v52 ~= 0 or v53 ~= 0) then
                u47.LocalCF = u47.LocalCF + v54;
                u47.VisualPart.CFrame = u47.VisualPart.CFrame + v54;
            end;
        end;

        Turbulence.buildInto(u47, EmitData);
        local v55 = Graph.QueryPointsWithTime(0, u47.Graphs.SizeX, u47.Seeds.SizeX);
        local v56 = Graph.QueryPointsWithTime(0, u47.Graphs.SizeY, u47.Seeds.SizeY);
        local Vector3_new_ret2 = Vector3.new(v55, v56, Graph.QueryPointsWithTime(0, u47.Graphs.SizeZ, u47.Seeds.SizeZ));
        local v57 = Graph.QueryPointsWithTime(0, u47.Graphs.Transparency, u47.Seeds.Transparency);
        local u58 = Graph.QueryColorPointWithTime(0, u47.Graphs.Color);
        local u59 = Graph.QueryPointsWithTime(0, u47.Graphs.Brightness, u47.Seeds.Brightness);

        if v31 then
            u47._drive = v31;
            Vector3_new_ret2 = Vector3_new_ret2 * v31.scale;
            u59 = u59 * v31.brightness;

            if v31.look then
                u58 = Colors.driven(u47, u58, v31);
            end;
        end;

        if u47.SpecialMesh then
            u47.SpecialMesh.Scale = Vector3_new_ret2;
        else
            u47.VisualPart.Size = Vector3_new_ret2;
        end;

        if u47.SurfaceAppearance then
            u47.VisualPart.Transparency = v57;
            u47.VisualPart.Color = Color3.fromRGB(u58.R * 255, u58.G * 255, u58.B * 255);
            u47.SurfaceAppearance.Color = Color3.fromRGB(u58.R * 255, u58.G * 255, u58.B * 255);
            pcall(function() -- Line: 339
                -- upvalues: u47 (copy), u58 (ref), u59 (ref)
                u47.SurfaceAppearance.EmissiveTint = Color3.new(u58.R * u59, u58.G * u59, u58.B * u59);
            end);
        elseif u47.Decal and not EmitData.DecalLayersMode then
            u47.Decal.Transparency = v57;
            u47.Decal.Color3 = Color3.fromRGB(u58.R * 255 * u59, u58.G * 255 * u59, u58.B * 255 * u59);
        else
            local v60 = EmitData.DecalLayersMode and u59 or 1;

            if v31 and not EmitData.DecalLayersMode then
                v60 = v31.brightness;
            end;

            u47.VisualPart.Transparency = v57;
            u47.VisualPart.Color = Color3.fromRGB(u58.R * 255 * v60, u58.G * 255 * v60, u58.B * 255 * v60);
        end;

        for _, descendant in v40:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        if v44 then
            p2:_matteJoin(v44, u47);
        end;

        v40.Parent = EmitData.EmitParent or p2:GetFolder();

        for _, descendant in v40:GetDescendants() do
            if descendant:IsA("Trail") and not descendant:GetAttribute("Transformed") then
                local Parent = descendant.Parent;
                local v61 = descendant;
                local v62 = false;

                while Parent and Parent ~= v40 do
                    if Parent:GetAttribute("Transformed") then
                        v62 = true;
                        break;
                    end;

                    Parent = Parent.Parent;
                end;

                if not v62 and v61:GetAttribute("EmitDuration") ~= nil then
                    if v61.Enabled ~= true then
                        v61.Enabled = true;
                    end;

                    if v61:GetAttribute("_pooledTrailEnabled") ~= nil then
                        v61:SetAttribute("_pooledTrailEnabled", true);
                    end;
                end;
            end;
        end;

        Pool.restoreTrails(v40, "Part");
        p2:_adoptIntoContainer(u47, p5);
        local v63 = p2:_makeAliveCheck();

        for _, child in v40:GetChildren() do
            if child:IsA("Attachment") then
                Particles.EnableEmitChildrenAndRepeatForAttachments(child, v63);
            end;

            Particles.EnableEmitSingle(child, v63);
        end;

        if p5 and p5.ParentScale then
            u47.ParentScale = p5.ParentScale;
        end;

        u47._scaledContent = v41;
        u47._sourceItem = p3;
        u1._seedTsOverride(u47, p3);

        if EmitData.Pool ~= false then
            u47._sourceRT = EmitData.RenderTemplate;
            u47._poolKind = "Part";
        end;

        StaticPass.apply(u47);
        p2:_applyEmitVisualPasses(u47);
        u47._nestedAlive = { true };

        if EmitData.Reactor then
            p2:_watchForForces(u47, EmitData.Reactor, v44 ~= nil);
        end;

        p2:_registerEmit(u47, p5);
        DecalLayers.attach(u47, EmitData, v40, v8, false);
        MeshFrames.attach(u47, EmitData, v40, v8, false);

        if EmitData.CachedMeshTextures and (#EmitData.CachedMeshTextures > 0 and not v44) then
            local SurfaceAppearance = u47.SurfaceAppearance;

            if not (SurfaceAppearance or (EmitData.DecalLayersMode or EmitData.MeshFramesTextured)) then
                SurfaceAppearance = u47.Decal;
            end;

            if not (SurfaceAppearance or (not v40:IsA("MeshPart") or u47.Layers)) then
                if not EmitData.MeshFramesTextured then
                    SurfaceAppearance = v40;
                end;
            end;

            if SurfaceAppearance then
                Flipbook.Flip(u47, EmitData.ParticleData, EmitData.CachedMeshTextures, SurfaceAppearance, v8);
            end;
        end;

        NestedEmit.walk(p2, EmitData.RenderTemplate, v40, u47._nestedAlive, p5, u47.ParentScale);
    end;

    function u1.EmitBeam(p64, p65, p66, p67) -- Line: 441
        -- upvalues: Pool (ref), Graph (ref), Range (ref), u1 (copy), Lines (ref), Flipbook (ref)
        if not (p65 and p65.Parent) then
            return;
        end;

        local EmitData = p64:GetEmitData(p65, p67);

        if not (EmitData and EmitData.RenderTemplate) then
            return;
        end;

        local v68 = Pool.acquireOrClone(EmitData.RenderTemplate, "Beam", EmitData.Pool);
        v68.Archivable = false;
        v68.Enabled = true;

        if EmitData.FaceCamera ~= nil then
            v68.FaceCamera = EmitData.FaceCamera;
        end;

        if EmitData.ZOffset ~= nil then
            v68.ZOffset = EmitData.ZOffset;
        end;

        if EmitData.TextureMode ~= nil then
            v68.TextureMode = EmitData.TextureMode;
        end;

        local v69;

        if p67 then
            v69 = p67._parentCloneMap;
        else
            v69 = p67;
        end;

        local Attachment0 = EmitData.RenderTemplate.Attachment0;
        local Attachment1 = EmitData.RenderTemplate.Attachment1;
        local v70;

        if v69 then
            if Attachment0 then
                v70 = v69[Attachment0];
            else
                v70 = Attachment0;
            end;
        else
            v70 = v69;
        end;

        if v69 then
            if Attachment1 then
                v69 = v69[Attachment1];
            else
                v69 = Attachment1;
            end;
        end;

        if v70 and v70.Parent then
            Attachment0 = v70 or Attachment0;
        end;

        v68.Attachment0 = Attachment0;

        if v69 and v69.Parent then
            Attachment1 = v69 or Attachment1;
        end;

        v68.Attachment1 = Attachment1;
        local v71 = {};

        for i, v in pairs(EmitData.BeamProps) do
            if v then
                if Graph.IsStatic(v) then
                    v68[i] = Graph.GetStaticValue(v, v68[i]);
                else
                    local v72 = Graph.GenerateSeed(v);
                    v71[i] = {
                        Sequence = v,
                        Seed = v72
                    };

                    if i ~= "TextureSpeed" then
                        local v73 = Graph.QueryPointsWithTime(0, v, v72);

                        if i == "Segments" then
                            local math_round_ret = math.round(v73);
                            v73 = math.max(20, math_round_ret);
                        end;

                        v68[i] = v73;
                    end;
                end;
            end;
        end;

        if v71.TextureSpeed then
            v68.TextureSpeed = 0;
        end;

        local v74, v75 = Graph.CollectGraphStates(EmitData.GraphBlender);
        local v76 = {};

        for i = 1, #v74 - 1 do
            v76[i] = Graph.PrecomputeMergedTimes(v74[i].Graph, v74[i + 1].Graph);
            local _ = i;
        end;

        local v77 = {};

        for i = 1, #v75 - 1 do
            v77[i] = Graph.PrecomputeMergedColorTimes(v75[i].Graph, v75[i + 1].Graph);
            local _ = i;
        end;

        if #v74 > 0 then
            v68.Transparency = v74[1].Graph;
        end;

        if #v75 > 0 then
            v68.Color = v75[1].Graph;
        end;

        v68.Parent = EmitData.EmitParent or p64:GetFolder();
        local v78 = Range.RandomValueFromRange(EmitData.Lifetime);
        local v79 = v78 <= 0 and 0.001 or v78;
        local v80 = Graph.GenerateSeed(EmitData.BeamTimescale);
        local v81 = {
            Type = "Beam",
            CurrentStep = 0,
            VisualPart = v68,
            Link = p66,
            Events = EmitData.Events,
            StartTime = os.clock(),
            TotalKeyFrames = math.max(1, EmitData.TotalKeyFrames),
            LifeTime = v79,
            PartLife = EmitData.PartLife or 0,
            AnimatedProps = v71,
            TransStates = v74,
            ColorStates = v75,
            TransMergedTimes = v76,
            ColorMergedTimes = v77,
            Graphs = {
                Timescale = EmitData.BeamTimescale
            },
            Seeds = {
                Timescale = v80
            },
            _effectiveElapsed = Graph.InitialEffectiveElapsed(EmitData.BeamTimescale, v80, v79)
        };

        if p67 and p67.ParentScale then
            v81.ParentScale = p67.ParentScale;
            v81._baseWidth0 = v68.Width0;
            v81._baseWidth1 = v68.Width1;
            v81._baseCurveSize0 = v68.CurveSize0;
            v81._baseCurveSize1 = v68.CurveSize1;
            v81._baseTextureLength = v68.TextureLength;
            v81._baseSegments = v68.Segments;
        end;

        v81._sourceItem = p65;
        u1._seedTsOverride(v81, p65);

        if EmitData.Pool ~= false then
            v81._sourceRT = EmitData.RenderTemplate;
            v81._poolKind = "Beam";
        end;

        if p67 and p67._containerDrive then
            Lines.carry(v81, "Beam", p67._containerDrive);
        end;

        p64:_registerEmit(v81, p67);

        if EmitData.CachedBeamTextures and (#EmitData.CachedBeamTextures > 0 and EmitData.FlipbookParticle) then
            Flipbook.FlipBeam(v81, EmitData.FlipbookParticle, EmitData.CachedBeamTextures, v68, v79);
        end;
    end;
end;