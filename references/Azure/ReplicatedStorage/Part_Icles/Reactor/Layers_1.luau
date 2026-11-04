 
 

local Sites = require(script.Parent.Sites);
local u1 = { "X", "Y", "Z" };
local v2 = {};

local function along(p3, p4) -- Line: 64
    if p3 == "X" then
        return Vector3.new(p4, 0, 0);
    end;

    if p3 == "Y" then
        return Vector3.new(0, p4, 0);
    end;

    return Vector3.new(0, 0, p4);
end;

local function withAxis(p5, p6, p7) -- Line: 73
    if p6 == "X" then
        return Vector3.new(p7, p5.Y, p5.Z);
    end;

    if p6 == "Y" then
        return Vector3.new(p5.X, p7, p5.Z);
    end;

    return Vector3.new(p5.X, p5.Y, p7);
end;

local function sizeAlong(p8, p9) -- Line: 84
    -- upvalues: u1 (copy)
    local v10 = {};

    for i, v in ipairs({ p8.XVector, p8.YVector, p8.ZVector }) do
        local v11 = v;
        local v12 = nil;

        for _, v3 in ipairs(u1) do
            if math.abs(v11[v3]) >= 0.9998 then
                v12 = v3;
            end;
        end;

        if not v12 or v10[v12] then
            return nil;
        end;

        v10[v12] = p9[u1[i]];
    end;

    return Vector3.new(v10.X, v10.Y, v10.Z);
end;

local function inLine(p13, p14, p15) -- Line: 104
    -- upvalues: u1 (copy), sizeAlong (copy)
    local CFrame2 = p13.CFrame;
    local Size = p13.Size;
    local v16 = {};

    for _, v in ipairs(p14) do
        if v ~= p13 and not p15[v] then
            local v17 = CFrame2:ToObjectSpace(v.CFrame);
            local Position = v17.Position;
            local v18 = v;
            local v19 = 0;
            local v20 = nil;

            for _, v3 in ipairs(u1) do
                if math.abs(Position[v3]) > 0.05 then
                    v19 = v19 + 1;
                    v20 = v3;
                end;
            end;

            local v21;

            if v19 == 1 then
                v21 = sizeAlong(v17, v18.Size);
            else
                v21 = false;
            end;

            if v21 then
                local v22 = true;

                for _, v3 in ipairs(u1) do
                    if v3 ~= v20 and math.abs(Size[v3] - v21[v3]) > 0.05 then
                        v22 = false;
                    end;
                end;

                if v22 then
                    local v23 = v16[v20];

                    if not v23 then
                        v23 = {};
                        v16[v20] = v23;
                    end;

                    local v24 = {
                        part = v18,
                        low = Position[v20] - v21[v20] / 2,
                        high = Position[v20] + v21[v20] / 2
                    };
                    local v25;

                    if v17.XVector.X >= 0.9998 and v17.YVector.Y >= 0.9998 then
                        v25 = v17.ZVector.Z >= 0.9998;
                    else
                        v25 = false;
                    end;

                    v24.aligned = v25;
                    table.insert(v23, v24);
                end;
            end;
        end;
    end;

    return v16;
end;

local function stackOf(p26, p27, p28) -- Line: 149
    local v29 = p26.Size[p27] / 2;
    local v30 = {
        {
            aligned = true,
            part = p26,
            low = -v29,
            high = v29
        }
    };
    local v31 = -v29;
    local v32 = true;

    while v32 do
        v32 = false;

        for i = #p28, 1, -1 do
            local v33 = p28[i];
            local v34;

            if math.abs(v33.low - v29) <= 0.05 then
                v29 = v33.high;
                table.insert(v30, v33);
                table.remove(p28, i);
                v34 = i;
                v32 = true;
            elseif math.abs(v33.high - v31) <= 0.05 then
                v31 = v33.low;
                table.insert(v30, v33);
                table.remove(p28, i);
                v34 = i;
                v32 = true;
            else
                v34 = i;
            end;
        end;
    end;

    if #v30 < 2 then
        return nil;
    end;

    table.sort(v30, function(p35, p36) -- Line: 174
        return p35.low < p36.low;
    end);

    return v30, v31, v29;
end;

local function skinOn(p37, p38, p39, p40, p41, p42) -- Line: 182
    -- upvalues: sizeAlong (copy), u1 (copy)
    local CFrame2 = p37.CFrame;
    local Size = p37.Size;

    for _, v in ipairs(p41) do
        if not p42[v] then
            local v43 = CFrame2:ToObjectSpace(v.CFrame);
            local v44 = sizeAlong(v43, v.Size);

            if v44 then
                local Position = v43.Position;
                local v45 = Position[p38] - v44[p38] / 2;
                local v46 = Position[p38] + v44[p38] / 2;

                if math.abs(v45 - p40) <= 0.05 or math.abs(v46 - p39) <= 0.05 then
                    local v47 = v;
                    local v48 = 1;
                    local v49 = (1 / 0);

                    for _, v3 in ipairs(u1) do
                        if v3 ~= p38 then
                            local v50 = math.min(Position[v3] + v44[v3] / 2, Size[v3] / 2) - math.max(Position[v3] - v44[v3] / 2, -Size[v3] / 2);
                            v48 = v48 * (math.max(v50, 0) / Size[v3]);
                            v49 = math.min(v49, v44[v3]);
                        end;
                    end;

                    if v48 >= 0.25 and v44[p38] <= v49 * 0.2 then
                        return {
                            aligned = false,
                            skin = true,
                            part = v47,
                            low = v45,
                            high = v46
                        };
                    end;
                end;
            end;
        end;
    end;

    return nil;
end;

local function stacked(p51, p52, p53, p54, p55) -- Line: 213
    local v56 = (p54 + p55) / 2;
    local CFrame2 = p51.CFrame;
    local CFrame_new = CFrame.new;
    local v57;

    if p52 == "X" then
        v57 = Vector3.new(v56, 0, 0);
    elseif p52 == "Y" then
        v57 = Vector3.new(0, v56, 0);
    else
        v57 = Vector3.new(0, 0, v56);
    end;

    local v58 = CFrame2 * CFrame_new(v57);
    local Size = p51.Size;
    local v59 = p55 - p54;
    local v60;

    if p52 == "X" then
        v60 = Vector3.new(v59, Size.Y, Size.Z);
    elseif p52 == "Y" then
        v60 = Vector3.new(Size.X, v59, Size.Z);
    else
        v60 = Vector3.new(Size.X, Size.Y, v59);
    end;

    local table_create_ret = table.create(#p53);

    for i, v in ipairs(p53) do
        local v61 = v.low - v56;
        local v62 = v.high - v56;
        local v63 = {
            part = v.part,
            low = v61,
            high = v62,
            aligned = v.aligned,
            skin = v.skin
        };
        local v64 = {
            part = v.part
        };
        local CFrame_new2 = CFrame.new;
        local v65 = (v61 + v62) / 2;
        local v66;

        if p52 == "X" then
            v66 = Vector3.new(v65, 0, 0);
        elseif p52 == "Y" then
            v66 = Vector3.new(0, v65, 0);
        else
            v66 = Vector3.new(0, 0, v65);
        end;

        v64.frame = v58 * CFrame_new2(v66);
        local v67 = v62 - v61;
        local v68;

        if p52 == "X" then
            v68 = Vector3.new(v67, v60.Y, v60.Z);
        elseif p52 == "Y" then
            v68 = Vector3.new(v60.X, v67, v60.Z);
        else
            v68 = Vector3.new(v60.X, v60.Y, v67);
        end;

        v64.size = v68;
        v64.plain = not v.aligned;
        v63.slice = v64;
        table_create_ret[i] = v63;
    end;

    return {
        part = p51,
        frame = v58,
        size = v60,
        axis = p52,
        layers = table_create_ret
    };
end;

local function withSkin(p69, p70, p71, p72, p73, p74, p75) -- Line: 239
    -- upvalues: skinOn (copy)
    local v76 = skinOn(p69, p70, p72, p73, p74, p75);

    if not v76 then
        return false, p72, p73;
    end;

    p75[v76.part] = true;
    table.insert(p71, v76);
    table.sort(p71, function(p77, p78) -- Line: 246
        return p77.low < p78.low;
    end);

    return true, math.min(p72, v76.low), math.max(p73, v76.high);
end;

function v2.grounds(p79, p80) -- Line: 252
    -- upvalues: inLine (copy), u1 (copy), stackOf (copy), withSkin (copy), stacked (copy)
    local table_create_ret = table.create(#p79);
    local v81 = {};
    local v82 = {};
    local v83;

    if #p79 > 1 then
        v83 = #p79 <= 400;
    else
        v83 = false;
    end;

    local v84;

    if p80 == nil or #p80 <= 0 then
        v84 = false;
    else
        v84 = #p79 <= 400;
    end;

    for _, v in ipairs(p79) do
        if not v81[v] then
            v81[v] = true;
            local v85 = nil;
            local v86;

            if v83 then
                local v87 = inLine(v, p79, v81);
                v86 = v;

                for _, v3 in ipairs(u1) do
                    local v88 = v87[v3];

                    if v88 and not v85 then
                        local v89, v90, v91 = stackOf(v86, v3, v88);

                        if v89 then
                            local v92 = v3;

                            for _, v4 in ipairs(v89) do
                                v81[v4.part] = true;
                            end;

                            if v84 then
                                local v93;
                                v93, v90, v91 = withSkin(v86, v92, v89, v90, v91, p80, v82);
                            end;

                            v85 = stacked(v86, v92, v89, v90, v91);
                        end;
                    end;
                end;
            else
                v86 = v;
            end;

            if not v85 and v84 then
                for _, v3 in ipairs(u1) do
                    if not v85 then
                        local v94 = v86.Size[v3] / 2;
                        local v95 = {
                            {
                                aligned = true,
                                part = v86,
                                low = -v94,
                                high = v94
                            }
                        };
                        local v96, v97, v98 = withSkin(v86, v3, v95, -v94, v94, p80, v82);

                        if v96 then
                            v85 = stacked(v86, v3, v95, v97, v98);
                        end;
                    end;
                end;
            end;

            table.insert(table_create_ret, v85 or {
                part = v86,
                frame = v86.CFrame,
                size = v86.Size
            });
        end;
    end;

    return table_create_ret, v82;
end;

function v2.inPatch(p99, p100, p101) -- Line: 300
    local axis = p99.axis;
    local v102 = p100[axis] - p101[axis] / 2;
    local v103 = p100[axis] + p101[axis] / 2;
    local v104 = {};

    for i, v in ipairs(p99.layers) do
        local math_max_ret = math.max(v102, v.low);
        local math_min_ret = math.min(v103, v.high);

        if math_min_ret - math_max_ret > 0.01 then
            local v105 = {
                index = i
            };
            local v106 = (math_max_ret + math_min_ret) / 2 - p100[axis];
            local v107;

            if axis == "X" then
                v107 = Vector3.new(v106, 0, 0);
            elseif axis == "Y" then
                v107 = Vector3.new(0, v106, 0);
            else
                v107 = Vector3.new(0, 0, v106);
            end;

            v105.offset = v107;
            local v108 = math_min_ret - math_max_ret;
            local v109;

            if axis == "X" then
                v109 = Vector3.new(v108, p101.Y, p101.Z);
            elseif axis == "Y" then
                v109 = Vector3.new(p101.X, v108, p101.Z);
            else
                v109 = Vector3.new(p101.X, p101.Y, v108);
            end;

            v105.size = v109;
            v105.skin = v.skin and v.part or nil;
            table.insert(v104, v105);
        end;
    end;

    return v104;
end;

function v2.clip(p110, p111, p112, p113) -- Line: 320
    -- upvalues: Sites (copy)
    if p113.axis == p110.axis then
        return p112;
    end;

    local v114 = Sites.faceAxes(p113.axis);
    local v115 = (p111.low + p111.high) / 2;
    local v116 = {};

    for _, v in ipairs(p112) do
        local minU = v.minU;
        local minV = v.minV;
        local maxU = v.maxU;
        local maxV = v.maxV;

        if v114 == p110.axis then
            minU = math.max(minU, p111.low) - v115;
            maxU = math.min(maxU, p111.high) - v115;
        else
            minV = math.max(minV, p111.low) - v115;
            maxV = math.min(maxV, p111.high) - v115;
        end;

        if maxU - minU > 0.01 and maxV - minV > 0.01 then
            table.insert(v116, {
                minU = minU,
                minV = minV,
                maxU = maxU,
                maxV = maxV
            });
        end;
    end;

    return v116;
end;

return v2;