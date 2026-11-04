 

local u1 = {
    ["On"] = false,
    ["maxDistance"] = 100,
    ["kenTime"] = 0,
    ["kenColor"] = Color3.fromRGB(110, 153, 202)
}
local u2 = game.Players.LocalPlayer
local v3 = Instance.new("ScreenGui")
v3.Name = "KenHaki"
v3.Parent = game.Players.LocalPlayer.PlayerGui
v3.ResetOnSpawn = false
local u4 = {}
local u5 = {}
local u6 = { workspace.NPCs, workspace.PlayerCharacters, workspace.Ragdolls }
local u7 = nil
local u8 = nil
local u9 = tick()
local u10 = nil
function u1.Outline(_, p11, p12) --[[ Line: 23 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u2
    --]]
    local v13 = game.ReplicatedStorage:FindFirstChild("Stats" .. game.Players.LocalPlayer.Name)
    local v14 = game.Players.LocalPlayer.Character
    if u4[p11] then
        return
    elseif p11:IsA("Model") == false then
        return
    elseif p11 and (p11:IsA("Model") and (p11.PrimaryPart ~= nil and p12 < (p11.PrimaryPart.Position - v14.HumanoidRootPart.Position).magnitude)) then
        return
    elseif p11 == v14 then
        return
    elseif v14.PrimaryPart ~= nil and (not p11 or p11.PrimaryPart ~= nil) then
        local v15 = (v14.HumanoidRootPart.Position - p11.PrimaryPart.Position).magnitude / p12
        local v16 = Instance.new("Highlight")
        v16.FillColor = v13.Customization.KenColor.Value
        v16.FillTransparency = 0.5
        v16.OutlineTransparency = 0 + 0.2 * v15
        v16.Adornee = p11
        local v17 = false
        local v18
        if p11.Parent == workspace.NPCs then
            v18 = true
        else
            local v19 = game.Players:GetPlayerFromCharacter(p11)
            v18 = v19 and (v19:FindFirstChild("Party") and (v19.Party.Value ~= u2.Party.Value or v19.Party.Value == nil)) and true or v17
        end
        if v18 == true then
            v16.FillColor = Color3.fromRGB(255, 0, 0)
        else
            v16.FillColor = Color3.fromRGB(0, 255, 0)
        end
        v16.OutlineColor = v16.FillColor
        v16.Parent = p11
        u4[p11] = {
            ["highLight"] = v16
        }
        if v13.Skills.KenV2.Value == true then
            local v20 = game.Players:GetPlayerFromCharacter(p11)
            local v21 = script.Overhead:Clone()
            v21.Adornee = p11.PrimaryPart
            v21.Parent = game.Players.LocalPlayer.PlayerGui.HealthBars
            if v20 == nil then
                v21.tool:Destroy()
                v21.Stam:Destroy()
            end
            local v22 = p11:FindFirstChild("Humanoid")
            if v22 and v22:IsA("Humanoid") == true then
                u4[p11].gui = v21
            else
                v21:Destroy()
            end
            u4[p11].isPlayer = v20
        end
    end
end
function u1.Enable(_) --[[ Line: 87 ]]
    --[[
    Upvalues:
        [1] = u10
        [2] = u1
        [3] = u9
        [4] = u5
        [5] = u2
        [6] = u8
        [7] = u7
    --]]
    u10 = game.Players.LocalPlayer.Character
    game.ReplicatedStorage.Events.Haki:FireServer("Ken", true)
    if u10:WaitForChild("KenHaki", 2) ~= nil then
        u1.On = true
        local v23 = game.ReplicatedStorage:FindFirstChild("Stats" .. game.Players.LocalPlayer.Name)
        u9 = 0
        if u5.color then
            u5.color:Destroy()
        end
        if u5.blur then
            u5.blur:Destroy()
        end
        _G.tween(workspace.CurrentCamera, {
            0.25,
            "Sine",
            Enum.EasingDirection.Out,
            0,
            true,
            0
        }, {
            ["FieldOfView"] = 90
        })
        local v24 = script.KenHaki:Clone()
        v24.Contrast = 0
        v24.TintColor = Color3.fromRGB(255, 255, 255)
        v24.Parent = workspace.CurrentCamera
        local v25, _, v26 = v23.Customization.KenColor.Value:ToHSV()
        _G.tween(v24, {
            0.25,
            "Smooth",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Contrast"] = script.KenHaki.Contrast,
            ["TintColor"] = Color3.fromHSV(v25, 0.325, v26)
        })
        u5.color = v24
        local v27 = script.DepthOfField:Clone()
        v27.FarIntensity = 0
        v27.FocusDistance = 100
        v27.InFocusRadius = 0
        v27.Parent = workspace.CurrentCamera
        _G.tween(v27, {
            0.25,
            "Smooth",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["FarIntensity"] = 0.5,
            ["FocusDistance"] = 25,
            ["InFocusRadius"] = 5
        })
        u5.blur = v27
        local v28 = script.kengui:Clone()
        v28.Parent = u2.PlayerGui
        v28.ImageLabel.ImageColor3 = v23.Customization.KenColor.Value
        v28.TextLabel.UIGradient.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255), v23.Customization.KenColor.Value)
        _G.tween(v28.ImageLabel, {
            0.25,
            "Quad",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Size"] = UDim2.new(1.25, 0, 1.25, 0)
        })
        _G.tween(v28.ImageLabel, {
            0.25,
            "Quad",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["ImageTransparency"] = 1
        })
        _G.tween(v28.TextLabel.UIGradient, {
            0.5,
            "Sine",
            Enum.EasingDirection.Out,
            -1,
            true,
            0.25
        }, {
            ["Offset"] = Vector2.new(1, 0)
        })
        if u8 then
            u8:Destroy()
        end
        u8 = v28
        if string.find(v23.Stats.DF.Value, "Mochi") == nil or (v23.Stats.KenMastery.Value < 700 or _G.isFruitSupressed(u2) ~= false) then
            if v23.Skills.KenV2.Value == true then
                script.V2LOOP:Play()
            else
                script.KenSFX:Play()
            end
        else
            script.futureSightLoop:Play()
        end
        u7 = _G.music
        _G.music = false
    end
end
function u1.Disable(_) --[[ Line: 149 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u4
        [3] = u5
        [4] = u7
        [5] = u8
    --]]
    u1.On = false
    for v29, _ in u4 do
        u1:removehighLight(v29)
    end
    table.clear(u4)
    pcall(function() --[[ Line: 156 ]]
        --[[
        Upvalues:
            [1] = u5
        --]]
        _G.tween(u5.blur, {
            0.25,
            "Smooth",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["FarIntensity"] = 0
        })
        _G.tween(u5.color, {
            0.25,
            "Smooth",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Contrast"] = 0,
            ["TintColor"] = Color3.fromRGB(255, 255, 255)
        })
        _G.destroy(u5.blur, 0.25)
        _G.destroy(u5.color, 0.25)
    end)
    script.KenSFX:Stop()
    script.futureSightLoop:Stop()
    script.V2LOOP:Stop()
    _G.music = u7
    u1.kenTime = 0
    game.ReplicatedStorage.Events.Haki:FireServer("Ken", false)
    if u8 then
        u8:Destroy()
        u8 = nil
    end
end
function u1.removehighLight(_, p30, p31) --[[ Line: 175 ]]
    --[[
    Upvalues:
        [1] = u4
    --]]
    if u4[p30] then
        if p31 == nil then
            _G.tween(u4[p30].highLight, {
                0.25,
                "Smooth",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["OutlineTransparency"] = 1,
                ["FillTransparency"] = 1
            })
            _G.destroy(u4[p30].highLight, 0.25)
            u4[p30].highLight = nil
        else
            u4[p30].highLight:Destroy()
        end
    end
    if u4[p30].gui ~= nil then
        u4[p30].gui:Destroy()
    end
    if u4[p30].blockGUI ~= nil then
        u4[p30].blockGUI:Destroy()
    end
    u4[p30] = nil
end
local function u36(p32) --[[ Line: 195 ]]
    local v33 = p32:GetChildren()
    local v34 = false
    for v35 = 1, #v33 do
        if v33[v35].Name:match("Buso") and v33[v35]:IsA("NumberValue") then
            v34 = true
        end
    end
    return v34
end
local u37 = game.ReplicatedStorage:FindFirstChild("Stats" .. u2.Name)
game["Run Service"].Heartbeat:Connect(function(p38) --[[ Line: 208 ]]
    --[[
    Upvalues:
        [1] = u10
        [2] = u1
        [3] = u37
        [4] = u4
        [5] = u36
        [6] = u9
        [7] = u6
        [8] = u8
    --]]
    local v39 = game.Players.LocalPlayer.Character
    if u10 and u10 ~= v39 then
        u1:Disable()
    elseif u1.On == true then
        local v40 = 100 + u37.Stats.KenMastery.Value / 3
        local v41 = math.clamp(v40, 0, 2000)
        for v42, _ in u4 do
            local v43 = v42.PrimaryPart
            local v44 = v42:FindFirstChildWhichIsA("Humanoid")
            if v42 and (v42.Parent ~= nil and (v43 and v41 <= (v43.Position - v39.HumanoidRootPart.Position).magnitude)) or (v43 == nil or v44 ~= nil and (v42.Parent ~= workspace.PlayerCharacters and (v42.Parent ~= workspace.Ragdolls and v42.Parent ~= workspace.NPCs)) or v42:IsDescendantOf(workspace) == false) then
                u1:removehighLight(v42, true)
            elseif v42 then
                local v45 = (v39.HumanoidRootPart.Position - v42.PrimaryPart.Position).magnitude / v41
                u4[v42].highLight.FillTransparency = 0.5 + 0.5 * v45
                u4[v42].highLight.OutlineTransparency = 0 + 1 * v45
                if u4[v42].gui ~= nil then
                    local v46 = u4[v42].gui
                    if u4[v42].isPlayer ~= nil then
                        local v47 = game.ReplicatedStorage:FindFirstChild("Stats" .. v42.Name)
                        if v47 then
                            local v48 = v47.Stamina.Value / v47.Stamina.MaxValue
                            v46.Health.Frame.BackgroundColor3 = BrickColor.new("White").Color:Lerp(Color3.fromRGB(66, 163, 218), v48)
                            v46.Stam.Frame.Size = UDim2.new(v48, 0, 1, 0)
                        end
                        local v49 = v42:FindFirstChildWhichIsA("Tool")
                        if v49 then
                            if v49.TextureId == "" then
                                v46.tool.ImageLabel.Image = ""
                                v46.tool.ImageLabel.TextLabel.Text = v49.Name
                            else
                                v46.tool.ImageLabel.Image = v49.TextureId
                                v46.tool.ImageLabel.TextLabel.Text = ""
                            end
                            v46.tool.Visible = true
                        else
                            v46.tool.Visible = false
                        end
                    end
                    local v50 = v42:findFirstChild("Blocking")
                    if v50 and (u4[v42].blockGUI == nil and v50.Value > 0) then
                        local v51 = game.ReplicatedStorage.Util.Melee.BlockGui:Clone()
                        v51.MaxDistance = 1000
                        v51.Parent = v42.HumanoidRootPart
                        v51.Size = UDim2.new(3, 0, 3, 0)
                        if u36(v42) == true then
                            v51.ImageLabel.Frame.ImageLabel.ImageColor3 = Color3.fromRGB(85, 85, 255)
                        end
                        u4[v42].blockGUI = v51
                    elseif v50 and (u4[v42].blockGUI ~= nil and v50.Value > 0) then
                        local v52 = u4[v42].blockGUI
                        local v53 = v50.Value / v50.MaxValue
                        v52.ImageLabel.Frame.Size = UDim2.new(1, 0, v53, 0)
                        v52.ImageLabel.Frame.Position = UDim2.new(0, 0, 1 - v53, 0)
                        v52.ImageLabel.Frame.ImageLabel.Size = UDim2.new(1, 0, 1 / v53, 0)
                        v52.ImageLabel.Frame.ImageLabel.Position = UDim2.new(0, 0, -(v52.ImageLabel.Frame.Position.Y.Scale / v52.ImageLabel.Frame.Size.Y.Scale), 0)
                    elseif u4[v42].blockGUI ~= nil and (v50 == nil or v50 and v50.Value <= 0) and u4[v42].blockGUI then
                        u4[v42].blockGUI:Destroy()
                        u4[v42].blockGUI = nil
                    end
                    if v44 then
                        local v54 = v44.Health / v44.MaxHealth
                        v46.Health.Frame.BackgroundColor3 = BrickColor.new("Bright red").Color:Lerp(Color3.fromRGB(170, 255, 127), v54)
                        v46.Health.Frame.Size = UDim2.new(v54, 0, 1, 0)
                    end
                end
            end
        end
        if tick() - u9 >= 0.3 then
            for v55 = 1, #u6 do
                local v56 = u6[v55]:GetChildren()
                for v57 = 1, #v56 do
                    if u4[v56[v57]] == nil then
                        u1:Outline(v56[v57], v41)
                    end
                end
            end
            local v58 = workspace:GetChildren()
            for v59 = 1, #v58 do
                if v58[v59]:IsA("Tool") and v58[v59]:FindFirstChild("FruitEater") then
                    u1:Outline(v58[v59].FruitModel, v41)
                end
            end
            local v60 = workspace.Env.Settings:GetDescendants()
            for v61 = 1, #v60 do
                if v60[v61]:IsA("Model") and v60[v61]:GetAttribute("fruitModel") == true then
                    u1:Outline(v60[v61], v41)
                end
            end
            u9 = tick()
        end
        u1.kenTime = u1.kenTime + p38
        if u8 and v39:FindFirstChild("KenHaki") then
            if u8:FindFirstChild("TextLabel") then
                u8.TextLabel.Text = u37.KenBar.Value .. " Dodges left"
            end
            if v39:FindFirstChild("KenHaki").Value <= 0 then
                u1:Disable()
                return
            end
        elseif u1.On == true and v39:FindFirstChild("KenHaki") == nil then
            u1:Disable()
            return
        end
    elseif script.V2LOOP.IsPlaying == true or (script.KenSFX.IsPlaying == true or script.futureSightLoop.IsPlaying == true) then
        script.KenSFX:Stop()
        script.futureSightLoop:Stop()
        script.V2LOOP:Stop()
    end
end)
return u1