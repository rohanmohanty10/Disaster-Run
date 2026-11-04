 

local u1 = game.Players.LocalPlayer
game:GetService("RunService")
local u2 = game:GetService("ReplicatedStorage")
local u3 = require(game.ReplicatedStorage.Modules.Skills)
local u4 = require(script.Parent.Parent.MobileBase)
local v5 = require(u1.PlayerScripts:WaitForChild("PlayerModule"))
u1:GetMouse()
local u6 = v5:GetControls()
local u7 = setmetatable({}, u4)
u7.__index = u7
function u7.new(_) --[[ Line: 20 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u7
    --]]
    local v8 = u4.new(script.Name)
    local v9 = u7
    local v10 = setmetatable(v8, v9)
    v10.Cooldowns = {
        ["slash"] = false,
        ["triple"] = false
    }
    return v10
end
function u7.CrescentSlash(p11, p12) --[[ Line: 28 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v13 = p11.Cooldowns
    local u14 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v13.slash == false and _G.check:inspect(u14) == true then
        local v15 = u3.GetM("Crescent Slash")
        local v16 = v15.cd
        if _G.StamCheck("Crescent Slash") == false then
            return
        end
        if v15.statreq and _G.MeetReq(v15.statreq) == false then
            return
        end
        local v17 = u14.Humanoid.Animator:LoadAnimation(script.slash)
        v17:Play()
        v17:AdjustWeight(2)
        v13.slash = true
        _G.FaceMouse = true
        _G.canuse = false
        local v18 = game.ReplicatedStorage.Events.Skill:InvokeServer("Crescent Slash")
        _G.PauseAnim(v17, 0.4, 2)
        local u19 = tick()
        p11:ChargeSkill(p12, {
            ["Key"] = Enum.KeyCode.E,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 55 ]]
                --[[
                Upvalues:
                    [1] = u14
                --]]
                u14.Humanoid.AutoRotate = false
            end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 60 ]]
                --[[
                Upvalues:
                    [1] = u14
                    [2] = u19
                --]]
                if u14:FindFirstChild(script.Name) == nil or tick() - u19 >= 10 then
                    return true
                end
            end
        })
        v17:AdjustSpeed(1)
        task.wait(0.15)
        _G.FaceMouse = false
        u14.HumanoidRootPart.Anchored = true
        u14.Humanoid.AutoRotate = false
        if v18 then
            v18:FireServer(u14.PrimaryPart.CFrame)
        end
        v17:AdjustSpeed(1)
        task.wait(0.35)
        u14.Humanoid.AutoRotate = true
        u14.HumanoidRootPart.Anchored = false
        u14.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Crescent Slash", v16)
        _G.fw(v16)
        v13.slash = false
    end
end
function u7.TripleRipple(p20, p21) --[[ Line: 95 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
        [4] = u6
    --]]
    local v22 = p20.Cooldowns
    local u23 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v22.triple == false and _G.check:inspect(u23) == true then
        local v24 = u3.GetM("Triple Ripple")
        local v25 = v24.cd
        if _G.StamCheck("Triple Ripple") == false then
            return
        end
        if v24.statreq and _G.MeetReq(v24.statreq) == false then
            return
        end
        local v26 = u23.Humanoid.Animator:LoadAnimation(script.triple)
        v26:Play()
        v26:AdjustWeight(2)
        v22.triple = true
        _G.canuse = false
        u23.Humanoid.WalkSpeed = 4
        local u27 = game.ReplicatedStorage.Events.Skill:InvokeServer("Triple Ripple")
        _G.PauseAnim(v26, 0.35, 1)
        local u28 = tick()
        p20:ChargeSkill(p21, {
            ["Key"] = Enum.KeyCode.R,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 123 ]]
                --[[
                Upvalues:
                    [1] = u23
                --]]
                u23.Humanoid.WalkSpeed = 4
            end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 127 ]]
                --[[
                Upvalues:
                    [1] = u23
                    [2] = u28
                --]]
                if u23:FindFirstChild(script.Name) == nil or tick() - u28 >= 10 then
                    return true
                end
            end
        })
        v26:AdjustSpeed(1)
        if u27 then
            local u29 = Instance.new("BodyVelocity")
            u29.Velocity = Vector3.new(0, 0, 0)
            u29.MaxForce = Vector3.new(100000000000, 100000000000, 100000000000)
            u29.Parent = u23.HumanoidRootPart
            local u30 = 0
            local u31 = game:GetService("UserInputService")
            local u32 = { 0, 0.15, 0.48 }
            local u33 = 1
            u27:FireServer("start", u23.PrimaryPart.CFrame)
            local u42 = game["Run Service"].RenderStepped:Connect(function(p34) --[[ Line: 158 ]]
                --[[
                Upvalues:
                    [1] = u30
                    [2] = u31
                    [3] = u6
                    [4] = u23
                    [5] = u29
                    [6] = u33
                    [7] = u32
                    [8] = u27
                --]]
                u30 = u30 + p34
                if u31.MouseBehavior == Enum.MouseBehavior.LockCenter then
                    local v35 = workspace.CurrentCamera.CFrame
                    local v36 = u6:GetMoveVector()
                    local v37 = v35.RightVector * v36.X + v35.LookVector * -v36.Z
                    local v38
                    if v37.Magnitude > 0 then
                        v38 = v37.Unit
                    else
                        v38 = v35.LookVector
                    end
                    local v39 = u23.Humanoid.FloorMaterial == Enum.Material.Air
                    if v38.Y < 0 and not v39 then
                        local v40 = v38.X
                        local v41 = v38.Z
                        v38 = Vector3.new(v40, 0, v41)
                        if v38.Magnitude > 0 then
                            v38 = v38.Unit
                        end
                    end
                    u29.Velocity = v38 * 40
                else
                    u29.Velocity = u23.PrimaryPart.CFrame.LookVector * 40
                end
                if u33 <= #u32 and u30 >= u32[u33] then
                    u27:FireServer("slash", u23.PrimaryPart.CFrame)
                    u33 = u33 + 1
                end
            end)
            task.delay(0.6, function() --[[ Line: 194 ]]
                --[[
                Upvalues:
                    [1] = u42
                    [2] = u29
                --]]
                u42:Disconnect()
                u29:Destroy()
            end)
        end
        task.wait(0.3)
        u23.Humanoid.AutoRotate = true
        u23.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Triple Ripple", v25)
        _G.fw(v25)
        v22.triple = false
    end
end
return u7