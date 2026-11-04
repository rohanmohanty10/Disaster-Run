 
 

local Display = require(script.Parent.Display);
local Index = require(script.Parent.Index);
local Sites = require(script.Parent.Sites);
local u1 = {};

local function edgesOf(p2, p3, p4, p5, p6) -- Line: 37
    local v7 = { p2, p3 };

    for _, v in ipairs(p4) do
        local math_clamp_ret = math.clamp(v[p5], p2, p3);
        table.insert(v7, math_clamp_ret);
        local math_clamp_ret2 = math.clamp(v[p6], p2, p3);
        table.insert(v7, math_clamp_ret2);
    end;

    table.sort(v7);
    local v8 = { v7[1] };

    for i = 2, #v7 do
        local v9;

        if v7[i] - v8[#v8] > 0.01 then
            table.insert(v8, v7[i]);
            v9 = i;
        else
            v9 = i;
        end;
    end;

    return v8;
end;

function u1.holes(p10, p11, p12) -- Line: 53
    -- upvalues: Sites (copy), edgesOf (copy)
    local v13, v14 = Sites.faceAxes(p12.axis);
    local v15 = edgesOf(-p10[v13] / 2, p10[v13] / 2, p11, "minU", "maxU");
    local v16 = edgesOf(-p10[v14] / 2, p10[v14] / 2, p11, "minV", "maxV");
    local v17 = {};

    for i = 1, #v16 - 1 do
        local v18 = (v16[i] + v16[i + 1]) / 2;
        local v19 = i;
        local v20 = nil;

        for i2 = 1, #v15 - 1 do
            local v21 = (v15[i2] + v15[i2 + 1]) / 2;
            local v22 = i2;
            local v23 = false;

            for _, v in ipairs(p11) do
                if v.minU < v21 and (v21 < v.maxU and (v.minV < v18 and v18 < v.maxV)) then
                    v23 = true;
                    break;
                end;
            end;

            if v23 then
                v20 = nil;
            elseif v20 then
                v20.maxU = v15[v22 + 1];
            else
                v20 = {
                    minU = v15[v22],
                    minV = v16[v19],
                    maxU = v15[v22 + 1],
                    maxV = v16[v19 + 1]
                };
                table.insert(v17, v20);
            end;
        end;
    end;

    return v17;
end;

local function stillOpen(p24, p25) -- Line: 85
    for _, v in ipairs(p24) do
        local v26 = (v.minU + v.maxU) / 2;
        local v27 = (v.minV + v.maxV) / 2;
        local v28 = false;

        for _, v2 in ipairs(p25) do
            if v2.minU <= v26 and (v26 <= v2.maxU and (v2.minV <= v27 and v27 <= v2.maxV)) then
                v28 = true;
                break;
            end;
        end;

        if not v28 then
            return false;
        end;
    end;

    return true;
end;

function u1.new(u29, u30, u31) -- Line: 104
    -- upvalues: Display (copy), Index (copy), u1 (copy), stillOpen (copy), Sites (copy)
    local u32 = {};
    local v33 = {};

    local function whole(p34) -- Line: 109
        -- upvalues: u32 (copy), Display (ref), u30 (copy)
        local v35 = u32[p34];

        if not v35 then
            return;
        end;

        u32[p34] = nil;

        if v35.copy then
            v35.copy:Destroy();
        end;

        if v35.kept then
            Display.show(p34, u30, v35.kept);
        end;
    end;

    local function dress(p36, p37) -- Line: 124
        -- upvalues: Display (ref), Index (ref)
        p36.Name = "SkinRest";
        p36.Archivable = false;
        p36.Anchored = true;
        p36.CanCollide = false;
        p36.CanQuery = false;
        p36.CanTouch = false;
        p36.Locked = true;

        if p36:IsA("PartOperation") and p37:IsA("PartOperation") then
            p36.UsePartColor = p37.UsePartColor;
        end;

        p36.Transparency = Display.ownTransparency(p37);
        Index.unmark(p36);
        p36:SetAttribute("_PartIcleEmit", true);
    end;

    function v33.draw(p38, p39, p40, p41) -- Line: 141
        -- upvalues: u1 (ref), u32 (copy), Display (ref), u30 (copy), stillOpen (ref), Sites (ref), u31 (copy), dress (copy), u29 (copy)
        local part = p39.part;
        local v42 = p40 and (u1.holes(p38.size, p40, p41) or {}) or {};

        if #v42 == 0 then
            local v43 = u32[part];

            if not v43 then
                return;
            end;

            u32[part] = nil;

            if v43.copy then
                v43.copy:Destroy();
            end;

            if v43.kept then
                Display.show(part, u30, v43.kept);
            end;

            return;
        end;

        local u44 = u32[part];

        if not u44 then
            u44 = {
                copy = nil,
                kept = nil,
                version = 0,
                holes = {}
            };
            u32[part] = u44;
        end;

        if u44.kept and not stillOpen(u44.holes, v42) then
            Display.show(part, u30, u44.kept);
            u44.kept = nil;
        end;

        u44.holes = v42;
        u44.version = u44.version + 1;
        local version = u44.version;
        local table_create_ret = table.create(#v42);
        local v45 = p38.size[p41.axis] + 8;

        for i, v in ipairs(v42) do
            local v46 = Sites.alongFace(p41.axis, (v.minU + v.maxU) / 2, (v.minV + v.maxV) / 2, 0);
            table_create_ret[i] = {
                frame = p38.frame * CFrame.new(v46.X, v46.Y, v46.Z),
                size = Sites.alongFace(p41.axis, v.maxU - v.minU, v.maxV - v.minV, v45)
            };
        end;

        task.spawn(function() -- Line: 170
            -- upvalues: u31 (ref), part (copy), table_create_ret (copy), u32 (ref), u44 (ref), version (copy), dress (ref), u29 (ref), Display (ref), u30 (ref)
            local v47 = u31(part, table_create_ret);

            if u32[part] ~= u44 or u44.version ~= version then
                if v47 then
                    v47:Destroy();
                end;

                return;
            end;

            if not v47 then
                return;
            end;

            dress(v47, part);
            v47.Parent = u29;

            if u44.copy then
                u44.copy:Destroy();
            end;

            u44.copy = v47;

            if not u44.kept then
                u44.kept = Display.hide(part, u30, true);
            end;
        end);
    end;

    function v33.clear() -- Line: 195
        -- upvalues: u32 (copy), Display (ref), u30 (copy)
        for i in pairs(table.clone(u32)) do
            local v48 = u32[i];

            if v48 then
                u32[i] = nil;

                if v48.copy then
                    v48.copy:Destroy();
                end;

                if v48.kept then
                    Display.show(i, u30, v48.kept);
                end;
            end;
        end;
    end;

    return v33;
end;

return u1;