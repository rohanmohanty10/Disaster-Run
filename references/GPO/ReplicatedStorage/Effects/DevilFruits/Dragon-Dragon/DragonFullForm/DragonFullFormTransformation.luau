 

local u1 = game:GetService("RunService")
game:GetService("UserInputService")
local u2 = game:GetService("TweenService")
script:WaitForChild("Animations")
local u3 = require(script.Parent:WaitForChild("DragonHybridForm"))
local u4 = Random.new()
local v5 = {}
local function u11(p6) --[[ Line: 24 ]]
    local v7, v8, v9 = Color3.toHSV(p6)
    local v10 = v9 * 0.2
    return Color3.fromHSV(v7, v8, v10)
end
local function u21(p12, p13, p14) --[[ Line: 30 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v15 = script.Beam:Clone()
    v15.CFrame = p12 * CFrame.Angles(p13:NextNumber(-2.199114857512855, 2.199114857512855), 1.5707963267948966 * p14, p13:NextNumber(-0.9424777960769379, 0.9424777960769379))
    v15.Parent = workspace.Effects
    local v16 = p13:NextNumber(0.8, 1.4)
    local v17 = p13:NextNumber(0.4, 0.6)
    u2:Create(v15, TweenInfo.new(v17), {
        ["CFrame"] = v15.CFrame * CFrame.new(0, 0, p13:NextNumber(6, 24))
    }):Play()
    for _, v18 in v15:GetChildren() do
        if v18:IsA("Attachment") then
            local v19 = v18.Position
            v18.Position = v18.Position * 0.1
            u2:Create(v18, TweenInfo.new(v17 + p13:NextNumber(-0.1, 0.2)), {
                ["Position"] = v19 * v16
            }):Play()
        elseif v18:IsA("Beam") then
            local v20 = v18.Name == "fire" and 0.15 or 0.35
            u2:Create(v18, TweenInfo.new(v17 + v20, Enum.EasingStyle.Linear), {
                ["Width1"] = 0,
                ["Width0"] = 0
            }):Play()
        end
    end
    _G.destroy(v15, v17 + 1)
    return v15
end
local v22 = RaycastParams.new()
local v23 = { workspace.Islands, workspace.Env, workspace.Ships }
local v24 = Enum.RaycastFilterType.Include
v22.FilterDescendantsInstances = v23
v22.FilterType = v24
function v5.start(_, u25, p26, u27) --[[ Line: 70 ]]
    --[[
    Upvalues:
        [1] = u21
        [2] = u4
        [3] = u11
        [4] = u3
        [5] = u2
        [6] = u1
    --]]
    local u28 = u27.DragonColor
    local v29 = u27.PlayerDragonModel
    local v30 = u27.serverStartTime
    if v30 then
        v30 = workspace:GetServerTimeNow() - v30
    end
    if p26 == false then
        task.delay(0.1, function() --[[ Line: 81 ]]
            --[[
            Upvalues:
                [1] = u25
                [2] = u28
                [3] = u21
                [4] = u4
                [5] = u11
                [6] = u27
                [7] = u3
            --]]
            local v31 = script.Detransform:Clone()
            v31.CFrame = u25:GetPivot()
            _G.recolorParticles(v31, u28)
            v31.Parent = workspace.Effects
            _G.destroy(v31, 2)
            _G.customEmit(v31)
            local v32 = u25.PrimaryPart.CFrame
            for v33 = 1, 4 do
                local v34 = u21(v32, u4, v33)
                v34.Beam85.Color = ColorSequence.new(u28)
                v34.Beam.Color = ColorSequence.new(u11(u27.DragonColor))
                u3:CreateTrail(v32, u4, script.Trail, 35, 2).Beam79.Color = ColorSequence.new(u28)
            end
        end)
        local v35 = Instance.new("Highlight")
        v35.DepthMode = Enum.HighlightDepthMode.Occluded
        local v36 = Color3.new(1, 1, 1)
        local v37 = Color3.new(1, 1, 1)
        v35.FillColor = v36
        v35.OutlineColor = v37
        v35.FillTransparency = 1
        v35.OutlineTransparency = 1
        v35.Parent = v29
        u2:Create(v35, TweenInfo.new(0.2), {
            ["OutlineTransparency"] = 0,
            ["FillTransparency"] = 0
        }):Play()
        local v38 = v29:FindFirstChild("DragonPositionMover")
        local v39 = v29:FindFirstChild("DragonOrientationMover")
        u3:TweenModel(v29, v29:GetScale(), 0, 0.16000000000000003, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
        _G.destroy(v35, 0.2)
        _G.destroy(v38, 0.2)
        _G.destroy(v39, 0.2)
        _G.destroy(v29, 0.16000000000000003)
        return
    else
        local _ = u25.Humanoid.Animator
        task.wait(0.1 - v30)
        local v40 = u25.PrimaryPart:FindFirstChild("DragonFlightAttachment") or Instance.new("Attachment")
        v40.Parent = u25.PrimaryPart
        v40.Name = "DragonFlightAttachment"
        task.wait(0.6 - v30)
        local u41 = workspace.Effects:WaitForChild(u25.Name .. "DragonModel", 5)
        if u41 == nil then
            return
        else
            u41:WaitForChild("AnimationController"):WaitForChild("Animator")
            task.spawn(function() --[[ Line: 140 ]]
                --[[
                Upvalues:
                    [1] = u41
                    [2] = u28
                    [3] = u1
                --]]
                if u41:WaitForChild("RootPart", 5) then
                    for u42 = 1, 48 do
                        task.delay(u42 / 200, function() --[[ Line: 151 ]]
                            --[[
                            Upvalues:
                                [1] = u41
                                [2] = u42
                                [3] = u28
                                [4] = u1
                            --]]
                            if u41.PrimaryPart == nil then
                                warn("no primaryPart")
                                return
                            else
                                local u43 = u41.PrimaryPart:FindFirstChild("Body_" .. u42, true) or u41.PrimaryPart:FindFirstChild(("Body%*_Main"):format(u42), true)
                                if u43 == nil then
                                    warn("no bone")
                                else
                                    task.spawn(function() --[[ Line: 163 ]]
                                        --[[
                                        Upvalues:
                                            [1] = u43
                                            [2] = u28
                                            [3] = u1
                                        --]]
                                        local u44 = script.DragonFormEffect:Clone()
                                        u44.CFrame = u43.WorldCFrame
                                        u44.Parent = workspace.Effects
                                        local v45 = ColorSequence.new(u28)
                                        for _, v46 in u44:GetDescendants() do
                                            if v46.Name == "ColoredEffect" then
                                                v46.Color = v45
                                            end
                                        end
                                        _G.customEmit(u44)
                                        _G.destroy(u44, 2)
                                        local v47 = u1.RenderStepped:Connect(function() --[[ Line: 171 ]]
                                            --[[
                                            Upvalues:
                                                [1] = u44
                                                [2] = u43
                                            --]]
                                            u44.CFrame = u43.WorldCFrame * CFrame.Angles(-1.5707963267948966, 0, 0)
                                        end)
                                        task.delay(1.75, v47.Disconnect, v47)
                                    end)
                                end
                            end
                        end)
                    end
                end
            end)
            if u25 == game.Players.LocalPlayer.Character ~= false then
                local u48 = u25:WaitForChild("HumanoidRootPart")
                local u49 = u25:WaitForChild("Humanoid")
                local u50 = u48.AssemblyMass
                local u51 = Vector3.new(0, 1, 0) * u50 * workspace.Gravity
                local u52 = workspace.CurrentCamera
                local u53 = require(game.Players.LocalPlayer.PlayerScripts:WaitForChild("PlayerModule")):GetControls()
                local u54 = Instance.new("VectorForce")
                u54.Attachment0 = u48:FindFirstChild("RootRigAttachment")
                u54.RelativeTo = Enum.ActuatorRelativeTo.World
                u54.Parent = u48
                local u55 = Instance.new("AlignOrientation")
                u55.Attachment0 = u54.Attachment0
                u55.CFrame = u52.CFrame * CFrame.Angles(0, 3.141592653589793, 0)
                u55.MaxTorque = 50000
                u55.Mode = Enum.OrientationAlignmentMode.OneAttachment
                u55.Parent = u48
                local u56 = nil
                _G.customDragonFlightForce = nil
                _G.customDragonFlightMult = 1
                u56 = u1.RenderStepped:Connect(function(_) --[[ Line: 221 ]]
                    --[[
                    Upvalues:
                        [1] = u53
                        [2] = u52
                        [3] = u49
                        [4] = u50
                        [5] = u48
                        [6] = u51
                        [7] = u25
                        [8] = u55
                        [9] = u41
                        [10] = u56
                        [11] = u54
                    --]]
                    local v57 = u53:GetMoveVector()
                    local v58 = u52.CFrame.RightVector * v57.X + u52.CFrame.LookVector * -v57.Z
                    local v59 = u49.Health / u49.MaxHealth
                    u50 = u48.AssemblyMass
                    u51 = Vector3.new(0, 1, 0) * u50 * workspace.Gravity
                    local v60 = v59 > 0.25 and 1 or v59
                    local v61 = 300 * (_G.check:inspect(u25) == false and 0.1 or v60) * _G.customDragonFlightMult
                    local v62 = v58 * u50 * v61
                    local v63 = u48.AssemblyLinearVelocity * u50 * 2
                    if v58.Magnitude > 0 then
                        u55.CFrame = CFrame.lookAlong(u52.CFrame.Position, v58)
                    end
                    if _G.FaceMouse == true or u25:GetAttribute("DragonFaceRoot") then
                        u55.CFrame = u48.CFrame
                    end
                    u49.AutoRotate = false
                    u49.PlatformStand = true
                    u49.Sit = false
                    u49:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
                    if u41 and (u41:IsDescendantOf(workspace) and u41.Name ~= "Done") then
                        local v64
                        if _G.customDragonFlightForce == nil then
                            v64 = u51 + v62 - v63
                        else
                            v64 = u51 + _G.customDragonFlightForce
                        end
                        if v64 == v64 then
                            u54.Force = v64
                        end
                    else
                        u56:Disconnect()
                        u49.PlatformStand = false
                        u49.AutoRotate = true
                        u49:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
                        u49.Sit = true
                        u55:Destroy()
                        u54:Destroy()
                        _G.customDragonMovement = nil
                        task.delay(0.1, function() --[[ Line: 260 ]]
                            --[[
                            Upvalues:
                                [1] = u49
                            --]]
                            u49.Sit = false
                        end)
                    end
                end)
            end
        end
    end
end
return v5