 

game:GetService("ReplicatedStorage")
local u1 = game:GetService("RunService")
local v2 = game:GetService("Players")
local u3 = game:GetService("TweenService")
local u4 = require(game.ReplicatedStorage.Modules.Trove)
local _ = v2.LocalPlayer
local u5 = workspace.Effects
local u6 = {}
local function u17(p7, p8, p9) --[[ Line: 18 ]]
    local function v15(u10, p11, p12) --[[ Line: 19 ]]
        for _, v13 in ipairs(u10:GetDescendants()) do
            if v13:IsA("ParticleEmitter") or v13:IsA("Trail") then
                v13.Enabled = p11
            end
        end
        if p12 then
            task.delay(p12, function() --[[ Line: 27 ]]
                --[[
                Upvalues:
                    [1] = u10
                --]]
                for _, v14 in ipairs(u10:GetDescendants()) do
                    if v14:IsA("ParticleEmitter") or v14:IsA("Trail") then
                        v14.Enabled = false
                    end
                end
            end)
        end
    end
    if typeof(p7) == "table" then
        for _, v16 in p7 do
            v15(v16, p8, p9)
        end
    else
        v15(p7, p8, p9)
    end
end
local function u48(p18, u19) --[[ Line: 48 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    for _, u20 in p18:GetDescendants() do
        if u20.ClassName == "Beam" then
            local v21 = {}
            local u22 = {}
            for _, v23 in u20.Transparency.Keypoints do
                local v24 = NumberSequenceKeypoint.new
                local v25 = v23.Time
                local v26 = v23.Value
                local v27 = v23.Envelope
                table.insert(v21, v24(v25, v26, v27))
            end
            local u28 = NumberSequence.new(v21)
            for _, v29 in ipairs(u28.Keypoints) do
                local v30 = v29.Value + 1
                local v31 = math.clamp(v30, 0, 1)
                local v32 = NumberSequenceKeypoint.new
                local v33 = v29.Time
                table.insert(u22, v32(v33, v31))
            end
            local u34 = u28.Keypoints[#u28.Keypoints].Time
            local u35 = tick()
            local u36 = 0
            local u37 = nil
            u37 = u1.Heartbeat:Connect(function() --[[ Line: 72 ]]
                --[[
                Upvalues:
                    [1] = u36
                    [2] = u35
                    [3] = u34
                    [4] = u19
                    [5] = u28
                    [6] = u22
                    [7] = u20
                    [8] = u37
                --]]
                u36 = tick() - u35
                local v38 = u34
                local v39 = u36
                local v40 = math.min(v38, v39)
                local v41 = v40 / u34 / u19
                local v42 = {}
                for v43, v44 in ipairs(u28.Keypoints) do
                    local v45 = v44.Value + (u22[v43].Value - v44.Value) * v41
                    local v46 = NumberSequenceKeypoint.new
                    local v47 = v44.Time
                    table.insert(v42, v46(v47, v45))
                end
                u20.Transparency = NumberSequence.new(v42)
                if u34 <= v40 then
                    u37:Disconnect()
                end
            end)
        end
    end
end
return {
    ["start"] = function(_, p49, p50, _) --[[ Name: start, Line 100 ]]
        --[[
        Upvalues:
            [1] = u6
            [2] = u5
            [3] = u17
            [4] = u3
            [5] = u1
            [6] = u4
            [7] = u48
        --]]
        local v51 = p50.PrimaryPart
        if _G.checkRenderDistance(v51.Position) == false then
            return
        elseif p49 == "Start" then
            u6[p50] = {}
            local u52 = script.SeductionVFXModel:Clone()
            u52:PivotTo(v51.CFrame * CFrame.new(0, -3, 0))
            u52.Parent = u5
            u17(u52.Aroma, true)
            u17(u52.Charge, true)
            local v53 = u6[p50]
            table.insert(v53, u52)
            for _, v54 in u52.Beam["Meshes/half sphere"]:GetDescendants() do
                if v54:IsA("Beam") then
                    local v55 = v54.Width0
                    local v56 = v54.Width1
                    v54.Width0 = 0
                    v54.Width1 = 0
                    u3:Create(v54, TweenInfo.new(0.4), {
                        ["Width0"] = v55,
                        ["Width1"] = v56
                    }):Play()
                end
            end
            local v62 = u1.Heartbeat:Connect(function(p57) --[[ Line: 129 ]]
                --[[
                Upvalues:
                    [1] = u52
                --]]
                local v58 = u52.Beam["Meshes/half sphere"]
                local v59 = v58.CFrame
                local v60 = CFrame.Angles
                local v61 = p57 * 110
                v58.CFrame = v59 * v60(0, math.rad(v61), 0)
            end)
            u52.Charge.loopSFX:Play()
            _G.PlaySound(u52.Charge, script["Audio/HeartCharmStart"])
            local v63 = u4.new()
            v63:AttachToInstance(u52)
            v63:Add(v62)
            local v64 = u6[p50]
            table.insert(v64, v62)
        elseif p49 == "End" then
            if u6[p50] == nil then
                return
            end
            local v65 = u6[p50]
            local v66, v67 = table.unpack(v65)
            u17(v66, false)
            _G.customEmit(v66.AromaRelease)
            _G.destroy(v66, 3)
            v66.Aroma:Destroy()
            v66.Beam:ScaleTo(2)
            u3:Create(v66.Charge.loopSFX, TweenInfo.new(0.2), {
                ["Volume"] = 0
            }):Play()
            for _, v68 in v66.Beam["Meshes/half sphere"]:GetDescendants() do
                if v68:IsA("Beam") then
                    v68.Enabled = false
                    local _ = v68.Width0
                    local _ = v68.Width1
                    v68.Width0 = 0
                    v68.Width1 = 0
                end
            end
            v67:Disconnect()
            _G.PlaySound(v66.Beam["Meshes/half sphere"].CFrame, script["Audio/HeartCharmBoom"])
            v66.Beam["Meshes/half sphere"].CFrame = v66.Beam["Meshes/half sphere"].CFrame * CFrame.new(0, 15, 0)
            u3:Create(v66.Beam["Meshes/half sphere"], TweenInfo.new(0.7), {
                ["CFrame"] = v66.Beam["Meshes/half sphere"].CFrame * CFrame.Angles(0, 3.141592653589793, 0)
            }):Play()
            u48(v66.Beam["Meshes/half sphere"], 0.6)
            _G.destroy(v66, 5)
        end
    end
}