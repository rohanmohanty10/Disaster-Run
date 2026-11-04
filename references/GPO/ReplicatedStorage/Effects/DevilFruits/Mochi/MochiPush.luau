 

local u1 = game:GetService("RunService")
local v2 = _G.Ess
Emit = _G.Emit
DestInt = v2.Destroy
TweenCreate = v2.Tween
Spawner = task.spawn
RaycastParameters = v2.RaycastParams
local u3 = require(script.ModuleScript)
return {
    ["start"] = function(_, p4, p5, _) --[[ Name: start, Line 16 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u3
        --]]
        if _G.checkRenderDistance(p4.HumanoidRootPart.Position) then
            local _ = p4.PrimaryPart
            local u6 = Random.new()
            local v7 = p5[1]
            local v8 = p5[2]
            local v9 = CFrame.new(v7, v8)
            local _ = (v8 - v7).Unit
            local u10 = (v8 - v7).Magnitude
            local _ = u10 / 80
            local v11 = TweenInfo.new(0.25, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out, 0, false)
            local u12 = TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
            local u13 = TweenInfo.new(u10 / 150, Enum.EasingStyle.Sine, Enum.EasingDirection.In, 0, false, 0)
            local v14 = TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In, 0, false, u13.Time / 2)
            local u15 = {}
            local u16 = script.Dough:Clone()
            u16.Size = u16.Size * 0
            u16.CFrame = v9 * CFrame.Angles(0, 3.141592653589793, 0)
            u16.Parent = workspace.Effects
            local v17, _, _ = _G.getRayFloor(u16.CFrame, 10)
            local u18 = script.MochiFist:Clone()
            u18.CFrame = u16.CFrame * CFrame.new(0, 0, -5)
            u18.Anchored = true
            u18.CanCollide = false
            u18.Parent = workspace.Effects
            if v17 then
                u18.side.flour.Color = ColorSequence.new(v17.Color)
                u18.side.flour2.Color = ColorSequence.new(v17.Color)
                u18.side1.flour.Color = ColorSequence.new(v17.Color)
                u18.side1.flour.Color = ColorSequence.new(v17.Color)
                u18.side1.rocks.Color = ColorSequence.new(v17.Color)
                u18.side.rocks.Color = ColorSequence.new(v17.Color)
            else
                u18.side.flour.Rate = 0
                u18.side.flour2.Rate = 0
                u18.side.rocks.Rate = 0
                u18.side1.flour.Rate = 0
                u18.side1.flour2.Rate = 0
                u18.side1.rocks.Rate = 0
            end
            _G.PlaySound(u18, script.MochiFistWhoosh)
            Emit(u16.Attachment, true)
            local v19 = TweenCreate(u18.RightRoot.RightExtend, u13, {
                ["Position"] = u18.RightRoot.RightExtend.Position + Vector3.new(0, u10, 0)
            })
            local v20 = TweenCreate
            local v21 = {}
            local v22 = u18.Size.Z
            v21.Size = Vector3.new(0, 0, v22)
            v20(u18, v14, v21)
            for _, u23 in u18:GetChildren() do
                if u23.ClassName == "Attachment" then
                    local v24 = TweenCreate
                    local v25 = {}
                    local v26 = u23.Position
                    local v27 = -u10
                    v25.Position = v26 + Vector3.new(0, 0, v27)
                    v24(u23, u13, v25)
                    task.delay(u13.Time / 1.1, function() --[[ Line: 102 ]]
                        --[[
                        Upvalues:
                            [1] = u23
                        --]]
                        Emit(u23, false)
                    end)
                end
            end
            local u28 = script.Part:Clone()
            u28.CFrame = u18.CFrame
            u28.Parent = workspace.Effects
            _G.tween(u28, {
                u13.Time,
                "Sine",
                Enum.EasingDirection.In,
                0,
                false,
                0
            }, {
                ["CFrame"] = u28.CFrame * CFrame.new(0, 0, -u10)
            })
            _G.PlayEffect("RockFollow", nil, u28, 2, 3.5)
            v19.Completed:Connect(function() --[[ Line: 112 ]]
                --[[
                Upvalues:
                    [1] = u15
                    [2] = u16
                    [3] = u12
                    [4] = u28
                    [5] = u18
                --]]
                for _, v29 in u15 do
                    if v29 ~= nil then
                        v29:Disconnect()
                    end
                end
                TweenCreate(u16, u12, {
                    ["Size"] = Vector3.new(0, 0, 0),
                    ["CFrame"] = u16.CFrame * CFrame.Angles(0, 0, 3.141592653589793)
                })
                task.delay(u12.Time, function() --[[ Line: 127 ]]
                    --[[
                    Upvalues:
                        [1] = u28
                        [2] = u16
                        [3] = u18
                    --]]
                    task.wait(0.56)
                    u28:Destroy()
                    u16:Destroy()
                    u18:Destroy()
                end)
            end)
            TweenCreate(u16, TweenInfo.new(u13.Time + 0.25, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
                ["Transparency"] = 1
            })
            TweenCreate(u16, v11, {
                ["Size"] = script.Dough.Size,
                ["CFrame"] = u16.CFrame * CFrame.Angles(0, 0, 3.141592653589793)
            })
            task.spawn(function() --[[ Line: 148 ]]
                --[[
                Upvalues:
                    [1] = u1
                    [2] = u18
                    [3] = u3
                    [4] = u13
                    [5] = u10
                    [6] = u15
                    [7] = u6
                --]]
                local u30 = script.RepeatingMeshes
                local u31 = nil
                local u32 = tick()
                local u33 = tick()
                local u34 = tick()
                u31 = u1.RenderStepped:Connect(function() --[[ Line: 157 ]]
                    --[[
                    Upvalues:
                        [1] = u18
                        [2] = u32
                        [3] = u3
                        [4] = u33
                        [5] = u30
                        [6] = u13
                        [7] = u34
                        [8] = u10
                        [9] = u31
                    --]]
                    local v35 = tick()
                    local v36 = tick()
                    local v37 = u18.RightRoot.RightExtend.Position.Y
                    if v35 - u32 > 0.07 then
                        u3.CreateSideFlyingRocks(u18.CFrame * CFrame.new(0, -5, -v37), 5, (Vector3.new(0, 25, 0) + u18.CFrame.RightVector * 5) * 10, u18.CFrame.LookVector * -100)
                        u32 = tick()
                    end
                    if v36 - u33 > 0.1 then
                        local v38 = u18.CFrame * CFrame.new(0, 0, -v37) * CFrame.Angles(0, 3.141592653589793, 0)
                        local u39 = u30.sides:Clone()
                        u39:PivotTo(v38)
                        u39.Parent = workspace.Effects
                        for _, v40 in u39:GetChildren() do
                            local v41 = v40:GetAttribute("Left") == true and -1 or 1
                            v40.Transparency = 0
                            local v42 = TweenCreate
                            local v43 = TweenInfo.new(u13.Time * 1.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                            local v44 = {
                                ["CFrame"] = v40.CFrame * CFrame.new(-v37 / 2, 0, v41 * 5)
                            }
                            local v45 = v40.Size
                            local v46 = 15 + v37
                            v44.Size = v45 + Vector3.new(v46, 15, 0)
                            v42(v40, v43, v44)
                            TweenCreate(v40, TweenInfo.new(u13.Time, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                                ["Transparency"] = 1
                            })
                        end
                        task.delay(u13.Time, function() --[[ Line: 192 ]]
                            --[[
                            Upvalues:
                                [1] = u39
                            --]]
                            u39:Destroy()
                        end)
                        u33 = tick()
                    end
                    if tick() - u34 >= u10 / 150 then
                        u31:Disconnect()
                        u31 = nil
                    end
                end)
                local v47 = u15
                local v48 = u31
                table.insert(v47, v48)
                task.wait(0.15)
                for v49 = 1, 2 do
                    local v50 = u18.RightRoot.RightExtend.Position.Y / 3 - 4
                    local v51 = u18.CFrame * CFrame.new(0, 0, -(v50 * 3)) * CFrame.Angles(0, 0, 0)
                    local u52 = u30.SwirlModel:Clone()
                    u52:PivotTo(v51)
                    u52.Parent = workspace.Effects
                    for _, v53 in u52:GetChildren() do
                        v53.Size = v53.Size / (v50 ^ 0.5 / 2 + 0.45)
                        TweenCreate(v53, TweenInfo.new(u13.Time * 1.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                            ["CFrame"] = v53.CFrame * CFrame.new(0, 20, 0) * CFrame.Angles(0, 3.141592653589793, 0),
                            ["Size"] = v53.Size * 2 + Vector3.new(0, 20, 0)
                        })
                        TweenCreate(v53, TweenInfo.new(u13.Time, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                            ["Transparency"] = 1
                        })
                    end
                    task.delay(u13.Time, function() --[[ Line: 233 ]]
                        --[[
                        Upvalues:
                            [1] = u52
                        --]]
                        u52:Destroy()
                    end)
                    local v54 = u18.CFrame * CFrame.Angles(0, 1.5707963267948966, 0) * CFrame.new(v50 * 2, 0, 0) * CFrame.Angles(-3.141592653589793 / v49 * 2, 0, 0)
                    local u55 = u30.Swirl2:Clone()
                    u55.CFrame = v54
                    u55.Size = u55.Size / (v50 ^ 0.5 / 2)
                    u55.Parent = workspace.Effects
                    local v56 = TweenCreate
                    local v57 = TweenInfo.new(u13.Time, Enum.EasingStyle.Circular, Enum.EasingDirection.Out)
                    local v58 = {
                        ["CFrame"] = u55.CFrame * CFrame.new(10, 0, 0) * CFrame.Angles(1.5707963267948966, 0, 0)
                    }
                    local v59 = u55.Size * 2.5
                    local v60 = u6:NextNumber(0.5, 2)
                    v58.Size = v59 * Vector3.new(v60, 1, 1)
                    v56(u55, v57, v58)
                    TweenCreate(u55, TweenInfo.new(u13.Time, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                        ["Transparency"] = 1
                    })
                    task.delay(u13.Time, function() --[[ Line: 255 ]]
                        --[[
                        Upvalues:
                            [1] = u55
                        --]]
                        u55:Destroy()
                    end)
                    task.wait(u13.Time / 2)
                end
            end)
            local u61 = script.Wind:Clone()
            u61:PivotTo(v9 * CFrame.new(0, 0, -10))
            u61.Parent = workspace.Effects
            task.delay(u13.Time + 0.25, function() --[[ Line: 272 ]]
                --[[
                Upvalues:
                    [1] = u61
                --]]
                u61:Destroy()
            end)
            for _, v62 in u61:GetChildren() do
                if v62.Name == "sides" then
                    local function v69(p63, p64) --[[ Line: 279 ]]
                        --[[
                        Upvalues:
                            [1] = u13
                            [2] = u10
                        --]]
                        local v65 = TweenCreate
                        local v66 = TweenInfo.new(u13.Time * 1.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                        local v67 = {
                            ["CFrame"] = p63.CFrame * CFrame.new(u10, 0, 0) + p64
                        }
                        local v68 = u10
                        v67.Size = p63.Size + Vector3.new(v68, 9, 0)
                        v65(p63, v66, v67)
                        TweenCreate(p63, TweenInfo.new(u13.Time * 1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                            ["Transparency"] = 1
                        })
                    end
                    for _, v70 in v62:GetChildren() do
                        v69(v70, v62:GetPivot().RightVector * 10)
                    end
                elseif v62.Name == "swirls" then
                    for _, v71 in v62:GetChildren() do
                        local v72 = TweenCreate
                        local v73 = TweenInfo.new(u13.Time * 1.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
                        local v74 = {
                            ["CFrame"] = v71.CFrame * CFrame.new(-u10 / 1.25, 0, 0) * CFrame.Angles(1.5707963267948966, 0, 0)
                        }
                        local v75 = v71.Size * 1.5
                        local v76 = u10 / 2.5
                        v74.Size = v75 + Vector3.new(v76, 0, 0)
                        v72(v71, v73, v74)
                        TweenCreate(v71, TweenInfo.new(u13.Time, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                            ["Transparency"] = 1
                        })
                    end
                elseif v62.Name == "mainShock" then
                    for _, v77 in v62:GetChildren() do
                        local v78 = TweenCreate
                        local v79 = TweenInfo.new(u13.Time * 1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                        local v80 = {
                            ["CFrame"] = v77.CFrame * CFrame.new(u10 * 1.5, 0, 0)
                        }
                        local v81 = v77.Size * 1.5
                        local v82 = u10 / 4
                        v80.Size = v81 + Vector3.new(v82, 0, 0)
                        v78(v77, v79, v80)
                        TweenCreate(v77, TweenInfo.new(u13.Time * 1.25, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                            ["Transparency"] = 1
                        })
                    end
                end
            end
        end
    end
}