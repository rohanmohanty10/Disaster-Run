 

 

local _ = game:GetService("TweenService");
local l__Blessings__1 = script.Parent:WaitForChild("Frames"):WaitForChild("Blessings");
for _, v1 in pairs(l__Blessings__1:GetChildren()) do
    local v2 = v1:FindFirstChild("Frame");
    if v2 then
        v2.Visible = false;
    end;
end;