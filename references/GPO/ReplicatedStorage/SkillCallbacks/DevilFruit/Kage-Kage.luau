 

local u1 = game.Players.LocalPlayer
game:GetService("RunService")
local u2 = game:GetService("ReplicatedStorage")
local u3 = require(game.ReplicatedStorage.Modules.Skills)
local u4 = require(script.Parent.Parent.MobileBase)
require(u1.PlayerScripts:WaitForChild("PlayerModule"))
local u5 = game:GetService("UserInputService")
u1:GetMouse()
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
        ["batspin"] = false,
        ["blackbox"] = false,
        ["batdrill"] = false,
        ["burrow"] = false,
        ["clone"] = false,
        ["lizard"] = false
    }
    return v9
end
function u6.BatTornado(p10, _) --[[ Line: 28 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v11 = p10.Cooldowns
    local v12 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v11.batspin == false and (_G.check:inspect(v12) == true and _G.StamCheck("Bat Tornado") == true) then
        local v13 = u3.GetM("Bat Tornado")
        local v14 = v13.cd
        if _G.StamCheck("Bat Tornado") == false then
            return
        end
        if v13.statreq and _G.MeetReq(v13.statreq) == false then
            return
        end
        v11.batspin = true
        _G.canuse = false
        local v15 = v12.Humanoid:LoadAnimation(script.batwind)
        v15:Play()
        v15:AdjustSpeed(1.5)
        task.wait(0.25)
        game.ReplicatedStorage.Events.Skill:InvokeServer("Bat Tornado", {
            ["cf"] = p10:GetMouseCFrame()
        })
        _G.canuse = true
        _G.keysetup:cooldown("Bat Tornado", v14)
        _G.fw(v14)
        v11.batspin = false
    end
end
function u6.ShadowTrap(p16, _) --[[ Line: 59 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v17 = p16.Cooldowns
    local v18 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v17.blackbox == false and (_G.check:inspect(v18) == true and _G.StamCheck("Shadow Trap") == true) then
        local v19 = u3.GetM("Shadow Trap")
        local v20 = v19.cd
        if _G.StamCheck("Shadow Trap") == false then
            return
        end
        if v19.statreq and _G.MeetReq(v19.statreq) == false then
            return
        end
        v17.blackbox = true
        _G.canuse = false
        game.ReplicatedStorage.Events.Skill:InvokeServer("Shadow Trap", p16:GetMouseCFrame())
        local v21 = v18.Humanoid:LoadAnimation(script.blackbox)
        v21:Play()
        v21:AdjustWeight(2)
        v21:AdjustSpeed(1.1)
        task.wait(2)
        _G.canuse = true
        _G.keysetup:cooldown("Shadow Trap", v20)
        _G.fw(v20)
        v17.blackbox = false
    end
end
function u6.FleeingShadows(p22, _) --[[ Line: 90 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v23 = p22.Cooldowns
    local v24 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if _G.grounded == false and (v23.batdrill == false and (_G.check:inspect(v24) == true and _G.StamCheck("Fleeing Shadows") == true)) then
        local v25 = u3.GetM("Fleeing Shadows")
        local v26 = v25.cd
        if _G.StamCheck("Fleeing Shadows") == false then
            return
        end
        if v25.statreq and _G.MeetReq(v25.statreq) == false then
            return
        end
        v23.batdrill = true
        _G.canuse = false
        local v27 = v24.Humanoid:LoadAnimation(script.batStart)
        v27:Play()
        v27:AdjustWeight(2)
        game.ReplicatedStorage.Events.Skill:InvokeServer("Fleeing Shadows", p22:GetMouseCFrame())
        v24.Humanoid:LoadAnimation(script.batEnd):Play()
        _G.canuse = true
        _G.keysetup:cooldown("Fleeing Shadows", v26)
        _G.fw(v26)
        v23.batdrill = false
    end
end
function u6.BurrowingShadows(p28, _) --[[ Line: 121 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v29 = p28.Cooldowns
    local v30 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v29.burrow == false and (_G.check:inspect(v30) == true and _G.StamCheck("Burrowing Shadows") == true) then
        local v31 = u3.GetM("Burrowing Shadows")
        local v32 = v31.cd
        if _G.StamCheck("Burrowing Shadows") == false then
            return
        end
        if v31.statreq and _G.MeetReq(v31.statreq) == false then
            return
        end
        if _G.getRayFloor(v30.PrimaryPart.CFrame, 10) == nil then
            return
        end
        v29.burrow = true
        _G.canuse = false
        local v33 = v30.Humanoid:LoadAnimation(script.burrow)
        v33:Play()
        v33:AdjustSpeed(2)
        task.wait(0.3)
        game.ReplicatedStorage.Events.Skill:InvokeServer("Burrowing Shadows", p28:GetMouseCFrame())
        task.wait(0.45)
        _G.canuse = true
        _G.keysetup:cooldown("Burrowing Shadows", v32)
        _G.fw(v32)
        v29.burrow = false
    end
end
function u6.ShadowsGrasp(p34, _) --[[ Line: 158 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v35 = p34.Cooldowns
    local v36 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v35.lizard == false and (_G.check:inspect(v36) == true and _G.StamCheck("Shadows Grasp") == true) then
        local v37 = u3.GetM("Shadows Grasp")
        local v38 = v37.cd
        if _G.StamCheck("Shadows Grasp") == false then
            return
        end
        if v37.statreq and _G.MeetReq(v37.statreq) == false then
            return
        end
        v35.lizard = true
        _G.canuse = false
        game.ReplicatedStorage.Events.Skill:InvokeServer("Shadows Grasp", p34:GetMouseCFrame())
        local v39 = v36.Humanoid:LoadAnimation(script.hand)
        v39:Play()
        v39:AdjustWeight(2)
        task.wait(1)
        _G.canuse = true
        _G.keysetup:cooldown("Shadows Grasp", v38)
        _G.fw(v38)
        v35.lizard = false
    end
end
u6["Sillhouette\'sAssault"] = function(p40, _) --[[ Line: 189 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
        [4] = u5
    --]]
    local v41 = p40.Cooldowns
    local u42 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v41.clone == false and (_G.check:inspect(u42) == true and _G.StamCheck("Sillhouette\'s Assault") == true) then
        local v43 = u3.GetM("Sillhouette\'s Assault")
        local v44 = v43.cd
        if _G.StamCheck("Sillhouette\'s Assault") == false then
            return
        end
        if v43.statreq and _G.MeetReq(v43.statreq) == false then
            return
        end
        if _G.getRayFloor(u42.PrimaryPart.CFrame, 10) == nil then
            return
        end
        v41.clone = true
        _G.canuse = false
        local u45 = false
        local u46 = game.ReplicatedStorage.Events.Skill:InvokeServer("Sillhouette\'s Assault", p40:GetMouseCFrame())
        if u46 then
            u46.OnClientEvent:Connect(function() --[[ Line: 215 ]]
                --[[
                Upvalues:
                    [1] = u45
                --]]
                u45 = true
            end)
        end
        local u47 = nil
        u47 = u5.InputBegan:Connect(function(p48, p49) --[[ Line: 220 ]]
            --[[
            Upvalues:
                [1] = u42
                [2] = u46
                [3] = u47
                [4] = u45
            --]]
            if p48.KeyCode == Enum.KeyCode.C and (u42:FindFirstChild(script.Name) and p49 ~= true) then
                if u46 then
                    u46:FireServer()
                end
                u47:Disconnect()
                u47 = nil
                u45 = true
            end
        end)
        _G.canuse = true
        repeat
            task.wait()
        until u45 == true
        _G.keysetup:cooldown("Sillhouette\'s Assault", v44)
        _G.fw(v44)
        v41.clone = false
    end
end
return u6