 

local u1 = game:GetService("UserInputService")
local v2 = game:GetService("ProximityPromptService")
local u3 = game:GetService("TweenService")
local u4 = game:GetService("TextService")
local v5 = game:GetService("Players").LocalPlayer
local u6 = require(game.ReplicatedStorage.Modules.Shared.Signals.GoodSignal)
local u7 = v5:WaitForChild("PlayerGui")
require(game.ReplicatedStorage:WaitForChild("Modules"):WaitForChild("ToolDesc"))
local u8 = {
    [Enum.KeyCode.ButtonX] = "rbxasset://textures/ui/Controls/xboxX.png",
    [Enum.KeyCode.ButtonY] = "rbxasset://textures/ui/Controls/xboxY.png",
    [Enum.KeyCode.ButtonA] = "rbxasset://textures/ui/Controls/xboxA.png",
    [Enum.KeyCode.ButtonB] = "rbxasset://textures/ui/Controls/xboxB.png",
    [Enum.KeyCode.DPadLeft] = "rbxasset://textures/ui/Controls/dpadLeft.png",
    [Enum.KeyCode.DPadRight] = "rbxasset://textures/ui/Controls/dpadRight.png",
    [Enum.KeyCode.DPadUp] = "rbxasset://textures/ui/Controls/dpadUp.png",
    [Enum.KeyCode.DPadDown] = "rbxasset://textures/ui/Controls/dpadDown.png",
    [Enum.KeyCode.ButtonSelect] = "rbxasset://textures/ui/Controls/xboxmenu.png",
    [Enum.KeyCode.ButtonL1] = "rbxasset://textures/ui/Controls/xboxLS.png",
    [Enum.KeyCode.ButtonR1] = "rbxasset://textures/ui/Controls/xboxRS.png"
}
local u9 = {
    [Enum.KeyCode.Backspace] = "rbxasset://textures/ui/Controls/backspace.png",
    [Enum.KeyCode.Return] = "rbxasset://textures/ui/Controls/return.png",
    [Enum.KeyCode.LeftShift] = "rbxasset://textures/ui/Controls/shift.png",
    [Enum.KeyCode.RightShift] = "rbxasset://textures/ui/Controls/shift.png",
    [Enum.KeyCode.Tab] = "rbxasset://textures/ui/Controls/tab.png"
}
local u10 = {
    ["\'"] = "rbxasset://textures/ui/Controls/apostrophe.png",
    [","] = "rbxasset://textures/ui/Controls/comma.png",
    ["`"] = "rbxasset://textures/ui/Controls/graveaccent.png",
    ["."] = "rbxasset://textures/ui/Controls/period.png",
    [" "] = "rbxasset://textures/ui/Controls/spacebar.png"
}
local u11 = {
    [Enum.KeyCode.LeftControl] = "Ctrl",
    [Enum.KeyCode.RightControl] = "Ctrl",
    [Enum.KeyCode.LeftAlt] = "Alt",
    [Enum.KeyCode.RightAlt] = "Alt",
    [Enum.KeyCode.F1] = "F1",
    [Enum.KeyCode.F2] = "F2",
    [Enum.KeyCode.F3] = "F3",
    [Enum.KeyCode.F4] = "F4",
    [Enum.KeyCode.F5] = "F5",
    [Enum.KeyCode.F6] = "F6",
    [Enum.KeyCode.F7] = "F7",
    [Enum.KeyCode.F8] = "F8",
    [Enum.KeyCode.F9] = "F9",
    [Enum.KeyCode.F10] = "F10",
    [Enum.KeyCode.F11] = "F11",
    [Enum.KeyCode.F12] = "F12"
}
local function u225(u12, p13, p14) --[[ Line: 83 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u8
        [3] = u1
        [4] = u9
        [5] = u10
        [6] = u11
        [7] = u4
    --]]
    local u15 = {}
    local u16 = {}
    local u17 = {}
    local u18 = {}
    local v19 = TweenInfo.new(u12.HoldDuration, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
    TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local u20 = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local u21 = TweenInfo.new(0.06, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
    local v22 = TweenInfo.new(0, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
    local u23 = nil
    local v24 = u12:GetAttribute("Theme")
    if v24 then
        local v25 = script:FindFirstChild(v24)
        if v25 then
            u23 = v25:Clone()
        end
    end
    if u23 == nil then
        u23 = script.Default:Clone()
    end
    u23.Enabled = true
    local u26 = u23.PromptFrame
    local v27 = u26.InputFrame
    local u28 = u26.ActionText
    local u29 = u26.ObjectText
    local v30 = u26.BackgroundTransparency
    local v31 = u26.ImageTransparency
    u26.BackgroundTransparency = 1
    u26.ImageTransparency = 1
    local v32 = u3
    local v33 = {
        ["Size"] = UDim2.fromScale(0.5, 1),
        ["BackgroundTransparency"] = 1,
        ["ImageTransparency"] = 1
    }
    table.insert(u15, v32:Create(u26, u20, v33))
    local v34 = u3
    local v35 = {
        ["Size"] = UDim2.fromScale(1, 1),
        ["BackgroundTransparency"] = v30,
        ["ImageTransparency"] = v31
    }
    table.insert(u16, v34:Create(u26, u20, v35))
    local v36 = u3
    local v37 = {
        ["Size"] = UDim2.fromScale(0.5, 1),
        ["BackgroundTransparency"] = 1,
        ["ImageTransparency"] = 1
    }
    table.insert(u17, v36:Create(u26, u20, v37))
    local v38 = u3
    local v39 = {
        ["Size"] = UDim2.fromScale(1, 1),
        ["BackgroundTransparency"] = v30,
        ["ImageTransparency"] = v31
    }
    table.insert(u18, v38:Create(u26, u20, v39))
    local function u54(p40) --[[ Line: 126 ]]
        --[[
        Upvalues:
            [1] = u15
            [2] = u3
            [3] = u20
            [4] = u16
            [5] = u17
            [6] = u18
        --]]
        local v41 = p40.Transparency
        p40.Transparency = 1
        local v42 = u15
        local v43 = u3
        local v44 = u20
        table.insert(v42, v43:Create(p40, v44, {
            ["Transparency"] = 1
        }))
        local v45 = u16
        local v46 = u3
        local v47 = u20
        table.insert(v45, v46:Create(p40, v47, {
            ["Transparency"] = v41
        }))
        local v48 = u17
        local v49 = u3
        local v50 = u20
        table.insert(v48, v49:Create(p40, v50, {
            ["Transparency"] = 1
        }))
        local v51 = u18
        local v52 = u3
        local v53 = u20
        table.insert(v51, v52:Create(p40, v53, {
            ["Transparency"] = v41
        }))
    end
    local function u69(p55) --[[ Line: 135 ]]
        --[[
        Upvalues:
            [1] = u15
            [2] = u3
            [3] = u20
            [4] = u16
            [5] = u17
            [6] = u18
        --]]
        local v56 = p55.BackgroundTransparency
        p55.BackgroundTransparency = 1
        local v57 = u15
        local v58 = u3
        local v59 = u20
        table.insert(v57, v58:Create(p55, v59, {
            ["BackgroundTransparency"] = 1
        }))
        local v60 = u16
        local v61 = u3
        local v62 = u20
        table.insert(v60, v61:Create(p55, v62, {
            ["BackgroundTransparency"] = v56
        }))
        local v63 = u17
        local v64 = u3
        local v65 = u20
        table.insert(v63, v64:Create(p55, v65, {
            ["BackgroundTransparency"] = 1
        }))
        local v66 = u18
        local v67 = u3
        local v68 = u20
        table.insert(v66, v67:Create(p55, v68, {
            ["BackgroundTransparency"] = v56
        }))
    end
    local function u85(p70) --[[ Line: 144 ]]
        --[[
        Upvalues:
            [1] = u15
            [2] = u3
            [3] = u20
            [4] = u16
            [5] = u17
            [6] = u18
        --]]
        local v71 = p70.TextTransparency
        local v72 = p70.TextStrokeTransparency
        p70.TextTransparency = 1
        p70.TextStrokeTransparency = 1
        local v73 = u15
        local v74 = u3
        local v75 = u20
        table.insert(v73, v74:Create(p70, v75, {
            ["TextTransparency"] = 1,
            ["TextStrokeTransparency"] = 1
        }))
        local v76 = u16
        local v77 = u3
        local v78 = u20
        table.insert(v76, v77:Create(p70, v78, {
            ["TextTransparency"] = v71,
            ["TextStrokeTransparency"] = v72
        }))
        local v79 = u17
        local v80 = u3
        local v81 = u20
        table.insert(v79, v80:Create(p70, v81, {
            ["TextTransparency"] = 1,
            ["TextStrokeTransparency"] = 1
        }))
        local v82 = u18
        local v83 = u3
        local v84 = u20
        table.insert(v82, v83:Create(p70, v84, {
            ["TextTransparency"] = v71,
            ["TextStrokeTransparency"] = v72
        }))
    end
    local function u100(p86) --[[ Line: 155 ]]
        --[[
        Upvalues:
            [1] = u15
            [2] = u3
            [3] = u20
            [4] = u16
            [5] = u17
            [6] = u18
        --]]
        local v87 = p86.ImageTransparency
        p86.ImageTransparency = 1
        local v88 = u15
        local v89 = u3
        local v90 = u20
        table.insert(v88, v89:Create(p86, v90, {
            ["ImageTransparency"] = 1
        }))
        local v91 = u16
        local v92 = u3
        local v93 = u20
        table.insert(v91, v92:Create(p86, v93, {
            ["ImageTransparency"] = v87
        }))
        local v94 = u17
        local v95 = u3
        local v96 = u20
        table.insert(v94, v95:Create(p86, v96, {
            ["ImageTransparency"] = 1
        }))
        local v97 = u18
        local v98 = u3
        local v99 = u20
        table.insert(v97, v98:Create(p86, v99, {
            ["ImageTransparency"] = v87
        }))
    end
    local function u103(p101) --[[ Line: 164 ]]
        --[[
        Upvalues:
            [1] = u54
            [2] = u69
            [3] = u85
            [4] = u100
            [5] = u103
        --]]
        if p101:IsA("UIStroke") then
            u54(p101)
        elseif not p101:IsA("UIGradient") and p101:IsA("GuiObject") then
            u69(p101)
            if p101:IsA("TextLabel") then
                u85(p101)
            elseif p101:IsA("ImageLabel") then
                u100(p101)
            end
        end
        for _, v102 in pairs(p101:GetChildren()) do
            u103(v102)
        end
    end
    local v104 = {
        [v27] = false,
        [u28] = true,
        [u29] = true
    }
    for _, v105 in pairs(u26:GetChildren()) do
        if v104[v105] == nil then
            u103(v105)
        elseif v104[v105] == true then
            for _, v106 in pairs(v105:GetChildren()) do
                u103(v106)
            end
        end
    end
    local v107 = v27.Frame
    local v108 = v107.UIScale
    local v109 = p13 == Enum.ProximityPromptInputType.Touch and 1.6 or 1.33
    local v110 = u3
    table.insert(u15, v110:Create(v108, u20, {
        ["Scale"] = v109
    }))
    local v111 = u3
    table.insert(u16, v111:Create(v108, u20, {
        ["Scale"] = 1
    }))
    u85(u28)
    u85(u29)
    local u112 = v107.ButtonFrame;
    (function() --[[ Name: setupButtonFrameTweens, Line 211 ]]
        --[[
        Upvalues:
            [1] = u112
            [2] = u17
            [3] = u3
            [4] = u21
            [5] = u18
        --]]
        local v113 = u17
        local v114 = u3
        local v115 = u112
        local v116 = u21
        table.insert(v113, v114:Create(v115, v116, {
            ["BackgroundTransparency"] = 1,
            ["ImageTransparency"] = 1
        }))
        local v117 = u18
        local v118 = u3
        local v119 = u112
        local v120 = u21
        local v121 = {
            ["BackgroundTransparency"] = u112.BackgroundTransparency,
            ["ImageTransparency"] = u112.ImageTransparency
        }
        table.insert(v117, v118:Create(v119, v120, v121))
        for _, v122 in pairs(u112:getChildren()) do
            if v122:IsA("UIStroke") then
                local v123 = u17
                local v124 = u3
                local v125 = u21
                table.insert(v123, v124:Create(v122, v125, {
                    ["Transparency"] = 1
                }))
                local v126 = u18
                local v127 = u3
                local v128 = u21
                local v129 = {
                    ["Transparency"] = v122.Transparency
                }
                table.insert(v126, v127:Create(v122, v128, v129))
            end
        end
    end)()
    local u130 = v107.ButtonImage
    local u131 = v107.ButtonText
    local u132 = v107.ButtonTextImage
    local function v152() --[[ Line: 233 ]]
        --[[
        Upvalues:
            [1] = u131
            [2] = u17
            [3] = u3
            [4] = u21
            [5] = u18
        --]]
        local v133 = u131.TextTransparency
        local v134 = u131.TextStrokeTransparency
        local v135 = u131.BackgroundTransparency
        u131.BackgroundTransparency = 1
        u131.TextStrokeTransparency = 1
        u131.TextTransparency = 1
        local v136 = u17
        local v137 = u3
        local v138 = u131
        local v139 = u21
        table.insert(v136, v137:Create(v138, v139, {
            ["TextTransparency"] = 1,
            ["TextStrokeTransparency"] = 1,
            ["BackgroundTransparency"] = 1
        }))
        local v140 = u18
        local v141 = u3
        local v142 = u131
        local v143 = u21
        table.insert(v140, v141:Create(v142, v143, {
            ["TextTransparency"] = v133,
            ["TextStrokeTransparency"] = v134,
            ["BackgroundTransparency"] = v135
        }))
        for _, v144 in pairs(u131:getChildren()) do
            if v144:IsA("UIStroke") then
                local v145 = u17
                local v146 = u3
                local v147 = u21
                table.insert(v145, v146:Create(v144, v147, {
                    ["Transparency"] = 1
                }))
                local v148 = u18
                local v149 = u3
                local v150 = u21
                local v151 = {
                    ["Transparency"] = v144.Transparency
                }
                table.insert(v148, v149:Create(v144, v150, v151))
            end
        end
    end
    local function v163() --[[ Line: 253 ]]
        --[[
        Upvalues:
            [1] = u130
            [2] = u17
            [3] = u3
            [4] = u21
            [5] = u18
        --]]
        local v153 = u130.ImageTransparency
        local v154 = u130.BackgroundTransparency
        u130.BackgroundTransparency = 1
        u130.ImageTransparency = 1
        local v155 = u17
        local v156 = u3
        local v157 = u130
        local v158 = u21
        table.insert(v155, v156:Create(v157, v158, {
            ["ImageTransparency"] = 1,
            ["BackgroundTransparency"] = 1
        }))
        local v159 = u18
        local v160 = u3
        local v161 = u130
        local v162 = u21
        table.insert(v159, v160:Create(v161, v162, {
            ["ImageTransparency"] = v153,
            ["BackgroundTransparency"] = v154
        }))
    end
    local function v174() --[[ Line: 262 ]]
        --[[
        Upvalues:
            [1] = u132
            [2] = u17
            [3] = u3
            [4] = u21
            [5] = u18
        --]]
        local v164 = u132.BackgroundTransparency
        local v165 = u132.ImageTransparency
        u132.BackgroundTransparency = 1
        u132.ImageTransparency = 1
        local v166 = u17
        local v167 = u3
        local v168 = u132
        local v169 = u21
        table.insert(v166, v167:Create(v168, v169, {
            ["ImageTransparency"] = 1,
            ["BackgroundTransparency"] = 1
        }))
        local v170 = u18
        local v171 = u3
        local v172 = u132
        local v173 = u21
        table.insert(v170, v171:Create(v172, v173, {
            ["ImageTransparency"] = v165,
            ["BackgroundTransparency"] = v164
        }))
    end
    if p13 == Enum.ProximityPromptInputType.Gamepad then
        if u8[u12.GamepadKeyCode] then
            v174()
            u132.Image = u8[u12.GamepadKeyCode]
            u131.Visible = false
            u130.Visible = false
            u132.Visible = true
        end
    elseif p13 == Enum.ProximityPromptInputType.Touch then
        v163()
        u130.Image = "rbxasset://textures/ui/Controls/TouchTapIcon.png"
        u131.Visible = false
        u132.Visible = false
        u130.Visible = true
    else
        v163()
        u130.Visible = true
        local v175 = u1:GetStringForKeyCode(u12.KeyboardKeyCode)
        local v176 = u9[u12.KeyboardKeyCode]
        if v176 == nil then
            v176 = u10[v175]
        end
        if v176 == nil then
            v175 = u11[u12.KeyboardKeyCode] or v175
        end
        if v176 then
            v174()
            u132.Image = v176
            u131.Visible = false
            u132.Visible = true
        elseif v175 == nil or v175 == "" then
            local v177 = error
            local v178 = u12.Name
            local v179 = u12.KeyboardKeyCode
            v177("ProximityPrompt \'" .. v178 .. "\' has an unsupported keycode for rendering UI: " .. tostring(v179))
        else
            if string.len(v175) > 2 then
                local v180 = u131.TextSize * 6 / 7
                u131.TextSize = math.round(v180)
            end
            v152()
            u131.Text = v175
            u132.Visible = false
            u131.Visible = true
        end
    end
    if p13 == Enum.ProximityPromptInputType.Touch or u12.ClickablePrompt then
        local v181 = u23.TextButton
        local u182 = false
        v181.InputBegan:Connect(function(p183) --[[ Line: 336 ]]
            --[[
            Upvalues:
                [1] = u12
                [2] = u182
            --]]
            if (p183.UserInputType == Enum.UserInputType.Touch or p183.UserInputType == Enum.UserInputType.MouseButton1) and p183.UserInputState ~= Enum.UserInputState.Change then
                u12:InputHoldBegin()
                u182 = true
            end
        end)
        v181.InputEnded:Connect(function(p184) --[[ Line: 343 ]]
            --[[
            Upvalues:
                [1] = u182
                [2] = u12
            --]]
            if (p184.UserInputType == Enum.UserInputType.Touch or p184.UserInputType == Enum.UserInputType.MouseButton1) and u182 then
                u182 = false
                u12:InputHoldEnd()
            end
        end)
        u23.Active = true
    end
    if u12.HoldDuration > 0 then
        local v185 = v107.ProgressBar
        local u186 = v185.LeftGradient.ProgressBarImage.UIGradient
        local u187 = v185.RightGradient.ProgressBarImage.UIGradient
        v185.Progress.Changed:Connect(function(p188) --[[ Line: 76 ]]
            --[[
            Upvalues:
                [1] = u186
                [2] = u187
            --]]
            local v189 = p188 * 360
            local v190 = math.clamp(v189, 0, 360)
            u186.Rotation = math.clamp(v190, 180, 360)
            u187.Rotation = math.clamp(v190, 0, 180)
        end)
        local v191 = u3
        local v192 = v185.Progress
        table.insert(u15, v191:Create(v192, v19, {
            ["Value"] = 1
        }))
        local v193 = u3
        local v194 = v185.Progress
        table.insert(u16, v193:Create(v194, v22, {
            ["Value"] = 0
        }))
    end
    local u195, u196
    if u12.HoldDuration > 0 then
        u195 = u12.PromptButtonHoldBegan:Connect(function() --[[ Line: 368 ]]
            --[[
            Upvalues:
                [1] = u15
            --]]
            for _, v197 in ipairs(u15) do
                v197:Play()
            end
        end)
        u196 = u12.PromptButtonHoldEnded:Connect(function() --[[ Line: 374 ]]
            --[[
            Upvalues:
                [1] = u16
            --]]
            for _, v198 in ipairs(u16) do
                v198:Play()
            end
        end)
    else
        u195 = nil
        u196 = nil
    end
    local u200 = u12.Triggered:Connect(function() --[[ Line: 381 ]]
        --[[
        Upvalues:
            [1] = u17
        --]]
        for _, v199 in ipairs(u17) do
            v199:Play()
        end
    end)
    local u202 = u12.TriggerEnded:Connect(function() --[[ Line: 387 ]]
        --[[
        Upvalues:
            [1] = u18
        --]]
        for _, v201 in ipairs(u18) do
            v201:Play()
        end
    end)
    local function v221() --[[ Line: 418 ]]
        --[[
        Upvalues:
            [1] = u26
            [2] = u12
            [3] = u28
            [4] = u4
            [5] = u29
            [6] = u23
        --]]
        u26.ActionText2.Text = u12.ActionText
        u26.ObjectText2.Text = u12.ObjectText
        local u203 = u12.ActionText:gsub("(\\?)<[^<>]->", {
            [""] = ""
        })
        local u204 = u28.TextSize
        local u205 = Vector2.new(1000, 1000)
        local u206 = nil
        local _, _ = pcall(function() --[[ Line: 399 ]]
            --[[
            Upvalues:
                [1] = u203
                [2] = u205
                [3] = u204
                [4] = u206
                [5] = u4
            --]]
            local v207 = Instance.new("GetTextBoundsParams")
            v207.Text = u203
            v207.Font = Font.new(textLabel.FontFace.Family)
            v207.Size = u205
            v207.Width = u204
            u206 = u4:GetTextBoundsAsync(v207).X
        end)
        if u206 == nil then
            u206 = u4:GetTextSize(u203, u204, Enum.Font.SourceSans, u205)
        end
        local v208 = u206
        local u209 = u12.ObjectText:gsub("(\\?)<[^<>]->", {
            [""] = ""
        })
        local u210 = u29.TextSize
        local u211 = Vector2.new(1000, 1000)
        local u212 = nil
        local _, _ = pcall(function() --[[ Line: 399 ]]
            --[[
            Upvalues:
                [1] = u209
                [2] = u211
                [3] = u210
                [4] = u212
                [5] = u4
            --]]
            local v213 = Instance.new("GetTextBoundsParams")
            v213.Text = u209
            v213.Font = Font.new(textLabel.FontFace.Family)
            v213.Size = u211
            v213.Width = u210
            u212 = u4:GetTextBoundsAsync(v213).X
        end)
        if u212 == nil then
            u212 = u4:GetTextSize(u209, u210, Enum.Font.SourceSans, u211)
        end
        local v214 = u212
        local v215 = v208.X
        local v216 = v214.X
        local v217 = math.max(v215, v216)
        local v218 = (u12.ActionText == nil or u12.ActionText == "") and (u12.ObjectText == nil or u12.ObjectText == "") and 72 or v217 + 72 + 24
        local v219 = (u12.ObjectText == nil or u12.ObjectText == "") and 0 or 9
        u28.Position = UDim2.new(0.5, 72 - v218 / 2, 0, v219)
        u29.Position = UDim2.new(0.5, 72 - v218 / 2, 0, -10)
        u28.Text = u12.ActionText
        u29.Text = u12.ObjectText
        u28.AutoLocalize = u12.AutoLocalize
        u28.RootLocalizationTable = u12.RootLocalizationTable
        u29.AutoLocalize = u12.AutoLocalize
        u29.RootLocalizationTable = u12.RootLocalizationTable
        u23.Size = UDim2.fromOffset(v218, 72)
        u23.SizeOffset = Vector2.new(u12.UIOffset.X / u23.Size.Width.Offset, u12.UIOffset.Y / u23.Size.Height.Offset)
        if _G.displayRareItem ~= nil then
            local v220 = u12.ObjectText
            if u12:GetAttribute("itemName") then
                v220 = u12:GetAttribute("itemName")
            end
            _G.displayRareItem(v220, u29.UIGradient)
        end
    end
    local u222 = u12.Changed:Connect(v221)
    v221()
    u23.Adornee = u12.Parent
    u23.Parent = p14
    for _, v223 in ipairs(u18) do
        v223:Play()
    end
    return function() --[[ Name: cleanup, Line 471 ]]
        --[[
        Upvalues:
            [1] = u195
            [2] = u196
            [3] = u200
            [4] = u202
            [5] = u222
            [6] = u17
            [7] = u23
        --]]
        if u195 then
            u195:Disconnect()
        end
        if u196 then
            u196:Disconnect()
        end
        u200:Disconnect()
        u202:Disconnect()
        u222:Disconnect()
        for _, v224 in ipairs(u17) do
            v224:Play()
        end
        task.wait(0.2)
        u23:Destroy()
    end
end
v2.PromptShown:Connect(function(u226, p227) --[[ Line: 497 ]]
    --[[
    Upvalues:
        [1] = u7
        [2] = u225
        [3] = u6
    --]]
    u226.Style = Enum.ProximityPromptStyle.Custom
    local v228 = u7:FindFirstChild("ProximityPrompts")
    if v228 == nil then
        v228 = Instance.new("ScreenGui")
        v228.Name = "ProximityPrompts"
        v228.ResetOnSpawn = false
        v228.Parent = u7
    end
    local v229 = u225(u226, p227, v228)
    local u230 = u6.new()
    local u231 = {}
    local v232 = task.spawn
    table.insert(u231, v232(function() --[[ Line: 510 ]]
        --[[
        Upvalues:
            [1] = u226
            [2] = u230
        --]]
        u226.PromptHidden:Wait()
        u230:Fire()
    end))
    local v233 = task.spawn
    table.insert(u231, v233(function() --[[ Line: 515 ]]
        --[[
        Upvalues:
            [1] = u226
            [2] = u230
        --]]
        u226.Destroying:Wait()
        u230:Fire()
    end))
    u230:Wait()
    u230:DisconnectAll()
    for u234 = 1, #u231 do
        pcall(function() --[[ Line: 525 ]]
            --[[
            Upvalues:
                [1] = u231
                [2] = u234
            --]]
            task.cancel(u231[u234])
        end)
    end
    v229()
end)