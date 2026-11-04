 
 

local v1 = {
    __index = {}
};

local function get_move_label(p2) -- Line: 4
    local v3 = p2.humanoidRootPart.CFrame:VectorToObjectSpace(p2.human.MoveDirection);

    return math.round(v3.X) == 1 and "Right" or (math.round(v3.X) == -1 and "Left" or (math.round(v3.Z) == 1 and "Back" or "Front"));
end;

local function is_airborne(p4) -- Line: 16
    local State = p4.human:GetState();

    return State == Enum.HumanoidStateType.Jumping and true or State == Enum.HumanoidStateType.Freefall;
end;

function v1.skill1(p5) -- Line: 21
    p5:senduse({ "skill1" });
end;

function v1.skill3(p6) -- Line: 25
    p6:senduse({ "skill3" });
end;

function v1.skill4(p7) -- Line: 29
    local v8 = {};
    local State = p7.human:GetState();
    local v9 = State == Enum.HumanoidStateType.Jumping and true or State == Enum.HumanoidStateType.Freefall;
    local v10 = p7.humanoidRootPart.CFrame:VectorToObjectSpace(p7.human.MoveDirection);
    v8[1], v8[2], v8[3] = "skill4", v9, math.round(v10.X) == 1 and "Right" or (math.round(v10.X) == -1 and "Left" or (math.round(v10.Z) == 1 and "Back" or "Front"));
    p7:senduse(v8);
end;

return v1;