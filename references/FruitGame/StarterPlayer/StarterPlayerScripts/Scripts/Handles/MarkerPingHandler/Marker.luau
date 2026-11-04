 

local u1 = game:GetService("RunService")
local u2 = game:GetService("TweenService")
local u3 = workspace.CurrentCamera
local u4 = game.Players.LocalPlayer
local u5 = {}
local u6 = {}
u6.__index = u6
function u6.new(p7) --[[ Line: 11 ]]
    --[[
    Upvalues:
        [1] = u6
        [2] = u4
        [3] = u5
    --]]
    local v8 = u6
    local v9 = setmetatable({}, v8)
    local v10 = script.MainFrame:Clone()
    v10.Parent = u4.PlayerGui.IndicatorGui
    v10.IconImage.ImageColor3 = p7.Color
    local v11 = script.Part:Clone()
    v11.Position = p7.Position
    v11.Parent = workspace.Effects
    for _, v12 in v11.Attachment:GetChildren() do
        v12.Color = ColorSequence.new(p7.Color)
    end
    v9.UI = v10
    v9.Part = v11
    v9.Player = p7.Player
    v9.Color = p7.Color
    v9.Duration = 5
    v9.OnScreen = false
    v9.Tween = nil
    v9.DangerPing = nil
    u5[v9.Player] = v9
    v9:_main()
    return v9
end
function u6._dangerPing(u13, u14) --[[ Line: 45 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    if u13.DangerPing and coroutine.status(u13.DangerPing) ~= "dead" then
        task.cancel(u13.DangerPing)
    end
    u13.DangerPing = task.spawn(function() --[[ Line: 50 ]]
        --[[
        Upvalues:
            [1] = u13
            [2] = u14
            [3] = u2
        --]]
        for _ = 1, 3 do
            local v15 = u13.UI.Circle
            v15.BackgroundTransparency = 0
            v15.Size = UDim2.fromOffset(0, 0)
            v15.BackgroundColor3 = script.Parent.MarkerMenu[u14].ImageColor3
            v15.UIGradient.Color = script.Parent.MarkerMenu[u14].UIGradient.Color
            u13.Tween = u2:Create(v15, TweenInfo.new(0.5), {
                ["Size"] = UDim2.fromScale(1, 1),
                ["BackgroundTransparency"] = 1
            }):Play()
            task.wait(1)
        end
    end)
end
function u6.Update(p16, p17, p18) --[[ Line: 90 ]]
    p16:MoveLocation(p17, p18)
    p16.UI.IconImage.Image = script.Parent.MarkerMenu[p18].Image
    p16.UI.IconImage.ImageColor3 = script.Parent.MarkerMenu[p18].ImageColor3
    p16.UI.IconImage.UIGradient.Color = script.Parent.MarkerMenu[p18].UIGradient.Color
    p16.UI.IconImage.playerName.Text = p18 .. "<br/>-" .. p16.Player.DisplayName
    p16.UI.IconImage.shadow.Image = script.Parent.MarkerMenu[p18].Image
    _G.recolorParticles(p16.Part, script.Parent.MarkerMenu[p18].UIGradient.Color)
end
function u6.MoveLocation(p19, p20, p21) --[[ Line: 101 ]]
    local v22 = p19.Part
    p19:_dangerPing(p21)
    v22.Position = p20
end
function u6.FadeOut(p23) --[[ Line: 111 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    u2:Create(p23.UI.IconImage, TweenInfo.new(1), {
        ["ImageTransparency"] = 1
    }):Play()
    u2:Create(p23.UI.IconImage.shadow, TweenInfo.new(1), {
        ["ImageTransparency"] = 1
    }):Play()
    u2:Create(p23.UI.IconImage.Distance, TweenInfo.new(1), {
        ["TextTransparency"] = 1
    }):Play()
    u2:Create(p23.UI.IconImage.playerName, TweenInfo.new(1), {
        ["TextTransparency"] = 1
    }):Play()
    u2:Create(p23.Part.Beam, TweenInfo.new(1), {
        ["Width0"] = 0,
        ["Width1"] = 0
    }):Play()
    for _, v24 in p23.Part.Attachment:GetChildren() do
        v24.Enabled = false
    end
end
function u6._main(u25) --[[ Line: 124 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u3
        [3] = u2
    --]]
    local u26 = 0
    u25.RunService = u1.RenderStepped:Connect(function(p27) --[[ Line: 126 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u25
            [3] = u2
            [4] = u26
        --]]
        local v28 = u3.ViewportSize.X
        local v29 = u3.ViewportSize.Y
        local v30 = u25.UI.AbsoluteSize.X / 2
        local v31 = v28 - v30 * 2
        local v32 = v29 - v30 * 2
        local v33 = u3.CFrame
        local v34 = (v31 / 2) ^ 2 + (v32 / 2) ^ 2
        local v35 = math.sqrt(v34)
        local v36 = u3.CFrame.LookVector
        local _ = Vector2.new(v36.X, v36.Z).Unit
        local v37 = u25.Part.Position + Vector3.new(0, 2.5, 0)
        local v38, v39 = u3:WorldToViewportPoint(v37)
        local v40 = v38.X
        local v41 = v28 - v30
        local v42 = math.clamp(v40, v30, v41)
        local v43 = v38.Y
        local v44 = v29 - v30
        local v45 = math.clamp(v43, v30, v44)
        local v46 = UDim2.fromOffset()
        if v42 == v38.X and (v45 == v38.Y and v39) then
            if not u25.OnScreen then
                u25.OnScreen = true
                u25.Tween = u2:Create(u25.UI.IconImage, TweenInfo.new(0.2), {
                    ["Rotation"] = u25.UI.IconImage.Rotation < 180 and 0 or 360
                })
                u25.Tween:Play()
            end
            local v47 = UDim2.fromOffset
            local v48 = u26 * 3.141592653589793
            v46 = v47(0, math.sin(v48) * 5 - 2.5)
        else
            u25.OnScreen = false
            if u25.Tween then
                u25.Tween:Cancel()
                u25.Tween = nil
            end
            local v49 = v33:VectorToObjectSpace(v37 - v33.Position)
            local v50 = Vector2.new(v49.X, v49.Y).Unit
            local v51 = v50 * v35
            local v52 = v50.X
            local v53 = v50.Y
            local v54 = math.atan2(v52, v53)
            local v55 = v51.Y
            local v56
            if math.abs(v55) > v32 / 2 then
                local v57 = v32 / 2 / v50.Y
                v56 = v50 * math.abs(v57)
            else
                local v58 = v31 / 2 / v50.X
                v56 = v50 * math.abs(v58)
            end
            v42 = v28 / 2 + v56.X
            v45 = v29 / 2 - v56.Y
            local v59 = ((u25.UI.IconImage.Rotation + 15) % 360 < 15 or (u25.UI.IconImage.Rotation - 15) % 360 > 345) and 1 or 0.25
            local v60 = u25.UI.IconImage
            local v61 = u25.UI.IconImage.Rotation
            local v62 = v54 + 3.141592653589793
            v60.Rotation = v61 + (math.deg(v62) - v61) * v59
        end
        u26 = u26 + p27
        local v63 = u25.UI.IconImage.Distance
        local v64 = (workspace.CurrentCamera.CFrame.Position - v37).Magnitude
        v63.Text = ("%*m"):format((math.ceil(v64)))
        u25.UI.IconImage.Distance.Rotation = -u25.UI.IconImage.Rotation
        u25.UI.Position = UDim2.fromOffset(v42, v45) + v46
    end)
end
function u6.Destroy(p65) --[[ Line: 205 ]]
    p65.RunService:Disconnect()
    p65.RunService = nil
    p65.UI:Destroy()
    p65.Part:Destroy()
    setmetatable(p65, nil)
end
return u6