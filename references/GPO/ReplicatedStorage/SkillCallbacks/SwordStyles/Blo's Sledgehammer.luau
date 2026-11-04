 

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
        ["smash"] = false,
        ["spin"] = false
    }
    return v9
end
function u6.EggsplosiveRift(p10, p11) --[[ Line: 28 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v12 = p10.Cooldowns
    local u13 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v12.smash == false and _G.check:inspect(u13) == true then
        local v14 = u3.GetM("Eggsplosive Rift")
        local v15 = v14.cd
        if _G.StamCheck("Eggsplosive Rift") == false then
            return
        end
        if v14.statreq and _G.MeetReq(v14.statreq) == false then
            return
        end
        _G.FaceMouse = true
        _G.mouseLevel = true
        _G.canuse = false
        v12.smash = true
        local v16 = game.ReplicatedStorage.Events.Skill:InvokeServer("Eggsplosive Rift")
        local u17 = u13.Humanoid.Animator:LoadAnimation(script.smash)
        u17:Play()
        u17:AdjustWeight(2)
        _G.PauseAnim(u17, 0.48, 1)
        p10:ChargeSkill(p11, {
            ["Key"] = Enum.KeyCode.E,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 57 ]] end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 62 ]]
                --[[
                Upvalues:
                    [1] = u13
                    [2] = u17
                --]]
                if u13:FindFirstChild(script.Name) == nil then
                    return true
                end
                if _G.check:inspect(u13) == false then
                    u17:Stop()
                    return true
                end
            end
        })
        u17:AdjustSpeed(1)
        u13.PrimaryPart.Anchored = true
        _G.FaceMouse = false
        _G.mouseLevel = nil
        if v16 then
            local v18 = u13.HumanoidRootPart.CFrame
            if _G.check:inspect(u13) == true then
                v16:InvokeServer({
                    ["cf"] = v18,
                    ["targetPosition"] = p10:GetMouseCFrame().Position
                })
            else
                v16:InvokeServer({
                    ["Cancel"] = true
                })
            end
        end
        task.wait(0.3)
        u17:Stop(0.25)
        u13.PrimaryPart.Anchored = false
        _G.canuse = true
        _G.keysetup:cooldown("Eggsplosive Rift", v15)
        _G.fw(v15)
        v12.smash = false
    end
end
function u6.Eggsweeper(p19, p20) --[[ Line: 107 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v21 = p19.Cooldowns
    local u22 = u1.Character
    local u23 = u2["Stats" .. u1.Name]
    if v21.spin == false and _G.check:inspect(u22) == true then
        local v24 = u3.GetM("Eggsweeper")
        local v25 = v24.cd
        if _G.StamCheck("Eggsweeper") == false then
            return
        end
        if v24.statreq and _G.MeetReq(v24.statreq) == false then
            return
        end
        v21.spin = true
        _G.canuse = false
        local v26 = game.ReplicatedStorage.Events.Skill:InvokeServer("Eggsweeper")
        local u27 = tick()
        local u28 = Instance.new("BodyVelocity", u22.HumanoidRootPart)
        u28.MaxForce = Vector3.new(1000000, 0, 1000000)
        p19:ChargeSkill(p20, {
            ["Key"] = Enum.KeyCode.R,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 131 ]]
                --[[
                Upvalues:
                    [1] = u23
                    [2] = u22
                    [3] = u28
                --]]
                if u23.Stamina.Value <= 0 or u22:GetAttribute("BloSpin") == nil then
                    return true
                end
                u28.Velocity = u22.HumanoidRootPart.CFrame.LookVector * 35
            end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 139 ]]
                --[[
                Upvalues:
                    [1] = u22
                    [2] = u27
                --]]
                if u22:FindFirstChild(script.Name) == nil or (tick() - u27 >= 3 or u22:GetAttribute("BloSpin") == nil) then
                    return true
                end
            end,
            ["IgnoreInstantCastSetting"] = true
        })
        u28:Destroy()
        if v26 then
            v26:FireServer()
        end
        u22.Humanoid.WalkSpeed = 0
        task.wait(1)
        u22.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Eggsweeper", v25)
        _G.fw(v25)
        v21.spin = false
    end
end
return u6