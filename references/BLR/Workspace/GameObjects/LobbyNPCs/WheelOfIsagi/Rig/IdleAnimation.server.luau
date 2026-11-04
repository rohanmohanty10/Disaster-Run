  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local v1 = script.Parent:WaitForChild("Humanoid"):LoadAnimation(ReplicatedStorage.Assets.Emotes.Bow);
v1.Looped = true;
v1:Play();