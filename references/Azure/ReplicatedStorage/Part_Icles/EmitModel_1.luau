 
 

local Graph = require(script.Parent.Graph);
local Range = require(script.Parent.Range);
local AxisLinks = require(script.Parent.AxisLinks);
local Particles = require(script.Parent.Particles);
local PartConstants = require(script.Parent.PartConstants);
local LinkCF = require(script.Parent.LinkCF);
local Pool = require(script.Parent.Pool);
local NestedEmit = require(script.Parent.NestedEmit);
local StaticPass = require(script.Parent.StaticPass);
local Turbulence = require(script.Parent.Turbulence);
local AtRest = require(script.Parent.AtRest);
local DirectionVectors = PartConstants.DirectionVectors;

return function(u1) -- Line: 19
    -- upvalues: Range (copy), LinkCF (copy), DirectionVectors (copy), AxisLinks (copy), PartConstants (copy), Graph (copy), Pool (copy), Turbulence (copy), Particles (copy), StaticPass (copy), NestedEmit (copy), AtRest (copy)
    function u1.EmitModel(p2, p3, p4, p5) -- Line: 22
        -- upvalues: Range (ref), LinkCF (ref), DirectionVectors (ref), AxisLinks (ref), PartConstants (ref), Graph (ref), Pool (ref), Turbulence (ref), Particles (ref), u1 (copy), StaticPass (ref), NestedEmit (ref)
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
        local Pivot = p3:GetPivot();
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
                v10 = CFrame.new(v10.Position) * Pivot.Rotation;
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

            v10 = LinkCF.spawnFrame(EmitData.LinkMode, v6, p3, Pivot, v11, v12, v9);
        else
            v10 = Pivot;
        end;

        local v13 = DirectionVectors[EmitData.EmissionDirection] or DirectionVectors[Enum.NormalId.Top];
        local v14 = v10[v13.vector] * v13.multiplier;
        local v15 = EmitData.DirMode or "RigidLocal";
        local v16 = AxisLinks.sampleRangeAxes(EmitData, EmitData.AxisLinks, { "RotX", "RotY", "RotZ" }, Range, p5);
        local v17 = PartConstants.composeRotation(EmitData.RotOrder or "Global", v16.RotX, v16.RotY, v16.RotZ);
        local v18 = PartConstants.applyPositionOffset(v10 * v17, EmitData, v6, p3, Range, AxisLinks, p5);

        if v15 == "Global" then
            v18 = CFrame.new(v18.Position) * v17;
        end;

        if v15 == "Local" then
            v14 = v18[v13.vector] * v13.multiplier;
        elseif v15 == "Global" then
            v14 = CFrame.new()[v13.vector] * v13.multiplier;
        end;

        local v19, v20;

        if EmitData.ParticleData.SpreadAngle.X > 0 or EmitData.ParticleData.SpreadAngle.Y > 0 then
            v19 = (math.random() * 2 - 1) * EmitData.ParticleData.SpreadAngle.X;
            v20 = (math.random() * 2 - 1) * EmitData.ParticleData.SpreadAngle.Y;
        else
            v19 = 0;
            v20 = 0;
        end;

        local CFrame_Angles_ret = CFrame.Angles(math.rad(v19), math.rad(v20), 0);
        local LookVector = (CFrame.lookAt(Vector3.new(), v14) * CFrame_Angles_ret).LookVector;
        local v21 = {
            RotSpeedX = Graph.GenerateSeed(EmitData.RotSpeedX),
            RotSpeedY = Graph.GenerateSeed(EmitData.RotSpeedY),
            RotSpeedZ = Graph.GenerateSeed(EmitData.RotSpeedZ),
            PosOffsetX = Graph.GenerateSeed(EmitData.PosOffsetX),
            PosOffsetY = Graph.GenerateSeed(EmitData.PosOffsetY),
            PosOffsetZ = Graph.GenerateSeed(EmitData.PosOffsetZ),
            Speed = Graph.GenerateSeed(EmitData.Speed),
            Scale = Graph.GenerateSeed(EmitData.Scale),
            Timescale = Graph.GenerateSeed(EmitData.Timescale)
        };
        AxisLinks.applyGraphAxisAliases(EmitData, v21, EmitData.AxisLinks);
        local InvertMotion = EmitData.InvertMotion;
        local v22, v23;

        if InvertMotion then
            local v24 = v18.Rotation * v17:Inverse();
            local v25;

            if p5 then
                v25 = p5._linkLocal;
            else
                v25 = p5;
            end;

            local v26;

            if v9 then
                v26 = p3:GetPivot() or nil;
            else
                v26 = nil;
            end;

            v22, v23 = p2:PreSimulateForward(EmitData, v21, v18, LookVector, CFrame_Angles_ret, v6, v8, nil, v24, v25, v26);
        else
            v22 = nil;
            v23 = nil;
        end;

        local u27 = Pool.acquireOrCopyBare(EmitData.RenderTemplate, "Model", EmitData.Pool);
        u27.Archivable = false;
        local RenderTemplate = EmitData.RenderTemplate;

        if RenderTemplate and u27:GetAttribute("_pooledModelScale") == nil then
            local success, result = pcall(function() -- Line: 121
                -- upvalues: RenderTemplate (copy)
                return RenderTemplate:GetScale();
            end);

            if success and result then
                u27:SetAttribute("_pooledModelScale", result);
            end;
        end;

        local Attribute = u27:GetAttribute("_pooledModelScale");

        if Attribute then
            pcall(function() -- Line: 125
                -- upvalues: u27 (copy), Attribute (copy)
                u27:ScaleTo(Attribute);
            end);
        end;

        local v28;

        if p5 then
            v28 = p5._linkLocal;
        else
            v28 = p5;
        end;

        local v29 = LinkCF.emitParentFrame(EmitData.LinkMode, v6, v28, v9, p3:GetPivot());

        if InvertMotion and v22 then
            v18 = v22[v23 or EmitData.TotalKeyFrames] or v22[0];
            u27:PivotTo(v29 * v18);
        else
            if v6 then
                v18 = v29:ToObjectSpace(v18) or v18;
            end;

            u27:PivotTo(v29 * v18);
        end;

        local v30 = {
            Type = "Model",
            VisualPart = u27,
            Link = v6,
            LinkMode = EmitData.LinkMode,
            LinkAxes = EmitData.LinkAxes
        };
        local v31;

        if p5 then
            v31 = p5._linkLocal or nil;
        else
            v31 = nil;
        end;

        v30._linkLocal = v31;
        v30._rigidLocalParentCF = LinkCF.rigidSnapshot(EmitData.LinkMode, v6, v29);
        v30.Events = EmitData.Events;
        v30.StartTime = os.clock();
        v30.TotalKeyFrames = InvertMotion and v23 and v23 or math.max(1, EmitData.TotalKeyFrames);
        v30.CurrentStep = 0;
        v30.AccumulatedDT = 0;
        v30.LifeTime = v8;
        v30.PartLife = EmitData.PartLife;
        v30.CurrentPosition = u27:GetPivot().Position;
        v30.LocalCF = v18;
        v30.BaseDirection = LookVector;
        v30._accelVel = Vector3.new(0, 0, 0);
        v30.SpeedMultiplier = 1;
        v30._spinRate = Vector3.new(0, 0, 0);
        v30._spinAccumX = 0;
        v30._spinAccumY = 0;
        v30._spinAccumZ = 0;
        v30.EmissionDirection = EmitData.EmissionDirection;
        v30.SpreadRotation = CFrame_Angles_ret;
        v30.Acceleration = EmitData.ParticleData.Acceleration;
        v30.Drag = EmitData.ParticleData.Drag;
        v30.VelocityVectored = EmitData.VelocityVectored;
        v30.InvertMotion = InvertMotion;
        v30.SimLocalCFrames = v22;
        v30.RotMode = EmitData.RotMode or "OverLife";
        v30.RotOrder = EmitData.RotOrder or "Global";
        v30.AccRotX = 0;
        v30.AccRotY = 0;
        v30.AccRotZ = 0;
        v30.Orientation = EmitData.Orientation;
        v30.ZOffset = EmitData.ZOffset;
        v30._localWorldCF = v18;
        v30.SpawnRotation = v18.Rotation;
        v30.SpawnEmitterRotation = v18.Rotation * v17:Inverse();
        v30.DisplacementMode = EmitData.DisplacementMode;
        v30._sleepRadius = 1;
        v30._prevWorldOff = Vector3.new(0, 0, 0);
        v30.HasPosOffsetGraphs = (EmitData.PosOffsetX ~= nil or EmitData.PosOffsetY ~= nil) and true or EmitData.PosOffsetZ ~= nil;
        v30.NeedsFullIteration = EmitData.VelocityVectored;
        local v32;

        if EmitData.RotMode == "Speed" then
            v32 = not EmitData.VelocityVectored;
        else
            v32 = false;
        end;

        v30.NeedsRotAccum = v32;
        v30.HasDrag = EmitData.ParticleData.Drag ~= 0;
        v30.HasAccel = EmitData.ParticleData.Acceleration.Magnitude > 0;
        v30.Graphs = {
            RotSpeedX = EmitData.RotSpeedX,
            RotSpeedY = EmitData.RotSpeedY,
            RotSpeedZ = EmitData.RotSpeedZ,
            PosOffsetX = EmitData.PosOffsetX,
            PosOffsetY = EmitData.PosOffsetY,
            PosOffsetZ = EmitData.PosOffsetZ,
            Speed = EmitData.Speed,
            Scale = EmitData.Scale,
            Timescale = EmitData.Timescale
        };
        v30.Seeds = v21;
        v30._effectiveElapsed = Graph.InitialEffectiveElapsed(EmitData.Timescale, v21.Timescale, v8);

        if v30.HasPosOffsetGraphs then
            local v33 = v30.Graphs.PosOffsetX and (Graph.QueryPointsWithTime(0, v30.Graphs.PosOffsetX, v30.Seeds.PosOffsetX) or 0) or 0;
            local v34 = v30.Graphs.PosOffsetY and (Graph.QueryPointsWithTime(0, v30.Graphs.PosOffsetY, v30.Seeds.PosOffsetY) or 0) or 0;
            local v35 = v30.Graphs.PosOffsetZ and (Graph.QueryPointsWithTime(0, v30.Graphs.PosOffsetZ, v30.Seeds.PosOffsetZ) or 0) or 0;
            local v36 = PartConstants.resolveDisplacement(Vector3.new(v33, v34, v35), EmitData.DisplacementMode or "Global", v30.SpawnRotation, v30.SpawnEmitterRotation);
            v30._prevWorldOff = v36;

            if v33 ~= 0 or (v34 ~= 0 or v35 ~= 0) then
                v30.LocalCF = v30.LocalCF + v36;
                v30.VisualPart:PivotTo(v30.VisualPart:GetPivot() + v36);
            end;
        end;

        Turbulence.buildInto(v30, EmitData);
        local v37 = {};

        for _, descendant in u27:GetDescendants() do
            if descendant:IsA("Beam") and not descendant:GetAttribute("Transformed") then
                table.insert(v37, descendant);
            end;
        end;

        if #v37 > 0 then
            v30._visualBeams = v37;
        end;

        if p5 and p5.ParentScale then
            v30.ParentScale = p5.ParentScale;
        end;

        u27:ScaleTo(math.max(0.001, Graph.QueryPointsWithTime(0, v30.Graphs.Scale, v30.Seeds.Scale)) * PartConstants.getParentScaleFactor(v30.ParentScale, v30.StartTime, Graph));

        for _, v in ipairs(v37) do
            if v.Segments < 20 then
                v.Segments = 20;
            end;
        end;

        p2:_matteCarry(p5, v30, nil, "Pivot");
        u27.Parent = EmitData.EmitParent or p2:GetFolder();
        Pool.restoreTrails(u27, "Model");

        for _, descendant in u27:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        p2:_adoptIntoContainer(v30, p5);
        local v38 = p2:_makeAliveCheck();

        for _, descendant in u27:GetDescendants() do
            Particles.EnableEmitSingle(descendant, v38);
        end;

        v30._sourceItem = p3;
        u1._seedTsOverride(v30, p3);

        if EmitData.Pool ~= false then
            v30._sourceRT = EmitData.RenderTemplate;
            v30._poolKind = "Model";
        end;

        StaticPass.apply(v30);
        p2:_applyEmitVisualPasses(v30);
        v30._nestedAlive = { true };
        p2:_registerEmit(v30, p5);
        local v39 = {
            Owner = v30,
            ScaleTextureLength = EmitData.ScaleTextureLength ~= false,
            ScaleMotion = EmitData.ScaleMotion ~= false,
            ScaleRotation = EmitData.ScaleRotation == true,
            Parent = v30.ParentScale
        };
        v30._scaleNode = v39;
        NestedEmit.walk(p2, EmitData.RenderTemplate, u27, v30._nestedAlive, p5, v39);
    end;

    function u1.EmitModelAnimate(p40, u41, p42, p43) -- Line: 279
        -- upvalues: Range (ref), LinkCF (ref), DirectionVectors (ref), AxisLinks (ref), PartConstants (ref), Graph (ref), Turbulence (ref), Particles (ref), u1 (copy), StaticPass (ref), AtRest (ref), NestedEmit (ref)
        if not (u41 and u41.Parent) then
            return;
        end;

        local EmitData = p40:GetEmitData(u41, p43);

        if not (EmitData and EmitData.RenderTemplate) then
            return;
        end;

        local v44 = p42 or EmitData.Link;
        local v45 = Range.RandomValueFromRange(EmitData.Lifetime);
        local v46 = v45 <= 0 and 0.001 or v45;
        local RenderTemplate = EmitData.RenderTemplate;
        local Pivot = RenderTemplate:GetPivot();
        local v47 = LinkCF.spawnAxes(EmitData, p43);
        local Pivot2 = u41:GetPivot();
        local v48 = DirectionVectors[EmitData.EmissionDirection] or DirectionVectors[Enum.NormalId.Top];
        local v49 = Pivot2[v48.vector] * v48.multiplier;
        local v50 = EmitData.DirMode or "RigidLocal";
        local v51 = AxisLinks.sampleRangeAxes(EmitData, EmitData.AxisLinks, { "RotX", "RotY", "RotZ" }, Range, p43);
        local v52 = PartConstants.composeRotation(EmitData.RotOrder or "Global", v51.RotX, v51.RotY, v51.RotZ);
        local v53 = PartConstants.applyPositionOffset(Pivot2 * v52, EmitData, v44, u41, Range, AxisLinks, p43);

        if v50 == "Global" then
            v53 = CFrame.new(v53.Position) * v52;
        end;

        if v50 == "Local" then
            v49 = v53[v48.vector] * v48.multiplier;
        elseif v50 == "Global" then
            v49 = CFrame.new()[v48.vector] * v48.multiplier;
        end;

        local v54, v55;

        if EmitData.ParticleData.SpreadAngle.X > 0 or EmitData.ParticleData.SpreadAngle.Y > 0 then
            v54 = (math.random() * 2 - 1) * EmitData.ParticleData.SpreadAngle.X;
            v55 = (math.random() * 2 - 1) * EmitData.ParticleData.SpreadAngle.Y;
        else
            v54 = 0;
            v55 = 0;
        end;

        local CFrame_Angles_ret = CFrame.Angles(math.rad(v54), math.rad(v55), 0);
        local LookVector = (CFrame.lookAt(Vector3.new(), v49) * CFrame_Angles_ret).LookVector;
        local v56 = {
            RotSpeedX = Graph.GenerateSeed(EmitData.RotSpeedX),
            RotSpeedY = Graph.GenerateSeed(EmitData.RotSpeedY),
            RotSpeedZ = Graph.GenerateSeed(EmitData.RotSpeedZ),
            PosOffsetX = Graph.GenerateSeed(EmitData.PosOffsetX),
            PosOffsetY = Graph.GenerateSeed(EmitData.PosOffsetY),
            PosOffsetZ = Graph.GenerateSeed(EmitData.PosOffsetZ),
            Speed = Graph.GenerateSeed(EmitData.Speed),
            Scale = Graph.GenerateSeed(EmitData.Scale),
            Timescale = Graph.GenerateSeed(EmitData.Timescale)
        };
        AxisLinks.applyGraphAxisAliases(EmitData, v56, EmitData.AxisLinks);
        local InvertMotion = EmitData.InvertMotion;
        local v57, v58;

        if InvertMotion then
            local v59 = v53.Rotation * v52:Inverse();
            local v60;

            if p43 then
                v60 = p43._linkLocal;
            else
                v60 = p43;
            end;

            local v61;

            if v47 then
                v61 = u41:GetPivot() or nil;
            else
                v61 = nil;
            end;

            v57, v58 = p40:PreSimulateForward(EmitData, v56, v53, LookVector, CFrame_Angles_ret, v44, v46, nil, v59, v60, v61);
        else
            v57 = nil;
            v58 = nil;
        end;

        local v62;

        if p43 then
            v62 = p43._linkLocal;
        else
            v62 = p43;
        end;

        local v63 = LinkCF.emitParentFrame(EmitData.LinkMode, v44, v62, v47, u41:GetPivot());

        if InvertMotion and v57 then
            v53 = v57[v58 or EmitData.TotalKeyFrames] or v57[0];
        elseif v44 then
            v53 = v63:ToObjectSpace(v53) or v53;
        end;

        RenderTemplate:PivotTo(v63 * v53);
        local v64 = {
            Type = "Model",
            VisualPart = RenderTemplate,
            Link = v44,
            LinkMode = EmitData.LinkMode,
            LinkAxes = EmitData.LinkAxes
        };
        local v65;

        if p43 then
            v65 = p43._linkLocal or nil;
        else
            v65 = nil;
        end;

        v64._linkLocal = v65;
        v64._rigidLocalParentCF = LinkCF.rigidSnapshot(EmitData.LinkMode, v44, v63);
        v64.Events = EmitData.Events;
        v64.StartTime = os.clock();
        v64.TotalKeyFrames = InvertMotion and v58 and v58 or math.max(1, EmitData.TotalKeyFrames);
        v64.CurrentStep = 0;
        v64.AccumulatedDT = 0;
        v64.LifeTime = v46;
        v64.PartLife = EmitData.PartLife or 0;
        v64.CurrentPosition = RenderTemplate:GetPivot().Position;
        v64.LocalCF = v53;
        v64.BaseDirection = LookVector;
        v64._accelVel = Vector3.new(0, 0, 0);
        v64.SpeedMultiplier = 1;
        v64._spinRate = Vector3.new(0, 0, 0);
        v64._spinAccumX = 0;
        v64._spinAccumY = 0;
        v64._spinAccumZ = 0;
        v64.EmissionDirection = EmitData.EmissionDirection;
        v64.SpreadRotation = CFrame_Angles_ret;
        v64.Acceleration = EmitData.ParticleData.Acceleration;
        v64.Drag = EmitData.ParticleData.Drag;
        v64.VelocityVectored = EmitData.VelocityVectored;
        v64.InvertMotion = InvertMotion;
        v64.SimLocalCFrames = v57;
        v64.RotMode = EmitData.RotMode or "OverLife";
        v64.RotOrder = EmitData.RotOrder or "Global";
        v64.AccRotX = 0;
        v64.AccRotY = 0;
        v64.AccRotZ = 0;
        v64.Orientation = EmitData.Orientation;
        v64.ZOffset = EmitData.ZOffset;
        v64._localWorldCF = v53;
        v64.SpawnRotation = v53.Rotation;
        v64.SpawnEmitterRotation = v53.Rotation * v52:Inverse();
        v64.DisplacementMode = EmitData.DisplacementMode;
        v64._sleepRadius = 1;
        v64._prevWorldOff = Vector3.new(0, 0, 0);
        v64.HasPosOffsetGraphs = (EmitData.PosOffsetX ~= nil or EmitData.PosOffsetY ~= nil) and true or EmitData.PosOffsetZ ~= nil;
        v64.NeedsFullIteration = EmitData.VelocityVectored;
        local v66;

        if EmitData.RotMode == "Speed" then
            v66 = not EmitData.VelocityVectored;
        else
            v66 = false;
        end;

        v64.NeedsRotAccum = v66;
        v64.HasDrag = EmitData.ParticleData.Drag ~= 0;
        v64.HasAccel = EmitData.ParticleData.Acceleration.Magnitude > 0;
        v64.Graphs = {
            RotSpeedX = EmitData.RotSpeedX,
            RotSpeedY = EmitData.RotSpeedY,
            RotSpeedZ = EmitData.RotSpeedZ,
            PosOffsetX = EmitData.PosOffsetX,
            PosOffsetY = EmitData.PosOffsetY,
            PosOffsetZ = EmitData.PosOffsetZ,
            Speed = EmitData.Speed,
            Scale = EmitData.Scale,
            Timescale = EmitData.Timescale
        };
        v64.Seeds = v56;
        v64._effectiveElapsed = Graph.InitialEffectiveElapsed(EmitData.Timescale, v56.Timescale, v46);
        v64.IsAnimate = true;
        v64.AnimateItem = u41;
        v64.InitialAnchorCF = Pivot;
        v64.InitialLocalCF = v53;
        local success, result = pcall(function() -- Line: 424
            -- upvalues: u41 (copy)
            return u41:GetScale();
        end);
        v64.InitialScale = success and result and result or 1;

        if v64.HasPosOffsetGraphs then
            local v67 = v64.Graphs.PosOffsetX and (Graph.QueryPointsWithTime(0, v64.Graphs.PosOffsetX, v64.Seeds.PosOffsetX) or 0) or 0;
            local v68 = v64.Graphs.PosOffsetY and (Graph.QueryPointsWithTime(0, v64.Graphs.PosOffsetY, v64.Seeds.PosOffsetY) or 0) or 0;
            local v69 = v64.Graphs.PosOffsetZ and (Graph.QueryPointsWithTime(0, v64.Graphs.PosOffsetZ, v64.Seeds.PosOffsetZ) or 0) or 0;
            local v70 = PartConstants.resolveDisplacement(Vector3.new(v67, v68, v69), EmitData.DisplacementMode or "Global", v64.SpawnRotation, v64.SpawnEmitterRotation);
            v64._prevWorldOff = v70;

            if v67 ~= 0 or (v68 ~= 0 or v69 ~= 0) then
                v64.LocalCF = v64.LocalCF + v70;
                v64.VisualPart:PivotTo(v64.VisualPart:GetPivot() + v70);
            end;
        end;

        Turbulence.buildInto(v64, EmitData);
        local v71 = {};

        for _, descendant in RenderTemplate:GetDescendants() do
            if descendant:IsA("Beam") and not descendant:GetAttribute("Transformed") then
                table.insert(v71, descendant);
            end;
        end;

        if #v71 > 0 then
            v64._visualBeams = v71;
        end;

        if p43 and p43.ParentScale then
            v64.ParentScale = p43.ParentScale;
        end;

        RenderTemplate:ScaleTo(math.max(0.001, Graph.QueryPointsWithTime(0, v64.Graphs.Scale, v64.Seeds.Scale)) * PartConstants.getParentScaleFactor(v64.ParentScale, v64.StartTime, Graph));

        for _, v in ipairs(v71) do
            if v.Segments < 20 then
                v.Segments = 20;
            end;
        end;

        local v72 = p40:_makeAliveCheck();

        for _, descendant in RenderTemplate:GetDescendants() do
            Particles.EnableEmitSingle(descendant, v72);
        end;

        v64._sourceItem = u41;
        u1._seedTsOverride(v64, u41);
        StaticPass.apply(v64);
        p40.ActiveAnimates[u41] = v64;
        p40:_applyEmitVisualPasses(v64);
        v64._nestedAlive = { true };
        p40:_registerEmit(v64, p43);

        if p40.ActiveAnimates[u41] == v64 then
            AtRest.wake(RenderTemplate);
        end;

        local v73 = {
            Owner = v64,
            ScaleTextureLength = EmitData.ScaleTextureLength ~= false,
            ScaleMotion = EmitData.ScaleMotion ~= false,
            ScaleRotation = EmitData.ScaleRotation == true,
            Parent = v64.ParentScale
        };
        v64._scaleNode = v73;
        NestedEmit.walk(p40, RenderTemplate, RenderTemplate, v64._nestedAlive, p43, v73);
    end;
end;