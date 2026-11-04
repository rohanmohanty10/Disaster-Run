 

local v1 = {}
local u2 = game:GetService("Debris")
game:GetService("TweenService")
game:GetService("RunService")
local u3 = require(game.ReplicatedStorage.Modules.BoatTween)
Random.new()
local function u7(p4, p5) --[[ Line: 11 ]]
    for _, v6 in ipairs(p4:GetDescendants()) do
        if v6:IsA("ParticleEmitter") then
            v6.Enabled = p5
        end
    end
end
function v1.start(_, u8, p9, p10) --[[ Line: 31 ]]
    --[[
    Upvalues:
        [1] = u7
        [2] = u3
        [3] = u2
    --]]
    local v11 = p10.isMochiFruit
    local u12 = script
    if p9 == "Start" then
        local u13 = Instance.new("Folder")
        u13.Parent = workspace.Effects
        local u14 = u8:WaitForChild("HumanoidRootPart")
        local v15 = u8:WaitForChild("Humanoid")
        local u16
        if v11 then
            u16 = u12.StartupDough:Clone()
        else
            u16 = u12.Startup:Clone()
        end
        local u17
        if v11 then
            u17 = u12.BarrageDough:Clone()
        else
            u17 = u12.Barrage:Clone()
        end
        local u18
        if v11 then
            u18 = u12.ArmVFXDough:Clone()
        else
            u18 = u12.ArmVFX:Clone()
        end
        local u19 = nil
        local v23 = {
            ["Startup"] = function() --[[ Line: 59 ]]
                --[[
                Upvalues:
                    [1] = u16
                    [2] = u13
                    [3] = u18
                    [4] = u14
                    [5] = u8
                --]]
                u16.Parent = u13
                u18.Parent = u13
                u16.CFrame = u14.CFrame
                u18.Weld.Part1 = u8:WaitForChild("RightLowerArm")
                u14.Anchored = false
                _G.customEmit(u16)
                _G.customEmit(u8)
            end,
            ["Barrage"] = function() --[[ Line: 72 ]]
                --[[
                Upvalues:
                    [1] = u17
                    [2] = u13
                    [3] = u7
                    [4] = u18
                    [5] = u8
                    [6] = u12
                    [7] = u14
                    [8] = u3
                    [9] = u2
                    [10] = u19
                --]]
                u17.Parent = u13
                u7(u17, true)
                u7(u18, true)
                local v20 = tick()
                while true do
                    local _ = tick() - v20
                    if u8:GetAttribute("MochiTridentDrillHold") == nil then
                        break
                    end
                    local v21 = u12.mesh2:Clone()
                    u17.CFrame = u14.CFrame * CFrame.new(0, 0, -8)
                    v21.Parent = u13
                    v21.CFrame = u14.CFrame * CFrame.new(0, 0, -2) * CFrame.Angles(1.5707963267948966, 0, 0)
                    local v22 = {
                        ["EasingStyle"] = "Sine",
                        ["EasingDirection"] = "Out",
                        ["Time"] = 0.12,
                        ["Goal"] = {
                            ["Scale"] = Vector3.new(0, 25, 0)
                        }
                    }
                    u3:Create(v21.Mesh, v22):Play()
                    u2:AddItem(v21, 0.14)
                    task.wait(0.1)
                end
                u7(u17, false)
                u7(u18, false)
                u19:Stop()
            end
        }
        u19 = v15:LoadAnimation(script.Anims.Player)
        u19:Play()
        for v24, v25 in pairs({
            ["Startup"] = 0.15,
            ["Barrage"] = 0.45
        }) do
            local v26 = v23[v24]
            if v26 then
                task.delay(v25, v26)
            end
        end
    end
end
return v1