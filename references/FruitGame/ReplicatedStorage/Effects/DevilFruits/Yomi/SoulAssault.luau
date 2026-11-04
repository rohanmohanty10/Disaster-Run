 

local v1 = {}
local u2 = script:WaitForChild("Animations")
local u3 = game:GetService("TweenService")
function PlayAnim(p4, p5)
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v6 = (p4:FindFirstChild("Humanoid") or p4:FindFirstChild("AnimationController")).Animator:LoadAnimation(u2[p5])
    v6:Play()
    v6:AdjustWeight(2)
    return v6
end
function CreateMesh(p7, p8)
    local v9 = script:WaitForChild("MeshImage"):Clone()
    v9.CFrame = p8 * CFrame.Angles(0, -1.5707963267948966, 0)
    v9.Parent = workspace.Effects
    v9.Decal.Texture = "rbxassetid://" .. p7
    return v9
end
function Hitbox(p10)
    local v11 = OverlapParams.new()
    local v12 = Enum.RaycastFilterType.Blacklist
    v11.FilterDescendantsInstances = { p10 }
    v11.FilterType = v12
    local v13 = workspace:GetPartBoundsInBox(p10.PrimaryPart.CFrame * CFrame.new(0, 0, -3), Vector3.new(5, 5, 14), v11)
    for _, v14 in next, v13 do
        local v15 = v14.Parent:FindFirstChild("Humanoid") or v14.Parent.Parent:FindFirstChild("Humanoid")
        if v15 then
            return v15
        end
    end
end
function v1.start(_, u16) --[[ Line: 38 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    if _G.checkRenderDistance(u16.PrimaryPart.Position) ~= false then
        u16.Archivable = true
        local u17 = u16:Clone()
        u17.PrimaryPart.Anchored = true
        task.spawn(function() --[[ Line: 47 ]]
            --[[
            Upvalues:
                [1] = u17
            --]]
            for _, v18 in u17:GetDescendants() do
                if v18:IsA("BodyVelocity") then
                    v18:Destroy()
                elseif v18:IsA("BaseScript") then
                    v18:Destroy()
                elseif v18:IsA("Weld") or v18:IsA("Motor6D") then
                    if v18.Part1 and v18.Part1:IsDescendantOf(u17) == false then
                        v18:Destroy()
                    end
                elseif v18:IsA("BasePart") then
                    v18.CanTouch = false
                    v18.CollisionGroupId = 6
                    v18.CanCollide = false
                    v18.CanQuery = false
                    v18.CastShadow = false
                    if v18.Transparency == 1 then
                        v18:SetAttribute("trans", true)
                    end
                    if v18:IsA("MeshPart") then
                        v18.TextureID = ""
                    end
                    v18.Color = Color3.fromRGB(135, 255, 80)
                    v18.Material = Enum.Material.Neon
                elseif v18:IsA("Decal") then
                    v18:Destroy()
                end
            end
        end)
        u17.Parent = workspace.Effects
        u17:PivotTo(u16:GetPrimaryPartCFrame())
        _G.customWeld(u17.PrimaryPart, u16.PrimaryPart, CFrame.new(), u17)
        local u19 = script:WaitForChild("Beam Holder"):Clone()
        local u20 = script:WaitForChild("End")["2"]:Clone()
        u19.CFrame = u16:GetPrimaryPartCFrame()
        u19.Parent = workspace.Effects
        u20.Parent = u17.UpperTorso
        _G.customWeld(u19, u16.PrimaryPart, CFrame.new(), u19)
        local v21 = next
        local v22, v23 = u19:GetChildren()
        for _, v24 in v21, v22, v23 do
            if v24:IsA("Beam") then
                v24.Attachment0 = u19["1"]
                v24.Attachment1 = u20
            end
        end
        PlayAnim(u16, "Player")
        PlayAnim(u17, "Soul")
        task.delay(0.45, function() --[[ Line: 103 ]]
            --[[
            Upvalues:
                [1] = u17
                [2] = u16
                [3] = u16
                [4] = u3
                [5] = u19
                [6] = u20
            --]]
            local function v33(p25) --[[ Line: 104 ]]
                --[[
                Upvalues:
                    [1] = u17
                --]]
                local v26 = next
                local v27, v28 = u17:GetDescendants()
                for _, v29 in v26, v27, v28 do
                    if v29.Name ~= "HumanoidRootPart" and (v29:IsA("BasePart") and v29:GetAttribute("trans") == nil) then
                        local v30 = _G.tween
                        local v31 = { 0.15, "Linear", Enum.EasingDirection.Out }
                        local v32 = {
                            ["Transparency"] = ({
                                [true] = 0.8,
                                [false] = 1
                            })[p25]
                        }
                        v30(v29, v31, v32)
                    end
                end
            end
            _G.PlaySound(u16, script["Audio/YomiKickWhoosh"]).Parent = u16.PrimaryPart
            task.delay(1.3, function() --[[ Line: 111 ]]
                --[[
                Upvalues:
                    [1] = u16
                    [2] = u3
                --]]
                local v34 = { 9632554664, 9622414579, 9572542664 }
                for v35 = 1, #v34 do
                    local v36 = CreateMesh(v34[v35], u16:GetPrimaryPartCFrame() * CFrame.new(0, 0, -2.5) * CFrame.Angles(0, 3.141592653589793, 0))
                    v36.Mesh.Scale = Vector3.new(0, 0, 0)
                    v36.Decal.Transparency = 0
                    local v37
                    if v35 == 3 then
                        v37 = Vector3.new(0.45, 0, 0)
                    else
                        local v38 = v35 * 0.292
                        v37 = Vector3.new(v38, 0.222, 0.215) * (v35 / 4 + 1)
                    end
                    u3:Create(v36.Mesh, TweenInfo.new(0.45 / v35, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                        ["Scale"] = v37
                    }):Play()
                    _G.tween(v36, { 0.6 / v35, "Quint", Enum.EasingDirection.Out }, {
                        ["CFrame"] = v36.CFrame * CFrame.new(v35 * 5, 0, 0) * CFrame.Angles(-3.141592653589793, 0, 0)
                    })
                    _G.tween(v36.Decal, { 0.6 / v35, "Quart", Enum.EasingDirection.Out }, {
                        ["Transparency"] = 1
                    })
                    _G.destroy(v36, 0.6 / v35)
                end
            end)
            task.spawn(function() --[[ Line: 128 ]]
                --[[
                Upvalues:
                    [1] = u16
                --]]
                local v39 = script:WaitForChild("During").Attachment:Clone()
                v39.Parent = u16.PrimaryPart
                task.wait(0.8)
                _G.destroy(v39, 1)
                local v40 = next
                local v41, v42 = v39:GetChildren()
                for _, v43 in v40, v41, v42 do
                    if v43:IsA("ParticleEmitter") then
                        v43.Enabled = false
                    end
                end
            end)
            v33(true)
            task.wait(0.6)
            v33(false)
            task.wait(0.475)
            v33(true)
            task.wait(0.5)
            v33(false)
            _G.destroy(u17, 0.25)
            _G.destroy(u19, 0.25)
            _G.destroy(u20, 0.25)
        end)
    end
end
return v1