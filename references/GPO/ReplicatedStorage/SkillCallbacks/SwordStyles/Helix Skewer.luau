 

local u1 = game.Players.LocalPlayer
game:GetService("RunService")
local u2 = require(game.ReplicatedStorage.Modules.Skills)
local u3 = require(script.Parent.Parent.MobileBase)
require(u1.PlayerScripts:WaitForChild("PlayerModule"))
u1:GetMouse()
local u4 = setmetatable({}, u3)
u4.__index = u4
function u4.new(_) --[[ Line: 18 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u4
    --]]
    local v5 = u3.new(script.Name)
    local v6 = u4
    local v7 = setmetatable(v5, v6)
    v7.Cooldowns = {
        ["waterspout"] = false,
        ["tidalstrike"] = false
    }
    return v7
end
function u4.WringingVortex(u8, p9) --[[ Line: 29 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local v10 = u8.Cooldowns
    local u11 = u1.Character
    if v10.waterspout == false and _G.check:inspect(u11) == true then
        local v12 = u2.GetM("Wringing Vortex")
        local v13 = v12.cd
        if _G.StamCheck("Wringing Vortex") == false then
            return
        end
        if v12.statreq and _G.MeetReq(v12.statreq) == false then
            return
        end
        v10.waterspout = true
        _G.canuse = false
        local v14 = game.ReplicatedStorage.Events.Skill:InvokeServer("Wringing Vortex")
        local u15 = tick()
        local u16 = u11.Humanoid
        local u17 = false
        u8:ChargeSkill(p9, {
            ["Key"] = Enum.KeyCode.E,
            ["CheckFunction"] = function() --[[ Name: CheckFunction, Line 57 ]]
                --[[
                Upvalues:
                    [1] = u16
                --]]
                u16.WalkSpeed = 2
                u16.JumpPower = 0
            end,
            ["EndFunction"] = function() --[[ Name: EndFunction, Line 61 ]]
                --[[
                Upvalues:
                    [1] = u11
                    [2] = u17
                    [3] = u8
                    [4] = u15
                --]]
                if _G.check:inspect(u11) ~= false then
                    return u8.Tool.Parent ~= u11 and true or tick() - u15 >= 4
                end
                u17 = true
                return true
            end,
            ["HoldDuration"] = 0.4
        })
        u16.WalkSpeed = 0
        u16.AutoRotate = false
        if v14 then
            v14:InvokeServer(u11.PrimaryPart.CFrame, u17)
        end
        u16.AutoRotate = false
        task.wait(0.1)
        u16.WalkSpeed = 16
        u16.JumpPower = 50
        u16.AutoRotate = true
        _G.canuse = true
        _G.keysetup:cooldown("Wringing Vortex", v13)
        _G.fw(v13)
        v10.waterspout = false
    end
end
function u4.WringingRupture(p18, _) --[[ Line: 95 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local v19 = u1.Character
    local v20 = p18.Cooldowns
    if v20.tidalstrike == false and _G.check:inspect(v19) == true then
        local v21 = u2.GetM("Wringing Rupture")
        local v22 = v21.cd
        if _G.StamCheck("Wringing Rupture") == false then
            return
        end
        if v21.statreq and _G.MeetReq(v21.statreq) == false then
            return
        end
        local u23 = v19.Humanoid
        _G.canuse = false
        local u24 = true
        task.spawn(function() --[[ Line: 117 ]]
            --[[
            Upvalues:
                [1] = u24
                [2] = u23
            --]]
            while u24 do
                u23.WalkSpeed = 2
                task.wait()
            end
        end)
        game.ReplicatedStorage.Events.Skill:InvokeServer("Wringing Rupture")
        u24 = false
        u23.JumpHeight = 7.2
        u23.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Wringing Rupture", v22)
        _G.fw(v22)
        v20.tidalstrike = false
    end
end
return u4