  

 

local function IsObjectInView(p1, p2, p3, p4) -- Line: 2
    if not p1 then
        return false;
    end;

    local CurrentCamera = workspace.CurrentCamera;
    local v5, v6 = CurrentCamera:WorldToViewportPoint(p1.Position);

    if v6 then
        v6 = v5.Z > 0;
    end;

    local v7;

    if p2 == "Sight" then
        v7 = false;
    else
        v7 = v6;
    end;

    if p2 == "Sight" and v6 then
        local v8 = CurrentCamera:ViewportPointToRay(v5.X, v5.Y, 0);
        local v9 = RaycastParams.new();
        v9.FilterType = Enum.RaycastFilterType.Exclude;
        v9.FilterDescendantsInstances = p4 or { p1, workspace.Living, workspace.Effects };
        local Magnitude = (p1.Position - CurrentCamera.CFrame.Position).Magnitude;

        if p3 <= Magnitude then
            return false;
        end;

        local v10 = workspace:Raycast(v8.Origin, v8.Direction * Magnitude, v9);
        v7 = not v10 and v6;

        if v6 and (not v7 and (v10 and (v10.Instance and v10.Instance:IsA("BasePart")))) then
            if v10.Instance.Transparency >= 0.2 or (v10.Instance.Material == Enum.Material.Glass or v10.Instance.Material == Enum.Material.ForceField) then
                return true;
            end;

            v7 = false;
        end;
    end;

    return v7;
end;

return function(p11, p12, p13, p14) -- Line: 31
    -- upvalues: IsObjectInView (copy)
    return IsObjectInView(p11, p12, p13, p14);
end;