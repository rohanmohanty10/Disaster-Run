 

 

local Particles = require(script.Parent.Particles);
local PlayHandle = require(script.Parent.PlayHandle);
local EventsSchema = require(script.Parent.EventsSchema);
local PartConstants = require(script.Parent.PartConstants);
local Log = require(script.Parent.Log);
local Duration = require(script.Parent.Duration);
local u1 = {};

local function warnOnce(p2, p3) -- Line: 15
    -- upvalues: u1 (copy), Log (copy)
    if u1[p2] then
        return;
    end;

    u1[p2] = true;
    Log.warn(p3);
end;

local function warnInPlace(p4) -- Line: 23
    -- upvalues: EventsSchema (copy), u1 (copy), Log (copy)
    local v5 = EventsSchema.emitCapabilityReason(p4);

    if not v5 then
        return;
    end;

    local v6 = p4.ClassName .. ":" .. tostring(p4:GetAttribute("EmissionMode"));
    local v7 = ("[Part-Icles] EmitAt: %s emits in place: %s"):format(p4:GetFullName(), v5);

    if u1[v6] then
        return;
    end;

    u1[v6] = true;
    Log.warn(v7);
end;

local function resolveOrigin(u8, p9) -- Line: 33
    -- upvalues: PartConstants (copy)
    local v10 = typeof(u8);
    local v11 = p9.UseFullOrigin ~= false;

    if v10 == "CFrame" then
        return u8, p9.OriginResolver, v11;
    end;

    if v10 == "Vector3" then
        return CFrame.new(u8), p9.OriginResolver, false;
    end;

    if v10 == "Instance" and (u8:IsA("PVInstance") or (u8:IsA("Attachment") or u8:IsA("Camera"))) then
        local v12 = p9.OriginResolver or function() -- Line: 39
            -- upvalues: u8 (copy), PartConstants (ref)
            if u8.Parent == nil then
                return nil;
            end;

            return PartConstants.resolveLinkCFrame(u8);
        end;

        return PartConstants.resolveLinkCFrame(u8), v12, v11;
    end;

    if v10 == "Instance" then
        v10 = u8.ClassName or v10;
    end;

    return nil, ("origin must be a CFrame, a Vector3 or an instance with a position (got %s)"):format(v10);
end;

local function playLink(p13) -- Line: 50
    if p13.Persist == true then
        return nil;
    end;

    local Link = p13.Link;

    if Link == "camera" then
        return workspace.CurrentCamera;
    end;

    if typeof(Link) == "Instance" then
        return Link;
    end;

    return nil;
end;

local function buildOverrides(p14) -- Line: 60
    local v15 = {};

    if p14.Persist ~= true then
        if p14.LinkMode == nil then
            if p14.Link ~= nil then
                v15.LinkMode = "Weld";
            end;
        else
            v15.LinkMode = p14.LinkMode;
        end;

        if p14.EmitParent ~= nil then
            v15.EmitParent = p14.EmitParent;
        end;
    end;

    if typeof(p14.Count) == "number" then
        v15.Count = p14.Count;
    end;

    if typeof(p14.Delay) == "number" then
        v15.Delay = p14.Delay;
    end;

    if p14.Duration ~= nil then
        v15.Duration = p14.Duration;
    end;

    if next(v15) == nil then
        return nil;
    end;

    return v15;
end;

local function persistAuthoring(p16, p17, p18) -- Line: 78
    if p18.Link ~= nil then
        p16:SetLink(p17, p18.Link, p18.LinkMode or "Weld");
    end;

    if p18.EmitParent ~= nil then
        p16:SetEmitParent(p17, p18.EmitParent);
    end;
end;

return function(p19) -- Line: 83
    -- upvalues: u1 (copy), Log (copy), resolveOrigin (copy), buildOverrides (copy), Duration (copy), PlayHandle (copy), warnInPlace (copy), Particles (copy)
    local function beginPlay(p20, p21, p22, p23, p24) -- Line: 86
        -- upvalues: u1 (ref), Log (ref), resolveOrigin (ref), buildOverrides (ref), Duration (ref), PlayHandle (ref)
        p20:_warnIfNotActivated(p24);
        local v25 = p23 or {};

        if not (p21 and p21.Parent) then
            local v26 = p24 .. ":item";
            local v27 = ("[Part-Icles] %s: item is nil or has no parent; nothing emitted."):format(p24);

            if not u1[v26] then
                u1[v26] = true;
                Log.warn(v27);
            end;

            return nil;
        end;

        local v28, v29, v30 = resolveOrigin(p22, v25);

        if not v28 then
            local v31 = p24 .. ":" .. tostring(v29);
            local v32 = ("[Part-Icles] %s: %s; nothing emitted."):format(p24, (tostring(v29)));

            if not u1[v31] then
                u1[v31] = true;
                Log.warn(v32);
            end;

            return nil;
        end;

        local v33 = buildOverrides(v25);
        local v34 = Duration.computeMaxDuration(p21, 0, v33);
        local v35 = {
            Alive = true,
            Loops = {},
            Clones = {},
            Duration = v34
        };
        local v36 = {
            options = v25,
            originCF = v28,
            resolver = v29,
            fullPose = v30,
            overrides = v33,
            token = v35,
            handle = PlayHandle.new(p20, v35),
            totalDur = v34
        };
        local v37;

        if v25.Persist == true then
            v37 = nil;
        else
            v37 = v25.Link;

            if v37 == "camera" then
                v37 = workspace.CurrentCamera;
            elseif typeof(v37) ~= "Instance" then
                v37 = nil;
            end;
        end;

        v36.link = v37;
        local v38;

        if v25.LinkOverride == true then
            v38 = v25.Link ~= nil;
        else
            v38 = false;
        end;

        v36.linkWins = v38;

        return v36;
    end;

    local function buildCtx(p39, p40, p41) -- Line: 122
        local options = p39.options;
        local v42 = {
            ChainCtx = options.ChainCtx,
            UseFullOrigin = p39.fullPose
        };
        local v43;

        if options.IgnoreLink == true then
            v43 = p39.link == nil;
        else
            v43 = false;
        end;

        v42.IgnoreLink = v43;
        v42.EventDriven = options.EventDriven == true;
        v42.Overrides = p39.overrides;
        v42._playToken = p39.token;
        v42._playLink = p39.link;

        if not p39.linkWins then
            v42.EventOriginCF = p40;
            v42.EventOriginResolver = p41;
        end;

        return v42;
    end;

    local function emitTransformedRoot(p44, p45, p46) -- Line: 143
        -- upvalues: warnInPlace (ref), buildCtx (copy)
        warnInPlace(p45);

        if p46.options.Persist == true then
            local options = p46.options;

            if options.Link ~= nil then
                p44:SetLink(p45, options.Link, options.LinkMode or "Weld");
            end;

            if options.EmitParent ~= nil then
                p44:SetEmitParent(p45, options.EmitParent);
            end;
        end;

        p44:EnableEmit(p45, p46.link, (buildCtx(p46, p46.originCF, p46.resolver)));

        return p46.handle, p46.totalDur;
    end;

    function p19.EnableEmitAt(p47, p48, p49, p50) -- Line: 151
        -- upvalues: beginPlay (copy), PlayHandle (ref), u1 (ref), Log (ref), emitTransformedRoot (copy)
        local v51 = beginPlay(p47, p48, p49, p50, "EnableEmitAt");

        if not v51 then
            return PlayHandle.inert(p47), 0;
        end;

        if p48:GetAttribute("Transformed") then
            return emitTransformedRoot(p47, p48, v51);
        end;

        local v52 = "EnableEmitAt:" .. p48.ClassName;
        local v53 = ("[Part-Icles] EnableEmitAt: %s is not a Part-Icle; use AbsoluteEmitAt for containers and raw emitters. Nothing emitted."):format(p48:GetFullName());

        if not u1[v52] then
            u1[v52] = true;
            Log.warn(v53);
        end;

        return PlayHandle.inert(p47), 0;
    end;

    function p19.AbsoluteEmitAt(u54, u55, p56, p57) -- Line: 212
        -- upvalues: beginPlay (copy), PlayHandle (ref), emitTransformedRoot (copy), u1 (ref), Log (ref), buildCtx (copy), warnInPlace (ref), Particles (ref), Duration (ref)
        local u58 = beginPlay(u54, u55, p56, p57, "AbsoluteEmitAt");

        if not u58 then
            return PlayHandle.inert(u54), 0;
        end;

        local options = u58.options;
        local originCF = u58.originCF;
        local fullPose = u58.fullPose;
        local token = u58.token;
        local handle = u58.handle;
        local totalDur = u58.totalDur;

        if u55:GetAttribute("Transformed") then
            return emitTransformedRoot(u54, u55, u58);
        end;

        if u55:IsA("Trail") or u55:IsA("Beam") then
            u54:_absoluteEmitFire(u55, nil, nil);

            return handle, totalDur;
        end;

        if not (u55:IsA("BasePart") or (u55:IsA("Model") or (u55:IsA("Attachment") or u55:IsA("ParticleEmitter")))) then
            local v59 = "AbsoluteEmitAt:" .. u55.ClassName;
            local v60 = ("[Part-Icles] AbsoluteEmitAt: %s has no position; pass a Part / Model / Attachment / ParticleEmitter or a transformed item. Nothing emitted."):format(u55:GetFullName());

            if not u1[v59] then
                u1[v59] = true;
                Log.warn(v60);
            end;

            return PlayHandle.inert(u54), 0;
        end;

        local v61 = nil;
        local u62;

        if u55:IsA("Model") then
            local v63;
            v63, u62 = pcall(u55.GetPivot, u55);

            if not v63 then
                u62 = v61;
            end;
        elseif u55:IsA("BasePart") then
            u62 = u55.CFrame;
        elseif u55:IsA("Attachment") then
            u62 = u55.WorldCFrame;
        elseif u55:IsA("ParticleEmitter") then
            local Parent = u55.Parent;

            if Parent and Parent:IsA("BasePart") then
                u62 = Parent.CFrame;
            elseif Parent and Parent:IsA("Attachment") then
                u62 = Parent.WorldCFrame;
            else
                u62 = v61;
            end;
        else
            u62 = v61;
        end;

        local function readWorldCF(p64) -- Line: 253
            if p64:IsA("Model") then
                local success, result = pcall(p64.GetPivot, p64);

                return success and result and result or nil;
            end;

            if p64:IsA("Attachment") then
                return p64.WorldCFrame;
            end;

            if p64:IsA("BasePart") then
                return p64.CFrame;
            end;

            return nil;
        end;

        local function originFor(p65, p66) -- Line: 263
            -- upvalues: u62 (ref), readWorldCF (copy), fullPose (copy)
            if not u62 then
                return p65;
            end;

            local v67 = readWorldCF(p66);

            if not v67 then
                return p65;
            end;

            if fullPose then
                return p65 * u62:ToObjectSpace(v67);
            end;

            return v67 + (p65.Position - u62.Position);
        end;

        local function ctxFor(u68) -- Line: 271
            -- upvalues: u58 (copy), u62 (ref), readWorldCF (copy), fullPose (copy), buildCtx (ref), originCF (copy)
            local resolver = u58.resolver;
            local v71 = resolver and function() -- Line: 277
                -- upvalues: resolver (copy), u68 (copy), u62 (ref), readWorldCF (ref), fullPose (ref)
                local v69 = resolver();

                if not v69 then
                    return nil;
                end;

                if not u62 then
                    return v69;
                end;

                local v70 = readWorldCF(u68);

                if not v70 then
                    return v69;
                end;

                if fullPose then
                    return v69 * u62:ToObjectSpace(v70);
                end;

                return v70 + (v69.Position - u62.Position);
            end or nil;
            local v72 = originCF;

            if u62 then
                local v73 = readWorldCF(u68);

                if v73 then
                    if fullPose then
                        v72 = v72 * u62:ToObjectSpace(v73);
                    else
                        v72 = v73 + (v72.Position - u62.Position);
                    end;
                end;
            end;

            return buildCtx(u58, v72, v71);
        end;

        if options.Persist == true and (options.ApplyToAll or u58.linkWins) then
            local function applyAuthoring(p74) -- Line: 289
                -- upvalues: u54 (copy), options (ref), applyAuthoring (copy)
                if p74:GetAttribute("Transformed") then
                    local v75 = u54;
                    local v76 = options;

                    if v76.Link ~= nil then
                        v75:SetLink(p74, v76.Link, v76.LinkMode or "Weld");
                    end;

                    if v76.EmitParent ~= nil then
                        v75:SetEmitParent(p74, v76.EmitParent);
                    end;
                end;

                for _, child in p74:GetChildren() do
                    applyAuthoring(child);
                end;
            end;

            applyAuthoring(u55);
        end;

        local function walkTransformed(u77) -- Line: 299
            -- upvalues: warnInPlace (ref), u54 (copy), u58 (copy), u62 (ref), readWorldCF (copy), fullPose (copy), buildCtx (ref), originCF (copy), walkTransformed (copy)
            if not u77:GetAttribute("Transformed") then
                for _, child in u77:GetChildren() do
                    walkTransformed(child);
                end;

                return;
            end;

            warnInPlace(u77);
            local link = u58.link;
            local resolver = u58.resolver;
            local v80 = resolver and function() -- Line: 277
                -- upvalues: resolver (copy), u77 (copy), u62 (ref), readWorldCF (ref), fullPose (ref)
                local v78 = resolver();

                if not v78 then
                    return nil;
                end;

                if not u62 then
                    return v78;
                end;

                local v79 = readWorldCF(u77);

                if not v79 then
                    return v78;
                end;

                if fullPose then
                    return v78 * u62:ToObjectSpace(v79);
                end;

                return v79 + (v78.Position - u62.Position);
            end or nil;
            local v81 = originCF;

            if u62 then
                local v82 = readWorldCF(u77);

                if v82 then
                    if fullPose then
                        v81 = v81 * u62:ToObjectSpace(v82);
                    else
                        v81 = v82 + (v81.Position - u62.Position);
                    end;
                end;
            end;

            u54:EnableEmit(u77, link, (buildCtx(u58, v81, v80)));
        end;

        walkTransformed(u55);

        if options.SkipClone then
            Particles.EnableEmit(u55, u54:_makeAliveCheck());

            return handle, totalDur;
        end;

        local v83 = u55:IsA("ParticleEmitter");

        local function _underTransformedAncestor(p84) -- Line: 323
            -- upvalues: u55 (copy)
            local Parent = p84.Parent;

            while Parent and Parent ~= u55 do
                if Parent:GetAttribute("Transformed") then
                    return true;
                end;

                Parent = Parent.Parent;
            end;

            return false;
        end;

        for _, descendant in ipairs(u55:GetDescendants()) do
            if (descendant:IsA("ParticleEmitter") or (descendant:IsA("Trail") or descendant:IsA("Beam"))) and not (descendant:GetAttribute("Transformed") or _underTransformedAncestor(descendant)) then
                v83 = true;
                break;
            end;
        end;

        if not v83 then
            return handle, totalDur;
        end;

        local success, result = pcall(u55.Clone, u55);

        if not (success and result) then
            return handle, totalDur;
        end;

        pcall(function() -- Line: 343
            -- upvalues: result (ref)
            result.Archivable = false;
        end);

        for _, descendant in ipairs(result:GetDescendants()) do
            if descendant:GetAttribute("Transformed") then
                pcall(function() -- Line: 349
                    -- upvalues: descendant (copy)
                    descendant:Destroy();
                end);
            end;
        end;

        local v85 = Duration.computeMaxDuration(result, 0) or 60;

        if result:IsA("BasePart") then
            pcall(function() -- Line: 356
                -- upvalues: result (ref)
                result.Anchored = true;
            end);
        end;

        for _, descendant in ipairs(result:GetDescendants()) do
            if descendant:IsA("BasePart") then
                pcall(function() -- Line: 358
                    -- upvalues: descendant (copy)
                    descendant.Anchored = true;
                end);
            end;
        end;

        if not fullPose and u62 then
            originCF = CFrame.new(originCF.Position) * u62.Rotation;
        end;

        if result:IsA("Model") then
            pcall(function() -- Line: 368
                -- upvalues: result (ref), originCF (ref)
                result:PivotTo(originCF);
            end);
        elseif result:IsA("BasePart") then
            pcall(function() -- Line: 372
                -- upvalues: result (ref), originCF (ref)
                result:PivotTo(originCF * result.PivotOffset);
            end);
        else
            local Part = Instance.new("Part");
            Part.Name = "_EmitHolder";
            Part.Anchored = true;
            Part.CanCollide = false;
            Part.CanQuery = false;
            Part.CanTouch = false;
            Part.Massless = true;
            Part.Transparency = 1;
            Part.Size = Vector3.new(0.001, 0.001, 0.001);
            Part.Archivable = false;

            if result:IsA("ParticleEmitter") and (u55.Parent and u55.Parent:IsA("BasePart")) then
                Part.Size = u55.Parent.Size;
            end;

            Part.CFrame = originCF;

            if result:IsA("Attachment") then
                result.CFrame = CFrame.new();
            end;

            result.Parent = Part;
            result = Part;
        end;

        result.Parent = u54:GetFolder();
        table.insert(token.Clones, result);
        u54:_absoluteEmitFire(result, nil, nil);
        task.delay(v85, function() -- Line: 402
            -- upvalues: result (ref)
            if result and result.Parent then
                pcall(function() -- Line: 403
                    -- upvalues: result (ref)
                    result:Destroy();
                end);
            end;
        end);

        return handle, totalDur;
    end;
end;