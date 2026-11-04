 

local v1 = {}
local u2 = game:GetService("Debris")
local u3 = game:GetService("TweenService")
local u4 = workspace.Effects
local u5 = script.DistortionMesh
function v1.Play(p6) --[[ Line: 20 ]]
    --[[
    Upvalues:
        [1] = u5
        [2] = u4
        [3] = u3
        [4] = u2
    --]]
    local v7 = u5:Clone()
    v7.CFrame = p6.Position
    v7.Parent = u4
    v7.Transparency = p6.StartDistortion
    local v8 = p6.StartRadius
    local v9 = p6.StartRadius
    local v10 = p6.StartRadius
    v7.Size = Vector3.new(v8, v9, v10)
    local v11 = u3
    local v12 = TweenInfo.new(p6.Duration, p6.EasingStyle, p6.EasingDirection)
    local v13 = {}
    local v14 = p6.EndRadius
    local v15 = p6.EndRadius
    local v16 = p6.EndRadius
    v13.Size = Vector3.new(v14, v15, v16)
    v13.Transparency = p6.EndDistortion
    v11:Create(v7, v12, v13):Play()
    u2:AddItem(v7, p6.Duration)
end
return v1