 

local v1 = {}
local _ = workspace.Effects
local _ = game["Run Service"]
local u2 = game:GetService("TweenService")
local u3 = require(game.ReplicatedStorage.Modules.Client.WeaponVFXRecolor)
function v1.start(_, p4, p5) --[[ Line: 8 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u2
    --]]
    local v6 = game.Players.LocalPlayer.Character
    if p4 == "cast" then
        local v7 = p5.EffectRadius or 10
        local v8 = p5.castCFrame
        local v9 = script.AreaRingV2:Clone()
        u3.apply(v9, v6)
        v9.CFrame = v8 * CFrame.new(0, -2, 0) * CFrame.Angles(0, 0, 0)
        v9.Parent = workspace.Effects
        local v10 = u2
        local v11 = TweenInfo.new(1, Enum.EasingStyle.Exponential)
        local v12 = {}
        local v13 = v7 * 1.3
        local v14 = v7 * 1.3
        v12.Size = Vector3.new(v13, 1, v14)
        v12.Transparency = 1
        v10:Create(v9, v11, v12):Play()
        _G.destroy(v9, 1.1)
        local v15 = script.MochiC:Clone()
        u3.apply(v15, v6)
        v15.CFrame = v8 * CFrame.new(0, -2, 0) * CFrame.Angles(0, 0, 0)
        v15.Parent = workspace.Effects
        _G.customEmit(v15)
        _G.destroy(v15, 2)
    end
end
return v1