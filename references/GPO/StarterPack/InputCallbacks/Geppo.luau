 

local u1 = {}
u1.__index = u1
local v2 = game:GetService("ReplicatedStorage")
local v3 = game.Players.LocalPlayer
local u4 = game:GetService("UserInputService")
local u5 = v3.Character or v3.CharacterAdded:Wait()
local u6 = false
local u7 = v2:WaitForChild("Stats" .. v3.Name)
local u8 = false
local u9 = 0
local u10 = 0
local u11 = u5.Humanoid.Animator
local u12 = require(game.ReplicatedStorage.Modules.Skills)
local u13 = 1
local u14 = script.geppoIndicator:Clone()
u14.Parent = u5.PrimaryPart
local u15 = false
local u16 = nil
local function u18() --[[ Line: 29 ]]
    --[[
    Upvalues:
        [1] = u5
        [2] = u15
        [3] = u7
    --]]
    local v17
    if _G.isCustomHUB == false and (_G.canGlide == true and (u5.Humanoid.Sit == false and u15 == false)) then
        v17 = (u7.Stats.FightingStyle.Value == "Rokushiki" or (u7.Stats.FightingStyle.Value == "BlackLeg" or u7.Stats.FightingStyle.Value == "Kamishiki")) and true or u7.Skills.skyWalk.Value == true
    else
        v17 = false
    end
    return v17
end
local function u23() --[[ Line: 33 ]]
    --[[
    Upvalues:
        [1] = u14
        [2] = u9
        [3] = u5
    --]]
    local v19 = u14.ImageLabel.ImageLabel:GetChildren()
    for v20 = 1, #v19 do
        if v19[v20]:IsA("Frame") then
            v19[v20].BackgroundTransparency = 0
            v19[v20].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        end
    end
    for u21 = 1, u9 do
        pcall(function() --[[ Line: 43 ]]
            --[[
            Upvalues:
                [1] = u14
                [2] = u21
            --]]
            u14.ImageLabel.ImageLabel[u21].BackgroundTransparency = 0.5
            u14.ImageLabel.ImageLabel[u21].BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        end)
    end
    if u9 <= 0 then
        u9 = 0
        game.ReplicatedStorage.Util.Movement.geppoReady:Play()
        local v22 = Instance.new("Highlight")
        v22.FillColor = Color3.fromRGB(255, 255, 255)
        v22.FillTransparency = 0
        v22.OutlineTransparency = 1
        v22.Parent = u5
        _G.tween(v22, { 1, "Cubic", Enum.EasingDirection.Out }, {
            ["FillTransparency"] = 1
        })
        _G.destroy(v22, 1)
        u14.Enabled = false
        if currentGeppoRegen then
            currentGeppoRegen:Disconnect()
            currentGeppoRegen = nil
        end
    end
end
local function u26(p24) --[[ Line: 67 ]]
    --[[
    Upvalues:
        [1] = u6
        [2] = u9
        [3] = u10
        [4] = u5
        [5] = u26
        [6] = u23
        [7] = u15
    --]]
    u6 = false
    if u9 >= 5 then
        u9 = 5
    end
    u9 = u9 - 1
    u10 = 0
    if currentGeppoRegen then
        currentGeppoRegen:Disconnect()
        currentGeppoRegen = nil
    end
    if u9 > 0 and p24 == nil then
        currentGeppoRegen = game["Run Service"].Heartbeat:Connect(function(p25) --[[ Line: 82 ]]
            --[[
            Upvalues:
                [1] = u5
                [2] = u10
                [3] = u26
            --]]
            if u5.Humanoid.FloorMaterial ~= Enum.Material.Air then
                u10 = u10 + p25
                if u10 >= 1 then
                    u26()
                end
            end
        end)
    end
    u23()
    u15 = false
end
function u1.new(p27) --[[ Line: 96 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u9
        [3] = u26
    --]]
    local v28 = u1
    local u29 = setmetatable({}, v28)
    u29.Handler = p27
    u29.Utils = p27.Utils
    game.ReplicatedStorage.Events.geppoManager.OnClientEvent:Connect(function() --[[ Line: 101 ]]
        --[[
        Upvalues:
            [1] = u9
            [2] = u29
            [3] = u26
        --]]
        if u9 <= 0 then
            return
        elseif u29.Utils.inCombatCheck() ~= false then
            u26(true)
        end
    end)
    return u29
end
local u30 = nil
local function u66(p31) --[[ Line: 117 ]]
    --[[
    Upvalues:
        [1] = u8
        [2] = u5
        [3] = u9
        [4] = u10
        [5] = u15
        [6] = u6
        [7] = u30
        [8] = u7
        [9] = u12
        [10] = u11
        [11] = u13
        [12] = u14
        [13] = u16
        [14] = u23
        [15] = u26
        [16] = u4
        [17] = u18
        [18] = u66
    --]]
    u8 = not u8
    local v32 = u5:GetAttribute("evading") ~= nil
    if _G.check:inspect(u5) == false and (v32 == false and u5:FindFirstChild("ragcarry") == nil) then
        return
    end
    if u5.Humanoid.PlatformStand == true or (u5.Humanoid:GetState() == Enum.HumanoidStateType.Physics or u5.PrimaryPart.Anchored == true) then
        return
    end
    if u5:GetAttribute("flyMode") then
        return
    end
    if p31.Utils.inCombatCheck() and u9 >= 5 then
        local v33 = _G.displayMessage
        local v34 = 2 - u10
        v33("<Color=Red>Geppo is on cooldown until you remain on the ground for " .. math.ceil(v34) .. " seconds.")
        script.DashOut:Play()
        if u15 == false then
            u6 = true
        end
        u8 = false
        u15 = true
        return
    end
    if u30 then
        task.cancel(u30)
        u30 = nil
    end
    if u8 ~= false or _G.canuse ~= true and v32 ~= true or (_G.swimming ~= false or (_G.StamCheck("Sky Walk2", true) ~= true or u5:FindFirstChild("Cuffed") ~= nil)) then
        u30 = task.delay(0.35, function() --[[ Line: 389 ]]
            --[[
            Upvalues:
                [1] = u8
            --]]
            u8 = false
        end)
        return
    end
    if u7.Stats.FightingStyle.Value == "Rokushiki" then
        local v35 = u12.GetM("Geppo")
        local _ = v35.cd
        if v35.statreq and _G.MeetReq(v35.statreq, nil, true) == false then
            return
        end
        if u7.Skills.Rokushiki.Value < 4 then
            return
        end
    elseif u7.Stats.FightingStyle.Value == "BlackLeg" then
        local v36 = u12.GetM("Sky Walk")
        local _ = v36.cd
        if v36.statreq and _G.MeetReq(v36.statreq, nil, true) == false then
            return
        end
        if u7.Skills.BlackLeg.Value < 3 then
            return
        end
    elseif u7.Stats.FightingStyle.Value == "Kamishiki" then
        local v37 = u12.GetM("KamishikiGeppo")
        local _ = v37.cd
        if v37.statreq and _G.MeetReq(v37.statreq, nil, true) == false then
            return
        end
    else
        if u7.Skills.skyWalk.Value ~= true then
            return
        end
        local v38 = u12.GetM("Sky Walk2")
        local _ = v38.cd
        if v38.statreq and _G.MeetReq(v38.statreq, nil, true) == false then
            return
        end
    end
    _G.canuse = false
    task.spawn(function() --[[ Line: 192 ]]
        task.wait(0.1)
        _G.canuse = true
    end)
    u15 = true
    local v39 = u5:FindFirstChild("LeopardRig")
    local v40
    if v39 == nil then
        v40 = u11:LoadAnimation(game.ReplicatedStorage.Util.Movement["Geppo" .. u13])
        v40.Priority = Enum.AnimationPriority.Action
        v40:Play(0.25)
        v40:AdjustWeight(5)
        v40:AdjustSpeed(2)
    else
        v40 = v39.AnimationController:LoadAnimation(script.LeopardGeppo["Geppo" .. u13])
        v40:Play(0.25)
        v40:AdjustWeight(5)
    end
    local v41 = Instance.new("BodyVelocity")
    v41.MaxForce = Vector3.new(1000000, 1000000, 1000000)
    v41.Name = "geppo"
    local v42 = _G.running == true and 75 or 50
    local v43 = _G.ScaleWithHP(v42)
    if v39 ~= nil then
        v43 = v43 * 1.25
    end
    local v44 = u5.Humanoid.MoveDirection * v43
    local v45 = _G.ScaleWithHP(25)
    v41.Velocity = v44 + Vector3.new(0, v45, 0)
    _G.destroy(v41, 0.25)
    task.delay(0.3, function() --[[ Line: 231 ]]
        --[[
        Upvalues:
            [1] = u5
        --]]
        local v46 = Instance.new("BoolValue", u5.HumanoidRootPart)
        v46.Name = "geppo"
        _G.destroy(v46, 0.25)
    end)
    local v47 = tick()
    local v48 = u5.HumanoidRootPart.CFrame
    local v49
    if u5.Humanoid.MoveDirection == Vector3.new(0, 0, 0) then
        v49 = true
        v48 = u5.HumanoidRootPart.CFrame
        v41.Velocity = u5.HumanoidRootPart.CFrame.upVector * v43
        v40:Stop()
        if v39 == nil then
            v40 = u11:LoadAnimation(game.ReplicatedStorage.Util.Movement["Geppo2" .. u13])
            v40.Priority = Enum.AnimationPriority.Action
            v40:Play(0.25)
            v40:AdjustWeight(5)
            v40:AdjustSpeed(2)
        else
            v40 = v39.AnimationController:LoadAnimation(script.LeopardGeppo["Geppo2" .. u13])
            v40:Play(0.25)
            v40:AdjustWeight(5)
        end
    else
        v49 = false
    end
    local _ = _G.clientimpacts[game.ReplicatedStorage.ClientImpacts.BeamRing]
    local v50 = u5.HumanoidRootPart.CFrame * CFrame.new(0, -2, 0)
    if v49 == true then
        local _ = v50 * CFrame.Angles(1.5707963267948966, 0, 0)
    end
    local u51 = CFrame.lookAt(u5.HumanoidRootPart.Position, v41.Velocity + u5.PrimaryPart.Position)
    if v39 then
        local v52 = v39:FindFirstChild(u13 == 2 and "LowerLeg.R" or "LowerLeg.L", true)
        if v52 then
            local v53 = v52.WorldPosition
            u51 = CFrame.lookAt(v53, v41.Velocity + v53)
        end
    end
    u10 = 0
    local v54 = {
        ["char"] = u5,
        ["cf"] = u51
    }
    _G.PlayEffect("Geppo", nil, v54)
    v41.Parent = u5.HumanoidRootPart
    local _ = v41.Velocity
    task.spawn(function() --[[ Line: 295 ]]
        --[[
        Upvalues:
            [1] = u7
            [2] = u5
            [3] = u51
        --]]
        if u7.Stats.FightingStyle.Value == "Rokushiki" then
            local v55 = {
                ["char"] = u5,
                ["cf"] = u51
            }
            game.ReplicatedStorage.Events.Skill:InvokeServer("Geppo", v55)
            if _G.keysetup then
                _G.keysetup:cooldown("Geppo", 0.25)
                return
            end
        elseif u7.Stats.FightingStyle.Value == "BlackLeg" then
            local v56 = {
                ["char"] = u5,
                ["cf"] = u51
            }
            game.ReplicatedStorage.Events.Skill:InvokeServer("Sky Walk", v56)
            if _G.keysetup then
                _G.keysetup:cooldown("Sky Walk", 0.25)
                return
            end
        else
            if u7.Stats.FightingStyle.Value == "Kamishiki" then
                local v57 = {
                    ["char"] = u5,
                    ["cf"] = u51
                }
                game.ReplicatedStorage.Events.Skill:InvokeServer("KamishikiGeppo", v57)
                return
            end
            if u7.Skills.skyWalk.Value == true then
                local v58 = {
                    ["char"] = u5,
                    ["cf"] = u51
                }
                game.ReplicatedStorage.Events.Skill:InvokeServer("Sky Walk2", v58)
            end
        end
    end)
    while true do
        u5.Humanoid.AutoRotate = false
        if v49 == false and (u5.HumanoidRootPart.CFrame.Position - v48.Position).magnitude >= 0.1 then
            local v59 = u5.HumanoidRootPart
            local v60 = CFrame.new
            local v61 = u5.HumanoidRootPart.Position
            local v62 = v48.X + 0.001
            local v63 = u5.HumanoidRootPart.Position.Y
            local v64 = v48.Z + 0.001
            v59.CFrame = v60(v61, (Vector3.new(v62, v63, v64))) * CFrame.Angles(0, 3.141592653589793, 0)
        end
        if u5:FindFirstChild("Stun") and (u5:GetAttribute("evading") == nil and v41) then
            v41.MaxForce = Vector3.new()
            v41:Destroy()
            if u5:FindFirstChild("knockback", true) == nil then
                u5.PrimaryPart.AssemblyLinearVelocity = Vector3.new()
            end
            break
        end
        game["Run Service"].RenderStepped:Wait()
        if tick() - v47 >= 0.25 then
            break
        end
    end
    u5.Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
    u5.Humanoid.AutoRotate = true
    u9 = u9 + 1
    if p31.Utils.inCombatCheck() == true then
        u14.Enabled = true
        if u16 then
            task.cancel(u16)
            u16 = nil
        end
        u23()
    else
        u14.Enabled = false
        u9 = 0
    end
    if p31.Utils.inCombatCheck() and u9 >= 5 then
        script.DashOut:Play()
    end
    if p31.Utils.inCombatCheck() then
        if currentGeppoRegen then
            currentGeppoRegen:Disconnect()
            currentGeppoRegen = nil
        end
        currentGeppoRegen = game["Run Service"].Heartbeat:Connect(function(p65) --[[ Line: 366 ]]
            --[[
            Upvalues:
                [1] = u5
                [2] = u10
                [3] = u26
            --]]
            if u5.Humanoid.FloorMaterial ~= Enum.Material.Air then
                u10 = u10 + p65
                if u10 >= 1 then
                    u26()
                end
            end
        end)
    end
    v40:Stop(0.25)
    u13 = u13 + 1
    if u13 > 2 then
        u13 = 1
    end
    u15 = false
    task.wait(0.1)
    if (u4:IsKeyDown(Enum.KeyCode.Space) == true or _G.mobileJumpHeld == true) and (u6 == false and u18() == true) then
        u8 = true
        u66(p31)
    end
end
function u1.PC_Activate(p67) --[[ Line: 395 ]]
    --[[
    Upvalues:
        [1] = u14
        [2] = u6
        [3] = u18
        [4] = u66
    --]]
    if p67.Utils.inCombatCheck() == false then
        u14.Enabled = false
    end
    if u6 == false and (not _G.grounded and u18() == true) then
        u66(p67)
    end
end
u1.Mobile_Activate = u1.PC_Activate
return u1