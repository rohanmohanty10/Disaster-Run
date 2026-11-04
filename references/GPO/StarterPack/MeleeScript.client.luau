 

if _G.isCustomHUB == true then
    _G.canuse = true
    script:Destroy()
    return
end
local u1, u2, _, _, u3 = require(game.ReplicatedStorage.Modules.ScriptSet).get()
game:GetService("ProximityPromptService").Enabled = true
local v4 = game:GetService("UserInputService")
_G.HoldingBlockKey = false
local u5 = false
local u6 = false
local u7 = false
require(game.ReplicatedStorage.Modules.Skills)
local _ = _G.allowMelee
local u8 = game.ReplicatedStorage:WaitForChild("CombatAnimations", 1)
local u9 = {}
require(game.ReplicatedStorage.Modules.FastWait)
local u10 = require(game.ReplicatedStorage.Modules.SwordHandle.SwordInfo)
local u11 = u2:WaitForChild("Humanoid")
local u12 = u2.Humanoid:WaitForChild("Animator")
_G.FaceMouse = false
_G.canuse = true
_G.swordEquiped = false
_G.currentSword = nil
_G.toolLocked = nil
_G.canM1 = true
local function u17(p13) --[[ Line: 45 ]]
    local v14 = p13:GetChildren()
    local v15 = false
    for v16 = 1, #v14 do
        if v14[v16].Name:match("Buso") and v14[v16]:IsA("NumberValue") then
            v15 = true
        end
    end
    return v15
end
local _ = nil
local u18 = false
v4.InputEnded:Connect(function(p19, p20) --[[ Line: 98 ]]
    if not p20 then
        if p19.KeyCode == Enum.KeyCode.F then
            _G.HoldingBlockKey = false
        end
    end
end)
game:GetService("GuiService").MenuOpened:Connect(function() --[[ Line: 107 ]]
    --[[
    Upvalues:
        [1] = u6
        [2] = u18
    --]]
    if u6 ~= false then
        u18 = true
        _G.HoldingBlockKey = false
    end
end)
local u21 = require(u1.Backpack:WaitForChild("InputCallbacks"))
v4.InputBegan:Connect(function(p22, p23) --[[ Line: 129 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u6
        [3] = u18
        [4] = u21
    --]]
    u2:FindFirstChildWhichIsA("Tool")
    if u6 == true and (p22.KeyCode == Enum.KeyCode.Slash or p22.KeyCode == Enum.KeyCode.BackSlash) then
        u18 = true
        _G.HoldingBlockKey = false
        return
    elseif p23 ~= true then
        if p22.KeyCode == Enum.KeyCode.F then
            _G.HoldingBlockKey = true
        end
        if p22.KeyCode == Enum.KeyCode.J then
            u21.Callbacks.Buso:PC_Activate()
        end
        if p22.UserInputType == Enum.UserInputType.MouseButton1 then
            _G.HoldingM1 = true
            while _G.HoldingM1 == true do
                if u21.Utils.holdingValidMelee() == true then
                    u21.Callbacks.Attack:PC_Activate()
                end
                task.wait()
            end
        end
    end
end)
v4.InputEnded:Connect(function(p24, _) --[[ Line: 157 ]]
    if p24.UserInputType == Enum.UserInputType.MouseButton1 then
        _G.HoldingM1 = false
    end
end)
local u25 = nil
local u26 = {}
local u27 = nil
local u28 = nil
u2.ChildAdded:Connect(function(u29) --[[ Line: 167 ]]
    --[[
    Upvalues:
        [1] = u10
        [2] = u25
        [3] = u28
        [4] = u2
        [5] = u3
        [6] = u1
        [7] = u27
        [8] = u12
        [9] = u8
        [10] = u9
        [11] = u26
        [12] = u5
    --]]
    if u29:IsA("Tool") and (u29:GetAttributes().MeleeTool ~= nil or u10[u29.Name]) then
        u25 = u29
        if u28 then
            u28:Stop()
            u28:Destroy()
            u28 = nil
        end
        local v30 = u2:GetAttribute("customM1") ~= nil
        local v31 = u3.Stats.FightingStyle.Value
        if v31 and (game.ReplicatedStorage.CombatAnimations:FindFirstChild(u3.Stats.FightingStyle.Value) and (u10[u29.Name] == nil and v30 == false)) then
            if u29:GetAttributes().MeleeTool ~= nil then
                local v32 = u1.Backpack:FindFirstChild(v31) or u29
                if v32.Name == v31 and u29:GetAttribute("customIdle") == nil then
                    local v33 = v32:GetAttribute("idleName") or "Idle"
                    local v34
                    if v32.Main:FindFirstChild("Idle2") == nil then
                        v34 = v32.Main:FindFirstChild(v33)
                        local v35 = v32:GetAttribute("idleAsWalk")
                        if u27 == nil or v35 ~= nil then
                            if v35 then
                                if u27 then
                                    u27:Stop()
                                    u27:Destroy()
                                    u27 = nil
                                end
                                u27 = u12:LoadAnimation(v34)
                            end
                        else
                            u27:Stop()
                            u27:Destroy()
                            u27 = nil
                        end
                    else
                        v34 = v32.Main:FindFirstChild(v33)
                        if u27 == nil then
                            u27 = u12:LoadAnimation(v32.Main.Idle2)
                        end
                    end
                    u28 = u12:LoadAnimation(v34)
                end
            end
        elseif u27 then
            u27:Stop()
            u27:Destroy()
            u27 = nil
        end
        if v30 == false then
            if u28 == nil then
                u28 = u12:LoadAnimation(u8.Melee.Idle)
            end
            if u27 == nil then
                u27 = u12:LoadAnimation(u8.Melee.Idle)
            else
                u27.Priority = Enum.AnimationPriority.Action
            end
            if u29:GetAttributes().MeleeTool ~= nil and (u9[u29.Name] == nil and _G.canuse == true) then
                u28:Play(0.25)
            end
            if u29:GetAttribute("customIdle") ~= nil or _G.canuse == false then
                u28:Stop()
            end
            u26[u29] = u29.AttributeChanged:Connect(function() --[[ Line: 246 ]]
                --[[
                Upvalues:
                    [1] = u29
                    [2] = u28
                    [3] = u9
                --]]
                if u29:GetAttribute("customIdle") == nil then
                    if u28.IsPlaying == false and (u29:GetAttributes().MeleeTool ~= nil and (u9[u29.Name] == nil and u29.Name ~= "BlackLeg")) then
                        u28:Play(0.25)
                    end
                else
                    u28:Stop()
                end
            end)
        elseif u28 then
            u28:Stop()
            u28 = nil
        end
        u5 = true
    end
end)
u2.ChildRemoved:Connect(function(p36) --[[ Line: 269 ]]
    --[[
    Upvalues:
        [1] = u10
        [2] = u25
        [3] = u5
        [4] = u28
        [5] = u26
    --]]
    if p36:IsA("Tool") and (p36:GetAttributes().MeleeTool ~= nil or u10[p36.Name]) then
        u25 = nil
        u5 = false
        if u28 then
            u28:Stop()
        end
    end
    if u26[p36] then
        u26[p36]:Disconnect()
        u26[p36] = nil
    end
end)
game["Run Service"].Heartbeat:Connect(function() --[[ Line: 285 ]]
    --[[
    Upvalues:
        [1] = u11
        [2] = u25
        [3] = u2
        [4] = u27
        [5] = u28
    --]]
    if u11 == nil then
        return
    elseif u25 == nil or u25 and not u25:GetAttribute("MeleeTool") or u2:GetAttribute("customM1") ~= nil then
        if u27 then
            u27:Stop()
        end
        if u28 then
            u28:Stop()
        end
        return
    elseif u25.Parent == u2 and (_G.canuse ~= false and _G.blocking ~= true) then
        if u11.MoveDirection == Vector3.new() and u11.FloorMaterial ~= Enum.Material.Air then
            if u28 and u28.IsPlaying == false then
                u28:Play()
            end
            if u27 and u27.IsPlaying == true then
                u27:Stop()
            end
        else
            if u28 and u28.IsPlaying == true then
                u28:Stop()
            end
            if u27 and u27.IsPlaying == false then
                u27:Play()
                return
            end
        end
    elseif u27 then
        if u27.IsPlaying == true then
            u27:Stop()
        end
        if u28.IsPlaying == true then
            u28:Stop()
        end
    end
end)
while true do
    local u37 = nil
    local v61, v62 = pcall(function() --[[ Line: 334 ]]
        --[[
        Upvalues:
            [1] = u7
            [2] = u2
            [3] = u6
            [4] = u21
            [5] = u12
            [6] = u37
            [7] = u17
            [8] = u11
            [9] = u18
        --]]
        if _G.HoldingBlockKey == true then
            local u38 = false
            local u39 = true
            local function v40() --[[ Line: 339 ]]
                --[[
                Upvalues:
                    [1] = u7
                    [2] = u2
                    [3] = u38
                    [4] = u39
                --]]
                if u7 == false and (_G.canuse == true and (_G.check:inspect(u2) == true and (u2:FindFirstChildWhichIsA("Tool") and u2.Parent == workspace.PlayerCharacters))) then
                    u38 = true
                else
                    u38 = false
                    u39 = false
                end
            end
            v40()
            tick()
            local v41 = u39
            while u38 ~= true and _G.HoldingBlockKey ~= false do
                v40()
                game["Run Service"].RenderStepped:Wait()
                if u38 == true or (_G.HoldingBlockKey == false or u2.Parent ~= workspace.PlayerCharacters) then
                    break
                end
            end
            if _G.HoldingBlockKey == false then
                return
            end
            v40()
            u7 = true
            u6 = true
            _G.blocking = true
            u21.Callbacks.Attack:stopM1Anims()
            local v42 = u2:FindFirstChildWhichIsA("Tool")
            local v43 = {}
            local u44 = nil
            if not pcall(function() --[[ Line: 377 ]]
                --[[
                Upvalues:
                    [1] = u44
                    [2] = u12
                    [3] = u2
                --]]
                u44 = u12:LoadAnimation(u2:FindFirstChildWhichIsA("Tool").Main.Block)
            end) then
                if u44 then
                    u44:Destroy()
                end
                u44 = u12:LoadAnimation(game.ReplicatedStorage.Util.Melee.Block)
            end
            local v45 = u2:GetAttribute("customM1Model")
            if v45 then
                local v46 = u2:FindFirstChild(v45)
                if v46 then
                    if u44 then
                        u44:Destroy()
                    end
                    local v47 = u2:GetAttribute("customM1")
                    local v48 = game.ReplicatedStorage.Modules.SwordHandle.Swords:FindFirstChild(v47)
                    u44 = v46.AnimationController:LoadAnimation(v48.Block)
                end
            end
            u44.Priority = Enum.AnimationPriority.Action3
            if v42 then
                local v49 = u2:FindFirstChild(v42.Name .. "Sword")
                if v49 and v49:FindFirstChild("AnimationController") then
                    local v50 = v49.AnimationController:LoadAnimation(u2:FindFirstChildWhichIsA("Tool").Main.Block)
                    v50.Priority = Enum.AnimationPriority.Action3
                    table.insert(v43, v50)
                end
            end
            local v51 = u44
            table.insert(v43, v51)
            local v52 = u38
            for v53 = 1, #v43 do
                v43[v53]:Play()
            end
            warn("invoke block remote")
            local u54
            if v52 == true then
                u54 = game.ReplicatedStorage.Events.Block:InvokeServer(true, "Melee", v41)
            else
                u54 = nil
            end
            warn("finished invoke block remote")
            u37 = game.ReplicatedStorage.Util.Melee.BlockGui:Clone()
            u37.Parent = u2.HumanoidRootPart
            if v45 ~= nil then
                u37.MaxDistance = 200
            end
            if u17(u2) == true then
                u37.ImageLabel.Frame.ImageLabel.ImageColor3 = Color3.fromRGB(85, 85, 255)
            end
            if v41 == false then
                local v55 = u37.ImageLabel.Frame.ImageLabel.ImageColor3
                u37.ImageLabel.Frame.ImageLabel.ImageColor3 = Color3.fromHSV(select(1, v55:ToHSV()), select(2, v55:ToHSV()), 0.75)
            end
            if u54 then
                local v56 = tick()
                while true do
                    u11.WalkSpeed = 5
                    local u57 = false
                    local v59, _ = pcall(function() --[[ Line: 449 ]]
                        --[[
                        Upvalues:
                            [1] = u54
                            [2] = u2
                            [3] = u57
                            [4] = u37
                            [5] = u18
                        --]]
                        if u54 == nil or u54 and (u54.Parent == nil or u54:IsDescendantOf(u2) == false) then
                            u57 = true
                        end
                        _G.blocking = true
                        local v58 = u54.Value / u54.MaxValue
                        u37.ImageLabel.Frame.Size = UDim2.new(1, 0, v58, 0)
                        u37.ImageLabel.Frame.Position = UDim2.new(0, 0, 1 - v58, 0)
                        u37.ImageLabel.Frame.ImageLabel.Size = UDim2.new(1, 0, 1 / v58, 0)
                        u37.ImageLabel.Frame.ImageLabel.Position = UDim2.new(0, 0, -(u37.ImageLabel.Frame.Position.Y.Scale / u37.ImageLabel.Frame.Size.Y.Scale), 0)
                        if u2.Humanoid.SeatPart ~= nil or u2.Humanoid.Sit == true then
                            u57 = true
                        end
                        if game:GetService("GuiService").MenuIsOpen == true then
                            u18 = true
                            u57 = true
                        end
                    end)
                    if v59 == false or u57 == true then
                        break
                    end
                    game["Run Service"].RenderStepped:Wait()
                    if _G.HoldingBlockKey == false and tick() - v56 >= 0.1 or (u54 == nil or u54 and u54.Parent == nil or (u54:IsDescendantOf(u2) == false or (u2.Parent ~= workspace.PlayerCharacters or v42 and v42.Parent ~= u2))) then
                        break
                    end
                end
            end
            if _G.HoldingBlockKey == false then
                blockHold = false
            end
            _G.blocking = false
            if u54 then
                u54:Destroy()
            end
            u37:Destroy()
            u11.WalkSpeed = 16
            for v60 = 1, #v43 do
                v43[v60]:Stop()
            end
            u6 = false
            game.ReplicatedStorage.Events.Block:InvokeServer(false, "Melee")
            _G.keysetup:cooldown("Block", 1)
            task.wait(1)
            u7 = false
        end
    end)
    if not v61 then
        warn("ERROR:", v62)
        _G.blocking = false
        _G.HoldingBlockKey = false
        u6 = false
        u7 = false
        if u37 then
            u37:Destroy()
        end
    end
    game["Run Service"].RenderStepped:Wait()
end