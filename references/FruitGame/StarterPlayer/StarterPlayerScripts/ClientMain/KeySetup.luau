 

local u1 = {}
local u2 = game.Players.LocalPlayer
require(game.ReplicatedStorage.Modules.MEnterLeave)
local u3 = require(game.ReplicatedStorage.Modules.Skills)
local u4 = true
local u5 = nil
local u6 = require(game.ReplicatedStorage.Modules.Skills)
local u7 = {}
local u8 = {}
local u9 = {}
require(game.ReplicatedStorage.Modules.FastWait)
local u10 = {}
local u11 = nil
local function u20(p12) --[[ Line: 17 ]]
    --[[
    Upvalues:
        [1] = u5
    --]]
    local v13 = script.GUI:GetDescendants()
    if u5 then
        local v14 = u5:GetDescendants()
        for v15 = 1, #v14 do
            local v16 = v14[v15]
            table.insert(v13, v16)
        end
    end
    local v17 = {}
    for v18 = 1, #v13 do
        if v13[v18].Name == p12 then
            local v19 = v13[v18]
            table.insert(v17, v19)
        end
    end
    return v17
end
function u1.cooldown(_, u21, u22, u23) --[[ Line: 47 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u20
        [3] = u9
        [4] = u10
    --]]
    task.spawn(function() --[[ Line: 48 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u23
            [3] = u20
            [4] = u21
            [5] = u9
            [6] = u22
            [7] = u10
        --]]
        u2.PlayerGui:FindFirstChild("Keys")
        local v24 = u20(u21)
        for v25 = 1, #v24 do
            local u26 = v24[v25]
            if u9[u21] == nil and u22 then
                u9[u21] = {
                    ["endTime"] = tick() + u22,
                    ["coolTime"] = u22,
                    ["startTime"] = tick()
                }
                task.delay(u22, function() --[[ Line: 60 ]]
                    --[[
                    Upvalues:
                        [1] = u9
                        [2] = u21
                    --]]
                    u9[u21] = nil
                end)
            end
            u22 = u9[u21].coolTime
            task.spawn(function() --[[ Line: 68 ]]
                --[[
                Upvalues:
                    [1] = u9
                    [2] = u21
                    [3] = u10
                    [4] = u22
                    [5] = u26
                --]]
                local u27 = u9[u21].startTime
                local u28 = Color3.fromRGB(255, 0, 0)
                local v29 = game:GetService("HttpService"):GenerateGUID()
                u10[u21] = v29
                local v30 = false
                while u22 ~= 0 do
                    if u10[u21] ~= v29 then
                        v30 = true
                        break
                    end
                    local u31 = 1 - (tick() - u27) / u22
                    local _, _ = pcall(function() --[[ Line: 86 ]]
                        --[[
                        Upvalues:
                            [1] = u26
                            [2] = u28
                            [3] = u31
                            [4] = u22
                            [5] = u27
                        --]]
                        local v32 = u26.TextLabel.Frame.UIGradient
                        local v33 = ColorSequence.new
                        local v34 = {}
                        local v35 = ColorSequenceKeypoint.new(0, u28)
                        local v36 = ColorSequenceKeypoint.new
                        local v37 = u31 * 0.9
                        __set_list(v34, 1, {v35, v36(math.clamp(v37, 0, 0.9), u28), ColorSequenceKeypoint.new(u31, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))})
                        v32.Color = v33(v34)
                        u26.Frame.cdStroke.Enabled = true
                        local v38 = u26.TextLabel.cdTimer
                        local v39 = (u22 - (tick() - u27)) * 10
                        local v40
                        if v39 >= 0 then
                            local v41 = v39 + 0.5
                            v40 = math.floor(v41)
                        else
                            local v42 = v39 - 0.5
                            v40 = math.ceil(v42)
                        end
                        v38.Text = v40 / 10
                        u26.TextLabel.cdTimer.Visible = true
                    end)
                    game["Run Service"].Heartbeat:Wait()
                    if u22 <= tick() - u27 then
                        break
                    end
                end
                if u10[u21] == v29 then
                    u10[u21] = nil
                end
                if v30 == false then
                    u9[u21] = nil
                end
                u26.TextLabel.Frame.UIGradient.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255))
                u26.TextLabel.cdTimer.Visible = false
                u26.Frame.cdStroke.Enabled = false
            end)
        end
    end)
end
local u43 = nil
local u44 = nil
local u45 = {}
local function u56(p46, p47, p48) --[[ Line: 114 ]]
    --[[
    Upvalues:
        [1] = u6
        [2] = u45
    --]]
    local v49 = game.ReplicatedStorage:FindFirstChild("Stats" .. game.Players.LocalPlayer.Name)
    if v49 == nil then
        return true
    end
    local v50 = true
    local v51 = 0
    local v52 = u6.GetM(p48).hiddenLock ~= nil
    if p47 == nil then
        v50 = false
    else
        for v53, v54 in p47 do
            v49.Stats:FindFirstChild(v53)
            local v55 = u6.GetM(p48)
            if _G.MeetReq(v55.statreq) then
                p46.desc.img.TextLabel.Text = v55.desc
                p46.Frame.TextLabel.Text = p48
                v51 = v54
                v50 = false
            else
                p46.desc.img.TextLabel.Text = "???"
                p46.Frame.TextLabel.Text = "???"
                v50 = true
                if v53:match("/SKILL/") == nil then
                    v51 = v54
                end
            end
        end
    end
    if v50 == true then
        if v52 == false then
            p46.lock.levelreq.Text = v51
        else
            p46.lock.levelreq.Text = "???"
        end
        p46.lock.Visible = true
        p46.TextLabel.Visible = false
    else
        p46.lock.Visible = false
        p46.TextLabel.Visible = true
    end
    u45[p46] = v50
    return v50
end
local u57 = {}
function u1.Destroy(_) --[[ Line: 164 ]]
    --[[
    Upvalues:
        [1] = u5
        [2] = u8
        [3] = u7
        [4] = u45
    --]]
    if u5 and not pcall(function() --[[ Line: 166 ]]
        --[[
        Upvalues:
            [1] = u5
        --]]
        u5.Parent = script.GUI
    end) then
        u8[u5.Name] = nil
        u7[u5.Name] = nil
        u5 = nil
    end
    u45 = {}
end
local u58 = nil
function u1.setup(_, u59, p60) --[[ Line: 182 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u58
        [3] = u7
        [4] = u5
        [5] = u8
        [6] = u45
        [7] = u44
        [8] = u1
        [9] = u3
        [10] = u57
        [11] = u9
        [12] = u11
        [13] = u4
        [14] = u43
    --]]
    game.ReplicatedStorage:FindFirstChild("Stats" .. u2.Name)
    if u58 == nil then
        u58 = game.Players.LocalPlayer.Character
    end
    if u2.PlayerGui:FindFirstChild("Keys") == nil then
        if u7[u59] and u7[u59]:IsDescendantOf(script.GUI) then
            u5 = u7[u59]
            u5.Parent = game.Players.LocalPlayer.PlayerGui
        elseif u7[u59] and u7[u59]:IsDescendantOf(script) == false then
            if u8[u59] then
                pcall(function() --[[ Line: 197 ]]
                    --[[
                    Upvalues:
                        [1] = u7
                        [2] = u59
                        [3] = u45
                    --]]
                    local v61 = u7[u59].Frame:GetChildren()
                    for v62 = 1, #v61 do
                        if u45[v61[v62]] then
                            u45[v61[v62]] = nil
                        end
                    end
                end)
            end
            u7[u59]:Destroy()
            u7[u59] = nil
        end
        local u63
        if u7[u59] == nil then
            u63 = script.Keys:Clone()
            u63.Parent = game.Players.LocalPlayer.PlayerGui
            u63.Frame.Frame.Visible = false
            u63.Frame.nameFrame.TextLabel.Text = u59
            if _G.mobile == true then
                u63.Frame.Size = UDim2.new(u63.Frame.Size.X.Scale, 0, 0.6, 0)
            end
        else
            u63 = u7[u59]
        end
        if u44 then
            u44:Disconnect()
            u44 = nil
        end
        u7[u59] = u63
        u5 = u63
        if u63:FindFirstChild("Frame") == nil then
            u63:Destroy()
            u7[u59] = nil
            _G.keysetup:Destroy()
            u1:setup(u59, p60)
            return
        end
        local v64 = #p60
        for v65 = 1, #p60 do
            local v66 = p60[v65][1]
            if u63.Frame:FindFirstChild(p60[v65][1]) == nil then
                local v67 = p60[v65][2]
                if string.len(v67) == 1 then
                    v67 = string.upper(p60[v65][2])
                end
                local v68 = p60[v65][3]
                local v69 = u63.Frame.Frame:Clone()
                v69.Name = v66
                v69.LayoutOrder = v64 - v65
                v69.TextLabel.TextLabel.Text = v67
                v69:SetAttribute("buttonKey", "Enum.KeyCode." .. v67)
                if v68 then
                    v69.TextLabel.TextLabel.Text = v68 .. " " .. v67
                end
                v69.Frame.TextLabel.Text = v66
                v69.Visible = true
                local _ = v69.TextLabel.Frame.BackgroundColor3
                local v70 = u3.GetM(v66).statreq
                local _ = v69.desc.img.Position
                local v71 = UDim2.new(1, 0, 0, 0)
                v69.desc.img.Position = v71
                v69.desc.img.TextLabel.Text = u3.GetM(v66).desc
                local v72 = u57
                table.insert(v72, { v69, v70, v66 })
                v69.Parent = u63.Frame
            end
            if u9[v66] then
                warn(v66 .. " has eixsitng cd")
                u11:cooldown(v66, nil, u63)
            end
        end
        local u73 = false
        local _ = u63.Frame.Position.X.Scale
        local u74 = UDim2.new(script.Keys.Frame.Position.X.Scale, 0, u63.Frame.Position.Y.Scale, 0)
        local u75 = UDim2.new(1.25, 0, u63.Frame.Position.Y.Scale, 0)
        if u4 then
            u63.TextButton.TextLabel.Text = "Close"
            u63.Frame.Position = u74
        else
            u63.TextButton.TextLabel.Text = "Open"
            u63.Frame.Position = u75
        end
        if u43 then
            u43:Disconnect()
            u43 = nil
        end
        u43 = u63.TextButton.MouseButton1Click:Connect(function() --[[ Line: 296 ]]
            --[[
            Upvalues:
                [1] = u73
                [2] = u4
                [3] = u63
                [4] = u74
                [5] = u75
            --]]
            if u73 == false then
                u4 = not u4
                u73 = true
                if u4 then
                    u63.TextButton.TextLabel.Text = "Close"
                    u63.Frame:TweenPosition(u74, "Out", "Quad", 0.25, true)
                else
                    u63.TextButton.TextLabel.Text = "Open"
                    u63.Frame:TweenPosition(u75, "Out", "Quad", 0.5, true)
                end
                task.wait(0.3)
                u73 = false
            end
        end)
        if u58 ~= game.Players.LocalPlayer.Character then
            u58 = game.Players.LocalPlayer.Character
        end
    end
end
local function u80(p76) --[[ Line: 317 ]]
    --[[
    Upvalues:
        [1] = u5
    --]]
    if u5 ~= nil then
        local v77 = nil
        if u5:FindFirstChild("Frame") ~= nil then
            local v78 = u5.Frame:GetChildren()
            for v79 = 1, #v78 do
                if v78[v79]:GetAttribute("buttonKey") ~= nil and v78[v79]:GetAttribute("buttonKey") == tostring(p76) then
                    return v78[v79]
                end
            end
            return v77
        end
    end
end
game:GetService("UserInputService").InputBegan:Connect(function(u81, p82) --[[ Line: 337 ]]
    --[[
    Upvalues:
        [1] = u5
        [2] = u80
        [3] = u45
    --]]
    if u5 == nil then
        return
    elseif p82 ~= true then
        local u83 = u80(u81.KeyCode)
        if u83 ~= nil and u45[u83] == false then
            u83.TextLabel.Frame.BackgroundColor3 = Color3.fromRGB(151, 198, 255)
            local u84 = nil
            u84 = game:GetService("UserInputService").InputEnded:Connect(function(p85, p86) --[[ Line: 346 ]]
                --[[
                Upvalues:
                    [1] = u81
                    [2] = u84
                    [3] = u83
                --]]
                if p86 == false and p85.KeyCode == u81.KeyCode then
                    u84:Disconnect()
                    u84 = nil
                    u83.TextLabel.Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                end
            end)
        end
    end
end)
task.spawn(function() --[[ Line: 356 ]]
    --[[
    Upvalues:
        [1] = u57
        [2] = u56
    --]]
    while true do
        for v87 = 1, #u57 do
            if u57[v87] then
                local v88 = u57[v87]
                local v89, v90, v91 = unpack(v88)
                if v89 == nil or v89 and v89.Parent == nil then
                    table.remove(u57, v87)
                else
                    u56(v89, v90, v91)
                end
            else
                table.remove(u57, v87)
            end
        end
        task.wait(0.2)
    end
end)
u11 = u1
game.Players.LocalPlayer.CharacterAdded:Connect(function() --[[ Line: 376 ]]
    --[[
    Upvalues:
        [1] = u7
        [2] = u1
    --]]
    for _, v92 in pairs(u7) do
        if v92 then
            v92:Destroy()
        end
    end
    table.clear(u7)
    u1:Destroy()
end)
return u1