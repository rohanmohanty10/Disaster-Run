 

local v1 = {}
local u2 = game:GetService("TweenService")
game:GetService("ReplicatedStorage")
game:GetService("PhysicsService")
game:GetService("RunService")
local v3 = require(script.Parent.PartCache)
local u4
if workspace:FindFirstChild("Effects") then
    u4 = workspace.Effects
else
    u4 = Instance.new("Folder")
    u4.Name = "Effects"
    u4.Parent = workspace
end
local u5 = v3.new(Instance.new("Part"), 1000, u4)
function v1.Ground(u6, u7, p8, p9, u10, u11, p12) --[[ Line: 21 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u5
        [3] = u2
    --]]
    local u13 = Random.new()
    local u14 = 30
    local u15 = 360 / u10
    local u16 = RaycastParams.new()
    u16.FilterType = Enum.RaycastFilterType.Exclude
    u16.FilterDescendantsInstances = p9 or { game.Players.LocalPlayer.Character, u4 }
    local u17 = p8 or Vector3.new(2, 2, 2)
    local u18 = p12 or 3
    local function v30() --[[ Line: 34 ]]
        --[[
        Upvalues:
            [1] = u10
            [2] = u6
            [3] = u14
            [4] = u7
            [5] = u16
            [6] = u15
            [7] = u5
            [8] = u13
            [9] = u17
            [10] = u4
            [11] = u11
            [12] = u18
            [13] = u2
        --]]
        for _ = 1, u10 do
            local v19 = u14
            local v20 = CFrame.new(u6) * CFrame.fromEulerAnglesXYZ(0, math.rad(v19), 0) * CFrame.new(u7 / 2 + u7 / 2.7, 10, 0)
            local v21 = workspace:Raycast(v20.Position, Vector3.new(0, -50, 0), u16)
            u14 = u14 + u15
            if v21 then
                local u22 = u5:GetPart()
                local u23 = u5:GetPart()
                u22.CFrame = CFrame.new(v21.Position - Vector3.new(0, 0.5, 0), u6) * CFrame.fromEulerAnglesXYZ(u13:NextNumber(-0.25, 0.5), u13:NextNumber(-0.25, 0.25), u13:NextNumber(-0.25, 0.25))
                local v24 = u17.X * 1.3
                local v25 = u17.Y / 1.4
                local v26 = u17.Z * 1.3
                u22.Size = Vector3.new(v24, v25, v26) * u13:NextNumber(1, 1.5)
                local v27 = u22.Size.X * 1.01
                local v28 = u22.Size.Y * 0.25
                local v29 = u22.Size.Z * 1.01
                u23.Size = Vector3.new(v27, v28, v29)
                u23.CFrame = u22.CFrame * CFrame.new(0, u22.Size.Y / 2 - u23.Size.Y / 2.1, 0)
                u22.Parent = u4
                u23.Parent = u4
                if v21.Instance.Material == Enum.Material.Concrete or (v21.Instance.Material == Enum.Material.Air or (v21.Instance.Material == Enum.Material.Wood or (v21.Instance.Material == Enum.Material.Neon or v21.Instance.Material == Enum.Material.WoodPlanks))) then
                    u22.Material = v21.Instance.Material
                    u23.Material = v21.Instance.Material
                else
                    u22.Material = Enum.Material.Concrete
                    u23.Material = v21.Instance.Material
                end
                u22.BrickColor = BrickColor.new("Dark grey")
                u22.Anchored = true
                u22.CanTouch = false
                u22.CanCollide = false
                u23.BrickColor = v21.Instance.BrickColor
                u23.Anchored = true
                u23.CanTouch = false
                u23.CanCollide = false
                if u11 then
                    u22.BrickColor = BrickColor.new("Pastel light blue")
                    u23.BrickColor = BrickColor.new("Lily white")
                    u22.Material = Enum.Material.Ice
                    u23.Material = Enum.Material.Sand
                end
                task.delay(u18, function() --[[ Line: 78 ]]
                    --[[
                    Upvalues:
                        [1] = u2
                        [2] = u22
                        [3] = u23
                        [4] = u5
                    --]]
                    u2:Create(u22, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                        ["Size"] = Vector3.new(0.01, 0.01, 0.01)
                    }):Play()
                    u2:Create(u23, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                        ["Size"] = Vector3.new(0.01, 0.01, 0.01),
                        ["CFrame"] = u22.CFrame * CFrame.new(0, u22.Size.Y / 2 - u22.Size.Y / 2.1, 0)
                    }):Play()
                    task.delay(0.6, function() --[[ Line: 82 ]]
                        --[[
                        Upvalues:
                            [1] = u5
                            [2] = u22
                            [3] = u23
                        --]]
                        u5:ReturnPart(u22)
                        u5:ReturnPart(u23)
                    end)
                end)
            end
        end
    end
    (function() --[[ Name: InnerRocksLoop, Line 91 ]]
        --[[
        Upvalues:
            [1] = u10
            [2] = u6
            [3] = u14
            [4] = u7
            [5] = u16
            [6] = u15
            [7] = u5
            [8] = u17
            [9] = u13
            [10] = u4
            [11] = u11
            [12] = u18
            [13] = u2
        --]]
        for _ = 1, u10 do
            local v31 = u14
            local v32 = CFrame.new(u6) * CFrame.fromEulerAnglesXYZ(0, math.rad(v31), 0) * CFrame.new(u7 / 2 + u7 / 10, 10, 0)
            local v33 = game.Workspace:Raycast(v32.Position, Vector3.new(0, -20, 0), u16)
            u14 = u14 + u15
            if v33 then
                local u34 = u5:GetPart()
                local u35 = u5:GetPart()
                local v36 = CFrame.new
                local v37 = v33.Position
                local v38 = u17.Y * 0.4
                u34.CFrame = v36(v37 - Vector3.new(0, v38, 0), u6) * CFrame.fromEulerAnglesXYZ(u13:NextNumber(-1, -0.3), u13:NextNumber(-0.15, 0.15), u13:NextNumber(-0.15, 0.15))
                local v39 = u17.X * 1.3
                local v40 = u17.Y * 0.7
                local v41 = u17.Z * 1.3
                u34.Size = Vector3.new(v39, v40, v41) * u13:NextNumber(1, 1.5)
                local v42 = u34.Size.X * 1.01
                local v43 = u34.Size.Y * 0.25
                local v44 = u34.Size.Z * 1.01
                u35.Size = Vector3.new(v42, v43, v44)
                u35.CFrame = u34.CFrame * CFrame.new(0, u34.Size.Y / 2 - u35.Size.Y / 2.1, 0)
                u34.Parent = u4
                u35.Parent = u4
                if v33.Instance.Material == Enum.Material.Concrete or (v33.Instance.Material == Enum.Material.Air or (v33.Instance.Material == Enum.Material.Wood or (v33.Instance.Material == Enum.Material.Neon or v33.Instance.Material == Enum.Material.WoodPlanks))) then
                    u34.Material = v33.Instance.Material
                    u35.Material = v33.Instance.Material
                else
                    u34.Material = Enum.Material.Concrete
                    u35.Material = v33.Instance.Material
                end
                u34.BrickColor = BrickColor.new("Dark grey")
                u34.Anchored = true
                u34.CanTouch = false
                u34.CanCollide = false
                u35.BrickColor = v33.Instance.BrickColor
                u35.Anchored = true
                u35.CanTouch = false
                u35.CanCollide = false
                if u11 then
                    u34.BrickColor = BrickColor.new("Pastel light blue")
                    u35.BrickColor = BrickColor.new("Lily white")
                    u34.Material = Enum.Material.Ice
                    u35.Material = Enum.Material.Sand
                end
                task.delay(u18, function() --[[ Line: 135 ]]
                    --[[
                    Upvalues:
                        [1] = u2
                        [2] = u34
                        [3] = u35
                        [4] = u5
                    --]]
                    u2:Create(u34, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                        ["Size"] = Vector3.new(0.01, 0.01, 0.01)
                    }):Play()
                    u2:Create(u35, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                        ["Size"] = Vector3.new(0.01, 0.01, 0.01),
                        ["CFrame"] = u34.CFrame * CFrame.new(0, u34.Size.Y / 2 - u34.Size.Y / 2.1, 0)
                    }):Play()
                    task.delay(0.6, function() --[[ Line: 139 ]]
                        --[[
                        Upvalues:
                            [1] = u5
                            [2] = u34
                            [3] = u35
                        --]]
                        u5:ReturnPart(u34)
                        u5:ReturnPart(u35)
                    end)
                end)
            end
        end
    end)()
    v30()
end
return v1