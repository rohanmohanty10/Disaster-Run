 

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
        ["fear"] = false
    }
    return v7
end
u4["Ba\'alsFear"] = function(p8, _) --[[ Line: 28 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local v9 = p8.Cooldowns
    local v10 = u1.Character
    if v9.fear ~= false or (_G.check:inspect(v10) ~= true or _G.StamCheck("Ba\'als Fear") ~= true) then
        ::l2::
        return
    end
    local v11 = u2.GetM("Ba\'als Fear")
    local v12 = v11.cd
    if _G.StamCheck("Ba\'als Fear") == false then
        return
    end
    if v11.statreq and _G.MeetReq(v11.statreq) == false then
        return
    end
    v9.fear = true
    local v13 = p8.Tool:WaitForChild("PumpkinHead", 5)
    if v13 == nil then
        v9.fear = false
        return
    end
    if v13 and v13:FindFirstChild("Handle") == nil then
        v9.fear = false
        return
    end
    _G.canuse = false
    if game.ReplicatedStorage.Events.Skill:InvokeServer("Ba\'als Fear", v13.Handle.CFrame) == true then
        v10.Humanoid.WalkSpeed = 4
        local v14 = tick()
        while true do
            if p8.Tool.Parent ~= v10 then
                v10.Humanoid:UnequipTools()
                p8.Tool.Parent = v10
            end
            v10.Humanoid.WalkSpeed = 4
            _G.canuse = false
            game["Run Service"].RenderStepped:Wait()
            if tick() - v14 >= 0.75 then
                v10.Humanoid.WalkSpeed = 16
                goto l16
            end
        end
    else
        ::l16::
        _G.canuse = true
        _G.keysetup:cooldown("Ba\'als Fear", v12)
        _G.fw(v12)
        v9.fear = false
        goto l2
    end
end
return u4