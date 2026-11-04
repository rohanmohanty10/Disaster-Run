 

local u1 = workspace.Effects
local u2 = require(script.Info)
local u3 = _G.tween
local function u7(p4, p5) --[[ Line: 9 ]]
    for _, v6 in p4:GetDescendants() do
        if v6:IsA("ParticleEmitter") then
            v6.Enabled = p5
        end
    end
end
local function u11(p8) --[[ Line: 17 ]]
    local v9 = p8:GetDescendants()
    for v10 = 1, #v9 do
        if v9[v10]:IsA("JointInstance") or (v9[v10]:IsA("BillboardGui") or v9[v10]:IsA("BaseScript")) then
            v9[v10]:Destroy()
        end
    end
end
return function(p12, p13) --[[ Line: 27 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u11
        [3] = u1
        [4] = u3
        [5] = u7
    --]]
    local v14 = {}
    for _, v15 in u2.Leg do
        local v16 = p12:FindFirstChild(v15)
        if v16 then
            local v17 = _G.bodyGetSection(p12, v16)
            for v18 = 1, #v17 do
                local v19 = v17[v18]
                local u20 = v19:Clone()
                u20:BreakJoints()
                u20.CFrame = v19.CFrame
                u20.Size = u20.Size * 1.02
                u20.CFrame = v19.CFrame
                u20.CanCollide = false
                u20.Anchored = false
                u20.Massless = true
                u11(u20)
                local v21 = Instance.new("Weld")
                v21.Part0 = u20
                v21.Part1 = v19
                v21.Parent = u20
                u20.Parent = workspace.Effects
                for _, v22 in script.Aura:GetChildren() do
                    if not v22:IsA("SurfaceAppearance") or u20:IsA("MeshPart") ~= false then
                        local v23 = v22:Clone()
                        v23.Parent = u20
                        table.insert(v14, v23)
                    end
                end
                table.insert(v14, u20)
                task.delay(p13, function() --[[ Line: 67 ]]
                    --[[
                    Upvalues:
                        [1] = u20
                    --]]
                    local v24 = u20.CFrame
                    local v25 = Random.new()
                    local v26 = _G.PlayEffect
                    local v27 = {
                        ["Position"] = v24.Position
                    }
                    local v28 = v25:NextNumber(-20, 20)
                    local v29 = v25:NextNumber(6, 15)
                    v27.Velocity = Vector3.new(v28, v29, v25:NextNumber(-20, 20))
                    v27.AngularVelocity = Random.new():NextUnitVector() * 3
                    local v30 = v25:NextNumber(0.5, 1)
                    v27.Size = Vector3.new(v30, 0.08, v25:NextNumber(0.5, 1))
                    v27.Duration = v25:NextInteger(2, 4)
                    v27.Color = Color3.fromRGB(239, 184, 56)
                    v27.Material = Enum.Material.Metal
                    v27.customModel = script.Parent.Parent.Gold_shatter:GetChildren()[math.random(1, #script.Parent.Parent.Gold_shatter:GetChildren())]
                    local v31 = v26("CreateRock", "skipThread", v27)
                    script.Aura.SurfaceAppearance:Clone().Parent = v31
                end)
            end
        end
    end
    _G.PlaySound(p12.PrimaryPart, script.GoldTrapHit, {
        ["RandomPitch"] = true
    })
    local v32 = p12.PrimaryPart.CFrame
    local _, v33, v34 = _G.getRayFloor(v32, 5)
    local v35 = v33 + Vector3.new(0, 0.1, 0)
    local v36 = CFrame.new(v35, v35 + v34) * CFrame.Angles(-1.5707963267948966, 0, 0)
    local v37 = script.FloorGold:Clone()
    v37.CFrame = v36
    v37.Parent = u1
    local v38 = script.main:Clone()
    v38.CFrame = v36 * CFrame.Angles(3.141592653589793, 0, 0)
    v38.Parent = u1
    _G.customEmit(v38)
    _G.destroy(v38, 5)
    local v39 = script.FootStepped:Clone()
    v39.CFrame = v36 * CFrame.new(0, 1, 0)
    v39.Parent = u1
    _G.customEmit(v39)
    _G.destroy(v39, 4)
    _G.destroy(v37, 5)
    task.wait(p13)
    _G.PlaySound(p12.PrimaryPart, script.GoldBreak, {
        ["RandomPitch"] = true
    })
    u3(v37, {
        0.5,
        Enum.EasingStyle.Quad,
        Enum.EasingDirection.In,
        0,
        false
    }, {
        ["Transparency"] = 1
    })
    u7(v37, false)
    u7(v38, false)
    _G.destroy(v38, false)
    for _, v40 in v14 do
        if v40:IsA("ParticleEmitter") then
            v40.Enabled = false
        elseif v40:IsA("BasePart") then
            v40:Destroy()
        end
    end
end