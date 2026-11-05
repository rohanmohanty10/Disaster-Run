  

 

local v1;

if workspace:FindFirstChild("1v1Mode") then
    v1 = workspace.Map;
else
    v1 = workspace.Map;
end;

local u2 = {};

for _, child in pairs(v1:GetChildren()) do
    if child:FindFirstChild("Collisions") then
        table.insert(u2, child.Collisions);
    end;
end;

return function(p3, p4, p5) -- Line: 17
    -- upvalues: u2 (copy)
    local v6 = RaycastParams.new();
    v6.FilterDescendantsInstances = u2;
    v6.FilterType = Enum.RaycastFilterType.Whitelist;
    local v7 = workspace:Raycast(p3, p4, v6);

    if p5 then
        return v7;
    end;

    if v7 then
        return v7.Position;
    end;

    return p3;
end;