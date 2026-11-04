 

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
        [3] = u1
    --]]
    local v7 = u4.new(script.Name)
    local v8 = u6
    local v9 = setmetatable(v7, v8)
    v9.Cooldowns = {}
    function v9.CheckChakramHand(p10) --[[ Line: 25 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local _ = u1.Character
        local v11 = p10.Tool:GetAttribute("Offhand") == nil
        if v11 == false then
            _G.displayMessage("<Color=Pink>You must have the chakram in your hand to use this skill")
            script.indicator:Play()
        end
        return v11
    end
    return v9
end
u6["Cupid\'sEmbrace"] = function(u12, p13) --[[ Line: 38 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v14 = u12.Cooldowns
    local u15 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    local v16 = ("Cupid\'s Embrace"):gsub("%s+", "")
    if not v14[v16] and _G.check:inspect(u15) == true then
        local v17 = u3.GetM("Cupid\'s Embrace")
        local v18 = v17.cd
        if _G.StamCheck("Cupid\'s Embrace") == false then
            return
        end
        if v17.statreq and _G.MeetReq(v17.statreq) == false then
            return
        end
        if u12:CheckChakramHand() == false then
            return
        end
        v14[v16] = true
        _G.canuse = false
        local v19 = u15.Humanoid.Animator
        local v20 = v19:LoadAnimation(script.CupidGrabHold)
        v20:Play()
        v20.Priority = Enum.AnimationPriority.Action3
        local v21 = game.ReplicatedStorage.Events.Skill:InvokeServer("Cupid\'s Embrace")
        local u22 = tick()
        local u23 = u15.Humanoid
        u12:ChargeSkill(p13, {
            ["Key"] = Enum.KeyCode.R,
            ["CheckFunction"] = function() --[[ Name: CheckFunction, Line 75 ]]
                --[[
                Upvalues:
                    [1] = u23
                --]]
                u23.WalkSpeed = 4
            end,
            ["EndFunction"] = function() --[[ Name: EndFunction, Line 78 ]]
                --[[
                Upvalues:
                    [1] = u15
                    [2] = u12
                    [3] = u22
                --]]
                return _G.check:inspect(u15) == false and true or (u12.Tool.Parent ~= u15 and true or tick() - u22 >= 4)
            end,
            ["HoldDuration"] = 0.1
        })
        v20:Stop(0)
        local v24
        if u12.Tool.Name == "Cupid\'s Chakram" then
            v24 = v19:LoadAnimation(script.CupidGrabRelease)
        else
            v24 = v19:LoadAnimation(script.PrestigeCupidGrabRelease)
        end
        v24:Play(0)
        v24.Priority = Enum.AnimationPriority.Action3
        if v21 and v21:InvokeServer(u15.PrimaryPart.CFrame) == false then
            task.wait(0.5)
        end
        task.wait(0.5)
        u23.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Cupid\'s Embrace", v18)
        _G.fw(v18)
        v14[v16] = false
    end
end
function u6.EnchantingGrasp(u25, p26) --[[ Line: 122 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v27 = u25.Cooldowns
    local u28 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    local v29 = ("Enchanting Grasp"):gsub("%s+", "")
    if not v27[v29] and _G.check:inspect(u28) == true then
        local v30 = u3.GetM("Enchanting Grasp")
        local v31 = v30.cd
        if _G.StamCheck("Enchanting Grasp") == false then
            return
        end
        if v30.statreq and _G.MeetReq(v30.statreq) == false then
            return
        end
        if u25:CheckChakramHand() == false then
            return
        end
        v27[v29] = true
        _G.canuse = false
        local v32 = u28.Humanoid.Animator
        local v33 = v32:LoadAnimation(script.CupidThrowHold)
        v33:Play()
        local u34 = u28.Humanoid
        u34.WalkSpeed = 4
        local v35 = game.ReplicatedStorage.Events.Skill:InvokeServer("Enchanting Grasp")
        local u36 = tick()
        local u37 = false
        u25:ChargeSkill(p26, {
            ["Key"] = Enum.KeyCode.E,
            ["CheckFunction"] = function() --[[ Name: CheckFunction, Line 160 ]]
                --[[
                Upvalues:
                    [1] = u34
                --]]
                u34.WalkSpeed = 4
            end,
            ["EndFunction"] = function() --[[ Name: EndFunction, Line 163 ]]
                --[[
                Upvalues:
                    [1] = u28
                    [2] = u37
                    [3] = u25
                    [4] = u36
                --]]
                if _G.check:inspect(u28) ~= false then
                    return u25.Tool.Parent ~= u28 and true or tick() - u36 >= 4
                end
                u37 = true
                return true
            end
        })
        v33:Stop()
        local v38 = v32:LoadAnimation(script.CupidThrowRelease)
        v38.Looped = false
        v38:Play()
        if v35 and v35:InvokeServer(u37) == true then
            v38:Stop()
        end
        task.wait(0.4)
        u34.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Enchanting Grasp", v31)
        _G.fw(v31)
        v27[v29] = false
    end
end
return u6