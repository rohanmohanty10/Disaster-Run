 

 

return {
    transform = function(p1, p2, p3, p4) -- Line: 3, Name: transform
        local v5 = p1 * p2.C0;
        local v6 = p3 - v5.Position;

        if v6.Magnitude < 0.01 then
            return p4;
        end;

        local Vector3_new_ret = Vector3.new(v6.X, 0, v6.Z);

        if Vector3_new_ret.Magnitude < 0.01 then
            return p4;
        end;

        local math_atan2_ret = math.atan2(v6.Y, Vector3_new_ret.Magnitude);
        local math_clamp_ret = math.clamp(math_atan2_ret, -0.4363323129985824, 0.5235987755982988);
        local v7 = Vector3_new_ret.Unit * math.cos(math_clamp_ret) + Vector3.new(0, 1, 0) * math.sin(math_clamp_ret);
        local v8 = CFrame.lookAt(Vector3.new(0, 0, 0), v7) * CFrame.Angles(1.5707963267948966, 0, 0);
        local v9 = v5.Rotation:Inverse() * v8 * p2.C1.Rotation;

        return CFrame.new(p4.Position) * v9;
    end
};