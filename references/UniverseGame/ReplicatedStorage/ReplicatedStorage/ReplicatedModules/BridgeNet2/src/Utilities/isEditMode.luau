  

 

local RunService = game:GetService("RunService");
local v1;

if RunService:IsRunning() == false then
    v1 = RunService:IsStudio() == true;
else
    v1 = false;
end;

return v1;