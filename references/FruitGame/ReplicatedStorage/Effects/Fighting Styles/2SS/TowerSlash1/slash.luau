 

local u1 = game:GetService("TweenService")
TweenInfo.new(0.3, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out)
local u2 = game:GetService("RunService").Heartbeat
local _ = Vector3.new
local u3 = CFrame.new;
({}).Transparency = 1
local u4 = CFrame.Angles(0, 0.9, 0)
local u5 = CFrame.Angles(0, 3.0473448739820994, 0)
local u6 = Random.new()
return function(p7) --[[ Line: 11 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u2
        [3] = u1
        [4] = u3
        [5] = u6
        [6] = u5
    --]]
    local u8 = p7.slasha
    local u9 = p7.slashb
    spawn(function() --[[ Line: 14 ]]
        --[[
        Upvalues:
            [1] = u8
            [2] = u4
            [3] = u9
            [4] = u2
        --]]
        for v10 = -0.9, 1.2, 0.3 do
            u8.root.CFrame = u8.root.CFrame * u4
            u9.root.CFrame = u9.root.CFrame * u4
            u8.root.Decal.Transparency = v10
            u8.Part.Decal.Transparency = v10
            u9.root.Decal.Transparency = v10
            u9.Part.Decal.Transparency = v10
            u8.root.Mesh.Scale = u8.root.Mesh.Scale + Vector3.new(2.2, 0, 2.2)
            u8.Part.Mesh.Scale = u8.Part.Mesh.Scale - Vector3.new(2.2, 0, 2.2)
            u9.root.Mesh.Scale = u9.root.Mesh.Scale + Vector3.new(2.2, 0, 2.2)
            u9.Part.Mesh.Scale = u9.Part.Mesh.Scale - Vector3.new(2.2, 0, 2.2)
            u2:Wait()
        end
    end)
    u1:Create(p7.slice1, TweenInfo.new(0.6, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
        ["Transparency"] = 1,
        ["CFrame"] = p7.slice1.CFrame * u3(0, 0, 20),
        ["Size"] = p7.slice1.Size * Vector3.new(0, 0, 4)
    }):Play()
    local v11 = p7.tinyslice
    for v12 = 1, 10 do
        local v13 = u6:NextNumber(1, 3)
        local v14 = u6:NextNumber(0, v12)
        local v15 = p7.slice1
        local v16 = v11:Clone()
        v16.CFrame = v15.CFrame * u3(u6:NextNumber(-1, 1), u6:NextNumber(-2, 2), u6:NextNumber(-1, 1))
        v16.Parent = p7
        local v17 = u1
        local v18 = TweenInfo.new(u6:NextNumber(0.2, 0.5), Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local v19 = {
            ["Transparency"] = 1,
            ["CFrame"] = v16.CFrame * u3(0, 0, 6 * v14) * CFrame.Angles(0, 0, u6:NextNumber(0, 1.5))
        }
        local v20 = 4 * v13
        v19.Size = Vector3.new(0.05, 0.1, v20)
        v17:Create(v16, v18, v19):Play()
    end
    v11:Destroy()
    u1:Create(p7.swirl1, TweenInfo.new(0.9, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        ["Transparency"] = 1,
        ["CFrame"] = p7.swirl1.CFrame * u5,
        ["Size"] = Vector3.new(30, 0, 30)
    }):Play()
    u1:Create(p7.swirl2, TweenInfo.new(1.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        ["Transparency"] = 1,
        ["CFrame"] = p7.swirl2.CFrame * u5,
        ["Size"] = Vector3.new(25, 0, 25)
    }):Play()
    u1:Create(p7.areaswirl, TweenInfo.new(1.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        ["Transparency"] = 1,
        ["CFrame"] = p7.areaswirl.CFrame * u5,
        ["Size"] = p7.areaswirl.Size * 6
    }):Play()
    u1:Create(p7.sliceswirl, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        ["Transparency"] = 1,
        ["CFrame"] = p7.sliceswirl.CFrame * u3(0, 8, 0) * u5,
        ["Size"] = p7.sliceswirl.Size * Vector3.new(0.75, 2, 0.75)
    }):Play()
    _G.destroy(p7, 3)
end