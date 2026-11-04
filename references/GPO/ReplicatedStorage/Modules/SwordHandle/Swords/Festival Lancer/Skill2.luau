 

local v1 = {}
local u2, _, u3, _, _ = require(game.ReplicatedStorage.Modules.ScriptSet).get()
local u4 = nil
local u5 = {
    ["thrust"] = false,
    ["crash"] = false
}
require(game.ReplicatedStorage.Modules.RotatedRegion3)
local u6 = require(game.ReplicatedStorage.Modules.Skills)
local u7 = nil
function v1.setup(_, u8, u9) --[[ Line: 11 ]]
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
    u4 = u3.InputBegan:Connect(function(p11, p12) --[[ Line: 22 ]]
        --[[
        Upvalues:
            [1] = u9
            [2] = u8
            [3] = u5
            [4] = u6
            [5] = u3
        --]]
        if u9.Parent ~= u8 or (_G.canuse == false or p12 == true) then
            return
        end
        if p11.KeyCode == Enum.KeyCode.E and (u5.thrust == false and _G.check:inspect(u8) == true) then
            local v13 = u6.GetM("Festival Thrust")
            local v14 = v13.cd
            if _G.StamCheck("Festival Thrust") == false then
                return
            end
            if v13.statreq and _G.MeetReq(v13.statreq) == false then
                return
            end
            local v15 = u8.Humanoid.Animator:LoadAnimation(script.thrust)
            v15:Play()
            v15:AdjustWeight(4)
            v15:AdjustSpeed(1)
            u5.thrust = true
            _G.canuse = false
            u8.Humanoid.WalkSpeed = 4
            _G.FaceMouse = true
            local v16 = game.ReplicatedStorage.Events.Skill:InvokeServer("Festival Thrust")
            _G.PauseAnim(v15, 0.22, 1)
            local v17 = tick()
            while true do
                if _G.check:inspect(u8) == false then
                    v15:Stop()
                    break
                end
                _G.canuse = false
                game["Run Service"].Heartbeat:Wait()
                if u3:IsKeyDown(Enum.KeyCode.E) == false or (u9.Parent ~= u8 or tick() - v17 >= 10) then
                    break
                end
            end
            _G.FaceMouse = false
            v15:AdjustSpeed(1)
            if v16 then
                if _G.check:inspect(u8) == true then
                    u8.HumanoidRootPart.Anchored = true
                    u8.Humanoid.AutoRotate = false
                    local v18 = u8.HumanoidRootPart.CFrame
                    local _, v19 = _G.raycast:cast(u8.HumanoidRootPart.CFrame.p, (_G.MouseCF.p - u8.HumanoidRootPart.CFrame.p).unit * 20, { workspace.Islands, workspace.Ships, workspace.Env })
                    local v20 = (v18.p - v19).magnitude
                    v16:FireServer({
                        ["cf"] = v18 * CFrame.new(0, 0, -v20) * CFrame.new(0, u8.Humanoid.HipHeight * 1.25, 2)
                    })
                    task.wait(0.45)
                else
                    v16:FireServer(nil)
                end
            end
            u8.Humanoid.AutoRotate = true
            u8.HumanoidRootPart.Anchored = false
            u8.Humanoid.WalkSpeed = 16
            _G.canuse = true
            _G.keysetup:cooldown("Festival Thrust", v14)
            _G.fw(v14)
            u5.thrust = false
        elseif p11.KeyCode == Enum.KeyCode.R and (u5.crash == false and _G.check:inspect(u8) == true) then
            local v21 = u6.GetM("Festival Crash")
            local v22 = v21.cd
            if _G.StamCheck("Festival Crash") == false then
                return
            end
            if v21.statreq and _G.MeetReq(v21.statreq) == false then
                return
            end
            local u23 = u8.Humanoid.Animator:LoadAnimation(script.windup)
            u23:Play()
            u23:AdjustWeight(2)
            u23:AdjustSpeed(1)
            u5.crash = true
            _G.canuse = false
            u8.Humanoid.WalkSpeed = 4
            local u24 = game.ReplicatedStorage.Events.Skill:InvokeServer("Festival Crash")
            _G.PauseAnim(u23, 0.27, 1)
            local v25 = tick()
            while true do
                if _G.check:inspect(u8) == false then
                    u23:Stop()
                    break
                end
                u8.Humanoid.WalkSpeed = 4
                _G.canuse = false
                game["Run Service"].RenderStepped:Wait()
                if u3:IsKeyDown(Enum.KeyCode.R) == false or (u9.Parent ~= u8 or tick() - v25 >= 6) then
                    break
                end
            end
            u23:AdjustSpeed(2)
            local u26 = Instance.new("BodyVelocity", u8.HumanoidRootPart)
            u26.MaxForce = Vector3.new(100000, 0, 100000)
            u26.Velocity = u8.HumanoidRootPart.CFrame.lookVector * 100
            _G.destroy(u26, 0.15)
            if u24 then
                u24:FireServer("sfx")
            end
            local u27 = false
            local function v29(p28) --[[ Line: 126 ]]
                --[[
                Upvalues:
                    [1] = u26
                    [2] = u8
                    [3] = u24
                --]]
                u26:Destroy()
                u8.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
                if u24 then
                    u24:FireServer({
                        ["cf"] = u8.PrimaryPart.CFrame,
                        ["Target"] = p28.Parent
                    })
                end
            end
            local function v30() --[[ Line: 133 ]]
                --[[
                Upvalues:
                    [1] = u26
                    [2] = u27
                    [3] = u23
                --]]
                u26:Destroy()
                u27 = true
                u23:Stop()
            end
            _G.hitbox:start(u8, Vector3.new(8, 5, 12), 0.3, CFrame.new(0, 0, -3), v29, v30)
            warn("client finished")
            u8.Humanoid.WalkSpeed = 16
            _G.canuse = true
            _G.keysetup:cooldown("Festival Crash", v22)
            _G.fw(v22)
            u5.crash = false
        end
    end)
end
return v1