 

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
        ["powerCord"] = false,
        ["amp"] = false
    }
    return v7
end
function u4.PowerChord(u8, p9) --[[ Line: 30 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local v10 = u8.Cooldowns
    local u11 = u1.Character
    if v10.powerCord == false and (_G.check:inspect(u11) == true and _G.StamCheck("Power Chord") == true) then
        local v12 = u2.GetM("Power Chord")
        local v13 = v12.cd
        if _G.StamCheck("Power Chord") == false then
            return
        end
        if v12.statreq and _G.MeetReq(v12.statreq) == false then
            return
        end
        v10.powerCord = true
        _G.canuse = false
        local v14 = u11.Humanoid:LoadAnimation(script.play)
        v14:Play()
        v14:AdjustWeight(2)
        v14:AdjustSpeed(0)
        _G.FaceMouse = true
        local u15 = tick()
        u8:ChargeSkill(p9, {
            ["Key"] = Enum.KeyCode.R,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 55 ]] end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 59 ]]
                --[[
                Upvalues:
                    [1] = u8
                    [2] = u11
                    [3] = u15
                --]]
                if u8.Tool.Parent ~= u11 or tick() - u15 >= 10 then
                    return true
                end
            end
        })
        v14:AdjustSpeed(1)
        _G.FaceMouse = false
        u11.PrimaryPart.Anchored = true
        if _G.castingSkill(u11, 0.5) == true then
            game.ReplicatedStorage.Events.Skill:InvokeServer("Power Chord", u11.PrimaryPart.CFrame)
        end
        task.wait(0.65)
        u11.PrimaryPart.Anchored = false
        _G.canuse = true
        _G.keysetup:cooldown("Power Chord", v13)
        _G.fw(v13)
        v10.powerCord = false
    end
end
u4["AmpItUp!"] = function(p16, _) --[[ Line: 88 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local v17 = p16.Cooldowns
    local v18 = u1.Character
    if v17.amp == false and (_G.check:inspect(v18) == true and _G.StamCheck("Amp It Up!") == true) then
        local v19 = u2.GetM("Amp It Up!")
        local v20 = v19.cd
        if _G.StamCheck("Amp It Up!") == false then
            return
        end
        if v19.statreq and _G.MeetReq(v19.statreq) == false then
            return
        end
        local v21, _, _ = _G.getRayFloor(v18.PrimaryPart.CFrame, 7)
        if v21 == nil then
            _G.displayMessage("<Color=Red>I have to touch the ground")
            return nil
        end
        v17.amp = true
        _G.canuse = false
        local v22 = v18.Humanoid:LoadAnimation(script.amp)
        v22:Play()
        v22:AdjustWeight(2)
        v18.PrimaryPart.Anchored = true
        game.ReplicatedStorage.Events.Skill:InvokeServer("Amp It Up!", v18.PrimaryPart.CFrame)
        task.wait(0.85)
        task.wait(0.65)
        v18.PrimaryPart.Anchored = false
        _G.canuse = true
        _G.keysetup:cooldown("Amp It Up!", v20)
        _G.fw(v20)
        v17.amp = false
    end
end
return u4