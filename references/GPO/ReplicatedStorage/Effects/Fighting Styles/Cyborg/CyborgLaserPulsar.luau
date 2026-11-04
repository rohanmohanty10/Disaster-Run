 

game:GetService("RunService")
game:GetService("TweenService")
local u1 = RaycastParams.new()
u1.FilterType = Enum.RaycastFilterType.Whitelist
u1.FilterDescendantsInstances = { workspace.Islands, workspace.Env, workspace.Ships }
local v2 = {}
local u3 = require(game.ReplicatedStorage.Modules.Client.WeaponVFXRecolor)
local function u9(p4, p5) --[[ Line: 8 ]]
    local v6 = { p4 }
    for _, v7 in p4:GetDescendants() do
        table.insert(v6, v7)
    end
    for _, v8 in v6 do
        if (v8:IsA("ParticleEmitter") or (v8:IsA("BasePart") or (v8:IsA("PointLight") or (v8:IsA("Trail") or v8:IsA("Highlight"))))) and v8:GetAttribute("recolorable") then
            if v8:IsA("Trail") or v8:IsA("ParticleEmitter") then
                v8.Color = ColorSequence.new(p5)
            elseif v8:IsA("Highlight") then
                v8.FillColor = p5
                v8.OutlineColor = Color3.new(1, 1, 1)
            else
                v8.Color = p5
            end
        end
    end
    table.clear(v6)
end
function v2.start(_, p10, p11) --[[ Line: 30 ]]
    --[[
    Upvalues:
        [1] = u9
        [2] = u3
        [3] = u1
    --]]
    if _G.checkRenderDistance(p10.PrimaryPart.Position) ~= false then
        local u12 = p10.PrimaryPart.CFrame * CFrame.new(0.45, 0, -4)
        local v13 = script.repulsorBlast:Clone()
        u9(v13, p11)
        u3.apply(v13, p10)
        v13.Parent = workspace.Effects
        v13:SetPrimaryPartCFrame(u12 * CFrame.new(0, 0, -24, -4.37113883e-8, 0.2079117, 0.978147626, 0, 0.978147626, -0.2079117, -1, -9.08810893e-9, -4.27561915e-8))
        _G.PlaySound(v13, script.CyBlastShoot)
        for _, u14 in v13:GetChildren() do
            local v15 = CFrame.Angles(u14:GetAttribute("RotateAxis") == "X" and 1.5707963267948966 or 0, u14:GetAttribute("RotateAxis") == "Y" and 1.5707963267948966 or 0, 0)
            local v16 = CFrame.Angles
            local v17
            if u14:GetAttribute("RotateAxis") == "X" then
                v17 = 0
            else
                local v18 = math.random(-90, 90)
                v17 = math.rad(v18) or 0
            end
            local v19
            if u14:GetAttribute("RotateAxis") == "Y" then
                v19 = 0
            else
                local v20 = math.random(-360, 360)
                v19 = math.rad(v20) or 0
            end
            local u21 = v15 * v16(v17, v19, 0)
            u14.Size = Vector3.new(0, 0, 0)
            u14.CFrame = u12 * CFrame.new(0, 0, -(u14.Size[u14:GetAttribute("ScaleAxis") or "Y"] / 2)) * u21
            task.spawn(function() --[[ Line: 120 ]]
                --[[
                Upvalues:
                    [1] = u14
                    [2] = u12
                    [3] = u21
                --]]
                _G.tween(u14, {
                    0,
                    Enum.EasingStyle.Back,
                    Enum.EasingDirection.Out,
                    0,
                    false
                }, {
                    ["Size"] = Vector3.new(48, 6, 6),
                    ["CFrame"] = u12 * CFrame.new(0, 0, -((Vector3.new(48, 6, 6))[u14:GetAttribute("ScaleAxis") or "Y"] / 2)) * u21
                })
                _G.tween(u14, {
                    0.21,
                    Enum.EasingStyle.Bounce,
                    Enum.EasingDirection.Out,
                    0,
                    true
                }, {
                    ["Size"] = Vector3.new(49, 9, 9),
                    ["CFrame"] = u12 * CFrame.new(0, 0, -((Vector3.new(48, 6, 6))[u14:GetAttribute("ScaleAxis") or "Y"] / 2)) * u21
                })
                task.wait(0.3)
                _G.tween(u14, {
                    0.3,
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out,
                    0,
                    false
                }, {
                    ["Size"] = Vector3.new(48, 0, 0),
                    ["CFrame"] = u12 * CFrame.new(0, 0, -((Vector3.new(48, 6, 6))[u14:GetAttribute("ScaleAxis") or "Y"] / 2)) * u21
                })
            end)
        end
        _G.destroy(v13, 0.6)
        local v22 = script.BlastEffects.first:Clone()
        u9(v22, p11)
        u3.apply(v22, p10)
        v22.Parent = workspace.Effects
        v22.CFrame = u12 * CFrame.new(0, 0, -3)
        for _, v23 in v22:GetDescendants() do
            if v23:IsA("ParticleEmitter") then
                _G.customEmit(v23)
            end
        end
        _G.destroy(v22, 7)
        task.wait(0.1)
        for v24 = 1, 10 do
            local v25 = u12 * CFrame.new(0, 0, -(v24 * 4))
            local v26 = workspace:Raycast(v25.Position, v25.UpVector * Vector3.new(0, -10, 0), u1)
            if v26 then
                local u27 = script.floorFire:Clone()
                u9(u27, p11)
                u3.apply(u27, p10)
                local v28 = CFrame.new(v26.Position, v26.Position + v26.Normal)
                local v29 = CFrame.Angles
                local v30 = math.random(0, 360)
                u27.CFrame = v28 * v29(-1.5707963267948966, math.rad(v30), 0)
                u27.Parent = workspace.Effects
                task.delay(1 + math.random(60, 200) / 100, function() --[[ Line: 167 ]]
                    --[[
                    Upvalues:
                        [1] = u27
                    --]]
                    for _, v31 in ipairs(u27:GetChildren()) do
                        v31.Enabled = false
                    end
                    _G.destroy(u27, 4)
                end)
            end
        end
        local v32 = script.BlastEffects.throw:Clone()
        u9(v32, p11)
        u3.apply(v32, p10)
        v32.Parent = workspace.Effects
        v32.CFrame = u12 * CFrame.new(0, 0, -3)
        for _, v33 in v32:GetDescendants() do
            if v33:IsA("ParticleEmitter") then
                _G.customEmit(v33)
            end
        end
        _G.destroy(v32, 7)
    end
end
return v2