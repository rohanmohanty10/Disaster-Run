 

local u1 = script
game:GetService("ReplicatedStorage")
local u2 = game:GetService("RunService")
local _ = workspace.Effects
game:GetService("Debris")
local u3 = game:GetService("TweenService")
local u4 = {
    ["start"] = 0.3
}
local u5 = Random.new()
function trails(p6, u7, u8)
    --[[
    Upvalues:
        [1] = u5
        [2] = u1
        [3] = u2
        [4] = u3
    --]]
    task.wait(u5:NextNumber(0, 0.3))
    local u9 = u1.TrailPart:Clone()
    local v10 = u5:NextNumber(4, 5)
    local v11 = Vector3.new(v10, 0, 0)
    local v12 = u5:NextNumber(-3, 1)
    local v13 = Vector3.new(v12, 0, 0)
    local v14 = u9.Attachment1
    v14.Position = v14.Position + v11
    local v15 = u9.Attachment2
    v15.Position = v15.Position + v11
    u9.Trail.Color = p6
    u9.CFrame = u7
    local v16 = u5:NextNumber(0, 0.3)
    local u17 = 0
    local u18 = 0.7 + v16
    local u19 = u7 * CFrame.new(0, 2 + u5:NextNumber(0, 6), 0)
    local u20 = u5:NextNumber(0, 180)
    local u21 = nil
    u21 = u2.Heartbeat:Connect(function(p22) --[[ Line: 29 ]]
        --[[
        Upvalues:
            [1] = u17
            [2] = u3
            [3] = u18
            [4] = u9
            [5] = u7
            [6] = u19
            [7] = u20
            [8] = u8
            [9] = u21
        --]]
        u17 = u17 + p22
        local v23 = u3
        local v24 = u17 / u18
        local v25 = v23:GetValue(math.clamp(v24, 0, 1), Enum.EasingStyle.Circular, Enum.EasingDirection.Out)
        local v26 = u9
        local v27 = u7:Lerp(u19, v25)
        local v28 = CFrame.Angles
        local v29 = (200 + u20) * v25 * u8
        v26.CFrame = v27 * v28(0, math.rad(v29), 0)
        if u18 <= u17 then
            u21:Disconnect()
        end
    end)
    local v30 = { u18, "Circular", Enum.EasingDirection.Out }
    _G.tween(u9.Attachment1, v30, {
        ["Position"] = u9.Attachment1.Position + v13
    })
    _G.tween(u9.Attachment2, v30, {
        ["Position"] = u9.Attachment2.Position + v13
    })
    u9.Parent = workspace.Effects
    task.delay(0.1 + v16, function() --[[ Line: 41 ]]
        --[[
        Upvalues:
            [1] = u9
        --]]
        _G.tween(u9.Trail, { 0.4, "Sine", Enum.EasingDirection.Out }, {
            ["WidthScale"] = NumberSequence.new(0)
        })
    end)
    _G.destroy(u9, 2)
end
return {
    ["start"] = function(_, u31, u32, u33) --[[ Name: start, Line 49 ]]
        --[[
        Upvalues:
            [1] = u4
            [2] = u1
            [3] = u5
        --]]
        if _G.checkRenderDistance(u31.PrimaryPart.Position) ~= false then
            local u34 = u31.HumanoidRootPart
            task.delay(u4.start, function() --[[ Line: 55 ]]
                --[[
                Upvalues:
                    [1] = u34
                    [2] = u32
                    [3] = u1
                    [4] = u5
                    [5] = u31
                    [6] = u33
                --]]
                _G.PlaySound(u34, script.DragonBuffStart)
                for v35 = 1, 4 do
                    local v36 = v35 / 4 * 360
                    local u37 = u34.CFrame * CFrame.new(0, -3.5, 0) * CFrame.Angles(0, math.rad(v36), 0)
                    task.spawn(function() --[[ Line: 61 ]]
                        --[[
                        Upvalues:
                            [1] = u37
                        --]]
                        trails(ColorSequence.new(Color3.fromRGB(0, 0, 0)), u37, -1)
                    end)
                    task.spawn(function() --[[ Line: 64 ]]
                        --[[
                        Upvalues:
                            [1] = u32
                            [2] = u37
                        --]]
                        local v38 = u32 and Color3.fromRGB(255, 54, 28) or Color3.fromRGB(255, 255, 255)
                        trails(ColorSequence.new(v38), u37, 1)
                    end)
                end
                local v39 = u1.Particles:Clone()
                v39.Parent = workspace.Effects
                v39.CFrame = u34.CFrame * CFrame.new(0, -4, 0)
                local v40 = u1.Wind:Clone()
                if u32 == false then
                    v40.Decal.Color3 = Color3.fromRGB(500, 500, 500)
                end
                v40.Parent = workspace.Effects
                local v41 = u34.CFrame * CFrame.new(0, -1.5, 0)
                local v42 = CFrame.Angles
                local v43 = u5:NextNumber(0, 360)
                v40.CFrame = v41 * v42(0, math.rad(v43), 0)
                _G.tween(v40.Mesh, { 0.8, "Quart", Enum.EasingDirection.Out }, {
                    ["Scale"] = v40.Mesh.Scale * Vector3.new(2.5, 0.5, 2.5)
                })
                _G.tween(v40, { 0.8, "Quad", Enum.EasingDirection.Out }, {
                    ["CFrame"] = v40.CFrame * CFrame.new(0, -2, 0) * CFrame.Angles(0, 2.0943951023931953, 0)
                })
                _G.tween(v40.Decal, { 0.8, "Quad", Enum.EasingDirection.In }, {
                    ["Transparency"] = 1
                })
                _G.destroy(v40, 1)
                local v44 = u1.BlackWind:Clone()
                v44.Parent = workspace.Effects
                local v45 = u34.CFrame * CFrame.new(0, -2.5, 0)
                local v46 = CFrame.Angles
                local v47 = u5:NextNumber(0, 360)
                v44.CFrame = v45 * v46(0, math.rad(v47), 0)
                _G.tween(v44.Mesh, { 1, "Quart", Enum.EasingDirection.Out }, {
                    ["Scale"] = v44.Mesh.Scale * Vector3.new(1.5, 1, 1.5)
                })
                _G.tween(v44, { 1, "Quad", Enum.EasingDirection.Out }, {
                    ["CFrame"] = v44.CFrame * CFrame.new(0, -0.5, 0) * CFrame.Angles(0, -2.0943951023931953, 0)
                })
                _G.tween(v44.Decal, { 1, "Quad", Enum.EasingDirection.Out }, {
                    ["Transparency"] = 1
                })
                _G.destroy(v44, 1)
                local v48, v49
                if u32 then
                    v48 = u1.HandFire:Clone()
                    v49 = u1.HandFire:Clone()
                else
                    v48 = u1.Shockwave:Clone()
                    v49 = u1.Shockwave:Clone()
                end
                v48.Parent = u31.LeftHand
                v49.Parent = u31.RightHand
                v48:Emit(15)
                v49:Emit(15)
                if u32 == false then
                    v39.Spark.Color = ColorSequence.new(Color3.new(1, 1, 1))
                    v39.Attachment.Smoke.Color = ColorSequence.new(Color3.new(1, 1, 1))
                    v39.Attachment.Smoke.Transparency = NumberSequence.new(0.9, 1)
                end
                _G.customEmit(v39)
                task.wait(0.5)
                v39.Spark.Enabled = false
                v39.BlackSpark.Enabled = false
                task.wait(u33)
                v48.Enabled = false
                v49.Enabled = false
                _G.destroy(v49, 2)
                _G.destroy(v48, 2)
                _G.destroy(v39, 2)
            end)
        end
    end
}