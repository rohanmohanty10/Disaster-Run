  

 

local u1 = {};

for _, descendant in script:GetDescendants() do
    if descendant:IsA("ModuleScript") then
        if u1[descendant.Name] then
            warn((`two mesh modules are called {descendant.Name}`));
        end;

        u1[descendant.Name] = {
            Instance = descendant,
            Data = require(descendant)
        };
    end;
end;

return function(p2) -- Line: 18
    -- upvalues: u1 (copy)
    local v3 = p2 or {};
    local v4 = v3.Type or error("no type");
    local u5 = v3.Origin or error("no origin");
    local v6 = u1[v4] or error((`{v3.Type} is not a registered mesh module`));

    for _, child in v6.Instance:GetChildren() do
        local u7 = v6.Data[child.Name];

        if u7 then
            task.spawn(function() -- Line: 34
                -- upvalues: child (copy), u5 (copy), u7 (copy)
                local v8 = child:Clone();
                v8.CFrame = u5 * child.CFrame;
                v8.Parent = workspace.Terrain;
                u7(v8);
            end);
        else
            print("nah");
        end;
    end;
end;