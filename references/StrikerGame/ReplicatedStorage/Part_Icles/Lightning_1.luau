 
 

local Graph = require(script.Parent.Graph);
local Range = require(script.Parent.Range);
local Pool = require(script.Parent.Pool);
local PartConstants = require(script.Parent.PartConstants);
local AxisLinks = require(script.Parent.AxisLinks);
local NestedEmit = require(script.Parent.NestedEmit);
local Particles = require(script.Parent.Particles);
local Turbulence = require(script.Parent.Turbulence);
local Events = require(script.Parent.Events);
local script_BoltGen = require(script.BoltGen);
local DirectionVectors = PartConstants.DirectionVectors;
local script_Rig = require(script.Rig);
local buildRig = script_Rig.buildRig;
local acquireBolt = script_Rig.acquireBolt;
local layoutFor = script_Rig.layoutFor;
local flushCFrames = script_Rig.flushCFrames;
local FAR_CFRAME = script_Rig.FAR_CFRAME;
local u1 = -1;
local u2 = 0;
local u3 = false;
local u4 = 0;

return function(u5) -- Line: 52
    -- upvalues: script_BoltGen (copy), FAR_CFRAME (copy), script_Rig (copy), Graph (copy), flushCFrames (copy), Events (copy), Range (copy), acquireBolt (copy), u2 (ref), Pool (copy), Particles (copy), NestedEmit (copy), buildRig (copy), u1 (ref), u3 (ref), u4 (ref), Turbulence (copy), DirectionVectors (copy), AxisLinks (copy), PartConstants (copy), layoutFor (copy)
    function u5._isLightning(p6) -- Line: 55
        local v7 = p6:IsA("BasePart") and p6:GetAttribute("IsLightning") == true;

        return v7;
    end;

    local script_Endpoints = require(script.Endpoints);
    local script_ImpactDisk = require(script.ImpactDisk);
    local sampleShape = script_Endpoints.sampleShape;
    local resolveEndpoints = script_Endpoints.resolveEndpoints;

    local function writeSizes(p8, p9, p10) -- Line: 69
        -- upvalues: script_BoltGen (ref)
        for i = 1, script_BoltGen.planSizes(p8, p9, p10) do
            local v11 = p8.sizeWriteIdx[i];
            local math_max_ret = math.max(0.05, p9 * p8.widthScale[v11] * p8.taper[v11]);
            p8.parts[v11].Size = Vector3.new(math_max_ret, math_max_ret, p8.segLen[v11]);
            local _ = i;
        end;
    end;

    local function applyRoll(u12, p13) -- Line: 79
        -- upvalues: resolveEndpoints (copy), script_BoltGen (ref), FAR_CFRAME (ref), script_Rig (ref), Graph (ref), writeSizes (copy), flushCFrames (ref), script_ImpactDisk (copy)
        local _rig = u12._rig;
        local u14, u15, v16 = resolveEndpoints(u12);
        u12._totalLen = script_BoltGen.roll(_rig, u12, u15, v16, FAR_CFRAME);

        if u12._shapeMode ~= "Jitter" then
            script_BoltGen.applyScroll(_rig, u12, u12._scrollPhase or 0);
            script_BoltGen.applyScrollForks(_rig, u12, u12._scrollPhase or 0);
        end;

        script_Rig.applyTaper(_rig, u12.Graphs.ThicknessProfile, u12.Seeds.ThicknessProfile, u12._totalLen);
        local v17 = script_BoltGen.diffLive(_rig);
        local Gradient = u12.Graphs.Gradient;

        if not p13 and v17 > 0 then
            local _curTrans = u12._curTrans;
            local v18;

            if Gradient then
                v18 = nil;
            else
                v18 = u12._curColor or nil;
            end;

            for i = 1, v17 do
                local v19 = _rig.newlyLiveIdx[i];
                local v20 = _rig.parts[v19];

                if _curTrans then
                    v20.Transparency = _curTrans;
                end;

                if v18 then
                    v20.Color = v18;
                end;

                local v21 = _rig.decals[v19];
                local v22;

                if v21 then
                    if _curTrans then
                        v21.Transparency = _curTrans;
                    end;

                    if v18 then
                        v21.Color3 = v18;
                        v22 = i;
                    else
                        v22 = i;
                    end;
                else
                    v22 = i;
                end;
            end;
        end;

        if Gradient and not u12.SkipColor then
            local v23 = 1 / math.max(_rig.maxReveal or 0, 0.0001);
            local _curTint = u12._curTint;

            for i = 1, _rig.partCount do
                local v24;

                if _rig.prevLive[i] then
                    local math_clamp_ret = math.clamp((_rig.revealDist[i] + _rig.segLen[i] * 0.5) * v23, 0, 1);
                    local v25 = Graph.QueryColorPointWithTime(math_clamp_ret, Gradient);
                    _rig.gradColor[i] = v25;

                    if p13 then
                        v24 = i;
                    else
                        if _curTint then
                            v25 = Color3.new(math.min(v25.R * _curTint.R, 1), math.min(v25.G * _curTint.G, 1), (math.min(v25.B * _curTint.B, 1))) or v25;
                        end;

                        _rig.parts[i].Color = v25;
                        local v26 = _rig.decals[i];

                        if v26 then
                            v26.Color3 = v25;
                            v24 = i;
                        else
                            v24 = i;
                        end;
                    end;
                else
                    v24 = i;
                end;
            end;
        end;

        writeSizes(_rig, u12._curThick or 0.15, p13);
        pcall(function() -- Line: 132
            -- upvalues: u12 (copy), u15 (copy), u14 (copy)
            u12.VisualPart.WorldPivot = CFrame.new(u15) * u14.Rotation;
        end);
        flushCFrames(u12, p13);

        if u12._impactDisk then
            script_ImpactDisk.place(u12, u15, v16);
        end;
    end;

    local function writeVisuals(p27, p28) -- Line: 140
        -- upvalues: Graph (ref), writeSizes (copy), script_ImpactDisk (copy)
        local Graphs = p27.Graphs;
        local Seeds = p27.Seeds;
        local v29 = Graphs.Transparency and (Graph.QueryPointsWithTime(p28, Graphs.Transparency, Seeds.Transparency) or 0) or 0;

        if p27.SkipTransparency then
            v29 = p27._curTrans or v29;
        end;

        local v30 = Graphs.Brightness and (Graph.QueryPointsWithTime(p28, Graphs.Brightness, Seeds.Brightness) or 1) or 1;
        local v31;

        if Graphs.Color and not p27.SkipColor then
            local v32 = Graph.QueryColorPointWithTime(p28, Graphs.Color);
            v31 = Color3.new(math.min(v32.R * v30, 1), math.min(v32.G * v30, 1), (math.min(v32.B * v30, 1)));
        else
            v31 = nil;
        end;

        local v33 = Graphs.Thickness and Graph.QueryPointsWithTime(p28, Graphs.Thickness, Seeds.Thickness);
        local _rig = p27._rig;
        local v34;

        if v33 then
            v34 = v33 ~= p27._curThick;
        else
            v34 = v33;
        end;

        if v33 then
            p27._curThick = v33;
        end;

        p27._curTrans = v29;
        p27._curBright = v30;

        if v31 then
            p27._curColor = v31;
            p27._curTint = v31;
        end;

        local Gradient = Graphs.Gradient;

        for i = 1, _rig.partCount do
            local v35;

            if _rig.prevLive[i] then
                local v36 = _rig.parts[i];
                v36.Transparency = v29;
                local v37 = _rig.decals[i];

                if v37 then
                    v37.Transparency = v29;
                end;

                if v31 then
                    local v38;

                    if Gradient then
                        local v39 = _rig.gradColor[i];

                        if v39 then
                            v38 = Color3.new(math.min(v39.R * v31.R, 1), math.min(v39.G * v31.G, 1), (math.min(v39.B * v31.B, 1)));
                        else
                            v38 = v31;
                        end;
                    else
                        v38 = v31;
                    end;

                    v36.Color = v38;

                    if v37 then
                        v37.Color3 = v38;
                        v35 = i;
                    else
                        v35 = i;
                    end;
                else
                    v35 = i;
                end;
            else
                v35 = i;
            end;
        end;

        if v34 then
            writeSizes(_rig, v33, false);
        end;

        if p27._impactDisk then
            script_ImpactDisk.write(p27, p28);
        end;
    end;

    local script_PDataBuilder = require(script.PDataBuilder);
    local build = script_PDataBuilder.build;

    local function buildSeekParams(u40, p41) -- Line: 193
        -- upvalues: Events (ref)
        if p41._endpointMode ~= "Seek" then
            return;
        end;

        local u42 = Events.makeHitParams(p41);
        u42.RespectCanCollide = true;
        pcall(function() -- Line: 197
            -- upvalues: u42 (copy), u40 (copy)
            u42:AddToFilter(u40:GetFolder());
            u42:AddToFilter(u40:GetPoolFolder());
        end);

        function p41._seekRayFn(p43, p44) -- Line: 201
            -- upvalues: u42 (copy)
            return workspace:Raycast(p43, p44, u42);
        end;
    end;

    local function fireSeekHit(p45, p46) -- Line: 209
        -- upvalues: script_Endpoints (copy), Events (ref)
        if not p46._seekNewHit then
            return;
        end;

        if not script_Endpoints.glideArrived(p46) then
            return;
        end;

        p46._seekNewHit = nil;

        if not (p46.Events and (p46.Events.OnHit and p46._seekHit)) then
            return;
        end;

        local _seekHit = p46._seekHit;
        local v47 = Events.makePayload(p45, p46, "OnHit", nil);
        v47.HitInstance = _seekHit.Instance;
        v47.Other = _seekHit.Instance;
        v47.HitPosition = _seekHit.Position;
        v47.HitNormal = _seekHit.Normal;
        Events.fire(p45, p46, "OnHit", p46.EventChainCtx, v47);
    end;

    function u5.EmitLightning(p48, p49, p50, p51) -- Line: 225
        -- upvalues: Range (ref), acquireBolt (ref), build (copy), u5 (copy), Graph (ref), buildSeekParams (copy), u2 (ref), applyRoll (copy), writeVisuals (copy), script_ImpactDisk (copy), Pool (ref), Particles (ref), NestedEmit (ref), fireSeekHit (copy)
        if not (p49 and p49.Parent) then
            return;
        end;

        local EmitData = p48:GetEmitData(p49, p51);

        if not (EmitData and EmitData.RenderTemplate) then
            return;
        end;

        local v52 = Range.RandomValueFromRange(EmitData.Lifetime);
        local v53, v54 = acquireBolt(EmitData);
        local v55 = build(p49, EmitData, v53, v54, v52 <= 0 and 0.001 or v52, p51);
        v55._parentLink = p50;
        p48:_matteCarry(p51, v55, v54.parts, "Spine", v54.mainSegs);

        if p51 then
            local v56;

            if p51.EventOriginResolver then
                v56 = p51.EventOriginResolver();
            else
                v56 = nil;
            end;

            local v57 = v56 or p51.EventOriginCF;

            if v57 then
                v55._startCFOverride = p51.UseFullOrigin and v57 and v57 or CFrame.new(v57.Position) * p49.CFrame.Rotation;
            end;
        end;

        u5._seedTsOverride(v55, p49);

        if EmitData.Pool ~= false then
            v55._sourceRT = EmitData.RenderTemplate;
            v55._poolKind = "Lightning";
        end;

        v55._curThick = EmitData.Thickness and (Graph.QueryPointsWithTime(0, EmitData.Thickness, v55.Seeds.Thickness) or 0.15) or 0.15;
        buildSeekParams(p48, v55);
        u2 = u2 + 1;
        applyRoll(v55, true);
        writeVisuals(v55, 0);
        v53.Parent = EmitData.EmitParent or p48:GetFolder();
        script_ImpactDisk.attach(p48, v55, EmitData);
        Pool.restoreTrails(v53, "Lightning");
        Particles.EnableEmit(v53, p48:_makeAliveCheck());
        p48:_registerEmit(v55, p51);
        NestedEmit.walk(p48, EmitData.RenderTemplate, v53, v55._nestedAlive, p51);
        fireSeekHit(p48, v55);
    end;

    function u5.EmitLightningAnimate(p58, p59, p60, p61) -- Line: 278
        -- upvalues: Range (ref), buildRig (ref), build (copy), u5 (copy), Graph (ref), buildSeekParams (copy), u2 (ref), applyRoll (copy), writeVisuals (copy), script_ImpactDisk (copy), Particles (ref), NestedEmit (ref), fireSeekHit (copy)
        if not (p59 and p59.Parent) then
            return;
        end;

        if p58.ActiveAnimates[p59] then
            return;
        end;

        local EmitData = p58:GetEmitData(p59, p61);

        if not (EmitData and EmitData.RenderTemplate) then
            return;
        end;

        local v62 = Range.RandomValueFromRange(EmitData.Lifetime);
        local v63, v64 = buildRig(EmitData);
        v63:SetAttribute("_PartIcleEmit", true);
        local v65 = build(p59, EmitData, v63, v64, v62 <= 0 and 0.001 or v62, p61);
        v65._parentLink = p60;
        v65.IsAnimate = true;
        v65.AnimateItem = p59;
        u5._seedTsOverride(v65, p59);
        v65._curThick = EmitData.Thickness and (Graph.QueryPointsWithTime(0, EmitData.Thickness, v65.Seeds.Thickness) or 0.15) or 0.15;
        buildSeekParams(p58, v65);
        u2 = u2 + 1;
        applyRoll(v65, true);
        writeVisuals(v65, 0);
        v63.Parent = EmitData.EmitParent or p58:GetFolder();
        script_ImpactDisk.attach(p58, v65, EmitData);
        Particles.EnableEmit(v63, p58:_makeAliveCheck());
        p58.ActiveAnimates[p59] = v65;
        p58:_registerEmit(v65, p61);
        NestedEmit.walk(p58, EmitData.RenderTemplate, v63, v65._nestedAlive, p61);
        fireSeekHit(p58, v65);
    end;

    function u5.UpdateLightning(p66, p67, p68, p69) -- Line: 315
        -- upvalues: Graph (ref), u1 (ref), u2 (ref), u3 (ref), u4 (ref), Turbulence (ref), applyRoll (copy), fireSeekHit (copy), script_Endpoints (copy), flushCFrames (ref), FAR_CFRAME (ref), script_BoltGen (ref), writeSizes (copy), writeVisuals (copy)
        local math_max_ret = math.max((p69 - p67.StartTime) / p67.LifeTime, 0);
        local math_min_ret = math.min(math_max_ret, 1);
        local v70;

        if p67._tsOverride == nil or p69 >= (p67._tsOverrideUntil or 0) then
            v70 = p67.Graphs.Timescale and (Graph.QueryPointsWithTime(math_min_ret, p67.Graphs.Timescale, p67.Seeds.Timescale) or 1) or 1;
        else
            v70 = p67._tsOverride;
        end;

        local v71 = p68 * v70;
        local LifeTime = p67.LifeTime;
        local v72 = p67._effectiveElapsed or 0;
        local v73 = v72 + (p67._timeFrozen and 0 or v71);
        local v74 = v73 < 0 and 0 or v73;

        if LifeTime < v74 then
            v74 = LifeTime;
        end;

        p67._effectiveElapsed = v74;
        local VisualPart = p67.VisualPart;

        if not (VisualPart and VisualPart.Parent) then
            return true;
        end;

        if p67.TotalKeyFrames <= 0 then
            return true;
        end;

        local v75;

        if math_min_ret >= 1 then
            v75 = LifeTime <= v74 and true or v74 <= 0;
        else
            v75 = false;
        end;

        local _rig = p67._rig;

        if p69 ~= u1 then
            u1 = p69;
            u2 = 0;

            if p68 > 0.025 then
                u3 = true;
                u4 = 0;
            elseif u3 then
                if p68 < 0.01818181818181818 then
                    u4 = u4 + 1;

                    if u4 >= 2 then
                        u3 = false;
                    end;
                else
                    u4 = 0;
                end;
            end;
        end;

        if not v75 then
            local v76 = v74 - v72;

            if p67._hasMotion and v76 ~= 0 then
                local math_max_ret2 = math.max(v74 / LifeTime, 0);
                local math_min_ret2 = math.min(math_max_ret2, 1);
                local v77 = p67.Graphs.Speed and (Graph.QueryPointsWithTime(math_min_ret2, p67.Graphs.Speed, p67.Seeds.Speed) or 0) or 0;

                if p67._drag ~= 0 then
                    v77 = v77 * math.exp(-p67._drag * v74);
                end;

                p67._motionAccelVel = p67._motionAccelVel + p67._accel * v76;
                p67._motionOffset = p67._motionOffset + (p67._lastDirWorld or Vector3.new(0, 0, 0)) * (v77 * v76) + p67._motionAccelVel * v76;
            end;

            if p67._hasDisp then
                local math_max_ret2 = math.max(v74 / LifeTime, 0);
                local math_min_ret2 = math.min(math_max_ret2, 1);
                local v78 = p67.Graphs.PosOffsetX and (Graph.QueryPointsWithTime(math_min_ret2, p67.Graphs.PosOffsetX, p67.Seeds.PosOffsetX) or 0) or 0;
                local v79 = p67.Graphs.PosOffsetY and (Graph.QueryPointsWithTime(math_min_ret2, p67.Graphs.PosOffsetY, p67.Seeds.PosOffsetY) or 0) or 0;
                local v80 = p67.Graphs.PosOffsetZ and (Graph.QueryPointsWithTime(math_min_ret2, p67.Graphs.PosOffsetZ, p67.Seeds.PosOffsetZ) or 0) or 0;
                p67._dispRaw = Vector3.new(v78, v79, v80);
            end;

            if p67._hasTurb then
                local math_max_ret2 = math.max(v74 / LifeTime, 0);
                local math_min_ret2 = math.min(math_max_ret2, 1);
                p67._turbRaw = Turbulence.sampleRaw(p67.Graphs.Turbulence, p67.Seeds.Turbulence, p67._turbSeed, p67._turbFreq, LifeTime, math_min_ret2);
            end;

            if p67._rollPending and p67._rollPendingStamp ~= p69 then
                p67._rollPending = nil;
                p67._rollPendingStamp = nil;
                p67._jitterAccum = 0;
                u2 = u2 + 1;
                applyRoll(p67, false);
                fireSeekHit(p66, p67);
            end;

            if script_Endpoints.glideStep(p67, (math.abs(v76))) and p67._jitterInterval == (1 / 0) then
                if u3 and u2 >= 8 then
                    p67._rollPending = true;
                    p67._rollPendingStamp = p69;
                else
                    u2 = u2 + 1;
                    applyRoll(p67, false);
                    fireSeekHit(p66, p67);
                end;
            end;

            p67._jitterAccum = p67._jitterAccum + math.abs(v71);

            if p67._jitterAccum >= p67._jitterInterval and not p67._rollPending then
                if u3 and u2 >= 8 then
                    p67._rollPending = true;
                    p67._rollPendingStamp = p69;
                else
                    p67._jitterAccum = 0;
                    u2 = u2 + 1;
                    applyRoll(p67, false);
                    fireSeekHit(p66, p67);
                end;
            end;

            if p67._lSpeed ~= 0 then
                local v81 = math.abs(p67._lSpeed) * v74;

                if v81 ~= p67._tipDist then
                    p67._tipDist = v81;

                    if p67._growReversed then
                        if p67._shapeMode == "Jitter" then
                            flushCFrames(p67, false);
                        end;
                    elseif p67._shapeMode == "Jitter" then
                        local revealOrder = _rig.revealOrder;
                        local revealDist = _rig.revealDist;
                        local writeCFs = _rig.writeCFs;
                        local rollCFs = _rig.rollCFs;
                        local _revealPtr = p67._revealPtr;
                        local v82 = false;

                        while _revealPtr < _rig.partCount and revealDist[revealOrder[_revealPtr + 1]] <= v81 do
                            _revealPtr = _revealPtr + 1;
                            local v83 = revealOrder[_revealPtr];
                            writeCFs[v83] = rollCFs[v83];
                            v82 = true;
                        end;

                        while _revealPtr > 0 and v81 < revealDist[revealOrder[_revealPtr]] do
                            writeCFs[revealOrder[_revealPtr]] = FAR_CFRAME;
                            _revealPtr = _revealPtr - 1;
                            v82 = true;
                        end;

                        p67._revealPtr = _revealPtr;

                        if v82 then
                            workspace:BulkMoveTo(_rig.parts, _rig.writeCFs, Enum.BulkMoveMode.FireCFrameChanged);
                        end;
                    end;
                end;
            end;

            if p67._shapeMode ~= "Jitter" then
                p67._scrollPhase = p67._scrollPhase + p67._scrollSpeed * (p67._timeFrozen and 0 or v71);
                script_BoltGen.applyScroll(_rig, p67, p67._scrollPhase);
                script_BoltGen.applyScrollForks(_rig, p67, p67._scrollPhase);
                writeSizes(_rig, p67._curThick or 0.15, false);
                flushCFrames(p67, false);
            end;
        end;

        local math_max_ret2 = math.max(v74 / LifeTime, 0);
        local v84 = math.min(math_max_ret2, 1) * p67.TotalKeyFrames;
        local math_floor_ret = math.floor(v84);

        if math_floor_ret ~= p67.CurrentStep then
            p67.CurrentStep = math_floor_ret;
            writeVisuals(p67, math_floor_ret / p67.TotalKeyFrames);
        end;

        return v75;
    end;

    function u5._refreshLightningAnimate(p85, p86, p87) -- Line: 492
        -- upvalues: Range (ref), buildSeekParams (copy), DirectionVectors (ref), AxisLinks (ref), PartConstants (ref), script_PDataBuilder (copy), Graph (ref), Turbulence (ref), sampleShape (copy), layoutFor (ref), buildRig (ref), script_ImpactDisk (copy), u2 (ref), applyRoll (copy), writeVisuals (copy), fireSeekHit (copy)
        p86.Link = nil;
        p86._userLink = p87.Link;
        p86._originPivotRot = nil;
        p86._originLinkCF = nil;
        p86._endpointMode = p87.TargetMode == "Seek" and "Seek" or (p87.TargetMode == "Point" and (p87.Target and p87.Target.Parent) and "Point" or "Directional");
        p86._target = p87.Target;
        local v88 = Range.RandomValueFromRange(p87.SeekRadius);
        p86._seekRadius = math.max(v88, 1);
        p86._seekRetarget = p87.SeekRetarget == true;
        p86._seekBias = math.clamp(p87.SeekBias or 0, 0, 1);
        p86._retargetSpeed = math.max(p87.RetargetSpeed or 0, 0);
        p86._seekHit = nil;
        p86._seekFallbackDir = nil;
        p86._seekNewHit = nil;
        p86._seekCurrentPos = nil;
        p86._seekGoalPos = nil;
        buildSeekParams(p85, p86);
        p86._length = math.max(0.1, Range.RandomValueFromRange(p87.Length));
        p86._amplitude = Range.RandomValueFromRange(p87.Amplitude);
        p86._decay = Range.RandomValueFromRange(p87.AmplitudeDecay);
        p86._forkChance = Range.RandomValueFromRange(p87.ForkChance);
        local v89 = Range.RandomValueFromRange(p87.ForkDepth) + 0.5;
        p86._forkDepth = math.floor(v89);
        p86._forkLenScale = Range.RandomValueFromRange(p87.ForkLengthScale);
        p86._sag = Range.RandomValueFromRange(p87.Sag);
        p86._sagShape = Range.RandomValueFromRange(p87.SagShape);
        p86._shapeMode = p87.ShapeMode or "Jitter";
        p86._scrollSpeed = Range.RandomValueFromRange(p87.ScrollSpeed);
        p86._waves = math.max(0.25, Range.RandomValueFromRange(p87.Waves));
        p86._scrollPhase = 0;
        p86._noiseSeedA = math.random() * 1000;
        p86._noiseSeedB = 500 + math.random() * 1000;
        local v90 = Range.RandomValueFromRange(p87.JitterRate);
        p86._jitterInterval = v90 > 0 and 1 / v90 or (1 / 0);
        p86._jitterAccum = 0;
        local v91 = Range.RandomValueFromRange(p87.GrowthSpeed);
        p86._lSpeed = v91;
        p86._growReversed = v91 < 0;
        p86._tipDist = 0;
        p86._revealPtr = 0;
        local v92 = DirectionVectors[p87.EmissionDirection] or DirectionVectors[Enum.NormalId.Top];
        local v93 = CFrame.new()[v92.vector] * v92.multiplier;
        local v94 = p87.SpreadAngle or Vector2.new(0, 0);
        local v95 = AxisLinks.sampleRangeAxes(p87, p87.AxisLinks, { "RotX", "RotY", "RotZ" }, Range, nil);
        local v96 = PartConstants.composeRotation(p87.RotOrder or "Global", v95.RotX or 0, v95.RotY or 0, v95.RotZ or 0);
        local CFrame_lookAt_ret = CFrame.lookAt(Vector3.new(0, 0, 0), v93);

        if p87.DirMode == "Local" then
            CFrame_lookAt_ret = CFrame_lookAt_ret * v96;
        end;

        if v94.X > 0 or v94.Y > 0 then
            local CFrame_Angles = CFrame.Angles;
            local v97 = (math.random() * 2 - 1) * v94.X;
            local math_rad_ret = math.rad(v97);
            local v98 = (math.random() * 2 - 1) * v94.Y;
            CFrame_lookAt_ret = CFrame_lookAt_ret * CFrame_Angles(math_rad_ret, math.rad(v98), 0);
        end;

        p86._dirLocalVec = CFrame_lookAt_ret.LookVector;
        p86._dirGlobal = p87.DirMode == "Global";
        p86._originRot = v96;
        local v99 = AxisLinks.sampleRangeAxes(p87, p87.AxisLinks, { "PosX", "PosY", "PosZ" }, Range, nil);
        local v100 = v99.PosX or 0;
        local v101 = v99.PosY or 0;
        local v102 = v99.PosZ or 0;

        if v100 == 0 and (v101 == 0 and v102 == 0) then
            p86._originOffset = nil;
        else
            p86._originOffset = Vector3.new(v100, v101, v102);
            p86._originOffsetGlobal = p87.PosMode == "Global";
        end;

        p86._accel = p87.Acceleration or Vector3.new(0, 0, 0);
        p86._drag = p87.Drag or 0;
        p86._dispMode = p87.DisplacementMode or "Global";
        p86._motionOffset = Vector3.new(0, 0, 0);
        p86._motionAccelVel = Vector3.new(0, 0, 0);
        p86._dispRaw = nil;
        p86._hasMotion = script_PDataBuilder.liveGraph(p87.Speed) ~= nil and true or p86._accel.Magnitude > 0;
        p86._hasDisp = (script_PDataBuilder.liveGraph(p87.PosOffsetX) ~= nil or script_PDataBuilder.liveGraph(p87.PosOffsetY) ~= nil) and true or script_PDataBuilder.liveGraph(p87.PosOffsetZ) ~= nil;
        p86.Graphs.Gradient = script_PDataBuilder.liveColor(p87.Gradient);
        p86.Graphs.ThicknessProfile = script_PDataBuilder.liveProfile(p87.ThicknessProfile);
        p86.Seeds.ThicknessProfile = Graph.GenerateSeed(p86.Graphs.ThicknessProfile);
        p86.Graphs.Turbulence = Turbulence.isLive(p87.Turbulence);
        p86._hasTurb = p86.Graphs.Turbulence ~= nil;
        p86._turbFreq = p87.TurbulenceFrequency or 1;
        p86._turbSeed = math.random() * 997 + 0.5;
        p86._turbRaw = nil;
        sampleShape(p86, p87, p86.AnimateItem);

        if layoutFor(p87) ~= p86._rig.partCount and p87.RenderTemplate then
            local VisualPart = p86.VisualPart;
            local v103;

            if VisualPart then
                v103 = VisualPart.Parent;
            else
                v103 = VisualPart;
            end;

            local v104, v105 = buildRig(p87);
            v104:SetAttribute("_PartIcleEmit", true);
            p86.VisualPart = v104;
            p86._rig = v105;
            v104.Parent = v103 or p85:GetFolder();

            if VisualPart then
                pcall(function() -- Line: 589
                    -- upvalues: VisualPart (copy)
                    VisualPart:Destroy();
                end);
            end;
        end;

        local v106 = Range.RandomValueFromRange(p87.SegmentCount) + 0.5;
        local math_floor_ret = math.floor(v106);
        p86._segCount = math.clamp(math_floor_ret, 2, p86._rig.mainSegs);
        p86._curThick = p87.Thickness and Graph.QueryPointsWithTime(0, p87.Thickness, p86.Seeds.Thickness) or p86._curThick;
        script_ImpactDisk.refresh(p85, p86, p87);
        p86._rollPending = nil;
        p86._rollPendingStamp = nil;
        u2 = u2 + 1;
        applyRoll(p86, false);
        writeVisuals(p86, 0);
        fireSeekHit(p85, p86);
    end;
end;