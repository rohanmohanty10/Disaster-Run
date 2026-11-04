 

local v1 = {}
local u2 = RaycastParams.new()
u2.FilterType = Enum.RaycastFilterType.Include
u2.FilterDescendantsInstances = { workspace.Env, workspace.Ships, workspace.Islands }
function v1.start(_, p3, p4, _) --[[ Line: 10 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    if typeof(p4) == "table" then
        local v5 = p4.isSmokeFruit
        local v6 = p4.floorCFrame
        local v7 = p4.pos
        local v8 = p4.nor
        local v9 = p4.color
        if v5 == true then
            local v10 = script.FloorHit:Clone()
            v10.CFrame = v6
            v10.Parent = workspace.Effects
            _G.customEmit(v10)
            _G.destroy(v10, 5)
        end
        local v11 = script.vfx:Clone()
        v11.CFrame = CFrame.new(v7, v7 + v8) * CFrame.Angles(-1.5707963267948966, 0, 0)
        _G.recolorParticles(v11, v9)
        v11.Parent = workspace.Effects
        _G.customEmit(v11)
        _G.destroy(v11, 5)
        _G.PlayEffect("GroundRocks4", nil, {
            ["Segments"] = 16,
            ["Position"] = v11.Position + Vector3.new(0, 5, 0),
            ["DistanceRandomness"] = Vector2.new(0.5, 1),
            ["Duration"] = 2,
            ["TweenDuration"] = 1,
            ["Radius"] = 10,
            ["Direction"] = Vector3.new(0, -10, 0)
        })
        _G.PlayEffect("RockDebris", nil, {
            ["PartCount"] = 4,
            ["RandomVelocityMagnitude"] = Vector2.new(-25, 25) / 2,
            ["Position"] = v11.Position + Vector3.new(0, 5, 0),
            ["Direction"] = Vector3.new(0, 75, 0),
            ["RaycastDirection"] = Vector3.new(0, -30, 0),
            ["Size"] = Vector3.new(0.5, 0.5, 0.5),
            ["TrailEnabled"] = true
        })
        _G.PlaySound(v6, script.JitteJumpSmash)
        return
    end
    if p4 == "trail" then
        local u12 = p3.PrimaryPart
        local u13 = {}
        for _ = 1, 4 do
            local v14 = script.JitteLaunch:Clone()
            v14.CFrame = p3.PrimaryPart.CFrame
            v14.Parent = workspace.Effects
            table.insert(u13, v14)
        end
        local u15 = 0
        local u16 = 0
        local u17 = false
        local function u28(_) --[[ Line: 83 ]]
            --[[
            Upvalues:
                [1] = u13
                [2] = u16
                [3] = u12
            --]]
            local v18 = 6.283185307179586 / #u13
            local v19 = 1 - u16 / 0.3
            local v20 = math.max(0, v19)
            for v21, v22 in ipairs(u13) do
                local v23 = (tick() * 7 + v21 * v18) % 6.283185307179586
                local v24 = v20 * 7
                local v25 = u12.Position.X + v24 * math.cos(v23)
                local v26 = u12.Position.Z + v24 * math.sin(v23)
                local v27 = u12.Position.Y
                v22.Position = Vector3.new(v25, v27, v26)
            end
        end
        local u29 = nil
        u29 = game:GetService("RunService").Heartbeat:Connect(function(p30) --[[ Line: 106 ]]
            --[[
            Upvalues:
                [1] = u17
                [2] = u15
                [3] = u28
                [4] = u16
                [5] = u13
                [6] = u29
            --]]
            if u17 then
                u16 = u16 + p30
                u28(p30)
                if u16 >= 0.3 then
                    for v31 = 1, #u13 do
                        _G.particleEnabled(u13[v31], false)
                        _G.destroy(u13[v31], 3)
                    end
                    u29:Disconnect()
                end
            else
                u15 = u15 + p30
                u28(p30)
                if u15 >= 0.25 then
                    u17 = true
                    return
                end
            end
        end)
        return
    end
    local v32 = p3.Humanoid.HipHeight + p3.PrimaryPart.Size.Y / 2 + 1
    local v33 = CFrame.new(0, 0, -5)
    while true do
        local v34 = p3.PrimaryPart.CFrame * v33
        local v35 = workspace:Blockcast(v34, p3.PrimaryPart.Size, v34.UpVector * -v32, u2)
        if v35 and v35.Instance or p3.Humanoid.FloorMaterial ~= Enum.Material.Air then
            if p4 then
                p4:FireServer(p3.PrimaryPart.CFrame * v33, p3.PrimaryPart.CFrame)
                return
            end
            break
        end
        task.wait()
        if p3:GetAttribute("JitteLeapHold") == nil then
            break
        end
    end
end
return v1