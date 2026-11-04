 

game:GetService("RunService")
game:GetService("TweenService")
return {
    ["start"] = function(_, p1) --[[ Name: start, Line 6 ]]
        Random.new()
        if p1 == nil then
            return
        elseif _G.checkRenderDistance(p1.PrimaryPart.Position) ~= false then
            local u2 = {}
            local v3 = p1:GetDescendants()
            local function v9(p4) --[[ Line: 16 ]]
                --[[
                Upvalues:
                    [1] = u2
                --]]
                local v5 = script.fullUntransParticles:GetChildren()
                for v6 = 1, #v5 do
                    local v7 = v5[v6]:Clone()
                    v7.Parent = p4
                    local v8 = u2
                    table.insert(v8, v7)
                end
            end
            for v10 = 1, #v3 do
                if v3[v10]:IsA("Bone") then
                    v9(v3[v10])
                end
            end
            for v11 = 1, #u2 do
                _G.customEmit(u2[v11])
                _G.destroy(u2[v11], 3)
            end
        end
    end
}