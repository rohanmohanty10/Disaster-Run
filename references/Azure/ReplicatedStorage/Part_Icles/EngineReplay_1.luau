 
 

local Graph = require(script.Parent.Graph);
local Range = require(script.Parent.Range);
local PartConstants = require(script.Parent.PartConstants);
local LinkCF = require(script.Parent.LinkCF);
local Pool = require(script.Parent.Pool);
local StaticPass = require(script.Parent.StaticPass);
local AxisLinks = require(script.Parent.AxisLinks);
local NestedEmit = require(script.Parent.NestedEmit);
local Turbulence = require(script.Parent.Turbulence);
local DecalLayers = require(script.Parent.DecalLayers);
local MeshFrames = require(script.Parent.MeshFrames);
local AtRest = require(script.Parent.AtRest);

return function(p1) -- Line: 22
    -- upvalues: Graph (copy), PartConstants (copy), Turbulence (copy), Range (copy), Pool (copy), LinkCF (copy), StaticPass (copy), AxisLinks (copy), NestedEmit (copy), AtRest (copy), DecalLayers (copy), MeshFrames (copy)
    function p1._replayAnimateCycle(u2, u3, p4) -- Line: 26
        -- upvalues: Graph (ref), PartConstants (ref), Turbulence (ref), Range (ref), Pool (ref), LinkCF (ref), StaticPass (ref), AxisLinks (ref), NestedEmit (ref), AtRest (ref)
        u3.StartTime = p4;
        u3.CurrentStep = 0;

        if u3.AccumulatedDT then
            u3.AccumulatedDT = 0;
        end;

        if u3.InitialLocalCF then
            u3.LocalCF = u3.InitialLocalCF;
        end;

        if u3.AccRotX then
            u3.AccRotX = 0;
            u3.AccRotY = 0;
            u3.AccRotZ = 0;
        end;

        if u3.TargetVel then
            u3.TargetVel = Vector3.new(0, 0, 0);
        end;

        u3._collisionStopped = false;
        u3._spinRate = Vector3.new(0, 0, 0);
        u3._spinAccumX = 0;
        u3._spinAccumY = 0;
        u3._spinAccumZ = 0;
        u3.SpeedMultiplier = 1;

        if u3._accelVel then
            u3._accelVel = Vector3.new(0, 0, 0);
        end;

        u3._prevRawOff = nil;
        u3._turnX = nil;
        u3._turnY = nil;
        u3._turnZ = nil;

        if u3._prevWorldOff then
            u3._prevWorldOff = Vector3.new(0, 0, 0);
            u3._displacementMirrorX = nil;
            u3._displacementMirrorY = nil;
            u3._displacementMirrorZ = nil;

            if u3.HasPosOffsetGraphs and (u3.Graphs and u3.SpawnRotation) then
                local v5 = u3.Graphs.PosOffsetX and (Graph.QueryPointsWithTime(0, u3.Graphs.PosOffsetX, u3.Seeds.PosOffsetX) or 0) or 0;
                local v6 = u3.Graphs.PosOffsetY and (Graph.QueryPointsWithTime(0, u3.Graphs.PosOffsetY, u3.Seeds.PosOffsetY) or 0) or 0;
                local v7 = u3.Graphs.PosOffsetZ and (Graph.QueryPointsWithTime(0, u3.Graphs.PosOffsetZ, u3.Seeds.PosOffsetZ) or 0) or 0;

                if v5 ~= 0 or (v6 ~= 0 or v7 ~= 0) then
                    local u8 = PartConstants.resolveDisplacement(Vector3.new(v5, v6, v7), u3.DisplacementMode or "Global", u3.SpawnRotation, u3.SpawnEmitterRotation);
                    u3._prevWorldOff = u8;
                    u3.LocalCF = u3.LocalCF + u8;

                    if u3.VisualPart and u3.VisualPart.Parent then
                        if u3.Type == "Model" then
                            pcall(function() -- Line: 70
                                -- upvalues: u3 (copy), u8 (copy)
                                u3.VisualPart:PivotTo(u3.VisualPart:GetPivot() + u8);
                            end);
                        else
                            u3.VisualPart.CFrame = u3.VisualPart.CFrame + u8;
                        end;
                    end;
                end;
            end;
        end;

        Turbulence.reprime(u3);

        if u3._initialBaseDirection then
            u3.BaseDirection = u3._initialBaseDirection;
        end;

        u3._lastOrientPos = nil;
        local InitialLocalCF = u3.InitialLocalCF;
        u3._localWorldCF = u3.InitialLocalCF;
        u3._postUpdateCF = InitialLocalCF;
        u3._lastTransIdx = nil;
        u3._lastColorIdx = nil;
        u3._effectiveElapsed = Graph.InitialEffectiveElapsed(u3.Graphs and u3.Graphs.Timescale, u3.Seeds and u3.Seeds.Timescale, u3.LifeTime);
        u3._hitHistory = nil;

        if u3.Type == "ImageLabel" then
            u3.PosX = 0;
            u3.PosY = 0;
            u3.EnvVelX = 0;
            u3.EnvVelY = 0;
            u3.AccRot = 0;
        end;

        local EmitData = u2:GetEmitData(u3.AnimateItem, u3._playOverrides and ({
            Overrides = u3._playOverrides
        } or nil) or nil);

        if EmitData then
            u3.Events = EmitData.Events;
            u3._killedManually = false;
            u3._fireOnDeathOverride = false;
            u3._hitFired = false;
            u3.LifeTime = Range.RandomValueFromRange(EmitData.Lifetime);

            if u3.LifeTime <= 0 then
                u3.LifeTime = 0.001;
            end;

            u3.TotalKeyFrames = math.max(1, EmitData.TotalKeyFrames);

            if EmitData.ParticleData then
                u3.Acceleration = EmitData.ParticleData.Acceleration;
                u3.Drag = EmitData.ParticleData.Drag;
                u3.HasDrag = EmitData.ParticleData.Drag ~= 0;
                u3.HasAccel = EmitData.ParticleData.Acceleration.Magnitude > 0;
            end;

            u3.InvertMotion = EmitData.InvertMotion or false;
            u3.AccelTarget = EmitData.AccelTarget;
            local v9;

            if EmitData.AccelerationTowardsInstance == true and (EmitData.AccelTarget ~= nil and EmitData.AccelStrength ~= nil) then
                v9 = not u3.InvertMotion;
            else
                v9 = false;
            end;

            u3.HasTargetAccel = v9;
            u3.TargetVel = Vector3.new(0, 0, 0);

            if EmitData.VelocityVectored ~= nil then
                u3.VelocityVectored = EmitData.VelocityVectored;
            end;

            u3.NeedsFullIteration = u3.VelocityVectored or false;

            if EmitData.RotMode then
                u3.RotMode = EmitData.RotMode;
                local v10;

                if EmitData.RotMode == "Speed" then
                    v10 = not u3.VelocityVectored and true or false;
                else
                    v10 = false;
                end;

                u3.NeedsRotAccum = v10;
            end;

            if not u3._nestedDriven then
                u3.Link = u3._playLink or EmitData.Link;
                u3._frozenLinkCF = nil;
            end;

            u3.LinkMode = EmitData.LinkMode;
            u3.LinkAxes = EmitData.LinkAxes;
            u3._linkMaskRefCF = nil;

            if u3.Link then
                u3._linkGen = Pool.linkGen(u3.Link);
            end;

            LinkCF.captureEmitFrame(u3);

            if u3.Link and u3.Link.Parent then
                u3._rigidLocalParentCF = LinkCF.rigidWorldSnapshot(u3.LinkMode, u3.Link, u3._linkLocal, u3.LinkAxes, u3._linkMaskRefCF) or u3._rigidLocalParentCF;
            end;

            if u3.Type == "ImageLabel" then
                u2:_refreshImageLabelAnimateNonSpatial(u3, EmitData);
            elseif u3.Type == "Lightning" then
                u2:_refreshLightningAnimate(u3, EmitData);
            elseif u3.Type == "CameraShake" then
                u2:_refreshCameraShakeAnimate(u3, EmitData);
            elseif u3.Type == "Rocks" then
                u2:_refreshRocksAnimate(u3, EmitData);
            elseif u3.Type == "Rope" then
                u2:_refreshRopeAnimate(u3, EmitData);
            elseif u3.Type == "Distortion" then
                u2:_refreshDistortionAnimate(u3, EmitData);
            else
                u2:_refreshAnimateNonSpatial(u3, EmitData);
            end;

            StaticPass.restoreFromFreshData(u3, EmitData);
            AxisLinks.refreshLoopGraphsAndSeeds(u3, EmitData, Graph);

            if u3.Type == "Part" or (u3.Type == "Attachment" or u3.Type == "Model") then
                Turbulence.buildInto(u3, EmitData);
            end;

            StaticPass.apply(u3);

            if u3.Type == "ImageLabel" and (u3._staticSizeScaleX and u3._staticSizeScaleY) then
                u3._staticSizeScaleX = nil;
                u3._staticSizeScaleY = nil;
            end;

            u3._effectiveElapsed = Graph.InitialEffectiveElapsed(u3.Graphs and u3.Graphs.Timescale, u3.Seeds and u3.Seeds.Timescale, u3.LifeTime);

            if u3.Type == "Distortion" then
                u2:_reseedDistortionPhase(u3);
            end;

            if u3.Type == "ImageLabel" then
                u3.InvertMotion = EmitData.ImgInvertMotion or false;

                if u3.InvertMotion then
                    local v11, v12, v13, v14 = u2:_computeImageLabelEndState(EmitData, u3.DirX or 0, u3.DirY or 0, u3.LifeTime, u3.Seeds);
                    u3.PosX = v11;
                    u3.PosY = v12;
                    u3.EnvVelX = v13;
                    u3.EnvVelY = v14;
                    u3._effectiveElapsed = u3.LifeTime;
                    u3._invertDtSign = -1;
                else
                    u3._invertDtSign = nil;
                end;
            end;

            if u3.InvertMotion and (u3.AnimateItem and u3.AnimateItem.Parent) then
                local v15 = nil;
                local u16 = u3.Type == "Attachment";
                local u17;

                if u3.Type == "Model" then
                    local v18;
                    v18, u17 = pcall(function() -- Line: 215
                        -- upvalues: u3 (copy)
                        return u3.AnimateItem:GetPivot();
                    end);

                    if not v18 then
                        u17 = v15;
                    end;
                elseif u16 then
                    u17 = u3.AnimateItem.CFrame;
                elseif u3.AnimateItem:IsA("BasePart") then
                    u17 = u3.AnimateItem.CFrame;
                else
                    u17 = v15;
                end;

                if u17 then
                    local v19, v20, v21 = pcall(function() -- Line: 224
                        -- upvalues: u16 (copy), u2 (copy), EmitData (copy), u3 (copy), u17 (ref)
                        if u16 then
                            return u2:PreSimulateAttachmentForward(EmitData, u3.Seeds, u17, u3.BaseDirection, u3.SpreadRotation, u3.LifeTime, nil, u3.SpawnEmitterRotation);
                        end;

                        return u2:PreSimulateForward(EmitData, u3.Seeds, u17, u3.BaseDirection, u3.SpreadRotation, u3.Link, u3.LifeTime, nil, u3.SpawnEmitterRotation, u3._linkLocal);
                    end);

                    if v19 then
                        u3.SimLocalCFrames = v20;

                        if v21 then
                            u3.TotalKeyFrames = v21;
                        end;
                    end;
                end;
            elseif not u3.InvertMotion then
                u3.SimLocalCFrames = nil;
            end;

            if u3.Type == "Beam" and EmitData.BeamProps then
                local VisualPart = u3.VisualPart;
                local v22 = {};

                for i, v in pairs(EmitData.BeamProps) do
                    if v then
                        if Graph.IsStatic(v) then
                            if VisualPart then
                                VisualPart[i] = Graph.GetStaticValue(v, VisualPart[i]);
                            end;
                        else
                            v22[i] = {
                                Sequence = v,
                                Seed = Graph.GenerateSeed(v)
                            };
                        end;
                    end;
                end;

                u3.AnimatedProps = v22;

                if VisualPart then
                    u3._baseWidth0 = VisualPart.Width0;
                    u3._baseWidth1 = VisualPart.Width1;
                    u3._baseCurveSize0 = VisualPart.CurveSize0;
                    u3._baseCurveSize1 = VisualPart.CurveSize1;
                    u3._baseTextureLength = VisualPart.TextureLength;
                    u3._baseSegments = VisualPart.Segments;
                end;

                if v22.TextureSpeed and VisualPart then
                    VisualPart.TextureSpeed = 0;
                end;

                if EmitData.GraphBlender then
                    local v23, v24 = Graph.CollectGraphStates(EmitData.GraphBlender);
                    u3.TransStates = v23;
                    u3.ColorStates = v24;
                    local v25 = {};

                    for i = 1, #v23 - 1 do
                        v25[i] = Graph.PrecomputeMergedTimes(v23[i].Graph, v23[i + 1].Graph);
                        local _ = i;
                    end;

                    local v26 = {};

                    for i = 1, #v24 - 1 do
                        v26[i] = Graph.PrecomputeMergedColorTimes(v24[i].Graph, v24[i + 1].Graph);
                        local _ = i;
                    end;

                    u3.TransMergedTimes = v25;
                    u3.ColorMergedTimes = v26;

                    if #v23 > 0 and VisualPart then
                        VisualPart.Transparency = v23[1].Graph;
                    end;

                    if #v24 > 0 and VisualPart then
                        VisualPart.Color = v24[1].Graph;
                    end;
                end;
            end;

            if EmitData.PLRange then
                u3.PLRange = EmitData.PLRange;
            end;

            if EmitData.PLBrightness then
                u3.PLBrightness = EmitData.PLBrightness;
            end;

            if EmitData.PLColor then
                u3.PLColor = EmitData.PLColor;
            end;
        end;

        if u3.Type ~= "Lightning" and (u3.Type ~= "Rocks" and (u3.Type ~= "CameraShake" and (u3.Type ~= "Rope" and (u3.Type ~= "Distortion" and (u3.AnimateItem and (u3.AnimateItem.Parent and (u3.VisualPart and u3.VisualPart.Parent))))))) then
            if u3.Type == "Model" then
                local success, result = pcall(function() -- Line: 285
                    -- upvalues: u3 (copy)
                    return u3.AnimateItem:GetPivot();
                end);

                if success and result then
                    u3.VisualPart:PivotTo(result);
                end;
            elseif u3.AnimateItem:IsA("BasePart") then
                u3.VisualPart.CFrame = u3.AnimateItem.CFrame;
            elseif u3.AnimateItem:IsA("Attachment") then
                u3.VisualPart.CFrame = CFrame.new();
            end;
        end;

        if u3.AnimateItem and (u3.VisualPart and u3.VisualPart.Parent) then
            local v27 = {
                ChainCtx = u3.EventChainCtx,
                _playToken = u3._playToken
            };

            if u3.Type == "Lightning" or (u3.Type == "Rocks" or u3.Type == "Rope") then
                local Data = u2:GetData(u3.AnimateItem);

                if Data and Data.RenderTemplate then
                    NestedEmit.walk(u2, Data.RenderTemplate, u3.VisualPart, u3._nestedAlive, v27, u3._scaleNode or u3.ParentScale);
                end;
            elseif u3.Type == "Part" or (u3.Type == "Attachment" or u3.Type == "Model") then
                AtRest.wake(u3.VisualPart);
                NestedEmit.walk(u2, u3.VisualPart, u3.VisualPart, u3._nestedAlive, v27, u3._scaleNode or u3.ParentScale);
            end;
        end;

        u2:_fireAnimateCycleRestartEvents(u3);
    end;

    function p1._refreshAnimateNonSpatial(p28, p29, p30) -- Line: 321
        -- upvalues: DecalLayers (ref), MeshFrames (ref), Graph (ref)
        if not p30 then
            return;
        end;

        if p30.EmissionDirection then
            p29.EmissionDirection = p30.EmissionDirection;
        end;

        if p30.Orientation then
            p29.Orientation = p30.Orientation;
        end;

        if p30.ZOffset ~= nil then
            p29.ZOffset = p30.ZOffset;
        end;

        if p30.RotOrder then
            p29.RotOrder = p30.RotOrder;
        end;

        if p30.PartLife ~= nil then
            p29.PartLife = p30.PartLife;
        end;

        DecalLayers.refresh(p29, p30);
        MeshFrames.refresh(p29, p30);
        local v31 = p30.Timescale or p30.BeamTimescale or (p30.AtmTimescale or p30.PLTimescale);

        if v31 and p29.Graphs then
            p29.Graphs.Timescale = v31;
            p29.Seeds.Timescale = Graph.GenerateSeed(v31);
        end;

        if p30.ParticleData and p30.ParticleData.SpreadAngle then
            local SpreadAngle = p30.ParticleData.SpreadAngle;
            local v32, v33;

            if SpreadAngle.X > 0 or SpreadAngle.Y > 0 then
                v32 = (math.random() * 2 - 1) * SpreadAngle.X;
                v33 = (math.random() * 2 - 1) * SpreadAngle.Y;
            else
                v32 = 0;
                v33 = 0;
            end;

            p29.SpreadRotation = CFrame.Angles(math.rad(v32), math.rad(v33), 0);
        end;
    end;
end;