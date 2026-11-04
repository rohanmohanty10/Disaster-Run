 

local v1 = {}
function recu(p2, p3, p4)
    local v5 = p2:GetChildren()
    if #v5 ~= 0 then
        v5[1].CFrame = p3 * CFrame.Angles(p4, 0, 0)
        recu(v5[1], p3, p4 - 0.07)
    end
end
require(game:GetService("ReplicatedStorage").Modules.sBeat)
require(game:GetService("ReplicatedStorage"):WaitForChild("Modules").swoopz)
function v1.start(_, p6, p7, p8, p9) --[[ Line: 24 ]]
    if _G.checkRenderDistance(p6.HumanoidRootPart.Position) then
        local v10 = Random.new()
        local u11 = {
            ["outTime"] = 0.57,
            ["lashAmount"] = 7,
            ["lashRad"] = -0.25,
            ["lashSize"] = Vector3.new(1.15, 15, 1.4),
            ["lashLength"] = 0.5,
            ["lashLengthRange"] = 0.15,
            ["lashOffset"] = 5,
            ["lashColor"] = p8
        }
        u11.totalTime = u11.outTime
        u11.orig_cf = p7
        local v12 = script.krakenbouquet:Clone()
        v12.root.CFrame = u11.orig_cf
        v12.root.Color = u11.lashColor
        local u13 = {}
        for v14 = 1, u11.lashAmount do
            local v15 = script.Tentacle:Clone()
            local v16 = v10:NextNumber(-3.14, 3.14)
            local v17 = v10:NextNumber(-2.5, 2.5)
            v15.CFrame = u11.orig_cf * CFrame.Angles(0, v16, 0) + Vector3.new(v17, -2.5, v17)
            local v18 = u11.lashSize.Y
            local v19 = Vector3.new(0, v18, 0)
            local v20 = u11.lashSize.X
            local v21 = u11.lashSize.Z
            v15.Size = v19 + Vector3.new(v20, 0, v21) * (v14 / u11.lashAmount + 1)
            v15.Color = v12.root.Color:lerp(u11.lashColor, v14 / u11.lashAmount)
            v15.Parent = v12
            table.insert(u13, v15)
        end
        v12.Parent = workspace.Effects
        _G.customEmit(v12.root)
        v12.root.Wave:Emit(6)
        _G.destroy(v12, 4)
        spawn(function() --[[ Line: 83 ]]
            --[[
            Upvalues:
                [1] = u11
                [2] = u13
            --]]
            local v22 = u11.outTime * 60
            local v23 = math.ceil(v22)
            local v24 = 1 / v23
            for v25 = 1, v23 do
                local v26 = v25 * v24 - 1
                local v27 = 1 - v26 * v26
                local v28 = math.sqrt(v27)
                for v29, v30 in u13 do
                    local v31 = u11.lashLength + u11.lashLengthRange * v29
                    recu(v30.Tentecle, CFrame.new(0, v31 * v28, 0) * CFrame.Angles(-u11.lashRad * v28, 0, 0), 0)
                end
                task.wait()
            end
        end)
        task.wait(p9)
        _G.PlayEffect("KraSwoBouquetCut", nil, p6, v12)
    end
end
return v1