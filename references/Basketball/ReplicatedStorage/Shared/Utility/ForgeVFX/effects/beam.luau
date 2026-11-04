 
 

local u1 = require("../mod/tween");
local u2 = require("../mod/utility");
local Random_new_ret = Random.new();

local function getLegacyWidths(p3: userdata, p4: number) -- Line: 6
    -- upvalues: u2 (copy)
    return u2.getAttribute(p3, "Width0", p3.Width0, true) * p4, u2.getAttribute(p3, "Width1", p3.Width1, true) * p4, u2.getAttribute(p3, "StartWidth0", p3.Width0, true) * p4, u2.getAttribute(p3, "StartWidth1", p3.Width1, true) * p4;
end;

return {
    emit = function(u5: userdata, u6: userdata, p7: any, p8: number) -- Line: 18, Name: emit
        -- upvalues: getLegacyWidths (copy), u2 (copy), Random_new_ret (copy), u1 (copy)
        local v9, v10, v11, v12 = getLegacyWidths(u5, p8);
        local Attribute = u2.getAttribute(u5, "Width0_Start", v11);
        local Attribute2 = u2.getAttribute(u5, "Width0_End", v9);
        local Attribute3 = u2.getAttribute(u5, "Width1_Start", v12);
        local Attribute4 = u2.getAttribute(u5, "Width1_End", v10);
        local Attribute5 = u2.getAttribute(u5, "EmitDelay", 0);
        local Attribute6 = u2.getAttribute(u5, "Duration", 1, true);
        local Attribute7 = u2.getAttribute(u5, "EndTransparencyScale", 1, true);
        local RangeAttribute = u2.getRangeAttribute(u5, "EffectDuration", NumberRange.new(Attribute6, Attribute6), NumberRange.new(0, (1 / 0)));
        local v13 = Random_new_ret:NextNumber(RangeAttribute.Min, RangeAttribute.Max);
        local Attribute8 = u2.getAttribute(u5, "Transparency_Scale_Start", 1);
        local Attribute9 = u2.getAttribute(u5, "Transparency_Scale_End", Attribute7);
        local Attribute10 = u2.getAttribute(u5, "Speed_Start", 1);
        local Attribute11 = u2.getAttribute(u5, "Speed_End", 1);
        local TextureSpeed = u6.TextureSpeed;
        task.wait(Attribute5);
        u6.Enabled = true;
        local u14 = 1;
        local u15;

        if Attribute10 == Attribute11 then
            u15 = nil;
        else
            u15 = u1.fromParams(u2.getAttribute(u5, "Speed_Curve", u2.default_bezier), u2.getAttribute(u6, "Speed_Duration", 0.1), function(p16, p17) -- Line: 61
                -- upvalues: u14 (ref), u2 (ref), Attribute10 (copy), Attribute11 (copy), u6 (copy), TextureSpeed (copy)
                u14 = u2.lerp(Attribute10, Attribute11, p16);
                u6.TextureSpeed = TextureSpeed * u14;

                return p17;
            end);
            table.insert(p7, u15);
        end;

        local function setTScale(u18: number) -- Line: 73
            -- upvalues: u6 (copy), u2 (ref), u5 (copy)
            u6.Transparency = u2.scaleNumberSequence(u5.Transparency, function(p19, p20) -- Line: 74
                -- upvalues: u18 (copy)
                return p19 + (u18 > 1 and 1 - p19 or -p19) * (u18 > 1 and u18 - 1 or 1 - u18), p20;
            end);
        end;

        if Attribute8 == Attribute9 then
            if Attribute8 ~= 1 then
                u6.Transparency = u2.scaleNumberSequence(u5.Transparency, function(p21, p22) -- Line: 74
                    -- upvalues: Attribute8 (copy)
                    return p21 + (Attribute8 > 1 and 1 - p21 or -p21) * (Attribute8 > 1 and Attribute8 - 1 or 1 - Attribute8), p22;
                end);
            end;
        else
            local fromParams = u1.fromParams;
            local Attribute12 = u2.getAttribute(u5, "Transparency_Scale_Curve", u2.default_bezier);
            table.insert(p7, fromParams(Attribute12, v13, function(p23, p24) -- Line: 88
                -- upvalues: u2 (ref), Attribute8 (copy), Attribute9 (copy), u6 (copy), u5 (copy), u14 (ref)
                local u25 = u2.lerp(Attribute8, Attribute9, p23);
                u6.Transparency = u2.scaleNumberSequence(u5.Transparency, function(p26, p27) -- Line: 74
                    -- upvalues: u25 (copy)
                    return p26 + (u25 > 1 and 1 - p26 or -p26) * (u25 > 1 and u25 - 1 or 1 - u25), p27;
                end);

                return p24 * u14;
            end, u15));
        end;

        if Attribute == Attribute2 then
            u6.Width0 = Attribute;
        else
            local fromParams = u1.fromParams;
            local Attribute12 = u2.getAttribute(u5, "Width0_Curve", u2.default_bezier);
            table.insert(p7, fromParams(Attribute12, v13, function(p28, p29) -- Line: 105
                -- upvalues: u6 (copy), u2 (ref), Attribute (copy), Attribute2 (copy), u14 (ref)
                u6.Width0 = u2.lerp(Attribute, Attribute2, p28);

                return p29 * u14;
            end, u15));
        end;

        if Attribute3 == Attribute4 then
            u6.Width1 = Attribute3;
        else
            local fromParams = u1.fromParams;
            local Attribute12 = u2.getAttribute(u5, "Width1_Curve", u2.default_bezier);
            table.insert(p7, fromParams(Attribute12, v13, function(p30, p31) -- Line: 122
                -- upvalues: u6 (copy), u2 (ref), Attribute3 (copy), Attribute4 (copy), u14 (ref)
                u6.Width1 = u2.lerp(Attribute3, Attribute4, p30);

                return p31 * u14;
            end, u15));
        end;

        u1.timer(v13, function(p32, p33) -- Line: 133
            -- upvalues: u14 (ref), u15 (ref)
            if u14 > 0 or p33 > 0 and (u15 and u15.Connected) then
                return p32 * u14;
            end;

            return nil;
        end, u15, p7);
    end
};