 

 

local Graph = require(script.Parent.Parent.Graph);
local Range = require(script.Parent.Parent.Range);
local PartConstants = require(script.Parent.Parent.PartConstants);
local LinkCF = require(script.Parent.Parent.LinkCF);
local AxisLinks = require(script.Parent.Parent.AxisLinks);
local Pool = require(script.Parent.Parent.Pool);
local DirectionVectors = PartConstants.DirectionVectors;
local u1 = { "Speed", "RotSpeedX", "RotSpeedY", "RotSpeedZ", "PosOffsetX", "PosOffsetY", "PosOffsetZ", "AccelStrength" };
local u2 = { "Speed", "RotSpeedX", "RotSpeedY", "RotSpeedZ", "PosOffsetX", "PosOffsetY", "PosOffsetZ", "Turbulence" };
local u3 = { "RotX", "RotY", "RotZ", "PosX", "PosY", "PosZ" };
local u5 = {
    hostFrame = function(p4) -- Line: 57, Name: hostFrame
        if p4:IsA("Attachment") then
            return p4.WorldCFrame;
        end;

        return p4.CFrame;
    end
};

local function isFlat(p6) -- Line: 64
    if typeof(p6) ~= "NumberSequence" then
        return true;
    end;

    for _, v in ipairs(p6.Keypoints) do
        if v.Value ~= 0 or v.Envelope ~= 0 then
            return false;
        end;
    end;

    return true;
end;

function u5.linkOf(p7, p8, p9) -- Line: 76
    if p9 and p9.IgnoreLink then
        return nil;
    end;

    return p8 or p7.Link;
end;

function u5.travels(p10, p11) -- Line: 83
    -- upvalues: u2 (copy), isFlat (copy)
    local Motion = p10.Motion;

    if p11 then
        return true;
    end;

    if Motion.ParticleData.Acceleration.Magnitude > 0 then
        return true;
    end;

    if Motion.AccelerationTowardsInstance and Motion.AccelTarget then
        return true;
    end;

    for _, v in ipairs(u2) do
        if not isFlat(Motion[v]) then
            return true;
        end;
    end;

    return false;
end;

function u5.length(p12, p13, p14) -- Line: 105
    -- upvalues: u5 (copy)
    if p12.ActsAs == "Continuous" then
        return p14;
    end;

    if u5.travels(p12, p13) or p12.Timescale then
        return math.max(p14, p12.TravelTime);
    end;

    return p12.TravelTime;
end;

function u5.start(p15, p16, p17, p18, p19, p20) -- Line: 115
    -- upvalues: u5 (copy), LinkCF (copy), DirectionVectors (copy), AxisLinks (copy), Range (copy), PartConstants (copy), u1 (copy), Graph (copy)
    local Motion = p17.Motion;
    local v21 = u5.hostFrame(p16);
    local v22;

    if p19 then
        v22 = p19._linkLocal or nil;
    else
        v22 = nil;
    end;

    local v23 = LinkCF.spawnAxes(Motion, p19);
    local v24 = nil;

    if p19 then
        if p19.EventOriginResolver then
            v24 = p19.EventOriginResolver();
        end;

        v24 = v24 or p19.EventOriginCF;
    end;

    if v24 then
        if not p19.UseFullOrigin then
            v24 = CFrame.new(v24.Position) * v21.Rotation;
        end;
    elseif p18 then
        local v25;

        if p19 then
            v25 = p19._sourceParentCF;
        else
            v25 = p19;
        end;

        v24 = LinkCF.spawnFrame(Motion.LinkMode, p18, p16, v21, v22, v25, v23);
    else
        v24 = v21;
    end;

    local v26 = DirectionVectors[Motion.EmissionDirection] or DirectionVectors[Enum.NormalId.Top];
    local v27 = v24[v26.vector] * v26.multiplier;
    local v28 = AxisLinks.sampleRangeAxes(Motion, Motion.AxisLinks, { "RotX", "RotY", "RotZ" }, Range, p19);
    local v29 = PartConstants.composeRotation(Motion.RotOrder, v28.RotX, v28.RotY, v28.RotZ);
    local v30 = PartConstants.applyPositionOffset(v24 * v29, Motion, p18, p16, Range, AxisLinks, p19, nil, 1);
    local DirMode = Motion.DirMode;

    if DirMode == "Global" then
        v30 = CFrame.new(v30.Position) * v29;
    end;

    if DirMode == "Local" then
        v27 = v30[v26.vector] * v26.multiplier;
    elseif DirMode == "Global" then
        v27 = CFrame.new()[v26.vector] * v26.multiplier;
    end;

    local SpreadAngle = Motion.ParticleData.SpreadAngle;
    local v31, v32;

    if SpreadAngle.X > 0 or SpreadAngle.Y > 0 then
        v31 = (math.random() * 2 - 1) * SpreadAngle.X;
        v32 = (math.random() * 2 - 1) * SpreadAngle.Y;
    else
        v31 = 0;
        v32 = 0;
    end;

    local CFrame_Angles_ret = CFrame.Angles(math.rad(v31), math.rad(v32), 0);
    local LookVector = (CFrame.lookAt(Vector3.new(), v27) * CFrame_Angles_ret).LookVector;
    local v33 = {};

    for _, v in ipairs(u1) do
        v33[v] = Graph.GenerateSeed(Motion[v]);
    end;

    AxisLinks.applyGraphAxisAliases(Motion, v33, Motion.AxisLinks);
    local math_ceil_ret = math.ceil(p20 * 60);
    Motion.TotalKeyFrames = math.clamp(math_ceil_ret, 1, 240);
    local v34, v35 = p15:PreSimulateForward(Motion, v33, v30, LookVector, CFrame_Angles_ret, p18, p20, 240, v30.Rotation * v29:Inverse(), v22, v23 and v21 and v21 or nil);
    local v36 = LinkCF.emitParentFrame(Motion.LinkMode, p18, v22, v23, v21);

    return {
        frames = v34,
        steps = v35,
        linkLocal = v22,
        rigid = LinkCF.rigidSnapshot(Motion.LinkMode, p18, v36),
        reversed = Motion.InvertMotion == true
    };
end;

function u5.frame(p37, p38) -- Line: 194
    -- upvalues: LinkCF (copy)
    local _pathSteps = p37._pathSteps;
    local v39 = math.clamp(p38, 0, 1) * _pathSteps;

    if p37._pathReversed then
        v39 = _pathSteps - v39;
    end;

    local math_floor_ret = math.floor(v39);
    local math_clamp_ret = math.clamp(math_floor_ret, 0, _pathSteps);
    local math_min_ret = math.min(math_clamp_ret + 1, _pathSteps);
    local _pathFrames = p37._pathFrames;
    local v40 = _pathFrames[math_clamp_ret]:Lerp(_pathFrames[math_min_ret], v39 - math_clamp_ret);

    return LinkCF.reapplyFrame(p37.LinkMode, LinkCF.parentFrame(p37), v40);
end;

function u5.sketch(p41, p42, p43, p44) -- Line: 207
    -- upvalues: u3 (copy), u5 (copy), Pool (copy), LinkCF (copy)
    local table_clone_ret = table.clone(p43.Motion);

    for _, v in ipairs(u3) do
        local v45 = table_clone_ret[v];
        table_clone_ret[v] = NumberRange.new((v45.Min + v45.Max) / 2);
    end;

    table_clone_ret.ParticleData = table.clone(table_clone_ret.ParticleData);
    table_clone_ret.ParticleData.SpreadAngle = Vector2.new(0, 0);
    local v46 = u5.linkOf(p43, nil, nil);
    local v47 = u5.length(p43, v46, p43.Lifetime.Max);
    local math_max_ret = math.max(v47, 0.016666666666666666);
    local v48 = u5.start(p41, p42, {
        Motion = table_clone_ret
    }, v46, nil, math_max_ret);
    local v49 = {
        Link = v46,
        LinkMode = p43.LinkMode,
        LinkAxes = p43.LinkAxes,
        _sourceItem = p42,
        _linkLocal = v48.linkLocal,
        _rigidLocalParentCF = v48.rigid,
        _pathFrames = v48.frames,
        _pathSteps = v48.steps,
        _pathReversed = v48.reversed
    };

    if v46 then
        v49._linkGen = Pool.linkGen(v46);
    end;

    LinkCF.captureEmitFrame(v49);
    local v50 = {};

    for i = 0, p44 do
        v50[i + 1] = u5.frame(v49, i / p44);
        local _ = i;
    end;

    return v50;
end;

return u5;