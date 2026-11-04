 

 

local u1 = require("../mod/attributes");
local u2 = require("../mod/tween");
require("../types");
local u3 = require("../mod/utility");

return {
    emit = function(u4: userdata, p5: any) -- Line: 8, Name: emit
        -- upvalues: u3 (copy), u1 (copy), u2 (copy)
        if u3.isSpinModelStatic(u4) then
            return;
        end;

        local v6 = u1.get(u4, "SpinRotation", Vector3.new(0, 0, 0)) * u3.DEG_TO_RAD;
        local u7 = u1.get(u4, "Scale_Start", 1);
        local u8 = u1.get(u4, "Scale_End", 1);
        local v9 = u1.get(u4, "EmitDelay", 0);
        local u10 = u1.get(u4, "SyncPosition", false);
        local u11 = u1.get(u4, "SpinDuration", 0.5);
        local v12 = u1.get(u4, "SpinSpeed_Duration", 0.1);
        local u13 = u1.get(u4, "SpinSpeed_Start", 0);
        local u14 = u1.get(u4, "SpinSpeed_End", 1);
        local u15 = u13;
        task.wait(v9);
        local u16;

        if u13 == u14 then
            u16 = nil;
        else
            u16 = u2.fromParams(u1.get(u4, "SpinSpeed_Curve", u3.default_bezier), v12, function(p17, p18) -- Line: 38
                -- upvalues: u15 (ref), u3 (ref), u13 (copy), u14 (copy)
                u15 = u3.lerp(u13, u14, p17);

                return p18;
            end);
            table.insert(p5, u16);
        end;

        local Pivot = u4:GetPivot();
        local Scale = u4:GetScale();

        if u7 == u8 then
            u4:ScaleTo(u7);
        else
            local fromParams = u2.fromParams;
            local v19 = u1.get(u4, "Scale_Curve", u3.default_bezier);
            table.insert(p5, fromParams(v19, u11, function(p20, p21) -- Line: 53
                -- upvalues: u4 (copy), u3 (ref), u7 (copy), u8 (copy)
                u4:ScaleTo(u3.lerp(u7, u8, p20));

                return p21;
            end));
        end;

        local u22 = u4:FindFirstAncestorOfClass("Attachment") or u4:FindFirstAncestorWhichIsA("BasePart");
        table.insert(p5, function() -- Line: 64
            -- upvalues: u4 (copy), u22 (copy), u3 (ref), Pivot (copy), Scale (copy)
            u4:PivotTo(u22 and u3.getTransformedOriginExtents(u22) or Pivot);
            u4:ScaleTo(Scale);
        end);
        local u23 = v6 * u11;
        u2.timer(u11, function(p24, p25) -- Line: 71
            -- upvalues: u11 (copy), u23 (ref), u22 (copy), u10 (copy), u3 (ref), Pivot (copy), u4 (copy), u15 (ref), u16 (ref)
            local v26 = u23 * math.clamp(p25 / u11, 0, 1);
            local v27;

            if u22 and u10 then
                v27 = u3.getTransformedOriginExtents(u22);
            else
                v27 = Pivot;
            end;

            u4:PivotTo(v27 * CFrame.fromOrientation(v26.x, v26.y, v26.z));

            if u15 > 0 or p25 > 0 and u16.Connected then
                return p24 * u15;
            end;

            return nil;
        end, u16, p5, u3.RENDER_PRIORITY + p5.depth);
    end
};