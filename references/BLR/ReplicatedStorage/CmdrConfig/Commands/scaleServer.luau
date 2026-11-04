  

game:GetService("ServerStorage");

return function(p1, p2, p3) -- Line: 3
    for _, _ in p2 do
        if p2.Character then
            p2.Character:ScaleTo(p3);
        end;
    end;
end;