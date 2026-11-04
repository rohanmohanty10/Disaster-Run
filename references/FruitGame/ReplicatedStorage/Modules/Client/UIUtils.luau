 

local v1 = game:GetService("Players")
local u2 = game:GetService("UserInputService")
local v3 = game:GetService("ReplicatedStorage")
local u4 = game:GetService("TweenService")
local v5 = v3:WaitForChild("Modules"):WaitForChild("Shared")
local u6 = require(v5:WaitForChild("SoundUtils"))
local u7 = require(v5:WaitForChild("DebrisService"))
local u8 = v1.LocalPlayer:WaitForChild("PlayerGui")
local u9 = {}
local u10 = u8:FindFirstChild("ButtonEffects")
if u10 == nil then
    u10 = Instance.new("ScreenGui")
    u10.Name = "ButtonEffects"
    u10.DisplayOrder = 10000000
    u10.IgnoreGuiInset = true
    u10.ResetOnSpawn = false
    u10.AutoLocalize = false
    u10.SafeAreaCompatibility = Enum.SafeAreaCompatibility.None
    u10:SetAttribute("unhideable", true)
    u10.Parent = u8
    local u11 = {
        "ContextActionGui",
        "TouchControls",
        "TouchUI",
        "TouchGui"
    }
    u2.InputBegan:Connect(function(p12, _) --[[ Line: 34 ]]
        --[[
        Upvalues:
            [1] = u8
            [2] = u11
            [3] = u9
        --]]
        if p12.UserInputType == Enum.UserInputType.Touch or p12.UserInputType == Enum.UserInputType.MouseButton1 then
            local v13 = u8:GetGuiObjectsAtPosition(p12.Position.X, p12.Position.Y)
            if v13 and #v13 > 0 then
                for v14 = 1, #v13 do
                    if v13[v14]:IsA("GuiButton") and (v13[v14].Interactable == true and v13[v14].Size ~= UDim2.new(0, 0, 0, 0)) then
                        local v15 = v13[v14]:FindFirstAncestorWhichIsA("ScreenGui")
                        if v15 and table.find(u11, v15.Name) == nil then
                            u9.ButtonClick()
                            return
                        end
                    end
                end
            end
        end
    end)
end
function u9.ButtonEffect() --[[ Line: 58 ]] end
function u9.ButtonClick() --[[ Line: 84 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u10
        [3] = u6
        [4] = u4
        [5] = u7
    --]]
    local v16 = math.random(10, 50) / 1000
    local v17 = u2:GetMouseLocation()
    local v18 = script.Circle:Clone()
    v18.Position = UDim2.new(0, v17.X, 0, v17.Y)
    v18.Active = false
    v18.Parent = u10
    u6.PlaySound("UiTap5", {
        ["SoundCategory"] = "UI",
        ["RandomPitch"] = true
    })
    u4:Create(v18, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0), {
        ["ImageTransparency"] = 1,
        ["Size"] = UDim2.new(v16, 15, v16, 15)
    }):Play()
    u7:AddItem(v18, 0.25)
end
return u9