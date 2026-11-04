 

local v1 = {}
local u2 = script.Move1
local u3 = u2.Anims
local function u9(p4, p5, p6) --[[ Line: 4 ]]
    local v7 = p6 or {}
    local v8 = p4:LoadAnimation(p5)
    v8:Play()
    v8.Priority = v7.Priority or Enum.AnimationPriority.Action
    v8.Looped = v7.Looped or false
    return v8
end
local function u13(p10, p11) --[[ Line: 18 ]]
    for _, v12 in ipairs(p10:GetDescendants()) do
        if v12:IsA("Beam") then
            table.insert(p11, v12)
            v12.Enabled = true
        end
    end
end
function v1.start(_, p14, p15, u16) --[[ Line: 27 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u9
        [3] = u3
        [4] = u13
    --]]
    local u17 = Instance.new("Folder")
    u17.Parent = workspace.Effects
    local u18 = p14:WaitForChild("HumanoidRootPart")
    local v19 = p14:WaitForChild("Humanoid")
    local u20 = p14:FindFirstChild("Blood ScytheSword")
    if p15 == 1 then
        local u21 = u2.InitialSlash:Clone()
        local u22 = u2.BeamCrescents:Clone()
        local v23, v24, v25 = _G.getRayFloor(u18.CFrame, 8)
        local v26 = u9(v19, u3["Grasp Attempt"])
        u21.Parent = u17
        u22.Parent = u17
        u21.CFrame = u18.CFrame
        if v23 then
            local v27 = CFrame.new(v24, v24 + v25) * CFrame.Angles(-1.5707963267948966, 0, 0)
            _G.recolorParticles(u21, v23.Color)
            u21.VFX.WorldCFrame = v27 + Vector3.new(0, 0.2, 0)
        else
            u21.VFX:Destroy()
        end
        u22.CFrame = u18.CFrame * CFrame.Angles(0, 0, -0.3490658503988659)
        _G.PlaySound(u18, script["Audio/BSDownSlashStance"])
        local u28 = {}
        v26:GetMarkerReachedSignal("Ohio"):Connect(function() --[[ Line: 68 ]]
            --[[
            Upvalues:
                [1] = u21
                [2] = u13
                [3] = u22
                [4] = u28
                [5] = u18
            --]]
            _G.customEmit(u21)
            u13(u22, u28)
            _G.PlaySound(u18, script["Audio/BSPullAttackWhoosh1"])
            for _, v29 in ipairs(u28) do
                _G.tween(v29, {
                    0.23,
                    Enum.EasingStyle.Quad,
                    "Out",
                    0,
                    false,
                    0
                }, {
                    ["Width0"] = 0,
                    ["Width1"] = 0
                })
            end
            _G.tween(u22, {
                0.47,
                Enum.EasingStyle.Quad,
                "Out",
                0,
                false,
                0
            }, {
                ["CFrame"] = u22.CFrame * CFrame.Angles(0, 3.490658503988659, 0)
            })
        end)
        _G.destroy(u17, 5)
    end
    if p15 == 2 then
        local u30 = u2.Parent.WarpIndicatorEffect:Clone()
        local u31 = u2.mesh:Clone()
        local u32 = u2.Pull:Clone()
        local u33 = u2.ScythePuncture:Clone()
        local u34 = u9(v19, u3["Grasp Success"])
        u33.Parent = u17
        u30.Parent = u17
        u30.CFrame = u18.CFrame
        u33.CFrame = u18.CFrame * CFrame.new(0, 0, -7)
        _G.PlaySound(u16.PrimaryPart, script["Audio/BSPullAttackHit1"])
        _G.PlaySound(u18, script["Audio/BSPullAttackWhoosh2"])
        _G.emitHitVfx(script.HitVFX, u16.PrimaryPart.CFrame)
        local u36 = u34:GetMarkerReachedSignal("Gyatt"):Connect(function() --[[ Line: 106 ]]
            --[[
            Upvalues:
                [1] = u33
                [2] = u31
                [3] = u17
                [4] = u18
                [5] = u16
                [6] = u20
                [7] = u34
                [8] = u32
                [9] = u30
            --]]
            _G.customEmit(u33)
            u31.Parent = u17
            u31.CFrame = u18.CFrame * CFrame.Angles(1.5707963267948966, 0, 0)
            _G.tween(u31, {
                0.6,
                Enum.EasingStyle.Sine,
                "Out",
                0,
                false,
                0
            }, {
                ["CFrame"] = u31.CFrame * CFrame.new(0, -14, 0)
            })
            _G.tween(u31.Mesh, {
                0.45,
                Enum.EasingStyle.Quad,
                "Out",
                0,
                false,
                0
            }, {
                ["Scale"] = Vector3.new(0, 29, 0)
            })
            _G.PlaySound(u16.PrimaryPart, script["Audio/BSPullAttackHit2"])
            _G.PlaySound(u18, script["Audio/BSPullAttackWhoosh3"])
            _G.emitHitVfx(script.HitVFX, u16.PrimaryPart.CFrame)
            local u35
            if u20 then
                u35 = script.Blade.EnableBleeding:Clone()
                u35.Parent = u20.Blade
            else
                u35 = nil
            end
            u34:GetMarkerReachedSignal("Duke"):Connect(function() --[[ Line: 122 ]]
                --[[
                Upvalues:
                    [1] = u16
                    [2] = u32
                    [3] = u17
                    [4] = u33
                    [5] = u30
                    [6] = u35
                --]]
                _G.PlaySound(u16.PrimaryPart, script["Audio/BloodScythePull"])
                _G.PlaySound(u16.PrimaryPart, script["Audio/BSPullAttackHit3"])
                _G.emitHitVfx(script.HitVFX, u16.PrimaryPart.CFrame)
                u32.Parent = u17
                u32.CFrame = u33.CFrame * CFrame.new(0, 0, -2) * CFrame.Angles(0, 3.141592653589793, 0)
                _G.customEmit(u32)
                _G.customEmit(u30)
                _G.particleEnabled(u35, false)
                _G.destroy(u35, 5)
            end)
        end)
        task.delay(3, function() --[[ Line: 139 ]]
            --[[
            Upvalues:
                [1] = u36
                [2] = u17
            --]]
            u36:Disconnect()
            u17:Destroy()
        end)
    end
end
return v1