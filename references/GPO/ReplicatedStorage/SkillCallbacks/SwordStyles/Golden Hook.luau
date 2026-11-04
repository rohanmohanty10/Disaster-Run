 

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
        ["impale"] = false,
        ["poison"] = false
    }
    return v9
end
u6["HookImpale/Dehydrate"] = function(p10, p11) --[[ Line: 28 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v12 = p10.Cooldowns
    local u13 = u1.Character
    local u14 = u2["Stats" .. u1.Name]
    if v12.impale == false and _G.check:inspect(u13) == true then
        local v15 = u3.GetM("Hook Impale/Dehydrate")
        local v16 = v15.cd
        if _G.StamCheck("Hook Impale/Dehydrate") == false then
            return
        end
        if v15.statreq and _G.MeetReq(v15.statreq) == false then
            return
        end
        local u17 = u13.Humanoid.Animator:LoadAnimation(script.grab)
        if u14.Stats.DF.Value ~= "Suna-Suna" then
            u17 = u13.Humanoid.Animator:LoadAnimation(script.grab2)
        end
        u17:Play()
        u17:AdjustWeight(5)
        v12.impale = true
        _G.canuse = false
        u13.Humanoid.WalkSpeed = 4
        if u14.Stats.DF.Value == "Suna-Suna" then
            _G.PauseAnim(u17, 0.35, 1)
        else
            _G.PauseAnim(u17, 0.25, 1)
        end
        local u18 = tick()
        p10:ChargeSkill(p11, {
            ["Key"] = Enum.KeyCode.R,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 61 ]]
                --[[
                Upvalues:
                    [1] = u13
                    [2] = u17
                --]]
                if _G.check:inspect(u13) == false then
                    u17:Stop()
                    return true
                end
                u13.Humanoid.WalkSpeed = 4
            end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 70 ]]
                --[[
                Upvalues:
                    [1] = u13
                    [2] = u18
                    [3] = u14
                --]]
                if u13:FindFirstChild(script.Name) == nil or (tick() - u18 >= 5 or (u13:FindFirstChild("Stun") or u14.Stamina.Value <= 0)) then
                    return true
                end
            end
        })
        u13.Humanoid.WalkSpeed = 16
        if u14.Stats.DF.Value == "Suna-Suna" then
            u17:AdjustSpeed(1.1)
        else
            u17:AdjustSpeed(1.5)
        end
        game.ReplicatedStorage.Events.Skill:InvokeServer("Hook Impale/Dehydrate", {
            ["cf"] = u13.HumanoidRootPart.CFrame
        })
        _G.keysetup:cooldown("Hook Impale/Dehydrate", v16)
        task.wait(0.2)
        _G.canuse = true
        _G.fw(v16)
        v12.impale = false
    end
end
function u6.ActivatePoison(p19, _) --[[ Line: 100 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v20 = p19.Cooldowns
    local v21 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v20.poison == false and _G.check:inspect(v21) == true then
        local v22 = u3.GetM("Activate Poison")
        local v23 = v22.cd
        if _G.StamCheck("Activate Poison") == false then
            return
        end
        if v22.statreq and _G.MeetReq(v22.statreq) == false then
            return
        end
        local v24 = v21.Humanoid.Animator:LoadAnimation(script.poison)
        v24:Play()
        v24:AdjustWeight(2)
        v20.poison = true
        game.ReplicatedStorage.Events.Skill:InvokeServer("Activate Poison", {
            ["cf"] = v21.HumanoidRootPart.CFrame
        })
        _G.keysetup:cooldown("Activate Poison", v23)
        task.wait(0.5)
        _G.fw(v23)
        v20.poison = false
    end
end
return u6