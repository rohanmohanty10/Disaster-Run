 

local v1 = game:GetService("ReplicatedStorage")
game:GetService("Debris")
local u2 = game:GetService("RunService")
local u3 = game:GetService("TweenService")
require(v1.Modules.BoatTween)
local u4 = script.Parent.Parent:WaitForChild("Animations")
local u5 = script.Parent.Parent:WaitForChild("Models")
script.Parent.Parent:WaitForChild("SFX")
local u6 = script.Parent.Parent:WaitForChild("VFX")
script.Parent.Parent:WaitForChild("Other")
local u7 = workspace.Effects
require(script.Parent.Parent.Parent.Shared.SharedFunctions)
local u8 = Random.new()
local function u14(p9, p10, p11) --[[ Line: 19 ]]
    local v12 = p9:Dot(p10)
    local v13 = p9:Cross(p10)
    if v12 < -0.99999 then
        return CFrame.fromAxisAngle(p11, 3.141592653589793)
    else
        return CFrame.new(0, 0, 0, v13.x, v13.y, v13.z, 1 + v12)
    end
end
local u15 = {}
u15.__index = u15
function u15.new(p16, p17, p18) --[[ Line: 28 ]]
    --[[
    Upvalues:
        [1] = u5
        [2] = u6
        [3] = u4
        [4] = u15
    --]]
    local v19 = {
        ["State"] = "Undeployed",
        ["Name"] = p16,
        ["Bomb"] = u5.Monkey:Clone()
    }
    v19.Bomb.Name = p16
    v19.Bomb:PivotTo(p17)
    v19.Bomb.Parent = p18
    v19.Trail = u6.FlameChompTrail:Clone()
    v19.Landing = u6.FlameChompLand:Clone()
    v19.Puddle = u6.FlameChompLoop:Clone()
    v19.Hit = u6.FlameChompHit:Clone()
    v19.Explosion = u6.FlameChompExplode:Clone()
    v19.Debuff = u6.ChompCircle:Clone()
    v19.Animation = v19.Bomb.AnimationController.Animator:LoadAnimation(u4.Success)
    v19.Victim = "None"
    local v20 = u15
    setmetatable(v19, v20)
    return v19
end
function u15.Throw(u21, p22, u23, u24, u25) --[[ Line: 48 ]]
    --[[
    Upvalues:
        [1] = u7
    --]]
    local u26 = RaycastParams.new()
    u26.FilterType = Enum.RaycastFilterType.Exclude
    u26.FilterDescendantsInstances = u25
    u21.State = "Thrown"
    local u27 = u21.Bomb
    u21.Trail.CFrame = u27.PrimaryPart.CFrame
    for _, v28 in u21.Trail:GetDescendants() do
        if v28:IsA("ParticleEmitter") then
            v28:Emit(1)
        end
    end
    u21.Trail.Parent = u7
    local u29 = u27.PrimaryPart.Position
    local u30 = p22
    local u31 = Vector3.new(0, 0, 0)
    local u32 = game:GetService("TweenService")
    local u33 = nil
    u33 = game:GetService("RunService").RenderStepped:Connect(function(p34) --[[ Line: 79 ]]
        --[[
        Upvalues:
            [1] = u29
            [2] = u30
            [3] = u26
            [4] = u33
            [5] = u21
            [6] = u25
            [7] = u31
            [8] = u23
            [9] = u23
            [10] = u32
            [11] = u24
            [12] = u27
        --]]
        local v35 = workspace:Raycast(u29, u30 * p34, u26)
        if v35 and not (v35.Instance:IsA("Hat") or v35.Instance:IsA("Accessory")) then
            if v35.Instance.Parent:FindFirstChild("Humanoid") then
                u33:Disconnect()
                u21:Bite(v35.Instance.Parent, u25)
                return
            end
            if v35.Normal.Y > 0.1 then
                u33:Disconnect()
                u21:Land(v35, u25)
                return
            end
            local v36 = u30.Y
            u30 = Vector3.new(0, v36, 0)
            local v37 = u31.Y
            u31 = Vector3.new(0, v37, 0)
        end
        u29 = u29 + u30 * p34
        local v38 = u30.Y - u23 * p34
        local v39 = -u23
        local v40 = math.max(v39, v38)
        local v41, v42 = u32:SmoothDamp(u30, Vector3.new(0, v40, 0), u31, u24, (1 / 0), p34)
        u30 = v41
        u31 = v42
        local v43 = u30.X
        local v44 = u30.Z
        u30 = Vector3.new(v43, v40, v44)
        u27:MoveTo(u29)
        u21.Trail.Position = u29
    end)
end
function u15.Land(u45, p46, u47) --[[ Line: 130 ]]
    --[[
    Upvalues:
        [1] = u7
        [2] = u14
        [3] = u8
        [4] = u2
    --]]
    u45.State = "Deployed"
    local v48 = u45.Bomb
    local v49 = p46.Position
    local v50 = u45.Bomb.PrimaryPart.Size.Y
    v48:MoveTo(v49 + Vector3.new(0, v50), 0)
    u45.Landing.Position = p46.Position
    for _, v51 in u45.Landing:GetDescendants() do
        if v51:IsA("ParticleEmitter") then
            v51:Emit(1)
        end
    end
    task.delay(1, u45.Landing.Destroy, u45.Landing)
    u45.Landing.Parent = u7
    u45.Puddle.Position = p46.Position
    u45.Puddle.CFrame = u45.Puddle.CFrame * u14(u45.Puddle.CFrame.UpVector, p46.Normal, Vector3.new(0, 1, 0))
    for _, v52 in u45.Puddle:GetDescendants() do
        if v52:IsA("ParticleEmitter") then
            v52:Emit(1)
        end
    end
    u45.Puddle.Parent = u7
    for _, v53 in u45.Trail:GetDescendants() do
        if v53:IsA("Trail") then
            v53.Enabled = false
        end
    end
    u45.Animation:Play()
    u45.Animation.TimePosition = u8:NextNumber(0, 1)
    u45.Animation:AdjustSpeed(u8:NextNumber(1.5, 2))
    local u54 = os.clock()
    local u55 = nil
    u55 = u2.RenderStepped:Connect(function() --[[ Line: 166 ]]
        --[[
        Upvalues:
            [1] = u54
            [2] = u45
            [3] = u47
            [4] = u55
        --]]
        if os.clock() - u54 >= 2 then
            u45:Explode(u47)
            u55:Disconnect()
        end
    end)
end
function u15.Bite(p56, p57, p58) --[[ Line: 175 ]]
    --[[
    Upvalues:
        [1] = u7
        [2] = u2
    --]]
    p56.State = "Biting"
    p56.Victim = p57
    p56.Debuff.CFrame = p57.HumanoidRootPart.CFrame * CFrame.new(0, -3, 0)
    local v59 = Instance.new("WeldConstraint")
    v59.Part0 = p57.HumanoidRootPart
    v59.Part1 = p56.Debuff
    v59.Parent = p56.Debuff
    p56.Debuff.Parent = u7
    local v60 = p56.Victim
    table.insert(p58, v60)
    p56:Explode(p58)
    local v61 = os.clock()
    while true do
        u2.RenderStepped:Wait()
        if os.clock() - v61 >= 2 then
            p56.Victim = nil
        end
        if p56.Victim == nil then
            for _, v62 in p56.Debuff:GetDescendants() do
                if v62:IsA("ParticleEmitter") then
                    v62.Enabled = false
                elseif v62:IsA("Beam") then
                    _G.tween(v62, { 0.5, "Quad", "In" }, {
                        ["Transparency"] = NumberSequence.new(1, 1)
                    })
                end
            end
            task.delay(1, p56.Debuff.Destroy, p56.Debuff)
            return
        end
    end
end
function u15.Explode(u63, p64) --[[ Line: 203 ]]
    --[[
    Upvalues:
        [1] = u7
        [2] = u8
        [3] = u6
        [4] = u3
    --]]
    local v65 = RaycastParams.new()
    v65.FilterType = Enum.RaycastFilterType.Exclude
    v65.FilterDescendantsInstances = p64
    local v66
    if u63.State == "Biting" then
        v66 = u63.Victim.HumanoidRootPart.CFrame
    else
        v66 = u63.Bomb.PrimaryPart.CFrame
        u63.State = "Exploding"
    end
    u63.Hit.CFrame = v66
    _G.customEmit(u63.Hit)
    u63.Hit.Parent = u7
    task.delay(1, u63.Hit.Destroy, u63.Hit)
    local v67 = workspace:Raycast(v66.Position + Vector3.new(0, 0.75, 0), Vector3.new(0, -4, 0), v65)
    if v67 then
        u63.Explosion.Position = v67.Position
        u63.Explosion.CFrame = CFrame.lookAt(v67.Position, v67.Position + v67.Normal) * CFrame.Angles(1.5707963267948966, 0, 0)
        _G.customEmit(u63.Explosion)
        u63.Explosion.Parent = u7
        task.delay(1, u63.Explosion.Destroy, u63.Explosion)
        local v68 = { Enum.EasingStyle.Sine, Enum.EasingStyle.Quad }
        for _ = 1, 6 do
            local v69 = u8:NextNumber(0.125, 0.5)
            local v70 = u8:NextNumber(1, 3)
            local v71 = u8:NextNumber(10, 20)
            local v72
            if math.random(1, 2) == 1 then
                v72 = Color3.fromRGB(255, 94, 255)
            else
                v72 = Color3.fromRGB(105, 205, 255)
            end
            local v73 = u6.Swirl:Clone()
            v73.Transparency = u8:NextNumber(0.8, 0.95)
            v73.Color = v72
            local v74 = CFrame.lookAt(v67.Position, v67.Position + v67.Normal) * CFrame.new(0, u8:NextNumber(0, 1), 0)
            local v75 = CFrame.Angles
            local v76 = u8:NextNumber(-179, 179)
            local v77 = math.rad(v76)
            local v78 = u8:NextNumber(-5, 5)
            v73.CFrame = v74 * v75(-1.5707963267948966, v77, (math.rad(v78)))
            v73.Size = Vector3.new(v70, v70, v70)
            v73.Parent = workspace.Effects
            local v79 = u3
            local v80 = TweenInfo.new(v69, v68[math.random(1, #v68)], Enum.EasingDirection.Out)
            local v81 = {}
            local v82 = u8:NextNumber(1, 5)
            v81.Size = Vector3.new(v71, v82, v71)
            local v83 = CFrame.new(v67.Position) * CFrame.new(0, u8:NextNumber(0, 2), 0) * v73.CFrame.Rotation
            local v84 = CFrame.Angles
            local v85 = u8:NextNumber(-25, 25)
            v81.CFrame = v83 * v84(0, math.rad(v85) * (v69 * 10), 0)
            v79:Create(v73, v80, v81):Play()
            u3:Create(v73, TweenInfo.new(v69, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
                ["Transparency"] = 1
            }):Play()
            task.delay(v69, v73.Destroy, v73)
        end
    end
    u63.Bomb:Destroy()
    u63.Puddle:Destroy()
    u63.Trail.Attachment.PointLight.Enabled = false
    u63.Trail.Attachment.Glow.Enabled = false
    u63.Trail.Attachment.Glow:Clear()
    task.delay(1, function() --[[ Line: 261 ]]
        --[[
        Upvalues:
            [1] = u63
        --]]
        u63.Trail:Destroy()
        u63.Bomb:Destroy()
        u63.Hit:Destroy()
        u63.Explosion:Destroy()
    end)
end
return u15