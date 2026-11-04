 

local v1 = {}
local u2 = {}
require(game.ReplicatedStorage.Modules.BindToRender)
_G.getEffect("Shockwave2")
function v1.start(_, p3, p4) --[[ Line: 7 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    if _G.checkRenderDistance(p3.Position) ~= false then
        p3.Attachment.BurningPart2.Enabled = true
        local v5 = u2
        table.insert(v5, { p3, p4 })
    end
end
game["Run Service"].Heartbeat:Connect(function() --[[ Name: renderFunction, Line 15 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    for v6 = 1, #u2 do
        if u2[v6] == nil then
            return
        end
        local v7 = u2[v6]
        local v8, v9 = unpack(v7)
        if v8 == nil or (not v8:IsDescendantOf(game) or (not v8.Parent or (v8.Attachment.BurningPart2.Enabled ~= true or (v8.Position - workspace.CurrentCamera.CFrame.Position).Magnitude >= 1000))) then
            table.clear(u2[v6])
            table.remove(u2, v6)
        else
            if _G.fastmodee == true and math.random(1, 2) == 1 then
                return
            end
            local v10 = v8.Size.X * 3
            local v11 = Instance.new("Attachment")
            v11.Parent = v8
            local v12 = v11:Clone()
            v12.Parent = v8
            local v13 = script.Beam:Clone()
            if v9 then
                v13.Color = ColorSequence.new(v9)
            end
            v13.Parent = v8
            local v14 = v8.CFrame.Position
            local v15 = math.random(-v10, v10)
            local v16 = math.random(-v10, v10)
            local v17 = math.random
            local v18 = -v10
            local v19 = v14 + Vector3.new(v15, v16, v17(v18, v10))
            v13.Width0 = math.random(v8.Size.X * 2, v8.Size.X * 4)
            v13.Attachment0 = v11
            v13.Attachment1 = v12
            _G.tween(v12, {
                0.25,
                Enum.EasingStyle.Exponential,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["WorldPosition"] = v19
            })
            _G.tween(v13, {
                0.25,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Width0"] = 0,
                ["Width1"] = 0
            })
            _G.destroy(v13, 0.25)
            local v20 = v8.Size.X
            v8.Attachment.BurningPart2.Speed = NumberRange.new(v20 * 4, v20 * 8)
            v8.Attachment.BurningPart2.Size = NumberSequence.new(v20, 0)
            v8.Attachment.Spark.Size = v8.Attachment.BurningPart2.Size
            v8.Attachment.Spark.Speed = v8.Attachment.BurningPart2.Speed
            v8.Attachment.Ring.Size = NumberSequence.new(0, v20 * 4)
            v8.Attachment2.sm2.Speed = NumberRange.new(v20 * 4, v20 * 6)
            v8.Attachment2.Rocks.Speed = v8.Attachment2.sm2.Speed
            v8.Attachment2.sm2.Size = NumberSequence.new(0, v20 / 1.5)
            v8.Attachment2.sm2:Emit(5)
            v8.Attachment2.Rocks:Emit(2)
            local v21 = Ray.new(v8.Position, CFrame.new(v8.Position).upVector * -v8.Size.Y)
            local v22, v23 = _G.raycastWhitelist(v21, { workspace.Islands })
            if v22 then
                v8.Attachment2.WorldCFrame = CFrame.new(v23)
                v8.Attachment2.Rocks.Transparency = NumberSequence.new(0)
                v8.Attachment2.sm2.Enabled = true
                v8.Attachment2.sm2.Transparency = NumberSequence.new(0.5, 1)
                v8.Attachment2.sm2.Color = ColorSequence.new(v22.Color)
                v8.Attachment2.Rocks.Color = ColorSequence.new(v22.Color)
            else
                v8.Attachment2.sm2.Enabled = false
                v8.Attachment2.Rocks.Enabled = false
                v8.Attachment2.Rocks.Transparency = NumberSequence.new(1)
                v8.Attachment2.sm2.Transparency = NumberSequence.new(1)
            end
        end
    end
end)
return v1