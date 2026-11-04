 

if script.Parent:IsDescendantOf(workspace) ~= false then
    local u1 = script.Parent
    local v2 = u1:WaitForChild("Character", 1)
    local u3 = v2 ~= nil
    local u4 = u1:WaitForChild("Gold.013")
    local v5 = game:GetService("RunService")
    local v6 = script.Parent:GetDescendants()
    local u7 = {}
    local u8 = 0
    local u9 = nil
    for v10 = 1, #v6 do
        if v6[v10].Name == "Dark_Gold.002" then
            u9 = v6[v10]
        end
        if v6[v10]:IsA("BasePart") and v6[v10].Material == Enum.Material.Neon or v6[v10]:IsA("ParticleEmitter") and v6[v10]:GetAttribute("recolorable") then
            local v11 = v6[v10]
            table.insert(u7, v11)
        end
    end
    if u3 == true then
        for v12 = 1, #u7 do
            if u7[v12]:IsA("BasePart") then
                u7[v12].Parent = workspace.Effects
            end
        end
        u4:GetPropertyChangedSignal("Transparency"):Connect(function() --[[ Line: 29 ]]
            --[[
            Upvalues:
                [1] = u7
                [2] = u4
            --]]
            for v13 = 1, #u7 do
                if u7[v13]:IsA("BasePart") then
                    u7[v13].Transparency = u4.Transparency
                end
            end
        end)
        u1.Destroying:Connect(function() --[[ Line: 36 ]]
            --[[
            Upvalues:
                [1] = u7
            --]]
            for u14 = 1, #u7 do
                pcall(function() --[[ Line: 38 ]]
                    --[[
                    Upvalues:
                        [1] = u7
                        [2] = u14
                    --]]
                    u7[u14]:Destroy()
                end)
            end
        end)
    end
    local u15
    if v2 == nil or v2.Value == nil then
        u15 = nil
    else
        u15 = game.ReplicatedStorage:WaitForChild("Stats" .. v2.Value.Name, 600)
        if not u15 then
            return
        end
        u15:WaitForChild("Customization"):WaitForChild("ASEChromaColor")
    end
    local u16 = 0
    v5.Heartbeat:Connect(function(p17) --[[ Line: 53 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u3
            [3] = u8
            [4] = u15
            [5] = u7
            [6] = u16
            [7] = u4
            [8] = u9
        --]]
        if u1:IsDescendantOf(workspace) == false then
            script:Destroy()
        else
            if u3 == true then
                if u1.PrimaryPart == nil then
                    return
                end
                if (workspace.CurrentCamera.CFrame.Position - u1.PrimaryPart.Position).Magnitude >= 100 then
                    return
                end
            end
            u8 = (u8 + p17 * 0.05) % 1
            local v18 = Color3.fromHSV(u8, 1, 1)
            if u15 and u15.Settings.CustomASEChroma.Value == true then
                v18 = u15.Customization.ASEChromaColor.Value
            end
            for _, v19 in ipairs(u7) do
                if v19:IsA("BasePart") then
                    v19.Color = v18
                elseif v19:IsA("ParticleEmitter") then
                    v19.Color = ColorSequence.new(v18)
                end
            end
            if tick() - u16 >= Random.new():NextNumber(0.2, 0.4) and (_G.PlayEffect ~= nil and u4.Transparency ~= 1) then
                _G.PlayEffect("ASEGlitch", nil, u9, v18)
                u16 = tick()
            end
        end
    end)
end