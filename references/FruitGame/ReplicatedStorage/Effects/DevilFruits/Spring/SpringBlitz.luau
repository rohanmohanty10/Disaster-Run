 

local v1 = {}
local u2 = game:GetService("TweenService")
script:WaitForChild("Rocks"):GetChildren()
local _ = script.Animations
local _ = _G.customEmit
local function u9(p3, p4) --[[ Line: 22 ]]
    local v5 = p3:GetDescendants()
    local v6 = {}
    for v7 = 1, #v5 do
        if v5[v7]:IsA("Humanoid") or v5[v7]:IsA("AnimationController") and v5[v7].Parent.Name:match("Spring") then
            local v8 = v5[v7]:LoadAnimation(p4)
            v8:Play()
            v8:AdjustWeight(2)
            table.insert(v6, v8)
        end
    end
    return v6
end
local function u13(p10, p11) --[[ Line: 36 ]]
    for _, v12 in p10:GetDescendants() do
        if v12:IsA("ParticleEmitter") or v12:IsA("Trail") then
            v12.Enabled = p11
        end
    end
end
function v1.start(_, u14, u15) --[[ Line: 50 ]]
    --[[
    Upvalues:
        [1] = u9
        [2] = u2
        [3] = u13
    --]]
    if _G.checkRenderDistance(u14.PrimaryPart.Position) then
        Random.new()
        local u16 = game.Players.LocalPlayer.Character == u14
        u9(u14, script.Animations.Start)
        u14:GetPivot()
        local v17 = script.Trail:Clone()
        local v18 = u14.UpperTorso.CFrame
        local v19 = workspace.Effects
        v17.CFrame = v18
        v17.Parent = v19
        local v20 = Instance.new("WeldConstraint")
        v20.Part0 = u14.UpperTorso
        v20.Part1 = v17
        v20.Parent = v17
        if u16 == true then
            u14.Humanoid.AutoRotate = false
        end
        _G.PlaySound(u14.PrimaryPart, script.SpringBlitzStart)
        task.delay(0.6, function() --[[ Line: 69 ]]
            --[[
            Upvalues:
                [1] = u16
                [2] = u14
                [3] = u15
            --]]
            for v21 = 1, 8 do
                local v22 = v21 % 2 == 0 and -1 or 1
                if u16 == true then
                    u14.Humanoid.AutoRotate = false
                end
                local v23 = script.SpringEffect:Clone()
                v23.CFrame = u14.PrimaryPart.CFrame * CFrame.new(v22 * 9, -3, -1)
                v23.Parent = workspace.Effects
                _G.customEmit(v23)
                _G.destroy(v23, 2)
                _G.PlaySound(v23, script.SpringBlitzSingleJump, {
                    ["Pitch"] = math.random(100, 120) / 100
                })
                if u15 and u16 == true then
                    u15:FireServer(u14.PrimaryPart.CFrame)
                end
                task.wait(0.1)
            end
        end)
        task.wait(0.66)
        local v24 = u9(u14, script.Animations.Loop)
        if u16 == true then
            local v25 = Instance.new("BodyVelocity")
            v25.MaxForce = Vector3.new(1000000, 1000000, 1000000)
            v25.Velocity = u14:GetPivot().LookVector * 45 + Vector3.new(0, 0.1, 0)
            v25.Parent = u14.PrimaryPart
            _G.destroy(v25, 0.95)
        end
        task.wait(0.8)
        for v26 = 1, #v24 do
            v24[v26]:Stop()
        end
        u14.Humanoid.AutoRotate = true
        u9(u14, script.Animations.End)
        _G.PlaySound(u14.PrimaryPart, script.SpringBlitzEnd)
        local v27 = script.Chargeup:Clone()
        v27.CFrame = u14:GetPivot()
        v27.Parent = workspace.Effects
        _G.customEmit(v27)
        _G.destroy(v27, 2.5)
        task.wait(0.55)
        local v28 = script.LastSpring:Clone()
        v28.CFrame = u14:GetPivot() * CFrame.new(0, -2.5, 3.5)
        v28.Parent = workspace.Effects
        _G.customEmit(v28)
        _G.destroy(v28, 2)
        local v29 = script.Waves:Clone()
        local v30 = u14:GetPivot()
        local v31 = workspace.Effects
        v29.CFrame = v30
        v29.Parent = v31
        local v32 = Instance.new("WeldConstraint")
        v32.Part0 = u14.PrimaryPart
        v32.Part1 = v29
        v32.Parent = v29
        if u16 == true then
            local v33 = Instance.new("BodyVelocity")
            v33.MaxForce = Vector3.new(100000000000, 100000000000, 100000000000)
            v33.Velocity = u14:GetPivot().LookVector * 65
            v33.Parent = u14.LowerTorso
            u2:Create(v33, TweenInfo.new(1), {
                ["Velocity"] = Vector3.new(0, 0, 0)
            }):Play()
            _G.destroy(v33, 0.54)
            if u15 and u16 == true then
                u15:FireServer(u14.PrimaryPart.CFrame)
            end
        end
        _G.destroy(v29, 2)
        task.delay(0.35, u13, v29)
        task.wait(0.54)
        v17:Destroy()
    end
end
return v1