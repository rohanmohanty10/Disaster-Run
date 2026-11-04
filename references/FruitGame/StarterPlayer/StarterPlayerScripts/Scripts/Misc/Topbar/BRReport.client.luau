 

local v1 = game:GetService("ReplicatedStorage")
local u2 = require(game.ReplicatedStorage:WaitForChild("Modules"):WaitForChild("TopbarPlus"):WaitForChild("Icon"))
local v3 = require(v1.Modules.Trove)
local u4 = game.Players.LocalPlayer
local u5 = game.ReplicatedStorage:WaitForChild("Events"):WaitForChild("ReportKick")
local u6 = v3.new()
game:GetService("UserInputService")
local u7 = true
local u8 = 0
local u9 = false
while true do
    local v10, _ = pcall(function() --[[ Line: 19 ]]
        --[[
        Upvalues:
            [1] = u4
            [2] = u7
            [3] = u8
        --]]
        if u4:IsInGroup(268184936) == false then
            u7 = false
        else
            u8 = u4:GetRankInGroup(268184936)
        end
    end)
    if v10 == true then
        break
    end
    task.wait(1)
end
local u11 = false
pcall(function() --[[ Line: 34 ]]
    --[[
    Upvalues:
        [1] = u11
        [2] = u4
    --]]
    u11 = game:GetService("BadgeService"):UserHasBadgeAsync(u4.UserId, 4199204445683457)
end)
if u7 == false and u11 == false then
    script:Destroy()
    return
elseif u8 < 100 and u11 == false then
    script:Destroy()
    return
else
    local v12
    if _G.arena == nil then
        v12 = u11
        repeat
            task.wait()
        until _G.arena ~= nil
    else
        v12 = u11
    end
    if _G.arena == false and game.GameId ~= 2097989947 then
        return
    else
        if _G.arena == true then
            local v13 = game.ReplicatedStorage:WaitForChild("reservedCode")
            repeat
                task.wait()
            until v13.Value ~= "checking"
            if v13:GetAttribute("battleRoyale") == nil then
                return
            end
        end
        local u14 = u2.new():align("Left"):setLabel("BR Report System"):setCaption("DO NOT ABUSE"):setTextFont(Enum.Font.SourceSansBold):setOrder(50):setImage(14942519118)
        local u15 = nil
        local u16 = false
        local u17 = {}
        local function u30() --[[ Line: 80 ]]
            --[[
            Upvalues:
                [1] = u15
                [2] = u2
                [3] = u4
                [4] = u5
                [5] = u6
                [6] = u9
                [7] = u17
                [8] = u14
                [9] = u16
            --]]
            local v18 = game.Players:GetPlayers()
            table.sort(v18, function(p19, p20) --[[ Line: 82 ]]
                return p19.Name:lower() < p20.Name:lower()
            end)
            local v21 = {}
            if u15 then
                for v22 = 1, #u15 do
                    u15[v22]:Destroy()
                end
            end
            local v24 = u2.new():setLabel("Self Respawn"):bindEvent("selected", function(_) --[[ Line: 96 ]]
                --[[
                Upvalues:
                    [1] = u4
                    [2] = u5
                --]]
                local v23 = {
                    [true] = function() --[[ Line: 98 ]]
                        --[[
                        Upvalues:
                            [1] = u5
                        --]]
                        u5:InvokeServer("Respawn")
                    end,
                    [false] = function() --[[ Line: 101 ]] end
                }
                _G.promptQuestion(u4, "<font color=\"rgb(255,0,0)\">Are you sure you want to respawn (spectate)? DONT RESPAWN UNTIL YOU DROP FROM BUS!</font>", v23)
            end):setOrder(-100000000000):oneClick(true):align("Center")
            table.insert(v21, v24)
            u6:Clean()
            for v25, u26 in ipairs(v18) do
                if u26 ~= u4 or game.GameId == 2097989947 then
                    local v29 = u2.new():setLabel(u26.Name):bindEvent("selected", function(_) --[[ Line: 121 ]]
                        --[[
                        Upvalues:
                            [1] = u9
                            [2] = u26
                            [3] = u4
                            [4] = u5
                        --]]
                        if u9 ~= true then
                            u9 = true
                            local u27
                            if u26.Character then
                                u27 = Instance.new("Highlight")
                                u27.FillTransparency = 0.2
                                u27.FillColor = Color3.fromRGB(255, 0, 0)
                                u27.Parent = u26.Character
                            else
                                u27 = nil
                            end
                            local v28 = {
                                [true] = function() --[[ Line: 145 ]]
                                    --[[
                                    Upvalues:
                                        [1] = u5
                                        [2] = u26
                                        [3] = u27
                                        [4] = u9
                                    --]]
                                    u5:InvokeServer(u26)
                                    if u27 then
                                        u27:Destroy()
                                    end
                                    u9 = false
                                end,
                                [false] = function() --[[ Line: 149 ]]
                                    --[[
                                    Upvalues:
                                        [1] = u27
                                        [2] = u9
                                    --]]
                                    if u27 then
                                        u27:Destroy()
                                    end
                                    u9 = false
                                end
                            }
                            _G.promptQuestion(u4, ("Report <font color=\"rgb(255,0,0)\">%*</font> for exploiting? They will be <font color=\"rgb(255,0,0)\">kicked</font> from this server."):format((string.upper(u26.Name))), v28)
                        end
                    end):setImage(("rbxthumb://type=AvatarHeadShot&id=%d&w=100&h=100"):format(u26.UserId)):setOrder(v25):oneClick(true):align("Center")
                    u17[u26.UserId] = v29
                    table.insert(v21, v29)
                end
            end
            u14:setDropdown(v21)
            u15 = v21
            u16 = false
        end
        local function v32(p31) --[[ Line: 178 ]]
            --[[
            Upvalues:
                [1] = u16
                [2] = u30
            --]]
            if p31:GetAttribute("ReportStarted") then
                return
            else
                p31:SetAttribute("ReportStarted", true)
                if not u16 then
                    u16 = true
                    task.delay(1, u30)
                end
            end
        end
        game.Players.PlayerAdded:Connect(v32)
        game.Players.PlayerRemoving:Connect(function(p33) --[[ Line: 190 ]]
            --[[
            Upvalues:
                [1] = u17
            --]]
            if u17[p33.UserId] then
                u17[p33.UserId]:Destroy()
                u17[p33.UserId] = nil
            end
        end)
        local v34 = game.Players:GetPlayers()
        local v35 = u16
        for v36 = 1, #v34 do
            local v37 = v34[v36]
            if not v37:GetAttribute("ReportStarted") then
                v37:SetAttribute("ReportStarted", true)
                if not v35 then
                    u16 = true
                    task.delay(1, u30)
                    v35 = u16
                end
            end
        end
        local u38 = game:GetService("UserInputService")
        local u39 = game:GetService("RunService")
        local v40 = game:GetService("Players").LocalPlayer
        local u41 = false
        local u42 = false
        local u43 = nil
        local u44 = nil
        local u45 = workspace.CurrentCamera
        local u46 = false
        local u47 = nil
        local u48 = nil
        local u49 = false
        local u50 = game.ReplicatedStorage:WaitForChild("DrawRemote")
        if game["Run Service"]:IsStudio() ~= true then
            if v12 == true or v40.Name == "Phoeating" and (_G.arena == true or game.GameId == 2097989947 and game["Run Service"]:IsStudio() == true) then
                local u51 = false
                u38.InputBegan:Connect(function(p52, p53) --[[ Line: 226 ]]
                    --[[
                    Upvalues:
                        [1] = u51
                        [2] = u5
                        [3] = u41
                        [4] = u43
                        [5] = u50
                        [6] = u46
                        [7] = u47
                        [8] = u45
                        [9] = u48
                        [10] = u39
                        [11] = u38
                    --]]
                    if p53 == true then
                        return
                    else
                        if p52.KeyCode == Enum.KeyCode.P then
                            u51 = not u51
                        end
                        if u51 == false then
                            return
                        elseif p52.KeyCode == Enum.KeyCode.F then
                            warn("spawning chest")
                            u5:InvokeServer(_G.MouseCF)
                            return
                        elseif p52.KeyCode == Enum.KeyCode.R then
                            warn("spawning chest 2")
                            u5:InvokeServer(_G.MouseCF, "Common")
                        elseif p52.KeyCode == Enum.KeyCode.G then
                            u41 = not u41
                            if u41 then
                                warn("Drawing mode enabled - hold left mouse to draw")
                                return
                            end
                            warn("Drawing mode disabled")
                            if u43 then
                                u43:Disconnect()
                                u43 = nil
                                return
                            end
                        else
                            if p52.KeyCode == Enum.KeyCode.J then
                                warn("Clearing all drawings")
                                u50:FireServer("ClearDrawings")
                                return
                            end
                            if p52.KeyCode == Enum.KeyCode.V then
                                u46 = not u46
                                if u46 then
                                    warn("Free cam enabled")
                                    u47 = u45.CFrame
                                    u45.CameraType = Enum.CameraType.Scriptable
                                    u48 = u39.RenderStepped:Connect(function() --[[ Line: 264 ]]
                                        --[[
                                        Upvalues:
                                            [1] = u45
                                            [2] = u38
                                            [3] = u47
                                        --]]
                                        local v54 = Vector3.new()
                                        local v55 = u45.CFrame
                                        if u38:IsKeyDown(Enum.KeyCode.W) then
                                            v54 = v54 + v55.LookVector
                                        end
                                        if u38:IsKeyDown(Enum.KeyCode.S) then
                                            v54 = v54 - v55.LookVector
                                        end
                                        if u38:IsKeyDown(Enum.KeyCode.A) then
                                            v54 = v54 - v55.RightVector
                                        end
                                        if u38:IsKeyDown(Enum.KeyCode.D) then
                                            v54 = v54 + v55.RightVector
                                        end
                                        if u38:IsKeyDown(Enum.KeyCode.E) then
                                            v54 = v54 + v55.UpVector
                                        end
                                        if u38:IsKeyDown(Enum.KeyCode.Q) then
                                            v54 = v54 - v55.UpVector
                                        end
                                        if v54.Magnitude > 0 then
                                            v54 = v54.Unit
                                        end
                                        u47 = u47 + v54 * (u38:IsKeyDown(Enum.KeyCode.LeftShift) and 64 or (u38:IsKeyDown(Enum.KeyCode.LeftControl) and 4 or 16)) * 0.03333333333333333
                                        u45.CFrame = u47
                                        u45.Focus = u47 + u47.LookVector * 5
                                    end)
                                    u38.MouseBehavior = Enum.MouseBehavior.Default
                                    return
                                end
                                warn("Free cam disabled")
                                u45.CameraType = Enum.CameraType.Custom
                                if u48 then
                                    u48:Disconnect()
                                    u48 = nil
                                end
                                u38.MouseBehavior = Enum.MouseBehavior.Default
                            end
                        end
                    end
                end)
                u38.InputBegan:Connect(function(p56, p57) --[[ Line: 316 ]]
                    --[[
                    Upvalues:
                        [1] = u41
                        [2] = u42
                        [3] = u44
                        [4] = u43
                        [5] = u39
                        [6] = u50
                        [7] = u46
                        [8] = u49
                        [9] = u38
                    --]]
                    if p57 then
                        return
                    elseif p56.UserInputType == Enum.UserInputType.MouseButton1 and u41 then
                        u42 = true
                        u44 = nil
                        if u43 then
                            u43:Disconnect()
                        end
                        u43 = u39.Heartbeat:Connect(function() --[[ Line: 324 ]]
                            --[[
                            Upvalues:
                                [1] = u42
                                [2] = u44
                                [3] = u50
                            --]]
                            if u42 and _G.MouseCF then
                                local v58 = _G.MouseCF.Position
                                if u44 then
                                    if (v58 - u44).Magnitude < 0.01 then
                                        return
                                    end
                                    u50:FireServer("DrawLine", {
                                        ["StartPosition"] = u44,
                                        ["EndPosition"] = v58
                                    })
                                else
                                    u50:FireServer("DrawPoint", {
                                        ["Position"] = v58
                                    })
                                end
                                u44 = v58
                            end
                        end)
                    elseif p56.UserInputType == Enum.UserInputType.MouseButton2 and u46 then
                        u49 = true
                        u38.MouseBehavior = Enum.MouseBehavior.LockCurrentPosition
                    end
                end)
                u38.InputEnded:Connect(function(p59, p60) --[[ Line: 352 ]]
                    --[[
                    Upvalues:
                        [1] = u42
                        [2] = u44
                        [3] = u43
                        [4] = u46
                        [5] = u49
                        [6] = u38
                    --]]
                    if not p60 then
                        if p59.UserInputType == Enum.UserInputType.MouseButton1 then
                            u42 = false
                            u44 = nil
                            if u43 then
                                u43:Disconnect()
                                u43 = nil
                                return
                            end
                        elseif p59.UserInputType == Enum.UserInputType.MouseButton2 and u46 then
                            u49 = false
                            u38.MouseBehavior = Enum.MouseBehavior.Default
                        end
                    end
                end)
                u38.InputChanged:Connect(function(p61) --[[ Line: 367 ]]
                    --[[
                    Upvalues:
                        [1] = u46
                        [2] = u49
                        [3] = u47
                    --]]
                    if u46 and (u49 and p61.UserInputType == Enum.UserInputType.MouseMovement) then
                        local v62 = p61.Delta
                        local v63 = u47
                        local v64 = -v62.X * 0.003
                        local v65 = -v62.Y * 0.003
                        local _, v66, _ = v63:ToEulerAnglesYXZ()
                        local v67 = v66 + v65
                        math.clamp(v67, -1.3962634015954636, 1.3962634015954636)
                        u47 = CFrame.new(u47.Position) * CFrame.Angles(0, v64, 0) * v63.Rotation * CFrame.Angles(v65, 0, 0)
                    end
                end)
                u38.InputEnded:Connect(function(p68, p69) --[[ Line: 383 ]]
                    --[[
                    Upvalues:
                        [1] = u46
                        [2] = u49
                        [3] = u38
                    --]]
                    if p69 ~= true then
                        if p68.KeyCode == Enum.KeyCode.V and not u46 then
                            u49 = false
                            u38.MouseBehavior = Enum.MouseBehavior.Default
                        end
                    end
                end)
            end
        end
    end
end