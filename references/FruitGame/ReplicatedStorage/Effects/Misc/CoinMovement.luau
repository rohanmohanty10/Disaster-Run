 

game:GetService("TweenService")
local u1 = {}
u1.__index = u1
function u1.new(p2, p3) --[[ Line: 6 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v4 = u1
    local v5 = setmetatable({}, v4)
    v5.Duration = p2.Duration * (math.random(75, 100) / 100)
    v5.Elapsed = 0
    v5.SpinModifier = Random.new():NextNumber(5, 10)
    v5.TrackingPart = p2.Track
    v5.Position = p2.Position
    v5.Model = v5:_createModel()
    v5.totalData = p3
    v5:_main()
    return v5
end
function u1._createModel(p6) --[[ Line: 21 ]]
    local v7 = script.Coin:Clone()
    v7.CFrame = CFrame.Angles(1.5707963267948966, 0, 0) + p6.Position
    v7.Parent = workspace.Effects
    return v7
end
function u1._main(u8) --[[ Line: 29 ]]
    local u9 = u8.Position
    local u10 = u8.TrackingPart.Position
    local u11 = u9 + Random.new():NextUnitVector() * 15
    local u12 = u8.Model.Size * (math.random(90, 110) / 100)
    task.spawn(function() --[[ Line: 36 ]]
        --[[
        Upvalues:
            [1] = u8
            [2] = u10
            [3] = u9
            [4] = u11
            [5] = u12
        --]]
        while u8.Model do
            local v13 = task.wait()
            local v14 = u8
            v14.Elapsed = v14.Elapsed + v13
            local v15 = u8.Elapsed / u8.Duration
            if v15 >= 1 or not u8.TrackingPart then
                local v16 = u8.totalData
                v16.PickedUp = v16.PickedUp + 1
                _G.PlaySound(u8.Model.CFrame, script.CoinPickup, {
                    ["Pitch"] = 0.9 + u8.totalData.PickedUp / 10
                })
                u8:Destroy()
                return
            end
            u10 = u8.TrackingPart.Position
            local v17 = u9:Lerp(u11, v15):Lerp(u11:Lerp(u10, v15), v15)
            u8.Model.CFrame = CFrame.Angles(1.5707963267948966, 0, u8.Elapsed * u8.SpinModifier) + v17
            u8.Model.Size = u12 * (1 - v15 * 0.75)
            local v18 = u8.Model.shader
            local v19 = u8.Model.Size.X * 1.2
            local v20 = u8.Model.Size.Y - 0.1
            local v21 = u8.Model.Size.Z * 1.2
            v18.Size = Vector3.new(v19, v20, v21)
            local v22 = u8.Model.Size.X / 10
            u8.Model.Attachment1.Position = Vector3.new(0, v22, 0)
            local v23 = u8.Model.Attachment2
            local v24 = -v22
            v23.Position = Vector3.new(0, v24, 0)
        end
    end)
end
function u1.Destroy(p25) --[[ Line: 66 ]]
    p25.Model:Destroy()
    p25.Model = nil
    setmetatable(p25, nil)
end
function u1.start(_, p26) --[[ Line: 73 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local u27 = {
        ["PickedUp"] = 0
    }
    for _ = 1, p26.Count do
        u1.new(p26, u27)
        task.wait(0.05 + math.random(50, 200) / 10000)
    end
    task.delay(p26.Duration + 1, function() --[[ Line: 79 ]]
        --[[
        Upvalues:
            [1] = u27
        --]]
        table.clear(u27)
        u27 = nil
    end)
end
return u1