  

game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("Players");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("ReplicatedStorage");

return function(p1, p2, p3) -- Line: 12
    local Humanoid = p3:FindFirstChild("Humanoid");

    if (not Humanoid or Humanoid:GetState() ~= Enum.HumanoidStateType.Freefall) and Humanoid then
        local _ = Humanoid:GetState() == Enum.HumanoidStateType.Jumping;
    end;
end;