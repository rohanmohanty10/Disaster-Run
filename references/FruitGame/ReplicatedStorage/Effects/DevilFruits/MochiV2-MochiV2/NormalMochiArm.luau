 

local v1 = {}
local u2 = workspace.Effects
local _ = game["Run Service"]
local u3 = game:GetService("TweenService")
local u4 = require(game.ReplicatedStorage.Modules.Client.WeaponVFXRecolor)
local u5 = script.MochiBarrage
function v1.start(_, p6) --[[ Line: 33 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u2
        [3] = u3
        [4] = u5
    --]]
    local u7 = game.Players.LocalPlayer.Character
    local v8 = p6.startCFrame
    local v9 = p6.FistTimeToArrive
    local v10 = p6.Distance
    local v11 = p6.modelScale
    local _ = p6.instant
    local u12 = p6.hitInfo
    local _ = p6.hakiColor
    local u13 = v9 or 1
    local u14 = v10 or 48.252
    local _ = (v11 or 2.5) >= 2
    local u15 = Random.new()
    local u16 = u15:NextNumber(0.75, 1.25)
    local v17 = u15:NextNumber(0.75, 1.25)
    local u18 = u15:NextNumber(100, 150)
    local v19 = script.Fists.Right
    local u20 = v19.Dough:Clone()
    u4.apply(u20, u7)
    u20.CFrame = v8
    u20.Parent = u2
    u3:Create(u20, TweenInfo.new(0.2 * v17, Enum.EasingStyle.Bounce), {
        ["Size"] = Vector3.new(7.375, 7.187, 3) * v17
    }):Play()
    local u21 = u5:WaitForChild("DoughVFX2"):Clone()
    u4.apply(u21, u7)
    u21.CFrame = u20:GetPivot() * CFrame.new(0, 0, 0) * CFrame.Angles(0, 0, 0)
    u21.Parent = u2
    _G.customEmit(u21)
    task.delay(1, function() --[[ Line: 65 ]]
        --[[
        Upvalues:
            [1] = u21
        --]]
        u21:Destroy()
    end)
    local u22 = v19.Fist:Clone()
    u4.apply(u22, u7)
    u22:SetPrimaryPartCFrame(u20:GetPivot() * CFrame.Angles(0, 0, 0))
    local u23 = u22.Fist
    local u24 = u22.PrimaryPart.Left_Base.Left_Palm_Extender
    u22.Parent = u2
    local u25 = u5:WaitForChild("DoughShotVFX2"):Clone()
    u4.apply(u25, u7)
    u25.CFrame = u20:GetPivot() * CFrame.new(0, -1, 0) * CFrame.Angles(0, 0, 0)
    u25.Parent = u2
    _G.customEmit(u25)
    task.delay(1.4, function() --[[ Line: 88 ]]
        --[[
        Upvalues:
            [1] = u25
        --]]
        u25:Destroy()
    end)
    local u26 = v19.Fist.PrimaryPart:FindFirstChild("Left_Palm_Extender", true).CFrame
    if u12 then
        local v27 = ((u23.Position - u12.Position).Magnitude - u14 / u14 * 100 + 100) / 30
        local u28 = v27 <= 0.5 and 0.5 or v27
        local u29 = (u23.Position - u12.Position).Magnitude
        u3:Create(u24, TweenInfo.new(u13 * u28, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
            ["CFrame"] = u24.CFrame * CFrame.new(0, u29 - 1.85, 0)
        }):Play()
        task.delay(u13 * u28, function() --[[ Line: 107 ]]
            --[[
            Upvalues:
                [1] = u23
                [2] = u5
                [3] = u4
                [4] = u7
                [5] = u20
                [6] = u29
                [7] = u15
                [8] = u2
                [9] = u3
                [10] = u16
                [11] = u24
                [12] = u13
                [13] = u28
                [14] = u26
                [15] = u12
            --]]
            u23.Beam.Enabled = false
            local v30 = u5.FistWind1:Clone()
            u4.apply(v30, u7)
            local v31 = u20:GetPivot() * CFrame.new(0, 0, -u29 - 1.85)
            local v32 = CFrame.Angles
            local v33 = u15:NextNumber(-15, 15)
            local v34 = math.rad(v33)
            local v35 = u15:NextNumber(1, 360)
            v30.CFrame = v31 * v32(1.5707963267948966, v34, (math.rad(v35)))
            v30.Parent = u2
            local v36 = u3
            local v37 = v30.Mesh
            local v38 = TweenInfo.new(0.5 * u16, Enum.EasingStyle.Exponential)
            local v39 = {}
            local v40 = v30.Mesh.Scale.X * 3 * u16
            local v41 = v30.Mesh.Scale.Y * 3 * u16
            local v42 = v30.Mesh.Scale.Z * 3 * u16
            v39.Scale = Vector3.new(v40, v41, v42)
            v36:Create(v37, v38, v39):Play()
            u3:Create(v30.Decal, TweenInfo.new(0.5 * u16, Enum.EasingStyle.Exponential), {
                ["Transparency"] = 1
            }):Play()
            _G.destroy(v30, 2)
            local v43 = {
                ["CFrame"] = u26
            }
            u3:Create(u24, TweenInfo.new(u13 * u28 * 1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.In), v43):Play()
            local v44 = u12.CFrame
            if v44 then
                local v45 = script.FistImpactVFX2:Clone()
                u4.apply(v45, u7)
                v45.CFrame = v44
                v45.Parent = workspace.Effects
                _G.customEmit(v45)
                _G.destroy(v45, 4)
                _G.PlaySound(v45, script["Audio/MochiV2BarrageGroundHit" .. math.random(1, 3)], {
                    ["RandomPitch"] = true
                })
                local _ = v44.Position
            end
        end)
        task.delay(u13 * u28 * 1.5, function() --[[ Line: 144 ]]
            --[[
            Upvalues:
                [1] = u3
                [2] = u23
                [3] = u22
                [4] = u13
                [5] = u28
                [6] = u5
                [7] = u4
                [8] = u7
                [9] = u20
                [10] = u2
                [11] = u18
            --]]
            u3:Create(u23, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
                ["Size"] = Vector3.new()
            }):Play()
            _G.PlayEffect("TweenModel", nil, u22, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), 0.001)
            task.wait(u13 * u28 * 0.1)
            local u46 = u5:WaitForChild("DoughDeleteVFX"):Clone()
            u4.apply(u46, u7)
            u46.CFrame = u20:GetPivot() * CFrame.new(0, -2, 0) * CFrame.Angles(0, 0, 0)
            u46.Parent = u2
            task.delay(1, function() --[[ Line: 155 ]]
                --[[
                Upvalues:
                    [1] = u46
                --]]
                u46:Destroy()
            end)
            u3:Create(u20, TweenInfo.new(0.2, Enum.EasingStyle.Bounce, Enum.EasingDirection.In), {
                ["Size"] = Vector3.new()
            }):Play()
            local v47 = u3
            local v48 = u20
            local v49 = TweenInfo.new(0.45, Enum.EasingStyle.Sine)
            local v50 = {}
            local v51 = u20.Orientation
            local v52 = u18 * -2
            v50.Orientation = v51 + Vector3.new(0, 0, v52)
            v47:Create(v48, v49, v50):Play()
            task.wait(0.2)
            u23:Destroy()
            u20:Destroy()
        end)
    else
        u23.CFrame = u20:GetPivot() * CFrame.new(0, 0, -1.5) * CFrame.Angles(0, 0, 0)
        u3:Create(u24, TweenInfo.new(u13, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
            ["CFrame"] = u24.CFrame * CFrame.new(0, u14, 0)
        }):Play()
        task.delay(u13, function() --[[ Line: 173 ]]
            --[[
            Upvalues:
                [1] = u5
                [2] = u4
                [3] = u7
                [4] = u20
                [5] = u14
                [6] = u15
                [7] = u2
                [8] = u3
                [9] = u16
                [10] = u23
                [11] = u24
                [12] = u13
                [13] = u26
                [14] = u22
                [15] = u18
            --]]
            local v53 = u5.FistWind1:Clone()
            u4.apply(v53, u7)
            local v54 = u20:GetPivot() * CFrame.new(0, 0, -u14)
            local v55 = CFrame.Angles
            local v56 = u15:NextNumber(1, 360)
            local v57 = math.rad(v56)
            local v58 = u15:NextNumber(-1, 1)
            v53.CFrame = v54 * v55(1.5707963267948966, v57, (math.rad(v58)))
            v53.Parent = u2
            local v59 = u3
            local v60 = v53.Mesh
            local v61 = TweenInfo.new(0.75 * u16, Enum.EasingStyle.Exponential)
            local v62 = {}
            local v63 = v53.Mesh.Scale.X * 3 * u16
            local v64 = v53.Mesh.Scale.Y * 3 * u16
            local v65 = v53.Mesh.Scale.Z * 3 * u16
            v62.Scale = Vector3.new(v63, v64, v65)
            v59:Create(v60, v61, v62):Play()
            u3:Create(v53.Decal, TweenInfo.new(0.75 * u16, Enum.EasingStyle.Exponential), {
                ["Transparency"] = 1
            }):Play()
            _G.destroy(v53, 2)
            u23.Beam.Enabled = false
            local v66 = {
                ["CFrame"] = u26
            }
            u3:Create(u24, TweenInfo.new(u13, Enum.EasingStyle.Sine, Enum.EasingDirection.In), v66):Play()
            u3:Create(u23, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
                ["Size"] = Vector3.new()
            }):Play()
            _G.PlayEffect("TweenModel", nil, u22, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), 0.001)
            u3:Create(u20, TweenInfo.new(0.2, Enum.EasingStyle.Bounce, Enum.EasingDirection.In), {
                ["Size"] = Vector3.new()
            }):Play()
            local v67 = u3
            local v68 = u20
            local v69 = TweenInfo.new(0.45, Enum.EasingStyle.Sine)
            local v70 = {}
            local v71 = u20.Orientation
            local v72 = u18 * u15:NextInteger(-2, 2)
            v70.Orientation = v71 + Vector3.new(0, 0, v72)
            v67:Create(v68, v69, v70):Play()
            local u73 = u5:WaitForChild("DoughDeleteVFX"):Clone()
            u4.apply(u73, u7)
            u73.CFrame = u20:GetPivot() * CFrame.new(0, -2, 0) * CFrame.Angles(0, 0, 0)
            u73.Parent = u2
            task.delay(1, function() --[[ Line: 198 ]]
                --[[
                Upvalues:
                    [1] = u73
                --]]
                u73:Destroy()
            end)
            task.wait(0.2)
            u23:Destroy()
            u20:Destroy()
        end)
    end
end
return v1