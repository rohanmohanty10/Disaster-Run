 

local v1 = {}
local _ = workspace.Effects
local _ = game["Run Service"]
game:GetService("TweenService")
function v1.start(_, u2, u3, u4, p5) --[[ Line: 6 ]]
    local u6 = game:GetService("TweenService")
    local v7 = game:GetService("RunService")
    local u8 = u2:GetScale()
    local v9 = 0
    local u10 = 0
    if u3 and (typeof(u3) == "table" and u3.serverStartTime ~= nil) then
        local v11 = workspace:GetServerTimeNow() - u3.serverStartTime
        u3.Time = u3.Time - v11
    end
    local u12 = p5 and (p5.ClientPlayer and p5.ClientPlayer ~= game.Players.LocalPlayer) and 0.1 or v9
    local u13 = 0
    local u14 = 0
    local u15 = nil
    local function v19(p16) --[[ Line: 31 ]]
        --[[
        Upvalues:
            [1] = u13
            [2] = u3
            [3] = u6
            [4] = u14
            [5] = u8
            [6] = u4
            [7] = u10
            [8] = u12
            [9] = u2
            [10] = u15
        --]]
        local v17 = u13 + p16
        local v18 = u3.Time
        u13 = math.min(v17, v18)
        u14 = u8 + u6:GetValue(u13 / u3.Time, u3.EasingStyle, u3.EasingDirection) * (u4 - u8)
        if u12 <= tick() - u10 or u13 >= u3.Time then
            u10 = tick()
            u2:ScaleTo(u14)
        end
        if u13 >= u3.Time then
            u15:Disconnect()
            u15 = nil
        end
    end
    u15 = v7.Heartbeat:Connect(v19)
end
return v1