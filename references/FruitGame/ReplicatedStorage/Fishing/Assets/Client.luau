 

local v1 = game:GetService("ReplicatedStorage")
local u2 = game:GetService("UserInputService")
local v3 = game:GetService("Players")
game:GetService("HttpService")
local u4 = game:GetService("TweenService")
local u5 = game:GetService("RunService")
local u6 = game:GetService("ContentProvider")
local u7 = game.GameId == 2097989947
local u8 = Random.new()
local _ = workspace.Effects
local u9 = v1.Fishing
local u10 = u9.Remotes.Action
local u11 = u9.Assets.Animations
local u12 = v3.LocalPlayer
local u13 = u12:WaitForChild("PlayerGui")
u12:GetMouse()
local u14 = v1.Fishing.Assets.SFX.InputSFX
local u15 = v1.Fishing.Assets.UI
local u16 = v1:WaitForChild("Modules")
local v17 = u16:WaitForChild("Shared")
local u18 = require(v17:WaitForChild("GameUtils"))
local u19 = require(v17.Maids.Maid)
local v20 = u16:WaitForChild("Client")
require(v20:WaitForChild("ItemDisplay"))
local u21 = require(v20.UIController)
local u22 = require(v20.Notification)
local u23 = require(v1.Modules.ToolDesc)
local u24 = require(u9.Assets.Bobble)
local u25 = {}
u25.__index = u25
task.spawn(function() --[[ Line: 44 ]]
    --[[
    Upvalues:
        [1] = u6
        [2] = u9
    --]]
    u6:PreloadAsync({ u9.Assets.Animations })
end)
local function u29(p26, p27) --[[ Line: 48 ]]
    --[[
    Upvalues:
        [1] = u23
    --]]
    if u23[p26] ~= nil then
        local v28 = p27:FindFirstChild("RareUIGradient")
        if v28 == nil then
            v28 = Instance.new("UIGradient", p27)
            v28.Name = "RareUIGradient"
        end
        if _G.displayRareItem == nil then
            repeat
                task.wait()
            until _G.displayRareItem
        end
        _G.displayRareItem(p26, v28)
    end
end
function u25.new(p30) --[[ Line: 65 ]]
    --[[
    Upvalues:
        [1] = u25
        [2] = u19
        [3] = u12
        [4] = u15
    --]]
    local v31 = u25
    local v32 = setmetatable({}, v31)
    v32.Cleaner = u19.new()
    v32.Animations = v32:_preloadAnimations()
    v32.Character = u12.Character or u12.CharacterAdded:Wait()
    v32.Tool = p30
    v32.MaxDistance = 300
    v32.ChargeClock = os.clock()
    v32.Bobble = nil
    v32.FishCaught = nil
    v32.Debounce = true
    v32.IsCharging = false
    v32.SelectedBait = "None"
    v32.FishingBaitGui = u15:WaitForChild("FishingBaitGui"):Clone()
    v32:_main()
    return v32
end
function u25._preloadAnimations(_) --[[ Line: 91 ]]
    --[[
    Upvalues:
        [1] = u12
        [2] = u11
    --]]
    local v33 = u12.Character.Humanoid.Animator
    local v34 = {}
    for _, v35 in u11:GetChildren() do
        v34[v35.Name] = v33:LoadAnimation(v35)
    end
    return v34
end
function u25._canDoInputs(p36) --[[ Line: 103 ]]
    --[[
    Upvalues:
        [1] = u12
    --]]
    local v37 = p36.Character
    if p36.Debounce then
        if p36.Tool.Parent == v37 then
            if p36.Bobble == nil then
                if not _G.canuse then
                    return
                end
                if _G.check:inspect(v37) == false then
                    return
                end
            end
            if u12.Character.Humanoid.FloorMaterial ~= Enum.Material.Air then
                return true
            end
        end
    else
        return
    end
end
function u25._play(p38, p39) --[[ Line: 117 ]]
    if p38.Animations[p39].IsPlaying == false then
        p38.Animations[p39]:Play()
    end
    return p38.Animations[p39]
end
function u25._stop(p40, p41) --[[ Line: 124 ]]
    p40.Animations[p41]:Stop()
end
function u25._getAnimation(p42, p43) --[[ Line: 128 ]]
    return p42.Animations[p43]
end
function u25._reelBack(p44, p45) --[[ Line: 132 ]]
    --[[
    Upvalues:
        [1] = u14
        [2] = u8
        [3] = u10
    --]]
    if p44.Debounce then
        if p44.Bobble then
            local v46 = p44.Character
            local v47 = v46.HumanoidRootPart
            u14.FishingBarChargeLoop:Stop()
            u14.FishingBarDrainLoop:Stop()
            p44:_stop("Reel")
            p44:_stop("Throw")
            local u48 = p44:_play("Catch")
            u48:AdjustSpeed(1)
            p44.Cleaner:Destroy()
            local v49 = p44.Bobble
            local v50 = v49.Model
            p44.Bobble = nil
            local v51 = u8:NextNumber(15, 35)
            local v52 = v50.CFrame
            u10:InvokeServer({
                ["Action"] = "HookReturning"
            })
            p44.Debounce = false
            p44.Cleaner:AddTask(task.delay(0.2, function() --[[ Line: 165 ]]
                --[[
                Upvalues:
                    [1] = u48
                --]]
                u48:AdjustSpeed(0.5)
            end))
            local v53 = p44.Tool:FindFirstChild("BobbleSpawn", true)
            local v54 = 0
            local v55 = p45 and 0.65 or 0.25
            while v54 <= 1 do
                local v56 = CFrame.new(v53.WorldPosition, v52.Position) * CFrame.Angles(1.5707963267948966, 0, 0)
                local v57 = v52:Lerp(v56, 0.5) + (not p45 and Vector3.new(-0, -3, -0) or Vector3.new(0, 1, 0) * v51)
                v54 = v54 + game["Run Service"].RenderStepped:Wait() / v55
                local v58 = v52:Lerp(v57, v54):Lerp(v57:Lerp(v56, v54), v54)
                local _ = (CFrame.new(v58.Position, v46.PrimaryPart.Position) * CFrame.new(0, 0, -1000)).Position
                v50.CFrame = CFrame.new(Vector3.new(0, 0, 0), (Vector3.new(0, 1, 0)):Cross(CFrame.new(v58.Position, v47.Position).RightVector)) * CFrame.Angles(-1.5707963267948966, 0, 0) + v58.Position
            end
            u48:AdjustSpeed(1)
            v49:Destroy()
            u10:InvokeServer({
                ["Action"] = "Cancel"
            })
            p44.Debounce = true
            _G.canuse = true
            p44.IsCharging = false
        else
            p44.IsCharging = false
        end
    else
        return
    end
end
function u25._throw(p59) --[[ Line: 198 ]]
    p59.Cleaner:Destroy()
    p59:_getAnimation("Throw"):AdjustSpeed(1)
end
function u25._spawnBobble(p60) --[[ Line: 205 ]]
    --[[
    Upvalues:
        [1] = u10
        [2] = u24
    --]]
    task.wait(0.1)
    local v61 = u10:InvokeServer({
        ["Action"] = "Throw",
        ["Goal"] = _G.MouseCF.p,
        ["Bait"] = p60.SelectedBait
    })
    _G.canuse = true
    p60.IsCharging = false
    if v61 then
        local v62 = p60.Character.Humanoid
        local v63 = p60.Tool:FindFirstChild("BobbleSpawn", true).WorldPosition
        local v64 = _G.MouseCF.p
        local v65 = os.clock() - p60.ChargeClock
        local v66 = math.min(v65, 1.5)
        local v67 = u24.new
        local v68 = {}
        local v69 = (v64 - v63).Unit * 100 * v66
        local v70 = p60.MaxDistance
        if v70 <= v69.Magnitude then
            v69 = v69.Unit * v70
        end
        v68.Velocity = v69
        v68.Client = p60
        p60.Bobble = v67(v68)
        v62.WalkSpeed = 16
    end
end
function u25._reel(_) --[[ Line: 243 ]] end
function u25._charge(u71) --[[ Line: 254 ]]
    --[[
    Upvalues:
        [1] = u22
        [2] = u18
        [3] = u12
    --]]
    if u71.IsCharging == true then
        print("CANT THROW BECAUSE OF CHARGING")
        return
    elseif u71.SelectedBait == "None" then
        u22.DisplayMessage("<Color=Red>Please select a bait!")
        return
    elseif u18.CheckItemAmount(u12, u71.SelectedBait) <= 0 then
        u22.DisplayMessage((("<Color=Red>You do not have any %*!"):format(u71.SelectedBait)))
    else
        u71.IsCharging = true
        local u72 = u71.Character.Humanoid
        u71.Cleaner:AddTask(task.spawn(function() --[[ Name: WindUp, Line 273 ]]
            --[[
            Upvalues:
                [1] = u71
            --]]
            u71.ChargeClock = os.clock()
            local v73 = u71:_play("Throw")
            task.wait(0.43)
            v73:AdjustSpeed(0)
        end))
        u71.Cleaner:AddTask(task.delay(1.5, u71._throw, u71))
        u72.WalkSpeed = 4
        u71.Cleaner:AddTask(u72:GetPropertyChangedSignal("WalkSpeed"):Connect(function() --[[ Name: WalkSpeedChanged, Line 287 ]]
            --[[
            Upvalues:
                [1] = u72
            --]]
            u72.WalkSpeed = 4
        end))
    end
end
function u25._fishCaught(u74) --[[ Line: 298 ]]
    --[[
    Upvalues:
        [1] = u15
        [2] = u13
        [3] = u7
        [4] = u14
        [5] = u2
        [6] = u5
        [7] = u4
        [8] = u10
    --]]
    if u74.Bobble then
        if not u74.Animations.Reel.IsPlaying then
            u74:_play("Reel")
            u74.Velocity = 0
            u74.MaxVelocity = 2
            u74.Acceleration = u74.Tool:GetAttribute("Acceleration")
            u74.Max = 2
            u74.BarPosition = u74.Max * 0.5
            u74.BarRadius = 0.25
            u74.FishTime = 2
            u74.MaxFishTime = 7.5
            u74.GameSeed = u74.Bobble.Model:GetAttribute("Seed")
            u74.GameRNG = Random.new(u74.GameSeed)
            u74.MinigameStartTime = os.clock()
            u74.MinigameUpdateCount = 0
            local u75 = false
            local u76 = true
            local u77 = os.clock()
            local u78 = false
            local u79 = os.clock()
            local u80 = false
            local v81 = u15.FishingUIBill:Clone()
            local v82 = v81.Frame
            local u83 = v82.Player
            local u84 = v82.Goal
            local u85 = v82.Time
            local u86 = u84.icon
            local u87 = u85.Fill.Goal.icon
            local u88 = v82.InfoText
            local v89 = u74.Character
            v81.Frame.Player.Size = UDim2.new(v81.Frame.Player.Size.X.Scale, v81.Frame.Player.Size.X.Offset, u74.BarRadius, 0)
            v81.Adornee = v89.PrimaryPart
            v81.Enabled = true
            v81.Parent = u13
            u74.Cleaner.UI = v81
            u74.UpdateClock = os.clock()
            local v90
            if u74.Bobble then
                v90 = u74.GameRNG:NextNumber(1, 3) / (u74.Bobble.Model:GetAttribute("MoveMultiplier") or 1)
            else
                u74:_reelBack()
                v90 = nil
            end
            u74.UpdateTime = v90
            if u7 then
                warn((("CLIENT Initial - UpdateTime: %*, Acceleration: %*, MoveMultiplier: %*"):format(u74.UpdateTime, u74.Acceleration, u74.Bobble.Model:GetAttribute("MoveMultiplier") or 1)))
            end
            u74.Cleaner.InputBeganMobile = u2.InputBegan:Connect(function(p91, p92) --[[ Line: 375 ]]
                --[[
                Upvalues:
                    [1] = u75
                    [2] = u14
                --]]
                if not p92 then
                    if p91.UserInputType == Enum.UserInputType.Touch then
                        u75 = true
                        u14.FishingClick:Play()
                    end
                end
            end)
            u74.Cleaner.InputEndedMobile = u2.InputEnded:Connect(function(p93, p94) --[[ Line: 384 ]]
                --[[
                Upvalues:
                    [1] = u75
                    [2] = u14
                --]]
                if not p94 then
                    if p93.UserInputType == Enum.UserInputType.Touch then
                        u75 = false
                        u14.FishingUnclick:Play()
                    end
                end
            end)
            if _G.mobile ~= true then
                u74.Cleaner.InputBegan = u74.Tool.Activated:Connect(function() --[[ Line: 394 ]]
                    --[[
                    Upvalues:
                        [1] = u75
                        [2] = u14
                    --]]
                    u75 = true
                    u14.FishingClick:Play()
                end)
                u74.Cleaner.InputEnded = u74.Tool.Deactivated:Connect(function() --[[ Line: 398 ]]
                    --[[
                    Upvalues:
                        [1] = u75
                        [2] = u14
                    --]]
                    u75 = false
                    u14.FishingUnclick:Play()
                end)
            end
            local u95 = u84.icon.ImageColor3
            local u96 = nil
            local u97 = u84.Position
            local u98 = nil
            local u99 = nil
            local u100 = nil
            local u101 = nil
            local u102 = nil
            local _ = u7 == false
            local u103 = false
            u74.Cleaner.Update = u5.RenderStepped:Connect(function(p104) --[[ Line: 423 ]]
                --[[
                Upvalues:
                    [1] = u74
                    [2] = u75
                    [3] = u96
                    [4] = u7
                    [5] = u99
                    [6] = u97
                    [7] = u100
                    [8] = u101
                    [9] = u102
                    [10] = u98
                    [11] = u4
                    [12] = u84
                    [13] = u83
                    [14] = u103
                    [15] = u76
                    [16] = u14
                    [17] = u86
                    [18] = u77
                    [19] = u78
                    [20] = u79
                    [21] = u80
                    [22] = u87
                    [23] = u95
                    [24] = u88
                    [25] = u85
                    [26] = u10
                --]]
                local v105 = u74
                local v106 = u74.Velocity + (u75 and -u74.Acceleration or u74.Acceleration) * p104
                local v107 = -u74.MaxVelocity
                local v108 = u74.MaxVelocity
                v105.Velocity = math.clamp(v106, v107, v108)
                if u74.Velocity > 0 and u74.BarPosition == u74.Max - u74.BarRadius or u74.Velocity < 0 and u74.BarPosition == u74.BarRadius then
                    u74.Velocity = 0
                end
                local v109 = u74
                local v110 = u74.BarPosition + u74.Velocity * p104
                local v111 = u74.BarRadius
                local v112 = u74.Max - u74.BarRadius
                v109.BarPosition = math.clamp(v110, v111, v112)
                u96 = UDim2.fromScale(0.5, u74.BarPosition / u74.Max)
                if os.clock() - u74.UpdateClock >= u74.UpdateTime then
                    u74.MinigameUpdateCount = u74.MinigameUpdateCount + 1
                    u74.UpdateClock = os.clock()
                    local v113 = u74
                    local v114
                    if u74.Bobble then
                        v114 = u74.GameRNG:NextNumber(1, 3) / (u74.Bobble.Model:GetAttribute("MoveMultiplier") or 1)
                    else
                        u74:_reelBack()
                        v114 = nil
                    end
                    v113.UpdateTime = v114
                    if u74.MinigameUpdateCount <= 5 and u7 then
                        warn((("CLIENT Update %* - NewUpdateTime: %*"):format(u74.MinigameUpdateCount, u74.UpdateTime)))
                    end
                    u99 = u97
                    u100 = UDim2.fromScale(0.5, u74.GameRNG:NextNumber())
                    u101 = os.clock()
                    u102 = u74.UpdateTime / 2
                    u98 = u4:Create(u84, TweenInfo.new(u74.UpdateTime / 2), {
                        ["Position"] = UDim2.fromScale(0.5, u74.GameRNG:NextNumber())
                    })
                end
                if u98 and u99 then
                    local v115 = (os.clock() - u101) / u102
                    local v116 = u4:GetValue(math.clamp(v115, 0, 1), u98.TweenInfo.EasingStyle, u98.TweenInfo.EasingDirection)
                    u97 = UDim2.new(u99.X.Scale + (u100.X.Scale - u99.X.Scale) * v116, u99.X.Offset + (u100.X.Offset - u99.X.Offset) * v116, u99.Y.Scale + (u100.Y.Scale - u99.Y.Scale) * v116, u99.Y.Offset + (u100.Y.Offset - u99.Y.Offset) * v116)
                end
                u84.Position = u97
                u83.Position = u96
                if u103 == true then
                    local v117 = u83.Position.Y.Scale
                    local v118 = u84.Position.Y.Scale
                    local v119 = v118 - v117
                    local v120 = u74.Velocity / u74.Max
                    if u74.BarRadius / 2 / u74.Max >= math.abs(v119) then
                        local v121 = v118 - (v117 + v120 * 0.1)
                        if v121 > 0.01 then
                            u75 = false
                        elseif v121 < -0.01 then
                            u75 = true
                        end
                    else
                        local v122 = math.abs(v120) / (u74.Acceleration / u74.Max)
                        local v123 = v118 - (v117 + (v120 * v122 - 0.5 * (u74.Acceleration / u74.Max) * v122 * v122 * (v120 > 0 and 1 or -1)))
                        if v119 > 0 then
                            if v123 > 0.02 then
                                u75 = false
                            else
                                u75 = true
                            end
                        elseif v123 < -0.02 then
                            u75 = true
                        else
                            u75 = false
                        end
                    end
                end
                local v124 = u96.Y.Scale - u97.Y.Scale
                local v125 = math.abs(v124) <= u74.BarRadius / 2
                if p104 >= 0.2 then
                    v125 = false
                end
                local v126 = u74
                local v127 = u74.FishTime + p104 * (v125 and 1 or -0.75)
                local v128 = u74.MaxFishTime
                v126.FishTime = math.clamp(v127, 0, v128)
                if v125 then
                    if u76 then
                        u76 = false
                        u14.FishingBarOnTarget:Play()
                        u14.FishingBarChargeLoop:Play()
                        u14.FishingBarDrainLoop:Stop()
                        u4:Create(u86, TweenInfo.new(0.25), {
                            ["ImageColor3"] = Color3.fromRGB(172, 255, 127)
                        }):Play()
                    end
                    if os.clock() - u77 >= 0.1 then
                        u77 = os.clock()
                        u78 = not u78
                        u86.Image = u78 and "rbxassetid://86151972586326" or "rbxassetid://126419334589592"
                    end
                    if os.clock() - u79 >= 0.15 then
                        u79 = os.clock()
                        u80 = not u80
                        u87.Image = u80 and "rbxassetid://77450437735760" or "rbxassetid://106397882099629"
                    end
                elseif not u76 then
                    u76 = true
                    u14.FishingBarOffTarget:Play()
                    u14.FishingBarChargeLoop:Stop()
                    u14.FishingBarDrainLoop:Play()
                    local v129 = {
                        ["ImageColor3"] = u95
                    }
                    u4:Create(u86, TweenInfo.new(0.5), v129):Play()
                    u86.Image = "rbxassetid://126419334589592"
                    u87.Image = "rbxassetid://106397882099629"
                end
                u88.Text = v125 and "" or (u96.Y.Scale > u97.Y.Scale and "HOLD CLICK" or "RELEASE CLICK")
                local v130 = u74.FishTime / u74.MaxFishTime
                local v131 = math.clamp(v130, 0, 1)
                u85.Fill.Size = UDim2.new(u85.Fill.Size.X.Scale, u85.Fill.Size.X.Offset, v131, 0)
                if v131 == 0 then
                    u74:_reelBack()
                elseif v131 >= 1 then
                    local v132 = os.clock() - u74.MinigameStartTime
                    if u7 then
                        warn((("CLIENT COMPLETED - Updates: %*, Time: %*s, Seed: %*"):format(u74.MinigameUpdateCount, v132, u74.GameSeed)))
                    end
                    if u10:InvokeServer({
                        ["Action"] = "Reel"
                    }) then
                        u74:_reelBack(true)
                        return
                    end
                    u74:_reelBack()
                end
            end)
        end
    else
        return
    end
end
function u25._animationHandler(u133) --[[ Line: 607 ]]
    local u134 = u133:_getAnimation("Idle")
    local u135 = u133.Character
    local u136 = u135.Humanoid
    u133.Tool.Equipped:Connect(function() --[[ Name: Equipped, Line 648 ]]
        --[[
        Upvalues:
            [1] = u136
            [2] = u133
            [3] = u135
            [4] = u134
        --]]
        if u136.MoveDirection.Magnitude > 0 or u133.Tool.Parent ~= u135 then
            if u134.IsPlaying then
                u134:Stop()
                u133:_reelBack()
            end
        elseif u134.IsPlaying == false then
            u134:Play()
            return
        end
    end)
    u133.Tool.Unequipped:Connect(function() --[[ Name: Unequipped, Line 652 ]]
        --[[
        Upvalues:
            [1] = u136
            [2] = u133
            [3] = u135
            [4] = u134
        --]]
        if u136.MoveDirection.Magnitude > 0 or u133.Tool.Parent ~= u135 then
            if u134.IsPlaying then
                u134:Stop()
                u133:_reelBack()
            end
        elseif u134.IsPlaying == false then
            u134:Play()
            return
        end
    end)
    u136:GetPropertyChangedSignal("MoveDirection"):Connect(function() --[[ Name: OnMovement, Line 612 ]]
        --[[
        Upvalues:
            [1] = u136
            [2] = u133
            [3] = u135
            [4] = u134
        --]]
        if u136.MoveDirection.Magnitude > 0 or u133.Tool.Parent ~= u135 then
            if u134.IsPlaying then
                u134:Stop()
                u133:_reelBack()
            end
        elseif u134.IsPlaying == false then
            u134:Play()
            return
        end
    end)
    game["Run Service"].Heartbeat:Connect(function() --[[ Name: floor, Line 628 ]]
        --[[
        Upvalues:
            [1] = u133
            [2] = u135
            [3] = u134
            [4] = u136
        --]]
        if u133.Tool.Parent == u135 then
            if u136.FloorMaterial == Enum.Material.Air then
                if u134.IsPlaying == true then
                    u134:Stop()
                    return
                end
            elseif u134.IsPlaying == false and u136.MoveDirection == Vector3.new() then
                u134:Play()
            end
        elseif u134.IsPlaying == true then
            u134:Stop()
        end
    end)
end
function u25._main(u137) --[[ Line: 665 ]]
    --[[
    Upvalues:
        [1] = u12
        [2] = u21
        [3] = u16
        [4] = u15
        [5] = u18
        [6] = u29
        [7] = u13
        [8] = u14
        [9] = u10
        [10] = u2
    --]]
    if _G.layoutMulti == nil then
        repeat
            task.wait()
        until _G.layoutMulti
    end
    if _G.ToolDesc == nil then
        repeat
            task.wait()
        until _G.ToolDesc
    end
    u137:_animationHandler()
    local v138 = u12.Character
    local u139 = v138:WaitForChild("Humanoid")
    local u140 = v138:WaitForChild("HumanoidRootPart")
    task.spawn(function() --[[ Line: 682 ]]
        --[[
        Upvalues:
            [1] = u137
            [2] = u21
            [3] = u16
            [4] = u15
            [5] = u18
            [6] = u12
            [7] = u29
        --]]
        local u141 = {}
        local u142 = u137.FishingBaitGui:WaitForChild("Main"):WaitForChild("List")
        local v143 = u21:GetStatsFolder():WaitForChild("Inventory"):WaitForChild("Inventory")
        local u144 = require(u16.Blueprints["Fish Baits"])
        local function v159() --[[ Line: 694 ]]
            --[[
            Upvalues:
                [1] = u144
                [2] = u141
                [3] = u15
                [4] = u18
                [5] = u12
                [6] = u142
                [7] = u29
                [8] = u137
            --]]
            for u145, _ in pairs(u144) do
                local u146 = u141[u145] or u15:WaitForChild("BaitTemplate"):Clone()
                if u141[u145] == nil and _G.HasItem(u12, u145) == true then
                    u146.Name = u145
                    u146.LayoutOrder = _G.layoutMulti[_G.ToolDesc[u145].Rare]
                    u146.Parent = u142
                    u141[u145] = u146
                    local v147 = nil
                    local v148 = nil
                    if v148 == nil then
                        v148 = u145
                    end
                    local v149 = u18.CheckItemAmount(u12, v148)
                    if v147 == nil then
                        v147 = u146
                    end
                    v147.Item.Text = v148
                    v147.ItemCount.Text = ("x%*"):format(v149)
                    u29(u145, u146.Item)
                    u146.MouseButton1Click:Connect(function() --[[ Line: 720 ]]
                        --[[
                        Upvalues:
                            [1] = u137
                            [2] = u145
                            [3] = u141
                            [4] = u18
                            [5] = u12
                            [6] = u146
                        --]]
                        if not u137.Bobble then
                            if u137.SelectedBait ~= u145 and u141[u137.SelectedBait] then
                                local v150 = u141[u137.SelectedBait]
                                local v151 = u137.SelectedBait
                                if v151 == nil then
                                    v151 = u145
                                end
                                local v152 = u18.CheckItemAmount(u12, v151)
                                if v150 == nil then
                                    v150 = u146
                                end
                                v150.Item.Text = v151
                                v150.ItemCount.Text = ("x%*"):format(v152)
                                u141[u137.SelectedBait].backGroundSelect.Visible = false
                            end
                            u137.SelectedBait = u145
                            local v153 = nil
                            local v154 = nil
                            if v154 == nil then
                                v154 = u145
                            end
                            local v155 = u18.CheckItemAmount(u12, v154)
                            if v153 == nil then
                                v153 = u146
                            end
                            v153.Item.Text = v154
                            v153.ItemCount.Text = ("x%*"):format(v155)
                            u146.backGroundSelect.Visible = true
                        end
                    end)
                end
                if _G.HasItem(u12, u145) == false and u146 ~= nil then
                    u146:Destroy()
                    u141[u145] = nil
                else
                    local v156 = nil
                    local v157 = nil
                    if v157 == nil then
                        v157 = u145
                    end
                    local v158 = u18.CheckItemAmount(u12, v157)
                    if v156 == nil then
                        v156 = u146
                    end
                    v156.Item.Text = v157
                    v156.ItemCount.Text = ("x%*"):format(v158)
                    if u137.SelectedBait == u145 then
                        u146.Item.Text = u145
                        u146.backGroundSelect.Visible = true
                    else
                        u146.Item.Text = u145
                        u146.backGroundSelect.Visible = false
                    end
                end
            end
        end
        v143:GetPropertyChangedSignal("Value"):Connect(v159)
        v159()
    end)
    local function v161() --[[ Line: 769 ]]
        --[[
        Upvalues:
            [1] = u137
            [2] = u13
            [3] = u14
        --]]
        u137.FishingBaitGui.Parent = u13
        for _, v160 in u14:GetChildren() do
            v160:Stop()
        end
    end
    local function v164() --[[ Line: 777 ]]
        --[[
        Upvalues:
            [1] = u137
            [2] = u10
            [3] = u139
            [4] = u14
        --]]
        u137.IsCharging = false
        u137.FishingBaitGui.Parent = script
        for _, v162 in u137.Animations do
            v162:Stop()
        end
        u137.Cleaner:Destroy()
        if u137.Bobble then
            _G.canuse = true
            u137.Bobble:Destroy()
            u137.Bobble = nil
        end
        u10:InvokeServer({
            ["Action"] = "Cancel"
        })
        u137.Debounce = true
        u137.FishCaught = nil
        u139.WalkSpeed = 16
        for _, v163 in u14:GetChildren() do
            v163:Stop()
        end
    end
    local function v166(p165) --[[ Line: 807 ]]
        --[[
        Upvalues:
            [1] = u137
        --]]
        if p165 == "Throw" then
            u137:_spawnBobble()
        end
    end
    local function u169(p167, p168) --[[ Line: 813 ]]
        --[[
        Upvalues:
            [1] = u137
        --]]
        if p168 then
            return
        elseif u137:_canDoInputs() then
            if p167 == "force" or p167.UserInputType == Enum.UserInputType.MouseButton1 then
                if u137.Bobble and u137.FishCaught then
                    u137:_reel()
                    print("reel")
                    return
                elseif u137.Bobble then
                    u137:_reelBack()
                    print("test")
                else
                    u137:_charge()
                    print("charge")
                end
            else
                return
            end
        else
            return
        end
    end
    local function v171() --[[ Line: 844 ]]
        --[[
        Upvalues:
            [1] = u137
            [2] = u140
        --]]
        while task.wait() do
            if u137.Bobble then
                local v170 = u137.Bobble.Model
                if (u140.Position - v170.Position).Magnitude >= u137.MaxDistance then
                    u137:_reelBack()
                end
            end
        end
    end
    u137.Tool.Activated:Connect(function() --[[ Line: 861 ]]
        --[[
        Upvalues:
            [1] = u169
        --]]
        u169("force")
    end)
    u137.Tool.Deactivated:Connect(function() --[[ Line: 865 ]]
        --[[
        Upvalues:
            [1] = u137
        --]]
        if not u137.Bobble then
            u137:_throw()
        end
    end)
    if _G.mobile == true then
        u2.TouchStarted:Connect(function(p172, p173) --[[ Line: 870 ]]
            --[[
            Upvalues:
                [1] = u169
            --]]
            if p173 then
                return
            elseif not _G.nearThumbstick or _G.nearThumbstick(p172.Position, true) ~= true then
                u169("force")
            end
        end)
        u2.TouchEnded:Connect(function(_, p174) --[[ Line: 880 ]]
            --[[
            Upvalues:
                [1] = u137
            --]]
            if not p174 then
                if not u137.Bobble then
                    u137:_throw()
                end
            end
        end)
    end
    u137:_getAnimation("Throw").KeyframeReached:Connect(v166)
    u137.Tool.Unequipped:Connect(v164)
    u137.Tool.Equipped:Connect(v161)
    task.spawn(v171)
end
return u25