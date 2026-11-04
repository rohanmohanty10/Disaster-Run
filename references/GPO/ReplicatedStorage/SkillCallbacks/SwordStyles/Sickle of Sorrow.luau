 

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
        ["Grasp"] = false,
        ["strike"] = false
    }
    return v9
end
function u6.DimensionalSlash(u10, p11) --[[ Line: 28 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v12 = u10.Cooldowns
    local u13 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v12.strike == false and _G.check:inspect(u13) == true then
        local v14 = u3.GetM("Dimensional Slash")
        local v15 = v14.cd
        if _G.StamCheck("Dimensional Slash") == false then
            return
        end
        if v14.statreq and _G.MeetReq(v14.statreq) == false then
            return
        end
        v12.strike = true
        local v16 = _G.MouseCF.Position
        _G.canuse = false
        _G.FaceMouse = true
        local v17 = game.ReplicatedStorage.Events.Skill:InvokeServer("Dimensional Slash", v16)
        local u18 = tick()
        local v19 = u13.Humanoid
        local _ = v19.Animator
        local u20 = false
        tick()
        u10:ChargeSkill(p11, {
            ["Key"] = Enum.KeyCode.E,
            ["EndFunction"] = function() --[[ Name: EndFunction, Line 64 ]]
                --[[
                Upvalues:
                    [1] = u13
                    [2] = u20
                    [3] = u10
                    [4] = u18
                --]]
                if _G.check:inspect(u13) ~= false then
                    return u10.Tool.Parent ~= u13 and true or tick() - u18 >= 4
                end
                u20 = true
                return true
            end,
            ["HoldDuration"] = 0.4
        })
        v19.AutoRotate = false
        _G.FaceMouse = false
        u13.PrimaryPart.Anchored = true
        if v17 then
            if v17:InvokeServer(u13.PrimaryPart.CFrame, u20) == true then
                task.wait(0.9)
            else
                task.wait(0.75)
            end
        end
        u13.PrimaryPart.Anchored = false
        v19.JumpPower = 50
        v19.AutoRotate = true
        _G.canuse = true
        _G.keysetup:cooldown("Dimensional Slash", v15)
        _G.fw(v15)
        v12.strike = false
    end
end
function u6.DivineFury(p21, _) --[[ Line: 104 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v22 = p21.Cooldowns
    local v23 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v22.Grasp == false and _G.check:inspect(v23) == true then
        local v24 = u3.GetM("Divine Fury")
        local v25 = v24.cd
        if _G.StamCheck("Divine Fury") == false then
            return
        end
        if v24.statreq and _G.MeetReq(v24.statreq) == false then
            return
        end
        v22.Grasp = true
        _G.canuse = false
        v23.Humanoid.WalkSpeed = 4
        game.ReplicatedStorage.Events.Skill:InvokeServer("Divine Fury", v23.PrimaryPart.CFrame)
        v23.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Divine Fury", v25)
        _G.fw(v25)
        v22.Grasp = false
    end
end
return u6