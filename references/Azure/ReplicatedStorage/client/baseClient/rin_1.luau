 
 

local Players = game:GetService("Players");
game:GetService("UserInputService");
game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local v1 = {
    __index = {}
};
require(ReplicatedStorage.util.actionUtil);
require(ReplicatedStorage.packets);
Players.LocalPlayer:GetMouse();
local _ = workspace.CurrentCamera;

function v1.skill2(p2) -- Line: 16
    local v3 = p2.humanoidRootPart.CFrame:VectorToObjectSpace(p2.human.MoveDirection);
    local v4 = math.round(v3.X) == -1 and "left" or (math.round(v3.X) == 1 and "right" or (math.round(v3.Z) == 1 and "back" or "front"));
    p2:senduse({ "skill2", v4 });
    print("direction on client is", v4);
end;

return v1;