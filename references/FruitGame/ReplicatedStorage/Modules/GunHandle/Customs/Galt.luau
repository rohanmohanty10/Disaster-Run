 

local v1 = {}
local u2 = require(game.ReplicatedStorage.Modules.GunHandle)
function v1.Rev(_, p3, p4, p5) --[[ Line: 3 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    if p3 ~= nil then
        local v6 = p3.Parent
        p3:WaitForChild("AnimationController", 2)
        p3.AnimationController:WaitForChild("Animator", 2)
        if p5.FireAnims == nil then
            p5.FireAnims = {
                ["hum"] = v6.Humanoid:LoadAnimation(script.Parent.Parent.Guns.Galt.Fire1),
                ["gunA"] = p3.AnimationController:LoadAnimation(script.Parent.Parent.Guns.Galt.Fire2)
            }
        end
        if p5.GunModel == nil then
            p5.GunModel = p3
        end
        if p5.GunModel ~= p3 then
            if p5.tween then
                p5.tween:Cancel()
                p5.tween = nil
            end
            if p5.FireAnims then
                p5.FireAnims.gunA = p3.AnimationController:LoadAnimation(script.Parent.Parent.Guns.Galt.Fire2)
            end
            p5.GunModel = p3
        end
        if p5.tween == nil then
            local v7 = TweenInfo.new(4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0)
            p5.tween = game:GetService("TweenService"):Create(p3.Base.MiddleBarrel, v7, {
                ["MaxVelocity"] = 0
            })
        end
        if p5.StartRev ~= nil and p5.StartRev >= u2:getRevsAm()[p5.Name] then
            p5.Reloaded = false
            script.NOAMMO:Play()
            _G.TurnCharacterToMouse = false
            p4 = false
        end
        if p4 == true then
            if p5.tween.PlaybackState == Enum.PlaybackState.Playing then
                p5.tween:Cancel()
            end
            local _ = p3.Base.MiddleBarrel.MaxVelocity
            if p5.FireAnims.hum.IsPlaying == false then
                game.ReplicatedStorage.Events.GunManager:FireServer("rev", {
                    ["Gun"] = p5.Name
                })
                p5.FireAnims.hum:Play()
            end
            if p5.FireAnims.gunA.IsPlaying == false then
                p5.FireAnims.gunA:Play()
            end
            p3.Base.MiddleBarrel.MaxVelocity = p3.Base.MiddleBarrel.MaxVelocity + 0.002
            local v8 = 2 + p3.Base.MiddleBarrel.MaxVelocity
            p5.FireAnims.hum:AdjustSpeed(v8)
            p5.FireAnims.gunA:AdjustSpeed(v8)
            if p3.Base.MiddleBarrel.MaxVelocity >= 0.075 then
                if p5.StartRev == nil then
                    p5.StartRev = 0
                end
                p5.StartRev = p5.StartRev + 1
                if p3.Hole.loop.IsPlaying == false then
                    p3.Hole.loop:Play()
                end
                game.ReplicatedStorage.Events.GunManager:FireServer("fire", {
                    ["Gun"] = script.Name,
                    ["Position"] = _G.MouseCF.p,
                    ["Start"] = p3.Hole.CFrame,
                    ["go"] = true
                })
                return
            end
        else
            game.ReplicatedStorage.Events.GunManager:FireServer("unrev", {
                ["Gun"] = script.Name
            })
            if p3.Hole.loop.IsPlaying == true then
                p3.Hole.loop:Stop()
            end
            if p5.FireAnims.hum.IsPlaying == true then
                p5.FireAnims.hum:Stop()
            end
            if p5.FireAnims.gunA.IsPlaying == true then
                p5.FireAnims.gunA:Stop()
            end
            if p5.Reloaded == false then
                p5.Anims.aimHold:Stop()
                p5.Anims.aim:Stop()
                p5.IsAiming = false
            end
            if p5.tween.PlaybackState ~= Enum.PlaybackState.Playing then
                p5.tween:Play()
            end
        end
    end
end
function v1.Reload(_, u9, p10, u11) --[[ Line: 89 ]]
    local u12 = u9:FindFirstChild(p10 .. "Gun")
    if u12 then
        local u13 = u9.Humanoid:LoadAnimation(script.Reload1)
        u13:Play()
        local u14 = u12.AnimationController:LoadAnimation(script.Reload2)
        u14:Play()
        task.spawn(function() --[[ Line: 96 ]]
            --[[
            Upvalues:
                [1] = u12
                [2] = u9
                [3] = u13
                [4] = u14
                [5] = u11
            --]]
            while true do
                task.wait()
                if u12.Parent ~= u9 then
                    u13:Stop()
                    u14:Stop()
                end
                u11.Ready = false
                if u14.IsPlaying == false then
                    u11.Ready = true
                    return
                end
            end
        end)
    end
end
return v1