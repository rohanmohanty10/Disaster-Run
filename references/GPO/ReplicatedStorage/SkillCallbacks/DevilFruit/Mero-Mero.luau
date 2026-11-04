 

local u1 = game.Players.LocalPlayer
game:GetService("RunService")
local u2 = game:GetService("ReplicatedStorage")
local u3 = require(game.ReplicatedStorage.Modules.Skills)
local u4 = require(script.Parent.Parent.MobileBase)
require(u1.PlayerScripts:WaitForChild("PlayerModule"))
u1:GetMouse()
local u5 = setmetatable({}, u4)
u5.__index = u5
function u5.new(_) --[[ Line: 18 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u5
    --]]
    local v6 = u4.new(script.Name)
    local v7 = u5
    local v8 = setmetatable(v6, v7)
    v8.Cooldowns = {
        ["burst"] = false,
        ["wave"] = false,
        ["charm"] = false,
        ["fem"] = false,
        ["pistol"] = false,
        ["bomb"] = false
    }
    v8.CurrentSwipe = 1
    return v8
end
function u5.LoveBurst(p9, p10) --[[ Line: 30 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v11 = p9.Cooldowns
    local u12 = u1.Character
    local u13 = u2["Stats" .. u1.Name]
    if v11.burst == false and (_G.check:inspect(u12) == true and _G.StamCheck("Love Burst") == true) then
        local v14 = u3.GetM("Love Burst")
        local v15 = v14.cd
        if _G.StamCheck("Love Burst") == false then
            return
        end
        if v14.statreq and _G.MeetReq(v14.statreq) == false then
            return
        end
        _G.canuse = false
        local v16 = game.ReplicatedStorage.Events.Skill:InvokeServer("Love Burst", {
            ["cf"] = p9:GetMouseCFrame()
        })
        if v16 == nil then
            _G.canuse = true
            return
        end
        local v17, v18 = unpack(v16)
        v11.burst = true
        local v19 = u12.Humanoid:LoadAnimation(script.loveBurst)
        v19:Play()
        local u20 = v18.AnimationController:LoadAnimation(script.loveBurst)
        u20:Play()
        _G.FaceMouse = true
        task.spawn(function() --[[ Line: 61 ]]
            --[[
            Upvalues:
                [1] = u20
            --]]
            _G.PauseAnim(u20, 1.75, 1.5)
        end)
        _G.PauseAnim(v19, 1.75, 1.5)
        local u21 = tick()
        p9:ChargeSkill(p10, {
            ["Key"] = Enum.KeyCode.X,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 71 ]] end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 75 ]]
                --[[
                Upvalues:
                    [1] = u21
                    [2] = u12
                    [3] = u13
                --]]
                if tick() - u21 >= 10 or (not u12:FindFirstChild(script.Name) or (u12.Parent == nil or (u12.Parent ~= workspace.PlayerCharacters or u13.Stamina.Value <= 0))) then
                    return true
                end
            end
        })
        u12.HumanoidRootPart.Anchored = true
        _G.FaceMouse = false
        v19:AdjustSpeed(1)
        u20:AdjustSpeed(1)
        if v17 then
            v17:FireServer(u12.HumanoidRootPart.CFrame)
        end
        task.wait(0.65)
        u12.HumanoidRootPart.Anchored = false
        _G.canuse = true
        _G.keysetup:cooldown("Love Burst", v15)
        _G.fw(v15)
        v11.burst = false
    end
end
function u5.LoveWave(p22, p23) --[[ Line: 106 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v24 = p22.Cooldowns
    local u25 = u1.Character
    local u26 = u2["Stats" .. u1.Name]
    if v24.wave == false and (_G.check:inspect(u25) == true and _G.StamCheck("Love Wave") == true) then
        local v27 = u3.GetM("Love Wave")
        local v28 = v27.cd
        if _G.StamCheck("Love Wave") == false then
            return
        end
        if v27.statreq and _G.MeetReq(v27.statreq) == false then
            return
        end
        v24.wave = true
        _G.canuse = false
        local v29 = u25.Humanoid:LoadAnimation(script.ray)
        v29:Play()
        _G.FaceMouse = true
        _G.PauseAnim(v29, 0.3, 2)
        local u30 = tick()
        p22:ChargeSkill(p23, {
            ["Key"] = Enum.KeyCode.Z,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 133 ]] end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 137 ]]
                --[[
                Upvalues:
                    [1] = u30
                    [2] = u25
                    [3] = u26
                --]]
                if tick() - u30 >= 10 or (not u25:FindFirstChild(script.Name) or (u25.Parent == nil or (u25.Parent ~= workspace.PlayerCharacters or u26.Stamina.Value <= 0))) then
                    return true
                end
            end
        })
        u25.HumanoidRootPart.Anchored = true
        _G.FaceMouse = false
        v29:AdjustSpeed(2)
        task.wait(0.15)
        v29:AdjustSpeed(0)
        u25.Humanoid.AutoRotate = false
        game.ReplicatedStorage.Events.Skill:InvokeServer("Love Wave", {
            ["cf"] = u25.HumanoidRootPart.CFrame
        })
        task.wait(0.2)
        v29:Stop()
        u25.HumanoidRootPart.Anchored = false
        u25.Humanoid.AutoRotate = true
        task.wait(0.35)
        _G.canuse = true
        _G.keysetup:cooldown("Love Wave", v28)
        _G.fw(v28)
        v24.wave = false
    end
end
function u5.LoveBomb(p31, p32) --[[ Line: 170 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v33 = p31.Cooldowns
    local u34 = u1.Character
    local u35 = u2["Stats" .. u1.Name]
    if v33.bomb == false and (_G.check:inspect(u34) == true and _G.StamCheck("Love Bomb") == true) then
        local v36 = u3.GetM("Love Bomb")
        local v37 = v36.cd
        if _G.StamCheck("Love Bomb") == false then
            return
        end
        if v36.statreq and _G.MeetReq(v36.statreq) == false then
            return
        end
        _G.canuse = false
        local v38 = game.ReplicatedStorage.Events.Skill:InvokeServer("Love Bomb", {
            ["cf"] = p31:GetMouseCFrame()
        })
        if v38 == nil then
            _G.canuse = true
            return
        end
        local v39, _ = unpack(v38)
        v33.bomb = true
        local v40 = u34.Humanoid:LoadAnimation(script.bomb)
        v40:Play()
        _G.FaceMouse = true
        _G.PauseAnim(v40, 0.02, 1)
        local u41 = tick()
        p31:ChargeSkill(p32, {
            ["Key"] = Enum.KeyCode.R,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 204 ]] end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 208 ]]
                --[[
                Upvalues:
                    [1] = u41
                    [2] = u34
                    [3] = u35
                --]]
                if tick() - u41 >= 10 or (not u34:FindFirstChild(script.Name) or (u34.Parent == nil or (u34.Parent ~= workspace.PlayerCharacters or u35.Stamina.Value <= 0))) then
                    return true
                end
            end
        })
        u34.HumanoidRootPart.Anchored = true
        _G.FaceMouse = false
        v40:AdjustSpeed(1)
        local v42 = p31:GetMouseCFrame()
        task.wait(0.45)
        if v39 then
            v39:FireServer(u34.RightHand.CFrame, v42)
        end
        task.wait(0.5)
        u34.HumanoidRootPart.Anchored = false
        _G.canuse = true
        _G.keysetup:cooldown("Love Bomb", v37)
        _G.fw(v37)
        v33.bomb = false
    end
end
function u5.PerfumeFemur(p43, p44) --[[ Line: 241 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v45 = p43.Cooldowns
    local u46 = u1.Character
    local u47 = u2["Stats" .. u1.Name]
    if v45.fem == false and (_G.check:inspect(u46) == true and _G.StamCheck("Perfume Femur") == true) then
        local v48 = u3.GetM("Perfume Femur")
        local v49 = v48.cd
        if _G.StamCheck("Perfume Femur") == false then
            return
        end
        if v48.statreq and _G.MeetReq(v48.statreq) == false then
            return
        end
        v45.fem = true
        _G.canuse = false
        local u50 = u46.Humanoid:LoadAnimation(script.fem)
        u50:Play()
        u46.Humanoid.WalkSpeed = 4
        _G.PauseAnim(u50, 0.5, 1.5)
        tick()
        p43:ChargeSkill(p44, {
            ["Key"] = Enum.KeyCode.C,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 267 ]]
                --[[
                Upvalues:
                    [1] = u46
                --]]
                u46.Humanoid.WalkSpeed = 4
            end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 272 ]]
                --[[
                Upvalues:
                    [1] = u46
                    [2] = u47
                --]]
                if not u46:FindFirstChild(script.Name) or (u46.Parent == nil or (u46.Parent ~= workspace.PlayerCharacters or u47.Stamina.Value <= 0)) then
                    return true
                end
            end
        })
        u50:AdjustSpeed(1)
        local u51 = game.ReplicatedStorage.Events.Skill:InvokeServer("Perfume Femur", {
            ["cf"] = u46.HumanoidRootPart.CFrame
        })
        local u52 = Instance.new("BodyVelocity", u46.HumanoidRootPart)
        u52.MaxForce = Vector3.new(1000000, 0, 1000000)
        u52.Velocity = u46.HumanoidRootPart.CFrame.LookVector * 125
        _G.destroy(u52, 0.1)
        local u53 = false
        local function v55(p54) --[[ Line: 294 ]]
            --[[
            Upvalues:
                [1] = u52
                [2] = u51
                [3] = u46
            --]]
            u52:Destroy()
            u52 = nil
            u51:FireServer(p54.Parent, u46.HumanoidRootPart.CFrame)
        end
        local function v56() --[[ Line: 299 ]]
            --[[
            Upvalues:
                [1] = u52
                [2] = u53
                [3] = u50
            --]]
            u52:Destroy()
            u52 = nil
            u53 = true
            u50:Stop()
        end
        _G.hitbox:start(u46, Vector3.new(9, 9, 9), 0.3, CFrame.new(0, 0, -2), v55, v56)
        u46.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Perfume Femur", v49)
        _G.fw(v49)
        v45.fem = false
    end
end
function u5.LovePistol(p57, p58) --[[ Line: 319 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v59 = p57.Cooldowns
    local u60 = u1.Character
    local u61 = u2["Stats" .. u1.Name]
    if v59.pistol == false and (_G.check:inspect(u60) == true and _G.StamCheck("Love Pistol") == true) then
        local v62 = u3.GetM("Love Pistol")
        local v63 = v62.cd
        if _G.StamCheck("Love Pistol") == false then
            return
        end
        if v62.statreq and _G.MeetReq(v62.statreq) == false then
            return
        end
        v59.pistol = true
        _G.canuse = false
        local v64 = game.ReplicatedStorage.Events.Skill:InvokeServer("Love Pistol", {
            ["cf"] = u60.HumanoidRootPart.CFrame
        })
        if v64 == nil then
            _G.canuse = true
            v59.pistol = false
            return
        end
        local v65, _ = unpack(v64)
        local v66 = u60.Humanoid:LoadAnimation(script.pistol)
        v66:Play()
        _G.FaceMouse = true
        _G.PauseAnim(v66, 0.65, 1.5)
        local u67 = tick()
        p57:ChargeSkill(p58, {
            ["Key"] = Enum.KeyCode.E,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 358 ]]
                --[[
                Upvalues:
                    [1] = u60
                    [2] = u67
                    [3] = u61
                --]]
                if not u60:FindFirstChild(script.Name) or (tick() - u67 >= 10 or (u60.Parent == nil or (u60.Parent ~= workspace.PlayerCharacters or u61.Stamina.Value <= 0))) then
                    return true
                end
            end
        })
        v66:AdjustSpeed(2)
        _G.FaceMouse = false
        u60.HumanoidRootPart.Anchored = true
        if v65 then
            v65:FireServer(u60.HumanoidRootPart.CFrame, p57:GetMouseCFrame(), u60.RightHand.CFrame)
        end
        task.wait(0.2)
        u60.HumanoidRootPart.Anchored = false
        _G.canuse = true
        _G.keysetup:cooldown("Love Pistol", v63)
        _G.fw(v63)
        v59.pistol = false
    end
end
return u5