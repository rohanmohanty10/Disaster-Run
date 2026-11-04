 

return {
    ["WithinViewport"] = function(p1) --[[ Name: WithinViewport, Line 3 ]]
        local v2 = workspace.CurrentCamera
        local v3, v4
        if p1:IsA("Model") then
            v3, v4 = p1:GetBoundingBox()
        else
            if not p1:IsA("BasePart") then
                warn("Object is neither a Model nor a BasePart! Disregarding Camera check!")
                return false
            end
            v3 = p1.CFrame
            v4 = p1.Size
        end
        for v5 = 1, 8 do
            if v2:WorldToViewportPoint((v3 * CFrame.new(v4.X * (v5 % 2 == 0 and 0.5 or -0.5), v4.Y * (v5 % 4 > 1 and 0.5 or -0.5), v4.Z * (v5 % 8 > 3 and 0.5 or -0.5))).Position) then
                return true
            end
        end
        return false
    end
}