 
 

game:GetService("CollectionService");
local RaycastParams_new = RaycastParams.new;
local workspace_Raycast = workspace.Raycast;
local _ = Ray.new;

return {
    Cast = function(p1, p2, p3, p4, p5, p6) -- Line: 9, Name: Cast
        -- upvalues: RaycastParams_new (copy), workspace_Raycast (copy)
        local Magnitude = p2.Magnitude;
        local v7 = Magnitude + 0.1;
        local v8 = 0;
        local v9 = p3 or {};
        local Unit = p2.Unit;
        local v10 = RaycastParams_new();
        v10.FilterType = Enum.RaycastFilterType.Exclude;
        v10.FilterDescendantsInstances = v9;
        v10.IgnoreWater = p4;
        local v11;

        if p6 then
            v10.CollisionGroup = p6;
            v11 = p1;
        else
            v11 = p1;
        end;

        local v12;

        while true do
            v12 = workspace_Raycast(workspace, p1, Unit * (v7 - v8), v10);

            if not v12 then
                break;
            end;

            local Instance = v12.Instance;
            p1 = v12.Position;

            if not Instance.CanQuery or p5 and Instance.Parent:FindFirstChildOfClass("Humanoid") or p5 and Instance.Parent.Parent:FindFirstChildOfClass("Humanoid") then
                v9[#v9 + 1] = Instance;
                v10.FilterDescendantsInstances = v9;
                v12 = nil;
            end;

            v8 = (v11 - p1).Magnitude;

            if Magnitude <= v8 or v12 then
                break;
            end;
        end;

        return v12;
    end,

    CastWithWhitelist = function(p13, p14, p15) -- Line: 47, Name: CastWithWhitelist
        -- upvalues: workspace_Raycast (copy)
        return workspace_Raycast(workspace, p13, p14, p15);
    end
};