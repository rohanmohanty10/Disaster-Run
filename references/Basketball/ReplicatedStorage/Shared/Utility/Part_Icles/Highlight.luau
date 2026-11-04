 
 

local Graph = require(script.Parent.Graph);
local Range = require(script.Parent.Range);
local Pool = require(script.Parent.Pool);

return function(u1) -- Line: 12
    -- upvalues: Graph (copy), Pool (copy), Range (copy)
    function u1.UpdateHighlight(p2, p3, p4, p5) -- Line: 17
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

    local function _resolveAdornee(p11, p12) -- Line: 70
        if p11.Adornee then
            return p11.Adornee;
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

    function u1.EmitHighlight(p13, p14, p15, p16) -- Line: 80
        -- upvalues: Pool (ref), Range (ref), Graph (ref), u1 (copy)
        if not (p14 and p14.Parent) then
            return;
        end;

        local Data = p13:GetData(p14);

        if not (Data and Data.RenderTemplate) then
            return;
        end;

        local v17 = Pool.acquireOrClone(Data.RenderTemplate, "Highlight", Data.Pool);
        v17.Archivable = false;
        v17.Enabled = true;

        if Data.HLDepthMode then
            v17.DepthMode = Data.HLDepthMode;
        end;

        local v18;

        if Data.Adornee then
            v18 = Data.Adornee;
        else
            v18 = p14.Adornee;

            if not v18 then
                v18 = p14.Parent;

                if not (v18 and (v18:IsA("BasePart") or v18:IsA("Model"))) then
                    v18 = nil;
                end;
            end;
        end;

        v17.Adornee = v18;
        local v19 = Data.EmitParent or p14.Parent;
        local v20 = Range.RandomValueFromRange(Data.Lifetime);
        local v21 = v20 <= 0 and 0.001 or v20;
        local v22 = Data.HLFillTransparency and (Graph.GenerateSeed(Data.HLFillTransparency) or {}) or {};
        local v23 = Data.HLOutlineTransparency and (Graph.GenerateSeed(Data.HLOutlineTransparency) or {}) or {};
        local v24 = Graph.GenerateSeed(Data.HLTimescale);

        if Data.HLFillColor then
            v17.FillColor = Graph.QueryColorPointWithTime(0, Data.HLFillColor);
        end;

        if Data.HLFillTransparency then
            v17.FillTransparency = Graph.QueryPointsWithTime(0, Data.HLFillTransparency, v22);
        end;

        if Data.HLOutlineColor then
            v17.OutlineColor = Graph.QueryColorPointWithTime(0, Data.HLOutlineColor);
        end;

        if Data.HLOutlineTransparency then
            v17.OutlineTransparency = Graph.QueryPointsWithTime(0, Data.HLOutlineTransparency, v23);
        end;

        v17.Parent = v19;
        local v25 = {
            Type = "Highlight",
            CurrentStep = 0,
            VisualPart = v17,
            Events = Data.Events,
            StartTime = os.clock(),
            TotalKeyFrames = math.max(1, Data.TotalKeyFrames),
            LifeTime = v21,
            PartLife = Data.PartLife or 0,
            Graphs = {
                HLFillColor = Data.HLFillColor,
                HLFillTransparency = Data.HLFillTransparency,
                HLOutlineColor = Data.HLOutlineColor,
                HLOutlineTransparency = Data.HLOutlineTransparency,
                Timescale = Data.HLTimescale
            },
            Seeds = {
                HLFillTransparency = v22,
                HLOutlineTransparency = v23,
                Timescale = v24
            },
            _effectiveElapsed = Graph.InitialEffectiveElapsed(Data.HLTimescale, v24, v21),
            _sourceItem = p14
        };
        u1._seedTsOverride(v25, p14);

        if Data.Pool ~= false then
            v25._sourceRT = Data.RenderTemplate;
            v25._poolKind = "Highlight";
        end;

        p13:_registerEmit(v25, p16);
    end;

    function u1.EmitHighlightAnimate(p26, p27, p28, p29) -- Line: 149
        -- upvalues: Range (ref), Graph (ref), u1 (copy)
        if not (p27 and p27.Parent) then
            return;
        end;

        if p26.ActiveAnimates[p27] then
            return;
        end;

        local Data = p26:GetData(p27);

        if not (Data and Data.RenderTemplate) then
            return;
        end;

        local RenderTemplate = Data.RenderTemplate;
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

        if Data.HLDepthMode then
            RenderTemplate.DepthMode = Data.HLDepthMode;
        end;

        local v31;

        if Data.Adornee then
            v31 = Data.Adornee;
        else
            v31 = p27.Adornee;

            if not v31 then
                v31 = p27.Parent;

                if not (v31 and (v31:IsA("BasePart") or v31:IsA("Model"))) then
                    v31 = nil;
                end;
            end;
        end;

        RenderTemplate.Adornee = v31;
        local v32 = Range.RandomValueFromRange(Data.Lifetime);
        local v33 = v32 <= 0 and 0.001 or v32;
        local v34 = Data.HLFillTransparency and (Graph.GenerateSeed(Data.HLFillTransparency) or {}) or {};
        local v35 = Data.HLOutlineTransparency and (Graph.GenerateSeed(Data.HLOutlineTransparency) or {}) or {};
        local v36 = Graph.GenerateSeed(Data.HLTimescale);
        local v37 = {
            Type = "Highlight",
            CurrentStep = 0,
            IsAnimate = true,
            VisualPart = RenderTemplate,
            Events = Data.Events,
            StartTime = os.clock(),
            TotalKeyFrames = math.max(1, Data.TotalKeyFrames),
            LifeTime = v33,
            PartLife = Data.PartLife or 0,
            AnimateItem = p27,
            HighlightSnapshot = v30,
            Graphs = {
                HLFillColor = Data.HLFillColor,
                HLFillTransparency = Data.HLFillTransparency,
                HLOutlineColor = Data.HLOutlineColor,
                HLOutlineTransparency = Data.HLOutlineTransparency,
                Timescale = Data.HLTimescale
            },
            Seeds = {
                HLFillTransparency = v34,
                HLOutlineTransparency = v35,
                Timescale = v36
            },
            _effectiveElapsed = Graph.InitialEffectiveElapsed(Data.HLTimescale, v36, v33),
            _sourceItem = p27
        };
        u1._seedTsOverride(v37, p27);
        p26.ActiveAnimates[p27] = v37;
        p26:_registerEmit(v37, p29);
    end;
end;