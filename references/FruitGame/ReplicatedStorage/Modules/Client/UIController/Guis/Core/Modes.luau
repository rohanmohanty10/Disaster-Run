 

local v1 = game:GetService("Players")
local u2 = game:GetService("ReplicatedStorage")
game:GetService("TweenService")
local u3 = v1.LocalPlayer
local u4 = u3:WaitForChild("PlayerGui")
local u5 = u3:WaitForChild("PlayerScripts")
local u6 = u2:WaitForChild("Modules")
require(u6.Leveling)
local v7 = u6.Shared
local u8 = require(v7.GameUtils)
local u9 = require(v7.GamePlaceInfo)
local u10 = {
    ["Initialized"] = false
}
TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
local function u18(p11, p12, p13) --[[ Line: 20 ]]
    local v14 = math.floor(p12)
    local v15 = math.max(v14, 0) / math.floor(p13)
    local v16 = math.clamp(v15, 0, 1) * 360
    local v17 = math.clamp(v16, 0, 360)
    p11.Left.Bar.UIGradient.Rotation = math.clamp(v17, 180, 360)
    p11.Right.Bar.UIGradient.Rotation = math.clamp(v17, 0, 180)
    p11.Right.Bar.UIGradient.Offset = Vector2.new(-0.01, 0)
    p11.Left.Bar.UIGradient.Offset = Vector2.new(0.01, 0)
end
local u19 = {
    ["Mera-Mera"] = Color3.fromRGB(255, 78, 19),
    ["Magu-Magu"] = Color3.fromRGB(255, 12, 12),
    ["Pika-Pika"] = Color3.fromRGB(255, 207, 33),
    ["Hie-Hie"] = Color3.fromRGB(170, 255, 255),
    ["Goro-Goro"] = Color3.fromRGB(190, 255, 255),
    ["Suna-Suna"] = Color3.fromRGB(255, 213, 160),
    ["Yami-Yami"] = Color3.fromRGB(85, 0, 255),
    ["Tori-Tori"] = Color3.fromRGB(0, 255, 255),
    ["Yuki-Yuki"] = Color3.fromRGB(240, 255, 253),
    ["PikaV2-PikaV2"] = Color3.fromRGB(255, 207, 33),
    ["Smoke-Smoke"] = Color3.fromRGB(181, 181, 181)
}
function u10.Initialize(p20) --[[ Line: 70 ]]
    --[[
    Upvalues:
        [1] = u10
        [2] = u5
        [3] = u6
        [4] = u4
        [5] = u2
        [6] = u9
        [7] = u19
        [8] = u3
        [9] = u18
        [10] = u8
    --]]
    if u10.Initialized then
        warn("HUD already initialized")
        return
    else
        local u21 = require(u5:WaitForChild("InputHandler"))
        local u22 = require(u5:WaitForChild("InputHandler"):WaitForChild("GetPreferredInput"))
        local u23 = require(u6.ContextActionService)
        local v24 = u4:WaitForChild("Modes")
        local u25 = v24:WaitForChild("Frame")
        local u26 = u25:WaitForChild("GeneralBars")
        local u27 = u23:GetButtonParent("Ultimate") or u26:WaitForChild("Ultimate", 2)
        local u28 = u23:GetButtonParent("Logia") or u26:WaitForChild("Logia", 2)
        local u29 = u23:GetButtonParent("Buso") or u26:WaitForChild("Buso", 2)
        local u30 = u23:GetButtonParent("Ken") or u26:WaitForChild("Ken", 2)
        local u31 = u23:GetButtonParent("Evasive") or u26:FindFirstChild("Evasive", 2)
        local u32 = u25:WaitForChild("PVP")
        local u33 = u25.Position
        local u34 = p20:GetStatsFolder()
        print("stats", u34:GetChildren())
        local u35 = u34.Stats
        local u36 = u35.DF
        local u37 = u34.LogiaBar
        local u38 = u35.LogiaMastery
        local v39 = u28:WaitForChild("Background")
        local u40 = v39:WaitForChild("ActionIcon")
        local u41 = u35.BusoMastery
        local u42 = u34.BusoBar
        local u43 = u35.KenMastery
        local u44 = u34.KenBar
        local u45 = u2.reservedCode
        local v46 = u9:GetPlaceIds()[game.PlaceId]
        if v46 == nil or v46 ~= "Trade Hub" then
            local function v49() --[[ Line: 115 ]]
                --[[
                Upvalues:
                    [1] = u36
                    [2] = u19
                    [3] = u38
                    [4] = u3
                    [5] = u28
                    [6] = u18
                    [7] = u37
                    [8] = u34
                --]]
                local v47 = u19[u36.Value]
                if u38.Value > 0 and (v47 and _G.playerFruitPassiveEnabled(u3) == true) then
                    local _, _, _ = v47:ToHSV()
                    local v48 = u28
                    v48.Left.Bar.ImageColor3 = v47
                    v48.Right.Bar.ImageColor3 = v47
                    u18(u28, u37.Value, u37.MaxValue)
                    if u34.Stats.DF.Value == "Tori-Tori" then
                        u28.Display.Text = "Passive"
                    else
                        u28.Display.Text = "Logia"
                    end
                    if u37.Value >= u37.MaxValue then
                        script.LogiaCharge:Play()
                    elseif u37.Value <= 0 then
                        script.LogiaRunOut:Play()
                    end
                    u28.Visible = true
                else
                    u28.Visible = false
                end
            end
            u36:GetPropertyChangedSignal("Value"):Connect(v49)
            u37.Changed:Connect(v49)
            v49()
            if u34.Settings.Logia.Value == true then
                u40.ImageColor3 = Color3.fromRGB(255, 255, 255)
            else
                u40.ImageColor3 = Color3.fromRGB(255, 0, 0)
            end
            v39.MouseButton1Click:Connect(function() --[[ Line: 155 ]]
                --[[
                Upvalues:
                    [1] = u2
                    [2] = u34
                    [3] = u40
                --]]
                u2.Events.Settings:InvokeServer("Logia", not u34.Settings.Logia.Value)
                if u34.Settings.Logia.Value == true then
                    u40.ImageColor3 = Color3.fromRGB(255, 255, 255)
                else
                    u40.ImageColor3 = Color3.fromRGB(255, 0, 0)
                end
                local v50 = ""
                local v51 = u34.Stats.DF.Value
                if u34.Settings.Logia.Value == false then
                    local v52 = (v51 == "Hie-Hie" or v51 == "Magu-Magu") and "Your ability to walk on water has also been disabled." or v50
                    _G.displayMessage("<Color=Red>Your Logia reflex has been disabled. " .. v52)
                else
                    local v53 = (v51 == "Hie-Hie" or v51 == "Magu-Magu") and "Your ability to walk on water has also been enabled." or v50
                    _G.displayMessage("<Color=Green>Your Logia reflex has been enabled. " .. v53)
                end
            end)
            local function v54() --[[ Line: 175 ]]
                --[[
                Upvalues:
                    [1] = u43
                    [2] = u18
                    [3] = u30
                    [4] = u44
                    [5] = u34
                --]]
                if u43.Value > 0 then
                    u18(u30, u44.Value, u44.MaxValue)
                    if u44.Value >= u44.MaxValue then
                        script.KenCharge:Play()
                    elseif u44.Value <= 0 then
                        script.KenRunOut:Play()
                    end
                    u30.Visible = true
                else
                    u30.Visible = false
                end
                u30.Left.Bar.ImageColor3 = u34.Customization.KenColor.Value
                u30.Right.Bar.ImageColor3 = u34.Customization.KenColor.Value
            end
            u44:GetPropertyChangedSignal("Value"):Connect(v54)
            u44:GetPropertyChangedSignal("MaxValue"):Connect(v54)
            v54()
            local function v55() --[[ Line: 198 ]]
                --[[
                Upvalues:
                    [1] = u41
                    [2] = u18
                    [3] = u29
                    [4] = u42
                    [5] = u34
                --]]
                if u41.Value > 0 then
                    u18(u29, u42.Value, u42.MaxValue)
                    if u42.Value >= u42.MaxValue then
                        script.BusoCharged:Play()
                    elseif u42.Value <= 0 then
                        script.BusoRunOut:Play()
                    end
                    u29.Visible = true
                else
                    u29.Visible = false
                end
                u29.Left.Bar.ImageColor3 = u34.Customization.BusoColor.Value
                u29.Right.Bar.ImageColor3 = u34.Customization.BusoColor.Value
            end
            u42:GetPropertyChangedSignal("Value"):Connect(v55)
            u42:GetPropertyChangedSignal("MaxValue"):Connect(v55)
            v55()
            u34.Settings.PVPMode:GetPropertyChangedSignal("Value"):Connect(function() --[[ Name: OnPVPChanged, Line 219 ]]
                --[[
                Upvalues:
                    [1] = u32
                    [2] = u34
                --]]
                if game.ReplicatedStorage.reservedCode.Value == "arena" then
                    u32.Visible = false
                    return
                elseif u34.Settings.PVPMode.Value == false then
                    u32.Visible = true
                else
                    u32.Visible = false
                end
            end)
            if game.ReplicatedStorage.reservedCode.Value == "arena" then
                u32.Visible = false
            elseif u34.Settings.PVPMode.Value == false then
                u32.Visible = true
            else
                u32.Visible = false
            end
            local function u68() --[[ Line: 236 ]]
                --[[
                Upvalues:
                    [1] = u21
                    [2] = u27
                    [3] = u45
                    [4] = u3
                    [5] = u35
                    [6] = u8
                    [7] = u18
                --]]
                u21:GetCurrentInput()
                u27.Visible = false
                if u45.Value == "arena" then
                    u3:WaitForChild("UltsUsed")
                    local u56 = u3:WaitForChild("leaderstats")
                    local u57 = u56:FindFirstChild("UltBar")
                    u35:WaitForChild("SkillPoints")
                    u56:WaitForChild("Damage")
                    local u58 = u8.CheckUltDamage(u3)
                    local u59 = false
                    local function v67() --[[ Line: 257 ]]
                        --[[
                        Upvalues:
                            [1] = u57
                            [2] = u56
                            [3] = u27
                            [4] = u58
                            [5] = u8
                            [6] = u3
                            [7] = u59
                            [8] = u18
                        --]]
                        u57 = u56:FindFirstChild("UltBar")
                        if u57 ~= nil then
                            u27.Visible = true
                            u58 = u8.CheckUltDamage(u3)
                            local v60 = 1
                            local v61 = u57.Value
                            local v62 = v61 / u58
                            local v63 = math.clamp(v62, 0, 1)
                            local v64 = os.clock() % v60 / v60
                            local v65 = Color3.fromHSV(v64, 1, 1)
                            if v63 >= 1 then
                                u27.Display.Text = "Ultimate Ready"
                                if u59 == false then
                                    u59 = true
                                    script.UltBarFull:Play()
                                end
                                local v66 = u27
                                v66.Left.Bar.ImageColor3 = v65
                                v66.Right.Bar.ImageColor3 = v65
                            else
                                u59 = false
                                u27.Display.Text = "Ultimate"
                            end
                            u18(u27, v61, u58)
                        end
                    end
                    game["Run Service"].Heartbeat:Connect(v67)
                else
                    u27.Visible = false
                end
            end
            if u45.Value == "checking" then
                local u69 = nil
                u69 = u45:GetPropertyChangedSignal("Value"):Connect(function() --[[ Line: 299 ]]
                    --[[
                    Upvalues:
                        [1] = u45
                        [2] = u69
                        [3] = u68
                    --]]
                    if u45.Value ~= "checking" then
                        u69:Disconnect()
                        u69 = nil
                        u68()
                    end
                end)
            else
                u68()
            end
            local u70 = "None"
            local u71 = nil
            local function u76() --[[ Line: 311 ]]
                --[[
                Upvalues:
                    [1] = u22
                    [2] = u70
                    [3] = u23
                    [4] = u26
                    [5] = u25
                    [6] = u33
                    [7] = u71
                --]]
                if u22.Current == "Mobile" and u70 ~= "Mobile" then
                    u70 = "Mobile"
                    local _, _, u72 = u23:GetMobileUI()
                    print("MODE BARS SHOULD BE LOADED")
                    local function v75() --[[ Line: 318 ]]
                        --[[
                        Upvalues:
                            [1] = u23
                            [2] = u26
                            [3] = u72
                            [4] = u25
                            [5] = u33
                        --]]
                        local v73, _ = u23:GetPositionAndSize()
                        for _, v74 in ipairs(u26:GetChildren()) do
                            if v74:IsA("Frame") then
                                v74.Size = UDim2.fromOffset(u72.AbsoluteSize.X * 0.85, u72.AbsoluteSize.Y * 0.85)
                            end
                        end
                        u25.Position = UDim2.new(0, 0, u33.Y.Scale, -v73.Y.Offset / 2)
                    end
                    v75()
                    if u71 then
                        return
                    end
                    u71 = u72:GetPropertyChangedSignal("AbsoluteSize"):Connect(v75)
                end
            end
            u76()
            u22.Observe(function(_) --[[ Line: 338 ]]
                --[[
                Upvalues:
                    [1] = u76
                --]]
                u76()
            end)
            print("is this getting reached?")
            function _G.BusoRed(_) --[[ Line: 347 ]] end
            local u77 = nil
            local function v83(u78) --[[ Line: 373 ]]
                --[[
                Upvalues:
                    [1] = u77
                    [2] = u18
                    [3] = u31
                --]]
                local u79 = u78:WaitForChild("Humanoid")
                if u77 then
                    u77:Disconnect()
                    u77 = nil
                end
                local function v81() --[[ Line: 382 ]]
                    --[[
                    Upvalues:
                        [1] = u79
                        [2] = u78
                        [3] = u18
                        [4] = u31
                    --]]
                    local v80 = u79.MaxHealth * u78:GetAttribute("healthPercentEvasive") + u78:GetAttribute("baseEvasiveReq")
                    u18(u31, u78:GetAttribute("evasiveBar"), v80)
                end
                u77 = u78:GetAttributeChangedSignal("evasiveBar"):Connect(v81)
                local v82 = u79.MaxHealth * u78:GetAttribute("healthPercentEvasive") + u78:GetAttribute("baseEvasiveReq")
                u18(u31, u78:GetAttribute("evasiveBar"), v82)
            end
            v83(u3.Character or u3.CharacterAdded:Wait())
            u3.CharacterAdded:Connect(v83)
            u10.Initialized = true
        else
            v24.Enabled = false
        end
    end
end
return u10