 

local v1 = {}
game:GetService("Players")
game:GetService("TweenService")
local v2 = RaycastParams.new()
v2.RespectCanCollide = true
v2.FilterDescendantsInstances = { workspace.Env, workspace.Islands, workspace.Ships }
v2.FilterType = Enum.RaycastFilterType.Include
function v1.start(_, p3, p4, p5, p6) --[[ Line: 10 ]]
    if _G.checkRenderDistance(p3.PrimaryPart.Position) ~= false then
        local _ = script
        local _ = p3.Humanoid
        local _ = p3.HumanoidRootPart
        if p6 then
            p6.PrimaryPart.CFrame = CFrame.new(p6.PrimaryPart.Position, p4.Position)
            p5 = p6.PrimaryPart.CFrame
        end
        local v7 = script.HookThrow:Clone()
        v7.CFrame = p5
        v7.Parent = workspace.Effects
        _G.customEmit(v7)
        _G.destroy(v7, 5)
    end
end
return v1