 
 

local Players = game:GetService("Players");
game:GetService("UserInputService");
game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local v1 = {
    __index = {}
};
require(ReplicatedStorage.packets);
require(ReplicatedStorage.util.actionUtil);
Players.LocalPlayer:GetMouse();
local _ = workspace.CurrentCamera;

function v1.skill2(p2) -- Line: 16
    local X = p2.humanoidRootPart.CFrame:VectorToObjectSpace(p2.human.MoveDirection).X;
    p2:senduse({ "skill2", math.round(X) == -1 });
end;

function v1.skill3(p3) -- Line: 23
    local X = p3.humanoidRootPart.CFrame:VectorToObjectSpace(p3.human.MoveDirection).X;
    local math_round_ret = math.round(X);
    local v4;

    if math_round_ret == -1 then
        v4 = true;
    elseif math_round_ret == 1 then
        v4 = false;
    else
        v4 = nil;
    end;

    p3:senduse({ "skill3", v4 });
end;

return v1;