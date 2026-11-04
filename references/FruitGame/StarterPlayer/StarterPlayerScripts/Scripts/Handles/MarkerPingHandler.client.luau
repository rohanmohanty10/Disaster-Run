 

local v1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
game:GetService("StarterPlayer")
local u3 = v1.LocalPlayer
local _ = u3.PlayerGui
local v4 = game:GetService("UserInputService")
local v5 = require(v2.Modules.Trove)
u3.PlayerScripts:WaitForChild("PlayerModule")
local u6 = game:GetService("ReplicatedStorage").Marker
local u7 = nil
local u8 = u3:GetMouse()
local u9 = false
local u10 = require(script.MarkerMenu).new()
local u11 = Vector2.new()
local u12 = Vector3.new()
local u13 = {}
local u14 = require(script:WaitForChild("Marker"))
local u15 = nil
u6.OnClientEvent:Connect(function(p16) --[[ Line: 27 ]]
    --[[
    Upvalues:
        [1] = u13
        [2] = u14
        [3] = u7
    --]]
    local u17 = p16.Player
    local v18 = u13[p16.Player]
    local v19 = script.MarkerMenu:FindFirstChild(p16.Type)
    local v20 = nil
    local u21
    if v18 then
        u21 = u13[p16.Player].Marker
        v20 = u13[p16.Player].Blip
    else
        u21 = u14.new(p16)
        if u7 then
            v20 = _G.addBlip("Marker", u21.Part, p16.Type)
        end
        u13[p16.Player] = {
            ["Marker"] = u21,
            ["Blip"] = v20
        }
    end
    if v20 then
        v20.ImageColor3 = v19.ImageColor3
        v20.Image = v19.Image
        v20.areaLabel.Text = p16.Type .. "<br/>-" .. p16.Player.DisplayName
        v20.UIGradient.Color = v19.UIGradient.Color
        v20.shadow.Image = v20.Image
        v20.AnchorPoint = p16.Minimap and Vector2.one or Vector2.new(0.5, 0.5)
    end
    u21:Update(p16.Position, p16.Type)
    if script.PingSFX:FindFirstChild(p16.Type) then
        _G.PlaySound(CFrame.new(p16.Position), script.PingSFX[p16.Type])
    end
    if u13[p16.Player] and (u13[p16.Player].Destroy and coroutine.status(u13[p16.Player].Destroy) ~= "dead") then
        task.cancel(u13[p16.Player].Destroy)
    end
    u13[p16.Player].Destroy = task.delay(u13[p16.Player].Marker.Duration - 1, function() --[[ Line: 70 ]]
        --[[
        Upvalues:
            [1] = u21
            [2] = u13
            [3] = u17
        --]]
        u21:FadeOut()
        task.delay(1, function() --[[ Line: 72 ]]
            --[[
            Upvalues:
                [1] = u21
            --]]
            u21:Destroy()
        end)
        u13[u17] = nil
    end)
end)
v4.InputBegan:Connect(function(p22, p23) --[[ Line: 79 ]]
    --[[
    Upvalues:
        [1] = u10
        [2] = u11
        [3] = u8
        [4] = u12
        [5] = u9
    --]]
    if p23 then
        return
    elseif p22.UserInputType == Enum.UserInputType.MouseButton3 then
        if game:GetService("GuiService"):IsTenFootInterface() ~= true then
            u10:Choose()
            u11 = Vector2.new(u8.X, u8.Y)
            u12 = u8.Hit.Position
            if u9 == true then
                Hovering = true
            end
        end
    else
        return
    end
end)
v4.InputEnded:Connect(function(p24, p25) --[[ Line: 100 ]]
    --[[
    Upvalues:
        [1] = u10
        [2] = u7
        [3] = u15
        [4] = u3
        [5] = u6
        [6] = u12
    --]]
    if p25 then
        return
    elseif p24.UserInputType == Enum.UserInputType.MouseButton3 then
        if game:GetService("GuiService"):IsTenFootInterface() == true then
            return
        else
            u10:Select()
            if Hovering and (u7 and u7.ScreenGui.Enabled) then
                local v26 = u7.MainBlip.AbsolutePosition - u10.MousePosition
                local v27 = u15.customBlip.AbsoluteSize
                local v28 = v26.X
                local v29 = v26.Y
                local v30 = Vector3.new(v28, 0, v29)
                local v31 = v27.X
                local v32 = v27.Y
                local v33 = v30 + Vector3.new(v31, 0, v32) * 0.5
                local v34 = u7.TruePixelsPerStudX
                local v35 = u7.TruePixelsPerStudY
                local v36 = v33 / Vector3.new(v34, 1, v35)
                local v37 = u3.Character.PrimaryPart
                if u3.ReplicationFocus ~= nil then
                    v37 = u3.ReplicationFocus
                end
                u6:FireServer({
                    ["Position"] = v37.Position - v36,
                    ["Type"] = u10.Selected,
                    ["MinimapOpen"] = true
                })
                Hovering = false
            else
                u6:FireServer({
                    ["Position"] = u12,
                    ["Type"] = u10.Selected
                })
            end
        end
    else
        return
    end
end)
local u38 = v5.new()
function _G.attachMinimapToMarker(p39, p40) --[[ Line: 136 ]]
    --[[
    Upvalues:
        [1] = u7
        [2] = u15
        [3] = u38
        [4] = u9
    --]]
    u7 = p39
    u15 = p40
    local v41 = u7.ScreenGui.Frame
    local _ = v41.Size
    u38:Clean()
    u38:Add(v41.MouseEnter:Connect(function() --[[ Line: 146 ]]
        --[[
        Upvalues:
            [1] = u9
        --]]
        u9 = true
    end))
    u38:Add(v41.MouseLeave:Connect(function() --[[ Line: 152 ]]
        --[[
        Upvalues:
            [1] = u9
        --]]
        u9 = false
    end))
end