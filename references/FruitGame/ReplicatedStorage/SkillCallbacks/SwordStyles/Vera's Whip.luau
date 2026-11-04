 

local u1 = game.Players.LocalPlayer
game:GetService("RunService")
local u2 = game:GetService("ReplicatedStorage")
local u3 = require(game.ReplicatedStorage.Modules.Skills)
local u4 = require(script.Parent.Parent.MobileBase)
local v5 = require(u1.PlayerScripts:WaitForChild("PlayerModule"))
u1:GetMouse()
v5:GetControls()
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
        ["slam"] = false,
        ["block"] = false
    }
    return v9
end
function u6.TempestuousDefence(p10, p11) --[[ Line: 28 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v12 = p10.Cooldowns
    local u13 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v12.block == false and _G.check:inspect(u13) == true then
        local v14 = u3.GetM("Tempestuous Defence")
        local v15 = v14.cd
        if _G.StamCheck("Tempestuous Defence") == false then
            return
        end
        if v14.statreq and _G.MeetReq(v14.statreq) == false then
            return
        end
        local v16 = u13.Humanoid.Animator:LoadAnimation(script.blockloop)
        v16:Play(0)
        v16:AdjustWeight(2)
        local v17 = u13:FindFirstChild(script.Name .. "Sword")
        local v18
        if v17 then
            local v19 = v17.AnimationController.Animator:GetPlayingAnimationTracks()
            for v20 = 1, #v19 do
                v19[v20]:Stop(0)
            end
            v18 = v17.AnimationController.Animator:LoadAnimation(script.blockloop)
            v18:Play(0)
            v18:AdjustWeight(500)
        else
            v18 = nil
        end
        v12.block = true
        _G.canuse = false
        local v21 = game.ReplicatedStorage.Events.Skill:InvokeServer("Tempestuous Defence")
        local u22 = tick()
        local u23 = false
        if v21 then
            task.spawn(function() --[[ Line: 70 ]]
                --[[
                Upvalues:
                    [1] = u13
                    [2] = u23
                --]]
                local u24 = u13:WaitForChild("Blocking", 3)
                local u25 = game.ReplicatedStorage.Util.Melee.BlockGui:Clone()
                u25.Parent = u13.HumanoidRootPart
                repeat
                    game["Run Service"].RenderStepped:Wait()
                    pcall(function() --[[ Line: 75 ]]
                        --[[
                        Upvalues:
                            [1] = u24
                            [2] = u25
                        --]]
                        local v26 = u24.Value / u24.MaxValue
                        u25.ImageLabel.Frame.Position = UDim2.new(0, 0, 1 - v26, 0)
                        u25.ImageLabel.Frame.Size = UDim2.new(1, 0, v26, 0)
                        u25.ImageLabel.Frame.ImageLabel.Size = UDim2.new(1, 0, 1 / v26, 0)
                        u25.ImageLabel.Frame.ImageLabel.Position = UDim2.new(0, 0, -(u25.ImageLabel.Frame.Position.Y.Scale / u25.ImageLabel.Frame.Size.Y.Scale), 0)
                    end)
                until u23 == true
                u25:Destroy()
            end)
        end
        p10:ChargeSkill(p11, {
            ["Key"] = Enum.KeyCode.R,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 87 ]]
                --[[
                Upvalues:
                    [1] = u13
                --]]
                u13.Humanoid.WalkSpeed = 4
            end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 91 ]]
                --[[
                Upvalues:
                    [1] = u13
                    [2] = u22
                --]]
                if u13:FindFirstChild(script.Name) == nil or (tick() - u22 >= 1.5 or u13:FindFirstChild("Blocking") == nil) then
                    return true
                end
            end,
            ["IgnoreInstantCastSetting"] = true
        })
        local _ = true
        v16:Stop()
        if v18 then
            v18:Stop()
        end
        if v21 then
            v21:FireServer()
        end
        if v17 and v17:FindFirstChild("AnimationController") then
            local v27 = v17.AnimationController:LoadAnimation(game.ReplicatedStorage.Modules.SwordHandle.Swords["Vera\'s Whip"].Idle)
            v27:Play(0)
            v27.Priority = Enum.AnimationPriority.Core
        end
        u13.HumanoidRootPart.Anchored = false
        u13.Humanoid.WalkSpeed = 16
        task.wait(0.35)
        _G.canuse = true
        _G.keysetup:cooldown("Tempestuous Defence", v15)
        _G.fw(v15)
        v12.block = false
    end
end
function u6.WhipSlam(p28, p29) --[[ Line: 127 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v30 = p28.Cooldowns
    local u31 = u1.Character
    local u32 = u2["Stats" .. u1.Name]
    if v30.slam == false and _G.check:inspect(u31) == true then
        local v33 = u3.GetM("Whip Slam")
        local v34 = v33.cd
        if _G.StamCheck("Whip Slam") == false then
            return
        end
        if v33.statreq and _G.MeetReq(v33.statreq) == false then
            return
        end
        _G.canuse = false
        local u35 = game.ReplicatedStorage.Events.Skill:InvokeServer("Whip Slam", {
            ["cf"] = p28:GetMouseCFrame()
        })
        v30.slam = true
        local v36 = u31.Humanoid:LoadAnimation(script.windup)
        v36:Play()
        v36:AdjustWeight(5)
        v36.Priority = Enum.AnimationPriority.Action
        v36:AdjustSpeed(0)
        local v37 = u31:FindFirstChild(script.Name .. "Sword")
        local v38
        if v37 and v37:FindFirstChild("AnimationController") then
            v38 = v37.AnimationController:LoadAnimation(script.windup)
            v38:Play()
            v38.Priority = Enum.AnimationPriority.Action
            v38:AdjustWeight(5)
            v38:AdjustSpeed(0)
        else
            v38 = nil
        end
        _G.canuse = false
        u31.Humanoid.WalkSpeed = 4
        local u39 = tick()
        p28:ChargeSkill(p29, {
            ["Key"] = Enum.KeyCode.E,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 165 ]]
                --[[
                Upvalues:
                    [1] = u31
                --]]
                u31.Humanoid.WalkSpeed = 4
            end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 170 ]]
                --[[
                Upvalues:
                    [1] = u39
                    [2] = u31
                    [3] = u32
                --]]
                if tick() - u39 >= 5 or (u31:FindFirstChild(script.Name) == nil or (u31.Parent == nil or (u31.Parent ~= workspace.PlayerCharacters or (u32.Stamina.Value <= 0 or _G.check:inspect(u31) == false)))) then
                    return true
                end
            end
        })
        v36:AdjustSpeed(0.75)
        if v38 then
            v38:AdjustSpeed(0.75)
        end
        if u35 then
            u35:FireServer("woosh")
        end
        task.wait(0.30000000000000004)
        local u40 = nil
        local function v42(p41) --[[ Line: 194 ]]
            --[[
            Upvalues:
                [1] = u35
                [2] = u31
                [3] = u40
            --]]
            if u35 then
                u35:FireServer(u31.PrimaryPart.CFrame, p41.Parent)
                u40 = true
            end
        end
        _G.hitbox:start(u31, Vector3.new(10, 10, 18), 0.25, CFrame.new(0, 0, -9), v42)
        task.wait(0.5)
        u31.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Whip Slam", v34)
        _G.fw(v34)
        v30.slam = false
    end
end
return u6