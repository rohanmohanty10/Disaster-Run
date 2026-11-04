 

local u1 = script:WaitForChild("Character").Value
if not u1 then
    script:Destroy()
    return
end
local v2 = workspace
local v3 = u1:WaitForChild("Humanoid", 5)
if v3:IsA("Humanoid") == false then
    script:Destroy()
    return
end
if not v3 or v3.Health <= 0 then
    script:Destroy()
    return
end
local v4 = v3:WaitForChild("Animator", 3) or v3
if not (v3.Parent and (v3:IsDescendantOf(v2) and (v4.Parent and v4:IsDescendantOf(v2)))) then
    return
end
local v5 = game:GetService("ReplicatedStorage"):WaitForChild("NPCAnimations"):WaitForChild("TrueBaal")
local _ = script:WaitForChild("Walkspeed").Value
local u6 = {
    ["Idle"] = v4:LoadAnimation(script.idle100),
    ["Walk"] = v4:LoadAnimation(script.walk100),
    ["Run"] = v4:LoadAnimation(script.walk100),
    ["Fall"] = v4:LoadAnimation(v5.Fall),
    ["Jump"] = v4:LoadAnimation(v5.Jump),
    ["Land"] = v4:LoadAnimation(v5.Land)
}
u6.Idle.Priority = Enum.AnimationPriority.Idle
u6.Walk.Priority = Enum.AnimationPriority.Movement
u6.Run.Priority = Enum.AnimationPriority.Movement
u6.Jump.Priority = Enum.AnimationPriority.Movement
u6.Fall.Priority = Enum.AnimationPriority.Movement
u6.Land.Priority = Enum.AnimationPriority.Movement
local u7 = {}
local u8 = "Idle"
v3.Running:Connect(function(p9) --[[ Line: 71 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u8
        [3] = u6
        [4] = u7
    --]]
    if p9 > 0.749 and u1.PrimaryPart.Anchored == false then
        if u8 ~= "Running" then
            u8 = "Running"
            for v10, _ in u6 do
                if u6[v10].IsPlaying ~= false then
                    u7[v10] = u6[v10].TimePosition
                    u6[v10]:Stop()
                end
            end
            if u7.Run == nil then
                u7.Run = 0
            end
            u6.Run:Play()
            u6.Run.TimePosition = u7.Run
            return
        end
    elseif u8 ~= "Idle" then
        u8 = "Idle"
        for v11, _ in u6 do
            if u6[v11].IsPlaying ~= false then
                u7[v11] = u6[v11].TimePosition
                u6[v11]:Stop()
            end
        end
        u6.Idle:Play()
    end
end)
u6.Idle:Play()
task.spawn(function() --[[ Line: 128 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    while true do
        _G.PlaySound(u1.PrimaryPart, script.SFX:GetChildren()[math.random(1, #script.SFX:GetChildren())]).Parent = u1.PrimaryPart
        task.wait(math.random(10, 15))
    end
end)
local v12 = u8
local v13 = "100"
local v14 = {
    ["third"] = false,
    ["half"] = false
}
while true do
    local _ = v3.Health / v3.MaxHealth
    local v15 = u1:GetAttribute("currentMode")
    if v15 and v13 ~= v15 then
        if v15 == "50" then
            if v14.half == false then
                v14.half = true
                local v16 = v14.half
                for v17, _ in pairs(v14) do
                    if v17 ~= v16 then
                        v14[v17] = false
                    end
                end
                local v18 = v4:LoadAnimation(script.idle50)
                v18:Play()
                u6.Idle:Stop()
                u6.Idle = v18
                u6.Run:Stop()
                u6.Run = v4:LoadAnimation(script.walk50)
                if v12 == "Walk" or v12 == "Run" then
                    u6.Run:Play()
                end
            else
                v15 = v13
            end
        elseif v15 == "75" then
            if v14.third == false then
                v14.third = true
                local v19 = v14.third
                for v20, _ in pairs(v14) do
                    if v20 ~= v19 then
                        v14[v20] = false
                    end
                end
                local v21 = v4:LoadAnimation(script.idl75)
                v21:Play()
                u6.Idle:Stop()
                u6.Idle = v21
                u6.Run:Stop()
                u6.Run = v4:LoadAnimation(script.walk75)
                if v12 == "Walk" or v12 == "Run" then
                    u6.Run:Play()
                end
            else
                v15 = v13
            end
        elseif v15 == "100" then
            for v22, _ in pairs(v14) do
                if v22 ~= nil then
                    v14[v22] = false
                end
            end
            local v23 = v4:LoadAnimation(script.idle100)
            local v24 = v4:LoadAnimation(script.walk100)
            local v25 = v4:LoadAnimation(script.walk100)
            u6.Idle:Stop()
            u6.Idle = v23
            u6.Run:Stop()
            u6.Run = v25
            u6.Walk:Stop()
            u6.Walk = v24
        else
            v15 = v13
        end
    else
        v15 = v13
    end
    u6.Walk.Priority = Enum.AnimationPriority.Movement
    u6.Run.Priority = Enum.AnimationPriority.Movement
    task.wait(0.1)
    v13 = v15
end