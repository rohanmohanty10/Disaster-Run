 

local u1 = game.Players.LocalPlayer
game:GetService("RunService")
local u2 = game:GetService("ReplicatedStorage")
local u3 = require(game.ReplicatedStorage.Modules.Skills)
local u4 = require(script.Parent.Parent.MobileBase)
local v5 = require(u1.PlayerScripts:WaitForChild("PlayerModule"))
local u6 = require(game.ReplicatedStorage.Modules.RotatedRegion3)
u1:GetMouse()
v5:GetControls()
local u7 = require(game.ReplicatedStorage.Modules.SwordHandle.SwordInfo)
local u8 = setmetatable({}, u4)
u8.__index = u8
function u8.new(_, p9) --[[ Line: 22 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u8
        [3] = u7
    --]]
    local v10 = u4.new()
    local v11 = u8
    local v12 = setmetatable(v10, v11)
    v12.Tool = p9
    local v13 = {}
    local v14 = u7[script.Name]
    local v15
    if v14 == nil then
        v15 = u7.Katana.keys
    else
        v15 = v14.keys
    end
    for v16 = 1, #v15 do
        v13[v15[v16][1]] = false
    end
    v12.Cooldowns = v13
    return v12
end
u8["36CaliberPhoenix"] = function(u17, p18) --[[ Line: 66 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
        [4] = u6
    --]]
    local v19 = u17.Cooldowns
    local u20 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v19["36 Caliber Phoenix"] == false and _G.check:inspect(u20) == true then
        local v21 = u3.GetM("36 Caliber Phoenix")
        local v22 = v21.cd
        if _G.StamCheck("36 Caliber Phoenix") == false then
            return
        end
        if v21.statreq and _G.MeetReq(v21.statreq) == false then
            return
        end
        local u23 = u20.Humanoid.Animator:LoadAnimation(script.caliber)
        u23:Play()
        u23:AdjustWeight(2)
        v19["36 Caliber Phoenix"] = true
        _G.FaceMouse = true
        _G.canuse = false
        local u24 = game.ReplicatedStorage.Events.Skill:InvokeServer("36 Caliber Phoenix")
        _G.PauseAnim(u23, 0.45, 2)
        local u25 = tick()
        u17:ChargeSkill(p18, {
            ["Key"] = Enum.KeyCode.E,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 96 ]]
                --[[
                Upvalues:
                    [1] = u20
                    [2] = u23
                --]]
                if _G.check:inspect(u20) == false then
                    u23:Stop()
                    return true
                end
            end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 104 ]]
                --[[
                Upvalues:
                    [1] = u17
                    [2] = u20
                    [3] = u25
                --]]
                if u17.Tool.Parent ~= u20 or tick() - u25 >= 10 then
                    return true
                end
            end
        })
        _G.FaceMouse = false
        u20.HumanoidRootPart.Anchored = true
        if u24 then
            local u26, v27 = u24:InvokeServer(CFrame.new(u20.HumanoidRootPart.Position, u17:GetMouseCFrame().Position))
            local u28 = _G.awaitObject(v27)
            local u29 = {}
            task.spawn(function() --[[ Line: 122 ]]
                --[[
                Upvalues:
                    [1] = u20
                    [2] = u28
                    [3] = u6
                    [4] = u29
                    [5] = u26
                    [6] = u24
                --]]
                local v30 = 0
                while true do
                    task.wait()
                    local v31 = u20
                    local v32 = u28
                    local v33 = u6.new(v32.CFrame, v32.Size):FindPartsInRegion3WithWhiteList(_G.getTargets(v31, true), 2000)
                    for v34 = 1, #v33 do
                        local v35 = v33[v34]
                        if v30 < 3 and (u29[v35.Parent] == nil and (v35.Parent:FindFirstChild("Humanoid") and v35:IsDescendantOf(u20) == false)) then
                            u29[v35.Parent] = true
                            v30 = v30 + 1
                            u26:FireServer(v35.Parent)
                        end
                    end
                    if v30 >= 3 or (u24.Parent == nil or u28.Parent == nil) then
                        return
                    end
                end
            end)
            if u28 then
                local u36 = nil
                u36 = u28.Touched:Connect(function(p37) --[[ Line: 141 ]]
                    --[[
                    Upvalues:
                        [1] = u36
                        [2] = u26
                    --]]
                    if p37 and p37.CollisionGroupId == 5 then
                        u36:Disconnect()
                        u26:FireServer("cancel")
                    end
                end)
            end
        end
        u23:AdjustSpeed(1)
        task.wait(0.35)
        u20.HumanoidRootPart.Anchored = false
        u20.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("36 Caliber Phoenix", v22)
        require(script.Parent.SwordStyleSwapping):matchCooldowns(v19)
        _G.fw(v22)
        v19["36 Caliber Phoenix"] = false
    end
end
function u8.RagingSerpent(u38, p39) --[[ Line: 162 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v40 = u38.Cooldowns
    local u41 = u1.Character
    local u42 = u2["Stats" .. u1.Name]
    if v40["Raging Serpent"] == false and _G.check:inspect(u41) == true then
        local v43 = u3.GetM("Raging Serpent")
        local v44 = v43.cd
        if _G.StamCheck("Raging Serpent") == false then
            return
        end
        if v43.statreq and _G.MeetReq(v43.statreq) == false then
            return
        end
        _G.canuse = false
        local u45 = u41.Humanoid.Animator:LoadAnimation(script.serpantC)
        u45:Play()
        u45:AdjustSpeed(0)
        u41.HumanoidRootPart.Anchored = true
        local v46 = game.ReplicatedStorage.Events.Skill:InvokeServer("Raging Serpent")
        _G.PauseAnim(u45, 0.525, 1)
        v40["Raging Serpent"] = true
        local u47 = 45
        local u48 = 0
        local u49 = script.Sphere:Clone()
        u49.CFrame = u41.HumanoidRootPart.CFrame
        u49.Parent = workspace.Effects
        local function v53() --[[ Line: 196 ]]
            --[[
            Upvalues:
                [1] = u41
                [2] = u45
                [3] = u47
                [4] = u49
                [5] = u48
            --]]
            if _G.check:inspect(u41) == false then
                u45:Stop()
                return true
            end
            u47 = u47 + 0.1
            local v50 = u47
            local v51 = u47
            local v52 = u47
            u49.Size = Vector3.new(v50, v51, v52)
            if tick() - u48 >= 0.1 then
                u48 = tick()
                game.ReplicatedStorage.Events.takestam:FireServer(2)
            end
        end
        local function v54() --[[ Line: 210 ]]
            --[[
            Upvalues:
                [1] = u47
                [2] = u42
                [3] = u38
                [4] = u41
            --]]
            if u47 >= 125 or (u42.Stamina.Value <= 0 or u38.Tool.Parent ~= u41) then
                return true
            end
        end
        u38:ChargeSkill(p39, {
            ["Key"] = Enum.KeyCode.Z,
            ["CheckFunction"] = v53,
            ["EndFunction"] = v54,
            ["IgnoreInstantCastSetting"] = true
        })
        u45:Stop()
        _G.tween(u49, {
            0.25,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Transparency"] = 1
        })
        _G.destroy(u49, 0.25)
        u49 = nil
        local u55 = not v46 and 0 or v46:InvokeServer({
            ["siz"] = u47
        })
        pcall(function() --[[ Line: 234 ]]
            --[[
            Upvalues:
                [1] = u55
                [2] = u41
            --]]
            if u55 and u55 ~= 0 then
                local v56 = u41.Humanoid.Animator:LoadAnimation(script.serpantSlash)
                v56:Play()
                v56:AdjustWeight(2)
                v56:AdjustSpeed(0)
                task.wait(0.25)
                v56:Stop()
            end
        end)
        u41.HumanoidRootPart.Anchored = false
        u41.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Raging Serpent", v44)
        require(script.Parent.SwordStyleSwapping):matchCooldowns(v40)
        _G.fw(v44)
        v40["Raging Serpent"] = false
    end
end
function u8.DragonBlaze(u57, p58) --[[ Line: 255 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v59 = u57.Cooldowns
    local u60 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v59["Dragon Blaze"] == false and _G.check:inspect(u60) == true then
        local v61 = u3.GetM("Dragon Blaze")
        local v62 = v61.cd
        if _G.StamCheck("Dragon Blaze") == false then
            return
        end
        if v61.statreq and _G.MeetReq(v61.statreq) == false then
            return
        end
        _G.canuse = false
        local u63 = u60.Humanoid.Animator:LoadAnimation(script.dragonBlaze)
        u63:Play()
        u63:AdjustSpeed(0)
        _G.FaceMouse = true
        _G.PauseAnim(u63, 0.5, 1)
        v59["Dragon Blaze"] = true
        local u64 = tick()
        local v65 = game.ReplicatedStorage.Events.Skill:InvokeServer("Dragon Blaze")
        u57:ChargeSkill(p58, {
            ["Key"] = Enum.KeyCode.C,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 281 ]]
                --[[
                Upvalues:
                    [1] = u60
                    [2] = u63
                --]]
                if _G.check:inspect(u60) == false then
                    u63:Stop()
                    return true
                end
            end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 288 ]]
                --[[
                Upvalues:
                    [1] = u57
                    [2] = u60
                    [3] = u64
                --]]
                if u57.Tool.Parent ~= u60 or tick() - u64 >= 10 then
                    return true
                end
            end
        })
        local v66 = Ray.new(workspace.CurrentCamera.CFrame.Position, (u57:GetMouseCFrame().Position - workspace.CurrentCamera.CFrame.Position).unit * 400)
        local v67, v68, _ = _G.raycastIgnoreList(v66, {
            workspace.CurrentCamera,
            u60,
            workspace.Effects,
            workspace.Projectiles,
            workspace.NPCs,
            workspace.PlayerCharacters
        })
        if v67 == nil then
            local v69 = CFrame.new(v68)
            local v70 = Ray.new(v69.Position, v69.UpVector * -1000)
            local v71, v72
            v71, v68, v72 = _G.raycastIgnoreList(v70, {
                workspace.CurrentCamera,
                u60,
                workspace.Effects,
                workspace.Projectiles,
                workspace.NPCs,
                workspace.PlayerCharacters
            })
        end
        local v73 = (v68 - u60.HumanoidRootPart.CFrame.Position).Magnitude / 2
        local v74 = v73 / (math.random(100, 250) / 50)
        local v75 = u60.HumanoidRootPart.CFrame.Position
        local v76 = (u60.HumanoidRootPart.CFrame * CFrame.new(-v74, -v74 / 2, -v73)).Position
        local v77 = (u60.HumanoidRootPart.CFrame * CFrame.new(v74, v74 * 2, -v73)).Position
        if v65 ~= nil then
            v65:FireServer({
                v75,
                v76,
                v77,
                v68
            }, u57:GetMouseCFrame())
        end
        u60.HumanoidRootPart.Anchored = true
        u60.HumanoidRootPart.Anchored = false
        _G.FaceMouse = false
        u63:AdjustSpeed(1)
        task.wait(0.25)
        u60.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Dragon Blaze", v62)
        require(script.Parent.SwordStyleSwapping):matchCooldowns(v59)
        _G.fw(v62)
        v59["Dragon Blaze"] = false
    end
end
function u8.RapidSlashes(u78, p79) --[[ Line: 332 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v80 = u78.Cooldowns
    local u81 = u1.Character
    local u82 = u2["Stats" .. u1.Name]
    if v80["Rapid Slashes"] == false and _G.check:inspect(u81) == true then
        local v83 = u3.GetM("Rapid Slashes")
        local v84 = v83.cd
        if _G.StamCheck("Rapid Slashes") == false then
            return
        end
        if v83.statreq and _G.MeetReq(v83.statreq) == false then
            return
        end
        _G.canuse = false
        local v85 = u81.Humanoid.Animator:LoadAnimation(script.rapidStart)
        v85:Play()
        v85:AdjustSpeed(0)
        v80["Rapid Slashes"] = true
        u81.Humanoid.WalkSpeed = 4
        _G.PauseAnim(v85, 0.4, 1)
        v85:Stop()
        local v86 = u81.Humanoid.Animator:LoadAnimation(script.rapidHold)
        v86:Play()
        local v87 = game.ReplicatedStorage.Events.Skill:InvokeServer("Rapid Slashes")
        local u88 = tick()
        u78:ChargeSkill(p79, {
            ["Key"] = Enum.KeyCode.R,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 361 ]]
                --[[
                Upvalues:
                    [1] = u81
                --]]
                u81.Humanoid.WalkSpeed = 4
                if _G.check:inspect(u81) == false then
                    return true
                end
            end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 368 ]]
                --[[
                Upvalues:
                    [1] = u82
                    [2] = u88
                    [3] = u78
                    [4] = u81
                --]]
                if u82.Stamina.Value <= 0 or (tick() - u88 >= 4 or u78.Tool.Parent ~= u81) then
                    return true
                end
            end,
            ["IgnoreInstantCastSetting"] = true
        })
        v86:Stop()
        if v87 then
            v87:InvokeServer()
        end
        task.wait(0.4)
        u81.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Rapid Slashes", v84)
        require(script.Parent.SwordStyleSwapping):matchCooldowns(v80)
        _G.fw(v84)
        v80["Rapid Slashes"] = false
    end
end
function u8.ShishiSonson(u89, p90) --[[ Line: 396 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v91 = u89.Cooldowns
    local u92 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v91["Shishi Sonson"] == false and _G.check:inspect(u92) == true then
        local v93 = u3.GetM("Shishi Sonson")
        local v94 = v93.cd
        if _G.StamCheck("Shishi Sonson") == false then
            return
        end
        if v93.statreq and _G.MeetReq(v93.statreq) == false then
            return
        end
        _G.canuse = false
        local v95 = u92.Humanoid.Animator:LoadAnimation(script.shishi)
        v95:Play()
        v95:AdjustSpeed(0)
        v95:AdjustWeight(5)
        v91["Shishi Sonson"] = true
        _G.FaceMouse = true
        local v96 = game.ReplicatedStorage.Events.Skill:InvokeServer("Shishi Sonson")
        _G.PauseAnim(v95, 1, 1.1)
        local u97 = false
        local u98 = tick()
        local function v99() --[[ Line: 425 ]]
            --[[
            Upvalues:
                [1] = u92
                [2] = u97
            --]]
            u92.Humanoid.WalkSpeed = 4
            if _G.check:inspect(u92) == false then
                u97 = true
                return true
            end
        end
        u89:ChargeSkill(p90, {
            ["Key"] = Enum.KeyCode.X,
            ["CheckFunction"] = v99,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 433 ]]
                --[[
                Upvalues:
                    [1] = u89
                    [2] = u92
                    [3] = u98
                --]]
                if u89.Tool.Parent ~= u92 or tick() - u98 >= 10 then
                    return true
                end
            end
        })
        v95:AdjustSpeed(1.5)
        _G.FaceMouse = false
        if u97 == false then
            u92.HumanoidRootPart.Anchored = true
            local v100 = Ray.new(u92.HumanoidRootPart.CFrame.Position, (u89:GetMouseCFrame().Position - u92.HumanoidRootPart.CFrame.Position).unit * 100)
            local _, v101 = _G.raycastWhitelist(v100, { workspace.Islands, workspace.Ships, workspace.Env })
            local v102 = u92.HumanoidRootPart.CFrame
            local v103 = CFrame.new(v101, v102.Position) * CFrame.Angles(0, 3.141592653589793, 0) * CFrame.new(0, u92.Humanoid.HipHeight * 1.25, 2)
            u92.HumanoidRootPart.CFrame = v103
            local v104 = script.ColorCorrection:Clone()
            v104.Parent = workspace.CurrentCamera
            _G.tween(v104, {
                0.25,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Contrast"] = 0,
                ["Saturation"] = 0
            })
            _G.destroy(v104, 0.25)
            local u105 = {
                ["cf"] = v103,
                ["mag"] = (v102.Position - v103.Position).Magnitude,
                ["old"] = v102
            }
            spawn(function() --[[ Line: 461 ]]
                --[[
                Upvalues:
                    [1] = u92
                    [2] = u105
                --]]
                _G.PlayEffect("SonSon", nil, u92, u105)
            end)
            if v96 then
                v96:FireServer(u105)
            end
        end
        task.wait(1.2)
        u92.HumanoidRootPart.Anchored = false
        u92.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Shishi Sonson", v94)
        require(script.Parent.SwordStyleSwapping):matchCooldowns(v91)
        _G.fw(v94)
        v91["Shishi Sonson"] = false
    end
end
function u8.SwordStyleSwap(p106, _) --[[ Line: 482 ]]
    require(script.Parent.SwordStyleSwapping):swap(p106)
end
return u8