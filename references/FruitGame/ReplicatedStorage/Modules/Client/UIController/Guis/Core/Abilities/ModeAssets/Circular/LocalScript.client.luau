 

local v1 = game.Players.LocalPlayer
local v2 = v1.Character
game.ReplicatedStorage:FindFirstChild("Stats" .. v1.Name)
local v3 = script.Parent:WaitForChild("Progress")
local v4 = v3:WaitForChild("Left")
local v5 = v3:WaitForChild("Right")
local u6 = v4:WaitForChild("Bar"):WaitForChild("UIGradient")
local u7 = v5:WaitForChild("Bar"):WaitForChild("UIGradient")
u6.Color = script.UIGradient.Color
u7.Color = script.UIGradient.Color
game:GetService("TweenService")
TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
local v8 = script.tool.Value
local v9 = v8.Name
local v10 = v8:GetAttribute("damageName")
local v11 = v8:GetAttribute("modePercent") or 1
local v12 = v1.PlayerGui:WaitForChild("TouchGui")
local v13 = false
local v14 = false
local function v23(p15, p16) --[[ Line: 19 ]]
    --[[
    Upvalues:
        [1] = u6
        [2] = u7
    --]]
    local v17 = math.floor(p15)
    local v18 = math.floor(p16)
    local v19 = (v17 < 0 and 0 or v17) / v18
    local v20 = v19 * 100 * 3.6
    math.clamp(v20, 0, 360)
    local v21 = v19 * 360
    local v22 = math.clamp(v21, 0, 360)
    u6.Rotation = math.clamp(v22, 180, 360)
    u7.Rotation = math.clamp(v22, 0, 180)
    u6.Offset = Vector2.new(0.01, 0)
    u7.Offset = Vector2.new(-0.01, 0)
end
while script.Parent ~= nil do
    local v24
    if v2:GetAttribute(v10) then
        local v25 = v2:GetAttribute(v10)
        v24 = math.ceil(v25)
    else
        v24 = 0
    end
    local v26 = require(game.ReplicatedStorage.Modules.Skills.Modes:FindFirstChild(_G.modeBarModuleNames(v9)))(v1)
    if v26 * v11 <= v24 and v13 == false then
        script.enough:Play()
        local v27 = script.ColorCorrection:Clone()
        v27.Parent = workspace.CurrentCamera
        _G.tween(v27, {
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
        _G.destroy(v27, 2)
        v13 = true
    elseif v24 < v26 * (v11 * 0.8) then
        v13 = false
    end
    if v26 * v11 <= v24 and v14 == false then
        v14 = true
    elseif v24 < v26 * v11 then
        v14 = false
    end
    v23(v24, v26)
    if v2:FindFirstChild(v9) == nil then
        if script.Parent ~= nil then
            script.Parent.Enabled = false
        end
        if v1.Backpack:FindFirstChild(v9) == nil then
            script.Parent:Destroy()
        end
    elseif v12.Enabled == true then
        if script.Parent ~= nil then
            script.Parent.Enabled = true
        end
        script.Parent.Enabled = true
    end
    if v12.Enabled == false and script.Parent ~= nil then
        script.Parent.Enabled = false
    end
    task.wait()
end