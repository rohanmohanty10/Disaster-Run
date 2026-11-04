 

local v1 = {}
local u2, _, u3, _, _ = require(game.ReplicatedStorage.Modules.ScriptSet).get()
local u4 = nil
local u5 = {
    ["spin"] = false,
    ["smash"] = false,
    ["Throw"] = false
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
    local u11 = game.ReplicatedStorage:FindFirstChild("Stats" .. u2.Name)
    u4 = u3.InputBegan:Connect(function(p12, p13) --[[ Line: 23 ]]
        --[[
        Upvalues:
            [1] = u9
            [2] = u8
            [3] = u5
            [4] = u6
            [5] = u11
        --]]
        if u9.Parent == u8 and (_G.canuse ~= false and p13 ~= true) then
            if p12.KeyCode == Enum.KeyCode.E and (u5.spin == false and _G.check:inspect(u8) == true) then
                local v14 = u6.GetM("Kiribachi Frenzy")
                local v15 = v14.cd
                if _G.StamCheck("Kiribachi Frenzy") == false then
                    return
                elseif not v14.statreq or _G.MeetReq(v14.statreq) ~= false then
                    local v16 = u8.Humanoid.Animator:LoadAnimation(script.windup)
                    v16:Play()
                    v16:AdjustWeight(2)
                    u5.spin = true
                    _G.canuse = false
                    _G.PauseAnim(v16, 0.4, 1)
                    v16:Stop()
                    local u17 = u8.Humanoid.Animator:LoadAnimation(script.loop)
                    u17:Play()
                    u17:AdjustSpeed(1)
                    local v18 = game.ReplicatedStorage.Events.Skill:InvokeServer("Kiribachi Frenzy")
                    local u19 = tick()
                    local u20 = Instance.new("BodyVelocity", u8.HumanoidRootPart)
                    u20.MaxForce = Vector3.new(1000000, 0, 1000000)
                    local function v21() --[[ Line: 54 ]]
                        --[[
                        Upvalues:
                            [1] = u8
                            [2] = u17
                            [3] = u20
                        --]]
                        if _G.check:inspect(u8) == false then
                            u17:Stop()
                            return true
                        end
                        u20.Velocity = u8.HumanoidRootPart.CFrame.lookVector * 30
                    end
                    local function v22() --[[ Line: 63 ]]
                        --[[
                        Upvalues:
                            [1] = u9
                            [2] = u8
                            [3] = u19
                            [4] = u11
                        --]]
                        if u9.Parent ~= u8 or (tick() - u19 >= 3 or (u8:FindFirstChild("Stun") or u11.Stamina.Value <= 0)) then
                            return true
                        end
                    end
                    _G.holdSkill(Enum.KeyCode.E, v21, v22)
                    u20:Destroy()
                    u17:Stop()
                    if v18 then
                        v18:FireServer()
                    end
                    u8.Humanoid.WalkSpeed = 16
                    _G.canuse = true
                    _G.keysetup:cooldown("Kiribachi Frenzy", v15)
                    _G.fw(v15)
                    u5.spin = false
                end
            else
                if p12.KeyCode == Enum.KeyCode.R and (u5.smash == false and _G.check:inspect(u8) == true) then
                    local v23 = u6.GetM("Kiribachi Smash")
                    local v24 = v23.cd
                    if _G.StamCheck("Kiribachi Smash") == false then
                        return
                    end
                    if v23.statreq and _G.MeetReq(v23.statreq) == false then
                        return
                    end
                    local u25 = u8.Humanoid.Animator:LoadAnimation(script.smash)
                    u25:Play()
                    u25:AdjustWeight(2)
                    u8.Humanoid.WalkSpeed = 4
                    u5.smash = true
                    _G.canuse = false
                    local v26 = game.ReplicatedStorage.Events.Skill:InvokeServer("Kiribachi Smash")
                    _G.PauseAnim(u25, 0.5, 1)
                    local function v27() --[[ Line: 103 ]]
                        --[[
                        Upvalues:
                            [1] = u8
                            [2] = u25
                        --]]
                        if _G.check:inspect(u8) == false then
                            u25:Stop()
                            return true
                        end
                        u8.Humanoid.WalkSpeed = 4
                    end
                    local function v28() --[[ Line: 111 ]]
                        --[[
                        Upvalues:
                            [1] = u9
                            [2] = u8
                        --]]
                        if u9.Parent ~= u8 then
                            return true
                        end
                    end
                    _G.holdSkill(Enum.KeyCode.R, v27, v28)
                    u25:AdjustSpeed(1)
                    if v26 then
                        v26:FireServer()
                    end
                    task.wait(0.15)
                    u8.Humanoid.WalkSpeed = 16
                    _G.canuse = true
                    _G.keysetup:cooldown("Kiribachi Smash", v24)
                    _G.fw(v24)
                    u5.smash = false
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