 

local v1 = {}
local u2 = game:GetService("TweenService")
local u3 = game:GetService("RunService")
local _ = workspace.CurrentCamera
local _ = script.Animations
require(game.ReplicatedStorage.Modules.CameraShaker)
local function u6(p4) --[[ Line: 10 ]]
    for _, u5 in p4:GetDescendants() do
        if u5:IsA("ParticleEmitter") then
            if u5:GetAttribute("EmitDelay") then
                task.delay(u5:GetAttribute("EmitDelay"), function() --[[ Line: 14 ]]
                    --[[
                    Upvalues:
                        [1] = u5
                    --]]
                    _G.customEmit(u5)
                end)
            else
                _G.customEmit(u5)
            end
        end
    end
end
local function u10(p7, p8) --[[ Line: 37 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    for _, v9 in p7:GetDescendants() do
        if v9:IsA("ParticleEmitter") then
            v9.Enabled = p8
        end
        if v9:IsA("PointLight") and not p8 then
            u2:Create(v9, TweenInfo.new(0.35), {
                ["Brightness"] = 0
            }):Play()
        end
    end
end
local u11 = RaycastParams.new()
local v12 = { workspace.Islands, workspace.Env, workspace.Ships }
local v13 = Enum.RaycastFilterType.Include
u11.FilterDescendantsInstances = v12
u11.FilterType = v13
function v1.start(_, u14, p15) --[[ Line: 83 ]]
    --[[
    Upvalues:
        [1] = u6
        [2] = u2
        [3] = u11
        [4] = u3
        [5] = u10
    --]]
    local u16 = Random.new()
    if typeof(u14) == "CFrame" then
        if _G.checkRenderDistance(u14.Position) ~= false then
            local u17 = script.WallHitModel:Clone()
            u17:PivotTo(u14)
            u17.Parent = workspace.Effects
            u6(u17)
            if (workspace.CurrentCamera.CFrame.Position - u14.Position).Magnitude <= 50 then
                local v18 = Instance.new("ColorCorrectionEffect")
                v18.Parent = workspace.CurrentCamera
                v18.Contrast = 100
                v18.Saturation = -1
                _G.destroy(v18, 0.1)
            end
            u2:Create(u17.Main.Attachment.PointLight, TweenInfo.new(u16:NextNumber(0.6, 0.8)), {
                ["Brightness"] = 0
            }):Play()
            for _, v19 in u17:GetDescendants() do
                if v19.Name == "GroundRocks" and v19:IsA("BasePart") then
                    if workspace:Raycast(v19.Position, u14.LookVector * -4, u11) then
                        local v20 = p15.Material
                        local v21 = p15.Color
                        v19.Material = v20
                        v19.Color = v21
                    else
                        v19:Destroy()
                    end
                end
            end
            task.delay(2.5, function() --[[ Line: 115 ]]
                --[[
                Upvalues:
                    [1] = u17
                    [2] = u2
                    [3] = u16
                --]]
                for _, v22 in u17:GetDescendants() do
                    if v22.Name == "GroundRocks" and v22:IsA("BasePart") then
                        u2:Create(v22, TweenInfo.new(u16:NextNumber(0.5, 0.65)), {
                            ["Size"] = Vector3.new(0, 0, 0)
                        }):Play()
                    elseif v22:IsA("Decal") then
                        u2:Create(v22, TweenInfo.new(u16:NextNumber(0.6, 0.8)), {
                            ["Transparency"] = 1
                        }):Play()
                    end
                end
            end)
        end
    elseif _G.checkRenderDistance(u14.PrimaryPart.Position) ~= false then
        u14:GetPivot()
        local u23 = script.Dash:Clone()
        local v24 = u14:GetPivot() * CFrame.new(0, 0, -1)
        local v25 = workspace.Effects
        u23.CFrame = v24
        u23.Parent = v25
        local u26 = Instance.new("WeldConstraint")
        local v27 = u14.PrimaryPart
        u26.Parent = u23
        u26.Part0 = u23
        u26.Part1 = v27
        local u28 = script.Ground:Clone()
        local v29 = u14:GetPivot() * CFrame.new(0, -2.5, -1)
        local v30 = workspace.Effects
        u28.CFrame = v29
        u28.Parent = v30
        local u31 = Instance.new("WeldConstraint")
        local v32 = u14.PrimaryPart
        u31.Parent = u28
        u31.Part0 = u28
        u31.Part1 = v32
        local u33 = {}
        local u34 = true
        for v35 = 0, 3 do
            local u36 = v35 * 90
            local u37 = 6.5
            local u38 = u14:GetPivot() * CFrame.new(0, 0, 6)
            local u39 = script.TrailSpear:Clone()
            local v40 = CFrame.new
            local v41 = u36
            local v42 = math.rad(v41)
            local v43 = math.cos(v42) * u37
            local v44 = u36
            local v45 = math.rad(v44)
            u39.CFrame = u38 * v40(v43, math.sin(v45) * u37, 0)
            u39.Parent = workspace.Effects
            table.insert(u33, u39)
            local v46 = u3.PreRender
            local function v57(p47) --[[ Line: 186 ]]
                --[[
                Upvalues:
                    [1] = u34
                    [2] = u37
                    [3] = u38
                    [4] = u14
                    [5] = u36
                    [6] = u39
                --]]
                if u34 then
                    u38 = u14:GetPivot() * CFrame.new(0, 0, 6)
                else
                    local v48 = u37 - p47 * 20
                    u37 = math.clamp(v48, 0, (1 / 0))
                    u38 = u38 * CFrame.new(0, 0, -p47 * 45)
                end
                u36 = u36 + 600 * p47
                local v49 = u39
                local v50 = u38
                local v51 = CFrame.new
                local v52 = u36
                local v53 = math.rad(v52)
                local v54 = math.cos(v53) * u37
                local v55 = u36
                local v56 = math.rad(v55)
                v49.CFrame = v50 * v51(v54, math.sin(v56) * u37, 0)
            end
            table.insert(u33, v46:Connect(v57))
        end
        local function v59() --[[ Line: 201 ]]
            --[[
            Upvalues:
                [1] = u34
                [2] = u26
                [3] = u31
                [4] = u23
                [5] = u28
                [6] = u10
                [7] = u33
            --]]
            if u34 then
                u34 = false
                u26:Destroy()
                u31:Destroy()
                u23.Anchored = true
                u28.Anchored = true
                u10(u23, false)
                u10(u28, false)
                _G.destroy(u23, 1.5)
                _G.destroy(u28, 2)
                task.delay(0.325, function() --[[ Line: 230 ]]
                    --[[
                    Upvalues:
                        [1] = u33
                    --]]
                    for _, v58 in u33 do
                        if typeof(v58) == "RBXScriptConnection" then
                            v58:Disconnect()
                        else
                            _G.destroy(v58, 1)
                        end
                    end
                    u33 = nil
                end)
            end
        end
        local v60 = tick()
        while u14:GetAttribute("spearRushing") ~= nil and u14:IsDescendantOf(workspace) == true do
            local v61 = u16:NextNumber(5, 7)
            for v62 = -1, 1, 2 do
                local v63 = CFrame.new(v62 * v61, 0, -1.75)
                local v64 = u14:GetPivot() * CFrame.new(0, 0, -1.75)
                local v65 = workspace:Raycast((u14:GetPivot() * v63).Position, Vector3.new(0, -4, 0), u11)
                if v65 then
                    local v66 = u16:NextNumber(-3.141592653589793, 3.141592653589793) / 9
                    local v67 = u16:NextNumber(-3.141592653589793, 3.141592653589793) / 9
                    local v68 = CFrame.new(v65.Position - Vector3.new(0, 0.5, 0), v64.Position - Vector3.new(0, 6, 0)) * CFrame.Angles(0, v66, v67)
                    local u69 = script.Rocks["RockModel" .. u16:NextInteger(1, 2)]:Clone()
                    u69:PivotTo(v68)
                    u69.Parent = workspace.Effects
                    local v70 = u69.Land
                    local v71 = u69.Land
                    local v72 = v65.Material
                    local v73 = v65.Instance.Color
                    v70.Material = v72
                    v71.Color = v73
                    task.delay(1.5, function() --[[ Line: 263 ]]
                        --[[
                        Upvalues:
                            [1] = u2
                            [2] = u69
                        --]]
                        u2:Create(u69.Rock, TweenInfo.new(0.45), {
                            ["Size"] = Vector3.new(0, 0, 0)
                        }):Play()
                        local v74 = u2
                        local v75 = u69.Land
                        local v76 = TweenInfo.new(0.45)
                        local v77 = {
                            ["Size"] = Vector3.new(0, 0, 0)
                        }
                        local v78 = u69.Land.Position
                        local v79 = u69.Rock.Size.Y / 2
                        v77.Position = v78 - Vector3.new(0, v79, 0)
                        v74:Create(v75, v76, v77):Play()
                    end)
                end
            end
            if tick() - v60 >= 0.06666666666666667 then
                v60 = tick()
                local v80 = script.DashWaves:Clone()
                v80:PivotTo(u14:GetPivot() * CFrame.new(0, 0, -3.25) * CFrame.Angles(0, 0, u16:NextNumber(-3.141592653589793, 3.141592653589793)))
                v80.Parent = workspace.Effects
                local v81 = {
                    ["DetailWave"] = 0.375,
                    ["FlashWave"] = 0.3
                }
                for _, v82 in v80:GetChildren() do
                    if v82.Name == "Main" or not v81[v82.Name] then
                        if v82.Name == "FrontSpark" then
                            u2:Create(v82, TweenInfo.new(u16:NextNumber(0.3, 0.4)), {
                                ["CFrame"] = v82.CFrame * CFrame.new(2, 0, 0)
                            }):Play()
                            u2:Create(v82.Mesh, TweenInfo.new(u16:NextNumber(0.25, 0.35)), {
                                ["Scale"] = Vector3.new(0.6, 0, 0)
                            }):Play()
                        end
                    else
                        u2:Create(v82.Mesh, TweenInfo.new(v81[v82.Name] * 1.15), {
                            ["Scale"] = v82.Mesh.Scale * 1.75
                        }):Play()
                        u2:Create(v82.Decal, TweenInfo.new(v81[v82.Name]), {
                            ["Transparency"] = 1
                        }):Play()
                    end
                end
                _G.destroy(v80, 1)
            end
            local v83 = workspace:Raycast((u14:GetPivot() * CFrame.new(0, 0, -1)).Position, Vector3.new(0, -4, 0), u11)
            u28.Dust.Enabled = v83 ~= nil
            u28.Rocks.Enabled = v83 ~= nil
            local v84 = script["WindMesh" .. u16:NextInteger(1, 2)]:Clone()
            v84.CFrame = u14:GetPivot() * CFrame.new(0, 0, -2.5) * CFrame.Angles(1.5707963267948966, u16:NextNumber(-3.141592653589793, 3.141592653589793), 0)
            v84.Parent = workspace.Effects
            local v85 = TweenInfo.new(0.325, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            u2:Create(v84, v85, {
                ["CFrame"] = v84.CFrame * CFrame.Angles(0, 3.141592653589793, 0),
                ["Size"] = v84.Size * u16:NextNumber(1, 1.35),
                ["Transparency"] = 1
            }):Play()
            v84.Size = v84.Size * 0.1
            local v86 = script.WindMesh3:Clone()
            v86.CFrame = u14:GetPivot() * CFrame.new(0, 0, -3) * CFrame.Angles(1.5707963267948966, u16:NextNumber(-3.141592653589793, 3.141592653589793), 0)
            v86.Parent = workspace.Effects
            u2:Create(v86, v85, {
                ["CFrame"] = v86.CFrame * CFrame.Angles(0, 3.141592653589793, 0),
                ["Size"] = v86.Size * u16:NextNumber(1, 1.45),
                ["Transparency"] = 1
            }):Play()
            v86.Size = v86.Size * 0.1
            _G.destroy(v86, 1)
            _G.destroy(v84, 1)
            task.wait(0.03333333333333333)
        end
        v59()
    end
end
return v1