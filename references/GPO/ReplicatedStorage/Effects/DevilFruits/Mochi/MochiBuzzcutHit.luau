 

return {
    ["start"] = function(_, p1, p2) --[[ Name: start, Line 3 ]]
        if _G.checkRenderDistance(p1.HumanoidRootPart.Position) then
            local v3 = script.Stabs:GetChildren()
            _G.PlaySound(p1.UpperTorso, v3[Random.new():NextInteger(1, #v3)])
            _G.PlaySound(p1.UpperTorso, script.Snap)
            local v4 = script.Part:Clone()
            v4.CFrame = p2.WorldCFrame
            v4.Parent = workspace.Effects
            _G.customEmit(v4.Spark)
            _G.destroy(v4, 1)
        end
    end
}