 

local v1 = game.Players.LocalPlayer
local v2 = v1.Character
game.ReplicatedStorage:FindFirstChild("Stats" .. v1.Name)
local u3 = {}
local v4 = script.tool.Value
local v5 = v4.Name
local v6 = v4:GetAttribute("damageName")
local v7 = false
local v8 = false
local function v29(p9, p10, p11) --[[ Line: 19 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    local v12 = math.floor(p10)
    local v13 = math.floor(p11)
    local v14 = (v12 < 0 and 0 or v12) / v13
    local v15 = p9.bar.Size.X.Scale
    if u3[p9.Name] == nil then
        u3[p9.Name] = 0
    end
    if u3[p9.Name] ~= v14 then
        local _ = v15 - v14
        local v16 = v14 >= 1 and 1 or v14
        u3[p9.Name] = v16
        local v17 = math.pow(10, 3 or 0)
        local v18 = v16 * v17
        local v19
        if v18 >= 0 then
            local v20 = v18 + 0.5
            v19 = math.floor(v20)
        else
            local v21 = v18 - 0.5
            v19 = math.ceil(v21)
        end
        local v22 = v19 / v17
        local v23 = p9.bar.Size.X.Scale
        local v24 = math.pow(10, 3 or 0)
        local v25 = v23 * v24
        local v26
        if v25 >= 0 then
            local v27 = v25 + 0.5
            v26 = math.floor(v27)
        else
            local v28 = v25 - 0.5
            v26 = math.ceil(v28)
        end
        if v22 ~= v26 / v24 then
            p9.bar:TweenSize(UDim2.new(v16, 0, 1, 0), "Out", "Quad", 0.25, true)
        end
    end
end
while script.Parent ~= nil do
    local v30
    if v2:GetAttribute(v6) then
        local v31 = v2:GetAttribute(v6)
        v30 = math.ceil(v31)
    else
        v30 = 0
    end
    local v32 = require(game.ReplicatedStorage.Modules.Skills.Modes:FindFirstChild(_G.modeBarModuleNames(v5)))(v1)
    if v32 <= v30 then
        script.Parent.TextLabel.Text = "MAXED"
    else
        local v33 = script.Parent.TextLabel
        local v34 = v30 / v32 * 100
        v33.Text = math.floor(v34) .. "%"
    end
    if v32 <= v30 and v7 == false then
        script.enough:Play()
        local v35 = script.ColorCorrection:Clone()
        v35.Parent = workspace.CurrentCamera
        _G.tween(v35, {
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
        _G.destroy(v35, 2)
        v7 = true
    elseif v30 < v32 * 0.8 then
        v7 = false
    end
    if v32 <= v30 and v8 == false then
        v8 = true
    elseif v30 < v32 then
        v8 = false
    end
    v29(script.Parent, v30, v32)
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