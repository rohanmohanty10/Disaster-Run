 

local v1 = {}
local u2 = require(game.ReplicatedStorage.Modules.Client.WeaponVFXRecolor)
local function u9(p3, p4) --[[ Line: 4 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v5 = script.Bolts:GetChildren()
    local v6 = {}
    for v7 = 1, #v5 do
        local v8 = v5[v7]:Clone()
        u2.apply(v8, p4)
        v8.Parent = p3
        table.insert(v6, v8)
    end
    return v6
end
function v1.start(_, p10) --[[ Line: 16 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u9
    --]]
    local u11 = p10.char
    if u11 == nil then
        return
    elseif not u11:FindFirstChild("HumanoidRootPart") or _G.checkRenderDistance(u11.HumanoidRootPart.CFrame.Position) ~= false then
        local v12 = u11.HumanoidRootPart.CFrame
        local v13 = Ray.new(v12.Position, v12.upVector * -10)
        local u14, v15 = _G.raycastIgnoreList(v13, { workspace.Effects, workspace.PlayerCharacters, workspace.Projectiles })
        if u14 then
            local v16 = script.dust2:Clone()
            v16.Parent = workspace.Effects
            local v17 = (v12.Position - v15).Magnitude
            v16.CFrame = v12 * CFrame.new(0, -v17, 0)
            v16.Attachment.sm2.Color = ColorSequence.new(u14.Color)
            v16.Attachment.sm2:Emit(25)
            _G.destroy(v16, 1)
        end
        local u18 = script.HumanoidRootPart.Attachment:Clone()
        u2.apply(u18, u11)
        u18.Parent = u11.UpperTorso
        _G.destroy(u18, 10)
        local v19 = u11:GetChildren()
        local u20 = {}
        for v21 = 1, #v19 do
            if v19[v21]:IsA("BasePart") and v19[v21].Transparency ~= 1 then
                local v22 = u9(v19[v21], u11)
                for v23 = 1, #v22 do
                    local v24 = v22[v23]
                    table.insert(u20, v24)
                end
            end
        end
        _G.PlaySound(u11.Head, script.Electro)
        _G.PlaySound(u11.Head, script["Jump (2)"], {
            ["TimePosition"] = 0.35
        })
        local v25 = script.Part.PointLight:Clone()
        u2.apply(v25, u11)
        v25.Parent = u11.HumanoidRootPart
        _G.tween(v25, {
            0.25,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out,
            0,
            true,
            0
        }, {
            ["Range"] = 12
        })
        _G.destroy(v25, 0.5)
        task.spawn(function() --[[ Line: 58 ]]
            --[[
            Upvalues:
                [1] = u14
                [2] = u11
            --]]
            task.wait(0.2)
            if u14 then
                local v26 = script.Slide:Clone()
                v26.Parent = u11.Head
                v26:Play()
                _G.tween(v26, {
                    2,
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Volume"] = 0
                })
                _G.destroy(v26, 2)
            end
        end)
        task.spawn(function() --[[ Line: 68 ]]
            --[[
            Upvalues:
                [1] = u11
            --]]
            task.wait(0.65)
            local v27 = u11.HumanoidRootPart.CFrame
            local v28 = Ray.new(v27.Position, v27.upVector * -10)
            local v29, _ = _G.raycastIgnoreList(v28, { workspace.Effects, workspace.PlayerCharacters, workspace.Projectiles })
            if v29 then
                local v30 = script.dust:Clone()
                v30.Parent = u11
                v30.Attachment.sm2.Color = ColorSequence.new(v29.Color)
                v30.Attachment.rocks.Color = ColorSequence.new(v29.Color)
                _G.destroy(v30, 1.5)
                local v31 = Instance.new("Weld")
                v31.Part0 = u11.HumanoidRootPart
                v31.Part1 = v30
                v31.C0 = CFrame.new(0, -2, 0)
                v31.Parent = v30
                task.wait(0.35)
                v30.Attachment.sm2.Enabled = false
                v30.Attachment.rocks.Enabled = false
            end
        end)
        task.spawn(function() --[[ Line: 92 ]]
            --[[
            Upvalues:
                [1] = u18
                [2] = u20
            --]]
            task.wait(1)
            if u18:FindFirstChild("ParticleEmitter") then
                u18.ParticleEmitter.Enabled = false
            end
            _G.destroy(u18, 1)
            for v32 = 1, #u20 do
                u20[v32].Enabled = false
                _G.destroy(u20[v32], 1)
            end
        end)
    end
end
return v1