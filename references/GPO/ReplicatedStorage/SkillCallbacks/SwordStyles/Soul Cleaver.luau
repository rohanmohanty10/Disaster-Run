 

local u1 = game.Players.LocalPlayer
local u2 = game:GetService("RunService")
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
        [3] = u1
        [4] = u2
    --]]
    local v6 = u4.new(script.Name)
    local v7 = u5
    local u8 = setmetatable(v6, v7)
    u8.Cooldowns = {
        ["Hakai Slash"] = false,
        ["Hahaba"] = false,
        ["Maser Ray"] = false,
        ["Blaze Eruption"] = false
    }
    local u9 = u1.Character
    u8.ForceEquip = false
    function u8.PlayAnim(_, p10, _) --[[ Line: 32 ]]
        --[[
        Upvalues:
            [1] = u9
        --]]
        local v11 = u9.Humanoid:LoadAnimation(p10)
        local v12 = u9:FindFirstChild("SoulCleaverAnimationController", true)
        if v12 ~= nil then
            v12:LoadAnimation(p10)
        end
        v11:Play()
        return v11
    end
    local u13 = u9.Humanoid
    u8.ToolForceEquip = u2.Heartbeat:Connect(function() --[[ Line: 76 ]]
        --[[
        Upvalues:
            [1] = u8
            [2] = u9
            [3] = u13
        --]]
        local u14 = u8.ForceEquip == true and u8.Tool
        if u14 then
            local v15 = u9:FindFirstChildWhichIsA("Tool")
            if v15 and v15 ~= u14 then
                task.defer(function() --[[ Line: 83 ]]
                    --[[
                    Upvalues:
                        [1] = u13
                    --]]
                    u13:UnequipTools()
                end)
            end
            if u14.Parent ~= u9 then
                task.defer(function() --[[ Line: 89 ]]
                    --[[
                    Upvalues:
                        [1] = u13
                        [2] = u14
                    --]]
                    u13:EquipTool(u14)
                end)
            end
        end
    end)
    return u8
end
function u5.HakaiSlash(u16, p17) --[[ Line: 99 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u3
    --]]
    local v18 = u16.Cooldowns
    local u19 = u1.Character
    if v18["Hakai Slash"] == false and _G.check:inspect(u19) == true then
        local v20 = u3.GetM("Hakai Slash")
        local v21 = v20.cd
        if _G.StamCheck("Hakai Slash") == false then
            return
        end
        if v20.statreq and _G.MeetReq(v20.statreq) == false then
            return
        end
        v18["Hakai Slash"] = true
        _G.canuse = false
        _G.FaceMouse = true
        u16.ForceEquip = true
        local v22 = tick()
        local v23 = game.ReplicatedStorage.Events.Skill:InvokeServer("Hakai Slash")
        local u24 = tick() - v22
        local v25 = u16:PlayAnim(script.HakaiSlash.Start)
        v25:Play()
        local u26 = tick()
        local v27 = u19.Humanoid
        local u28 = false
        local u29 = v25
        local u30 = false
        u16:ChargeSkill(p17, {
            ["Key"] = Enum.KeyCode.Z,
            ["CheckFunction"] = function() --[[ Name: CheckFunction, Line 139 ]]
                --[[
                Upvalues:
                    [1] = u26
                    [2] = u24
                    [3] = u30
                    [4] = u29
                    [5] = u16
                --]]
                if tick() - u26 >= 1 - u24 and u30 == false then
                    u29:Stop()
                    u29 = u16:PlayAnim(script.HakaiSlash.Hold)
                    u29:Play()
                    u30 = true
                end
            end,
            ["IgnoreInstantCastSetting"] = true,
            ["EndFunction"] = function() --[[ Name: EndFunction, Line 150 ]]
                --[[
                Upvalues:
                    [1] = u19
                    [2] = u28
                    [3] = u16
                    [4] = u26
                --]]
                if _G.check:inspect(u19) ~= false then
                    return u16.Tool.Parent ~= u19 and true or tick() - u26 >= 3
                end
                u28 = true
                return true
            end,
            ["HoldDuration"] = 0.4
        })
        u29:Stop()
        u19.PrimaryPart.Anchored = true
        _G.FaceMouse = false
        u16:PlayAnim(script.HakaiSlash.Success):Play()
        if v23 then
            v23:InvokeServer(u19.PrimaryPart.CFrame, u28)
        end
        v27.AutoRotate = false
        u19.PrimaryPart.Anchored = false
        task.wait(0.1)
        v27.WalkSpeed = 16
        v27.JumpPower = 50
        v27.AutoRotate = true
        u16.ForceEquip = false
        _G.canuse = true
        _G.keysetup:cooldown("Hakai Slash", v21)
        _G.fw(v21)
        v18["Hakai Slash"] = false
    end
end
function u5.Hahaba(u31, p32) --[[ Line: 191 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u3
    --]]
    local v33 = u31.Cooldowns
    local u34 = u1.Character
    if v33.Hahaba == false and _G.check:inspect(u34) == true then
        local v35 = u3.GetM("Hahaba")
        local v36 = v35.cd
        if _G.StamCheck("Hahaba") == false then
            return
        end
        if v35.statreq and _G.MeetReq(v35.statreq) == false then
            return
        end
        v33.Hahaba = true
        _G.canuse = false
        local u37 = u34.Humanoid
        u37.WalkSpeed = 4
        local u38 = game.ReplicatedStorage.Events.Skill:InvokeServer("Hahaba")
        local v39 = u31:PlayAnim(script.Hahaba.HoldNew)
        v39:Play()
        task.wait(0.3)
        local u40 = tick()
        local u41 = false
        u31:ChargeSkill(p32, {
            ["Key"] = Enum.KeyCode.R,
            ["CheckFunction"] = function() --[[ Name: CheckFunction, Line 226 ]]
                --[[
                Upvalues:
                    [1] = u37
                --]]
                u37.WalkSpeed = 4
            end,
            ["IgnoreInstantCastSetting"] = true,
            ["EndFunction"] = function() --[[ Name: EndFunction, Line 231 ]]
                --[[
                Upvalues:
                    [1] = u34
                    [2] = u41
                    [3] = u38
                    [4] = u31
                    [5] = u40
                --]]
                if _G.check:inspect(u34) ~= false then
                    return u38 == nil and true or (u31.Tool.Parent ~= u34 and true or tick() - u40 >= 3.75)
                end
                u41 = true
                return true
            end
        })
        v39:Stop()
        if u38 then
            local v42 = u31:PlayAnim(script.Hahaba.Success)
            v42:Play()
            v42:AdjustWeight(2)
            u37.AutoRotate = false
            u38:InvokeServer(u34.PrimaryPart.CFrame, u41)
        end
        task.wait(0.5)
        u37.AutoRotate = true
        u37.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Hahaba", v36)
        _G.fw(v36)
        v33.Hahaba = false
    end
end
function u5.MaserRay(u43, p44) --[[ Line: 267 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u3
    --]]
    local v45 = u43.Cooldowns
    local u46 = u1.Character
    if v45["Maser Ray"] == false and _G.check:inspect(u46) == true then
        local v47 = u3.GetM("Maser Ray")
        local v48 = v47.cd
        if _G.StamCheck("Maser Ray") == false then
            return
        end
        if v47.statreq and _G.MeetReq(v47.statreq) == false then
            return
        end
        v45["Maser Ray"] = true
        _G.canuse = false
        _G.FaceMouse = true
        local u49 = game.ReplicatedStorage.Events.Skill:InvokeServer("Maser Ray", u43:GetMouseCFrame().Position)
        local v50 = u43:PlayAnim(script.MaserRay.Start)
        v50:Play()
        v50:AdjustSpeed(1)
        task.wait(0.4)
        v50:Stop()
        local v51 = u43:PlayAnim(script.MaserRay.Hold)
        v51:Play()
        local u52 = tick()
        local v53 = u46.Humanoid
        u43:ChargeSkill(p44, {
            ["Key"] = Enum.KeyCode.E,
            ["CheckFunction"] = function() --[[ Name: CheckFunction, Line 305 ]] end,
            ["IgnoreInstantCastSetting"] = true,
            ["EndFunction"] = function() --[[ Name: EndFunction, Line 309 ]]
                --[[
                Upvalues:
                    [1] = u46
                    [2] = u49
                    [3] = u43
                    [4] = u52
                --]]
                if _G.check:inspect(u46) == false then
                    return true
                end
                if u49 then
                    u49:FireServer((u46.PrimaryPart.CFrame * CFrame.new(0, 0, -1000)).Position)
                end
                return u43.Tool.Parent ~= u46 and true or tick() - u52 >= 3
            end,
            ["HoldDuration"] = 0.5
        })
        v51:Stop()
        u46.PrimaryPart.Anchored = true
        _G.FaceMouse = false
        u43:PlayAnim(script.MaserRay.Success):Play()
        if u49 then
            u49:FireServer("release", (u46.PrimaryPart.CFrame * CFrame.new(0, 0, -1000)).Position)
        end
        task.wait(0.75)
        v53.AutoRotate = true
        u46.PrimaryPart.Anchored = false
        _G.canuse = true
        _G.keysetup:cooldown("Maser Ray", v48)
        _G.fw(v48)
        v45["Maser Ray"] = false
    end
end
function u5.BlazeEruption(u54, p55) --[[ Line: 346 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u3
    --]]
    local v56 = u54.Cooldowns
    local u57 = u1.Character
    if v56["Blaze Eruption"] == false and _G.check:inspect(u57) == true then
        local v58 = u3.GetM("Blaze Eruption")
        local v59 = v58.cd
        if _G.StamCheck("Blaze Eruption") == false then
            return
        end
        if v58.statreq and _G.MeetReq(v58.statreq) == false then
            return
        end
        v56["Blaze Eruption"] = true
        _G.canuse = false
        _G.FaceMouse = true
        _G.mouseLevel = true
        u54.ForceEquip = true
        local v60 = game.ReplicatedStorage.Events.Skill:InvokeServer("Blaze Eruption", u54:GetMouseCFrame().Position)
        local v61 = u54:PlayAnim(script.Pillar.Start)
        v61:Play()
        v61:AdjustSpeed(1)
        task.wait(0.5)
        v61:Stop()
        local v62 = u54:PlayAnim(script.Pillar.Hold)
        v62:Play()
        local u63 = tick()
        local v64 = u57.Humanoid
        u54:ChargeSkill(p55, {
            ["Key"] = Enum.KeyCode.X,
            ["CheckFunction"] = function() --[[ Name: CheckFunction, Line 388 ]] end,
            ["EndFunction"] = function() --[[ Name: EndFunction, Line 391 ]]
                --[[
                Upvalues:
                    [1] = u57
                    [2] = u54
                    [3] = u63
                --]]
                return _G.check:inspect(u57) == false and true or (u54.Tool.Parent ~= u57 and true or tick() - u63 >= 3)
            end
        })
        v62:Stop(0)
        u57.PrimaryPart.Anchored = true
        _G.FaceMouse = false
        _G.mouseLevel = false
        u54:PlayAnim(script.Pillar.Success):Play()
        if v60 then
            v60:InvokeServer(u57.PrimaryPart.CFrame)
        end
        task.wait(0.5)
        v64.AutoRotate = true
        u57.PrimaryPart.Anchored = false
        u54.ForceEquip = false
        _G.canuse = true
        _G.keysetup:cooldown("Blaze Eruption", v59)
        _G.fw(v59)
        v56["Blaze Eruption"] = false
    end
end
return u5