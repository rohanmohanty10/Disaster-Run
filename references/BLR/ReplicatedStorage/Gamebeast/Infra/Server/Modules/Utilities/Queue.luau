  

return {
    new = function() -- Line: 7, Name: new
        return {
            first = 0,
            last = -1,
            len = 0,

            push = function(p1, p2) -- Line: 14, Name: push
                p1.last = p1.last + 1;
                p1[p1.last] = p2;
                p1.len = p1.len + 1;
            end,

            pop = function(p3) -- Line: 20, Name: pop
                local first = p3.first;

                if p3.last >= first then
                    local v4 = p3[first];
                    p3[first] = nil;
                    p3.first = p3.first + 1;
                    p3.len = p3.len - 1;

                    return v4;
                end;
            end
        };
    end
};