  

 

return function(p1) -- Line: 1
    local Scale = p1.Scale;
    local Duration = p1.Duration;

    for _, v in p1.Model:GetDescenants() do
        if v:IsA("Sound") then
            local Volume = v.Volume;
            v.Volume = v.Volume * Scale;
            task.delay(Duration, function() -- Line: 11
                -- upvalues: v (copy), Volume (copy)
                v.Volume = Volume;
            end);
        end;
    end;
end;