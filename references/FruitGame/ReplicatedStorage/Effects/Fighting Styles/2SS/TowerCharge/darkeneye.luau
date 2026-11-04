 

local u1 = game:GetService("TweenService")
local u2 = TweenInfo.new(0.3, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out)
local _ = Vector3.new
local _ = CFrame.new
local u3 = {
    ["Transparency"] = 1
}
return function(p4, p5) --[[ Line: 7 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v6 = p4.eye1
    local v7 = p4.eye2
    local _ = p4.fakehead.face
    if p5 then
        v6.Transparency = 0
        v7.Transparency = 0
        v6.Beam.Enabled = true
        v7.Beam.Enabled = true
    else
        v6.Transparency = -0.5
        v7.Transparency = -0.5
        u1:Create(v6, u2, u3):Play()
        u1:Create(v7, u2, u3):Play()
        v6.Beam.Enabled = false
        v7.Beam.Enabled = false
    end
end