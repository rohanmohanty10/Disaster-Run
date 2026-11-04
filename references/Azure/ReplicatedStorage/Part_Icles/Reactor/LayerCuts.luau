 

 

local u1 = { "X", "Y", "Z" };
local v2 = {};
local u3 = nil;
local u4 = nil;
local u5 = nil;

function v2.use(p6, p7, p8) -- Line: 49
    -- upvalues: u3 (ref), u4 (ref), u5 (ref)
    u3 = p6;
    u4 = p7;
    u5 = p8;
end;

local function along(p9, p10) -- Line: 55
    if p9 == "X" then
        return Vector3.new(p10, 0, 0);
    end;

    if p9 == "Y" then
        return Vector3.new(0, p10, 0);
    end;

    return Vector3.new(0, 0, p10);
end;

function v2.stamp(p11, p12) -- Line: 64
    for _, v in ipairs(p11) do
        v.layer = p12.index;
    end;
end;

local function joined(p13, p14, p15, p16) -- Line: 72
    -- upvalues: u4 (ref)
    local v17 = p14[1];

    if #p14 == 1 then
        local v18 = u4(v17.instance, p13, p15, p16);
        v18.layer = v17.layer;

        return v18;
    end;

    local v19 = nil;
    local v20 = nil;

    for _, v in ipairs(p14) do
        local v21 = p13:PointToObjectSpace(v.instance.ExtentsCFrame.Position);
        local v22 = v.instance.ExtentsSize / 2;
        local v23 = v21 - v22;
        local v24 = v21 + v22;

        if v19 then
            local math_min_ret = math.min(v19.X, v23.X);
            local math_min_ret2 = math.min(v19.Y, v23.Y);
            local math_min_ret3 = math.min(v19.Z, v23.Z);
            v19 = Vector3.new(math_min_ret, math_min_ret2, math_min_ret3);
            local math_max_ret = math.max(v20.X, v24.X);
            local math_max_ret2 = math.max(v20.Y, v24.Y);
            local math_max_ret3 = math.max(v20.Z, v24.Z);
            v20 = Vector3.new(math_max_ret, math_max_ret2, math_max_ret3);
        else
            v20 = v24;
            v19 = v23;
        end;
    end;

    local CFrame_new_ret = CFrame.new((v19 + v20) / 2);
    local v25 = p13 * CFrame_new_ret;
    local table_create_ret = table.create(#p14);

    for i, v in ipairs(p14) do
        local instance = v.instance;
        table_create_ret[i] = {
            template = instance,
            layer = v.layer,
            standOffset = v25:ToObjectSpace(instance.CFrame),
            offset = v25:ToObjectSpace(instance.ExtentsCFrame),
            size = instance.ExtentsSize
        };
    end;

    return {
        template = v17.instance,
        box = CFrame_new_ret,
        size = v20 - v19,
        standOffset = table_create_ret[1].standOffset,
        fixed = p15,
        siteIndex = p16,
        layer = v17.layer,
        parts = table_create_ret
    };
end;

local function gather(p26, p27, p28, p29) -- Line: 117
    for _, v in ipairs(p28) do
        local v30 = p26[v.Index];

        if not v30 then
            v30 = {};
            p26[v.Index] = v30;
            table.insert(p27, v.Index);
        end;

        table.insert(v30, {
            instance = v.Instance,
            layer = p29
        });
    end;
end;

local function destroyGroups(p31, p32) -- Line: 129
    for _, v in pairs(p31) do
        for _, v3 in ipairs(v) do
            v3.instance:Destroy();
        end;
    end;

    for _, v in ipairs(p32 or {}) do
        v.instance:Destroy();
    end;
end;

local function shardsOf(p33, p34, p35, p36) -- Line: 141
    -- upvalues: destroyGroups (copy), joined (copy)
    if #p35 < 2 then
        destroyGroups(p34, p36);

        return false;
    end;

    table.sort(p35);
    local table_create_ret = table.create(#p35 + 1);

    for _, v in ipairs(p35) do
        local v37 = joined(p33, p34[v], false, v);
        table.insert(table_create_ret, v37);
    end;

    if p36 and #p36 > 0 then
        local v38 = joined(p33, p36, true, nil);
        table.insert(table_create_ret, v38);
    end;

    return table_create_ret;
end;

local function axisOf(p39) -- Line: 158
    -- upvalues: u1 (copy)
    local v40 = p39[2].offset - p39[1].offset;

    for _, v in ipairs(u1) do
        if math.abs(v40[v]) > 0.01 then
            return v;
        end;
    end;

    return "Y";
end;

local function slabsOf(p41, p42, p43, p44) -- Line: 171
    -- upvalues: axisOf (copy), u3 (ref), u5 (ref)
    local v45 = axisOf(p43);
    local table_create_ret = table.create(#p43, false);
    local v46 = p41;

    for i = 1, #p43 - 1 do
        local v47 = p43[i];
        local v48 = v47.offset[v45] + v47.size[v45] / 2;
        local v49 = {};
        local v50 = v48 - 1;
        local v51;

        if v45 == "X" then
            v51 = Vector3.new(v50, 0, 0);
        elseif v45 == "Y" then
            v51 = Vector3.new(0, v50, 0);
        else
            v51 = Vector3.new(0, 0, v50);
        end;

        local v52 = p42:PointToWorldSpace(v51);
        local v53 = v48 + 1;
        local v54;

        if v45 == "X" then
            v54 = Vector3.new(v53, 0, 0);
        elseif v45 == "Y" then
            v54 = Vector3.new(0, v53, 0);
        else
            v54 = Vector3.new(0, 0, v53);
        end;

        v49[1], v49[2] = v52, p42:PointToWorldSpace(v54);
        local v55 = u3(p41, v49);

        if p41 ~= v46 then
            p41:Destroy();
        end;

        p41 = nil;

        if not v55 then
            for _, v in ipairs(table_create_ret) do
                if v then
                    v:Destroy();
                end;
            end;

            return nil;
        end;

        local v56 = i;

        for _, v in ipairs(v55) do
            v.Instance.Color = Color3.new(1, 1, 1);

            if v.Index == 1 then
                table_create_ret[v56] = v.Instance;
            else
                p41 = v.Instance;
            end;
        end;

        if not p41 then
            break;
        end;
    end;

    if p41 then
        table_create_ret[#p43] = p41;
    end;

    local v57 = p44 and p42 * p44:Inverse() or nil;

    for i, v in ipairs(p43) do
        local v58 = table_create_ret[i];

        if v58 and v.skin then
            table_create_ret[i] = u5(v46, v.skin, v57) or false;
            v58:Destroy();
        end;
    end;

    return table_create_ret;
end;

local function together(p59, u60) -- Line: 228
    -- upvalues: u3 (ref)
    local table_create_ret = table.create(#p59, false);
    local coroutine_running_ret = coroutine.running();
    local u61 = #p59;
    local u62 = false;

    for i, v in ipairs(p59) do
        task.spawn(function() -- Line: 234
            -- upvalues: v (copy), table_create_ret (copy), i (copy), u3 (ref), u60 (copy), u61 (ref), u62 (ref), coroutine_running_ret (copy)
            if v then
                table_create_ret[i] = u3(v, u60) or false;
            end;

            u61 = u61 - 1;

            if u61 == 0 and u62 then
                task.spawn(coroutine_running_ret);
            end;
        end);
    end;

    if u61 > 0 then
        coroutine.yield();
    end;

    return table_create_ret;
end;

function v2.cut(p63, p64, p65, p66, p67) -- Line: 251
    -- upvalues: slabsOf (copy), together (copy), gather (copy), shardsOf (copy)
    local layers = p63.layers;
    local v68 = slabsOf(p64, p65, layers, p63.place);

    if not v68 then
        return false;
    end;

    local v69, v70;

    if p67 then
        v69 = p65:PointToWorldSpace(p67.inCrust);
        v70 = p65:PointToWorldSpace(p67.inBase);
    else
        v69 = nil;
        v70 = nil;
    end;

    local v71 = {};
    local v72 = {};
    local v73 = {};
    local v74;

    if p67 then
        local v75 = together(v68, { v69, v70 });
        v74 = table.create(#layers, false);

        for i, v in ipairs(layers) do
            local v76 = v68[i];
            local v77 = v75[i];

            if v77 then
                local v78 = i;
                local v79 = v;

                for _, v3 in ipairs(v77) do
                    if v3.Index == 1 then
                        v74[v78] = v3.Instance;
                    else
                        table.insert(v73, {
                            instance = v3.Instance,
                            layer = v79.index
                        });
                    end;
                end;

                v76:Destroy();
            else
                v74[i] = v76;
            end;
        end;
    else
        v74 = v68;
    end;

    local v80 = together(v74, p66);

    for i, v in ipairs(layers) do
        local v81 = v74[i];
        local v82 = v80[i];

        if v82 and #v82 > 0 then
            gather(v71, v72, v82, v.index);
            v81:Destroy();
        elseif v81 then
            table.insert(v73, {
                instance = v81,
                layer = v.index
            });
        end;
    end;

    return shardsOf(p65, v71, v72, v73);
end;

function v2.carve(p83, p84, p85) -- Line: 300
    -- upvalues: slabsOf (copy), u3 (ref), u4 (ref)
    local layers = p83.layers;
    local v86 = slabsOf(p83.part, p84, layers, p83.place);

    if not v86 then
        return false;
    end;

    local v87 = {};

    for i, v in ipairs(layers) do
        local v88 = v86[i];

        if v88 then
            local table_clone_ret = table.clone(p83);
            table_clone_ret.template = v88;
            table_clone_ret.frame = p84;
            table_clone_ret.layers = nil;
            local v89 = p85(table_clone_ret, u3, u4);

            if v89 then
                local v90 = v;

                for _, v3 in ipairs(v89) do
                    v3.layer = v90.index;
                    table.insert(v87, v3);
                end;

                v88:Destroy();
            else
                local v91 = u4(v88, p84, true, nil);
                v91.layer = v.index;
                table.insert(v87, v91);
            end;
        end;
    end;

    if #v87 == 0 then
        return false;
    end;

    v87.slash = p83.slash;

    return v87;
end;

function v2.cutAgain(p92) -- Line: 336
    -- upvalues: together (copy), gather (copy), shardsOf (copy)
    local CFrame2 = p92.template.CFrame;
    local table_create_ret = table.create(#p92.points);

    for i, v in ipairs(p92.points) do
        table_create_ret[i] = CFrame2:PointToWorldSpace(v);
    end;

    local table_create_ret2 = table.create(#p92.layered);

    for i, v in ipairs(p92.layered) do
        table_create_ret2[i] = v.shard;
    end;

    local v93 = together(table_create_ret2, table_create_ret);
    local v94 = {};
    local v95 = {};

    for i, v in ipairs(p92.layered) do
        if v93[i] then
            gather(v94, v95, v93[i], v.layer);
        end;
    end;

    return shardsOf(CFrame2, v94, v95, nil);
end;

return v2;