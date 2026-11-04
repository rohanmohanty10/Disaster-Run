 

local v1 = {}
function recurse_bones(p2, p3)
    for _, v4 in p2:GetChildren() do
        local v5 = v4:GetAttribute("OrigPos")
        if v5 then
            v4.CFrame = CFrame.new(v5) * p3
            recurse_bones(v4, p3)
        end
    end
end
function add_length(p6, p7, p8)
    if p8 <= 4 then
        add_length(p6:FindFirstChildOfClass("Bone"), p7, p8 + 1)
        if p8 > 0 then
            p6.CFrame = p6.CFrame * CFrame.new(0, p7, 0)
        end
    end
end
function v1.start(_, u9) --[[ Line: 25 ]]
    if _G.checkRenderDistance(u9.WorldCFrame.Position) then
        task.spawn(function() --[[ Line: 38 ]]
            --[[
            Upvalues:
                [1] = u9
            --]]
            local v10 = game:GetService("RunService").Heartbeat
            local v11 = 0
            while v11 < 0.65 do
                local v12 = 1 - v11 * 1.5384615
                local v13 = v12 * v12
                recurse_bones(u9, CFrame.new(0, -v13 * 0.5, 0) * CFrame.Angles((1 - v13) * -0.06, 0, 0))
                v11 = v11 + v10:Wait()
            end
            local v14 = 0.45
            while v14 > 0 do
                local v15 = v14 * 2.22222
                local v16 = v15 * (2 - v15)
                recurse_bones(u9, CFrame.new(0, 0, 0) * CFrame.Angles(-0.06 + (1 - v16) * 0.2, 0, 0))
                add_length(u9, 1 - v16, 0)
                v14 = v14 - v10:Wait()
            end
            local v17 = 0.4
            while v17 > 0 do
                local v18 = v17 * 2.5
                recurse_bones(u9, CFrame.new(0, 0, 0) * CFrame.Angles(v18 * 0.14, 0, 0))
                add_length(u9, 1, 0)
                v17 = v17 - v10:Wait()
            end
        end)
    end
end
return v1