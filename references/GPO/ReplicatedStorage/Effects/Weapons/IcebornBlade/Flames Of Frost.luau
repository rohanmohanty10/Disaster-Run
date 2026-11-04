 

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
local u9 = {
    "rbxassetid://15465037590",
    "rbxassetid://15465037456",
    "rbxassetid://15465037253",
    "rbxassetid://15465037090",
    "rbxassetid://15465029763",
    "rbxassetid://15465029624",
    "rbxassetid://15465029478",
    "rbxassetid://15465029361",
    "rbxassetid://15465029186",
    "rbxassetid://15465028989",
    "rbxassetid://15465022187",
    "rbxassetid://15465022009",
    "rbxassetid://15465021824",
    "rbxassetid://15465021708",
    "rbxassetid://15465021545",
    "rbxassetid://15465021331",
    ""
}
local function u18(p10, p11, p12, p13) --[[ Line: 79 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u2
        [3] = u6
    --]]
    local u14 = u3["IceSpike" .. math.random(1, 2)]:Clone()
    u14.Material = Enum.Material.Neon
    u14.CFrame = p10
    u14.Size = p11
    local v15 = workspace:Raycast(p10.Position + Vector3.new(0, 3, 0), Vector3.new(0, -7, 0), u2)
    local u16 = u3.floor:Clone()
    u16.CFrame = CFrame.lookAt(v15.Position, v15.Position + v15.Normal) * CFrame.Angles(-1.5707963267948966, u6:NextNumber(0, 6.283185307179586), 0)
    u16.Size = Vector3.new(0, 0, 0)
    u16.Material = Enum.Material.Neon
    u16.Parent = p13
    local v17 = u6:NextNumber(8, 10)
    u14.Parent = p13
    _G.tween(u16, {
        0.25,
        Enum.EasingStyle.Quad,
        Enum.EasingDirection.Out,
        0,
        false,
        0
    }, {
        ["Size"] = Vector3.new(v17, 0.6, v17)
    })
    _G.tween(u14, {
        0.25,
        Enum.EasingStyle.Quad,
        Enum.EasingDirection.Out,
        0,
        false,
        0
    }, {
        ["CFrame"] = u14.CFrame * CFrame.new(0, u6:NextNumber(1, 3), 0),
        ["Size"] = p12
    })
    task.delay(0.1, function() --[[ Line: 102 ]]
        --[[
        Upvalues:
            [1] = u16
            [2] = u14
        --]]
        u16.Material = Enum.Material.Ice
        u14.Material = Enum.Material.Ice
        task.wait(0.15)
        task.wait(1.4)
        _G.tween(u16, {
            0.3,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Size"] = Vector3.new(0, 0, 0)
        })
    end)
    task.delay(1.2, function() --[[ Line: 114 ]]
        --[[
        Upvalues:
            [1] = u14
        --]]
        _G.tween(u14, {
            0.25,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Size"] = Vector3.new(0, 0, 0),
            ["CFrame"] = u14.CFrame * CFrame.new(0, -5, 0)
        })
        task.wait(0.5)
        u14:Destroy()
    end)
end
function v4.start(_, _, u19) --[[ Line: 122 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u1
        [3] = u6
        [4] = u2
        [5] = u18
        [6] = u5
        [7] = u8
        [8] = u7
        [9] = u9
    --]]
    local u20 = Instance.new("Folder")
    u20.Name = "EffectsFolder"
    u20.Parent = workspace.Effects
    _G.destroy(u20, 10)
    _G.PlaySound(u19, script.HelheimSlashesIceSpikes)
    _G.PlaySound(u19, script.IceSlashes)
    for u21 = 1, 2 do
        task.spawn(function() --[[ Line: 134 ]]
            --[[
            Upvalues:
                [1] = u3
                [2] = u21
                [3] = u19
                [4] = u20
                [5] = u1
                [6] = u6
                [7] = u2
                [8] = u18
                [9] = u5
                [10] = u8
                [11] = u7
                [12] = u9
            --]]
            local u22 = u3.Frost:Clone()
            local u23 = 0
            local u24 = 900
            if u21 == 2 then
                u24 = u24 * -1
            end
            local v25 = CFrame.lookAt
            local v26 = u19
            local v27 = CFrame.new
            local v28 = math.rad(u23)
            local v29 = math.sin(v28) * 9
            local v30 = math.rad(u23)
            u22.CFrame = v25((v26 * v27(v29, 0, math.cos(v30) * 9)).Position, u19.Position)
            u22.Parent = u20
            local u31 = tick()
            local u32 = nil
            local u33 = tick()
            u32 = u1.Heartbeat:Connect(function(p34) --[[ Line: 156 ]]
                --[[
                Upvalues:
                    [1] = u23
                    [2] = u24
                    [3] = u21
                    [4] = u33
                    [5] = u6
                    [6] = u19
                    [7] = u2
                    [8] = u18
                    [9] = u20
                    [10] = u22
                    [11] = u31
                    [12] = u32
                --]]
                u23 = u23 + u24 * p34
                if u21 == 1 and tick() - u33 >= u6:NextNumber(0.03, 0.07) then
                    u33 = tick()
                    local v35 = workspace
                    local v36 = u19
                    local v37 = CFrame.new
                    local v38 = u23
                    local v39 = math.rad(v38)
                    local v40 = math.sin(v39) * 9 + u6:NextNumber(-3, 3)
                    local v41 = u23
                    local v42 = math.rad(v41)
                    local v43 = v35:Raycast((v36 * v37(v40, 0, math.cos(v42) * 9 + u6:NextNumber(-3, 3))).Position, Vector3.new(0, -12, 0), u2)
                    if v43 then
                        local v44 = u6:NextNumber(3, 6)
                        local v45 = u18
                        local v46 = CFrame.lookAt(v43.Position, u19.Position)
                        local v47 = CFrame.Angles
                        local v48 = u6:NextNumber(20, 40)
                        local v49 = math.rad(v48)
                        local v50 = u6:NextNumber(0, 360)
                        local v51 = v46 * v47(v49, math.rad(v50), 0)
                        local v52 = u6:NextNumber(11, 14)
                        v45(v51, Vector3.new(0, 0, 0), Vector3.new(v44, v52, v44), u20)
                    end
                elseif u21 == 2 and tick() - u33 >= u6:NextNumber(0.015, 0.04) then
                    u33 = tick()
                    local v53 = workspace
                    local v54 = u19
                    local v55 = CFrame.new
                    local v56 = u23
                    local v57 = math.rad(v56)
                    local v58 = math.sin(v57) * 18 + u6:NextNumber(-3, 3)
                    local v59 = u23
                    local v60 = math.rad(v59)
                    local v61 = v53:Raycast((v54 * v55(v58, 0, math.cos(v60) * 18 + u6:NextNumber(-3, 3))).Position, Vector3.new(0, -10, 0), u2)
                    if v61 then
                        local v62 = u6:NextNumber(4, 8)
                        local v63 = u18
                        local v64 = CFrame.lookAt(v61.Position, u19.Position)
                        local v65 = CFrame.Angles
                        local v66 = u6:NextNumber(20, 40)
                        local v67 = math.rad(v66)
                        local v68 = u6:NextNumber(0, 360)
                        local v69 = v64 * v65(v67, math.rad(v68), 0)
                        local v70 = u6:NextNumber(15, 21)
                        v63(v69, Vector3.new(0, 0, 0), Vector3.new(v62, v70, v62), u20)
                    end
                end
                local v71 = u22
                local v72 = CFrame.lookAt
                local v73 = u19
                local v74 = CFrame.new
                local v75 = u23
                local v76 = math.rad(v75)
                local v77 = math.sin(v76) * 9
                local v78 = u23
                local v79 = math.rad(v78)
                v71.CFrame = v72((v73 * v74(v77, 0, math.cos(v79) * 9)).Position, u19.Position)
                if tick() - u31 >= 0.4 then
                    for _, v80 in pairs(u22:GetDescendants()) do
                        if v80:IsA("ParticleEmitter") then
                            v80.Enabled = false
                        end
                    end
                    u32:Disconnect()
                end
            end)
            task.wait(0.15)
            task.spawn(function() --[[ Line: 215 ]]
                --[[
                Upvalues:
                    [1] = u21
                    [2] = u3
                    [3] = u6
                    [4] = u5
                    [5] = u19
                    [6] = u20
                    [7] = u8
                --]]
                local u81 = u21 == 2 and -1 or 1
                for _ = 1, 2 do
                    task.spawn(function() --[[ Line: 223 ]]
                        --[[
                        Upvalues:
                            [1] = u3
                            [2] = u6
                            [3] = u5
                            [4] = u81
                            [5] = u19
                            [6] = u20
                            [7] = u8
                        --]]
                        local v82 = u3.Cone:Clone()
                        local v83 = u6:NextNumber(10, 14)
                        local v84 = v83 - u6:NextNumber(7, 10)
                        local v85 = v82.Mesh
                        local v86 = u6:NextNumber(2, 4)
                        v85.Scale = Vector3.new(v84, v86, v84)
                        local v87 = u5
                        local v88 = v82.Mesh
                        local v89 = TweenInfo.new(0.4, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out)
                        local v90 = {}
                        local v91 = u6:NextNumber(10, 13)
                        v90.Scale = Vector3.new(v83, v91, v83)
                        local v92 = v87:Create(v88, v89, v90)
                        local v93 = u5:Create(v82.Decal, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                            ["Transparency"] = 1
                        })
                        local v94 = u5
                        local v95 = TweenInfo.new(0.4, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out)
                        local v96 = {}
                        local v97 = v82.Orientation
                        local v98 = -u81 * u6:NextNumber(360, 420)
                        v96.Orientation = v97 + Vector3.new(0, v98, 0)
                        local v99 = v94:Create(v82, v95, v96)
                        v93:Play()
                        v92:Play()
                        v99:Play()
                        v82.CFrame = u19 * CFrame.new(0, -3, 0) * CFrame.Angles(0, u6:NextNumber(0, 12.566370614359172), 0)
                        local v100 = u6:NextNumber(0, 360)
                        v82.Orientation = Vector3.new(0, v100, 0)
                        v82.Parent = u20
                        for _, v101 in pairs(u8) do
                            v82.Decal.Texture = v101
                            task.wait(0.015)
                        end
                    end)
                    task.wait(0.1)
                end
            end)
            local v102 = u3.Cresent:Clone()
            v102.CFrame = u19
            if u21 == 1 then
                v102.CFrame = u19 * CFrame.Angles(3.141592653589793, 0, 0)
            end
            v102.Parent = u20
            for _, v103 in pairs(v102:GetDescendants()) do
                if v103:IsA("ParticleEmitter") then
                    _G.customEmit(v103)
                end
            end
            local v104 = u3.Slash:Clone()
            local v105 = -180
            if u21 == 2 then
                v104.CFrame = u19 * CFrame.Angles(0, 0, 0.3490658503988659) * CFrame.new(0, 1, 0)
                local v106 = v104.Mesh
                local v107 = v104.Mesh.Scale.X + 0.04
                local v108 = v104.Mesh.Scale.Y
                local v109 = v104.Mesh.Scale.Z + 0.04
                v106.Scale = Vector3.new(v107, v108, v109)
                v105 = v105 * -1
            else
                v104.CFrame = u19 * CFrame.Angles(3.141592653589793, 3.141592653589793, -0.3490658503988659) * CFrame.new(0, -1, 0)
            end
            v104.Parent = u20
            for v110, v111 in pairs(u7) do
                v104.Decal.Texture = v111
                local v112 = #u7 * 0.2
                if v110 == math.round(v112) then
                    local v113 = u3.Spin:Clone()
                    if u21 == 1 then
                        v113.CFrame = u19 * CFrame.Angles(0, 0, -0.3490658503988659)
                    else
                        v113.CFrame = u19 * CFrame.Angles(0, 0, 0.3490658503988659)
                    end
                    v113.Parent = u20
                    _G.customEmit(v113.Dots)
                    local v114 = u5:Create(v113, TweenInfo.new(1.4, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                        ["CFrame"] = v113.CFrame * CFrame.Angles(0, math.rad(v105), 0)
                    })
                    v114:Play()
                    if u21 == 2 then
                        local v115 = u3.FireEmit:Clone()
                        v115.CFrame = u19 * CFrame.Angles(1.5707963267948966, 0, 0)
                        v115.Parent = u20
                        for _, v116 in pairs(v115:GetDescendants()) do
                            if v116:IsA("ParticleEmitter") then
                                _G.customEmit(v116)
                            end
                        end
                        task.spawn(function() --[[ Line: 318 ]]
                            --[[
                            Upvalues:
                                [1] = u3
                                [2] = u19
                                [3] = u20
                                [4] = u5
                                [5] = u6
                                [6] = u9
                            --]]
                            local v117 = u3.FireSpinEmit:Clone()
                            v117.CFrame = u19 * CFrame.Angles(1.5707963267948966, 0, 0)
                            v117.Parent = u20
                            for _, v118 in pairs(v117:GetDescendants()) do
                                if v118:IsA("ParticleEmitter") then
                                    _G.customEmit(v118)
                                end
                            end
                            local v119 = u5:Create(v117, TweenInfo.new(1.2, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                                ["Orientation"] = v117.Orientation + Vector3.new(0, -180, 0)
                            })
                            v119:Play()
                            for _ = 1, 5 do
                                local u120 = u3.FireMesh:Clone()
                                u120.CFrame = u19 * CFrame.Angles(0, u6:NextNumber(0, 6.283185307179586), 0) * CFrame.new(0, u6:NextNumber(1.5, 3), 0)
                                u120.Parent = u20
                                local v121 = u6:NextNumber(3, 6)
                                local v122 = u6:NextNumber(5, 10)
                                local v123 = u5
                                local v124 = u120.Mesh
                                local v125 = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                                local v126 = {}
                                local v127 = u120.Mesh.Scale.X + v122
                                local v128 = u6:NextNumber(14, 17)
                                local v129 = u120.Mesh.Scale.Z + v122
                                v126.Scale = Vector3.new(v127, v128, v129)
                                local u130 = v123:Create(v124, v125, v126)
                                local v131 = u120.Mesh
                                local v132 = u6:NextNumber(11, 14)
                                v131.Scale = Vector3.new(v121, v132, v121)
                                u130:Play()
                                task.spawn(function() --[[ Line: 351 ]]
                                    --[[
                                    Upvalues:
                                        [1] = u9
                                        [2] = u120
                                        [3] = u5
                                        [4] = u130
                                    --]]
                                    for v133, v134 in pairs(u9) do
                                        u120.Decal.Texture = v134
                                        local v135 = #u9 * 0.5
                                        if v133 == math.round(v135) then
                                            local v136 = u5:Create(u120.Decal, TweenInfo.new(0.3, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                                                ["Transparency"] = 1
                                            })
                                            v136:Play()
                                            task.delay(0.3, v136.Destroy, v136)
                                        end
                                        task.wait(0.015)
                                    end
                                    task.wait(0.3)
                                    u130:Destroy()
                                end)
                                task.wait(u6:NextNumber(0.023, 0.04))
                            end
                            task.wait(1.4)
                            v117:Destroy()
                            v119:Destroy()
                        end)
                    end
                    task.delay(1.4, v114.Destroy, v114)
                    task.delay(1.4, v113.Destroy, v113)
                end
                task.wait(0.016)
            end
        end)
        task.wait(0.5)
    end
end
return v4