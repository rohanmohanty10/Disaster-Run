 

game:GetService("ReplicatedStorage")
game:GetService("RunService")
game:GetService("TweenService")
local u1 = require(game:GetService("ReplicatedStorage").Modules.Client.WeaponVFXRecolor)
local u2 = script.Parent["Rocket Launcher Firework Assets"]
return {
    ["start"] = function(_, p3) --[[ Name: start, Line 9 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u1
        --]]
        local v4 = p3.rocket
        local v5 = p3.rocketTravelConnection
        local v6 = p3.char
        if _G.checkRenderDistance(v4.Position) ~= false then
            repeat
                task.wait(0.05)
                local v7 = u2.SmokeMesh:Clone()
                u1.apply(v7, v6)
                v7.CFrame = v4.CFrame * CFrame.Angles(Random.new():NextNumber(-180, 180), 0, 1.5707963267948966)
                v7.Mesh.Scale = Vector3.new(-3.25, -2, -3.25)
                v7.Parent = workspace.Effects
                _G.tween(v7, { 0.25, Enum.EasingStyle.Linear, Enum.EasingDirection.Out }, {
                    ["Transparency"] = 1,
                    ["CFrame"] = v7.CFrame * CFrame.new(0, -10, 0) * CFrame.Angles(0, 3.12413936106985, 0)
                })
                _G.tween(v7.Mesh, { 0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out }, {
                    ["Scale"] = Vector3.new(-6.25, -40.25, -6.25)
                })
                _G.destroy(v7, 0.25)
            until v5 == nil or v5 and v5.Connected == false or v4:IsDescendantOf(workspace) == false
        end
    end
}