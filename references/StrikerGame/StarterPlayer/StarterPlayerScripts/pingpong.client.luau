 

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");

while task.wait(3) do
    local os_clock_ret = os.clock();
    local success, _ = pcall(function() -- Line: 4
        -- upvalues: ReplicatedStorage (copy)
        return ReplicatedStorage.pingpong2:InvokeServer();
    end);
    local os_clock_ret2 = os.clock();

    if success then
        shared.ping = os_clock_ret2 - os_clock_ret;
    end;
end;