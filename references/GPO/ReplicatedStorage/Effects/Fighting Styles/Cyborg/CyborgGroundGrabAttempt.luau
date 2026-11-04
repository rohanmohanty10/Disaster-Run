 

local u1 = game:GetService("RunService")
local u2 = require(game.ReplicatedStorage.Modules.Client.WeaponVFXRecolor)
local v3 = {}
local u4 = RaycastParams.new()
u4.FilterType = Enum.RaycastFilterType.Whitelist
u4.FilterDescendantsInstances = { workspace.Islands, workspace.Env, workspace.Ships }
local function u10(p5, p6) --[[ Line: 8 ]]
    local v7 = { p5 }
    for _, v8 in p5:GetDescendants() do
        table.insert(v7, v8)
    end
    for _, v9 in v7 do
        if (v9:IsA("ParticleEmitter") or (v9:IsA("BasePart") or (v9:IsA("PointLight") or (v9:IsA("Trail") or (v9:IsA("Highlight") or v9:IsA("Decal")))))) and v9:GetAttribute("recolorable") then
            if v9:IsA("Trail") or v9:IsA("ParticleEmitter") then
                v9.Color = ColorSequence.new(p6)
            elseif v9:IsA("Highlight") then
                v9.FillColor = p6
                v9.OutlineColor = Color3.new(1, 1, 1)
            elseif v9:IsA("Decal") then
                v9.Color3 = p6
            else
                v9.Color = p6
            end
        end
    end
    table.clear(v7)
end
function v3.start(_, u11, p12, u13) --[[ Line: 32 ]]
    --[[
    Upvalues:
        [1] = u10
        [2] = u2
        [3] = u4
        [4] = u1
    --]]
    if _G.checkRenderDistance(u11.PrimaryPart.Position) ~= false then
        local u14 = u11.PrimaryPart
        local u15 = u14.CFrame
        local u16 = p12.PrimaryPart.CFrame
        local v17 = {
            "RightFoot",
            "LeftFoot",
            "RightLowerLeg",
            "LeftLowerLeg"
        }
        for _, v18 in u11:GetChildren() do
            if table.find(v17, v18.Name) then
                local u19 = script.aura:Clone()
                u10(u19, u13)
                u2.apply(u19, u11)
                u19.Parent = v18
                task.delay(0.4, function() --[[ Line: 46 ]]
                    --[[
                    Upvalues:
                        [1] = u19
                    --]]
                    u19.Enabled = false
                    _G.destroy(u19, 3)
                end)
            end
        end
        local function u40(p20, _) --[[ Line: 52 ]]
            --[[
            Upvalues:
                [1] = u14
                [2] = u4
                [3] = u10
                [4] = u13
                [5] = u2
                [6] = u11
            --]]
            local v21 = p20 or u14.CFrame
            local v22 = workspace:Raycast(v21.Position, v21.UpVector * Vector3.new(0, -10, 0), u4)
            if v22 then
                local v23 = script.Rocks:GetChildren()
                local v24 = v23[math.random(1, #v23)]:Clone()
                v24:PivotTo(v21)
                v24.Floor.Color = v22.Instance.Color
                v24.Parent = workspace.Effects
                local v25 = math.random(-1, 1)
                local v26 = v25 == 0 and -1 or v25
                local v27 = v24.Rock
                local v28 = v21.LookVector * math.random(-60, -25)
                local v29 = v26 * math.random(30, 70)
                local v30 = math.random(25, 60)
                v27.Velocity = v28 + Vector3.new(v29, v30, 0) / 1.25
                local v31 = v24.Rock
                local v32 = math.random(-5, 5)
                local v33 = math.random(-5, 5)
                local v34 = math.random
                v31.RotVelocity = Vector3.new(v32, v33, v34(-5, 5)) * 1.6
                local v35 = nil
                local v36 = nil
                for _, v37 in ipairs(script.rocktrail:GetChildren()) do
                    local v38 = v37:Clone()
                    if v38.Name == "A0" then
                        v35 = v38.Trail
                        v35.Attachment0 = v38
                    else
                        v36 = v38
                    end
                    v38.Parent = v24.Rock
                end
                for _, v39 in ipairs(script.rockfire:GetChildren()) do
                    v39:Clone().Parent = v24.Rock
                end
                v35.Attachment1 = v36
                u10(v24, u13)
                u2.apply(v24, u11)
                _G.destroy(v24, 5)
            end
        end
        local u41 = Instance.new("Highlight")
        u41.OutlineTransparency = 1
        u41.DepthMode = Enum.HighlightDepthMode.Occluded
        u41.FillTransparency = 1
        u41.OutlineColor = u13
        u41.FillColor = u13
        u10(u41, u13)
        u41:SetAttribute("UniqueID", "e1a2b3c4-d5e6-4f78-9012-000000000001")
        u2.apply(u41, u11)
        u41.Parent = u11
        _G.tween(u41, {
            0.35,
            "EntranceExpressive",
            Enum.EasingDirection.In,
            0,
            false,
            0
        }, {
            ["OutlineTransparency"] = 0,
            ["FillTransparency"] = 0.5
        })
        _G.destroy(u41, 1)
        task.wait(0.37)
        local v42 = u14.CFrame
        u40(v42)
        u40(v42)
        u40(v42)
        for u43 = 1, 2 do
            task.spawn(function() --[[ Line: 122 ]]
                --[[
                Upvalues:
                    [1] = u10
                    [2] = u13
                    [3] = u2
                    [4] = u11
                    [5] = u15
                    [6] = u43
                    [7] = u14
                --]]
                local v44 = script.trail:Clone()
                u10(v44, u13)
                u2.apply(v44, u11)
                v44.CFrame = u15 * CFrame.new(0, 0, -10)
                v44.Parent = workspace.Effects
                for v45 = 0, 1000, 45 do
                    local v46 = 8 - v45 / 100
                    local v47 = u43 == 1 and v45 and v45 or -v45
                    local v48 = u14.CFrame
                    local v49 = CFrame.new
                    local v50 = math.rad(v45)
                    local v51 = v46 * math.cos(v50)
                    local v52 = math.rad(v47)
                    v44.CFrame = v48 * v49(v51, v46 * math.sin(v52), 0)
                    task.wait()
                end
                _G.destroy(v44, 1)
            end)
        end
        local v53 = script["Meshes/Rasengan Shockwave_Cylinder.002"]:Clone()
        u10(v53, u13)
        u2.apply(v53, u11)
        local v54 = u15 * CFrame.new(0, 0, -1)
        local v55 = CFrame.Angles
        local v56 = math.random(0, 180)
        v53.CFrame = v54 * v55(1.5707963267948966, math.rad(v56), 0)
        v53.Size = Vector3.new(14, 23, 14)
        v53.Parent = workspace.Effects
        local v57 = _G.tween
        local v58 = {
            0.5,
            "Exponential",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }
        local v59 = {}
        local v60 = v53.Size.Y
        v59.Size = Vector3.new(0, v60, 0)
        local v61 = u15 * CFrame.new(0, 0, -(v53.Size.Y / 2))
        local v62 = CFrame.Angles
        local v63 = math.random(0, 180)
        v59.CFrame = v61 * v62(1.5707963267948966, math.rad(v63), 0)
        v57(v53, v58, v59)
        _G.destroy(v53, 0.5)
        local v64 = script.stars:Clone()
        u10(v64, u13)
        u2.apply(v64, u11)
        v64.CFrame = u15
        v64.Parent = workspace.Effects
        _G.tween(v64.PointLight, {
            0.4,
            "Quad",
            Enum.EasingDirection.In,
            0,
            false,
            0
        }, {
            ["Brightness"] = 0
        })
        local v65 = workspace:Raycast(u14.Position, u14.CFrame.UpVector * Vector3.new(0, -10, 0), u4)
        if v65 then
            local u66 = script.bigfloorFire:Clone()
            u10(u66, u13)
            u2.apply(u66, u11)
            local v67 = CFrame.new(v65.Position, v65.Position + v65.Normal)
            local v68 = CFrame.Angles
            local v69 = math.random(0, 360)
            u66.CFrame = v67 * v68(-1.5707963267948966, math.rad(v69), 0)
            u66.Parent = workspace.Effects
            task.delay(1 + math.random(100, 140) / 100, function() --[[ Line: 162 ]]
                --[[
                Upvalues:
                    [1] = u66
                --]]
                for _, v70 in ipairs(u66:GetChildren()) do
                    v70.Enabled = false
                end
                _G.destroy(u66, 4)
            end)
        end
        _G.customEmit(v64)
        task.delay(0.05, function() --[[ Line: 168 ]]
            --[[
            Upvalues:
                [1] = u10
                [2] = u13
                [3] = u2
                [4] = u11
                [5] = u14
                [6] = u1
                [7] = u4
                [8] = u40
                [9] = u41
                [10] = u16
            --]]
            local u71 = script.tings:Clone()
            u10(u71, u13)
            u2.apply(u71, u11)
            u71.Parent = workspace.Effects
            local u72 = script.floortrail:Clone()
            u10(u72, u13)
            u2.apply(u72, u11)
            u72.Parent = workspace.Effects
            u72.CFrame = u14.CFrame
            _G.destroy(u72, 5)
            local u73 = script.Rush:Clone()
            u10(u73, u13)
            u2.apply(u73, u11)
            u73.Parent = workspace.Effects
            _G.tween(u73.Colored, {
                0.35,
                "ExitExpressive",
                Enum.EasingDirection.In,
                0,
                false,
                0
            }, {
                ["Transparency"] = 1
            })
            _G.tween(u73.Black, {
                0.35,
                "ExitExpressive",
                Enum.EasingDirection.In,
                0,
                false,
                0
            }, {
                ["Transparency"] = 1
            })
            _G.tween(u73.Mesh, {
                0.2,
                "EntranceExpressive",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Scale"] = Vector3.new(5.5, 45, 5.5)
            })
            local u74 = 0
            local u75 = u14.Position
            local u76 = nil
            local u89 = u1.Heartbeat:Connect(function(_) --[[ Line: 194 ]]
                --[[
                Upvalues:
                    [1] = u76
                    [2] = u14
                    [3] = u4
                    [4] = u73
                    [5] = u71
                    [6] = u72
                    [7] = u75
                    [8] = u74
                    [9] = u10
                    [10] = u13
                    [11] = u2
                    [12] = u11
                --]]
                u76 = workspace:Raycast(u14.Position, u14.CFrame.UpVector * Vector3.new(0, -10, 0), u4)
                u73.CFrame = u14.CFrame * CFrame.Angles(1.5707963267948966, 0, 0) * CFrame.new(0, -8, 0) * CFrame.new(0, u73.Mesh.Scale.Y / 2.25, 0)
                u71.CFrame = u14.CFrame * CFrame.Angles(1.5707963267948966, 0, 0)
                if u76 then
                    local v77 = u72
                    local v78 = CFrame.new
                    local v79 = u76.Position
                    local v80 = u14.CFrame.LookVector.X
                    local v81 = u76.Position.Y
                    local v82 = u14.CFrame.LookVector.Z
                    v77.CFrame = v78(v79, (Vector3.new(v80, v81, v82))) * CFrame.new(0, 0.5, 0)
                else
                    u72:Destroy()
                end
                local v83 = u74 + (u75 - u14.Position).Magnitude
                u74 = math.clamp(v83, 0, 1.75)
                if u74 == 1.75 then
                    u74 = 0
                    if u76 then
                        local u84 = script.floorFire:Clone()
                        u10(u84, u13)
                        u2.apply(u84, u11)
                        local v85 = CFrame.new(u76.Position, u76.Position + u76.Normal)
                        local v86 = CFrame.Angles
                        local v87 = math.random(0, 360)
                        u84.CFrame = v85 * v86(-1.5707963267948966, math.rad(v87), 0)
                        u84.Parent = workspace.Effects
                        task.delay(1 + math.random(60, 200) / 100, function() --[[ Line: 216 ]]
                            --[[
                            Upvalues:
                                [1] = u84
                            --]]
                            for _, v88 in ipairs(u84:GetChildren()) do
                                v88.Enabled = false
                            end
                            _G.destroy(u84, 4)
                        end)
                    end
                end
                u75 = u14.Position
            end)
            task.spawn(function() --[[ Line: 224 ]]
                --[[
                Upvalues:
                    [1] = u40
                    [2] = u10
                    [3] = u13
                    [4] = u2
                    [5] = u11
                    [6] = u14
                --]]
                local v90 = tick()
                while tick() - v90 < 0.35 do
                    u40()
                    local v91 = script.swirltwo:Clone()
                    u10(v91, u13)
                    u2.apply(v91, u11)
                    local v92 = u14.CFrame
                    local v93 = CFrame.Angles
                    local v94 = math.random(0, 180)
                    v91.CFrame = v92 * v93(-1.5707963267948966, math.rad(v94), 0)
                    v91.Parent = workspace.Effects
                    _G.tween(v91, {
                        0.4,
                        "EntranceProductive",
                        Enum.EasingDirection.Out,
                        0,
                        false,
                        0
                    }, {
                        ["Size"] = Vector3.new(25, 0.15, 25),
                        ["Transparency"] = 1,
                        ["Color"] = Color3.new(0, 0, 0),
                        ["CFrame"] = v91.CFrame * CFrame.new(0, 1.5707963267948966, 0)
                    })
                    _G.destroy(v91, 0.6)
                    task.wait(0.05)
                end
            end)
            task.delay(0.35, function() --[[ Line: 247 ]]
                --[[
                Upvalues:
                    [1] = u71
                    [2] = u41
                    [3] = u89
                    [4] = u73
                --]]
                for _, v95 in ipairs(u71:GetDescendants()) do
                    if v95:IsA("ParticleEmitter") or (v95:IsA("Trail") or v95:IsA("PointLight")) then
                        v95.Enabled = false
                    end
                end
                _G.tween(u41, {
                    0.4,
                    "EntranceExpressive",
                    Enum.EasingDirection.In,
                    0,
                    false,
                    0
                }, {
                    ["OutlineTransparency"] = 1,
                    ["FillTransparency"] = 1
                })
                u89:Disconnect()
                _G.destroy(u73, 4)
                _G.destroy(u71, 4)
            end)
            _G.tween(u11.PrimaryPart, {
                0.3,
                "EntranceExpressive",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["CFrame"] = u16 * CFrame.new(0, 0, -1.75) * CFrame.Angles(0, 3.141592653589793, 0)
            })
        end)
        _G.destroy(v64, 5)
    end
end
return v3