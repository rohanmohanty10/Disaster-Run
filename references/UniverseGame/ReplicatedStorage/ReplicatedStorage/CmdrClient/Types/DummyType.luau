  

 

local u1 = game:GetService("ReplicatedStorage")["Client Assets"];

local function GetDummyTypes() -- Line: 4
    -- upvalues: u1 (copy)
    local v2 = {};
    local Dummies = u1:WaitForChild("Dummies");

    if Dummies then
        for _, child in Dummies:GetChildren() do
            if child:IsA("Model") and child:FindFirstChildOfClass("Humanoid") then
                local Name = child.Name;

                if Name:sub(-6) == " Dummy" then
                    Name = Name:sub(1, -7);
                end;

                local v3 = Name:gsub("%s+", " "):gsub("[^%w%s]", ""):gsub("^%l", string.upper);
                table.insert(v2, v3);
            end;
        end;
    end;

    table.sort(v2);

    return v2;
end;

return function(p4) -- Line: 30
    -- upvalues: GetDummyTypes (copy)
    local v5 = GetDummyTypes();
    p4:RegisterType("dummytype", p4.Cmdr.Util.MakeEnumType("DummyType", v5));
end;