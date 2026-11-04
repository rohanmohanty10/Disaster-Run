 

local v1 = game:GetService("ReplicatedStorage")
local u2 = game:GetService("RunService")
local v3 = game:GetService("Players")
local u4 = game:GetService("TweenService")
require(game:GetService("ReplicatedStorage").Modules.CameraShaker)
require(v1.Modules.CraterHandler)
require(v1.Modules.ParticleTween)
local u5 = v3.LocalPlayer
local u6 = workspace.Effects
local u7 = Random.new()
local u8 = {}
function Flipbook(p9, u10, u11, u12)
    local u13 = p9:FindFirstChildOfClass("SpecialMesh")
    if u13 and u10 then
        task.spawn(function() --[[ Line: 23 ]]
            --[[
            Upvalues:
                [1] = u10
                [2] = u13
                [3] = u11
                [4] = u12
            --]]
            for v14 = 1, #u10 do
                u13.TextureId = u10[v14]
                task.wait(1 / u11)
            end
            if u12 == true then
                u13.Parent:Destroy()
            end
        end)
    end
end
local function u25(p15, p16, p17) --[[ Line: 37 ]]
    local function v23(u18, p19, p20) --[[ Line: 38 ]]
        for _, v21 in ipairs(u18:GetDescendants()) do
            if v21:IsA("ParticleEmitter") or v21:IsA("Trail") then
                v21.Enabled = p19
            end
        end
        if p20 then
            task.delay(p20, function() --[[ Line: 46 ]]
                --[[
                Upvalues:
                    [1] = u18
                --]]
                for _, v22 in ipairs(u18:GetDescendants()) do
                    if v22:IsA("ParticleEmitter") or v22:IsA("Trail") then
                        v22.Enabled = false
                    end
                end
            end)
        end
    end
    if typeof(p15) == "table" then
        for _, v24 in p15 do
            v23(v24, p16, p17)
        end
    else
        v23(p15, p16, p17)
    end
end
local u26 = RaycastParams.new()
u26.FilterType = Enum.RaycastFilterType.Include
u26.FilterDescendantsInstances = { workspace.Ships, workspace.Islands, workspace.Env }
return {
    ["start"] = function(_, p27, u28, u29) --[[ Name: start, Line 82 ]]
        --[[
        Upvalues:
            [1] = u8
            [2] = u6
            [3] = u4
            [4] = u26
            [5] = u5
            [6] = u7
            [7] = u25
            [8] = u2
        --]]
        if p27 == "Spawn_Sword" then
            u28:FindFirstChild("HumanoidRootPart")
            local v30 = u28:FindFirstChild("RightHand")
            u8[u28] = {}
            local v31 = script.Sword:Clone()
            v31.Parent = u28
            local v32 = Instance.new("Motor6D")
            v32.Name = "Handle"
            local v33 = v31.Handle
            v32.Part0 = v30
            v32.Part1 = v33
            v32.C0 = CFrame.new(0.000102996826, -0.0343222618, -0.000329971313, 1, -1.2403233e-11, 0, -1.2403233e-11, 1, 0, 0, 0, 1)
            v32.C1 = CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            v32.Parent = v30
            local v34 = u8[u28]
            table.insert(v34, v31)
            local v35 = u8[u28]
            table.insert(v35, v32)
            local v36 = script.Sword_Spawn:Clone()
            v36.CFrame = v31.Blade.CFrame * CFrame.new(0, 0, 1.5)
            v36.Anchored = false
            v36.Parent = u6
            local v37 = v31.Blade
            local v38 = Instance.new("WeldConstraint")
            v38.Part0 = v36
            v38.Part1 = v37
            v38.Parent = v36
            _G.customEmit(v36)
            _G.destroy(v36, 1.5)
        elseif p27 == "Dash" then
            local v39 = script.Dash:Clone()
            v39:PivotTo(u29 * CFrame.new(0, 1, 0))
            v39.Parent = u6
            _G.customEmit(v39.Dash)
            _G.destroy(v39, 3)
            for _, u40 in v39:GetDescendants() do
                if u40:IsA("Beam") then
                    u40.Enabled = true
                    local v41 = u40.Width0
                    local v42 = u40.Width1
                    u40.Width0 = 0
                    u40.Width1 = 0
                    u4:Create(u40, TweenInfo.new(0.3), {
                        ["Width0"] = v41,
                        ["Width1"] = v42
                    }):Play()
                    if u40:GetAttribute("EmitDuration") then
                        task.delay(u40:GetAttribute("EmitDuration"), function() --[[ Line: 126 ]]
                            --[[
                            Upvalues:
                                [1] = u4
                                [2] = u40
                            --]]
                            u4:Create(u40, TweenInfo.new(0.3), {
                                ["Width0"] = 0,
                                ["Width1"] = 0
                            }):Play()
                        end)
                    else
                        task.delay(0.3, function() --[[ Line: 130 ]]
                            --[[
                            Upvalues:
                                [1] = u4
                                [2] = u40
                            --]]
                            u4:Create(u40, TweenInfo.new(0.3), {
                                ["Width0"] = 0,
                                ["Width1"] = 0
                            }):Play()
                        end)
                    end
                end
            end
            local v43 = workspace:Raycast(v39.Dust.Position, Vector3.new(0, -5, 0), u26)
            if v43 then
                _G.customEmit(v39.Dust)
                for _, v44 in v39.Dust.Ground:GetChildren() do
                    if v44:IsA("ParticleEmitter") then
                        v44.Color = ColorSequence.new(v43.Instance.Color, v43.Instance.Color)
                    end
                end
                for _, v45 in v39.Dust.Ground2:GetChildren() do
                    if v45:IsA("ParticleEmitter") then
                        v45.Color = ColorSequence.new(v43.Instance.Color, v43.Instance.Color)
                    end
                end
                return
            end
        elseif p27 == "Success" then
            if u5.Character == u28 then
                workspace.CurrentCamera.CameraSubject = u28:FindFirstChild("UpperTorso")
            end
            local v46 = script.Uptilt:Clone()
            v46.CFrame = u29 * CFrame.new(0, -2.4, -6.4)
            v46.Parent = u6
            _G.customEmit(v46)
            _G.destroy(v46, 2)
            _G.PlaySound(u28.PrimaryPart, script["Hit (5)"]).Parent = u28.PrimaryPart
            task.spawn(function() --[[ Line: 168 ]]
                --[[
                Upvalues:
                    [1] = u29
                    [2] = u7
                    [3] = u6
                    [4] = u25
                    [5] = u2
                --]]
                local u47 = u29 * CFrame.new(0, 0, -5)
                local v48 = false
                for v49 = 1, 5 do
                    v48 = not v48
                    local u50 = math.random(10, 18)
                    local u51 = v49 * 1.5707963267948966
                    local u52 = 0
                    local u53 = u7:NextNumber(12, 15) * (v48 and 1 or -1)
                    local u54 = v49 * 4
                    local u55 = script.Light_Trail:Clone()
                    u55.CFrame = u47
                    u55.Parent = u6
                    u25(u55, true)
                    local u56 = os.clock()
                    local u57 = nil
                    u57 = u2.Heartbeat:Connect(function(p58) --[[ Line: 187 ]]
                        --[[
                        Upvalues:
                            [1] = u52
                            [2] = u53
                            [3] = u54
                            [4] = u55
                            [5] = u47
                            [6] = u50
                            [7] = u51
                            [8] = u56
                            [9] = u57
                            [10] = u25
                        --]]
                        u52 = u52 + p58 * u53
                        u54 = u54 + p58 * 35
                        local v59 = u55
                        local v60 = u47
                        local v61 = CFrame.new
                        local v62 = u50
                        local v63 = u52 + u51
                        local v64 = v62 * math.sin(v63)
                        local v65 = u54
                        local v66 = u50
                        local v67 = u52 + u51
                        v59.CFrame = v60 * v61(v64, v65, v66 * math.cos(v67))
                        if os.clock() - u56 >= 1 then
                            u57:Disconnect()
                            u25(u55, false)
                            _G.destroy(u55, 1.5)
                        end
                    end)
                    task.wait(0.05)
                end
            end)
            task.wait(0.266)
            local u68 = script.ComboEffect:Clone()
            u68.CFrame = u29 * CFrame.new(1, 35, -6)
            u68.Parent = u6
            u25(u68, true)
            task.delay(0.8, function() --[[ Line: 214 ]]
                --[[
                Upvalues:
                    [1] = u25
                    [2] = u68
                --]]
                u25(u68, false)
                _G.destroy(u68, 2)
            end)
            task.wait(1.28)
            local v69 = script.SlashHit:Clone()
            v69.CFrame = u29 * CFrame.new(-0.9096641540527344, 39.413963317871094, -7.859869956970215) * CFrame.fromEulerAnglesYXZ(1.5009844303131104, -1.5707963705062866, 1.5707963705062866)
            v69.Parent = u6
            _G.customEmit(v69)
            _G.destroy(v69, 2)
            local v70 = script.GroundSlam:Clone()
            v70.CFrame = u29 * CFrame.new(0, -2.4, -6.4)
            v70.Parent = u6
            _G.customEmit(v70)
            _G.destroy(v70, 4)
            local v71 = workspace:Raycast(v70.CFrame.Position, -v70.CFrame.UpVector * 15, u26)
            if v71 then
                local v72 = script.Debree:Clone()
                v72.CFrame = CFrame.new(v71.Position, v71.Position + v71.Normal) * CFrame.Angles(-1.5707963267948966, 0, 0)
                v72.Parent = u6
                _G.customEmit(v72)
                _G.destroy(v72, 4)
                for _, v73 in v72["1"]:GetDescendants() do
                    if v73:IsA("ParticleEmitter") then
                        v73.Color = ColorSequence.new(v71.Instance.Color, v71.Instance.Color)
                    end
                end
            end
            if u5.Character == u28 then
                task.delay(0.1, function() --[[ Line: 250 ]]
                    --[[
                    Upvalues:
                        [1] = u28
                    --]]
                    workspace.CurrentCamera.CameraSubject = u28:FindFirstChild("Humanoid")
                end)
            end
        end
    end
}