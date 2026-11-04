 

local u1 = game:GetService("GuiService")
local v2 = game:GetService("ReplicatedStorage")
require(v2.Modules.MEnterLeave)
local u3 = script.Parent
local u4 = u3:WaitForChild("Main")
local u5 = u3:WaitForChild("Background")
local u6 = u4:WaitForChild("OptionsFrame")
local u7 = u3:WaitForChild("RemoteEvent")
local u8 = u3:GetAttribute("isServer")
local u9 = u3:GetAttribute("ScaleWithText") or false
local u10 = u3:GetAttribute("MultiSelect") or false
if u9 == true then
    u4.AutomaticSize = Enum.AutomaticSize.Y
    u4.TextLabel.AutomaticSize = Enum.AutomaticSize.Y
else
    u4.AutomaticSize = Enum.AutomaticSize.None
    u4.TextLabel.AutomaticSize = Enum.AutomaticSize.None
end
local u11
if _G.UIEnabled == true then
    _G.hideUI(true)
    u11 = true
else
    u11 = false
end
local function u13(p12) --[[ Line: 31 ]]
    --[[
    Upvalues:
        [1] = u8
        [2] = u7
        [3] = u11
        [4] = u3
    --]]
    if u8 == true then
        u7:FireServer(p12)
    else
        script.Parent.clientEvent:Fire(p12)
    end
    if u11 == true then
        _G.hideUI(false)
    end
    u3:Destroy()
end
local v14 = u6:GetChildren()
for v15 = 1, #v14 do
    if v14[v15]:IsA("ImageButton") then
        local u16 = v14[v15]
        if u10 and u16:GetAttribute("Toggleable") then
            u16.MouseButton1Click:Connect(function() --[[ Line: 49 ]]
                --[[
                Upvalues:
                    [1] = u16
                --]]
                local v17 = not u16:GetAttribute("Selected")
                u16:SetAttribute("Selected", v17)
                if v17 then
                    u16.ImageColor3 = u16:GetAttribute("SelectedColor") or Color3.fromRGB(100, 200, 100)
                else
                    u16.ImageColor3 = u16:GetAttribute("UnselectedColor") or Color3.fromRGB(80, 80, 80)
                end
            end)
        else
            u16.MouseButton1Click:Connect(function() --[[ Line: 60 ]]
                --[[
                Upvalues:
                    [1] = u10
                    [2] = u16
                    [3] = u6
                    [4] = u13
                --]]
                if not u10 or u16:GetAttribute("buttonValue") ~= "_selectAll" then
                    if u10 and u16:GetAttribute("buttonValue") == "_apply" then
                        local v18 = {}
                        for _, v19 in u6:GetChildren() do
                            if v19:IsA("ImageButton") and (v19:GetAttribute("Toggleable") and v19:GetAttribute("Selected")) then
                                table.insert(v18, v19:GetAttribute("buttonValue"))
                            end
                        end
                        u13("MULTISELECT:" .. table.concat(v18, ","))
                    else
                        u13(u16:GetAttribute("buttonValue"))
                    end
                end
                local v20 = true
                for _, v21 in u6:GetChildren() do
                    if v21:IsA("ImageButton") and (v21:GetAttribute("Toggleable") and not v21:GetAttribute("Selected")) then
                        v20 = false
                        break
                    end
                end
                for _, v22 in u6:GetChildren() do
                    if v22:IsA("ImageButton") and v22:GetAttribute("Toggleable") then
                        v22:SetAttribute("Selected", not v20)
                        if v20 then
                            v22.ImageColor3 = v22:GetAttribute("UnselectedColor") or Color3.fromRGB(80, 80, 80)
                        else
                            v22.ImageColor3 = v22:GetAttribute("SelectedColor") or Color3.fromRGB(100, 200, 100)
                        end
                    end
                end
            end)
        end
    end
end
local function u38() --[[ Line: 97 ]]
    --[[
    Upvalues:
        [1] = u6
        [2] = u4
        [3] = u1
        [4] = u9
        [5] = u5
    --]]
    local v23 = u6.UIListLayout.AbsoluteContentSize
    local v24 = u4.AbsolutePosition
    local v25 = u4.AbsoluteSize
    local v26, v27 = u1:GetGuiInset()
    local v28 = v24 + (v26 - v27) + v25 / 2
    local v29 = v25.Y
    local v30 = v23.Y + v25.Y - u6.AbsoluteSize.Y
    local v31 = math.max(v29, v30)
    local v32 = v25.X
    local v33 = v23.X + v25.X - u6.AbsoluteSize.X
    local v34 = math.max(v32, v33)
    local v35 = (v31 - v25.Y) / 2
    local v36 = (v34.X - v25.X) / 2
    local v37 = u9 == false and 1 or 1.1
    u5.Size = UDim2.new(0, v25.X * v37, 0, v31 * v37)
    u5.Position = UDim2.new(0, v28.X + v36, 0, v28.Y + v35)
end
task.defer(function() --[[ Line: 122 ]]
    --[[
    Upvalues:
        [1] = u38
    --]]
    u38()
end)
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
u3:GetPropertyChangedSignal("AbsoluteSize"):Connect(u38)
u6:GetPropertyChangedSignal("AbsoluteSize"):Connect(u38)