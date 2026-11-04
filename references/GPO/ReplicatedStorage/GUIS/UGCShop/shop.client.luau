 

local v1 = game.ReplicatedStorage:WaitForChild("UGCAssets", 600)
if v1 then
    repeat
        task.wait(0.1)
    until script.Parent.Enabled == true
    local u2 = require(game.ReplicatedStorage.Modules.Module3D)
    local u3 = script.Parent.Frame.Frame.ScrollingFrame
    local u4 = {}
    require(game.ReplicatedStorage.Modules.MEnterLeave)
    function weldAttachments(p5, p6)
        local v7 = Instance.new("Weld")
        v7.Part0 = p5.Parent
        v7.Part1 = p6.Parent
        v7.C0 = p5.CFrame
        v7.C1 = p6.CFrame
        v7.Parent = p5.Parent
        return v7
    end
    local function u12(p8, p9) --[[ Line: 36 ]]
        --[[
        Upvalues:
            [1] = u12
        --]]
        for _, v10 in pairs(p8:GetChildren()) do
            if v10:IsA("Attachment") and v10.Name == p9 then
                return v10
            end
            if not (v10:IsA("Accoutrement") or v10:IsA("Tool")) then
                local v11 = u12(v10, p9)
                if v11 then
                    return v11
                end
            end
        end
    end
    function addAccoutrement(p13, p14)
        --[[
        Upvalues:
            [1] = u12
        --]]
        p14.Parent = p13
        local v15 = p14:FindFirstChild("Handle")
        if v15 then
            local v16 = v15:FindFirstChildOfClass("Attachment")
            if v16 then
                local v17 = u12(p13, v16.Name)
                if v17 then
                    weldAttachments(v17, v16)
                    return
                end
            else
                local v18 = p13:FindFirstChild("Head")
                if v18 then
                    local v19 = CFrame.new(0, 0.5, 0)
                    local v20 = p14.AttachmentPoint
                    local v21 = Instance.new("Weld")
                    v21.Name = "HeadWeld"
                    v21.Part0 = v18
                    v21.Part1 = v15
                    v21.C0 = v19
                    v21.C1 = v20
                    v21.Parent = v18
                end
            end
        end
    end
    (function() --[[ Name: clear, Line 70 ]]
        --[[
        Upvalues:
            [1] = u3
        --]]
        local v22 = u3:GetChildren()
        for v23 = 1, #v22 do
            if v22[v23]:IsA("ImageButton") then
                v22[v23]:Destroy()
            end
        end
    end)()
    local u24 = game.Players:CreateHumanoidModelFromUserId(game.Players.LocalPlayer.UserId)
    u24:WaitForChild("Humanoid")
    u24.Humanoid.EvaluateStateMachine = false
    u24.PrimaryPart.Anchored = true
    u24:WaitForChild("Animate"):Destroy()
    local _ = u3.UIGridLayout
    local function u33() --[[ Line: 99 ]]
        --[[
        Upvalues:
            [1] = u3
        --]]
        local v25 = Vector2.new(0.025, 0.165)
        local v26 = Vector2.new(0.4, 0.4)
        local v27 = u3
        local v28 = v27.UIGridLayout
        local v29 = v26 * v27.AbsoluteSize
        local v30 = v25 * v27.AbsoluteSize
        local v31 = UDim2.new(0, v30.X, 0, v30.Y)
        local v32 = UDim2.new(0, v29.X, 0, v29.Y)
        if u3:IsA("ScrollingFrame") then
            v28.CellPadding = v31
            v28.CellSize = v32
            v27.CanvasSize = UDim2.new(0, v28.AbsoluteContentSize.X, 0, v28.AbsoluteContentSize.Y + 50)
        end
    end
    u33()
    game["Run Service"].Heartbeat:Connect(function(_) --[[ Line: 118 ]]
        --[[
        Upvalues:
            [1] = u4
            [2] = u33
        --]]
        if script.Parent.Enabled == false then
            for _, v34 in pairs(u4) do
                v34.Visible = false
            end
        else
            for _, v35 in pairs(u4) do
                v35.Visible = true
            end
            local v36 = CFrame.Angles(0, tick() % 6.283185307179586, 0) * CFrame.Angles(-0.03490658503988659, 0, 0)
            u33()
            for v37, _ in pairs(u4) do
                v37:SetCFrame(v36)
            end
        end
    end)
    local u38 = v1:GetChildren()
    local function u43(p39, p40) --[[ Line: 87 ]]
        local v41 = p39:GetChildren()
        for v42 = 1, #v41 do
            if v41[v42]:IsA("Accessory") and (v41[v42].AccessoryType == p40.AccessoryType and v41[v42] ~= p40) then
                v41[v42]:Destroy()
            end
        end
    end
    for u44 = 1, #u38 do
        task.spawn(function() --[[ Line: 139 ]]
            --[[
            Upvalues:
                [1] = u38
                [2] = u44
                [3] = u24
                [4] = u43
                [5] = u2
                [6] = u3
                [7] = u4
            --]]
            local u45 = u38[u44]
            local v46, v47 = pcall(game:GetService("MarketplaceService").PlayerOwnsAsset, game:GetService("MarketplaceService"), game.Players.LocalPlayer, u45:GetAttribute("ID"))
            if v46 ~= true or v47 ~= true then
                if script.Parent.Enabled == false then
                    repeat
                        task.wait(0.1)
                    until script.Parent.Enabled == true
                end
                local u48 = script.Temp:Clone()
                local u49 = u45:Clone()
                local u50 = u24:Clone()
                addAccoutrement(u50, u49)
                u43(u50, u49)
                u50.Parent = game.Workspace
                task.delay(0.1, function() --[[ Line: 159 ]]
                    --[[
                    Upvalues:
                        [1] = u2
                        [2] = u48
                        [3] = u50
                        [4] = u45
                        [5] = u3
                        [6] = u4
                        [7] = u49
                    --]]
                    local v51 = u2:Attach3D(u48.Frame, u50)
                    v51:SetDepthMultiplier(1.5)
                    v51.Camera.FieldOfView = 70
                    v51:SetActive(true)
                    v51:SetCFrame(CFrame.new(0, 0, 0) * CFrame.Angles(0, 3.141592653589793, 0))
                    local v52 = u48.Frame:WaitForChild("ViewportFrame", 1)
                    if v52 then
                        v52.ZIndex = 15
                        v52.BackgroundColor3 = Color3.fromRGB(79, 79, 79)
                    end
                    u48.Price.Text = u45:GetAttribute("Price") .. " ROBUX"
                    u48.Name = u45.Name
                    u48.itemName.Text = u45.Name
                    u48.Parent = u3
                    u48.MouseEnter:Connect(function() --[[ Line: 176 ]]
                        --[[
                        Upvalues:
                            [1] = u48
                        --]]
                        u48.itemName.Visible = true
                    end)
                    u48.MouseLeave:Connect(function() --[[ Line: 180 ]]
                        --[[
                        Upvalues:
                            [1] = u48
                        --]]
                        u48.itemName.Visible = false
                    end)
                    u4[v51] = u48
                    u48.Buy.MouseButton1Down:Connect(function() --[[ Line: 186 ]]
                        --[[
                        Upvalues:
                            [1] = u49
                            [2] = u48
                        --]]
                        game:GetService("MarketplaceService"):PromptPurchase(game.Players.LocalPlayer, u49:GetAttribute("ID"))
                        _G.circleclick:Activate(u48)
                    end)
                end)
            end
        end)
        task.wait(0.1)
    end
end