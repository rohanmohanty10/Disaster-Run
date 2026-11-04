 

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
        ["triple"] = false,
        ["souleater"] = false
    }
    v9.doingSlash = false
    return v9
end
function u6.THETROXX(u10, u11) --[[ Line: 28 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local u12 = u10.Cooldowns
    local u13 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if u12.triple == false and (_G.check:inspect(u13) == true and (u10.doingSlash == false and _G.canuse == true)) then
        local v14 = u3.GetM("THE TROXX")
        local u15 = v14.cd
        if _G.StamCheck("THE TROXX") == false then
            return
        end
        if v14.statreq and _G.MeetReq(v14.statreq) == false then
            return
        end
        _G.canuse = false
        local u16 = game.ReplicatedStorage.Events.Skill:InvokeServer("THE TROXX")
        if u16 == nil then
            _G.canuse = true
            return
        end
        local u17 = 1
        local u18 = false
        local function u20() --[[ Line: 58 ]]
            --[[
            Upvalues:
                [1] = u10
                [2] = u18
                [3] = u13
                [4] = u17
                [5] = u12
                [6] = u16
            --]]
            _G.canuse = false
            u10.doingSlash = true
            u18 = true
            local v19 = u13.Humanoid.Animator:LoadAnimation(script["s" .. u17])
            v19:Play()
            v19.Priority = Enum.AnimationPriority.Action4
            v19:AdjustWeight(2)
            u12.triple = true
            v19:AdjustSpeed(1)
            u13.Humanoid.AutoRotate = false
            if u16 and u16:InvokeServer(u13.HumanoidRootPart.CFrame * CFrame.new(0, -1, -1)) == false then
                u17 = u17 - 1
            end
            task.wait(0.5)
            task.wait(0.75)
            _G.canuse = true
            u13.Humanoid.AutoRotate = true
            u18 = false
        end
        u20()
        local function u22() --[[ Line: 88 ]]
            --[[
            Upvalues:
                [1] = u10
                [2] = u11
                [3] = u17
                [4] = u20
                [5] = u15
                [6] = u12
                [7] = u22
                [8] = u13
                [9] = u18
            --]]
            u10:DoubleCastSkill(u11, {
                ["Key"] = Enum.KeyCode.E,
                ["SkipTap"] = true,
                ["CompleteFunction"] = function() --[[ Name: CompleteFunction, Line 92 ]]
                    --[[
                    Upvalues:
                        [1] = u17
                        [2] = u20
                        [3] = u10
                        [4] = u15
                        [5] = u12
                        [6] = u22
                    --]]
                    u17 = u17 + 1
                    u20()
                    if u17 >= 3 then
                        u10.doingSlash = false
                        _G.canuse = true
                        _G.keysetup:cooldown("THE TROXX", u15)
                        _G.fw(u15)
                        u12.triple = false
                    else
                        u22()
                    end
                end,
                ["PassFunction"] = function() --[[ Name: PassFunction, Line 107 ]]
                    --[[
                    Upvalues:
                        [1] = u13
                        [2] = u18
                    --]]
                    local v21 = u13:FindFirstChild(script.Name)
                    if v21 then
                        if u18 == false and _G.check:inspect(u13) == true then
                            v21 = _G.canuse == true
                        else
                            v21 = false
                        end
                    end
                    return v21
                end
            })
        end
        u22()
        u13.HumanoidRootPart.Anchored = false
        u13.Humanoid.WalkSpeed = 16
        _G.canuse = true
    end
end
function u6.SoulEater(p23, p24) --[[ Line: 121 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v25 = p23.Cooldowns
    local u26 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v25.souleater == false and (_G.check:inspect(u26) == true and _G.canuse == true) then
        local v27 = u3.GetM("Soul Eater")
        local v28 = v27.cd
        if _G.StamCheck("Soul Eater") == false then
            return
        end
        if v27.statreq and _G.MeetReq(v27.statreq) == false then
            return
        end
        _G.canuse = false
        local v29 = u26.Humanoid.Animator:LoadAnimation(script.soul)
        v29:Play()
        v29:AdjustWeight(2)
        v25.souleater = true
        u26.Humanoid.WalkSpeed = 8
        local v30 = game.ReplicatedStorage.Events.Skill:InvokeServer("Soul Eater")
        _G.PauseAnim(v29, 0.25, 1)
        local u31 = tick()
        p23:ChargeSkill(p24, {
            ["Key"] = Enum.KeyCode.R,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 148 ]]
                --[[
                Upvalues:
                    [1] = u26
                --]]
                u26.Humanoid.WalkSpeed = 8
            end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 153 ]]
                --[[
                Upvalues:
                    [1] = u26
                    [2] = u31
                --]]
                if u26:FindFirstChild(script.Name) == nil or tick() - u31 >= 10 then
                    return true
                end
            end
        })
        v29:AdjustSpeed(1)
        task.wait(0.1)
        if v30 then
            v30:FireServer(u26.HumanoidRootPart.CFrame)
        end
        task.wait(0.4)
        u26.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Soul Eater", v28)
        _G.fw(v28)
        v25.souleater = false
    end
end
return u6