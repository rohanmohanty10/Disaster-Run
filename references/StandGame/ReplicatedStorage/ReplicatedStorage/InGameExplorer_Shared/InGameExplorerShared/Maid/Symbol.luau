 

 

return function(u1) --[[ Name: Symbol, Line 2 ]]
    local v2 = newproxy(true);
    getmetatable(v2).__tostring = function() --[[ Name: __tostring, Line 5 ]]
        -- upvalues: u1 (copy)
        return u1;
    end;
    return v2;
end;