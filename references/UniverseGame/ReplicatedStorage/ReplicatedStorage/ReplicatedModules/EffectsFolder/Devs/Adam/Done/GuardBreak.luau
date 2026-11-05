  

 

return function(p1) -- Line: 1
    local v2 = game.ReplicatedStorage["Client Assets"].Blocking.BlockBreak.Attachment:Clone();
    v2.Parent = p1.PrimaryPart;

    for _, child in pairs(v2:GetChildren()) do
        child.Parent = p1.HumanoidRootPart or p1.PrimaryPart;
        child:Emit(child.Rate);
    end;
end;