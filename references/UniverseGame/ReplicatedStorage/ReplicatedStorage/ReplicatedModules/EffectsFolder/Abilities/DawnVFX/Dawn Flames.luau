  

 

local u1 = game.ReplicatedStorage["Client Assets"];

return function(p2, p3) -- Line: 2
    -- upvalues: u1 (copy)
    local v4 = u1.Dawn.Flames:GetChildren();

    for _, child in ipairs(p2:GetChildren()) do
        if child:IsA("BasePart") then
            for _, v in ipairs(v4) do
                local v5 = v:Clone();
                v5.Enabled = true;
                v5.Parent = child;
                deb:AddItem(v5, p3.Time);
            end;
        end;
    end;
end;