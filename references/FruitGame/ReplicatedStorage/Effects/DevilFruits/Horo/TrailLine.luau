 

return {
    ["start"] = function(_, p1, p2, u3, p4) --[[ Name: start, Line 4 ]]
        if _G.checkRenderDistance(p1.Position) ~= false then
            local v5 = p2 * 100
            for _ = 1, p4 do
                local v6 = math.random(-v5, v5) / 100
                local v7 = math.random(-v5, v5) / 100
                local v8 = Vector3.new(v6, 0, v7)
                local u9 = Instance.new("Attachment")
                u9.Position = v8
                u9.Parent = p1
                local u10 = Instance.new("Attachment")
                u10.Position = v8 + Vector3.new(0, 0, 0.1)
                u10.Parent = p1
                local u11 = script.Trail:Clone()
                u11.Parent = p1
                task.spawn(function() --[[ Line: 19 ]]
                    --[[
                    Upvalues:
                        [1] = u3
                        [2] = u11
                        [3] = u9
                        [4] = u10
                    --]]
                    task.wait(u3)
                    u11.Enabled = false
                    local v12 = { u9, u10, u11 }
                    _G.destroy(v12, 0.25)
                end)
            end
        end
    end
}