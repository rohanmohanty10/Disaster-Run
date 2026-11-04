 

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
        ["blows"] = false,
        ["wind"] = false,
        ["tackle"] = false,
        ["drill"] = false,
        ["bite"] = false,
        ["ult"] = false
    }
    return v7
end
function u4.ThunderousRoar(u8, p9) --[[ Line: 26 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local v10 = u8.Cooldowns
    local u11 = game.ReplicatedStorage["Stats" .. u1.Name]
    local u12 = u1.Character
    if v10.blows == false and (_G.StamCheck("Thunderous Roar") == true and (_G.canuse == true and _G.check:inspect(u12) == true)) then
        local v13 = u2.GetM("Thunderous Roar")
        local v14 = v13.cd
        if _G.StamCheck("Thunderous Roar") == false then
            return
        end
        if v13.statreq and _G.MeetReq(v13.statreq) == false then
            return
        end
        _G.canuse = false
        v10.blows = true
        local u15 = tick()
        _G.FaceMouse = true
        _G.mouseLevel = true
        local v16 = game.ReplicatedStorage.Events.Skill:InvokeServer("Thunderous Roar", {
            ["cf"] = u12.PrimaryPart.CFrame
        })
        u8:ChargeSkill(p9, {
            ["Key"] = Enum.KeyCode.E,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 49 ]] end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 53 ]]
                --[[
                Upvalues:
                    [1] = u8
                    [2] = u12
                    [3] = u15
                    [4] = u11
                --]]
                if u8.Tool.Parent ~= u12 or (tick() - u15 >= 10 or (u12.Parent == nil or (u12.Parent ~= workspace.PlayerCharacters or u11.Stamina.Value <= 0))) then
                    return true
                end
            end,
            ["HoldDuration"] = 0.5
        })
        u12.HumanoidRootPart.Anchored = true
        _G.FaceMouse = false
        _G.mouseLevel = false
        if v16 then
            v16:FireServer(u12.PrimaryPart.CFrame)
        end
        task.wait(0.9)
        u12.HumanoidRootPart.Anchored = false
        _G.canuse = true
        _G.keysetup:cooldown("Thunderous Roar", v14)
        _G.fw(v14)
        v10.blows = false
    end
end
function u4.ThunderousWhirlwind(p17, _) --[[ Line: 83 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local v18 = p17.Cooldowns
    local _ = game.ReplicatedStorage["Stats" .. u1.Name]
    local v19 = u1.Character
    if v18.wind == false and (_G.StamCheck("Thunderous Whirlwind") == true and (_G.canuse == true and _G.check:inspect(v19) == true)) then
        local v20 = u2.GetM("Thunderous Whirlwind")
        local v21 = v20.cd
        if _G.StamCheck("Thunderous Whirlwind") == false then
            return
        end
        if v20.statreq and _G.MeetReq(v20.statreq) == false then
            return
        end
        _G.canuse = false
        v18.wind = true
        game.ReplicatedStorage.Events.Skill:InvokeServer("Thunderous Whirlwind", {
            ["Start"] = v19.PrimaryPart.CFrame,
            ["Goal"] = p17:GetMouseCFrame()
        })
        task.wait(0.1)
        _G.canuse = true
        _G.keysetup:cooldown("Thunderous Whirlwind", v21)
        _G.fw(v21)
        v18.wind = false
    end
end
function u4.ThunderousTackle(u22, p23) --[[ Line: 109 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local v24 = u22.Cooldowns
    local u25 = game.ReplicatedStorage["Stats" .. u1.Name]
    local u26 = u1.Character
    if v24.tackle == false and (_G.StamCheck("Thunderous Tackle") == true and (_G.canuse == true and _G.check:inspect(u26) == true)) then
        local v27 = u2.GetM("Thunderous Tackle")
        local v28 = v27.cd
        if _G.StamCheck("Thunderous Tackle") == false then
            return
        end
        if v27.statreq and _G.MeetReq(v27.statreq) == false then
            return
        end
        v24.tackle = true
        local u29 = tick()
        _G.FaceMouse = true
        _G.canuse = false
        local v30 = u26.Humanoid:LoadAnimation(script.Tackle)
        v30:Play()
        v30:AdjustSpeed(0)
        local v31 = game.ReplicatedStorage.Events.Skill:InvokeServer("Thunderous Tackle", {
            ["cf"] = u26.PrimaryPart.CFrame
        })
        u22:ChargeSkill(p23, {
            ["Key"] = Enum.KeyCode.T,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 135 ]] end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 139 ]]
                --[[
                Upvalues:
                    [1] = u22
                    [2] = u26
                    [3] = u29
                    [4] = u25
                --]]
                if u22.Tool.Parent ~= u26 or (tick() - u29 >= 10 or (u26.Parent == nil or (u26.Parent ~= workspace.PlayerCharacters or u25.Stamina.Value <= 0))) then
                    return true
                end
            end
        })
        u26.HumanoidRootPart.Anchored = true
        _G.FaceMouse = false
        v30:AdjustSpeed(3)
        if v31 then
            v31:InvokeServer(u22:GetMouseCFrame())
        end
        task.wait(0.75)
        u26.HumanoidRootPart.Anchored = false
        _G.canuse = true
        _G.keysetup:cooldown("Thunderous Tackle", v28)
        _G.fw(v28)
        v24.tackle = false
    end
end
function u4.ThunderousDrill(p32, _) --[[ Line: 169 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local v33 = p32.Cooldowns
    local _ = game.ReplicatedStorage["Stats" .. u1.Name]
    local v34 = u1.Character
    if v33.drill == false and (_G.StamCheck("Thunderous Drill") == true and (_G.canuse == true and _G.check:inspect(v34) == true)) then
        local v35 = u2.GetM("Thunderous Drill")
        local v36 = v35.cd
        if _G.StamCheck("Thunderous Drill") == false then
            return
        end
        if v35.statreq and _G.MeetReq(v35.statreq) == false then
            return
        end
        _G.canuse = false
        v33.drill = true
        game.ReplicatedStorage.Events.Skill:InvokeServer("Thunderous Drill", {
            ["Start"] = v34.PrimaryPart.CFrame,
            ["Goal"] = p32:GetMouseCFrame()
        })
        _G.canuse = true
        _G.keysetup:cooldown("Thunderous Drill", v36)
        _G.fw(v36)
        v33.drill = false
    end
end
function u4.ThunderousBite(u37, p38) --[[ Line: 195 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local v39 = u37.Cooldowns
    local u40 = game.ReplicatedStorage["Stats" .. u1.Name]
    local u41 = u1.Character
    if v39.bite == false and (_G.StamCheck("Thunderous Bite") == true and (_G.canuse == true and _G.check:inspect(u41) == true)) then
        local v42 = u2.GetM("Thunderous Bite")
        local v43 = v42.cd
        if _G.StamCheck("Thunderous Bite") == false then
            return
        end
        if v42.statreq and _G.MeetReq(v42.statreq) == false then
            return
        end
        v39.bite = true
        local u44 = tick()
        _G.FaceMouse = true
        _G.mouseLevel = true
        _G.canuse = false
        local u45 = u41.Humanoid:LoadAnimation(script.dash)
        u45:Play()
        u45:AdjustSpeed(0)
        local v46 = game.ReplicatedStorage.Events.Skill:InvokeServer("Thunderous Bite", {
            ["cf"] = u41.PrimaryPart.CFrame
        })
        local v47, u48
        if v46 then
            v47, u48 = unpack(v46)
        else
            v47 = nil
            u48 = nil
        end
        _G.PauseAnim(u45, 0.2, 1.5)
        u37:ChargeSkill(p38, {
            ["Key"] = Enum.KeyCode.X,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 227 ]] end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 231 ]]
                --[[
                Upvalues:
                    [1] = u37
                    [2] = u41
                    [3] = u44
                    [4] = u40
                --]]
                if u37.Tool.Parent ~= u41 or (tick() - u44 >= 10 or (u41.Parent == nil or (u41.Parent ~= workspace.PlayerCharacters or u40.Stamina.Value <= 0))) then
                    return true
                end
            end
        })
        _G.FaceMouse = false
        _G.mouseLevel = false
        u41.PrimaryPart.Anchored = true
        u45:AdjustSpeed(1.5)
        u41.Humanoid.AutoRotate = false
        local v49 = u41.PrimaryPart.CFrame
        if v47 then
            v47:FireServer(v49, v49 * CFrame.new(0, 0, -100))
        end
        task.wait(0.13333333333333333)
        local u50 = Instance.new("LinearVelocity")
        u50.Attachment0 = u41.PrimaryPart.RootRigAttachment
        u50.MaxForce = 100000000000
        u50.VelocityConstraintMode = Enum.VelocityConstraintMode.Vector
        u50.VectorVelocity = v49.LookVector * 300
        u50.RelativeTo = Enum.ActuatorRelativeTo.World
        u50.Parent = u41
        local u51 = Instance.new("AlignOrientation")
        u51.Attachment0 = u41.PrimaryPart.RootRigAttachment
        u51.Mode = 0
        u51.CFrame = v49
        u51.Responsiveness = 100
        u51.MaxTorque = 100000000000
        u51.Parent = u41
        _G.tween(u50, { 0.25, "Linear", Enum.EasingDirection.Out }, {
            ["VectorVelocity"] = Vector3.new(0, 0, 0)
        })
        _G.destroy(u50, 0.5)
        _G.destroy(u51, 0.75)
        u41.PrimaryPart.Anchored = false
        u41.PrimaryPart.Velocity = Vector3.new()
        u41.Humanoid.AutoRotate = false
        local u52 = nil
        local function v62(p53) --[[ Line: 280 ]]
            --[[
            Upvalues:
                [1] = u48
                [2] = u41
                [3] = u50
                [4] = u51
                [5] = u45
                [6] = u52
            --]]
            if u48 then
                local v54 = u41.PrimaryPart.CFrame * CFrame.new(0, 0, -5)
                u50:Destroy()
                u51:Destroy()
                u41.PrimaryPart.Anchored = true
                u45:Stop()
                local v55 = u48
                local v56 = p53.Parent
                local v57 = CFrame.new
                local v58 = u41.PrimaryPart.Position
                local v59 = v54.X
                local v60 = u41.PrimaryPart.Position.Y
                local v61 = v54.Z
                v55:FireServer(v56, v57(v58, (Vector3.new(v59, v60, v61))))
                u52 = true
            end
        end
        _G.hitbox:start(u41, Vector3.new(8, 8, 8), 0.5, CFrame.new(0, 0, 0), v62)
        task.wait(0.5)
        if u41:FindFirstChild("GrabTag") == nil then
            u41.Humanoid.AutoRotate = true
        end
        _G.canuse = true
        _G.keysetup:cooldown("Thunderous Bite", v43)
        _G.fw(v43)
        v39.bite = false
    end
end
function u4.ThunderousBlitz(u63, p64) --[[ Line: 307 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local v65 = u63.Cooldowns
    local u66 = game.ReplicatedStorage["Stats" .. u1.Name]
    local u67 = u1.Character
    if v65.ult == false and (_G.StamCheck("Thunderous Blitz") == true and (_G.canuse == true and _G.check:inspect(u67) == true)) then
        local v68 = u2.GetM("Thunderous Blitz")
        local v69 = v68.cd
        if _G.StamCheck("Thunderous Blitz") == false then
            return
        end
        if v68.statreq and _G.MeetReq(v68.statreq) == false then
            return
        end
        _G.canuse = false
        v65.ult = true
        local v70 = u67.Humanoid:LoadAnimation(script.ultWindup)
        v70:Play()
        u67.Humanoid.WalkSpeed = 4
        local u71 = tick()
        _G.PauseAnim(v70, 0.4, 1.5)
        u63:ChargeSkill(p64, {
            ["Key"] = Enum.KeyCode.C,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 338 ]]
                --[[
                Upvalues:
                    [1] = u67
                --]]
                u67.Humanoid.WalkSpeed = 4
            end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 342 ]]
                --[[
                Upvalues:
                    [1] = u63
                    [2] = u67
                    [3] = u71
                    [4] = u66
                --]]
                if u63.Tool.Parent ~= u67 or (tick() - u71 >= 10 or (u67.Parent == nil or (u67.Parent ~= workspace.PlayerCharacters or u66.Stamina.Value <= 0))) then
                    return true
                end
            end
        })
        v70:Stop()
        local v72 = u67.Humanoid:LoadAnimation(script.dash)
        v72:Play(0)
        v72:AdjustWeight(5)
        v72:AdjustSpeed(4)
        local v73 = Ray.new(u67.HumanoidRootPart.Position, u67.PrimaryPart.CFrame.LookVector * 15)
        local _, v74 = _G.raycastWhitelist(v73, { workspace.Islands, workspace.Ships, workspace.Env })
        local v75 = (u67.HumanoidRootPart.Position - v74).Magnitude
        local v76 = u67.PrimaryPart.CFrame
        u67.PrimaryPart.Anchored = true
        u67:SetPrimaryPartCFrame(u67.PrimaryPart.CFrame * CFrame.new(0, 0, -v75))
        game.ReplicatedStorage.Events.Skill:InvokeServer("Thunderous Blitz", { v76, u67.PrimaryPart.CFrame })
        u67.Humanoid.AutoRotate = false
        task.wait(0.3)
        u67.Humanoid.WalkSpeed = 16
        u67.Humanoid.AutoRotate = true
        u67.PrimaryPart.Anchored = false
        _G.canuse = true
        _G.keysetup:cooldown("Thunderous Blitz", v69)
        _G.fw(v69)
        v65.ult = false
    end
end
return u4