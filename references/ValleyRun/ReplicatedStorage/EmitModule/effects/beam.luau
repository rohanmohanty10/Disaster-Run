 

 

local u1 = require("../mod/tween");
require("../types");
local u2 = require("../mod/utility");
local u3 = require("../pkg/Promise");
local Random_new_ret = Random.new();

local function getLegacyWidths(p4: userdata, p5: number) -- Line: 10
    -- upvalues: u2 (copy)
    return u2.getAttribute(p4, "Width0", p4.Width0, true) * p5, u2.getAttribute(p4, "Width1", p4.Width1, true) * p5, u2.getAttribute(p4, "StartWidth0", p4.Width0, true) * p5, u2.getAttribute(p4, "StartWidth1", p4.Width1, true) * p5;
end;

return {
    emit = function(u6: userdata, u7: userdata, p8: any, p9: number) -- Line: 22, Name: emit
        -- upvalues: getLegacyWidths (copy), u2 (copy), Random_new_ret (copy), u1 (copy), u3 (copy)
        local v10 = p8.effects.prepareEmitOnFinish(u7, p8);
        local v11, v12, v13, v14 = getLegacyWidths(u6, p9);
        local Attribute = u2.getAttribute(u6, "Width0_Start", v13);
        local Attribute2 = u2.getAttribute(u6, "Width0_End", v11);
        local Attribute3 = u2.getAttribute(u6, "Width1_Start", v14);
        local Attribute4 = u2.getAttribute(u6, "Width1_End", v12);
        local Attribute5 = u2.getAttribute(u6, "CurveSize0_Start", u7.CurveSize0);
        local Attribute6 = u2.getAttribute(u6, "CurveSize0_End", u7.CurveSize0);
        local Attribute7 = u2.getAttribute(u6, "CurveSize1_Start", u7.CurveSize1);
        local Attribute8 = u2.getAttribute(u6, "CurveSize1_End", u7.CurveSize1);
        local Attribute9 = u2.getAttribute(u6, "EmitDelay", 0);
        local Attribute10 = u2.getAttribute(u6, "Duration", 1, true);
        local Attribute11 = u2.getAttribute(u6, "EndTransparencyScale", 1, true);
        local RangeAttribute = u2.getRangeAttribute(u6, "EffectDuration", NumberRange.new(Attribute10, Attribute10), NumberRange.new(0, (1 / 0)));
        local Attribute12 = u2.getAttribute(u6, "Length_Scale_Start", NumberRange.new(1, 1));
        local Attribute13 = u2.getAttribute(u6, "Length_Scale_End", NumberRange.new(1, 1));
        local Attribute14 = u2.getAttribute(u6, "Length_Texture_Start", u6.TextureLength);
        local Attribute15 = u2.getAttribute(u6, "Length_Texture_End", u6.TextureLength);
        local v15 = Random_new_ret:NextNumber(RangeAttribute.Min, RangeAttribute.Max);
        local u16 = Random_new_ret:NextNumber(Attribute12.Min, Attribute12.Max);
        local u17 = Random_new_ret:NextNumber(Attribute13.Min, Attribute13.Max);
        local Attribute16 = u2.getAttribute(u6, "Transparency_Scale_Start", 1);
        local Attribute17 = u2.getAttribute(u6, "Transparency_Scale_End", Attribute11);
        local Attribute18 = u2.getAttribute(u6, "Speed_Texture_Start", u6.TextureSpeed);
        local Attribute19 = u2.getAttribute(u6, "Speed_Texture_End", u6.TextureSpeed);
        local Attribute20 = u2.getAttribute(u6, "Speed_Start", 1);
        local Attribute21 = u2.getAttribute(u6, "Speed_End", 1);
        local TextureSpeed = u7.TextureSpeed;
        task.wait(Attribute9);
        u7.Enabled = true;
        local v18 = {};
        local u19 = 1;
        local u20 = nil;
        local Finished = p8.effects.emitNested(u7, p8.depth + 1).Finished;
        table.insert(v18, Finished);

        if Attribute18 ~= Attribute19 then
            u1.fromParams(u2.getAttribute(u6, "Speed_Texture_Curve", u2.default_bezier), v15, function(p21, p22) -- Line: 88
                -- upvalues: TextureSpeed (ref), u2 (ref), Attribute18 (copy), Attribute19 (copy), u7 (copy), u19 (ref)
                TextureSpeed = u2.lerp(Attribute18, Attribute19, p21);
                u7.TextureSpeed = TextureSpeed * u19;

                return p22;
            end);
        end;

        if Attribute20 ~= Attribute21 then
            u20 = u1.fromParams(u2.getAttribute(u6, "Speed_Curve", u2.default_bezier), u2.getAttribute(u7, "Speed_Duration", 0.1), function(p23, p24) -- Line: 101
                -- upvalues: u19 (ref), u2 (ref), Attribute20 (copy), Attribute21 (copy), u7 (copy), TextureSpeed (ref)
                u19 = u2.lerp(Attribute20, Attribute21, p23);
                u7.TextureSpeed = TextureSpeed * u19;

                return p24;
            end);
            table.insert(p8, u20);
        end;

        local function setTScale(u25: number) -- Line: 113
            -- upvalues: u7 (copy), u2 (ref), u6 (copy)
            u7.Transparency = u2.scaleNumberSequence(u6.Transparency, function(p26, p27) -- Line: 114
                -- upvalues: u25 (copy)
                return p26 + (u25 > 1 and 1 - p26 or -p26) * (u25 > 1 and u25 - 1 or 1 - u25), p27;
            end);
        end;

        local Attachment0 = u7.Attachment0;
        local Attachment1 = u7.Attachment1;
        local u28;

        if Attachment0 then
            u28 = Attachment0.CFrame;
        else
            u28 = Attachment0;
        end;

        local u29;

        if Attachment1 then
            u29 = Attachment1.CFrame;
        else
            u29 = Attachment1;
        end;

        local function setLengthScale(p30: number) -- Line: 125
            -- upvalues: u28 (copy), u29 (copy), Attachment0 (copy), Attachment1 (copy)
            if not (u28 and u29) then
                return;
            end;

            local v31 = (u29.Position - u28.Position) * 0.5;
            local v32 = u28.Position + v31;
            local v33 = v31 * p30;
            Attachment0.CFrame = CFrame.new(v32 - v33) * (u28 - u28.Position);
            Attachment1.CFrame = CFrame.new(v32 + v33) * (u29 - u29.Position);
        end;

        table.insert(p8, function() -- Line: 144
            -- upvalues: setLengthScale (copy)
            setLengthScale(1);
        end);

        if Attribute16 == Attribute17 then
            if Attribute16 ~= 1 then
                u7.Transparency = u2.scaleNumberSequence(u6.Transparency, function(p34, p35) -- Line: 114
                    -- upvalues: Attribute16 (copy)
                    return p34 + (Attribute16 > 1 and 1 - p34 or -p34) * (Attribute16 > 1 and Attribute16 - 1 or 1 - Attribute16), p35;
                end);
            end;
        else
            local fromParams = u1.fromParams;
            local Attribute22 = u2.getAttribute(u6, "Transparency_Scale_Curve", u2.default_bezier);
            table.insert(p8, fromParams(Attribute22, v15, function(p36, p37) -- Line: 154
                -- upvalues: u2 (ref), Attribute16 (copy), Attribute17 (copy), u7 (copy), u6 (copy), u19 (ref)
                local u38 = u2.lerp(Attribute16, Attribute17, p36);
                u7.Transparency = u2.scaleNumberSequence(u6.Transparency, function(p39, p40) -- Line: 114
                    -- upvalues: u38 (copy)
                    return p39 + (u38 > 1 and 1 - p39 or -p39) * (u38 > 1 and u38 - 1 or 1 - u38), p40;
                end);

                return p37 * u19;
            end, u20));
        end;

        if Attribute14 ~= Attribute15 then
            local fromParams = u1.fromParams;
            local Attribute22 = u2.getAttribute(u6, "Length_Texture_Curve", u2.default_bezier);
            table.insert(p8, fromParams(Attribute22, v15, function(p41, p42) -- Line: 171
                -- upvalues: u7 (copy), u2 (ref), Attribute14 (copy), Attribute15 (copy), u19 (ref)
                u7.TextureLength = u2.lerp(Attribute14, Attribute15, p41);

                return p42 * u19;
            end, u20));
        end;

        if u16 == u17 then
            if Attribute14 ~= 1 then
                setLengthScale(u16);
            end;
        else
            local fromParams = u1.fromParams;
            local Attribute22 = u2.getAttribute(u6, "Length_Scale_Curve", u2.default_bezier);
            table.insert(p8, fromParams(Attribute22, v15, function(p43, p44) -- Line: 186
                -- upvalues: u2 (ref), u16 (copy), u17 (copy), setLengthScale (copy), u19 (ref)
                setLengthScale((u2.lerp(u16, u17, p43)));

                return p44 * u19;
            end, u20));
        end;

        if Attribute == Attribute2 then
            u7.Width0 = Attribute;
        else
            local fromParams = u1.fromParams;
            local Attribute22 = u2.getAttribute(u6, "Width0_Curve", u2.default_bezier);
            table.insert(p8, fromParams(Attribute22, v15, function(p45, p46) -- Line: 206
                -- upvalues: u7 (copy), u2 (ref), Attribute (copy), Attribute2 (copy), u19 (ref)
                u7.Width0 = u2.lerp(Attribute, Attribute2, p45);

                return p46 * u19;
            end, u20));
        end;

        if Attribute3 == Attribute4 then
            u7.Width1 = Attribute3;
        else
            local fromParams = u1.fromParams;
            local Attribute22 = u2.getAttribute(u6, "Width1_Curve", u2.default_bezier);
            table.insert(p8, fromParams(Attribute22, v15, function(p47, p48) -- Line: 223
                -- upvalues: u7 (copy), u2 (ref), Attribute3 (copy), Attribute4 (copy), u19 (ref)
                u7.Width1 = u2.lerp(Attribute3, Attribute4, p47);

                return p48 * u19;
            end, u20));
        end;

        if Attribute5 == Attribute6 then
            u7.Width0 = Attribute;
        else
            local fromParams = u1.fromParams;
            local Attribute22 = u2.getAttribute(u6, "CurveSize0_Curve", u2.default_bezier);
            table.insert(p8, fromParams(Attribute22, v15, function(p49, p50) -- Line: 240
                -- upvalues: u7 (copy), u2 (ref), Attribute5 (copy), Attribute6 (copy), u19 (ref)
                u7.CurveSize0 = u2.lerp(Attribute5, Attribute6, p49);

                return p50 * u19;
            end, u20));
        end;

        if Attribute7 == Attribute8 then
            u7.Width1 = Attribute3;
        else
            local fromParams = u1.fromParams;
            local Attribute22 = u2.getAttribute(u6, "CurveSize1_Curve", u2.default_bezier);
            table.insert(p8, fromParams(Attribute22, v15, function(p51, p52) -- Line: 257
                -- upvalues: u7 (copy), u2 (ref), Attribute7 (copy), Attribute8 (copy), u19 (ref)
                u7.CurveSize1 = u2.lerp(Attribute7, Attribute8, p51);

                return p52 * u19;
            end, u20));
        end;

        u1.timer(v15, function(p53, p54) -- Line: 268
            -- upvalues: u19 (ref), u20 (ref)
            if u19 > 0 or p54 > 0 and (u20 and u20.Connected) then
                return p53 * u19;
            end;

            return nil;
        end, u20, p8);

        if v10 then
            local Finished2 = p8.effects.emitOnFinish(v10, u7.Parent or workspace.Terrain, p8.depth + 1).Finished;
            table.insert(v18, Finished2);
        end;

        u3.all(v18):await();
    end
};