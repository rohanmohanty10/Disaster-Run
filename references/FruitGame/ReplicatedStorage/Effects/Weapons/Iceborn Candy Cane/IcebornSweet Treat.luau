 

local v1 = {}
local u2 = game:GetService("TweenService")
game:GetService("RunService")
local u3 = setmetatable({}, {
    ["__mode"] = "k"
})
local v4 = RaycastParams.new()
v4.FilterDescendantsInstances = { workspace.Env, workspace.Islands, workspace.Ships }
v4.FilterType = Enum.RaycastFilterType.Include
local _ = _G.tween
local v5 = game:GetService("ReplicatedStorage")
local u6 = require(v5.Modules.Client.WeaponVFXRecolor)
local function u15(p7, p8) --[[ Line: 33 ]]
    local v9 = p7.Keypoints
    if #v9 == 0 then
        return 0, 0
    end
    if p8 <= v9[1].Time then
        return v9[1].Value, v9[1].Envelope
    end
    if v9[#v9].Time <= p8 then
        return v9[#v9].Value, v9[#v9].Envelope
    end
    for v10 = 1, #v9 - 1 do
        local v11 = v9[v10]
        local v12 = v9[v10 + 1]
        if v11.Time <= p8 and p8 <= v12.Time then
            local v13 = v12.Time - v11.Time
            local v14 = v13 <= 0 and 0 or (p8 - v11.Time) / v13
            return v11.Value + (v12.Value - v11.Value) * v14, v11.Envelope + (v12.Envelope - v11.Envelope) * v14
        end
    end
    return v9[#v9].Value, v9[#v9].Envelope
end
local function u20(p16) --[[ Line: 53 ]]
    local v17 = table.create(#p16.Keypoints)
    for v18, v19 in ipairs(p16.Keypoints) do
        v17[v18] = NumberSequenceKeypoint.new(v19.Time, 1, v19.Envelope)
    end
    return NumberSequence.new(v17)
end
local function u32(p21, p22, p23) --[[ Line: 61 ]]
    --[[
    Upvalues:
        [1] = u15
    --]]
    local v24 = p22.Keypoints
    local v25 = table.create(#v24)
    for v26, v27 in ipairs(v24) do
        local v28, v29 = u15(p21, v27.Time)
        local v30, v31 = u15(p22, v27.Time)
        v25[v26] = NumberSequenceKeypoint.new(v27.Time, v28 + (v30 - v28) * p23, v29 + (v31 - v29) * p23)
    end
    return NumberSequence.new(v25)
end
local function u40(u33, u34, u35, p36) --[[ Line: 78 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u32
    --]]
    u33.Transparency = u34
    local u37 = Instance.new("NumberValue")
    u37.Value = 0
    local v38 = u2:Create(u37, TweenInfo.new(p36, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        ["Value"] = 1
    })
    local u39 = u37:GetPropertyChangedSignal("Value"):Connect(function() --[[ Line: 89 ]]
        --[[
        Upvalues:
            [1] = u33
            [2] = u32
            [3] = u34
            [4] = u35
            [5] = u37
        --]]
        u33.Transparency = u32(u34, u35, u37.Value)
    end)
    v38.Completed:Connect(function() --[[ Line: 92 ]]
        --[[
        Upvalues:
            [1] = u39
            [2] = u37
            [3] = u33
            [4] = u35
        --]]
        if u39 then
            u39:Disconnect()
        end
        u37:Destroy()
        u33.Transparency = u35
    end)
    v38:Play()
    return v38
end
function v1.start(_, p41, p42) --[[ Line: 114 ]]
    --[[
    Upvalues:
        [1] = u6
        [2] = u3
        [3] = u40
        [4] = u20
    --]]
    if p41:FindFirstChild("HumanoidRootPart") then
        local v43 = p41:FindFirstChild("UpperTorso")
        if v43 then
            local v44 = p42 - workspace:GetServerTimeNow()
            local u45 = script.Cold:Clone()
            u6.apply(u45, p41)
            local v46, v47, v48 = _G.getRayFloor(p41.HumanoidRootPart.CFrame, 10)
            if v46 then
                u45.CFrame = CFrame.new(v47, v47 + v48)
                _G.vfxToFloor(u45.GroundAttachment, {
                    ["StartCFrame"] = p41.PrimaryPart.CFrame,
                    ["Depth"] = 6,
                    ["Offset"] = CFrame.new()
                })
            else
                local v49 = u45:GetDescendants()
                for v50 = 1, #v49 do
                    if v49[v50]:GetAttribute("IsFloor") then
                        v49[v50]:Destroy()
                    end
                end
            end
            for _, v51 in u45:GetChildren() do
                if v51.Name == "AT1" then
                    v51.Parent = v43
                    local v52 = math.random(-150, 150)
                    local v53 = math.random(-100, 100)
                    local v54 = math.random
                    v51.Position = Vector3.new(v52, v53, v54(-150, 150)) / 100
                end
            end
            u45.Parent = workspace.Effects
            _G.customEmit(u45)
            for _, v55 in u45:GetChildren() do
                if v55:IsA("Beam") then
                    local v56 = u3[v55]
                    if v56 == nil then
                        v56 = v55.Transparency
                        u3[v55] = v56
                    end
                    u40(v55, u20(v56), v56, 0.4)
                end
            end
            _G.destroy(u45, 4)
            local u57 = script.Surround:Clone()
            u6.apply(u57, p41)
            u57.Position = p41.HumanoidRootPart.Position
            local v58 = Instance.new("Weld")
            v58.Part0 = p41.PrimaryPart
            v58.Part1 = u57
            v58.Parent = u57
            u57.Parent = workspace.Effects
            task.delay(0.5, function() --[[ Line: 167 ]]
                --[[
                Upvalues:
                    [1] = u57
                    [2] = u45
                    [3] = u3
                    [4] = u20
                    [5] = u40
                --]]
                _G.particleEnabled(u57, false)
                for _, v59 in u45:GetChildren() do
                    if v59:IsA("Beam") then
                        local v60 = u3[v59]
                        if v60 == nil then
                            v60 = v59.Transparency
                            u3[v59] = v60
                        end
                        local v61 = u20(v60)
                        u40(v59, v59.Transparency, v61, 0.2)
                    end
                end
                _G.destroy(u57, 3)
            end)
            task.wait(v44)
            local v62 = script.Attachment:Clone()
            u6.apply(v62, p41)
            v62.Parent = p41.RightHand
            _G.customEmit(v62)
            _G.destroy(v62, 3)
            task.wait(0.1)
            local v63 = script.Heal:Clone()
            u6.apply(v63, p41)
            v63.Position = v62.WorldPosition
            v63.Parent = workspace.Effects
            _G.customEmit(v63)
            _G.destroy(v63, 3)
            local v64 = script.Burst:Clone()
            u6.apply(v64, p41)
            v64.Position = p41.HumanoidRootPart.Position - Vector3.new(0, 2.5, 0)
            v64.Parent = workspace.Effects
            _G.customEmit(v64)
            _G.destroy(v64, 3)
            local v65 = {}
            for _, v66 in script.Folder:GetChildren() do
                local v67 = v66:Clone()
                u6.apply(v67, p41)
                v67.Parent = v43
                table.insert(v65, v67)
            end
            task.wait(2)
            for _, v68 in v65 do
                v68.Enabled = false
                _G.destroy(v68, 4)
            end
        end
    else
        return
    end
end
return v1