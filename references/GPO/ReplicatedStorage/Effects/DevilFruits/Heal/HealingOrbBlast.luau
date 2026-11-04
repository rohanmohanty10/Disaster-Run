 

local v1 = {}
function CubicBezier(p2, p3, p4, p5, p6)
    local v7 = (1 - p2) ^ 3 * p3 + 3 * (1 - p2) ^ 2 * p2 * p4 + 3 * (1 - p2) * p2 ^ 2 * p5 + p2 ^ 3 * p6
    local v8 = p2 + 0.006944444444444444
    local v9 = (1 - v8) ^ 3 * p3 + 3 * (1 - v8) ^ 2 * v8 * p4 + 3 * (1 - v8) * v8 ^ 2 * p5 + v8 ^ 3 * p6
    return CFrame.new(v7, v9)
end
local u10 = Random.new()
function v1.start(_, u11, u12) --[[ Line: 17 ]]
    --[[
    Upvalues:
        [1] = u10
    --]]
    if _G.checkRenderDistance(u11.Position) ~= false then
        local v13 = CFrame.new(u11.Position, u12.Position)
        local v14 = (u11.Position - u12.Position).Magnitude
        local u15 = (v13 * CFrame.new(u10:NextNumber(-12.5, 12.5), u10:NextNumber(2, 16), -v14 / 2.5)).Position
        local u16 = (v13 * CFrame.new(u10:NextNumber(-12.5, 12.5), u10:NextNumber(2, 16), -v14 / 1.75)).Position
        local u17 = script["Chiyu Orb"]:Clone()
        u17.Parent = workspace.Effects
        u17.CFrame = u11
        local u18 = nil
        local u19 = 0
        tick()
        local _ = v14 / 50
        u18 = game["Run Service"].Heartbeat:Connect(function(p20) --[[ Line: 32 ]]
            --[[
            Upvalues:
                [1] = u19
                [2] = u18
                [3] = u17
                [4] = u12
                [5] = u11
                [6] = u15
                [7] = u16
            --]]
            if u19 >= 1 then
                u18:Disconnect()
                u17:Destroy()
                local v21 = script.explosion:Clone()
                v21.CFrame = u12
                v21.Parent = workspace.Effects
                _G.customEmit(v21)
                _G.destroy(v21, 2)
            else
                u19 = u19 + p20
                u17.CFrame = CubicBezier(u19, u11.Position, u15, u16, u12.Position)
            end
        end)
    end
end
return v1