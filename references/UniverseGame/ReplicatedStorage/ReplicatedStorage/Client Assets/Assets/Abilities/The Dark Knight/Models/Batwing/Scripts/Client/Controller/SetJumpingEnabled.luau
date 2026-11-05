  

 

return function(p1, p2) -- Line: 1
    if p1 then
        p1 = p1:FindFirstChildOfClass("Humanoid");
    end;

    if p1 then
        p1:SetStateEnabled(Enum.HumanoidStateType.Jumping, p2);
    end;
end;