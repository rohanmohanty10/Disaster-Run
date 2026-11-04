 
 

local Graph = require(script.Parent.Graph);
local Range = require(script.Parent.Range);
local Pool = require(script.Parent.Pool);

return function(u1) -- Line: 13
    -- upvalues: Graph (copy), Pool (copy), Range (copy)
    function u1.UpdateHighlight(p2, p3, p4, p5) -- Line: 18
        -- upvalues: Graph (ref)
        local math_max_ret = math.max((p5 - p3.StartTime) / p3.LifeTime, 0);
        local math_min_ret = math.min(math_max_ret, 1);
        local v6;

        if p3._tsOverride == nil or p5 >= (p3._tsOverrideUntil or 0) then
            v6 = p3.Graphs.Timescale and (Graph.QueryPointsWithTime(math_min_ret, p3.Graphs.Timescale, p3.Seeds.Timescale) or 1) or 1;
        else
            v6 = p3._tsOverride;
        end;

        local LifeTime = p3.LifeTime;
        local v7 = (p3._effectiveElapsed or 0) + (p3._timeFrozen and 0 or p4 * v6);
        local v8 = v7 < 0 and 0 or v7;

        if LifeTime < v8 then
            v8 = LifeTime;
        end;

        p3._effectiveElapsed = v8;

        if not (p3.VisualPart and p3.VisualPart.Parent) then
            return true;
        end;

        if p3.TotalKeyFrames <= 0 then
            return true;
        end;

        local math_max_ret2 = math.max(v8 / LifeTime, 0);
        local v9 = math.min(math_max_ret2, 1) * p3.TotalKeyFrames;
        local math_floor_ret = math.floor(v9);

        if math_floor_ret ~= p3.CurrentStep then
            p3.CurrentStep = math_floor_ret;
            local v10 = p3.CurrentStep / p3.TotalKeyFrames;

            if p3.Graphs.HLFillColor and not p3.SkipColor then
                p3.VisualPart.FillColor = Graph.QueryColorPointWithTime(v10, p3.Graphs.HLFillColor);
            end;

            if p3.Graphs.HLFillTransparency and not p3.SkipTransparency then
                p3.VisualPart.FillTransparency = Graph.QueryPointsWithTime(v10, p3.Graphs.HLFillTransparency, p3.Seeds.HLFillTransparency);
            end;

            if p3.Graphs.HLOutlineColor and not p3.SkipColor then
                p3.VisualPart.OutlineColor = Graph.QueryColorPointWithTime(v10, p3.Graphs.HLOutlineColor);
            end;

            if p3.Graphs.HLOutlineTransparency and not p3.SkipTransparency then
                p3.VisualPart.OutlineTransparency = Graph.QueryPointsWithTime(v10, p3.Graphs.HLOutlineTransparency, p3.Seeds.HLOutlineTransparency);
            end;
        end;

        return math_min_ret >= 1 and (LifeTime <= v8 or v8 <= 0);
    end;

    local function _resolveAdornee(p11, p12, p13) -- Line: 73
        if p11.Adornee then
            return p11.Adornee;
        end;

        if p13 then
            if p13:IsA("BasePart") or p13:IsA("Model") then
                return p13;
            end;

            if p13:IsA("Attachment") then
                local Parent = p13.Parent;

                if Parent and (Parent:IsA("BasePart") or Parent:IsA("Model")) then
                    return Parent;
                end;
            end;
        end;

        local Adornee = p12.Adornee;

        if Adornee then
            return Adornee;
        end;

        local Parent = p12.Parent;

        if Parent and (Parent:IsA("BasePart") or Parent:IsA("Model")) then
            return Parent;
        end;

        return nil;
    end;

    function u1.EmitHighlight(p14, p15, p16, p17) -- Line: 90
        -- upvalues: Pool (ref), _resolveAdornee (copy), Range (ref), Graph (ref), u1 (copy)
        if not (p15 and p15.Parent) then
            return;
        end;

        local EmitData = p14:GetEmitData(p15, p17);

        if not (EmitData and EmitData.RenderTemplate) then
            return;
        end;

        local v18 = Pool.acquireOrClone(EmitData.RenderTemplate, "Highlight", EmitData.Pool);
        v18.Archivable = false;
        v18.Enabled = true;

        if EmitData.HLDepthMode then
            v18.DepthMode = EmitData.HLDepthMode;
        end;

        v18.Adornee = _resolveAdornee(EmitData, p15, p16);
        local v19 = EmitData.EmitParent or (p16 or p14:GetFolder());
        local v20 = Range.RandomValueFromRange(EmitData.Lifetime);
        local v21 = v20 <= 0 and 0.001 or v20;
        local v22 = EmitData.HLFillTransparency and (Graph.GenerateSeed(EmitData.HLFillTransparency) or {}) or {};
        local v23 = EmitData.HLOutlineTransparency and (Graph.GenerateSeed(EmitData.HLOutlineTransparency) or {}) or {};
        local v24 = Graph.GenerateSeed(EmitData.HLTimescale);

        if EmitData.HLFillColor then
            v18.FillColor = Graph.QueryColorPointWithTime(0, EmitData.HLFillColor);
        end;

        if EmitData.HLFillTransparency then
            v18.FillTransparency = Graph.QueryPointsWithTime(0, EmitData.HLFillTransparency, v22);
        end;

        if EmitData.HLOutlineColor then
            v18.OutlineColor = Graph.QueryColorPointWithTime(0, EmitData.HLOutlineColor);
        end;

        if EmitData.HLOutlineTransparency then
            v18.OutlineTransparency = Graph.QueryPointsWithTime(0, EmitData.HLOutlineTransparency, v23);
        end;

        v18.Parent = v19;
        local v25 = {
            Type = "Highlight",
            CurrentStep = 0,
            VisualPart = v18,
            Events = EmitData.Events,
            StartTime = os.clock(),
            TotalKeyFrames = math.max(1, EmitData.TotalKeyFrames),
            LifeTime = v21,
            PartLife = EmitData.PartLife or 0,
            Graphs = {
                HLFillColor = EmitData.HLFillColor,
                HLFillTransparency = EmitData.HLFillTransparency,
                HLOutlineColor = EmitData.HLOutlineColor,
                HLOutlineTransparency = EmitData.HLOutlineTransparency,
                Timescale = EmitData.HLTimescale
            },
            Seeds = {
                HLFillTransparency = v22,
                HLOutlineTransparency = v23,
                Timescale = v24
            },
            _effectiveElapsed = Graph.InitialEffectiveElapsed(EmitData.HLTimescale, v24, v21),
            _sourceItem = p15
        };
        u1._seedTsOverride(v25, p15);

        if EmitData.Pool ~= false then
            v25._sourceRT = EmitData.RenderTemplate;
            v25._poolKind = "Highlight";
        end;

        p14:_registerEmit(v25, p17);
    end;

    function u1.EmitHighlightAnimate(p26, p27, p28, p29) -- Line: 160
        -- upvalues: _resolveAdornee (copy), Range (ref), Graph (ref), u1 (copy)
        if not (p27 and p27.Parent) then
            return;
        end;

        if p26.ActiveAnimates[p27] then
            return;
        end;

        local EmitData = p26:GetEmitData(p27, p29);

        if not (EmitData and EmitData.RenderTemplate) then
            return;
        end;

        local RenderTemplate = EmitData.RenderTemplate;
        local v30 = {
            FillColor = RenderTemplate.FillColor,
            FillTransparency = RenderTemplate.FillTransparency,
            OutlineColor = RenderTemplate.OutlineColor,
            OutlineTransparency = RenderTemplate.OutlineTransparency,
            DepthMode = RenderTemplate.DepthMode,
            Adornee = RenderTemplate.Adornee,
            Enabled = RenderTemplate.Enabled
        };
        RenderTemplate.Enabled = true;

        if EmitData.HLDepthMode then
            RenderTemplate.DepthMode = EmitData.HLDepthMode;
        end;

        RenderTemplate.Adornee = _resolveAdornee(EmitData, p27, p28);
        local v31 = Range.RandomValueFromRange(EmitData.Lifetime);
        local v32 = v31 <= 0 and 0.001 or v31;
        local v33 = EmitData.HLFillTransparency and (Graph.GenerateSeed(EmitData.HLFillTransparency) or {}) or {};
        local v34 = EmitData.HLOutlineTransparency and (Graph.GenerateSeed(EmitData.HLOutlineTransparency) or {}) or {};
        local v35 = Graph.GenerateSeed(EmitData.HLTimescale);
        local v36 = {
            Type = "Highlight",
            CurrentStep = 0,
            IsAnimate = true,
            VisualPart = RenderTemplate,
            Events = EmitData.Events,
            StartTime = os.clock(),
            TotalKeyFrames = math.max(1, EmitData.TotalKeyFrames),
            LifeTime = v32,
            PartLife = EmitData.PartLife or 0,
            AnimateItem = p27,
            HighlightSnapshot = v30,
            Graphs = {
                HLFillColor = EmitData.HLFillColor,
                HLFillTransparency = EmitData.HLFillTransparency,
                HLOutlineColor = EmitData.HLOutlineColor,
                HLOutlineTransparency = EmitData.HLOutlineTransparency,
                Timescale = EmitData.HLTimescale
            },
            Seeds = {
                HLFillTransparency = v33,
                HLOutlineTransparency = v34,
                Timescale = v35
            },
            _effectiveElapsed = Graph.InitialEffectiveElapsed(EmitData.HLTimescale, v35, v32),
            _sourceItem = p27
        };
        u1._seedTsOverride(v36, p27);
        p26.ActiveAnimates[p27] = v36;
        p26:_registerEmit(v36, p29);
    end;
end;