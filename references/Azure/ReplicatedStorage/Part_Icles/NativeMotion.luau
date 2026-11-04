 

 

return {
    shares = function(p1, p2) -- Line: 24, Name: shares
        local v3 = 0.6931471805599453 * p1;

        if math.abs(v3 * p2) < 1e-6 then
            return p2, p2 * p2 / 2;
        end;

        local v4 = (1 - math.exp(-v3 * p2)) / v3;

        return v4, (p2 - v4) / v3;
    end
};