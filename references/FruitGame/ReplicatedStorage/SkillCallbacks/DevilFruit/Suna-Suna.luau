
local u1 = game.Players.LocalPlayer
game:GetService("RunService")
local u2 = game:GetService("ReplicatedStorage")
local u3 = require(game.ReplicatedStorage.Modules.Skills)
local u4 = require(script.Parent.Parent.MobileBase)
local v5 = require(u1.PlayerScripts:WaitForChild("PlayerModule"))
game:GetService("UserInputService")
local u6 = v5:GetControls()
u1:GetMouse()
local u7 = setmetatable({}, u4)
u7.__index = u7
function u7.new(_) 
    
    local v8 = u4.new(script.Name)
    local v9 = u7
    local u10 = setmetatable(v8, v9)
    u10.Cooldowns = {
        ["bury"] = false,
        ["Flight"] = false,
        ["spada"] = false,
        ["pesado"] = false,
        ["slash"] = false,
        ["frenzy"] = false
    }
    local u11 = u1.Character
    local u12 = {
        ["Idle"] = u11.Humanoid:LoadAnimation(script.Fly.idle),
        ["Front"] = u11.Humanoid:LoadAnimation(script.Fly.front),
        ["Back"] = u11.Humanoid:LoadAnimation(script.Fly.back),
        ["Left"] = u11.Humanoid:LoadAnimation(script.Fly.left),
        ["Right"] = u11.Humanoid:LoadAnimation(script.Fly.right)
    }
    function u10.stopAll(_, p13) 
        
        for v14, v15 in u12 do
            if v14 ~= p13 then
                v15:Stop()
            end
        end
    end
    function u10.playAnim(_, p16) 
        
        if _G.check:inspect(u11) == false then
            u10:stopAll(nil)
        else
            if u12[p16] and u12[p16].IsPlaying == false then
                u12[p16]:Play()
            end
            u10:stopAll(p16)
        end
    end
    return u10
end
function u7.DesertStorm(p17, p18) 
   
    local v19 = p17.Cooldowns
    local u20 = u1.Character
    local u21 = u2["Stats" .. u1.Name]
    if v19.bury == false and (_G.check:inspect(u20) == true and _G.StamCheck("Desert Storm") == true) then
        local v22 = u3.GetM("Desert Storm")
        local v23 = v22.cd
        if _G.StamCheck("Desert Storm") == false then
            return
        end
        if v22.statreq and _G.MeetReq(v22.statreq) == false then
            return
        end
        v19.bury = true
        _G.canuse = false
        _G.FaceMouse = true
        local v24 = u20.Humanoid:LoadAnimation(script.sables)
        v24:Play()
        v24:AdjustWeight(2)
        _G.PauseAnim(v24, 0.35, 0.75)
        local v25 = game.ReplicatedStorage.Events.Skill:InvokeServer("Desert Storm", {
            ["cf"] = p17:GetMouseCFrame()
        })
        local u26 = tick()
        task.wait(0.25)
        p17:ChargeSkill(p18, {
            ["Key"] = Enum.KeyCode.Z,
            ["EndFunction"] = function() 
                
                if _G.check:inspect(u20) == false or (tick() - u26 >= 4 or (u20:FindFirstChild(script.Name) == nil or (u20.Parent == nil or (u20.Parent ~= workspace.PlayerCharacters or u21.Stamina.Value <= 0)))) then
                    return true
                end
            end
        })
        v24:AdjustSpeed(2)
        _G.FaceMouse = false
        u20.HumanoidRootPart.Anchored = true
        task.wait(0.1)
        if v25 then
            v25:FireServer({
                ["cf"] = p17:GetMouseCFrame()
            })
        end
        task.wait(0.25)
        u20.HumanoidRootPart.Anchored = false
        u20.Humanoid.PlatformStand = false
        _G.canuse = true
        _G.keysetup:cooldown("Desert Storm", v23)
        _G.fw(v23)
        v19.bury = false
    end
end
local function u44(p27) 
    local v28 = p27.X
    local v29 = math.abs(v28)
    local v30 = p27.Y
    if math.abs(v30) < v29 then
        local v31 = p27.X
        local v32 = math.abs(v31)
        local v33 = p27.Z
        if math.abs(v33) < v32 then
            local v34 = p27.X > 0 and "Right" or "Left"
            local v35 = p27.X
            return v34, math.abs(v35)
        end
    end
    local v36 = p27.Z
    local v37 = math.abs(v36)
    local v38 = p27.X
    if math.abs(v38) < v37 then
        local v39 = p27.Z
        local v40 = math.abs(v39)
        local v41 = p27.Y
        if math.abs(v41) < v40 then
            local v42 = p27.Z > 0 and "Down" or "Up"
            local v43 = p27.Z
            return v42, math.abs(v43)
        end
    end
    return "None", 0
end
function u7.DesertFlight(p45, p46) 
    
    local v47 = p45.Cooldowns
    local u48 = u1.Character
    local u49 = u2["Stats" .. u1.Name]
    if _G.grounded == false and (v47.Flight == false and (_G.check:inspect(u48) == true and _G.StamCheck("Desert Flight") == true)) then
        local v50 = u3.GetM("Desert Flight")
        local v51 = v50.cd
        if _G.StamCheck("Desert Flight") == false then
            return
        end
        if v50.statreq and _G.MeetReq(v50.statreq) == false then
            return
        end
        v47.Flight = true
        u48.Humanoid.WalkSpeed = 0
        local u52 = game.ReplicatedStorage.Events.Skill:InvokeServer("Desert Flight")
        local v53 = Instance.new("BodyVelocity", u48.LowerTorso)
        v53.Name = "geppo"
        v53.MaxForce = Vector3.new(100000000000, 100000000000, 100000000000)
        v53.Velocity = Vector3.new()
        local v54 = Instance.new("BodyGyro", u48.HumanoidRootPart)
        v54.P = 100000
        v54.D = 2500
        v54.MaxTorque = Vector3.new(100000000000, 100000000000, 100000000000)
        u48.Humanoid.WalkSpeed = 16
        local u55 = false
        p45:DoubleCastSkill(p46, {
            ["ToolName"] = script.Name,
            ["Button"] = p46,
            ["Key"] = Enum.KeyCode.T,
            ["PassFunction"] = function() 
                
                return u48:FindFirstChild(script.Name) ~= nil
            end,
            ["CancelFunction"] = function()
               
                if u48:FindFirstChild("inCombat") and u48:FindFirstChild("PB") then
                    return true
                end
                local v56 = u48.Parent == workspace.PlayerCharacters and u49.Stamina.Value > 0 and (u52 ~= nil and u52)
                if v56 then
                    v56 = u52:IsDescendantOf(game) == false
                end
                return v56
            end,
            ["CompleteFunction"] = function() --[[ Name: CompleteFunction, Line 168 ]]
                --[[
                Upvalues:
                    [1] = u55
                --]]
                u55 = true
            end,
            ["SkipTap"] = true
        })
        u48.Humanoid.PlatformStand = true
        local v57 = tick()
        local v58 = u55
        while true do
            local v59 = (u48:FindFirstChild("inCombat") == nil and 50 or 25) * (u48.Humanoid.Health / u48.Humanoid.MaxHealth)
            local v60 = u6:GetMoveVector()
            local v61 = u44(v60)
            v53.Velocity = (workspace.CurrentCamera.CFrame.LookVector * -v60.Z * 2 + workspace.CurrentCamera.CFrame.RightVector * v60.X) * v59
            if _G.FaceMouse == true or (u48:FindFirstChildWhichIsA("ObjectValue") or _G.canuse == false) then
                v53.Velocity = Vector3.new()
            end
            if _G.FaceMouse == true then
                v54.Parent = nil
                v54.MaxTorque = Vector3.new(0, 0, 0)
            else
                if v61 == "Down" then
                    p45:playAnim("Back")
                elseif v61 == "Left" then
                    p45:playAnim("Left")
                elseif v61 == "Right" then
                    p45:playAnim("Right")
                elseif v61 == "Up" then
                    p45:playAnim("Front")
                elseif v61 == "None" then
                    p45:playAnim("Idle")
                end
                v54.MaxTorque = Vector3.new(100000000000, 100000000000, 100000000000)
                v54.CFrame = workspace.CurrentCamera.CFrame
                v54.Parent = u48.LowerTorso
            end
            u48.Humanoid.PlatformStand = true
            local v62 = u48:FindFirstChildWhichIsA("Tool")
            if v62 and v62 ~= p45.Tool then
                task.defer(function() --[[ Line: 221 ]]
                    --[[
                    Upvalues:
                        [1] = u48
                    --]]
                    u48.Humanoid:UnequipTools()
                end)
            end
            if u48:FindFirstChild("inCombat") and tick() - v57 >= 30 then
                break
            end
            game["Run Service"].RenderStepped:Wait()
            if v58 == true then
                break
            end
        end
        p45.stopAll()
        u48.Humanoid.AutoRotate = true
        u48.Humanoid.PlatformStand = false
        v53:Destroy()
        v54:Destroy()
        if u52 then
            pcall(function() --[[ Line: 242 ]]
                --[[
                Upvalues:
                    [1] = u52
                --]]
                u52:InvokeServer()
            end)
        end
        _G.keysetup:cooldown("Desert Flight", v51)
        _G.fw(v51)
        v47.Flight = false
    end
end
function u7.DesertSpada(p63, p64) --[[ Line: 252 ]]
    
    local v65 = p63.Cooldowns
    local u66 = u1.Character
    local u67 = u2["Stats" .. u1.Name]
    if v65.spada == false and (_G.check:inspect(u66) == true and _G.StamCheck("Desert Spada") == true) then
        local v68 = u3.GetM("Desert Spada")
        local v69 = v68.cd
        if _G.StamCheck("Desert Spada") == false then
            return
        end
        if v68.statreq and _G.MeetReq(v68.statreq) == false then
            return
        end
        v65.spada = true
        _G.canuse = false
        _G.mouseLevel = true
        _G.FaceMouse = true
        local v70 = u66.Humanoid:LoadAnimation(script.spada)
        v70:Play()
        v70:AdjustWeight(2)
        _G.PauseAnim(v70, 0.4, 1)
        local v71 = game.ReplicatedStorage.Events.Skill:InvokeServer("Desert Spada", {
            ["cf"] = p63:GetMouseCFrame()
        })
        tick()
        p63:ChargeSkill(p64, {
            ["Key"] = Enum.KeyCode.X,
            ["EndFunction"] = function() 
                
                if u66:FindFirstChild(script.Name) == nil or (u66.Parent == nil or (u66.Parent ~= workspace.PlayerCharacters or u67.Stamina.Value <= 0)) then
                    return true
                end
            end
        })
        u66.HumanoidRootPart.Anchored = true
        v70:AdjustSpeed(1)
        task.wait(0.1)
        _G.FaceMouse = false
        _G.mouseLevel = nil
        u66.Humanoid.AutoRotate = false
        if v71 then
            v71:FireServer(u66.HumanoidRootPart.CFrame)
        end
        task.wait(0.4)
        u66.HumanoidRootPart.Anchored = false
        u66.Humanoid.AutoRotate = true
        u66.Humanoid.PlatformStand = false
        _G.canuse = true
        _G.keysetup:cooldown("Desert Spada", v69)
        _G.fw(v69)
        v65.spada = false
    end
end
function u7.DesertRailgun(p72, p73) --[[ Line: 316 ]]
    
    local v74 = p72.Cooldowns
    local u75 = u1.Character
    local u76 = u2["Stats" .. u1.Name]
    if v74.pesado == false and (_G.check:inspect(u75) == true and _G.StamCheck("Desert Railgun") == true) then
        local v77 = u3.GetM("Desert Railgun")
        local v78 = v77.cd
        if _G.StamCheck("Desert Railgun") == false then
            return
        end
        if v77.statreq and _G.MeetReq(v77.statreq) == false then
            return
        end
        v74.pesado = true
        _G.canuse = false
        _G.FaceMouse = true
        local v79 = u75.Humanoid:LoadAnimation(script.pesado)
        v79:Play()
        v79:AdjustWeight(2)
        local u80 = game.ReplicatedStorage.Events.Skill:InvokeServer("Desert Railgun", {
            ["cf"] = p72:GetMouseCFrame()
        })
        _G.PauseAnim(v79, 0.5, 1)
        task.wait(0.7)
        tick()
        p72:ChargeSkill(p73, {
            ["Key"] = Enum.KeyCode.C,
            ["EndFunction"] = function()
               
                if u75:FindFirstChild(script.Name) == nil or (u80 == nil or (u75.Parent == nil or (u75.Parent ~= workspace.PlayerCharacters or u76.Stamina.Value <= 0))) then
                    return true
                end
            end
        })
        u75.HumanoidRootPart.Anchored = true
        v79:AdjustSpeed(1)
        local v81 = p72:GetMouseCFrame()
        task.wait(0.27)
        _G.FaceMouse = false
        u75.Humanoid.AutoRotate = false
        if u80 then
            u80:FireServer(v81)
        end
        task.wait(0.4)
        u75.HumanoidRootPart.Anchored = false
        u75.Humanoid.AutoRotate = true
        u75.Humanoid.PlatformStand = false
        _G.canuse = true
        _G.keysetup:cooldown("Desert Railgun", v78)
        _G.fw(v78)
        v74.pesado = false
    end
end
function u7.DesertCutlass(p82, p83) 
    
    local v84 = p82.Cooldowns
    local u85 = u1.Character
    local u86 = u2["Stats" .. u1.Name]
    if v84.slash == false and (_G.check:inspect(u85) == true and _G.StamCheck("Desert Cutlass") == true) then
        local v87 = u3.GetM("Desert Cutlass")
        local v88 = v87.cd
        if _G.StamCheck("Desert Cutlass") == false then
            return
        end
        if v87.statreq and _G.MeetReq(v87.statreq) == false then
            return
        end
        v84.slash = true
        _G.canuse = false
        _G.FaceMouse = true
        local v89 = u85.Humanoid:LoadAnimation(script.slash)
        v89:Play()
        v89:AdjustWeight(2)
        local v90 = game.ReplicatedStorage.Events.Skill:InvokeServer("Desert Cutlass", {
            ["cf"] = p82:GetMouseCFrame()
        })
        if u85:WaitForChild("SandBlade2", 5) == nil then
            _G.canuse = true
            v84.slash = false
            _G.FaceMouse = false
            v89:Stop()
            return
        end
        local v91 = u85.SandBlade2.AnimationController:LoadAnimation(script.slash)
        v91:Play()
        v91:AdjustWeight(2)
        _G.PauseAnim(v89, 0.4, 1.25)
        v91:AdjustSpeed(0)
        local u92 = tick()
        p82:ChargeSkill(p83, {
            ["Key"] = Enum.KeyCode.E,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 420 ]]
                --[[
                Upvalues:
                    [1] = u85
                    [2] = u92
                    [3] = u86
                --]]
                if u85:FindFirstChild(script.Name) == nil or (tick() - u92 >= 5 or (u85.Parent == nil or (u85.Parent ~= workspace.PlayerCharacters or u86.Stamina.Value <= 0))) then
                    return true
                end
            end
        })
        v89:AdjustSpeed(0.75)
        v91:AdjustSpeed(0.75)
        _G.FaceMouse = false
        local _ = u85.HumanoidRootPart.CFrame
        u85.Humanoid.AutoRotate = false
        u85.HumanoidRootPart.Anchored = true
        task.wait(0.1)
        if v90 then
            v90:FireServer(p82:GetMouseCFrame())
        end
        task.wait(0.35)
        u85.Humanoid.AutoRotate = true
        u85.Humanoid.PlatformStand = false
        u85.HumanoidRootPart.Anchored = false
        _G.canuse = true
        _G.keysetup:cooldown("Desert Cutlass", v88)
        _G.fw(v88)
        v84.slash = false
    end
end
u7["DesertCutlass:Frenzy"] = function(p93, p94) --[[ Line: 458 ]]
   
    local v95 = p93.Cooldowns
    local u96 = u1.Character
    local u97 = u2["Stats" .. u1.Name]
    if v95.frenzy == false and (_G.check:inspect(u96) == true and _G.StamCheck("Desert Cutlass: Frenzy") == true) then
        local v98 = u3.GetM("Desert Cutlass: Frenzy")
        local v99 = v98.cd
        if _G.StamCheck("Desert Cutlass: Frenzy") == false then
            return
        end
        if v98.statreq and _G.MeetReq(v98.statreq) == false then
            return
        end
        v95.frenzy = true
        _G.canuse = false
        local v100 = u96.Humanoid:LoadAnimation(script.frenzyHold)
        v100:Play()
        v100:AdjustWeight(2)
        u96.Humanoid.WalkSpeed = 4
        local v101 = game.ReplicatedStorage.Events.Skill:InvokeServer("Desert Cutlass: Frenzy", {
            ["cf"] = p93:GetMouseCFrame()
        })
        if u96:WaitForChild("SandBlade2", 5) == nil then
            _G.canuse = true
            v95.frenzy = false
            v100:Stop()
            return
        end
        local v102 = u96.SandBlade2.AnimationController:LoadAnimation(script.frenzyHold)
        v102:Play()
        v102:AdjustWeight(2)
        _G.PauseAnim(v100, 0.4, 1)
        v102:AdjustSpeed(0)
        tick()
        p93:ChargeSkill(p94, {
            ["Key"] = Enum.KeyCode.R,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 496 ]]
                --[[
                Upvalues:
                    [1] = u96
                --]]
                u96.Humanoid.WalkSpeed = 4
            end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 501 ]]
                --[[
                Upvalues:
                    [1] = u96
                    [2] = u97
                --]]
                if u96:FindFirstChild(script.Name) == nil or (u96.Parent == nil or (u96.Parent ~= workspace.PlayerCharacters or u97.Stamina.Value <= 0)) then
                    return true
                end
            end
        })
        v100:AdjustSpeed(1.5)
        v102:AdjustSpeed(1.5)
        local _ = u96.HumanoidRootPart.CFrame
        local v103 = Instance.new("BodyVelocity", u96.HumanoidRootPart)
        v103.MaxForce = Vector3.new(1000000, 0, 1000000)
        v103.Velocity = u96.HumanoidRootPart.CFrame.LookVector * 100
        _G.destroy(v103, 0.1)
        if v101 then
            v101:FireServer(u96.HumanoidRootPart.CFrame)
        end
        task.wait(0.35)
        u96.Humanoid.PlatformStand = false
        u96.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Desert Cutlass: Frenzy", v99)
        _G.fw(v99)
        v95.frenzy = false
    end
end
return u7