 

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
        ["oversizedBall"] = false,
        ["shower"] = false,
        ["FusilladeFist"] = false,
        ["FistOfLove"] = false,
        ["InstantSoru"] = false,
        ["Galaxy"] = false
    }
    return v7
end
require(game.ReplicatedStorage.Modules.RotatedRegion3)
function u4.OversizedIronBall(u8, p9) --[[ Line: 33 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local v10 = u8.Cooldowns
    local _ = game.ReplicatedStorage["Stats" .. u1.Name]
    local u11 = u1.Character
    if v10.oversizedBall == false and _G.check:inspect(u11) == true then
        local v12 = u2.GetM("Oversized Iron Ball")
        local v13 = v12.cd
        if _G.StamCheck("Oversized Iron Ball") == false then
            return
        end
        if v12.statreq and _G.MeetReq(v12.statreq) == false then
            return
        end
        v10.oversizedBall = true
        _G.canuse = false
        u11.Humanoid.WalkSpeed = 4
        u11.Humanoid.WalkSpeed = 4
        local u14 = game.ReplicatedStorage.Events.Skill:InvokeServer("Oversized Iron Ball", {
            ["cf"] = u11.HumanoidRootPart.CFrame
        })
        local u15 = tick()
        u8:ChargeSkill(p9, {
            ["Key"] = Enum.KeyCode.E,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 63 ]]
                --[[
                Upvalues:
                    [1] = u11
                    [2] = u8
                    [3] = u14
                    [4] = u15
                --]]
                u11.Humanoid.WalkSpeed = 4
                _G.canuse = false
                if u8.Tool.Parent ~= u11 or (u11:FindFirstChild("Stun") or (u14 == nil or (tick() - u15 >= 2 or _G.check:inspect(u11) == false))) then
                    return true
                end
            end,
            ["IgnoreInstantCastSetting"] = true
        })
        if u14 then
            u14:InvokeServer(u11.PrimaryPart.CFrame)
        end
        task.wait(0.3)
        u11.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Oversized Iron Ball", v13)
        _G.fw(v13)
        v10.oversizedBall = false
    end
end
function u4.MeteorFistShower(u16, p17) --[[ Line: 91 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local v18 = u16.Cooldowns
    local _ = game.ReplicatedStorage["Stats" .. u1.Name]
    local u19 = u1.Character
    if v18.shower == false and _G.check:inspect(u19) == true then
        local v20 = u2.GetM("Meteor Fist Shower")
        local v21 = v20.cd
        if _G.StamCheck("Meteor Fist Shower") == false then
            return
        end
        if v20.statreq and _G.MeetReq(v20.statreq) == false then
            return
        end
        v18.shower = true
        _G.canuse = false
        _G.FaceMouse = true
        local u22 = game.ReplicatedStorage.Events.Skill:InvokeServer("Meteor Fist Shower", u16:GetMouseCFrame())
        local u23 = tick()
        u16:ChargeSkill(p17, {
            ["Key"] = Enum.KeyCode.R,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 114 ]]
                --[[
                Upvalues:
                    [1] = u22
                    [2] = u16
                    [3] = u19
                    [4] = u23
                --]]
                _G.canuse = false
                if u22 then
                    u22:FireServer(u16:GetMouseCFrame())
                end
                if u16.Tool.Parent ~= u19 or (u19:FindFirstChild("Stun") or (u22 == nil or u22 and u22:IsDescendantOf(game) == false)) or (tick() - u23 >= 5 or _G.check:inspect(u19) == false) then
                    return true
                end
            end,
            ["IgnoreInstantCastSetting"] = true
        })
        if u22 then
            u22:FireServer()
        end
        _G.FaceMouse = false
        _G.canuse = true
        _G.keysetup:cooldown("Meteor Fist Shower", v21)
        _G.fw(v21)
        v18.shower = false
    end
end
function u4.FusilladeFist(u24, p25) --[[ Line: 144 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local v26 = u24.Cooldowns
    local _ = game.ReplicatedStorage["Stats" .. u1.Name]
    local u27 = u1.Character
    if v26.FusilladeFist == false and _G.check:inspect(u27) == true then
        local v28 = u2.GetM("Fusillade Fist")
        local v29 = v28.cd
        if _G.StamCheck("Fusillade Fist") == false then
            return
        end
        if v28.statreq and _G.MeetReq(v28.statreq) == false then
            return
        end
        v26.FusilladeFist = true
        _G.canuse = false
        local u30 = Instance.new("BodyVelocity")
        u30.MaxForce = Vector3.new(100000, 0, 100000)
        u30.Parent = u27.LowerTorso
        local u31 = game.ReplicatedStorage.Events.Skill:InvokeServer("Fusillade Fist", {
            ["cf"] = u27.HumanoidRootPart.CFrame
        })
        local u32 = tick()
        local u33 = u27.PrimaryPart
        local u34 = RaycastParams.new()
        u34.FilterType = Enum.RaycastFilterType.Include
        u34.FilterDescendantsInstances = { workspace.Env, workspace.Ships, workspace.Islands }
        u24:ChargeSkill(p25, {
            ["Key"] = Enum.KeyCode.Z,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 177 ]]
                --[[
                Upvalues:
                    [1] = u30
                    [2] = u27
                    [3] = u33
                    [4] = u34
                    [5] = u24
                    [6] = u31
                    [7] = u32
                --]]
                _G.canuse = false
                u30.Velocity = u27.PrimaryPart.CFrame.LookVector * 50
                local v35 = workspace:Raycast(u33.Position, u33.CFrame.LookVector * 6, u34)
                if v35 and v35.Instance then
                    return true
                end
                if u24.Tool.Parent ~= u27 or (u27:FindFirstChild("Stun") or (u31 == nil or (tick() - u32 >= 2 or u27:GetAttribute("FuissiladeFistHold") == nil))) then
                    return true
                end
            end,
            ["IgnoreInstantCastSetting"] = true
        })
        u27.Humanoid.AutoRotate = false
        u30.MaxForce = Vector3.new(100000000000, 100000000000, 100000000000)
        _G.tween(u30, {
            0.5,
            "EntranceExpressive",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Velocity"] = Vector3.new(0, 0, 0)
        })
        if u31 then
            u31:InvokeServer(u27.PrimaryPart.CFrame)
        end
        u30:Destroy()
        u27.Humanoid.AutoRotate = true
        _G.canuse = true
        _G.keysetup:cooldown("Fusillade Fist", v29)
        _G.fw(v29)
        v26.FusilladeFist = false
    end
end
function u4.FistOfLove(u36, p37) --[[ Line: 219 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local v38 = u36.Cooldowns
    local _ = game.ReplicatedStorage["Stats" .. u1.Name]
    local u39 = u1.Character
    if v38.FistOfLove == false and _G.check:inspect(u39) == true then
        local v40 = u2.GetM("Fist Of Love")
        local v41 = v40.cd
        if _G.StamCheck("Fist Of Love") == false then
            return
        end
        if v40.statreq and _G.MeetReq(v40.statreq) == false then
            return
        end
        v38.FistOfLove = true
        _G.canuse = false
        _G.FaceMouse = true
        local u42 = game.ReplicatedStorage.Events.Skill:InvokeServer("Fist Of Love", u36:GetMouseCFrame())
        local u43 = tick()
        u36:ChargeSkill(p37, {
            ["Key"] = Enum.KeyCode.X,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 242 ]]
                --[[
                Upvalues:
                    [1] = u36
                    [2] = u39
                    [3] = u42
                    [4] = u43
                --]]
                _G.canuse = false
                if u36.Tool.Parent ~= u39 or (u39:FindFirstChild("Stun") or (u42 == nil or tick() - u43 >= 5)) then
                    return true
                end
            end
        })
        _G.FaceMouse = false
        u39.PrimaryPart.Anchored = true
        if u42 then
            u42:InvokeServer(u39.PrimaryPart.CFrame)
        end
        u39.PrimaryPart.Anchored = false
        _G.canuse = true
        _G.keysetup:cooldown("Fist Of Love", v41)
        _G.fw(v41)
        v38.FistOfLove = false
    end
end
function u4.GalaxyImpact(p44, _) --[[ Line: 271 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local v45 = p44.Cooldowns
    local _ = game.ReplicatedStorage["Stats" .. u1.Name]
    local v46 = u1.Character
    if v45.Galaxy == false and _G.check:inspect(v46) == true then
        local v47 = u2.GetM("Galaxy Impact")
        local v48 = v47.cd
        if _G.StamCheck("Galaxy Impact") == false then
            return
        end
        if v47.statreq and _G.MeetReq(v47.statreq) == false then
            return
        end
        v45.Galaxy = true
        _G.canuse = false
        game.ReplicatedStorage.Events.Skill:InvokeServer("Galaxy Impact", v46.PrimaryPart.CFrame)
        _G.canuse = true
        _G.keysetup:cooldown("Galaxy Impact", v48)
        _G.fw(v48)
        v45.Galaxy = false
    end
end
return u4