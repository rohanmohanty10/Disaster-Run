  

 

return function(p1) -- Line: 2
    local v2 = {};
    v2.__index = v2;

    function v2.new() -- Line: 6
    end;

    return v2;
end;