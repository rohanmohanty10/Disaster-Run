  

local Gamebeast = game:GetService("ReplicatedStorage"):WaitForChild("Gamebeast", 60);

if not Gamebeast then
    return;
end;

local v1 = os.clock() + 60;

while Gamebeast:GetAttribute("BLRTelemetry") == nil and os.clock() < v1 do
    task.wait(0.5);
end;

if Gamebeast:GetAttribute("BLRTelemetry") ~= "on" then
    return;
end;

local success, result = pcall(require, Gamebeast);

if success then
    pcall(function() -- Line: 30
        -- upvalues: result (copy)
        result:Setup();
    end);
end;