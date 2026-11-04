 

local v1 = {}
local u2 = game:GetService("TweenService")
local u3 = game:GetService("RunService")
local v4 = RaycastParams.new()
v4.FilterDescendantsInstances = { workspace.Env, workspace.Ships, workspace.Islands }
v4.FilterType = Enum.RaycastFilterType.Include
local u5 = _G.tween
local u6 = {
    Color3.fromRGB(255, 0, 0),
    Color3.fromRGB(64, 74, 255),
    Color3.fromRGB(78, 255, 65),
    Color3.fromRGB(74, 201, 255),
    Color3.fromRGB(255, 239, 58),
    Color3.fromRGB(255, 144, 93)
}
local function u55(u7) --[[ Line: 24 ]]
    --[[
    Upvalues:
        [1] = u6
        [2] = u2
        [3] = u3
    --]]
    local u8 = 1.35 + math.random() * 0.3
    local u9 = 2 + math.random() * 2
    local u10 = 4 + math.random()
    local u11 = 8 + math.random() * 4
    local u12 = 8 + math.random() * 6
    local v13 = math.random(-25, 25)
    local u14 = math.rad(v13)
    local v15 = math.random(-25, 25)
    local u16 = math.rad(v15)
    local u17 = 0.45 + math.random() * 0.35
    local u18 = 0.45 + math.random() * 0.35
    local u19 = math.random() * 1000
    local u20 = math.random() * 1000
    local u21 = script.Gift:Clone()
    if not u21.PrimaryPart then
        local v22 = u21:FindFirstChildWhichIsA("BasePart", true)
        if not v22 then
            return
        end
        u21.PrimaryPart = v22
    end
    local v23 = u6[math.random(1, #u6)]
    local u24 = {}
    for _, v25 in ipairs(u21:GetDescendants()) do
        if v25:IsA("BasePart") then
            v25.Anchored = true
            v25.CanCollide = false
            table.insert(u24, v25)
            if v25.Name == "Color" then
                v25.Color = v23
            elseif v25.Name == "Top" then
                for _, v26 in v25:GetChildren() do
                    v26.Color3 = v23
                end
            end
        end
    end
    u21:PivotTo(u7 * CFrame.new(0, 2, 0))
    local v27 = u21.PrimaryPart.CFrame
    local u28 = {}
    for _, v29 in ipairs(u24) do
        local v30 = v27:ToObjectSpace(v29.CFrame)
        local v31, v32, v33 = v30:ToOrientation()
        u28[v29] = {
            ["size"] = v29.Size,
            ["pos"] = v30.Position,
            ["rx"] = v31,
            ["ry"] = v32,
            ["rz"] = v33
        }
        v29.Size = v29.Size * 0.1
    end
    u21.Parent = workspace.Effects
    local u34 = math.random() * 6.283185307179586
    local u35 = Instance.new("NumberValue")
    u35.Value = 0
    u2:Create(u35, TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        ["Value"] = 1
    }):Play()
    local u36 = time()
    local u37 = nil
    task.delay(u8 - 0.3, function() --[[ Line: 99 ]]
        --[[
        Upvalues:
            [1] = u24
            [2] = u2
            [3] = u21
        --]]
        for _, v38 in ipairs(u24) do
            u2:Create(v38, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                ["Size"] = Vector3.new(0, 0, 0)
            }):Play()
        end
        _G.destroy(u21, 1.5)
    end)
    u37 = u3.PreSimulation:Connect(function() --[[ Line: 108 ]]
        --[[
        Upvalues:
            [1] = u36
            [2] = u8
            [3] = u35
            [4] = u37
            [5] = u34
            [6] = u9
            [7] = u10
            [8] = u11
            [9] = u12
            [10] = u14
            [11] = u19
            [12] = u17
            [13] = u16
            [14] = u20
            [15] = u18
            [16] = u7
            [17] = u24
            [18] = u28
        --]]
        local v39 = (time() - u36) / u8
        if v39 >= 0.95 then
            u35:Destroy()
            u37:Disconnect()
        else
            local v40 = u35.Value
            local v41 = 1 - (1 - v40) * (1 - v40)
            local v42 = 0.1 + 0.9 * v41
            local v43 = u34 + v39 * 3.141592653589793 * 2 * u9 * 0.6
            local v44 = u10 + (u11 - u10) * v39
            local v45 = v39 * u12
            local v46 = math.cos(v43) * v44
            local v47 = math.sin(v43) * v44
            local v48 = 1.5707963267948966 * (1 - v41)
            local v49 = time() - u36
            local v50 = u14 + (math.noise(u19, v49 * u17, 0) * 2 - 1) * 0.4363323129985824
            local v51 = u16 + (math.noise(u20, v49 * u18, 0) * 2 - 1) * 0.4363323129985824
            local v52 = u7 * CFrame.new(v46, v45 + 2, v47) * CFrame.Angles(v50, v43 + v48, v51)
            for _, v53 in ipairs(u24) do
                local v54 = u28[v53]
                if v39 < 0.5 then
                    v53.Size = v54.size * v42
                end
                v53.CFrame = v52 * CFrame.new(v54.pos * v42) * CFrame.fromOrientation(v54.rx, v54.ry, v54.rz)
            end
        end
    end)
end
local u56 = require(game.ReplicatedStorage.Modules.ZiliEmitModule)
function v1.start(_, u57) --[[ Line: 155 ]]
    --[[
    Upvalues:
        [1] = u5
        [2] = u55
        [3] = u56
        [4] = u2
        [5] = u3
    --]]
    local v58 = u57:FindFirstChild("HumanoidRootPart")
    if v58 then
        local u59 = v58.CFrame
        local v60 = workspace.Effects
        local v61 = script.Burst:Clone()
        v61.CFrame = u59 * CFrame.new(0, -2.5, 0)
        v61.Parent = v60
        _G.customEmit(v61)
        _G.destroy(v61, 5)
        _G.PlaySound(u59, script.tornadogrip)
        local function v65(p62, _) --[[ Line: 170 ]]
            --[[
            Upvalues:
                [1] = u57
                [2] = u5
            --]]
            local v63 = {}
            for _, v64 in ipairs(u57:GetDescendants()) do
                if (v64:IsA("BasePart") or v64:IsA("Decal")) and v64.Transparency ~= 1 then
                    v63[v64] = v64.Transparency
                    u5(v64, {
                        p62,
                        Enum.EasingStyle.Quad,
                        Enum.EasingDirection.Out,
                        0,
                        false
                    }, {
                        ["Transparency"] = 1
                    })
                end
            end
        end
        task.spawn(function() --[[ Line: 180 ]]
            --[[
            Upvalues:
                [1] = u59
                [2] = u55
            --]]
            local v66 = u59 * CFrame.new(0, -2.5, 0)
            for _ = 1, 3 do
                for _ = 1, 4 do
                    u55(v66)
                    task.wait(math.random(120, 300) / 1000)
                end
                task.wait(0.04)
            end
        end)
        local u67 = script.Tornado:Clone()
        u67:PivotTo(u59 * CFrame.new(0, -3, 0))
        u67.Parent = v60
        local v68 = u67:FindFirstChild("particles")
        if v68 then
            _G.customEmit(v68)
        end
        u56.emit(u67)
        local v69 = Instance.new("Highlight")
        v69.FillColor = Color3.fromRGB(224, 241, 255)
        v69.FillTransparency = -18
        v69.OutlineTransparency = 1
        v69.OutlineColor = Color3.fromRGB(0, 0, 0)
        v69.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        v69.Parent = u57
        u2:Create(v69, TweenInfo.new(0.1), {
            ["FillTransparency"] = 1
        }):Play()
        v65(0.1, 3.4)
        local v75 = u3.PreSimulation:Connect(function(p70) --[[ Line: 215 ]]
            --[[
            Upvalues:
                [1] = u67
            --]]
            local v71 = u67:FindFirstChild("particles")
            if v71 then
                local v72 = v71.CFrame
                local v73 = CFrame.Angles
                local v74 = -100 * p70
                v71.CFrame = v72 * v73(0, math.rad(v74), 0)
            end
        end)
        task.wait(5)
        if v75 then
            v75:Disconnect()
        end
        _G.destroy(u67, 3)
    end
end
return v1