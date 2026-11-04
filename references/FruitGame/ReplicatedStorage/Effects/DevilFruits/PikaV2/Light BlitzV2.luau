 

local v1 = game:GetService("ReplicatedStorage")
local u2 = game:GetService("RunService")
local v3 = game:GetService("Players")
local u4 = game:GetService("TweenService")
require(game:GetService("ReplicatedStorage").Modules.CameraShaker)
require(v1.Modules.CraterHandler)
require(v1.Modules.ParticleTween)
local u5 = require(v1.Modules.Client.WeaponVFXRecolor)
local u6 = v3.LocalPlayer
local u7 = workspace.Effects
local u8 = Random.new()
local u9 = {}
function Flipbook(p10, u11, u12, u13)
    local u14 = p10:FindFirstChildOfClass("SpecialMesh")
    if u14 and u11 then
        task.spawn(function() --[[ Line: 24 ]]
            --[[
            Upvalues:
                [1] = u11
                [2] = u14
                [3] = u12
                [4] = u13
            --]]
            for v15 = 1, #u11 do
                u14.TextureId = u11[v15]
                task.wait(1 / u12)
            end
            if u13 == true then
                u14.Parent:Destroy()
            end
        end)
    end
end
local function u26(p16, p17, p18) --[[ Line: 38 ]]
    local function v24(u19, p20, p21) --[[ Line: 39 ]]
        for _, v22 in ipairs(u19:GetDescendants()) do
            if v22:IsA("ParticleEmitter") or v22:IsA("Trail") then
                v22.Enabled = p20
            end
        end
        if p21 then
            task.delay(p21, function() --[[ Line: 47 ]]
                --[[
                Upvalues:
                    [1] = u19
                --]]
                for _, v23 in ipairs(u19:GetDescendants()) do
                    if v23:IsA("ParticleEmitter") or v23:IsA("Trail") then
                        v23.Enabled = false
                    end
                end
            end)
        end
    end
    if typeof(p16) == "table" then
        for _, v25 in p16 do
            v24(v25, p17, p18)
        end
    else
        v24(p16, p17, p18)
    end
end
local u27 = RaycastParams.new()
u27.FilterType = Enum.RaycastFilterType.Include
u27.FilterDescendantsInstances = { workspace.Ships, workspace.Islands, workspace.Env }
return {
    ["start"] = function(_, p28, u29, u30, p31, u32) --[[ Name: start, Line 83 ]]
        --[[
        Upvalues:
            [1] = u9
            [2] = u5
            [3] = u7
            [4] = u4
            [5] = u27
            [6] = u6
            [7] = u8
            [8] = u26
            [9] = u2
        --]]
        if p28 == "Spawn_Sword" then
            u29:FindFirstChild("HumanoidRootPart")
            local v33 = u29:FindFirstChild("RightHand")
            u9[u29] = {}
            local v34 = script.Sword:Clone()
            u5.apply(v34, u29)
            v34.Parent = u29
            local v35 = Instance.new("Motor6D")
            v35.Name = "Handle"
            local v36 = v34.Handle
            v35.Part0 = v33
            v35.Part1 = v36
            v35.C0 = CFrame.new(0.000102996826, -0.0343222618, -0.000329971313, 1, -1.2403233e-11, 0, -1.2403233e-11, 1, 0, 0, 0, 1)
            v35.C1 = CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            v35.Parent = v33
            local v37 = u9[u29]
            table.insert(v37, v34)
            local v38 = u9[u29]
            table.insert(v38, v35)
            local v39 = script.Sword_Spawn:Clone()
            u5.apply(v39, u29)
            v39.CFrame = v34.Blade.CFrame * CFrame.new(0, 0, 1.5)
            v39.Anchored = false
            v39.Parent = u7
            local v40 = v34.Blade
            local v41 = Instance.new("WeldConstraint")
            v41.Part0 = v39
            v41.Part1 = v40
            v41.Parent = v39
            _G.customEmit(v39)
            _G.destroy(v39, 1.5)
        elseif p28 == "Dash" then
            if u29 == game.Players.LocalPlayer.Character then
                return
            end
            local v42 = u29 or game.Players.LocalPlayer.Character
            local v43 = script.Dash:Clone()
            u5.apply(v43, v42)
            v43:PivotTo(u30 * CFrame.new(0, 1, 0))
            v43.Parent = u7
            _G.customEmit(v43.Dash)
            _G.destroy(v43, 3)
            for _, u44 in v43:GetDescendants() do
                if u44:IsA("Beam") then
                    u44.Enabled = true
                    local v45 = u44.Width0
                    local v46 = u44.Width1
                    u44.Width0 = 0
                    u44.Width1 = 0
                    u4:Create(u44, TweenInfo.new(0.3), {
                        ["Width0"] = v45,
                        ["Width1"] = v46
                    }):Play()
                    if u44:GetAttribute("EmitDuration") then
                        task.delay(u44:GetAttribute("EmitDuration"), function() --[[ Line: 134 ]]
                            --[[
                            Upvalues:
                                [1] = u4
                                [2] = u44
                            --]]
                            u4:Create(u44, TweenInfo.new(0.3), {
                                ["Width0"] = 0,
                                ["Width1"] = 0
                            }):Play()
                        end)
                    else
                        task.delay(0.3, function() --[[ Line: 138 ]]
                            --[[
                            Upvalues:
                                [1] = u4
                                [2] = u44
                            --]]
                            u4:Create(u44, TweenInfo.new(0.3), {
                                ["Width0"] = 0,
                                ["Width1"] = 0
                            }):Play()
                        end)
                    end
                end
            end
            local v47 = workspace:Raycast(v43.Dust.Position, Vector3.new(0, -5, 0), u27)
            if v47 then
                _G.customEmit(v43.Dust)
                for _, v48 in v43.Dust.Ground:GetChildren() do
                    if v48:IsA("ParticleEmitter") then
                        v48.Color = ColorSequence.new(v47.Instance.Color, v47.Instance.Color)
                    end
                end
                for _, v49 in v43.Dust.Ground2:GetChildren() do
                    if v49:IsA("ParticleEmitter") then
                        v49.Color = ColorSequence.new(v47.Instance.Color, v47.Instance.Color)
                    end
                end
                return
            end
        elseif p28 == "Success" then
            local v50 = p31 == u6.Character and true or u29 == u6.Character
            if v50 == true then
                workspace.CurrentCamera.CameraSubject = u29:FindFirstChild("UpperTorso")
            end
            local v51 = script.Uptilt:Clone()
            u5.apply(v51, u29)
            v51.CFrame = u30 * CFrame.new(0, -2.4, -6.4)
            v51.Parent = u7
            _G.customEmit(v51)
            _G.destroy(v51, 2)
            _G.PlaySound(u29.PrimaryPart, script["Hit (5)"]).Parent = u29.PrimaryPart
            task.spawn(function() --[[ Line: 180 ]]
                --[[
                Upvalues:
                    [1] = u30
                    [2] = u32
                    [3] = u8
                    [4] = u5
                    [5] = u29
                    [6] = u7
                    [7] = u26
                    [8] = u2
                --]]
                local u52 = u30 * CFrame.new(0, 0, -5)
                local v53 = u32 / 35
                local v54 = false
                for v55 = 1, 5 do
                    v54 = not v54
                    local u56 = math.random(10, 18)
                    local u57 = v55 * 1.5707963267948966
                    local u58 = 0
                    local u59 = u8:NextNumber(12, 15) * (v54 and 1 or -1)
                    local u60 = v55 * 4 * v53
                    local u61 = script.Light_Trail:Clone()
                    u5.apply(u61, u29)
                    u61.CFrame = u52
                    u61.Parent = u7
                    u26(u61, true)
                    local u62 = os.clock()
                    local u63 = nil
                    u63 = u2.Heartbeat:Connect(function(p64) --[[ Line: 201 ]]
                        --[[
                        Upvalues:
                            [1] = u58
                            [2] = u59
                            [3] = u60
                            [4] = u32
                            [5] = u61
                            [6] = u52
                            [7] = u56
                            [8] = u57
                            [9] = u62
                            [10] = u63
                            [11] = u26
                        --]]
                        u58 = u58 + p64 * u59
                        u60 = u60 + p64 * u32
                        local v65 = u61
                        local v66 = u52
                        local v67 = CFrame.new
                        local v68 = u56
                        local v69 = u58 + u57
                        local v70 = v68 * math.sin(v69)
                        local v71 = u60
                        local v72 = u56
                        local v73 = u58 + u57
                        v65.CFrame = v66 * v67(v70, v71, v72 * math.cos(v73))
                        if os.clock() - u62 >= 1 then
                            u63:Disconnect()
                            u26(u61, false)
                            _G.destroy(u61, 1.5)
                        end
                    end)
                    task.wait(0.05)
                end
            end)
            task.wait(0.266)
            local u74 = script.ComboEffect:Clone()
            u5.apply(u74, u29)
            u74.CFrame = u30 * CFrame.new(1, u32, -6)
            u74.Parent = u7
            u26(u74, true)
            task.delay(0.8, function() --[[ Line: 229 ]]
                --[[
                Upvalues:
                    [1] = u26
                    [2] = u74
                --]]
                u26(u74, false)
                _G.destroy(u74, 2)
            end)
            task.wait(1.28)
            local v75 = script.SlashHit:Clone()
            u5.apply(v75, u29)
            v75.CFrame = u30 * CFrame.new(-0.9096641540527344, u32, -7.859869956970215) * CFrame.fromEulerAnglesYXZ(1.5009844303131104, -1.5707963705062866, 1.5707963705062866)
            v75.Parent = u7
            _G.customEmit(v75)
            _G.destroy(v75, 2)
            local v76 = script.GroundSlam:Clone()
            u5.apply(v76, u29)
            v76.CFrame = u30 * CFrame.new(0, -2.4, -6.4)
            v76.Parent = u7
            _G.customEmit(v76)
            _G.destroy(v76, 4)
            _G.tween(v76.PointLight, {
                0.25,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Range"] = 75,
                ["Brightness"] = 0
            })
            local v77 = workspace:Raycast(v76.CFrame.Position + Vector3.new(0, 3, 0), -v76.CFrame.UpVector * 150, u27)
            if v77 then
                local v78 = script.Debree:Clone()
                u5.apply(v78, u29)
                v78.CFrame = CFrame.new(v77.Position, v77.Position + v77.Normal) * CFrame.Angles(-1.5707963267948966, 0, 0)
                v78.Parent = u7
                _G.customEmit(v78)
                _G.destroy(v78, 4)
                for _, v79 in v78["1"]:GetDescendants() do
                    if v79:IsA("ParticleEmitter") then
                        v79.Color = ColorSequence.new(v77.Instance.Color, v77.Instance.Color)
                    end
                end
                _G.PlayEffect("GroundRocks4", nil, {
                    ["Segments"] = 20,
                    ["Position"] = v78.Position + Vector3.new(0, 1, 0),
                    ["DistanceRandomness"] = Vector2.new(0.25, 1),
                    ["Duration"] = 3,
                    ["TweenDuration"] = 1,
                    ["Radius"] = 25,
                    ["Direction"] = v78.CFrame.UpVector * -30,
                    ["Angle"] = -0.9599310885968813
                })
                _G.PlayEffect("RockDebris", nil, {
                    ["PartCount"] = 10,
                    ["RandomVelocityMagnitude"] = Vector2.new(-60, 60),
                    ["Position"] = v78.Position,
                    ["Direction"] = v78.CFrame.UpVector * 75,
                    ["RaycastDirection"] = v78.CFrame.UpVector * -30,
                    ["Size"] = Vector3.new(1.4, 2.4, 1.4),
                    ["TrailEnabled"] = true
                })
            end
            if v50 == true then
                task.delay(0.1, function() --[[ Line: 292 ]]
                    workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid
                end)
            end
        end
    end
}