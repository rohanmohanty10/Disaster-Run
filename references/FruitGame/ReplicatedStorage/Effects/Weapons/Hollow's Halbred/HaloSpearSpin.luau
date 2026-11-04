 

local v1 = {}
local u2 = game:GetService("TweenService")
local u3 = game:GetService("RunService")
require(game.ReplicatedStorage.Modules.CameraShaker)
local _ = script.Animations
local function u7(p4, p5) --[[ Line: 36 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    for _, v6 in p4:GetDescendants() do
        if v6:IsA("ParticleEmitter") then
            v6.Enabled = p5
        end
        if v6:IsA("PointLight") and not p5 then
            u2:Create(v6, TweenInfo.new(0.35), {
                ["Brightness"] = 0
            }):Play()
        end
    end
end
local function u34(p8) --[[ Line: 48 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    if _G.checkRenderDistance(p8.PrimaryPart.Position) ~= false then
        local u9 = -2.5
        local u10 = Random.new():NextNumber(10, 12.5)
        local u11 = Random.new():NextNumber(-360, 360)
        local u12 = p8:GetPivot()
        local u13 = script.TrailSpear:Clone()
        local v14 = CFrame.new
        local v15 = u11
        local v16 = math.rad(v15)
        local v17 = math.cos(v16) * u10
        local v18 = u9
        local v19 = u11
        local v20 = math.rad(v19)
        u13.CFrame = u12 * v14(v17, v18, math.sin(v20) * u10)
        u13.Parent = workspace.Effects
        local u21 = Random.new():NextNumber(0.35, 0.6)
        local u22 = tick()
        local u23 = nil
        u23 = u3.PreRender:Connect(function(p24) --[[ Line: 63 ]]
            --[[
            Upvalues:
                [1] = u22
                [2] = u21
                [3] = u23
                [4] = u13
                [5] = u9
                [6] = u11
                [7] = u10
                [8] = u12
            --]]
            if u21 <= tick() - u22 then
                u23:Disconnect()
                _G.destroy(u13)
            else
                u9 = u9 + 11 * p24
                u11 = u11 + 600 * p24
                u10 = u10 + 5 * p24
                local v25 = u13
                local v26 = u12
                local v27 = CFrame.new
                local v28 = u11
                local v29 = math.rad(v28)
                local v30 = math.cos(v29) * u10
                local v31 = u9
                local v32 = u11
                local v33 = math.rad(v32)
                v25.CFrame = v26 * v27(v30, v31, math.sin(v33) * u10)
            end
        end)
    end
end
function v1.start(_, p35, p36) --[[ Line: 79 ]]
    --[[
    Upvalues:
        [1] = u34
        [2] = u2
        [3] = u7
    --]]
    local _ = workspace.CurrentCamera
    local v37 = p35:GetPivot()
    local v38 = Random.new()
    local v39 = RaycastParams.new()
    local v40 = { workspace.Islands, workspace.Ships, workspace.Env }
    local v41 = Enum.RaycastFilterType.Include
    v39.FilterDescendantsInstances = v40
    v39.FilterType = v41
    tick()
    local v42 = script.Slashes:Clone()
    v42.CFrame = v37 * CFrame.new(0, 0.8, 0)
    v42.Parent = workspace.Effects
    _G.destroy(v42, 4)
    local v43 = Instance.new("WeldConstraint")
    local v44 = p35.PrimaryPart
    v43.Part0 = v42
    v43.Part1 = v44
    v43.Parent = v42
    local v45 = tick()
    local v46 = tick()
    while p36 ~= nil and p36:IsDescendantOf(game) do
        local v47 = workspace:Raycast(p35:GetPivot().Position, Vector3.new(0, -4, 0), v39)
        v42.Ground.DDetail.Enabled = v47 ~= nil
        v42.Ground.Dust.Enabled = v47 ~= nil
        if tick() - v46 >= 0.1 then
            v46 = tick()
            u34(p35)
        end
        if tick() - v45 > 0.15 then
            v45 = tick()
            local v48 = script.Primary:Clone()
            v48.CFrame = p35:GetPivot() * CFrame.new(0, -2, 0) * CFrame.Angles(0, v38:NextNumber(-3.141592653589793, 3.141592653589793), 0)
            v48.Parent = workspace.Effects
            u2:Create(v48, TweenInfo.new(0.65, Enum.EasingStyle.Cubic), {
                ["CFrame"] = v48.CFrame * CFrame.Angles(0, 3.141592653589793, 0)
            }):Play()
            u2:Create(v48.Mesh, TweenInfo.new(0.5), {
                ["Scale"] = v48.Mesh.Scale * v38:NextNumber(1.05, 1.1)
            }):Play()
            u2:Create(v48.Decal, TweenInfo.new(0.45), {
                ["Transparency"] = 1
            }):Play()
            local v49 = v48.Mesh
            v49.Scale = v49.Scale * 0.9
            local v50 = script.Secondary:Clone()
            v50.CFrame = p35:GetPivot() * CFrame.new(0, -2.5, 0) * CFrame.Angles(0, v38:NextNumber(-3.141592653589793, 3.141592653589793), 0)
            v50.Parent = workspace.Effects
            u2:Create(v50, TweenInfo.new(0.8, Enum.EasingStyle.Cubic), {
                ["CFrame"] = v50.CFrame * CFrame.Angles(0, 3.141592653589793, 0)
            }):Play()
            u2:Create(v50.Mesh, TweenInfo.new(0.6), {
                ["Scale"] = v50.Mesh.Scale * v38:NextNumber(1.125, 1.2)
            }):Play()
            u2:Create(v50.Decal, TweenInfo.new(0.65), {
                ["Transparency"] = 1
            }):Play()
            local v51 = v50.Mesh
            v51.Scale = v51.Scale * 0.9
            for v52 = 1, 2 do
                local v53 = script[v52 == 1 and "Wind" or "WindSlash"]:Clone()
                v53.CFrame = p35:GetPivot() * CFrame.new(0, -v38:NextNumber(1, 2.5), 0) * CFrame.Angles(0, v38:NextNumber(-3.141592653589793, 3.141592653589793), 0)
                v53.Parent = workspace.Effects
                u2:Create(v53, TweenInfo.new(0.8, Enum.EasingStyle.Cubic), {
                    ["CFrame"] = v53.CFrame * CFrame.Angles(0, 3.141592653589793, 0)
                }):Play()
                u2:Create(v53.Mesh, TweenInfo.new(0.6), {
                    ["Scale"] = v53.Mesh.Scale * v38:NextNumber(1.35, 1.5)
                }):Play()
                u2:Create(v53.Decal, TweenInfo.new(0.65), {
                    ["Transparency"] = 1
                }):Play()
                local v54 = v53.Mesh
                v54.Scale = v54.Scale * 0.575
            end
        end
        task.wait()
    end
    u7(v42, false)
end
return v1