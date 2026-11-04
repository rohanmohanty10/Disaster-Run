 

local v1 = {}
game:GetService("Debris")
game:GetService("RunService")
local u2 = game:GetService("TweenService")
local u3 = require(game:GetService("ReplicatedStorage").Modules.Client.WeaponVFXRecolor)
script:WaitForChild("Animations")
script:WaitForChild("Models")
script:WaitForChild("SFX")
script:WaitForChild("VFX")
script:WaitForChild("Other")
local u4 = workspace:WaitForChild("Effects")
local u5 = Random.new()
function v1.start(_, p6) --[[ Line: 16 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u4
        [3] = u5
        [4] = u2
    --]]
    local u7 = p6.isSpecial
    local u8 = p6.Character
    local u9 = script.VFX.Normal
    local u10 = script.SFX.Normal
    if u7 == true then
        u9 = script.VFX.Special
        u10 = script.SFX.Special
    end
    if p6.Type == "Hit" then
        local v11 = u9.FlameChompHit:Clone()
        u3.apply(v11, u8)
        v11.CFrame = p6.CFrame
        v11.Parent = workspace.Effects
        _G.customEmit(v11)
        _G.destroy(v11, 4)
    elseif p6.Type == "Debuff" then
        local v12 = p6.Target
        local v13 = v12.Humanoid.HipHeight + v12.PrimaryPart.Size.Y / 2
        local u14 = u9.ChompCircle:Clone()
        u3.apply(u14, u8)
        u14.CFrame = v12.PrimaryPart.CFrame * CFrame.new(0, -v13, 0)
        local v15 = Instance.new("WeldConstraint")
        v15.Part0 = p6.Target.PrimaryPart
        v15.Part1 = u14
        v15.Parent = u14
        u14.Parent = workspace.Effects
        _G.PlaySound(v12.PrimaryPart, u10.JinxGunToysDebuff).Parent = v12.PrimaryPart
        task.delay(p6.Duration, function() --[[ Line: 51 ]]
            --[[
            Upvalues:
                [1] = u14
            --]]
            for _, v16 in u14:GetDescendants() do
                if v16:IsA("ParticleEmitter") then
                    v16.Enabled = false
                elseif v16:IsA("Beam") then
                    _G.tween(v16, { 0.5, "Quad", "In" }, {
                        ["Transparency"] = NumberSequence.new(1, 1)
                    })
                end
            end
            _G.destroy(u14, 3)
        end)
    elseif p6.Type == "Throw" then
        local u17 = p6.Monkey
        if u17.PrimaryPart == nil then
            return
        end
        local v18 = p6.Replicator
        local u19 = nil
        local u20 = nil
        local u21 = u17:GetScale()
        local u22 = u9.FlameChompTrail:Clone()
        u3.apply(u22, u8)
        u22.CFrame = u17.PrimaryPart.CFrame
        u22.Parent = u17
        local v23 = Instance.new("Weld")
        v23.Part0 = u17.PrimaryPart
        v23.Part1 = u22
        v23.Parent = u22
        local u48 = {
            ["Explode"] = function(p24) --[[ Line: 82 ]]
                --[[
                Upvalues:
                    [1] = u9
                    [2] = u3
                    [3] = u8
                    [4] = u4
                    [5] = u5
                    [6] = u21
                    [7] = u2
                    [8] = u22
                    [9] = u19
                    [10] = u7
                    [11] = u10
                    [12] = u17
                --]]
                local v25 = u9.FlameChompExplode:Clone()
                u3.apply(v25, u8)
                v25.CFrame = p24.GroundCFrame
                _G.customEmit(v25)
                v25.Parent = u4
                _G.destroy(v25, 5)
                local v26 = { Enum.EasingStyle.Sine, Enum.EasingStyle.Quad }
                for _ = 1, 6 do
                    local v27 = u5:NextNumber(0.125, 0.5)
                    local v28 = u5:NextNumber(1, 3) * u21
                    local v29 = u5:NextNumber(10, 20) * u21
                    local v30
                    if math.random(1, 2) == 1 then
                        v30 = Color3.fromRGB(255, 94, 255)
                    else
                        v30 = Color3.fromRGB(105, 205, 255)
                    end
                    local v31 = u9.Swirl:Clone()
                    v31.Transparency = u5:NextNumber(0.8, 0.95)
                    v31.Color = v30
                    u3.apply(v31, u8)
                    local v32 = p24.GroundCFrame * CFrame.new(0, u5:NextNumber(0, 1), 0)
                    local v33 = CFrame.Angles
                    local v34 = u5:NextNumber(-179, 179)
                    local v35 = math.rad(v34)
                    local v36 = u5:NextNumber(-5, 5)
                    v31.CFrame = v32 * v33(0, v35, (math.rad(v36)))
                    v31.Size = Vector3.new(v28, v28, v28)
                    v31.Parent = workspace.Effects
                    local v37 = u2
                    local v38 = TweenInfo.new(v27, v26[math.random(1, #v26)], Enum.EasingDirection.Out)
                    local v39 = {}
                    local v40 = u5:NextNumber(1, 5) * u21
                    v39.Size = Vector3.new(v29, v40, v29)
                    local v41 = CFrame.new(p24.GroundCFrame.Position) * CFrame.new(0, u5:NextNumber(0, 2) * u21, 0) * v31.CFrame.Rotation
                    local v42 = CFrame.Angles
                    local v43 = u5:NextNumber(-25, 25)
                    v39.CFrame = v41 * v42(0, math.rad(v43) * (v27 * 10), 0)
                    v37:Create(v31, v38, v39):Play()
                    u2:Create(v31, TweenInfo.new(v27, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
                        ["Transparency"] = 1
                    }):Play()
                    task.delay(v27, v31.Destroy, v31)
                end
                if u22:FindFirstChild("Attachment") then
                    u22.Attachment.PointLight.Enabled = false
                    u22.Attachment.Glow.Enabled = false
                    u22.Attachment.Glow:Clear()
                end
                _G.destroy(u22, 3)
                if u19 then
                    u19:Destroy()
                end
                _G.PlayEffect("JinxMinigunFlameChompers", nil, {
                    ["Type"] = "Hit",
                    ["Character"] = u8,
                    ["CFrame"] = p24.GroundCFrame,
                    ["isSpecial"] = u7
                })
                _G.PlaySound(p24.GroundCFrame, u10["explode" .. math.random(1, 3)], {
                    ["RandomPitch"] = true
                })
                u17:Destroy()
            end,
            ["Landed"] = function(p44) --[[ Line: 132 ]]
                --[[
                Upvalues:
                    [1] = u9
                    [2] = u3
                    [3] = u8
                    [4] = u19
                    [5] = u22
                    [6] = u10
                    [7] = u20
                    [8] = u17
                    [9] = u5
                --]]
                local v45 = u9.FlameChompLand:Clone()
                u3.apply(v45, u8)
                v45.CFrame = p44.GroundCFrame
                v45.Parent = workspace.Effects
                _G.customEmit(v45)
                _G.destroy(v45, 3)
                u19 = u9.FlameChompLoop:Clone()
                u3.apply(u19, u8)
                u19.CFrame = p44.GroundCFrame
                u19.Parent = workspace.Effects
                _G.customEmit(u19)
                for _, v46 in u22:GetDescendants() do
                    if v46:IsA("Trail") then
                        v46.Enabled = false
                    end
                end
                _G.PlaySound(p44.GroundCFrame, u10["JinxGunToysLand" .. math.random(1, 3)])
                u20 = u10.JinxGunToysLoop:Clone()
                u20.Parent = u17.PrimaryPart
                u20.Pitch = u5:NextNumber(0.9, 1.1)
                u20:Play()
                local v47 = u17.AnimationController:LoadAnimation(script.loopAnim)
                v47:Play(0)
                v47:AdjustSpeed(u5:NextNumber(1.5, 2))
            end,
            ["End"] = function(_) --[[ Line: 162 ]]
                --[[
                Upvalues:
                    [1] = u19
                    [2] = u22
                    [3] = u17
                --]]
                if u19 then
                    u19:Destroy()
                end
                _G.destroy(u22, 3)
                u17:Destroy()
            end
        }
        v18.OnClientEvent:Connect(function(p49, p50) --[[ Line: 171 ]]
            --[[
            Upvalues:
                [1] = u48
            --]]
            if u48[p49] then
                u48[p49](p50)
            end
        end)
        local v51 = p6.MiscInfo
        local v52, u53, u54 = table.unpack(v51)
        local u55 = p6.StartPosition
        local u56 = v52
        local u57 = false
        local u58 = Vector3.new(0, 0, 0)
        local u59 = u55
        local u60 = RaycastParams.new()
        u60.FilterType = Enum.RaycastFilterType.Include
        u60.FilterDescendantsInstances = { workspace.Islands, workspace.Ships, workspace.Env }
        u60.RespectCanCollide = true
        local u61 = nil
        u61 = game:GetService("RunService").RenderStepped:Connect(function(p62) --[[ Line: 195 ]]
            --[[
            Upvalues:
                [1] = u17
                [2] = u61
                [3] = u55
                [4] = u56
                [5] = u59
                [6] = u60
                [7] = u58
                [8] = u57
                [9] = u53
                [10] = u53
                [11] = u2
                [12] = u54
            --]]
            if u17 and u17:IsDescendantOf(workspace) == false then
                u61:Disconnect()
                u61 = nil
                return
            elseif u17 == nil or u17.PrimaryPart == nil then
                u61:Disconnect()
                u61 = nil
                return
            elseif u17:GetAttribute("Landed") ~= nil == false then
                local v63 = u55 + u56 * p62 - u59
                local v64 = v63.Magnitude
                if v64 > 0 then
                    local v65 = v63.Unit
                    local v66 = workspace:Raycast(u59, v65 * v64, u60)
                    if v66 then
                        if v66.Normal.Y > 0.1 then
                            local v67 = CFrame.new(v66.Position, v66.Position + v66.Normal) * CFrame.Angles(-1.5707963267948966, 0, 0)
                            local v68 = u17
                            local v69 = u17.PrimaryPart.Size.Y
                            v68:MoveTo((v67 + Vector3.new(0, v69, 0)).Position)
                            u17:SetAttribute("Landed", true)
                            u61:Disconnect()
                            u61 = nil
                            return
                        end
                        local v70 = u56.Y
                        u56 = Vector3.new(0, v70, 0)
                        local v71 = u58.Y
                        u58 = Vector3.new(0, v71, 0)
                        u57 = true
                    end
                end
                u55 = u55 + u56 * p62
                local v72 = u56.Y - u53 * p62
                local v73 = -u53
                local v74 = math.max(v73, v72)
                local v75, v76 = u2:SmoothDamp(u56, Vector3.new(0, v74, 0), u58, u54, (1 / 0), p62)
                u56 = v75
                u58 = v76
                if u57 == false then
                    local v77 = u56.X
                    local v78 = u56.Z
                    u56 = Vector3.new(v77, v74, v78)
                else
                    u56 = Vector3.new(0, v74, 0)
                end
                u17:MoveTo(u55)
                u59 = u55
            else
                u61:Disconnect()
                u61 = nil
            end
        end)
    end
end
return v1