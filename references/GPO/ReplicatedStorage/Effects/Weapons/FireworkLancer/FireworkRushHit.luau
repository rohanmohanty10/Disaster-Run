 

local u1 = require(game:GetService("ReplicatedStorage").Modules.Client.WeaponVFXRecolor)
local u2 = script.FireworkRushHit
local u3 = script.FireworkRushHitPrestige
return {
    ["start"] = function(_, p4, p5, p6) --[[ Name: start, Line 7 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u2
            [3] = u1
        --]]
        if _G.checkRenderDistance(p4.Position) ~= false then
            local v7
            if p6 then
                v7 = u3:Clone()
            else
                v7 = u2:Clone()
            end
            u1.apply(v7, p5.Parent)
            v7.CFrame = CFrame.lookAt(p5.Position, p4.Position)
            v7.Parent = workspace.Effects
            for _, v8 in v7:GetDescendants() do
                if v8:IsA("ParticleEmitter") then
                    _G.customEmit(v8)
                end
            end
            _G.destroy(v7, 1.2)
        end
    end
}