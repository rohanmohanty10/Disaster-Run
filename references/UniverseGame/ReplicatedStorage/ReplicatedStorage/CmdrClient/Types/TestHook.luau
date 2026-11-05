  

 

return function(p1) -- Line: 2
    p1:RegisterHook("BeforeRun", function(p2) -- Line: 3
        if p2.Group == "TestHook" then
            warn(p2);
        end;
    end);
end;