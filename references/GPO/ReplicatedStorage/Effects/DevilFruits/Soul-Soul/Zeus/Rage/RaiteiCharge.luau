 

game:GetService("TweenService")
game:GetService("Debris")
game:GetService("RunService")
Random.new()
require(script.Parent.Shared)
local v1 = RaycastParams.new()
v1.FilterDescendantsInstances = { workspace.Islands, workspace.Ships, workspace.Env }
v1.FilterType = Enum.RaycastFilterType.Include
return {
    ["start"] = function(_, p2, p3, u4) --[[ Name: start, Line 18 ]]
        local u5 = nil
        local u6 = p3.PrimaryPart
        local u7 = p2.PrimaryPart.RealRoot.Value
        local u8 = p3.Humanoid:LoadAnimation(script.charCharge)
        u8:Play()
        local u9 = p2.RageModel.AnimationController:LoadAnimation(script.soulCharge)
        u9:Play()
        u5 = game["Run Service"].Heartbeat:Connect(function() --[[ Line: 28 ]]
            --[[
            Upvalues:
                [1] = u4
                [2] = u8
                [3] = u9
                [4] = u5
                [5] = u7
                [6] = u6
            --]]
            if u4 and u4:GetAttribute("Crashed") == true then
                u8:Stop()
                u9:Stop()
            end
            if u4 == nil or u4 and u4:IsDescendantOf(game) == false then
                u5:Disconnect()
                u5 = nil
                u8:Stop()
                u9:Stop()
            else
                u7.CFrame = u6.CFrame * CFrame.new(0, -4, 0)
            end
        end)
    end
}