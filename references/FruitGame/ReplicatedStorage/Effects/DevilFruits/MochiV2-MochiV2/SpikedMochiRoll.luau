 

local v1 = {}
local _ = workspace.Effects
local _ = game["Run Service"]
local u2 = game:GetService("TweenService")
game:GetService("TweenService")
local u3 = require(game.ReplicatedStorage.Modules.Client.WeaponVFXRecolor)
local u4 = RaycastParams.new()
u4.FilterType = Enum.RaycastFilterType.Include
local v5 = OverlapParams.new()
v5.FilterType = Enum.RaycastFilterType.Include
u4.FilterDescendantsInstances = { workspace.Env, workspace.Ships, workspace.Islands }
v5.FilterDescendantsInstances = { workspace.Env, workspace.Ships, workspace.Islands }
u4.RespectCanCollide = true
v5.RespectCanCollide = true
function v1.start(_, u6, u7, p8) --[[ Line: 18 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u4
        [3] = u2
    --]]
    local u9 = 0
    local u10 = 120
    local u11 = 0
    local v12 = script.DonutWheel:Clone()
    v12:SetPrimaryPartCFrame(u6.PrimaryPart.CFrame)
    local u13 = v12.PrimaryPart
    local u14 = os.clock()
    local v15 = u13.Attachment
    local u16 = u13.BotR
    local u17 = u13.BotL
    local u18 = u13.jumpVFX
    local u19 = u6 == game.Players.LocalPlayer.Character
    local u20 = u6.PrimaryPart
    local u21 = Instance.new("Motor6D")
    u21.Part0 = u6.PrimaryPart
    u21.Part1 = v12.PrimaryPart
    u21.C0 = CFrame.new(0, 2, 0)
    u21.C1 = CFrame.Angles(0, 1.5707963267948966, 0)
    u21.Parent = u13
    v12:ScaleTo(0.01)
    if p8 then
        v12.Haki.Color = p8
        v12.Haki.Transparency = 0
    end
    u3.apply(v12, u6)
    v12.Parent = workspace.Effects
    _G.PlayEffect("TweenModel", nil, v12, TweenInfo.new(0.4, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), 1.75)
    local v22 = script.Start:Clone()
    u3.apply(v22, u6)
    v22.CFrame = u13.CFrame
    v22.Parent = workspace.Effects
    _G.customEmit(v22)
    _G.destroy(v22, 2)
    _G.PlayEffect("MochiImpactDroplet", nil, u13.CFrame, 8, 1.5, 35, 0.4, 0.75, nil, u6)
    local u23 = v15:GetChildren()
    local u24 = CFrame.new(0, -4, 0)
    task.delay(0.2, function() --[[ Line: 70 ]]
        --[[
        Upvalues:
            [1] = u17
            [2] = u24
            [3] = u6
            [4] = u16
        --]]
        u17.CFrame = u24
        u17.Parent = u6.PrimaryPart
        u16.Parent = u6.PrimaryPart
    end)
    os.clock()
    local u25 = u20.Position.Y
    local u26 = nil
    local u27 = false
    local u28 = os.clock()
    local u29 = script["Audio/MochiV2WheelLoop"]:Clone()
    u29.Parent = u6.PrimaryPart
    u29:Play()
    _G.PlaySound(u6.PrimaryPart, script["Audio/MochiV2WheelStart"]).Parent = u6.PrimaryPart
    task.wait(0.4)
    local u30 = Random.new()
    local u31 = u6.Humanoid
    local v125 = game["Run Service"].Stepped:Connect(function(_, p32) --[[ Line: 142 ]]
        --[[
        Upvalues:
            [1] = u20
            [2] = u13
            [3] = u4
            [4] = u19
            [5] = u31
            [6] = u9
            [7] = u18
            [8] = u3
            [9] = u6
            [10] = u10
            [11] = u23
            [12] = u11
            [13] = u21
            [14] = u29
            [15] = u14
            [16] = u17
            [17] = u30
            [18] = u27
            [19] = u26
            [20] = u28
            [21] = u7
            [22] = u24
            [23] = u25
        --]]
        local v33 = u20.CFrame
        local v34 = u13.Size.X * 0.8 / 2
        local v35 = u20.CFrame.LookVector * -v34
        local v36 = u13.CFrame * CFrame.Angles(0, 1.5707963267948966, 0) + v35
        local _ = u13.Size * 0.8
        local v37 = u20.CFrame.LookVector * v34 * 2
        local v38 = u4
        local v39 = workspace:Spherecast(v36.Position, 4.3, v37, v38)
        if u19 == true then
            local v40 = u31.MoveDirection
            local v41 = v40.X
            local v42 = v40.Z
            local v43 = Vector3.new(v41, 0, v42)
            local v44
            if v43.Magnitude == 0 then
                v44 = v33.LookVector
            else
                v44 = v43.Unit
            end
            local v45 = v44.X
            local v46 = v44.Z
            local v47 = math.atan2(v45, v46)
            local _ = CFrame.new(u20.Position) * CFrame.Angles(0, v47, 0)
            local v48 = u9 * (u31.Health / u31.MaxHealth)
            if u31:GetState() == Enum.HumanoidStateType.Jumping then
                local v49 = u20
                local v50 = v44.X
                local v51 = 1 * v48
                local v52 = v44.Z
                v49.AssemblyLinearVelocity = Vector3.new(v50, v51, v52)
                local v53 = u18:Clone()
                u3.apply(v53, u6)
                local v54 = CFrame.new
                local v55 = u13.Position
                local v56 = u13.Size.Y / 2
                v53.WorldCFrame = v54(v55 - Vector3.new(0, v56, 0))
                v53.Parent = workspace.Terrain
                _G.customEmit(v53)
                _G.destroy(v53, 4)
                _G.PlaySound(u20, script.MochiV2WheelJump, {
                    ["RandomPitch"] = true
                }).Parent = u20
            else
                local v57 = u20.CFrame * CFrame.new(0, u20.Size.Y / 2, 0)
                local _ = u13.Size * Vector3.new(0.8, 0.2, 0.8)
                local v58 = u13.Size.Y * 0.8
                local v59 = Vector3.new(0, v58, 0)
                local v60 = u4
                local v61 = workspace:Spherecast(v57.Position, 4.3, v59, v60)
                if v39 or v39 ~= nil and v61 then
                    local v62 = false
                    local v63 = false
                    if v39 then
                        local v64 = v39.Position.Y
                        local v65 = u20.Position.Y - u20.Size.Y / 2
                        local v66 = u13.Size.Y
                        local v67 = v65 - v66 / 2
                        local v68 = v65 + v66 / 2
                        local v69 = v39.Normal.Y
                        local v70 = v39.Normal:Dot(v33.LookVector)
                        v62 = v67 <= v64 and (v64 <= v68 and (v69 < 0.7 and v70 < -0.5)) and true or v62
                    end
                    if v61 then
                        local v71 = v61.Position.X - u20.Position.X
                        if math.abs(v71) < 1 then
                            local v72 = v61.Position.Z - u20.Position.Z
                            v63 = math.abs(v72) < 1 and true or v63
                        end
                    end
                    if v62 then
                        local v73 = u20
                        local v74 = v40.X * v48 / 2
                        local v75 = v40.Z * v48 / 2
                        v73.AssemblyLinearVelocity = Vector3.new(v74, v48, v75)
                    elseif v63 then
                        local v76 = u20
                        local v77 = -v33.LookVector.X * v48 * 2
                        local v78 = v48 * 1.8
                        local v79 = -v33.LookVector.Z * v48 * 2
                        v76.AssemblyLinearVelocity = Vector3.new(v77, v78, v79)
                    else
                        local v80 = u20.AssemblyLinearVelocity
                        local v81 = u20
                        local v82 = v44.X * v48
                        local v83 = v80.Y
                        local v84 = v44.Z * v48
                        v81.AssemblyLinearVelocity = Vector3.new(v82, v83, v84)
                    end
                else
                    local v85 = u20.AssemblyLinearVelocity
                    local v86 = u20
                    local v87 = v44.X * v48
                    local v88 = v85.Y
                    local v89 = v44.Z * v48
                    v86.AssemblyLinearVelocity = Vector3.new(v87, v88, v89)
                end
            end
            local v90 = u20.AssemblyLinearVelocity.X
            local v91 = u20.AssemblyLinearVelocity.Z
            local v92 = Vector3.new(v90, 0, v91)
            if v92.Magnitude > 0 then
                local v93 = v92.Unit
                u20.CFrame = v33:Lerp(CFrame.new(v33.Position, v33.Position + v93), p32 * 10)
            end
            u20.AssemblyAngularVelocity = Vector3.new()
        end
        if u6:FindFirstChild("inCombat") == nil then
            u10 = 180
        else
            u10 = 120
        end
        local v94 = u20.AssemblyLinearVelocity.Magnitude / u10
        local v95 = math.clamp(v94, 0, 1)
        for v96 = 1, #u23 do
            if v95 >= 0.3 then
                u23[v96].Rate = v95 * 15
            else
                u23[v96].Rate = 0
            end
        end
        if u9 < u10 and (u31.FloorMaterial ~= Enum.Material.Air or v39 and v39.Instance ~= nil) then
            local v97 = -4 * p32 / 5
            local v98 = 1 - math.exp(v97)
            u9 = u9 + (u10 - u9) * v98
        end
        u11 = v95 * 800
        local v99 = u21
        local v100 = v99.C1
        local v101 = CFrame.Angles
        local v102 = p32 * u11
        v99.C1 = v100 * v101(math.rad(v102), 0, 0)
        u29.Pitch = v95
        if os.clock() - u14 >= u10 / u9 / 13 and v95 >= 0.5 then
            local v103, v104
            if v39 == nil then
                local v105
                v103, v104, v105 = _G.getRayFloor(u17.WorldCFrame, 5)
            else
                v103 = v39.Instance
                v104 = v39.Position
                local _ = v39.Normal
            end
            if v103 then
                local v106 = -u20.AssemblyLinearVelocity.Unit
                local v107 = u30:NextInteger(-2, 2)
                local v108 = u30
                local v109 = v104 + Vector3.new(v107, 0, v108:NextInteger(-2, 2))
                local v110 = _G.PlayEffect
                local v111 = CFrame.new(v109)
                local v112 = v106 * (u9 / 2)
                local v113 = u9 / 10 + 15
                v110("MochiImpactDroplet", nil, v111, 1, 2, 25, 0.5, 0.7, v112 + Vector3.new(0, v113, 0), u6)
                local v114 = _G.PlayEffect
                local v115 = {
                    ["Position"] = v109,
                    ["Velocity"] = (Vector3.new(0, 1, 0)):Cross(v106) * (math.random(2) == 1 and 1 or -1) * (math.random(u10 / 2, u10) / 3) + Vector3.new(0, 1, 0) * math.random(u10 / 3, u10 / 2),
                    ["AngularVelocity"] = Random.new():NextUnitVector() * 15,
                    ["Material"] = v103.Material
                }
                local v116 = math.random(2)
                local v117 = math.random(2)
                local v118 = math.random
                v115.Size = Vector3.new(v116, v117, v118(2))
                v115.Color = v103.Color
                v114("CreateRock", nil, v115)
            end
            u14 = os.clock()
        end
        local v119 = u20.Position.Y
        if u31.FloorMaterial == Enum.Material.Air then
            if u27 == false then
                u27 = true
                u26 = v119
            end
            if u26 < v119 then
                u26 = v119
            end
        else
            if u27 == true and u26 ~= nil then
                local v120 = u26 - v119
                if v120 >= 20 and os.clock() - u28 >= 0.5 then
                    local v121 = u13.GroundImpactVFX:Clone()
                    u3.apply(v121, u6)
                    local _, v122, _ = _G.getRayWall(u20.CFrame, u20.CFrame * CFrame.new(0, 0, -4.8))
                    local v123 = workspace:Raycast(v122, Vector3.new(0, -30, 0), u4)
                    v121.Parent = workspace.Terrain
                    _G.destroy(v121, 4)
                    if v123 then
                        v121.WorldCFrame = CFrame.new(v123.Position, v123.Position + v123.Normal) * CFrame.Angles(-1.5707963267948966, 0, 0)
                        _G.customEmit(v121)
                        _G.destroy(v121, 2)
                        _G.PlayEffect("MochiImpactDroplet", nil, v121.CFrame, 5, 3, 25, 0.4, 0.7, v121.CFrame.upVector * 55, u6)
                        _G.PlaySound(v121.WorldCFrame, script["Audio/MochiV2WheelHit"], {
                            ["RandomPitch"] = true
                        })
                        _G.PlayEffect("GroundRocks4", nil, {
                            ["Segments"] = 20,
                            ["Position"] = (v121.WorldCFrame * CFrame.new(0, 5, 0)).Position,
                            ["DistanceRandomness"] = Vector2.new(0.4, 1),
                            ["Duration"] = 2,
                            ["TweenDuration"] = 1,
                            ["Radius"] = 13,
                            ["Direction"] = v121.WorldCFrame.UpVector * -15,
                            ["Angle"] = -0.6108652381980153
                        })
                        _G.PlayEffect("RockDebris", nil, {
                            ["PartCount"] = 8,
                            ["RandomVelocityMagnitude"] = Vector2.new(-35, 35),
                            ["Position"] = v121.WorldCFrame.Position,
                            ["Direction"] = v121.WorldCFrame.UpVector * 75,
                            ["RaycastDirection"] = v121.WorldCFrame.UpVector * -15,
                            ["Size"] = Vector3.new(1, 1, 1),
                            ["TrailEnabled"] = true
                        }, true)
                        u28 = os.clock()
                        local v124 = v120 / 200
                        u9 = u10 * (1 - math.clamp(v124, 0, 1))
                        if u19 == true and u7 then
                            u7:FireServer(CFrame.new(v122))
                        end
                    end
                end
            end
            u27 = false
            u26 = nil
        end
        if v39 and v39.Instance then
            u17.WorldPosition = v39.Position
        end
        if u31.FloorMaterial == Enum.Material.Air and v39 == nil or v95 <= 0.5 then
            _G.particleEnabled(u17, false)
        else
            _G.particleEnabled(u17, true)
        end
        if v39 == nil or u31.FloorMaterial ~= Enum.Material.Air then
            u17.CFrame = u24
        end
        u25 = v119
    end)
    repeat
        task.wait()
    until u6:GetAttribute("spikedMochiRolling") == nil or u6:IsDescendantOf(workspace) == false
    u2:Create(u29, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {
        ["Volume"] = 0
    }):Play()
    _G.destroy(u29)
    if v125 then
        v125:Disconnect()
    end
    u21:Destroy()
    u13.Anchored = true
    _G.particleEnabled(v12, false)
    _G.PlayEffect("TweenModel", nil, v12, TweenInfo.new(0.1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), 0.01)
    _G.particleEnabled(v15, false)
    _G.particleEnabled(u17, false)
    _G.destroy({ v12 }, 0.25)
    _G.destroy({
        v12,
        u17,
        u16,
        v15
    }, 3)
    _G.PlayEffect("MochiImpactDroplet", nil, u13.CFrame, 8, 1.5, 35, 0.4, 0.75, nil, u6)
    local v126 = script.End:Clone()
    u3.apply(v126, u6)
    v126.CFrame = u13.CFrame
    v126.Parent = workspace.Effects
    _G.customEmit(v126)
    _G.destroy(v126, 2)
    _G.PlaySound(u6.PrimaryPart, script["Audio/MochiV2WheelStop"]).Parent = u6.PrimaryPart
end
return v1