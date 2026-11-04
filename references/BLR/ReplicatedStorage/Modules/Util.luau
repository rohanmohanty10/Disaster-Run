  

return {
    RandomiseTable = function(p1) -- Line: 3, Name: RandomiseTable
        for i = #p1, 2, -1 do
            local math_random_ret = math.random(1, i);
            local v2 = p1[i];
            p1[i] = p1[math_random_ret];
            p1[math_random_ret] = v2;
            local _ = i;
        end;
    end
};