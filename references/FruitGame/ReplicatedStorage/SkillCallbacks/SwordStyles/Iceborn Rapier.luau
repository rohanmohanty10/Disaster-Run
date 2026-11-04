 

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
        ["lunge"] = false,
        ["nado"] = false
    }
    return v9
end
function u6.IcebornLunge(p10, p11) --[[ Line: 28 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v12 = p10.Cooldowns
    local u13 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v12.lunge == false and _G.check:inspect(u13) == true then
        local v14 = u3.GetM("Iceborn Lunge")
        local v15 = v14.cd
        if _G.StamCheck("Iceborn Lunge") == false then
            return
        end
        if v14.statreq and _G.MeetReq(v14.statreq) == false then
            return
        end
        local u16 = u13.Humanoid.Animator:LoadAnimation(script.lunge)
        u16:Play()
        u16:AdjustWeight(2)
        v12.lunge = true
        _G.canuse = false
        _G.FaceMouse = true
        local v17 = game.ReplicatedStorage.Events.Skill:InvokeServer("Iceborn Lunge")
        _G.PauseAnim(u16, 0.25, 0.75)
        local u18 = tick()
        p10:ChargeSkill(p11, {
            ["Key"] = Enum.KeyCode.E,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 54 ]]
                --[[
                Upvalues:
                    [1] = u13
                    [2] = u16
                --]]
                if _G.check:inspect(u13) == false then
                    u16:Stop()
                    return true
                end
            end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 61 ]]
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
        u16:AdjustSpeed(1)
        u13.HumanoidRootPart.Anchored = true
        u13.Humanoid.AutoRotate = false
        local v19 = u13.HumanoidRootPart.CFrame
        local _, v20 = _G.raycast:cast(u13.HumanoidRootPart.CFrame.Position, v19.LookVector * 45, { workspace.Islands, workspace.Ships, workspace.Env })
        local v21 = (v19.Position - v20).Magnitude
        local v22 = v19 * CFrame.new(0, 0, -v21) * CFrame.new(0, u13.Humanoid.HipHeight * 1.25, 2)
        _G.FaceMouse = false
        _G.tween(u13.HumanoidRootPart, { 0.4, "Cubic", Enum.EasingDirection.Out }, {
            ["CFrame"] = v22
        })
        if v17 then
            v17:FireServer(v19, v22)
        end
        task.wait(0.7)
        u13.Humanoid.AutoRotate = true
        u13.HumanoidRootPart.Anchored = false
        u13.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Iceborn Lunge", v15)
        _G.fw(v15)
        v12.lunge = false
    end
end
function u6.IcebornShards(p23, _) --[[ Line: 103 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v24 = p23.Cooldowns
    local v25 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v24.nado == false and _G.check:inspect(v25) == true then
        local v26 = u3.GetM("Iceborn Shards")
        local v27 = v26.cd
        if _G.StamCheck("Iceborn Shards") == false then
            return
        end
        if v26.statreq and _G.MeetReq(v26.statreq) == false then
            return
        end
        local v28 = v25.Humanoid.Animator:LoadAnimation(script.shoot)
        v28:Play()
        v28:AdjustWeight(2)
        v24.nado = true
        _G.canuse = false
        _G.FaceMouse = true
        v25.Humanoid.WalkSpeed = 4
        local v29 = game.ReplicatedStorage.Events.Skill:InvokeServer("Iceborn Shards")
        local v30 = {
            [0] = 0,
            [1] = 0.38,
            [2] = 0.62,
            [3] = 0.9
        }
        for v31 = 1, 3 do
            task.wait(v30[v31] - v30[v31 - 1])
            if not v29 or _G.check:inspect(v25) ~= true then
                if v29 then
                    v29:FireServer("end")
                end
                break
            end
            v29:FireServer({
                ["hrpCF"] = v25.PrimaryPart.CFrame,
                ["targetCF"] = p23:GetMouseCFrame()
            })
        end
        _G.FaceMouse = false
        v25.HumanoidRootPart.Anchored = true
        task.wait(0.4)
        v25.HumanoidRootPart.Anchored = false
        v25.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Iceborn Shards", v27)
        _G.fw(v27)
        v24.nado = false
    end
end
return u6