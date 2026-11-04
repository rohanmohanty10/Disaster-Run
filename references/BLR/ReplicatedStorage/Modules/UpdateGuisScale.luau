  

local workspace_CurrentCamera = workspace.CurrentCamera;
local u1 = {};

local function Map() -- Line: 5
    -- upvalues: workspace_CurrentCamera (copy)
    local v2 = (math.min(workspace_CurrentCamera.ViewportSize.X, workspace_CurrentCamera.ViewportSize.Y) - 320) / 960 * 0.6 + 0.4;

    return math.clamp(v2, 0.4, 1);
end;

local function UpdateGuisScale() -- Line: 9
    -- upvalues: u1 (copy), workspace_CurrentCamera (copy)
    for _, v in ipairs(u1) do
        local v3 = (math.min(workspace_CurrentCamera.ViewportSize.X, workspace_CurrentCamera.ViewportSize.Y) - 320) / 960 * 0.6 + 0.4;
        v.Scale = math.clamp(v3, 0.4, 1) * 1;
    end;
end;

workspace_CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function() -- Line: 15
    -- upvalues: u1 (copy), workspace_CurrentCamera (copy)
    task.wait();

    for _, v in ipairs(u1) do
        local v4 = (math.min(workspace_CurrentCamera.ViewportSize.X, workspace_CurrentCamera.ViewportSize.Y) - 320) / 960 * 0.6 + 0.4;
        v.Scale = math.clamp(v4, 0.4, 1) * 1;
    end;
end);

return function(p5: userdata) -- Line: 20
    -- upvalues: u1 (copy), workspace_CurrentCamera (copy)
    table.insert(u1, p5);

    for _, v in ipairs(u1) do
        local v6 = (math.min(workspace_CurrentCamera.ViewportSize.X, workspace_CurrentCamera.ViewportSize.Y) - 320) / 960 * 0.6 + 0.4;
        v.Scale = math.clamp(v6, 0.4, 1) * 1;
    end;
end;