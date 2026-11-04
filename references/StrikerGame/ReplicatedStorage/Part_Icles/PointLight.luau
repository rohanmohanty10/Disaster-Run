 

 

local Graph = require(script.Parent.Graph);
local Range = require(script.Parent.Range);
local Pool = require(script.Parent.Pool);
local VisualHost = require(script.Parent.VisualHost);

return function(u1) -- Line: 11
    -- upvalues: Graph (copy), Pool (copy), VisualHost (copy), Range (copy)
    function u1.UpdatePointLight(p2, p3, p4, p5) -- Line: 13
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

        if p3._parentAlive and not p3._parentAlive[1] then
            return true;
        end;

        local math_max_ret2 = math.max(v8 / LifeTime, 0);
        local v9 = math.min(math_max_ret2, 1) * p3.TotalKeyFrames;
        local math_floor_ret = math.floor(v9);

        if math_floor_ret ~= p3.CurrentStep then
            p3.CurrentStep = math_floor_ret;
            local v10 = p3.CurrentStep / p3.TotalKeyFrames;
            local v11 = nil;
            local v12 = nil;
            local v13 = nil;
            local v14;

            if p3.Graphs.PLRange then
                v14 = Graph.QueryPointsWithTime(v10, p3.Graphs.PLRange, p3.Seeds.PLRange);
                p3.VisualPart.Range = v14;
            else
                v14 = nil;
            end;

            if p3.Graphs.PLBrightness and not p3.SkipTransparency then
                v11 = Graph.QueryPointsWithTime(v10, p3.Graphs.PLBrightness, p3.Seeds.PLBrightness);
                p3.VisualPart.Brightness = v11;
            end;

            if p3.Graphs.PLColor and not p3.SkipColor then
                v12 = Graph.QueryColorPointWithTime(v10, p3.Graphs.PLColor);
                p3.VisualPart.Color = v12;
            end;

            if p3._hasCone and p3.Graphs.PLAngle then
                v13 = Graph.QueryPointsWithTime(v10, p3.Graphs.PLAngle, p3.Seeds.PLAngle);
                p3.VisualPart.Angle = v13;
            end;

            local _extraLights = p3._extraLights;

            if _extraLights then
                for i = 1, #_extraLights do
                    local v15 = _extraLights[i];

                    if v14 then
                        v15.Range = v14;
                    end;

                    if v11 then
                        v15.Brightness = v11;
                    end;

                    if v12 then
                        v15.Color = v12;
                    end;

                    local v16;

                    if v13 then
                        v15.Angle = v13;
                        v16 = i;
                    else
                        v16 = i;
                    end;
                end;
            end;
        end;

        return math_min_ret >= 1 and (LifeTime <= v8 or v8 <= 0);
    end;

    function u1.EmitPointLight(p17, p18, p19, p20) -- Line: 80
        -- upvalues: Pool (ref), VisualHost (ref), Range (ref), Graph (ref), u1 (copy)
        if not (p18 and p18.Parent) then
            return;
        end;

        local EmitData = p17:GetEmitData(p18, p20);

        if not (EmitData and EmitData.RenderTemplate) then
            return;
        end;

        local v21 = Pool.acquireOrClone(EmitData.RenderTemplate, "PointLight", EmitData.Pool);
        v21.Archivable = false;
        v21.Enabled = true;

        if EmitData.Shadows ~= nil then
            v21.Shadows = EmitData.Shadows;
        end;

        local v22 = EmitData.EmitParent or p19;
        local v23 = nil;

        if not v22 then
            v22 = p18.Parent;

            if v22 and (v22:IsA("BasePart") or v22:IsA("Attachment")) then
                v22 = VisualHost.acquireCarrier(v22);
                v23 = v22;
            end;
        end;

        local v24 = nil;
        local v25;

        if v22 and v22:IsA("Model") then
            v25 = nil;

            for _, child in ipairs(v22:GetChildren()) do
                if child:IsA("BasePart") then
                    v25 = v25 or {};
                    v25[#v25 + 1] = child;
                end;
            end;

            if v25 then
                if v22:GetAttribute("_lightningBolt") then
                    v22 = v25[1];
                else
                    v22 = v25[math.ceil(#v25 / 2)];
                    v25 = v24;
                end;
            else
                v25 = v24;
            end;
        else
            v25 = v24;
        end;

        local v26 = Range.RandomValueFromRange(EmitData.Lifetime);
        local v27 = v26 <= 0 and 0.001 or v26;
        local v28 = EmitData.PLRange and (Graph.GenerateSeed(EmitData.PLRange) or {}) or {};
        local v29 = EmitData.PLBrightness and (Graph.GenerateSeed(EmitData.PLBrightness) or {}) or {};
        local v30 = EmitData.PLAngle and (Graph.GenerateSeed(EmitData.PLAngle) or {}) or {};
        local v31 = Graph.GenerateSeed(EmitData.PLTimescale);

        if EmitData.PLRange then
            v21.Range = Graph.QueryPointsWithTime(0, EmitData.PLRange, v28);
        end;

        if EmitData.PLBrightness then
            v21.Brightness = Graph.QueryPointsWithTime(0, EmitData.PLBrightness, v29);
        end;

        if EmitData.PLColor then
            v21.Color = Graph.QueryColorPointWithTime(0, EmitData.PLColor);
        end;

        local v32 = v21:IsA("SpotLight") or v21:IsA("SurfaceLight");

        if v32 then
            if EmitData.PLFace then
                v21.Face = EmitData.PLFace;
            end;

            if EmitData.PLAngle then
                v21.Angle = Graph.QueryPointsWithTime(0, EmitData.PLAngle, v30);
            end;
        end;

        v21.Parent = v22;
        local v33;

        if v25 and #v25 > 1 then
            v21.Archivable = true;
            v33 = table.create(#v25 - 1);

            for i = 2, #v25 do
                local v34 = v21:Clone();
                v34.Archivable = false;
                v34.Parent = v25[i];
                v33[i - 1] = v34;
                local _ = i;
            end;

            v21.Archivable = false;
        else
            v33 = nil;
        end;

        local v35 = {
            Type = "PointLight",
            CurrentStep = 0,
            _carrier = v23,
            _hasCone = v32,
            VisualPart = v21,
            Events = EmitData.Events,
            StartTime = os.clock(),
            TotalKeyFrames = math.max(1, EmitData.TotalKeyFrames),
            LifeTime = v27,
            PartLife = EmitData.PartLife or 0,
            Graphs = {
                PLRange = EmitData.PLRange,
                PLBrightness = EmitData.PLBrightness,
                PLColor = EmitData.PLColor,
                PLAngle = EmitData.PLAngle,
                Timescale = EmitData.PLTimescale
            },
            Seeds = {
                PLRange = v28,
                PLBrightness = v29,
                PLAngle = v30,
                Timescale = v31
            },
            _effectiveElapsed = Graph.InitialEffectiveElapsed(EmitData.PLTimescale, v31, v27),
            _sourceItem = p18,
            _extraLights = v33
        };

        if p20 and (p20._parentAlive and not EmitData.EmitParent) then
            v35._parentAlive = p20._parentAlive;
        end;

        u1._seedTsOverride(v35, p18);

        if EmitData.Pool ~= false then
            v35._sourceRT = EmitData.RenderTemplate;
            v35._poolKind = "PointLight";
        end;

        p17:_registerEmit(v35, p20);
    end;
end;