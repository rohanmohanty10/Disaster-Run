 

game:GetService("TweenService")
game:GetService("ReplicatedStorage")
local v1 = {}
local u2 = workspace.Effects
function v1.start(_, p3) --[[ Line: 9 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    if _G.checkRenderDistance(p3.PrimaryPart.Position) then
        p3:WaitForChild("HumanoidRootPart")
        local v4 = script:FindFirstChild("Body"):Clone()
        v4.CFrame = p3.PrimaryPart.CFrame
        v4.Parent = u2
        _G.customEmit(v4)
        _G.destroy(v4, 1)
        _G.particleEnabled(v4, false)
        local v5, v6, v7 = _G.getRayFloor(p3.PrimaryPart.CFrame, 15)
        local v8 = v7:Dot(Vector3.new(0, 1, 0))
        local v9 = math.acos(v8)
        local v10 = math.rad(v9)
        local v11 = v7:Dot(p3.PrimaryPart.CFrame.LookVector)
        local v12 = math.sign(v11)
        local v13 = CFrame.new(v6, v6 + p3.PrimaryPart.CFrame.LookVector) * CFrame.Angles(1.5707963267948966 - v12 * v10, 0, 0)
        if v5 then
            local v14 = script:FindFirstChild("Floor"):Clone()
            v14.CFrame = v13 * CFrame.Angles(-1.5707963267948966, 0, 0)
            v14.Parent = u2
            _G.customEmit(v14)
            _G.destroy(v14, 1.5)
        end
    end
end
return v1