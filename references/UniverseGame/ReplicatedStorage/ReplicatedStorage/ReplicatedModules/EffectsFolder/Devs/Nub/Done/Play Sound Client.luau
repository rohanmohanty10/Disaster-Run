  

 

return function(p1) -- Line: 1
    if typeof(p1) == "table" then
        for _, v in ipairs(p1) do
            v:Play();
        end;

        return;
    end;

    p1:Play();
end;