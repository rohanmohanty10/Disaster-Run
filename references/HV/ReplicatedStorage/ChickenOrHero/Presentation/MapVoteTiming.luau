 

 

return {
    canPresent = function(p1, p2, p3, p4, p5, p6) -- Line: 4, Name: canPresent
        if not p2 then
            return false;
        end;

        local v7;

        if type(p4) == "number" and type(p3) == "number" then
            v7 = p4 < p3;
        else
            v7 = false;
        end;

        return math.max(v7 and p2 and p2 or p2 + (p6.ArrivalBreatherSeconds or 4), p5 or 0) <= p1;
    end,

    shouldExpand = function(p8, p9) -- Line: 10, Name: shouldExpand
        local v10;

        if p8 == "Voting" then
            v10 = p9 >= 2;
        else
            v10 = false;
        end;

        return v10;
    end
};