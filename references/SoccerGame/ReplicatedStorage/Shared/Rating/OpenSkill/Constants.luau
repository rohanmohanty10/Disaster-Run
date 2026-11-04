  

local u3 = {
    z = function(p1) -- Line: 3, Name: z
        return p1.z or 3;
    end,

    mu = function(p2) -- Line: 7, Name: mu
        return p2.mu or 25;
    end
};

function u3.sigma(p4) -- Line: 11
    -- upvalues: u3 (copy)
    return p4.sigma or u3.mu(p4) / u3.z(p4);
end;

function u3.epsilon(p5) -- Line: 15
    return p5.epsilon or 0.0001;
end;

function u3.beta(p6) -- Line: 19
    -- upvalues: u3 (copy)
    return p6.beta or u3.sigma(p6) / 2;
end;

function u3.betaSq(p7) -- Line: 23
    -- upvalues: u3 (copy)
    return u3.beta(p7) ^ 2;
end;

return u3;