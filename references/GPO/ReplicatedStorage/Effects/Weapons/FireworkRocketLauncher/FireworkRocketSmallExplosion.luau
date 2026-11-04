 

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
        local v4 = p3.position
        local v5 = p3.prestige
        local u6 = p3.char
        if _G.checkRenderDistance(v4) ~= false then
            local u7
            if v5 == false then
                u7 = u2.SmallerFireworkExplosion:Clone()
            else
                u7 = u2.PrestigeSmallerFireworkExplosion:Clone()
            end
            u1.apply(u7, u6)
            u7.Position = v4
            u7.Parent = workspace.Effects
            _G.customEmit(u7)
            _G.destroy(u7, 3)
            _G.shakenear(u7.CFrame.Position, 50, 35, 55, -1)
            _G.PlaySound(u7, script.ClusterShotSingleBoom, {
                ["Pitch"] = math.random(90, 110) / 100
            })
            task.spawn(function() --[[ Line: 31 ]]
                --[[
                Upvalues:
                    [1] = u2
                    [2] = u1
                    [3] = u6
                    [4] = u7
                --]]
                for _ = 1, 5 do
                    local v8 = u2.SmokeMesh:Clone()
                    u1.apply(v8, u6)
                    local v9 = u7.CFrame
                    local v10 = CFrame.Angles
                    local v11 = math.random(0, 360)
                    local v12 = math.rad(v11)
                    local v13 = math.random(0, 360)
                    local v14 = math.rad(v13)
                    local v15 = math.random(0, 360)
                    v8.CFrame = v9 * v10(v12, v14, (math.rad(v15)))
                    v8.Mesh.Scale = Vector3.new(-3.25, -2, -3.25)
                    v8.Color = Color3.fromRGB(109, 109, 109)
                    v8.Parent = workspace.Effects
                    local v16 = math.random(300, 750) / 1000
                    _G.tween(v8, { v16, Enum.EasingStyle.Linear, Enum.EasingDirection.Out }, {
                        ["Transparency"] = 1,
                        ["CFrame"] = v8.CFrame * CFrame.Angles(0, 3.12413936106985, 0)
                    })
                    _G.tween(v8.Mesh, { v16, Enum.EasingStyle.Sine, Enum.EasingDirection.Out }, {
                        ["Scale"] = Vector3.new(-15, -25, -15) * math.random(300, 1100) / 1000
                    })
                    _G.destroy(v8, v16)
                end
            end)
        end
    end
}