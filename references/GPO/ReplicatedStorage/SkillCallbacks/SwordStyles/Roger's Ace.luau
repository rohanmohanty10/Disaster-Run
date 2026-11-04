 

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
        ["overflow"] = false,
        ["flash"] = false,
        ["slash"] = false,
        ["divine"] = false
    }
    return v7
end
function u4.Overflow(p8, _) --[[ Line: 31 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local v9 = p8.Cooldowns
    local v10 = u1.Character
    if v9.overflow == false and _G.check:inspect(v10) == true then
        local v11 = u2.GetM("Overflow")
        local v12 = v11.cd
        if _G.StamCheck("Overflow") == false then
            return
        end
        if v11.statreq and _G.MeetReq(v11.statreq) == false then
            return
        end
        v9.overflow = true
        v10.Humanoid.WalkSpeed = 4
        game.ReplicatedStorage.Events.Skill:InvokeServer("Overflow")
        task.wait(0.25)
        v10.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Overflow", v12)
        _G.fw(v12)
        v9.overflow = false
    end
end
function u4.LaughingCounter(p13, _) --[[ Line: 63 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local v14 = p13.Cooldowns
    local v15 = u1.Character
    if v14.flash == false and _G.check:inspect(v15) == true then
        local v16 = u2.GetM("Laughing Counter")
        local v17 = v16.cd
        if _G.StamCheck("Laughing Counter") == false then
            return
        end
        if v16.statreq and _G.MeetReq(v16.statreq) == false then
            return
        end
        v14.flash = true
        _G.canuse = false
        game.ReplicatedStorage.Events.Skill:InvokeServer("Laughing Counter")
        task.wait(0.65)
        _G.canuse = true
        _G.keysetup:cooldown("Laughing Counter", v17)
        _G.fw(v17)
        v14.flash = false
    end
end
function u4.FinalRetort(p18, _) --[[ Line: 97 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local v19 = p18.Cooldowns
    local v20 = u1.Character
    if v19.slash == false and _G.check:inspect(v20) == true then
        local v21 = u2.GetM("Final Retort")
        local v22 = v21.cd
        if _G.StamCheck("Final Retort") == false then
            return
        end
        if v21.statreq and _G.MeetReq(v21.statreq) == false then
            return
        end
        v19.slash = true
        _G.canuse = false
        game.ReplicatedStorage.Events.Skill:InvokeServer("Final Retort", p18:GetMouseCFrame())
        v20.Humanoid.AutoRotate = true
        v20.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Final Retort", v22)
        _G.fw(v22)
        v19.slash = false
    end
end
function u4.DivineDeparture(u23, p24) --[[ Line: 128 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local u25 = u1.Character
    local v26 = u23.Cooldowns
    if v26.divine == false and _G.check:inspect(u25) == true then
        local v27 = u2.GetM("Divine Departure")
        local v28 = v27.cd
        if _G.StamCheck("Divine Departure") == false then
            return
        end
        if v27.statreq and _G.MeetReq(v27.statreq) == false then
            return
        end
        v26.divine = true
        _G.FaceMouse = true
        _G.canuse = false
        local v29 = u25.Humanoid.Animator:LoadAnimation(script.slash)
        v29:Play()
        v29:AdjustWeight(2)
        local v30 = game.ReplicatedStorage.Events.Skill:InvokeServer("Divine Departure")
        local u31 = tick()
        u23:ChargeSkill(p24, {
            ["Key"] = Enum.KeyCode.X,
            ["CheckFunction"] = function() --[[ Name: CheckFunction, Line 158 ]]
                --[[
                Upvalues:
                    [1] = u25
                --]]
                u25.Humanoid.AutoRotate = false
            end,
            ["HoldDuration"] = 0.3,
            ["EndFunction"] = function() --[[ Name: EndFunction, Line 162 ]]
                --[[
                Upvalues:
                    [1] = u23
                    [2] = u25
                    [3] = u31
                --]]
                return (u23.Tool.Parent ~= u25 or u25.Parent ~= workspace.PlayerCharacters) and true or tick() - u31 >= 10
            end
        })
        v29:Stop()
        local v32 = u25.Humanoid.Animator:LoadAnimation(script.slashEnd)
        v32:Play()
        v32:AdjustWeight(2)
        _G.FaceMouse = false
        u25.HumanoidRootPart.Anchored = true
        u25.Humanoid.AutoRotate = false
        u25:PivotTo(CFrame.new(u25.PrimaryPart.Position, u23:GetMousePosition()))
        if v30 then
            v30:FireServer(CFrame.new(u25.PrimaryPart.Position, u23:GetMousePosition()))
        end
        v32:AdjustSpeed(1)
        task.wait(0.5)
        u25.Humanoid.AutoRotate = true
        u25.HumanoidRootPart.Anchored = false
        u25.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Divine Departure", v28)
        _G.fw(v28)
        v26.divine = false
    end
end
return u4