 
 

local Graph = require(script.Parent.Graph);
local Lines = require(script.Parent.Container.Lines);
local u1 = {};
local PartConstants = require(script.Parent.PartConstants);
local NestedScale = require(script.Parent.NestedScale);

return function(p2) -- Line: 20
    -- upvalues: Graph (copy), u1 (copy), PartConstants (copy), NestedScale (copy), Lines (copy)
    function p2.UpdateBeam(p3, p4, p5, p6) -- Line: 25
        -- upvalues: Graph (ref), u1 (ref), PartConstants (ref), NestedScale (ref), Lines (ref)
        local math_max_ret = math.max((p6 - p4.StartTime) / p4.LifeTime, 0);
        local math_min_ret = math.min(math_max_ret, 1);
        local v7;

        if p4._tsOverride == nil or p6 >= (p4._tsOverrideUntil or 0) then
            v7 = p4.Graphs.Timescale and (Graph.QueryPointsWithTime(math_min_ret, p4.Graphs.Timescale, p4.Seeds.Timescale) or 1) or 1;
        else
            v7 = p4._tsOverride;
        end;

        local _drive = p4._drive;

        if _drive then
            v7 = v7 * _drive.timescale;
        end;

        local LifeTime = p4.LifeTime;
        local v8 = (p4._effectiveElapsed or 0) + (p4._timeFrozen and 0 or p5 * v7);
        local v9 = v8 < 0 and 0 or v8;

        if LifeTime < v9 then
            v9 = LifeTime;
        end;

        p4._effectiveElapsed = v9;

        if not (p4.VisualPart and p4.VisualPart.Parent) then
            return true;
        end;

        local math_max_ret2 = math.max(v9 / LifeTime, 0);
        local math_min_ret2 = math.min(math_max_ret2, 1);
        local TransStates = p4.TransStates;
        local ColorStates = p4.ColorStates;

        if not p4.SkipTransparency then
            if TransStates and #TransStates >= 2 then
                local v10 = p4._lastTransIdx or 1;
                local v11 = #TransStates - 1;

                for i = math_min_ret2 < TransStates[v10].Time and 1 or v10, #TransStates - 1 do
                    if TransStates[i].Time <= math_min_ret2 and math_min_ret2 <= TransStates[i + 1].Time then
                        v11 = i;
                        break;
                    end;

                    local _ = i;
                end;

                p4._lastTransIdx = v11;
                local v12 = TransStates[v11];
                local v13 = TransStates[v11 + 1] or TransStates[#TransStates];
                local v14 = v13.Time - v12.Time;
                local v15 = v14 > 0 and ((math_min_ret2 - v12.Time) / v14 or 0) or 0;

                if v13.Transition then
                    v15 = Graph.QueryPointsWithTime(v15, v13.Transition, u1);
                end;

                local v16 = p4.TransMergedTimes[v11];

                if v16 then
                    p4.VisualPart.Transparency = Graph.LerpGraphFast(v12.Graph, v13.Graph, v15, v16);
                else
                    p4.VisualPart.Transparency = Graph.LerpGraph(v12.Graph, v13.Graph, v15);
                end;
            elseif TransStates and #TransStates == 1 then
                p4.VisualPart.Transparency = TransStates[1].Graph;
            end;
        end;

        if not p4.SkipColor then
            if ColorStates and #ColorStates >= 2 then
                local v17 = p4._lastColorIdx or 1;
                local v18 = #ColorStates - 1;

                for i = math_min_ret2 < ColorStates[v17].Time and 1 or v17, #ColorStates - 1 do
                    if ColorStates[i].Time <= math_min_ret2 and math_min_ret2 <= ColorStates[i + 1].Time then
                        v18 = i;
                        break;
                    end;

                    local _ = i;
                end;

                p4._lastColorIdx = v18;
                local v19 = ColorStates[v18];
                local v20 = ColorStates[v18 + 1] or ColorStates[#ColorStates];
                local v21 = v20.Time - v19.Time;
                local v22 = v21 > 0 and ((math_min_ret2 - v19.Time) / v21 or 0) or 0;

                if v20.Transition then
                    v22 = Graph.QueryPointsWithTime(v22, v20.Transition, u1);
                end;

                local v23 = p4.ColorMergedTimes[v18];

                if v23 then
                    p4.VisualPart.Color = Graph.LerpColorGraphFast(v19.Graph, v20.Graph, v22, v23);
                else
                    p4.VisualPart.Color = Graph.LerpColorGraph(v19.Graph, v20.Graph, v22);
                end;
            elseif ColorStates and #ColorStates == 1 then
                p4.VisualPart.Color = ColorStates[1].Graph;
            end;
        end;

        local TextureSpeed = p4.AnimatedProps.TextureSpeed;

        if TextureSpeed then
            local v24 = Graph.IntegrateUpTo(math_min_ret2, TextureSpeed.Sequence, TextureSpeed.Seed);
            p4.VisualPart:SetTextureOffset(-v24 * p4.LifeTime % 1);
        end;

        for i, v in pairs(p4.AnimatedProps) do
            if i ~= "TextureSpeed" then
                local v25 = Graph.QueryPointsWithTime(math_min_ret2, v.Sequence, v.Seed);

                if i == "Segments" then
                    local math_round_ret = math.round(v25);
                    v25 = math.max(20, math_round_ret);
                end;

                p4.VisualPart[i] = v25;
            end;
        end;

        if p4.ParentScale then
            local ParentScale = p4.ParentScale;
            local ParentScaleFactor = PartConstants.getParentScaleFactor(ParentScale, p6, Graph);
            local VisualPart = p4.VisualPart;
            local AnimatedProps = p4.AnimatedProps;
            VisualPart.Width0 = (AnimatedProps.Width0 and VisualPart.Width0 or p4._baseWidth0) * ParentScaleFactor;
            VisualPart.Width1 = (AnimatedProps.Width1 and VisualPart.Width1 or p4._baseWidth1) * ParentScaleFactor;
            VisualPart.CurveSize0 = (AnimatedProps.CurveSize0 and VisualPart.CurveSize0 or p4._baseCurveSize0) * ParentScaleFactor;
            VisualPart.CurveSize1 = (AnimatedProps.CurveSize1 and VisualPart.CurveSize1 or p4._baseCurveSize1) * ParentScaleFactor;

            if ParentScale.ScaleTextureLength ~= false and NestedScale.textureScales(VisualPart) then
                VisualPart.TextureLength = (AnimatedProps.TextureLength and VisualPart.TextureLength or p4._baseTextureLength) * ParentScaleFactor;
            end;

            local math_round_ret = math.round((AnimatedProps.Segments and VisualPart.Segments or p4._baseSegments) * ParentScaleFactor);
            VisualPart.Segments = math.max(20, math_round_ret);
        end;

        if _drive then
            Lines.driveBeam(p4);
        end;

        return math_min_ret >= 1 and (LifeTime <= v9 or v9 <= 0);
    end;
end;