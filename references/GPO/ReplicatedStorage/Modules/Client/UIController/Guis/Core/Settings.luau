 

local v1 = game:GetService("Players")
game:GetService("ReplicatedStorage")
local u2 = game:GetService("TweenService")
game:GetService("UserInputService")
local u3 = game:GetService("Lighting")
game:GetService("RunService")
local u4 = game:GetService("ReplicatedStorage")
local u5 = v1.LocalPlayer
local u6 = u5:WaitForChild("PlayerGui")
local v7 = u4:WaitForChild("Modules")
require(v7.Leveling)
local v8 = v7.Client
local u9 = require(v8:WaitForChild("Slider"))
local v10 = v7.Shared
require(v10.GameUtils)
require(v10:WaitForChild("SoundUtils"))
local u11 = require(u4.Modules.Trove)
local u12 = require(v7.Client.Notification)
local u13 = u4:WaitForChild("Events")
local u154 = {
    ["Initialized"] = false,
    ["Initialize"] = function(p14) --[[ Name: Initialize, Line 29 ]]
        --[[
        Upvalues:
            [1] = u154
            [2] = u13
            [3] = u4
            [4] = u6
            [5] = u12
            [6] = u3
            [7] = u11
            [8] = u2
            [9] = u9
            [10] = u5
        --]]
        if u154.Initialized then
            return
        end
        local u15 = u13:WaitForChild("Settings")
        local u16 = u4:WaitForChild("reservedCode")
        local u17 = p14:GetStatsFolder()
        local u18 = u17:WaitForChild("Settings"):WaitForChild("MobileButtonScale")
        local v19 = u6:WaitForChild("Settings", 360):WaitForChild("Main")
        local v20 = v19:WaitForChild("List")
        local u21 = v19:WaitForChild("Code")
        local u22 = v19.Toggle
        local u23 = Color3.fromRGB(170, 12, 1)
        local u24 = Color3.fromRGB(85, 170, 0)
        local u25 = {
            ["On"] = true,
            ["Off"] = false,
            [true] = "On",
            [false] = "Off"
        }
        local u26 = {
            ["DashMode"] = { "Default", "Fruit", "FightingStyle" }
        }
        local v27 = { "M1Button", "HapticFeedback", "MobileBlockToggle" }
        local u28 = {}
        local function u31(p29) --[[ Line: 76 ]]
            for _, v30 in ipairs(p29:GetChildren()) do
                if v30:IsA("Texture") then
                    v30:Destroy()
                end
            end
        end
        function u28.FastModeInit(p32) --[[ Line: 84 ]]
            --[[
            Upvalues:
                [1] = u25
                [2] = u24
                [3] = u23
            --]]
            local v33 = _G.fastmode
            local v34 = p32.Options.Select
            v34.Position = UDim2.new(u25[v33] == "On" and 0.5 or 0, 0, 0.5, 0)
            v34.ImageColor3 = u25[v33] == "On" and u24 or u23
            return "Off"
        end
        function u28.FastModeCheck(_, _) --[[ Line: 89 ]]
            if _G.fastmode == true then
                return false, "<Color=Red>You must rejoin to disable FastMode!"
            else
                return true
            end
        end
        function u28.FastModeOn(_) --[[ Line: 98 ]]
            --[[
            Upvalues:
                [1] = u12
                [2] = u3
                [3] = u31
            --]]
            u12.DisplayMessage("Transitioning to FastMode...")
            _G.fastmode = true
            local v35 = os.clock()
            u3.GlobalShadows = false
            workspace.Islands.DescendantAdded:Connect(function(p36) --[[ Line: 119 ]]
                --[[
                Upvalues:
                    [1] = u31
                --]]
                if p36:IsA("BasePart") then
                    if p36.Material == Enum.Material.ForceField then
                        return
                    end
                    p36.Material = Enum.Material.SmoothPlastic
                    if p36:FindFirstChildWhichIsA("Texture") then
                        u31(p36)
                    end
                end
            end)
            local v37 = workspace.Islands:GetDescendants()
            local v38 = 0
            for v39 = 1, #v37 do
                if v37[v39]:IsA("BasePart") and v37[v39].Material ~= Enum.Material.ForceField then
                    v38 = v38 + 1
                    local v40 = v37[v39]
                    if v40.Material ~= Enum.Material.ForceField then
                        v40.Material = Enum.Material.SmoothPlastic
                        if v40:FindFirstChildWhichIsA("Texture") then
                            u31(v40)
                        end
                    end
                    if v38 >= 50 then
                        task.wait()
                        v38 = 0
                    end
                end
            end
            local v41 = u12.DisplayMessage
            local v42 = os.clock() - v35
            v41((("Finalized FastMode in %*s"):format((math.floor(v42)))))
        end
        function u28.AllowJoinsInit(p43) --[[ Line: 143 ]]
            --[[
            Upvalues:
                [1] = u17
                [2] = u25
                [3] = u24
                [4] = u23
            --]]
            local v44 = u17.Settings.AllowJoins.Value
            local v45 = p43.Options.Select
            v45.Position = UDim2.new(u25[v44] == "On" and 0.5 or 0, 0, 0.5, 0)
            v45.ImageColor3 = u25[v44] == "On" and u24 or u23
            return u25[u17.Settings.AllowJoins.Value]
        end
        function u28.AllowJoinsOn(_) --[[ Line: 148 ]]
            --[[
            Upvalues:
                [1] = u15
            --]]
            u15:InvokeServer("AllowJoins", true)
        end
        function u28.AllowJoinsOff(_) --[[ Line: 152 ]]
            --[[
            Upvalues:
                [1] = u15
            --]]
            u15:InvokeServer("AllowJoins", false)
        end
        function u28.ShadowsInit(p46) --[[ Line: 156 ]]
            --[[
            Upvalues:
                [1] = u17
                [2] = u25
                [3] = u24
                [4] = u23
                [5] = u3
            --]]
            local v47 = u17.Settings.Shadows.Value
            local v48 = p46.Options.Select
            v48.Position = UDim2.new(u25[v47] == "On" and 0.5 or 0, 0, 0.5, 0)
            v48.ImageColor3 = u25[v47] == "On" and u24 or u23
            u3.GlobalShadows = u17.Settings.Shadows.Value
            return u25[u17.Settings.Shadows.Value]
        end
        function u28.ShadowsOn(_) --[[ Line: 162 ]]
            --[[
            Upvalues:
                [1] = u15
                [2] = u3
            --]]
            u15:InvokeServer("Shadows", true)
            u3.GlobalShadows = true
        end
        function u28.ShadowsOff(_) --[[ Line: 167 ]]
            --[[
            Upvalues:
                [1] = u15
                [2] = u3
            --]]
            u15:InvokeServer("Shadows", false)
            u3.GlobalShadows = false
        end
        function u28.MusicInit(p49) --[[ Line: 172 ]]
            --[[
            Upvalues:
                [1] = u17
                [2] = u25
                [3] = u24
                [4] = u23
            --]]
            _G.music = u17.Settings.Music.Value
            local v50 = u17.Settings.Music.Value
            local v51 = p49.Options.Select
            v51.Position = UDim2.new(u25[v50] == "On" and 0.5 or 0, 0, 0.5, 0)
            v51.ImageColor3 = u25[v50] == "On" and u24 or u23
            return u25[u17.Settings.Music.Value]
        end
        function u28.MusicOn(_) --[[ Line: 178 ]]
            --[[
            Upvalues:
                [1] = u15
            --]]
            u15:InvokeServer("Music", true)
            _G.music = true
        end
        function u28.MusicOff(_) --[[ Line: 183 ]]
            --[[
            Upvalues:
                [1] = u15
            --]]
            u15:InvokeServer("Music", false)
            _G.music = false
        end
        function u28.RadioInit(p52) --[[ Line: 188 ]]
            --[[
            Upvalues:
                [1] = u25
                [2] = u24
                [3] = u23
            --]]
            _G.music2 = true
            local v53 = _G.music2
            local v54 = p52.Options.Select
            v54.Position = UDim2.new(u25[v53] == "On" and 0.5 or 0, 0, 0.5, 0)
            v54.ImageColor3 = u25[v53] == "On" and u24 or u23
            return u25[_G.music2]
        end
        function u28.RadioOn(_) --[[ Line: 194 ]]
            _G.music2 = true
        end
        function u28.RadioOff(_) --[[ Line: 198 ]]
            _G.music2 = false
        end
        function u28.LocalOverheadInit(p55) --[[ Line: 202 ]]
            --[[
            Upvalues:
                [1] = u17
                [2] = u25
                [3] = u24
                [4] = u23
            --]]
            local v56 = u17.Settings.ShowLocalPlayerBar.Value
            local v57 = p55.Options.Select
            v57.Position = UDim2.new(u25[v56] == "On" and 0.5 or 0, 0, 0.5, 0)
            v57.ImageColor3 = u25[v56] == "On" and u24 or u23
            return u25[u17.Settings.ShowLocalPlayerBar.Value]
        end
        function u28.LocalOverheadOn(_) --[[ Line: 207 ]]
            --[[
            Upvalues:
                [1] = u15
                [2] = u12
            --]]
            u15:InvokeServer("ShowLocalPlayerBar", true)
            u12.DisplayMessage("<Color=Orange>A respawn is required to apply changes.")
        end
        function u28.LocalOverheadOff(_) --[[ Line: 212 ]]
            --[[
            Upvalues:
                [1] = u15
            --]]
            u15:InvokeServer("ShowLocalPlayerBar", false)
        end
        function u28.AnimatedAccessoriesInit(p58) --[[ Line: 216 ]]
            --[[
            Upvalues:
                [1] = u17
                [2] = u25
                [3] = u24
                [4] = u23
            --]]
            local v59 = u17.Settings.AnimatedHats.Value
            local v60 = p58.Options.Select
            v60.Position = UDim2.new(u25[v59] == "On" and 0.5 or 0, 0, 0.5, 0)
            v60.ImageColor3 = u25[v59] == "On" and u24 or u23
            return u25[u17.Settings.AnimatedHats.Value]
        end
        function u28.AnimatedAccessoriesOn(_) --[[ Line: 221 ]]
            --[[
            Upvalues:
                [1] = u15
            --]]
            u15:InvokeServer("AnimatedHats", true)
        end
        function u28.AnimatedAccessoriesOff(_) --[[ Line: 225 ]]
            --[[
            Upvalues:
                [1] = u15
            --]]
            u15:InvokeServer("AnimatedHats", false)
        end
        function u28.PVPModeInit(p61) --[[ Line: 229 ]]
            --[[
            Upvalues:
                [1] = u17
                [2] = u25
                [3] = u24
                [4] = u23
            --]]
            local v62 = u17.Settings.PVPMode.Value
            local v63 = p61.Options.Select
            v63.Position = UDim2.new(u25[v62] == "On" and 0.5 or 0, 0, 0.5, 0)
            v63.ImageColor3 = u25[v62] == "On" and u24 or u23
            return u25[u17.Settings.PVPMode.Value]
        end
        function u28.PVPModeOn(_) --[[ Line: 234 ]]
            --[[
            Upvalues:
                [1] = u15
            --]]
            return u15:InvokeServer("PVPMode", true)
        end
        function u28.PVPModeOff(_) --[[ Line: 238 ]]
            --[[
            Upvalues:
                [1] = u15
            --]]
            return u15:InvokeServer("PVPMode", false)
        end
        function u28.HapticFeedbackInit(p64) --[[ Line: 242 ]]
            --[[
            Upvalues:
                [1] = u17
                [2] = u25
                [3] = u24
                [4] = u23
            --]]
            local v65 = u17.Settings.PVPMode.Value
            local v66 = p64.Options.Select
            v66.Position = UDim2.new(u25[v65] == "On" and 0.5 or 0, 0, 0.5, 0)
            v66.ImageColor3 = u25[v65] == "On" and u24 or u23
            return u25[u17.Settings.HapticFeedback.Value]
        end
        function u28.HapticFeedbackOn(_) --[[ Line: 247 ]]
            --[[
            Upvalues:
                [1] = u15
            --]]
            u15:InvokeServer("HapticFeedback", true)
        end
        function u28.HapticFeedbackOff(_) --[[ Line: 251 ]]
            --[[
            Upvalues:
                [1] = u15
            --]]
            u15:InvokeServer("HapticFeedback", false)
        end
        function u28.OverrideDashOn(_) --[[ Line: 255 ]]
            --[[
            Upvalues:
                [1] = u15
            --]]
            _G.displayMessage("<Color=Orange>Your special dashes have been switched to normal roll dash")
            return u15:InvokeServer("OverrideDash", true)
        end
        function u28.OverrideDashOff(_) --[[ Line: 260 ]]
            --[[
            Upvalues:
                [1] = u15
            --]]
            _G.displayMessage("<Color=Orange>Your special dashes have been enabled")
            return u15:InvokeServer("OverrideDash", false)
        end
        function u28.InstantCastSkillsOn(_) --[[ Line: 265 ]]
            --[[
            Upvalues:
                [1] = u15
            --]]
            _G.displayMessage("<Color=Orange>Your holdable skills will now instantly cast instead of waiting for your input.")
            if _G.mobile == true then
                _G.displayMessage("<Color=Orange>Shift Lock is recommend for this setting on mobile.")
            end
            return u15:InvokeServer("InstantCastSkills", true)
        end
        function u28.InstantCastSkillsOff(_) --[[ Line: 273 ]]
            --[[
            Upvalues:
                [1] = u15
            --]]
            _G.displayMessage("<Color=Orange>Your holdable skills will now wait for your input.")
            return u15:InvokeServer("InstantCastSkills", false)
        end
        function u28.M1ButtonOn(_) --[[ Line: 278 ]]
            --[[
            Upvalues:
                [1] = u15
            --]]
            u15:InvokeServer("M1Button", true)
        end
        function u28.M1ButtonOff(_) --[[ Line: 282 ]]
            --[[
            Upvalues:
                [1] = u15
            --]]
            u15:InvokeServer("M1Button", false)
        end
        function u28.MobileBlockToggleOn(_) --[[ Line: 286 ]]
            --[[
            Upvalues:
                [1] = u15
                [2] = u12
            --]]
            u15:InvokeServer("MobileBlockToggle", true)
            u12.DisplayMessage("<Color=Orange>Blocking now requires you to tap 2 times, one time to block, and another to unblock.")
        end
        function u28.MobileBlockToggleOff(_) --[[ Line: 292 ]]
            --[[
            Upvalues:
                [1] = u15
                [2] = u12
            --]]
            u15:InvokeServer("MobileBlockToggle", false)
            u12.DisplayMessage("<Color=Orange>Blocking now is now holdable,hold the button to start blocking and release to unblock.")
        end
        function u28.AutoRunOn(_) --[[ Line: 298 ]]
            --[[
            Upvalues:
                [1] = u15
            --]]
            u15:InvokeServer("AutoRun", true)
        end
        function u28.AutoRunOff(_) --[[ Line: 302 ]]
            --[[
            Upvalues:
                [1] = u15
            --]]
            u15:InvokeServer("AutoRun", false)
        end
        function u28.MobileUIScaleInit(_, p67, _) --[[ Line: 308 ]]
            --[[
            Upvalues:
                [1] = u18
            --]]
            p67:OverrideValue(u18.Value)
        end
        function u28.MobileUIScaleUpdated(_, p68, _) --[[ Line: 312 ]]
            --[[
            Upvalues:
                [1] = u15
            --]]
            u15:InvokeServer("MobileButtonScale", p68:GetValue())
        end
        function u28.ShowCapturePointsOn(_) --[[ Line: 318 ]]
            --[[
            Upvalues:
                [1] = u15
            --]]
            u15:InvokeServer("ShowCapturePoints", true)
        end
        function u28.ShowCapturePointsOff(_) --[[ Line: 322 ]]
            --[[
            Upvalues:
                [1] = u15
            --]]
            u15:InvokeServer("ShowCapturePoints", false)
        end
        local u69 = "ParticleEmitRate"
        function u28.ParticleEmitRateInit(_, p70, _) --[[ Line: 327 ]]
            --[[
            Upvalues:
                [1] = u17
                [2] = u69
            --]]
            p70:OverrideValue(u17.Settings[u69].Value)
        end
        local u71 = "ParticleEmitRate"
        function u28.ParticleEmitRateUpdated(_, p72, _) --[[ Line: 331 ]]
            --[[
            Upvalues:
                [1] = u15
                [2] = u71
            --]]
            u15:InvokeServer(u71, p72:GetValue())
        end
        local u73 = "ParticleRate"
        function u28.ParticleRateInit(_, p74, _) --[[ Line: 327 ]]
            --[[
            Upvalues:
                [1] = u17
                [2] = u73
            --]]
            p74:OverrideValue(u17.Settings[u73].Value)
        end
        local u75 = "ParticleRate"
        function u28.ParticleRateUpdated(_, p76, _) --[[ Line: 331 ]]
            --[[
            Upvalues:
                [1] = u15
                [2] = u75
            --]]
            u15:InvokeServer(u75, p76:GetValue())
        end
        local u77 = "DamageOutput"
        function u28.DamageOutputInit(_, p78, _) --[[ Line: 327 ]]
            --[[
            Upvalues:
                [1] = u17
                [2] = u77
            --]]
            p78:OverrideValue(u17.Settings[u77].Value)
        end
        local u79 = "DamageOutput"
        function u28.DamageOutputUpdated(_, p80, _) --[[ Line: 331 ]]
            --[[
            Upvalues:
                [1] = u15
                [2] = u79
            --]]
            u15:InvokeServer(u79, p80:GetValue())
        end
        (function(u81) --[[ Name: setupBasicToggle, Line 340 ]]
            --[[
            Upvalues:
                [1] = u28
                [2] = u17
                [3] = u25
                [4] = u24
                [5] = u23
                [6] = u15
            --]]
            u28[u81 .. "Init"] = function(p82) --[[ Line: 341 ]]
                --[[
                Upvalues:
                    [1] = u17
                    [2] = u81
                    [3] = u25
                    [4] = u24
                    [5] = u23
                --]]
                local v83 = u17.Settings[u81].Value
                local v84 = p82.Options.Select
                v84.Position = UDim2.new(u25[v83] == "On" and 0.5 or 0, 0, 0.5, 0)
                v84.ImageColor3 = u25[v83] == "On" and u24 or u23
                return u25[u17.Settings[u81].Value]
            end
            u28[u81 .. "On"] = function(_) --[[ Line: 346 ]]
                --[[
                Upvalues:
                    [1] = u15
                    [2] = u81
                --]]
                u15:InvokeServer(u81, true)
            end
            u28[u81 .. "Off"] = function(_) --[[ Line: 350 ]]
                --[[
                Upvalues:
                    [1] = u15
                    [2] = u81
                --]]
                u15:InvokeServer(u81, false)
            end
        end)("PartyPings")
        function u28.CameraShakeOn(_) --[[ Line: 359 ]]
            --[[
            Upvalues:
                [1] = u15
            --]]
            u15:InvokeServer("CameraShake", true)
            _G.cameraShakeEnabled = true
        end
        function u28.CameraShakeOff(_) --[[ Line: 364 ]]
            --[[
            Upvalues:
                [1] = u15
            --]]
            u15:InvokeServer("CameraShake", false)
            _G.cameraShakeEnabled = false
        end
        local u85 = {}
        local u86 = u11.new()
        local u87 = false
        local function u90() --[[ Line: 375 ]]
            --[[
            Upvalues:
                [1] = u85
                [2] = u86
            --]]
            for v88, v89 in pairs(u85) do
                if v89 then
                    v89:Disconnect()
                end
                if v88 then
                    u85[v88] = nil
                end
            end
            table.clear(u85)
            u85 = {}
            u86:Clean()
            warn("cleared particle storage")
        end
        local function u99(p91) --[[ Line: 391 ]]
            --[[
            Upvalues:
                [1] = u17
                [2] = u86
                [3] = u87
                [4] = u85
                [5] = u90
            --]]
            if p91 == nil then
                p91 = u17.Settings.ParticleRate.Value
            end
            if p91 >= 1 then
                u86:Clean()
                u87 = false
            else
                u87 = true
                u86:Clean()
                local function v98(u92) --[[ Line: 405 ]]
                    --[[
                    Upvalues:
                        [1] = u85
                        [2] = u17
                    --]]
                    if u92:IsA("ParticleEmitter") and u85[u92] == nil then
                        local v93 = u17.Settings.ParticleRate.Value
                        local v94 = u92:GetAttribute("OrgParticleRateSetting")
                        if v94 == nil then
                            u92:SetAttribute("OrgParticleRateSetting", u92.Rate)
                            v94 = u92.Rate
                        end
                        if v94 <= 0 then
                            return
                        end
                        local v95 = 4
                        if v94 < v95 then
                            v95 = v94
                        end
                        local v96 = v94 * v93
                        u92.Rate = math.max(v96, v95)
                        local u97 = nil
                        u97 = u92.Destroying:Once(function() --[[ Line: 429 ]]
                            --[[
                            Upvalues:
                                [1] = u97
                                [2] = u85
                                [3] = u92
                            --]]
                            u97:Disconnect()
                            u97 = nil
                            u85[u92] = nil
                        end)
                        u85[u92] = u97
                    end
                end
                u86:Add(workspace.Effects.DescendantAdded:Connect(v98))
                u86:Add(workspace.NPCs.DescendantAdded:Connect(v98))
                u86:Add(workspace.PlayerCharacters.DescendantAdded:Connect(v98))
                u86:Add(u90)
                u86:Add(function() --[[ Line: 465 ]]
                    --[[
                    Upvalues:
                        [1] = u87
                    --]]
                    u87 = false
                end)
            end
        end
        function u28.ParticleRateInit(_, p100, _) --[[ Line: 470 ]]
            --[[
            Upvalues:
                [1] = u17
                [2] = u99
            --]]
            p100:OverrideValue(u17.Settings.ParticleRate.Value)
            u99()
        end
        function u28.ParticleRateUpdated(_, p101, _) --[[ Line: 476 ]]
            --[[
            Upvalues:
                [1] = u87
                [2] = u85
                [3] = u86
                [4] = u99
                [5] = u15
            --]]
            local v102 = p101:GetValue()
            if u87 == true then
                for v103, _ in pairs(u85) do
                    if v103 ~= nil then
                        local v104 = v103:GetAttribute("OrgParticleRateSetting")
                        if v104 then
                            local v105 = v104 * v102
                            v103.Rate = math.max(v105, 4)
                        end
                    end
                end
            end
            warn("new rate", v102)
            if v102 >= 1 then
                u87 = false
                u86:Clean()
            elseif u87 == false then
                u99(v102)
            end
            u15:InvokeServer("ParticleRate", v102)
        end
        function u28.DashModeInit(p106) --[[ Line: 506 ]]
            --[[
            Upvalues:
                [1] = u17
            --]]
            local v107 = u17.Settings.DashMode.Value
            p106.Options.Select.Text = v107
            return v107
        end
        function u28.DashModeChanged(_, p108) --[[ Line: 512 ]]
            --[[
            Upvalues:
                [1] = u15
                [2] = u12
            --]]
            u15:InvokeServer("DashMode", p108)
            u12.DisplayMessage("<Color=Orange>Dash mode set to: " .. p108)
        end
        local v149 = {
            ["On/Off"] = function(u109) --[[ Line: 519 ]]
                --[[
                Upvalues:
                    [1] = u28
                    [2] = u12
                    [3] = u2
                    [4] = u24
                    [5] = u23
                    [6] = u17
                    [7] = u25
                --]]
                local v110 = u109.Options
                local u111 = v110.Select
                local u112 = "On"
                local u113 = false
                v110.Button.MouseButton1Click:Connect(function() --[[ Line: 526 ]]
                    --[[
                    Upvalues:
                        [1] = u28
                        [2] = u109
                        [3] = u12
                        [4] = u113
                        [5] = u112
                        [6] = u2
                        [7] = u111
                        [8] = u24
                        [9] = u23
                    --]]
                    local v114 = u28[u109.Name .. "Check"]
                    if v114 then
                        local v115, v116 = v114(u109)
                        if v115 == false then
                            u12.DisplayMessage(v116 or "Error Occured")
                            u113 = false
                            return
                        end
                    end
                    if u113 ~= true then
                        u113 = true
                        u112 = u112 == "On" and "Off" or "On"
                        if u28[u109.Name .. u112] then
                            local v117 = u28[u109.Name .. u112](u109)
                            if v117 then
                                if v117 == true then
                                    u112 = "On"
                                else
                                    u112 = "Off"
                                end
                            end
                        else
                            warn("Missing Functions for", u109, u112)
                        end
                        u2:Create(u111, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                            ["Position"] = UDim2.new(u112 == "On" and 0.5 or 0, 0, 0.5, 0),
                            ["ImageColor3"] = u112 == "On" and u24 or u23
                        }):Play()
                        task.wait(0.25)
                        u113 = false
                    end
                end)
                if u28[u109.Name .. "Init"] then
                    u112 = u28[u109.Name .. "Init"](u109, u112) or "On"
                else
                    local v118 = u17.Settings[u109.Name].Value
                    local v119 = u109.Options.Select
                    v119.Position = UDim2.new(u25[v118] == "On" and 0.5 or 0, 0, 0.5, 0)
                    v119.ImageColor3 = u25[v118] == "On" and u24 or u23
                    u112 = u25[u17.Settings[u109.Name].Value]
                end
            end,
            ["Slider"] = function(u120) --[[ Line: 581 ]]
                --[[
                Upvalues:
                    [1] = u9
                    [2] = u28
                --]]
                print("setup", u120, "slider")
                local v121 = u120:WaitForChild("Bar")
                local u122 = v121:WaitForChild("UIGradient")
                local u123 = u120:WaitForChild("Value")
                local u124 = Color3.fromRGB(179, 179, 179)
                local u125 = Color3.fromRGB(100, 100, 100)
                local u126 = u9.new(v121, {
                    ["Start"] = u120:GetAttribute("Start") or 0,
                    ["End"] = u120:GetAttribute("End") or 1,
                    ["Increment"] = u120:GetAttribute("Increment") or 0.1,
                    ["Default"] = 0
                }, TweenInfo.new(0, Enum.EasingStyle.Linear), "X", 0.25)
                u126:Track()
                local function u136() --[[ Line: 607 ]]
                    --[[
                    Upvalues:
                        [1] = u123
                        [2] = u126
                        [3] = u122
                        [4] = u124
                        [5] = u125
                    --]]
                    u123.Text = u126:GetValue()
                    local v127 = u122
                    local v128 = ColorSequence.new
                    local v129 = {}
                    local v130 = ColorSequenceKeypoint.new(0, u124)
                    local v131 = ColorSequenceKeypoint.new
                    local v132 = u126._percent + 0.001
                    local v133 = v131(math.clamp(v132, 0.001, 0.998), u124)
                    local v134 = ColorSequenceKeypoint.new
                    local v135 = u126._percent + 0.002
                    __set_list(v129, 1, {v130, v133, v134(math.clamp(v135, 0.002, 0.999), u125), ColorSequenceKeypoint.new(1, u125)})
                    v127.Color = v128(v129)
                end
                u126.Changed:Connect(function(_) --[[ Line: 617 ]]
                    --[[
                    Upvalues:
                        [1] = u136
                    --]]
                    u136()
                end)
                local u137 = u28[("%*Updated"):format(u120.Name)]
                u126.Released:Connect(function(_) --[[ Line: 622 ]]
                    --[[
                    Upvalues:
                        [1] = u136
                        [2] = u137
                        [3] = u120
                        [4] = u126
                    --]]
                    u136()
                    if u137 ~= nil then
                        u137(u120, u126, u136)
                    end
                end)
                u126.OnClick:Connect(function(_) --[[ Line: 629 ]]
                    --[[
                    Upvalues:
                        [1] = u136
                        [2] = u137
                        [3] = u120
                        [4] = u126
                    --]]
                    u136()
                    if u137 ~= nil then
                        u137(u120, u126, u136)
                    end
                end)
                local v138 = u28[("%*Init"):format(u120.Name)]
                if v138 ~= nil then
                    v138(u120, u126, u136)
                end
            end,
            ["Cycle"] = function(u139) --[[ Line: 641 ]]
                --[[
                Upvalues:
                    [1] = u26
                    [2] = u5
                    [3] = u28
                --]]
                local v140 = u139.Options
                local u141 = v140.Select
                local v142 = v140.Button
                local u143 = u26[u139.Name]
                if u143 then
                    local u144 = 1
                    local u145 = false
                    v142.MouseButton1Click:Connect(function() --[[ Line: 656 ]]
                        --[[
                        Upvalues:
                            [1] = u5
                            [2] = u145
                            [3] = u144
                            [4] = u143
                            [5] = u141
                            [6] = u28
                            [7] = u139
                        --]]
                        if u5.Character:FindFirstChild("inCombat") then
                            _G.displayMessage("<Color=Red>Cant change this setting while in combat!")
                            return
                        elseif not u145 then
                            u145 = true
                            u144 = u144 % #u143 + 1
                            local v146 = u143[u144]
                            u141.Text = v146
                            if u28[u139.Name .. "Changed"] then
                                u28[u139.Name .. "Changed"](u139, v146)
                            end
                            task.wait(0.25)
                            u145 = false
                        end
                    end)
                    if u28[u139.Name .. "Init"] then
                        local v147 = u28[u139.Name .. "Init"](u139)
                        local v148 = v147 and table.find(u143, v147)
                        if v148 then
                            u144 = v148
                        end
                    end
                else
                    warn("No cycle options for", u139.Name)
                end
            end
        }
        for _, v150 in ipairs(v20:GetChildren()) do
            if v150:IsA("ImageLabel") then
                local v151 = v149[v150:GetAttribute("Type") or ""]
                if v151 ~= nil then
                    v151(v150)
                    if table.find(v27, v150.Name) and _G.mobile == false then
                        v150.Visible = false
                    end
                    goto l6
                end
                warn((("Could not find setup type for %*"):format(v150.Name)))
            else
                ::l6::
                task.wait()
            end
        end
        local function v152() --[[ Line: 710 ]]
            --[[
            Upvalues:
                [1] = u21
                [2] = u16
                [3] = u22
            --]]
            u21.Text = u16.Value
            if u16.Value == "" then
                u22.Visible = false
            else
                u22.Visible = true
            end
            if u16.Value == "" then
                u21.Text = "Public Server"
            end
        end
        u21.Text = u16.Value
        if u16.Value == "" then
            u22.Visible = false
        else
            u22.Visible = true
        end
        if u16.Value == "" then
            u21.Text = "Public Server"
        end
        u16:GetPropertyChangedSignal("Value"):Connect(v152)
        u21.Visible = false
        if u16.Value == "" then
            u21.Visible = true
        end
        local u153 = true
        u22.MouseButton1Click:Connect(function() --[[ Line: 732 ]]
            --[[
            Upvalues:
                [1] = u153
                [2] = u21
                [3] = u22
            --]]
            u153 = not u153
            u21.Visible = not u153
            u22.Status.Text = u153 and "SHOW" or "HIDE"
        end)
        u154.Initialized = true
    end
}
return u154