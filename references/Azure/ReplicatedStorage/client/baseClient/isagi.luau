 

 

local Players = game:GetService("Players");
game:GetService("UserInputService");
game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local trove = require(ReplicatedStorage:WaitForChild("forum"):WaitForChild("trove"));
local v1 = {
    __index = {}
};
require(ReplicatedStorage.packets);
require(ReplicatedStorage.util.actionUtil);
Players.LocalPlayer:GetMouse();
local _ = workspace.CurrentCamera;
trove.new();

function v1.onAwaken(p2) -- Line: 18
end;

function v1.onAwakeEnded(p3) -- Line: 22
end;

return v1;