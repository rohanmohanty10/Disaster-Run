 

local v1 = {}
local u2 = game:GetService("TweenService")
local u3 = game:GetService("RunService")
local u4 = Random.new()
local u5 = RaycastParams.new()
u5.FilterDescendantsInstances = { workspace.Effects }
u5.FilterType = Enum.RaycastFilterType.Exclude
local u6 = _G.customEmit
function v1.start(_, p7) --[[ Line: 21 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u4
        [3] = u5
        [4] = u6
        [5] = u3
    --]]
    local u8 = game.ReplicatedStorage["Stats" .. p7.Character.Name].Customization.BusoColor.Value
    local u9 = script.Blackhole:Clone()
    u9.Position = p7.Position
    for _, v10 in pairs(u9:GetDescendants()) do
        if v10:IsA("ParticleEmitter") and v10:GetAttribute("Colourable") then
            v10.Color = ColorSequence.new(u8)
        end
    end
    u9.Parent = workspace.Effects
    _G.PlaySound(u9, script.Sound.Charge)
    u9.Attachment.Shadow.Lifetime = NumberRange.new(2)
    u9.Attachment.Shadow:Emit(1)
    u9.Attachment.Circle:Emit(1)
    local u11 = p7.Victim
    task.spawn(function() --[[ Line: 44 ]]
        --[[
        Upvalues:
            [1] = u11
            [2] = u2
            [3] = u9
        --]]
        local v12 = {
            u11.Head,
            u11.LeftUpperArm,
            u11.LeftLowerArm,
            u11.LeftHand,
            u11.UpperTorso,
            u11.LowerTorso,
            u11.RightUpperArm,
            u11.RightLowerArm,
            u11.RightHand,
            u11.LeftUpperLeg,
            u11.LeftLowerLeg,
            u11.LeftFoot,
            u11.RightUpperLeg,
            u11.RightLowerLeg,
            u11.RightFoot
        }
        for _, u13 in pairs(u11:GetDescendants()) do
            if u13.Name:lower():find("hair") and u13:IsA("BasePart") then
                u2:Create(u13, TweenInfo.new(0.5), {
                    ["CFrame"] = CFrame.Angles(math.random() * 2 * 3.141592653589793, math.random() * 2 * 3.141592653589793, math.random() * 2 * 3.141592653589793) + u9.Position,
                    ["Size"] = Vector3.new()
                }):Play()
                task.delay(0.5, function() --[[ Line: 72 ]]
                    --[[
                    Upvalues:
                        [1] = u13
                    --]]
                    u13:Destroy()
                end)
            end
        end
        task.spawn(function() --[[ Line: 85 ]]
            --[[
            Upvalues:
                [1] = u11
            --]]
            for v14 = 1, 25 do
                local v15 = u11
                local v16 = 1 - v14 / 25
                v15:ScaleTo((math.max(v16, 0.01)))
                task.wait()
            end
        end)
        for _, u17 in pairs(v12) do
            u17.Anchored = true
            u2:Create(u17, TweenInfo.new(0.5), {
                ["CFrame"] = CFrame.Angles(math.random() * 2 * 3.141592653589793, math.random() * 2 * 3.141592653589793, math.random() * 2 * 3.141592653589793) + u9.Position,
                ["Size"] = Vector3.new()
            }):Play()
            task.delay(0.5, function() --[[ Line: 104 ]]
                --[[
                Upvalues:
                    [1] = u17
                --]]
                u17:Destroy()
            end)
            task.wait()
        end
    end)
    local u18 = 0.025
    local u19 = 0.01
    local u20 = 1
    local u21 = 0
    local u22 = true
    local u23 = {}
    local u24 = {}
    local function u56() --[[ Line: 128 ]]
        --[[
        Upvalues:
            [1] = u9
            [2] = u4
            [3] = u5
            [4] = u22
            [5] = u8
            [6] = u2
            [7] = u23
        --]]
        local v25 = u9.Position
        local v26 = u4:NextUnitVector() * 15
        local v27 = workspace:Raycast(v25, v26, u5)
        if v27 then
            local u28 = {}
            local u29 = Instance.new("Part")
            u29.Anchored = true
            u29.CanCollide = false
            local v30 = u4:NextNumber(0.25, 1.5)
            local v31 = u4:NextNumber(0.25, 1.5)
            local v32 = u4
            u29.Size = Vector3.new(1, 1, 1) * Vector3.new(v30, v31, v32:NextNumber(0.25, 1.5))
            u29.Material = v27.Instance.Material
            u29.Color = v27.Instance.Color
            local u33 = u4:NextNumber(-0.1, 0.1)
            local u34 = u4:NextNumber(-0.1, 0.1)
            local u35 = u4:NextNumber(-0.1, 0.1)
            u29.CFrame = CFrame.new(v27.Position, v27.Position + v27.Normal) * CFrame.Angles(0, 6.283185307179586 * math.random(), 0)
            local u36 = 0
            local u37 = u4:NextNumber(1, 3)
            local u38 = u29.Position
            local u39 = u29.Size
            local u40 = u4:NextNumber(1, 1.5)
            local v41 = v27.Position.X - u9.Position.X
            local v42 = v27.Position.Z - u9.Position.Z
            local u43 = math.atan2(v41, v42)
            local u44 = (v27.Position * Vector3.new(1, 0, 1) - u9.Position * Vector3.new(1, 0, 1)).Magnitude
            u28.Finished = false
            function u28.Update(_, p45) --[[ Line: 155 ]]
                --[[
                Upvalues:
                    [1] = u36
                    [2] = u37
                    [3] = u28
                    [4] = u29
                    [5] = u22
                    [6] = u8
                    [7] = u2
                    [8] = u44
                    [9] = u40
                    [10] = u43
                    [11] = u9
                    [12] = u38
                    [13] = u39
                    [14] = u33
                    [15] = u34
                    [16] = u35
                --]]
                local v46 = u36 / u37
                u36 = u36 + p45
                if v46 >= 1 then
                    u28.Finished = true
                    u29:Destroy()
                    return
                elseif u22 then
                    local v47 = u44 * (1 - v46)
                    local v48 = u36 * 3.141592653589793 * u40 / u37 + u43
                    local v49 = math.sin(v48)
                    local v50 = math.cos(v48)
                    local v51 = Vector3.new(v49, 0, v50) * v47
                    local v52 = (u9.Position.Y - u38.Y) * v46 - (u9.Position.Y - u38.Y)
                    local v53 = v51 + Vector3.new(0, v52, 0)
                    u29.Position = u9.Position + v53
                    u29.Size = u39 * (1 - v46)
                    local v54 = u29
                    v54.CFrame = v54.CFrame * CFrame.Angles(u33, u34, u35)
                else
                    u28.Finished = true
                    u29.Anchored = false
                    u29.CanCollide = true
                    u29.Material = Enum.Material.Neon
                    u29.Color = u8
                    _G.destroy(u29, 0.25)
                    u2:Create(u29, TweenInfo.new(0.25), {
                        ["Transparency"] = 1
                    }):Play()
                end
            end
            u29.Parent = workspace.Effects
            local v55 = u23
            table.insert(v55, u28)
        end
    end
    local function u82() --[[ Line: 202 ]]
        --[[
        Upvalues:
            [1] = u9
            [2] = u4
            [3] = u5
            [4] = u8
            [5] = u2
            [6] = u22
            [7] = u23
        --]]
        local v57 = u9.Position
        local v58 = u4:NextUnitVector() * 15
        local v59 = workspace:Raycast(v57, v58, u5)
        if v59 then
            local u60 = script.trail:Clone()
            u60.Trail.Color = ColorSequence.new(u8)
            local v61 = CFrame.Angles
            local v62 = u4:NextNumber(-90, 90)
            u60.CFrame = v61(math.rad(v62), 6.283185307179586 * math.random(), 0) * CFrame.new(0, 0, -math.random(2, 4)) + u9.Position
            local u63 = 0
            local u64 = u4:NextNumber(0.25, 0.65)
            local u65 = u60.Position
            local u66 = u60.Size
            local v67 = v59.Position.X - u9.Position.X
            local v68 = v59.Position.Z - u9.Position.Z
            local u69 = math.atan2(v67, v68)
            local u70 = (v59.Position * Vector3.new(1, 0, 1) - u9.Position * Vector3.new(1, 0, 1)).Magnitude
            local u71 = {
                ["Finished"] = false
            }
            u2:Create(u60.Trail, TweenInfo.new(u64), {
                ["MaxLength"] = 0
            }):Play()
            u2:Create(u60.A0, TweenInfo.new(u64), {
                ["Position"] = Vector3.new()
            }):Play()
            u2:Create(u60.A1, TweenInfo.new(u64), {
                ["Position"] = Vector3.new()
            }):Play()
            function u71.Update(_, p72) --[[ Line: 247 ]]
                --[[
                Upvalues:
                    [1] = u63
                    [2] = u64
                    [3] = u22
                    [4] = u71
                    [5] = u60
                    [6] = u70
                    [7] = u69
                    [8] = u9
                    [9] = u65
                    [10] = u66
                --]]
                local v73 = u63 / u64
                u63 = u63 + p72
                if v73 >= 1 or not u22 then
                    u71.Finished = true
                    u60:Destroy()
                else
                    local v74 = u70 * (1 - v73)
                    local v75 = u63 * 3.141592653589793 * 1 / u64 + u69
                    local v76 = math.sin(v75)
                    local v77 = math.cos(v75)
                    local v78 = Vector3.new(v76, 0, v77) * v74
                    local v79 = (u9.Position.Y - u65.Y) * v73 - (u9.Position.Y - u65.Y)
                    local v80 = v78 + Vector3.new(0, v79, 0)
                    u60.Position = u9.Position + v80
                    u60.Size = u66 * (1 - v73)
                    u60.Trail.Transparency = NumberSequence.new(1 - v73)
                end
            end
            u60.Parent = workspace.Effects
            local v81 = u23
            table.insert(v81, u71)
        end
    end
    task.delay(2, function() --[[ Line: 272 ]]
        --[[
        Upvalues:
            [1] = u22
            [2] = u9
            [3] = u24
            [4] = u4
            [5] = u8
            [6] = u6
        --]]
        u22 = false
        _G.PlaySound(u9, script.Sound.Explode)
        u9.Attachment:Destroy()
        for _, v83 in pairs(u24) do
            v83:ApplyImpulse(CFrame.new(u9.Position, v83.Position).LookVector * math.random(25, 50))
        end
        for _ = 1, 3 do
            _G.PlayEffect("ConquerorsLightning", nil, {
                ["Start"] = u9.Position + u4:NextUnitVector() * u4:NextNumber(15, 20),
                ["End"] = u9.Position,
                ["Colour"] = u8,
                ["Linear"] = true,
                ["Size"] = Random.new():NextNumber(0.05, 0.1) * 4
            })
        end
        u6(u9.Explode)
        _G.destroy(u9, u9.Dust.Dust.Lifetime.Max)
        local v84 = workspace:Raycast(u9.Position, Vector3.new(0, -99, 0))
        if v84 then
            u9.Dust.WorldCFrame = CFrame.new(v84.Position, v84.Position + v84.Normal)
            u6(u9.Dust)
        end
    end)
    local u85 = nil
    u85 = u3.Heartbeat:Connect(function(p86) --[[ Line: 306 ]]
        --[[
        Upvalues:
            [1] = u21
            [2] = u23
            [3] = u85
            [4] = u18
            [5] = u22
            [6] = u56
            [7] = u19
            [8] = u82
            [9] = u20
            [10] = u9
            [11] = u5
            [12] = u8
        --]]
        if u21 >= 2 and #u23 == 0 then
            u85:Disconnect()
            u85 = nil
        else
            if u18 <= u21 and u22 then
                u56()
                u18 = u18 + 0.025
            end
            if u19 <= u21 and u22 then
                u82()
                u19 = u19 + 0.01
            end
            if u20 <= u21 and u22 then
                local v87 = CFrame.Angles(-1.5707963267948966, 0, 0) * CFrame.Angles(0, 0, 6.283185307179586 * math.random())
                local v88 = CFrame.Angles
                local v89 = Random.new():NextNumber(55, 75)
                local v90 = v87 * v88(math.rad(v89), 0, 0)
                local v91 = u9.Position
                local v92 = v90.LookVector * 25
                local v93 = workspace:Raycast(v91, v92, u5)
                if v93 then
                    _G.PlayEffect("ConquerorsLightning", nil, {
                        ["Start"] = u9.Position,
                        ["End"] = v93.Position,
                        ["Colour"] = u8,
                        ["Size"] = Random.new():NextNumber(0.05, 0.1) * 4
                    })
                end
                u20 = u20 + 1
            end
            for v94 = #u23, 1, -1 do
                local v95 = u23[v94]
                if v95.Finished then
                    table.remove(u23, v94)
                else
                    v95:Update(p86)
                end
            end
            u21 = u21 + p86
        end
    end)
end
return v1