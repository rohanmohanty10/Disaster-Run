 

return {
    ["start"] = function(_, p1, p2) --[[ Name: start, Line 3 ]]
        if _G.checkRenderDistance(p1.Position) ~= false then
            local v3 = script.blood.Attachment:Clone()
            v3.WorldCFrame = CFrame.new(p1.Position)
            v3.Parent = workspace.Terrain
            _G.customEmit(v3)
            _G.destroy(v3, 5)
            _G.PlayEffect("Spheres", nil, {
                ["cf"] = p1.CFrame,
                ["ti"] = 0.25,
                ["ti2"] = 0.25,
                ["range"] = 5,
                ["minThick"] = 0.2,
                ["maxThick"] = 3,
                ["part"] = p1,
                ["color"] = Color3.fromRGB(255, 89, 89),
                ["am"] = 10
            })
            if p2 and p2 == "gravityBlade" then
                local v4 = script.gravityBlade.Hit:Clone()
                v4.WorldCFrame = p1.CFrame
                v4.Parent = workspace.Terrain
                _G.customEmit(v4)
                _G.destroy(v4, 5)
            end
        end
    end
}