  

 

game:GetService("TweenService");
local u1 = game:GetService("ReplicatedStorage")["Client Assets"];

return function(p2, p3) -- Line: 4
    -- upvalues: u1 (copy)
    local Head = p2:FindFirstChild("Head");

    if Head == nil then
        return;
    end;

    local v4 = u1["Candy Cutlass"].HotChocolate.Steam.SteamParticle:Clone();
    v4.Parent = Head;
    task.wait(2.5);
    task.delay(1.5, v4.Destroy, v4);
    v4.Enabled = false;
end;