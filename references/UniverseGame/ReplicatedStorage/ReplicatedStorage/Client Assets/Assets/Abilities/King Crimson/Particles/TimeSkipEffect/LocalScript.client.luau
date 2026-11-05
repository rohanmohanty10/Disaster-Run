  

 

local RunService = game:GetService("RunService");
local v1 = { "rbxassetid://4573462670", "rbxassetid://4573463247", "rbxassetid://4573464191", "rbxassetid://4573465237", "rbxassetid://4573466633", "rbxassetid://4573467848", "rbxassetid://4573468665", "rbxassetid://4573469255", "rbxassetid://4573469861", "rbxassetid://4573470481", "rbxassetid://4573472230", "rbxassetid://4573472712", "rbxassetid://4573473408", "rbxassetid://4573474618", "rbxassetid://4573475743", "rbxassetid://4573476483", "rbxassetid://4573476928", "rbxassetid://4573477493" };

for i = 1, #v1 do
    script.Parent.ImageLabel.Image = v1[i];
    RunService.RenderStepped:Wait();
end;

script.Parent:Destroy();