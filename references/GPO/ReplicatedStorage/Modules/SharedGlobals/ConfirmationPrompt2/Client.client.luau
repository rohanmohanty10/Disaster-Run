 

local u1 = script.Parent
local v2 = u1:WaitForChild("Main"):WaitForChild("OptionsFrame")
local u3 = u1:WaitForChild("RemoteEvent")
local u4 = u1:GetAttribute("isServer")
_G.hideUI(true)
local u5 = v2:GetChildren()
for u6 = 1, #u5 do
    if u5[u6]:IsA("ImageButton") then
        u5[u6].MouseButton1Click:Connect(function() --[[ Line: 11 ]]
            --[[
            Upvalues:
                [1] = u4
                [2] = u3
                [3] = u5
                [4] = u6
                [5] = u1
            --]]
            if u4 == true then
                u3:FireServer(u5[u6]:GetAttribute("buttonValue"))
            else
                script.Parent.clientEvent:Fire(u5[u6]:GetAttribute("buttonValue"))
            end
            _G.hideUI(false)
            u1:Destroy()
        end)
    end
end
script.Roblox_UI_Indicator:Play()
_G.tween(script.Parent.Main.UIStroke, {
    0.4,
    Enum.EasingStyle.Sine,
    Enum.EasingDirection.Out,
    -1,
    true,
    0
}, {
    ["Thickness"] = 0
})