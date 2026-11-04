 

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
        ["spin"] = false,
        ["sweep"] = false
    }
    return v9
end
function u6.FireworkRush(u10, p11) --[[ Line: 31 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v12 = u10.Cooldowns
    local u13 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v12.spin == false and _G.check:inspect(u13) == true then
        local v14 = u3.GetM("Firework Rush")
        local v15 = v14.cd
        if _G.StamCheck("Firework Rush") == false then
            return
        end
        if v14.statreq and _G.MeetReq(v14.statreq) == false then
            return
        end
        local u16 = u10.Tool
        local v17 = u13.Humanoid.Animator:LoadAnimation(script.hop)
        v17:Play()
        v17:AdjustWeight(2)
        v17:AdjustSpeed(1)
        v17.Priority = Enum.AnimationPriority.Action4
        v12.spin = true
        _G.canuse = false
        local u18 = game.ReplicatedStorage.Events.Skill:InvokeServer("Firework Rush")
        local u19 = Instance.new("BodyVelocity")
        u19.MaxForce = Vector3.new(100000, 100000, 100000)
        u19.Parent = u13.LowerTorso
        _G.tween(u19, {
            0.5,
            Enum.EasingStyle.Cubic,
            Enum.EasingDirection.In,
            0,
            false,
            0
        }, {
            ["MaxForce"] = Vector3.new(100000, 100000, 100000)
        })
        local u20 = tick()
        local u21 = false
        local v28 = game["Run Service"].Heartbeat:Connect(function(_) --[[ Line: 66 ]]
            --[[
            Upvalues:
                [1] = u20
                [2] = u21
                [3] = u13
                [4] = u16
                [5] = u10
                [6] = u19
            --]]
            if tick() - u20 > 0.3 and u21 ~= true then
                if u13:FindFirstChild(script.Name) == nil then
                    task.defer(function() --[[ Line: 72 ]]
                        --[[
                        Upvalues:
                            [1] = u13
                            [2] = u16
                        --]]
                        u13.Humanoid:UnequipTools()
                        u13.Humanoid:EquipTool(u16)
                    end)
                end
                local v22 = u10:GetMouseCFrame()
                local v23 = workspace.CurrentCamera:ViewportPointToRay(v22.X, v22.Y)
                local v24 = v23.Origin + v23.Direction * 20
                local v25 = CFrame.new(u13.PrimaryPart.Position, v24).Position
                local v26 = tick() - u20
                local _ = 45 + 11 * v26
                if v25 then
                    local v27 = 45 + 11 * v26
                    u19.Velocity = u13.PrimaryPart.CFrame.LookVector * Vector3.new(v27, 0, v27)
                end
            end
        end)
        task.wait(0.6)
        v17:Stop()
        local v29 = u13.Humanoid.Animator:LoadAnimation(script.loop)
        v29:Play()
        v29.Priority = Enum.AnimationPriority.Action4
        v29:AdjustWeight(2)
        local u30 = tick()
        local u31 = nil
        local function v33(p32) --[[ Line: 105 ]]
            --[[
            Upvalues:
                [1] = u18
                [2] = u21
                [3] = u31
            --]]
            if u18 and (u21 == false and p32.Parent:FindFirstChild("SeaNPC") == nil) then
                u31 = true
                u18:FireServer(p32.Parent.PrimaryPart)
            end
            u21 = true
        end
        _G.hitbox:start(u13, Vector3.new(15, 10, 15), 1.8, CFrame.new(0, 0, -3), v33)
        local function v34() --[[ Line: 122 ]]
            --[[
            Upvalues:
                [1] = u13
                [2] = u30
                [3] = u21
            --]]
            if u13:FindFirstChild(script.Name) == nil or tick() - u30 >= 1.8 then
                return true
            end
            if u21 == true then
                return true
            end
        end
        u10:ChargeSkill(p11, {
            ["Key"] = Enum.KeyCode.R,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 117 ]] end,
            ["EndFunction"] = v34,
            ["IgnoreInstantCastSetting"] = true
        })
        u21 = true
        v29:Stop()
        v28:Disconnect()
        local v35 = u13.Humanoid.Animator:LoadAnimation(script.off)
        v35:Play()
        v35:AdjustWeight(2)
        if u31 ~= true and u18 then
            u18:FireServer()
        end
        _G.tween(u19, {
            0.25,
            Enum.EasingStyle.Cubic,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["MaxForce"] = Vector3.new(0, 0, 0)
        })
        _G.destroy(u19, 0.25)
        u13.HumanoidRootPart.Anchored = false
        u13.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Firework Rush", v15)
        _G.fw(v15)
        v12.spin = false
    end
end
u6["TOTHEMOON!"] = function(u36, p37) --[[ Line: 161 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v38 = u36.Cooldowns
    local u39 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v38.sweep == false and _G.check:inspect(u39) == true then
        local v40 = u3.GetM("TO THE MOON!")
        local v41 = v40.cd
        if _G.StamCheck("TO THE MOON!") == false then
            return
        end
        if v40.statreq and _G.MeetReq(v40.statreq) == false then
            return
        end
        local u42 = u39.Humanoid.Animator:LoadAnimation(script.stab)
        u42:Play()
        u42:AdjustWeight(2)
        v38.sweep = true
        _G.canuse = false
        local v43 = game.ReplicatedStorage.Events.Skill:InvokeServer("TO THE MOON!")
        _G.PauseAnim(u42, 0.35, 1)
        local u44 = tick()
        u36:ChargeSkill(p37, {
            ["Key"] = Enum.KeyCode.E,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 188 ]]
                --[[
                Upvalues:
                    [1] = u39
                --]]
                u39.Humanoid.WalkSpeed = 4
                _G.canuse = false
            end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 194 ]]
                --[[
                Upvalues:
                    [1] = u39
                    [2] = u36
                    [3] = u44
                    [4] = u42
                --]]
                if _G.check:inspect(u39) == false or (u36.Tool.Parent ~= u39 or tick() - u44 >= 10) then
                    u42:Stop()
                    return true
                end
            end
        })
        u42:AdjustSpeed(1)
        if v43 then
            v43:FireServer(u39.HumanoidRootPart.CFrame)
        end
        task.wait(0.4)
        u39.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("TO THE MOON!", v41)
        _G.fw(v41)
        v38.sweep = false
    end
end
return u6