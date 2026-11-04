 

game:GetService("ReplicatedStorage")
local u1 = game:GetService("RunService")
local v2 = game:GetService("Players")
local u3 = game:GetService("TweenService")
local u4 = require(game.ReplicatedStorage.Modules.Client.WeaponVFXRecolor)
local _ = v2.LocalPlayer
local u5 = workspace.Effects
local function u16(p6, p7, p8) --[[ Line: 15 ]]
    local function v14(u9, p10, p11) --[[ Line: 16 ]]
        for _, v12 in ipairs(u9:GetDescendants()) do
            if v12:IsA("ParticleEmitter") or v12:IsA("Trail") then
                v12.Enabled = p10
            end
        end
        if p11 then
            task.delay(p11, function() --[[ Line: 24 ]]
                --[[
                Upvalues:
                    [1] = u9
                --]]
                for _, v13 in ipairs(u9:GetDescendants()) do
                    if v13:IsA("ParticleEmitter") or v13:IsA("Trail") then
                        v13.Enabled = false
                    end
                end
            end)
        end
    end
    if typeof(p6) == "table" then
        for _, v15 in p6 do
            v14(v15, p7, p8)
        end
    else
        v14(p6, p7, p8)
    end
end
local function u47(p17, u18) --[[ Line: 52 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    for _, u19 in p17:GetDescendants() do
        if u19.ClassName == "Beam" then
            local v20 = {}
            local u21 = {}
            for _, v22 in u19.Transparency.Keypoints do
                local v23 = NumberSequenceKeypoint.new
                local v24 = v22.Time
                local v25 = v22.Value
                local v26 = v22.Envelope
                table.insert(v20, v23(v24, v25, v26))
            end
            local u27 = NumberSequence.new(v20)
            for _, v28 in ipairs(u27.Keypoints) do
                local v29 = v28.Value + 1
                local v30 = math.clamp(v29, 0, 1)
                local v31 = NumberSequenceKeypoint.new
                local v32 = v28.Time
                table.insert(u21, v31(v32, v30))
            end
            local u33 = u27.Keypoints[#u27.Keypoints].Time
            local u34 = tick()
            local u35 = 0
            local u36 = nil
            u36 = u1.Heartbeat:Connect(function() --[[ Line: 76 ]]
                --[[
                Upvalues:
                    [1] = u35
                    [2] = u34
                    [3] = u33
                    [4] = u18
                    [5] = u27
                    [6] = u21
                    [7] = u19
                    [8] = u36
                --]]
                u35 = tick() - u34
                local v37 = u33
                local v38 = u35
                local v39 = math.min(v37, v38)
                local v40 = v39 / u33 / u18
                local v41 = {}
                for v42, v43 in ipairs(u27.Keypoints) do
                    local v44 = v43.Value + (u21[v42].Value - v43.Value) * v40
                    local v45 = NumberSequenceKeypoint.new
                    local v46 = v43.Time
                    table.insert(v41, v45(v46, v44))
                end
                u19.Transparency = NumberSequence.new(v41)
                if u33 <= v39 then
                    u36:Disconnect()
                    u36 = nil
                end
            end)
        end
    end
end
local u48 = RaycastParams.new()
u48.FilterType = Enum.RaycastFilterType.Include
u48.FilterDescendantsInstances = { workspace.Terrain, workspace.Islands, workspace.Env }
return {
    ["start"] = function(_, p49, p50) --[[ Name: start, Line 108 ]]
        --[[
        Upvalues:
            [1] = u4
            [2] = u5
            [3] = u48
            [4] = u16
            [5] = u3
            [6] = u47
        --]]
        local u51 = p50.char
        local v52 = p50.Goal
        local v53 = p50.dashDuration
        local v54 = p50.Color
        if u51 == nil then
            return
        elseif _G.checkRenderDistance(u51.PrimaryPart.Position) == false then
            return
        elseif p49 == "Dash" then
            local v55 = u51.HumanoidRootPart
            local v56 = script.WindEmit:Clone()
            v56.CFrame = v55.CFrame * CFrame.Angles(-1.5707963267948966, 0, 0)
            if v54 then
                _G.recolorParticles(v56, v54)
                u4.apply(v56, u51)
            end
            v56.Parent = u5
            _G.customEmit(v56)
            _G.destroy(v56, 3)
            local v57 = script.DashAir:Clone()
            v57.CFrame = v55.CFrame
            if v54 then
                _G.recolorParticles(v57, v54)
                u4.apply(v57, u51)
            end
            v57.Parent = u5
            _G.customEmit(v57)
            _G.destroy(v57, 3)
            if workspace:Raycast(v55.Position, Vector3.new(0, -5, 0), u48) then
                local v58 = script.DashGround:Clone()
                v58.CFrame = v55.CFrame
                if v54 then
                    _G.recolorParticles(v58, v54)
                    u4.apply(v58, u51)
                end
                v58.Parent = u5
                _G.customEmit(v58)
                _G.destroy(v58, 3)
            end
            local u59 = script.MainDash:Clone()
            u59.CFrame = v55.CFrame
            if v54 then
                _G.recolorParticles(u59, v54)
                u4.apply(u59, u51)
            end
            u59.Parent = u5
            u16(u59, true)
            local v60 = Instance.new("WeldConstraint")
            v60.Part0 = u59
            v60.Part1 = v55
            v60.Parent = u59
            for _, v61 in u59:GetDescendants() do
                if v61.ClassName == "Beam" then
                    local v62 = v61.Width0
                    local v63 = v61.Width1
                    v61.Width0 = 0
                    v61.Width1 = 0
                    u3:Create(v61, TweenInfo.new(0.1), {
                        ["Width0"] = v62,
                        ["Width1"] = v63
                    }):Play()
                end
            end
            local u64 = script.WindBeam:Clone()
            if v54 then
                u4.apply(u64, u51)
            end
            u64:PivotTo(v55.CFrame)
            u64.Parent = u5
            local v65 = u64.PartBeam1
            local v66 = Instance.new("WeldConstraint")
            v66.Part0 = v65
            v66.Part1 = v55
            v66.Parent = v65
            u47(u64, 0.6)
            for _, v67 in u64:GetDescendants() do
                if v67.ClassName == "Beam" then
                    u3:Create(v67, TweenInfo.new(1), {
                        ["TextureSpeed"] = 0
                    }):Play()
                end
            end
            local u68 = _G.tween(u51.PrimaryPart, {
                v53,
                Enum.EasingStyle.Linear,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["CFrame"] = v52
            })
            local u69 = false
            task.spawn(function() --[[ Line: 193 ]]
                --[[
                Upvalues:
                    [1] = u51
                    [2] = u68
                    [3] = u69
                --]]
                local v70 = tick()
                repeat
                    task.wait()
                until u51:GetAttribute("SlashTackleGrabbed") ~= nil or tick() - v70 >= 3
                if u68.Destroy then
                    u68:Destroy()
                end
                u69 = true
            end)
            u68.Completed:Connect(function() --[[ Line: 206 ]]
                --[[
                Upvalues:
                    [1] = u68
                    [2] = u69
                --]]
                u68:Destroy()
                u69 = true
            end)
            task.spawn(function() --[[ Line: 211 ]]
                --[[
                Upvalues:
                    [1] = u69
                    [2] = u16
                    [3] = u59
                    [4] = u64
                    [5] = u47
                    [6] = u3
                --]]
                local v71 = os.clock()
                repeat
                    task.wait()
                until u69 == true or os.clock() - v71 > 5
                if u69 then
                    u16(u59, false)
                    u47(u64, 0.1)
                    for _, v72 in u59:GetDescendants() do
                        if v72.ClassName == "Beam" then
                            u3:Create(v72, TweenInfo.new(0.2), {
                                ["Width0"] = 0,
                                ["Width1"] = 0
                            }):Play()
                        end
                    end
                    _G.destroy(u59, 3)
                    _G.destroy(u64, 3)
                else
                    warn("TIMEOUT: DarkBladeGrab yield expired")
                    u16(u59, false)
                    _G.destroy(u59, 0)
                    _G.destroy(u64, 0)
                end
            end)
        elseif p49 == "Grab" then
            local v73 = u51.HumanoidRootPart
            local v74 = p50.Speed
            local v75 = script.Hit:Clone()
            v75.CFrame = v73.CFrame * CFrame.new(0, 0, -5) * CFrame.Angles(0, 0, -0.7853981633974483)
            if v54 then
                _G.recolorParticles(v75, v54)
                u4.apply(v75, u51)
            end
            v75.Parent = u5
            _G.customEmit(v75)
            _G.destroy(v75, 3)
            task.wait(1.65 / v74)
            local v76 = script.Abdomen:Clone()
            v76.CFrame = v73.CFrame * CFrame.new(0, 0, -3) * CFrame.Angles(0, 0, 0.2617993877991494)
            if v54 then
                _G.recolorParticles(v76, v54)
                u4.apply(v76, u51)
            end
            v76.Parent = u5
            u16(v76, true)
            _G.destroy(v76, 3)
            task.wait(1 / v74)
            u16(v76, false)
            local v77 = script.Uppercut:Clone()
            v77.CFrame = v73.CFrame * CFrame.new(0, 0, -3) * CFrame.Angles(0, 0, 0.2617993877991494)
            if v54 then
                _G.recolorParticles(v77, v54)
                u4.apply(v77, u51)
            end
            v77.Parent = u5
            _G.customEmit(v77)
            _G.destroy(v77, 3)
        end
    end
}