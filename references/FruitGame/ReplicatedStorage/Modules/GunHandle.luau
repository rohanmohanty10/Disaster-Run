 

local u1 = {}
u1.__index = u1
local v2 = require(game.ReplicatedStorage.Modules.MaidClass)
local u3
if game["Run Service"]:IsClient() == true then
    u3 = game.ReplicatedStorage.Events:WaitForChild("GunManager")
else
    u3 = nil
end
local u4 = v2.new()
local u5, u6
if game:GetService("RunService"):IsServer() == false then
    local v7, v8, v9
    u5, u6, v7, v8, v9 = require(game.ReplicatedStorage.Modules.ScriptSet).get()
else
    u5 = nil
    u6 = nil
end
local u10 = nil
local u11 = {}
local u12 = {
    ["Bazooka"] = 0.65,
    ["Burn Bazooka"] = 0.5,
    ["Rifle"] = 0.3,
    ["Pistol"] = 0.5,
    ["Shotgun"] = 0.92,
    ["Galt"] = 0.5
}
u1.aimTimes = u12
local u13 = {
    ["Bazooka"] = 4,
    ["Burn Bazooka"] = 5.2,
    ["Rifle"] = 1.3,
    ["Pistol"] = 1.25,
    ["Shotgun"] = 1,
    ["Galt"] = 8
}
u1.reloadTimes = u13
local u14 = {
    ["Galt"] = true
}
local u15 = {
    ["Galt"] = 1002323
}
u1.revs = u14
u1.chargeables = {
    ["Burn Bazooka"] = { 4.5, 1 }
}
u1.maxcharge = {
    ["Burn Bazooka"] = 5
}
u1.revAmm = u15
local u16 = {
    ["Bazooka"] = "Explosive",
    ["Burn Bazooka"] = "Explosive",
    ["Rifle"] = "Normal",
    ["Pistol"] = "Normal",
    ["Shotgun"] = "Spread",
    ["Galt"] = "Spread"
}
function u1.getAimTimes(_) --[[ Line: 73 ]]
    --[[
    Upvalues:
        [1] = u12
    --]]
    return u12
end
function u1.getReloadTimes(_) --[[ Line: 77 ]]
    --[[
    Upvalues:
        [1] = u13
    --]]
    return u13
end
function u1.getRevs(_) --[[ Line: 81 ]]
    --[[
    Upvalues:
        [1] = u14
    --]]
    return u14
end
function u1.getRevsAm(_) --[[ Line: 85 ]]
    --[[
    Upvalues:
        [1] = u15
    --]]
    return u15
end
function u1.getIcons(_) --[[ Line: 89 ]]
    --[[
    Upvalues:
        [1] = u16
    --]]
    return u16
end
local function u21(p17) --[[ Line: 100 ]]
    --[[
    Upvalues:
        [1] = u5
    --]]
    local v18 = u5.Character
    if p17 == "Bazooka" then
        local v19 = Instance.new("BodyVelocity", v18.HumanoidRootPart)
        v19.MaxForce = Vector3.new(1000000000, 1000000000, 1000000000)
        v19.Velocity = v18.HumanoidRootPart.CFrame.lookVector * -50
        _G.destroy(v19, 0.1)
    elseif p17 == "Burn Bazooka" then
        local v20 = Instance.new("BodyVelocity", v18.HumanoidRootPart)
        v20.MaxForce = Vector3.new(1000000000, 1000000000, 1000000000)
        v20.Velocity = v18.HumanoidRootPart.CFrame.lookVector * -75
        _G.destroy(v20, 0.1)
    end
end
function u1.New(p22, p23) --[[ Line: 115 ]]
    --[[
    Upvalues:
        [1] = u10
        [2] = u11
        [3] = u4
        [4] = u1
    --]]
    if script.Guns:FindFirstChild(p22) ~= nil then
        local v24 = game.Players.LocalPlayer.Character
        if game["Run Service"]:IsClient() == true then
            if u10 == nil then
                u10 = v24
            elseif u10 and (u10 ~= v24 and u11[u10] ~= nil) then
                table.clear(u11[u10])
                u11[u10] = nil
            end
        end
        if u11[v24] == nil then
            u11 = {
                [v24] = {}
            }
        end
        local v25 = script.Guns:FindFirstChild(p22)
        local v26 = v24.Humanoid:LoadAnimation(v25.Idle)
        local v27 = v24.Humanoid:LoadAnimation(v25.Aim)
        local v28 = v24.Humanoid:LoadAnimation(v25.Aim2)
        local v29 = v24.Humanoid:LoadAnimation(v25.Fire)
        local v30 = v24.Humanoid:LoadAnimation(v25.Reload)
        v26.Priority = Enum.AnimationPriority.Movement
        v28.Priority = Enum.AnimationPriority.Action
        v30.Priority = Enum.AnimationPriority.Action
        local u31 = nil
        local v33 = {
            ["Reloaded"] = true,
            ["Ready"] = true,
            ["Equiped"] = true,
            ["IsAiming"] = false,
            ["Reved"] = false,
            ["EqId"] = nil,
            ["Name"] = p22,
            ["Tool"] = p23,
            ["Anims"] = {
                ["idle"] = v26,
                ["aim"] = v27,
                ["aimHold"] = v28,
                ["fire"] = v29,
                ["reload"] = v30
            },
            ["term"] = function() --[[ Name: term, Line 156 ]]
                --[[
                Upvalues:
                    [1] = u31
                    [2] = u4
                --]]
                table.clear(u31)
                u4[u31] = nil
                local v32 = u31
                setmetatable(v32, nil)
            end
        }
        u31 = v33
        local v34 = u11[v24]
        local v35 = u31
        table.insert(v34, v35)
        local v36 = u1
        local v37 = u31
        setmetatable(v37, v36)
        u4[u31] = u31
        return u31
    end
end
function u1.Aim(p38) --[[ Line: 168 ]]
    --[[
    Upvalues:
        [1] = u12
    --]]
    if p38.Equiped == false then
        warn("equiped is False")
    elseif p38.Anims.aim.IsPlaying == false and (p38.IsAiming == false and (p38.Ready == true and p38.Reloaded == true)) then
        p38.Anims.aim:Play()
        script.AimSFX:Play()
        _G.TurnCharacterToMouse = true
        p38.Ready = false
        local v39 = tick()
        repeat
            game["Run Service"].RenderStepped:Wait()
        until tick() - v39 >= u12[p38.Name] or p38.Anims.aim.TimePosition >= u12[p38.Name]
        p38.Ready = true
        if p38.Equiped == true then
            p38.Anims.aim:AdjustSpeed(0)
            p38.Anims.aimHold:Play(0)
            p38.IsAiming = true
            return
        end
    elseif p38.Reloaded == false and p38.Ready == true then
        script.NOAMMO:Play()
    end
end
local u40 = {}
function u1.Rev(p41, p42) --[[ Line: 191 ]]
    --[[
    Upvalues:
        [1] = u14
        [2] = u6
        [3] = u40
    --]]
    if p41.Equiped == false then
        return
    elseif p41.Anims.IsAiming == false then
        return
    elseif u14[p41.Name] == nil then
        return
    else
        local v43 = u6:FindFirstChild(p41.Name .. "Gun")
        if v43 ~= nil then
            local v44 = script.Customs:FindFirstChild(p41.Name)
            if u40[u6] == nil then
                u40[u6] = {}
            end
            if v44 then
                if u40[u6][p41.Name] == nil then
                    u40[u6][p41.Name] = require(script.Customs[p41.Name])
                end
                u40[u6][p41.Name]:Rev(v43, p42, p41)
            end
        end
    end
end
function u1.Fire(u45, p46) --[[ Line: 218 ]]
    --[[
    Upvalues:
        [1] = u5
        [2] = u3
        [3] = u21
    --]]
    if u45.Equiped ~= false then
        local v47 = u5.Character
        if u45.IsAiming == true and (u45.Reloaded == true and (v47:FindFirstChild(u45.Name .. "Gun") and (u45.Ready == true and v47:FindFirstChild("Blocking") == nil))) then
            u45.Ready = false
            u45.IsAiming = false
            local v48 = p46 == nil and {} or p46
            v48.Gun = u45.Name
            v48.Position = _G.MouseCF.p
            v48.Start = v47:FindFirstChild(u45.Name .. "Gun").Hole.CFrame
            v48.joe = "true"
            u3:FireServer("fire", v48)
            task.wait(0.1)
            u21(u45.Name)
            u45.Anims.aimHold:Stop()
            u45.Anims.aim:Stop()
            u45.Reloaded = false
            u45.Anims.fire:Play()
            task.spawn(function() --[[ Line: 240 ]]
                --[[
                Upvalues:
                    [1] = u45
                --]]
                u45.Anims.fire.Stopped:Wait()
                _G.TurnCharacterToMouse = false
            end)
            task.wait(0.5)
            u45.Ready = true
        end
    end
end
function u1.GetCharge(p49) --[[ Line: 249 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    return u3.gunFunctions:InvokeServer("charge", {
        ["Gun"] = p49.Name
    })
end
local function u53(_) --[[ Line: 252 ]]
    local v50 = game.Players.LocalPlayer.Character
    local v51 = Ray.new(v50.HumanoidRootPart.CFrame.p, CFrame.new(v50.HumanoidRootPart.Position).upVector * -12)
    local v52, _, _ = _G.raycastWhitelist(v51, { workspace.Islands, workspace.Env, workspace.Ships })
    return v52 ~= nil
end
function u1.Reload(u54) --[[ Line: 262 ]]
    --[[
    Upvalues:
        [1] = u53
        [2] = u6
        [3] = u40
        [4] = u3
    --]]
    if u54.Equiped == false then
        return
    elseif u53(u6) == false then
        _G.displayMessage("<Color=Red>You need to be touching the ground to reload!")
    elseif u54.Reloaded == false and (u54.Equiped == true and u54.Ready == true) then
        u54.Ready = false
        local u55 = nil
        if script.Guns[u54.Name]:FindFirstChild("Reload1") == nil then
            u54.Anims.reload:Play()
            if script.Guns:FindFirstChild(u54.Name).Reload:FindFirstChild("Speed") then
                u54.Anims.reload:AdjustSpeed(script.Guns:FindFirstChild(u54.Name).Reload:FindFirstChild("Speed").Value)
            end
            local v56 = game["Run Service"].Heartbeat:Connect(function() --[[ Line: 278 ]]
                --[[
                Upvalues:
                    [1] = u6
                    [2] = u54
                    [3] = u55
                --]]
                if _G.check:inspect(u6) == false or u6:FindFirstChild(u54.Name .. "Gun") == nil then
                    u54.Anims.reload:Stop()
                    u55:Disconnect()
                    u55 = nil
                end
            end)
            u55 = v56
        else
            u40[u6][u54.Name]:Reload(u6, u54.Name, u54)
        end
        local v57 = game:GetService("HttpService"):GenerateGUID(true)
        u54.EqId = v57
        local v58 = u3.gunFunctions:InvokeServer("reload", {
            ["Gun"] = u54.Name
        })
        if u55 then
            u55:Disconnect()
        end
        u54.Ready = true
        if u54.Equiped == true and v57 == u54.EqId then
            if u54.StartRev ~= nil then
                u54.StartRev = nil
            end
            u54.Reloaded = v58
        end
    end
end
if game["Run Service"]:IsClient() then
    u3.OnClientEvent:Connect(function(p59, p60, p61) --[[ Line: 308 ]]
        if p59 ~= game.Players.LocalPlayer then
            if p60 == "velocity" then
                p61.m.MaxVelocity = p61.val
            end
        end
    end)
    game["Run Service"].Heartbeat:Connect(function() --[[ Line: 317 ]]
        --[[
        Upvalues:
            [1] = u11
        --]]
        for v62, v63 in u11 do
            if v62 == nil or v62.Parent == nil then
                for v64 = 1, #v63 do
                    local v65 = v63[v64]
                    if v65 then
                        v65:term()
                    end
                end
                u11[v62] = nil
            end
        end
    end)
end
return u1