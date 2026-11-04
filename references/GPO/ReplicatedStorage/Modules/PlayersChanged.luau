 

local u1 = {}
local u2 = {}
local u3 = {}
local u4 = {}
function u1.AddRemove(_, p5) --[[ Line: 6 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v6 = u2
    table.insert(v6, p5)
end
function u1.AddJoin(_, u7) --[[ Line: 10 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u4
    --]]
    task.spawn(function() --[[ Line: 11 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u7
            [3] = u4
        --]]
        local v8 = u3
        local v9 = u7
        table.insert(v8, v9)
        local v10 = game.Players:GetPlayers()
        for v11 = 1, #v10 do
            local v12 = v10[v11]
            if u4[v12] == nil then
                u4[v12] = {}
            end
            if not u4[v12][u7] then
                u4[v12][u7] = true
                task.spawn(u7, v10[v11])
            end
        end
    end)
end
game.Players.PlayerRemoving:Connect(function(u13) --[[ Line: 29 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u2
    --]]
    local _ = u13.Character
    u4[u13] = nil
    for u14 = 1, #u2 do
        task.spawn(function() --[[ Line: 33 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u14
                [3] = u13
            --]]
            u2[u14](u13)
        end)
    end
    task.wait(3)
end)
game.Players.PlayerAdded:Connect(function(u15) --[[ Line: 45 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u4
    --]]
    for u16 = 1, #u3 do
        task.spawn(function() --[[ Line: 48 ]]
            --[[
            Upvalues:
                [1] = u4
                [2] = u15
                [3] = u3
                [4] = u16
            --]]
            if u4[u15] == nil then
                u4[u15] = {}
            end
            if u4[u15][u3[u16]] == nil then
                u4[u15][u3[u16]] = true
                u3[u16](u15)
            end
        end)
    end
end)
function _G.addPlayerJoinFunction(p17) --[[ Line: 61 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    u1:AddJoin(p17)
end
function _G.addPlayerRemoveFunction(p18) --[[ Line: 65 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    u1:AddRemove(p18)
end
return u1