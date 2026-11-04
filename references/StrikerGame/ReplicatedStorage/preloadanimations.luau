 

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ContentProvider = game:GetService("ContentProvider");
local RunService = game:GetService("RunService");
local u1 = {};

for _, descendant in ipairs(ReplicatedStorage.Resources:GetDescendants()) do
    if descendant:IsA("Animation") then
        table.insert(u1, descendant);
    end;
end;

local u2 = {};
task.spawn(function() -- Line: 15
    -- upvalues: u1 (copy), u2 (ref), ContentProvider (copy), RunService (copy)
    for _, v in ipairs(u1) do
        table.insert(u2, v);

        if #u2 >= 10 then
            ContentProvider:PreloadAsync(u2);
            u2 = {};
            task.wait(0.1);
        end;
    end;

    if #u2 > 0 then
        print((`({RunService:IsClient() and "client" or "server"}) finish preload`));
        ContentProvider:PreloadAsync(u2);
    end;
end);

return u1;