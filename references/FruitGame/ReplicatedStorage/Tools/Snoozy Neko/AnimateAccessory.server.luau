 

local v1 = game:GetService("RunService")
game:GetService("Players")
require(script:WaitForChild("Spring"))
local v2 = Random.new()
local u3 = script.Parent
local u4 = u3:WaitForChild("HoverPetMiddlefake"):WaitForChild("RootPartWeld")
local v5 = u4:GetAttribute("C0Origin")
local u6 = v2:NextNumber(0, 1000)
local v7 = script.Parent:WaitForChild("AnimationController")
local v8 = v7:GetPlayingAnimationTracks()
for v9 = 1, #v8 do
    v8[v9]:Stop()
    v8[v9]:Destroy()
end
v7:LoadAnimation(script:WaitForChild("Animation")):Play()
local u10 = u3.PrimaryPart.CFrame
local u11 = false
local v12 = u3.Parent:WaitForChild("HumanoidRootPart")
local u13 = v5.Rotation + v5.Position * (v12.Size / Vector3.new(2, 2, 1))
local function v23(p14) --[[ Line: 33 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u11
        [3] = u6
        [4] = u4
        [5] = u13
        [6] = u10
    --]]
    local v15 = u3.PrimaryPart.CFrame
    if (workspace.Camera.CFrame.Position - v15.Position).Magnitude <= 100 then
        u11 = true
        local v16 = os.clock() * 2 + u6
        local v17 = Vector3.new(0, 1, 0) * math.sin(v16) * 0.5
        local v18 = CFrame.Angles
        local v19 = os.clock() * 2 + u6
        local v20 = v18(math.sin(v19) * 0.25 - 0.5235987755982988, 0, 0)
        local v21 = u4.Part0.CFrame * u13
        local v22 = v21 * v20 + v17
        if (v22.Position - u10.Position).Magnitude >= 100 then
            u10 = v22
        else
            u10 = u10:Lerp(v22, p14 * 10)
        end
        u4.C0 = u13 * v21:ToObjectSpace(u10)
    else
        if u11 then
            u11 = false
            u4.C0 = u13
        end
        u10 = v15
    end
end
v1.Heartbeat:Connect(v23)
task.defer(function() --[[ Line: 64 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    u3.Parent = workspace.Effects
end)