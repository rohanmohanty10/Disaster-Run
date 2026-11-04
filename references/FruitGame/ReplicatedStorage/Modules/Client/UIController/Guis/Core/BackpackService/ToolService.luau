 

local u1 = game:GetService("ReplicatedStorage")
local u2 = game:GetService("Players")
local v3 = u1:WaitForChild("Modules")
local u4 = require(v3:WaitForChild("Maid"))
local u5 = require(script.DraggableObject)
local v6 = v3.Shared
local u7 = require(v6.GameUtils)
local u8 = script.ToolTemplate
require(script.SortTypes)
local u9 = require(v3:WaitForChild("ToolDesc"))
local v10 = v3.Client
local u11 = require(v10:WaitForChild("ItemDisplay"))
local u12 = u2.LocalPlayer:WaitForChild("PlayerGui")
local u13 = {}
u13.__index = u13
local u14 = {
    ["Gun"] = "Weapons",
    ["Katana"] = "Weapons",
    ["Katana2"] = "Weapons",
    ["Artifact"] = "Items",
    ["Back2"] = "Items",
    ["Baloon"] = "Items",
    ["Book"] = "Items",
    ["Core"] = "Items",
    ["Display"] = "Items",
    ["Drink"] = "Items",
    ["ETPose"] = "Items",
    ["Egg"] = "Items",
    ["Essence"] = "Items",
    ["Food"] = "Items",
    ["FruitBag"] = "Items",
    ["FruitChest"] = "Items",
    ["FruitRemover"] = "Items",
    ["Hammer"] = "Items",
    ["Item"] = "Items",
    ["Key"] = "Items",
    ["Mount"] = "Items",
    ["Pet"] = "Items",
    ["Fruit"] = "Special",
    ["Back"] = "Wearables",
    ["Cap"] = "Wearables",
    ["Cape"] = "Wearables",
    ["Ears"] = "Wearables",
    ["Glasses"] = "Wearables",
    ["Headband"] = "Wearables",
    ["Jaw"] = "Wearables",
    ["NormalOutfit"] = "Wearables",
    ["Outfit"] = "Wearables",
    ["Waist"] = "Wearables"
}
function u13.new(p15) --[[ Line: 69 ]]
    --[[
    Upvalues:
        [1] = u13
        [2] = u4
        [3] = u8
        [4] = u9
        [5] = u14
        [6] = u7
        [7] = u2
        [8] = u1
        [9] = u11
        [10] = u12
        [11] = u5
    --]]
    if p15 ~= nil then
        local v16 = u13
        local u17 = setmetatable({}, v16)
        u17.Maid = u4.new()
        u17.Tool = p15
        u17.LastDrag = false
        local u18 = u8:Clone()
        u18.Name = p15.Name
        u18:SetAttribute("Selected", false)
        local v19 = u18.ToolImage
        local u20 = u18.ToolText
        local u21 = u18.ItemCount
        local u22 = u18.ToolTip
        local u23 = u18.ToolObject
        local v24 = u18.HotbarObject
        local u25 = nil
        local function u30(p26) --[[ Line: 91 ]]
            --[[
            Upvalues:
                [1] = u25
                [2] = u23
                [3] = u22
                [4] = u4
                [5] = u9
                [6] = u14
                [7] = u7
                [8] = u2
                [9] = u21
            --]]
            if u25 then
                u25:Destroy()
                u25 = nil
            end
            local u27 = p26 or u23.Value
            if u27 ~= nil then
                u22.Text = u27.ToolTip
                u25 = u4.new()
                u25:AddTask(u27:GetPropertyChangedSignal("ToolTip"):Connect(function() --[[ Line: 103 ]]
                    --[[
                    Upvalues:
                        [1] = u22
                        [2] = u27
                    --]]
                    u22.Text = u27.ToolTip
                end))
                local v28 = u9[u27.Name]
                if v28 == nil then
                    if u27:GetAttribute("MeleeTool") then
                        u27:SetAttribute("Category", "Weapons")
                    end
                    u21.Visible = false
                else
                    u27:SetAttribute("Category", u14[v28.Type] or "")
                    if v28.OneTime == nil then
                        local v29 = u7.CheckItemAmount(u2.LocalPlayer, u27.Name)
                        if v29 > 1 then
                            u21.Visible = true
                            u21.Text = ("x%*"):format(v29)
                        else
                            u21.Visible = false
                        end
                    else
                        u21.Visible = false
                    end
                end
            end
        end
        u30(p15)
        local v31 = u1:WaitForChild("Stats" .. u2.LocalPlayer.Name):WaitForChild("Inventory"):WaitForChild("Inventory")
        u17.Maid:AddTask(v31.Changed:Connect(function() --[[ Line: 137 ]]
            --[[
            Upvalues:
                [1] = u30
            --]]
            u30()
        end))
        u17.Maid:AddTask(u18:GetAttributeChangedSignal("Selected"):Connect(function() --[[ Line: 141 ]]
            --[[
            Upvalues:
                [1] = u18
            --]]
            if u18:GetAttribute("Selected") then
                u18.ImageTransparency = 0.3
                u18.Outline.ImageTransparency = 0
            else
                u18.ImageTransparency = 0.55
                u18.Outline.ImageTransparency = 0.55
            end
        end))
        u17.Maid:AddTask(u18:GetPropertyChangedSignal("Parent"):Connect(function() --[[ Line: 152 ]]
            --[[
            Upvalues:
                [1] = u18
            --]]
            if u18.Parent then
                if u18.Parent:IsA("ScrollingFrame") then
                    return
                end
                u18.Parent:IsA("Frame")
            end
        end))
        u17.Maid:AddTask(u18.MouseEnter:Connect(function() --[[ Line: 164 ]]
            --[[
            Upvalues:
                [1] = u22
            --]]
            u22.Visible = true
        end))
        u17.Maid:AddTask(u18.MouseLeave:Connect(function() --[[ Line: 168 ]]
            --[[
            Upvalues:
                [1] = u22
            --]]
            u22.Visible = false
        end))
        u23.Value = p15
        u17.ItemDisplay = u11.new({
            ["Gui"] = u12:WaitForChild("BackpackGui"),
            ["Trade"] = false
        })
        local function u33(p32) --[[ Line: 176 ]]
            --[[
            Upvalues:
                [1] = u17
                [2] = u23
                [3] = u18
                [4] = u20
                [5] = u9
            --]]
            u17.ItemDisplay:StopRotation()
            u17.ItemDisplay:RemoveAllItems()
            if p32 == nil then
                return
            elseif u23.Value.TextureId == "" then
                if u9[p32.Name] == nil then
                    u18.ToolImage.Image = ""
                    u20.Text = p32.Name
                else
                    u17.ItemDisplay:StartRotation()
                    u17.ItemDisplay:AddToolItem(u18.ItemDisplay, p32.Name, 1)
                    u18.ToolImage.Image = ""
                    u20.Text = ""
                end
            else
                u18.ToolImage.Image = u23.Value.TextureId
                u20.Text = ""
                return
            end
        end
        u33(u23.Value)
        u17.Maid:AddTask(u23:GetPropertyChangedSignal("Value"):Connect(function() --[[ Line: 202 ]]
            --[[
            Upvalues:
                [1] = u23
                [2] = u18
                [3] = u30
                [4] = u20
                [5] = u33
            --]]
            if u23.Value == nil then
                u20.Text = ""
                u18.ToolImage.Image = ""
            else
                u18.Name = u23.Value.Name
                u30(u23.Value)
            end
            u33(u23.Value)
        end))
        u17.ToolButton = u18
        u17.ToolImage = v19
        u17.ToolText = u20
        u17.ToolObject = u23
        u17.HotbarObject = v24
        u17.Maid:AddTask(u17.ToolButton)
        u17.Drag = u5.new(u18)
        u17.Drag:Enable()
        return u17
    end
    warn("Invalid Tool, Received:", p15)
end
function u13.UpdateLayoutOrder(p34) --[[ Line: 240 ]]
    local _ = p34.Tool
    p34.ToolButton.LayoutOrder = 100
end
function u13.Destroy(p35) --[[ Line: 248 ]]
    if p35.ItemDisplay then
        p35.ItemDisplay:RemoveAllItems()
        p35.ItemDisplay:Destroy()
    end
    p35.Drag:Destroy()
    p35.Maid:Clean()
    setmetatable(p35, nil)
end
return u13