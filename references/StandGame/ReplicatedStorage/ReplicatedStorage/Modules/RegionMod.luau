 

 

local u1 = {};
u1.mt = {
    __index = u1
};
game:GetService("ReplicatedStorage");
game:GetService("ServerStorage");
local _ = task.delay;
local _ = task.spawn;
local _ = task.wait;
function u1.new(p2, p3, ...) --[[ Line: 10 ]]
    -- upvalues: u1 (copy)
    return setmetatable({
        Size = p3,
        CFrame = p2,
        Args = ... or {}
    }, u1.mt);
end;
function u1.Destroy(p4) --[[ Line: 18 ]]
    setmetatable(p4, nil);
end;
function u1.Cast(p5, p6, p7) --[[ Line: 23 ]]
    local l__Args__1 = p5.Args;
    local l__CFrame__2 = p5.CFrame;
    local l__Size__3 = p5.Size;
    local v8 = {};
    local v9 = {};
    local v10 = not l__Args__1.GetMap;
    if v10 then
        v10 = workspace:FindFirstChild("Map");
    end;
    v9[1], v9[2], v9[3], v9[4], v9[5], v9[6], v9[7], v9[8] = p6, v10, workspace:FindFirstChild("IgnoredInstances"), workspace.CurrentCamera, workspace.Camera, workspace:FindFirstChild("Locations"), workspace:FindFirstChild("Mob_Spawns"), workspace:FindFirstChild("Mob_Spawns2");
    for _, v11 in pairs(v9) do
        if v11 and v11.Parent then
            table.insert(v8, v11);
        end;
    end;
    if l__Args__1.IgnoreList then
        for _, v12 in pairs(l__Args__1.IgnoreList) do
            if v12 and v12.Parent then
                table.insert(v8, v12);
            end;
        end;
    end;
    local v13 = OverlapParams.new();
    v13.MaxParts = p7 and p7 + 10 or 9999;
    v13.FilterType = l__Args__1.FilterType or Enum.RaycastFilterType.Exclude;
    v13.FilterDescendantsInstances = v8;
    p5:Destroy();
    return workspace:GetPartBoundsInBox(l__CFrame__2, l__Size__3, v13);
end;
return u1;