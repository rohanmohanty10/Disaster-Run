 

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
        ["pull"] = false,
        ["bullet"] = false
    }
    v8.CurrentSwipe = 1
    v8.doingSlash = false
    return v8
end
function u5.IceGunbladePull(p9, p10) --[[ Line: 29 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v11 = p9.Cooldowns
    local u12 = u1.Character
    local u13 = u2["Stats" .. u1.Name]
    if v11.pull == false and (_G.check:inspect(u12) == true and _G.StamCheck("IceGunbladePull") == true) then
        local v14 = u3.GetM("IceGunbladePull")
        local v15 = v14.cd
        if _G.StamCheck("IceGunbladePull") == false then
            return
        end
        if v14.statreq and _G.MeetReq(v14.statreq) == false then
            return
        end
        v11.pull = true
        _G.canuse = false
        u12.PrimaryPart.Anchored = true
        u12.Humanoid.AutoRotate = false
        u12:PivotTo(CFrame.new(u12.PrimaryPart.Position, p9:GetMouseCFrame().Position))
        local v16 = u12.Humanoid:LoadAnimation(script.kurowindup)
        v16:Play()
        v16:AdjustSpeed(2)
        task.wait(0.2)
        local u17 = game.ReplicatedStorage.Events.Skill:InvokeServer("IceGunbladePull", u12.PrimaryPart.CFrame)
        v16:Stop()
        local v18 = u12.Humanoid:LoadAnimation(script.kuroloop)
        v18:Play()
        local u19 = tick()
        p9:ChargeSkill(p10, {
            ["Key"] = Enum.KeyCode.r,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 60 ]]
                --[[
                Upvalues:
                    [1] = u17
                    [2] = u12
                --]]
                if u17 == nil then
                    return true
                end
                u12.Humanoid.AutoRotate = false
            end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 68 ]]
                --[[
                Upvalues:
                    [1] = u12
                    [2] = u19
                    [3] = u13
                --]]
                if not u12:FindFirstChild(script.Name) or (tick() - u19 >= 2 or (u12.Parent == nil or (u12.Parent ~= workspace.PlayerCharacters or (u13.Stamina.Value <= 0 or u12:FindFirstChild("PB") ~= nil)))) then
                    return true
                end
            end,
            ["IgnoreInstantCastSetting"] = true
        })
        _G.FaceMouse = false
        if u17 then
            u17:FireServer(u12.PrimaryPart.CFrame)
        end
        v18:AdjustSpeed(0)
        task.wait(0.75)
        u12.Humanoid.AutoRotate = true
        v18:Stop(0.25)
        u12.PrimaryPart.Anchored = false
        _G.keysetup:cooldown("IceGunbladePull", v15)
        _G.canuse = true
        _G.fw(v15)
        v11.pull = false
    end
end
function u5.FrostBlast(p20, p21) --[[ Line: 101 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v22 = p20.Cooldowns
    local u23 = u1.Character
    local u24 = u2["Stats" .. u1.Name]
    if v22.pull == false and (_G.check:inspect(u23) == true and _G.StamCheck("Frost Blast") == true) then
        local v25 = u3.GetM("Frost Blast")
        local v26 = v25.cd
        if _G.StamCheck("Frost Blast") == false then
            return
        end
        if v25.statreq and _G.MeetReq(v25.statreq) == false then
            return
        end
        v22.pull = true
        _G.canuse = false
        _G.FaceMouse = true
        local v27 = u23.Humanoid:LoadAnimation(script.gunBurstCharge)
        v27:Play()
        local u28 = game.ReplicatedStorage.Events.Skill:InvokeServer("Frost Blast")
        local u29 = tick()
        local v30 = u23:FindFirstChild(script.Name .. "Sword")
        p20:ChargeSkill(p21, {
            ["Key"] = Enum.KeyCode.R,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 129 ]]
                --[[
                Upvalues:
                    [1] = u28
                    [2] = u23
                --]]
                if u28 == nil then
                    return true
                end
                u23.Humanoid.AutoRotate = false
            end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 136 ]]
                --[[
                Upvalues:
                    [1] = u23
                    [2] = u29
                    [3] = u24
                --]]
                if not u23:FindFirstChild(script.Name) or (tick() - u29 >= 3 or (_G.check:inspect(u23) == false or (u23.Parent == nil or (u23.Parent ~= workspace.PlayerCharacters or (u24.Stamina.Value <= 0 or u23:FindFirstChild("PB") ~= nil))))) then
                    return true
                end
            end,
            ["IgnoreInstantCastSetting"] = true,
            ["HoldDuration"] = 0.2
        })
        _G.FaceMouse = false
        u23.PrimaryPart.Anchored = true
        local v31 = u23.PrimaryPart.CFrame
        if v30 then
            local v32 = v30:FindFirstChild("Muzzle")
            if v32 then
                v31 = v32.CFrame
            end
        end
        if u28 then
            u28:InvokeServer(u23.PrimaryPart.CFrame, v31)
            task.wait(0.05)
        end
        v27:Stop()
        local v33 = u23.Humanoid:LoadAnimation(script.gunBurstShoot)
        v33:Play()
        v33:AdjustSpeed(1.25)
        task.wait(0.3)
        u23.PrimaryPart.Anchored = false
        u23.Humanoid.AutoRotate = true
        v33:Stop(0.25)
        u23.PrimaryPart.Anchored = false
        _G.keysetup:cooldown("Frost Blast", v26)
        _G.canuse = true
        _G.fw(v26)
        v22.pull = false
    end
end
function u5.FrostBullets(u34, u35) --[[ Line: 188 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local u36 = u34.Cooldowns
    local u37 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if u36.bullet == false and (_G.check:inspect(u37) == true and (_G.StamCheck("Frost Bullets") == true and u34.doingSlash == false)) then
        local v38 = u3.GetM("Frost Bullets")
        local u39 = v38.cd
        if _G.StamCheck("Frost Bullets") == false then
            return
        end
        if v38.statreq and _G.MeetReq(v38.statreq) == false then
            return
        end
        u36.bullet = true
        _G.canuse = false
        local u40 = game.ReplicatedStorage.Events.Skill:InvokeServer("Frost Bullets", u37.PrimaryPart.CFrame)
        local u41 = 1
        local u42 = false
        local u43 = nil
        local function u46() --[[ Line: 213 ]]
            --[[
            Upvalues:
                [1] = u34
                [2] = u42
                [3] = u43
                [4] = u37
                [5] = u41
                [6] = u36
                [7] = u40
            --]]
            _G.canuse = false
            u34.doingSlash = true
            u42 = true
            if u43 then
                u43:Stop(0)
            end
            local u44 = u37.Humanoid.Animator:LoadAnimation(script["shoot" .. u41])
            u44:Play(0)
            u44:AdjustWeight(2)
            u44.Priority = Enum.AnimationPriority.Action4
            u43 = u44
            u36.bullet = true
            u37.Humanoid.AutoRotate = false
            u37.PrimaryPart.CFrame = CFrame.new(u37.PrimaryPart.Position, u34:GetMouseCFrame().Position)
            if u40 and u40:InvokeServer(u34:GetMouseCFrame(), workspace:GetServerTimeNow() + 0.275) == false then
                u41 = u41 - 1
            end
            local u45 = false
            task.spawn(function() --[[ Line: 238 ]]
                --[[
                Upvalues:
                    [1] = u44
                    [2] = u45
                --]]
                u44.Stopped:Wait()
                u45 = true
            end)
            task.delay(0.8, function() --[[ Line: 242 ]]
                --[[
                Upvalues:
                    [1] = u45
                --]]
                u45 = true
            end)
            repeat
                task.wait()
            until u45 == true
            u37.Humanoid.AutoRotate = true
            _G.canuse = true
            u42 = false
        end
        u46()
        local function u48() --[[ Line: 256 ]]
            --[[
            Upvalues:
                [1] = u34
                [2] = u35
                [3] = u41
                [4] = u46
                [5] = u39
                [6] = u36
                [7] = u48
                [8] = u37
                [9] = u42
            --]]
            u34:DoubleCastSkill(u35, {
                ["Key"] = Enum.KeyCode.E,
                ["SkipTap"] = true,
                ["CompleteFunction"] = function() --[[ Name: CompleteFunction, Line 260 ]]
                    --[[
                    Upvalues:
                        [1] = u41
                        [2] = u46
                        [3] = u34
                        [4] = u39
                        [5] = u36
                        [6] = u48
                    --]]
                    u41 = u41 + 1
                    u46()
                    if u41 >= 3 then
                        u34.doingSlash = false
                        _G.canuse = true
                        _G.keysetup:cooldown("Frost Bullets", u39)
                        _G.fw(u39)
                        u36.bullet = false
                    else
                        u48()
                    end
                end,
                ["PassFunction"] = function() --[[ Name: PassFunction, Line 274 ]]
                    --[[
                    Upvalues:
                        [1] = u37
                        [2] = u42
                    --]]
                    task.wait()
                    local v47 = u37:FindFirstChild(script.Name)
                    if v47 then
                        if u42 == false and _G.check:inspect(u37) == true then
                            v47 = _G.canuse == true
                        else
                            v47 = false
                        end
                    end
                    return v47
                end
            })
        end
        u48()
        _G.keysetup:cooldown("Frost Bullets", u39)
        _G.canuse = true
        _G.fw(u39)
        u36.bullet = false
    end
end
return u5