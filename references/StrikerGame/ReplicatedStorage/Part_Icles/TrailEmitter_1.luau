 
 

local Graph = require(script.Parent.Graph);
local u1 = {};
local Range = require(script.Parent.Range);
local TrailGraphBlender = require(script.Parent.TrailGraphBlender);
local Pool = require(script.Parent.Pool);
local Flipbook = require(script.Parent.Flipbook);
local Lines = require(script.Parent.Container.Lines);

return function(u2) -- Line: 26
    -- upvalues: Graph (copy), u1 (copy), Lines (copy), TrailGraphBlender (copy), Pool (copy), Range (copy), Flipbook (copy)
    local u3 = { "Brightness", "LightEmission", "LightInfluence", "TextureLength", "MinLength", "MaxLength" };

    local function _writeBlenderState(p4, p5, p6, p7, p8, p9, p10) -- Line: 31
        -- upvalues: Graph (ref), u1 (ref)
        if not p6 or #p6 == 0 then
            return;
        end;

        if #p6 == 1 then
            p4[p5] = p6[1].Graph;

            return;
        end;

        local v11 = p9[p8] or 1;
        local v12 = #p6 - 1;

        for i = p10 < p6[v11].Time and 1 or v11, #p6 - 1 do
            if p6[i].Time <= p10 and p10 <= p6[i + 1].Time then
                v12 = i;
                break;
            end;

            local _ = i;
        end;

        p9[p8] = v12;
        local v13 = p6[v12];
        local v14 = p6[v12 + 1] or p6[#p6];
        local v15 = v14.Time - v13.Time;
        local v16 = v15 > 0 and ((p10 - v13.Time) / v15 or 0) or 0;

        if v14.Transition then
            v16 = Graph.QueryPointsWithTime(v16, v14.Transition, u1);
        end;

        if p7 then
            p7 = p7[v12];
        end;

        if p7 then
            if p5 == "Color" then
                p4[p5] = Graph.LerpColorGraphFast(v13.Graph, v14.Graph, v16, p7);

                return;
            end;

            p4[p5] = Graph.LerpGraphFast(v13.Graph, v14.Graph, v16, p7);
        end;
    end;

    function u2.UpdateTrail(p17, p18, p19, p20) -- Line: 63
        -- upvalues: Graph (ref), _writeBlenderState (copy), u3 (copy), Lines (ref)
        local math_max_ret = math.max((p20 - p18.StartTime) / p18.LifeTime, 0);
        local math_min_ret = math.min(math_max_ret, 1);
        local v21;

        if p18._tsOverride == nil or p20 >= (p18._tsOverrideUntil or 0) then
            v21 = p18.Graphs.Timescale and (Graph.QueryPointsWithTime(math_min_ret, p18.Graphs.Timescale, p18.Seeds.Timescale) or 1) or 1;
        else
            v21 = p18._tsOverride;
        end;

        local _drive = p18._drive;

        if _drive then
            v21 = v21 * _drive.timescale;
        end;

        local LifeTime = p18.LifeTime;
        local v22 = (p18._effectiveElapsed or 0) + (p18._timeFrozen and 0 or p19 * v21);
        local v23 = v22 < 0 and 0 or v22;

        if LifeTime < v23 then
            v23 = LifeTime;
        end;

        p18._effectiveElapsed = v23;

        if not (p18.VisualPart and p18.VisualPart.Parent) then
            return true;
        end;

        local math_max_ret2 = math.max(v23 / LifeTime, 0);
        local math_min_ret2 = math.min(math_max_ret2, 1);

        if not p18.SkipColor then
            _writeBlenderState(p18.VisualPart, "WidthScale", p18.WidthStates, p18.WidthMergedTimes, "_lastWidthIdx", p18, math_min_ret2);
            _writeBlenderState(p18.VisualPart, "Color", p18.ColorStates, p18.ColorMergedTimes, "_lastColorIdx", p18, math_min_ret2);
        end;

        if not p18.SkipTransparency then
            _writeBlenderState(p18.VisualPart, "Transparency", p18.TransStates, p18.TransMergedTimes, "_lastTransIdx", p18, math_min_ret2);
        end;

        if p18.TotalKeyFrames > 0 then
            local math_floor_ret = math.floor(math_min_ret2 * p18.TotalKeyFrames);

            if math_floor_ret ~= p18.CurrentStep then
                p18.CurrentStep = math_floor_ret;
                local v24 = p18.CurrentStep / p18.TotalKeyFrames;

                for _, v in ipairs(u3) do
                    local v25 = p18.Graphs[v];

                    if v25 then
                        p18.VisualPart[v] = Graph.QueryPointsWithTime(v24, v25, p18.Seeds[v]);
                    end;
                end;
            end;
        end;

        if _drive then
            Lines.driveTrail(p18);
        end;

        return math_min_ret >= 1 and (LifeTime <= v23 or v23 <= 0);
    end;

    local function _collectStatesAndMergedTimes(p26) -- Line: 121
        -- upvalues: TrailGraphBlender (ref)
        local v27, v28, v29 = TrailGraphBlender.CollectStates(p26);
        local v30 = {};
        local v31 = {};
        local v32 = {};

        for i = 1, #v27 - 1 do
            v30[i] = TrailGraphBlender.PrecomputeMergedTimes(v27[i].Graph, v27[i + 1].Graph);
            local _ = i;
        end;

        for i = 1, #v28 - 1 do
            v31[i] = TrailGraphBlender.PrecomputeMergedTimes(v28[i].Graph, v28[i + 1].Graph);
            local _ = i;
        end;

        for i = 1, #v29 - 1 do
            v32[i] = TrailGraphBlender.PrecomputeMergedColorTimes(v29[i].Graph, v29[i + 1].Graph);
            local _ = i;
        end;

        return v27, v28, v29, v30, v31, v32;
    end;

    local function _buildScalarGraphs(p33) -- Line: 130
        -- upvalues: Graph (ref), u3 (copy)
        local v34 = {
            Timescale = p33.TEmitTimescale
        };
        local v35 = {
            Timescale = Graph.GenerateSeed(p33.TEmitTimescale)
        };

        for _, v in ipairs(u3) do
            local v36 = p33["TEmit" .. v] or p33[v];

            if v36 then
                v34[v] = v36;
                v35[v] = Graph.GenerateSeed(v36);
            end;
        end;

        return v34, v35;
    end;

    function u2.EmitTrail(p37, p38, p39, p40) -- Line: 145
        -- upvalues: Pool (ref), Range (ref), _collectStatesAndMergedTimes (copy), _buildScalarGraphs (copy), u3 (copy), Graph (ref), u2 (copy), Lines (ref), Flipbook (ref)
        if not (p38 and p38.Parent) then
            return;
        end;

        local EmitData = p37:GetEmitData(p38, p40);

        if not (EmitData and EmitData.RenderTemplate) then
            return;
        end;

        local v41 = Pool.acquireOrClone(EmitData.RenderTemplate, "TrailEmitter", EmitData.Pool);
        v41.Archivable = false;
        v41.Enabled = true;
        local v42;

        if p40 then
            v42 = p40._parentCloneMap;
        else
            v42 = p40;
        end;

        local Attachment0 = EmitData.RenderTemplate.Attachment0;
        local Attachment1 = EmitData.RenderTemplate.Attachment1;
        local v43;

        if v42 then
            if Attachment0 then
                v43 = v42[Attachment0];
            else
                v43 = Attachment0;
            end;
        else
            v43 = v42;
        end;

        if v42 then
            if Attachment1 then
                v42 = v42[Attachment1];
            else
                v42 = Attachment1;
            end;
        end;

        if v43 and v43.Parent then
            Attachment0 = v43 or Attachment0;
        end;

        v41.Attachment0 = Attachment0;

        if v42 and v42.Parent then
            Attachment1 = v42 or Attachment1;
        end;

        v41.Attachment1 = Attachment1;
        local v44 = Range.RandomValueFromRange(EmitData.Lifetime);
        local v45 = v44 <= 0 and 0.001 or v44;
        local v46 = Range.RandomValueFromRange(EmitData.TrailLife or EmitData.Lifetime);
        v41.Lifetime = v46 <= 0 and 0.001 or v46;
        local v47, v48, v49, v50, v51, v52 = _collectStatesAndMergedTimes(EmitData.GraphBlender);

        if #v47 > 0 then
            v41.WidthScale = v47[1].Graph;
        end;

        if #v48 > 0 then
            v41.Transparency = v48[1].Graph;
        end;

        if #v49 > 0 then
            v41.Color = v49[1].Graph;
        end;

        local v53, v54 = _buildScalarGraphs(EmitData);

        for _, v in ipairs(u3) do
            if v53[v] then
                v41[v] = Graph.QueryPointsWithTime(0, v53[v], v54[v]);
            end;
        end;

        v41.Parent = EmitData.EmitParent or p37:GetFolder();
        local v55 = {
            Type = "TrailEmitter",
            CurrentStep = 0,
            VisualPart = v41,
            Link = p39,
            Events = EmitData.Events,
            StartTime = os.clock(),
            TotalKeyFrames = math.max(1, EmitData.TotalKeyFrames),
            LifeTime = v45,
            PartLife = EmitData.PartLife or 0,
            WidthStates = v47,
            TransStates = v48,
            ColorStates = v49,
            WidthMergedTimes = v50,
            TransMergedTimes = v51,
            ColorMergedTimes = v52,
            Graphs = v53,
            Seeds = v54,
            _effectiveElapsed = Graph.InitialEffectiveElapsed(EmitData.TEmitTimescale, v54.Timescale, v45),
            _sourceItem = p38
        };
        u2._seedTsOverride(v55, p38);

        if EmitData.Pool ~= false then
            v55._sourceRT = EmitData.RenderTemplate;
            v55._poolKind = "TrailEmitter";
        end;

        if p40 and p40._containerDrive then
            Lines.carry(v55, "Trail", p40._containerDrive);
        end;

        p37:_registerEmit(v55, p40);

        if EmitData.TrailFlipbookMode and EmitData.TrailFlipbooks then
            local SortedBeamTextures = Flipbook.GetSortedBeamTextures(EmitData.TrailFlipbooks);

            if #SortedBeamTextures > 0 then
                Flipbook.FlipBeam(v55, {
                    FlipbookMode = EmitData.TrailFlipbookMode,
                    FlipbookFramerate = EmitData.TrailFlipbookFramerate,
                    FlipbookStartRandom = EmitData.TrailFlipbookStartRandom,
                    FlipbookReverse = EmitData.TrailFlipbookReverse
                }, SortedBeamTextures, v41, v45);
            end;
        end;
    end;

    function u2.EmitTrailAnimate(p56, p57, p58, p59) -- Line: 234
        -- upvalues: Range (ref), _collectStatesAndMergedTimes (copy), _buildScalarGraphs (copy), u3 (copy), Graph (ref), u2 (copy), Flipbook (ref)
        if not (p57 and p57.Parent) then
            return;
        end;

        if p56.ActiveAnimates[p57] then
            return;
        end;

        local EmitData = p56:GetEmitData(p57, p59);

        if not (EmitData and EmitData.RenderTemplate) then
            return;
        end;

        local RenderTemplate = EmitData.RenderTemplate;
        local v60 = {
            Lifetime = RenderTemplate.Lifetime,
            Brightness = RenderTemplate.Brightness,
            LightEmission = RenderTemplate.LightEmission,
            LightInfluence = RenderTemplate.LightInfluence,
            TextureLength = RenderTemplate.TextureLength,
            MinLength = RenderTemplate.MinLength,
            MaxLength = RenderTemplate.MaxLength,
            Texture = RenderTemplate.Texture,
            TextureMode = RenderTemplate.TextureMode,
            FaceCamera = RenderTemplate.FaceCamera,
            WidthScale = RenderTemplate.WidthScale,
            Transparency = RenderTemplate.Transparency,
            Color = RenderTemplate.Color,
            Enabled = RenderTemplate.Enabled
        };
        RenderTemplate.Enabled = true;
        local v61 = Range.RandomValueFromRange(EmitData.Lifetime);
        local v62 = v61 <= 0 and 0.001 or v61;
        local v63 = Range.RandomValueFromRange(EmitData.TrailLife or EmitData.Lifetime);
        RenderTemplate.Lifetime = v63 <= 0 and 0.001 or v63;
        local v64, v65, v66, v67, v68, v69 = _collectStatesAndMergedTimes(EmitData.GraphBlender);

        if #v64 > 0 then
            RenderTemplate.WidthScale = v64[1].Graph;
        end;

        if #v65 > 0 then
            RenderTemplate.Transparency = v65[1].Graph;
        end;

        if #v66 > 0 then
            RenderTemplate.Color = v66[1].Graph;
        end;

        local v70, v71 = _buildScalarGraphs(EmitData);

        for _, v in ipairs(u3) do
            if v70[v] then
                RenderTemplate[v] = Graph.QueryPointsWithTime(0, v70[v], v71[v]);
            end;
        end;

        local v72 = {
            Type = "TrailEmitter",
            CurrentStep = 0,
            IsAnimate = true,
            VisualPart = RenderTemplate,
            Link = p58,
            Events = EmitData.Events,
            StartTime = os.clock(),
            TotalKeyFrames = math.max(1, EmitData.TotalKeyFrames),
            LifeTime = v62,
            PartLife = EmitData.PartLife or 0,
            AnimateItem = p57,
            TrailEmitterSnapshot = v60,
            WidthStates = v64,
            TransStates = v65,
            ColorStates = v66,
            WidthMergedTimes = v67,
            TransMergedTimes = v68,
            ColorMergedTimes = v69,
            Graphs = v70,
            Seeds = v71,
            _effectiveElapsed = Graph.InitialEffectiveElapsed(EmitData.TEmitTimescale, v71.Timescale, v62),
            _sourceItem = p57
        };
        u2._seedTsOverride(v72, p57);
        p56.ActiveAnimates[p57] = v72;
        p56:_registerEmit(v72, p59);

        if EmitData.TrailFlipbookMode and EmitData.TrailFlipbooks then
            local SortedBeamTextures = Flipbook.GetSortedBeamTextures(EmitData.TrailFlipbooks);

            if #SortedBeamTextures > 0 then
                Flipbook.FlipBeam(v72, {
                    FlipbookMode = EmitData.TrailFlipbookMode,
                    FlipbookFramerate = EmitData.TrailFlipbookFramerate,
                    FlipbookStartRandom = EmitData.TrailFlipbookStartRandom,
                    FlipbookReverse = EmitData.TrailFlipbookReverse
                }, SortedBeamTextures, RenderTemplate, v62);
            end;
        end;
    end;
end;