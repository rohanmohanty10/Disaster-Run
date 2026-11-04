 

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
        ["lunge"] = false,
        ["nado"] = false
    }
    return v9
end
function u6.CutlassLunge(p10, p11) --[[ Line: 28 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v12 = p10.Cooldowns
    local u13 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v12.lunge == false and _G.check:inspect(u13) == true then
        local v14 = u3.GetM("Cutlass Lunge")
        local v15 = v14.cd
        if _G.StamCheck("Cutlass Lunge") == false then
            return
        end
        if v14.statreq and _G.MeetReq(v14.statreq) == false then
            return
        end
        local u16 = u13.Humanoid.Animator:LoadAnimation(script.lunge)
        u16:Play()
        u16:AdjustWeight(2)
        v12.lunge = true
        _G.canuse = false
        _G.FaceMouse = true
        local v17 = game.ReplicatedStorage.Events.Skill:InvokeServer("Cutlass Lunge")
        _G.PauseAnim(u16, 0.47, 1.2)
        local u18 = tick()
        p10:ChargeSkill(p11, {
            ["Key"] = Enum.KeyCode.E,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 56 ]]
                --[[
                Upvalues:
                    [1] = u13
                    [2] = u16
                --]]
                if _G.check:inspect(u13) == false then
                    u16:Stop()
                    return true
                end
            end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 63 ]]
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
        _G.FaceMouse = false
        u16:AdjustSpeed(1)
        if v17 then
            if _G.check:inspect(u13) == true then
                u13.HumanoidRootPart.Anchored = true
                u13.Humanoid.AutoRotate = false
                local v19 = u13.HumanoidRootPart.CFrame
                local _, v20 = _G.raycast:cast(u13.HumanoidRootPart.CFrame.Position, v19.LookVector * 30, { workspace.Islands, workspace.Ships, workspace.Env })
                local v21 = (v19.Position - v20).Magnitude
                local v22 = v19 * CFrame.new(0, 0, -v21) * CFrame.new(0, u13.Humanoid.HipHeight * 1.25, 2)
                local v23 = script.Part:Clone()
                v23.Parent = workspace.Effects
                v23.CFrame = u13.HumanoidRootPart.CFrame * CFrame.new(0, 0, -8)
                _G.tween(u13.HumanoidRootPart, { 0.3, "Cubic", Enum.EasingDirection.Out }, {
                    ["CFrame"] = v22
                })
                _G.tween(v23, { 0.3, "Cubic", Enum.EasingDirection.Out }, {
                    ["CFrame"] = v22 * CFrame.new(0, 0, -8)
                })
                _G.PlayEffect("FloorTrail", nil, v23, 0.3, Color3.fromRGB(213, 104, 14), Color3.fromRGB(0, 0, 0), 0.3, 0.25, 15)
                _G.destroy(v23, 0.3)
                v17:FireServer({
                    ["cf"] = v22
                })
                task.wait(0.7)
            else
                v17:FireServer(nil)
            end
        end
        u13.Humanoid.AutoRotate = true
        u13.HumanoidRootPart.Anchored = false
        u13.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Cutlass Lunge", v15)
        _G.fw(v15)
        v12.lunge = false
    end
end
function u6.CutlassLadder(p24, p25) --[[ Line: 113 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v26 = p24.Cooldowns
    local u27 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v26.nado == false and _G.check:inspect(u27) == true then
        local v28 = u3.GetM("Cutlass Ladder")
        local v29 = v28.cd
        if _G.StamCheck("Cutlass Ladder") == false then
            return
        end
        if v28.statreq and _G.MeetReq(v28.statreq) == false then
            return
        end
        local v30 = u27.Humanoid.Animator:LoadAnimation(script.ladder)
        v30:Play()
        v30:AdjustWeight(2)
        v26.nado = true
        _G.canuse = false
        u27.Humanoid.WalkSpeed = 4
        local v31 = game.ReplicatedStorage.Events.Skill:InvokeServer("Cutlass Ladder")
        _G.PauseAnim(v30, 0.39, 1.2)
        local u32 = tick()
        p24:ChargeSkill(p25, {
            ["Key"] = Enum.KeyCode.R,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 140 ]]
                --[[
                Upvalues:
                    [1] = u27
                --]]
                u27.Humanoid.WalkSpeed = 4
            end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 149 ]]
                --[[
                Upvalues:
                    [1] = u27
                    [2] = u32
                --]]
                if u27:FindFirstChild(script.Name) == nil or tick() - u32 >= 10 then
                    return true
                end
            end
        })
        v30:AdjustSpeed(1)
        task.wait(0.13)
        local v33 = Instance.new("BodyVelocity", u27.HumanoidRootPart)
        v33.MaxForce = Vector3.new(0, 10000000, 0)
        v33.Velocity = u27.HumanoidRootPart.CFrame.upVector * 50
        _G.destroy(v33, 0.2)
        if v31 and _G.check:inspect(u27) == true then
            v31:FireServer(u27.HumanoidRootPart.CFrame)
        elseif v31 then
            v31:FireServer()
        end
        task.wait(0.5)
        u27.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Cutlass Ladder", v29)
        _G.fw(v29)
        v26.nado = false
    end
end
return u6