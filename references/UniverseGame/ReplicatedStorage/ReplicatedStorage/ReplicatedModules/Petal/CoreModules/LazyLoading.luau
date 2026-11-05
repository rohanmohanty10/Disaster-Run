  

 

require(script.Parent.Types);

return function() -- Line: 4
    return {
        cache = {},

        setCache = function(p1, p2, p3) -- Line: 7, Name: setCache
            if p2 == nil or (not p2.Name or p2.Name == ".ignore") then
                return false;
            end;

            if p3 then
                if not p1.cache[p3] then
                    p1.cache[p3] = {};
                end;

                p1.cache[p3][p2.Name] = p2;
            else
                p1.cache[p2.Name] = p2;
            end;

            return true;
        end,

        push = function(p4, p5, p6) -- Line: 24, Name: push
            return p4:setCache(p5, p6 or nil);
        end,

        pull = function(p7, p8, p9) -- Line: 29, Name: pull
            local v10;

            if p9 then
                v10 = p7.cache[p9][p8];
            else
                v10 = p7.cache[p8];
            end;

            if v10 ~= nil then
                return v10;
            end;

            return false;
        end,

        pullDirectory = function(p11, p12) -- Line: 40, Name: pullDirectory
            if p12 == nil or p11.cache[p12] == nil then
                return false;
            end;

            return p11.cache[p12];
        end
    };
end;