 

game:GetService("TweenService")
game:GetService("Debris")
game:GetService("RunService")
Random.new()
require(script.Parent.Shared)
local _ = script.VFX
local v1 = RaycastParams.new()
v1.FilterDescendantsInstances = { workspace.Islands, workspace.Ships, workspace.Env }
v1.FilterType = Enum.RaycastFilterType.Include
return {
    ["start"] = function(_, p2) --[[ Name: start, Line 15 ]]
        local v3 = p2.Character
        local v4 = p2.PrecomputedPath
        local v5 = p2.WaitInterval - (workspace:GetServerTimeNow() - p2.serverTime)
        local v6 = v5 <= 0.05 and 0.05 or v5
        for v7 = 1, #v4 do
            local v8 = v4[v7]
            if v3:FindFirstChild("PB") then
                break
            end
            _G.PlayEffect("Thunder Flash Step", nil, {
                ["CFrame"] = v8.CFrame,
                ["Character"] = v3,
                ["Duration"] = v6,
                ["Direction"] = v8.Direction,
                ["zagCount"] = v8.zagCount,
                ["LastCFrame"] = v8.LastCFrame
            })
            task.wait(v6)
        end
    end
}