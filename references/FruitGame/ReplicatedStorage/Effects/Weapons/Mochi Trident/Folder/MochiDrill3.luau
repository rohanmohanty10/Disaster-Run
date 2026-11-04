 

local v1 = {}
game:GetService("Debris")
game:GetService("TweenService")
game:GetService("RunService")
local u2 = require(game.ReplicatedStorage.Modules.BoatTween)
Random.new()
local function u6(p3, p4) --[[ Line: 11 ]]
    for _, v5 in ipairs(p3:GetDescendants()) do
        if v5:IsA("ParticleEmitter") then
            v5.Enabled = p4
        end
    end
end
function v1.start(_, p7, p8, p9) --[[ Line: 31 ]]
    --[[
    Upvalues:
        [1] = u6
        [2] = u2
    --]]
    local v10 = p9.isMochiFruit
    local v11 = script
    if p8 ~= "Start" then
        if p8 == "Bash" then
            local u12 = p9.Target
            task.delay(p9.BashTime - workspace:GetServerTimeNow(), function() --[[ Line: 103 ]]
                --[[
                Upvalues:
                    [1] = u12
                --]]
                local v13 = script.Bash:Clone()
                v13.PrimaryPart.CFrame = u12.PrimaryPart.CFrame * CFrame.Angles(1.5707963267948966, 0, 0)
                v13.Parent = workspace.Effects
                _G.customEmit(v13)
                _G.destroy(v13, 4)
            end)
        end
        return
    end
    local v14 = Instance.new("Folder")
    v14.Parent = workspace.Effects
    local v15 = p7:WaitForChild("HumanoidRootPart")
    p7:WaitForChild("Humanoid")
    local v16
    if v10 then
        v16 = v11.StartupDough:Clone()
    else
        v16 = v11.Startup:Clone()
    end
    v16.CFrame = v15.CFrame
    v16.Parent = v14
    _G.customEmit(v16)
    local v17
    if v10 then
        v17 = v11.ArmVFXDough:Clone()
    else
        v17 = v11.ArmVFX:Clone()
    end
    v17.Weld.Part1 = p7:WaitForChild("RightLowerArm")
    v17.Parent = v14
    local v18
    if v10 then
        v18 = v11.BarrageDough:Clone()
    else
        v18 = v11.Barrage:Clone()
    end
    v18.CFrame = v15.CFrame * CFrame.new(0, 0, -8)
    v18.Parent = v14
    u6(v18, true)
    u6(v17, true)
    local v19 = tick()
    while true do
        if tick() - v19 >= 0.1 then
            local v20 = v11.mesh2:Clone()
            v18.CFrame = v15.CFrame * CFrame.new(0, 0, -8)
            v20.Parent = v14
            v20.CFrame = v15.CFrame * CFrame.new(0, 0, -2) * CFrame.Angles(1.5707963267948966, 0, 0)
            local v21 = {
                ["EasingStyle"] = "Sine",
                ["EasingDirection"] = "Out",
                ["Time"] = 0.12,
                ["Goal"] = {
                    ["Scale"] = Vector3.new(0, 25, 0)
                }
            }
            u2:Create(v20.Mesh, v21):Play()
            _G.destroy(v20, 0.14)
            v19 = tick()
        end
        if p9.BarrageEnd - workspace:GetServerTimeNow() <= 0 then
            u6(v18, false)
            u6(v17, false)
            _G.destroy(v14, 5)
            return
        end
        task.wait()
    end
end
return v1