 

local v1 = {}
game:GetService("Debris")
game:GetService("TweenService")
game:GetService("RunService")
require(game.ReplicatedStorage.Modules.BoatTween)
local u2 = require(game.ReplicatedStorage.Modules.RotatedRegion3)
Random.new()
function v1.start(_, u3, p4, u5) --[[ Line: 32 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local _ = u5.isMochiFruit == true
    local u6 = script
    local u7 = u5.hakiColor
    if p4 == "Startup" then
        local v8 = u3:FindFirstChild(script.Parent.Name .. "Sword")
        if v8 then
            local v9 = u6.EnchantTrident:Clone()
            v9.Weld.Part1 = v8.Blade
            _G.PlayEffect("3SSRecolor", nil, v9, u7, "isRed", Color3.fromRGB(255, 0, 0))
            v9.Parent = workspace.Effects
            _G.customEmit(v9)
            _G.destroy(v9, 4)
            local v10 = script.BladeAura:GetChildren()
            for v11 = 1, #v10 do
                local v12 = v10[v11]:Clone()
                _G.PlayEffect("3SSRecolor", nil, v12, u7, "isRed", Color3.fromRGB(255, 0, 0))
                v12.Parent = v8.Blade
                _G.customEmit(v12)
                _G.destroy(v12, 3)
            end
            _G.PlaySound(u3.PrimaryPart, script.skill2_cast)
        end
    elseif p4 == "Stab" then
        local v13 = u5.Target
        if v13 == nil then
            return
        elseif v13.PrimaryPart ~= nil then
            local v14 = script.Stab:Clone()
            v14.CFrame = v13.UpperTorso.CFrame
            _G.PlayEffect("3SSRecolor", nil, v14, u7, "isRed", Color3.fromRGB(255, 0, 0))
            v14.Parent = workspace.Effects
            _G.customEmit(v14)
            _G.destroy(v14, 3)
        end
    elseif p4 == "Throw" then
        local v15 = script.Throw:Clone()
        v15.CFrame = u5.ThrowCFrame
        _G.PlayEffect("3SSRecolor", nil, v15, u7, "isRed", Color3.fromRGB(255, 0, 0))
        v15.Parent = workspace.Effects
        _G.customEmit(v15)
        _G.destroy(v15, 4)
        local v16 = _G.PlaySound(v15, script.throw2)
        if u5.projectile ~= nil then
            v16.Parent = u5.projectile
        end
    elseif p4 == "HookProjectile" then
        local u17 = u5.projectile
        if u17 then
            local u18 = false
            local u19 = u5.projectileLifetime
            local u20 = u5.endCFrameGoal
            local u21 = nil
            local function v22() --[[ Line: 117 ]]
                --[[
                Upvalues:
                    [1] = u18
                    [2] = u21
                    [3] = u17
                --]]
                if u18 ~= true then
                    warn("trident client fade")
                    if u21 then
                        u21:Disconnect()
                        u21 = nil
                    end
                    u18 = true
                    _G.particleEnabled(u17, false)
                    if u17:FindFirstChild("loopedSFX") then
                        _G.tween(u17.loopedSFX, {
                            0.25,
                            Enum.EasingStyle.Quad,
                            Enum.EasingDirection.Out,
                            0,
                            false,
                            0
                        }, {
                            ["Volume"] = 0
                        })
                    end
                end
            end
            u17:GetAttributeChangedSignal("Faded"):Once(v22)
            local u23 = u5.startCFrame
            local u24 = workspace:GetServerTimeNow()
            local u25 = u17.Position
            u21 = game:GetService("RunService").Heartbeat:Connect(function() --[[ Line: 145 ]]
                --[[
                Upvalues:
                    [1] = u24
                    [2] = u19
                    [3] = u17
                    [4] = u23
                    [5] = u20
                    [6] = u25
                    [7] = u2
                    [8] = u3
                    [9] = u21
                --]]
                local v26 = (workspace:GetServerTimeNow() - u24) / u19
                local v27 = math.min(v26, 1)
                u17.CFrame = u23:Lerp(u20, v27)
                local v28 = u17.Position
                local v29 = v28 - u25
                local v30 = v29.Magnitude
                if v30 > 0 then
                    local v31 = u25 + v29 * 0.5
                    local v32 = CFrame.lookAt(v31, v28) * CFrame.Angles(1.5707963267948966, 0, 0)
                    local v33 = u2.new(v32, (Vector3.new(6, v30, 6))):FindPartsInRegion3WithWhiteList(_G.getTargets(u3, nil, nil, true), 50000)
                    for v34 = 1, #v33 do
                        if _G.getTargetByPart(v33[v34]) ~= nil then
                            _G.particleEnabled(u17, false)
                            u17:SetAttribute("Stopped", true)
                            break
                        end
                    end
                end
                u25 = v28
                if u17:GetAttribute("Stopped") then
                    if u21 then
                        u21:Disconnect()
                        u21 = nil
                    end
                    return
                elseif v27 >= 1 then
                    u21:Disconnect()
                end
            end)
        end
    else
        if p4 == "TP" then
            local v35 = u3.PrimaryPart
            local v36 = u3:FindFirstChild("UpperTorso")
            if not (v36 and v35) then
                return
            end
            local v37 = u6.Dust:Clone()
            v37.CFrame = u5.oldCFrame
            _G.PlayEffect("3SSRecolor", nil, v37, u7, "isRed", Color3.fromRGB(255, 0, 0))
            _G.vfxToFloor(v37.VFX, {
                ["StartCFrame"] = v37.CFrame
            })
            v37.Parent = workspace.Effects
            local u38 = u6.TP:Clone()
            u38.Weld.Part1 = v36
            _G.PlayEffect("3SSRecolor", nil, u38, u7, "isRed", Color3.fromRGB(255, 0, 0))
            u38.Parent = workspace.Effects
            _G.customEmit(v37)
            _G.PlaySound(u3.PrimaryPart, script.skill2_tp).Parent = u3.PrimaryPart
            task.spawn(function() --[[ Line: 215 ]]
                --[[
                Upvalues:
                    [1] = u38
                --]]
                task.wait()
                _G.customEmit(u38)
            end)
            _G.destroy({ v37, u38 }, 5)
            task.delay(0.3, function() --[[ Line: 222 ]]
                --[[
                Upvalues:
                    [1] = u38
                --]]
                _G.particleEnabled(u38, false)
            end)
            local u39 = u3:FindFirstChild("RightLowerArm")
            if not u39 then
                return
            end
            task.delay(u5.HakiTime - workspace:GetServerTimeNow(), function() --[[ Line: 231 ]]
                --[[
                Upvalues:
                    [1] = u6
                    [2] = u39
                    [3] = u7
                --]]
                local v40 = u6.HakiEnchant:Clone()
                v40.Weld.Part1 = u39
                _G.PlayEffect("3SSRecolor", nil, v40, u7, "isRed", Color3.fromRGB(255, 0, 0))
                v40.Parent = workspace.Effects
                _G.customEmit(v40)
                _G.destroy(v40, 4)
            end)
            task.delay(u5.BashTime - workspace:GetServerTimeNow(), function() --[[ Line: 242 ]]
                --[[
                Upvalues:
                    [1] = u5
                    [2] = u6
                    [3] = u7
                --]]
                if u5.Target == nil then
                    return
                elseif u5.Target.PrimaryPart ~= nil then
                    _G.PlaySound(u5.Target.PrimaryPart.CFrame, script.skill2_punch)
                    local v41 = u6.Bash:Clone()
                    v41.CFrame = u5.Target.PrimaryPart.CFrame * CFrame.new(0, u5.Target.PrimaryPart.Size.Y, 0) * CFrame.Angles(0, 3.141592653589793, 0)
                    _G.PlayEffect("3SSRecolor", nil, v41, u7, "isRed", Color3.fromRGB(255, 0, 0))
                    v41.Parent = workspace.Effects
                    _G.customEmit(v41)
                    _G.destroy(v41, 4)
                end
            end)
        end
        return
    end
end
return v1