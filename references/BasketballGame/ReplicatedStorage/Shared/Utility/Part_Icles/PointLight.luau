 
 

local Graph = require(script.Parent.Graph);
local Range = require(script.Parent.Range);
local Pool = require(script.Parent.Pool);

return function(u1) -- Line: 10
    -- upvalues: Graph (copy), Pool (copy), Range (copy)
    function u1.UpdatePointLight(p2, p3, p4, p5) -- Line: 12
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

            if p3.Graphs.PLRange then
                p3.VisualPart.Range = Graph.QueryPointsWithTime(v10, p3.Graphs.PLRange, p3.Seeds.PLRange);
            end;

            if p3.Graphs.PLBrightness and not p3.SkipTransparency then
                p3.VisualPart.Brightness = Graph.QueryPointsWithTime(v10, p3.Graphs.PLBrightness, p3.Seeds.PLBrightness);
            end;

            if p3.Graphs.PLColor and not p3.SkipColor then
                p3.VisualPart.Color = Graph.QueryColorPointWithTime(v10, p3.Graphs.PLColor);
            end;
        end;

        return math_min_ret >= 1 and (LifeTime <= v8 or v8 <= 0);
    end;

    function u1.EmitPointLight(p11, p12, p13, p14) -- Line: 59
        -- upvalues: Pool (ref), Range (ref), Graph (ref), u1 (copy)
        if not (p12 and p12.Parent) then
            return;
        end;

        local Data = p11:GetData(p12);

        if not (Data and Data.RenderTemplate) then
            return;
        end;

        local v15 = Pool.acquireOrClone(Data.RenderTemplate, "PointLight", Data.Pool);
        v15.Archivable = false;
        v15.Enabled = true;

        if Data.Shadows ~= nil then
            v15.Shadows = Data.Shadows;
        end;

        local v16 = Data.EmitParent or (p13 or p12.Parent);
        local v17 = Range.RandomValueFromRange(Data.Lifetime);
        local v18 = v17 <= 0 and 0.001 or v17;
        local v19 = Data.PLRange and (Graph.GenerateSeed(Data.PLRange) or {}) or {};
        local v20 = Data.PLBrightness and (Graph.GenerateSeed(Data.PLBrightness) or {}) or {};
        local v21 = Graph.GenerateSeed(Data.PLTimescale);

        if Data.PLRange then
            v15.Range = Graph.QueryPointsWithTime(0, Data.PLRange, v19);
        end;

        if Data.PLBrightness then
            v15.Brightness = Graph.QueryPointsWithTime(0, Data.PLBrightness, v20);
        end;

        if Data.PLColor then
            v15.Color = Graph.QueryColorPointWithTime(0, Data.PLColor);
        end;

        v15.Parent = v16;
        local v22 = {
            Type = "PointLight",
            CurrentStep = 0,
            VisualPart = v15,
            Events = Data.Events,
            StartTime = os.clock(),
            TotalKeyFrames = math.max(1, Data.TotalKeyFrames),
            LifeTime = v18,
            PartLife = Data.PartLife or 0,
            Graphs = {
                PLRange = Data.PLRange,
                PLBrightness = Data.PLBrightness,
                PLColor = Data.PLColor,
                Timescale = Data.PLTimescale
            },
            Seeds = {
                PLRange = v19,
                PLBrightness = v20,
                Timescale = v21
            },
            _effectiveElapsed = Graph.InitialEffectiveElapsed(Data.PLTimescale, v21, v18),
            _sourceItem = p12
        };
        u1._seedTsOverride(v22, p12);

        if Data.Pool ~= false then
            v22._sourceRT = Data.RenderTemplate;
            v22._poolKind = "PointLight";
        end;

        p11:_registerEmit(v22, p14);
    end;
end;