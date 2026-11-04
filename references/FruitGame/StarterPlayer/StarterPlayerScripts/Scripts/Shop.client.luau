 

repeat
    task.wait()
until workspace.Islands:GetAttribute("ready") == true and (workspace.BuyableItems:FindFirstChild("FirstSea") == nil and workspace.BuyableItems:FindFirstChild("SecondSea") == nil)
function _G.HasItem(p1, p2) --[[ Line: 5 ]]
    local v3 = game.ReplicatedStorage:FindFirstChild("Stats" .. p1.Name)
    local v4 = false
    for v5, _ in game:GetService("HttpService"):JSONDecode(v3.Inventory.Inventory.Value) do
        if v5 == p2 then
            return true
        end
    end
    return v4
end
function _G.CheckItemAmmount(p6, p7) --[[ Line: 18 ]]
    local v8 = game.ReplicatedStorage:FindFirstChild("Stats" .. p6.Name)
    local v9 = 0
    for v10, v11 in game:GetService("HttpService"):JSONDecode(v8.Inventory.Inventory.Value) do
        if v10 == p7 then
            v9 = v11
        end
    end
    return v9
end
local u12 = require(game.ReplicatedStorage.Modules.NPCInteractions)
workspace:WaitForChild("BuyableItems", 50)
local u13 = game.Players.LocalPlayer:GetMouse()
u13.Icon = "http://www.roblox.com/asset/?id=4776810280"
_G.normalCur = "http://www.roblox.com/asset/?id=4776810280"
local v14 = workspace.BuyableItems:GetChildren()
local u15 = {}
for v16 = 1, #v14 do
    local u17 = v14[v16]
    if u15[u17] ~= true then
        u15[u17] = true
        task.spawn(function() --[[ Line: 44 ]]
            --[[
            Upvalues:
                [1] = u17
                [2] = u12
            --]]
            repeat
                task.wait(1)
            until u17:GetModelSize() ~= Vector3.new()
            local v18 = script.Part:Clone()
            v18.Size = u17:GetModelSize()
            v18.CFrame = u17:GetModelCFrame()
            v18.Name = "ShopPart"
            v18.ClickDetector:Destroy()
            v18.Parent = u17
            local u19 = u17.Info.Seller.Value
            if u19 == nil then
                u19 = game.Players.LocalPlayer.Character
            end
            local v20 = script.ProximityPrompt:Clone()
            v20.MaxActivationDistance = 4 + v18.Size.Magnitude / 2
            v20.ActionText = "<font color=\"rgb(255, 255, 126)\">" .. u17.Info.Price.Value .. " Peli</font>"
            v20.ObjectText = u17.Name
            v20.HoldDuration = 0
            v20.Parent = v18
            v20.Triggered:Connect(function() --[[ Line: 66 ]]
                --[[
                Upvalues:
                    [1] = u17
                    [2] = u12
                    [3] = u19
                --]]
                local v21 = u17.Info:FindFirstChild("Amount")
                local v22 = u17.Info:FindFirstChild("Team")
                local v23
                if v21 then
                    v23 = v21.Value
                else
                    v23 = nil
                end
                local v24
                if v22 then
                    v24 = v22.Value
                else
                    v24 = nil
                end
                warn("trying to buy item " .. u17.Name)
                u12:startchat(u19, true, u17.Name, u17.Info.Price.Value, u17, v23, v24)
            end)
        end)
    end
end
workspace.BuyableItems.ChildAdded:Connect(function(u25) --[[ Line: 101 ]]
    --[[
    Upvalues:
        [1] = u15
        [2] = u12
    --]]
    if u15[u25] ~= true then
        u15[u25] = true
        task.spawn(function() --[[ Line: 44 ]]
            --[[
            Upvalues:
                [1] = u25
                [2] = u12
            --]]
            repeat
                task.wait(1)
            until u25:GetModelSize() ~= Vector3.new()
            local v26 = script.Part:Clone()
            v26.Size = u25:GetModelSize()
            v26.CFrame = u25:GetModelCFrame()
            v26.Name = "ShopPart"
            v26.ClickDetector:Destroy()
            v26.Parent = u25
            local u27 = u25.Info.Seller.Value
            if u27 == nil then
                u27 = game.Players.LocalPlayer.Character
            end
            local v28 = script.ProximityPrompt:Clone()
            v28.MaxActivationDistance = 4 + v26.Size.Magnitude / 2
            v28.ActionText = "<font color=\"rgb(255, 255, 126)\">" .. u25.Info.Price.Value .. " Peli</font>"
            v28.ObjectText = u25.Name
            v28.HoldDuration = 0
            v28.Parent = v26
            v28.Triggered:Connect(function() --[[ Line: 66 ]]
                --[[
                Upvalues:
                    [1] = u25
                    [2] = u12
                    [3] = u27
                --]]
                local v29 = u25.Info:FindFirstChild("Amount")
                local v30 = u25.Info:FindFirstChild("Team")
                local v31
                if v29 then
                    v31 = v29.Value
                else
                    v31 = nil
                end
                local v32
                if v30 then
                    v32 = v30.Value
                else
                    v32 = nil
                end
                warn("trying to buy item " .. u25.Name)
                u12:startchat(u27, true, u25.Name, u25.Info.Price.Value, u25, v31, v32)
            end)
        end)
    end
end)
local u33 = {
    ["Grab"] = "http://www.roblox.com/asset/?id=4826349103",
    ["Lock"] = "http://www.roblox.com/asset/?id=4826094125"
}
local u34 = {}
local u35 = {}
game.ReplicatedStorage.Events.ClickIcon.OnClientEvent:Connect(function(u36, u37) --[[ Line: 108 ]]
    --[[
    Upvalues:
        [1] = u34
        [2] = u13
        [3] = u33
        [4] = u35
    --]]
    if u36 == nil then
        return
    elseif _G.checkRenderDistance(u36.Parent.Position) ~= false then
        if u34[u36] then
            u34[u36][1]:Disconnect()
            u34[u36][2]:Disconnect()
            u34[u36] = nil
        end
        local v39 = u36.MouseHoverEnter:Connect(function() --[[ Line: 122 ]]
            --[[
            Upvalues:
                [1] = u36
                [2] = u13
                [3] = u33
                [4] = u37
            --]]
            local v38 = game.Players.LocalPlayer.Character
            if v38 == nil or (v38.HumanoidRootPart.Position - u36.Parent.Position).magnitude > u36.MaxActivationDistance then
                u13.Icon = "http://www.roblox.com/asset/?id=4776810280"
            else
                u13.Icon = u33[u37]
            end
        end)
        local v40 = u36.MouseHoverLeave:Connect(function() --[[ Line: 131 ]]
            --[[
            Upvalues:
                [1] = u13
            --]]
            u13.Icon = "http://www.roblox.com/asset/?id=4776810280"
        end)
        u34[u36] = { v39, v40 }
        local u41 = Instance.new("BindableEvent")
        u41.Parent = script
        u41.Name = "shopEvent"
        u35[u36] = { u36, u41 }
        local u42 = nil
        u42 = u36.Destroying:Connect(function() --[[ Line: 141 ]]
            --[[
            Upvalues:
                [1] = u35
                [2] = u36
                [3] = u41
                [4] = u42
            --]]
            if u35[u36] then
                u35[u36] = nil
                u41:Fire()
            end
            if u42 then
                u42:Disconnect()
                u42 = nil
            end
        end)
        u41.Event:Wait()
        u41:Destroy()
        u13.Icon = "http://www.roblox.com/asset/?id=4776810280"
        u34[u36] = nil
        v39:Disconnect()
        v40:Disconnect()
    end
end)
local v43 = workspace.Jails:GetDescendants()
for v44 = 1, #v43 do
    if v43[v44]:IsA("ClickDetector") then
        v43[v44].MouseHoverEnter:Connect(function() --[[ Line: 164 ]]
            --[[
            Upvalues:
                [1] = u13
            --]]
            u13.Icon = "http://www.roblox.com/asset/?id=4826349103"
        end)
        v43[v44].MouseHoverLeave:Connect(function() --[[ Line: 168 ]]
            --[[
            Upvalues:
                [1] = u13
            --]]
            u13.Icon = "http://www.roblox.com/asset/?id=4776810280"
        end)
    end
end
local u45 = {}
game:GetService("ProximityPromptService").PromptShown:Connect(function(p46) --[[ Line: 174 ]]
    --[[
    Upvalues:
        [1] = u45
    --]]
    if p46:GetAttribute("highlight") ~= nil then
        if (p46.Parent.Parent ~= nil and p46.Parent.Parent:IsA("Model") or p46.Parent:FindFirstChild("toolModel")) and u45[p46] == nil then
            if p46.Parent.Parent:FindFirstChild("highlightPrompt") then
                p46.Parent.Parent:FindFirstChild("highlightPrompt"):Destroy()
            end
            local v47 = Instance.new("Highlight")
            v47.FillColor = Color3.fromRGB(255, 255, 255)
            v47.OutlineColor = Color3.fromRGB(255, 255, 255)
            v47.FillTransparency = 0.5
            v47.OutlineTransparency = 0
            v47.Name = "highlightPrompt"
            v47.Parent = p46.Parent.Parent
            if p46.Parent:FindFirstChild("toolModel") then
                v47.Parent = p46.Parent:FindFirstChild("toolModel").Value
            end
            _G.tween(v47, {
                1,
                Enum.EasingStyle.Circular,
                Enum.EasingDirection.In,
                -1,
                true,
                0
            }, {
                ["FillTransparency"] = 1
            })
            u45[p46] = v47
        end
    end
end)
game:GetService("ProximityPromptService").PromptHidden:Connect(function(p48) --[[ Line: 200 ]]
    --[[
    Upvalues:
        [1] = u45
    --]]
    if u45[p48] ~= nil then
        local v49 = u45[p48]
        _G.tween(v49, {
            0.25,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["OutlineTransparency"] = 1,
            ["FillTransparency"] = 1
        }, nil, true)
        _G.destroy(v49, 0.25)
        u45[p48] = nil
    end
end)
local u50 = {}
local function u63(p51, p52, _, _, _) --[[ Line: 218 ]]
    local v53 = p51:GetScale()
    local v54 = (workspace.CurrentCamera.CFrame.Position - p51:GetPivot().Position).Magnitude
    if v54 < 30 then
        local v55 = 0
        local v56 = 0
        while v55 < p52 do
            local v57 = task.wait()
            local v58 = v55 + v57
            v55 = math.min(v58, p52)
            v56 = v56 + v57
            if v56 >= 0.011111111111111112 or p52 <= v55 then
                local v59 = v53 * (1 - v55 / p52)
                p51:ScaleTo((math.clamp(v59, 0.001, v53)))
                v56 = 0
            end
        end
    else
        local v60 = v54 < 80 and 4 or 2
        for v61 = 1, v60 do
            local v62 = v53 * (1 - v61 / v60)
            p51:ScaleTo((math.clamp(v62, 0.001, v53)))
            if v61 < v60 then
                task.wait(p52 / v60)
            end
        end
    end
end
game.ReplicatedStorage.spinDrop.OnClientEvent:Connect(function(p64, p65, p66) --[[ Line: 250 ]]
    --[[
    Upvalues:
        [1] = u63
        [2] = u50
    --]]
    if not _G.awaitObject then
        repeat
            task.wait()
        until _G.awaitObject ~= nil
    end
    local u67 = _G.awaitObject(p64)
    if typeof(u67) == "Instance" then
        if p65 == nil or (p65 ~= "newCFrame" or u67 == nil) then
            if p65 == nil then
                if u50[u67] then
                    return
                elseif u67 == nil then
                    return
                elseif not _G.checkRenderDistance or _G.checkRenderDistance(u67:GetPivot().Position, 100) ~= false then
                    local v68 = math.random(600, 1000)
                    if math.random(1, 2) == 1 then
                        v68 = v68 * -1
                    end
                    local v69 = v68 / 1000
                    local v70 = math.random(600, 1000)
                    if math.random(1, 2) == 1 then
                        v70 = v70 * -1
                    end
                    local v71 = v70 / 1000
                    local v72 = math.random(600, 1000)
                    if math.random(1, 2) == 1 then
                        v72 = v72 * -1
                    end
                    u50[u67] = {
                        v69,
                        v71,
                        v72 / 1000,
                        {
                            true,
                            tick(),
                            0,
                            0
                        }
                    }
                    u67.Destroying:Once(function() --[[ Line: 288 ]]
                        --[[
                        Upvalues:
                            [1] = u50
                            [2] = u67
                        --]]
                        u50[u67] = nil
                    end)
                end
            else
                u63(u67, 0.25, 0.001, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                return
            end
        else
            u67:PivotTo(p66)
            return
        end
    else
        return
    end
end)
game.ReplicatedStorage.Events.renderChest.OnClientEvent:Connect(function(p73) --[[ Line: 293 ]]
    if p73 == "pickUp" then
        script.pickupItem.Pitch = math.random(90, 110) / 100
        game.SoundService:PlayLocalSound(script.pickupItem)
    end
end)
local u74 = workspace.CurrentCamera
local u75 = game.ReplicatedStorage:FindFirstChild("stopspin") ~= nil
local u76 = tick()
game["Run Service"].Heartbeat:Connect(function(p77) --[[ Line: 304 ]]
    --[[
    Upvalues:
        [1] = u76
        [2] = u75
        [3] = u74
        [4] = u50
    --]]
    local v78 = tick()
    if v78 - u76 >= 5 then
        u76 = v78
        u75 = game.ReplicatedStorage:FindFirstChild("stopspin") ~= nil
    end
    if not u75 then
        local v79 = u74.CFrame.Position
        for v80, _ in u50 do
            if v80 then
                local v81 = u50[v80]
                local v82, v83, v84, v85 = unpack(v81)
                local v86 = v85[1]
                local v87 = v85[2]
                local v88 = v85[3] or 0
                local v89 = v85[4] or 0
                local v90
                if v78 - v87 >= 1 then
                    v90 = v80:GetPivot()
                    v86 = _G.checkRenderDistance(v90.Position, 50)
                    v89 = (v79 - v90.Position).Magnitude
                    v85[1] = v86
                    v85[2] = v78
                    v85[4] = v89
                else
                    v90 = nil
                end
                if v86 ~= false and (v89 < 80 and 0 or (v89 < 100 and 0.066 or 0.166)) <= v78 - v88 then
                    v85[3] = v78
                    local v91 = v78 - v88
                    if v91 > 0.25 then
                        v91 = p77
                    end
                    if v90 == nil then
                        v90 = v80:GetPivot()
                    end
                    v80:PivotTo(v90 * CFrame.Angles(v82 * v91, v83 * v91, v84 * v91))
                end
            else
                u50[v80] = nil
            end
        end
    end
end)