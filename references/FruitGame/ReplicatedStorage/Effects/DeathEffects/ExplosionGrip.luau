 

local v1 = {}
local u2 = game:GetService("TweenService")
local u3 = _G.customEmit
function v1.start(_, p4) --[[ Line: 9 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u2
    --]]
    local v5 = Random.new()
    local v6 = p4:GetPivot()
    local v7 = script.Explosion:Clone()
    v7.CFrame = v6
    v7.Parent = workspace.Effects
    u3(v7)
    _G.destroy(v7, 2.5)
    u2:Create(v7.Attachment.Light, TweenInfo.new(0.8), {
        ["Brightness"] = 0
    }):Play()
    _G.PlaySound(p4.PrimaryPart, script.ExplosionGrip)
    local v8 = v5:NextInteger(3, 5)
    local v9 = v5:NextInteger(0, 90)
    for v10 = 1, v8 do
        local v11 = 360 / v8 * v10 + v9
        local v12 = math.rad(v11)
        local v13 = CFrame.new
        local v14 = v6.Position
        local v15 = v6.Position
        local v16 = math.cos(v12)
        local v17 = math.sin(v12)
        local v18 = v13(v14, v15 + Vector3.new(v16, 0, v17)).LookVector
        local v19 = v5:NextNumber(0.5, 1)
        local v20 = v18 + Vector3.new(0, v19, 0)
        local u21 = script.ExplosionDebris:Clone()
        u21.CFrame = v6
        u21.Parent = workspace.Effects
        u21.Anchored = false
        u21.CanCollide = false
        local v22 = Instance.new("BodyVelocity")
        v22.Velocity = v20 * v5:NextInteger(45, 60)
        v22.Parent = u21
        _G.destroy(v22, 0.175)
        task.delay(0.175, function() --[[ Line: 41 ]]
            --[[
            Upvalues:
                [1] = u21
            --]]
            u21.CanCollide = true
        end)
        task.delay(1, function() --[[ Line: 45 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u21
            --]]
            u2:Create(u21.Attachment.Light, TweenInfo.new(0.4), {
                ["Brightness"] = 0
            }):Play()
            for _, v23 in u21:GetDescendants() do
                if v23:IsA("ParticleEmitter") or v23:IsA("Trail") then
                    v23.Enabled = false
                end
            end
            _G.destroy(u21, 1.25)
        end)
    end
end
return v1