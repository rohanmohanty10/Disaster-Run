  

 

return function(p1, p2, p3) -- Line: 1
    local v4 = game:GetService("ReplicatedStorage")["Client Assets"].Goku.Blink:Clone();
    v4.CFrame = typeof(p1) == "CFrame" and p1 and p1 or p1.HumanoidRootPart.CFrame;
    v4.Parent = workspace.Effects;

    for _, child in ipairs(v4.Attachment:GetChildren()) do
        child:Emit(8);
    end;

    game:GetService("Debris"):AddItem(v4, 1);
end;