 

local u1 = game:GetService("RunService")
Emit = _G.Emit
TweenCreate = _G.Ess.Tween
local function u10(p2, p3, p4, p5) --[[ Line: 6 ]]
    --[[
    Upvalues:
        [1] = u10
    --]]
    local v6 = p5 and 1 or 0
    for _, v8 in p3 do
        if typeof(v8) ~= string then
            local v8 = tostring(v8)
        end
        local v9 = p2:FindFirstChild(v8)
        if v9 and (v9:IsA("BasePart") and not table.find(p4, v9.Name)) then
            v9.Transparency = v6
            u10(v9, v9:GetChildren(), {}, p5)
        end
    end
end
local function u15(p11, p12) --[[ Line: 22 ]]
    for _, v13 in p11 do
        local v14
        if p12 then
            v14 = v13.TextureSpeed * p12
        else
            v14 = v13:GetAttribute("NormalSpeed")
        end
        v13.TextureSpeed = v14
    end
end
return {
    ["start"] = function(_, _, u16, p17) --[[ Name: start, Line 31 ]]
        --[[
        Upvalues:
            [1] = u15
            [2] = u1
        --]]
        if _G.checkRenderDistance(u16.PrimaryPart.Position) then
            local u18 = Random.new()
            local v19 = {}
            for _, v20 in u16.Trails:GetDescendants() do
                if v20:IsA("Beam") then
                    table.insert(v19, v20)
                end
            end
            local u21 = u16.Humanoid.RootPart
            TweenCreate(u16.AttHolder.Attachment, TweenInfo.new(0.275, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                ["Position"] = Vector3.new(0, -0.5, -7)
            })
            u15(v19, 4)
            for _, v22 in u16.SmokeHolder:GetChildren() do
                if v22:IsA("ParticleEmitter") then
                    v22.Acceleration = Vector3.new(0, 15, 0) + u21.CFrame.LookVector * -40
                end
            end
            local _ = u21.Position
            tick()
            local u23 = tick()
            local u24 = tick()
            local u25 = script.Rush:Clone()
            u25.Transparency = 1
            _G.particleEnabled(u25, false, true)
            u25.CFrame = u21.CFrame * CFrame.new(0, 0, -15)
            u25.Parent = workspace.Effects
            local u26 = script.hit:Clone()
            u26.CFrame = u25.HitAttachment.WorldCFrame
            u26.Parent = workspace.Effects
            _G.particleEnabled(u25, true, true)
            local v27 = script.JetGatlingLoop:Clone()
            v27.Parent = u16.PrimaryPart
            v27:Play()
            local v39 = u1.RenderStepped:Connect(function() --[[ Line: 98 ]]
                --[[
                Upvalues:
                    [1] = u25
                    [2] = u21
                    [3] = u26
                    [4] = u23
                    [5] = u24
                    [6] = u18
                    [7] = u16
                --]]
                u25.CFrame = u21.CFrame * CFrame.new(0, 0, -15)
                u26.CFrame = u25.HitAttachment.WorldCFrame
                if u23 - u24 >= 0.013333333333333334 then
                    u24 = tick()
                    u18:NextInteger(-3, 3)
                    local v28 = u18:NextUnitVector() * 0.5
                    local _ = CFrame.new(u21.Position, u25.Position + u21.CFrame.LookVector + v28) * CFrame.new(u18:NextNumber(-2, 2), u18:NextNumber(-1.5, 1.5) + 1, -3)
                    local v29 = { u16.UpperTorso.RightGat, u16.UpperTorso.LeftGat }
                    for _ = 1, 2 do
                        for v30 = 1, 2 do
                            local v31 = u18:NextNumber(-0.4, 0.4)
                            local v32 = u18:NextNumber(-0.4, 0.5)
                            local v33 = v29[v30].WorldPosition
                            local v34 = u18:NextNumber(-0.3, 0.4)
                            local v35 = v33 + Vector3.new(0, v34, 0) + u21.CFrame.LookVector * 0.6
                            local v36 = CFrame.new(v35, v35 + -u21.CFrame.RightVector * 2) * CFrame.Angles(0, 3.141592653589793, 0)
                            local v37 = u18
                            local v38 = script.ExtraMeshes.Folder[tostring(v37:NextInteger(1, 3))]:Clone()
                            v38.CFrame = v36 * CFrame.Angles(0, v31, v32)
                            v38.Parent = workspace.Effects
                            TweenCreate(v38, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                ["CFrame"] = v38.CFrame * CFrame.new(-3, 0, 0),
                                ["Size"] = v38.Size * Vector3.new(6, 1.4, 1.4)
                            })
                            TweenCreate(v38, TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                                ["Transparency"] = 1
                            })
                            _G.destroy(v38, 0.1)
                        end
                        task.wait()
                    end
                end
                u23 = tick()
            end)
            repeat
                task.wait()
            until p17 == nil or p17 and p17:IsDescendantOf(game) == false
            v39:Disconnect()
            v27:Destroy()
            _G.particleEnabled(u25, false, true)
            _G.destroy(u25, 4)
            _G.particleEnabled(u26, false, true)
            _G.destroy(u26, 4)
            u16.AttHolder.Attachment.Position = Vector3.new(0, -0.5, 0)
            u15(v19)
            for _, v40 in u16.SmokeHolder:GetChildren() do
                if v40:IsA("ParticleEmitter") then
                    v40.Acceleration = Vector3.new(0, 15, 0)
                end
            end
        end
    end
}