 

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
        ["slash"] = false,
        ["flash"] = false
    }
    return v9
end
function u6.FlowerAroma(p10, _) --[[ Line: 28 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v11 = p10.Cooldowns
    local v12 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v11.slash == false and _G.check:inspect(v12) == true then
        local v13 = u3.GetM("Flower Aroma")
        local v14 = v13.cd
        if _G.StamCheck("Flower Aroma") == false then
            return
        end
        if v13.statreq and _G.MeetReq(v13.statreq) == false then
            return
        end
        local v15, _, _ = _G.getRayFloor(v12.PrimaryPart.CFrame, 5)
        if v15 == nil then
            _G.displayMessage("<Color=Red>I have to touch the ground")
            return nil
        end
        v11.slash = true
        _G.canuse = false
        v12.Humanoid.WalkSpeed = 0
        v12.Humanoid:LoadAnimation(script.buffSkill):Play()
        task.wait(0.4)
        game.ReplicatedStorage.Events.Skill:InvokeServer("Flower Aroma", v12.PrimaryPart.CFrame * CFrame.new(0, 0, -3))
        task.wait(0.25)
        v12.Humanoid.WalkSpeed = 16
        task.wait(0.25)
        _G.canuse = true
        _G.keysetup:cooldown("Flower Aroma", v14)
        _G.fw(v14)
        v11.slash = false
    end
end
function u6.AbsoluteSeduction(p16, p17) --[[ Line: 67 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v18 = p16.Cooldowns
    local u19 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v18.flash == false and _G.check:inspect(u19) == true then
        local v20 = u3.GetM("Absolute Seduction")
        local v21 = v20.cd
        if _G.StamCheck("Absolute Seduction") == false then
            return
        end
        if v20.statreq and _G.MeetReq(v20.statreq) == false then
            return
        end
        local v22, _, _ = _G.getRayFloor(u19.PrimaryPart.CFrame, 5)
        if v22 == nil then
            _G.displayMessage("<Color=Red>I have to touch the ground")
            return nil
        end
        v18.flash = true
        _G.canuse = false
        _G.FaceMouse = true
        _G.mouseLevel = true
        local v23 = u19.Humanoid:LoadAnimation(script.hold)
        v23:Play()
        task.wait(0.2)
        local u24 = game.ReplicatedStorage.Events.Skill:InvokeServer("Absolute Seduction")
        local u25 = tick()
        p16:ChargeSkill(p17, {
            ["Key"] = Enum.KeyCode.R,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 100 ]] end,
            ["IgnoreInstantCastSetting"] = true,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 104 ]]
                --[[
                Upvalues:
                    [1] = u19
                    [2] = u25
                    [3] = u24
                --]]
                if u19:FindFirstChild(script.Name) == nil or tick() - u25 >= 3 then
                    return true
                end
                if u24 == nil then
                    return true
                end
            end
        })
        if u24 then
            u24:FireServer()
        end
        task.wait(0.1)
        v23:Stop()
        u19.Humanoid:LoadAnimation(script.release):Play()
        task.wait(0.4)
        _G.mouseLevel = nil
        _G.FaceMouse = false
        _G.canuse = true
        _G.keysetup:cooldown("Absolute Seduction", v21)
        _G.fw(v21)
        v18.flash = false
    end
end
return u6