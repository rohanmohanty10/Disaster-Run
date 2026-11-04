 

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
local u6 = {
    { "Block", "f" },
    { "Venom Spit", "e" },
    { "Venom Hydra", "r" },
    { "Venom Road", "t" },
    { "Venom Discharge", "z" },
    { "Venom Aura", "x" },
    { "Venom Demon", "c" }
}
function u5.new(_) --[[ Line: 21 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u5
        [3] = u1
    --]]
    local v7 = u4.new(script.Name)
    local v8 = u5
    local u9 = setmetatable(v7, v8)
    u9.Cooldowns = {
        ["spit"] = false,
        ["hydra"] = false,
        ["road"] = false,
        ["cloak"] = false,
        ["swipe"] = false,
        ["demon"] = false,
        ["rush"] = false,
        ["gas"] = false,
        ["slam"] = false,
        ["grab"] = false
    }
    local u10 = u1.Character
    u9.demonMode = u10:GetAttribute("VenomDemonActive") or false
    u10:GetAttributeChangedSignal("VenomDemonActive"):Connect(function() --[[ Line: 31 ]]
        --[[
        Upvalues:
            [1] = u9
            [2] = u10
        --]]
        u9.demonMode = u10:GetAttribute("VenomDemonActive") or false
    end)
    u9.slam = 0
    return u9
end
function u5.VenomSpit(u11, p12) --[[ Line: 39 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v13 = u11.Cooldowns
    local u14 = u1.Character
    local u15 = u2["Stats" .. u1.Name]
    if u11.demonMode == false and (v13.spit == false and (_G.check:inspect(u14) == true and _G.StamCheck("Venom Spit") == true)) then
        local v16 = u3.GetM("Venom Spit")
        local v17 = v16.cd
        if _G.StamCheck("Venom Spit") == false then
            return
        end
        if v16.statreq and _G.MeetReq(v16.statreq) == false then
            return
        end
        v13.spit = true
        local v18 = u14.Humanoid:LoadAnimation(script.spitCharge)
        v18:Play()
        v18:AdjustWeight(2)
        v18:AdjustSpeed(1)
        _G.FaceMouse = true
        _G.canuse = false
        local u19 = game.ReplicatedStorage.Events.Skill:InvokeServer("Venom Spit")
        _G.PauseAnim(v18, 0.99, 3)
        local u20 = tick()
        u11:ChargeSkill(p12, {
            ["Key"] = Enum.KeyCode.E,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 66 ]]
                --[[
                Upvalues:
                    [1] = u19
                --]]
                if u19 == nil then
                    return false
                end
            end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 72 ]]
                --[[
                Upvalues:
                    [1] = u19
                    [2] = u11
                    [3] = u14
                    [4] = u20
                    [5] = u15
                --]]
                if u19 == nil or (u11.Tool.Parent ~= u14 or (tick() - u20 >= 10 or (u14.Parent == nil or (u14.Parent ~= workspace.PlayerCharacters or u15.Stamina.Value <= 0)))) then
                    return true
                end
            end
        })
        _G.FaceMouse = false
        if u19 then
            u19:FireServer(u14.PrimaryPart.CFrame)
        end
        v18:Stop()
        local v21 = u14.Humanoid:LoadAnimation(script.spit)
        v21:Play()
        v21:AdjustWeight(2)
        v21:AdjustSpeed(1.5)
        u14.PrimaryPart.Anchored = true
        task.wait(0.35)
        u14.PrimaryPart.Anchored = false
        _G.keysetup:cooldown("Venom Spit", v17)
        _G.canuse = true
        _G.fw(v17)
        v13.spit = false
    end
end
function u5.VenomHydra(u22, p23) --[[ Line: 108 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v24 = u22.Cooldowns
    local u25 = u1.Character
    local u26 = u2["Stats" .. u1.Name]
    if v24.hydra == false and (_G.check:inspect(u25) == true and _G.StamCheck("Venom Hydra") == true) then
        local v27 = u3.GetM("Venom Hydra")
        local v28 = v27.cd
        if _G.StamCheck("Venom Hydra") == false then
            return
        end
        if v27.statreq and _G.MeetReq(v27.statreq) == false then
            return
        end
        v24.hydra = true
        _G.canuse = false
        local u29 = u25.Humanoid:LoadAnimation(script.QuickCast)
        u29:Play()
        u29:AdjustWeight(2)
        u29:AdjustSpeed(0)
        if not u22.demonMode then
            _G.FaceMouse = true
        end
        local v30 = false
        local u31 = game.ReplicatedStorage.Events.Skill:InvokeServer("Venom Hydra")
        if u22.demonMode == true then
            local v32 = u25.VenomDemonModel.AnimationController.Animator:LoadAnimation(script.demonHydra)
            v32:Play()
            v32:AdjustSpeed(1)
        end
        local u33 = tick()
        local u34 = u22.demonMode == true and true or v30
        local function v35() --[[ Line: 149 ]]
            --[[
            Upvalues:
                [1] = u33
                [2] = u34
                [3] = u29
                [4] = u25
                [5] = u31
            --]]
            if tick() - u33 >= 0.7 and u34 == false then
                u29:Stop()
                u29 = u25.Humanoid:LoadAnimation(script.HeldCast)
                u29:Play()
                u29:AdjustWeight(2)
                u29:AdjustSpeed(0)
                if u31 then
                    u31:FireServer("tripleCast")
                end
                u34 = true
            end
        end
        local function v36() --[[ Line: 163 ]]
            --[[
            Upvalues:
                [1] = u22
                [2] = u25
                [3] = u33
                [4] = u26
            --]]
            if u22.Tool.Parent ~= u25 or (tick() - u33 >= 10 or (u25.Parent == nil or (u25.Parent ~= workspace.PlayerCharacters or u26.Stamina.Value <= 0))) then
                warn("released")
                return true
            end
        end
        task.wait(0.1)
        local v37 = warn
        local v38 = u22.demonMode
        v37("demon mode", (tostring(v38)))
        if u22.demonMode == false then
            u22:ChargeSkill(p23, {
                ["Key"] = Enum.KeyCode.R,
                ["CheckFunction"] = v35,
                ["IgnoreInstantCastSetting"] = true,
                ["EndFunction"] = v36
            })
        end
        _G.FaceMouse = false
        if u31 then
            local v39 = _G.getTargetNearMouse(300)
            if v39 then
                v39 = v39.Parent
            end
            if not u22.demonMode then
                u25:PivotTo(CFrame.new(u25.PrimaryPart.Position, u22:GetMouseCFrame().Position))
            end
            u31:FireServer(u25.PrimaryPart.CFrame, v39, u34, u22:GetMouseCFrame())
        end
        u29:AdjustSpeed(1)
        u25.PrimaryPart.Anchored = true
        task.wait(0.5)
        if u22.demonMode == true then
            task.wait(0.2)
        elseif u34 == true then
            task.wait(0.4)
        end
        u25.PrimaryPart.Anchored = false
        _G.keysetup:cooldown("Venom Hydra", v28)
        _G.canuse = true
        _G.fw(v28)
        v24.hydra = false
    end
end
function u5.VenomRoad(p40, _) --[[ Line: 215 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v41 = p40.Cooldowns
    local v42 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if p40.demonMode == false and (_G.grounded == false and (v41.road == false and (_G.check:inspect(v42) == true and _G.StamCheck("Venom Road") == true))) then
        local v43 = u3.GetM("Venom Road")
        local v44 = v43.cd
        if _G.StamCheck("Venom Road") == false then
            return
        end
        if v43.statreq and _G.MeetReq(v43.statreq) == false then
            return
        end
        v41.road = true
        _G.canuse = false
        local v45 = p40:GetMouseCFrame()
        local v46 = (v42.PrimaryPart.Position - v45.Position).Magnitude
        local v47 = Ray.new(v42.PrimaryPart.Position, (v42.PrimaryPart.Position - v45.Position).unit * -v46)
        local _, v48 = _G.raycastWhitelist(v47, { workspace.Islands, workspace.Ships, workspace.Env })
        local v49 = CFrame.new(v48)
        if (v42.HumanoidRootPart.Position - v49.Position).Magnitude >= 150 then
            local v50 = Ray.new(v42.HumanoidRootPart.Position, (v42.HumanoidRootPart.Position - v49.Position).unit * -150)
            local _, v51 = _G.raycastIgnoreList(v50, { workspace })
            v49 = CFrame.new(v51)
        end
        game.ReplicatedStorage.Events.Skill:InvokeServer("Venom Road", v49)
        _G.keysetup:cooldown("Venom Road", v44)
        _G.canuse = true
        _G.fw(v44)
        v41.road = false
    end
end
function u5.VenomDischarge(p52, _) --[[ Line: 256 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v53 = p52.Cooldowns
    local v54 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if p52.demonMode == false and (v53.cloak == false and (_G.check:inspect(v54) == true and _G.StamCheck("Venom Discharge") == true)) then
        local v55 = u3.GetM("Venom Discharge")
        local v56 = v55.cd
        if _G.StamCheck("Venom Discharge") == false then
            return
        end
        if v55.statreq and _G.MeetReq(v55.statreq) == false then
            return
        end
        v53.cloak = true
        v54.Humanoid:LoadAnimation(script.counterCast):Play()
        task.spawn(function() --[[ Line: 275 ]]
            game.ReplicatedStorage.Events.Skill:InvokeServer("Venom Discharge")
        end)
        _G.keysetup:cooldown("Venom Discharge", v56)
        _G.canuse = true
        _G.fw(v56)
        v53.cloak = false
    end
end
function u5.VenomAura(p57, _) --[[ Line: 288 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v58 = p57.Cooldowns
    local v59 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if p57.demonMode == false and (v58.swipe == false and (_G.check:inspect(v59) == true and _G.StamCheck("Venom Aura") == true)) then
        local v60 = u3.GetM("Venom Aura")
        local v61 = v60.cd
        if _G.StamCheck("Venom Aura") == false then
            return
        end
        if v60.statreq and _G.MeetReq(v60.statreq) == false then
            return
        end
        v58.swipe = true
        local v62 = v59.Humanoid:LoadAnimation(script.swipe)
        v62:Play()
        v62:AdjustWeight(2)
        v62:AdjustSpeed(1)
        _G.canuse = false
        v59.Humanoid.WalkSpeed = 4
        game.ReplicatedStorage.Events.Skill:InvokeServer("Venom Aura")
        _G.keysetup:cooldown("Venom Aura", v61)
        _G.canuse = true
        v59.Humanoid.WalkSpeed = 16
        _G.fw(v61)
        v58.swipe = false
    end
end
function u5.VenomDemon(u63, p64) --[[ Line: 320 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
        [4] = u6
    --]]
    local v65 = u63.Cooldowns
    local u66 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if u66:FindFirstChild("VenomDemonModel") == nil and (v65.demon == false and (_G.check:inspect(u66) == true and _G.StamCheck("Venom Demon") == true)) then
        local v67 = u3.GetM("Venom Demon")
        local v68 = v67.cd
        if _G.StamCheck("Venom Demon") == false then
            return
        end
        if v67.statreq and _G.MeetReq(v67.statreq) == false then
            return
        end
        local v69
        if u66:GetAttribute("venomDamage") then
            local v70 = u66:GetAttribute("venomDamage")
            v69 = math.ceil(v70)
        else
            v69 = 0
        end
        if v69 < require(game.ReplicatedStorage.Modules.Skills.Modes.Venom)(u1) * u63.Tool:GetAttribute("modePercent") then
            _G.displayMessage((("<Color=/>I need <Color=Red>%*%%<Color=/> Rage for full mode."):format(u63.Tool:GetAttribute("modePercent") * 100)))
            return
        end
        local v71, _, _ = _G.getRayFloor(u66.PrimaryPart.CFrame, 5)
        if v71 == nil then
            _G.displayMessage("<Color=Red>You must be grounded!")
            return nil
        end
        v65.demon = true
        _G.canuse = false
        local u72 = game.ReplicatedStorage.Events.Skill:InvokeServer("Venom Demon", u66.PrimaryPart.CFrame)
        if u72 then
            pcall(function() --[[ Line: 354 ]]
                if _G.keysetup then
                    _G.keysetup:Destroy()
                    _G.keysetup:setup("Venom Demon", {
                        { "Block", "f" },
                        { "Venom Rush", "q" },
                        { "Venom Slam", "e" },
                        { "Venom Hydra", "r" },
                        { "Venom Poisonous Gas", "z" },
                        { "Venom Grab", "x" },
                        { "Venom Demon", "c" }
                    })
                end
            end)
            u63:DoubleCastSkill(p64, {
                ["Key"] = Enum.KeyCode.C,
                ["SkipTap"] = true,
                ["CompleteFunction"] = function() --[[ Name: CompleteFunction, Line 366 ]]
                    --[[
                    Upvalues:
                        [1] = u72
                    --]]
                    if u72 then
                        warn("UNTRASNFORM VENOM DEMON HERE")
                        _G.canuse = false
                        local v73 = tick()
                        local u74 = false
                        task.spawn(function() --[[ Line: 372 ]]
                            --[[
                            Upvalues:
                                [1] = u72
                                [2] = u74
                            --]]
                            u72:InvokeServer()
                            u74 = true
                        end)
                        repeat
                            task.wait()
                        until u74 == true or tick() - v73 >= 1.4
                        _G.canuse = true
                        warn("UNTRASNFORM VENOM DEMON FINISHED")
                    end
                end,
                ["PassFunction"] = function() --[[ Name: PassFunction, Line 384 ]]
                    --[[
                    Upvalues:
                        [1] = u63
                        [2] = u66
                    --]]
                    local v75
                    if u63.Tool.Parent == u66 and _G.check:inspect(u66) == true then
                        v75 = _G.canuse == true
                    else
                        v75 = false
                    end
                    return v75
                end
            })
            task.spawn(function() --[[ Line: 389 ]]
                --[[
                Upvalues:
                    [1] = u66
                    [2] = u63
                    [3] = u1
                    [4] = u6
                --]]
                while true do
                    u66.Humanoid.Jump = false
                    u66.Humanoid.WalkSpeed = 35
                    local u76 = u66:FindFirstChildWhichIsA("Tool")
                    if u76 and u76 ~= u63.Tool then
                        task.defer(function() --[[ Line: 395 ]]
                            --[[
                            Upvalues:
                                [1] = u76
                                [2] = u1
                            --]]
                            u76.Parent = u1.Backpack
                        end)
                    end
                    if u66.PrimaryPart.Velocity.Magnitude >= 150 then
                        u66.PrimaryPart.Velocity = Vector3.new(0, 0, 0)
                        u66.PrimaryPart.RotVelocity = Vector3.new(0, 0, 0)
                    end
                    _G.toolLocked = u63.Tool
                    game["Run Service"].RenderStepped:Wait()
                    if u66:GetAttribute("VenomDemonActive") == false then
                        _G.toolLocked = nil
                        _G.keysetup:Destroy()
                        _G.keysetup:setup(script.Name, u6)
                        return
                    end
                end
            end)
        end
        _G.canuse = true
        _G.keysetup:cooldown("Venom Demon", v68)
        _G.fw(v68)
        v65.demon = false
    end
end
function u5.VenomRush(p77, _) --[[ Line: 423 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v78 = p77.Cooldowns
    local v79 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if p77.demonMode == true and (v78.rush == false and (_G.check:inspect(v79) == true and _G.StamCheck("Venom Rush") == true)) then
        local v80 = u3.GetM("Venom Rush")
        local v81 = v80.cd
        if _G.StamCheck("Venom Rush") == false then
            return
        end
        if v80.statreq and _G.MeetReq(v80.statreq) == false then
            return
        end
        v78.rush = true
        _G.canuse = false
        local v82 = v79.VenomDemonModel.AnimationController.Animator:LoadAnimation(script.Rush)
        v82:Play()
        v82:AdjustSpeed(1.3)
        game.ReplicatedStorage.Events.Skill:InvokeServer("Venom Rush")
        task.wait(0.5)
        _G.keysetup:cooldown("Venom Rush", v81)
        _G.canuse = true
        _G.fw(v81)
        v78.rush = false
    end
end
function u5.VenomPoisonousGas(p83, _) --[[ Line: 454 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v84 = p83.Cooldowns
    local u85 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if p83.demonMode == true and (v84.gas == false and (_G.check:inspect(u85) == true and _G.StamCheck("Venom Poisonous Gas") == true)) then
        local v86 = u3.GetM("Venom Poisonous Gas")
        local v87 = v86.cd
        if _G.StamCheck("Venom Poisonous Gas") == false then
            return
        end
        if v86.statreq and _G.MeetReq(v86.statreq) == false then
            return
        end
        v84.gas = true
        _G.canuse = false
        local v88 = u85.VenomDemonModel.AnimationController.Animator:LoadAnimation(script.demonGas)
        v88:Play()
        v88:AdjustSpeed(1.3)
        u85.PrimaryPart.Anchored = true
        task.delay(1.5, function() --[[ Line: 483 ]]
            --[[
            Upvalues:
                [1] = u85
            --]]
            u85.PrimaryPart.Anchored = false
        end)
        game.ReplicatedStorage.Events.Skill:InvokeServer("Venom Poisonous Gas")
        task.wait(1.5)
        _G.keysetup:cooldown("Venom Poisonous Gas", v87)
        _G.canuse = true
        _G.fw(v87)
        v84.gas = false
    end
end
function u5.VenomSlam(p89, _) --[[ Line: 498 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v90 = p89.Cooldowns
    local v91 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if p89.demonMode == true and (v90.slam == false and (_G.check:inspect(v91) == true and _G.StamCheck("Venom Slam") == true)) then
        local v92 = u3.GetM("Venom Slam")
        local v93 = v92.cd
        if _G.StamCheck("Venom Slam") == false then
            return
        end
        if v92.statreq and _G.MeetReq(v92.statreq) == false then
            return
        end
        v90.slam = true
        _G.canuse = false
        p89.slam = p89.slam + 1
        if p89.slam >= 3 then
            p89.slam = 1
        end
        local v94 = v91.VenomDemonModel.AnimationController.Animator:LoadAnimation(script["slam" .. p89.slam])
        v94:Play()
        v94:AdjustSpeed(1)
        local v95 = game.ReplicatedStorage.Events.Skill:InvokeServer("Venom Slam", p89.slam)
        task.wait(1.1)
        if v95 then
            v95:FireServer(v91.PrimaryPart.CFrame)
        end
        task.wait(0.2)
        _G.keysetup:cooldown("Venom Slam", v93)
        _G.canuse = true
        _G.fw(v93)
        v90.slam = false
    end
end
function u5.VenomGrab(p96, _) --[[ Line: 538 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v97 = p96.Cooldowns
    local v98 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if p96.demonMode == true and (v97.grab == false and (_G.check:inspect(v98) == true and _G.StamCheck("Venom Grab") == true)) then
        local v99 = u3.GetM("Venom Grab")
        local v100 = v99.cd
        if _G.StamCheck("Venom Grab") == false then
            return
        end
        if v99.statreq and _G.MeetReq(v99.statreq) == false then
            return
        end
        v97.grab = true
        _G.canuse = false
        game.ReplicatedStorage.Events.Skill:InvokeServer("Venom Grab", v98.PrimaryPart.CFrame)
        task.wait(0.2)
        _G.keysetup:cooldown("Venom Grab", v100)
        _G.canuse = true
        _G.fw(v100)
        v97.grab = false
    end
end
return u5