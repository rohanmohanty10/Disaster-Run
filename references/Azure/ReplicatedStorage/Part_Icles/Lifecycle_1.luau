 
 

local Selection = game:GetService("Selection");
local RunService = game:GetService("RunService");
local u1 = RunService:IsStudio();
local success = pcall(function() -- Line: 11
    -- upvalues: Selection (copy)
    return Selection:Get();
end);
local u2 = RunService:IsClient() and RunService.PreRender or RunService.Heartbeat;
local TypeRegistry = require(script.Parent.TypeRegistry);
local Particles = require(script.Parent.Particles);
local Events = require(script.Parent.Events);
local EvenCycle = require(script.Parent.EvenCycle);
local EngineAttr = require(script.Parent.EngineAttr);
local Log = require(script.Parent.Log);
local DecalLayers = require(script.Parent.DecalLayers);
local MeshFrames = require(script.Parent.MeshFrames);
local AtRest = require(script.Parent.AtRest);
local Drive = require(script.Parent.Container.Drive);

return function(u3) -- Line: 27
    -- upvalues: AtRest (copy), DecalLayers (copy), MeshFrames (copy), EngineAttr (copy), TypeRegistry (copy), EvenCycle (copy), Particles (copy), success (copy), Log (copy), Events (copy), u2 (copy), u1 (copy), Selection (copy), Drive (copy)
    local function cancelAnimation(p4, p5) -- Line: 30
        -- upvalues: AtRest (ref), DecalLayers (ref), MeshFrames (ref)
        local u6 = p4.ActiveAnimates[p5];

        if not u6 then
            return;
        end;

        if (u6.Type == "Beam" or (u6.Type == "Highlight" or u6.Type == "TrailEmitter")) and (u6.VisualPart and u6.VisualPart.Parent) then
            local u7 = u6.BeamSnapshot or (u6.HighlightSnapshot or u6.TrailEmitterSnapshot);

            if u7 then
                pcall(function() -- Line: 40
                    -- upvalues: u7 (copy), u6 (copy)
                    for i, v in pairs(u7) do
                        u6.VisualPart[i] = v;
                    end;
                end);
            end;

            u6.VisualPart.Enabled = false;
        end;

        if u6.InitialAnchorCF and (u6.VisualPart and u6.VisualPart.Parent) then
            if u6.Type == "Model" then
                u6.VisualPart:PivotTo(u6.InitialAnchorCF);

                if u6.InitialScale then
                    pcall(function() -- Line: 50
                        -- upvalues: u6 (copy)
                        u6.VisualPart:ScaleTo(u6.InitialScale);
                    end);
                end;
            elseif u6.Type ~= "Beam" then
                u6.VisualPart.CFrame = u6.InitialAnchorCF;
            end;
        end;

        if (u6.Type == "Part" or (u6.Type == "Attachment" or u6.Type == "Model")) and (u6.VisualPart and u6.VisualPart.Parent) then
            AtRest.rest(u6.VisualPart);
        end;

        if (u6.Type == "Part" or u6.Type == "Attachment") and (u6.VisualPart and u6.VisualPart.Parent) then
            DecalLayers.restore(u6);
            MeshFrames.restore(u6);
            pcall(function() -- Line: 64
                -- upvalues: u6 (copy)
                u6.VisualPart.Transparency = 1;
                local v8 = u6.HasDecal and u6.VisualPart:FindFirstChildOfClass("Decal");

                if v8 then
                    v8.Transparency = 1;
                end;
            end);
        end;

        if (u6.Type == "Screen" or (u6.Type == "ImageLabel" or (u6.Type == "Lightning" or (u6.Type == "Rocks" or u6.Type == "Rope")))) and u6.VisualPart then
            pcall(function() -- Line: 74
                -- upvalues: u6 (copy)
                u6.VisualPart:Destroy();
            end);

            if u6._impactDisk then
                pcall(function() -- Line: 75
                    -- upvalues: u6 (copy)
                    u6._impactDisk:Destroy();
                end);
            end;
        end;

        p4:_reclaimPData(u6);

        for i = #p4.ActiveEmits, 1, -1 do
            if p4.ActiveEmits[i] == u6 then
                local v9 = #p4.ActiveEmits;

                if i < v9 then
                    p4.ActiveEmits[i] = p4.ActiveEmits[v9];
                end;

                p4.ActiveEmits[v9] = nil;
                break;
            end;

            local _ = i;
        end;

        p4.ActiveAnimates[p5] = nil;
    end;

    function u3._cancelAnimation(p10, p11) -- Line: 91
        -- upvalues: cancelAnimation (copy)
        cancelAnimation(p10, p11);
    end;

    local function haltEmission(p12, p13, p14) -- Line: 98
        -- upvalues: u3 (copy), EngineAttr (ref), cancelAnimation (copy), TypeRegistry (ref), EvenCycle (ref), Particles (ref)
        if u3.ActiveLoops[p13] then
            task.cancel(u3.ActiveLoops[p13]);
            u3.ActiveLoops[p13] = nil;
        end;

        local v15 = u3.ActiveChainLoops[p13];

        if v15 then
            for _, v in ipairs(v15) do
                pcall(task.cancel, v);
            end;

            u3.ActiveChainLoops[p13] = nil;
        end;

        EngineAttr.write(p13, "AnimateLoop", false);
        local v16 = (p13:GetAttribute("_emitGen") or 0) + 1;
        EngineAttr.write(p13, "_emitGen", v16);

        if p14 then
            cancelAnimation(p12, p13);
        end;

        local Config = TypeRegistry.getConfig(p13);

        if Config then
            EngineAttr.write(Config, "Enabled", false);
        end;

        EngineAttr.write(p13, "_PartIclePlaying", nil);
        EvenCycle.clear(p12._evenCycleStore, p13:GetAttribute("_EvenCycleId") or p13);

        for _, descendant in ipairs(p13:GetDescendants()) do
            if descendant:GetAttribute("Transformed") then
                if p14 then
                    p12:Disable(descendant);
                else
                    p12:SoftDisable(descendant);
                end;
            elseif not TypeRegistry.isInsideRenderTemplate(descendant, p13) then
                if descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") then
                    if p14 then
                        Particles.CancelNative(descendant);
                    else
                        pcall(function() -- Line: 124
                            -- upvalues: descendant (copy)
                            descendant.Enabled = false;
                        end);
                    end;
                elseif descendant:IsA("Beam") or descendant:IsA("Highlight") then
                    pcall(function() -- Line: 126
                        -- upvalues: descendant (copy)
                        descendant.Enabled = false;
                    end);
                end;
            end;
        end;
    end;

    function u3.Disable(u17, u18) -- Line: 134
        -- upvalues: success (ref), haltEmission (copy), u3 (copy), EngineAttr (ref)
        if not u18 then
            return;
        end;

        if u17._inStep then
            u17._afterStep = u17._afterStep or {};
            table.insert(u17._afterStep, function() -- Line: 140
                -- upvalues: u17 (copy), u18 (copy)
                u17:Disable(u18);
            end);

            return;
        end;

        local v19 = success and (game:GetService("RunService"):IsEdit() and game:GetService("ChangeHistoryService")) or nil;

        if v19 then
            v19:SetWaypoint("Part-Icles: Before Disable");
        end;

        haltEmission(u17, u18, true);

        if u3._isReactor(u18) then
            u17:RestoreReactor(u18);
        end;

        u17:_endReacted(u18, nil);
        local ActiveEmits = u17.ActiveEmits;

        for i = #ActiveEmits, 1, -1 do
            local v20 = ActiveEmits[i];
            local v21;

            if v20 and v20._sourceItem == u18 then
                if v20.VisualPart and v20.VisualPart.Parent then
                    u17:_releaseOrDestroy(v20, v20.VisualPart);
                end;

                u17:_reclaimPData(v20);

                if ActiveEmits[i] == v20 then
                    local v22 = #ActiveEmits;

                    if i < v22 then
                        ActiveEmits[i] = ActiveEmits[v22];
                    end;

                    ActiveEmits[v22] = nil;
                    v21 = i;
                else
                    v21 = i;
                end;
            else
                v21 = i;
            end;
        end;

        if u17._lingerByItem and u17._lingerByItem[u18] then
            for _, v in ipairs(u17._lingerByItem[u18]) do
                if v then
                    local u23 = false;
                    pcall(function() -- Line: 173
                        -- upvalues: u23 (ref), v (copy)
                        u23 = v:GetAttribute("_lingerCounted") == true;
                    end);

                    if u23 then
                        u17._lingerVisualCount = math.max(0, (u17._lingerVisualCount or 0) - 1);
                        EngineAttr.write(v, "_lingerCounted", nil);
                    end;

                    if v.Parent then
                        pcall(function() -- Line: 179
                            -- upvalues: v (copy)
                            v:Destroy();
                        end);
                    end;
                end;
            end;

            u17._lingerByItem[u18] = nil;
        end;

        if v19 then
            v19:SetWaypoint("Part-Icles: Disable");
        end;
    end;

    function u3.SoftDisable(p24, p25) -- Line: 191
        -- upvalues: success (ref), haltEmission (copy)
        if not p25 then
            return;
        end;

        local v26 = success and (game:GetService("RunService"):IsEdit() and game:GetService("ChangeHistoryService")) or nil;

        if v26 then
            v26:SetWaypoint("Part-Icles: Before Soft Disable");
        end;

        haltEmission(p24, p25, false);

        if v26 then
            v26:SetWaypoint("Part-Icles: Soft Disable");
        end;
    end;

    function u3.EmitAnimate(p27, p28, p29, p30) -- Line: 202
        -- upvalues: u3 (copy), cancelAnimation (copy), Log (ref)
        p27:_warnIfNotActivated("EmitAnimate");

        if (p28:IsA("BlurEffect") or p28:IsA("BloomEffect") or (p28:IsA("ColorCorrectionEffect") or p28:IsA("Atmosphere") or (p28:IsA("ImageLabel") or u3._isLightning(p28)) or (u3._isCameraShake(p28) or u3._isRocks(p28) or (u3._isRope(p28) or u3._isDistortion(p28))))) and p27.ActiveAnimates[p28] then
            return;
        end;

        cancelAnimation(p27, p28);
        local v31 = p27.MAX_ACTIVE_PARTICLES or 1000;

        if v31 <= #p27.ActiveEmits + (p27._lingerVisualCount or 0) then
            local os_clock_ret = os.clock();

            if os_clock_ret - (p27._capWarnLastAt or 0) >= 1 then
                p27._capWarnLastAt = os_clock_ret;
                Log.warn(("[Part-Icles] active particle cap (%d) reached  -  new emits skipped (user Module code still runs)."):format(v31));
            end;

            return;
        end;

        if u3._isContainer(p28) then
            p27:EmitContainer(p28, p29, p30);

            return;
        end;

        if u3._isForce(p28) then
            p27:EmitForce(p28, p29, p30);

            return;
        end;

        if u3._isMatte(p28) then
            p27:EmitMatte(p28, p29, p30);

            return;
        end;

        if u3._isReactor(p28) then
            p27:EmitReactor(p28, p29, p30);

            return;
        end;

        if p28:IsA("Beam") then
            p27:EmitBeamAnimate(p28, p29, p30);

            return;
        end;

        if p28:IsA("Trail") and p28:FindFirstChild("PartIcleProperties") then
            p27:EmitTrailAnimate(p28, p29, p30);

            return;
        end;

        if p28:IsA("Highlight") then
            p27:EmitHighlightAnimate(p28, p29, p30);

            return;
        end;

        if p28:IsA("Attachment") then
            p27:EmitAttachmentAnimate(p28, p29, p30);

            return;
        end;

        if p28:IsA("Model") then
            p27:EmitModelAnimate(p28, p29, p30);

            return;
        end;

        if p28:IsA("BlurEffect") then
            p27:EmitBlurAnimate(p28, p29, p30);

            return;
        end;

        if p28:IsA("BloomEffect") then
            p27:EmitBloomAnimate(p28, p29, p30);

            return;
        end;

        if p28:IsA("ColorCorrectionEffect") then
            p27:EmitColorCorrectionAnimate(p28, p29, p30);

            return;
        end;

        if p28:IsA("Atmosphere") then
            p27:EmitAtmosphereAnimate(p28, p29, p30);

            return;
        end;

        if p28:IsA("ImageLabel") then
            p27:EmitImageLabelAnimate(p28, p29, p30);

            return;
        end;

        if u3._isLightning(p28) then
            p27:EmitLightningAnimate(p28, p29, p30);

            return;
        end;

        if u3._isCameraShake(p28) then
            p27:EmitCameraShakeAnimate(p28, p29, p30);

            return;
        end;

        if u3._isRocks(p28) then
            p27:EmitRocksAnimate(p28, p29, p30);

            return;
        end;

        if u3._isRope(p28) then
            p27:EmitRopeAnimate(p28, p29, p30);

            return;
        end;

        if u3._isDistortion(p28) then
            p27:EmitDistortionAnimate(p28, p29, p30);

            return;
        end;

        if p28:IsA("BasePart") then
            p27:EmitPartAnimate(p28, p29, p30);
        end;
    end;

    function u3.EnableEmit(u32, u33, u34, u35) -- Line: 253
        -- upvalues: Particles (ref), EvenCycle (ref), EngineAttr (ref), TypeRegistry (ref), Events (ref)
        u32:_warnIfNotActivated("EnableEmit");
        local v36 = u33:GetAttribute("EmissionMode") or "Emit";
        local Attribute = u33:GetAttribute("EmitCount");
        local v37 = Attribute == nil and 1 or Attribute;
        local u38 = v37 <= 0 and (u35 and u35.EventDriven) and 1 or v37;
        local v39 = u33:GetAttribute("EmitDelay") or 0;
        local u40 = Particles.parseDuration(u33:GetAttribute("EmitDuration")) or 0;
        local v41;

        if u35 then
            v41 = u35.Overrides;
        else
            v41 = u35;
        end;

        if v41 then
            if v41.Count ~= nil then
                u38 = v41.Count;
            end;

            if v41.Delay ~= nil then
                v39 = v41.Delay;
            end;

            if v41.Duration ~= nil then
                u40 = Particles.parseDuration(v41.Duration) or 0;
            end;
        end;

        if v36 ~= "Animate" and (u38 <= 0 and u40 <= 0) then
            return;
        end;

        local u42;

        if u35 then
            u42 = u35.ChainCtx ~= nil;
        else
            u42 = u35;
        end;

        local u43;

        if u35 then
            u43 = u35._parentAlive ~= nil;
        else
            u43 = u35;
        end;

        local u44;

        if u35 == nil or u35._playToken == nil then
            u44 = false;
        else
            u44 = v36 ~= "Animate";
        end;

        local u45 = u42 or (u43 or (u44 or u40 <= 0));

        if not (u42 or u43) then
            EvenCycle.ensureIds(u33);
        end;

        local u46;

        if u45 then
            u46 = nil;
        else
            u46 = (u33:GetAttribute("_emitGen") or 0) + 1;
            EngineAttr.write(u33, "_emitGen", u46);
        end;

        local u47 = u32._engineGen or 0;

        local function genStillCurrent() -- Line: 295
            -- upvalues: u32 (copy), u47 (copy), u33 (copy), u45 (copy), u46 (ref), u35 (copy)
            if u32.Connection == nil then
                return false;
            end;

            if (u32._engineGen or 0) ~= u47 then
                return false;
            end;

            if not u33.Parent then
                return false;
            end;

            if not u45 and (u33:GetAttribute("_emitGen") or 0) ~= u46 then
                return false;
            end;

            if u35 and (u35._parentAlive and not u35._parentAlive[1]) then
                return false;
            end;

            return not (u35 and (u35._playToken and u35._playToken.Alive == false));
        end;

        if v36 == "Animate" then
            local function doAnimate() -- Line: 310
                -- upvalues: genStillCurrent (copy), u40 (ref), EngineAttr (ref), u33 (copy), u32 (copy), u47 (copy), u45 (copy), u46 (ref), u34 (copy), u35 (copy)
                if not genStillCurrent() then
                    return;
                end;

                if u40 > 0 then
                    EngineAttr.write(u33, "AnimateLoop", true);
                    task.delay(u40, function() -- Line: 314
                        -- upvalues: u32 (ref), u47 (ref), u33 (ref), u45 (ref), u46 (ref), EngineAttr (ref)
                        if u32.Connection == nil or ((u32._engineGen or 0) ~= u47 or not u33.Parent) then
                            return;
                        end;

                        if not u45 and (u33:GetAttribute("_emitGen") or 0) ~= u46 then
                            return;
                        end;

                        if u33:GetAttribute("AnimateLoop") then
                            EngineAttr.write(u33, "AnimateLoop", false);
                        end;
                    end);
                end;

                u32:EmitAnimate(u33, u34, u35);
            end;

            if v39 > 0 then
                task.delay(v39, doAnimate);
            else
                doAnimate();
            end;

            return;
        end;

        local Config = TypeRegistry.getConfig(u33);

        local function doEmit() -- Line: 330
            -- upvalues: genStillCurrent (copy), EvenCycle (ref), Config (copy), u33 (copy), u32 (copy), u38 (ref), u34 (copy), Events (ref), u35 (copy), u40 (ref), u42 (copy), u43 (copy), u44 (copy), EngineAttr (ref)
            if not genStillCurrent() then
                return;
            end;

            local v48, v49 = EvenCycle.evenFlags(Config);
            local v50, v51, v52, v53;

            if v48 or v49 then
                local v54 = u33:GetAttribute("_EvenCycleId") or u33;
                local v55 = Config and Config:GetAttribute("Rate") or 10;
                v50, v51, v52, v53 = EvenCycle.advance(u32._evenCycleStore, v54, Config, v55, v48, v49);
            else
                v51 = 0;
                v52 = 1;
                v53 = 0;
                v50 = 1;
            end;

            for i = 1, u38 do
                u32:Emit(u33, u34, Events.withEvenOffset(u35, i, u38, v50, v51, v52, v53));
                local _ = i;
            end;

            if u40 > 0 then
                if u42 or (u43 or u44) then
                    u32:Enable(u33, u34, u40, u35);

                    return;
                end;

                EngineAttr.write(u33, "_PartIclePlaying", true);

                if Config then
                    EngineAttr.write(Config, "Enabled", true);
                end;

                u32:Enable(u33, u34, u40, u35);
                task.delay(u40, function() -- Line: 359
                    -- upvalues: genStillCurrent (ref), Config (ref), EngineAttr (ref), u33 (ref)
                    if not genStillCurrent() then
                        return;
                    end;

                    if Config and Config.Parent then
                        EngineAttr.write(Config, "Enabled", false);
                    end;

                    EngineAttr.write(u33, "_PartIclePlaying", nil);
                end);
            end;
        end;

        if v39 > 0 then
            task.delay(v39, doEmit);
        else
            doEmit();
        end;
    end;

    function u3.Enable(u56, u57, u58, p59, u60) -- Line: 373
        -- upvalues: EngineAttr (ref), TypeRegistry (ref), u3 (copy), u2 (ref), u1 (ref), success (ref), Selection (ref), Drive (ref), EvenCycle (ref), Events (ref)
        u56:_warnIfNotActivated("Enable");
        local Data = u56:GetData(u57);

        if not Data then
            return;
        end;

        if (u57:GetAttribute("EmissionMode") or "Emit") == "Animate" then
            EngineAttr.write(u57, "AnimateLoop", true);
            u56:EmitAnimate(u57, u58, u60);

            return;
        end;

        local u61 = p59 or (1 / 0);
        local Config = TypeRegistry.getConfig(u57);
        local v62;

        if u60 then
            v62 = u60.ChainCtx ~= nil;
        else
            v62 = u60;
        end;

        local u63;

        if u60 then
            u63 = u60._parentAlive ~= nil;
        else
            u63 = u60;
        end;

        local u64;

        if u60 then
            u64 = u60._playToken;
        else
            u64 = u60;
        end;

        local u65 = u64 ~= nil;
        local u66 = v62 or (u63 or u65);
        local u67 = u56._engineGen or 0;

        local function loopBody() -- Line: 397
            -- upvalues: u57 (copy), u66 (copy), u56 (copy), u67 (copy), u63 (copy), u60 (copy), u65 (copy), u64 (copy), u3 (ref), u61 (copy), Data (copy), u2 (ref), u1 (ref), success (ref), Selection (ref), Drive (ref), Config (copy), EvenCycle (ref), u58 (copy), Events (ref)
            local os_clock_ret = os.clock();
            local v68 = 0;
            local v69 = u57:GetAttribute("_EvenCycleId") or u57;

            while not (u66 and (u56._engineGen or 0) ~= u67 or (u63 and (u60._parentAlive and not u60._parentAlive[1]) or u65 and not u64.Alive)) do
                if not (u57 and u57.Parent) then
                    if not u66 then
                        u3.ActiveLoops[u57] = nil;

                        return;
                    end;

                    break;
                end;

                if u61 <= os.clock() - os_clock_ret then
                    if not u66 then
                        u3.ActiveLoops[u57] = nil;

                        return;
                    end;

                    break;
                end;

                if not (u66 or Data.CheckEnabled()) then
                    u3.ActiveLoops[u57] = nil;

                    return;
                end;

                local v70 = u2:Wait();

                if u66 and (u56._engineGen or 0) ~= u67 or (u63 and (u60._parentAlive and not u60._parentAlive[1]) or u65 and not u64.Alive) then
                    break;
                end;

                if u1 and (success and not (u3._focused or #Selection:Get() ~= 0 and (u3._unfocusedAt <= 0 or os.clock() - u3._unfocusedAt <= 600))) then
                    v68 = 0;
                else
                    local v71, v72 = Drive.stream(u60 and u60._containerDrive, Config and Config:GetAttribute("Rate") or 10, v70);

                    if v71 <= 0 then
                        v68 = 0;
                    else
                        local v73 = 1 / v71;
                        v68 = v68 + v72;
                        local v74 = (Data.PosXEven or (Data.PosYEven or Data.PosZEven)) == true;
                        local v75 = (Data.RotXEven or (Data.RotYEven or Data.RotZEven)) == true;
                        local v76;

                        if u57:GetAttribute("EmitMode") == "Burst" then
                            local v77 = tonumber(u57:GetAttribute("EmitCount")) or 1;
                            v76 = math.max(v77, 1);
                        else
                            v76 = 1;
                        end;

                        while v73 <= v68 do
                            v68 = v68 - v73;

                            if v76 > 1 then
                                local v78, v79, v80, v81;

                                if v74 or v75 then
                                    v78, v79, v80, v81 = EvenCycle.advance(u56._evenCycleStore, v69, Config, v71, v74, v75);
                                else
                                    v79 = 0;
                                    v80 = 1;
                                    v81 = 0;
                                    v78 = 1;
                                end;

                                for i = 1, v76 do
                                    u56:Emit(u57, u58, Events.withEvenOffset(u60, i, v76, v78, v79, v80, v81));
                                    local _ = i;
                                end;
                            elseif v74 or v75 then
                                local v82, v83, v84, v85 = EvenCycle.advance(u56._evenCycleStore, v69, Config, v71, v74, v75);
                                u56:Emit(u57, u58, Events.withEvenOffset(u60, 1, 1, v82, v83, v84, v85));
                            else
                                u56:Emit(u57, u58, u60);
                            end;
                        end;
                    end;
                end;
            end;
        end;

        if u66 then
            local task_spawn_ret = task.spawn(function() -- Line: 470
                -- upvalues: loopBody (copy), u3 (ref), u57 (copy)
                loopBody();
                local coroutine_running_ret = coroutine.running();
                local v86 = u3.ActiveChainLoops[u57];

                if not v86 then
                    return;
                end;

                for i = #v86, 1, -1 do
                    if v86[i] == coroutine_running_ret then
                        table.remove(v86, i);
                        break;
                    end;

                    local _ = i;
                end;

                if #v86 == 0 then
                    u3.ActiveChainLoops[u57] = nil;
                end;
            end);
            local v87 = u3.ActiveChainLoops[u57];

            if not v87 then
                v87 = {};
                u3.ActiveChainLoops[u57] = v87;
            end;

            table.insert(v87, task_spawn_ret);

            if u65 then
                table.insert(u64.Loops, task_spawn_ret);
            end;
        else
            if u3.ActiveLoops[u57] then
                task.cancel(u3.ActiveLoops[u57]);
            end;

            u3.ActiveLoops[u57] = task.spawn(loopBody);
        end;
    end;

    function u3._makeAliveCheck(u88) -- Line: 499
        local u89 = u88._engineGen or 0;

        return function() -- Line: 501
            -- upvalues: u88 (copy), u89 (copy)
            local v90;

            if u88.Connection == nil then
                v90 = false;
            else
                v90 = (u88._engineGen or 0) == u89;
            end;

            return v90;
        end;
    end;

    function u3._fireAnimateCycleRestartEvents(p91, p92) -- Line: 507
        -- upvalues: Events (ref)
        if p92.Events and p92.Events.OnHit then
            p92.LastHitCheckPos = Events.getWorldPosition(p92);
            p92.LastHitCheckTime = nil;
        end;

        if p92.Events and p92.Events.OnEmit then
            local v93 = Events.makePayload(p91, p92, "OnEmit", {
                EmitIndex = nil,
                ChainCtx = p92.EventChainCtx
            });
            Events.fire(p91, p92, "OnEmit", p92.EventChainCtx, v93);
        end;
    end;

    function u3._killParticle(p94, p95, p96) -- Line: 520
        -- upvalues: EngineAttr (ref), TypeRegistry (ref)
        p95._killedManually = true;
        p95._fireOnDeathOverride = (p96 or {}).fireOnDeath == true;
        p95._forceDead = true;
        p95.PartLife = 0;
        local u97 = p95.IsAnimate and p95._sourceItem;

        if u97 then
            pcall(function() -- Line: 529
                -- upvalues: EngineAttr (ref), u97 (copy), TypeRegistry (ref)
                EngineAttr.write(u97, "AnimateLoop", false);
                local Config = TypeRegistry.getConfig(u97);

                if Config then
                    EngineAttr.write(Config, "Enabled", false);
                end;
            end);
        end;
    end;
end;