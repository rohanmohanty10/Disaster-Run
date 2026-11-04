 

local v1 = {}
local _ = _G.clientimpacts[game.ReplicatedStorage.ClientImpacts.Sparks]
local _ = _G.clientimpacts[game.ReplicatedStorage.ClientImpacts.RockDebs]
function v1.start(_, p2) --[[ Line: 6 ]]
    local v3 = p2.obj
    local v4 = p2.cf
    local u5 = p2.hit
    if _G.checkRenderDistance(v4.p) ~= false then
        v3.Transparency = 1
        v3.Attachment.ParticleEmitter.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0, 0), NumberSequenceKeypoint.new(0.5, 2, 1.5), NumberSequenceKeypoint.new(1, 0, 0) })
        v3.Attachment.ParticleEmitter:Emit(15)
        local u6 = nil
        pcall(function() --[[ Line: 18 ]]
            --[[
            Upvalues:
                [1] = u5
                [2] = u6
            --]]
            if u5 and u5.Parent:FindFirstChild("Humanoid") or (u5.Parent.Parent:FindFirstChild("Humanoid") or u5.Parent.Parent.Parent:FindFirstChild("Humanoid")) then
                u6 = true
            end
        end)
        if u5 and u6 == nil then
            v3.Attachment.Smoke.Color = ColorSequence.new(u5.Color)
            v3.Attachment.Smoke:Emit(25)
            local v7, v8, v9 = Color3.toHSV(u5.Color)
            local v10 = Color3.fromHSV(v7, v8, v9 * 0.75)
            v3.Attachment.rock.Color = ColorSequence.new(v10)
            v3.Attachment.rock:Emit(25)
        elseif u6 then
            v3.Attachment2.WorldPosition = u5.Position
            v3.Attachment2.Blood:Emit(25)
        end
        local v11 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0)
        game:GetService("TweenService"):Create(v3.PointLight, v11, {
            ["Range"] = 0,
            ["Brightness"] = 2
        }):Play()
        v3.Attachment.ParticleEmitter2.Acceleration = v4.rightVector * -300
        v3.Attachment.ParticleEmitter3.Acceleration = v4.rightVector * -300
        v3.Attachment.ParticleEmitter2:Emit(25)
        v3.Attachment.ParticleEmitter3:Emit(25)
        v3.Parent = workspace.Effects
    end
end
return v1