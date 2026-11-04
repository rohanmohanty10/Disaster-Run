 

local v1 = {}
local u2 = {}
function v1.start(_, p3, p4, p5) --[[ Line: 3 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    if _G.checkRenderDistance(p3.HumanoidRootPart.Position) ~= false then
        local v6 = _G.awaitObject(p4)
        local v7 = 0
        while v6.Parent ~= nil and p3.Parent ~= nil do
            local v8 = script.Main:Clone()
            local v9 = Instance.new("Weld")
            v9.Part0 = p3.HumanoidRootPart
            local v10 = CFrame.new(0, math.random(-200, 200) / 100, -2)
            local v11 = CFrame.Angles
            local v12 = math.random(-45, 45)
            local v13 = math.rad(v12)
            local v14 = math.random(-90, 90)
            v9.C0 = v10 * v11(3.141592653589793, v13, (math.rad(v14)))
            v9.Parent = v8
            v8.CFrame = p3.HumanoidRootPart.CFrame
            v8.Mesh.Scale = Vector3.new(0, 0, 0)
            if p5 then
                v8.decal.Color3 = p5
            end
            v8.Parent = workspace.Effects
            local v15 = {
                ["C0"] = v9.C0 * CFrame.new(0, 0, math.random(2, 5))
            }
            _G.tween(v9, {
                0.1,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, v15)
            _G.tween(v8.decal, {
                0.1,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Transparency"] = 1
            })
            local v16 = math.random(7, 20)
            local v17 = _G.tween
            local v18 = v8.Mesh
            local v19 = {
                0.25,
                Enum.EasingStyle.Exponential,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }
            local v20 = {}
            local v21 = -v16
            v20.Scale = Vector3.new(v21, 0, v16)
            v17(v18, v19, v20)
            _G.destroy(v8, 0.25)
            _G.destroy(v9, 0.25)
            local v22 = u2
            table.insert(v22, { v9, v8 })
            local v23 = p3.HumanoidRootPart.CFrame
            local v24 = Ray.new(v23.Position, CFrame.new(v23.Position).upVector * -15)
            local v25, v26, _ = _G.raycastWhitelist(v24, { workspace.Islands, workspace.Ships })
            if v25 then
                local v27 = (v23.Position - v26).Magnitude
                v6.CFrame = v23 * CFrame.new(0, -v27, 0) * CFrame.Angles(3.141592653589793, 0, 0)
                local v28, v29, v30 = Color3.toHSV(v25.Color)
                local v31 = Color3.fromHSV(v28, v29, v30 - 0.1)
                v6.Attachment.sm2.Color = ColorSequence.new(v31)
                v6.Attachment.sm2.Enabled = true
            else
                v6.Attachment.sm2.Enabled = false
            end
            if tick() - v7 >= 0.1 then
                _G.PlaySound(p3.Head, script["r" .. math.random(1, 4)], {
                    ["Pitch"] = math.random(90, 100) / 100
                })
                v7 = tick()
            end
            game["Run Service"].Heartbeat:Wait()
            if v6.Parent == nil or (p3.Parent == nil or v6.Name == "done") then
                return
            end
        end
    end
end
game["Run Service"].RenderStepped:Connect(function() --[[ Line: 55 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    for v32 = 1, #u2 do
        if u2[v32] then
            local v33 = u2[v32]
            local v34, v35 = unpack(v33)
            if v34 == nil or (v35 == nil or (v34.Parent == nil or v35.Parent == nil)) then
                table.remove(u2, v32)
            else
                v35.CFrame = v34.Part0.CFrame * v34.C0
            end
        else
            table.remove(u2, v32)
        end
    end
end)
return v1