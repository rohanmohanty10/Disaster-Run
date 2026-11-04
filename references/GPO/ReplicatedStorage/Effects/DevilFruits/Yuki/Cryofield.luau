 

function PlayFlipbook(p1, p2, p3, p4, p5)
    for v6 = p4, p5 do
        if p1:IsDescendantOf(workspace) then
            local v7
            if p2:FindFirstChild((tostring(v6))) then
                v7 = v6
            else
                v7 = v6 + 1
            end
            p1.Texture = p2[tostring(v7)].Texture
            task.wait(p3)
        end
    end
end
local u8 = game:GetService("RunService")
Emit = _G.Emit
TweenCreate = _G.Ess.Tween
local _ = _G.Ess
local function u17(p9, p10, p11, p12, p13) --[[ Line: 33 ]]
    --[[
    Upvalues:
        [1] = u17
    --]]
    local v14 = p13 and 1 or 0
    for _, v15 in p10 do
        if type(v15) == "table" then
            u17(p9, v15, p11, p12, p13)
            task.wait(p11)
        else
            local v16 = p9:FindFirstChild(v15)
            if v16:IsA("BasePart") then
                TweenCreate(v16, TweenInfo.new(p12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    ["Transparency"] = v14
                })
            end
        end
    end
end
return {
    ["start"] = function(_, u18, p19, p20, u21) --[[ Name: start, Line 60 ]]
        --[[
        Upvalues:
            [1] = u8
        --]]
        if _G.checkRenderDistance(u18.PrimaryPart.Position) ~= false then
            Random.new()
            local _ = u18.PrimaryPart
            local _ = u18.Humanoid
            local u22 = {}
            local function v29(p23, p24) --[[ Line: 68 ]]
                --[[
                Upvalues:
                    [1] = u22
                --]]
                local v25 = p23:GetChildren()
                for v26 = 1, #v25 do
                    local v27 = v25[v26]:Clone()
                    v27.Parent = p24
                    local v28 = u22
                    table.insert(v28, v27)
                end
            end
            v29(script.Particles, u18.LeftFoot)
            v29(script.Particles2, u18.LeftUpperLeg)
            v29(script.Particles3, u18.LeftLowerLeg)
            Emit(u18.LeftFoot:GetChildren(), true)
            local v30 = Emit
            local v31 = {}
            local v32 = u18.LeftUpperLeg
            __set_list(v31, 1, {unpack(v32:GetChildren()), u18.LeftFoot.Fog1, u18.LeftLowerLeg.Fog})
            v30(v31, false)
            local u33 = CFrame.new(p19)
            local u34 = script.Ground:Clone()
            local u35 = script.Dome:Clone()
            u34.Size = u34.Size / 2
            u34.CFrame = u33 * CFrame.new(0, 0.25, 0)
            u35.CFrame = u33
            u34.Parent = workspace.Effects
            u35.Parent = workspace.Effects
            _G.PlaySound(u34, script.start)
            local u36 = true
            repeat
                task.wait()
            until p20 == nil or p20 and p20:IsDescendantOf(game) == false
            Emit(u35.Start, true)
            TweenCreate(u34, TweenInfo.new(0.15, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                ["Size"] = script.Ground.Size
            })
            for _, v37 in u34:GetChildren() do
                local v38 = TweenCreate
                local v39 = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                local v40 = {}
                local v41 = v37.Name
                v40.Transparency = tonumber(v41) * 1.5 * (v37.Name == ".25" and 0 or 1)
                v38(v37, v39, v40)
            end
            TweenCreate(u35.Decal, TweenInfo.new(0.7, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
                ["Transparency"] = 0.75
            })
            TweenCreate(u35, TweenInfo.new(1.4, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                ["CFrame"] = u35.CFrame * CFrame.Angles(0, -3.141592653589793, 0)
            })
            task.spawn(function() --[[ Line: 133 ]]
                --[[
                Upvalues:
                    [1] = u36
                    [2] = u35
                --]]
                while u36 ~= nil do
                    PlayFlipbook(u35.Decal, u35.Folder, 0.07, 1, 18)
                end
            end)
            task.wait(0.6)
            local u42 = _G.PlaySound(u34, script.spin)
            TweenCreate(u42, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                ["Volume"] = 0.5
            })
            TweenCreate(u35, TweenInfo.new(u21, Enum.EasingStyle.Linear), {
                ["Size"] = u35.Size * 1.5
            })
            TweenCreate(u34, TweenInfo.new(u21, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                ["Size"] = script.Ground.Size * 1.5
            })
            for _, v43 in u34:GetChildren() do
                local v44 = TweenCreate
                local v45 = TweenInfo.new(u21, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
                local v46 = {
                    ["Color3"] = Color3.new(1.5, 1.5, 1.5)
                }
                local v47 = v43.Name
                v46.Transparency = tonumber(v47)
                v44(v43, v45, v46)
            end
            for _, v48 in u35.Prim:GetChildren() do
                local v49 = v48.Speed
                local v50 = {}
                for _, v51 in v48.Size.Keypoints do
                    local v52 = NumberSequenceKeypoint.new
                    local v53 = v51.Time
                    local v54 = v51.Value * 1.5
                    local v55 = v51.Envelope * 1.5
                    table.insert(v50, v52(v53, v54, v55))
                end
                local v56 = NumberSequence.new(v50)
                _G.tween(v48, { u21, Enum.EasingStyle.Linear, Enum.EasingDirection.Out }, {
                    ["Size"] = v56,
                    ["Speed"] = NumberRange.new(v49.Min * 1.35, v49.Max * 1.35)
                })
            end
            local u57 = tick()
            local u58 = u35.Mesh.Scale
            Emit(u35:GetChildren(), false, u21 + 0.6)
            Emit(u35.Sec, false, u21 + 0.6)
            Emit(u35.Prim, false, u21 + 0.6)
            local _ = u8.Stepped:Connect(function() --[[ Line: 205 ]]
                --[[
                Upvalues:
                    [1] = u57
                    [2] = u35
                    [3] = u33
                    [4] = u58
                    [5] = u21
                    [6] = u18
                    [7] = u22
                    [8] = u42
                    [9] = u34
                    [10] = u36
                --]]
                local v59 = tick() - u57
                local v60 = v59 * 360
                local v61 = math.ceil(v60) % 360
                local v62 = u35
                local v63 = u33
                local v64 = CFrame.Angles
                local v65 = v61 / 2
                v62.CFrame = v63 * v64(0, math.rad(v65), 0)
                u35.Mesh.Scale = u58 + Vector3.new(15, 5, 15) * (v59 / u21)
                if u21 < v59 then
                    local v66 = Emit
                    local v67 = {}
                    local v68 = u18.LeftUpperLeg
                    __set_list(v67, 1, {unpack(v68:GetChildren()), u18.LeftFoot.Fog1, u18.LeftLowerLeg.Fog})
                    v66(v67, false)
                    TweenCreate(u35.Decal, TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                        ["Transparency"] = 1
                    })
                    for v69 = 1, #u22 do
                        u22[v69].Name = "done"
                        _G.destroy(u22[v69], 3)
                    end
                    task.delay(0.7, function() --[[ Line: 225 ]]
                        --[[
                        Upvalues:
                            [1] = u42
                            [2] = u34
                        --]]
                        TweenCreate(u42, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                            ["Volume"] = 0
                        })
                        _G.destroy(u42, 0.6)
                        for _, v70 in u34:GetChildren() do
                            TweenCreate(v70, TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                ["Transparency"] = 1
                            })
                        end
                    end)
                    _G.PlaySound(u18.PrimaryPart, script.endsfx)
                    u36:Disconnect()
                    u36 = nil
                    _G.destroy(u35, 3)
                end
            end)
        end
    end
}