 

 

local GoatSdk = script:WaitForChild("GoatSdk", 10);

if not (GoatSdk and GoatSdk:IsA("ObjectValue")) then
    warn("[GA] Client bootstrap is missing its SDK reference.");

    return;
end;

local v1 = os.clock() + 60;

while not GoatSdk.Value and os.clock() < v1 do
    task.wait(0.1);
end;

local Value = GoatSdk.Value;

if not (Value and Value:IsA("ModuleScript")) then
    warn("[GA] Client bootstrap could not resolve its SDK module.");

    return;
end;

local success, result = pcall(require, Value);

if not success then
    warn("[GA] Client bootstrap failed: " .. tostring(result));
end;