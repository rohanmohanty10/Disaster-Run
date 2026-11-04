 

local v1 = {}
local u2, _, u3, _, _ = require(game.ReplicatedStorage.Modules.ScriptSet).get()
local u4 = nil
local u5 = {
    ["lunge"] = false,
    ["nado"] = false
}
require(game.ReplicatedStorage.Modules.RotatedRegion3)
local u6 = require(game.ReplicatedStorage.Modules.Skills)
local u7 = nil
function v1.setup(_, u8, u9) --[[ Line: 12 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u7
        [3] = u5
        [4] = u2
        [5] = u3
        [6] = u6
    --]]
    if u4 then
        u4:Disconnect()
    end
    if u7 ~= u8 then
        for v10, _ in u5 do
            u5[v10] = false
        end
    end
    u7 = u8
    game.ReplicatedStorage:FindFirstChild("Stats" .. u2.Name)
    u4 = u3.InputBegan:Connect(function(p11, p12) --[[ Line: 23 ]]
        --[[
        Upvalues:
            [1] = u9
            [2] = u8
            [3] = u5
            [4] = u6
        --]]
        if u9.Parent == u8 and (_G.canuse ~= false and p12 ~= true) then
            if p11.KeyCode == Enum.KeyCode.E and (u5.lunge == false and _G.check:inspect(u8) == true) then
                local v13 = u6.GetM("Cutlass Lunge")
                local v14 = v13.cd
                if _G.StamCheck("Cutlass Lunge") == false then
                    return
                elseif not v13.statreq or _G.MeetReq(v13.statreq) ~= false then
                    local u15 = u8.Humanoid.Animator:LoadAnimation(script.lunge)
                    u15:Play()
                    u15:AdjustWeight(2)
                    u5.lunge = true
                    _G.canuse = false
                    _G.FaceMouse = true
                    local v16 = game.ReplicatedStorage.Events.Skill:InvokeServer("Cutlass Lunge")
                    _G.PauseAnim(u15, 0.47, 0.75)
                    local u17 = tick()
                    local function v18() --[[ Line: 48 ]]
                        --[[
                        Upvalues:
                            [1] = u8
                            [2] = u15
                        --]]
                        if _G.check:inspect(u8) == false then
                            u15:Stop()
                            return true
                        end
                    end
                    local function v19() --[[ Line: 55 ]]
                        --[[
                        Upvalues:
                            [1] = u9
                            [2] = u8
                            [3] = u17
                        --]]
                        if u9.Parent ~= u8 or tick() - u17 >= 10 then
                            return true
                        end
                    end
                    _G.holdSkill(Enum.KeyCode.E, v18, v19)
                    _G.FaceMouse = false
                    u15:AdjustSpeed(1)
                    if v16 then
                        if _G.check:inspect(u8) == true then
                            u8.HumanoidRootPart.Anchored = true
                            u8.Humanoid.AutoRotate = false
                            local v20 = u8.HumanoidRootPart.CFrame
                            local _, v21 = _G.raycast:cast(u8.HumanoidRootPart.CFrame.p, v20.lookVector * 30, { workspace.Islands, workspace.Ships, workspace.Env })
                            local v22 = (v20.p - v21).magnitude
                            local v23 = v20 * CFrame.new(0, 0, -v22) * CFrame.new(0, u8.Humanoid.HipHeight * 1.25, 2)
                            local v24 = script.Part:Clone()
                            v24.Parent = workspace.Effects
                            v24.CFrame = u8.HumanoidRootPart.CFrame * CFrame.new(0, 0, -8)
                            _G.tween(u8.HumanoidRootPart, { 0.3, "Cubic", Enum.EasingDirection.Out }, {
                                ["CFrame"] = v23
                            })
                            _G.tween(v24, { 0.3, "Cubic", Enum.EasingDirection.Out }, {
                                ["CFrame"] = v23 * CFrame.new(0, 0, -8)
                            })
                            _G.PlayEffect("FloorTrail", nil, v24, 0.3, Color3.fromRGB(213, 104, 14), Color3.fromRGB(0, 0, 0), 0.3, 0.25, 15)
                            _G.destroy(v24, 0.3)
                            v16:FireServer({
                                ["cf"] = v23
                            })
                            task.wait(0.7)
                        else
                            v16:FireServer(nil)
                        end
                    end
                    u8.Humanoid.AutoRotate = true
                    u8.HumanoidRootPart.Anchored = false
                    u8.Humanoid.WalkSpeed = 16
                    _G.canuse = true
                    _G.keysetup:cooldown("Cutlass Lunge", v14)
                    _G.fw(v14)
                    u5.lunge = false
                end
            else
                if p11.KeyCode == Enum.KeyCode.R and (u5.nado == false and _G.check:inspect(u8) == true) then
                    local v25 = u6.GetM("Cutlass Ladder")
                    local v26 = v25.cd
                    if _G.StamCheck("Cutlass Ladder") == false then
                        return
                    end
                    if v25.statreq and _G.MeetReq(v25.statreq) == false then
                        return
                    end
                    local u27 = u8.Humanoid.Animator:LoadAnimation(script.ladder)
                    u27:Play()
                    u27:AdjustWeight(2)
                    u5.nado = true
                    _G.canuse = false
                    u8.Humanoid.WalkSpeed = 4
                    local v28 = game.ReplicatedStorage.Events.Skill:InvokeServer("Cutlass Ladder")
                    _G.PauseAnim(u27, 0.39, 1.2)
                    local u29 = tick()
                    local function v30() --[[ Line: 119 ]]
                        --[[
                        Upvalues:
                            [1] = u8
                            [2] = u27
                        --]]
                        if _G.check:inspect(u8) == false then
                            u27:Stop()
                            return true
                        end
                        u8.Humanoid.WalkSpeed = 4
                    end
                    local function v31() --[[ Line: 128 ]]
                        --[[
                        Upvalues:
                            [1] = u9
                            [2] = u8
                            [3] = u29
                        --]]
                        if u9.Parent ~= u8 or tick() - u29 >= 10 then
                            return true
                        end
                    end
                    _G.holdSkill(Enum.KeyCode.R, v30, v31)
                    u27:AdjustSpeed(1)
                    task.wait(0.13)
                    local v32 = Instance.new("BodyVelocity", u8.HumanoidRootPart)
                    v32.MaxForce = Vector3.new(0, 10000000, 0)
                    v32.Velocity = u8.HumanoidRootPart.CFrame.upVector * 50
                    _G.destroy(v32, 0.2)
                    if v28 and _G.check:inspect(u8) == true then
                        v28:FireServer(u8.HumanoidRootPart.CFrame)
                    elseif v28 then
                        v28:FireServer()
                    end
                    task.wait(0.2)
                    u8.Humanoid.WalkSpeed = 16
                    _G.canuse = true
                    _G.keysetup:cooldown("Cutlass Ladder", v26)
                    _G.fw(v26)
                    u5.nado = false
                end
                return
            end
        else
            return
        end
    end)
    return weaponCallbacks
end
return v1