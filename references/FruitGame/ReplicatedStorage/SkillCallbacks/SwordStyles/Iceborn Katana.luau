 

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
        ["slash"] = false,
        ["triple"] = false
    }
    return v9
end
function u6.FrostFlash(p10, p11) --[[ Line: 28 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v12 = p10.Cooldowns
    local u13 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v12.slash == false and _G.check:inspect(u13) == true then
        local v14 = u3.GetM("Frost Flash")
        local v15 = v14.cd
        if _G.StamCheck("Frost Flash") == false then
            return
        end
        if v14.statreq and _G.MeetReq(v14.statreq) == false then
            return
        end
        local v16 = u13.Humanoid.Animator:LoadAnimation(script.slash)
        v16:Play()
        v16:AdjustWeight(2)
        v12.slash = true
        _G.FaceMouse = true
        _G.canuse = false
        u13:SetPrimaryPartCFrame(CFrame.new(u13.PrimaryPart.Position, p10:GetMouseCFrame().Position))
        _G.PauseAnim(v16, 0.15, 0.3)
        local v17 = game.ReplicatedStorage.Events.Skill:InvokeServer("Frost Flash", u13.PrimaryPart.CFrame)
        local u18 = tick()
        p10:ChargeSkill(p11, {
            ["Key"] = Enum.KeyCode.E,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 55 ]]
                --[[
                Upvalues:
                    [1] = u13
                --]]
                u13.Humanoid.AutoRotate = false
            end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 60 ]]
                --[[
                Upvalues:
                    [1] = u13
                    [2] = u18
                --]]
                if u13:FindFirstChild(script.Name) == nil or tick() - u18 >= 10 then
                    return true
                end
            end
        })
        v16:AdjustSpeed(1)
        if v17 then
            v17:FireServer("slash")
        end
        _G.FaceMouse = false
        u13.HumanoidRootPart.Anchored = true
        u13.Humanoid.AutoRotate = false
        task.wait(0.15)
        if v17 then
            v17:FireServer(u13.PrimaryPart.CFrame)
        end
        task.wait(0.5)
        if u13:GetAttribute("frostSlashHit") ~= nil then
            repeat
                task.wait()
            until u13:GetAttribute("frostSlashHit") == nil
        end
        u13.Humanoid.AutoRotate = true
        u13.HumanoidRootPart.Anchored = false
        u13.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Frost Flash", v15)
        _G.fw(v15)
        v12.slash = false
    end
end
function u6.FrostfallCascade(p19, p20) --[[ Line: 104 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v21 = p19.Cooldowns
    local u22 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v21.triple == false and _G.check:inspect(u22) == true then
        local v23 = u3.GetM("Frostfall Cascade")
        local v24 = v23.cd
        if _G.StamCheck("Frostfall Cascade") == false then
            return
        end
        if v23.statreq and _G.MeetReq(v23.statreq) == false then
            return
        end
        local v25 = u22.Humanoid.Animator:LoadAnimation(script.triple)
        v25:Play()
        v25:AdjustWeight(5)
        v21.triple = true
        _G.FaceMouse = true
        _G.canuse = false
        u22:SetPrimaryPartCFrame(CFrame.new(u22.PrimaryPart.Position, p19:GetMouseCFrame().Position))
        local v26 = game.ReplicatedStorage.Events.Skill:InvokeServer("Frostfall Cascade", u22.PrimaryPart.CFrame)
        _G.PauseAnim(v25, 0.15, 0.5)
        local u27 = tick()
        local u28 = false
        local function v30() --[[ Line: 138 ]]
            --[[
            Upvalues:
                [1] = u22
                [2] = u27
                [3] = u28
            --]]
            if u22:FindFirstChild(script.Name) == nil or tick() - u27 >= 2 then
                return true
            end
            if tick() - u27 >= 1.5 and u28 == false then
                u28 = true
                local v29 = Instance.new("Highlight")
                v29.FillColor = Color3.fromRGB(255, 255, 255)
                v29.FillTransparency = 0
                v29.OutlineTransparency = 1
                v29.Parent = u22
                _G.tween(v29, { 0.5, "Cubic", Enum.EasingDirection.Out }, {
                    ["FillTransparency"] = 1
                })
                _G.destroy(v29, 0.5)
                script.IceKatanaChargeFull:Play()
            end
        end
        p19:ChargeSkill(p20, {
            ["Key"] = Enum.KeyCode.R,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 133 ]]
                --[[
                Upvalues:
                    [1] = u22
                --]]
                u22.Humanoid.AutoRotate = false
            end,
            ["IgnoreInstantCastSetting"] = true,
            ["EndFunction"] = v30
        })
        v25:AdjustSpeed(1)
        if v26 then
            v26:FireServer("slash")
        end
        _G.FaceMouse = false
        u22.HumanoidRootPart.Anchored = true
        u22.Humanoid.AutoRotate = false
        task.wait(0.1)
        if v26 then
            v26:FireServer(u22.PrimaryPart.CFrame, u28)
        end
        task.wait(0.65)
        u22.Humanoid.AutoRotate = true
        u22.HumanoidRootPart.Anchored = false
        u22.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Frostfall Cascade", v24)
        _G.fw(v24)
        v21.triple = false
    end
end
return u6