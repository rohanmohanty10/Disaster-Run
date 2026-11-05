  

 

return function(p1) -- Line: 1
    function p1.Lerp(p2, p3, p4) -- Line: 2
        if typeof(p2) == "Color3" then
            return p2:Lerp(p3, p4);
        end;

        return p2 + (p3 - p2) * p4;
    end;
end;