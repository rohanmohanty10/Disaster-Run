 

local v1 = game:GetService("ReplicatedStorage")
local u2 = require(v1.Modules.Client.WeaponVFXRecolor)
local u3 = script.Normal
local u4 = script.Prestige
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
        local v8 = p5.char
        if _G.checkRenderDistance(v6.Position) ~= false then
            local v9
            if v7 then
                v9 = u4:Clone()
            else
                v9 = u3:Clone()
            end
            u2.apply(v9, v8)
            v9.CFrame = v6.CFrame
            v9.Parent = workspace.Effects
            for _, v10 in v9:GetDescendants() do
                if v10:IsA("ParticleEmitter") then
                    _G.customEmit(v10)
                end
            end
            _G.tween(v9.Attachment.PointLight, { v7 and 0.14 or 0.12, "Quint", "Out" }, {
                ["Brightness"] = v7 and 5.5 or 5
            })
            _G.PlaySound(v6, script.FireworkMiniBoom)
            task.wait(v7 and 0.14 or 0.12)
            _G.tween(v9.Attachment.PointLight, { 0.14, "Linear", "Out" }, {
                ["Brightness"] = 0
            })
            _G.destroy(v9, 3)
            task.wait(1)
        end
    end
}