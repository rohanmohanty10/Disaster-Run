 

local v1 = game:GetService("ReplicatedStorage")
local u2 = game:GetService("RunService")
local _ = workspace.Effects
game:GetService("Debris")
local u3 = game:GetService("TweenService")
local u4 = require(v1.Modules.EffectsUtil)
local u5 = script
local v6 = {}
local u7 = {
    ["chargeUp"] = 0.05,
    ["slam"] = 0.85,
    ["groundFlash"] = 0.8166666666666667,
    ["wind"] = 0.8333333333333334
}
local u8 = Random.new()
local u9 = RaycastParams.new()
u9.FilterType = Enum.RaycastFilterType.Whitelist
u9.FilterDescendantsInstances = { workspace.Islands, workspace.Env, workspace.Ships }
function shuffle(p10)
    for v11 = #p10, 1, -1 do
        local v12 = math.random(v11)
        local v13 = p10[v11]
        p10[v11] = p10[v12]
        p10[v12] = v13
    end
    return p10
end
function crater(p14)
    --[[
    Upvalues:
        [1] = u8
        [2] = u5
    --]]
    local v15 = {}
    for v16 = 1, 8 do
        local v17 = v16 / 8 * 360 + u8:NextNumber(-10, 10)
        local v18 = u5.Rock1:Clone()
        local v19 = p14 * CFrame.new(0, u8:NextNumber(-2.2, -1.5), 0) * CFrame.Angles(0, math.rad(v17), 0) * CFrame.new(0, 0, -8) * CFrame.Angles(-0.6981317007977318, 0, 0)
        local v20 = CFrame.Angles
        local v21 = math.random(-15, 15)
        local v22 = math.rad(v21)
        local v23 = math.random(-15, 15)
        local v24 = math.rad(v23)
        local v25 = math.random(-15, 15)
        v18:PivotTo(v19 * v20(v22, v24, (math.rad(v25))))
        table.insert(v15, v18)
        v18.Parent = workspace.Effects
    end
    for v26 = 1, 6 do
        local v27 = v26 / 6 * 360 + u8:NextNumber(-10, 10)
        local v28 = u5.Rock2:Clone()
        local v29 = p14 * CFrame.new(0, u8:NextNumber(-2.4, -2), 0) * CFrame.Angles(0, math.rad(v27), 0) * CFrame.new(0, 0, -6.5) * CFrame.Angles(0.08726646259971647, 0, 0)
        local v30 = CFrame.Angles
        local v31 = math.random(-5, 5)
        local v32 = math.rad(v31)
        local v33 = math.random(-15, 15)
        local v34 = math.rad(v33)
        local v35 = math.random(-15, 15)
        v28:PivotTo(v29 * v30(v32, v34, (math.rad(v35))))
        table.insert(v15, v28)
        v28.Parent = workspace.Effects
    end
    return v15
end
function animateCrater(u36)
    --[[
    Upvalues:
        [1] = u9
        [2] = u3
        [3] = u8
    --]]
    for v37, v38 in pairs(u36) do
        local v39 = workspace:Raycast(v38.PrimaryPart.Position + Vector3.new(0, 6, 0), Vector3.new(0, -8, 0), u9)
        if v39 then
            _G.matchMaterial(v38.Top, v39.Instance)
            v38:PivotTo(v38.PrimaryPart.CFrame * CFrame.new(0, -4, 0))
            local v40 = 0.03333333333333333 + math.random(0, 50) / 1000
            if v38.Name == "Rock1" then
                v40 = v40 + 0.08333333333333333
            end
            _G.tween(v38.PrimaryPart, { v40, "Quint", Enum.EasingDirection.Out }, {
                ["CFrame"] = v38.PrimaryPart.CFrame * CFrame.new(0, 4, 0)
            })
        else
            v38:Destroy()
            u36[v37] = nil
        end
    end
    task.delay(1.5, function() --[[ Line: 74 ]]
        --[[
        Upvalues:
            [1] = u36
            [2] = u3
            [3] = u8
        --]]
        shuffle(u36)
        for _, v41 in pairs(u36) do
            task.wait(0.03333333333333333)
            local v42 = v41.Name == "Rock2" and 0.75 or 1.25
            local v43 = u3
            local v44 = v41.PrimaryPart
            local v45 = TweenInfo.new(v42 + u8:NextNumber(0, 0.5), Enum.EasingStyle.Back, Enum.EasingDirection.InOut)
            local v46 = {}
            local v47 = v41.PrimaryPart.CFrame
            local v48 = u8:NextNumber(-2, -6)
            v46.CFrame = v47 + Vector3.new(0, v48, 0)
            v43:Create(v44, v45, v46):Play()
            _G.destroy(v41, 4)
        end
    end)
end
function trails(p49, u50, u51)
    --[[
    Upvalues:
        [1] = u8
        [2] = u5
        [3] = u2
        [4] = u3
    --]]
    task.wait(u8:NextNumber(0, 0.3))
    local u52 = u5.TrailPart:Clone()
    local v53 = u8:NextNumber(4, 8)
    local v54 = Vector3.new(v53, 0, 0)
    local v55 = u8:NextNumber(-4, 4)
    local v56 = Vector3.new(v55, 0, 0)
    local v57 = u52.Attachment1
    v57.Position = v57.Position + v54
    local v58 = u52.Attachment2
    v58.Position = v58.Position + v54
    u52.Trail.Color = p49
    u52.CFrame = u50
    local u59 = 0
    local u60 = u8:NextNumber(0.5, 1)
    local u61 = u50 * CFrame.new(0, u8:NextNumber(1, 5), 0)
    local u62 = u8:NextNumber(200, 500)
    local u63 = nil
    u63 = u2.Heartbeat:Connect(function(p64) --[[ Line: 99 ]]
        --[[
        Upvalues:
            [1] = u59
            [2] = u60
            [3] = u3
            [4] = u52
            [5] = u50
            [6] = u61
            [7] = u62
            [8] = u51
            [9] = u63
        --]]
        u59 = u59 + p64
        local v65 = u59 / u60
        local v66 = math.clamp(v65, 0, 1)
        local v67 = u3:GetValue(v66, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local v68 = u3:GetValue(v66, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local v69 = u52
        local v70 = u50:Lerp(u61, v67)
        local v71 = CFrame.Angles
        local v72 = u62 * v68 * u51
        v69.CFrame = v70 * v71(0, math.rad(v72), 0)
        if u60 <= u59 then
            u63:Disconnect()
        end
    end)
    local v73 = { 0.7, "Circular", Enum.EasingDirection.Out }
    _G.tween(u52.Attachment1, v73, {
        ["Position"] = u52.Attachment1.Position + v56
    })
    _G.tween(u52.Attachment2, v73, {
        ["Position"] = u52.Attachment2.Position + v56
    })
    u52.Parent = workspace.Effects
    task.delay(u8:NextNumber(0.1, 0.6), function() --[[ Line: 114 ]]
        --[[
        Upvalues:
            [1] = u52
            [2] = u8
        --]]
        _G.tween(u52.Trail, { u8:NextNumber(0.2, 0.5), "Sine", Enum.EasingDirection.Out }, {
            ["WidthScale"] = NumberSequence.new(0)
        })
    end)
    _G.destroy(u52, 2)
end
function debrisRock(p74, p75, p76)
    --[[
    Upvalues:
        [1] = u8
    --]]
    local v77 = workspace:Raycast(p75.Position + Vector3.new(0, 6, 0), Vector3.new(0, -8, 0), rockRaycastParams)
    if v77 then
        local v78 = p74:Clone()
        v78:PivotTo(CFrame.new(v77.Position) * CFrame.Angles(u8:NextNumber(0, 6.283185307179586), u8:NextNumber(0, 6.283185307179586), u8:NextNumber(0, 6.283185307179586)))
        _G.matchMaterial(v78.Bot, v77.Instance)
        local v79 = math.random(50, 125) / 100
        local v80 = v78.Bot
        v80.Size = v80.Size * v79
        v78.Bot.Trail.Color = ColorSequence.new(v78.Bot.Color)
        v78.Parent = workspace.Effects
        local v81 = v78.Bot
        local v82 = u8:NextNumber(-1, 1)
        local v83 = u8:NextNumber(0, 1)
        local v84 = u8
        v81:ApplyImpulse(Vector3.new(v82, v83, v84:NextNumber(-1, 1)) * p76 / 2)
        _G.destroy(v78, 5)
    end
end
function v6.start(_, u85, _, u86) --[[ Line: 139 ]]
    --[[
    Upvalues:
        [1] = u7
        [2] = u5
        [3] = u8
        [4] = u4
    --]]
    if _G.checkRenderDistance(u85.PrimaryPart.Position) ~= false then
        local u87 = u85.HumanoidRootPart
        _G.PlaySound(u87, script.DragonDashGrabSmash)
        local u88 = CFrame.new(0, 0, -2)
        task.delay(u7.chargeUp, function() --[[ Line: 148 ]]
            --[[
            Upvalues:
                [1] = u85
                [2] = u86
            --]]
            require(script.Parent.ChargeEffect)(u85.RightHand, u86, 4, 10, 10)
        end)
        task.delay(u7.groundFlash, function() --[[ Line: 152 ]]
            --[[
            Upvalues:
                [1] = u86
                [2] = u87
                [3] = u88
                [4] = u5
                [5] = u8
            --]]
            if u86 then
                local u89 = u87.CFrame * u88 * CFrame.new(0, -2.9, 0)
                for u90 = 1, 50 do
                    task.spawn(function() --[[ Line: 156 ]]
                        --[[
                        Upvalues:
                            [1] = u5
                            [2] = u89
                            [3] = u8
                            [4] = u90
                        --]]
                        local v91 = u5.Flash:Clone()
                        v91.Parent = workspace.Effects
                        local v92 = u89
                        local v93 = CFrame.Angles
                        local v94 = u8:NextNumber(0, 360)
                        v91.CFrame = v92 * v93(0, math.rad(v94), 0) * CFrame.new(0, u90 / 100, 0)
                        v91.Size = v91.Size * u8:NextNumber(0.75, 1.25)
                        local v95 = u8:NextNumber(0.1, 0.6)
                        _G.tween(v91, { v95, "Quad", Enum.EasingDirection.Out }, {
                            ["Size"] = v91.Size * 2
                        })
                        _G.tween(v91.Decal, { v95, "Sine", Enum.EasingDirection.Out }, {
                            ["Transparency"] = 1
                        })
                        _G.destroy(v91, 2)
                    end)
                end
                local v96 = u5.Flare:Clone()
                v96.Parent = workspace.Effects
                v96.CFrame = u89
                v96.Attachment.Flare:Emit(25)
                _G.destroy(v96, 1)
                local v97 = u5.ScorchMark:Clone()
                v97.Parent = workspace.Effects
                v97.CFrame = u89 * CFrame.new(0, -0.00999, 0)
                _G.tween(v97.Decal, { 4, "Quint", Enum.EasingDirection.In }, {
                    ["Transparency"] = 1
                })
                _G.destroy(v97, 4)
            end
            local v98 = u5.Light:Clone()
            v98.Parent = workspace.Effects
            v98.CFrame = u87.CFrame * u88 * CFrame.new(0, 16, 0)
            v98.SpotLight.Brightness = 0
            if u86 == false then
                v98.SpotLight.Color = Color3.fromRGB(255, 255, 255)
            end
            _G.tween(v98.SpotLight, { 0.25, "Quad", Enum.EasingDirection.Out }, {
                ["Brightness"] = u5.Light.SpotLight.Brightness
            })
            task.wait(1.25)
            _G.tween(v98.SpotLight, { 1, "Quad", Enum.EasingDirection.InOut }, {
                ["Brightness"] = 0
            })
            _G.destroy(v98, 1)
        end)
        task.delay(u7.wind, function() --[[ Line: 195 ]]
            --[[
            Upvalues:
                [1] = u5
                [2] = u86
                [3] = u87
                [4] = u88
                [5] = u8
            --]]
            local v99 = u5.Wind:Clone()
            if u86 == false then
                v99.Decal.Color3 = Color3.fromRGB(500, 500, 500)
            end
            v99.Parent = workspace.Effects
            local v100 = u87.CFrame * u88 * CFrame.new(0, -2, 0)
            local v101 = CFrame.Angles
            local v102 = u8:NextNumber(0, 360)
            v99.CFrame = v100 * v101(0, math.rad(v102), 0)
            _G.tween(v99.Mesh, { 0.8, "Quart", Enum.EasingDirection.Out }, {
                ["Scale"] = v99.Mesh.Scale * Vector3.new(1.5, 0.5, 1.5)
            })
            _G.tween(v99, { 0.8, "Sine", Enum.EasingDirection.Out }, {
                ["CFrame"] = v99.CFrame * CFrame.new(0, -2, 0) * CFrame.Angles(0, 2.0943951023931953, 0)
            })
            _G.tween(v99.Decal, { 0.8, "Quad", Enum.EasingDirection.In }, {
                ["Transparency"] = 1
            })
            _G.destroy(v99, 1)
            local v103 = u5.BlackWind:Clone()
            v103.Parent = workspace.Effects
            local v104 = u87.CFrame * u88 * CFrame.new(0, -2.75, 0)
            local v105 = CFrame.Angles
            local v106 = u8:NextNumber(0, 360)
            v103.CFrame = v104 * v105(0, math.rad(v106), 0)
            _G.tween(v103.Mesh, { 1, "Quart", Enum.EasingDirection.Out }, {
                ["Scale"] = v103.Mesh.Scale * Vector3.new(1.75, 1, 1.75)
            })
            _G.tween(v103, { 1, "Quad", Enum.EasingDirection.Out }, {
                ["CFrame"] = v103.CFrame * CFrame.new(0, -0.5, 0) * CFrame.Angles(0, -2.0943951023931953, 0)
            })
            _G.tween(v103.Decal, { 1, "Quad", Enum.EasingDirection.Out }, {
                ["Transparency"] = 1
            })
            _G.destroy(v103, 1)
        end)
        task.delay(u7.slam, function() --[[ Line: 216 ]]
            --[[
            Upvalues:
                [1] = u5
                [2] = u86
                [3] = u87
                [4] = u88
                [5] = u4
                [6] = u8
            --]]
            local v107 = u5.GroundParticles:Clone()
            if u86 == false then
                v107.Attachment.ColoredRings.Color = ColorSequence.new(Color3.new(1, 1, 1))
                v107.Attachment.Smoke.Color = ColorSequence.new(Color3.new(1, 1, 1))
                v107.ColoredBalls.Color = ColorSequence.new(Color3.new(1, 1, 1))
            end
            v107.Parent = workspace.Effects
            v107.CFrame = u87.CFrame * CFrame.new(0, -2.9, 0) * u88
            u4:Emit(v107)
            _G.destroy(v107, 2)
            for _ = 1, 25 do
                debrisRock(u5.DebrisRock, u87.CFrame * CFrame.new(0, -3, 0) * u88 * CFrame.new(u8:NextNumber(-2, 2), 0, u8:NextNumber(-2, 2)), Vector3.new(0.1, 0.4, 0.1))
            end
            for v108 = 1, 12 do
                local v109 = v108 / 12 * 360
                local u110
                if v108 % 2 == 0 then
                    u110 = u86 and ColorSequence.new(Color3.fromRGB(255, 54, 28)) or ColorSequence.new(Color3.fromRGB(255, 255, 255))
                else
                    u110 = ColorSequence.new(Color3.fromRGB(0, 0, 0))
                end
                local u111 = u87.CFrame * CFrame.new(0, -2.9, 0) * u88 * CFrame.Angles(0, math.rad(v109), 0)
                task.spawn(function() --[[ Line: 242 ]]
                    --[[
                    Upvalues:
                        [1] = u110
                        [2] = u111
                    --]]
                    trails(u110, u111, -1)
                end)
                task.spawn(function() --[[ Line: 245 ]]
                    --[[
                    Upvalues:
                        [1] = u110
                        [2] = u111
                    --]]
                    trails(u110, u111, 1)
                end)
            end
            local v112 = u8:NextNumber(0, 180)
            for v113 = 1, 2 do
                local u114 = u5.Crack:Clone()
                if u86 == false then
                    u114.Decal.Color3 = Color3.new(0, 0, 0)
                end
                u114.Parent = workspace.Effects
                local v115 = u87.CFrame * CFrame.new(0, -2.9, 0) * u88
                local v116 = CFrame.Angles
                local v117 = v112 + v113 * 180
                u114.CFrame = v115 * v116(0, math.rad(v117), 0)
                local v118 = u8:NextNumber(24, 28)
                u114.Size = Vector3.new(v118, 0.05, v118)
                task.delay(0.5, function() --[[ Line: 260 ]]
                    --[[
                    Upvalues:
                        [1] = u114
                        [2] = u8
                    --]]
                    _G.tween(u114.Decal, { 1.6 + u8:NextNumber(0, 0.2), "Quint", Enum.EasingDirection.In }, {
                        ["Transparency"] = 1
                    })
                    _G.tween(u114.Black, { 3 + u8:NextNumber(0, 0.4), "Quad", Enum.EasingDirection.InOut }, {
                        ["Transparency"] = 1
                    })
                    _G.destroy(u114, 4)
                end)
            end
            local v119 = crater(u87.CFrame * CFrame.new(0, -2.5, 0) * u88)
            animateCrater(v119)
        end)
    end
end
return v6