 

local u1 = game:GetService("TweenService")
local u2 = {
    14399492802,
    14399492596,
    14399492365,
    14399492055,
    14399491725,
    14399491447,
    14399491149,
    14399490913,
    14399490678,
    14399490439,
    14399490165,
    14399489881,
    14399489682,
    14399489443,
    14399489049
}
local u3 = Random.new()
local u4 = workspace.Effects
local function u23(u5) --[[ Line: 7 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u1
        [3] = u2
    --]]
    local u6 = u5.Duration
    local u7 = script.Slash:Clone()
    u7.CFrame = u5.CFrame
    u7.SlashDecal.Transparency = u5.InitialTransparency
    u7.Anchored = false
    u7.Mesh.Scale = u5.Scale
    u7.Parent = u4
    _G.destroy(u7, u6)
    u1:Create(u7.SlashDecal, TweenInfo.new(u6), {
        ["Transparency"] = 1
    }):Play()
    u1:Create(u7.Mesh, TweenInfo.new(u6), {
        ["Scale"] = u5.Endscale
    }):Play()
    local u8 = Instance.new("Weld")
    u8.Part0 = u7
    u8.Part1 = u5.Character.HumanoidRootPart
    u8.C0 = u8.Part0.CFrame:Inverse() * u8.Part1.CFrame
    u8.Parent = u7
    task.spawn(function() --[[ Line: 39 ]]
        --[[
        Upvalues:
            [1] = u5
            [2] = u8
            [3] = u1
            [4] = u6
        --]]
        local v9 = u5.Rotation
        local v10 = u5.yVector
        for v11 = 1, 8 do
            if not (u8.Part0 and u8.Part1) then
                return
            end
            local v12 = u1
            local v13 = u8
            local v14 = TweenInfo.new(u6 / 8, Enum.EasingStyle.Linear)
            local v15 = {}
            local v16 = u8.Part0.CFrame
            local v17 = CFrame.Angles
            local v18 = v9 * (8 - v11) / 8
            local v19 = v16 * v17(0, -math.rad(v18), 0)
            local v20 = v10 * (8 - v11) / 8
            v15.C0 = (v19 + Vector3.new(0, v20, 0)):Inverse() * u8.Part1.CFrame
            v12:Create(v13, v14, v15):Play()
            task.wait(u6 / 8)
        end
    end)
    task.spawn(function() --[[ Line: 58 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u8
            [3] = u7
            [4] = u6
        --]]
        for v21 = 1, #u2 do
            if not (u8.Part0 and u8.Part1) then
                return
            end
            local v22 = u7:FindFirstChild("SlashDecal")
            if not v22 then
                return
            end
            v22.Texture = "rbxassetid://" .. u2[v21]
            task.wait(u6 / #u2)
        end
    end)
end
return {
    ["start"] = function(_, p24) --[[ Name: start, Line 73 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u23
        --]]
        local v25 = p24.Character
        local v26 = p24.Duration
        if _G.checkRenderDistance(v25.PrimaryPart.Position) ~= false then
            local v27 = script.Particles.Attachment:Clone()
            for _, u28 in pairs(v27:GetChildren()) do
                task.delay(v26, function() --[[ Line: 81 ]]
                    --[[
                    Upvalues:
                        [1] = u28
                    --]]
                    u28.Enabled = false
                end)
            end
            v27.Parent = v25.HumanoidRootPart
            _G.destroy(v27, v26 + 2)
            for _ = 1, 20 do
                if not v25.Parent or v25.Parent and v25.Parent.Name == "DeadNPCs" then
                    return
                end
                local v29 = Vector3.new(3, 5, 3) * u3:NextNumber(5, 10)
                local v30 = u23
                local v31 = {}
                local v32 = v25.HumanoidRootPart.CFrame
                local v33 = CFrame.Angles
                local v34 = 6.283185307179586 * math.random()
                local v35 = u3:NextNumber(-15, 15)
                v31.CFrame = v32 * v33(0, v34, (math.rad(v35)))
                v31.Character = v25
                v31.Scale = v29
                v31.EndScale = v29 * u3:NextNumber(1, 3)
                v31.InitialTransparency = 0.25
                v31.Duration = 1
                v31.Rotation = 179
                v31.yVector = 0
                v30(v31)
                local v36 = Vector3.new(1, 10, 1) * u3:NextNumber(5, 10)
                local v37 = u23
                local v38 = {}
                local v39 = v25.HumanoidRootPart.CFrame
                local v40 = CFrame.Angles
                local v41 = 6.283185307179586 * math.random()
                local v42 = u3:NextNumber(-15, 15)
                v38.CFrame = v39 * v40(0, v41, (math.rad(v42)))
                v38.Character = v25
                v38.Scale = v36
                v38.EndScale = v36 * Vector3.new(1, 2, 1)
                v38.InitialTransparency = 0.9
                v38.Duration = 0.5
                v38.Rotation = 50
                v38.yVector = 0
                v37(v38)
                local _, v43 = p24.Character:GetBoundingBox()
                local v44 = Vector3.new(35, 85, 35) * u3:NextNumber(5, 10)
                local v45 = Vector3.new(3, 25, 3) * u3:NextNumber(2, 3)
                local v46 = u23
                local v47 = {}
                local v48 = v25.HumanoidRootPart.CFrame * CFrame.new(0, -v43.Y / 2, 0)
                local v49 = CFrame.Angles
                local v50 = 6.283185307179586 * math.random()
                local v51 = u3:NextNumber(-15, 15)
                v47.CFrame = v48 * v49(0, v50, (math.rad(v51)))
                v47.Character = v25
                v47.Scale = v45
                v47.EndScale = v44
                v47.InitialTransparency = 0.9
                v47.Duration = 0.5
                v47.Rotation = 10
                v47.yVector = 2
                v46(v47)
                task.wait(v26 / 20)
            end
        end
    end
}