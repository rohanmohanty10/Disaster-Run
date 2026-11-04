 

local v1 = {}
local u2 = _G.tween
function v1.start(_, p3) --[[ Line: 16 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v4 = p3.PrimaryPart.CFrame
    local _, v5, v6 = _G.getRayFloor(v4, 5)
    local v7 = CFrame.new(v5, v5 + v6) * CFrame.Angles(-1.5707963267948966, 0, 0)
    local v8 = script.fx:Clone()
    v8.CFrame = v7
    v8.Parent = workspace.Effects
    _G.destroy(v8, 5)
    _G.PlaySound(p3.PrimaryPart, script.CrowGrip)
    for _, v9 in p3:GetDescendants() do
        if v9:IsA("BasePart") or v9:IsA("Decal") then
            u2(v9, {
                0.5,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                0,
                false
            }, {
                ["Transparency"] = 1
            })
        end
    end
    task.wait(0.5)
    _G.particleEnabled(v8, false)
end
return v1