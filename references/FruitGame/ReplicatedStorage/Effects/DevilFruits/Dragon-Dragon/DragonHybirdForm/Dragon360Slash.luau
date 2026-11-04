 

local v1 = {}
local u2 = game:GetService("TweenService")
local u3 = require(script.Parent.Parent.SlashMesh)
function PlayAnim(p4, p5, p6)
    local v7 = (p4:FindFirstChild("Humanoid") or p4:FindFirstChild("AnimationController")).Animator:LoadAnimation(script[p5])
    v7:Play(0, 1, 1)
    v7:AdjustSpeed(p6)
    return v7
end
Random.new()
function v1.start(_, p8, p9, p10) --[[ Line: 69 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u3
    --]]
    local v11 = p8:GetPivot()
    local v12 = Random.new()
    local v13, v14, v15 = _G.getRayFloor(v11, 8)
    local v16 = v14 + Vector3.new(0, 0.25, 0)
    local v17 = CFrame.new(v16, v16 + v15) * CFrame.Angles(1.5707963267948966, 0, 0)
    local v18 = script.VFXModel:Clone()
    v18:ScaleTo(p10)
    _G.destroy(v18, 10)
    local v19 = v18.Startup
    v19.CFrame = v11
    if v13 then
        v19.Attachment.WorldCFrame = v17
    end
    v19.Parent = workspace.Effects
    _G.customEmit(v19)
    _G.PlaySound(p8.PrimaryPart, script.DragonFlameSpinStart).Parent = p8.PrimaryPart
    local v20 = PlayAnim(p8, "PlayerAnim", p9)
    local v21 = _G.castingSkill(p8, 0.45 / p9)
    local v22 = v19.Main.PointLight
    v22.Brightness = 8
    v22.Parent = p8.PrimaryPart
    u2:Create(v22, TweenInfo.new(1.25), {
        ["Brightness"] = 0,
        ["Range"] = v22.Range * 2
    }):Play()
    _G.destroy(v22, 1.25)
    if v21 == false then
        _G.destroy(v19, 3)
        v20:Stop()
    else
        local v23 = p8:GetPivot()
        local v24, v25, v26 = _G.getRayFloor(v23, 8)
        local v27 = v25 + Vector3.new(0, 0.25, 0)
        local v28 = CFrame.new(v27, v27 + v26) * CFrame.Angles(1.5707963267948966, 0, 0)
        local v29 = v18.SlashParticles
        v29.CFrame = v23
        if v24 then
            v29.Floor.WorldCFrame = v28
        end
        v29.Parent = workspace.Effects
        v22.Parent = v29
        u2:Create(v29, TweenInfo.new(1.5), {
            ["CFrame"] = v29.CFrame * CFrame.Angles(0, 1.5707963267948966, 0)
        }):Play()
        _G.PlaySound(p8.PrimaryPart, script.DragonFlameSpin)
        _G.customEmit(v29)
        _G.destroy(v29, 3)
        _G.destroy(v19, 3)
        for v30 = -1, 1, 2 do
            u3(1, v12:NextNumber(0.4, 0.6), v23 * CFrame.Angles(v12:NextNumber(-0.1308996938995747, 0.1308996938995747), 3.141592653589793 * v30, 0), { 0.25 * p10, v12:NextNumber(1, 1.5) * p10 })
        end
    end
end
return v1