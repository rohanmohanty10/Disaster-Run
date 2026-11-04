 
 

local Graph = require(script.Parent.Graph);
local Range = require(script.Parent.Range);
local AxisLinks = require(script.Parent.AxisLinks);
local Particles = require(script.Parent.Particles);
local Flipbook = require(script.Parent.Flipbook);
require(script.Parent.Events);
local PartConstants = require(script.Parent.PartConstants);
local Pool = require(script.Parent.Pool);
local NestedEmit = require(script.Parent.NestedEmit);
local DirectionVectors = PartConstants.DirectionVectors;
local shapeFunctions = PartConstants.shapeFunctions;

local function _findBasePartAncestor(p1) -- Line: 22
    local Parent = p1.Parent;

    while Parent do
        if Parent:IsA("BasePart") then
            return Parent;
        end;

        Parent = Parent.Parent;
    end;

    return nil;
end;

return function(u2) -- Line: 31
    -- upvalues: Range (copy), PartConstants (copy), DirectionVectors (copy), shapeFunctions (copy), AxisLinks (copy), Graph (copy), Pool (copy), Particles (copy), Flipbook (copy), NestedEmit (copy)
    function u2.EmitPart(p3, p4, p5, p6) -- Line: 37
        -- upvalues: Range (ref), PartConstants (ref), DirectionVectors (ref), shapeFunctions (ref), AxisLinks (ref), Graph (ref), Pool (ref), Particles (ref), u2 (copy), Flipbook (ref), NestedEmit (ref)
        if not (p4 and p4.Parent) then
            return;
        end;

        local Data = p3:GetData(p4);

        if not (Data and Data.RenderTemplate) then
            return;
        end;

        if p6 then
            if p6.LinkMode then
                Data.LinkMode = p6.LinkMode;
            end;

            if p6.EmitParent then
                Data.EmitParent = p6.EmitParent;
            end;
        end;

        local v7;

        if p6 and p6.IgnoreLink then
            v7 = nil;
        else
            v7 = p5 or Data.Link;
        end;

        local v8 = Range.RandomValueFromRange(Data.Lifetime);
        local v9 = v8 <= 0 and 0.001 or v8;
        local v10 = nil;

        if p6 then
            if p6.EventOriginResolver then
                v10 = p6.EventOriginResolver();
            end;

            v10 = v10 or p6.EventOriginCF;
        end;

        if v10 then
            if not (p6 and p6.UseFullOrigin) then
                v10 = CFrame.new(v10.Position) * p4.CFrame.Rotation;
            end;
        elseif v7 then
            local v11 = PartConstants.resolveLinkCFrame(v7);
            local Position = v11.Position;

            if Data.LinkMode == "Follow" then
                v10 = CFrame.new(Position) * p4.CFrame.Rotation;
            else
                v10 = CFrame.new(Position) * v11.Rotation * p4.CFrame.Rotation;
            end;
        else
            v10 = p4.CFrame;
        end;

        local v12 = DirectionVectors[Data.EmissionDirection] or DirectionVectors[Enum.NormalId.Top];
        local v13 = v10[v12.vector] * v12.multiplier;
        local Vector3_new_ret = Vector3.new();
        local v14 = nil;
        local v15;

        if Data.UseShape then
            local v16 = shapeFunctions[Data.ParticleData.Shape];

            if v16 then
                local v17;

                if Data.ShapePart then
                    v17 = Data.ShapePart.CFrame or v10;
                else
                    v17 = v10;
                end;

                local v18, v19, v20 = v16(Data.ShapePart or p4, Data.ParticleData);
                local ShapeInOut = Data.ParticleData.ShapeInOut;

                if ShapeInOut == Enum.ParticleEmitterShapeInOut.Inward then
                    v20 = -v20;
                elseif ShapeInOut == Enum.ParticleEmitterShapeInOut.InAndOut and math.random() < 0.5 then
                    v20 = -v20;
                end;

                v14 = (v17 - v17.Position):VectorToWorldSpace(v20);

                if Data.ParticleData.LookAtInitially then
                    local v21, v22, v23 = v10:ToEulerAnglesXYZ();
                    v15 = CFrame.new((v17 * CFrame.new(v18)).Position) * v19 * CFrame.Angles(v21, v22, v23);
                else
                    v15 = CFrame.new((v17 * CFrame.new(v18)).Position) * v10.Rotation;
                end;
            else
                v15 = CFrame.new((v10 * CFrame.new(Vector3_new_ret)).Position) * v10.Rotation;
            end;
        else
            v15 = CFrame.new((v10 * CFrame.new(Vector3_new_ret)).Position) * v10.Rotation;
        end;

        local v24 = Data.DirMode or "RigidLocal";
        local v25 = AxisLinks.sampleRangeAxes(Data, Data.AxisLinks, { "RotX", "RotY", "RotZ" }, Range, p6);
        local v26 = PartConstants.composeRotation(Data.RotOrder or "Global", v25.RotX, v25.RotY, v25.RotZ);
        local v27 = PartConstants.applyPositionOffset(v15 * v26, Data, v7, p4, Range, AxisLinks, p6);

        if v24 == "Global" then
            v27 = CFrame.new(v27.Position) * v26;
        end;

        if v14 then
            v13 = v14;
        elseif v24 == "Local" then
            v13 = v27[v12.vector] * v12.multiplier;
        elseif v24 == "Global" then
            v13 = CFrame.new()[v12.vector] * v12.multiplier;
        end;

        local v28, v29;

        if Data.ParticleData.SpreadAngle.X > 0 or Data.ParticleData.SpreadAngle.Y > 0 then
            v28 = (math.random() * 2 - 1) * Data.ParticleData.SpreadAngle.X;
            v29 = (math.random() * 2 - 1) * Data.ParticleData.SpreadAngle.Y;
        else
            v28 = 0;
            v29 = 0;
        end;

        local CFrame_Angles_ret = CFrame.Angles(math.rad(v28), math.rad(v29), 0);
        local LookVector = (CFrame.lookAt(Vector3.new(), v13) * CFrame_Angles_ret).LookVector;
        local v30 = {
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
        AxisLinks.applyGraphAxisAliases(Data, v30, Data.AxisLinks);
        local InvertMotion = Data.InvertMotion;
        local v31, v32;

        if InvertMotion then
            v31, v32 = p3:PreSimulateForward(Data, v30, v27, LookVector, CFrame_Angles_ret, v7, v9, nil, v27.Rotation * v26:Inverse());
        else
            v32 = nil;
            v31 = nil;
        end;

        local v33 = Pool.acquireOrCopyBare(Data.RenderTemplate, "Part", Data.Pool);
        v33.Archivable = false;
        local v34;

        if v7 then
            v34 = PartConstants.resolveLinkCFrame(v7);

            if Data.LinkMode == "Follow" or Data.LinkMode == "Pivot" then
                v34 = CFrame.new(v34.Position) or v34;
            end;
        else
            v34 = CFrame.new();
        end;

        if InvertMotion and v31 then
            v27 = v31[v32 or Data.TotalKeyFrames] or v31[0];
            v33.CFrame = v34 * v27;
        else
            if v7 then
                v27 = v34:ToObjectSpace(v27) or v27;
            end;

            v33.CFrame = v34 * v27;
        end;

        local u35 = {
            Type = "Part",
            VisualPart = v33,
            Link = v7,
            LinkMode = Data.LinkMode,
            Events = Data.Events,
            SpecialMesh = v33:FindFirstChildOfClass("SpecialMesh"),
            Decal = v33:FindFirstChildOfClass("Decal"),
            SurfaceAppearance = v33:FindFirstChildOfClass("SurfaceAppearance"),
            StartTime = os.clock(),
            TotalKeyFrames = InvertMotion and v32 and v32 or math.max(1, Data.TotalKeyFrames),
            CurrentStep = 0,
            AccumulatedDT = 0,
            LifeTime = v9,
            PartLife = Data.PartLife,
            CurrentPosition = v33.Position,
            LocalCF = v27,
            BaseDirection = LookVector,
            _accelVel = Vector3.new(0, 0, 0),
            SpeedMultiplier = 1,
            _spinRate = Vector3.new(0, 0, 0),
            _spinAccumX = 0,
            _spinAccumY = 0,
            _spinAccumZ = 0,
            EmissionDirection = Data.EmissionDirection,
            SpreadRotation = CFrame_Angles_ret,
            Acceleration = Data.ParticleData.Acceleration,
            Drag = Data.ParticleData.Drag,
            VelocityVectored = Data.VelocityVectored,
            InvertMotion = InvertMotion,
            SimLocalCFrames = v31,
            RotMode = Data.RotMode or "OverLife",
            RotOrder = Data.RotOrder or "Global",
            AccRotX = 0,
            AccRotY = 0,
            AccRotZ = 0,
            Orientation = Data.Orientation,
            ZOffset = Data.ZOffset,
            _localWorldCF = v27,
            SpawnRotation = v27.Rotation,
            SpawnEmitterRotation = v27.Rotation * v26:Inverse(),
            DisplacementMode = Data.DisplacementMode,
            _sleepRadius = v33 and v33:IsA("BasePart") and (v33.Size.Magnitude * 0.5 or 1) or 1,
            _prevWorldOff = Vector3.new(0, 0, 0),
            HasPosOffsetGraphs = (Data.PosOffsetX ~= nil or Data.PosOffsetY ~= nil) and true or Data.PosOffsetZ ~= nil
        };
        local v36;

        if Data.AccelerationTowardsInstance == true and (Data.AccelTarget ~= nil and Data.AccelStrength ~= nil) then
            v36 = not Data.InvertMotion;
        else
            v36 = false;
        end;

        u35.HasTargetAccel = v36;
        u35.AccelTarget = Data.AccelTarget;
        u35.TargetVel = Vector3.new(0, 0, 0);
        u35.NeedsFullIteration = Data.VelocityVectored;
        local v37;

        if Data.RotMode == "Speed" then
            v37 = not Data.VelocityVectored;
        else
            v37 = false;
        end;

        u35.NeedsRotAccum = v37;
        u35.HasDrag = Data.ParticleData.Drag ~= 0;
        u35.HasAccel = Data.ParticleData.Acceleration.Magnitude > 0;
        u35.HasDecal = v33:FindFirstChildOfClass("Decal") ~= nil;
        u35.Graphs = {
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
        u35.Seeds = v30;
        u35._effectiveElapsed = Graph.InitialEffectiveElapsed(Data.Timescale, v30.Timescale, v9);

        if u35.HasPosOffsetGraphs then
            local v38 = u35.Graphs.PosOffsetX and (Graph.QueryPointsWithTime(0, u35.Graphs.PosOffsetX, u35.Seeds.PosOffsetX) or 0) or 0;
            local v39 = u35.Graphs.PosOffsetY and (Graph.QueryPointsWithTime(0, u35.Graphs.PosOffsetY, u35.Seeds.PosOffsetY) or 0) or 0;
            local v40 = u35.Graphs.PosOffsetZ and (Graph.QueryPointsWithTime(0, u35.Graphs.PosOffsetZ, u35.Seeds.PosOffsetZ) or 0) or 0;
            local v41 = PartConstants.resolveDisplacement(Vector3.new(v38, v39, v40), Data.DisplacementMode or "Global", u35.SpawnRotation, u35.SpawnEmitterRotation);
            u35._prevWorldOff = v41;

            if v38 ~= 0 or (v39 ~= 0 or v40 ~= 0) then
                u35.LocalCF = u35.LocalCF + v41;
                u35.VisualPart.CFrame = u35.VisualPart.CFrame + v41;
            end;
        end;

        local v42 = Graph.QueryPointsWithTime(0, u35.Graphs.SizeX, u35.Seeds.SizeX);
        local v43 = Graph.QueryPointsWithTime(0, u35.Graphs.SizeY, u35.Seeds.SizeY);
        local Vector3_new_ret2 = Vector3.new(v42, v43, Graph.QueryPointsWithTime(0, u35.Graphs.SizeZ, u35.Seeds.SizeZ));
        local v44 = Graph.QueryPointsWithTime(0, u35.Graphs.Transparency, u35.Seeds.Transparency);
        local u45 = Graph.QueryColorPointWithTime(0, u35.Graphs.Color);
        local u46 = Graph.QueryPointsWithTime(0, u35.Graphs.Brightness, u35.Seeds.Brightness);

        if u35.SpecialMesh then
            u35.SpecialMesh.Scale = Vector3_new_ret2;
        else
            u35.VisualPart.Size = Vector3_new_ret2;
        end;

        if u35.SurfaceAppearance then
            u35.VisualPart.Transparency = v44;
            u35.VisualPart.Color = Color3.fromRGB(u45.R * 255, u45.G * 255, u45.B * 255);
            u35.SurfaceAppearance.Color = Color3.fromRGB(u45.R * 255, u45.G * 255, u45.B * 255);
            pcall(function() -- Line: 316
                -- upvalues: u35 (copy), u45 (copy), u46 (copy)
                u35.SurfaceAppearance.EmissiveTint = Color3.new(u45.R * u46, u45.G * u46, u45.B * u46);
            end);
        elseif u35.Decal then
            u35.Decal.Transparency = v44;
            u35.Decal.Color3 = Color3.fromRGB(u45.R * 255 * u46, u45.G * 255 * u46, u45.B * 255 * u46);
        else
            u35.VisualPart.Transparency = v44;
            u35.VisualPart.Color = Color3.fromRGB(u45.R * 255, u45.G * 255, u45.B * 255);
        end;

        for _, descendant in v33:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        v33.Parent = Data.EmitParent or p3:GetFolder();

        for _, descendant in v33:GetDescendants() do
            if descendant:IsA("Trail") and not descendant:GetAttribute("Transformed") then
                local Parent = descendant.Parent;
                local v47 = descendant;
                local v48 = false;

                while Parent and Parent ~= v33 do
                    if Parent:GetAttribute("Transformed") then
                        v48 = true;
                        break;
                    end;

                    Parent = Parent.Parent;
                end;

                if not v48 and v47:GetAttribute("EmitDuration") ~= nil then
                    if v47.Enabled ~= true then
                        v47.Enabled = true;
                    end;

                    if v47:GetAttribute("_pooledTrailEnabled") ~= nil then
                        v47:SetAttribute("_pooledTrailEnabled", true);
                    end;
                end;
            end;
        end;

        Pool.restoreTrails(v33, "Part");
        local v49 = p3:_makeAliveCheck();

        for _, child in v33:GetChildren() do
            if child:IsA("Attachment") then
                Particles.EnableEmitChildrenAndRepeatForAttachments(child, v49);
            end;

            Particles.EnableEmitSingle(child, v49);
        end;

        if p3._parentScaleMap and p3._parentScaleMap[p4] then
            u35.ParentScale = p3._parentScaleMap[p4];
        end;

        u35._sourceItem = p4;
        u2._seedTsOverride(u35, p4);

        if Data.Pool ~= false then
            u35._sourceRT = Data.RenderTemplate;
            u35._poolKind = "Part";
        end;

        p3:_applyEmitVisualPasses(u35);
        p3:_registerEmit(u35, p6);

        if Data.CachedMeshTextures and #Data.CachedMeshTextures > 0 then
            local v50 = u35.SurfaceAppearance or u35.Decal;

            if not v50 then
                if v33:IsA("MeshPart") then
                    v50 = v33;
                end;
            end;

            if v50 then
                Flipbook.Flip(u35, Data.ParticleData, Data.CachedMeshTextures, v50, v9);
            end;
        end;

        u35._nestedAlive = { true };
        NestedEmit.walk(p3, Data.RenderTemplate, v33, u35._nestedAlive, p6);
    end;

    function u2.EmitAttachment(p51, p52, p53, p54) -- Line: 397
        -- upvalues: Range (ref), PartConstants (ref), DirectionVectors (ref), AxisLinks (ref), Graph (ref), Pool (ref), u2 (copy), Particles (ref), NestedEmit (ref)
        if not (p52 and p52.Parent) then
            return;
        end;

        local Data = p51:GetData(p52);

        if not (Data and Data.RenderTemplate) then
            return;
        end;

        if p54 then
            if p54.LinkMode then
                Data.LinkMode = p54.LinkMode;
            end;

            if p54.EmitParent then
                Data.EmitParent = p54.EmitParent;
            end;
        end;

        local v55;

        if p54 and p54.IgnoreLink then
            v55 = nil;
        else
            v55 = p53 or Data.Link;
        end;

        local v56 = Range.RandomValueFromRange(Data.Lifetime);
        local v57 = v56 <= 0 and 0.001 or v56;
        local WorldCFrame = p52.WorldCFrame;
        local v58 = nil;

        if p54 then
            if p54.EventOriginResolver then
                v58 = p54.EventOriginResolver();
            end;

            v58 = v58 or p54.EventOriginCF;
        end;

        if v58 then
            if not (p54 and p54.UseFullOrigin) then
                v58 = CFrame.new(v58.Position) * WorldCFrame.Rotation;
            end;
        elseif v55 then
            local v59 = PartConstants.resolveLinkCFrame(v55);

            if Data.LinkMode == "Follow" then
                v58 = CFrame.new(v59.Position) * WorldCFrame.Rotation;
            else
                v58 = CFrame.new(v59.Position) * v59.Rotation * WorldCFrame.Rotation;
            end;
        else
            v58 = WorldCFrame;
        end;

        local EmitParent = Data.EmitParent;

        if not EmitParent then
            EmitParent = p52.Parent;

            while true do
                if not EmitParent then
                    EmitParent = nil;
                    break;
                end;

                if EmitParent:IsA("BasePart") then
                    break;
                end;

                EmitParent = EmitParent.Parent;
            end;

            if not EmitParent then
                EmitParent = p51:GetFolder();
            end;
        end;

        local v60 = EmitParent and EmitParent:IsA("BasePart") and EmitParent.CFrame or CFrame.new();
        local v61 = v60:ToObjectSpace(v58);
        local v62 = DirectionVectors[Data.EmissionDirection] or DirectionVectors[Enum.NormalId.Top];
        local v63 = Data.DirMode or "RigidLocal";
        local v64 = AxisLinks.sampleRangeAxes(Data, Data.AxisLinks, { "RotX", "RotY", "RotZ" }, Range, p54);
        local v65 = PartConstants.composeRotation(Data.RotOrder or "Global", v64.RotX, v64.RotY, v64.RotZ);
        local v66 = v61 * v65;
        local v67;

        if v63 == "Local" then
            v67 = v66[v62.vector] * v62.multiplier;
        elseif v63 == "Global" then
            v67 = CFrame.new()[v62.vector] * v62.multiplier;

            if EmitParent and EmitParent:IsA("BasePart") then
                v67 = EmitParent.CFrame:VectorToObjectSpace(v67);
            end;
        else
            v67 = v61[v62.vector] * v62.multiplier;
        end;

        local v68 = PartConstants.applyPositionOffset(v66, Data, v55, p52, Range, AxisLinks, p54, v60);

        if v63 == "Global" then
            if EmitParent and EmitParent:IsA("BasePart") then
                v68 = CFrame.new(v68.Position) * EmitParent.CFrame.Rotation:Inverse() * v65;
            else
                v68 = CFrame.new(v68.Position) * v65;
            end;
        end;

        local v69, v70;

        if Data.ParticleData.SpreadAngle.X > 0 or Data.ParticleData.SpreadAngle.Y > 0 then
            v69 = (math.random() * 2 - 1) * Data.ParticleData.SpreadAngle.X;
            v70 = (math.random() * 2 - 1) * Data.ParticleData.SpreadAngle.Y;
        else
            v69 = 0;
            v70 = 0;
        end;

        local CFrame_Angles_ret = CFrame.Angles(math.rad(v69), math.rad(v70), 0);
        local LookVector = (CFrame.lookAt(Vector3.new(), v67) * CFrame_Angles_ret).LookVector;
        local v71 = {
            Speed = Graph.GenerateSeed(Data.Speed),
            RotSpeedX = Graph.GenerateSeed(Data.RotSpeedX),
            RotSpeedY = Graph.GenerateSeed(Data.RotSpeedY),
            RotSpeedZ = Graph.GenerateSeed(Data.RotSpeedZ),
            PosOffsetX = Graph.GenerateSeed(Data.PosOffsetX),
            PosOffsetY = Graph.GenerateSeed(Data.PosOffsetY),
            PosOffsetZ = Graph.GenerateSeed(Data.PosOffsetZ),
            Timescale = Graph.GenerateSeed(Data.Timescale)
        };
        AxisLinks.applyGraphAxisAliases(Data, v71, Data.AxisLinks);
        local InvertMotion = Data.InvertMotion;
        local v72, v73;

        if InvertMotion then
            v72, v73 = p51:PreSimulateAttachmentForward(Data, v71, v68, LookVector, CFrame_Angles_ret, v57, nil, v68.Rotation * v65:Inverse());
        else
            v72 = nil;
            v73 = nil;
        end;

        local v74 = Pool.acquireOrCopyBare(Data.RenderTemplate, "Attachment", Data.Pool);
        v74.Archivable = false;

        if InvertMotion and v72 then
            v68 = v72[v73 or Data.TotalKeyFrames] or v72[0];
        end;

        v74.CFrame = v68;
        v74.Parent = EmitParent;
        Pool.restoreTrails(v74, "Attachment");

        if v55 then
            local v75 = PartConstants.resolveLinkCFrame(v55);
            local v76 = (EmitParent and (EmitParent:IsA("BasePart") and EmitParent.CFrame) or CFrame.new()):ToObjectSpace(v75);

            if Data.LinkMode == "Follow" or Data.LinkMode == "Pivot" then
                v76 = CFrame.new(v76.Position);
            end;

            v68 = v76:ToObjectSpace(v68);
        end;

        local v77 = {
            Type = "Attachment",
            VisualPart = v74,
            Link = v55,
            LinkMode = Data.LinkMode,
            Events = Data.Events,
            StartTime = os.clock(),
            TotalKeyFrames = InvertMotion and v73 and v73 or math.max(1, Data.TotalKeyFrames),
            CurrentStep = 0,
            AccumulatedDT = 0,
            LifeTime = v57,
            PartLife = Data.PartLife,
            LocalCF = v68,
            _localWorldCF = v68,
            BaseDirection = LookVector,
            _accelVel = Vector3.new(0, 0, 0),
            SpeedMultiplier = 1,
            _spinRate = Vector3.new(0, 0, 0),
            _spinAccumX = 0,
            _spinAccumY = 0,
            _spinAccumZ = 0,
            EmissionDirection = Data.EmissionDirection,
            SpreadRotation = CFrame_Angles_ret,
            Acceleration = Data.ParticleData.Acceleration,
            Drag = Data.ParticleData.Drag,
            VelocityVectored = Data.VelocityVectored,
            InvertMotion = InvertMotion,
            SimLocalCFrames = v72,
            RotMode = Data.RotMode or "OverLife",
            RotOrder = Data.RotOrder or "Global",
            AccRotX = 0,
            AccRotY = 0,
            AccRotZ = 0,
            Orientation = Data.Orientation,
            ZOffset = Data.ZOffset,
            SpawnRotation = v68.Rotation,
            SpawnEmitterRotation = v68.Rotation * v65:Inverse(),
            DisplacementMode = Data.DisplacementMode,
            _sleepRadius = 1,
            _prevWorldOff = Vector3.new(0, 0, 0),
            HasPosOffsetGraphs = (Data.PosOffsetX ~= nil or Data.PosOffsetY ~= nil) and true or Data.PosOffsetZ ~= nil,
            NeedsFullIteration = Data.VelocityVectored
        };
        local v78;

        if Data.RotMode == "Speed" then
            v78 = not Data.VelocityVectored;
        else
            v78 = false;
        end;

        v77.NeedsRotAccum = v78;
        v77.HasDrag = Data.ParticleData.Drag ~= 0;
        v77.HasAccel = Data.ParticleData.Acceleration.Magnitude > 0;
        v77.Graphs = {
            Speed = Data.Speed,
            RotSpeedX = Data.RotSpeedX,
            RotSpeedY = Data.RotSpeedY,
            RotSpeedZ = Data.RotSpeedZ,
            PosOffsetX = Data.PosOffsetX,
            PosOffsetY = Data.PosOffsetY,
            PosOffsetZ = Data.PosOffsetZ,
            Timescale = Data.Timescale
        };
        v77.Seeds = v71;
        v77._effectiveElapsed = Graph.InitialEffectiveElapsed(Data.Timescale, v71.Timescale, v57);

        if v77.HasPosOffsetGraphs then
            local v79 = v77.Graphs.PosOffsetX and (Graph.QueryPointsWithTime(0, v77.Graphs.PosOffsetX, v77.Seeds.PosOffsetX) or 0) or 0;
            local v80 = v77.Graphs.PosOffsetY and (Graph.QueryPointsWithTime(0, v77.Graphs.PosOffsetY, v77.Seeds.PosOffsetY) or 0) or 0;
            local v81 = v77.Graphs.PosOffsetZ and (Graph.QueryPointsWithTime(0, v77.Graphs.PosOffsetZ, v77.Seeds.PosOffsetZ) or 0) or 0;
            local v82 = PartConstants.resolveDisplacement(Vector3.new(v79, v80, v81), Data.DisplacementMode or "Global", v77.SpawnRotation, v77.SpawnEmitterRotation);
            v77._prevWorldOff = v82;

            if v79 ~= 0 or (v80 ~= 0 or v81 ~= 0) then
                v77.LocalCF = v77.LocalCF + v82;
                v77.VisualPart.CFrame = v77.VisualPart.CFrame + v82;
            end;
        end;

        v77._sourceItem = p52;
        u2._seedTsOverride(v77, p52);

        if Data.Pool ~= false then
            v77._sourceRT = Data.RenderTemplate;
            v77._poolKind = "Attachment";
        end;

        p51:_applyEmitVisualPasses(v77);
        p51:_registerEmit(v77, p54);

        for _, descendant in v74:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        local v83 = p51:_makeAliveCheck();

        for _, child in v74:GetChildren() do
            if child:IsA("Attachment") then
                Particles.EnableEmitChildrenAndRepeatForAttachments(child, v83);
            end;

            Particles.EnableEmitSingle(child, v83);
        end;

        v77._nestedAlive = { true };
        NestedEmit.walk(p51, Data.RenderTemplate, v74, v77._nestedAlive, p54);
    end;

    function u2.EmitBeam(p84, p85, p86, p87) -- Line: 650
        -- upvalues: Pool (ref), Graph (ref), Range (ref), u2 (copy), Flipbook (ref)
        if not (p85 and p85.Parent) then
            return;
        end;

        local Data = p84:GetData(p85);

        if not (Data and Data.RenderTemplate) then
            return;
        end;

        local v88 = Pool.acquireOrClone(Data.RenderTemplate, "Beam", Data.Pool);
        v88.Archivable = false;
        v88.Enabled = true;

        if Data.FaceCamera ~= nil then
            v88.FaceCamera = Data.FaceCamera;
        end;

        if Data.ZOffset ~= nil then
            v88.ZOffset = Data.ZOffset;
        end;

        if Data.TextureMode ~= nil then
            v88.TextureMode = Data.TextureMode;
        end;

        if p87 and p87._parentCloneMap then
            local _parentCloneMap = p87._parentCloneMap;

            if v88.Attachment0 and _parentCloneMap[v88.Attachment0] then
                v88.Attachment0 = _parentCloneMap[v88.Attachment0];
            end;

            if v88.Attachment1 and _parentCloneMap[v88.Attachment1] then
                v88.Attachment1 = _parentCloneMap[v88.Attachment1];
            end;
        end;

        local v89 = {};

        for i, v in pairs(Data.BeamProps) do
            if v then
                if Graph.IsStatic(v) then
                    v88[i] = Graph.GetStaticValue(v, v88[i]);
                else
                    local v90 = Graph.GenerateSeed(v);
                    v89[i] = {
                        Sequence = v,
                        Seed = v90
                    };

                    if i ~= "TextureSpeed" then
                        local v91 = Graph.QueryPointsWithTime(0, v, v90);

                        if i == "Segments" then
                            local math_round_ret = math.round(v91);
                            v91 = math.max(20, math_round_ret);
                        end;

                        v88[i] = v91;
                    end;
                end;
            end;
        end;

        if v89.TextureSpeed then
            v88.TextureSpeed = 0;
        end;

        local v92, v93 = Graph.CollectGraphStates(Data.GraphBlender);
        local v94 = {};

        for i = 1, #v92 - 1 do
            v94[i] = Graph.PrecomputeMergedTimes(v92[i].Graph, v92[i + 1].Graph);
            local _ = i;
        end;

        local v95 = {};

        for i = 1, #v93 - 1 do
            v95[i] = Graph.PrecomputeMergedColorTimes(v93[i].Graph, v93[i + 1].Graph);
            local _ = i;
        end;

        if #v92 > 0 then
            v88.Transparency = v92[1].Graph;
        end;

        if #v93 > 0 then
            v88.Color = v93[1].Graph;
        end;

        v88.Parent = Data.EmitParent or p84:GetFolder();
        local v96 = Range.RandomValueFromRange(Data.Lifetime);
        local v97 = v96 <= 0 and 0.001 or v96;
        local v98 = Graph.GenerateSeed(Data.BeamTimescale);
        local v99 = {
            Type = "Beam",
            CurrentStep = 0,
            VisualPart = v88,
            Link = p86,
            Events = Data.Events,
            StartTime = os.clock(),
            TotalKeyFrames = math.max(1, Data.TotalKeyFrames),
            LifeTime = v97,
            PartLife = Data.PartLife or 0,
            AnimatedProps = v89,
            TransStates = v92,
            ColorStates = v93,
            TransMergedTimes = v94,
            ColorMergedTimes = v95,
            Graphs = {
                Timescale = Data.BeamTimescale
            },
            Seeds = {
                Timescale = v98
            },
            _effectiveElapsed = Graph.InitialEffectiveElapsed(Data.BeamTimescale, v98, v97)
        };

        if p84._parentScaleMap and p84._parentScaleMap[p85] then
            v99.ParentScale = p84._parentScaleMap[p85];
            v99._baseWidth0 = v88.Width0;
            v99._baseWidth1 = v88.Width1;
            v99._baseCurveSize0 = v88.CurveSize0;
            v99._baseCurveSize1 = v88.CurveSize1;
            v99._baseTextureLength = v88.TextureLength;
            v99._baseSegments = v88.Segments;
        end;

        v99._sourceItem = p85;
        u2._seedTsOverride(v99, p85);

        if Data.Pool ~= false then
            v99._sourceRT = Data.RenderTemplate;
            v99._poolKind = "Beam";
        end;

        p84:_registerEmit(v99, p87);

        if Data.CachedBeamTextures and (#Data.CachedBeamTextures > 0 and Data.FlipbookParticle) then
            Flipbook.FlipBeam(v99, Data.FlipbookParticle, Data.CachedBeamTextures, v88, v97);
        end;
    end;
end;