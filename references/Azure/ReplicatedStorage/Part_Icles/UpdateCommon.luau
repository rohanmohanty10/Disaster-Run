 

 

local Graph = require(script.Parent.Graph);
local PartConstants = require(script.Parent.PartConstants);
local Turbulence = require(script.Parent.Turbulence);
local TURNING_DISPLACEMENT = PartConstants.TURNING_DISPLACEMENT;

local function _rawOffset(p1, p2) -- Line: 13
    -- upvalues: Graph (copy)
    return p1._staticPosOffsetX or (p1.Graphs.PosOffsetX and (Graph.QueryPointsWithTime(p2, p1.Graphs.PosOffsetX, p1.Seeds.PosOffsetX) or 0) or 0), p1._staticPosOffsetY or (p1.Graphs.PosOffsetY and (Graph.QueryPointsWithTime(p2, p1.Graphs.PosOffsetY, p1.Seeds.PosOffsetY) or 0) or 0), p1._staticPosOffsetZ or (p1.Graphs.PosOffsetZ and Graph.QueryPointsWithTime(p2, p1.Graphs.PosOffsetZ, p1.Seeds.PosOffsetZ) or 0);
end;

local function _startAngles(p3, p4) -- Line: 64
    -- upvalues: Graph (copy)
    return (p3._staticRotSpeedX or Graph.QueryPointsWithTime(0, p3.Graphs.RotSpeedX, p3.Seeds.RotSpeedX)) * p4, (p3._staticRotSpeedY or Graph.QueryPointsWithTime(0, p3.Graphs.RotSpeedY, p3.Seeds.RotSpeedY)) * p4, (p3._staticRotSpeedZ or Graph.QueryPointsWithTime(0, p3.Graphs.RotSpeedZ, p3.Seeds.RotSpeedZ)) * p4;
end;

return {
    _posOffsetFrameDelta = function(p5, p6, p7) -- Line: 33, Name: _posOffsetFrameDelta
        -- upvalues: _rawOffset (copy), PartConstants (copy), Turbulence (copy)
        if not (p5.HasPosOffsetGraphs or p5.HasTurbulence) then
            return Vector3.new(0, 0, 0), false;
        end;

        local v8;

        if p5.HasPosOffsetGraphs then
            local v9, v10, v11 = _rawOffset(p5, p6);
            local v12 = PartConstants.resolveDisplacement(Vector3.new(v9, v10, v11), p5.DisplacementMode or "Global", p5.SpawnRotation, p5.SpawnEmitterRotation, p5._displacementMirrorX, p5._displacementMirrorY, p5._displacementMirrorZ);
            v8 = v12 - p5._prevWorldOff;
            p5._prevWorldOff = v12;
        else
            v8 = Vector3.new(0, 0, 0);
        end;

        if p5.HasTurbulence then
            v8 = v8 + Turbulence.frameDelta(p5, p6);
        end;

        if p7 then
            p7 = (p5.DisplacementMode or "Global") ~= "Global";
        end;

        return v8, p7;
    end,

    _composeLocalDelta = function(p13, p14, p15, p16, p17, p18) -- Line: 122, Name: _composeLocalDelta
        if p14 then
            return (p13:VectorToObjectSpace(p15) + (p17 and p16 and p16 or p13:VectorToObjectSpace(p16))) * p18;
        end;

        return (p15 + p16) * p18;
    end,

    _turnsDisplacement = function(p19) -- Line: 59, Name: _turnsDisplacement
        -- upvalues: TURNING_DISPLACEMENT (copy)
        local v20;

        if p19.HasPosOffsetGraphs == true then
            v20 = p19.DisplacementMode == TURNING_DISPLACEMENT;
        else
            v20 = false;
        end;

        return v20;
    end,

    _turnedFrameDelta = function(p21, p22, p23, p24, p25, p26, p27, p28) -- Line: 77, Name: _turnedFrameDelta
        -- upvalues: _startAngles (copy), PartConstants (copy), _rawOffset (copy), Turbulence (copy)
        local _turnX = p21._turnX;
        local _turnY = p21._turnY;
        local _turnZ = p21._turnZ;

        if p21.RotMode == "Speed" then
            local v29 = p21.LifeTime / p21.TotalKeyFrames * p24;
            _turnX = _turnX or 0;
            _turnY = _turnY or 0;
            _turnZ = _turnZ or 0;
            p26 = _turnX + p26 * v29;
            p27 = _turnY + p27 * v29;
            p28 = _turnZ + p28 * v29;
        elseif not _turnX then
            _turnX, _turnY, _turnZ = _startAngles(p21, p25);
        end;

        p21._turnX = p26;
        p21._turnY = p27;
        p21._turnZ = p28;
        local v30 = p21._spinAccumX or 0;
        local v31 = p21._spinAccumY or 0;
        local v32 = p21._spinAccumZ or 0;
        local v33 = PartConstants.midRotation(p21.RotOrder or "Global", _turnX + v30, _turnY + v31, _turnZ + v32, p26 + v30, p27 + v31, p28 + v32);
        local v34, v35, v36 = _rawOffset(p21, p22);
        local Vector3_new_ret = Vector3.new(v34, v35, v36);
        local v37 = p21._prevRawOff or Vector3.new(_rawOffset(p21, 0));
        p21._prevRawOff = Vector3_new_ret;
        local v38 = (p21.SpawnRotation * v33):VectorToWorldSpace(Vector3_new_ret - v37);
        local _displacementMirrorX = p21._displacementMirrorX;

        if _displacementMirrorX then
            v38 = _displacementMirrorX * v38.X + p21._displacementMirrorY * v38.Y + p21._displacementMirrorZ * v38.Z;
        end;

        if p21.HasTurbulence then
            v38 = v38 + Turbulence.frameDelta(p21, p22);
        end;

        return v38, p23;
    end
};