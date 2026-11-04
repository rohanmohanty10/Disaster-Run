 

local v1 = {}
local u2 = game:GetService("TweenService")
local u3 = game:GetService("RunService")
local u4 = _G.customEmit
function v1.start(_, p5) --[[ Line: 13 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u4
        [3] = u3
    --]]
    local v6 = Random.new()
    local v7 = p5:GetPivot() * CFrame.new(0, 2.8, 0)
    local v8 = Instance.new("AlignPosition")
    local v9 = p5.PrimaryPart.RootRigAttachment
    v8.Mode = 0
    v8.Attachment0 = v9
    v8.Position = v7.Position
    v8.Parent = p5
    v8.MaxVelocity = 2500000
    v8.Responsiveness = 50
    local v10 = script.Sphere:Clone()
    v10.CFrame = v7
    local v11 = Instance.new("Highlight")
    v11.FillTransparency = 0
    v11.OutlineColor = Color3.fromRGB(125, 227, 255)
    v11.FillColor = Color3.fromRGB(255, 255, 255)
    v11.Parent = v10
    v10.Parent = workspace.Effects
    local v12 = v10.Size
    v10.Size = Vector3.new(0, 0, 0)
    local v13 = TweenInfo.new(0.25, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out, 0, true)
    u2:Create(v10.Light, v13, {
        ["Range"] = 15
    }):Play()
    u2:Create(v10, v13, {
        ["Size"] = v12
    }):Play()
    local v14 = script.Particles:Clone()
    local v15 = workspace.Effects
    v14.CFrame = v7
    v14.Parent = v15
    u4(v14)
    _G.PlaySound(p5.PrimaryPart, script.EnergyBallGrip)
    local u16 = v13.Time * 1.5
    for _ = 1, 10 do
        local v17 = v6:NextNumber(0.2, 0.45)
        local u18 = v7.Position + v6:NextUnitVector() * 16.5
        local u19 = v7.Position
        local u20 = (CFrame.new(u18, u19) * CFrame.new(v6:NextNumber(-16.5, 16.5), v6:NextNumber(-16.5, 16.5), -(u18 - u19).Magnitude / 2)).Position
        local u21 = script.Trail:Clone()
        u21.Position = u18
        u21.Parent = workspace.Effects
        local v22 = u21.a
        local v23 = -v17
        v22.Position = Vector3.new(0, 0, v23)
        u21.b.Position = Vector3.new(0, 0, v17)
        local u24 = 0
        local u25 = nil
        u25 = u3.Stepped:Connect(function(_, p26) --[[ Line: 73 ]]
            --[[
            Upvalues:
                [1] = u24
                [2] = u25
                [3] = u16
                [4] = u18
                [5] = u20
                [6] = u19
                [7] = u21
            --]]
            if u24 >= 1 then
                u25:Disconnect()
            else
                u24 = u24 + p26 / u16
                local v27 = u24
                local v28 = u18
                local v29 = u20
                local v30 = u19
                u21.Position = (1 - v27) ^ 2 * v28 + 2 * (1 - v27) * v27 * v29 + v27 ^ 2 * v30
            end
        end)
    end
    _G.destroy(v10, 1.5)
    _G.destroy(v14, 2)
    _G.destroy(v8, 0.5)
end
return v1