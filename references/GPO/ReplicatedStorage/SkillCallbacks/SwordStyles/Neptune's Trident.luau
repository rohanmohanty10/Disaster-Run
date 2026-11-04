 

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
        ["pull"] = false,
        ["impale"] = false
    }
    return v9
end
function u6.TridentPull(u10, p11) --[[ Line: 28 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v12 = u10.Cooldowns
    local u13 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v12.pull == false and _G.check:inspect(u13) == true then
        local v14 = u3.GetM("Trident Pull")
        local v15 = v14.cd
        if _G.StamCheck("Trident Pull") == false then
            return
        end
        if v14.statreq and _G.MeetReq(v14.statreq) == false then
            return
        end
        local v16 = u13.Humanoid.Animator:LoadAnimation(script.pull)
        v16:Play()
        v16:AdjustWeight(2)
        v12.pull = true
        _G.canuse = false
        u13.Humanoid.WalkSpeed = 4
        _G.FaceMouse = true
        _G.PauseAnim(v16, 0.42, 1)
        local u17 = tick()
        u10:ChargeSkill(p11, {
            ["Key"] = Enum.KeyCode.E,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 56 ]]
                --[[
                Upvalues:
                    [1] = u13
                --]]
                if _G.check:inspect(u13) == false then
                    return true
                end
                u13.Humanoid.WalkSpeed = 4
            end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 63 ]]
                --[[
                Upvalues:
                    [1] = u17
                    [2] = u13
                --]]
                if tick() - u17 >= 6 or u13:FindFirstChild("Stun") then
                    return true
                end
            end
        })
        _G.FaceMouse = false
        v16:AdjustSpeed(1)
        u13.HumanoidRootPart.Anchored = true
        task.wait(0.1)
        task.spawn(function() --[[ Line: 79 ]]
            --[[
            Upvalues:
                [1] = u10
            --]]
            game.ReplicatedStorage.Events.Skill:InvokeServer("Trident Pull", {
                ["cf"] = u10:GetMouseCFrame()
            })
        end)
        u13.Humanoid.WalkSpeed = 16
        task.wait(0.2)
        u13.HumanoidRootPart.Anchored = false
        _G.canuse = true
        _G.keysetup:cooldown("Trident Pull", v15)
        _G.fw(v15)
        v12.pull = false
    end
end
function u6.TridentImpale(u18, p19) --[[ Line: 92 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v20 = u18.Cooldowns
    local u21 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v20.impale == false and _G.check:inspect(u21) == true then
        local v22 = u3.GetM("Trident Impale")
        local v23 = v22.cd
        if _G.StamCheck("Trident Impale") == false then
            return
        end
        if v22.statreq and _G.MeetReq(v22.statreq) == false then
            return
        end
        local v24 = u21.Humanoid.Animator:LoadAnimation(script.windup)
        v24:Play()
        v24:AdjustWeight(2)
        v20.impale = true
        _G.canuse = false
        u21.Humanoid.WalkSpeed = 4
        _G.PauseAnim(v24, 0.25, 1)
        tick()
        local function v25() --[[ Line: 123 ]]
            --[[
            Upvalues:
                [1] = u18
                [2] = u1
                [3] = u21
            --]]
            if not u18:_findTool(u1.Character) or _G.check:inspect(u21) == false then
                return true
            end
        end
        u18:ChargeSkill(p19, {
            ["Key"] = Enum.KeyCode.R,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 119 ]]
                --[[
                Upvalues:
                    [1] = u21
                --]]
                u21.Humanoid.WalkSpeed = 4
            end,
            ["EndFunction"] = v25
        })
        v24:AdjustSpeed(2)
        if u21:FindFirstChild("Stun") == nil then
            task.wait(0.07500000000000001)
            game.ReplicatedStorage.Events.Skill:InvokeServer("Trident Impale", {
                ["cf"] = u21.HumanoidRootPart.CFrame
            })
        end
        u21.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Trident Impale", v23)
        _G.fw(v23)
        v20.impale = false
    end
end
return u6