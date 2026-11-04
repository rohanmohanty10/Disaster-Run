 

local v1 = {}
game:GetService("Players")
local u2 = game:GetService("TweenService")
local _ = workspace.Effects
function v1.start(_, p3) --[[ Line: 29 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v4 = p3.startPosition
    local v5 = p3.endPosition
    local v6 = p3.delayTime - workspace:GetServerTimeNow()
    local v7 = p3.weaponModel
    task.wait(v6)
    if v7 and v7:FindFirstChild("Muzzle") then
        v4 = v7.Muzzle.Attachment.WorldPosition
    end
    local v8 = script.T_Fire_Fx:Clone()
    v8.CFrame = CFrame.new(v4)
    v8.Parent = workspace.Effects
    _G.customEmit(v8)
    _G.destroy(v8, 3)
    local v9 = p3.Speed
    local v10 = (v4 - v5).Magnitude
    local u11 = script.Bullet:Clone()
    u11.CFrame = CFrame.new(v4, v5) * CFrame.new(0, 0, 1)
    u11.Parent = workspace.Effects
    local v12 = {
        ["CFrame"] = u11.CFrame * CFrame.new(0, 0, -(v10 + 1))
    }
    local u13 = u2:Create(u11, TweenInfo.new(v9, Enum.EasingStyle.Linear), v12)
    u13:Play()
    local u14 = p3.hitCFrame
    _G.PlaySound(u11, script["IceGunbladeShotFire" .. math.random(1, 3)])
    u13.Completed:Connect(function() --[[ Line: 65 ]]
        --[[
        Upvalues:
            [1] = u13
            [2] = u11
            [3] = u14
        --]]
        u13:Destroy()
        u11.Transparency = 1
        _G.particleEnabled(u11, false, true)
        _G.destroy(u11, 3)
        local v15 = script.Hit_Fx:Clone()
        v15.CFrame = u14
        v15.Parent = workspace.Effects
        _G.customEmit(v15)
        _G.destroy(v15, 3)
        _G.PlaySound(v15, script.IceGunbladeShotGroundHit, {
            ["RandomPitch"] = true
        })
    end)
end
return v1