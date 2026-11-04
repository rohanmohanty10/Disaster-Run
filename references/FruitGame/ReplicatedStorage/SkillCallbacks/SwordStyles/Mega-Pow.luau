 

local u1 = game.Players.LocalPlayer
game:GetService("RunService")
game:GetService("ReplicatedStorage")
local u2 = require(game.ReplicatedStorage.Modules.Skills)
local u3 = require(script.Parent.Parent.MobileBase)
local v4 = require(u1.PlayerScripts:WaitForChild("PlayerModule"))
u1:GetMouse()
v4:GetControls()
local u5 = setmetatable({}, u3)
u5.__index = u5
function u5.new(_) --[[ Line: 20 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u5
    --]]
    local v6 = u3.new(script.Name)
    local v7 = u5
    local v8 = setmetatable(v6, v7)
    v8.Cooldowns = {
        ["FlameChompers"] = false,
        ["deathRocket"] = false
    }
    return v8
end
function u5.MonkeyChompers(u9, p10) --[[ Line: 28 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local v11 = u9.Cooldowns
    local _ = game.ReplicatedStorage["Stats" .. u1.Name]
    local u12 = u1.Character
    if v11.FlameChompers == false and _G.check:inspect(u12) == true then
        local v13 = u2.GetM("Monkey Chompers")
        local v14 = v13.cd
        if _G.StamCheck("Monkey Chompers") == false then
            return
        end
        if v13.statreq and _G.MeetReq(v13.statreq) == false then
            return
        end
        v11.FlameChompers = true
        _G.canuse = false
        u12.Humanoid.WalkSpeed = 10
        local v15 = u12.Humanoid.Animator:LoadAnimation(script.strikeWindup)
        v15:Play(0)
        v15:AdjustWeight(2)
        _G.PauseAnim(v15, 0.33, 1.3)
        local u16 = tick()
        u9:ChargeSkill(p10, {
            ["Key"] = Enum.KeyCode.E,
            ["EndFunction"] = function() --[[ Name: endFunction2, Line 56 ]]
                --[[
                Upvalues:
                    [1] = u12
                    [2] = u9
                    [3] = u16
                --]]
                u12.Humanoid.WalkSpeed = 10
                if u9.Tool.Parent ~= u12 or (tick() - u16 >= 5 or _G.check:inspect(u12) == false) then
                    return true
                end
            end,
            ["IgnoreInstantCastSetting"] = true
        })
        v15:AdjustSpeed(1.3)
        task.wait(0.05384615384615385)
        game.ReplicatedStorage.Events.Skill:InvokeServer("Monkey Chompers", u12.HumanoidRootPart.CFrame)
        u12.Humanoid.WalkSpeed = 16
        u12.Humanoid.AutoRotate = true
        _G.canuse = true
        _G.keysetup:cooldown("Monkey Chompers", v14)
        _G.fw(v14)
        v11.FlameChompers = false
    end
end
u5["SUPERMEGADEATHROCKET!"] = function(u17, p18) --[[ Line: 83 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local v19 = u17.Cooldowns
    local _ = game.ReplicatedStorage["Stats" .. u1.Name]
    local u20 = u1.Character
    if v19.deathRocket == false and _G.check:inspect(u20) == true then
        local v21 = u2.GetM("SUPER MEGA DEATH ROCKET!")
        local v22 = v21.cd
        if _G.StamCheck("SUPER MEGA DEATH ROCKET!") == false then
            return
        end
        if v21.statreq and _G.MeetReq(v21.statreq) == false then
            return
        end
        if u20:FindFirstChild(script.Name .. "Sword") == nil then
            return
        end
        v19.deathRocket = true
        _G.canuse = false
        _G.FaceMouse = true
        local v23 = game.ReplicatedStorage.Events.Skill:InvokeServer("SUPER MEGA DEATH ROCKET!", {
            ["cf"] = u20.HumanoidRootPart.CFrame
        })
        local u24 = tick()
        u17:ChargeSkill(p18, {
            ["Key"] = Enum.KeyCode.R,
            ["EndFunction"] = function() --[[ Name: endFunction2, Line 108 ]]
                --[[
                Upvalues:
                    [1] = u17
                    [2] = u20
                    [3] = u24
                --]]
                if u17.Tool.Parent ~= u20 or (tick() - u24 >= 5 or u20.Parent ~= workspace.PlayerCharacters) then
                    return true
                end
            end,
            ["HoldDuration"] = 1,
            ["IgnoreInstantCastSetting"] = true
        })
        local v25 = u20.PrimaryPart.Position
        local v26 = u20:FindFirstChild(script.Name .. "Sword")
        if v26 then
            local v27 = v26:FindFirstChild("mouth", true)
            if v27 then
                v25 = v27.WorldPosition
            end
        end
        if v23 then
            v23:FireServer(v25, _G.MouseCF)
        end
        u20.PrimaryPart.Anchored = true
        _G.FaceMouse = false
        task.wait(1)
        u20.PrimaryPart.Anchored = false
        _G.canuse = true
        _G.keysetup:cooldown("SUPER MEGA DEATH ROCKET!", v22)
        _G.fw(v22)
        v19.deathRocket = false
    end
end
return u5