 

game:GetService("RunService")
game:GetService("TweenService")
game:GetService("UserInputService")
return {
    ["start"] = function(_, p1, p2, p3) --[[ Name: start, Line 9 ]]
        if p1 == nil then
            return
        elseif _G.checkRenderDistance(p1.PrimaryPart.Position) ~= false then
            local v4 = p3 and script.Flame or script.Base
            local v5 = v4.M1:Clone()
            v5.CFrame = p1.PrimaryPart.CFrame * CFrame.new(0, 3, -0.65)
            v5.Parent = workspace.Effects
            _G.customEmit(v5)
            _G.destroy(v5, 4)
            local v6 = v4.Claw:Clone()
            v6.CFrame = p1.PrimaryPart.CFrame * CFrame.new(0, 3, -4) * CFrame.Angles(0, 0, (math.rad(p2)))
            v6.Parent = workspace.Effects
            _G.customEmit(v6)
            _G.destroy(v6, 4)
        end
    end
}