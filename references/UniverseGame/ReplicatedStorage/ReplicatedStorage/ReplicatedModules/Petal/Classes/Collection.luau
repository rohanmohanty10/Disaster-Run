  

 

return function(p1) -- Line: 7
    local u2 = {};
    u2.__index = u2;

    function u2.new() -- Line: 11
        -- upvalues: u2 (copy)
        return setmetatable({
            _collection = {}
        }, u2);
    end;

    function u2.Add(p3, ...) -- Line: 20
        local v4 = { ... };

        for i = 1, #v4 do
            table.insert(p3._collection, v4[i]);
        end;
    end;

    function u2.forEach(p5, p6) -- Line: 28
        for i = 1, #p5._collection do
            p6(p5, p5._collection[i], i);
        end;
    end;

    function u2.atIndex(p7, p8) -- Line: 35
        return p7._collection[p8] or nil;
    end;

    function u2.pickOne(p9) -- Line: 40
        return p9._collection[math.random(1, p9:Len())];
    end;

    function u2.Len(p10) -- Line: 44
        return #p10._collection;
    end;

    function u2.Clear(p11) -- Line: 48
        p11:forEach(function(p12) -- Line: 49
            if typeof(p12) == "Instance" then
                p12:Destroy();
            end;
        end);
        table.clear(p11._collection);
    end;

    return u2;
end;