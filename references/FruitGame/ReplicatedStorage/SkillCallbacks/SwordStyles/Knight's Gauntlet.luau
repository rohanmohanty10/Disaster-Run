 

local u1 = game.Players.LocalPlayer
game:GetService("RunService")
local u2 = game:GetService("ReplicatedStorage")
local u3 = require(game.ReplicatedStorage.Modules.Skills)
local u4 = require(script.Parent.Parent.MobileBase)
local v5 = require(u1.PlayerScripts:WaitForChild("PlayerModule"))
u1:GetMouse()
v5:GetControls()
local u6 = setmetatable({}, u4)
u6.__index = u6
function u6.new(_) --[[ Line: 20 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u6
    --]]
    local v7 = u4.new(script.Name)
    local v8 = u6
    local v9 = setmetatable(v7, v8)
    v9.Cooldowns = {
        ["upper"] = false,
        ["slam"] = false
    }
    return v9
end
function u6.OverShoulderSlam(p10, p11) --[[ Line: 28 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v12 = p10.Cooldowns
    local u13 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v12.upper == false and _G.check:inspect(u13) == true then
        local v14 = u3.GetM("Over Shoulder Slam")
        local v15 = v14.cd
        if _G.StamCheck("Over Shoulder Slam") == false then
            return
        end
        if v14.statreq and _G.MeetReq(v14.statreq) == false then
            return
        end
        local v16 = u13.Humanoid.Animator:LoadAnimation(script.grab)
        v16:Play()
        v16:AdjustWeight(2)
        v12.upper = true
        _G.canuse = false
        u13.Humanoid.WalkSpeed = 8
        local v17 = game.ReplicatedStorage.Events.Skill:InvokeServer("Over Shoulder Slam")
        _G.PauseAnim(v16, 0.3, 1)
        local u18 = tick()
        p10:ChargeSkill(p11, {
            ["Key"] = Enum.KeyCode.E,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 54 ]]
                --[[
                Upvalues:
                    [1] = u13
                --]]
                u13.Humanoid.WalkSpeed = 8
            end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 59 ]]
                --[[
                Upvalues:
                    [1] = u13
                    [2] = u18
                --]]
                if u13:FindFirstChild(script.Name) == nil or tick() - u18 >= 10 then
                    return true
                end
            end
        })
        v16:AdjustSpeed(1)
        if v17 then
            v17:FireServer(u13.HumanoidRootPart.CFrame)
        end
        task.wait(0.75)
        u13.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Over Shoulder Slam", v15)
        _G.fw(v15)
        v12.upper = false
    end
end
function u6.GrandEntranceSlam(u19, p20) --[[ Line: 85 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v21 = u19.Cooldowns
    local u22 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v21.slam == false and _G.check:inspect(u22) == true then
        local v23 = u3.GetM("Grand Entrance Slam")
        local v24 = v23.cd
        if _G.StamCheck("Grand Entrance Slam") == false then
            return
        end
        if v23.statreq and _G.MeetReq(v23.statreq) == false then
            return
        end
        local u25 = u22.Humanoid.Animator:LoadAnimation(script.slamStart)
        u25:Play()
        u25:AdjustWeight(2)
        v21.slam = true
        _G.canuse = false
        u22.Humanoid.WalkSpeed = 4
        local v26 = game.ReplicatedStorage.Events.Skill:InvokeServer("Grand Entrance Slam")
        _G.PauseAnim(u25, 0.3, 1)
        local u27 = nil
        local u28 = nil
        local u29 = nil
        local u30 = u19:GetMouseCFrame()
        local u31 = 80
        local function v37() --[[ Line: 114 ]]
            --[[
            Upvalues:
                [1] = u22
                [2] = u25
                [3] = u30
                [4] = u19
                [5] = u31
                [6] = u27
                [7] = u28
                [8] = u29
            --]]
            if u22.Humanoid.SeatPart ~= nil then
                u25:Stop()
                return false
            end
            u30 = u19:GetMouseCFrame()
            local v32 = Ray.new(workspace.CurrentCamera.CFrame.Position, (workspace.CurrentCamera.CFrame.Position - u30.Position).unit * -(u31 + 75))
            local v33, v34 = _G.raycastWhitelist(v32, { workspace.Islands, workspace.Env, workspace.Ships })
            u27 = v33
            u28 = v34
            local v35, v36 = _G.getRayFloor(CFrame.new(u28), 2000)
            u27 = v35
            u28 = v36
            u29 = u22.HumanoidRootPart.CFrame.Position
            u22.Humanoid.WalkSpeed = 4
        end
        u19:ChargeSkill(p20, {
            ["Key"] = Enum.KeyCode.R,
            ["CheckFunction"] = v37,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 132 ]]
                --[[
                Upvalues:
                    [1] = u22
                --]]
                if u22:FindFirstChild(script.Name) == nil then
                    return true
                end
            end
        })
        v37()
        u25:AdjustSpeed(1)
        local v38 = u31
        u31 = math.clamp(v38, 0, 80)
        local u39 = false
        local v40 = u28 + Vector3.new(0, 2, 0)
        local u41 = (CFrame.new(u28, u22.HumanoidRootPart.Position) * CFrame.new(0, 0, 100)).Position
        local v42 = u22.Humanoid.Animator:LoadAnimation(script.slamLoop)
        v42:Play()
        local u43 = (v40 - u29 - Vector3.new(0, -98.1, 0)) / 1
        local u44 = 0
        local u45 = nil
        local u46 = nil
        local v47 = Instance.new("BoolValue", u22.HumanoidRootPart)
        v47.Name = "geppo"
        local v48 = Instance.new("BodyVelocity", u22.LowerTorso)
        v48.MaxForce = Vector3.new(inf, inf, inf)
        v48.Velocity = Vector3.new()
        if v26 then
            local v49 = {
                v40,
                u29,
                u41,
                v47
            }
            v26:FireServer("jump", u22.PrimaryPart.CFrame, v49)
        end
        local _ = game["Run Service"].Heartbeat:Connect(function(p50) --[[ Line: 174 ]]
            --[[
            Upvalues:
                [1] = u22
                [2] = u44
                [3] = u43
                [4] = u29
                [5] = u41
                [6] = u46
                [7] = u45
                [8] = u39
            --]]
            u22.HumanoidRootPart.CFrame = CFrame.new(CFrame.new(Vector3.new(0, -98.1, 0) * u44 * u44 + u43 * u44 + u29).Position, u41)
            local v51 = u44 + p50 * 1.5
            local v52 = CFrame.new(Vector3.new(0, -98.1, 0) * v51 * v51 + u43 * v51 + u29)
            local v53 = Ray.new(u22.HumanoidRootPart.CFrame.Position, (u22.HumanoidRootPart.CFrame.Position - v52.Position).unit * -(u22.HumanoidRootPart.CFrame.Position - v52.Position).Magnitude)
            local v54, v55 = _G.raycastWhitelist(v53, { workspace.Islands, workspace.Env, workspace.Ships })
            Ray.new(u22.HumanoidRootPart.CFrame.Position, (u22.HumanoidRootPart.CFrame.Position - v52.Position).unit * (u22.HumanoidRootPart.CFrame.Position - v52.Position).Magnitude / 2)
            if v54 then
                local v56 = u22.Humanoid.HipHeight * 1.5
                local v57 = v55 + Vector3.new(0, v56)
                local v58 = u22.HumanoidRootPart
                local v59 = CFrame.new
                local v60 = u41.x
                local v61 = v57.y
                local v62 = u41.z
                v58.CFrame = v59(v57, (Vector3.new(v60, v61, v62)))
                u46 = u22.HumanoidRootPart.CFrame
                u22.HumanoidRootPart.Anchored = true
                u45:Disconnect()
                u45 = nil
                u39 = true
            end
            u44 = u44 + p50 * 1.5
        end)
        repeat
            task.wait()
        until u39 == true
        v42:Stop()
        u22.Humanoid.PlatformStand = false
        if v26 then
            v26:FireServer(u22.PrimaryPart.CFrame)
        end
        v47:Destroy()
        u22.Humanoid.Animator:LoadAnimation(script.slamEnd):Play()
        task.wait(0.2)
        u22.HumanoidRootPart.Anchored = false
        v48:Destroy()
        u22.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Grand Entrance Slam", v24)
        _G.fw(v24)
        v21.slam = false
    end
end
return u6