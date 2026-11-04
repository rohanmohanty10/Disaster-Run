 

local u1 = game:GetService("RunService")
local v2 = RaycastParams.new()
v2.FilterType = Enum.RaycastFilterType.Include
v2.FilterDescendantsInstances = workspace.Env:GetDescendants()
local u3 = script
local v4 = {}
local u5 = game:GetService("TweenService")
local u6 = Random.new()
local u7 = {
    "rbxassetid://15563680836",
    "rbxassetid://15563680760",
    "rbxassetid://15563680632",
    "rbxassetid://15563676324",
    "rbxassetid://15563676206",
    "rbxassetid://15563676043",
    "rbxassetid://15563675889",
    "rbxassetid://15563675703",
    "rbxassetid://15563675618",
    "rbxassetid://15563669564",
    "rbxassetid://15563669408",
    "rbxassetid://15563669274",
    "rbxassetid://15563669108",
    "rbxassetid://15563668904",
    "rbxassetid://15563668801",
    ""
}
local u8 = {
    "",
    "rbxassetid://15438802340",
    "rbxassetid://15438802166",
    "rbxassetid://15438801989",
    "rbxassetid://15438801859",
    "rbxassetid://15438801747",
    "rbxassetid://15438794123",
    "rbxassetid://15438794123",
    "rbxassetid://15438793585",
    "rbxassetid://15438793449",
    "rbxassetid://15438793327",
    "rbxassetid://15438786375",
    "rbxassetid://15438786206",
    "rbxassetid://15438786102",
    "rbxassetid://15438785962",
    "rbxassetid://15438785756",
    ""
}
local function u13(p9, p10) --[[ Line: 98 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u6
        [3] = u5
    --]]
    local v11 = u3.Cone:Clone()
    v11.Position = p9
    local v12 = u6
    v11.Orientation = Vector3.new(-90, 0, v12:NextNumber(0, 360))
    v11.Parent = p10
    u5:Create(v11.Mesh, TweenInfo.new(0.2, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
        ["Scale"] = Vector3.new(8, 8, 0.1)
    }):Play()
    u5:Create(v11, TweenInfo.new(0.2, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
        ["Position"] = p9 + Vector3.new(0, -3, 0)
    }):Play()
    u5:Create(v11.Decal, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        ["Transparency"] = 1
    }):Play()
    _G.destroy(v11, 1)
end
function v4.start(_, u14, p15, p16, p17) --[[ Line: 121 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u1
        [3] = u13
        [4] = u6
        [5] = u8
        [6] = u7
    --]]
    local _ = p15.PrimaryPart
    if p17 then
        local u18 = p15.PrimaryPart
        local v19 = p17.PrimaryPart
        local u20 = u3.BigEmit:Clone()
        u20.CFrame = v19.CFrame
        u20.Parent = workspace.Effects
        _G.destroy(u20, 5)
        task.delay(0.65, function() --[[ Line: 132 ]]
            --[[
            Upvalues:
                [1] = u3
                [2] = u18
                [3] = u20
            --]]
            local v21 = u3.Shine:Clone()
            v21.CFrame = u18.CFrame * CFrame.new(-1.5, -1.5, 0)
            v21.Parent = workspace.Effects
            _G.customEmit(v21)
            local v22 = u20
            _G.customEmit(v22)
            _G.destroy(v21, 5)
        end)
        task.spawn(function() --[[ Line: 145 ]]
            --[[
            Upvalues:
                [1] = u3
                [2] = u18
                [3] = u1
            --]]
            local u23 = u3.AfterAura:Clone()
            u23.CFrame = u18.CFrame
            u23.Parent = workspace.Effects
            local u24 = false
            local u25 = tick()
            local u26 = nil
            u26 = u1.Heartbeat:Connect(function(p27) --[[ Line: 154 ]]
                --[[
                Upvalues:
                    [1] = u23
                    [2] = u25
                    [3] = u24
                    [4] = u26
                --]]
                u23.CFrame = u23.CFrame * CFrame.Angles(0, 6.283185307179586 * p27, 0)
                if tick() - u25 >= 0.5 and u24 == false then
                    u24 = true
                    local v28 = u23
                    for _, v29 in pairs(v28:GetDescendants()) do
                        if v29:IsA("ParticleEmitter") then
                            v29.Enabled = false
                        end
                    end
                    u26:Disconnect()
                    u26 = nil
                    _G.destroy(u23, 5)
                end
            end)
        end)
        task.spawn(function() --[[ Line: 169 ]]
            --[[
            Upvalues:
                [1] = u13
                [2] = u18
            --]]
            for _ = 1, 8 do
                u13(u18.Position, workspace.Effects)
                task.wait(0.075)
            end
        end)
        local v30 = tick()
        while tick() - v30 <= 0.5 do
            local u31 = u18.CFrame * CFrame.Angles(0, 0, u6:NextNumber(0, 6.283185307179586))
            local u32 = workspace.Effects
            local u33 = Vector3.new(1, 1, 1) * u6:NextNumber(0.2, 0.35)
            local u34 = true
            task.spawn(function() --[[ Line: 77 ]]
                --[[
                Upvalues:
                    [1] = u3
                    [2] = u31
                    [3] = u33
                    [4] = u32
                    [5] = u8
                    [6] = u34
                    [7] = u6
                --]]
                local v35 = u3.Slash:Clone()
                v35.CFrame = u31 * CFrame.Angles(0, 1.5707963267948966, 0)
                v35.Mesh.Scale = u33
                v35.Parent = u32
                for v36, v37 in pairs(u8) do
                    v35.Decal.Texture = v37
                    local v38 = #u8 * 0.4
                    if v36 == math.round(v38) and u34 == true then
                        local v39 = v35.Particles
                        local v40 = u6:NextNumber(4, 7)
                        v39.Position = Vector3.new(v40, 0, 0)
                        _G.customEmit(v35)
                    end
                    task.wait()
                end
                _G.destroy(v35, 1)
            end)
            task.wait(u6:NextNumber(0.06, 0.2))
        end
        for _, v41 in pairs(u20:GetDescendants()) do
            if v41:IsA("ParticleEmitter") then
                v41.Enabled = false
            end
        end
    else
        local u42 = Instance.new("Folder")
        u42.Name = "EffectsFolder"
        u42.Parent = workspace.Effects
        local u43 = Vector3.new(0.3, 0.3, 0.3)
        local u44 = nil
        task.spawn(function() --[[ Line: 77 ]]
            --[[
            Upvalues:
                [1] = u3
                [2] = u14
                [3] = u43
                [4] = u42
                [5] = u8
                [6] = u44
                [7] = u6
            --]]
            local v45 = u3.Slash:Clone()
            v45.CFrame = u14 * CFrame.Angles(0, 1.5707963267948966, 0)
            v45.Mesh.Scale = u43
            v45.Parent = u42
            for v46, v47 in pairs(u8) do
                v45.Decal.Texture = v47
                local v48 = #u8 * 0.4
                if v46 == math.round(v48) and u44 == true then
                    local v49 = v45.Particles
                    local v50 = u6:NextNumber(4, 7)
                    v49.Position = Vector3.new(v50, 0, 0)
                    _G.customEmit(v45)
                end
                task.wait()
            end
            _G.destroy(v45, 1)
        end)
        task.wait(0.1)
        tick()
        local v51 = 1
        while p16:IsDescendantOf(workspace) == false do
            p16.Decal.Texture = u7[v51]
            local v52 = v51 + 1
            v51 = #u7 < v52 and 1 or v52
            task.wait(0.02)
        end
        task.wait(0.15)
        task.wait(3.5)
        u42:Destroy()
    end
end
return v4