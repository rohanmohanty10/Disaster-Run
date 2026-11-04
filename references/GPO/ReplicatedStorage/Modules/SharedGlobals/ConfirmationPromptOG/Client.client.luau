 

local u1 = game:GetService("GuiService")
local v2 = game:GetService("ReplicatedStorage")
require(v2.Modules.MEnterLeave)
local u3 = script.Parent
local u4 = u3:WaitForChild("Main")
local u5 = u3:WaitForChild("Main2")
local u6 = u4:WaitForChild("OptionsFrame")
local u7 = u3:WaitForChild("RemoteEvent")
local u8 = u3:GetAttribute("isServer")
_G.hideUI(true)
local u9 = u6:GetChildren()
for u10 = 1, #u9 do
    if u9[u10]:IsA("ImageButton") then
        u9[u10].MouseButton1Click:Connect(function() --[[ Line: 19 ]]
            --[[
            Upvalues:
                [1] = u8
                [2] = u7
                [3] = u9
                [4] = u10
                [5] = u3
            --]]
            if u8 == true then
                u7:FireServer(u9[u10]:GetAttribute("buttonValue"))
            else
                script.Parent.clientEvent:Fire(u9[u10]:GetAttribute("buttonValue"))
            end
            _G.hideUI(false)
            u3:Destroy()
        end)
    end
end
local function v21() --[[ Line: 31 ]]
    --[[
    Upvalues:
        [1] = u6
        [2] = u4
        [3] = u1
        [4] = u5
    --]]
    local v11 = u6.UIListLayout.AbsoluteContentSize
    local v12 = u4.AbsolutePosition
    local v13 = u4.AbsoluteSize
    local v14, v15 = u1:GetGuiInset()
    local v16 = v12 + (v14 - v15) + v13 / 2
    local v17 = v13.Y
    local v18 = v11.Y + v13.Y - u6.AbsoluteSize.Y
    local v19 = math.max(v17, v18)
    local v20 = (v19 - v13.Y) / 2
    u5.Size = UDim2.new(0, v13.X, 0, v19)
    u5.Position = UDim2.new(0, v16.X, 0, v16.Y + v20)
end
v21()
script.Roblox_UI_Indicator:Play()
_G.tween(u5.UIStroke, {
    0.4,
    Enum.EasingStyle.Sine,
    Enum.EasingDirection.Out,
    -1,
    true,
    0
}, {
    ["Thickness"] = 0
})
u3:GetPropertyChangedSignal("AbsoluteSize"):Connect(v21)