 

local v1 = game:GetService("Players").LocalPlayer
local v2 = v1.PlayerGui
local u3 = game:GetService("UserInputService")
local v4 = script.Parent
local v5 = require(v4:WaitForChild("Minimap"))
local v6 = v4:WaitForChild("GuiElements")
local v7 = v6:WaitForChild("Blips")
local v8 = v6:WaitForChild("Map")
local v9 = v7:WaitForChild("LocalPlayer")
local u10 = {
    ["Marker"] = v7:WaitForChild("Marker"),
    ["stormCenter"] = v7:WaitForChild("stormCenter"),
    ["Player"] = v7:WaitForChild("Player"),
    ["hotZone"] = v7:WaitForChild("hotZone"),
    ["busRoute"] = v7:WaitForChild("busRoute"),
    ["campfire"] = v7:WaitForChild("campfire"),
    ["areaLabel"] = v7:WaitForChild("areaLabel"),
    ["phoLabel"] = v7:WaitForChild("phoLabel"),
    ["customBlip"] = v7:WaitForChild("customBlip")
}
local v11 = script:GetAttribute("Center")
local v12 = game:GetService("HttpService"):JSONDecode(script:GetAttribute("Resolution"))
local u13 = v5.CreateMinimap(false, false, false, v11, 2, v12, true, false, "Minimap")
u13:ImportMap(v8:Clone())
local v14 = (v1.Character or v1.CharacterAdded:Wait()):WaitForChild("HumanoidRootPart")
u13:ImportMainBlip(v9:Clone(), v14, true)
u13:Run()
local u15 = game.Players.LocalPlayer
local u16 = nil
game.Players.LocalPlayer.CharacterAdded:Connect(function(p17) --[[ Line: 54 ]]
    --[[
    Upvalues:
        [1] = u15
        [2] = u16
        [3] = u13
    --]]
    local v18 = p17:WaitForChild("HumanoidRootPart")
    if u15.Team == game.Teams.Eliminated then
        if u16 == nil then
            u16 = script.camPart:Clone()
            u16.Parent = workspace.Effects
            game["Run Service"].RenderStepped:Connect(function() --[[ Line: 60 ]]
                --[[
                Upvalues:
                    [1] = u16
                --]]
                u16.CFrame = workspace.CurrentCamera.CFrame
            end)
            u13:UpdateMainBlipPart(u16)
            return
        end
    else
        u13:UpdateMainBlipPart(v18)
    end
end)
u13.ScreenGui.Enabled = false
game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false)
u3.InputBegan:Connect(function(p19, p20) --[[ Line: 74 ]]
    --[[
    Upvalues:
        [1] = u13
        [2] = u3
    --]]
    if p20 then
        return
    elseif p19.KeyCode == Enum.KeyCode.Tab then
        u13.ScreenGui.Enabled = true
        repeat
            task.wait()
        until u3:IsKeyDown(Enum.KeyCode.Tab) == false
        u13.ScreenGui.Enabled = false
    elseif p19.KeyCode == Enum.KeyCode.CapsLock and game:GetService("GuiService"):IsTenFootInterface() == true then
        u13.ScreenGui.Enabled = true
        repeat
            task.wait()
        until u3:IsKeyDown(Enum.KeyCode.CapsLock) == false
        u13.ScreenGui.Enabled = false
    end
end)
local v21 = v2:WaitForChild("BattleRoyaleMiniMap")
local v22 = v21.MiniMap
local v23 = v1:WaitForChild("PlayerScripts")
v21.Enabled = require(v23:WaitForChild("InputHandler")):GetCurrentInput() == "Mobile"
v22.Activated:Connect(function() --[[ Line: 101 ]]
    --[[
    Upvalues:
        [1] = u13
    --]]
    u13.ScreenGui.Enabled = not u13.ScreenGui.Enabled
end)
local u24 = {}
local u25 = game.Players.LocalPlayer
local function u32() --[[ Line: 108 ]]
    --[[
    Upvalues:
        [1] = u25
        [2] = u24
        [3] = u13
        [4] = u10
    --]]
    if u25.Party.Value ~= nil then
        local u26 = game.ReplicatedStorage.currentParty:FindFirstChild(u25.Party.Value.Name):GetChildren()
        for u27 = 1, #u26 do
            local u28 = game.Players:FindFirstChild(u26[u27].Name)
            if u24[u28] == nil and (u28 ~= game.Players.LocalPlayer and (u28.Team == game.Teams.Players and u26[u27]:FindFirstChild("playerColor"))) then
                task.spawn(function() --[[ Line: 116 ]]
                    --[[
                    Upvalues:
                        [1] = u28
                        [2] = u13
                        [3] = u10
                        [4] = u26
                        [5] = u27
                        [6] = u24
                    --]]
                    local v29 = u28.Character
                    if v29 ~= nil then
                        local u30 = v29:WaitForChild("HumanoidRootPart", 100000000000)
                        u13:ImportBlip(u10.Player:Clone(), u30, false, true).ImageColor3 = u26[u27].playerColor.Value
                        u13:EnableBlip(u30)
                        u24[u28] = u30
                        local u31 = nil
                        u31 = u28:GetPropertyChangedSignal("Team"):Connect(function() --[[ Line: 127 ]]
                            --[[
                            Upvalues:
                                [1] = u28
                                [2] = u13
                                [3] = u30
                                [4] = u24
                                [5] = u31
                            --]]
                            if u28.Team ~= game.Teams.Players then
                                warn("eliminated")
                                u13:RemoveBlip(u30)
                                u24[u28] = nil
                                u31:Disconnect()
                            end
                        end)
                        u30.Destroying:Connect(function() --[[ Line: 136 ]]
                            --[[
                            Upvalues:
                                [1] = u13
                                [2] = u30
                                [3] = u24
                                [4] = u28
                            --]]
                            warn("root destryoed removing blip")
                            u13:RemoveBlip(u30)
                            u24[u28] = nil
                            warn("removed blip!")
                        end)
                    end
                end)
            end
        end
    end
end
task.spawn(function() --[[ Line: 147 ]]
    --[[
    Upvalues:
        [1] = u32
    --]]
    while true do
        u32()
        task.wait(1)
    end
end)
local u33 = v23:FindFirstChild("MarkerMenu", true)
function _G.addBlip(p34, p35, p36, p37) --[[ Line: 156 ]]
    --[[
    Upvalues:
        [1] = u13
        [2] = u10
        [3] = u33
    --]]
    if p37 then
        p37 = game:GetService("HttpService"):JSONDecode(p37)
    end
    if p35 then
        p35 = _G.awaitObject(p35)
    end
    if p37 and p37.Position ~= nil then
        p35 = Instance.new("Part")
        p35.Anchored = true
        p35.Transparency = 1
        p35.CanCollide = false
        p35.CanQuery = false
        p35.CanTouch = false
        local v38 = p37.Position
        p35.CFrame = CFrame.new(v38[1], v38[2], v38[3])
        p35.Parent = workspace.Effects
    end
    local v39 = u13:ImportBlip(u10[p34]:Clone(), p35, false, true)
    u13:EnableBlip(p35)
    if p36 and u33:FindFirstChild(p36) then
        local v40 = u33:FindFirstChild(p36)
        v39.Image = v40.Image
        v39.ImageColor3 = v40.ImageColor3
    end
    if p34 == "hotZone" then
        local v41 = script.Parent.Minimap.hotZoneRing:Clone()
        v41.Parent = v39
        local v42 = p35.Mesh.Scale.X / 5.25
        v41.Size = UDim2.new(0, v42, 0, v42)
    elseif p34 == "areaLabel" then
        v39.Text = p35.Name
    end
    if p37 then
        v39.areaLabel.Text = p37.Text
        v39.Image = p37.Image
        if p37.Color then
            v39.areaLabel.TextColor3 = Color3.new(p37.Color[1], p37.Color[2], p37.Color[3])
        end
        if p37.ImageColor then
            local v43 = p37.ImageColor
            v39.ImageColor3 = Color3.new(v43[1], v43[2], v43[3])
        end
        if p37.Size then
            v39.Size = UDim2.new(0, p37.Size, 0, p37.Size)
        end
    end
    return v39
end
function _G.addBusRoute(_, _, p44, p45) --[[ Line: 216 ]]
    --[[
    Upvalues:
        [1] = u13
        [2] = u10
    --]]
    warn("new hotzone added!")
    local v46 = u13:ImportBlip(u10.busRoute:Clone(), p45, false, true)
    u13:EnableBlip(p45)
    local v47 = p44 / 5.25
    v46.Size = UDim2.new(0, 2, 0, v47)
    v46.Rotation = -p45.Orientation.Y
end
_G.attachMinimapToMarker(u13, u10)
repeat
    task.wait()
until _G.stormPart ~= nil
u13:ImportBlip(u10.stormCenter:Clone(), _G.stormPart, false, true)
u13:EnableBlip(_G.stormPart)