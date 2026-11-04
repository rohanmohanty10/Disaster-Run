 

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
        ["lunge"] = false,
        ["nado"] = false
    }
    return v9
end
u6["Hellheim\'sStorm"] = function(p10, _) --[[ Line: 28 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v11 = p10.Cooldowns
    local v12 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v11.lunge == false and _G.check:inspect(v12) == true then
        local v13 = u3.GetM("Hellheim\'s Storm")
        local v14 = v13.cd
        if _G.StamCheck("Hellheim\'s Storm") == false then
            return
        end
        if v13.statreq and _G.MeetReq(v13.statreq) == false then
            return
        end
        v11.lunge = true
        _G.canuse = false
        v12.HumanoidRootPart.Anchored = true
        v12.Humanoid.AutoRotate = true
        v12.PrimaryPart.Anchored = true
        game.ReplicatedStorage.Events.Skill:InvokeServer("Hellheim\'s Storm", v12.PrimaryPart.CFrame)
        v12.HumanoidRootPart.Anchored = false
        v12.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Hellheim\'s Storm", v14)
        _G.fw(v14)
        v11.lunge = false
    end
end
function u6.FlamesOfFrost(p15, _) --[[ Line: 62 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v16 = p15.Cooldowns
    local v17 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v16.nado == false and _G.check:inspect(v17) == true then
        local v18 = u3.GetM("Flames Of Frost")
        local v19 = v18.cd
        if _G.StamCheck("Flames Of Frost") == false then
            return
        end
        if v18.statreq and _G.MeetReq(v18.statreq) == false then
            return
        end
        v16.nado = true
        _G.canuse = false
        v17.Humanoid.WalkSpeed = 4
        v17.PrimaryPart.Anchored = true
        game.ReplicatedStorage.Events.Skill:InvokeServer("Flames Of Frost", v17.PrimaryPart.CFrame)
        task.wait(0.3)
        v17.PrimaryPart.Anchored = false
        v17.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Flames Of Frost", v19)
        _G.fw(v19)
        v16.nado = false
    end
end
return u6