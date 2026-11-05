 

 

local l__ReplicatedFirst__1 = game:GetService("ReplicatedFirst");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
local l__ServerScriptService__3 = game:GetService("ServerScriptService");
local l__ServerStorage__4 = game:GetService("ServerStorage");
local u1 = {
    script.Parent.Parent,
    l__ReplicatedFirst__1,
    l__ReplicatedStorage__2,
    l__ServerScriptService__3,
    l__ServerStorage__4
};
local function u6(p2, p3, p4) --[[ Line: 9 ]]
    for _, v5 in ipairs(p2:GetDescendants()) do
        if v5:IsA(p4) and v5.Name == p3 then
            return v5;
        end;
    end;
    return nil;
end;
return function() --[[ Name: GetPromiseLibrary, Line 19 ]]
    -- upvalues: u6 (copy), u1 (copy)
    local v7 = script:FindFirstAncestorOfClass("Plugin");
    if v7 then
        local v8 = u6(v7, "Promise", "ModuleScript");
        if v8 then
            return true, require(v8);
        else
            return false;
        end;
    else
        local v9 = nil;
        for _, v10 in ipairs(u1) do
            v9 = u6(v10, "Promise", "ModuleScript");
            if v9 then
                break;
            end;
        end;
        if v9 then
            return true, require(v9);
        else
            return false;
        end;
    end;
end;