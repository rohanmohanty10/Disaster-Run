 

local v1 = game.Players.LocalPlayer
local v2 = v1.Character
game.ReplicatedStorage:FindFirstChild("Stats" .. v1.Name)
local u3 = {}
local function v24(p4, p5, p6) --[[ Line: 19 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    local v7 = math.floor(p5)
    local v8 = math.floor(p6)
    local v9 = (v7 < 0 and 0 or v7) / v8
    local v10 = p4.bar.Size.X.Scale
    if u3[p4.Name] == nil then
        u3[p4.Name] = 0
    end
    if u3[p4.Name] ~= v9 then
        local _ = v10 - v9
        local v11 = v9 >= 1 and 1 or v9
        u3[p4.Name] = v11
        local v12 = math.pow(10, 3 or 0)
        local v13 = v11 * v12
        local v14
        if v13 >= 0 then
            local v15 = v13 + 0.5
            v14 = math.floor(v15)
        else
            local v16 = v13 - 0.5
            v14 = math.ceil(v16)
        end
        local v17 = v14 / v12
        local v18 = p4.bar.Size.X.Scale
        local v19 = math.pow(10, 3 or 0)
        local v20 = v18 * v19
        local v21
        if v20 >= 0 then
            local v22 = v20 + 0.5
            v21 = math.floor(v22)
        else
            local v23 = v20 - 0.5
            v21 = math.ceil(v23)
        end
        if v17 ~= v21 / v19 then
            p4.bar:TweenSize(UDim2.new(v11, 0, 1, 0), "Out", "Quad", 0.25, true)
        end
    end
end
local u25 = 0
function _G.venomDemonMode(p26) --[[ Line: 61 ]]
    --[[
    Upvalues:
        [1] = u25
    --]]
    local v27 = script.Parent
    local v28 = v27.bar:Clone()
    v28.Name = "a"
    v28.Parent = v27.bar.Parent
    v28.ZIndex = 2
    v28.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    local v29 = 1 - p26 / u25
    v28.Size = UDim2.new(1 - v29, 0, 1, 0)
    v28.Position = UDim2.new(0, 0, 0, 0)
    v28:ClearAllChildren()
    local v30 = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In, 0, false, 0)
    game:GetService("TweenService"):Create(v28, v30, {
        ["BackgroundTransparency"] = 1
    }):Play()
    script.enough:Play()
end
local v31 = false
local v32 = false
while script.Parent ~= nil do
    local v33
    if v2:GetAttribute("buddhaDamage") then
        local v34 = v2:GetAttribute("buddhaDamage")
        v33 = math.ceil(v34)
    else
        v33 = 0
    end
    u25 = require(game.ReplicatedStorage.Modules.Skills.Modes.Buddha)(v1)
    local v35 = v2:GetAttribute("BeastType") == "Full"
    if u25 <= v33 then
        script.Parent.TextLabel.Text = "MAXED"
    else
        script.Parent.TextLabel.Text = v33 .. "/" .. u25
    end
    if u25 <= v33 and v31 == false then
        script.enough:Play()
        local v36 = script.ColorCorrection:Clone()
        v36.Parent = workspace.CurrentCamera
        _G.tween(v36, {
            2,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["TintColor"] = Color3.fromRGB(255, 255, 255),
            ["Contrast"] = 0
        })
        _G.destroy(v36, 2)
        v31 = true
    elseif v33 < 150 then
        v31 = false
    end
    if u25 <= v33 and (v32 == false and v35 == false) then
        script.enough:Play()
        v32 = true
    elseif v33 < u25 then
        v32 = false
    end
    v24(script.Parent, v33, u25)
    if v2:FindFirstChild("Buddha-Buddha") == nil then
        script.Parent.Visible = false
        if v1.Backpack:FindFirstChild("Buddha-Buddha") == nil then
            script.Parent.Parent:Destroy()
        end
    else
        script.Parent.Visible = true
    end
    local v37 = v1.PlayerGui:FindFirstChild("Keys")
    if v37 then
        local _ = script.Parent.Parent.AbsoluteSize
        script.Parent.Parent.Position = UDim2.new(0, v37.Frame.nameFrame.TextLabel.AbsolutePosition.X, -0.05, v37.Frame.nameFrame.TextLabel.AbsolutePosition.Y)
    end
    task.wait()
end