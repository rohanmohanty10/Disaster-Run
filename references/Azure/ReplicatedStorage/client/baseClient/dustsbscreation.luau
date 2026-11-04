 

 

local v1 = {
    __index = {}
};
local UserInputService = game:GetService("UserInputService");

function v1.skill1(p2) -- Line: 6
    -- upvalues: UserInputService (copy)
    local v3 = p2.humanoidRootPart.CFrame:VectorToObjectSpace(p2.human.MoveDirection);
    local math_round_ret = math.round(v3.X);
    local v4 = UserInputService:IsKeyDown(Enum.KeyCode.A);
    local v5 = UserInputService:IsKeyDown(Enum.KeyCode.D);
    local v6 = (math_round_ret == -1 or v4) and "left" or ((math_round_ret == 1 or v5) and "right" or (math.round(v3.Z) == 1 and "back" or "front"));
    local v7 = p2.character:GetAttribute("DustbsOcclusionActive") and (v6 == "left" and true or v6 == "right");

    if p2.character:GetAttribute("SaeBeautifulActive") and (p2.character:GetAttribute("canReuse") ~= "skill1" and not v7) then
        return;
    end;

    p2:senduse({ "skill1", v6 });
end;

function v1.skill2(p8) -- Line: 37
    local v9 = p8.humanoidRootPart.CFrame:VectorToObjectSpace(p8.human.MoveDirection);
    p8:senduse({ "skill2", math.round(v9.X) == -1 and "left" or (math.round(v9.X) == 1 and "right" or (math.round(v9.Z) == 1 and "back" or "front")) });
end;

function v1.skill3(p10) -- Line: 54
    local X = p10.humanoidRootPart.CFrame:VectorToObjectSpace(p10.human.MoveDirection).X;
    local math_round_ret = math.round(X);
    p10:senduse({ "skill3", math_round_ret == -1 and "left" or (math_round_ret == 1 and "right" or nil) });
end;

return v1;