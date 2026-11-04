 

local u1 = game:GetService("TweenService")
local u2 = Vector3.new
local u3 = CFrame.new
local _ = game:GetService("RunService").Heartbeat
CFrame.Angles(0, 0.6, 0)
local u4 = Random.new()
return function(u5, p6, p7) --[[ Line: 9 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u3
        [3] = u4
        [4] = u2
    --]]
    local v8 = u5.sphere
    u1:Create(u5.woosh, TweenInfo.new(0.3, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
        ["Transparency"] = 1,
        ["CFrame"] = u5.woosh.CFrame * u3(0, -p6, 0) * CFrame.Angles(0, 2.9845130209103035, 0),
        ["Size"] = Vector3.new(1, 25, 1)
    }):Play()
    u1:Create(u5.ring, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        ["Transparency"] = 1,
        ["CFrame"] = u5.ring.CFrame * u3(0, p6 * 0.75, 0),
        ["Size"] = u5.ring.Size * Vector3.new(1.5, 0, 1.5)
    }):Play()
    u5.woosh.Attachment.Sparkles:Emit(1)
    u5.woosh.Attachment.Waves:Emit(6)
    local v9 = false
    for v10 = 0, 0.9, 0.1 do
        local v11 = v8:Clone()
        v11.CFrame = u5.root.CFrame * CFrame.new(u4:NextNumber(-9, 9), u4:NextNumber(-5, 8), -v10 * p6 * 0.25)
        if v9 then
            if u5.Name == "dasheffectBuso" then
                v11.Color = require(script.Parent.Parent.BusoColor):getColor(p7)
            else
                v11.BrickColor = BrickColor.new("Light blue")
            end
        end
        v11.Parent = u5
        u1:Create(v11, TweenInfo.new(v10 * 0.2 + 0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            ["Transparency"] = 1,
            ["CFrame"] = u5.root.CFrame * u3(0, 0, -p6 + u4:NextNumber(-5, p6)),
            ["Size"] = u2(0, 0, v10 * 4 + 3)
        }):Play()
        v9 = not v9
    end
    task.spawn(function() --[[ Line: 49 ]]
        --[[
        Upvalues:
            [1] = u5
        --]]
        task.wait(0.2)
        u5.woosh.new3.Enabled = false
    end)
    v8:Destroy()
    _G.destroy(u5, 5.5)
end