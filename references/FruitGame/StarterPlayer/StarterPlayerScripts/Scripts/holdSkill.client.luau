 

repeat
    task.wait()
until game.Players.LocalPlayer ~= nil
local _ = game.Players.LocalPlayer
local u1 = game:GetService("UserInputService")
local u2 = false
local u3 = true
function _G.holdSkill(p4, p5, p6, p7) --[[ Line: 10 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u3
        [3] = u1
    --]]
    if u2 == true then
        warn("already holding soemthing")
        return
    end
    local v8 = game.Players.LocalPlayer.Character
    local v9 = tick()
    local v10 = tick()
    local v11 = false
    if p7 == nil then
        p7 = 0
    end
    while true do
        _G.canuse = false
        u2 = true
        if p5 then
            local v12, v13 = pcall(p5)
            if v12 == false and v13 then
                warn("ERRROR: " .. v13)
            end
        end
        if u3 == false then
            warn("focus false brerak")
            break
        end
        if v8 and v8:FindFirstChild("campfireResting") then
            warn("cant fire resting")
            break
        end
        if v8 ~= game.Players.LocalPlayer.Character then
            warn("in efect folder beka")
            break
        end
        if v8.Parent == workspace.Effects then
            break
        end
        game["Run Service"].Heartbeat:Wait()
        if tick() - v9 >= 3 then
            local v14 = game.Players.LocalPlayer
            local v15 = (tick() - v9) * 1000
            local v16 = math.floor(v15) / 1000
            v14:Kick("game froze too long, rejoin. froze for " .. tostring(v16))
            v11 = true
            break
        end
        v9 = tick()
        if (u1:IsKeyDown(p4) == false or p6() == true) and p7 <= tick() - v10 then
            break
        end
    end
    u2 = false
    if v11 == true then
        while true do
            task.wait(1)
        end
    else
        return
    end
end
local u17 = {}
u1.WindowFocused:Connect(function() --[[ Line: 123 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    u3 = true
end)
u1.WindowFocusReleased:Connect(function() --[[ Line: 127 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    u3 = false
end)
game.Players.LocalPlayer.CharacterAdded:Connect(function() --[[ Line: 131 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u17
    --]]
    u2 = false
    for _, v18 in pairs(u17) do
        if v18.UI then
            v18.UI:Destroy()
        end
        v18.uiUpdateCnt:Disconnect()
    end
    table.clear(u17)
end)