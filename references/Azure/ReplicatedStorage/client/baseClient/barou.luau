 

 

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

function v1.skill1(p2) -- Line: 16
    local X = p2.humanoidRootPart.CFrame:VectorToObjectSpace(p2.human.MoveDirection).X;
    p2:senduse({ "skill1", math.round(X) == -1 });
end;

return v1;