 

local v1 = {}
game:GetService("TweenService")
local u2 = game:GetService("RunService")
local function u4(p3) --[[ Line: 6 ]]
    return p3 == "Common" and ColorSequence.new(Color3.new(1, 1, 1)) or p3 == "Uncommon" and ColorSequence.new(Color3.new(0.231373, 1, 0.113725)) or (p3 == "Rare" and ColorSequence.new(Color3.new(0.113725, 0.690196, 1)) or (p3 == "Legendary" and ColorSequence.new(Color3.new(1, 0.67451, 0.0196078)) or nil))
end
function v1.start(_, u5) --[[ Line: 18 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u2
    --]]
    local u6 = script.SpawnChest:Clone()
    u6.Position = u5.Position
    u6.Parent = workspace.Effects
    for _, v7 in pairs(u6:GetDescendants()) do
        if v7:IsA("ParticleEmitter") then
            v7.Color = u4(u5.Rarity) or v7.Color
            _G.customEmit(v7)
        end
    end
    local u8 = {}
    task.spawn(function() --[[ Line: 32 ]]
        --[[
        Upvalues:
            [1] = u6
            [2] = u4
            [3] = u5
            [4] = u8
        --]]
        for _ = 1, math.random(4) do
            local u9 = script.Trail:Clone()
            u9.Position = u6.Position
            u9.Trail.Color = u4(u5.Rarity) or u9.Trail.Color
            u9.Parent = workspace.Effects
            local u10 = 0
            local u11 = Random.new():NextNumber(0.75, 3)
            local u12 = math.random() * 3.141592653589793
            local u13 = Random.new():NextNumber(3, 5)
            local u14 = 0
            local u15 = Random.new():NextNumber(5, 10)
            local u26 = {
                ["Finished"] = false,
                ["Update"] = function(_, p16) --[[ Line: 47 ]]
                    --[[
                    Upvalues:
                        [1] = u10
                        [2] = u11
                        [3] = u26
                        [4] = u9
                        [5] = u12
                        [6] = u13
                        [7] = u6
                        [8] = u14
                        [9] = u15
                    --]]
                    local v17 = u10 / u11
                    local v18 = math.clamp(v17, 0, 1)
                    if v18 == 1 then
                        u26.Finished = true
                        _G.destroy(u9, 2)
                    else
                        local v19 = u10 * 3.141592653589793 * u12
                        local v20 = u13 * (1 - v18) * 0.5
                        local v21 = u9
                        local v22 = u6.Position
                        local v23 = math.sin(v19) * v20
                        local v24 = u14
                        local v25 = math.cos(v19) * v20
                        v21.Position = v22 + Vector3.new(v23, v24, v25)
                        u10 = u10 + p16
                        u14 = u14 + p16 * (1 - v18) * u15
                    end
                end
            }
            local v27 = u8
            table.insert(v27, u26)
            task.wait(Random.new():NextNumber(0.1, 0.25))
        end
    end)
    local u28 = false
    task.delay(2, function() --[[ Line: 71 ]]
        --[[
        Upvalues:
            [1] = u28
        --]]
        u28 = true
    end)
    local u29 = nil
    u29 = u2.Heartbeat:Connect(function(p30) --[[ Line: 76 ]]
        --[[
        Upvalues:
            [1] = u8
            [2] = u28
            [3] = u29
        --]]
        for v31 = #u8, 1, -1 do
            if u8[v31].Finished then
                table.remove(u8, v31)
            else
                u8[v31]:Update(p30)
            end
        end
        if u28 and #u8 == 0 then
            u29:Disconnect()
        end
    end)
end
return v1