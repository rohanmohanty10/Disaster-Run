 
 

local Config = require(script.Parent:WaitForChild("Config"));

return {
    push = function(p1: table, p2: vector) -- Line: 12, Name: push
        -- upvalues: Config (copy)
        table.insert(p1, 1, p2);
        p1[Config.VelocityHistory + 1] = nil;
    end,

    normal = function(p3: vector, p4: vector) -- Line: 19, Name: normal
        local v5 = p4 - p3;
        local Vector3_new_ret = Vector3.new(v5.X, 0, v5.Z);

        if Vector3_new_ret.Magnitude < 0.001 or Vector3_new_ret.Magnitude < v5.Magnitude * 0.35 then
            return nil;
        end;

        return Vector3_new_ret.Unit;
    end,

    closing = function(p6: table, p7: table, p8: vector) -- Line: 30, Name: closing
        local v9 = (-1 / 0);
        local v10 = 0;
        local v11 = 0;

        for i = 1, math.min(#p6, #p7) do
            local v12 = p6[i]:Dot(p8);
            local v13 = -p7[i]:Dot(p8);
            local v14;

            if v9 < v12 + v13 then
                v9 = v12 + v13;
                v11 = v13;
                v10 = v12;
                v14 = i;
            else
                v14 = i;
            end;
        end;

        return v9, v10, v11;
    end,

    resolve = function(p15: vector, p16: number, p17: number, p18: number) -- Line: 43, Name: resolve
        -- upvalues: Config (copy)
        local math_max_ret = math.max(p17, 0);
        local v19 = math_max_ret + math.max(p18, 0);
        local v20 = v19 <= 0.001 and 0.5 or math_max_ret / v19;
        local v21 = 1 - v20;
        local math_clamp_ret = math.clamp(Config.ClashBase + Config.ClashScale * p16, 0, Config.ClashMax);
        local u22 = math.abs(v20 - 0.5) <= Config.ClashEvenBand;

        local function side(p23: number, p24: number, p25: vector, p26: number) -- Line: 51
            -- upvalues: u22 (copy), Config (ref), math_clamp_ret (copy)
            local v27, v28;

            if u22 then
                v27 = Config.ClashEvenKeep;
                v28 = Config.ClashEvenStagger;
            elseif p24 < p23 then
                v27 = Config.ClashWinnerKeep;
                v28 = Config.ClashWinnerStagger;
            else
                v27 = Config.ClashLoserKeep;
                v28 = Config.ClashLoserStagger;
            end;

            return {
                dir = (p25 + Vector3.new(0, 1, 0) * Config.ClashUp).Unit,
                mag = math.min(math_clamp_ret * (Config.ClashWinnerFloor + Config.ClashLoserGain * p24 ^ Config.ClashShareExponent), Config.ClashKnockMax),
                away = math.max(-p26, 0),
                keep = v27,
                stagger = v28
            };
        end;

        return u22 and "even" or "win", side(v20, v21, -p15, p17), side(v21, v20, p15, p18);
    end,

    applyKnock = function(p29: vector, p30: vector, p31: table) -- Line: 76, Name: applyKnock
        local v32 = p29 - p30 * p29:Dot(p30);
        local v33 = p31.dir * p31.mag - p30 * (p31.away or 0);
        local v34 = v32.X + v33.X;
        local math_max_ret = math.max(v32.Y, v33.Y);

        return Vector3.new(v34, math_max_ret, v32.Z + v33.Z);
    end
};