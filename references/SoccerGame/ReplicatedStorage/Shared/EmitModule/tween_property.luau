  

local u1 = require("./mod/lerp");
local u2 = require("./mod/tween");
local u3 = require("./mod/utility");
local Random_new_ret = Random.new();

return {
    emit = function(u4: userdata, p5: userdata, p6: any) -- Line: 9, Name: emit
        -- upvalues: u3 (copy), Random_new_ret (copy), u2 (copy), u1 (copy)
        local Name = p5.Name;
        local Attribute = u3.getAttribute(p5, "EmitDelay", 0);
        local Attribute2 = u3.getAttribute(p5, "ResetOnFinish", true);
        local RangeAttribute = u3.getRangeAttribute(p5, "Duration", NumberRange.new(1, 1), NumberRange.new(0, (1 / 0)));

        if Attribute > 0 then
            task.wait(Attribute);
        end;

        local Attribute3 = p5:GetAttribute("_END_VALUE");
        local Attribute4 = p5:GetAttribute("_START_VALUE");
        local success, result = pcall(function() -- Line: 24
            -- upvalues: u4 (copy), Name (copy)
            return u4[Name];
        end);
        local u7 = Attribute4 or result;
        local v8 = typeof(u7);

        if not success or v8 ~= typeof(Attribute3) then
            return;
        end;

        local v9 = Random_new_ret:NextNumber(RangeAttribute.Min, RangeAttribute.Max);
        local Attribute5 = u3.getAttribute(p5, "Speed_Start", 1);
        local Attribute6 = u3.getAttribute(p5, "Speed_End", 1);
        local u10 = Attribute5;
        local u11;

        if Attribute5 == Attribute6 then
            u11 = nil;
        else
            u11 = u2.fromParams(u3.getAttribute(p5, "Speed_Curve", u3.default_bezier), u3.getAttribute(p5, "Speed_Duration", 0.1), function(p12, p13) -- Line: 51
                -- upvalues: u10 (ref), u3 (ref), Attribute5 (copy), Attribute6 (copy)
                u10 = u3.lerp(Attribute5, Attribute6, p12);

                return p13;
            end);
            table.insert(p6, u11);
        end;

        local u14 = u1[v8] or u1.Other;
        local fromParams = u2.fromParams;
        local Attribute7 = u3.getAttribute(p5, "Easing_Curve", u3.linear_bezier);
        table.insert(p6, fromParams(Attribute7, v9, function(p15, p16) -- Line: 67
            -- upvalues: u4 (copy), Name (copy), u14 (copy), u7 (ref), Attribute3 (copy), u10 (ref)
            u4[Name] = u14(u7, Attribute3, p15);

            return p16 * u10;
        end, u11, nil, nil, u3.RENDER_PRIORITY + p6.depth));

        if Attribute2 then
            table.insert(p6, function() -- Line: 79
                -- upvalues: u4 (copy), Name (copy), u7 (ref)
                u4[Name] = u7;
            end);
        end;

        u2.timer(v9, function(p17, p18) -- Line: 84
            -- upvalues: u10 (ref), u11 (ref)
            if u10 > 0 or p18 > 0 and (u11 and u11.Connected) then
                return p17 * u10;
            end;

            return nil;
        end, u11, p6);
    end
};