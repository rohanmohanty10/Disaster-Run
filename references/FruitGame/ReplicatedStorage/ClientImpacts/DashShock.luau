 

local v1 = {}
_G.getEffect("Shockwave2")
_G.getEffect("Beam")
local function u7(p2) --[[ Line: 7 ]]
    local v3 = script.Bolts:GetChildren()
    local v4 = {}
    for v5 = 1, #v3 do
        local v6 = v3[v5]:Clone()
        v6.Parent = p2
        table.insert(v4, v6)
    end
    return v4
end
function v1.start(_, p8) --[[ Line: 18 ]]
    --[[
    Upvalues:
        [1] = u7
    --]]
    local u9 = p8.char
    if u9 == nil then
        return
    elseif not u9:FindFirstChild("HumanoidRootPart") or _G.checkRenderDistance(u9.HumanoidRootPart.CFrame.p) ~= false then
        local v10 = u9.HumanoidRootPart.CFrame
        local v11 = Ray.new(v10.p, v10.upVector * -10)
        local u12, v13 = _G.raycastIgnoreList(v11, { workspace.Effects, workspace.PlayerCharacters, workspace.Projectiles })
        if u12 then
            local v14 = script.dust2:Clone()
            v14.Parent = workspace.Effects
            local v15 = (v10.p - v13).magnitude
            v14.CFrame = v10 * CFrame.new(0, -v15, 0)
            v14.Attachment.sm2.Color = ColorSequence.new(u12.Color)
            v14.Attachment.sm2:Emit(25)
            _G.destroy(v14, 1)
        end
        local u16 = script.HumanoidRootPart.Attachment:Clone()
        u16.Parent = u9.UpperTorso
        _G.destroy(u16, 10)
        local v17 = u9:GetChildren()
        local u18 = {}
        for v19 = 1, #v17 do
            if v17[v19]:IsA("BasePart") and v17[v19].Transparency ~= 1 then
                local v20 = u7(v17[v19])
                for v21 = 1, #v20 do
                    local v22 = v20[v21]
                    table.insert(u18, v22)
                end
            end
        end
        _G.PlaySound(u9.Head, script.Electro)
        _G.PlaySound(u9.Head, script["Jump (2)"], {
            ["TimePosition"] = 0.35
        })
        local v23 = script.Part.PointLight:Clone()
        v23.Parent = u9.HumanoidRootPart
        _G.tween(v23, {
            0.25,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out,
            0,
            true,
            0
        }, {
            ["Range"] = 12
        })
        _G.destroy(v23, 0.5)
        task.spawn(function() --[[ Line: 58 ]]
            --[[
            Upvalues:
                [1] = u12
                [2] = u9
            --]]
            task.wait(0.2)
            if u12 then
                local v24 = script.Slide:Clone()
                v24.Parent = u9.Head
                v24:Play()
                _G.tween(v24, {
                    2,
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Volume"] = 0
                })
                _G.destroy(v24, 2)
            end
        end)
        task.spawn(function() --[[ Line: 68 ]]
            --[[
            Upvalues:
                [1] = u9
            --]]
            task.wait(0.65)
            local v25 = u9.HumanoidRootPart.CFrame
            local v26 = Ray.new(v25.p, v25.upVector * -10)
            local v27, _ = _G.raycastIgnoreList(v26, { workspace.Effects, workspace.PlayerCharacters, workspace.Projectiles })
            if v27 then
                local v28 = script.dust:Clone()
                v28.Parent = u9
                v28.Attachment.sm2.Color = ColorSequence.new(v27.Color)
                v28.Attachment.rocks.Color = ColorSequence.new(v27.Color)
                _G.destroy(v28, 1.5)
                local v29 = Instance.new("Weld", v28)
                v29.Part0 = u9.HumanoidRootPart
                v29.Part1 = v28
                v29.C0 = CFrame.new(0, -2, 0)
                task.wait(0.35)
                v28.Attachment.sm2.Enabled = false
                v28.Attachment.rocks.Enabled = false
            end
        end)
        task.spawn(function() --[[ Line: 91 ]]
            --[[
            Upvalues:
                [1] = u16
                [2] = u18
            --]]
            task.wait(1)
            if u16:FindFirstChild("ParticleEmitter") then
                u16.ParticleEmitter.Enabled = false
            end
            _G.destroy(u16, 1)
            for v30 = 1, #u18 do
                u18[v30].Enabled = false
                _G.destroy(u18[v30], 1)
            end
        end)
    end
end
return v1