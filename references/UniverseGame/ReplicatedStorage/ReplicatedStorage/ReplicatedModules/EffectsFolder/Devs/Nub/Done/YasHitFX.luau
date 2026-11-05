  

 

local u1 = game:GetService("ReplicatedStorage")["Client Assets"]["Hit Effects"];

return function(p2, p3, p4) -- Line: 3
    -- upvalues: u1 (copy)
    local v5 = p2.PrimaryPart or p2.HumanoidRootPart;
    local v6 = u1.Yas:Clone();
    v6.CFrame = v5.CFrame;
    v6.Parent = workspace.Effects;

    for _, child in ipairs(v6.Hit:GetChildren()) do
        child:Emit(8.5);
    end;

    game:GetService("Debris"):AddItem(v6, 2);
end;