 

local v1 = require(script.Parent.Default)
local _ = workspace.CurrentCamera
local u2 = game.ReplicatedStorage.CompassGuider
local u3 = game:GetService("TweenService")
local u4, _, _, _, u5 = require(game.ReplicatedStorage.Modules.ScriptSet).get()
local u12 = {
    ["TextLabel"] = function(p6, p7) --[[ Line: 16 ]]
        local v8
        if p6:IsA("GuiObject") then
            v8 = p6:GetAttribute("canFade") and true or false
        else
            v8 = false
        end
        if v8 then
            p6.TextTransparency = p7
        end
    end,
    ["ImageLabel"] = function(p9, p10) --[[ Line: 21 ]]
        local v11
        if p9:IsA("GuiObject") then
            v11 = p9:GetAttribute("canFade") and true or false
        else
            v11 = false
        end
        if v11 then
            p9.ImageTransparency = p10
        end
    end
}
local u45 = {
    ["__index"] = v1,
    ["new"] = function(p13) --[[ Name: new, Line 30 ]]
        --[[
        Upvalues:
            [1] = u45
            [2] = u3
            [3] = u12
            [4] = u5
            [5] = u4
            [6] = u2
        --]]
        local v14 = u45
        local u15 = setmetatable({}, v14)
        local v16 = script.Icon:Clone()
        v16.Name = p13.Guider.Name
        v16.Info.Title.Text = p13.Guider.Name
        v16.Flag.Image = p13.Guider:GetAttribute("ImageIcon") or ""
        v16:SetAttribute("CanVisible", true)
        v16.Parent = p13.Parent
        u15.Angle = 6.283185307179586
        u15.Guider = p13.Guider
        u15.Icon = v16
        u15.DefaultTransparency = p13.DefaultTransparency or 0
        u15.InView = false
        u15.Handler = p13.Handler
        local u17 = u15.Icon.Info.Position
        u15.InViewTweens = {
            [true] = function() --[[ Line: 51 ]]
                --[[
                Upvalues:
                    [1] = u15
                    [2] = u3
                    [3] = u17
                --]]
                if u15.Icon.Visible ~= false then
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
                end
            end,
            [false] = function() --[[ Line: 75 ]]
                --[[
                Upvalues:
                    [1] = u15
                    [2] = u3
                    [3] = u17
                --]]
                if u15.Icon.Visible ~= false then
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
            end
        }
        u15.CachedUI = {}
        if u12[u15.Icon.ClassName] then
            local v21 = u15.CachedUI
            local v22 = u15.Icon
            table.insert(v21, v22)
        end
        for _, v23 in u15.Icon:GetDescendants() do
            if u12[v23.ClassName] then
                local v24 = u15.CachedUI
                table.insert(v24, v23)
            end
        end
        local function v26() --[[ Line: 117 ]]
            --[[
            Upvalues:
                [1] = u15
                [2] = u5
            --]]
            local v25 = u15.Guider:GetAttribute("Captured")
            u15.Icon.Info.Captured.Text = v25 == "" and "None" or "CAPTURED BY: " .. v25
            if v25 == "" or v25 == u5.Stats.Crew.Value then
                if v25 == "" then
                    u15.Icon.Flag.ImageColor3 = Color3.fromRGB(255, 255, 255)
                    u15.Icon.Info.InfamyAccumulated.Visible = false
                else
                    u15.Icon.Flag.ImageColor3 = Color3.fromRGB(0, 255, 0)
                    u15.Icon.Info.InfamyAccumulated.Visible = true
                end
            else
                u15.Icon.Flag.ImageColor3 = Color3.fromRGB(255, 0, 0)
                u15.Icon.Info.InfamyAccumulated.Visible = false
                return
            end
        end
        local v27 = game.ReplicatedStorage:WaitForChild("Stats" .. u4.Name)
        local u28 = v27.Stats.Crew
        local u29 = v27.Settings.ShowCapturePoints
        local function v34() --[[ Line: 137 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u15
                [3] = u28
            --]]
            local v30 = u2:GetAttribute("CapturePointEnabled")
            local v31 = u15.Guider
            local v32 = "isEnabled"
            local v33
            if v30 then
                v33 = u28.Value ~= ""
            else
                v33 = v30
            end
            v31:SetAttribute(v32, v33)
            if not v30 then
                u15.Icon.Info.InfamyAccumulated.Visible = false
            end
        end
        local function v36(p35) --[[ Line: 147 ]]
            --[[
            Upvalues:
                [1] = u15
            --]]
            u15.Guider:SetAttribute("isEnabled", p35 ~= "")
        end
        local function v37() --[[ Line: 151 ]]
            --[[
            Upvalues:
                [1] = u15
                [2] = u29
            --]]
            if u15.Guider:GetAttribute("Captured") == nil then
                return
            elseif u29.Value == true then
                u15.Icon:SetAttribute("CanVisible", true)
            else
                u15.Icon:SetAttribute("CanVisible", u15.Guider:GetAttribute("CustomIcon") ~= nil)
            end
        end
        u15.Guider:GetAttributeChangedSignal("Captured"):Connect(v26)
        u15.Guider:GetAttributeChangedSignal("InfamyAccumulated"):Connect(function() --[[ Name: updateInfamyGained, Line 112 ]]
            --[[
            Upvalues:
                [1] = u15
            --]]
            local v38 = u15.Guider:GetAttribute("InfamyAccumulated")
            u15.Icon.Info.InfamyAccumulated.Text = v38 .. " INFAMY EARNED"
        end)
        u2:GetAttributeChangedSignal("CapturePointEnabled"):Connect(v34)
        v26()
        local v39 = u15.Guider:GetAttribute("InfamyAccumulated")
        u15.Icon.Info.InfamyAccumulated.Text = v39 .. " INFAMY EARNED"
        local v40 = u2:GetAttribute("CapturePointEnabled")
        local v41 = u15.Guider
        local v42 = "isEnabled"
        local v43
        if v40 then
            v43 = u28.Value ~= ""
        else
            v43 = v40
        end
        v41:SetAttribute(v42, v43)
        if not v40 then
            u15.Icon.Info.InfamyAccumulated.Visible = false
        end
        u28.Changed:Connect(v36)
        local v44 = u28.Value
        u15.Guider:SetAttribute("isEnabled", v44 ~= "")
        u29.Changed:Connect(v37)
        v37()
        u15.InViewTweens[false]()
        return u15
    end
}
return u45