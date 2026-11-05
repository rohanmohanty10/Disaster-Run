  

 

local u1 = {
    ClimbAnimation = true,
    FallAnimation = true,
    IdleAnimation = true,
    JumpAnimation = true,
    RunAnimation = true,
    SwimAnimation = true,
    WalkAnimation = true
};

return function(p2, p3) -- Line: 13
    -- upvalues: u1 (copy)
    local v4 = p2:GetAppliedDescription();

    if p2.RigType == Enum.HumanoidRigType.R6 then
        return;
    end;

    for i, _ in pairs(u1) do
        if v4[i] > 0 then
            p3:WaitForChild((i:sub(1, #i - 9):lower()));
        end;
    end;
end;