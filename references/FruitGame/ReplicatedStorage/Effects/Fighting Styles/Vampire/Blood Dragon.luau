 

local v1 = game:GetService("ReplicatedStorage")
game:GetService("PhysicsService")
local u2 = game:GetService("RunService")
require(v1.Modules.HitboxManager)
local u3 = require(v1.Modules.BezierFormula)
local u4 = require(v1.Modules.Client.WeaponVFXRecolor)
local u5 = workspace.Effects
local u6 = Random.new()
local u7 = {
    "rbxassetid://13835305736",
    "rbxassetid://13835482174",
    "rbxassetid://13835305369",
    "rbxassetid://13835305229",
    "rbxassetid://13835304999",
    "rbxassetid://13835304801",
    "rbxassetid://13835300445",
    "rbxassetid://13835300249",
    "rbxassetid://13835300033",
    "rbxassetid://13835299827",
    "rbxassetid://13835299641",
    "rbxassetid://13835299427",
    "rbxassetid://13835295518",
    "rbxassetid://13835295302",
    "rbxassetid://13835295083",
    "rbxassetid://13835294864",
    "rbxassetid://13835294651",
    "rbxassetid://13835294427",
    "rbxassetid://13835290570",
    "rbxassetid://13835290451",
    "rbxassetid://13835290277",
    "rbxassetid://13835290108",
    "rbxassetid://13835289939",
    "rbxassetid://13835289717"
}
function Flipbook(p8, u9, u10, u11)
    local u12 = p8:FindFirstChildOfClass("SpecialMesh")
    if u12 and u9 then
        task.spawn(function() --[[ Line: 45 ]]
            --[[
            Upvalues:
                [1] = u9
                [2] = u12
                [3] = u10
                [4] = u11
            --]]
            for v13 = 1, #u9 do
                u12.TextureId = u9[v13]
                task.wait(1 / u10)
            end
            if u11 == true then
                u12.Parent:Destroy()
            end
        end)
    end
end
local function u24(p14, p15, p16) --[[ Line: 57 ]]
    local function v22(u17, p18, p19) --[[ Line: 58 ]]
        for _, v20 in ipairs(u17:GetDescendants()) do
            if v20:IsA("ParticleEmitter") or v20:IsA("Trail") then
                v20.Enabled = p18
            end
        end
        if p19 then
            task.delay(p19, function() --[[ Line: 66 ]]
                --[[
                Upvalues:
                    [1] = u17
                --]]
                for _, v21 in ipairs(u17:GetDescendants()) do
                    if v21:IsA("ParticleEmitter") or v21:IsA("Trail") then
                        v21.Enabled = false
                    end
                end
            end)
        end
    end
    if typeof(p14) == "table" then
        for _, v23 in p14 do
            v22(v23, p15, p16)
        end
    else
        v22(p14, p15, p16)
    end
end
local v25 = {}
local function u28(p26, p27) --[[ Line: 105 ]]
    --[[
    Upvalues:
        [1] = u6
    --]]
    return u6:NextNumber(p26, p27)
end
function v25.start(_, _, u29, u30, p31, u32) --[[ Line: 110 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u5
        [3] = u2
        [4] = u3
        [5] = u24
        [6] = u6
        [7] = u28
        [8] = u7
    --]]
    if _G.checkRenderDistance(u29.Position) ~= false then
        local u33 = script["Blood Dragon"]["Blood Drag Head"]:Clone()
        u4.apply(u33, u32)
        u33:PivotTo(u29)
        u33.Parent = u5
        local v34 = script.SpawnVFX:Clone()
        u4.apply(v34, u32)
        v34.CFrame = u29
        v34.Parent = u5
        _G.customEmit(v34)
        _G.destroy(v34, 1)
        local u35 = 0
        local u36 = (CFrame.lookAt(u33.PrimaryPart.Position:Lerp(u30.Position, 0.25), u30.Position) * CFrame.new(p31, math.random(25, 65), 0)).Position
        local u37 = (CFrame.lookAt(u33.PrimaryPart.Position:Lerp(u30.Position, 0.25), u30.Position) * CFrame.new(p31 * -1, math.random(25, 65), 0)).Position
        _G.PlaySound(v34, script["BloodDragonShoot" .. math.random(1, 4)])
        tick()
        local u38 = nil
        u38 = u2.RenderStepped:Connect(function(p39) --[[ Line: 134 ]]
            --[[
            Upvalues:
                [1] = u35
                [2] = u3
                [3] = u29
                [4] = u36
                [5] = u37
                [6] = u30
                [7] = u38
                [8] = u33
                [9] = u24
                [10] = u4
                [11] = u32
                [12] = u5
                [13] = u6
                [14] = u28
                [15] = u2
                [16] = u7
            --]]
            u35 = u35 + p39 * 1.5
            local v40 = u3.CubicBezier(u35, u29.Position, u36, u37, u30.Position)
            if u35 >= 1 then
                u38:Disconnect()
                u33.PrimaryPart.Position = u30.Position
                u24(u33, false)
                _G.destroy(u33, 1)
                local v41 = script.HitFX:Clone()
                u4.apply(v41, u32)
                v41.Position = u33.PrimaryPart.Position
                v41.Parent = u5
                _G.customEmit(v41)
                _G.destroy(v41, 1)
                _G.tween(u33.PrimaryPart, {
                    0.5,
                    "Quad",
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Transparency"] = 1
                })
                local v42 = RaycastParams.new()
                v42.FilterDescendantsInstances = { workspace.Env, workspace.Islands }
                v42.FilterType = Enum.RaycastFilterType.Include
                _G.PlaySound(v41, script["BloodDragonBoom" .. math.random(1, 4)])
                _G.shakenear(u33.PrimaryPart.Position, 125, 100, 90, -1)
                local v43 = workspace:Raycast(u33.PrimaryPart.Position + Vector3.new(0, 5, 0), Vector3.new(0, -15, 0), v42)
                if v43 then
                    for _ = 1, 10 do
                        local u44 = script.Splat:Clone()
                        u4.apply(u44, u32)
                        u44.CFrame = CFrame.new(v43.Position) * CFrame.new(u6:NextNumber(-10, 10), 0, u28(-10, 10))
                        u44.Parent = u5
                        u24(u44["Aura + Trail"], true, 2)
                        local u45 = 0
                        local u46 = u44.Position
                        local v47 = math.random(-100, 100)
                        local v48 = math.random(-50, -35)
                        local v49 = math.random
                        local u50 = u46 + Vector3.new(v47, v48, v49(-100, 100))
                        local u51 = (CFrame.lookAt(u44.Position:Lerp(u50, 0.25), u50) * CFrame.new(0, math.random(u28(150, 200)), 0)).Position
                        local u52 = u6:NextNumber(0.5, 0.8)
                        u44.CFrame = CFrame.new(u3.QuadBezier(u45, u46, u51, u50))
                        local u53 = nil
                        u53 = u2.Heartbeat:Connect(function(p54) --[[ Line: 176 ]]
                            --[[
                            Upvalues:
                                [1] = u45
                                [2] = u52
                                [3] = u3
                                [4] = u46
                                [5] = u51
                                [6] = u50
                                [7] = u53
                                [8] = u24
                                [9] = u44
                            --]]
                            u45 = u45 + p54 * u52
                            local v55 = u3.QuadBezier(u45, u46, u51, u50)
                            if u45 >= 1 then
                                u53:Disconnect()
                                u24(u44["Aura + Trail"], false)
                                _G.destroy(u44, 3)
                            else
                                u44.CFrame = CFrame.new(v55)
                            end
                        end)
                        task.delay(0.2, function() --[[ Line: 192 ]]
                            --[[
                            Upvalues:
                                [1] = u44
                                [2] = u53
                                [3] = u24
                            --]]
                            local u56 = nil
                            u56 = u44.Touched:Connect(function() --[[ Line: 194 ]]
                                --[[
                                Upvalues:
                                    [1] = u44
                                    [2] = u56
                                    [3] = u53
                                    [4] = u24
                                --]]
                                u44.Anchored = true
                                u56:Disconnect()
                                u53:Disconnect()
                                u24(u44["Aura + Trail"], false)
                                _G.customEmit(u44)
                                _G.destroy(u44, 3)
                                _G.PlaySound(u44, script.BloodDrip, {
                                    ["Pitch"] = math.random(90, 110) / 100
                                })
                            end)
                        end)
                    end
                end
                local u57 = script.BallMesh:Clone()
                u4.apply(u57, u32)
                u57.Position = u33.PrimaryPart.Position + Vector3.new(0, 10, 0)
                u57.Parent = u5
                Flipbook(u57, u7, 16)
                _G.destroy(u57, 2)
                local v58 = _G.tween
                local v59 = u57.Mesh
                local v60 = {
                    3,
                    "Quint",
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }
                local v61 = {}
                local v62 = u57.Mesh.Scale.X * 6
                local v63 = u57.Mesh.Scale.Y * 2
                local v64 = u57.Mesh.Scale.Z * 6
                v61.Scale = Vector3.new(v62, v63, v64)
                v58(v59, v60, v61)
                task.delay(0.3, function() --[[ Line: 217 ]]
                    --[[
                    Upvalues:
                        [1] = u57
                    --]]
                    _G.tween(u57, {
                        0.7,
                        "Quint",
                        Enum.EasingDirection.Out,
                        0,
                        false,
                        0
                    }, {
                        ["Transparency"] = 1
                    })
                end)
            else
                u33.PrimaryPart.CFrame = CFrame.new(v40, u3.CubicBezier(u35 + 0.01, u29.Position, u36, u37, u30.Position))
            end
        end)
        task.defer(function() --[[ Line: 226 ]]
            --[[
            Upvalues:
                [1] = u33
                [2] = u35
                [3] = u4
                [4] = u32
                [5] = u5
            --]]
            local v65 = u33.PrimaryPart.CFrame
            while u35 < 1 do
                local u66 = script["Blood Dragon"].reddrag_body.PM3D_Cylinder3D1:Clone()
                u4.apply(u66, u32)
                local v67 = (v65.Position - u33.PrimaryPart.Position).Magnitude
                local v68 = CFrame.new(v65.Position, u33.PrimaryPart.Position) * CFrame.new(0, 0, -v67 / 2)
                local v69 = CFrame.Angles
                local v70 = math.random(-360, 360)
                u66:PivotTo(v68 * v69(0, 0, (math.rad(v70))))
                local v71 = u66.Size.X
                local v72 = u66.Size.Y
                u66.Size = Vector3.new(v71, v72, v67)
                u66.Parent = u5
                local v73 = _G.PlayEffect
                local v74 = u66:GetPivot()
                local v75 = u66:GetPivot().LookVector * -math.random(25, 45)
                local v76 = math.random(-25, 25)
                local v77 = math.random(35, 55)
                local v78 = math.random
                v73("VampireBloodSplat", nil, 1, v74, 5, 25, 50, { -100, 15 }, v75 + Vector3.new(v76, v77, v78(-25, 25)), u32)
                task.delay(0.2, function() --[[ Line: 241 ]]
                    --[[
                    Upvalues:
                        [1] = u66
                    --]]
                    local v79 = _G.tween
                    local v80 = u66
                    local v81 = {
                        0.25,
                        "Quad",
                        Enum.EasingDirection.Out,
                        0,
                        false,
                        0
                    }
                    local v82 = {}
                    local v83 = u66.Size.Z
                    v82.Size = Vector3.new(0, 0, v83)
                    v79(v80, v81, v82)
                    _G.destroy(u66, 0.25)
                end)
                v65 = u33.PrimaryPart.CFrame
                task.wait(0.02)
            end
        end)
    end
end
return v25