 

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
        ["rend"] = false,
        ["sweep"] = false
    }
    return v9
end
u6["ShadowExtraction/ScissorImpale"] = function(u10, p11) --[[ Line: 28 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v12 = u10.Cooldowns
    local u13 = u1.Character
    local v14 = u2["Stats" .. u1.Name]
    if v12.rend == false and _G.check:inspect(u13) == true then
        local v15 = u3.GetM("Shadow Extraction/Scissor Impale")
        local v16 = v15.cd
        if _G.StamCheck("Shadow Extraction/Scissor Impale") == false then
            return
        end
        if v15.statreq and _G.MeetReq(v15.statreq) == false then
            return
        end
        local u17 = u13.Humanoid.Animator:LoadAnimation(script.grab2)
        if v14.Stats.DF.Value == "Kage-Kage" then
            u17 = u13.Humanoid.Animator:LoadAnimation(script.grab)
        end
        u17:Play()
        u17:AdjustWeight(2)
        v12.rend = true
        _G.canuse = false
        local v18 = game.ReplicatedStorage.Events.Skill:InvokeServer("Shadow Extraction/Scissor Impale")
        _G.PauseAnim(u17, 0.35, 1)
        local u19 = tick()
        local function v20() --[[ Line: 61 ]]
            --[[
            Upvalues:
                [1] = u10
                [2] = u1
                [3] = u19
                [4] = u13
                [5] = u17
            --]]
            if not u10:_findTool(u1.Character) or (tick() - u19 >= 10 or _G.check:inspect(u13) == false) then
                u17:Stop()
                return true
            end
        end
        u10:ChargeSkill(p11, {
            ["Key"] = Enum.KeyCode.R,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 56 ]]
                --[[
                Upvalues:
                    [1] = u13
                --]]
                u13.Humanoid.WalkSpeed = 4
                _G.canuse = false
            end,
            ["EndFunction"] = v20
        })
        u17:AdjustSpeed(1)
        task.wait(0.1)
        if v18 then
            v18:FireServer(u13.HumanoidRootPart.CFrame)
        end
        u13.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Shadow Extraction/Scissor Impale", v16)
        _G.fw(v16)
        v12.rend = false
    end
end
function u6.BladeWhirl(p21, _) --[[ Line: 88 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v22 = p21.Cooldowns
    local v23 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v22.sweep == false and _G.check:inspect(v23) == true then
        local v24 = u3.GetM("Blade Whirl")
        local v25 = v24.cd
        if _G.StamCheck("Blade Whirl") == false then
            return
        end
        if v24.statreq and _G.MeetReq(v24.statreq) == false then
            return
        end
        local v26 = v23.Humanoid.Animator:LoadAnimation(script.throw)
        v26:Play()
        v26:AdjustWeight(2)
        v26:AdjustSpeed(1)
        _G.canuse = false
        local v27 = v23:FindFirstChild("Moria\'s ScissorsSword")
        if v27 then
            local v28 = v27.AnimationController:LoadAnimation(script.throw)
            v28:Play()
            v28:AdjustWeight(2)
            v28:AdjustSpeed(1)
        end
        game.ReplicatedStorage.Events.Skill:InvokeServer("Blade Whirl")
        v22.sweep = true
        _G.canuse = false
        task.wait(0.4)
        v23.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Blade Whirl", v25)
        _G.fw(v25)
        v22.sweep = false
    end
end
return u6