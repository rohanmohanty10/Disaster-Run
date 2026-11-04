 

local u1 = game.Players.LocalPlayer
game:GetService("RunService")
local u2 = game:GetService("ReplicatedStorage")
local u3 = require(game.ReplicatedStorage.Modules.Skills)
local u4 = require(script.Parent.Parent.MobileBase)
require(u1.PlayerScripts:WaitForChild("PlayerModule"))
game:GetService("UserInputService")
u1:GetMouse()
local u5 = setmetatable({}, u4)
u5.__index = u5
function u5.new(_, _, _) --[[ Line: 20 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u5
        [3] = u1
    --]]
    local v6 = u4.new(script.Name)
    local v7 = u5
    local u8 = setmetatable(v6, v7)
    u8.Cooldowns = {
        ["BarrierC"] = false,
        ["Sphere"] = false,
        ["Stairs"] = false,
        ["Smash"] = false,
        ["Spike"] = false
    }
    local u9 = u1.Character
    u8.crosshold = u9.Humanoid:LoadAnimation(script.crosshold)
    function u8.release(p10) --[[ Line: 29 ]]
        --[[
        Upvalues:
            [1] = u9
        --]]
        local v11 = u9.Humanoid:LoadAnimation(script[p10])
        v11:Play()
        v11:AdjustWeight(2)
        task.wait(0.3)
        return v11
    end
    function u8.hold() --[[ Line: 37 ]]
        --[[
        Upvalues:
            [1] = u8
        --]]
        u8.crosshold:Play()
        task.spawn(function() --[[ Line: 39 ]]
            --[[
            Upvalues:
                [1] = u8
            --]]
            _G.PauseAnim(u8.crosshold, 0.4, 1)
        end)
        task.wait(0.4)
    end
    return u8
end
function u5.BarrierCrash(p12, p13) --[[ Line: 48 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v14 = p12.Cooldowns
    local u15 = u1.Character
    local u16 = u2["Stats" .. u1.Name]
    if v14.BarrierC == false and (_G.check:inspect(u15) == true and _G.StamCheck("Barrier Crash") == true) then
        local v17 = u3.GetM("Barrier Crash")
        local v18 = v17.cd
        if _G.StamCheck("Barrier Crash") == false then
            return
        end
        if v17.statreq and _G.MeetReq(v17.statreq) == false then
            return
        end
        v14.BarrierC = true
        _G.canuse = false
        p12.hold()
        local v19 = game.ReplicatedStorage.Events.Skill:InvokeServer("Barrier Crash", {})
        local v20, u21
        if v19 then
            v20, u21 = unpack(v19)
        else
            u21 = nil
            v20 = nil
        end
        local u22 = tick()
        local function v23() --[[ Line: 75 ]]
            --[[
            Upvalues:
                [1] = u21
                [2] = u22
            --]]
            if u21 and u21.PrimaryPart ~= nil then
                u21.PrimaryPart.CanCollide = false
            end
            if tick() - u22 >= 30 then
                return false
            end
        end
        p12:ToggleSkill(p13, {
            ["Key"] = Enum.KeyCode.E,
            ["CheckFunction"] = v23,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 84 ]]
                --[[
                Upvalues:
                    [1] = u15
                    [2] = u16
                --]]
                if not u15:FindFirstChild(script.Name) or (u15.Parent == nil or (u15.Parent ~= workspace.PlayerCharacters or u16.Stamina.Value <= 0)) then
                    return true
                end
            end,
            ["IgnoreInstantCastSetting"] = true
        })
        p12.crosshold:Stop()
        if v20 then
            p12.release("crash")
            if v20:IsDescendantOf(game) then
                v20:InvokeServer()
            end
        end
        if u21 and u21.PrimaryPart ~= nil then
            u21.PrimaryPart.CanCollide = true
        end
        task.wait(0.25)
        _G.canuse = true
        _G.keysetup:cooldown("Barrier Crash", v18)
        _G.fw(v18)
        v14.BarrierC = false
    end
end
function u5.BarrierSphere(p24, p25) --[[ Line: 116 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v26 = p24.Cooldowns
    local u27 = u1.Character
    local u28 = u2["Stats" .. u1.Name]
    if v26.Sphere == false and (_G.check:inspect(u27) == true and _G.StamCheck("Barrier Sphere") == true) then
        local v29 = u3.GetM("Barrier Sphere")
        local v30 = v29.cd
        if _G.StamCheck("Barrier Sphere") == false then
            return
        end
        if v29.statreq and _G.MeetReq(v29.statreq) == false then
            return
        end
        v26.Sphere = true
        _G.canuse = false
        local u31 = tick()
        local v32 = p24.release("sphere")
        v32:AdjustSpeed(0)
        local u33 = game.ReplicatedStorage.Events.Skill:InvokeServer("Barrier Sphere", {
            ["cf"] = p24:GetMouseCFrame()
        })
        p24:ToggleSkill(p25, {
            ["Key"] = Enum.KeyCode.R,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 137 ]]
                --[[
                Upvalues:
                    [1] = u28
                    [2] = u27
                    [3] = u31
                    [4] = u33
                --]]
                if u28.Stamina.Value <= 0 or (not u27:FindFirstChild(script.Name) or (u27.Parent == nil or (u27.Parent ~= workspace.PlayerCharacters or (tick() - u31 >= 60 or u27:findFirstChild("Stun"))))) then
                    return true
                end
                if u33 and u33:GetAttribute("released") then
                    return true
                end
            end,
            ["IgnoreInstantCastSetting"] = true
        })
        v32:Stop()
        if u33 and u33:GetAttribute("released") == nil then
            task.spawn(function() --[[ Line: 157 ]]
                --[[
                Upvalues:
                    [1] = u33
                --]]
                u33:InvokeServer()
            end)
        end
        task.wait(0.25)
        _G.canuse = true
        _G.keysetup:cooldown("Barrier Sphere", v30)
        _G.fw(v30)
        v26.Sphere = false
    end
end
function u5.BarrierStairs(p34, p35) --[[ Line: 170 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v36 = p34.Cooldowns
    local u37 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v36.Stairs == false and (_G.check:inspect(u37) == true and _G.StamCheck("Barrier Stairs") == true) then
        local v38 = u3.GetM("Barrier Stairs")
        local v39 = v38.cd
        if _G.StamCheck("Barrier Stairs") == false then
            return
        end
        if v38.statreq and _G.MeetReq(v38.statreq) == false then
            return
        end
        if v38.customCDInfo.FunctionCheck(u1, u37) == false then
            return
        end
        v36.Stairs = true
        _G.canuse = false
        local v40 = p34.release("stair")
        v40:AdjustSpeed(0)
        local v41 = game.ReplicatedStorage.Events.Skill:InvokeServer("Barrier Stairs", {
            ["cf"] = p34:GetMouseCFrame()
        })
        p34:ToggleSkill(p35, {
            ["Key"] = Enum.KeyCode.Z,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 194 ]]
                --[[
                Upvalues:
                    [1] = u37
                --]]
                if u37:FindFirstChild("Stun") or (not u37:FindFirstChild(script.Name) or (u37.Parent == nil or u37.Parent ~= workspace.PlayerCharacters)) then
                    return true
                end
            end,
            ["IgnoreInstantCastSetting"] = true
        })
        v40:Stop()
        _G.canuse = true
        if v41 then
            v41:InvokeServer()
        end
        if v38.customCDInfo.FunctionCheck(u1, u37) == false and v39 >= 0.1 then
            v39 = v38.customCDInfo.FullCooldown
        end
        _G.keysetup:cooldown("Barrier Stairs", v39)
        _G.fw(v39)
        v36.Stairs = false
    end
end
function u5.BarrierCage(u42, p43) --[[ Line: 224 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v44 = u42.Cooldowns
    local u45 = u1.Character
    local u46 = u2["Stats" .. u1.Name]
    if v44.Smash == false and (_G.check:inspect(u45) == true and _G.StamCheck("Barrier Cage") == true) then
        local v47 = u3.GetM("Barrier Cage")
        local v48 = v47.cd
        if _G.StamCheck("Barrier Cage") == false then
            return
        end
        if v47.statreq and _G.MeetReq(v47.statreq) == false then
            return
        end
        v44.Smash = true
        _G.canuse = false
        u42.hold()
        local v49 = game.ReplicatedStorage.Events.Skill:InvokeServer("Barrier Cage", {
            ["cf"] = u42:GetMouseCFrame()
        })
        u42:ToggleSkill(p43, {
            ["Key"] = Enum.KeyCode.X,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 244 ]]
                --[[
                Upvalues:
                    [1] = u45
                    [2] = u46
                --]]
                if u45:FindFirstChild("Stun") or (not u45:FindFirstChild(script.Name) or (u45.Parent == nil or (u45.Parent ~= workspace.PlayerCharacters or u46.Stamina.Value <= 0))) then
                    return true
                end
            end,
            ["IgnoreInstantCastSetting"] = true
        })
        u42.crosshold:Stop()
        if v49 then
            task.spawn(function() --[[ Line: 259 ]]
                --[[
                Upvalues:
                    [1] = u42
                --]]
                u42.release("cage")
            end)
            v49:InvokeServer()
        end
        _G.canuse = true
        _G.keysetup:cooldown("Barrier Cage", v48)
        _G.fw(v48)
        v44.Smash = false
    end
end
function u5.BarrierSpikes(p50, p51) --[[ Line: 271 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v52 = p50.Cooldowns
    local u53 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v52.Spike == false and (_G.check:inspect(u53) == true and _G.StamCheck("Barrier Spikes") == true) then
        local v54 = u3.GetM("Barrier Spikes")
        local v55 = v54.cd
        if _G.StamCheck("Barrier Spikes") == false then
            return
        end
        if v54.statreq and _G.MeetReq(v54.statreq) == false then
            return
        end
        v52.Spike = true
        _G.canuse = false
        local v56 = u53.Humanoid:LoadAnimation(script.spike)
        v56:Play()
        v56:AdjustSpeed(0)
        v56:AdjustWeight(2)
        local v57 = game.ReplicatedStorage.Events.Skill:InvokeServer("Barrier Spikes", {
            ["cf"] = p50:GetMouseCFrame()
        })
        p50:ChargeSkill(p51, {
            ["Key"] = Enum.KeyCode.C,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 294 ]]
                --[[
                Upvalues:
                    [1] = u53
                --]]
                if u53:FindFirstChild("Stun") or (not u53:FindFirstChild(script.Name) or (u53.Parent == nil or u53.Parent ~= workspace.PlayerCharacters)) then
                    return true
                end
            end,
            ["IgnoreInstantCastSetting"] = true
        })
        v56:AdjustSpeed(1)
        task.wait(0.3)
        if v57 then
            v57:InvokeServer()
        end
        _G.canuse = true
        _G.keysetup:cooldown("Barrier Spikes", v55)
        _G.fw(v55)
        v52.Spike = false
    end
end
return u5