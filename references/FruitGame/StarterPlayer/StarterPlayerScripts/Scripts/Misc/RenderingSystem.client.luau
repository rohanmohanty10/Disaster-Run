 

if workspace.StreamingEnabled == true then
    return
else
    local u1 = script.RenderCache
    u1.Parent = nil
    if game.ReplicatedStorage.reservedCode.Value == "arena" then
        script:Destroy()
    else
        _G.RenderCache = u1
        _G.IslandCFrames = {}
        local v2 = require(script.Octree.Octree).new()
        local _ = workspace.CurrentCamera
        local v3 = {}
        local u4 = {}
        for _, v5 in workspace.Islands:GetChildren() do
            if v5:IsA("Model") then
                v3[v5] = true
                u4[v5] = v5.Parent
                _G.IslandCFrames[v5.Name] = v5:GetModelCFrame()
                v2:CreateNode(v5:GetModelCFrame().p, v5)
            end
        end
        for _, v6 in workspace.Islands:GetDescendants() do
            if v6:IsA("Model") and v6.Parent ~= workspace.Islands then
                u4[v6] = v6.Parent
                v2:CreateNode(v6:GetModelCFrame().p, v6)
            end
        end
        for _, v7 in workspace.BuyableItems:GetChildren() do
            if v7:IsA("Model") then
                u4[v7] = v7.Parent
                v2:CreateNode(v7:GetModelCFrame().p, v7)
            end
        end
        for _, v8 in workspace.Jails:GetDescendants() do
            if v8:IsA("Model") and v8.Parent:IsA("ObjectValue") then
                u4[v8] = v8.Parent
                v2:CreateNode(v8:GetModelCFrame().p, v8)
            end
        end
        local v9 = workspace.Env:GetChildren()
        for v10 = 1, #v9 do
            if v9[v10]:GetAttribute("render") ~= nil and v9[v10]:IsA("Model") then
                local v11 = v9[v10]
                u4[v11] = v11.Parent
                v2:CreateNode(v11:GetModelCFrame().p, v11)
            end
        end
        local v12 = game:GetService("CollectionService"):GetTagged("Seats")
        for v13 = 1, #v12 do
            if v12[v13]:IsA("Seat") then
                v12[v13].Disabled = false
            end
        end
        game.ReplicatedStorage.Events.loadIsland.OnClientEvent:Connect(function(p14, p15) --[[ Line: 180 ]]
            --[[
            Upvalues:
                [1] = u1
                [2] = u4
            --]]
            if p15 and workspace.StreamingEnabled == true then
                _G.requestStream(p15.p)
            elseif u1:FindFirstChild(p14) and u4[u1:FindFirstChild(p14)] == workspace.Islands then
                u1:FindFirstChild(p14).Parent = workspace.Islands
            end
        end)
    end
end