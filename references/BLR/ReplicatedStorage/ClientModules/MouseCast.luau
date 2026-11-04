  

local UserInputService = game:GetService("UserInputService");
local workspace_CurrentCamera = workspace.CurrentCamera;
local WireframeHandleAdornment = Instance.new("WireframeHandleAdornment");
WireframeHandleAdornment.Adornee = workspace.Terrain;
WireframeHandleAdornment.Thickness = 10;
WireframeHandleAdornment.Color3 = Color3.fromRGB(255, 0, 0);
WireframeHandleAdornment.Parent = workspace.Terrain;
local v1 = {};

local function RaycastAt(p2, p3: userdata) -- Line: 12
    -- upvalues: workspace_CurrentCamera (copy)
    local v4 = workspace_CurrentCamera:ViewportPointToRay(p2.X, p2.Y);

    return workspace:Raycast(v4.Origin, v4.Direction * 500, p3);
end;

local function Raycast(p5: userdata) -- Line: 17
    -- upvalues: UserInputService (copy), workspace_CurrentCamera (copy)
    local MouseLocation = UserInputService:GetMouseLocation();
    local v6 = workspace_CurrentCamera:ViewportPointToRay(MouseLocation.X, MouseLocation.y);

    return workspace:Raycast(v6.Origin, v6.Direction * 500, p5);
end;

function v1.WithParams(p7: table, p8: userdata) -- Line: 24
    -- upvalues: Raycast (copy)
    return Raycast(p8);
end;

function v1.WithParamsCenter(p9: table, p10: userdata) -- Line: 28
    -- upvalues: RaycastAt (copy), workspace_CurrentCamera (copy)
    return RaycastAt(workspace_CurrentCamera.ViewportSize / 2, p10);
end;

local RaycastParams_new_ret = RaycastParams.new();
RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;

function v1.Exclude(p11: table, p12: table) -- Line: 36
    -- upvalues: RaycastParams_new_ret (copy), Raycast (copy)
    RaycastParams_new_ret.FilterDescendantsInstances = p12;

    return Raycast(RaycastParams_new_ret);
end;

function v1.WithPositionExclude(p13: table, p14, p15: table) -- Line: 41
    -- upvalues: RaycastParams_new_ret (copy), RaycastAt (copy)
    RaycastParams_new_ret.FilterDescendantsInstances = p15;

    return RaycastAt(p14, RaycastParams_new_ret);
end;

local RaycastParams_new_ret2 = RaycastParams.new();
RaycastParams_new_ret2.FilterType = Enum.RaycastFilterType.Include;

function v1.Include(p16: table, p17: table) -- Line: 50
    -- upvalues: RaycastParams_new_ret2 (copy), Raycast (copy)
    RaycastParams_new_ret2.FilterDescendantsInstances = p17;

    return Raycast(RaycastParams_new_ret2);
end;

function v1.WithPositionInclude(p18: table, p19, p20: table) -- Line: 55
    -- upvalues: RaycastParams_new_ret2 (copy), RaycastAt (copy)
    RaycastParams_new_ret2.FilterDescendantsInstances = p20;

    return RaycastAt(p19, RaycastParams_new_ret2);
end;

return v1;