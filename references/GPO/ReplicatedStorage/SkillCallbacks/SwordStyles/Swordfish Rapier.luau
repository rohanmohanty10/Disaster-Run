 

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
        ["Call of the Deep"] = false,
        ["Aquatic Lunge"] = false
    }
    return v9
end
function u6.AquaticLunge(p10, _) --[[ Line: 28 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v11 = p10.Cooldowns
    local v12 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v11["Aquatic Lunge"] == false and _G.check:inspect(v12) == true then
        local v13 = u3.GetM("Aquatic Lunge")
        local v14 = v13.cd
        if _G.StamCheck("Aquatic Lunge") == false then
            return
        end
        if v13.statreq and _G.MeetReq(v13.statreq) == false then
            return
        end
        v11["Aquatic Lunge"] = true
        _G.canuse = false
        v12.Humanoid.WalkSpeed = 4
        game.ReplicatedStorage.Events.Skill:InvokeServer("Aquatic Lunge")
        task.wait(0.25)
        v12.Humanoid.WalkSpeed = 16
        v12.Humanoid.AutoRotate = true
        _G.canuse = true
        _G.keysetup:cooldown("Aquatic Lunge", v14)
        _G.fw(v14)
        v11["Aquatic Lunge"] = false
    end
end
function u6.CalloftheDeep(p15, p16) --[[ Line: 61 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v17 = p15.Cooldowns
    local u18 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v17["Call of the Deep"] == false and _G.check:inspect(u18) == true then
        local v19 = u3.GetM("Call of the Deep")
        local v20 = v19.cd
        if _G.StamCheck("Call of the Deep") == false then
            return
        end
        if v19.statreq and _G.MeetReq(v19.statreq) == false then
            return
        end
        v17["Call of the Deep"] = true
        _G.FaceMouse = true
        _G.canuse = false
        local v21 = u18.Humanoid.Animator:LoadAnimation(script.callofdeep)
        v21:Play()
        v21:AdjustWeight(2)
        v21.Priority = Enum.AnimationPriority.Action4
        local v22 = game.ReplicatedStorage.Events.Skill:InvokeServer("Call of the Deep")
        local u23 = tick()
        _G.PauseAnim(v21, 0.3, 0.7)
        p15:ChargeSkill(p16, {
            ["Key"] = Enum.KeyCode.R,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 91 ]] end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 98 ]]
                --[[
                Upvalues:
                    [1] = u18
                    [2] = u23
                --]]
                if u18:FindFirstChild(script.Name) == nil or tick() - u23 >= 10 then
                    return true
                end
            end
        })
        v21:AdjustSpeed(2)
        _G.FaceMouse = false
        local v24 = u18.PrimaryPart.CFrame
        u18.PrimaryPart.Anchored = true
        u18.Humanoid.AutoRotate = false
        if v22 then
            v22:InvokeServer(v24)
        end
        task.wait(0.4)
        u18.PrimaryPart.Anchored = false
        _G.canuse = true
        _G.keysetup:cooldown("Call of the Deep", v20)
        _G.fw(v20)
        v17["Call of the Deep"] = false
    end
end
return u6