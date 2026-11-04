 

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
        ["heal"] = false,
        ["freeze"] = false
    }
    return v9
end
function u6.SoulParade(p10, _) --[[ Line: 28 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v11 = p10.Cooldowns
    local v12 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v11.heal == false and _G.check:inspect(v12) == true then
        local v13 = u3.GetM("Soul Parade")
        local v14 = v13.cd
        if _G.StamCheck("Soul Parade") == false then
            return
        end
        if v13.statreq and _G.MeetReq(v13.statreq) == false then
            return
        end
        _G.canuse = false
        v11.heal = true
        local v15 = v12.Humanoid.Animator:LoadAnimation(script.counter)
        v15:Play()
        game.ReplicatedStorage.Events.Skill:InvokeServer("Soul Parade")
        task.wait(0.45)
        v15:Stop()
        task.wait(0.6)
        _G.canuse = true
        _G.keysetup:cooldown("Soul Parade", v14)
        _G.fw(v14)
        v11.heal = false
    end
end
function u6.DrawingSong(p16, p17) --[[ Line: 58 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v18 = p16.Cooldowns
    local u19 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v18.freeze == false and _G.check:inspect(u19) == true then
        local v20 = u3.GetM("Drawing Song")
        local v21 = v20.cd
        if _G.StamCheck("Drawing Song") == false then
            return
        end
        if v20.statreq and _G.MeetReq(v20.statreq) == false then
            return
        end
        _G.canuse = false
        local v22 = u19.Humanoid.Animator:LoadAnimation(script.freeze)
        v22:Play()
        v22:AdjustWeight(2)
        u19.Humanoid.WalkSpeed = 4
        _G.FaceMouse = true
        local v23 = game.ReplicatedStorage.Events.Skill:InvokeServer("Drawing Song")
        _G.PauseAnim(v22, 0.67, 1.3)
        v18.freeze = true
        local v24 = u19.PrimaryPart.CFrame
        p16:ChargeSkill(p17, {
            ["Key"] = Enum.KeyCode.R,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 82 ]] end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 86 ]]
                --[[
                Upvalues:
                    [1] = u19
                --]]
                if u19:FindFirstChild(script.Name) == nil then
                    return true
                end
            end
        })
        _G.FaceMouse = false
        u19.HumanoidRootPart.Anchored = true
        v22:AdjustSpeed(1)
        local v25 = Ray.new(u19.HumanoidRootPart.CFrame.Position, (p16:GetMouseCFrame().Position - u19.HumanoidRootPart.CFrame.Position).unit * 45)
        local _, v26 = _G.raycastWhitelist(v25, { workspace.Islands, workspace.Ships, workspace.Env })
        local v27 = u19.HumanoidRootPart.CFrame
        local v28 = CFrame.new(v26, v27.Position) * CFrame.Angles(0, 3.141592653589793, 0) * CFrame.new(0, u19.Humanoid.HipHeight * 1.25, 2)
        u19.HumanoidRootPart.CFrame = v28
        if v23 then
            v23:FireServer({
                ["cf"] = u19.PrimaryPart.CFrame,
                ["old"] = v24
            })
        end
        task.wait(0.9)
        u19.HumanoidRootPart.Anchored = false
        u19.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Drawing Song", v21)
        _G.fw(v21)
        v18.freeze = false
    end
end
return u6