 

 

local u1 = require("../mod/tween");
require("../types");
local u2 = require("../mod/utility");

return {
    emit = function(u3: userdata, u4: userdata, p5: any) -- Line: 7, Name: emit
        -- upvalues: u2 (copy), u1 (copy)
        if u3.Enabled then
            u3.Enabled = false;
        end;

        local Attribute = u2.getAttribute(u3, "EmitDelay", 0);
        local Attribute2 = u2.getAttribute(u3, "EmitCount", 1);
        local Attribute3 = u2.getAttribute(u3, "EmitDuration", 0);
        local v6 = Attribute3 > 0;
        task.wait(Attribute);

        if v6 then
            u4.Enabled = true;
        end;

        local Attribute4 = u2.getAttribute(u3, "TimeScale_Duration", 0.1);
        local Attribute5 = u2.getAttribute(u3, "TimeScale_Start", u4.TimeScale);
        local Attribute6 = u2.getAttribute(u3, "TimeScale_End", u4.TimeScale);
        local u7 = nil;

        if Attribute5 == Attribute6 then
            if Attribute5 ~= 1 then
                u4.TimeScale = Attribute5;
            end;
        else
            u7 = u1.fromParams(u2.getAttribute(u3, "TimeScale_Curve", u2.default_bezier), Attribute4, function(p8, p9) -- Line: 35
                -- upvalues: u2 (ref), Attribute5 (copy), Attribute6 (copy), u4 (copy)
                u4.TimeScale = u2.lerp(Attribute5, Attribute6, (math.clamp(p8, 0, 1)));

                return p9;
            end);
            table.insert(p5, u7);
        end;

        u4:Emit(Attribute2);

        if v6 then
            task.wait(Attribute3);
            u4.Enabled = false;
        end;

        u1.timer(u3.Lifetime.Max, function(p10, p11) -- Line: 56
            -- upvalues: u3 (copy), u7 (ref)
            if u3.TimeScale > 0 or p11 > 0 and (u7 and u7.Connected) then
                return p10 * u3.TimeScale;
            end;

            return nil;
        end, u7, p5);
    end
};