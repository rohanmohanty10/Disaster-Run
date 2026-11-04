 

local v1 = script:WaitForChild("Character").Value
if not v1 then
    script:Destroy()
    return
end
local v2 = workspace
local v3 = v1:WaitForChild("Humanoid", 5)
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
local v5 = game:GetService("ReplicatedStorage"):WaitForChild("NPCAnimations"):WaitForChild(script.Name)
local u6 = script:WaitForChild("Walkspeed").Value
local u7 = {
    ["Idle"] = v4:LoadAnimation(v5.Idle),
    ["Walk"] = v4:LoadAnimation(v5.Walk),
    ["Run"] = v4:LoadAnimation(v5.Walk)
}
u7.Idle.Priority = Enum.AnimationPriority.Idle
u7.Walk.Priority = Enum.AnimationPriority.Movement
u7.Run.Priority = Enum.AnimationPriority.Movement
local u8 = "Idle"
v3.Running:Connect(function(p9) --[[ Line: 46 ]]
    --[[
    Upvalues:
        [1] = u6
        [2] = u8
        [3] = u7
    --]]
    if u6 + 5 < p9 then
        if u8 ~= "Running" then
            u8 = "Running"
            for _, v10 in u7 do
                v10:Stop()
            end
            u7.Run:Play()
            u7.Run:AdjustSpeed(1.5)
            return
        end
    elseif p9 > 0.749 then
        if u8 ~= "Walking" then
            u8 = "Walking"
            for _, v11 in u7 do
                v11:Stop()
            end
            u7.Walk:Play()
            return
        end
    elseif u8 ~= "Idle" then
        u8 = "Idle"
        for _, v12 in u7 do
            v12:Stop()
        end
        u7.Idle:Play()
    end
end)
u7.Idle:Play()
local v13 = Random.new()
while true do
    repeat
        task.wait(v13:NextNumber(5, 15))
    until v1 and v1.PrimaryPart
    _G.PlaySound(v1.PrimaryPart, script.strawberrycakeSound1, {
        ["RandomPitch"] = true
    }).Parent = v1.PrimaryPart
end