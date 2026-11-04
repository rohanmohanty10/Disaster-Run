 

local v1 = script.Parent.Frame.Frame
local u2 = v1.Position
local u3 = script.Parent.TextLabel.TextLabel.Position
local u4 = script.Parent.TextLabel2.Frame.Size
script.Parent.TextLabel2.Frame.Size = UDim2.new(0, 0, script.Parent.TextLabel2.Frame.Size.Y.Scale, 0)
script.Parent.TextLabel2.Frame.Position = UDim2.new(0.5, 0, 1, 0)
script.Parent.Frame.Frame.Position = UDim2.new(0, 0, -1, 0)
script.Parent.TextLabel.TextLabel.Position = UDim2.new(0, 0, 1, 0)
task.spawn(function() --[[ Line: 11 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u3
        [3] = u2
    --]]
    script.Parent.TextLabel2.Frame:TweenSizeAndPosition(u4, UDim2.new(0, 0, 1, 0), "Out", "Quad", 0.25, true)
    task.wait(0.25)
    script.Parent.TextLabel.TextLabel:TweenPosition(u3, "Out", "Quad", 0.25, true)
    task.wait(0.25)
    script.Parent.Frame.Frame:TweenPosition(u2, "Out", "Quad", 0.25, true)
end)
local v5 = {
    ["Bush"] = 0,
    ["Small Shack"] = 4,
    ["Big Shack"] = 5,
    ["Watch Tower"] = 6,
    ["Wooden Spikes"] = 2,
    ["Wooden Wall"] = 1,
    ["Spike Trap"] = 7,
    ["Wooden Door Wall"] = 3,
    ["Wooden Ladder"] = 3,
    ["Spike Turret"] = 8
}
local v6 = script.Parent:GetAttribute("Buildables")
if v6 then
    local v7 = game:GetService("HttpService"):JSONDecode(v6)
    for v8, v9 in pairs(v7) do
        local v10 = script.Template:Clone()
        v10.Name = v8
        v10.TextButton.Text = v8
        v10.ammount.Text = v9 .. " Wood"
        v10.Parent = v1
        if v8 == "Campfire" then
            v10.LayoutOrder = -1
        elseif v5[v8] then
            v10.LayoutOrder = v5[v8]
        end
    end
end
local u11 = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0)
local function u16() --[[ Line: 55 ]]
    --[[
    Upvalues:
        [1] = u11
    --]]
    local v12 = script.Parent.Frame.Frame:GetChildren()
    for v13 = 1, #v12 do
        if v12[v13]:IsA("Frame") and v12[v13].Name ~= _G.planktype then
            local v14 = {
                ["TextColor3"] = Color3.fromRGB(255, 255, 255)
            }
            game:GetService("TweenService"):Create(v12[v13].TextButton, u11, v14):Play()
        elseif v12[v13]:IsA("Frame") then
            local v15 = {
                ["TextColor3"] = Color3.fromRGB(89, 171, 227)
            }
            game:GetService("TweenService"):Create(v12[v13].TextButton, u11, v15):Play()
        end
    end
end
u16()
local u17 = v1:GetChildren()
local v18 = {}
for u19 = 1, #u17 do
    if u17[u19]:IsA("Frame") then
        local v20 = u17[u19]
        table.insert(v18, v20)
        u17[u19].TextButton.MouseButton1Click:Connect(function() --[[ Line: 83 ]]
            --[[
            Upvalues:
                [1] = u17
                [2] = u19
                [3] = u16
            --]]
            if game.Players.LocalPlayer.Character.PrimaryPart.Anchored ~= true then
                _G.planktype = u17[u19].Name
                pcall(function() --[[ Line: 88 ]]
                    --[[
                    Upvalues:
                        [1] = u17
                        [2] = u19
                    --]]
                    script.Parent.remote.Value:FireServer(u17[u19].Name)
                end)
                u16()
            end
        end)
    end
end
local v21 = game.ReplicatedStorage:FindFirstChild("Stats" .. game.Players.LocalPlayer.Name)
local function v28(p22, p23) --[[ Line: 97 ]]
    local v24 = game.ReplicatedStorage:FindFirstChild("Stats" .. p22.Name)
    local v25 = 0
    for v26, v27 in game:GetService("HttpService"):JSONDecode(v24.Inventory.Inventory.Value) do
        if v26 == p23 then
            v25 = v27
        end
    end
    return v25
end
while true do
    game:GetService("HttpService"):JSONDecode(v21.Inventory.Inventory.Value)
    for v29 = 1, #v18 do
        if v18[v29].Name == "Wooden" then
            local v30 = v18[v29].Name .. " Plank"
            local v31 = v28(game.Players.LocalPlayer, v30)
            v18[v29].ammount.Text = "x" .. v31
            if v31 <= 0 then
                v18[v29].Visible = false
                if _G.planktype == v18[v29].Name then
                    _G.planktype = ""
                end
            else
                v18[v29].Visible = true
            end
        end
    end
    script.Parent.TextLabel.TextLabel.Text = "Wooden Planks: " .. _G.CheckItemAmmount(game.Players.LocalPlayer, "Wooden Plank")
    task.wait(0.1)
end