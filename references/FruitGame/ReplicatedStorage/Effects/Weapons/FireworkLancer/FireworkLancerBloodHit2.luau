 

local u1 = script.BloodHit2
return {
    ["start"] = function(_, p2) --[[ Name: start, Line 4 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        if _G.checkRenderDistance(p2.Position) ~= false then
            local v3 = u1:Clone()
            v3.CFrame = p2.CFrame
            v3.Parent = workspace.Effects
            for _, v4 in v3:GetDescendants() do
                if v4:IsA("ParticleEmitter") then
                    _G.customEmit(v4)
                end
            end
            _G.destroy(v3, 1.2)
        end
    end
}