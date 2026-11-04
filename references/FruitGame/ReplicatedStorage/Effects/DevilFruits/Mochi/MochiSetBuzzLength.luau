 

return {
    ["start"] = function(_, p1, p2, p3, p4) --[[ Name: start, Line 3 ]]
        if _G.checkRenderDistance(p1.PrimaryPart.Position) then
            local v5 = p1:FindFirstChild("mArm")
            local v6 = nil
            if v5 then
                v6 = v5.Value
            elseif p4 == nil then
                return
            end
            local v7 = p4 or v6.RootPart.MochiArmJoints
            if p3 <= 3 then
                _G.PlayEffect(script.Name, nil, p1, p2, p3 + 1, v7:FindFirstChildOfClass("Bone"))
                if p3 > 0 then
                    v7.CFrame = CFrame.new(v7:GetAttribute("OrigPos")) * CFrame.new(0, p2, 0)
                end
            end
        else
            return
        end
    end
}