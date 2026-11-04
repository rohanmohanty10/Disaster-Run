 

local v1 = {}
local u2 = require(game.ReplicatedStorage.Modules.Client.WeaponVFXRecolor)
function v1.start(_, p3) --[[ Line: 4 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v4 = p3.cf
    local v5 = p3.char
    if _G.checkRenderDistance(v4.Position) ~= false then
        local v6 = Ray.new(v4.Position, v4.UpVector * -20)
        local v7, v8, _ = _G.raycastWhitelist(v6, { workspace.Env, workspace.Ships, workspace.Islands })
        if v7 then
            local v9 = CFrame.new(v8)
            local v10 = v4 * CFrame.new(0, -v5.Humanoid.HipHeight / 2, -1)
            _G.PlayEffect("GroundRocks", nil, v10, math.random(15, 20), 4, 20, 2)
            local u11 = 15
            local u12 = v9.Position
            local v13 = script.dust:Clone()
            v13.Parent = workspace.Effects
            v13.CFrame = CFrame.new(u12)
            v13.Attachment.sm2.Color = ColorSequence.new(v7.Color)
            v13.Attachment.Rocks.Color = ColorSequence.new(v7.Color)
            v13.Attachment.sm2:Emit(40)
            v13.Attachment.Rocks:Emit(20)
            _G.destroy(v13, 3)
            local v14 = script.Part:Clone()
            u2.apply(v14, v5)
            v14.Parent = workspace.Effects
            v14.CFrame = v10 * CFrame.Angles(-1.5707963267948966, 0, 0)
            _G.tween(v14.PointLight, {
                0.25,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Range"] = 75,
                ["Brightness"] = 0
            })
            _G.destroy(v14, 0.5)
            _G.PlaySound(v5.Head, script.gauss_electro2)
            _G.PlaySound(v5.Head, script.downsmash)
            local v15 = script:FindFirstChild("ShockwaveColor")
            if v15 then
                v15 = script.ShockwaveColor:GetAttribute("UniqueID")
            end
            if v15 then
                v15 = u2.getColor(v5, v15)
            end
            local v16
            if v15 then
                v16 = BrickColor.new(v15)
            else
                v16 = BrickColor.new("Toothpaste")
            end
            local v17 = v15 or BrickColor.new("White").Color
            local u18 = script:FindFirstChild("LightningColor")
            if u18 then
                u18 = script.LightningColor:GetAttribute("UniqueID")
            end
            if u18 then
                u18 = u2.getColor(v5, u18)
            end
            _G.PlayEffect("Shockwave2", nil, v10 * CFrame.new(0, 50, 0), v10 * CFrame.new(0, 0, 0), v16, Vector3.new(55, 0, 55), Vector3.new(10, 2, 10), 0.2, 0, Enum.EasingStyle.Quad, v17, Enum.Material.Neon, "Rings")
            _G.PlayEffect("Shockwave2", nil, v10, v10, v16, Vector3.new(45, 0, 45), Vector3.new(10, 2, 10), 0.25, 0, Enum.EasingStyle.Quad, v17, Enum.Material.Neon, "Rings")
            for _ = 1, 10 do
                local v19 = BrickColor.new("Cyan").Color
                if math.random(1, 2) == 1 then
                    v19 = BrickColor.new("Baby blue").Color
                end
                local v20 = {
                    ["color"] = u18 or v19,
                    ["color2"] = u18 or BrickColor.new("Baby blue").Color,
                    ["ti"] = math.random(100, 400) / 1000,
                    ["decay"] = math.random(100, 200) / 1000,
                    ["bends"] = 2,
                    ["fork_bends"] = 1,
                    ["fork_chance"] = 0,
                    ["transparency"] = 0.5,
                    ["thickness"] = math.random(10, 75) / 200,
                    ["max_depth"] = 50
                }
                local v21 = _G.PlayEffect
                local v22 = math.random(-u11, u11)
                local v23 = math.random(20, 65)
                local v24 = math.random
                local v25 = -u11
                v21("Lightning", nil, u12, u12 + Vector3.new(v22, v23, v24(v25, u11)), v20)
                game["Run Service"].Heartbeat:Wait()
            end
            task.spawn(function() --[[ Line: 67 ]]
                --[[
                Upvalues:
                    [1] = u11
                    [2] = u18
                    [3] = u12
                --]]
                u11 = 35
                for _ = 1, 10 do
                    local v26 = BrickColor.new("Cyan").Color
                    if math.random(1, 2) == 1 then
                        v26 = BrickColor.new("Baby blue").Color
                    end
                    if u18 then
                        v26 = u18
                    end
                    local v27 = {
                        ["color"] = v26,
                        ["color2"] = u18 or BrickColor.new("Baby blue").Color,
                        ["ti"] = math.random(100, 200) / 1000,
                        ["decay"] = math.random(100, 200) / 1000,
                        ["bends"] = 2,
                        ["fork_bends"] = 1,
                        ["fork_chance"] = 0,
                        ["transparency"] = 0.5,
                        ["thickness"] = math.random(10, 75) / 200,
                        ["max_depth"] = 50
                    }
                    local v28 = math.random(-u11, u11)
                    local v29 = math.random(5, 10)
                    local v30 = math.random
                    local v31 = -u11
                    local v32 = u11
                    local v33 = Vector3.new(v28, v29, v30(v31, v32))
                    _G.PlayEffect("Lightning", nil, u12 + v33 / 2, u12 + v33, v27)
                end
            end)
        end
    end
end
return v1