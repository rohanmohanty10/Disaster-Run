 

return {
    ["start"] = function(_, p1, p2) --[[ Name: start, Line 3 ]]
        if _G.checkRenderDistance(p1.PrimaryPart.Position) ~= false then
            local _, v3 = p1:GetBoundingBox()
            local v4 = script.FX:Clone()
            local v5 = v4.Bite
            v5.CFrame = p1.HumanoidRootPart.CFrame * CFrame.new(0, 0, -v3.Z / 2 - 2)
            local v6 = v4.Blood
            v6.CFrame = p2.HumanoidRootPart.CFrame
            v4.Parent = workspace.Effects
            _G.customEmit(v5)
            _G.customEmit(v6)
            _G.destroy(v4, 2)
        end
    end
}