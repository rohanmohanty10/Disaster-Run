  

 

local u1 = require("../mod/attributes");
local u2 = require("../mod/lerp");
local u3 = require("../mod/tween");
require("../types");
local u4 = require("../mod/utility");
local u5 = require("../obj/Bezier");
local u6 = Random.new();
local v7 = {};

local function getBezier(u8) -- Line: 14
    -- upvalues: u3 (copy), u4 (copy), u5 (copy)
    local v9 = u3.bezier_cache[u8];

    if not v9 then
        local success, result = pcall(function() -- Line: 18
            -- upvalues: u4 (ref), u8 (copy)
            return u4.deserializePath(u8);
        end);

        if not success then
            return nil;
        end;

        v9 = u5.new(result, 0);
        u3.bezier_cache[u8] = v9;
    end;

    return v9;
end;

local function sampleWeighted(p10) -- Line: 33
    -- upvalues: u6 (copy)
    return 1 - p10:getEase((u6:NextNumber())).y;
end;

function v7.emit(p11, p12, u13) -- Line: 40
    -- upvalues: u4 (copy), u1 (copy), getBezier (copy), u2 (copy), u6 (copy)
    local u14 = u4.getTarget(p11);

    if not u14 then
        return;
    end;

    local Name = p11.Name;
    local v15 = u1.get(p11, "_START_VALUE", nil);
    local v16 = u1.get(p11, "_END_VALUE", nil);

    if v15 == nil or v16 == nil then
        return;
    end;

    local v17 = typeof(v15);

    if v17 ~= typeof(v16) then
        return;
    end;

    local v18 = getBezier((u1.get(p11, "Weight_Curve", u4.linear_bezier)));

    if not v18 then
        return;
    end;

    local u19;

    if u13 then
        u19 = u1.get(u14, Name, nil);
    else
        local v20;
        v20, u19 = pcall(function() -- Line: 74
            -- upvalues: u14 (copy), Name (copy)
            return u14[Name];
        end);

        if not v20 then
            return;
        end;
    end;

    local v21 = (u2[v17] or u2.Other)(v15, v16, 1 - v18:getEase((u6:NextNumber())).y);
    local v22 = u1.get(p11, "ResetOnFinish", true);

    if u13 then
        u1.set(u14, Name, v21);
    else
        u14[Name] = v21;
    end;

    if v22 then
        task.defer(function() -- Line: 100
            -- upvalues: u13 (copy), u1 (ref), u14 (copy), Name (copy), u19 (ref)
            if u13 then
                u1.set(u14, Name, u19);

                return;
            end;

            u14[Name] = u19;
        end);
    end;
end;

return v7;