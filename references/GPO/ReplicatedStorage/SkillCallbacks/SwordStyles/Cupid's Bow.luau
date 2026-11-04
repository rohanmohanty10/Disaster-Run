 

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
        ["rain"] = false,
        ["burst"] = false
    }
    return v9
end
local function u23(p10, u11) --[[ Line: 28 ]]
    local u15 = {
        ["anims"] = {},
        ["Stop"] = function(p12) --[[ Name: Stop, Line 33 ]]
            for v13 = 1, #p12.anims do
                p12.anims[v13]:Stop()
            end
        end,
        ["Destroy"] = function(p14) --[[ Name: Destroy, Line 39 ]]
            p14.anims = nil
        end
    }
    local u16 = 2
    local u17 = false
    local function v21(p18) --[[ Line: 47 ]]
        --[[
        Upvalues:
            [1] = u11
            [2] = u16
            [3] = u15
            [4] = u17
        --]]
        local v19 = p18:LoadAnimation(u11)
        v19:Play()
        v19.Priority = Enum.AnimationPriority.Action4
        u16 = v19.Length
        local v20 = u15.anims
        table.insert(v20, v19)
        if u17 == false then
            u17 = true
            v19.Stopped:Connect(function() --[[ Line: 55 ]]
                --[[
                Upvalues:
                    [1] = u15
                --]]
                task.wait(1)
                u15:Destroy()
            end)
        end
    end
    local v22 = p10:FindFirstChild(script.Name .. "Sword")
    if v22 then
        v21(v22.AnimationController)
    end
    v21(p10.Humanoid)
    return u15
end
u6["Cupid\'sRain"] = function(p24, p25) --[[ Line: 72 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
        [4] = u23
    --]]
    local v26 = p24.Cooldowns
    local u27 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v26.rain == false and _G.check:inspect(u27) == true then
        local v28 = u3.GetM("Cupid\'s Rain")
        local v29 = v28.cd
        if _G.StamCheck("Cupid\'s Rain") == false then
            return
        end
        if v28.statreq and _G.MeetReq(v28.statreq) == false then
            return
        end
        _G.canuse = false
        v26.rain = true
        _G.FaceMouse = true
        _G.mouseLevel = true
        local v30 = u23(u27, script.rainLoop)
        local u31 = tick()
        local v32 = game.ReplicatedStorage.Events.Skill:InvokeServer("Cupid\'s Rain")
        p24:ChargeSkill(p25, {
            ["Key"] = Enum.KeyCode.E,
            ["IgnoreInstantCastSetting"] = true,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 98 ]]
                --[[
                Upvalues:
                    [1] = u27
                    [2] = u31
                --]]
                if u27:FindFirstChild(script.Name) == nil or tick() - u31 >= 10 then
                    return true
                end
                if _G.check:inspect(u27) == false then
                    return true
                end
            end
        })
        v30:Stop()
        u23(u27, script.rainFire)
        if v32 then
            v32:FireServer(p24:GetMouseCFrame())
        end
        u27.PrimaryPart.Anchored = true
        u27.Humanoid.AutoRotate = false
        _G.FaceMouse = false
        _G.mouseLevel = nil
        task.wait(0.3)
        _G.canuse = true
        _G.keysetup:cooldown("Cupid\'s Rain", v29)
        u27.PrimaryPart.Anchored = false
        u27.Humanoid.AutoRotate = true
        _G.fw(v29)
        v26.rain = false
    end
end
function u6.CupidBurst(p33, p34) --[[ Line: 136 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
        [4] = u23
    --]]
    local v35 = p33.Cooldowns
    local u36 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v35.burst == false and _G.check:inspect(u36) == true then
        local v37 = u3.GetM("Cupid Burst")
        local v38 = v37.cd
        if _G.StamCheck("Cupid Burst") == false then
            return
        end
        if v37.statreq and _G.MeetReq(v37.statreq) == false then
            return
        end
        _G.canuse = false
        v35.burst = true
        _G.FaceMouse = true
        local v39 = u23(u36, script.burstLoop)
        local u40 = tick()
        local v41 = game.ReplicatedStorage.Events.Skill:InvokeServer("Cupid Burst")
        p33:ChargeSkill(p34, {
            ["Key"] = Enum.KeyCode.R,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 161 ]]
                --[[
                Upvalues:
                    [1] = u36
                    [2] = u40
                --]]
                if u36:FindFirstChild(script.Name) == nil or tick() - u40 >= 10 then
                    return true
                end
                if _G.check:inspect(u36) == false then
                    return true
                end
            end,
            ["HoldDuration"] = 0.3
        })
        v39:Stop()
        u23(u36, script.burstFire)
        _G.FaceMouse = false
        u36.PrimaryPart.Anchored = true
        if v41 then
            v41:FireServer(u36.PrimaryPart.CFrame)
        end
        task.wait(0.75)
        u36.PrimaryPart.Anchored = false
        _G.canuse = true
        _G.keysetup:cooldown("Cupid Burst", v38)
        _G.fw(v38)
        v35.burst = false
    end
end
return u6