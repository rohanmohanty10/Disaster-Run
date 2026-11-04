 
 

return {
    __index = {},

    skill3 = function(p1) -- Line: 4, Name: skill3
        local State = p1.human:GetState();
        p1:senduse({ "skill3", State == Enum.HumanoidStateType.Jumping and true or State == Enum.HumanoidStateType.Freefall });
    end
};