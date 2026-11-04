 

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
        ["flash"] = false
    }
    return v9
end
function u6.FireworkRocket(p10, _) --[[ Line: 55 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v11 = p10.Cooldowns
    local u12 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v11.slash == false and _G.check:inspect(u12) == true then
        local v13 = u3.GetM("Firework Rocket")
        local v14 = v13.cd
        if _G.StamCheck("Firework Rocket") == false then
            return
        end
        if v13.statreq and _G.MeetReq(v13.statreq) == false then
            return
        end
        local v15 = u12:FindFirstChild(script.Name .. "Sword") or u12:FindFirstChild("Prestige " .. script.Name .. "Sword") or nil
        if v15 == nil then
            return
        end
        v11.slash = true
        _G.canuse = false
        local v16 = u12.Humanoid:LoadAnimation(script.shoot)
        v16:Play(0)
        v16.Priority = Enum.AnimationPriority.Action4
        v16:AdjustWeight(5)
        u12.PrimaryPart.Anchored = true
        local v17 = p10:GetMouseCFrame()
        u12:SetPrimaryPartCFrame(CFrame.new(u12.PrimaryPart.Position, v17.Position))
        task.wait(0.05)
        local v18
        if v15 and v15:FindFirstChild("Blade") then
            v18 = v15.Blade.BackSmoke.WorldCFrame
        else
            v18 = u12.PrimaryPart.CFrame
        end
        game.ReplicatedStorage.Events.Skill:InvokeServer("Firework Rocket", {
            ["mouseCF"] = v17,
            ["startCF"] = v18,
            ["charCF"] = u12.PrimaryPart.CFrame
        })
        task.spawn(function() --[[ Line: 29 ]]
            --[[
            Upvalues:
                [1] = u12
            --]]
            local v19 = u12.HumanoidRootPart.CFrame
            local _, v20 = _G.raycast:cast(u12.HumanoidRootPart.CFrame.Position, u12.HumanoidRootPart.CFrame.LookVector * -10, { workspace.Islands, workspace.Ships, workspace.Env })
            local v21 = (v19.Position - v20).Magnitude
            if v21 > 1 then
                v21 = v21 - 1
            end
            _G.tween(u12.HumanoidRootPart, {
                0.15,
                "Sine",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["CFrame"] = u12.HumanoidRootPart.CFrame * CFrame.new(0, 0, v21)
            })
        end)
        task.wait(0.25)
        u12.PrimaryPart.Anchored = false
        u12.Humanoid.AutoRotate = true
        u12.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Firework Rocket", v14)
        _G.fw(v14)
        v11.slash = false
    end
end
function u6.SkyhighFireworkRocket(p22, _) --[[ Line: 108 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v23 = p22.Cooldowns
    local u24 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v23.flash == false and _G.check:inspect(u24) == true then
        local v25 = u3.GetM("Skyhigh Firework Rocket")
        local v26 = v25.cd
        if _G.StamCheck("Skyhigh Firework Rocket") == false then
            return
        end
        if v25.statreq and _G.MeetReq(v25.statreq) == false then
            return
        end
        local v27 = u24:FindFirstChild(script.Name .. "Sword") or u24:FindFirstChild("Prestige " .. script.Name .. "Sword") or nil
        if v27 == nil then
            return
        end
        v23.flash = true
        _G.canuse = false
        local v28 = u24.Humanoid:LoadAnimation(script.shoot)
        v28:Play(0)
        v28.Priority = Enum.AnimationPriority.Action4
        v28:AdjustWeight(5)
        u24.PrimaryPart.Anchored = true
        local v29 = p22:GetMouseCFrame()
        u24:SetPrimaryPartCFrame(CFrame.new(u24.PrimaryPart.Position, v29.Position))
        task.wait(0.05)
        local v30
        if v27 and v27:FindFirstChild("Blade") then
            v30 = v27.Blade.BackSmoke.WorldCFrame
        else
            v30 = u24.PrimaryPart.CFrame
        end
        game.ReplicatedStorage.Events.Skill:InvokeServer("Skyhigh Firework Rocket", {
            ["mouseCF"] = v29,
            ["startCF"] = v30,
            ["charCF"] = u24.PrimaryPart.CFrame
        })
        task.spawn(function() --[[ Line: 29 ]]
            --[[
            Upvalues:
                [1] = u24
            --]]
            local v31 = u24.HumanoidRootPart.CFrame
            local _, v32 = _G.raycast:cast(u24.HumanoidRootPart.CFrame.Position, u24.HumanoidRootPart.CFrame.LookVector * -10, { workspace.Islands, workspace.Ships, workspace.Env })
            local v33 = (v31.Position - v32).Magnitude
            if v33 > 1 then
                v33 = v33 - 1
            end
            _G.tween(u24.HumanoidRootPart, {
                0.15,
                "Sine",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["CFrame"] = u24.HumanoidRootPart.CFrame * CFrame.new(0, 0, v33)
            })
        end)
        task.wait(0.25)
        u24.PrimaryPart.Anchored = false
        _G.canuse = true
        _G.keysetup:cooldown("Skyhigh Firework Rocket", v26)
        _G.fw(v26)
        v23.flash = false
    end
end
return u6