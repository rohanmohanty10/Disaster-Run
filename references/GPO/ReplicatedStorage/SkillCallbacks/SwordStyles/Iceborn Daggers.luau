 

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
        ["upper"] = false,
        ["dash"] = false
    }
    return v9
end
function u6.IcebornAura(p10, _) --[[ Line: 28 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v11 = p10.Cooldowns
    local v12 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v11.upper == false and _G.check:inspect(v12) == true then
        local v13 = u3.GetM("Iceborn Aura")
        local v14 = v13.cd
        if _G.StamCheck("Iceborn Aura") == false then
            return
        end
        if v13.statreq and _G.MeetReq(v13.statreq) == false then
            return
        end
        v11.upper = true
        local v15 = v12.Humanoid.Animator:LoadAnimation(script.active)
        v15:Play()
        v15:AdjustWeight(2)
        v15:AdjustSpeed(2)
        game.ReplicatedStorage.Events.Skill:InvokeServer("Iceborn Aura")
        _G.keysetup:cooldown("Iceborn Aura", v14)
        _G.fw(v14)
        v11.upper = false
    end
end
function u6.IcebornDeathLotus(p16, p17) --[[ Line: 56 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v18 = p16.Cooldowns
    local u19 = u1.Character
    local u20 = u2["Stats" .. u1.Name]
    if v18.dash == false and _G.check:inspect(u19) == true then
        local v21 = u3.GetM("Iceborn Death Lotus")
        local v22 = v21.cd
        if _G.StamCheck("Iceborn Death Lotus") == false then
            return
        end
        if v21.statreq and _G.MeetReq(v21.statreq) == false then
            return
        end
        local v23, _, _ = _G.getRayFloor(u19.PrimaryPart.CFrame, 5)
        if v23 == nil then
            return nil
        end
        local v24 = u19.Humanoid.Animator:LoadAnimation(script.startup)
        v24:Play()
        v24:AdjustWeight(2)
        v18.dash = true
        _G.canuse = false
        local v25 = game.ReplicatedStorage.Events.Skill:InvokeServer("Iceborn Death Lotus")
        task.wait(0.4)
        local v26 = u19.Humanoid.Animator:LoadAnimation(script.loop)
        v26:Play()
        v26:AdjustWeight(2)
        v26:AdjustSpeed(2)
        u19.PrimaryPart.Anchored = true
        local u27 = tick()
        task.wait(0.5)
        p16:ChargeSkill(p17, {
            ["Key"] = Enum.KeyCode.R,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 89 ]]
                --[[
                Upvalues:
                    [1] = u19
                --]]
                u19.Humanoid.Jump = false
                u19.Humanoid.WalkSpeed = 0
            end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 94 ]]
                --[[
                Upvalues:
                    [1] = u27
                    [2] = u20
                --]]
                if tick() - u27 >= 3 or u20.Stamina.Value <= 0 then
                    return true
                end
            end,
            ["IgnoreInstantCastSetting"] = true
        })
        if v25 then
            v25:FireServer()
        end
        v26:Stop()
        local v28 = u19.Humanoid.Animator:LoadAnimation(script.endd)
        v28:Play()
        v28:AdjustWeight(2)
        task.wait(0.5)
        u19.PrimaryPart.Anchored = false
        u19.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Iceborn Death Lotus", v22)
        _G.fw(v22)
        v18.dash = false
    end
end
return u6