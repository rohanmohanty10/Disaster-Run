 

 

local Graph = require(script.Parent.Graph);
local DecalLayers = require(script.Parent.DecalLayers);
local MeshFrames = require(script.Parent.MeshFrames);
local Range = require(script.Parent.Range);
local Particles = require(script.Parent.Particles);
local PartConstants = require(script.Parent.PartConstants);
local NestedEmit = require(script.Parent.NestedEmit);
local LinkCF = require(script.Parent.LinkCF);
local AxisLinks = require(script.Parent.AxisLinks);
local StaticPass = require(script.Parent.StaticPass);
local Turbulence = require(script.Parent.Turbulence);
local AtRest = require(script.Parent.AtRest);
local DirectionVectors = PartConstants.DirectionVectors;
local shapeFunctions = PartConstants.shapeFunctions;

return function(u1) -- Line: 23
    -- upvalues: Range (copy), LinkCF (copy), DirectionVectors (copy), shapeFunctions (copy), AxisLinks (copy), PartConstants (copy), Graph (copy), Turbulence (copy), DecalLayers (copy), MeshFrames (copy), Particles (copy), StaticPass (copy), AtRest (copy), NestedEmit (copy)
    function u1.EmitPartAnimate(p2, p3, p4, p5) -- Line: 26
        -- upvalues: Range (ref), LinkCF (ref), DirectionVectors (ref), shapeFunctions (ref), AxisLinks (ref), PartConstants (ref), Graph (ref), Turbulence (ref), DecalLayers (ref), MeshFrames (ref), Particles (ref), u1 (copy), StaticPass (ref), AtRest (ref), NestedEmit (ref)
        if not (p3 and p3.Parent) then
            return;
        end;

        local EmitData = p2:GetEmitData(p3, p5);

        if not (EmitData and EmitData.RenderTemplate) then
            return;
        end;

        local v6 = p4 or EmitData.Link;
        local v7 = Range.RandomValueFromRange(EmitData.Lifetime);
        local v8 = v7 <= 0 and 0.001 or v7;
        local RenderTemplate = EmitData.RenderTemplate;
        local CFrame2 = RenderTemplate.CFrame;
        local v9 = LinkCF.spawnAxes(EmitData, p5);
        local v10;

        if v6 then
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
        local v28 = PartConstants.applyPositionOffset(v16 * v27, EmitData, v6, p3, Range, AxisLinks, p5);

        if v25 == "Global" then
            v28 = CFrame.new(v28.Position) * v27;
        end;

        if v15 then
            v14 = v15;
        elseif v25 == "Local" then
            v14 = v28[v13.vector] * v13.multiplier;
        elseif v25 == "Global" then
            v14 = CFrame.new()[v13.vector] * v13.multiplier;
        end;

        local v29, v30;

        if EmitData.ParticleData.SpreadAngle.X > 0 or EmitData.ParticleData.SpreadAngle.Y > 0 then
            v29 = (math.random() * 2 - 1) * EmitData.ParticleData.SpreadAngle.X;
            v30 = (math.random() * 2 - 1) * EmitData.ParticleData.SpreadAngle.Y;
        else
            v29 = 0;
            v30 = 0;
        end;

        local CFrame_Angles_ret = CFrame.Angles(math.rad(v29), math.rad(v30), 0);
        local LookVector = (CFrame.lookAt(Vector3.new(), v14) * CFrame_Angles_ret).LookVector;
        local v31 = {
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
        AxisLinks.applyGraphAxisAliases(EmitData, v31, EmitData.AxisLinks);
        local InvertMotion = EmitData.InvertMotion;
        local v32, v33;

        if InvertMotion then
            local v34 = v28.Rotation * v27:Inverse();
            local v35;

            if p5 then
                v35 = p5._linkLocal;
            else
                v35 = p5;
            end;

            local v36;

            if v9 then
                v36 = p3.CFrame or nil;
            else
                v36 = nil;
            end;

            v32, v33 = p2:PreSimulateForward(EmitData, v31, v28, LookVector, CFrame_Angles_ret, v6, v8, nil, v34, v35, v36);
        else
            v32 = nil;
            v33 = nil;
        end;

        local v37;

        if p5 then
            v37 = p5._linkLocal;
        else
            v37 = p5;
        end;

        local v38 = LinkCF.emitParentFrame(EmitData.LinkMode, v6, v37, v9, p3.CFrame);

        if InvertMotion and v32 then
            v28 = v32[v33 or EmitData.TotalKeyFrames] or v32[0];
        elseif v6 then
            v28 = v38:ToObjectSpace(v28) or v28;
        end;

        RenderTemplate.CFrame = v38 * v28;
        local u39 = {
            Type = "Part",
            VisualPart = RenderTemplate,
            Link = v6,
            LinkMode = EmitData.LinkMode,
            LinkAxes = EmitData.LinkAxes
        };
        local v40;

        if p5 then
            v40 = p5._linkLocal or nil;
        else
            v40 = nil;
        end;

        u39._linkLocal = v40;
        u39._rigidLocalParentCF = LinkCF.rigidSnapshot(EmitData.LinkMode, v6, v38);
        u39.Events = EmitData.Events;
        u39.SpecialMesh = RenderTemplate:FindFirstChildOfClass("SpecialMesh");
        u39.Decal = RenderTemplate:FindFirstChildOfClass("Decal");
        u39.SurfaceAppearance = RenderTemplate:FindFirstChildOfClass("SurfaceAppearance");
        local v41 = RenderTemplate:FindFirstChildOfClass("SurfaceAppearance");
        u39._initialSAColor = v41 and v41.Color or nil;
        local v42;

        if RenderTemplate:IsA("BasePart") then
            v42 = RenderTemplate.Color or nil;
        else
            v42 = nil;
        end;

        u39._initialPartColor = v42;
        u39.StartTime = os.clock();
        u39.TotalKeyFrames = InvertMotion and v33 and v33 or math.max(1, EmitData.TotalKeyFrames);
        u39.CurrentStep = 0;
        u39.AccumulatedDT = 0;
        u39.LifeTime = v8;
        u39.PartLife = EmitData.PartLife or 0;
        u39.CurrentPosition = RenderTemplate.Position;
        u39.LocalCF = v28;
        u39.BaseDirection = LookVector;
        u39._initialBaseDirection = LookVector;
        u39.EmissionDirection = EmitData.EmissionDirection;
        u39.SpreadRotation = CFrame_Angles_ret;
        u39.Acceleration = EmitData.ParticleData.Acceleration;
        u39.Drag = EmitData.ParticleData.Drag;
        u39.VelocityVectored = EmitData.VelocityVectored;
        u39.InvertMotion = InvertMotion;
        u39.SimLocalCFrames = v32;
        u39.RotMode = EmitData.RotMode or "OverLife";
        u39.RotOrder = EmitData.RotOrder or "Global";
        u39.AccRotX = 0;
        u39.AccRotY = 0;
        u39.AccRotZ = 0;
        u39.Orientation = EmitData.Orientation;
        u39.ZOffset = EmitData.ZOffset;
        u39._localWorldCF = v28;
        u39.SpawnRotation = v28.Rotation;
        u39.SpawnEmitterRotation = v28.Rotation * v27:Inverse();
        u39.DisplacementMode = EmitData.DisplacementMode;
        u39._sleepRadius = RenderTemplate and RenderTemplate:IsA("BasePart") and (RenderTemplate.Size.Magnitude * 0.5 or 1) or 1;
        u39._prevWorldOff = Vector3.new(0, 0, 0);
        u39.HasPosOffsetGraphs = (EmitData.PosOffsetX ~= nil or EmitData.PosOffsetY ~= nil) and true or EmitData.PosOffsetZ ~= nil;
        u39.NeedsFullIteration = EmitData.VelocityVectored;
        local v43;

        if EmitData.RotMode == "Speed" then
            v43 = not EmitData.VelocityVectored;
        else
            v43 = false;
        end;

        u39.NeedsRotAccum = v43;
        u39.HasDrag = EmitData.ParticleData.Drag ~= 0;
        u39.HasAccel = EmitData.ParticleData.Acceleration.Magnitude > 0;
        u39.HasDecal = RenderTemplate:FindFirstChildOfClass("Decal") ~= nil;
        u39.DecalLayersMode = EmitData.DecalLayersMode;
        local v44;

        if EmitData.AccelerationTowardsInstance == true and (EmitData.AccelTarget ~= nil and EmitData.AccelStrength ~= nil) then
            v44 = not EmitData.InvertMotion;
        else
            v44 = false;
        end;

        u39.HasTargetAccel = v44;
        u39.AccelTarget = EmitData.AccelTarget;
        u39.TargetVel = Vector3.new(0, 0, 0);
        u39.Graphs = {
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
        u39.Seeds = v31;
        u39._effectiveElapsed = Graph.InitialEffectiveElapsed(EmitData.Timescale, v31.Timescale, v8);
        u39.IsAnimate = true;
        u39.AnimateItem = p3;
        u39.InitialAnchorCF = CFrame2;
        u39.InitialLocalCF = v28;

        if u39.HasPosOffsetGraphs then
            local v45 = u39.Graphs.PosOffsetX and (Graph.QueryPointsWithTime(0, u39.Graphs.PosOffsetX, u39.Seeds.PosOffsetX) or 0) or 0;
            local v46 = u39.Graphs.PosOffsetY and (Graph.QueryPointsWithTime(0, u39.Graphs.PosOffsetY, u39.Seeds.PosOffsetY) or 0) or 0;
            local v47 = u39.Graphs.PosOffsetZ and (Graph.QueryPointsWithTime(0, u39.Graphs.PosOffsetZ, u39.Seeds.PosOffsetZ) or 0) or 0;
            local v48 = PartConstants.resolveDisplacement(Vector3.new(v45, v46, v47), EmitData.DisplacementMode or "Global", u39.SpawnRotation, u39.SpawnEmitterRotation);
            u39._prevWorldOff = v48;

            if v45 ~= 0 or (v46 ~= 0 or v47 ~= 0) then
                u39.LocalCF = u39.LocalCF + v48;
                u39.VisualPart.CFrame = u39.VisualPart.CFrame + v48;
            end;
        end;

        Turbulence.buildInto(u39, EmitData);
        local v49 = Graph.QueryPointsWithTime(0, u39.Graphs.SizeX, u39.Seeds.SizeX);
        local v50 = Graph.QueryPointsWithTime(0, u39.Graphs.SizeY, u39.Seeds.SizeY);
        local Vector3_new_ret2 = Vector3.new(v49, v50, Graph.QueryPointsWithTime(0, u39.Graphs.SizeZ, u39.Seeds.SizeZ));
        local v51 = Graph.QueryPointsWithTime(0, u39.Graphs.Transparency, u39.Seeds.Transparency);
        local u52 = Graph.QueryColorPointWithTime(0, u39.Graphs.Color);
        local u53 = Graph.QueryPointsWithTime(0, u39.Graphs.Brightness, u39.Seeds.Brightness);

        if u39.SpecialMesh then
            u39.SpecialMesh.Scale = Vector3_new_ret2;
        else
            u39.VisualPart.Size = Vector3_new_ret2;
        end;

        if u39.SurfaceAppearance then
            u39.VisualPart.Transparency = v51;
            u39.VisualPart.Color = Color3.fromRGB(u52.R * 255, u52.G * 255, u52.B * 255);
            u39.SurfaceAppearance.Color = Color3.fromRGB(u52.R * 255, u52.G * 255, u52.B * 255);
            pcall(function() -- Line: 253
                -- upvalues: u39 (copy), u52 (copy), u53 (copy)
                u39.SurfaceAppearance.EmissiveTint = Color3.new(u52.R * u53, u52.G * u53, u52.B * u53);
            end);
        elseif u39.Decal and not EmitData.DecalLayersMode then
            u39.Decal.Transparency = v51;
            u39.Decal.Color3 = Color3.fromRGB(u52.R * 255 * u53, u52.G * 255 * u53, u52.B * 255 * u53);
        else
            local v54 = EmitData.DecalLayersMode and u53 and u53 or 1;
            u39.VisualPart.Transparency = v51;
            u39.VisualPart.Color = Color3.fromRGB(u52.R * 255 * v54, u52.G * 255 * v54, u52.B * 255 * v54);
        end;

        DecalLayers.attach(u39, EmitData, RenderTemplate, v8, true);
        MeshFrames.attach(u39, EmitData, RenderTemplate, v8, true);
        local v55 = p2:_makeAliveCheck();

        for _, child in RenderTemplate:GetChildren() do
            if child:IsA("Attachment") then
                Particles.EnableEmitChildrenAndRepeatForAttachments(child, v55);
            end;

            Particles.EnableEmitSingle(child, v55);
        end;

        if p5 and p5.ParentScale then
            u39.ParentScale = p5.ParentScale;
        end;

        u39._sourceItem = p3;
        u1._seedTsOverride(u39, p3);
        StaticPass.apply(u39);
        p2.ActiveAnimates[p3] = u39;
        p2:_applyEmitVisualPasses(u39);
        u39._nestedAlive = { true };
        p2:_registerEmit(u39, p5);

        if p2.ActiveAnimates[p3] == u39 then
            AtRest.wake(RenderTemplate);
        end;

        NestedEmit.walk(p2, RenderTemplate, RenderTemplate, u39._nestedAlive, p5, u39.ParentScale);
    end;

    function u1.EmitAttachmentAnimate(p56, p57, p58, p59) -- Line: 292
        -- upvalues: Range (ref), LinkCF (ref), DirectionVectors (ref), AxisLinks (ref), PartConstants (ref), Graph (ref), Turbulence (ref), u1 (copy), StaticPass (ref), AtRest (ref), Particles (ref), NestedEmit (ref)
        if not (p57 and p57.Parent) then
            return;
        end;

        local EmitData = p56:GetEmitData(p57, p59);

        if not (EmitData and EmitData.RenderTemplate) then
            return;
        end;

        local v60 = p58 or EmitData.Link;
        local v61 = Range.RandomValueFromRange(EmitData.Lifetime);
        local v62 = v61 <= 0 and 0.001 or v61;
        local RenderTemplate = EmitData.RenderTemplate;
        local CFrame2 = RenderTemplate.CFrame;
        local WorldCFrame = p57.WorldCFrame;
        local v63 = LinkCF.spawnAxes(EmitData, p59);
        local CFrame_new_ret = CFrame.new();

        if v60 then
            local v64;

            if p59 then
                v64 = p59._linkLocal;
            else
                v64 = p59;
            end;

            local v65;

            if p59 then
                v65 = p59._sourceParentCF;
            else
                v65 = p59;
            end;

            CFrame_new_ret = WorldCFrame:ToObjectSpace((LinkCF.spawnFrame(EmitData.LinkMode, v60, p57, WorldCFrame, v64, v65, v63)));
        end;

        local v66 = DirectionVectors[EmitData.EmissionDirection] or DirectionVectors[Enum.NormalId.Top];
        local v67 = EmitData.DirMode or "RigidLocal";
        local v68 = AxisLinks.sampleRangeAxes(EmitData, EmitData.AxisLinks, { "RotX", "RotY", "RotZ" }, Range, p59);
        local v69 = PartConstants.composeRotation(EmitData.RotOrder or "Global", v68.RotX, v68.RotY, v68.RotZ);
        local v70 = CFrame_new_ret * v69;
        local v71;

        if v67 == "Local" then
            v71 = v70[v66.vector] * v66.multiplier;
        elseif v67 == "Global" then
            local v72 = CFrame.new()[v66.vector] * v66.multiplier;
            v71 = p57.WorldCFrame:VectorToObjectSpace(v72);
        else
            v71 = CFrame_new_ret[v66.vector] * v66.multiplier;
        end;

        local v73 = PartConstants.applyPositionOffset(v70, EmitData, v60, p57, Range, AxisLinks, p59, p57.WorldCFrame);

        if v67 == "Global" then
            v73 = CFrame.new(v73.Position) * p57.WorldCFrame.Rotation:Inverse() * v69;
        end;

        local v74, v75;

        if EmitData.ParticleData.SpreadAngle.X > 0 or EmitData.ParticleData.SpreadAngle.Y > 0 then
            v74 = (math.random() * 2 - 1) * EmitData.ParticleData.SpreadAngle.X;
            v75 = (math.random() * 2 - 1) * EmitData.ParticleData.SpreadAngle.Y;
        else
            v75 = 0;
            v74 = 0;
        end;

        local CFrame_Angles_ret = CFrame.Angles(math.rad(v74), math.rad(v75), 0);
        local LookVector = (CFrame.lookAt(Vector3.new(), v71) * CFrame_Angles_ret).LookVector;
        local v76 = {
            Speed = Graph.GenerateSeed(EmitData.Speed),
            RotSpeedX = Graph.GenerateSeed(EmitData.RotSpeedX),
            RotSpeedY = Graph.GenerateSeed(EmitData.RotSpeedY),
            RotSpeedZ = Graph.GenerateSeed(EmitData.RotSpeedZ),
            PosOffsetX = Graph.GenerateSeed(EmitData.PosOffsetX),
            PosOffsetY = Graph.GenerateSeed(EmitData.PosOffsetY),
            PosOffsetZ = Graph.GenerateSeed(EmitData.PosOffsetZ),
            Timescale = Graph.GenerateSeed(EmitData.Timescale)
        };
        AxisLinks.applyGraphAxisAliases(EmitData, v76, EmitData.AxisLinks);
        local InvertMotion = EmitData.InvertMotion;
        local v77, v78;

        if InvertMotion then
            v77, v78 = p56:PreSimulateAttachmentForward(EmitData, v76, v73, LookVector, CFrame_Angles_ret, v62, nil, v73.Rotation * v69:Inverse());
        else
            v77 = nil;
            v78 = nil;
        end;

        if InvertMotion and v77 then
            v73 = v77[v78 or EmitData.TotalKeyFrames] or v77[0];
        end;

        RenderTemplate.CFrame = v73;
        local v79;

        if v60 then
            local v80;

            if p59 then
                v80 = p59._linkLocal;
            else
                v80 = p59;
            end;

            v79 = LinkCF.emitAttachmentParentFrame(EmitData.LinkMode, v60, p57, v80, v63, WorldCFrame):ToObjectSpace(v73);
        else
            v79 = v73;
        end;

        local v81 = {
            Type = "Attachment",
            VisualPart = RenderTemplate,
            Link = v60,
            LinkMode = EmitData.LinkMode,
            LinkAxes = EmitData.LinkAxes
        };
        local v82;

        if p59 then
            v82 = p59._linkLocal or nil;
        else
            v82 = nil;
        end;

        v81._linkLocal = v82;
        local v83;

        if p59 then
            v83 = p59._linkLocal;
        else
            v83 = p59;
        end;

        v81._rigidLocalParentCF = LinkCF.rigidWorldSnapshot(EmitData.LinkMode, v60, v83, v63, WorldCFrame);
        v81.Events = EmitData.Events;
        v81.StartTime = os.clock();
        v81.TotalKeyFrames = InvertMotion and v78 and v78 or math.max(1, EmitData.TotalKeyFrames);
        v81.CurrentStep = 0;
        v81.AccumulatedDT = 0;
        v81.LifeTime = v62;
        v81.PartLife = EmitData.PartLife or 0;
        v81.LocalCF = v79;
        v81._localWorldCF = v79;
        v81.BaseDirection = LookVector;
        v81._initialBaseDirection = LookVector;
        v81.EmissionDirection = EmitData.EmissionDirection;
        v81.SpreadRotation = CFrame_Angles_ret;
        v81.Acceleration = EmitData.ParticleData.Acceleration;
        v81.Drag = EmitData.ParticleData.Drag;
        v81.VelocityVectored = EmitData.VelocityVectored;
        v81.InvertMotion = InvertMotion;
        v81.SimLocalCFrames = v77;
        v81.RotMode = EmitData.RotMode or "OverLife";
        v81.RotOrder = EmitData.RotOrder or "Global";
        v81.AccRotX = 0;
        v81.AccRotY = 0;
        v81.AccRotZ = 0;
        v81.Orientation = EmitData.Orientation;
        v81.ZOffset = EmitData.ZOffset;
        v81.NeedsFullIteration = EmitData.VelocityVectored;
        local v84;

        if EmitData.RotMode == "Speed" then
            v84 = not EmitData.VelocityVectored;
        else
            v84 = false;
        end;

        v81.NeedsRotAccum = v84;
        v81.HasDrag = EmitData.ParticleData.Drag ~= 0;
        v81.HasAccel = EmitData.ParticleData.Acceleration.Magnitude > 0;
        v81.SpawnRotation = v73.Rotation;
        v81.SpawnEmitterRotation = v73.Rotation * v69:Inverse();
        v81.DisplacementMode = EmitData.DisplacementMode;
        v81._sleepRadius = 1;
        v81._prevWorldOff = Vector3.new(0, 0, 0);
        v81.HasPosOffsetGraphs = (EmitData.PosOffsetX ~= nil or EmitData.PosOffsetY ~= nil) and true or EmitData.PosOffsetZ ~= nil;
        v81.Graphs = {
            Speed = EmitData.Speed,
            RotSpeedX = EmitData.RotSpeedX,
            RotSpeedY = EmitData.RotSpeedY,
            RotSpeedZ = EmitData.RotSpeedZ,
            PosOffsetX = EmitData.PosOffsetX,
            PosOffsetY = EmitData.PosOffsetY,
            PosOffsetZ = EmitData.PosOffsetZ,
            Timescale = EmitData.Timescale
        };
        v81.Seeds = v76;
        v81._effectiveElapsed = Graph.InitialEffectiveElapsed(EmitData.Timescale, v76.Timescale, v62);
        v81.IsAnimate = true;
        v81.AnimateItem = p57;
        v81.InitialAnchorCF = CFrame2;
        v81.InitialLocalCF = v73;

        if v81.HasPosOffsetGraphs then
            local v85 = v81.Graphs.PosOffsetX and (Graph.QueryPointsWithTime(0, v81.Graphs.PosOffsetX, v81.Seeds.PosOffsetX) or 0) or 0;
            local v86 = v81.Graphs.PosOffsetY and (Graph.QueryPointsWithTime(0, v81.Graphs.PosOffsetY, v81.Seeds.PosOffsetY) or 0) or 0;
            local v87 = v81.Graphs.PosOffsetZ and (Graph.QueryPointsWithTime(0, v81.Graphs.PosOffsetZ, v81.Seeds.PosOffsetZ) or 0) or 0;
            local v88 = PartConstants.resolveDisplacement(Vector3.new(v85, v86, v87), EmitData.DisplacementMode or "Global", v81.SpawnRotation, v81.SpawnEmitterRotation);
            v81._prevWorldOff = v88;

            if v85 ~= 0 or (v86 ~= 0 or v87 ~= 0) then
                v81.LocalCF = v81.LocalCF + v88;
                v81.VisualPart.CFrame = v81.VisualPart.CFrame + v88;
            end;
        end;

        Turbulence.buildInto(v81, EmitData);
        v81._sourceItem = p57;
        u1._seedTsOverride(v81, p57);
        StaticPass.apply(v81);
        p56.ActiveAnimates[p57] = v81;
        p56:_applyEmitVisualPasses(v81);

        if p59 and p59.ParentScale then
            v81.ParentScale = p59.ParentScale;
        end;

        v81._nestedAlive = { true };
        p56:_registerEmit(v81, p59);

        if p56.ActiveAnimates[p57] == v81 then
            AtRest.wake(RenderTemplate);
        end;

        local v89 = p56:_makeAliveCheck();

        for _, child in RenderTemplate:GetChildren() do
            if child:IsA("Attachment") then
                Particles.EnableEmitChildrenAndRepeatForAttachments(child, v89);
            end;

            Particles.EnableEmitSingle(child, v89);
        end;

        NestedEmit.walk(p56, RenderTemplate, RenderTemplate, v81._nestedAlive, p59, v81.ParentScale);
    end;

    function u1.EmitBeamAnimate(p90, p91, p92, p93) -- Line: 477
        -- upvalues: Graph (ref), Range (ref), u1 (copy)
        if not (p91 and p91.Parent) then
            return;
        end;

        local EmitData = p90:GetEmitData(p91, p93);

        if not (EmitData and EmitData.RenderTemplate) then
            return;
        end;

        local RenderTemplate = EmitData.RenderTemplate;
        local v94 = {
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

        if EmitData.FaceCamera ~= nil then
            RenderTemplate.FaceCamera = EmitData.FaceCamera;
        end;

        local v95 = {};

        for i, v in pairs(EmitData.BeamProps) do
            if v then
                if Graph.IsStatic(v) then
                    RenderTemplate[i] = Graph.GetStaticValue(v, RenderTemplate[i]);
                else
                    local v96 = Graph.GenerateSeed(v);
                    v95[i] = {
                        Sequence = v,
                        Seed = v96
                    };

                    if i ~= "TextureSpeed" then
                        local v97 = Graph.QueryPointsWithTime(0, v, v96);

                        if i == "Segments" then
                            local math_round_ret = math.round(v97);
                            v97 = math.max(20, math_round_ret);
                        end;

                        RenderTemplate[i] = v97;
                    end;
                end;
            end;
        end;

        if v95.TextureSpeed then
            RenderTemplate.TextureSpeed = 0;
        end;

        local v98, v99 = Graph.CollectGraphStates(EmitData.GraphBlender);
        local v100 = {};

        for i = 1, #v98 - 1 do
            v100[i] = Graph.PrecomputeMergedTimes(v98[i].Graph, v98[i + 1].Graph);
            local _ = i;
        end;

        local v101 = {};

        for i = 1, #v99 - 1 do
            v101[i] = Graph.PrecomputeMergedColorTimes(v99[i].Graph, v99[i + 1].Graph);
            local _ = i;
        end;

        if #v98 > 0 then
            RenderTemplate.Transparency = v98[1].Graph;
        end;

        if #v99 > 0 then
            RenderTemplate.Color = v99[1].Graph;
        end;

        RenderTemplate.Enabled = true;
        local v102 = Range.RandomValueFromRange(EmitData.Lifetime);
        local v103 = v102 <= 0 and 0.001 or v102;
        local v104 = Graph.GenerateSeed(EmitData.BeamTimescale);
        local v105 = {
            Type = "Beam",
            CurrentStep = 0,
            IsAnimate = true,
            VisualPart = RenderTemplate,
            Link = p92,
            Events = EmitData.Events,
            StartTime = os.clock(),
            TotalKeyFrames = math.max(1, EmitData.TotalKeyFrames),
            LifeTime = v103,
            PartLife = EmitData.PartLife or 0,
            AnimatedProps = v95,
            TransStates = v98,
            ColorStates = v99,
            TransMergedTimes = v100,
            ColorMergedTimes = v101,
            BeamSnapshot = v94,
            Graphs = {
                Timescale = EmitData.BeamTimescale
            },
            Seeds = {
                Timescale = v104
            },
            _effectiveElapsed = Graph.InitialEffectiveElapsed(EmitData.BeamTimescale, v104, v103),
            AnimateItem = p91
        };

        if p93 and p93.ParentScale then
            v105.ParentScale = p93.ParentScale;
            v105._baseWidth0 = RenderTemplate.Width0;
            v105._baseWidth1 = RenderTemplate.Width1;
            v105._baseCurveSize0 = RenderTemplate.CurveSize0;
            v105._baseCurveSize1 = RenderTemplate.CurveSize1;
            v105._baseTextureLength = RenderTemplate.TextureLength;
            v105._baseSegments = RenderTemplate.Segments;
        end;

        v105._sourceItem = p91;
        u1._seedTsOverride(v105, p91);
        p90.ActiveAnimates[p91] = v105;
        p90:_registerEmit(v105, p93);
    end;
end;