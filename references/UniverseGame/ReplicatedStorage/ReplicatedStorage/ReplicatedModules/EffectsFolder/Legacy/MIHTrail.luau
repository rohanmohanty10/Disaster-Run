  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");

return function(p1, p2) -- Line: 3
    -- upvalues: ReplicatedStorage (copy)
    if p2 then
        for _, child in pairs(p1:GetChildren()) do
            if child:IsA("Part") or child:IsA("MeshPart") then
                local v3 = ReplicatedStorage["Client Assets"]["Made In Heaven"].MIHTrail:Clone();
                local Weld = Instance.new("Weld");
                Weld.Part0 = child;
                Weld.Part1 = v3;
                Weld.Parent = v3;
                v3.Parent = child;
            end;
        end;

        return;
    end;

    for _, descendant in pairs(p1:GetDescendants()) do
        if descendant.Name == "MIHTrail" then
            game.Debris:AddItem(descendant, 1);
            descendant.Anchored = true;

            for _, child in pairs(descendant:GetChildren()) do
                if child:IsA("Weld") then
                    child:Destroy();
                end;
            end;
        end;
    end;
end;