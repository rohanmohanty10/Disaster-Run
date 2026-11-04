 

 

game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("Debris");

return function(p1) -- Line: 9
    for _, descendant in ipairs(p1:GetDescendants()) do
        if descendant:IsA("BodyVelocity") or (descendant:IsA("BodyPosition") or descendant:IsA("BodyGyro")) then
            descendant:Destroy();
        end;
    end;
end;