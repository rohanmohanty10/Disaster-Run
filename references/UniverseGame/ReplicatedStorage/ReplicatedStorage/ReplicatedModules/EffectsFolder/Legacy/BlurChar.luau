  

 

return function(p1) -- Line: 1
    for _, child in pairs(p1.Character:GetChildren()) do
        if (child:IsA("Part") or child:IsA("MeshPart")) and child.Name ~= "HumanoidRootPart" then
            local v2 = game.ReplicatedStorage["Client Assets"]["Made In Heaven"].Blur.blur:Clone();
            local v3 = game.ReplicatedStorage["Client Assets"]["Made In Heaven"].Blur.blur2:Clone();
            v2.Parent = child;
            v3.Parent = child;
        end;
    end;
end;