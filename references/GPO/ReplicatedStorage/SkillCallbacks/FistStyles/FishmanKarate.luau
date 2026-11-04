 

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
        ["BrickFist"] = false,
        ["Pirson"] = false,
        ["Shark"] = false,
        ["ser"] = false,
        ["bomb"] = false
    }
    return v7
end
function u4.FiveThousandBrickFist(p8, p9) --[[ Line: 31 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local v10 = p8.Cooldowns
    local u11 = game.ReplicatedStorage["Stats" .. u1.Name]
    local u12 = u1.Character
    if v10.BrickFist == false and (_G.StamCheck("Five Thousand Brick Fist") == true and (_G.canuse == true and _G.check:inspect(u12) == true)) then
        local v13 = u2.GetM("Five Thousand Brick Fist")
        local v14 = v13.cd
        if v13.statreq and _G.MeetReq(v13.statreq) == false then
            return
        end
        v10.BrickFist = true
        _G.canuse = false
        local u15 = u12.Humanoid:LoadAnimation(script.brickfist)
        u15:Play()
        u15:AdjustWeight(3)
        local u16 = game.ReplicatedStorage.Events.Skill:InvokeServer("Five Thousand Brick Fist")
        _G.PauseAnim(u15, 0.25, 1)
        tick()
        p8:ChargeSkill(p9, {
            ["Key"] = Enum.KeyCode.E,
            ["CheckFunction"] = function() --[[ Name: CheckFunction, Line 56 ]]
                --[[
                Upvalues:
                    [1] = u12
                --]]
                u12.Humanoid.WalkSpeed = 4
            end,
            ["EndFunction"] = function() --[[ Name: EndFunction, Line 59 ]]
                --[[
                Upvalues:
                    [1] = u11
                    [2] = u12
                --]]
                return u11.Stamina.Value <= 0 and true or (u12.Parent == workspace.Ragdolls and true or u12:FindFirstChild("Stun"))
            end
        })
        u15:AdjustSpeed(2)
        local u17 = Instance.new("BodyVelocity", u12.HumanoidRootPart)
        u17.MaxForce = Vector3.new(100000, 0, 100000)
        u17.Velocity = u12.HumanoidRootPart.CFrame.LookVector * 100
        _G.destroy(u17, 0.15)
        local u18 = false
        local function v20(p19) --[[ Line: 72 ]]
            --[[
            Upvalues:
                [1] = u17
                [2] = u12
                [3] = u16
            --]]
            u17:Destroy()
            u12.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
            if u16 then
                u16:FireServer({
                    ["Target"] = p19.Parent,
                    ["cf"] = u12.PrimaryPart.CFrame * CFrame.new(0, 0, -2)
                })
            end
        end
        local function v21() --[[ Line: 79 ]]
            --[[
            Upvalues:
                [1] = u17
                [2] = u18
                [3] = u15
            --]]
            u17:Destroy()
            u18 = true
            u15:Stop()
        end
        if u16 then
            u16:FireServer("dash")
        end
        _G.hitbox:start(u12, Vector3.new(5, 5, 5), 0.5, CFrame.new(0, 0, -1.5), v20, v21)
        task.wait(0.35)
        u12.Humanoid.WalkSpeed = 16
        _G.keysetup:cooldown("Five Thousand Brick Fist", v14)
        _G.canuse = true
        _G.fw(v14)
        v10.BrickFist = false
    end
end
function u4.WaterPrison(p22, p23) --[[ Line: 97 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local v24 = p22.Cooldowns
    local u25 = game.ReplicatedStorage["Stats" .. u1.Name]
    local u26 = u1.Character
    if v24.Pirson == false and (_G.StamCheck("Water Prison") == true and (_G.canuse == true and _G.check:inspect(u26) == true)) then
        local v27 = u2.GetM("Water Prison")
        local v28 = v27.cd
        if v27.statreq and _G.MeetReq(v27.statreq) == false then
            return
        end
        v24.Pirson = true
        _G.canuse = false
        local v29 = u26.Humanoid:LoadAnimation(script.bubble)
        v29:Play()
        v29:AdjustWeight(3)
        _G.PauseAnim(v29, 0.25, 1)
        tick()
        p22:ChargeSkill(p23, {
            ["Key"] = Enum.KeyCode.R,
            ["EndFunction"] = function() --[[ Name: EndFunction, Line 121 ]]
                --[[
                Upvalues:
                    [1] = u26
                    [2] = u25
                --]]
                u26.Humanoid.WalkSpeed = 4
                return u25.Stamina.Value <= 0 and true or u26.Parent == workspace.Ragdolls
            end
        })
        v29:AdjustSpeed(1)
        task.wait(0.1)
        game.ReplicatedStorage.Events.Skill:InvokeServer("Water Prison", {
            ["cf"] = p22:GetMouseCFrame()
        })
        task.wait(0.2)
        u26.Humanoid.WalkSpeed = 16
        _G.keysetup:cooldown("Water Prison", v28)
        _G.canuse = true
        _G.fw(v28)
        v24.Pirson = false
    end
end
function u4.SharkBarrage(p30, p31) --[[ Line: 140 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local v32 = p30.Cooldowns
    local u33 = game.ReplicatedStorage["Stats" .. u1.Name]
    local u34 = u1.Character
    if v32.Shark == false and (_G.StamCheck("Shark Barrage") == true and (_G.canuse == true and _G.check:inspect(u34) == true)) then
        local v35 = u2.GetM("Shark Barrage")
        local v36 = v35.cd
        if v35.statreq and _G.MeetReq(v35.statreq) == false then
            return
        end
        v32.Shark = true
        _G.canuse = false
        local v37 = u34.Humanoid:LoadAnimation(script.barwind)
        v37:Play()
        _G.FaceMouse = true
        _G.PauseAnim(v37, 0.6, 0.8)
        v37:Stop()
        local v38 = u34.Humanoid:LoadAnimation(script.barloop)
        v38:Play()
        local u39 = tick()
        local v40 = game.ReplicatedStorage.Events.Skill:InvokeServer("Shark Barrage", {
            ["cf"] = u34.HumanoidRootPart.CFrame
        })
        p30:ChargeSkill(p31, {
            ["Key"] = Enum.KeyCode.Z,
            ["EndFunction"] = function() --[[ Name: EndFunction, Line 168 ]]
                --[[
                Upvalues:
                    [1] = u34
                    [2] = u33
                    [3] = u39
                --]]
                return not u34:FindFirstChild("FishmanKarate") or ((u33.Stamina.Value <= 0 or (tick() - u39 >= 5 or u34.Parent == workspace.Ragdolls)) and true or _G.check:inspect(u34) == false)
            end,
            ["IgnoreInstantCastSetting"] = true
        })
        _G.FaceMouse = false
        v38:Stop()
        if v40 then
            v40:FireServer()
        end
        u34.Humanoid.WalkSpeed = 16
        _G.keysetup:cooldown("Shark Barrage", v36)
        _G.canuse = true
        _G.fw(v36)
        v32.Shark = false
    end
end
function u4.WaterSerpent(u41, _) --[[ Line: 188 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local v42 = u41.Cooldowns
    local _ = game.ReplicatedStorage["Stats" .. u1.Name]
    local v43 = u1.Character
    if v42.ser == false and (_G.StamCheck("Water Serpent") == true and (_G.canuse == true and _G.check:inspect(v43) == true)) then
        local v44 = u2.GetM("Water Serpent")
        local v45 = v44.cd
        if v44.statreq and _G.MeetReq(v44.statreq) == false then
            return
        end
        v42.ser = true
        _G.canuse = false
        local v46 = v43.Humanoid:LoadAnimation(script.sharksummon)
        v46:Play()
        v46:AdjustSpeed(1.5)
        task.wait(0.26666666666666666)
        local u47 = game.ReplicatedStorage.Events.Skill:InvokeServer("Water Serpent", {
            ["pos"] = u41:GetMouseCFrame()
        })
        if u47 then
            task.spawn(function() --[[ Line: 208 ]]
                --[[
                Upvalues:
                    [1] = u47
                    [2] = u41
                --]]
                while u47.Parent ~= nil do
                    u47:FireServer(u41:GetMouseCFrame())
                    task.wait(0.03333333333333333)
                end
            end)
        end
        v43.Humanoid.WalkSpeed = 16
        _G.keysetup:cooldown("Water Serpent", v45)
        _G.canuse = true
        _G.fw(v45)
        v42.ser = false
    end
end
function u4.WaterBomb(p48, p49) --[[ Line: 225 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local v50 = p48.Cooldowns
    local u51 = game.ReplicatedStorage["Stats" .. u1.Name]
    local u52 = u1.Character
    if v50.bomb == false and (_G.StamCheck("Water Bomb") == true and (_G.canuse == true and _G.check:inspect(u52) == true)) then
        local v53 = u2.GetM("Water Bomb")
        local v54 = v53.cd
        if v53.statreq and _G.MeetReq(v53.statreq) == false then
            return
        end
        v50.bomb = true
        _G.canuse = false
        local v55 = game.ReplicatedStorage.Events.Skill:InvokeServer("Water Bomb", {
            ["pos"] = p48:GetMouseCFrame()
        })
        local v56 = u52.Humanoid:LoadAnimation(script.ult)
        v56:Play()
        v56:AdjustSpeed(2)
        _G.FaceMouse = true
        _G.PauseAnim(v56, 0.55, 1)
        p48:ChargeSkill(p49, {
            ["Key"] = Enum.KeyCode.C,
            ["IgnoreInstantCastSetting"] = true,
            ["EndFunction"] = function() --[[ Name: EndFunction, Line 249 ]]
                --[[
                Upvalues:
                    [1] = u52
                    [2] = u51
                --]]
                return not u52:FindFirstChild("FishmanKarate") or (u51.Stamina.Value <= 0 and true or u52.Parent == workspace.Ragdolls)
            end
        })
        v56:AdjustSpeed(1)
        if v55 then
            v55:FireServer(p48:GetMouseCFrame())
        end
        u52.Humanoid.WalkSpeed = 16
        _G.FaceMouse = false
        u52.HumanoidRootPart.Anchored = true
        task.wait(0.2)
        u52.HumanoidRootPart.Anchored = false
        _G.keysetup:cooldown("Water Bomb", v54)
        _G.canuse = true
        _G.fw(v54)
        v50.bomb = false
    end
end
return u4