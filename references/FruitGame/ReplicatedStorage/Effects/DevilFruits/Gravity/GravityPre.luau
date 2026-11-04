 

local v1 = {}
game:GetService("RunService")
function v1.start(_, p2, _) --[[ Line: 6 ]]
    if p2 then
        if _G.checkRenderDistance(p2.Position) == false then
            return
        else
            local v3 = tick()
            local v4 = p2.Transparency
            local v5 = 0
            while true do
                local v6 = p2.Size.X / 2
                local v7 = v6 / 4 * (math.random(100, 150) / 100)
                local v8 = math.clamp(v7, 0, 35)
                local v9 = v8 / 10
                for _ = 1, 4 do
                    local v10 = math.random(100, 200) / 1000
                    local v11 = script.sph:Clone()
                    local v12 = v11.Mesh
                    local v13 = v8 / 2
                    v12.Offset = Vector3.new(0, v13, 0)
                    v11.Mesh.Scale = Vector3.new(v9, v8, v9)
                    local v14 = CFrame.new
                    local v15 = CFrame.new(p2.CFrame.Position)
                    local v16 = CFrame.Angles
                    local v17 = math.random(-360, 360)
                    local v18 = v14((v15 * v16(0, math.rad(v17), 0) * CFrame.new(math.random(-v6, v6), v8 / 2, 0)).Position)
                    local v19 = Ray.new(v18.Position, v18.UpVector * -(v8 * 2))
                    local _, v20, _ = _G.raycastWhitelist(v19, { workspace.Islands, workspace.Ships, workspace.Env })
                    v11.CFrame = CFrame.new(v20)
                    if math.random(1, 2) == 1 then
                        v11.Color = Color3.fromRGB(0, 0, 0)
                    end
                    v11.Parent = workspace.Effects
                    local v21 = _G.tween
                    local v22 = v11.Mesh
                    local v23 = {
                        ["Scale"] = Vector3.new(0, 0, 0)
                    }
                    local v24 = -v8 / 2.5
                    v23.Offset = Vector3.new(0, v24, 0)
                    v21(v22, {
                        v10,
                        "Quad",
                        "Out",
                        0,
                        false,
                        0
                    }, v23)
                    _G.destroy(v11, v10)
                end
                if tick() - v5 >= 0.25 then
                    local v25 = script.sph:Clone()
                    v25.CFrame = p2.CFrame
                    local v26 = p2.Size.X
                    local v27 = p2.Size.X
                    local v28 = p2.Size.X
                    local v29 = Vector3.new(v26, v27, v28)
                    v25.Mesh.Scale = v29 / 2
                    v25.Transparency = 0.8
                    v25.Material = Enum.Material.Neon
                    v25.Parent = workspace.Effects
                    _G.tween(v25.Mesh, {
                        0.25,
                        "Quad",
                        "Out",
                        0,
                        false,
                        0
                    }, {
                        ["Scale"] = v29
                    })
                    _G.tween(v25, {
                        0.25,
                        "Quad",
                        "Out",
                        0,
                        false,
                        0
                    }, {
                        ["Transparency"] = 1
                    })
                    _G.destroy(v25, 0.25)
                    v5 = tick()
                end
                game["Run Service"].Heartbeat:Wait()
                if tick() - v3 >= 3 or (p2.Parent == nil or p2.Transparency ~= v4) then
                    return
                end
            end
        end
    else
        return
    end
end
return v1