 

local v1 = {}
local u2 = game:GetService("TweenService")
function v1.start(_, p3) --[[ Line: 36 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v4 = p3.startPosition
    local v5 = p3.endPosition
    local v6 = p3.weaponModel
    local v7 = p3.Speed
    if v6 then
        local v8 = v6:FindFirstChild("shootAttachment", true)
        if v8 then
            v4 = v8.WorldPosition
        end
    end
    local v9 = (v4 - v5).Magnitude
    local v10 = CFrame.new(v4, v5)
    local u11 = script.Model.SnowballProjectile:Clone()
    u11:PivotTo(v10)
    u11.Parent = workspace.Effects
    _G.destroy(u11, 2)
    local v12 = script.Model.ShootFX:Clone()
    v12.CFrame = v10
    v12.Parent = workspace.Effects
    _G.customEmit(v12)
    _G.destroy(v12, 2)
    _G.PlaySound(v10, script["SnowglobeRodShot" .. math.random(1, 3)]).Parent = u11.PrimaryPart
    local v13 = u11:GetDescendants()
    local v14 = {}
    local u15 = false
    for v16 = 1, #v13 do
        if v13[v16]:IsA("Beam") then
            local v17 = v13[v16]
            table.insert(v14, v17)
        end
    end
    task.spawn(function() --[[ Line: 74 ]]
        --[[
        Upvalues:
            [1] = u11
        --]]
        _G.particleEnabled(u11.Main.Dust, false, true)
    end)
    local u18 = u11.PrimaryPart.CFrame * CFrame.new(0, 0, -v9)
    local u19 = u2:Create(u11.PrimaryPart, TweenInfo.new(v7, Enum.EasingStyle.Linear), {
        ["CFrame"] = u18
    })
    u19:Play()
    local _ = p3.hitCFrame
    u19.Completed:Connect(function() --[[ Line: 111 ]]
        --[[
        Upvalues:
            [1] = u19
            [2] = u15
            [3] = u11
            [4] = u18
        --]]
        u19:Destroy()
        u15 = true
        _G.tween(u11.Main, {
            1,
            "Linear",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["CFrame"] = u11.Main.CFrame
        })
        _G.particleEnabled(u11, false, true)
        _G.destroy(u11, 1)
        u11.Mesh.Decal.Transparency = 1
        local v20 = script.Model.HitFX:Clone()
        v20.Position = u11.Mesh.Position
        v20.Parent = workspace.Effects
        _G.customEmit(v20)
        _G.destroy(v20, 3)
        _G.PlaySound(u18, script.SnowglobeRodShotHitSurface, {
            ["RandomPitch"] = true
        })
    end)
end
return v1