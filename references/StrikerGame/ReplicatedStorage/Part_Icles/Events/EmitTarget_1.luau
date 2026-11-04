 
 

local EventsSchema = require(script.Parent.Parent.EventsSchema);
local Log = require(script.Parent.Parent.Log);

return function(u1) -- Line: 21
    -- upvalues: Log (copy), EventsSchema (copy)
    local function warnOnce(p2, p3) -- Line: 24
        -- upvalues: u1 (copy), Log (ref)
        if u1._unsupportedOriginWarned[p2] then
            return;
        end;

        u1._unsupportedOriginWarned[p2] = true;
        Log.warn(p3);
    end;

    local function inPlaceCtx(p4) -- Line: 30
        return {
            EventDriven = true,
            ChainCtx = p4
        };
    end;

    local function emitInPlace(u5, u6, u7) -- Line: 34
        -- upvalues: u1 (copy), Log (ref)
        if u6:GetAttribute("Transformed") then
            u5:EnableEmit(u6, nil, {
                EventDriven = true,
                ChainCtx = u7
            });

            return;
        end;

        local success, result = pcall(function() -- Line: 39
            -- upvalues: u5 (copy), u6 (copy), u7 (copy)
            u5:AbsoluteEmit(u6, false, {
                EventDriven = true,
                ChainCtx = u7
            });
        end);

        if not success then
            local v8 = "emit:" .. u6.ClassName;
            local v9 = "[Part-Icles Events] emit target failed: " .. tostring(result);

            if u1._unsupportedOriginWarned[v8] then
                return;
            end;

            u1._unsupportedOriginWarned[v8] = true;
            Log.warn(v9);
        end;
    end;

    local function frameOf(p10) -- Line: 44
        -- upvalues: frameOf (copy)
        if p10:IsA("BasePart") then
            return p10.CFrame;
        end;

        if p10:IsA("Attachment") then
            return p10.WorldCFrame;
        end;

        if p10:IsA("Model") then
            return p10:GetPivot();
        end;

        if p10:IsA("ParticleEmitter") and p10.Parent then
            return frameOf(p10.Parent);
        end;

        return nil;
    end;

    local function isContainer(p11) -- Line: 52
        local v12 = p11:IsA("Folder") or p11:IsA("Model") and not p11:GetAttribute("Transformed");

        return v12;
    end;

    local function containerPivot(p13) -- Line: 58
        -- upvalues: containerPivot (copy), frameOf (copy)
        if p13:IsA("Model") then
            return p13:GetPivot();
        end;

        for _, child in ipairs(p13:GetChildren()) do
            if child:IsA("Folder") then
                local v14 = containerPivot(child);

                if v14 then
                    return v14;
                end;
            elseif not child:GetAttribute("_isAnchor") then
                local v15 = frameOf(child);

                if v15 then
                    return CFrame.new(v15.Position);
                end;
            end;
        end;

        return nil;
    end;

    local function childOrigin(p16, p17, p18, p19) -- Line: 74
        if p19 then
            return p16 * p17:ToObjectSpace(p18);
        end;

        return p18 + (p16.Position - p17.Position);
    end;

    local function emitAt(u20, u21, u22, p23, p24, p25) -- Line: 80
        -- upvalues: EventsSchema (ref), u1 (copy), Log (ref), emitInPlace (copy)
        local u26 = {
            EventDriven = true,
            IgnoreLink = true,
            ChainCtx = p25,
            UseFullOrigin = p24 == "AtCFrame",
            OriginResolver = p23
        };

        if not u21:GetAttribute("Transformed") then
            if u21:IsA("Trail") or u21:IsA("Beam") then
                emitInPlace(u20, u21, p25);

                return;
            end;

            local success, result = pcall(function() -- Line: 102
                -- upvalues: u20 (copy), u21 (copy), u22 (copy), u26 (copy)
                u20:AbsoluteEmitAt(u21, u22, u26);
            end);

            if not success then
                local v27 = "emitAt:" .. u21.ClassName;
                local v28 = "[Part-Icles Events] emit target failed: " .. tostring(result);

                if u1._unsupportedOriginWarned[v27] then
                    return;
                end;

                u1._unsupportedOriginWarned[v27] = true;
                Log.warn(v28);
            end;

            return;
        end;

        local v29 = EventsSchema.emitCapabilityReason(u21);

        if not v29 then
            u20:EnableEmitAt(u21, u22, u26);

            return;
        end;

        local v30 = tostring(p24) .. ":" .. u21.ClassName;
        local v31 = ("[Part-Icles Events] %s emits in place: %s"):format(u21:GetFullName(), v29);

        if not u1._unsupportedOriginWarned[v30] then
            u1._unsupportedOriginWarned[v30] = true;
            Log.warn(v31);
        end;

        u20:EnableEmit(u21, nil, {
            EventDriven = true,
            ChainCtx = p25
        });
    end;

    local function fanOut(p32, p33, u34, p35, u36, p37, p38) -- Line: 107
        -- upvalues: fanOut (copy), frameOf (copy), emitAt (copy), emitInPlace (copy)
        local u39 = p37 == "AtCFrame";

        for _, child in ipairs(p33:GetChildren()) do
            if child:IsA("Folder") then
                fanOut(p32, child, u34, p35, u36, p37, p38);
            else
                local u40 = frameOf(child);

                if u40 then
                    local function resolver() -- Line: 115
                        -- upvalues: u36 (copy), u34 (copy), frameOf (ref), child (copy), u40 (copy), u39 (copy)
                        local v41 = u36();
                        local v42 = u34;
                        local v43 = frameOf(child) or u40;

                        if u39 then
                            return v41 * v42:ToObjectSpace(v43);
                        end;

                        return v43 + (v41.Position - v42.Position);
                    end;

                    local v44;

                    if u39 then
                        v44 = p35 * u34:ToObjectSpace(u40);
                    else
                        v44 = u40 + (p35.Position - u34.Position);
                    end;

                    emitAt(p32, child, v44, resolver, p37, p38);
                elseif child:IsA("Trail") or (child:IsA("Beam") or child:IsA("ParticleEmitter")) then
                    emitInPlace(p32, child, p38);
                end;
            end;
        end;
    end;

    function u1.emitTargetInstance(p45, p46, u47, u48, u49, p50, p51) -- Line: 127
        -- upvalues: u1 (copy), emitInPlace (copy), EventsSchema (ref), Log (ref), fanOut (copy), containerPivot (copy), emitAt (copy)
        if not (p46 and p46.Parent) then
            return;
        end;

        local v52 = p50 or u1.newChainCtx();
        local v53 = {
            ChainId = v52.ChainId,
            Depth = v52.Depth + 1
        };

        if (p51 or u1.DEFAULT_CHAIN_DEPTH_LIMIT) <= v53.Depth then
            if u48 then
                u48 = u48._eventName;
            end;

            u1.dropDepth(u48);

            return;
        end;

        if u47 == nil or u47 == "AtTarget" then
            emitInPlace(p45, p46, v53);

            return;
        end;

        local v54 = EventsSchema.emitCapabilityReason(p46);

        if v54 then
            local v55 = tostring(u47) .. ":" .. p46.ClassName;
            local v56 = ("[Part-Icles Events] %s emits in place: %s"):format(p46:GetFullName(), v54);

            if not u1._unsupportedOriginWarned[v55] then
                u1._unsupportedOriginWarned[v55] = true;
                Log.warn(v56);
            end;

            emitInPlace(p45, p46, v53);

            return;
        end;

        local u57 = u1.resolveEmitModeCF(u47, u48, u49);

        if u57 then
            local function resolveLive() -- Line: 155
                -- upvalues: u1 (ref), u47 (copy), u48 (copy), u49 (copy), u57 (copy)
                return u1.resolveEmitModeCF(u47, u48, u49) or u57;
            end;

            local v58 = p46:IsA("Folder") or p46:IsA("Model") and not p46:GetAttribute("Transformed");

            if v58 then
                fanOut(p45, p46, containerPivot(p46) or u57, u57, resolveLive, u47, v53);

                return;
            end;

            emitAt(p45, p46, u57, resolveLive, u47, v53);

            return;
        end;

        local v59 = tostring(u47);

        if u48 then
            u48 = u48._eventName;
        end;

        local v60 = v59 .. ":" .. tostring(u48);
        local v61 = ("[Part-Icles Events] EmitMode %q has no resolvable origin; emitting in place"):format((tostring(u47)));

        if not u1._unsupportedOriginWarned[v60] then
            u1._unsupportedOriginWarned[v60] = true;
            Log.warn(v61);
        end;

        emitInPlace(p45, p46, v53);
    end;
end;