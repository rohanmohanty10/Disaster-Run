 
 

local Graph = require(script.Parent.Parent.Graph);
local Flipbook = require(script.Parent.Parent.Flipbook);
local Field = require(script.Parent.Field);
local Layer = require(script.Parent.Layer);
local Twins = require(script.Parent.Twins);
local View = require(script.Parent.View);
local u1 = {
    MASK_NEAREST = 1
};
local u2 = 0;
local u3 = 1;
local u4 = 0;

function u1.begin() -- Line: 48
    -- upvalues: u2 (ref)
    u2 = 0;
end;

function u1.finish() -- Line: 52
    -- upvalues: View (copy), u2 (ref), u3 (ref), u4 (ref)
    local v5 = View.shareOf(u2);

    if v5 >= u3 then
        if u3 < v5 then
            u4 = u4 + 1;

            if u4 >= 120 then
                u3 = v5;
                u4 = 0;

                return;
            end;
        else
            u4 = 0;
        end;

        return;
    end;

    u3 = v5;
    u4 = 0;
end;

function u1.share() -- Line: 69
    -- upvalues: u3 (ref)
    return u3;
end;

local function leave(p6, p7) -- Line: 74
    -- upvalues: Twins (copy), Layer (copy)
    Twins.destroy(p7);

    if not p6._layer then
        Layer.rest(p7.layer);
        table.insert(p6._spare, p7.layer);
    end;
end;

local function placeShared(p8, p9, p10, p11) -- Line: 84
    -- upvalues: View (copy), Twins (copy), Layer (copy), u3 (ref), u2 (ref), u1 (copy), Field (copy)
    local CFrame = p9.CFrame;
    local ViewportSize = p9.ViewportSize;
    local v12 = ViewportSize.X / math.max(ViewportSize.Y, 1);
    local _shapes = p8._shapes;
    local v13 = p8._shrink or 1;
    local v14 = p8._shrink == nil;
    local v15 = View.sceneReach(p9.FieldOfView, v12);
    Twins.scene(CFrame.Position, v13);
    local v16 = 0;
    local v17 = (1 / 0);
    local v18 = 0;
    local v19 = 0;
    local v20 = 0;
    local v21 = 0;
    local v22 = nil;

    for i = #_shapes, 1, -1 do
        local v23 = _shapes[i];
        local v24;

        if Twins.alive(v23) then
            local v25, v26 = Twins.follow(v23);

            if v25 then
                local Position = v25.Position;
                local v27 = View.along(CFrame, Position);
                local v28 = v26.Magnitude * 0.5;
                v19 = v19 + v27;
                v20 = v20 + 1;
                v16 = math.max(v16, v27 + v28);
                v17 = math.min(v17, v27 - v28);
                local v29 = v28 / math.max((Position - CFrame.Position).Magnitude, View.NEAREST);

                if v18 < v29 then
                    v22 = v23;
                    v18 = v29;
                end;

                if v23 == p8._lead then
                    v21 = v29;
                    v24 = i;
                else
                    v24 = i;
                end;
            else
                v24 = i;
            end;
        else
            Twins.destroy(v23);

            if not p8._layer then
                Layer.rest(v23.layer);
                table.insert(p8._spare, v23.layer);
            end;

            _shapes[i] = _shapes[#_shapes];
            _shapes[#_shapes] = nil;
            v24 = i;
        end;
    end;

    if v14 and v20 > 0 then
        v13 = View.shrinkFor(v16, v17, v15);

        if v13 ~= 1 then
            Twins.scene(CFrame.Position, v13);

            for _, v in ipairs(_shapes) do
                Twins.follow(v);
            end;
        end;
    end;

    local v30 = nil;

    if v20 > 0 and p8.ViewMode == View.MODES.SemiTilt then
        local _lead = p8._lead;

        if v21 ~= 0 and v21 * 1.2 >= v18 then
            v22 = _lead;
        end;

        if not (v22 and v22.frame) then
            for _, v in ipairs(_shapes) do
                if v.frame then
                    v22 = v;
                    break;
                end;
            end;
        end;

        p8._lead = v22;
        local _group = p8._group;
        View.groupStart(_group, v22.frame);

        for _, v in ipairs(_shapes) do
            if v.frame then
                View.groupAdd(_group, v.frame, v.size);
            end;
        end;

        local v31, v32 = View.groupBox(_group);
        v30 = View.sheet(p8._sheet, CFrame, p9.FieldOfView, v12, ViewportSize.Y, v31, v32, u3);
    elseif v20 > 0 then
        local v33 = View.sharedDepth(p8.ViewMode, v17, v19 / v20);
        v30 = View.facing(p8._sheet, CFrame, p9.FieldOfView, v12, ViewportSize.Y, v33, u3);
    end;

    if v30 then
        u2 = u2 + 1;
    end;

    if p11 and v20 > 0 then
        p11.distance = math.max(v17 * 0.9, u1.MASK_NEAREST);
    end;

    Layer.place(p8._layer, p9, v30, v16, p8.TextureScale, Field.SPANS, p8._picture, p10, p11, v13);

    if v20 > 0 then
        p8._shrink = View.shrinkFor(v16, v17, v15);
    end;
end;

local function clockOf(p34, p35, p36, p37, p38) -- Line: 182
    -- upvalues: Graph (copy)
    if not p37 then
        return p36;
    end;

    local v39 = Graph.QueryPointsWithTime(p35, p37, p38);

    return math.max(v39, 0) * p34.LifeTime;
end;

function u1.frame(p40, p41) -- Line: 189
    -- upvalues: Graph (copy), View (copy), Flipbook (copy), placeShared (copy), Layer (copy), Twins (copy), u3 (ref), u1 (copy), u2 (ref), Field (copy)
    local _effectiveElapsed = p40._effectiveElapsed;
    local CFrame = p41.CFrame;
    local ViewportSize = p41.ViewportSize;
    local v42 = ViewportSize.X / math.max(ViewportSize.Y, 1);
    local FieldOfView = p41.FieldOfView;
    local math_clamp_ret = math.clamp(_effectiveElapsed / p40.LifeTime, 0, 1);
    local Graphs = p40.Graphs;
    local Seeds = p40.Seeds;
    local v43 = Graph.QueryPointsWithTime(math_clamp_ret, Graphs.Brightness, Seeds.Brightness);
    local math_max_ret = math.max(v43, 0);
    local v44 = Graph.QueryPointsWithTime(math_clamp_ret, Graphs.Transparency, Seeds.Transparency);
    local math_clamp_ret2 = math.clamp(v44, 0, 1);
    local v45 = Graph.QueryColorPointWithTime(math_clamp_ret, Graphs.Color);
    local v46;

    if p40._mask then
        local v47 = Graph.QueryPointsWithTime(math_clamp_ret, Graphs.EdgeBrightness, Seeds.EdgeBrightness);
        local math_max_ret2 = math.max(v47, 0);
        local v48, v49;
        math_max_ret, v48, v49 = View.glow(math_max_ret, math_max_ret2);

        if v48 < 1 then
            v45 = Color3.new(v45.R * v48, v45.G * v48, v45.B * v48);
        end;

        local v50 = Graph.QueryColorPointWithTime(math_clamp_ret, Graphs.EdgeColor);
        v46 = Color3.new(v50.R * v49, v50.G * v49, v50.B * v49);
    else
        v46 = nil;
    end;

    local _flip = p40._flip;
    local v51;

    if _flip then
        local frameIndex = Flipbook.frameIndex;
        local FlipbookTime = Graphs.FlipbookTime;
        local FlipbookTime2 = Seeds.FlipbookTime;
        local v52;

        if FlipbookTime then
            local v53 = Graph.QueryPointsWithTime(math_clamp_ret, FlipbookTime, FlipbookTime2);
            v52 = math.max(v53, 0) * p40.LifeTime;
        else
            v52 = _effectiveElapsed;
        end;

        v51 = frameIndex(_flip, v52, p40.LifeTime) or 0;
    else
        v51 = 0;
    end;

    local _mask = p40._mask;

    if _mask then
        local _maskFlip = p40._maskFlip;
        local v54;

        if _maskFlip then
            local frameIndex = Flipbook.frameIndex;
            local MaskFlipbookTime = Graphs.MaskFlipbookTime;
            local MaskFlipbookTime2 = Seeds.MaskFlipbookTime;

            if MaskFlipbookTime then
                local v55 = Graph.QueryPointsWithTime(math_clamp_ret, MaskFlipbookTime, MaskFlipbookTime2);
                _effectiveElapsed = math.max(v55, 0) * p40.LifeTime;
            end;

            v54 = frameIndex(_maskFlip, _effectiveElapsed, p40.LifeTime) or 0;
        else
            v54 = 0;
        end;

        _mask.frame = v54;
    end;

    if p40._layer then
        placeShared(p40, p41, v51, _mask);
        Layer.look(p40._layer, math_max_ret, math_clamp_ret2, v45, v46);

        return;
    end;

    local _shapes = p40._shapes;
    local v56 = View.sceneReach(FieldOfView, v42);

    for i = #_shapes, 1, -1 do
        local v57 = _shapes[i];
        local v58;

        if Twins.alive(v57) then
            local v59 = v57.shrink or 1;
            local v60 = v57.shrink == nil;
            Twins.scene(CFrame.Position, v59);
            local v61, v62 = Twins.follow(v57);
            local v63, v64;

            if v61 then
                local v65 = View.along(CFrame, v61.Position);
                local v66 = v62.Magnitude * 0.5;
                v63 = v65 + v66;
                v57.shrink = View.shrinkFor(v63, v65 - v66, v56);

                if v60 and v57.shrink ~= 1 then
                    v59 = v57.shrink;
                    Twins.scene(CFrame.Position, v59);
                    Twins.follow(v57);
                end;

                v64 = View.sheet(v57.sheet, CFrame, FieldOfView, v42, ViewportSize.Y, v61, v62, u3);

                if _mask then
                    _mask.distance = math.max((v65 - v66) * 0.9, u1.MASK_NEAREST);
                end;
            else
                v64 = nil;
                v63 = 0;
            end;

            if v64 then
                u2 = u2 + 1;
            end;

            Layer.place(v57.layer, p41, v64, v63, p40.TextureScale, Field.SPANS, p40._picture, v51, _mask, v59);
            Layer.look(v57.layer, math_max_ret, math_clamp_ret2, v45, v46);
            v58 = i;
        else
            Twins.destroy(v57);

            if not p40._layer then
                Layer.rest(v57.layer);
                table.insert(p40._spare, v57.layer);
            end;

            _shapes[i] = _shapes[#_shapes];
            _shapes[#_shapes] = nil;
            v58 = i;
        end;
    end;
end;

return u1;