 

local u1 = game:GetService("TweenService")
game:GetService("Debris")
game:GetService("RunService")
local _ = game:GetService("Players").LocalPlayer
Random.new()
local v2 = {}
local u3 = script
function v2.start(_, p4) --[[ Line: 18 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u1
    --]]
    local v5 = u3.Special_Emit.Attachment:Clone()
    v5.WorldCFrame = p4:GetPivot()
    v5.Parent = workspace.Terrain
    task.delay(2, v5.Destroy, v5)
    _G.particleEnabled(v5, false)
    _G.customEmit(v5)
    local u6 = Instance.new("Highlight")
    u6.FillTransparency = 1
    u6.FillColor = Color3.new(1, 1, 1)
    u6.DepthMode = Enum.HighlightDepthMode.Occluded
    u6.OutlineTransparency = 0
    u6.Parent = p4
    task.delay(0.2, function() --[[ Line: 34 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u6
        --]]
        u1:Create(u6, TweenInfo.new(1), {
            ["OutlineTransparency"] = 1,
            ["FillTransparency"] = 1
        }):Play()
        _G.destroy(u6, 1)
    end)
end
return v2