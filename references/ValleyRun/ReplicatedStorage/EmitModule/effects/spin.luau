 

 

local u1 = require("../mod/tween");
require("../types");
local u2 = require("../mod/utility");

return {
    emit = function(u3: userdata, p4: any) -- Line: 7, Name: emit
        -- upvalues: u2 (copy), u1 (copy)
        if u2.isSpinModelStatic(u3) then
            return;
        end;

        local v5 = u2.getAttribute(u3, "SpinRotation", Vector3.new(0, 0, 0)) * u2.DEG_TO_RAD;
        local Attribute = u2.getAttribute(u3, "Scale_Start", 1);
        local Attribute2 = u2.getAttribute(u3, "Scale_End", 1);
        local Attribute3 = u2.getAttribute(u3, "EmitDelay", 0);
        local Attribute4 = u2.getAttribute(u3, "SyncPosition", false);
        local Attribute5 = u2.getAttribute(u3, "SpinDuration", 0.5);
        local Attribute6 = u2.getAttribute(u3, "SpinSpeed_Duration", 0.1);
        local Attribute7 = u2.getAttribute(u3, "SpinSpeed_Start", 0);
        local Attribute8 = u2.getAttribute(u3, "SpinSpeed_End", 1);
        local u6 = Attribute7;
        task.wait(Attribute3);
        local u7;

        if Attribute7 == Attribute8 then
            u7 = nil;
        else
            u7 = u1.fromParams(u2.getAttribute(u3, "SpinSpeed_Curve", u2.default_bezier), Attribute6, function(p8, p9) -- Line: 37
                -- upvalues: u6 (ref), u2 (ref), Attribute7 (copy), Attribute8 (copy)
                u6 = u2.lerp(Attribute7, Attribute8, p8);

                return p9;
            end);
            table.insert(p4, u7);
        end;

        local Pivot = u3:GetPivot();
        local Scale = u3:GetScale();

        if Attribute == Attribute2 then
            u3:ScaleTo(Attribute);
        else
            local fromParams = u1.fromParams;
            local Attribute9 = u2.getAttribute(u3, "Scale_Curve", u2.default_bezier);
            table.insert(p4, fromParams(Attribute9, Attribute5, function(p10, p11) -- Line: 55
                -- upvalues: u3 (copy), u2 (ref), Attribute (copy), Attribute2 (copy)
                u3:ScaleTo(u2.lerp(Attribute, Attribute2, p10));

                return p11;
            end));
        end;

        local u12 = u3:FindFirstAncestorOfClass("Attachment") or u3:FindFirstAncestorWhichIsA("BasePart");
        table.insert(p4, function() -- Line: 67
            -- upvalues: u3 (copy), u12 (copy), u2 (ref), Pivot (copy), Scale (copy)
            u3:PivotTo(u12 and u2.getTransformedOriginExtents(u12) or Pivot);
            u3:ScaleTo(Scale);
        end);
        local u13 = v5 * Attribute5;
        u1.timer(Attribute5, function(p14, p15) -- Line: 74
            -- upvalues: Attribute5 (copy), u13 (ref), u12 (copy), Attribute4 (copy), u2 (ref), Pivot (copy), u3 (copy), u6 (ref), u7 (ref)
            local v16 = u13 * math.clamp(p15 / Attribute5, 0, 1);
            local v17;

            if u12 and Attribute4 then
                v17 = u2.getTransformedOriginExtents(u12);
            else
                v17 = Pivot;
            end;

            u3:PivotTo(v17 * CFrame.fromOrientation(v16.x, v16.y, v16.z));

            if u6 > 0 or p15 > 0 and u7.Connected then
                return p14 * u6;
            end;

            return nil;
        end, u7, p4, u2.RENDER_PRIORITY + p4.depth);
    end
};