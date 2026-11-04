 

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
        ["wisp"] = false,
        ["fearGrab"] = false,
        ["headThrow"] = false,
        ["res"] = false,
        ["ult"] = false
    }
    return v7
end
u4["WillO\'Wisp"] = function(p8, _) --[[ Line: 25 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local v9 = p8.Cooldowns
    local _ = game.ReplicatedStorage["Stats" .. u1.Name]
    local v10 = u1.Character
    if v9.wisp == false and (_G.check:inspect(v10) == true and _G.StamCheck("Will O\' Wisp") == true) then
        local v11 = u2.GetM("Will O\' Wisp")
        local v12 = v11.cd
        if _G.StamCheck("Will O\' Wisp") == false then
            return
        end
        if v11.statreq and _G.MeetReq(v11.statreq) == false then
            return
        end
        v9.wisp = true
        _G.canuse = false
        local v13 = _G.getTargetNearMouse()
        if v13 == nil then
            v13 = p8:GetMouseCFrame()
        end
        v10.PrimaryPart.Anchored = true
        local v14
        if typeof(v13) == "Instance" then
            v14 = v13.CFrame
        else
            v14 = v13
        end
        v10:SetPrimaryPartCFrame(CFrame.new(v10.PrimaryPart.Position, v14.Position))
        local v15 = v10.Humanoid:LoadAnimation(script.wisp)
        v15:Play(0)
        v15:AdjustWeight(2)
        v15:AdjustSpeed(2.25)
        game.ReplicatedStorage.Events.Skill:InvokeServer("Will O\' Wisp", { v13, v10.RightHand.CFrame })
        task.wait(0.25)
        v10.PrimaryPart.Anchored = false
        v10.Humanoid.WalkSpeed = 16
        _G.mouseLevel = false
        _G.keysetup:cooldown("Will O\' Wisp", v12)
        _G.canuse = true
        _G.fw(v12)
        v9.wisp = false
    end
end
function u4.FearInducement(p16, _) --[[ Line: 74 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local v17 = p16.Cooldowns
    local _ = game.ReplicatedStorage["Stats" .. u1.Name]
    local u18 = u1.Character
    if v17.fearGrab == false and (_G.check:inspect(u18) == true and _G.StamCheck("Fear Inducement") == true) then
        local v19 = u2.GetM("Fear Inducement")
        local v20 = v19.cd
        if _G.StamCheck("Fear Inducement") == false then
            return
        end
        if v19.statreq and _G.MeetReq(v19.statreq) == false then
            return
        end
        v17.fearGrab = true
        _G.canuse = false
        local v21 = u18.Humanoid:LoadAnimation(script.grab)
        v21:Play(0)
        v21:AdjustWeight(2)
        u18.Humanoid.WalkSpeed = 4
        v21:AdjustSpeed(1.25)
        local u22 = game.ReplicatedStorage.Events.Skill:InvokeServer("Fear Inducement", {
            ["cf"] = u18.HumanoidRootPart.CFrame
        })
        tick()
        task.wait(0.2)
        local u23 = Instance.new("BodyVelocity", u18.HumanoidRootPart)
        u23.MaxForce = Vector3.new(1000000, 1000000, 1000000)
        u23.Velocity = u18.HumanoidRootPart.CFrame.LookVector * 75
        _G.destroy(u23, 0.1)
        if u22 then
            u22:FireServer()
        end
        _G.hitbox:start(u18, Vector3.new(6, 6, 6), 0.35, CFrame.new(0, 0, -2), function(p24) --[[ Name: hitfound, Line 111 ]]
            --[[
            Upvalues:
                [1] = u23
                [2] = u22
                [3] = u18
            --]]
            u23:Destroy()
            u23 = nil
            if u22 then
                u22:FireServer(p24.Parent, u18.HumanoidRootPart.CFrame)
            end
        end, nil)
        u18.Humanoid.WalkSpeed = 16
        task.wait(0.4)
        _G.canuse = true
        _G.keysetup:cooldown("Fear Inducement", v20)
        _G.fw(v20)
        v17.fearGrab = false
    end
end
function u4.HeadThrow(p25, _) --[[ Line: 128 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local v26 = p25.Cooldowns
    local _ = game.ReplicatedStorage["Stats" .. u1.Name]
    local v27 = u1.Character
    if v26.headThrow == false and (_G.check:inspect(v27) == true and _G.StamCheck("Head Throw") == true) then
        local v28 = u2.GetM("Head Throw")
        local v29 = v28.cd
        if _G.StamCheck("Head Throw") == false then
            return
        end
        if v28.statreq and _G.MeetReq(v28.statreq) == false then
            return
        end
        v26.headThrow = true
        _G.canuse = false
        local v30 = v27.Humanoid:LoadAnimation(script.head)
        v30:Play(0)
        v30:AdjustWeight(2)
        task.wait(0.1)
        game.ReplicatedStorage.Events.Skill:InvokeServer("Head Throw", {
            ["start"] = v27.PrimaryPart.CFrame,
            ["target"] = p25:GetMouseCFrame()
        })
        v27.Humanoid.WalkSpeed = 16
        _G.mouseLevel = false
        _G.keysetup:cooldown("Head Throw", v29)
        _G.canuse = true
        _G.fw(v29)
        v26.headThrow = false
    end
end
function u4.Resurrection(p31, _) --[[ Line: 163 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local v32 = p31.Cooldowns
    local _ = game.ReplicatedStorage["Stats" .. u1.Name]
    local v33 = u1.Character
    if v32.res == false and (_G.check:inspect(v33) == true and _G.StamCheck("Resurrection") == true) then
        local v34 = u2.GetM("Resurrection")
        local v35 = v34.cd
        if _G.StamCheck("Resurrection") == false then
            return
        end
        if v34.statreq and _G.MeetReq(v34.statreq) == false then
            return
        end
        local v36, _, _ = _G.getRayFloor(v33.PrimaryPart.CFrame, 5)
        if v36 == nil then
            _G.displayMessage("<Color=Red>I have to touch the ground")
            return nil
        end
        v32.res = true
        _G.canuse = false
        v33.Humanoid.WalkSpeed = 0
        local v37 = v33.Humanoid:LoadAnimation(script.res)
        v37:Play(0)
        v37:AdjustWeight(2)
        game.ReplicatedStorage.Events.Skill:InvokeServer("Resurrection", {
            ["start"] = v33.PrimaryPart.CFrame,
            ["target"] = p31:GetMouseCFrame()
        })
        task.wait(0.4)
        v33.Humanoid.WalkSpeed = 16
        _G.mouseLevel = false
        _G.keysetup:cooldown("Resurrection", v35)
        _G.canuse = true
        _G.fw(v35)
        v32.res = false
    end
end
function u4.OnslaughtofShadows(p38, _) --[[ Line: 203 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local v39 = p38.Cooldowns
    local _ = game.ReplicatedStorage["Stats" .. u1.Name]
    local v40 = u1.Character
    if v39.ult == false and (_G.check:inspect(v40) == true and _G.StamCheck("Onslaught of Shadows") == true) then
        local v41 = u2.GetM("Onslaught of Shadows")
        local v42 = v41.cd
        if _G.StamCheck("Onslaught of Shadows") == false then
            return
        end
        if v41.statreq and _G.MeetReq(v41.statreq) == false then
            return
        end
        v39.ult = true
        _G.canuse = false
        v40.Humanoid.AutoRotate = false
        local v43 = v40.Humanoid:LoadAnimation(script.ult)
        v43:Play(0)
        v43:AdjustWeight(2)
        v43:AdjustSpeed(1.75)
        game.ReplicatedStorage.Events.Skill:InvokeServer("Onslaught of Shadows", {
            ["start"] = v40.PrimaryPart.CFrame,
            ["target"] = p38:GetMouseCFrame()
        })
        _G.keysetup:cooldown("Onslaught of Shadows", v42)
        _G.canuse = true
        v40.Humanoid.AutoRotate = true
        _G.fw(v42)
        v39.ult = false
    end
end
return u4