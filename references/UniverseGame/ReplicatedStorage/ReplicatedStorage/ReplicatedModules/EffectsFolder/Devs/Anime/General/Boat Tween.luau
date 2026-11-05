  

 

local BoatTween = require(script:WaitForChild("BoatTween"));

return function(p1, p2) -- Line: 3
    -- upvalues: BoatTween (copy)
    local u3 = BoatTween:Create(p1, p2);
    u3.Completed:Connect(function() -- Line: 6
        -- upvalues: u3 (copy)
        u3:Destroy();
    end);
    u3:Play();

    return u3;
end;