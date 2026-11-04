 

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
u6["Shadow\'sMark"] = function(p10, p11) --[[ Line: 28 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v12 = p10.Cooldowns
    local u13 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v12.upper == false and _G.check:inspect(u13) == true then
        local v14 = u3.GetM("Shadow\'s Mark")
        local v15 = v14.cd
        if _G.StamCheck("Shadow\'s Mark") == false then
            return
        end
        if v14.statreq and _G.MeetReq(v14.statreq) == false then
            return
        end
        v12.upper = true
        local v16 = u13.Humanoid.Animator:LoadAnimation(script.cloneAnim)
        v16:Play()
        v16:AdjustWeight(2)
        v16:AdjustSpeed(2)
        local u17 = nil
        local u18 = nil
        pcall(function() --[[ Line: 50 ]]
            --[[
            Upvalues:
                [1] = u17
                [2] = u18
                [3] = u13
            --]]
            local v19 = game.ReplicatedStorage.Events.Skill
            local v20 = u13.HumanoidRootPart.CFrame
            local v21, v22 = unpack(v19:InvokeServer("Shadow\'s Mark", v20))
            u17 = v21
            u18 = v22
        end)
        local u23
        if u18 then
            u18 = _G.awaitObject(u18)
            u23 = u18
        else
            u23 = u18
        end
        local u24 = false
        local v25 = nil
        if u17 then
            task.wait(1)
            p10:DoubleCastSkill(p11, {
                ["Key"] = Enum.KeyCode.E,
                ["SkipTap"] = true,
                ["CompleteFunction"] = function() --[[ Name: CompleteFunction, Line 65 ]]
                    --[[
                    Upvalues:
                        [1] = u23
                        [2] = u17
                        [3] = u24
                    --]]
                    if u23 and u23:IsDescendantOf(workspace) then
                        u17:FireServer()
                        _G.resetM1()
                    end
                    u24 = true
                end,
                ["PassFunction"] = function() --[[ Name: PassFunction, Line 72 ]]
                    --[[
                    Upvalues:
                        [1] = u13
                    --]]
                    local v26 = u13:FindFirstChild(script.Name)
                    if v26 then
                        if _G.check:inspect(u13) == true then
                            v26 = _G.canuse == true
                        else
                            v26 = false
                        end
                    end
                    return v26
                end
            })
        else
            u24 = true
        end
        repeat
            task.wait()
        until u24 == true or (u23 == nil or u23 and u23:IsDescendantOf(workspace) == false)
        _G.keysetup:cooldown("Shadow\'s Mark", v15)
        if v25 then
            v25:Disconnect()
        end
        _G.fw(v15)
        v12.upper = false
    end
end
function u6.ThousandStrikes(p27, _) --[[ Line: 93 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v28 = p27.Cooldowns
    local v29 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v28.dash == false and _G.check:inspect(v29) == true then
        local v30 = u3.GetM("Thousand Strikes")
        local v31 = v30.cd
        if _G.StamCheck("Thousand Strikes") == false then
            return
        end
        if v30.statreq and _G.MeetReq(v30.statreq) == false then
            return
        end
        local v32 = v29.Humanoid.Animator:LoadAnimation(script.slash)
        v32:Play()
        v32:AdjustWeight(2)
        v28.dash = true
        _G.canuse = false
        v29.Humanoid.WalkSpeed = 4
        local v33 = game.ReplicatedStorage.Events.Skill:InvokeServer("Thousand Strikes", v29.HumanoidRootPart.CFrame)
        task.wait(0.45)
        if v33 then
            v33:FireServer()
            if _G.check:inspect(v29) == false then
                v32:Stop()
            end
        end
        task.wait(0.4)
        v29.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Thousand Strikes", v31)
        _G.fw(v31)
        v28.dash = false
    end
end
return u6