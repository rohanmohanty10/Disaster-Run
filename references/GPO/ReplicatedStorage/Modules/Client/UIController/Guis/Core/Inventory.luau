 

local v1 = game:GetService("Players")
game:GetService("ReplicatedStorage")
game:GetService("TweenService")
game:GetService("UserInputService")
local u2 = game:GetService("HttpService")
game:GetService("RunService")
local u3 = game:GetService("ReplicatedStorage")
local v4 = u3:WaitForChild("Modules")
local v5 = v4.Shared
local v6 = v4.Client
local u7 = v4:WaitForChild("ToolDesc")
require(v4.Leveling)
require(v5.GameUtils)
require(v5.SoundUtils)
local u8 = require(u7)
local u9 = require(v5.Queues.QueueTask)
local u10 = require(v4.Module3D)
local u11 = require(v4.RichText)
require(v5.Maids.Maid)
local u12 = require(v4.Titles)
local u13 = require(game.ReplicatedStorage.Modules.Trove)
local u14 = require(u3.Modules.Shared.TailorCodec)
local u15 = u3:WaitForChild("Events")
local u16 = require(u3.Modules.Shared.Signals.GoodSignal)
local v17 = v6:WaitForChild("UIs")
local u18 = require(v17:WaitForChild("RarityGradient"))
local u19 = v1.LocalPlayer
local u20 = u19:WaitForChild("PlayerGui")
local u21 = u3:WaitForChild("Tools")
local v22 = script:WaitForChild("Gradients")
local u23 = {
    ["Uncommon"] = v22:WaitForChild("Uncommon"),
    ["Rare"] = v22:WaitForChild("Rare"),
    ["Epic"] = v22:WaitForChild("Epic"),
    ["Legendary"] = v22:WaitForChild("Legendary"),
    ["Mythical"] = v22:WaitForChild("Mythical"),
    ["Collectable"] = v22:WaitForChild("Collectable")
}
local u24 = table.freeze({
    ["Common"] = 0,
    ["Uncommon"] = -200,
    ["Rare"] = -400,
    ["Epic"] = -600,
    ["Legendary"] = -800,
    ["Mythical"] = -1000,
    ["Collectable"] = -1200
})
local u25 = table.freeze({
    ["Mythical"] = 0,
    ["Legendary"] = 1,
    ["Epic"] = 2,
    ["Rare"] = 3,
    ["Common"] = 4
})
local u26 = {
    ["HP"] = {
        ["Display"] = "Extra Health",
        ["UsePercentValue"] = false,
        ["Color"] = Color3.fromRGB(170, 255, 0)
    },
    ["Regen"] = {
        ["Display"] = "Health Regen",
        ["UsePercentValue"] = false,
        ["Color"] = Color3.fromRGB(170, 255, 127)
    },
    ["Stam"] = {
        ["Display"] = "Stamina Regen",
        ["UsePercentValue"] = false,
        ["Color"] = Color3.fromRGB(85, 255, 255)
    },
    ["MaxStam"] = {
        ["Display"] = "Extra Stamina",
        ["UsePercentValue"] = false,
        ["Color"] = Color3.fromRGB(0, 255, 255)
    },
    ["swordMultiplier"] = {
        ["Display"] = "Sword DMG Mult",
        ["UsePercentValue"] = true,
        ["Color"] = Color3.fromRGB(85, 85, 255)
    },
    ["strengthMultiplier"] = {
        ["Display"] = "STR DMG Mult",
        ["UsePercentValue"] = true,
        ["Color"] = Color3.fromRGB(255, 170, 127)
    },
    ["damageMultiplier"] = {
        ["Display"] = "DMG Multiplier",
        ["UsePercentValue"] = true,
        ["Color"] = Color3.fromRGB(255, 85, 0)
    },
    ["ReducedDMG"] = {
        ["Display"] = "Reduced DMG",
        ["UsePercentValue"] = true,
        ["Color"] = Color3.fromRGB(170, 170, 255)
    },
    ["BurnResistance"] = {
        ["Display"] = "Reduced Burn",
        ["UsePercentValue"] = true,
        ["Color"] = Color3.fromRGB(255, 85, 0)
    },
    ["FreezeResistance"] = {
        ["Display"] = "Reduced Freeze",
        ["UsePercentValue"] = true,
        ["Color"] = Color3.fromRGB(170, 255, 255)
    },
    ["AntiHeal"] = {
        ["Display"] = "Grevious Wounds",
        ["UsePercentValue"] = true,
        ["Color"] = Color3.fromRGB(57, 113, 0)
    }
}
local function u41(p27, p28, p29) --[[ Line: 90 ]]
    --[[
    Upvalues:
        [1] = u26
    --]]
    local v30 = u26[p28]
    local v31 = v30.Color
    if typeof(p29) == "number" and p29 <= 0 then
        p27.Visible = false
        return
    end
    p27.Visible = true
    if v30.UsePercentValue == true then
        local v32 = p29 * 100 * 100
        v40 = math.floor(v32) / 100 .. "%"
        if v40 then
            ::l6::
            local v33 = v30.Display
            local v34 = v31.R * 255
            local v35 = math.floor(v34)
            local v36 = v31.G * 255
            local v37 = math.floor(v36)
            local v38 = v31.B * 255
            p27.Text = ("%*: <font color=\"rgb(%*, %*, %*)\"><b>%*</b></font>"):format(v33, v35, v37, math.floor(v38), v40)
            return
        end
    end
    local v39 = p29 * 100
    local v40 = math.floor(v39) / 100
    goto l6
end
local u496 = {
    ["Initialized"] = false,
    ["DisplayItemStats"] = function(p42, p43) --[[ Name: DisplayItemStats, Line 114 ]]
        --[[
        Upvalues:
            [1] = u7
            [2] = u8
            [3] = u41
        --]]
        local v44 = u7.ItemStats:FindFirstChild(p43)
        if v44 == nil and (u8[p43] and u8[p43].BaseItem ~= nil) then
            v44 = u7.ItemStats:FindFirstChild(u8[p43].BaseItem)
        end
        local v45 = v44 and v44:GetAttributes() or {}
        for _, v46 in ipairs(p42:GetChildren()) do
            if v46:IsA("TextLabel") then
                local v47 = v45[v46.Name]
                u41(v46, v46.Name, v47 or 0)
            end
        end
    end,
    ["Initialize"] = function(u48) --[[ Name: Initialize, Line 131 ]]
        --[[
        Upvalues:
            [1] = u496
            [2] = u3
            [3] = u20
            [4] = u18
            [5] = u8
            [6] = u2
            [7] = u15
            [8] = u11
            [9] = u19
            [10] = u23
            [11] = u25
            [12] = u9
            [13] = u21
            [14] = u10
            [15] = u24
            [16] = u12
            [17] = u7
            [18] = u41
            [19] = u14
            [20] = u16
            [21] = u13
        --]]
        if not u496.Initialized then
            u3:WaitForChild("reservedCode")
            local u49 = u48:GetStatsFolder()
            local v50 = u49:WaitForChild("Stats")
            local v51 = u49:WaitForChild("Inventory")
            local u52 = v51:WaitForChild("Inventory")
            local u53 = v51:WaitForChild("Equiped")
            local u54 = v51:WaitForChild("VanitySlots")
            local u55 = v50:WaitForChild("FightingStyle")
            local u56 = v51:WaitForChild("KatanaOrder")
            local u57 = v51:WaitForChild("EquipedShip")
            local v58 = u49:WaitForChild("Titles")
            local u59 = v58:WaitForChild("AllTitles")
            local u60 = v58:WaitForChild("EquipedTitle")
            local u61 = u49:WaitForChild("Settings"):WaitForChild("AutoEquip")
            local u62 = u49:WaitForChild("Grips"):WaitForChild("EquipedGrip")
            local u63 = u20:WaitForChild("Inventory", 360)
            local u64 = u63:WaitForChild("Main")
            local v65 = u64:WaitForChild("Inventory")
            local u66 = v65:WaitForChild("List")
            local v67 = u64:WaitForChild("TopTabs")
            local u68 = u66:WaitForChild("UIGridLayout")
            local u69 = u66:WaitForChild("UIPadding")
            local v70 = v65:WaitForChild("Search")
            local u71 = v70:WaitForChild("Input")
            local u72 = v70:WaitForChild("Clear")
            local u73 = u64:WaitForChild("ItemMenu")
            local u74 = u73:WaitForChild("Health")
            local u75 = u74:WaitForChild("Bar")
            local u76 = u73:WaitForChild("Equip")
            local u77 = u76:WaitForChild("Usage")
            local u78 = u73:WaitForChild("Drop")
            local v79 = u73:WaitForChild("MiscButtons")
            local u80 = v79:WaitForChild("Vanity")
            local u81 = v79:WaitForChild("CustomTailoredToggle")
            local u82 = u73:WaitForChild("SwordButtons")
            local u83 = u73:WaitForChild("Stats")
            local u84 = u64:WaitForChild("StatusBoosts"):WaitForChild("Boosts")
            local u85 = u64:WaitForChild("Selections"):WaitForChild("Frames")
            local u86 = u64:WaitForChild("RarityFilter")
            local u87 = u64:WaitForChild("Grips")
            local u88 = u87:WaitForChild("List")
            local u89 = u64:WaitForChild("LoadoutFrame")
            local u90 = u73.FavButton
            u64.Visible = false
            u63:GetPropertyChangedSignal("Enabled"):Connect(function() --[[ Line: 204 ]]
                --[[
                Upvalues:
                    [1] = u63
                    [2] = u18
                --]]
                local v91 = u63.Enabled
                print("Visible", v91)
                u18.SetRainbowGradientsGui(u63, v91)
            end)
            local u92 = {}
            local u93 = {}
            local u94 = {}
            local u95 = {}
            local u96 = 1
            local u97 = nil
            local v98 = Vector2.new(1920, 1080)
            local v99 = workspace.Camera.ViewportSize
            local v100 = 5 * ((v99.X + v99.Y) / 2 / ((v98.X + v98.Y) / 2))
            local u101 = math.round(v100)
            u68.CellPadding = UDim2.new(0, u101, 0, u101)
            local v102 = u3:FindFirstChild("battleRoyaleDrop")
            local u103 = u3:FindFirstChild("tradingHUB")
            local u104 = nil
            local function u118(p105, p106) --[[ Line: 324 ]]
                --[[
                Upvalues:
                    [1] = u97
                    [2] = u2
                    [3] = u53
                    [4] = u8
                    [5] = u57
                    [6] = u76
                    [7] = u77
                --]]
                local v107 = p105 or u97
                if v107 == nil then
                    return
                else
                    local v108 = p106 or v107:GetAttribute("itemName")
                    if v108 ~= nil then
                        local v109 = u2:JSONDecode(u53.Value)
                        local v110 = table.find(v109, v108)
                        local v111 = u8[v108]
                        if v111 and v111.Type == "Ship" then
                            v110 = u57.Value == v108
                        end
                        local v112 = u8[v108]
                        u76.Visible = v112.Type ~= "Display"
                        if (v110 and true or false) == true then
                            u77.Text = "Unequip"
                        elseif v112.OneTime then
                            if v112.Type == "Fruit" then
                                u77.Text = "Equip"
                            else
                                u77.Text = "Use"
                            end
                        else
                            u77.Text = "Equip"
                        end
                        if v112 and v112.Type == "Ship" then
                            local v113 = v107:GetAttribute("amountOwned") or 1
                            local v114 = v107.Border
                            local _ = u8[v108]
                            local v115 = u2:JSONDecode(u53.Value)
                            local v116 = table.find(v115, v108)
                            local v117 = u8[v108]
                            if v117 and v117.Type == "Ship" then
                                v116 = u57.Value == v108
                            end
                            if (v116 and true or false) == true then
                                v114.ImageTransparency = 0
                            else
                                v114.ImageTransparency = 0.9
                            end
                            v107.Amount.Text = ("x%*"):format(v113)
                        end
                    end
                end
            end
            local function u124(p119) --[[ Line: 357 ]]
                --[[
                Upvalues:
                    [1] = u8
                    [2] = u82
                    [3] = u55
                    [4] = u2
                    [5] = u56
                --]]
                local v120 = u8[p119]
                if p119:match("Katana") == nil and v120.isKatana == nil then
                    u82.Visible = false
                else
                    u82.Visible = true
                end
                if u55.Value == "2SS" or u55.Value == "3SS" then
                    if u55.Value == "3SS" then
                        u82.Head.Visible = true
                    else
                        u82.Head.Visible = false
                    end
                    for v121, v122 in pairs(u2:JSONDecode(u56.Value)) do
                        local v123 = v122 == p119 and Color3.fromRGB(170, 170, 255) or Color3.fromRGB(255, 255, 255)
                        u82[v121].TextColor3 = v123
                    end
                else
                    u82.Visible = false
                end
            end
            local u125 = {
                ["Cap"] = true,
                ["Cape"] = true,
                ["Glasses"] = true,
                ["Jaw"] = true,
                ["Back"] = true,
                ["Outfit"] = true,
                ["Headband"] = true,
                ["Ears"] = true,
                ["NormalOutfit"] = true,
                ["Head"] = true,
                ["Waist"] = true,
                ["ASESlot"] = true,
                ["TorsoScarf"] = true
            }
            local function u134(p126, p127) --[[ Line: 400 ]]
                --[[
                Upvalues:
                    [1] = u97
                    [2] = u8
                    [3] = u125
                    [4] = u80
                    [5] = u2
                    [6] = u54
                    [7] = u57
                --]]
                local v128 = p126 or u97
                if v128 == nil then
                    return
                else
                    local v129 = p127 or v128:GetAttribute("itemName")
                    if v129 == nil then
                        return
                    else
                        local v130 = u8[v129]
                        if v130 == nil or u125[v130.Type] == nil then
                            u80.Visible = false
                        else
                            u80.Visible = true
                            local v131 = u2:JSONDecode(u54.Value)
                            local v132 = table.find(v131, v129)
                            local v133 = u8[v129]
                            if v133 and v133.Type == "Ship" then
                                v132 = u57.Value == v129
                            end
                            u80.Text = "Set Vanity: " .. ((v132 and true or false) and "<b><font color=\"rgb(170,255,0)\">ON</font></b>" or "<b><font color=\"rgb(255, 0, 0)\">OFF</font></b>")
                        end
                    end
                end
            end
            local function u141(p135, p136) --[[ Line: 424 ]]
                --[[
                Upvalues:
                    [1] = u97
                    [2] = u81
                    [3] = u8
                    [4] = u2
                    [5] = u49
                --]]
                local v137 = p135 or u97
                if v137 == nil then
                    u81.Visible = false
                    return
                else
                    local v138 = p136 or v137:GetAttribute("itemName")
                    if v138 == nil then
                        u81.Visible = false
                        return
                    else
                        local v139 = u8[v138]
                        local v140 = u2:JSONDecode(u49.Inventory.CustomTailoredOutfitsToggle.Value)
                        if v139 == nil or v140[v138] == nil then
                            u81.Visible = false
                        else
                            u81.Visible = true
                            u81.Text = "Tailored: " .. (v140[v138] == true and "<b><font color=\"rgb(170,255,0)\">ON</font></b>" or "<b><font color=\"rgb(255, 0, 0)\">OFF</font></b>")
                        end
                    end
                end
            end
            local function u153(u142, u143, _) --[[ Line: 455 ]]
                --[[
                Upvalues:
                    [1] = u8
                    [2] = u97
                    [3] = u73
                    [4] = u18
                    [5] = u63
                    [6] = u2
                    [7] = u49
                    [8] = u90
                    [9] = u104
                    [10] = u74
                    [11] = u15
                    [12] = u75
                    [13] = u118
                    [14] = u124
                    [15] = u134
                    [16] = u141
                    [17] = u496
                    [18] = u83
                    [19] = u11
                --]]
                local u144 = u8[u143]
                if u144 == nil then
                    return
                elseif u142 == u97 then
                    u73.Visible = false
                    u97 = nil
                else
                    local v145 = u142.Border.UIGradient
                    u73.Visible = true
                    u97 = u142
                    u73.ItemName.Text = u143
                    u73.Rarity.Text = u144.Chroma and u144.Rare .. " Chroma" or u144.Rare
                    u73.Rarity.UIGradient.Color = v145.Color
                    if u144.Rare == "Legendary" or u144.Chroma ~= nil then
                        u18.BindRainbowGradient(u73.Rarity.UIGradient, u63)
                    end
                    local v146 = u2:JSONDecode(u49.Inventory.FavItems.Value)
                    if table.find(v146, u143) then
                        u90.ImageColor3 = Color3.fromRGB(255, 255, 127)
                    else
                        u90.ImageColor3 = Color3.fromRGB(175, 175, 87)
                    end
                    if u104 ~= nil and coroutine.status(u104) ~= "dead" then
                        task.cancel(u104)
                        u104 = nil
                    end
                    u104 = task.spawn(function() --[[ Line: 495 ]]
                        --[[
                        Upvalues:
                            [1] = u144
                            [2] = u74
                            [3] = u15
                            [4] = u143
                            [5] = u97
                            [6] = u142
                            [7] = u75
                        --]]
                        if u144.Type == "Ship" and _G.isCustomHUB == false then
                            u74.Visible = true
                            local v147 = {
                                ["action"] = "getHP",
                                ["ship"] = u143
                            }
                            local v148 = u15.ShipEvents.Spawn:InvokeServer(v147)
                            if u97 ~= u142 then
                                return
                            end
                            if v148 then
                                local v149, v150 = unpack(v148)
                                local v151 = math.clamp(v149, 0, v150)
                                local v152 = v151 / v150
                                u75.BackgroundColor3 = Color3.fromRGB(255, 0, 0):Lerp(Color3.fromRGB(170, 255, 0), v152)
                                u75.Size = UDim2.new(v152, 0, 1, 0)
                                u74.Display.Text = v151 .. "/" .. v150
                                return
                            end
                        else
                            u74.Visible = false
                        end
                    end)
                    u118(u142, u143)
                    u124(u143)
                    u134(u142, u143)
                    u141(u142, u143)
                    u496.DisplayItemStats(u83, u143)
                    u11:New(u73.Desc, u144.Desc, {
                        ["ZIndex"] = 10,
                        ["TextScale"] = 0.2,
                        ["AnimateStepFrequency"] = 3
                    }):Animate(true)
                end
            end
            local u154 = false
            u90.MouseButton1Click:Connect(function() --[[ Line: 539 ]]
                --[[
                Upvalues:
                    [1] = u97
                    [2] = u154
                    [3] = u2
                    [4] = u49
                    [5] = u15
                    [6] = u90
                --]]
                if u97 == nil then
                    return
                elseif u154 ~= true then
                    u154 = true
                    local v155 = u97:GetAttribute("itemName")
                    local v156 = u2:JSONDecode(u49.Inventory.FavItems.Value)
                    local v157 = not table.find(v156, v155)
                    if u15.Tools:InvokeServer("FavItem", v155, v157) == true then
                        u90.ImageColor3 = Color3.fromRGB(255, 255, 127)
                    else
                        u90.ImageColor3 = Color3.fromRGB(175, 175, 87)
                    end
                    u154 = false
                end
            end)
            local u158 = v102
            local u159 = u97
            local v160 = {}
            for _, u161 in ipairs(u82:GetChildren()) do
                if v160[u161.Name] ~= true and u161:IsA("TextButton") then
                    u161.MouseButton1Click:Connect(function() --[[ Line: 571 ]]
                        --[[
                        Upvalues:
                            [1] = u159
                            [2] = u8
                            [3] = u15
                            [4] = u161
                            [5] = u124
                        --]]
                        if u159 == nil then
                            return
                        else
                            local v162 = u159:GetAttribute("itemName")
                            if v162 == nil then
                                warn("Missing ItemName")
                            else
                                local v163 = u8[v162]
                                if v162:match("Katana") ~= nil or v163.isKatana ~= nil then
                                    u15.Tools:InvokeServer("katanaOrder", u161.Name, v162)
                                end
                                u124(v162)
                            end
                        end
                    end)
                end
            end
            local u164 = false
            u76.MouseButton1Click:Connect(function() --[[ Line: 591 ]]
                --[[
                Upvalues:
                    [1] = u164
                    [2] = u19
                    [3] = u159
                    [4] = u2
                    [5] = u53
                    [6] = u8
                    [7] = u57
                    [8] = u15
                    [9] = u118
                --]]
                if u164 == true then
                    return
                else
                    local v165 = u19.Character
                    if v165 == nil then
                        return
                    else
                        local v166 = v165:FindFirstChild("Humanoid")
                        if v166 then
                            if v166.Health <= 0 then
                                return
                            elseif _G.check:inspect(v165) == false and (v166.Sit == false and v165:FindFirstChild("Disabled") == nil) or _G.canuse == false then
                                return
                            else
                                local v167 = u159
                                if v167 == nil then
                                    return
                                else
                                    local v168 = v167:GetAttribute("itemName")
                                    if v168 ~= nil then
                                        local v169 = u2:JSONDecode(u53.Value)
                                        local v170 = table.find(v169, v168)
                                        local v171 = u8[v168]
                                        if v171 and v171.Type == "Ship" then
                                            v170 = u57.Value == v168
                                        end
                                        u164 = true
                                        if (v170 and true or false) == false and u57.Value ~= v168 then
                                            script.equipSFX:Play()
                                            u15.Tools:InvokeServer("equip", v168)
                                        else
                                            script.unequipSFX:Play()
                                            u15.Tools:InvokeServer("unequip", v168)
                                        end
                                        u164 = false
                                        u118()
                                    end
                                end
                            end
                        else
                            return
                        end
                    end
                end
            end)
            u80.MouseButton1Click:Connect(function() --[[ Line: 627 ]]
                --[[
                Upvalues:
                    [1] = u159
                    [2] = u15
                    [3] = u134
                --]]
                local v172 = u159
                if v172 == nil then
                    return
                else
                    local v173 = v172:GetAttribute("itemName")
                    if v173 ~= nil then
                        u15.Tools:InvokeServer("vanitySlot", v173)
                        u134()
                    end
                end
            end)
            u81.MouseButton1Click:Connect(function() --[[ Line: 639 ]]
                --[[
                Upvalues:
                    [1] = u159
                    [2] = u15
                    [3] = u141
                --]]
                local v174 = u159
                if v174 == nil then
                    return
                else
                    local v175 = v174:GetAttribute("itemName")
                    if v175 ~= nil then
                        u15.Tools:InvokeServer("toggleCustomTailored", v175)
                        u141()
                    end
                end
            end)
            u78.MouseButton1Click:Connect(function() --[[ Line: 651 ]]
                --[[
                Upvalues:
                    [1] = u158
                    [2] = u159
                --]]
                if u158 and u159 then
                    u158:FireServer(u159:GetAttribute("itemName"))
                end
            end)
            local function v183(p176, u177, u178) --[[ Line: 658 ]]
                --[[
                Upvalues:
                    [1] = u8
                    [2] = u23
                    [3] = u18
                --]]
                local v179 = u8[p176]
                if v179 == nil then
                    return
                else
                    local v180 = u23[v179.Rare]
                    if v180 ~= nil then
                        u177.Enabled = true
                        u177.Color = v180.Color
                        if v179.Rare == "Legendary" or v179.Chroma ~= nil then
                            local u181 = u177.Parent.Text
                            local u182 = not u8[u181] and "" or u8[u181].Rare
                            task.spawn(function() --[[ Line: 231 ]]
                                --[[
                                Upvalues:
                                    [1] = u178
                                    [2] = u177
                                    [3] = u181
                                    [4] = u8
                                    [5] = u182
                                    [6] = u18
                                --]]
                                while true do
                                    task.wait(0.02)
                                    if u178 then
                                        u178()
                                    end
                                    if u177.Parent == nil then
                                        break
                                    end
                                    if u177.Parent.Text ~= u181 then
                                        if u8[u177.Parent.Text] == nil then
                                            return
                                        end
                                        if u8[u177.Parent.Text].Rare ~= u182 then
                                            break
                                        end
                                    end
                                    u177.Color = u18.GetRainbowGradientColor()
                                end
                            end)
                        end
                    end
                end
            end
            warn("Todo: REPLACE THIS")
            _G.displayRareItem = v183
            local u184 = {}
            local function u189(u185, p186) --[[ Line: 681 ]]
                --[[
                Upvalues:
                    [1] = u8
                    [2] = u184
                    [3] = u25
                    [4] = u18
                    [5] = u63
                    [6] = u87
                    [7] = u15
                    [8] = u11
                    [9] = u88
                --]]
                local u187 = u8[u185]
                local v188 = u184[u185]
                if v188 == nil then
                    v188 = script.GripTemplate:Clone()
                    v188.Name = u185
                    v188.LayoutOrder = u25[u187.Rare]
                    u184[u185] = v188
                    v188.GripName.Text = u185
                    u18.ApplyRarityGradient(u185, v188.GripName.Gradient, u63, u87)
                    v188.MouseButton1Click:Connect(function() --[[ Line: 703 ]]
                        --[[
                        Upvalues:
                            [1] = u15
                            [2] = u185
                            [3] = u11
                            [4] = u87
                            [5] = u187
                        --]]
                        u15.Tools:InvokeServer("equipGrip", u185)
                        u11:New(u87.Description, u187.Desc, {
                            ["ZIndex"] = 10,
                            ["TextScale"] = 0.15,
                            ["AnimateStepFrequency"] = 3
                        }):Animate(true)
                    end)
                    v188.Parent = u88
                end
                v188.Owned.Text = ("x%*"):format(p186)
            end
            local function v190() --[[ Line: 718 ]]
                --[[
                Upvalues:
                    [1] = u62
                    [2] = u87
                    [3] = u18
                    [4] = u63
                --]]
                if u62.Value == "" then
                    u87.Current.Text = "None"
                else
                    u87.Current.Text = u62.Value
                    u18.ApplyRarityGradient(u62.Value, u87.Current.Gradient, u63, u87)
                end
            end
            u87:GetPropertyChangedSignal("Visible"):Connect(function() --[[ Line: 733 ]]
                --[[
                Upvalues:
                    [1] = u18
                    [2] = u87
                --]]
                u18.SetRainbowGradientsFrame(u87, u87.Visible)
            end)
            local u191 = {}
            local u192 = {}
            local function u196(p193) --[[ Line: 741 ]]
                --[[
                Upvalues:
                    [1] = u92
                    [2] = u191
                --]]
                local v194 = u92[p193]
                if v194 == nil then
                    return
                else
                    v194.vanityDisplay.Visible = false
                    local v195 = u191[p193]
                    if v195 == nil then
                        return
                    else
                        v194.vanityDisplay.Visible = true
                        if v195 == true then
                            v194.vanityDisplay.ImageColor3 = Color3.fromRGB(255, 0, 0)
                        else
                            v194.vanityDisplay.ImageColor3 = Color3.fromRGB(255, 255, 255)
                        end
                    end
                end
            end
            local function v201() --[[ Line: 773 ]]
                --[[
                Upvalues:
                    [1] = u2
                    [2] = u49
                    [3] = u191
                    [4] = u196
                --]]
                local v197 = u2:JSONDecode(u49.Inventory.VanitySlots.Value)
                local v198 = table.clone(u191)
                for _, v199 in pairs(v197) do
                    v198[v199] = nil
                    u191[v199] = true
                    u196(v199)
                end
                for v200, _ in pairs(v198) do
                    u191[v200] = nil
                    u196(v200)
                end
            end
            u49.Inventory.VanitySlots.Changed:Connect(v201)
            v201()
            local u202 = u9.new()
            local u203 = "None"
            local u204 = {
                ["Wearables"] = {
                    ["Back"] = true,
                    ["Cap"] = true,
                    ["Cape"] = true,
                    ["Ears"] = true,
                    ["Glasses"] = true,
                    ["Headband"] = true,
                    ["Jaw"] = true,
                    ["NormalOutfit"] = true,
                    ["Outfit"] = true,
                    ["Waist"] = true,
                    ["ASESlot"] = true,
                    ["TorsoScarf"] = true
                },
                ["Weapons"] = {
                    ["Gun"] = true,
                    ["Katana"] = true,
                    ["Katana2"] = true
                },
                ["Fruit"] = {
                    ["Fruit"] = true
                },
                ["Items"] = {
                    ["Artifact"] = true,
                    ["Back2"] = true,
                    ["Baloon"] = true,
                    ["Book"] = true,
                    ["Core"] = true,
                    ["Display"] = true,
                    ["Drink"] = true,
                    ["ETPose"] = true,
                    ["Egg"] = true,
                    ["Essence"] = true,
                    ["Food"] = true,
                    ["FruitBag"] = true,
                    ["FruitChest"] = true,
                    ["FruitRemover"] = true,
                    ["Hammer"] = true,
                    ["Item"] = true,
                    ["Key"] = true,
                    ["Mount"] = true,
                    ["Pet"] = true,
                    ["Fishing Rod"] = true
                },
                ["Ships"] = {
                    ["Ship"] = true
                },
                ["Fish"] = {
                    ["Fish"] = true
                },
                ["Cosmetics"] = {
                    ["Head"] = true,
                    ["NormalOutfit"] = true,
                    ["BattlePassItem"] = true
                }
            }
            local u205 = {}
            local u206 = {}
            local u207 = Vector2.one * -20
            local u208 = u68.AbsoluteCellSize
            local u209 = u66.AbsoluteWindowSize
            local v210 = u209 / u208
            local v211 = Vector2.new
            local v212 = v210.X
            local v213 = math.floor(v212)
            local v214 = v210.Y
            local u215 = v211(v213, (math.ceil(v214)))
            local u216 = false
            local u217 = ""
            local u218 = "None"
            local function u237() --[[ Line: 874 ]]
                --[[
                Upvalues:
                    [1] = u216
                    [2] = u66
                    [3] = u207
                    [4] = u215
                    [5] = u208
                    [6] = u68
                    [7] = u209
                    [8] = u206
                    [9] = u94
                    [10] = u205
                    [11] = u69
                --]]
                if u216 == true then
                    return
                elseif u66.ScrollingEnabled == false then
                    return
                elseif (u66.CanvasPosition - u207).Magnitude >= u215.Y then
                    u208 = u68.AbsoluteCellSize
                    u207 = u66.CanvasPosition
                    u209 = u66.AbsoluteWindowSize
                    u215 = u209 / u208
                    local v219 = Vector2.new
                    local v220 = u215.X
                    local v221 = math.floor(v220)
                    local v222 = u215.Y
                    u215 = v219(v221, (math.ceil(v222)))
                    local v223 = u66.CanvasPosition / u208
                    local v224 = Vector2.new
                    local v225 = v223.X
                    local v226 = math.floor(v225)
                    local v227 = v223.Y
                    local v228 = v224(v226, (math.floor(v227)))
                    for v229, v230 in pairs(u206) do
                        if u216 == true then
                            return
                        end
                        local v231 = v230.Y
                        local v232
                        if v228.Y <= v231 then
                            v232 = v231 <= v228.Y + u215.Y
                        else
                            v232 = false
                        end
                        if not v232 then
                            u94[v230.Object].Visible = false
                            v230.Object.Parent = nil
                            u206[v229] = nil
                        end
                    end
                    for v233 = v228.X, v228.X + u215.X do
                        if u216 == true then
                            return
                        end
                        for v234 = v228.Y, v228.Y + u215.Y do
                            if u216 == true then
                                return
                            end
                            local v235 = ("%*, %*"):format(v233, v234)
                            local v236 = u205[v235]
                            if v236 and u206[v235] == nil then
                                u94[v236].Visible = true
                                v236.Parent = u66
                                u206[v235] = {
                                    ["X"] = v233,
                                    ["Y"] = v234,
                                    ["Object"] = v236
                                }
                            end
                        end
                    end
                    u69.PaddingTop = UDim.new(0, u208.Y * v228.Y)
                end
            end
            u66:GetPropertyChangedSignal("CanvasPosition"):Connect(function() --[[ Line: 931 ]]
                --[[
                Upvalues:
                    [1] = u216
                    [2] = u237
                --]]
                if u216 ~= true then
                    u237()
                end
            end)
            local function u313(_) --[[ Line: 936 ]]
                --[[
                Upvalues:
                    [1] = u217
                    [2] = u66
                    [3] = u69
                    [4] = u216
                    [5] = u2
                    [6] = u52
                    [7] = u53
                    [8] = u49
                    [9] = u92
                    [10] = u184
                    [11] = u208
                    [12] = u68
                    [13] = u209
                    [14] = u215
                    [15] = u71
                    [16] = u8
                    [17] = u189
                    [18] = u21
                    [19] = u203
                    [20] = u218
                    [21] = u204
                    [22] = u57
                    [23] = u93
                    [24] = u96
                    [25] = u18
                    [26] = u23
                    [27] = u95
                    [28] = u10
                    [29] = u94
                    [30] = u153
                    [31] = u196
                    [32] = u24
                    [33] = u206
                    [34] = u205
                    [35] = u101
                    [36] = u159
                    [37] = u73
                --]]
                local v238 = u217 ~= ""
                if v238 == true then
                    u66.ScrollingEnabled = false
                    u66.CanvasPosition = Vector2.new(0, 0)
                    u69.PaddingTop = UDim.new(0, 0)
                end
                u216 = true
                local v239 = u2:JSONDecode(u52.Value)
                u2:JSONDecode(u53.Value)
                local v240 = u2:JSONDecode(u49.Inventory.FavItems.Value)
                local v241 = 0
                local v242 = table.clone(u92)
                local v243 = table.clone(u184)
                local v244 = {}
                local v245 = {
                    ["Common"] = 0,
                    ["Uncommon"] = 0,
                    ["Rare"] = 0,
                    ["Epic"] = 0,
                    ["Legendary"] = 0,
                    ["Mythical"] = 0,
                    ["Collectable"] = 0,
                    ["Equipped"] = 0
                }
                u208 = u68.AbsoluteCellSize
                u209 = u66.AbsoluteWindowSize
                u215 = u209 / u208
                local v246 = Vector2.new
                local v247 = u215.X
                local v248 = math.floor(v247)
                local v249 = u215.Y
                u215 = v246(v248, (math.ceil(v249)))
                local v250 = u71.Text
                local v251 = string.lower(v250)
                for u252, u253 in pairs(v239) do
                    local v254 = u8[u252]
                    if v254 ~= nil then
                        if v254.Type == "Grip" then
                            u189(u252, u253)
                            if v243[u252] ~= nil then
                                v243[u252] = nil
                            end
                        else
                            local v255 = u252:match("Eternal Pose") and (u21:FindFirstChild("Eternal Pose") and u21["Eternal Pose"]:Clone()) or u21:FindFirstChild(u252)
                            if v255 ~= nil then
                                local u256 = u92[u252]
                                local v257 = v254.Rare
                                local v258
                                if u203 == "None" then
                                    v258 = v238 ~= true and true or (string.find(string.lower(u252), string.lower(v251), 1, true) and true or false)
                                    if u218 ~= "None" and v257 ~= u218 then
                                        v258 = false
                                    end
                                else
                                    local v259 = u204[u203]
                                    if v259 then
                                        v259 = v259[v254.Type]
                                    end
                                    if u203 == "Cosmetics" and (v254.Cosmetic ~= nil or (v254.Rare == "Collectable" or v254.BattlePassItem ~= nil)) and true or v259 then
                                        v258 = v238 ~= true and true or (string.find(string.lower(u252), string.lower(v251), 1, true) and true or false)
                                    else
                                        v258 = false
                                    end
                                    if u203 ~= "None" and v251 ~= "" then
                                        v258 = string.find(string.lower(u252), string.lower(v251), 1, true) and true or false
                                    end
                                    if u218 ~= "None" and v257 ~= u218 then
                                        v258 = false
                                    end
                                end
                                if v258 == false then
                                    if u256 then
                                        u256.Parent = nil
                                    end
                                    v242[u252] = nil
                                else
                                    local v260 = u8[u252]
                                    local v261 = u2:JSONDecode(u53.Value)
                                    local v262 = table.find(v261, u252)
                                    local v263 = u8[u252]
                                    if v263 and v263.Type == "Ship" then
                                        v262 = u57.Value == u252
                                    end
                                    local v264 = v262 and true or false
                                    if u256 == nil then
                                        if v241 == 10 then
                                            task.wait()
                                            v241 = 0
                                        end
                                        v241 = v241 + 1
                                        u256 = script.EmptyTemplate:Clone()
                                        u256.Name = u252
                                        u92[u252] = u256
                                        u256:SetAttribute("itemName", u252)
                                        u256:SetAttribute("itemType", v260.Type)
                                        u256:SetAttribute("itemRarity", v260.Rare)
                                        u256:SetAttribute("amountOwned", u253)
                                        u256.ItemName.Text = u252
                                        u256.ItemName.ZIndex = 10
                                        local u265 = u256.Border
                                        local u266 = u265.UIGradient
                                        if u93[v260.Type] == nil then
                                            u93[v260.Type] = u96 + 1
                                            u96 = u96 + 1
                                        end
                                        local u267 = u256.ItemName.ItemRare
                                        local u268 = nil
                                        local function u270() --[[ Line: 1094 ]]
                                            --[[
                                            Upvalues:
                                                [1] = u267
                                                [2] = u18
                                            --]]
                                            local v269 = u267.Parent.Text
                                            while true do
                                                task.wait(0.02)
                                                if u267.Parent == nil or u267.Parent.Text ~= v269 then
                                                    break
                                                end
                                                u267.Color = u18.GetRainbowGradientColor()
                                            end
                                        end
                                        local v271 = u23[v260.Rare]
                                        if v271 then
                                            u267.Enabled = true
                                            u267.Color = v271.Color
                                            if v260.Rare == "Legendary" or v260.Chroma ~= nil then
                                                if u256.Parent ~= nil then
                                                    u268 = task.spawn(u270)
                                                end
                                                u256:GetPropertyChangedSignal("Parent"):Connect(function() --[[ Line: 1128 ]]
                                                    --[[
                                                    Upvalues:
                                                        [1] = u256
                                                        [2] = u268
                                                        [3] = u270
                                                    --]]
                                                    if u256.Parent == nil then
                                                        if u268 ~= nil and coroutine.status(u268) ~= "dead" then
                                                            task.cancel(u268)
                                                        end
                                                        u268 = nil
                                                    elseif u268 == nil then
                                                        u268 = task.spawn(u270)
                                                    end
                                                end)
                                            end
                                            u266.Enabled = true
                                            u266.Color = v271.Color
                                            u95[u256] = u266
                                            u265:GetPropertyChangedSignal("ImageTransparency"):Connect(function() --[[ Line: 1146 ]]
                                                --[[
                                                Upvalues:
                                                    [1] = u265
                                                    [2] = u95
                                                    [3] = u256
                                                    [4] = u266
                                                --]]
                                                if u265.ImageTransparency == 0 then
                                                    u95[u256] = u266
                                                else
                                                    u95[u256] = nil
                                                end
                                            end)
                                        end
                                        local v272 = v255:Clone()
                                        local v273 = u10:Attach3D(u256.Display, v272)
                                        v273:SetDepthMultiplier(1)
                                        v273.Camera.FieldOfView = 30
                                        v273.Visible = true
                                        v273:SetCFrame(CFrame.Angles(0, os.clock() % 6.283185307179586, 0) * CFrame.Angles(-0.03490658503988659, 0, 0))
                                        u94[u256] = v273
                                        local v274 = u256.Display:FindFirstChild("ViewportFrame")
                                        if v274 then
                                            v274.ZIndex = 6
                                            v274.BackgroundTransparency = 0
                                            v274.BorderSizePixel = 0
                                            v274.BackgroundColor3 = Color3.fromRGB(79, 79, 79)
                                        end
                                        local v275 = u256.Button
                                        v275.MouseEnter:Connect(function() --[[ Line: 1183 ]]
                                            --[[
                                            Upvalues:
                                                [1] = u256
                                            --]]
                                            u256.ItemName.Visible = true
                                        end)
                                        v275.MouseLeave:Connect(function() --[[ Line: 1187 ]]
                                            --[[
                                            Upvalues:
                                                [1] = u256
                                            --]]
                                            u256.ItemName.Visible = false
                                        end)
                                        local function v276() --[[ Line: 1191 ]]
                                            --[[
                                            Upvalues:
                                                [1] = u153
                                                [2] = u256
                                                [3] = u252
                                                [4] = u253
                                            --]]
                                            u153(u256, u252, u253)
                                        end
                                        v275.Activated:Connect(v276)
                                        u196(u252)
                                        local v277 = u92[u252]
                                        if v277 ~= nil then
                                            local v278 = u2:JSONDecode(u49.Inventory.FavItems.Value)
                                            if table.find(v278, u252) then
                                                v277.Display.FavIcon.Visible = true
                                            else
                                                v277.Display.FavIcon.Visible = false
                                            end
                                        end
                                    end
                                    u256:SetAttribute("amountOwned", u253)
                                    u256.Amount.Text = ("x%*"):format(u253)
                                    local v279 = v260.Rare
                                    v245[v279] = v245[v279] + 1
                                    local v280 = u256.Border
                                    if v264 == true then
                                        v280.ImageTransparency = 0
                                        v245.Equipped = v245.Equipped + 1
                                        u256.LayoutOrder = -10000 + u24[v260.Rare] + v245.Equipped
                                    else
                                        v280.ImageTransparency = 0.9
                                        u256.LayoutOrder = u24[v260.Rare] + v245[v260.Rare]
                                    end
                                    if table.find(v240, u252) then
                                        u256.LayoutOrder = u256.LayoutOrder - 100000
                                    end
                                    table.insert(v244, u256)
                                    v242[u252] = nil
                                end
                            end
                        end
                    end
                end
                table.sort(v244, function(p281, p282) --[[ Line: 1236 ]]
                    return p281.LayoutOrder < p282.LayoutOrder
                end)
                local v283 = 0
                local v284 = 0
                local v285 = {}
                local v286 = 0
                local v287 = 0
                for _, v288 in ipairs(v244) do
                    if v283 == 6 then
                        v284 = v284 + 1
                        v283 = 1
                    else
                        v283 = v283 + 1
                    end
                    local v289 = ("%*, %*"):format(v283, v284)
                    local v290 = u66.CanvasPosition / u208
                    local v291 = Vector2.new
                    local v292 = v290.X
                    local v293 = math.floor(v292)
                    local v294 = v290.Y
                    local v295 = v291(v293, (math.floor(v294)))
                    local v296
                    if v295.Y <= v284 then
                        v296 = v284 <= v295.Y + u215.Y
                    else
                        v296 = false
                    end
                    v285[v288] = {
                        ["IsPossible"] = v296,
                        ["CellPosition"] = v289
                    }
                end
                local v297 = {}
                for _, v298 in ipairs(v244) do
                    if v286 == 6 then
                        v287 = v287 + 1
                        v286 = 1
                    else
                        v286 = v286 + 1
                    end
                    local v299 = ("%*, %*"):format(v286, v287)
                    v297[v299] = v298
                    local v300 = u66.CanvasPosition / u208
                    local v301 = Vector2.new
                    local v302 = v300.X
                    local v303 = math.floor(v302)
                    local v304 = v300.Y
                    local v305 = v301(v303, (math.floor(v304)))
                    local v306
                    if v305.Y <= v287 then
                        v306 = v287 <= v305.Y + u215.Y
                    else
                        v306 = false
                    end
                    if u206[v299] ~= nil then
                        if u206[v299].Object ~= v298 then
                            local v307 = v285[v298]
                            if v307 and v307.IsPossible == false then
                                u206[v299].Object.Parent = nil
                            end
                        end
                        u206[v299] = nil
                    end
                    if v306 then
                        if v298.Parent == nil then
                            v298.Parent = u66
                        end
                        u94[v298].Visible = true
                        u206[v299] = {
                            ["X"] = v286,
                            ["Y"] = v287,
                            ["Object"] = v298
                        }
                    else
                        u94[v298].Visible = false
                        v298.Parent = nil
                    end
                    v298.LayoutOrder = v287 .. v286
                    v298:SetAttribute("CellPosition", v299)
                    v297[v299] = v298
                end
                table.clear(u205)
                u205 = v297
                u208 = u68.AbsoluteCellSize
                local v308 = v287 + 1
                u66.CanvasSize = UDim2.new(0, 0, 0, u208.Y * v308 + u101 * v308)
                for v309, v310 in pairs(v242) do
                    if v310 == u159 then
                        u73.Visible = false
                        u159 = nil
                    end
                    v310:Destroy()
                    u92[v309] = nil
                end
                for v311, v312 in pairs(v243) do
                    v312:Destroy()
                    u184[v311] = nil
                end
                if v238 == true then
                    u66.ScrollingEnabled = true
                end
                u216 = false
            end
            local u314 = false
            local function v316(p315) --[[ Line: 1354 ]]
                --[[
                Upvalues:
                    [1] = u64
                    [2] = u314
                    [3] = u202
                    [4] = u313
                --]]
                if u64.Visible == false then
                    u314 = true
                else
                    u202:QueueTask(u313, p315 or false)
                end
            end
            local function v326(_) --[[ Line: 1362 ]]
                --[[
                Upvalues:
                    [1] = u2
                    [2] = u49
                    [3] = u192
                    [4] = u92
                    [5] = u64
                    [6] = u314
                    [7] = u202
                    [8] = u313
                --]]
                local v317 = u2:JSONDecode(u49.Inventory.FavItems.Value)
                local v318 = table.clone(u192)
                for v319 = 1, #v317 do
                    local v320 = v317[v319]
                    local v321 = u92[v320]
                    if v321 ~= nil then
                        local v322 = u2:JSONDecode(u49.Inventory.FavItems.Value)
                        if table.find(v322, v320) then
                            v321.Display.FavIcon.Visible = true
                        else
                            v321.Display.FavIcon.Visible = false
                        end
                    end
                    u192[v320] = true
                end
                for v323, _ in pairs(v318) do
                    u192[v323] = nil
                    local v324 = u92[v323]
                    if v324 ~= nil then
                        local v325 = u2:JSONDecode(u49.Inventory.FavItems.Value)
                        if table.find(v325, v323) then
                            v324.Display.FavIcon.Visible = true
                        else
                            v324.Display.FavIcon.Visible = false
                        end
                    end
                end
                if u64.Visible == false then
                    u314 = true
                else
                    u202:QueueTask(u313, false)
                end
            end
            u49.Inventory.FavItems.Changed:Connect(v326)
            local u327 = nil
            u64:GetPropertyChangedSignal("Visible"):Connect(function() --[[ Line: 1385 ]]
                --[[
                Upvalues:
                    [1] = u64
                    [2] = u314
                    [3] = u202
                    [4] = u313
                    [5] = u327
                --]]
                if u64.Visible then
                    if u314 then
                        u314 = false
                        if u64.Visible == false then
                            u314 = true
                        else
                            u202:QueueTask(u313, false)
                        end
                    end
                    u327 = task.delay(0.25, function() --[[ Line: 1391 ]]
                        --[[
                        Upvalues:
                            [1] = u64
                            [2] = u314
                            [3] = u202
                            [4] = u313
                            [5] = u327
                        --]]
                        if u64.Visible == false then
                            u314 = true
                        else
                            u202:QueueTask(u313, false)
                        end
                        u327 = nil
                    end)
                elseif u327 and coroutine.status(u327) ~= "dead" then
                    task.cancel(u327)
                    u327 = nil
                end
            end)
            u71.FocusLost:Connect(function(_) --[[ Line: 1404 ]]
                --[[
                Upvalues:
                    [1] = u217
                    [2] = u71
                    [3] = u64
                    [4] = u314
                    [5] = u202
                    [6] = u313
                    [7] = u72
                --]]
                u217 = u71.Text
                if u217 == "" then
                    if u64.Visible == false then
                        u314 = true
                    else
                        u202:QueueTask(u313, false)
                    end
                elseif u64.Visible == false then
                    u314 = true
                else
                    u202:QueueTask(u313, true)
                end
                u72.Visible = u217 ~= ""
            end)
            u72.MouseButton1Click:Connect(function() --[[ Line: 1414 ]]
                --[[
                Upvalues:
                    [1] = u217
                    [2] = u71
                    [3] = u72
                    [4] = u64
                    [5] = u314
                    [6] = u202
                    [7] = u313
                --]]
                u217 = ""
                u71.Text = u217
                u72.Visible = false
                if u64.Visible == false then
                    u314 = true
                else
                    u202:QueueTask(u313, false)
                end
            end)
            local u328 = u218
            local u329 = u314
            local u330 = u203
            for _, u331 in ipairs(u85:GetChildren()) do
                if u331:IsA("ImageButton") then
                    u331.MouseButton1Click:Connect(function() --[[ Line: 1423 ]]
                        --[[
                        Upvalues:
                            [1] = u330
                            [2] = u331
                            [3] = u85
                            [4] = u66
                            [5] = u69
                            [6] = u64
                            [7] = u329
                            [8] = u202
                            [9] = u313
                        --]]
                        if u330 == u331.Name then
                            u85[u330].Text.TextColor3 = Color3.fromRGB(255, 255, 255)
                            u330 = "None"
                        else
                            if u330 ~= "None" then
                                u85[u330].Text.TextColor3 = Color3.fromRGB(255, 255, 255)
                            end
                            u331.Text.TextColor3 = Color3.fromRGB(247, 202, 24)
                            u330 = u331.Name
                        end
                        u66.CanvasPosition = Vector2.new(0, 0)
                        u69.PaddingTop = UDim.new(0, 0)
                        if u64.Visible == false then
                            u329 = true
                        else
                            u202:QueueTask(u313, false)
                        end
                    end)
                end
            end
            for _, u332 in pairs(u86:GetChildren()) do
                if u332:IsA("TextButton") then
                    u332.MouseButton1Click:Connect(function() --[[ Line: 1445 ]]
                        --[[
                        Upvalues:
                            [1] = u328
                            [2] = u332
                            [3] = u86
                            [4] = u66
                            [5] = u69
                            [6] = u64
                            [7] = u329
                            [8] = u202
                            [9] = u313
                        --]]
                        if u328 == u332.Name then
                            u332.BackgroundTransparency = 0.8
                            u328 = "None"
                        else
                            if u328 ~= "None" then
                                u86[u328].BackgroundTransparency = 0.8
                            end
                            u332.BackgroundTransparency = 0
                            u328 = u332.Name
                        end
                        u66.CanvasPosition = Vector2.new(0, 0)
                        u69.PaddingTop = UDim.new(0, 0)
                        if u64.Visible == false then
                            u329 = true
                        else
                            u202:QueueTask(u313, false)
                        end
                    end)
                end
            end
            if u158 then
                u78.Visible = true
            else
                u78.Visible = false
            end
            if not u158 then
                u3.ChildAdded:Connect(function(p333) --[[ Line: 1471 ]]
                    --[[
                    Upvalues:
                        [1] = u158
                        [2] = u78
                        [3] = u103
                    --]]
                    if p333.Name == "battleRoyaleDrop" then
                        u158 = p333
                        if u158 then
                            u78.Visible = true
                        else
                            u78.Visible = false
                        end
                    else
                        if p333.Name == "tradingHUB" then
                            u103 = p333
                        end
                        return
                    end
                end)
            end
            u52:GetPropertyChangedSignal("Value"):Connect(v316)
            u53:GetPropertyChangedSignal("Value"):Connect(v316)
            if u62.Value == "" then
                u87.Current.Text = "None"
            else
                u87.Current.Text = u62.Value
                u18.ApplyRarityGradient(u62.Value, u87.Current.Gradient, u63, u87)
            end
            u62:GetPropertyChangedSignal("Value"):Connect(v190)
            local v334 = v67:WaitForChild("Categories"):WaitForChild("Buttons")
            local v335 = u64:WaitForChild("Grips")
            local u336 = u64:WaitForChild("Titles")
            local u337 = u336:WaitForChild("List")
            local u338 = {
                ["InventoryFrame"] = v65,
                ["SectionsFrameParent"] = u85.Parent,
                ["RarityFilterFrame"] = u86,
                ["GripsFrame"] = v335,
                ["TitlesFrame"] = u336,
                ["ItemMenuFrame"] = u73,
                ["LoadoutFrame"] = u89
            }
            local u339 = {
                ["Inventory"] = {
                    ["InventoryFrame"] = true,
                    ["SectionsFrameParent"] = true,
                    ["RarityFilterFrame"] = true,
                    ["GripsFrame"] = false,
                    ["TitlesFrame"] = false,
                    ["LoadoutFrame"] = false
                },
                ["Titles"] = {
                    ["ItemMenuFrame"] = false,
                    ["RarityFilterFrame"] = false,
                    ["InventoryFrame"] = false,
                    ["SectionsFrameParent"] = false,
                    ["GripsFrame"] = false,
                    ["TitlesFrame"] = true,
                    ["ClearSelectedButton"] = true,
                    ["HackyBugFix"] = u337,
                    ["LoadoutFrame"] = false
                },
                ["Grips"] = {
                    ["ItemMenuFrame"] = false,
                    ["RarityFilterFrame"] = false,
                    ["InventoryFrame"] = false,
                    ["SectionsFrameParent"] = false,
                    ["GripsFrame"] = true,
                    ["TitlesFrame"] = false,
                    ["ClearSelectedButton"] = true,
                    ["LoadoutFrame"] = false,
                    ["HackyBugFix"] = u88
                },
                ["LoadoutSlots"] = {
                    ["ItemMenuFrame"] = false,
                    ["RarityFilterFrame"] = false,
                    ["InventoryFrame"] = false,
                    ["SectionsFrameParent"] = false,
                    ["GripsFrame"] = false,
                    ["TitlesFrame"] = false,
                    ["ClearSelectedButton"] = false,
                    ["LoadoutFrame"] = true
                }
            }
            local function u344(p340) --[[ Line: 1555 ]]
                --[[
                Upvalues:
                    [1] = u73
                    [2] = u159
                    [3] = u338
                --]]
                for v341, v342 in pairs(p340) do
                    if v341 == "ClearSelectedButton" then
                        if v342 then
                            u73.Visible = false
                            u159 = nil
                        end
                    elseif v341 == "HackyBugFix" then
                        v342.Visible = true
                    else
                        local v343 = u338[v341]
                        if v343 then
                            v343.Visible = v342
                        end
                    end
                end
            end
            for _, u345 in ipairs(v334:GetChildren()) do
                if u345:IsA("ImageButton") then
                    u345.MouseButton1Click:Connect(function() --[[ Line: 1575 ]]
                        --[[
                        Upvalues:
                            [1] = u339
                            [2] = u345
                            [3] = u344
                        --]]
                        local v346 = u339[u345.Name]
                        if v346 then
                            u344(v346)
                        end
                    end)
                end
            end
            task.spawn(function() --[[ Line: 1585 ]]
                --[[
                Upvalues:
                    [1] = u64
                    [2] = u48
                    [3] = u95
                    [4] = u206
                    [5] = u94
                --]]
                local v347 = 0
                while task.wait() do
                    if u64.Visible == true and u48.ItemRotation == true then
                        v347 = v347 + 1
                        for _, v348 in pairs(u95) do
                            v348.Rotation = v347
                        end
                        for _, v349 in pairs(u206) do
                            local v350 = v349.Object
                            if v350.Parent ~= nil and v350.Visible ~= false then
                                local v351 = u94[v350]
                                if v351 then
                                    v351:SetCFrame(CFrame.Angles(0, os.clock() % 6.283185307179586, 0) * CFrame.Angles(-0.03490658503988659, 0, 0))
                                end
                            end
                        end
                    else
                        v347 = 0
                    end
                end
            end)
            local function u355(p352, p353) --[[ Line: 1630 ]]
                --[[
                Upvalues:
                    [1] = u12
                    [2] = u2
                    [3] = u59
                --]]
                local v354 = u12[p353]
                if u2:JSONDecode(u59.Value)[p353] and true or false then
                    p352.LayoutOrder = v354.ID
                    p352.TitleText.Text = p353
                    p352.TitleText.TextColor3 = v354.RoleColor
                else
                    p352.LayoutOrder = 1000 + v354.ID
                    p352.TitleText.Text = "? ? ?"
                    p352.TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
                end
            end
            local function u365(p356) --[[ Line: 1646 ]]
                --[[
                Upvalues:
                    [1] = u12
                    [2] = u19
                    [3] = u336
                --]]
                local v357 = u12[p356]
                if v357 then
                    local v358 = ("%*%*%*"):format(v357.StartText and (v357.StartText .. "[" or "[") or "[", p356, v357.EndText and ("]" .. v357.EndText or "]") or "]")
                    local v359 = v357.RoleColor
                    local v360 = ("<font color=\"#%*\"><b>%*</b></font><br/>%*"):format(tostring(v359:ToHex()), v358, u19.Name)
                    if u336.CurrentTitle.Text ~= v360 then
                        for _, v361 in ipairs(u336.PerksList:GetChildren()) do
                            if v361:IsA("TextLabel") then
                                v361:Destroy()
                            end
                        end
                        if v357.Perks then
                            if #v357.Perks <= 0 then
                                local v362 = script.PerkTemplate:Clone()
                                v362.Text = "None"
                                v362.Parent = u336.PerksList
                            else
                                for _, v363 in pairs(v357.Perks) do
                                    local v364 = script.PerkTemplate:Clone()
                                    v364.Text = v363
                                    v364.Parent = u336.PerksList
                                end
                            end
                        end
                    end
                    u336.CurrentTitle.Text = v360
                end
            end
            task.spawn(function() --[[ Line: 1685 ]]
                --[[
                Upvalues:
                    [1] = u12
                    [2] = u337
                    [3] = u355
                    [4] = u2
                    [5] = u59
                    [6] = u15
                    [7] = u60
                    [8] = u336
                    [9] = u19
                    [10] = u365
                --]]
                local u366 = {}
                for u367, v368 in pairs(u12) do
                    local v369 = script.TitleTemplate:Clone()
                    v369.Name = u367
                    v369.Parent = u337
                    u366[u367] = v369
                    v369:SetAttribute("ID", v368.ID)
                    v369.Number.Text = ("#%*"):format(v368.ID)
                    u355(v369, u367)
                    v369.MouseButton1Click:Connect(function() --[[ Line: 1700 ]]
                        --[[
                        Upvalues:
                            [1] = u367
                            [2] = u2
                            [3] = u59
                            [4] = u15
                        --]]
                        local v370 = u367
                        if u2:JSONDecode(u59.Value)[v370] and true or false then
                            u15.Titles:InvokeServer(u367)
                        end
                    end)
                    task.wait()
                end
                u59:GetPropertyChangedSignal("Value"):Connect(function() --[[ Line: 1709 ]]
                    --[[
                    Upvalues:
                        [1] = u366
                        [2] = u355
                    --]]
                    for v371, v372 in pairs(u366) do
                        u355(v372, v371)
                    end
                end)
                local function v373() --[[ Line: 1715 ]]
                    --[[
                    Upvalues:
                        [1] = u60
                        [2] = u336
                        [3] = u19
                        [4] = u365
                    --]]
                    if u60.Value == "" then
                        u336.CurrentTitle.Text = u19.Name
                    else
                        u365(u60.Value)
                    end
                end
                if u60.Value == "" then
                    u336.CurrentTitle.Text = u19.Name
                else
                    u365(u60.Value)
                end
                u60:GetPropertyChangedSignal("Value"):Connect(v373)
            end)
            local u374 = v67:WaitForChild("ItemRotation")
            local u375 = v67:WaitForChild("DefaultColors")
            local u376 = u64:WaitForChild("AutoEquip")
            local u377 = u61.Value
            u376.MouseButton1Click:Connect(function() --[[ Line: 1739 ]]
                --[[
                Upvalues:
                    [1] = u377
                    [2] = u15
                --]]
                u377 = not u377
                u15.Settings:InvokeServer("AutoEquip", u377)
            end)
            u376.Text = u61.Value == true and "Auto Equip: <b><font color=\"rgb(170,255,0)\">ON</font></b>" or "Auto Equip: <b><font color=\"rgb(255,0,0)\">OFF</font></b>"
            u61:GetPropertyChangedSignal("Value"):Connect(function() --[[ Name: AutoEquipUpdated, Line 1735 ]]
                --[[
                Upvalues:
                    [1] = u376
                    [2] = u61
                --]]
                u376.Text = u61.Value == true and "Auto Equip: <b><font color=\"rgb(170,255,0)\">ON</font></b>" or "Auto Equip: <b><font color=\"rgb(255,0,0)\">OFF</font></b>"
            end)
            local u378 = game.ReplicatedStorage:FindFirstChild("Stats" .. u19.Name)
            u374.MouseButton1Click:Connect(function() --[[ Line: 1755 ]]
                --[[
                Upvalues:
                    [1] = u378
                    [2] = u374
                    [3] = u48
                --]]
                game.ReplicatedStorage.Events.Settings:InvokeServer("ItemRotation", not u378.Settings.ItemRotation.Value)
                local v379 = u378.Settings.ItemRotation.Value
                u374.Text = v379 == true and "Item Rotation: <b><font color=\"rgb(170,255,0)\">ON</font></b>" or "Item Rotation: <b><font color=\"rgb(255,0,0)\">OFF</font></b>"
                u48.ItemRotation = v379
            end)
            local v380 = u378.Settings.ItemRotation.Value
            u374.Text = v380 == true and "Item Rotation: <b><font color=\"rgb(170,255,0)\">ON</font></b>" or "Item Rotation: <b><font color=\"rgb(255,0,0)\">OFF</font></b>"
            u48.ItemRotation = v380
            u375.MouseButton1Click:Connect(function() --[[ Line: 1767 ]]
                --[[
                Upvalues:
                    [1] = u378
                    [2] = u375
                --]]
                game.ReplicatedStorage.Events.Settings:InvokeServer("DefaultOutfitColors", not u378.Settings.DefaultOutfitColors.Value)
                u375.Text = u378.Settings.DefaultOutfitColors.Value == true and "Default Outfit Colors: <b><font color=\"rgb(170,255,0)\">ON</font></b>" or "Default Outfit Colors: <b><font color=\"rgb(255,0,0)\">OFF</font></b>"
            end)
            u375.Text = u378.Settings.DefaultOutfitColors.Value == true and "Default Outfit Colors: <b><font color=\"rgb(170,255,0)\">ON</font></b>" or "Default Outfit Colors: <b><font color=\"rgb(255,0,0)\">OFF</font></b>"
            local u381 = u15:WaitForChild("LoadoutSlots")
            local u382 = u89:FindFirstChild("LoadoutListFrame")
            local u383 = u49.Inventory.LoadoutSlotsTable
            local u384 = u20:WaitForChild("Statistics"):WaitForChild("Main"):WaitForChild("Stats")
            local _ = game.GameId == 2097989947
            local v385 = u2:JSONDecode(u383.Value)
            local u386 = 0
            for _, _ in pairs(v385) do
                u386 = u386 + 1
            end
            task.spawn(function() --[[ Line: 1790 ]]
                --[[
                Upvalues:
                    [1] = u381
                    [2] = u382
                    [3] = u3
                    [4] = u89
                    [5] = u384
                    [6] = u12
                    [7] = u19
                    [8] = u83
                    [9] = u7
                    [10] = u41
                    [11] = u14
                    [12] = u16
                    [13] = u386
                    [14] = u2
                    [15] = u383
                --]]
                local u387 = {}
                local function u480(u388) --[[ Line: 1793 ]]
                    --[[
                    Upvalues:
                        [1] = u381
                        [2] = u382
                        [3] = u3
                        [4] = u89
                        [5] = u384
                        [6] = u12
                        [7] = u19
                        [8] = u83
                        [9] = u7
                        [10] = u41
                        [11] = u14
                        [12] = u16
                        [13] = u387
                    --]]
                    local v389 = 0
                    repeat
                        local v390, v391 = u381:InvokeServer({
                            ["actionType"] = "fetchLoadoutModel",
                            ["requestedSlot"] = u388
                        })
                        local u392 = v391
                        v389 = v389 + 1
                        task.wait(1)
                    until v390 ~= nil or v389 >= 3
                    if v390 == nil or v389 >= 3 then
                        _G.displayMessage("<Color=Red>Failed to load a loadout slot!")
                    else
                        local u393 = script.LoadoutTemplate:Clone()
                        u393.SlotNumber.Text = ("Slot #%*"):format(u388)
                        u393.Parent = u382
                        local function u408(p394) --[[ Line: 1816 ]]
                            --[[
                            Upvalues:
                                [1] = u393
                                [2] = u3
                                [3] = u89
                            --]]
                            local u395 = u393:FindFirstChild("ViewFrame")
                            local u396 = u395:FindFirstChild("ViewportFrame")
                            u396:ClearAllChildren()
                            local v397 = Instance.new("Camera")
                            u396.CurrentCamera = v397
                            p394:SetPrimaryPartCFrame(CFrame.new(0, 0, 0))
                            local v398 = p394:GetExtentsSize().Magnitude / 1.75
                            v397.CFrame = p394.PrimaryPart.CFrame * CFrame.Angles(0, 3.141592653589793, 0) * CFrame.new(0, 0, v398)
                            local v399 = Instance.new("WorldModel")
                            v399.Parent = u396
                            p394.Parent = v399
                            local v400 = p394.Humanoid
                            local v401 = p394:GetAttribute("IdleName")
                            local v402
                            if v401 == "Normal" then
                                v402 = script.IdleAnim
                            else
                                v402 = u3.Modules.SwordHandle.Swords[v401].Idle
                            end
                            v400.EvaluateStateMachine = false
                            local u403 = v400:LoadAnimation(script.IdleAnim)
                            local u404 = v400:LoadAnimation(v402)
                            local v405 = p394:GetDescendants()
                            for v406 = 1, #v405 do
                                if v405[v406].Name == "AnimateAccessory" then
                                    v405[v406].Enabled = true
                                end
                            end
                            local function v407() --[[ Line: 1862 ]]
                                --[[
                                Upvalues:
                                    [1] = u89
                                    [2] = u403
                                    [3] = u404
                                    [4] = u396
                                    [5] = u395
                                --]]
                                if u89.Visible then
                                    u403:Play()
                                    u404:Play()
                                    u396.Parent = u395
                                else
                                    u403:Stop()
                                    u404:Stop()
                                    u396.Parent = nil
                                end
                            end
                            if u89.Visible then
                                u403:Play()
                                u404:Play()
                                u396.Parent = u395
                            else
                                u403:Stop()
                                u404:Stop()
                                u396.Parent = nil
                            end
                            u89:GetPropertyChangedSignal("Visible"):Connect(v407)
                        end
                        u408(v390)
                        local v409 = u393.ButtonOptions.Override
                        local v410 = u393.ButtonOptions.Wear
                        local u411 = u393.ButtonOptions.Stats
                        local v412 = u393.ButtonOptions.LoadStats
                        local v413 = u393.ButtonOptions.ExportButton
                        local v414 = u393.ButtonOptions.ImportButton
                        local u415 = u393.Stats
                        local u416 = u393.ViewFrame
                        local function u448(p417) --[[ Line: 1894 ]]
                            --[[
                            Upvalues:
                                [1] = u415
                                [2] = u384
                                [3] = u12
                                [4] = u19
                                [5] = u83
                                [6] = u7
                                [7] = u41
                            --]]
                            local v418 = { "StatTemplate" }
                            if p417.StatPoints == nil then
                                warn("nil stat points")
                            else
                                for v419, v420 in pairs(p417.StatPoints) do
                                    if v420 > 0 then
                                        local v421 = u415:FindFirstChild(v419)
                                        local v422 = u384:FindFirstChild(v419).Stat
                                        if u415:FindFirstChild(v419) == nil then
                                            v421 = u415.StatTemplate:Clone()
                                            v421.Name = v419
                                            v421.Visible = true
                                            v422.UIGradient:Clone().Parent = v421.Stat
                                            v422.UIGradient:Clone().Parent = v421.Amount
                                            v421.LayoutOrder = v422.Parent.LayoutOrder - 400
                                            v421:SetAttribute("IsStatPoint", true)
                                            v421.Parent = u415
                                        end
                                        v421.Stat.Text = v422.Text
                                        v421.Amount.Text = v420
                                        table.insert(v418, v419)
                                    end
                                end
                                if p417.FightingStyle and p417.FightingStyle ~= "" then
                                    local v423 = u415:FindFirstChild("CustomFightingStyle")
                                    if v423 == nil then
                                        v423 = script.LoadoutTemplate.Stats.MiscTemplate:Clone()
                                        v423.Parent = u415
                                    end
                                    v423.Name = "CustomFightingStyle"
                                    v423.Visible = true
                                    v423.LayoutOrder = 55
                                    v423.StatName.Text = p417.FightingStyle
                                    local v424 = v423.Name
                                    table.insert(v418, v424)
                                end
                                if p417.Title and (p417.Title ~= "" and u12[p417.Title] ~= nil) then
                                    local v425 = u415:FindFirstChild("CustomTitle")
                                    local v426 = p417.Title
                                    local v427 = u12[v426]
                                    if v427 and _G.HasTitle(u19, v426) then
                                        if v425 == nil then
                                            v425 = script.LoadoutTemplate.Stats.MiscTemplate:Clone()
                                            v425.Parent = u415
                                        end
                                        v425.Name = "CustomTitle"
                                        v425.Visible = true
                                        v425.LayoutOrder = 51
                                        local v428 = ("%*%*%*"):format(v427.StartText and (v427.StartText .. "[" or "[") or "[", v426, v427.EndText and ("]" .. v427.EndText or "]") or "]")
                                        local v429 = v427.RoleColor
                                        local v430 = ("<font color=\"#%*\"><b>%*</b></font>"):format(tostring(v429:ToHex()), v428)
                                        v425.StatName.Text = v430
                                        local v431 = v425.Name
                                        table.insert(v418, v431)
                                    end
                                end
                                local v432 = u83:GetChildren()
                                for v433 = 1, #v432 do
                                    local v434 = v432[v433]
                                    if v434:IsA("TextLabel") and u415:FindFirstChild(v434.Name) == nil then
                                        local v435 = v434:Clone()
                                        v435.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                                        v435.BackgroundTransparency = 0
                                        v435.TextXAlignment = Enum.TextXAlignment.Center
                                        v435.Size = u415.StatTemplate.Size
                                        v435:SetAttribute("ForceStay", true)
                                        v435:SetAttribute("IsItemStat", true)
                                        v435.Parent = u415
                                    end
                                end
                                local v436 = u415:GetChildren()
                                for v437 = 1, #v436 do
                                    if v436[v437]:IsA("Frame") and (table.find(v418, v436[v437].Name) == nil and v436[v437]:GetAttribute("ForceStay") == nil) then
                                        v436[v437]:Destroy()
                                    end
                                end
                                local v438 = p417.Items
                                local v439 = {}
                                for v440 = 1, #v438 do
                                    local v441 = v438[v440]
                                    local v442 = u7.ItemStats:FindFirstChild(v441)
                                    local v443 = v442 and v442:GetAttributes() or {}
                                    for v444, v445 in pairs(v443) do
                                        v439[v444] = (v439[v444] or 0) + v445
                                    end
                                end
                                for _, v446 in ipairs(u415:GetChildren()) do
                                    if v446:IsA("TextLabel") and v446:GetAttribute("IsItemStat") == true then
                                        local v447 = v439[v446.Name]
                                        u41(v446, v446.Name, v447 or 0)
                                    end
                                end
                            end
                        end
                        local u449 = u393.SlotNumber
                        local u450 = u393.SlotNumber.EditName
                        u450.MouseButton1Click:Connect(function() --[[ Line: 2026 ]]
                            --[[
                            Upvalues:
                                [1] = u449
                                [2] = u392
                                [3] = u388
                                [4] = u450
                            --]]
                            u449.TextEditable = not u449.TextEditable
                            if u449.TextEditable == true then
                                u449.Text = ""
                                u449.PlaceholderText = u392.CustomName or "Slot #" .. u388
                                u450.ImageColor3 = Color3.fromRGB(255, 170, 0)
                            else
                                u450.ImageColor3 = Color3.fromRGB(255, 255, 255)
                                u449.PlaceholderText = ""
                                u449.Text = u392.CustomName or "Slot #" .. u388
                            end
                        end)
                        u449.FocusLost:Connect(function() --[[ Line: 2039 ]]
                            --[[
                            Upvalues:
                                [1] = u449
                                [2] = u392
                                [3] = u388
                                [4] = u381
                            --]]
                            local v451 = u449.Text
                            if v451 == "" then
                                u449.Text = u392.CustomName or "Slot #" .. u388
                            elseif u392.CustomName ~= v451 then
                                u381:InvokeServer({
                                    ["actionType"] = "UpdateName",
                                    ["requestedSlot"] = u388,
                                    ["Name"] = v451
                                })
                            end
                        end)
                        v412.MouseButton1Click:Connect(function() --[[ Line: 2056 ]]
                            --[[
                            Upvalues:
                                [1] = u19
                                [2] = u381
                                [3] = u388
                            --]]
                            if _G.HasItem(u19, "SP Reset Essence") == false then
                                _G.displayMessage("<Color=Red>You need a SP Reset Essence to load stats!")
                            else
                                u381:InvokeServer({
                                    ["actionType"] = "LoadStats",
                                    ["requestedSlot"] = u388
                                })
                            end
                        end)
                        v409.MouseButton1Click:Connect(function() --[[ Line: 2068 ]]
                            --[[
                            Upvalues:
                                [1] = u19
                                [2] = u392
                                [3] = u388
                                [4] = u381
                                [5] = u408
                                [6] = u448
                            --]]
                            _G.promptQuestion(u19, ("<font color=\"#FF0000\">Override Loadout %* with current?</font>"):format(u392.CustomName or ("Slot #%*"):format(u388)), {
                                [true] = function() --[[ Line: 2070 ]]
                                    --[[
                                    Upvalues:
                                        [1] = u381
                                        [2] = u388
                                        [3] = u392
                                        [4] = u408
                                        [5] = u448
                                    --]]
                                    local v452, v453 = u381:InvokeServer({
                                        ["actionType"] = "Override",
                                        ["requestedSlot"] = u388
                                    })
                                    if v452 and v453 then
                                        u392 = v453
                                        u408(v452)
                                        u448(u392)
                                    end
                                end
                            })
                        end)
                        v410.MouseButton1Click:Connect(function() --[[ Line: 2086 ]]
                            --[[
                            Upvalues:
                                [1] = u19
                                [2] = u381
                                [3] = u388
                            --]]
                            local v454 = {
                                [true] = function() --[[ Line: 2088 ]]
                                    --[[
                                    Upvalues:
                                        [1] = u381
                                        [2] = u388
                                    --]]
                                    u381:InvokeServer({
                                        ["actionType"] = "Wear",
                                        ["requestedSlot"] = u388
                                    })
                                end
                            }
                            _G.promptQuestion(u19, "Wear this loadout? <font color=\"#ffaa00\">Overrides your accessories,outfits, and equipped items</font>.", v454)
                        end)
                        u411.MouseButton1Click:Connect(function() --[[ Line: 2097 ]]
                            --[[
                            Upvalues:
                                [1] = u415
                                [2] = u416
                                [3] = u411
                            --]]
                            local v455 = not u415.Visible
                            u415.Visible = v455
                            u416.Visible = not v455
                            if v455 == true then
                                u411.Usage.Text = "Hide Stats"
                            else
                                u411.Usage.Text = "Show Stats"
                            end
                        end)
                        v413.MouseButton1Click:Connect(function() --[[ Line: 2109 ]]
                            --[[
                            Upvalues:
                                [1] = u381
                                [2] = u388
                                [3] = u14
                            --]]
                            task.spawn(function() --[[ Line: 2110 ]]
                                --[[
                                Upvalues:
                                    [1] = u381
                                    [2] = u388
                                    [3] = u14
                                --]]
                                local v456 = u381:InvokeServer({
                                    ["actionType"] = "ExportTailor",
                                    ["requestedSlot"] = u388
                                })
                                if v456 and (v456.success and v456.code) then
                                    u14.PromptPortCodeUI("Export", v456.code)
                                else
                                    _G.displayMessage("<Color=Red>" .. (v456 and v456.error or "Failed to export"))
                                end
                            end)
                        end)
                        v414.MouseButton1Click:Connect(function() --[[ Line: 2124 ]]
                            --[[
                            Upvalues:
                                [1] = u14
                                [2] = u381
                                [3] = u388
                                [4] = u392
                                [5] = u408
                                [6] = u448
                            --]]
                            task.spawn(function() --[[ Line: 2125 ]]
                                --[[
                                Upvalues:
                                    [1] = u14
                                    [2] = u381
                                    [3] = u388
                                    [4] = u392
                                    [5] = u408
                                    [6] = u448
                                --]]
                                local v457 = u14.PromptPortCodeUI("Import")
                                if v457 and v457 ~= "" then
                                    local v458 = u381:InvokeServer({
                                        ["actionType"] = "ImportTailor",
                                        ["requestedSlot"] = u388,
                                        ["code"] = v457
                                    })
                                    if v458 and v458.success then
                                        local v459 = {}
                                        local v460 = string.format
                                        local v461 = v458.appliedItems or 0
                                        table.insert(v459, v460("%d items", v461))
                                        local v462 = string.format
                                        local v463 = v458.appliedVanity or 0
                                        table.insert(v459, v462("%d vanity", v463))
                                        if v458.title and v458.title ~= "" then
                                            table.insert(v459, "title")
                                        end
                                        if v458.fightingStyle and v458.fightingStyle ~= "" then
                                            table.insert(v459, "fighting style")
                                        end
                                        local v464 = "<Color=Green>Imported: " .. table.concat(v459, ", ")
                                        local v465 = {}
                                        if v458.skippedItems then
                                            for _, v466 in ipairs(v458.skippedItems) do
                                                table.insert(v465, v466)
                                            end
                                        end
                                        if v458.skippedVanity then
                                            for _, v467 in ipairs(v458.skippedVanity) do
                                                table.insert(v465, v467)
                                            end
                                        end
                                        if v458.skippedTitle then
                                            local v468 = v458.skippedTitle
                                            table.insert(v465, v468)
                                        end
                                        if v458.skippedTailorItems then
                                            for _, v469 in ipairs(v458.skippedTailorItems) do
                                                table.insert(v465, v469)
                                            end
                                        end
                                        if #v465 > 0 then
                                            v464 = v464 .. string.format("\n<Color=Yellow>%d skipped:", #v465)
                                            for _, v470 in ipairs(v465) do
                                                v464 = v464 .. string.format("\n  - %s (%s)", v470.name, v470.reason)
                                            end
                                        end
                                        _G.displayMessage(v464)
                                        task.wait(0.5)
                                        local v471, v472 = u381:InvokeServer({
                                            ["actionType"] = "fetchLoadoutModel",
                                            ["requestedSlot"] = u388
                                        })
                                        if v471 and v472 then
                                            u392 = v472
                                            u408(v471)
                                            u448(u392)
                                            return
                                        end
                                    else
                                        _G.displayMessage("<Color=Red>" .. (v458 and v458.error or "Import failed"))
                                    end
                                end
                            end)
                        end)
                        u448(u392)
                        local v473 = u392.CustomName
                        if v473 then
                            u449.Text = v473
                            u449.PlaceholderText = v473
                        end
                        local v474 = u16.new()
                        u387[u388] = v474
                        v474:Connect(function(p475, p476) --[[ Line: 2203 ]]
                            --[[
                            Upvalues:
                                [1] = u392
                                [2] = u449
                                [3] = u381
                                [4] = u388
                                [5] = u408
                                [6] = u448
                            --]]
                            u392 = p476
                            local v477 = p476.CustomName
                            if v477 then
                                u449.Text = v477
                                u449.PlaceholderText = v477
                            end
                            if p475 ~= "Name" then
                                local v478, v479 = u381:InvokeServer({
                                    ["actionType"] = "fetchLoadoutModel",
                                    ["requestedSlot"] = u388
                                })
                                u408(v478)
                                u448(v479)
                            end
                        end)
                    end
                end
                for v481 = 1, u386 do
                    u480(v481)
                    task.wait(v481)
                end
                local u482 = u2:JSONDecode(u383.Value)
                u383.Changed:Connect(function() --[[ Line: 2228 ]]
                    --[[
                    Upvalues:
                        [1] = u2
                        [2] = u383
                        [3] = u482
                        [4] = u387
                        [5] = u480
                    --]]
                    local v483 = u2:JSONDecode(u383.Value)
                    for v484, v485 in pairs(v483) do
                        local v486 = string.match
                        local v487 = tonumber(v486(v484, "%d+"))
                        local v488 = u482[v484]
                        if v488 then
                            if v488.UID == v485.UID then
                                if v488.CustomName ~= v485.CustomName then
                                    u387[v487]:Fire("Name", v485)
                                end
                            end
                        elseif v488 == nil then
                            u480(v487)
                        end
                    end
                    u482 = v483
                end)
            end)
            local u489 = u13.new()
            local function u494(p490) --[[ Line: 2254 ]]
                --[[
                Upvalues:
                    [1] = u489
                    [2] = u84
                    [3] = u41
                --]]
                u489:Clean()
                for _, u491 in ipairs(p490:GetChildren()) do
                    local u492 = u84:FindFirstChild(u491.Name)
                    if u492 then
                        local function v493() --[[ Line: 2262 ]]
                            --[[
                            Upvalues:
                                [1] = u41
                                [2] = u492
                                [3] = u491
                            --]]
                            u41(u492, u491.Name, u491.Value)
                        end
                        u41(u492, u491.Name, u491.Value)
                        u489:Add(u491:GetPropertyChangedSignal("Value"):Connect(v493))
                    else
                        print("could not find", u491.Name)
                    end
                end
            end
            task.delay(1, function() --[[ Line: 2282 ]]
                --[[
                Upvalues:
                    [1] = u19
                    [2] = u494
                --]]
                if u19.Character == nil then
                    repeat
                        task.wait()
                    until u19.Character
                end
                u494(u19.Character:WaitForChild("Boosts", 360))
            end)
            u19.CharacterAdded:Connect(function(p495) --[[ Name: CharacterAdded, Line 2278 ]]
                --[[
                Upvalues:
                    [1] = u494
                --]]
                u494(p495:WaitForChild("Boosts", 360))
            end)
            u496.Initialized = true
        end
    end
}
return u496