 

 

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
    local State = p2.human:GetState();
    p2:senduse({ "skill1", State == Enum.HumanoidStateType.Jumping and true or State == Enum.HumanoidStateType.Freefall });
end;

return v1;