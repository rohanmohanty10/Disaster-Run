 

 

local Graph = require(script.Parent.Graph);
local Range = require(script.Parent.Range);
local script_Fields = require(script.Fields);
local script_Registry = require(script.Registry);
local script_Path = require(script.Path);

local function ownTimescale(p1, p2, p3) -- Line: 44
    -- upvalues: Graph (copy)
    local _ownTime = p1._ownTime;

    if _ownTime.play._released then
        return 1;
    end;

    p1._realAge = p1._realAge + p2;
    local v4 = p1._realAge / p1._timeSpan;

    if v4 >= 1 then
        _ownTime.play._released = true;
        _ownTime.timescale = 1;

        return 1;
    end;

    local v5 = Graph.QueryPointsWithTime(v4, p1._timescaleGraph, p1._timescaleSeed);
    local math_max_ret = math.max(v5, 0);
    _ownTime.timescale = math_max_ret * p3;

    return math_max_ret;
end;

return function(u6) -- Line: 61
    -- upvalues: script_Registry (copy), Graph (copy), script_Path (copy), script_Fields (copy), Range (copy)
    function u6._isForce(p7) -- Line: 64
        local v8 = (p7:IsA("BasePart") or p7:IsA("Attachment")) and p7:GetAttribute("IsForce") == true;

        return v8;
    end;

    function u6.UpdateForce(p9, p10, p11, p12) -- Line: 68
        -- upvalues: script_Registry (ref), Graph (ref), script_Path (ref), script_Fields (ref)
        if p10._finished then
            return true;
        end;

        local v13 = script_Registry.timescale(p10._time);

        if p10._ownTime then
            local _ownTime = p10._ownTime;
            local v14;

            if _ownTime.play._released then
                v14 = 1;
            else
                p10._realAge = p10._realAge + p11;
                local v15 = p10._realAge / p10._timeSpan;

                if v15 >= 1 then
                    _ownTime.play._released = true;
                    _ownTime.timescale = 1;
                    v14 = 1;
                else
                    local v16 = Graph.QueryPointsWithTime(v15, p10._timescaleGraph, p10._timescaleSeed);
                    v14 = math.max(v16, 0);
                    _ownTime.timescale = v14 * v13;
                end;
            end;

            v13 = v13 * v14;
        end;

        if p10._tsOverride ~= nil and p12 < (p10._tsOverrideUntil or 0) then
            v13 = p10._tsOverride;
        end;

        local LifeTime = p10.LifeTime;
        local _effectiveElapsed = p10._effectiveElapsed;

        if not p10._timeFrozen then
            _effectiveElapsed = math.clamp(_effectiveElapsed + p11 * v13, 0, LifeTime);
            p10._effectiveElapsed = _effectiveElapsed;
        end;

        local _record = p10._record;
        local v17 = script_Path.frame(p10, _effectiveElapsed / LifeTime);
        _record.field.origin = script_Fields.orient(v17, p10._face);
        _record.moving = (v17.Position - p10._lastPlace).Magnitude > 0.001;
        p10._lastPlace = v17.Position;

        if (v17.Position - p10._announcedAt).Magnitude > 2 then
            p10._announcedAt = v17.Position;
            script_Registry.announce(_record);
        end;

        _record.age = _effectiveElapsed;

        if _record.travelSpeed > 0 then
            _record.front = _record.travelSpeed * _effectiveElapsed;
        end;

        _record.strength = Graph.QueryPointsWithTime(_effectiveElapsed / LifeTime, p10._strengthGraph, p10._strengthSeed);

        if LifeTime <= _effectiveElapsed then
            p10._finished = true;
        end;

        return false;
    end;

    function u6.EmitForce(p18, p19, p20, p21) -- Line: 107
        -- upvalues: script_Path (ref), script_Fields (ref), Range (ref), Graph (ref), script_Registry (ref), u6 (copy)
        if not (p19 and p19.Parent) then
            return;
        end;

        local EmitData = p18:GetEmitData(p19, p21);

        if not EmitData then
            return;
        end;

        local v22 = script_Path.linkOf(EmitData, p20, p21);
        local v23 = script_Fields.frontSpeed(EmitData.Range, EmitData.TravelTime);
        local v24 = Range.RandomValueFromRange(EmitData.Lifetime);
        local v25 = script_Path.length(EmitData, v22, v24);
        local math_max_ret = math.max(v25, 0.001);
        local v26 = script_Path.start(p18, p19, EmitData, v22, p21, math_max_ret);
        local v27 = Graph.GenerateSeed(EmitData.Strength);
        local v28;

        if p21 then
            v28 = p21._containerDrive or nil;
        else
            v28 = nil;
        end;

        local v29, u30;

        if EmitData.Timescale then
            v29 = Graph.GenerateSeed(EmitData.Timescale);
            local v31 = Graph.QueryPointsWithTime(0, EmitData.Timescale, v29);
            u30 = {
                timescale = math.max(v31, 0) * script_Registry.timescale(v28),
                play = {
                    _released = false
                }
            };
        else
            v29 = nil;
            u30 = nil;
        end;

        local v32 = {
            Type = "Force",
            VisualPart = nil,
            TotalKeyFrames = 1,
            CurrentStep = -1,
            PartLife = 0,
            _effectiveElapsed = 0,
            _finished = false,
            _announcedAt = Vector3.new(0, 0, 0),
            _lastPlace = Vector3.new(0, 0, 0),
            _realAge = 0,
            Events = EmitData.Events,
            StartTime = os.clock(),
            LifeTime = math_max_ret,
            Graphs = {},
            Seeds = {},
            _sourceItem = p19,
            Link = v22,
            LinkMode = EmitData.LinkMode,
            LinkAxes = EmitData.LinkAxes,
            _linkLocal = v26.linkLocal,
            _rigidLocalParentCF = v26.rigid,
            _pathFrames = v26.frames,
            _pathSteps = v26.steps,
            _pathReversed = v26.reversed,
            _face = EmitData.EmissionDirection.Name,
            _strengthGraph = EmitData.Strength,
            _strengthSeed = v27,
            _time = v28,
            _ownTime = u30,
            _timescaleGraph = EmitData.Timescale,
            _timescaleSeed = v29,
            _timeSpan = math.max(v24, 0.001)
        };
        u6._seedTsOverride(v32, p19);
        p18:_registerEmit(v32, p21);

        if not table.find(p18.ActiveEmits, v32) then
            return;
        end;

        local v33 = script_Path.frame(v32, 0);
        v32._announcedAt = v33.Position;
        v32._lastPlace = v33.Position;
        local v34 = script_Fields.new(EmitData.Shape, script_Fields.orient(v33, v32._face), EmitData);

        if EmitData.ActsAs == "Continuous" and EmitData.Shape ~= "Vortex" then
            v34.lift = 0;
        end;

        local u35 = {
            age = 0,
            field = v34,
            actsAs = EmitData.ActsAs,
            strength = Graph.QueryPointsWithTime(0, EmitData.Strength, v27),
            falloff = EmitData.Falloff,
            travelSpeed = v23,
            front = v23 > 0 and 0 or (1 / 0),
            length = math_max_ret,
            variation = EmitData.Variation,
            turbulence = EmitData.Turbulence,
            sizeResponse = EmitData.SizeResponse,
            group = EmitData.Group,
            seed = math.random(),
            time = v32._time,
            ownTime = u30
        };

        if EmitData.After ~= "Reactor\'s" then
            u35.after = EmitData.After;
            u35.afterDelay = EmitData.AfterDelay;
        end;

        if EmitData.Pieces >= 2 then
            u35.pieces = math.floor(EmitData.Pieces);
        end;

        if EmitData.Cut ~= "Off" and (EmitData.Shape == "Linear" and EmitData.ActsAs == "Impulse") then
            u35.cut = {
                mode = EmitData.Cut,
                pushAlong = EmitData.PushAlong,
                pushApart = EmitData.PushApart,
                noise = EmitData.CutNoise,
                noiseScale = EmitData.CutNoiseScale
            };
        end;

        v32._record = u35;

        function v32._onReclaim() -- Line: 220
            -- upvalues: script_Registry (ref), u35 (copy), u30 (ref)
            script_Registry.remove(u35);

            if u30 then
                u30.play._released = true;
            end;
        end;

        script_Registry.add(u35);
    end;
end;