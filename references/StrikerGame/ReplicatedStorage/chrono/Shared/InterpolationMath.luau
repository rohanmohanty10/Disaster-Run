 

 

require(script.Parent.Types);
local Config = require(script.Parent.Config);

return {
    Hermite = function(p1: vector, p2: vector, p3: vector, p4: vector, p5: number, p6: number) -- Line: 6, Name: Hermite
        if not p6 or p6 == 0 then
            return p1:Lerp(p2, p5);
        end;

        local v7 = p5 * p5;
        local v8 = v7 * p5;

        return p1 * (v8 * 2 - v7 * 3 + 1) + (p3 or Vector3.new(0, 0, 0)) * p6 * (v8 - v7 * 2 + p5) + p2 * (v8 * -2 + v7 * 3) + (p4 or Vector3.new(0, 0, 0)) * p6 * (v8 - v7);
    end,

    VelocityAt = function(p9: any, p10: number, p11, p12: number?) -- Line: 37, Name: VelocityAt
        -- upvalues: Config (copy)
        if not p9 then
            return Vector3.new(0, 0, 0);
        end;

        local Position = p9.value.Position;
        local Position2 = p11.Position;
        local v13 = p12 or 0.05;
        local v14 = p10 - p9.t;

        if v14 <= 1e-6 then
            return Vector3.new(0, 0, 0);
        end;

        if math.max(v13 * 3, 0.15) < v14 then
            if Config.FLAGS.SNAPSHOT_INTERPOLATION_FIX then
                v14 = v13;
            end;
        end;

        if Config.FLAGS.VELOCITY_CALC_FIX then
            v14 = math.max(v14, v13);
        end;

        return (Position2 - Position) / v14;
    end,

    CalculateVelocity = function(p15: vector, p16: number, p17: vector, p18: number, p19: number?) -- Line: 23, Name: CalculateVelocity
        -- upvalues: Config (copy)
        local v20 = p19 or 0.05;
        local v21 = p18 - p16;

        if v21 <= 1e-6 then
            return Vector3.new(0, 0, 0);
        end;

        if math.max(v20 * 3, 0.15) < v21 then
            if Config.FLAGS.SNAPSHOT_INTERPOLATION_FIX then
                v21 = v20;
            end;
        end;

        if Config.FLAGS.VELOCITY_CALC_FIX then
            v21 = math.max(v21, v20);
        end;

        return (p17 - p15) / v21;
    end
};