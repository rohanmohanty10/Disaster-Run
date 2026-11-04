 

local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
local v3 = v1.Modules.Client
local v4 = require(v3.ItemDisplay)
local v5 = v3.Managers
local u6 = require(v5.ReplicaClientManager)
local u7 = v2.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("DailyRewards")
local u8 = u7:WaitForChild("Main")
local v9 = u8:WaitForChild("Contents")
local u10 = v9:WaitForChild("NextDayTimerText")
local u11 = v9:WaitForChild("Rewards")
local v12 = v9:WaitForChild("Timer")
local u13 = v12:WaitForChild("TimerText")
local u14 = v12:WaitForChild("TimerBar")
local u15 = u8:WaitForChild("TotalLogins"):WaitForChild("Logins")
local u16 = v9:WaitForChild("NotReady")
local u17 = v9:WaitForChild("Claim")
local u18 = v1:WaitForChild("Remotes").DailyRewards
local u19 = v4.new({
    ["Gui"] = u7
})
task.spawn(function() --[[ Line: 42 ]]
    --[[
    Upvalues:
        [1] = u8
        [2] = u18
    --]]
    for _, u20 in u8:WaitForChild("ModMenu"):GetChildren() do
        if u20:IsA("ImageButton") then
            u20.MouseButton1Down:Connect(function() --[[ Line: 49 ]]
                --[[
                Upvalues:
                    [1] = u18
                    [2] = u20
                --]]
                u18:FireServer(u20.Name)
            end)
        end
    end
end)
local function u30(p21, p22) --[[ Line: 59 ]]
    --[[
    Upvalues:
        [1] = u11
        [2] = u19
    --]]
    for v23, v24 in ipairs(p21) do
        local v25 = u11[("Day%*"):format(v23)]
        local v26 = v25.Claimed
        local v27 = v25.Locked
        v26.Visible = v24.State == "Claimed"
        v27.Visible = v24.State == "Locked"
        if p22 then
            local v28 = v25.Items
            local _ = v25.Title
            if #v24.Items == 1 then
                v25.ImageTransparency = 1
                v28.UIGridLayout.CellSize = UDim2.new(1, 0, 1, 0)
                v28.ScrollingEnabled = false
                v28.ScrollBarImageTransparency = 1
            else
                v28.UIGridLayout.VerticalAlignment = Enum.VerticalAlignment.Top
                v28.UIGridLayout.CellSize = UDim2.new(0.75, 0, 0.75, 0)
            end
            for _, v29 in v24.Items do
                u19:AddItem(v28, v29.Name, v29.Amount)
            end
        end
    end
end
local u31 = nil
local u32 = nil
local u33 = 600
local u34 = Color3.fromRGB(170, 255, 127)
local u35 = Color3.fromRGB(85, 170, 0)
local u36 = Color3.fromRGB(53, 53, 53)
local u37 = Color3.fromRGB(68, 68, 68)
local function u60(p38) --[[ Line: 144 ]]
    --[[
    Upvalues:
        [1] = u33
        [2] = u32
        [3] = u13
        [4] = u14
        [5] = u34
        [6] = u35
        [7] = u36
        [8] = u37
        [9] = u16
        [10] = u17
    --]]
    if u33 == nil then
        return
    else
        u32 = p38 or u32
        if u32 == nil then
            return
        else
            local v39 = os.time() - u32
            local v40 = u33
            local v41 = math.clamp(v39, 0, v40)
            local v42 = u33 - v41
            local v43 = u33
            local v44 = math.clamp(v42, 0, v43)
            local v45 = v44 / 3600
            local v46 = math.floor(v45)
            local v47 = v44 % 3600 / 60
            local v48 = math.floor(v47)
            local v49 = v44 % 60
            local v50
            if v46 > 0 then
                v50 = string.format("%02d:%02d:%02d", v46, v48, v49)
            else
                v50 = string.format("%02d:%02d", v48, v49)
            end
            local v51 = v41 / u33
            local v52 = math.clamp(v51, 0, 1)
            u13.Text = v50
            if v52 == 1 then
                u14.UIGradient.Color = ColorSequence.new(u35)
                u33 = nil
                u16.Visible = false
                u17.Visible = true
            else
                local v53 = u14.UIGradient
                local v54 = ColorSequence.new
                local v55 = {}
                local v56 = ColorSequenceKeypoint.new(0, u34)
                local v57 = ColorSequenceKeypoint.new(math.min(v52, 0.98), u35)
                local v58 = ColorSequenceKeypoint.new
                local v59 = v52 + 0.05
                __set_list(v55, 1, {v56, v57, v58(math.min(0.99, v59), u36), ColorSequenceKeypoint.new(1, u37)})
                v53.Color = v54(v55)
                u16.Visible = true
                u17.Visible = false
            end
        end
    end
end
local function u69(p61) --[[ Line: 179 ]]
    --[[
    Upvalues:
        [1] = u31
        [2] = u10
        [3] = u60
        [4] = u19
    --]]
    if u31 and coroutine.status(u31) ~= "dead" then
        task.cancel(u31)
        u31 = nil
    end
    if p61 then
        u31 = task.spawn(function() --[[ Line: 185 ]]
            --[[
            Upvalues:
                [1] = u10
                [2] = u60
            --]]
            while task.wait(1) do
                local v62 = os.date("!*t")
                local v63 = 86400 - (v62.hour * 3600 + v62.min * 60 + v62.sec)
                local v64 = v63 / 3600
                local v65 = math.floor(v64)
                local v66 = v63 % 3600 / 60
                local v67 = math.floor(v66)
                local v68 = v63 % 60
                u10.Text = ("%* %* %* seconds til tomorrow!"):format(v65 > 0 and v65 .. " hours" or "", v67 > 0 and v67 .. " minutes and" or "", v68)
                u60()
            end
        end)
        u19:StartRotation()
    else
        u19:StopRotation()
    end
end
return {
    ["Initialize"] = function() --[[ Name: Initialize, Line 203 ]]
        --[[
        Upvalues:
            [1] = u6
            [2] = u15
            [3] = u33
            [4] = u60
            [5] = u19
            [6] = u30
            [7] = u11
            [8] = u69
            [9] = u7
            [10] = u17
            [11] = u18
        --]]
        local v70 = u6:GetPlayerDataReplica()
        local u71 = v70.Data
        local u72 = u71.DailyRewards.RewardKey
        u15.Text = ("LOGIN STREAK: %*"):format(u71.DailyRewards.LoginStreak)
        v70:OnSet({ "DailyRewards", "LoginStreak" }, function(p73, _) --[[ Line: 217 ]]
            --[[
            Upvalues:
                [1] = u15
            --]]
            u15.Text = ("LOGIN STREAK: %*"):format(p73)
        end)
        v70:OnSet({ "DailyRewards", "JoinedTime" }, function(p74, _) --[[ Line: 221 ]]
            --[[
            Upvalues:
                [1] = u33
                [2] = u60
            --]]
            u33 = 600
            u60(p74)
        end)
        v70:OnSet({ "DailyRewards", "Rewards" }, function(p75, p76) --[[ Line: 260 ]]
            --[[
            Upvalues:
                [1] = u71
                [2] = u72
                [3] = u33
                [4] = u19
                [5] = u30
            --]]
            print("Entity Rewards Upated with Key:", u71.DailyRewards.RewardKey, p75, p76)
            local v77
            if u72 == u71.DailyRewards.RewardKey then
                v77 = false
            else
                u33 = 600
                u19:RemoveAllItems()
                u72 = u71.DailyRewards.RewardKey
                v77 = true
            end
            u30(p75, v77)
        end)
        u60(u71.DailyRewards.JoinedTime)
        local v78 = u71.DailyRewards.Rewards
        for v79, v80 in ipairs(v78) do
            local v81 = u11[("Day%*"):format(v79)]
            local v82 = v81.Claimed
            local v83 = v81.Locked
            v82.Visible = v80.State == "Claimed"
            v83.Visible = v80.State == "Locked"
        end
        for v84, v85 in u71.DailyRewards.Rewards do
            local v86 = u11:WaitForChild((("Day%*"):format(v84)))
            local v87 = v86.Items
            v86.Title.Text = ("DAY %*"):format(v84)
            if #v85.Items == 1 then
                v86.ImageTransparency = 1
                v87.UIGridLayout.CellSize = UDim2.new(1, 0, 1, 0)
                v87.ScrollingEnabled = false
                v87.ScrollBarImageTransparency = 1
            else
                v87.UIGridLayout.VerticalAlignment = Enum.VerticalAlignment.Top
                v87.UIGridLayout.CellSize = UDim2.new(0.75, 0, 0.75, 0)
            end
            for _, v88 in v85.Items do
                u19:AddItem(v87, v88.Name, v88.Amount)
            end
        end
        u69(u7.Enabled)
        u7:GetPropertyChangedSignal("Enabled"):Connect(function() --[[ Line: 305 ]]
            --[[
            Upvalues:
                [1] = u69
                [2] = u7
            --]]
            u69(u7.Enabled)
        end)
        local u89 = os.clock()
        u17.MouseButton1Down:Connect(function() --[[ Line: 311 ]]
            --[[
            Upvalues:
                [1] = u89
                [2] = u18
            --]]
            if os.clock() - u89 >= 1 then
                u89 = os.clock()
                u18:FireServer()
            end
        end)
    end
}