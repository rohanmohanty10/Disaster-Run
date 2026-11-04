 

local v1 = {}
game:GetService("Players")
local u2 = game:GetService("TweenService")
local u3 = workspace.Effects
local u4 = script:WaitForChild("Pull_FX")
local u5 = script:WaitForChild("Tornado")
local u6 = script:WaitForChild("Character_WindFX")
local u7 = script:WaitForChild("Wind_Trail")
local u8 = script:WaitForChild("Floor")
local u9 = script:WaitForChild("FloorParticles")
local u10 = script:WaitForChild("Break_FX")
local function u17(p11, p12, _) --[[ Line: 22 ]]
    local v13 = p11.Position
    local v14 = p11.LookVector:Cross(p12).Unit
    local v15 = (v14.Magnitude > 0.001 and v14 and v14 or p11.RightVector).Unit
    local v16 = v15:Cross(p12).Unit.Unit
    return CFrame.fromMatrix(v13, v15, p12, v16)
end
function v1.start(_, u18, u19) --[[ Line: 36 ]]
    --[[
    Upvalues:
        [1] = u6
        [2] = u4
        [3] = u5
        [4] = u3
        [5] = u8
        [6] = u9
        [7] = u17
        [8] = u2
        [9] = u7
        [10] = u10
    --]]
    local u20 = u18.HumanoidRootPart
    u18.Humanoid.AutoRotate = false
    u18.Humanoid.WalkSpeed = 0
    local u21 = {}
    local u24 = {
        ["add"] = function(p22) --[[ Name: add, Line 45 ]]
            --[[
            Upvalues:
                [1] = u21
            --]]
            local v23 = u21
            table.insert(v23, p22)
        end
    }
    task.spawn(function() --[[ Line: 50 ]]
        --[[
        Upvalues:
            [1] = u19
            [2] = u6
            [3] = u4
            [4] = u5
            [5] = u18
            [6] = u24
            [7] = u3
            [8] = u8
            [9] = u9
            [10] = u17
            [11] = u20
            [12] = u2
            [13] = u7
            [14] = u10
            [15] = u21
        --]]
        local v25 = u19.Weapon
        if v25 then
            local v26 = v25:WaitForChild("Muzzle")
            local v27 = u6:Clone()
            local v28 = u4:Clone()
            local v29 = u5:Clone()
            local v30 = u18.HumanoidRootPart
            local v31 = Instance.new("Weld")
            v31.Part0 = v30
            v31.Part1 = v27
            v31.Parent = v27
            local v32 = Instance.new("Weld")
            v32.Part0 = v26
            v32.Part1 = v28
            v32.Parent = v28
            u24.add(v27)
            u24.add(v28)
            u24.add(v29)
            v27.CFrame = u18.HumanoidRootPart.CFrame + u18.HumanoidRootPart.CFrame.UpVector * -2.5
            v31.C0 = CFrame.new(0, -2.5, 0)
            v28.CFrame = v26.CFrame
            v32.C0 = v32.C0 * CFrame.Angles(0, 3.141592653589793, 0)
            v29.CFrame = v26.CFrame
            local v33 = Instance.new("Weld")
            v33.Part0 = v26
            v33.Part1 = v29
            v33.Parent = v29
            v27.Parent = u3
            v28.Parent = u3
            v29.Parent = u3
            local v34 = u8:Clone()
            local v35 = u8:Clone()
            local v36 = u8:Clone()
            local v37 = u9:Clone()
            local u38 = u18.PrimaryPart.CFrame
            local function v47(p39, p40, p41) --[[ Line: 85 ]]
                --[[
                Upvalues:
                    [1] = u38
                    [2] = u17
                --]]
                local v42 = p40 == nil and 0 or p40
                local v43 = p41 or u38 * CFrame.new(0, 0, -v42)
                local v44, v45, v46 = _G.getRayFloor(CFrame.new(v43.Position), 12)
                if v44 then
                    p39.CFrame = u17(CFrame.new(Vector3.new(), v43.LookVector) + v45, v46)
                else
                    warn("NO FLOOR", p39:GetFullName())
                    p39.Transparency = 1
                    _G.particleEnabled(p39, false)
                end
            end
            v47(v34, 0)
            v47(v35, 13)
            v47(v36, 27)
            v36.Parent = u3
            v35.Parent = u3
            v34.Parent = u3
            v37:PivotTo(u20.CFrame + u20.CFrame.UpVector * -2.9)
            local v48 = v37:GetChildren()
            local u49 = { v34, v35, v36 }
            for v50 = 1, #v48 do
                v47(v48[v50], 0, v48[v50].CFrame)
            end
            v37.Parent = u3
            u24.add(v36)
            u24.add(v35)
            u24.add(v34)
            u24.add(v37)
            local v51 = u2:Create(v34, TweenInfo.new(9), {
                ["CFrame"] = v34.CFrame * CFrame.new(0, 0.5, 0),
                ["Size"] = v35.Size * 1.2
            })
            local v52 = u2:Create(v35, TweenInfo.new(6), {
                ["CFrame"] = v35.CFrame * CFrame.new(0, 0.5, 0),
                ["Size"] = v35.Size * 1.4
            })
            local v53 = u2:Create(v36, TweenInfo.new(3), {
                ["CFrame"] = v36.CFrame * CFrame.new(0, 0.5, 0),
                ["Size"] = v36.Size * 2
            })
            v51:Play()
            v52:Play()
            v53:Play()
            local v54 = 0
            while u18:GetAttribute("holdingIceGunPull") ~= nil do
                if tick() - v54 >= 0.75 then
                    local u55 = u7:Clone()
                    u55.CFrame = u20.CFrame + u20.CFrame.LookVector * 40
                    u55.Anchored = true
                    u55.Parent = u3
                    local u56 = Instance.new("NumberValue")
                    u56.Value = 15
                    u56.Changed:Connect(function() --[[ Line: 146 ]]
                        --[[
                        Upvalues:
                            [1] = u55
                            [2] = u56
                        --]]
                        if u55.Parent ~= nil then
                            u55.Left.CFrame = CFrame.new(-u56.Value, 0, 0)
                            u55.Right.CFrame = CFrame.new(u56.Value, 0, 0)
                        end
                    end)
                    local v57 = TweenInfo.new(3)
                    local v58 = u2:Create(u56, TweenInfo.new(3.5), {
                        ["Value"] = 0
                    })
                    local u59 = Instance.new("Part")
                    u59.Anchored = true
                    u59.CanCollide = false
                    u59.CFrame = u55.CFrame
                    u59.Transparency = 1
                    u59.Parent = u3
                    u24.add(u59)
                    u24.add(u55)
                    u24.add(u56)
                    u2:Create(u59, v57, {
                        ["CFrame"] = u20.CFrame + u20.CFrame.LookVector * 8
                    }):Play()
                    local u60 = u55.CFrame
                    local u61 = game["Run Service"].RenderStepped:Connect(function() --[[ Line: 171 ]]
                        --[[
                        Upvalues:
                            [1] = u60
                            [2] = u59
                            [3] = u55
                        --]]
                        u60 = (u60 - u60.Position + u59.CFrame.Position) * CFrame.Angles(0, 0, -0.2617993877991494)
                        u55.CFrame = u60
                    end)
                    v58.Completed:Connect(function() --[[ Line: 176 ]]
                        --[[
                        Upvalues:
                            [1] = u61
                            [2] = u59
                            [3] = u55
                        --]]
                        if u61 ~= nil then
                            u61:Disconnect()
                            if u59.Parent ~= nil then
                                u59:Destroy()
                            end
                            if u55.Parent ~= nil then
                                u55:Destroy()
                            end
                        end
                    end)
                    v58:Play()
                    v54 = tick()
                end
                task.wait()
            end
            task.delay(0.5, function() --[[ Line: 195 ]]
                --[[
                Upvalues:
                    [1] = u49
                    [2] = u10
                    [3] = u3
                --]]
                for v62 = 1, #u49 do
                    local v63 = u49[v62]
                    if v63.Transparency ~= 1 then
                        local v64 = u10:Clone()
                        v64.CFrame = v63.CFrame
                        v64.Size = v63.Size
                        v64.Parent = u3
                        _G.destroy(v64, 2)
                        _G.customEmit(v64)
                    end
                end
            end)
            for _, u65 in u21 do
                if typeof(u65) == "Instance" then
                    if u65.Name == u5.Name or (u65.Name == u4.Name or u65.Name == u6.Name) then
                        _G.particleEnabled(u65, false, true)
                    elseif u65.Name == u9.Name or u65.Name == u8.Name then
                        task.delay(0.5, function() --[[ Line: 216 ]]
                            --[[
                            Upvalues:
                                [1] = u65
                            --]]
                            u65:Destroy()
                        end)
                    elseif u65.Name == u7.Name then
                        for _, u66 in u65:GetDescendants() do
                            if u66:IsA("Trail") then
                                local u67 = Instance.new("NumberValue")
                                u67.Value = 0
                                u67.Changed:Connect(function() --[[ Line: 224 ]]
                                    --[[
                                    Upvalues:
                                        [1] = u66
                                        [2] = u67
                                    --]]
                                    u66.Transparency = NumberSequence.new(u67.Value)
                                end)
                                u67.Parent = u3
                                u2:Create(u67, TweenInfo.new(0.5), {
                                    ["Value"] = 1
                                }):Play()
                                _G.destroy(u67, 0.51)
                            end
                        end
                    end
                    _G.particleEnabled(u65, false, true)
                    _G.destroy(u65, 5)
                end
            end
        end
    end)
end
return v1