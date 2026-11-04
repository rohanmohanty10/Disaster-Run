 

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
        ["wall"] = false,
        ["crash"] = false
    }
    return v9
end
function u6.FrostWall(p10, p11) --[[ Line: 28 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v12 = p10.Cooldowns
    local u13 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v12.wall == false and _G.check:inspect(u13) == true then
        local v14 = u3.GetM("Frost Wall")
        local v15 = v14.cd
        if _G.StamCheck("Frost Wall") == false then
            return
        end
        if v14.statreq and _G.MeetReq(v14.statreq) == false then
            return
        end
        local u16 = u13.Humanoid.Animator:LoadAnimation(script.wallSummon)
        u16:Play()
        u16:AdjustWeight(4)
        u16:AdjustSpeed(1)
        v12.wall = true
        _G.canuse = false
        _G.FaceMouse = true
        _G.PauseAnim(u16, 0.22, 1)
        local u17 = tick()
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
            ["EndFunction"] = function() --[[ Name: endFunction, Line 64 ]]
                --[[
                Upvalues:
                    [1] = u13
                    [2] = u17
                --]]
                if u13:FindFirstChild(script.Name) == nil or tick() - u17 >= 10 then
                    return true
                end
            end
        })
        u16:AdjustSpeed(2)
        u13.HumanoidRootPart.Anchored = true
        _G.FaceMouse = false
        task.wait(0.1)
        game.ReplicatedStorage.Events.Skill:InvokeServer("Frost Wall", p10:GetMouseCFrame())
        task.wait(0.35)
        u13.Humanoid.AutoRotate = true
        u13.HumanoidRootPart.Anchored = false
        u13.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Frost Wall", v15)
        _G.fw(v15)
        v12.wall = false
    end
end
function u6.FestivalCrash(p18, p19) --[[ Line: 96 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v20 = p18.Cooldowns
    local u21 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v20.crash == false and _G.check:inspect(u21) == true then
        local v22 = u3.GetM("Festival Crash")
        local v23 = v22.cd
        if _G.StamCheck("Festival Crash") == false then
            return
        end
        if v22.statreq and _G.MeetReq(v22.statreq) == false then
            return
        end
        local u24 = u21.Humanoid.Animator:LoadAnimation(script.windup)
        u24:Play()
        u24:AdjustWeight(2)
        u24:AdjustSpeed(1)
        v20.crash = true
        _G.canuse = false
        u21.Humanoid.WalkSpeed = 4
        local u25 = game.ReplicatedStorage.Events.Skill:InvokeServer("Festival Crash")
        _G.PauseAnim(u24, 0.27, 1)
        local u26 = tick()
        p18:ChargeSkill(p19, {
            ["Key"] = Enum.KeyCode.R,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 124 ]]
                --[[
                Upvalues:
                    [1] = u21
                    [2] = u24
                --]]
                if _G.check:inspect(u21) == false then
                    u24:Stop()
                    return true
                end
                u21.Humanoid.WalkSpeed = 4
            end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 133 ]]
                --[[
                Upvalues:
                    [1] = u21
                    [2] = u26
                --]]
                if u21:FindFirstChild(script.Name) == nil or tick() - u26 >= 6 then
                    return true
                end
            end
        })
        u24:AdjustSpeed(2)
        local u27 = Instance.new("BodyVelocity", u21.HumanoidRootPart)
        u27.MaxForce = Vector3.new(100000, 0, 100000)
        u27.Velocity = u21.HumanoidRootPart.CFrame.LookVector * 100
        _G.destroy(u27, 0.15)
        if u25 then
            u25:FireServer("sfx")
        end
        local u28 = false
        local function v29() --[[ Line: 161 ]]
            --[[
            Upvalues:
                [1] = u27
                [2] = u28
                [3] = u24
            --]]
            u27:Destroy()
            u28 = true
            u24:Stop()
        end
        _G.hitbox:start(u21, Vector3.new(8, 5, 12), 0.3, CFrame.new(0, 0, -3), function(p30) --[[ Name: hitfound, Line 154 ]]
            --[[
            Upvalues:
                [1] = u27
                [2] = u21
                [3] = u25
            --]]
            u27:Destroy()
            u21.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
            if u25 then
                u25:FireServer({
                    ["cf"] = u21.PrimaryPart.CFrame,
                    ["Target"] = p30.Parent
                })
            end
        end, v29)
        warn("client finished")
        u21.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Festival Crash", v23)
        _G.fw(v23)
        v20.crash = false
    end
end
return u6