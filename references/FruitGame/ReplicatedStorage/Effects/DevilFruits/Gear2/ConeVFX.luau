 

return {
    ["start"] = function(_, p1, p2, p3, p4, p5, p6, p7, p8, p9) --[[ Name: start, Line 3 ]]
        local v10 = p9 == nil and 0 or p9
        local function v15(p11, ...) --[[ Line: 7 ]]
            local v12, v13, v14 = ...
            return (p11 + v13) ^ v12 * v14
        end
        for v16 = 1, #p8 do
            local v17 = script.Cone:Clone()
            local v18 = v17.Mesh
            v18.Scale = v18.Scale * p5
            v17.CFrame = p1:Lerp(p2, p8[v16]) * CFrame.Angles(math.rad(p4), 0, 0)
            v17.Parent = workspace.Effects
            _G.tween(v17, p7, {
                ["CFrame"] = v17.CFrame * CFrame.new(0, p3, 0)
            })
            _G.tween(v17.Mesh, p7, {
                ["Scale"] = v17.Mesh.Scale * v15(p8[v16], unpack(p6))
            })
            _G.tween(v17.Decal, { p7[1], Enum.EasingStyle.Quart, Enum.EasingDirection.InOut }, {
                ["Transparency"] = 1
            })
            _G.destroy(v17, p7[1])
            task.wait(v10)
        end
    end
}