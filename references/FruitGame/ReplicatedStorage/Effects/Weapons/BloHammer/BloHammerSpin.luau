

local v1 = {}
local u2 = require(script.MeshTextures)
local u3 = RaycastParams.new()
u3.FilterDescendantsInstances = { workspace.Env, workspace.Islands, workspace.Ships }
u3.FilterType = Enum.RaycastFilterType.Include
local u4 = _G.tween
function v1.start(_, p5, p6) --[[ Line: 28 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u4
        [3] = u3
    --]]
    local v7 = p5:FindFirstChild("HumanoidRootPart")
    if not v7 then
        return
    end
    local v8 = script.Red
    if p6 then
        v8 = script[p6]
    end
    local v9 = p5.Humanoid.Animator:LoadAnimation(v8.Start)
    v9:Play()
    local v10 = v8.armCharge.Attachment:Clone()
    v10.Parent = p5.RightHand
    _G.destroy(v10, 3)
    local v11 = v8.Intensitylines:Clone()
    v11.Parent = workspace.Effects
    v11.Position = v7.Position - Vector3.new(0, 2.5, 0)
    _G.destroy(v11, 3)
    local v12 = Instance.new("Weld")
    v12.Part0 = v7
    v12.C0 = CFrame.new()
    v12.Part1 = v11
    v11.Anchored = false
    v12.Parent = v11
    task.wait(0.4)
    _G.particleEnabled(v10, false)
    _G.particleEnabled(v11, false)
    task.wait(0.15)
    v9:Stop()
    local v13 = p5.Humanoid.Animator:LoadAnimation(v8.Loop)
    v13:Play()
    v13:AdjustSpeed(1.5)
    if p6 == "Red" then
        v13:AdjustSpeed(1)
    end
    local u14 = v8.Spinning:Clone()
    u14.Parent = workspace.Effects
    u14.Position = v7.Position
    local v15 = CFrame.new(0, -p5.PrimaryPart.Size.Y / 2, 0)
    local v16 = Instance.new("Weld")
    v16.Part0 = v7
    v16.C0 = v15 or CFrame.new()
    v16.Part1 = u14
    u14.Anchored = false
    v16.Parent = u14
    local u17 = v8.Main:Clone()
    u17.Parent = workspace.Effects
    u17.Position = v7.Position
    local v18 = CFrame.Angles(-1.5707963267948966, 0, 0)
    local v19 = Instance.new("Weld")
    v19.Part0 = v7
    v19.C0 = v18 or CFrame.new()
    v19.Part1 = u17
    u17.Anchored = false
    v19.Parent = u17
    local v20 = v8.EasterHammerSpinLoop:Clone()
    v20.Parent = p5.PrimaryPart
    v20:Play()
    local v21 = 0
    while true do
        task.wait()
        if tick() - v21 >= 0.25 then
            local u22 = v8.SOFT_WIND:Clone()
            u22.Position = v7.Position
            local v23 = CFrame.Angles
            local v24 = math.random(0, 180)
            local v25 = v23(0, math.rad(v24), 0)
            local v26 = Instance.new("Weld")
            v26.Part0 = v7
            v26.C0 = v25 or CFrame.new()
            v26.Part1 = u22
            u22.Anchored = false
            v26.Parent = u22
            u22.Anchored = false
            u22.Parent = workspace.Effects
            game.TweenService:Create(u22.Mesh, TweenInfo.new(0.25), {
                ["Scale"] = Vector3.new(7, 3.5, 7)
            }):Play()
            game.TweenService:Create(u22.Decal, TweenInfo.new(0.2), {
                ["Transparency"] = 1
            }):Play()
            task.spawn(function() --[[ Line: 94 ]]
                --[[
                Upvalues:
                    [1] = u2
                    [2] = u22
                --]]
                for _, v27 in u2.SoftWind do
                    u22.Decal.Texture = v27
                    game:GetService("RunService").Heartbeat:Wait()
                    task.wait(0.025)
                end
                u22:Destroy()
            end)
            v21 = tick()
        end
        if p5:GetAttribute("BloSpin") == nil then
            _G.tween(v20, {
                0.25,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Volume"] = 0
            })
            _G.destroy(v20, 0.25)
            _G.PlaySound(p5.PrimaryPart, v8.EasterHammerSpinEndWhoosh)
            v13:Stop()
            local v28 = p5.Humanoid.Animator:LoadAnimation(v8.End)
            v28:Play()
            v28.Priority = Enum.AnimationPriority.Action4
            if p6 == "Pink" then
                v28:AdjustSpeed(1.5)
            else
                v28:AdjustSpeed(0.95)
            end
            _G.destroy(u17, 3)
            _G.destroy(u14, 3)
            task.spawn(function() --[[ Line: 124 ]]
                --[[
                Upvalues:
                    [1] = u14
                    [2] = u17
                    [3] = u4
                --]]
                task.wait(0.15)
                _G.particleEnabled(u14, false)
                _G.particleEnabled(u17, false)
                for _, v29 in u17:GetDescendants() do
                    if v29:IsA("Beam") then
                        u4(v29, { 0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out }, {
                            ["Transparency"] = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 1) }),
                            ["TextureSpeed"] = 0.3
                        })
                    end
                end
            end)
            local v30 = workspace:Raycast(v7.Position, Vector3.new(0, -50, 0), u3)
            task.wait(0.4)
            if v30 ~= nil then
                for _, v31 in script.Dust:GetChildren() do
                    local u32 = v31:Clone()
                    u32.Parent = p5.RightFoot
                    if v30 then
                        local v33 = v30.Instance.Color
                        u32.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, v33), ColorSequenceKeypoint.new(1, v33) })
                    end
                    task.delay(0.8, function() --[[ Line: 161 ]]
                        --[[
                        Upvalues:
                            [1] = u32
                        --]]
                        u32.Enabled = false
                        _G.destroy(u32, 3)
                    end)
                end
            end
        end
    end
end
return v1