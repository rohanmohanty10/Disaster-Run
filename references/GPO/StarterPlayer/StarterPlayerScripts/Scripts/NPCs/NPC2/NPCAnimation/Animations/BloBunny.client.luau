 

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
local v5 = game:GetService("ReplicatedStorage"):WaitForChild("NPCAnimations"):WaitForChild("Blo")
local _ = script:WaitForChild("Walkspeed").Value
local u6 = {
    ["Idle"] = v4:LoadAnimation(v5.Idle),
    ["Walk"] = v4:LoadAnimation(v5.Walk),
    ["Run"] = v4:LoadAnimation(v5.Walk)
}
u6.Idle.Priority = Enum.AnimationPriority.Idle
local u7 = u1:WaitForChild("Info", 3)
local v8 = 0
local u9 = v8
for _, v10 in pairs(u6) do
    v10.Priority = Enum.AnimationPriority.Action3
    v10:GetMarkerReachedSignal("Jump"):Connect(function() --[[ Line: 35 ]]
        --[[
        Upvalues:
            [1] = u9
            [2] = u7
            [3] = u1
        --]]
        u9 = u9 + 1
        if u9 > 3 then
            u9 = 1
        end
        if u7 and u7.Target.Value ~= nil then
            _G.PlaySound(u1.PrimaryPart, script["EasterBunnyAgroJump" .. u9]).Parent = u1.PrimaryPart
        else
            _G.PlaySound(u1.PrimaryPart, script["EasterBunnyIdleJump" .. u9]).Parent = u1.PrimaryPart
        end
    end)
end
local u11 = {}
local u12 = "Idle"
local function u15(p13) --[[ Line: 63 ]]
    --[[
    Upvalues:
        [1] = u6
        [2] = u11
    --]]
    for _, v14 in u6 do
        if v14.IsPlaying == true and v14 ~= p13 then
            u11[v14] = v14.TimePosition
            v14:Stop()
        end
    end
end
v3.Running:Connect(function(p16) --[[ Line: 83 ]]
    --[[
    Upvalues:
        [1] = u12
        [2] = u15
        [3] = u6
    --]]
    if p16 > 2 then
        if u12 ~= "Running" then
            u12 = "Running"
            u15()
            u6.Run:Play()
            return
        end
    elseif u12 ~= "Idle" then
        u12 = "Idle"
        u15()
        u6.Idle:Play()
    end
end)
if u7 then
    u7.Target.Changed:Connect(function() --[[ Line: 101 ]]
        --[[
        Upvalues:
            [1] = u7
            [2] = u15
            [3] = u6
            [4] = u11
        --]]
        if u7.Target.Value == nil then
            u15(u6.Idle)
            local v17 = u6.Idle
            if v17 and v17.IsPlaying == false then
                v17:Play()
                if u11[v17] then
                    v17.TimePosition = u11[v17]
                end
            end
        end
    end)
end
u6.Idle:Play()
while true do
    repeat
        task.wait(math.random(5, 10))
    until not u1:GetAttribute("EndVoice") or workspace:GetServerTimeNow() >= u1:GetAttribute("EndVoice")
    _G.PlaySound(u1.PrimaryPart, script["EasterBunnyIdleVoice" .. math.random(1, 3)])
end