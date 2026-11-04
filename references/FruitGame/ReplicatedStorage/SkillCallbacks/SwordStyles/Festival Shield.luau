 

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
        ["guard"] = false,
        ["care"] = false
    }
    return v9
end
function u6.ShieldBash(p10, p11) --[[ Line: 28 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v12 = p10.Cooldowns
    local u13 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v12.guard == false and _G.check:inspect(u13) == true then
        local v14 = u3.GetM("Shield Bash")
        local v15 = v14.cd
        if _G.StamCheck("Shield Bash") == false then
            return
        end
        if v14.statreq and _G.MeetReq(v14.statreq) == false then
            return
        end
        local u16 = u13.Humanoid.Animator:LoadAnimation(script.start)
        u16:Play()
        u16:AdjustWeight(2)
        u16:AdjustSpeed(2)
        v12.guard = true
        _G.canuse = false
        u13.Humanoid.WalkSpeed = 4
        _G.PauseAnim(u16, 0.25, 1)
        local u17 = tick()
        p10:ChargeSkill(p11, {
            ["Key"] = Enum.KeyCode.E,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 55 ]]
                --[[
                Upvalues:
                    [1] = u13
                    [2] = u16
                --]]
                if _G.check:inspect(u13) == false then
                    u16:Stop()
                    return true
                end
                u13.Humanoid.WalkSpeed = 4
            end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 64 ]]
                --[[
                Upvalues:
                    [1] = u13
                    [2] = u17
                --]]
                if u13:FindFirstChild(script.Name) == nil or tick() - u17 >= 10 then
                    return true
                end
            end
        })
        u16:AdjustSpeed(2)
        game.ReplicatedStorage.Events.Skill:InvokeServer("Shield Bash", {
            ["cf"] = u13.PrimaryPart.CFrame
        })
        u13.Humanoid.AutoRotate = true
        u13.HumanoidRootPart.Anchored = false
        u13.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Shield Bash", v15)
        _G.fw(v15)
        v12.guard = false
    end
end
u6["SharingisCaring!"] = function(u18, p19) --[[ Line: 92 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v20 = u18.Cooldowns
    local u21 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v20.care == false and _G.check:inspect(u21) == true then
        local v22 = u3.GetM("Sharing is Caring!")
        local v23 = v22.cd
        if _G.StamCheck("Sharing is Caring!") == false then
            return
        end
        if v22.statreq and _G.MeetReq(v22.statreq) == false then
            return
        end
        _G.canuse = false
        local u24 = false
        local u25 = game.ReplicatedStorage.Events.Skill:InvokeServer("Sharing is Caring!", u21.PrimaryPart.CFrame)
        u18:DoubleCastSkill(p19, {
            ["Key"] = Enum.KeyCode.R,
            ["SkipTap"] = true,
            ["CompleteFunction"] = function() --[[ Name: CompleteFunction, Line 116 ]]
                --[[
                Upvalues:
                    [1] = u24
                    [2] = u25
                --]]
                u24 = true
                if u25 then
                    u25:FireServer()
                end
            end,
            ["PassFunction"] = function() --[[ Name: PassFunction, Line 122 ]]
                --[[
                Upvalues:
                    [1] = u18
                    [2] = u21
                --]]
                return u18.Tool.Parent == u21
            end
        })
        repeat
            task.wait()
        until u24 == true or u25 and u25:IsDescendantOf(game) == false
        _G.canuse = true
        _G.keysetup:cooldown("Sharing is Caring!", v23)
        _G.fw(v23)
        v20.care = false
    end
end
return u6