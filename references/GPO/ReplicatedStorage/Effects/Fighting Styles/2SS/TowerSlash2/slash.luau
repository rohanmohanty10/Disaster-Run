 

local u1 = game:GetService("TweenService")
TweenInfo.new(0.3, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out)
local u2 = game:GetService("RunService").Heartbeat
local _ = Vector3.new
local u3 = CFrame.new;
({}).Transparency = 1
local u4 = CFrame.Angles(0, 0.9, 0)
local u5 = CFrame.Angles(0, 3.0473448739820994, 0)
Random.new()
return function(u6) --[[ Line: 11 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u4
        [3] = u2
        [4] = u3
        [5] = u5
    --]]
    local u7 = u6.slasha
    local u8 = u6.slashb
    if (workspace.CurrentCamera.CFrame.Position - u6.PrimaryPart.Position).magnitude < 100 then
        local v9 = u6.ColorCorrection
        v9.Parent = workspace.CurrentCamera
        _G.destroy(v9, 0.5)
        u1:Create(v9, TweenInfo.new(0.15, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
            ["Contrast"] = 0,
            ["Enabled"] = false
        }):Play()
    end
    spawn(function() --[[ Line: 25 ]]
        --[[
        Upvalues:
            [1] = u7
            [2] = u4
            [3] = u8
            [4] = u2
        --]]
        for v10 = -2.2, 1.2, 0.2 do
            u7.root.CFrame = u7.root.CFrame * u4
            u8.root.CFrame = u8.root.CFrame * u4
            u7.root.Decal.Transparency = v10
            u7.Part.Decal.Transparency = v10
            u8.root.Decal.Transparency = v10
            u8.Part.Decal.Transparency = v10
            u7.root.Mesh.Scale = u7.root.Mesh.Scale + Vector3.new(3.2, 1, 3.2)
            u7.Part.Mesh.Scale = u7.Part.Mesh.Scale - Vector3.new(3.2, 1, 3.2)
            u8.root.Mesh.Scale = u8.root.Mesh.Scale + Vector3.new(3.2, 1, 3.2)
            u8.Part.Mesh.Scale = u8.Part.Mesh.Scale - Vector3.new(3.2, 1, 3.2)
            u2:Wait()
        end
    end)
    u1:Create(u6.bigslice, TweenInfo.new(1.3, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
        ["CFrame"] = u6.bigslice.CFrame * u3(0, 0, 30),
        ["Size"] = u6.bigslice.Size * Vector3.new(0.15, 0.15, 5)
    }):Play()
    task.spawn(function() --[[ Line: 47 ]]
        --[[
        Upvalues:
            [1] = u6
        --]]
        task.wait(0.2)
        _G.tween(u6.bigslice.Mesh, {
            1,
            "Sharp",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Scale"] = Vector3.new(0, 1, 0),
            ["Offset"] = Vector3.new(0, 0, 50)
        })
    end)
    u6.root.Attachment.Sparkles:Emit(16)
    u1:Create(u6.horislice1, TweenInfo.new(0.6, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        ["Transparency"] = 1,
        ["CFrame"] = u6.horislice1.CFrame * u3(0, 0, 14),
        ["Size"] = u6.horislice1.Size * Vector3.new(0.1, 0, 4)
    }):Play()
    u1:Create(u6.horislice2, TweenInfo.new(0.6, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        ["Transparency"] = 1,
        ["CFrame"] = u6.horislice2.CFrame * u3(0, 0, 14),
        ["Size"] = u6.horislice2.Size * Vector3.new(0, 0.1, 4)
    }):Play()
    u1:Create(u6.areaswirl1, TweenInfo.new(1.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        ["Transparency"] = 1,
        ["CFrame"] = u6.areaswirl1.CFrame * u5,
        ["Size"] = u6.areaswirl1.Size * 2
    }):Play()
    u1:Create(u6.areaswirl2, TweenInfo.new(1.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        ["Transparency"] = 1,
        ["CFrame"] = u6.areaswirl2.CFrame * u5,
        ["Size"] = u6.areaswirl2.Size * 3
    }):Play()
    u1:Create(u6.sliceswirl, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        ["Transparency"] = 1,
        ["CFrame"] = u6.sliceswirl.CFrame * u3(0, 24, 0) * u5,
        ["Size"] = u6.sliceswirl.Size * Vector3.new(2.5, 4, 2.5)
    }):Play()
    u1:Create(u6.ring, TweenInfo.new(0.8, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
        ["Transparency"] = 1,
        ["CFrame"] = u6.ring.CFrame * u3(0, 20, 0),
        ["Size"] = u6.ring.Size * Vector3.new(1.8, 0, 1.8)
    }):Play()
    _G.destroy(u6, 3)
end