 

local v1 = game.Players.LocalPlayer
local v2 = v1.Character
local v3 = game.ReplicatedStorage:FindFirstChild("Stats" .. v1.Name)
local u4 = {}
local function v28(p5, p6, p7) --[[ Line: 19 ]]
    --[[
    Upvalues:
        [1] = u4
    --]]
    local v8 = math.floor(p6)
    local v9 = math.floor(p7)
    local v10 = (v8 < 0 and 0 or v8) / v9
    local v11 = p5.bar.Size.X.Scale
    if u4[p5.Name] == nil then
        u4[p5.Name] = 0
    end
    if u4[p5.Name] ~= v10 then
        local v12 = v11 - v10
        local v13 = v10 >= 1 and 1 or v10
        u4[p5.Name] = v13
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
        local v20 = p5.bar.Size.X.Scale
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
            p5.bar:TweenSize(UDim2.new(v13, 0, 1, 0), "Out", "Quad", 0.25, true)
        end
        if v12 > 0 then
            if p5.bar.Parent:FindFirstChild("a") then
                p5.bar.Parent.a:Destroy()
            end
            local v26 = p5.bar:Clone()
            v26.Name = "a"
            v26.ZIndex = 2
            v26.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            v26.Size = UDim2.new(v12, 0, 1, 0)
            v26.Position = UDim2.new(v13, 0, 0, 0)
            v26:ClearAllChildren()
            v26.Parent = p5.bar.Parent
            local v27 = v12 + 0.25
            _G.tween(v26, {
                v27,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.In,
                0,
                false,
                0
            }, {
                ["BackgroundTransparency"] = 1,
                ["Size"] = UDim2.new(0, 0, 1, 0)
            })
            _G.destroy(v26, v27)
        end
    end
end
local u29 = 0
function _G.rocketDMGRed(p30) --[[ Line: 60 ]]
    --[[
    Upvalues:
        [1] = u29
    --]]
    local v31 = script.Parent
    local v32 = v31.bar:Clone()
    v32.Name = "a"
    v32.Parent = v31.bar.Parent
    v32.ZIndex = 2
    v32.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    local v33 = 1 - p30 / u29
    v32.Size = UDim2.new(1 - v33, 0, 1, 0)
    v32.Position = UDim2.new(0, 0, 0, 0)
    v32:ClearAllChildren()
    local v34 = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In, 0, false, 0)
    game:GetService("TweenService"):Create(v32, v34, {
        ["BackgroundTransparency"] = 1
    }):Play()
    script.RocketBladeNotFull:Play()
end
local v35 = false
local v36 = false
while true do
    local v37
    if v2:GetAttribute("rocketBladeDamage") then
        local v38 = v2:GetAttribute("rocketBladeDamage")
        v37 = math.ceil(v38)
    else
        v37 = 0
    end
    local v39 = 150 + v3.Stats.Defense.Value * 0.75 + v3.Stats.GunMastery.Value * 1.25
    u29 = math.ceil(v39)
    if u29 <= v37 then
        script.Parent.TextLabel.Text = "MAXED"
    else
        script.Parent.TextLabel.Text = v37 .. "/" .. u29
    end
    if v37 >= 150 and v35 == false then
        script.enough:Play()
        local v40 = script.ColorCorrection:Clone()
        v40.Parent = workspace.CurrentCamera
        _G.tween(v40, {
            1,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["TintColor"] = Color3.fromRGB(255, 255, 255),
            ["Contrast"] = 0
        })
        _G.destroy(v40, 1)
        v35 = true
    elseif v37 < 150 then
        v35 = false
    end
    if u29 <= v37 and v36 == false then
        script.maxcharged:Play()
        v36 = true
    elseif v37 < u29 then
        v36 = false
    end
    v28(script.Parent, v37, u29)
    if v2:FindFirstChild("Inferno Rocket Blade") == nil then
        script.Parent.Visible = false
        if v1.Backpack:FindFirstChild("Inferno Rocket Blade") == nil then
            script.Parent.Parent:Destroy()
        end
    else
        script.Parent.Visible = true
    end
    task.wait()
end