 

local u1 = game:GetService("RunService")
local u2 = game:GetService("TweenService")
local u3 = Random.new()
local u4 = require(game.ReplicatedStorage.Modules.Trove)
local v5 = RaycastParams.new()
v5.FilterDescendantsInstances = { workspace.Islands, workspace.Env, workspace.Ships }
v5.FilterType = Enum.RaycastFilterType.Include
local v6 = -workspace.Gravity * 3.5
local u7 = Vector3.new(0, v6, 0)
local u8 = {
    ["BubblePuller1"] = Vector3.new(0, 0, 1),
    ["BubblePuller2"] = Vector3.new(-1, -0, -0),
    ["BubblePuller3"] = Vector3.new(-0, -0, -1),
    ["BubblePuller4"] = Vector3.new(1, 0, 0),
    ["BubblePuller5"] = Vector3.new(0, 1, 0),
    ["BubblePuller6"] = Vector3.new(-0, -1, -0)
}
local u9 = require(script.Signal)
local u10 = {}
u10.__index = u10
function u10.new(p11) --[[ Line: 30 ]]
    --[[
    Upvalues:
        [1] = u10
        [2] = u8
    --]]
    local v12 = u10
    local v13 = setmetatable(p11, v12)
    local v14 = v13.Parent.Model:GetScale()
    v13.OriginalPosition = v13.Bone.Position
    v13.AffectedAxis = u8[v13.Bone.Name]
    v13.Frequency = 5
    v13.Resolution = 100
    v13.Amplitude = 2 * v14
    v13.RandomSeed = math.random(1000)
    return v13
end
function u10._noise(p15) --[[ Line: 45 ]]
    return math.noise(p15.Bone.Position.X * p15.Frequency / p15.Resolution + os.clock(), p15.Bone.Position.Y * p15.Frequency / p15.Resolution, p15.RandomSeed) * p15.Amplitude
end
local u16 = {}
u16.__index = u16
function u16.new(p17) --[[ Line: 52 ]]
    --[[
    Upvalues:
        [1] = u16
        [2] = u3
        [3] = u9
        [4] = u10
        [5] = u4
        [6] = u2
    --]]
    local v18 = u16
    local v19 = setmetatable(p17, v18)
    v19.Size = v19.Size or (p17.Scale or u3:NextNumber(0.15, 0.25))
    local v20 = script.Bubble:Clone()
    v20:PivotTo(CFrame.new(v19.Position))
    v20:ScaleTo(v19.Size)
    v20.Parent = workspace.Effects
    v19.Model = v20
    v19.Velocity = v19.Velocity or Vector3.new(0, 0, 0)
    v19.Acceleration = v19.Acceleration or Vector3.new(3, 3, 3)
    v19.LifeSpan = v19.LifeSpan or 5
    v19.CanSplash = v19.CanSplash == nil and true or v19.CanSplash
    v19.PuddleDuration = 3
    v19.RotationIncrement = u3:NextUnitVector()
    v19.Rotation = Vector3.new(0, 0, 0)
    v19.Destroyed = u9.new()
    v19.FallSFX = script.MiniWaterBallFall:Clone()
    v19.FallSFX.Pitch = math.random(90, 110) / 100
    v19.FallSFX.Parent = v20.PrimaryPart
    v19.FallSFX:Play()
    v19.Pullers = {}
    for _, v21 in pairs(v19.Model.Sphere.Base:GetChildren()) do
        local v22 = v19.Pullers
        local v23 = u10.new
        table.insert(v22, v23({
            ["Bone"] = v21,
            ["Parent"] = v19
        }))
    end
    v19.trash = u4.new()
    v19.trash:Add(v19)
    u2:Create(v19.Model.PrimaryPart, TweenInfo.new(0.14, Enum.EasingStyle.Back, Enum.EasingDirection.Out, 0, true), {
        ["Size"] = v19.Model.PrimaryPart.Size * 1.4
    }):Play()
    v19:_main()
    return v19
end
function u16._getPosition(p24) --[[ Line: 104 ]]
    return p24.Model:GetPivot().Position
end
local u25 = script.Puddle:GetChildren()
local _ = workspace.Env:WaitForChild("WaterStuff"):WaitForChild("Falls").Position.Y
function u16._main(u26) --[[ Line: 112 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u1
        [3] = u7
        [4] = u25
    --]]
    u26.StartClock = os.clock()
    local u27 = 0
    local u28 = nil
    local u29 = tick()
    u26.CFrameCNT = u26.CFrameValue:GetPropertyChangedSignal("Value"):Connect(function() --[[ Line: 120 ]]
        --[[
        Upvalues:
            [1] = u26
            [2] = u29
            [3] = u28
            [4] = u2
        --]]
        if u26.CFrameValue:GetAttribute("ExplodePosition") then
            return
        elseif tick() - u29 > 0.03333333333333333 then
            local v30 = u26.CFrameValue.Value
            local v31 = u26.CFrameValue:GetAttribute("DT") + (tick() - u29)
            if u28 then
                u28:Pause()
                u28:Destroy()
                u28 = nil
            end
            u28 = u2:Create(u26.Model.PrimaryPart, TweenInfo.new(v31, Enum.EasingStyle.Quad), {
                ["CFrame"] = v30 * CFrame.Angles(u26.Rotation.X, u26.Rotation.Y, u26.Rotation.Z)
            })
            u28:Play()
            u29 = tick()
        end
    end)
    u26.RunService = u1.Heartbeat:Connect(function(p32) --[[ Line: 151 ]]
        --[[
        Upvalues:
            [1] = u27
            [2] = u26
            [3] = u7
            [4] = u28
            [5] = u2
            [6] = u25
        --]]
        u27 = u27 + p32
        if u27 <= 0.03333333333333333 then
            return
        else
            local v33 = u27
            u27 = 0
            u26:_getPosition()
            local v34 = u26
            v34.Acceleration = v34.Acceleration + u7 * v33
            local v35 = u26
            v35.Velocity = v35.Velocity + u26.Acceleration * v33
            local u36 = u26.CFrameValue:GetAttribute("ExplodePosition") ~= nil and {
                ["Position"] = u26.CFrameValue:GetAttribute("ExplodePosition"),
                ["Normal"] = u26.CFrameValue:GetAttribute("ExplodeNormal")
            } or nil
            if os.clock() - u26.StartClock >= u26.LifeSpan or u36 then
                u26:Destroy()
                if u36 then
                    if u28 then
                        u28:Pause()
                        u28:Destroy()
                        u28 = nil
                    end
                    local u37 = u2:Create(u26.Model.PrimaryPart, TweenInfo.new(v33, Enum.EasingStyle.Linear), {
                        ["Position"] = u36.Position
                    })
                    u37:Play()
                    task.delay(v33, function() --[[ Line: 195 ]]
                        --[[
                        Upvalues:
                            [1] = u37
                            [2] = u26
                            [3] = u36
                        --]]
                        u37:Pause()
                        u37:Destroy()
                        u26.Model:ScaleTo(u26.Model:GetScale() * 2)
                        u26.Model.PrimaryPart.CFrame = CFrame.new(u36.Position, u36.Position + u36.Normal) * CFrame.Angles(-1.5707963267948966, 0, 0) * CFrame.new(0, 0.3, 0)
                        for _, v38 in u26.Model.PrimaryPart:GetDescendants() do
                            if v38:IsA("ParticleEmitter") then
                                if v38:IsDescendantOf(u26.Model.PrimaryPart.FloorHit) then
                                    v38:Emit(v38:GetAttribute("EmitCount") or 5)
                                end
                                v38.Enabled = false
                            elseif v38:IsA("Trail") then
                                v38.Enabled = false
                            end
                        end
                    end)
                    local v39 = u26.Model.PrimaryPart.Size.Magnitude
                    if u36.Normal == nil then
                        u36.Normal = Vector3.new(0, 1, 0)
                    end
                    local u40 = u25[math.random(#u25)]:Clone()
                    u40.CFrame = CFrame.new(u36.Position, u36.Position + u36.Normal) * CFrame.Angles(-1.5707963267948966, 6.283185307179586 * math.random(), 0)
                    u40.Size = Vector3.new(v39, 0.25, v39) * 1.2
                    u40.Parent = workspace.Effects
                    u2:Create(u40, TweenInfo.new(0.5), {
                        ["Size"] = u40.Size + Vector3.new(v39, 0, v39) * math.random() * 0.5
                    }):Play()
                    local v41 = script:FindFirstChild("FishKDropSplash" .. math.random(1, 3)):Clone()
                    v41.Pitch = math.random(90, 110) / 100
                    v41.Parent = u40
                    v41:Play()
                    u2:Create(u26.FallSFX, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {
                        ["Volume"] = 0
                    }):Play()
                    task.delay(u26.PuddleDuration, function() --[[ Line: 244 ]]
                        --[[
                        Upvalues:
                            [1] = u2
                            [2] = u40
                        --]]
                        u2:Create(u40, TweenInfo.new(0.5), {
                            ["Transparency"] = 1
                        }):Play()
                        task.wait(0.5)
                        u40:Destroy()
                    end)
                    if u26.Main then
                        script.Parent:SendMessage("Destroyed", {
                            ["Detect"] = u36,
                            ["CanSplash"] = u26.CanSplash,
                            ["Size"] = u26.Model:GetScale()
                        })
                    end
                end
            else
                for _, v42 in pairs(u26.Pullers) do
                    local v43 = v42:_noise()
                    u2:Create(v42.Bone, TweenInfo.new(v33, Enum.EasingStyle.Linear), {
                        ["Position"] = v42.OriginalPosition + v42.AffectedAxis * v43
                    }):Play()
                end
                local v44 = u26
                v44.Rotation = v44.Rotation + u26.RotationIncrement * v33
            end
        end
    end)
end
function u16.Destroy(u45) --[[ Line: 281 ]]
    if u45.RunService ~= nil then
        u45.Destroyed:Fire()
        if u45.RunService then
            u45.RunService:Disconnect()
            u45.RunService = nil
        end
        local u46 = u45.Model
        u46.PrimaryPart.Transparency = 1
        task.delay(2, function() --[[ Line: 296 ]]
            --[[
            Upvalues:
                [1] = u46
            --]]
            u46:Destroy()
        end)
        task.delay(u45.PuddleDuration + 1, function() --[[ Line: 300 ]]
            --[[
            Upvalues:
                [1] = u45
            --]]
            u45.trash:Destroy()
            local v47 = u45
            setmetatable(v47, nil)
            u45 = nil
        end)
    end
end
return u16