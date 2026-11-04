 

 

local Graph = require(script.Parent.Graph);
local Range = require(script.Parent.Range);
local Pool = require(script.Parent.Pool);
local Events = require(script.Parent.Events);
local NestedEmit = require(script.Parent.NestedEmit);
local Particles = require(script.Parent.Particles);
local script_Trajectory = require(script.Trajectory);
local script_PDataBuilder = require(script.PDataBuilder);
local CFrame_new_ret = CFrame.new(1000000000, 1000000000, 1000000000);
local u1 = setmetatable({}, {
    __mode = "k"
});

return function(u2) -- Line: 39
    -- upvalues: Pool (copy), CFrame_new_ret (copy), u1 (copy), Graph (copy), Events (copy), script_Trajectory (copy), Range (copy), script_PDataBuilder (copy), Particles (copy), NestedEmit (copy)
    function u2._isRocks(p3) -- Line: 42
        local v4 = p3:IsA("BasePart") and p3:GetAttribute("IsRocks") == true;

        return v4;
    end;

    local function buildChunk(p5) -- Line: 49
        -- upvalues: Pool (ref)
        local v6 = Pool.copyBare(p5);
        v6.Anchored = true;
        v6.CanCollide = false;
        v6.CanQuery = false;
        v6.CanTouch = false;
        v6.Massless = false;
        v6.Locked = true;
        v6.Archivable = false;
        v6.CastShadow = true;
        v6.Transparency = 0;

        return v6, v6:FindFirstChildWhichIsA("Decal") or v6:FindFirstChildWhichIsA("Texture");
    end;

    local function chunkCapFor(p7) -- Line: 64
        local math_floor_ret = math.floor((p7.ChunkCount and p7.ChunkCount.Max or 10) + 0.5);

        return math.clamp(math_floor_ret, 1, 32);
    end;

    local function buildRig(p8) -- Line: 68
        -- upvalues: Pool (ref), CFrame_new_ret (ref), u1 (ref)
        local math_floor_ret = math.floor((p8.ChunkCount and (p8.ChunkCount.Max or 10) or 10) + 0.5);
        local math_clamp_ret = math.clamp(math_floor_ret, 1, 32);
        local Model = Instance.new("Model");
        Model.Name = "RockBurst";
        Model.Archivable = false;
        local v9 = {
            chunkCap = math_clamp_ret,
            parts = table.create(math_clamp_ret),
            decals = table.create(math_clamp_ret),
            baseSize = table.create(math_clamp_ret),
            halfExt = table.create(math_clamp_ret),
            bounciness = table.create(math_clamp_ret),
            gravity = table.create(math_clamp_ret),
            friction = table.create(math_clamp_ret),
            launchVel = table.create(math_clamp_ret),
            launchAng = table.create(math_clamp_ret),
            spawnPos = table.create(math_clamp_ret),
            spawnRot = table.create(math_clamp_ret),
            trajs = table.create(math_clamp_ret),
            touched = table.create(math_clamp_ret),
            hitDone = table.create(math_clamp_ret),
            writeCFs = table.create(math_clamp_ret)
        };

        for i = 1, math_clamp_ret do
            local v10 = Pool.copyBare(p8.RenderTemplate);
            v10.Anchored = true;
            v10.CanCollide = false;
            v10.CanQuery = false;
            v10.CanTouch = false;
            v10.Massless = false;
            v10.Locked = true;
            v10.Archivable = false;
            v10.CastShadow = true;
            v10.Transparency = 0;
            local v11 = v10:FindFirstChildWhichIsA("Decal") or v10:FindFirstChildWhichIsA("Texture");
            v10.Name = "Chunk" .. i;
            v10.CFrame = CFrame_new_ret;
            v10.Parent = Model;
            v9.parts[i] = v10;
            v9.decals[i] = v11;
            v9.baseSize[i] = v10.Size;
            v9.writeCFs[i] = CFrame_new_ret;
            local _ = i;
        end;

        u1[Model] = v9;

        return Model, v9;
    end;

    local function acquireRocks(p12) -- Line: 108
        -- upvalues: Pool (ref), u1 (ref), buildRig (copy)
        local math_floor_ret = math.floor((p12.ChunkCount and (p12.ChunkCount.Max or 10) or 10) + 0.5);
        local math_clamp_ret = math.clamp(math_floor_ret, 1, 32);
        local u13 = p12.Pool ~= false and Pool.acquire(p12.RenderTemplate, "Rocks");

        if u13 then
            local v14 = u1[u13];

            if v14 and (v14.chunkCap == math_clamp_ret and (v14.parts[1] and v14.parts[1].Parent == u13)) then
                u13:SetAttribute("_PartIcleEmit", true);

                return u13, v14;
            end;

            pcall(function() -- Line: 118
                -- upvalues: u13 (copy)
                u13:Destroy();
            end);
        end;

        local v15, v16 = buildRig(p12);
        v15:SetAttribute("_PartIcleEmit", true);

        return v15, v16;
    end;

    local function writeVisuals(p17, p18) -- Line: 128
        -- upvalues: Graph (ref)
        local Graphs = p17.Graphs;
        local Seeds = p17.Seeds;
        local v19 = Graphs.Transparency and (Graph.QueryPointsWithTime(p18, Graphs.Transparency, Seeds.Transparency) or 0) or 0;

        if p17.SkipTransparency then
            v19 = p17._curTrans or v19;
        end;

        local v20 = Graphs.Brightness and (Graph.QueryPointsWithTime(p18, Graphs.Brightness, Seeds.Brightness) or 1) or 1;
        local v21;

        if Graphs.Color and not p17.SkipColor then
            local v22 = Graph.QueryColorPointWithTime(p18, Graphs.Color);
            v21 = Color3.new(math.min(v22.R * v20, 1), math.min(v22.G * v20, 1), (math.min(v22.B * v20, 1)));
        else
            v21 = nil;
        end;

        local v23 = Graphs.Scale and Graph.QueryPointsWithTime(p18, Graphs.Scale, Seeds.Scale);
        local _rig = p17._rig;
        local v24;

        if v23 then
            v24 = v23 ~= p17._curScale;
        else
            v24 = v23;
        end;

        if v23 then
            p17._curScale = v23;
        end;

        p17._curTrans = v19;

        for i = 1, _rig.chunkCap do
            local v25 = _rig.parts[i];
            v25.Transparency = v19;

            if v21 then
                v25.Color = v21;
            end;

            local v26 = _rig.decals[i];

            if v26 then
                v26.Transparency = v19;

                if v21 then
                    v26.Color3 = v21;
                end;
            end;

            local v27;

            if v24 then
                v25.Size = _rig.baseSize[i] * math.max(v23, 0.01);
                v27 = i;
            else
                v27 = i;
            end;
        end;
    end;

    local function buildRockParams(u28, p29) -- Line: 161
        -- upvalues: Events (ref)
        local u30 = Events.makeHitParams(p29);
        u30.RespectCanCollide = true;
        pcall(function() -- Line: 164
            -- upvalues: u30 (copy), u28 (copy)
            u30:AddToFilter(u28:GetFolder());
            u30:AddToFilter(u28:GetPoolFolder());
        end);
        p29._rockParams = u30;

        function p29._raycastFn(p31, p32) -- Line: 169
            -- upvalues: u30 (copy)
            return workspace:Raycast(p31, p32, u30);
        end;
    end;

    local function buildTrajectories(p33, p34) -- Line: 176
        -- upvalues: script_Trajectory (ref)
        local _rig = p33._rig;
        local _raycastFn = p33._raycastFn;
        local v35 = p33._curScale or 1;
        local v36 = p33._trajBuilt + 1;
        local math_min_ret = math.min(p33._chunkCount, p33._trajBuilt + p34);

        for i = v36, math_min_ret do
            local v37 = script_Trajectory.build(_rig.spawnPos[i], _rig.launchVel[i], _rig.spawnRot[i], _rig.launchAng[i], _rig.halfExt[i], v35, _rig.gravity[i], _rig.bounciness[i], _rig.friction[i], _raycastFn);
            _rig.trajs[i] = v37;

            if v37.impactT and v37.impactT < p33._firstImpactT then
                p33._firstImpactT = v37.impactT;
                p33._firstHitInfo = v37.hit;
            end;

            local v38;

            if v37.restT == (1 / 0) then
                p33._trajAnyEndless = true;
                v38 = i;
            elseif v37.restT > p33._trajMaxRest then
                p33._trajMaxRest = v37.restT;
                v38 = i;
            else
                v38 = i;
            end;
        end;

        p33._trajBuilt = math_min_ret;

        if p33._chunkCount <= math_min_ret then
            p33._maxRestT = p33._trajMaxRest > 0 and not p33._trajAnyEndless and (p33._trajMaxRest or (1 / 0)) or (1 / 0);
        end;
    end;

    local function startPhysics(p39, p40) -- Line: 207
        -- upvalues: buildRockParams (copy), script_Trajectory (ref), buildTrajectories (copy)
        buildRockParams(p39, p40);
        local _rig = p40._rig;
        p40._trajBuilt = 0;
        p40._firstImpactT = (1 / 0);
        p40._firstHitInfo = nil;
        p40._trajMaxRest = 0;
        p40._trajAnyEndless = false;
        p40._maxRestT = (1 / 0);
        p40._restWritten = false;
        p40._hitsPending = p40._hitPerChunk and (p40._chunkCount or 0) or 0;

        for i = 1, p40._chunkCount do
            _rig.trajs[i] = script_Trajectory.ballistic(_rig.spawnPos[i], _rig.launchVel[i], _rig.spawnRot[i], _rig.launchAng[i]);
            _rig.hitDone[i] = false;
            local _ = i;
        end;

        buildTrajectories(p40, 8);
    end;

    local function fireChunkHit(p41, p42, p43) -- Line: 225
        -- upvalues: Events (ref)
        local v44 = Events.makePayload(p41, p42, "OnHit", nil);
        v44.HitInstance = p43.Instance;
        v44.Other = p43.Instance;
        v44.HitPosition = p43.Position;
        v44.HitNormal = p43.Normal;
        Events.fire(p41, p42, "OnHit", p42.EventChainCtx, v44);
    end;

    function u2.EmitRocks(p45, p46, p47, p48) -- Line: 235
        -- upvalues: Range (ref), acquireRocks (copy), script_PDataBuilder (ref), u2 (copy), writeVisuals (copy), startPhysics (copy), Pool (ref), Particles (ref), NestedEmit (ref)
        if not (p46 and p46.Parent) then
            return;
        end;

        local EmitData = p45:GetEmitData(p46, p48);

        if not (EmitData and EmitData.RenderTemplate) then
            return;
        end;

        local v49 = Range.RandomValueFromRange(EmitData.Lifetime);
        local v50, v51 = acquireRocks(EmitData);
        local v52 = script_PDataBuilder.build(p46, EmitData, v50, v51, v49 <= 0 and 0.001 or v49, p48, p47);
        u2._seedTsOverride(v52, p46);

        if EmitData.Pool ~= false then
            v52._sourceRT = EmitData.RenderTemplate;
            v52._poolKind = "Rocks";
        end;

        p45:_matteCarry(p48, v52, v51.parts);
        writeVisuals(v52, 0);
        v50.Parent = EmitData.EmitParent or p45:GetFolder();
        startPhysics(p45, v52);
        Pool.restoreTrails(v50, "Rocks");
        Particles.EnableEmit(v50, p45:_makeAliveCheck());
        v52._nestedAlive = { true };
        p45:_registerEmit(v52, p48);
        NestedEmit.walk(p45, EmitData.RenderTemplate, v50, v52._nestedAlive, p48);
    end;

    function u2.EmitRocksAnimate(p53, p54, p55, p56) -- Line: 265
        -- upvalues: Range (ref), buildRig (copy), script_PDataBuilder (ref), u2 (copy), writeVisuals (copy), startPhysics (copy), Particles (ref), NestedEmit (ref)
        if not (p54 and p54.Parent) then
            return;
        end;

        if p53.ActiveAnimates[p54] then
            return;
        end;

        local EmitData = p53:GetEmitData(p54, p56);

        if not (EmitData and EmitData.RenderTemplate) then
            return;
        end;

        local v57 = Range.RandomValueFromRange(EmitData.Lifetime);
        local v58, v59 = buildRig(EmitData);
        v58:SetAttribute("_PartIcleEmit", true);
        local v60 = script_PDataBuilder.build(p54, EmitData, v58, v59, v57 <= 0 and 0.001 or v57, p56, p55);
        v60.IsAnimate = true;
        v60.AnimateItem = p54;
        v60._animateLink = p55;
        u2._seedTsOverride(v60, p54);
        writeVisuals(v60, 0);
        v58.Parent = EmitData.EmitParent or p53:GetFolder();
        startPhysics(p53, v60);
        Particles.EnableEmit(v58, p53:_makeAliveCheck());
        v60._nestedAlive = { true };
        p53.ActiveAnimates[p54] = v60;
        p53:_registerEmit(v60, p56);
        NestedEmit.walk(p53, EmitData.RenderTemplate, v58, v60._nestedAlive, p56);
    end;

    function u2.UpdateRocks(p61, p62, p63, p64) -- Line: 295
        -- upvalues: Graph (ref), buildTrajectories (copy), script_Trajectory (ref), Events (ref), writeVisuals (copy)
        local math_max_ret = math.max((p64 - p62.StartTime) / p62.LifeTime, 0);
        local math_min_ret = math.min(math_max_ret, 1);
        local v65;

        if p62._tsOverride == nil or p64 >= (p62._tsOverrideUntil or 0) then
            v65 = p62.Graphs.Timescale and (Graph.QueryPointsWithTime(math_min_ret, p62.Graphs.Timescale, p62.Seeds.Timescale) or 1) or 1;
        else
            v65 = p62._tsOverride;
        end;

        local LifeTime = p62.LifeTime;
        local v66 = (p62._effectiveElapsed or 0) + (p62._timeFrozen and 0 or p63 * v65);
        local v67 = v66 < 0 and 0 or v66;

        if LifeTime < v67 then
            v67 = LifeTime;
        end;

        p62._effectiveElapsed = v67;
        local VisualPart = p62.VisualPart;

        if not (VisualPart and VisualPart.Parent) then
            return true;
        end;

        if p62.TotalKeyFrames <= 0 then
            return true;
        end;

        local v68;

        if math_min_ret >= 1 then
            v68 = LifeTime <= v67 and true or v67 <= 0;
        else
            v68 = false;
        end;

        if not v68 then
            local _rig = p62._rig;

            if p62._trajBuilt < p62._chunkCount then
                buildTrajectories(p62, 8);
            end;

            local v69 = p62._sinkOut and v67 / LifeTime > 0.85;

            if v67 < p62._maxRestT or (v69 or not p62._restWritten) then
                local v70;

                if v69 then
                    local v71 = (v67 / LifeTime - 0.85) / 0.15000000000000002;
                    v70 = v71 * v71;
                else
                    v70 = 0;
                end;

                for i = 1, p62._chunkCount do
                    local u72 = _rig.trajs[i];
                    local v73;

                    if u72 then
                        local v74 = script_Trajectory.evaluate(u72, v67, _rig.gravity[i]);

                        if v70 > 0 and u72.restT < v67 then
                            local v75 = _rig.baseSize[i];
                            local v76 = math.max(v75.X, v75.Y, v75.Z) * math.max(p62._curScale or 1, 0.01) * 1.5;
                            v74 = v74.Rotation + (v74.Position - (u72.restNormal or Vector3.new(0, 1, 0)) * (v76 * v70));
                        end;

                        _rig.writeCFs[i] = v74;

                        if p62._inheritFloor and (not _rig.touched[i] and (u72.impactT and (u72.impactT <= v67 and u72.hit))) then
                            _rig.touched[i] = true;
                            local u77 = _rig.parts[i];
                            pcall(function() -- Line: 342
                                -- upvalues: u77 (copy), u72 (copy)
                                u77.Material = u72.hit.Instance.Material;
                                u77.Color = u72.hit.Instance.Color;
                            end);
                            p62.SkipColor = true;
                            v73 = i;
                        else
                            v73 = i;
                        end;
                    else
                        v73 = i;
                    end;
                end;

                workspace:BulkMoveTo(_rig.parts, _rig.writeCFs, Enum.BulkMoveMode.FireCFrameChanged);
                local v78;

                if p62._maxRestT <= v67 then
                    v78 = not v69;
                else
                    v78 = false;
                end;

                p62._restWritten = v78;
            end;

            if p62.Events and p62.Events.OnHit then
                if p62._hitPerChunk then
                    if p62._hitsPending > 0 then
                        for i = 1, p62._chunkCount do
                            local v79 = _rig.trajs[i];
                            local v80;

                            if _rig.hitDone[i] or not (v79.impactT and (v79.hit and v79.impactT <= v67)) then
                                v80 = i;
                            else
                                _rig.hitDone[i] = true;
                                p62._hitsPending = p62._hitsPending - 1;
                                local hit = v79.hit;
                                local v81 = Events.makePayload(p61, p62, "OnHit", nil);
                                v81.HitInstance = hit.Instance;
                                v81.Other = hit.Instance;
                                v81.HitPosition = hit.Position;
                                v81.HitNormal = hit.Normal;
                                Events.fire(p61, p62, "OnHit", p62.EventChainCtx, v81);
                                v80 = i;
                            end;
                        end;
                    end;
                elseif not (p62._hitFired or (p62._trajBuilt < p62._chunkCount or (not p62._firstHitInfo or p62._firstImpactT > v67))) then
                    p62._hitFired = true;
                    local _firstHitInfo = p62._firstHitInfo;
                    local v82 = Events.makePayload(p61, p62, "OnHit", nil);
                    v82.HitInstance = _firstHitInfo.Instance;
                    v82.Other = _firstHitInfo.Instance;
                    v82.HitPosition = _firstHitInfo.Position;
                    v82.HitNormal = _firstHitInfo.Normal;
                    Events.fire(p61, p62, "OnHit", p62.EventChainCtx, v82);
                end;
            end;
        end;

        local math_max_ret2 = math.max(v67 / LifeTime, 0);
        local v83 = math.min(math_max_ret2, 1) * p62.TotalKeyFrames;
        local math_floor_ret = math.floor(v83);

        if math_floor_ret ~= p62.CurrentStep then
            p62.CurrentStep = math_floor_ret;
            writeVisuals(p62, math_floor_ret / p62.TotalKeyFrames);
        end;

        return v68;
    end;

    function u2._refreshRocksAnimate(p84, u85, p86) -- Line: 387
        -- upvalues: buildRig (copy), script_PDataBuilder (ref), writeVisuals (copy), startPhysics (copy)
        u85.Link = nil;
        u85._sinkOut = p86.SinkOut ~= false;
        u85._inheritFloor = p86.InheritFloor == true;
        u85._hitPerChunk = p86.HitPerChunk == true;
        u85._hitFired = false;
        u85.SkipColor = nil;
        local math_floor_ret = math.floor((p86.ChunkCount and (p86.ChunkCount.Max or 10) or 10) + 0.5);

        if math.clamp(math_floor_ret, 1, 32) ~= u85._rig.chunkCap and p86.RenderTemplate then
            local VisualPart = u85.VisualPart;
            VisualPart = VisualPart;
            local v87;

            if VisualPart then
                v87 = VisualPart.Parent;
            else
                v87 = VisualPart;
            end;

            local v88, v89 = buildRig(p86);
            v88:SetAttribute("_PartIcleEmit", true);
            u85.VisualPart = v88;
            u85._rig = v89;
            v88.Parent = v87 or p84:GetFolder();

            if VisualPart then
                pcall(function() -- Line: 405
                    -- upvalues: VisualPart (copy)
                    VisualPart:Destroy();
                end);
            end;
        end;

        local u90 = script_PDataBuilder.cloneOrigin(u85, u85._animateLink);
        local AnimateItem = u85.AnimateItem;

        if not u90 and (AnimateItem and AnimateItem.Parent) then
            u90 = AnimateItem.CFrame;
        end;

        if u90 then
            pcall(function() -- Line: 412
                -- upvalues: u85 (copy), u90 (ref)
                u85.VisualPart.WorldPivot = u90;
            end);
        end;

        script_PDataBuilder.rollChunks(u85, p86, u85._rig, u90 or CFrame.new());
        writeVisuals(u85, 0);
        startPhysics(p84, u85);
    end;
end;