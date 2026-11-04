 

local v1 = {}
local u2 = Random.new()
local u3 = require(game.ReplicatedStorage.Modules.Client.WeaponVFXRecolor)
function v1.start(_, p4, p5, p6) --[[ Line: 5 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u2
    --]]
    if _G.checkRenderDistance(p4.Position) then
        if p4 then
            p4 = p4:FindFirstChildWhichIsA("Attachment")
        end
        local v7 = script.MochiThing:Clone()
        if p6 then
            u3.apply(v7, p6)
        end
        v7.Size = Vector3.new()
        v7.RigidConstraint.Attachment1 = p4
        local v8 = v7.RigidConstraint.Attachment0
        local v9 = u2:NextNumber(-360, 360)
        local v10 = u2:NextNumber(-360, 360)
        local v11 = u2
        v8.Orientation = Vector3.new(v9, v10, v11:NextNumber(-360, 360))
        v7.Parent = workspace.Effects
        v7.hold:Play()
        _G.PlaySound(v7.CFrame, script.MochiHandBubble, {
            ["RandomPitch"] = true
        })
        _G.tween(v7, {
            0.5,
            "Quad",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Size"] = Vector3.new(2, 2, 2)
        })
        local v12 = v7.AnimationController
        local v13 = v12.Animator:LoadAnimation(v12.Animation)
        v13:Play()
        v13.Looped = true
        v13:AdjustSpeed(10)
        repeat
            task.wait()
        until p5 == nil or p5:IsDescendantOf(game) == false
        _G.tween(v7.hold, {
            0.5,
            "Quad",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Volume"] = 0
        })
        _G.tween(v7, {
            0.25,
            "Quad",
            Enum.EasingDirection.In,
            0,
            false,
            0
        }, {
            ["Size"] = Vector3.new(),
            ["Transparency"] = 1
        })
        _G.destroy(v7, 0.5)
    end
end
return v1