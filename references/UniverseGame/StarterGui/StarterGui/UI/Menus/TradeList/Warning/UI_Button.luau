  

 

return function(u1) -- Line: 1
    script.Parent.MouseButton1Down:Connect(function() -- Line: 2
        -- upvalues: u1 (copy)
        u1:Prompt("Policy Service", u1.PolicyError and "An error has occurred with Roblox services, you will not be able to trade paid items." or "Due to legal restrictions in your region, you are unable to trade paid items.", "ok", function(p2, p3, p4) -- Line: 7
            -- upvalues: u1 (ref)
            u1:PlaySound("Click");
        end);
    end);
end;