 

local v1 = game:GetService("ReplicatedStorage")
local u2 = require(v1.Modules.Client.WeaponVFXRecolor)
local u3 = script.Firework
local u4 = script.FireworkPrestige
return {
    ["start"] = function(_, p5) --[[ Name: start, Line 8 ]]
        --[[
        Upvalues:
            [1] = u4
            [2] = u3
            [3] = u2
        --]]
        local v6 = p5.rootPart
        local v7 = p5.prestige
        local v8 = p5.small
        local v9 = p5.char
        if _G.checkRenderDistance(v6.Position) ~= false then
            local v10
            if v7 then
                v10 = u4:Clone()
            else
                v10 = u3:Clone()
            end
            u2.apply(v10, v9)
            v10.CFrame = v6.CFrame
            v10.Parent = workspace.Effects
            if v8 ~= nil then
                _G.scaleParticle(v10, 0.75, true)
            end
            for _, v11 in v10:GetDescendants() do
                if v11:IsA("ParticleEmitter") then
                    _G.customEmit(v11)
                end
            end
            _G.tween(v10.Attachment.PointLight, { v7 and 0.16 or 0.13, "Quint", "Out" }, {
                ["Brightness"] = v7 and 5.5 or 5
            })
            task.wait(v7 and 0.15 or 0.13)
            _G.tween(v10.Attachment.PointLight, { 0.15, "Linear", "Out" }, {
                ["Brightness"] = 0
            })
            _G.destroy(v10, 3)
            task.wait(1)
        end
    end
}