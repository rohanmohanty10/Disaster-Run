 

local u1 = game:GetService("RunService")
local u2 = game:GetService("TweenService")
local v3 = game:GetService("Players")
local u4 = workspace.CurrentCamera
local u5 = v3.LocalPlayer:WaitForChild("PlayerGui")
local v6 = {}
local u7 = {}
function v6.start(_, p8) --[[ Line: 13 ]]
    --[[
    Upvalues:
        [1] = u7
        [2] = u1
        [3] = u4
        [4] = u5
        [5] = u2
    --]]
    local u9 = p8.Message
    local u10 = p8.Cloud
    local v11 = p8.Lifetime or 3
    local u12 = p8.PlayerCharacter.HumanoidRootPart
    if not u10 then
        return
    end
    if u10:FindFirstChild("AttachedPart") == nil then
        return
    end
    if u10:GetScale() < 1 then
        local v13 = tick()
        local v14 = false
        while true do
            task.wait()
            if u10:GetScale() >= 1 then
                v14 = true
                break
            end
            if tick() - v13 >= 1 then
                break
            end
        end
        if v14 == false then
            warn("dont meet scale", u10:GetScale())
            return
        end
    end
    local v15 = u10.AttachedPart
    local u16 = u7[u10] or script.ChatHolder:Clone()
    local v17 = u16:GetAttribute("OriginalOffset")
    local u18 = nil
    local v19 = u16.Frame.ChatBubbleFrameTemplate
    local v20 = v19.Images
    u16.Adornee = v15
    local u21 = u10:GetAttribute("HomieName")
    if not u16:GetAttribute("Active") then
        u16:SetAttribute("Active", true)
        u7[u10] = u16
        if u21 == "Zeus" then
            u16.StudsOffset = v17
            local v22 = u16.Frame
            v22.Rotation = v22.Rotation * -1
            u16.Frame.UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
            v19.TextLabel.TextXAlignment = Enum.TextXAlignment.Right
            u16.SizeOffset = Vector2.new(-0.5, 0.5)
            u18 = "Right"
        elseif u21 == "Prometheus" then
            v20.Right.Visible = false
            v20.Left.Visible = true
            u16.StudsOffset = v17 * Vector3.new(-0.5, 1, 1)
            u16.SizeOffset = Vector2.one * 0.5
            u18 = "Left"
        end
        local u23 = u16.Frame.Rotation
        local u24 = u16.SizeOffset
        local u25 = u16.StudsOffset
        local u26 = u18 == "Left" and "Right" or "Left"
        local u27 = nil
        local u28 = nil
        local function v29() --[[ Line: 93 ]]
            --[[
            Upvalues:
                [1] = u27
                [2] = u28
                [3] = u16
                [4] = u7
                [5] = u10
            --]]
            if u27 then
                u27:Disconnect()
                u27 = nil
            end
            if u28 then
                u28:Disconnect()
                u28 = nil
            end
            u16:SetAttribute("Active", nil)
            u7[u10] = nil
            u16:Destroy()
        end
        u28 = u10.Destroying:Connect(v29)
        u27 = u1.Heartbeat:Connect(function() --[[ Line: 111 ]]
            --[[
            Upvalues:
                [1] = u16
                [2] = u27
                [3] = u28
                [4] = u7
                [5] = u10
                [6] = u12
                [7] = u4
                [8] = u18
                [9] = u26
                [10] = u23
                [11] = u25
                [12] = u21
                [13] = u24
                [14] = u5
            --]]
            local v30 = u16.Frame:QueryDescendants(">Frame")
            if #v30 == 1 then
                if u27 then
                    u27:Disconnect()
                    u27 = nil
                end
                if u28 then
                    u28:Disconnect()
                    u28 = nil
                end
                u16:SetAttribute("Active", nil)
                u7[u10] = nil
                u16:Destroy()
            else
                local v31 = u12.CFrame.LookVector:Dot(u4.CFrame.LookVector) < 0
                local v32 = v31 and u18 or u26
                local v33 = v31 and u26 or u18
                for _, v34 in v30 do
                    v34.Images[v32].Visible = true
                    v34.Images[v33].Visible = false
                    v34.TextLabel.TextXAlignment = Enum.TextXAlignment[v33]
                end
                u16.Frame.Rotation = u23 * (v31 and -1 or 1)
                u16.Frame.UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment[v33]
                local v35 = u16
                local v36 = u25
                local v37 = v31 and (u21 == "Zeus" and 0.5 or 2) or -1
                v35.StudsOffset = v36 * Vector3.new(v37, 1, 1)
                u16.SizeOffset = u24 * Vector2.new(v31 and -1 or 1, 1)
                u16.Parent = u5
            end
        end)
    end
    local u38 = u16.Frame.ChatBubbleFrameTemplate:Clone()
    u38.Size = UDim2.new(0, 0, 0.25, 0)
    u38.TextLabel.Text = u9
    u38.Visible = true
    u38.Parent = u16.Frame
    u2:Create(u38, TweenInfo.new(0.15), {
        ["Size"] = UDim2.fromScale(1, 0.25)
    }):Play()
    task.delay(0.15, function() --[[ Line: 151 ]]
        --[[
        Upvalues:
            [1] = u38
            [2] = u9
        --]]
        u38.TextLabel.Text = u9
    end)
    task.wait(v11)
    u38.TextLabel.Text = ""
    u2:Create(u38, TweenInfo.new(0.15), {
        ["Size"] = UDim2.fromScale(0, 0.25)
    }):Play()
    task.wait(0.15)
    u38:Destroy()
    u38 = nil
end
return v6