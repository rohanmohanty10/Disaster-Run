 

local v1 = {}
local u2 = _G.getEffect("Shockwave2")
local u3 = _G.getEffect("Beam")
function v1.start(_, p4) --[[ Line: 6 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u2
    --]]
    local v5 = p4.char
    local _ = p4.info
    if _G.checkRenderDistance(v5.HumanoidRootPart.CFrame.p) ~= false then
        local v6 = v5:GetChildren()
        local v7 = {}
        for v8 = 1, #v6 do
            if v6[v8]:IsA("BasePart") and (v6[v8].Name ~= "Head" and (v6[v8]:IsA("MeshPart") and v6[v8].Size.Magnitude > 1)) then
                local v9 = { v6[v8], v6[v8].CFrame }
                table.insert(v7, v9)
            end
        end
        for v10 = 1, #v7 do
            if v7[v10][1].Parent == v5 then
                local v11 = v7[v10][1]
                local v12 = v7[v10][2]
                local v13 = v11:Clone()
                v13:BreakJoints()
                v13:ClearAllChildren()
                v13.Anchored = false
                v13.Parent = workspace.Effects
                v13.Name = "TekkaiEffect"
                v13.CFrame = v12 * CFrame.new(0, v13.Size.Y / 2, 0)
                v13.Transparency = -0.5
                v13.CanCollide = false
                v13.Massless = true
                v13.Color = Color3.fromRGB(101, 147, 255)
                v13.Material = "Neon"
                local v14 = v13.Size.X * 1.1
                local v15 = v13.Size.Z * 1.1
                v13.Size = Vector3.new(v14, 0.05, v15)
                local v16 = script.teka:Clone()
                v16.Parent = v11
                v16:Emit(3)
                _G.destroy(v16, 2)
                _G.destroy(v13, 0.5)
                local v17 = Instance.new("Weld", v11)
                v17.Part0 = v11
                v17.Part1 = v13
                v17.C0 = CFrame.new(0, v11.Size.Y / 2, 0)
                local v18 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0)
                local v19 = {
                    ["Transparency"] = 1,
                    ["Color"] = BrickColor.new("Pastel light blue").Color
                }
                game:GetService("TweenService"):Create(v13, v18, v19):Play()
                local v20 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0)
                local v21 = {
                    ["C0"] = CFrame.new(0, -v11.Size.Y / 4, 0)
                }
                game:GetService("TweenService"):Create(v17, v20, v21):Play()
            end
        end
        local v22 = CFrame.new(v5.HumanoidRootPart.CFrame.p) * CFrame.new(0, -2, 0)
        u3:start(v22, 15, 0, 0.25, ColorSequence.new(BrickColor.new("Pastel light blue").Color, Color3.fromRGB(255, 255, 255)), 1, 15, 50, nil, NumberSequence.new(0.8, 1))
        u2:start(v22 * CFrame.new(0, 5, 0), v22, BrickColor.new("Institutional white"), Vector3.new(8, 0.1, 8), Vector3.new(2, 0.2, 2), 0.25, -1, Enum.EasingStyle.Quad, nil, Enum.Material.Neon, "Rings")
        u2:start(v22, v22 * CFrame.new(0, 4, 0), BrickColor.new("Institutional white"), Vector3.new(15, 0.4, 15), Vector3.new(2, 0.2, 2), 0.25, -1, Enum.EasingStyle.Quad, nil, Enum.Material.Neon, "g2")
        local v23 = script.tekkaip.Attachment.Shockwave:Clone()
        v23.Parent = v5.UpperTorso.WaistRigAttachment
        v23:Emit(1)
        local v24 = script.tekkaip.Attachment.teks:Clone()
        v24.Parent = v5.Head
        v24:Play()
        _G.destroy(v24, 5)
        _G.destroy(v23, 5)
    end
end
return v1