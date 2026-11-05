  

 

local random = math.random;

return function(p1, p2, p3) -- Line: 2
    -- upvalues: random (copy)
    local v4 = game:GetService("ReplicatedStorage")["Client Assets"]["Stone Free"].HitEffect:Clone();
    v4.CFrame = CFrame.new(p1.Torso.CFrame.Position, p2.PrimaryPart.CFrame.Position) * CFrame.Angles(random(), random(), random());
    v4.CFrame = v4.CFrame * CFrame.new(random(-1, 0.5), random(-0.5, 1), random(-1, 0.5));
    v4.Parent = workspace;

    for _, child in pairs(v4.Attachment:GetChildren()) do
        child:Emit(22);
    end;

    game:GetService("Debris"):AddItem(v4, 1);
end;