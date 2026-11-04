 

game:GetService("ReplicatedStorage")
game:GetService("RunService")
game:GetService("TweenService")
local u1 = require(game:GetService("ReplicatedStorage").Modules.Client.WeaponVFXRecolor)
local u2 = script.Parent["Rocket Launcher Firework Assets"]
local v3 = {}
local function u8(p4, p5, p6) --[[ Line: 16 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u1
    --]]
    local v7
    if p5 == false then
        v7 = u2.FireworkExplosion:Clone()
    else
        v7 = u2.PrestigeFireworkExplosion:Clone()
    end
    u1.apply(v7, p6)
    v7.Position = p4
    v7.Parent = workspace.Effects
    _G.customEmit(v7)
    _G.destroy(v7, 4)
end
function v3.start(_, p9) --[[ Line: 34 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u1
        [3] = u8
    --]]
    local u10 = p9.startCF
    local v11 = p9.mouseCF
    local v12 = p9.rocketLauncher
    local u13 = p9.prestige
    local v14 = p9.targets
    local u15 = p9.char
    if _G.checkRenderDistance(u10.Position) ~= false then
        Random.new()
        local u16 = RaycastParams.new()
        u16.FilterType = Enum.RaycastFilterType.Include
        u16.FilterDescendantsInstances = v14
        _G.customEmit(v12)
        local u17
        if u13 == false then
            u17 = u2.Rocket:Clone()
        else
            u17 = u2.PrestigeRocket:Clone()
        end
        u1.apply(u17, u15)
        u17.CFrame = CFrame.new(u10.Position, v11.Position) * CFrame.Angles(0, -1.5707963267948966, 0)
        u17.Parent = workspace.Effects
        _G.PlaySound(u17, script.AniRocketClusterShotShoot)
        local u18 = tick()
        local u19 = nil
        local u20 = false
        local u21 = u17.CFrame
        u19 = game["Run Service"].Heartbeat:Connect(function(p22) --[[ Line: 182 ]]
            --[[
            Upvalues:
                [1] = u20
                [2] = u17
                [3] = u21
                [4] = u16
                [5] = u18
                [6] = u8
                [7] = u13
                [8] = u15
                [9] = u19
                [10] = u10
            --]]
            if u20 == true then
                return
            else
                u17.CFrame = u17.CFrame * CFrame.new(-p22 * 160 + 0.01, 0, 0)
                local v23 = CFrame.new(u21.Position, u17.CFrame.Position)
                local v24 = (u21.Position - u17.Position).Magnitude
                local v25 = workspace:Blockcast(v23, u17.Size, v23.LookVector * v24, u16)
                if u18 + 2 <= tick() then
                    u8(u17.Position, u13, u15)
                    u17.Transparency = 1
                    _G.particleEnabled(u17, false, true)
                    _G.destroy(u17, 1.5)
                    u19:Disconnect()
                    u19 = nil
                    return
                elseif v25 and v25.Instance then
                    local v26 = _G.getTargetByPart(v25.Instance)
                    if v26 and v26:FindFirstChild("Humanoid") then
                        local v27 = CFrame.lookAt
                        local v28 = v26.HumanoidRootPart.CFrame.Position
                        local v29 = u10.Position.X
                        local v30 = v26.HumanoidRootPart.CFrame.Position.Y
                        local v31 = u10.Position.Z
                        local v32 = v27(v28, (Vector3.new(v29, v30, v31)))
                        v26.HumanoidRootPart.CFrame = v32
                        u17.Anchored = true
                        _G.customWeld(u17, v26.UpperTorso, CFrame.new(0, -0.5, 0) * CFrame.Angles(0, 1.5707963267948966, 0), u17)
                        local v33 = v26.HumanoidRootPart.CFrame.Position
                        local _ = (v32 * CFrame.new(0, -5, 50)).Position
                        local v34 = (v32 * CFrame.new(0, 50, 50)).Position
                        local _ = v32 * CFrame.new(0, 50, 50)
                        local v35 = v34.X
                        local v36 = v33.Y
                        local v37 = v34.Z
                        local v38 = Vector3.new(v35, v36, v37)
                        CFrame.new(v38, v33)
                        tick()
                        u20 = true
                        task.wait(1)
                        u17:Destroy()
                        u19:Disconnect()
                    else
                        u8(u17.Position, u13, u15)
                        u17.Transparency = 1
                        _G.particleEnabled(u17, false, true)
                        _G.destroy(u17, 1.5)
                        u19:Disconnect()
                    end
                else
                    u21 = u17.CFrame
                    return
                end
            end
        end)
        local v39 = {
            ["char"] = u15,
            ["rocket"] = u17,
            ["rocketTravelConnection"] = u19
        }
        _G.PlayEffect("FireworkRocketTrail", nil, v39)
    end
end
return v3