 

local u1 = game.Players.LocalPlayer
game:GetService("RunService")
local u2 = game:GetService("ReplicatedStorage")
local u3 = require(game.ReplicatedStorage.Modules.Skills)
local u4 = require(script.Parent.Parent.MobileBase)
require(u1.PlayerScripts:WaitForChild("PlayerModule"))
game:GetService("UserInputService")
u1:GetMouse()
local u5 = setmetatable({}, u4)
u5.__index = u5
function u5.new(_) --[[ Line: 21 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u5
    --]]
    local v6 = u4.new(script.Name)
    local v7 = u5
    local v8 = setmetatable(v6, v7)
    v8.Cooldowns = {
        ["rocket"] = false,
        ["WhiteOut"] = false,
        ["barrage"] = false,
        ["snake"] = false,
        ["WhiteFog"] = false,
        ["Judgement"] = false
    }
    return v8
end
function u5.WhiteRocket(u9, p10) --[[ Line: 28 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v11 = u9.Cooldowns
    local u12 = u1.Character
    local u13 = u2["Stats" .. u1.Name]
    if v11.rocket == false and (_G.check:inspect(u12) == true and _G.StamCheck("White Rocket") == true) then
        local v14 = u3.GetM("White Rocket")
        local v15 = v14.cd
        if _G.StamCheck("White Rocket") == false then
            return
        end
        if v14.statreq and _G.MeetReq(v14.statreq) == false then
            return
        end
        _G.canuse = false
        v11.rocket = true
        local v16 = game.ReplicatedStorage.Events.Skill:InvokeServer("White Rocket")
        local u17 = Instance.new("BodyVelocity", u12.LowerTorso)
        u17.MaxForce = Vector3.new(inf, inf, inf)
        u17.Name = "geppo"
        u17.Velocity = Vector3.new()
        local u18 = Instance.new("BodyGyro", u12.PrimaryPart)
        u18.MaxTorque = Vector3.new(100000000000, 100000000000, 100000000000)
        u18.P = 40000000
        u18.D = 10000
        local u19 = tick()
        local u20 = RaycastParams.new()
        u20.FilterType = Enum.RaycastFilterType.Include
        u20.FilterDescendantsInstances = _G.getTargetsWithENV(u12)
        u12:SetPrimaryPartCFrame(CFrame.new(u12.PrimaryPart.Position, u9:GetMouseCFrame().Position))
        u9:ChargeSkill(p10, {
            ["Key"] = Enum.KeyCode.Z,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 67 ]]
                --[[
                Upvalues:
                    [1] = u12
                    [2] = u9
                    [3] = u17
                    [4] = u18
                    [5] = u20
                    [6] = u19
                    [7] = u13
                --]]
                local v21 = u12.Humanoid.Health / u12.Humanoid.MaxHealth
                local v22 = u9:GetMouseCFrame().Position
                local v23 = u12:FindFirstChild("inCombat") == nil and 110 or 90
                u17.Velocity = (u12.HumanoidRootPart.Position - v22).Unit * -(v23 * v21)
                u18.CFrame = CFrame.new(u12.PrimaryPart.Position, v22)
                local v24 = CFrame.new(u12.PrimaryPart.Position, v22) * CFrame.new(0, 0, 2)
                local v25 = workspace:Blockcast(v24, Vector3.new(4, 4, 4), CFrame.new(u12.PrimaryPart.Position, v22).LookVector * 2, u20)
                if v25 and v25.Instance then
                    return true
                end
                if _G.check:inspect(u12) == false then
                    return true
                end
                if tick() - u19 >= 4 or (u9.Tool.Parent ~= u12 or (u12.Parent == nil or (u12.Parent ~= workspace.PlayerCharacters or u13.Stamina.Value <= 0))) then
                    return true
                end
            end
        })
        u17:Destroy()
        u18:Destroy()
        if v16 then
            v16:FireServer(u12.HumanoidRootPart.CFrame)
        end
        _G.canuse = true
        _G.keysetup:cooldown("White Rocket", v15)
        _G.fw(v15)
        v11.rocket = false
    end
end
function u5.WhiteOut(p26, _) --[[ Line: 111 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v27 = p26.Cooldowns
    local v28 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v27.WhiteOut == false and (_G.check:inspect(v28) == true and _G.StamCheck("White Out") == true) then
        local v29 = u3.GetM("White Out")
        local v30 = v29.cd
        if _G.StamCheck("White Out") == false then
            return
        end
        if v29.statreq and _G.MeetReq(v29.statreq) == false then
            return
        end
        _G.canuse = false
        v27.WhiteOut = true
        v28.PrimaryPart.Anchored = true
        game.ReplicatedStorage.Events.Skill:InvokeServer("White Out", v28.PrimaryPart.CFrame)
        v28.PrimaryPart.Anchored = false
        _G.canuse = true
        _G.keysetup:cooldown("White Out", v30)
        _G.fw(v30)
        v27.WhiteOut = false
    end
end
function u5.WhiteBarrage(u31, p32) --[[ Line: 141 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v33 = u31.Cooldowns
    local u34 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v33.barrage == false and (_G.check:inspect(u34) == true and _G.StamCheck("White Barrage") == true) then
        local v35 = u3.GetM("White Barrage")
        local v36 = v35.cd
        if _G.StamCheck("White Barrage") == false then
            return
        end
        if v35.statreq and _G.MeetReq(v35.statreq) == false then
            return
        end
        v33.barrage = true
        _G.canuse = false
        _G.FaceMouse = true
        local v37 = u34.Humanoid:LoadAnimation(script.barrageWind)
        v37:Play()
        v37:AdjustSpeed(1.3)
        local u38 = tick()
        u34:SetPrimaryPartCFrame(CFrame.new(u34.PrimaryPart.Position, u31:GetMouseCFrame().Position))
        local u39 = game.ReplicatedStorage.Events.Skill:InvokeServer("White Barrage", u34.PrimaryPart.CFrame)
        local v40 = u34.Humanoid:LoadAnimation(script.barrageLoop)
        v40:Play()
        u31:ChargeSkill(p32, {
            ["Key"] = Enum.KeyCode.E,
            ["EndFunction"] = function() --[[ Name: EndFunction, Line 178 ]]
                --[[
                Upvalues:
                    [1] = u31
                    [2] = u34
                    [3] = u38
                    [4] = u39
                --]]
                return u31.Tool.Parent ~= u34 or (tick() - u38 >= 3 or not u39) or _G.check:inspect(u34) == false
            end,
            ["IgnoreInstantCastSetting"] = true
        })
        v40:Stop()
        if u39 then
            u39:FireServer()
        end
        _G.canuse = true
        _G.FaceMouse = false
        _G.keysetup:cooldown("White Barrage", v36)
        _G.fw(v36)
        v33.barrage = false
    end
end
function u5.WhiteSnake(p41, _) --[[ Line: 199 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v42 = p41.Cooldowns
    local v43 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v42.snake == false and _G.check:inspect(v43) == true then
        local v44 = u3.GetM("White Snake")
        local v45 = v44.cd
        if _G.StamCheck("White Snake") == false then
            return
        end
        if v44.statreq and _G.MeetReq(v44.statreq) == false then
            return
        end
        local v46 = _G.getTargetNearMouse(300)
        if v46 == nil then
            _G.displayMessage("<Color=Red>No targets")
            return
        end
        v42.snake = true
        _G.canuse = false
        v43.Humanoid.AutoRotate = false
        v43.PrimaryPart.Anchored = true
        v43:SetPrimaryPartCFrame(CFrame.new(v43.PrimaryPart.Position, v46.Position))
        game.ReplicatedStorage.Events.Skill:InvokeServer("White Snake", {
            ["target"] = v46,
            ["startCFrame"] = v43.PrimaryPart.CFrame
        })
        v43.PrimaryPart.Anchored = false
        v43.Humanoid.AutoRotate = true
        _G.canuse = true
        _G.keysetup:cooldown("White Snake", v45)
        _G.fw(v45)
        v42.snake = false
    end
end
function u5.WhiteFog(p47, _) --[[ Line: 242 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v48 = p47.Cooldowns
    local v49 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v48.WhiteFog == false and (_G.check:inspect(v49) == true and _G.StamCheck("White Fog") == true) then
        local v50 = u3.GetM("White Fog")
        local v51 = v50.cd
        if _G.StamCheck("White Fog") == false then
            return
        end
        if v50.statreq and _G.MeetReq(v50.statreq) == false then
            return
        end
        _G.canuse = false
        v48.WhiteFog = true
        game.ReplicatedStorage.Events.Skill:InvokeServer("White Fog", v49.PrimaryPart.CFrame)
        _G.canuse = true
        _G.keysetup:cooldown("White Fog", v51)
        _G.fw(v51)
        v48.WhiteFog = false
    end
end
return u5