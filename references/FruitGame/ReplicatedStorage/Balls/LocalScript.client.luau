 

local v1 = script.Parent.Frame.Frame.Position
local v2 = script.Parent.TextLabel.TextLabel.Position
local v3 = script.Parent.TextLabel2.Frame.Size
script.Parent.TextLabel2.Frame.Size = UDim2.new(0, 0, script.Parent.TextLabel2.Frame.Size.Y.Scale, 0)
script.Parent.TextLabel2.Frame.Position = UDim2.new(0.5, 0, 1, 0)
script.Parent.Frame.Frame.Position = UDim2.new(0, 0, -1, 0)
script.Parent.TextLabel.TextLabel.Position = UDim2.new(0, 0, 1, 0)
script.Parent.TextLabel2.Frame:TweenSizeAndPosition(v3, UDim2.new(0, 0, 1, 0), "Out", "Quad", 0.25, true)
task.wait(0.25)
script.Parent.TextLabel.TextLabel:TweenPosition(v2, "Out", "Quad", 0.25, true)
task.wait(0.25)
script.Parent.Frame.Frame:TweenPosition(v1, "Out", "Quad", 0.25, true)
local u4 = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0)
local function u9() --[[ Line: 17 ]]
    --[[
    Upvalues:
        [1] = u4
    --]]
    local v5 = script.Parent.Frame.Frame:GetChildren()
    for v6 = 1, #v5 do
        if v5[v6]:IsA("Frame") and v5[v6].Name ~= _G.balltype then
            local v7 = {
                ["TextColor3"] = Color3.fromRGB(255, 255, 255)
            }
            game:GetService("TweenService"):Create(v5[v6].TextButton, u4, v7):Play()
        elseif v5[v6]:IsA("Frame") then
            local v8 = {
                ["TextColor3"] = Color3.fromRGB(89, 171, 227)
            }
            game:GetService("TweenService"):Create(v5[v6].TextButton, u4, v8):Play()
        end
    end
end
u9()
local u10 = script.Parent.Frame.Frame:GetChildren()
local u11 = {}
for u12 = 1, #u10 do
    if u10[u12]:IsA("Frame") then
        local v13 = u10[u12]
        table.insert(u11, v13)
        u10[u12].TextButton.MouseButton1Click:Connect(function() --[[ Line: 41 ]]
            --[[
            Upvalues:
                [1] = u10
                [2] = u12
                [3] = u9
            --]]
            _G.balltype = u10[u12].Name
            u9()
        end)
    end
end
local u14 = game.ReplicatedStorage:FindFirstChild("Stats" .. game.Players.LocalPlayer.Name)
local function u21(p15, p16) --[[ Line: 49 ]]
    local v17 = game.ReplicatedStorage:FindFirstChild("Stats" .. p15.Name)
    local v18 = 0
    for v19, v20 in game:GetService("HttpService"):JSONDecode(v17.Inventory.Inventory.Value) do
        if v19 == p16 then
            v18 = v20
        end
    end
    return v18
end
while true do
    repeat
        task.wait()
        pcall(function() --[[ Line: 66 ]]
            --[[
            Upvalues:
                [1] = u14
                [2] = u11
                [3] = u21
            --]]
            game:GetService("HttpService"):JSONDecode(u14.Inventory.Inventory.Value)
            for v22 = 1, #u11 do
                local v23 = u11[v22].Name .. " Cannonball"
                local v24 = u21(game.Players.LocalPlayer, v23)
                u11[v22].ammount.Text = "x" .. v24
                if v24 <= 0 then
                    u11[v22].Visible = false
                    if _G.balltype == u11[v22].Name then
                        _G.balltype = ""
                    end
                else
                    u11[v22].Visible = true
                end
            end
        end)
        local v25 = game.Players.LocalPlayer.Character
    until v25 and (v25:FindFirstChild("Humanoid") and v25.Humanoid.SeatPart == nil)
    pcall(function() --[[ Line: 84 ]]
        script.Parent:Destroy()
    end)
end