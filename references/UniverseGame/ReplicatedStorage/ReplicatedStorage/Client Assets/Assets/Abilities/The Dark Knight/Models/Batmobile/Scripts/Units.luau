  

 

local u3 = {
    studsToMiles = function(p1) -- Line: 7, Name: studsToMiles
        return p1 / 5280;
    end,

    milesToStuds = function(p2) -- Line: 11, Name: milesToStuds
        return p2 * 5280;
    end
};

function u3.studsPerSecondToMilesPerHour(p4) -- Line: 15
    -- upvalues: u3 (copy)
    return u3.studsToMiles(p4) * 3600;
end;

function u3.milesPerHourToStudsPerSecond(p5) -- Line: 21
    -- upvalues: u3 (copy)
    return u3.milesToStuds(p5) / 3600;
end;

return u3;