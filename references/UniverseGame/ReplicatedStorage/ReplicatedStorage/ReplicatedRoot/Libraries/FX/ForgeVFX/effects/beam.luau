  

 

local u1 = require("../mod/attributes");
local u2 = require("../mod/tween");
require("../types");
local u3 = require("../mod/utility");
local u4 = require("../mod/common/flipbook");
local u5 = require("../pkg/Promise");
local u6 = Random.new();

local function getLegacyWidths(p7, p8) -- Line: 12
    -- upvalues: u1 (copy)
    return u1.get(p7, "Width0", p7.Width0, true) * p8, u1.get(p7, "Width1", p7.Width1, true) * p8, u1.get(p7, "StartWidth0", p7.Width0, true) * p8, u1.get(p7, "StartWidth1", p7.Width1, true) * p8;
end;

return {
    emit = function(p9, u10, p11, p12) -- Line: 24, Name: emit
        -- upvalues: getLegacyWidths (copy), u1 (copy), u6 (copy), u2 (copy), u3 (copy), u4 (copy), u5 (copy)
        local v13 = p11.effects.prepareEmitOnFinish(u10, p11);
        local v14, v15, v16, v17 = getLegacyWidths(p9, p12);
        local u18 = u1.get(p9, "Width0_Start", v16);
        local u19 = u1.get(p9, "Width0_End", v14);
        local u20 = u1.get(p9, "Width1_Start", v17);
        local u21 = u1.get(p9, "Width1_End", v15);
        local u22 = u1.get(p9, "CurveSize0_Start", u10.CurveSize0);
        local u23 = u1.get(p9, "CurveSize0_End", u10.CurveSize0);
        local u24 = u1.get(p9, "CurveSize1_Start", u10.CurveSize1);
        local u25 = u1.get(p9, "CurveSize1_End", u10.CurveSize1);
        local v26 = u1.get(p9, "EmitDelay", 0);
        local v27 = u1.get(p9, "Duration", 1, true);
        local v28 = u1.get(p9, "EndTransparencyScale", 1, true);
        local v29 = u1.getRange(p9, "EffectDuration", NumberRange.new(v27, v27), NumberRange.new(0, (1 / 0)));
        local v30 = u1.get(p9, "Length_Scale_Start", NumberRange.new(1, 1));
        local v31 = u1.get(p9, "Length_Scale_End", NumberRange.new(1, 1));
        local u32 = u1.get(p9, "Length_Texture_Start", p9.TextureLength);
        local u33 = u1.get(p9, "Length_Texture_End", p9.TextureLength);
        local v34 = u6:NextNumber(v29.Min, v29.Max);
        local u35 = u6:NextNumber(v31.Min, v31.Max);
        local u36 = u6:NextNumber(v30.Min, v30.Max);
        local u37 = u1.get(p9, "Transparency_Scale_Start", 1);
        local u38 = u1.get(p9, "Transparency_Scale_End", v28);
        local u39 = u1.get(p9, "Speed_Texture_Start", p9.TextureSpeed);
        local u40 = u1.get(p9, "Speed_Texture_End", p9.TextureSpeed);
        local u41 = u1.get(p9, "Speed_Start", 1);
        local u42 = u1.get(p9, "Speed_End", 1);
        local TextureSpeed = u10.TextureSpeed;
        task.wait(v26);
        u10.Enabled = true;
        local v43 = {};
        local u44 = 1;
        local u45 = nil;
        local Finished = p11.effects.emitNested(u10, p11.depth + 1, p11).Finished;
        table.insert(v43, Finished);

        if u39 ~= u40 then
            u2.fromParams(u1.get(p9, "Speed_Texture_Curve", u3.default_bezier), v34, function(p46, p47) -- Line: 86
                -- upvalues: TextureSpeed (ref), u3 (ref), u39 (copy), u40 (copy), u10 (copy), u44 (ref)
                TextureSpeed = u3.lerp(u39, u40, p46);
                u10.TextureSpeed = TextureSpeed * u44;

                return p47;
            end);
        end;

        if u41 ~= u42 then
            u45 = u2.fromParams(u1.get(p9, "Speed_Curve", u3.default_bezier), u1.get(u10, "Speed_Duration", 0.1), function(p48, p49) -- Line: 98
                -- upvalues: u44 (ref), u3 (ref), u41 (copy), u42 (copy), u10 (copy), TextureSpeed (ref)
                u44 = u3.lerp(u41, u42, p48);
                u10.TextureSpeed = TextureSpeed * u44;

                return p49;
            end);
            table.insert(p11, u45);
        end;

        local Keypoints = p9.Transparency.Keypoints;
        local v50 = #Keypoints;
        local u51 = table.create(v50);
        local u52 = table.create(v50);

        for i, v in Keypoints do
            u52[i] = {
                time = v.Time,
                value = v.Value,
                envelope = v.Envelope
            };
        end;

        local u53 = nil;

        local function setTScale(p54) -- Line: 127
            -- upvalues: u53 (ref), u52 (copy), u51 (copy), u10 (copy)
            if u53 and math.abs(p54 - u53) < 0.001 then
                return;
            end;

            u53 = p54;
            local v55 = p54 > 1 and p54 - 1 or 1 - p54;

            for i, v in u52 do
                local value = v.value;
                u51[i] = NumberSequenceKeypoint.new(v.time, value + (p54 > 1 and 1 - value or -value) * v55, v.envelope);
            end;

            u10.Transparency = NumberSequence.new(u51);
        end;

        local Attachment0 = u10.Attachment0;
        local Attachment1 = u10.Attachment1;
        local u56;

        if Attachment0 then
            u56 = Attachment0.CFrame;
        else
            u56 = Attachment0;
        end;

        local u57;

        if Attachment1 then
            u57 = Attachment1.CFrame;
        else
            u57 = Attachment1;
        end;

        local function setLengthScale(p58) -- Line: 149
            -- upvalues: u56 (copy), u57 (copy), Attachment0 (copy), Attachment1 (copy)
            if not (u56 and u57) then
                return;
            end;

            local v59 = (u57.Position - u56.Position) * 0.5;
            local v60 = u56.Position + v59;
            local v61 = v59 * p58;
            Attachment0.CFrame = CFrame.new(v60 - v61) * (u56 - u56.Position);
            Attachment1.CFrame = CFrame.new(v60 + v61) * (u57 - u57.Position);
        end;

        table.insert(p11, function() -- Line: 168
            -- upvalues: setLengthScale (copy)
            setLengthScale(1);
        end);

        if u37 == u38 then
            if u37 ~= 1 then
                setTScale(u37);
            end;
        else
            local fromParams = u2.fromParams;
            local v62 = u1.get(p9, "Transparency_Scale_Curve", u3.default_bezier);
            table.insert(p11, fromParams(v62, v34, function(p63, p64) -- Line: 178
                -- upvalues: setTScale (copy), u3 (ref), u37 (copy), u38 (copy), u44 (ref)
                setTScale(u3.lerp(u37, u38, p63));

                return p64 * u44;
            end, u45));
        end;

        if u32 ~= u33 then
            local fromParams = u2.fromParams;
            local v65 = u1.get(p9, "Length_Texture_Curve", u3.default_bezier);
            table.insert(p11, fromParams(v65, v34, function(p66, p67) -- Line: 195
                -- upvalues: u10 (copy), u3 (ref), u32 (copy), u33 (copy), u44 (ref)
                u10.TextureLength = u3.lerp(u32, u33, p66);

                return p67 * u44;
            end, u45));
        end;

        if u36 == u35 then
            if u32 ~= 1 then
                setLengthScale(u36);
            end;
        else
            local fromParams = u2.fromParams;
            local v68 = u1.get(p9, "Length_Scale_Curve", u3.default_bezier);
            table.insert(p11, fromParams(v68, v34, function(p69, p70) -- Line: 207
                -- upvalues: u3 (ref), u36 (copy), u35 (copy), setLengthScale (copy), u44 (ref)
                setLengthScale((u3.lerp(u36, u35, p69)));

                return p70 * u44;
            end, u45));
        end;

        if u18 == u19 then
            u10.Width0 = u18;
        else
            local fromParams = u2.fromParams;
            local v71 = u1.get(p9, "Width0_Curve", u3.default_bezier);
            table.insert(p11, fromParams(v71, v34, function(p72, p73) -- Line: 222
                -- upvalues: u10 (copy), u3 (ref), u18 (copy), u19 (copy), u44 (ref)
                u10.Width0 = u3.lerp(u18, u19, p72);

                return p73 * u44;
            end, u45));
        end;

        if u20 == u21 then
            u10.Width1 = u20;
        else
            local fromParams = u2.fromParams;
            local v74 = u1.get(p9, "Width1_Curve", u3.default_bezier);
            table.insert(p11, fromParams(v74, v34, function(p75, p76) -- Line: 234
                -- upvalues: u10 (copy), u3 (ref), u20 (copy), u21 (copy), u44 (ref)
                u10.Width1 = u3.lerp(u20, u21, p75);

                return p76 * u44;
            end, u45));
        end;

        if u22 == u23 then
            u10.Width0 = u18;
        else
            local fromParams = u2.fromParams;
            local v77 = u1.get(p9, "CurveSize0_Curve", u3.default_bezier);
            table.insert(p11, fromParams(v77, v34, function(p78, p79) -- Line: 246
                -- upvalues: u10 (copy), u3 (ref), u22 (copy), u23 (copy), u44 (ref)
                u10.CurveSize0 = u3.lerp(u22, u23, p78);

                return p79 * u44;
            end, u45));
        end;

        if u24 == u25 then
            u10.Width1 = u20;
        else
            local fromParams = u2.fromParams;
            local v80 = u1.get(p9, "CurveSize1_Curve", u3.default_bezier);
            table.insert(p11, fromParams(v80, v34, function(p81, p82) -- Line: 258
                -- upvalues: u10 (copy), u3 (ref), u24 (copy), u25 (copy), u44 (ref)
                u10.CurveSize1 = u3.lerp(u24, u25, p81);

                return p82 * u44;
            end, u45));
        end;

        local v83 = u4.getFlipbookData(p9);
        local v84;

        if v83 then
            local v86 = {
                ref = p9,
                frames = v83,
                speedTween = u45,
                effectDuration = v34,
                curve = u1.get(p9, "Flipbook_Change_Curve", u3.linear_bezier),
                duration = u1.get(p9, "Flipbook_Change_Duration", v34),

                getSpeed = function() -- Line: 281, Name: getSpeed
                    -- upvalues: u44 (ref)
                    return u44;
                end,

                setTexture = function(p85) -- Line: 285, Name: setTexture
                    -- upvalues: u10 (copy)
                    u10.Texture = p85;
                end
            };
            v84 = u4.getChangeDuration(v86);
            local fromParams = u2.fromParams;
            local curve = v86.curve;
            local v87 = u4.createUpdateCallback(v86);
            table.insert(p11, fromParams(curve, v84, v87, u45));
        else
            v84 = 0;
        end;

        u2.timer(math.max(v34, v84), function(p88, p89) -- Line: 298
            -- upvalues: u44 (ref), u45 (ref)
            if u44 > 0 or p89 > 0 and (u45 and u45.Connected) then
                return p88 * u44;
            end;

            return nil;
        end, u45, p11);

        if v13 then
            local Finished2 = p11.effects.emitOnFinish(v13, u10.Parent or workspace.Terrain, p11.depth + 1, p11).Finished;
            table.insert(v43, Finished2);
        end;

        u5.all(v43):await();
    end
};