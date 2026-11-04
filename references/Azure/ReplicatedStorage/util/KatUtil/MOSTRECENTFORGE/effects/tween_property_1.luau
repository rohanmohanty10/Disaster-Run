 
 

local u1 = require("../mod/attributes");
local u2 = require("../mod/lerp");
local u3 = require("../mod/tween");
require("../types");
local u4 = require("../mod/utility");
local Random_new_ret = Random.new();

return {
    emit = function(u5: userdata, p6: userdata, p7: any) -- Line: 11, Name: emit
        -- upvalues: u1 (copy), Random_new_ret (copy), u3 (copy), u4 (copy), u2 (copy)
        local Name = p6.Name;
        local v8 = u1.get(p6, "EmitDelay", 0);
        local v9 = u1.get(p6, "ResetOnFinish", true);
        local Range = u1.getRange(p6, "Duration", NumberRange.new(1, 1), NumberRange.new(0, (1 / 0)));

        if v8 > 0 then
            task.wait(v8);
        end;

        local Attribute = p6:GetAttribute("_END_VALUE");
        local Attribute2 = p6:GetAttribute("_START_VALUE");
        local success, result = pcall(function() -- Line: 26
            -- upvalues: u5 (copy), Name (copy)
            return u5[Name];
        end);
        local u10 = Attribute2 or result;
        local v11 = typeof(u10);

        if not success or v11 ~= typeof(Attribute) then
            return;
        end;

        local v12 = Random_new_ret:NextNumber(Range.Min, Range.Max);
        local u13 = u1.get(p6, "Speed_Start", 1);
        local u14 = u1.get(p6, "Speed_End", 1);
        local u15 = u13;
        local u16;

        if u13 == u14 then
            u16 = nil;
        else
            u16 = u3.fromParams(u1.get(p6, "Speed_Curve", u4.default_bezier), u1.get(p6, "Speed_Duration", 0.1), function(p17, p18) -- Line: 53
                -- upvalues: u15 (ref), u4 (ref), u13 (copy), u14 (copy)
                u15 = u4.lerp(u13, u14, p17);

                return p18;
            end);
            table.insert(p7, u16);
        end;

        local u19 = u2[v11] or u2.Other;
        local fromParams = u3.fromParams;
        local v20 = u1.get(p6, "Easing_Curve", u4.linear_bezier);
        table.insert(p7, fromParams(v20, v12, function(p21, p22) -- Line: 66
            -- upvalues: u5 (copy), Name (copy), u19 (copy), u10 (ref), Attribute (copy), u15 (ref)
            u5[Name] = u19(u10, Attribute, p21);

            return p22 * u15;
        end, u16, nil, nil, u4.RENDER_PRIORITY + p7.depth));

        if v9 then
            table.insert(p7, function() -- Line: 73
                -- upvalues: u5 (copy), Name (copy), u10 (ref)
                u5[Name] = u10;
            end);
        end;

        u3.timer(v12, function(p23, p24) -- Line: 78
            -- upvalues: u15 (ref), u16 (ref)
            if u15 > 0 or p24 > 0 and (u16 and u16.Connected) then
                return p23 * u15;
            end;

            return nil;
        end, u16, p7);
    end
};