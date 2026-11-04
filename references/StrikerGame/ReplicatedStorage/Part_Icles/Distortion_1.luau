 
 

local RunService = game:GetService("RunService");
local Graph = require(script.Parent.Graph);
local Range = require(script.Parent.Range);
local PartConstants = require(script.Parent.PartConstants);
local script_Canvas = require(script.Canvas);
local Log = require(script.Parent.Log);
local u1 = {
    Ripple = 1,
    Wave = 2,
    Noise = 3,
    Bulge = 4,
    Pinch = 5
};
local u2 = false;

return function(u3) -- Line: 33
    -- upvalues: Graph (copy), u1 (copy), RunService (copy), u2 (ref), Log (copy), Range (copy), PartConstants (copy), script_Canvas (copy)
    function u3._isDistortion(p4) -- Line: 36
        local v5 = p4:IsA("BasePart") and p4:GetAttribute("IsDistortion") == true;

        return v5;
    end;

    local function buildPData(p6, p7, p8, p9) -- Line: 40
        -- upvalues: Graph (ref), u1 (ref)
        local v10 = {
            Amplitude = Graph.GenerateSeed(p7.Amplitude),
            Transparency = Graph.GenerateSeed(p7.Transparency),
            Timescale = Graph.GenerateSeed(p7.Timescale)
        };
        local v11 = Graph.InitialEffectiveElapsed(p7.Timescale, v10.Timescale, p8);
        local v12 = p7.Speed or 3;
        local v13 = {
            Type = "Distortion",
            VisualPart = nil,
            CurrentStep = -1,
            PartLife = 0,
            Events = p7.Events,
            StartTime = os.clock(),
            TotalKeyFrames = math.max(1, p7.TotalKeyFrames),
            LifeTime = p8,
            _sourceItem = p6,
            Graphs = {
                Amplitude = p7.Amplitude,
                Transparency = p7.Transparency,
                Timescale = p7.Timescale
            },
            Seeds = v10,
            _effectiveElapsed = v11,
            _kindId = u1[p7.FieldKind] or 1,
            _wavelength = math.max(p7.Wavelength or 1.5, 0.02),
            _speed = v12,
            _dirRad = math.rad(p7.Direction or 0),
            _noiseScale = math.max(p7.NoiseScale or 2, 0.05),
            _lensRadius = math.max(p7.LensRadius or 1.5, 0.02),
            _screenCenter = p7.EpicenterMode == "ScreenCenter",
            _falloff = p7.Falloff or 0,
            _strength = p7.Strength or 1,
            _amplify = p7.Amplify or 0,
            _allowOver = p7.AllowOverdrive == true
        };
        local math_floor_ret = math.floor(p7.Resolution or 24);
        v13._resolution = math.clamp(math_floor_ret, 8, 96);
        v13._phase = v11 * v12 * 0.1;
        local v14 = math.random() * 100000;
        v13._noiseSeed = math.floor(v14);
        v13._lastOriginPos = p6.Position;

        if p9 then
            local v15;

            if p9.EventOriginResolver then
                v15 = p9.EventOriginResolver();
            else
                v15 = nil;
            end;

            local v16 = v15 or p9.EventOriginCF;

            if v16 then
                v13._originOverride = v16.Position;
            end;

            if p9._rigPlace then
                v13._parentPlace = p9._rigPlace.Position;
            end;
        end;

        return v13;
    end;

    function u3.EmitDistortion(p17, p18, p19, p20) -- Line: 98
        -- upvalues: RunService (ref), u2 (ref), Log (ref), Range (ref), buildPData (copy), u3 (copy)
        if not (p18 and p18.Parent) then
            return;
        end;

        if not RunService:IsClient() then
            if not u2 then
                u2 = true;
                Log.warn("[Part-Icles] Distortion ignored on the server (no screen).");
            end;

            return;
        end;

        local Data = p17:GetData(p18);

        if not Data then
            return;
        end;

        local v21 = Range.RandomValueFromRange(Data.Lifetime);
        local v22 = buildPData(p18, Data, v21 <= 0 and 0.001 or v21, p20);
        v22._parentLink = p19;
        u3._seedTsOverride(v22, p18);
        p17:_registerEmit(v22, p20);
    end;

    function u3.EmitDistortionAnimate(p23, p24, p25, p26) -- Line: 122
        -- upvalues: RunService (ref), Range (ref), buildPData (copy), u3 (copy)
        if not (p24 and p24.Parent) then
            return;
        end;

        if p23.ActiveAnimates[p24] then
            return;
        end;

        if not RunService:IsClient() then
            return;
        end;

        local Data = p23:GetData(p24);

        if not Data then
            return;
        end;

        local v27 = Range.RandomValueFromRange(Data.Lifetime);
        local v28 = buildPData(p24, Data, v27 <= 0 and 0.001 or v27, p26);
        v28._parentLink = p25;
        v28.IsAnimate = true;
        v28.AnimateItem = p24;
        u3._seedTsOverride(v28, p24);
        p23.ActiveAnimates[p24] = v28;
        p23:_registerEmit(v28, p26);
    end;

    function u3.UpdateDistortion(p29, p30, p31, p32) -- Line: 144
        -- upvalues: Graph (ref), PartConstants (ref), script_Canvas (ref)
        local math_max_ret = math.max((p32 - p30.StartTime) / p30.LifeTime, 0);
        local math_min_ret = math.min(math_max_ret, 1);
        local v33;

        if p30._tsOverride == nil or p32 >= (p30._tsOverrideUntil or 0) then
            v33 = p30.Graphs.Timescale and (Graph.QueryPointsWithTime(math_min_ret, p30.Graphs.Timescale, p30.Seeds.Timescale) or 1) or 1;
        else
            v33 = p30._tsOverride;
        end;

        local v34 = p31 * v33;
        local LifeTime = p30.LifeTime;
        local v35 = (p30._effectiveElapsed or 0) + (p30._timeFrozen and 0 or v34);
        local v36 = v35 < 0 and 0 or v35;

        if LifeTime < v36 then
            v36 = LifeTime;
        end;

        p30._effectiveElapsed = v36;

        if p30.TotalKeyFrames <= 0 then
            return true;
        end;

        local v37;

        if math_min_ret >= 1 then
            v37 = LifeTime <= v36 and true or v36 <= 0;
        else
            v37 = false;
        end;

        if v37 then
            return true;
        end;

        if not p30._timeFrozen then
            p30._phase = p30._phase + v34 * p30._speed * 0.1;
        end;

        local math_max_ret2 = math.max(v36 / LifeTime, 0);
        local v38 = math.min(math_max_ret2, 1) * p30.TotalKeyFrames;
        local math_floor_ret = math.floor(v38);

        if math_floor_ret ~= p30.CurrentStep then
            p30.CurrentStep = math_floor_ret;
            local v39 = math_floor_ret / p30.TotalKeyFrames;
            p30._curAmp = p30.Graphs.Amplitude and (Graph.QueryPointsWithTime(v39, p30.Graphs.Amplitude, p30.Seeds.Amplitude) or 0) or 0;
            local v40 = p30.Graphs.Transparency and Graph.QueryPointsWithTime(v39, p30.Graphs.Transparency, p30.Seeds.Transparency);
            p30._curTrans = v40 and math.clamp(v40, 0, 10) or nil;
        end;

        local workspace_CurrentCamera = workspace.CurrentCamera;

        if not workspace_CurrentCamera then
            return false;
        end;

        local v41 = 0.5;
        local v42 = 0.5;
        local v43 = 1;

        if not p30._screenCenter or p30._falloff > 0 then
            local _originOverride = p30._originOverride;

            if not _originOverride then
                local _parentLink = p30._parentLink;

                if _parentLink and _parentLink.Parent then
                    _originOverride = PartConstants.placeOnLink(_parentLink, p30._parentPlace);
                else
                    local _sourceItem = p30._sourceItem;
                    _originOverride = _sourceItem and (_sourceItem.Parent and _sourceItem.Position) or p30._lastOriginPos;
                end;
            end;

            p30._lastOriginPos = _originOverride;

            if p30._falloff > 0 then
                v43 = math.clamp(1 - (workspace_CurrentCamera.CFrame.Position - _originOverride).Magnitude / p30._falloff, 0, 1);
            end;

            if not p30._screenCenter then
                local v44, _ = workspace_CurrentCamera:WorldToViewportPoint(_originOverride);
                local ViewportSize = workspace_CurrentCamera.ViewportSize;
                v41 = v44.X / math.max(1, ViewportSize.X);
                v42 = 1 - v44.Y / math.max(1, ViewportSize.Y);
                v43 = v43 * math.clamp(v44.Z / 2, 0, 1);
            end;
        end;

        script_Canvas.accumulate(p30._kindId, (p30._curAmp or 0) * p30._strength * v43, p30._wavelength, p30._phase, p30._dirRad, p30._noiseScale, p30._lensRadius, v41, v42, p30._noiseSeed, p30._amplify, p30._allowOver, p30._curTrans, v43, p30._resolution);

        return false;
    end;

    function u3._refreshDistortionAnimate(p45, p46, p47) -- Line: 233
        -- upvalues: u1 (ref)
        p46.Link = nil;
        p46._kindId = u1[p47.FieldKind] or 1;
        p46._wavelength = math.max(p47.Wavelength or 1.5, 0.02);
        p46._speed = p47.Speed or 3;
        p46._dirRad = math.rad(p47.Direction or 0);
        p46._noiseScale = math.max(p47.NoiseScale or 2, 0.05);
        p46._lensRadius = math.max(p47.LensRadius or 1.5, 0.02);
        p46._screenCenter = p47.EpicenterMode == "ScreenCenter";
        p46._falloff = p47.Falloff or 0;
        p46._strength = p47.Strength or 1;
        p46._amplify = p47.Amplify or 0;
        p46._allowOver = p47.AllowOverdrive == true;
        local math_floor_ret = math.floor(p47.Resolution or 24);
        p46._resolution = math.clamp(math_floor_ret, 8, 96);
        p46._curAmp = nil;
        p46._curTrans = nil;
        p46.CurrentStep = -1;
    end;

    function u3._reseedDistortionPhase(p48, p49) -- Line: 257
        if p49._kindId == 1 or (p49._kindId == 4 or p49._kindId == 5) then
            p49._phase = (p49._effectiveElapsed or 0) * p49._speed * 0.1;
        end;
    end;
end;