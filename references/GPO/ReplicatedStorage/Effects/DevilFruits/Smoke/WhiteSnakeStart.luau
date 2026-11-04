 

local v1 = RaycastParams.new()
v1.FilterType = Enum.RaycastFilterType.Include
v1.FilterDescendantsInstances = workspace.Env:GetDescendants()
game:GetService("RunService")
local _ = script
local v2 = {}
game:GetService("TweenService")
Random.new()
function v2.start(_, p3, p4) --[[ Line: 49 ]]
    local v5 = p3:WaitForChild("RightHand")
    local v6 = p3:WaitForChild("RightLowerArm")
    local v7 = { v5, p3:WaitForChild("RightUpperArm"), v6 }
    local v8 = script.ArmSmoke:Clone()
    v8.Weld.Part0 = v5
    v8.Parent = workspace.Effects
    for _, v9 in v7 do
        _G.bodyTransSection(p3, v9)
    end
    _G.PlaySound(p3.PrimaryPart, script.SmokeSnakeStart)
    task.wait(p4)
    for _, v10 in v7 do
        _G.bodyTransSection(p3, v10, true)
    end
    _G.particleEnabled(v8, false)
    _G.destroy(v8, 3)
end
return v2