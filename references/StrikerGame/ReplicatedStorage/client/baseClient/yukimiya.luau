 

 

local v1 = {};

local function getSideDirection(p2) -- Line: 3
    local X = p2.humanoidRootPart.CFrame:VectorToObjectSpace(p2.human.MoveDirection).X;

    return math.round(X) == -1;
end;

local function getDirection(p3) -- Line: 7
    local v4 = p3.humanoidRootPart.CFrame:VectorToObjectSpace(p3.human.MoveDirection);
    local math_round_ret = math.round(v4.X);
    local math_round_ret2 = math.round(v4.Z);

    return math_round_ret == -1 and "Left" or (math_round_ret == 1 and "Right" or (math_round_ret2 == -1 and "Front" or (math_round_ret2 == 1 and "Back" or "Front")));
end;

function v1.skill2(p5) -- Line: 19
    local v6 = {};
    local X = p5.humanoidRootPart.CFrame:VectorToObjectSpace(p5.human.MoveDirection).X;
    v6[1], v6[2] = "skill2", math.round(X) == -1;
    p5:senduse(v6);
end;

function v1.skill3(p7) -- Line: 23
    local v8 = {};
    local X = p7.humanoidRootPart.CFrame:VectorToObjectSpace(p7.human.MoveDirection).X;
    local v9 = math.round(X) == -1;
    local v10 = p7.humanoidRootPart.CFrame:VectorToObjectSpace(p7.human.MoveDirection);
    local math_round_ret = math.round(v10.X);
    local math_round_ret2 = math.round(v10.Z);
    v8[1], v8[2], v8[3], v8[4] = "skill3", v9, math_round_ret == -1 and "Left" or (math_round_ret == 1 and "Right" or (math_round_ret2 == -1 and "Front" or (math_round_ret2 == 1 and "Back" or "Front"))), shared.moveVector;
    p7:senduse(v8);
end;

return v1;