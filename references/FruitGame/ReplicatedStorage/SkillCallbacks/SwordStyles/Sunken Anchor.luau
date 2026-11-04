 

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
        ["reel"] = false,
        ["depths"] = false
    }
    return v9
end
function u6.SunkenDepths(p10, _) --[[ Line: 28 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v11 = p10.Cooldowns
    local v12 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v11.depths == false and _G.check:inspect(v12) == true then
        local v13 = u3.GetM("Sunken Depths")
        local v14 = v13.cd
        if v12.Humanoid.FloorMaterial == Enum.Material.Air then
            _G.displayMessage("<Color=Red>I need to be on the ground")
            return
        end
        if _G.StamCheck("Sunken Depths") == false then
            return
        end
        if v13.statreq and _G.MeetReq(v13.statreq) == false then
            return
        end
        local v15 = _G.getTargetNearMouse(300)
        if v15 == nil then
            _G.displayMessage("<Color=Red>No targets")
            return
        end
        v11.depths = true
        _G.canuse = false
        game.ReplicatedStorage.Events.Skill:InvokeServer("Sunken Depths", {
            ["target"] = v15,
            ["startCFrame"] = v12.PrimaryPart.CFrame
        })
        task.wait(0.3)
        _G.canuse = true
        _G.keysetup:cooldown("Sunken Depths", v14)
        _G.fw(v14)
        v11.depths = false
    end
end
function u6.SunkenHook(u16, p17) --[[ Line: 68 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u3
    --]]
    local u18 = u1.Character
    local v19 = u16.Cooldowns
    if v19.reel == false and _G.check:inspect(u18) == true then
        local v20 = u3.GetM("Sunken Hook")
        local v21 = v20.cd
        if _G.StamCheck("Sunken Hook") == false then
            return
        end
        if v20.statreq and _G.MeetReq(v20.statreq) == false then
            return
        end
        local v22 = u18.Humanoid.Animator:LoadAnimation(script.throwCharge)
        v22:Play()
        v22:AdjustWeight(2)
        v19.reel = true
        _G.FaceMouse = true
        _G.canuse = false
        local v23 = game.ReplicatedStorage.Events.Skill:InvokeServer("Sunken Hook")
        local u24 = tick()
        u16:ChargeSkill(p17, {
            ["Key"] = Enum.KeyCode.R,
            ["CheckFunction"] = function() --[[ Name: CheckFunction, Line 95 ]]
                --[[
                Upvalues:
                    [1] = u18
                --]]
                u18.Humanoid.AutoRotate = false
            end,
            ["IgnoreInstantCastSetting"] = true,
            ["EndFunction"] = function() --[[ Name: EndFunction, Line 99 ]]
                --[[
                Upvalues:
                    [1] = u18
                    [2] = u16
                    [3] = u24
                --]]
                return _G.check:inspect(u18) == false and true or (u16.Tool.Parent ~= u18 and true or tick() - u24 >= 4)
            end,
            ["HoldDuration"] = 0.25
        })
        v22:Stop()
        local v25 = u18.Humanoid.Animator:LoadAnimation(script.throwAnim)
        v25:Play()
        v25:AdjustWeight(2)
        task.wait(0.175)
        _G.FaceMouse = false
        u18.HumanoidRootPart.Anchored = true
        u18.Humanoid.AutoRotate = false
        u18:PivotTo(CFrame.new(u18.PrimaryPart.Position, u16:GetMousePosition()))
        if v23 then
            v23:InvokeServer(u16:GetMouseCFrame())
        end
        v25:Stop()
        repeat
            task.wait()
        until u18:GetAttribute("SunkenAnchorPulling") == nil
        u18.Humanoid.AutoRotate = true
        u18.HumanoidRootPart.Anchored = false
        u18.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Sunken Hook", v21)
        _G.fw(v21)
        v19.reel = false
    end
end
return u6