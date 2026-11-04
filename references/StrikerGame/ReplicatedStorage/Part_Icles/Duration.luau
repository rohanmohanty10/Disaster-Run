 

 

local Graph = require(script.Parent.Graph);
local u1 = {};

local function resolveDuration(p2) -- Line: 15
    if p2 == nil then
        return 0;
    end;

    if typeof(p2) == "number" then
        return p2;
    end;

    local v3 = {};

    for i in tostring(p2):gmatch("[^,]+") do
        local v4 = tonumber(i:match("^%s*(.-)%s*$"));

        if v4 then
            table.insert(v3, v4);
        end;
    end;

    if #v3 == 0 then
        return 0;
    end;

    if #v3 == 1 then
        return v3[1];
    end;

    return math.max(v3[1], v3[2]);
end;

function u1.computeTrueLifetime(p5, p6, p7) -- Line: 32
    -- upvalues: Graph (copy)
    if not p5 or p5 <= 0 then
        return 0;
    end;

    if not p6 then
        return p5;
    end;

    if Graph.IsStatic(p6) then
        local StaticValue = Graph.GetStaticValue(p6, 1);

        if StaticValue == 1 then
            return p5;
        end;

        if StaticValue == 0 then
            return nil;
        end;

        if StaticValue > 0 then
            return p5 / StaticValue;
        end;

        return p5 / -StaticValue;
    end;

    local v8 = p7 or {};
    local v9 = Graph.QueryPointsWithTime(0, p6, v8) < 0;
    local v10 = p5 / 200;
    local v11 = v9 and p5 and p5 or 0;
    local v12 = 0;

    for i = 1, 200 do
        local v13 = v11 + Graph.QueryPointsWithTime(i / 200, p6, v8) * v10;

        if not v9 and p5 <= v13 then
            return v12 + (p5 - v11) / (v13 - v11) * v10;
        end;

        if v9 and v13 <= 0 then
            return v12 + v11 / (v11 - v13) * v10;
        end;

        v12 = v12 + v10;
        v11 = v13;
        local _ = i;
    end;

    local v14 = Graph.QueryPointsWithTime(1, p6, v8);

    if v9 then
        if v14 >= 0 then
            return nil;
        end;

        return v12 + v11 / -v14;
    end;

    if v14 <= 0 then
        return nil;
    end;

    return v12 + (p5 - v11) / v14;
end;

function u1.computeItemLifecycle(p15, p16) -- Line: 86
    -- upvalues: resolveDuration (copy), u1 (copy)
    if not p15:GetAttribute("Transformed") then
        if not p15:IsA("ParticleEmitter") then
            if p15:IsA("Trail") then
                local v17 = tonumber(p15:GetAttribute("EmitDelay")) or 0;
                local v18 = resolveDuration(p15:GetAttribute("EmitDuration"));

                return v18 > 0 and {
                    infinite = false,
                    emitDelay = v17,
                    emitDur = v18,
                    lifecycle = p15.Lifetime or 0
                } or nil;
            end;

            if not p15:IsA("Beam") then
                return nil;
            end;

            local v19 = tonumber(p15:GetAttribute("EmitDelay")) or 0;
            local v20 = tonumber(p15:GetAttribute("EmitDuration")) or 0;

            return v20 > 0 and {
                lifecycle = 0,
                infinite = false,
                emitDelay = v19,
                emitDur = v20
            } or nil;
        end;

        local v21 = tonumber(p15:GetAttribute("EmitCount")) or 1;
        local v22 = tonumber(p15:GetAttribute("EmitDelay")) or 0;
        local v23 = tonumber(p15:GetAttribute("EmitDuration")) or 0;

        if v21 <= 0 and v23 <= 0 then
            return nil;
        end;

        local Lifetime = p15.Lifetime;

        return {
            infinite = false,
            emitDelay = v22,
            emitDur = v23,
            lifecycle = typeof(Lifetime) == "NumberRange" and (Lifetime.Max or 0) or 0
        };
    end;

    local PartIcleProperties = p15:FindFirstChild("PartIcleProperties");
    local v24 = p15:GetAttribute("EmitDelay") or 0;
    local v25 = resolveDuration(p15:GetAttribute("EmitDuration"));
    local Attribute = p15:GetAttribute("EmitCount");
    local v26 = Attribute == nil and 1 or Attribute;

    if p16 then
        if p16.Delay ~= nil then
            v24 = p16.Delay;
        end;

        if p16.Duration ~= nil then
            v25 = resolveDuration(p16.Duration);
        end;

        if p16.Count ~= nil then
            v26 = p16.Count;
        end;
    end;

    local v27 = p15:GetAttribute("EmissionMode") or "Emit";
    local v28 = p15:GetAttribute("AnimateLoop") == true;

    if v27 == "Animate" and (v28 and v25 <= 0) then
        return {
            emitDur = 0,
            lifecycle = 0,
            infinite = true,
            emitDelay = v24
        };
    end;

    if v26 <= 0 and v25 <= 0 and v27 ~= "Animate" then
        return nil;
    end;

    local v29;

    if PartIcleProperties then
        v29 = PartIcleProperties:GetAttribute("Lifetime");
    else
        v29 = PartIcleProperties;
    end;

    local v30 = 0;

    if typeof(v29) == "NumberRange" then
        v29 = v29.Max;
    elseif type(v29) ~= "number" then
        v29 = v30;
    end;

    local v31;

    if PartIcleProperties then
        v31 = PartIcleProperties:GetAttribute("Timescale");
    else
        v31 = PartIcleProperties;
    end;

    local v32 = u1.computeTrueLifetime(v29, v31, nil);

    if v32 == nil then
        return {
            lifecycle = 0,
            infinite = true,
            emitDelay = v24,
            emitDur = v25
        };
    end;

    local v33 = PartIcleProperties and PartIcleProperties:GetAttribute("PartLife") or 0;

    if v27 == "Animate" then
        if v25 < v32 then
            v25 = v32;
        end;
    end;

    return {
        infinite = false,
        emitDelay = v24,
        emitDur = v25,
        lifecycle = v32 + v33
    };
end;

function u1.computeMaxDuration(p34, p35, p36) -- Line: 158
    -- upvalues: u1 (copy)
    if not p34 then
        return 0;
    end;

    local v37 = p35 or 0;
    local v38 = u1.computeItemLifecycle(p34, p36);
    local v39 = 0;
    local v40 = false;

    if v38 then
        if v38.infinite then
            return nil;
        end;

        v39 = v37 + v38.emitDelay + v38.emitDur + v38.lifecycle;
        v37 = v37 + v38.emitDelay;
        p34:GetAttribute("Transformed");
    elseif p34:GetAttribute("Transformed") then
        v40 = true;
    end;

    if not v40 then
        for _, child in ipairs(p34:GetChildren()) do
            if child.Name == "RenderTemplate" then
                for _, descendant in ipairs(child:GetDescendants()) do
                    if descendant:GetAttribute("Transformed") then
                        local v41 = u1.computeMaxDuration(descendant, v37);

                        if v41 == nil then
                            return nil;
                        end;

                        if v39 < v41 then
                            v39 = v41;
                        end;
                    end;
                end;
            else
                local v42 = u1.computeMaxDuration(child, v37, p36);

                if v42 == nil then
                    return nil;
                end;

                if v39 < v42 then
                    v39 = v42;
                end;
            end;
        end;
    end;

    return v39;
end;

return u1;