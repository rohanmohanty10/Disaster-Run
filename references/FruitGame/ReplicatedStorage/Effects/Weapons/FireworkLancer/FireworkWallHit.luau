 

local u1 = game:GetService("TweenService")
local v2 = game:GetService("ReplicatedStorage")
local u3 = require(v2.Modules.Client.WeaponVFXRecolor)
local u4 = script.Groundbreak
local u5 = script.GroundbreakPrestige
local _ = script.Rock
return {
    ["start"] = function(_, p6) --[[ Name: start, Line 10 ]]
        --[[
        Upvalues:
            [1] = u5
            [2] = u4
            [3] = u3
            [4] = u1
        --]]
        local _ = p6.target
        local v7 = p6.position
        local v8 = p6.normal
        local v9 = p6.part
        local v10 = p6.prestige
        local v11 = p6.char
        if _G.checkRenderDistance(v7) ~= false then
            local v12 = CFrame.new(v7, v7 + v8)
            local v13
            if v10 then
                v13 = u5:Clone()
            else
                v13 = u4:Clone()
            end
            u3.apply(v13, v11)
            local u14 = v13.Crack
            local v15 = u14.Size
            v13.CFrame = v12 * CFrame.Angles(1.5707963267948966, 0, -3.141592653589793) * CFrame.new(0, 0.05, 0)
            v13.Parent = workspace.Effects
            _G.scaleParticle(v13, 1.5, true)
            for _, v16 in v13:GetDescendants() do
                if v16:IsA("ParticleEmitter") and (v16.Name ~= "Dust" and v16.Name ~= "Rocks") then
                    _G.customEmit(v16)
                end
            end
            v13.Dust.Color = ColorSequence.new(v9.Color)
            _G.customEmit(v13.Dust)
            v13.Attachment.Rocks.Color = ColorSequence.new(v9.Color)
            _G.customEmit(v13.Attachment.Rocks)
            _G.PlaySound(v13, script.hitWall)
            u14.Size = Vector3.new()
            u14.CFrame = v12 * CFrame.new(0, 0, -0.05)
            u1:Create(u14, TweenInfo.new(0.4, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                ["Size"] = v15
            }):Play()
            task.delay(1.5, function() --[[ Line: 48 ]]
                --[[
                Upvalues:
                    [1] = u14
                    [2] = u1
                --]]
                for _, v17 in ipairs(u14:GetChildren()) do
                    if v17:IsA("Decal") then
                        u1:Create(v17, TweenInfo.new(1), {
                            ["Transparency"] = 1
                        }):Play()
                    end
                end
            end)
            _G.destroy(v13, 4)
        end
    end
}