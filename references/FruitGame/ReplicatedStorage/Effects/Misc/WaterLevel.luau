 

local v1 = {}
local u2 = {}
function v1.start(_, p3, p4, p5) --[[ Line: 4 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v6 = _G.awaitObject(p3)
    if v6 == nil then
        return
    elseif _G.checkRenderDistance(v6.Position) then
        p5.obj = v6
        local v7 = u2
        table.insert(v7, { v6, p4, p5 })
    end
end
local u8 = workspace.Env.WaterStuff.Ocean.Position.Y
task.spawn(function() --[[ Line: 18 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u8
    --]]
    game["Run Service"].Heartbeat:Connect(function() --[[ Line: 19 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u8
        --]]
        for v9 = #u2, 1, -1 do
            if u2[v9] == nil or (u2[v9][1] == nil or u2[v9][1].Parent == nil) then
                table.remove(u2, v9)
            else
                local v10 = u2[v9][1]
                local u11 = u2[v9][2]
                local u12 = u2[v9][3]
                local v13 = u12.remote
                local v14 = v10.Position.Y
                if v14 <= u8 and workspace.Env.WaterStuff.Sand.Position.Y - 10 < v14 then
                    local v15, _, v16, v17, v18, v19, v20, v21, v22, v23, v24, v25 = v10.CFrame:components()
                    v10.CFrame = CFrame.new(v15, u8, v16, v17, v18, v19, v20, v21, v22, v23, v24, v25)
                    v13:FireServer("splash", v10.CFrame)
                    task.spawn(function() --[[ Line: 32 ]]
                        --[[
                        Upvalues:
                            [1] = u11
                            [2] = u12
                        --]]
                        if u11 and game.ReplicatedStorage.ClientImpacts:FindFirstChild(u11) then
                            _G.clientimpacts[game.ReplicatedStorage.ClientImpacts:FindFirstChild(u11)]:start(u12)
                        end
                    end)
                    table.clear(u2[v9])
                    table.remove(u2, v9)
                end
            end
        end
    end)
end)
return v1