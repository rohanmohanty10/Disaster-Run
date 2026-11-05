 

 

return {
    WithinViewport = function(p1) --[[ Name: WithinViewport, Line 3 ]]
        local l__CurrentCamera__1 = workspace.CurrentCamera;
        local v2, v3;
        if p1:IsA("Model") then
            v2, v3 = p1:GetBoundingBox();
        else
            if not p1:IsA("BasePart") then
                warn("Object is neither a Model nor a BasePart! Disregarding Camera check!");
                return false;
            end;
            v2 = p1.CFrame;
            v3 = p1.Size;
        end;
        for v4 = 1, 8 do
            if l__CurrentCamera__1:WorldToViewportPoint((v2 * CFrame.new(v3.X * (v4 % 2 == 0 and 0.5 or -0.5), v3.Y * (v4 % 4 > 1 and 0.5 or -0.5), v3.Z * (v4 % 8 > 3 and 0.5 or -0.5))).Position) then
                return true;
            end;
        end;
        return false;
    end
};