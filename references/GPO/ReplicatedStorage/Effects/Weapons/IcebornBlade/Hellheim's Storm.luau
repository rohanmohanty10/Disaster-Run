 

local u1 = game:GetService("RunService")
local u2 = RaycastParams.new()
u2.FilterType = Enum.RaycastFilterType.Include
u2.FilterDescendantsInstances = { workspace.Islands, workspace.Env, workspace.Ships }
local u3 = script
local v4 = {}
local u5 = game:GetService("TweenService")
local u6 = Random.new()
local u7 = {
    "",
    "rbxassetid://15438802340",
    "rbxassetid://15438802166",
    "rbxassetid://15438801989",
    "rbxassetid://15438801859",
    "rbxassetid://15438801747",
    "rbxassetid://15438801633",
    "rbxassetid://15438794123",
    "rbxassetid://15438794123",
    "rbxassetid://15438793747",
    "rbxassetid://15438793585",
    "rbxassetid://15438793449",
    "rbxassetid://15438793327",
    "rbxassetid://15438786472",
    "rbxassetid://15438786375",
    "rbxassetid://15438786206",
    "rbxassetid://15438786102",
    "rbxassetid://15438785962",
    "rbxassetid://15438785756",
    ""
}
local u8 = {
    "",
    "rbxassetid://15438802340",
    "rbxassetid://15438802166",
    "rbxassetid://15438801989",
    "rbxassetid://15438801859",
    "rbxassetid://15438801633",
    "rbxassetid://15438794123",
    "rbxassetid://15438794123",
    "rbxassetid://15438793585",
    "rbxassetid://15438793449",
    "rbxassetid://15438793327",
    "rbxassetid://15438786375",
    "rbxassetid://15438786206",
    "rbxassetid://15438786102",
    "rbxassetid://15438785962",
    "rbxassetid://15438785756",
    ""
}
local u9 = {
    "rbxassetid://15440280688",
    "rbxassetid://15440280460",
    "rbxassetid://15440272935",
    "rbxassetid://15440272740",
    "rbxassetid://15440272599",
    "rbxassetid://15440272476",
    "rbxassetid://15440272306",
    "rbxassetid://15440265943",
    "rbxassetid://15440265760",
    "rbxassetid://15440265510",
    "rbxassetid://15440265305",
    "rbxassetid://15440264989",
    ""
}
local u10 = {
    "rbxassetid://15492186363",
    "rbxassetid://15492186258",
    "rbxassetid://15492181528",
    "rbxassetid://15492181460",
    "rbxassetid://15492181227",
    "rbxassetid://15492176630",
    "rbxassetid://15492176463",
    "rbxassetid://15492176001",
    "rbxassetid://15492175846",
    "rbxassetid://15492175759",
    ""
}
local function u62(u11, u12, p13) --[[ Line: 114 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u1
        [3] = u7
        [4] = u8
        [5] = u5
        [6] = u6
        [7] = u9
    --]]
    local u14 = u3.Frost:Clone()
    local u15 = 0
    local v16 = CFrame.lookAt
    local v17 = CFrame.new
    local v18 = u15
    local v19 = math.rad(v18)
    local v20 = math.sin(v19) * 9
    local v21 = u15
    local v22 = math.rad(v21)
    u14.CFrame = v16((u11 * v17(v20, 0, math.cos(v22) * 9)).Position, u11.Position)
    u14.Parent = u12
    local u23 = tick()
    local u24 = nil
    u24 = u1.Heartbeat:Connect(function(p25) --[[ Line: 128 ]]
        --[[
        Upvalues:
            [1] = u15
            [2] = u14
            [3] = u11
            [4] = u23
            [5] = u24
        --]]
        u15 = u15 + -900 * p25
        local v26 = u14
        local v27 = CFrame.lookAt
        local v28 = u11
        local v29 = CFrame.new
        local v30 = u15
        local v31 = math.rad(v30)
        local v32 = math.sin(v31) * 9
        local v33 = u15
        local v34 = math.rad(v33)
        v26.CFrame = v27((v28 * v29(v32, 0, math.cos(v34) * 9)).Position, u11.Position)
        if tick() - u23 >= 0.4 then
            _G.particleEnabled(u14, false, true)
            u24:Disconnect()
            u24 = nil
        end
    end)
    local u35 = u3.Slash:Clone()
    u35.CFrame = u11 * CFrame.Angles(0, 1.0471975511965976, 0)
    u35.Parent = u12
    local u36 = u7
    if p13 == true then
        u36 = u8
    end
    task.spawn(function() --[[ Line: 153 ]]
        --[[
        Upvalues:
            [1] = u36
            [2] = u35
            [3] = u7
            [4] = u3
            [5] = u11
            [6] = u12
            [7] = u5
        --]]
        for v37, v38 in pairs(u36) do
            u35.Decal.Texture = v38
            local v39 = #u7 * 0.2
            if v37 == math.round(v39) then
                local v40 = u3.Spin:Clone()
                v40.CFrame = u11
                v40.Parent = u12
                _G.customEmit(v40)
                u5:Create(v40, TweenInfo.new(1.4, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                    ["CFrame"] = v40.CFrame * CFrame.new(0, -3, 0) * CFrame.Angles(0, 3.141592653589793, 0)
                }):Play()
            end
            task.wait(0.015)
        end
    end)
    local v41 = u3.Cresent:Clone()
    v41.CFrame = u11
    v41.Parent = u12
    _G.customEmit(v41)
    if p13 == true then
        for _ = 1, 2 do
            task.spawn(function() --[[ Line: 185 ]]
                --[[
                Upvalues:
                    [1] = u3
                    [2] = u6
                    [3] = u5
                    [4] = u11
                    [5] = u12
                    [6] = u9
                --]]
                local v42 = u3.Cone:Clone()
                local v43 = u6:NextNumber(10, 14)
                local v44 = v43 - u6:NextNumber(7, 10)
                local v45 = v42.Mesh
                local v46 = u6:NextNumber(2, 4)
                v45.Scale = Vector3.new(v44, v46, v44)
                local v47 = u5
                local v48 = v42.Mesh
                local v49 = TweenInfo.new(0.4, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out)
                local v50 = {}
                local v51 = u6:NextNumber(10, 13)
                v50.Scale = Vector3.new(v43, v51, v43)
                local v52 = v47:Create(v48, v49, v50)
                local v53 = u5:Create(v42.Decal, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    ["Transparency"] = 1
                })
                local v54 = u5
                local v55 = TweenInfo.new(0.4, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out)
                local v56 = {}
                local v57 = v42.Orientation
                local v58 = -u6:NextNumber(360, 420)
                v56.Orientation = v57 + Vector3.new(0, v58, 0)
                local v59 = v54:Create(v42, v55, v56)
                v53:Play()
                v52:Play()
                v59:Play()
                v42.CFrame = u11 * CFrame.new(0, -3, 0) * CFrame.Angles(0, u6:NextNumber(0, 12.566370614359172), 0)
                local v60 = u6:NextNumber(0, 360)
                v42.Orientation = Vector3.new(0, v60, 0)
                v42.Parent = u12
                for _, v61 in pairs(u9) do
                    v42.Decal.Texture = v61
                    task.wait(0.015)
                end
            end)
            task.wait(0.1)
        end
    end
end
function v4.start(_, _, u63, u64) --[[ Line: 263 ]]
    --[[
    Upvalues:
        [1] = u62
        [2] = u3
        [3] = u2
        [4] = u5
        [5] = u6
        [6] = u10
    --]]
    local u65 = Instance.new("Folder")
    u65.Name = "EffectsFolder"
    u65.Parent = workspace.Effects
    _G.destroy(u65, 10)
    task.wait(0.15)
    _G.PlaySound(u64.PrimaryPart, script.IceTwisterStart)
    u62(u63 * CFrame.new(0, 2, 0) * CFrame.Angles(0, 0, 0.5235987755982988), u65, false)
    task.wait(0.25)
    local v66 = u3.TPEmit:Clone()
    v66.CFrame = u63
    v66.Parent = workspace.Effects
    _G.customEmit(v66)
    _G.destroy(v66, 2)
    local v67 = workspace:Raycast(u63.Position, u63.LookVector * -16, u2)
    local u68 = not v67 and 16 or (v67.Position - u63.Position).Magnitude - 1
    u5:Create(u64.PrimaryPart, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        ["CFrame"] = u63 * CFrame.new(0, 0, u68)
    }):Play()
    task.wait(0.2)
    local v69 = u3.TPEmit:Clone()
    v69.CFrame = CFrame.new(u64.PrimaryPart.CFrame.Position)
    v69.Parent = workspace.Effects
    _G.customEmit(v69)
    _G.destroy(v69, 2)
    local v70 = u3.TornadoeEmit:Clone()
    v70.CFrame = u63 * CFrame.new(0, 0, u68) * CFrame.Angles(-1.5707963267948966, 0, 0)
    v70.Parent = u65
    local u71 = _G.PlaySound(u64.PrimaryPart, script.IceTwisterTpShoot)
    _G.customEmit(v70)
    local v72 = u5:Create(v70, TweenInfo.new(1.2, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
        ["Orientation"] = v70.Orientation + Vector3.new(0, -400, 0)
    })
    v72:Play()
    task.delay(0.15, function() --[[ Line: 315 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u63
            [3] = u68
            [4] = u65
            [5] = u71
            [6] = u6
            [7] = u10
            [8] = u5
            [9] = u64
        --]]
        task.spawn(function() --[[ Line: 317 ]]
            --[[
            Upvalues:
                [1] = u3
                [2] = u63
                [3] = u68
                [4] = u65
                [5] = u71
                [6] = u6
                [7] = u10
                [8] = u5
                [9] = u64
            --]]
            local u73 = u3.Tornadoe:Clone()
            u73.CFrame = u63 * CFrame.new(0, 0, u68) * CFrame.Angles(-1.5707963267948966, 0, 0)
            u73.Parent = u65
            u71.Parent = u73.Attachment
            task.spawn(function() --[[ Line: 221 ]]
                --[[
                Upvalues:
                    [1] = u3
                    [2] = u6
                    [3] = u10
                    [4] = u73
                    [5] = u5
                --]]
                local v74 = tick()
                while tick() - v74 <= 0.5 do
                    local u75 = u3.TornadoeMesh:Clone()
                    local v76 = u6:NextNumber(0, 360)
                    u75.Orientation = Vector3.new(0, v76, 0)
                    local v77 = u6:NextNumber(5, 9)
                    local v78 = u75.Mesh
                    local v79 = u6:NextNumber(17, 20)
                    v78.Scale = Vector3.new(v77, v79, v77)
                    u75.Parent = workspace.Effects
                    task.spawn(function() --[[ Line: 231 ]]
                        --[[
                        Upvalues:
                            [1] = u10
                            [2] = u75
                            [3] = u73
                            [4] = u6
                            [5] = u5
                        --]]
                        for v80, v81 in pairs(u10) do
                            u75.Position = u73.Position + Vector3.new(0, 3, 0)
                            u75.Decal.Texture = v81
                            if v80 == 1 then
                                local v82 = u6:NextNumber(1, 3)
                                local v83 = u5
                                local v84 = u75.Mesh
                                local v85 = TweenInfo.new(0.4, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out)
                                local v86 = {}
                                local v87 = u75.Mesh.Scale.X + v82
                                local v88 = u75.Mesh.Scale.Y + u6:NextNumber(1, 4)
                                local v89 = u75.Mesh.Scale.Z + v82
                                v86.Scale = Vector3.new(v87, v88, v89)
                                local v90 = v83:Create(v84, v85, v86)
                                v90:Play()
                                task.delay(0.4, v90.Destroy, v90)
                            end
                            local v91 = #u10 * 0.6
                            if v80 == math.round(v91) then
                                local v92 = u5:Create(u75.Decal, TweenInfo.new(0.4, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                                    ["Transparency"] = 1
                                })
                                v92:Play()
                                task.delay(0.4, v92.Destroy, v92)
                            end
                            task.wait(0.025)
                        end
                        _G.destroy(u73, 3)
                    end)
                    task.wait(u6:NextNumber(0.07, 0.12))
                end
            end)
            local _ = u64.PrimaryPart.Position
            local _ = (u64.PrimaryPart.CFrame * CFrame.new(0, 0, -14)).Position
            local v93 = (u64.PrimaryPart.CFrame * CFrame.new(0, 0, -40)).Position
            u5:Create(u73, TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                ["Orientation"] = u73.Orientation - Vector3.new(0, 1000, 0)
            }):Play()
            u5:Create(u73, TweenInfo.new(0.4, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                ["Position"] = v93
            }):Play()
            task.wait(0.4)
            _G.particleEnabled(u73, false, true)
        end)
    end)
    u62(u63 * CFrame.new(0, 0, u68), u65, true)
    task.wait(0.175)
    task.wait(0.625)
    v72:Destroy()
end
return v4