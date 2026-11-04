 

local v1 = game.Players.LocalPlayer
local v2 = v1.Character
game.ReplicatedStorage:FindFirstChild("Stats" .. v1.Name)
local u3 = {}
local v4 = false
local v5 = false
local function v26(p6, p7, p8) --[[ Line: 19 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    local v9 = math.floor(p7)
    local v10 = math.floor(p8)
    local v11 = (v9 < 0 and 0 or v9) / v10
    local v12 = p6.bar.Size.X.Scale
    if u3[p6.Name] == nil then
        u3[p6.Name] = 0
    end
    if u3[p6.Name] ~= v11 then
        local _ = v12 - v11
        local v13 = v11 >= 1 and 1 or v11
        u3[p6.Name] = v13
        local v14 = math.pow(10, 3 or 0)
        local v15 = v13 * v14
        local v16
        if v15 >= 0 then
            local v17 = v15 + 0.5
            v16 = math.floor(v17)
        else
            local v18 = v15 - 0.5
            v16 = math.ceil(v18)
        end
        local v19 = v16 / v14
        local v20 = p6.bar.Size.X.Scale
        local v21 = math.pow(10, 3 or 0)
        local v22 = v20 * v21
        local v23
        if v22 >= 0 then
            local v24 = v22 + 0.5
            v23 = math.floor(v24)
        else
            local v25 = v22 - 0.5
            v23 = math.ceil(v25)
        end
        if v19 ~= v23 / v21 then
            p6.bar:TweenSize(UDim2.new(v13, 0, 1, 0), "Out", "Quad", 0.25, true)
        end
    end
end
while script.Parent do
    local v27
    if v2:GetAttribute("gomuDamage") then
        local v28 = v2:GetAttribute("gomuDamage")
        v27 = math.ceil(v28)
    else
        v27 = 0
    end
    local v29 = require(game.ReplicatedStorage.Modules.Skills.Modes["Gomu-Gomu"])(v1)
    if v29 <= v27 then
        script.Parent.TextLabel.Text = "MAXED"
    else
        script.Parent.TextLabel.Text = v27 .. "/" .. v29
    end
    if v29 <= v27 and v4 == false then
        script.enough:Play()
        local v30 = script.ColorCorrection:Clone()
        v30.Parent = workspace.CurrentCamera
        _G.tween(v30, {
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
        _G.destroy(v30, 2)
        v4 = true
    elseif v27 < 150 then
        v4 = false
    end
    if v29 / 4 <= v27 and v5 == false then
        script.enough:Play()
        v5 = true
    elseif v27 < v29 / 4 then
        v5 = false
    end
    v26(script.Parent, v27, v29)
    if v2:FindFirstChild("Gomu-Gomu") == nil then
        script.Parent.Visible = false
        if v1.Backpack:FindFirstChild("Gomu-Gomu") == nil then
            script.Parent.Parent:Destroy()
        end
    else
        script.Parent.Visible = true
    end
    task.wait()
end