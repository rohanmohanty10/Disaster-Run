 

local u1 = game.Players.LocalPlayer
game:GetService("RunService")
local u2 = require(game.ReplicatedStorage.Modules.Skills)
local u3 = require(script.Parent.Parent.MobileBase)
require(u1.PlayerScripts:WaitForChild("PlayerModule"))
u1:GetMouse()
local u4 = setmetatable({}, u3)
u4.__index = u4
function u4.new(_) --[[ Line: 17 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u4
    --]]
    local v5 = u3.new(script.Name)
    local v6 = u4
    local v7 = setmetatable(v5, v6)
    v7.Cooldowns = {
        ["Rank"] = false,
        ["Tekkai"] = false,
        ["Shigan"] = false,
        ["Rokuogan"] = false
    }
    return v7
end
require(game.ReplicatedStorage.Modules.RotatedRegion3)
function u4.Rankakyu(u8, p9) --[[ Line: 33 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local v10 = u8.Cooldowns
    local v11 = game.ReplicatedStorage["Stats" .. u1.Name]
    local u12 = u1.Character
    if v10.Rank == false and (_G.check:inspect(u12) == true and _G.StamCheck("Rankakyu") == true) then
        local v13 = u2.GetM("Rankakyu")
        local v14 = v13.cd
        if v13.stamreq and v11.Stamina.Value < v13.stamreq then
            return
        end
        if v13.statreq and _G.MeetReq(v13.statreq) == false then
            return
        end
        v10.Rank = true
        _G.canuse = false
        game.ReplicatedStorage.Events.StamRequest:InvokeServer("Rankakyu")
        local v15 = u12.Humanoid:LoadAnimation(script.rank)
        v15:Play()
        _G.FaceMouse = true
        _G.PauseAnim(v15, 0.3, 1)
        local u16 = tick()
        u8:ChargeSkill(p9, {
            ["Key"] = Enum.KeyCode.Z,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 58 ]]
                --[[
                Upvalues:
                    [1] = u12
                    [2] = u8
                    [3] = u16
                --]]
                if _G.check:inspect(u12) == false or (u8.Tool.Parent ~= u12 or tick() - u16 >= 5) then
                    return true
                end
            end
        })
        v15:AdjustSpeed(1)
        local v17 = CFrame.new(u12.HumanoidRootPart.Position, u8:GetMouseCFrame().Position)
        task.wait(0.25)
        _G.FaceMouse = false
        u12.HumanoidRootPart.Anchored = true
        game.ReplicatedStorage.Events.Skill:InvokeServer("Rankakyu", {
            ["CFrame"] = v17
        })
        task.wait(0.5)
        u12.HumanoidRootPart.Anchored = false
        _G.canuse = true
        _G.keysetup:cooldown("Rankakyu", v14)
        _G.fw(v14)
        v10.Rank = false
    end
end
function u4.Tekkai(u18, p19) --[[ Line: 84 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local v20 = u18.Cooldowns
    local u21 = game.ReplicatedStorage["Stats" .. u1.Name]
    local u22 = u1.Character
    if v20.Tekkai == false and (_G.check:inspect(u22) == true and _G.StamCheck("Tekkai") == true) then
        local v23 = u2.GetM("Tekkai")
        local v24 = v23.cd
        if v23.stamreq and u21.Stamina.Value < v23.stamreq then
            return
        end
        if v23.statreq and _G.MeetReq(v23.statreq) == false then
            return
        end
        v20.Tekkai = true
        _G.canuse = false
        game.ReplicatedStorage.Events.StamRequest:InvokeServer("Tekkai")
        local v25 = u22.Humanoid:LoadAnimation(script.tekkai)
        v25:Play()
        local v26 = Instance.new("BodyVelocity", u22.HumanoidRootPart)
        v26.MaxForce = Vector3.new(inf, 0, inf)
        v26.Velocity = Vector3.new(0, 0, 0)
        _G.PauseAnim(v25, 0.85, 2, function() --[[ Line: 108 ]]
            --[[
            Upvalues:
                [1] = u22
            --]]
            u22.Humanoid.JumpPower = 0
        end)
        v25:AdjustSpeed(0)
        v25.Priority = Enum.AnimationPriority.Action4
        v25.TimePosition = 0.85
        local u27 = game.ReplicatedStorage.Events.Skill:InvokeServer("Tekkai", {
            ["CFrame"] = u22.HumanoidRootPart.CFrame,
            ["info"] = {}
        })
        if u27 then
            local u28 = u22:WaitForChild("Blocking", 3)
            local u29 = game.ReplicatedStorage.Util.Melee.BlockGui:Clone()
            u29.Parent = u22.HumanoidRootPart
            u18:ChargeSkill(p19, {
                ["Key"] = Enum.KeyCode.R,
                ["EndFunction"] = function() --[[ Name: endFunction, Line 123 ]]
                    --[[
                    Upvalues:
                        [1] = u28
                        [2] = u29
                        [3] = u22
                        [4] = u21
                        [5] = u27
                        [6] = u18
                    --]]
                    pcall(function() --[[ Line: 124 ]]
                        --[[
                        Upvalues:
                            [1] = u28
                            [2] = u29
                            [3] = u22
                        --]]
                        local v30 = u28.Value / u28.MaxValue
                        u29.ImageLabel.Frame.Position = UDim2.new(0, 0, 1 - v30, 0)
                        u29.ImageLabel.Frame.Size = UDim2.new(1, 0, v30, 0)
                        _G.canuse = false
                        u22.Humanoid.WalkSpeed = 0
                        u29.ImageLabel.Frame.ImageLabel.Size = UDim2.new(1, 0, 1 / v30, 0)
                        u29.ImageLabel.Frame.ImageLabel.Position = UDim2.new(0, 0, -(u29.ImageLabel.Frame.Position.Y.Scale / u29.ImageLabel.Frame.Size.Y.Scale), 0)
                    end)
                    if u28 == nil then
                        return true
                    end
                    if u28 and u28.Value <= 0 or (u28.Parent == nil or (u21.Stamina.Value <= 0 or (u27 == nil or u18.Tool and u18.Tool.Parent ~= u22))) then
                        return true
                    end
                end,
                ["IgnoreInstantCastSetting"] = true
            })
            u29:Destroy()
        end
        u22.Humanoid.WalkSpeed = 16
        if u27 then
            u27:FireServer()
        end
        v25:AdjustSpeed(1)
        u22.Humanoid.JumpPower = 50
        v26:Destroy()
        task.wait(0.5)
        _G.canuse = true
        _G.keysetup:cooldown("Tekkai", v24)
        _G.fw(v24)
        v20.Tekkai = false
    end
end
function u4.Shigan(u31, p32) --[[ Line: 166 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local v33 = u31.Cooldowns
    local v34 = game.ReplicatedStorage["Stats" .. u1.Name]
    local u35 = u1.Character
    if v33.Shigan == false and (_G.check:inspect(u35) == true and _G.StamCheck("Shigan") == true) then
        local v36 = u2.GetM("Shigan")
        local v37 = v36.cd
        if v36.stamreq and v34.Stamina.Value < v36.stamreq then
            return
        end
        if v36.statreq and _G.MeetReq(v36.statreq) == false then
            return
        end
        v33.Shigan = true
        _G.canuse = false
        game.ReplicatedStorage.Events.StamRequest:InvokeServer("Shigan")
        local u38 = u35.Humanoid:LoadAnimation(script.shigan)
        u38:Play()
        u38:AdjustWeight(3)
        _G.PauseAnim(u38, 0.3, 2, function() --[[ Line: 189 ]]
            --[[
            Upvalues:
                [1] = u35
            --]]
            u35.Humanoid.WalkSpeed = 4
        end)
        u31:ChargeSkill(p32, {
            ["Key"] = Enum.KeyCode.E,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 193 ]]
                --[[
                Upvalues:
                    [1] = u35
                    [2] = u31
                --]]
                u35.Humanoid.WalkSpeed = 4
                if u31.Tool.Parent ~= u35 or _G.check:inspect(u35) == false then
                    return true
                end
            end
        })
        u38:AdjustSpeed(4)
        local u39 = Instance.new("BodyVelocity", u35.HumanoidRootPart)
        u39.MaxForce = Vector3.new(100000, 0, 100000)
        u39.Velocity = u35.HumanoidRootPart.CFrame.LookVector * 75
        _G.destroy(u39, 0.1)
        u35.Humanoid.WalkSpeed = 16
        local u40 = false
        local function v42(p41) --[[ Line: 216 ]]
            --[[
            Upvalues:
                [1] = u39
            --]]
            u39:Destroy()
            u39 = nil
            game.ReplicatedStorage.Events.Skill:InvokeServer("Shigan", {
                ["Target"] = p41.Parent
            })
        end
        local function v43() --[[ Line: 222 ]]
            --[[
            Upvalues:
                [1] = u39
                [2] = u40
                [3] = u38
            --]]
            u39:Destroy()
            u39 = nil
            u40 = true
            u38:Stop()
        end
        _G.hitbox:start(u35, Vector3.new(5, 5, 5), 0.3, CFrame.new(0, 0, -1), v42, v43)
        task.wait(0.35)
        _G.canuse = true
        _G.keysetup:cooldown("Shigan", v37)
        _G.fw(v37)
        v33.Shigan = false
    end
end
function u4.Rokuogan(u44, p45) --[[ Line: 237 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local v46 = u44.Cooldowns
    local v47 = game.ReplicatedStorage["Stats" .. u1.Name]
    local u48 = u1.Character
    if v46.Rokuogan == false and (_G.check:inspect(u48) == true and _G.StamCheck("Rokuogan") == true) then
        local v49 = u2.GetM("Rokuogan")
        local v50 = v49.cd
        if v49.stamreq and v47.Stamina.Value < v49.stamreq then
            return
        end
        if v49.statreq and _G.MeetReq(v49.statreq) == false then
            return
        end
        v46.Rokuogan = true
        _G.canuse = false
        game.ReplicatedStorage.Events.StamRequest:InvokeServer("Rokuogan")
        local u51 = u48.Humanoid:LoadAnimation(script.rokuogan)
        u51:Play()
        u51:AdjustWeight(3)
        _G.FaceMouse = true
        _G.PauseAnim(u51, 0.45, 1, function() --[[ Line: 260 ]]
            --[[
            Upvalues:
                [1] = u48
            --]]
            u48.Humanoid.WalkSpeed = 0
        end)
        u44:ChargeSkill(p45, {
            ["Key"] = Enum.KeyCode.X,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 264 ]]
                --[[
                Upvalues:
                    [1] = u44
                    [2] = u48
                    [3] = u51
                --]]
                if u44.Tool.Parent ~= u48 or _G.check:inspect(u48) == false then
                    u51:Stop()
                    return true
                end
            end
        })
        _G.FaceMouse = false
        u51:AdjustSpeed(4)
        u48.HumanoidRootPart.Anchored = true
        if _G.check:inspect(u48) == true then
            task.wait(0.1)
            local u52 = CFrame.new(u48.HumanoidRootPart.Position, u44:GetMouseCFrame().Position)
            local u53 = u44:GetMouseCFrame()
            local v54 = Ray.new(u52.Position, u52.LookVector * 125)
            local _, v55 = _G.raycastWhitelist(v54, { workspace.Islands, workspace.Ships, workspace.Env })
            local _ = (v55 - u52.Position).Magnitude + 10
            local u56 = CFrame.new(v55, u48.HumanoidRootPart.CFrame.Position) * CFrame.Angles(0, 3.141592653589793, 0) * CFrame.new(0, u48.Humanoid.HipHeight * 2, 3)
            local v57 = (u52.Position - u53.Position).Magnitude
            local v58 = _G.getTargetsInRegion
            local v59 = CFrame.new(u52.Position, u53.Position) * CFrame.new(0, 0, -v57 / 2)
            local v60 = v57 + 5
            local v61 = v58(u48, v59, (Vector3.new(20, 20, v60)))
            local u62 = nil
            for v63 = 1, #v61 do
                if v61[v63].Parent ~= u48 and (v61[v63].Parent:FindFirstChild("targetGrabed") == nil and (v61[v63].Parent:FindFirstChildWhichIsA("ForceField") == nil and v61[v63].Parent:FindFirstChild("SeaNPC") == nil)) then
                    u62 = v61[v63].Parent
                    break
                end
            end
            if u62 then
                u56 = CFrame.new(u62.HumanoidRootPart.CFrame.Position, u48.HumanoidRootPart.CFrame.Position) * CFrame.Angles(0, 3.141592653589793, 0) * CFrame.new(0, 0, 2)
            end
            local v64 = TweenInfo.new(0.25, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out, 0, false, 0)
            local v65 = {
                ["CFrame"] = u56
            }
            game:GetService("TweenService"):Create(u48.HumanoidRootPart, v64, v65):Play()
            _G.clientimpacts[game.ReplicatedStorage.ClientImpacts.Soru]:start({
                ["char"] = u48
            })
            task.spawn(function() --[[ Line: 341 ]]
                --[[
                Upvalues:
                    [1] = u52
                    [2] = u56
                    [3] = u53
                --]]
                local v66 = require(script.Lightning)
                local v67 = game.ReplicatedStorage.MiscModels.RokuTrail:Clone()
                v67.Parent = workspace.Effects
                local v68 = v66:Fire(workspace.Effects, u52.Position, u56.Position, Vector3.new(-20, 0, -20), Vector3.new(20, 0, 20), 0.75, Color3.fromRGB(0, 255, 0), 1, nil, 0.25)
                for v69 = 1, #v68 do
                    game["Run Service"].RenderStepped:Wait()
                    v67.CFrame = CFrame.new(v68[v69], u53.Position)
                    v67.Trail.Enabled = true
                end
                task.wait()
                v67.Trail.Enabled = false
                _G.destroy(v67, 1)
            end)
            game:GetService("PhysicsService")
            if u62 then
                local _ = u56 * CFrame.new(0, 0, -2) * CFrame.Angles(1.5707963267948966, 0, 0)
                pcall(function() --[[ Line: 361 ]]
                    --[[
                    Upvalues:
                        [1] = u62
                        [2] = u56
                    --]]
                    local v70 = {
                        ["Target"] = u62,
                        ["cf"] = u56
                    }
                    game.ReplicatedStorage.Events.Skill:InvokeServer("Rokuogan", v70)
                end)
            else
                local v71 = {
                    ["Target"] = nil,
                    ["cf"] = u56
                }
                game.ReplicatedStorage.Events.Skill:InvokeServer("Rokuogan", v71)
            end
            task.wait()
            _G.canuse = true
            u48.Humanoid.WalkSpeed = 16
            task.wait(0.1)
        end
        u48.HumanoidRootPart.Anchored = false
        u48.Humanoid.WalkSpeed = 16
        _G.keysetup:cooldown("Rokuogan", v50)
        task.wait(1)
        _G.canuse = true
        _G.fw(v50)
        v46.Rokuogan = false
    end
end
return u4