 

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
        [3] = u1
    --]]
    local v7 = u4.new(script.Name)
    local v8 = u6
    local v9 = setmetatable(v7, v8)
    game.ReplicatedStorage:FindFirstChild("Stats" .. u1.Name)
    v9.Cooldowns = {
        ["Gut Punch"] = false,
        ["Ground Smash"] = false
    }
    return v9
end
function u6.GroundSmash(p10, p11) --[[ Line: 42 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v12 = p10.Cooldowns
    local u13 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    game.ReplicatedStorage:WaitForChild("CombatAnimations", 1)
    if u13:FindFirstChild("Melee") and (v12["Ground Smash"] == false and (_G.canuse == true and (_G.check:inspect(u13) == true and _G.StamCheck("Ground Smash") == true))) then
        local v14 = u3.GetM("Ground Smash")
        local v15 = v14.cd
        if v14.statreq and _G.MeetReq(v14.statreq) == false then
            return
        end
        v12["Ground Smash"] = true
        _G.canuse = false
        local u16 = tick()
        local v17 = u13.Humanoid:LoadAnimation(script.charge)
        v17:Play()
        v17.Priority = Enum.AnimationPriority.Action
        v17:AdjustWeight(2)
        u13.Humanoid.WalkSpeed = 2
        local v18 = game.ReplicatedStorage.Events.Skill:InvokeServer("Ground Smash")
        _G.PauseAnim(v17, 0.5, 1)
        p10:ChargeSkill(p11, {
            ["Key"] = Enum.KeyCode.R,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 69 ]]
                --[[
                Upvalues:
                    [1] = u13
                    [2] = u16
                --]]
                if _G.check:inspect(u13) == false or tick() - u16 >= 3 then
                    return true
                end
                u13.Humanoid.WalkSpeed = 2
            end
        })
        v17:Stop()
        u13.Humanoid:LoadAnimation(script.slam):Play()
        if v18 then
            v18:FireServer(u13.PrimaryPart.CFrame * CFrame.new(0, 0, -2))
        end
        task.wait(0.25)
        _G.canuse = true
        u13.Humanoid.WalkSpeed = 16
        _G.keysetup:cooldown("Ground Smash", v15)
        task.wait(v15)
        v12["Ground Smash"] = false
    end
end
function u6.GutPunch(p19, p20) --[[ Line: 99 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v21 = p19.Cooldowns
    local u22 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    local v23 = game.ReplicatedStorage:WaitForChild("CombatAnimations", 1)
    if u22:FindFirstChild("Melee") and (v21["Gut Punch"] == false and (_G.canuse == true and (_G.check:inspect(u22) == true and _G.StamCheck("Gut Punch") == true))) then
        local v24 = u3.GetM("Gut Punch")
        local v25 = v24.cd
        if v24.statreq and _G.MeetReq(v24.statreq) == false then
            return
        end
        v21["Gut Punch"] = true
        _G.canuse = false
        game.ReplicatedStorage.Events.StamRequest:InvokeServer("Gut Punch")
        game:GetService("HttpService"):GenerateGUID(true)
        local u26 = tick()
        local u27 = u22.Humanoid:LoadAnimation(v23.Melee.GutPunch)
        u27:Play()
        u27.Priority = Enum.AnimationPriority.Action
        u27:AdjustSpeed(3)
        u27:AdjustWeight(2)
        u22.Humanoid.WalkSpeed = 5
        _G.PauseAnim(u27, 0.5, 3)
        game.ReplicatedStorage.Util.Melee.Ace_sound:Play()
        p19:ChargeSkill(p20, {
            ["Key"] = Enum.KeyCode.E,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 140 ]]
                --[[
                Upvalues:
                    [1] = u22
                    [2] = u26
                --]]
                if _G.check:inspect(u22) == false or tick() - u26 >= 2 then
                    return true
                end
                u22.Humanoid.WalkSpeed = 5
            end
        })
        game.ReplicatedStorage.Util.Melee.Ace_sound:Stop()
        u27:AdjustSpeed(3)
        local _ = u22.RightHand
        local u28 = nil
        local u29 = false
        local function v31(p30) --[[ Line: 159 ]]
            --[[
            Upvalues:
                [1] = u28
            --]]
            u28 = true
            game.ReplicatedStorage.Events.Skill:InvokeServer("Gut Punch", {
                ["Target"] = p30.Parent
            })
        end
        local function v32() --[[ Line: 164 ]]
            --[[
            Upvalues:
                [1] = u29
                [2] = u27
            --]]
            u29 = true
            u27:Stop()
        end
        task.spawn(function() --[[ Line: 169 ]]
            game.ReplicatedStorage.Events.CombatRegister:InvokeServer({ "swingsfx", "Melee", true })
        end)
        _G.hitbox:start(u22, Vector3.new(5, 5, 5), 0.3, CFrame.new(0, 0, -1), v31, v32)
        tick()
        _G.canuse = true
        u22.Humanoid.WalkSpeed = 16
        u22.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
        _G.keysetup:cooldown("Gut Punch", v25)
        task.wait(v25)
        v21["Gut Punch"] = false
    end
end
return u6