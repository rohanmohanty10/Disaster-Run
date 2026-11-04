 

local v1 = game:GetService("ReplicatedStorage")
game:GetService("TweenService")
local v2 = game:GetService("HttpService")
local u3 = game:GetService("Players")
local v4 = game.ReplicatedStorage.Assets.Buildables:GetChildren()
local v5 = require(v1.Modules.Module3D)
local v6 = v1:FindFirstChild("Stats" .. u3.LocalPlayer.Name)
local u7 = script.Parent.Parent:WaitForChild("remote")
local v8 = {
    ["Important"] = -1,
    ["Damage"] = 0,
    ["Buildings"] = 100,
    ["Walls"] = 200,
    ["Misc"] = 300
}
local u9 = {}
for v10 = 1, #v4 do
    local v11 = v4[v10]:Clone()
    local v12 = script.Frame:Clone()
    local v13 = v11:GetAttribute("woodCost") or 0
    local u14 = v11.Name
    local v15 = v5:Attach3D(v12.Display, v11)
    v15:SetDepthMultiplier(1)
    v15.Camera.FieldOfView = 30
    v15.Visible = true
    v15:SetCFrame(CFrame.Angles(-0.7853981633974483, 0, 0))
    local v16 = v12.Display:FindFirstChild("ViewportFrame")
    if v16 then
        v16.ZIndex = 5
        v16.BackgroundColor3 = Color3.fromRGB(79, 79, 79)
    end
    v12.LayoutOrder = (v8[v11:GetAttribute("Catagory") or "Misc"] or 300) + (v11:GetAttribute("displayOrder") or 0)
    v12.Cost.Text = v13
    v12.Name = u14
    v12.Parent = script.Parent.ScrollingFrame
    local u17 = v12.UIStroke
    u17.Enabled = false
    table.insert(u9, {
        ["button"] = v12,
        ["stroke"] = u17,
        ["model"] = v11,
        ["name"] = u14,
        ["cost"] = v13
    })
    v12.MouseButton1Click:Connect(function() --[[ Line: 58 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u14
            [3] = u9
            [4] = u17
            [5] = u7
        --]]
        if not u3.LocalPlayer.Character or (not u3.LocalPlayer.Character.PrimaryPart or u3.LocalPlayer.Character.PrimaryPart.Anchored ~= true) then
            _G.planktype = u14
            for _, v18 in ipairs(u9) do
                v18.stroke.Enabled = false
            end
            u17.Enabled = true
            if u7 and u7.Value then
                u7.Value:FireServer(u14)
            end
        end
    end)
end
if _G.planktype then
    for _, v19 in ipairs(u9) do
        if v19.name == _G.planktype then
            v19.stroke.Enabled = true
        end
    end
end
while true do
    if v6 and v6.Inventory.Inventory.Value then
        v2:JSONDecode(v6.Inventory.Inventory.Value)
        for v20 = 1, #u9 do
            local v21 = u9[v20]
            if (_G.CheckItemAmmount(u3.LocalPlayer, "Wooden Plank") or 0) < v21.cost then
                v21.button.ImageTransparency = 0.5
                v21.button.Cost.TextColor3 = Color3.fromRGB(255, 100, 100)
            else
                v21.button.ImageTransparency = 0
                v21.button.Cost.TextColor3 = Color3.fromRGB(0, 255, 0)
            end
        end
        local v22 = _G.CheckItemAmmount(u3.LocalPlayer, "Wooden Plank")
        script.Parent.TextFrames.PlankCount.Text = "Wooden Planks: " .. v22
    end
    task.wait(0.1)
end