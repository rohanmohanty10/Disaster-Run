 

game:GetService("ReplicatedStorage")
game:GetService("RunService")
game:GetService("TweenService")
local u1 = require(game:GetService("ReplicatedStorage").Modules.Client.WeaponVFXRecolor)
local u2 = script.Parent["Rocket Launcher Firework Assets"]
return {
    ["start"] = function(_, p3) --[[ Name: start, Line 11 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u1
        --]]
        local v4 = p3.startCF
        local v5 = p3.mouseCF
        local v6 = p3.rocketLauncher
        local u7 = p3.prestige
        local v8 = p3.targets
        local u9 = p3.char
        if _G.checkRenderDistance(v4.Position) ~= false then
            local u10 = RaycastParams.new()
            u10.FilterType = Enum.RaycastFilterType.Include
            u10.FilterDescendantsInstances = v8
            local function u22(p11) --[[ Line: 25 ]]
                --[[
                Upvalues:
                    [1] = u7
                    [2] = u2
                    [3] = u1
                    [4] = u9
                --]]
                local v12
                if u7 == false then
                    v12 = u2.FireworkExplosion:Clone()
                else
                    v12 = u2.PrestigeFireworkExplosion:Clone()
                end
                u1.apply(v12, u9)
                v12.Position = p11
                v12.Parent = workspace.Effects
                _G.PlaySound(v12, script["AniRocketBoom" .. math.random(1, 3)], {
                    ["Pitch"] = math.random(90, 110) / 100
                })
                _G.shakenear(v12.CFrame.Position, 35, 55, 75, -1)
                _G.customEmit(v12)
                _G.destroy(v12, 4)
                for _ = 1, 10 do
                    local v13 = u2.SmokeMesh:Clone()
                    u1.apply(v13, u9)
                    local v14 = CFrame.new(p11)
                    local v15 = CFrame.Angles
                    local v16 = math.random(0, 360)
                    local v17 = math.rad(v16)
                    local v18 = math.random(0, 360)
                    local v19 = math.rad(v18)
                    local v20 = math.random(0, 360)
                    v13.CFrame = v14 * v15(v17, v19, (math.rad(v20)))
                    v13.Mesh.Scale = Vector3.new(-3.25, -2, -3.25)
                    v13.Color = Color3.fromRGB(109, 109, 109)
                    v13.Parent = workspace.Effects
                    local v21 = math.random(750, 1000) / 1000
                    _G.tween(v13, { v21, Enum.EasingStyle.Linear, Enum.EasingDirection.Out }, {
                        ["Transparency"] = 1,
                        ["CFrame"] = v13.CFrame * CFrame.Angles(0, 3.12413936106985, 0)
                    })
                    _G.tween(v13.Mesh, { v21, Enum.EasingStyle.Sine, Enum.EasingDirection.Out }, {
                        ["Scale"] = Vector3.new(-15, -25, -15) * math.random(300, 1100) / 1000
                    })
                    _G.destroy(v13, v21)
                end
            end
            if v6 then
                _G.customEmit(v6)
            end
            local u23
            if u7 == false then
                u23 = u2.Rocket:Clone()
            else
                u23 = u2.PrestigeRocket:Clone()
            end
            u1.apply(u23, u9)
            u23.CFrame = CFrame.new(v4.Position, v5.Position) * CFrame.Angles(0, -1.5707963267948966, 0)
            u23.Parent = workspace.Effects
            _G.PlaySound(u23, script["AniRocketShoot" .. math.random(1, 3)])
            local u24 = tick()
            local u25 = nil
            local u26 = u23.CFrame
            u25 = game["Run Service"].Heartbeat:Connect(function(p27) --[[ Line: 77 ]]
                --[[
                Upvalues:
                    [1] = u23
                    [2] = u26
                    [3] = u10
                    [4] = u24
                    [5] = u22
                    [6] = u25
                --]]
                u23.CFrame = u23.CFrame * CFrame.new(-p27 * 160 + 0.01, 0, 0)
                local v28 = CFrame.new(u26.Position, u23.CFrame.Position)
                local v29 = (u26.Position - u23.Position).Magnitude
                local v30 = workspace:Blockcast(v28, u23.Size, v28.LookVector * v29, u10)
                if u24 + 2 <= tick() or v30 and v30.Instance ~= nil then
                    u22(u23.Position)
                    u23.Transparency = 1
                    _G.particleEnabled(u23, false, true)
                    _G.destroy(u23, 1.5)
                    u25:Disconnect()
                    u25 = nil
                else
                    u26 = u23.CFrame
                end
            end)
            local v31 = {
                ["char"] = u9,
                ["rocket"] = u23,
                ["rocketTravelConnection"] = u25
            }
            _G.PlayEffect("FireworkRocketTrail", nil, v31)
        end
    end
}