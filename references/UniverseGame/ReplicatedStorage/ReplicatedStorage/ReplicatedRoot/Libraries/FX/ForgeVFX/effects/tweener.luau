  

 

local u1 = require("../mod/attributes");
local u2 = require("../mod/lerp");
local u3 = require("../mod/tween");
require("../types");
local u4 = require("../mod/utility");
local u5 = Random.new();

return {
    emit = function(p6, p7, u8) -- Line: 11, Name: emit
        -- upvalues: u4 (copy), u1 (copy), u5 (copy), u3 (copy), u2 (copy)
        local u9 = u4.getTarget(p6);

        if not u9 then
            return;
        end;

        local Name = p6.Name;
        local v10 = u1.get(p6, "EmitDelay", 0);
        local v11 = u1.get(p6, "ResetOnFinish", true);
        local v12 = u1.getRange(p6, "Duration", NumberRange.new(1, 1), NumberRange.new(0, (1 / 0)));

        if v10 > 0 then
            task.wait(v10);
        end;

        local u13 = u1.get(p6, "_END_VALUE", nil);
        local v14 = u1.get(p6, "_START_VALUE", nil);
        local v15;

        if u8 then
            v15 = u1.get(u9, Name, nil);
        else
            local v16;
            v16, v15 = pcall(function() -- Line: 37
                -- upvalues: u9 (copy), Name (copy)
                return u9[Name];
            end);

            if not v16 then
                return;
            end;
        end;

        local u17 = v14 or v15;
        local v18 = typeof(u17);

        if v18 ~= typeof(u13) then
            return;
        end;

        local v19 = u5:NextNumber(v12.Min, v12.Max);
        local u20 = u1.get(p6, "Speed_Start", 1);
        local u21 = u1.get(p6, "Speed_End", 1);
        local u22 = u20;
        local u23;

        if u20 == u21 then
            u23 = nil;
        else
            u23 = u3.fromParams(u1.get(p6, "Speed_Curve", u4.default_bezier), u1.get(p6, "Speed_Duration", 0.1), function(p24, p25) -- Line: 71
                -- upvalues: u22 (ref), u4 (ref), u20 (copy), u21 (copy)
                u22 = u4.lerp(u20, u21, p24);

                return p25;
            end);
            table.insert(p7, u23);
        end;

        local u26 = u2[v18] or u2.Other;
        local v27;

        if u8 then
            v27 = function(p28, p29) -- Line: 83
                -- upvalues: u1 (ref), u9 (copy), Name (copy), u26 (copy), u17 (ref), u13 (copy), u22 (ref)
                u1.set(u9, Name, u26(u17, u13, p28));

                return p29 * u22;
            end;
        else
            v27 = function(p30, p31) -- Line: 87
                -- upvalues: u9 (copy), Name (copy), u26 (copy), u17 (ref), u13 (copy), u22 (ref)
                u9[Name] = u26(u17, u13, p30);

                return p31 * u22;
            end;
        end;

        local fromParams = u3.fromParams;
        local v32 = u1.get(p6, "Easing_Curve", u4.linear_bezier);
        table.insert(p7, fromParams(v32, v19, v27, u23, nil, nil, u4.RENDER_PRIORITY + p7.depth));

        if v11 then
            table.insert(p7, function() -- Line: 106
                -- upvalues: u8 (copy), u1 (ref), u9 (copy), Name (copy), u17 (ref)
                if u8 then
                    u1.set(u9, Name, u17);

                    return;
                end;

                u9[Name] = u17;
            end);
        end;

        u3.timer(v19, function(p33, p34) -- Line: 115
            -- upvalues: u22 (ref), u23 (ref)
            if u22 > 0 or p34 > 0 and (u23 and u23.Connected) then
                return p33 * u22;
            end;

            return nil;
        end, u23, p7);
    end
};