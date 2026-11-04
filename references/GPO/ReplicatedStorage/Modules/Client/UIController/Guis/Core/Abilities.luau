 

local v1 = game:GetService("Players")
local u2 = game:GetService("ReplicatedStorage")
local u3 = game:GetService("HttpService")
local u4 = game:GetService("UserInputService")
local u5 = v1.LocalPlayer
local u6 = u5:WaitForChild("PlayerGui")
local u7 = u2:WaitForChild("Modules")
require(u7.Trove)
local u8 = require(u7.Skills)
local v9 = u7.Shared
require(v9.GameUtils)
local u10 = require(v9.Queues.QueueTask)
local u11 = require(v9.Signals.GoodSignal)
u2:WaitForChild("Events")
u8.Moves = {}
local v12 = 0
local u13 = {
    ["Initialized"] = false
}
for _, v14 in pairs(u8.Skills) do
    for v15, v16 in pairs(v14) do
        u8.Moves[v15] = v16
    end
    v12 = v12 + 1
    if v12 == 5 then
        task.wait()
        v12 = 0
    end
end
function u8.GetMoveData(p17) --[[ Line: 41 ]]
    --[[
    Upvalues:
        [1] = u8
    --]]
    return u8.Moves[p17]
end
local u18 = {
    ["Ope-Ope Surgeon Mode"] = "Ope-Ope",
    ["Gomu-Gomu Gear 2"] = "Gomu-Gomu",
    ["Buddha-Buddha Full Form"] = "Buddha-Buddha",
    ["Buddha-Buddha Half Form"] = "Buddha-Buddha",
    ["Venom Demon"] = "Venom-Venom",
    ["Tori-Tori Transformed"] = "Tori-Tori",
    ["BlackLegD"] = "BlackLeg",
    ["Pteranodon-Pteranodon Hybrid Form"] = "Pteranodon-Pteranodon",
    ["Pteranodon-Pteranodon Full Form"] = "Pteranodon-Pteranodon",
    ["Dragon-Dragon Full Form"] = "Dragon-Dragon",
    ["Dragon-Dragon Half Form"] = "Dragon-Dragon",
    ["Soul-Soul: Prometheus"] = "Soul-Soul",
    ["Soul-Soul: Prometheus RAGE"] = "Soul-Soul",
    ["Soul-Soul: Zeus"] = "Soul-Soul",
    ["Soul-Soul: Zeus RAGE"] = "Soul-Soul",
    ["Soul-Soul: Soul Summon"] = "Soul-Soul"
}
function u13.Initialize(u19) --[[ Line: 69 ]]
    --[[
    Upvalues:
        [1] = u13
        [2] = u5
        [3] = u2
        [4] = u6
        [5] = u10
        [6] = u3
        [7] = u8
        [8] = u18
        [9] = u11
        [10] = u4
        [11] = u7
    --]]
    if not u13.Initialized then
        local v20 = u5:WaitForChild("PlayerScripts")
        local u21 = require(v20:WaitForChild("InputHandler"))
        local u22 = require(u2.Modules.ContextActionService)
        local u23 = u19:GetStatsFolder()
        u23:WaitForChild("Stats")
        u23:WaitForChild("Skills")
        local u24 = u6:WaitForChild("Abilities", 360)
        local u25 = u24:WaitForChild("Main")
        local u26 = u25:WaitForChild("List")
        local u27 = u26:WaitForChild("Title")
        local u28 = u26:WaitForChild("ModeBar")
        local u29 = u25:WaitForChild("Toggle")
        local u30 = u26:WaitForChild("MasteryBar")
        local u31 = u30:WaitForChild("Base"):WaitForChild("Bar"):WaitForChild("Fill")
        u13.QueueTask = u10.new()
        local u32 = {}
        local u33 = {}
        local u34 = {}
        local u35 = {}
        local u36 = {}
        local u37 = {}
        local u38 = Color3.fromRGB(255, 0, 0)
        local u39 = nil
        local function u48(p40, p41) --[[ Line: 118 ]]
            p40.CD.Text = p41
            local v42 = tick()
            while tick() - v42 < p41 do
                local v43 = p40.CD
                local v44 = (p41 - (tick() - v42)) * 10
                local v45
                if v44 >= 0 then
                    local v46 = v44 + 0.5
                    v45 = math.floor(v46)
                else
                    local v47 = v44 - 0.5
                    v45 = math.ceil(v47)
                end
                v43.Text = v45 / 10
                task.wait(0.1)
            end
            if p40 then
                p40.CD.Text = ""
            end
        end
        function u13.UpdateSkillCooldown(_, u49, u50, _) --[[ Line: 133 ]]
            --[[
            Upvalues:
                [1] = u21
                [2] = u35
                [3] = u37
                [4] = u34
                [5] = u26
                [6] = u24
                [7] = u3
                [8] = u38
            --]]
            local v51 = u21:GetCurrentInput()
            if u35[u49] == nil then
                u35[u49] = {
                    ["CooldownTime"] = u50,
                    ["StartTime"] = os.clock(),
                    ["EndTime"] = os.clock() + u50
                }
                task.delay(u50, function() --[[ Line: 146 ]]
                    --[[
                    Upvalues:
                        [1] = u35
                        [2] = u49
                    --]]
                    u35[u49] = nil
                end)
            end
            if v51 == "Mobile" then
                task.spawn(function() --[[ Line: 153 ]]
                    --[[
                    Upvalues:
                        [1] = u37
                        [2] = u49
                        [3] = u50
                    --]]
                    for v52 = 1, #u37 do
                        if u37[v52].Name == u49 then
                            local v53 = u37[v52]
                            print(v53, u50)
                            v53.CD.Text = u50
                            local v54 = tick()
                            while tick() - v54 < u50 do
                                local v55 = v53.CD
                                local v56 = (u50 - (tick() - v54)) * 10
                                local v57
                                if v56 >= 0 then
                                    local v58 = v56 + 0.5
                                    v57 = math.floor(v58)
                                else
                                    local v59 = v56 - 0.5
                                    v57 = math.ceil(v59)
                                end
                                v55.Text = v57 / 10
                                task.wait(0.1)
                            end
                            if v53 then
                                v53.CD.Text = ""
                                return
                            end
                            break
                        end
                    end
                end)
                return
            else
                if u34[u49] == nil then
                    u34[u49] = {
                        ["SkillFrame"] = nil
                    }
                end
                local u60 = u34[u49]
                local u61 = u49 == "Block" and u26:FindFirstChild("Block")
                if not u61 then
                    if u60 then
                        u61 = u60.SkillFrame or nil
                    else
                        u61 = nil
                    end
                end
                if u61 and u61:IsDescendantOf(u24) == false or u61 == nil then
                    local v62 = u26:FindFirstChild(u49)
                    if v62 then
                        u61 = v62
                        if u60 then
                            u60.SkillFrame = u61
                        end
                    end
                end
                if u60.CooldownData == nil then
                    u60.CooldownData = {
                        ["CooldownTime"] = u50,
                        ["StartTime"] = os.clock(),
                        ["EndTime"] = os.clock() + u50,
                        ["SerialId"] = u3:GenerateGUID()
                    }
                    task.delay(u50, function() --[[ Line: 211 ]]
                        --[[
                        Upvalues:
                            [1] = u34
                            [2] = u49
                        --]]
                        if u34[u49] then
                            u34[u49].CooldownData = nil
                        end
                    end)
                end
                if u61 ~= nil then
                    local u63 = u61.CDTimer
                    local u64 = u61.Icon
                    local u65 = u64.UIGradient
                    task.spawn(function() --[[ Line: 228 ]]
                        --[[
                        Upvalues:
                            [1] = u63
                            [2] = u49
                            [3] = u61
                            [4] = u60
                            [5] = u50
                            [6] = u64
                            [7] = u65
                            [8] = u38
                            [9] = u34
                        --]]
                        if u63.Visible == true and u49 ~= "Block" then
                            warn("exting cd visible")
                            return
                        end
                        if u61:GetAttribute("IsInCD") == true then
                            warn("exting cd attribute")
                            return
                        end
                        u63.Visible = true
                        u61:SetAttribute("IsInCD", true)
                        local v66 = u61
                        local v67 = false
                        while u60 and (u60.CooldownData ~= nil and os.clock() - u60.CooldownData.StartTime < u50) do
                            if u61 ~= u60.SkillFrame and u49 ~= "Block" then
                                u61 = u60.SkillFrame
                                u63 = u61.CDTimer
                                u64 = u61.Icon
                                u65 = u64.UIGradient
                            end
                            if u61 ~= v66 then
                                v67 = true
                                break
                            end
                            local u68 = 1 - (os.clock() - u60.CooldownData.StartTime) / u50
                            pcall(function() --[[ Line: 254 ]]
                                --[[
                                Upvalues:
                                    [1] = u65
                                    [2] = u38
                                    [3] = u68
                                --]]
                                local v69 = u65
                                local v70 = ColorSequence.new
                                local v71 = {}
                                local v72 = ColorSequenceKeypoint.new(0, u38)
                                local v73 = ColorSequenceKeypoint.new
                                local v74 = u68 * 0.9
                                __set_list(v71, 1, {v72, v73(math.clamp(v74, 0, 0.9), u38), ColorSequenceKeypoint.new(u68, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))})
                                v69.Color = v70(v71)
                            end)
                            local v75 = u63
                            local v76 = (u50 - (os.clock() - u60.CooldownData.StartTime)) * 10
                            local v77
                            if v76 >= 0 then
                                local v78 = v76 + 0.5
                                v77 = math.floor(v78)
                            else
                                local v79 = v76 - 0.5
                                v77 = math.ceil(v79)
                            end
                            v75.Text = v77 / 10
                            task.wait(0.1)
                        end
                        if (u61 == u60.SkillFrame or u49 == "Block") and v67 ~= true then
                            u61:SetAttribute("IsInCD", false)
                            u34[u49].CooldownData = nil
                            u65.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255))
                            u63.Visible = false
                        end
                    end)
                end
            end
        end
        function u13.UpdateSkillCooldown2(_, u80, u81, _) --[[ Line: 279 ]]
            --[[
            Upvalues:
                [1] = u21
                [2] = u34
                [3] = u35
                [4] = u37
                [5] = u48
                [6] = u26
                [7] = u24
                [8] = u38
            --]]
            local v82 = u21:GetCurrentInput()
            local _ = u34[u80]
            if u35[u80] == nil then
                u35[u80] = {
                    ["CooldownTime"] = u81,
                    ["StartTime"] = os.clock(),
                    ["EndTime"] = os.clock() + u81
                }
                task.delay(u81, function() --[[ Line: 293 ]]
                    --[[
                    Upvalues:
                        [1] = u35
                        [2] = u80
                    --]]
                    u35[u80] = nil
                end)
            end
            if v82 == "Mobile" then
                task.spawn(function() --[[ Line: 300 ]]
                    --[[
                    Upvalues:
                        [1] = u37
                        [2] = u80
                        [3] = u48
                        [4] = u81
                    --]]
                    for v83 = 1, #u37 do
                        if u37[v83].Name == u80 then
                            u48(u37[v83], u81)
                            return
                        end
                    end
                end)
                return
            else
                local u84 = u34[u80]
                print("Update SkillCooldown", u80, u81)
                local u85 = u80 == "Block" and u26:FindFirstChild("Block")
                if not u85 then
                    if u84 then
                        u85 = u84.SkillFrame or nil
                    else
                        u85 = nil
                    end
                end
                if u85 and u85:IsDescendantOf(u24) == false or u85 == nil then
                    local v86 = u26:FindFirstChild(u80)
                    if v86 then
                        u85 = v86
                        if u84 then
                            u84.SkillFrame = u85
                        end
                    end
                end
                if u85 == nil then
                    print("frame is nil?")
                    return
                elseif u85:WaitForChild("CDTimer", 1) == nil then
                    warn("cant find cd timer for ", u80)
                else
                    local u87 = u85.CDTimer
                    local u88 = u85.Icon
                    local u89 = u88.UIGradient
                    task.spawn(function() --[[ Line: 344 ]]
                        --[[
                        Upvalues:
                            [1] = u87
                            [2] = u80
                            [3] = u85
                            [4] = u84
                            [5] = u81
                            [6] = u88
                            [7] = u89
                            [8] = u38
                            [9] = u34
                        --]]
                        if u87.Visible == true and u80 ~= "Block" then
                            warn("exting cd visible")
                            return
                        end
                        if u85:GetAttribute("IsInCD") == true then
                            warn("exting cd attribute")
                            return
                        end
                        u87.Visible = true
                        u85:SetAttribute("IsInCD", true)
                        local v90 = u85
                        local v91 = false
                        while u84 and (u84.CooldownData ~= nil and os.clock() - u84.CooldownData.StartTime < u81) do
                            if u85 ~= u84.SkillFrame and u80 ~= "Block" then
                                u85 = u84.SkillFrame
                                u87 = u85.CDTimer
                                u88 = u85.Icon
                                u89 = u88.UIGradient
                            end
                            if u85 ~= v90 then
                                v91 = true
                                break
                            end
                            local v92 = 1 - (os.clock() - u84.CooldownData.StartTime) / u81
                            local v93 = u89
                            local v94 = ColorSequence.new
                            local v95 = {}
                            local v96 = ColorSequenceKeypoint.new(0, u38)
                            local v97 = ColorSequenceKeypoint.new
                            local v98 = v92 * 0.9
                            __set_list(v95, 1, {v96, v97(math.clamp(v98, 0, 0.9), u38), ColorSequenceKeypoint.new(v92, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))})
                            v93.Color = v94(v95)
                            local v99 = u87
                            local v100 = (u81 - (os.clock() - u84.CooldownData.StartTime)) * 10
                            local v101
                            if v100 >= 0 then
                                local v102 = v100 + 0.5
                                v101 = math.floor(v102)
                            else
                                local v103 = v100 - 0.5
                                v101 = math.ceil(v103)
                            end
                            v99.Text = v101 / 10
                            task.wait(0.1)
                        end
                        if (u85 == u84.SkillFrame or u80 == "Block") and v91 ~= true then
                            u85:SetAttribute("IsInCD", false)
                            u34[u80].CooldownData = nil
                            u89.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255))
                            u87.Visible = false
                        end
                    end)
                end
            end
        end
        local u104 = nil
        local function u109(p105) --[[ Line: 392 ]]
            --[[
            Upvalues:
                [1] = u104
                [2] = u33
            --]]
            if u104 ~= p105 and u33[u104] ~= nil then
                for _, v106 in pairs(u33[u104]) do
                    local v107 = v106.CDTimer
                    local v108 = v106.Icon.UIGradient
                    v106.Parent = nil
                    v107.Visible = false
                    v106:SetAttribute("IsInCD", false)
                    v108.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255))
                end
                u104 = nil
            end
        end
        local function u124(p110, p111) --[[ Line: 489 ]]
            --[[
            Upvalues:
                [1] = u8
                [2] = u5
            --]]
            local v112 = u8.GetMoveData(p110)
            local v113 = false
            local v114
            if v112 then
                local v115 = v112.statreq
                if v115 == nil then
                    v114 = false
                else
                    v113 = v112.hiddenLock or false
                    local v116, v117 = _G.SkillRequirementsMet(u5, v115, nil)
                    if v116 then
                        p111.Icon.Key.Text = p111:GetAttribute("Key")
                        p111.SkillName.Text = p110
                        v114 = false
                    else
                        v114 = true
                        if typeof(v117) == "string" or typeof(v117) == "number" then
                            p111.Icon.Key.Text = "<stroke><font color=\"rgb(255,0,0)\">" .. v117 .. "</font></stroke>"
                        elseif typeof(v117) == "table" then
                            local v118 = {}
                            for v119 = 1, #v117 do
                                local v120 = v117[v119]
                                local v121 = string.split(v120, "-")
                                local v122 = string.gsub(v121[1], "V2", "")
                                table.insert(v118, v122)
                            end
                            local v123 = table.concat(v118, " or ")
                            p111.Icon.Key.Text = "<stroke><font color=\"rgb(255,0,0)\">" .. v123 .. "</font></stroke>"
                        end
                        p111.SkillName.Text = "???"
                    end
                end
            else
                v114 = false
            end
            p111:SetAttribute("Locked", v114)
            if v114 == true then
                if v113 then
                    p111.SkillName.Text = "?"
                end
                p111.Icon.Lock.Visible = true
            elseif v114 == false then
                p111.Icon.Lock.Visible = false
            end
        end
        local function u131() --[[ Line: 558 ]]
            --[[
            Upvalues:
                [1] = u5
                [2] = u39
                [3] = u30
                [4] = u31
            --]]
            local v125, v126 = _G.getMasteryInfo(u5, u39)
            if v125 == nil then
                u30.Visible = false
            else
                u30.Visible = true
                local v127 = v125 / v126
                local v128 = math.min(1, v127)
                local v129
                if v128 < 1 then
                    local v130 = v128 * 100
                    v129 = math.floor(v130) .. "%" or "MAXED"
                else
                    v129 = "MAXED"
                end
                u30.Base.Progress.Text = v129
                u31:TweenSize(UDim2.new(v128, 0, 1.01, 0), "Out", "Quad", 0.25, true)
            end
        end
        local function u187(p132, p133) --[[ Line: 572 ]]
            --[[
            Upvalues:
                [1] = u39
                [2] = u131
                [3] = u21
                [4] = u109
                [5] = u104
                [6] = u27
                [7] = u25
                [8] = u33
                [9] = u34
                [10] = u13
                [11] = u26
                [12] = u37
                [13] = u124
                [14] = u8
                [15] = u36
                [16] = u5
                [17] = u22
                [18] = u18
                [19] = u11
                [20] = u4
                [21] = u23
                [22] = u35
                [23] = u48
            --]]
            u39 = p132
            u131()
            u21:GetCurrentInput()
            u109(p132)
            u104 = p132
            u27.Text = p132
            local v134 = u21:GetCurrentInput()
            if v134 == "Mobile" then
                u25.Visible = false
            else
                u25.Visible = true
            end
            if u33[p132] ~= nil then
                if not u33[p132] then
                    ::l7::
                    if v134 ~= "Mobile" then
                        for v135, v136 in pairs(u33[p132]) do
                            v136.Parent = u26
                            local v137 = u34[v135]
                            if v137 and v137.CooldownData ~= nil then
                                u13.UpdateSkillCooldown(nil, v135, v137.CooldownData.CooldownTime)
                            end
                        end
                        return
                    end
                    goto l24
                end
                local v138 = u33[p132]
                local v139 = 0
                for _, _ in pairs(v138) do
                    v139 = v139 + 1
                end
                local v140 = 0
                for _, _ in pairs(p133) do
                    v140 = v140 + 1
                end
                if v139 == v140 then
                    goto l7
                end
            end
            if u33[p132] then
                for _, v141 in pairs(u33[p132]) do
                    v141.Parent = nil
                end
            end
            for v142 = 1, #p133 do
                local v143 = p133[v142]
                local v144 = u34[v143]
                if v144 and v144.CooldownData ~= nil then
                    warn("new cd setting", v143)
                    u13.UpdateSkillCooldown(nil, v143, v144.CooldownData.CooldownTime)
                end
            end
            u33[p132] = {}
            ::l24::
            for v145 = 1, #u37 do
                u37[v145].Parent = nil
                u37[v145] = nil
            end
            u37 = {}
            for v146, v147 in pairs(p133) do
                local u148 = v147[1]
                local v149 = v147[2]
                local v150 = v147[3]
                local v151 = u21:GetCurrentInput()
                if u148 ~= "Armament Haki" then
                    if v151 == "Mobile" then
                        if u148 ~= "Block" then
                            local u152 = u8.GetMoveData(u148)
                            if u152.hideMobile == nil then
                                local u153 = u36[u148]
                                local u154 = require(u5.Backpack:WaitForChild("SkillCallbacks"))
                                local v155 = #u37 + 1
                                local v156 = ("Skill%*"):format(v155) or u148
                                local v157 = u21.Inputs.Mobile.SavedButtons[v156]
                                local _, _, v158 = u22:GetMobileUI()
                                if not u153 then
                                    local u159 = false
                                    local v160 = u22
                                    local v161 = {
                                        ["Name"] = u148,
                                        ["Title"] = u148,
                                        ["AutoScaling"] = true
                                    }
                                    local v162
                                    if v157 then
                                        v162 = v157.SizeRatio
                                    else
                                        v162 = v157
                                    end
                                    v161.SizeRatio = v162
                                    local v163
                                    if v157 then
                                        v163 = UDim2.fromOffset(v157.SizeRatio.X * v158.AbsoluteSize.X, v157.SizeRatio.Y * v158.AbsoluteSize.Y)
                                    else
                                        v163 = v157
                                    end
                                    v161.Size = v163
                                    v161.Callbacks = {
                                        ["InputBegan"] = function() --[[ Name: InputBegan, Line 719 ]]
                                            --[[
                                            Upvalues:
                                                [1] = u159
                                                [2] = u39
                                                [3] = u18
                                                [4] = u154
                                                [5] = u148
                                                [6] = u152
                                                [7] = u153
                                                [8] = u11
                                                [9] = u4
                                                [10] = u23
                                            --]]
                                            if u159 then
                                                warn("already using?")
                                                return
                                            else
                                                local v164 = u39
                                                local v165 = u18[v164] or v164
                                                u159 = true
                                                warn((("Ability used: %*"):format(v165)))
                                                local v166 = u154:GetSkillCallback(v165)
                                                local v167 = u148:gsub("%s+", "")
                                                _G.mobileUsingSkill = true
                                                if u152.InstantCast ~= nil then
                                                    local u168 = u153.ActionIcon.Image
                                                    u153.ActionIcon.Image = "rbxassetid://17714973640"
                                                    u153.ActionIcon.ImageColor3 = Color3.fromRGB(255, 255, 255)
                                                    local u169 = u11.new()
                                                    local v172 = u4.TouchTapInWorld:Connect(function(p170, p171) --[[ Line: 739 ]]
                                                        --[[
                                                        Upvalues:
                                                            [1] = u153
                                                            [2] = u168
                                                            [3] = u169
                                                        --]]
                                                        if not p171 then
                                                            u153.ActionIcon.Image = u168
                                                            _G.Mouse:SetPosition(p170)
                                                            u169:Fire()
                                                        end
                                                    end)
                                                    if u23.Settings.InstantCastSkills.Value == false and u152.IgnoreInstantCastSetting == nil then
                                                        u169:Wait()
                                                    end
                                                    u153.ActionIcon.ImageColor3 = Color3.fromRGB(255, 255, 255)
                                                    u169:DisconnectAll()
                                                    u169 = nil
                                                    v172:Disconnect()
                                                end
                                                if v166.canUseSkills and not v166.canUseSkills() then
                                                    u159 = nil
                                                    warn("alreaedy yusing returning!")
                                                else
                                                    task.delay(0.1, function() --[[ Line: 761 ]]
                                                        _G.mobileUsingSkill = nil
                                                    end)
                                                    v166[v167](v166, u153)
                                                    u159 = nil
                                                end
                                            end
                                        end
                                    }
                                    local u173 = v160:CreateButton(v161)
                                    u173:SetAttribute("Skill", true)
                                    u36[u148] = u173
                                    task.spawn(function() --[[ Line: 775 ]]
                                        --[[
                                        Upvalues:
                                            [1] = u173
                                            [2] = u152
                                            [3] = u5
                                            [4] = u22
                                            [5] = u148
                                        --]]
                                        local u174 = false
                                        u173.Destroying:Connect(function() --[[ Line: 778 ]]
                                            --[[
                                            Upvalues:
                                                [1] = u174
                                            --]]
                                            u174 = true
                                        end)
                                        while u174 == false do
                                            if u173.Parent ~= nil and (u173.ActionIcon.Image ~= "rbxassetid://17672867931" and u173.ActionIcon.Image ~= "rbxassetid://17714973640") then
                                                local v175 = u152.statreq
                                                local v176, v177 = _G.SkillRequirementsMet(u5, v175, nil)
                                                if v175 then
                                                    v175 = v176 == true
                                                end
                                                if v176 == false then
                                                    u173.LockedText.Text = "<stroke><font color=\"rgb(255,0,0)\">" .. v177 .. "</font></stroke>"
                                                    u173.LockedText.Visible = true
                                                else
                                                    u173.LockedText.Visible = false
                                                end
                                                u22:UpdateTexture({
                                                    ["ButtonName"] = u148,
                                                    ["Texture"] = v175 and "rbxassetid://16527536731" or "http://www.roblox.com/asset/?id=15938966453"
                                                })
                                            end
                                            task.wait(0.1)
                                        end
                                        warn("mobile button gone")
                                    end)
                                    u153 = u173
                                end
                                local v178 = u37
                                table.insert(v178, u153)
                                u22:GetButtonData(u148).Ability = p132
                                local v179, _ = u22:GetPositionAndSize()
                                local v180 = u22:GetButton("Block")
                                local v181 = #p133 - 1
                                local v182 = 2.356194490192345 + 4.71238898038469 / math.max(v181, 5) * #u37
                                local v183 = v179.X.Offset * 1.75
                                u22:UpdatePosition({
                                    ["ButtonName"] = u148,
                                    ["Position"] = v157 and UDim2.fromOffset(v157.X, v157.Y) or v180.Position + UDim2.new(0, math.sin(v182) * v183, 0, -math.cos(v182) * v183)
                                })
                                if v157 then
                                    u22:UpdateSize({
                                        ["ButtonName"] = u148,
                                        ["Size"] = UDim2.fromOffset(v157.SizeRatio.X * v158.AbsoluteSize.X, v157.SizeRatio.Y * v158.AbsoluteSize.Y)
                                    })
                                end
                                u21.Inputs.Mobile.EditMode.Skills[v155] = u148
                                u153.Parent = u22:GetMobileUI()
                                if u35[u148] then
                                    task.spawn(function() --[[ Line: 840 ]]
                                        --[[
                                        Upvalues:
                                            [1] = u48
                                            [2] = u153
                                            [3] = u35
                                            [4] = u148
                                        --]]
                                        u48(u153, u35[u148].EndTime - os.clock())
                                    end)
                                end
                            end
                        end
                    elseif u26:FindFirstChild(u148) then
                        warn("existing frame for", u148)
                    else
                        if string.len(v149) == 1 then
                            v149 = string.upper(v149) or v149
                        end
                        local v184 = script.Template:Clone()
                        v184.Name = u148
                        v184.LayoutOrder = #p133 - v146
                        v184.Parent = u26
                        v184:SetAttribute("Key", v149)
                        u33[p132][u148] = v184
                        v184.SkillName.Text = u148
                        local v185 = v184.Icon.Key
                        if v150 then
                            v149 = v150 .. " " .. v149 or v149
                        end
                        v185.Text = v149
                        u124(u148, v184)
                        local v186 = u34[u148]
                        if v186 == nil then
                            u34[u148] = {
                                ["SkillFrame"] = v184
                            }
                        else
                            u34[u148].SkillFrame = v184
                            if v186.CooldownData ~= nil then
                                u13.UpdateSkillCooldown(nil, u148, v186.CooldownData.CooldownTime)
                            end
                        end
                    end
                end
            end
        end
        function u13.BindAbility(_, p188, p189) --[[ Line: 849 ]]
            --[[
            Upvalues:
                [1] = u13
                [2] = u187
            --]]
            u13.QueueTask:QueueTask(u187, p188, p189)
        end
        function u13.Cleanup(_) --[[ Line: 853 ]]
            --[[
            Upvalues:
                [1] = u25
                [2] = u37
                [3] = u27
                [4] = u109
            --]]
            u25.Visible = false
            for v190 = 1, #u37 do
                u37[v190].Parent = nil
                u37[v190] = nil
            end
            u37 = {}
            u27.Text = "None"
            u109(nil)
        end
        u13.cooldown = u13.UpdateSkillCooldown
        u13.setup = u13.BindAbility
        u13.Destroy = u13.Cleanup
        _G.keysetup = u13
        local u191 = nil
        local function v233(u192) --[[ Line: 871 ]]
            --[[
            Upvalues:
                [1] = u32
                [2] = u2
                [3] = u5
                [4] = u21
                [5] = u28
                [6] = u191
                [7] = u3
                [8] = u7
                [9] = u22
                [10] = u18
                [11] = u6
            --]]
            local u193 = script.ModeAssets
            local u194 = u192:GetAttribute("barName")
            local u195 = u192:GetAttribute("damageName")
            local u196 = u192:GetAttribute("filledBarSFX")
            local u197 = u192:GetAttribute("barColor")
            if not u195 then
                return
            end
            if u32[u195] then
                return
            end
            local u198 = u2.Modules.Skills.Modes:FindFirstChild(_G.modeBarModuleNames(u192.Name))
            if not u198 then
                warn((("%* does not have a mode module!"):format(u194)))
                return
            end
            local u199 = require(u198)(u5)
            warn("mode bar ", u192.Name)
            local v200 = u21:GetCurrentInput()
            u192.Destroying:Connect(function() --[[ Line: 890 ]]
                --[[
                Upvalues:
                    [1] = u32
                    [2] = u195
                --]]
                u32[u195] = nil
            end)
            u192.AncestryChanged:Connect(function() --[[ Line: 894 ]]
                --[[
                Upvalues:
                    [1] = u192
                    [2] = u32
                    [3] = u195
                --]]
                if u192.Parent and u192.Parent.Name == "Unequiped" then
                    u32[u195] = nil
                end
            end)
            if v200 ~= "Mobile" then
                local u201 = u5.Character
                local v202 = u28.Base
                local u203 = v202.Bar.Fill
                local u204 = v202.Progress
                local u205 = u28.ModeName
                u32[u195] = {}
                local v206 = u32[u195]
                u28.Visible = false
                local u207 = false
                local function u218() --[[ Line: 917 ]]
                    --[[
                    Upvalues:
                        [1] = u192
                        [2] = u191
                        [3] = u194
                        [4] = u205
                        [5] = u3
                        [6] = u199
                        [7] = u198
                        [8] = u5
                        [9] = u201
                        [10] = u195
                        [11] = u204
                        [12] = u203
                        [13] = u207
                        [14] = u193
                        [15] = u196
                        [16] = u197
                    --]]
                    if u192 == u191 then
                        if u194 == u205.Text then
                            local v208 = u192:GetAttribute("customModeData")
                            local v209 = u192:GetAttribute("modePercent") or 1
                            if v208 then
                                v208 = u3:JSONDecode(v208)
                            end
                            u199 = require(u198)(u5)
                            local v210 = 0.25
                            if v208 and v208.Max then
                                u199 = v208.Max
                            end
                            if v208 and v208.Volume then
                                v210 = v208.Volume
                            end
                            local v211 = u201:GetAttribute(u195) or 0
                            local v212 = math.floor(v211)
                            local v213 = v212 / u199
                            local v214 = math.min(1, v213)
                            local v215
                            if v214 < 1 then
                                local v216 = v214 * 100
                                v215 = math.floor(v216) .. "%" or "MAXED"
                            else
                                v215 = "MAXED"
                            end
                            if v208 == nil then
                                u204.Text = v215
                            else
                                u204.Text = ("%* %*"):format(v212, v208.ModeType)
                            end
                            u203:TweenSize(UDim2.new(v214, 0, 1.01, 0), "Out", "Quad", 0.25, true)
                            if (v208 == nil and u199 * v209 <= v212 or v208 and v208.ModeRequirement <= v212) and u207 == false then
                                u207 = true
                                u193.enough.Volume = v210
                                u193.enough.SoundId = u196
                                u193.enough:Play()
                                local v217 = u193.ColorCorrection:Clone()
                                v217.TintColor = u197
                                v217.Parent = workspace.CurrentCamera
                                _G.tween(v217, {
                                    2,
                                    Enum.EasingStyle.Quad,
                                    Enum.EasingDirection.Out,
                                    0,
                                    false,
                                    0
                                }, {
                                    ["TintColor"] = Color3.fromRGB(255, 255, 255),
                                    ["Contrast"] = 0
                                })
                                _G.destroy(v217, 2)
                            elseif v208 == nil and v212 < u199 * v209 * 0.8 or v208 ~= nil and v212 < v208.ModeRequirement then
                                u207 = false
                            end
                        else
                            return
                        end
                    else
                        return
                    end
                end
                local function v219() --[[ Line: 971 ]]
                    --[[
                    Upvalues:
                        [1] = u191
                        [2] = u192
                        [3] = u203
                        [4] = u197
                        [5] = u205
                        [6] = u194
                        [7] = u218
                        [8] = u28
                    --]]
                    u191 = u192
                    u203.BackgroundColor3 = u197
                    u205.Text = u194
                    u218()
                    u28.Visible = true
                end
                local function v220() --[[ Line: 983 ]]
                    --[[
                    Upvalues:
                        [1] = u28
                        [2] = u191
                    --]]
                    u28.Visible = false
                    u191 = nil
                end
                u191 = u192
                u203.BackgroundColor3 = u197
                u205.Text = u194
                u218()
                u28.Visible = true
                print(u192, "bind to", u195)
                v206.UpdateBar = u201:GetAttributeChangedSignal(u195):Connect(u218)
                v206.DisplayModeBar = u192.Equipped:Connect(v219)
                v206.HideModeBar = u192.Unequipped:Connect(v220)
                ::l9::
                return
            end
            print("mobile", u192.Name)
            local v221 = u7:WaitForChild("Skills")
            local v222 = require(v221)
            local u223 = nil
            for v224, v225 in pairs(u22.Buttons) do
                print("action name", v224)
                if v225.Ability == nil then
                    warn("canht find " .. v224)
                elseif v225.Ability == u192.Name then
                    ::l15::
                    local v226 = v222.GetM(v224)
                    if v226 == nil then
                        warn("invalid")
                    else
                        print("skill desc", v226)
                        if v226.transformation == true then
                            u223 = u22:GetButton(v224)
                            break
                        end
                    end
                elseif u18[v225.Ability] ~= nil then
                    if u18[v225.Ability] == u192.Name then
                        goto l15
                    end
                end
            end
            if u223 == nil then
                print("failed")
                return
            end
            u32[u195] = true
            print(u195)
            local u227 = u193.Circular:Clone()
            u227.Name = "CircularModeUI"
            u227.Parent = u6
            local u228 = u227.Progress
            local v229 = u228.Left
            local v230 = u228.Right
            local v231 = u223.Position
            u228.Size = u223.Size
            u228.Position = v231
            u223.Changed:Connect(function(p232) --[[ Line: 1046 ]]
                --[[
                Upvalues:
                    [1] = u223
                    [2] = u228
                --]]
                if u223.Parent ~= nil then
                    if p232 == "Position" then
                        u228.Position = u223.Position
                        return
                    end
                    if p232 == "Size" then
                        u228.Size = u223.Size
                    end
                end
            end)
            u223:GetPropertyChangedSignal("Parent"):Connect(function() --[[ Line: 1056 ]]
                --[[
                Upvalues:
                    [1] = u223
                    [2] = u227
                --]]
                if u223.Parent == nil then
                    u227.Enabled = false
                else
                    u227.Enabled = true
                end
            end)
            u227:GetPropertyChangedSignal("Enabled"):Connect(function() --[[ Line: 1064 ]]
                --[[
                Upvalues:
                    [1] = u227
                    [2] = u228
                    [3] = u223
                --]]
                if u227.Enabled then
                    u228.Position = u223.Position
                end
            end)
            u192.Destroying:Connect(function() --[[ Line: 1070 ]]
                --[[
                Upvalues:
                    [1] = u195
                    [2] = u32
                --]]
                print(u195, "removed?")
                u32[u195] = nil
            end)
            v229.Bar.ImageColor3 = u197
            v230.Bar.ImageColor3 = u197
            u227.LocalScript.enough.SoundId = u196
            u227.LocalScript.ColorCorrection.TintColor = u197
            u227.LocalScript.tool.Value = u192
            u227.LocalScript.Enabled = true
            goto l9
        end
        u23.MasteryPercentages.AllMasterys.Changed:Connect(u131)
        _G.addModeBar = v233
        u28.Visible = false
        u25.Visible = false
        task.spawn(function() --[[ Line: 1093 ]]
            --[[
            Upvalues:
                [1] = u21
                [2] = u104
                [3] = u33
                [4] = u124
            --]]
            while true do
                repeat
                    task.wait(0.5)
                    u21:GetCurrentInput()
                until u104 ~= nil and u33[u104] ~= nil
                for v234, v235 in pairs(u33[u104]) do
                    u124(v234, v235)
                end
            end
        end)
        local function u238(p236) --[[ Line: 1105 ]]
            --[[
            Upvalues:
                [1] = u104
                [2] = u33
            --]]
            if u104 ~= nil and u33[u104] ~= nil then
                for _, v237 in pairs(u33[u104]) do
                    if typeof(v237) ~= "table" and v237:GetAttribute("Key") == p236.Name then
                        return v237
                    end
                end
            end
        end
        u4.InputBegan:Connect(function(u239, p240) --[[ Line: 1118 ]]
            --[[
            Upvalues:
                [1] = u238
                [2] = u4
            --]]
            if not p240 then
                local v241 = u238(u239.KeyCode)
                if v241 ~= nil and (v241.Parent ~= nil and v241:GetAttribute("Locked") ~= true) then
                    local u242 = v241:FindFirstChild("Icon")
                    u242.ImageColor3 = Color3.fromRGB(151, 198, 255)
                    local u243 = nil
                    u243 = u4.InputEnded:Connect(function(p244, _) --[[ Line: 1127 ]]
                        --[[
                        Upvalues:
                            [1] = u239
                            [2] = u243
                            [3] = u242
                        --]]
                        if p244.KeyCode == u239.KeyCode then
                            u243:Disconnect()
                            u243 = nil
                            u242.ImageColor3 = Color3.fromRGB(255, 255, 255)
                        end
                    end)
                end
            end
        end)
        u29.MouseButton1Click:Connect(function() --[[ Line: 1140 ]]
            --[[
            Upvalues:
                [1] = u19
                [2] = u26
                [3] = u29
            --]]
            u19.UIUtils.ButtonEffect()
            u26.Visible = not u26.Visible
            u29.Status.Text = u26.Visible == true and "Close" or "Open"
        end)
        local function v255(_) --[[ Line: 1147 ]]
            --[[
            Upvalues:
                [1] = u25
                [2] = u36
                [3] = u34
                [4] = u33
                [5] = u32
                [6] = u28
            --]]
            u25.Visible = false
            for v245, v246 in u36 do
                v246:Destroy()
                u36[v245] = nil
            end
            for _, v247 in pairs(u34) do
                if v247.SkillFrame then
                    v247.SkillFrame:Destroy()
                end
            end
            table.clear(u34)
            for v248, v249 in pairs(u33) do
                for _, v250 in pairs(v249) do
                    v250:Destroy()
                end
                u33[v248] = nil
            end
            for v251, v252 in pairs(u32) do
                if typeof(v252) == "boolean" then
                    u32[v251] = nil
                else
                    for v253, v254 in v252 do
                        v254:Disconnect()
                        v252[v253] = nil
                    end
                end
            end
            u28.Visible = false
            table.clear(u32)
        end
        v255(u5.Character or u5.CharacterAdded:Wait())
        u5.CharacterAdded:Connect(v255)
        u13.Initialized = true
    end
end
return u13