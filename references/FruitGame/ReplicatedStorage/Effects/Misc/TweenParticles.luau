 

return {
    ["start"] = function(_, p1, p2, p3) --[[ Name: start, Line 3 ]]
        if p1 ~= nil then
            local v4 = p1:GetDescendants()
            local v5 = { p1 }
            for v6 = 1, #v4 do
                if v4[v6]:IsA("ParticleEmitter") then
                    local v7 = v4[v6]
                    table.insert(v5, v7)
                end
            end
            for v8 = 1, #v5 do
                if v5[v8]:IsA("ParticleEmitter") then
                    _G.tween(v5[v8], {
                        p3,
                        Enum.EasingStyle.Quad,
                        Enum.EasingDirection.Out,
                        0,
                        false,
                        0
                    }, {
                        ["Size"] = p2
                    })
                end
            end
        end
    end
}