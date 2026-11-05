  

 

return function(p1, p2) -- Line: 1, Name: setJumpingEnabled
    local v3 = p1:FindFirstChildOfClass("Humanoid");
    assert(v3, "No humanoid found!");
    v3:SetStateEnabled(Enum.HumanoidStateType.Jumping, p2);
end;