 

local v1 = script.Parent
if not v1:IsA("Actor") then
    warn("ActorScript Parent wasn\'t an Actor: " .. script:GetFullName())
    return
end
local v2 = v1.Event
local v3 = game:FindService("Players")
local u4 = game:FindService("RunService")
local v5 = game:FindService("ReplicatedStorage")
local u6 = v3.LocalPlayer or v3.PlayerAdded:Wait()
local v7 = nil
for _, v8 in { v5, u6:WaitForChild("PlayerScripts") } do
    local v9 = v8:FindFirstChild("SmartBone", true)
    if v9 and v9:IsA("ModuleScript") then
        v7 = v9
        break
    end
end
if v7 then
    local v10 = v7:WaitForChild("Dependencies")
    local v11 = require(v10:WaitForChild("Config"))
    local u12 = require(v7)
    local u13 = require(v10:WaitForChild("CameraUtil"))
    local _ = v11.Debug
    local u14 = os.clock
    local u15 = u14()
    local u16 = 60
    local u17 = {}
    local u18 = v5:WaitForChild("Stats" .. game.Players.LocalPlayer.Name):WaitForChild("Settings"):WaitForChild("AnimatedHats")
    local u19 = false
    local function u27() --[[ Line: 67 ]]
        --[[
        Upvalues:
            [1] = u14
            [2] = u17
            [3] = u16
            [4] = u15
        --]]
        local v20 = u14()
        for v21 = #u17, 1, -1 do
            local v22 = u17
            local v23 = v21 + 1
            local v24
            if u17[v21] >= v20 - 1 then
                v24 = u17[v21] or nil
            else
                v24 = nil
            end
            v22[v23] = v24
        end
        u17[1] = v20
        local v25 = u14() - u15 >= 1 and #u17 or #u17 / (u14() - u15)
        u16 = math.floor(v25)
        local v26 = (u16 * (1 / u16) ^ 2 + 0.001) * 1000 + 0.5
        return math.floor(v26) / 1000
    end
    function v2.OnInvoke(p28, p29) --[[ Line: 179 ]]
        --[[
        Upvalues:
            [1] = u19
            [2] = u6
            [3] = u12
            [4] = u4
            [5] = u27
            [6] = u18
            [7] = u13
        --]]
        u19 = p28:IsDescendantOf(u6.Character)
        local u30 = u12.new(p28, p29)
        local u31 = 0
        local u32 = false
        u30.SimulationConnection = u4.Heartbeat:ConnectParallel(function(_) --[[ Line: 86 ]]
            --[[
            Upvalues:
                [1] = u27
                [2] = u18
                [3] = u19
                [4] = u32
                [5] = u30
                [6] = u31
                [7] = u13
            --]]
            local v33 = u27()
            if workspace:GetAttribute("LowFXMode") or (workspace:GetAttribute("NoClothingPhysics") or (u18.Value == false or u19 == false)) then
                if not u32 then
                    u32 = true
                    u30.InRange = false
                    for _, v34 in u30.ParticleTrees do
                        u30:ResetParticles(v34)
                    end
                    task.synchronize()
                    for _, v35 in u30.ParticleTrees do
                        u30:ResetTransforms(v35, v33)
                    end
                    task.desynchronize()
                end
            else
                u31 = u31 + v33
                local v36 = workspace.CurrentCamera.CFrame.Position
                local v37 = u30.RootPart.Position
                local v38 = u30.Settings.ThrottleDistance
                local v39 = (v36 - v37).Magnitude
                local v40 = u30.Settings.ActivationDistance
                local v41 = v39 - v38
                local v42 = math.clamp(v41, 0, v40) / v40
                local v43 = (1 - math.clamp(v42, 0, 1)) * u30.Settings.UpdateRate
                local v44 = u30.Settings.UpdateRate
                local v45 = math.clamp(v43, 1, v44)
                local v46 = math.floor(v45)
                local v47 = u13.WithinViewport(u30.RootPart)
                if u31 >= 1 / v46 then
                    if u32 then
                        u32 = false
                    end
                    if v39 < v40 and v47 then
                        local v48 = u31
                        u31 = 0
                        debug.profilebegin("SmartBone")
                        if not u30.InRange then
                            u30.InRange = true
                        end
                        u30:UpdateBones(v48, v46)
                        debug.profileend()
                        task.synchronize()
                        debug.profilebegin("SmartBoneTransform")
                        for _, v49 in u30.ParticleTrees do
                            u30:TransformBones(v49, v48)
                        end
                        debug.profileend()
                        task.desynchronize()
                        return
                    end
                    if u30.InRange then
                        u30.InRange = false
                        for _, v50 in u30.ParticleTrees do
                            u30:ResetParticles(v50)
                        end
                        task.synchronize()
                        for _, v51 in u30.ParticleTrees do
                            u30:ResetTransforms(v51, v33)
                        end
                        task.desynchronize()
                    end
                end
                return
            end
        end)
        return u30
    end
else
    warn("SmartBone was not found!")
end