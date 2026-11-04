 

local u1, _, _, _, u2 = require(game.ReplicatedStorage.Modules.ScriptSet).get()
local _ = require(game.ReplicatedStorage.Util.WaterLogia.rougelineage)
local u3 = {}
local u4 = {}
task.wait(1)
game.ReplicatedStorage:WaitForChild("Stats" .. u1.Name)
local v5 = game.Players:GetPlayers()
local function u8(p6) --[[ Line: 9 ]]
    local v7 = game.ReplicatedStorage:FindFirstChild("Stats" .. p6.Name)
    if v7 and (v7:FindFirstChild("Stats") and v7.Stats:FindFirstChild("DF")) then
        return game.ReplicatedStorage.Util.WaterLogia:FindFirstChild(v7.Stats.DF.Value) ~= nil
    else
        return false
    end
end
local function v11(p9) --[[ Line: 24 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u4
    --]]
    if u3[p9] then
        u3[p9] = nil
        local v10 = table.find(u4, p9)
        if v10 then
            table.remove(u4, v10)
        end
    end
end
for v12 = 1, #v5 do
    local v13 = v5[v12]
    if not u3[v13] and u8(v13) then
        u3[v13] = true
        table.insert(u4, v13)
    end
end
game.Players.PlayerAdded:Connect(function(u14) --[[ Line: 41 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u8
        [3] = u4
    --]]
    task.delay(2, function() --[[ Line: 43 ]]
        --[[
        Upvalues:
            [1] = u14
            [2] = u3
            [3] = u8
            [4] = u4
        --]]
        local v15 = u14
        if not u3[v15] and u8(v15) then
            u3[v15] = true
            local v16 = u4
            table.insert(v16, v15)
        end
    end)
end)
game.Players.PlayerRemoving:Connect(v11)
local v17 = game.ReplicatedStorage.Util.WaterLogia:GetChildren()
local u18 = {}
for v19 = 1, #v17 do
    if v17[v19].Name:match("-") then
        u18[v17[v19].Name] = require(v17[v19])
    end
end
local u20 = workspace.Env.WaterStuff.Falls.Position.Y
local u21 = workspace.Env.WaterStuff.Sand.Position.Y
local u22 = 0
if not game.ReplicatedStorage:FindFirstChild("raidMode") and _G.isCustomHUB ~= true then
    local u23 = game.Players.LocalPlayer.Character
    u2.Stats.DF.Changed:Connect(function() --[[ Line: 73 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u8
            [3] = u4
        --]]
        local v24 = game.Players.LocalPlayer
        if not u3[v24] and u8(v24) then
            u3[v24] = true
            local v25 = u4
            table.insert(v25, v24)
        end
    end)
    workspace.PlayerCharacters.ChildAdded:Connect(function(u26) --[[ Line: 78 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u8
            [3] = u4
        --]]
        task.delay(1, function() --[[ Line: 79 ]]
            --[[
            Upvalues:
                [1] = u26
                [2] = u3
                [3] = u8
                [4] = u4
            --]]
            local v27 = game.Players:GetPlayerFromCharacter(u26)
            if v27 and (not u3[v27] and u8(v27)) then
                u3[v27] = true
                local v28 = u4
                table.insert(v28, v27)
            end
        end)
    end)
    local u29 = RaycastParams.new()
    u29.FilterDescendantsInstances = {
        workspace.Effects,
        workspace.Env.FruitFloors,
        workspace.CurrentCamera,
        workspace.NPCs,
        workspace.PlayerCharacters
    }
    u29.FilterType = Enum.RaycastFilterType.Exclude
    u29.CollisionGroup = "Default"
    local u30 = nil
    u30 = game["Run Service"].Heartbeat:Connect(function() --[[ Line: 94 ]]
        --[[
        Upvalues:
            [1] = u23
            [2] = u1
            [3] = u2
            [4] = u21
            [5] = u20
            [6] = u22
            [7] = u30
            [8] = u4
            [9] = u3
            [10] = u29
            [11] = u18
        --]]
        local v31 = u23:FindFirstChild("HumanoidRootPart")
        if v31 and (_G.playerFruitPassiveEnabled and (_G.playerFruitPassiveEnabled(u1) == true and u2.Settings.Logia.Value == true)) then
            local v32 = v31.Position.Y
            if u21 - 5 < v32 and (v32 < u20 + 15 and (u23.Parent == workspace.PlayerCharacters and (v32 < u20 and (u20 - 10 < v32 and game.ReplicatedStorage.Util.WaterLogia:FindFirstChild(u2.Stats.DF.Value))))) then
                local v33 = (v31.Position - Vector3.new(1837.977, 2.691, -12196.688)).Magnitude >= 25 or u23:FindFirstChild("coatBubble") == nil
                if u23:FindFirstChild("inCombat") and u23.Humanoid:GetAttribute("isRagdolled") == true then
                    v33 = false
                end
                if v33 == true then
                    local v34, _, v35, v36, v37, v38, v39, v40, v41, v42, v43, v44 = v31.CFrame:components()
                    v31.Velocity = Vector3.new()
                    v31.CFrame = CFrame.new(v34, u20 + u23.Humanoid.HipHeight * 2.25, v35, v36, v37, v38, v39, v40, v41, v42, v43, v44)
                end
            end
        end
        if tick() - u22 <= 0.1 then
            return
        else
            u22 = tick()
            if workspace:GetAttribute("DisableFruitFloors") then
                u30:Disconnect()
                u30 = nil
            else
                for v45 = #u4, 1, -1 do
                    local v46 = u4[v45]
                    if v46 == nil or v46.Parent ~= game.Players then
                        if u3[v46] then
                            u3[v46] = nil
                            local v47 = table.find(u4, v46)
                            if v47 then
                                table.remove(u4, v47)
                            end
                        end
                    else
                        local v48 = v46.Character
                        if v48 and v48.Parent ~= nil then
                            local v49 = v48:FindFirstChild("HumanoidRootPart")
                            if v49 and (_G.checkRenderDistance ~= nil and _G.checkRenderDistance(v49.Position)) then
                                local v50 = game.ReplicatedStorage:FindFirstChild("Stats" .. v46.Name)
                                if v50 then
                                    local v51 = v50.Stats.DF.Value
                                    if game.ReplicatedStorage.Util.WaterLogia:FindFirstChild(v51) then
                                        if _G.playerFruitPassiveEnabled(v46) ~= false and v50.Settings.Logia.Value ~= false then
                                            local v52 = v49.Position.Y
                                            if v52 >= u20 and u20 + 10 > v52 then
                                                local v53 = v48:FindFirstChild("Humanoid")
                                                if v53 and (v53.SeatPart == nil or v53.SeatPart.Parent and v53.SeatPart.Parent:FindFirstChild("Owner")) and ((not v48:FindFirstChild("Rag") or v48.Rag.Value == nil) and (((v49.Position - Vector3.new(1837.977, 2.691, -12196.688)).Magnitude >= 25 or v48:FindFirstChild("coatBubble") == nil) and (v48.Parent ~= workspace.Ragdolls or not v48:FindFirstChild("inCombat")))) then
                                                    local v54 = v49.Position
                                                    local v55 = workspace:Raycast(v54, Vector3.new(0, -15, 0), u29)
                                                    local v56 = nil
                                                    local v57
                                                    if v55 then
                                                        v56 = v55.Instance
                                                        v57 = v55.Position
                                                    else
                                                        local v58 = v54.X
                                                        local v59 = u20
                                                        local v60 = v54.Z
                                                        v57 = Vector3.new(v58, v59, v60)
                                                    end
                                                    if v55 == nil or (v56 == nil or v57.Y <= u20) and u20 <= v54.Y then
                                                        u18[v51]:start(v46, CFrame.new(v57))
                                                    end
                                                end
                                            end
                                        end
                                    elseif u3[v46] then
                                        u3[v46] = nil
                                        local v61 = table.find(u4, v46)
                                        if v61 then
                                            table.remove(u4, v61)
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end)
end