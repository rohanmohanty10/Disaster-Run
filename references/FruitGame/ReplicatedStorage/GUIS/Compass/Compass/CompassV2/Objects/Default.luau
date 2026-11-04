 

local u1 = game.Players.LocalPlayer
local u2 = workspace.CurrentCamera
local u3 = game:GetService("TweenService")
local u4 = game:GetService("ReplicatedStorage").CompassGuider
local u11 = {
    ["TextLabel"] = function(p5, p6) --[[ Line: 17 ]]
        local v7
        if p5:IsA("GuiObject") then
            v7 = p5:GetAttribute("canFade") and true or false
        else
            v7 = false
        end
        if v7 then
            p5.TextTransparency = p6
        end
    end,
    ["ImageLabel"] = function(p8, p9) --[[ Line: 22 ]]
        local v10
        if p8:IsA("GuiObject") then
            v10 = p8:GetAttribute("canFade") and true or false
        else
            v10 = false
        end
        if v10 then
            p8.ImageTransparency = p9
        end
    end
}
local u12 = {}
u12.__index = u12
function u12.new(p13) --[[ Line: 31 ]]
    --[[
    Upvalues:
        [1] = u12
        [2] = u3
        [3] = u11
    --]]
    local v14 = u12
    local u15 = setmetatable({}, v14)
    u15.DefaultTransparency = p13.DefaultTransparency or 0
    u15.Guider = p13.Guider
    u15.InView = false
    u15.Angle = 6.283185307179586
    u15.IsVisible = true
    u15._lastTrans = -1
    u15._lastTextUpdate = 0
    u15.Icon = p13.Icon or script.Icon:Clone()
    local v16 = p13.Guider
    if typeof(v16) == "Instance" and not p13.Icon then
        u15.Icon.Flag.Image = p13.Guider:GetAttribute("ImageIcon") or ""
        u15.Icon.Name = p13.Guider.Name
        u15.Icon.Info.Title.Text = p13.Guider.Name:upper()
        local u17 = u15.Icon.Info.Position
        u15.InViewTweens = {
            [true] = function() --[[ Line: 51 ]]
                --[[
                Upvalues:
                    [1] = u3
                    [2] = u15
                    [3] = u17
                --]]
                local v18 = {
                    ["Position"] = u17
                }
                u3:Create(u15.Icon.Info, TweenInfo.new(0.5), v18):Play()
                for _, v19 in pairs(u15.Icon.Info:GetChildren()) do
                    if v19:IsA("TextLabel") then
                        u3:Create(v19, TweenInfo.new(0.5), {
                            ["TextTransparency"] = 0
                        }):Play()
                    end
                end
            end,
            [false] = function() --[[ Line: 72 ]]
                --[[
                Upvalues:
                    [1] = u3
                    [2] = u15
                    [3] = u17
                --]]
                u3:Create(u15.Icon.Info, TweenInfo.new(0.5), {
                    ["Position"] = u17 + UDim2.new(0, 0, 0.25, 0)
                }):Play()
                for _, v20 in pairs(u15.Icon.Info:GetChildren()) do
                    if v20:IsA("TextLabel") then
                        u3:Create(v20, TweenInfo.new(0.5), {
                            ["TextTransparency"] = 1
                        }):Play()
                    end
                end
            end
        }
        u15.InViewTweens[false]()
    end
    u15.CachedUI = {}
    if u11[u15.Icon.ClassName] then
        local v21 = u15.CachedUI
        local v22 = u15.Icon
        table.insert(v21, v22)
    end
    for _, v23 in u15.Icon:GetDescendants() do
        if u11[v23.ClassName] then
            local v24 = u15.CachedUI
            table.insert(v24, v23)
        end
    end
    u15.Icon.Parent = p13.Parent or p13.Handler.CompassUI
    u15.Handler = p13.Handler
    return u15
end
function u12.AutoOptimize(u25) --[[ Line: 116 ]]
    local u26 = u25.Guider
    u25.Optimizer = u26:GetAttributeChangedSignal("isEnabled"):Connect(function() --[[ Line: 138 ]]
        --[[
        Upvalues:
            [1] = u26
            [2] = u25
        --]]
        local v27 = u26:GetAttribute("isEnabled")
        local v28 = u25.Handler.InactiveCoordinates[u26]
        local v29 = u25.Handler.Coordinates[u26]
        if v27 then
            if v28 then
                u25.Handler.InactiveCoordinates[u26] = nil
                u25.Handler.Coordinates[u26] = u25
                u25.Icon.Visible = true
                return
            end
        elseif v29 then
            u25.Handler.Coordinates[u26] = nil
            u25.Handler.InactiveCoordinates[u26] = u25
            u25.Icon.Visible = false
        end
    end)
    local v30 = u26:GetAttribute("isEnabled")
    local v31 = u25.Handler.InactiveCoordinates[u26]
    local v32 = u25.Handler.Coordinates[u26]
    if v30 then
        if v31 then
            u25.Handler.InactiveCoordinates[u26] = nil
            u25.Handler.Coordinates[u26] = u25
            u25.Icon.Visible = true
            return
        end
    elseif v32 then
        u25.Handler.Coordinates[u26] = nil
        u25.Handler.InactiveCoordinates[u26] = u25
        u25.Icon.Visible = false
    end
end
function u12.CheckItems(u33) --[[ Line: 145 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u4
    --]]
    local u34 = nil
    local u35 = u33.Guider
    local u36 = u35:GetAttribute("ImageIcon")
    u33.Handler.ItemAddedCheck:Connect(function(p37) --[[ Line: 151 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u33
            [3] = u34
            [4] = u35
        --]]
        local v38 = u1.Backpack:FindFirstChild(u33.Guider.Name .. " Eternal Pose") ~= nil
        if p37.Name == u33.Guider.Name .. " Eternal Pose" or p37.Name == "Bomi\'s Log Pose" and (_G.HasItem(u1, u33.Guider.Name .. " Eternal Pose") and not v38) then
            if not u33.Guider:GetAttribute("CustomIcon") then
                u33.Icon.Flag.Image = p37.TextureId
            end
            if u34 then
                return
            end
            u34 = u35:GetAttributeChangedSignal("isEnabled"):Connect(function() --[[ Line: 160 ]]
                --[[
                Upvalues:
                    [1] = u35
                --]]
                if not u35:GetAttribute("isEnabled") then
                    u35:SetAttribute("isEnabled", true)
                end
            end)
            u35:SetAttribute("isEnabled", true)
        end
    end)
    u33.Handler.ItemRemovedCheck:Connect(function(p39) --[[ Line: 169 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u33
            [3] = u34
            [4] = u36
            [5] = u35
            [6] = u4
        --]]
        local v40 = u1.Backpack:FindFirstChild(u33.Guider.Name .. " Eternal Pose")
        local v41 = u1.Backpack:FindFirstChild("Bomi\'s Log Pose")
        if p39.Name == u33.Guider.Name .. " Eternal Pose" or p39.Name == "Bomi\'s Log Pose" and _G.HasItem(u1, u33.Guider.Name .. " Eternal Pose") then
            if p39.Parent == u1.Character then
                return
            end
            if not u34 then
                return
            end
            u33.Icon.Flag.Image = v41 and v41.TextureId or (v40 and v40.TextureId or u36)
            if not (v41 or v40) then
                u34:Disconnect()
                u34 = nil
            end
            u35:SetAttribute("isEnabled", u35:GetAttribute("Type") == "Flag" and u4:GetAttribute("CapturePointEnabled") or (v40 ~= nil and true or v41 ~= nil))
        end
    end)
end
function u12.GetAngle(p42, p43) --[[ Line: 189 ]]
    local v44 = p42.Guider
    if typeof(v44) == "number" then
        return p42.Guider + 1.5707963267948966
    end
    local v45 = p42.Guider
    if typeof(v45) ~= "Instance" then
        return nil
    end
    local v46 = p42.Guider.Value
    local v47 = v46.Z - p43.Z
    local v48 = v46.X - p43.X
    return math.atan2(v47, v48)
end
function u12._setUIVisiblity(p49, p50) --[[ Line: 203 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v51 = p49.Guider
    if typeof(v51) ~= "Instance" then
        return math.sin(p50) > 0
    end
    local v52
    if CFrame.new(u2.CFrame.Position * Vector3.new(1, 0, 1), p49.Guider.Value * Vector3.new(1, 0, 1)).LookVector:Dot(u2.CFrame.LookVector * Vector3.new(1, 0, 1)) > 0 then
        v52 = p49.Guider:GetAttribute("isEnabled")
    else
        v52 = false
    end
    return v52
end
function u12.SetInView(p53, p54) --[[ Line: 211 ]]
    if p53.InView == p54 then
        return
    elseif p53.Guider:GetAttribute("isEnabled") then
        p53.InView = p54
        p53.InViewTweens[p54]()
    end
end
function u12.UpdateTransparency(p55, p56) --[[ Line: 219 ]]
    --[[
    Upvalues:
        [1] = u11
    --]]
    if p55.CachedUI then
        for _, v57 in p55.CachedUI do
            u11[v57.ClassName](v57, p56)
        end
    end
end
function u12.Update(p58, p59, p60) --[[ Line: 229 ]]
    local v61 = (p59 or workspace.CurrentCamera.CFrame).Position
    local v62 = p58:GetAngle(v61)
    if v62 then
        local v63 = p58.Handler.RestrictAngle(v62 - p58.Handler.PlayerLookAngle)
        if p60 then
            local v64 = p58.Icon:GetAttribute("CanVisible") ~= false and math.cos(v63) > 0
            if v64 then
                local v65 = p58.Guider
                if typeof(v65) == "Instance" then
                    v64 = p58.Guider:GetAttribute("isEnabled")
                end
            end
            p58.IsVisible = v64
            p58.Icon.Visible = v64
            if v64 then
                local v66 = p58.Guider
                if typeof(v66) == "Instance" then
                    local v67 = os.clock()
                    if v67 - (p58._lastTextUpdate or 0) > 0.5 then
                        local v68 = p58.Icon.Info.Distance
                        local v69 = (p58.Guider.Value - v61).Magnitude
                        v68.Text = math.floor(v69) .. " STUDS"
                        p58._lastTextUpdate = v67
                    end
                end
            end
            local v70 = 1 - math.cos(v63)
            local v71 = (p58._lastTrans or -1) - v70
            if math.abs(v71) > 0.05 then
                p58:UpdateTransparency(v70)
                p58._lastTrans = v70
            end
        end
        if p58.IsVisible then
            local v72 = math.sin(v63)
            p58.Angle = v72
            local v73 = v72 * 0.6 + 0.5
            local v74 = p58.Icon.Position.X.Scale - v73
            if math.abs(v74) > 0.001 then
                p58.Icon.Position = UDim2.new(v73, p58.Icon.Position.X.Offset, 0, 3)
            end
        end
    else
        return
    end
end
function u12.Destroy(p75) --[[ Line: 278 ]]
    if p75.Optimizer then
        p75.Optimizer:Disconnect()
        p75.Optimizer = nil
    end
    p75.Icon:Destroy()
    setmetatable(p75, nil)
end
return u12