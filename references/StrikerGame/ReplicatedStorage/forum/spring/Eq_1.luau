 
 

local v1 = {};

function OverDamping(p2: number, p3: number, p4: number, p5: number, p6: number, p7: number)
    local v8 = p3 * p3 - p4 * 4 / p2;
    local v9 = p3 + math.sqrt(v8);
    local v10 = p3 - math.sqrt(v8);
    local u11 = v9 * -0.5;
    local u12 = v10 * -0.5;
    local u13 = (u12 * p5 - p6) / (u12 - u11);
    local u14 = (u11 * p5 - p6) / (u11 - u12);
    local u15 = p7 / p4;

    return {
        Offset = function(p16) -- Line: 47, Name: Offset
            -- upvalues: u13 (copy), u11 (copy), u14 (copy), u12 (copy), u15 (copy)
            return u13 * math.exp(u11 * p16) + u14 * math.exp(u12 * p16) + u15;
        end,

        Velocity = function(p17) -- Line: 50, Name: Velocity
            -- upvalues: u13 (copy), u11 (copy), u14 (copy), u12 (copy)
            return u13 * u11 * math.exp(u11 * p17) + u14 * u12 * math.exp(u12 * p17);
        end,

        Acceleration = function(p18) -- Line: 53, Name: Acceleration
            -- upvalues: u13 (copy), u11 (copy), u14 (copy), u12 (copy)
            return u13 * u11 * u11 * math.exp(u11 * p18) + u14 * u12 * u12 * math.exp(u12 * p18);
        end
    };
end;

function CriticalDamping(p19: number, p20: number, p21: number, u22: number, p23: number, p24: number)
    local u25 = -p20 / 2;
    local u26 = p23 - u25 * u22;
    local u27 = p24 / p21;

    return {
        Offset = function(p28) -- Line: 66, Name: Offset
            -- upvalues: u25 (copy), u22 (copy), u26 (copy), u27 (copy)
            return math.exp(u25 * p28) * (u22 + u26 * p28) + u27;
        end,

        Velocity = function(p29) -- Line: 69, Name: Velocity
            -- upvalues: u25 (copy), u26 (copy), u22 (copy)
            return math.exp(u25 * p29) * (u26 * u25 * p29 + u22 * u25 + u26);
        end,

        Acceleration = function(p30) -- Line: 72, Name: Acceleration
            -- upvalues: u25 (copy), u26 (copy), u22 (copy)
            return u25 * math.exp(u25 * p30) * (u26 * u25 * p30 + u22 * u25 + u26 * 2);
        end
    };
end;

function UnderDamping(p31: number, p32: number, p33: number, u34: number, p35: number, p36: number)
    local u37 = -p32 / 2;
    local math_sqrt_ret = math.sqrt(-(p32 * p32 - p33 * 4 / p31));
    local u38 = (p35 - u37 * u34) / math_sqrt_ret;
    local u39 = p36 / p33;

    return {
        Offset = function(p40) -- Line: 87, Name: Offset
            -- upvalues: u37 (copy), u34 (copy), math_sqrt_ret (copy), u38 (copy), u39 (copy)
            return math.exp(u37 * p40) * (u34 * math.cos(math_sqrt_ret * p40) + u38 * math.sin(math_sqrt_ret * p40)) + u39;
        end,

        Velocity = function(p41) -- Line: 90, Name: Velocity
            -- upvalues: u37 (copy), u34 (copy), math_sqrt_ret (copy), u38 (copy)
            return -math.exp(u37 * p41) * ((u34 * math_sqrt_ret - u38 * u37) * math.sin(math_sqrt_ret * p41) + (-u38 * math_sqrt_ret - u34 * u37) * math.cos(math_sqrt_ret * p41));
        end,

        Acceleration = function(p42) -- Line: 93, Name: Acceleration
            -- upvalues: u37 (copy), u38 (copy), math_sqrt_ret (copy), u34 (copy)
            return -math.exp(u37 * p42) * ((u38 * math_sqrt_ret * math_sqrt_ret + u34 * 2 * u37 * math_sqrt_ret - u38 * u37 * u37) * math.sin(math_sqrt_ret * p42) + (u34 * math_sqrt_ret * math_sqrt_ret - u38 * 2 * u37 * math_sqrt_ret - u34 * u37 * u37) * math.cos(math_sqrt_ret * p42));
        end
    };
end;

function v1.F(p43: table) -- Line: 100
    local InitialOffset = p43.InitialOffset;
    local InitialVelocity = p43.InitialVelocity;
    local ExternalForce = p43.ExternalForce;
    local Mass = p43.Mass;
    local Damping = p43.Damping;
    local Constant = p43.Constant;
    local v44 = Damping * Damping - Constant * 4 / Mass;

    if v44 > 0 then
        return OverDamping(Mass, Damping, Constant, InitialOffset, InitialVelocity, ExternalForce);
    end;

    if v44 == 0 then
        return CriticalDamping(Mass, Damping, Constant, InitialOffset, InitialVelocity, ExternalForce);
    end;

    return UnderDamping(Mass, Damping, Constant, InitialOffset, InitialVelocity, ExternalForce);
end;

return v1;