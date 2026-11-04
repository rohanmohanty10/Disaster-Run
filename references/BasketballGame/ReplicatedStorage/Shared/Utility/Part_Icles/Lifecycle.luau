 
 

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
local Pool = require(script.Parent.Pool);

return function(u3) -- Line: 21
    -- upvalues: success (copy), TypeRegistry (copy), Particles (copy), Events (copy), u2 (copy), u1 (copy), Selection (copy), Pool (copy)
    local function cancelAnimation(p4, p5) -- Line: 24
        local u6 = p4.ActiveAnimates[p5];

        if not u6 then
            return;
        end;

        if (u6.Type == "Beam" or (u6.Type == "Highlight" or u6.Type == "TrailEmitter")) and (u6.VisualPart and u6.VisualPart.Parent) then
            local u7 = u6.BeamSnapshot or (u6.HighlightSnapshot or u6.TrailEmitterSnapshot);

            if u7 then
                pcall(function() -- Line: 34
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
                    pcall(function() -- Line: 44
                        -- upvalues: u6 (copy)
                        u6.VisualPart:ScaleTo(u6.InitialScale);
                    end);
                end;
            elseif u6.Type ~= "Beam" then
                u6.VisualPart.CFrame = u6.InitialAnchorCF;
            end;
        end;

        if (u6.Type == "Part" or u6.Type == "Attachment") and (u6.VisualPart and u6.VisualPart.Parent) then
            pcall(function() -- Line: 52
                -- upvalues: u6 (copy)
                u6.VisualPart.Transparency = 1;
                local v8 = u6.HasDecal and u6.VisualPart:FindFirstChildOfClass("Decal");

                if v8 then
                    v8.Transparency = 1;
                end;
            end);
        end;

        if (u6.Type == "Screen" or u6.Type == "ImageLabel") and u6.VisualPart then
            pcall(function() -- Line: 61
                -- upvalues: u6 (copy)
                u6.VisualPart:Destroy();
            end);
        end;

        if u6._scaleMapKeys and p4._parentScaleMap then
            for _, v in ipairs(u6._scaleMapKeys) do
                p4._parentScaleMap[v] = nil;
            end;
        end;

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

    function u3._cancelAnimation(p10, p11) -- Line: 81
        -- upvalues: cancelAnimation (copy)
        cancelAnimation(p10, p11);
    end;

    function u3.Disable(p12, u13) -- Line: 89
        -- upvalues: success (ref), u3 (copy), cancelAnimation (copy), TypeRegistry (ref), Particles (ref)
        if not u13 then
            return;
        end;

        local v14 = success and (game:GetService("RunService"):IsEdit() and game:GetService("ChangeHistoryService")) or nil;

        if v14 then
            v14:SetWaypoint("Part-Icles: Before Disable");
        end;

        if u3.ActiveLoops[u13] then
            task.cancel(u3.ActiveLoops[u13]);
            u3.ActiveLoops[u13] = nil;
        end;

        local v15 = u3.ActiveChainLoops[u13];

        if v15 then
            for _, v in ipairs(v15) do
                pcall(task.cancel, v);
            end;

            u3.ActiveChainLoops[u13] = nil;
        end;

        u13:SetAttribute("AnimateLoop", false);
        local u16 = (u13:GetAttribute("_emitGen") or 0) + 1;
        pcall(function() -- Line: 111
            -- upvalues: u13 (copy), u16 (copy)
            u13:SetAttribute("_emitGen", u16);
        end);
        cancelAnimation(p12, u13);
        local Config = TypeRegistry.getConfig(u13);

        if Config then
            Config:SetAttribute("Enabled", false);
        end;

        pcall(function() -- Line: 116
            -- upvalues: u13 (copy)
            u13:SetAttribute("_PartIclePlaying", nil);
        end);
        pcall(function() -- Line: 117
            -- upvalues: u13 (copy)
            u13:SetAttribute("_evenRollingIdx", nil);
        end);

        for _, descendant in ipairs(u13:GetDescendants()) do
            if descendant:GetAttribute("Transformed") then
                p12:Disable(descendant);
            elseif descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") then
                Particles.CancelNative(descendant);
            elseif descendant:IsA("Beam") or descendant:IsA("Highlight") then
                pcall(function() -- Line: 130
                    -- upvalues: descendant (copy)
                    descendant.Enabled = false;
                end);
            end;
        end;

        local ActiveEmits = p12.ActiveEmits;

        for i = #ActiveEmits, 1, -1 do
            local v17 = ActiveEmits[i];
            local v18;

            if v17 and v17._sourceItem == u13 then
                if v17.VisualPart and v17.VisualPart.Parent then
                    p12:_releaseOrDestroy(v17, v17.VisualPart);
                end;

                if v17._scaleMapKeys and p12._parentScaleMap then
                    v18 = i;

                    for _, v in ipairs(v17._scaleMapKeys) do
                        p12._parentScaleMap[v] = nil;
                    end;
                else
                    v18 = i;
                end;

                local v19 = #ActiveEmits;

                if v18 < v19 then
                    ActiveEmits[v18] = ActiveEmits[v19];
                end;

                ActiveEmits[v19] = nil;
            else
                v18 = i;
            end;
        end;

        if p12._lingerByItem and p12._lingerByItem[u13] then
            for _, v in ipairs(p12._lingerByItem[u13]) do
                if v then
                    local u20 = false;
                    pcall(function() -- Line: 160
                        -- upvalues: u20 (ref), v (copy)
                        u20 = v:GetAttribute("_lingerCounted") == true;
                    end);

                    if u20 then
                        p12._lingerVisualCount = math.max(0, (p12._lingerVisualCount or 0) - 1);
                        pcall(function() -- Line: 163
                            -- upvalues: v (copy)
                            v:SetAttribute("_lingerCounted", nil);
                        end);
                    end;

                    if v.Parent then
                        pcall(function() -- Line: 166
                            -- upvalues: v (copy)
                            v:Destroy();
                        end);
                    end;
                end;
            end;

            p12._lingerByItem[u13] = nil;
        end;

        if v14 then
            v14:SetWaypoint("Part-Icles: Disable");
        end;
    end;

    local function _hasTransformedAncestor(p21, p22) -- Line: 176
        local Parent = p21.Parent;

        while Parent and Parent ~= p22 do
            if Parent:GetAttribute("Transformed") then
                return true;
            end;

            Parent = Parent.Parent;
        end;

        return false;
    end;

    function u3.AbsoluteEnable(p23, u24, p25) -- Line: 192
        -- upvalues: TypeRegistry (ref), _hasTransformedAncestor (copy)
        if not u24 then
            return;
        end;

        if u24:GetAttribute("Transformed") then
            pcall(function() -- Line: 201
                -- upvalues: u24 (copy)
                u24:SetAttribute("_PartIclePlaying", true);
            end);
            local Config = TypeRegistry.getConfig(u24);

            if Config then
                Config:SetAttribute("Enabled", true);
            end;

            p23:Enable(u24, nil, (1 / 0));

            return;
        end;

        if u24:IsA("ParticleEmitter") or (u24:IsA("Trail") or (u24:IsA("Beam") or u24:IsA("Highlight"))) then
            if p25 then
                return;
            end;

            pcall(function() -- Line: 210
                -- upvalues: u24 (copy)
                u24.Enabled = true;
            end);

            return;
        end;

        local v26;

        if u24:IsA("BasePart") or u24:IsA("Attachment") then
            v26 = not p25;
        else
            v26 = u24:IsA("Model") and not p25;
        end;

        if v26 then
            for _, descendant in ipairs(u24:GetDescendants()) do
                if (descendant:IsA("ParticleEmitter") or (descendant:IsA("Trail") or (descendant:IsA("Beam") or descendant:IsA("Highlight")))) and not (descendant:GetAttribute("Transformed") or _hasTransformedAncestor(descendant, u24)) then
                    pcall(function() -- Line: 219
                        -- upvalues: descendant (copy)
                        descendant.Enabled = true;
                    end);
                end;
            end;
        end;

        local v27 = v26 or p25;

        for _, child in u24:GetChildren() do
            if not (u24:IsA("BasePart") and (child:IsA("BasePart") and not child:GetAttribute("Transformed"))) then
                p23:AbsoluteEnable(child, v27);
            end;
        end;
    end;

    function u3.AbsoluteDisable(p28, u29, p30) -- Line: 237
        -- upvalues: _hasTransformedAncestor (copy)
        if not u29 then
            return;
        end;

        if u29:GetAttribute("Transformed") then
            p28:Disable(u29);

            return;
        end;

        if u29:IsA("ParticleEmitter") or (u29:IsA("Trail") or (u29:IsA("Beam") or u29:IsA("Highlight"))) then
            if p30 then
                return;
            end;

            pcall(function() -- Line: 245
                -- upvalues: u29 (copy)
                u29.Enabled = false;
            end);

            return;
        end;

        local v31;

        if u29:IsA("BasePart") or u29:IsA("Attachment") then
            v31 = not p30;
        else
            v31 = u29:IsA("Model") and not p30;
        end;

        if v31 then
            for _, descendant in ipairs(u29:GetDescendants()) do
                if (descendant:IsA("ParticleEmitter") or (descendant:IsA("Trail") or (descendant:IsA("Beam") or descendant:IsA("Highlight")))) and not (descendant:GetAttribute("Transformed") or _hasTransformedAncestor(descendant, u29)) then
                    pcall(function() -- Line: 254
                        -- upvalues: descendant (copy)
                        descendant.Enabled = false;
                    end);
                end;
            end;
        end;

        local v32 = v31 or p30;

        for _, child in u29:GetChildren() do
            if not (u29:IsA("BasePart") and (child:IsA("BasePart") and not child:GetAttribute("Transformed"))) then
                p28:AbsoluteDisable(child, v32);
            end;
        end;
    end;

    function u3.EmitAnimate(p33, p34, p35, p36) -- Line: 268
        -- upvalues: cancelAnimation (copy)
        p33:_warnIfNotActivated("EmitAnimate");

        if (p34:IsA("BlurEffect") or (p34:IsA("BloomEffect") or p34:IsA("ColorCorrectionEffect") or (p34:IsA("Atmosphere") or p34:IsA("ImageLabel")))) and p33.ActiveAnimates[p34] then
            return;
        end;

        cancelAnimation(p33, p34);

        if p34:IsA("Beam") then
            p33:EmitBeamAnimate(p34, p35, p36);

            return;
        end;

        if p34:IsA("Trail") and p34:FindFirstChild("PartIcleProperties") then
            p33:EmitTrailAnimate(p34, p35, p36);

            return;
        end;

        if p34:IsA("Highlight") then
            p33:EmitHighlightAnimate(p34, p35, p36);

            return;
        end;

        if p34:IsA("Attachment") then
            p33:EmitAttachmentAnimate(p34, p35, p36);

            return;
        end;

        if p34:IsA("Model") then
            p33:EmitModelAnimate(p34, p35, p36);

            return;
        end;

        if p34:IsA("BlurEffect") then
            p33:EmitBlurAnimate(p34, p35, p36);

            return;
        end;

        if p34:IsA("BloomEffect") then
            p33:EmitBloomAnimate(p34, p35, p36);

            return;
        end;

        if p34:IsA("ColorCorrectionEffect") then
            p33:EmitColorCorrectionAnimate(p34, p35, p36);

            return;
        end;

        if p34:IsA("Atmosphere") then
            p33:EmitAtmosphereAnimate(p34, p35, p36);

            return;
        end;

        if p34:IsA("ImageLabel") then
            p33:EmitImageLabelAnimate(p34, p35, p36);

            return;
        end;

        if p34:IsA("BasePart") then
            p33:EmitPartAnimate(p34, p35, p36);
        end;
    end;

    function u3.EnableEmit(u37, u38, u39, u40) -- Line: 291
        -- upvalues: Particles (ref), TypeRegistry (ref), Events (ref)
        u37:_warnIfNotActivated("EnableEmit");
        local v41 = u38:GetAttribute("EmissionMode") or "Emit";
        local Attribute = u38:GetAttribute("EmitCount");
        local u42 = Attribute == nil and 1 or Attribute;
        local v43 = u38:GetAttribute("EmitDelay") or 0;
        local u44 = Particles.parseDuration(u38:GetAttribute("EmitDuration")) or 0;

        if v41 ~= "Animate" and (u42 <= 0 and u44 <= 0) then
            return;
        end;

        local u45;

        if u40 then
            u45 = u40.ChainCtx ~= nil;
        else
            u45 = u40;
        end;

        local u46 = u45 or u44 <= 0;
        local u47;

        if u46 then
            u47 = nil;
        else
            u47 = (u38:GetAttribute("_emitGen") or 0) + 1;
            pcall(function() -- Line: 309
                -- upvalues: u38 (copy), u47 (ref)
                u38:SetAttribute("_emitGen", u47);
            end);
        end;

        local u48 = u37._engineGen or 0;

        local function genStillCurrent() -- Line: 313
            -- upvalues: u37 (copy), u48 (copy), u38 (copy), u46 (copy), u47 (ref), u40 (copy)
            if u37.Connection == nil then
                return false;
            end;

            if (u37._engineGen or 0) ~= u48 then
                return false;
            end;

            if not u38.Parent then
                return false;
            end;

            if u46 or (u38:GetAttribute("_emitGen") or 0) == u47 then
                return not (u40 and (u40._parentAlive and not u40._parentAlive[1]));
            end;

            return false;
        end;

        if v41 == "Animate" then
            local function doAnimate() -- Line: 326
                -- upvalues: u37 (copy), u48 (copy), u38 (copy), u46 (copy), u47 (ref), u40 (copy), u44 (copy), u39 (copy)
                local v49;

                if u37.Connection == nil or ((u37._engineGen or 0) ~= u48 or not (u38.Parent and (u46 or (u38:GetAttribute("_emitGen") or 0) == u47))) then
                    v49 = false;
                else
                    v49 = not (u40 and (u40._parentAlive and not u40._parentAlive[1]));
                end;

                if not v49 then
                    return;
                end;

                if u44 > 0 then
                    u38:SetAttribute("AnimateLoop", true);
                    task.delay(u44, function() -- Line: 330
                        -- upvalues: u37 (ref), u48 (ref), u38 (ref), u46 (ref), u47 (ref), u40 (ref)
                        local v50;

                        if u37.Connection == nil or ((u37._engineGen or 0) ~= u48 or not (u38.Parent and (u46 or (u38:GetAttribute("_emitGen") or 0) == u47))) then
                            v50 = false;
                        else
                            v50 = not (u40 and (u40._parentAlive and not u40._parentAlive[1]));
                        end;

                        if not v50 then
                            return;
                        end;

                        if u38:GetAttribute("AnimateLoop") then
                            u38:SetAttribute("AnimateLoop", false);
                        end;
                    end);
                end;

                u37:EmitAnimate(u38, u39, u40);
            end;

            if v43 > 0 then
                task.delay(v43, doAnimate);
            else
                doAnimate();
            end;

            return;
        end;

        local Config = TypeRegistry.getConfig(u38);

        local function doEmit() -- Line: 343
            -- upvalues: u37 (copy), u48 (copy), u38 (copy), u46 (copy), u47 (ref), u40 (copy), u42 (copy), u39 (copy), Events (ref), u44 (copy), u45 (copy), Config (copy)
            local v51;

            if u37.Connection == nil or ((u37._engineGen or 0) ~= u48 or not (u38.Parent and (u46 or (u38:GetAttribute("_emitGen") or 0) == u47))) then
                v51 = false;
            else
                v51 = not (u40 and (u40._parentAlive and not u40._parentAlive[1]));
            end;

            if not v51 then
                return;
            end;

            for i = 1, u42 do
                u37:Emit(u38, u39, Events.withEmitIndexAndCount(u40, i, u42));
                local _ = i;
            end;

            if u44 > 0 then
                if u45 then
                    u37:Enable(u38, u39, u44, u40);

                    return;
                end;

                u38:SetAttribute("_PartIclePlaying", true);

                if Config then
                    Config:SetAttribute("Enabled", true);
                end;

                u37:Enable(u38, u39, u44, u40);
                task.delay(u44, function() -- Line: 360
                    -- upvalues: u37 (ref), u48 (ref), u38 (ref), u46 (ref), u47 (ref), u40 (ref), Config (ref)
                    local v52;

                    if u37.Connection == nil or ((u37._engineGen or 0) ~= u48 or not (u38.Parent and (u46 or (u38:GetAttribute("_emitGen") or 0) == u47))) then
                        v52 = false;
                    else
                        v52 = not (u40 and (u40._parentAlive and not u40._parentAlive[1]));
                    end;

                    if not v52 then
                        return;
                    end;

                    if Config and Config.Parent then
                        Config:SetAttribute("Enabled", false);
                    end;

                    u38:SetAttribute("_PartIclePlaying", nil);
                end);
            end;
        end;

        if v43 > 0 then
            task.delay(v43, doEmit);
        else
            doEmit();
        end;
    end;

    function u3.Enable(u53, u54, u55, p56, u57) -- Line: 374
        -- upvalues: TypeRegistry (ref), u3 (copy), u2 (ref), u1 (ref), success (ref), Selection (ref), Events (ref)
        u53:_warnIfNotActivated("Enable");
        local Data = u53:GetData(u54);

        if not Data then
            return;
        end;

        if (u54:GetAttribute("EmissionMode") or "Emit") == "Animate" then
            u54:SetAttribute("AnimateLoop", true);
            u53:EmitAnimate(u54, u55, u57);

            return;
        end;

        local u58 = p56 or (1 / 0);
        local Config = TypeRegistry.getConfig(u54);
        local u59;

        if u57 then
            u59 = u57.ChainCtx ~= nil;
        else
            u59 = u57;
        end;

        local u60 = u53._engineGen or 0;

        local function loopBody() -- Line: 389
            -- upvalues: u59 (copy), u53 (copy), u60 (copy), u54 (copy), u3 (ref), u58 (copy), Data (copy), u2 (ref), u1 (ref), success (ref), Selection (ref), Config (copy), u55 (copy), Events (ref), u57 (copy)
            local os_clock_ret = os.clock();
            local v61 = 0;

            while not u59 or (u53._engineGen or 0) == u60 do
                if not (u54 and u54.Parent) then
                    if not u59 then
                        u3.ActiveLoops[u54] = nil;

                        return;
                    end;

                    break;
                end;

                if u58 <= os.clock() - os_clock_ret then
                    if not u59 then
                        u3.ActiveLoops[u54] = nil;

                        return;
                    end;

                    break;
                end;

                if not (u59 or Data.CheckEnabled()) then
                    u3.ActiveLoops[u54] = nil;

                    return;
                end;

                local v62 = u2:Wait();

                if u1 and (success and not (u3._focused or #Selection:Get() ~= 0 and (u3._unfocusedAt <= 0 or os.clock() - u3._unfocusedAt <= 600))) then
                    v61 = 0;
                else
                    local v63 = Config and Config:GetAttribute("Rate") or 10;

                    if v63 <= 0 then
                        v61 = 0;
                    else
                        local v64 = 1 / v63;
                        v61 = v61 + v62;
                        local v65;

                        if (Data.RotXEven or Data.RotYEven or (Data.RotZEven or Data.PosXEven or (Data.PosYEven or Data.PosZEven))) == true then
                            v65 = true;
                        else
                            v65 = false;
                        end;

                        while v64 <= v61 do
                            v61 = v61 - v64;

                            if v65 then
                                local u66 = (u54:GetAttribute("_evenRollingIdx") or 0) % 12 + 1;
                                pcall(function() -- Line: 422
                                    -- upvalues: u54 (ref), u66 (copy)
                                    u54:SetAttribute("_evenRollingIdx", u66);
                                end);
                                u53:Emit(u54, u55, Events.withEmitIndexAndCount(u57, u66, 12));
                            else
                                u53:Emit(u54, u55, u57);
                            end;
                        end;
                    end;
                end;
            end;
        end;

        if not u59 then
            if u3.ActiveLoops[u54] then
                task.cancel(u3.ActiveLoops[u54]);
            end;

            u3.ActiveLoops[u54] = task.spawn(loopBody);

            return;
        end;

        local task_spawn_ret = task.spawn(function() -- Line: 432
            -- upvalues: loopBody (copy), u3 (ref), u54 (copy)
            loopBody();
            local coroutine_running_ret = coroutine.running();
            local v67 = u3.ActiveChainLoops[u54];

            if not v67 then
                return;
            end;

            for i = #v67, 1, -1 do
                if v67[i] == coroutine_running_ret then
                    table.remove(v67, i);
                    break;
                end;

                local _ = i;
            end;

            if #v67 == 0 then
                u3.ActiveChainLoops[u54] = nil;
            end;
        end);
        local v68 = u3.ActiveChainLoops[u54];

        if not v68 then
            v68 = {};
            u3.ActiveChainLoops[u54] = v68;
        end;

        table.insert(v68, task_spawn_ret);
    end;

    local u69 = {};
    local u70 = false;

    function u3.EnableEmitAt(p71, p72, p73, p74) -- Line: 454
        -- upvalues: u69 (copy), u70 (ref)
        if not (p72 and (p72.Parent and p73)) then
            return;
        end;

        if not (p72:IsA("BasePart") or (p72:IsA("Attachment") or p72:IsA("Model"))) then
            local ClassName = p72.ClassName;

            if not u69[ClassName] then
                u69[ClassName] = true;
                warn(("[Part-Icles] EnableEmitAt does not support %s targets (origin override is BasePart/Attachment/Model only). Emit skipped."):format(ClassName));
            end;

            return;
        end;

        if (p72:GetAttribute("EmissionMode") or "Emit") == "Animate" then
            if not u70 then
                u70 = true;
                warn("[Part-Icles] EnableEmitAt does not support Animate-mode targets in v1; use EmitMode=AtTarget for Animate sources. Emit skipped.");
            end;

            return;
        end;

        local v75 = p74 or {};
        local v76 = v75.Link ~= nil;
        local v77 = {
            ChainCtx = v75.ChainCtx,
            EventOriginCF = p73,
            EventOriginResolver = v75.OriginResolver,
            UseFullOrigin = v75.UseFullOrigin ~= false
        };
        local v78;

        if v75.IgnoreLink == true then
            v78 = not v76;
        else
            v78 = false;
        end;

        v77.IgnoreLink = v78;
        v77.Link = v75.Link;
        v77.LinkMode = v75.LinkMode;
        v77.EmitParent = v75.EmitParent;
        p71:EnableEmit(p72, v75.Link, v77);
    end;

    function u3._registerEmit(p79, p80, p81) -- Line: 491
        -- upvalues: Events (ref)
        if (p79.MAX_ACTIVE_PARTICLES or 1000) <= #p79.ActiveEmits + (p79._lingerVisualCount or 0) then
            local v82 = p80.IsAnimate and ((p80.Type == "Part" or (p80.Type == "Attachment" or p80.Type == "Beam")) and true or p80.Type == "Model");

            if p80.IsAnimate and p80._sourceItem then
                p79.ActiveAnimates[p80._sourceItem] = nil;
            end;

            if not v82 and (p80.VisualPart and p80.VisualPart.Parent) then
                p79:_releaseOrDestroy(p80, p80.VisualPart);
            end;

            return;
        end;

        p80.EventChainCtx = p81 and p81.ChainCtx or (p80.EventChainCtx or Events.newChainCtx());
        table.insert(p79.ActiveEmits, p80);

        if p80.Events and p80.Events.OnHit then
            p80.LastHitCheckPos = Events.getWorldPosition(p80);
            p80.HitParams = Events.makeHitParams(p80);
            p80._hitFired = false;
        end;

        if p80.Events and p80.Events.OnEmit then
            local v83 = Events.makePayload(p79, p80, "OnEmit", p81);
            Events.fire(p79, p80, "OnEmit", p80.EventChainCtx, v83);
        end;
    end;

    function u3._fireOnDeath(p84, p85) -- Line: 526
        -- upvalues: Events (ref)
        if p85.Events and (p85.Events.OnDeath and (not p85._killedManually or p85._fireOnDeathOverride)) then
            Events.fire(p84, p85, "OnDeath", p85.EventChainCtx, nil);
        end;
    end;

    function u3._fireOnDestruction(p86, p87, p88) -- Line: 534
        -- upvalues: Events (ref)
        if p87.Events and (p87.Events.OnDestruction and (p88 and p88.Parent)) then
            Events.fire(p86, p87, "OnDestruction", p87.EventChainCtx, nil);
        end;
    end;

    function u3._releaseOrDestroy(p89, p90, u91) -- Line: 541
        -- upvalues: TypeRegistry (ref), Pool (ref)
        if not u91 then
            return;
        end;

        if not u91.Parent then
            return;
        end;

        if p90.IsAnimate or not (p90._sourceRT and p90._poolKind) then
            pcall(function() -- Line: 545
                -- upvalues: u91 (copy)
                u91:Destroy();
            end);

            return;
        end;

        local v92 = nil;
        local _sourceItem = p90._sourceItem;

        if _sourceItem and _sourceItem.Parent then
            local Config = TypeRegistry.getConfig(_sourceItem);

            if Config then
                v92 = Config:GetAttribute("Rate");
            end;
        end;

        Pool.release(u91, p90._sourceRT, p90._poolKind, v92);
    end;

    function u3._makeAliveCheck(u93) -- Line: 559
        local u94 = u93._engineGen or 0;

        return function() -- Line: 561
            -- upvalues: u93 (copy), u94 (copy)
            local v95;

            if u93.Connection == nil then
                v95 = false;
            else
                v95 = (u93._engineGen or 0) == u94;
            end;

            return v95;
        end;
    end;

    function u3._fireAnimateCycleRestartEvents(p96, p97) -- Line: 567
        -- upvalues: Events (ref)
        if p97.Events and p97.Events.OnHit then
            p97.LastHitCheckPos = Events.getWorldPosition(p97);
            p97.LastHitCheckTime = nil;
        end;

        if p97.Events and p97.Events.OnEmit then
            local v98 = Events.makePayload(p96, p97, "OnEmit", {
                EmitIndex = nil,
                ChainCtx = p97.EventChainCtx
            });
            Events.fire(p96, p97, "OnEmit", p97.EventChainCtx, v98);
        end;
    end;

    function u3._killParticle(p99, p100, p101) -- Line: 580
        -- upvalues: TypeRegistry (ref)
        p100._killedManually = true;
        p100._fireOnDeathOverride = (p101 or {}).fireOnDeath == true;
        p100._forceDead = true;
        p100.PartLife = 0;
        local u102 = p100.IsAnimate and p100._sourceItem;

        if u102 then
            pcall(function() -- Line: 589
                -- upvalues: u102 (copy), TypeRegistry (ref)
                u102:SetAttribute("AnimateLoop", false);
                local Config = TypeRegistry.getConfig(u102);

                if Config then
                    Config:SetAttribute("Enabled", false);
                end;
            end);
        end;
    end;
end;