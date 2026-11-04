 

local v1 = {}
function recu(p2, p3, p4)
    local v5 = p2:GetChildren()
    if #v5 ~= 0 then
        v5[1].CFrame = p3
        recu(v5[1], p3, p4)
    end
end
require(game:GetService("ReplicatedStorage").Modules.sBeat)
local u6 = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules").swoopz)
function v1.start(_, p7, p8, p9, p10) --[[ Line: 24 ]]
    --[[
    Upvalues:
        [1] = u6
    --]]
    if _G.checkRenderDistance(p7.HumanoidRootPart.Position) then
        local v11 = Random.new()
        local v12 = v11:NextNumber(-p9, p9) * 0.6
        local u13 = {
            ["inTime"] = 0.25,
            ["outTime"] = 0.3,
            ["cfOffset"] = CFrame.new(v12, 0, v12),
            ["lashRad"] = 1.4,
            ["lashSize"] = Vector3.new(1.65, 10, 2.9),
            ["lashLength"] = p9 * 0.2,
            ["lashColor"] = p10
        }
        local v14 = v11:NextNumber(-3.14, 3.14)
        u13.totalTime = u13.inTime + u13.outTime
        u13.orig_cf = p8 * u13.cfOffset * CFrame.Angles(v11:NextNumber(-0.8, 0.8), v14, v11:NextNumber(-0.8, 0.8)) + Vector3.new(0, -2.5, 0)
        local u15 = script.Tentacle:Clone()
        u15.CFrame = u13.orig_cf
        u15.Color = u13.lashColor
        u15.Parent = workspace.Effects
        task.spawn(function() --[[ Line: 49 ]]
            --[[
            Upvalues:
                [1] = u15
                [2] = u6
            --]]
            for v16 = 2, 4.14, 2.145 do
                local v17 = script.Swoosh:Clone()
                v17.CFrame = u15.CFrame * CFrame.new(0, v16, 0) * CFrame.Angles(v16, 0, v16)
                v17.Parent = u15
                u6.Do("thswir", v17)
                task.wait(0.05)
            end
        end)
        _G.destroy(u15, u13.totalTime + 0.2)
        task.spawn(function() --[[ Line: 65 ]]
            --[[
            Upvalues:
                [1] = u13
                [2] = u15
            --]]
            local v18 = u13.inTime * 60
            local v19 = math.ceil(v18)
            local v20 = u13.outTime * 60
            local v21 = math.ceil(v20)
            local v22 = 1 / v19
            local v23 = 1 / v21
            for v24 = 1, v19 do
                if u15:FindFirstChild("Tentecle") == nil then
                    break
                end
                local v25 = (v24 - 1) * v22
                recu(u15.Tentecle, CFrame.new(0, u13.lashLength * v25, 0) * CFrame.Angles(u13.lashRad - u13.lashRad * v25, 0, 0))
                task.wait()
            end
            for v26 = 1, v21 * 0.5 do
                if u15:FindFirstChild("Tentecle") == nil then
                    break
                end
                local v27 = 1 - v26 * v23
                recu(u15.Tentecle, CFrame.new(0, u13.lashLength * v27, 0) * CFrame.Angles(-u13.lashRad * (1 - v27), 0, 0))
                task.wait()
            end
        end)
    end
end
return v1