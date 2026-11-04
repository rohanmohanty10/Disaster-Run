 

local u1 = game:GetService("RunService")
game:GetService("VRService")
local u2 = require(game.ReplicatedStorage.Modules.Client.WeaponVFXRecolor)
local v3 = {}
local u4 = RaycastParams.new()
u4.FilterType = Enum.RaycastFilterType.Whitelist
u4.FilterDescendantsInstances = { workspace.Islands, workspace.Env, workspace.Ships }
local function u10(p5, p6) --[[ Line: 9 ]]
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
function v3.start(_, u11, p12, u13, u14) --[[ Line: 32 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u10
        [3] = u2
        [4] = u4
    --]]
    if _G.checkRenderDistance(u11.PrimaryPart.Position) ~= false then
        u11:FindFirstChildOfClass("Humanoid")
        local v15 = u11.PrimaryPart
        local u16 = p12.PrimaryPart
        local v17 = v15.CFrame
        local u18 = tick()
        if game.Players.LocalPlayer.Character == u11 or game.Players.LocalPlayer.Character == p12 then
            task.spawn(function() --[[ Line: 45 ]]
                --[[
                Upvalues:
                    [1] = u14
                    [2] = u1
                --]]
                local u19 = u14:WaitForChild("camra", 3)
                if u19 ~= nil then
                    local u20 = workspace.CurrentCamera
                    u20.CameraType = Enum.CameraType.Scriptable
                    u1:BindToRenderStep("cyborgCUTSCENE", Enum.RenderPriority.Camera.Value - 1, function() --[[ Line: 52 ]]
                        --[[
                        Upvalues:
                            [1] = u20
                            [2] = u19
                        --]]
                        u20.CFrame = u19.CFrame
                    end)
                    task.delay(3.12, function() --[[ Line: 55 ]]
                        --[[
                        Upvalues:
                            [1] = u1
                            [2] = u20
                        --]]
                        u1:UnbindFromRenderStep("cyborgCUTSCENE")
                        u20.CameraType = Enum.CameraType.Custom
                    end)
                end
            end)
        end
        local function v26(p21) --[[ Line: 77 ]]
            --[[
            Upvalues:
                [1] = u10
                [2] = u13
                [3] = u2
                [4] = u11
            --]]
            local v22 = nil
            local v23 = nil
            for _, v24 in ipairs(script.trail:GetChildren()) do
                local v25 = v24:Clone()
                u10(v25, u13)
                u2.apply(v25, u11)
                if v25.Name == "A0" then
                    v22 = v25.Trail
                    v22.Attachment0 = v25
                else
                    v23 = v25
                end
                v25.Parent = p21
            end
            v22.Attachment1 = v23
            return { v22, v23, v22.Parent }
        end
        for v27 = 1, 2 do
            local v28 = script.booster.cyborgBoosterEffects:Clone()
            u10(v28, u13)
            u2.apply(v28, u11)
            v28.Parent = v27 == 1 and u11:FindFirstChild("RightFoot") or u11:FindFirstChild("LeftFoot")
        end
        local v29 = script.fire:Clone()
        u10(v29, u13)
        u2.apply(v29, u11)
        v29.CFrame = v17 * CFrame.new(0.149993896, 3.24999189, -1, 1, 1.70606612e-7, 0, -1.70606612e-7, 1, 0, 0, 0, 1)
        v29.Parent = workspace.Effects
        _G.destroy(v29, 4)
        local v30 = script.throw:Clone()
        u10(v30, u13)
        u2.apply(v30, u11)
        v30.CFrame = v17 * CFrame.new(0.199996948, 3.59998894, -1.25, -1, 0, -1.70606612e-7, 1.70606612e-7, 0, -1, 0, -1, -0)
        v30.Parent = workspace.Effects
        _G.destroy(v30, 4)
        local v31 = script.fire2:Clone()
        u10(v31, u13)
        u2.apply(v31, u11)
        v31.CFrame = v17 * CFrame.new(-0.475006104, 8.87499237, -1, 1, 1.70606612e-7, 0, -1.70606612e-7, 1, 0, 0, 0, 1)
        v31.Parent = workspace.Effects
        _G.destroy(v31, 4)
        local v32 = script.throw1:Clone()
        u10(v32, u13)
        u2.apply(v32, u11)
        v32.CFrame = v17 * CFrame.new(0.199996948, -2, -1.25, -1, 0, -1.70606612e-7, 1.70606612e-7, 0, -1, 0, -1, -0)
        v32.Parent = workspace.Effects
        _G.destroy(v32, 6)
        local u33 = v26(u11:FindFirstChild("RightFoot"))
        local u34 = v26(u11:FindFirstChild("LeftFoot"))
        task.wait(0.133)
        local u35 = 0.25
        local u36 = 0.5
        local u37 = 1
        task.spawn(function() --[[ Line: 63 ]]
            --[[
            Upvalues:
                [1] = u11
                [2] = u35
                [3] = u36
                [4] = u37
            --]]
            for _, v38 in u11:GetDescendants() do
                if v38:IsA("ParticleEmitter") and v38.Parent.Name == "cyborgBoosterEffects" then
                    v38.TimeScale = u35
                end
            end
            task.wait(u36)
            for _, v39 in u11:GetDescendants() do
                if v39:IsA("ParticleEmitter") and v39.Parent.Name == "cyborgBoosterEffects" then
                    v39.TimeScale = u37
                end
            end
        end)
        for _, v40 in v29:GetChildren() do
            if v40:IsA("ParticleEmitter") then
                v40.Enabled = true
            end
        end
        task.wait(0.367)
        _G.customEmit(v29)
        for _, v41 in v29:GetChildren() do
            if v41:IsA("ParticleEmitter") then
                v41.Enabled = false
            end
        end
        task.wait(0.9)
        local u42 = 0.25
        local u43 = 0.5
        local u44 = 1
        task.spawn(function() --[[ Line: 63 ]]
            --[[
            Upvalues:
                [1] = u11
                [2] = u42
                [3] = u43
                [4] = u44
            --]]
            for _, v45 in u11:GetDescendants() do
                if v45:IsA("ParticleEmitter") and v45.Parent.Name == "cyborgBoosterEffects" then
                    v45.TimeScale = u42
                end
            end
            task.wait(u43)
            for _, v46 in u11:GetDescendants() do
                if v46:IsA("ParticleEmitter") and v46.Parent.Name == "cyborgBoosterEffects" then
                    v46.TimeScale = u44
                end
            end
        end)
        for _, v47 in v31:GetChildren() do
            if v47:IsA("ParticleEmitter") then
                v47.Enabled = true
            end
        end
        task.wait(0.33)
        for _, v48 in v31:GetChildren() do
            if v48:IsA("ParticleEmitter") then
                v48.Enabled = false
            end
        end
        _G.customEmit(v30)
        task.delay(0.89, function() --[[ Line: 160 ]]
            --[[
            Upvalues:
                [1] = u16
            --]]
            if (workspace.CurrentCamera.CFrame.Position - u16.Position).Magnitude <= 150 then
                local v49 = script.Bloom:Clone()
                v49.Parent = game:GetService("Lighting")
                _G.tween(v49, {
                    0.15,
                    "Quad",
                    Enum.EasingDirection.InOut,
                    0,
                    true,
                    0
                }, {
                    ["Threshold"] = 0,
                    ["Intensity"] = 4,
                    ["Size"] = 100
                })
                _G.destroy(v49, 0.5)
                local v50 = script.Blur:Clone()
                v50.Parent = game:GetService("Lighting")
                _G.tween(v50, {
                    0.7,
                    "Quad",
                    Enum.EasingDirection.InOut,
                    0,
                    false,
                    0
                }, {
                    ["Size"] = 0
                })
                _G.destroy(v50, 1)
            end
        end)
        task.wait(0.93)
        _G.customEmit(v32)
        task.delay(0.025, function() --[[ Line: 182 ]]
            --[[
            Upvalues:
                [1] = u18
                [2] = u10
                [3] = u13
                [4] = u2
                [5] = u11
                [6] = u16
                [7] = u4
            --]]
            warn("explosion after " .. tick() - u18)
            local v51 = script.explosion:Clone()
            u10(v51, u13)
            u2.apply(v51, u11)
            v51.CFrame = u16.CFrame
            v51.Parent = workspace.Effects
            _G.customEmit(v51)
            _G.destroy(v51, 7)
            local v52 = workspace:Raycast(u16.Position, u16.CFrame.UpVector * Vector3.new(0, -8, 0), u4)
            if v52 then
                local u53 = script.scorch:Clone()
                local v54 = CFrame.new(v52.Position, v52.Position + v52.Normal)
                local v55 = CFrame.Angles
                local v56 = math.random(0, 360)
                u53.CFrame = v54 * v55(-1.5707963267948966, math.rad(v56), 0)
                u53.Parent = workspace.Effects
                u2.apply(u53, u11)
                _G.tween(u53, {
                    0.1,
                    "Exponential",
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Size"] = Vector3.new(45, 0.15, 45)
                })
                for _, v57 in ipairs(u53:GetDescendants()) do
                    if v57:IsA("Decal") then
                        _G.tween(v57, {
                            0.5,
                            "Quad",
                            Enum.EasingDirection.Out,
                            0,
                            false,
                            0
                        }, {
                            ["Transparency"] = 0.35
                        })
                    end
                end
                task.delay(3, function() --[[ Line: 209 ]]
                    --[[
                    Upvalues:
                        [1] = u53
                    --]]
                    for _, v58 in ipairs(u53:GetDescendants()) do
                        if v58:IsA("Decal") then
                            _G.tween(v58, {
                                2,
                                "Quad",
                                Enum.EasingDirection.Out,
                                0,
                                false,
                                0
                            }, {
                                ["Transparency"] = 1
                            })
                        end
                    end
                end)
                _G.destroy(u53, 6)
            end
        end)
        for v59 = 1, 2 do
            local v60 = u11:FindFirstChild(v59 == 1 and "RightFoot" or "LeftFoot"):FindFirstChild("cyborgBoosterEffects")
            for _, v61 in ipairs(v60:GetChildren()) do
                if v61:IsA("ParticleEmitter") then
                    v61.Enabled = false
                end
            end
            v60.Name = "d"
            _G.destroy(v60, 4)
        end
        u33[1].Enabled = false
        u34[1].Enabled = false
        task.delay(2, function() --[[ Line: 233 ]]
            --[[
            Upvalues:
                [1] = u34
                [2] = u33
            --]]
            for v62, v63 in u34 do
                v63:Destroy()
                u34[v62] = nil
            end
            for v64, v65 in u33 do
                v65:Destroy()
                u34[v64] = nil
            end
        end)
    end
end
return v3