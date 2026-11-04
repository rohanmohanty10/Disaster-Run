 

local v1 = game.Players.LocalPlayer
local v2 = v1.Character
game.ReplicatedStorage:FindFirstChild("Stats" .. v1.Name)
local u3 = {}
local v4 = script.tool.Value
local v5 = v4.Name
local v6 = v4:GetAttribute("damageName")
local v7 = v4:GetAttribute("modePercent") or 1
local v8 = false
local v9 = false
local function v30(p10, p11, p12) --[[ Line: 19 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    local v13 = math.floor(p11)
    local v14 = math.floor(p12)
    local v15 = (v13 < 0 and 0 or v13) / v14
    local v16 = p10.bar.Size.X.Scale
    if u3[p10.Name] == nil then
        u3[p10.Name] = 0
    end
    if u3[p10.Name] ~= v15 then
        local _ = v16 - v15
        local v17 = v15 >= 1 and 1 or v15
        u3[p10.Name] = v17
        local v18 = math.pow(10, 3 or 0)
        local v19 = v17 * v18
        local v20
        if v19 >= 0 then
            local v21 = v19 + 0.5
            v20 = math.floor(v21)
        else
            local v22 = v19 - 0.5
            v20 = math.ceil(v22)
        end
        local v23 = v20 / v18
        local v24 = p10.bar.Size.X.Scale
        local v25 = math.pow(10, 3 or 0)
        local v26 = v24 * v25
        local v27
        if v26 >= 0 then
            local v28 = v26 + 0.5
            v27 = math.floor(v28)
        else
            local v29 = v26 - 0.5
            v27 = math.ceil(v29)
        end
        if v23 ~= v27 / v25 then
            p10.bar:TweenSize(UDim2.new(v17, 0, 1, 0), "Out", "Quad", 0.25, true)
        end
    end
end
while script.Parent ~= nil do
    local v31
    if v2:GetAttribute(v6) then
        local v32 = v2:GetAttribute(v6)
        v31 = math.ceil(v32)
    else
        v31 = 0
    end
    local v33 = require(game.ReplicatedStorage.Modules.Skills.Modes:FindFirstChild(_G.modeBarModuleNames(v5)))(v1)
    if v33 <= v31 then
        script.Parent.TextLabel.Text = "MAXED"
    else
        local v34 = script.Parent.TextLabel
        local v35 = v31 / v33 * 100
        v34.Text = math.floor(v35) .. "%"
    end
    if v33 * v7 <= v31 and v8 == false then
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
        v8 = true
    elseif v31 < v33 * (v7 * 0.8) then
        v8 = false
    end
    if v33 * v7 <= v31 and v9 == false then
        v9 = true
    elseif v31 < v33 * v7 then
        v9 = false
    end
    v30(script.Parent, v31, v33)
    if v2:FindFirstChild(v5) == nil then
        script.Parent.Visible = false
        if v1.Backpack:FindFirstChild(v5) == nil then
            script.Parent.Parent:Destroy()
        end
    else
        script.Parent.Visible = true
    end
    task.wait()
end