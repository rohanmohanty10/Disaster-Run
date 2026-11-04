 

game:GetService("RunService")
game:GetService("TweenService")
game:GetService("UserInputService")
local v1 = {}
local u2 = {
    CFrame.new(-0.000366210938, -3.57362652, -3.81889343, -0.707106709, 0, 0.707106888, 0.405579865, -0.819152296, 0.405579805, 0.579228044, 0.573576629, 0.579228103),
    CFrame.new(-0.000366210938, -3.57363033, -3.81890106, 0.707106709, 0, -0.707106888, 0.405579805, 0.819152236, 0.405579865, 0.579227984, -0.57357657, 0.579227984),
    CFrame.new(-0.000366210938, -3.57362652, -3.81889343, -0.707106709, 0, 0.707106888, 0.405579865, -0.819152296, 0.405579805, 0.579228044, 0.573576629, 0.579228103),
    CFrame.new(-0.000366210938, -3.57363033, -3.81890106, 0.707106709, 0, -0.707106888, 0.405579805, 0.819152236, 0.405579865, 0.579227984, -0.57357657, 0.579227984),
    CFrame.new()
}
function v1.start(_, p3, p4) --[[ Line: 17 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    if _G.checkRenderDistance(p3.Position) ~= false then
        local v5 = script.Part:Clone()
        if p4 == 5 then
            v5:Destroy()
            v5 = script.Part2:Clone()
        end
        v5.CFrame = p3 * u2[p4]
        v5.Parent = workspace.Effects
        _G.customEmit(v5)
        _G.destroy(v5, 4)
    end
end
return v1