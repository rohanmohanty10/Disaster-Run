  

if not game:GetService("RunService"):IsStudio() then
    return;
end;

local RunService = game:GetService("RunService");

while true do
    local v1 = tick();
    RunService.Heartbeat:Wait();

    while v1 + 0.1 >= tick() do

    end;
end;