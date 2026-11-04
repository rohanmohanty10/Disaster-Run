 

local v1 = game:GetService("Players")
local u2 = game:GetService("CollectionService")
local v3 = game:GetService("ReplicatedStorage")
local v4 = game:GetService("RunService")
local u5 = false
v3:WaitForChild("Events"):WaitForChild("FallDmg")
if not v1.LocalPlayer then
    v1.PlayerAdded:Wait()
end
local v6 = v1.LocalPlayer
local u7 = v6.Character or v6.CharacterAdded:Wait()
local u8 = u7:WaitForChild("Humanoid", 10)
if u8 and u8.Health > 0 then
    local _ = u8:WaitForChild("Animator", 10) or u8
    local u9 = u7:WaitForChild("HumanoidRootPart", 10)
    if u9 then
        if _G.isCustomHUB ~= true then
            Random.new()
            local u10 = 0
            local u11 = 0
            local u12 = Enum.HumanoidStateType.Jumping
            local u13 = Enum.HumanoidStateType.Landed
            local u14 = Enum.HumanoidStateType.Freefall
            v3:WaitForChild("LandAnimation")
            local v15 = Instance.new("Sound")
            v15.SoundId = "rbxassetid://147397876"
            v15.Name = "HurtSoundDamage"
            v15.Parent = u9
            local v16 = Instance.new("Sound")
            v16.SoundId = "rbxassetid://1161221108"
            v16.Name = "LandingSFX"
            v16.Volume = 0.25
            v16.Parent = u9
            local v17 = RaycastParams.new()
            v17.FilterType = Enum.RaycastFilterType.Include
            v17.RespectCanCollide = true
            v17.IgnoreWater = false
            v17.FilterDescendantsInstances = { workspace:WaitForChild("Env"), workspace:WaitForChild("Islands"), workspace:WaitForChild("Ships") }
            local u18 = 0
            local u19 = u8.HipHeight
            local v20 = -(u19 * 2)
            local u21 = Vector3.new(0, v20, 0)
            u8:GetPropertyChangedSignal("HipHeight"):Connect(function() --[[ Line: 60 ]]
                --[[
                Upvalues:
                    [1] = u19
                    [2] = u8
                    [3] = u21
                --]]
                u19 = u8.HipHeight
                local v22 = -(u19 * 2)
                u21 = Vector3.new(0, v22, 0)
            end)
            local function v33(p23, _) --[[ Line: 65 ]]
                --[[
                Upvalues:
                    [1] = u5
                    [2] = u9
                    [3] = u18
                    [4] = u7
                    [5] = u2
                    [6] = u8
                --]]
                if p23 and not u5 then
                    local v24 = u9:FindFirstAncestorWhichIsA("AlignPosition")
                    if v24 and v24.Enabled then
                        return
                    end
                    if u9:FindFirstChild("geppo") then
                        return
                    end
                    if _G.canuse == false then
                        return
                    end
                    u5 = true
                    local v25 = u9.Position.Y
                    tick()
                    local function v28() --[[ Line: 83 ]]
                        --[[
                        Upvalues:
                            [1] = u9
                            [2] = u18
                            [3] = u7
                            [4] = u2
                            [5] = u8
                        --]]
                        local v26 = u9:FindFirstAncestorWhichIsA("AlignPosition")
                        local v27 = (not v26 or v26.Enabled ~= true) and true or false
                        if u9:FindFirstChild("geppo") then
                            v27 = false
                            u18 = tick()
                        end
                        if u7.LowerTorso:FindFirstChild("geppo") then
                            v27 = false
                            u18 = tick()
                        end
                        if u7:FindFirstChild("SafeFF") then
                            v27 = false
                        end
                        if u2:HasTag(u7, "AirBypass") then
                            v27 = false
                            u18 = tick()
                        end
                        if _G.swimming then
                            v27 = false
                        end
                        if u8.SeatPart then
                            v27 = false
                        end
                        if u7:GetAttribute("FlyBypass") ~= nil then
                            v27 = false
                            u18 = tick()
                        end
                        if u8.SeatPart ~= nil then
                            v27 = false
                        end
                        if tick() - u18 < 3 then
                            v27 = false
                        end
                        return v27
                    end
                    while true do
                        if u5 ~= true then
                            v29 = v25
                            break
                        end
                        local v29 = u9.Position.Y
                        if v25 < v29 then
                            tick()
                        else
                            v29 = v25
                        end
                        if v28() == false then
                            break
                        end
                        task.wait()
                        v25 = v29
                    end
                    local v30 = u9:FindFirstAncestorWhichIsA("AlignPosition")
                    if v28() == true then
                        if v30 and v30.Enabled then
                            return
                        end
                        local v31 = u9.Position.Y - v29
                        local v32 = math.abs(v31) / 1.5
                        if u9:FindFirstChild("rolling") then
                            local _ = v32 / 2
                            return
                        end
                    end
                elseif not p23 then
                    u5 = false
                end
            end
            u8.StateChanged:Connect(function(_, p34) --[[ Line: 160 ]]
                --[[
                Upvalues:
                    [1] = u13
                    [2] = u10
                    [3] = u11
                    [4] = u9
                    [5] = u8
                    [6] = u12
                    [7] = u14
                --]]
                if p34 == u13 and (tick() - u10 >= 1 and u11 - u9.Position.Y >= 10) then
                    local v35
                    if u8:GetStateEnabled(u12) then
                        u8:SetStateEnabled(u12, false)
                        v35 = true
                    else
                        v35 = false
                    end
                    u10 = tick()
                    task.wait(0.5)
                    if v35 then
                        u8:SetStateEnabled(u12, true)
                        return
                    end
                elseif p34 == u14 then
                    u11 = u9.Position.Y
                end
            end)
            local v36 = Enum.Material.Air
            local v37 = u21
            local v38 = 0
            while u8.Health > 0 and u7.Parent do
                if u8.FloorMaterial == v36 then
                    v38 = v38 + 1
                    if v38 < 3 then
                        v4.Stepped:Wait()
                    else
                        v38 = 0
                        local v39 = workspace:Raycast(u9.Position, v37, v17)
                        if (not v39 or v39 and not v39.Instance) and not u9.Anchored then
                            task.spawn(v33, true)
                            while true do
                                task.wait()
                                if u8.FloorMaterial ~= v36 or u9.Anchored then
                                    break
                                end
                                local v40 = workspace:Raycast(u9.Position, v37, v17)
                                if v40 and (v40.Instance and v40.Instance.CanCollide) then
                                    break
                                end
                            end
                            local _ = false
                        end
                        v4.Stepped:Wait()
                    end
                else
                    v4.Stepped:Wait()
                    v38 = 0
                end
            end
        end
    else
        return
    end
else
    return
end