 

local u1 = game:GetService("RunService")
local u2 = game:GetService("UserInputService")
game:GetService("StarterGui")
local u3 = game:GetService("TweenService")
local u4 = game.Players.LocalPlayer
u4:GetMouse()
local _ = workspace.CurrentCamera
local u5 = require(script.Maid)
local u6 = require(script.Signal)
local u7 = {}
u7.__index = u7
local v8 = u4:WaitForChild("PlayerScripts")
local u9 = require(v8:WaitForChild("PlayerModule"))
local u10 = game.ReplicatedStorage:WaitForChild("Stats" .. u4.Name)
local u11 = true
u2.WindowFocused:Connect(function() --[[ Line: 25 ]]
    --[[
    Upvalues:
        [1] = u11
    --]]
    u11 = true
end)
u2.WindowFocusReleased:Connect(function() --[[ Line: 29 ]]
    --[[
    Upvalues:
        [1] = u11
    --]]
    u11 = false
end)
function u7.new(u12) --[[ Line: 33 ]]
    --[[
    Upvalues:
        [1] = u7
        [2] = u5
        [3] = u6
        [4] = u4
    --]]
    local v13 = u7
    local u14 = setmetatable({}, v13)
    u14.Maid = u5.new()
    u14.Input = u6.new()
    u14.ToolName = u12
    if u12 then
        u14.Tool = nil
        u14.on = false
        task.spawn(function() --[[ Line: 43 ]]
            --[[
            Upvalues:
                [1] = u14
                [2] = u4
                [3] = u12
            --]]
            u14.Tool = u4.Backpack:FindFirstChild(u12) or u4.Character:FindFirstChild(u12)
            if u14.Tool == nil then
                u14.Tool = u4.Backpack:WaitForChild(u12, 5)
                if u14.Tool == nil then
                    u14.Tool = u4.Character:WaitForChild(u12, 5)
                end
            end
            if not u14.Tool then
                u14.Tool = u14:_findTool(u4.Character) or u14:_findTool(u4.Backpack)
            end
            if u14.Tool then
                if u14.Tool:IsA("Tool") then
                    u14.Tool.Equipped:Connect(function() --[[ Line: 66 ]]
                        --[[
                        Upvalues:
                            [1] = u14
                        --]]
                        u14.on = true
                    end)
                    u14.Tool.Unequipped:Connect(function() --[[ Line: 70 ]]
                        --[[
                        Upvalues:
                            [1] = u14
                        --]]
                        u14.on = false
                    end)
                end
            end
        end)
    end
    return u14
end
function u7._findTool(p15, p16, p17) --[[ Line: 82 ]]
    for _, v18 in p16:GetChildren() do
        if v18.Name:find(p17 or p15.ToolName) then
            return v18
        end
    end
    return nil
end
function u7.GetMouseCFrame(_) --[[ Line: 92 ]]
    if _G.mobile == true then
        _G.Mouse:UpdateGlobals()
    end
    return _G.MouseCF
end
function u7.GetMousePosition(_) --[[ Line: 99 ]]
    if _G.mobile == true then
        _G.Mouse:UpdateGlobals()
    end
    return _G.MouseCF.Position
end
local function u23(p19) --[[ Line: 106 ]]
    local v20 = {
        ["ImageColor3"] = Color3.fromRGB(255, 85, 0)
    }
    local v21 = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, -1, true, 0)
    local v22 = game:GetService("TweenService"):Create(p19.ActionIcon, v21, v20)
    v22:Play()
    return v22
end
local u24 = false
u2.TouchStarted:Connect(function(p25) --[[ Line: 119 ]]
    --[[
    Upvalues:
        [1] = u24
    --]]
    if not p25 then
        u24 = true
    end
end)
u2.TouchEnded:Connect(function(p26) --[[ Line: 126 ]]
    --[[
    Upvalues:
        [1] = u24
    --]]
    if not p26 then
        u24 = false
    end
end)
local function u37(p27, p28, p29) --[[ Line: 133 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u9
    --]]
    if _G.FaceMouse then
        local _ = u4.Character
        if _G.mobile == true and (u9 and (u9.cameras.CameraModule.activeMouseLockController ~= nil and u9.cameras.CameraModule.activeMouseLockController:GetIsMouseLocked() == true)) then
            local v30 = u4.PlayerGui:FindFirstChild("MobileMouseIcon").Icon
            p28 = v30.AbsolutePosition + v30.AbsoluteSize / 2
            p29 = true
        end
        if p28 then
            _G.Mouse:SetPosition(p28, p29)
        end
        local v31 = p27:GetMousePosition()
        local v32 = u4.Character
        local v33 = v32.PrimaryPart
        if _G.mouseLevel then
            local v34 = v31.X
            local v35 = v32.HumanoidRootPart.Position.Y
            local v36 = v31.Z
            v31 = Vector3.new(v34, v35, v36)
        end
        v32:SetPrimaryPartCFrame(CFrame.new(v33.Position, v31))
    end
end
local function u49(p38) --[[ Line: 177 ]]
    --[[
    Upvalues:
        [1] = u4
    --]]
    local v39 = game.ReplicatedStorage:FindFirstChild("Stats" .. u4.Name)
    if p38.Tool ~= nil then
        local v40
        if p38.Tool then
            local v41 = p38.Tool
            if typeof(v41) == "string" then
                v40 = p38.Tool
            else
                v40 = p38.Tool.Name
            end
        else
            v40 = nil
        end
        local v42 = script.Parent:FindFirstChild(v40, true)
        local v43 = {
            ["DF"] = true,
            ["FightingStyle"] = true
        }
        if v42 then
            local v44 = v42.Parent:GetAttribute("Catagory")
            if v44 and v43[v44] then
                local u45 = v39.Stats:FindFirstChild(v44)
                local u46 = u45.Value
                local u47 = false
                local u48 = nil
                u48 = u45.Changed:Connect(function() --[[ Line: 207 ]]
                    --[[
                    Upvalues:
                        [1] = u45
                        [2] = u46
                        [3] = u48
                        [4] = u47
                    --]]
                    if u45.Value ~= u46 then
                        u48:Disconnect()
                        u48 = nil
                        u47 = true
                    end
                end)
                return u48, function() --[[ Line: 215 ]]
                    --[[
                    Upvalues:
                        [1] = u47
                    --]]
                    return u47
                end
            end
        end
    end
end
function u7.DoubleCastSkill(u50, p51, u52) --[[ Line: 222 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u5
        [3] = u23
        [4] = u2
        [5] = u49
    --]]
    local u53 = u4.Character
    local u54 = u52.Key
    local u55 = u52.ToolName
    local u56 = u52.CompleteFunction
    local u57 = u52.CheckFunction or u52.CancelFunction
    local u59 = u52.PassFunction or function() --[[ Line: 228 ]]
        --[[
        Upvalues:
            [1] = u53
            [2] = u55
        --]]
        local v58 = u53:FindFirstChild(u55)
        if v58 then
            v58 = _G.check:inspect(u53) == true
        end
        return v58
    end
    local u60 = u52.Button or p51
    local u61 = u50.Input
    local u62 = u5.new()
    local u63 = nil
    local u64 = nil
    local u65
    if u60 then
        u65 = Color3.fromRGB(255, 255, 255)
        if u52.SkipTap == nil then
            u60.ActionIcon.ImageColor3 = Color3.fromRGB(170, 255, 255)
        else
            u63 = u23(u60)
        end
        if u60.ActionIcon.Image ~= "rbxassetid://17672867931" then
            u64 = u60.ActionIcon.Image
            u60.ActionIcon.Image = "rbxassetid://17672867931"
        end
    else
        u65 = nil
    end
    task.spawn(function() --[[ Line: 253 ]]
        --[[
        Upvalues:
            [1] = u60
            [2] = u62
            [3] = u59
            [4] = u52
            [5] = u2
            [6] = u61
            [7] = u54
            [8] = u56
            [9] = u49
            [10] = u50
            [11] = u57
            [12] = u53
            [13] = u63
            [14] = u65
            [15] = u64
        --]]
        if _G.mobile and u60 then
            u62:AddTask(u60.MouseButton1Click:Connect(function() --[[ Line: 265 ]]
                --[[
                Upvalues:
                    [1] = u59
                    [2] = u52
                    [3] = u60
                    [4] = u62
                    [5] = u2
                    [6] = u61
                    [7] = u54
                --]]
                local v66 = u59()
                if v66 == false or v66 == nil then
                    return
                elseif u52.SkipTap == nil then
                    u60.ActionIcon.ImageColor3 = Color3.fromRGB(255, 255, 255)
                    u60.ActionIcon.Image = "rbxassetid://17714973640"
                    u62:AddTask(u2.TouchTapInWorld:Connect(function(p67, p68) --[[ Line: 276 ]]
                        --[[
                        Upvalues:
                            [1] = u61
                            [2] = u54
                        --]]
                        if not p68 then
                            _G.Mouse:SetPosition(p67)
                            u61:Fire(u54)
                        end
                    end))
                else
                    u61:Fire(u54)
                end
            end))
        else
            u62:AddTask(u2.InputBegan:Connect(function(p69, p70) --[[ Line: 293 ]]
                --[[
                Upvalues:
                    [1] = u54
                    [2] = u61
                --]]
                if not p70 then
                    if p69.KeyCode == u54 then
                        warn("user inpiut tapped")
                        task.defer(function() --[[ Line: 300 ]]
                            --[[
                            Upvalues:
                                [1] = u61
                                [2] = u54
                            --]]
                            u61:Fire(u54)
                        end)
                    end
                end
            end))
        end
        local u71 = false
        local u72 = false
        local v75 = u61:Connect(function(p73) --[[ Line: 323 ]]
            --[[
            Upvalues:
                [1] = u54
                [2] = u59
                [3] = u71
                [4] = u72
                [5] = u56
            --]]
            if p73 == u54 then
                local v74 = u59()
                if v74 ~= nil and v74 ~= false then
                    u71 = true
                    if u72 == true then
                        return
                    end
                    u72 = true
                    if u56 then
                        u56()
                    end
                end
            end
        end)
        local v76 = tick()
        local v77, v78 = u49(u50)
        local v79
        if v77 == nil then
            v79 = u72
        else
            u62:AddTask(v77)
            v79 = u72
        end
        while true do
            local v80 = tick() - v76
            if u71 == true or u57 and u57(v80) == true or v78 ~= nil and v78() == true then
                break
            end
            v76 = tick()
            task.wait()
            if u53:IsDescendantOf(workspace) == false then
                break
            end
        end
        if v75 then
            v75:Disconnect()
        end
        u62:Destroy()
        u62 = nil
        if u60 then
            if u63 then
                u63:Cancel()
                u63:Destroy()
            end
            u60.ActionIcon.ImageColor3 = u65
            if u64 then
                u60.ActionIcon.Image = "rbxassetid://16527536731"
            end
        end
        if v79 ~= true then
            u72 = true
            if u56 then
                u56()
            end
        end
    end)
end
function u7.ToggleSkill(p81, p82, p83) --[[ Line: 387 ]]
    --[[
    Upvalues:
        [1] = u5
        [2] = u49
        [3] = u1
        [4] = u2
    --]]
    local u84 = p83.Key
    local u85 = p83.CheckFunction or function() --[[ Line: 389 ]] end
    local u86 = p83.EndFunction
    local u87 = p83.Button or p82
    local _ = p83.PassFunction
    local u88 = p81.Input
    local u89 = u5.new()
    local v90, v91, v92
    if u87 then
        v90 = u87.ActionIcon.ImageColor3
        v91 = u87.ActionIcon.Image
        u87.ActionIcon.Image = "rbxassetid://17672867931"
        local v93 = {
            ["ImageColor3"] = Color3.fromRGB(255, 85, 0)
        }
        local v94 = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, -1, true, 0)
        v92 = game:GetService("TweenService"):Create(u87.ActionIcon, v94, v93)
        v92:Play()
    else
        v92 = nil
        v91 = nil
        v90 = nil
    end
    local v95, u96 = u49(p81)
    if v95 ~= nil then
        u89:AddTask(v95)
    end
    task.spawn(function() --[[ Line: 418 ]]
        --[[
        Upvalues:
            [1] = u89
            [2] = u1
            [3] = u86
            [4] = u96
            [5] = u85
            [6] = u2
            [7] = u84
            [8] = u88
            [9] = u87
        --]]
        u89:AddTask(u1.RenderStepped:Connect(function(p97) --[[ Line: 421 ]]
            --[[
            Upvalues:
                [1] = u86
                [2] = u96
                [3] = u85
                [4] = u2
                [5] = u84
                [6] = u88
            --]]
            local v98 = u86(p97)
            local v99
            if u96 then
                v99 = u96()
            else
                v99 = false
            end
            if v98 == true or (u85() or not (_G.mobile or u2:IsKeyDown(u84))) or v99 == true then
                u88:Fire(u84)
            end
        end))
        if _G.mobile and u87 then
            task.delay(0.05, function() --[[ Line: 436 ]]
                --[[
                Upvalues:
                    [1] = u89
                    [2] = u87
                    [3] = u88
                    [4] = u84
                --]]
                u89:AddTask(u87.MouseButton1Click:Connect(function() --[[ Line: 438 ]]
                    --[[
                    Upvalues:
                        [1] = u88
                        [2] = u84
                    --]]
                    u88:Fire(u84)
                end))
            end)
        end
    end)
    while u88:Wait() ~= u84 do

    end
    if u87 then
        v92:Cancel()
        v92:Destroy()
        u87.ActionIcon.Image = v91
        u87.ActionIcon.ImageColor3 = v90
    end
    u89:Destroy()
end
function u7.ChargeSkill(u100, u101, u102) --[[ Line: 459 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u5
        [3] = u49
        [4] = u4
        [5] = u10
        [6] = u11
        [7] = u37
    --]]
    local u103 = u102.Key
    u102.CheckFunction = u102.CheckFunction or function() --[[ Line: 461 ]] end
    u102.EndFunction = u102.EndFunction or function() --[[ Line: 462 ]] end
    u102.canUse = u102.canUse == nil and true or u102.canUse
    u102.RunServiceType = u102.RunServiceType or u1.Heartbeat
    if u102.HoldDuration == nil then
        u102.HoldDuration = 0
    end
    local u104 = u102.PCInputType == nil and "Default" or u102.PCInputType
    local u105 = u102.MobileInputType == nil and "Default" or u102.MobileInputType
    local u106 = u5.new()
    local v107
    if u101 then
        v107 = u101.ActionIcon.Image
        u101.ActionIcon.Image = "rbxassetid://17714973640"
    else
        v107 = nil
    end
    local u108 = tick()
    local v109, u110 = u49(u100)
    if v109 ~= nil then
        u106:AddTask(v109)
    end
    local u111 = _G.canuse == false
    local function u116(...) --[[ Line: 495 ]]
        --[[
        Upvalues:
            [1] = u4
            [2] = u102
            [3] = u100
            [4] = u103
            [5] = u10
            [6] = u110
            [7] = u11
            [8] = u111
        --]]
        local v112 = u4.Character
        local u113 = ...
        local u114 = false
        local _, v115 = pcall(function() --[[ Line: 499 ]]
            --[[
            Upvalues:
                [1] = u114
                [2] = u102
                [3] = u113
            --]]
            u114 = u102.CheckFunction(u113)
        end)
        if v115 then
            warn("ERROR:", v115)
        end
        if u102.EndFunction(...) == true or u114 == false then
            u100.Input:Fire(u103)
            return
        elseif u102.IgnoreInstantCastSetting == nil and u10.Settings.InstantCastSkills.Value == true then
            u100.Input:Fire(u103)
            return
        elseif v112 and v112:FindFirstChild("campfireResting") then
            warn("cant fire resting")
            u100.Input:Fire(u103)
            return
        elseif v112 == game.Players.LocalPlayer.Character then
            if v112.Parent == workspace.Effects or u110 and u110() == true then
                u100.Input:Fire(u103)
                return
            elseif u11 == false then
                u100.Input:Fire(u103)
            elseif u102.canUse == true and u111 == true then
                _G.canuse = false
            end
        else
            warn("in efect folder beka")
            u100.Input:Fire(u103)
            return
        end
    end
    local function u117() --[[ Line: 544 ]]
        --[[
        Upvalues:
            [1] = u102
            [2] = u108
        --]]
        if u102.HoldDuration ~= 0 then
            repeat
                task.wait()
            until tick() - u108 >= u102.HoldDuration
        end
    end
    local u118 = false
    task.spawn(function() --[[ Line: 554 ]]
        --[[
        Upvalues:
            [1] = u100
            [2] = u103
            [3] = u118
        --]]
        local v119 = tick()
        while true do
            game["Run Service"].Heartbeat:Wait()
            if tick() - v119 >= 3 then
                break
            end
            v119 = tick()
            if u118 == true then
                return
            end
        end
        local v120 = game.Players.LocalPlayer
        local v121 = (tick() - v119) * 1000
        local v122 = math.floor(v121) / 1000
        v120:Kick("game froze too long, rejoin. froze for " .. tostring(v122))
        u100.Input:Fire(u103)
    end)
    task.spawn(function() --[[ Line: 569 ]]
        --[[
        Upvalues:
            [1] = u106
            [2] = u102
            [3] = u116
            [4] = u117
            [5] = u100
            [6] = u105
            [7] = u104
            [8] = u101
        --]]
        u106.RunServiceCheck = u102.RunServiceType:Connect(u116)
        u117()
        u100["_" .. (_G.mobile and "Mobile" .. u105 or "PC" .. u104)](u100, u102, u106, u101)
    end)
    if _G.mobile == true then
        u37(u100)
    end
    while u100.Input:Wait() ~= u103 do

    end
    u118 = true
    u117()
    u106.RunServiceCheck:Disconnect()
    u116(0)
    u37(u100)
    if u101 then
        u101.ActionIcon.Image = v107
        u101.ActionIcon.ImageColor3 = Color3.fromRGB(255, 255, 255)
    end
    u106:Destroy()
end
function u7._PCDefault(u123, u124, p125) --[[ Line: 595 ]]
    --[[
    Upvalues:
        [1] = u10
        [2] = u1
        [3] = u2
    --]]
    if u124.IgnoreInstantCastSetting == nil and u10.Settings.InstantCastSkills.Value == true then
        u123.Input:Fire(u124.Key)
    else
        p125:AddTask(u1.RenderStepped:Connect(function() --[[ Line: 602 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u124
                [3] = u123
            --]]
            if not u2:IsKeyDown(u124.Key) then
                u123.Input:Fire(u124.Key)
            end
        end))
    end
end
function u7._MobileDefault(u126, p127, u128, u129) --[[ Line: 610 ]]
    --[[
    Upvalues:
        [1] = u10
        [2] = u2
        [3] = u37
        [4] = u4
    --]]
    local u130 = p127.Key
    local _ = p127.CheckFunction
    local _ = p127.EndFunction
    local u131 = false
    if p127.IgnoreInstantCastSetting == nil and u10.Settings.InstantCastSkills.Value == true then
        u126.Input:Fire(u130)
    else
        u128:AddTask(u2.TouchStarted:Connect(function(_, p132) --[[ Line: 623 ]]
            --[[
            Upvalues:
                [1] = u131
            --]]
            if not p132 then
                u131 = true
            end
        end))
        u128:AddTask(u2.TouchEnded:Connect(function(p133, p134) --[[ Line: 632 ]]
            --[[
            Upvalues:
                [1] = u131
                [2] = u37
                [3] = u126
                [4] = u130
            --]]
            if p134 then
                return
            elseif u131 then
                u37(u126, p133.Position)
                u126.Input:Fire(u130)
            end
        end))
        if u129 then
            task.delay(0.05, function() --[[ Line: 652 ]]
                --[[
                Upvalues:
                    [1] = u128
                    [2] = u129
                    [3] = u4
                    [4] = u37
                    [5] = u126
                    [6] = u130
                --]]
                u128:AddTask(u129.MouseButton1Click:Connect(function() --[[ Line: 654 ]]
                    --[[
                    Upvalues:
                        [1] = u4
                        [2] = u37
                        [3] = u126
                        [4] = u130
                    --]]
                    u37(u126, (u4.Character.PrimaryPart.CFrame * CFrame.new(0, 0, 100)).Position, true)
                    u126.Input:Fire(u130)
                end))
            end)
        end
    end
end
function u7._PCToggle(u135, p136, p137) --[[ Line: 671 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local u138 = p136.Key
    p137:AddTask(u2.InputBegan:Connect(function(p139, p140) --[[ Line: 675 ]]
        --[[
        Upvalues:
            [1] = u138
            [2] = u135
        --]]
        if not p140 then
            if p139.KeyCode == u138 then
                u135.Input:Fire(u138)
            end
        end
    end))
end
function u7._MobileToggle(u141, u142, u143) --[[ Line: 687 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    local u144 = u142.Button
    local u145 = u144.ActionIcon.ImageColor3
    local v146 = {
        ["ImageColor3"] = Color3.fromRGB(255, 85, 0)
    }
    local v147 = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, -1, true, 0)
    local u148 = u3:Create(u144.ActionIcon, v147, v146)
    u148:Play()
    u143:AddTask(u148)
    task.delay(0.05, function() --[[ Line: 697 ]]
        --[[
        Upvalues:
            [1] = u143
            [2] = u144
            [3] = u141
            [4] = u142
            [5] = u148
            [6] = u145
        --]]
        u143:AddTask(u144.MouseButton1Click:Connect(function() --[[ Line: 699 ]]
            --[[
            Upvalues:
                [1] = u141
                [2] = u142
                [3] = u148
                [4] = u144
                [5] = u145
            --]]
            u141.Input:Fire(u142.Key)
            u148:Cancel()
            u144.ActionIcon.ImageColor3 = u145
        end))
    end)
end
function u7._MobileTapScreen(u149, u150, p151) --[[ Line: 708 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u37
    --]]
    p151:AddTask(u2.TouchTapInWorld:Connect(function(p152, p153) --[[ Line: 710 ]]
        --[[
        Upvalues:
            [1] = u37
            [2] = u149
            [3] = u150
        --]]
        if not p153 then
            _G.Mouse:SetPosition(p152)
            u37(u149)
            u149.Input:Fire(u150.Key)
        end
    end))
end
return u7