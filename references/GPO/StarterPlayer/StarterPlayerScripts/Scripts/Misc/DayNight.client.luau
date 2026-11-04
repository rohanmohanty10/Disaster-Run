 

repeat
    task.wait(1)
until game.ReplicatedStorage.reservedCode.Value ~= "checking" and game.Lighting:GetAttribute("Ready") == true
require(script.Day)
require(script.Night)
local u1 = game:GetService("Lighting")
local u2 = game:GetService("CollectionService"):GetTagged("nightWindow")
local u3 = {}
local u4 = false
for v5 = 1, #u2 do
    local v6 = u2[v5]
    u3[v6] = {
        ["color"] = v6.Color,
        ["mat"] = v6.Material
    }
end
local function u13(_) --[[ Line: 25 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u4
        [3] = u2
        [4] = u3
    --]]
    u1:GetMinutesAfterMidnight()
    if game.Lighting:FindFirstChild("Atmosphere") then
        local v7 = game.Lighting.ClockTime
        if game.Lighting.ClockTime >= 7 and game.Lighting.ClockTime < 18 then
            local _ = (8 - (12 - v7)) / 8
            if u4 == true then
                u4 = false
                local v8 = u2
                for v9 = 1, #v8 do
                    local v10 = v8[v9]
                    if v10 and u3[v10] ~= nil then
                        v8[v9].Material = u3[v10].mat
                        v8[v9].Color = u3[v10].color
                    end
                end
                return
            end
        elseif game.Lighting.ClockTime >= 13 then
            local _ = (5 - (23 - v7)) / 5
            if u4 == false then
                u4 = true
                local v11 = u2
                for v12 = 1, #v11 do
                    v11[v12].Material = Enum.Material.Neon
                    v11[v12].Color = Color3.fromRGB(162, 108, 81)
                end
            end
        end
    end
end
if game["Run Service"]:IsStudio() == false then
    game.ReplicatedFirst.StartTime:Destroy()
end
if game.Lighting:GetAttribute("AlwaysDay") == true then
    u13(game.Lighting:GetAttribute("setTime"))
else
    local u14 = 0
    game:GetService("RunService").Heartbeat:Connect(function() --[[ Line: 91 ]]
        --[[
        Upvalues:
            [1] = u14
            [2] = u13
        --]]
        if tick() - u14 >= 1 then
            workspace:GetServerTimeNow()
            u13()
            u14 = tick()
        end
    end)
end