 

local u1 = script
game:GetService("ReplicatedStorage")
local u2 = game:GetService("RunService")
local _ = workspace.Effects
local u3 = game:GetService("Debris")
local u4 = game:GetService("TweenService")
Random.new()
function doSlash(u5, u6, p7)
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u4
        [4] = u3
    --]]
    local u8 = u1.Slash:Clone()
    u8.Parent = workspace.Effects
    local u9 = p7 * CFrame.new(1.25, 0, 0)
    local u10 = 0
    local u11 = nil
    u11 = u2.Heartbeat:Connect(function(p12) --[[ Line: 15 ]]
        --[[
        Upvalues:
            [1] = u10
            [2] = u11
            [3] = u4
            [4] = u8
            [5] = u6
            [6] = u9
            [7] = u5
        --]]
        u10 = u10 + p12
        if u10 > 0.3 then
            u11:Disconnect()
        else
            local v13 = u4:GetValue(u10 / 0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
            local v14 = u8
            local v15 = u6.CFrame * u9
            local v16 = CFrame.Angles
            local v17 = u5 * v13
            v14.CFrame = v15 * v16(0, math.rad(v17), 0)
        end
    end)
    _G.tween(u8.Colored, { 0.15, "Sine", Enum.EasingDirection.Out }, {
        ["Transparency"] = 1
    })
    _G.tween(u8.Black1, { 0.25, "Sine", Enum.EasingDirection.Out }, {
        ["Transparency"] = 1
    })
    _G.tween(u8.Black2, { 0.3, "Sine", Enum.EasingDirection.Out }, {
        ["Transparency"] = 1
    })
    _G.tween(u8.Mesh, { 0.9, "Sine", Enum.EasingDirection.Out }, {
        ["Scale"] = u8.Mesh.Scale + Vector3.new(1, 1, 1)
    })
    u3:AddItem(u8, 1)
end
function tweenCFrame(u18, u19, u20, u21, u22, u23, u24)
    --[[
    Upvalues:
        [1] = u2
        [2] = u4
    --]]
    local u25 = 0
    local u26 = nil
    u26 = u2.Heartbeat:Connect(function(p27) --[[ Line: 32 ]]
        --[[
        Upvalues:
            [1] = u25
            [2] = u24
            [3] = u26
            [4] = u4
            [5] = u23
            [6] = u22
            [7] = u18
            [8] = u20
            [9] = u21
            [10] = u19
        --]]
        u25 = u25 + p27
        if u24 < u25 then
            u26:Disconnect()
        else
            local v28 = u4:GetValue(u25 / u24, u23, u22)
            u18.CFrame = u20.CFrame * u21:Lerp(u21 * u19, v28)
        end
    end)
end
return {
    ["start"] = function(_, p29, p30) --[[ Name: start, Line 44 ]]
        if p29 == "1" then
            doSlash(-130, p30, CFrame.new(-0.0000152587891, -0.000443458557, 9.05990601e-6, -0.719846308, -0.342020094, 0.604022563, 0.262002587, -0.939692438, -0.219846293, 0.642787576, 3.86950489e-8, 0.766044319) * CFrame.Angles(0, 1.9198621771937625, 0))
        end
        if p29 == "2" then
            doSlash(-130, p30, CFrame.new(0.0000152587891, 0.499553204, 9.05990601e-6, 0.691998959, -0.349716216, -0.631531537, 0.344263673, 0.928805828, -0.137109563, 0.634522617, -0.122533172, 0.763128102) * CFrame.Angles(0, 1.9198621771937625, 0))
        end
        if p29 == "3" then
            doSlash(-130, p30, CFrame.new(0.168060303, 0.214526653, -0.122787952, -0.519835651, 0.422618449, 0.74240458, -0.24240613, -0.906307697, 0.346187294, 0.819152117, -2.9190428e-6, 0.573576391) * CFrame.Angles(0, 2.181661564992912, 0))
        end
        if p29 == "4" then
            doSlash(-130, p30, CFrame.new(0, 0.249537468, 0, 0.763936341, 0.0841850564, -0.639776826, -0.0499879755, 0.99619478, 0.0713953227, 0.643352509, -0.0225603394, 0.765237689) * CFrame.Angles(0, 1.9198621771937625, 0))
        end
        if p29 == "5" then
            doSlash(-130, p30, CFrame.new(0.5, -0.000465869904, -0.25, 0.720564187, 0.355512351, -0.595313728, -0.258620918, 0.934399247, 0.244975969, 0.643352509, -0.0225603394, 0.765237689) * CFrame.Angles(0, 1.9198621771937625, 0))
        end
    end
}