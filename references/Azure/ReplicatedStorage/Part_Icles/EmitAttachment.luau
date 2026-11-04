 

 

local Graph = require(script.Parent.Graph);
local Range = require(script.Parent.Range);
local AxisLinks = require(script.Parent.AxisLinks);
local Particles = require(script.Parent.Particles);
local PartConstants = require(script.Parent.PartConstants);
local Pool = require(script.Parent.Pool);
local NestedEmit = require(script.Parent.NestedEmit);
local NestedScale = require(script.Parent.NestedScale);
local StaticPass = require(script.Parent.StaticPass);
local LinkCF = require(script.Parent.LinkCF);
local Turbulence = require(script.Parent.Turbulence);
local VisualHost = require(script.Parent.VisualHost);
local DirectionVectors = PartConstants.DirectionVectors;

local function _findBasePartAncestor(p1) -- Line: 24
    local Parent = p1.Parent;

    while Parent do
        if Parent:IsA("BasePart") then
            return Parent;
        end;

        Parent = Parent.Parent;
    end;

    return nil;
end;

return function(u2) -- Line: 33
    -- upvalues: Range (copy), LinkCF (copy), NestedEmit (copy), VisualHost (copy), DirectionVectors (copy), AxisLinks (copy), PartConstants (copy), Graph (copy), Pool (copy), NestedScale (copy), Turbulence (copy), StaticPass (copy), Particles (copy)
    function u2.EmitAttachment(p3, p4, p5, p6) -- Line: 37
        -- upvalues: Range (ref), LinkCF (ref), NestedEmit (ref), VisualHost (ref), DirectionVectors (ref), AxisLinks (ref), PartConstants (ref), Graph (ref), Pool (ref), NestedScale (ref), Turbulence (ref), u2 (copy), StaticPass (ref), Particles (ref)
        if not (p4 and p4.Parent) then
            return;
        end;

        local EmitData = p3:GetEmitData(p4, p6);

        if not (EmitData and EmitData.RenderTemplate) then
            return;
        end;

        local v7;

        if p6 and p6.IgnoreLink then
            v7 = nil;
        else
            v7 = p5 or EmitData.Link;
        end;

        local v8 = Range.RandomValueFromRange(EmitData.Lifetime);
        local v9 = v8 <= 0 and 0.001 or v8;
        local WorldCFrame = p4.WorldCFrame;
        local v10 = LinkCF.spawnAxes(EmitData, p6);
        local v11 = nil;

        if p6 then
            if p6.EventOriginResolver then
                v11 = p6.EventOriginResolver();
            end;

            v11 = v11 or p6.EventOriginCF;
        end;

        if v11 then
            if not (p6 and p6.UseFullOrigin) then
                v11 = CFrame.new(v11.Position) * WorldCFrame.Rotation;
            end;
        elseif v7 then
            local v12;

            if p6 then
                v12 = p6._linkLocal;
            else
                v12 = p6;
            end;

            local v13;

            if p6 then
                v13 = p6._sourceParentCF;
            else
                v13 = p6;
            end;

            v11 = LinkCF.spawnFrame(EmitData.LinkMode, v7, p4, WorldCFrame, v12, v13, v10);
        else
            v11 = WorldCFrame;
        end;

        local v14 = EmitData.EmitParent or NestedEmit.resolveCloneParent(p4, v7, p6);
        local v15 = nil;

        if not v14 then
            local Parent = p4.Parent;

            while true do
                if not Parent then
                    Parent = nil;
                    break;
                end;

                if Parent:IsA("BasePart") then
                    break;
                end;

                Parent = Parent.Parent;
            end;

            if Parent then
                v14 = VisualHost.acquireCarrier(Parent);
                v15 = v14;
            else
                v14 = VisualHost.worldCarrier();
            end;
        end;

        local v16 = v14 and v14:IsA("BasePart") and v14.CFrame or CFrame.new();
        local v17 = v16:ToObjectSpace(v11);
        local v18 = DirectionVectors[EmitData.EmissionDirection] or DirectionVectors[Enum.NormalId.Top];
        local v19 = EmitData.DirMode or "RigidLocal";
        local v20 = AxisLinks.sampleRangeAxes(EmitData, EmitData.AxisLinks, { "RotX", "RotY", "RotZ" }, Range, p6);
        local v21 = PartConstants.composeRotation(EmitData.RotOrder or "Global", v20.RotX, v20.RotY, v20.RotZ);
        local v22 = v17 * v21;
        local v23;

        if v19 == "Local" then
            v23 = v22[v18.vector] * v18.multiplier;
        elseif v19 == "Global" then
            v23 = CFrame.new()[v18.vector] * v18.multiplier;

            if v14 and v14:IsA("BasePart") then
                v23 = v14.CFrame:VectorToObjectSpace(v23);
            end;
        else
            v23 = v17[v18.vector] * v18.multiplier;
        end;

        local v24 = 1;
        local v25;

        if p6 then
            v25 = p6.ParentScale;
        else
            v25 = p6;
        end;

        if v25 and v25.ScaleMotion ~= false then
            v24 = PartConstants.getParentScaleFactor(v25, os.clock(), Graph);
        end;

        local v26 = PartConstants.applyPositionOffset(v22, EmitData, v7, p4, Range, AxisLinks, p6, v16, v24);

        if v19 == "Global" then
            if v14 and v14:IsA("BasePart") then
                v26 = CFrame.new(v26.Position) * v14.CFrame.Rotation:Inverse() * v21;
            else
                v26 = CFrame.new(v26.Position) * v21;
            end;
        end;

        local v27, v28;

        if EmitData.ParticleData.SpreadAngle.X > 0 or EmitData.ParticleData.SpreadAngle.Y > 0 then
            v27 = (math.random() * 2 - 1) * EmitData.ParticleData.SpreadAngle.X;
            v28 = (math.random() * 2 - 1) * EmitData.ParticleData.SpreadAngle.Y;
        else
            v27 = 0;
            v28 = 0;
        end;

        local CFrame_Angles_ret = CFrame.Angles(math.rad(v27), math.rad(v28), 0);
        local LookVector = (CFrame.lookAt(Vector3.new(), v23) * CFrame_Angles_ret).LookVector;
        local v29 = {
            Speed = Graph.GenerateSeed(EmitData.Speed),
            RotSpeedX = Graph.GenerateSeed(EmitData.RotSpeedX),
            RotSpeedY = Graph.GenerateSeed(EmitData.RotSpeedY),
            RotSpeedZ = Graph.GenerateSeed(EmitData.RotSpeedZ),
            PosOffsetX = Graph.GenerateSeed(EmitData.PosOffsetX),
            PosOffsetY = Graph.GenerateSeed(EmitData.PosOffsetY),
            PosOffsetZ = Graph.GenerateSeed(EmitData.PosOffsetZ),
            Timescale = Graph.GenerateSeed(EmitData.Timescale)
        };
        AxisLinks.applyGraphAxisAliases(EmitData, v29, EmitData.AxisLinks);
        local InvertMotion = EmitData.InvertMotion;
        local v30, v31;

        if InvertMotion then
            v30, v31 = p3:PreSimulateAttachmentForward(EmitData, v29, v26, LookVector, CFrame_Angles_ret, v9, nil, v26.Rotation * v21:Inverse());
        else
            v30 = nil;
            v31 = nil;
        end;

        local v32 = Pool.acquireOrCopyBare(EmitData.RenderTemplate, "Attachment", EmitData.Pool);
        v32.Archivable = false;

        if v25 then
            v25 = NestedScale.start(v32, v25, PartConstants.getParentScaleFactor(v25, os.clock(), Graph));
        end;

        if InvertMotion and v30 then
            v26 = v30[v31 or EmitData.TotalKeyFrames] or v30[0];
        end;

        v32.CFrame = v26;
        v32.Parent = v14;

        if p6 and p6._parentCloneMap then
            Pool.registerEmitted(p6._parentCloneMap, p4, v32);
        end;

        Pool.restoreTrails(v32, "Attachment");

        if v7 then
            local v33;

            if p6 then
                v33 = p6._linkLocal;
            else
                v33 = p6;
            end;

            v26 = LinkCF.emitAttachmentParentFrame(EmitData.LinkMode, v7, v14, v33, v10, WorldCFrame):ToObjectSpace(v26);
        end;

        local v34;

        if p6 then
            v34 = p6._linkLocal;
        else
            v34 = p6;
        end;

        local v35 = LinkCF.rigidWorldSnapshot(EmitData.LinkMode, v7, v34, v10, WorldCFrame);
        local v36 = {
            Type = "Attachment",
            VisualPart = v32,
            _carrier = v15,
            Link = v7,
            LinkMode = EmitData.LinkMode,
            LinkAxes = EmitData.LinkAxes
        };
        local v37;

        if p6 then
            v37 = p6._linkLocal or nil;
        else
            v37 = nil;
        end;

        v36._linkLocal = v37;
        v36._rigidLocalParentCF = v35;
        v36.Events = EmitData.Events;
        v36.StartTime = os.clock();
        v36.TotalKeyFrames = InvertMotion and v31 and v31 or math.max(1, EmitData.TotalKeyFrames);
        v36.CurrentStep = 0;
        v36.AccumulatedDT = 0;
        v36.LifeTime = v9;
        v36.PartLife = EmitData.PartLife;
        v36.LocalCF = v26;
        v36._localWorldCF = v26;
        v36.BaseDirection = LookVector;
        v36._accelVel = Vector3.new(0, 0, 0);
        v36.SpeedMultiplier = 1;
        v36._spinRate = Vector3.new(0, 0, 0);
        v36._spinAccumX = 0;
        v36._spinAccumY = 0;
        v36._spinAccumZ = 0;
        v36.EmissionDirection = EmitData.EmissionDirection;
        v36.SpreadRotation = CFrame_Angles_ret;
        v36.Acceleration = EmitData.ParticleData.Acceleration;
        v36.Drag = EmitData.ParticleData.Drag;
        v36.VelocityVectored = EmitData.VelocityVectored;
        v36.InvertMotion = InvertMotion;
        v36.SimLocalCFrames = v30;
        v36.RotMode = EmitData.RotMode or "OverLife";
        v36.RotOrder = EmitData.RotOrder or "Global";
        v36.AccRotX = 0;
        v36.AccRotY = 0;
        v36.AccRotZ = 0;
        v36.Orientation = EmitData.Orientation;
        v36.ZOffset = EmitData.ZOffset;
        v36.SpawnRotation = v26.Rotation;
        v36.SpawnEmitterRotation = v26.Rotation * v21:Inverse();
        v36.DisplacementMode = EmitData.DisplacementMode;
        v36._sleepRadius = 1;
        v36._prevWorldOff = Vector3.new(0, 0, 0);
        v36.HasPosOffsetGraphs = (EmitData.PosOffsetX ~= nil or EmitData.PosOffsetY ~= nil) and true or EmitData.PosOffsetZ ~= nil;
        v36.NeedsFullIteration = EmitData.VelocityVectored;
        local v38;

        if EmitData.RotMode == "Speed" then
            v38 = not EmitData.VelocityVectored;
        else
            v38 = false;
        end;

        v36.NeedsRotAccum = v38;
        v36.HasDrag = EmitData.ParticleData.Drag ~= 0;
        v36.HasAccel = EmitData.ParticleData.Acceleration.Magnitude > 0;
        v36.Graphs = {
            Speed = EmitData.Speed,
            RotSpeedX = EmitData.RotSpeedX,
            RotSpeedY = EmitData.RotSpeedY,
            RotSpeedZ = EmitData.RotSpeedZ,
            PosOffsetX = EmitData.PosOffsetX,
            PosOffsetY = EmitData.PosOffsetY,
            PosOffsetZ = EmitData.PosOffsetZ,
            Timescale = EmitData.Timescale
        };
        v36.Seeds = v29;
        v36._effectiveElapsed = Graph.InitialEffectiveElapsed(EmitData.Timescale, v29.Timescale, v9);

        if v36.HasPosOffsetGraphs then
            local v39 = v36.Graphs.PosOffsetX and (Graph.QueryPointsWithTime(0, v36.Graphs.PosOffsetX, v36.Seeds.PosOffsetX) or 0) or 0;
            local v40 = v36.Graphs.PosOffsetY and (Graph.QueryPointsWithTime(0, v36.Graphs.PosOffsetY, v36.Seeds.PosOffsetY) or 0) or 0;
            local v41 = v36.Graphs.PosOffsetZ and (Graph.QueryPointsWithTime(0, v36.Graphs.PosOffsetZ, v36.Seeds.PosOffsetZ) or 0) or 0;
            local v42 = PartConstants.resolveDisplacement(Vector3.new(v39, v40, v41), EmitData.DisplacementMode or "Global", v36.SpawnRotation, v36.SpawnEmitterRotation);
            v36._prevWorldOff = v42;

            if v39 ~= 0 or (v40 ~= 0 or v41 ~= 0) then
                v36.LocalCF = v36.LocalCF + v42;
                v36.VisualPart.CFrame = v36.VisualPart.CFrame + v42;
            end;
        end;

        Turbulence.buildInto(v36, EmitData);
        v36._sourceItem = p4;
        u2._seedTsOverride(v36, p4);

        if p6 and p6.ParentScale then
            v36.ParentScale = p6.ParentScale;
            v36._scaledContent = v25;
        end;

        if EmitData.Pool ~= false then
            v36._sourceRT = EmitData.RenderTemplate;
            v36._poolKind = "Attachment";
        end;

        StaticPass.apply(v36);
        p3:_applyEmitVisualPasses(v36);
        v36._nestedAlive = { true };
        p3:_registerEmit(v36, p6);

        for _, descendant in v32:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        p3:_adoptIntoContainer(v36, p6);
        local v43 = p3:_makeAliveCheck();

        for _, child in v32:GetChildren() do
            if child:IsA("Attachment") then
                Particles.EnableEmitChildrenAndRepeatForAttachments(child, v43);
            end;

            Particles.EnableEmitSingle(child, v43);
        end;

        NestedEmit.walk(p3, EmitData.RenderTemplate, v32, v36._nestedAlive, p6, v36.ParentScale);
    end;
end;