 

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
function u5.new(_) --[[ Line: 21 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u5
    --]]
    local v6 = u4.new(script.Name)
    local v7 = u5
    local v8 = setmetatable(v6, v7)
    v8.Cooldowns = {
        ["goldenFist"] = false,
        ["path"] = false,
        ["touch"] = false,
        ["field"] = false,
        ["age"] = false,
        ["Judgement"] = false
    }
    return v8
end
function u5.GoldenFist(u9, p10) --[[ Line: 28 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v11 = u9.Cooldowns
    local u12 = u1.Character
    local u13 = u2["Stats" .. u1.Name]
    if v11.goldenFist == false and (_G.check:inspect(u12) == true and _G.StamCheck("Golden Fist") == true) then
        local v14 = u3.GetM("Golden Fist")
        local v15 = v14.cd
        if _G.StamCheck("Golden Fist") == false then
            return
        end
        if v14.statreq and _G.MeetReq(v14.statreq) == false then
            return
        end
        _G.canuse = false
        v11.goldenFist = true
        _G.FaceMouse = true
        local v16 = game.ReplicatedStorage.Events.Skill:InvokeServer("Golden Fist")
        local u17 = tick()
        u9:ChargeSkill(p10, {
            ["Key"] = Enum.KeyCode.E,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 53 ]]
                --[[
                Upvalues:
                    [1] = u17
                    [2] = u9
                    [3] = u12
                    [4] = u13
                --]]
                if tick() - u17 >= 4 or (u9.Tool.Parent ~= u12 or (u12.Parent == nil or (u12.Parent ~= workspace.PlayerCharacters or u13.Stamina.Value <= 0))) then
                    return true
                end
            end,
            ["HoldDuration"] = 0.4400000000000001
        })
        u12.HumanoidRootPart.Anchored = true
        _G.FaceMouse = false
        task.wait()
        u12.Humanoid.AutoRotate = false
        if v16 then
            v16:FireServer(u12.HumanoidRootPart.CFrame)
        end
        task.wait(1)
        u12.Humanoid.AutoRotate = true
        u12.HumanoidRootPart.Anchored = false
        _G.canuse = true
        _G.keysetup:cooldown("Golden Fist", v15)
        _G.fw(v15)
        v11.goldenFist = false
    end
end
function u5.GoldenPath(p18, p19) --[[ Line: 84 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v20 = p18.Cooldowns
    local u21 = u1.Character
    local u22 = u2:FindFirstChild("Stats" .. u1.Name)
    if _G.grounded == false and (v20.path == false and (_G.check:inspect(u21) == true and _G.StamCheck("Golden Path") == true)) then
        local v23 = u3.GetM("Golden Path")
        local v24 = v23.cd
        if _G.StamCheck("Golden Path") == false then
            return
        end
        if v23.statreq and _G.MeetReq(v23.statreq) == false then
            return
        end
        v20.path = true
        _G.canuse = false
        local u25 = u21.Humanoid:LoadAnimation(script.pathSlide)
        u25:Play()
        u25:AdjustSpeed(0)
        local v26 = game.ReplicatedStorage.Events.Skill:InvokeServer("Golden Path", {
            ["cf"] = u21.HumanoidRootPart.CFrame
        })
        tick()
        local u27 = Instance.new("BodyVelocity", u21.LowerTorso)
        u27.MaxForce = Vector3.new(100000, 0, 100000)
        tick()
        local u28 = 0
        local u29 = false
        local u30 = 0
        local u31 = workspace.Gravity
        local u32 = false
        game:GetService("UserInputService").JumpRequest:Connect(function() --[[ Line: 122 ]]
            --[[
            Upvalues:
                [1] = u29
            --]]
            u29 = true
        end)
        local function v38(p33) --[[ Line: 126 ]]
            --[[
            Upvalues:
                [1] = u21
                [2] = u28
                [3] = u30
                [4] = u31
                [5] = u25
                [6] = u29
                [7] = u32
                [8] = u27
                [9] = u22
            --]]
            if u21.Humanoid.FloorMaterial == Enum.Material.Air then
                u28 = u28 - p33 * 10
                u30 = u30 - u31 * p33
            else
                u28 = u28 + p33 * 50
                u30 = 0
            end
            local v34 = u21:FindFirstChild("inCombat") == nil and 1.3 or 1
            local v35 = u28
            local v36 = 75 * (u21.Humanoid.Health / u21.Humanoid.MaxHealth)
            u28 = math.clamp(v35, 0, v36)
            u25:AdjustSpeed(u28 / 75)
            if u29 and (u21.Humanoid.FloorMaterial ~= Enum.Material.Air and not u32) then
                u30 = 60
                u29 = false
                u32 = true
                u27.MaxForce = Vector3.new(100000, 100000000000, 100000)
                task.delay(0.5, function() --[[ Line: 145 ]]
                    --[[
                    Upvalues:
                        [1] = u32
                    --]]
                    u32 = false
                end)
            else
                u29 = false
                u27.MaxForce = Vector3.new(100000, 0, 100000)
            end
            local v37 = u30
            u27.Velocity = u21.HumanoidRootPart.CFrame.LookVector * (u28 * v34) + Vector3.new(0, v37, 0)
            if u21:FindFirstChild("Stun") then
                return true
            end
            if u21.Parent == workspace.Ragdolls then
                return true
            end
            if u22.Stamina.Value <= 0 then
                return true
            end
        end
        p18:ChargeSkill(p19, {
            ["Button"] = p19,
            ["Key"] = Enum.KeyCode.T,
            ["PCInputType"] = "Toggle",
            ["MobileInputType"] = "Toggle",
            ["EndFunction"] = v38
        })
        u27:Destroy()
        u25:Stop()
        _G.canuse = true
        if v26 then
            v26:FireServer()
        end
        _G.keysetup:cooldown("Golden Path", v24)
        _G.fw(v24)
        v20.path = false
    end
end
function u5.GoldenTouch(u39, p40) --[[ Line: 189 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v41 = u39.Cooldowns
    local u42 = u1.Character
    local u43 = u2["Stats" .. u1.Name]
    if v41.touch == false and (_G.check:inspect(u42) == true and _G.StamCheck("Golden Touch") == true) then
        local v44 = u3.GetM("Golden Touch")
        local v45 = v44.cd
        if _G.StamCheck("Golden Touch") == false then
            return
        end
        if v44.statreq and _G.MeetReq(v44.statreq) == false then
            return
        end
        _G.canuse = false
        v41.touch = true
        local u46 = u42.Humanoid:LoadAnimation(script.touchHold)
        u46:Play()
        u46:AdjustSpeed(0)
        local u47 = tick()
        u39:ChargeSkill(p40, {
            ["Key"] = Enum.KeyCode.R,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 215 ]]
                --[[
                Upvalues:
                    [1] = u42
                    [2] = u47
                    [3] = u39
                    [4] = u43
                    [5] = u46
                --]]
                u42.Humanoid.WalkSpeed = 4
                if tick() - u47 >= 4 or (_G.check:inspect(u42) == false or (u39.Tool.Parent ~= u42 or (u42.Parent == nil or (u42.Parent ~= workspace.PlayerCharacters or u43.Stamina.Value <= 0)))) then
                    if _G.check:inspect(u42) == false then
                        u46:Stop()
                    end
                    return true
                end
            end
        })
        u46:AdjustSpeed(1)
        game.ReplicatedStorage.Events.Skill:InvokeServer("Golden Touch", {
            ["cf"] = u42.PrimaryPart.CFrame
        })
        task.wait(0.25)
        u42.Humanoid.WalkSpeed = 16
        u42.HumanoidRootPart.Anchored = false
        _G.canuse = true
        _G.keysetup:cooldown("Golden Touch", v45)
        _G.fw(v45)
        v41.touch = false
    end
end
function u5.GoldenField(u48, p49) --[[ Line: 244 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v50 = u48.Cooldowns
    local u51 = u1.Character
    local u52 = u2["Stats" .. u1.Name]
    if v50.field == false and (_G.check:inspect(u51) == true and _G.StamCheck("Golden Field") == true) then
        local v53 = u3.GetM("Golden Field")
        local v54 = v53.cd
        if _G.StamCheck("Golden Field") == false then
            return
        end
        if v53.statreq and _G.MeetReq(v53.statreq) == false then
            return
        end
        _G.canuse = false
        v50.field = true
        local u55 = u51.Humanoid:LoadAnimation(script.fieldCast)
        u55:Play()
        u55:AdjustSpeed(0)
        u51.Humanoid.WalkSpeed = 4
        local u56 = game.ReplicatedStorage.Events.Skill:InvokeServer("Golden Field")
        _G.PauseAnim(u55, 0.4, 1)
        local u57 = tick()
        u48:ChargeSkill(p49, {
            ["Key"] = Enum.KeyCode.Z,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 274 ]]
                --[[
                Upvalues:
                    [1] = u51
                    [2] = u57
                    [3] = u48
                    [4] = u56
                    [5] = u52
                    [6] = u55
                --]]
                u51.Humanoid.WalkSpeed = 4
                if tick() - u57 >= 4 or (_G.check:inspect(u51) == false or (u48.Tool.Parent ~= u51 or (u56 == nil or (u51.Parent == nil or (u51.Parent ~= workspace.PlayerCharacters or u52.Stamina.Value <= 0))))) then
                    if _G.check:inspect(u51) == false then
                        u55:Stop()
                    end
                    return true
                end
            end
        })
        u55:AdjustSpeed(1)
        task.wait(0.2)
        if u56 then
            u56:FireServer(u51.PrimaryPart.CFrame)
        end
        task.wait(0.5)
        u51.Humanoid.WalkSpeed = 16
        u55:Stop()
        _G.canuse = true
        _G.keysetup:cooldown("Golden Field", v54)
        _G.fw(v54)
        v50.field = false
    end
end
function u5.GoldenAge(p58, _) --[[ Line: 304 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v59 = p58.Cooldowns
    local v60 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v59.age == false and (_G.check:inspect(v60) == true and _G.StamCheck("Golden Age") == true) then
        local v61 = u3.GetM("Golden Age")
        local v62 = v61.cd
        if _G.StamCheck("Golden Age") == false then
            return
        end
        if v61.statreq and _G.MeetReq(v61.statreq) == false then
            return
        end
        local v63, _, _ = _G.getRayFloor(v60.PrimaryPart.CFrame, 5)
        if v63 == nil then
            _G.displayMessage("<Color=Red>I have to touch the ground")
            return nil
        end
        _G.canuse = false
        v59.age = true
        game.ReplicatedStorage.Events.Skill:InvokeServer("Golden Age", v60.PrimaryPart.CFrame)
        _G.canuse = true
        _G.keysetup:cooldown("Golden Age", v62)
        _G.fw(v62)
        v59.age = false
    end
end
function u5.GoldenJudgement(u64, p65) --[[ Line: 335 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v66 = u64.Cooldowns
    local u67 = u1.Character
    local u68 = u2["Stats" .. u1.Name]
    if v66.Judgement == false and (_G.check:inspect(u67) == true and _G.StamCheck("Golden Judgement") == true) then
        local v69 = u3.GetM("Golden Judgement")
        local v70 = v69.cd
        if _G.StamCheck("Golden Judgement") == false then
            return
        end
        if v69.statreq and _G.MeetReq(v69.statreq) == false then
            return
        end
        _G.canuse = false
        v66.Judgement = true
        u67.Humanoid.WalkSpeed = 4
        local u71 = game.ReplicatedStorage.Events.Skill:InvokeServer("Golden Judgement")
        local u72 = u67.Humanoid:LoadAnimation(script.newspiekcast)
        u72:Play()
        u72:AdjustSpeed(0)
        _G.PauseAnim(u72, 0.3, 1)
        local u73 = tick()
        u64:ChargeSkill(p65, {
            ["Key"] = Enum.KeyCode.X,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 365 ]]
                --[[
                Upvalues:
                    [1] = u67
                    [2] = u73
                    [3] = u64
                    [4] = u71
                    [5] = u68
                    [6] = u72
                --]]
                u67.Humanoid.WalkSpeed = 4
                if tick() - u73 >= 4 or (_G.check:inspect(u67) == false or (u64.Tool.Parent ~= u67 or (u71 == nil or (u67.Parent == nil or (u67.Parent ~= workspace.PlayerCharacters or u68.Stamina.Value <= 0))))) then
                    if _G.check:inspect(u67) == false then
                        u72:Stop()
                    end
                    return true
                end
            end
        })
        u72:AdjustSpeed(1.5)
        if u71 then
            u71:FireServer(u67.PrimaryPart.CFrame)
        end
        task.wait(0.5)
        u67.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Golden Judgement", v70)
        _G.fw(v70)
        v66.Judgement = false
    end
end
return u5