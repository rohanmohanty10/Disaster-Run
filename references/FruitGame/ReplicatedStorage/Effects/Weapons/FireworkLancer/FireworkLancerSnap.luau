 

local u1 = script.Snap
return {
    ["start"] = function(_, p2, p3) --[[ Name: start, Line 4 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        if _G.checkRenderDistance(p2.Position) == false then
            return
        elseif p3 == "Start" then
            local v4 = u1.Snap:Clone()
            v4.Parent = p2
            for _, v5 in v4:GetDescendants() do
                if v5:IsA("ParticleEmitter") then
                    v5.Enabled = true
                end
            end
            _G.destroy(v4, 3)
        else
            local v6 = p3 == "End" and p2:FindFirstChild(u1.Name)
            if v6 then
                for _, v7 in v6:GetDescendants() do
                    if v7:IsA("ParticleEmitter") then
                        v7.Enabled = false
                    end
                end
                task.wait(0.5)
                v6:Destroy()
            end
        end
    end
}